Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1452767430.3292.8.camel@linux.intel.com>
Subject: Re: [PATCH] Bluetooth: 6lowpan: Fix handling of uncompressed IPv6
 packets
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: Lukasz Duda <lukasz.duda@nordicsemi.no>, alex.aring@gmail.com
Cc: linux-bluetooth@vger.kernel.org, glenn.ruben.bakke@nordicsemi.no
Date: Thu, 14 Jan 2016 12:30:30 +0200
In-Reply-To: <1452700668-4241-1-git-send-email-lukasz.duda@nordicsemi.no>
References: <1452700668-4241-1-git-send-email-lukasz.duda@nordicsemi.no>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

good catch.

Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>


On Wed, 2016-01-13 at 16:57 +0100, Lukasz Duda wrote:
> This patch fixes incorrect handling of the 6lowpan packets that
> contain
> uncompressed IPv6 header.
> 
> RFC4944 specifies a special dispatch for 6lowpan to carry
> uncompressed
> IPv6 header. This dispatch (1 byte long) has to be removed during
> reception and skb data pointer has to be moved. To correctly point in
> the beginning of the IPv6 header the dispatch byte has to be pulled
> off
> before packet can be processed by netif_rx_in().
> 
> Test scenario: IPv6 packets are not correctly interpreted by the
> network
> layer when IPv6 header is not compressed (e.g. ICMPv6 Echo Reply is
> not
> propagated correctly to the ICMPv6 layer because the extra byte will
> make
> the header look corrupted).
> 
> Similar approach is done for IEEE 802.15.4.
> 
> Signed-off-by: Lukasz Duda <lukasz.duda@nordicsemi.no>
> Signed-off-by: Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>
> ---
>  net/bluetooth/6lowpan.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index d040365..350f379 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -307,6 +307,9 @@ static int recv_pkt(struct sk_buff *skb, struct
> net_device *dev,
>  
>  	/* check that it's our buffer */
>  	if (lowpan_is_ipv6(*skb_network_header(skb))) {
> +		/* Pull off the 1-byte of 6lowpan header. */
> +		skb_pull(skb, 1);
> +
>  		/* Copy the packet so that the IPv6 header is
>  		 * properly aligned.
>  		 */


Cheers,
Jukka

