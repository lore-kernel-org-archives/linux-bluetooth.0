Return-Path: <SRS0=HOwO=YF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9E7C4360C
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Oct 2019 16:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF2AC206CD
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Oct 2019 16:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Mwx/lEnb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbfJLQfB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Oct 2019 12:35:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:35310 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbfJLQfB (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Oct 2019 12:35:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2019 09:35:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,288,1566889200"; 
   d="scan'208";a="206776366"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga002.jf.intel.com with ESMTP; 12 Oct 2019 09:34:59 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 12 Oct 2019 09:34:59 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 12 Oct 2019 09:34:59 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 12 Oct 2019 09:34:59 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (104.47.34.56) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Sat, 12 Oct 2019 09:34:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpJJCHp7oalp+V8M9sk68Vm3vKEjZvZKfrUXzkkznXboB0J4u1hpWvww/HPPGJZ/GNGA4PUNXUMEEapR+ahmAa1uuy8BiB1t/Q0oR9drYGQuYWPfCOQEfi9I2a7pDEqRPcBeRBcI6YS+xsAfTdkMlDkGFH4sSm8aVP1qMle+i3l2CjEK7T8iA7l+hjItSpFZntQtdfI5Xun5g80ZNNYZ+Y3Gjv9SL/2+wauzMC+88DUzg2KBBsqgjsnhSShHmHdrpDkMWCZfpNjlFdmGEsmyLDjWP/C+gVTH9RW0mnaJENfdRG5Nj2ZwvPGeZBI2btKyjd+2WwIfz3ll1d9xh7MGhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCtQl3/e/y16l4zCNAiX29ZOUU8FddlSHcqNETKId7k=;
 b=LybWenFn+/yh+aKC/3N7G8PpEeB6pPnvqurWHNr4O4KxjoJiwqs/GKDtDO6W7kd1eOw+SmUMPpjRp+/CgIH/gGbHJtEUjvd8WDs+FPXNs86NZp4vsnDjQrdN1esTspy37Xjm0GUnBNtHxGWRD4MLZLWQLCJgPcrGM3mMlFdxAhRCwP8rIh3tJuYkZmh6QzdO8jnWuIHxfE2MTFAgwIb9rVCTyfI2iChkcLEEWo8dkg08iAm9qyGruRiEtLhdGqjU6SACgv6dSQWPLoJY/7tqfnj9e4P4nzTzHQ1OC1X8XfNTH2/OIRBLQXIcwLshGwNzfOs2CvxRgcQkdrKIWMS6bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCtQl3/e/y16l4zCNAiX29ZOUU8FddlSHcqNETKId7k=;
 b=Mwx/lEnbn1aG12/KUA5YkSEt9TOmIvfqlVZ5erq24+BuHKEzalJkv6TwJ1L0yKoPesfd6Dcmd0JUpCaJbsdKXqP3/Vz352Qjhqpla8XQ2A8BWQDt47vkhv2EDsmP+TKLOhVrR8XPUlo8r9KhlocNpvaKN96gUmTCdm84SlcOEXM=
Received: from DM6PR11MB4412.namprd11.prod.outlook.com (52.132.248.86) by
 DM6PR11MB3674.namprd11.prod.outlook.com (20.178.231.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Sat, 12 Oct 2019 16:34:57 +0000
Received: from DM6PR11MB4412.namprd11.prod.outlook.com
 ([fe80::256c:4683:ec9f:6a19]) by DM6PR11MB4412.namprd11.prod.outlook.com
 ([fe80::256c:4683:ec9f:6a19%5]) with mapi id 15.20.2347.021; Sat, 12 Oct 2019
 16:34:57 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
Subject: Re: [PATCH BlueZ] unit: Fix valgrind errors in test-mesh-crypto
Thread-Topic: [PATCH BlueZ] unit: Fix valgrind errors in test-mesh-crypto
Thread-Index: AQHVgFnKn3yT/lcRdU2eH4NFQJ5QXqdXNUIA
Date:   Sat, 12 Oct 2019 16:34:57 +0000
Message-ID: <1106234e53c79be7c7424574c38dc9173f2b3e83.camel@intel.com>
References: <20191011173129.14941-1-brian.gix@intel.com>
In-Reply-To: <20191011173129.14941-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5632f53b-6ce0-443e-bc7f-08d74f321eb3
x-ms-traffictypediagnostic: DM6PR11MB3674:
x-microsoft-antispam-prvs: <DM6PR11MB367453E1855816A30C5AB06CE1960@DM6PR11MB3674.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 0188D66E61
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(136003)(39860400002)(366004)(199004)(189003)(11346002)(5640700003)(256004)(229853002)(99286004)(446003)(86362001)(14444005)(81166006)(2351001)(14454004)(486006)(2501003)(305945005)(25786009)(81156014)(6512007)(102836004)(76176011)(316002)(8676002)(2616005)(6916009)(36756003)(8936002)(6506007)(478600001)(76116006)(7736002)(4326008)(6486002)(71200400001)(71190400001)(91956017)(26005)(118296001)(66556008)(186003)(66446008)(2906002)(66476007)(5660300002)(6246003)(66066001)(476003)(66946007)(6436002)(64756008)(4001150100001)(6116002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR11MB3674;H:DM6PR11MB4412.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wFlltSCEMEuXmoXiXyFe6ev/tFYrXZaURL1La2Otm3E1wby2gp27u5W7439Md/lYM8B1UXTtA03nFeLf612LyT8roPhrf4Ga/oOz6qRHdW+aCfPZI2wJ8rYEXUspLvuBV51u3H1DpfWa+/qScM1kV/MM1BVwcVJhojwStdXf1mLvZhC/yXrYKqrh9XagKAnajX9w9D1lDp91W4ayviANrlzGSGgSD8kax1j/BxE6PozFZ7KiQZFeHpnSHPykLx7AwVT4e5BB0wdqwJpT1PslM8z7xmkPbmdUNYIbeXRYAOPkkFXK7doOqJt7pK5xT0rtQQM9ZKepp+SX8PKe1yGK5aNpHRL35P8NEam2aHqCCqy01s9c2P79tF2Xdrdnbrw8yHjnuKnMdHpca9PvL7rmNyfUC1J9OKFJ0OE6BxarnFA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B67BA89162C6046B13B9205AC297258@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5632f53b-6ce0-443e-bc7f-08d74f321eb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2019 16:34:57.6520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zwbvC0dNoQMUzrn2pAFv9UpGKJZWkChqWnPPBnrV/wodMiSx7JGWoHfx2z5RXSnK2IyVx8iVaeICSJMhEcHXAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3674
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBGcmksIDIwMTktMTAtMTEgYXQgMTA6MzEgLTA3MDAsIEJyaWFuIEdpeCB3
cm90ZToNCj4gVHdvIEhFQVAgZXJyb3JzLCBhbmQgb25lIGVycm9yIGNhdXNlZCBieSBtaXNzaW5n
IGNoZWNrc3VtIGRhdGEuDQo+IC0tLQ0KPiAgdW5pdC90ZXN0LW1lc2gtY3J5cHRvLmMgfCAzMiAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDI4IGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdW5pdC90ZXN0
LW1lc2gtY3J5cHRvLmMgYi91bml0L3Rlc3QtbWVzaC1jcnlwdG8uYw0KPiBpbmRleCA2YWNiOWMw
YjYuLjZjMmQzNjczNiAxMDA2NDQNCj4gLS0tIGEvdW5pdC90ZXN0LW1lc2gtY3J5cHRvLmMNCj4g
KysrIGIvdW5pdC90ZXN0LW1lc2gtY3J5cHRvLmMNCj4gQEAgLTIxNyw3ICsyMTcsOSBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IG1lc2hfY3J5cHRvX3Rlc3QgczhfMl82ID0gew0KPiAgc3RhdGljIGNv
bnN0IHN0cnVjdCBtZXNoX2NyeXB0b190ZXN0IHM4XzNfMSA9IHsNCj4gIAkubmFtZQkJPSAiOC4z
LjEgTWVzc2FnZSAjMSIsDQo+ICANCj4gKwkuYXBwX2tleQk9ICI2Mzk2NDc3MTczNGZiZDc2ZTNi
NDA1MTlkMWQ5NGE0OCIsDQo+ICAJLm5ldF9rZXkJPSAiN2RkNzM2NGNkODQyYWQxOGMxN2MyYjgy
MGM4NGMzZDYiLA0KPiArCS5kZXZfa2V5CT0gIjlkNmRkMGU5NmViMjVkYzE5YTQwZWQ5OTE0Zjhm
MDNmIiwNCj4gIAkuaXZfaW5kZXgJPSAweDEyMzQ1Njc4LA0KPiAgDQo+ICAJLm5ldF90dGwJPSAw
eDAwLA0KPiBAQCAtMjQ0LDggKzI0NiwxMCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG1lc2hfY3J5
cHRvX3Rlc3QgczhfM18xID0gew0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBtZXNoX2NyeXB0b190
ZXN0IHM4XzNfMiA9IHsNCj4gIAkubmFtZQkJPSAiOC4zLjIgTWVzc2FnZSAjMiIsDQo+ICANCj4g
LQkuaXZfaW5kZXgJPSAweDEyMzQ1Njc4LA0KPiArCS5hcHBfa2V5CT0gIjYzOTY0NzcxNzM0ZmJk
NzZlM2I0MDUxOWQxZDk0YTQ4IiwNCj4gIAkubmV0X2tleQk9ICI3ZGQ3MzY0Y2Q4NDJhZDE4YzE3
YzJiODIwYzg0YzNkNiIsDQo+ICsJLmRldl9rZXkJPSAiOWQ2ZGQwZTk2ZWIyNWRjMTlhNDBlZDk5
MTRmOGYwM2YiLA0KPiArCS5pdl9pbmRleAk9IDB4MTIzNDU2NzgsDQo+ICANCj4gIAkuY3RsCQk9
IHRydWUsDQo+ICAJLm5ldF90dGwJPSAweDAwLA0KPiBAQCAtMjcxLDcgKzI3NSw5IEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgbWVzaF9jcnlwdG9fdGVzdCBzOF8zXzIgPSB7DQo+ICBzdGF0aWMgY29u
c3Qgc3RydWN0IG1lc2hfY3J5cHRvX3Rlc3QgczhfM18zID0gew0KPiAgCS5uYW1lCQk9ICI4LjMu
MyBNZXNzYWdlICMzIiwNCj4gIA0KPiArCS5hcHBfa2V5CT0gIjYzOTY0NzcxNzM0ZmJkNzZlM2I0
MDUxOWQxZDk0YTQ4IiwNCj4gIAkubmV0X2tleQk9ICI3ZGQ3MzY0Y2Q4NDJhZDE4YzE3YzJiODIw
Yzg0YzNkNiIsDQo+ICsJLmRldl9rZXkJPSAiOWQ2ZGQwZTk2ZWIyNWRjMTlhNDBlZDk5MTRmOGYw
M2YiLA0KPiAgCS5pdl9pbmRleAk9IDB4MTIzNDU2NzgsDQo+ICANCj4gIAkuY3RsCQk9IHRydWUs
DQo+IEBAIC0yOTgsNyArMzA0LDkgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtZXNoX2NyeXB0b190
ZXN0IHM4XzNfMyA9IHsNCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbWVzaF9jcnlwdG9fdGVzdCBz
OF8zXzQgPSB7DQo+ICAJLm5hbWUJCT0gIjguMy40IE1lc3NhZ2UgIzQiLA0KPiAgDQo+ICsJLmFw
cF9rZXkJPSAiNjM5NjQ3NzE3MzRmYmQ3NmUzYjQwNTE5ZDFkOTRhNDgiLA0KPiAgCS5uZXRfa2V5
CT0gIjdkZDczNjRjZDg0MmFkMThjMTdjMmI4MjBjODRjM2Q2IiwNCj4gKwkuZGV2X2tleQk9ICI5
ZDZkZDBlOTZlYjI1ZGMxOWE0MGVkOTkxNGY4ZjAzZiIsDQo+ICAJLml2X2luZGV4CT0gMHgxMjM0
NTY3OCwNCj4gIA0KPiAgCS5uZXRfbmlkCT0gMHg1ZSwNCj4gQEAgLTMzMSw3ICszMzksOSBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IG1lc2hfY3J5cHRvX3Rlc3QgczhfM180ID0gew0KPiAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBtZXNoX2NyeXB0b190ZXN0IHM4XzNfNSA9IHsNCj4gIAkubmFtZQkJPSAi
OC4zLjUgTWVzc2FnZSAjNSIsDQo+ICANCj4gKwkuYXBwX2tleQk9ICI2Mzk2NDc3MTczNGZiZDc2
ZTNiNDA1MTlkMWQ5NGE0OCIsDQo+ICAJLm5ldF9rZXkJPSAiN2RkNzM2NGNkODQyYWQxOGMxN2My
YjgyMGM4NGMzZDYiLA0KPiArCS5kZXZfa2V5CT0gIjlkNmRkMGU5NmViMjVkYzE5YTQwZWQ5OTE0
ZjhmMDNmIiwNCj4gIAkuaXZfaW5kZXgJPSAweDEyMzQ1Njc4LA0KPiAgDQo+ICAJLm5ldF9uaWQJ
PSAweDVlLA0KPiBAQCAtMzY0LDYgKzM3NCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbWVzaF9j
cnlwdG9fdGVzdCBzOF8zXzUgPSB7DQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG1lc2hfY3J5cHRv
X3Rlc3QgczhfM182ID0gew0KPiAgCS5uYW1lCQk9ICI4LjMuNiBNZXNzYWdlICM2IiwNCj4gIA0K
PiArCS5hcHBfa2V5CT0gIjYzOTY0NzcxNzM0ZmJkNzZlM2I0MDUxOWQxZDk0YTQ4IiwNCj4gIAku
bmV0X2tleQk9ICI3ZGQ3MzY0Y2Q4NDJhZDE4YzE3YzJiODIwYzg0YzNkNiIsDQo+ICAJLmRldl9r
ZXkJPSAiOWQ2ZGQwZTk2ZWIyNWRjMTlhNDBlZDk5MTRmOGYwM2YiLA0KPiAgCS5pdl9pbmRleAk9
IDB4MTIzNDU2NzgsDQo+IEBAIC00MDcsNyArNDE4LDkgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBt
ZXNoX2NyeXB0b190ZXN0IHM4XzNfNiA9IHsNCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbWVzaF9j
cnlwdG9fdGVzdCBzOF8zXzcgPSB7DQo+ICAJLm5hbWUJCT0gIjguMy43IE1lc3NhZ2UgIzciLA0K
PiAgDQo+ICsJLmFwcF9rZXkJPSAiNjM5NjQ3NzE3MzRmYmQ3NmUzYjQwNTE5ZDFkOTRhNDgiLA0K
PiAgCS5uZXRfa2V5CT0gIjdkZDczNjRjZDg0MmFkMThjMTdjMmI4MjBjODRjM2Q2IiwNCj4gKwku
ZGV2X2tleQk9ICI5ZDZkZDBlOTZlYjI1ZGMxOWE0MGVkOTkxNGY4ZjAzZiIsDQo+ICAJLml2X2lu
ZGV4CT0gMHgxMjM0NTY3OCwNCj4gIA0KPiAgCS5uZXRfbmlkCT0gMHg2OCwNCj4gQEAgLTQzOSw3
ICs0NTIsOSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG1lc2hfY3J5cHRvX3Rlc3QgczhfM184ID0g
ew0KPiAgCS5zZWdfbWF4CT0gMSwNCj4gIAkuc2VnX251bQk9IDAsDQo+ICANCj4gKwkuYXBwX2tl
eQk9ICI2Mzk2NDc3MTczNGZiZDc2ZTNiNDA1MTlkMWQ5NGE0OCIsDQo+ICAJLm5ldF9rZXkJPSAi
N2RkNzM2NGNkODQyYWQxOGMxN2MyYjgyMGM4NGMzZDYiLA0KPiArCS5kZXZfa2V5CT0gIjlkNmRk
MGU5NmViMjVkYzE5YTQwZWQ5OTE0ZjhmMDNmIiwNCj4gIAkuaXZfaW5kZXgJPSAweDEyMzQ1Njc4
LA0KPiAgDQo+ICAJLm5ldF9uaWQJPSAweDY4LA0KPiBAQCAtNDY4LDcgKzQ4Myw5IEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgbWVzaF9jcnlwdG9fdGVzdCBzOF8zXzggPSB7DQo+ICBzdGF0aWMgY29u
c3Qgc3RydWN0IG1lc2hfY3J5cHRvX3Rlc3QgczhfM185ID0gew0KPiAgCS5uYW1lCQk9ICI4LjMu
OSBNZXNzYWdlICM5IiwNCj4gIA0KPiArCS5hcHBfa2V5CT0gIjYzOTY0NzcxNzM0ZmJkNzZlM2I0
MDUxOWQxZDk0YTQ4IiwNCj4gIAkubmV0X2tleQk9ICI3ZGQ3MzY0Y2Q4NDJhZDE4YzE3YzJiODIw
Yzg0YzNkNiIsDQo+ICsJLmRldl9rZXkJPSAiOWQ2ZGQwZTk2ZWIyNWRjMTlhNDBlZDk5MTRmOGYw
M2YiLA0KPiAgCS5pdl9pbmRleAk9IDB4MTIzNDU2NzgsDQo+ICANCj4gIAkubmV0X25pZAk9IDB4
NjgsDQo+IEBAIC00OTcsOCArNTE0LDEwIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbWVzaF9jcnlw
dG9fdGVzdCBzOF8zXzkgPSB7DQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG1lc2hfY3J5cHRvX3Rl
c3QgczhfM18xMCA9IHsNCj4gIAkubmFtZQkJPSAiOC4zLjEwIE1lc3NhZ2UgIzEwIiwNCj4gIA0K
PiAtCS5pdl9pbmRleAk9IDB4MTIzNDU2NzgsDQo+ICsJLmFwcF9rZXkJPSAiNjM5NjQ3NzE3MzRm
YmQ3NmUzYjQwNTE5ZDFkOTRhNDgiLA0KPiAgCS5uZXRfa2V5CT0gIjdkZDczNjRjZDg0MmFkMThj
MTdjMmI4MjBjODRjM2Q2IiwNCj4gKwkuZGV2X2tleQk9ICI5ZDZkZDBlOTZlYjI1ZGMxOWE0MGVk
OTkxNGY4ZjAzZiIsDQo+ICsJLml2X2luZGV4CT0gMHgxMjM0NTY3OCwNCj4gIA0KPiAgCS5uZXRf
bmlkCT0gMHg1ZSwNCj4gIAkubmV0X3R0bAk9IDB4MDAsDQo+IEBAIC01NDIsOCArNTYxLDEwIEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgbWVzaF9jcnlwdG9fdGVzdCBzOF8zXzExID0gew0KPiAgCS5m
bl9jbnRyCT0gIjA3MmYiLA0KPiAgCS5wCQk9ICIwMTEyMDEyMzQ1MDAwMDA3MmYiLA0KPiAgDQo+
IC0JLml2X2luZGV4CT0gMHgxMjM0NTY3OCwNCj4gKwkuYXBwX2tleQk9ICI2Mzk2NDc3MTczNGZi
ZDc2ZTNiNDA1MTlkMWQ5NGE0OCIsDQo+ICAJLm5ldF9rZXkJPSAiN2RkNzM2NGNkODQyYWQxOGMx
N2MyYjgyMGM4NGMzZDYiLA0KPiArCS5kZXZfa2V5CT0gIjlkNmRkMGU5NmViMjVkYzE5YTQwZWQ5
OTE0ZjhmMDNmIiwNCj4gKwkuaXZfaW5kZXgJPSAweDEyMzQ1Njc4LA0KPiAgDQo+ICAJLm5ldF9u
aWQJPSAweDVlLA0KPiAgCS5uZXRfdHRsCT0gMHgwMywNCj4gQEAgLTEzMzMsNyArMTM1NCw3IEBA
IHN0YXRpYyB2b2lkIGNoZWNrX2RlY3J5cHQoY29uc3Qgc3RydWN0IG1lc2hfY3J5cHRvX3Rlc3Qg
KmtleXMpDQo+ICAJdWludDhfdCBwcml2X3JhbmRbMTZdOw0KPiAgCXVpbnQ4X3QgcFs5XTsNCj4g
IAlzaXplX3QgcF9sZW47DQo+IC0JdWludDhfdCAqcGFja2V0Ow0KPiArCXVpbnQ4X3QgKnBhY2tl
dCA9IE5VTEw7DQo+ICAJc2l6ZV90IHBhY2tldF9sZW47DQo+ICAJY29uc3QgdWludDhfdCAqbmV0
X2hkcjsNCj4gIAl1aW50OF90ICpuZXRfbXNnOw0KPiBAQCAtMTQyNiw2ICsxNDQ3LDcgQEAgc3Rh
dGljIHZvaWQgY2hlY2tfZGVjcnlwdChjb25zdCBzdHJ1Y3QgbWVzaF9jcnlwdG9fdGVzdCAqa2V5
cykNCj4gIAkJbWVzaF9jcnlwdG9fbmV0d29ya19ub25jZShrZXlzLT5mcm5kLCBrZXlzLT5uZXRf
dHRsLA0KPiAgCQkJCWtleXMtPm5ldF9zZXFbaV0sIGtleXMtPm5ldF9zcmMsIGtleXMtPml2X2lu
ZGV4LA0KPiAgCQkJCW5ldF9ub25jZSk7DQo+ICsJCWxfZnJlZShwYWNrZXQpOw0KPiAgCQlwYWNr
ZXQgPSBsX3V0aWxfZnJvbV9oZXhzdHJpbmcoa2V5cy0+cGFja2V0W2ldLCAmcGFja2V0X2xlbik7
DQo+ICANCj4gIAkJbmV0X2hkciA9IHBhY2tldCArIDE7DQo+IEBAIC0xNzMxLDYgKzE3NTMsNyBA
QCBzdGF0aWMgdm9pZCBjaGVja19pZF9iZWFjb24oY29uc3Qgc3RydWN0IG1lc2hfY3J5cHRvX3Rl
c3QgKmtleXMpDQo+ICANCj4gIAlsX2luZm8oIiIpOw0KPiAgDQo+ICsJbF9mcmVlKHJhbmQpOw0K
PiAgCWxfZnJlZShuZXRfa2V5KTsNCj4gIH0NCj4gIA0KPiBAQCAtMTc4NCw2ICsxODA3LDcgQEAg
c3RhdGljIHZvaWQgY2hlY2tfazEyOChjb25zdCBzdHJ1Y3QgbWVzaF9jcnlwdG9fdGVzdCAqa2V5
cykNCj4gIA0KPiAgCXZlcmlmeV9kYXRhKCJrMShOLCBzYWx0LCBpbmZvKSIsIDAsIGtleXMtPmVu
Y19rZXksIGVuY19rZXksIDE2KTsNCj4gIA0KPiArCWxfZnJlZShuZXRfa2V5KTsNCj4gIAlsX2lu
Zm8oIiIpOw0KPiAgfQ0KPiAgDQo=
