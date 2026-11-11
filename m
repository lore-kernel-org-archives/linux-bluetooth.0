Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.92.39.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390767;
	b=CNkmATMmEoevLRdA+k86Bg9sLP85A1jHCpQQpfRnDxXU9uV5kW9Kok0XUOhUSHgEdkO/
	 0bsRTILTTOVpV+p7RvVein5nf6lWpP/4yG90lpa+gfZZK8OifJXlcXprToQ7LX+bDeuv3
	 GbfNuCokWByGlAEQpREoYS20OmSm9Wez9xIQEK4J/wg+vCiSsgD5H6yMs+EI2C+j+4Rcl
	 s32HsZ7KgF7irbwAoLlU2cEFkWi9KwOkRQkmahOmaLp2DI49oXCSPM2FZ177zGWHkgG1w
	 hEzC9Fs+6sCLpSKz+5uwK3iXjuIEMcbBOHyp9wpCdu2J4PEFIKX2+RdpNZgxtqiXB/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390767;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:Mime-Version:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:References:
	 In-Reply-To:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:
	 X-QQ-RECHKSPAM;
	bh=DG1BenR9t2CnTlPb8/ogURcL1e6BMKuUq7sc1gbDGHo=;
	b=el5VGSGnQQkUBctKkPgz3LzrYzGGov03zSuceqxs1pLdBTJaupwuHJvtsLqt4IOs3oL0
	 6e33UDLK8VBPFioeHcXX70gadosZ3SooWfunRf7YqvwJQt5IkEslcuOtmV5k1lMOWWj/y
	 Ppf/eB2lHIm6jzVsX0i2tM7bbKqrKugSeg2lbwxTG5f4Ga326bk2/AzIw8653rg1/p77Z
	 jTxIaU/4LY+tsYzXmhdGQjXecNkdVqBUrKFJUDYRoGaZ+P3t1wJW5jxduzL4+ass0QiHd
	 dAc8m7f0znjdeti5n0CeRh/jSfXhppwfvv9+5SdrUw0czaOkjGCxVIDYbbxN8ixsllg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux.spacemit.com;
	spf=none smtp.mailfrom=linux.spacemit.com;
	dkim=pass header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b="mjG/+kMn";
	arc=none smtp.remote-ip=54.92.39.34
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A741606A326;
	Wed, 11 Nov 2026 09:52:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A741606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=mjG/+kMn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1794390726;
	bh=DG1BenR9t2CnTlPb8/ogURcL1e6BMKuUq7sc1gbDGHo=;
	h=Mime-Version:Date:Message-Id:Subject:From:To;
	b=mjG/+kMnUZWetaFV2Vgby66+o7QHCPRGnJHM+Bh/iaW6tWiRlrgQtd2xeCaAP0gzZ
	 j4KvD70sugn679HzzhTC/Izg5XFeaR4rjKNu0b7IuYdxgeddjVIdqJ13P3Xj2oNdZ3
	 3n3ngqxTuJ3xejINVe1W681A6WlVncjidL7IbWUA=
X-QQ-mid: esmtpsz20t1794390724t563d4722
X-QQ-Originating-IP: fXB4PNbNwEfDwLguUILLu5oL1M0xcKGD1gmFw5eQsO8=
Received: from = ( [183.48.246.46])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 11 Nov 2026 17:52:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1931649316664943864
EX-QQ-RecipientCnt: 19
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=6359a66ba761be3e5a04adee6e9d479520c40fb2731af54d02b8be3e9469;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 11 Nov 2026 09:52:01 +0000
Message-Id: <DMSAF9BN11D0.IDM8IS01DE6B@linux.spacemit.com>
Cc: "Vasily Khoruzhick" <anarsoul@gmail.com>, "Alistair Francis"
 <alistair@alistair23.me>, "Paul Walmsley" <pjw@kernel.org>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Alexandre Ghiti" <alex@ghiti.fr>, "Troy Mitchell"
 <troy.mitchell@linux.spacemit.com>, <linux-bluetooth@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <spacemit@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] riscv: dts: spacemit: enable Bluetooth on BPI-F3
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: =?utf-8?q?Fr=C3=A9d=C3=A9ric_Mah=C3=A9?= <frederic.mahe@cirad.fr>,
 "Marcel Holtmann" <marcel@holtmann.org>, "Luiz Augusto von Dentz"
 <luiz.dentz@gmail.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Yixun Lan" <dlan@kernel.org>
X-Mailer: aerc 0.21.0-reader-ipc4
References: <20261111094557.443481-1-frederic.mahe@cirad.fr>
 <20261111094557.443481-3-frederic.mahe@cirad.fr>
