Return-Path: <SRS0=+1pe=TT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A03C04E87
	for <linux-bluetooth@archiver.kernel.org>; Sun, 19 May 2019 17:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61305204EC
	for <linux-bluetooth@archiver.kernel.org>; Sun, 19 May 2019 17:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTcWtVR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfESRVf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 19 May 2019 13:21:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36437 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfESRVe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 19 May 2019 13:21:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id s17so11991557wru.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 May 2019 10:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dajtjx1bIYBztQ1hWsrwS/0EkeXde1hMQIoUagVApVg=;
        b=fTcWtVR+y023EN+8sekNwBWQyaRv4mrhNnrWipibq0BBiHUgeF4lO7JSvCrxwe9e6+
         It1iLvfUeA3MmOAOH8doCAu9vMIVsbnZNTdRnxPVTZ9K8E7E15/dCLqf1oUroIJK0rvc
         fCCqyC6+j3H9lhtM8W0iHtAif4iJeRpkNvMqeJaDdKa2DZko7uyWKjBGgJc8IpiTcKtG
         Saf21BQBIbBEIDoOwCdULqoJ+3ipoSpx/jqB+oeFB7uMwEkTfycdfRykl50hwhQxSL0n
         mMXbvdNEOPIwuMCX3YPAlM529f79A1BVtFbT6dI9eeB3KtR7G36MAR3RT9t3ZTp+KIhC
         7DoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dajtjx1bIYBztQ1hWsrwS/0EkeXde1hMQIoUagVApVg=;
        b=MdDhWzOr7o7cb1nvVKA7/LAGNeAEEdd04CJ5yMO2zkhhjDOQ7xolSjbJ3pvr/Z7bT9
         LE9kLjB0Z/nxMgRqCEwGu+B9whoGwu0409Py5qal6DtZWJU3+XsQWNO2uJQr8Nv2pNbX
         5EsNNzYgmbJgRkhDQtgWLI0Ml0GJTSmQj0idF8SHJTy8xgkEIPqtU+tJP7djFIbNd47N
         PNPMkDmKjIOWjuOIScsGZmq6DqhiUaNRTwON8H8H6bNNOA4MZ/VUDjBuzLV7KJI3DeDX
         mxWBSWxeFQ5TAtlSTlOebjgN0CUVEYzpGeqQXZkEBTZ6PfB2vra2byrZMAuH7Et6gFLW
         F3JA==
X-Gm-Message-State: APjAAAUDpyTLMsSdN1BZRhsBM4jUst5pSeBCAC1OdE8OaTC5/7k2wqaM
        iHOij0LyrIhzawNBosQNteYUEnTT
X-Google-Smtp-Source: APXvYqwDagRr+Qs8sWeuPk5ZHygNeimmJsiB3K2wMbFjW7YfCMffiMQIcModUKaI7Krg8QR2K8XsRA==
X-Received: by 2002:adf:8bc5:: with SMTP id w5mr26994489wra.226.1558268546086;
        Sun, 19 May 2019 05:22:26 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id a11sm14415720wrx.31.2019.05.19.05.22.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 May 2019 05:22:24 -0700 (PDT)
Date:   Sun, 19 May 2019 14:22:23 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: bluez A2DP socket reliability
Message-ID: <20190519122223.gabew7qfftihlbic@pali>
References: <20190518190618.m7rdkthvpz4agxd2@pali>
 <CABBYNZ+8YX-zBnUaYKLX2=OdJ-GUQ4y4V0EhGsN+uecKEpFBeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zwj77sbdf2qyf2xw"
Content-Disposition: inline
In-Reply-To: <CABBYNZ+8YX-zBnUaYKLX2=OdJ-GUQ4y4V0EhGsN+uecKEpFBeA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--zwj77sbdf2qyf2xw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sunday 19 May 2019 11:13:09 Luiz Augusto von Dentz wrote:
> Hi Pali,
>=20
> On Sat, May 18, 2019 at 11:12 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> w=
rote:
> >
> > Hello! How is L2CAP layer of bluetooth socket used for A2DP audio
> > transfer configured in bluez? It is reliable with big/infinite
> > retransmit count? Or in best-effort manner and some packets may be
> > dropped? And it is possible to change between these two modes for
> > application which uses bluez DBUS API? I'm asking because some A2DP
> > audio codecs are designed to deal with packet loss and for those codecs
> > it would be probably better to configure L2CAP socket to unreliable
> > mode.
>=20
> We don't use ERTM with AVDTP, both signaling and transport sockets are
> using basic mode which don't support retransmissions, there the
> concept of flush timeout which iirc we don't currently it.

On bluez.org site there is no information how to use bluez sockets and
the only documentation/tutorial which I found on internet was this:

  https://people.csail.mit.edu/albert/bluez-intro/x559.html

I do not know how up-to-date it is, but seems that by default bluez
L2CAP sockets are reliable and to change them to unreliable mode it is
needed to issue OGF_HOST_CTL / OCF_WRITE_AUTOMATIC_FLUSH_TIMEOUT (0x28)
request. As default is zero =3D infinity =3D reliable connection.

I do not understand low level bluetooth details, but is ERTM related to
OCF_WRITE_AUTOMATIC_FLUSH_TIMEOUT?

So what are default settings for L2CAP socket used by AVDTP/A2DP
profiles which are transferred to user application via DBUS?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--zwj77sbdf2qyf2xw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXOFKfgAKCRCL8Mk9A+RD
UoBjAKC1smAIEZGph1QYqs3XbAP8O/8ZLwCfXlLXh/S1hwlNL6Y8ovmSos1X92w=
=UUH9
-----END PGP SIGNATURE-----

--zwj77sbdf2qyf2xw--
