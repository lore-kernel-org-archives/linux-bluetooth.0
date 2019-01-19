Return-Path: <SRS0=MOIW=P3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CCBC61CE8
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Jan 2019 17:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802E92084C
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Jan 2019 17:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAr857Y3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbfASRPk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 19 Jan 2019 12:15:40 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35246 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfASRPk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 19 Jan 2019 12:15:40 -0500
Received: by mail-wr1-f66.google.com with SMTP id 96so18694846wrb.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Jan 2019 09:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BJInj7vGHlT6KmSUBo9PSKOK/Rph4GZ1Y5zdYCo1KCw=;
        b=EAr857Y3GbIGG5nVJB8MsRoIZKfjlFFVC1UWdl8VkHGW5QCfvUIdpPAPAZF6G1zojv
         yAu/FI8CSNrE7+uWzWb4GfwJlGUMVUBmPpghpdzLnV47AKxBtthkRyv1Qk/qqT4IKHwz
         FQT8XvVcR+LNcpdlPkPXuvv9PcRjPZ5xvm1ozaUQiiI7jE7PX83LB1VANcUC7dbCkAHZ
         uhmGbenaFJI1ORURF36+lh4fMF8ZPDuXjMKwTOLiZYtRaQrqIs7itqJD71Q1xHkC9PNd
         YQPuhF+Sss+kIrvp8mRC8puYs46ZesYP/00Um86oSGKEqJ1P00Ena3btnOTED3DEh7KX
         vUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BJInj7vGHlT6KmSUBo9PSKOK/Rph4GZ1Y5zdYCo1KCw=;
        b=Tark6Hiy4zeors2266HpftaiCmUOB1tTBLbaMBBwgs5C1loqdKRn6KybeRjpiWMfQO
         W6U3u1MRE4pRdbqfjyA1tty5f8eHSAB9jBjfDsvUD7T/mG1r9pyGwSe4XY+OEPb4munu
         Kb1ItFVaasZBgoNowx6JBIPwwrDIneJ2GLRRxtMHdIHB/OXekevSsAkgNcVQVZa2dvGt
         inFCYjwub+kPfMZdlpvkQzU0SUZXjDSZpOrRdLYW1E1shwHZTrYGr+i/9H6Cxu1Lb34y
         wxCQcMPotqk+cI8qT382dPaIE192NORbnTGivx0VWRQCzVhESz4VFSwxX6dYxwVc2KZr
         XBpw==
X-Gm-Message-State: AJcUukdWyirK2bL+XRxDdhyqVSn99vkvh1baqwTQpDSDyJUYX2+dh73J
        Zc3LyUANJkIsSbFVskjPK1o=
X-Google-Smtp-Source: ALg8bN74612ggOGtcWxcOThZVZdqJ6m6hD80OnpUxoz6+fUYbxwwm6rWRbmd8Enl3IJZVJhCta6esQ==
X-Received: by 2002:adf:fe43:: with SMTP id m3mr20511015wrs.290.1547918138416;
        Sat, 19 Jan 2019 09:15:38 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id g188sm55880474wmf.32.2019.01.19.09.15.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 19 Jan 2019 09:15:37 -0800 (PST)
Date:   Sat, 19 Jan 2019 18:15:36 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Pasi =?utf-8?B?S8Okcmtrw6RpbmVu?= <pasik@iki.fi>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez: dbus method call for switching endpoint
Message-ID: <20190119171536.k7jxqogiqz4juavc@pali>
References: <20180711082352.oo6srapfnol5nkxq@pali>
 <CABBYNZJuGT5_zhg-BkAc4XjtVu5His92cHTujrin=SMOVbaodQ@mail.gmail.com>
 <20180711144501.ovdxc2expa4bg6sc@pali>
 <20181215202910.j24amjshrvjqprll@pali>
 <CABBYNZLK4tyL8nvWbXxr6VctyEyJkMdwNiWMy4gUge9h9Vb4SQ@mail.gmail.com>
 <20181228191102.GA31975@reaktio.net>
 <CABBYNZ+bwbSkH4qtkuzhE=JY6KAGwJ_E4ABGT_LE6E277eTNDQ@mail.gmail.com>
 <20181229130818.jdcpwlpyoyhdqlf3@pali>
 <CABBYNZK4+K5vRF0JCHFcUjbfzWanp_ju6XfQQJWBtiLqKi=e7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2mcf7unfvgybeatt"
Content-Disposition: inline
In-Reply-To: <CABBYNZK4+K5vRF0JCHFcUjbfzWanp_ju6XfQQJWBtiLqKi=e7Q@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--2mcf7unfvgybeatt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tuesday 08 January 2019 13:44:24 Luiz Augusto von Dentz wrote:
> On Sat, Dec 29, 2018 at 10:08 AM Pali Roh=C3=A1r <pali.rohar@gmail.com> w=
rote:
> > On Friday 28 December 2018 19:10:11 Luiz Augusto von Dentz wrote:
> > > Regarding the API I still didn't have time to start it, so it will
> > > take a little longer than I antecipated.
>=20
> Ive just sent the patches adding support to switch the endpoints, Ive
> only tested with a couple of sony headsets so I would appreciate if
> you guys could try it as well.

Now I implemented profile switching into pulseaudio. Seems that bluez
DBus API is working fine with tested headsets. Patches for pulseaudio
are on pulseaudio mailing list.

What else is needed for including these patches into bluez officially?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--2mcf7unfvgybeatt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXENbNgAKCRCL8Mk9A+RD
UoDDAKC3ZTKomd7cJPOk36O2I7a8ZBGgkwCcDUA4BGB5Ae9aPMNR5tMcE+Y8CI0=
=NFey
-----END PGP SIGNATURE-----

--2mcf7unfvgybeatt--
