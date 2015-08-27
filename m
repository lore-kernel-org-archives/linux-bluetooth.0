Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH 1/5] emulator: Fix LE Connection Complete Event data
Date: Thu, 27 Aug 2015 17:54:49 +0200
Message-Id: <1440690893-30384-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This sets LE Connection Complete Event paramaters based on parameters
from LE Create Connection command.
Event parameters like Conn_Interval and Supervision_Timeout
shouldn't be set to 0.
---
 emulator/btdev.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index e4c85f8..319d434 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -1085,20 +1085,22 @@ static void sco_conn_complete(struct btdev *btdev, uint8_t status)
 	send_event(btdev, BT_HCI_EVT_CONN_COMPLETE, &cc, sizeof(cc));
 }
 
-static void le_conn_complete(struct btdev *btdev,
-					const uint8_t *bdaddr, uint8_t bdaddr_type,
-					uint8_t status)
+static void le_conn_complete(struct btdev *btdev, const void *cmd,
+								uint8_t status)
 {
 	char buf[1 + sizeof(struct bt_hci_evt_le_conn_complete)];
 	struct bt_hci_evt_le_conn_complete *cc = (void *) &buf[1];
+	const struct bt_hci_cmd_le_create_conn *lecc = cmd;
 
 	memset(buf, 0, sizeof(buf));
 
 	buf[0] = BT_HCI_EVT_LE_CONN_COMPLETE;
 
 	if (!status) {
-		struct btdev *remote = find_btdev_by_bdaddr_type(bdaddr,
-								bdaddr_type);
+		struct btdev *remote;
+
+		remote = find_btdev_by_bdaddr_type(lecc->peer_addr,
+							lecc->peer_addr_type);
 
 		btdev->conn = remote;
 		btdev->le_adv_enable = 0;
@@ -1114,6 +1116,9 @@ static void le_conn_complete(struct btdev *btdev,
 
 		cc->role = 0x01;
 		cc->handle = cpu_to_le16(42);
+		cc->interval = lecc->max_interval;
+		cc->latency = lecc->latency;
+		cc->supv_timeout = lecc->supv_timeout;
 
 		send_event(remote, BT_HCI_EVT_LE_META_EVENT, buf, sizeof(buf));
 
@@ -1121,8 +1126,8 @@ static void le_conn_complete(struct btdev *btdev,
 	}
 
 	cc->status = status;
-	cc->peer_addr_type = bdaddr_type;
-	memcpy(cc->peer_addr, bdaddr, 6);
+	cc->peer_addr_type = lecc->peer_addr_type;
+	memcpy(cc->peer_addr, lecc->peer_addr, 6);
 	cc->role = 0x00;
 
 	send_event(btdev, BT_HCI_EVT_LE_META_EVENT, buf, sizeof(buf));
@@ -1164,16 +1169,17 @@ static bool adv_connectable(struct btdev *btdev)
 	return btdev->le_adv_type != 0x03;
 }
 
-static void le_conn_request(struct btdev *btdev, const uint8_t *bdaddr,
-							uint8_t bdaddr_type)
+static void le_conn_request(struct btdev *btdev, const void *cmd)
 {
-	struct btdev *remote = find_btdev_by_bdaddr_type(bdaddr, bdaddr_type);
+	const struct bt_hci_cmd_le_create_conn *lecc = cmd;
+	struct btdev *remote = find_btdev_by_bdaddr_type(lecc->peer_addr,
+							lecc->peer_addr_type);
 
 	if (remote && adv_connectable(remote) && adv_match(btdev, remote) &&
-					remote->le_adv_own_addr == bdaddr_type)
-		le_conn_complete(btdev, bdaddr, bdaddr_type, 0);
+				remote->le_adv_own_addr == lecc->peer_addr_type)
+		le_conn_complete(btdev, lecc, 0);
 	else
-		le_conn_complete(btdev, bdaddr, bdaddr_type,
+		le_conn_complete(btdev, lecc,
 					BT_HCI_ERR_CONN_FAILED_TO_ESTABLISH);
 }
 
@@ -3314,7 +3320,7 @@ static void default_cmd_completion(struct btdev *btdev, uint16_t opcode,
 			return;
 		lecc = data;
 		btdev->le_scan_own_addr_type = lecc->own_addr_type;
-		le_conn_request(btdev, lecc->peer_addr, lecc->peer_addr_type);
+		le_conn_request(btdev, lecc);
 		break;
 
 	case BT_HCI_CMD_LE_CONN_UPDATE:
-- 
2.4.3

