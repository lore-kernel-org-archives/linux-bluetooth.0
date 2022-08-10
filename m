Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A3FC00140
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Aug 2022 20:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbiHJUFJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Aug 2022 16:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiHJUFG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Aug 2022 16:05:06 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BEC82758
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Aug 2022 13:05:03 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id y13so29592085ejp.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Aug 2022 13:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=j2yXZtpc2gAAB+hLG3fQpBT6is9hlYEWV8RVU1jKRW0=;
        b=UjgXcDnfjjCvHDN8JSwbZIhJEgzgzY59fVdMMnh3gW3HgERZh/ZU2Qzxq94+/fP+3P
         xcH8owGdim1tQYL0kcCtZ+Zux1RLYEr8n4pLxxh0xj9wHHfol1JvJOeYE4Qybkw3io5G
         RU5DFAs6zNnplZTMA9v1vewPaMMvjAPjGbuifTh/jAD8ot7E75QrAx0B7uft0tcJUm43
         4wQBPdxkASeBmb2/ByHaakygtCJtmatPlBawAmor5AM0DX4RXRanYmnL2xlpCRVVTa/v
         X1CzMqf8i8iIS6Gjqq97SlxthssC5C14UijBWXppCZ3emOupPSEgYZpx04FeOhkhGBR0
         CJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=j2yXZtpc2gAAB+hLG3fQpBT6is9hlYEWV8RVU1jKRW0=;
        b=YHK882eDuBIvHjYcdyxp8CQ7GPsklts5HvVdwce0F+u4bkRnCyrqJCJcpedbQ76XoC
         YW8a2rL0ZVCpoSpU8MHWzBG4H2Zn6L6C6PhtxCk6Prw7HdxyV50h3ITdGNq1lT09Itij
         hMjZYLZ3VNpf7UUreBEnpDdTasQje80PzZONUDA7XcdSQFZZiIXNo9hrfiv3pkp8Wshs
         bP1fsZVXRgJcfYETRelMETODXot9yM+61K7aiCMlW/Rm0LL7Oj2AoLE190XA9++yNgdc
         eN+Fvcb2zUYoa87WCnnssHj6qfsBaJtfrIS6FS3OE1aLsDlKgQWtp4PwfewhX/z4XYc7
         181g==
X-Gm-Message-State: ACgBeo2QD8mSVm/wRdUpc+5xoxgkrC+YYYyUymoyf+FvuwFhs0IIitkM
        B8vyQW2sGEnETdckwzD7+ygqZanPO56sS1+6jvhcXEZ/oLk=
X-Google-Smtp-Source: AA6agR6bBXJVHcSmyVFY5AjoRriqxymSKOlL1sKgOyk08uP9vlU88wh6okqv4kjy6nurJmlynuc5ioM0YacziL2M6S0=
X-Received: by 2002:a17:907:a40d:b0:733:17c1:a246 with SMTP id
 sg13-20020a170907a40d00b0073317c1a246mr2369876ejc.132.1660161901871; Wed, 10
 Aug 2022 13:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220711233535.3134546-1-luiz.dentz@gmail.com>
 <CGME20220809085500eucas1p18cb2752164ca55832787e7d3843f48ab@eucas1p1.samsung.com>
 <20220711233535.3134546-2-luiz.dentz@gmail.com> <749ed578-bc9d-b699-3602-bee444fff9bb@samsung.com>
 <CABBYNZLsR0KT1-OVVjnUzLp0+U0eHGi0PNqKbfntp_5AHNDawA@mail.gmail.com> <03f9bea9-77fb-2b57-43d0-c4b819c2560a@samsung.com>
In-Reply-To: <03f9bea9-77fb-2b57-43d0-c4b819c2560a@samsung.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 10 Aug 2022 13:04:50 -0700
Message-ID: <CABBYNZ+vRqqCBVTgQJ-UZ+gd2ceFebQF94NDdYcN4Xmyk+GWTA@mail.gmail.com>
Subject: Re: [PATCH v7 2/7] Bluetooth: Add initial implementation of CIS connections
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marek,

