Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2.1 5/7] Bluetooth: Fix locking of the SMP context
Date: Fri,  5 Sep 2014 15:50:16 +0300
Message-Id: <1409921416-32594-1-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1409920838-30242-6-git-send-email-johan.hedberg@gmail.com>
References: <1409920838-30242-6-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Before the move the l2cap_chan the SMP context (smp_chan) didn't have
any kind of proper locking. The best there existed was the
HCI_CONN_LE_SMP_PEND flag which was used to enable mutual exclusion for
potential multiple creators of the SMP context.

Now that SMP has been converted to use the l2cap_chan infrastructure and
since the SMP context is directly mapped to a corresponding l2cap_chan
we get the SMP context locking essentially for free through the
l2cap_chan lock. For all callbacks that l2cap_core.c makes for each
channel implementation (smp.c in the case of SMP) the l2cap_chan lock is
held through l2cap_chan_lock(chan).

Since the calls from l2cap_core.c to smp.c are covered the only missing
piece to have the locking implemented properly is to ensure that the
lock is held for any other call path that may access the SMP context.
This means user responses through mgmt.c, requests to elevate the
security of a connection through hci_conn.c, as well as any deferred
work through workqueues.

This patch adds the necessary locking to all these other code paths that
try to access the SMP context. Since mutual exclusion for the l2cap_chan
access is now covered from all directions the patch also removes
unnecessary HCI_CONN_LE_SMP_PEND flag (once we've acquired the chan lock
we can simply check whether chan->smp is set to know if there's an SMP
context).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/smp.c              | 76 +++++++++++++++++++++++-----------------
 2 files changed, 44 insertions(+), 33 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2b6e04d37593..045d9133d180 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -539,7 +539,6 @@ enum {
 	HCI_CONN_RSWITCH_PEND,
 	HCI_CONN_MODE_CHANGE_PEND,
 	HCI_CONN_SCO_SETUP_PEND,
-	HCI_CONN_LE_SMP_PEND,
 	HCI_CONN_MGMT_CONNECTED,
 	HCI_CONN_SSP_ENABLED,
 	HCI_CONN_SC_ENABLED,
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 0b4403f3dce1..c71589f4b435 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -409,7 +409,6 @@ static void smp_failure(struct l2cap_conn *conn, u8 reason)
 {
 	struct hci_conn *hcon = conn->hcon;
 	struct l2cap_chan *chan = conn->smp;
-	struct smp_chan *smp;
 
 	if (reason)
 		smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, sizeof(reason),
@@ -419,12 +418,7 @@ static void smp_failure(struct l2cap_conn *conn, u8 reason)
 	mgmt_auth_failed(hcon->hdev, &hcon->dst, hcon->type, hcon->dst_type,
 			 HCI_ERROR_AUTH_FAILURE);
 
-	if (!chan->data)
-		return;
-
-	smp = chan->data;
-
-	if (test_and_clear_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags))
+	if (chan->data)
 		smp_chan_destroy(conn);
 }
 
@@ -706,9 +700,6 @@ static void smp_distribute_keys(struct smp_chan *smp)
 
 	BT_DBG("conn %p", conn);
 
-	if (!test_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags))
-		return;
-
 	rsp = (void *) &smp->prsp[1];
 
 	/* The responder sends its keys first */
@@ -801,7 +792,6 @@ static void smp_distribute_keys(struct smp_chan *smp)
 	if ((smp->remote_key_dist & 0x07))
 		return;
 
-	clear_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags);
 	set_bit(SMP_FLAG_COMPLETE, &smp->flags);
 	smp_notify_keys(conn);
 
@@ -825,16 +815,13 @@ static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
 	struct smp_chan *smp;
 
 	smp = kzalloc(sizeof(*smp), GFP_ATOMIC);
-	if (!smp) {
-		clear_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->flags);
+	if (!smp)
 		return NULL;
-	}
 
 	smp->tfm_aes = crypto_alloc_blkcipher("ecb(aes)", 0, CRYPTO_ALG_ASYNC);
 	if (IS_ERR(smp->tfm_aes)) {
 		BT_ERR("Unable to create ECB crypto context");
 		kfree(smp);
-		clear_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->flags);
 		return NULL;
 	}
 
@@ -854,16 +841,23 @@ int smp_user_confirm_reply(struct hci_conn *hcon, u16 mgmt_op, __le32 passkey)
 	struct l2cap_chan *chan;
 	struct smp_chan *smp;
 	u32 value;
+	int err;
 
 	BT_DBG("");
 
-	if (!conn || !test_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags))
+	if (!conn)
 		return -ENOTCONN;
 
 	chan = conn->smp;
 	if (!chan)
 		return -ENOTCONN;
 
