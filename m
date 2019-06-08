Return-Path: <SRS0=Jazt=UH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAFBC28CC5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  8 Jun 2019 10:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD73208E3
	for <linux-bluetooth@archiver.kernel.org>; Sat,  8 Jun 2019 10:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jow9HDgW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfFHK73 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 8 Jun 2019 06:59:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43242 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfFHK72 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 8 Jun 2019 06:59:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id r18so4540330wrm.10
        for <linux-bluetooth@vger.kernel.org>; Sat, 08 Jun 2019 03:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MsiFjnUSWppmKe9VajkXEEt0Mscb8SE58K4UqlHM4Hc=;
        b=jow9HDgWeoZb9L8PNS/KdnnzqMYj22E9RPFrUbBQ7f4zWmF9gK10/lWyYoaVkNfD4O
         /ljELef85QqS82omVi4P/15X9xWzdHmJWDsu6PuuLqLMGcQXhtxyidwuTOAsYTf1enCb
         iYJwwdQfcVrxs/dUe8H01eopueJgGw6oE15/+kTM3MOcjkgnQpoCNMu91W8UfdHJI2BA
         coblLNmtNSMAaRpVTjad0GQJpW4fMO1snUYwdBjiJGF+ZwbCY51kdqfz+oMQJxd9xVHt
         FbtoyqtYoDpAQil/Yv/proNSoKwhtYnkImY+82612pGP1DYs4VesppClfwUZP7oxhurq
         ekAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MsiFjnUSWppmKe9VajkXEEt0Mscb8SE58K4UqlHM4Hc=;
        b=cFhlnued+ItENQg+48nBvSWXs2DYpBiI6AWfTTmWHDBBOTyyG/U7KSiQ7mV4ivh+gn
         0wGTCoM2MKCJ+C3NGIHuF0Irnsldlbqxb9CcN2cCFMQGdxIKwnI/6yZ4pLuFZLgfe+n7
         VYGFiIq4Ej3ozwf9uocg5ffimCsmOQE6t2WzU3GL2rzo+SB9Zy1ow4IwAh3oJF1i+5tC
         BTltpWszGJXyBUpvzsjDp8zyHnzfS6twyHfd3J6aNJ4KxgooqyV54bwBtjFwvHB8rK8M
         55v9LdC7znll54WAENDmaQzTV/k3dRHbADBDkS3PmMhlc5ZROPqd0jcA3KY51i+lRCrN
         J5RA==
X-Gm-Message-State: APjAAAXjhtUAqI8Ge0/W8bwMfO3jk0Pepyu0UF4SBLQ7hLdvikJkuIuU
        P698HyH+iBQyp+v+PXJAEkM=
X-Google-Smtp-Source: APXvYqxI3Fw6J8YS5ueID9uE4wvcih1J+1Oor0xMFFNkib6K+mxdytrVYHZd9PyjRoqgs2c1mxwoyw==
X-Received: by 2002:a5d:42c5:: with SMTP id t5mr22198764wrr.5.1559991566215;
        Sat, 08 Jun 2019 03:59:26 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id q20sm12536611wra.36.2019.06.08.03.59.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Jun 2019 03:59:25 -0700 (PDT)
Date:   Sat, 8 Jun 2019 12:59:24 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez - check for new a2dp features
Message-ID: <20190608105924.qmauvrwyz7nofx74@pali>
References: <20190513170550.bsbr2mh7w36hj7io@pali>
 <20190607125800.trsx2o3njaiaitu2@pali>
 <CABBYNZLtgaCi5VGHapsKQG4iAC33ySow3AuH0Qkx8iCo3LcZDg@mail.gmail.com>
 <20190607153715.w5exsodd25qxc6xv@pali>
 <CABBYNZ+gPRkAgFAeeoSqZ7tp5fYimGdju9JSuSpn_kL+f9hJhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="nvdnvowfvjmgnafh"
Content-Disposition: inline
In-Reply-To: <CABBYNZ+gPRkAgFAeeoSqZ7tp5fYimGdju9JSuSpn_kL+f9hJhQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--nvdnvowfvjmgnafh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Saturday 08 June 2019 13:56:29 Luiz Augusto von Dentz wrote:
> Hi Pali,
>=20
> On Fri, Jun 7, 2019 at 6:37 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
> >
> > On Friday 07 June 2019 18:26:02 Luiz Augusto von Dentz wrote:
> > > Hi Pali,
> > >
> > > On Fri, Jun 7, 2019 at 3:58 PM Pali Roh=C3=A1r <pali.rohar@gmail.com>=
 wrote:
> > > >
> > > > On Monday 13 May 2019 19:05:50 Pali Roh=C3=A1r wrote:
> > > > > Hello!
> > > > >
> > > > > In current git bluez master repository are new features related t=
o A2DP.
> > > > > E.g. support for codec switching or fallback to other local dbus
> > > > > endpoints when current selected rejected connection...
> > > > >
> > > > > Moreover codec switching support is behind experimental runtime s=
witch.
> > > > >
> > > > > For pulseaudio a2dp module I need to do runtime check if above fe=
atures
> > > > > are supported by currently running bluez instance (which register=
ed to
> > > > > dbus org.bluez. It is needed to ensure that pulseaudio does not
> > > > > introduce regression for older bluez version without above new A2=
DP
> > > > > features.
> > > > >
> > > > > But currently I have not found any way how to detect if bluez sup=
ports
> > > > > codec switching or if it has support for trying another local SEP=
 for
> > > > > connection.
> > > > >
> > > > > So, could you please export e.g. bluez version as dbus property? =
And
> > > > > also property if codec switching is supported and enabled by that
> > > > > experimental flag?
> > > >
> > > > Hello, I would like to ask for some possibility to export these
> > > > information. Without them it is not really possible to have stable
> > > > implementation which would work with both old and new bluez version.
> > >
> > > I wonder what you are talking about since your changes do have checks
> > > for when endpoints are detected,
> >
> > But this does not work as endpoints are available on DBus only when A2DP
> > connection is active. I already asked to export them always (even when
> > A2DP is not connected).
> >
> > Main problem is that when profile switching is not available, there
> > should be registered only one A2DP codec (SBC in automatic quality) as
> > changing is not possible. This is to prevent introducing any regression
> > or having registered codec which would not work correctly.
>=20
> I fill like repeating myself over and over, but here it goes again,
> endpoints are not supposed to initiate connection which is the reason
> why in PA the card is created only when a profile is connected, and no
> we are not going to introduce feature like this to counter bugs where
> HFP is left connect while A2DP isn't, etc. It is very important to
> note that while we are caching the remote endpoints we never assume
> they are valid before we connect and confirm they are still available.

Ok. So is there any way how to check if bluez supports profile switching
or not? And if not, could be introduced some flag/property on DBus so
applications would not this information?

> > > isn't that enough to detect if one can switch codecs or not?
> >
> > Yes, this could be enough... but endpoints on DBus must be always
> > available, not only when A2DP profile is connected.
>=20
> Not gonna happen.
>=20
> > > This logic used to work just fine last time I tested it.
> >
> > --
> > Pali Roh=C3=A1r
> > pali.rohar@gmail.com
>=20
>=20
>=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nvdnvowfvjmgnafh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXPuVCgAKCRCL8Mk9A+RD
UrLfAJ44xrRMv4B4aZ2cg2qLrPSi6mrT7wCgjTNy7xRB9yYIn6XSptHy6LAlXYA=
=ukBE
-----END PGP SIGNATURE-----

--nvdnvowfvjmgnafh--
