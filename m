Return-Path: <cyrus@holtmann.org>
Message-ID: <1413555639.2705.156.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCH] Bluetooth: 6lowpan: remove unnecessary codes in
 give_skb_to_upper
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: roy.qing.li@gmail.com, linux-bluetooth@vger.kernel.org, "Gustavo F.
	Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>
Date: Fri, 17 Oct 2014 17:20:39 +0300
In-Reply-To: <CE81865A-F3BE-4177-BF79-E66CFAAFEA72@holtmann.org>
References: <1413426115-17077-1-git-send-email-roy.qing.li@gmail.com>
	 <1413551445.2705.152.camel@jrissane-mobl.ger.corp.intel.com>
	 <CE81865A-F3BE-4177-BF79-E66CFAAFEA72@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On pe, 2014-10-17 at 16:08 +0200, Marcel Holtmann wrote:
> Hi Jukka,
> 
> >> From: Li RongQing <roy.qing.li@gmail.com>
> >> 
> >> netif_rx() only returns NET_RX_DROP and NET_RX_SUCCESS, not returns
> >> negative value
> >> 
> >> Signed-off-by: Li RongQing <roy.qing.li@gmail.com>
> >> ---
> >> net/bluetooth/6lowpan.c |    9 +--------
> >> 1 file changed, 1 insertion(+), 8 deletions(-)
> >> 
> >> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> >> index c2e0d14..9b5c89b 100644
> >> --- a/net/bluetooth/6lowpan.c
> >> +++ b/net/bluetooth/6lowpan.c
> >> @@ -249,19 +249,12 @@ static struct lowpan_dev *lookup_dev(struct l2cap_conn *conn)
> >> static int give_skb_to_upper(struct sk_buff *skb, struct net_device *dev)
> >> {
> >> 	struct sk_buff *skb_cp;
> >> -	int ret;
> >> 
> >> 	skb_cp = skb_copy(skb, GFP_ATOMIC);
> >> 	if (!skb_cp)
> >> 		return -ENOMEM;
> >> 
> >> -	ret = netif_rx(skb_cp);
> >> -	if (ret < 0) {
> >> -		BT_DBG("receive skb %d", ret);
> >> -		return NET_RX_DROP;
> >> -	}
> >> -
> >> -	return ret;
> >> +	return netif_rx(skb_cp);
> >> }
> >> 
> >> static int process_data(struct sk_buff *skb, struct net_device *netdev,
> > 
> > Ack to this.
> > 
> > Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> 
> this should be acked-by or reviewed-by and not signed-off-by. The signed-off-by is only if you would send Roy's original patch on his behalf or you would be in the chain of sending patches along the maintainer trees.

Do'h! Yep, I meant to say Acked-by (too many things going on same
time :)

Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>


> 
> Regards
> 
> Marcel
> 


Cheers,
Jukka
