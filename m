Return-Path: <SRS0=Ssic=SK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86005C282DD
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Apr 2019 09:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43BA920880
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Apr 2019 09:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtZ1Pilz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfDHJlU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:41:20 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40138 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbfDHJlU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Apr 2019 05:41:20 -0400
Received: by mail-ot1-f65.google.com with SMTP id t8so11387505otp.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Apr 2019 02:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/z/M2FfrjncwpujR7oD8LJNu1hl4CkD+hAA0Lt7npC8=;
        b=DtZ1PilzTJ9tGMiqxPQ9+hTYzpHeJAq/WdmKYojl9wkRCUPXPHRgOEm22VmDRy7N3f
         JVv6qHybL3/3wGqiHl2t5fsVFeHMccEOoy4Op7kHrMDcvgObD7plQFkbxozH8Q5fe72q
         KVvI6hRaG5zHgDGEhzjw39f1nvQeOE+oWj8+/2sgSvRM+YsKgYD0VXGbryGdDmtCKMm8
         7Po15YNbMelRsyLNEJ+Lqfd43V8MiD8Qudp2dqTryZ2z7g5SbqcLrVyVilhRhBx82Koa
         mVmTft781zHPvmu9Mpab9BNtF1xt5wMKVCNcq5+s8jYatN7e2W3Pipq/bvmmevFycNgc
         0HlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/z/M2FfrjncwpujR7oD8LJNu1hl4CkD+hAA0Lt7npC8=;
        b=Zzr9iP9grToU3Q9Lo+p31dCvG7ZkZfaETx1+xRS2Tgv9x2xH9qxgXz2f14hDDuL5Ew
         rRdJuzQ0ZKlgtW3QLLJtFZ/+G227EKdhpMkO0df9/Djl9VM6dTB8SV+7ZOPZ/xab1aOq
         dCaZFB/v/rV2Xd3rc5Wt/70jF7Y4OIS4ByLXDfrLc94tyM/JUCw9ff3dmSqorPljco6Q
         +dL5wCQQRuPffi2VZLkMbq1T7H50gSJmxiEfTnZY9p3qe4EFc090BRrISQzMAhiB9Z0f
         J/Nljffwn02JUKxhwrvgaKX+GO9aMquuP/VBM3Lpv8PUikjsTIK0tWj1aqwRF02VXN1D
         +Fbg==
X-Gm-Message-State: APjAAAWkHxeSlyVAAMTYcxsb1KshJ0gLlfT8Hs5isP9P1DOdsZxLFd7o
        qP88bJxSdPAQoLcnrCeJGhbgjjvDb0JgPQojq9YaJw8Y
X-Google-Smtp-Source: APXvYqwNMlWViXU9VGBwg+lDfPg/Mbz3pPSR4iaF6mbByx2HnwUmngYHxk59m0wG+rExd204oxral1aOVvQU50d9wzo=
X-Received: by 2002:a05:6830:2042:: with SMTP id f2mr17767531otp.89.1554716479380;
 Mon, 08 Apr 2019 02:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190122134524.20509-1-luiz.dentz@gmail.com> <CABBYNZLCFpXhbAnVYaA-nVNOY8QRvpR1UZhMHfy-awZxtpSocQ@mail.gmail.com>
 <20190122175622.dj6riiim6zukpetw@pali> <CABBYNZJGLGnNzXC_Q+Visk1XPwP9FX+BvJ65UQMj4tMJfL92+Q@mail.gmail.com>
 <20190405164713.cvfciulxnby25o3g@pali>
