Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluteooth: Convert hci_conn->link_mode into flags
Date: Tue, 24 Jun 2014 16:59:15 +0300
Message-Id: <1403618355-5882-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Since the link_mode member of the hci_conn struct is a bit field and we
already have a flags member as well it makes sense to merge these two
together. This patch moves all used link_mode bits into corresponding
flags. To keep backwards compatibility with user space we still need to
provide a get_link_mode() helper function for the ioctl's that expect a
link_mode style value.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 10 +++++++---
 net/bluetooth/hci_conn.c         | 43 ++++++++++++++++++++++++++++++----------
 net/bluetooth/hci_event.c        | 28 +++++++++++++-------------
 net/bluetooth/l2cap_core.c       |  4 ++--
 net/bluetooth/smp.c              | 12 +++++------
 5 files changed, 62 insertions(+), 35 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4f70605e0399..0b0597d81827 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -367,7 +367,6 @@ struct hci_conn {
 	__u8		features[HCI_MAX_PAGES][8];
 	__u16		pkt_type;
 	__u16		link_policy;
-	__u32		link_mode;
 	__u8		key_type;
 	__u8		auth_type;
 	__u8		sec_level;
@@ -524,6 +523,11 @@ enum {
 	HCI_CONN_POWER_SAVE,
 	HCI_CONN_REMOTE_OOB,
 	HCI_CONN_FLUSH_KEY,
+	HCI_CONN_MASTER,
+	HCI_CONN_ENCRYPT,
+	HCI_CONN_AUTH,
+	HCI_CONN_SECURE,
+	HCI_CONN_FIPS,
 };
 
 static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
@@ -1025,7 +1029,7 @@ static inline void hci_proto_auth_cfm(struct hci_conn *conn, __u8 status)
 	if (test_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags))
 		return;
 
-	encrypt = (conn->link_mode & HCI_LM_ENCRYPT) ? 0x01 : 0x00;
+	encrypt = test_bit(HCI_CONN_ENCRYPT, &conn->flags) ? 0x01 : 0x00;
 	l2cap_security_cfm(conn, status, encrypt);
 
 	if (conn->security_cfm_cb)
@@ -1066,7 +1070,7 @@ static inline void hci_auth_cfm(struct hci_conn *conn, __u8 status)
 	if (test_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags))
 		return;
 
-	encrypt = (conn->link_mode & HCI_LM_ENCRYPT) ? 0x01 : 0x00;
+	encrypt = test_bit(HCI_CONN_ENCRYPT, &conn->flags) ? 0x01 : 0x00;
 
 	read_lock(&hci_cb_list_lock);
 	list_for_each_entry(cb, &hci_cb_list, list) {
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index a7a27bc2c0b1..afa30d6a31a9 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -67,7 +67,7 @@ static void hci_acl_create_connection(struct hci_conn *conn)
 	conn->state = BT_CONNECT;
 	conn->out = true;
 
-	conn->link_mode = HCI_LM_MASTER;
+	set_bit(HCI_CONN_MASTER, &conn->flags);
 
 	conn->attempt++;
 
@@ -743,7 +743,7 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	}
 
 	conn->out = true;
-	conn->link_mode |= HCI_LM_MASTER;
+	set_bit(HCI_CONN_MASTER, &conn->flags);
 
 	params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
 	if (params) {
@@ -865,7 +865,8 @@ int hci_conn_check_link_mode(struct hci_conn *conn)
 			return 0;
 	}
 
-	if (hci_conn_ssp_enabled(conn) && !(conn->link_mode & HCI_LM_ENCRYPT))
+	if (hci_conn_ssp_enabled(conn) &&
+	    !test_bit(HCI_CONN_ENCRYPT, &conn->flags))
 		return 0;
 
 	return 1;
