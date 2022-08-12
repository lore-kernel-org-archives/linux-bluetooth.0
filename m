Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E2DC00140
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Aug 2022 12:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237853AbiHLMdx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Aug 2022 08:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiHLMdw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Aug 2022 08:33:52 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19415AA4D2
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Aug 2022 05:33:51 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220812123349euoutp011d6f62b8218827d58c2aa49f0eed0ef3~KmP4JamQe0540505405euoutp01R
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Aug 2022 12:33:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220812123349euoutp011d6f62b8218827d58c2aa49f0eed0ef3~KmP4JamQe0540505405euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660307629;
        bh=hego0GX04vKxA4IkBlOi9+x4/gSomDQJK+HigYPIKhI=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=RzutNwRO0wXiT6wsNDdjwsFi0YO5NZTELJ+OIXsmOhXlPVVzyV+J4ohOPBp0EnHCr
         alJnNwynUIUb+GgoZfXDrV38WPJnWj78oSHXW2owM1OjtLDprJTe8FrzGSIXW6hC4h
         VXxLPgA6jlHCYubIHcfZ49UR/pDNJQJwbaVPbmmI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220812123349eucas1p1f685477424ee9312831fca685033a514~KmP3-bwy90444504445eucas1p1o;
        Fri, 12 Aug 2022 12:33:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E7.BE.09664.DA846F26; Fri, 12
        Aug 2022 13:33:49 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220812123348eucas1p10a9fae0f49e7ee3f4788a965ffcc64c2~KmP3pgkXp0444504445eucas1p1n;
        Fri, 12 Aug 2022 12:33:48 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220812123348eusmtrp24b719c8a7966c26f4f4f2db83a790226~KmP3o8zdy0591705917eusmtrp2_;
        Fri, 12 Aug 2022 12:33:48 +0000 (GMT)
X-AuditID: cbfec7f2-d97ff700000025c0-5c-62f648ad4473
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 5C.7C.09095.CA846F26; Fri, 12
        Aug 2022 13:33:48 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220812123348eusmtip282eb85047beefa40b065de64d458035e~KmP3aCjqo1993119931eusmtip2K;
        Fri, 12 Aug 2022 12:33:48 +0000 (GMT)
