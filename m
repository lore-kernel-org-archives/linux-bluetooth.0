Return-Path: <cyrus@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH 2/2] Bluetooth: hci_intel: Introduce LPM support
Date: Sat, 29 Aug 2015 13:38:19 +0200
Message-Id: <1440848299-856-2-git-send-email-loic.poulain@intel.com>
In-Reply-To: <1440848299-856-1-git-send-email-loic.poulain@intel.com>
References: <1440848299-856-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Enable controller Low-Power-Mode if we have a pdev to manage host
wake-up. Once LPM is enabled, controller notifies its TX status via
a vendor specific packet (tx_idle/tx_active).
tx_active means that there is more data upcoming from controller.
tx_idle means that controller can be put in suspended state.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 v2: coding style, spin_lock restructuring
 v3: rebase

 drivers/bluetooth/hci_intel.c | 95 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 1ec2205..30dce61 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -44,6 +44,20 @@
 #define STATE_FIRMWARE_LOADED	2
 #define STATE_FIRMWARE_FAILED	3
 #define STATE_BOOTING		4
+#define STATE_LPM_ENABLED	5
+#define STATE_TX_ACTIVE		6
+
+#define HCI_LPM_PKT 0xf1
+#define HCI_LPM_MAX_SIZE 10
+#define HCI_LPM_HDR_SIZE HCI_EVENT_HDR_SIZE
+
+#define LPM_OP_TX_NOTIFY 0x00
+
+struct hci_lpm_pkt {
+	__u8 opcode;
+	__u8 dlen;
+	__u8 data[0];
+} __packed;
 
 struct intel_device {
 	struct list_head list;
@@ -316,11 +330,14 @@ static int intel_setup(struct hci_uart *hu)
 {
 	static const u8 reset_param[] = { 0x00, 0x01, 0x00, 0x01,
 					  0x00, 0x08, 0x04, 0x00 };
+	static const u8 lpm_param[] = { 0x03, 0x07, 0x01, 0x0b };
 	struct intel_data *intel = hu->priv;
+	struct intel_device *idev = NULL;
 	struct hci_dev *hdev = hu->hdev;
 	struct sk_buff *skb;
 	struct intel_version *ver;
 	struct intel_boot_params *params;
+	struct list_head *p;
 	const struct firmware *fw;
 	const u8 *fw_ptr;
 	char fwname[64];
@@ -680,6 +697,37 @@ done:
 
 	BT_INFO("%s: Device booted in %llu usecs", hdev->name, duration);
 
+	/* Enable LPM if matching pdev with wakeup enabled */
+	spin_lock(&intel_device_list_lock);
+	list_for_each(p, &intel_device_list) {
+		struct intel_device *dev = list_entry(p, struct intel_device,
+						      list);
+		if (hu->tty->dev->parent != dev->pdev->dev.parent)
+			continue;
+
+		if (device_may_wakeup(&dev->pdev->dev))
+			idev = dev;
+
+		break;
+	}
+	spin_unlock(&intel_device_list_lock);
+
+	if (!idev)
+		goto no_lpm;
+
+	BT_INFO("%s: Enabling LPM", hdev->name);
+
+	skb = __hci_cmd_sync(hdev, 0xfc8b, sizeof(lpm_param), lpm_param,
+			     HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s: Failed to enable LPM", hdev->name);
+		goto no_lpm;
+	}
+	kfree_skb(skb);
+
+	set_bit(STATE_LPM_ENABLED, &intel->flags);
+
+no_lpm:
 	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_CMD_TIMEOUT);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
@@ -740,10 +788,51 @@ recv:
 	return hci_recv_frame(hdev, skb);
 }
 
+static void intel_recv_lpm_notify(struct hci_dev *hdev, int value)
+{
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+	struct intel_data *intel = hu->priv;
+
+	BT_DBG("%s: TX idle notification (%d)", hdev->name, value);
+
+	if (value)
+		set_bit(STATE_TX_ACTIVE, &intel->flags);
+	else
+		clear_bit(STATE_TX_ACTIVE, &intel->flags);
+}
+
+static int intel_recv_lpm(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_lpm_pkt *lpm = (void *)skb->data;
+
+	switch (lpm->opcode) {
+	case LPM_OP_TX_NOTIFY:
+		if (lpm->dlen)
+			intel_recv_lpm_notify(hdev, lpm->data[0]);
+		break;
+	default:
+		BT_ERR("%s: unknown LPM opcode (%02x)", hdev->name,
+		       lpm->opcode);
+		break;
+	}
+
+	kfree_skb(skb);
+
+	return 0;
+}
+
+#define INTEL_RECV_LPM \
+	.type = HCI_LPM_PKT, \
+	.hlen = HCI_LPM_HDR_SIZE, \
+	.loff = 1, \
+	.lsize = 1, \
+	.maxlen = HCI_LPM_MAX_SIZE
+
 static const struct h4_recv_pkt intel_recv_pkts[] = {
-	{ H4_RECV_ACL,   .recv = hci_recv_frame },
-	{ H4_RECV_SCO,   .recv = hci_recv_frame },
-	{ H4_RECV_EVENT, .recv = intel_recv_event },
+	{ H4_RECV_ACL,    .recv = hci_recv_frame },
+	{ H4_RECV_SCO,    .recv = hci_recv_frame },
+	{ H4_RECV_EVENT,  .recv = intel_recv_event },
+	{ INTEL_RECV_LPM, .recv = intel_recv_lpm },
 };
 
 static int intel_recv(struct hci_uart *hu, const void *data, int count)
-- 
1.9.1
