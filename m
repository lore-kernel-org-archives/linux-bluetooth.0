Return-Path: <SRS0=wtFT=P6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF4AC282C3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jan 2019 17:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D7CE217D6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jan 2019 17:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDJLNlJt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbfAVR41 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Jan 2019 12:56:27 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43685 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfAVR41 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Jan 2019 12:56:27 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so28386329wrs.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jan 2019 09:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nNhAi9PeI9Lao0Oy7CJsL/rKbvKMf3HQm8WqVi9Ff7w=;
        b=ZDJLNlJtNeENLenhogxWhOtyKjAUnzSDNUkyJPTaBx2/rLZGnAB6YqSV55neGeXjeR
         +k6hltkofFaQqYnVK9CMJP3kCkfm2oN2zYr0aNlGwRlczLQscR+swFa6nyKDX8WZP+cZ
         mrMFNicj3ZSJeLdXGQ5jnF2N+k78MWEWd6dGQIsMALYDLZaNz/eLB1v4i8Xpwln7M2yk
         m18USp/iO0sJ721OIZD+QUgNMwJ1Xnx3qanfrFCE17p2U3hMTO/9mHJq7acKoRSo5hhd
         medA+oXxzP3wIcANDRIRqINv/Xaa8uSutUhdU4Rtu17A87Aq5aBIe/M6iWU6kVHIlDKp
         23Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nNhAi9PeI9Lao0Oy7CJsL/rKbvKMf3HQm8WqVi9Ff7w=;
        b=lfx6BvRbT2EZU7w/7U1OVQ8bsR5CzaTwHPSrSYFCCHk1zHE2zAdjsBgyi2M5jgHX3i
         QIG3C5HI7MA9i1X/7lOArYmf1wkx5Z3IeFtdoP2JqwQYcupQ8BT5/xbvoDBq1Kv/Vl8K
         kh8ZFgpWEHKfqubCiccTXiZe1pKsxLBoHOdCaI6TTyW4K1WdBb6Cm42tP90uRQeo8oRV
         GsDblUyNhGWQjkzCXk7dZ/BEB93Zu45uaBaYctIWQVP8d0h2YjHzwiQcTSRCHm8GmXz8
         EAfWtfPDJVo+8YE5044p9ONQN7zdr98aK4fukKvmLVGd45Hvd5FKkIa8hNih2Ku2xPso
         JxMg==
X-Gm-Message-State: AJcUukehp3IcqAYz0kVwW5D1zyYuhgj+ur1FLmNuOFDn/9T++sztn6wE
        DsRK25Ak0ALvqibCV9jjmms=
X-Google-Smtp-Source: ALg8bN6ajgFUy4EN2XrDoIgwzVoTFjyGMttzbqsR89CUbrlKlBYgeN4LdAsgeZ2vsvRqjuzhmMcPAA==
X-Received: by 2002:a5d:4f10:: with SMTP id c16mr34912036wru.177.1548179785547;
        Tue, 22 Jan 2019 09:56:25 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id o16sm137316716wrn.11.2019.01.22.09.56.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 09:56:23 -0800 (PST)
Date:   Tue, 22 Jan 2019 18:56:22 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3 1/9] doc/media-api: Enable MediaEndpoint to expose
 remote SEP
Message-ID: <20190122175622.dj6riiim6zukpetw@pali>
References: <20190122134524.20509-1-luiz.dentz@gmail.com>
 <CABBYNZLCFpXhbAnVYaA-nVNOY8QRvpR1UZhMHfy-awZxtpSocQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5tf73hqdu6na3ifi"
Content-Disposition: inline
In-Reply-To: <CABBYNZLCFpXhbAnVYaA-nVNOY8QRvpR1UZhMHfy-awZxtpSocQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--5tf73hqdu6na3ifi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tuesday 22 January 2019 16:20:12 Luiz Augusto von Dentz wrote:
> Hi Pali,
> On Tue, Jan 22, 2019 at 3:45 PM Luiz Augusto von Dentz
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
> Can you try this set?

Hi! In V3 you added only "a2dp: Add reverse discovery" patch right?
I tested my setup also with this patch and there is no difference,
pulseaudio is working fine :-)

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--5tf73hqdu6na3ifi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXEdZQwAKCRCL8Mk9A+RD
UsJrAKDMLsYDVMATP9W5xqwU86v9VjGdVACeOCYSzHwgBtRET+tPZ+3NnBXwn4U=
=Y5BO
-----END PGP SIGNATURE-----

--5tf73hqdu6na3ifi--
