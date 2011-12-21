Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: Brian Gix <bgix@codeaurora.org>
Subject: [PATCH-v8 1/2] Bluetooth: Add MITM mechanism to LE-SMP
Date: Wed, 21 Dec 2011 14:08:38 -0800
Message-Id: <1324505319-3881-2-git-send-email-bgix@codeaurora.org>
In-Reply-To: <1324505319-3881-1-git-send-email-bgix@codeaurora.org>
References: <1324505319-3881-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

To achive Man-In-The-Middle (MITM) level security with Low Energy,
we have to enable User Passkey Comparison.  This commit modifies the
hard-coded JUST-WORKS pairing mechanism to support query via the MGMT
interface of Passkey comparison and User Confirmation.

Signed-off-by: Brian Gix <bgix@codeaurora.org>
---
 include/net/bluetooth/hci_core.h |    1 +
 include/net/bluetooth/smp.h      |    6 +
 net/bluetooth/smp.c              |  226 ++++++++++++++++++++++++++++++++++----
 3 files changed, 211 insertions(+), 22 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 25c161a..295cd90 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -314,6 +314,7 @@ struct hci_conn {
 	struct hci_dev	*hdev;
 	void		*l2cap_data;
 	void		*sco_data;
+	void		*smp_conn;
 
 	struct hci_conn	*link;
 
diff --git a/include/net/bluetooth/smp.h b/include/net/bluetooth/smp.h
index 15b97d5..aeaf5fa 100644
--- a/include/net/bluetooth/smp.h
+++ b/include/net/bluetooth/smp.h
@@ -115,6 +115,10 @@ struct smp_cmd_security_req {
 #define SMP_MIN_ENC_KEY_SIZE		7
 #define SMP_MAX_ENC_KEY_SIZE		16
 
+#define SMP_FLAG_TK_VALID	1
+#define SMP_FLAG_CFM_PENDING	2
+#define SMP_FLAG_MITM_AUTH	3
+
 struct smp_chan {
 	struct l2cap_conn *conn;
 	u8		preq[7]; /* SMP Pairing Request */
@@ -124,6 +128,7 @@ struct smp_chan {
 	u8		pcnf[16]; /* SMP Pairing Confirm */
 	u8		tk[16]; /* SMP Temporary Key */
 	u8		smp_key_size;
+	unsigned long	smp_flags;
 	struct crypto_blkcipher	*tfm;
 	struct work_struct confirm;
 	struct work_struct random;
@@ -134,6 +139,7 @@ struct smp_chan {
 int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level);
 int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb);
 int smp_distribute_keys(struct l2cap_conn *conn, __u8 force);
+int smp_user_confirm_reply(struct hci_conn *conn, u16 mgmt_op, __le32 passkey);
 
 void smp_chan_destroy(struct l2cap_conn *conn);
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 0ee2905..d0ca417 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -23,6 +23,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
+#include <net/bluetooth/mgmt.h>
 #include <net/bluetooth/smp.h>
 #include <linux/crypto.h>
 #include <linux/scatterlist.h>
@@ -189,24 +190,45 @@ static void smp_send_cmd(struct l2cap_conn *conn, u8 code, u16 len, void *data)
 					msecs_to_jiffies(SMP_TIMEOUT));
 }
 
+static __u8 authreq_to_seclevel(__u8 authreq)
+{
+	if (authreq & SMP_AUTH_MITM)
+		return BT_SECURITY_HIGH;
+	else
+		return BT_SECURITY_MEDIUM;
+}
+
+static __u8 seclevel_to_authreq(__u8 sec_level)
+{
+	switch (sec_level) {
+	case BT_SECURITY_HIGH:
+		return SMP_AUTH_MITM | SMP_AUTH_BONDING;
+	case BT_SECURITY_MEDIUM:
+		return SMP_AUTH_BONDING;
+	default:
+		return SMP_AUTH_NONE;
+	}
+}
+
 static void build_pairing_cmd(struct l2cap_conn *conn,
 				struct smp_cmd_pairing *req,
 				struct smp_cmd_pairing *rsp,
 				__u8 authreq)
 {
-	u8 dist_keys;
+	u8 dist_keys = 0;
 
-	dist_keys = 0;
 	if (test_bit(HCI_PAIRABLE, &conn->hcon->hdev->flags)) {
 		dist_keys = SMP_DIST_ENC_KEY;
 		authreq |= SMP_AUTH_BONDING;
+	} else {
+		authreq &= ~SMP_AUTH_BONDING;
 	}
 
 	if (rsp == NULL) {
 		req->io_capability = conn->hcon->io_capability;
 		req->oob_flag = SMP_OOB_NOT_PRESENT;
 		req->max_key_size = SMP_MAX_ENC_KEY_SIZE;
-		req->init_key_dist = dist_keys;
+		req->init_key_dist = 0;
 		req->resp_key_dist = dist_keys;
 		req->auth_req = authreq;
 		return;
@@ -215,7 +237,7 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
 	rsp->io_capability = conn->hcon->io_capability;
 	rsp->oob_flag = SMP_OOB_NOT_PRESENT;
 	rsp->max_key_size = SMP_MAX_ENC_KEY_SIZE;
-	rsp->init_key_dist = req->init_key_dist & dist_keys;
+	rsp->init_key_dist = 0;
 	rsp->resp_key_dist = req->resp_key_dist & dist_keys;
 	rsp->auth_req = authreq;
 }
@@ -245,6 +267,95 @@ static void smp_failure(struct l2cap_conn *conn, u8 reason, u8 send)
 	smp_chan_destroy(conn);
 }
 
+#define JUST_WORKS	0x00
+#define JUST_CFM	0x01
+#define REQ_PASSKEY	0x02
+#define CFM_PASSKEY	0x03
+#define REQ_OOB		0x04
+#define OVERLAP		0xFF
+
+static const u8	gen_method[5][5] = {
+	{ JUST_WORKS, JUST_CFM, REQ_PASSKEY, JUST_WORKS, REQ_PASSKEY     },
+	{ JUST_WORKS, JUST_CFM, REQ_PASSKEY, JUST_WORKS, REQ_PASSKEY     },
+	{ CFM_PASSKEY, CFM_PASSKEY, REQ_PASSKEY, JUST_WORKS, CFM_PASSKEY },
+	{ JUST_WORKS, JUST_CFM, JUST_WORKS, JUST_WORKS, JUST_CFM         },
+	{ CFM_PASSKEY, CFM_PASSKEY, REQ_PASSKEY, JUST_WORKS, OVERLAP     },
+};
+
+static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
+						u8 local_io, u8 remote_io)
+{
+	struct hci_conn *hcon = conn->hcon;
+	struct smp_chan *smp = conn->smp_chan;
+	u8 method;
+	u32 passkey = 0;
+	int ret = 0;
+
+	/* Initialize key for JUST WORKS */
+	memset(smp->tk, 0, sizeof(smp->tk));
+	clear_bit(SMP_FLAG_TK_VALID, &smp->smp_flags);
+
+	BT_DBG("tk_request: auth:%d lcl:%d rem:%d", auth, local_io, remote_io);
+
+	/* If neither side wants MITM, use JUST WORKS */
+	/* If either side has unknown io_caps, use JUST WORKS */
+	/* Otherwise, look up method from the table */
+	if (!(auth & SMP_AUTH_MITM) ||
+			local_io > SMP_IO_KEYBOARD_DISPLAY ||
+			remote_io > SMP_IO_KEYBOARD_DISPLAY)
+		method = JUST_WORKS;
+	else
+		method = gen_method[local_io][remote_io];
+
+	/* If not bonding, don't ask user to confirm a Zero TK */
+	if (!(auth & SMP_AUTH_BONDING) && method == JUST_CFM)
+		method = JUST_WORKS;
+
+	/* If Just Works, Continue with Zero TK */
+	if (method == JUST_WORKS) {
+		set_bit(SMP_FLAG_TK_VALID, &smp->smp_flags);
+		return 0;
+	}
+
+	/* Not Just Works/Confirm results in MITM Authentication */
+	if (method != JUST_CFM)
+		set_bit(SMP_FLAG_MITM_AUTH, &smp->smp_flags);
+
+	/* If both devices have Keyoard-Display I/O, the master
+	 * Confirms and the slave Enters the passkey.
+	 */
+	if (method == OVERLAP) {
+		if (hcon->link_mode & HCI_LM_MASTER)
+			method = CFM_PASSKEY;
+		else
+			method = REQ_PASSKEY;
+	}
+
+	/* Generate random passkey. Not valid until confirmed. */
+	if (method == CFM_PASSKEY) {
+		u8 key[16];
+
+		memset(key, 0, sizeof(key));
+		get_random_bytes(&passkey, sizeof(passkey));
+		passkey %= 1000000;
+		put_unaligned_le32(passkey, key);
+		swap128(key, smp->tk);
+		BT_DBG("PassKey: %d", passkey);
+	}
+
+	hci_dev_lock(hcon->hdev);
+
+	if (method == REQ_PASSKEY)
+		ret = mgmt_user_passkey_request(hcon->hdev, conn->dst);
+	else
+		ret = mgmt_user_confirm_request(hcon->hdev, conn->dst,
+						cpu_to_le32(passkey), 0);
+
+	hci_dev_unlock(hcon->hdev);
+
+	return ret;
+}
+
 static void confirm_work(struct work_struct *work)
 {
 	struct smp_chan *smp = container_of(work, struct smp_chan, confirm);
@@ -277,6 +388,8 @@ static void confirm_work(struct work_struct *work)
 		goto error;
 	}
 
