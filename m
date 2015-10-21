Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/13] Bluetooth: Use hci_conn_hash_lookup_le() when possible
Date: Wed, 21 Oct 2015 18:03:01 +0300
Message-Id: <1445439791-2151-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1445439791-2151-1-git-send-email-johan.hedberg@gmail.com>
References: <1445439791-2151-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Use the new hci_conn_hash_lookup_le() API to look up LE connections.
This way we're guaranteed exact matches that also take into account
the address type.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c  |  9 +++------
 net/bluetooth/hci_event.c |  3 ++-
 net/bluetooth/mgmt.c      | 10 ++++++----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index ec4836f243bc..60fe6a570800 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -869,7 +869,7 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	 * attempt, we simply update pending_sec_level and auth_type fields
 	 * and return the object found.
 	 */
-	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
+	conn = hci_conn_hash_lookup_le(hdev, dst, dst_type);
 	conn_unfinished = NULL;
 	if (conn) {
 		if (conn->state == BT_CONNECT &&
@@ -1019,13 +1019,10 @@ static bool is_connected(struct hci_dev *hdev, bdaddr_t *addr, u8 type)
 {
 	struct hci_conn *conn;
 
-	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, addr);
+	conn = hci_conn_hash_lookup_le(hdev, addr, type);
 	if (!conn)
 		return false;
 
-	if (conn->dst_type != type)
-		return false;
-
 	if (conn->state != BT_CONNECTED)
 		return false;
 
@@ -1098,7 +1095,7 @@ struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
 	 * attempt, we simply update pending_sec_level and auth_type fields
 	 * and return the object found.
 	 */
-	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
+	conn = hci_conn_hash_lookup_le(hdev, dst, dst_type);
 	if (conn) {
 		if (conn->pending_sec_level < sec_level)
 			conn->pending_sec_level = sec_level;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b4571d84cafa..504892cfb25a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1915,7 +1915,8 @@ static void hci_cs_le_create_conn(struct hci_dev *hdev, u8 status)
 
 	hci_dev_lock(hdev);
 
-	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->peer_addr);
+	conn = hci_conn_hash_lookup_le(hdev, &cp->peer_addr,
+				       cp->peer_addr_type);
 	if (!conn)
 		goto unlock;
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index de338d576907..19834f524a7b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3098,8 +3098,8 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	} else {
 		u8 addr_type = le_addr_type(cp->addr.type);
 
-		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK,
-					       &cp->addr.bdaddr);
+		conn = hci_conn_hash_lookup_le(hdev, &cp->addr.bdaddr,
+					       addr_type);
 		if (conn) {
 			/* Defer clearing up the connection parameters
 			 * until closing to give a chance of keeping
@@ -3198,7 +3198,8 @@ static int disconnect(struct sock *sk, struct hci_dev *hdev, void *data,
 		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
 					       &cp->addr.bdaddr);
 	else
-		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->addr.bdaddr);
+		conn = hci_conn_hash_lookup_le(hdev, &cp->addr.bdaddr,
+					       le_addr_type(cp->addr.type));
 
 	if (!conn || conn->state == BT_OPEN || conn->state == BT_CLOSED) {
 		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_DISCONNECT,
@@ -3695,7 +3696,8 @@ static int user_pairing_resp(struct sock *sk, struct hci_dev *hdev,
 	if (addr->type == BDADDR_BREDR)
 		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &addr->bdaddr);
 	else
-		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &addr->bdaddr);
+		conn = hci_conn_hash_lookup_le(hdev, &addr->bdaddr,
+					       le_addr_type(addr->type));
 
 	if (!conn) {
 		err = mgmt_cmd_complete(sk, hdev->id, mgmt_op,
-- 
2.5.0

