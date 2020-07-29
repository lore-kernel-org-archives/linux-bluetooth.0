Return-Path: <SRS0=Z40G=BI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BACFC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jul 2020 19:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33F062075D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jul 2020 19:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="G+4Czq6C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgG2TAp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Jul 2020 15:00:45 -0400
Received: from mga05.intel.com ([192.55.52.43]:4796 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgG2TAp (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Jul 2020 15:00:45 -0400
IronPort-SDR: AH3RaXai0HZKSAApKq96ihB48Gy8dlEmpzxg0Te1RCihrGHza+YjqkAYWlLzzxjvTLSOuWOgfL
 Adlo64wAaimg==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="236346927"
X-IronPort-AV: E=Sophos;i="5.75,411,1589266800"; 
   d="scan'208";a="236346927"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 12:00:44 -0700
IronPort-SDR: 0p4Gtb4BrK2T3iWCmzgsTLcmUTDia0HvAxE91b00OY7mhB6gfyCF0TO1UKZm5awUTIlaUqt+EK
 PLGU6swjs0cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,411,1589266800"; 
   d="scan'208";a="364936883"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga001.jf.intel.com with ESMTP; 29 Jul 2020 12:00:44 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 29 Jul 2020 12:00:44 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 29 Jul 2020 12:00:44 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.54) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 29 Jul 2020 12:00:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g72IoD1ye225Ne1QUXZb4j6Fi56k2i/pyl/oQR7uccRdpE4/wRJZO7PhPWBmXsAz1Uo5i9WGrtBcXOup6gb3XcoE9bb8WFhlysJqb3jcU0e0sIf4bZEtm8PGSmXE8ctI8QbhlcvzeyGXmtV5Fbdj77jdV7KM+qP6X0JQFqhIvzBWX3uFCqAjTpFlVGx1nBDcXSU5mS2B0WsdN+1iiNku9ANFJOoyLOXAFjV/iUYxizKLsyaiF00X2yyEbdeYTDBRldpN8YHcl509s1eaK4qr7jkTrsq3mMsOoe2nbiEnPJqAnbxwEnKuVI7EmlXmyUg3975uQhkuKCSSyZKzpc04AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zkf8KVjbJkwXRkX51n1K74y/9B7gRqxO3OFw7gsHYu8=;
 b=IEDLPfMYkylplSvKHBF0ft66GiJUG08slSpuKRYw6tgjPH41JVxILp4BgZj+m69g3vy2Q8fbzWbk4XSaFWV9s9gdGXq6KBvQyFo5vdDpNrqCzDJHeh2nKzPW/OX20Cw4qZvikc2OXACYHZDU+kRLbC37wBG518Z3Igks5nMaBjD76yVcR38VxaHQPcsMI7/Ypsb+Z6vnbFVYX33VCzCbLleQxi5t736sP+RI7YR5VmjwB745Xl3Dye/nSD3MRrVTRJ44a2q9JAcrwwfxCNW1lquPPmEpl8Lavx/D9Zx1p55Ogm6Ecf6VZ+VF6PZGFs67IpKIx383c9vMRMabd72/7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zkf8KVjbJkwXRkX51n1K74y/9B7gRqxO3OFw7gsHYu8=;
 b=G+4Czq6CUIBg/E/9OWs1kUsZP23kY8EIP3fAwvHrET/+g7xvWwywrJ8xNuTM1CDzYKlA+Gty0q6MxEkWQrVxFqbT6+spf2h6QQY2ztLelV4TgwT64I8d9ChYIdyMcGppDsWLIKSz5OKEB57rL+Y2Cs3+roj14b/XHnRXWo+Nvvg=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR11MB1792.namprd11.prod.outlook.com (2603:10b6:300:10b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Wed, 29 Jul
 2020 19:00:37 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225%6]) with mapi id 15.20.3239.017; Wed, 29 Jul 2020
 19:00:37 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "mike@mnmoran.org" <mike@mnmoran.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Add guard against wedging outbound queue
