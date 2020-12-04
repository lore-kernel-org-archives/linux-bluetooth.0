Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02914C1B0D9
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Dec 2020 18:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C79DA22C9C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Dec 2020 18:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbgLDSNS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Dec 2020 13:13:18 -0500
Received: from mga12.intel.com ([192.55.52.136]:34099 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbgLDSNS (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Dec 2020 13:13:18 -0500
IronPort-SDR: lXfy5TA0VVBAtUsQA4U9C4+7aRZAzSaWz+/NN0ZsG668hpKHx4fmLZRTdIjHelrapmGFRd3At7
 mTzGihS1gXKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9825"; a="152669569"
X-IronPort-AV: E=Sophos;i="5.78,393,1599548400"; 
   d="scan'208";a="152669569"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 10:12:29 -0800
IronPort-SDR: lmxwgfKGkGZ2ozv/XRbZHRHRgrKJpHSpVZyIar3qz6lT5BX2vDp9MvykENQCH93e796j8IiXj8
 Z6P9U5K9IFiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,393,1599548400"; 
   d="scan'208";a="482480347"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 04 Dec 2020 10:12:28 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 4 Dec 2020 10:12:28 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 4 Dec 2020 10:12:28 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 4 Dec 2020 10:12:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k30Zu83Br+W/ElDYSMFO0AJNjWpMq+0KndubpEtZh09ECoHMAfvCM0i8bc3u0Z7JZH14LdLg8uz+xBD+3fgT61qVtTIJ6lmhbFJrPZsXdFthqf2nwNqQU5sqhgkaYiqQ7kO1p6OFCnM6UfENYU8pDoDMA72HRqFO5oO/3ZUPxjsZtp3jrYo5lzZId404UTzjrJ3mgnWvTsXC0S23WrDT3XYSMntFc1BwojdS8KPEHOCxEuiEyMoV/kCjl9TTO3Akod0adItQBpfM1PZK1eLAvWCz1IDklc+3vtkkJfZuaHybXI6TSbpXNTZNgwtr5n+yeVX5ImUZ5u+JsXSXrH2LoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1TN9uJikp4jLjlDM7Ou1SkAYBEE3EtaEs4p5q8A7wk=;
 b=Mm/s2SrxXY7In2FB+O5UQ1flBEvA6W8lQFeaG8H8+Qn7lY/4dM9PO4YZ/atooQUcnQT8P9nAq8oiMA6LhTTYvIX52JDz37tXgrmxU9TIvePlxddqr5Im8dXfNCv7rhg4/Z5QbMukU+2AL5aWDaG/HQThDsgSLhKWYVKBmTN8EXDSLUKuAvZ3I8cWgHVVZ37OpyLwZztsvD7hViP0/yNo9zdE00cUPO6utqiTkbjUPXCXnwPruVtRVloHruqzp+FWXgVXwrw4MwBpOq3/sh37P7nj3lJTpxmnrBoEVvv3jyNcB69KzQD9P2RFQzkRvOcr8pAAOJnUslhMDOGvVu3Tqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1TN9uJikp4jLjlDM7Ou1SkAYBEE3EtaEs4p5q8A7wk=;
 b=mIj2ktU60ri5LjMhZn3TqGhom0qRvgNeKvoi/7ya7jzxfAyUoixrEHbCzyNKxsL9maivdyPPAqwqUlJEUNCtEj/JOcnDXYiVwj0ES7IihPBDTGn8j4gLWYWh1ayRVtDBkn5ZzRv2SZPeDjQdnr7aayJvsYOqgdBS+I97MF9CM7E=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR11MB1583.namprd11.prod.outlook.com (2603:10b6:301:b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Fri, 4 Dec
 2020 18:12:07 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::80b8:462a:6fde:926]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::80b8:462a:6fde:926%6]) with mapi id 15.20.3632.021; Fri, 4 Dec 2020
 18:12:07 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "sbrown@ewol.com" <sbrown@ewol.com>
Subject: Re: [PATCH BlueZ v2] mesh: Fix check for mkdir return value in
 keyring.c
Thread-Topic: [PATCH BlueZ v2] mesh: Fix check for mkdir return value in
 keyring.c
