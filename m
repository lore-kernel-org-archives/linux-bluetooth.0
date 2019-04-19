Return-Path: <SRS0=AkUh=SV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED58BC282DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Apr 2019 20:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC96F2171F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Apr 2019 20:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIV5v7s5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfDSUKq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:10:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46675 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfDSUKq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Apr 2019 16:10:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id t17so8049905wrw.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2019 13:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aXlTPk2ELLu0hdH1gunLLyvudW2rk6E+Ho/A14OmHjE=;
        b=GIV5v7s5KWJrQbIjuZfHeXjNWFmNVlMgIyvOQ5llelMu8rEwAiTwpG5zaumhdoVFS6
         oNdFuzTF1D9oIJHD39AssqfaatTBBmQ2uk1cFE/N+c9MIskhRa6LKO2n94Z5x6DN5yLs
         cF/OEk9r910CZMfVD3IIAhWf/MRC6KUIcLfkgoAyKYH2WGejoCNnP/xEE8PNocEhhqeo
         E3/JmXEyBaF6RzEVOXJLuZSNz0jhuAK3knN+6tJga43bH/qKMGy5cy/1UZtssWjeHpqq
         dQhIS+p4crXqjTmbBEt2NmM1SfguByGAbeA3HlpRGpyVXtexK/7GDMt+rWzlWljjzYrr
         t0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aXlTPk2ELLu0hdH1gunLLyvudW2rk6E+Ho/A14OmHjE=;
        b=TfIt3et8pdxVGEIHoqhfX5y8S3bJvYfv7PaQ81yjdc3e2AQA72HmM0HfMhB1tj3t3f
         NqISa5wlXrllJOLwSWmyivTJJHRdVa4r1r1zCSSTC1vZbGlaOaFenynOdMrGM6FhCfsM
         ayZYvbsys1lhtB/Mcor8Jwde91epECDZptLUVqtSgtXW1kYldQpg9G7YlOUGNdbyQiXu
         xt492taEm+i+A45gs9hHWGIUNs17gFlRRghK4YgQsvYW1/Za2dhQBJtVamgfXBaZT7jr
         1HZa6uj/189tHdy97fWlys8I99tSLcmNxhuW8MTVLNRUz/Gz9V1uoA1CcMjOaLfeUWxN
         vShQ==
X-Gm-Message-State: APjAAAU9JbbkAcf4L1pLlDGMy1yDj01GemPaEhBrML45c/nh8X6tWTP6
        Jltn15up4wfC6bpWV0VKys2UppZ2
X-Google-Smtp-Source: APXvYqzzbOAFI+XGV114Hl6pHazP81AQ/+Cd5MtVnJ3MDNmEem+bBXENLuejkw+dpjZLJZ/eUrpMLA==
X-Received: by 2002:a5d:56c6:: with SMTP id m6mr1847200wrw.211.1555661029947;
        Fri, 19 Apr 2019 01:03:49 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id r196sm3288809wmf.22.2019.04.19.01.03.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 01:03:49 -0700 (PDT)
Date:   Fri, 19 Apr 2019 10:03:48 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3 1/9] doc/media-api: Enable MediaEndpoint to expose
 remote SEP
Message-ID: <20190419080348.fbgs55qqs3j2yovb@pali>
References: <20190122134524.20509-1-luiz.dentz@gmail.com>
 <CABBYNZLCFpXhbAnVYaA-nVNOY8QRvpR1UZhMHfy-awZxtpSocQ@mail.gmail.com>
 <20190122175622.dj6riiim6zukpetw@pali>
 <CABBYNZJGLGnNzXC_Q+Visk1XPwP9FX+BvJ65UQMj4tMJfL92+Q@mail.gmail.com>
 <20190127020038.q3hm5h7xl2ku6fse@pali>
 <20190327111430.6gliqodnnojsifjd@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="t2vhlk37gg34rafd"