Message-ID: <92a47171-f69b-5bf9-6e8c-70fc3e9e6eee@samsung.com>
Date:   Fri, 12 Aug 2022 14:33:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v7 2/7] Bluetooth: Add initial implementation of CIS
 connections
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CABBYNZ+vRqqCBVTgQJ-UZ+gd2ceFebQF94NDdYcN4Xmyk+GWTA@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsWy7djPc7prPb4lGSz5zmMx51ofs8XTz1NY
        HZg8ds66y+7xeZNcAFMUl01Kak5mWWqRvl0CV8bHFceZCvapVfz+M4e9gfG9bBcjJ4eEgInE
        hyuNrCC2kMAKRomTN9y7GLmA7C+MEmcP32OCSHxmlNjynxWmYeXeN2wQ8eWMEs2X4yAaPjJK
        9Gx9xAKS4BWwk7jVu5oZxGYRUJX4sLWfHSIuKHFy5hOwGlGBZIln/xeDxYUFwiS+X/8FZjML
        iEvcejIfaDEHh4iAocS3CzEQYXeJ/fO/grWyAYW73naB3cApECjx89xlNogaeYntb+cwQ9w5
        l0Pi0GNxCNtFYsXPB1BxYYlXx7ewQ9gyEv93QqySEMiX+DvDGCJcIXHt9RqocmuJO+d+sYGU
        MAtoSqzfpQ8RdpS4ufsiC0Qnn8SNt4IQB/BJTNo2nRkizCvR0SYEUa0mMev4OridBy9cYp7A
        qDQLKURmIfl8FpJXZiHsXcDIsopRPLW0ODc9tdgwL7Vcrzgxt7g0L10vOT93EyMwTZz+d/zT
        Dsa5rz7qHWJk4mA8xCjBwawkwlu26HOSEG9KYmVValF+fFFpTmrxIUZpDhYlcd7kzA2JQgLp
        iSWp2ampBalFMFkmDk6pBiZb5moGptqzRxVfPPSY+3BxrZfD/XD+OMmZRR/Ns86FcB+/wnXt
        WITANQ2J0GuPmfmv7rNfIuJwdPIjjZT2/XMuWqzaOGl+tOlaC//QbetTfqlu7dm/u9vlvS7r
        1basqtkHqk7EtAVrZaSY6HBYCeju2pgf7nEy88ylX7v95d8XrxU88l8idYmr6Lm3oU0BAevK
        ZztcdT7J4Jrsc59NUePCeXFW9X/LbwQGZ5ZPPbkrUzRy0clGmW875TNPP2/+cvTjc8ZErkOi
        d870RjqlHVs5xeimwAv7/ReKlA9efcHlavzW8N1/Rb0aE6kzYi93TIrzLzvU/TTd9dx5kZln
        7rpNYujo8rH+F3XN4Z/An6tKLMUZiYZazEXFiQB6hrijggMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42I5/e/4Pd01Ht+SDD4cN7WYc62P2eLp5yms
        DkweO2fdZff4vEkugClKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYl
        NSezLLVI3y5BL+PjiuNMBfvUKn7/mcPewPhetouRk0NCwERi5d43bF2MXBxCAksZJd48ncwG
        kZCRODmtgRXCFpb4c60Lqug9o8TW/dvAErwCdhK3elczg9gsAqoSH7b2s0PEBSVOznzCAmKL
        CiRLLDi0FMwWFgiT+H79F1gNs4C4xK0n85m6GDk4RAQMJb5diIEIu0vsn/8VrFxIYCezxPG7
        USA2G1BJ19susNs4BQIlfp67zAZRbybRtbWLEcKWl9j+dg7zBEahWUiumIVk2ywkLbOQtCxg
        ZFnFKJJaWpybnltsqFecmFtcmpeul5yfu4kRGCPbjv3cvINx3quPeocYmTgYDzFKcDArifCW
        LfqcJMSbklhZlVqUH19UmpNafIjRFBgUE5mlRJPzgVGaVxJvaGZgamhiZmlgamlmrCTO61nQ
        kSgkkJ5YkpqdmlqQWgTTx8TBKdXAxLM5wn/mpKXq3laiuRryDauXnjI2EXxv5jonLzFpWsvK
        fVv367a5Bt/y3/zNOiDoWsROYaYsGf9NJSv39D4WWZ6095rr8UC1mPd3/HQLTPf/3vzO+2vd
        1ORj3odFj6W2GjXPDMvZ9K73YO/PWq8F095Pqb8+Ny2tvuY4X8MurxKGQql9LxW+c81VtDP6
        UrNB5E2ylvOPvP8TTRfcWdVzLv5CwrYp80N8Hm+fMu3ZOg2GkJB3l7mFdOZOjn9f+Oqc7VaR
        amZ9p1JN1eS9+nEFLoIvla2Oej6NC3gy9cbq44tLs+84zCvbdjyn/7rnjK8Nru/v1D/omNSf
        OUkhIbHy32d56YnSn097vV+R5ny6X4mlOCPRUIu5qDgRABipkooaAwAA
