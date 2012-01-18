Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 08/15] Bluetooth: Rename conn->pend to conn->flags
Date: Wed, 18 Jan 2012 20:51:50 +0200
Message-Id: <1326912717-6347-9-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
References: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

These flags can and will be used for more general purpose values than
just pending state transitions so the more common name "flags" makes
more sense than "pend".

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    6 +++---
 net/bluetooth/hci_conn.c         |   20 ++++++++++----------
 net/bluetooth/hci_event.c        |   36 ++++++++++++++++++------------------
 net/bluetooth/l2cap_core.c       |    2 +-
 net/bluetooth/smp.c              |   19 +++++++++----------
 5 files changed, 41 insertions(+), 42 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 02aa0f9..c8ae176 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -300,7 +300,7 @@ struct hci_conn {
 	__u8		io_capability;
 	__u8		power_save;
 	__u16		disc_timeout;
-	unsigned long	pend;
+	unsigned long	flags;
 
 	__u8		remote_cap;
 	__u8		remote_oob;
@@ -764,7 +764,7 @@ static inline void hci_proto_auth_cfm(struct hci_conn *conn, __u8 status)
 	if (conn->type != ACL_LINK && conn->type != LE_LINK)
 		return;
 
-	if (test_bit(HCI_CONN_ENCRYPT_PEND, &conn->pend))
+	if (test_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags))
 		return;
 
 	encrypt = (conn->link_mode & HCI_LM_ENCRYPT) ? 0x01 : 0x00;
@@ -805,7 +805,7 @@ static inline void hci_auth_cfm(struct hci_conn *conn, __u8 status)
 
 	hci_proto_auth_cfm(conn, status);
 
-	if (test_bit(HCI_CONN_ENCRYPT_PEND, &conn->pend))
+	if (test_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags))
 		return;
 
 	encrypt = (conn->link_mode & HCI_LM_ENCRYPT) ? 0x01 : 0x00;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 3db4324..8a4678a 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -337,7 +337,7 @@ static void hci_conn_enter_sniff_mode(struct hci_conn *conn)
 		hci_send_cmd(hdev, HCI_OP_SNIFF_SUBRATE, sizeof(cp), &cp);
 	}
 
