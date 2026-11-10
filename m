Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.59.177.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794300335;
	b=erovdncVcgMZRp0QvPv77WpRuejG1qVscQwyqNyoymY/oM7zoojUEK2/+bX72r1WB1wh
	 1u+jjWkz5+51Hqc5g57yCUqTQlD0P0IOsHMVLMe0YRuDe6injZRAhHqJ3GI0gWL3CB8k7
	 UODuWmAM77BaIx3BSYrUQQdgFS4NjHN9q/oQK2YqZ1aYbf02AirRtB4xkM5fF90I6pk5J
	 pYH7jpDL+gskKS1yZMj+/8hfSikjBXL77PYPziispRlyESneHhUfwMe4QRDD+JyQr2H2t
	 dY3UYGJK9ySn9lrpmHgPnoCxwnu948w+3thnIE0I8hTYafrBFYBNmWERfe6f47O03pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794300335;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:Mime-Version:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 Content-Transfer-Encoding:In-Reply-To:References:X-QQ-SENDSIZE:
	 Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=sUto69GneM3/21N1G4JPtL94JDaDhP2/KjnoIeniECk=;
	b=HHMgpDwqUcAJ+E5aPOvvTGPqFc4dDBwfcczxfo9dFCq6ogwjHwhXwQZ2A9XzOhZp9FbW
	 NUR3fkikgtMZvJa7ZuJRTyEwluhjzzR73/DN2GlEggB3uZvSw1O6WSrA6jQq26wDhf0G5
	 GwMz9Y2/k+gnMsqf/R4l+UUHwHwpvXO0g4QlpbtoRDK1iHusNaEurwa70m+3mB6cCVkGa
	 bFvQW94HkDfDc/r3z47wX+qxXn3y7ihdLFPL/EyTuCneu5IdW4ubWA+altkVXBwiyDGzZ
	 +jwHevwv9S1/C1/qqXjK4lSCKuKAschpYDRclweg2Lv+s6ZWCLONuQFhdXOpeykZgsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux.spacemit.com;
	spf=none smtp.mailfrom=linux.spacemit.com;
	dkim=pass header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=Pmrp1zLQ;
	arc=none smtp.remote-ip=52.59.177.22
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA352606A31C;
	Tue, 10 Nov 2026 08:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA352606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=Pmrp1zLQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1794300281;
	bh=sUto69GneM3/21N1G4JPtL94JDaDhP2/KjnoIeniECk=;
	h=Mime-Version:Date:Message-Id:From:To:Subject;
	b=Pmrp1zLQtx/5nIr+Y5iQ2mlQeMA1CYwGweLyEYJAh7qy5//x4lI597D4KpAhYE8R9
	 JYWJDdpP5cWGd++UMpi1H7c4UCla7UMwVQRmY4nP/MysInDHirSrCzz2nWdqGU1Hw9
	 Z16dzNPqvJF7dDxht4xbY3dBQJyEr70QYZWWPM18=
X-QQ-mid: esmtpsz16t1794300279t7e784a46
X-QQ-Originating-IP: RZyIr1RkrL/Ze4oQ+7VPt95YCi+emVuRwyceRtOz8jI=
Received: from = ( [183.48.247.17])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 10 Nov 2026 16:44:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8600440983646492188
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
 boundary=18f11060a803f47ff361742ba8691daff4c6fbfbe03e1b9c377f4db00c26;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 10 Nov 2026 08:44:36 +0000
