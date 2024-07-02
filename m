Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76388F72
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 03:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719889864; cv=none; b=cIGk1MyMk7FIVVFTdBExE47ZO+MOgc/dc4xAHPwVHL60DJGx7TEk2x7NmDr2XjjmGqdf/WJJs9gWs/eYCMzXitagc01nWxa4hWH1rXb5WheAc9R7fGW4MsglSUo+OIJ8WVaFZWagZ0p368bHxtBgjnJIcaGXS7Ko5ArDatC2ADI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719889864; c=relaxed/simple;
	bh=Uzlot6OPtNOIjSfWyTQT9t285PdHs5jYUa5Bj68yenE=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=RbhNXYifujpPXiBGQgJdGHWTTE7MuUfIEGcXqZ3JkMTozBRmTpNZViF432oZ5/lwynMznify8clVHYHK+9GTe4tnF1xB8Twd4z6K+tgzf+u5QRvytLW/OcHZaWcr9kwVZAjxcRI3ivpSyqX+hZjq3XBbut1xCzPF59cXaZQ0usY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-GoodBg: 2
X-QQ-SSF: 00400000000000F0
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-FEAT: zT6n3Y95oi2VLOR4A2F4qRNnyoM1S0cB9SDuRFEx6jA9d8tIWuUQ+7Lb4KjTU
	Obxn6eXUrG6W9L42PKVsSK06AeAvPHfyFfcKHv3Vk/iASSN/VyCrPympndumc0I6EsVE92d
	O0X9tE3R1ixN000TVB3jibhNufU7u8zy5aRyybCSq6vtJ7RkRjGU4M5qFKb8e9OAcb7iHdZ
	2kWNKZJBfnbjB+xqJuNFeuGUt1P1jYFKf8Mbls4+/bufOWvFzfGYL97BbadUGqNGUlIxzGb
	q8DD+NFq054jr2XDRqN4aNsIYs4rZK+QU9M/+1AKyrKmypBqtF7VtopkRdrIrjCt2Sz0lIs
	IiiJxbsTd7vvIGcB2L9v+duftdT1zAe7VAj3R258sNLwvem2H1Qaaq884dny6pf3HZMRF8f
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: z2plQ/6RjyLe1UiH2WZjt090KNGkeSI8DVMR7ztFMAc=
X-QQ-STYLE: 
X-QQ-mid: maileng7t1719889848t591575
From: "=?utf-8?B?6LW15oiQ5LmJ?=" <zhaochengyi@uniontech.com>
To: "=?utf-8?B?THVpeiBBdWd1c3RvIHZvbiBEZW50eg==?=" <luiz.dentz@gmail.com>
Cc: "=?utf-8?B?bGludXgtYmx1ZXRvb3Ro?=" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] adapter: Add retry when bonding device returns connection failure
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Tue, 2 Jul 2024 11:10:48 +0800
X-Priority: 3
Message-ID: <tencent_479A3EDC37E92B2C642695B1@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20240701101243.2902-1-zhaochengyi@uniontech.com>
	<CABBYNZK8ZvoHCQjo=rj7yt-0omZ8zgTFOueCvL5KoghhY_1nwA@mail.gmail.com>
	<tencent_1A76F7A01B286AA77BEC7DAE@qq.com>
In-Reply-To: <tencent_1A76F7A01B286AA77BEC7DAE@qq.com>
X-QQ-ReplyHash: 2285007281
X-BIZMAIL-ID: 14305346098413274524
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Tue, 02 Jul 2024 11:10:50 +0800 (CST)
Feedback-ID: maileng:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

SGksDQoNCj4gSGVyZSBpcyB3aGF0IEl2ZSBhY3R1YWxseSBoYWQgaW4gbWluZDoNCj4NCj4g
ZGlmZiAtLWdpdCBhL3NyYy9hZGFwdGVyLmMgYi9zcmMvYWRhcHRlci5jDQo+IGluZGV4IGJi
NDlhMWVjYWQyMy4uZjFjYzRmMmVkMjVhIDEwMDY0NA0KPiAtLS0gYS9zcmMvYWRhcHRlci5j
DQo+ICsrKyBiL3NyYy9hZGFwdGVyLmMNCj4gQEAgLTgzNjMsMTIgKzgzNjMsMTcgQEAgc3Rh
dGljIHZvaWQgYm9uZGluZ19hdHRlbXB0X2NvbXBsZXRlKHN0cnVjdA0KPiBidGRfYWRhcHRl
ciAqYWRhcHRlciwNCj4gICAgICAgICBlbHNlDQo+ICAgICAgICAgICAgICAgICBkZXZpY2Ug
PSBidGRfYWRhcHRlcl9maW5kX2RldmljZShhZGFwdGVyLCBiZGFkZHIsIGFkZHJfdHlwZSk7
DQo+DQo+IC0gICAgICAgaWYgKHN0YXR1cyA9PSBNR01UX1NUQVRVU19BVVRIX0ZBSUxFRCAm
JiBhZGFwdGVyLT5waW5jb2RlX3JlcXVlc3RlZCkgew0KPiAtICAgICAgICAgICAgICAgLyog
T24gZmFsaXVyZSwgaXNzdWUgYSBib25kaW5nX3JldHJ5IGlmIHBvc3NpYmxlLiAqLw0KPiAr
ICAgICAgIHN3aXRjaCAoc3RhdHVzKSB7DQo+ICsgICAgICAgY2FzZSBNR01UX1NUQVRVU19B
VVRIX0ZBSUxFRDoNCj4gKyAgICAgICAgICAgICAgIGlmICghYWRhcHRlci0+cGluY29kZV9y
ZXF1ZXN0ZWQpDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiArICAgICAg
IC8qIGZhbGwgdGhyb3VnaCAqLw0KPiArICAgICAgIGNhc2UgTUdNVF9TVEFUVVNfQ09OTkVD
VF9GQUlMRUQ6DQo+ICAgICAgICAgICAgICAgICBpZiAoZGV2aWNlICE9IE5VTEwpIHsNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGRldmljZV9ib25kaW5nX2F0dGVtcHRfcmV0
cnkoZGV2aWNlKSA9PSAwKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJl
dHVybjsNCj4gICAgICAgICAgICAgICAgIH0NCj4gKyAgICAgICAgICAgICAgIGJyZWFrOw0K
PiAgICAgICAgIH0NCj4NCj4gICAgICAgICAvKiBJZ25vcmUgZGlzY29ubmVjdHMgZHVyaW5n
IHJldHJ5LiAqLw0KDQpHcmVhdCwgSSB0aGluayB5b3UgYXJlIHJpZ2h0IGlmIGtlcm5lbCBk
b2VzIG5vdCBjb250aW51ZSB0byByZXR1cm4gTUdNVF9TVEFUVVNfQ09OTkVDVF9GQUlMRUQg
c3RhdHVzLg0KDQpNeSBpZGVhIGlzIHRvIHJldHJ5IG9ubHkgb25jZSBhZnRlciByZXR1cm5p
bmcgTUdNVF9TVEFUVVNfQ09OTkVDVF9GQUlMRUQsDQppdCBjYW4gYXZvaWQgcmVwZWF0ZWQg
cmV0cnkgd2hlbiBjb250aW51aW5nIHRvIHJldHVybiBNR01UX1NUQVRVU19DT05ORUNUX0ZB
SUxFRC4NCg0KQ2hlZXJzLA0KQ2hlbmd5aQ==

