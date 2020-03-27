Return-Path: <SRS0=n6SA=5M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33D9C43331
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 21:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937AE2072F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 21:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="hO//0YAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbgC0VRT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Mar 2020 17:17:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:49677 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727444AbgC0VRT (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Mar 2020 17:17:19 -0400
IronPort-SDR: VHFrzCfyX+8oDT9kc2Djz1d+sryJzQpZTz641+XKPsL1dkee+6A8En+BA2DLgEannvVK0La1z1
 oi0F1Oo8RzFA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 14:17:16 -0700
IronPort-SDR: YWwa4NTV1YvRqZAoE/PAV+TjdYvYDJlCjPkEyYcK/7ibxJnQx0jo1FVoFTggEXEds4onprlpEP
 kVIjfFBnrTxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,313,1580803200"; 
   d="scan'208";a="282971544"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga002.fm.intel.com with ESMTP; 27 Mar 2020 14:17:16 -0700
Received: from orsmsx161.amr.corp.intel.com (10.22.240.84) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 27 Mar 2020 14:17:15 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX161.amr.corp.intel.com (10.22.240.84) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 27 Mar 2020 14:17:15 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 27 Mar 2020 14:17:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBTNd/wOmuWyL7tIBKArSeQIKyTtMy5CZlW2ctbJW3OrSy9AFLEU5DT3GaBXAfLoTFBncIY5Xt4ZbJXtq9zEJkTIbL63R0f9az9GfvilZt0Vvq6ILzTPv6FNyKF7GMGTMr3uKRdsLBV5RtHDC8zK/chd4dBwANYF85SIj/qmfWzY6Mm1NZcC/0F6Xn6UlZ67ByS2ov3zinujjflEJkQBSyzDBX9JjBGIaAaojRRzIX67lC9PW+7LhFvaMnzUh0LrjFK2T47Uz1C54wxF3mrLmewi+Y+2ch6FMN8ZE/n0ApbHRCdoBqOaABzMHN+gdR1DfX+ix0scsuPFtXBGkEHDjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7f1eGDxpOFKdsHltVez/rBRw9eBlt7dfnIjVjugwYM=;
 b=neXbCVi4v/WBlZ3QWufowcN7sF9hzJYh71zp4MtUAv8ctAM7WfkIK2oaNApU58rBQ0zSyO3Se1QfKPVrOaw3edUPafyStwjsfIjXChEiQsteizsnZUagxJOQe33UlSUOuDG4tisJl3fn19pkiE/B+1UmJ7dtNkAXwkQbM0BM987Xdwc30WkuyKD5YGocUzeq/FFJpGwRPBhCJhvYmKgLiKJku0hekZuTc7sDkxXNkvcOXi3V9+F4wUkuMiS0uSxF0l029W2DkgmN8ImfBA6ea0hDkydwqc7pD2gUOalUiRgQxjy5e3TrrySBUUyTIOi+vb9ijp7DwgHwQM2pVpoi3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7f1eGDxpOFKdsHltVez/rBRw9eBlt7dfnIjVjugwYM=;
 b=hO//0YAZhKiC8TjjhL4Y+ev90i7nMQjYmGM+vDAHHEhLj0ZJU0+rbbSxrSWJzKRxcTnEwbnhJ8VgS3JgymxTFehUPi1gKKOCl7ZNcduLdBgNZzRW7OvJHulfBhmOJy4V0evoYI8gyJT9wqyzhQ38kSfE7ifq59ohmqLczqvesE8=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4619.namprd11.prod.outlook.com (2603:10b6:303:5b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18; Fri, 27 Mar
 2020 21:17:13 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a%3]) with mapi id 15.20.2856.019; Fri, 27 Mar 2020
 21:17:13 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ 2/4] mesh: Update UnprovisionedScan, AddNode &
 ScanResult
Thread-Topic: [PATCH BlueZ 2/4] mesh: Update UnprovisionedScan, AddNode &
 ScanResult
