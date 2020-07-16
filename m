Return-Path: <SRS0=Zco+=A3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19883C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 08:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBEFE2067D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 08:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="BfzcJit1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgGPIkA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jul 2020 04:40:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:40635 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbgGPIj7 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jul 2020 04:39:59 -0400
IronPort-SDR: j0g+K8vpftdLJYkRZ3XcTxXLv97uJIJTNxIJhe0d5WsHrWMkPc3o/EhGDMp7DE+jltoLjkbWd7
 x58g1Qf/giyA==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="210873151"
X-IronPort-AV: E=Sophos;i="5.75,358,1589266800"; 
   d="scan'208";a="210873151"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 01:39:58 -0700
IronPort-SDR: DO4grs1kzSEN8kymiXuKTbLJzHvkFMPRI5n3Pf99jjTXY0pCM8jBY35ovOtwhQ+9y6lsz7Aruk
 1uNOBo5w8+kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,358,1589266800"; 
   d="scan'208";a="430421729"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 16 Jul 2020 01:39:58 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 16 Jul 2020 01:39:58 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 16 Jul 2020 01:39:58 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Jul 2020 01:39:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=al+oJTUuGotkFuv2wHAw+872P8+2aS+8r+glg3hPfxEuGs8t0BJcQYZPVKz35bn8uVvkYAxenN9njTzadwdXsI9Dv2aDUnGUh73QYtYZN0KKjBgotJVkpjHAkrbhJ8DhASAe7yzs4yoRTuyWoLcmAwV+MPPxsgpGnqJfvNqnC58crU60y0ZlqVB9UQe47hl7AJhp0ouqrWKm+Mdxi22VDawtx/PIbq5nwXtub3I3g1eUsGdEqo7OF8VHPsJy5YzqMoOtgPrJy6juVl9xVTiqO+rzchPh/ONb1NFNB8je3jcRvNv/zjdWHjHLjInrAZ5/wvvdhPSbSVOVggSzqe/csA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQE21eNy0iUx1ymkuQZ+uH7HhH5R4icOIWoVX1v/tLg=;
 b=Opz8boVl/26pcyE/bdYbK842rCIsSHKQZtXexCHJ/y1KStL6LRqgqOX/T/C9J25u5MEjy/Q6IWJHfJQC7Ytz/AoYP2VaGuENyiuMYLxJzX2ssza5OoUchCXY+WBp7ySrCzz/rmk0NhvZ7QHhC2W3AIeI5VytwCqIVpPLC0OQEXyZ5ys+rJ7bWpgr2r4BfIDEBKALnVwyZqmvc0zQBBHar78jNKOhIqQdhD0bR40srHBqZWIXh1wjAhViNmgs2XY9hY2mEnGwgcRd0olX3YQHIMsI2B0ykMjhF22GF2SVqnA+sTNb0GdBnk5tw4MpECWcrMKHm0AUPmQbL9xMPM/uCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQE21eNy0iUx1ymkuQZ+uH7HhH5R4icOIWoVX1v/tLg=;
 b=BfzcJit1nWue6tTqgbOdJvNUylvP5GYssYyO1ULlfmUalhusLJmEVcAAYMOllHLCZfbz8S2JTCGzu7w0yP4XvRfetYK7mIQCAmux48FzEklZrXLyyqjPDjMhw9/Rmnx7Fn9dm4DtrB6r7ZAxpT37qlDAKsa/SU/M3ZtNThDTnPo=
