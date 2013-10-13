Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix coding style violations in SMP handling
Date: Sun, 13 Oct 2013 05:43:25 -0700
Message-Id: <1381668205-52698-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The SMP source code has a few coding style violations. Fix them up
all at once. No actual code has changed.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/smp.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 112e581..463e50c 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -86,8 +86,8 @@ static int smp_e(struct crypto_blkcipher *tfm, const u8 *k, u8 *r)
 }
 
 static int smp_c1(struct crypto_blkcipher *tfm, u8 k[16], u8 r[16],
-		u8 preq[7], u8 pres[7], u8 _iat, bdaddr_t *ia,
-		u8 _rat, bdaddr_t *ra, u8 res[16])
+		  u8 preq[7], u8 pres[7], u8 _iat, bdaddr_t *ia,
+		  u8 _rat, bdaddr_t *ra, u8 res[16])
 {
 	u8 p1[16], p2[16];
 	int err;
@@ -127,8 +127,8 @@ static int smp_c1(struct crypto_blkcipher *tfm, u8 k[16], u8 r[16],
 	return err;
 }
 
-static int smp_s1(struct crypto_blkcipher *tfm, u8 k[16],
-			u8 r1[16], u8 r2[16], u8 _r[16])
+static int smp_s1(struct crypto_blkcipher *tfm, u8 k[16], u8 r1[16],
+		  u8 r2[16], u8 _r[16])
 {
 	int err;
 
@@ -151,7 +151,7 @@ static int smp_rand(u8 *buf)
 }
 
 static struct sk_buff *smp_build_cmd(struct l2cap_conn *conn, u8 code,
-						u16 dlen, void *data)
+				     u16 dlen, void *data)
 {
 	struct sk_buff *skb;
 	struct l2cap_hdr *lh;
@@ -214,9 +214,8 @@ static __u8 seclevel_to_authreq(__u8 sec_level)
 }
 
 static void build_pairing_cmd(struct l2cap_conn *conn,
-				struct smp_cmd_pairing *req,
-				struct smp_cmd_pairing *rsp,
-				__u8 authreq)
+			      struct smp_cmd_pairing *req,
+			      struct smp_cmd_pairing *rsp, __u8 authreq)
 {
 	u8 dist_keys = 0;
 
@@ -250,7 +249,7 @@ static u8 check_enc_key_size(struct l2cap_conn *conn, __u8 max_key_size)
 	struct smp_chan *smp = conn->smp_chan;
 
 	if ((max_key_size > SMP_MAX_ENC_KEY_SIZE) ||
-			(max_key_size < SMP_MIN_ENC_KEY_SIZE))
+	    (max_key_size < SMP_MIN_ENC_KEY_SIZE))
 		return SMP_ENC_KEY_SIZE;
 
 	smp->enc_key_size = max_key_size;
@@ -264,7 +263,7 @@ static void smp_failure(struct l2cap_conn *conn, u8 reason, u8 send)
 
 	if (send)
 		smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, sizeof(reason),
-								&reason);
+			     &reason);
 
 	clear_bit(HCI_CONN_ENCRYPT_PEND, &hcon->flags);
 	mgmt_auth_failed(hcon->hdev, &hcon->dst, hcon->type, hcon->dst_type,
@@ -310,8 +309,8 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 	/* If either side has unknown io_caps, use JUST WORKS */
 	/* Otherwise, look up method from the table */
 	if (!(auth & SMP_AUTH_MITM) ||
-			local_io > SMP_IO_KEYBOARD_DISPLAY ||
-			remote_io > SMP_IO_KEYBOARD_DISPLAY)
+	    local_io > SMP_IO_KEYBOARD_DISPLAY ||
+	    remote_io > SMP_IO_KEYBOARD_DISPLAY)
 		method = JUST_WORKS;
 	else
 		method = gen_method[remote_io][local_io];
@@ -481,7 +480,7 @@ static void random_work(struct work_struct *work)
 		swap128(key, stk);
 
 		memset(stk + smp->enc_key_size, 0,
-				SMP_MAX_ENC_KEY_SIZE - smp->enc_key_size);
+		       SMP_MAX_ENC_KEY_SIZE - smp->enc_key_size);
 
 		hci_add_ltk(hcon->hdev, &hcon->dst, hcon->dst_type,
 			    HCI_SMP_STK_SLAVE, 0, 0, stk, smp->enc_key_size,
@@ -498,7 +497,7 @@ static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
 {
 	struct smp_chan *smp;
 
-	smp = kzalloc(sizeof(struct smp_chan), GFP_ATOMIC);
+	smp = kzalloc(sizeof(*smp), GFP_ATOMIC);
 	if (!smp)
 		return NULL;
 
@@ -653,7 +652,7 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 	memcpy(&smp->prsp[1], rsp, sizeof(*rsp));
 
 	if ((req->auth_req & SMP_AUTH_BONDING) &&
-			(rsp->auth_req & SMP_AUTH_BONDING))
+	    (rsp->auth_req & SMP_AUTH_BONDING))
 		auth = SMP_AUTH_BONDING;
 
 	auth |= (req->auth_req | rsp->auth_req) & SMP_AUTH_MITM;
@@ -688,7 +687,7 @@ static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 
 		swap128(smp->prnd, random);
 		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(random),
-								random);
+			     random);
 	} else if (test_bit(SMP_FLAG_TK_VALID, &smp->smp_flags)) {
 		queue_work(hdev->workqueue, &smp->confirm);
 	} else {
@@ -732,8 +731,8 @@ static u8 smp_ltk_encrypt(struct l2cap_conn *conn, u8 sec_level)
 	hcon->enc_key_size = key->enc_size;
 
 	return 1;
-
 }
+
 static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct smp_cmd_security_req *rp = (void *) skb->data;
@@ -1014,7 +1013,7 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 		bacpy(&addrinfo.bdaddr, &conn->hcon->src);
 
 		smp_send_cmd(conn, SMP_CMD_IDENT_ADDR_INFO, sizeof(addrinfo),
-								&addrinfo);
+			     &addrinfo);
 
 		*keydist &= ~SMP_DIST_ID_KEY;
 	}
-- 
1.8.3.1

