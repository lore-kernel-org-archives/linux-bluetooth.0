Return-Path: <SRS0=EsMn=TA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9871C43219
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Apr 2019 10:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EB852080C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Apr 2019 10:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556619876;
	bh=g5xduG0M1i8LmswLyio4BtyWSLQN+yUFyjOdD60a+ko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tbY3c4VkxkHshgzYc0/RFUG0ZORpetqcr2NyRInjKKButVjbElKAkkuLsEWqhUOi8
	 vMpUZ0rV/5k8WaW8hV9UOsnoe+dlszfMtirPVezGBeIwaWB2B4nxvPu61acI4sCmZg
	 858c6fAb5+GGTfD79o+QRLtGmL4KMc1Loo7cTSlY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfD3KYg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Apr 2019 06:24:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbfD3KYg (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Apr 2019 06:24:36 -0400
Received: from earth.universe (dyndsl-037-138-093-097.ewe-ip-backbone.de [37.138.93.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1115F2080C;
        Tue, 30 Apr 2019 10:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556619875;
        bh=g5xduG0M1i8LmswLyio4BtyWSLQN+yUFyjOdD60a+ko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uWROAV1A6/jHZerIIAaTvzxs+/vmVpHA80/CujN+0ypzxV7uJoKCLgc76n7Zwa+0i
         PrKfxmWlWRHgv3JbS/o9qHQn44ErNcrsiwYvR1rKbZM6aAmtXCJHymifBfv5tcQYgV
         NCfWJUwgQr7nRPB6DXtug/A6sbYy/NPwoltdqZFE=
Received: by earth.universe (Postfix, from userid 1000)
        id B9B653C0866; Tue, 30 Apr 2019 12:24:32 +0200 (CEST)
Date:   Tue, 30 Apr 2019 12:24:32 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 3/3] a2dp: Fix not calling SelectConfiguration on
 other available endpoints
Message-ID: <20190430102432.qo6pflsj75ktr34x@earth.universe>
References: <20190429120259.17880-1-luiz.dentz@gmail.com>
 <20190429120259.17880-3-luiz.dentz@gmail.com>
 <CABBYNZK1LRANfR6cwu+xbLsvy4EnB+ZPS78JNK04mJ=pwTGSDw@mail.gmail.com>
 <20190429163916.ngdqk437xbuahl4k@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xjnt3g6y64ofsdy3"
Content-Disposition: inline
In-Reply-To: <20190429163916.ngdqk437xbuahl4k@pali>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--xjnt3g6y64ofsdy3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 29, 2019 at 06:39:16PM +0200, Pali Roh=E1r wrote:
> Btw, for future patches please directly CC them to me as I'm not
> subscribed to list and either extracting them from '> ' quotes or
> finding them in web archive is quite impractical.

FYI (not against your point, just making your life a bit easier):
linux-bluetooth is on lore.kernel.org, which provides an mbox
download:

https://lore.kernel.org/linux-bluetooth/20190429120259.17880-1-luiz.dentz@g=
mail.com/T/#t

-- Sebastian

--xjnt3g6y64ofsdy3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlzIIl0ACgkQ2O7X88g7
+po0Ug//R4uz37I8OBz9peiVR3DV4euIr2z1vChW+hkG9Iv6T+BPL6Bf9A0EneLl
rjTZCACoONSYYbo8Xs6GCu1uXSal1qjEVgsjFPG7ZGUsS5pQ7Pkkx0W7JZZdQLI7
dx1ZAZf1pRgESG41ySAwOS4IIhMKfVVqa3TbmJiXO2TDFagioHwBCrKrhudoCXy+
8hBh0L+xA3Lq/TVh/fw6ny5LeCoLjdeWy2S8/qcFioGIGBPAxPqCKXOwzckwzWhR
24zbCxc8BVrXOR3ISMAEvw4efGr7j4sgXGiqZ16Blm+oL+tOJvlQn84naUEo9UmF
NQ1la6ucdUWES3umAJGenCgtYb4ck/ymF22iCRdeISysFMAxM0ue7u5D/JRnzPXA
g6J25I/nLgDMTcfwRd+lPEj/Y3geK8jVNIJb20T6n5bvGkDZzLbuI4LXs2pBpiCW
/VLceZtXQvTSdF8dNs0vUmx6kXTdnEQdtrjJjXDVaXS+ciMFb+p1A68xzXaoeOjZ
lD1naZNfmMipQqSUvvFQBfMLomHoMfZCxUpJ3qcG0RzX7SEI9rx8rAPQqqCH5aCY
FnbclWrBfasM+k53Mw/WLxx+2YNI2toS6TfsHhFZq6oE+guhDuEcA9C0hmpug2UT
qJiQ7F/CPEfYhdj3uzbiodSUmUXZpo6tQX7oHUNAQDGW5uiZDvI=
=G7xc
-----END PGP SIGNATURE-----

--xjnt3g6y64ofsdy3--
