Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5264C6FA82
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Sep 2022 10:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiIHK0L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Sep 2022 06:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiIHK0J (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Sep 2022 06:26:09 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362DB7CAA9
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Sep 2022 03:26:00 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220908102544euoutp0157d8de85cfaa541a591eefdfd0ee6c0a~S26wOGYi-2302123021euoutp01V
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Sep 2022 10:25:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220908102544euoutp0157d8de85cfaa541a591eefdfd0ee6c0a~S26wOGYi-2302123021euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1662632744;
        bh=T0b9YebozlOlUSD3qOJoRghrz3LdWHP8TO1O8MIt5iI=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=uThYPMKAjmvuIyEDYzpovkD+lYwfCV7mw2Hxsw7qXofRWuAa1aGDE8ZmT5lfvKVlI
         mCfMrujjFBpDOovfM0QU6rIplfS37AXp2X0urA7NlmB3jgrilkvc90/KfJtxorQiSn
         P0zcnBk29OkLMW1HEkbKwoidhILoT5fItz+LjX/8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220908102539eucas1p1bc9c5529d158a7b5acd2cc3138ed7e72~S26rS7EXZ2886928869eucas1p1I;
        Thu,  8 Sep 2022 10:25:39 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 6C.74.07817.323C9136; Thu,  8
        Sep 2022 11:25:39 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220908102538eucas1p1a92bc3a47ef168118e38e7e9ec0cf1a6~S26q09v0e2890228902eucas1p1Q;
        Thu,  8 Sep 2022 10:25:38 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220908102538eusmtrp2b62e4afcb1de8950d04d93fccb8c5fe9~S26q0Z0wA2734127341eusmtrp2g;
        Thu,  8 Sep 2022 10:25:38 +0000 (GMT)
X-AuditID: cbfec7f4-8abff70000011e89-a8-6319c323ea78
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id BF.5A.10862.223C9136; Thu,  8
        Sep 2022 11:25:38 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220908102538eusmtip12471e3bf60275d8150a117988d8355d6~S26qjQQNo1335913359eusmtip1b;
        Thu,  8 Sep 2022 10:25:38 +0000 (GMT)
Message-ID: <4263c3ba-036b-ae67-ab29-166325ce6aba@samsung.com>
Date:   Thu, 8 Sep 2022 12:25:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v7 2/7] Bluetooth: Add initial implementation of CIS
 connections
