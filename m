Return-Path: <SRS0=Rr1U=P5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D95C31681
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jan 2019 18:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB83D20989
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jan 2019 18:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2Pg842T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfAUSaZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Jan 2019 13:30:25 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55045 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfAUSaZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Jan 2019 13:30:25 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so11780710wmh.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jan 2019 10:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SL4DY6nUh8twiGMB3JgFFzCsjMQs8P/G5ab+getxwY0=;
        b=N2Pg842TQ0ngkXxnK5113uP+6yudh+boyuS5D8EhEQuxG6KuMlnnliSaXGY3zFIQdc
         pH4CGhAcQ9GjYUUr8JYz0L5TqrN2lsVH5FuZpefwn20SUq8Sh3ud3mIe+TjzlPgEyljs
         i6IZ3iUh+Cm5s+oT8bkYc26ZMhBgMklWakE6zVkh2qIhnYKQJMV4ctS5ryl3QBQoWAAw
         32e1ttjpdxK4IVwt8RVYF/KwZYiy/etAD6Y7Rk8grYskIRyOw98junltj2NgCAMxitKb
         ea2sk07WLQ53oOEwfVUSP00G/HyTfbELdws9Op4pTnNEcpJxCdkwlwD1F0QrImyrreGX
         ciTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SL4DY6nUh8twiGMB3JgFFzCsjMQs8P/G5ab+getxwY0=;
        b=QQiWNuBGglC39tNI3W53RnNG/VE1YmqOFR7DbArnNgtBXbPvUBgNAXyJw7N19xHm0W
         tZbYQ6fRsnP4YQLoRe4PMa5CVVC+5IY149QRJro1l23SOGbE5VsTS0McUjchl1mwKrOJ
         3UQqbMY1R1LFkZV806hW/a4OXyXpb85WxdSbeOZg3Pt1n/57Z7CbUO4xSnoE6uIMGwUQ
         BEZZ56atixAQmuET7U5HMVO6GevpWBctL9snVb6IsJyHbysZPtOzNrUjAiDsRuPdbsoU
         TUq2VGW8piD1wBEgU0KQ44myOf/JolTe1asGcTsfjcO8Nhw6dufBM1GUTGrJ5QWTspDu
         yNvQ==
X-Gm-Message-State: AJcUukefXUp99V/gmfENBIvobIkhyXWrKHBUtWKGxyLFLjMJIyOvIv6q
        7gHM48Ia8Hiq8kJ/Z00BNP4=
X-Google-Smtp-Source: ALg8bN5+uPRkia0RPjO7fDDJ3JpEzSbXrQUFTkzrAISjCO6yokOK6c0u4+m9HwR+OAf783d25RQxbQ==
X-Received: by 2002:a1c:38c4:: with SMTP id f187mr494025wma.90.1548095422765;
        Mon, 21 Jan 2019 10:30:22 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id n127sm57957103wmd.20.2019.01.21.10.30.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 10:30:21 -0800 (PST)
Date:   Mon, 21 Jan 2019 19:30:16 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Pasi =?utf-8?B?S8Okcmtrw6RpbmVu?= <pasik@iki.fi>
Subject: Re: [PATCH v2 1/8] doc/media-api: Enable MediaEndpoint to expose
 remote SEP
Message-ID: <20190121183016.jiqrtw3csllmqhif@pali>
References: <20190115141023.353-1-luiz.dentz@gmail.com>
 <CABBYNZLL7Usr=bS2rcJCCV6STVwi9ywq3Om6jkF8cfB8GC6mcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="h7lq53lunsot2zyv"
Content-Disposition: inline
In-Reply-To: <CABBYNZLL7Usr=bS2rcJCCV6STVwi9ywq3Om6jkF8cfB8GC6mcA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--h7lq53lunsot2zyv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Monday 21 January 2019 20:25:41 Luiz Augusto von Dentz wrote:
> Hi,
> On Tue, Jan 15, 2019 at 4:12 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This adds the possibility to expose remote SEP using MediaEndpoint
> > interface to allow setting a configuration.
> > ---
> >  doc/media-api.txt | 27 +++++++++++++++++++++++++--
> >  1 file changed, 25 insertions(+), 2 deletions(-)
> >
> > diff --git a/doc/media-api.txt b/doc/media-api.txt
> > index b5ad2db12..af9485342 100644
> > --- a/doc/media-api.txt
> > +++ b/doc/media-api.txt
> > @@ -500,14 +500,23 @@ Properties        object Player [readonly]
> >  MediaEndpoint1 hierarchy
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >
> > -Service                unique name
> > +Service                unique name (Server role)
> > +               org.bluez (Client role)
> >  Interface      org.bluez.MediaEndpoint1
> > -Object path    freely definable
> > +Object path    freely definable (Server role)
> > +               [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX=
/sepX
> > +               (Client role)
> >
> >  Methods                void SetConfiguration(object transport, dict pr=
operties)
> >
> >                         Set configuration for the transport.
> >
> > +                       For client role transport must be set with a se=
rver
> > +                       endpoint oject which will be configured and the
> > +                       properties must contain the following propertie=
s:
> > +
> > +                               array{byte} Capabilities
> > +
> >                 array{byte} SelectConfiguration(array{byte} capabilitie=
s)
> >
> >                         Select preferable configuration from the suppor=
ted
> > @@ -532,6 +541,20 @@ Methods            void SetConfiguration(object tr=
ansport, dict properties)
> >                         endpoint, because when this method gets called =
it has
> >                         already been unregistered.
> >
> > +Properties     string UUID [readonly, optional]:
> > +
> > +                       UUID of the profile which the endpoint is for.
> > +
> > +               byte Codec [readonly, optional]:
> > +
> > +                       Assigned number of codec that the endpoint impl=
ements.
> > +                       The values should match the profile specificati=
on which
> > +                       is indicated by the UUID.
> > +
> > +               array{byte} Capabilities [readonly, optional]:
> > +
> > +                       Capabilities blob, it is used as it is so the s=
ize and
> > +                       byte order must match.
> >
> >  MediaTransport1 hierarchy
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > --
> > 2.17.2
>=20
> Are there any comments for this set? Notice that I did include the
> device path in this set so there is no need to hack to guess what
> device the endpoint belongs to.

I did not know about V2 as I'm not subscribed to list. I tested and used
with PA only V1.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--h7lq53lunsot2zyv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXEYPtgAKCRCL8Mk9A+RD
Us6HAKCBONDWiyJGFG9jwKckamnHSPtn9gCfVAieEa0rK+AnuTN3hpi2/9d0TT8=
=tGEd
-----END PGP SIGNATURE-----

--h7lq53lunsot2zyv--
