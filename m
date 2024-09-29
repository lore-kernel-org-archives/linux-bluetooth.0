Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C721E4B0
	for <linux-bluetooth@vger.kernel.org>; Sun, 29 Sep 2024 08:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727598339; cv=none; b=BLMWne2mtlGq+GWI4pXpV/y10wjalM8fVYGDHYy88ApLrpTiHef+lqZAVf1V3p3bxw1HgUxsPJpBqMxI5RWHQ+6Eo/NrDiRniT0dR/yM2c9UZMezbPptgl3cWibkKLH3eEkWAdce/lqLWAxhjxrSAWq/J3plPApk9L5Ue3w9A+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727598339; c=relaxed/simple;
	bh=k6SppduUKU3JGg1fWi14sVMD3eTuD4vo9gOVOUpOICI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=UaM5NgqPePdfXAZLwB6a/RXr492sqFDRoIyJwxusJyy68VW+OlzONWYgRwFN+72rThdb3wJ6uHwq1qLBXUzTFF6pLrtWxVEBFwMbL1SqENh1E+XxpK8WmHe4M629lxE5fy7PLptXOkk1KZ9XYoaGwnZVMjhFJowRIZyhn3Lgo+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=KcWF7fFq; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="KcWF7fFq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1727598267;
	bh=k6SppduUKU3JGg1fWi14sVMD3eTuD4vo9gOVOUpOICI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=KcWF7fFqkAXH1HT9DhW88JfIdoGOaVh31+qMp5kJBxF954DH3nvaU/kelVNCwFEJM
	 Z2YLK8Ir76M7zVQ5GwUA5nVoeqgUbncuz2fxbHUZ85z8NkfzOqNDJQHSU2MWpO28M3
	 K33cv69aCKfr9GeLA0QbmZpxgL8BpnctvZ6s1bJ0=
X-QQ-mid: bizesmtp86t1727598259tqq2b3km
X-QQ-Originating-IP: qCmwn2P0eJXYEJvCqX9wDgoZtkhFe7MnmYNhiWlStS4=
Received: from [10.20.53.22] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 29 Sep 2024 16:24:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10790167505109477571
Message-ID: <20E3795420C6CF06+ececafaf-0a3b-4e3c-a56e-448f50c537c6@uniontech.com>
Date: Sun, 29 Sep 2024 16:24:16 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND.,v2] Bluetooth: btusb: Add MT7925 support for ID
 0x13d3:0x3608
To: linux-bluetooth@vger.kernel.org, bluez.test.bot@gmail.com
References: <34A24B6870318797+20240929074852.977045-1-wangyuli@uniontech.com>
 <66f90d4b.170a0220.288304.076c@mx.google.com>
Content-Language: en-US
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, johan.hedberg@gmail.com,
 matthias.bgg@gmail.com, hello@felixjara.me, wangyuli@uniontech.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, guanwentao@uniontech.com,
 zhanjun@uniontech.com, aaron.ma@canonical.com
From: WangYuli <wangyuli@uniontech.com>
Autocrypt: addr=wangyuli@uniontech.com; keydata=
 xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSKP+nX39DN
 IVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAxFiEEa1GMzYeuKPkg
 qDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMBAAAKCRDF2h8wRvQL7g0UAQCH
 3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfPbwD/SrncJwwPAL4GiLPEC4XssV6FPUAY
 0rA68eNNI9cJLArOOARmgSyJEgorBgEEAZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7
 VTL0dvPDofBTjFYDAQgHwngEGBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIb
 DAAKCRDF2h8wRvQL7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkU
 o9ERi7qS/hbUdUgtitI89efbY0TVetgDsyeQiwU=
In-Reply-To: <66f90d4b.170a0220.288304.076c@mx.google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------kF4g1z672TtdiqJ02ivacGnm"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MVkZiY22hz/mhmqmCOdyNh5Nroz40db5/YpVA3RDPfz+5jaId9+EQIVQ
	esorRbGhl2EYcXSlyr+RZtDZi3cvuPsPalOeVF70TYtdMHzMUBq8ntrh+RkNy72SXqpgtR5
	/iqs454099r2Q7i9SIdpHG+cWcFHjdviEfclzmsvqnzSYrUA+NWpZHbADiWXVd2F+q0z7LV
	H2OA4dUz5sKE3SVsKEhqzEAoASx/SDtj1cA/c7/OOuRA78jx5MwZbmtdKG5n4giGP83fwB1
	Lz/8aDk5gMXFBFfOCRLzOQf4NiSN1mgSO2J6SyHu6wcbv5CBG/d2yfmG/TjIdQ0llyWhr9G
	SCUbI+emADjnzWJFRmir8wi3A4cwZ2YX+h8sr0gyXGaC1m9btrz61ATfbtjFQP9bE79UnjO
	7v6xgIAhRFL4Bgf/kO33zcr0MWRTQNV1FctLJ1gzo7at0CDaNdPsdFRwx6d6JgLI3XW+twP
	fCEb4/fczoHLRa3G2XW4+CoHlZmFeXhmu2NmXd6JXNQoc0jtRKQb17FdQ5K/AjRazCxtG+d
	mqk4OzC7IPRwMtE6Ipp2OXWRm0h+Szqw+Fy76Hcwk1xYXEjz6ttkytzR+zKy/6nIsBMtH+i
	cRJ78+nusqL5wrndZT7rP0a2oxYHIcZNgoWGw/7atjk+Vk44vbETJ7HEJUwFGx+z6V2t53U
	DLm28OIa9bcrTHdRYEH/0ipNyR13gFqzAkqrb4iQuaJRMalZzTElE8826rl15q/6B2W1qSK
	uBa8054G1mmBYfklRH6y8UmeaxyltGKBdZzxp7BVte0Dy6N1lYgjQnWDk74K2xaB+PEIPg0
	yG3+lesIvWp+tgPOjtr0jEqZJFXtDNF7re+2CdsXOBLuuriUBB/WCZ68c6fLHdu4WCL1EZc
	M/4+bC3dDQ5LoXzZwA2a65Mp8EKMe2/jUneLG06RHiDty6RpRb7vHtXx1rJczeiBe0x5Z5h
	difo3vMZzfexZp5uR4azPG4sTUkRJcUDHbNZxSSgDTGEXrsrut4XjgDyy4VNwzEaWxmw=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------kF4g1z672TtdiqJ02ivacGnm
