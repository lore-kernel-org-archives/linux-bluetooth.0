Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1C5C433E0
	for <linux-bluetooth@archiver.kernel.org>; Sun, 21 Feb 2021 20:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B57764E86
	for <linux-bluetooth@archiver.kernel.org>; Sun, 21 Feb 2021 20:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhBUUgl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 21 Feb 2021 15:36:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:41176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230174AbhBUUgl (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 21 Feb 2021 15:36:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B768B64E86;
        Sun, 21 Feb 2021 20:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613939759;
        bh=62pblr5PKwtl7r1W6CVV/N21T1Y68VBAk4kKZYHcIw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EMmpefgwQiboemyixGKxEA/xqCYHSvI32QBR0mJDthQTSsp2gByDsefnDLHZme3p0
         Z50dYGskwtcrXpk+g1xS0nJgRqs6t29g/zcdG2EZ6u9eO/fTHy0mSw7jx0e9Yx0aWY
         zkVPwFnLkksfYC1CDFl7QP5bLqC2emTP36WL30MDZcoLBnm2E+itHBITLZ+ZOLq1ca
         6iobcUGb/ek+hPKB0wMP0LAPp6yoj+u/ZRu2nv/edXsrIFFqBn0wG61cvoT7pJImUF
         f6iFGymgNHOa7K9p32UWLfnrlk2ERzTaVq8GrjO3Cn59FGtLsUcuphVAcn1P2dQUSy
         ItTUUiXx5GlBg==
Received: by earth.universe (Postfix, from userid 1000)
        id C1F5F3C0C96; Sun, 21 Feb 2021 21:35:57 +0100 (CET)
Date:   Sun, 21 Feb 2021 21:35:57 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     stable@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Trent Piepho <tpiepho@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hilda Wu <hildawu@realtek.com>,
        Sathish Narasimman <sathish.narasimman@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Hsin-Yu Chao <hychao@chromium.org>,
        Amit K Bag <amit.k.bag@intel.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        kernel@collabora.com, Sjoerd Simons <sjoerd@collabora.com>
Subject: Re: [PATCH] Bluetooth: btusb: Always fallback to alt 1 for WBS
Message-ID: <20210221203557.wcmukv77sng25bql@earth.universe>
References: <20201210012003.133000-1-tpiepho@gmail.com>
 <7ADF39E2-647E-49E2-9C5B-B0BF6A303B95@holtmann.org>
 <YB68RUVLRGQKS+yH@dawn.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wercdu6qitq2sblv"
Content-Disposition: inline
In-Reply-To: <YB68RUVLRGQKS+yH@dawn.lan>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--wercdu6qitq2sblv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[+cc stable@vger.kernel.org]

Hi,

On Sat, Feb 06, 2021 at 04:56:53PM +0100, Sjoerd Simons wrote:
> On Fri, Dec 18, 2020 at 10:23:08PM +0100, Marcel Holtmann wrote:
> > Hi Trent,
> >=20
> > > When alt mode 6 is not available, fallback to the kernel <=3D 5.7 beh=
avior
> > > of always using alt mode 1.
> > >=20
> > > Prior to kernel 5.8, btusb would always use alt mode 1 for WBS (Wide
> > > Band Speech aka mSBC aka transparent SCO).  In commit baac6276c0a9
> > > ("Bluetooth: btusb: handle mSBC audio over USB Endpoints") this
> > > was changed to use alt mode 6, which is the recommended mode in the
> > > Bluetooth spec (Specifications of the Bluetooth System, v5.0, Vol 4.B
> > > =A72.2.1).  However, many if not most BT USB adapters do not support =
alt
> > > mode 6.  In fact, I have been unable to find any which do.
>=20
> > patch has been applied to bluetooth-next tree.
>=20
> For easier application to the stable tree(s) this should probably get:
>   Fixes: baac6276c0a9 ("Bluetooth: btusb: handle mSBC audio over USB Endp=
oints")
>=20
> In my testing this indeed fixes mSBC audio with both a Belkin (Broadcom
> BCM20702A, 050d:065a) and an Intel Bluetooth (8087:0a2b) adapters.
>=20
>   Tested-By: Sjoerd Simons <sjoerd@collabora.com>

Tested on Intel AX200 Bluetooth (8087:0029):

Tested-by: Sebastian Reichel <sre@kernel.org>

The patch has been merged to Linus' tree today and I think it should
be applied to the 5.10 tree, which is used by Debian. This patch is
required to use BT headset with bidirectional-audio in acceptable
quality (That also requires proper userspace software, e.g. pipewire
0.3.22, which Sjoerd uploaded to Debian experimental).

Patch applies cleanly on 5.10.

Thanks,

-- Sebastian

--wercdu6qitq2sblv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmAyxCEACgkQ2O7X88g7
+poTOA/7BIfVEMLI8RRz7+F2HQiJXwieTVgLSHIVc6EADDgK/K0BCkFYUX+bHSkL
BQ7PbVqhS77A9EtDrP0aMNioC126fKKMJ4uePBnhCzyHN0YpZwPmriagu6MlOMUh
xYGNMAjLk3e6jBusaGSGkIzN43LkjDJmIwYn4NDrUxceJa+VGoTkEVhGhPMOa2zj
AbVIGetuWY5Q9pqzzUgJnaFnqNflsA6NZQ3IuCrD0pi2SKwkzKOglk1+MgxUmUVa
HdSIeLNyOJLoGDS0Qr6Nytma3S0frYrcru2w1zQ0S1/fujWvSP+io4PNuceXo6Vj
+c71oggRPjRbZowXvPkYvJN7yAKr07h7YfsCf6nXAf0XHSSea3kxmQrn3xgYRNTG
Pf0Xx7IGPptpOLt/Lym8b0dDQc8483I42QLQxtwDvrk9hCjC5ifFu3jNfBdoZF8K
/kFtIHWk/1FVNoyRWSeCf/Wi1/Z4zkoEzkzBdufcujY05vj/43HSxZb7ttlZRmkB
1uG/I3JIdJUOdUU9EWqea65NKd8HnU+zMyb6LjXhfI0eyy7FyhAuP6n/qnRdoKfM
M/RE3PtnuZPsk98OMgpJ4TPJnyFyoOA9zxn+wtfTbaxmRy6hIFHf4alB8FPaWg04
H2vJG5xfugXrOln8u5wwtl2ZckmzFAUY58ylQsvpy1QlWG0qxNE=
=K/qZ
-----END PGP SIGNATURE-----

--wercdu6qitq2sblv--
