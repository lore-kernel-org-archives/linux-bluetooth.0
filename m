Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFCAC6FD19
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Mar 2023 00:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjCNASh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Mar 2023 20:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjCNASg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Mar 2023 20:18:36 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAA964B00
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 17:18:34 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id g18so14415430ljl.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 17:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678753113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sj1ijZsR/Ykp50q0Ewqp6ELcgHUPxs6tBIWIzF0TXvA=;
        b=j6L0m7OUKH1OvLLzjO8HwNR8tbfrYybx4eWt8p6mqzkJkqMUwgUXA0AD+Csa1aWbVc
         JV67lIXIofaNJvl40xZvN2su+3KzagBy/9zgj9ki+WiEhlqjy1nImMOQCpENM2jMk5Ym
         i6xWvy3+X/b9qOXrF5JOAKfycDmSYF8wW8+ubPfXxVr0mSFEVJH1DdJPovdi/1QL681L
         3xunqzRBPt6FzAY8oldtrru1Nk8FCgccrXnOt5pqpAuOunBHeL80lCL1tlPWujms67TT
         MOMdOCmZo1qcZppaU7ehMV+fNPYyTi4I5AY1k9re0b5sS2lLGjS0TfLjYTMeXhAzM4LU
         +Hgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678753113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sj1ijZsR/Ykp50q0Ewqp6ELcgHUPxs6tBIWIzF0TXvA=;
        b=mfHvQzkvawWV3I/Zumy3aI/I7gjkXmytYuNjRkUAyF2j6Q2QH7SahxNqvaNYqqYPu0
         cPDlS0ByrL81xecXzYy+Zz3vCO0VvuY+dr/JhYoCIVG8td8UbSnBXccXG4OiORdcCoH3
         XyoL9f2rAW1IAGvCV+qwNG+8OhRUdRZE6zAPqH/78NDRzJAgPKIaf3Vo8J7lq8YnmSd0
         W3zlz8JR3nHs89WPGF/QtminMcmHxYofFlsiVyNOAy+hW/EHmkUG6Tg82yQtpUYmQku1
         eYKYOj6JTJiiWoZqytBLcZ+JHaj5eRDxBF5Vj5Mjxf3xQSF61Vkbdiyym/ZvVHJPVIPm
         GGKA==
X-Gm-Message-State: AO0yUKV41tA9kgnijPNnr73bjLVenmz4UIzMtB1Vz+wR6100en7QFnig
        IRX6lHH7sUjvZ+UdjdRlreP2k2boYVlFIVk/tLgGj4WhyOs=
X-Google-Smtp-Source: AK7set8Glp6bE4Rt5HREmKkRwjjpphRXo9MKOZszjQpyftgZfCCWa/9oPoM+fh1kWWx4I2sC08ygxgsYl8qC3+pygjc=
X-Received: by 2002:a05:651c:1725:b0:295:a96a:2ea1 with SMTP id
 be37-20020a05651c172500b00295a96a2ea1mr11027026ljb.0.1678753112529; Mon, 13
 Mar 2023 17:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230307222422.2608483-1-luiz.dentz@gmail.com>
 <167849522070.21816.4954897604805294201.git-patchwork-notify@kernel.org>
 <CABBYNZJ8GbCic4+dAz-04vji3xgtqYnXRUjTuWHSk3oGjXxA=Q@mail.gmail.com> <f86f2896be923a9caa5625457fea46d1c32b3114.camel@iki.fi>
In-Reply-To: <f86f2896be923a9caa5625457fea46d1c32b3114.camel@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 13 Mar 2023 17:18:21 -0700
Message-ID: <CABBYNZKv68ybD3YVKFtHUARh6H+TVY=2_P9TdNWEbZ4FbTX31w@mail.gmail.com>
Subject: Re: [RFC v2 01/12] shared/crypto: Add bt_crypto_sirk
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org,
        =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Mon, Mar 13, 2023 at 4:30=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> su, 2023-03-12 kello 22:36 -0700, Luiz Augusto von Dentz kirjoitti:
> > Hi Pauli, Frederic,
> >
> > On Fri, Mar 10, 2023 at 4:40=E2=80=AFPM <patchwork-bot+bluetooth@kernel=
.org> wrote:
> > >
> > > Hello:
> > >
> > > This series was applied to bluetooth/bluez.git (master)
> > > by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
> > >
> > > On Tue,  7 Mar 2023 14:24:11 -0800 you wrote:
> > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > >
> > > > This adds bt_crypto_sirk which attempts to generate a unique SIRK u=
sing
> > > > the following steps:
> > > >
> > > >  - Generate a hash (k) using the str as input
> > > >  - Generate a hash (sirk) using vendor, product, version and source=
 as input
