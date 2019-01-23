Return-Path: <SRS0=X26K=P7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D63C282C0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jan 2019 11:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F7F20870
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jan 2019 11:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cB6Y5UTE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfAWLYf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Jan 2019 06:24:35 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41220 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbfAWLYf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Jan 2019 06:24:35 -0500
Received: by mail-ot1-f66.google.com with SMTP id u16so1568143otk.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jan 2019 03:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QJi0V99Em77Tr6KqF6iJRTleogjvN80kXKMBlQ5nkqo=;
        b=cB6Y5UTEDSLMjK7bomCI2DS/gZZdfFC8/MW3RvMhjc8Wz9WsnDU3QFyvGJPGt7kO36
         q4XdTpy9eHhInqZ3B08UDI5S/gfnW99JvIxjfFCbQ5SH5+o3/e7s9AecIf2uHr/+fLnI
         U5hURErNYxh3+SNpNWg/tR+b08pfVuzCMepDaQAk/rIta1ZMTqMM4aTn66a+2EclkvVA
         SVh6Gq/+taRor1QJHYB60N//ueOuVl6DYUaBRHvX85fxRgUWduMsD3kQJupBQ5RUb5Rh
         U7p09CvoWoqwnyey9/v2mtW2k3Db7AxzyBDzmmF1VL0nb2QuPgircYznm7eS114B5gMf
         qBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QJi0V99Em77Tr6KqF6iJRTleogjvN80kXKMBlQ5nkqo=;
        b=X+t1LD5PuaFVsF8mTlg+z/OmXSpqCENjoCdMoXS5HLJEuRgYcqaNSrCxK/GG2iC+cD
         IQOj/ualaWuyj9GfZGPAcLx55ffRlLokqKdb9qbJXGBsMCDSRb4NtzvCZEyT6GL+aRtI
         DZF91LYJA7IJV4t2+Op7IxqZthfF+brSjDn7ZW7yqh71tDjJYhiJaWPWpJvHdZqxtm83
         cFRxAmJdKnGmxyZxKTVReN9i+2DcQCOQEsib3LkkwwQeqpYomlpRshGcdUlTlAoRV9Ds
         cuDD3C1bILYBCz6C2dRKocGcIhFPgQ+i0LGJVzATbGyTfPmV5zLVbtksE+2UKexia4YK
         yBAw==
X-Gm-Message-State: AJcUukeKMRXk5cUJE7zgo5T+fZQOam82kjBH9WKhBL7cXyrF0jP+XDHM
        b4qkPWgrl0vS3hoPkdm8JyX71WT2WZOAhDKVWmQ=
X-Google-Smtp-Source: ALg8bN4Y95pX26SpO85C0TdaRRbtdG04/x+YgRlE+IzL1heqN/DoLR/QHt2d6xn7U0m4Ky+R1Khz0EXUKRJeLBX5RUw=
X-Received: by 2002:a9d:7749:: with SMTP id t9mr1251212otl.342.1548242674118;
 Wed, 23 Jan 2019 03:24:34 -0800 (PST)
MIME-Version: 1.0
References: <20190122134524.20509-1-luiz.dentz@gmail.com> <CABBYNZLCFpXhbAnVYaA-nVNOY8QRvpR1UZhMHfy-awZxtpSocQ@mail.gmail.com>
 <20190122175622.dj6riiim6zukpetw@pali>
In-Reply-To: <20190122175622.dj6riiim6zukpetw@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 23 Jan 2019 13:24:22 +0200
Message-ID: <CABBYNZJGLGnNzXC_Q+Visk1XPwP9FX+BvJ65UQMj4tMJfL92+Q@mail.gmail.com>
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
On Tue, Jan 22, 2019 at 7:56 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
>
> On Tuesday 22 January 2019 16:20:12 Luiz Augusto von Dentz wrote:
> > Hi Pali,
> > On Tue, Jan 22, 2019 at 3:45 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > >
> > > This adds the possibility to expose remote SEP using MediaEndpoint
> > > interface to allow setting a configuration.
> > > ---
> > >  doc/media-api.txt | 27 +++++++++++++++++++++++++--
> > >  1 file changed, 25 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/doc/media-api.txt b/doc/media-api.txt
> > > index b5ad2db12..af9485342 100644
> > > --- a/doc/media-api.txt
> > > +++ b/doc/media-api.txt
> > > @@ -500,14 +500,23 @@ Properties        object Player [readonly]
> > >  MediaEndpoint1 hierarchy
> > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > >
> > > -Service                unique name
> > > +Service                unique name (Server role)
> > > +               org.bluez (Client role)
> > >  Interface      org.bluez.MediaEndpoint1
> > > -Object path    freely definable
> > > +Object path    freely definable (Server role)
> > > +               [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_=
XX/sepX
> > > +               (Client role)
> > >
> > >  Methods                void SetConfiguration(object transport, dict =
properties)
> > >
> > >                         Set configuration for the transport.
> > >
> > > +                       For client role transport must be set with a =
server
> > > +                       endpoint oject which will be configured and t=
he
> > > +                       properties must contain the following propert=
ies:
> > > +
> > > +                               array{byte} Capabilities
> > > +
> > >                 array{byte} SelectConfiguration(array{byte} capabilit=
ies)
> > >
> > >                         Select preferable configuration from the supp=
orted
> > > @@ -532,6 +541,20 @@ Methods            void SetConfiguration(object =
transport, dict properties)
> > >                         endpoint, because when this method gets calle=
d it has
> > >                         already been unregistered.
> > >
> > > +Properties     string UUID [readonly, optional]:
> > > +
> > > +                       UUID of the profile which the endpoint is for=
.
> > > +
> > > +               byte Codec [readonly, optional]:
> > > +
> > > +                       Assigned number of codec that the endpoint im=
plements.
> > > +                       The values should match the profile specifica=
tion which
> > > +                       is indicated by the UUID.
> > > +
> > > +               array{byte} Capabilities [readonly, optional]:
> > > +
> > > +                       Capabilities blob, it is used as it is so the=
 size and
> > > +                       byte order must match.
> > >
> > >  MediaTransport1 hierarchy
> > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > > --
> > > 2.17.2
> >
> > Can you try this set?
>
> Hi! In V3 you added only "a2dp: Add reverse discovery" patch right?
> I tested my setup also with this patch and there is no difference,
> pulseaudio is working fine :-)
>

Applied.


--=20
Luiz Augusto von Dentz
