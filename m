Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  1/2] emulator/btdev: Restructure le functions for readablity
Date: Thu, 04 Jun 2015 15:56:07 +0530
Message-id: <1433413568-26382-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use packed struct instead of buf to improve readability.
---
 emulator/btdev.c | 71 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 37 insertions(+), 34 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 4066d10..dfd953e 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -1088,12 +1088,13 @@ static void le_conn_complete(struct btdev *btdev,
 					const uint8_t *bdaddr, uint8_t bdaddr_type,
 					uint8_t status)
 {
-	char buf[1 + sizeof(struct bt_hci_evt_le_conn_complete)];
-	struct bt_hci_evt_le_conn_complete *cc = (void *) &buf[1];
+	struct __packed {
+		uint8_t subevent;
+		struct bt_hci_evt_le_conn_complete cc;
+	} ev;
 
-	memset(buf, 0, sizeof(buf));
 
-	buf[0] = BT_HCI_EVT_LE_CONN_COMPLETE;
+	ev.subevent = BT_HCI_EVT_LE_CONN_COMPLETE;
 
 	if (!status) {
 		struct btdev *remote = find_btdev_by_bdaddr_type(bdaddr,
@@ -1104,27 +1105,27 @@ static void le_conn_complete(struct btdev *btdev,
 		remote->conn = btdev;
 		remote->le_adv_enable = 0;
 
-		cc->status = status;
-		cc->peer_addr_type = btdev->le_scan_own_addr_type;
-		if (cc->peer_addr_type == 0x01)
-			memcpy(cc->peer_addr, btdev->random_addr, 6);
+		ev.cc.status = status;
+		ev.cc.peer_addr_type = btdev->le_scan_own_addr_type;
+		if (ev.cc.peer_addr_type == 0x01)
+			memcpy(ev.cc.peer_addr, btdev->random_addr, 6);
 		else
-			memcpy(cc->peer_addr, btdev->bdaddr, 6);
+			memcpy(ev.cc.peer_addr, btdev->bdaddr, 6);
 
-		cc->role = 0x01;
-		cc->handle = cpu_to_le16(42);
+		ev.cc.role = 0x01;
+		ev.cc.handle = cpu_to_le16(42);
 
-		send_event(remote, BT_HCI_EVT_LE_META_EVENT, buf, sizeof(buf));
+		send_event(remote, BT_HCI_EVT_LE_META_EVENT, &ev, sizeof(ev));
 
-		cc->handle = cpu_to_le16(42);
+		ev.cc.handle = cpu_to_le16(42);
 	}
 
-	cc->status = status;
-	cc->peer_addr_type = bdaddr_type;
-	memcpy(cc->peer_addr, bdaddr, 6);
-	cc->role = 0x00;
+	ev.cc.status = status;
+	ev.cc.peer_addr_type = bdaddr_type;
+	memcpy(ev.cc.peer_addr, bdaddr, 6);
+	ev.cc.role = 0x00;
 
-	send_event(btdev, BT_HCI_EVT_LE_META_EVENT, buf, sizeof(buf));
+	send_event(btdev, BT_HCI_EVT_LE_META_EVENT, &ev, sizeof(ev));
 }
 
 static const uint8_t *scan_addr(const struct btdev *btdev)
@@ -1813,9 +1814,11 @@ static void le_set_scan_enable_complete(struct btdev *btdev)
 
 static void le_read_remote_features_complete(struct btdev *btdev)
 {
-	char buf[1 + sizeof(struct bt_hci_evt_le_remote_features_complete)];
-	struct bt_hci_evt_le_remote_features_complete *ev = (void *) &buf[1];
 	struct btdev *remote = btdev->conn;
+	struct __packed {
+		uint8_t subevent;
+		struct bt_hci_evt_le_remote_features_complete rfc;
+	} ev;
 
 	if (!remote) {
 		cmd_status(btdev, BT_HCI_ERR_UNKNOWN_CONN_ID,
@@ -1826,20 +1829,21 @@ static void le_read_remote_features_complete(struct btdev *btdev)
 	cmd_status(btdev, BT_HCI_ERR_SUCCESS,
 				BT_HCI_CMD_LE_READ_REMOTE_FEATURES);
 
-	memset(buf, 0, sizeof(buf));
-	buf[0] = BT_HCI_EVT_LE_REMOTE_FEATURES_COMPLETE;
-	ev->status = BT_HCI_ERR_SUCCESS;
-	ev->handle = cpu_to_le16(42);
-	memcpy(ev->features, remote->le_features, 8);
+	ev.subevent = BT_HCI_EVT_LE_REMOTE_FEATURES_COMPLETE;
+	ev.rfc.status = BT_HCI_ERR_SUCCESS;
+	ev.rfc.handle = cpu_to_le16(42);
+	memcpy(&ev.rfc.features, remote->le_features, 8);
 
-	send_event(btdev, BT_HCI_EVT_LE_META_EVENT, buf, sizeof(buf));
+	send_event(btdev, BT_HCI_EVT_LE_META_EVENT, &ev, sizeof(ev));
 }
 
 static void le_start_encrypt_complete(struct btdev *btdev, uint16_t ediv,
 								uint64_t rand)
 {
-	char buf[1 + sizeof(struct bt_hci_evt_le_long_term_key_request)];
-	struct bt_hci_evt_le_long_term_key_request *ev = (void *) &buf[1];
+	struct __packed {
+		uint8_t subevent;
+		struct bt_hci_evt_le_long_term_key_request ev;
+	} ev;
 	struct btdev *remote = btdev->conn;
 
 	if (!remote) {
@@ -1850,13 +1854,12 @@ static void le_start_encrypt_complete(struct btdev *btdev, uint16_t ediv,
 
 	cmd_status(btdev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_LE_START_ENCRYPT);
 
-	memset(buf, 0, sizeof(buf));
-	buf[0] = BT_HCI_EVT_LE_LONG_TERM_KEY_REQUEST;
-	ev->handle = cpu_to_le16(42);
-	ev->ediv = ediv;
-	ev->rand = rand;
+	ev.subevent = BT_HCI_EVT_LE_LONG_TERM_KEY_REQUEST;
+	ev.ev.handle = cpu_to_le16(42);
+	ev.ev.ediv = ediv;
+	ev.ev.rand = rand;
 
-	send_event(remote, BT_HCI_EVT_LE_META_EVENT, buf, sizeof(buf));
+	send_event(remote, BT_HCI_EVT_LE_META_EVENT, &ev, sizeof(ev));
 }
 
 static void le_encrypt_complete(struct btdev *btdev)
-- 
1.9.1

