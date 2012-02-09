Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/8] Bluetooth: Add address type to user_confirm and user_passkey messages
Date: Thu,  9 Feb 2012 17:23:45 +0200
Message-Id: <1328801030-24274-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1328801030-24274-1-git-send-email-johan.hedberg@gmail.com>
References: <1328801030-24274-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch upadate the user confirm and user passkey mgmt messages to
match the latest API specification by adding an address type parameter
to them.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |   18 ++++---
 include/net/bluetooth/mgmt.h     |   16 +++---
 net/bluetooth/hci_event.c        |   14 +++--
 net/bluetooth/mgmt.c             |   98 +++++++++++++++++++------------------
 net/bluetooth/smp.c              |    4 +-
 5 files changed, 79 insertions(+), 71 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 634a0cd..5f27694 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -968,16 +968,18 @@ int mgmt_pin_code_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 int mgmt_pin_code_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 								u8 status);
 int mgmt_user_confirm_request(struct hci_dev *hdev, bdaddr_t *bdaddr,
-						__le32 value, u8 confirm_hint);
+				u8 link_type, u8 addr_type, __le32 value,
+				u8 confirm_hint);
 int mgmt_user_confirm_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
-								u8 status);
-int mgmt_user_confirm_neg_reply_complete(struct hci_dev *hdev,
-						bdaddr_t *bdaddr, u8 status);
-int mgmt_user_passkey_request(struct hci_dev *hdev, bdaddr_t *bdaddr);
+					u8 link_type, u8 addr_type, u8 status);
+int mgmt_user_confirm_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
+					u8 link_type, u8 addr_type, u8 status);
+int mgmt_user_passkey_request(struct hci_dev *hdev, bdaddr_t *bdaddr,
+						u8 link_type, u8 addr_type);
 int mgmt_user_passkey_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
