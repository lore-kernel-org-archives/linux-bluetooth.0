Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D83C05027
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Feb 2023 18:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjBQSIy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Feb 2023 13:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjBQSIx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Feb 2023 13:08:53 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9524A5CF16
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Feb 2023 10:08:51 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id bx7so807331iob.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Feb 2023 10:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lRlyYR2LyekMYoUtM5RmaSIa4c1FQUAkOXOiiAF25lk=;
        b=A6JzsV/lIXliaryDrfeaA/yW/bcaRyXvKzFlF/PyrbkaRfwNgDSvBTCdqYiiUFjUhA
         G2JWuevKPEhoEA8aiQzncfjfUZzApIL1U0M/rzTXJQQXnnHnc9IrvfUV4GJ5lNQNqK7K
         hx+yzsd1GWaf5L+QWA+dW1mq1Ehqd3JkaDYz142fsSIEx3zQryI8TBw1uvbBKuZXkgqN
         /V9Gdf7sBVvUjhxDfNRDVI0EluA/v4eWy1cJ9+OHJaH9p8YzWn10dP/RGRmGU8lvfDIQ
         ut1s32nwwjrWttjSmCAZ5cmZTQ4siLLFvSvcoHaVZp45AOSbDQlxBi3jm872xb9MtzV/
         Nymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lRlyYR2LyekMYoUtM5RmaSIa4c1FQUAkOXOiiAF25lk=;
        b=m2smhfo7STuX2UuHApyNVvvfvVopN13s0so4xtKP2BogiSTlm89WD1MKiX/tPiIL+5
         +2JMiwhgVcV/Fl3Ats+2V6z5kW4O6NTSSy0pW1nneaANx0nq3+QTa+H/ea8M2sUG4dHI
         UmO2h9wiFn4KxIpp1x7POUkM8uL9ceLq0a++W3Ynh1nLfS53MCUNL7tn0jp+VWwzTQxI
         6oPwesxKvTBVgfGXVQvw8sAGPP1xyhwr6MTkxpwH6hXiaIHpZYrfuV2HWWTu98eHS7mc
         +8Rd55IKNlyBKxMDraWiNL4ejZyaAmkfMAWSsxd0sSBOIwHyNt6bl9Q5S1MRDmNqufQV
         Xweg==
X-Gm-Message-State: AO0yUKWxaq2uisL3d7hICkYNG5ApAlysLBPPnfAnNmKuMT8Z6kzfb/O/
        LzsguR/6H0kyw/gsIqfjc1aC4toE1bRLhAoIPOWZab/q
X-Google-Smtp-Source: AK7set8WU1wGo1TvH202c5TQV4mZvYvHCj2chrtJ3vLReKYwkKLVrkarTfQfG1C20HL+1Z0cH0re0rojGctVJ7S8kcg=
X-Received: by 2002:a5d:970d:0:b0:734:11db:e655 with SMTP id
 h13-20020a5d970d000000b0073411dbe655mr3433202iol.45.1676657330910; Fri, 17
 Feb 2023 10:08:50 -0800 (PST)
MIME-Version: 1.0
References: <CADBWZmXM7NO_mbw-ka9WYg2fMVhxD2ByFR1PJBDVc2e1yf_8Tw@mail.gmail.com>
 <CABBYNZK_O5bnmE4ONOQiB-RgUjWwqvQrD8euNqpKAOcUSzER5A@mail.gmail.com>
In-Reply-To: <CABBYNZK_O5bnmE4ONOQiB-RgUjWwqvQrD8euNqpKAOcUSzER5A@mail.gmail.com>
From:   Neacsu Cristian <neacsu.cristianstefan@gmail.com>
Date:   Fri, 17 Feb 2023 20:08:38 +0200
Message-ID: <CADBWZmUBKdVf9M3G5s6KW-4spXidQxiE0KRwytsdS+xrvk0t-Q@mail.gmail.com>
Subject: Re: Need a BLE socket to connect to a nRF52832 Nordic (Low energy BT 5)
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

Thank you for your reply. Yes gatt is the way to go. I tried in
bluetoothctl using gatt.list_attributes gatt.select_attribute,
selecting the tx uuid and the send some bytes. Exactly what I need.
But that is directly in bluetootctl. I don't want to do that by doing
a wrapper around it. How can I implement it directly in C?
Do you have a scenario for a gatt connection in C?

Cristian-Stefan


Cristian-Stefan




On Thu, Feb 16, 2023 at 11:04 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Neacsu,
>
> On Thu, Feb 16, 2023 at 11:20 AM Neacsu Cristian
> <neacsu.cristianstefan@gmail.com> wrote:
> >
> > Hello,
> >
> >     Long story short, I am trying to connect with a linux PC using a
> > Bluetooth 5 universal adapter (Asus USB-BT500) to a Bluetooth 5 module
> > PCB, called BT832X which is using a Bluetooth Low Energy Technology
> > that is using a chip Nordic nRF52832 (see url for the module
> > documentation https://static1.squarespace.com/static/561459a2e4b0b39f5cefa12e/t/63de8b578e4d7813cde64445/1675529048975/BT832X-p+Product+Specifications.pdf).
> >     Therefore I tried everything, reading docs, sniffing through the
> > bluetoothctl sources, gatttools sources, and I am not able to open and
> > connect on a socket on my PC to connect properly.
> > Usually for legacy Bluetooth stuff, I create a RF_COMM socket, and the
> > magic is done by itself. No biggie.
> >     Here I tried an L2CAP approach (not sure if I had a proper
> > configuration), I tried to use the gatttool as it is, without success.
> > I feel a bit lost.
> >     The remote device is working properly, because using the Nordic
> > demo Android app (downloadable from Google Play Store), I am able to
> > communicate with the PCB and exchange packages.
> >     Do you have a functional, very simple sample, or suggestion,
> > preferably in C, to help me to open a socket and send a data package?
> > I mean, you have a BLE module, you want to connect with it using
> > BlueZ, how do you open a socket, how do you configure it, connect to
> > it and send a byte through it?
> >     Let's keep in mind that I am already able to scan for the
> > destination address (I created a custom agent in bluetoothctl that is
> > fishing data using the "scan on" command), so the address that I'm
> > connecting to is already known.
> >
> > Thank you and I'm really really looking forward to your reply.
>
> I guess for LE what you really want is to use GATT procedures, which
> are available via bluetoothctl> menu gatt
>
> > Cristian-Stefan
>
>
>
> --
> Luiz Augusto von Dentz
