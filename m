Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 16/16] Bluetooth: Support BR/EDR/LE discovery procedure
Date: Fri,  9 Sep 2011 18:56:31 -0300
Message-Id: <1315605391-2407-17-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1315605391-2407-1-git-send-email-andre.guedes@openbossa.org>
References: <1315605391-2407-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for BR/EDR/LE discovery procedure through
management interface.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    2 +
 net/bluetooth/hci_event.c        |   16 ++++++++++---
 net/bluetooth/mgmt.c             |   42 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e23b646..3ec218e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -882,6 +882,8 @@ int mgmt_device_blocked(u16 index, bdaddr_t *bdaddr);
 int mgmt_device_unblocked(u16 index, bdaddr_t *bdaddr);
 int mgmt_discovery_complete(u16 index, u8 status);
 int mgmt_has_pending_stop_discov(u16 index);
+int mgmt_interleaved_discovery(u16 index);
+int mgmt_is_interleaved_discovery(u16 index);
 
 /* HCI info for socket */
 #define hci_pi(sk) ((struct hci_pinfo *) sk)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index fc49f3b..e081a4c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -896,12 +896,17 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 	if (cp->enable == 0x01) {
 		if (status) {
 			mgmt_discovery_complete(hdev->id, status);
+
+			if (mgmt_is_interleaved_discovery(hdev->id))
+				mgmt_discovering(hdev->id, 0);
+
 			return;
 		}
 
 		set_bit(HCI_LE_SCAN, &hdev->flags);
 
-		mgmt_discovering(hdev->id, 1);
+		if (!mgmt_is_interleaved_discovery(hdev->id))
+			mgmt_discovering(hdev->id, 1);
 
 		del_timer(&hdev->adv_timer);
 
@@ -1357,6 +1362,7 @@ static void hci_cs_le_start_enc(struct hci_dev *hdev, u8 status)
 static inline void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
+	int err;
 
 	BT_DBG("%s status %d", hdev->name, status);
 
@@ -1367,9 +1373,11 @@ static inline void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff
 	if (!test_and_clear_bit(HCI_INQUIRY, &hdev->flags))
 		return;
 
-	mgmt_discovery_complete(hdev->id, 0);
-
-	mgmt_discovering(hdev->id, 0);
+	err = mgmt_interleaved_discovery(hdev->id);
+	if (err < 0) {
+		mgmt_discovery_complete(hdev->id, 0);
+		mgmt_discovering(hdev->id, 0);
+	}
 }
 
 static inline void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e6fe04c..ea56d30 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -40,7 +40,9 @@
 #define LE_SCAN_WIN 0x12
 #define LE_SCAN_INT 0x12
 #define LE_SCAN_TIMEOUT_LE_ONLY 10240 /* TGAP(gen_disc_scan_min) */
+#define LE_SCAN_TIMEOUT_BREDR_LE 5120 /* TGAP(100)/2 */
 #define INQUIRY_LEN_BREDR 0x08 /* TGAP(100) */
+#define INQUIRY_LEN_BREDR_LE 0x04 /* TGAP(100)/2 */
 
 struct pending_cmd {
 	struct list_head list;
@@ -1664,7 +1666,7 @@ static int start_discovery(struct sock *sk, u16 index)
 	}
 
 	if (lmp_host_le_capable(hdev) && lmp_bredr_capable(hdev))
-		err = -ENOSYS;
+		err = hci_do_inquiry(hdev, INQUIRY_LEN_BREDR_LE);
 	else if (lmp_host_le_capable(hdev))
 		err = hci_do_le_scan(hdev, LE_SCAN_TYPE, LE_SCAN_INT,
 					LE_SCAN_WIN, LE_SCAN_TIMEOUT_LE_ONLY);
@@ -2425,3 +2427,41 @@ int mgmt_has_pending_stop_discov(u16 index)
 
 	return 0;
 }
+
+int mgmt_is_interleaved_discovery(u16 index)
+{
+	struct hci_dev *hdev;
+	int res = 0;
+
+	hdev = hci_dev_get(index);
+	if (!hdev)
+		return 0;
+
+	if (mgmt_pending_find(MGMT_OP_START_DISCOVERY, hdev->id) &&
+			lmp_host_le_capable(hdev) && lmp_bredr_capable(hdev))
+		res = 1;
+
+	hci_dev_put(hdev);
+
+	return res;
+}
+
+int mgmt_interleaved_discovery(u16 index)
+{
+	struct hci_dev *hdev;
+	int err;
+
+	if (!mgmt_is_interleaved_discovery(index))
+		return -EPERM;
+
+	hdev = hci_dev_get(index);
+	if (!hdev)
+		return -ENODEV;
+
+	err = hci_do_le_scan(hdev, LE_SCAN_TYPE, LE_SCAN_INT, LE_SCAN_WIN,
+						LE_SCAN_TIMEOUT_BREDR_LE);
+
+	hci_dev_put(hdev);
+
+	return err;
+}
-- 
1.7.5.2

