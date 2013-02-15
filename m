Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2 5/8] Bluetooth: Change LE connection routine
Date: Fri, 15 Feb 2013 20:27:05 -0300
Message-Id: <1360970828-24004-6-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1360970828-24004-1-git-send-email-andre.guedes@openbossa.org>
References: <1360970828-24004-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In order to better support LE connection requirements, such as multiple
connections and re-connections, we should use the general connection
establishment procedure described in Core spec. Today, we use the direct
connection establishment procedure which has some limitations and,
therefore, requires extra connection management at user-space in order
to support LE connection requirements.

According to the spec, the general procedure is described as follows:
The host starts scanning for LE devices, once the device we want to
connect to is in-range, the host stops scanning and initiates a
connection. The procedure is terminated when the connection is
established or when the host terminates the procedure.

This patch changes the LE connection routine so we perform the general
procedure instead of the direct procedure.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_conn.c  |  4 +++-
 net/bluetooth/hci_event.c | 19 +++++++++++++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b1a162f..308c87a 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -517,7 +517,9 @@ static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 			return ERR_PTR(-ENOMEM);
 
 		le->dst_type = bdaddr_to_le(dst_type);
-		hci_le_create_connection(le);
+		le->state = BT_CONNECT;
+
+		hci_conn_set_le_state(le, HCI_CONN_LE_SCAN);
 	}
 
 	le->pending_sec_level = sec_level;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 477726a..84648c8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1260,6 +1260,7 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 {
 	struct hci_cp_le_set_scan_enable *cp;
 	__u8 status = *((__u8 *) skb->data);
+	struct hci_conn *hcon;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
 
@@ -1295,8 +1296,15 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 
 		clear_bit(HCI_LE_SCAN, &hdev->dev_flags);
 
-		if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED &&
-		    hdev->discovery.state == DISCOVERY_FINDING) {
+		hcon = hci_conn_hash_lookup_le_state(hdev, HCI_CONN_LE_FOUND);
+		if (hcon) {
+			hci_dev_lock(hdev);
+			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+			hci_dev_unlock(hdev);
+
+			hci_conn_set_le_state(hcon, HCI_CONN_LE_INITIATE);
+		} else if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED &&
+			   hdev->discovery.state == DISCOVERY_FINDING) {
 			mgmt_interleaved_discovery(hdev);
 		} else {
 			hci_dev_lock(hdev);
@@ -3971,6 +3979,7 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	conn->sec_level = BT_SECURITY_LOW;
 	conn->handle = __le16_to_cpu(ev->handle);
+	hci_conn_set_le_state(conn, 0);
 	conn->state = BT_CONNECTED;
 
 	hci_conn_hold_device(conn);
@@ -3987,10 +3996,16 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	u8 num_reports = skb->data[0];
 	void *ptr = &skb->data[1];
 	s8 rssi;
+	struct hci_conn *hcon;
 
 	while (num_reports--) {
 		struct hci_ev_le_advertising_info *ev = ptr;
 
+		hcon = hci_conn_has_le_pending(hdev, &ev->bdaddr,
+					       ev->bdaddr_type);
+		if (hcon)
+			hci_conn_set_le_state(hcon, HCI_CONN_LE_FOUND);
+
 		rssi = ev->data[ev->length];
 		mgmt_device_found(hdev, &ev->bdaddr, LE_LINK, ev->bdaddr_type,
 				  NULL, rssi, 0, 1, ev->data, ev->length);
-- 
1.8.1.2

