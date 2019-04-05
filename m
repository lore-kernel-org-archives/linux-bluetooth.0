Return-Path: <SRS0=tQl/=SH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C032CC282CE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Apr 2019 16:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 780A820700
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Apr 2019 16:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieDJmEmc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbfDEQrR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:47:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51055 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730565AbfDEQrR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Apr 2019 12:47:17 -0400
Received: by mail-wm1-f67.google.com with SMTP id z11so7468331wmi.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Apr 2019 09:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FNUEjMGu1kRYi8v2ytXrDj+Tfzwg4V9LIJg5m0Ar1TU=;
        b=ieDJmEmcZflpuEEXxSGwdYc/sx93Lb01f/oKjUCu4s2I7OT7eC75w4ZuNZsqW1l19n
         YT/fKcD8th45+l/CS7mM0RCmCnNr+VBMrYc146qbC9r1wSuBQgjYND+Oc83KiWZIlpar
         bna4vWCVQML36mkFGPl3ANgv9h2wPXoWcGHj9A2J9Ue2Yhzeajj4//Hp72reTAIKpCom
         sg58RxcbSa1a/5UFTpmmPxZ+XkeiBZmcoVzmWjWhYjLTfC5hu3UBSyKHAjVgZ4A05xc8
         w0I5OY3RwBoS2YkmIOH5U3+0nnm7RVXasbeUfRpOsZn5uCWSBM2dg20T8Ey4RoiPD4FT
         1qoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FNUEjMGu1kRYi8v2ytXrDj+Tfzwg4V9LIJg5m0Ar1TU=;
        b=D8bOzHV/5kii2iI6CVvg34D7U0O76G7B/FQVhtWjKZx7FiQqG15KO/CwUC9hq2+CLK
         AcsMhKmrPZFVs770a7sHlDsyvb71UJmgcHem1wadBwGS3ykIltKB53wR52CkUKn5CICX
         r+62enXoNg99mb9fms4xXvFLAeCvnj03S+rhRWwFQzJXyM2bMtiasAFDaGkF36KEmP30
         8nO/NWNIs5FWcf+W97Q1xsGE5R+OKE7LqvPVEAQVaKdBA3A4A/hWlufs6XBJ5RQTyvk8
         IT0x8adC/Qj4Z2UuFjEg6yttkcLNDUSNu3BrAAqAAYUtp9U3IX7VZE8e20LlC2rSfs7U
         5CEA==
X-Gm-Message-State: APjAAAUMWuF3MJa86GN0iNv74HsGVnAHYllksjzxfEj8QJaGzT56eGO5
        66tbpKpNHRCVIAksd4jHEg0=
X-Google-Smtp-Source: APXvYqwHsDa5JSNuhhD3qI/HuK4zpAPucl+Rf89spOWtegZoX+MADwS1SMdSqRv9qHA+SaHBEerUpg==
X-Received: by 2002:a1c:df89:: with SMTP id w131mr6493028wmg.82.1554482835378;
        Fri, 05 Apr 2019 09:47:15 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id k14sm2971920wmj.26.2019.04.05.09.47.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 09:47:14 -0700 (PDT)
Date:   Fri, 5 Apr 2019 18:47:13 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3 1/9] doc/media-api: Enable MediaEndpoint to expose
 remote SEP
Message-ID: <20190405164713.cvfciulxnby25o3g@pali>
References: <20190122134524.20509-1-luiz.dentz@gmail.com>
 <CABBYNZLCFpXhbAnVYaA-nVNOY8QRvpR1UZhMHfy-awZxtpSocQ@mail.gmail.com>
 <20190122175622.dj6riiim6zukpetw@pali>
 <CABBYNZJGLGnNzXC_Q+Visk1XPwP9FX+BvJ65UQMj4tMJfL92+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5alpeweq3yat3hhw"