In-Reply-To: <20190405164713.cvfciulxnby25o3g@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 8 Apr 2019 12:41:06 +0300
Message-ID: <CABBYNZJQvOODiwVcNrDPH7A+5qTM0ZmSHaZ8=+=32CeH1t482A@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] doc/media-api: Enable MediaEndpoint to expose
 remote SEP
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Fri, Apr 5, 2019 at 7:47 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrote=
:
>
> On Wednesday 23 January 2019 13:24:22 Luiz Augusto von Dentz wrote:
> > Hi Pali,
> > On Tue, Jan 22, 2019 at 7:56 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> =
wrote:
> > >
> > > On Tuesday 22 January 2019 16:20:12 Luiz Augusto von Dentz wrote:
> > > > Hi Pali,
> > > > On Tue, Jan 22, 2019 at 3:45 PM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > >
> > > > > This adds the possibility to expose remote SEP using MediaEndpoin=
t
> > > > > interface to allow setting a configuration.
> > > > > ---
> > > > >  doc/media-api.txt | 27 +++++++++++++++++++++++++--
> > > > >  1 file changed, 25 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/doc/media-api.txt b/doc/media-api.txt
> > > > > index b5ad2db12..af9485342 100644
> > > > > --- a/doc/media-api.txt
> > > > > +++ b/doc/media-api.txt
> > > > > @@ -500,14 +500,23 @@ Properties        object Player [readonly]
> > > > >  MediaEndpoint1 hierarchy
> > > > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > > > >
> > > > > -Service                unique name
> > > > > +Service                unique name (Server role)
> > > > > +               org.bluez (Client role)
> > > > >  Interface      org.bluez.MediaEndpoint1
> > > > > -Object path    freely definable
> > > > > +Object path    freely definable (Server role)
> > > > > +               [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX=
_XX_XX/sepX
> > > > > +               (Client role)
> > > > >
> > > > >  Methods                void SetConfiguration(object transport, d=
ict properties)
> > > > >
> > > > >                         Set configuration for the transport.
> > > > >
> > > > > +                       For client role transport must be set wit=
h a server
> > > > > +                       endpoint oject which will be configured a=
nd the
> > > > > +                       properties must contain the following pro=
perties:
> > > > > +
> > > > > +                               array{byte} Capabilities
> > > > > +
> > > > >                 array{byte} SelectConfiguration(array{byte} capab=
ilities)
> > > > >
> > > > >                         Select preferable configuration from the =
supported
> > > > > @@ -532,6 +541,20 @@ Methods            void SetConfiguration(obj=
ect transport, dict properties)
> > > > >                         endpoint, because when this method gets c=
alled it has
> > > > >                         already been unregistered.
> > > > >
> > > > > +Properties     string UUID [readonly, optional]:
> > > > > +
> > > > > +                       UUID of the profile which the endpoint is=
 for.
> > > > > +
> > > > > +               byte Codec [readonly, optional]:
> > > > > +
> > > > > +                       Assigned number of codec that the endpoin=
t implements.
> > > > > +                       The values should match the profile speci=
fication which
> > > > > +                       is indicated by the UUID.
> > > > > +
> > > > > +               array{byte} Capabilities [readonly, optional]:
> > > > > +
> > > > > +                       Capabilities blob, it is used as it is so=
 the size and
> > > > > +                       byte order must match.
> > > > >
> > > > >  MediaTransport1 hierarchy
> > > > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > > > > --
> > > > > 2.17.2
> > > >
> > > > Can you try this set?
> > >
> > > Hi! In V3 you added only "a2dp: Add reverse discovery" patch right?
> > > I tested my setup also with this patch and there is no difference,
> > > pulseaudio is working fine :-)
> > >
> >
> > Applied.
> >
>
> Hello, I have found another problem with this patch series.
>
> I have there Nokia N900 device with Community SSU updates which acts as
> both A2DP sink and A2DP source.
>
> When I scan A2DP capabilities of Nokia N900 I get following output:
>
> $ ./tools/avinfo XX:XX:XX:XX:XX:XX
> Connecting ...
> Stream End-Point #1: Audio Source
>         Media Codec: SBC
>                 Channel Modes: Mono DualChannel Stereo JointStereo
>                 Frequencies: 16Khz 32Khz 44.1Khz 48Khz
>                 Subbands: 4 8
>                 Blocks: 4 8 12 16
>                 Bitpool Range: 2-64
> Stream End-Point #2: Audio Sink
>         Media Codec: SBC
>                 Channel Modes: Mono DualChannel Stereo JointStereo
>                 Frequencies: 16Khz 32Khz 44.1Khz 48Khz
>                 Subbands: 4 8
>                 Blocks: 4 8 12 16
>                 Bitpool Range: 2-64
>
> $ qdbus --system org.bluez
> /
> /org
> /org/bluez
> /org/bluez/hci0
> /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX
> /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/fd2
> /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/player0
> /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/sep1
> /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/sep2
> /org/bluez/test
>
> So there is one SEP as Audio Source and one SEP as Audio Sink.
>
> But when I ask sep1 and sep2 for UUID via dbus, I get that both are just
> Audio Sinks:
>
> $ qdbus --system org.bluez /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/sep1 org=
.bluez.MediaEndpoint1.UUID
> 0000110a-0000-1000-8000-00805f9b34fb
>
> $ qdbus --system org.bluez /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/sep2 org=
.bluez.MediaEndpoint1.UUID
> 0000110a-0000-1000-8000-00805f9b34fb
>
> So this is a clear bug.

I will send a fix shortly.

--=20
Luiz Augusto von Dentz
