Return-Path: <SRS0=Dy9H=BA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A04BC433E2
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jul 2020 16:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E30CB20720
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jul 2020 16:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="hySFkPdd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgGUQBp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:01:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:42328 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727058AbgGUQBp (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jul 2020 12:01:45 -0400
IronPort-SDR: BXz0qh4F/JVHoelj0Pkr+5De/XkzYC6gB0YFbvZL8788LvW9E3PEzGtpPeKAaeHcf8/D9VlfLO
 Ym+xeF23izzA==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="147663262"
X-IronPort-AV: E=Sophos;i="5.75,379,1589266800"; 
   d="scan'208";a="147663262"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 09:01:44 -0700
IronPort-SDR: K1wXDL88bkwSwOTc3TfhUavD4gBxCTqVeaZ8l4un6GWIvNhCeE2QY6JSMFQ91fQCGDNEoXZod3
 /BcNPf5LGi8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,379,1589266800"; 
   d="scan'208";a="326412860"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Jul 2020 09:01:44 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 21 Jul 2020 09:01:44 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 21 Jul 2020 09:01:43 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 21 Jul 2020 09:01:43 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 21 Jul 2020 09:01:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hF/oRY/s//oTxojQrbtJvjyMBoKFJDOYXb9UEfmf5RUw3rUWZSBt2l/989Qr4bEGZR8UC1v58E7iO2gJ+ClTkB15h9cxo9EXK+0oG1rK74BrksyTAFBp2X+I/t2u0T+CnsicPXocF/z+4s6V7Oho37opTmI1Z2W35Vwt1uAMADa8e/oW8DnRa14MBNxxryeVzD9dvg52dLE6z/4bGixV3oJ40oyZfied7O/veRCj/vkOVddUvWjZrSB4Y1EgaZy7NXAemZH40YNYp9NtEPxKCui8Ylx4X5R9ZvdsI5Ss+ag32oteZwWrVzA99hMwiqUgLEY6CEWgptLjc8790yfgUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBJiqsqmro1IOFMzZ2zTsqfgaTYtJDcr5PXr9+WTo6o=;
 b=KKsO9TyiVZGT7CD9L86cB97ORCeFCBJGAVcIqpDRR2aue+BAdKekaQc8IMRWeJ75HrCEhdqIFa71MRPD0MupBow53w7RYdGRKVCXLTXSeopVOi+qOZqQyvIjoM2YWyqT31Ej992jThz0qv3CmaSzyHc0xj/y9sk5BHbOyUfWIBCrtUKlvNgPFqcUXcZDfYfAabpG3qGfFd5CaMrF1gsIPZ8H7RPQ7CYkdbxHpiO9Hcz3LwpdmaRRN7q2xR1XXCalluy2QXjBsQmEmdf/Kdyy6ci4EIQ2VI56V4Pv3Gj+iNAcgWf+yyeo0ObgFYwUKO2TwieYeLymllNweapNNfdnXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBJiqsqmro1IOFMzZ2zTsqfgaTYtJDcr5PXr9+WTo6o=;
 b=hySFkPddMEO2uPIloanCLnAP574Z4uWJvJ3Uk90l7vngRQOJqGJGlzPyzmKrbwhlMN+WUIoBrhBz7QT52Uacty3GLMVmHwhGlpeCD24rSFXV2lSC65E3dL2DsKBp2JxnkntjuTV83pF+adVmafFfjV4UejOypAAsKdMRD3TfTco=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR11MB1376.namprd11.prod.outlook.com (2603:10b6:300:1d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Tue, 21 Jul
 2020 16:01:41 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225%6]) with mapi id 15.20.3216.020; Tue, 21 Jul 2020
 16:01:41 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] tools/mesh-cfgclient: Fix segfault on remote node
 reset
Thread-Topic: [PATCH BlueZ] tools/mesh-cfgclient: Fix segfault on remote node
 reset
