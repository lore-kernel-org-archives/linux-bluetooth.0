Return-Path: <cyrus@holtmann.org>
From: "Malovany, Ram" <ramm@ti.com>
To: Gustavo Padovan <gustavo@padovan.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH] Bluetooth: Fix for double free of st buffer.
Date: Wed, 25 Jul 2012 08:00:32 +0000
Message-ID: <2683478DEE33CD4DAF508ABCF391F6A40B4B494D@DNCE05.ent.ti.com>
References: <1342511370-26470-1-git-send-email-ramm@ti.com>
 <20120724230124.GL20029@joana>
In-Reply-To: <20120724230124.GL20029@joana>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HI Gustavo,

> -----Original Message-----
> From: Gustavo Padovan [mailto:gustavo@padovan.org]
> Sent: Wednesday, July 25, 2012 2:01 AM
> To: Malovany, Ram
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH] Bluetooth: Fix for double free of st buffer.
> 
> Hi Ram,
> 
> * ramm@ti.com <ramm@ti.com> [2012-07-17 10:49:30 +0300]:
> 
> > From: Ram Malovany <ramm@ti.com>
> >
> > When the Shared Transport line discipline driver (st_core) get data it
> > pushes the skb received to the relevant protocol stacks , it then
> > excepts that the relevant protocol stacks should handle the buffer ,
> > and if it cannot then the stack should respond with an error.
> > In our case the Bluetooth driver for shared transport (btwilink) should
> > always be able to handle the buffer , in case of an error it will
> > release it , thus we always should return 0.
> >
> > Signed-off-by: Ram Malovany <ramm@ti.com>
> > ---
> >  drivers/bluetooth/btwilink.c |   12 ++++++++----
> >  1 files changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btwilink.c b/drivers/bluetooth/btwilink.c
> > index 8869469..1f60d84 100644
> > --- a/drivers/bluetooth/btwilink.c
> > +++ b/drivers/bluetooth/btwilink.c
> > @@ -94,18 +94,22 @@ static void st_reg_completion_cb(void *priv_data, char
> data)
> >  }
> >
> >  /* Called by Shared Transport layer when receive data is
> > - * available */
> > + * available
> > + * Return:
> > + * 0 if buffer handled (affectivly allways even if error found)
> > + * if return !=0 the buffer will be freed by the st
> > + */
> >  static long st_receive(void *priv_data, struct sk_buff *skb)
> >  {
> >  	struct ti_st *lhst = priv_data;
> >  	int err;
> >
> >  	if (!skb)
> > -		return -EFAULT;
> > +		return 0;
> >
> >  	if (!lhst) {
> >  		kfree_skb(skb);
> 
> If you remove this call to kfree_skb() from here doesn't it fixes your
> problem?
> 
> 	Gustavo

You are correct , I was going to send a new version for this patch.

Thanks,
Ram