+	l2cap_chan_lock(chan);
+	if (!chan->data) {
+		err = -ENOTCONN;
+		goto unlock;
+	}
+
 	smp = chan->data;
 
 	switch (mgmt_op) {
@@ -879,12 +873,16 @@ int smp_user_confirm_reply(struct hci_conn *hcon, u16 mgmt_op, __le32 passkey)
 	case MGMT_OP_USER_PASSKEY_NEG_REPLY:
 	case MGMT_OP_USER_CONFIRM_NEG_REPLY:
 		smp_failure(conn, SMP_PASSKEY_ENTRY_FAILED);
-		return 0;
+		err = 0;
+		goto unlock;
 	default:
 		smp_failure(conn, SMP_PASSKEY_ENTRY_FAILED);
-		return -EOPNOTSUPP;
+		err = -EOPNOTSUPP;
+		goto unlock;
 	}
 
+	err = 0;
+
 	/* If it is our turn to send Pairing Confirm, do so now */
 	if (test_bit(SMP_FLAG_CFM_PENDING, &smp->flags)) {
 		u8 rsp = smp_confirm(smp);
@@ -892,12 +890,15 @@ int smp_user_confirm_reply(struct hci_conn *hcon, u16 mgmt_op, __le32 passkey)
 			smp_failure(conn, rsp);
 	}
 
-	return 0;
+unlock:
+	l2cap_chan_unlock(chan);
+	return err;
 }
 
 static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct smp_cmd_pairing rsp, *req = (void *) skb->data;
+	struct l2cap_chan *chan = conn->smp;
 	struct hci_dev *hdev = conn->hcon->hdev;
 	struct smp_chan *smp;
 	u8 key_size, auth, sec_level;
@@ -911,12 +912,10 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (conn->hcon->role != HCI_ROLE_SLAVE)
 		return SMP_CMD_NOTSUPP;
 
-	if (!test_and_set_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->flags)) {
+	if (!chan->data)
 		smp = smp_chan_create(conn);
-	} else {
-		struct l2cap_chan *chan = conn->smp;
+	else
 		smp = chan->data;
-	}
 
 	if (!smp)
 		return SMP_UNSPECIFIED;
@@ -1122,6 +1121,7 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct smp_cmd_security_req *rp = (void *) skb->data;
 	struct smp_cmd_pairing cp;
 	struct hci_conn *hcon = conn->hcon;
+	struct l2cap_chan *chan = conn->smp;
 	struct smp_chan *smp;
 	u8 sec_level;
 
@@ -1143,7 +1143,8 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (smp_ltk_encrypt(conn, hcon->pending_sec_level))
 		return 0;
 
-	if (test_and_set_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags))
+	/* If SMP is already in progress ignore this request */
+	if (chan->data)
 		return 0;
 
 	smp = smp_chan_create(conn);
@@ -1170,8 +1171,10 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 {
 	struct l2cap_conn *conn = hcon->l2cap_data;
+	struct l2cap_chan *chan = conn->smp;
 	struct smp_chan *smp;
 	__u8 authreq;
+	int ret;
 
 	BT_DBG("conn %p hcon %p level 0x%2.2x", conn, hcon, sec_level);
 
@@ -1192,12 +1195,19 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 		if (smp_ltk_encrypt(conn, hcon->pending_sec_level))
 			return 0;
 
-	if (test_and_set_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags))
-		return 0;
+	l2cap_chan_lock(chan);
+
+	/* If SMP is already in progress ignore this request */
+	if (chan->data) {
+		ret = 0;
+		goto unlock;
+	}
 
 	smp = smp_chan_create(conn);
-	if (!smp)
-		return 1;
+	if (!smp) {
+		ret = 1;
+		goto unlock;
+	}
 
 	authreq = seclevel_to_authreq(sec_level);
 
@@ -1223,8 +1233,11 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 	}
 
 	set_bit(SMP_FLAG_INITIATOR, &smp->flags);
+	ret = 0;
 
-	return 0;
+unlock:
+	l2cap_chan_unlock(chan);
+	return ret;
 }
 
 static int smp_cmd_encrypt_info(struct l2cap_conn *conn, struct sk_buff *skb)
@@ -1315,7 +1328,6 @@ static int smp_cmd_ident_addr_info(struct l2cap_conn *conn,
 	struct l2cap_chan *chan = conn->smp;
 	struct smp_chan *smp = chan->data;
 	struct hci_conn *hcon = conn->hcon;
-	struct hci_dev *hdev = hcon->hdev;
 	bdaddr_t rpa;
 
 	BT_DBG("");
@@ -1430,7 +1442,7 @@ static int smp_sig_channel(struct l2cap_chan *chan, struct sk_buff *skb)
 	 * returns an error).
 	 */
 	if (code != SMP_CMD_PAIRING_REQ && code != SMP_CMD_SECURITY_REQ &&
-	    !test_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags)) {
+	    !chan->data) {
 		BT_ERR("Unexpected SMP command 0x%02x. Disconnecting.", code);
 		err = -EOPNOTSUPP;
 		goto done;
@@ -1504,7 +1516,7 @@ static void smp_teardown_cb(struct l2cap_chan *chan, int err)
 
 	BT_DBG("chan %p", chan);
 
-	if (test_and_clear_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->flags))
+	if (chan->data)
 		smp_chan_destroy(conn);
 
 	conn->smp = NULL;
-- 
1.9.3