Thread-Topic: [PATCH BlueZ] mesh: Add guard against wedging outbound queue
Thread-Index: AQHWZcBQu+oUh0kTcUuSK+nyNK6OMKke6ZaA
Date:   Wed, 29 Jul 2020 19:00:37 +0000
Message-ID: <c5550c4c6d3009e6f0c76c709baf82c9522dfa11.camel@intel.com>
References: <20200729155234.547679-1-brian.gix@intel.com>
In-Reply-To: <20200729155234.547679-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.139.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0eb9780-2534-47a3-9f14-08d833f1ae5a
x-ms-traffictypediagnostic: MWHPR11MB1792:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1792BE300936EB8ED1A215BFE1700@MWHPR11MB1792.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fkb9zefRTChxduZ0p0nYDI3TLlaKxjclf776CsOdyDqigY2RHSBLQN53RirxCGB7MAkKnPkm5A8qnT8a6rhrvICYBnTt/efKOXa8d2xC49035lrnnm0VlUYGzgaQAvMtasZXqFJlqvhytom6jgTfmHFdJkih1uQlLBOuXa7zGGM9SYg6jpDElAHrsfFWEmfm5JXzOEdn8Ak41VC6Yhl0Y9WKgsO7RAFjQtG6gJry5MC5CsjOTwY5dJehEMcnwViI7g2OImoaGA2RSwGd3j5jE5eV4b2hJ82WhDvt20ew1YUBNIg95PCnYq8g8riU+mgufGe7njxd1ZRmNmbfqUKpZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(6916009)(107886003)(26005)(71200400001)(6486002)(478600001)(186003)(36756003)(5660300002)(4326008)(2616005)(64756008)(76116006)(316002)(2906002)(6506007)(6512007)(66476007)(66556008)(86362001)(66946007)(66446008)(54906003)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: /SdYcro9P776J9/8PAHIEBlS8+WSqEKno7d+pWhEHkbff/uWERsFE6IPaqNPUM/n4/Fteyl/fpR4X5DolJdJwn4TTIJAQcq3UNHc7t0ehcVc/XukG7BhEOwvUU7wqOgiwobctblwzcz/zIMZKabJJGJTRxYm5XeZMF26Wj7DUIjbNT7ulUqiAaxKbvGyfTUxGCl27KDthIw+9M2Rw8iSuT5JlSLmf6n/xcUjQXVJc6ACTlV9kDqPjm6GYfEv+P0GE2tA8PJbTxSgYBYQTIed8YHLs7yYyX7K7Bre4VYOU03fA7rzytAZY5VF6QLnOiBi4EjD4O1UsJi8LcZpUJiS292I3PrRL2FyenoD7Jyo0BFpyGLbDB3+no6nqbMetKPw8qercx2ut18q4VU6Pl/dEDIhjI6a1L1yKJq0+lc+q47vVwtU0ch8AlNSCs9BDkgPPL6zBbDV1JYIsUhQNfSjhA9WeaO2E71sh8px7Wt6q1X/zxcIMVOthEssHTTU6fRq
Content-Type: text/plain; charset="utf-8"
Content-ID: <90FD69813994594D84792F88B2C205DE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0eb9780-2534-47a3-9f14-08d833f1ae5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2020 19:00:37.6183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dPGcMxCSqjufStQ1Gbethu131l5UA1hQUYDSYb0bWnmeaSp2+s62Z6/rP2N+cTwvY14gu1N5yK3SNjfUuFihAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1792
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gV2VkLCAyMDIwLTA3LTI5IGF0IDA4OjUyIC0wNzAwLCBCcmlhbiBHaXggd3Jv
dGU6DQo+IFdoZW4gdXNpbmcgSENJIGNvbW1hbmQgY2hhaW5zLCB0aGUgZmlyc3QgcGFja2V0IHNl
bmQgdGhhdCBzdGFydHMgYW4NCj4gb3V0Ym91bmQgc2VxdWVuY2UgbmVlZHMgdG8gc3RpbGwgZXhp
c3Qgd2hlbiBjb21tYW5kIGNoYWluIGNvbXBsZXRlcywgb3INCj4gdGhlIG91dGJvdW5kIHF1ZXVl
IHdpbGwgd2VkZ2UuICBUaGUgc2ltcGxlc3Qgc29sdXRpb24gaXMgdG8gc2VuZCBwYWNrZXRzDQo+
IGF0IGxlYXN0IHR3aWNlIG9uIGFuIGVtcHR5IHF1ZXVlLCBpZiB0aGVyZSBpcyBhIGNoYW5jZSBp
dCBjb3VsZCBiZSBjYW5jZWxlZC4NCj4gLS0tDQo+ICBtZXNoL21lc2gtaW8tZ2VuZXJpYy5jIHwg
OCArKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL21lc2gvbWVzaC1pby1nZW5lcmljLmMgYi9tZXNoL21lc2gtaW8tZ2VuZXJpYy5j
DQo+IGluZGV4IDg2OTUyNTE2ZS4uNGIyNmIxMTgxIDEwMDY0NA0KPiAtLS0gYS9tZXNoL21lc2gt
aW8tZ2VuZXJpYy5jDQo+ICsrKyBiL21lc2gvbWVzaC1pby1nZW5lcmljLmMNCj4gQEAgLTcxNCw2
ICs3MTQsMTQgQEAgc3RhdGljIGJvb2wgc2VuZF90eChzdHJ1Y3QgbWVzaF9pbyAqaW8sIHN0cnVj
dCBtZXNoX2lvX3NlbmRfaW5mbyAqaW5mbywNCj4gIAkJCXNlbmRpbmcgPSAhbF9xdWV1ZV9pc2Vt
cHR5KHB2dC0+dHhfcGt0cyk7DQo+ICANCj4gIAkJbF9xdWV1ZV9wdXNoX3RhaWwocHZ0LT50eF9w
a3RzLCB0eCk7DQo+ICsNCj4gKwkJLyoNCj4gKwkJICogSWYgdHJhbnNtaXR0ZXIgaXMgaWRsZSwg
c2VuZCBwYWNrZXRzIGF0IGxlYXN0IHR3aWNlIHRvDQo+ICsJCSAqIGd1YXJkIGFnYWluc3QgaW4t
bGluZSBjYW5jZWxhdGlvbiBvZiBIQ0kgY29tbWFuZCBjaGFpbi4NCj4gKwkJICovDQo+ICsJCWlm
IChpbmZvLT50eXBlID09IE1FU0hfSU9fVElNSU5HX1RZUEVfR0VORVJBTCAmJiAhc2VuZGluZyAm
Jg0KPiArCQkJCQkJCXR4LT5pbmZvLnUuZ2VuLmNudCA9PSAxKQ0KPiArCQkJdHgtPmluZm8udS5n
ZW4uY250Kys7DQo+ICAJfQ0KPiAgDQo+ICAJaWYgKCFzZW5kaW5nKSB7DQo=
