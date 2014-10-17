Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH v6 bluetooth-next] 6lowpan: Use skb_cow in IPHC decompression.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1413194456-26351-2-git-send-email-martin.townsend@xsilon.com>
Date: Fri, 17 Oct 2014 16:15:52 +0200
Cc: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
	alex.aring@gmail.com, jukka.rissanen@linux.intel.com,
	Martin Townsend <martin.townsend@xsilon.com>
Message-Id: <934EB47B-5CAD-453A-AD44-0B84CED3C2C3@holtmann.org>
References: <1413194456-26351-1-git-send-email-martin.townsend@xsilon.com> <1413194456-26351-2-git-send-email-martin.townsend@xsilon.com>
To: Martin Townsend <mtownsend1973@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Martin,

> Currently there are potentially 2 skb_copy_expand calls in IPHC
> decompression.  This patch replaces this with one call to
> skb_cow which will check to see if there is enough headroom
> first to ensure it's only done if necessary and will handle
> alignment issues for cache.
> As skb_cow uses pskb_expand_head we ensure the skb isn't shared from
> bluetooth and ieee802.15.4 code that use the IPHC decompression.
> 
> Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>
> ---
> net/6lowpan/iphc.c      | 47 +++++++++++++++++++++--------------------------
> net/bluetooth/6lowpan.c |  4 ++++
> 2 files changed, 25 insertions(+), 26 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