> > > >  - Encrypt sirk using k as LTK with sef function.
> > > >
> > > > [...]
> > >
> > > Here is the summary with links:
> > >   - [RFC,v2,01/12] shared/crypto: Add bt_crypto_sirk
> > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dc1dd94cc=
7f81
> > >   - [RFC,v2,02/12] shared/ad: Add RSI data type
> > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dc2e99aef=
d337
> > >   - [RFC,v2,03/12] doc: Add set-api
> > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D6477522e=
92e3
> > >   - [RFC,v2,04/12] device-api: Add Set property
> > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D5bac4cdd=
b191
> > >   - [RFC,v2,05/12] core: Add initial implementation of DeviceSet inte=
rface
> > >     (no matching commit)
> > >   - [RFC,v2,06/12] core: Check if device has RSI
> > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Df95ffcc8=
b1fe
> > >   - [RFC,v2,07/12] main.conf: Add CSIP profile configurable options
> > >     (no matching commit)
> > >   - [RFC,v2,08/12] shared/csip: Add initial code for handling CSIP
> > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dd297a03b=
7a61
> > >   - [RFC,v2,09/12] profiles: Add initial code for csip plugin
> > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D9e1eb0a6=
2b3f
> > >   - [RFC,v2,10/12] tools: Add support to generate RSI using SIRK
> > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dc446a64d=
461b
> > >   - [RFC,v2,11/12] client: Add support for DeviceSet proxy
> > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D373bafc3=
4ce6
> > >   - [RFC,v2,12/12] client: Use AdvertisingFlags when available
> > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D815f779a=
a8e4
> > >
> > > You are awesome, thank you!
> > > --
> > > Deet-doot-dot, I am a bot.
> > > https://korg.docs.kernel.org/patchwork/pwbot.html
> >
> > Let me know if you guys are happy with this interface to detect
> > Coordinated Sets, it still experimental so we can experiment with it
> > until we think it is stable, regarding the implementation of the
> > transports one major difference here is that we will need to encode
> > left and right separately, not sure how hard it is to do that in
> > pipewire?
>
> As far as the device set DBus interface is concerned, it seems to work
> fine for me currently (in wip implementation for PW [0]). Don't right
> now see something that would need to be added/changed in it.
>
> Channel splitting/merging is generally easy in PW. How the playback
> synchronization is going to work on socket level may determine a bit at
> what level in PW it is convenient to do though.
>
>
> ---
>
> Laundry list for PW related to this:
>
> * How to do TX syncronization properly with the ISO sockets needs still
> some thinking. I have some wip patches [2] that add the timestamps and
> other socket API that provide timing information to allow
> synchronization to the Number of Completed packets events.
> Corresponding Pipewire implementation [3] rate matches to keep the time
> difference between those events and our audio reference time fixed at
> e.g. 25ms (2 packets in controller). Not really clear yet if this is a
> right thing to do to help the controller send packets at the right
> time.

I have to check with our controller folks, I do recall someone saying
that perhaps we should use framed instead of unframed so the
controller can better keep up with timings, but it is not yet clear
why.

> Here I see LE Read ISO TX Sync with Intel AX210 returning only zero
> values in Command Complete in btmon for running CIS, so that command
> doesn't seem to help here.

Yeah, I don't think it is implemented yet.

> * BlueZ doesn't seem to pass on the PAC audio location it reads via
> read_sink/source_pac_loc, probably very easy to fix.

Will take a look, afaik we fixed something like this not long ago but
perhaps you are talking about something different.

> * The CIS in a CIG cannot be started one by one, or connected to same
> destination. The kernel appears to wait until all CIS sockets in same
> CIG go to connect state before proceeding to create CIS. The spec does
> not seem to require this (I have some pre-rfc patches to make it more
> flexible [1].)

It used to be like that but I actually have to fix it because the
controller don't accept multiple CreateCIS in parallel:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/tree/net/bluetooth/hci_conn.c#n1907

And it would actually create a relatively big window if we queue and
wait for CIS established, because then the controller may set up its
scheduling without taking into account the second CIS which will then
fail when it comes to its setup, so I think it is better to program
them together to avoid having only one side working.

Btw, take a look at how it was done with bluetoothctl>
transport.acquire <transport_left> <transport_right>, we have been
able to use it to acquire both left/right earbuds and then send
pre-encoded files.

> * PW currently does transport acquires synchronously and fails because
> of that with multiple CIS, but it probably should do them async.
>
>
> [0] https://gitlab.freedesktop.org/pipewire/pipewire/-/merge_requests/156=
4
> [1] https://github.com/pv/linux/commits/iso-fix-multicis
> [2] https://github.com/pv/linux/commits/iso-timestamp
> [3] https://gitlab.freedesktop.org/pvir/pipewire/-/commits/iso-timestamp-=
test
>
> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz
