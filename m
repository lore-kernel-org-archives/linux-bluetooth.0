Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BD815532A
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 05:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731303224; cv=none; b=ha0o8lDgYMtYdQhEPGPnV3ygVaDIszAdiYxNRSZ1qgGqBsfDOuW8az8gPQ0U5EGYw/ZzO6osgfZOuFJNwvVMrqZzTslBqNsu7QnLEWIHfIhdxwpg6yC+OnPM9AWNzJrqqzLj8J4Wzoq1XYoXuSjgMjjnLAIB8EdoIzwa2lSzPmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731303224; c=relaxed/simple;
	bh=r0qJC1SezqBQynGrNDWaqH2I8fe34n0nk3C9hPlNSJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DpLzilhE1JIqi5BA1lecQxODsbKSUEr0TecvM+NErMQ7WBugf2GVW7G+mVtq/4CTUjWZc9EfO8Nx+z3XXL8HJd3DTVFbIDDChuRaSp07yheOdBtEB0QrkPgBTBGG0xHSHyKQ00TfC0dI8vOaVIEVmGmE8XRaY3I0b8fziNGmIvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=edBauzF4; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="edBauzF4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1731303140;
	bh=r0qJC1SezqBQynGrNDWaqH2I8fe34n0nk3C9hPlNSJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=edBauzF4+psN00yGCWd2hhRKKGZjoCLM+XP/4Vk/wT24xfIM2jXvn069w9epgAQUt
	 85bfX/4dTuk0HkQwTOQDvkw+xDeaDVSschC8OeCFR0Up3YtvxOz09Y8aN8WA0Z+WdU
	 2FKvun9iHGLJvDrBVjFe6CfJKjDLq3VIVs4RZ/eg=
X-QQ-mid: bizesmtpsz15t1731303113tpcbqo
X-QQ-Originating-IP: LqKdR6A/9tP/7Zdlo1TgGaooe3XoVAUEqK6adang8j8=
Received: from [10.20.53.22] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 Nov 2024 13:31:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16417097256222115542
Message-ID: <0356012E12D9C4F2+d5bf77f1-6baa-4e02-b9d4-52fc49997f32@uniontech.com>
Date: Mon, 11 Nov 2024 13:31:50 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Bluetooth: btusb: Add MT7925 support for ID
 0x13d3:0x3608
To: Paul Menzel <pmenzel@molgen.mpg.de>, hello@felixjara.me
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, johan.hedberg@gmail.com,
 matthias.bgg@gmail.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, guanwentao@uniontech.com,
 zhanjun@uniontech.com, aaron.ma@canonical.com
References: <D3E1285F7DBFAB3E+20241108082418.187499-1-wangyuli@uniontech.com>
 <9954d66f-7e1c-4df3-a600-f82139ea9e5b@molgen.mpg.de>
Content-Language: en-US
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
In-Reply-To: <9954d66f-7e1c-4df3-a600-f82139ea9e5b@molgen.mpg.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------prXwvg4jx33S8hv2mv5kSAoR"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OeS8HGsJZnO5WQ/8ZQ6BffBFbGR9UrRzTYv+R+oNPOkwgdfqFMgDdSHX
	Wy44DZAinLznguz1eM/svs+91IHgk2ocBVP4edgAKN9n3sjftJ7tXT3SoGSiWtODeBL0EuY
	h6n8z9f/WAOwhhBUBw0Xkc1rHpekXnyUA2nLykOIY/50BJd/Fv3WhYntwO621a7jXwJ6feU
	2eqdh8i1Lt4+Vqg9Qmb79fUWiYdccjP6MvtxG2Q5/H7+IVl4P0+raXgxSiY50dMKhSWblun
	iu/iwkgUShjjnwUjOuFpckKVgNfC2NYX637ZW68WuLqL+S82IamEA2eaDhsuiN8PmhC7rZ+
	JVaIqsiCEhZDR1aFKqUDBtI8lnZTjTcB0Pefv7Rz9ls3a2d5RqfoDmnHsQEpGo1M8t/ozz/
	+rX6xhdYr65yOMXM5K3uCIK+Hfl8E28AMrSozBvVA0ELoLOwSgDwkKLrdnsMZxPr3KsGTV8
	vDlQIkLznlOZm6vPPXNsoaBZpL0RsbOgtR47nohl48VnRaqgqeiKvOb1sKHpvXRHMT3krJZ
	lszzyEBeehKq3KtSRVnVxcYD+3H9ZVvVWvniA74bJjYMOH/2JKD2bfbuspKXvhJx81Cvubo
	huwLOsTaxxuXVGgvr+xbpuGgxYqmtehEEQEZsG3lrwLw16vx+mXvsGxV58PNgXQYcVL4gaA
	CnX2LGbDZwr5sTpcG9hYFMRpxcRuLbCqdT3G/8n9dQNS28i5GgsaLsDt5G7m3uO4IGOSMZB
	r/MWneSbPbBfWJ+ICcVqkp2jR4rZjtcxYNVgSUzMPHGo103r1FdCd/sroUnm/iMdp62ZP0n
	X+j25k76mv7CPMHcjVK7YIWx5dvIWkx8su17duxLxYdB7c25dMm20oMERQMfBaGxzAn0NF+
	mvRHQoJ8FLhHaMLySq3njzY8vONHeBtqSM89z9k7++MwNCQpGw7622KS+z5iIDGsQemvXmj
	7obgyivlYYNDEmZmJlK7hBc1tLmdsuTGPuKi8g0pLF0NvEF4M33gC/5HN1CUY+NOU6/mrnv
	jDJlfsfOYVl2zuzpP85ozdB37O2yGxJHBPB8PYj992l61tC91GvTi9pP8DLue7cfw0C6sri
	fVmZKLAcx57Ax6iWRJfxvH32ThKSrfi8FS1K8IwCGJZ
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------prXwvg4jx33S8hv2mv5kSAoR
Content-Type: multipart/mixed; boundary="------------dFU7eN00AXop4PhYtPWk9804";
 protected-headers="v1"
