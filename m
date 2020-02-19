Return-Path: <SRS0=cHq6=4H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47125C34031
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Feb 2020 02:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D3224654
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Feb 2020 02:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="vxe/clsu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgBSCSm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Feb 2020 21:18:42 -0500
Received: from mga14.intel.com ([192.55.52.115]:4540 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbgBSCSm (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Feb 2020 21:18:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 18:18:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,458,1574150400"; 
   d="scan'208";a="258764251"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga004.fm.intel.com with ESMTP; 18 Feb 2020 18:18:41 -0800
Received: from orsmsx158.amr.corp.intel.com (10.22.240.20) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 18 Feb 2020 18:18:40 -0800
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX158.amr.corp.intel.com (10.22.240.20) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 18 Feb 2020 18:18:40 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 18 Feb 2020 18:18:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZYUe9WghzzVyCYdoCYGv5bSiIHCSWRTyU4C9N816cOSCnP4VIIgVfkQne3X2yQj2ydqTbejw6qPZ5rkGrR6TPbJ2tIlJO30gcbyOrbrbh/+uWHAIe/tXe40jQADG3XZgu/MuTteMgBC/H2jQNAOBUCIGP5oHCEK4i5ZnIrqe5Idxk2GV7oLMRaD3g7lEGIesr3ktcT9rJ13Uf3PFr2NNuLu2bWyU3i6+pfffiP/++mNu3RAn4AYJ6pdoqr87xeP8bu+gfnG7eVLVex8d0GthuhtxoJj9bUTJn2wJ8nihr+FBlITW0st8t6uOHf6R6xlsA+rp+E8vytXU8IASrdHfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fudK2P0235jxj7EjFQxVEw+hBh/NC4mhFWQYl0UarTg=;
 b=g2v+X1c87qnVjyYka+zD6WuZqI2udy9NHxYmh7qcQZ19GAb0w4RNvlAa82k8HvnnyabisGOyfq5ggBbrs90gL7MhQ91Vtho+kmRdkVdr4n+pEWMc3AiJb7nyXtUTRT4bo90DZ6O3NRAS5j+rpGplMMgv7lZbOosITyFaBl8u6s8VZT4+4ZqAEFALLrFOVQgVGqDAQIdoLQzXfrvPemM4+r9kUg+T93KpVgroheBkMKwjokwdLQnsoXVnyo45KkzCheEjWLM8vTef9b/fjsiBWGT17AbHKiHwPAzKQuw+2AUDcP7YZhSosAA0+56Nj6/OAoTBOUspvzI0NJhONEas4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fudK2P0235jxj7EjFQxVEw+hBh/NC4mhFWQYl0UarTg=;
 b=vxe/clsuUYSArZo8XuW9ldAlOsHNHZSz7rnX+N6nI2+lZj1qlsPQgPTrJjUj33QcSZmodpBwzZwNZaG5E3mnB/bD4z8EFti2+mQB6dKAbjsYIIh3B5g5JYYQzerl7CnAkbb8P+8KqtWBzb95aohj6ZCBBC+5OYLmkCOpRaj632I=
Received: from BN7PR11MB2580.namprd11.prod.outlook.com (52.135.246.155) by
 BN7PR11MB2708.namprd11.prod.outlook.com (52.135.252.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24; Wed, 19 Feb 2020 02:18:39 +0000
Received: from BN7PR11MB2580.namprd11.prod.outlook.com
 ([fe80::c8ca:3c11:3fc5:a9d6]) by BN7PR11MB2580.namprd11.prod.outlook.com
 ([fe80::c8ca:3c11:3fc5:a9d6%6]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 02:18:39 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Fix app payload decryption for virtual labels
Thread-Topic: [PATCH BlueZ] mesh: Fix app payload decryption for virtual
 labels
Thread-Index: AQHV5pH2PFvlmGW83EuI6gZpGCakdaghyKWA
Date:   Wed, 19 Feb 2020 02:18:38 +0000
Message-ID: <f5838e7391acdf6ab7f88db22bb28835eba8b05c.camel@intel.com>
References: <20200218193010.12725-1-inga.stotland@intel.com>
In-Reply-To: <20200218193010.12725-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3faec32-a1ed-4f3e-938c-08d7b4e2084f
x-ms-traffictypediagnostic: BN7PR11MB2708:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR11MB27084855EDBF4C7DAF5120EFE1100@BN7PR11MB2708.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(39860400002)(376002)(366004)(199004)(189003)(110136005)(316002)(26005)(91956017)(66946007)(186003)(6512007)(76116006)(6486002)(5660300002)(81166006)(81156014)(36756003)(8676002)(66476007)(66556008)(66446008)(64756008)(2616005)(478600001)(6636002)(86362001)(8936002)(71200400001)(2906002)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR11MB2708;H:BN7PR11MB2580.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YV9AhubNDllJ0GdLCOVDXpYFYQp8yzZZ+wSU3Dcr2MKG5JhZXr64d5c++U1nshnre94DFYlZ4B3fF77DNz7yFmQaBpRNpipkDF0m8u3RT5f0js32+a6kSQ06KvlTu69EAVfMMBpdfkvErREwpcmmj6PtwQHGSWzFZd49nmha3tkGp+s/d1nllaXBhQ+U5HlRkE4hvOb4M7eAavBx4tmM3tO40wNkvUE0U5M542gBbJe4n2KmZZ+1QCiync9PTM0Q3kYaBO/e2+6rdj4i6Y3PGRu8mBdTs8DyFYblllr4smJ+z8rhpYKdxVssbzkFncDgTKlm8Tsi2S2nZ78juHmks8gf+UmED7Uv5ccOqVtqX5TliB4AFCRDhotO3y2jMRRmVlXzG06AITDH++LNDmfWw3em3V+DYsP5mxvtyIsgPzzK+C6nTYjUIT/gBLx4nfRz
x-ms-exchange-antispam-messagedata: Ec8Z3YMArx75B1ZR3EvCIu99UXQapUZWzHnC53H7R4zB0ir9JGUATgafxRP5VP6JhTNajeC3NEZbZtpq81lLQBvs4F2MyyqGym3Qs5FSNsSXszeHtZPwDlIFVecSI37KIe6enaZi8cMN9xCQ1mB9Dg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <379A901B631A02429F1D44391394953F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b3faec32-a1ed-4f3e-938c-08d7b4e2084f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 02:18:39.0916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /frN2AKs6vWBVLQktOh/ASRmMI5iDcTrKeiB2BoUqySQHPRwaaX2yGnGR+CAtlVLSMRQTRM2D23i/iAIHMb2Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2708
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gVHVlLCAyMDIwLTAyLTE4IGF0IDExOjMwIC0wODAwLCBJbmdhIFN0b3RsYW5k
IHdyb3RlOg0KPiBUaGlzIGZpeGVzIGEgYnVnIHdoZW4gYSB2aXJ0dWFsIGxhYmVsIGFuZCBpdHMg
c2l6ZSBoYXNuJ3QgYmVlbiBwYXNzZWQNCj4gdG8gYSBkZWNyeXB0aW9uIGZ1bmN0aW9uOiBpbnN0
ZWFkIG9mIGFsd2F5cyB1c2luZyBOVUxMIHBvaW50ZXIgZm9yDQo+IGxhYmVsIGFuZCAwIGZvciBs
YWJsZSBzaXplLCB1c2UgYWN0dWFsIHZpcnR1YWwgbGFiZWwgaW5mbyBpZiBkZWNyeXB0aW5nDQo+
IGEgcGF5bG9hZCBhZGRyZXNzZWQgdG8gYSB2aXJ0dWFsIGRlc3RpbmF0aW9uLg0KPiAtLS0NCj4g
IG1lc2gvbW9kZWwuYyB8IDggKysrKy0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlv
bnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9tb2RlbC5jIGIv
bWVzaC9tb2RlbC5jDQo+IGluZGV4IDA3Mjk3MmZkYS4uNGU1ODU2MjkyIDEwMDY0NA0KPiAtLS0g
YS9tZXNoL21vZGVsLmMNCj4gKysrIGIvbWVzaC9tb2RlbC5jDQo+IEBAIC00NDQsOCArNDQ0LDgg
QEAgc3RhdGljIGludCBhcHBfcGFja2V0X2RlY3J5cHQoc3RydWN0IG1lc2hfbmV0ICpuZXQsIGNv
bnN0IHVpbnQ4X3QgKmRhdGEsDQo+ICAJCQljb250aW51ZTsNCj4gIA0KPiAgCQlpZiAob2xkX2tl
eSAmJiBvbGRfa2V5X2FpZCA9PSBrZXlfYWlkKSB7DQo+IC0JCQlkZWNyeXB0ZWQgPSBtZXNoX2Ny
eXB0b19wYXlsb2FkX2RlY3J5cHQoTlVMTCwgMCwgZGF0YSwNCj4gLQkJCQkJCXNpemUsIHN6bWlj
dCwgc3JjLCBkc3QsIGtleV9haWQsDQo+ICsJCQlkZWNyeXB0ZWQgPSBtZXNoX2NyeXB0b19wYXls
b2FkX2RlY3J5cHQodmlydCwgdmlydF9zaXplLA0KPiArCQkJCQlkYXRhLCBzaXplLCBzem1pY3Qs
IHNyYywgZHN0LCBrZXlfYWlkLA0KPiAgCQkJCQkJc2VxLCBpdl9pZHgsIG91dCwgb2xkX2tleSk7
DQo+ICANCj4gIAkJCWlmIChkZWNyeXB0ZWQpIHsNCj4gQEAgLTQ1Nyw4ICs0NTcsOCBAQCBzdGF0
aWMgaW50IGFwcF9wYWNrZXRfZGVjcnlwdChzdHJ1Y3QgbWVzaF9uZXQgKm5ldCwgY29uc3QgdWlu
dDhfdCAqZGF0YSwNCj4gIAkJfQ0KPiAgDQo+ICAJCWlmIChuZXdfa2V5ICYmIG5ld19rZXlfYWlk
ID09IGtleV9haWQpIHsNCj4gLQkJCWRlY3J5cHRlZCA9IG1lc2hfY3J5cHRvX3BheWxvYWRfZGVj
cnlwdChOVUxMLCAwLCBkYXRhLA0KPiAtCQkJCQkJc2l6ZSwgc3ptaWN0LCBzcmMsIGRzdCwga2V5
X2FpZCwNCj4gKwkJCWRlY3J5cHRlZCA9IG1lc2hfY3J5cHRvX3BheWxvYWRfZGVjcnlwdCh2aXJ0
LCB2aXJ0X3NpemUsDQo+ICsJCQkJCWRhdGEsIHNpemUsIHN6bWljdCwgc3JjLCBkc3QsIGtleV9h
aWQsDQo+ICAJCQkJCQlzZXEsIGl2X2lkeCwgb3V0LCBuZXdfa2V5KTsNCj4gIA0KPiAgCQkJaWYg
KGRlY3J5cHRlZCkgew0K
