Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.59.177.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390770;
	b=ZlDXBm1fD8bdvGT5179cXeVGKC9XXxIj9JDY2KGJQIyagKzr1KCY5wIh3/x6ojQPVe6G
	 ir9Taz8/6/SIH6+bYgQBXrh5zgNgSLl0QlJtIltQ70UgdEJRPUKCRzfZXtiNS2rMb7YKz
	 RqJ9X+9Id12V/U69foQbHvpI53x4868ekK5P5xpip0JF4Kanh1alsVzsU/ZWLJDEvtlaA
	 mb/rGXI9TC4/qNhq08Mel/uEm1RLbiLftEegVe6MNZgZLykSx4dKV5Nj879OoKtczUrLv
	 LYCXTo57d9zBpPmirX8rMmIxwg0zZ8JAaLgugm3qIVTqUOeGt87oFGQUo9Jua9HqHwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390770;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:Mime-Version:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:References:
	 In-Reply-To:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:
	 X-QQ-RECHKSPAM;
	bh=GWi9Mrn0MCeiOZQc5+4kfVX0EHtk3DfuQOjdPxmcFTQ=;
	b=sju/4ZVVIBYq+z4DKEcrFIFgaXRJlJFsQuUxuf58S/Mf0GG79wtaYBnKtS1j4AW4dR5p
	 zgQbV5+9vCY0h6wlVcluWqRj6zBNLLM4SY4pPKKUAFt+hGs8TPRN3aUydUEJCsRddTjIW
	 KDsuefARekHkD0XO9wAUZGH/nWwBUAglMquGEj4Nxl09BzTJPWnrIO6d5RaSQ8L7rtfeE
	 xWjTwa7VMc+8831L6l+vhv/3846o2RQATA5OxB6jTK8tzcsO6zj10peEX1UvEkHSuqB2O
	 Q2JRmOCUlIkHmyodZO34nRSTyw14YfkCPO8y86mBEqGMszR85HprB44TmPXAh7swGLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux.spacemit.com;
	spf=none smtp.mailfrom=linux.spacemit.com;
	dkim=pass header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=f7+rYJlO;
	arc=none smtp.remote-ip=52.59.177.22
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC9C606A33D;
	Wed, 11 Nov 2026 09:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DC9C606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=f7+rYJlO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1794390708;
	bh=GWi9Mrn0MCeiOZQc5+4kfVX0EHtk3DfuQOjdPxmcFTQ=;
	h=Mime-Version:Date:Message-Id:Subject:From:To;
	b=f7+rYJlOFA26NTV0INBR35r0W21EOZe4WDucyr825KEFuCV1tXwNLgeCkfWBesNgj
	 OaP0KKJUiu4Y5UgsgNJIIHnyZg15a2FiSX87V5z2Fa4vZHpf+1ST88QJDW5t4++MNa
	 6KJlGjyANok5Rh/+YwWbgVe9TB7mE4viCdr8qmhs=
X-QQ-mid: esmtpgz16t1794390706t35ab9cf1
X-QQ-Originating-IP: 7/3GNwEBAt+0SADWshzJh1j73v8R28IgqdTX80eo1hM=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 11 Nov 2026 17:51:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6762194668848470308
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
 boundary=25e53c27b1c6852924479b566cbfa263ebbd1c7ea96f00b6a8984ab5ea2b;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 11 Nov 2026 09:51:42 +0000
Message-Id: <DMSAF0L4F8ZU.1R534QOL67WB5@linux.spacemit.com>
Cc: "Vasily Khoruzhick" <anarsoul@gmail.com>, "Alistair Francis"
 <alistair@alistair23.me>, "Paul Walmsley" <pjw@kernel.org>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Alexandre Ghiti" <alex@ghiti.fr>, "Troy Mitchell"
 <troy.mitchell@linux.spacemit.com>, <linux-bluetooth@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <spacemit@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Conor Dooley"
 <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: net: bluetooth: realtek: Add
 RTL8852BS
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: =?utf-8?q?Fr=C3=A9d=C3=A9ric_Mah=C3=A9?= <frederic.mahe@cirad.fr>,
 "Marcel Holtmann" <marcel@holtmann.org>, "Luiz Augusto von Dentz"
 <luiz.dentz@gmail.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Yixun Lan" <dlan@kernel.org>
X-Mailer: aerc 0.21.0-reader-ipc4
References: <20261111094557.443481-1-frederic.mahe@cirad.fr>
 <20261111094557.443481-2-frederic.mahe@cirad.fr>
