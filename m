Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: hci_uart: Add Atheros support for address configuration
Date: Sat, 11 Apr 2015 05:35:38 -0700
Message-Id: <1428755738-22030-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Atheros support for missing the support for configuration of the
Bluetooth public address. Add support for the vendor specific command.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_ath.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
index 42f13d0b437f..ec8fa0e0f036 100644
--- a/drivers/bluetooth/hci_ath.c
+++ b/drivers/bluetooth/hci_ath.c
@@ -144,6 +144,39 @@ static int ath_flush(struct hci_uart *hu)
 	return 0;
 }
 
+static int ath_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
+{
+	struct sk_buff *skb;
+	u8 buf[10];
+	int err;
+
+	buf[0] = 0x01;
+	buf[1] = 0x01;
+	buf[2] = 0x00;
+	buf[3] = sizeof(bdaddr_t);
+	memcpy(buf + 4, bdaddr, sizeof(bdaddr_t));
+
+	skb = __hci_cmd_sync(hdev, 0xfc0b, sizeof(buf), buf, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		BT_ERR("%s: Change address command failed (%d)",
+		       hdev->name, err);
+		return err;
+	}
+	kfree_skb(skb);
+
+	return 0;
+}
+
+static int ath_setup(struct hci_uart *hu)
+{
+	BT_DBG("hu %p", hu);
+
+	hu->hdev->set_bdaddr = ath_set_bdaddr;
+
+	return 0;
+}
+
 static const struct h4_recv_pkt ath_recv_pkts[] = {
 	{ H4_RECV_ACL,   .recv = hci_recv_frame },
 	{ H4_RECV_SCO,   .recv = hci_recv_frame },
@@ -212,6 +245,7 @@ static const struct hci_uart_proto athp = {
 	.open		= ath_open,
 	.close		= ath_close,
 	.flush		= ath_flush,
+	.setup		= ath_setup,
 	.recv		= ath_recv,
 	.enqueue	= ath_enqueue,
 	.dequeue	= ath_dequeue,
-- 
2.1.0

