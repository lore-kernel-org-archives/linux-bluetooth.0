Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B08C54EE9
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Sep 2022 15:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiIHP0u (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Sep 2022 11:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbiIHP0J (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Sep 2022 11:26:09 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B1AEB2F7
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Sep 2022 08:25:52 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id bx38so20294669ljb.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Sep 2022 08:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=i3jMYZ/kwa+hYGDRPuu7heWyKNq9xzIwTPZU1LZt9I4=;
        b=qa/dzdLBhwfrJwmzznLE0u3ys3y0SNeGrKMKaa72v8/74a+WqNKwkVZj3OOZsvp/Jv
         8I1v3dOdzh9Z6Psn2ED+8v/kub2w+766aEZ5/lhzQgOv6elj5pvDV+SQgHGwr14sUjiK
         Bv6N3w5xuDfVT7fYLe2DYEW1zHIdayO82YYd14jEji3Az4o8xwtwR0bB+tGsnOfDIqmB
         kCLBcB3S4rDFYY51mxgdvLn/8otoxBO22Jdqyf+JpQC67flsQNurqYkEqfRo7XxFR2IO
         VDdMFl8l+XD/S9byYtOpPFEgaKTrUAWJTnKFLOCEVDv9L1J5tx3Ip15K+abM2T1VQ7sA
         5ZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=i3jMYZ/kwa+hYGDRPuu7heWyKNq9xzIwTPZU1LZt9I4=;
        b=PAiEvSzU+c9IaM+LSWm9f4LnL2BpwNOsEpcw3umHSVQCEq0dqGhWhZFL9jIHR3NSZz
         unop1WtUtFfP5QCHyUGhTNlq4b8CaThQkiE20HoYSML4xtMvVtd9EC+NBJZ7C6rRQgQi
         XWx/Ywz6TW4f9i+WhFjsCfHtq4cVt5Fy2pfGq+tZsP57bnzLd1KpBcjuSgZcw5RRXhYw
         mdl2QwwQTjaQnox1vfb97n0uAoQi5MGn0CjXTSE/lVlxgR4HpDH9UKpiPFPRGDWxPva5
         WS2R2OnP2LoixkB566JzB6eseu9RSOf3vHhnJIlGxKazHZ2dnCmoXt4H4Rpl27oskEtM
         lfbQ==
X-Gm-Message-State: ACgBeo2Hx1+bbKt8T4Fcsrxu+pHBHBAkpIlSaxOVuV27RMHHYv02SQsy
        7A+SlJHPYF/qE8IrZ5U70OpunTH5gyLnicfN9BaKHoDc7ChA9Q==
X-Google-Smtp-Source: AA6agR4n4G25JPrLGnWEcSR2rc7+N59GX4F4AkAhZ5PpMN3oVEIayeIUWwLega6HKivy5R2V27oKyPhK5W+jCiHHRe8=
X-Received: by 2002:a2e:9c84:0:b0:268:8e0f:78cd with SMTP id
 x4-20020a2e9c84000000b002688e0f78cdmr2694785lji.432.1662650750432; Thu, 08
 Sep 2022 08:25:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220711233535.3134546-1-luiz.dentz@gmail.com>
 <CGME20220809085500eucas1p18cb2752164ca55832787e7d3843f48ab@eucas1p1.samsung.com>
 <20220711233535.3134546-2-luiz.dentz@gmail.com> <749ed578-bc9d-b699-3602-bee444fff9bb@samsung.com>
 <CABBYNZLsR0KT1-OVVjnUzLp0+U0eHGi0PNqKbfntp_5AHNDawA@mail.gmail.com>
 <03f9bea9-77fb-2b57-43d0-c4b819c2560a@samsung.com> <CABBYNZ+vRqqCBVTgQJ-UZ+gd2ceFebQF94NDdYcN4Xmyk+GWTA@mail.gmail.com>
 <92a47171-f69b-5bf9-6e8c-70fc3e9e6eee@samsung.com> <41717010-b7a5-40e4-39d7-722fb6d18eae@samsung.com>
 <4263c3ba-036b-ae67-ab29-166325ce6aba@samsung.com>
In-Reply-To: <4263c3ba-036b-ae67-ab29-166325ce6aba@samsung.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 8 Sep 2022 08:25:38 -0700
Message-ID: <CABBYNZKjirNBon9r=xA5g=vp=R_RPgwMWDODw2cmqvco2X9x3w@mail.gmail.com>
Subject: Re: [PATCH v7 2/7] Bluetooth: Add initial implementation of CIS connections
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marek,

On Thu, Sep 8, 2022 at 3:26 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi All,
>
> On 16.08.2022 17:24, Marek Szyprowski wrote:
> > On 12.08.2022 14:33, Marek Szyprowski wrote:
> >> On 10.08.2022 22:04, Luiz Augusto von Dentz wrote:
> >>> On Wed, Aug 10, 2022 at 7:18 AM Marek Szyprowski
> >>> <m.szyprowski@samsung.com> wrote:
> >>>> On 09.08.2022 21:24, Luiz Augusto von Dentz wrote:
> >>>>> On Tue, Aug 9, 2022 at 1:55 AM Marek Szyprowski
> >>>>> <m.szyprowski@samsung.com>  wrote:
> >>>>>> On 12.07.2022 01:35, Luiz Augusto von Dentz wrote:
> >>>>>>> From: Luiz Augusto von Dentz<luiz.von.dentz@intel.com>
> >>>>>>>
> >>>>>>> This adds the initial implementation of CIS connections and
> >>>>>>> introduces
> >>>>>>> the ISO packets/links.
> >>>>>>>
> >>>>>>> == Central: Set CIG Parameters, create a CIS and Setup Data Path ==
> >>>>>>>
> >>>>>>>> tools/isotest -s <address>
> >>>>>>> < HCI Command: LE Extended Create... (0x08|0x0043) plen 26
> >>>>>>> ...
> >>>>>>>> HCI Event: Command Status (0x0f) plen 4
> >>>>>>>          LE Extended Create Connection (0x08|0x0043) ncmd 1
> >>>>>>>            Status: Success (0x00)
> >>>>>>>> HCI Event: LE Meta Event (0x3e) plen 31
> >>>>>>>          LE Enhanced Connection Complete (0x0a)
> >>>>>>>          ...
> >>>>>>> < HCI Command: LE Create Connected... (0x08|0x0064) plen 5
> >>>>>>> ...
> >>>>>>>> HCI Event: Command Status (0x0f) plen 4
> >>>>>>>          LE Create Connected Isochronous Stream (0x08|0x0064)
> >>>>>>> ncmd 1
> >>>>>>>            Status: Success (0x00)
> >>>>>>>> HCI Event: LE Meta Event (0x3e) plen 29
> >>>>>>>          LE Connected Isochronous Stream Established (0x19)
> >>>>>>>          ...
> >>>>>>> < HCI Command: LE Setup Isochronou.. (0x08|0x006e) plen 13
> >>>>>>> ...
> >>>>>>>> HCI Event: Command Complete (0x0e) plen 6
> >>>>>>>          LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
> >>>>>>>            Status: Success (0x00)
> >>>>>>>            Handle: 257
> >>>>>>> < HCI Command: LE Setup Isochronou.. (0x08|0x006e) plen 13
> >>>>>>> ...
> >>>>>>>> HCI Event: Command Complete (0x0e) plen 6
> >>>>>>>          LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
> >>>>>>>            Status: Success (0x00)
> >>>>>>>            Handle: 257
> >>>>>>>
> >>>>>>> == Peripheral: Accept CIS and Setup Data Path ==
> >>>>>>>
> >>>>>>>> tools/isotest -d
> >>>>>>>     HCI Event: LE Meta Event (0x3e) plen 7
> >>>>>>>          LE Connected Isochronous Stream Request (0x1a)
> >>>>>>> ...
> >>>>>>> < HCI Command: LE Accept Co.. (0x08|0x0066) plen 2
> >>>>>>> ...
> >>>>>>>> HCI Event: LE Meta Event (0x3e) plen 29
> >>>>>>>          LE Connected Isochronous Stream Established (0x19)
> >>>>>>> ...
> >>>>>>> < HCI Command: LE Setup Is.. (0x08|0x006e) plen 13
> >>>>>>> ...
> >>>>>>>> HCI Event: Command Complete (0x0e) plen 6
> >>>>>>>          LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
> >>>>>>>            Status: Success (0x00)
> >>>>>>>            Handle: 257
> >>>>>>> < HCI Command: LE Setup Is.. (0x08|0x006e) plen 13
> >>>>>>> ...
> >>>>>>>> HCI Event: Command Complete (0x0e) plen 6
> >>>>>>>          LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
> >>>>>>>            Status: Success (0x00)
> >>>>>>>            Handle: 257
> >>>>>>>
> >>>>>>> Signed-off-by: Luiz Augusto von Dentz<luiz.von.dentz@intel.com>
> >>>>>> This patch landed recently in linux-next as commit 26afbd826ee3
> >>>>>> ("Bluetooth: Add initial implementation of CIS connections").
> >>>>>> Unfortunately it causes a regression on my test systems. On
> >>>>>> almost all
> >>>>>> I've observed that calling a simple 'hcitool scan' command in a
> >>>>>> shell
> >>>>>> fails in an unexpected way:
> >>>>>>
> >>>>>> $ hcitool scan
> >>>>>> *** stack smashing detected ***: <unknown> terminated
> >>>>>> Aborted
> >>>>> Not really sure how it would be related to ISO changes though, have
> >>>>> you even enabled ISO sockets UUID? Perhaps check if there is
> >>>>> something
> >>>>> on dmesg indicating what is going on since I tried here and that
> >>>>> doesn't seem to cause any problem:
> >>>>>
> >>>>> tools/hcitool scan
> >>>>> Scanning ...
> >>>>>
> >>>>> Perhaps it is a combination of using old userspace tools with new
> >>>>> kernel, but then again these changes should affect something like
> >>>>> hcitool.
> >>>> Indeed my userspace is old, but still, the kernel changes shouldn't
> >>>> make
> >>>> it to crash. I didn't change anything in userspace since ages, so I
> >>>> assume that ISO sockets UUIDs are not enabled. Maybe it is somehow
> >>>> architecture related or specific? It looks that only ARM 32bit
> >>>> userspace
> >>>> apps crashes. I've just checked 64bit userspace on ARM64 (RPi4) and it
> >>>> works fine with that commit.
> >>> That would be the first time it happens to me that a change in kernel
> >>> would crash the userspace in such odd fashion, btw perhaps run with
> >>> valgrind so it generates a backtrace of where it would be crashing,
> >>> well if that is reproducible with valgrind.
> >>
> >> Well, its not that easy. I've checked and Debian doesn't provide a
> >> valgrind package for the buster/armel arch, which I use on my test
> >> systems (for some historical reasons). Building everything from the
> >> source will take some time, though. I will try to do this after
> >> getting back from my holidays after 24th Aug.
> >
> > Unfortunately my holidays trip didn't start, so I had a chance to play
> > a bit with this issue.
> >
> > Valgrind doesn't really provide any useful information here:
> >
> > $ valgrind hcitool scan
> > ==1391== Memcheck, a memory error detector
> > ==1391== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
> > ==1391== Using Valgrind-3.14.0 and LibVEX; rerun with -h for copyright
> > info
> > ==1391== Command: hcitool scan
> > ==1391==
> > *** stack smashing detected ***: <unknown> terminated
> > ==1391==
> > ==1391== Process terminating with default action of signal 6 (SIGABRT)
> > ==1391==    at 0x48EB6AC: raise (raise.c:51)
> > ==1391==    by 0x48D6283: abort (abort.c:79)
> > ==1391==    by 0x4928E3B: __libc_message (libc_fatal.c:181)
> > ==1391==    by 0x49ACFE3: __fortify_fail_abort (fortify_fail.c:33)
> > ==1391==    by 0x49ACFA7: __stack_chk_fail (stack_chk_fail.c:29)
> > ==1391==    by 0x117DFB: ??? (in /usr/bin/hcitool)
> > ==1391==
> > ==1391== HEAP SUMMARY:
> > ==1391==     in use at exit: 132 bytes in 1 blocks
> > ==1391==   total heap usage: 1 allocs, 0 frees, 132 bytes allocated
> > ==1391==
> > ==1391== LEAK SUMMARY:
> > ==1391==    definitely lost: 0 bytes in 0 blocks
> > ==1391==    indirectly lost: 0 bytes in 0 blocks
> > ==1391==      possibly lost: 0 bytes in 0 blocks
> > ==1391==    still reachable: 132 bytes in 1 blocks
> > ==1391==         suppressed: 0 bytes in 0 blocks
> > ==1391== Rerun with --leak-check=full to see details of leaked memory
> > ==1391==
> > ==1391== For counts of detected and suppressed errors, rerun with: -v
> > ==1391== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)
> > Aborted
> >
> >
> > I've also checked the ARM 32bit 'armhf' userspace abi on vanilla
> > Raspberry Pi OS Lite 32-bit image (from April 4th 2022). The issue is
> > same:
> >
> > $ hcitool scan
> > *** stack smashing detected ***: terminated
> > Aborted
> >
> > It is enough to boot that image with init=/bin/bash and run 'hcitool
> > scan' to reproduce the issue...
> >
>
> I've had some time to analyze this issue further and I've finally found
> which change is responsible for this issue. It is caused by the
> following chunk:
>
> diff --git a/include/net/bluetooth/hci_sock.h
> b/include/net/bluetooth/hci_sock.h
> index 9949870f7d78..0520e21ab698 100644
> --- a/include/net/bluetooth/hci_sock.h
> +++ b/include/net/bluetooth/hci_sock.h
> @@ -124,6 +124,8 @@ struct hci_dev_info {
>          __u16 acl_pkts;
>          __u16 sco_mtu;
>          __u16 sco_pkts;
> +       __u16 iso_mtu;
> +       __u16 iso_pkts;
>
>          struct hci_dev_stats stat;
>   };
>
> It looks that this is an ABI break for some old userspace tools. I've
> confirmed this by applying only the above chunk on top of v5.19-rc1 and
> running my tests. 'hcitool scan' crashes in such case.

Oh that indeed is not intended, this is the old IOCTL interface for
HCIGETDEVINFO opcode which apparently breaks due to the change in size
of hci_dev_info.

> I've also removed that chunk from the v6.0-rc1 release and surprisingly
> I found that it is not used by the bluetooth code! Kernel compiled
> successfully. Is that change intentional? Or is it just a leftover from
> the development process that accidentally made its way into final patch?

We should definitely remove these changes, I will send a patch shortly.

>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>


-- 
Luiz Augusto von Dentz