On Wed, Aug 10, 2022 at 7:18 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi Luiz,
>
> On 09.08.2022 21:24, Luiz Augusto von Dentz wrote:
> > On Tue, Aug 9, 2022 at 1:55 AM Marek Szyprowski
> > <m.szyprowski@samsung.com>  wrote:
> >> On 12.07.2022 01:35, Luiz Augusto von Dentz wrote:
> >>> From: Luiz Augusto von Dentz<luiz.von.dentz@intel.com>
> >>>
> >>> This adds the initial implementation of CIS connections and introduces
> >>> the ISO packets/links.
> >>>
> >>> == Central: Set CIG Parameters, create a CIS and Setup Data Path ==
> >>>
> >>>> tools/isotest -s <address>
> >>> < HCI Command: LE Extended Create... (0x08|0x0043) plen 26
> >>> ...
> >>>> HCI Event: Command Status (0x0f) plen 4
> >>>         LE Extended Create Connection (0x08|0x0043) ncmd 1
> >>>           Status: Success (0x00)
> >>>> HCI Event: LE Meta Event (0x3e) plen 31
> >>>         LE Enhanced Connection Complete (0x0a)
> >>>         ...
> >>> < HCI Command: LE Create Connected... (0x08|0x0064) plen 5
> >>> ...
> >>>> HCI Event: Command Status (0x0f) plen 4
> >>>         LE Create Connected Isochronous Stream (0x08|0x0064) ncmd 1
> >>>           Status: Success (0x00)
> >>>> HCI Event: LE Meta Event (0x3e) plen 29
> >>>         LE Connected Isochronous Stream Established (0x19)
> >>>         ...
> >>> < HCI Command: LE Setup Isochronou.. (0x08|0x006e) plen 13
> >>> ...
> >>>> HCI Event: Command Complete (0x0e) plen 6
> >>>         LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
> >>>           Status: Success (0x00)
> >>>           Handle: 257
> >>> < HCI Command: LE Setup Isochronou.. (0x08|0x006e) plen 13
> >>> ...
> >>>> HCI Event: Command Complete (0x0e) plen 6
> >>>         LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
> >>>           Status: Success (0x00)
> >>>           Handle: 257
> >>>
> >>> == Peripheral: Accept CIS and Setup Data Path ==
> >>>
> >>>> tools/isotest -d
> >>>    HCI Event: LE Meta Event (0x3e) plen 7
> >>>         LE Connected Isochronous Stream Request (0x1a)
> >>> ...
> >>> < HCI Command: LE Accept Co.. (0x08|0x0066) plen 2
> >>> ...
> >>>> HCI Event: LE Meta Event (0x3e) plen 29
> >>>         LE Connected Isochronous Stream Established (0x19)
> >>> ...
> >>> < HCI Command: LE Setup Is.. (0x08|0x006e) plen 13
> >>> ...
> >>>> HCI Event: Command Complete (0x0e) plen 6
> >>>         LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
> >>>           Status: Success (0x00)
> >>>           Handle: 257
> >>> < HCI Command: LE Setup Is.. (0x08|0x006e) plen 13
> >>> ...
> >>>> HCI Event: Command Complete (0x0e) plen 6
> >>>         LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
> >>>           Status: Success (0x00)
> >>>           Handle: 257
> >>>
> >>> Signed-off-by: Luiz Augusto von Dentz<luiz.von.dentz@intel.com>
> >> This patch landed recently in linux-next as commit 26afbd826ee3
> >> ("Bluetooth: Add initial implementation of CIS connections").
> >> Unfortunately it causes a regression on my test systems. On almost all
> >> I've observed that calling a simple 'hcitool scan' command in a shell
> >> fails in an unexpected way:
> >>
> >> $ hcitool scan
> >> *** stack smashing detected ***: <unknown> terminated
> >> Aborted
> > Not really sure how it would be related to ISO changes though, have
> > you even enabled ISO sockets UUID? Perhaps check if there is something
> > on dmesg indicating what is going on since I tried here and that
> > doesn't seem to cause any problem:
> >
> > tools/hcitool scan
> > Scanning ...
> >
> > Perhaps it is a combination of using old userspace tools with new
> > kernel, but then again these changes should affect something like
> > hcitool.
>
> Indeed my userspace is old, but still, the kernel changes shouldn't make
> it to crash. I didn't change anything in userspace since ages, so I
> assume that ISO sockets UUIDs are not enabled. Maybe it is somehow
> architecture related or specific? It looks that only ARM 32bit userspace
> apps crashes. I've just checked 64bit userspace on ARM64 (RPi4) and it
> works fine with that commit.

That would be the first time it happens to me that a change in kernel
would crash the userspace in such odd fashion, btw perhaps run with
valgrind so it generates a backtrace of where it would be crashing,
well if that is reproducible with valgrind.

> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>


-- 
Luiz Augusto von Dentz
