Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 6/7] Bluetooth: Handle hci_conn timeout in BT_SCAN state
Date: Fri,  1 Feb 2013 21:44:37 -0300
Message-Id: <1359765878-31409-7-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1359765878-31409-1-git-send-email-andre.guedes@openbossa.org>
References: <1359765878-31409-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If occurs a hci_conn timeout in BT_SCAN state we should stop the
ongoing LE scan.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_conn.c  |  6 ++++++
 net/bluetooth/hci_event.c | 16 ++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index fa2caf2..ac45725 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -269,6 +269,12 @@ static void hci_conn_timeout(struct work_struct *work)
 		return;
 
 	switch (conn->state) {
+	case BT_SCAN:
+		if (conn->type == LE_LINK) {
+			conn->state = BT_CLOSED;
+			hci_cancel_le_scan(conn->hdev);
+		}
+		break;
 	case BT_CONNECT:
 	case BT_CONNECT2:
 		if (conn->out) {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c9d2b71..63c5d10 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1296,6 +1296,22 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 
 		clear_bit(HCI_LE_SCAN, &hdev->dev_flags);
 
+		hcon = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CLOSED);
+		if (hcon) {
+			mgmt_connect_failed(hdev, &hcon->dst, hcon->type,
+					    hcon->dst_type,
+					    HCI_ERROR_LOCAL_HOST_TERM);
+
+			hci_proto_connect_cfm(hcon, HCI_ERROR_LOCAL_HOST_TERM);
+			hci_conn_del(hcon);
+
+			hci_dev_lock(hdev);
+			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+			hci_dev_unlock(hdev);
+
+			return;
+		}
+
 		hcon = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_DEV_FOUND);
 		if (hcon) {
 			hci_dev_lock(hdev);
-- 
1.8.1.1