Content-Language: en-US
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <41717010-b7a5-40e4-39d7-722fb6d18eae@samsung.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRmVeSWpSXmKPExsWy7djP87rKhyWTDY7sYbOYc62P2eLp5yms
        DkweO2fdZff4vEkugCmKyyYlNSezLLVI3y6BK2Pnz1PMBdudK35uW8TYwHjTvIuRk0NCwERi
        5cSJjF2MXBxCAisYJS53TWEDSQgJfGGUmLNSESLxmVGitXMXK0zH1gtLmCASy4ESuxrZIZyP
        jBJfnl1gB6niFbCT+HPpIiOIzSKgIvH88042iLigxMmZT1hAbFGBZIlZx46B1QgLhEl8v/4L
        rJdZQFzi1pP5TCA2m4ChRNfbLqBeDg4RIPvbhRiIEneJ/fO/go3hFLCXWPt/AjNEXF6ieets
        ZpB7JATmckh8+QAxX0LARWLG1UtsELawxKvjW9ghbBmJ/zvnM0E0tDNKLPh9H8qZwCjR8PwW
        VLe1xJ1zv8CuYBbQlFi/Sx8i7Chxc/dFFpCwhACfxI23ghBH8ElM2jadGSLMK9HRJgRRrSYx
        6/g6uLUHL1xinsCoNAspVGYh+X4WkndmIexdwMiyilE8tbQ4Nz212CgvtVyvODG3uDQvXS85
        P3cTIzBlnP53/MsOxuWvPuodYmTiYDzEKMHBrCTCK7pWIlmINyWxsiq1KD++qDQntfgQozQH
        i5I4b3LmhkQhgfTEktTs1NSC1CKYLBMHp1QDE+O7eI43mfXTLr+0cmx/9NFlnfKqk8lnz54r
        2sByao3S1aijdQZHfSLzz5fPDD9rvdlty0HXlQcW+LmzFKXuSYv7NPWendQNQcuY2MJMUZls
        0csyFyYl8vzeuHL9vFvu9c+c5z7d8Oe8j9jU/9V7fmi8vvGsRZsnsWD2IZYInoZtv2M27Lq8
        aMWdEJZTV7Z4sl1OqeuYz5pbxtEQ+LXLVqHMpiz9nPvsot++Mo9uP2USSb/RHsR7JixG6M83
        AW+Or/fa1AvSBZxm5BxZKn0nuU506SwPvoz+CobnJw1lOifkTtrCdY3xSHTKY3GW82wrvybd
        1Z/hcL/X9PpC7c3flNpfLLS4rrYjbOr1/m1zTiqxFGckGmoxFxUnAgB8S1nxiAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42I5/e/4XV2lw5LJBufWKFvMudbHbPH08xRW
        ByaPnbPusnt83iQXwBSlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OS
        mpNZllqkb5egl7Hz5ynmgu3OFT+3LWJsYLxp3sXIySEhYCKx9cISpi5GLg4hgaWMEpe/bWeC
        SMhInJzWwAphC0v8udbFBlH0nlHiRd8fFpAEr4CdxJ9LFxlBbBYBFYnnn3eyQcQFJU7OfAJW
        IyqQLLGk4T7YIGGBMInv13+xg9jMAuISt57MB1vGJmAo0fUWZAEHhwiQ/e1CDESJu8T++V9Z
        IPYuZpGY0/UKbCangL3E2v8TmCGKzCS6tnYxQtjyEs1bZzNPYBSaheSMWUjWzULSMgtJywJG
        llWMIqmlxbnpucVGesWJucWleel6yfm5mxiBUbLt2M8tOxhXvvqod4iRiYPxEKMEB7OSCK/o
        WolkId6UxMqq1KL8+KLSnNTiQ4ymwLCYyCwlmpwPjNO8knhDMwNTQxMzSwNTSzNjJXFez4KO
        RCGB9MSS1OzU1ILUIpg+Jg5OqQYmtscnsv10Ze54XU24uinzvPbEh/zrTydG9ahO/2kzgWVd
        y7Y6/T1nk/flM+rMSEiedJVlMcfcc5dX6v/wf2kh3XhT11si+eHUg18engzfX7G9T8bwjIaO
        /4eXhvUalkv2vCx7+93dnotrSsr9H3k2Ve1rQmcrc/y0q+fuuvaYN97ze619+sZtJzsyjp97
        lvn5fEzeVqPX4jNSrnXll14yZTco6fsr/5r1X63riu9Rh489u75p916pA/dNrnFZGNxqPS+V
        t9cyfuLm4G/HfjLtfiUkEXDH7+eT+BsCDJvTL07TN7Jl/j1F6aL35ll7lX4GBdqcbkiZ/lN7
        Rk/IpIhVO9pn3XGJ9Hlj99oqM4P/lhJLcUaioRZzUXEiAAjHmN4bAwAA
X-CMS-MailID: 20220908102538eucas1p1a92bc3a47ef168118e38e7e9ec0cf1a6
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
        <41717010-b7a5-40e4-39d7-722fb6d18eae@samsung.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi All,

