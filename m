Return-Path: <SRS0=Uexg=X7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F399BC4360C
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Oct 2019 10:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C755F2087E
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Oct 2019 10:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dg73KHLb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfJFKFI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Oct 2019 06:05:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44803 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfJFKFI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Oct 2019 06:05:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id z9so11800381wrl.11
        for <linux-bluetooth@vger.kernel.org>; Sun, 06 Oct 2019 03:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2naE1yUqNpWRdrcWzEisP6TXmJmgW15Me9mRKmDM5SA=;
        b=Dg73KHLbtD+ZkaLlovJxneb2Tahn0sPLNJZFcTQKWiAAphkMihCx9lHakI+f7zC2iI
         feZ6RkkWVMqOS6JwWbVp2dcTWX7QcxRddlU7RTeeOfc1kFiKJek78sH76U3EuPVBv1Eu
         WhWCr86FpozoMLS/B9c0BmsJhLecrdFfb03I/+0fIA4tAIZsafg8+GPLYxHI/QxQP3uD
         M2+Xgwfgy+UscHjYRScPKJoG6+CdWvdICKr2J4bxIOqnGEGoE78kqNH4w4BYkf9kyW1J
         Att7Bmjtl2GVk+RbbrCDz14AloDLm38oNjp3kSeWhye0fNMCbKQ8/HCUl0HD41n79JIx
         h4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2naE1yUqNpWRdrcWzEisP6TXmJmgW15Me9mRKmDM5SA=;
        b=E610A8QrkEMk6OajbeW7Rhb9fM4XFf87A8gCtt5/huQxTviGx97RPoMDi4Ic/dhHns
         SXsW1YNojOFFt/pLgKXfOjHpfDjY7GcIlgFitcaRQn2YaApSA7hVnkK0lZ2olpg1QRnG
         tJgYnaU2pemjsgrDFNzgESu9VoXFmXC4liAjf4V0QSY0AglEDOUtiktTOXyr7O2U72vb
         4mUJIxrB+raxh8cxU9Qu+YU8MQbrxdDm5qWpw37ej2kZXzjRNALS2rS2ceC1QOXXfMrD
         VOkbd7Au91QhyLlomsHS6BGX9ue7tPmOH++0FCzyldfL7RJpvGX6LI/ZyLfhQXHLSoah
         NtgQ==
X-Gm-Message-State: APjAAAWHajnP4J1l+XxuGQYPqn6zRCfFivLTuzIhmrkXEGMUOX1v2NIW
        /gBMg5brIAeKSQn1x1zqW5w=
X-Google-Smtp-Source: APXvYqw/5eOc9Cqk9DZST5WTLMKvjWuScaC0xFL8ilGdRNu90vkI3+LHKOMr2VvMZHJcsPUnesEYhg==
X-Received: by 2002:a5d:6812:: with SMTP id w18mr17573758wru.250.1570356305973;
        Sun, 06 Oct 2019 03:05:05 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id a204sm19703975wmh.21.2019.10.06.03.05.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 Oct 2019 03:05:04 -0700 (PDT)
Date:   Sun, 6 Oct 2019 12:05:03 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Pasi =?utf-8?B?S8Okcmtrw6RpbmVu?= <pasik@iki.fi>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 1/4] doc/media-api: Add RegisterApplication method
Message-ID: <20191006100503.fsbttcschr6wgsdq@pali>
References: <20190712151329.11333-1-luiz.dentz@gmail.com>
 <CABBYNZLDFAJgkfAFWOOAAqqiX8mpi3KgirBkpwpnBFJ3TxPqyg@mail.gmail.com>
 <20190718100024.ii2igadxb2lmmitm@pali>
 <20190721155522.3vqt7vsprhpxflqf@pali>
 <CABBYNZK6cuz9n4Hu9uRCbQvn9uFEYkn9=mY8J5Fqu0u-D3B1EA@mail.gmail.com>
 <20190829125734.GH2840@reaktio.net>
 <20190829200513.6xnta5jx3trbmgxp@pali>
 <20191003181855.GF28704@reaktio.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="q65dnjl57ttqoylu"
Content-Disposition: inline
In-Reply-To: <20191003181855.GF28704@reaktio.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--q65dnjl57ttqoylu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thursday 03 October 2019 21:18:55 Pasi K=C3=A4rkk=C3=A4inen wrote:
> Hi,
>=20
> On Thu, Aug 29, 2019 at 10:05:13PM +0200, Pali Roh=C3=A1r wrote:
> > On Thursday 29 August 2019 15:57:34 Pasi K=C3=A4rkk=C3=A4inen wrote:
> > > Pali: How does it look with porting the PA patches to use the new int=
erfaces?
> >=20
> > Hello, I have not had a time yet to play with these pulseaudio patches
> > and porting to the new interface. I guess that I could have more free
> > time in the last week of next month.
> >
>=20
> It seems BlueZ 5.51 has been released meanwhile (http://www.bluez.org/rel=
ease-of-bluez-5-51/)
> So now at least the new interfaces are in a released bluez version.

Ok! Today I have looked at this new Bluez API, but seems that there is
not only missing some examples or usages with libdbus-1, but also
documentation. I have tried to find something how to register endpoints
throw GetManagedObjects() via libdbus-1, but seems that there is no
usage of it and also unusable documentation for it in libdbus-1. So
currently I'm stuck how to use this exotic API in pulseaudio...

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--q65dnjl57ttqoylu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXZm8TAAKCRCL8Mk9A+RD
UpSbAKCfK2h9EUCAl31q3sxDTgRSOiLkhACgrL+u35WaTEAiGHHx0BZrunO4bq8=
=6njA
-----END PGP SIGNATURE-----

--q65dnjl57ttqoylu--
