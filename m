Return-Path: <cyrus@holtmann.org>
Message-ID: <53FE446D.6040805@xsilon.com>
Date: Wed, 27 Aug 2014 21:49:49 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>,
 Alexander Aring <alex.aring@gmail.com>
CC: linux-zigbee-devel@lists.sourceforge.net,
 linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org
Subject: Re: [PATCH v2 bluetooth-next] Simplify lowpan receive path so skb
 is freed in lowpan_rcv when dropped.
References: <53DCE75C.2030305@xsilon.com> <20140821083945.GA29484@omega> <3DF0C18C-4A97-4A00-AB0F-9E01F72CE967@holtmann.org>
In-Reply-To: <3DF0C18C-4A97-4A00-AB0F-9E01F72CE967@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 21/08/14 14:24, Marcel Holtmann wrote:
> Hi Alex,
>
>> this patch wasn't able to apply and now it doesn't apply either (because
>> lot of other changes). I thought you will resend a v3 and then I will
>> care about reviewing. Then putting Acked-by, then Marcel will put it on
>> the right repositories.
>>
>> If you can, describe the changes in the commit msg (please note the 80
>> line width there).
>>
>> This patch is also something for bluetooth (not bluetooth-next), it's a
>> bug fix. But this depends how Marcel will dealing with this issue. It's
>> a bugfix with a huge change of lines. I would base it on bluetooth,
>> because it's a bug fix.
> simplifying something is not for -stable or a bug fix. If there is a memory leak, then fix that memory leak first in a separate patch. The rules are pretty clear here. Only bug fixes after the merge window has closed.
>
> Regards
>
> Marcel
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Hi,

I'll respin and include the memory leak fix and this patch and a couple 
of others I have and send as a series to bluetooth.  What bluetooth git 
repository should I base the series on?

- Martin.
