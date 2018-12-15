Return-Path: <SRS0=1Za/=OY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F8CC43387
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Dec 2018 20:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4D32084D
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Dec 2018 20:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJPxMoy8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeLOU3V (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 15 Dec 2018 15:29:21 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46221 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbeLOU3U (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 15 Dec 2018 15:29:20 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so8551535wrt.13
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Dec 2018 12:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0zooompeLkv4cocIRzLKYrz/1U8/mu6s8z0oVz8VZwE=;
        b=JJPxMoy8tTx0o2DzdUSZVwyiora8tNXOg76isU/cMIUlxIBhZ5xVb2TkE5uApMfOdx
         ZSLvWT4UJSiTlWNcIYGlrYFoUvZHADNljTltHcUvEQGvM3YkhDEkiJiL+VS26n4QqROb
         cUkmhBuT9MTA7LXZpD3dvyaE6EGPHP7ZObJBTPHPiazyaXADokG8OdkUUMNHbg0ZxEze
         j5ofCBI5ISqOHEJyAjKj1tKkB7Q4ohLhkitLckI67RSD+LTSnINnPX2OYeFwODtGEGFf
         mgfqE70tZfYI9YrHoF6pg0lQFg8BkG9iLvLM8fcKWEaLDpR2iLiLkxXmvTNatAKbLu6N
         Uj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0zooompeLkv4cocIRzLKYrz/1U8/mu6s8z0oVz8VZwE=;
        b=kqBWqCK+Rt9k/SZnKzsZ5UgnUPsetlLlCDJk1U0yAOgph1URXBF0MhBv1rJxG57xJJ
         m/zFAsZSSgWEjc+vBbTfQ4P4g/rdKRdv75JeJ8S2hhqdVlr17exW6LOX3VP3j0JpZV50
         03M295wue/joJFmrd5pYAeT+mzPiw4RtPs0D9C1hVK+ga9jWILv6l3C34vTczvn9fb32
         Z19FxhA2pQoyz/4DTTT+IZoj5L5FBUr297GsYGBU9JxWUrmsR/Oz0xh3Etebapk5qBYo
         iBj1bK7JzWz7w6u6g6CAHB/EkO/Mt5hX27PqADw/QZzLyNOQpsUc+0Zz8Dbt2p1VS4X/
         cQ9g==
X-Gm-Message-State: AA+aEWaxK0uxLGN/2hjaLEtJ6NuREKNryRMtRR0tcXckkPJ8d48gIP4x
        t+2ZCvAf+A+geInfYLyEUgo=
X-Google-Smtp-Source: AFSGD/XE1rllTS5ACmfrsH+AMH0TDchIEaBAdDqhB5w+lVFkIJNRL2Zd+ACCKLndDBLzb4AZFYT+Bg==
X-Received: by 2002:adf:f350:: with SMTP id e16mr5912705wrp.125.1544905758789;
        Sat, 15 Dec 2018 12:29:18 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id x20sm13516900wme.6.2018.12.15.12.29.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Dec 2018 12:29:17 -0800 (PST)
Date:   Sat, 15 Dec 2018 21:29:10 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez: dbus method call for switching endpoint
Message-ID: <20181215202910.j24amjshrvjqprll@pali>
References: <20180711082352.oo6srapfnol5nkxq@pali>
 <CABBYNZJuGT5_zhg-BkAc4XjtVu5His92cHTujrin=SMOVbaodQ@mail.gmail.com>
 <20180711144501.ovdxc2expa4bg6sc@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="imkmxtjc22yaldve"
Content-Disposition: inline
In-Reply-To: <20180711144501.ovdxc2expa4bg6sc@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--imkmxtjc22yaldve
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday 11 July 2018 16:45:01 Pali Roh=C3=A1r wrote:
> On Wednesday 11 July 2018 16:27:07 Luiz Augusto von Dentz wrote:
> > One way to solve all of these is that we would expose the remote
> > endpoints using MediaEndpoint1
>=20
> So client application (like pulseadio) would see list of remote
> endpoints (one for each codec) and choose one for connection?
>=20
> Looks like this should solve this problem.

Are there any progress on such API in bluez?

On pulseaudio mailing list other people proposed patches for other A2DP
codecs and basically bluez API for choosing A2DP codec is still missing
part...

> > though only SelectConfiguration would
> > be really useful here and that doesn't contain the remote capabilities
> > that probably should be made into properties, along with codec type
> > and uuid.
>=20
> Remote capabilities are needed. And for codec type =3D=3D vendor it is ne=
eded
> to know also vendor id and codec id.
>=20
> > Besides a good headset would probably
> > remember what codec you selected the last time and just connect with
> > it, this btw is what I would do when operating as a sink.
>=20
> I hope that Linux would support also not-so-good headsets.
>=20
> Anyway, dual booting between systems which support different set of
> codecs makes those "good headset" with remember support just
> "no-so-good" one.
>=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--imkmxtjc22yaldve
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXBVkFAAKCRCL8Mk9A+RD
Uu5qAKCA/PFlL1hYBtnvOtjCQl9wp+LlcACeJdpgni+tfqM0Noma6zC8CnlT44w=
=gUEQ
-----END PGP SIGNATURE-----

--imkmxtjc22yaldve--