+	clear_bit(SMP_FLAG_CFM_PENDING, &smp->smp_flags);
+
 	swap128(res, cp.confirm_val);
 	smp_send_cmd(smp->conn, SMP_CMD_PAIRING_CONFIRM, sizeof(cp), &cp);
 
@@ -382,6 +495,7 @@ static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
 
 	smp->conn = conn;
 	conn->smp_chan = smp;
+	conn->hcon->smp_conn = conn;
 
 	hci_conn_hold(conn->hcon);
 
@@ -399,18 +513,64 @@ void smp_chan_destroy(struct l2cap_conn *conn)
 
 	kfree(smp);
 	conn->smp_chan = NULL;
+	conn->hcon->smp_conn = NULL;
 	hci_conn_put(conn->hcon);
 }
 
+int smp_user_confirm_reply(struct hci_conn *hcon, u16 mgmt_op, __le32 passkey)
+{
+	struct l2cap_conn *conn = hcon->smp_conn;
+	struct smp_chan *smp;
+	u32 value;
+	u8 key[16];
+
+	BT_DBG("");
+
+	if (!conn)
+		return -ENOTCONN;
+
+	smp = conn->smp_chan;
+
+	switch (mgmt_op) {
+	case MGMT_OP_USER_PASSKEY_REPLY:
+		value = le32_to_cpu(passkey);
+		memset(key, 0, sizeof(key));
+		BT_DBG("PassKey: %d", value);
+		put_unaligned_le32(value, key);
+		swap128(key, smp->tk);
+		/* Fall Through */
+	case MGMT_OP_USER_CONFIRM_REPLY:
+		set_bit(SMP_FLAG_TK_VALID, &smp->smp_flags);
+		break;
+	case MGMT_OP_USER_PASSKEY_NEG_REPLY:
+	case MGMT_OP_USER_CONFIRM_NEG_REPLY:
+		smp_failure(conn, SMP_PASSKEY_ENTRY_FAILED, 1);
+		return 0;
+	default:
+		smp_failure(conn, SMP_PASSKEY_ENTRY_FAILED, 1);
+		return -EOPNOTSUPP;
+	}
+
+	/* If it is our turn to send Pairing Confirm, do so now */
+	if (test_bit(SMP_FLAG_CFM_PENDING, &smp->smp_flags))
+		queue_work(hcon->hdev->workqueue, &smp->confirm);
+
+	return 0;
+}
+
 static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct smp_cmd_pairing rsp, *req = (void *) skb->data;
 	struct smp_chan *smp;
 	u8 key_size;
