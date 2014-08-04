Return-Path: <cyrus@holtmann.org>
Message-ID: <53DF56BE.6000309@xsilon.com>
Date: Mon, 04 Aug 2014 10:47:42 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
To: Alexander Aring <alex.aring@gmail.com>
CC: linux-zigbee-devel@lists.sourceforge.net,
	linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v3 bluetooth-next] Simplify lowpan receive path so skb
 is freed in, lowpan_rcv when dropped.
References: <53DF4B10.7000209@xsilon.com> <20140804090403.GB15334@omega> <53DF4F7B.4090307@xsilon.com> <20140804093630.GD15334@omega> <20140804094147.GE15334@omega>
In-Reply-To: <20140804094147.GE15334@omega>
Content-Type: text/plain; charset=utf-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Oops, sorry about that.

- Martin

On 04/08/14 10:41, Alexander Aring wrote:
> Martin,
>
> On Mon, Aug 04, 2014 at 11:36:30AM +0200, Alexander Aring wrote:
>> On Mon, Aug 04, 2014 at 10:16:43AM +0100, Martin Townsend wrote:
>>> The changes were made to a clone of bluetooth-next, do I have the right repository?
>>>
>>> martin@martin-HP-ProDesk-490-G1-MT:~/workspace/bluetooth-next$ git ls-remote
>>> From git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
>>>
>> yes, but maybe it's a little bit outdated. Try to update it, on top of
>> git log should be the patches:
>>
>> http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/log/
>>
> I think I know now why it fails. This patch depends on your previous patch
> ("6lowpan: Remove ununsed dev parameter from skb_delivery_cb
> callback."), otherwise I get merge conflicts.
>
> Normally you need to send this in a series of patches to avoid something
> like this. Now you need to wait until your patch ("6lowpan: Remove
> ununsed dev parameter from skb_delivery_cb callback.") go into the
> bluetooth-next tree.
>
>
> Next time, if you have a bunch of patches which depends on each other
> then send patch series. Sorry.
>
> - Alex
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

