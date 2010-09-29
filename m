Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100928234934.GC8518@vigoh>
References: <AANLkTimQtkORjmsiO3wPULRErNXORBtHATbBvdCEsY27@mail.gmail.com> <20100928234934.GC8518@vigoh>
From: haijun liu <liuhaijun.er@gmail.com>
Date: Wed, 29 Sep 2010 19:11:29 +0800
Message-ID: <AANLkTikz3VTGtL5PY2nAXKO1z_XD4ROEZyUV3JXsrstn@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: Update conf_state before send config_req out.
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"dantian.ip" <dantian.ip@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

 Update conf_state with L2CAP_CONF_REQ_SENT before send
 config_req out in l2cap_config_req().


Signed-off-by: Haijun.Liu <haijun.liu@atheros.com>
---
 net/bluetooth/l2cap_core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index bef5c9f..f461fee 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3026,6 +3026,7 @@ static inline int l2cap_config_req(struct
l2cap_conn *conn, struct l2cap_cmd_hdr

 	if (!(l2cap_pi(sk)->conf_state & L2CAP_CONF_REQ_SENT)) {
 		u8 buf[64];
+		l2cap_pi(sk)->conf_state |= L2CAP_CONF_REQ_SENT;
 		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
 					l2cap_build_conf_req(sk, buf), buf);
 		l2cap_pi(sk)->num_conf_req++;
-- 
1.6.3.3
