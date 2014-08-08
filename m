Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: Convert SMP to use l2cap_chan infrastructure
Date: Fri,  8 Aug 2014 09:37:18 +0300
Message-Id: <1407479838-5652-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1407479838-5652-1-git-send-email-johan.hedberg@gmail.com>
References: <1407479838-5652-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Now that we have all the necessary pieces in place we can fully convert
SMP to use the L2CAP channel infrastructure. This patch adds the
necessary callbacks and removes the now unneeded conn->smp_chan pointer.

One notable behavioral change in this patch comes from the following
code snippet:

-       case L2CAP_CID_SMP:
-               if (smp_sig_channel(conn, skb))
-                       l2cap_conn_del(conn->hcon, EACCES);

This piece of code was essentially forcing a disconnection if garbage
SMP data was received. The l2cap_conn_del() function is private to
l2cap_conn.c so we don't have access to it anymore when using the L2CAP
channel callbacks. Therefore, the behavior of the new code is simply to
return errors in the recv() callback (which is simply the old
smp_sig_channel()), but no disconnection will occur.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/l2cap.h |   1 -
 net/bluetooth/l2cap_core.c    |  10 ----
 net/bluetooth/smp.c           | 122 +++++++++++++++++++++++-------------------
 net/bluetooth/smp.h           |   1 -
 4 files changed, 66 insertions(+), 68 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 1a037ba4b6f4..bda6252e3722 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -636,7 +636,6 @@ struct l2cap_conn {
 	__u8			disc_reason;
 
 	struct delayed_work	security_timer;
-	struct smp_chan		*smp_chan;
 	struct l2cap_chan	*smp;
 
 	struct list_head	chan_l;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 8acfe6f57b5e..40b6c06ab2c0 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1651,11 +1651,6 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
 		cancel_delayed_work_sync(&conn->info_timer);
 
-	if (test_and_clear_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags)) {
-		cancel_delayed_work_sync(&conn->security_timer);
-		smp_chan_destroy(conn);
-	}
-
 	hcon->l2cap_data = NULL;
 	conn->hchan = NULL;
 	l2cap_conn_put(conn);
@@ -6862,11 +6857,6 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 		l2cap_le_sig_channel(conn, skb);
 		break;
 
-	case L2CAP_CID_SMP:
-		if (smp_sig_channel(conn, skb))
-			l2cap_conn_del(conn->hcon, EACCES);
-		break;
-
 	default:
 		l2cap_data_channel(conn, cid, skb);
 		break;
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 6925fc4caaee..744f678ac3e8 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -248,44 +248,29 @@ static int smp_s1(struct smp_chan *smp, u8 k[16], u8 r1[16], u8 r2[16],
 	return err;
 }
 
-static struct sk_buff *smp_build_cmd(struct l2cap_conn *conn, u8 code,
-				     u16 dlen, void *data)
+static void smp_send_cmd(struct l2cap_conn *conn, u8 code, u16 len, void *data)
 {
-	struct sk_buff *skb;
-	struct l2cap_hdr *lh;
-	int len;
-
-	len = L2CAP_HDR_SIZE + sizeof(code) + dlen;
-
-	if (len > conn->mtu)
-		return NULL;
+	struct l2cap_chan *chan = conn->smp;
+	struct kvec iv[2];
+	struct msghdr msg;
 
-	skb = bt_skb_alloc(len, GFP_ATOMIC);
-	if (!skb)
-		return NULL;
+	if (!chan)
+		return;
 
-	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
-	lh->len = cpu_to_le16(sizeof(code) + dlen);
-	lh->cid = cpu_to_le16(L2CAP_CID_SMP);
+	BT_DBG("code 0x%2.2x", code);
 
-	memcpy(skb_put(skb, sizeof(code)), &code, sizeof(code));
+	iv[0].iov_base = &code;
+	iv[0].iov_len = 1;
 
-	memcpy(skb_put(skb, dlen), data, dlen);
+	iv[1].iov_base = data;
+	iv[1].iov_len = len;
 
-	return skb;
-}
+	memset(&msg, 0, sizeof(msg));
 
