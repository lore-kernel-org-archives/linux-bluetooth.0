Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH] Bluetooth: Resend ConfigReq on unknown options failure
Date: Wed, 28 Jul 2010 04:11:20 -0300
Message-Id: <1280301080-565-1-git-send-email-gustavo@padovan.org>
In-Reply-To: <20100728033225.GB22156@vigoh>
References: <20100728033225.GB22156@vigoh>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo F. Padovan <padovan@profusion.mobi>

If the remote device send a ConfigRsp with the unknown options failure we
should remove that option from the ConfigReq and send it again.
This patch only remove the RFC option in the case it is a unknown option.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |   17 +++++++++--------
 net/bluetooth/l2cap.c         |   28 ++++++++++++++++++++++++----
 2 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 636724b..407af2b 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -373,14 +373,15 @@ struct l2cap_pinfo {
 	struct sock		*prev_c;
 };
 
-#define L2CAP_CONF_REQ_SENT       0x01
-#define L2CAP_CONF_INPUT_DONE     0x02
-#define L2CAP_CONF_OUTPUT_DONE    0x04
-#define L2CAP_CONF_MTU_DONE       0x08
-#define L2CAP_CONF_MODE_DONE      0x10
-#define L2CAP_CONF_CONNECT_PEND   0x20
-#define L2CAP_CONF_NO_FCS_RECV    0x40
-#define L2CAP_CONF_STATE2_DEVICE  0x80
+#define L2CAP_CONF_REQ_SENT       0x0001
+#define L2CAP_CONF_INPUT_DONE     0x0002
+#define L2CAP_CONF_OUTPUT_DONE    0x0004
+#define L2CAP_CONF_MTU_DONE       0x0008
+#define L2CAP_CONF_MODE_DONE      0x0010
+#define L2CAP_CONF_CONNECT_PEND   0x0020
+#define L2CAP_CONF_NO_FCS_RECV    0x0040
+#define L2CAP_CONF_STATE2_DEVICE  0x0080
+#define L2CAP_CONF_RFC_UNKNOWN    0x0200
 
 #define L2CAP_CONF_MAX_CONF_REQ 2
 #define L2CAP_CONF_MAX_CONF_RSP 2
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 9ba1e8e..dc435a3 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -2577,8 +2577,9 @@ done:
 		break;
 	}
 
-	l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
-						(unsigned long) &rfc);
+	if (!(pi->conf_state & L2CAP_CONF_RFC_UNKNOWN))
+		l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
+							(unsigned long) &rfc);
 
 	/* FIXME: Need actual value of the flush timeout */
 	//if (flush_to != L2CAP_DEFAULT_FLUSH_TO)
@@ -2748,12 +2749,15 @@ static int l2cap_parse_conf_rsp(struct sock *sk, void *rsp, int len, void *data,
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	struct l2cap_conf_req *req = data;
 	void *ptr = req->data;
-	int type, olen;
+	int type, olen, unknown = 0;
 	unsigned long val;
 	struct l2cap_conf_rfc rfc;
 
 	BT_DBG("sk %p, rsp %p, len %d, req %p", sk, rsp, len, data);
 
+	if (*result == L2CAP_CONF_UNKNOWN)
+		unknown = 1;
+
 	while (len >= L2CAP_CONF_OPT_SIZE) {
 		len -= l2cap_get_conf_opt(&rsp, &type, &olen, &val);
 
@@ -2774,6 +2778,11 @@ static int l2cap_parse_conf_rsp(struct sock *sk, void *rsp, int len, void *data,
 			break;
 
 		case L2CAP_CONF_RFC:
+			if (unknown) {
+				pi->conf_state |= L2CAP_CONF_RFC_UNKNOWN;
+				break;
+			}
+
 			if (olen == sizeof(rfc))
 				memcpy(&rfc, (void *)val, olen);
 
@@ -3161,6 +3170,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	u16 scid, flags, result;
 	struct sock *sk;
 	int len = cmd->len - sizeof(*rsp);
+	char req[64];
 
 	scid   = __le16_to_cpu(rsp->scid);
 	flags  = __le16_to_cpu(rsp->flags);
@@ -3180,7 +3190,6 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 
 	case L2CAP_CONF_UNACCEPT:
 		if (l2cap_pi(sk)->num_conf_rsp <= L2CAP_CONF_MAX_CONF_RSP) {
-			char req[64];
 
 			if (len > sizeof(req) - sizeof(struct l2cap_conf_req)) {
 				l2cap_send_disconn_req(conn, sk, ECONNRESET);
@@ -3203,6 +3212,17 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 				goto done;
 			break;
 		}
+	case L2CAP_CONF_UNKNOWN:
+		len = l2cap_parse_conf_rsp(sk, rsp->data,
+						len, req, &result);
+		if (len < 0) {
+			l2cap_send_disconn_req(conn, sk, ECONNRESET);
+			goto done;
+		}
+
+		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
+				l2cap_build_conf_req(sk, req), req);
+		goto done;
 
 	default:
 		sk->sk_err = ECONNRESET;
-- 
1.7.1.1

