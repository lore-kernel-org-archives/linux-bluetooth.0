Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1452767337.3292.7.camel@linux.intel.com>
Subject: Re: [PATCH] Bluetooth: 6lowpan: Fix kernel NULL pointer dereferences
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>,
	alex.aring@gmail.com
Cc: linux-bluetooth@vger.kernel.org, lukasz.duda@nordicsemi.no
Date: Thu, 14 Jan 2016 12:28:57 +0200
In-Reply-To: <1452699702-3986-1-git-send-email-glenn.ruben.bakke@nordicsemi.no>
References: <1452699702-3986-1-git-send-email-glenn.ruben.bakke@nordicsemi.no>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

looks good, ack from me.

Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>


On Wed, 2016-01-13 at 16:41 +0100, Glenn Ruben Bakke wrote:
> The fixes provided in this patch assigns a valid net_device structure
> to
> skb before dispatching it for further processing.
> 
> Scenario #1:
> ============
> 
> Bluetooth 6lowpan receives an uncompressed IPv6 header, and
> dispatches it
> to netif. The following error occurs:
> 
> Null pointer dereference error #1 crash log:
> 
> [  845.854013] BUG: unable to handle kernel NULL pointer dereference
> at
>                0000000000000048
> [  845.855785] IP: [<ffffffff816e3d36>] enqueue_to_backlog+0x56/0x240
> ...
> [  845.909459] Call Trace:
> [  845.911678]  [<ffffffff816e3f64>] netif_rx_internal+0x44/0xf0
> 
> The first modification fixes the NULL pointer dereference error by
> assigning dev to the local_skb in order to set a valid net_device
> before
> processing the skb by netif_rx_ni().
> 
> Scenario #2:
> ============
> 
> Bluetooth 6lowpan receives an UDP compressed message which needs
> further
> decompression by nhc_udp. The following error occurs:
> 
> Null pointer dereference error #2 crash log:
> 
> [   63.295149] BUG: unable to handle kernel NULL pointer dereference
> at
>                0000000000000840
> [   63.295931] IP: [<ffffffffc0559540>] udp_uncompress+0x320/0x626
>                [nhc_udp]
> 
> The second modification fixes the NULL pointer dereference error by
> assigning dev to the local_skb in the case of a udp compressed
> packet.
> The 6lowpan udp_uncompress function expects that the net_device is
> set in
> the skb when checking lltype.
> 
> Signed-off-by: Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>
> Signed-off-by: Lukasz Duda <lukasz.duda@nordicsemi.no>
> ---
>  net/bluetooth/6lowpan.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index d040365..58e1b3c 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -317,6 +317,7 @@ static int recv_pkt(struct sk_buff *skb, struct
> net_device *dev,
>  
>  		local_skb->protocol = htons(ETH_P_IPV6);
>  		local_skb->pkt_type = PACKET_HOST;
> +		local_skb->dev = dev;
>  
>  		skb_set_transport_header(local_skb, sizeof(struct
> ipv6hdr));
>  
> @@ -335,6 +336,8 @@ static int recv_pkt(struct sk_buff *skb, struct
> net_device *dev,
>  		if (!local_skb)
>  			goto drop;
>  
> +		local_skb->dev = dev;
> +
>  		ret = iphc_decompress(local_skb, dev, chan);
>  		if (ret < 0) {
>  			kfree_skb(local_skb);
> @@ -343,7 +346,6 @@ static int recv_pkt(struct sk_buff *skb, struct
> net_device *dev,
>  
>  		local_skb->protocol = htons(ETH_P_IPV6);
>  		local_skb->pkt_type = PACKET_HOST;
> -		local_skb->dev = dev;
>  
>  		if (give_skb_to_upper(local_skb, dev)
>  				!= NET_RX_SUCCESS) {


Cheers,
Jukka

