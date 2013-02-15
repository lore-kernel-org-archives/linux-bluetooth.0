Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2 7/8] Bluetooth: Count pending LE connection attempts
Date: Fri, 15 Feb 2013 20:27:07 -0300
Message-Id: <1360970828-24004-8-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1360970828-24004-1-git-send-email-andre.guedes@openbossa.org>
References: <1360970828-24004-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

To avoid traversing the hci_conn list every time we get an advertising
report, we keep a counter of pending LE connection attempts (connections
in HCI_CONN_LE_SCAN state). This way, we only traverse the list if the
counter is greater from zero.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h | 6 ++++++
 net/bluetooth/hci_conn.c         | 6 ++++++
 net/bluetooth/hci_core.c         | 2 ++
 3 files changed, 14 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c797717..5f2a991 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -290,6 +290,12 @@ struct hci_dev {
 	__u8			adv_data[HCI_MAX_AD_LENGTH];
 	__u8			adv_data_len;
 
+	/*
+	 * This counter tracks the number of pending LE connections
+	 * (connections in HCI_CONN_LE_SCAN state).
+	 */
+	atomic_t		le_conn_pend;
+
 	int (*open)(struct hci_dev *hdev);
 	int (*close)(struct hci_dev *hdev);
 	int (*flush)(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index e259745..29192e0 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -266,6 +266,7 @@ static void cancel_le_connection(struct hci_conn *conn)
 
 	switch (atomic_read(&conn->le_state)) {
 	case HCI_CONN_LE_SCAN:
+		atomic_dec(&hdev->le_conn_pend);
 		hci_cancel_le_scan(hdev);
 		break;
 	case HCI_CONN_LE_INITIATE:
@@ -1061,9 +1062,11 @@ void hci_conn_set_le_state(struct hci_conn *conn, int state)
 
 	switch (state) {
 	case HCI_CONN_LE_SCAN:
+		atomic_inc(&hdev->le_conn_pend);
 		hci_le_scan(hdev, LE_SCAN_PASSIVE, 0x60, 0x30, 0);
 		break;
 	case HCI_CONN_LE_FOUND:
+		atomic_dec(&hdev->le_conn_pend);
 		hci_cancel_le_scan(hdev);
 		break;
 	case HCI_CONN_LE_INITIATE:
@@ -1079,6 +1082,9 @@ struct hci_conn *hci_conn_has_le_pending(struct hci_dev *hdev, bdaddr_t *addr,
 {
 	struct hci_conn *conn;
 
+	if (atomic_read(&hdev->le_conn_pend) == 0)
+		return NULL;
+
 	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, addr);
 	if (!conn)
 		return NULL;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3aa0345..acdfe15 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1742,6 +1742,8 @@ struct hci_dev *hci_alloc_dev(void)
 	hci_init_sysfs(hdev);
 	discovery_init(hdev);
 
+	atomic_set(&hdev->le_conn_pend, 0);
+
 	return hdev;
 }
 EXPORT_SYMBOL(hci_alloc_dev);
-- 
1.8.1.2

