Return-Path: <SRS0=JIrD=3S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E067C2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jan 2020 15:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31DD20716
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jan 2020 15:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Ve2jwiMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgA2PNZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Jan 2020 10:13:25 -0500
Received: from mga06.intel.com ([134.134.136.31]:7365 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbgA2PNZ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Jan 2020 10:13:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2020 07:06:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,378,1574150400"; 
   d="scan'208";a="429700826"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jan 2020 07:06:12 -0800
Received: from orsmsx153.amr.corp.intel.com (10.22.226.247) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 29 Jan 2020 07:06:12 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX153.amr.corp.intel.com (10.22.226.247) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 29 Jan 2020 07:06:12 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.52) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 29 Jan 2020 07:06:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSQ2PAQcRI3sswTayZly/513QpCNrOGsYv39GSvCt+C0Qzj3BJc4gfxD+R+XDSdVna+yt7om46iMrL8Se6K7cLMSEnNI3QQZql5IA/5kwZ5pyNY3nXBgYWxV2NQfDlLbQqEn76XQ18HAhIDEf1Zsijz3+y/vqyGz54W4vGYSWoHq+X7GAqDcPR2o8Ahr3W9WPBZsSoRj+gc7xF0xLShTaegjPnfY04/w/0v/AKUPxtDzMfFkKeH6fQ48dSOAe+ijlZgE2XTA5NNDxMaO+UQx/uks/fD3gORZplqSE+ipMiauF7YvbCYDTwUGZEKqjoijdqlt7jI0X43N56+wSFP0ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CzkHINgzGfi5BKLUIaA09GLIIkgYZb0dtK9D9s895M=;
 b=edyB0z7CLEh3Nq2BnC9JNhZjWKVZDO1+iv6b1ZR4LP98vW2Zn31/pOUSpCBJFgG7tR4+XQ4IhWxmQXlbsK84a7+lqqNFQPSepNUz/1q7EKjNnOSv8mN9cEiyjvK2h1IGTMnjrmPiVJwydxYK4mKjRi61c7+tsmAA9i+5ZoRQwA7To032qgxy3X8+hvM8RZ5HJerr7/U5Gy/G2+fdfqW0MpFtcup0ngOZAR5FEDIlnO3OAxQTsVfL8ntjk50F5bdEVyksDNNoUFkHrqNf564avAD23WsvI/0ogomRba+Iklfbx1JHoH71U+IKKWTYl8HhWzH0d6t/yDWxRvTzhNi2PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CzkHINgzGfi5BKLUIaA09GLIIkgYZb0dtK9D9s895M=;
 b=Ve2jwiMdMjL//7Q3Ncy6Eg6o9rvJZhVb+9dUecstK/MZvXb3D+r7FSTBVzoEAoXwO1f3sjhLhe+3bkd034k/SSjUlyQxq/OuxHga8MvpVG0tDN1QaMl1ExpxgNvJp1FH/JMpR1u+qwHWCoPUR2IxClVI4gbz4sQwtDfeTUZWZeY=
Received: from BN7PR11MB2580.namprd11.prod.outlook.com (52.135.246.155) by
 BN7PR11MB2738.namprd11.prod.outlook.com (52.135.245.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.26; Wed, 29 Jan 2020 15:06:10 +0000
Received: from BN7PR11MB2580.namprd11.prod.outlook.com
 ([fe80::c8ca:3c11:3fc5:a9d6]) by BN7PR11MB2580.namprd11.prod.outlook.com
 ([fe80::c8ca:3c11:3fc5:a9d6%6]) with mapi id 15.20.2665.027; Wed, 29 Jan 2020
 15:06:10 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "rafal.gajda@silvair.com" <rafal.gajda@silvair.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v4 5/5] mesh: Add NVM storage of Replay Protection
Thread-Topic: [PATCH BlueZ v4 5/5] mesh: Add NVM storage of Replay Protection
Thread-Index: AQHV1kyN/LArUGwVHkm0VPVW+lGhN6gBj54AgAAvDoA=
Date:   Wed, 29 Jan 2020 15:06:10 +0000
Message-ID: <a49f5f0c9633bacfcbe6f2125aece235ac34e90f.camel@intel.com>
References: <20200129023258.10004-1-brian.gix@intel.com>
         <20200129023258.10004-6-brian.gix@intel.com>
         <20200129121744.zv3jnf6uejjpetud@rgajda2364>
