Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100929131229.GK1931@null>
References: <AANLkTi=mS2212wTd3nu_ENJ8ySyNSVMWgTmc-MT0421c@mail.gmail.com>
 <20100928234820.GB8518@vigoh> <AANLkTi=EVEwuKy3QwNJ1sVpe2_EJCkQQ3iGutKQQRneU@mail.gmail.com>
 <20100929113615.GH1931@null> <AANLkTi=tyZ4rsn8QtqV8b04=f=1QA9qwJW03PQzroJ7O@mail.gmail.com>
 <20100929131229.GK1931@null>
From: haijun liu <liuhaijun.er@gmail.com>
Date: Wed, 29 Sep 2010 21:33:09 +0800
Message-ID: <AANLkTin8muojCiTZ+1MZL7GLDs45MwsZBErmvzVaZy4a@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Replace hard code of configuration
 continuation flag.
To: Ville Tervo <ville.tervo@nokia.com>
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Mat Martineau <mathewm@codeaurora.org>,
	"dantian.ip" <dantian.ip@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Replace hard code of configuration continuation flag with self-comment macro.


Signed-off-by: Haijun.Liu <haijun.liu@atheros.com>
---
 net/bluetooth/l2cap_core.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index efcf510..279f98a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2985,11 +2985,11 @@ static inline int l2cap_config_req(struct
l2cap_conn *conn, struct l2cap_cmd_hdr
 	memcpy(l2cap_pi(sk)->conf_req + l2cap_pi(sk)->conf_len, req->data, len);
 	l2cap_pi(sk)->conf_len += len;

-	if (flags & 0x0001) {
+	if (flags & L2CAP_CONF_FLAG_CONT) {
 		/* Incomplete config. Send empty response. */
 		l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP,
 				l2cap_build_conf_rsp(sk, rsp,
-					L2CAP_CONF_SUCCESS, 0x0001), rsp);
+					L2CAP_CONF_SUCCESS, L2CAP_CONF_FLAG_CONT), rsp);
 		goto unlock;
 	}

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