X-CMS-MailID: 20220812123348eucas1p10a9fae0f49e7ee3f4788a965ffcc64c2
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
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On 10.08.2022 22:04, Luiz Augusto von Dentz wrote:
> Hi Marek,
>
> On Wed, Aug 10, 2022 at 7:18 AM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> Hi Luiz,
>>
>> On 09.08.2022 21:24, Luiz Augusto von Dentz wrote:
>>> On Tue, Aug 9, 2022 at 1:55 AM Marek Szyprowski
>>> <m.szyprowski@samsung.com>  wrote:
>>>> On 12.07.2022 01:35, Luiz Augusto von Dentz wrote:
>>>>> From: Luiz Augusto von Dentz<luiz.von.dentz@intel.com>
>>>>>
>>>>> This adds the initial implementation of CIS connections and introduces
>>>>> the ISO packets/links.
>>>>>
>>>>> == Central: Set CIG Parameters, create a CIS and Setup Data Path ==
>>>>>
>>>>>> tools/isotest -s <address>
>>>>> < HCI Command: LE Extended Create... (0x08|0x0043) plen 26
>>>>> ...
>>>>>> HCI Event: Command Status (0x0f) plen 4
>>>>>          LE Extended Create Connection (0x08|0x0043) ncmd 1
>>>>>            Status: Success (0x00)
>>>>>> HCI Event: LE Meta Event (0x3e) plen 31
>>>>>          LE Enhanced Connection Complete (0x0a)
>>>>>          ...
>>>>> < HCI Command: LE Create Connected... (0x08|0x0064) plen 5
>>>>> ...
>>>>>> HCI Event: Command Status (0x0f) plen 4
>>>>>          LE Create Connected Isochronous Stream (0x08|0x0064) ncmd 1
>>>>>            Status: Success (0x00)
>>>>>> HCI Event: LE Meta Event (0x3e) plen 29
>>>>>          LE Connected Isochronous Stream Established (0x19)
>>>>>          ...
>>>>> < HCI Command: LE Setup Isochronou.. (0x08|0x006e) plen 13
>>>>> ...
>>>>>> HCI Event: Command Complete (0x0e) plen 6
>>>>>          LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
>>>>>            Status: Success (0x00)
>>>>>            Handle: 257
>>>>> < HCI Command: LE Setup Isochronou.. (0x08|0x006e) plen 13
>>>>> ...
>>>>>> HCI Event: Command Complete (0x0e) plen 6
>>>>>          LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
>>>>>            Status: Success (0x00)
>>>>>            Handle: 257
>>>>>
>>>>> == Peripheral: Accept CIS and Setup Data Path ==
>>>>>
>>>>>> tools/isotest -d
>>>>>     HCI Event: LE Meta Event (0x3e) plen 7
>>>>>          LE Connected Isochronous Stream Request (0x1a)
>>>>> ...
>>>>> < HCI Command: LE Accept Co.. (0x08|0x0066) plen 2
>>>>> ...
>>>>>> HCI Event: LE Meta Event (0x3e) plen 29
>>>>>          LE Connected Isochronous Stream Established (0x19)
>>>>> ...
>>>>> < HCI Command: LE Setup Is.. (0x08|0x006e) plen 13
>>>>> ...
>>>>>> HCI Event: Command Complete (0x0e) plen 6
>>>>>          LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
>>>>>            Status: Success (0x00)
>>>>>            Handle: 257
>>>>> < HCI Command: LE Setup Is.. (0x08|0x006e) plen 13
>>>>> ...
>>>>>> HCI Event: Command Complete (0x0e) plen 6
>>>>>          LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
>>>>>            Status: Success (0x00)
>>>>>            Handle: 257
>>>>>
>>>>> Signed-off-by: Luiz Augusto von Dentz<luiz.von.dentz@intel.com>
>>>> This patch landed recently in linux-next as commit 26afbd826ee3
>>>> ("Bluetooth: Add initial implementation of CIS connections").
>>>> Unfortunately it causes a regression on my test systems. On almost all
>>>> I've observed that calling a simple 'hcitool scan' command in a shell
>>>> fails in an unexpected way:
>>>>
>>>> $ hcitool scan
>>>> *** stack smashing detected ***: <unknown> terminated
>>>> Aborted
>>> Not really sure how it would be related to ISO changes though, have
>>> you even enabled ISO sockets UUID? Perhaps check if there is something
>>> on dmesg indicating what is going on since I tried here and that
>>> doesn't seem to cause any problem:
>>>
>>> tools/hcitool scan
>>> Scanning ...
>>>
>>> Perhaps it is a combination of using old userspace tools with new
>>> kernel, but then again these changes should affect something like
>>> hcitool.
>> Indeed my userspace is old, but still, the kernel changes shouldn't make
>> it to crash. I didn't change anything in userspace since ages, so I
>> assume that ISO sockets UUIDs are not enabled. Maybe it is somehow
>> architecture related or specific? It looks that only ARM 32bit userspace
>> apps crashes. I've just checked 64bit userspace on ARM64 (RPi4) and it
>> works fine with that commit.
> That would be the first time it happens to me that a change in kernel
> would crash the userspace in such odd fashion, btw perhaps run with
> valgrind so it generates a backtrace of where it would be crashing,
> well if that is reproducible with valgrind.

Well, its not that easy. I've checked and Debian doesn't provide a 
valgrind package for the buster/armel arch, which I use on my test 
systems (for some historical reasons). Building everything from the 
source will take some time, though. I will try to do this after getting 
back from my holidays after 24th Aug.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

