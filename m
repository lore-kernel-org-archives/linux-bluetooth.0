Return-Path: <cyrus@holtmann.org>
Date: Thu, 31 Jul 2014 07:54:30 +0200
From: Alexander Aring <alex.aring@gmail.com>
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-zigbee-devel@lists.sourceforge.net,
	linux-bluetooth@vger.kernel.org
Subject: Re: [Linux-zigbee-devel] [PATCH 2/2] Change lowpan_rcv so skb is
 freed within function and fix return values.
Message-ID: <20140731055427.GB26557@omega>
References: <1406733923-21700-1-git-send-email-martin.townsend@xsilon.com>
 <1406733923-21700-3-git-send-email-martin.townsend@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1406733923-21700-3-git-send-email-martin.townsend@xsilon.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Martin,

I agree about the issue, we talked a lot time before about this. But I
would not complete remove the errno numbers.

The basic issue is that that mixed function can return errno or
NET_RX_DROP/NET_RX_SUCCESS and we need to decide if we use
NET_RX_DROP/NET_RX_SUCCESS only or using errno's but then we need a
conversion of the errno to NET_RX_DROP at the end of receive call, If
a errno was returned.

If all functions return "-1" now, it's hard to debug what could be
failed, when we add some debug prints in this file.

On Wed, Jul 30, 2014 at 04:25:23PM +0100, Martin Townsend wrote:
> Currently it is up to the functions below lowpan_rcv to free the skb on error
> conditions.  This patch now removes all the UAPI error codes and process data
> now returns -1 if there is a problem.  In this scenario lowpan_rcv will free
> the skb and return NET_RX_DROP.  This also fixes the problem where
> NET_RX_SUCCESS is returned on error
> 
> Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>
> ---
>  include/net/6lowpan.h         |  2 +-
>  net/6lowpan/iphc.c            | 35 ++++++++++++++++++-----------------
>  net/bluetooth/6lowpan.c       | 17 ++++++++---------
>  net/ieee802154/6lowpan_rtnl.c | 39 +++++++++++++++++++--------------------
>  4 files changed, 46 insertions(+), 47 deletions(-)
> 
> diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
> index 995cce86..561defe 100644
> --- a/include/net/6lowpan.h
> +++ b/include/net/6lowpan.h
> @@ -424,7 +424,7 @@ lowpan_uncompress_size(const struct sk_buff *skb, u16 *dgram_offset)
>  
>  typedef int (*skb_delivery_cb)(struct sk_buff *skb);
>  
> -int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
> +int lowpan_process_data(struct sk_buff **skb_inout, struct net_device *dev,
>  		const u8 *saddr, const u8 saddr_type, const u8 saddr_len,
>  		const u8 *daddr, const u8 daddr_type, const u8 daddr_len,
>  		u8 iphc0, u8 iphc1, skb_delivery_cb skb_deliver);
> diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
> index b4bb27c..61b5206 100644
> --- a/net/6lowpan/iphc.c
> +++ b/net/6lowpan/iphc.c
> @@ -119,17 +119,17 @@ static int uncompress_addr(struct sk_buff *skb,
>  			break;
>  		default:
>  			pr_debug("Invalid addr_type set\n");
> -			return -EINVAL;
> +			return -1;
>  		}
>  		break;
>  	default:
>  		pr_debug("Invalid address mode value: 0x%x\n", address_mode);
> -		return -EINVAL;
> +		return -1;
>  	}
>  
>  	if (fail) {
>  		pr_debug("Failed to fetch skb data\n");
> -		return -EIO;
> +		return -1;
>  	}
>  
>  	raw_dump_inline(NULL, "Reconstructed ipv6 addr is",
> @@ -158,10 +158,10 @@ static int uncompress_context_based_src_addr(struct sk_buff *skb,
>  	case LOWPAN_IPHC_ADDR_03:
>  		/* TODO */
>  		netdev_warn(skb->dev, "SAM value 0x%x not supported\n", sam);
> -		return -EINVAL;
> +		return -1;
>  	default:
>  		pr_debug("Invalid sam value: 0x%x\n", sam);
> -		return -EINVAL;
> +		return -1;
>  	}
>  
>  	raw_dump_inline(NULL,
> @@ -179,10 +179,10 @@ static int skb_deliver(struct sk_buff *skb, struct ipv6hdr *hdr,
>  
>  	new = skb_copy_expand(skb, sizeof(struct ipv6hdr),
>  			      skb_tailroom(skb), GFP_ATOMIC);
> -	kfree_skb(skb);
> -
>  	if (!new)
> -		return -ENOMEM;
> +		return -1;
> +
> +	kfree_skb(skb);

This leaks memory here, move kfree_skb above the condition after the
skb_copy_expand. This should be also a consume_skb or dev_kfree_skb, we
should not mix these function in this file and use only one of them.

We need another patch for this.

>  
>  	skb_push(new, sizeof(struct ipv6hdr));
>  	skb_reset_network_header(new);
> @@ -196,6 +196,8 @@ static int skb_deliver(struct sk_buff *skb, struct ipv6hdr *hdr,
>  		       new->data, new->len);
>  
>  	stat = deliver_skb(new);
> +	if (stat == -1)

keep all existing errnos and look for function which are called but
returning NET_RX_DROP. Then check for if (stat < 0) to indicate a error.

- Alex
