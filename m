Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 15/15] Bluetooth: Support BR/EDR/LE discovery procedure
Date: Wed,  5 Oct 2011 20:20:47 -0300
Message-Id: <1317856847-28167-16-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1317856847-28167-1-git-send-email-andre.guedes@openbossa.org>
References: <1317856847-28167-1-git-send-email-andre.guedes@openbossa.org>
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
index c6ae380..c5c38e3 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -880,6 +880,8 @@ int mgmt_device_blocked(u16 index, bdaddr_t *bdaddr);
 int mgmt_device_unblocked(u16 index, bdaddr_t *bdaddr);
 int mgmt_discovery_complete(u16 index, u8 status);
 int mgmt_has_pending_stop_discov(u16 index);
+int mgmt_interleaved_discovery(u16 index);
+int mgmt_is_interleaved_discovery(u16 index);
 
 /* HCI info for socket */
 #define hci_pi(sk) ((struct hci_pinfo *) sk)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5b99058..029badd 100644
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
 
@@ -1358,6 +1363,7 @@ static void hci_cs_le_start_enc(struct hci_dev *hdev, u8 status)
 static inline void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
+	int err;
 
 	BT_DBG("%s status %d", hdev->name, status);
 
@@ -1368,9 +1374,11 @@ static inline void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff
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
index 685519b..1096a37 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -40,8 +40,10 @@
 #define LE_SCAN_WIN 0x12
 #define LE_SCAN_INT 0x12
 #define LE_SCAN_TIMEOUT_LE_ONLY 10240 /* TGAP(gen_disc_scan_min) */
+#define LE_SCAN_TIMEOUT_BREDR_LE 5120 /* TGAP(100)/2 */
 
 #define INQUIRY_LEN_BREDR 0x08 /* TGAP(100) */
+#define INQUIRY_LEN_BREDR_LE 0x04 /* TGAP(100)/2 */
 
 struct pending_cmd {
 	struct list_head list;
@@ -1645,7 +1647,7 @@ static int start_discovery(struct sock *sk, u16 index)
 
 	if (lmp_host_le_capable(hdev)) {
 		if (lmp_bredr_capable(hdev))
-			err = -ENOSYS;
+			err = hci_do_inquiry(hdev, INQUIRY_LEN_BREDR_LE);
 		else
 			err = hci_do_le_scan(hdev, LE_SCAN_TYPE, LE_SCAN_INT,
 					LE_SCAN_WIN, LE_SCAN_TIMEOUT_LE_ONLY);
@@ -2456,3 +2458,41 @@ int mgmt_has_pending_stop_discov(u16 index)
 
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
+	if (lmp_host_le_capable(hdev) && lmp_bredr_capable(hdev) &&
+			mgmt_pending_find(MGMT_OP_START_DISCOVERY, hdev->id))
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