-static void smp_send_cmd(struct l2cap_conn *conn, u8 code, u16 len, void *data)
-{
-	struct sk_buff *skb = smp_build_cmd(conn, code, len, data);
+	msg.msg_iov = (struct iovec *) &iv;
+	msg.msg_iovlen = 2;
 
-	BT_DBG("code 0x%2.2x", code);
-
-	if (!skb)
-		return;
-
-	skb->priority = HCI_PRIO_MAX;
-	hci_send_acl(conn->hchan, skb, 0);
+	l2cap_chan_send(chan, &msg, 1 + len);
 
 	cancel_delayed_work_sync(&conn->security_timer);
 	schedule_delayed_work(&conn->security_timer, SMP_TIMEOUT);
@@ -315,7 +300,8 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
 			      struct smp_cmd_pairing *req,
 			      struct smp_cmd_pairing *rsp, __u8 authreq)
 {
-	struct smp_chan *smp = conn->smp_chan;
+	struct l2cap_chan *chan = conn->smp;
+	struct smp_chan *smp = chan->data;
 	struct hci_conn *hcon = conn->hcon;
 	struct hci_dev *hdev = hcon->hdev;
 	u8 local_dist = 0, remote_dist = 0;
@@ -358,7 +344,8 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
 
 static u8 check_enc_key_size(struct l2cap_conn *conn, __u8 max_key_size)
 {
-	struct smp_chan *smp = conn->smp_chan;
+	struct l2cap_chan *chan = conn->smp;
+	struct smp_chan *smp = chan->data;
 
 	if ((max_key_size > SMP_MAX_ENC_KEY_SIZE) ||
 	    (max_key_size < SMP_MIN_ENC_KEY_SIZE))
@@ -418,7 +405,8 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 						u8 local_io, u8 remote_io)
 {
 	struct hci_conn *hcon = conn->hcon;
-	struct smp_chan *smp = conn->smp_chan;
+	struct l2cap_chan *chan = conn->smp;
+	struct smp_chan *smp = chan->data;
 	u8 method;
 	u32 passkey = 0;
 	int ret = 0;
@@ -589,6 +577,7 @@ static u8 smp_random(struct smp_chan *smp)
 
 static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
 {
+	struct l2cap_chan *chan = conn->smp;
 	struct smp_chan *smp;
 
 	smp = kzalloc(sizeof(*smp), GFP_ATOMIC);
@@ -606,7 +595,7 @@ static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
 	}
 
 	smp->conn = conn;
-	conn->smp_chan = smp;
+	chan->data = smp;
 
 	hci_conn_hold(conn->hcon);
 
@@ -615,7 +604,8 @@ static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
 
 void smp_chan_destroy(struct l2cap_conn *conn)
 {
-	struct smp_chan *smp = conn->smp_chan;
+	struct l2cap_chan *chan = conn->smp;
+	struct smp_chan *smp = chan->data;
 	bool complete;
 
 	BUG_ON(!smp);
@@ -646,14 +636,15 @@ void smp_chan_destroy(struct l2cap_conn *conn)
 		}
 	}
 
+	chan->data = NULL;
 	kfree(smp);
-	conn->smp_chan = NULL;
 	hci_conn_drop(conn->hcon);
 }
 
 int smp_user_confirm_reply(struct hci_conn *hcon, u16 mgmt_op, __le32 passkey)
 {
 	struct l2cap_conn *conn = hcon->l2cap_data;
+	struct l2cap_chan *chan;
 	struct smp_chan *smp;
 	u32 value;
 
@@ -662,7 +653,11 @@ int smp_user_confirm_reply(struct hci_conn *hcon, u16 mgmt_op, __le32 passkey)
 	if (!conn || !test_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags))
 		return -ENOTCONN;
 
-	smp = conn->smp_chan;
+	chan = conn->smp;
+	if (!chan)
+		return -ENOTCONN;
+
+	smp = chan->data;
 
 	switch (mgmt_op) {
 	case MGMT_OP_USER_PASSKEY_REPLY:
@@ -709,10 +704,12 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (conn->hcon->role != HCI_ROLE_SLAVE)
 		return SMP_CMD_NOTSUPP;
 
-	if (!test_and_set_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->flags))
+	if (!test_and_set_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->flags)) {
 		smp = smp_chan_create(conn);
-	else
-		smp = conn->smp_chan;
+	} else {
+		struct l2cap_chan *chan = conn->smp;
+		smp = chan->data;
+	}
 
 	if (!smp)
 		return SMP_UNSPECIFIED;
@@ -766,7 +763,8 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct smp_cmd_pairing *req, *rsp = (void *) skb->data;
-	struct smp_chan *smp = conn->smp_chan;
+	struct l2cap_chan *chan = conn->smp;
+	struct smp_chan *smp = chan->data;
 	u8 key_size, auth = SMP_AUTH_NONE;
 	int ret;
 
