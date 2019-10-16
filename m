Return-Path: <SRS0=8ZYm=YJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB9EFA3728
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Oct 2019 19:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1472064B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Oct 2019 19:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="tAnnBDiJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbfJPTdc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Oct 2019 15:33:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:19359 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728699AbfJPTdc (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Oct 2019 15:33:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 12:33:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,304,1566889200"; 
   d="scan'208";a="396007266"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga005.fm.intel.com with ESMTP; 16 Oct 2019 12:33:30 -0700
Received: from fmsmsx154.amr.corp.intel.com (10.18.116.70) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 16 Oct 2019 12:33:30 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX154.amr.corp.intel.com (10.18.116.70) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 16 Oct 2019 12:33:29 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.56) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 16 Oct 2019 12:33:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTl7SysAPAeEZOHOIkK+O6kNFoLK4RmeOd9YoN9nGVD4SdASUK1Ul1gMP8qf5ppVs9fmX8tsQGXMtIIoLwek9eSL+nLf/mfL+NKIw0GN1VTsYzalwddBLtiqHgQKjw7gEhmY5NA4ZOzQ7VnAYwVi+2vpttf1+jtjHlIHY2XIWggGTb5uaZ6RpLrZT4aRkRnTywmycmSWOPasPmjragOFnUczt8JEpPCEGy5CQsLlm/etHfPQYsUT+/xpeh0z43WkcTGa1nSaZqXDqQ74Orps8WrS6UPK6cc+K63+FLicr/pcRaIOAKYGigDNmQYDnx8rRZ03Q7sCswHq2opOwaw9xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVTKsV8EripHJljOQQ2LGQsqB5KDMOzJHaF7zDm77VE=;
 b=mPh88NgEWWKwCEZI4VozkVkUjQF5FS2JC/zVADvz5VamTqE9p1OHM4GBOSmZVXirDiAQyV5APFlTafRVeBh2ny93NWTnuIPQgaADLFIW8DlwiGobxMLYRcgjYOGX5iVQc3eAmFm7LQcG0+UjFRWZfWK/UXcpaLh8x1Ci0ToqcPFDFwLTlEId5ldkc46CW1x9vKCZi2aCc7pwtz1yX8fw5m9B3OhvsMxx654b+k9CVMgMOOaZthFTwZ9jSBh+tCVVTppEW0XC/97hz/rniY5dcFvE7tuBl6zN2az+T+b8YHj6o6qEFxYHv3gHuhflSXVzfeTmdTmPKEZBNez0qm5Lxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVTKsV8EripHJljOQQ2LGQsqB5KDMOzJHaF7zDm77VE=;
 b=tAnnBDiJEZyM2H/0tql2iZVcFpnSw+ae6ZAnjrgeEi4vG/BuN0RgnjsIOXe/T8Q9hIbVeIHDf5/av3V6t4O9OIzoZLi01MChVKYiLf3Y+xpaDI/gN7AquZN7uuntDoQzO/RHmQ8CZVwr8jB5LXjGOZAOFMySnT+IIV3wEvKLmE8=
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com (10.172.76.7) by
 CY4PR1101MB2183.namprd11.prod.outlook.com (10.172.76.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 16 Oct 2019 19:33:28 +0000
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::c6d:ebf:5ae2:7501]) by CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::c6d:ebf:5ae2:7501%10]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 19:33:28 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Add provisioner confirmation
Thread-Topic: [PATCH BlueZ] mesh: Add provisioner confirmation
Thread-Index: AQHVgtkfo9YoKP2ob0aAz7QZb86keKddq3eA
Date:   Wed, 16 Oct 2019 19:33:28 +0000
Message-ID: <b0aecfc65f18e4cef1a2aeebd655d75bd7d6cd5e.camel@intel.com>
References: <20191014214758.13829-1-inga.stotland@intel.com>
In-Reply-To: <20191014214758.13829-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa8d6610-a5eb-48d3-0bb7-08d7526fb86d
x-ms-traffictypediagnostic: CY4PR1101MB2183:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1101MB2183C5FB3742AF0E4B3CAE44E1920@CY4PR1101MB2183.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:353;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39850400004)(396003)(366004)(136003)(346002)(199004)(189003)(256004)(66476007)(25786009)(66556008)(4001150100001)(76116006)(7736002)(305945005)(86362001)(66446008)(91956017)(118296001)(478600001)(64756008)(6486002)(66946007)(110136005)(14444005)(2906002)(229853002)(316002)(5660300002)(11346002)(81166006)(99286004)(446003)(6116002)(36756003)(8936002)(3846002)(14454004)(476003)(26005)(6512007)(6246003)(8676002)(486006)(71190400001)(2616005)(71200400001)(6436002)(6506007)(102836004)(2501003)(81156014)(6636002)(66066001)(76176011)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1101MB2183;H:CY4PR1101MB2262.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VeJLsaqpbWaHlpj4mQQPM+UL0S/68KZS0QiNSn+2IK75CNEn/S+LsyCrBMMu4Sd138jzu6S9S7qwuwqeUdLGKljvmgf2I1oDirZWdUkpwx9hXhXABpJ7qDvBuO/kyce8Oz+e7+YwweSpJUr1jcoNE6bcfvhyyJuvW/+gp63LboJZEcbnK9Kh2krMv9PVodSPuF9HkEVkuq4PEt4PPV28jq7imJTVAcI8YwES7zYH+v/fwUp7XGOPEb8nM4xD0GjXn3HFhyC8fr/JiNzjopSc4BDovPncRapsr49FxwLqH7Cryx0GLU0z+eJYwmoof8dcMnskZPCJb1ucYdPpOHVBFgoZotO0hMn9DYs3Ep1xai6PmJphEeFBBaLa95xtm6MmySHGS6dSfa5TXbuvPhmx72z9oH/jjy4w3ysAazIAy6Y=
Content-Type: text/plain; charset="utf-8"
Content-ID: <16EEDF73845AF948B214E3A571F9F96D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8d6610-a5eb-48d3-0bb7-08d7526fb86d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2019 19:33:28.4396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SRNO2UGLo3D41e0MvXXi8jMY/CWXwu4IfDHUNPIepS8TbJY5YA0Xb4lsGvoKKbeoIMIS7ewyG4tFh7+8J/+JTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2183
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBNb24sIDIwMTktMTAtMTQgYXQgMTQ6NDcgLTA3MDAsIEluZ2EgU3RvdGxh
bmQgd3JvdGU6DQo+IFRoaXMgYWRkcyBjb2RlcyB0byBzZW5kIGEgY29uZmlybWF0aW9uZnJvbSBw
cm92aXNpb25lcidzIHNpZGUNCj4gYWZ0ZXIgcmVjZWl2aW5nIGEgY2FsbGJhY2sgZnJvbSBhIHBy
b3Zpc2lvbmluZyBhZ2VudC4NCj4gDQo+IC0tLQ0KPiAgbWVzaC9wcm92LWluaXRpYXRvci5jIHwg
MzYgKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMjAgaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
bWVzaC9wcm92LWluaXRpYXRvci5jIGIvbWVzaC9wcm92LWluaXRpYXRvci5jDQo+IGluZGV4IGVi
NTlmNTNmMS4uNWU0NWQ2ODEzIDEwMDY0NA0KPiAtLS0gYS9tZXNoL3Byb3YtaW5pdGlhdG9yLmMN
Cj4gKysrIGIvbWVzaC9wcm92LWluaXRpYXRvci5jDQo+IEBAIC0yNjUsNiArMjY1LDE4IEBAIHN0
YXRpYyB2b2lkIGNhbGNfbG9jYWxfbWF0ZXJpYWwoY29uc3QgdWludDhfdCAqcmFuZG9tKQ0KPiAg
CXByaW50X3BhY2tldCgiTm9uY2UiLCBwcm92LT5zX25vbmNlLCBzaXplb2YocHJvdi0+c19ub25j
ZSkpOw0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgdm9pZCBzZW5kX2NvbmZpcm0oc3RydWN0IG1lc2hf
cHJvdl9pbml0aWF0b3IgKnByb3YpDQo+ICt7DQo+ICsJc3RydWN0IHByb3ZfY29uZl9tc2cgbXNn
Ow0KPiArDQo+ICsJbXNnLm9wY29kZSA9IFBST1ZfQ09ORklSTTsNCj4gKwltZXNoX2NyeXB0b19h
ZXNfY21hYyhwcm92LT5jYWxjX2tleSwgcHJvdi0+cmFuZF9hdXRoX3dvcmtzcGFjZSwNCj4gKwkJ
CTMyLCBtc2cuY29uZik7DQo+ICsJcHJvdi0+dHJhbnNfdHgocHJvdi0+dHJhbnNfZGF0YSwgJm1z
Zywgc2l6ZW9mKG1zZykpOw0KPiArCXByb3YtPnN0YXRlID0gSU5UX1BST1ZfQ09ORl9TRU5UOw0K
PiArCXByb3YtPmV4cGVjdGVkID0gUFJPVl9DT05GSVJNOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMg
dm9pZCBudW1iZXJfY2Iodm9pZCAqdXNlcl9kYXRhLCBpbnQgZXJyLCB1aW50MzJfdCBudW1iZXIp
DQo+ICB7DQo+ICAJc3RydWN0IG1lc2hfcHJvdl9pbml0aWF0b3IgKnJ4X3Byb3YgPSB1c2VyX2Rh
dGE7DQo+IEBAIC0yODQsNiArMjk2LDcgQEAgc3RhdGljIHZvaWQgbnVtYmVyX2NiKHZvaWQgKnVz
ZXJfZGF0YSwgaW50IGVyciwgdWludDMyX3QgbnVtYmVyKQ0KPiAgCWxfcHV0X2JlMzIobnVtYmVy
LCBwcm92LT5yYW5kX2F1dGhfd29ya3NwYWNlICsgMjgpOw0KPiAgCWxfcHV0X2JlMzIobnVtYmVy
LCBwcm92LT5yYW5kX2F1dGhfd29ya3NwYWNlICsgNDQpOw0KPiAgCXByb3YtPm1hdGVyaWFsIHw9
IE1BVF9SQU5EX0FVVEg7DQo+ICsJc2VuZF9jb25maXJtKHByb3YpOw0KPiAgfQ0KPiAgDQo+ICBz
dGF0aWMgdm9pZCBzdGF0aWNfY2Iodm9pZCAqdXNlcl9kYXRhLCBpbnQgZXJyLCB1aW50OF90ICpr
ZXksIHVpbnQzMl90IGxlbikNCj4gQEAgLTMwNCw2ICszMTcsNyBAQCBzdGF0aWMgdm9pZCBzdGF0
aWNfY2Iodm9pZCAqdXNlcl9kYXRhLCBpbnQgZXJyLCB1aW50OF90ICprZXksIHVpbnQzMl90IGxl
bikNCj4gIAltZW1jcHkocHJvdi0+cmFuZF9hdXRoX3dvcmtzcGFjZSArIDE2LCBrZXksIDE2KTsN
Cj4gIAltZW1jcHkocHJvdi0+cmFuZF9hdXRoX3dvcmtzcGFjZSArIDMyLCBrZXksIDE2KTsNCj4g
IAlwcm92LT5tYXRlcmlhbCB8PSBNQVRfUkFORF9BVVRIOw0KPiArCXNlbmRfY29uZmlybShwcm92
KTsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIHZvaWQgcHViX2tleV9jYih2b2lkICp1c2VyX2RhdGEs
IGludCBlcnIsIHVpbnQ4X3QgKmtleSwgdWludDMyX3QgbGVuKQ0KPiBAQCAtMzIxLDExICszMzUs
MTMgQEAgc3RhdGljIHZvaWQgcHViX2tleV9jYih2b2lkICp1c2VyX2RhdGEsIGludCBlcnIsIHVp
bnQ4X3QgKmtleSwgdWludDMyX3QgbGVuKQ0KPiAgCQlyZXR1cm47DQo+ICAJfQ0KPiAgDQo+IC0J
CW1lbWNweShwcm92LT5jb25mX2lucHV0cy5kZXZfcHViX2tleSwga2V5LCA2NCk7DQo+IC0JCXBy
b3YtPm1hdGVyaWFsIHw9IE1BVF9SRU1PVEVfUFVCTElDOw0KPiArCW1lbWNweShwcm92LT5jb25m
X2lucHV0cy5kZXZfcHViX2tleSwga2V5LCA2NCk7DQo+ICsJcHJvdi0+bWF0ZXJpYWwgfD0gTUFU
X1JFTU9URV9QVUJMSUM7DQo+ICANCj4gLQkJaWYgKChwcm92LT5tYXRlcmlhbCAmIE1BVF9TRUNS
RVQpID09IE1BVF9TRUNSRVQpDQo+IC0JCQlpbnRfY3JlZGVudGlhbHMocHJvdik7DQo+ICsJaWYg
KChwcm92LT5tYXRlcmlhbCAmIE1BVF9TRUNSRVQpID09IE1BVF9TRUNSRVQpDQo+ICsJCWludF9j
cmVkZW50aWFscyhwcm92KTsNCj4gKw0KPiArCXNlbmRfY29uZmlybShwcm92KTsNCj4gIH0NCj4g
IA0KPiAgc3RhdGljIHZvaWQgc2VuZF9wdWJfa2V5KHN0cnVjdCBtZXNoX3Byb3ZfaW5pdGlhdG9y
ICpwcm92KQ0KPiBAQCAtMzM4LDE4ICszNTQsNiBAQCBzdGF0aWMgdm9pZCBzZW5kX3B1Yl9rZXko
c3RydWN0IG1lc2hfcHJvdl9pbml0aWF0b3IgKnByb3YpDQo+ICAJcHJvdi0+c3RhdGUgPSBJTlRf
UFJPVl9LRVlfU0VOVDsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIHZvaWQgc2VuZF9jb25maXJtKHN0
cnVjdCBtZXNoX3Byb3ZfaW5pdGlhdG9yICpwcm92KQ0KPiAtew0KPiAtCXN0cnVjdCBwcm92X2Nv
bmZfbXNnIG1zZzsNCj4gLQ0KPiAtCW1zZy5vcGNvZGUgPSBQUk9WX0NPTkZJUk07DQo+IC0JbWVz
aF9jcnlwdG9fYWVzX2NtYWMocHJvdi0+Y2FsY19rZXksIHByb3YtPnJhbmRfYXV0aF93b3Jrc3Bh
Y2UsDQo+IC0JCQkzMiwgbXNnLmNvbmYpOw0KPiAtCXByb3YtPnRyYW5zX3R4KHByb3YtPnRyYW5z
X2RhdGEsICZtc2csIHNpemVvZihtc2cpKTsNCj4gLQlwcm92LT5zdGF0ZSA9IElOVF9QUk9WX0NP
TkZfU0VOVDsNCj4gLQlwcm92LT5leHBlY3RlZCA9IFBST1ZfQ09ORklSTTsNCj4gLX0NCj4gLQ0K
PiAgc3RhdGljIHZvaWQgc2VuZF9yYW5kb20oc3RydWN0IG1lc2hfcHJvdl9pbml0aWF0b3IgKnBy
b3YpDQo+ICB7DQo+ICAJc3RydWN0IHByb3ZfcmFuZF9tc2cgbXNnOw0K
