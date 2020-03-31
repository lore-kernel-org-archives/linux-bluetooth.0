Return-Path: <SRS0=zBKN=5Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A77C43331
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 17:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACEA1212CC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 17:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="HdePqLAC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgCaRtb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Mar 2020 13:49:31 -0400
Received: from mga07.intel.com ([134.134.136.100]:4853 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgCaRta (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Mar 2020 13:49:30 -0400
IronPort-SDR: sap0WJAIrF39ZO5MQYM9NersxWnmd1BCI0JRoMDdbxn+gL4dGMDgyLYZqXzPs8bSrzU79TCPtU
 3Lz0CoNXUSKw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 10:49:28 -0700
IronPort-SDR: 3CQNNgxKeVWX69PvJUfZPMzTN2bmBcJ9PERlxD93IUjtRSaihuU+7OJExiV66ctpubFiRpVxvZ
 ekbI4+P9QaAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,328,1580803200"; 
   d="scan'208";a="284080570"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga002.fm.intel.com with ESMTP; 31 Mar 2020 10:49:27 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 31 Mar 2020 10:49:27 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 31 Mar 2020 10:49:26 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 31 Mar 2020 10:49:26 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 31 Mar 2020 10:49:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dh99zxYuwBN3Wq8YIrpDPtfBW3cUOK+BQ4uTn7N1E5V5AkhN85e+FCnZ6hiE21VIu3bgCwquGWAdrDIPUG7IL3WEO5r0YVr5YRGZozRgp7SNzPssNp8FvcbIyeNg2qqjWa/izCYd0jfCrzNSWE8RFoZ2nhdAsZGlloDwKYrYn57nhYntlnibrdKC8WsJFd9CTN0r9FiZfxXl7SVcBzPf0kYw3PcsqZp7ODu+TKJKZh6C8wQAtEuk3e+6Jv2vlsAFPJPMoo5m02nUKsONMH6yxFRAzhjjeqbULBRfV7IxUz8j+hFvoaJbX/ouZrG5a8oOXTaHIK+osDS3xdkQfTHPgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Om2lmHqihSx4yQJfQAlK9bJ9B1J3c2HcejLbAx0cNsg=;
 b=X0wsVWHJWBV0MPWZXAQzXWYPSr4p+hr29D8tXcXSTfAlCtmw2DD2h0MIDZHSARiGjmOS+1pllGqqx5z0bO9TPPoYCSY589lSECT4IJF3WEaIqlDpsfrq9KxAgAlDampq7WAfrAPG/m+K07SNw6u538Q1VsOqNTYd2F6bq5RQ80TUJmB1muB4sYlbu4EjXd94pa7zodKstIpc8Bs8kMXKzpbC4d+1xZrBkppH+VYMtPi+8+deVzSxhLunnf+lRKuTWUKx7JLwVWOpSORA+5/LxG51TZljt1xYNl8S0IC2ZytBQaVeNi2oes+QbFoVrxLsO4CKG6jjCGFZxm4XLNFD1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Om2lmHqihSx4yQJfQAlK9bJ9B1J3c2HcejLbAx0cNsg=;
 b=HdePqLACh9iphqUuq15e0DHShU/W99h6zwXgNJIRH2M7ZakrIwhGQgHUXRllaHWLEyptilS4IXui2v8vJqsGjKM5KVfcs5MNBQqsZzC2dPFyQuvNp3FO54vVJPEgb8VGW+iPvEQH4BpvRX+b9P/7sQe3CLq/prGSdhvDY7dXKZo=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4716.namprd11.prod.outlook.com (2603:10b6:303:53::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Tue, 31 Mar
 2020 17:49:13 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a%3]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 17:49:13 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "przemyslaw.fierek@silvair.com" <przemyslaw.fierek@silvair.com>
Subject: Re: [PATCH BlueZ v2 1/3] mesh: Remove unused argument from
 'mesh_net_transport_send' function
Thread-Topic: [PATCH BlueZ v2 1/3] mesh: Remove unused argument from
 'mesh_net_transport_send' function
Thread-Index: AQHWB1VK6GuiLIwxxkyGE6ZEJ58166hi+rQA
Date:   Tue, 31 Mar 2020 17:49:13 +0000
Message-ID: <faefdcbadda3f068165f5fbe765aae6135798316.camel@intel.com>
References: <20200331120908.23215-1-przemyslaw.fierek@silvair.com>
         <20200331120908.23215-2-przemyslaw.fierek@silvair.com>
In-Reply-To: <20200331120908.23215-2-przemyslaw.fierek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48aaf048-860f-4c3b-172b-08d7d59bd32c
x-ms-traffictypediagnostic: MW3PR11MB4716:
x-microsoft-antispam-prvs: <MW3PR11MB471613D144995581523A4955E1C80@MW3PR11MB4716.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0359162B6D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(136003)(396003)(346002)(376002)(366004)(39860400002)(186003)(86362001)(8936002)(81156014)(81166006)(5660300002)(66574012)(8676002)(6506007)(26005)(91956017)(6512007)(64756008)(66476007)(76116006)(71200400001)(2616005)(6486002)(478600001)(36756003)(2906002)(66446008)(110136005)(66946007)(66556008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eAu5/E0SU6Nf63Kq6drSKSSYbr/N2OssekFq7wiOgQSQBAAhzp1pcfg5/RwV5TP8S52ghjAU+SISmdYGUwjZ5QQM16bvVuEt28Jryz6HzeiFfuvxr/HhUAYSE9jpdiCPnK2OQF7FT9WdZ3UlmIVN77xOrr0lkvtoC9yR2AmzkKneBw3LJQjtHX+bt4PciQuXM1VCjD3VT/LDzDOusR0oyKsAVb9932u/OtfW1IggtSs+2QJoeW/TCfdNpa1hWOgibXFGrLV2MvUAacoQ1dginH4NxBIm7L4qb+xeu9CJOsTAe6HVc/oiG/QI87SdI6YoSdfy11lSJQjC7ZAcg4szichBccVU+l3cYJbCXrU7kCFVC0I6hDOVHsrM9p+kwTHjh0wFuS1E6PIncdbX2BVLnTOUUgcvXtZXfPXtTalNHmNMsiC9aBtPoVcTF0cMPPye
x-ms-exchange-antispam-messagedata: iOrTdcN4vQggAqcRaWOjXUtFeXgopKpznPJkfJ4XrU6GFMmO0RRYdAAAhY9As8qnP58h+8L1nr+KA0oxhumf/aeWICc/eIrXWnoGgLKmtO/jATn5u+xAN+IlV1wLWSkl3lGJkvTxjlNleIYd8YRxEg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B2F615F8E6EAC4384F152318ED9BDF5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 48aaf048-860f-4c3b-172b-08d7d59bd32c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2020 17:49:13.3672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C62PdDkCsJ0skzX66DRvdWYPsmv0Mrn58EYeOdL89syV6M4GdOo/G5FfR/fMwnxkXeBaSupGUW4k0CvufJO42g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4716
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgUHJ6ZW15c8WCYXcsDQoNCkkgYXBwbGllZCB0aGUgZmlyc3QgMiBvZiB0aGlzIHBhdGNoc2V0
LCBhbmQgbW9kaWZpZWQgYW5kIHNlbnQgb3V0IGEgdjMgb2YgdGhlIDNyZCAqbWFpbiogcGF0Y2gs
IGZvciB5b3VyDQphcHByb3ZhbC4NCg0KUGxlYXNlIG5vdGUgdGhhdCBJIGhhdmUgcmVtb3ZlZCB0
aGUgbmV0X2lkeCBhcmd1bWVudCBmcm9tIHNlbmRfc2VnKCksIHNpbmNlIHRoZSBmaWVsZCBpcyBh
IG1lbWJlciBvZiB0aGUNCm1lc2hfc2FyIHN0cnVjdHVyZSBiZWluZyBwYXNzZWQuDQoNCllvdSBh
cmUgc3RpbGwgbGlzdGVkIGFzIGF1dGhvciBvZiB0aGUgcGF0Y2guDQoNClBsZWFzZSByZXZpZXcg
YW5kIGNvbW1lbnQuDQoNCk9uIFR1ZSwgMjAyMC0wMy0zMSBhdCAxNDowOSArMDIwMCwgUHJ6ZW15
c8WCYXcgRmllcmVrIHdyb3RlOg0KPiAtLS0NCj4gIG1lc2gvZnJpZW5kLmMgfCAxNiArKysrKysr
Ky0tLS0tLS0tDQo+ICBtZXNoL25ldC5jICAgIHwgMTQgKysrKysrKy0tLS0tLS0NCj4gIG1lc2gv
bmV0LmggICAgfCAgMiArLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAx
NiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9tZXNoL2ZyaWVuZC5jIGIvbWVzaC9m
cmllbmQuYw0KPiBpbmRleCA1ZjVmNmY4MjMuLjZkMjZkZTE1YiAxMDA2NDQNCj4gLS0tIGEvbWVz
aC9mcmllbmQuYw0KPiArKysgYi9tZXNoL2ZyaWVuZC5jDQo+IEBAIC05Nyw3ICs5Nyw3IEBAIHN0
YXRpYyB2b2lkIHJlc3BvbnNlX2RlbGF5KHN0cnVjdCBsX3RpbWVvdXQgKnRpbWVvdXQsIHZvaWQg
KnVzZXJfZGF0YSkNCj4gIAluICs9IDI7DQo+ICAJc2VxID0gbWVzaF9uZXRfbmV4dF9zZXFfbnVt
KG5lZy0+bmV0KTsNCj4gIAlwcmludF9wYWNrZXQoIlR4LU5FVF9PUF9GUk5EX09GRkVSIiwgbXNn
LCBuKTsNCj4gLQltZXNoX25ldF90cmFuc3BvcnRfc2VuZChuZWctPm5ldCwga2V5X2lkLCB0cnVl
LA0KPiArCW1lc2hfbmV0X3RyYW5zcG9ydF9zZW5kKG5lZy0+bmV0LCBrZXlfaWQsDQo+ICAJCQlt
ZXNoX25ldF9nZXRfaXZfaW5kZXgobmVnLT5uZXQpLCAwLA0KPiAgCQkJc2VxLCAwLCBuZWctPmxw
X2FkZHIsDQo+ICAJCQltc2csIG4pOw0KPiBAQCAtMzE2LDcgKzMxNiw3IEBAIHZvaWQgZnJpZW5k
X2NsZWFyKHN0cnVjdCBtZXNoX25ldCAqbmV0LCB1aW50MTZfdCBzcmMsIHVpbnQxNl90IGxwbiwN
Cj4gIA0KPiAgCWxfcHV0X2JlMTYobHBuLCBtc2cgKyAxKTsNCj4gIAlsX3B1dF9iZTE2KGxwbkNv
dW50ZXIsIG1zZyArIDMpOw0KPiAtCW1lc2hfbmV0X3RyYW5zcG9ydF9zZW5kKG5ldCwgMCwgZmFs
c2UsDQo+ICsJbWVzaF9uZXRfdHJhbnNwb3J0X3NlbmQobmV0LCAwLA0KPiAgCQkJbWVzaF9uZXRf
Z2V0X2l2X2luZGV4KG5ldCksIERFRkFVTFRfVFRMLA0KPiAgCQkJMCwgMCwgc3JjLA0KPiAgCQkJ
bXNnLCBzaXplb2YobXNnKSk7DQo+IEBAIC0zMzIsNyArMzMyLDcgQEAgc3RhdGljIHZvaWQgY2xl
YXJfcmV0cnkoc3RydWN0IGxfdGltZW91dCAqdGltZW91dCwgdm9pZCAqdXNlcl9kYXRhKQ0KPiAg
DQo+ICAJbF9wdXRfYmUxNihuZWctPmxwX2FkZHIsIG1zZyArIDEpOw0KPiAgCWxfcHV0X2JlMTYo
bmVnLT5scF9jbnQsIG1zZyArIDMpOw0KPiAtCW1lc2hfbmV0X3RyYW5zcG9ydF9zZW5kKG5lZy0+
bmV0LCAwLCBmYWxzZSwNCj4gKwltZXNoX25ldF90cmFuc3BvcnRfc2VuZChuZWctPm5ldCwgMCwN
Cj4gIAkJCW1lc2hfbmV0X2dldF9pdl9pbmRleChuZWctPm5ldCksIERFRkFVTFRfVFRMLA0KPiAg
CQkJMCwgMCwgbmVnLT5vbGRfZnJpZW5kLA0KPiAgCQkJbXNnLCBzaXplb2YobXNnKSk7DQo+IEBA
IC0zOTgsNyArMzk4LDcgQEAgc3RhdGljIHZvaWQgZnJpZW5kX2RlbGF5X3JzcChzdHJ1Y3QgbF90
aW1lb3V0ICp0aW1lb3V0LCB2b2lkICp1c2VyX2RhdGEpDQo+ICAJCQkJCXBrdC0+dS5vbmVbMF0u
ZGF0YSwgcGt0LT5sYXN0X2xlbik7DQo+ICANCj4gIAkJCXBrdC0+dS5vbmVbMF0uc2VudCA9IHRy
dWU7DQo+IC0JCQltZXNoX25ldF90cmFuc3BvcnRfc2VuZChuZXQsIGZybmQtPm5ldF9rZXlfY3Vy
LCBmYWxzZSwNCj4gKwkJCW1lc2hfbmV0X3RyYW5zcG9ydF9zZW5kKG5ldCwgZnJuZC0+bmV0X2tl
eV9jdXIsDQo+ICAJCQkJCXBrdC0+aXZfaW5kZXgsIHBrdC0+dHRsLA0KPiAgCQkJCQlwa3QtPnUu
b25lWzBdLnNlcSwgcGt0LT5zcmMsIHBrdC0+ZHN0LA0KPiAgCQkJCQlwa3QtPnUub25lWzBdLmRh
dGEsIHBrdC0+bGFzdF9sZW4pOw0KPiBAQCAtNDM5LDcgKzQzOSw3IEBAIHVwZGF0ZToNCj4gIAls
X3B1dF9iZTMyKGl2X2luZGV4LCB1cGQgKyAyKTsNCj4gIAl1cGRbNl0gPSBmYWxzZTsgLyogUXVl
dWUgaXMgRW1wdHkgKi8NCj4gIAlwcmludF9wYWNrZXQoIlVwZGF0ZSIsIHVwZCwgc2l6ZW9mKHVw
ZCkpOw0KPiAtCW1lc2hfbmV0X3RyYW5zcG9ydF9zZW5kKG5ldCwgZnJuZC0+bmV0X2tleV9jdXIs
IGZhbHNlLA0KPiArCW1lc2hfbmV0X3RyYW5zcG9ydF9zZW5kKG5ldCwgZnJuZC0+bmV0X2tleV9j
dXIsDQo+ICAJCQltZXNoX25ldF9nZXRfaXZfaW5kZXgobmV0KSwgMCwNCj4gIAkJCW5ldF9zZXEs
IDAsIGZybmQtPmxwX2FkZHIsDQo+ICAJCQl1cGQsIHNpemVvZih1cGQpKTsNCj4gQEAgLTQ4Nyw3
ICs0ODcsNyBAQCB2b2lkIGZyaWVuZF9wb2xsKHN0cnVjdCBtZXNoX25ldCAqbmV0LCB1aW50MTZf
dCBzcmMsIGJvb2wgc2VxLA0KPiAgCQkJbmVnLT51Lm5lZ290aWF0ZS5jbGVhcmluZyA9IHRydWU7
DQo+ICAJCQlsX3B1dF9iZTE2KG5lZy0+bHBfYWRkciwgbXNnICsgMSk7DQo+ICAJCQlsX3B1dF9i
ZTE2KG5lZy0+bHBfY250LCBtc2cgKyAzKTsNCj4gLQkJCW1lc2hfbmV0X3RyYW5zcG9ydF9zZW5k
KG5ldCwgMCwgZmFsc2UsDQo+ICsJCQltZXNoX25ldF90cmFuc3BvcnRfc2VuZChuZXQsIDAsDQo+
ICAJCQkJCW1lc2hfbmV0X2dldF9pdl9pbmRleChuZXQpLCBERUZBVUxUX1RUTCwNCj4gIAkJCQkJ
MCwgMCwgbmVnLT5vbGRfZnJpZW5kLA0KPiAgCQkJCQltc2csIHNpemVvZihtc2cpKTsNCj4gQEAg
LTU5Niw3ICs1OTYsNyBAQCB2b2lkIGZyaWVuZF9zdWJfYWRkKHN0cnVjdCBtZXNoX25ldCAqbmV0
LCBzdHJ1Y3QgbWVzaF9mcmllbmQgKmZybmQsDQo+ICANCj4gIAlwcmludF9wYWNrZXQoIlR4LU5F
VF9PUF9QUk9YWV9TVUJfQ09ORklSTSIsIG1zZywgc2l6ZW9mKG1zZykpOw0KPiAgCW5ldF9zZXEg
PSBtZXNoX25ldF9nZXRfc2VxX251bShuZXQpOw0KPiAtCW1lc2hfbmV0X3RyYW5zcG9ydF9zZW5k
KG5ldCwgZnJuZC0+bmV0X2tleV9jdXIsIGZhbHNlLA0KPiArCW1lc2hfbmV0X3RyYW5zcG9ydF9z
ZW5kKG5ldCwgZnJuZC0+bmV0X2tleV9jdXIsDQo+ICAJCQltZXNoX25ldF9nZXRfaXZfaW5kZXgo
bmV0KSwgMCwNCj4gIAkJCW5ldF9zZXEsIDAsIGZybmQtPmxwX2FkZHIsDQo+ICAJCQltc2csIHNp
emVvZihtc2cpKTsNCj4gQEAgLTYzNCw3ICs2MzQsNyBAQCB2b2lkIGZyaWVuZF9zdWJfZGVsKHN0
cnVjdCBtZXNoX25ldCAqbmV0LCBzdHJ1Y3QgbWVzaF9mcmllbmQgKmZybmQsDQo+ICANCj4gIAlw
cmludF9wYWNrZXQoIlR4LU5FVF9PUF9QUk9YWV9TVUJfQ09ORklSTSIsIG1zZywgc2l6ZW9mKG1z
ZykpOw0KPiAgCW5ldF9zZXEgPSBtZXNoX25ldF9nZXRfc2VxX251bShuZXQpOw0KPiAtCW1lc2hf
bmV0X3RyYW5zcG9ydF9zZW5kKG5ldCwgZnJuZC0+bmV0X2tleV9jdXIsIGZhbHNlLA0KPiArCW1l
c2hfbmV0X3RyYW5zcG9ydF9zZW5kKG5ldCwgZnJuZC0+bmV0X2tleV9jdXIsDQo+ICAJCQltZXNo
X25ldF9nZXRfaXZfaW5kZXgobmV0KSwgMCwNCj4gIAkJCW5ldF9zZXEsIDAsIGZybmQtPmxwX2Fk
ZHIsDQo+ICAJCQltc2csIHNpemVvZihtc2cpKTsNCj4gZGlmZiAtLWdpdCBhL21lc2gvbmV0LmMg
Yi9tZXNoL25ldC5jDQo+IGluZGV4IDAzNDNjNGM0OS4uMTFhOWQ4NGEzIDEwMDY0NA0KPiAtLS0g
YS9tZXNoL25ldC5jDQo+ICsrKyBiL21lc2gvbmV0LmMNCj4gQEAgLTE1NjYsNyArMTU2Niw3IEBA
IHN0YXRpYyB2b2lkIHNlbmRfZnJuZF9hY2soc3RydWN0IG1lc2hfbmV0ICpuZXQsIHVpbnQxNl90
IHNyYywgdWludDE2X3QgZHN0LA0KPiAgCQlmcmllbmRfYWNrX3J4ZWQobmV0LCBtZXNoX25ldF9n
ZXRfaXZfaW5kZXgobmV0KSwNCj4gIAkJCQltZXNoX25ldF9uZXh0X3NlcV9udW0obmV0KSwgMCwg
ZHN0LCBtc2cpOw0KPiAgCX0gZWxzZSB7DQo+IC0JCW1lc2hfbmV0X3RyYW5zcG9ydF9zZW5kKG5l
dCwgMCwgZmFsc2UsDQo+ICsJCW1lc2hfbmV0X3RyYW5zcG9ydF9zZW5kKG5ldCwgMCwNCj4gIAkJ
CQltZXNoX25ldF9nZXRfaXZfaW5kZXgobmV0KSwgREVGQVVMVF9UVEwsDQo+ICAJCQkJMCwgMCwg
ZHN0LCBtc2csIHNpemVvZihtc2cpKTsNCj4gIAl9DQo+IEBAIC0xNjAxLDcgKzE2MDEsNyBAQCBz
dGF0aWMgdm9pZCBzZW5kX25ldF9hY2soc3RydWN0IG1lc2hfbmV0ICpuZXQsIHN0cnVjdCBtZXNo
X3NhciAqc2FyLA0KPiAgCQlyZXR1cm47DQo+ICAJfQ0KPiAgDQo+IC0JbWVzaF9uZXRfdHJhbnNw
b3J0X3NlbmQobmV0LCAwLCBmYWxzZSwNCj4gKwltZXNoX25ldF90cmFuc3BvcnRfc2VuZChuZXQs
IDAsDQo+ICAJCQkJbWVzaF9uZXRfZ2V0X2l2X2luZGV4KG5ldCksIERFRkFVTFRfVFRMLA0KPiAg
CQkJCTAsIHNyYywgZHN0LCBtc2csIHNpemVvZihtc2cpKTsNCj4gIH0NCj4gQEAgLTIyMDgsNyAr
MjIwOCw3IEBAIHN0YXRpYyBib29sIGN0bF9yZWNlaXZlZChzdHJ1Y3QgbWVzaF9uZXQgKm5ldCwg
dWludDE2X3Qga2V5X2lkLA0KPiAgCX0NCj4gIA0KPiAgCWlmIChuKSB7DQo+IC0JCW1lc2hfbmV0
X3RyYW5zcG9ydF9zZW5kKG5ldCwgMCwgZmFsc2UsDQo+ICsJCW1lc2hfbmV0X3RyYW5zcG9ydF9z
ZW5kKG5ldCwgMCwNCj4gIAkJCQltZXNoX25ldF9nZXRfaXZfaW5kZXgobmV0KSwgcnNwX3R0bCwN
Cj4gIAkJCQkwLCBkc3QgJiAweDgwMDAgPyAwIDogZHN0LCBzcmMsDQo+ICAJCQkJbXNnLCBuKTsN
Cj4gQEAgLTI5ODgsNyArMjk4OCw3IEBAIHZvaWQgbWVzaF9uZXRfc3ViX2xpc3RfYWRkKHN0cnVj
dCBtZXNoX25ldCAqbmV0LCB1aW50MTZfdCBhZGRyKQ0KPiAgCWxfcHV0X2JlMTYoYWRkciwgbXNn
ICsgbik7DQo+ICAJbiArPSAyOw0KPiAgDQo+IC0JbWVzaF9uZXRfdHJhbnNwb3J0X3NlbmQobmV0
LCAwLCBmYWxzZSwNCj4gKwltZXNoX25ldF90cmFuc3BvcnRfc2VuZChuZXQsIDAsDQo+ICAJCQlt
ZXNoX25ldF9nZXRfaXZfaW5kZXgobmV0KSwgMCwNCj4gIAkJCTAsIDAsIDAsIG1zZywgbik7DQo+
ICB9DQo+IEBAIC0zMDAxLDcgKzMwMDEsNyBAQCB2b2lkIG1lc2hfbmV0X3N1Yl9saXN0X2RlbChz
dHJ1Y3QgbWVzaF9uZXQgKm5ldCwgdWludDE2X3QgYWRkcikNCj4gIAlsX3B1dF9iZTE2KGFkZHIs
IG1zZyArIG4pOw0KPiAgCW4gKz0gMjsNCj4gIA0KPiAtCW1lc2hfbmV0X3RyYW5zcG9ydF9zZW5k
KG5ldCwgMCwgZmFsc2UsDQo+ICsJbWVzaF9uZXRfdHJhbnNwb3J0X3NlbmQobmV0LCAwLA0KPiAg
CQkJbWVzaF9uZXRfZ2V0X2l2X2luZGV4KG5ldCksIDAsDQo+ICAJCQkwLCAwLCAwLCBtc2csIG4p
Ow0KPiAgfQ0KPiBAQCAtMzM1MCw3ICszMzUwLDcgQEAgdm9pZCBtZXNoX25ldF9hY2tfc2VuZChz
dHJ1Y3QgbWVzaF9uZXQgKm5ldCwgdWludDMyX3Qga2V5X2lkLA0KPiAgDQo+ICAvKiBUT0RPOiBh
ZGQgbmV0IGtleSBpbmRleCAqLw0KPiAgdm9pZCBtZXNoX25ldF90cmFuc3BvcnRfc2VuZChzdHJ1
Y3QgbWVzaF9uZXQgKm5ldCwgdWludDMyX3Qga2V5X2lkLA0KPiAtCQkJCWJvb2wgZmFzdCwgdWlu
dDMyX3QgaXZfaW5kZXgsIHVpbnQ4X3QgdHRsLA0KPiArCQkJCXVpbnQzMl90IGl2X2luZGV4LCB1
aW50OF90IHR0bCwNCj4gIAkJCQl1aW50MzJfdCBzZXEsIHVpbnQxNl90IHNyYywgdWludDE2X3Qg
ZHN0LA0KPiAgCQkJCWNvbnN0IHVpbnQ4X3QgKm1zZywgdWludDE2X3QgbXNnX2xlbikNCj4gIHsN
Cj4gQEAgLTM1ODMsNyArMzU4Myw3IEBAIHZvaWQgbWVzaF9uZXRfaGVhcnRiZWF0X3NlbmQoc3Ry
dWN0IG1lc2hfbmV0ICpuZXQpDQo+ICAJbF9wdXRfYmUxNihoYi0+ZmVhdHVyZXMsIG1zZyArIG4p
Ow0KPiAgCW4gKz0gMjsNCj4gIA0KPiAtCW1lc2hfbmV0X3RyYW5zcG9ydF9zZW5kKG5ldCwgMCwg
ZmFsc2UsIG1lc2hfbmV0X2dldF9pdl9pbmRleChuZXQpLA0KPiArCW1lc2hfbmV0X3RyYW5zcG9y
dF9zZW5kKG5ldCwgMCwgbWVzaF9uZXRfZ2V0X2l2X2luZGV4KG5ldCksDQo+ICAJCQkJaGItPnB1
Yl90dGwsIDAsIDAsIGhiLT5wdWJfZHN0LCBtc2csIG4pOw0KPiAgfQ0KPiAgDQo+IGRpZmYgLS1n
aXQgYS9tZXNoL25ldC5oIGIvbWVzaC9uZXQuaA0KPiBpbmRleCBjYjkwYzFkOTIuLjU3NTg1Y2Vm
ZiAxMDA2NDQNCj4gLS0tIGEvbWVzaC9uZXQuaA0KPiArKysgYi9tZXNoL25ldC5oDQo+IEBAIC0z
MDUsNyArMzA1LDcgQEAgc3RydWN0IGxfcXVldWUgKm1lc2hfbmV0X2dldF9hcHBfa2V5cyhzdHJ1
Y3QgbWVzaF9uZXQgKm5ldCk7DQo+ICANCj4gIGJvb2wgbWVzaF9uZXRfZmx1c2goc3RydWN0IG1l
c2hfbmV0ICpuZXQpOw0KPiAgdm9pZCBtZXNoX25ldF90cmFuc3BvcnRfc2VuZChzdHJ1Y3QgbWVz
aF9uZXQgKm5ldCwgdWludDMyX3Qga2V5X2lkLA0KPiAtCQkJCWJvb2wgZmFzdCwgdWludDMyX3Qg
aXZfaW5kZXgsIHVpbnQ4X3QgdHRsLA0KPiArCQkJCXVpbnQzMl90IGl2X2luZGV4LCB1aW50OF90
IHR0bCwNCj4gIAkJCQl1aW50MzJfdCBzZXEsIHVpbnQxNl90IHNyYywgdWludDE2X3QgZHN0LA0K
PiAgCQkJCWNvbnN0IHVpbnQ4X3QgKm1zZywgdWludDE2X3QgbXNnX2xlbik7DQo+ICANCg==
