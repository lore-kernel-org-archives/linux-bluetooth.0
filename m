Return-Path: <SRS0=ag/l=4U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02946C3F2C6
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Mar 2020 18:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9D820842
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Mar 2020 18:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="HCjzWImj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730786AbgCCS0R (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Mar 2020 13:26:17 -0500
Received: from mga04.intel.com ([192.55.52.120]:25298 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729801AbgCCS0R (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Mar 2020 13:26:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 10:26:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="386877845"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga004.jf.intel.com with ESMTP; 03 Mar 2020 10:26:15 -0800
Received: from orsmsx115.amr.corp.intel.com (10.22.240.11) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 3 Mar 2020 10:26:12 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX115.amr.corp.intel.com (10.22.240.11) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 3 Mar 2020 10:26:12 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 3 Mar 2020 10:26:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDxF/ng6Y/Ctd82jSx5Q3jK835RAtirOFghWj6aSLDuo0S7gFHEBHWk9xdDPton6NOnzdKM0TqXIivQfTzbRo+mKccCtEkOWMxOhZbRnkByUmQJqwXzAdV1P9jmX8RZBfqtzsznAhOJCUiqNZVzemEfzBZiWv9ePQ/IjT+GcaXEIwE2OfRnmkPwF2ioTuGRsr59r5HEo39Cg4KrAvUg33AvaRtMcKMVxJtG19CEqeZVoc3jeUT90Shnjiy2jM5Z6XJ04n5RR6m+OiVPNPlcjwxBwQqnpFvPcqZvJ0IcRETD4EVhf03wA6w5dli1SfWRvQBn89YNhQszbZmnsewltug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3uAbWrGSxsBT4cXXRqxRHrObPFKOt7XMkBBkbCvzL4c=;
 b=Xh3V8pmCcFbnVn5RsL0NOWNiv1J2hmd/2SiP/e6eo/5rJEvGmeMzyGaTO4C9pa3oyyrd3nEKlqW4cq6dWBWAd6gkSBRE2keQFntYFMn60Qm6tCv3NPVcSzxWPQXbb+ZqWBbcQr8KJ+3vLoG8J0UJUcNxe8B91A+gZHfx0V70OhDEUTF4HPDk4qHYjhLST7xEt4yyVOTc3ql37sxRueNj5aJwoQtjtMc79B5DeTy+eG1AGPZOZLzeQ0ppVIZ6kOKzxnAPGpFNmA2r/EYs5SiGSskrLTkqo98phuEzGZzN/q37tRrBbPHsQduNRI+99sRe3B4tHVr8Bn8YHxvn0HxXTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3uAbWrGSxsBT4cXXRqxRHrObPFKOt7XMkBBkbCvzL4c=;
 b=HCjzWImjG/gPYIviKUoZt5BFPya/YnOeSGcE7OTNipRgPHWSETKcyhJ2oZbjD8t0tl3Xzd3BE+VlOiWVFIumJyuuWSTUZH/WA8lBtP5MZuSGy73Mt2LVFe3FsiZWc5RjUFWFLogrlCP2P6f9PMRqFtO2rb6nJwLjanSxknQ9Emc=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4634.namprd11.prod.outlook.com (2603:10b6:303:54::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.16; Tue, 3 Mar
 2020 18:26:11 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a%3]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 18:26:11 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "anupam.r@samsung.com" <anupam.r@samsung.com>
CC:     "semun.lee@samsung.com" <semun.lee@samsung.com>,
        "dh79.pyun@samsung.com" <dh79.pyun@samsung.com>,
        "amit.jaiswal@samsung.com" <amit.jaiswal@samsung.com>,
        "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>,
        "nitin.j@samsung.com" <nitin.j@samsung.com>
Subject: Re: Regarding OOB authentication method & action for Mesh provisioner
Thread-Topic: Regarding OOB authentication method & action for Mesh
 provisioner
Thread-Index: AQHV8Yk3BKAvNo5Wbk2mGZ/gble5ng==
Date:   Tue, 3 Mar 2020 18:26:11 +0000
Message-ID: <5125c6f3497334112311a66442730a78cb031adf.camel@intel.com>
References: <f2ea1cd7ff4a84671a53c518e3bdbabc286343cd.camel@intel.com>
         <20200302142239.re57glm4ixjot7d3@mlowasrzechonek2133>
         <20200302125344epcms5p3e31d97ef6263e0513b94f6306536269b@epcms5p3>
         <20200302145518epcms5p7ec2da0403de9efa6733e12290f3cc80d@epcms5p7>
         <7686b0b5ec818946fef72d8eb438460898d53c40.camel@intel.com>
         <CGME20200302125344epcms5p3e31d97ef6263e0513b94f6306536269b@epcms5p1>
         <20200303091825epcms5p128183f5a0fb4790eba71edcf306cf7d0@epcms5p1>
In-Reply-To: <20200303091825epcms5p128183f5a0fb4790eba71edcf306cf7d0@epcms5p1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69346dc1-feed-4c08-c8c9-08d7bfa059a2
x-ms-traffictypediagnostic: MW3PR11MB4634:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB463444B75AB4BBACF3A2F03FE1E40@MW3PR11MB4634.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03319F6FEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(39860400002)(346002)(376002)(189003)(199004)(2906002)(6506007)(54906003)(316002)(86362001)(66446008)(66556008)(64756008)(66476007)(26005)(71200400001)(5660300002)(4326008)(76116006)(6512007)(36756003)(91956017)(186003)(66946007)(8676002)(81156014)(81166006)(6916009)(478600001)(8936002)(6486002)(66574012)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:MW3PR11MB4634;H:MW3PR11MB4539.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j/NWjW491LVLaFiETpfRTm+sRn5OclqoSKEiBqduUqUZ2/+kZrPd82U1kK4R8QRpbQd5zKn0wrmH2W45/e7gedETb92MOO1DGjk9KrLy1aKCCRHvIFrp+ztvBlJp8fU1Z1OhlTiTH/VFpoAWqZDyEGl1xWmwV9UYk7Kgglq6IZz6bbkBnH9GhSpIAWbrIUk5C3Vl3tF97y1SESXzuFhyX8BnSTO1iYpkbsM3yWEzBQcuuliz8uORPn0UP+3fDv4D6BB3q5YHst0oz90kGbcLSog0z2gRv0aBafnITECudYlcrfS177nRaoIghsn671sixq2TKp1ilKN3bQaKOVN0cEovugdMEpSUkIhrRgoc9oflpQLTncScmIImIoJEJHSkKyonoyQ0ZzKWla9SuiOkalmjaeCYv3lT+XpWpxvUdks8Hzfemp1UGP9OBxsgIfDL
x-ms-exchange-antispam-messagedata: uQ6ojIkyFBQR0buiyPKjWPXSeTrc48re5anNy8zSB4aoo636tYooUDJAjJm1ZoLhQu4RSD2VspWirZLDQFTcK6sZb5DnXFeqs6bfaFVgCGOWq5RkWGduUGJoPT6mpvWsxKJVPze/2Dh2S0WCHGGyNQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <85516E2B63BC20409D42E392A946C115@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 69346dc1-feed-4c08-c8c9-08d7bfa059a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2020 18:26:11.4025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fWlro/4lsdSJKmc6snTLQxlg6jS/e4fyf/JMKNFFUabeKfqDYFq3AnlX/Z0pgvLoPWY/fHFu7Ekh3nV4q9U43g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4634
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgQW51cGFtLA0KT24gVHVlLCAyMDIwLTAzLTAzIGF0IDE0OjQ4ICswNTMwLCBBbnVwYW0gUm95
IHdyb3RlOg0KPiAgSGkgSW5nYSwNCj4gU2VuZGVyIDogU3RvdGxhbmQsIEluZ2EgPGluZ2Euc3Rv
dGxhbmRAaW50ZWwuY29tPg0KPiA+IE9uIE1vbiwgMjAyMC0wMy0wMiBhdCAxNjo1NiArMDAwMCwg
R2l4LCBCcmlhbiB3cm90ZToNCj4gPiA+IE9uIE1vbiwgMjAyMC0wMy0wMiBhdCAyMDoyNSArMDUz
MCwgQW51cGFtIFJveSB3cm90ZToNCj4gPiA+ID4gSGkgTWljaGFsLA0KPiA+ID4gPiBTZW5kZXIg
OiBNaWNoYcWCIExvd2FzLVJ6ZWNob25layA8DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gT24gMDMv
MDIsIEFudXBhbSBSb3kgd3JvdGU6DQo+ID4gPiA+ID4gPiBBbHNvLCBJIHdvdWxkIGxpa2UgdG8g
a25vdywgd2hldGhlciB0aGVyZSBpcyBhbnkgcGxhbiB0bw0KPiA+ID4gPiA+ID4gUmVxdWVzdA0K
PiA+ID4gPiA+ID4gZXh0ZXJuYWwgcHJvdmlzaW9uaW5nIEFnZW50IHRvIGNob29zZSBQcm92aXNp
b25pbmcgbWV0aG9kICYNCj4gPiA+ID4gPiA+IHNwZWNpZmljDQo+ID4gPiA+ID4gPiBhY3Rpb24/
ICBUaGUgcmVhc29uIGJlaW5nLCBzb21lICphcHBsaWNhdGlvbiogbWF5IGJlIGludGVyZXN0ZWQN
Cj4gPiA+ID4gPiA+IGluIGENCj4gPiA+ID4gPiA+IHBhcnRpY3VsYXIgU2VjdXJpdHkgbGV2ZWwg
JiBBdXRoZW50aWNhdGlvbiBhY3Rpb24sIGRlcGVuZGluZyBvbg0KPiA+ID4gPiA+ID4gaXRzDQo+
ID4gPiA+ID4gPiBvd24gSS9PIGNhcGFiaWxpdGllcy4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBG
b3IgdGhlIHJlY29yZCwgd2UgYWxzbyBuZWVkIHRoaXMgaXMgZnVuY3Rpb25hbGl0eS4gT25lIG9m
IHRoZQ0KPiA+ID4gPiA+IHBvc3NpYmxlDQo+ID4gPiA+ID4gc2NlbmFyaW9zIGlzIGhhdmluZyBh
IHByb3Zpc2lvbmVyIHdobyBkb2Vzbid0IGhhdmUgYSByZWxpYWJsZQ0KPiA+ID4gPiA+IEludGVy
bmV0DQo+ID4gPiA+ID4gY29ubmVjdGlvbiBhbmQgbWlnaHQgd2FudCB0byBmYWxsIGJhY2sgdG8g
KGxlc3Mgc2VjdXJlKSBPT0INCj4gPiA+ID4gPiBhY3Rpb25zIGlmDQo+ID4gPiA+ID4gaXQgY2Fu
bm90IG9idGFpbiBPT0IgcHVibGljIGtleS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBXZSd2ZSBi
ZWVuIHBsYW5uaW5nIHRvIHNlbmQgYSBwYXRjaCBpbXBsZW1lbnRpbmcgYSBELUJ1cyBBUEkgZm9y
DQo+ID4gPiA+ID4gdGhhdCwNCj4gPiA+ID4gPiBidXQgaXQncyBub3QgcmVhZHkgeWV0IDooDQo+
ID4gPiA+IA0KPiA+ID4gPiBPa2F5LCB0aGF0IHdvdWxkIGJlIG5pY2UgJiBhbmQgd2lsbCBpdCBh
bGxvdyBhcHBsaWNhdGlvbiB0byBjaG9vc2UNCj4gPiA+ID4gYm90aCBhKSAiT09CIFB1YiBLZXko
V2l0aC9XaXRob3V0KSIgYXMNCj4gPiA+ID4gd2VsbCBhcyAgYikiT09CIEF1dGggTWV0aG9kcyhJ
Ti9PVVQvU3RhdGljL05vIE9PQikgJg0KPiA+ID4gPiBBY3Rpb25zKEJsaW5rL0JlZXAvVmlicmF0
ZS9OdW0vYWxwaGEgZXRjLikiPw0KPiA+ID4gDQo+ID4gPiBUaGUgb3JpZ2luYWwgcGxhbiBmb3Ig
dGhpcyB3YXMgdGhhdCBhbiBBZ2VudCBkZWZpbmVzIGl0J3MNCj4gPiA+IENhcGFiaWxpdGllcyBk
LWJ1cyBwcm9wZXJ0aWVzIHRvIGluZGljYXRlIHRoZSBPT0INCj4gPiA+IG1ldGhvZG9sb2dpZXMg
aXQgaXMgd2lsbGluZyB0byBzdXBwb3J0ICpmb3IgdGhhdCBzZXNzaW9uKi4gSWYgeW91DQo+ID4g
PiAqc29tZXRpbWVzKiB3YW50IHRvIHN1cHBvcnQgInN0YXRpYy1vb2IiIG9yDQo+ID4gPiAicHVi
bGljLW9vYiIgKGZvciBpbnN0YW5jZSwgdG8gZG8gYSBDZXJ0aWZpY2F0ZSBsb29rdXAgdmlhIGEg
V0FOKQ0KPiA+ID4gdGhlbiBmb3IgdGhhdCBzZXNzaW9uLCB0aG9zZSBjYXBhYmlsaXRpZXMNCj4g
PiA+IHNob3VsZCBiZSBpbmNsdWRlZCBpbiB0aGUgQWdlbnQncyBDYXBhYmlsaXRpZXMgYXJyYXku
Li4gICBhbmQgaWYgdGhlDQo+ID4gPiBXQU4gaXMgb2ZmbGluZSwgYW5kIENlcnRpZmljYXRlcyBj
YW4ndCBiZQ0KPiA+ID4gcmV0cmlldmVkLCB0aGVuIGxlYXZlIHRoYXQgY2FwYWJpbGl0eSBvdXQu
DQo+ID4gPiANCj4gPiA+IE90aGVyd2lzZSwgeWVzLi4uICBUaGUgKmluaXRpYXRvciogZGFlbW9u
IHRoZW4gbG9va3MgYXQgdGhlDQo+ID4gPiBjYXBhYmlsaXRpZXMgb2YgdGhlIHJlbW90ZSB1bnBy
b3Zpc2lvbmVkIGRldmljZSwNCj4gPiA+IGFuZCB0aGUgY2FwYWJpbGl0aWVzIG9mIHRoZSBsb2Nh
bCBhZ2VudCwgYW5kIGNob29zZXMgdGhlIGhpZ2hlc3QNCj4gPiA+IHNlY3VyaXR5IG1ldGhvZCB0
aGF0IGNhbiBiZSBzdXBwb3J0ZWQgYmV0d2Vlbg0KPiA+ID4gdGhlIHR3byBkZXZpY2VzLiAgQnV0
IHRoZSBsaXN0IG9mIGF2YWlsYWJsZSBtZXRob2RzIGlzIHN0aWxsIHVuZGVyDQo+ID4gPiB0aGUg
Y29udHJvbCBvZiB0aGUgQXBwLg0KPiA+ID4gDQo+ID4gDQo+ID4gVGhlIGRhZW1vbiBpbmRlZWQg
aXMgbWlzc2luZyB0aGUgZHluYW1pYyBhY3F1aXNpdGlvbiBvZiB0aGUNCj4gPiBwcm92aXNpb25l
cidzIGFnZW50IGNhcGFiaWxpdGllcy4gSSB0aGluayB0aGVyZSBpcyBubyBuZWVkIGZvciBhIG5l
dyBELQ0KPiA+IEJ1cyBtZXRob2QsIHRoZSBjdXJyZW50IEFQSSBpcyBzdWZmaWNpZW50LiBXaGF0
IGlzIG5lZWRlZCwgaXMgdG8gYWRkDQo+ID4gY2FsbCBmb3IgR2V0UHJvcGVydHkoKSByZXF1ZXN0
IG9mICJDYXBhYmlsaXRpZXMiIG9uIHRoZSBBZ2VudCBpbnRlcmZhY2UNCj4gPiAoaW4gYWdlbnQu
YykgcHJpb3IgdG8gc2VuZGluZyBwcm92aXNpb25pbmcgaW52aXRlIChpbiBwcm92LWluaXRpYXRv
ci5jLCANCj4gPiBiZWZvcmUgb3IgaW4gcHJvdl9pbml0X29wZW4oKSkNCj4gPiANCj4gVGhhbmtz
IGZvciBzaGFyaW5nIHlvdXIgaW5wdXRzLiBBY3R1YWxseSwgbXkgcG9pbnQgb2YgdmlldyB3YXMg
YWxsb3dpbmcgYXBwbGljYXRpb24gdG8gY2hvb3NlIGEgcGFydGljdWxhcg0KPiBtZXRob2RvbG9n
eSAmIGFjdGlvbg0KPiBiYXNlZCBvbiAqY2FwYWJpbGl0aWVzKiByZWNlaXZlZCBmcm9tIHRoZSBy
ZW1vdGUgdW5wcm92aXNpb25lZCBkZXZpY2UgKm9uIHJ1bnRpbWUqIChBZnRlciByZWNlaXZpbmcN
Cj4gY2FwYWJpbGl0aWVzIFBEVSBmcm9tIHJlbW90ZSkNCj4gSXQgc2VlbXMsIGFib3ZlIG1heSBu
b3QgYmUgcG9zc2libGUgd2l0aCB0aGUgYXBwcm9hY2ggeW91IGhhdmUgZXhwbGFpbmVkLg0KDQpU
aGUgcHJvdmlzaW9uaW5nIGhhcHBlbnMgcHJldHR5IGZhc3Qgb25jZSB0aGUgY2FsbCBvbiB0aGUg
UHJvdmlzaW9uZXIgaXMgbWFkZSwgYW5kIEkgYW0gbm90IHN1cmUgd2hhdCB0aGUNCmFkdmFudGFn
ZSB3b3VsZCBiZSB0byBkZWNpZGluZyAqYWZ0ZXIqIHJlY2VpdmluZyByZW1vdGUgY2FwYWJpbGl0
aWVzLCB3aGljaCBjYXBhYmlsaXRpZXMgKnlvdSogc3VwcG9ydC4gIEFzDQpNaWNoYcWCIG1lbnRp
b25lZCwgaXQgaXMgdHJ1ZSB0aGF0IGlmIHlvdSAqdXN1YWxseSogY2FuIHN1cHBvcnQgYW4gSVAg
YmFzZWQgT09CIGluZm9ybWF0aW9uIGV4Y2hhbmdlLCBidXQgeW91cg0KIldpRmkgaXMgZG93biIs
IHRoYXQgeW91IHdpbGwgd2FudCB0byBkbyBtYW51YWwgaHVtYW4gT09CIGVudHJ5Li4uICBCdXQg
aW4gdGhhdCBjYXNlLCByZW1vdmUgdGhlIGNhcGFiaWxpdGllcw0KdGhhdCByZXF1aXJlIFdpRmkg
ZnJvbSB5b3VyIGFnZW50IGNhcGFiaWxpdGllcyAqYmVmb3JlKiBpbml0aWF0aW5nIHByb3Zpc2lv
bmluZy4gDQoNCj4gDQo+IEkgdGhpbmssIGJ5IGV4cG9zaW5nIGFnZW50IHByb3BlcnRpZXMsIGRh
ZW1vbiB3aWxsIHN1cmVseSB0YWtpbmcgaW50byBjb25zaWRlcmF0aW9uLCB0aGUgY2hvaWNlIG9m
DQo+IHByb3Zpc2lvbmluZyBhZ2VudCwgaG93ZXZlciwNCj4gY2hvb3NpbmcgKmZpbmFsIG1ldGhv
ZCAmIGFjdGlvbiogd2lsbCBzdGlsbCBiZSBpbiBjb250cm9sIG9mIGRhZW1vbiBieSB0aGlzIGFw
cHJvYWNoLCBpZiBJIGFtIHVuZGVyc3RhbmRpbmcNCj4gaXQgY29ycmVjdGx5Lg0KPiBGb3IgaW5z
dGFuY2UsIGlmIGJvdGggYWdlbnQgJiBub2RlIHN1cHBvcnQgT1VUIE9PQiB3aXRoIEJsaW5rL0Jl
ZXAvVmlicmF0ZSwgdGhlbiBkYWVtb24gd2lsbCBoYXZlIHRvDQo+IGludGVybmFsbHkgZGVjaWRl
IG9uIGEgc3BlY2lmaWMgKmFjdGlvbiosIGlmIGl0IGNob29zaW5nIE9VVCBPT0IuDQoNCldlIG1h
eSBoYXZlIGEgbWlzdW5kZXJzdGFuZGluZyBvZiB0ZXJtcyBoZXJlLiAgVGhlIGFwcGxpY2F0aW9u
IGNvbnRyb2xzIHRoZSAiYWdlbnQiLCBhbmQgdGhlIG5vZGUgKGFzIG1hbmFnZWQNCmJ5IHRoZSBk
YWVtb24pIG9ubHkgc3VwcG9ydHMgd2hhdCB0aGUgYWdlbnQgdGVsbHMgaXQgdG8gc3VwcG9ydC4g
IFRoZSAqcmVtb3RlKiBkZXZpY2UgYmVpbmcgcHJvdmlzaW9uZWQgaXMgdGhlDQpvbmx5IHRoaW5n
IHRoYXQgbWF5IG9yIG1heSBub3QgbWF0Y2ggc3BlY2lmaWMgY2FwYWJpbGl0aWVzIG9uIHRoZSBs
b2NhbCBhZ2VudC4gIEFuZCB0eXBpY2FsbHkgdGhlIGxvY2FsDQpwcm92aXNpb25lcidzIHN1cHBv
cnQgb2YgdGhlIHZhcmlvdXMgT1VUIE9PQiBvciBJTiBPT0IgaXMgc2ltcGxpc3RpYyBvbiB0aGUg
UHJvdmlzaW9uZXIgc2lkZS4uLiAgDQoNCk1vc3QgKGlmIG5vdCBhbGwpIHJlbW90ZSBkZXZpY2Vz
IHdpbGwgaGF2ZSBvbmx5ICpvbmUqIG9mIEJsaW5rLCBCZWVwLCBWaWJyYXRlLCBPdXQgTnVtZXJp
YyBvciBvdXQgQWxwaGFiZXRpYy4gDQpTdXBwb3J0IG9uIHRoZSBQcm92aXNpb25lciB3aWxsIGlu
ZGVlZCBhdXRvIHNlbGVjdCBvbmUgaW4gdGhlIHJhcmUgY2FzZSB0aGF0IGl0IHN1cHBvcnRzIG1v
cmUgdGhhbiBvbmUsIGFuZA0Kd2lsbCBzZWxlY3QgdGhlIGhpZ2hlc3Qgc2VjdXJpdHkuICBCdXQg
cmVnYXJkbGVzcywgb24gdGhlICpQcm92aXNpb25lciBTaWRlKiB5b3Ugd2lsbCBiYXNpY2FsbHkg
anVzdCBkaXNwbGF5IGENCnN0cmluZyBsaWtlOg0KIkVudGVyIHRoZSBudW1iZXIgb2YgdGltZXMg
cmVtb3RlIGRldmljZSBCbGlua2VkIiBmb3IgZXhhbXBsZS4gIA0KDQpTYW1lIGZvciBJTiBPT0Is
IGV4Y2VwdCB0aGUgYWN0aW9uIG9mIHRoZSBQcm92aXNpb25lciB3aWxsIGJlIHRvIGRpc3BsYXkg
YSBzdHJpbmcgbGlrZToNCiJUd2lzdCBkZXZpY2UgWCB0aW1lcyIgYmVjYXVzZSB0aGUgcmVtb3Rl
IGRldmljZSBoYXMgdG9sZCB1cyBpdCBoYXMgc29tZXRoaW5nIHRoYXQgY2FuIGJlIHR3aXN0ZWQu
DQoNCkZvciBodW1hbiBlbnRlcmVkIE9PQiAob24gZWl0aGVyIHNpZGUpIHdlIGFzc3VtZSB0aGF0
IHRoZSBQcm92aXNpb25lciBpcyBoaWdoIGZ1bmN0aW9uaW5nIChoYXMgYWJpbGl0eSB0bw0KZGlz
cGxheSBhbnkga2luZCBvZiBzdHJpbmcsIGFuZCBhY2NlcHQgYW55IGtpbmQgb2YgbWFudWFsIGlu
cHV0KSBhbmQgdGhlICppZiogZWl0aGVyIGRldmljZSBpcyBsb3cgZnVuY3Rpb25pbmcNCml0IGlz
IHRoZSB1bnByb3Zpc2lvbmVkIGRldmljZSwgd2hpY2ggd2lsbCBwcm9iYWJseSBvbmx5IGhhdmUg
YSBzaW5nbGUgbWV0aG9kIG9mIGFjY2VwdGluZyBvciBvdXRwdXRpbmcgT09CDQpkYXRhLg0KDQpF
aXRoZXIgd2F5LCB0aGUgVW5wcm92aXNpb25lZCBCZWFjb24gc2hvdWxkIHRlbGwgdGhlIFByb3Zp
c2lvbmVyIGFsbCBvZiB0aGUgaW5mb3JtYXRpb24gaXQgbmVlZHMgdG8ga25vdw0KKGVzcGVjaWFs
bHkgd2hlbiBjb21iaW5lZCB3aXRoIGluZm9ybWF0aW9uIGxpa2UgIk15IFdpRmkgaXNuJ3Qgd29y
a2luZyIpIHRvIGRlY2lkZSB3aGljaCBjYXBhYmlsaXRpZXMgdG8NCmluY2x1ZGUgaW4gaXQncyBh
Z2VudC4NCg0KV2hhdCB3ZSBkb24ndCB3YW50IGlzIHRvIHJlcXVpcmUgYW4gYWRkaXRpb25hbCBo
dW1hbiBpbnRlcmFjdGlvbiByZXF1aXJpbmcgYSBjaG9pY2Ugb2Ygd2hhdCB0byB1c2UgYmVmb3Jl
DQphZHZhbmNpbmcgdG8gdGhlIGlucHV0IGl0c2VsZi4gV2UgYXJlIHRyeWluZyB0byBrZWVwIGl0
IHRvIGEgc2luZ2xlIGludGVyYWN0aW9uLg0KDQo+IEFsc28sIGJldHdlZW4gT1VUL0lOL1N0YXRp
YyBPT0IsIGRhbWVvbiB3aWxsIGhhdmUgdG8gaW50ZXJuYWxseSBkZWNpZGUgb24gYSBtZXRob2Qs
IG1heSBiZSBhcHBseWluZyBzb21lIHByZS0NCj4gZGVmaW5lZCBzZWN1cml0eSBsZXZlbD8gUGxl
YXNlIGxldCBtZSBrbm93IGlmIEkgYW0gbWlzc2luZyBzb21ldGhpbmcuIFRoYW5rIFlvdS4NCg0K
Qm90aCB0aGUgT3V0cHV0IEFjdGlvbiBhbmQgSW5wdXQgQWN0aW9uIGFyZSBhcnJhbmdlZCBieSB2
YWx1ZSBpbiBvcmRlciBvZiBsZXZlbCBvZiBzZWN1cml0eSBwb3NzaWJsZToNCjEuIExvd2VzdA0K
CU5vIElucHV0L05vIE91dHB1dA0KDQoyLiBTdGlsbCBwcmV0dHkgbG93IChyYW5kb20gbnVtYmVy
IGZyb20gMC05KQ0KCUJsaW5rDQoJQmVlcA0KCVZpYnJhdGUNCglQdXNoDQoJVHdpc3QNCg0KMy4g
UHJldHR5IEdvb2QgKHJhbmRvbSBudW1iZXIgYmV0d2VlbiAwLTk5OTk5OTk5KQ0KCUlucHV0IE51
bWVyaWMNCglPdXRwdXQgTnVtZXJpYw0KDQo0LiBFdmVuIEJldHRlciAocmFuZG9tIDggY2hhciBz
dHJpbmcgaW5jb3Jwb3JhdGluZyAwLTksIGEteiwgQS1aKQ0KCUlucHV0IEFscGhhbnVtZXJpYw0K
CU91dHB1dCBBbHBoYW51bWVyaWMNCg0KNS4gQmVzdCAoUHJvYmFibHkgSVAgbmV0d29yayBkZWxp
dmVyZWQgc2lnbmVkIGNlcnRpZmljYXRlcyBvciBzY2FubmVkIGJhcmNvZGVzKQ0KCU9PQiBQdWJs
aWMgS2V5DQoJT09CIFN0YXRpYw0KCQ0KDQo+IA0KPiA+IFJlZ2FyZHMsDQo+ID4gSW5nYQ0K