Content-Disposition: inline
In-Reply-To: <20190327111430.6gliqodnnojsifjd@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--t2vhlk37gg34rafd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday 27 March 2019 12:14:30 Pali Roh=C3=A1r wrote:
> On Sunday 27 January 2019 03:00:38 Pali Roh=C3=A1r wrote:
> > On Wednesday 23 January 2019 13:24:22 Luiz Augusto von Dentz wrote:
> > > Hi Pali,
> > > On Tue, Jan 22, 2019 at 7:56 PM Pali Roh=C3=A1r <pali.rohar@gmail.com=
> wrote:
> > > >
> > > > On Tuesday 22 January 2019 16:20:12 Luiz Augusto von Dentz wrote:
> > > > > Hi Pali,
> > > > > On Tue, Jan 22, 2019 at 3:45 PM Luiz Augusto von Dentz
> > > > > <luiz.dentz@gmail.com> wrote:
> > > > > >
> > > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > > >
> > > > > > This adds the possibility to expose remote SEP using MediaEndpo=
int
> > > > > > interface to allow setting a configuration.
> > > > > > ---
> > > > > >  doc/media-api.txt | 27 +++++++++++++++++++++++++--
> > > > > >  1 file changed, 25 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/doc/media-api.txt b/doc/media-api.txt
> > > > > > index b5ad2db12..af9485342 100644
> > > > > > --- a/doc/media-api.txt
> > > > > > +++ b/doc/media-api.txt
> > > > > > @@ -500,14 +500,23 @@ Properties        object Player [readonly]
> > > > > >  MediaEndpoint1 hierarchy
> > > > > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > > > > >
> > > > > > -Service                unique name
> > > > > > +Service                unique name (Server role)
> > > > > > +               org.bluez (Client role)
> > > > > >  Interface      org.bluez.MediaEndpoint1
> > > > > > -Object path    freely definable
> > > > > > +Object path    freely definable (Server role)
> > > > > > +               [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_=
XX_XX_XX/sepX
> > > > > > +               (Client role)
> > > > > >
> > > > > >  Methods                void SetConfiguration(object transport,=
 dict properties)
> > > > > >
> > > > > >                         Set configuration for the transport.
> > > > > >
> > > > > > +                       For client role transport must be set w=
ith a server
> > > > > > +                       endpoint oject which will be configured=
 and the
> > > > > > +                       properties must contain the following p=
roperties:
> > > > > > +
> > > > > > +                               array{byte} Capabilities
> > > > > > +
> > > > > >                 array{byte} SelectConfiguration(array{byte} cap=
abilities)
> > > > > >
> > > > > >                         Select preferable configuration from th=
e supported
> > > > > > @@ -532,6 +541,20 @@ Methods            void SetConfiguration(o=
bject transport, dict properties)
> > > > > >                         endpoint, because when this method gets=
 called it has
> > > > > >                         already been unregistered.
> > > > > >
> > > > > > +Properties     string UUID [readonly, optional]:
> > > > > > +
> > > > > > +                       UUID of the profile which the endpoint =
is for.
> > > > > > +
> > > > > > +               byte Codec [readonly, optional]:
> > > > > > +
> > > > > > +                       Assigned number of codec that the endpo=
int implements.
> > > > > > +                       The values should match the profile spe=
cification which
> > > > > > +                       is indicated by the UUID.
> > > > > > +
> > > > > > +               array{byte} Capabilities [readonly, optional]:
> > > > > > +
> > > > > > +                       Capabilities blob, it is used as it is =
so the size and
> > > > > > +                       byte order must match.
> > > > > >
> > > > > >  MediaTransport1 hierarchy
> > > > > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > > > > --
> > > > > > 2.17.2
> > > > >
> > > > > Can you try this set?
> > > >
> > > > Hi! In V3 you added only "a2dp: Add reverse discovery" patch right?
> > > > I tested my setup also with this patch and there is no difference,
> > > > pulseaudio is working fine :-)
> > > >
> > >=20
> > > Applied.
> >=20
> > Hi! I have one bug report for these patches.
> >=20
> > When I manually disconnect A2DP profile, but let HFP active then all SEP
> > paths on D-Bus disappear.
> >=20
> >   qdbus --system org.bluez /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX org.bl=
uez.Device1.DisconnectProfile 0000110b-0000-1000-8000-00805f9b34fb
> >=20
> > So pulseaudio would still see bluetooth device as active (because HFP is
> > in use), but does not see any A2DP codec as all remote SEPs from DBus
> > were removed.
> >=20
> > It is possible to not remove remote SEPs when A2DP sink profile is
> > manually disconnected?
>=20
> Hi Luiz! Have you looked at above problem?

Hi! This one problem is still there.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--t2vhlk37gg34rafd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXLmA4gAKCRCL8Mk9A+RD
Uo/sAKCiXDr0nkIvsvULSWj+goNcV4pkhwCeLNLo0WZmyVnRnk4TuT+EvSq7THE=
=U4vo
-----END PGP SIGNATURE-----

--t2vhlk37gg34rafd--
