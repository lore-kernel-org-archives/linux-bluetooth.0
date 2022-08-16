Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B842DC25B0E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Aug 2022 15:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236098AbiHPPZQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Aug 2022 11:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236068AbiHPPZA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Aug 2022 11:25:00 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F51590
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 08:24:46 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220816152441euoutp0273a47d17f8c722387499ebc3c1274f0b~L3KNP2Ijj0536205362euoutp029
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 15:24:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220816152441euoutp0273a47d17f8c722387499ebc3c1274f0b~L3KNP2Ijj0536205362euoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660663481;
        bh=GbX1Q/b6f/BJ0tZ0cHUoXuizeto5B7mT2utIBePFyGc=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=VjNtjJTIeOP0suzgOtWDI/pcByG3ewKP4J/KCH8j/m/SX/wyvBpN23cPNmqaCQg8v
         TtLR/6S6fxNxh/OwDp9do+lyumB5ixDwtCpwqHVv9KveR3GJ6PuoJl7EZdxy0EL5BB
         bJkFpJwVMLGC97E3TkwZpi1FAngHPr725O5Gtoq4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220816152441eucas1p2422042a99b1c99fc05aa32784b6d04c7~L3KNFi9PT3068630686eucas1p2a;
        Tue, 16 Aug 2022 15:24:41 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 95.D0.10067.9B6BBF26; Tue, 16
        Aug 2022 16:24:41 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220816152441eucas1p2e278c3906817871ee93ea2290253ece4~L3KMsy_BO1149711497eucas1p2Q;
        Tue, 16 Aug 2022 15:24:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220816152440eusmtrp2bdec4c2df53d3825f9b360132aef3975~L3KMsI_du1696216962eusmtrp2g;
        Tue, 16 Aug 2022 15:24:40 +0000 (GMT)
X-AuditID: cbfec7f4-dd7ff70000002753-15-62fbb6b973dd
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 09.93.09095.8B6BBF26; Tue, 16
        Aug 2022 16:24:40 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220816152440eusmtip1194729733d5d376c09073c6b871c9683~L3KMep9iJ1079010790eusmtip1J;
        Tue, 16 Aug 2022 15:24:40 +0000 (GMT)
Message-ID: <41717010-b7a5-40e4-39d7-722fb6d18eae@samsung.com>
Date:   Tue, 16 Aug 2022 17:24:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v7 2/7] Bluetooth: Add initial implementation of CIS
 connections
