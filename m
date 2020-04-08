Return-Path: <SRS0=PsJ4=5Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDEBC2D0F4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Apr 2020 18:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9562075E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Apr 2020 18:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="U0KzTpSM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgDHSMJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Apr 2020 14:12:09 -0400
Received: from mga11.intel.com ([192.55.52.93]:46941 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbgDHSMJ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Apr 2020 14:12:09 -0400
IronPort-SDR: wO6ESlZUloLHjVDOzM+K4eX05lXpKFi674C0gZAbh0gNcMbjITElr/mR5RzTveM3y6WBJUowNY
 XQNmYU8FcmRA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 11:12:08 -0700
IronPort-SDR: YgvFscjJU50bIsIV21FfCR6L9oc6wPsM7d0GzWuZEVYvrm5CQoaTNxNQPA6igoYmEHr+3d3Aso
 p8ttjeL/XaRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,359,1580803200"; 
   d="scan'208";a="244103039"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by fmsmga008.fm.intel.com with ESMTP; 08 Apr 2020 11:12:08 -0700
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 8 Apr 2020 11:12:08 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX157.amr.corp.intel.com (10.22.240.23) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 8 Apr 2020 11:12:08 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.53) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 8 Apr 2020 11:12:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bn/Qb3kawE614HTv4L5PbpbecuyGV/WlDASAKpI8mCtnhSxL/dKuQxqGkX5iCOE/NN2uB4YmDJHypU6hqdyehxdlhVxtr8FKgxKyw02QQ1yoxzUlbZH1wMYXMd8V4WuNk/SfhDXQHQ91DIvU3uKHHrBifsrka2NhbMqvx1NbafH/d1o97AvIhnbWM28FCBqVvke151p5QzntkqJegxCHgB3Qjfn8TeqGuuDixOJnVlU4mGzkX3499WaBrbcGRV9BDFrOKJXT7izTHGGk3NjH8hfQxBvVMErPEIsrH+kh1qRH9xr+XNA9CEJBByHJXOVVWGXC8OwQ3IPGIiEMIDoUBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGrunuHaUaI42Z1Hoc8mKu+ezeeCiWOAQIFQDW7KnTk=;
 b=RmbAFz9k8mvaRVp1TuOQBxvHk2Dniyr9dHw9jP7zDe+d9NXj/nLdk1aqhRQBkgx3RsJaCinkwE0Q1a5FWdWbBFIywGA4i6nshMZf6jR6w1VvMsEWh7EewZxKjCoQKR15oH6gf9kfJ77fheAhL0P7wthO/LSVpX6T5xmxAHDJndAacFkHeQiz/Lr1uJ2fgDJrUDUEd5FWuDuF2jsLzexbirejUwSQmfu/WNCM17rpyYCue+3GlPij22/jOICASIyagbBhwy6lOAlLw1em1gSBRrly9jxkKqKZ6zNySMl7PvvhTGhdbN+JD03/6KQIZgbcL2bOgeOLw+zj4XeJEQVe7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGrunuHaUaI42Z1Hoc8mKu+ezeeCiWOAQIFQDW7KnTk=;
 b=U0KzTpSMHT+p1s0GKjtAnNyN4Evp/6qpcTb0kMUJ5H16C2MzfAqUz5hR+sHm1GQ80jW9AHDjpB7a0RL5xfjd1HRGUYMn1hvdV0OgtN6ANbkZBzqKSJexGBKzbT89V1Slojo8Fyjzug2bX86BppYLRxGLRRgL8qfwgxu9cJLJz8Y=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4620.namprd11.prod.outlook.com (2603:10b6:303:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Wed, 8 Apr
 2020 18:12:07 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a%3]) with mapi id 15.20.2900.015; Wed, 8 Apr 2020
 18:12:07 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "Stotland, Inga" <inga.stotland@intel.com>,
        "rafal.gajda@silvair.com" <rafal.gajda@silvair.com>
Subject: Re: [PATCH BlueZ v2] mesh: Ignore beacons with IVU if IV already
 updated
Thread-Topic: [PATCH BlueZ v2] mesh: Ignore beacons with IVU if IV already
 updated
