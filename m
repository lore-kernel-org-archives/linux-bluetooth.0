Return-Path: <cyrus@holtmann.org>
Message-ID: <1415110033.2918.23.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCH bluetooth-next] ieee802154: 6lowpan: fix udp header
 compression when using raw skts
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: alex.aring@gmail.com, linux-wpan@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Date: Tue, 04 Nov 2014 16:07:13 +0200
In-Reply-To: <1415108633-32358-1-git-send-email-simon.vincent@xsilon.com>
References: <1415108633-32358-1-git-send-email-simon.vincent@xsilon.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Simon,

On ti, 2014-11-04 at 13:43 +0000, Simon Vincent wrote:
> If you use RAW sockets the transport header offset is not set by the
> ipv6 stack so when we get to the udp header compression it does not
> compress the right part of the packet.
> 
> This patch adds a check for this scenario and sets the transport
> header offset.
> 
> Signed-off-by: Simon Vincent <simon.vincent@xsilon.com>
> ---
>  net/6lowpan/iphc.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
> index 73a7065..305bf2b 100644
> --- a/net/6lowpan/iphc.c
> +++ b/net/6lowpan/iphc.c
> @@ -512,9 +512,17 @@ static u8 lowpan_compress_addr_64(u8 **hc_ptr, u8 shift,
>  
>  static void compress_udp_header(u8 **hc_ptr, struct sk_buff *skb)
>  {
> -	struct udphdr *uh = udp_hdr(skb);
> +	struct udphdr *uh;
>  	u8 tmp;
>  
> +	/* In the case of RAW sockets the transport header is not set by
> +	* the ip6 stack so we must set it ourselves
> +	*/
> +	if (skb->transport_header == skb->network_header)
> +		skb_set_transport_header(skb, sizeof(struct ipv6hdr));
> +
> +	uh = udp_hdr(skb);
> +
>  	if (((ntohs(uh->source) & LOWPAN_NHC_UDP_4BIT_MASK) ==
>  	     LOWPAN_NHC_UDP_4BIT_PORT) &&
>  	    ((ntohs(uh->dest) & LOWPAN_NHC_UDP_4BIT_MASK) ==


Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>


Cheers,
Jukka


