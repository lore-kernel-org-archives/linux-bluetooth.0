Return-Path: <SRS0=G1Nt=XZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E4EC32792
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Sep 2019 22:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B37DA21855
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Sep 2019 22:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569882841;
	bh=ISUtgowUUlOBG9tC6LlpHlkEKmAkDDDE4cTTZB+2Z68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=punFXQfA1zUZQ/hBNKHOfzjKVJphXQlAJZStSxC0hPsAHVxax77jmuGjnPh1onCIy
	 eOrvRI+ttBE1Dzww+ju8rOdGmXXi3clIpn21wdBcRiLuPy5GeMn3NKCw55M1qNQgK/
	 Wb9ZW08M8lxgR69URaYhz4RKCG9IzQbF4OmvCcsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfI3WeB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Sep 2019 18:34:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbfI3WeA (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Sep 2019 18:34:00 -0400
Received: from earth.universe (unknown [185.62.205.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E52920842;
        Mon, 30 Sep 2019 22:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569882839;
        bh=ISUtgowUUlOBG9tC6LlpHlkEKmAkDDDE4cTTZB+2Z68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R/vGfivyxO0EQOoZJilucBMK+Ggb7FG/PEMeT7JlM4a1pePlH6Q4U1Tp4eKJyh0I+
         Gpz/JjFFm/BLnAYTl8V1jk7rcEkdYpKHlbobFjSecMN9eclILTSBPJZpui5Uh5cVrA
         Mk5/0gEOFKk0tyLzmTl7O5ihrL92nbm8ly6JQ6fA=
Received: by earth.universe (Postfix, from userid 1000)
        id BC02A3C0CA1; Tue,  1 Oct 2019 00:33:56 +0200 (CEST)
Date:   Tue, 1 Oct 2019 00:33:56 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     Linux-OMAP <linux-omap@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Philipp Puschmann <philipp.puschmann@emlix.com>
Subject: Re: [PATCH] Bluetooth: hci_ll: set operational frequency earlier
Message-ID: <20190930223356.z6tiv4v5yrqtzu2t@earth.universe>
References: <CAHCN7xLOCC00UC4PB3vHa6Q7yyhXVEaWgx2X9D9L2dDubd_5fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="niqozkc3jiirtp7i"
Content-Disposition: inline
In-Reply-To: <CAHCN7xLOCC00UC4PB3vHa6Q7yyhXVEaWgx2X9D9L2dDubd_5fA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--niqozkc3jiirtp7i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 30, 2019 at 03:10:18PM -0500, Adam Ford wrote:
> Is anyone else having issues with the hci_ll after a2e02f38eff8
> ("Bluetooth: hci_ll: set operational frequency earlier") was applied?
>=20
> I have an i.MX6Q with a WL1837MOD attached to UART2. After this patch
> I git a bunch of timeouts when initializing the device using the 5.3
> and 5.3.1 kernel.   I know a bunch of omap and imx users have done
> some various tests over the years, so I thought I'd ask.
>=20
> [  195.911836] Bluetooth: hci0: command 0xff36 tx timeout
> [  206.071837] Bluetooth: hci0: command 0x1001 tx timeout
> [  214.231862] Bluetooth: hci0: Reading TI version information failed (-1=
10)
> [  214.238712] Bluetooth: hci0: download firmware failed, retrying...
> [  216.391834] Bluetooth: hci0: command 0xff36 tx timeout
> [  226.551843] Bluetooth: hci0: command 0x1001 tx timeout
> [  234.711856] Bluetooth: hci0: Reading TI version information failed (-1=
10)
> [  234.718705] Bluetooth: hci0: download firmware failed, retrying...
> [  236.871832] Bluetooth: hci0: command 0xff36 tx timeout
> [  247.031837] Bluetooth: hci0: command 0x1001 tx timeout
> [  255.191852] Bluetooth: hci0: Reading TI version information failed (-1=
10)
> [  255.198706] Bluetooth: hci0: download firmware failed, retrying...
>
> Can't init device hci0: Connection timed out (110)

I can see the same messages on OMAP4+WL1285 based Motorola Droid 4
(with the same commands resulting in a timeout).

> Revering this patch fixes the issue,

Ack.

> and subsequent patch proposals form Philipp haven't seemed
> to fix the issues for me on 5.3.

I did not do any further tests, just noticed this while working
on another patchset.

-- Sebastian

--niqozkc3jiirtp7i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl2SgtEACgkQ2O7X88g7
+po4/g/+IGM3j5jfpYzr+RYoNYjBkQPYgwWojq8LpIwfihDVFs6NCfjt3f1G0aJ+
zDczVpLC/Pnj6ltnfliLUAuyhOM94+unB/yOCKtKIwSWMX+wgofyITm6rSxlAM0n
SoqgY5TkNXUBv0wMoJse+6wqOBsMZ/mJg6vpP7L2IjP5s668MgoD4wPADi4mJ0p7
9L68Of5PodwjXMnTQG8FiMezaetSiLGNtFBFBnRY8R499AhldpDf/uDSafaFNNyg
U+K4fBYhFFcYECQI3UvFD6vhytH49dSzOByCNjLsf0je7g92qbm1bZV0FomTuFrJ
ni5px6yFV+svNgo+w+n+jFrDpzutkU91jp/TGJpGDHb2QaztQ8gGHb/R68ZkFPko
y9r4f3y6N6d44oJnxpEPerDw0jKyfNQ3HbLZNqHTWQPOLqVy9V3S4WGF9AZ5fgWG
Jd0tkAh2mjryNjwKv6z0JnNA6PBMSyle0C1wdwxExL2QNqmNKf6C16ada2N32anb
QqYKj/UcA86Qad0rDwdY8KLj784/7+1yUgO+LUtv3ZYv9lUgbHcb1EB+/5jaNOvv
X17dW2bTu+RXYefM3Uq/DI2wxSg6umFfjCmou/yJiqa7O8yfkmzGlmywNBESCRfZ
TcUjqJROSUaYKi6JZwsuaBsMqgeMlfsk97HgBkVF8RxiDTtNEiQ=
=P+sU
-----END PGP SIGNATURE-----

--niqozkc3jiirtp7i--