In-Reply-To: <20261111094557.443481-2-frederic.mahe@cirad.fr>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: M83iEva+1QDBUBgdA7sSAtJcG3q5n/Zygl/jupVTurhnL4J4aBVtHSbE
	icNuHZVnyuKnrEe8xPNF8sjgyZtuyeDzcEZ0hebOWObGvoTG9OgrMG778xKPKL464aFiRux
	IoBuUmmOSZ47LZHGIvkdvdLuv/rQIBu4xw02iNIWRy1cnMppQSIwZZ4ZRY8wKZkln4iqDWX
	j3EK6Gjio29t3T9V55wvT62Q3dcppbiGhQ5g44W+URE0piS3QJVakXdZ9IH8r5gv0VlqKzQ
	kyby+dpDxy40j4+DuVLlkisrw0Vn/wfDU2KbpEGcfpqJKP5RGUlv4OH01bbE5uOETUpUMuI
	EIgLK+Y9kPim3QQvXhdUXZZXDp64ttK1z+QnL6wXae6oWhCz4BAkPZN57kn3kXElG3Z5Lfi
	rNkwe2B2/cVaVQZUuqyz7Pt2yEg+XGao8C3E2sLI9g3zAX1G1gtcFIe4df4Yaw4IetWg7PN
	oQnbYjygK3OOWeLitGY2nFnSstepc7C6UArtns4XlkeMGYzMEReFmKxQ6bM1zHuV/xAtl2N
	E2qu08efNj4RAF74CDMQdD2iTH+EuY/9pgEnWJsiJIaSytGzDmLaix6II1226hB5oF6M8Qz
	Zb2moevaDdTHMv+Ljb/4S8hc/ghEHx3u6iH6HcsD3fR1ANAx9Vd4K88Novrk1SCm0W+vin8
	7Cl6itjMSB/3BhNmf1bOXIwpTpI2C0yMacu1eNYB8CpqBcK07MUdI2MrV8Gvh6JdOQysqM0
	3hlHx9YBAZG8rGrvPfMMBQYS6r8h7dw8mcfZH1Qz1ZFEDpYxDrfLnOuCrWN7XEwbypZEWB6
	S1/xIx3e0tuB6AsahnqXkRSha5KyjF48t2jwVtrybsMPqopnEYHeab8UWQGI3/ruPg9yV6v
	VrdJFnNTSscLXfeFgfd1Yz3W8KoDGH2Fc8tVwJaSI2IQZpyfhnschD5K3sS7qK0PbgZBU7V
	w+HghMIBs+cugiPWEMd/z35Ril+6DUv45ePwEHq+l7vwjo97Vx9/+p3n0hRYpgquNxeP267
	dNzhlDCNG3wEHwZyPMcjgIyvZUFIz154GfvRnU5l8JrkgapwK5vHpGte+tg+KhckvmmLhwh
	A==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

--25e53c27b1c6852924479b566cbfa263ebbd1c7ea96f00b6a8984ab5ea2b
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Nov 11, 2026 at 9:45 AM GMT, Fr=C3=A9d=C3=A9ric Mah=C3=A9 wrote:
> The RTL8852BS is a Wi-Fi 6 + Bluetooth 5.2 chip with Wi-Fi on SDIO
> and Bluetooth on UART (H5). Its Bluetooth part works with the
> RTL8822CS driver data, so use realtek,rtl8822cs-bt as fallback.
>
> This patch was prepared with the help of an AI assistant (Claude),
> which also ran the tests.
>
> Signed-off-by: Fr=C3=A9d=C3=A9ric Mah=C3=A9 <frederic.mahe@cirad.fr>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Alistair Francis <alistair@alistair23.me>
Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>


--=20
Troy Mitchell


--25e53c27b1c6852924479b566cbfa263ebbd1c7ea96f00b6a8984ab5ea2b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJcEABYKAD8WIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCavQ6riEcdHJveS5taXRj
aGVsbEBsaW51eC5zcGFjZW1pdC5jb20ACgkQmAnvgPkzNC+JWwEAo3AjrXyZm7p4
9ZEUTYiTXAsJq4AVvELJfl2OA3dhFlYBAOWsMtFYDasIhrqeWg8qqk6/Kagb+qd1
IfEbAOyLKHIJ
=CYdm
-----END PGP SIGNATURE-----

--25e53c27b1c6852924479b566cbfa263ebbd1c7ea96f00b6a8984ab5ea2b--
