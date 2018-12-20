Return-Path: <SRS0=5zPD=O5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BFCC43387
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Dec 2018 07:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046BA21720
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Dec 2018 07:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=targetsg.onmicrosoft.com header.i=@targetsg.onmicrosoft.com header.b="kB5v9PNk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbeLTHyD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Dec 2018 02:54:03 -0500
Received: from mail-eopbgr60108.outbound.protection.outlook.com ([40.107.6.108]:61536
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729907AbeLTHyC (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Dec 2018 02:54:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=targetsg.onmicrosoft.com; s=selector1-targetsg-com01e;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5TQxKMiwxUUqBzzUzvk+y30dU8D8Mp44dfT7NXgIQs=;
 b=kB5v9PNkXTm/C5OKA2sAD6fJjIFYl0dwmV0INF57c7X3p7yMmkA8TQqZ51sAU/i2naJftbHp8nAxXwHTuCZLdp/il9Us9xHbaQo6ZMFmdYNtMxWPcfFHCjBS/exVMR2uh0WFkdugupyjQGt0o9DxwnlgLGjOti3SV1BrH0qV/i0=
Received: from AM0PR02MB3841.eurprd02.prod.outlook.com (52.134.80.26) by
 AM0PR02MB3665.eurprd02.prod.outlook.com (52.133.63.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Thu, 20 Dec 2018 07:53:59 +0000
Received: from AM0PR02MB3841.eurprd02.prod.outlook.com
 ([fe80::c54:ab59:4e66:9f94]) by AM0PR02MB3841.eurprd02.prod.outlook.com
 ([fe80::c54:ab59:4e66:9f94%2]) with mapi id 15.20.1425.024; Thu, 20 Dec 2018
 07:53:59 +0000
From:   Kai Ruhnau <kai.ruhnau@target-sg.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: AW: Broken "device" privacy for my TI chip
Thread-Topic: Broken "device" privacy for my TI chip
Thread-Index: AdSNifJ+UYE5GaWEQKeA1pt1wcpcBgJn8pwAAEOme0A=
Date:   Thu, 20 Dec 2018 07:53:59 +0000
Message-ID: <AM0PR02MB384105110097E23AB03EDB85C5BF0@AM0PR02MB3841.eurprd02.prod.outlook.com>
References: <AM0PR02MB38415BE5FF10D0A6D1469E8AC5A90@AM0PR02MB3841.eurprd02.prod.outlook.com>
 <32DDD430-DD53-4C30-B288-1AE2F58D2EC9@holtmann.org>
In-Reply-To: <32DDD430-DD53-4C30-B288-1AE2F58D2EC9@holtmann.org>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.250.113.163]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR02MB3665;6:38T7rMuR18JMVw8qfAjjvvAdYl0SIJQR6qgyFkUOlNKSlPg1RG7ys1VBFZzSEzkA4DYlmgZksq9B3bHFfpj+TDCFrstjuphTXFOJk0SWlnh4/C5SfdsgZVbqnWZZPkirSeXu/djZ5bC1wnf0fmcjTcM1Zrc23jqwjspFiNg4mRnKaov9Bh0a5F8Izd55fUmx1x1rnaE1mueIJJ9HXtuYKeQAMSRLcGPJVpe+04efcD/riOhgvwlLbv+1lHIqT57ZLUapfUVjH9dt/PAtNBBxxIy07JArpvJ9lUMQISidkJdjLtqtBDJ8gyO6ixWOTG8SXoUoHFAxhKzGBsUZix8HUCh21I8tQ6Z9I++ww/z/kctSK9l+PfWZdEwV3WkmEiXuQAqg+IFL3/NoutPVJI1v+UOWKXcg3gLxzTuk5Yp/BaJlnaYyu7DWuCAY3WFCzUy8+OZiFy8nNtNUfSADC13qGQ==;5:6zXZz18oD/5b+Iyb6ybJsfIXhFocZg4mJuulF9HPcORiS//sQ2DQ3Frj4lIUZpeR0b0N/ysPUNcAYlVeEoCi6/V8y4X5ApieiaoGwdzFIVMi7EG9tUoMYoXcW0fBoRTYgD/1lQJ1nMOmaB+Uzrh8nd30uM87khn9v0mTn6LNlTw=;7:dKPc6JXpoxNzE8vuogHhkR2LpGARG4y7uTQMocy74r3r/AXClx2FUt9hIrbEmhqV5uf1dJclFPIIkg/mCf6WSxo+Zoh7jJEO44Bvv7a7NJLCs77UTSfYmcFB23QBDM47ojenah6U/iKnleW/D5/n6Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 46e0a6db-37de-47af-650c-08d666504cea
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR02MB3665;
x-ms-traffictypediagnostic: AM0PR02MB3665:
x-microsoft-antispam-prvs: <AM0PR02MB3665315A82648E21774165E4C5BF0@AM0PR02MB3665.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(2016111802025)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:AM0PR02MB3665;BCL:0;PCL:0;RULEID:;SRVR:AM0PR02MB3665;
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(366004)(376002)(396003)(136003)(346002)(51914003)(189003)(199004)(446003)(11346002)(76176011)(71200400001)(71190400001)(68736007)(186003)(2906002)(6506007)(476003)(7736002)(55016002)(7696005)(26005)(305945005)(6346003)(102836004)(66574012)(105586002)(8936002)(25786009)(106356001)(508600001)(66066001)(74316002)(81166006)(81156014)(8676002)(99286004)(5660300001)(4326008)(14454004)(97736004)(86362001)(316002)(6436002)(486006)(44832011)(14444005)(256004)(6916009)(6116002)(3846002)(53936002)(33656002)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR02MB3665;H:AM0PR02MB3841.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: target-sg.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kai.ruhnau@target-sg.com; 
x-microsoft-antispam-message-info: VCfCdmHKYt+bf/rHUjZCH1iPjf11CLJBhavHImTpp/qpmnQm8WodIz61aDH6Y4x0fJbX0YHWROO+yPHzBEmMsRcigyGaTOIZkHGee9IQ9oMUuPmKnSjDJWtimAhE20kGb1vFlV6Mxcx+295m/iEg97ePcx9BM+d+SGlbwBhzqg3NM+G/953NsxPN79g/yMBMVyE6/moThtzRZeIVN4J0zjQJTNSNyzdWw0dvyuTzctW0YVnyaKEv2DTqELfF5kQONSd1Ft5hEwlphzlHKYQXwr9RxPAR4hk5Mx/ZudAnNaK1PXr0HX1PzgBb3ibcuXwr
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: target-sg.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e0a6db-37de-47af-650c-08d666504cea
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 07:53:59.2412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 52a4fe2f-f30a-452d-90b1-03ecc8ab0c0d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB3665
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWFyY2VsLA0KDQo+PiBJ4oCZbSBydW5uaW5nIEJsdWVaIDUuNTAgb24gbXkgZW1iZWRkZWQg
cGxhdGZvcm0gY29udGFpbmluZyBhbiBPRElOLVcxNjAgV2lGaS9CbHVldG9vdGgtY29tYm8tY2hp
cCB3aXRoIGEgVEkgQmx1ZXRvb3RoIGNvcmUuIEFmdGVyIHVuLXJlc2V0dGluZyB0aGUgQmx1ZXRv
b3RoIHBvd2VyIEdQSU8sIEkgcnVuIGBoY2lhdHRhY2gg4oCmIHRleGFzIDExNTIwMCBmbG93YCBh
bmQgdGhlbiBzdGFydCBibHVldG9vdGhkLiBJbiBgbWFpbi5jb25mYCwgSSBoYXZlIHNldCBgUHJp
dmFjeT1kZXZpY2VgLg0KPj4NCj4+IFdpdGggdGhpcyBzZXR1cCwgdGhlIGBzZXRfcHJpdmFjeV9j
b21wbGV0ZWAgKGFkYXB0ZXIuYykgY2FsbGJhY2sgaW4gYmx1ZXRvb3RoZCBpcyBjYWxsZWQgd2l0
aCBgc3RhdHVzID09IE1HTVRfU1RBVFVTX1JFSkVDVEVEYCBhbmQgYWNjb3JkaW5nIHRvIG15IDQu
OSBrZXJuZWwsIHRoaXMgaXMgdGhlIGNhc2Ugd2hlbiBgaGRldl9pc19wb3dlcmVkYDogQWZ0ZXIg
Ym9vdGluZyBhbmQgcnVubmluZyBgaGNpYXR0YWNoYCwgbXkgY2hpcCBpcyBhbHJlYWR5ICJ1cCIg
YW5kIHRodXMgSSBjYW5ub3Qgc2V0IHRoZSBJUksuDQo+Pg0KPj4gSSBmb3VuZCBpbiBgdGV4YXNf
cG9zdGAgKGhjaWF0dGFjaF90aS5jKSwgdGhhdCB0aGVyZSdzIGFuIGV4cGxpY2l0IGlvY3RsIHRv
IEhDSURFVlVQIHRoZSBjaGlwIGF0IHRoZSBlbmQsIHNvIHRoaXMgY29tYmluYXRpb24gY2Fubm90
IHdvcmsgY29ycmVjdGx5IGF0IHRoZSBtb21lbnQuDQo+Pg0KPj4gRm9yIHRoZSB0aW1lIGJlaW5n
LCBJIGhhdmUgZXh0ZW5kZWQgbXkgaGNpYXR0YWNoIHN5c3RlbWQgdW5pdCB3aXRoIGBFeGVjU3Rh
cnRQb3N0PS91c3IvYmluL2hjaWNvbmZpZyBoY2kwIGRvd25gIGFuZCB0aGF0IGZpeGVzIHRoZSBg
c2V0X3ByaXZhY3lgIGNhbGwgY2hhaW4gd2hlbiBzdGFydGluZyBibHVldG9vdGhkLg0KPg0KPiBz
dG9wIHVzaW5nIGhjaWF0dGFjaCBhbmQgc3RhcnQgdXNpbmcgc2VyZGV2Lg0KDQpJJ20gc3RpbGwg
b24gbGludXgtc3RhYmxlIDQuOSwgc28gSSBoYXZlIHRvIHB1dCB0aGF0IG9uIHRoZSBsaXN0IG9m
IHRoaW5ncyB0aGF0IHdpbGwgYmUgYmV0dGVyIHdoZW4gSSBmaW5kIHRpbWUgdG8gdXBkYXRlLiBU
aGFua3MgZm9yIHRoZSBwb2ludGVyIQ0KDQpDaGVlcnMsDQpLYWkNCi0tDQpLYWkgUnVobmF1DQpT
b2Z0d2FyZSBNYW5hZ2VyDQpUOis0OSAyMDIgNzY5MzAyIDE5DQoNClRhcmdldCBTeXN0ZW1lbGVr
dHJvbmlrIEdtYkggJiBDby4gS0cNCkhlaW56LUZhbmdtYW4tU3RyYcOfZSA0DQo0MjI4NyBXdXBw
ZXJ0YWwNCg0KQW10c2dlcmljaHQgV3VwcGVydGFsIEhSQSAyMzg5OA0KUGVyc8O2bmxpY2ggaGFm
dGVuZGUgR2VzZWxsc2NoYWZ0ZXJpbg0KVGFyZ2V0IFN5c3RlbWVsZWt0cm9uaWsgQmV0ZWlsaWd1
bmdzIEdtYkgNCkhlaW56LUZhbmdtYW4tU3RyYcOfZSA0LCA0MjI4NyBXdXBwZXJ0YWwNCkFtdHNn
ZXJpY2h0IFd1cHBlcnRhbCBIUkIgMjUzNDYNCkdlc2Now6RmdHNmw7xocmVyOiBKw7xyZ2VuIFN0
ZWluDQotLQ0K
