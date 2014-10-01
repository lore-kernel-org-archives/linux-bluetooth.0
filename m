Return-Path: <cyrus@holtmann.org>
Message-ID: <1412149892.4860.137.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCH] Bluetooth: 6lowpan: Memory leak as the skb is not freed
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 01 Oct 2014 10:51:32 +0300
In-Reply-To: <20141001070852.GD23043@omega>
References: <1412146853-1968-1-git-send-email-jukka.rissanen@linux.intel.com>
	 <20141001070852.GD23043@omega>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On ke, 2014-10-01 at 09:08 +0200, Alexander Aring wrote:
> Hi Jukka,
> 
> On Wed, Oct 01, 2014 at 10:00:53AM +0300, Jukka Rissanen wrote:
> > The earlier multicast commit 36b3dd250dde ("Bluetooth: 6lowpan:
> > Ensure header compression does not corrupt IPv6 header") lost one
> > skb free which then caused memory leak.
> > 
> > Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> > ---
> >  net/bluetooth/6lowpan.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> > index f0432ae..bcbee3d 100644
> > --- a/net/bluetooth/6lowpan.c
> > +++ b/net/bluetooth/6lowpan.c
> > @@ -625,6 +625,8 @@ static netdev_tx_t bt_xmit(struct sk_buff *skb, struct net_device *netdev)
> >  		send_mcast_pkt(skb, netdev);
> >  	}
> >  
> > +	kfree_skb(skb);
> > +
> 
> not dropping afterwards? Then this should be consume_skb or
> dev_kfree_skb.

Ok, will change that.

> 
> Also I detected we can't make:
> 
> 	skb = skb_unshare(skb, GFP_ATOMIC);
> 	if (!skb)
> 		return NET_XMIT_DROP;
> 
> We need something like:
> 
> 	tmpskb = skb_unshare(skb, GFP_ATOMIC);
> 	if (!tmpskb) {
> 		kfree_skb(skb);
> 		return NET_XMIT_DROP;
> 	}
> 	skb = tmpskb;
> 

Sure, thanks for the info.

> 
> - Alex


Cheers,
Jukka


