Return-Path: <cyrus@holtmann.org>
From: ngh@isomerica.net
To: linux-bluetooth@vger.kernel.org
Cc: Nathan Holstein <nathan@lampreynetworks.com>
Subject: [PATCH] Add support for negotiating new L2CAP options after a failed configuration
Date: Wed, 29 Apr 2009 21:42:24 -0400
Message-Id: <1241055744-12140-2-git-send-email-ngh@isomerica.net>
In-Reply-To: <1241055744-12140-1-git-send-email-ngh@isomerica.net>
References: <1241055744-12140-1-git-send-email-ngh@isomerica.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Nathan Holstein <nathan@lampreynetworks.com>

When negotiating the configuration of an L2CAP socket, the remote may reject
the initial configuration that was sent.  This patch adds allows selecting
differing configuration values.
---
 net/bluetooth/l2cap.c |  106 ++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 97 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 7505137..528c72d 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -2016,6 +2016,70 @@ static int l2cap_parse_conf_req(struct sock *sk, void *data)
 	return ptr - data;
 }
 
+static inline int l2cap_parse_conf_rsp(struct sock *sk, void *rsp, int len, void *_req, u16 *result)
+{
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	struct l2cap_conf_req *req = _req;
+	void *ptr = req->data;
+	int type, hint, olen;
+	unsigned long val;
+	struct l2cap_conf_rfc rfc;
+
+	BT_DBG("sk %p, rsp %p, len %d, req %p", sk, rsp, len, _req);
+
+	while (len >= L2CAP_CONF_OPT_SIZE) {
+		len -= l2cap_get_conf_opt(&rsp, &type, &olen, &val);
+
+		hint  = type & L2CAP_CONF_HINT;
+		type &= 0x7f;
+
+		switch (type) {
+		case L2CAP_CONF_MTU:
+			if (val < L2CAP_CONF_MIN_MTU)
+			{
+				*result = L2CAP_CONF_UNACCEPT;
+				pi->omtu = L2CAP_CONF_MIN_MTU;
+			}
+			else
+				pi->omtu = val;
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_MTU, 2, pi->omtu);
+			break;
+
+		case L2CAP_CONF_FLUSH_TO:
+			pi->flush_to = val;
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_FLUSH_TO, 2,
+						pi->flush_to);
+			break;
+
+		case L2CAP_CONF_QOS:
+			break;
+
+		case L2CAP_CONF_RFC:
+			/* Currently, the code does not support negotiating to
+			 * use a different mode than was initially created. This
+			 * can be used for switching between ERTM/Streaming, and
+			 * will be useful for implementing MCAP/HDP on top of
+			 * eL2CAP. */
+			*result = L2CAP_CONF_UNACCEPT;
+			if (pi->mode == L2CAP_MODE_BASIC)
+				pi->fcs = 0;
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC,
+						sizeof(rfc), (unsigned long) &rfc);
+			break;
+
+		case L2CAP_CONF_FCS:
+			pi->fcs = val;
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_FCS, 1, pi->fcs);
+		}
+	}
+
+	req->dcid   = cpu_to_le16(pi->dcid);
+	req->flags  = cpu_to_le16(0x0000);
+
+	BT_DBG("ptr %p, req->data %p", ptr, req->data);
+	return ptr - _req;
+}
+
 static int l2cap_build_conf_rsp(struct sock *sk, void *data, u16 result, u16 flags)
 {
 	struct l2cap_conf_rsp *rsp = data;
@@ -2237,6 +2301,15 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	if (sk->sk_state == BT_DISCONN)
 		goto unlock;
 
+	/* Reject if connected and in eL2CAP mode. */
+	if (sk->sk_state == BT_CONNECTED && l2cap_pi(sk)->mode != L2CAP_MODE_BASIC)
+	{
+		l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP,
+				l2cap_build_conf_rsp(sk, rsp,
+					L2CAP_CONF_REJECT, flags), rsp);
+		goto unlock;
+	}
+
 	/* Reject if config buffer is too small. */
 	len = cmd_len - sizeof(*req);
 	if (l2cap_pi(sk)->conf_len + len > sizeof(l2cap_pi(sk)->conf_req)) {
@@ -2305,21 +2378,36 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	if (!sk)
 		return 0;
 
+	/* Reject if connected and in eL2CAP mode. */
+	if (sk->sk_state == BT_CONNECTED && l2cap_pi(sk)->mode != L2CAP_MODE_BASIC)
+	{
+		l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP,
+				l2cap_build_conf_rsp(sk, rsp,
+					L2CAP_CONF_REJECT, flags), rsp);
+		goto done;
+	}
+
 	switch (result) {
 	case L2CAP_CONF_SUCCESS:
 		break;
 
 	case L2CAP_CONF_UNACCEPT:
 		if (++l2cap_pi(sk)->conf_retry < L2CAP_CONF_MAX_RETRIES) {
-			char req[128];
-			/* It does not make sense to adjust L2CAP parameters
-			 * that are currently defined in the spec. We simply
-			 * resend config request that we sent earlier. It is
-			 * stupid, but it helps qualification testing which
-			 * expects at least some response from us. */
-			l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
-						l2cap_build_conf_req(sk, req), req);
-			goto done;
+			int len = cmd->len - sizeof(*rsp);
+			char req[64];
+
+			/* throw out any old conf requests we stored */
+			result = L2CAP_CONF_SUCCESS;
+			len = l2cap_parse_conf_rsp(sk, rsp->data, len, req,
+					&result);
+
+			BT_DBG("len %d", len);
+			l2cap_send_cmd(conn, l2cap_get_ident(conn),
+						L2CAP_CONF_REQ, len, req);
+			if (result == L2CAP_CONF_SUCCESS)
+				break;
+			else
+				goto done;
 		}
 
 	default:
-- 
1.6.0.6