@@ -827,7 +825,8 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 
 static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 {
-	struct smp_chan *smp = conn->smp_chan;
+	struct l2cap_chan *chan = conn->smp;
+	struct smp_chan *smp = chan->data;
 
 	BT_DBG("conn %p %s", conn, conn->hcon->out ? "master" : "slave");
 
@@ -850,7 +849,8 @@ static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 
 static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 {
-	struct smp_chan *smp = conn->smp_chan;
+	struct l2cap_chan *chan = conn->smp;
+	struct smp_chan *smp = chan->data;
 
 	BT_DBG("conn %p", conn);
 
@@ -1023,7 +1023,8 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 static int smp_cmd_encrypt_info(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct smp_cmd_encrypt_info *rp = (void *) skb->data;
-	struct smp_chan *smp = conn->smp_chan;
+	struct l2cap_chan *chan = conn->smp;
+	struct smp_chan *smp = chan->data;
 
 	BT_DBG("conn %p", conn);
 
@@ -1044,7 +1045,8 @@ static int smp_cmd_encrypt_info(struct l2cap_conn *conn, struct sk_buff *skb)
 static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct smp_cmd_master_ident *rp = (void *) skb->data;
-	struct smp_chan *smp = conn->smp_chan;
+	struct l2cap_chan *chan = conn->smp;
+	struct smp_chan *smp = chan->data;
 	struct hci_dev *hdev = conn->hcon->hdev;
 	struct hci_conn *hcon = conn->hcon;
 	struct smp_ltk *ltk;
@@ -1080,7 +1082,8 @@ static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 static int smp_cmd_ident_info(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct smp_cmd_ident_info *info = (void *) skb->data;
-	struct smp_chan *smp = conn->smp_chan;
+	struct l2cap_chan *chan = conn->smp;
+	struct smp_chan *smp = chan->data;
 
 	BT_DBG("");
 
@@ -1102,7 +1105,8 @@ static int smp_cmd_ident_addr_info(struct l2cap_conn *conn,
 				   struct sk_buff *skb)
 {
 	struct smp_cmd_ident_addr_info *info = (void *) skb->data;
-	struct smp_chan *smp = conn->smp_chan;
+	struct l2cap_chan *chan = conn->smp;
+	struct smp_chan *smp = chan->data;
 	struct hci_conn *hcon = conn->hcon;
 	bdaddr_t rpa;
 
@@ -1156,7 +1160,8 @@ distribute:
 static int smp_cmd_sign_info(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct smp_cmd_sign_info *rp = (void *) skb->data;
-	struct smp_chan *smp = conn->smp_chan;
+	struct l2cap_chan *chan = conn->smp;
+	struct smp_chan *smp = chan->data;
 	struct hci_dev *hdev = conn->hcon->hdev;
 	struct smp_csrk *csrk;
 
@@ -1187,8 +1192,9 @@ static int smp_cmd_sign_info(struct l2cap_conn *conn, struct sk_buff *skb)
 	return 0;
 }
 
-int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
+static int smp_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 {
+	struct l2cap_conn *conn = chan->conn;
 	struct hci_conn *hcon = conn->hcon;
 	__u8 code, reason;
 	int err = 0;
@@ -1290,7 +1296,8 @@ done:
 
 static void smp_notify_keys(struct l2cap_conn *conn)
 {
-	struct smp_chan *smp = conn->smp_chan;
+	struct l2cap_chan *chan = conn->smp;
+	struct smp_chan *smp = chan->data;
 	struct hci_conn *hcon = conn->hcon;
 	struct hci_dev *hdev = hcon->hdev;
 	struct smp_cmd_pairing *req = (void *) &smp->preq[1];
@@ -1357,7 +1364,8 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 int smp_distribute_keys(struct l2cap_conn *conn)
 {
 	struct smp_cmd_pairing *req, *rsp;
-	struct smp_chan *smp = conn->smp_chan;
+	struct l2cap_chan *chan = conn->smp;
+	struct smp_chan *smp = chan->data;
 	struct hci_conn *hcon = conn->hcon;
 	struct hci_dev *hdev = hcon->hdev;
 	__u8 *keydist;
@@ -1475,6 +1483,11 @@ static void smp_teardown_cb(struct l2cap_chan *chan, int err)
 
 	BT_DBG("chan %p", chan);
 
+	if (test_and_clear_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->flags)) {
+		cancel_delayed_work_sync(&conn->security_timer);
+		smp_chan_destroy(conn);
+	}
+
 	conn->smp = NULL;
 	l2cap_chan_put(chan);
 }
@@ -1508,11 +1521,11 @@ static struct sk_buff *smp_alloc_skb_cb(struct l2cap_chan *chan,
 static const struct l2cap_ops smp_chan_ops = {
 	.name			= "Security Manager",
 	.ready			= smp_ready_cb,
+	.recv			= smp_recv_cb,
 	.alloc_skb		= smp_alloc_skb_cb,
 	.teardown		= smp_teardown_cb,
 
 	.new_connection		= l2cap_chan_no_new_connection,
-	.recv			= l2cap_chan_no_recv,
 	.state_change		= l2cap_chan_no_state_change,
 	.close			= l2cap_chan_no_close,
 	.defer			= l2cap_chan_no_defer,
@@ -1587,10 +1600,7 @@ int smp_register(struct hci_dev *hdev)
 
 	chan->data = tfm_aes;
 
-	/* FIXME: Using reserved 0x1f value for now - to be changed to
-	 * L2CAP_CID_SMP once all functionality is in place.
-	 */
-	l2cap_add_scid(chan, 0x1f);
+	l2cap_add_scid(chan, L2CAP_CID_SMP);
 
 	l2cap_chan_set_defaults(chan);
 
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index d3f6bd617940..161ace3c3234 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -126,7 +126,6 @@ enum {
 /* SMP Commands */
 bool smp_sufficient_security(struct hci_conn *hcon, u8 sec_level);
 int smp_conn_security(struct hci_conn *hcon, __u8 sec_level);
-int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb);
 int smp_distribute_keys(struct l2cap_conn *conn);
 int smp_user_confirm_reply(struct hci_conn *conn, u16 mgmt_op, __le32 passkey);
 
-- 
1.9.3

