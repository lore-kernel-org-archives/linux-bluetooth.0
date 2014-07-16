Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Convert HCI_CONN_MASTER flag to a conn->role variable
Date: Wed, 16 Jul 2014 11:42:27 +0300
Message-Id: <1405500148-12370-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1405500148-12370-1-git-send-email-johan.hedberg@gmail.com>
References: <1405500148-12370-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Having a dedicated u8 role variable in the hci_conn struct greatly
simplifies tracking of the role, since this is the native way that it's
represented on the HCI level.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/hci_conn.c         | 13 ++++++-------
 net/bluetooth/hci_event.c        | 27 +++++++++------------------
 net/bluetooth/l2cap_core.c       |  4 ++--
 net/bluetooth/smp.c              | 12 ++++++------
 5 files changed, 24 insertions(+), 34 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b52c2ef3f56d..e335c5fd8824 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -371,6 +371,7 @@ struct hci_conn {
 	__u16		state;
 	__u8		mode;
 	__u8		type;
+	__u8		role;
 	bool		out;
 	__u8		attempt;
 	__u8		dev_class[3];
@@ -540,7 +541,6 @@ enum {
 	HCI_CONN_POWER_SAVE,
 	HCI_CONN_REMOTE_OOB,
 	HCI_CONN_FLUSH_KEY,
-	HCI_CONN_MASTER,
 	HCI_CONN_ENCRYPT,
 	HCI_CONN_AUTH,
 	HCI_CONN_SECURE,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 490ee8846d9e..6c1c5048984c 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -66,8 +66,7 @@ static void hci_acl_create_connection(struct hci_conn *conn)
 
 	conn->state = BT_CONNECT;
 	conn->out = true;
-
-	set_bit(HCI_CONN_MASTER, &conn->flags);
+	conn->role = HCI_ROLE_MASTER;
 
 	conn->attempt++;
 
@@ -335,7 +334,7 @@ static void hci_conn_timeout(struct work_struct *work)
 			 * event handling and hci_clock_offset_evt function.
 			 */
 			if (conn->type == ACL_LINK &&
-			    test_bit(HCI_CONN_MASTER, &conn->flags)) {
+			    conn->role == HCI_ROLE_MASTER) {
 				struct hci_dev *hdev = conn->hdev;
 				struct hci_cp_read_clock_offset cp;
 
@@ -786,8 +785,8 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 		goto create_conn;
 	}
 
-	conn->out = true;
-	set_bit(HCI_CONN_MASTER, &conn->flags);
+	conn->out  = true;
+	conn->role = HCI_ROLE_MASTER;
 
 	params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
 	if (params) {
@@ -1076,7 +1075,7 @@ int hci_conn_switch_role(struct hci_conn *conn, __u8 role)
 {
 	BT_DBG("hcon %p", conn);
 
-	if (!role && test_bit(HCI_CONN_MASTER, &conn->flags))
+	if (role == conn->role)
 		return 1;
 
 	if (!test_and_set_bit(HCI_CONN_RSWITCH_PEND, &conn->flags)) {
@@ -1151,7 +1150,7 @@ static u32 get_link_mode(struct hci_conn *conn)
 {
 	u32 link_mode = 0;
 
-	if (test_bit(HCI_CONN_MASTER, &conn->flags))
+	if (conn->role == HCI_ROLE_MASTER)
 		link_mode |= HCI_LM_MASTER;
 
 	if (test_bit(HCI_CONN_ENCRYPT, &conn->flags))
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 13f83c48face..3b1d2dadedc8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -101,12 +101,8 @@ static void hci_cc_role_discovery(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(rp->handle));
-	if (conn) {
-		if (rp->role)
-			clear_bit(HCI_CONN_MASTER, &conn->flags);
-		else
-			set_bit(HCI_CONN_MASTER, &conn->flags);
-	}
+	if (conn)
+		conn->role = rp->role;
 
 	hci_dev_unlock(hdev);
 }
@@ -1420,8 +1416,8 @@ static void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
 		if (!conn) {
 			conn = hci_conn_add(hdev, ACL_LINK, &cp->bdaddr);
 			if (conn) {
-				conn->out = true;
-				set_bit(HCI_CONN_MASTER, &conn->flags);
+				conn->out  = true;
+				conn->role = HCI_ROLE_MASTER;
 			} else
 				BT_ERR("No memory for new connection");
 		}
@@ -2924,12 +2920,8 @@ static void hci_role_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
 	if (conn) {
-		if (!ev->status) {
-			if (ev->role)
-				clear_bit(HCI_CONN_MASTER, &conn->flags);
-			else
-				set_bit(HCI_CONN_MASTER, &conn->flags);
-		}
+		if (!ev->status)
+			conn->role = ev->role;
 
 		clear_bit(HCI_CONN_RSWITCH_PEND, &conn->flags);
 
@@ -4116,10 +4108,9 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 		conn->dst_type = ev->bdaddr_type;
 
-		if (ev->role == HCI_ROLE_MASTER) {
+		conn->role = ev->role;
+		if (conn->role == HCI_ROLE_MASTER)
 			conn->out = true;
-			set_bit(HCI_CONN_MASTER, &conn->flags);
-		}
 
 		/* If we didn't have a hci_conn object previously
 		 * but we're in master role this must be something
@@ -4527,7 +4518,7 @@ static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev,
 		return send_conn_param_neg_reply(hdev, handle,
 						 HCI_ERROR_INVALID_LL_PARAMS);
 
-	if (test_bit(HCI_CONN_MASTER, &hcon->flags)) {
+	if (hcon->role == HCI_ROLE_MASTER) {
 		struct hci_conn_params *params;
 		u8 store_hint;
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 8538cb07b0c0..ea68d3219b7e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1487,7 +1487,7 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 	 * been configured for this connection. If not, then trigger
 	 * the connection update procedure.
 	 */
-	if (!test_bit(HCI_CONN_MASTER, &hcon->flags) &&
+	if (hcon->role == HCI_ROLE_SLAVE &&
 	    (hcon->le_conn_interval < hcon->le_conn_min_interval ||
 	     hcon->le_conn_interval > hcon->le_conn_max_interval)) {
 		struct l2cap_conn_param_update_req req;
@@ -5227,7 +5227,7 @@ static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
 	u16 min, max, latency, to_multiplier;
 	int err;
 
-	if (!test_bit(HCI_CONN_MASTER, &hcon->flags))
+	if (hcon->role != HCI_ROLE_MASTER)
 		return -EINVAL;
 
 	if (cmd_len != sizeof(struct l2cap_conn_param_update_req))
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 8339d6b0f2b8..78eeb8b5970a 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -445,7 +445,7 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 	 * Confirms and the slave Enters the passkey.
 	 */
 	if (method == OVERLAP) {
-		if (test_bit(HCI_CONN_MASTER, &hcon->flags))
+		if (hcon->role == HCI_ROLE_MASTER)
 			method = CFM_PASSKEY;
 		else
 			method = REQ_PASSKEY;
@@ -686,7 +686,7 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (skb->len < sizeof(*req))
 		return SMP_INVALID_PARAMS;
 
-	if (test_bit(HCI_CONN_MASTER, &conn->hcon->flags))
+	if (conn->hcon->role != HCI_ROLE_SLAVE)
 		return SMP_CMD_NOTSUPP;
 
 	if (!test_and_set_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->flags))
@@ -755,7 +755,7 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (skb->len < sizeof(*rsp))
 		return SMP_INVALID_PARAMS;
 
-	if (!test_bit(HCI_CONN_MASTER, &conn->hcon->flags))
+	if (conn->hcon->role != HCI_ROLE_MASTER)
 		return SMP_CMD_NOTSUPP;
 
 	skb_pull(skb, sizeof(*rsp));
@@ -903,7 +903,7 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (skb->len < sizeof(*rp))
 		return SMP_INVALID_PARAMS;
 
-	if (!test_bit(HCI_CONN_MASTER, &conn->hcon->flags))
+	if (hcon->role != HCI_ROLE_MASTER)
 		return SMP_CMD_NOTSUPP;
 
 	sec_level = authreq_to_seclevel(rp->auth_req);
@@ -961,7 +961,7 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 	if (sec_level > hcon->pending_sec_level)
 		hcon->pending_sec_level = sec_level;
 
-	if (test_bit(HCI_CONN_MASTER, &hcon->flags))
+	if (hcon->role == HCI_ROLE_MASTER)
 		if (smp_ltk_encrypt(conn, hcon->pending_sec_level))
 			return 0;
 
@@ -981,7 +981,7 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 	    hcon->pending_sec_level > BT_SECURITY_MEDIUM)
 		authreq |= SMP_AUTH_MITM;
 
-	if (test_bit(HCI_CONN_MASTER, &hcon->flags)) {
+	if (hcon->role == HCI_ROLE_MASTER) {
 		struct smp_cmd_pairing cp;
 
 		build_pairing_cmd(conn, &cp, NULL, authreq);
-- 
1.9.3

