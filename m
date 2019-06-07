Return-Path: <SRS0=bh0L=UG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3389DC2BCA1
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jun 2019 15:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A2C208C3
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jun 2019 15:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzAtZFY8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbfFGP3T (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:29:19 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:50939 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbfFGP3T (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jun 2019 11:29:19 -0400
Received: by mail-wm1-f52.google.com with SMTP id c66so2521260wmf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Jun 2019 08:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hxtWKgCH6rUBTeRXiKli+9sxQT6nFwvOVSDFnJYi9ZE=;
        b=gzAtZFY8WsVV+eSjNpz32rDuqeZGzUGmqBHIIDWX2EweAc3iapyDFIfHl+JRzzI8J1
         BV6yV6yDAYD6LLCK68c8YIfNnj3qjRPSzcr1U4OYvGtlrWFa15e8YyIwCNqA6vnu7Uj7
         breKq/lSZNI3iOHJtLXiTGq1QbrEyiCU1e39Ym2B8wAo+yQvNi2pZmpB7a9cj0A5xoPI
         yuXfoMdhfWxRCuaQ+6iFpgjQ3Db61ZH+uq5jK6iJQYhocSipLaDgYXxZNp85995M72UI
         XR8/SZKztwrsxknSVhAGDOyKB1UH6JZLELUG9AdfVHeieGFmONphuzj86d9uONPTtrkJ
         Pbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hxtWKgCH6rUBTeRXiKli+9sxQT6nFwvOVSDFnJYi9ZE=;
        b=KhrQGVIN7d2wcASR6ScyjFcbQBRtVHkOzFzJY5tS4EZsnnd1c+R3JE4ltXE6V+HZpr
         5Eml3OTWdo8SqNuCp24PK09bBZ3moWGfa1LCuFFXCnqFWJqHesQBSwXb2vjSbkOU0ge4
         Wbo7IwooHZ7A/0CjhII2dKaefqwk7c3dSDiee+Cu1GSK6AAg/Jp8iHeBeE/f3GDUpsjR
         yoZj40XYq4GhFxi/hJ6h328hRyOJMu2DUeUgkt0ytjRn2en4lY+5gf+5pS+GBDWFY3SF
         8gxpA0dM1bs39q8rpd432kT6y3y9liNo0RgOocKEE880UJYsdCT4qIK5gd2l9IHjPY/9
         IP1w==
X-Gm-Message-State: APjAAAUoeYAh8IwTsV91gxISgCF+gOMcQg4mQeo8d5oXHbHoWS7qrZaZ
        LJ7erwN9P4HEAhBvav8FAMPE9JgoYJs=
X-Google-Smtp-Source: APXvYqwvA7f1iabLPaEDWLGJ0ulO0bjOq6+LiBR873SqCQpAJt+2o1E9bfT2n0GMtdTLzWDYtSlJTQ==
X-Received: by 2002:a7b:cd15:: with SMTP id f21mr3793158wmj.99.1559921356895;
        Fri, 07 Jun 2019 08:29:16 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id t6sm2543559wrp.14.2019.06.07.08.29.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 08:29:16 -0700 (PDT)
Date:   Fri, 7 Jun 2019 17:29:15 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Is BT_VOICE_TRANSPARENT correctly defined?
Message-ID: <20190607152915.5m2z3gwvlkivr3ms@pali>
References: <20190519101854.2ygwxeqbixappks4@pali>
 <20190607125916.wswblh5nxrx7hapm@pali>
 <CABBYNZ+JPvvk1eACkp+cM9MtDZq+M78QLAtFcq-qrhR+8DsjnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="d6v6i47i75vprpgu"
Content-Disposition: inline
In-Reply-To: <CABBYNZ+JPvvk1eACkp+cM9MtDZq+M78QLAtFcq-qrhR+8DsjnA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--d6v6i47i75vprpgu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Friday 07 June 2019 18:03:50 Luiz Augusto von Dentz wrote:
> Hi Pali,
>=20
> On Fri, Jun 7, 2019 at 4:43 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
> >
> > On Sunday 19 May 2019 12:18:54 Pali Roh=C3=A1r wrote:
> > > Hello!
> > >
> > > Now I'm looking at BT_VOICE_TRANSPARENT definition which comes from f=
ile
> > > include/net/bluetooth/bluetooth.h and it has value 0x0003. It is real=
ly
> > > correct? Because it means following format:
> > >
> > >   Linear Coding, 8-bit without padding bits, 1's complement
> > >
> > > I think that usage of 1's complement is not easy as there is no C type
> > > which matches it. Should not it be 2's complement or rather Unsigned
> > > type?
> > >
> > > Seems that main usage of BT_VOICE_TRANSPARENT is mSBC codec and I dou=
bt
> > > that it uses 1's complement signed format (specially as it should be
> > > modification of SBC codec which encode bytes as unsigned type).
> > >
> > > There is another define BT_VOICE_CVSD_16BIT with value 0x0060 which
> > > seems to be correct as it means Linear Coding, 16-bit without padding
> > > bits, 2's complement and encoded by CVSD codec.
> >
> > Hello, can somebody look at this BT_VOICE_TRANSPARENT definition and
> > verify that it really should be defined as unsigned or 2's complement?
>=20
> Are you talking about these:
>=20
> https://elixir.bootlin.com/linux/latest/source/include/net/bluetooth/blue=
tooth.h#L119

Yes, exactly.

> Which is used in ofono:
>=20
> https://github.com/DynamicDevices/ofono/blob/master/src/handsfree-audio.c=
#L93
>=20
> Afaik these values work as intended with mSBC/WBS.

And I suspect that definition is wrong. mSBC does not use 1's complement
format.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--d6v6i47i75vprpgu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXPqCyQAKCRCL8Mk9A+RD
Ug5TAJ9fjBs4JqJH4b85t4y++N670lPOfgCaA5tO83YSeBSy+4Z/oX3163lQXWY=
=7BLx
-----END PGP SIGNATURE-----

--d6v6i47i75vprpgu--
