Return-Path: <SRS0=y60a=7P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579B5C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Jun 2020 16:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2591D20772
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Jun 2020 16:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="S3QVzyIR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgFBQJk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Jun 2020 12:09:40 -0400
Received: from mga18.intel.com ([134.134.136.126]:14358 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbgFBQJk (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Jun 2020 12:09:40 -0400
IronPort-SDR: 48IEkSltDtJFXMWVPJPm1miPBzQx6tN4+GQqelwjTxi1Pg2bOdXiUwI9ihrOf+7TSEmgTzYBMK
 4z/M3jTNDlgQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 09:09:39 -0700
IronPort-SDR: xykqjI5bPagqNu/+hBJvGlGcgUSmWvdgIBwrpVxuZJJKACFVe/m1PVfpgKbBTIeHlvTbosbH+Z
 l5AZ2+yYxIqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,465,1583222400"; 
   d="scan'208";a="272409115"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga006.jf.intel.com with ESMTP; 02 Jun 2020 09:09:38 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 2 Jun 2020 09:09:38 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 2 Jun 2020 09:09:37 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 2 Jun 2020 09:09:37 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 2 Jun 2020 09:09:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9LLD6Yh9QOu0ZVYZOI+dyqbsNtyA1HWuDGm0/MO0dQRIYYq2bBG7ULJZueRZ5tayGPE8dGtBH7oaz8QPGYNesbzgpSPLjB0Xd/DM3stSn8DshyYgtuPbVgH8Wxh0+gnIKZaWRr1R9dXEHrAkupJCJnLjXIDwrtODnZxjI3rndIJjx+egjx0q716sF8Bxzoe5RGS2m0PKLp7ct5PcQZD/70jnNehi+cWsQEUOoeBlP26HlIYoWG+scASP9OaqUCRxSyx76aIDriG1WRdHy88u4hKP1u8BAPC/60g1HFSdHLMkWGnlggCbl6pAkb2tmVULeAgm+ZeXAZKGunZ9i1y8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LW8C/3qbgx69e0EWEuManHEMZT0xCja3DVXQzs33oHw=;
 b=Jjyo2CyyDOVOLVRhK61Yi4PL3tAoz7642+jhDn5WAYPGwf8rOVWo2maQcD9z98tM4vIup2vHWHGrHpH3RJfvzV9eQvu2FejVOp8Q1KC5/vqfX6+2fFmXeN2y53PtB7vfJ29glEEgo7dUSweH/jYWgiLR4Wyz0Y4gscc8U61bKTHE2WHLA96cpPYUiLNDbjIvpJeUTu3X5jo1sjI1EnLLJrEEwWkwYx072fvZ7T8ymyelSPe4ZLfr0DJHoaJ6yHWE532nW00WSTDZFG5rqlj6Uut/Y3lBGHCvcpiisDS21oYTwrr2umqz9+n6SpJqEo7Z9O1v8jjmOi6BibahiXxoFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LW8C/3qbgx69e0EWEuManHEMZT0xCja3DVXQzs33oHw=;
 b=S3QVzyIRw7bh9dEtIwdWpjPpa5IInTuftTfajq2508hnHYJoMTE1w/QA8JdxuFJwnUMaRfCw3aHpW7IvpDZkr6qkFc10Paypa0QfHRlIkZBHlsc06xu3CTG/qelZavwaUaWqiXpfNW8Q+bKSHeY9S8B4DxtyQ8Pi9NJ7izVvnc0=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4732.namprd11.prod.outlook.com (2603:10b6:303:2c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Tue, 2 Jun
 2020 16:09:36 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0%5]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 16:09:36 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ v2] mesh: Fix FPE in overcommit logic.
Thread-Topic: [PATCH BlueZ v2] mesh: Fix FPE in overcommit logic.
Thread-Index: AQHWBz4jNtFaFjgVkEGkcOHDiJqAqKjF4e6A
Date:   Tue, 2 Jun 2020 16:09:36 +0000
Message-ID: <d78fd77558d63e574158e7a9f3212a1644239444.camel@intel.com>
References: <20200331090400.18379-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20200331090400.18379-1-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: silvair.com; dkim=none (message not signed)
 header.d=none;silvair.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.139.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69a501eb-9668-4f1b-badf-08d8070f5866
x-ms-traffictypediagnostic: MW3PR11MB4732:
x-microsoft-antispam-prvs: <MW3PR11MB47328FCD7443C86C7C64180FE18B0@MW3PR11MB4732.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d4G+E5ruXfs2wej5Kv4MIk5d9CkfepchgXsddiHBCAmeNUCNWF3YYohYybDtppkqjkQtXfpN0zyeRaV0wGcRExHLGn7EYuR7U16rQUSB7rhW36FxkBFU4HejY1ptmTet0IAKPPV6rpJocL4zYAccCW/hwL5uKjGq26mQXqqKSKByrXRmgj1cT3tEdVIBvQgmJA+nzr+2k27WkUSF+f2jRJbmEYGJ5WH4sHKTyqDhy4HmeRavEAYTTMmnBwFBUL5hjq/LYg8NAO9cxkqqLS4pl7Px1NG6xwUgQu9BK9XM3BKxRatOMdRRjAl2okXnBcUdZofegGg+TzI4aHWnC4EpBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(376002)(136003)(346002)(39860400002)(366004)(2616005)(6486002)(86362001)(478600001)(66556008)(66446008)(64756008)(66476007)(76116006)(66946007)(36756003)(2906002)(6512007)(71200400001)(6506007)(5660300002)(186003)(26005)(83380400001)(8936002)(316002)(110136005)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 1Uke3ncY/uy4TupnRj2j7wbB4vuWlUe0kKevEZ8TGMMEQc9KwNzqhIjz8M2wpcel1UMuyEZIIPx7dGCuW6yExU0Iqxubh7aO9pFlCYwMT94CL56OU+a4iTiilLIw1byw+LHzKannO3Vst3gTnbrFlciNj8tUzlD4UWqDJgHX871UTyp749S9IkI8GLSu5F/BK4CT9fCwp4UZIBcfXu31acqiEa5WnS0C++FuXrG3hUR6BOqShbC2pC99IcQTl8SGfo8V40LvnsuRWEEz2vP1pZPXYclwNYN1PMuDvPN/V3fH9yfNYH8GKuqDEQrHi8YTvmFu/oLrNMPB5TsA80lMIXyT7TkfqKXFPC08CQ3pdKd/RA6xmt+vxNBXFUpDbAysTHdLsYvP7bcwNYr8vrYwgOKR2+ZxvulVrH6Yh2MUjN/rGtsiTrrxeJaatvYxies52X7b/uTW2fu6+lTXeNdepvI73uh/FTBgH0dxYLpxu3LjCu3woJAijoL4CTSR7+3y
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1934023F2CD3D48B3F2B84395119309@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a501eb-9668-4f1b-badf-08d8070f5866
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 16:09:36.1448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T2Y43Xi0WWIL1z7IyvHKGyz1wB0YnY4frvmFq8JSVV3P2Saweeqrl9SeTwVFJG5smDJOcXVBLDxeFEuQ3UMLrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4732
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCB3aXRoIHN0eWxlIGd1aWRlIGZpeGVzDQoNCk9uIFR1ZSwgMjAyMC0wMy0zMSBhdCAx
MTowNCArMDIwMCwgTWljaGHFgiBMb3dhcy1SemVjaG9uZWsgd3JvdGU6DQo+IER1cmluZyBvdmVy
Y29tbWl0LCBtZXNoX2NvbmZpZ19zYXZlIGlzIGNhbGxlZCBpbiBhc3luY2hyb25vdXMgbW9kZSB0
bw0KPiBhdm9pZCBibG9ja2luZyBTZW5kKCkgY2FsbHMuIFRoaXMgbWVhbnMgdGhhdCB1cGRhdGUg
b2YgY2ZnLT53cml0ZV90aW1lDQo+IGlzIHNjaGVkdWxlZCB2aWEgbF9pZGxlX29uZXNob3QsIHNv
IGlmIHRoZSBuZXh0IFNlbmQoKSBnZXRzIHNjaGVkdWxlZA0KPiBmaXJzdCwgdGhlIGNvZGUgbWF5
IHNlZSBlbGFwc2VkIHRpbWUgb2YgemVyby4NCj4gDQo+IElmIHRoaXMgaGFwcGVucywgdGhlbiB0
aGUgb3ZlcmNvbW1pdCBsb2dpYyB3YXMgYWxyZWFkeSBleGVjdXRlZCBhbmQgdGhlDQo+IG92ZXJj
b21taXQgaXMgcGVuZGluZywgc28gd2UgY2FuIGp1c3QgcmV0dXJuLg0KPiAtLS0NCj4gRml4ZWQg
dGhlIGNvbW1pdCBsb2csIHNvcnJ5Lg0KPiANCj4gIG1lc2gvbWVzaC1jb25maWctanNvbi5jIHwg
NiArKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYg
LS1naXQgYS9tZXNoL21lc2gtY29uZmlnLWpzb24uYyBiL21lc2gvbWVzaC1jb25maWctanNvbi5j
DQo+IGluZGV4IGFkMmQ0ZDBmOC4uMjFmMmNmYzM3IDEwMDY0NA0KPiAtLS0gYS9tZXNoL21lc2gt
Y29uZmlnLWpzb24uYw0KPiArKysgYi9tZXNoL21lc2gtY29uZmlnLWpzb24uYw0KPiBAQCAtMjAx
NCw2ICsyMDE0LDEyIEBAIGJvb2wgbWVzaF9jb25maWdfd3JpdGVfc2VxX251bWJlcihzdHJ1Y3Qg
bWVzaF9jb25maWcgKmNmZywgdWludDMyX3Qgc2VxLA0KPiAgCQl0aW1lcnN1Yigmbm93LCAmY2Zn
LT53cml0ZV90aW1lLCAmZWxhcHNlZCk7DQo+ICAJCWVsYXBzZWRfbXMgPSBlbGFwc2VkLnR2X3Nl
YyAqIDEwMDAgKyBlbGFwc2VkLnR2X3VzZWMgLyAxMDAwOw0KPiAgDQo+ICsJCS8qIElmIHRpbWUg
c2luY2UgbGFzdCB3cml0ZSBpcyB6ZXJvLCB0aGlzIG1lYW5zIHRoYXQNCj4gKwkJICogaWRsZV9z
YXZlX2NvbmZpZyBpcyBhbHJlYWR5IHBlbmRpbmcsIHNvIHdlIGRvbid0IG5lZWQgdG8gZG8NCj4g
KwkJICogYW55dGhpbmcuICovDQo+ICsJCWlmICghZWxhcHNlZF9tcykNCj4gKwkJCXJldHVybiB0
cnVlOw0KPiArDQo+ICAJCWNhY2hlZCA9IHNlcSArIChzZXEgLSBjZmctPndyaXRlX3NlcSkgKg0K
PiAgCQkJCQkxMDAwICogTUlOX1NFUV9DQUNIRV9USU1FIC8gZWxhcHNlZF9tczsNCj4gIA0K
