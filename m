Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Subject: Re: [RFC] Bluetooth: Fix compile warning in l2cap_core.c
Date: Wed, 6 Jun 2012 09:58:32 +0200
CC: Gustavo Padovan <gustavo@padovan.org>,
	Andre Guedes <andre.guedes@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <1338507556-10920-1-git-send-email-andre.guedes@openbossa.org> <20120606043859.GA2533@joana> <20120606073320.GA2754@aemeltch-MOBL1>
In-Reply-To: <20120606073320.GA2754@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-ID: <201206060958.32857.szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

(as plain text this time...)

> > > I'm not sure this is a false positive. If remote device misbehaves and
> > > sends bogus L2CAP_CONF_RFC with wrong length (as Szymon said) we go to
> > > "done" label and 'rfc' is used uninitialized.
> 
> what is not OK is that double conversion.

Maybe sth like that? This function is expected to extract only conf_rfc anyway..

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index f9bffe3..42b8af6 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3273,12 +3273,14 @@ static void l2cap_conf_rfc_get(struct l2cap_chan *chan, void *rsp, int len)
        while (len >= L2CAP_CONF_OPT_SIZE) {
                len -= l2cap_get_conf_opt(&rsp, &type, &olen, &val);
 
-               switch (type) {
-               case L2CAP_CONF_RFC:
-                       if (olen == sizeof(rfc))
-                               memcpy(&rfc, (void *)val, olen);
-                       goto done;
-               }
+               if (type != L2CAP_CONF_RFC)
+                       continue;
+
+               if (olen != sizeof(rfc))
+                       break;
+
+               memcpy(&rfc, (void *)val, olen);
+               goto done;
        }

        /* Use sane default values in case a misbehaving remote device

-- 
BR
Szymon Janc