Content-Language: en-US
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <92a47171-f69b-5bf9-6e8c-70fc3e9e6eee@samsung.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsWy7djP87o7t/1OMrg5RdxizrU+Zounn6ew
        OjB57Jx1l93j8ya5AKYoLpuU1JzMstQifbsEroxTu/ILPlhUPHtwkK2BsUW/i5GTQ0LARGLa
        qTOMXYxcHEICKxglbvRPYINwvjBKbD2ynBmkSkjgM6PEuRP2MB03J7RAdSxnlDj+t4UZwvnI
        KHFy118WkCpeATuJ9lMv2UBsFgFViZczr7FDxAUlTs58AlYjKpAs8ez/YrC4sECYxPfrv8Bs
        ZgFxiVtP5jOB2GwChhJdb7uA5nBwiADZ3y7EQJS4S+yf/xVsDKeAvcT+aROYIeLyEs1bZ4Pd
        IyEwk0PixvblrBBXu0hc/vebGcIWlnh1fAs7hC0j8X8nyC4OIDtf4u8MY4hwhcS112ugyq0l
        7pz7BXYCs4CmxPpd0JBzlLi5+yILRCefxI23ghAX8ElM2jadGSLMK9HRJgRRrSYx6/g6uJ0H
        L1xinsCoNAspSGYheX0Wkl9mIexdwMiyilE8tbQ4Nz212CgvtVyvODG3uDQvXS85P3cTIzBV
        nP53/MsOxuWvPuodYmTiYDzEKMHBrCTCK/jiR5IQb0piZVVqUX58UWlOavEhRmkOFiVx3uTM
        DYlCAumJJanZqakFqUUwWSYOTqkGpjaLa+rzwycWrl//o9neQvKJpeI7C2dexwSu4wamilYn
        9x+ffXHPHp3HiWGODY+CDKsMO+d81d3nxHdCSrTzmUVAWn6+7J6Z0lpHwhNqHRcfmMclGqFa
        PaHqlHPMp9fCrS1VezluZVvK7lvKXvX5ktRMV8lrZy2u+Vvaf96XzZd4KfDmoh/yC301evZ9
        VWD9fOBPSx/T6xtaCzcw+7EWL36TUjHfyU12r4fwt9yS6j47qQo1xzNng02/Orea/e/m4Nlh
        web2VqWKV3jje5tdO+6dnNZwP6Emq+HqqyyP0yvXND68kdX9uv1EW+jPewX/49wssmbdyIoS
        quHT9c9tzY+ozb/xUF532s2cFC4lluKMREMt5qLiRADy8+gmhAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42I5/e/4Xd0d234nGdyZZ2Ux51ofs8XTz1NY
        HZg8ds66y+7xeZNcAFOUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1K
        ak5mWWqRvl2CXsapXfkFHywqnj04yNbA2KLfxcjJISFgInFzQgtjFyMXh5DAUkaJG+v72CES
        MhInpzWwQtjCEn+udbFBFL1nlJgyZw8zSIJXwE6i/dRLNhCbRUBV4uXMa+wQcUGJkzOfsIDY
        ogLJEgsOLQWzhQXCJL5f/wVWwywgLnHryXwmEJtNwFCi6y3IAg4OESD724UYiBJ3if3zv7JA
        7H3HLHFu0kOwXZwC9hL7p01ghigyk+ja2sUIYctLNG+dzTyBUWgWkjNmIVk3C0nLLCQtCxhZ
        VjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgTGyLZjPzfvYJz36qPeIUYmDsZDjBIczEoivIIv
        fiQJ8aYkVlalFuXHF5XmpBYfYjQFhsVEZinR5HxglOaVxBuaGZgamphZGphamhkrifN6FnQk
        CgmkJ5akZqemFqQWwfQxcXBKNTDNSJ/33KBk3r1IfV6dKFGbKSnH3uuWvp81we7NkeU6Qptj
        3oZsNyie6S0o/doz4O/jiUpStr+TNPj+JwmfSOrcOOnCidTkHZb7j+0xfnlS5zOTsZQyj2iv
        4ZoTFY6MCyO3b1vBzVstuGXltveMizZKX9jgfvV4YimbRYok35K3E/fbzyqqqWRJLxfjiq3f
        fy3tveu/5uB7qe1MLbyvuewUwq2CJ6pMaGXxddrGUHLv4tKZKxW7Gy6JaYi6TLnNtisn61t2
        0fRFU4TYFbx2HOtZ/JOR77GizUNlxdtB6rE1ZwzkVBS1twius/7EZFqs4e8odHXbeodSxd5+
        i+WcqVx1/xc9emo0bZ7reemSa0osxRmJhlrMRcWJAPF2ONgaAwAA
X-CMS-MailID: 20220816152441eucas1p2e278c3906817871ee93ea2290253ece4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220809085500eucas1p18cb2752164ca55832787e7d3843f48ab
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220809085500eucas1p18cb2752164ca55832787e7d3843f48ab
References: <20220711233535.3134546-1-luiz.dentz@gmail.com>
        <CGME20220809085500eucas1p18cb2752164ca55832787e7d3843f48ab@eucas1p1.samsung.com>
        <20220711233535.3134546-2-luiz.dentz@gmail.com>
        <749ed578-bc9d-b699-3602-bee444fff9bb@samsung.com>
        <CABBYNZLsR0KT1-OVVjnUzLp0+U0eHGi0PNqKbfntp_5AHNDawA@mail.gmail.com>
        <03f9bea9-77fb-2b57-43d0-c4b819c2560a@samsung.com>
        <CABBYNZ+vRqqCBVTgQJ-UZ+gd2ceFebQF94NDdYcN4Xmyk+GWTA@mail.gmail.com>
        <92a47171-f69b-5bf9-6e8c-70fc3e9e6eee@samsung.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi All,