Message-Id: <DMRED3CXA5IJ.3FLQ7UFUTN0R9@linux.spacemit.com>
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: =?utf-8?q?Fr=C3=A9d=C3=A9ric_Mah=C3=A9?= <frederic.mahe@cirad.fr>
Cc: "Marcel Holtmann" <marcel@holtmann.org>, "Luiz Augusto von Dentz"
 <luiz.dentz@gmail.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Yixun Lan" <dlan@kernel.org>, "Vasily Khoruzhick" <anarsoul@gmail.com>,
 "Alistair Francis" <alistair@alistair23.me>, "Paul Walmsley"
 <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou"
 <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>, "Troy Mitchell"
 <troy.mitchell@linux.spacemit.com>, <linux-bluetooth@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <spacemit@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] riscv: dts: spacemit: enable Bluetooth on BPI-F3
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261110074607.363918-3-frederic.mahe@cirad.fr>
References: <20261110074607.363918-1-frederic.mahe@cirad.fr>
	<20261110074607.363918-3-frederic.mahe@cirad.fr>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MShfLn39PbN2APgg9dvNoZD0mnyzgy9+pWI3O+qvUle3b+72Hb0DW5jh
	+1gCDbjd+J6Io1XLGyUL13hxdi0ki1gq0pJ+KDFHfB/PxOpOwYu8ItIbIcCW+oH/XS3N/8S
	3frioK4ctTvZZ1UX8eLcegFjaLe/mfvqvycD1gu8jSaRR2aFiO5BRdO9lzjxgHppMC+uAD7
	ziP8QK5WcvnB7tTI3bvuspACf89XB65k2y7PIR1pThs9AkArppm5KfHtyBtVclpsdmmuDsU
	VfyfZ+CrsJ5HFDQSvsOwGPr0SC7Cx8kD5cirKakzwiqSbJJz/bXQC7S1ux7M6IYiJDppUXG
	ANqtTgZ4YadObYvv31A9sYRFxhk+xkksh1ydebGUTEx5tCTACBQfky8uSnAk4g4mb3ECQ7Z
	Wfcn+blF/AKUNaMCwoltRdF4AVbMwLdC+Y9A0czXxiroI062FNF25SVEzkburqCPIZ0rb1Y
	SDvnNcQXsZfqEcJfQZqNsofkskEnK0+QA9BoY5PXDDnQ2M1gJIxz6rz6hy3MNJ9IdxIqIVt
	qvtjCNE5yX45Y5n1adxttOhK0tdUexuAyG5kuwwKqNOiNWEj9UCzSfvKHOh4VBrGwaBK45w
	JJc0NSCtAriyyptUxrqLDP2f7imKpUM87cTaRcYv3hpFELUtMh5lFYzom+Os9jSh7yPahpC
	HUz4apRyc+iXTQXIWNZX5dwahwEi5dUN2OzsuSP+1uWt0tIDSnOXO6q3b+64VEvbjUVj3fW
	0Ukh+Fl7gJ6EBPBGyklAxHR47iHcGAwQb0ICJvb9+FKk9wpOGy9zJ7SkugIabFPSxaZCIpO
	yjY7F7HylA1FHqWzHNGlo44pMZXU6yETsISwUYavcdmGFtI3gvaAygBRxgOm/t9fCTenvUw
	zJw6SMh1JcNDXBKxlkTJFbV7B0wdAT5yeclqbUebsCH6Gg1y7KwgUIvumPMGAvxL/p4p3n4
	5iGR/MjDrnIEsmc1kLO7ofIJbFK878qTg+DGkYl7oOEXlktShgdkvraqlyL+Vm7P1ltc1XP
	qg8khqNHQFfsQQaP5ApNt4X6v0rK51vqbawxm53SB0KH1rquATxoPaiZmCIwiDZbMRWh7jm
	mpasRtzGCriChpZJ5QTUcw=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

--18f11060a803f47ff361742ba8691daff4c6fbfbe03e1b9c377f4db00c26
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue, 10 Nov 2026 08:46:07 +0100, Fr=C3=A9d=C3=A9ric Mah=C3=A9 wrote:
> The BPI-F3 has an RTL8852BS module whose Bluetooth part is on UART2,
> with hardware flow control. GPIO 63 powers Bluetooth on and GPIO 64
> is the device wake line.
>
> The firmware config switches the UART to 1.5 Mbaud, so take the UART2
> clock from the 48 MHz slow_uart2 clock.
slow_uart2 is a programmable divider (MPMU_SUCCR_1), not a fixed
48 MHz clock. Its rate is whatever the bootloader left there.

[...]
> diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv=
/boot/dts/spacemit/k1-bananapi-f3.dts
> index 58035d886..280adc9dc 100644
> --- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> +++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> @@ -383,6 +383,21 @@ &uart0 {
>  	status =3D "okay";
>  };
> =20
> +&uart2 {
> +	assigned-clocks =3D <&syscon_apbc CLK_UART2>;
> +	assigned-clock-parents =3D <&syscon_mpmu CLK_SLOW_UART2>;
Please add CLK_SLOW_UART2 to assigned-clocks and set it explicitly:

	assigned-clock-rates =3D <0>, <48000000>;

> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&uart2_0_cfg>, <&uart2_0_cts_rts_cfg>;
> +	uart-has-rtscts;
> +	status =3D "okay";
> +
> +	bluetooth {
> +		compatible =3D "realtek,rtl8852bs-bt", "realtek,rtl8822cs-bt";
> +		enable-gpios =3D <&gpio K1_GPIO(63) GPIO_ACTIVE_HIGH>;
> +		device-wake-gpios =3D <&gpio K1_GPIO(64) GPIO_ACTIVE_HIGH>;
> +	};
> +};

--=20
Troy Mitchell

--18f11060a803f47ff361742ba8691daff4c6fbfbe03e1b9c377f4db00c26
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJcEABYKAD8WIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCavLZdCEcdHJveS5taXRj
aGVsbEBsaW51eC5zcGFjZW1pdC5jb20ACgkQmAnvgPkzNC9shwD/ctzYIBUZsuLe
dMFLfduAxPc7n4ySob06tzWvF4yFEtYBAO20Qqsvk4E1YLuWVcrPvgvy6Z/0EImi
egn5XeWhGVkK
=3dgM
-----END PGP SIGNATURE-----

--18f11060a803f47ff361742ba8691daff4c6fbfbe03e1b9c377f4db00c26--
