Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F40AC25B06
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Aug 2022 08:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241178AbiHIIzG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Aug 2022 04:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236411AbiHIIzE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Aug 2022 04:55:04 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F8122501
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Aug 2022 01:55:02 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220809085500euoutp0233b1b780cf5b786ff8cbdb0e6fc8768c~JoU_HTi8k1582115821euoutp02a
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Aug 2022 08:55:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220809085500euoutp0233b1b780cf5b786ff8cbdb0e6fc8768c~JoU_HTi8k1582115821euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660035300;
        bh=TaCxZlWNUBIqikL0MJqaqi4m3uwm9yQMLJvWiRgih7k=;
        h=Date:Subject:To:From:In-Reply-To:References:From;
        b=VtEk6wNf6imzXiiN3cDOM5DsRmMi0sXfFO/BriRr1n+7K6+9RsHmVnV8hjsX64F+w
         AMIsej30epiB/e4qSD5tPiyzyb1+DnK6NngxWDoTdEtW8L/0El7vVJw3xPgjVY+Ljg
         i/sXh8QnUuGjB3rHHz/ASsTW++6LgQOeJMKoRjL8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220809085500eucas1p248c8f12a9247815e64558d882d7d0430~JoU_ACDJ_1533115331eucas1p2B;
        Tue,  9 Aug 2022 08:55:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 4F.73.09580.4E022F26; Tue,  9
        Aug 2022 09:55:00 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220809085500eucas1p18cb2752164ca55832787e7d3843f48ab~JoU9rzRF00514505145eucas1p1M;
        Tue,  9 Aug 2022 08:55:00 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220809085500eusmtrp238f5a4e877574d8965805377af4fbcff~JoU9rNGiY2790027900eusmtrp2o;
        Tue,  9 Aug 2022 08:55:00 +0000 (GMT)
X-AuditID: cbfec7f5-9adff7000000256c-3e-62f220e4c66c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B3.9E.09038.4E022F26; Tue,  9
        Aug 2022 09:55:00 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220809085459eusmtip1368cb8892560f73a266bf08fd37fdf06~JoU9ckBTd2325223252eusmtip1e;
        Tue,  9 Aug 2022 08:54:59 +0000 (GMT)
