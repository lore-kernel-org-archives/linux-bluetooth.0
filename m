Return-Path: <SRS0=vBm7=XV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1D5C4360C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Sep 2019 23:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8089B207E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Sep 2019 23:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="cpHVkoju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbfIZX1i (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Sep 2019 19:27:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:22341 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728441AbfIZX1i (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Sep 2019 19:27:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2019 16:27:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,553,1559545200"; 
   d="scan'208";a="194297467"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga006.jf.intel.com with ESMTP; 26 Sep 2019 16:27:36 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Sep 2019 16:27:36 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.54) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 26 Sep 2019 16:27:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R17HMeYx4Stnf3fKxTh26+2JE5WzDUdPdlSph5EFlp1u28fa57E9HolzctPQeINvjirerJjgodkmIpb/c4lm0jA1pNafYBsa8gumjXmrqze5i7r+TE+GO51ZlCGuMdMUpphD0+WDqPKnPW+1qqGPc8SQZ0C69EcQAqkOOy8n4/fGY+UeVOfVHfdkyr+AtYmnpzNyLFMhFnu4cOBsr5KfgSopVfpGC/A75SB63/HP/rLM69PoG1M/6jDRz0gwO57kkZ6yrhLSLwmONPq7W6b/t2S9aYV6YVuep4nje49TSMRQsWR60XiC4oyGcqdpn8I2WIV3lf5hFY02a6/KBdWu6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXVSDh+BlsrixarUZr4SHMdm4C5EMqNNqv8vZH/8HhY=;
 b=hRlscZYS6ZNbQDHfvp/ehv+OXebvIaYpqb+GSAezrxJhWJ0bAbgaXkULaggT9lqnJAVTxmhYCdJ9BfMnmb9Xf5Jk9lCgjyB4hzs4vKA6gpLkSMl0/mQZeTeqIBcu1OGIRn9K8lWjnCCv7AZw/xBBcsTMENakfJuwuxm80MoLj3aJXV8b/yjorK7IZEnI3ppexbhJychUMfeZ0SHqan5J/gne0H+DOFC8OBMfum+HmG35sYc3yv7zqbmHLmPNmdbTH6qTXmqUsE1KBZjB28pTRocqVps3mjm/Y5l0skAS+vZttwPrjo3P7byM2uwLYLc/ShG6jIuL8Ol0KknKsy13rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXVSDh+BlsrixarUZr4SHMdm4C5EMqNNqv8vZH/8HhY=;
 b=cpHVkojuCpVLb5IcCKQp3bISS9pMBJUMt90622mOSuCLMIUo4ib3b0bp4frh1ejHzoIitEsDD3oSPL6mFlSZfI3lmaebj9O67E1xdCDjROupkx9PapSGyYd2/eWgIO7fOQGvtZdy7c1b4R5hKzY3FbX75h7/Cq33gf8+KJTNhjQ=
