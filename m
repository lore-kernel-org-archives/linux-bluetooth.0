Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 7/7] Bluetooth: Track the number of hci_conn in BT_SCAN
Date: Fri,  1 Feb 2013 21:44:38 -0300
Message-Id: <1359765878-31409-8-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1359765878-31409-1-git-send-email-andre.guedes@openbossa.org>
References: <1359765878-31409-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In order to avoid traversing the hci_conn list every time we get an
advertising report, we should keep a counter of connections in
BT_SCAN state. This way, we only traverse the list if the counter
is greater from zero.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |  5 +++++
 net/bluetooth/hci_conn.c         |  6 +++++-
 net/bluetooth/hci_core.c         |  2 ++
 net/bluetooth/hci_event.c        | 13 +++++++++----
 4 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b089968..b371434 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -290,6 +290,11 @@ struct hci_dev {
 	__u8			adv_data[HCI_MAX_AD_LENGTH];
 	__u8			adv_data_len;
 
+	/* This counter tracks the number of LE connections in scanning
+	 * state (BT_SCAN).
+	 */
+	atomic_t		le_conn_scan_cnt;
+
 	int (*open)(struct hci_dev *hdev);
 	int (*close)(struct hci_dev *hdev);
 	int (*flush)(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index ac45725..58fd681 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -262,6 +262,7 @@ static void hci_conn_timeout(struct work_struct *work)
 {
 	struct hci_conn *conn = container_of(work, struct hci_conn,
 					     disc_work.work);
+	struct hci_dev *hdev = conn->hdev;
 
 	BT_DBG("hcon %p state %s", conn, state_to_string(conn->state));
 
@@ -272,7 +273,8 @@ static void hci_conn_timeout(struct work_struct *work)
 	case BT_SCAN:
 		if (conn->type == LE_LINK) {
 			conn->state = BT_CLOSED;
-			hci_cancel_le_scan(conn->hdev);
+			atomic_dec(&hdev->le_conn_scan_cnt);
+			hci_cancel_le_scan(hdev);
 		}
 		break;
 	case BT_CONNECT:
@@ -524,6 +526,8 @@ static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 		le->dst_type = bdaddr_to_le(dst_type);
 		le->state = BT_SCAN;
 
+		atomic_inc(&hdev->le_conn_scan_cnt);
+
 		hci_le_scan(hdev, LE_SCAN_PASSIVE, 0x60, 0x30, 0);
 	}
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3aa0345..f5c2b01 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1742,6 +1742,8 @@ struct hci_dev *hci_alloc_dev(void)
 	hci_init_sysfs(hdev);
 	discovery_init(hdev);
 
+	atomic_set(&hdev->le_conn_scan_cnt, 0);
+
 	return hdev;
 }
 EXPORT_SYMBOL(hci_alloc_dev);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 63c5d10..1464e5e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4016,10 +4016,15 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	while (num_reports--) {
 		struct hci_ev_le_advertising_info *ev = ptr;
 
-		hcon = hci_conn_hash_lookup_ba(hdev, LE_LINK, &ev->bdaddr);
-		if (hcon && hcon->dst_type == ev->bdaddr_type) {
-			hcon->state = BT_DEV_FOUND;
-			hci_cancel_le_scan(hdev);
+		if (atomic_read(&hdev->le_conn_scan_cnt) != 0) {
+			hcon = hci_conn_hash_lookup_ba(hdev, LE_LINK,
+						       &ev->bdaddr);
+
+			if (hcon && hcon->dst_type == ev->bdaddr_type) {
+				hcon->state = BT_DEV_FOUND;
+				atomic_dec(&hdev->le_conn_scan_cnt);
+				hci_cancel_le_scan(hdev);
+			}
 		}
 
 		rssi = ev->data[ev->length];
-- 
1.8.1.1

