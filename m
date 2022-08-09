Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C27C25B06
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Aug 2022 19:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242678AbiHITZK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Aug 2022 15:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242078AbiHITZI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Aug 2022 15:25:08 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA5E196
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Aug 2022 12:25:07 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id dc19so23867802ejb.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Aug 2022 12:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vvsGIfc8PtY6uK1UGY855POToe7eD8nSELLE6H6DLx8=;
        b=WMG6cNfqR3Y5uJjM81plxDQX8USPXb0o2ZItiDDhUJcufg1bSrsAY9lmyOtdSdbbnK
         uaZKTlEdN9D8oz+3rThorGsxb5T/MUEIg+c/zN6Qv29zrexht3ve+rNwQSYbDcuZtTPW
         0cQzijA4WX3fpJr/4NhCSwJEx7TR40YSdhYZvV22IhXkrDC9KYrN9bwB0xoWl9NfvGlT
         om6zUiopG94rq0wv8bTcmKRuDN+m0mabyna6L1gbOrUGTC1uDT/MjIiA4D7txkthMc7k
         UVkzCiy/O1Yi8xIiXIK1B7T8ozo4v5LS/SHeZ+J2sKD+Z6+QCm1n3Ui+RruPWwkgs0mb
         KxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vvsGIfc8PtY6uK1UGY855POToe7eD8nSELLE6H6DLx8=;
        b=R8vbtHEyrPQ6kf/0FOAcgiQI1suRRQKkGYkRZWQUF9KcbRWURjpik7Mdq7L+MghtBG
         WfEl0Gtc1SVc1Avq1RTzX7JH+PLWuAJT3yxQ+q5NDYRmfvjMHBmv93lK5Kr7mbQm6Oxl
         Ls2YNqYiMLpqMHeDeJrWL6qCWuBqUsX1ZaPJwvJS0f2n6pnARxX4lWzFFa233CnHN1HB
         dSE0uAnhvKaWw91TaoPinbOPgxeeIWIOUpu2CldBPmcbK3a7UKCCbgaypNJMv7R5R5oP
         7wJb+DdL8THUtlmM3IPqKtSbhUSrnyPgFUWnYYkY7gxDMlSY6GUO+LAtOcv2AXjDe1zW
         0u3g==
X-Gm-Message-State: ACgBeo1RXhos+YbZp3CzMOkO3gQlmoYMxU9gQYCCJCnGbU5ep3yP0L7u
        mcLeDVEteSqxOms47iyPcF8WTwdGCwnMwCsuFWC3jjE3iOol7Q==
X-Google-Smtp-Source: AA6agR7xIio5M8Mu+RIIyCBXb96JK2Yr3F78LW/fD1eIJEEs1CEsX7M0py8PPNd89AyKDSd6hlKLVNujvaCeLgB67BA=
X-Received: by 2002:a17:907:a408:b0:730:f106:e692 with SMTP id
 sg8-20020a170907a40800b00730f106e692mr14839145ejc.132.1660073106245; Tue, 09
 Aug 2022 12:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220711233535.3134546-1-luiz.dentz@gmail.com>
 <CGME20220809085500eucas1p18cb2752164ca55832787e7d3843f48ab@eucas1p1.samsung.com>
 <20220711233535.3134546-2-luiz.dentz@gmail.com> <749ed578-bc9d-b699-3602-bee444fff9bb@samsung.com>
In-Reply-To: <749ed578-bc9d-b699-3602-bee444fff9bb@samsung.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 9 Aug 2022 12:24:54 -0700
Message-ID: <CABBYNZLsR0KT1-OVVjnUzLp0+U0eHGi0PNqKbfntp_5AHNDawA@mail.gmail.com>
Subject: Re: [PATCH v7 2/7] Bluetooth: Add initial implementation of CIS connections
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marek,

