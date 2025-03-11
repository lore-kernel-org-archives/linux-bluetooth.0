Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A0F8821
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Mar 2025 01:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741658095; cv=none; b=G8yGp02f9Ev9x7um7Ez8jyAqT5Nm8NEWxYeMEWydD7LvVNlG7nbi5evjUqZi/W/F4uqwG77aqd0yXOxT4eCv0iMY9ralc0Db8l7qYwgMSvCtRrUZUUVSPZ5VaoS73vHRLUfTK03nsl6SGEq/MKjIGh5FOS9AzxFXBHhdL5QBaEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741658095; c=relaxed/simple;
	bh=0yWYT9Kz30Vfe8t2VRFGLS/CGmze80SAv1Tv9IogynY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EackjJBvIocw2WfACY3ER8o/Je3u52lfukBfGied+bYReqIOunZNZ7ZxcnKhBYe0pqbIBuEAjJg/ZwmcEFrkj+oBXyt13yn87nYZAD12cNGVhSD0o9ZD0PMu/xWj2ab1WW24o91jnAzV0LmpvpGF+wzecFYKPS8aJpeEw8F0B/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=WEIclb18; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="WEIclb18"
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52B1snCzB4123725, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realsil.com.cn;
	s=dkim; t=1741658090;
	bh=0yWYT9Kz30Vfe8t2VRFGLS/CGmze80SAv1Tv9IogynY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	b=WEIclb18/CkS6PJhcPDm1XVgdLC6BNdZB2DJoBBH3V5hV8knnbcBxXPP6RIAEclea
	 dsbtrE41U9DnkKAbEvdxPORZ1JFDHfjkwlnTR0UXDd6qInLHBqcs46wTG6TFhA7+Dj
	 aUaGYSGmY4FMP3yu5dqqX/Noeoc0WfUxDx1xDsxpMDwUgoZKfjd9uCNcVGnXTYa0Ha
	 yfbK27bYEAaclERW255uyUYvAi83TwdxxGhh+Wt5vWKPE1kMxNG1IJuVECj/dwtubq
	 d07HchFNpVAO+WtN4myJG1OTGfPE864ej+bBZATDxIIY4rfcmHN4hnllhSuSJr/Rgg
	 B7U42ryyX0AaQ==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52B1snCzB4123725
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Mar 2025 09:54:50 +0800
Received: from RS-EX-MBS4.realsil.com.cn (172.29.17.104) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Mar 2025 09:54:49 +0800
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104]) by
 RS-EX-MBS4.realsil.com.cn ([172.29.17.104]) with mapi id 15.02.1544.011; Tue,
 11 Mar 2025 09:54:49 +0800
From: =?gb2312?B?TWljaGFlbCBLb25nKL/X9s4p?= <michael_kong@realsil.com.cn>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH BlueZ] Fix data type in bt_hci_send_data
Thread-Topic: [PATCH BlueZ] Fix data type in bt_hci_send_data
Thread-Index: AduSJ4BkRWEjINsYSdW5EM02qY/ASw==
Date: Tue, 11 Mar 2025 01:54:49 +0000
Message-ID: <7dcaf905169d4c399d89eefbbdf0d3c3@realsil.com.cn>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

VGhlIGRhdGEgdHlwZSBpbiBidF9oY2lfc2VuZF9kYXRhIHNoYWxsIGJlIEFDTCwgU0NPIG9yIElT
Ty4gVGhpcyBmaXggY2Fubm90IHNlbmQgSVNPIGRhdGEgaW4gY2xpZW50L2hjaSBtZW51Lg0KDQot
LS0NCiBzcmMvc2hhcmVkL2hjaS5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvc3JjL3NoYXJlZC9oY2kuYyBiL3Ny
Yy9zaGFyZWQvaGNpLmMNCmluZGV4IDA3ZmRmZmM4Mi4uNTc1MjU0YzA5IDEwMDY0NA0KLS0tIGEv
c3JjL3NoYXJlZC9oY2kuYw0KKysrIGIvc3JjL3NoYXJlZC9oY2kuYw0KQEAgLTYyMCw3ICs2MjAs
NyBAQCBib29sIGJ0X2hjaV9zZW5kX2RhdGEoc3RydWN0IGJ0X2hjaSAqaGNpLCB1aW50OF90IHR5
cGUsIHVpbnQxNl90IGhhbmRsZSwNCiAJc3dpdGNoICh0eXBlKSB7DQogCWNhc2UgQlRfSDRfQUNM
X1BLVDoNCiAJY2FzZSBCVF9INF9TQ09fUEtUOg0KLQljYXNlIEJUX0g0X0VWVF9QS1Q6DQorCWNh
c2UgQlRfSDRfSVNPX1BLVDoNCiAJCWJyZWFrOw0KIAlkZWZhdWx0Og0KIAkJcmV0dXJuIGZhbHNl
Ow0KLS0gDQoyLjI1LjENCg0KDQpCZXN0IHJlZ2FyZHMsDQpNaWNoYWVsX2tvbmdAcmVhbHNpbC5j
b20uY24NCg==
