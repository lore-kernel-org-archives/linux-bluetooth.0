Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25668C433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 07:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC4AA61260
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 07:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhELHMV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 May 2021 03:12:21 -0400
Received: from mail-dm6nam12on2069.outbound.protection.outlook.com ([40.107.243.69]:56444
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230070AbhELHMU (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 May 2021 03:12:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHHFUFyS5CmcDAEiXs4ViGFDtFs+Ho7aSIZTED6zPdn5pq50GC6ILSejS7EU72zi3n3V2xucynoruhEhL88fKh0OgxPvOqmaMj0ed3HT6QdvcJuE5U68LgEJ9Bqo7/wfUHrXqfU/fSJV8kmRhrn6LOnIkHmwqxfoUsyEnd1UjSAw4s//acVXV9Kqc44MpsteRB+SijBUGJ97TEbpifv4zA6zvnXZfyVq5aVJ08nyPGVuPyDrrrxp3e94R6AmK/bXqhaR11V7qfYOXDbkv8uI9q/+GG5yPjvxRoFCohkEZZx0b+LT0AY3jpwFEIXsZuQV1vXXy2HjBaflgUIhAUtNTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRM+53HZaZ3sTfVjl/hlW+1LQzRRnEpBOzgFkahc3sU=;
 b=HzV8Ntvi3XH+vI7Qwlnna/aPg7++1ohDhfUttbvoReMSJGCRIrFzOOKlxh0FUfVTc+2qdJC6IiNrDBdKomBQmuD3Bqn747HH3C1Nykb7542KbRSgrv+oDRil2WlKFuZbBOYZ1Bj2WeQozuT/Rh/8+mr8xsZCQBHFcgyZDgpivVGb/ifcxdkV8j3r+jT7WzgoCD2bqqsG6LU08CR9pkWg2Qv4ic0HRgezRyvB4KI6ce5fTHmfbHm4+8cP4Yz6nz8klgMLSFqjZT8knDTRKYJIMUvJACdg22Pa5CiC9BpPVNqDEWscL5PsESYNcrsP4ggtxnQ3KZnBrwVRG3OQtJKDJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lairdconnect.com; dmarc=pass action=none
 header.from=lairdconnect.com; dkim=pass header.d=lairdconnect.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lairdconnect.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRM+53HZaZ3sTfVjl/hlW+1LQzRRnEpBOzgFkahc3sU=;
 b=eXc7MfYw1nRTZxu9eHmh+xn6wzq3Q/7p2ogkqKNbuc/FgOyvyi0VCvYToAIkYUn1ROzRHn4pN2rpobVovUCvLoDiOqEmkUdHdzl+kDAkWnZymk7EqUuVWPKmaw8ectjaGtQZOSLgJwTuRBzRlvUoRA/CDSlhXxxYsxAvzFuIn0KRrht0rmCWBnmsyJ6DE2Q8ciNWoMdrmNR6iH9rIC18Cfnm7V85WCfibruInXvQHF8iLSe8/1bIN195WrB3FdTyW57rNQqrjj3tn4LBF9ZF06jHcz6tfEFsCZHbBDuvmR4WTAaegr+SQGIST+aIGBebaLpgWduqehp8zPaWkeF7ww==
Received: from SJ0PR14MB4680.namprd14.prod.outlook.com (2603:10b6:a03:375::23)
 by BYAPR14MB2661.namprd14.prod.outlook.com (2603:10b6:a03:d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Wed, 12 May
 2021 07:11:10 +0000
Received: from SJ0PR14MB4680.namprd14.prod.outlook.com
 ([fe80::5951:2689:bc5b:aa36]) by SJ0PR14MB4680.namprd14.prod.outlook.com
 ([fe80::5951:2689:bc5b:aa36%7]) with mapi id 15.20.4108.031; Wed, 12 May 2021
 07:11:10 +0000
From:   Jamie Mccrae <Jamie.Mccrae@lairdconnect.com>
To:     Kenny Bian <kennybian@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: Build BlueZ 5.50: getting errors
Thread-Topic: Build BlueZ 5.50: getting errors
Thread-Index: AQHXRsW5AjIqI1ujak6uLXfSufrd9Krfbb0g
Date:   Wed, 12 May 2021 07:11:09 +0000
Message-ID: <SJ0PR14MB4680DB694E5B1102E6F91704E6529@SJ0PR14MB4680.namprd14.prod.outlook.com>
References: <CAC9s0NZaXLFvf8DbdSaQC4za-TkR2Dj+r5mp313kCUjEP0S1sA@mail.gmail.com>
In-Reply-To: <CAC9s0NZaXLFvf8DbdSaQC4za-TkR2Dj+r5mp313kCUjEP0S1sA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=lairdconnect.com;
x-originating-ip: [86.161.154.20]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8bbfede-87bc-49cd-f0cb-08d915151e89
x-ms-traffictypediagnostic: BYAPR14MB2661:
x-microsoft-antispam-prvs: <BYAPR14MB2661D2D55494D7BD7C32685AE6529@BYAPR14MB2661.namprd14.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: crf7SfTB5CXvbUuO8ke4KUNctNPmf3zvx0iO3v1IyIqEvN38punoYd2hl/RMgHxEzgEQW5fwkkKacr97R1j7GclH+kJwkf02vM+Va+x2CkwzgpjH1qkYfkK9Jct6FrfSEKMY2p5MaoYZp5TEKPTCgJJmPmeXVKtofzzJXb29jDtuzFcS/Xxbu1v2xg7naF1MllTzdBEphkNSfEIgj1kULZLblACIz1DXFK56ACRNkIhvyRkftxb5RA6Dm0wBLyg628njdc5PxHuqm8JlEKzEl9VIsnu2v3cfsp207razNWtVmFT4hUYPmZJL0fNGkWZdk1AnJIRekd9SZMyiNPzVS1bLMR+byNFoCVthbd4KyZE1myBwpwmPr0Mf0gr4x3BV7dBtdYNgJlnKGniuzz2qvzr6GAUxSjU1MkHMA2SP6M9Mq0gAq+1ooqSv4s/ufkc2RVh2TNH4ZNGia4DtwVyra8Cz05gdLMESrETrgsMg3Kbig4lWGTdCM9TtbcuDnepoRcVBwsuxcVjRkjtrXXbi88C9oBxbyGKEJgVvVjXjr5K3HMjRfa3TIJCXLKmQDQrgNyuoKhw4NgpFOMCa6kQPUogQLWzf0cLurGaJE7kP/lg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR14MB4680.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39840400004)(346002)(376002)(366004)(396003)(478600001)(6506007)(76116006)(186003)(53546011)(83380400001)(33656002)(66946007)(38100700002)(316002)(26005)(55016002)(86362001)(2906002)(5660300002)(52536014)(122000001)(64756008)(9686003)(71200400001)(8676002)(8936002)(66556008)(66446008)(7696005)(110136005)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TC9CczBtdWpMellJUi9kL0Y3TXcrbktqL1FTRXd4K2xzTTRIMCtoeFhzclYv?=
 =?utf-8?B?ZDM5b2Q4OTJOZ21xUmxGdTBEV1B6YWRsVm5RN3dYdWxrVERzNjFwRzI2WndX?=
 =?utf-8?B?MGVxUHRFTDhDOHJQUmpCS216ZWtCanlWSHdic2x3ajBUbXZiYm9pZS81blFO?=
 =?utf-8?B?R0FReXFJTGx3U08xbGxlby9JOUdGejdoVUZYZXFXbnNFcjFuU3lmemhKSVF2?=
 =?utf-8?B?Sk9qMGZWTmtyNWwwQ0NzdDd3MW1SaVFXVkhNQjZxSHBTbHlyZm8zTXovd1g0?=
 =?utf-8?B?Z2RUYTdOdFFhUmtCRE9COThwam5RN0ozakZwN0g0QlVuaFFodFMrT1lQaVN6?=
 =?utf-8?B?c3k1bCtlblVPdDVEd3l0UnhiWTRVZWY0QUZKcmVja0NXV0dNM2w5d1ZHMDlS?=
 =?utf-8?B?eVZld25PNHhCQi8zVmlvbkhmTEdvSE55cFRQZ0ZGQzlXK1BLQkEzek5Tc3Q1?=
 =?utf-8?B?dkZ4SzgvUVMySDRDNWRqMnpPZzBVeFVzL0xVWWYvdFpFS2NlT0pLRm9oWEpI?=
 =?utf-8?B?bnZxbXh0eVpnVnkrZHpvYmFXU3JrL3FpK2RSMmUvVlFvVHN0UlMzMzJqMWw4?=
 =?utf-8?B?QWN3cHdOSlJqL2RjZHB6Mjg0c1pMNU1WNHE4MXhENlpWakJSZDQrOUphVURE?=
 =?utf-8?B?QnlnR2VpbDFJeTBQMUh5Wk0rNTlaWUExSDBCczBoM2lLenBrcUk0UTRqK2xj?=
 =?utf-8?B?WW05YlEzbXhORmYwNkpmdXQrOUx4dDhzOXA2SjYwT3l0SllFZjh5aHRjZDNa?=
 =?utf-8?B?NWg0K05MZklCVXozbjhjelZ4RGRtMTllWFI2Yy85ZTZKaGllR1Z5cjczOTF6?=
 =?utf-8?B?ay9va1VWSFl1Z1BkcnVnODdyYkl0UVp4dzI2UHg2bFFUc2RXdENjZHJnNS83?=
 =?utf-8?B?dWh2TGpNZkZzNi9BZU4wU1Z0ZjhPY1BQY1hMUk5aOWRZNTVTbzZXNWZKQld4?=
 =?utf-8?B?Ylh6a2JVeTFic0xYV2NCN3Bld3RBSFJGU3hCNThwQWsrVzdLK3RScS9HQnlF?=
 =?utf-8?B?Q3BrUFV6OUtWNGpzTnE0eUJCMzRwYkNUbTd4UFZ5SGlCMytPcGFNK2Zuc1li?=
 =?utf-8?B?S2E2SGtadW9JYzlaMGw5RHlSTDVlUVRMc1haRUo0N2VpUXlsb1hTdUlpeCty?=
 =?utf-8?B?MkNjOC9SU2xsd2dRSnlWVzJub1YrY2ZuR3BNS3lqZ2UrbE04cFpyMklkcmVM?=
 =?utf-8?B?b2RvK1h2b2tjV1NDYU1XSEEvT0x1VFRIczY2MmZBWm5tS0o1elhEOGFuTlBS?=
 =?utf-8?B?dEZFTXdSR1pwSUxZc2M3YXR0NXY4aGI3NTR5L2ZraFBYYU9qcHBUS0M4dWxM?=
 =?utf-8?B?TjdiR2NDTjNkTVdoN0YwWDFYcDZTNU5vWHRLdzE5THJyUUhSVitSdXhIcm1w?=
 =?utf-8?B?VXJyTWdYUHVwbnFKeW5vWFg0VTBIZDljenhXbTFodnV6ZU5RQUZNUXNRYTNr?=
 =?utf-8?B?aDRIOFM2ZDZPQUZmMHZmaGdKUGRCaVQwR0VBb245T1BOWUFOMGxtYVVPUVZy?=
 =?utf-8?B?VERTT201dmJZWXlWT1M3Y2NRcmV6ZG1FeUVyV2NVUGhTeENiam5nY3Zqbm9n?=
 =?utf-8?B?S0VxK3liVllwejlNZ0lVU1J4SXYvNFVpZ3ZRQWJoSllXMmNvV3pQY2x5ak9Y?=
 =?utf-8?B?UTZpeVhJMGhqT2pBamdmRWF6bUlrcTJyUmJoV3ltMkMrVGF0Yk1yZlZyaXp5?=
 =?utf-8?B?eWJnaThlNUh5NFpQTmJSKzlEck5YWkpZMGZHMGp5M3VNSjdtNDVoaDNRQ3Vz?=
 =?utf-8?Q?Mcxt5xu8TFDaP514GM5wofvV94JD4A8zhA8yjon?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: lairdconnect.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR14MB4680.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8bbfede-87bc-49cd-f0cb-08d915151e89
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 07:11:09.8686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a67ad7fe-2b14-4d12-b58f-bb509b58f338
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h5mmYXRtZtEj68fdlM87cHfkhmxxJ485Rh2MyZffCw29DxCwNToO32w4Auc9VuGN2WY9GrraCdwrRflm2Qlu85XbkNxMTuluwEPpriKwmuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR14MB2661
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SEkgS2VubnkNClRoaXMgaXNuJ3QgcmVhbGx5IGEgQmx1ZVogcXVlc3Rpb24uIFlvdSB3b3VsZCBu
ZWVkIHRvIGVpdGhlciBjb21waWxlIHRoZSBwYWNrYWdlIGZyb20gc291cmNlIHlvdXJzZWxmIG9y
IGVpdGhlciBqdXN0IHVwZ3JhZGUgdG8gYSBuZXdlciB2ZXJzaW9uIG9mIHlvdXIgZGlzdHJvLiBU
aGUgZGlzdHJvIHZlcnNpb24geW91IGFyZSB1c2luZyBoYXMgbGVzcyB0aGFuIDIgeWVhcnMgbGVm
dCBvZiBzdXBwb3J0LCB3aHkgbm90IGdvIHdpdGggMjAuMDQgTFRTIGluc3RlYWQgd2hpY2ggaGFz
IGEgbG9uZ2VyIHN1cHBvcnQgZHVyYXRpb24/DQpUaGFua3MsDQpKYW1pZQ0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogS2VubnkgQmlhbiA8a2VubnliaWFuQGdtYWlsLmNvbT4N
ClNlbnQ6IDEyIE1heSAyMDIxIDAxOjI4DQpUbzogbGludXgtYmx1ZXRvb3RoQHZnZXIua2VybmVs
Lm9yZw0KU3ViamVjdDogQnVpbGQgQmx1ZVogNS41MDogZ2V0dGluZyBlcnJvcnMNCg0KRVhURVJO
QUwgRU1BSUw6IEJlIGNhcmVmdWwgd2l0aCBhdHRhY2htZW50cyBhbmQgbGlua3MuDQoNCldlIGFy
ZSB1c2luZyBCbHVlWiA1LjQ4IGluIGVtYmVkZGVkIFVidW50dSAxOC4wNC4gV2UncmUgdHJ5aW5n
IHRvIGJ1aWxkIEJsdWVaIDUuNTAgZm9yIGVtYmVkZGVkIFVidW50dSAxOC4wNCBiZWNhdXNlIHdl
IG5lZWQgdGhlICJTZXJ2aWNlIENoYW5nZWQgSW5kaWNhdGlvbiIgZmVhdHVyZSB3aGljaCB3YXMg
Zml4ZWQgaW4gNS41MC4gVGhlIGhvc3Qgc3lzdGVtIHRvIGJ1aWxkIEJsdWVaIGlzIFVidW50dSAx
OC4wNC4NCg0KSSBkb3dubG9hZGVkIHRoZSBCbHVlWiA1LjUwLiBUaGUgQ1BVIG9uIHRoZSBlbWJl
ZGRlZCBkZXZpY2UgaXMgIkZyZWVzY2FsZSBpLk1YNiBVbHRyYUxpdGUiLiBBcyB3ZSBuZWVkIHRv
IGNyb3NzIGNvbXBpbGUgdGhlIEJsdWVaLCBJIHN1cHBvc2Ugd2UgbmVlZCB0byB1c2UgdGhlIG9w
dGlvbiAiLS1ob3N0PWFybS1saW51eC1nbnVlYWJpaGYiLiBJcyB0aGF0IHRoZSBjb3JyZWN0IG9w
dGlvbiBmb3IgY3Jvc3MtY29tcGlsYXRpb24/IEhlcmUgaXMgdGhlIGNvbmZpZ3VyZQ0KY29tbWFu
ZDoNCi4vY29uZmlndXJlIC0taG9zdD1hcm0tbGludXgtZ251ZWFiaWhmIC0tcHJlZml4PS91c3Ig
LS1tYW5kaXI9L3Vzci9zaGFyZS9tYW4gLS1zeXNjb25mZGlyPS9ldGMgLS1sb2NhbHN0YXRlZGly
PS92YXINCg0KQnV0IHRoZXJlIHdlcmUgZXJyb3JzIHdoZW4gd2UgcmFuIHRoZSBjb21tYW5kIGFi
b3ZlOg0KY2hlY2tpbmcgZm9yIEdMSUIuLi4gbm8NCmNvbmZpZ3VyZTogZXJyb3I6IEdMaWIgPj0g
Mi4yOCBpcyByZXF1aXJlZA0KDQpTbyBJIGluc3RhbGxlZCB0aGVzZSBwYWNrYWdlczoNCnN1ZG8g
YXB0LWdldCBpbnN0YWxsIGxpYmdsaWIyLjANCnN1ZG8gYXB0LWdldCBpbnN0YWxsIGdsaWIyLjAN
Cg0KQnV0IEkgc3RpbGwgZ290IHRoZSBzYW1lIGVycm9ycyBldmVuIGlmIHRoZSBwYWNrYWdlcyBh
Ym92ZSB3ZXJlIGluc3RhbGxlZC4gSXQgc2VlbXMgR0xpYiBpcyAyLjI3IGZvciBVYnVudHUgMTgu
MDQuIElmIHRoYXQgaXMgdGhlIGNhc2UsIGhvdyBjYW4gSSBnZXQgR0xpYiB2ZXJzaW9uIDIuMjgg
b3IgYWJvdmUgaW4gb3JkZXIgdG8gZ2V0IGNvbmZpZ3VyZSB3b3JraW5nPw0KDQpUaGFua3MgaW4g
QWR2YW5jZSENClRISVMgTUVTU0FHRSwgQU5ZIEFUVEFDSE1FTlQoUyksIEFORCBUSEUgSU5GT1JN
QVRJT04gQ09OVEFJTkVEIEhFUkVJTiBNQVkgQkUgUFJPUFJJRVRBUlkgVE8gTEFJUkQgQ09OTkVD
VElWSVRZLCBJTkMuIEFORC9PUiBBTk9USEVSIFBBUlRZLCBBTkQgTUFZIEZVUlRIRVIgQkUgSU5U
RU5ERUQgVE8gQkUgS0VQVCBDT05GSURFTlRJQUwuIElGIFlPVSBBUkUgTk9UIFRIRSBJTlRFTkRF
RCBSRUNJUElFTlQsIFBMRUFTRSBERUxFVEUgVEhFIEVNQUlMIEFORCBBTlkgQVRUQUNITUVOVFMs
IEFORCBJTU1FRElBVEVMWSBOT1RJRlkgVEhFIFNFTkRFUiBCWSBSRVRVUk4gRU1BSUwuIFRISVMg
TUVTU0FHRSBBTkQgSVRTIENPTlRFTlRTIEFSRSBUSEUgUFJPUEVSVFkgT0YgTEFJUkQgQ09OTkVD
VElWSVRZLCBJTkMuIEFORCBNQVkgTk9UIEJFIFJFUFJPRFVDRUQgT1IgVVNFRCBXSVRIT1VUIFRI
RSBFWFBSRVNTIFdSSVRURU4gQ09OU0VOVCBPRiBMQUlSRCBDT05ORUNUSVZJVFksIElOQy4NCg==
