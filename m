Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB7BC00140
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Aug 2022 14:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiHJOSk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Aug 2022 10:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbiHJOSd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Aug 2022 10:18:33 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF75872864
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Aug 2022 07:18:30 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220810141825euoutp020d9cf06ce40798f54cd5ffff4d76d906~KAYok9M2Z1133911339euoutp02t
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Aug 2022 14:18:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220810141825euoutp020d9cf06ce40798f54cd5ffff4d76d906~KAYok9M2Z1133911339euoutp02t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660141105;
        bh=BnDcz2EmBck9Vi9ruJ5yWXLvBtvewWeVg1ZkV0APqds=;
        h=Date:From:Subject:To:Cc:In-Reply-To:References:From;
        b=l28DXoz/Dz9WUbSvf3GuZ5tQbMIGA7IQaR/bgFhPUAw8VF+QdPAfJdXmePKSQxv5f
         duye0rW7psbyL9iTFj/gksdSS3M3AqgbIGj1FxNB/hB0WhT3xGiRq74zLvW7SzEYB3
         4honwetJp8Pm0Tys2rIXqGYENBDJ/kHgUt3SsO0c=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220810141825eucas1p1e5e37536baf145ff518933dc68a0a297~KAYoY2ayd1036810368eucas1p1z;
        Wed, 10 Aug 2022 14:18:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 3D.54.09664.13EB3F26; Wed, 10
        Aug 2022 15:18:25 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220810141824eucas1p121fafeacd666c7a6e509668ce4af38ba~KAYn_j9BU2943929439eucas1p1V;
        Wed, 10 Aug 2022 14:18:24 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220810141824eusmtrp234146273ba57a5a34834ae4eec4df65e~KAYn96ePS2808628086eusmtrp2c;
        Wed, 10 Aug 2022 14:18:24 +0000 (GMT)
X-AuditID: cbfec7f2-d97ff700000025c0-b5-62f3be31c026
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A9.27.09095.03EB3F26; Wed, 10
        Aug 2022 15:18:24 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220810141824eusmtip2590cc0ddb980c9cdd8c573fc50a5ce52~KAYnvbSTJ2244322443eusmtip2X;
        Wed, 10 Aug 2022 14:18:24 +0000 (GMT)
