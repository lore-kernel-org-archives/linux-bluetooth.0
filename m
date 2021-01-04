Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3CEC433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Jan 2021 17:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EC9D224DE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Jan 2021 17:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbhADRAY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Jan 2021 12:00:24 -0500
Received: from mga14.intel.com ([192.55.52.115]:39645 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727792AbhADRAX (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Jan 2021 12:00:23 -0500
IronPort-SDR: UZKoTj/VgPgxadd5ZtTbFtq8WOb1PFksOFoEzouCE+HKfatct0u1fV/kndvqTtWDHS9kYk+kvO
 EZ1sNAu/pCqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="176197656"
X-IronPort-AV: E=Sophos;i="5.78,474,1599548400"; 
   d="scan'208";a="176197656"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 08:59:42 -0800
IronPort-SDR: xyPeIh83Oe5uiwKa59uv+lEb7WnQU0+8lRLPJ0CXP5Er7qSc0lMKOKIQ5YHi2/E4E/OpO2Gijo
 G5cbGPYZdTHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,474,1599548400"; 
   d="scan'208";a="378491424"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 04 Jan 2021 08:59:41 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 4 Jan 2021 08:59:41 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 4 Jan 2021 08:59:41 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 4 Jan 2021 08:59:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvLxVOk/qNmfQBehJT5rYo/PN1w/cg7AmnSia6MXjiOvuYf4FTv3yMwVP30ZxjWoykF8iafpfbYA1DT/jMhZg3wNoBhhXeMQvKNbldzIKZ0DaRPKpPYGF1IVF49bg4B9lYIw/9ILaaqQWz8uV6KTWFy09Vn3u5d3fIwoPN0C3h6ZSIxVqDGfxkSoGdE+4xMND1ioKTTT33KIj5xDl868Vv+0zlFTlz7u4OJY1gX4giTzhOddmm1HiMejyweA2WkxBOdaavS5SCLu1UaNrBnYY2CVSe6YkCp2mZbJs31+EfOqR6qtilKKvIwo/EOYM5iw5ndtR/+lsuUA6nvZSt4+MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPPg0Ickx10g1zlE9ldM1PyP1yr+fe5F6jcOUwfTPls=;
 b=VvmjsFRJiWGTElTUheydAneO6jPgywIy065V8+ZDv908Ci7D6n0MRXlD0tAE5zC6Yt3Yj8jMIe9xI82zebBkSHoUs++GNcS2ADmqWCftOKTD3lhv+JTOkhVeXOktTqQj4hPklSVNgNaFre9uYJkqfAEsX5JoOXLzfmI6j7A4WJcslkcMjpGASm2heky8cnbcHNh2/WG+1JwDdsO3XAsyO7hD3uTYkijmYzvRrMKdoiWBwyVHdH26w4f+DTimcpEDCTyEPxYAA5Ba0VZgyJ9D18Iwqwpa5c0h1jIDffOFke4HtFeyi6oVtX6jpzZqaqahq3hNlU8fUg+mFHjGvPcFeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPPg0Ickx10g1zlE9ldM1PyP1yr+fe5F6jcOUwfTPls=;
 b=XFdWuS5MxbaglFxsGUlJ52rWY/17U7jG36MTE48E4sxHwV/Ls91Np4HR1P61YDR6vTDMKQgN0b2OusSIYAORQd5c5Z0Y5gJ6Xhc0dNiDirjj0I4dcIzzjTN0/OQliFj4BZ7ypbRTr58GzVEnhCnKjEWLnmoSrP46K/Z8tMnMy+0=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4618.namprd11.prod.outlook.com (2603:10b6:303:5f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Mon, 4 Jan
 2021 16:59:39 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::30c6:ea80:eabe:2aab]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::30c6:ea80:eabe:2aab%9]) with mapi id 15.20.3721.024; Mon, 4 Jan 2021
 16:59:38 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "mike@mnmoran.org" <mike@mnmoran.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v2] mesh: Update AppKeys on transition to Phase 0
Thread-Topic: [PATCH BlueZ v2] mesh: Update AppKeys on transition to Phase 0
Thread-Index: AQHW4kyHStOPZjJYT0yUymFeFGaCvKoXsV8A
Date:   Mon, 4 Jan 2021 16:59:38 +0000
Message-ID: <cb442a385e8e53f6878edce724b0d6012837f20a.camel@intel.com>
References: <20210104034837.640081-1-mike@mnmoran.org>
In-Reply-To: <20210104034837.640081-1-mike@mnmoran.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: mnmoran.org; dkim=none (message not signed)
 header.d=none;mnmoran.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1022b0c2-b22a-491b-f62f-08d8b0d21f6e