-								u8 status);
-int mgmt_user_passkey_neg_reply_complete(struct hci_dev *hdev,
-						bdaddr_t *bdaddr, u8 status);
+					u8 link_type, u8 addr_type, u8 status);
+int mgmt_user_passkey_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
+					u8 link_type, u8 addr_type, u8 status);
 int mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 status);
 int mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status);
 int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 735e547..378d498 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -235,31 +235,31 @@ struct mgmt_rp_unpair_device {
 
 #define MGMT_OP_USER_CONFIRM_REPLY	0x001C
 struct mgmt_cp_user_confirm_reply {
-	bdaddr_t bdaddr;
+	struct mgmt_addr_info addr;
 } __packed;
 struct mgmt_rp_user_confirm_reply {
-	bdaddr_t bdaddr;
+	struct mgmt_addr_info addr;
 	__u8 status;
 } __packed;
 
 #define MGMT_OP_USER_CONFIRM_NEG_REPLY	0x001D
 struct mgmt_cp_user_confirm_neg_reply {
-	bdaddr_t bdaddr;
+	struct mgmt_addr_info addr;
 } __packed;
 
 #define MGMT_OP_USER_PASSKEY_REPLY	0x001E
 struct mgmt_cp_user_passkey_reply {
-	bdaddr_t bdaddr;
+	struct mgmt_addr_info addr;
 	__le32 passkey;
 } __packed;
 struct mgmt_rp_user_passkey_reply {
-	bdaddr_t bdaddr;
+	struct mgmt_addr_info addr;
 	__u8 status;
 } __packed;
 
 #define MGMT_OP_USER_PASSKEY_NEG_REPLY	0x001F
 struct mgmt_cp_user_passkey_neg_reply {
-	bdaddr_t bdaddr;
+	struct mgmt_addr_info addr;
 } __packed;
 
 #define MGMT_OP_READ_LOCAL_OOB_DATA	0x0020
@@ -376,14 +376,14 @@ struct mgmt_ev_pin_code_request {
 
 #define MGMT_EV_USER_CONFIRM_REQUEST	0x000F
 struct mgmt_ev_user_confirm_request {
-	bdaddr_t bdaddr;
+	struct mgmt_addr_info addr;
 	__u8 confirm_hint;
 	__le32 value;
 } __packed;
 
 #define MGMT_EV_USER_PASSKEY_REQUEST	0x0010
 struct mgmt_ev_user_passkey_request {
-	bdaddr_t bdaddr;
+	struct mgmt_addr_info addr;
 } __packed;
 
 #define MGMT_EV_AUTH_FAILED		0x0011
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f0c822d..3bf3f4d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -960,8 +960,8 @@ static void hci_cc_user_confirm_reply(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_lock(hdev);
 
 	if (test_bit(HCI_MGMT, &hdev->dev_flags))
-		mgmt_user_confirm_reply_complete(hdev, &rp->bdaddr,
-								rp->status);
+		mgmt_user_confirm_reply_complete(hdev, &rp->bdaddr, ACL_LINK,
+								0, rp->status);
 
 	hci_dev_unlock(hdev);
 }
@@ -977,6 +977,7 @@ static void hci_cc_user_confirm_neg_reply(struct hci_dev *hdev,
 
 	if (test_bit(HCI_MGMT, &hdev->dev_flags))
 		mgmt_user_confirm_neg_reply_complete(hdev, &rp->bdaddr,
+								ACL_LINK, 0,
 								rp->status);
 
 	hci_dev_unlock(hdev);
@@ -991,8 +992,8 @@ static void hci_cc_user_passkey_reply(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_lock(hdev);
 
 	if (test_bit(HCI_MGMT, &hdev->dev_flags))
-		mgmt_user_passkey_reply_complete(hdev, &rp->bdaddr,
-								rp->status);
+		mgmt_user_passkey_reply_complete(hdev, &rp->bdaddr, ACL_LINK,
+								0, rp->status);
 
 	hci_dev_unlock(hdev);
 }
@@ -1008,6 +1009,7 @@ static void hci_cc_user_passkey_neg_reply(struct hci_dev *hdev,
 
 	if (test_bit(HCI_MGMT, &hdev->dev_flags))
 		mgmt_user_passkey_neg_reply_complete(hdev, &rp->bdaddr,
+								ACL_LINK, 0,
 								rp->status);
 
 	hci_dev_unlock(hdev);
@@ -3123,7 +3125,7 @@ static inline void hci_user_confirm_request_evt(struct hci_dev *hdev,
 	}
 
 confirm:
-	mgmt_user_confirm_request(hdev, &ev->bdaddr, ev->passkey,
+	mgmt_user_confirm_request(hdev, &ev->bdaddr, ACL_LINK, 0, ev->passkey,
 								confirm_hint);
 
 unlock:
@@ -3140,7 +3142,7 @@ static inline void hci_user_passkey_request_evt(struct hci_dev *hdev,
 	hci_dev_lock(hdev);
 
 	if (test_bit(HCI_MGMT, &hdev->dev_flags))
-		mgmt_user_passkey_request(hdev, &ev->bdaddr);
+		mgmt_user_passkey_request(hdev, &ev->bdaddr, ACL_LINK, 0);
 
 	hci_dev_unlock(hdev);
 }
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f1257ee..16fc828 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1629,7 +1629,8 @@ unlock:
 }
 
 static int user_pairing_resp(struct sock *sk, u16 index, bdaddr_t *bdaddr,
-					u16 mgmt_op, u16 hci_op, __le32 passkey)
+					u8 type, u16 mgmt_op, u16 hci_op,
+					__le32 passkey)
 {
 	struct pending_cmd *cmd;
 	struct hci_dev *hdev;
@@ -1648,24 +1649,18 @@ static int user_pairing_resp(struct sock *sk, u16 index, bdaddr_t *bdaddr,
 		goto done;
 	}
 
-	/*
-	 * Check for an existing ACL link, if present pair via
-	 * HCI commands.
-	 *
-	 * If no ACL link is present, check for an LE link and if
-	 * present, pair via the SMP engine.
-	 *
-	 * If neither ACL nor LE links are present, fail with error.
-	 */
-	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, bdaddr);
-	if (!conn) {
+	if (type == MGMT_ADDR_BREDR)
+		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, bdaddr);
+	else
 		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, bdaddr);
-		if (!conn) {
-			err = cmd_status(sk, index, mgmt_op,
+
+	if (!conn) {
+		err = cmd_status(sk, index, mgmt_op,
 						MGMT_STATUS_NOT_CONNECTED);
-			goto done;
-		}
+		goto done;
+	}
 
+	if (type == MGMT_ADDR_LE_PUBLIC || type == MGMT_ADDR_LE_RANDOM) {
 		/* Continue with pairing via SMP */
 		err = smp_user_confirm_reply(conn, mgmt_op, passkey);
 
@@ -1715,9 +1710,9 @@ static int user_confirm_reply(struct sock *sk, u16 index, void *data, u16 len)
 		return cmd_status(sk, index, MGMT_OP_USER_CONFIRM_REPLY,
 						MGMT_STATUS_INVALID_PARAMS);
 
-	return user_pairing_resp(sk, index, &cp->bdaddr,
-			MGMT_OP_USER_CONFIRM_REPLY,
-			HCI_OP_USER_CONFIRM_REPLY, 0);
+	return user_pairing_resp(sk, index, &cp->addr.bdaddr, cp->addr.type,
+						MGMT_OP_USER_CONFIRM_REPLY,
+						HCI_OP_USER_CONFIRM_REPLY, 0);
 }
 
 static int user_confirm_neg_reply(struct sock *sk, u16 index, void *data,
@@ -1731,9 +1726,9 @@ static int user_confirm_neg_reply(struct sock *sk, u16 index, void *data,
 		return cmd_status(sk, index, MGMT_OP_USER_CONFIRM_NEG_REPLY,
 						MGMT_STATUS_INVALID_PARAMS);
 
-	return user_pairing_resp(sk, index, &cp->bdaddr,
-			MGMT_OP_USER_CONFIRM_NEG_REPLY,
-			HCI_OP_USER_CONFIRM_NEG_REPLY, 0);
+	return user_pairing_resp(sk, index, &cp->addr.bdaddr, cp->addr.type,
+					MGMT_OP_USER_CONFIRM_NEG_REPLY,
+					HCI_OP_USER_CONFIRM_NEG_REPLY, 0);
 }
 
 static int user_passkey_reply(struct sock *sk, u16 index, void *data, u16 len)
@@ -1746,9 +1741,10 @@ static int user_passkey_reply(struct sock *sk, u16 index, void *data, u16 len)
 		return cmd_status(sk, index, MGMT_OP_USER_PASSKEY_REPLY,
 									EINVAL);
 
-	return user_pairing_resp(sk, index, &cp->bdaddr,
-			MGMT_OP_USER_PASSKEY_REPLY,
-			HCI_OP_USER_PASSKEY_REPLY, cp->passkey);
+	return user_pairing_resp(sk, index, &cp->addr.bdaddr, cp->addr.type,
+						MGMT_OP_USER_PASSKEY_REPLY,
+						HCI_OP_USER_PASSKEY_REPLY,
+						cp->passkey);
 }
 
 static int user_passkey_neg_reply(struct sock *sk, u16 index, void *data,
@@ -1762,9 +1758,9 @@ static int user_passkey_neg_reply(struct sock *sk, u16 index, void *data,
 		return cmd_status(sk, index, MGMT_OP_USER_PASSKEY_NEG_REPLY,
 									EINVAL);
 
-	return user_pairing_resp(sk, index, &cp->bdaddr,
-			MGMT_OP_USER_PASSKEY_NEG_REPLY,
-			HCI_OP_USER_PASSKEY_NEG_REPLY, 0);
+	return user_pairing_resp(sk, index, &cp->addr.bdaddr, cp->addr.type,
+					MGMT_OP_USER_PASSKEY_NEG_REPLY,
+					HCI_OP_USER_PASSKEY_NEG_REPLY, 0);
 }
 
 static int set_local_name(struct sock *sk, u16 index, void *data,
@@ -2765,13 +2761,15 @@ int mgmt_pin_code_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 }
 
 int mgmt_user_confirm_request(struct hci_dev *hdev, bdaddr_t *bdaddr,
-						__le32 value, u8 confirm_hint)
+				u8 link_type, u8 addr_type, __le32 value,
+				u8 confirm_hint)
 {
 	struct mgmt_ev_user_confirm_request ev;
 
 	BT_DBG("%s", hdev->name);
 
-	bacpy(&ev.bdaddr, bdaddr);
+	bacpy(&ev.addr.bdaddr, bdaddr);
+	ev.addr.type = link_to_mgmt(link_type, addr_type);
 	ev.confirm_hint = confirm_hint;
 	put_unaligned_le32(value, &ev.value);
 
@@ -2779,20 +2777,23 @@ int mgmt_user_confirm_request(struct hci_dev *hdev, bdaddr_t *bdaddr,
 									NULL);
 }
 
-int mgmt_user_passkey_request(struct hci_dev *hdev, bdaddr_t *bdaddr)
+int mgmt_user_passkey_request(struct hci_dev *hdev, bdaddr_t *bdaddr,
+						u8 link_type, u8 addr_type)
 {
 	struct mgmt_ev_user_passkey_request ev;
 
 	BT_DBG("%s", hdev->name);
 
-	bacpy(&ev.bdaddr, bdaddr);
+	bacpy(&ev.addr.bdaddr, bdaddr);
+	ev.addr.type = link_to_mgmt(link_type, addr_type);
 
 	return mgmt_event(MGMT_EV_USER_PASSKEY_REQUEST, hdev, &ev, sizeof(ev),
 									NULL);
 }
 
 static int user_pairing_resp_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
-							u8 status, u8 opcode)
+					u8 link_type, u8 addr_type, u8 status,
+					u8 opcode)
 {
 	struct pending_cmd *cmd;
 	struct mgmt_rp_user_confirm_reply rp;
@@ -2802,7 +2803,8 @@ static int user_pairing_resp_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	if (!cmd)
 		return -ENOENT;
 
-	bacpy(&rp.bdaddr, bdaddr);
+	bacpy(&rp.addr.bdaddr, bdaddr);
+	rp.addr.type = link_to_mgmt(link_type, addr_type);
 	rp.status = mgmt_status(status);
 	err = cmd_complete(cmd->sk, hdev->id, opcode, &rp, sizeof(rp));
 
@@ -2812,31 +2814,31 @@ static int user_pairing_resp_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 }
 
 int mgmt_user_confirm_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
-								u8 status)
+					u8 link_type, u8 addr_type, u8 status)
 {
-	return user_pairing_resp_complete(hdev, bdaddr, status,
-						MGMT_OP_USER_CONFIRM_REPLY);
+	return user_pairing_resp_complete(hdev, bdaddr, link_type, addr_type,
+					status, MGMT_OP_USER_CONFIRM_REPLY);
 }
 