Received: from DM6PR11MB4412.namprd11.prod.outlook.com (52.132.248.86) by
 DM6PR11MB3417.namprd11.prod.outlook.com (20.177.219.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.18; Thu, 26 Sep 2019 23:27:34 +0000
Received: from DM6PR11MB4412.namprd11.prod.outlook.com
 ([fe80::5d45:636:6a4a:9397]) by DM6PR11MB4412.namprd11.prod.outlook.com
 ([fe80::5d45:636:6a4a:9397%7]) with mapi id 15.20.2305.017; Thu, 26 Sep 2019
 23:27:34 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
Subject: Re: [PATCH BlueZ v3 3/3] mesh: Fix Key Ring permissions for local
 nodes
Thread-Topic: [PATCH BlueZ v3 3/3] mesh: Fix Key Ring permissions for local
 nodes
Thread-Index: AQHVdJZu+Q6WMhtc1U2FzjOdDnTbiKc+bDwAgAAuiIA=
Date:   Thu, 26 Sep 2019 23:27:34 +0000
Message-ID: <0a384749e155689d7981a443059d6cb5a6522f75.camel@intel.com>
References: <20190926181444.4916-1-brian.gix@intel.com>
         <20190926181444.4916-4-brian.gix@intel.com>
         <3c389010afa470574d5a90a4dc31a2bad9c26e84.camel@intel.com>
In-Reply-To: <3c389010afa470574d5a90a4dc31a2bad9c26e84.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 280473c6-1380-4b0a-8b0b-08d742d91c47
x-ms-traffictypediagnostic: DM6PR11MB3417:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3417A151A9951A6623BB6743E1860@DM6PR11MB3417.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(136003)(396003)(376002)(189003)(199004)(446003)(8676002)(36756003)(4326008)(6512007)(14454004)(6436002)(25786009)(66066001)(11346002)(486006)(2616005)(5660300002)(2501003)(186003)(76176011)(6116002)(3846002)(256004)(476003)(478600001)(14444005)(26005)(7736002)(102836004)(71200400001)(6636002)(6506007)(316002)(2906002)(6246003)(71190400001)(66446008)(8936002)(81166006)(99286004)(81156014)(66946007)(66476007)(66556008)(229853002)(76116006)(64756008)(305945005)(86362001)(118296001)(110136005)(91956017)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR11MB3417;H:DM6PR11MB4412.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PWnHpaU4S8AB1CNL92zpf8M4E0WJf2xzuyOA4/riT/dwKdFIFpMKUzA48I9J55uQ8PfpKdJ6wX0ApBskLnNTxVf++/rrXx4WUgiOSQZRiMhnE6z2cwghkOHqEPcbzKjbSCHkRN3H84NRPXfm4e8WfP25ssePTxNenzT0BuLjJR2qQXr52GfAxglOYQOK/NnxPECqu4R2KOnuzBFad+Qowq5HVJlQmG79m2R8NofEHHU8SyDRt0ra98RRbJOgWU1H8Dg+rS2BaO6qX+8smdLuKyP27qNK37OdF27bkUh23PNAm6/wQpn3ZmcwTYHTl1YzWEbCWL86d1xQDcS9CdHg4ubrMwrN5Vh+X9JzKBACL7teiKUxsiQkJWHdDE9PawudQ/c8sc6A3hJWXoO7I8KapM6G98ipqy+dMva/hKaJRmY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9CF652954D07B24ABE9571C3E9971C58@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 280473c6-1380-4b0a-8b0b-08d742d91c47
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 23:27:34.4352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QSxm03VlA8wtH9MeAgRsbL6+KETWCXoM6VFDjK925dWpgrwnaQvkZYdV3eMRwMBiXmgKIb+/KJt/fYbFsi2WEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3417
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

T24gVGh1LCAyMDE5LTA5LTI2IGF0IDIwOjQxICswMDAwLCBTdG90bGFuZCwgSW5nYSB3cm90ZToN
Cj4gSGkgQnJpYW4sDQo+IA0KPiBPbiBUaHUsIDIwMTktMDktMjYgYXQgMTE6MTQgLTA3MDAsIEJy
aWFuIEdpeCB3cm90ZToNCj4gPiBXZSBkbyAqbm90KiBhdXRvbWF0aWNhbGx5IGNyZWF0ZSBwb3B1
bGF0ZWQga2V5IHJpbmdzIGZvciBpbXBvcnRlZCBvcg0KPiA+IGpvaW5lZCBub2RlcywgDQo+IA0K
PiBXaHkgbm90IGZvciBJbXBvcnQoKT8gU2luY2UgYm90aCB0aGUgRGV2S2V5IGFuZCBOZXRLZXkg
YXJlIGluIHRoZQ0KPiBwb3NzZXNpb24gb2YgdGhlIG5vZGUuLi4NCg0KVGhlcmUgYXJlIHR3byAo
a25vd24pIHVzZSBjYXNlcyBmb3IgSW1wb3J0KCkNCg0KMS4gTm9kZSBwcmV2aW91c2x5IGV4aXN0
ZWQgb24gYSBkaWZmZXJlbnQgcGh5c2ljYWwgcGllY2Ugb2YgaGFyZHdhcmUsIGFuZCBpcyBiZWlu
ZyBtaWdyYXRlZCB0byB0aGlzIGRhZW1vbi4NCg0KMi4gTm9kZSB3YXMgbmV3bHkgcHJvdmlzaW9u
ZWQgT3V0LU9mLUJhbmQsIGFuZCB0aGlzIGlzIHRoZSBuZXQgcmVzdWx0IG9mIHRoZSBwcm92aXNp
b25pbmcuDQoNCkluICpuZWl0aGVyKiBjYXNlIGlzIGl0IGEgZ2l2ZW4gdGhhdCB0aGUgTm9kZSBz
aG91bGQgYmUgYWJsZSB0byBwcm92aXNpb24gYW5vdGhlciBub2RlICh0aGUgZWZmZWN0IG9mIGFk
ZGluZw0KdGhlIE5ldCBLZXkgdG8gdGhlIGtleSByaW5nKS4gSW4gbmVpdGhlciBjYXNlIGlzIGl0
IGEgZ2l2ZW4gdGhhdCB0aGUgTm9kZSBzaG91bGQgYmUgYWJsZSB0byBtb2RpZnkgaXQncyBvd24N
CkNvbmZpZyBTZXJ2ZXIgc3RhdGVzICh0aGUgZWZmZWN0IG9mIGFkZGluZyBpdCdzIERldmljZSBL
ZXkgdG8gdGhlIGtleSByaW5nKS4NCg0KSG93ZXZlciwgaWYgaXQgKmlzKiB0aGUgY2FzZSB0aGF0
IG9uZSBvciBtb3JlIG9mIHRoZXNlIG9wZXJhdGlvbnMgc2hvdWxkIGJlIGF2YWlsYWJsZSB0byB0
aGUgTm9kZSwgdGhlDQpBcHBsaWNhdGlvbiB0aGF0IHBlcmZvcm1lZCB0aGUgSW1wb3J0IG1heSBj
YWxsIHRoZSBJbXBvcnRTdWJuZXQoKSBhbmQvb3IgdGhlIEltcG9ydFJlbW90ZU5vZGUoKSBtZXRo
b2RzLiBJbg0KYWN0dWFsaXR5LCBpZiB0aGlzIHdhcyB0aGUgaW50ZW50IChwYXJ0aWN1bGFyaWx5
IG9uIGEgTm9kZSBiZWluZyBtaWdyYXRlZCkgYSBrZXktcmluZyBvZiBzb21lIHNvcnQgc2hvdWxk
IGhhdmUNCmV4aXN0ZWQgb24gdGhlIG90aGVyIHBoeXNpY2FsIHBpZWNlIG9mIGhhcmR3YXJlLg0K
DQoNClRoZSBwb2ludCBvZiB0aGlzIGxhcmdlciBwYXRjaC1zZXQgaXMgdG8gbm8gbG9uZ2VyIGFz
c3VtZSB0aGF0IGV2ZXJ5IE5vZGUgaGFzIHRoZSBhYmlsaXR5IHRvIHVzZSBpdCdzIG93bg0KbmV0
d29yayBrZXlzIHRvIHByb3Zpc2lvbiBvdGhlciBub2Rlcywgb3IgdXNlIGl0J3Mgb3duIERldmlj
ZSBLZXkgdG8gY2hhbmdlIGl0J3Mgb3duIENvbmZpZyBTZXJ2ZXIgc3RhdGVzLg0KDQpZZXMsIHRo
YXQgY2FuIHN0aWxsIGhhcHBlbiAoYXMgaXQgY2FuIHdpdGggbm9uIEJsdWVaIG5vZGVzKSBidXQg
aXQgc2hvdWxkIGJlIGJ5IGEgZGVsaWJlcmF0ZSBtZWNoYW5pc20sIG5vdCBhcw0KYSAidGltZSBz
YXZpbmcgZGVmYXVsdCIuDQoNCg0KDQo+ID4gYnV0IHdlIGFsc28gZG8gbm90ICpmb3JiaWQqIGFu
eSBub2RlIGZyb20gYWRkaW5nIGEga2V5DQo+ID4gaW4gaXQncyBwb3NzZXNpb24gdG8gdGhlIGxv
Y2FsIGtleSByaW5nLg0KPiA+IC0tLQ0KPiA+ICBtZXNoL21hbmFnZXIuYyB8ICA1IC0tLS0tDQo+
ID4gIG1lc2gvbm9kZS5jICAgIHwgMTUgLS0tLS0tLS0tLS0tLS0tDQo+ID4gIDIgZmlsZXMgY2hh
bmdlZCwgMjAgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL21lc2gvbWFuYWdl
ci5jIGIvbWVzaC9tYW5hZ2VyLmMNCj4gPiBpbmRleCA1MDFlYzEwZmUuLjYzMzU5NzY1OSAxMDA2
NDQNCj4gPiAtLS0gYS9tZXNoL21hbmFnZXIuYw0KPiA+ICsrKyBiL21lc2gvbWFuYWdlci5jDQo+
ID4gQEAgLTI4Miw3ICsyODIsNiBAQCBzdGF0aWMgc3RydWN0IGxfZGJ1c19tZXNzYWdlDQo+ID4g
KmltcG9ydF9ub2RlX2NhbGwoc3RydWN0IGxfZGJ1cyAqZGJ1cywNCj4gPiAgCQkJCQkJdm9pZCAq
dXNlcl9kYXRhKQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3QgbWVzaF9ub2RlICpub2RlID0gdXNlcl9k
YXRhOw0KPiA+IC0Jc3RydWN0IG1lc2hfbmV0ICpuZXQgPSBub2RlX2dldF9uZXQobm9kZSk7DQo+
ID4gIAlzdHJ1Y3QgbF9kYnVzX21lc3NhZ2VfaXRlciBpdGVyX2tleTsNCj4gPiAgCXVpbnQxNl90
IHByaW1hcnk7DQo+ID4gIAl1aW50OF90IG51bV9lbGU7DQo+ID4gQEAgLTI5OCwxMCArMjk3LDYg
QEAgc3RhdGljIHN0cnVjdCBsX2RidXNfbWVzc2FnZQ0KPiA+ICppbXBvcnRfbm9kZV9jYWxsKHN0
cnVjdCBsX2RidXMgKmRidXMsDQo+ID4gIAkJcmV0dXJuIGRidXNfZXJyb3IobXNnLCBNRVNIX0VS
Uk9SX0lOVkFMSURfQVJHUywNCj4gPiAgCQkJCQkJCSJCYWQgZGV2aWNlDQo+ID4ga2V5Iik7DQo+
ID4gIA0KPiA+IC0JaWYgKG1lc2hfbmV0X2lzX2xvY2FsX2FkZHJlc3MobmV0LCBwcmltYXJ5LCBu
dW1fZWxlKSkNCj4gPiAtCQlyZXR1cm4gZGJ1c19lcnJvcihtc2csIE1FU0hfRVJST1JfSU5WQUxJ
RF9BUkdTLA0KPiA+IC0JCQkJCSJDYW5ub3Qgb3ZlcndyaXRlIGxvY2FsIGRldmljZQ0KPiA+IGtl
eSIpOw0KPiA+IC0NCj4gPiAgCWlmICgha2V5cmluZ19wdXRfcmVtb3RlX2Rldl9rZXkobm9kZSwg
cHJpbWFyeSwgbnVtX2VsZSwga2V5KSkNCj4gPiAgCQlyZXR1cm4gZGJ1c19lcnJvcihtc2csIE1F
U0hfRVJST1JfRkFJTEVELCBOVUxMKTsNCj4gPiAgDQo+ID4gZGlmZiAtLWdpdCBhL21lc2gvbm9k
ZS5jIGIvbWVzaC9ub2RlLmMNCj4gPiBpbmRleCA4MzMzNzdlOTkuLmFmNDVhNjEzMCAxMDA2NDQN
Cj4gPiAtLS0gYS9tZXNoL25vZGUuYw0KPiA+ICsrKyBiL21lc2gvbm9kZS5jDQo+ID4gQEAgLTE2
ODEsNyArMTY4MSw2IEBAIHN0YXRpYyB2b2lkIGdldF9tYW5hZ2VkX29iamVjdHNfY2Ioc3RydWN0
DQo+ID4gbF9kYnVzX21lc3NhZ2UgKm1zZywgdm9pZCAqdXNlcl9kYXRhKQ0KPiA+ICANCj4gPiAg
CX0gZWxzZSBpZiAocmVxLT50eXBlID09IFJFUVVFU1RfVFlQRV9JTVBPUlQpIHsNCj4gPiAgCQlz
dHJ1Y3Qgbm9kZV9pbXBvcnQgKmltcG9ydCA9IHJlcS0+aW1wb3J0Ow0KPiA+IC0JCXN0cnVjdCBr
ZXlyaW5nX25ldF9rZXkgbmV0X2tleTsNCj4gPiAgDQo+ID4gIAkJaWYgKCFjcmVhdGVfbm9kZV9j
b25maWcobm9kZSwgbm9kZS0+dXVpZCkpDQo+ID4gIAkJCWdvdG8gZmFpbDsNCj4gPiBAQCAtMTY5
MiwyMyArMTY5MSw5IEBAIHN0YXRpYyB2b2lkIGdldF9tYW5hZ2VkX29iamVjdHNfY2Ioc3RydWN0
DQo+ID4gbF9kYnVzX21lc3NhZ2UgKm1zZywgdm9pZCAqdXNlcl9kYXRhKQ0KPiA+ICAJCQkJCWlt
cG9ydC0+bmV0X2lkeCwgaW1wb3J0LQ0KPiA+ID4gbmV0X2tleSkpDQo+ID4gIAkJCWdvdG8gZmFp
bDsNCj4gPiAgDQo+ID4gLQkJbWVtY3B5KG5ldF9rZXkub2xkX2tleSwgaW1wb3J0LT5uZXRfa2V5
LCAxNik7DQo+ID4gLQkJbmV0X2tleS5uZXRfaWR4ID0gaW1wb3J0LT5uZXRfaWR4Ow0KPiA+IC0J
CWlmIChpbXBvcnQtPmZsYWdzLmtyKQ0KPiA+IC0JCQluZXRfa2V5LnBoYXNlID0gS0VZX1JFRlJF
U0hfUEhBU0VfVFdPOw0KPiA+IC0JCWVsc2UNCj4gPiAtCQkJbmV0X2tleS5waGFzZSA9IEtFWV9S
RUZSRVNIX1BIQVNFX05PTkU7DQo+ID4gLQ0KPiA+ICAJCS8qIEluaXRpYWxpemUgZGlyZWN0b3J5
IGZvciBzdG9yaW5nIGtleXJpbmcgaW5mbyAqLw0KPiA+ICAJCWluaXRfc3RvcmFnZV9kaXIobm9k
ZSk7DQo+ID4gIA0KPiA+IC0JCWlmICgha2V5cmluZ19wdXRfcmVtb3RlX2Rldl9rZXkobm9kZSwg
aW1wb3J0LT51bmljYXN0LA0KPiA+IC0JCQkJCQludW1fZWxlLCBpbXBvcnQtDQo+ID4gPiBkZXZf
a2V5KSkNCj4gPiAtCQkJZ290byBmYWlsOw0KPiA+IC0NCj4gPiAtCQlpZiAoIWtleXJpbmdfcHV0
X25ldF9rZXkobm9kZSwgaW1wb3J0LT5uZXRfaWR4LA0KPiA+ICZuZXRfa2V5KSkNCj4gPiAtCQkJ
Z290byBmYWlsOw0KPiA+IC0NCj4gPiAgCX0gZWxzZSB7DQo+ID4gIAkJLyogQ2FsbGJhY2sgZm9y
IGNyZWF0ZSBub2RlIHJlcXVlc3QgKi8NCj4gPiAgCQlzdHJ1Y3Qga2V5cmluZ19uZXRfa2V5IG5l
dF9rZXk7DQo+IA0KPiANCg==