-	if (!test_and_set_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->pend)) {
+	if (!test_and_set_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->flags)) {
 		struct hci_cp_sniff_mode cp;
 		cp.handle       = cpu_to_le16(conn->handle);
 		cp.max_interval = cpu_to_le16(hdev->sniff_max_interval);
@@ -589,9 +589,9 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 		acl->power_save = 1;
 		hci_conn_enter_active_mode(acl, BT_POWER_FORCE_ACTIVE_ON);
 
-		if (test_bit(HCI_CONN_MODE_CHANGE_PEND, &acl->pend)) {
+		if (test_bit(HCI_CONN_MODE_CHANGE_PEND, &acl->flags)) {
 			/* defer SCO setup until mode change completed */
-			set_bit(HCI_CONN_SCO_SETUP_PEND, &acl->pend);
+			set_bit(HCI_CONN_SCO_SETUP_PEND, &acl->flags);
 			return sco;
 		}
 
@@ -633,13 +633,13 @@ static int hci_conn_auth(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
 
 	conn->auth_type = auth_type;
 
-	if (!test_and_set_bit(HCI_CONN_AUTH_PEND, &conn->pend)) {
+	if (!test_and_set_bit(HCI_CONN_AUTH_PEND, &conn->flags)) {
 		struct hci_cp_auth_requested cp;
 		cp.handle = cpu_to_le16(conn->handle);
 		hci_send_cmd(conn->hdev, HCI_OP_AUTH_REQUESTED,
 							sizeof(cp), &cp);
 		if (conn->key_type != 0xff)
-			set_bit(HCI_CONN_REAUTH_PEND, &conn->pend);
+			set_bit(HCI_CONN_REAUTH_PEND, &conn->flags);
 	}
 
 	return 0;
@@ -650,7 +650,7 @@ static void hci_conn_encrypt(struct hci_conn *conn)
 {
 	BT_DBG("conn %p", conn);
 
-	if (!test_and_set_bit(HCI_CONN_ENCRYPT_PEND, &conn->pend)) {
+	if (!test_and_set_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags)) {
 		struct hci_cp_set_conn_encrypt cp;
 		cp.handle  = cpu_to_le16(conn->handle);
 		cp.encrypt = 0x01;
@@ -700,7 +700,7 @@ int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
 		goto encrypt;
 
 auth:
-	if (test_bit(HCI_CONN_ENCRYPT_PEND, &conn->pend))
+	if (test_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags))
 		return 0;
 
 	if (!hci_conn_auth(conn, sec_level, auth_type))
@@ -735,7 +735,7 @@ int hci_conn_change_link_key(struct hci_conn *conn)
 {
 	BT_DBG("conn %p", conn);
 
-	if (!test_and_set_bit(HCI_CONN_AUTH_PEND, &conn->pend)) {
+	if (!test_and_set_bit(HCI_CONN_AUTH_PEND, &conn->flags)) {
 		struct hci_cp_change_conn_link_key cp;
 		cp.handle = cpu_to_le16(conn->handle);
 		hci_send_cmd(conn->hdev, HCI_OP_CHANGE_CONN_LINK_KEY,
@@ -754,7 +754,7 @@ int hci_conn_switch_role(struct hci_conn *conn, __u8 role)
 	if (!role && conn->link_mode & HCI_LM_MASTER)
 		return 1;
 
-	if (!test_and_set_bit(HCI_CONN_RSWITCH_PEND, &conn->pend)) {
+	if (!test_and_set_bit(HCI_CONN_RSWITCH_PEND, &conn->flags)) {
 		struct hci_cp_switch_role cp;
 		bacpy(&cp.bdaddr, &conn->dst);
 		cp.role = role;
@@ -781,7 +781,7 @@ void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active)
 	if (!conn->power_save && !force_active)
 		goto timer;
 
-	if (!test_and_set_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->pend)) {
+	if (!test_and_set_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->flags)) {
 		struct hci_cp_exit_sniff_mode cp;
 		cp.handle = cpu_to_le16(conn->handle);
 		hci_send_cmd(hdev, HCI_OP_EXIT_SNIFF_MODE, sizeof(cp), &cp);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a50e857..373ae73 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1344,7 +1344,7 @@ static void hci_cs_remote_name_req(struct hci_dev *hdev, __u8 status)
 	if (!hci_outgoing_auth_needed(hdev, conn))
 		goto unlock;
 
-	if (!test_and_set_bit(HCI_CONN_AUTH_PEND, &conn->pend)) {
+	if (!test_and_set_bit(HCI_CONN_AUTH_PEND, &conn->flags)) {
 		struct hci_cp_auth_requested cp;
 		cp.handle = __cpu_to_le16(conn->handle);
 		hci_send_cmd(hdev, HCI_OP_AUTH_REQUESTED, sizeof(cp), &cp);
@@ -1461,9 +1461,9 @@ static void hci_cs_sniff_mode(struct hci_dev *hdev, __u8 status)
 
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(cp->handle));
 	if (conn) {
-		clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->pend);
+		clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->flags);
 
-		if (test_and_clear_bit(HCI_CONN_SCO_SETUP_PEND, &conn->pend))
+		if (test_and_clear_bit(HCI_CONN_SCO_SETUP_PEND, &conn->flags))
 			hci_sco_setup(conn, status);
 	}
 
@@ -1488,9 +1488,9 @@ static void hci_cs_exit_sniff_mode(struct hci_dev *hdev, __u8 status)
 
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(cp->handle));
 	if (conn) {
-		clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->pend);
+		clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->flags);
 
-		if (test_and_clear_bit(HCI_CONN_SCO_SETUP_PEND, &conn->pend))
+		if (test_and_clear_bit(HCI_CONN_SCO_SETUP_PEND, &conn->flags))
 			hci_sco_setup(conn, status);
 	}
 
@@ -1817,7 +1817,7 @@ static inline void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *s
 
 	if (!ev->status) {
 		if (!(conn->ssp_mode > 0 && hdev->ssp_mode > 0) &&
-				test_bit(HCI_CONN_REAUTH_PEND,	&conn->pend)) {
+				test_bit(HCI_CONN_REAUTH_PEND,	&conn->flags)) {
 			BT_INFO("re-auth of legacy device is not possible.");
 		} else {
 			conn->link_mode |= HCI_LM_AUTH;
@@ -1827,8 +1827,8 @@ static inline void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *s
 		mgmt_auth_failed(hdev, &conn->dst, ev->status);
 	}
 
-	clear_bit(HCI_CONN_AUTH_PEND, &conn->pend);
-	clear_bit(HCI_CONN_REAUTH_PEND, &conn->pend);
+	clear_bit(HCI_CONN_AUTH_PEND, &conn->flags);
+	clear_bit(HCI_CONN_REAUTH_PEND, &conn->flags);
 
 	if (conn->state == BT_CONFIG) {
 		if (!ev->status && hdev->ssp_mode > 0 && conn->ssp_mode > 0) {
@@ -1850,7 +1850,7 @@ static inline void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *s
 		hci_conn_put(conn);
 	}
 
-	if (test_bit(HCI_CONN_ENCRYPT_PEND, &conn->pend)) {
+	if (test_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags)) {
 		if (!ev->status) {
 			struct hci_cp_set_conn_encrypt cp;
 			cp.handle  = ev->handle;
@@ -1858,7 +1858,7 @@ static inline void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *s
 			hci_send_cmd(hdev, HCI_OP_SET_CONN_ENCRYPT, sizeof(cp),
 									&cp);
 		} else {
-			clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->pend);
+			clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
 			hci_encrypt_cfm(conn, ev->status, 0x00);
 		}
 	}
@@ -1892,7 +1892,7 @@ static inline void hci_remote_name_evt(struct hci_dev *hdev, struct sk_buff *skb
 	if (!hci_outgoing_auth_needed(hdev, conn))
 		goto unlock;
 
-	if (!test_and_set_bit(HCI_CONN_AUTH_PEND, &conn->pend)) {
+	if (!test_and_set_bit(HCI_CONN_AUTH_PEND, &conn->flags)) {
 		struct hci_cp_auth_requested cp;
 		cp.handle = __cpu_to_le16(conn->handle);
 		hci_send_cmd(hdev, HCI_OP_AUTH_REQUESTED, sizeof(cp), &cp);
@@ -1923,7 +1923,7 @@ static inline void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *
 				conn->link_mode &= ~HCI_LM_ENCRYPT;
 		}
 
-		clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->pend);
+		clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
 
 		if (conn->state == BT_CONFIG) {
 			if (!ev->status)
@@ -1952,7 +1952,7 @@ static inline void hci_change_link_key_complete_evt(struct hci_dev *hdev, struct
 		if (!ev->status)
 			conn->link_mode |= HCI_LM_SECURE;
 
-		clear_bit(HCI_CONN_AUTH_PEND, &conn->pend);
+		clear_bit(HCI_CONN_AUTH_PEND, &conn->flags);
 
 		hci_key_change_cfm(conn, ev->status);
 	}
@@ -2336,7 +2336,7 @@ static inline void hci_role_change_evt(struct hci_dev *hdev, struct sk_buff *skb
 				conn->link_mode |= HCI_LM_MASTER;
 		}
 
-		clear_bit(HCI_CONN_RSWITCH_PEND, &conn->pend);
+		clear_bit(HCI_CONN_RSWITCH_PEND, &conn->flags);
 
 		hci_role_switch_cfm(conn, ev->status, ev->role);
 	}
@@ -2474,14 +2474,14 @@ static inline void hci_mode_change_evt(struct hci_dev *hdev, struct sk_buff *skb
 		conn->mode = ev->mode;
 		conn->interval = __le16_to_cpu(ev->interval);
 
-		if (!test_and_clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->pend)) {
+		if (!test_and_clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->flags)) {
 			if (conn->mode == HCI_CM_ACTIVE)
 				conn->power_save = 1;
 			else
 				conn->power_save = 0;
 		}
 
-		if (test_and_clear_bit(HCI_CONN_SCO_SETUP_PEND, &conn->pend))
+		if (test_and_clear_bit(HCI_CONN_SCO_SETUP_PEND, &conn->flags))
 			hci_sco_setup(conn, ev->status);
 	}
 
@@ -3013,7 +3013,7 @@ static inline void hci_user_confirm_request_evt(struct hci_dev *hdev,
 		/* If we're not the initiators request authorization to
 		 * proceed from user space (mgmt_user_confirm with
 		 * confirm_hint set to 1). */
-		if (!test_bit(HCI_CONN_AUTH_PEND, &conn->pend)) {
+		if (!test_bit(HCI_CONN_AUTH_PEND, &conn->flags)) {
 			BT_DBG("Confirming auto-accept as acceptor");
 			confirm_hint = 1;
 			goto confirm;
@@ -3074,7 +3074,7 @@ static inline void hci_simple_pair_complete_evt(struct hci_dev *hdev, struct sk_
 	 * initiated the authentication. A traditional auth_complete
 	 * event gets always produced as initiator and is also mapped to
 	 * the mgmt_auth_failed event */
-	if (!test_bit(HCI_CONN_AUTH_PEND, &conn->pend) && ev->status != 0)
+	if (!test_bit(HCI_CONN_AUTH_PEND, &conn->flags) && ev->status != 0)
 		mgmt_auth_failed(hdev, &conn->dst, ev->status);
 
 	hci_conn_put(conn);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 0087db8..e42999c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1020,7 +1020,7 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
 		__cancel_delayed_work(&conn->info_timer);
 
-	if (test_and_clear_bit(HCI_CONN_LE_SMP_PEND, &hcon->pend)) {
+	if (test_and_clear_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags)) {
 		__cancel_delayed_work(&conn->security_timer);
 		smp_chan_destroy(conn);
 	}
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 65a9024..e08fe6c 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -261,7 +261,7 @@ static void smp_failure(struct l2cap_conn *conn, u8 reason, u8 send)
 		smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, sizeof(reason),
 								&reason);
 
-	clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->hcon->pend);
+	clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->hcon->flags);
 	mgmt_auth_failed(conn->hcon->hdev, conn->dst, reason);
 	cancel_delayed_work_sync(&conn->security_timer);
 	smp_chan_destroy(conn);
@@ -449,7 +449,7 @@ static void random_work(struct work_struct *work)
 		memset(stk + smp->smp_key_size, 0,
 				SMP_MAX_ENC_KEY_SIZE - smp->smp_key_size);
 
-		if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND, &hcon->pend)) {
+		if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND, &hcon->flags)) {
 			reason = SMP_UNSPECIFIED;
 			goto error;
 		}
@@ -506,7 +506,7 @@ void smp_chan_destroy(struct l2cap_conn *conn)
 {
 	struct smp_chan *smp = conn->smp_chan;
 
-	clear_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->pend);
+	clear_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->flags);
 
 	if (smp->tfm)
 		crypto_free_blkcipher(smp->tfm);
@@ -571,7 +571,7 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (conn->hcon->link_mode & HCI_LM_MASTER)
 		return SMP_CMD_NOTSUPP;
 
-	if (!test_and_set_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->pend))
+	if (!test_and_set_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->flags))
 		smp = smp_chan_create(conn);
 
 	smp = conn->smp_chan;
@@ -707,8 +707,7 @@ static u8 smp_ltk_encrypt(struct l2cap_conn *conn)
 	if (!key)
 		return 0;
 
-	if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND,
-					&hcon->pend))
+	if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND, &hcon->flags))
 		return 1;
 
 	master = (void *) key->data;
@@ -733,7 +732,7 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (smp_ltk_encrypt(conn))
 		return 0;
 
-	if (test_and_set_bit(HCI_CONN_LE_SMP_PEND, &hcon->pend))
+	if (test_and_set_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags))
 		return 0;
 
 	smp = smp_chan_create(conn);
@@ -772,7 +771,7 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 		if (smp_ltk_encrypt(conn))
 			goto done;
 
-	if (test_and_set_bit(HCI_CONN_LE_SMP_PEND, &hcon->pend))
+	if (test_and_set_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags))
 		return 0;
 
 	smp = smp_chan_create(conn);
@@ -908,7 +907,7 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 
 	BT_DBG("conn %p force %d", conn, force);
 
-	if (!test_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->pend))
+	if (!test_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->flags))
 		return 0;
 
 	rsp = (void *) &smp->prsp[1];
@@ -982,7 +981,7 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 	}
 
 	if (conn->hcon->out || force) {
-		clear_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->pend);
+		clear_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->flags);
 		cancel_delayed_work_sync(&conn->security_timer);
 		smp_chan_destroy(conn);
 	}
-- 
1.7.8.3