-int mgmt_user_confirm_neg_reply_complete(struct hci_dev *hdev,
-						bdaddr_t *bdaddr, u8 status)
+int mgmt_user_confirm_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
+					u8 link_type, u8 addr_type, u8 status)
 {
-	return user_pairing_resp_complete(hdev, bdaddr, status,
-					MGMT_OP_USER_CONFIRM_NEG_REPLY);
+	return user_pairing_resp_complete(hdev, bdaddr, link_type, addr_type,
+					status, MGMT_OP_USER_CONFIRM_NEG_REPLY);
 }
 
 int mgmt_user_passkey_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
-								u8 status)
+					u8 link_type, u8 addr_type, u8 status)
 {
-	return user_pairing_resp_complete(hdev, bdaddr, status,
-						MGMT_OP_USER_PASSKEY_REPLY);
+	return user_pairing_resp_complete(hdev, bdaddr, link_type, addr_type,
+					status, MGMT_OP_USER_PASSKEY_REPLY);
 }
 
-int mgmt_user_passkey_neg_reply_complete(struct hci_dev *hdev,
-						bdaddr_t *bdaddr, u8 status)
+int mgmt_user_passkey_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
+					u8 link_type, u8 addr_type, u8 status)
 {
-	return user_pairing_resp_complete(hdev, bdaddr, status,
-					MGMT_OP_USER_PASSKEY_NEG_REPLY);
+	return user_pairing_resp_complete(hdev, bdaddr, link_type, addr_type,
+					status, MGMT_OP_USER_PASSKEY_NEG_REPLY);
 }
 
 int mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 status)
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 0563f73..589766d 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -349,9 +349,11 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 	hci_dev_lock(hcon->hdev);
 
 	if (method == REQ_PASSKEY)
-		ret = mgmt_user_passkey_request(hcon->hdev, conn->dst);
+		ret = mgmt_user_passkey_request(hcon->hdev, conn->dst,
+						hcon->type, hcon->dst_type);
 	else
 		ret = mgmt_user_confirm_request(hcon->hdev, conn->dst,
+						hcon->type, hcon->dst_type,
 						cpu_to_le32(passkey), 0);
 
 	hci_dev_unlock(hcon->hdev);
-- 
1.7.9

