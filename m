Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.92.39.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794447990;
	b=3OVEZhCp4B9aLdcKYys6OCqN7iOymoRiuXRQyEA4fnR/eJfMfhbcjourjeIkHalGZbf2
	 MoKEh+3WJKhr0You4CRRK2K4gmZx8PNcwDfxpheBKqQ/4O51fPeJTSBH8Ewq7F7r8/HoE
	 Rj9Ltgkwn7ikeaqFvBlBlrDMsMLRg3to+xC2jQTLotJvNFgunWxa+nQbPhe87BN9noP6W
	 +mOvMCpDHv8Zl24fQKaQ3HQ4o6c7qDPpp6DDzqO7UPBRtz/pBP22c6lhm3IfMx9jN1OG0
	 fG7H4Cq9sRWtNLu34GCgEOPFuRm6XvptSIdL2E43zabRsjtldIlovVijbtn28Dtqx9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794447990;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:Mime-Version:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=o9qbUelCx5fzvjlP9T4Xcmeuzs4IG3zEIHU3OITHRHo=;
	b=E0Fx9V9OqCUKgBAhAWpufzty4OiKcMmRPmDoxy9IJ/1GjQGhBwH/5g4LqvdBJAn1B1uk
	 04RMn4Hw7PUyjvaXOUn8ZEc1CoEwK1eXGDji0VShu7MeTQusd1X7Nhh91/xVMll1oOMXc
	 JI86Z1cgerWaaxV2hgEIpol7DOL9XhibgQxOBHE6Ga/BhxLwRuQtnpKmCpxhrALRsYK+c
	 eZgbnAwZt/Oo0yB+ZHmbRPjT4k9HJT9obRL/ENtoYCFf7cje2OeYJ/TwiAG+1QYNVajYm
	 b8nc6i5ZOxdwDtLKARONwoDaJ/RHHYRe8PzUC/ldK3oI5Bk2d+Xhu6YMSs60IADKNsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux.spacemit.com;
	spf=none smtp.mailfrom=linux.spacemit.com;
	dkim=pass header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=piyJX+OD;
	arc=none smtp.remote-ip=54.92.39.34
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CC8606A31C;
	Thu, 12 Nov 2026 01:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80CC8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=piyJX+OD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1794447957;
	bh=o9qbUelCx5fzvjlP9T4Xcmeuzs4IG3zEIHU3OITHRHo=;
	h=Mime-Version:Date:Message-Id:Subject:From:To;
	b=piyJX+ODZSYYaVvjlTI2Eq9fElkjSsMxECUYYfK7ObaUBsg5PgSevcsupPAxywNUG
	 M1V8o33I51bLUw7HNWTBkWtgIrCpBX6XsgTznpCjUmm4GjvzDmmTNdnXfXcOulnxIU
	 W9hxC8AC0AIVB0KOWtwu9w9G0OOccXGgnGlv+qEE=
X-QQ-mid: esmtpsz17t1794447955t84c88b44
X-QQ-Originating-IP: nAMxank+hAidb3QvsKnH0QjBdmBkxc00yYWvW0b9tzA=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 12 Nov 2026 09:45:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6514529535114007816
EX-QQ-RecipientCnt: 20
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
 boundary=d400da5dd7a138166c54bfc43864faed746c419ff16dffcffaf97ceb07d3;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 12 Nov 2026 01:45:52 +0000