+	u8 auth = SMP_AUTH_NONE;
 	int ret;
 
 	BT_DBG("conn %p", conn);
 
+	if (conn->hcon->link_mode & HCI_LM_MASTER)
+		return SMP_CMD_NOTSUPP;
+
 	if (!test_and_set_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->pend))
 		smp = smp_chan_create(conn);
 
@@ -420,19 +580,16 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	memcpy(&smp->preq[1], req, sizeof(*req));
 	skb_pull(skb, sizeof(*req));
 
-	if (req->oob_flag)
-		return SMP_OOB_NOT_AVAIL;
+	/* We didn't start the pairing, so match remote */
+	if (req->auth_req & SMP_AUTH_BONDING)
+		auth = req->auth_req;
 
-	/* We didn't start the pairing, so no requirements */
-	build_pairing_cmd(conn, req, &rsp, SMP_AUTH_NONE);
+	build_pairing_cmd(conn, req, &rsp, auth);
 
 	key_size = min(req->max_key_size, rsp.max_key_size);
 	if (check_enc_key_size(conn, key_size))
 		return SMP_ENC_KEY_SIZE;
 
-	/* Just works */
-	memset(smp->tk, 0, sizeof(smp->tk));
-
 	ret = smp_rand(smp->prnd);
 	if (ret)
 		return SMP_UNSPECIFIED;
