Return-Path: <cyrus@holtmann.org>
Message-ID: <5435589A.7050605@xsilon.com>
Date: Wed, 08 Oct 2014 16:30:34 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
To: Alexander Aring <alex.aring@gmail.com>
CC: Martin Townsend <mtownsend1973@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
 marcel@holtmann.org, jukka.rissanen@linux.intel.com
Subject: Re: [PATCH v4 bluetooth-next] 6lowpan: Use pskb_expand_head in IPHC
 decompression.
References: <1412776015-372-1-git-send-email-martin.townsend@xsilon.com> <1412776015-372-2-git-send-email-martin.townsend@xsilon.com> <20141008145917.GA23456@omega> <543553AD.9000501@xsilon.com> <20141008152750.GB23456@omega>
In-Reply-To: <20141008152750.GB23456@omega>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

I'll wait for Jukka's ack for the bluetooth side and then send v5 with the removed skb_share_check.

- Martin.

On 08/10/14 16:27, Alexander Aring wrote:
> On Wed, Oct 08, 2014 at 04:09:33PM +0100, Martin Townsend wrote:
>> Hi  Alex,
>>
>> I completely missed it, unless reassembly can result in a shared skb? can you confirm that it doesn't then I'll remove the line.
>>
> No, we manipulate the skb data there. We fetch the fragment header.
> See [0].
>
> This require a unshared buffer between af_802154 and 6lowpan. Also on
> LOWPAN_DISPATCH_IPV6 we fetch the one byte dispatch value.
>
> - Alex
>
> [0] http://lxr.free-electrons.com/source/net/ieee802154/reassembly.c#L328
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
