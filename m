Return-Path: <cyrus@holtmann.org>
Date: Fri, 17 Oct 2014 17:01:17 +0200
From: Alexander Aring <alex.aring@gmail.com>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: roy.qing.li@gmail.com, linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com
Subject: Re: [PATCH] Bluetooth: 6lowpan: remove unnecessary codes in
 give_skb_to_upper
Message-ID: <20141017150114.GA27094@omega>
References: <1413426115-17077-1-git-send-email-roy.qing.li@gmail.com>
 <1413551445.2705.152.camel@jrissane-mobl.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1413551445.2705.152.camel@jrissane-mobl.ger.corp.intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

On Fri, Oct 17, 2014 at 04:10:45PM +0300, Jukka Rissanen wrote:
> Hi,
> 
> On to, 2014-10-16 at 10:21 +0800, roy.qing.li@gmail.com wrote:
> > From: Li RongQing <roy.qing.li@gmail.com>
> > 
> > netif_rx() only returns NET_RX_DROP and NET_RX_SUCCESS, not returns
> > negative value
> > 
> > Signed-off-by: Li RongQing <roy.qing.li@gmail.com>
> > ---
> >  net/bluetooth/6lowpan.c |    9 +--------
> >  1 file changed, 1 insertion(+), 8 deletions(-)
> > 
> > diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> > index c2e0d14..9b5c89b 100644
> > --- a/net/bluetooth/6lowpan.c
> > +++ b/net/bluetooth/6lowpan.c
> > @@ -249,19 +249,12 @@ static struct lowpan_dev *lookup_dev(struct l2cap_conn *conn)
> >  static int give_skb_to_upper(struct sk_buff *skb, struct net_device *dev)
> >  {
> >  	struct sk_buff *skb_cp;
> > -	int ret;
> >  
> >  	skb_cp = skb_copy(skb, GFP_ATOMIC);
> >  	if (!skb_cp)
> >  		return -ENOMEM;
> >  
> > -	ret = netif_rx(skb_cp);
> > -	if (ret < 0) {
> > -		BT_DBG("receive skb %d", ret);
> > -		return NET_RX_DROP;
> > -	}
> > -
> > -	return ret;
> > +	return netif_rx(skb_cp);
> >  }
> >  
> >  static int process_data(struct sk_buff *skb, struct net_device *netdev,
> 
> Ack to this.
> 

Just for notice: this doesn't fix anything, because it's currently
broken.

This is part of issue that lowpan_process_data returns sometimes errno
and (NET_RX_DROP or NET_RX_SUCCESS).

Martin tries to fix this issue, but it seems that this isn't easy.

The lowpan_process_data function still returns sometimes a errno or
NET_RX_DROP. So a check on (ret < 0) or (ret == NET_RX_DROP) doesn't
work. I mean this patch is okay for me, but there still are some
problems around. :-)

Simple we can't return errno or NET_RX_FOO in lowpan_process_data, but I
am sure Martin still working on a fix for this issue. We need to change
everything to returning errno's only.

- Alex
