Return-Path: <SRS0=n6SA=5M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51350C43331
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 22:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0774D206DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 22:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Nk7wQ7C+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbgC0WWJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Mar 2020 18:22:09 -0400
Received: from mga07.intel.com ([134.134.136.100]:12032 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727655AbgC0WWJ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Mar 2020 18:22:09 -0400
IronPort-SDR: Yt2Xth7r9lZ7ERCiHa3ybRjxPKHc/CuzXNCJGl4AA5mm1siDH6jAI0TygfEj0hTbDr+6soEYYI
 iCjrWH9j7C+Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 15:22:08 -0700
IronPort-SDR: gmPxAhd6MDQ3Xe2K2Kifq2TjdrUyKuhhhZXiw+OYGGO3k9BKk/XkUR9ja+uBIZ2+W9PqM4fnPv
 Fza2pYowK6LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,314,1580803200"; 
   d="scan'208";a="248023783"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga003.jf.intel.com with ESMTP; 27 Mar 2020 15:22:07 -0700
Received: from fmsmsx123.amr.corp.intel.com (10.18.125.38) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 27 Mar 2020 15:22:07 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx123.amr.corp.intel.com (10.18.125.38) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 27 Mar 2020 15:22:07 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 27 Mar 2020 15:22:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIaOTL1VPPg67Kv1slLJv7q/va7QwlN5dIPhfwN3TbymSGF2as3N4UbOJgHxa5G3k447MNwrDdQnJoRW0bs4e4t0J7sUfxD8YYo6fnmfcAZJCrKuBx5+gWxq/Lyg7BPud2gKrfjunfmsY5H4kMdQPIQmARflXQdoSwa119FCRys28PffAdSW9MN4ZQdZxcWwiyYM+CWePIH/Xma2yo42qwyDAQSIfuNVQvcZQBZW+HgNO5ZAIUTQoyta+xyrsN8AqFV+snj3LKpmq01wFpV3izFUMAz6VSBp1eYFzbUGq474jLXpJoQl6G4Zn6V58JRtMYuqAMcdPnisQGV92N3uPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beL5iLHTGH/ZAP3Wx4CKuGd1EN10ekcLzedPE+akSvg=;
 b=AApbel+e/c6YnOO+w06lmRkyAoc6U5lOHwJYt4xdDOK4KLlMY+DVKt6+HQKX9FiMSz6Bbuj67mIT8yVkWhv4lH0Lpco8AF33cPs2zV9QUZOtgIc6+E8NJNf+I1ENBMr/3kp22zwQVrZSuxSOLCA69FGAPAyGT9nbMZ8ZTbKrl5+fVu/dRi6X2t0WK+npjwRraDlYv13J2v8eTV/TstAOlILatHcTPUIOHnKfjG4kej/0CG6RfErPQw5vCxbOgUN1EER/n66IVq9eZHeXcgCXLXxLPTOAnV22cWixVldIc/FnDFVBUtpyP+81AocSvpOANJa4i2IpUB0kjEEd2zAJyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beL5iLHTGH/ZAP3Wx4CKuGd1EN10ekcLzedPE+akSvg=;
 b=Nk7wQ7C+jr3H+FUkHL0KgOTii9VNE48AqGNj/gtZQDBOcQf44ZYej0+MyaayuNWzUjCUfTJ9/3gHNqFr6mMeS+h0m15xUryL6QoslrETjiCBZ9lFySsGu5yZ7l6JfOX3NG4vOTI0GSoSK9QSVB25sXUVLUPKCupq27mjaUY13cg=
Received: from MWHPR11MB1423.namprd11.prod.outlook.com (2603:10b6:300:22::14)
 by MWHPR11MB1504.namprd11.prod.outlook.com (2603:10b6:301:c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Fri, 27 Mar
 2020 22:22:05 +0000
Received: from MWHPR11MB1423.namprd11.prod.outlook.com
 ([fe80::61cc:c5cd:21af:4e00]) by MWHPR11MB1423.namprd11.prod.outlook.com
 ([fe80::61cc:c5cd:21af:4e00%7]) with mapi id 15.20.2835.025; Fri, 27 Mar 2020
 22:22:05 +0000
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "Gix, Brian" <brian.gix@intel.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 2/4] mesh: Update UnprovisionedScan, AddNode &
 ScanResult
Thread-Topic: [PATCH BlueZ 2/4] mesh: Update UnprovisionedScan, AddNode &
 ScanResult
Thread-Index: AQHWBGeVfwkL6MbyTkaAU3yIWTjvVqhc8VuAgAASHwA=
Date:   Fri, 27 Mar 2020 22:22:05 +0000
Message-ID: <dbfc69b52043d8ecdd695f58f83f2ed312390df6.camel@intel.com>
References: <20200327184257.15042-1-inga.stotland@intel.com>
         <20200327184257.15042-3-inga.stotland@intel.com>
         <23a1089f89c125779b4b3a73607d8ad8d38e1aef.camel@intel.com>
In-Reply-To: <23a1089f89c125779b4b3a73607d8ad8d38e1aef.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=inga.stotland@intel.com; 
x-originating-ip: [192.55.55.41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6eee3899-c114-4234-736c-08d7d29d47c9
x-ms-traffictypediagnostic: MWHPR11MB1504:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1504EFB3DA26FFEEC272F86CFBCC0@MWHPR11MB1504.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0355F3A3AE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(39860400002)(376002)(346002)(6512007)(37006003)(6506007)(86362001)(2906002)(81166006)(8676002)(81156014)(6486002)(8936002)(71200400001)(478600001)(91956017)(66446008)(66556008)(66476007)(5660300002)(64756008)(2616005)(26005)(66946007)(6862004)(4326008)(316002)(186003)(6636002)(76116006)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR11MB1504;H:MWHPR11MB1423.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ASpGj2LHUcg+eZBGAnmTqSJCMOI2fjFZEzhyuXF+482/y8snrOUB2TUSLvuaDySrRO/JtVPHRt1pu+P1/p2qC826GUJGGkj9kXzxM/HhcfpmWNtpYEAoIeVLOvzAbxP0pp496QR2f0f3A+NKzYACRW4BjUoM3o5xnWNIB7Aza1zKMi+u3cgG2Za2bJLIKW6Pq8qOuYMCCAen+xSPHujLSAuTr3zWStBV00Kx02NiuZsyuRjDID+lNc6QIf0hM7U8IcR1RI8PZvVyx/P/jnuBS5RGS0+TgA1dmdDN62/DwXcLLMbxyd8xy2X9LLLgGrCpdds67X/TQWIXxt5H656oMtLNLjOU16WX/wn/cjUZ0glknQjIf9NrRAOX46ndIDh+1q5IWSrXGoGPkeeIRR8gpIzhl+F8MQZgLdPGcuvd8+46CHcOgmPsM1oRdpRYSn7A
x-ms-exchange-antispam-messagedata: vIeEa80QceHo1KaQn1BcxC83/FJS5hEbGmvz4kohCw22qmSlWWL6suVeWcwjqMqerd0oyOIHv5OX4W3Js1Z/S18QRlF4GjjNliUMkImTl56dbGet2Z2/K++2IphpIS0jFYPrPMfSxLVJzLNDqNZSIg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <40CFA3B401FECD45A624B0C232CB5ECE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eee3899-c114-4234-736c-08d7d29d47c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2020 22:22:05.0768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PrWg8Axchjijb2cjSlSBVlBt2j7o3gMTm5vh2mjhxCvIUD/HyqMqPM5XiPJwTPbkKMys4SSm/MzoWs2Sz5tekw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1504
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgQnJpYW4sDQoNCk9uIEZyaSwgMjAyMC0wMy0yNyBhdCAyMToxNyArMDAwMCwgR2l4LCBCcmlh
biB3cm90ZToNCj4gSGkgSW5nYSwNCj4gT24gRnJpLCAyMDIwLTAzLTI3IGF0IDExOjQyIC0wNzAw
LCBJbmdhIFN0b3RsYW5kIHdyb3RlOg0KPiA+IFRoZSBmb2xsb3dpbmcgbWV0aG9kcyBhcmUgbW9k
aWZpZWQgdG8gYWxsb3cgZm9yIGZ1dHVyZSBkZXZlbG9wbWVudDoNCj4gPiANCj4gPiBJbnRlcmZh
Y2Ugb3JnLmJsdWV6Lm1lc2guTWFuYWdlbWVudDE6DQo+ID4gDQo+ID4gT2xkOiB2b2lkIFVucHJv
dmlzaW9uZWRTY2FuKHVpbnQxNiBzZWNvbmRzKQ0KPiA+IE5ldzogdm9pZCBVbnByb3Zpc2lvbmVk
U2NhbihkaWN0IG9wdGlvbnMpDQo+ID4gDQo+ID4gICAgIFRoZSBvcHRpb25zIHBhcmFtZXRlciBp
cyBhIGRpY3Rpb25hcnkgd2l0aCB0aGUgZm9sbG93aW5nIGtleXMgZGVmaW5lZDoNCj4gPiAgICAg
dWludDE2IFNlY29uZHMNCj4gPiAgICAgICAgICAgICAgICAgU3BlY2lmaWVzIG51bWJlciBvZiBz
ZWNvbmRzIGZvciBzY2FubmluZyB0byBiZSBhY3RpdmUuDQo+ID4gICAgICAgICAgICAgICAgIElm
IHNldCB0byAwIG9yIGlmIHRoaXMga2V5IGlzIG5vdCBwcmVzZW50LCB0aGVuIHRoZQ0KPiA+ICAg
ICAgICAgICAgICAgICBzY2FubmluZyB3aWxsIGNvbnRpbnVlIHVudGlsIFVucHJvdmlzaW9uZWRT
Y2FuQ2FuY2VsKCkNCj4gPiAgICAgICAgICAgICAgICAgb3IgQWRkTm9kZSgpIG1ldGhvZHMgYXJl
IGNhbGxlZC4NCj4gPiAgICAgb3RoZXIga2V5cyBUQkQNCj4gPiANCj4gPiBPbGQ6IHZvaWQgQWRk
Tm9kZShhcnJheXtieXRlfVsxNl0gdXVpZCkNCj4gPiBOZXc6IHZvaWQgQWRkTm9kZShhcnJheXti
eXRlfVsxNl0gdXVpZCwgZGljdCBvcHRpb25zKQ0KPiA+IA0KPiA+ICAgICBUaGUgb3B0aW9ucyBw
YXJhbWV0ZXIgaXMgY3VycmVudGx5IGFuIGVtcHR5IGRpY3Rpb25hcnkNCj4gPiANCj4gPiBJbnRl
cmZhY2Ugb3JnLmJsdWV6Lm1lc2guUHJvdmlzaW9uZXIxDQo+ID4gDQo+ID4gT2xkOiB2b2lkIFNj
YW5SZXN1bHQoaW50MTYgcnNzaSwgYXJyYXl7Ynl0ZX0gZGF0YSkNCj4gPiBOZXc6IHZvaWQgU2Nh
blJlc3VsdChpbnQxNiByc3NpLCBhcnJheXtieXRlfSBkYXRhLCBkaWN0IG9wdGlvbnMpDQo+ID4g
DQo+ID4gICAgIFRoZSBvcHRpb25zIHBhcmFtZXRlciBpcyBjdXJyZW50bHkgYW4gZW1wdHkgZGlj
dGlvbmFyeQ0KPiA+IC0tLQ0KPiA+ICBtZXNoL21hbmFnZXIuYyB8IDM5ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKy0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMzAgaW5zZXJ0
aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvbWVzaC9tYW5h
Z2VyLmMgYi9tZXNoL21hbmFnZXIuYw0KPiA+IGluZGV4IDA5MDljN2UxNi4uOGU5NDhlNDdkIDEw
MDY0NA0KPiA+IC0tLSBhL21lc2gvbWFuYWdlci5jDQo+ID4gKysrIGIvbWVzaC9tYW5hZ2VyLmMN
Cj4gPiBAQCAtMjE3LDIxICsyMTcsMjIgQEAgc3RhdGljIHN0cnVjdCBsX2RidXNfbWVzc2FnZSAq
YWRkX25vZGVfY2FsbChzdHJ1Y3QgbF9kYnVzICpkYnVzLA0KPiA+ICAJCQkJCQl2b2lkICp1c2Vy
X2RhdGEpDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBtZXNoX25vZGUgKm5vZGUgPSB1c2VyX2RhdGE7
DQo+ID4gLQlzdHJ1Y3QgbF9kYnVzX21lc3NhZ2VfaXRlciBpdGVyX3V1aWQ7DQo+ID4gKwlzdHJ1
Y3QgbF9kYnVzX21lc3NhZ2VfaXRlciBpdGVyX3V1aWQsIG9wdGlvbnM7DQo+ID4gIAlzdHJ1Y3Qg
bF9kYnVzX21lc3NhZ2UgKnJlcGx5Ow0KPiA+ICAJdWludDhfdCAqdXVpZDsNCj4gPiAtCXVpbnQz
Ml90IG47DQo+ID4gKwl1aW50MzJfdCBuID0gMjI7DQo+ID4gIA0KPiA+ICAJbF9kZWJ1ZygiQWRk
Tm9kZSByZXF1ZXN0Iik7DQo+ID4gIA0KPiA+IC0JaWYgKCFsX2RidXNfbWVzc2FnZV9nZXRfYXJn
dW1lbnRzKG1zZywgImF5IiwgJml0ZXJfdXVpZCkpDQo+ID4gKwlpZiAoIWxfZGJ1c19tZXNzYWdl
X2dldF9hcmd1bWVudHMobXNnLCAiYXlhe3N2fSIsICZpdGVyX3V1aWQsICZvcHRpb25zKSkNCj4g
PiAgCQlyZXR1cm4gZGJ1c19lcnJvcihtc2csIE1FU0hfRVJST1JfSU5WQUxJRF9BUkdTLCBOVUxM
KTsNCj4gPiAgDQo+ID4gIAlpZiAoIWxfZGJ1c19tZXNzYWdlX2l0ZXJfZ2V0X2ZpeGVkX2FycmF5
KCZpdGVyX3V1aWQsICZ1dWlkLCAmbikNCj4gPiAtCQkJCQkJCQl8fCBuICE9IDE2KQ0KPiA+ICsJ
ICAgIHx8IG4gIT0gMTYpIHsNCj4gPiArCQlsX2RlYnVnKCJuID0gJXUiLCBuKTsNCj4gPiAgCQly
ZXR1cm4gZGJ1c19lcnJvcihtc2csIE1FU0hfRVJST1JfSU5WQUxJRF9BUkdTLA0KPiA+ICAJCQkJ
CQkJIkJhZCBkZXZpY2UgVVVJRCIpOw0KPiA+IC0NCj4gPiArCX0NCj4gPiAgCS8qIEFsbG93IEFk
ZE5vZGUgdG8gY2FuY2VsIFNjYW5uaW5nIGlmIGZyb20gdGhlIHNhbWUgbm9kZSAqLw0KPiA+ICAJ
aWYgKHNjYW5fbm9kZSkgew0KPiA+ICAJCWlmIChzY2FuX25vZGUgIT0gbm9kZSkNCj4gPiBAQCAt
MzYxLDYgKzM2Miw5IEBAIHN0YXRpYyB2b2lkIHByb3ZfYmVhY29uX3JlY3Yodm9pZCAqdXNlcl9k
YXRhLCBzdHJ1Y3QgbWVzaF9pb19yZWN2X2luZm8gKmluZm8sDQo+ID4gIAlidWlsZGVyID0gbF9k
YnVzX21lc3NhZ2VfYnVpbGRlcl9uZXcobXNnKTsNCj4gPiAgCWxfZGJ1c19tZXNzYWdlX2J1aWxk
ZXJfYXBwZW5kX2Jhc2ljKGJ1aWxkZXIsICduJywgJnJzc2kpOw0KPiA+ICAJZGJ1c19hcHBlbmRf
Ynl0ZV9hcnJheShidWlsZGVyLCBkYXRhICsgMiwgbGVuIC0yKTsNCj4gPiArCWxfZGJ1c19tZXNz
YWdlX2J1aWxkZXJfZW50ZXJfYXJyYXkoYnVpbGRlciwgIntzdn0iKTsNCj4gPiArCS8qIFRPRE86
IHBvcHVsYXRlIHdpdGggb3B0aW9ucyB3aGVuIGRlZmluZWQgKi8NCj4gPiArCWxfZGJ1c19tZXNz
YWdlX2J1aWxkZXJfbGVhdmVfYXJyYXkoYnVpbGRlcik7DQo+ID4gIAlsX2RidXNfbWVzc2FnZV9i
dWlsZGVyX2ZpbmFsaXplKGJ1aWxkZXIpOw0KPiA+ICAJbF9kYnVzX21lc3NhZ2VfYnVpbGRlcl9k
ZXN0cm95KGJ1aWxkZXIpOw0KPiA+ICANCj4gPiBAQCAtMzcyLDE3ICszNzYsMzQgQEAgc3RhdGlj
IHN0cnVjdCBsX2RidXNfbWVzc2FnZSAqc3RhcnRfc2Nhbl9jYWxsKHN0cnVjdCBsX2RidXMgKmRi
dXMsDQo+ID4gIAkJCQkJCXZvaWQgKnVzZXJfZGF0YSkNCj4gPiAgew0KPiA+ICAJc3RydWN0IG1l
c2hfbm9kZSAqbm9kZSA9IHVzZXJfZGF0YTsNCj4gPiAtCXVpbnQxNl90IGR1cmF0aW9uOw0KPiA+
ICsJdWludDE2X3QgZHVyYXRpb24gPSAwOw0KPiA+ICAJc3RydWN0IG1lc2hfaW8gKmlvOw0KPiA+
ICAJc3RydWN0IG1lc2hfbmV0ICpuZXQ7DQo+ID4gKwljb25zdCBjaGFyICprZXk7DQo+ID4gKwlz
dHJ1Y3QgbF9kYnVzX21lc3NhZ2VfaXRlciBvcHRpb25zLCB2YXI7DQo+ID4gIAljb25zdCBjaGFy
ICpzZW5kZXIgPSBsX2RidXNfbWVzc2FnZV9nZXRfc2VuZGVyKG1zZyk7DQo+ID4gIA0KPiA+ICAJ
aWYgKHN0cmNtcChzZW5kZXIsIG5vZGVfZ2V0X293bmVyKG5vZGUpKSkNCj4gPiAgCQlyZXR1cm4g
ZGJ1c19lcnJvcihtc2csIE1FU0hfRVJST1JfTk9UX0FVVEhPUklaRUQsIE5VTEwpOw0KPiA+ICAN
Cj4gPiAtCWlmICghbF9kYnVzX21lc3NhZ2VfZ2V0X2FyZ3VtZW50cyhtc2csICJxIiwgJmR1cmF0
aW9uKSkNCj4gPiArCWlmICghbF9kYnVzX21lc3NhZ2VfZ2V0X2FyZ3VtZW50cyhtc2csICJhe3N2
fSIsICZvcHRpb25zKSkNCj4gPiAgCQlyZXR1cm4gZGJ1c19lcnJvcihtc2csIE1FU0hfRVJST1Jf
SU5WQUxJRF9BUkdTLCBOVUxMKTsNCj4gPiAgDQo+ID4gKwl3aGlsZSAobF9kYnVzX21lc3NhZ2Vf
aXRlcl9uZXh0X2VudHJ5KCZvcHRpb25zLCAma2V5LCAmdmFyKSkgew0KPiA+ICsJCWJvb2wgZmFp
bGVkID0gdHJ1ZTsNCj4gPiArDQo+ID4gKwkJaWYgKCFzdHJjbXAoa2V5LCAiU2Vjb25kcyIpKSB7
DQo+ID4gKwkJCWlmIChsX2RidXNfbWVzc2FnZV9pdGVyX2dldF92YXJpYW50KCZ2YXIsICJxIiwN
Cj4gPiArCQkJCQkJCSAgICAmZHVyYXRpb24pKSB7DQo+ID4gKwkJCQlmYWlsZWQgPSBmYWxzZTsN
Cj4gPiArCQkJfQ0KPiA+ICsJCX0NCj4gDQo+IEkgdGhpbmsgZmFpbGluZyBpbiB0aGlzIGluIHRo
aXMgd2F5IGlzIG5vdCB0cnVlbHkgIkZvcndhcmQgQ29tcGF0aWJsZSIuIElmIGEga2V5IHRoYXQg
aXMgKm5vdCogU2Vjb25kcyBpcyBmb3VuZA0KPiBpbiB0aGUgZGljdGlvbmFyeSwgdGhpcyB3aWxs
IGFsd2F5cyByZXR1cm4gYW4gZXJyb3IuICBJIHRoaW5rIGl0IHdvdWxkIGJlIGJldHRlciBpZiB0
aGUga2V5IGlzIGlnbm9yZWQuDQo+IA0KPiBUaGUgb25seSAiZmFpbCIgY2FzZSBzaG91bGQgYmUg
aWYgYSBrZXkgaGFzIGEga25vd24gdmFsaWQsIGJ1dCBoYXMgYW4gaW5jb3JyZWN0IHR5cGUgKG5v
dCAicSIgaW4gdGhlIGNhc2Ugb2YNCj4gU2Vjb25kcyksIG9yIGlmIHRoZSBrZXkgaXMgc3VwcG9y
dGVkLCBidXQgdGhlIHZhbHVlIGlzIG91dHNpZGUgdGhlIGFjY2VwdGFibGUgcmFuZ2UgKGlzIHRo
ZXJlIGFuIGFjY2VwdGFibGUNCj4gcmFuZ2UgZm9yIHRoaXMpPw0KPiANCg0KIkZvcndhcmQgY29t
cGF0aWJsZSIgbWVhbnMgdGhhdCBmdXJ0aGVyIGtleXMgc2hhbGwgYmUgZG9jdW1lbnRlZCBpbg0K
bWVzaC1hcGkudHh0IGFuZCB0aGVuIGNvcnJlY3RseSBwcm9jZXNzZWQgYnkgdGhlIGRhZW1vbi4N
Ckkgd291bGQgcHJlZmVyIHRvIGZhaWwgb24gdW5yZWNvZ25pemVkIGtleXdvcmRzLg0KDQo+IFdl
IGFncmVlZCwgSSB0aGluaywgdGhhdCB0aGUgKm5vbiogZXhpc3RhbmNlIG9mIFNlY29uZHMgbWVh
bnMgIlVubGltaXRlZCIuDQoNCkVpdGhlciAwIG9yIGFic2Vuc2Ugb2YgJ1NlY29uZHMnIGtleXdv
cmQgbWVhbiBjb250aW51b3VzIHNjYW4uDQoNCj4gDQo+ID4gKw0KPiA+ICsJCWlmIChmYWlsZWQp
DQo+ID4gKwkJCXJldHVybiBkYnVzX2Vycm9yKG1zZywgTUVTSF9FUlJPUl9JTlZBTElEX0FSR1Ms
DQo+ID4gKwkJCQkJCQkiSW52YWxpZCBvcHRpb25zIik7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICAJ
aWYgKHNjYW5fbm9kZSAmJiBzY2FuX25vZGUgIT0gbm9kZSkNCj4gPiAgCQlyZXR1cm4gZGJ1c19l
cnJvcihtc2csIE1FU0hfRVJST1JfQlVTWSwgTlVMTCk7DQo+ID4gIA0KPiA+IEBAIC03NTIsMTMg
Kzc3MywxMyBAQCBzdGF0aWMgc3RydWN0IGxfZGJ1c19tZXNzYWdlICpzZXRfa2V5X3BoYXNlX2Nh
bGwoc3RydWN0IGxfZGJ1cyAqZGJ1cywNCj4gPiAgc3RhdGljIHZvaWQgc2V0dXBfbWFuYWdlbWVu
dF9pbnRlcmZhY2Uoc3RydWN0IGxfZGJ1c19pbnRlcmZhY2UgKmlmYWNlKQ0KPiA+ICB7DQo+ID4g
IAlsX2RidXNfaW50ZXJmYWNlX21ldGhvZChpZmFjZSwgIkFkZE5vZGUiLCAwLCBhZGRfbm9kZV9j
YWxsLCAiIiwNCj4gPiAtCQkJCQkJCQkiYXkiLCAidXVpZCIpOw0KPiA+ICsJCQkJCQkiYXlhe3N2
fSIsICJ1dWlkIiwgIm9wdGlvbnMiKTsNCj4gPiAgCWxfZGJ1c19pbnRlcmZhY2VfbWV0aG9kKGlm
YWNlLCAiSW1wb3J0UmVtb3RlTm9kZSIsIDAsIGltcG9ydF9ub2RlX2NhbGwsDQo+ID4gIAkJCQki
IiwgInF5YXkiLCAicHJpbWFyeSIsICJjb3VudCIsICJkZXZfa2V5Iik7DQo+ID4gIAlsX2RidXNf
aW50ZXJmYWNlX21ldGhvZChpZmFjZSwgIkRlbGV0ZVJlbW90ZU5vZGUiLCAwLCBkZWxldGVfbm9k
ZV9jYWxsLA0KPiA+ICAJCQkJCQkiIiwgInF5IiwgInByaW1hcnkiLCAiY291bnQiKTsNCj4gPiAg
CWxfZGJ1c19pbnRlcmZhY2VfbWV0aG9kKGlmYWNlLCAiVW5wcm92aXNpb25lZFNjYW4iLCAwLCBz
dGFydF9zY2FuX2NhbGwsDQo+ID4gLQkJCQkJCQkiIiwgInEiLCAic2Vjb25kcyIpOw0KPiA+ICsJ
CQkJCQkJIiIsICJhe3N2fSIsICJvcHRpb25zIik7DQo+ID4gIAlsX2RidXNfaW50ZXJmYWNlX21l
dGhvZChpZmFjZSwgIlVucHJvdmlzaW9uZWRTY2FuQ2FuY2VsIiwgMCwNCj4gPiAgCQkJCQkJY2Fu
Y2VsX3NjYW5fY2FsbCwgIiIsICIiKTsNCj4gPiAgCWxfZGJ1c19pbnRlcmZhY2VfbWV0aG9kKGlm
YWNlLCAiQ3JlYXRlU3VibmV0IiwgMCwgY3JlYXRlX3N1Ym5ldF9jYWxsLA0K