Thread-Index: AQHWXtZDXFR1ETe+P0KWJmGsKkycbKkSMsQA
Date:   Tue, 21 Jul 2020 16:01:41 +0000
Message-ID: <8c8c7b2470be83516d4868b52ff655bab9646a13.camel@intel.com>
References: <20200720204206.226761-1-inga.stotland@intel.com>
In-Reply-To: <20200720204206.226761-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 233c4920-67bc-41f5-d73f-08d82d8f5b93
x-ms-traffictypediagnostic: MWHPR11MB1376:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1376E500F0DE7368E45B91FAE1780@MWHPR11MB1376.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:114;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: peqIcGExNIoTPHXHWN5pimFuQjdItGC/Tb0lVsh14erz8qq9VbCljWABLKNnEwxwMTo2i6DSt9BczlWQ0LO5c93JRbz3pQVnnUjA85N6CQf8ozHFl3jD9Kb7sCtxerIYXcirScXfp8udMFIxaQQwOiPHLb7r9jQP6lBttdwtwjWU5eHAelOMXZU71MoYPglYyTa70oDfXBPlAHibPYUfxQPQyrtw606ATEQv5DI20mjzUihE1+v0A7RLLlsefxFS89tWOieypu5RjHkH0vqPyvLuO4x6+oCd3s6ZzOWPfG8erhAXf4CDqWv8N+jqpCgUA//SL8ofTTVdaEHTJ+6UdA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(6506007)(26005)(186003)(5660300002)(478600001)(316002)(110136005)(71200400001)(2906002)(86362001)(36756003)(6486002)(66446008)(64756008)(66476007)(76116006)(91956017)(66946007)(2616005)(66556008)(8676002)(6512007)(83380400001)(8936002)(6636002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: zF42h4cysN7XmTj91YdDQc3ECph9T/uXxpdRZkzXWhs7bJPVTGu7O3S6MjX87bBKJ7XlKZydXBsbjOrd7/PUinl9DzkNYb7Ig48tXR9v2py4VKWHJ4Y0jz3zrY4+W42u9DcW7hWgTyFZgo8GYexuq+Pu2HB5L/qZeHPisOOWDhXQLlzCc6y5TWeL87yBMJqZPGSvYRiuhyyjuyC1sEDW2oeSo4170yo8/lEARv3myUQSEXxjObUOtOmKMIOkQWiK7zJRzWwx7uH3tpL0HhSKHT3MCmR01WXqeJdvw0OXBiIfCtjhHOBx8eDaUIgWhxGS7WxL+cHjnWAtMYH8vDH+aCik0uX3PC5+XBwW0Dn25CqFbUUSG5nrGpI+fLj0AopxJgxBvFJg9qiR9izTNi0M/pvNjEYgNMhV273jSxpa/UCSsPHLmFr6Ov71It3AfS6Fi3Q88u2ocOT0JX3M8wng/iHY6RMThN9YGylidTq/uII=
Content-Type: text/plain; charset="utf-8"
Content-ID: <218A2629E8A289419571B3D8CF53C6A9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 233c4920-67bc-41f5-d73f-08d82d8f5b93
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2020 16:01:41.0922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y2nQNTVs8pMVdCwjIl+lvAsVN1iIa/Su9V7UzJHOCdsMiQjdVPTnQTk8uXLqzdvVzGzMfdxaeqZI/aMvhXPffg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1376
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gTW9uLCAyMDIwLTA3LTIwIGF0IDEzOjQyIC0wNzAwLCBJbmdhIFN0b3RsYW5k
IHdyb3RlOg0KPiBUaGlzIGZpeGVzIGEgc2VnZmF1bHQgdGhhdCBpcyBjYXVzZWQgYnkgZnJlZWVp
bmcgbm9uLWFsbG9jYXRlZCBtZW1vcnkuDQo+IEhhcHBlbnMgdXBvbiB0aGUgcmVtb3ZhbCBvZiBh
IHJlbW90ZSBub2RlIHdoZW4gcmVtb3RlJ3MgbmV0IGtleSBhbmQvb3INCj4gYXBwIGtleSBxdWV1
ZXMgYXJlIGRlc3Ryb3llZC4NCj4gDQo+IF9fR0lfX19saWJjX2ZyZWUgKG1lbT0weDEpIGF0IG1h
bGxvYy5jOjMxMDINCj4gICAgIGRlc3Ryb3k9ZGVzdHJveUBlbnRyeT0weDU1NzYxZjYzYTNiMCA8
bF9mcmVlPikgYXQgZWxsL3F1ZXVlLmM6MTA3DQo+ICAgICBkZXN0cm95PWRlc3Ryb3lAZW50cnk9
MHg1NTc2MWY2M2EzYjAgPGxfZnJlZT4pIGF0IGVsbC9xdWV1ZS5jOjgyDQo+ICAgICBhdCB0b29s
cy9tZXNoL3JlbW90ZS5jOjE0MA0KPiAgICAgYXQgdG9vbHMvbWVzaC9jZmdjbGkuYzo3NjQNCj4g
ICAgIGF0IHRvb2xzL21lc2gvY2ZnY2xpLmM6NzY0DQo+ICAgICBtc2c9MHg1NTc2MjEzYWE2ZjAs
IHVzZXJfZGF0YT08b3B0aW1pemVkIG91dD4pDQo+ICAgICBhdCB0b29scy9tZXNoLWNmZ2NsaWVu
dC5jOjE1MjINCj4gICAgIGRidXM9ZGJ1c0BlbnRyeT0weDU1NzYyMTMyZjg2MCwgbWVzc2FnZT1t
ZXNzYWdlQGVudHJ5PTB4NTU3NjIxM2FhNmYwKQ0KPiAgICAgYXQgZWxsL2RidXMtc2VydmljZS5j
OjE3OTMNCj4gICAgIHVzZXJfZGF0YT0weDU1NzYyMTMyZjg2MCkgYXQgZWxsL2RidXMuYzoyODUN
Cj4gICAgIHVzZXJfZGF0YT0weDU1NzYyMTMyZjk0MCkgYXQgZWxsL2lvLmM6MTI2DQo+IC0tLQ0K
PiAgdG9vbHMvbWVzaC9yZW1vdGUuYyB8IDUgKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvbWVz
aC9yZW1vdGUuYyBiL3Rvb2xzL21lc2gvcmVtb3RlLmMNCj4gaW5kZXggMmE4Zjc0N2Q2Li5jNzRm
MGJlYzEgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL21lc2gvcmVtb3RlLmMNCj4gKysrIGIvdG9vbHMv
bWVzaC9yZW1vdGUuYw0KPiBAQCAtMTM0LDEwICsxMzQsMTEgQEAgdWludDhfdCByZW1vdGVfZGVs
X25vZGUodWludDE2X3QgdW5pY2FzdCkNCj4gIAkJbF9xdWV1ZV9kZXN0cm95KHJtdC0+ZWxzW2ld
LCBOVUxMKTsNCj4gIAkJcmVtb3RlX2FkZF9ibGFja2xpc3RlZF9hZGRyZXNzKHVuaWNhc3QgKyBp
LCBpdl9pbmRleCwgdHJ1ZSk7DQo+ICAJfQ0KPiArDQo+ICAJbF9mcmVlKHJtdC0+ZWxzKTsNCj4g
IA0KPiAtCWxfcXVldWVfZGVzdHJveShybXQtPm5ldF9rZXlzLCBsX2ZyZWUpOw0KPiAtCWxfcXVl
dWVfZGVzdHJveShybXQtPmFwcF9rZXlzLCBsX2ZyZWUpOw0KPiArCWxfcXVldWVfZGVzdHJveShy
bXQtPm5ldF9rZXlzLCBOVUxMKTsNCj4gKwlsX3F1ZXVlX2Rlc3Ryb3kocm10LT5hcHBfa2V5cywg
TlVMTCk7DQo+ICAJbF9mcmVlKHJtdCk7DQo+ICANCj4gIAltZXNoX2RiX2RlbF9ub2RlKHVuaWNh
c3QpOw0K
