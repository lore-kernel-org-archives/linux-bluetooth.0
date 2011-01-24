Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 Jan 2011 17:09:13 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Elvis =?iso-8859-1?Q?Pf=FCtzenreuter?= <epx@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Problems with L2CAP: deferred setup and MTU
Message-ID: <20110124190913.GB4300@joana>
References: <5E5308B0-BA11-46A2-B7A9-22CD4ADBCF80@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <5E5308B0-BA11-46A2-B7A9-22CD4ADBCF80@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

* Elvis Pfützenreuter <epx@signove.com> [2011-01-19 17:10:51 -0200]:

> I am currently investigating two problems with L2CAP sockets. Since I am not a kernel guy, I will take an indefinite amount of time to find and fix them; perhaps someone else can find and fix it in 5 minutes, so I think it is worth reporting.
> 
> First problem is ERTM x MTU, sockets configured with a MTU != 672. Normal sockets exchange MTU in initialization:
> 
> ./l2test -P 4099 -I 1000 -O 1000
> l2test[3211]: Connect from 00:1B:DC:0F:C8:A9 [imtu 1000, omtu 1000, flush_to 65535, mode 0, handle 12, class 0x480100]
> 
> but ERTM sockets seem to ignore the setsockopt() value and exchange the default size (672):
> 
> ./l2test -P 4099 -I 1000 -O 1000 -X ERTM
> l2test[3228]: Connect from 00:1B:DC:0F:C8:A9 [imtu 1000, omtu 672, flush_to 65535, mode 3, handle 11, class 0x480100]
> 
> (obviously the initiator side uses the same parameters)

I pushed I fix for this to bluetooth-next-2.6

Author: Gustavo F. Padovan <padovan@profusion.mobi>
Date:   Mon Jan 24 16:01:43 2011 -0200

    Bluetooth: Fix setting of MTU for ERTM and Streaming Mode
    
    The desired MTU should be sent in an Config_Req for all modes.
    
    Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index ff191b9..1ee18c6 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -2588,11 +2588,11 @@ static int l2cap_build_conf_req(struct sock *sk, void *data)
        }
 
 done:
+       if (pi->imtu != L4CAP_DEFAULT_MTU)
+               l2cap_add_conf_opt(&ptr, L2CAP_CONF_MTU, 2, pi->imtu);
+
        switch (pi->mode) {
        case L2CAP_MODE_BASIC:
-               if (pi->imtu != L2CAP_DEFAULT_MTU)
-                       l2cap_add_conf_opt(&ptr, L2CAP_CONF_MTU, 2, pi->imtu);
-
                if (!(pi->conn->feat_mask & L2CAP_FEAT_ERTM) &&
                                !(pi->conn->feat_mask & L2CAP_FEAT_STREAMING))
                        break;


-- 
Gustavo F. Padovan
http://profusion.mobi