Received: from DM6PR11MB3369.namprd11.prod.outlook.com (2603:10b6:5:b::16) by
 DM6PR11MB2937.namprd11.prod.outlook.com (2603:10b6:5:62::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.18; Thu, 16 Jul 2020 08:39:55 +0000
Received: from DM6PR11MB3369.namprd11.prod.outlook.com
 ([fe80::9064:3ba:cdd3:793b]) by DM6PR11MB3369.namprd11.prod.outlook.com
 ([fe80::9064:3ba:cdd3:793b%7]) with mapi id 15.20.3174.026; Thu, 16 Jul 2020
 08:39:55 +0000
From:   "Singh, AmitX K" <amitx.k.singh@intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Panda, Bharat B" <bharat.b.panda@intel.com>
Subject: RE: [PATCH 1/2] bluez:load Generic access service
Thread-Topic: [PATCH 1/2] bluez:load Generic access service
Thread-Index: AQHWO0WRIU81EbuT4k+8k2uG05Vf0qjKP/IAgDzW7xA=
Date:   Thu, 16 Jul 2020 08:39:55 +0000
Message-ID: <DM6PR11MB3369DA18BE2A012A64A8637BB67F0@DM6PR11MB3369.namprd11.prod.outlook.com>
References: <20200605142541.28412-1-amitx.k.singh@intel.com>
 <20200605142541.28412-4-amitx.k.singh@intel.com>
 <CABBYNZ+iO_0djYfBmTyURC3NU_jpUHRHBr21zF-gNXNJLKySGg@mail.gmail.com>
In-Reply-To: <CABBYNZ+iO_0djYfBmTyURC3NU_jpUHRHBr21zF-gNXNJLKySGg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [49.207.200.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 843b46c9-1340-40f1-3b72-08d82963d0ff
x-ms-traffictypediagnostic: DM6PR11MB2937:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB2937AB4A523966FF8554FD88B67F0@DM6PR11MB2937.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iVZuDbTvLQDcMG8BAKh5lca08LIIvhpg4TaErvxPDlVt7kX4Fu/7hWCEJ8ggCz/gMZwGqsOVPn6ueAXtHofvri5oH5SsSVxZdLtI8Fy4a53U4xEXrq/xOR1EZdyj8DFSzpImjipjtxxlIQ2YKrinu4VKYlHos+jOEGt7FGp2T+GBrFMwIrRFCZSFm3oeWZIgRC3kVoLRK3qeoyBXj/n/Hpvk795V2iQVSm8Gy8R8P1FApKaGF4kCPE7SAptii0mjNQhkPsRvYsh1m8zUWM5vBszGPtyNvjTjAQmYGsneYl1zVZnU0L1aqYgl2c1+sZBmWQGqvsxIGZW/UFKz/m0cp/3Z9fWEOM4l2e21I1W7m4z9XvQNalrEykbukpVmokPa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3369.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(6506007)(66476007)(64756008)(66556008)(26005)(54906003)(53546011)(6916009)(186003)(478600001)(7696005)(33656002)(66946007)(8936002)(8676002)(86362001)(5660300002)(9686003)(66446008)(55016002)(2906002)(71200400001)(76116006)(52536014)(4326008)(55236004)(107886003)(316002)(83380400001)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: jmXq9r3NsHpkQDiehkjWQnB+UlSbrVbXG1DG4vyYOQPjlzgnoitg1MIVW4Z7eNduo9RZe8zd97jeGFdAhTlsYZJ0Myo5FNnhwTP7PxhxYr34l9PD4MZkHf92+w5pzEQ9sbKQUCaRMKU3ZJulAPHqt2Tjvn0A8Cx/eNwM/RKuXoM9bgkwAVb0CdXDgSsvib6JQi+frUcrtYFkro+luDyyM/ugigUIPD/zlGGp2Wt7ujm+sUrxp0AL4TOd01Ovf+JLmwfA7qmVQHfnm5Me6j8+spNpmFVhSifggDBBYloa/x0FqcWPhEdIFp6r3nl4EvfEbWK3pw7TFMcu60Wm8vj7191cUW1rBUEhmbbbXz/QGs12vLznrOzCLQ7XBjVCUaDWnGUhu0aiqBNq9Nk/dl3vDDO4Jl/DV8sdOFQwxrp848h2JOBmrkuoBq3cp8gbXduY4zKmgybdMxYh0e1eM8DlZyDNAZ52ASnYsnVvteJTWC0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3369.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 843b46c9-1340-40f1-3b72-08d82963d0ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2020 08:39:55.7354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z0yb8C8ZAIz5GT8nziJ8ZSFYasxpjFyr0LT+4kRy9lTk6FWpRdT7+3CA5cFUnaeiNvZPnpSeryy2UjImNmJT+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2937
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWl6IEF1
Z3VzdG8gdm9uIERlbnR6IDxsdWl6LmRlbnR6QGdtYWlsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBK
dW5lIDUsIDIwMjAgMTA6MzQgUE0NCj4gVG86IFNpbmdoLCBBbWl0WCBLIDxhbWl0eC5rLnNpbmdo
QGludGVsLmNvbT4NCj4gQ2M6IGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCAxLzJdIGJsdWV6OmxvYWQgR2VuZXJpYyBhY2Nlc3Mgc2VydmljZQ0K
PiANCj4gSGkgQW1pdCwNCj4gDQo+IE9uIEZyaSwgSnVuIDUsIDIwMjAgYXQgNzozMSBBTSBBbWl0
c2k1eCA8YW1pdHguay5zaW5naEBpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTog4oCc
QW1pdFNpbmdo4oCdIDxhbWl0eC5rLnNpbmdoQGludGVsLmNvbT4NCj4gPg0KPiA+IEl0IGFsbG93
IHRvIGxvYWQgZ2VuZXJpYyBhY2Nlc3Mgc2VydmljZSB0byBkYXRhYmFzZQ0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTog4oCcQW1pdFNpbmdo4oCdIDxhbWl0eC5rLnNpbmdoQGludGVsLmNvbT4NCj4g
PiAtLS0NCj4gPiAgc3JjL2dhdHQtY2xpZW50LmMgfCAzIC0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9zcmMvZ2F0dC1jbGllbnQu
YyBiL3NyYy9nYXR0LWNsaWVudC5jIGluZGV4DQo+ID4gMjBjM2ZiZWMyLi4yYWUyNThkYTAgMTAw
NjQ0DQo+ID4gLS0tIGEvc3JjL2dhdHQtY2xpZW50LmMNCj4gPiArKysgYi9zcmMvZ2F0dC1jbGll
bnQuYw0KPiA+IEBAIC0yMDA5LDkgKzIwMDksNiBAQCBzdGF0aWMgdm9pZCBleHBvcnRfc2Vydmlj
ZShzdHJ1Y3QNCj4gZ2F0dF9kYl9hdHRyaWJ1dGUgKmF0dHIsIHZvaWQgKnVzZXJfZGF0YSkNCj4g
PiAgICAgICAgIHN0cnVjdCBidGRfZ2F0dF9jbGllbnQgKmNsaWVudCA9IHVzZXJfZGF0YTsNCj4g
PiAgICAgICAgIHN0cnVjdCBzZXJ2aWNlICpzZXJ2aWNlOw0KPiA+DQo+ID4gLSAgICAgICBpZiAo
Z2F0dF9kYl9zZXJ2aWNlX2dldF9jbGFpbWVkKGF0dHIpKQ0KPiA+IC0gICAgICAgICAgICAgICBy
ZXR1cm47DQo+ID4gLQ0KPiANCj4gVGhpcyBpcyBhY3R1YWxseSBkb25lIG9uIHB1cnBvc2UgaW4g
b3JkZXIgdG8gYXZvaWQgZXh0cmEgdHJhZmZpYyBzaW5jZSB0aGUNCj4gZGFlbW9uIGFscmVhZHkg
ZXhwb3NlcyB0aGlzIGluZm9ybWF0aW9uIGluIG90aGVyIGludGVyZmFjZXMuDQo+IA0KDQpHQVAg
c2VydmljZSBpcyBub3QgZ2V0dGluZyBzdG9yZWQgaXMgaGFzaCBkYXRhYmFzZSAuVG8gdmVyaWZ5
IHRoZSBQVFMgdGVzdCAgY2FzZSBHQVRUL0NML0dBRC9CVi0wMi1DIHdoaWNoIGlzIEdBUCBzZXJ2
aWNlIGRpc2NvdmVyeSB3aXRoICcxODAwJyBVVUlELCB2ZXJkaWN0cyBhcyAiSU5DT05DTFVTSVZF
IiBhcyBpdCBkb2VzIG5vdCBmaW5kIHRoZSBHQVAgVVVJRCBpbiBwbGFjZQ0KDQo+ID4gICAgICAg
ICBzZXJ2aWNlID0gc2VydmljZV9jcmVhdGUoYXR0ciwgY2xpZW50KTsNCj4gPiAgICAgICAgIGlm
ICghc2VydmljZSkNCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuOw0KPiA+IC0tDQo+ID4gMi4x
Ny4xDQo+IA0KPiAtLQ0KPiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6DQo=