Content-Type: multipart/mixed; boundary="------------rYgltaidC69xRNpWNvH7ciEI";
 protected-headers="v1"
From: WangYuli <wangyuli@uniontech.com>
To: linux-bluetooth@vger.kernel.org, bluez.test.bot@gmail.com
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, johan.hedberg@gmail.com,
 matthias.bgg@gmail.com, hello@felixjara.me, wangyuli@uniontech.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, guanwentao@uniontech.com,
 zhanjun@uniontech.com, aaron.ma@canonical.com
Message-ID: <ececafaf-0a3b-4e3c-a56e-448f50c537c6@uniontech.com>
Subject: Re: [RESEND.,v2] Bluetooth: btusb: Add MT7925 support for ID
 0x13d3:0x3608
References: <34A24B6870318797+20240929074852.977045-1-wangyuli@uniontech.com>
 <66f90d4b.170a0220.288304.076c@mx.google.com>
In-Reply-To: <66f90d4b.170a0220.288304.076c@mx.google.com>

--------------rYgltaidC69xRNpWNvH7ciEI
Content-Type: multipart/mixed; boundary="------------6qWSTeocB9KvF9FYwKm6wpSO"

--------------6qWSTeocB9KvF9FYwKm6wpSO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

Q291bGQgYW55b25lIHNoZWQgc29tZSBsaWdodCBvbiB3aGF0J3MgZ29pbmcgb24gaGVyZT8N
Cg0KSSdtIGFic29sdXRlbHkgY2VydGFpbiB0aGlzIHBhdGNoIGNhbiBiZSBtZXJnZWQgZGly
ZWN0bHkgaW50byB0aGUgDQpibHVldG9vdGgtbmV4dCBicmFuY2ggb2YgdGhlIGJsdWV0b290
aC1uZXh0IHJlcG9zaXRvcnkgDQooZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51
eC9rZXJuZWwvZ2l0L2JsdWV0b290aC9ibHVldG9vdGgtbmV4dC5naXQpLg0KDQpBbSBJIG1p
c3Npbmcgc29tZXRoaW5nLG9yIGlzIHRoZXJlIGEgcHJvYmxlbSB3aXRoIHRoZSBib3Q/DQoN
Ci0tDQoNCldhbmdZdWxpDQoNCg==
--------------6qWSTeocB9KvF9FYwKm6wpSO
Content-Type: application/pgp-keys; name="OpenPGP_0xC5DA1F3046F40BEE.asc"
Content-Disposition: attachment; filename="OpenPGP_0xC5DA1F3046F40BEE.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSK
P+nX39DNIVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAx
FiEEa1GMzYeuKPkgqDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMB
AAAKCRDF2h8wRvQL7g0UAQCH3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfP
bwD/SrncJwwPAL4GiLPEC4XssV6FPUAY0rA68eNNI9cJLArOOARmgSyJEgorBgEE
AZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7VTL0dvPDofBTjFYDAQgHwngE
GBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIbDAAKCRDF2h8wRvQL
7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkUo9ERi7qS
/hbUdUgtitI89efbY0TVetgDsyeQiwU=3D
=3DBlkq
-----END PGP PUBLIC KEY BLOCK-----

--------------6qWSTeocB9KvF9FYwKm6wpSO--

--------------rYgltaidC69xRNpWNvH7ciEI--

--------------kF4g1z672TtdiqJ02ivacGnm
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZvkOsAUDAAAAAAAKCRDF2h8wRvQL7l5p
AP452q7stgt+BE9fX7228H8xu3pV4e4Es4TQ7QVlNHbdGgD9Hfse70UZkqnlcL/lazmRK3bXA6US
lVf4rYRPvYyTmgc=
=8FY7
-----END PGP SIGNATURE-----

--------------kF4g1z672TtdiqJ02ivacGnm--
