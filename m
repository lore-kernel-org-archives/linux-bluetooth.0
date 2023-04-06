Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175C8C7618D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Apr 2023 00:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjDFAQk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Apr 2023 20:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjDFAQi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Apr 2023 20:16:38 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3081D4C25
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Apr 2023 17:16:35 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id c1so33052920vsk.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Apr 2023 17:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680740194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SH8JVe28qc7rbYJKslaaieUhZT5v1CGguyrZS56xDNA=;
        b=grzgMLBISaYrhQG4LWfipi1CFabwgjjouhnIN9FZ6FPZwB7BMFXfomGEpB1JD0+9aI
         ElvwviHGj1NaSjnKuh/8WJ1d6D+p1XfVg7IIzp7EoJHX7Jwn7VsouUKDiwmLFsFqEDwH
         C0Bkbo6BUTpzBOf9BfdTlGyHG7k7IgIyInGkg0VbK2CGFalADk/ahCYCZ7a2ExRwLt3B
         vuJyHnejJYeKotOd9xzKUWbTFZZ4fqVybQHtbVfauk9hUPweBkCaDxMp5sMfGT1UiAYS
         h7TCkktKiXkvePAR0wFzJJ48HFF4vr/kGref/uRg4DUVXYw1BWK3l+NzNBRChyQmm1Yp
         1tpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680740194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SH8JVe28qc7rbYJKslaaieUhZT5v1CGguyrZS56xDNA=;
        b=CZGLNo4SnIOTwUbS60fAzViGtGAQk1TIRySvwlt3I44iN0gTlIAal9WQinuZQYotTa
         zNhA/FLDrcFscDNvBsYe1e+gqDNLiaElvRbO+Rq8BCjqhjIO1G1YRukxHsutpxMKezqW
         AAmkPAc4QSSa2mVafU+L4EmeVqDPXDKDa9d/c8kyQT12jEnZSJACpPl9dGNI94LDj29m
         IGnSO9nwQrlM7wBZjlCqI5+SNIxHjasrmgM2Vx/LPYMisrbSqlxnvWjKdf8qVSdxW2Pe
         8oS3YcFTCUOCYZquCZsQzPt+8wPEtTgRQiHzILIKKyfphe0gaS/CieIcavcV0o3y20sa
         W7Og==
X-Gm-Message-State: AAQBX9f6o6+qXAsYvx/QRV/c+WrL2i9p/xqGSEMCXJU4PWXrdek9WyjI
        Ddh2uBQojska9plINyhAgahOfjixemhZ0X7TCns=
X-Google-Smtp-Source: AKy350a8wrjKrvupv69E+G/T1s0+nhWhJMHRI4gzaImPh94KG2e0qGLcAUweXEQNpUy//55C+kFl7PwUFH5W2r6K5xg=
X-Received: by 2002:a67:c285:0:b0:423:e1fd:c6e2 with SMTP id
 k5-20020a67c285000000b00423e1fdc6e2mr6000204vsj.2.1680740194126; Wed, 05 Apr
 2023 17:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230307222422.2608483-1-luiz.dentz@gmail.com>
 <167849522070.21816.4954897604805294201.git-patchwork-notify@kernel.org>
 <CABBYNZJ8GbCic4+dAz-04vji3xgtqYnXRUjTuWHSk3oGjXxA=Q@mail.gmail.com>
 <f86f2896be923a9caa5625457fea46d1c32b3114.camel@iki.fi> <CABBYNZKv68ybD3YVKFtHUARh6H+TVY=2_P9TdNWEbZ4FbTX31w@mail.gmail.com>
 <A02E43E3-63E3-4F75-AB99-FB355180DD2B@iki.fi>
In-Reply-To: <A02E43E3-63E3-4F75-AB99-FB355180DD2B@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 5 Apr 2023 17:16:21 -0700
Message-ID: <CABBYNZJdjq2TZCpNVSC-za6e++GgeL2M3=G=11g7u33NDeEpgg@mail.gmail.com>
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