From: WangYuli <wangyuli@uniontech.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>, hello@felixjara.me
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, johan.hedberg@gmail.com,
 matthias.bgg@gmail.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, guanwentao@uniontech.com,
 zhanjun@uniontech.com, aaron.ma@canonical.com
Message-ID: <d5bf77f1-6baa-4e02-b9d4-52fc49997f32@uniontech.com>
Subject: Re: [PATCH v3] Bluetooth: btusb: Add MT7925 support for ID
 0x13d3:0x3608
References: <D3E1285F7DBFAB3E+20241108082418.187499-1-wangyuli@uniontech.com>
 <9954d66f-7e1c-4df3-a600-f82139ea9e5b@molgen.mpg.de>
In-Reply-To: <9954d66f-7e1c-4df3-a600-f82139ea9e5b@molgen.mpg.de>

--------------dFU7eN00AXop4PhYtPWk9804
Content-Type: multipart/mixed; boundary="------------lc09SF6AgsylcJLktEewo2W5"

--------------lc09SF6AgsylcJLktEewo2W5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAyNC8xMS84IDE2OjQ4LCBQYXVsIE1lbnplbCB3cm90ZToNCg0KPg0KPiBTaG91bGQg
dGhlcmUgYmUgYSBzcGFjZSBpbiB5b3VyIG5hbWU6IFdhbmcgWXVsaT8NCj4NCk5vIG5lZWQg
Oi0pDQoNCj4NCj4gVGhlcmUgaXMgYWxyZWFkeSBhbiBlbnRyeSBmb3IgMTNkMzozNjA4LiAN
Cg0KU29ycnkuIEkndmUgYmVlbiB3b3JraW5nIG9uIHRoaXMgcGF0Y2ggaW4gdGhlIGJsdWV0
b290aC1uZXh0IGJyYW5jaCBvZiANCnRoZSBibHVldG9vdGgtbmV4dCByZXBvc2l0b3J5LiBb
MV0NCg0KU28gSSBkaWQgbm90IG5vdGljZSB0aGUgbmV3IGNoYW5nZXMgdG8gdGhpcyBmaWxl
Lg0KDQoNClsxXSANCmdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVs
L2dpdC9ibHVldG9vdGgvYmx1ZXRvb3RoLW5leHQuZ2l0DQoNCg0KPiBTaG91bGQgb25seSBC
VFVTQl9WQUxJRF9MRV9TVEFURVMgYmUgYWRkZWQ/UGxlYXNlIHVwZGF0ZSB0aGUgY29tbWl0
IA0KPiBtZXNzYWdlIChzdW1tYXJ5IGFuZCBib2R5KSBhY2NvcmRpbmdseS4NCg0KDQpObyBu
ZWVkIG5vdy4NCg0KQmVjYXVzZSBvZiBjb21taXQgMGZlYzY1NmQwOGFhICgiQmx1ZXRvb3Ro
OiBidHVzYjogSW52ZXJ0IExFIFN0YXRlIGZsYWcgDQp0byBzZXQgaW52YWxpZCByYXRoZXIg
dGhlbiB2YWxpZCIpDQoNCj4NCj4NCj4gS2luZCByZWdhcmRzLA0KPg0KPiBQYXVsDQo+DQot
LSANCldhbmdZdWxpDQo=
--------------lc09SF6AgsylcJLktEewo2W5
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

--------------lc09SF6AgsylcJLktEewo2W5--

--------------dFU7eN00AXop4PhYtPWk9804--

--------------prXwvg4jx33S8hv2mv5kSAoR
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZzGWxgUDAAAAAAAKCRDF2h8wRvQL7jrY
AP44VowUFBFTdi66/4qb7/KoyXwbptsn0Z/hGY/znCZe9QD/VSCt3lW4A+uVQRZokLhP9L9NwtxA
dBpfl8jCbQSqeg8=
=ey4H
-----END PGP SIGNATURE-----

--------------prXwvg4jx33S8hv2mv5kSAoR--
