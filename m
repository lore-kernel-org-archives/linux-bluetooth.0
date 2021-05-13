Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7271CC433ED
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 May 2021 20:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F0C061421
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 May 2021 20:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbhEMUaz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 May 2021 16:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbhEMUar (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 May 2021 16:30:47 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10464C061763
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 May 2021 13:29:28 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id e128so637878ybf.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 May 2021 13:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zN/lAFX1fKcTkEtnGlN/FwvIbQ//6AFIM7RPilCCdXk=;
        b=sFkrwCOURCuAfEWOGxZq3EGizPEaB9fvaIy9AJ/v240GzvfNlInrfGS5t6r/RrEbf6
         MVGzLW0hZYatGZLaP2sGJgy7/KuHz84ZuTLu1rj4sIYq5dMVBAoF78UCgH1DLLTK/ByX
         B/5x5nE5BO43aL/L1rVxjYolvX69urKYUL4kJrdilWdGi6kQ7MANbzmV/4MQhoxKhzCc
         FTNq8Xeg5zIkpg/9VbkC/2MXJ/JUQaXjw2Wmz56UCqDoDVc1VqppjttACteUr6JuUACm
         fdza/v7f/s+7rTVYSa3A7ImlXLa0Dj1kh8+622FUailOJ7sVvo4/sGTE1r9/Wc2g3n/H
         pLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zN/lAFX1fKcTkEtnGlN/FwvIbQ//6AFIM7RPilCCdXk=;
        b=Cc445WFpM8SMCY6kDFACNCOzFfE5pbaECkKQfKLKWHIgAf8xl59oTBagXJ93kKPfte
         uGGxut8A8hcUDwU/rdKRccr53Tq26GUAfQVxV0H6516Db8o21HBoFttXbW+PWpiypSvM
         LppJX+ARi68AlomuCR5jc1AInTJjFrbbJCBAOSnI7yuu5nwrEhyHvo+3ROxPxhohOQvK
         fshfJlRhvSH4yxi76P3uXN6NpML6LcwUAbMrR/eUtWKrpB29QVnh74F4QUhVS792HnsQ
         a06MUC+damXolE3LKLuX7qngjSir3pd+M61stgzV/TwiiThUvs/275mZbcdx5IdTMxor
         nVXg==
X-Gm-Message-State: AOAM533h0jt3CsRI9ga4jX/9g+Ne6mtkthrB1YaqHqo0Oqa0IfLPqHQw
        1Ek+QK33NdlZVrcXSjCEVXthhWAd50sCEnLRcBcVYmGs
X-Google-Smtp-Source: ABdhPJyKfRQ8uCNwDbKmF7gGIwfl5xbi54vW7dn4cUUCLz5DG9Zvp4CaEaDXH0xTmGUJ5fyEVxMy7/rc/j5j1xyv9I0=
X-Received: by 2002:a25:ad8b:: with SMTP id z11mr30899557ybi.91.1620937767218;
 Thu, 13 May 2021 13:29:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210430230501.603111-1-luiz.dentz@gmail.com> <20210511042654.8549-1-youling257@gmail.com>
 <CABBYNZLEiBzgM=Ur6YuFCNWu0w3E5nYN4ZBmQm95V=s9W9D8Aw@mail.gmail.com> <E8C3B5BB-502E-410D-84F9-74014A24D38A@holtmann.org>
In-Reply-To: <E8C3B5BB-502E-410D-84F9-74014A24D38A@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 13 May 2021 13:29:14 -0700
Message-ID: <CABBYNZL8SPZ2OoXLLBkN+4kVoOtSv1swZ61Yby7apoVpuxqkGw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Fix failing to init controllers with
 operation firmware
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     youling257 <youling257@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Thu, May 13, 2021 at 8:16 AM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Luiz,
>
> >> I test this patch no help. rmmod btusb, modprobe btusb.
> >>
> >>
> >> [    7.661739] Bluetooth: Core ver 2.22
> >> [    7.661762] NET: Registered protocol family 31
> >> [    7.661763] Bluetooth: HCI device and connection manager initialize=
d
> >> [    7.661767] Bluetooth: HCI socket layer initialized
> >> [    7.661768] Bluetooth: L2CAP socket layer initialized
> >> [    7.661772] Bluetooth: SCO socket layer initialized
> >> [    7.686106] usbcore: registered new interface driver btusb
> >> [    7.689317] iwlwifi 0000:07:00.0: Detected Intel(R) Wi-Fi 6 AX200 1=
60MHz, REV=3D0x340
> >> [    7.689789] Bluetooth: hci0: Firmware revision 0.0 build 118 week 1=
5 2021
> >> [    7.694911] bluetooth hci0: Direct firmware load for intel/ibt-20-0=
-0.sfi failed with error -2
> >>
> >> [  230.746397] usbcore: registered new interface driver btusb
> >> [  230.750827] Bluetooth: hci0: Firmware revision 0.0 build 118 week 1=
5 2021
> >> [  230.756450] bluetooth hci0: Direct firmware load for intel/ibt-20-0=
-0.sfi failed with error -2
> >
> > The error shall be ignored in this case since it comes from
> > request_firmware we can't prevent it, if you don't see another error
> > after that means it can be ignored, that said perhaps we detect it
> > sooner by either attempting to stat the file or perhaps check if
> > revision comes back as all 0.
>
> any reason you don=E2=80=99t use firmware_request_nowarn()?

Yep, totally missed that one exists, I will send a patch making use of it.

--=20
Luiz Augusto von Dentz
