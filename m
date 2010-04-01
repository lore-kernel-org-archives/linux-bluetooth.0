Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi
Subject: [PATCH 21/34] Bluetooth: Read RFC conf option on a successful Conf RSP
Date: Thu,  1 Apr 2010 17:23:39 -0300
Message-Id: <1270153432-6477-22-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1270153432-6477-21-git-send-email-padovan@profusion.mobi>
References: <1270153432-6477-1-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-2-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-3-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-4-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-5-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-6-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-7-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-8-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-9-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-10-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-11-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-12-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-13-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-14-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-15-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-16-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-17-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-18-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-19-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-20-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-21-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Enhanced Retransmission Mode and Streaming Mode a entity can send, on
a successful Conf RSP, new values for the RFC fields. For example, the
entity can send txWindow and MPS values less than the value received on
a Conf REQ.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/l2cap.c |   39 ++++++++++++++++++++++++++++++++++++++-
 1 files changed, 38 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 2cfad45..40aff8d 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -2598,6 +2598,42 @@ static int l2cap_build_conf_rsp(struct sock *sk, void *data, u16 result, u16 fla
 	return ptr - data;
 }
 
+static void l2cap_conf_rfc_get(struct sock *sk, void *rsp, int len)
+{
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	int type, olen;
+	unsigned long val;
+	struct l2cap_conf_rfc rfc;
+
+	BT_DBG("sk %p, rsp %p, len %d", sk, rsp, len);
+
+	if ((pi->mode != L2CAP_MODE_ERTM) && (pi->mode != L2CAP_MODE_STREAMING))
+		return;
+
+	while (len >= L2CAP_CONF_OPT_SIZE) {
+		len -= l2cap_get_conf_opt(&rsp, &type, &olen, &val);
+
+		switch (type) {
+		case L2CAP_CONF_RFC:
+			if (olen == sizeof(rfc))
+				memcpy(&rfc, (void *)val, olen);
+			goto done;
+		}
+	}
+
+done:
+	switch (rfc.mode) {
+	case L2CAP_MODE_ERTM:
+		pi->remote_tx_win   = rfc.txwin_size;
+		pi->retrans_timeout = rfc.retrans_timeout;
+		pi->monitor_timeout = rfc.monitor_timeout;
+		pi->mps    = le16_to_cpu(rfc.max_pdu_size);
+		break;
+	case L2CAP_MODE_STREAMING:
+		pi->mps    = le16_to_cpu(rfc.max_pdu_size);
+	}
+}
+
 static inline int l2cap_command_rej(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd, u8 *data)
 {
 	struct l2cap_cmd_rej *rej = (struct l2cap_cmd_rej *) data;
@@ -2877,6 +2913,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	struct l2cap_conf_rsp *rsp = (struct l2cap_conf_rsp *)data;
 	u16 scid, flags, result;
 	struct sock *sk;
+	int len = cmd->len - sizeof(*rsp);
 
 	scid   = __le16_to_cpu(rsp->scid);
 	flags  = __le16_to_cpu(rsp->flags);
@@ -2891,11 +2928,11 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 
 	switch (result) {
 	case L2CAP_CONF_SUCCESS:
+		l2cap_conf_rfc_get(sk, rsp->data, len);
 		break;
 
 	case L2CAP_CONF_UNACCEPT:
 		if (l2cap_pi(sk)->num_conf_rsp <= L2CAP_CONF_MAX_CONF_RSP) {
-			int len = cmd->len - sizeof(*rsp);
 			char req[64];
 
 			if (len > sizeof(req) - sizeof(struct l2cap_conf_req)) {
-- 
1.6.4.4
