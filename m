Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2 08/15] Bluetooth: Move is_scan_and_conn_supported() to hci_core
Date: Tue, 29 Oct 2013 10:25:53 -0300
Message-Id: <1383053160-10175-9-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1383053160-10175-1-git-send-email-andre.guedes@openbossa.org>
References: <1383053160-10175-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the "hci_" prefix and moves the is_scan_and_conn_
supported() helper to hci_core so it can be reused in hci_core by
the next patch.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_conn.c         | 13 +------------
 net/bluetooth/hci_core.c         | 11 +++++++++++
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e85b37e..0049036 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -782,6 +782,8 @@ int __hci_add_pending_auto_conn(struct hci_dev *hdev, bdaddr_t *addr,
 void __hci_remove_pending_auto_conn(struct hci_dev *hdev, bdaddr_t *addr,
 				    u8 addr_type);
 
+bool hci_is_scan_and_conn_supported(struct hci_dev *hdev);
+
 int hci_uuids_clear(struct hci_dev *hdev);
 
 int hci_link_keys_clear(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 075d070..b52bcb2 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -546,17 +546,6 @@ done:
 	hci_dev_unlock(hdev);
 }
 
-/* Check if controller supports creating a connection while scanning is
- * runnning.
- */
-static bool is_scan_and_conn_supported(struct hci_dev *hdev)
-{
-	u8 mask = BIT(6) | BIT(7);
-
-	/* Return true if both bits are set */
-	return (hdev->le_states[2] & mask) == mask;
-}
-
 static int hci_create_le_conn(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
@@ -571,7 +560,7 @@ static int hci_create_le_conn(struct hci_conn *conn)
 	 * Otherwise, LE Create Connection command fails.
 	 */
 	if (test_bit(HCI_LE_SCAN, &hdev->dev_flags) &&
-	    !is_scan_and_conn_supported(hdev)) {
+	    !hci_is_scan_and_conn_supported(hdev)) {
 		struct hci_cp_le_set_scan_enable enable_cp;
 
 		memset(&enable_cp, 0, sizeof(enable_cp));
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 94c390b..19624d1 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4496,3 +4496,14 @@ static void hci_cmd_work(struct work_struct *work)
 		}
 	}
 }
+
+/* Check if controller supports creating a connection while scanning is
+ * runnning.
+ */
+bool hci_is_scan_and_conn_supported(struct hci_dev *hdev)
+{
+	u8 mask = BIT(6) | BIT(7);
+
+	/* Return true if both bits are set */
+	return (hdev->le_states[2] & mask) == mask;
+}
-- 
1.8.4

