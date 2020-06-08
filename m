Return-Path: <SRS0=ITyu=7V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7594EC433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jun 2020 20:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FC6D2074B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jun 2020 20:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="KbrGnfM9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgFHUd2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Jun 2020 16:33:28 -0400
Received: from mga03.intel.com ([134.134.136.65]:20912 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgFHUd2 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Jun 2020 16:33:28 -0400
IronPort-SDR: cND0EYpE1lF5HwUH4JMNEcRIwfkdtbKSAmcQeA93GsSoi3TQYMw6i2+LFKzREGdo1jJEomghE5
 9xhIas9u9GtA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 13:33:27 -0700
IronPort-SDR: AUAJLM6qr9/0OoYLTaKMN9KcHkrvgiAM3ZHVElGM6Q6hh6oA9/PWNWiP6GrQauNGoX23hZH6xS
 VWVV5F+VSWFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,489,1583222400"; 
   d="scan'208";a="295595194"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga004.fm.intel.com with ESMTP; 08 Jun 2020 13:33:27 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 8 Jun 2020 13:33:26 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 8 Jun 2020 13:33:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hersx4mEYW/Uedaa3oSovL7wHQh/anf4HpM21NEsB5hBBgU89SaULJYNSCLabqm3+aQu5xDcP1thGKXhZR7EiTA9mNXSnqWp+C22ur3xmF5XWBSGOqv+Yj0TJ4HtluxabxfT5MhX56t6fuwJ/Mj/nmfYYuyKUxmeWJvJ3810zKfa3EijK+LFKmw6a5W5n0l8YzLEbfUsdl89R0Zpp9/bne0yloNoEVzMQKFOmyLa2SllQgSlIxPrizAM61RkMqCJMP1/mKpKtU9pjQ66/D8OttBPk4KIpvJGv9niCr/FoAZ+RhHC97e28clI9G8iFe+qphEwIppnBLkd85dFaJzO7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAfdji6wCUOYYw451XmWLksUOjYGwUVvelqnvPu7Pus=;
 b=J8OkdP4g2KpLRPA2wNRihF4LC4GmL0a5cX53KYgYMRjFxaZ8hkxnHzCws1Glo/M06LFG0vb14m5yT9677w5UYphVzD+KaQnFoPr2RBz536CZXg8qEPCdEVWPStE/o6CG1T89qdxZRda6fYM5uQtVC85uRXEs8GsQsx8zXWVNKZOpoeeeugUdSikVMfPeUM5kYiEmkDYIFWvNOKILwkPspSh4c0Ijd0XUfFaIdzDHqvtZvnSnKxNzY0s0oeowbPTo+hEvFoY8iJ7G91QIHPVeRxXu4VGu4cEmk8C6z68qpu8yqqK/tUb5DqjQFsW707JvHffrnX9Jn+jOTDy5WhXymQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAfdji6wCUOYYw451XmWLksUOjYGwUVvelqnvPu7Pus=;
 b=KbrGnfM9Jzv3eyqnFKbnTdkZAwBEBhxyWxQ478mSdmVc5RI/ypbd/Qu7UkqXrQ8LlGMj1jZrVvrYMfwC0f/gFdmk2/f5hPiKaIJkwTtwjemJBYccLSEcd8W9MiUOWdbgOUM90KHYtYLDEPBzsH0OzqQb+V5vQVtkwue6Z7UHLjE=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4650.namprd11.prod.outlook.com (2603:10b6:303:54::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Mon, 8 Jun
 2020 20:33:25 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0%6]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 20:33:25 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Remove unused/redundant functions
Thread-Topic: [PATCH BlueZ] mesh: Remove unused/redundant functions
Thread-Index: AQHWO4C9bGVjgbXQq0Sm7tNdHtmrJajPMRsA
Date:   Mon, 8 Jun 2020 20:33:25 +0000
Message-ID: <ba4c1d8d6c448409fdb81537263c42a6269a5f85.camel@intel.com>
References: <20200605213143.194808-1-inga.stotland@intel.com>
In-Reply-To: <20200605213143.194808-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.139.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83b81701-3d66-4161-1073-08d80beb31d6
x-ms-traffictypediagnostic: MW3PR11MB4650:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB465044C8C60E26664588530EE1850@MW3PR11MB4650.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 042857DBB5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yC6UVHyNychbGlH1wEFXXja2kMVx7F0d1B579RaIin1Sb7wZmm1Wn8nKj/76iSOBrP7TGzzHOieaypw7ISoY+mtIaXKOf2gHwL6FAw4X48DsV8NWukOgW80D03DkiUe1JfyNHvNFX1kUtCNRc8ZPrgiwzxENvFY/R0QokdoK/GP9lHP50ECVagWjGz6QC3FF2RAdc0vvSi7qfhe+Pqt1/6AlCkiBi2Jw3DH7nJAxogH0EZrAVw8ZinD8JeNrGaszmqPjc+zRnOVWU3aRLAXETackhLddJ4zAVhn3a0F19oIBMY6kvBjHexV3ExXynyVQAPC9aFqv0C5Awu6ZQytNyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(396003)(346002)(39860400002)(376002)(136003)(6486002)(6636002)(186003)(71200400001)(6506007)(2906002)(86362001)(478600001)(26005)(316002)(76116006)(64756008)(66446008)(6512007)(8936002)(36756003)(8676002)(66946007)(2616005)(66476007)(66556008)(5660300002)(110136005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 9I2f9/dVJfJqjht9mDsV83DxVtdN12HCaKjz4djei7hkwWInRZLvx0cG1+DmplLHzvxLI2vLk+geZoxdub2jJ19C1aMb9qjBPiiK5P0GakshgBeVwc6KAw1uahPC3hHAAN6Bk54Z+bhuisHoVy6VncbyIFdGFJnshKxk4yMvBUXHc/9w7ZrcyTIiNLyqcQiV3N9tbMIJaVYkmqZ6s5ruJtjcEXk1bba53yhj/6g7qv3ttUpKYHQ1IPPhkuJM3Jx6I4sddAzJb3Q7zP1Pt93RFXRg7/eBA28B8FtG1LCaXbBsV/M+LSbUts2AXaWgybyqJROsQzqyqU+dlA5JgN+gb+M59g6gcAT7khaBLxnD+WGD67WBSa9JIddHs7s9VvocDRzLmblXmdkj8HJkGnTh7tfnspJMtNcuxLnT3sMlO2Ul/Cdp6yxuchuMwTvl90ZmjWxQ3VpPX1apD2i4OJ12DrHfTNGlOv+rjLYV6ytiD6IJipSjj20/B7a1AsnwTAuJ
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B99E0156E6EA444854141E731281499@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b81701-3d66-4161-1073-08d80beb31d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2020 20:33:25.2435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W9pX1qD5K0Wd4ez66w2svTE1sxScMWw0C9hXhP+KvmEvK214Xt9/5pdPSElauE3aY9vqbq6qCihl2EXjA20m6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4650
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gRnJpLCAyMDIwLTA2LTA1IGF0IDE0OjMxIC0wNzAwLCBJbmdhIFN0b3RsYW5k
IHdyb3RlOg0KPiBUaGlzIHJlbW92ZXMgbWVzaF9uZXRfcHJvdmlzaW9uZXJfbW9kZV9zZXQgKHVu
dXNlZCkgYW5kDQo+IG1lc2hfbmV0X3Byb3Zpc2lvbmVyX21vZGVfZ2V0IChkdXBsaWNhdGVzIG5v
ZGVfaXNfcHJvdmlzaW9uZXIpDQo+IC0tLQ0KPiAgbWVzaC9tb2RlbC5jIHwgIDIgKy0NCj4gIG1l
c2gvbmV0LmMgICB8IDEwIC0tLS0tLS0tLS0NCj4gIG1lc2gvbmV0LmggICB8ICAyIC0tDQo+ICAz
IGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9tZXNoL21vZGVsLmMgYi9tZXNoL21vZGVsLmMNCj4gaW5kZXggZWM3OWE2OWI4
Li5mMmRmYjI2NDQgMTAwNjQ0DQo+IC0tLSBhL21lc2gvbW9kZWwuYw0KPiArKysgYi9tZXNoL21v
ZGVsLmMNCj4gQEAgLTkwNyw3ICs5MDcsNyBAQCBib29sIG1lc2hfbW9kZWxfcngoc3RydWN0IG1l
c2hfbm9kZSAqbm9kZSwgYm9vbCBzem1pY3QsIHVpbnQzMl90IHNlcTAsDQo+ICAJICogVGhlIHBh
Y2tldCBuZWVkcyB0byBiZSBkZWNvZGVkIGJ5IHRoZSBjb3JyZWN0IGtleSB3aGljaA0KPiAgCSAq
IGlzIGhpbnRlZCBieSBrZXlfYWlkLCBidXQgaXMgbm90IG5lY2Vzc2FyaWx5IGRlZmluaXRpdmUN
Cj4gIAkgKi8NCj4gLQlpZiAoa2V5X2FpZCA9PSBBUFBfQUlEX0RFViB8fCBtZXNoX25ldF9wcm92
aXNpb25lcl9tb2RlX2dldChuZXQpKQ0KPiArCWlmIChrZXlfYWlkID09IEFQUF9BSURfREVWIHx8
IG5vZGVfaXNfcHJvdmlzaW9uZXIobm9kZSkpDQo+ICAJCWRlY3J5cHRfaWR4ID0gZGV2X3BhY2tl
dF9kZWNyeXB0KG5vZGUsIGRhdGEsIHNpemUsIHN6bWljdCwgc3JjLA0KPiAgCQkJCQkJZHN0LCBr
ZXlfYWlkLCBzZXEwLCBpdl9pbmRleCwNCj4gIAkJCQkJCWNsZWFyX3RleHQpOw0KPiBkaWZmIC0t
Z2l0IGEvbWVzaC9uZXQuYyBiL21lc2gvbmV0LmMNCj4gaW5kZXggMDc4MTNlZWM0Li5jMTJkZDY1
NDEgMTAwNjQ0DQo+IC0tLSBhL21lc2gvbmV0LmMNCj4gKysrIGIvbWVzaC9uZXQuYw0KPiBAQCAt
MzM2MiwxNiArMzM2Miw2IEBAIHZvaWQgbWVzaF9uZXRfc2V0X2l2X2luZGV4KHN0cnVjdCBtZXNo
X25ldCAqbmV0LCB1aW50MzJfdCBpbmRleCwgYm9vbCB1cGRhdGUpDQo+ICAJbmV0LT5pdl91cGRh
dGUgPSB1cGRhdGU7DQo+ICB9DQo+ICANCj4gLXZvaWQgbWVzaF9uZXRfcHJvdmlzaW9uZXJfbW9k
ZV9zZXQoc3RydWN0IG1lc2hfbmV0ICpuZXQsIGJvb2wgbW9kZSkNCj4gLXsNCj4gLQluZXQtPnBy
b3Zpc2lvbmVyID0gbW9kZTsNCj4gLX0NCj4gLQ0KPiAtYm9vbCBtZXNoX25ldF9wcm92aXNpb25l
cl9tb2RlX2dldChzdHJ1Y3QgbWVzaF9uZXQgKm5ldCkNCj4gLXsNCj4gLQlyZXR1cm4gbmV0LT5w
cm92aXNpb25lcjsNCj4gLX0NCj4gLQ0KPiAgdWludDE2X3QgbWVzaF9uZXRfZ2V0X3ByaW1hcnlf
aWR4KHN0cnVjdCBtZXNoX25ldCAqbmV0KQ0KPiAgew0KPiAgCXN0cnVjdCBtZXNoX3N1Ym5ldCAq
c3VibmV0Ow0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9uZXQuaCBiL21lc2gvbmV0LmgNCj4gaW5kZXgg
ODRlN2MxNTQ1Li5mN2ZlM2YxNTAgMTAwNjQ0DQo+IC0tLSBhL21lc2gvbmV0LmgNCj4gKysrIGIv
bWVzaC9uZXQuaA0KPiBAQCAtMzM1LDggKzMzNSw2IEBAIHZvaWQgbWVzaF9uZXRfc2VuZF9zZWco
c3RydWN0IG1lc2hfbmV0ICpuZXQsIHVpbnQzMl90IGtleV9pZCwNCj4gIHN0cnVjdCBtZXNoX25l
dF9oZWFydGJlYXQgKm1lc2hfbmV0X2hlYXJ0YmVhdF9nZXQoc3RydWN0IG1lc2hfbmV0ICpuZXQp
Ow0KPiAgdm9pZCBtZXNoX25ldF9oZWFydGJlYXRfaW5pdChzdHJ1Y3QgbWVzaF9uZXQgKm5ldCk7
DQo+ICB2b2lkIG1lc2hfbmV0X2hlYXJ0YmVhdF9zZW5kKHN0cnVjdCBtZXNoX25ldCAqbmV0KTsN
Cj4gLXZvaWQgbWVzaF9uZXRfcHJvdmlzaW9uZXJfbW9kZV9zZXQoc3RydWN0IG1lc2hfbmV0ICpu
ZXQsIGJvb2wgbW9kZSk7DQo+IC1ib29sIG1lc2hfbmV0X3Byb3Zpc2lvbmVyX21vZGVfZ2V0KHN0
cnVjdCBtZXNoX25ldCAqbmV0KTsNCj4gIGJvb2wgbWVzaF9uZXRfa2V5X2xpc3RfZ2V0KHN0cnVj
dCBtZXNoX25ldCAqbmV0LCB1aW50OF90ICpidWYsIHVpbnQxNl90ICpjb3VudCk7DQo+ICB1aW50
MTZfdCBtZXNoX25ldF9nZXRfcHJpbWFyeV9pZHgoc3RydWN0IG1lc2hfbmV0ICpuZXQpOw0KPiAg
dWludDMyX3QgbWVzaF9uZXRfZnJpZW5kX3RpbWVvdXQoc3RydWN0IG1lc2hfbmV0ICpuZXQsIHVp
bnQxNl90IGFkZHIpOw0K