x-ms-traffictypediagnostic: MW3PR11MB4618:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB461859EF5B2A4A785890928EE1D20@MW3PR11MB4618.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a4l95pjMmiNdlpjPMVmUV/6woHSnn+Z1yHL3Ai970IWtfm/9dBXLNXHn+W+hjk6oTeEj/gO4euq0tAy+vl27IfuFAEMfcIZgveruwvOZRL7CgvVKRX+ILDf9oduSZUXWz8XT/l8SdoyluoWstmZoUm4lKWHQdJ8bQ8uzbKnvkJklftj7nuctLtUmYCiGPC2QYyfnn09gsflcHh6iH0fWCfPqNPasw3YzxAMkqvYlU3XQJIOxmSN/joaNsb97SF5K5nEuisksSu+uQNoZ7BhQ0TOS98WeMOiAqZIi3CxZCTUWq0dIo9ubtb4/ZkxMrnS1U9PI8XJBiQwFCk3adjoJGiu3Oc+LpSs4TTILIWLBYbzukQzzQxSaNRO+XSAiUK0QAOi8Fg7xAIp3WH5PVt14OQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(6512007)(66446008)(64756008)(36756003)(2616005)(66556008)(8936002)(66946007)(15650500001)(83380400001)(107886003)(6506007)(8676002)(4326008)(26005)(186003)(2906002)(71200400001)(478600001)(76116006)(91956017)(316002)(110136005)(6486002)(5660300002)(66476007)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cGZad3V5Q3RISmlqNkJ4cFNvMzUvNzY0V1BnTVBxdXQzYUt0NVdUUmJ1YzRL?=
 =?utf-8?B?RTYyWkxWQ2pKOUZQMDdPM0g1ODcrOHNQcjA0TFI4UWxKWGp3UDNHREh4eUhn?=
 =?utf-8?B?WmJ0UWJycHFPbmYrN0hrUUR5bjVJMU9jY2E4UXhPdzh3bGcvSDkrWUtPK0s3?=
 =?utf-8?B?T1EwNytPd2xyN0piUDRuOUFqbnV3c0NuVmZ3Qlo4WFZjMlBJYW5Vcmd6bE9r?=
 =?utf-8?B?RU94Z3Vaci9mQW9jL3pMMy9UNjk5ajBuZDFjSGFlVVVZMGt4dzVFcmdnTlFr?=
 =?utf-8?B?U050RnNSU3RxMURlejRUOU9IK2NPQVozcWNyNVBSUG9sTE1RUmZFV0xjZWxj?=
 =?utf-8?B?b0RKRkJqemJRbEljMFFDOWlQRVFadkM0cXdNcmlVSU1NWDhXUWJ3ZE9IbzBI?=
 =?utf-8?B?aXE5cUU0RGFmQUZZSm9UaEgzNGNzNVhpWTdIbnNpOXRTZFZUcW0yVzNvQ0ln?=
 =?utf-8?B?MmJseUlVVFJiR0Y1Z3ZxUjhOMlFXWEdIT2luSXpmcHhaZ0YvbTZxNXNvSmhw?=
 =?utf-8?B?OGxqVWpLY2F3QUQ2MVZmdTRJOUNhQkNUN1RxbGVHSHIrYnJqTE1HU0F2aDZv?=
 =?utf-8?B?aDVWNDBKcUl5bzlTbTJPVkdyTlVPbVBWRytQTU15Y3JiTEExSFI1ZUsrK0pt?=
 =?utf-8?B?Zld3eGZPQmFGYmZRSkxuVmZ5NkZ2RytYWllRcnd5YlZ2NWhKT1RFRnhBYTVW?=
 =?utf-8?B?TzRuemNiNmpJOUhHS01QNHdXOFBsR1kyM1ZrSnRNc3dXcE93cWkrb0tHcEQy?=
 =?utf-8?B?d2FPUDY4VzgydEw4eDBCeFo1Vm1HckUyMzJLTmVSbGowcHdMTWNyQ3Fwd2do?=
 =?utf-8?B?MnlCQytRRmxYS2ZTdmNBUzZJTTZoM2pGWTNvNXVCeXZXM3hjTXVoNzdRU2li?=
 =?utf-8?B?Tk5YNHlWSHJQdXFBZFp1SXhHL1BFZk1FV3NjTExKYlR1S3lwNm5UbWsza1Fx?=
 =?utf-8?B?dk1GZ3hUUXBxTE9QWitGZHhldXo0NFhoTi9hZVRlSWFRdlp4RS8veHdKVmwx?=
 =?utf-8?B?M3V5VU1TWFpIU2N5STJWR0gyR0xaajltc0l6NEZQcFJFZU52U1M3SFRpaU1w?=
 =?utf-8?B?Sys1dUZwYzVtd1hHK0YwMkI4KzcrT0RoNGtMNzYzV01vVGdyUmZ4VWN6bmhG?=
 =?utf-8?B?cGkzdGJyS2FxMXJTYWFzeE1HTjFaai9tb1MxVWMxQ0tPMC8wNDNUNnRoTUV6?=
 =?utf-8?B?dGt3c3ViMG5PUVBuVVoxMzJudFkwZ1FyVzBnU0s3NVI3RTBMRXhnd29vWk8v?=
 =?utf-8?B?VmlzcEtpZXlxSXdGa3lQSDlqYXBiRVRBc3VpaUFrbnpLSnFmWGdhQWRKcXRI?=
 =?utf-8?Q?55CmNXpKaRv7carkR6npRIE5bM9q48rlmN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <29EB8FA6C06C864B92B7C44C2194AA14@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1022b0c2-b22a-491b-f62f-08d8b0d21f6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2021 16:59:38.9154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1xPevMj3cfvjybM8jvRR6AAnx0Zhz0FujX5Fp7NmF0KBSNtHgo0QTgsEKbZxoB0iJfQiLXU25ZlEvatr4i1XPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4618
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCwgVGhhbmtzDQoNCk9uIFN1biwgMjAyMS0wMS0wMyBhdCAyMjo0OCAtMDUwMCwgTWlj
aGFlbCBOLiBNb3JhbiB3cm90ZToNCj4gQXQgdGhlIGVuZCBvZiB0aGUgbWVzaCBLZXkgUmVmcmVz
aCBwcm9jZWR1cmUgd2hlbiBhIHN1Ym5ldA0KPiB0cmFuc2l0aW9ucyB0byBQaGFzZSAwLCBsb2Nh
bCBBcHBLZXlzIHRoYXQgd2VyZSB1cGRhdGVkIHdlcmUNCj4gbm90IHVwZGF0aW5nIHVudGlsIHRo
ZSBibHVldG9vdGgtbWVzaGQgZGFlbW9uIHdhcyByZXN0YXJ0ZWQuDQo+IA0KPiBUaGlzIHBhdGNo
IGl0ZXJhdGVzIHRoZSBBcHBLZXlzIGF0IHRoZSBlbmQgb2YgbWVzaCBLZXkgUmVmcmVzaA0KPiB3
aGVuIHRoZSBzdWJuZXQgdHJhbnNpdGlvbnMgdG8gUGhhc2UgMCwgc2V0dGluZyB0aGUgbmV3IHN0
YXRlDQo+IG9mIGVhY2ggdXBkYXRlZCBBcHBLZXkuDQo+IA0KPiAqKioqKioqKiogdjIgKioqKioq
KioqKioqDQo+IA0KPiBUaGlzIHZlcnNpb24gaW5jb3Jwb3JhdGVzIHJlY29tbWVuZGF0aW9ucyBm
cm9tIEJyaWFuIEdpeA0KPiBjcmVhdGluZyBhIHB1YmxpYyBmdW5jdGlvbiBhcHBrZXlfZmluYWxp
emUoKTsgYW5kIGFkZGluZw0KPiBuZXcgQVBQX0FJRF9JTlZBTElEIGNvbnN0YW50IHRvIHJlcGxh
Y2UgdGhlIHVzZSBvZiAweEZGDQo+IGFzIGFuIGluZGljYXRpb24gdGhhdCB0aGUgbmV3X2tleV9h
aWQgZmllbGQgaXMgaW52YWxpZC4NCj4gDQo+IA0KPiAtLS0NCj4gIG1lc2gvYXBwa2V5LmMgICAg
fCAzMyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4gIG1lc2gvYXBwa2V5Lmgg
ICAgfCAgMSArDQo+ICBtZXNoL21lc2gtZGVmcy5oIHwgIDEgKw0KPiAgbWVzaC9uZXQuYyAgICAg
ICB8ICAyICsrDQo+ICA0IGZpbGVzIGNoYW5nZWQsIDM1IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9hcHBrZXkuYyBiL21lc2gvYXBwa2V5LmMN
Cj4gaW5kZXggNTQ5ZjVhODBkLi41MDg4YTE4MTIgMTAwNjQ0DQo+IC0tLSBhL21lc2gvYXBwa2V5
LmMNCj4gKysrIGIvbWVzaC9hcHBrZXkuYw0KPiBAQCAtNTAsMTEgKzUwLDQwIEBAIHN0YXRpYyBi
b29sIG1hdGNoX2JvdW5kX2tleShjb25zdCB2b2lkICphLCBjb25zdCB2b2lkICpiKQ0KPiAgCXJl
dHVybiBrZXktPm5ldF9pZHggPT0gaWR4Ow0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgdm9pZCBmaW5h
bGl6ZV9rZXkodm9pZCAqYSwgdm9pZCAqYikNCj4gK3sNCj4gKwlzdHJ1Y3QgbWVzaF9hcHBfa2V5
ICprZXkgPSBhOw0KPiArCXVpbnQxNl90IG5ldF9pZHggPSBMX1BUUl9UT19VSU5UKGIpOw0KPiAr
DQo+ICsJaWYgKGtleS0+bmV0X2lkeCAhPSBuZXRfaWR4KQ0KPiArCQlyZXR1cm47DQo+ICsNCj4g
KwlpZiAoa2V5LT5uZXdfa2V5X2FpZCA9PSBBUFBfQUlEX0lOVkFMSUQpDQo+ICsJCXJldHVybjsN
Cj4gKw0KPiArCWtleS0+a2V5X2FpZCA9IGtleS0+bmV3X2tleV9haWQ7DQo+ICsNCj4gKwlrZXkt
Pm5ld19rZXlfYWlkID0gQVBQX0FJRF9JTlZBTElEOw0KPiArDQo+ICsJbWVtY3B5KGtleS0+a2V5
LCBrZXktPm5ld19rZXksIDE2KTsNCj4gK30NCj4gKw0KPiArdm9pZCBhcHBrZXlfZmluYWxpemUo
c3RydWN0IG1lc2hfbmV0ICpuZXQsIHVpbnQxNl90IG5ldF9pZHgpDQo+ICt7DQo+ICsJc3RydWN0
IGxfcXVldWUgKmFwcF9rZXlzOw0KPiArDQo+ICsJYXBwX2tleXMgPSBtZXNoX25ldF9nZXRfYXBw
X2tleXMobmV0KTsNCj4gKwlpZiAoIWFwcF9rZXlzKQ0KPiArCQlyZXR1cm47DQo+ICsNCj4gKwls
X3F1ZXVlX2ZvcmVhY2goYXBwX2tleXMsIGZpbmFsaXplX2tleSwgTF9VSU5UX1RPX1BUUihuZXRf
aWR4KSk7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBzdHJ1Y3QgbWVzaF9hcHBfa2V5ICphcHBfa2V5
X25ldyh2b2lkKQ0KPiAgew0KPiAgCXN0cnVjdCBtZXNoX2FwcF9rZXkgKmtleSA9IGxfbmV3KHN0
cnVjdCBtZXNoX2FwcF9rZXksIDEpOw0KPiAgDQo+IC0Ja2V5LT5uZXdfa2V5X2FpZCA9IDB4RkY7
DQo+ICsJa2V5LT5uZXdfa2V5X2FpZCA9IEFQUF9BSURfSU5WQUxJRDsNCj4gIAlyZXR1cm4ga2V5
Ow0KPiAgfQ0KPiAgDQo+IEBAIC0xNDYsNyArMTc1LDcgQEAgY29uc3QgdWludDhfdCAqYXBwa2V5
X2dldF9rZXkoc3RydWN0IG1lc2hfbmV0ICpuZXQsIHVpbnQxNl90IGFwcF9pZHgsDQo+ICAJCXJl
dHVybiBhcHBfa2V5LT5rZXk7DQo+ICAJfQ0KPiAgDQo+IC0JaWYgKGFwcF9rZXktPm5ld19rZXlf
YWlkID09IE5FVF9OSURfSU5WQUxJRCkNCj4gKwlpZiAoYXBwX2tleS0+bmV3X2tleV9haWQgPT0g
QVBQX0FJRF9JTlZBTElEKQ0KPiAgCQlyZXR1cm4gTlVMTDsNCj4gIA0KPiAgCSprZXlfYWlkID0g
YXBwX2tleS0+bmV3X2tleV9haWQ7DQo+IGRpZmYgLS1naXQgYS9tZXNoL2FwcGtleS5oIGIvbWVz
aC9hcHBrZXkuaA0KPiBpbmRleCAzYmI3MDQ0NWIuLjY2ODhkODdmYiAxMDA2NDQNCj4gLS0tIGEv
bWVzaC9hcHBrZXkuaA0KPiArKysgYi9tZXNoL2FwcGtleS5oDQo+IEBAIC0xNiw2ICsxNiw3IEBA
IHN0cnVjdCBtZXNoX2FwcF9rZXk7DQo+ICBib29sIGFwcGtleV9rZXlfaW5pdChzdHJ1Y3QgbWVz
aF9uZXQgKm5ldCwgdWludDE2X3QgbmV0X2lkeCwgdWludDE2X3QgYXBwX2lkeCwNCj4gIAkJCQl1
aW50OF90ICprZXlfdmFsdWUsIHVpbnQ4X3QgKm5ld19rZXlfdmFsdWUpOw0KPiAgdm9pZCBhcHBr
ZXlfa2V5X2ZyZWUodm9pZCAqZGF0YSk7DQo+ICt2b2lkIGFwcGtleV9maW5hbGl6ZShzdHJ1Y3Qg
bWVzaF9uZXQgKm5ldCwgdWludDE2X3QgbmV0X2lkeCk7DQo+ICBjb25zdCB1aW50OF90ICphcHBr
ZXlfZ2V0X2tleShzdHJ1Y3QgbWVzaF9uZXQgKm5ldCwgdWludDE2X3QgYXBwX2lkeCwNCj4gIAkJ
CQkJCQl1aW50OF90ICprZXlfaWQpOw0KPiAgaW50IGFwcGtleV9nZXRfa2V5X2lkeChzdHJ1Y3Qg
bWVzaF9hcHBfa2V5ICphcHBfa2V5LA0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9tZXNoLWRlZnMuaCBi
L21lc2gvbWVzaC1kZWZzLmgNCj4gaW5kZXggNDNiZGY1YWFiLi4yNWNlMDEyNmMgMTAwNjQ0DQo+
IC0tLSBhL21lc2gvbWVzaC1kZWZzLmgNCj4gKysrIGIvbWVzaC9tZXNoLWRlZnMuaA0KPiBAQCAt
MTAwLDYgKzEwMCw3IEBADQo+ICANCj4gICNkZWZpbmUgTkVUX0lEWF9NQVgJCTB4MGZmZg0KPiAg
I2RlZmluZSBBUFBfSURYX01BWAkJMHgwZmZmDQo+ICsjZGVmaW5lIEFQUF9BSURfSU5WQUxJRAkw
eGZmDQo+ICANCj4gICNkZWZpbmUgQVBQX0lEWF9NQVNLCQkweDBmZmYNCj4gICNkZWZpbmUgQVBQ
X0lEWF9ERVZfUkVNT1RFCTB4NmZmZg0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9uZXQuYyBiL21lc2gv
bmV0LmMNCj4gaW5kZXggYjI0Y2RiYTc3Li45NjI0Y2QwNTggMTAwNjQ0DQo+IC0tLSBhL21lc2gv
bmV0LmMNCj4gKysrIGIvbWVzaC9uZXQuYw0KPiBAQCAtMjYwMCw2ICsyNjAwLDggQEAgc3RhdGlj
IGludCBrZXlfcmVmcmVzaF9maW5pc2goc3RydWN0IG1lc2hfbmV0ICpuZXQsIHVpbnQxNl90IGlk
eCkNCj4gIA0KPiAgCWxfcXVldWVfZm9yZWFjaChuZXQtPmZyaWVuZHMsIGZybmRfa3JfcGhhc2Uz
LCBuZXQpOw0KPiAgDQo+ICsJYXBwa2V5X2ZpbmFsaXplKG5ldCwgaWR4KTsNCj4gKw0KPiAgCWlm
ICghbWVzaF9jb25maWdfbmV0X2tleV9zZXRfcGhhc2Uobm9kZV9jb25maWdfZ2V0KG5ldC0+bm9k
ZSksIGlkeCwNCj4gIAkJCQkJCQlLRVlfUkVGUkVTSF9QSEFTRV9OT05FKSkNCj4gIAkJcmV0dXJu
IE1FU0hfU1RBVFVTX1NUT1JBR0VfRkFJTDsNCg==
