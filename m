Return-Path: <cyrus@holtmann.org>
Date: Mon, 13 Oct 2014 12:34:54 +0200
From: Alexander Aring <alex.aring@gmail.com>
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
	marcel@holtmann.org, jukka.rissanen@linux.intel.com,
	Martin Townsend <martin.townsend@xsilon.com>
Subject: Re: [PATCH v6 bluetooth-next] 6lowpan: Use skb_cow in IPHC
 decompression.
Message-ID: <20141013103452.GC20544@omega>
References: <1413194456-26351-1-git-send-email-martin.townsend@xsilon.com>
 <1413194456-26351-2-git-send-email-martin.townsend@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1413194456-26351-2-git-send-email-martin.townsend@xsilon.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Oct 13, 2014 at 11:00:56AM +0100, Martin Townsend wrote:
> Currently there are potentially 2 skb_copy_expand calls in IPHC
> decompression.  This patch replaces this with one call to
> skb_cow which will check to see if there is enough headroom
> first to ensure it's only done if necessary and will handle
> alignment issues for cache.
> As skb_cow uses pskb_expand_head we ensure the skb isn't shared from
> bluetooth and ieee802.15.4 code that use the IPHC decompression.
> 
> Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>

Okay, we don't use the goto drop; below and currently this will always
return -EINVAL. You will fix that in your next patches, so it doesn't
matter right now. Also this will correct a little bit the errno value.

Great job Martin.

Acked-by: Alexander Aring <alex.aring@gmail.com>

Marcel, please wait for jukka's acked here, then we are sure that we
didn't break anything in bluetooth 6lowpan.

- Alex