Thread-Index: AQHWxhgSl7TQ92RSOk+fADsa7XD4lKnnRcIA
Date:   Fri, 4 Dec 2020 18:12:07 +0000
Message-ID: <809803bcf078ad9ba9fd196a805515a9b7539fab.camel@intel.com>
References: <20201129062202.91034-1-inga.stotland@intel.com>
In-Reply-To: <20201129062202.91034-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a78bcbf-a3f8-4ca6-aade-08d898801c9c
x-ms-traffictypediagnostic: MWHPR11MB1583:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1583531F3FCD9E52BEA9C3EFE1F10@MWHPR11MB1583.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:785;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fbvk4HvNJHU80L6p0ZVAfZVwwQuQ6ShvnQBt1Z0pfp1z/20any7d1HF0LIIQlQBOmbCSqk381RGXHsOpJHk05W6uedp2x/Q5S4FN301l12ZgroWPKVgNr4NG9dyWaetQXSCxJjRt2cInnK56YxTBv8xVhBg4I0ojl86fzbGK8s6DF4hnZe+PgcT6Oyl+OP+XF6g6rJJPXixsxNl1rV/rpNfGKSRTOguECrEezzyJrwqYy/q0RnU72lHAVlt4CLJZUzSQKZTnyTPm5i3BK6KEJIxZOpakyMnL4Nu9IK2IoBYwSZEPzlj7C3Ob+l4EwLeWvuYcN3Q953YiXqYz+crHGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(2906002)(8936002)(5660300002)(478600001)(2616005)(8676002)(91956017)(6506007)(86362001)(4001150100001)(26005)(186003)(76116006)(83380400001)(6512007)(110136005)(316002)(4326008)(6486002)(64756008)(66446008)(66476007)(66556008)(36756003)(71200400001)(66946007)(6636002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: dLF5oGE1QmMzkFcnUFL/6WmdU/equjGopMIBtPzRBVLMdcEr60SFjL+X/31slGLw6zjCQcnW0pm0MsVfGIos2MhSGEYkwVJHJutKvXGxsOuPP1JVszK7F1J22wCOe+/vAlp6HHQ/93SrpHIHwYCkysEXP8AcYMO0+bg9hM86a5ikI9jdzjgm2/YMigVdyoPlbKoFI6ewwbwVW3gNezw9GYnTcseHxhmWeoDMaoI/SpDGGf5d/k72Ad0Gdq47fZjTv2lKPnopq1ESBiuHXmgLEW9E2+71anvJ+T0W2YuYDWHgNI957SozESRnov1pe24R1Fk8Kb2MMaPClP5HoscT2+Xk5/lyIFIC1YJgquAMrMzfPTMhNgil4ElsmSJYQVzAiwf9WWShjxS9bD31wS6rCoBGhf/ksc3tCqL7iHIMfNa6twYTB9HA4F+63AZMbENovKPjKQQWWTmU4GQ0Mrr3z7SB8wFRWR5uTaCWgcElV1UdxMemExN5izJvtNEg3S46Vb9M/c1VSs54nwQFgHfnO1TNFUB+Dm+vFnS71v2yRqwxYIVRKLJ6pT90DTji25hp4minQswrZ4fgbeoxtI5eF5/SUrs8p9G2tFHe3pv12GEP3/hTLi0HBZB8g9cEbKp73dkKhFqkQFpO3lWJCoeAJXGzCzmWi+7nTZxG5QXsrqz+4Se4lbTun17bns7hjDSi9LJxN0KuqdIX/2iG0Jgq2/i9jUYnPxWpD2WivvDTH4krTkgNmJzV1N/2viIxDuMD
Content-Type: text/plain; charset="utf-8"
Content-ID: <8CA31689E123F74C819E9910E72FD286@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a78bcbf-a3f8-4ca6-aade-08d898801c9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2020 18:12:07.4607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gnyJX4js7dz4lu69fqLCWmQNekx3jTP9rMxax+6XNfokh34ZXwJ20SN3UvWIsS1Z3oU6/NdhJ6cRb+Dm1YGVig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1583
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gU2F0LCAyMDIwLTExLTI4IGF0IDIyOjIyIC0wODAwLCBJbmdhIFN0b3RsYW5k
IHdyb3RlOg0KPiBSZW1vdmUgY2hlY2sgZm9yIG1rZGlyKCkgcmV0dXJuIHZhbHVlLCBzaW5jZSBj
aGVja2luZyBmb3IgemVybyBkb2VzIG5vdA0KPiBjb3ZlciAiYWxyZWFkeSBleGlzdHMiIGNvbmRp
dGlvbiBhbmQgYWRkaW5nIGV4dHJhIGNoZWNrIGZvciBlcnJubyB2YWx1ZQ0KPiB1bm5lY2Vzc2Fy
aWx5IGNvbXBsaWNhdGVzIHRoZSBjb2RlLiBJZiBta2RpcigpIGZhaWxzIGR1ZSB0byBhbnkgcmVh
c29uDQo+IHRoYW4gImFscmVhZHkgZXhpc3RzIiwgdGhlIHN1YnNlcXVlbnQgY2FsbCB0byBvcGVu
KCkgZmFpbHMgYW5kIHRoZQ0KPiBlcnJvciBpcyBkZXRlY3RlZCBhbmQgY29yZWN0bHkgcHJvY2Vz
c2VkIGJ5IHRoZSBjb2RlLg0KPiAtLS0NCj4gIG1lc2gva2V5cmluZy5jIHwgOSArKystLS0tLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvbWVzaC9rZXlyaW5nLmMgYi9tZXNoL2tleXJpbmcuYw0KPiBpbmRleCAx
ZWY0ZmMzZWYuLjBiNzRlZTkxNCAxMDA2NDQNCj4gLS0tIGEvbWVzaC9rZXlyaW5nLmMNCj4gKysr
IGIvbWVzaC9rZXlyaW5nLmMNCj4gQEAgLTUxLDggKzUxLDcgQEAgYm9vbCBrZXlyaW5nX3B1dF9u
ZXRfa2V5KHN0cnVjdCBtZXNoX25vZGUgKm5vZGUsIHVpbnQxNl90IG5ldF9pZHgsDQo+ICANCj4g
IAlzbnByaW50ZihrZXlfZmlsZSwgUEFUSF9NQVgsICIlcyVzIiwgbm9kZV9wYXRoLCBuZXRfa2V5
X2Rpcik7DQo+ICANCj4gLQlpZiAoIW1rZGlyKGtleV9maWxlLCAwNzU1KSkNCj4gLQkJcmV0dXJu
IGZhbHNlOw0KPiArCW1rZGlyKGtleV9maWxlLCAwNzU1KTsNCj4gIA0KPiAgCXNucHJpbnRmKGtl
eV9maWxlLCBQQVRIX01BWCwgIiVzJXMvJTMuM3giLCBub2RlX3BhdGgsIG5ldF9rZXlfZGlyLA0K
PiAgCQkJCQkJCQluZXRfaWR4KTsNCj4gQEAgLTg4LDggKzg3LDcgQEAgYm9vbCBrZXlyaW5nX3B1
dF9hcHBfa2V5KHN0cnVjdCBtZXNoX25vZGUgKm5vZGUsIHVpbnQxNl90IGFwcF9pZHgsDQo+ICAN
Cj4gIAlzbnByaW50ZihrZXlfZmlsZSwgUEFUSF9NQVgsICIlcyVzIiwgbm9kZV9wYXRoLCBhcHBf
a2V5X2Rpcik7DQo+ICANCj4gLQlpZiAoIW1rZGlyKGtleV9maWxlLCAwNzU1KSkNCj4gLQkJcmV0
dXJuIGZhbHNlOw0KPiArCW1rZGlyKGtleV9maWxlLCAwNzU1KTsNCj4gIA0KPiAgCXNucHJpbnRm
KGtleV9maWxlLCBQQVRIX01BWCwgIiVzJXMvJTMuM3giLCBub2RlX3BhdGgsIGFwcF9rZXlfZGly
LA0KPiAgCQkJCQkJCQlhcHBfaWR4KTsNCj4gQEAgLTIwNyw4ICsyMDUsNyBAQCBib29sIGtleXJp
bmdfcHV0X3JlbW90ZV9kZXZfa2V5KHN0cnVjdCBtZXNoX25vZGUgKm5vZGUsIHVpbnQxNl90IHVu
aWNhc3QsDQo+ICANCj4gIAlzbnByaW50ZihrZXlfZmlsZSwgUEFUSF9NQVgsICIlcyVzIiwgbm9k
ZV9wYXRoLCBkZXZfa2V5X2Rpcik7DQo+ICANCj4gLQlpZiAoIW1rZGlyKGtleV9maWxlLCAwNzU1
KSkNCj4gLQkJcmV0dXJuIGZhbHNlOw0KPiArCW1rZGlyKGtleV9maWxlLCAwNzU1KTsNCj4gIA0K
PiAgCWZvciAoaSA9IDA7IGkgPCBjb3VudDsgaSsrKSB7DQo+ICAJCXNucHJpbnRmKGtleV9maWxl
LCBQQVRIX01BWCwgIiVzJXMvJTQuNHgiLCBub2RlX3BhdGgsDQo=
