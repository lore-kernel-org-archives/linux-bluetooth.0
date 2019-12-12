Return-Path: <SRS0=nb/8=2C=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6399C43603
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Dec 2019 23:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C3F214D8
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Dec 2019 23:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hp9x5MAW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731327AbfLLXDS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Dec 2019 18:03:18 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:37934 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730847AbfLLXDS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Dec 2019 18:03:18 -0500
Received: by mail-wr1-f49.google.com with SMTP id y17so4567424wrh.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2019 15:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pKMYXHFDinWvkAw3+/awbV6kfj7pvPBocKfaMOS6Sj8=;
        b=Hp9x5MAWLFfY0XvdkkEHVqexzBbVmuYv7fd34rMXhfxVFcSZJtteDqutdtLFFPlRSL
         yAnB556jbyPn7d5ZZV6pUGpHko25Sx/OzqxOuY7uom2HyD+gVUKdqN/xH94OyT57c9Lv
         r2VJxPRI7EQvO6LiOxnzNC0LmOVdzcBsxcxVx89OU3T4DgmqO0Vt3uCr9Qr6NajK0EwH
         Znq4uuwKTlLtrSKhKBGPYtNmFBNQkQpl/iyRQp752QYJs77T0Jul6CZpxbNqrY5NN/VS
         05AY4eRSL/9pWGZm8rBUJIMPx/qkR+tUmtIEZkTvpqpan2zoko2YKdXUtvawhVe19mIv
         A/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pKMYXHFDinWvkAw3+/awbV6kfj7pvPBocKfaMOS6Sj8=;
        b=Lki9VktJNIcTZN6LAB72w50Gbopej5+AiK9RxtdbaywMxyn5Os3tT1mII4n8Qgpc12
         yLSZtShlzYLNfDevD2Glo5a4vT8f7KGOXgQce8EXyBeekckzHficXALqfr4rqRPhStyr
         edOktqR9BzVW+IqtkToTF+ztsqZctUt5Htnick1BkNYJU6RIwkfZORu+v3OrZRiey9JS
         nmHsN2+9NSnxIh/oe6mNbOglOoAAWNATs6oYPcnkoLvHSk+2KuHj+uo5K/JfP693kXSC
         t4J8BvPP9unkZeRB095+Mu0YAbV+a2xNkW1vuBa+QRyo9PYACH8o+5NFUYxjU/lEM2O2
         gz1A==
X-Gm-Message-State: APjAAAV0eLzK9RMcEjIaNqRgkMIMWbrA7qAmP0Og3lz/KOV/HSjSJSVv
        SZQ3M57pXwXZ1uvz9dfHq0M=
X-Google-Smtp-Source: APXvYqxfDsBvEo/VKZ6ATO4Jy1hT6wo8lH80Vy9lT6klNTaZws/HeBdeWYYN04ilT3dHJeMAQU8jzA==
X-Received: by 2002:adf:f508:: with SMTP id q8mr9017901wro.334.1576191796044;
        Thu, 12 Dec 2019 15:03:16 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id c2sm7905354wrp.46.2019.12.12.15.03.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Dec 2019 15:03:14 -0800 (PST)
Date:   Fri, 13 Dec 2019 00:03:14 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez: Export SDP "Remote audio volume control" item for HSP
 profile
Message-ID: <20191212230314.g5gt6rxkphzpwucd@pali>
References: <20191212172944.hgt6se2qz2hpsbo2@pali>
 <CABBYNZKCovNDcAaMMeYZgKAAq-8oz+pcs6xmS3A_Qt-28aoEbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vj3av4dbfywmd6i3"
Content-Disposition: inline
In-Reply-To: <CABBYNZKCovNDcAaMMeYZgKAAq-8oz+pcs6xmS3A_Qt-28aoEbQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--vj3av4dbfywmd6i3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thursday 12 December 2019 21:42:27 Luiz Augusto von Dentz wrote:
> Hi Pali,
>=20
> On Thu, Dec 12, 2019 at 7:31 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wr=
ote:
> >
> > Hello!
> >
> > According to HSP 1.2 specification, section 4.7 Remote Audio Volume
> > Control, Support for remote audio volume control is optional, so an
> > implementation may support none, either, or both of the controls for
> > microphone volume and speaker volume.
> >
> > According to HSP 1.2 specification, section 5.3 SDP Interoperability
> > Requirements, bluetooth device with HSP profile announce via SDP "Remote
> > audio volume control" field information if device itself supports volume
> > control.
> >
> > But currently I did not found any way how to access "Remote audio volume
> > control" SDP field in (pulseaudio) application as bluez does not export
> > it.
> >
> > Can you please export this field? E.g. for HFP profile all optional
> > features from SDP are passed to NewConnection() DBus method via
> > fd_properties dictionary under Features key. Could you export that
> > "Remote audio volume control" bit for HSP profile in Features key?
> >
> > And in same way, this needs to be handled also in RegisterProfile() DBus
> > method.
>=20
> Do you have a use case in mind?

Yes, checking in pulseaudio if remote side announce that supports remote
volume control or not. And based on this switch to software volume
level.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--vj3av4dbfywmd6i3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXfLHMAAKCRCL8Mk9A+RD
UlKtAJ4wryPSDSLw6lEBAO9H+nQh4bZQzwCfTEqiaXLcALsKsdcplm7U0c2YQCM=
=kmd+
-----END PGP SIGNATURE-----

--vj3av4dbfywmd6i3--