Message-Id: <DMSUPKS0VL8N.1RUUESQVU8FMF@linux.spacemit.com>
Cc: =?utf-8?q?Fr=C3=A9d=C3=A9ric_Mah=C3=A9?= <frederic.mahe@cirad.fr>,
 <marcel@holtmann.org>, <luiz.dentz@gmail.com>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <dlan@kernel.org>,
 <anarsoul@gmail.com>, <alistair@alistair23.me>, <pjw@kernel.org>,
 <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
 <troy.mitchell@linux.spacemit.com>, <linux-bluetooth@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <spacemit@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] Bluetooth for the RTL8852BS on BPI-F3
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Luiz Augusto von Dentz" <luiz.von.dentz@intel.com>
In-Reply-To: <179442601916.1604530.1705197925952408060.git-patchwork-notify@kernel.org>
References: <20261111094557.443481-1-frederic.mahe@cirad.fr>
	<179442601916.1604530.1705197925952408060.git-patchwork-notify@kernel.org>
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OD73vtqOAFgqQdl8kVxlaorlGh6ZaUM7MaaEhliCvStV/AKYXHEQMwXv
	mE8cjPXzZoSMzDP5rS79pEFkS9v0Cuth3c55LR7M61G2e8XnCAOlpEjrxoh8bqs8GEKMTfm
	GTyWl/QZL70ACCCVQ6uj8Tlyf3KkE2JcX10i0FHHOsrnfmi5q+Ehkn3K7RXY3bZvU2FID2H
	UvN7y9rKiw77FT7s6GhJ4fx1S1RlRbt7n6OsPhwPZHVivwHdgz9O3mYH3bj7sr9CPzEsPiZ
	anYDNKhJiC+hgVRO+VxFCm7clKBTCO1/dpbNR1ml5GvrpEDfhV/2pIFyykr+YGZpQHxfY3p
	TJc9QYLV1u0QXALxLj4Val5hsZE7/CthI+Qownvjkph5L1F+EXqwyrq4eoP0YcK/ilmDAho
	ZvCFlYhVaBcsc2VU89cwcIOEQgZEehRzQdL+SJw7373sgvVEJE1Y4vyw/ms45GOTC2Q21Id
	OMUuGZ3QjPuQHbb8B7XixuiYzs7iprF3xJjXo0jmeKrNhDIZGvuaDAh4bySOqW6kLnAbV56
	RA+Y600SEiXKQWXcLbRFeMx6ywBNGCxG5a+UJRDhGRum8DpjlhmVG+CuhQ2RMmjgc4wr2TD
	d9jJ3pfBFkZ94W/W+gOn3AIKoBSv2bAM+/8wb+QQJ5FJNFooxGq+YiWh3LAhoLGuVsbgV+D
	cGyRNvuebtQHbocavAoJSFzS4BmjFe3dwxdXk0kd1Zcow1gxUfTvCHCmx0tZuh3HzTl/1bD
	l1/6KffMQMTv7+AgDGYqGXZ/mf93hOH0+JeQSGtCJb9BHs+QrqmdnYhQb8uRxyx+kBYUNNl
	06viwZorpHpExLypIKCmxYCnoJKmZprZWkCQBHUR8BYD7VkRJkGTe7sPXHBZu8AsEKY/jew
	aZH2f1ovWzm8emaBcAGSmMYWkhghxdY3HkVZc6ExcZXgl8mK7/cUEWu2d5kcUwGmCbG4Qji
	rdB4VW/J2kmthTdNN2Yl5OqyEXyWpT820kPtJaT3gkQUxcw6IWwrGWQL2IF+aHUev6hHd1F
	5OEfl/viYZ1xVcnkitMrNIqckdq/L55vhD+jfzXnkrJegcbhzOxEi1uwRca08Usj47dp6VX
	f8qGllmeqmKimpUt5M9OSQQo1cVnn7Swg2kYjxjGMTh
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

--d400da5dd7a138166c54bfc43864faed746c419ff16dffcffaf97ceb07d3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Luiz,

On Wed, 11 Nov 2026 19:40:19 +0000, patchwork-bot+bluetooth@kernel.org wrot=
e:
> This series was applied to bluetooth/bluetooth-next.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

[...]
> Here is the summary with links:
>   - [v2,1/2] dt-bindings: net: bluetooth: realtek: Add RTL8852BS
>     https://git.kernel.org/bluetooth/bluetooth-next/c/c21f8cff7503
>   - [v2,2/2] riscv: dts: spacemit: enable Bluetooth on BPI-F3
>     https://git.kernel.org/bluetooth/bluetooth-next/c/df348a0d065c

SpacemiT DTS changes normally go through Yixun's tree to the SoC tree,
and Yixun hasn't acked this one yet. The binding patch is fine in
bluetooth-next.

Yixun, what do you think? Should Luiz drop the DTS patch and you pick it
up?

--=20
Troy Mitchell

--d400da5dd7a138166c54bfc43864faed746c419ff16dffcffaf97ceb07d3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJcEABYKAD8WIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCavUaUCEcdHJveS5taXRj
aGVsbEBsaW51eC5zcGFjZW1pdC5jb20ACgkQmAnvgPkzNC9TDAD/fhHvVXqOkUxo
4u6rg6LrG/txpGkWipkP94X2k5PSn9EBAIezttdQYAric2H/Pw+q38b/NEdLHI/i
7Au69q7vwYkA
=ms2x
-----END PGP SIGNATURE-----

--d400da5dd7a138166c54bfc43864faed746c419ff16dffcffaf97ceb07d3--
