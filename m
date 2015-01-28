Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Perform a power cycle when receiving hardware error event
Date: Wed, 28 Jan 2015 11:09:55 -0800
Message-Id: <1422472196-9595-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When receiving a HCI Hardware Error event, the controller should be
assumed to be non-functional until issuing a HCI Reset command.

The Bluetooth hardware errors are vendor specific and so add a
new hdev->hw_error callback that drivers can provide to run extra
code to handle the hardware error.

After completing the vendor specific error handling perform a full
reset of the Bluetooth stack by closing and re-opening the transport.

Based-on-patch-by: Johan Hedberg <johan.hedberg@intel.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  3 +++
 net/bluetooth/hci_core.c         | 21 +++++++++++++++++++++
 net/bluetooth/hci_event.c        |  4 +++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 0f5e59f1e3cb..1780f1681ecf 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -232,6 +232,7 @@ struct hci_dev {
 	__u16		conn_info_min_age;
 	__u16		conn_info_max_age;
 	__u8		ssp_debug_mode;
+	__u8		hw_error_code;
 	__u32		clock;
 
 	__u16		devid_source;
@@ -293,6 +294,7 @@ struct hci_dev {
 
 	struct work_struct	power_on;
 	struct delayed_work	power_off;
+	struct work_struct	error_reset;
 
 	__u16			discov_timeout;
 	struct delayed_work	discov_off;
@@ -369,6 +371,7 @@ struct hci_dev {
 	int (*setup)(struct hci_dev *hdev);
 	int (*send)(struct hci_dev *hdev, struct sk_buff *skb);
 	void (*notify)(struct hci_dev *hdev, unsigned int evt);
+	void (*hw_error)(struct hci_dev *hdev, u8 code);
 	int (*set_bdaddr)(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 };
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 46aa702c189d..0f98d9057ae7 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2140,6 +2140,26 @@ static void hci_power_off(struct work_struct *work)
 	smp_unregister(hdev);
 }
 
+static void hci_error_reset(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev, error_reset);
+
+	BT_DBG("%s", hdev->name);
+
+	if (hdev->hw_error)
+		hdev->hw_error(hdev, hdev->hw_error_code);
+	else
+		BT_ERR("%s hardware error 0x%2.2x", hdev->name,
+		       hdev->hw_error_code);
+
+	if (hci_dev_do_close(hdev))
+		return;
+
+	smp_unregister(hdev);
+
+	hci_dev_do_open(hdev);
+}
+
 static void hci_discov_off(struct work_struct *work)
 {
 	struct hci_dev *hdev;
@@ -2932,6 +2952,7 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_WORK(&hdev->cmd_work, hci_cmd_work);
 	INIT_WORK(&hdev->tx_work, hci_tx_work);
 	INIT_WORK(&hdev->power_on, hci_power_on);
+	INIT_WORK(&hdev->error_reset, hci_error_reset);
 
 	INIT_DELAYED_WORK(&hdev->power_off, hci_power_off);
 	INIT_DELAYED_WORK(&hdev->discov_off, hci_discov_off);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4175470ff48e..a72a5f50728d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3100,7 +3100,9 @@ static void hci_hardware_error_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_hardware_error *ev = (void *) skb->data;
 
-	BT_ERR("%s hardware error 0x%2.2x", hdev->name, ev->code);
+	hdev->hw_error_code = ev->code;
+
+	queue_work(hdev->req_workqueue, &hdev->error_reset);
 }
 
 static void hci_role_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
-- 
2.1.0

