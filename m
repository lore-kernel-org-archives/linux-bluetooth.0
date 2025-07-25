Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168AF1DE3A7
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jul 2025 08:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753432655; cv=none; b=WMJFRV42YVxbAcjd9oGvO3lz6OOnN7ix6pUmZeNJokgo+3P5ApcZFBt8hbQa2AoUoFXzFIBK9uOPycM7O4zSzC1cdpJlVLeI3iZQecBJ6vBa/wPICxuj+ARRtywvpD3FQ/9mJO0nv1/pvt/hWPlC0hQ6jeJ98gv/K/ELdXnUTCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753432655; c=relaxed/simple;
	bh=W8HJ1KWCY2oLz+1QP8VSY1XrvMKYGu1SYlHF1EPwFzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=tckkT6cVnSc4mViXlkkx2TBFzLfbregKzi3dIloQyZztVY/uq980CGADBbcQeV6LfnN6ctjnw9NZN+NnbxgJf+Z55wYbWI+DMR3+XtOsfimLwWBPrxxn5eXtHO6vumxbMMq96EJOG81wENiiLQ46hSsIkIv5En55vz6+ELF2QY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=hv4RQyXi; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="hv4RQyXi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1753432616;
	bh=W8HJ1KWCY2oLz+1QP8VSY1XrvMKYGu1SYlHF1EPwFzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=hv4RQyXiZ7NNe5SpHac1QhEzMy2I2P2Z0pGQvvVQ7S3HI7oyeZISBSRA2YkmntMNb
	 fFp0V0WcOh0p3kvS4Vg00ElNNFbPOMv8FhLdW34JykzonqPjxaEGIT3gtQ/ZZ/WbKb
	 P8soDdH1OyNyJAydyjLxCgyj4V3pUYcfRsKzgwmk=
X-QQ-mid: zesmtpip4t1753432602taada28d8
X-QQ-Originating-IP: K5y+sr3Tz2blsYpXvhPfYoVjT/T1inMMQBCdblCyoKk=
Received: from [IPV6:240e:668:120a::212:232] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 25 Jul 2025 16:36:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17059450852442954122
EX-QQ-RecipientCnt: 7
Message-ID: <0C978E5F85FC6FB2+b88e93f8-e254-4ed4-897c-63fceaa6bf96@uniontech.com>
Date: Fri, 25 Jul 2025 16:36:40 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bluetooth: btusb: Add RTL8851BE device 0x13d3:0x3601
To: linux-bluetooth@vger.kernel.org
References: <5D4383E66D4177F3+20250710080028.177664-1-wangyuli@uniontech.com>
 <686f7878.050a0220.756f0.10f9@mx.google.com>
Content-Language: en-US
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, zhanjun@uniontech.com,
 niecheng1@uniontech.com, guanwentao@uniontech.com,
 Hao Li <lihao1@uniontech.com>
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
In-Reply-To: <686f7878.050a0220.756f0.10f9@mx.google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------K7tDG07OghZdBETao7oKXO3b"
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MnvGtZwO7LbyRHpPPEjquxfXuaiOGYHpUaX5KGLV75WaFjvAggjKea/k
	wvhujDJPj3p0XaFdf8tTiRUvYnoAxUPLqa4SEuklGRifDgHFeFqeNeQkkpgeQbU3Q1IIlL4
	Fzg17VkHh1e/D5JJ1gqTxTqFIHBRhY+PcUDqmg3vr+TTloCNYwX54lBRPBhOV70NprwIDLi
	pmWKO4n9rDYYgz4wliMd+mwwkdUgq2ZLivbgLMxXgfR9p8qmAwmTw/vWgT4CcGs740AIBkB
	bFQ9BpsVy/T9W3pm0DPIeEEb1/kqbDSTR9HOztNQwGwsGKBk7tA7Tr6/tzX9SeqrckwsXXS
	ZahmAFdKc1bd0LXl2CYzx86jv8RLaq56iPMEpVdUx/IJMwjFGtK0dMrThwTGlnbTRnMCh53
	lc1eFVZkv4JMz4LMY9HdtPfuRRQ9LMpDN5h5GbUOIxNBq4XIkhlT6gpEUuTP0b3GmN9tBpx
	ojR8D60/JPDX+XjeFoKEposold9sIF8rrpydj1Lq7dfRyUhL7wHzJ/oI51rKwVVs6O6pM+O
	me/h75NfREMN07jf0lb+77J5Y2svcQvWLr4HHp3I+O9EDB/BFNuDsQXcgCIp9H1mAdYxCrA
	KI46Ovm1Iq/BeWc3Y12RBPGW6lsTRlw2SKe/8XhsmOQsZu3zUj0CVpqOF+ptCEOU2L8xpYE
	yIoM07ZeQe/MDntmbnE5dIb6uOCsPTt0wmTFlZ7sdSz8TZeF3DID+hty7nTDJQk6msNONFI
	zBn+VrFaF4bhizwjgZxmLOnmFsjoh6UR3VYoHZDfn40A26ipUqNvZCf3dYUOAqOLcWF1TWd
	gEzivMPTCRTzKLOnggB1UTPS9hZbheqmN1CTfdygGim8AMEQHWMuGXK46o+6zqomnLsZajq
	10P/2AYBTC1l0YYkwHg0idgdMKJIUeRC69ig3V8nP+QJ+6fIi6AmRusFpYm2yJgn9hjQsxR
	TuQfTcMFXpBnRk9C8/WvKlyAspw/TAuUgIvKunswfZvjTmOCYDx9QStfrLs/+guQ+UwA7cq
	o2W8aQQgiOzEUspQgduCk9+oYHNXBWwOCS/0DsOwW4uj5pRi4idZY+W20ggog=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------K7tDG07OghZdBETao7oKXO3b
