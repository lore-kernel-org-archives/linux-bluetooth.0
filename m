Return-Path: <SRS0=AkUh=SV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F49C282DA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Apr 2019 18:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAA320645
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Apr 2019 18:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Finv79xs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbfDSSwg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:52:36 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40179 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfDSSwg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Apr 2019 14:52:36 -0400
Received: by mail-ot1-f67.google.com with SMTP id t8so4999327otp.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2019 11:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AZUxJV7QWV/R2JS2WPhlXSPRY24cRjNyRKaVo8rPdFk=;
        b=Finv79xsU9XmDj71bNhJ7OsuaYIyjbcxaEl/26X5906HWc5KnZe35pD3osgsyN4v2f
         cIuP1em3L2RkysanZYghttWeAYFrN5DoYdNbvx4Lc/n50c/1pc8CNt3sPJEB0gA0wavk
         VBkJh2Wc5T7VEBQUMEGpmDVXtVyjAj39eVYct8JpCqMbzht5CSBPNWwTxvpm3oH6XXv5
         8I2OdqG1dAI8UkIY1D7UGJ2SAcjDLL1e3mAORFSi1/rsaVDt3AiGlhBg6eY5IwgVXQLj
         VrSk8daS98FnqS/mXlnP7oMXNHp0n63DgJ/EKhr2Mku70nRQIdZQZZJBLe3Qgh+OnhXh
         YwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AZUxJV7QWV/R2JS2WPhlXSPRY24cRjNyRKaVo8rPdFk=;
        b=duwh8YDYK05EMWI0gpx4doQwf6J38aiFuWqjHFVVGbfsnKvzpva9zw2H/cJN3hhI+7
         DoIbP8xtVIjQGVOv3th3cnDgh9zZtu6mbzK0kWAEqrwNW3W/THn2STjIqJ6hzRnKfTjg
         nPUm6QmXYnmM0tuUR268AnQCfQ2sWPdDJNK2kxP+PA6lYRd1RDh7opH1j0NLxZ6cU67V
         EboocMjThojDvT6cLAbsnlAd/6TjdcfWan7z/PAWP+YOy5i8x57hNTYDQtYMfN66dCL6
         FB2WtdGvN//gRWLIBaZOnd4e8jZFl1bR+OWRcDFov1YMwmZkhCbToPjZg5X/PJAIg1JK
         CW6Q==
X-Gm-Message-State: APjAAAXTqAE+sil/hewbAuZxeLaeB+yl9jvQXG19VF+v952Uzlky0Ckm
        oH+Q7RxFyDkZE8qU/714sBIyY1FvBfRneeP6l0BbqMwT3G8=
X-Google-Smtp-Source: APXvYqz2OTK7V8yrvz4TPEW30Nepo/6PNinJkbSLwnE2jNYRxFDIss2rMhK+X8aQdAxICvF9G+Kypr5R3z7eWXn8+fE=
X-Received: by 2002:a9d:694c:: with SMTP id p12mr1636089oto.242.1555668251326;
 Fri, 19 Apr 2019 03:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190122134524.20509-1-luiz.dentz@gmail.com> <CABBYNZLCFpXhbAnVYaA-nVNOY8QRvpR1UZhMHfy-awZxtpSocQ@mail.gmail.com>
 <20190122175622.dj6riiim6zukpetw@pali> <CABBYNZJGLGnNzXC_Q+Visk1XPwP9FX+BvJ65UQMj4tMJfL92+Q@mail.gmail.com>
 <20190127020038.q3hm5h7xl2ku6fse@pali> <20190327111430.6gliqodnnojsifjd@pali> <20190419080348.fbgs55qqs3j2yovb@pali>
In-Reply-To: <20190419080348.fbgs55qqs3j2yovb@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 19 Apr 2019 13:04:01 +0300
Message-ID: <CABBYNZLNBFVNh42eQ-SDeRPKpS96AUdOsoN3jqZgHSvHfRwxOQ@mail.gmail.com>
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