Content-Disposition: inline
In-Reply-To: <CABBYNZJGLGnNzXC_Q+Visk1XPwP9FX+BvJ65UQMj4tMJfL92+Q@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--5alpeweq3yat3hhw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday 23 January 2019 13:24:22 Luiz Augusto von Dentz wrote:
> Hi Pali,
> On Tue, Jan 22, 2019 at 7:56 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wr=
ote:
> >
> > On Tuesday 22 January 2019 16:20:12 Luiz Augusto von Dentz wrote:
> > > Hi Pali,
> > > On Tue, Jan 22, 2019 at 3:45 PM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > >
> > > > This adds the possibility to expose remote SEP using MediaEndpoint
> > > > interface to allow setting a configuration.
> > > > ---
> > > >  doc/media-api.txt | 27 +++++++++++++++++++++++++--
> > > >  1 file changed, 25 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/doc/media-api.txt b/doc/media-api.txt
> > > > index b5ad2db12..af9485342 100644
> > > > --- a/doc/media-api.txt
> > > > +++ b/doc/media-api.txt
> > > > @@ -500,14 +500,23 @@ Properties        object Player [readonly]
> > > >  MediaEndpoint1 hierarchy
> > > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > > >
> > > > -Service                unique name
> > > > +Service                unique name (Server role)
> > > > +               org.bluez (Client role)
> > > >  Interface      org.bluez.MediaEndpoint1
> > > > -Object path    freely definable
> > > > +Object path    freely definable (Server role)
> > > > +               [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_X=
X_XX/sepX
> > > > +               (Client role)
> > > >
> > > >  Methods                void SetConfiguration(object transport, dic=
t properties)
> > > >
> > > >                         Set configuration for the transport.
> > > >
> > > > +                       For client role transport must be set with =
a server
> > > > +                       endpoint oject which will be configured and=
 the
> > > > +                       properties must contain the following prope=
rties:
> > > > +
> > > > +                               array{byte} Capabilities
> > > > +
> > > >                 array{byte} SelectConfiguration(array{byte} capabil=
ities)
> > > >
> > > >                         Select preferable configuration from the su=
pported
> > > > @@ -532,6 +541,20 @@ Methods            void SetConfiguration(objec=
t transport, dict properties)
> > > >                         endpoint, because when this method gets cal=
led it has
> > > >                         already been unregistered.
> > > >
> > > > +Properties     string UUID [readonly, optional]:
> > > > +
> > > > +                       UUID of the profile which the endpoint is f=
or.
> > > > +
> > > > +               byte Codec [readonly, optional]:
> > > > +
> > > > +                       Assigned number of codec that the endpoint =
implements.
> > > > +                       The values should match the profile specifi=
cation which
> > > > +                       is indicated by the UUID.
> > > > +
> > > > +               array{byte} Capabilities [readonly, optional]:
> > > > +
> > > > +                       Capabilities blob, it is used as it is so t=
he size and
> > > > +                       byte order must match.
> > > >
> > > >  MediaTransport1 hierarchy
> > > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > > > --
> > > > 2.17.2
> > >
> > > Can you try this set?
> >
> > Hi! In V3 you added only "a2dp: Add reverse discovery" patch right?
> > I tested my setup also with this patch and there is no difference,
> > pulseaudio is working fine :-)
> >
>=20
> Applied.
>=20

Hello, I have found another problem with this patch series.

I have there Nokia N900 device with Community SSU updates which acts as
both A2DP sink and A2DP source.

When I scan A2DP capabilities of Nokia N900 I get following output:

$ ./tools/avinfo XX:XX:XX:XX:XX:XX
Connecting ...=20
Stream End-Point #1: Audio Source=20
        Media Codec: SBC
                Channel Modes: Mono DualChannel Stereo JointStereo
                Frequencies: 16Khz 32Khz 44.1Khz 48Khz=20
                Subbands: 4 8
                Blocks: 4 8 12 16=20
                Bitpool Range: 2-64
Stream End-Point #2: Audio Sink=20
        Media Codec: SBC
                Channel Modes: Mono DualChannel Stereo JointStereo
                Frequencies: 16Khz 32Khz 44.1Khz 48Khz=20
                Subbands: 4 8
                Blocks: 4 8 12 16=20
                Bitpool Range: 2-64=20

$ qdbus --system org.bluez
/
/org
/org/bluez
/org/bluez/hci0
/org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX
/org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/fd2
/org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/player0
/org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/sep1
/org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/sep2
/org/bluez/test

So there is one SEP as Audio Source and one SEP as Audio Sink.

But when I ask sep1 and sep2 for UUID via dbus, I get that both are just
Audio Sinks:

$ qdbus --system org.bluez /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/sep1 org.b=
luez.MediaEndpoint1.UUID
0000110a-0000-1000-8000-00805f9b34fb

$ qdbus --system org.bluez /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/sep2 org.b=
luez.MediaEndpoint1.UUID
0000110a-0000-1000-8000-00805f9b34fb

So this is a clear bug.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--5alpeweq3yat3hhw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXKeGjgAKCRCL8Mk9A+RD
UtJQAJ9fOwtoeSJk/aHYmSf0DV3xzH8KqACeJ7HUc3RnQ6pNn51Dbd36v+FqhEA=
=nWDJ
-----END PGP SIGNATURE-----

--5alpeweq3yat3hhw--
