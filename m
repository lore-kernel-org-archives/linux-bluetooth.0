Return-Path: <SRS0=sFHJ=SI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63875C10F06
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Apr 2019 14:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2686F2146F
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Apr 2019 14:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gT9m7b0T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfDFOw1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 6 Apr 2019 10:52:27 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:34612 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfDFOw1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 6 Apr 2019 10:52:27 -0400
Received: by mail-wr1-f41.google.com with SMTP id p10so11303494wrq.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 06 Apr 2019 07:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LYQ/KNbiYlBJotnqOFhlectdu4wqGrtnnhcD60VyQEI=;
        b=gT9m7b0TEUDe/2Y0s0GTmeOh+sWdfe2KDWIsz51ek7YEhQPG2j6HzVPGLaA6rY8VM5
         6LIF0pU5EwmZ8e8AraHgutjfirKN5JE6FaGg+A5/Tf32IYRDbWDI1Pm3ayVZ4jHVZQRI
         iz/AqUF9oke4tg0qkqYervO7v6OQ8djvj2KHsLcBWBZr6X1AmQOdnmXd9MlhYpkZ05OJ
         CFyJ6oexVjlx6Q9RyCzNLOP4heRGzB/3tybXsfpil9fhW3CqBYgla/KB0ahZJtdIY+j7
         Y5JBM0/HhKGTrX12apuE2kM1qJTs5GI4k1/k9klOaoFMPXcg1/qxgEujDOunMW7gPr4T
         CH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LYQ/KNbiYlBJotnqOFhlectdu4wqGrtnnhcD60VyQEI=;
        b=naJTfuDYlQIqZQmedOFEy0rOmfGPvghnqZJ9Iix8hQ/JS9wKJ4OB4bVmRDZR3z8BOZ
         tygWIWRYiwHXnkdofRr7k8/ZitgGrVSXNYOd3KIwdzquAyONsznlp3Ehbg+mxkCH9GB0
         ehqGSblvm53L7/SoewlfY6DX7W9hvm+9g0f5yHS9c/g2asx5u1Hl8CFpyQMDw1SX1SWE
         F/ffQ8Xbdg0VaAbWucqoFAbHJIEaq6uLYFYh6AX3eVE8fQRCOWP3GHruq1NTqJsgIXHC
         +Ah8BSlmmqyYTHAQ7zt1n3GpoOBunHEyoq2RfcQ405/LEKKuixxahmQoZYpUWasBPqlx
         icYg==
X-Gm-Message-State: APjAAAWLNMwXMkgXwdiOTDsDK4lWgvgqnOjtdZ2JUhwfYX3QFkxSt7vg
        YwIACBaV3a5Lf0cNwrJvj4lRwJ3/
X-Google-Smtp-Source: APXvYqzC93q2XE4Nf7+6kcmXkXsNSy7k7MbxhKWvyniOJMUVuEqdJA+lwj2lxqUd8poOwHsaujGcbQ==
X-Received: by 2002:adf:b682:: with SMTP id j2mr12230837wre.3.1554562344649;
        Sat, 06 Apr 2019 07:52:24 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id x5sm22415023wrt.72.2019.04.06.07.52.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Apr 2019 07:52:23 -0700 (PDT)
Date:   Sat, 6 Apr 2019 16:52:22 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: Re: bluez: install a2dp-codecs.h file
Message-ID: <20190406145222.so7oyma2gme67pfn@pali>
References: <20190324142058.neuunjf46lgwcrgh@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ypjdxisag5szwl33"
Content-Disposition: inline
In-Reply-To: <20190324142058.neuunjf46lgwcrgh@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--ypjdxisag5szwl33
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sunday 24 March 2019 15:20:58 Pali Roh=C3=A1r wrote:
> Hello, some projects like pulseaudio is re-using a2dp-codecs.h file. It
> has own private copy of it. To simplify sharing this file between
> projects, what do you think about exposing this file as part of bluez
> API? That make install would install this file into system and other
> projects like pulseaudio could depends on it.

Hello, any idea about exporting this a2dp-codecs.h file?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--ypjdxisag5szwl33
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXKi9JAAKCRCL8Mk9A+RD
UjhrAKDISy3AhjYlQValmK5TakTHPK1AAgCeN5COnphD2tdwAjmk9cODu6S+jjg=
=88Dx
-----END PGP SIGNATURE-----

--ypjdxisag5szwl33--
