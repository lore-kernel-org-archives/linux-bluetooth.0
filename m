Return-Path: <SRS0=Uexg=X7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA7BC10F14
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Oct 2019 18:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677992067B
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Oct 2019 18:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eB6R++BY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfJFSC5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Oct 2019 14:02:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41051 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbfJFSC5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Oct 2019 14:02:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id q9so12584538wrm.8
        for <linux-bluetooth@vger.kernel.org>; Sun, 06 Oct 2019 11:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nyDrxPo7x6/1wFL2VNcT0IbnYZ5Y4Qgd3DtleCuNED8=;
        b=eB6R++BYea5TqVl2/4+GSfpN1dMQ30xKGJnn2aC1enLlg2I5+r3PFVRUmpfFEnSCXY
         JOdl4LelnuSjAKQgVF1TAqMVKwaGt3Ayxi3vRIPEe0h7gi1FzdpuFWKVLgQ9zn1yDKP7
         yI2umQhQBwtL9p6b9ep+8K+RYojMn2BVjmIXP4ehAw1VRMAHGJdcTEGZNJ1Nb5X+uFsZ
         E1QbvL5j0MVolyz1eeRicwvXjWrkEnBgPGe8Uac29jogOkLNjtxkam+C84GYuULnm/J1
         b/zq1r2G5lfarEpvmUt6zcWObaPufDsfqjIoD3fIML3iAl5ZDPRuLnqNrAtdTDwuyiE/
         AKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nyDrxPo7x6/1wFL2VNcT0IbnYZ5Y4Qgd3DtleCuNED8=;
        b=lxzPrLPsviySJ1x+bPnjACldsRF08bMa3oPgaQS/+34s5XcfKx6bPz827V0NwN9COB
         4uZWs4Gv9kMHer67TpJPHy7TLZJX0F5oQCKCgwXIX1ZhbQeHOSCLsZaknxkZjSmwiy9Z
         Ys+B887l2T09KMYf3CZUYPboRYH4WUTdqMGSFwbF/hCejDA4EAaNxOuGkkLOdf7XL8Lc
         dpjKiARr3sIqnyjUxX2yh/p10iqbQCC7K1h3I15cXUOoq1zFzK877Mav5YhmLQ9VFnKR
         Zp6s2XxWzTsy1jzkEIOTmWTatlzAdBjMZOFpyuqUybxNS3FdS26774GqWJ/zDdfUxJVr
         K2Bw==
X-Gm-Message-State: APjAAAVSPw9W/mlkMsiggBo/u0E/QEl6odkotORXLwrHsyF+IhARDxcM
        L4exuDeAsDrANnB1xvkETSM=
X-Google-Smtp-Source: APXvYqxdudZVmXDo0GjDE+0552B1PBiI3gap7dS3igFupRZRK3r9m5TZwU2MPvmkfOHvVS/K6Qdhlg==
X-Received: by 2002:a5d:4d87:: with SMTP id b7mr20535784wru.148.1570384974248;
        Sun, 06 Oct 2019 11:02:54 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id l6sm14553030wmg.2.2019.10.06.11.02.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 Oct 2019 11:02:53 -0700 (PDT)
Date:   Sun, 6 Oct 2019 20:02:52 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Pasi =?utf-8?B?S8Okcmtrw6RpbmVu?= <pasik@iki.fi>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 1/4] doc/media-api: Add RegisterApplication method
Message-ID: <20191006180252.7bfil4lblfzakzyy@pali>
References: <20190721155522.3vqt7vsprhpxflqf@pali>
 <CABBYNZK6cuz9n4Hu9uRCbQvn9uFEYkn9=mY8J5Fqu0u-D3B1EA@mail.gmail.com>
 <20190829125734.GH2840@reaktio.net>
 <20190829200513.6xnta5jx3trbmgxp@pali>
 <20191003181855.GF28704@reaktio.net>
 <20191006100503.fsbttcschr6wgsdq@pali>
 <CABBYNZLS4MMxJ=gQED-BVfn81D0bvx8aLw5OO3tNmXAnWeA57Q@mail.gmail.com>
 <20191006105653.joky4pzkwtnntiwo@pali>
 <CABBYNZLwgZfXf9BhhSJOTvU_-shhj_52YMbYmyhBBNf75OhOsQ@mail.gmail.com>
 <20191006111700.42kcgojrzwru2et6@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="65b7va2ju4we7g3a"
