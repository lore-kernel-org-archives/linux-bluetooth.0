Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b17ba8fb-0ed2-a237-06c3-75ab0addbd86@opensourcefoundries.com>
References: <b17ba8fb-0ed2-a237-06c3-75ab0addbd86@opensourcefoundries.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 7 Dec 2017 16:55:51 -0200
Message-ID: <CABBYNZL2=8K9HeF=G42mkROacmDRfraaoBoP1hc8-hQDMCVMjw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: 6lowpan: Fix multi-link setup
To: Michael Scott <michael@opensourcefoundries.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Jukka Rissanen <jukka.rissanen@linux.intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Thu, Dec 7, 2017 at 4:26 PM, Michael Scott
<michael@opensourcefoundries.com> wrote:
> Hi Luiz (and linux-bluetooth),
>
> On Wed, 2017-09-20 at 12:52 +0300, Luiz Augusto von Dentz wrote:
>>
>> /From: Luiz Augusto von Dentz <luiz.von.dentz@xxxxxxxxx>/
>> //
>> /If there are more than one node connected and there isn't any route/
>> /information attempt to check if destination address matches any of/
>> /the/
>> /link-local peer addresses./
>> //
>> /Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@xxxxxxxxx>/
>> /---/
>> /net/bluetooth/6lowpan.c | 2 +-/
>> /1 file changed, 1 insertion(+), 1 deletion(-)/
>> //
>> /diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c/
>> /index 4e2576fc0c59..55370c330386 100644/
>> /--- a/net/bluetooth/6lowpan.c/
>> /+++ b/net/bluetooth/6lowpan.c/
>> /@@ -190,7 +190,7 @@ static inline struct lowpan_peer/
>> /*peer_lookup_dst(struct lowpan_btle_dev *dev,/
>> /nexthop = &lowpan_cb(skb)->gw;/
>> //
>> /if (ipv6_addr_any(nexthop))/
>> /- return NULL;/
>> /+ nexthop = daddr;/
>> /} else {/
>> /nexthop = rt6_nexthop(rt, daddr);/
>> //
>
>
> Was there any plan to bring this into the longterm 4.14 tree?  I saw that
> Jukka ACKed the patch.
>
> Using 4.14, connecting more than 1 node via 6lowpan is completely broken.
> This fairly simple patch restores connectivity for multiple 6lowpan devices.
>
> Question: Are there any hidden downsides to using this patch?

No really, we are just going to deprecated the debugfs interface thus
this got deprioritized, but perhaps we should apply one last fix
before moving on.

-- 
Luiz Augusto von Dentz
