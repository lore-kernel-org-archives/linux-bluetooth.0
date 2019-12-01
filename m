Return-Path: <SRS0=ukjF=ZX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C11CC432C0
	for <linux-bluetooth@archiver.kernel.org>; Sun,  1 Dec 2019 15:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E422B2053B
	for <linux-bluetooth@archiver.kernel.org>; Sun,  1 Dec 2019 15:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOIvN9f/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfLAPU4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 1 Dec 2019 10:20:56 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36586 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfLAPU4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 1 Dec 2019 10:20:56 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so40930115wru.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Dec 2019 07:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rKLSrZJkEH77lZ2ohriiKRfktKFCoFYYs4y4PBdXX44=;
        b=iOIvN9f/d6+wW0ABFOg9eEbkB/eIrGEZTz+rGH31eI2Al9BRzLZDIUwmDQnS9gSy74
         9Sn+K2VFsM5/W7DFPR21/L6sclJxyQliRpXN/3qwKkkqokq7ImAAH1cyuKjTYmQugCUY
         EXm7XLXBG3o+guv5OfKQdAJZdhipGDej/o7x0bL2MH+l83RCWWb3vht1remevVR2VS+e
         zoW25Os0182Cdw/71wzlttyw0alj2YdN/xUUQXgCJCxwE8An2cIhesTOmRwS9nmz+dV3
         za1/rg69RuL3kTeoeWXaH/XrnU+NNyYUXPZ3bBLWGzjiAQMSr8iOotuprKYzNWTTgP2Y
         hjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rKLSrZJkEH77lZ2ohriiKRfktKFCoFYYs4y4PBdXX44=;
        b=Jm2ck0OkdTrrNCe8lfPuRmeAuLRPOyqEdfHjusKBAWwt/xIQIdeEqKOMjPmKoAwOLv
         G+9gkMOnZrYPvPsssI+ipzLkfQ3lfE1myk5cVrIRiUuAHlJWWZvuTJ7eQ/VvbxxJ93yN
         SsmMDyzUXuwQn2wTOJhZ8p5d1PF+SCYhvylPlveDqH+8xIdubJGV6YthTico+JLJspkJ
         yKAagM4+ZClv4KAR6k5z8HRSDShH1w5qp/myjdeQRAyUCuR9I6I2/mQIR9TrPpfO1x2i
         i2xIRaCC6k1492YBewkZ27iKzlc/YLrLoz9Hr9NwiPr/U4WBxagBtrXKVveonjXAdgIF
         cCtw==
X-Gm-Message-State: APjAAAVgu1Gst+N6/areducnRrp7eAW6vqE529RUn4suYIau9MBzB2xm
        JvU+mJ7U3MVcTDPiKhdYDms=
X-Google-Smtp-Source: APXvYqzToaADlCh1O24LcKePM3Adq4VD6qsF/0Hpwf7pjAU0Akl/IspNpfZd1ZDPxV85/tHHEdDMcw==
X-Received: by 2002:a5d:4c8c:: with SMTP id z12mr10214937wrs.222.1575213654407;
        Sun, 01 Dec 2019 07:20:54 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id b17sm36402090wrp.49.2019.12.01.07.20.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Dec 2019 07:20:53 -0800 (PST)
Date:   Sun, 1 Dec 2019 16:20:52 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, alainm@chromium.org
Subject: Re: [BlueZ PATCH 2/2] input: Change uinput name and set uniq
 attribute
Message-ID: <20191201152052.zxjbitwjfbsh7vh5@pali>
References: <20191127110905.BlueZ.1.I95600043ffb5b2b6c4782497ff735ab5d3e37c13@changeid>
 <20191127190941.90789-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ca3kub6z62l5xmge"
Content-Disposition: inline
In-Reply-To: <20191127190941.90789-1-abhishekpandit@chromium.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--ca3kub6z62l5xmge
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday 27 November 2019 11:09:15 Abhishek Pandit-Subedi wrote:
> When creating the uinput device, change the name to the peer device
> name. Set the peer device address to the uniq attribute instead of the
> name.
>=20
> The resulting uinput device will look like this:
>=20
> $ udevadm info -a -p /sys/devices/virtual/input/input17
> ...
>   looking at device '/devices/virtual/input/input17':
>     KERNEL=3D=3D"input17"
>     SUBSYSTEM=3D=3D"input"
>     DRIVER=3D=3D""
>     ATTR{inhibited}=3D=3D"0"
>     ATTR{name}=3D=3D"BeatsStudio Wireless"

Hello, as you already wrote in different thread, could you add
" (AVCTP)" suffix to name to indicate used bluetooth profile?

>     ATTR{phys}=3D=3D"00:00:00:6e:d0:74"
>     ATTR{properties}=3D=3D"0"
>     ATTR{uniq}=3D=3D"00:00:00:cc:1c:f3"
>=20
> ---
>=20
> This change requires an accompanying change in the kernel that adds the
> set uniq ioctl. The change is available here:
>=20
> https://lore.kernel.org/linux-bluetooth/20191127185139.65048-1-abhishekpa=
ndit@chromium.org/T/#u
>=20
> If this change looks ok, I would like to merge it with the previous
> change before merging since they're related.
>=20
>=20
>  profiles/audio/avctp.c | 18 +++++++++---------
>  src/uinput.h           |  2 ++
>  2 files changed, 11 insertions(+), 9 deletions(-)

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--ca3kub6z62l5xmge
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXePaUgAKCRCL8Mk9A+RD
UrjSAJ9pD1cg7HNECBSINFrhr5q3UMAJEgCgtWK2zMMvy3jswAXcPLE9Mzb9kGc=
=7pYT
-----END PGP SIGNATURE-----

--ca3kub6z62l5xmge--
