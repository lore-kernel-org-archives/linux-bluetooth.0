Return-Path: <cyrus@holtmann.org>
Date: Thu, 31 Jul 2014 07:33:13 +0200
From: Alexander Aring <alex.aring@gmail.com>
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-zigbee-devel@lists.sourceforge.net,
	linux-bluetooth@vger.kernel.org
Subject: Re: [Linux-zigbee-devel] [PATCH 1/2] Remove dev parameter from
 skb_delivery_cb in 6lowpan.
Message-ID: <20140731053232.GA26557@omega>
References: <1406733923-21700-1-git-send-email-martin.townsend@xsilon.com>
 <1406733923-21700-2-git-send-email-martin.townsend@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1406733923-21700-2-git-send-email-martin.townsend@xsilon.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Martin,

this patch looks good, simple rebase it on bluetooth-next.

You could do:

git remote add bluetooth-next
git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git

git checkout bluetooth-next/master

then git cherry-pick $COMMIT_ID

to get the necessary commits from other branches, it should fail but you
need to solve the conflicts.

On Wed, Jul 30, 2014 at 04:25:22PM +0100, Martin Townsend wrote:
> This parameter is never used by any functions that are passed to
> lowpan_process_data which uses this callback.
> 
> Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>
> ---
>  include/net/6lowpan.h         | 2 +-
>  net/6lowpan/iphc.c            | 2 +-
>  net/bluetooth/6lowpan.c       | 4 ++--
>  net/ieee802154/6lowpan_rtnl.c | 5 ++---
>  4 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
> index 79b530f..995cce86 100644
> --- a/include/net/6lowpan.h
> +++ b/include/net/6lowpan.h
> @@ -422,7 +422,7 @@ lowpan_uncompress_size(const struct sk_buff *skb, u16 *dgram_offset)
>  	return skb->len + uncomp_header - ret;
>  }
>  
> -typedef int (*skb_delivery_cb)(struct sk_buff *skb, struct net_device *dev);
> +typedef int (*skb_delivery_cb)(struct sk_buff *skb);
>  
>  int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
>  		const u8 *saddr, const u8 saddr_type, const u8 saddr_len,
> diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
> index e82c9cc..b4bb27c 100644
> --- a/net/6lowpan/iphc.c
> +++ b/net/6lowpan/iphc.c
> @@ -195,7 +195,7 @@ static int skb_deliver(struct sk_buff *skb, struct ipv6hdr *hdr,
>  	raw_dump_table(__func__, "raw skb data dump before receiving",
>  		       new->data, new->len);
>  
> -	stat = deliver_skb(new, dev);
> +	stat = deliver_skb(new);
>  
>  	kfree_skb(new);
>  
I know you didn't change it and you should do this in a seperate
patch, but this should be consume_skb or dev_kfree_skb. We don't drop
the skb afterwards here with failure. The complete file have several
places like this and use kfree_skb here. We should do this in one of the
next patches.

- Alex