In-Reply-To: <20200129121744.zv3jnf6uejjpetud@rgajda2364>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee5920a4-5eba-4ce1-97c6-08d7a4ccc6ad
x-ms-traffictypediagnostic: BN7PR11MB2738:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR11MB2738DC3F8EC90EA5DE400957E1050@BN7PR11MB2738.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02973C87BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(366004)(39860400002)(396003)(189003)(199004)(91956017)(6916009)(86362001)(107886003)(26005)(6506007)(478600001)(5660300002)(6486002)(6512007)(2906002)(186003)(8676002)(36756003)(71200400001)(81156014)(316002)(81166006)(8936002)(54906003)(4326008)(66476007)(66946007)(2616005)(66556008)(76116006)(66446008)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR11MB2738;H:BN7PR11MB2580.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RpKKQqxGyh5cUczRKTkVtJS7yC/GQOfSOknUshmTN47n6roTrXxk/dHn+Ucim87tbNSr67P5Nd35GncwkaE7JsFfLv1K4lZUZvgecvQ24V2MTNWv0+HrjWYoi2vo36UPYabas8Sz8va1Qn4vaxZ++ILL4osqpqg79bADLMCnNDhFKfFEh7cAaYEbQ6j/IPMqXhtvZCQmKsYUhVQZ+bOOk3i4/4qpxzfPaTrnUk63YyBUke0Ic6FD0ulxWnj1adU2BWq2yUkOYEzzNgtwe6Uytlhd1bJHjlvSangS7+v4b40SQ5ZwEBOvOlQgxUKRWjfEZMpD9JzVgte0BRhhzgTkkIcL13L1xYGnwU112fQLwcnG7C0iPS6vzfakWUuBU2e/fXxUMQz4uAc/fk45mduucF1vvS/fNt19LuKVPQChGZEa4Qi5tvUzZhwGxczxyHWn
x-ms-exchange-antispam-messagedata: KF1wsp5l8RqHoF5WP3mr0BBnMjuv3HHFNi0M3hBCbHURY5p1jtLr5ZRWucUailkZBajxV/mkZvLmx5lXp+O1EQfdNF1J7+i56ICc3QJ2MIha351+e2FAIqhazKH2wgBdV0lYSpMcG758aHHqq6zhfA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <272057584E653C4B80F0E1394C7266B0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ee5920a4-5eba-4ce1-97c6-08d7a4ccc6ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2020 15:06:10.7274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aRqEpaiteFdpnvTUBHbsw+LKyYN9KsLTrLCKpleSmcZ8Il0irPuF69Sv3nbIR7Aai24K5iEZDAUcSNqFXjMVvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2738
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgUmFmYcWCLA0KDQpPbiBXZWQsIDIwMjAtMDEtMjkgYXQgMTM6MTcgKzAxMDAsIFJhZmFsIEdh
amRhIHdyb3RlOg0KPiBIaSBCcmlhbiwNCj4gDQo+IEkgaGF2ZSBhIHF1ZXN0aW9uIGFib3V0IHRo
ZSB3YXkgUlBMIGlzIHN0b3JlZC4NCj4gDQo+IE9uIFR1ZSwgSmFuIDI4LCAyMDIwIGF0IDA2OjMy
OjU4UE0gLTA4MDAsIEJyaWFuIEdpeCB3cm90ZTogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICANCj4gPiBNZXNoIHNwZWNpZmljYXRpb24gcmVxdWlyZXMgdGhhdCBSZXBs
YXkgUHJvdGVjdGlvbiBiZSBwcmVzZXJ2ZWQNCj4gPiBhY3Jvc3Mgbm9kZSByZXN0YXJ0cy4gIFRo
aXMgYWRkcyB0aGF0IHN0b3JhZ2UgaW4NCj4gPiA8bm9kZV91dWlkPi9ycGwvPGl2X2luZGV4Pi88
c3JjPg0KPiANCj4gV291bGRuJ3QgaXQgYmUgbW9yZSBjb252aW5pZW50IHRvIGtlZXAgYm90aCBp
dl9pbmRleCBhbmQgc2VxdWVuY2UgaW4gYSBmaWxlIGxpa2UgdGhpczoNCj4gICA8bm9kZV91dWlk
Pi9ycGwvPHNyYz4NCj4gPw0KPiANCj4gWW91IGNvdWxkIHN0b3JlIHRoZW0gaW4gYnl0ZXMgaW5z
dGVhZCBvZiBoZXggc3RyaW5nIA0KPiBhbmQgaXQgd291bGQgZWxpbWluYXRlIHRoZSBuZWVkIGZv
ciBjbGVhbmluZyBlbnRyaWVzIGZyb20gb2xkIElWX2luZGV4Lg0KDQoNCldlIGNvbnNpZGVyZWQg
dGhpcyBhbmQgZGVjaWRlZCBhZ2FpbnN0IGl0IGZvciBlYXNlIG9mIHByb2Nlc3NpbmcsIGFzIHRo
aXMgbWV0aG9kIHJlcXVpcmVzIGZld2VyIGZpbGUNCm9wZXJhdGlvbnMuICBDbGVhbmluZyBvbGQg
ZW50cmllcyBpcyBzb21ldGhpbmcgdGhhdCB3aWxsIGhhcHBlbiByZWdhcmRsZXNzIG9mIGhvdyB0
aGUgUlBMIHRyZWUgbG9va3MgaW4gdGhlDQpmaWxlIHN5c3RlbSwgYXMgd2UgZGVsZXRlIGVudHJp
ZXMgdGhhdCBhcmUgb2xkZXIgdGhhbiAobmV0LT5pdl9pbmRleCAtIDEpIHNpbmNlIHdlIGRvbid0
IHJlY2VpdmUgbWVzc2FnZXMgb24NCnRoYXQgaXZfaW5kZXgsIHRoZXJlIGlzIG5vIHBvc3NpYmxp
bGl0eSBvZiBhIFJlcGxheSBhdHRhY2suIEFuZCBkZWxldGluZyBhIGZpbGUgc3lzdGVtIHRyZWUg
aXMgcHJldHR5IHNpbXBsZS4gDQpBIFNSQyBhZGRyZXNzIGRvZXMgbm90IGdldCB0byBrZWVwIGl0
J3Mgc3BvdCBpbiB0aGUgUlBMIGluZGVmaW5pdGVseS4uLiAgb25seSBvdmVyIHRoZSBjdXJyZW50
IG9yIHByaW9yDQppdl9pbmRleC4NCg0KT3VyIG90aGVyIGNvbnNpZGVyYXRpb25zIGluY2x1ZGVk
IG1haW50YWluaW5nIHRoZSBpbnRlZ3JpdHkgb2YgdGhlIFJQTCBhY3Jvc3MgcG93ZXItbG9zcyBv
ciBhYm9ydCByZWJvb3RzLg0KDQpIb3dldmVyLCB3ZSBkbyByZWNvZ25pemUgdGhhdCBzb21lIHBs
YXRmb3JtcyBtYXkgZGlmZmVyZW50IE5WTSBzdG9yYWdlIGF2YWlsYWJsZSB0aGF0IGNhbiBiZSBv
cHRpbWl6ZWQgaW4NCmRpZmZlcmVudCB3YXlzLCBzbyB3ZSB0cmllZCB0byBrZWVwIHRoZSBOVk0g
UlBMIGFwaXMgYXMgc2ltcGxlIGFzIHBvc3NpYmxlIHRvIGFsbG93IG90aGVycyB0byBvcHRpbWl6
ZSB0aGUNCnN0b3JhZ2UgYXMgdGhleSBzZWUgZml0LiAgRm9yIGluc3RhbmNlLCBpZiBzb21lb25l
IHdhcyB0byBwb3J0IHRoaXMgdG8gYW4gZW1iZWRkZWQgc3lzdGVtIHdpdGhvdXQgYSBzdGFuZGFy
ZA0KbGludXggZmlsZSBzeXN0ZW0uDQo=
