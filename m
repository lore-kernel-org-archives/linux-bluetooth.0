Return-Path: <SRS0=kuCk=2G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F03BC43603
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Dec 2019 22:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540E62465E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Dec 2019 22:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="ToYhBpIv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfLPWuN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:50:13 -0500
Received: from mga09.intel.com ([134.134.136.24]:42428 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbfLPWuN (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Dec 2019 17:50:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 14:50:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,323,1571727600"; 
   d="scan'208";a="205269467"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by orsmga007.jf.intel.com with ESMTP; 16 Dec 2019 14:50:12 -0800
Received: from orsmsx112.amr.corp.intel.com (10.22.240.13) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 16 Dec 2019 14:50:11 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX112.amr.corp.intel.com (10.22.240.13) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 16 Dec 2019 14:50:11 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.51) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 16 Dec 2019 14:50:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4OE/pShvWqgLoA/fpTBdds5y+PtebZVxrl6NmJ1bcEdEEVeMfKCWs2unNUcWo/a7MlkZjZDg4ryAUvDWooh2dFs66YrcO2ubTT+p33wzJ0bUnAs4lzykjzIM8UmuleUukD7ziRP8BuAcGxzSAw3I6emMcNVV+pM/sdHJpgW8vDvJNBKAf3gA62939u+FhzBul+BsqPXC7+PHcpGgrsuw9z6EFXDKYWoymUwyKWuUmYLEprbHss8+xBtpfKAOQaBlD48CWUHsDyfgHkA+bT2o9YMKE19/nF/PUs5XjVA+Elm/FBJGsga8t+I6Kij4w9C78GtstzxjBFBl1M8MeKm9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oWiMiG0RMNgltUGJ+jBt7SVZXlwFYeTpYSipPp+opQ=;
 b=VN6z4XZ7ipMZnITsEJU9iDtvbd1GjwPY6mU3pC27VkAOl+HcuTA7N4la+TcSyYchlrxiNdaxZEqxm6ap0On1x/XIS8QptUJB7bjLxem3svyHB35yQ+QZfQ0WF/ke1ZRrf58VZtDScZp0e3QVp7gIwutFwkqjFMlfq+s94IWPGyeK6QztIB4Z/vZmmF8fYqE6kKUuTUroiS5wgzR1HNCCXBH0gfz81HQTVniDOtiYW3ZKflkbExQkqdxq1MasFl5JCyJRXNXsamx92lLmRm7N8t1xh7uivrjFIbZaL+B97YFWk6hpRdI77ZC8kKnY4Ocqm+vvsDiY1E7iLDe3Wm7qNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oWiMiG0RMNgltUGJ+jBt7SVZXlwFYeTpYSipPp+opQ=;
 b=ToYhBpIvb1opGujfrLLueAX3kxx+kvanKe6wGsXsXsVDQpN6IA+FnVwx6xX4o0oNhwc6l7HjvQ5txzM8Dvs/UR+ZzCcLFqOY4QX5y+AfhuOIeEvCvzHsPIwRT9ErxEjt//d23MJhm0jDw64CbEiWlciQ8pFzrzzd0uciRJy2n0A=
Received: from CY4PR11MB1269.namprd11.prod.outlook.com (10.173.16.11) by
 CY4PR11MB0022.namprd11.prod.outlook.com (10.171.254.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.20; Mon, 16 Dec 2019 22:50:10 +0000
Received: from CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::39e0:30e9:a8b0:fe24]) by CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::39e0:30e9:a8b0:fe24%3]) with mapi id 15.20.2538.019; Mon, 16 Dec 2019
 22:50:10 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "aurelien@aurel32.net" <aurelien@aurel32.net>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] tools/mesh-cfgclient: add friend get/set commands
