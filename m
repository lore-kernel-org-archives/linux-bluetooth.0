Return-Path: <cyrus@holtmann.org>
Subject: Re: [patch -next] bluetooth/hci_ath: kfree() => kfree_skb()
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: Dan Carpenter <error27@gmail.com>,
	Suraj Sumangala <suraj@atheros.com>,
	linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20100723181053.GN2620@vigoh>
References: <20100723101104.GD26313@bicker>  <20100723181053.GN2620@vigoh>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Jul 2010 15:28:58 -0700
Message-ID: <1280269738.2621.94.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dan,

> > sk_buffs have to be freed with kfree_skb() instead of kfree().
> > 
> > Signed-off-by: Dan Carpenter <error27@gmail.com>
> > 
> > diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
> > index 5ab258b..74a8f61 100755
> > --- a/drivers/bluetooth/hci_ath.c
> > +++ b/drivers/bluetooth/hci_ath.c
> > @@ -163,7 +163,7 @@ static int ath_enqueue(struct hci_uart *hu, struct sk_buff *skb)
> >  	struct ath_struct *ath = hu->priv;
> >  
> >  	if (bt_cb(skb)->pkt_type == HCI_SCODATA_PKT) {
> > -		kfree(skb);
> > +		kfree_skb(skb);
> >  		return 0;
> >  	}
> 
> Acked-by: Gustavo F. Padovan <padovan@profusion.mobi>

patch has been applied. Thanks.

Regards

Marcel