Message-ID: <749ed578-bc9d-b699-3602-bee444fff9bb@samsung.com>
Date:   Tue, 9 Aug 2022 10:54:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v7 2/7] Bluetooth: Add initial implementation of CIS
 connections
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220711233535.3134546-2-luiz.dentz@gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsWy7djPc7pPFD4lGbyZKW0x51ofs8XTz1NY
        HZg8ds66y+7xeZNcAFMUl01Kak5mWWqRvl0CV8a+N5+YC26qVFw+vo2xgfGETBcjJ4eEgInE
        zrUbGbsYuTiEBFYwSqz9cADK+cIoseDidWYI5zOjRHvPMWaYlr3Hu6CqljNKHFn2hgnC+cgo
        8XDRf0aQKl4BO4nnc2+wgNgsAioSU3p7WSDighInZz4Bs0UFkiWe/V/MDmILC4RJfL/+C8xm
        FhCXuPVkPtBQDg4RgRCJnl2SIGE2AUOJrrddbCA2p4CNxNyfLSwQ5fIS29/OAbtUQqCTQ+LV
        y4OMEJe6SFxb3ckKYQtLvDq+hR3ClpH4vxNivoRAvsTfGcYQ4QqJa6/XQD1pLXHn3C82kBJm
        AU2J9bv0IcKOEjd3X2SB6OSTuPFWEOICPolJ26YzQ4R5JTrahCCq1SRmHV8Ht/PghUtQwz0k
        Pjw9xjiBUXEWUpDMQvL6LCR/zUK4YQEjyypG8dTS4tz01GLjvNRyveLE3OLSvHS95PzcTYzA
        dHH63/GvOxhXvPqod4iRiYPxEKMEB7OSCO+Rte+ThHhTEiurUovy44tKc1KLDzFKc7AoifMm
        Z25IFBJITyxJzU5NLUgtgskycXBKNTAtW7TPXNPztO33+bzzHxsVzBf/kRM723PZCX494Wql
        N0K1czsPJ6ikv3FcX+MifiTfQfrNRfn9d2Z+ePT4f2hCSNrG7yeC/k7qE+wWt+ndk7aHpWi6
        +6Pb325dEfLdmRyh+EH/9bb975axeO5lmtk4P9JAKmmZL+tMQfbWNdOOX/2803SdoqF8X7Ec
        1+U1kouFjnFMFY1M8zin1WW5xKQj9/vdy/feqsYvqCiyXprf/qbJK3q/n8q/CxcZTC7Zm1gF
        nD+6V7otYlJol8pdzraEjDq1Zf2CzF84Dgp4LpFQt52qFy10X8rggUlnrUyMTw/X8enO1z4/
        /7ZNlL+WicEn5eHEkKUMHls2now0/KrEUpyRaKjFXFScCABFG9LAhgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsVy+t/xu7pPFD4lGfx+xGox51ofs8XTz1NY
        HZg8ds66y+7xeZNcAFOUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1K
        ak5mWWqRvl2CXsa+N5+YC26qVFw+vo2xgfGETBcjJ4eEgInE3uNdjCC2kMBSRokFy6DiMhIn
        pzWwQtjCEn+udbFB1LxnlPh63BvE5hWwk3g+9wYLiM0ioCIxpbeXBSIuKHFy5hMwW1QgWWLB
        oaVgtrBAmMT367/YQWxmAXGJW0/mM4HYIgIhEmv7TrJCzM+VOH3lPdg9bAKGEl1vIfZyCthI
        zP3ZwgLRaybRtRXiZmYBeYntb+cwT2AUnIVk9SwkK2YhaZmFpGUBI8sqRpHU0uLc9NxiI73i
        xNzi0rx0veT83E2MwEjYduznlh2MK1991DvEyMTBeIhRgoNZSYT3yNr3SUK8KYmVValF+fFF
        pTmpxYcYTYH+n8gsJZqcD4zFvJJ4QzMDU0MTM0sDU0szYyVxXs+CjkQhgfTEktTs1NSC1CKY
        PiYOTqkGJhde3okx2x7O2VHYE1ngs2f7+941ixJ2rd1+T+3brJJKffvEGSfeHk7boJIdFaid
        aHkgbONuJi691g6uqtAiT7eV8wRsvPSveOnPDbi73zHWKEmS8+ixJbvnv5+gxxY+Mca2WPT0
        m6jZSUv/512aF+j3Lkfr4KN5xvIfbwlU3Nj8SIpx0cEZnKZMfx5JqW8+yrdO/rVfX1tNW7rJ
        HfnnzR2NnZq5S7t0PsloxHfsvCS4+qLfDMH+RVUuU5JOJjNdtp3x5vuhfivuG1nnjDxWGR67
        W535WWra2c6imLlTrrxoZpa8Hu2w+vrVA381iiN6cu/OX7xHfJr2hH7hF4k8ERsnVO3hP3zV
        U5hn62HhB0osxRmJhlrMRcWJAGq0nOUNAwAA
X-CMS-MailID: 20220809085500eucas1p18cb2752164ca55832787e7d3843f48ab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220809085500eucas1p18cb2752164ca55832787e7d3843f48ab
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220809085500eucas1p18cb2752164ca55832787e7d3843f48ab
References: <20220711233535.3134546-1-luiz.dentz@gmail.com>
        <20220711233535.3134546-2-luiz.dentz@gmail.com>
        <CGME20220809085500eucas1p18cb2752164ca55832787e7d3843f48ab@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On 12.07.2022 01:35, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This adds the initial implementation of CIS connections and introduces