Content-Disposition: inline
In-Reply-To: <20191006111700.42kcgojrzwru2et6@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--65b7va2ju4we7g3a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sunday 06 October 2019 13:17:00 Pali Roh=C3=A1r wrote:
> On Sunday 06 October 2019 14:14:18 Luiz Augusto von Dentz wrote:
> > Hi Pali,
> >=20
> > On Sun, Oct 6, 2019 at 1:56 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> w=
rote:
> > >
> > > On Sunday 06 October 2019 13:53:37 Luiz Augusto von Dentz wrote:
> > > > Hi Pali,
> > > >
> > > > On Sun, Oct 6, 2019 at 1:05 PM Pali Roh=C3=A1r <pali.rohar@gmail.co=
m> wrote:
> > > > >
> > > > > On Thursday 03 October 2019 21:18:55 Pasi K=C3=A4rkk=C3=A4inen wr=
ote:
> > > > > > Hi,
> > > > > >
> > > > > > On Thu, Aug 29, 2019 at 10:05:13PM +0200, Pali Roh=C3=A1r wrote:
> > > > > > > On Thursday 29 August 2019 15:57:34 Pasi K=C3=A4rkk=C3=A4inen=
 wrote:
> > > > > > > > Pali: How does it look with porting the PA patches to use t=
he new interfaces?
> > > > > > >
> > > > > > > Hello, I have not had a time yet to play with these pulseaudi=
o patches
> > > > > > > and porting to the new interface. I guess that I could have m=
ore free
> > > > > > > time in the last week of next month.
> > > > > > >
> > > > > >
> > > > > > It seems BlueZ 5.51 has been released meanwhile (http://www.blu=
ez.org/release-of-bluez-5-51/)
> > > > > > So now at least the new interfaces are in a released bluez vers=
ion.
> > > > >
> > > > > Ok! Today I have looked at this new Bluez API, but seems that the=
re is
> > > > > not only missing some examples or usages with libdbus-1, but also
> > > > > documentation. I have tried to find something how to register end=
points
> > > > > throw GetManagedObjects() via libdbus-1, but seems that there is =
no
> > > > > usage of it and also unusable documentation for it in libdbus-1. =
So
> > > > > currently I'm stuck how to use this exotic API in pulseaudio...
> > > >
> > > > It is just another D-Bus method, the only difference is that it
> > > > carries the entire object tree, btw I did add an example of how to
> > > > register Endpoints in python:
> > > >
> > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/exampl=
e-endpoint
> > >
> > > Now I found this python example and currently I'm doing observations =
and
> > > "reverse-engineering" how it is working and how this example behaves =
on
> > > D-Bus. I think I understood it now.
> >=20
> > One important detail is that RegisterApplication shall not block since
> > the daemon will call GetManagedObjects the D-Bus mainloop must be able
> > to process messages.
>=20
> Ok. I'm already using non-blocking / async processing as blocking
> variants can cause more problems in event-orientated applications.

Now I implemented it in pulseaudio. New patches are now available in
pulseaudio-discuss@lists.freedesktop.org mailing list.

> > > > You can also have a look at how our gdbus internal library (uses
> > > > libdbus) utilize it:
> > > >
> > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/gdbus/clien=
t.c#n1269
> > > >
> > >
> > > --
> > > Pali Roh=C3=A1r
> > > pali.rohar@gmail.com
> >=20
> >=20
> >=20
>=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--65b7va2ju4we7g3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXZosSgAKCRCL8Mk9A+RD
UgA+AJ0RyGdlRPVM2mlLcmOh32x/24d+vACeNTpBlr0iSyajbGsXAaBnjMG/q+E=
=421F
-----END PGP SIGNATURE-----

--65b7va2ju4we7g3a--