Thread-Topic: [PATCH BlueZ] tools/mesh-cfgclient: add friend get/set commands
Thread-Index: AQHVr6iAuOBpXOORSUK7yUW6wSGBRKe9ZwMA
Date:   Mon, 16 Dec 2019 22:50:10 +0000
Message-ID: <973d8d57b5bbedcd862938e109f0e81db2a1d78f.camel@intel.com>
References: <20191210222250.759969-1-aurelien@aurel32.net>
In-Reply-To: <20191210222250.759969-1-aurelien@aurel32.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1a230aa-9fa4-4887-2c70-08d7827a4e24
x-ms-traffictypediagnostic: CY4PR11MB0022:
x-microsoft-antispam-prvs: <CY4PR11MB00220A53B876DE6B50906BA9E1510@CY4PR11MB0022.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:556;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(136003)(376002)(346002)(189003)(199004)(5660300002)(316002)(478600001)(71200400001)(26005)(81166006)(36756003)(6486002)(186003)(4001150100001)(110136005)(8676002)(86362001)(6512007)(81156014)(91956017)(66946007)(66476007)(76116006)(64756008)(66446008)(66556008)(2616005)(8936002)(6506007)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR11MB0022;H:CY4PR11MB1269.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5A9tOQlGpBtkKzwXHk2Bm8Y54hipiBd8PXKAuIYWgL+adHXr8EL05pENpZZJMfUykiDPm5xO44p4j/OSN0cYIvSevPAE/g1RhkUvFiMmLYRZgBoX1GvWu+yOi+D6GpIswONU2aTu7+U/FhMkISgLD6T90gU45kcvhf3GGfk4iXmI4/THcb+gzG/Rg27kW9+VAmvzSZzgD/mslhA6PEi6uOhLc4TF8b0rZf/J5Nwo3tURQgDdC1LGhFeRCYPjx0O5sDZWHHNUaWha1Q8cgUvGY2GmqeHNX/+Dnr8nQbfI7FCZjek8SgkV/O5+dgxOsR4hXm2fhwJhzYH6gPnj1jsmwuy+ht3+5QNb1cWTColW0GhRVzocga1DJ7jihVbbHllEjEEbEneZzGlOx87/hHB62jJ3XN9GG2ugvTiaSyAukn2O7bdJu2lD9Jo+/Qd2vY7p
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C6ECE912497FD4D90C0CC6C30966AFA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a230aa-9fa4-4887-2c70-08d7827a4e24
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 22:50:10.3629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3zYJlb42OmS0bcPcIuFcxJtMLYK103fV1HMCVFFIMyVmAE+OeQDZuZTLGnr1xEYjD4/3H7G/9GwiOgo/jeSQAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB0022
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCB3aXRoIG1pbm9yIHJlLWFycmFuZ2UgZm9yIG11bHRpcGxlIGNvbW1hbmQgYWRkcw0K
VGhhbmtzDQoNCk9uIFR1ZSwgMjAxOS0xMi0xMCBhdCAyMzoyMiArMDEwMCwgQXVyZWxpZW4gSmFy
bm8gd3JvdGU6DQo+IEFkZCBmcmllbmQtZ2V0IGFuZCBmcmllbmQtc2V0IGNvbW1hbmRzIGFzIHBl
ciBNZXNoIFByb2ZpbGUgNC4zLjIuNTUsDQo+IDQuMy4yLjU2IGFuZCA0LjMuMi41Ny4NCj4gLS0t
DQo+ICB0b29scy9tZXNoL2NmZ2NsaS5jIHwgNDAgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDQwIGluc2VydGlvbnMoKykNCj4gDQo+
IGRpZmYgLS1naXQgYS90b29scy9tZXNoL2NmZ2NsaS5jIGIvdG9vbHMvbWVzaC9jZmdjbGkuYw0K
PiBpbmRleCBlYzlmYWJiM2IuLjkwMjBiYjc1MiAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvbWVzaC9j
ZmdjbGkuYw0KPiArKysgYi90b29scy9tZXNoL2NmZ2NsaS5jDQo+IEBAIC02MjEsNiArNjIxLDE1
IEBAIHN0YXRpYyBib29sIG1zZ19yZWN2ZCh1aW50MTZfdCBzcmMsIHVpbnQxNl90IGlkeCwgdWlu
dDhfdCAqZGF0YSwNCj4gIAkJCQlzcmMsIG1lc2hfc3RhdHVzX3N0cihkYXRhWzBdKSk7DQo+ICAN
Cj4gIAkJYnJlYWs7DQo+ICsNCj4gKwkvKiBQZXIgTWVzaCBQcm9maWxlIDQuMy4yLjU3ICovDQo+
ICsJY2FzZSBPUF9DT05GSUdfRlJJRU5EX1NUQVRVUzoNCj4gKwkJaWYgKGxlbiAhPSAxKQ0KPiAr
CQkJcmV0dXJuIHRydWU7DQo+ICsNCj4gKwkJYnRfc2hlbGxfcHJpbnRmKCJOb2RlICU0LjR4IEZy
aWVuZCBzdGF0ZSAweCUwMnhcbiIsDQo+ICsJCQkJc3JjLCBkYXRhWzBdKTsNCj4gKwkJYnJlYWs7
DQo+ICAJfQ0KPiAgDQo+ICAJcmV0dXJuIHRydWU7DQo+IEBAIC0xMzEwLDYgKzEzMTksMzMgQEAg
c3RhdGljIHZvaWQgY21kX25vZGVfcmVzZXQoaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkNCj4gIAlj
bWRfZGVmYXVsdChPUF9OT0RFX1JFU0VUKTsNCj4gIH0NCj4gIA0KPiArc3RhdGljIHZvaWQgY21k
X2ZyaWVuZF9zZXQoaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkNCj4gK3sNCj4gKwl1aW50MTZfdCBu
Ow0KPiArCXVpbnQ4X3QgbXNnWzIgKyAxXTsNCj4gKwlpbnQgcGFybV9jbnQ7DQo+ICsNCj4gKwlu
ID0gbWVzaF9vcGNvZGVfc2V0KE9QX0NPTkZJR19GUklFTkRfU0VULCBtc2cpOw0KPiArDQo+ICsJ
cGFybV9jbnQgPSByZWFkX2lucHV0X3BhcmFtZXRlcnMoYXJnYywgYXJndik7DQo+ICsJaWYgKHBh
cm1fY250ICE9IDEpIHsNCj4gKwkJYnRfc2hlbGxfcHJpbnRmKCJiYWQgYXJndW1lbnRzIik7DQo+
ICsJCXJldHVybiBidF9zaGVsbF9ub25pbnRlcmFjdGl2ZV9xdWl0KEVYSVRfRkFJTFVSRSk7DQo+
ICsJfQ0KPiArDQo+ICsJbXNnW24rK10gPSBwYXJtc1swXTsNCj4gKw0KPiArCWlmICghY29uZmln
X3NlbmQobXNnLCBuLCBPUF9DT05GSUdfRlJJRU5EX1NFVCkpDQo+ICsJCXJldHVybiBidF9zaGVs
bF9ub25pbnRlcmFjdGl2ZV9xdWl0KEVYSVRfRkFJTFVSRSk7DQo+ICsNCj4gKwlyZXR1cm4gYnRf
c2hlbGxfbm9uaW50ZXJhY3RpdmVfcXVpdChFWElUX1NVQ0NFU1MpOw0KPiArfQ0KPiArDQo+ICtz
dGF0aWMgdm9pZCBjbWRfZnJpZW5kX2dldChpbnQgYXJnYywgY2hhciAqYXJndltdKQ0KPiArew0K
PiArCWNtZF9kZWZhdWx0KE9QX0NPTkZJR19GUklFTkRfR0VUKTsNCj4gK30NCj4gKw0KPiAgc3Rh
dGljIGJvb2wgdHhfc2V0dXAobW9kZWxfc2VuZF9tc2dfZnVuY190IHNlbmRfZnVuYywgdm9pZCAq
dXNlcl9kYXRhKQ0KPiAgew0KPiAgCWlmICghc2VuZF9mdW5jKQ0KPiBAQCAtMTM5MCw2ICsxNDI2
LDEwIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYnRfc2hlbGxfbWVudSBjZmdfbWVudSA9IHsNCj4g
IAkJCQkiR2V0IHN1YnNjcmlwdGlvbiJ9LA0KPiAgCXsibm9kZS1yZXNldCIsIE5VTEwsIGNtZF9u
b2RlX3Jlc2V0LA0KPiAgCQkJCSJSZXNldCBhIG5vZGUgYW5kIHJlbW92ZSBpdCBmcm9tIG5ldHdv
cmsifSwNCj4gKwl7ImZyaWVuZC1zZXQiLCAiPGZyaWVuZD4iLCBjbWRfZnJpZW5kX3NldCwNCj4g
KwkJCQkiU2V0IGZyaWVuZCBzdGF0ZSJ9LA0KPiArCXsiZnJpZW5kLWdldCIsIE5VTEwsIGNtZF9m
cmllbmRfZ2V0LA0KPiArCQkJCSJHZXQgZnJpZW5kIHN0YXRlIn0sDQo+ICAJe30gfSwNCj4gIH07
DQo+ICANCg==