On 12.08.2022 14:33, Marek Szyprowski wrote:
> Hi Luiz,
>
> On 10.08.2022 22:04, Luiz Augusto von Dentz wrote:
>> Hi Marek,
>>
>> On Wed, Aug 10, 2022 at 7:18 AM Marek Szyprowski
>> <m.szyprowski@samsung.com> wrote:
>>> Hi Luiz,
>>>
>>> On 09.08.2022 21:24, Luiz Augusto von Dentz wrote:
>>>> On Tue, Aug 9, 2022 at 1:55 AM Marek Szyprowski
>>>> <m.szyprowski@samsung.com>  wrote:
>>>>> On 12.07.2022 01:35, Luiz Augusto von Dentz wrote:
>>>>>> From: Luiz Augusto von Dentz<luiz.von.dentz@intel.com>
>>>>>>
>>>>>> This adds the initial implementation of CIS connections and 
>>>>>> introduces
>>>>>> the ISO packets/links.
>>>>>>
>>>>>> == Central: Set CIG Parameters, create a CIS and Setup Data Path ==
>>>>>>
>>>>>>> tools/isotest -s <address>
>>>>>> < HCI Command: LE Extended Create... (0x08|0x0043) plen 26
>>>>>> ...
>>>>>>> HCI Event: Command Status (0x0f) plen 4
>>>>>>          LE Extended Create Connection (0x08|0x0043) ncmd 1
>>>>>>            Status: Success (0x00)
>>>>>>> HCI Event: LE Meta Event (0x3e) plen 31
>>>>>>          LE Enhanced Connection Complete (0x0a)
>>>>>>          ...
>>>>>> < HCI Command: LE Create Connected... (0x08|0x0064) plen 5
>>>>>> ...
>>>>>>> HCI Event: Command Status (0x0f) plen 4
>>>>>>          LE Create Connected Isochronous Stream (0x08|0x0064) ncmd 1
>>>>>>            Status: Success (0x00)
>>>>>>> HCI Event: LE Meta Event (0x3e) plen 29
>>>>>>          LE Connected Isochronous Stream Established (0x19)
>>>>>>          ...
>>>>>> < HCI Command: LE Setup Isochronou.. (0x08|0x006e) plen 13
>>>>>> ...
>>>>>>> HCI Event: Command Complete (0x0e) plen 6
>>>>>>          LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
>>>>>>            Status: Success (0x00)
>>>>>>            Handle: 257
>>>>>> < HCI Command: LE Setup Isochronou.. (0x08|0x006e) plen 13
>>>>>> ...
>>>>>>> HCI Event: Command Complete (0x0e) plen 6
>>>>>>          LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
>>>>>>            Status: Success (0x00)
>>>>>>            Handle: 257
>>>>>>
>>>>>> == Peripheral: Accept CIS and Setup Data Path ==
>>>>>>
>>>>>>> tools/isotest -d
>>>>>>     HCI Event: LE Meta Event (0x3e) plen 7
>>>>>>          LE Connected Isochronous Stream Request (0x1a)
>>>>>> ...
>>>>>> < HCI Command: LE Accept Co.. (0x08|0x0066) plen 2
>>>>>> ...
>>>>>>> HCI Event: LE Meta Event (0x3e) plen 29
>>>>>>          LE Connected Isochronous Stream Established (0x19)
>>>>>> ...
>>>>>> < HCI Command: LE Setup Is.. (0x08|0x006e) plen 13
>>>>>> ...
>>>>>>> HCI Event: Command Complete (0x0e) plen 6
>>>>>>          LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
>>>>>>            Status: Success (0x00)
>>>>>>            Handle: 257
>>>>>> < HCI Command: LE Setup Is.. (0x08|0x006e) plen 13
>>>>>> ...
>>>>>>> HCI Event: Command Complete (0x0e) plen 6
>>>>>>          LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
>>>>>>            Status: Success (0x00)
>>>>>>            Handle: 257
>>>>>>
>>>>>> Signed-off-by: Luiz Augusto von Dentz<luiz.von.dentz@intel.com>
>>>>> This patch landed recently in linux-next as commit 26afbd826ee3
>>>>> ("Bluetooth: Add initial implementation of CIS connections").
>>>>> Unfortunately it causes a regression on my test systems. On almost 
>>>>> all
>>>>> I've observed that calling a simple 'hcitool scan' command in a shell
>>>>> fails in an unexpected way:
>>>>>
>>>>> $ hcitool scan
>>>>> *** stack smashing detected ***: <unknown> terminated
>>>>> Aborted
>>>> Not really sure how it would be related to ISO changes though, have
>>>> you even enabled ISO sockets UUID? Perhaps check if there is something
>>>> on dmesg indicating what is going on since I tried here and that
>>>> doesn't seem to cause any problem:
>>>>
>>>> tools/hcitool scan
>>>> Scanning ...
>>>>
>>>> Perhaps it is a combination of using old userspace tools with new
>>>> kernel, but then again these changes should affect something like
>>>> hcitool.
>>> Indeed my userspace is old, but still, the kernel changes shouldn't 
>>> make
>>> it to crash. I didn't change anything in userspace since ages, so I
>>> assume that ISO sockets UUIDs are not enabled. Maybe it is somehow
>>> architecture related or specific? It looks that only ARM 32bit 
>>> userspace
>>> apps crashes. I've just checked 64bit userspace on ARM64 (RPi4) and it
>>> works fine with that commit.
>> That would be the first time it happens to me that a change in kernel
>> would crash the userspace in such odd fashion, btw perhaps run with
>> valgrind so it generates a backtrace of where it would be crashing,
>> well if that is reproducible with valgrind.
>
> Well, its not that easy. I've checked and Debian doesn't provide a 
> valgrind package for the buster/armel arch, which I use on my test 
> systems (for some historical reasons). Building everything from the 
> source will take some time, though. I will try to do this after 
> getting back from my holidays after 24th Aug.

