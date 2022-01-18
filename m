Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED68AC4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Jan 2022 17:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347090AbiARRN3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Jan 2022 12:13:29 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:44438 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238280AbiARRN3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Jan 2022 12:13:29 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 641931C0B80; Tue, 18 Jan 2022 18:13:27 +0100 (CET)
Date:   Tue, 18 Jan 2022 18:13:27 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Marcel Holtmann <marcel@holtmann.org>, johan.hedberg@gmail.com,
        luiz.dentz@gmail.com, davem@davemloft.net, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.10 001/116] Bluetooth: Fix debugfs entry leak
 in hci_register_dev()
Message-ID: <20220118171327.GA16013@duo.ucw.cz>
References: <20220118024007.1950576-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <20220118024007.1950576-1-sashal@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Is there a git tree with the autosel patches or other automated way to
access them? It would help the review.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYeb1NwAKCRAw5/Bqldv6
8qu2AJwMjdacc9ps8qkCgBaPyQgYGa1NzACgs+Y0P/cj9xx/gLtV+rP32Wa3NiA=
=E1Vl
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