@@ -881,7 +882,7 @@ static int hci_conn_auth(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
 
 	if (sec_level > conn->sec_level)
 		conn->pending_sec_level = sec_level;
-	else if (conn->link_mode & HCI_LM_AUTH)
+	else if (test_bit(HCI_CONN_AUTH, &conn->flags))
 		return 1;
 
 	/* Make sure we preserve an existing MITM requirement*/
@@ -899,7 +900,7 @@ static int hci_conn_auth(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
 		/* If we're already encrypted set the REAUTH_PEND flag,
 		 * otherwise set the ENCRYPT_PEND.
 		 */
-		if (conn->link_mode & HCI_LM_ENCRYPT)
+		if (test_bit(HCI_CONN_ENCRYPT, &conn->flags))
 			set_bit(HCI_CONN_REAUTH_PEND, &conn->flags);
 		else
 			set_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
@@ -940,7 +941,7 @@ int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
 		return 1;
 
 	/* For other security levels we need the link key. */
-	if (!(conn->link_mode & HCI_LM_AUTH))
+	if (!test_bit(HCI_CONN_AUTH, &conn->flags))
 		goto auth;
 
 	/* An authenticated FIPS approved combination key has sufficient
@@ -980,7 +981,7 @@ auth:
 		return 0;
 
 encrypt:
-	if (conn->link_mode & HCI_LM_ENCRYPT)
+	if (test_bit(HCI_CONN_ENCRYPT, &conn->flags))
 		return 1;
 
 	hci_conn_encrypt(conn);
@@ -1027,7 +1028,7 @@ int hci_conn_switch_role(struct hci_conn *conn, __u8 role)
 {
 	BT_DBG("hcon %p", conn);
 
-	if (!role && conn->link_mode & HCI_LM_MASTER)
+	if (!role && test_bit(HCI_CONN_MASTER, &conn->flags))
 		return 1;
 
 	if (!test_and_set_bit(HCI_CONN_RSWITCH_PEND, &conn->flags)) {
@@ -1101,6 +1102,28 @@ void hci_conn_check_pending(struct hci_dev *hdev)
 	hci_dev_unlock(hdev);
 }
 
+static u32 get_link_mode(struct hci_conn *conn)
+{
+	u8 link_mode = 0;
+
+	if (test_bit(HCI_CONN_MASTER, &conn->flags))
+		link_mode |= HCI_LM_MASTER;
+
+	if (test_bit(HCI_CONN_ENCRYPT, &conn->flags))
+		link_mode |= HCI_LM_ENCRYPT;
+
+	if (test_bit(HCI_CONN_AUTH, &conn->flags))
+		link_mode |= HCI_LM_AUTH;
+
+	if (test_bit(HCI_CONN_SECURE, &conn->flags))
+		link_mode |= HCI_LM_SECURE;
+
+	if (test_bit(HCI_CONN_FIPS, &conn->flags))
+		link_mode |= HCI_LM_FIPS;
+
+	return link_mode;
+}
+
 int hci_get_conn_list(void __user *arg)
 {
 	struct hci_conn *c;
@@ -1136,7 +1159,7 @@ int hci_get_conn_list(void __user *arg)
 		(ci + n)->type  = c->type;
 		(ci + n)->out   = c->out;
 		(ci + n)->state = c->state;
-		(ci + n)->link_mode = c->link_mode;
+		(ci + n)->link_mode = get_link_mode(c);
 		if (++n >= req.conn_num)
 			break;
 	}
@@ -1172,7 +1195,7 @@ int hci_get_conn_info(struct hci_dev *hdev, void __user *arg)
 		ci.type  = conn->type;
 		ci.out   = conn->out;
 		ci.state = conn->state;
-		ci.link_mode = conn->link_mode;
+		ci.link_mode = get_link_mode(conn);
 	}
 	hci_dev_unlock(hdev);
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 90cba6a8293b..7a23324eac39 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -103,9 +103,9 @@ static void hci_cc_role_discovery(struct hci_dev *hdev, struct sk_buff *skb)
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(rp->handle));
 	if (conn) {
 		if (rp->role)
-			conn->link_mode &= ~HCI_LM_MASTER;
+			clear_bit(HCI_CONN_MASTER, &conn->flags);
 		else
-			conn->link_mode |= HCI_LM_MASTER;
+			set_bit(HCI_CONN_MASTER, &conn->flags);
 	}
 
 	hci_dev_unlock(hdev);
@@ -1346,7 +1346,7 @@ static void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
 			conn = hci_conn_add(hdev, ACL_LINK, &cp->bdaddr);
 			if (conn) {
 				conn->out = true;
-				conn->link_mode |= HCI_LM_MASTER;
+				set_bit(HCI_CONN_MASTER, &conn->flags);
 			} else
 				BT_ERR("No memory for new connection");
 		}
@@ -1989,10 +1989,10 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_conn_add_sysfs(conn);
 
 		if (test_bit(HCI_AUTH, &hdev->flags))
-			conn->link_mode |= HCI_LM_AUTH;
+			set_bit(HCI_CONN_AUTH, &conn->flags);
 
 		if (test_bit(HCI_ENCRYPT, &hdev->flags))
-			conn->link_mode |= HCI_LM_ENCRYPT;
+			set_bit(HCI_CONN_ENCRYPT, &conn->flags);
 
 		/* Get remote features */
 		if (conn->type == ACL_LINK) {
@@ -2220,7 +2220,7 @@ static void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		    test_bit(HCI_CONN_REAUTH_PEND, &conn->flags)) {
 			BT_INFO("re-auth of legacy device is not possible.");
 		} else {
-			conn->link_mode |= HCI_LM_AUTH;
+			set_bit(HCI_CONN_AUTH, &conn->flags);
 			conn->sec_level = conn->pending_sec_level;
 		}
 	} else {
@@ -2323,19 +2323,19 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!ev->status) {
 		if (ev->encrypt) {
 			/* Encryption implies authentication */
-			conn->link_mode |= HCI_LM_AUTH;
-			conn->link_mode |= HCI_LM_ENCRYPT;
+			set_bit(HCI_CONN_AUTH, &conn->flags);
+			set_bit(HCI_CONN_ENCRYPT, &conn->flags);
 			conn->sec_level = conn->pending_sec_level;
 
 			/* P-256 authentication key implies FIPS */
 			if (conn->key_type == HCI_LK_AUTH_COMBINATION_P256)
-				conn->link_mode |= HCI_LM_FIPS;
+				set_bit(HCI_CONN_FIPS, &conn->flags);
 
 			if ((conn->type == ACL_LINK && ev->encrypt == 0x02) ||
 			    conn->type == LE_LINK)
 				set_bit(HCI_CONN_AES_CCM, &conn->flags);
 		} else {
-			conn->link_mode &= ~HCI_LM_ENCRYPT;
+			clear_bit(HCI_CONN_ENCRYPT, &conn->flags);
 			clear_bit(HCI_CONN_AES_CCM, &conn->flags);
 		}
 	}
@@ -2386,7 +2386,7 @@ static void hci_change_link_key_complete_evt(struct hci_dev *hdev,
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
 	if (conn) {
 		if (!ev->status)
-			conn->link_mode |= HCI_LM_SECURE;
+			set_bit(HCI_CONN_SECURE, &conn->flags);
 
 		clear_bit(HCI_CONN_AUTH_PEND, &conn->flags);
 
@@ -2828,9 +2828,9 @@ static void hci_role_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (conn) {
 		if (!ev->status) {
 			if (ev->role)
-				conn->link_mode &= ~HCI_LM_MASTER;
+				clear_bit(HCI_CONN_MASTER, &conn->flags);
 			else
-				conn->link_mode |= HCI_LM_MASTER;
+				set_bit(HCI_CONN_MASTER, &conn->flags);
 		}
 
 		clear_bit(HCI_CONN_RSWITCH_PEND, &conn->flags);
@@ -4007,7 +4007,7 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 		if (ev->role == LE_CONN_ROLE_MASTER) {
 			conn->out = true;
-			conn->link_mode |= HCI_LM_MASTER;
+			set_bit(HCI_CONN_MASTER, &conn->flags);
 		}
 
 		/* If we didn't have a hci_conn object previously
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 565afb78296a..d015aa190fdc 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1486,7 +1486,7 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 	 * been configured for this connection. If not, then trigger
 	 * the connection update procedure.
 	 */
-	if (!(hcon->link_mode & HCI_LM_MASTER) &&
+	if (!test_bit(HCI_CONN_MASTER, &hcon->flags) &&
 	    (hcon->le_conn_interval < hcon->le_conn_min_interval ||
 	     hcon->le_conn_interval > hcon->le_conn_max_interval)) {
 		struct l2cap_conn_param_update_req req;
@@ -5244,7 +5244,7 @@ static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
 	u16 min, max, latency, to_multiplier;
 	int err;
 
-	if (!(hcon->link_mode & HCI_LM_MASTER))
+	if (!test_bit(HCI_CONN_MASTER, &hcon->flags))
 		return -EINVAL;
 
 	if (cmd_len != sizeof(struct l2cap_conn_param_update_req))
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 28f4ef48095b..976fce2315fd 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -435,7 +435,7 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 	 * Confirms and the slave Enters the passkey.
 	 */
 	if (method == OVERLAP) {
-		if (hcon->link_mode & HCI_LM_MASTER)
+		if (test_bit(HCI_CONN_MASTER, &hcon->flags))
 			method = CFM_PASSKEY;
 		else
 			method = REQ_PASSKEY;
@@ -683,7 +683,7 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (skb->len < sizeof(*req))
 		return SMP_INVALID_PARAMS;
 
-	if (conn->hcon->link_mode & HCI_LM_MASTER)
+	if (test_bit(HCI_CONN_MASTER, &conn->hcon->flags))
 		return SMP_CMD_NOTSUPP;
 
 	if (!test_and_set_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->flags))
@@ -750,7 +750,7 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (skb->len < sizeof(*rsp))
 		return SMP_INVALID_PARAMS;
 
-	if (!(conn->hcon->link_mode & HCI_LM_MASTER))
+	if (!test_bit(HCI_CONN_MASTER, &conn->hcon->flags))
 		return SMP_CMD_NOTSUPP;
 
 	skb_pull(skb, sizeof(*rsp));
@@ -873,7 +873,7 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (skb->len < sizeof(*rp))
 		return SMP_INVALID_PARAMS;
 
-	if (!(conn->hcon->link_mode & HCI_LM_MASTER))
+	if (!test_bit(HCI_CONN_MASTER, &conn->hcon->flags))
 		return SMP_CMD_NOTSUPP;
 
 	sec_level = authreq_to_seclevel(rp->auth_req);
@@ -937,7 +937,7 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 	if (sec_level > hcon->pending_sec_level)
 		hcon->pending_sec_level = sec_level;
 
-	if (hcon->link_mode & HCI_LM_MASTER)
+	if (test_bit(HCI_CONN_MASTER, &hcon->flags))
 		if (smp_ltk_encrypt(conn, hcon->pending_sec_level))
 			return 0;
 
@@ -957,7 +957,7 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 	    hcon->pending_sec_level > BT_SECURITY_MEDIUM)
 		authreq |= SMP_AUTH_MITM;
 
-	if (hcon->link_mode & HCI_LM_MASTER) {
+	if (test_bit(HCI_CONN_MASTER, &hcon->flags)) {
 		struct smp_cmd_pairing cp;
 
 		build_pairing_cmd(conn, &cp, NULL, authreq);
-- 
1.9.3

