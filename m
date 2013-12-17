Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: Re: [PATCH v3 bluetooth-next 0/8] 6lowpan: udp compression/uncompression fix
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1387286488-29382-1-git-send-email-alex.aring@gmail.com>
Date: Tue, 17 Dec 2013 15:18:01 +0100
Cc: linux-zigbee-devel@lists.sourceforge.net, werner@almesberger.net,
	"linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <87DBCEFE-FB53-43B2-9F17-FF30BE4123CC@holtmann.org>
References: <1387286488-29382-1-git-send-email-alex.aring@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

> The current 6LoWPAN udp compression/uncompression is completely broken.
> This patch series fix a lot of udp compression/uncompression issues and
> add support parsing with lowpan_fetch_skb/lowpan_push_hc_data functions.
> 
> I tested it in all cases of compressions in wireshark and a contiki
> sensornode.
> 
> Changes since v3:
> - add patch to introduce lowpan_push_hc_data helper function.
> - remove patch to fix nullpointer dereferencing and replace it with
>   a patch which use the lowpan_push_hc_data function in compress_udp_header
>   function. This fixes the nullpointer dereferencing problem also and is more
>   readable.
> - add missing newline in pr_debug_ratelimited.
> 
> Changes since v2:
> - remove unnecessary casts and brackes, suggested by Werner Almesberger.
> - use pr_debug_ratelimited instead of pr_debug on patch 4/7.
> 
> Alexander Aring (8):
>  6lowpan: introduce lowpan_push_hc_data function
>  6lowpan: udp use lowpan_push_hc_data function
>  6lowpan: fix udp compress ordering
>  6lowpan: fix udp byte ordering
>  6lowpan: add udp warning for elided checksum
>  6lowpan: udp use lowpan_fetch_skb function
>  6lowpan: udp use subtraction on both conditions
>  6lowpan: cleanup udp compress function
> 
> net/ieee802154/6lowpan.h      |   8 +++
> net/ieee802154/6lowpan_iphc.c | 114 ++++++++++++++++++++++++------------------
> 2 files changed, 74 insertions(+), 48 deletions(-)

all 8 patches have been applied to bluetooth-next tree.

Regards

Marcel

