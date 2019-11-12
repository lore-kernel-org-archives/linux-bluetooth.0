Return-Path: <SRS0=2Kq+=ZE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2FDC43331
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Nov 2019 17:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED802084E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Nov 2019 17:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="q3wyBKn7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfKLRzn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Nov 2019 12:55:43 -0500
Received: from mga05.intel.com ([192.55.52.43]:33675 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbfKLRzn (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Nov 2019 12:55:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2019 09:55:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,297,1569308400"; 
   d="scan'208";a="404331262"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga005.fm.intel.com with ESMTP; 12 Nov 2019 09:55:42 -0800
Received: from fmsmsx151.amr.corp.intel.com (10.18.125.4) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 12 Nov 2019 09:55:42 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX151.amr.corp.intel.com (10.18.125.4) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 12 Nov 2019 09:55:41 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.58) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 12 Nov 2019 09:55:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AolGKBdE018Sj1MuOxnM/GlzclrGinyRcmyMEafeHxflXWv07FVa4Womzxun/bh3q0s4nRBj3YqAewnh0lJFXJXlPDroL6MsME99F+1l+Q3f/U8OYbQs2tpu7B1C6+X3UCGtCtCqnA5IeydPOzc10/beL49QPHhxNXO8wmjEJHRgjgSNk8Qx4Hcysn9tJqXIuNRHQ/iboK0g1jaqdqGaaBqBIy+C0vptbi/mhnGk3RCGltv7yQFYLM3v7Ov7FZaYK4dNf77wlkPWJET/CP3Ownn0SVb6W94zI4NPcmt8WwgVDarTFJqdoBswSuV+l/xnSaYDuvuDI3YEvdAh1uiQnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y71DRn0uIwNXVRIleq0UIJeHFQAXla+20G0PsaE7eq0=;
 b=Tl4kFGnqyVtPKqNIDiAzpUKbuajf8kmkKSs5WmZWuShKf+daCGfaAhGp90queIQ5elKQqJmXQHSVd+Ar8x4F9Ya+KHycB5YCFd6Wg9j7BuNMEinVAViA3Mr91xyXKBtCd04VCp9aDy0gGjU0VvYA1unebQpOGtiVa7E+mCfimzZadeplizH4BBVnXRWVZzfZBmXmvONNO76J7cmE5yX730CgkNBogSV3/FeaDg+TKjzfyyKGHvd+oolN4POa61/uZdLNGmQ7dtGEpR6bzNByQlUIA/8th5sqHM/8uuj2z8aieWv5ov0yMBvNSrq3RjPtEUFp7gY9cFD0m4+Cz3iZug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y71DRn0uIwNXVRIleq0UIJeHFQAXla+20G0PsaE7eq0=;
 b=q3wyBKn797lOqvCgwa0PnhhDLXPx0ymLOujefVBHeFdaM6JsAcFHgEXdWwJFyhdOUO3TwyS1neIOeIeM0bT2I8SHEm2JzwXxM8DWqyQB+5+klVt4Xf+0iNbUwrzVUzZWeOnAQtshWLoPBJmbx7ZnWbrDrnfrV5vQVU7Tf1ZjSqM=
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com (10.172.76.7) by
 CY4PR1101MB2215.namprd11.prod.outlook.com (10.174.52.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Tue, 12 Nov 2019 17:55:40 +0000
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::44:eac4:f8c8:ad06]) by CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::44:eac4:f8c8:ad06%11]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 17:55:40 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "aurelien@aurel32.net" <aurelien@aurel32.net>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH Bluez] tools/mesh-cfgclient: add unbind command
Thread-Topic: [PATCH Bluez] tools/mesh-cfgclient: add unbind command
Thread-Index: AQHVmCZp8AnbPO8L0EW1488z5NSJIKeH1HyA
Date:   Tue, 12 Nov 2019 17:55:40 +0000
Message-ID: <730d19357516db53d0fec28c932c774ed53fc88a.camel@intel.com>
References: <20191111002407.32575-1-aurelien@aurel32.net>
In-Reply-To: <20191111002407.32575-1-aurelien@aurel32.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [134.134.137.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 491733ea-9e74-4b54-f738-08d7679987df
x-ms-traffictypediagnostic: CY4PR1101MB2215:
x-microsoft-antispam-prvs: <CY4PR1101MB22158338D4588344DB765788E1770@CY4PR1101MB2215.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(376002)(346002)(396003)(199004)(189003)(186003)(99286004)(6436002)(71190400001)(118296001)(25786009)(305945005)(486006)(6506007)(102836004)(76176011)(446003)(11346002)(26005)(7736002)(66066001)(476003)(2616005)(6512007)(6486002)(229853002)(256004)(71200400001)(6246003)(66556008)(66476007)(64756008)(81166006)(81156014)(66946007)(66446008)(8676002)(76116006)(14444005)(2906002)(6116002)(478600001)(3846002)(91956017)(2501003)(316002)(4001150100001)(36756003)(14454004)(8936002)(5660300002)(110136005)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1101MB2215;H:CY4PR1101MB2262.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iDCMneFKn4xKOZ2egWUA2hpu90dpYn2Dv+XFBJUDrtEtS/h5uZqulTqyW+c4n6D5fXsoDZiIHfi5hV0X+ifpj5yEVie9w+GOp+OdYMZT2qJ+SPJXEBgybJISiU8dwqXjCcBfvVc5wn+1HmJo2x14B4SfCE8q2Ml5PsjFsoJXhOR1nyEeSvYGg2vsl/P4mkSDpch/N/pAElj/t/sfvA1ti8qfB2srf+BBvYnWgBC25E/CC1xhExIWJKLCIrU2t68hZGouEo5GBGMegtAsZRr0YYwbXmnNzdut7GkctuJpfGQEPNyf1XtBkwBu8hz7vqjdEkgX+ycbEuCHsEfbzfGisJY542/1fyxxp/jWpZs9m9hFYT6L9TvD19i0kAuPtUm8t8hgQSS+tK7Slasktxt744/pw1D+wh24XERWS6UoAOXmCPGJWRNKwD+P2dfZ/BE/
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF032A72E3355E4AA9AB98B072CC157F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 491733ea-9e74-4b54-f738-08d7679987df
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 17:55:40.1629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aMnaj3MNL1En3Wp7cX+mrSKIC/oH14J30312YzHmvPJCExK1sOAJJLag0VNXF/y6y02dSl1JfsYxk2mvLxQg3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2215
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCwgVGhhbmtzDQoNCk9uIE1vbiwgMjAxOS0xMS0xMSBhdCAwMToyNCArMDEwMCwgQXVy
ZWxpZW4gSmFybm8gd3JvdGU6DQo+IFRoaXMgaXMgYmFzaWNhbGx5IGEgY29weSBvZiBjbWRfYmlu
ZCB3aXRoIE9QX01PREVMX0FQUF9CSU5EIHJlcGxhY2VkIGJ5DQo+IE9QX01PREVMX0FQUF9VTkJJ
TkQgYXMgY21kc1tdIGFscmVhZHkgaGFzIGNvZGUgdG8gaGFuZGxlIGl0Lg0KPiAtLS0NCj4gIHRv
b2xzL21lc2gvY2ZnY2xpLmMgfCAzNiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAzNiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvdG9vbHMvbWVzaC9jZmdjbGkuYyBiL3Rvb2xzL21lc2gvY2ZnY2xpLmMNCj4gaW5kZXggMDg2
OTk4OTEwLi5hNGRlNDI5NDMgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL21lc2gvY2ZnY2xpLmMNCj4g
KysrIGIvdG9vbHMvbWVzaC9jZmdjbGkuYw0KPiBAQCAtODk3LDYgKzg5Nyw0MCBAQCBzdGF0aWMg
dm9pZCBjbWRfYmluZChpbnQgYXJnYywgY2hhciAqYXJndltdKQ0KPiAgCXJldHVybiBidF9zaGVs
bF9ub25pbnRlcmFjdGl2ZV9xdWl0KEVYSVRfU1VDQ0VTUyk7DQo+ICB9DQo+ICANCj4gK3N0YXRp
YyB2b2lkIGNtZF91bmJpbmQoaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkNCj4gK3sNCj4gKwl1aW50
MTZfdCBuOw0KPiArCXVpbnQ4X3QgbXNnWzMyXTsNCj4gKwlpbnQgcGFybV9jbnQ7DQo+ICsNCj4g
KwlwYXJtX2NudCA9IHJlYWRfaW5wdXRfcGFyYW1ldGVycyhhcmdjLCBhcmd2KTsNCj4gKwlpZiAo
cGFybV9jbnQgIT0gMyAmJiBwYXJtX2NudCAhPSA0KSB7DQo+ICsJCWJ0X3NoZWxsX3ByaW50Zigi
QmFkIGFyZ3VtZW50c1xuIik7DQo+ICsJCXJldHVybiBidF9zaGVsbF9ub25pbnRlcmFjdGl2ZV9x
dWl0KEVYSVRfRkFJTFVSRSk7DQo+ICsJfQ0KPiArDQo+ICsJbiA9IG1lc2hfb3Bjb2RlX3NldChP
UF9NT0RFTF9BUFBfVU5CSU5ELCBtc2cpOw0KPiArDQo+ICsJcHV0X2xlMTYocGFybXNbMF0sIG1z
ZyArIG4pOw0KPiArCW4gKz0gMjsNCj4gKwlwdXRfbGUxNihwYXJtc1sxXSwgbXNnICsgbik7DQo+
ICsJbiArPSAyOw0KPiArDQo+ICsJaWYgKHBhcm1fY250ID09IDQpIHsNCj4gKwkJcHV0X2xlMTYo
cGFybXNbM10sIG1zZyArIG4pOw0KPiArCQlwdXRfbGUxNihwYXJtc1syXSwgbXNnICsgbiArIDIp
Ow0KPiArCQluICs9IDQ7DQo+ICsJfSBlbHNlIHsNCj4gKwkJcHV0X2xlMTYocGFybXNbMl0sIG1z
ZyArIG4pOw0KPiArCQluICs9IDI7DQo+ICsJfQ0KPiArDQo+ICsJaWYgKCFjb25maWdfc2VuZCht
c2csIG4sIE9QX01PREVMX0FQUF9VTkJJTkQpKQ0KPiArCQlyZXR1cm4gYnRfc2hlbGxfbm9uaW50
ZXJhY3RpdmVfcXVpdChFWElUX0ZBSUxVUkUpOw0KPiArDQo+ICsJcmV0dXJuIGJ0X3NoZWxsX25v
bmludGVyYWN0aXZlX3F1aXQoRVhJVF9TVUNDRVNTKTsNCj4gK30NCj4gKw0KPiAgc3RhdGljIHZv
aWQgY21kX2JlYWNvbl9zZXQoaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkNCj4gIHsNCj4gIAl1aW50
MTZfdCBuOw0KPiBAQCAtMTMzNSw2ICsxMzY5LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBidF9z
aGVsbF9tZW51IGNmZ19tZW51ID0gew0KPiAgCQkJCSJEZWxldGUgYXBwbGljYXRpb24ga2V5In0s
DQo+ICAJeyJiaW5kIiwgIjxlbGVfYWRkcj4gPGFwcF9pZHg+IDxtb2RfaWQ+IFt2ZW5kb3JfaWRd
IiwgY21kX2JpbmQsDQo+ICAJCQkJIkJpbmQgYXBwIGtleSB0byBhIG1vZGVsIn0sDQo+ICsJeyJ1
bmJpbmQiLCAiPGVsZV9hZGRyPiA8YXBwX2lkeD4gPG1vZF9pZD4gW3ZlbmRvcl9pZF0iLCBjbWRf
dW5iaW5kLA0KPiArCQkJCSJSZW1vdmUgYXBwIGtleSBmcm9tIGEgbW9kZWwifSwNCj4gIAl7Im1v
ZC1hcHBpZHgtZ2V0IiwgIjxlbGVfYWRkcj4gPG1vZGVsIGlkPiIsIGNtZF9tb2RfYXBwaWR4X2dl
dCwNCj4gIAkJCQkiR2V0IG1vZGVsIGFwcF9pZHgifSwNCj4gIAl7InR0bC1zZXQiLCAiPHR0bD4i
LCBjbWRfdHRsX3NldCwNCg==
