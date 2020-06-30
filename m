Return-Path: <SRS0=BnFh=AL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC8CC433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Jun 2020 17:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F9CA2068F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Jun 2020 17:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="st3vFT6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390241AbgF3RVB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:21:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:7500 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730584AbgF3RVA (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Jun 2020 13:21:00 -0400
IronPort-SDR: zEhh1MH6fEOe5WrO5ztSD/J0hoSR7SbnrEQ6i7uO8VMIespvOPsipNwizX2GPfd3lNObDg9mHo
 azgcc4jkx6kg==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="126425057"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="126425057"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 10:20:47 -0700
IronPort-SDR: NDNf2pbx/WZ71OBVnYDGBcS0uu/5kqkm56hoi20A4CzgnDJfZQudUuM1Ar1DL4ySbR69A1uL5Z
 u8yxzrQWWLpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="481269202"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jun 2020 10:20:47 -0700
Received: from fmsmsx158.amr.corp.intel.com (10.18.116.75) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 30 Jun 2020 10:20:46 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx158.amr.corp.intel.com (10.18.116.75) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 30 Jun 2020 10:20:46 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 30 Jun 2020 10:20:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcgQLscjAkDcVWukv6DR/xZnLCjl1XQTJPj7H01E9YdJiuzK5hd5Dm/rx7AVjvEFMqEgATGg2ssZLb5/p+0h7cYESCaC4HQj+NHHfy9cvJbjBudiz3fCq7+4qpKVCqaddMnsxDjfj9XiKCedz9zftK43ASAKtfmKJ0mOmhw7YD0YVKFAHUUYbNrOavp9CV79JwhtA5jypUgYjkdAIh5VDXXuxCn5DmKqtbsKo2qAZO7iBYZBcNIDusrbXKpjKy92i+trcf+Zn29R2usNyrdrtV5x/g2Qeb3wiTl6SQM1X1F54dcoB4ndbDj4g5xoruxY/jOC+CXHzN/H6fqZFY8AoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZbDM2P5RCzsiJx6O2+RJ/cBNi7kKPXrvHZyGyoeYaaU=;
 b=I/vhf4sV3CWSm+XwpWvrO7jIS07uwhUwXACdBbibA+4pQ72Qd8dTZVcE/KVq7Zmoo4d17yuq2XAdjfZOKzIk4XpcBpQ+UVxvlZ7qdC+Kb9NDfcc4K/jMYrhzO6Rs+SJ8mT7d+fHvYpceDTBiekPn36kpTnZgvTq37Cqbw9wOL23VIitbi54zIU+vMdE5XCye9Y9fQ15GtFBVL3oYALwXor6SAOm/c7xGl3XaxAxyfS3j4lK6/01/GW6e4fqCzWnWOPMzXfAIObz7CFxOcgS4Bm/7oyo1Z8X4ootJXxov49XaKkyLuU2jqBDXTOFj4r+JolUgzfyD5OBQ8kNRFgeOcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZbDM2P5RCzsiJx6O2+RJ/cBNi7kKPXrvHZyGyoeYaaU=;
 b=st3vFT6IjfbiG0lqAgFGc+n9GzGwnBYVsXEyGQZOHx9yieLKcuyR++unwM0HYR3JiCrPv+o9aHfSZn4HjrkpIL0D5YqpmTk2sHc57PP4ghlRccdIUXxoE0SSvB0E8znJQ6ZLQCv8uWyWzxem8nA2ol4anN6d/4bHPi6nd4DMn9o=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR11MB0048.namprd11.prod.outlook.com (2603:10b6:301:6a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Tue, 30 Jun
 2020 17:20:42 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0%6]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 17:20:42 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Clean up config model publication set
