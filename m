Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AA8C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 09:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4065F2311D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 09:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbgLVJhp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Dec 2020 04:37:45 -0500
Received: from mail-mw2nam10on2055.outbound.protection.outlook.com ([40.107.94.55]:53472
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725847AbgLVJho (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Dec 2020 04:37:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoMg+FryQwLKtmiNx6ghI3QGYv5ZHQ9oYpbXS5CL2sUicbVz2p0pxR58KjxkZjVdOQwUxYplRMm4WPM8+f1sL1v/YYY7zpzA00qKj4Vj5vcJRdh8UulKucZQ41dzEbVkdsBaDfrl3kALeiWvsL5kkNbGAmkdJc11Vrk8K8MaLFAf6w/8AhmtOe8c5DPG2xAPcDG0KIZd+tuR4fcxyuQB2MrhQo3g2sK3OfM/+ZBKTx3nprz+ZI6i7Akc6qXAKGxO8Snk/u+uLlmIutNaZcLofM2I3nmbJshUkyEmT4lg+CvQs2yBg8bGN4Fi7CfD6ySWE1vWv7ajcfAkP/xPE8taeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iqKRHOI5GrcSrmF9IKwMupadS8hIUSJVSswI0MvXH8=;
 b=EXZXcjy7sIhCr8/uImPs7yxAdfxMupKdS/koSb2SoqaPsDt8fCffqf+zVpGy8DpYg1Nnuxv2WN21bLvaA9+BXQsDxt8ePbfRTUvcH5NHO1BYm+3uHux5qJFBptaXnwmgn3FjCsF0a4JE1+Y6xTIuFGyo14XmSJJ+IWGj5/FxLYvdKc57R76e2fgJ0qwV6hP4sSuAaHyo9wAHlBf4PBdK6ItaOMwpec9U5mypTIRObxgJv8GOx6qz5sqdR1yNUeRyla/MsIJ0DaYIINwxT/7FtKVaY195OMX7PSoncrJwAGUxHOnra0dGFhebWECaYHXcrWZdSAguz0Lgt0XTOhiDvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lairdconnect.com; dmarc=pass action=none
 header.from=lairdconnect.com; dkim=pass header.d=lairdconnect.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lairdconnect.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iqKRHOI5GrcSrmF9IKwMupadS8hIUSJVSswI0MvXH8=;
 b=VtirqEfm6OUGp5crTrxj4yjmsToqYAIrKUZcyFdzvrLLLDFsyVqjF7IGwWSWJUn/uaN2CqcwnF9U6Ylzr/qMfArAgYUf7abSwgLYtSOC5niry+13iKLPLwi6NniDun29ozndRzSuu5UY80o1LhF8+4oV0UFFy9BjvaQJmQUmVHDduibKA+xWGJWivAVPLCQjHtBnPMcp1UgST5epxgBF2si3q0xBkM69NpKEerGYgcBvy80wxJSAuQ0h4fn0Do0JmgZ2RqfIsvCLLQI/wOXkUgc2OEscVPOFxUYeFEgMDHt/Y9mMCbpnxGp0+bmrmyCFbKNYh/nTc5x5YzpEg7bsWw==
Received: from BYAPR14MB2887.namprd14.prod.outlook.com (2603:10b6:a03:15c::18)
 by BY5PR14MB3669.namprd14.prod.outlook.com (2603:10b6:a03:1d2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Tue, 22 Dec
 2020 09:36:48 +0000
Received: from BYAPR14MB2887.namprd14.prod.outlook.com
 ([fe80::5461:f1b4:b127:e482]) by BYAPR14MB2887.namprd14.prod.outlook.com
 ([fe80::5461:f1b4:b127:e482%7]) with mapi id 15.20.3676.033; Tue, 22 Dec 2020
 09:36:48 +0000
From:   Jamie Mccrae <Jamie.Mccrae@lairdconnect.com>
To:     =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: Default to HW mSBC on capable controllers ?
Thread-Topic: Default to HW mSBC on capable controllers ?
Thread-Index: AQHW1UH1ZbjENPecx0GN2Ly2GQ87Man9QZ0AgATQcoCAAE5RAIAAfKIAgAACyyA=
Date:   Tue, 22 Dec 2020 09:36:48 +0000
Message-ID: <BYAPR14MB2887B82FEA76188DE261115BE6DF0@BYAPR14MB2887.namprd14.prod.outlook.com>
References: <CY4PR1001MB2389075CC44E480B446535E5F4C30@CY4PR1001MB2389.namprd10.prod.outlook.com>
 <CABBYNZKy4KXWqLdZu7C49jJ_nMbmBOdMjtM2_5OQg2ruUHUh_w@mail.gmail.com>
 <20201221211437.4s27cl6t4v27sugh@pali>
 <CABBYNZ+tGt4Duf=aYzWPG0OSATj0ZN6oQeFmvw=Un_JVK9C_rQ@mail.gmail.com>
 <20201222092100.ru5inf45v55qoa4m@pali>
In-Reply-To: <20201222092100.ru5inf45v55qoa4m@pali>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=lairdconnect.com;
x-originating-ip: [86.182.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0273ceb4-8b7f-4d16-d84d-08d8a65d1af3
x-ms-traffictypediagnostic: BY5PR14MB3669:
x-microsoft-antispam-prvs: <BY5PR14MB3669A9CE8641913F79FC404EE6DF0@BY5PR14MB3669.namprd14.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CmGd8h7TVILVceGKBxfFwXxlqA9yGEdUVihXkhOEj8OvObJIKNTR4/ouHSnY1Q4lHKTewYp4PXBd9ybtOm+GW0g1dsRY0Kol6Q6RXhRhM0hOI7wBQ1NB8grvWQEf5eEBT+dGtbtRKKCaUysLHgYgUJfCgXdNh9ahjO139kvwX8C8JTUo/t9+Qx7ejoNKtKTIWoDoQj3VggAw8G/lohHzWMMvnCDTGiAP1a+Obb5b/cHo6YSaIA1QO0o8vLSNvefGnTM1pBU2KBX00FbaZeMHEDZDJ8zyG3/SVTRPANdejLcqfnfB5Fg8dxtDpZml/WbY4Sjs4DKdx9mIqHk7v5mgvTW96OXKLDW+GZBu8GwgiQeB1rwf6cVwyacFhgdzkMDpuI2LVueIl6wGM0VHH94ebg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR14MB2887.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(39850400004)(136003)(376002)(52536014)(66446008)(5660300002)(86362001)(8676002)(186003)(54906003)(7696005)(8936002)(83380400001)(9686003)(55016002)(26005)(66946007)(33656002)(4326008)(478600001)(71200400001)(64756008)(66556008)(53546011)(6506007)(2906002)(66476007)(316002)(66574015)(110136005)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dzRSdlpzUFlXRzAydVpMV3BjOGN4VnNBbTNaanY2bmVlSHlDaDFkaHJmQlpr?=
 =?utf-8?B?NGtVN2ZLTE1wQktoUXZrWlhSa3BPZjd6TUk4SDI1YXJNQWdEcUZxUTBpNFpX?=
 =?utf-8?B?eVYxN3EwSGVkZC9jeThFdDc3eHNCZHNZOURVb0szTzV1V0NJekVRb3BmNmta?=
 =?utf-8?B?a3N1b0h1cEFMa0lBenJBS043SzJhWW4rUFhuSXB6NzhnamEwam9LZmZCTTRQ?=
 =?utf-8?B?UnkwczZmMnpjbEVETDIvRCtScWVSVzl4NEZHNElPeDVJMFZqL1VWd3NIYWZD?=
 =?utf-8?B?WnlMblhZeFhlNnpLeVptZ2Fjdk5QNVZtN2t4SUtLNkIzZWVIU1hxYnNyUTAz?=
 =?utf-8?B?cmpmSUJmUVA5RUd2QW1Lb29TVDkrR2VJUWx2UFJxVVBaaDE4Zk9jdndEbFVk?=
 =?utf-8?B?VThRSjNxaG5oemZNbnZCQ3puSlgyU0hPemM0ZWp4Z0lWTVFHY2JwSkVYSkk1?=
 =?utf-8?B?TUdmbTBXUm1yVDhIdGkwUERuRUszOHZrbXFqS2d0UThndjJlQy93ZlN3bVZa?=
 =?utf-8?B?a241eHdrUXc0S3BDQzB1UDBTM1h3RWRmSWowRU1RSllDUEttNDlTWCttSmhK?=
 =?utf-8?B?TWwzZExoZG8wdUpMczN1U3ozZU1ZVVNGZXVIemNJdHhYUEJnSlY4NTB3Rjc4?=
 =?utf-8?B?MmlXNnRERWdhR2VJZzhYOUR6MEJsbG1EeUZ6ZzVpUVJ6eVhIRmxyVDVyUWNF?=
 =?utf-8?B?QUFnVFlmOW55WXAvd2ZZMXh4TzAvSk5JK09OZy8xVUs3bEdWbGJPZU9PRGpO?=
 =?utf-8?B?K0NqaFRlOHpra3hmZ0EvUUI2R1dVUUV5SWd5Sld6ckVBMkl1WHUzRGZOaGIy?=
 =?utf-8?B?VGs1Z1NlR3l0ZVU1QSt1U0pnNzlobHNFbThxZkpRRGJLMklGYlJ4YkpEWGY0?=
 =?utf-8?B?VFkvQWI3TkxXK3RSRXpXUWlpQVFEVGdHSk95UzdtNXVGZStaV1NtUXBwSHZi?=
 =?utf-8?B?SEJ1TEhDbU1HQlZBN2lmWEttTmNoRVo4ODNmWUFsblRoaE41ZG1jRWJ1VmhB?=
 =?utf-8?B?cVExTTQ1RUVtSjlPUklFNTR3SEJDTmdzTHM4RGJyNktZK0I2YkVjMmlnNVA0?=
 =?utf-8?B?MmVlVEpvSVpBR21xbjhycmMzSDFsbjhTOGpCY0o4QWppd1JGbUtTTHQ1eVI4?=
 =?utf-8?B?L05EM2RsR25QYmFRdlZFRFZZeHhBVTgySlVPbTZFNEtRSUtocm5UamFnN1lG?=
 =?utf-8?B?eEt2blZIUGtkT1NRYWsyZkNOb2Rub3RzSkxid1VQTnh2WldYV2JLQmp4d2sw?=
 =?utf-8?B?UkNQY1I1eDFZa0Q2QmxQOXhNUGRLM29ydmw3R0xCeFRHMVZwVHoyeks4cmds?=
 =?utf-8?Q?PUgUwaN00lpGQ=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: lairdconnect.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR14MB2887.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0273ceb4-8b7f-4d16-d84d-08d8a65d1af3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2020 09:36:48.6203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a67ad7fe-2b14-4d12-b58f-bb509b58f338
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XhKpbxtmzYUpoFbJ/gcLXw8jrvkB0XD+dO5bs9qNxDWlq5/sKxTjHoXQRmcO5SMWDI6KOPs93t/Yy8/uZ5h53vJlaA48fHycw04wJjVu54k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR14MB3669
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGksDQoNCj4gT24gTW9uZGF5IDIxIERlY2VtYmVyIDIwMjAgMTc6NTQ6NTYgTHVpeiBBdWd1c3Rv
IHZvbiBEZW50eiB3cm90ZToNCj4gPiBIaSBQYWxpLA0KPiA+DQo+ID4gT24gTW9uLCBEZWMgMjEs
IDIwMjAgYXQgMToxNCBQTSBQYWxpIFJvaMOhciA8cGFsaUBrZXJuZWwub3JnPiB3cm90ZToNCj4g
PiA+DQo+ID4gPiBPbiBGcmlkYXkgMTggRGVjZW1iZXIgMjAyMCAxMTo0MzozMiBMdWl6IEF1Z3Vz
dG8gdm9uIERlbnR6IHdyb3RlOg0KPiA+ID4gPiBIaSBKb2FraW0sDQo+ID4gPiA+DQo+ID4gPiA+
IE9uIEZyaSwgRGVjIDE4LCAyMDIwIGF0IDEwOjQ4IEFNIEpvYWtpbSBUamVybmx1bmQNCj4gPiA+
ID4gPEpvYWtpbS5UamVybmx1bmRAaW5maW5lcmEuY29tPiB3cm90ZToNCj4gPiA+ID4gPg0KPiA+
ID4gPiA+IFRoZXJlIHNlZW1zIHRvIGJlIHF1aXRlIGEgZmV3IFVTQiBjb250cm9sbGVycyBnYWlu
aW5nIHRoZSBCVFVTQl9XSURFQkFORF9TUEVFQ0ggd2hpY2ggSSBndWVzcyBtZWFucyBIVyBtU0JD
IGJ1dCBjdXJyZW50bHkgdGhlcmUgaXMgbm8gd2F5IHRvIHNlbGVjdCB0aGlzIG1vZGUuDQo+ID4g
PiA+ID4gQW55IGlkZWEgaWYgb25lIGNvdWxkIHBhdGNoIHRoZSBrZXJuZWwgdG8gZGVmYXVsdCB0
byBIVyBtU0JDIGFuZCB1c2VyIGFwcHMgbGlrZSBibHVlYWxzYS9wdWxzZWF1ZGlvIHdvdWxkIGp1
c3QgdXNlIGl0IGF1dG9tYXRpY2FsbHk/DQo+ID4gPiA+DQo+ID4gPiA+IEl0IGlzIGluIG91ciBw
bGFuIHRvIHN1cHBvcnQgSFcgb2ZmbG9hZGluZywgYnV0IHRoYXQgZG9lc24ndCBtZWFuIGFsbA0K
PiA+ID4gPiBwbGF0Zm9ybXMgd2lsbCBiZSBzdXBwb3J0ZWQgc2luY2UgdGhhdCBkZXBlbmRzIG9u
IHRoZSBQQ00gbGluZXMgYmVpbmcNCj4gPiA+ID4gY29ubmVjdGVkIHRvIEJUIGNvbnRyb2xsZXIg
aW4gdGhlIGZpcnN0IHBsYWNlLg0KPiA+ID4NCj4gPiA+IERlZGljYXRlZCBQQ00gbGluZXMgYXJl
IHVzZWQgaW4gZW1iZWRkZWQgd29ybGQgYW5kIG1heWJlIGFsc28gc3RpbGwgaW4NCj4gPiA+IHNv
bWUgbW9iaWxlIHNlZ21lbnQuIEkgcmVtZW1iZXIgdGhhdCBlLmcuIE5va2lhIE45MDAgaGFkIHRo
aXMgc2V0dXAuIEFuZA0KPiA+ID4gaXQgd2FzIHF1aXRlIGNyYXp5IGhvdyBpdCB3YXMgZmluYWxs
eSBjb25maWd1cmVkLi4uIGJ1dCBpdCB3b3JrZWQhDQo+ID4gPg0KPiA+ID4gQnV0IHRoaXMgaXMg
bm90aGluZyBmb3IgY2xhc3NpYyB4ODYgbGFwdG9wcyB3aXRoIFVTQiBibHVldG9vdGgNCj4gPiA+
IGNvbnRyb2xsZXJzIG9uIGNsYXNzaWMgaW50ZWwgYmx1ZXRvb3RoK3dpZmkgbVBDSWUgY2FyZHMg
d2hlcmUgU0NPDQo+ID4gPiB0cmFmZmljIGlzIHJvdXRlZCB2aWEgSENJIChvdmVyIFVTQikuIEFu
ZCBub3QgdmlhIGRlZGljYXRlZCBQQ00gcGlucy4NCj4gPiA+IE1vcmVvdmVyIEkgdGhpbmsgdGhl
cmUgYXJlIG5vdCBhbnkgbWFpbnN0cmVhbSBsYXB0b3Agd2hpY2ggaGF2ZSBQQ00gcGlucw0KPiA+
ID4gb24gbVBDSWUgc2xvdHMgdXNhYmxlIGZvciBzdWNoIGJsdWV0b290aCBtUENJZSBjYXJkcy4N
Cj4gPiA+DQo+ID4gPiBGb3IgY2xhc3NpYyBkZXNrdG9wIC8gbGFwdG9wIGl0IGlzIG5lZWRlZCB0
byBkZWFsIHdpdGggZmFjdCB0aGF0IFNDTw0KPiA+ID4gYXVkaW8gaXMgcm91dGVkIHZpYSBIQ0kg
KGxpa2UgQTJEUCkgYW5kIHRoZXJlZm9yZSBzdXBwb3J0IGZvciBFbmhhbmNlZA0KPiA+ID4gU2V0
dXAgU3luY2hyb25vdXMgQ29ubmVjdGlvbiBIQ0kgY29tbWFuZC4NCj4gPiA+DQo+ID4gPiBBRkFJ
SyBldmVuIGZvciByb3V0aW5nIFNDTyBvdmVyIFBDTSB3aGVuIG1TQkMgaHcgZW5jb2RlciBpcyB1
c2VkLA0KPiA+ID4gRW5oYW5jZWQgU2V0dXAgU3luY2hyb25vdXMgQ29ubmVjdGlvbiBIQ0kgY29t
bWFuZCBpcyByZXF1aXJlZC4NCj4gPg0KPiA+IFNvIHlvdSBhcmUgc2F5aW5nIHRoYXQgd2Ugc2hv
dWxkIGRvIFBDTSBvdmVyIEhDSSBhbmQgdGhhdCB3b3VsZA0KPiA+IGFjdHVhbGx5IHdvcmsgKG1l
YW5pbmcgd2UgaGF2ZSBlbm91Z2ggYmFuZHdpZHRoKT8NCj4NCj4gVGhpcyBpcyBzb21ldGhpbmcg
d2hpY2ggbmVlZHMgdG8gYmUgdGVzdGVkLiBBbmQgd2l0aG91dCBmdWxsDQo+IGltcGxlbWVudGF0
aW9uICh3aXRoIGNvbnRyb2wgb2YgYWxsIHBhcmFtZXRlcnMpIHdlIGNhbm5vdCBzYXkgWUVTIG9y
IE5PLg0KPg0KPiBBbmQgaWYgeW91IGFyZSBhd2FyZSBvZiBiYW5kd2lkdGgsIEVuaGFuY2VkIFNl
dHVwIFN5bmNocm9ub3VzIENvbm5lY3Rpb24NCj4gSENJIGNvbW1hbmQgYWxsb3dzIHlvdSB0byB1
c2UgYWxzbyBzb2Z0d2FyZSBiYXNlZCBDVlNEIGNvZGVjLiBNZWFuaW5nDQo+IHRoYXQgQ1ZTRCBl
bmNvZGluZy9kZWNvZGluZyBjYW4gYmUgZG9uZSBieSBhcHBsaWNhdGlvbiBhbmQgdGhlcmVmb3Jl
DQo+IGRlY3JlYXNpbmcgYW1vdW50IG9mIGRhdGEgdG8gdHJhbnNmZXIgdG8gYmx1ZXRvb3RoIGFk
YXB0ZXIuDQo+DQo+IEFzIEkgc2FpZCB0aGlzIGNvbW1hbmQgaXMgbmVlZGVkIGFsc28gaWYgeW91
IHdhbnQgdG8gdXNlIG1TQkMgaHcgZW5jb2Rlcg0KPiBvdmVyIFBDTSwgc28gSSB0aGluayB1c2Fn
ZSBvZiBFbmhhbmNlZCBTZXR1cCBTeW5jaHJvbm91cyBDb25uZWN0aW9uIEhDSQ0KPiBjb21tYW5k
IGFsd2F5cyBoYXZlIGJlbmVmaXRzIHRvIGltcGxlbWVudCBpdCAoSSBoYXZlIHVuZmluaXNoZWQg
YW5kDQo+IHVudGVzdGVkIGltcGxlbWVudGF0aW9uKS4NCj4NCj4gPiBGcm9tIHBvd2VyIHBvaW50
IG9mDQo+ID4gdmlldyB0aGlzIG1ha2VzIHZlcnkgbGl0dGxlIHNlbnNlIGltbywgc2luY2UgYWxs
IHRoZSBjeWNsZSB3ZSBzYXZlIG9uDQo+ID4gbm8gZW5jb2Rpbmcgd2UgcHJvYmFibHkgbG9zZSB3
aXRoIG1vcmUgZGF0YSB0byB0cmFuc21pdCwgc28gYXJlIHdlDQo+ID4gbG9va2luZyBpbnRvIHVz
ZSBIVyBlbmNvZGVyIGp1c3QgdG8gZml4IHRoZSBxdWFsaXR5IG9mIGNvZGVjPw0KPg0KPiBUaGF0
IGlzIGEgZ29vZCBxdWVzdGlvbiBpZiBwb3dlciBjb25zdW1wdGlvbiB3b3VsZCBiZSBpbmNyZWFz
ZWQgb3INCj4gZGVjcmVhc2VkLiBBbnl3YXksIGh3IGVuY29kaW5nIG1heSBiZSBhYmxlIHRvIGFj
aGlldmUgbG93ZXIgbGF0ZW5jeS4gU28NCj4gSSByYXRoZXIgZG8gbm90IGRyb3AgaXQgcHJlbWF0
dXJlbHkgd2l0aG91dCBhbnkgdGVzdHMuDQo+DQo+IEFuZCBhbm90aGVyIGltcG9ydGFudCB0aGlu
Zywgbm90IGFsbCBibHVldG9vdGggYWRhcHRlcnMgYXJlIFVTQiBiYXNlZCwNCj4gdGhlcmUgYXJl
IGFkYXB0ZXJzIGNvbm5lY3RlZCBvdmVyIFVBUlQgYW5kIFNESU8uIEFuZCBldmVyeSBidXMgY2Fu
DQo+IGJlaGF2ZSBkaWZmZXJlbnRseS4gVVNCIGlzIGRvbWFpbiBvZiBsYXB0b3BzLCBVQVJUIGNh
biBiZSBmb3VuZCBvbg0KPiByYXNwYmVycnkgcGkgd2hpY2ggaXMgYWxzbyBoZWF2aWx5IHVzZWQu
IFNESU8gYmx1ZXRvb3RoIGlzIGxlc3MgdXNlZCBidXQNCj4gSSBoYXZlIHRoZXJlIGF0IGxlYXN0
IGRldmljZSBvbiB3aGljaCBpcyBydW5uaW5nIG1haW5saW5lIGtlcm5lbCAoNS4xMCkNCj4gYW5k
IGhhcyBTRElPIGJsdWV0b290aC4NCg0KQ2FuIGNvbmZpcm0gdGhpcywgd2UgaGF2ZSBTRElPLCBV
U0IgYW5kIFVBUlQgaW50ZXJmYWNlcyBvbiB0aGUgbW9kdWxlcw0Kd2Ugc3VwcGx5LiBUaGVyZSBh
cmUgc29tZSBxdWlya3Mgb24gaG93IHRvIHNlbGVjdCByb3V0aW5nIGZvciBQQ00sIG9uDQpDU1Ig
YmFzZWQgZGVzaWducyBJJ20gbm90IHN1cmUgaWYgdGhpcyBjYW4gYmUgY2hhbmdlZCBvbiB0aGUg
Zmx5IHZpYQ0KYSBjb21tYW5kIGJ1dCB0aGUgZGVmYXVsdCBjYW4gYmUgY2hhbmdlZCB2aWEgY2hh
bmdpbmcgdGhlIFBTS0VZDQpjb25maWd1cmF0aW9uIHdoaWxzdCBpbiBCQ1NQIG1vZGUuIE9uIGN5
cHJlc3MgbW9kdWxlcyB5b3UgY2Fubm90DQpjaGFuZ2UgaXQgZHluYW1pY2FsbHkgYXQgYWxsLCBp
dCByZXF1aXJlcyBhIGRpZmZlcmVudCBmaXJtd2FyZSAod2hpY2gsDQpjb252ZXJzZWx5LCBjYW5u
b3QgYmUgb2J0YWluZWQgbm9yIGNoYW5nZWQgYnkgdXNlcnMgaW4gdGhlIGZpZWxkKS4NClRoYW5r
cywNCkphbWllDQpUSElTIE1FU1NBR0UsIEFOWSBBVFRBQ0hNRU5UKFMpLCBBTkQgVEhFIElORk9S
TUFUSU9OIENPTlRBSU5FRCBIRVJFSU4gTUFZIEJFIFBST1BSSUVUQVJZIFRPIExBSVJEIENPTk5F
Q1RJVklUWSwgSU5DLiBBTkQvT1IgQU5PVEhFUiBQQVJUWSwgQU5EIE1BWSBGVVJUSEVSIEJFIElO
VEVOREVEIFRPIEJFIEtFUFQgQ09ORklERU5USUFMLiBJRiBZT1UgQVJFIE5PVCBUSEUgSU5URU5E
RUQgUkVDSVBJRU5ULCBQTEVBU0UgREVMRVRFIFRIRSBFTUFJTCBBTkQgQU5ZIEFUVEFDSE1FTlRT
LCBBTkQgSU1NRURJQVRFTFkgTk9USUZZIFRIRSBTRU5ERVIgQlkgUkVUVVJOIEVNQUlMLiBUSElT
IE1FU1NBR0UgQU5EIElUUyBDT05URU5UUyBBUkUgVEhFIFBST1BFUlRZIE9GIExBSVJEIENPTk5F
Q1RJVklUWSwgSU5DLiBBTkQgTUFZIE5PVCBCRSBSRVBST0RVQ0VEIE9SIFVTRUQgV0lUSE9VVCBU
SEUgRVhQUkVTUyBXUklUVEVOIENPTlNFTlQgT0YgTEFJUkQgQ09OTkVDVElWSVRZLCBJTkMuDQo=