On Fri, Apr 19, 2019 at 11:03 AM Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
>
> On Wednesday 27 March 2019 12:14:30 Pali Roh=C3=A1r wrote:
> > On Sunday 27 January 2019 03:00:38 Pali Roh=C3=A1r wrote:
> > > On Wednesday 23 January 2019 13:24:22 Luiz Augusto von Dentz wrote:
> > > > Hi Pali,
> > > > On Tue, Jan 22, 2019 at 7:56 PM Pali Roh=C3=A1r <pali.rohar@gmail.c=
om> wrote:
> > > > >
> > > > > On Tuesday 22 January 2019 16:20:12 Luiz Augusto von Dentz wrote:
> > > > > > Hi Pali,
> > > > > > On Tue, Jan 22, 2019 at 3:45 PM Luiz Augusto von Dentz
> > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > >
> > > > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > > > >
> > > > > > > This adds the possibility to expose remote SEP using MediaEnd=
point
> > > > > > > interface to allow setting a configuration.
> > > > > > > ---
> > > > > > >  doc/media-api.txt | 27 +++++++++++++++++++++++++--
> > > > > > >  1 file changed, 25 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/doc/media-api.txt b/doc/media-api.txt
> > > > > > > index b5ad2db12..af9485342 100644
> > > > > > > --- a/doc/media-api.txt
> > > > > > > +++ b/doc/media-api.txt
> > > > > > > @@ -500,14 +500,23 @@ Properties        object Player [readon=
ly]
> > > > > > >  MediaEndpoint1 hierarchy
> > > > > > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > > > > > >
> > > > > > > -Service                unique name
> > > > > > > +Service                unique name (Server role)
> > > > > > > +               org.bluez (Client role)
> > > > > > >  Interface      org.bluez.MediaEndpoint1
> > > > > > > -Object path    freely definable
> > > > > > > +Object path    freely definable (Server role)
> > > > > > > +               [variable prefix]/{hci0,hci1,...}/dev_XX_XX_X=
X_XX_XX_XX/sepX
> > > > > > > +               (Client role)
> > > > > > >
> > > > > > >  Methods                void SetConfiguration(object transpor=
t, dict properties)
> > > > > > >
> > > > > > >                         Set configuration for the transport.
> > > > > > >
> > > > > > > +                       For client role transport must be set=
 with a server
> > > > > > > +                       endpoint oject which will be configur=
ed and the
> > > > > > > +                       properties must contain the following=
 properties:
> > > > > > > +
> > > > > > > +                               array{byte} Capabilities
> > > > > > > +
> > > > > > >                 array{byte} SelectConfiguration(array{byte} c=
apabilities)
> > > > > > >
> > > > > > >                         Select preferable configuration from =
the supported
> > > > > > > @@ -532,6 +541,20 @@ Methods            void SetConfiguration=
(object transport, dict properties)
> > > > > > >                         endpoint, because when this method ge=
ts called it has
> > > > > > >                         already been unregistered.
> > > > > > >
> > > > > > > +Properties     string UUID [readonly, optional]:
> > > > > > > +
> > > > > > > +                       UUID of the profile which the endpoin=
t is for.
> > > > > > > +
> > > > > > > +               byte Codec [readonly, optional]:
> > > > > > > +
> > > > > > > +                       Assigned number of codec that the end=
point implements.
> > > > > > > +                       The values should match the profile s=
pecification which
> > > > > > > +                       is indicated by the UUID.
> > > > > > > +
> > > > > > > +               array{byte} Capabilities [readonly, optional]=
:
> > > > > > > +
> > > > > > > +                       Capabilities blob, it is used as it i=
s so the size and
> > > > > > > +                       byte order must match.
> > > > > > >
> > > > > > >  MediaTransport1 hierarchy
> > > > > > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > > > > > --
> > > > > > > 2.17.2
> > > > > >
> > > > > > Can you try this set?
> > > > >
> > > > > Hi! In V3 you added only "a2dp: Add reverse discovery" patch righ=
t?
> > > > > I tested my setup also with this patch and there is no difference=
,
> > > > > pulseaudio is working fine :-)
> > > > >
> > > >
> > > > Applied.
> > >
> > > Hi! I have one bug report for these patches.
> > >
> > > When I manually disconnect A2DP profile, but let HFP active then all =
SEP
> > > paths on D-Bus disappear.
> > >
> > >   qdbus --system org.bluez /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX org.=
bluez.Device1.DisconnectProfile 0000110b-0000-1000-8000-00805f9b34fb
> > >
> > > So pulseaudio would still see bluetooth device as active (because HFP=
 is
> > > in use), but does not see any A2DP codec as all remote SEPs from DBus
> > > were removed.
> > >
> > > It is possible to not remove remote SEPs when A2DP sink profile is
> > > manually disconnected?
> >
> > Hi Luiz! Have you looked at above problem?
>
> Hi! This one problem is still there.

This should have been fixed:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=3D9f7659a4460=
1e043bdb6724b0ab4f3f59c46e9fe



--=20
Luiz Augusto von Dentz