> the ISO packets/links.
>
> == Central: Set CIG Parameters, create a CIS and Setup Data Path ==
>
>> tools/isotest -s <address>
> < HCI Command: LE Extended Create... (0x08|0x0043) plen 26
> ...
>> HCI Event: Command Status (0x0f) plen 4
>        LE Extended Create Connection (0x08|0x0043) ncmd 1
>          Status: Success (0x00)
>> HCI Event: LE Meta Event (0x3e) plen 31
>        LE Enhanced Connection Complete (0x0a)
>        ...
> < HCI Command: LE Create Connected... (0x08|0x0064) plen 5
> ...
>> HCI Event: Command Status (0x0f) plen 4
>        LE Create Connected Isochronous Stream (0x08|0x0064) ncmd 1
>          Status: Success (0x00)
>> HCI Event: LE Meta Event (0x3e) plen 29
>        LE Connected Isochronous Stream Established (0x19)
>        ...
> < HCI Command: LE Setup Isochronou.. (0x08|0x006e) plen 13
> ...
>> HCI Event: Command Complete (0x0e) plen 6
>        LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
>          Status: Success (0x00)
>          Handle: 257
> < HCI Command: LE Setup Isochronou.. (0x08|0x006e) plen 13
> ...
>> HCI Event: Command Complete (0x0e) plen 6
>        LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
>          Status: Success (0x00)
>          Handle: 257
>
> == Peripheral: Accept CIS and Setup Data Path ==
>
>> tools/isotest -d
>   HCI Event: LE Meta Event (0x3e) plen 7
>        LE Connected Isochronous Stream Request (0x1a)
> ...
> < HCI Command: LE Accept Co.. (0x08|0x0066) plen 2
> ...
>> HCI Event: LE Meta Event (0x3e) plen 29
>        LE Connected Isochronous Stream Established (0x19)
> ...
> < HCI Command: LE Setup Is.. (0x08|0x006e) plen 13
> ...
>> HCI Event: Command Complete (0x0e) plen 6
>        LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
>          Status: Success (0x00)
>          Handle: 257
> < HCI Command: LE Setup Is.. (0x08|0x006e) plen 13
> ...
>> HCI Event: Command Complete (0x0e) plen 6
>        LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
>          Status: Success (0x00)
>          Handle: 257
>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This patch landed recently in linux-next as commit 26afbd826ee3 
("Bluetooth: Add initial implementation of CIS connections"). 
Unfortunately it causes a regression on my test systems. On almost all 
I've observed that calling a simple 'hcitool scan' command in a shell 
fails in an unexpected way:

$ hcitool scan
*** stack smashing detected ***: <unknown> terminated
Aborted

$

The above 'stack smashing' issue I've observed on Raspberry Pi4 with ARM 
32bit kernel.

Bisecting this lead me to this commit. Reverting it on top of 
next-20220808, together with the following commits due to dependencies, 
fixes the issue:

26afbd826ee326e63a334c37fd45e82e50a615ec "Bluetooth: Add initial 
implementation of CIS connections"
e78165d2ce798451d08ac09d704cd72caa962b81 "Bluetooth: hci_conn: Fix 
updating ISO QoS PHY"
ccf74f2390d60a2f9a75ef496d2564abb478f46a "Bluetooth: Add BTPROTO_ISO 
socket type"
f764a6c2c1e446f560faa3232271a0637369170b "Bluetooth: ISO: Add broadcast 
support"
c85008a4e748051cddc6be6333f55df476f35362 "Bluetooth: ISO: unlock on 
error path in iso_sock_setsockopt()"
82e07ef4b474f466b4b2955bad76c52d6df98a30 "Bluetooth: ISO: Fix info leak 
in iso_sock_getsockopt()"
c5d36b8a7dbdcf41da7316252b717c60c409992b "Bluetooth: ISO: Fix memory 
corruption"
8a3fd9bb4fac67ad5d44d6540c7ac20004767076 "Bluetooth: ISO: Fix 
iso_sock_getsockopt for BT_DEFER_SETUP"
aac59090a068139550f9b73d46d1116e31cdd2d1 "Bluetooth: ISO: Fix not using 
the correct QoS"
eca0ae4aea66914515e5e3098ea051b518ee5316 "Bluetooth: Add initial 
implementation of BIS connections"

Let me know if I can help fixing this issue.

> ---
>   include/net/bluetooth/bluetooth.h |  33 ++-
>   include/net/bluetooth/hci.h       |  28 +-
>   include/net/bluetooth/hci_core.h  | 107 +++++++-
>   include/net/bluetooth/hci_sock.h  |   2 +
>   include/net/bluetooth/hci_sync.h  |   3 +
>   net/bluetooth/Kconfig             |   1 +
>   net/bluetooth/hci_conn.c          | 440 ++++++++++++++++++++++++++++++
>   net/bluetooth/hci_core.c          | 230 ++++++++++++----
>   net/bluetooth/hci_event.c         | 307 ++++++++++++++++++++-
>   net/bluetooth/hci_sync.c          |  49 +++-
>   10 files changed, 1145 insertions(+), 55 deletions(-)
>
> ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