Unfortunately my holidays trip didn't start, so I had a chance to play a 
bit with this issue.

Valgrind doesn't really provide any useful information here:

$ valgrind hcitool scan
==1391== Memcheck, a memory error detector
==1391== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
==1391== Using Valgrind-3.14.0 and LibVEX; rerun with -h for copyright info
==1391== Command: hcitool scan
==1391==
*** stack smashing detected ***: <unknown> terminated
==1391==
==1391== Process terminating with default action of signal 6 (SIGABRT)
==1391==    at 0x48EB6AC: raise (raise.c:51)
==1391==    by 0x48D6283: abort (abort.c:79)
==1391==    by 0x4928E3B: __libc_message (libc_fatal.c:181)
==1391==    by 0x49ACFE3: __fortify_fail_abort (fortify_fail.c:33)
==1391==    by 0x49ACFA7: __stack_chk_fail (stack_chk_fail.c:29)
==1391==    by 0x117DFB: ??? (in /usr/bin/hcitool)
==1391==
==1391== HEAP SUMMARY:
==1391==     in use at exit: 132 bytes in 1 blocks
==1391==   total heap usage: 1 allocs, 0 frees, 132 bytes allocated
==1391==
==1391== LEAK SUMMARY:
==1391==    definitely lost: 0 bytes in 0 blocks
==1391==    indirectly lost: 0 bytes in 0 blocks
==1391==      possibly lost: 0 bytes in 0 blocks
==1391==    still reachable: 132 bytes in 1 blocks
==1391==         suppressed: 0 bytes in 0 blocks
==1391== Rerun with --leak-check=full to see details of leaked memory
==1391==
==1391== For counts of detected and suppressed errors, rerun with: -v
==1391== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)
Aborted


I've also checked the ARM 32bit 'armhf' userspace abi on vanilla 
Raspberry Pi OS Lite 32-bit image (from April 4th 2022). The issue is same:

$ hcitool scan
*** stack smashing detected ***: terminated
Aborted

It is enough to boot that image with init=/bin/bash and run 'hcitool 
scan' to reproduce the issue...


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

