Return-Path: <SRS0=AkUh=SV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D29FC282DA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Apr 2019 19:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583F02171F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Apr 2019 19:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIrWbjJ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfDSTfs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:35:48 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51574 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfDSTfr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Apr 2019 15:35:47 -0400
Received: by mail-wm1-f66.google.com with SMTP id 4so7198162wmf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2019 12:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8refgkCJ2d03ouxPRYA8g+PBkPVf5HShopTar0Cuivg=;
        b=UIrWbjJ0GB7icjtAgWZAs/a+InDmzyf6T5Zqyf+1kNi/f/D5Ok4fTZm6tJoLlbiJU8
         x/d/pzmisssNqLl1HApWy/82VV3P5aqjayuS6FCTV+vI++0KbEChR6lNtEBo7MTe7qeb
         jHGSvdwi19AfZLH8ymJop6fEWKODYFBbdE4RO9O1nhXiYC+3/2ID1oI9imvVbwcbkEUd
         dMCkTeCjWF3EYSvLGA9s10BQvzZmxY0F6aUtIw1LGvOaVv6Y+491DtbHotqFLkM8BSm6
         qJXwKDraQEdTo7N+CbJdbDfUuLRHjZrZ7F7pEwN9H06zeDyoY2wGpRh/5GdLthyBy/Jl
         5FQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8refgkCJ2d03ouxPRYA8g+PBkPVf5HShopTar0Cuivg=;
        b=MMxAkhpuxDiY/D2vEmcK8rT0PulssSqT9G9e4f0W0ijHE7IeSBZ9ZBWwZAIvc6wNaE
         C2hsd809eZqyeJzjf4v6YtOozsAy4b13Jumey1TjrpoGQB7FmwX9Wt9EfOtfpZrNibgD
         wqIjHwBksMIUSPGpmbfshHjVOlLAtKrcYAgH0xn1TAXxMnpo3NBYG4fkSLNApICPRwoy
         eqYy+4tOOo8ZwW1CFtbxka2ZI/o3i0QRog9dgSIuMmtuT50LlpqFXydzXWEiNuE43MaH
         uGCsaIREchPxSsaogcyQNbNLfJlqCK/76udEvyUuuzRNKGV01PoF5kL1Ew1xD3Ogg+kL
         hDvA==
X-Gm-Message-State: APjAAAXfO9p4PO1jA/t4bsnqJM+iYWD6uXiwNRp57dJnHI12ewI9qnRC
        WDToYo4KsOPj9AamGCujGV4sngxY
X-Google-Smtp-Source: APXvYqzNbO9d74chVWRYCivgTH14pfXSoX+HnFHB4261AdropNwMu6+7HrkgI/A7poKbs7xvE66ycw==
X-Received: by 2002:a1c:5543:: with SMTP id j64mr2299040wmb.37.1555671721714;
        Fri, 19 Apr 2019 04:02:01 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id b11sm4491884wru.61.2019.04.19.04.02.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 04:02:00 -0700 (PDT)
Date:   Fri, 19 Apr 2019 13:01:59 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3 1/9] doc/media-api: Enable MediaEndpoint to expose
 remote SEP
Message-ID: <20190419110159.7tec3yejhh4lnokb@pali>
References: <20190122134524.20509-1-luiz.dentz@gmail.com>
 <CABBYNZLCFpXhbAnVYaA-nVNOY8QRvpR1UZhMHfy-awZxtpSocQ@mail.gmail.com>
 <20190122175622.dj6riiim6zukpetw@pali>
 <CABBYNZJGLGnNzXC_Q+Visk1XPwP9FX+BvJ65UQMj4tMJfL92+Q@mail.gmail.com>
 <20190127020038.q3hm5h7xl2ku6fse@pali>
 <20190327111430.6gliqodnnojsifjd@pali>
 <20190419080348.fbgs55qqs3j2yovb@pali>
 <CABBYNZLNBFVNh42eQ-SDeRPKpS96AUdOsoN3jqZgHSvHfRwxOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="up6v2ytndp3avjvt"
