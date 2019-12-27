Return-Path: <SRS0=NQWU=2R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CE1C2D0C6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Dec 2019 17:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9109E208C4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Dec 2019 17:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="PyP8nx3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfL0RIa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:08:30 -0500
Received: from mga03.intel.com ([134.134.136.65]:56458 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfL0RIa (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Dec 2019 12:08:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Dec 2019 09:08:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,363,1571727600"; 
   d="scan'208";a="418317575"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga005.fm.intel.com with ESMTP; 27 Dec 2019 09:08:28 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 27 Dec 2019 09:08:28 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 27 Dec 2019 09:08:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfV1fLMYoAOHpnzcbvl77BQE90Ztm8sIRq18Jsfga2A8cGLwMxBUY++XhDMjjGrDkWpyp9ifoZ3+baAtk4u8I4+gtGKTNeoN404o0efJSMvpnQXL0hPTTB/IVofn2EnaC4AS41igzsHeSTO4zfQTwZbjgT14Ll1NoGc68e2z5dzsfZXFMCKCZ4WiwcJoTw7xcjiY9lrrWAFbtQuEYmvYOaxUbMfZZ0VrmxBYwvpZTwMz6Y7cKDdyjCns/8Qd5I9VjiFj3BobDSF+HmkcQk2SemOBlCH9RFyJwJO6nyXqtRgX5+ILLVosx8kqz4AleSyNqTRkV/btWB7Julwovortuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1N7KFkcPBCnegR5sglflwbX9fQpv/fDnSEgTWOhONOo=;
 b=airXytfh644ysvfeOi0usVBMQufeZdWk78X7E/T2z1jwBYywiZNQPKD/ruVZD3OdsJ2uvMeYppS4PZ45Vvov/qVFZo0hFXdozwjtfB55lC8WmYdS72LOpQgUWBIurghbzlIpAsf0hYGk5n/kHS3uM49EBIErrh9Raq1uAKGCZsoxP9Gl8hQZtnC/XCSK8FxFQwlfdpZeRZITw3nzN2idccySJQ+Z+KRB8hFGSYxtQHN5CYGq839/2MUG0x7UAbl6OYTsK4n9D080HwamHqHA0a76VAYh9oAWF3DEq9DOaKYheZ9OW2Yw0VgxYQoOYuVb/AUBlvnAd+Mw1a2flGXjNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1N7KFkcPBCnegR5sglflwbX9fQpv/fDnSEgTWOhONOo=;
 b=PyP8nx3VmkxPvI7vuchGPnfEDcqu/qs3ng/JRgwllyWiz2NsIAO0DetjGVGonCMNpcZQP8N3MEuLcnzDB5xmqua8okmOHKEto5c4i8yJmluHcaQe/RivB+jEXyur1mJoIdXzzfV538Xt7Zgr8GseX5fT3YVv8vHmq1EvJTcZUDk=
Received: from CY4PR11MB1269.namprd11.prod.outlook.com (10.173.16.11) by
 CY4PR11MB1608.namprd11.prod.outlook.com (10.172.71.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.12; Fri, 27 Dec 2019 17:08:26 +0000
Received: from CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::39e0:30e9:a8b0:fe24]) by CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::39e0:30e9:a8b0:fe24%3]) with mapi id 15.20.2559.017; Fri, 27 Dec 2019
 17:08:26 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "prathyusha.n@samsung.com" <prathyusha.n@samsung.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/1] mesh: Start link establishment timer of 60 sec
Thread-Topic: [PATCH 1/1] mesh: Start link establishment timer of 60 sec
Thread-Index: AQHVq+sArrbuZvD8ek6ka+Km0o046KfOWKgA
Date:   Fri, 27 Dec 2019 17:08:25 +0000
Message-ID: <8842dab4b7c0fbd8dd5674b8286a7593c419ea5e.camel@intel.com>
References: <CGME20191206040900epcas5p2ccb274134dab1154452d6f8d75dfedac@epcas5p2.samsung.com>
         <1575605319-461-1-git-send-email-prathyusha.n@samsung.com>
