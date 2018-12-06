Return-Path: <SRS0=vk22=OP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9602DC04EB8
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Dec 2018 17:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4073020989
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Dec 2018 17:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4073020989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=target-sg.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725898AbeLFRen (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:34:43 -0500
Received: from mail-eopbgr00101.outbound.protection.outlook.com ([40.107.0.101]:54432
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725871AbeLFRen (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Dec 2018 12:34:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=targetsg.onmicrosoft.com; s=selector1-targetsg-com01e;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ryg9eMh4IGqRnHsrPGOtEGTbhBVm9t99pjWTxr7uUQ=;
 b=bSAml5axcGo34C/ckW89JhlrvGMHloB2VYssAe1oHegrB10mvYUbUPiunYVZmxKwMKxt2wliEm6+pPpoFtuMrtyWVWnwUXjpIfWgxSfXgOzKA8dj1lihKl6NBqZ+PDxierFMAlunWTOmwWWcVjqLNFgJEvUxsi7VHuEN6UMhoQM=
Received: from AM0PR02MB3841.eurprd02.prod.outlook.com (52.134.80.26) by
 AM0PR02MB3684.eurprd02.prod.outlook.com (52.133.63.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.21; Thu, 6 Dec 2018 17:34:40 +0000
Received: from AM0PR02MB3841.eurprd02.prod.outlook.com
 ([fe80::2160:b53d:b508:7bd7]) by AM0PR02MB3841.eurprd02.prod.outlook.com
 ([fe80::2160:b53d:b508:7bd7%4]) with mapi id 15.20.1382.023; Thu, 6 Dec 2018
 17:34:40 +0000
From:   Kai Ruhnau <kai.ruhnau@target-sg.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Broken "device" privacy for my TI chip
Thread-Topic: Broken "device" privacy for my TI chip
Thread-Index: AdSNifJ+UYE5GaWEQKeA1pt1wcpcBg==
Date:   Thu, 6 Dec 2018 17:34:40 +0000
Message-ID: <AM0PR02MB38415BE5FF10D0A6D1469E8AC5A90@AM0PR02MB3841.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kai.ruhnau@target-sg.com; 
x-originating-ip: [80.133.39.24]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR02MB3684;6:8J2e7LbEI/Sx0MjuwO9QG2Dkna7EgItqkEZGijJGxSXaRlQ+leuahXx3puOvwlITa4zTSskeExAkvp66hdsY9AwwNJLBPQQyEjS0xYryRsQkW5McbS112HeK+/vhZJ8EtHq3pUytusLi4sl+OspXGVV06DPPt/pc4EEH7iWdaIi4dAEkh5w4KLGKmcb8RleR7ga8+JOOhLVgGmQ92CBJv+m2ebfx/0c+aq9o056p220SyGgP8ZqfuwrVywVGkqYLgttSccg171r7NcvqF5NpMUsSwWaFzJnRIhkIyq/Nblq6P4Qx1zHyzomn2VlDRWQ1acF3k4oZ6SnuRBi00OGIn1g7qAbiJM+CHznJPZRsGz/k4XvIN9kn+v+YDBsL8kOTF20K3gkVNgtZbSqZRoecqW3X8lckirGOIYCp04EqdjndfuNE+vUc8V5A7UNpKDPNZH48qtJqCll2lhMY/RWmag==;5:WRBz+KtXzY3jFvb77W+QVViGewlOLZkbUBnJS56QUnAnAzm8zAe9rwGWEPoZmVIo41kUgCuhP99e/bTuWJzxAswjP0o3iUiVyI2SXKDkkGvWwOCocKsAjn4/wlIguN2jhGWiQMcbJaafcwm5cOKN8psCgZ6a+vLG7J4D77deIhA=;7:4wCefn+gaPV1HHqhW3nQ5h6v6AMmdszHmTYAfcVUb3GJ09LqdgSQBNDKSZTZqY9DMbtAlLTGexG2+X4K4RHsnoUczK5qJbidwYaYfgl8rCQebOvLVepzoQHnzvyLClT303LkXjLs2PaG+NTcaigqqQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d68bfed9-866d-4374-b9d2-08d65ba11a2c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM0PR02MB3684;
x-ms-traffictypediagnostic: AM0PR02MB3684:
x-microsoft-antispam-prvs: <AM0PR02MB3684E9361B92B4EC764F2485C5A90@AM0PR02MB3684.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(2016111802025)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:AM0PR02MB3684;BCL:0;PCL:0;RULEID:;SRVR:AM0PR02MB3684;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39830400003)(396003)(376002)(136003)(189003)(199004)(99286004)(86362001)(55016002)(26005)(97736004)(2501003)(5640700003)(486006)(5660300001)(66574010)(53936002)(2906002)(9686003)(14454004)(105586002)(71190400001)(81166006)(8676002)(81156014)(71200400001)(256004)(66066001)(106356001)(74316002)(316002)(3846002)(476003)(305945005)(33656002)(7696005)(6116002)(8936002)(7736002)(102836004)(6916009)(44832011)(6506007)(186003)(68736007)(508600001)(6436002)(25786009)(2351001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR02MB3684;H:AM0PR02MB3841.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: target-sg.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wEH+QASvVUdj89m2YSosZZxIfPl6/LwbSFCcGVbeqRpbLmXP8hMYD6TtbHTpyxMAqrEHhz39gLWjAOjPOd7CHt1Iahu0tYhcjqIpHkyXFpcsc6RoTW1XiyGHUoSORTW4TiYdA542Q4bVneCd599ijDd7dyvUfwCBL95BTphxrMsdaCwAERyovStrM4olxwnDsaOe4iBTSQ8XhocNBkusvcKSF94MZCKi0J508oZbm9QWC2pCsouY6N4Gv7fxL2MqgYU8Z8CXiZ5m91Ml3ZNTHgqpfnE5fWnfms8vfo6UWlx/3klKfJBRNTFnkh8/I+KF9aHakpqDWbOWQBpfTYpMlINoP4rWZUVSkufsvVJlJH4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: target-sg.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d68bfed9-866d-4374-b9d2-08d65ba11a2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 17:34:40.5864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 52a4fe2f-f30a-452d-90b1-03ecc8ab0c0d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB3684
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGksDQoNCknigJltIHJ1bm5pbmcgQmx1ZVogNS41MCBvbiBteSBlbWJlZGRlZCBwbGF0Zm9ybSBj
b250YWluaW5nIGFuIE9ESU4tVzE2MCBXaUZpL0JsdWV0b290aC1jb21iby1jaGlwIHdpdGggYSBU
SSBCbHVldG9vdGggY29yZS4gQWZ0ZXIgdW4tcmVzZXR0aW5nIHRoZSBCbHVldG9vdGggcG93ZXIg
R1BJTywgSSBydW4gYGhjaWF0dGFjaCDigKYgdGV4YXMgMTE1MjAwIGZsb3dgIGFuZCB0aGVuIHN0
YXJ0IGJsdWV0b290aGQuIEluIGBtYWluLmNvbmZgLCBJIGhhdmUgc2V0IGBQcml2YWN5PWRldmlj
ZWAuDQoNCldpdGggdGhpcyBzZXR1cCwgdGhlIGBzZXRfcHJpdmFjeV9jb21wbGV0ZWAgKGFkYXB0
ZXIuYykgY2FsbGJhY2sgaW4gYmx1ZXRvb3RoZCBpcyBjYWxsZWQgd2l0aCBgc3RhdHVzID09IE1H
TVRfU1RBVFVTX1JFSkVDVEVEYCBhbmQgYWNjb3JkaW5nIHRvIG15IDQuOSBrZXJuZWwsIHRoaXMg
aXMgdGhlIGNhc2Ugd2hlbiBgaGRldl9pc19wb3dlcmVkYDogQWZ0ZXIgYm9vdGluZyBhbmQgcnVu
bmluZyBgaGNpYXR0YWNoYCwgbXkgY2hpcCBpcyBhbHJlYWR5ICJ1cCIgYW5kIHRodXMgSSBjYW5u
b3Qgc2V0IHRoZSBJUksuDQoNCkkgZm91bmQgaW4gYHRleGFzX3Bvc3RgIChoY2lhdHRhY2hfdGku
YyksIHRoYXQgdGhlcmUncyBhbiBleHBsaWNpdCBpb2N0bCB0byBIQ0lERVZVUCB0aGUgY2hpcCBh
dCB0aGUgZW5kLCBzbyB0aGlzIGNvbWJpbmF0aW9uIGNhbm5vdCB3b3JrIGNvcnJlY3RseSBhdCB0
aGUgbW9tZW50Lg0KDQpGb3IgdGhlIHRpbWUgYmVpbmcsIEkgaGF2ZSBleHRlbmRlZCBteSBoY2lh
dHRhY2ggc3lzdGVtZCB1bml0IHdpdGggYEV4ZWNTdGFydFBvc3Q9L3Vzci9iaW4vaGNpY29uZmln
IGhjaTAgZG93bmAgYW5kIHRoYXQgZml4ZXMgdGhlIGBzZXRfcHJpdmFjeWAgY2FsbCBjaGFpbiB3
aGVuIHN0YXJ0aW5nIGJsdWV0b290aGQuDQoNCkNoZWVycywNCkthaQ0KDQotLQ0KS2FpIFJ1aG5h
dQ0KU29mdHdhcmUgTWFuYWdlcg0KVDorNDkgMjAyIDc2OTMwMiAxOQ0KDQpUYXJnZXQgU3lzdGVt
ZWxla3Ryb25payBHbWJIICYgQ28uIEtHDQpIZWluei1GYW5nbWFuLVN0cmHDn2UgNA0KNDIyODcg
V3VwcGVydGFsDQoNCkFtdHNnZXJpY2h0IFd1cHBlcnRhbCBIUkEgMjM4OTgNClBlcnPDtm5saWNo
IGhhZnRlbmRlIEdlc2VsbHNjaGFmdGVyaW4NClRhcmdldCBTeXN0ZW1lbGVrdHJvbmlrIEJldGVp
bGlndW5ncyBHbWJIDQpIZWluei1GYW5nbWFuLVN0cmHDn2UgNCwgNDIyODcgV3VwcGVydGFsDQpB
bXRzZ2VyaWNodCBXdXBwZXJ0YWwgSFJCIDI1MzQ2DQpHZXNjaMOkZnRzZsO8aHJlcjogSsO8cmdl
biBTdGVpbg0KLS0NCg==