In-Reply-To: <20261111094557.443481-3-frederic.mahe@cirad.fr>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MQATRXU0qUVPtMJGdV/qYTqHVHYqtOb/+8WoFrBTaqq+ETn+zwvGt12e
	jAap32TdQuikSDDRXc0uznT5uAUwCr2P/ZUlr8iJ2rwGTb6V8BgJE+iFrPcBHulhC4X9EbE
	D3u5LQXFmzXULkNAyslr77brZ2cFoUDzPRXgamKRGyyoWlhhe5fbSty5LYarOKSnmkWdEVC
	YqHnsSZ+VopkKAGHvPFLpUT/UMGwQoyu4WSnuS6JHbVKJ7mxQ0ZQv+9M3mSLTsaBhUBrP4e
	CLy5s6grLFbF7VtffsL01J2w/q6XcoSIOOrc1hBzG8dO743sWUb0YtFDBn9+12MT4gHDnfB
	lFv/gbBFWilS8far+1/DVtLzzMEWGs/NKPE+zniTOnL3ePPLutoRh00fXYFbf3XCfFimA0T
	Y0TN7KRfLh7GuyIzrLyUqxpmbiSn8nuPnfet1Z7wsrB22XY5UdbQsMXAw1EHONLgXc0KY3Q
	/DknF6ft5eBBTr2fAVx1ui7OdzE9SVDOfXW/LNzqfTEXwzAWBIgLVhq9sfN90l2MbJ2Cjay
	63BJJWLVFrefBmXYCfr+dIzGdR2GxY/iN1y/SNlcpHTicnZkjp38Gvr78G6v7snFLvVV3L5
	pJui0ETk8VGkhBXBRMfnPL1gx1HihvLz7gJM8eLXpMDVVJtz0K9XBzVbbYodB8pliGyS487
	Z/4DF8i/G0CIWQgNzTrvDz0RfmFa3+4OPdL9G45kaUCd4XbSoyIZ9Yg+r4PJuCN/DKnShAv
	VlXu5JNP7eCS61AwCGOrCZV4jbywshcnD1r5ccA3N6+ToABYB6awhv9xUV1oNfuxJ81m9MF
	mQmKXS2kOgH6o7eqd7vbhnFA9dxB/hTrJp8qEU8CT8cbbybKPq3HFIy77BNVa6MfuaA2qz+
	pn6tO+0UmnPRBN23OlKh/q+o88sBmF/p2KijUYWuhftFrRXRFT3YFWFGXVHHw5+YxmW0jWM
	mqpkrX+6kJC7oSyCFdwYYGF8VSgfufvomqgF3xN51P+ZU/X3yZQdvPSpuR+nfimVLUYRCv4
	YKdwFdW5aJO061sef03Y+2+nk25uNf+44pNE3ZK+19rmWVJViKlnfThxZMEZ1XXTAYd3WS8
	wt5nFb17B84g7MNTSISy8Q=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

--6359a66ba761be3e5a04adee6e9d479520c40fb2731af54d02b8be3e9469
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Nov 11, 2026 at 9:45 AM GMT, Fr=C3=A9d=C3=A9ric Mah=C3=A9 wrote:
> The BPI-F3 has an RTL8852BS module whose Bluetooth part is on UART2,
> with hardware flow control. GPIO 63 powers Bluetooth on and GPIO 64
> is the device wake line.
>
> The firmware config switches the UART to 1.5 Mbaud, so take the UART2
> clock from slow_uart2, set to 48 MHz.
>
> Tested with a laptop: scan, pairing, and l2ping in both directions,
> including incoming connections while the UART is runtime suspended.
> An 8-hour soak (an HCI command every 20 s) showed no errors.
>
> This patch was prepared with the help of an AI assistant (Claude),
> which also ran the tests.
>
> Signed-off-by: Fr=C3=A9d=C3=A9ric Mah=C3=A9 <frederic.mahe@cirad.fr>
Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>


--=20
Troy Mitchell


--6359a66ba761be3e5a04adee6e9d479520c40fb2731af54d02b8be3e9469
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJcEABYKAD8WIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCavQ6wSEcdHJveS5taXRj
aGVsbEBsaW51eC5zcGFjZW1pdC5jb20ACgkQmAnvgPkzNC+EYAD+PVfe6aNSkOPl
AkTo/K9XuL9d/7QM1aSnDy4F1QOkuwsA/36C73njG07WkyEjw5wg2ulhtMmt7wNc
2/e/DVeUUG4B
=v4s2
-----END PGP SIGNATURE-----

--6359a66ba761be3e5a04adee6e9d479520c40fb2731af54d02b8be3e9469--