@@ -442,6 +599,11 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	smp_send_cmd(conn, SMP_CMD_PAIRING_RSP, sizeof(rsp), &rsp);
 
+	/* Request setup of TK */
+	ret = tk_request(conn, 0, auth, rsp.io_capability, req->io_capability);
+	if (ret)
+		return SMP_UNSPECIFIED;
+
 	return 0;
 }
 
@@ -450,11 +612,14 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct smp_cmd_pairing *req, *rsp = (void *) skb->data;
 	struct smp_chan *smp = conn->smp_chan;
 	struct hci_dev *hdev = conn->hcon->hdev;
-	u8 key_size;
+	u8 key_size, auth = SMP_AUTH_NONE;
 	int ret;
 
 	BT_DBG("conn %p", conn);
 
+	if (!(conn->hcon->link_mode & HCI_LM_MASTER))
+		return SMP_CMD_NOTSUPP;
+
 	skb_pull(skb, sizeof(*rsp));
 
 	req = (void *) &smp->preq[1];
@@ -463,12 +628,6 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (check_enc_key_size(conn, key_size))
 		return SMP_ENC_KEY_SIZE;
 
-	if (rsp->oob_flag)
-		return SMP_OOB_NOT_AVAIL;
-
-	/* Just works */
-	memset(smp->tk, 0, sizeof(smp->tk));
-
 	ret = smp_rand(smp->prnd);
 	if (ret)
 		return SMP_UNSPECIFIED;
@@ -476,6 +635,22 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 	smp->prsp[0] = SMP_CMD_PAIRING_RSP;
 	memcpy(&smp->prsp[1], rsp, sizeof(*rsp));
 
+	if ((req->auth_req & SMP_AUTH_BONDING) &&
+			(rsp->auth_req & SMP_AUTH_BONDING))
+		auth = SMP_AUTH_BONDING;
+
+	auth |= (req->auth_req | rsp->auth_req) & SMP_AUTH_MITM;
+
+	ret = tk_request(conn, 0, auth, rsp->io_capability, req->io_capability);
+	if (ret)
+		return SMP_UNSPECIFIED;
+
+	set_bit(SMP_FLAG_CFM_PENDING, &smp->smp_flags);
+
+	/* Can't compose response until we have been confirmed */
+	if (!test_bit(SMP_FLAG_TK_VALID, &smp->smp_flags))
+		return 0;
+
 	queue_work(hdev->workqueue, &smp->confirm);
 
 	return 0;
@@ -497,8 +672,10 @@ static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 		swap128(smp->prnd, random);
 		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(random),
 								random);
-	} else {
+	} else if (test_bit(SMP_FLAG_TK_VALID, &smp->smp_flags)) {
 		queue_work(hdev->workqueue, &smp->confirm);
+	} else {
+		set_bit(SMP_FLAG_CFM_PENDING, &smp->smp_flags);
 	}
 
 	return 0;
@@ -551,7 +728,7 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	BT_DBG("conn %p", conn);
 
-	hcon->pending_sec_level = BT_SECURITY_MEDIUM;
+	hcon->pending_sec_level = authreq_to_seclevel(rp->auth_req);
 
 	if (smp_ltk_encrypt(conn))
 		return 0;
@@ -578,6 +755,7 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 {
 	struct hci_conn *hcon = conn->hcon;
 	struct smp_chan *smp = conn->smp_chan;
+	__u8 authreq;
 
 	BT_DBG("conn %p hcon %p level 0x%2.2x", conn, hcon, sec_level);
 
@@ -598,18 +776,22 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 		return 0;
 
 	smp = smp_chan_create(conn);
+	if (!smp)
+		return 1;
+
+	authreq = seclevel_to_authreq(sec_level);
 
 	if (hcon->link_mode & HCI_LM_MASTER) {
 		struct smp_cmd_pairing cp;
 
-		build_pairing_cmd(conn, &cp, NULL, SMP_AUTH_NONE);
+		build_pairing_cmd(conn, &cp, NULL, authreq);
 		smp->preq[0] = SMP_CMD_PAIRING_REQ;
 		memcpy(&smp->preq[1], &cp, sizeof(cp));
 
 		smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
 	} else {
 		struct smp_cmd_security_req cp;
-		cp.auth_req = SMP_AUTH_NONE;
+		cp.auth_req = authreq;
 		smp_send_cmd(conn, SMP_CMD_SECURITY_REQ, sizeof(cp), &cp);
 	}
 
-- 
1.7.8

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum 