Message-ID: <03f9bea9-77fb-2b57-43d0-c4b819c2560a@samsung.com>
Date:   Wed, 10 Aug 2022 16:18:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.12.0
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v7 2/7] Bluetooth: Add initial implementation of CIS
 connections
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Language: en-US
In-Reply-To: <CABBYNZLsR0KT1-OVVjnUzLp0+U0eHGi0PNqKbfntp_5AHNDawA@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsWy7djPc7qG+z4nGWx5ymUx51ofs8XTz1NY
        HZg8ds66y+7xeZNcAFMUl01Kak5mWWqRvl0CV8by5ctYCr7JVUyY0MHcwHhHvIuRk0NCwETi
        8ZlXTF2MXBxCAisYJRYubGeGcL4wSpw7fAAq85lR4lNnGxNMy/s9c9hAbCGB5YwSU1bUQRR9
        ZJQ4ffoLC0iCV8BOYumzbrAiFgFVie6Zr9gh4oISJ2c+AasRFUiWePZ/MVicTcBQouttF1i9
        sECYxPfrv4DiHBwiQPFvF2JAwswC7hL7539lgbDFJW49mQ92D6dAoMSDxhnsEHF5ie1v54B9
        ICEwk0Ni5/xdLBBHu0gcXrWYDcIWlnh1fAs7hC0j8X8nyCAOIDtf4u8MY4hwhcS112uYIWxr
        iTvnfrGBlDALaEqs36UPEXaUuLn7IgtEJ5/EjbeCEBfwSUzaNp0ZIswr0dEmBFGtJjHr+Dq4
        nQcvXGKewKg0CylIZiH5axaSX2Yh7F3AyLKKUTy1tDg3PbXYMC+1XK84Mbe4NC9dLzk/dxMj
        MFmc/nf80w7Gua8+6h1iZOJgPMQowcGsJMJbtuhzkhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe
        5MwNiUIC6YklqdmpqQWpRTBZJg5OqQYmu2eyMTNZNSv+JLxd6h5m4enYs0MoLmy69Id1/5rP
        WCW9WH4ot+PMWpVrWzdPVJ4YNqnhuFHIoTzFxcVaDZs1NBWd2vz6Vh15ZmX++WpXi+aHuCuW
        Nj6nLNfHCVvutvvIwaAWxmn6aO7m484r3X+lW8ndsNtck36k66NkoWir/FZ7lX8/42UevfKa
        F/T02EL1nK9MU+70b3x5yq7Z6pCpvIYp1+HPeazHbn67oplQ1SvSETOZUUPXlinR62iWzPmj
        p8/PZzLSWvXfe+UNqePXtTo9bc7I/opZ3HzRfcI8fi+zvalcl9gzD7067vrGJ2f1Qm82x5ZZ
        3wu/H1FevyDH8nNksNztG1uVM3Y36MxQYinOSDTUYi4qTgQAa8YS74UDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42I5/e/4PV2DfZ+TDJ5c1bOYc62P2eLp5yms
        DkweO2fdZff4vEkugClKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYl
        NSezLLVI3y5BL2P58mUsBd/kKiZM6GBuYLwj3sXIySEhYCLxfs8cti5GLg4hgaWMEnu2b2GC
        SMhInJzWwAphC0v8udYFVfSeUWL6p+lsIAleATuJpc+6wWwWAVWJ7pmv2CHighInZz5hAbFF
        BZIlFhxaCmazCRhKdL3tAqsXFgiT+H79F1A9B4cIUPzbhRiQMLOAu8T++V9ZIHbtZZL4NP8V
        I0RCXOLWk/lgx3EKBEo8aJzBDhE3k+ja2gVVIy+x/e0c5gmMQrOQnDELSfssJC2zkLQsYGRZ
        xSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERgl24793LyDcd6rj3qHGJk4GA8xSnAwK4nwli36
        nCTEm5JYWZValB9fVJqTWnyI0RQYFhOZpUST84FxmlcSb2hmYGpoYmZpYGppZqwkzutZ0JEo
        JJCeWJKanZpakFoE08fEwSnVwJS4S8AkQli/IawuRN70mNBk+ws7Tz2Q4gt+Pv3vvNUnju/n
        kd5wqXu9UcWrnUGnd61uTGDKTArxWBhUp8iwpeJBx5WFYsxv5ZJVXMXWl3ooeE72Wm5z2khr
        2lm/ON2D51fkuRROtbcRXruvU8VVx0WubavFZqVDORfL9v8NmXn2oR7rIV8errlNOyWrKq1O
        qwZEzrFKD1E5JfbyTUGGcG1aY1V26dqrNrJnLmvVRJ6/8Sz3t5zJwoeLziyfdfHUzOnvflsK
        C7d5eB9VW1HCWp7/w0d5pml13eLrAi/WR99/0Tc9V1im/C0rG+Oxw045q+bnzK4QsC6xebZS
        cM3BGWk3XRITjhv++r0x5P9jaSWW4oxEQy3mouJEAPMyIbobAwAA
