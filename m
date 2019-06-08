Return-Path: <SRS0=Jazt=UH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB454C28CC5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  8 Jun 2019 10:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2E2214D8
	for <linux-bluetooth@archiver.kernel.org>; Sat,  8 Jun 2019 10:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yb6yxjHa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfFHK4n (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 8 Jun 2019 06:56:43 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:40289 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfFHK4n (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 8 Jun 2019 06:56:43 -0400
Received: by mail-ot1-f43.google.com with SMTP id x24so4206708otp.7
        for <linux-bluetooth@vger.kernel.org>; Sat, 08 Jun 2019 03:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zlrUofwC0rLFi4t3819MPKNnBDAhKU7LAfZlOhnun0o=;
        b=Yb6yxjHae4WPUhpkaOMCI/gV7D1nuAr2iGUaMeyt/YdDmKF7Yp22/M/5I3p1QY1Ywq
         fISjlKKXGxw6a/2DM97NJeDdpKS3ln3lzLCeyKBpGOJ2ROkAgU9rhpdzlWYh2qkq9Htv
         7/g0PQ1QWkB5TI42fGg4oLWTUg5vk+gHEMaWS1hm/G2HdQV/KFvkVoBH5FoM7/16KoV+
         8SV4vRrX6Qk5F3xrsBYHybV/0KqudbR5avoop+NwOkwqSwxsM3kNMUfv1k5Mofx/7VSr
         ZQ+bcR9Kd2BSgVLQ2E7Bl53wvRAuvvw02Uhf/HRBdvFKdhPYlgVjfEgd7Z8oqB/oZHBb
         iVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zlrUofwC0rLFi4t3819MPKNnBDAhKU7LAfZlOhnun0o=;
        b=qC4clDVK55XlaOL9Twn7g/OOkh+Dn0i5AkeluburE+XdybL4XbWuGiupgMWJo3waLp
         N2XEGn4pFn8lIhyRoxyB8QWiWSZBgXlYsLka33Zkhlam5kI+ktj754P0HSEZvoIiunR9
         fvzcJkh+JuFKCpApOrQ8DQGFcXM8LFddPgSL4ejuJN1aWOmA8rZmrVZKprS24vAh1qIQ
         UDJmwiSiP+NVpV3V12NfFU5xZXXnTF9ozz5haeBA4ce5fToOdm1UF5BzRK1friX7c4ZP
         AFLrspz7bVXlqHeRLUwiY/TLImfyhag2ms/BAtTa6sZQrby1yxXlwQvEzR2un/bBzJvr
         YDEw==
X-Gm-Message-State: APjAAAXcjvNOvA7KzluHxHnHnoyzb87K6DEjqrmmQc+/9ld0zzJFsvXq
        d9GUngi/9D49QhJClKttGNS17RfVcKYRrZL1vuE=
X-Google-Smtp-Source: APXvYqzdbWwhqlFhailipszC6uba84s1rKcw2rhUVfdrn47VpA5BPL9IQ3GG70F7tE11ubunKwc1/ZwXBLERqj6gkGM=
X-Received: by 2002:a9d:3a4a:: with SMTP id j68mr1423863otc.11.1559991402244;
 Sat, 08 Jun 2019 03:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190513170550.bsbr2mh7w36hj7io@pali> <20190607125800.trsx2o3njaiaitu2@pali>
 <CABBYNZLtgaCi5VGHapsKQG4iAC33ySow3AuH0Qkx8iCo3LcZDg@mail.gmail.com> <20190607153715.w5exsodd25qxc6xv@pali>
In-Reply-To: <20190607153715.w5exsodd25qxc6xv@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sat, 8 Jun 2019 13:56:29 +0300
Message-ID: <CABBYNZ+gPRkAgFAeeoSqZ7tp5fYimGdju9JSuSpn_kL+f9hJhQ@mail.gmail.com>
Subject: Re: bluez - check for new a2dp features
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Fri, Jun 7, 2019 at 6:37 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrote=
:
>
> On Friday 07 June 2019 18:26:02 Luiz Augusto von Dentz wrote:
> > Hi Pali,
> >
> > On Fri, Jun 7, 2019 at 3:58 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> w=
rote:
> > >
> > > On Monday 13 May 2019 19:05:50 Pali Roh=C3=A1r wrote:
> > > > Hello!
> > > >
> > > > In current git bluez master repository are new features related to =
A2DP.
> > > > E.g. support for codec switching or fallback to other local dbus
> > > > endpoints when current selected rejected connection...
> > > >
> > > > Moreover codec switching support is behind experimental runtime swi=
tch.
> > > >
> > > > For pulseaudio a2dp module I need to do runtime check if above feat=
ures
> > > > are supported by currently running bluez instance (which registered=
 to
> > > > dbus org.bluez. It is needed to ensure that pulseaudio does not
> > > > introduce regression for older bluez version without above new A2DP
> > > > features.
> > > >
> > > > But currently I have not found any way how to detect if bluez suppo=
rts
> > > > codec switching or if it has support for trying another local SEP f=
or
> > > > connection.
> > > >
> > > > So, could you please export e.g. bluez version as dbus property? An=
d
> > > > also property if codec switching is supported and enabled by that
> > > > experimental flag?
> > >
> > > Hello, I would like to ask for some possibility to export these
> > > information. Without them it is not really possible to have stable
> > > implementation which would work with both old and new bluez version.
> >
> > I wonder what you are talking about since your changes do have checks
> > for when endpoints are detected,
>
> But this does not work as endpoints are available on DBus only when A2DP
> connection is active. I already asked to export them always (even when
> A2DP is not connected).
>
> Main problem is that when profile switching is not available, there
> should be registered only one A2DP codec (SBC in automatic quality) as
> changing is not possible. This is to prevent introducing any regression
> or having registered codec which would not work correctly.

I fill like repeating myself over and over, but here it goes again,
endpoints are not supposed to initiate connection which is the reason
why in PA the card is created only when a profile is connected, and no
we are not going to introduce feature like this to counter bugs where
HFP is left connect while A2DP isn't, etc. It is very important to
note that while we are caching the remote endpoints we never assume
they are valid before we connect and confirm they are still available.

> > isn't that enough to detect if one can switch codecs or not?
>
> Yes, this could be enough... but endpoints on DBus must be always
> available, not only when A2DP profile is connected.

Not gonna happen.

> > This logic used to work just fine last time I tested it.
>
> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com



--=20
Luiz Augusto von Dentz
