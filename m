Return-Path: <cyrus@holtmann.org>
Subject: Re: regression introduced on v2.6.30-rc1
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <2d5a2c100906211047n31b9d4dajac290601c184380b@mail.gmail.com>
References: <2d5a2c100906090617m167d3815pae998d06bdbd6646@mail.gmail.com>
	 <2d5a2c100906210708x1816e5d9hb9a80c82d76da6dd@mail.gmail.com>
	 <1245595707.15367.66.camel@violet>
	 <2d5a2c100906210930q394fcf77hcd2bf39c26ae74f8@mail.gmail.com>
	 <1245603529.15367.68.camel@violet>
	 <2d5a2c100906211047n31b9d4dajac290601c184380b@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 21 Jun 2009 21:04:56 +0200
Message-Id: <1245611096.15367.76.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> > did you actually test this change? And understand it?
> >
> 
> Yep, this was actually one of my first attempts to fix the problem and
> it make no difference, but the real problem is not rfcomm_dlc
> reference being hold it is currently rfcomm_session reference which
> are not released until the remote device respond with DISC dlci 0, but
> in case where the remote never respond this reference will be held
> forever which cause the ACL to never be disconnected.
> 
> There is 2 session reference being hold, one by rfcomm_dlc_link
> (core.c:321) which rfcomm_dlc_unlink should takes care and another one
> created on rfcomm_accept_connection (core.c:1837) which afaik won't go
> away if the remote device doesn't respond with a proper DISC to dlci
> 0.

stupid specification. It is just bloody stupid that we have to cleanup
someone else's stuff that we haven't initiated in the first place :(

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 374536e..864c3c4 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -466,6 +466,11 @@ static int __rfcomm_dlc_close(struct rfcomm_dlc *d, int err)
 
                skb_queue_purge(&d->tx_queue);
                rfcomm_dlc_unlink(d);
+
+               /* Specification demands to cleanup after remote
+                * initiated session when closing last DLC */
+               if (list_empty(&s->dlcs))
+                       rfcomm_session_put(s);
        }
 

The patch above should actually fix this, but it is neither compile nor
runtime tested.

If it actually break outgoing connections, which it might, then we have
to add a !d->out to the if statement here and move the whole statement
before rfcomm_dlc_unlink and skb_queue_purge. That is fine anyway since
the rfcomm_dlc_link will always hold at least one session reference
count.

Regards

Marcel