X-CMS-MailID: 20220810141824eucas1p121fafeacd666c7a6e509668ce4af38ba
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
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On 09.08.2022 21:24, Luiz Augusto von Dentz wrote:
> On Tue, Aug 9, 2022 at 1:55 AM Marek Szyprowski
> <m.szyprowski@samsung.com>  wrote:
>> On 12.07.2022 01:35, Luiz Augusto von Dentz wrote:
>>> From: Luiz Augusto von Dentz<luiz.von.dentz@intel.com>
>>>
>>> This adds the initial implementation of CIS connections and introduces
>>> the ISO packets/links.
>>>
>>> == Central: Set CIG Parameters, create a CIS and Setup Data Path ==
>>>
>>>> tools/isotest -s <address>
>>> < HCI Command: LE Extended Create... (0x08|0x0043) plen 26
>>> ...
>>>> HCI Event: Command Status (0x0f) plen 4
>>>         LE Extended Create Connection (0x08|0x0043) ncmd 1
>>>           Status: Success (0x00)
>>>> HCI Event: LE Meta Event (0x3e) plen 31
>>>         LE Enhanced Connection Complete (0x0a)
>>>         ...
>>> < HCI Command: LE Create Connected... (0x08|0x0064) plen 5
>>> ...
>>>> HCI Event: Command Status (0x0f) plen 4
>>>         LE Create Connected Isochronous Stream (0x08|0x0064) ncmd 1
>>>           Status: Success (0x00)
>>>> HCI Event: LE Meta Event (0x3e) plen 29
>>>         LE Connected Isochronous Stream Established (0x19)
>>>         ...
>>> < HCI Command: LE Setup Isochronou.. (0x08|0x006e) plen 13
>>> ...
>>>> HCI Event: Command Complete (0x0e) plen 6
>>>         LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
>>>           Status: Success (0x00)
>>>           Handle: 257
>>> < HCI Command: LE Setup Isochronou.. (0x08|0x006e) plen 13
>>> ...
>>>> HCI Event: Command Complete (0x0e) plen 6
>>>         LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
>>>           Status: Success (0x00)
>>>           Handle: 257
>>>
>>> == Peripheral: Accept CIS and Setup Data Path ==
>>>
>>>> tools/isotest -d
>>>    HCI Event: LE Meta Event (0x3e) plen 7
>>>         LE Connected Isochronous Stream Request (0x1a)
>>> ...
>>> < HCI Command: LE Accept Co.. (0x08|0x0066) plen 2
>>> ...
>>>> HCI Event: LE Meta Event (0x3e) plen 29
>>>         LE Connected Isochronous Stream Established (0x19)
>>> ...
>>> < HCI Command: LE Setup Is.. (0x08|0x006e) plen 13
>>> ...
>>>> HCI Event: Command Complete (0x0e) plen 6
>>>         LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
>>>           Status: Success (0x00)
>>>           Handle: 257
>>> < HCI Command: LE Setup Is.. (0x08|0x006e) plen 13
>>> ...
>>>> HCI Event: Command Complete (0x0e) plen 6
>>>         LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
>>>           Status: Success (0x00)
>>>           Handle: 257
>>>
>>> Signed-off-by: Luiz Augusto von Dentz<luiz.von.dentz@intel.com>
>> This patch landed recently in linux-next as commit 26afbd826ee3
>> ("Bluetooth: Add initial implementation of CIS connections").
>> Unfortunately it causes a regression on my test systems. On almost all
>> I've observed that calling a simple 'hcitool scan' command in a shell
>> fails in an unexpected way:
>>
>> $ hcitool scan
>> *** stack smashing detected ***: <unknown> terminated
>> Aborted
> Not really sure how it would be related to ISO changes though, have
> you even enabled ISO sockets UUID? Perhaps check if there is something
> on dmesg indicating what is going on since I tried here and that
> doesn't seem to cause any problem:
>
> tools/hcitool scan
> Scanning ...
>
> Perhaps it is a combination of using old userspace tools with new
> kernel, but then again these changes should affect something like
> hcitool.

Indeed my userspace is old, but still, the kernel changes shouldn't make 
it to crash. I didn't change anything in userspace since ages, so I 
assume that ISO sockets UUIDs are not enabled. Maybe it is somehow 
architecture related or specific? It looks that only ARM 32bit userspace 
apps crashes. I've just checked 64bit userspace on ARM64 (RPi4) and it 
works fine with that commit.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