Thread-Index: AQHWBGeUdvWTj442hUCUAvCM9xEdy6hc8VoA
Date:   Fri, 27 Mar 2020 21:17:13 +0000
Message-ID: <23a1089f89c125779b4b3a73607d8ad8d38e1aef.camel@intel.com>
References: <20200327184257.15042-1-inga.stotland@intel.com>
         <20200327184257.15042-3-inga.stotland@intel.com>
In-Reply-To: <20200327184257.15042-3-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [134.134.139.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 048dfed4-5169-4218-7d0d-08d7d2943812
x-ms-traffictypediagnostic: MW3PR11MB4619:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB46195D1BA1AC10CC2A46FA18E1CC0@MW3PR11MB4619.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0355F3A3AE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(39860400002)(396003)(366004)(71200400001)(26005)(66946007)(110136005)(66446008)(5660300002)(186003)(2616005)(76116006)(66476007)(86362001)(66556008)(316002)(64756008)(6512007)(6506007)(8676002)(8936002)(6486002)(81166006)(36756003)(2906002)(6636002)(478600001)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:MW3PR11MB4619;H:MW3PR11MB4539.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iFTH5lv98jlJfaZHJLTymsjom3HW33wlbLgsJlw+JvKZ6LKF0HBojFCBj2b244LYIqj5CFglb9qs5+NBsOn7I5IX21ohzJqaV6OMGl93uVyjBdyOiJ0qS9iQM9b8pYQ2JbqLkPBIH/vRmldQYjB5xsD5DjjRkRVMX0AwFlBs6nMzYnNIzFjrzPl3mKP/26RGzx/QShfkOkru7ytlUWj3GGroaCwA6cQK7sJ6tnMyygHz5ZDazdeXN+tSOttgAVcNpHXbowmpPPJ++CQUHaInHg3Rx9uPQG939Gcg1Ns6ZtT2Sq0RYFKjJjjgnBPLno2/82IcPc7CA9nmPzy6GEeQ+HMjA/ysz92PG2G0UGiLsFJZzq2Schm5n/6XTMGfKShOYAVKYf7AUDu+RF25yXFPzeeSN+S0jAVlzECQ09l+3Dctn8/5A3IcW9QMhHaSkp9M
x-ms-exchange-antispam-messagedata: XcyTj35DRllV/LfPjj8HOPjRxOw/e4eASeWULIuRlSxm+peIjg6Lr1+3tZExuQTzndyA4bxgBnullr4jqCK/3cvPE5iLlSSqEOx61DjjQu14xguygg06nxz4leBKYI8sLTiZq0YCQPN4zr/ibnk2Ww==
Content-Type: text/plain; charset="utf-8"
Content-ID: <8CA3DEEC1AFCAF41AA37622808E3F8C9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 048dfed4-5169-4218-7d0d-08d7d2943812
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2020 21:17:13.1384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3YUxuUfUuaQhN9wedAldEnGYYspHoxTItETlrzsE47bUv5fK2j3FekYDAB0Cd1LWBkIR2DUuW6/CJTJMXwnfnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4619
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgSW5nYSwNCk9uIEZyaSwgMjAyMC0wMy0yNyBhdCAxMTo0MiAtMDcwMCwgSW5nYSBTdG90bGFu
ZCB3cm90ZToNCj4gVGhlIGZvbGxvd2luZyBtZXRob2RzIGFyZSBtb2RpZmllZCB0byBhbGxvdyBm
b3IgZnV0dXJlIGRldmVsb3BtZW50Og0KPiANCj4gSW50ZXJmYWNlIG9yZy5ibHVlei5tZXNoLk1h
bmFnZW1lbnQxOg0KPiANCj4gT2xkOiB2b2lkIFVucHJvdmlzaW9uZWRTY2FuKHVpbnQxNiBzZWNv
bmRzKQ0KPiBOZXc6IHZvaWQgVW5wcm92aXNpb25lZFNjYW4oZGljdCBvcHRpb25zKQ0KPiANCj4g
ICAgIFRoZSBvcHRpb25zIHBhcmFtZXRlciBpcyBhIGRpY3Rpb25hcnkgd2l0aCB0aGUgZm9sbG93
aW5nIGtleXMgZGVmaW5lZDoNCj4gICAgIHVpbnQxNiBTZWNvbmRzDQo+ICAgICAgICAgICAgICAg
ICBTcGVjaWZpZXMgbnVtYmVyIG9mIHNlY29uZHMgZm9yIHNjYW5uaW5nIHRvIGJlIGFjdGl2ZS4N
Cj4gICAgICAgICAgICAgICAgIElmIHNldCB0byAwIG9yIGlmIHRoaXMga2V5IGlzIG5vdCBwcmVz
ZW50LCB0aGVuIHRoZQ0KPiAgICAgICAgICAgICAgICAgc2Nhbm5pbmcgd2lsbCBjb250aW51ZSB1
bnRpbCBVbnByb3Zpc2lvbmVkU2NhbkNhbmNlbCgpDQo+ICAgICAgICAgICAgICAgICBvciBBZGRO
b2RlKCkgbWV0aG9kcyBhcmUgY2FsbGVkLg0KPiAgICAgb3RoZXIga2V5cyBUQkQNCj4gDQo+IE9s
ZDogdm9pZCBBZGROb2RlKGFycmF5e2J5dGV9WzE2XSB1dWlkKQ0KPiBOZXc6IHZvaWQgQWRkTm9k
ZShhcnJheXtieXRlfVsxNl0gdXVpZCwgZGljdCBvcHRpb25zKQ0KPiANCj4gICAgIFRoZSBvcHRp
b25zIHBhcmFtZXRlciBpcyBjdXJyZW50bHkgYW4gZW1wdHkgZGljdGlvbmFyeQ0KPiANCj4gSW50
ZXJmYWNlIG9yZy5ibHVlei5tZXNoLlByb3Zpc2lvbmVyMQ0KPiANCj4gT2xkOiB2b2lkIFNjYW5S
ZXN1bHQoaW50MTYgcnNzaSwgYXJyYXl7Ynl0ZX0gZGF0YSkNCj4gTmV3OiB2b2lkIFNjYW5SZXN1
bHQoaW50MTYgcnNzaSwgYXJyYXl7Ynl0ZX0gZGF0YSwgZGljdCBvcHRpb25zKQ0KPiANCj4gICAg
IFRoZSBvcHRpb25zIHBhcmFtZXRlciBpcyBjdXJyZW50bHkgYW4gZW1wdHkgZGljdGlvbmFyeQ0K
PiAtLS0NCj4gIG1lc2gvbWFuYWdlci5jIHwgMzkgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKSwgOSBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9tZXNoL21hbmFnZXIuYyBiL21lc2gvbWFuYWdl
ci5jDQo+IGluZGV4IDA5MDljN2UxNi4uOGU5NDhlNDdkIDEwMDY0NA0KPiAtLS0gYS9tZXNoL21h
bmFnZXIuYw0KPiArKysgYi9tZXNoL21hbmFnZXIuYw0KPiBAQCAtMjE3LDIxICsyMTcsMjIgQEAg
c3RhdGljIHN0cnVjdCBsX2RidXNfbWVzc2FnZSAqYWRkX25vZGVfY2FsbChzdHJ1Y3QgbF9kYnVz
ICpkYnVzLA0KPiAgCQkJCQkJdm9pZCAqdXNlcl9kYXRhKQ0KPiAgew0KPiAgCXN0cnVjdCBtZXNo
X25vZGUgKm5vZGUgPSB1c2VyX2RhdGE7DQo+IC0Jc3RydWN0IGxfZGJ1c19tZXNzYWdlX2l0ZXIg
aXRlcl91dWlkOw0KPiArCXN0cnVjdCBsX2RidXNfbWVzc2FnZV9pdGVyIGl0ZXJfdXVpZCwgb3B0
aW9uczsNCj4gIAlzdHJ1Y3QgbF9kYnVzX21lc3NhZ2UgKnJlcGx5Ow0KPiAgCXVpbnQ4X3QgKnV1
aWQ7DQo+IC0JdWludDMyX3QgbjsNCj4gKwl1aW50MzJfdCBuID0gMjI7DQo+ICANCj4gIAlsX2Rl
YnVnKCJBZGROb2RlIHJlcXVlc3QiKTsNCj4gIA0KPiAtCWlmICghbF9kYnVzX21lc3NhZ2VfZ2V0
X2FyZ3VtZW50cyhtc2csICJheSIsICZpdGVyX3V1aWQpKQ0KPiArCWlmICghbF9kYnVzX21lc3Nh
Z2VfZ2V0X2FyZ3VtZW50cyhtc2csICJheWF7c3Z9IiwgJml0ZXJfdXVpZCwgJm9wdGlvbnMpKQ0K
PiAgCQlyZXR1cm4gZGJ1c19lcnJvcihtc2csIE1FU0hfRVJST1JfSU5WQUxJRF9BUkdTLCBOVUxM
KTsNCj4gIA0KPiAgCWlmICghbF9kYnVzX21lc3NhZ2VfaXRlcl9nZXRfZml4ZWRfYXJyYXkoJml0
ZXJfdXVpZCwgJnV1aWQsICZuKQ0KPiAtCQkJCQkJCQl8fCBuICE9IDE2KQ0KPiArCSAgICB8fCBu
ICE9IDE2KSB7DQo+ICsJCWxfZGVidWcoIm4gPSAldSIsIG4pOw0KPiAgCQlyZXR1cm4gZGJ1c19l
cnJvcihtc2csIE1FU0hfRVJST1JfSU5WQUxJRF9BUkdTLA0KPiAgCQkJCQkJCSJCYWQgZGV2aWNl
IFVVSUQiKTsNCj4gLQ0KPiArCX0NCj4gIAkvKiBBbGxvdyBBZGROb2RlIHRvIGNhbmNlbCBTY2Fu
bmluZyBpZiBmcm9tIHRoZSBzYW1lIG5vZGUgKi8NCj4gIAlpZiAoc2Nhbl9ub2RlKSB7DQo+ICAJ
CWlmIChzY2FuX25vZGUgIT0gbm9kZSkNCj4gQEAgLTM2MSw2ICszNjIsOSBAQCBzdGF0aWMgdm9p
ZCBwcm92X2JlYWNvbl9yZWN2KHZvaWQgKnVzZXJfZGF0YSwgc3RydWN0IG1lc2hfaW9fcmVjdl9p
bmZvICppbmZvLA0KPiAgCWJ1aWxkZXIgPSBsX2RidXNfbWVzc2FnZV9idWlsZGVyX25ldyhtc2cp
Ow0KPiAgCWxfZGJ1c19tZXNzYWdlX2J1aWxkZXJfYXBwZW5kX2Jhc2ljKGJ1aWxkZXIsICduJywg
JnJzc2kpOw0KPiAgCWRidXNfYXBwZW5kX2J5dGVfYXJyYXkoYnVpbGRlciwgZGF0YSArIDIsIGxl
biAtMik7DQo+ICsJbF9kYnVzX21lc3NhZ2VfYnVpbGRlcl9lbnRlcl9hcnJheShidWlsZGVyLCAi
e3N2fSIpOw0KPiArCS8qIFRPRE86IHBvcHVsYXRlIHdpdGggb3B0aW9ucyB3aGVuIGRlZmluZWQg
Ki8NCj4gKwlsX2RidXNfbWVzc2FnZV9idWlsZGVyX2xlYXZlX2FycmF5KGJ1aWxkZXIpOw0KPiAg
CWxfZGJ1c19tZXNzYWdlX2J1aWxkZXJfZmluYWxpemUoYnVpbGRlcik7DQo+ICAJbF9kYnVzX21l
c3NhZ2VfYnVpbGRlcl9kZXN0cm95KGJ1aWxkZXIpOw0KPiAgDQo+IEBAIC0zNzIsMTcgKzM3Niwz
NCBAQCBzdGF0aWMgc3RydWN0IGxfZGJ1c19tZXNzYWdlICpzdGFydF9zY2FuX2NhbGwoc3RydWN0
IGxfZGJ1cyAqZGJ1cywNCj4gIAkJCQkJCXZvaWQgKnVzZXJfZGF0YSkNCj4gIHsNCj4gIAlzdHJ1
Y3QgbWVzaF9ub2RlICpub2RlID0gdXNlcl9kYXRhOw0KPiAtCXVpbnQxNl90IGR1cmF0aW9uOw0K
PiArCXVpbnQxNl90IGR1cmF0aW9uID0gMDsNCj4gIAlzdHJ1Y3QgbWVzaF9pbyAqaW87DQo+ICAJ
c3RydWN0IG1lc2hfbmV0ICpuZXQ7DQo+ICsJY29uc3QgY2hhciAqa2V5Ow0KPiArCXN0cnVjdCBs
X2RidXNfbWVzc2FnZV9pdGVyIG9wdGlvbnMsIHZhcjsNCj4gIAljb25zdCBjaGFyICpzZW5kZXIg
PSBsX2RidXNfbWVzc2FnZV9nZXRfc2VuZGVyKG1zZyk7DQo+ICANCj4gIAlpZiAoc3RyY21wKHNl
bmRlciwgbm9kZV9nZXRfb3duZXIobm9kZSkpKQ0KPiAgCQlyZXR1cm4gZGJ1c19lcnJvcihtc2cs
IE1FU0hfRVJST1JfTk9UX0FVVEhPUklaRUQsIE5VTEwpOw0KPiAgDQo+IC0JaWYgKCFsX2RidXNf
bWVzc2FnZV9nZXRfYXJndW1lbnRzKG1zZywgInEiLCAmZHVyYXRpb24pKQ0KPiArCWlmICghbF9k
YnVzX21lc3NhZ2VfZ2V0X2FyZ3VtZW50cyhtc2csICJhe3N2fSIsICZvcHRpb25zKSkNCj4gIAkJ
cmV0dXJuIGRidXNfZXJyb3IobXNnLCBNRVNIX0VSUk9SX0lOVkFMSURfQVJHUywgTlVMTCk7DQo+
ICANCj4gKwl3aGlsZSAobF9kYnVzX21lc3NhZ2VfaXRlcl9uZXh0X2VudHJ5KCZvcHRpb25zLCAm
a2V5LCAmdmFyKSkgew0KPiArCQlib29sIGZhaWxlZCA9IHRydWU7DQo+ICsNCj4gKwkJaWYgKCFz
dHJjbXAoa2V5LCAiU2Vjb25kcyIpKSB7DQo+ICsJCQlpZiAobF9kYnVzX21lc3NhZ2VfaXRlcl9n
ZXRfdmFyaWFudCgmdmFyLCAicSIsDQo+ICsJCQkJCQkJICAgICZkdXJhdGlvbikpIHsNCj4gKwkJ
CQlmYWlsZWQgPSBmYWxzZTsNCj4gKwkJCX0NCj4gKwkJfQ0KDQpJIHRoaW5rIGZhaWxpbmcgaW4g
dGhpcyBpbiB0aGlzIHdheSBpcyBub3QgdHJ1ZWx5ICJGb3J3YXJkIENvbXBhdGlibGUiLiBJZiBh
IGtleSB0aGF0IGlzICpub3QqIFNlY29uZHMgaXMgZm91bmQNCmluIHRoZSBkaWN0aW9uYXJ5LCB0
aGlzIHdpbGwgYWx3YXlzIHJldHVybiBhbiBlcnJvci4gIEkgdGhpbmsgaXQgd291bGQgYmUgYmV0
dGVyIGlmIHRoZSBrZXkgaXMgaWdub3JlZC4NCg0KVGhlIG9ubHkgImZhaWwiIGNhc2Ugc2hvdWxk
IGJlIGlmIGEga2V5IGhhcyBhIGtub3duIHZhbGlkLCBidXQgaGFzIGFuIGluY29ycmVjdCB0eXBl
IChub3QgInEiIGluIHRoZSBjYXNlIG9mDQpTZWNvbmRzKSwgb3IgaWYgdGhlIGtleSBpcyBzdXBw
b3J0ZWQsIGJ1dCB0aGUgdmFsdWUgaXMgb3V0c2lkZSB0aGUgYWNjZXB0YWJsZSByYW5nZSAoaXMg
dGhlcmUgYW4gYWNjZXB0YWJsZQ0KcmFuZ2UgZm9yIHRoaXMpPw0KDQpXZSBhZ3JlZWQsIEkgdGhp
bmssIHRoYXQgdGhlICpub24qIGV4aXN0YW5jZSBvZiBTZWNvbmRzIG1lYW5zICJVbmxpbWl0ZWQi
Lg0KDQo+ICsNCj4gKwkJaWYgKGZhaWxlZCkNCj4gKwkJCXJldHVybiBkYnVzX2Vycm9yKG1zZywg
TUVTSF9FUlJPUl9JTlZBTElEX0FSR1MsDQo+ICsJCQkJCQkJIkludmFsaWQgb3B0aW9ucyIpOw0K
PiArCX0NCj4gKw0KPiAgCWlmIChzY2FuX25vZGUgJiYgc2Nhbl9ub2RlICE9IG5vZGUpDQo+ICAJ
CXJldHVybiBkYnVzX2Vycm9yKG1zZywgTUVTSF9FUlJPUl9CVVNZLCBOVUxMKTsNCj4gIA0KPiBA
QCAtNzUyLDEzICs3NzMsMTMgQEAgc3RhdGljIHN0cnVjdCBsX2RidXNfbWVzc2FnZSAqc2V0X2tl
eV9waGFzZV9jYWxsKHN0cnVjdCBsX2RidXMgKmRidXMsDQo+ICBzdGF0aWMgdm9pZCBzZXR1cF9t
YW5hZ2VtZW50X2ludGVyZmFjZShzdHJ1Y3QgbF9kYnVzX2ludGVyZmFjZSAqaWZhY2UpDQo+ICB7
DQo+ICAJbF9kYnVzX2ludGVyZmFjZV9tZXRob2QoaWZhY2UsICJBZGROb2RlIiwgMCwgYWRkX25v
ZGVfY2FsbCwgIiIsDQo+IC0JCQkJCQkJCSJheSIsICJ1dWlkIik7DQo+ICsJCQkJCQkiYXlhe3N2
fSIsICJ1dWlkIiwgIm9wdGlvbnMiKTsNCj4gIAlsX2RidXNfaW50ZXJmYWNlX21ldGhvZChpZmFj
ZSwgIkltcG9ydFJlbW90ZU5vZGUiLCAwLCBpbXBvcnRfbm9kZV9jYWxsLA0KPiAgCQkJCSIiLCAi
cXlheSIsICJwcmltYXJ5IiwgImNvdW50IiwgImRldl9rZXkiKTsNCj4gIAlsX2RidXNfaW50ZXJm
YWNlX21ldGhvZChpZmFjZSwgIkRlbGV0ZVJlbW90ZU5vZGUiLCAwLCBkZWxldGVfbm9kZV9jYWxs
LA0KPiAgCQkJCQkJIiIsICJxeSIsICJwcmltYXJ5IiwgImNvdW50Iik7DQo+ICAJbF9kYnVzX2lu
dGVyZmFjZV9tZXRob2QoaWZhY2UsICJVbnByb3Zpc2lvbmVkU2NhbiIsIDAsIHN0YXJ0X3NjYW5f
Y2FsbCwNCj4gLQkJCQkJCQkiIiwgInEiLCAic2Vjb25kcyIpOw0KPiArCQkJCQkJCSIiLCAiYXtz
dn0iLCAib3B0aW9ucyIpOw0KPiAgCWxfZGJ1c19pbnRlcmZhY2VfbWV0aG9kKGlmYWNlLCAiVW5w
cm92aXNpb25lZFNjYW5DYW5jZWwiLCAwLA0KPiAgCQkJCQkJY2FuY2VsX3NjYW5fY2FsbCwgIiIs
ICIiKTsNCj4gIAlsX2RidXNfaW50ZXJmYWNlX21ldGhvZChpZmFjZSwgIkNyZWF0ZVN1Ym5ldCIs
IDAsIGNyZWF0ZV9zdWJuZXRfY2FsbCwNCg==