Thread-Topic: [PATCH BlueZ] mesh: Clean up config model publication set
Thread-Index: AQHWTAUTXPNO9zUKekO3sbs/bjsftKjxbYYA
Date:   Tue, 30 Jun 2020 17:20:42 +0000
Message-ID: <72485ce2912bf48377bc577e4b5e1db013b1f2b6.camel@intel.com>
References: <20200626215907.201532-1-inga.stotland@intel.com>
In-Reply-To: <20200626215907.201532-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.139.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21925ace-41f6-4144-cb12-08d81d19eafe
x-ms-traffictypediagnostic: MWHPR11MB0048:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB00482C85F181D9DB6A68624FE16F0@MWHPR11MB0048.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:291;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pbG3/9imGVZzV27PFnxfJUDq7JGHzBd1Fynwl9Gu0o1HG7gXzesV4xw52Yan8nchH0+8ouxdSK6hyisMDQy1Nve0QG4lIEHt5f4EhaWVb/wY+UTFaHjHwL3V4W7lP9t/Nsw5ssLEBLa3mIRw+XdGvEb9PIzJ9Spe7jHjDDTHOE0L5ByEjRMbz2p1GRBAI5Fr0BOGZamBqa8whLDmH1oaRv1C1VV2j2TUbD7jLnfhbGaPapSgUDBpET4gBlSbNaOd8BXsozgvdJHAB1SucCQ2K5T3c0ag+92XvjD6Va8qEeAHHiUeDU4WXZHJkiC5+E2wFHC5GRB0trshO8e3+uWpvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(8936002)(26005)(2906002)(71200400001)(66556008)(64756008)(66946007)(5660300002)(6636002)(76116006)(6506007)(186003)(8676002)(66446008)(66476007)(110136005)(6512007)(86362001)(6486002)(36756003)(478600001)(316002)(83380400001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: g20SiwaDJMU1HyGN2w0cE0CBHy2emJ2Rm0qMBUjFTlAi10FcUDayfIoMhdSJeExCdWfkKKsdAqOYzBGPYEGJR00jOLZvuvIzuS4veiSLfh/F7nC4u3OI5kc+GAXufkhLtnMkBBZiYZijdA7nAl1Dh/s5qOBGGEvTb9lBs7nu7+P1DwPeCpehkfun9pQVCqU+p0H1WwxAwVH+vtAPM25TLa0RgK9S3RKqpcww/1TwwNsJX6p0lZoVzoJBvB3DpU1tmxmPSH/Jjp5SH28USwS4rZV5lIiHSv5TgwJ5QldxCUeZ5FJGoW0yykKpb8MTy2ibMyny17AzO1ZFwHKNdKz3rH1+DeJB6DqSUsxvK+6/2hg5pRGqmokYUy3a+IDRhbV3C1WReKZuxwiqFT8sONbVodKmCjO5bw1ZRKqn0PLjOhpNxhmVYhd/7z4YJQYuEAvcShise6qkxtLBbZ/M8o+H6yX2vqnTuAWqBMBVqB+OXeXDBc+6rmLfV2zdDIJtzzXb
Content-Type: text/plain; charset="utf-8"
Content-ID: <C98D3F81F7722544B4316DF96F7C0905@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21925ace-41f6-4144-cb12-08d81d19eafe
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 17:20:42.5107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mcw5/CyoAz2nLTFoWUwTs7wUJi+vHN9WSMRICGRdH2ATBshNOkPzyKpDiYyYcL4rpOfNquAONmqvvosijzChCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0048
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBGcmksIDIwMjAtMDYtMjYgYXQgMTQ6NTkgLTA3MDAsIEluZ2EgU3RvdGxh
bmQgd3JvdGU6DQo+IE5vIGZ1bmN0aW9hbCBjaGFuZ2VzLiBNYWtlIGNvZGUgbW9yZSByZWFkYWJs
ZSwgcGx1cyBzdHlsZSBmaXhlcy4NCj4gLS0tDQo+ICBtZXNoL2NmZ21vZC1zZXJ2ZXIuYyB8IDc3
ICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMzcgaW5zZXJ0aW9ucygrKSwgNDAgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvbWVzaC9jZmdtb2Qtc2VydmVyLmMgYi9tZXNoL2NmZ21vZC1zZXJ2ZXIuYw0KPiBpbmRl
eCA5MDIyMjhhZTAuLmM1MjVkOWQyNCAxMDA2NDQNCj4gLS0tIGEvbWVzaC9jZmdtb2Qtc2VydmVy
LmMNCj4gKysrIGIvbWVzaC9jZmdtb2Qtc2VydmVyLmMNCj4gQEAgLTQ2LDEyICs0NiwxMCBAQCBz
dGF0aWMgdm9pZCBzZW5kX3B1Yl9zdGF0dXMoc3RydWN0IG1lc2hfbm9kZSAqbm9kZSwgdWludDE2
X3QgbmV0X2lkeCwNCj4gIAluID0gbWVzaF9tb2RlbF9vcGNvZGVfc2V0KE9QX0NPTkZJR19NT0RF
TF9QVUJfU1RBVFVTLCBtc2cpOw0KPiAgCW1zZ1tuKytdID0gc3RhdHVzOw0KPiAgCWxfcHV0X2xl
MTYoZWxlX2FkZHIsIG1zZyArIG4pOw0KPiAtCW4gKz0gMjsNCj4gLQlsX3B1dF9sZTE2KHB1Yl9h
ZGRyLCBtc2cgKyBuKTsNCj4gLQluICs9IDI7DQo+ICsJbF9wdXRfbGUxNihwdWJfYWRkciwgbXNn
ICsgbiArIDIpOw0KPiAgCWlkeCB8PSBjcmVkX2ZsYWcgPyBDUkVERkxBR19NQVNLIDogMDsNCj4g
LQlsX3B1dF9sZTE2KGlkeCwgbXNnICsgbik7DQo+IC0JbiArPSAyOw0KPiArCWxfcHV0X2xlMTYo
aWR4LCBtc2cgKyBuICsgNCk7DQo+ICsJbiArPSA2Ow0KPiAgCW1zZ1tuKytdID0gdHRsOw0KPiAg
CW1zZ1tuKytdID0gcGVyaW9kOw0KPiAgCW1zZ1tuKytdID0gcmV0cmFuc21pdDsNCj4gQEAgLTYx
LDE2ICs1OSwxNSBAQCBzdGF0aWMgdm9pZCBzZW5kX3B1Yl9zdGF0dXMoc3RydWN0IG1lc2hfbm9k
ZSAqbm9kZSwgdWludDE2X3QgbmV0X2lkeCwNCj4gIAkJbiArPSAyOw0KPiAgCX0gZWxzZSB7DQo+
ICAJCWxfcHV0X2xlMTYobW9kX2lkID4+IDE2LCBtc2cgKyBuKTsNCj4gLQkJbiArPSAyOw0KPiAt
CQlsX3B1dF9sZTE2KG1vZF9pZCwgbXNnICsgbik7DQo+IC0JCW4gKz0gMjsNCj4gKwkJbF9wdXRf
bGUxNihtb2RfaWQsIG1zZyArIG4gKyAyKTsNCj4gKwkJbiArPSA0Ow0KPiAgCX0NCj4gIA0KPiAg
CW1lc2hfbW9kZWxfc2VuZChub2RlLCBkc3QsIHNyYywgQVBQX0lEWF9ERVZfTE9DQUwsIG5ldF9p
ZHgsIERFRkFVTFRfVFRMLA0KPiAgCQkJCQkJCQlmYWxzZSwgbXNnLCBuKTsNCj4gIH0NCj4gIA0K
PiAtc3RhdGljIGJvb2wgY29uZmlnX3B1Yl9nZXQoc3RydWN0IG1lc2hfbm9kZSAqbm9kZSwgdWlu
dDE2X3QgbmV0X2lkeCwNCj4gK3N0YXRpYyB2b2lkIGNvbmZpZ19wdWJfZ2V0KHN0cnVjdCBtZXNo
X25vZGUgKm5vZGUsIHVpbnQxNl90IG5ldF9pZHgsDQo+ICAJCQkJCXVpbnQxNl90IHNyYywgdWlu
dDE2X3QgZHN0LA0KPiAgCQkJCQljb25zdCB1aW50OF90ICpwa3QsIHVpbnQxNl90IHNpemUpDQo+
ICB7DQo+IEBAIC04Niw3ICs4Myw3IEBAIHN0YXRpYyBib29sIGNvbmZpZ19wdWJfZ2V0KHN0cnVj
dCBtZXNoX25vZGUgKm5vZGUsIHVpbnQxNl90IG5ldF9pZHgsDQo+ICAJCW1vZF9pZCA9IGxfZ2V0
X2xlMTYocGt0ICsgMikgPDwgMTY7DQo+ICAJCW1vZF9pZCB8PSBsX2dldF9sZTE2KHBrdCArIDQp
Ow0KPiAgCX0gZWxzZQ0KPiAtCQlyZXR1cm4gZmFsc2U7DQo+ICsJCXJldHVybjsNCj4gIA0KPiAg
CWVsZV9hZGRyID0gbF9nZXRfbGUxNihwa3QpOw0KPiAgCXB1YiA9IG1lc2hfbW9kZWxfcHViX2dl
dChub2RlLCBlbGVfYWRkciwgbW9kX2lkLCAmc3RhdHVzKTsNCj4gQEAgLTk4LDE2ICs5NSwxNSBA
QCBzdGF0aWMgYm9vbCBjb25maWdfcHViX2dldChzdHJ1Y3QgbWVzaF9ub2RlICpub2RlLCB1aW50
MTZfdCBuZXRfaWR4LA0KPiAgCWVsc2UNCj4gIAkJc2VuZF9wdWJfc3RhdHVzKG5vZGUsIG5ldF9p
ZHgsIHNyYywgZHN0LCBzdGF0dXMsIGVsZV9hZGRyLA0KPiAgCQkJCW1vZF9pZCwgMCwgMCwgMCwg
MCwgMCwgMCk7DQo+IC0JcmV0dXJuIHRydWU7DQo+ICB9DQo+ICANCj4gIHN0YXRpYyB2b2lkIGNv
bmZpZ19wdWJfc2V0KHN0cnVjdCBtZXNoX25vZGUgKm5vZGUsIHVpbnQxNl90IG5ldF9pZHgsDQo+
ICAJCQkJCXVpbnQxNl90IHNyYywgdWludDE2X3QgZHN0LA0KPiAtCQkJCQljb25zdCB1aW50OF90
ICpwa3QsIHVpbnQ4X3QgdmlydF9vZmZzZXQsDQo+ICsJCQkJCWNvbnN0IHVpbnQ4X3QgKnBrdCwg
Ym9vbCB2aXJ0LA0KPiAgCQkJCQlib29sIHZlbmRvciwgYm9vbCB1bnJlbGlhYmxlKQ0KPiAgew0K
PiAgCXVpbnQzMl90IG1vZF9pZDsNCj4gLQl1aW50MTZfdCBlbGVfYWRkciwgaWR4LCBvdGEgPSAw
Ow0KPiArCXVpbnQxNl90IGVsZV9hZGRyLCBpZHgsIG90YSA9IFVOQVNTSUdORURfQUREUkVTUzsN
Cj4gIAljb25zdCB1aW50OF90ICpwdWJfYWRkcjsNCj4gIAl1aW50MTZfdCB0ZXN0X2FkZHI7DQo+
ICAJdWludDhfdCB0dGwsIHBlcmlvZDsNCj4gQEAgLTExNSwzNCArMTExLDMzIEBAIHN0YXRpYyB2
b2lkIGNvbmZpZ19wdWJfc2V0KHN0cnVjdCBtZXNoX25vZGUgKm5vZGUsIHVpbnQxNl90IG5ldF9p
ZHgsDQo+ICAJaW50IHN0YXR1czsNCj4gIAlib29sIGNyZWRfZmxhZzsNCj4gIA0KPiAtCWlkeCA9
IGxfZ2V0X2xlMTYocGt0ICsgNCArIHZpcnRfb2Zmc2V0KTsNCj4gLQl0dGwgPSBwa3RbNiArIHZp
cnRfb2Zmc2V0XTsNCj4gLQlwZXJpb2QgPSBwa3RbNyArIHZpcnRfb2Zmc2V0XTsNCj4gLQlyZXRy
YW5zbWl0ID0gcGt0WzggKyB2aXJ0X29mZnNldF07DQo+IC0JbW9kX2lkID0gbF9nZXRfbGUxNihw
a3QgKyA5ICsgdmlydF9vZmZzZXQpOw0KPiArCWVsZV9hZGRyID0gbF9nZXRfbGUxNihwa3QpOw0K
PiArCXB1Yl9hZGRyID0gcGt0ICsgMjsNCj4gKw0KPiArCXBrdCArPSAodmlydCA/IDE0IDogMCk7
DQo+ICsNCj4gKwlpZHggPSBsX2dldF9sZTE2KHBrdCArIDQpOw0KPiArCXR0bCA9IHBrdFs2XTsN
Cj4gKwlwZXJpb2QgPSBwa3RbN107DQo+ICsJcmV0cmFuc21pdCA9IHBrdFs4XTsNCj4gKwltb2Rf
aWQgPSBsX2dldF9sZTE2KHBrdCArIDkpOw0KPiAgDQo+ICAJaWYgKCF2ZW5kb3IpDQo+ICAJCW1v
ZF9pZCB8PSBWRU5ET1JfSURfTUFTSzsNCj4gIAllbHNlDQo+IC0JCW1vZF9pZCA9IChtb2RfaWQg
PDwgMTYpIHwgbF9nZXRfbGUxNihwa3QgKyAxMSArIHZpcnRfb2Zmc2V0KTsNCj4gLQ0KPiAtCWVs
ZV9hZGRyID0gbF9nZXRfbGUxNihwa3QpOw0KPiAtCXB1Yl9hZGRyID0gcGt0ICsgMjsNCj4gKwkJ
bW9kX2lkID0gKG1vZF9pZCA8PCAxNikgfCBsX2dldF9sZTE2KHBrdCArIDExKTsNCj4gIA0KPiAt
CS8qIERvZXNuJ3QgYWNjZXB0IHZpcnR1YWwgc2VlbWluZyBhZGRyZXNzZXMgKi8NCj4gKwkvKiBE
b24ndCBhY2NlcHQgdmlydHVhbCBzZWVtaW5nIGFkZHJlc3NlcyAqLw0KPiAgCXRlc3RfYWRkciA9
IGxfZ2V0X2xlMTYocHViX2FkZHIpOw0KPiAtCWlmICghdmlydF9vZmZzZXQgJiYgSVNfVklSVFVB
TCh0ZXN0X2FkZHIpKQ0KPiArCWlmICghdmlydCAmJiBJU19WSVJUVUFMKHRlc3RfYWRkcikpDQo+
ICAJCXJldHVybjsNCj4gIA0KPiAtCS8qIEdldCBjcmVkX2ZsYWcgKi8NCj4gIAljcmVkX2ZsYWcg
PSAhIShDUkVERkxBR19NQVNLICYgaWR4KTsNCj4gLQ0KPiAtCS8qIEdldCBBcHBLZXkgaW5kZXgg
Ki8NCj4gIAlpZHggJj0gQVBQX0lEWF9NQVNLOw0KPiAgDQo+ICAJc3RhdHVzID0gbWVzaF9tb2Rl
bF9wdWJfc2V0KG5vZGUsIGVsZV9hZGRyLCBtb2RfaWQsIHB1Yl9hZGRyLCBpZHgsDQo+ICAJCQkJ
CWNyZWRfZmxhZywgdHRsLCBwZXJpb2QsIHJldHJhbnNtaXQsDQo+IC0JCQkJCXZpcnRfb2Zmc2V0
ICE9IDAsICZvdGEpOw0KPiArCQkJCQl2aXJ0LCAmb3RhKTsNCj4gIA0KPiAgCWxfZGVidWcoInB1
Yl9zZXQ6IHN0YXR1cyAlZCwgZWEgJTQuNHgsIG90YTogJTQuNHgsIG1vZDogJXgsIGlkeDogJTMu
M3giLA0KPiAgCQkJCQlzdGF0dXMsIGVsZV9hZGRyLCBvdGEsIG1vZF9pZCwgaWR4KTsNCj4gQEAg
LTE1NSwxNiArMTUwLDE3IEBAIHN0YXRpYyB2b2lkIGNvbmZpZ19wdWJfc2V0KHN0cnVjdCBtZXNo
X25vZGUgKm5vZGUsIHVpbnQxNl90IG5ldF9pZHgsDQo+ICAJCXJldHVybjsNCj4gIAl9DQo+ICAN
Cj4gLQlpZiAoSVNfVU5BU1NJR05FRChvdGEpICYmICF2aXJ0X29mZnNldCkgew0KPiArCWlmIChJ
U19VTkFTU0lHTkVEKHRlc3RfYWRkcikgJiYgIXZpcnQpIHsNCj4gIAkJdHRsID0gcGVyaW9kID0g
aWR4ID0gMDsNCj4gIA0KPiAgCQkvKiBSZW1vdmUgbW9kZWwgcHVibGljYXRpb24gZnJvbSBjb25m
aWcgZmlsZSAqLw0KPiAtCQltZXNoX2NvbmZpZ19tb2RlbF9wdWJfZGVsKG5vZGVfY29uZmlnX2dl
dChub2RlKSwgZWxlX2FkZHIsDQo+ICsJCWlmICghbWVzaF9jb25maWdfbW9kZWxfcHViX2RlbChu
b2RlX2NvbmZpZ19nZXQobm9kZSksIGVsZV9hZGRyLA0KPiAgCQkJCXZlbmRvciA/IG1vZF9pZCA6
IG1vZF9pZCAmIH5WRU5ET1JfSURfTUFTSywNCj4gLQkJCQkJCQkJdmVuZG9yKTsNCj4gKwkJCQkJ
CQkJCXZlbmRvcikpDQo+ICsJCQlzdGF0dXMgPSBNRVNIX1NUQVRVU19TVE9SQUdFX0ZBSUw7DQo+
ICAJfSBlbHNlIHsNCj4gIAkJc3RydWN0IG1lc2hfY29uZmlnX3B1YiBkYl9wdWIgPSB7DQo+IC0J
CQkudmlydCA9ICh2aXJ0X29mZnNldCAhPSAwKSwNCj4gKwkJCS52aXJ0ID0gdmlydCwNCj4gIAkJ
CS5hZGRyID0gb3RhLA0KPiAgCQkJLmlkeCA9IGlkeCwNCj4gIAkJCS50dGwgPSB0dGwsDQo+IEBA
IC0xNzQsNyArMTcwLDcgQEAgc3RhdGljIHZvaWQgY29uZmlnX3B1Yl9zZXQoc3RydWN0IG1lc2hf
bm9kZSAqbm9kZSwgdWludDE2X3QgbmV0X2lkeCwNCj4gIAkJCS5pbnRlcnZhbCA9ICgocmV0cmFu
c21pdCA+PiAzKSArIDEpICogNTANCj4gIAkJfTsNCj4gIA0KPiAtCQlpZiAodmlydF9vZmZzZXQp
DQo+ICsJCWlmICh2aXJ0KQ0KPiAgCQkJbWVtY3B5KGRiX3B1Yi52aXJ0X2FkZHIsIHB1Yl9hZGRy
LCAxNik7DQo+ICANCj4gIAkJLyogU2F2ZSBtb2RlbCBwdWJsaWNhdGlvbiB0byBjb25maWcgZmls
ZSAqLw0KPiBAQCAtMTg2LDcgKzE4Miw4IEBAIHN0YXRpYyB2b2lkIGNvbmZpZ19wdWJfc2V0KHN0
cnVjdCBtZXNoX25vZGUgKm5vZGUsIHVpbnQxNl90IG5ldF9pZHgsDQo+ICANCj4gIAlpZiAoIXVu
cmVsaWFibGUpDQo+ICAJCXNlbmRfcHViX3N0YXR1cyhub2RlLCBuZXRfaWR4LCBzcmMsIGRzdCwg
c3RhdHVzLCBlbGVfYWRkciwNCj4gLQkJCW1vZF9pZCwgb3RhLCBpZHgsIGNyZWRfZmxhZywgdHRs
LCBwZXJpb2QsIHJldHJhbnNtaXQpOw0KPiArCQkJCQltb2RfaWQsIG90YSwgaWR4LCBjcmVkX2Zs
YWcsIHR0bCwNCj4gKwkJCQkJcGVyaW9kLCByZXRyYW5zbWl0KTsNCj4gIH0NCj4gIA0KPiAgc3Rh
dGljIHZvaWQgc2VuZF9zdWJfc3RhdHVzKHN0cnVjdCBtZXNoX25vZGUgKm5vZGUsIHVpbnQxNl90
IG5ldF9pZHgsDQo+IEBAIC03ODEsMTYgKzc3OCwxNiBAQCBzdGF0aWMgYm9vbCBjZmdfc3J2X3Br
dCh1aW50MTZfdCBzcmMsIHVpbnQxNl90IGRzdCwgdWludDE2X3QgYXBwX2lkeCwNCj4gIAkJaWYg
KHNpemUgIT0gMjUgJiYgc2l6ZSAhPSAyNykNCj4gIAkJCXJldHVybiB0cnVlOw0KPiAgDQo+IC0J
CWNvbmZpZ19wdWJfc2V0KG5vZGUsIG5ldF9pZHgsIHNyYywgZHN0LCBwa3QsIDE0LCBzaXplID09
IDI3LA0KPiAtCQkJCSEhKG9wY29kZSAmIE9QX1VOUkVMSUFCTEUpKTsNCj4gLQkJYnJlYWs7DQo+
ICsJCXZpcnQgPSB0cnVlOw0KPiArCQkvKiBGYWxsIFRocm91Z2ggKi8NCj4gIA0KPiAgCWNhc2Ug
T1BfQ09ORklHX01PREVMX1BVQl9TRVQ6DQo+IC0JCWlmIChzaXplICE9IDExICYmIHNpemUgIT0g
MTMpDQo+ICsJCWlmICghdmlydCAmJiAoc2l6ZSAhPSAxMSAmJiBzaXplICE9IDEzKSkNCj4gIAkJ
CXJldHVybiB0cnVlOw0KPiAgDQo+IC0JCWNvbmZpZ19wdWJfc2V0KG5vZGUsIG5ldF9pZHgsIHNy
YywgZHN0LCBwa3QsIDAsIHNpemUgPT0gMTMsDQo+IC0JCQkJISEob3Bjb2RlICYgT1BfVU5SRUxJ
QUJMRSkpOw0KPiArCQljb25maWdfcHViX3NldChub2RlLCBuZXRfaWR4LCBzcmMsIGRzdCwgcGt0
LCB2aXJ0LA0KPiArCQkJCQkJc2l6ZSA9PSAxMyB8fCBzaXplID09IDI3LA0KPiArCQkJCQkJISEo
b3Bjb2RlICYgT1BfVU5SRUxJQUJMRSkpOw0KPiAgCQlicmVhazsNCj4gIA0KPiAgCWNhc2UgT1Bf
Q09ORklHX01PREVMX1BVQl9HRVQ6DQo=