Content-Disposition: inline
In-Reply-To: <CABBYNZLNBFVNh42eQ-SDeRPKpS96AUdOsoN3jqZgHSvHfRwxOQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--up6v2ytndp3avjvt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Friday 19 April 2019 13:04:01 Luiz Augusto von Dentz wrote:
> Hi Pali,
>=20
> On Fri, Apr 19, 2019 at 11:03 AM Pali Roh=C3=A1r <pali.rohar@gmail.com> w=
rote:
> >
> > On Wednesday 27 March 2019 12:14:30 Pali Roh=C3=A1r wrote:
> > > On Sunday 27 January 2019 03:00:38 Pali Roh=C3=A1r wrote:
> > > > On Wednesday 23 January 2019 13:24:22 Luiz Augusto von Dentz wrote:
> > > > > Hi Pali,
> > > > > On Tue, Jan 22, 2019 at 7:56 PM Pali Roh=C3=A1r <pali.rohar@gmail=
=2Ecom> wrote:
> > > > > >
> > > > > > On Tuesday 22 January 2019 16:20:12 Luiz Augusto von Dentz wrot=
e:
> > > > > > > Hi Pali,
> > > > > > > On Tue, Jan 22, 2019 at 3:45 PM Luiz Augusto von Dentz
> > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > >
> > > > > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > > > > >
> > > > > > > > This adds the possibility to expose remote SEP using MediaE=
ndpoint
> > > > > > > > interface to allow setting a configuration.
> > > > > > > > ---
> > > > > > > >  doc/media-api.txt | 27 +++++++++++++++++++++++++--
> > > > > > > >  1 file changed, 25 insertions(+), 2 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/doc/media-api.txt b/doc/media-api.txt
> > > > > > > > index b5ad2db12..af9485342 100644
> > > > > > > > --- a/doc/media-api.txt
> > > > > > > > +++ b/doc/media-api.txt
> > > > > > > > @@ -500,14 +500,23 @@ Properties        object Player [read=
only]
> > > > > > > >  MediaEndpoint1 hierarchy
> > > > > > > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > > > > > >
> > > > > > > > -Service                unique name
> > > > > > > > +Service                unique name (Server role)
> > > > > > > > +               org.bluez (Client role)
> > > > > > > >  Interface      org.bluez.MediaEndpoint1
> > > > > > > > -Object path    freely definable
> > > > > > > > +Object path    freely definable (Server role)
> > > > > > > > +               [variable prefix]/{hci0,hci1,...}/dev_XX_XX=
_XX_XX_XX_XX/sepX
> > > > > > > > +               (Client role)
> > > > > > > >
> > > > > > > >  Methods                void SetConfiguration(object transp=
ort, dict properties)
> > > > > > > >
> > > > > > > >                         Set configuration for the transport.
> > > > > > > >
> > > > > > > > +                       For client role transport must be s=
et with a server
> > > > > > > > +                       endpoint oject which will be config=
ured and the
> > > > > > > > +                       properties must contain the followi=
ng properties:
> > > > > > > > +
> > > > > > > > +                               array{byte} Capabilities
> > > > > > > > +
> > > > > > > >                 array{byte} SelectConfiguration(array{byte}=
 capabilities)
> > > > > > > >
> > > > > > > >                         Select preferable configuration fro=
m the supported
> > > > > > > > @@ -532,6 +541,20 @@ Methods            void SetConfigurati=
on(object transport, dict properties)
> > > > > > > >                         endpoint, because when this method =
gets called it has
> > > > > > > >                         already been unregistered.
> > > > > > > >
> > > > > > > > +Properties     string UUID [readonly, optional]:
> > > > > > > > +
> > > > > > > > +                       UUID of the profile which the endpo=
int is for.
> > > > > > > > +
> > > > > > > > +               byte Codec [readonly, optional]:
> > > > > > > > +
> > > > > > > > +                       Assigned number of codec that the e=
ndpoint implements.
> > > > > > > > +                       The values should match the profile=
 specification which
> > > > > > > > +                       is indicated by the UUID.
> > > > > > > > +
> > > > > > > > +               array{byte} Capabilities [readonly, optiona=
l]:
> > > > > > > > +
> > > > > > > > +                       Capabilities blob, it is used as it=
 is so the size and
> > > > > > > > +                       byte order must match.
> > > > > > > >
> > > > > > > >  MediaTransport1 hierarchy
> > > > > > > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > > > > > > --
> > > > > > > > 2.17.2
> > > > > > >
> > > > > > > Can you try this set?
> > > > > >
> > > > > > Hi! In V3 you added only "a2dp: Add reverse discovery" patch ri=
ght?
> > > > > > I tested my setup also with this patch and there is no differen=
ce,
> > > > > > pulseaudio is working fine :-)
> > > > > >
> > > > >
> > > > > Applied.
> > > >
> > > > Hi! I have one bug report for these patches.
> > > >
> > > > When I manually disconnect A2DP profile, but let HFP active then al=
l SEP
> > > > paths on D-Bus disappear.
> > > >
> > > >   qdbus --system org.bluez /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX or=
g.bluez.Device1.DisconnectProfile 0000110b-0000-1000-8000-00805f9b34fb
> > > >
> > > > So pulseaudio would still see bluetooth device as active (because H=
FP is
> > > > in use), but does not see any A2DP codec as all remote SEPs from DB=
us
> > > > were removed.
> > > >
> > > > It is possible to not remove remote SEPs when A2DP sink profile is
> > > > manually disconnected?
> > >
> > > Hi Luiz! Have you looked at above problem?
> >
> > Hi! This one problem is still there.
>=20
> This should have been fixed:
>=20
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=3D9f7659a44=
601e043bdb6724b0ab4f3f59c46e9fe

Hi! It is still not fixed. I have that commit applied (it is in master
branch), but SEPs still disappears from dbus after calling
DisconnectProfile 0000110b-0000-1000-8000-00805f9b34fb as described
above; even HFP/HSP is still active.

Can you reproduce that problem?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--up6v2ytndp3avjvt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXLmqpQAKCRCL8Mk9A+RD
UvOyAJ90cZFp5fal+b/DKbqk84i1ilY5iQCeLVi7eimUHzREKqCvQtOSGO+hJc8=
=6fTt
-----END PGP SIGNATURE-----

--up6v2ytndp3avjvt--
