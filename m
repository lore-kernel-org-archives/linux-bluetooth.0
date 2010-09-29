Return-Path: <cyrus@holtmann.org>
Date: Wed, 29 Sep 2010 16:12:29 +0300
From: Ville Tervo <ville.tervo@nokia.com>
To: ext haijun liu <liuhaijun.er@gmail.com>
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Mat Martineau <mathewm@codeaurora.org>,
	"dantian.ip" <dantian.ip@gmail.com>
Subject: Re: [PATCH] Bluetooth: Replace hard code of configuration
 continuation flag.
Message-ID: <20100929131229.GK1931@null>
References: <AANLkTi=mS2212wTd3nu_ENJ8ySyNSVMWgTmc-MT0421c@mail.gmail.com>
 <20100928234820.GB8518@vigoh>
 <AANLkTi=EVEwuKy3QwNJ1sVpe2_EJCkQQ3iGutKQQRneU@mail.gmail.com>
 <20100929113615.GH1931@null>
 <AANLkTi=tyZ4rsn8QtqV8b04=f=1QA9qwJW03PQzroJ7O@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTi=tyZ4rsn8QtqV8b04=f=1QA9qwJW03PQzroJ7O@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Sep 29, 2010 at 02:42:35PM +0200, ext haijun liu wrote:
> Hi Ville,
> Do you mean l2cap_config_rsp()?

No. I meant change like this in addition to your changes.

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index efcf510..7a9c194 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2989,7 +2989,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
                /* Incomplete config. Send empty response. */
                l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP,
                                l2cap_build_conf_rsp(sk, rsp,
-                                       L2CAP_CONF_SUCCESS, 0x0001), rsp);
+                                       L2CAP_CONF_SUCCESS, L2CAP_CONF_FLAG_CONT), rsp);
                goto unlock;
        }


> I made it, but I don't why gmail hide that part.

I got the whole message.

-- 
Ville
