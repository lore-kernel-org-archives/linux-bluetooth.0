Return-Path: <cyrus@holtmann.org>
Date: Wed, 1 Oct 2014 09:21:40 +0200
From: Alexander Aring <alex.aring@gmail.com>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: 6lowpan: Memory leak as the skb is not freed
Message-ID: <20141001072139.GE23043@omega>
References: <1412146853-1968-1-git-send-email-jukka.rissanen@linux.intel.com>
 <20141001070852.GD23043@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20141001070852.GD23043@omega>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Oct 01, 2014 at 09:08:52AM +0200, Alexander Aring wrote:
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

I mean it depends, I don't see that skb_unshare free the skb when
allocation failed and then we lost the reference to the skb which
should be unshared.

- Alex