Content-Type: multipart/mixed; boundary="------------NCQexz2Ab0UAHm0fJjcglw0X";
 protected-headers="v1"
From: WangYuli <wangyuli@uniontech.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, zhanjun@uniontech.com,
 niecheng1@uniontech.com, guanwentao@uniontech.com,
 Hao Li <lihao1@uniontech.com>
Message-ID: <b88e93f8-e254-4ed4-897c-63fceaa6bf96@uniontech.com>
Subject: Re: Bluetooth: btusb: Add RTL8851BE device 0x13d3:0x3601
References: <5D4383E66D4177F3+20250710080028.177664-1-wangyuli@uniontech.com>
 <686f7878.050a0220.756f0.10f9@mx.google.com>
In-Reply-To: <686f7878.050a0220.756f0.10f9@mx.google.com>

--------------NCQexz2Ab0UAHm0fJjcglw0X
Content-Type: multipart/mixed; boundary="------------JhYJFquPz0m87g6XAlmmlp86"

--------------JhYJFquPz0m87g6XAlmmlp86
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQpQbGVhc2UgZm9yZ2l2ZSBteSBpZ25vcmFuY2UsIGJ1dCBJJ20gbm90IHN1
cmUgaG93IHRvIGdldCB0aGUgY29kZSBmcm9tIA0KdGhlIGxhdGVzdCBkZXZlbG9wbWVudCBi
cmFuY2ggb2YgdGhlIEJsdWV0b290aCBzdWJzeXN0ZW0gc28gdGhhdCBteSANCnBhdGNoIGNh
biBwYXNzIHRoZSBhdXRvbWF0ZWQgY2hlY2tzLg0KDQpUaGlzIHBhdGNoIGFwcGxpZXMgY2xl
YW5seSB0byB0aGUgY3VycmVudCBMaW51eCBtYWlubGluZSB3aXRob3V0IGFueSANCmNvbmZs
aWN0cy4NCg0KSSBkaWQgZmluZCB0aGUgYmx1ZXRvb3RoLW5leHQgcmVwb3NpdG9yeSANCiho
dHRwczovL2tlcm5lbC5nb29nbGVzb3VyY2UuY29tL3B1Yi9zY20vbGludXgva2VybmVsL2dp
dC9ibHVldG9vdGgvYmx1ZXRvb3RoLW5leHQuZ2l0KSwgDQpidXQgaXQgc2VlbXMgYWxsIG9m
IGl0cyBicmFuY2hlcyBoYXZlbid0IGJlZW4gdXBkYXRlZCBmb3IgYSB3aGlsZS4NCg0KT24g
MjAyNS83LzEwIDE2OjIzLCBibHVlei50ZXN0LmJvdEBnbWFpbC5jb20gd3JvdGU6DQo+IFRo
aXMgaXMgYW4gYXV0b21hdGVkIGVtYWlsIGFuZCBwbGVhc2UgZG8gbm90IHJlcGx5IHRvIHRo
aXMgZW1haWwuDQpJJ20gc29ycnkgdGhhdCBJIGhhdmUgdG8gcmVwbHkgdG8geW91LiA6LSkN
Cj4NCj4gRGVhciBTdWJtaXR0ZXIsDQo+DQo+IFRoYW5rIHlvdSBmb3Igc3VibWl0dGluZyB0
aGUgcGF0Y2hlcyB0byB0aGUgbGludXggYmx1ZXRvb3RoIG1haWxpbmcgbGlzdC4NCj4gV2hp
bGUgcHJlcGFyaW5nIHRoZSBDSSB0ZXN0cywgdGhlIHBhdGNoZXMgeW91IHN1Ym1pdHRlZCBj
b3VsZG4ndCBiZSBhcHBsaWVkIHRvIHRoZSBjdXJyZW50IEhFQUQgb2YgdGhlIHJlcG9zaXRv
cnkuDQo+DQo+IC0tLS0tIE91dHB1dCAtLS0tLQ0KPg0KPiBlcnJvcjogcGF0Y2ggZmFpbGVk
OiBkcml2ZXJzL2JsdWV0b290aC9idHVzYi5jOjUxNQ0KPiBlcnJvcjogZHJpdmVycy9ibHVl
dG9vdGgvYnR1c2IuYzogcGF0Y2ggZG9lcyBub3QgYXBwbHkNCj4gaGludDogVXNlICdnaXQg
YW0gLS1zaG93LWN1cnJlbnQtcGF0Y2gnIHRvIHNlZSB0aGUgZmFpbGVkIHBhdGNoDQo+DQo+
IFBsZWFzZSByZXNvbHZlIHRoZSBpc3N1ZSBhbmQgc3VibWl0IHRoZSBwYXRjaGVzIGFnYWlu
Lg0KPg0KPg0KPiAtLS0NCj4gUmVnYXJkcywNCj4gTGludXggQmx1ZXRvb3RoDQo+DQpUaGFu
a3MsDQotLSANCldhbmdZdWxpDQo=
--------------JhYJFquPz0m87g6XAlmmlp86
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

--------------JhYJFquPz0m87g6XAlmmlp86--

--------------NCQexz2Ab0UAHm0fJjcglw0X--

--------------K7tDG07OghZdBETao7oKXO3b
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCaINCGAUDAAAAAAAKCRDF2h8wRvQL7sr/
AP0U2iwqvkEsRKIHU//6B9PYGbA4NI3XqRI8S0we78l+awD9E/E9bZYdFn8sTABDic0s7vzwluqi
H7Oryp/kyvb6rAo=
=enEw
-----END PGP SIGNATURE-----

--------------K7tDG07OghZdBETao7oKXO3b--
