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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DFEC4360C
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Oct 2019 10:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47B72087E
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Oct 2019 10:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9J6ugXZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfJFK46 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Oct 2019 06:56:58 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53373 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfJFK46 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Oct 2019 06:56:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id i16so9700426wmd.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 06 Oct 2019 03:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z09LFk4ydlrpZJAroekNDzQQBHI0oMe45VxgPPN2h3Q=;
        b=D9J6ugXZ4YVkAcmCtTV4GkzOiFo4Qp53qIITXm0Lnn8ikQDn5KTJ7i9dOiNABlS03G
         NWXkzyXFSWSqRb5pxkRYwJScQkjiKvejRNiEn7Ls832pgq1Va4Dj5ZNY2Tjccdlk8vmj
         FxDx2cLjaZxO23YbxcI39vNKpXAWAip0OKjn3+3kSLco3qSzI96o9QdTiuNKR21ovU+X
         cXuT2WcLL86FWn1pa+gW+pRvNI9ASXoxDxKLu5AxBNdVjheYZmLHyPyMVY+64/1eQmDg
         0rMOArK8OSr16v5EEMbc3FmZ9sU9DxoPcOdjbF7CmqxNW4Mt9l2GbHQ5bI02Mq83g/kB
         xcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z09LFk4ydlrpZJAroekNDzQQBHI0oMe45VxgPPN2h3Q=;
        b=tzocZv77EomBcMk+SDjeKf8ZNb8/lsUmIirFUykhgKqBTuGBZ7gyKobKLomKx5ZoZo
         2ss1S6btLmtR6bcvvI/yrTMh+W77Hq9akRTOfOOcsxe/57z3aEhUlY5L6VBG2NRBtJUv
         tqn3n9OGkRB7bKlOzOiXykpqIhPDtUP595usg5FsR6OF4bFmNajHtezqeIBuB8fNemUI
         OnTsVaza3tMCaHDF+EFEgMs4FTaeNN//1PrMmqs1eBo7CsSy5Y8kmUNXigjZ5QFFojEt
         FxPXR0et7GNWmVj5OkJb0luZRPIjJEckni5aHJ3G8fZKIJ7fkOxSF18jM68TzDDU+Tcv
         c1MQ==
X-Gm-Message-State: APjAAAV+Fi282v8f94ZK+KiWaMoypvEUHrmRUaS7Dc7tZcLSMGPApUYG
        Zh5LyfrFysxy1D4O/yTWXy4=
X-Google-Smtp-Source: APXvYqxYWMWqF2AFFpKsf2IPFANR7qfI+L9sMOQMlUIng39ClSZN3yvaeVZvkq3XgwTOEyrB1KUw/g==
X-Received: by 2002:a1c:2144:: with SMTP id h65mr17740773wmh.114.1570359415680;
        Sun, 06 Oct 2019 03:56:55 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id e18sm14197108wrv.63.2019.10.06.03.56.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 Oct 2019 03:56:54 -0700 (PDT)
Date:   Sun, 6 Oct 2019 12:56:53 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Pasi =?utf-8?B?S8Okcmtrw6RpbmVu?= <pasik@iki.fi>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 1/4] doc/media-api: Add RegisterApplication method
Message-ID: <20191006105653.joky4pzkwtnntiwo@pali>
References: <20190712151329.11333-1-luiz.dentz@gmail.com>
 <CABBYNZLDFAJgkfAFWOOAAqqiX8mpi3KgirBkpwpnBFJ3TxPqyg@mail.gmail.com>
 <20190718100024.ii2igadxb2lmmitm@pali>
 <20190721155522.3vqt7vsprhpxflqf@pali>
 <CABBYNZK6cuz9n4Hu9uRCbQvn9uFEYkn9=mY8J5Fqu0u-D3B1EA@mail.gmail.com>
 <20190829125734.GH2840@reaktio.net>
 <20190829200513.6xnta5jx3trbmgxp@pali>
 <20191003181855.GF28704@reaktio.net>
 <20191006100503.fsbttcschr6wgsdq@pali>
 <CABBYNZLS4MMxJ=gQED-BVfn81D0bvx8aLw5OO3tNmXAnWeA57Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3kkbewmqwkfk45ib"
Content-Disposition: inline
In-Reply-To: <CABBYNZLS4MMxJ=gQED-BVfn81D0bvx8aLw5OO3tNmXAnWeA57Q@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--3kkbewmqwkfk45ib
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sunday 06 October 2019 13:53:37 Luiz Augusto von Dentz wrote:
> Hi Pali,
>=20
> On Sun, Oct 6, 2019 at 1:05 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
> >
> > On Thursday 03 October 2019 21:18:55 Pasi K=C3=A4rkk=C3=A4inen wrote:
> > > Hi,
> > >
> > > On Thu, Aug 29, 2019 at 10:05:13PM +0200, Pali Roh=C3=A1r wrote:
> > > > On Thursday 29 August 2019 15:57:34 Pasi K=C3=A4rkk=C3=A4inen wrote:
> > > > > Pali: How does it look with porting the PA patches to use the new=
 interfaces?
> > > >
> > > > Hello, I have not had a time yet to play with these pulseaudio patc=
hes
> > > > and porting to the new interface. I guess that I could have more fr=
ee
> > > > time in the last week of next month.
> > > >
> > >
> > > It seems BlueZ 5.51 has been released meanwhile (http://www.bluez.org=
/release-of-bluez-5-51/)
> > > So now at least the new interfaces are in a released bluez version.
> >
> > Ok! Today I have looked at this new Bluez API, but seems that there is
> > not only missing some examples or usages with libdbus-1, but also
> > documentation. I have tried to find something how to register endpoints
> > throw GetManagedObjects() via libdbus-1, but seems that there is no
> > usage of it and also unusable documentation for it in libdbus-1. So
> > currently I'm stuck how to use this exotic API in pulseaudio...
>=20
> It is just another D-Bus method, the only difference is that it
> carries the entire object tree, btw I did add an example of how to
> register Endpoints in python:
>=20
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/example-endp=
oint

Now I found this python example and currently I'm doing observations and
"reverse-engineering" how it is working and how this example behaves on
D-Bus. I think I understood it now.

> You can also have a look at how our gdbus internal library (uses
> libdbus) utilize it:
>=20
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/gdbus/client.c#n1=
269
>=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--3kkbewmqwkfk45ib
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXZnIdAAKCRCL8Mk9A+RD
UpAyAJ4n4NKjOlt+OSL8C/EiNN7V1xpGjACeMORhSw7Xxh1SyxYt+An5QcuLs6A=
=px14
-----END PGP SIGNATURE-----

--3kkbewmqwkfk45ib--