On 16.08.2022 17:24, Marek Szyprowski wrote:
> On 12.08.2022 14:33, Marek Szyprowski wrote:
>> On 10.08.2022 22:04, Luiz Augusto von Dentz wrote:
>>> On Wed, Aug 10, 2022 at 7:18 AM Marek Szyprowski
>>> <m.szyprowski@samsung.com> wrote:
>>>> On 09.08.2022 21:24, Luiz Augusto von Dentz wrote:
>>>>> On Tue, Aug 9, 2022 at 1:55 AM Marek Szyprowski
>>>>> <m.szyprowski@samsung.com>  wrote:
>>>>>> On 12.07.2022 01:35, Luiz Augusto von Dentz wrote:
>>>>>>> From: Luiz Augusto von Dentz<luiz.von.dentz@intel.com>
>>>>>>>
>>>>>>> This adds the initial implementation of CIS connections and 
>>>>>>> introduces
>>>>>>> the ISO packets/links.
>>>>>>>
>>>>>>> == Central: Set CIG Parameters, create a CIS and Setup Data Path ==
>>>>>>>
>>>>>>>> tools/isotest -s <address>
>>>>>>> < HCI Command: LE Extended Create... (0x08|0x0043) plen 26
>>>>>>> ...
>>>>>>>> HCI Event: Command Status (0x0f) plen 4
>>>>>>>          LE Extended Create Connection (0x08|0x0043) ncmd 1
>>>>>>>            Status: Success (0x00)
>>>>>>>> HCI Event: LE Meta Event (0x3e) plen 31
>>>>>>>          LE Enhanced Connection Complete (0x0a)
>>>>>>>          ...
>>>>>>> < HCI Command: LE Create Connected... (0x08|0x0064) plen 5
>>>>>>> ...
>>>>>>>> HCI Event: Command Status (0x0f) plen 4
>>>>>>>          LE Create Connected Isochronous Stream (0x08|0x0064) 
>>>>>>> ncmd 1
>>>>>>>            Status: Success (0x00)
>>>>>>>> HCI Event: LE Meta Event (0x3e) plen 29
>>>>>>>          LE Connected Isochronous Stream Established (0x19)
>>>>>>>          ...
>>>>>>> < HCI Command: LE Setup Isochronou.. (0x08|0x006e) plen 13
>>>>>>> ...
>>>>>>>> HCI Event: Command Complete (0x0e) plen 6
>>>>>>>          LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
>>>>>>>            Status: Success (0x00)
>>>>>>>            Handle: 257
>>>>>>> < HCI Command: LE Setup Isochronou.. (0x08|0x006e) plen 13
>>>>>>> ...
>>>>>>>> HCI Event: Command Complete (0x0e) plen 6
>>>>>>>          LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
>>>>>>>            Status: Success (0x00)
>>>>>>>            Handle: 257
>>>>>>>
>>>>>>> == Peripheral: Accept CIS and Setup Data Path ==
>>>>>>>
>>>>>>>> tools/isotest -d
>>>>>>>     HCI Event: LE Meta Event (0x3e) plen 7
>>>>>>>          LE Connected Isochronous Stream Request (0x1a)
>>>>>>> ...
>>>>>>> < HCI Command: LE Accept Co.. (0x08|0x0066) plen 2
>>>>>>> ...
>>>>>>>> HCI Event: LE Meta Event (0x3e) plen 29
>>>>>>>          LE Connected Isochronous Stream Established (0x19)
>>>>>>> ...
>>>>>>> < HCI Command: LE Setup Is.. (0x08|0x006e) plen 13
>>>>>>> ...
>>>>>>>> HCI Event: Command Complete (0x0e) plen 6
>>>>>>>          LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
>>>>>>>            Status: Success (0x00)
>>>>>>>            Handle: 257
>>>>>>> < HCI Command: LE Setup Is.. (0x08|0x006e) plen 13
>>>>>>> ...
>>>>>>>> HCI Event: Command Complete (0x0e) plen 6
>>>>>>>          LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
>>>>>>>            Status: Success (0x00)
>>>>>>>            Handle: 257
>>>>>>>
>>>>>>> Signed-off-by: Luiz Augusto von Dentz<luiz.von.dentz@intel.com>
>>>>>> This patch landed recently in linux-next as commit 26afbd826ee3
>>>>>> ("Bluetooth: Add initial implementation of CIS connections").
>>>>>> Unfortunately it causes a regression on my test systems. On 
>>>>>> almost all
>>>>>> I've observed that calling a simple 'hcitool scan' command in a 
>>>>>> shell
>>>>>> fails in an unexpected way:
>>>>>>
>>>>>> $ hcitool scan
>>>>>> *** stack smashing detected ***: <unknown> terminated
>>>>>> Aborted
>>>>> Not really sure how it would be related to ISO changes though, have
>>>>> you even enabled ISO sockets UUID? Perhaps check if there is 
>>>>> something
>>>>> on dmesg indicating what is going on since I tried here and that
>>>>> doesn't seem to cause any problem:
>>>>>
>>>>> tools/hcitool scan
>>>>> Scanning ...
>>>>>
>>>>> Perhaps it is a combination of using old userspace tools with new
>>>>> kernel, but then again these changes should affect something like
>>>>> hcitool.
>>>> Indeed my userspace is old, but still, the kernel changes shouldn't 
>>>> make
>>>> it to crash. I didn't change anything in userspace since ages, so I
>>>> assume that ISO sockets UUIDs are not enabled. Maybe it is somehow
>>>> architecture related or specific? It looks that only ARM 32bit 
>>>> userspace
>>>> apps crashes. I've just checked 64bit userspace on ARM64 (RPi4) and it
>>>> works fine with that commit.
>>> That would be the first time it happens to me that a change in kernel
>>> would crash the userspace in such odd fashion, btw perhaps run with
>>> valgrind so it generates a backtrace of where it would be crashing,
>>> well if that is reproducible with valgrind.
>>
>> Well, its not that easy. I've checked and Debian doesn't provide a 
>> valgrind package for the buster/armel arch, which I use on my test 
>> systems (for some historical reasons). Building everything from the 
>> source will take some time, though. I will try to do this after 
>> getting back from my holidays after 24th Aug.
>
> Unfortunately my holidays trip didn't start, so I had a chance to play 
> a bit with this issue.
>
> Valgrind doesn't really provide any useful information here:
>
> $ valgrind hcitool scan
> ==1391== Memcheck, a memory error detector
> ==1391== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
> ==1391== Using Valgrind-3.14.0 and LibVEX; rerun with -h for copyright 
> info
> ==1391== Command: hcitool scan
> ==1391==
> *** stack smashing detected ***: <unknown> terminated
> ==1391==
> ==1391== Process terminating with default action of signal 6 (SIGABRT)
> ==1391==    at 0x48EB6AC: raise (raise.c:51)
> ==1391==    by 0x48D6283: abort (abort.c:79)
> ==1391==    by 0x4928E3B: __libc_message (libc_fatal.c:181)
> ==1391==    by 0x49ACFE3: __fortify_fail_abort (fortify_fail.c:33)
> ==1391==    by 0x49ACFA7: __stack_chk_fail (stack_chk_fail.c:29)
> ==1391==    by 0x117DFB: ??? (in /usr/bin/hcitool)
> ==1391==
> ==1391== HEAP SUMMARY:
> ==1391==     in use at exit: 132 bytes in 1 blocks
> ==1391==   total heap usage: 1 allocs, 0 frees, 132 bytes allocated
> ==1391==
> ==1391== LEAK SUMMARY:
> ==1391==    definitely lost: 0 bytes in 0 blocks
> ==1391==    indirectly lost: 0 bytes in 0 blocks
> ==1391==      possibly lost: 0 bytes in 0 blocks
> ==1391==    still reachable: 132 bytes in 1 blocks
> ==1391==         suppressed: 0 bytes in 0 blocks
> ==1391== Rerun with --leak-check=full to see details of leaked memory
> ==1391==
> ==1391== For counts of detected and suppressed errors, rerun with: -v
> ==1391== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)
> Aborted
>
>
> I've also checked the ARM 32bit 'armhf' userspace abi on vanilla 
> Raspberry Pi OS Lite 32-bit image (from April 4th 2022). The issue is 
> same:
>
> $ hcitool scan
> *** stack smashing detected ***: terminated
> Aborted
>
> It is enough to boot that image with init=/bin/bash and run 'hcitool 
> scan' to reproduce the issue...
>

I've had some time to analyze this issue further and I've finally found 
which change is responsible for this issue. It is caused by the 
following chunk:

diff --git a/include/net/bluetooth/hci_sock.h 
b/include/net/bluetooth/hci_sock.h
index 9949870f7d78..0520e21ab698 100644
--- a/include/net/bluetooth/hci_sock.h
+++ b/include/net/bluetooth/hci_sock.h
@@ -124,6 +124,8 @@ struct hci_dev_info {
         __u16 acl_pkts;
         __u16 sco_mtu;
         __u16 sco_pkts;
+       __u16 iso_mtu;
+       __u16 iso_pkts;

         struct hci_dev_stats stat;
  };

It looks that this is an ABI break for some old userspace tools. I've 
confirmed this by applying only the above chunk on top of v5.19-rc1 and 
running my tests. 'hcitool scan' crashes in such case.

I've also removed that chunk from the v6.0-rc1 release and surprisingly 
I found that it is not used by the bluetooth code! Kernel compiled 
successfully. Is that change intentional? Or is it just a leftover from 
the development process that accidentally made its way into final patch?


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

