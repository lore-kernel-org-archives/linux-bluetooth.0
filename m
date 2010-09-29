Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100928234820.GB8518@vigoh>
References: <AANLkTi=mS2212wTd3nu_ENJ8ySyNSVMWgTmc-MT0421c@mail.gmail.com> <20100928234820.GB8518@vigoh>
From: haijun liu <liuhaijun.er@gmail.com>
Date: Wed, 29 Sep 2010 19:12:39 +0800
Message-ID: <AANLkTi=EVEwuKy3QwNJ1sVpe2_EJCkQQ3iGutKQQRneU@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Replace hard code of configuration
 continuation flag.
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org,
	Mat Martineau <mathewm@codeaurora.org>,
	"dantian.ip" <dantian.ip@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

 Replace hard code of configuration continuation flag with self-comment macro.


Signed-off-by: Haijun.Liu <haijun.liu@atheros.com>
---
 include/net/bluetooth/l2cap.h |    2 ++
 net/bluetooth/l2cap_core.c    |    4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index df599dc..2b114ca 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -193,6 +193,8 @@ struct l2cap_conf_rsp {
 #define L2CAP_CONF_REJECT	0x0002
 #define L2CAP_CONF_UNKNOWN	0x0003

+#define L2CAP_CONF_FLAG_CONT	0x0001
+
 struct l2cap_conf_opt {
 	__u8       type;
 	__u8       len;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index efcf510..bef5c9f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2985,7 +2985,7 @@ static inline int l2cap_config_req(struct
l2cap_conn *conn, struct l2cap_cmd_hdr
 	memcpy(l2cap_pi(sk)->conf_req + l2cap_pi(sk)->conf_len, req->data, len);
 	l2cap_pi(sk)->conf_len += len;

-	if (flags & 0x0001) {
+	if (flags & L2CAP_CONF_FLAG_CONT) {
 		/* Incomplete config. Send empty response. */
 		l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP,
 				l2cap_build_conf_rsp(sk, rsp,
@@ -3092,7 +3092,7 @@ static inline int l2cap_config_rsp(struct
l2cap_conn *conn, struct l2cap_cmd_hdr
 		goto done;
 	}

-	if (flags & 0x01)
+	if (flags & L2CAP_CONF_FLAG_CONT)
 		goto done;

 	l2cap_pi(sk)->conf_state |= L2CAP_CONF_INPUT_DONE;
-- 
1.6.3.3