In-Reply-To: <1575605319-461-1-git-send-email-prathyusha.n@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ec17c7e-0dc9-4e01-b44e-08d78aef632d
x-ms-traffictypediagnostic: CY4PR11MB1608:
x-microsoft-antispam-prvs: <CY4PR11MB160896A10251FD455A9AF86CE12A0@CY4PR11MB1608.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0264FEA5C3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39860400002)(396003)(136003)(199004)(189003)(66476007)(66946007)(76116006)(91956017)(4744005)(64756008)(66556008)(66446008)(36756003)(2616005)(186003)(26005)(6506007)(5660300002)(8936002)(110136005)(81156014)(81166006)(8676002)(478600001)(316002)(6486002)(2906002)(6512007)(86362001)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR11MB1608;H:CY4PR11MB1269.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BEIdrfRU9uK9qiBCX0RktB/doE7DmCWXhoPD85h+njqvxAqFy9N1vlDTh3VsWpKigvyeKOLrr8DxEZXWKUevFNZ3jZ/7lwac/KKFs/KhuUq5tvQ3RhatkuGfkkPmhVCgKsXtZfmWGN4MRdKD1oivHuMeNbKEj247D1VV9ZQY1eVAofjhaiS8XKHC3au+DJZ1zCSevTl7E708svLq7d11KNcfHPJrU6N+lR4IqcJmKWZomnswyi9dfrV5HjtsaDH4hJRPhX2jqEnGUjdvSLWroC3F1ImAU8N1aYpPZaPpG6e9TRIdCQgr+v0oK1E/yp6wDJWIVhH5lJ0ybqCRVfaiZ4hOl6KlYCiDIftQu9ASR/btBdCsIIM+ezEJzkrcYaxKo5a/PIYbgul5tYquIKKCp8u5qH8l0nvdpLfudrrNw4GKB1FtnozFQtvn+1AJQKaX
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3AE2D82AB8F4F408D7C9308C7AEA1B0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec17c7e-0dc9-4e01-b44e-08d78aef632d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2019 17:08:26.0131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MImB6+WZ/oYhTFvxEa9KLYPNlXd7LqGxTuA2jQZWGUKMHXX+A1phYe52BaKofC0acqxRHLxpfAB7YGSZehbXnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1608
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBGcmksIDIwMTktMTItMDYgYXQgMDk6MzggKzA1MzAsIFByYXRoeXVzaGEg
TmVsbHVyaSB3cm90ZToNCj4gRnJvbTogUHJhdGh5dXNoYSBOIDxwcmF0aHl1c2hhLm5Ac2Ftc3Vu
Zy5jb20+DQo+IA0KPiA1LjMuMiBvZiBNZXNoIFByb2ZpbGUgQmx1ZXRvb3RoIHNwZWNpZmljYXRp
b246DQo+IFRvIG9wZW4gYSBsaW5rLCB0aGUgcHJvdmlzaW9uZXIgc2hhbGwgc3RhcnQgdGhlIGxp
bmsgZXN0YWJsaXNobWVudA0KPiB0aW1lciwgc2V0IHRvIDYwIHNlY29uZHMsIGFuZCB0aGVuIHNo
YWxsIHN0YXJ0IHNlbmRpbmcgTGluayBPcGVuDQo+IG1lc3NhZ2VzLg0KPiANCj4gT24gdGltZW91
dCwgY2xvc2UgaW5kaWNhdGlvbiB3aWxsIGJlIHNlbnQuIFByb3Zpc2lvbmVyIGNhbmNlbHMgdGhl
DQo+IExpbmsgRXN0YWJsaXNobWVudCB0aW1lciwgd2hlbiB0aGUgbGluayBpcyBvcGVuIGkuZS4g
aW4gcGJfYWR2X3R4KCkuDQo+IC0tLQ0KPiAgbWVzaC9wYi1hZHYuYyB8IDIgKysNCj4gIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9tZXNoL3BiLWFk
di5jIGIvbWVzaC9wYi1hZHYuYw0KPiBpbmRleCAyN2NiYzQ2Li5jOWEyYTY1IDEwMDY0NA0KPiAt
LS0gYS9tZXNoL3BiLWFkdi5jDQo+ICsrKyBiL21lc2gvcGItYWR2LmMNCj4gQEAgLTQ1OCw2ICs0
NTgsOCBAQCBib29sIHBiX2Fkdl9yZWcoYm9vbCBpbml0aWF0b3IsIG1lc2hfcHJvdl9vcGVuX2Z1
bmNfdCBvcGVuX2NiLA0KPiAgDQo+ICAJaWYgKGluaXRpYXRvcikgew0KPiAgCQlsX2dldHJhbmRv
bSgmcGJfc2Vzc2lvbi0+bGlua19pZCwgc2l6ZW9mKHBiX3Nlc3Npb24tPmxpbmtfaWQpKTsNCj4g
KwkJcGJfc2Vzc2lvbi0+dHhfdGltZW91dCA9IGxfdGltZW91dF9jcmVhdGUoNjAsIHR4X3RpbWVv
dXQsDQo+ICsJCQkJCQkJcGJfc2Vzc2lvbiwgTlVMTCk7DQo+ICAJCXNlbmRfb3Blbl9yZXEocGJf
c2Vzc2lvbik7DQo+ICAJfQ0KPiAgDQo=