On Tue, Aug 9, 2022 at 1:55 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi Luiz,
>
> On 12.07.2022 01:35, Luiz Augusto von Dentz wrote:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This adds the initial implementation of CIS connections and introduces
> > the ISO packets/links.
> >
> > == Central: Set CIG Parameters, create a CIS and Setup Data Path ==
> >
> >> tools/isotest -s <address>
> > < HCI Command: LE Extended Create... (0x08|0x0043) plen 26
> > ...
> >> HCI Event: Command Status (0x0f) plen 4
> >        LE Extended Create Connection (0x08|0x0043) ncmd 1
> >          Status: Success (0x00)
> >> HCI Event: LE Meta Event (0x3e) plen 31
> >        LE Enhanced Connection Complete (0x0a)
> >        ...
> > < HCI Command: LE Create Connected... (0x08|0x0064) plen 5
> > ...
> >> HCI Event: Command Status (0x0f) plen 4
> >        LE Create Connected Isochronous Stream (0x08|0x0064) ncmd 1
> >          Status: Success (0x00)
> >> HCI Event: LE Meta Event (0x3e) plen 29
> >        LE Connected Isochronous Stream Established (0x19)
> >        ...
> > < HCI Command: LE Setup Isochronou.. (0x08|0x006e) plen 13
> > ...
> >> HCI Event: Command Complete (0x0e) plen 6
> >        LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
> >          Status: Success (0x00)
> >          Handle: 257
> > < HCI Command: LE Setup Isochronou.. (0x08|0x006e) plen 13
> > ...
> >> HCI Event: Command Complete (0x0e) plen 6
> >        LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
> >          Status: Success (0x00)
> >          Handle: 257
> >
> > == Peripheral: Accept CIS and Setup Data Path ==
> >
> >> tools/isotest -d
> >   HCI Event: LE Meta Event (0x3e) plen 7
> >        LE Connected Isochronous Stream Request (0x1a)
> > ...
> > < HCI Command: LE Accept Co.. (0x08|0x0066) plen 2
> > ...
> >> HCI Event: LE Meta Event (0x3e) plen 29
> >        LE Connected Isochronous Stream Established (0x19)
> > ...
> > < HCI Command: LE Setup Is.. (0x08|0x006e) plen 13
> > ...
> >> HCI Event: Command Complete (0x0e) plen 6
> >        LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
> >          Status: Success (0x00)
> >          Handle: 257
> > < HCI Command: LE Setup Is.. (0x08|0x006e) plen 13
> > ...
> >> HCI Event: Command Complete (0x0e) plen 6
> >        LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
> >          Status: Success (0x00)
> >          Handle: 257
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This patch landed recently in linux-next as commit 26afbd826ee3
> ("Bluetooth: Add initial implementation of CIS connections").
> Unfortunately it causes a regression on my test systems. On almost all
> I've observed that calling a simple 'hcitool scan' command in a shell
> fails in an unexpected way:
>
> $ hcitool scan
> *** stack smashing detected ***: <unknown> terminated
> Aborted

Not really sure how it would be related to ISO changes though, have
you even enabled ISO sockets UUID? Perhaps check if there is something
on dmesg indicating what is going on since I tried here and that
doesn't seem to cause any problem:

tools/hcitool scan
Scanning ...

Perhaps it is a combination of using old userspace tools with new
kernel, but then again these changes should affect something like
hcitool.

> $
>
> The above 'stack smashing' issue I've observed on Raspberry Pi4 with ARM
> 32bit kernel.
>
> Bisecting this lead me to this commit. Reverting it on top of
> next-20220808, together with the following commits due to dependencies,
> fixes the issue:
>
> 26afbd826ee326e63a334c37fd45e82e50a615ec "Bluetooth: Add initial
> implementation of CIS connections"
> e78165d2ce798451d08ac09d704cd72caa962b81 "Bluetooth: hci_conn: Fix
> updating ISO QoS PHY"
> ccf74f2390d60a2f9a75ef496d2564abb478f46a "Bluetooth: Add BTPROTO_ISO
> socket type"
> f764a6c2c1e446f560faa3232271a0637369170b "Bluetooth: ISO: Add broadcast
> support"
> c85008a4e748051cddc6be6333f55df476f35362 "Bluetooth: ISO: unlock on
> error path in iso_sock_setsockopt()"
> 82e07ef4b474f466b4b2955bad76c52d6df98a30 "Bluetooth: ISO: Fix info leak
> in iso_sock_getsockopt()"
> c5d36b8a7dbdcf41da7316252b717c60c409992b "Bluetooth: ISO: Fix memory
> corruption"
> 8a3fd9bb4fac67ad5d44d6540c7ac20004767076 "Bluetooth: ISO: Fix
> iso_sock_getsockopt for BT_DEFER_SETUP"
> aac59090a068139550f9b73d46d1116e31cdd2d1 "Bluetooth: ISO: Fix not using
> the correct QoS"
> eca0ae4aea66914515e5e3098ea051b518ee5316 "Bluetooth: Add initial
> implementation of BIS connections"
>
> Let me know if I can help fixing this issue.
>
> > ---
> >   include/net/bluetooth/bluetooth.h |  33 ++-
> >   include/net/bluetooth/hci.h       |  28 +-
> >   include/net/bluetooth/hci_core.h  | 107 +++++++-
> >   include/net/bluetooth/hci_sock.h  |   2 +
> >   include/net/bluetooth/hci_sync.h  |   3 +
> >   net/bluetooth/Kconfig             |   1 +
> >   net/bluetooth/hci_conn.c          | 440 ++++++++++++++++++++++++++++++
> >   net/bluetooth/hci_core.c          | 230 ++++++++++++----
> >   net/bluetooth/hci_event.c         | 307 ++++++++++++++++++++-
> >   net/bluetooth/hci_sync.c          |  49 +++-
> >   10 files changed, 1145 insertions(+), 55 deletions(-)
> >
> > ...
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>


-- 
Luiz Augusto von Dentz
