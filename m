Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [bluetooth-next 01/13] Bluetooth: Add support for SMP phase 3 (key distribution)
Date: Tue,  7 Jun 2011 19:50:02 -0300
Message-Id: <1307487014-19398-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1307487014-19398-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1307487014-19398-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds support for generating and distributing all the keys
specified in the third phase of SMP.

This will make possible to re-establish secure connections, resolve
private addresses and sign commands.

For now, the values generated are random.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/smp.h |    1 +
 net/bluetooth/l2cap_core.c  |    1 +
 net/bluetooth/smp.c         |  114 ++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 114 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/smp.h b/include/net/bluetooth/smp.h
index 4fb7d19..46c4576 100644
--- a/include/net/bluetooth/smp.h
+++ b/include/net/bluetooth/smp.h
@@ -118,5 +118,6 @@ struct smp_cmd_security_req {
 /* SMP Commands */
 int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level);
 int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb);
+int smp_distribute_keys(struct l2cap_conn *conn, __u8 force);
 
 #endif /* __SMP_H */
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9db461d..f202fa3 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4193,6 +4193,7 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 				chan->sec_level = hcon->sec_level;
 				del_timer(&conn->security_timer);
 				l2cap_chan_ready(sk);
+				smp_distribute_keys(conn, 0);
 			}
 
 			bh_unlock_sock(sk);
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 3822159..c9ae5d4 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -201,8 +201,8 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
 	cmd->io_capability = SMP_IO_NO_INPUT_OUTPUT;
 	cmd->oob_flag = SMP_OOB_NOT_PRESENT;
 	cmd->max_key_size = SMP_MAX_ENC_KEY_SIZE;
-	cmd->init_key_dist = 0x00;
-	cmd->resp_key_dist = 0x00;
+	cmd->init_key_dist = SMP_DIST_ENC_KEY | SMP_DIST_ID_KEY | SMP_DIST_SIGN;
+	cmd->resp_key_dist = SMP_DIST_ENC_KEY | SMP_DIST_ID_KEY | SMP_DIST_SIGN;
 	cmd->auth_req = authreq;
 }
 
@@ -462,6 +462,26 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 	return 0;
 }
 
+static int smp_cmd_encrypt_info(struct l2cap_conn *conn, struct sk_buff *skb)
+{
+	BT_DBG("conn %p", conn);
+	/* FIXME: store the ltk */
+	return 0;
+}
+
+static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
+{
+	struct smp_cmd_pairing *paircmd = (void *) &conn->prsp[1];
+	u8 keydist = paircmd->init_key_dist;
+
+	BT_DBG("keydist 0x%x", keydist);
+	/* FIXME: store ediv and rand */
+
+	smp_distribute_keys(conn, 1);
+
+	return 0;
+}
+
 int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	__u8 code = skb->data[0];
@@ -503,10 +523,20 @@ int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
 		break;
 
 	case SMP_CMD_ENCRYPT_INFO:
+		reason = smp_cmd_encrypt_info(conn, skb);
+		break;
+
 	case SMP_CMD_MASTER_IDENT:
+		reason = smp_cmd_master_ident(conn, skb);
+		break;
+
 	case SMP_CMD_IDENT_INFO:
 	case SMP_CMD_IDENT_ADDR_INFO:
 	case SMP_CMD_SIGN_INFO:
+		/* Just ignored */
+		reason = 0;
+		break;
+
 	default:
 		BT_DBG("Unknown command code 0x%2.2x", code);
 
@@ -523,3 +553,83 @@ done:
 	kfree_skb(skb);
 	return err;
 }
+
+int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
+{
+	struct smp_cmd_pairing *req, *rsp;
+	__u8 *keydist;
+
+	BT_DBG("conn %p force %d", conn, force);
+
+	if (IS_ERR(conn->hcon->hdev->tfm))
+		return PTR_ERR(conn->hcon->hdev->tfm);
+
+	rsp = (void *) &conn->prsp[1];
+
+	/* The responder sends its keys first */
+	if (!force && conn->hcon->out && (rsp->resp_key_dist & 0x07))
+		return 0;
+
+	req = (void *) &conn->preq[1];
+
+	if (conn->hcon->out) {
+		keydist = &rsp->init_key_dist;
+		*keydist &= req->init_key_dist;
+	} else {
+		keydist = &rsp->resp_key_dist;
+		*keydist &= req->resp_key_dist;
+	}
+
+
+	BT_DBG("keydist 0x%x", *keydist);
+
+	if (*keydist & SMP_DIST_ENC_KEY) {
+		struct smp_cmd_encrypt_info enc;
+		struct smp_cmd_master_ident ident;
+		__le16 ediv;
+
+		get_random_bytes(enc.ltk, sizeof(enc.ltk));
+		get_random_bytes(&ediv, sizeof(ediv));
+		get_random_bytes(ident.rand, sizeof(ident.rand));
+
+		smp_send_cmd(conn, SMP_CMD_ENCRYPT_INFO, sizeof(enc), &enc);
+
+		ident.ediv = cpu_to_le16(ediv);
+
+		smp_send_cmd(conn, SMP_CMD_MASTER_IDENT, sizeof(ident), &ident);
+
+		*keydist &= ~SMP_DIST_ENC_KEY;
+	}
+
+	if (*keydist & SMP_DIST_ID_KEY) {
+		struct smp_cmd_ident_addr_info addrinfo;
+		struct smp_cmd_ident_info idinfo;
+
+		/* Send a dummy key */
+		get_random_bytes(idinfo.irk, sizeof(idinfo.irk));
+
+		smp_send_cmd(conn, SMP_CMD_IDENT_INFO, sizeof(idinfo), &idinfo);
+
+		/* Just public address */
+		memset(&addrinfo, 0, sizeof(addrinfo));
+		bacpy(&addrinfo.bdaddr, conn->src);
+
+		smp_send_cmd(conn, SMP_CMD_IDENT_ADDR_INFO, sizeof(addrinfo),
+								&addrinfo);
+
+		*keydist &= ~SMP_DIST_ID_KEY;
+	}
+
+	if (*keydist & SMP_DIST_SIGN) {
+		struct smp_cmd_sign_info sign;
+
+		/* Send a dummy key */
+		get_random_bytes(sign.csrk, sizeof(sign.csrk));
+
+		smp_send_cmd(conn, SMP_CMD_SIGN_INFO, sizeof(sign), &sign);
+
+		*keydist &= ~SMP_DIST_SIGN;
+	}
+
+	return 0;
+}
-- 
1.7.5.4