Thread-Index: AQHWDcl1RRWdVuljJkCMewqPu9e8JahvhtQA
Date:   Wed, 8 Apr 2020 18:12:06 +0000
Message-ID: <d5c4e48a176cbb32d45ef5460615bed40271b1a3.camel@intel.com>
References: <20200408171516.15151-1-brian.gix@intel.com>
In-Reply-To: <20200408171516.15151-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [134.134.137.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09d043f3-fd48-4e1a-42b6-08d7dbe8592b
x-ms-traffictypediagnostic: MW3PR11MB4620:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB46207483B5839399973C668DE1C00@MW3PR11MB4620.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0367A50BB1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(346002)(136003)(376002)(396003)(39850400004)(366004)(6506007)(81156014)(64756008)(66476007)(186003)(6486002)(76116006)(66556008)(66946007)(478600001)(15650500001)(26005)(81166007)(6512007)(2906002)(2616005)(36756003)(86362001)(8676002)(8936002)(66446008)(54906003)(6916009)(316002)(4326008)(71200400001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V6JEp4ygQovnCzGbPWrSlfuxu49WlBBQSGS9i5pCnI+m3orid/mw1iZ5BMZgsaf5tTIpE+M0HSvbwC4ZUaHmEhrBk0gxj9uB4/lN16oUUiDeuEl9AB6TTLXh+HwSblOl+IdN6k8tb4JPmXbUinBUDb4o018c+K2oQGyDRQ9gdv7uNtzvyOMyfjhfMVmx0eoILCZpvI8v0EZ2IpJB+kXRzi4lF+5vYGHQczllaw5XZ39Nn3H1kWHHVvpV2gtCNLljXRvy6h436w15knUz2/z8jqDPWpgok+ZgWTWAe4WWdDPCoMUeyQvsVoxUdGf9Me1te+DFs0N8TfSRbVngx1oMsJKvA5CAGqJR2dFO5NthcgAfoe6mUWzCxI2ne0AQWbBBPtTsb7wN3FNgYsEshl3Z+uvoBiBxDDhNUiMvj5jPoPPj9V0Q59NUukjoXeuyiTMg
x-ms-exchange-antispam-messagedata: GTASFum4o1qjWk6XINaj7A3fajAS9wGO2CDpBJjN7FIeQWfriic+JdBBg3yyX58tixHqr9czJDVPvIP7isbYISae2FidGlv5+Wvx/XnxPZnMGXjS6Fgv/Sl4LUCEEv+AA4aJ17sfufOrXhS22SEW8w==
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CD1B8966E6A254595BFD6B18922E9B5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d043f3-fd48-4e1a-42b6-08d7dbe8592b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2020 18:12:06.9743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7+rDR/i0MG3kZPYNYO4bohNB8JHutGoruixJEnqxNx8BxpuM4q2Lca2yT/vWEUQ7L9ht0jpolojnr2bdKhoXGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4620
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCwgVGhhbmtzDQpPbiBXZWQsIDIwMjAtMDQtMDggYXQgMTA6MTUgLTA3MDAsIEJyaWFu
IEdpeCB3cm90ZToNCj4gRnJvbTogUmFmYcWCIEdhamRhIDxyYWZhbC5nYWpkYUBzaWx2YWlyLmNv
bT4NCj4gDQo+IFdoZW4gZGFlbW9uIHJlY2VpdmVzIGJlYWNvbiB3aXRoIElWPW4rMSwgSVZVPUZh
bHNlIGl0IHdpbGwNCj4gc3RhcnQgc2VuZGluZyBtZXNzYWdlcyB3aXRoIG5ldyBJViBhbmQgc2V0
IHNlcXVlbmNlIHRvIDAuDQo+IEhvd2V2ZXIgaWYgZGFlbW9uIHJlY2VpdmVzIGFub3RoZXIgYmVh
Y29uIHdpdGggSVY9bisxLCBJVlU9VHJ1ZSBpdA0KPiB3aWxsIGdvIGJhY2sgdG8gc2VuZGluZyBt
ZXNzYWdlcyB3aXRoIG9sZCBJVj1uIChJVlUgc2V0IHRvIFRydWUpLg0KPiBCZWNhdXNlIHNlcXVl
bmNlIG51bWJlciBoYXMgYmVlbiByZXNldCB0aG9zZSBtZXNzYWdlcyB3aWxsIGJlIGRyb3BwZWQN
Cj4gYnkgcmVwbGF5IHByb3RlY3Rpb24gYW5kIG5vZGUgd2lsbCBsb3NlIGNvbW11bmljYXRpb24u
DQo+IA0KPiBPbmNlIElWIGlzIHVwZGF0ZWQgZGFlbW9uIHNob3VsZCBub3QgZ28gYmFjayB0byB1
c2luZyB0aGUgb2xkIHZhbHVlLg0KPiANCj4gVGhpcyBwYXRjaCBhZGRzIGJlYWNvbiByZWplY3Rp
b24gaWYgSVYgaGFzIGFscmVhZHkgYmVlbiB1cGRhdGVkLg0KPiAtLS0NCj4gIG1lc2gvbmV0LmMg
fCA4ICsrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvbWVzaC9uZXQuYyBiL21lc2gvbmV0LmMNCj4gaW5kZXggOWE1NmQyZWU4Li5i
ZmI5YzQ0MzUgMTAwNjQ0DQo+IC0tLSBhL21lc2gvbmV0LmMNCj4gKysrIGIvbWVzaC9uZXQuYw0K
PiBAQCAtMjY5Niw2ICsyNjk2LDEwIEBAIHN0YXRpYyB2b2lkIHVwZGF0ZV9pdl9pdnVfc3RhdGUo
c3RydWN0IG1lc2hfbmV0ICpuZXQsIHVpbnQzMl90IGl2X2luZGV4LA0KPiAgCS8qIElmIGZpcnN0
IGJlYWNvbiBzZWVuLCBhY2NlcHQgd2l0aG91dCBqdWRnZW1lbnQgKi8NCj4gIAlpZiAobmV0LT5p
dl91cGRfc3RhdGUgPT0gSVZfVVBEX0lOSVQpIHsNCj4gIAkJaWYgKGl2dSkgew0KPiArCQkJLyog
SWdub3JlIGJlYWNvbnMgd2l0aCBJVlUgaWYgSVYgYWxyZWFkeSB1cGRhdGVkICovDQo+ICsJCQlp
ZiAoaXZfaW5kZXggPT0gbmV0LT5pdl9pbmRleCAmJiAhbmV0LT5pdl91cGRhdGUpDQo+ICsJCQkJ
cmV0dXJuOw0KPiArDQo+ICAJCQkvKiBPdGhlciBkZXZpY2VzIHdpbGwgYmUgYWNjZXB0aW5nIG9s
ZCBvciBuZXcgaXZfaW5kZXgsDQo+ICAJCQkgKiBidXQgd2UgZG9uJ3Qga25vdyBob3cgZmFyIHRo
cm91Z2ggdXBkYXRlIHRoZXkgYXJlLg0KPiAgCQkJICogU3RhcnRpbmcgcGVybWlzc2l2ZSBzdGF0
ZSB3aWxsIGFsbG93IHVzIG1heGltdW0NCj4gQEAgLTI3MTcsNiArMjcyMSwxMCBAQCBzdGF0aWMg
dm9pZCB1cGRhdGVfaXZfaXZ1X3N0YXRlKHN0cnVjdCBtZXNoX25ldCAqbmV0LCB1aW50MzJfdCBp
dl9pbmRleCwNCj4gIAkJCXJldHVybjsNCj4gIAkJfQ0KPiAgDQo+ICsJCS8qIElnbm9yZSBiZWFj
b25zIHdpdGggSVZVIGlmIElWIGFscmVhZHkgdXBkYXRlZCAqLw0KPiArCQlpZiAoaXZfaW5kZXgg
PT0gbmV0LT5pdl9pbmRleCkNCj4gKwkJCXJldHVybjsNCj4gKw0KPiAgCQlpZiAoIW5ldC0+aXZf
dXBkYXRlKSB7DQo+ICAJCQlsX2luZm8oIml2X3VwZF9zdGF0ZSA9IElWX1VQRF9VUERBVElORyIp
Ow0KPiAgCQkJbmV0LT5pdl91cGRfc3RhdGUgPSBJVl9VUERfVVBEQVRJTkc7DQo=