On Mon, Mar 13, 2023 at 6:05=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> 14. maaliskuuta 2023 2.18.21 GMT+02:00 Luiz Augusto von Dentz <luiz.dentz=
@gmail.com> kirjoitti:
> >Hi Pauli,
> >
> >On Mon, Mar 13, 2023 at 4:30=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrot=
e:
> >>
> >> Hi,
> >>
> >> su, 2023-03-12 kello 22:36 -0700, Luiz Augusto von Dentz kirjoitti:
> >> > Hi Pauli, Frederic,
> >> >
> >> > On Fri, Mar 10, 2023 at 4:40=E2=80=AFPM <patchwork-bot+bluetooth@ker=
nel.org> wrote:
> >> > >
> >> > > Hello:
> >> > >
> >> > > This series was applied to bluetooth/bluez.git (master)
> >> > > by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
> >> > >
> >> > > On Tue,  7 Mar 2023 14:24:11 -0800 you wrote:
> >> > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >> > > >
> >> > > > This adds bt_crypto_sirk which attempts to generate a unique SIR=
K using
> >> > > > the following steps:
> >> > > >
> >> > > >  - Generate a hash (k) using the str as input
> >> > > >  - Generate a hash (sirk) using vendor, product, version and sou=
rce as input
> >> > > >  - Encrypt sirk using k as LTK with sef function.
> >> > > >
> >> > > > [...]
> >> > >
> >> > > Here is the summary with links:
> >> > >   - [RFC,v2,01/12] shared/crypto: Add bt_crypto_sirk
> >> > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dc1dd9=
4cc7f81
> >> > >   - [RFC,v2,02/12] shared/ad: Add RSI data type
> >> > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dc2e99=
aefd337
> >> > >   - [RFC,v2,03/12] doc: Add set-api
> >> > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D64775=
22e92e3
> >> > >   - [RFC,v2,04/12] device-api: Add Set property
> >> > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D5bac4=
cddb191
> >> > >   - [RFC,v2,05/12] core: Add initial implementation of DeviceSet i=
nterface
> >> > >     (no matching commit)
> >> > >   - [RFC,v2,06/12] core: Check if device has RSI
> >> > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Df95ff=
cc8b1fe
> >> > >   - [RFC,v2,07/12] main.conf: Add CSIP profile configurable option=
s
> >> > >     (no matching commit)
> >> > >   - [RFC,v2,08/12] shared/csip: Add initial code for handling CSIP
> >> > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dd297a=
03b7a61
> >> > >   - [RFC,v2,09/12] profiles: Add initial code for csip plugin
> >> > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D9e1eb=
0a62b3f
> >> > >   - [RFC,v2,10/12] tools: Add support to generate RSI using SIRK
> >> > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dc446a=
64d461b
> >> > >   - [RFC,v2,11/12] client: Add support for DeviceSet proxy
> >> > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D373ba=
fc34ce6
> >> > >   - [RFC,v2,12/12] client: Use AdvertisingFlags when available
> >> > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D815f7=
79aa8e4
> >> > >
> >> > > You are awesome, thank you!
> >> > > --
> >> > > Deet-doot-dot, I am a bot.
> >> > > https://korg.docs.kernel.org/patchwork/pwbot.html
> >> >
> >> > Let me know if you guys are happy with this interface to detect
> >> > Coordinated Sets, it still experimental so we can experiment with it
> >> > until we think it is stable, regarding the implementation of the
> >> > transports one major difference here is that we will need to encode
> >> > left and right separately, not sure how hard it is to do that in
> >> > pipewire?
> >>
> >> As far as the device set DBus interface is concerned, it seems to work
> >> fine for me currently (in wip implementation for PW [0]). Don't right
> >> now see something that would need to be added/changed in it.
> >>
> >> Channel splitting/merging is generally easy in PW. How the playback
> >> synchronization is going to work on socket level may determine a bit a=
t
> >> what level in PW it is convenient to do though.
> >>
> >>
> >> ---
> >>
> >> Laundry list for PW related to this:
> >>
> >> * How to do TX syncronization properly with the ISO sockets needs stil=
l
> >> some thinking. I have some wip patches [2] that add the timestamps and
> >> other socket API that provide timing information to allow
> >> synchronization to the Number of Completed packets events.
> >> Corresponding Pipewire implementation [3] rate matches to keep the tim=
e
> >> difference between those events and our audio reference time fixed at
> >> e.g. 25ms (2 packets in controller). Not really clear yet if this is a
> >> right thing to do to help the controller send packets at the right
> >> time.
> >
> >I have to check with our controller folks, I do recall someone saying
> >that perhaps we should use framed instead of unframed so the
> >controller can better keep up with timings, but it is not yet clear
> >why.
> >
> >> Here I see LE Read ISO TX Sync with Intel AX210 returning only zero
> >> values in Command Complete in btmon for running CIS, so that command
> >> doesn't seem to help here.
> >
> >Yeah, I don't think it is implemented yet.
> >
> >> * BlueZ doesn't seem to pass on the PAC audio location it reads via
> >> read_sink/source_pac_loc, probably very easy to fix.
> >
> >Will take a look, afaik we fixed something like this not long ago but
> >perhaps you are talking about something different.
> >
> >> * The CIS in a CIG cannot be started one by one, or connected to same
> >> destination. The kernel appears to wait until all CIS sockets in same
> >> CIG go to connect state before proceeding to create CIS. The spec does
> >> not seem to require this (I have some pre-rfc patches to make it more
> >> flexible [1].)
> >
> >It used to be like that but I actually have to fix it because the
> >controller don't accept multiple CreateCIS in parallel:
> >
> >https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next=
.git/tree/net/bluetooth/hci_conn.c#n1907
> >
> >And it would actually create a relatively big window if we queue and
> >wait for CIS established, because then the controller may set up its
> >scheduling without taking into account the second CIS which will then
> >fail when it comes to its setup, so I think it is better to program
> >them together to avoid having only one side working.
>
> Hmm, I made it queue and wait for the previous Create CIS to fully comple=
te before emitting the next one, and that did seem to also work (also with =
TWS playback to the Samsung device).
> However did not extensively test, so even if allowed by spec risks runnin=
g to controller issues?
>
> The problem here is that the second CIS is not necessarily going to come,=
 as it may be unrelated device put to same CIG since controller doesn't sup=
port multiple CIG.
>
> In principle sound server can acquire always all CIS, but then we should =
expose also the cig/cis properties on transports so they know which ones ar=
e needed.
>
> It could also make sense for BlueZ do it, when any cis in cig is started.
>
> >Btw, take a look at how it was done with bluetoothctl>
> >transport.acquire <transport_left> <transport_right>, we have been
> >able to use it to acquire both left/right earbuds and then send
> >pre-encoded files.
> >
> >> * PW currently does transport acquires synchronously and fails because
> >> of that with multiple CIS, but it probably should do them async.
> >>
> >>
> >> [0] https://gitlab.freedesktop.org/pipewire/pipewire/-/merge_requests/=
1564

Did you make any progress on these changes above? Looks like the pull
request is still open, I wonder if you hit some blocker?

> >> [1] https://github.com/pv/linux/commits/iso-fix-multicis
> >> [2] https://github.com/pv/linux/commits/iso-timestamp
> >> [3] https://gitlab.freedesktop.org/pvir/pipewire/-/commits/iso-timesta=
mp-test
> >>
> >> --
> >> Pauli Virtanen
> >
> >
> >
>
> Hi,



--=20
Luiz Augusto von Dentz
