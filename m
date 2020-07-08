Return-Path: <SRS0=eST2=AT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4D1C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jul 2020 17:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8132D206E9
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jul 2020 17:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="UgNAq/Oo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgGHR4u (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:56:50 -0400
Received: from mga09.intel.com ([134.134.136.24]:57442 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgGHR4t (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jul 2020 13:56:49 -0400
IronPort-SDR: sQu6qFDshyIX+lcBhkEAx3wMQQahyIsmmcAVLBZNXrucz+7SHypNurH0VnfiEjgrJpL79JYc0B
 KosoaIA+XGYg==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="149374277"
X-IronPort-AV: E=Sophos;i="5.75,328,1589266800"; 
   d="scan'208";a="149374277"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 10:56:48 -0700
IronPort-SDR: qAAGtQj3L8yf12pdLUGmT4nhPvmov9ql8YvlJgrP6fmH8zgwftyJ7U8/frJk2WkI/Y2UDkVs97
 wFM3mHQo6P3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,328,1589266800"; 
   d="scan'208";a="388887560"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga001.fm.intel.com with ESMTP; 08 Jul 2020 10:56:48 -0700
Received: from orsmsx121.amr.corp.intel.com (10.22.225.226) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 8 Jul 2020 10:56:47 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX121.amr.corp.intel.com (10.22.225.226) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 8 Jul 2020 10:56:47 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 8 Jul 2020 10:56:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifKwJ7emoTAc/9rHAg5WJzgBjKziSqgV1gdEDyza23DqYE9u93FO0d+MBrmtQqMEABmyUnCZWkFxynCLGvnW99zEYNenerrawL3iHUJzEybjfxzJU/k9GcVILcGFeF4vrXnq4mTQih5CJbS4EcakXnVR5bznQJ96fOsWqaO192YV2WPrlJMv42abhnEO8949YSB5s+R+Ppqxa5dMYuXexIBY7IfnlwC1DtjM0jWSkLGp0C0W8/SFAdJhOebdvoV4ixM0xG6LVJtQPbBMihaMnnDuvLr9u3xaXRUNL5Csq1t+kI5tjFTZJ5ML8SlpEFUWuPqwWRaUQ91aYHOvees2jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ti7VqL0Co1R0rSjW6L58VCpXOw9IEn9HsNlSvOSpTuo=;
 b=eaRaavLg7FMhKQFuIb1cXLNcEXxrztMueNfiyBxZ0HZP1gTtMws3KOYS1SxK0UFlsAVYaQqeZ8I78cBRfnn4j+KBoiEiC5h23UkXl11uTT31WZZXCNYuAk2C+xiIjoPaO+spHE4K/0z+HAkzprmp5Ig8HgKIDV1dP9i2UdH8aY4ZhyC8yUg2bqXZgkXBUflFPpezbwjo8Yw3AkxvZj/5dNEOiJKIiuEn2sbdXrDmnbznnroK9mSrcnWUpVrrNnPhTH4YEKr3Ly+4kmbbjhDKkPuwjG6M5/iUCx6ur/fRVWdK/4+cwSHvsdkjatr+WUKP2TGqvLSYCeZcfIBM0lbwww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ti7VqL0Co1R0rSjW6L58VCpXOw9IEn9HsNlSvOSpTuo=;
 b=UgNAq/OoNAWDr7yaNQqXm+XezUCsrKO2lKrHzQ1Rm2u/NdZyG4fQEqHMELMIARLV0BnyKv+X/ORc/nJaNHQ/bM9sdV/BiIL/oVduKmqJvhf2D3STT2OTwLjG7eXc/wTrLZumBhXxx15D8O9w94MvHo1cKcdm5TIFAZVHuQ/AsqY=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR11MB1264.namprd11.prod.outlook.com (2603:10b6:300:27::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Wed, 8 Jul
 2020 17:56:47 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225%7]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 17:56:47 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ 1/2] mesh: Get rid of "unreliable opcodes" in config
 server
Thread-Topic: [PATCH BlueZ 1/2] mesh: Get rid of "unreliable opcodes" in
 config server
Thread-Index: AQHWVH3xZ/3pazV0xUKUuhkvaEFGoaj9+U4A
Date:   Wed, 8 Jul 2020 17:56:46 +0000
Message-ID: <e36e42899f144c92a30c61ecf5f8e28c487e7a90.camel@intel.com>
References: <20200707164439.24146-1-inga.stotland@intel.com>
In-Reply-To: <20200707164439.24146-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4d14be7-0100-4da6-e856-08d823684864
x-ms-traffictypediagnostic: MWHPR11MB1264:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB12648D48D0A82447200F5F3FE1670@MWHPR11MB1264.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-forefront-prvs: 04583CED1A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ovMxnsjze0zW2ZvyeqS2Bvcft8ap/uJeODYT4oZo3KLSC+LYBe+5+9mERXWLQ5xFKqS/KHebFDjhBovbz1ls4o612LSabxBVB/ZYKO9chx3vH4Pd0fJn9xcVZ+jdxdBMGMvio1qgQZdlP64zQmBqAzzCUKr1CesuDiO+c1GxodFJHGmgyDEmlvgMSNyUwLuUPFsUSoQw6TNoz03hJX7UM3xv21t62+0FbZYJgixWJH1l/cXrqvB4yvotJkms7ZqqlqzJ1EDS3jEeg7KiqeAGZffg6UQZbffiDpC6XVmwHqkYvo72uEvZh0p9INfd0CaKGatQxHh2DR0W7jv2vPsyVTYuFnUOkHahPftA0S5NddJEWC2DIdCktxKpMKG3IQSD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(66946007)(66446008)(6636002)(66476007)(110136005)(8676002)(86362001)(26005)(71200400001)(316002)(6486002)(8936002)(2616005)(2906002)(6506007)(6512007)(5660300002)(186003)(36756003)(66556008)(64756008)(91956017)(478600001)(76116006)(83380400001)(26583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 7MsCJeGRI3aeZpeuMgSJFLjXyOidtQ3y/uilWV2k7+WmKuC+qjAXqewnUsMKv18ICgwHvhyHZelhapAv4litktUNkpftjxlbdBCjT4IskkR6vAQhCHDwBnl471Wm/oZ3pcfymdafwwzuucO2BElBuaqTyoiai9ClZZeh68w7nfmXQnONip4VjNgNNzzjwX29zarWBPaWmanriQJEE9FM8hi/+4xL4LXNTOHjIY9NtpjAQib0jqg55Wab1T0Q+wDjc1WUTLt8rBORPA01OttGx27P+WuR8ff2EuviecowwWlyGx6zE1XevuB776FosjbNtb5gsJYw1yNoOaEInt23TuTN90pK3oWcT/y4rM/dqRfrnd7yOXMcd3t2/HnKcSBo/xD/mpgBoYNtYseosFbvpmeS1SX/yuuobJ8wNe9T8Q6GWJegSE8IWvBeXWuIG1CjGr/zhXIAU5XeVABgUKFAbgFGqSuskJucWOJ6RExZnsE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <17C8926655AB9643A4BD68C5DD2A4ED3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d14be7-0100-4da6-e856-08d823684864
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2020 17:56:46.9953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jWQiJlKLG5pO4FrfUV/1WAFa6I2bMOkFoNszJURrndyI/IzxyTktrSgZu8tMtsNhzm9BUfYryhU6c0fawpp0Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1264
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2hzZXQgQXBwbGllZA0KDQpPbiBUdWUsIDIwMjAtMDctMDcgYXQgMDk6NDQgLTA3MDAsIElu
Z2EgU3RvdGxhbmQgd3JvdGU6DQo+IFRoaXMgcmVtb3ZlcyBhbiBvbGQgbm90aW9uIG9mIHVucmVs
aWFibGUgb3Bjb2RlcyBpbiBjb25maWcgc2VydmVyDQo+IG1vZGVsICwgaS5lLiwgYSBjb3JyZWN0
bHkgZm9ybWF0dGVkIGFja25vd2xlZGdlZCBtZXNzYWdlIGFsd2F5cw0KPiBnZXRzIGEgcmVzcG9u
c2UuDQo+IC0tLQ0KPiAgbWVzaC9jZmdtb2Qtc2VydmVyLmMgfCAzMSArKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0tLS0tDQo+ICBtZXNoL21vZGVsLmggICAgICAgICB8ICAyIC0tDQo+ICAyIGZp
bGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDIyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL21lc2gvY2ZnbW9kLXNlcnZlci5jIGIvbWVzaC9jZmdtb2Qtc2VydmVyLmMNCj4g
aW5kZXggYzUyNWQ5ZDI0Li44YmE5YmM2ZWMgMTAwNjQ0DQo+IC0tLSBhL21lc2gvY2ZnbW9kLXNl
cnZlci5jDQo+ICsrKyBiL21lc2gvY2ZnbW9kLXNlcnZlci5jDQo+IEBAIC05OCw5ICs5OCw4IEBA
IHN0YXRpYyB2b2lkIGNvbmZpZ19wdWJfZ2V0KHN0cnVjdCBtZXNoX25vZGUgKm5vZGUsIHVpbnQx
Nl90IG5ldF9pZHgsDQo+ICB9DQo+ICANCj4gIHN0YXRpYyB2b2lkIGNvbmZpZ19wdWJfc2V0KHN0
cnVjdCBtZXNoX25vZGUgKm5vZGUsIHVpbnQxNl90IG5ldF9pZHgsDQo+IC0JCQkJCXVpbnQxNl90
IHNyYywgdWludDE2X3QgZHN0LA0KPiAtCQkJCQljb25zdCB1aW50OF90ICpwa3QsIGJvb2wgdmly
dCwNCj4gLQkJCQkJYm9vbCB2ZW5kb3IsIGJvb2wgdW5yZWxpYWJsZSkNCj4gKwkJCQl1aW50MTZf
dCBzcmMsIHVpbnQxNl90IGRzdCwNCj4gKwkJCQljb25zdCB1aW50OF90ICpwa3QsIGJvb2wgdmly
dCwgYm9vbCB2ZW5kb3IpDQo+ICB7DQo+ICAJdWludDMyX3QgbW9kX2lkOw0KPiAgCXVpbnQxNl90
IGVsZV9hZGRyLCBpZHgsIG90YSA9IFVOQVNTSUdORURfQUREUkVTUzsNCj4gQEAgLTE0Myw5ICsx
NDIsOCBAQCBzdGF0aWMgdm9pZCBjb25maWdfcHViX3NldChzdHJ1Y3QgbWVzaF9ub2RlICpub2Rl
LCB1aW50MTZfdCBuZXRfaWR4LA0KPiAgCQkJCQlzdGF0dXMsIGVsZV9hZGRyLCBvdGEsIG1vZF9p
ZCwgaWR4KTsNCj4gIA0KPiAgCWlmIChzdGF0dXMgIT0gTUVTSF9TVEFUVVNfU1VDQ0VTUykgew0K
PiAtCQlpZiAoIXVucmVsaWFibGUpDQo+IC0JCQlzZW5kX3B1Yl9zdGF0dXMobm9kZSwgbmV0X2lk
eCwgc3JjLCBkc3QsIHN0YXR1cywNCj4gLQkJCQkJZWxlX2FkZHIsIG1vZF9pZCwgMCwgMCwgMCwg
MCwgMCwgMCk7DQo+ICsJCXNlbmRfcHViX3N0YXR1cyhub2RlLCBuZXRfaWR4LCBzcmMsIGRzdCwg
c3RhdHVzLCBlbGVfYWRkciwNCj4gKwkJCQkJCW1vZF9pZCwgMCwgMCwgMCwgMCwgMCwgMCk7DQo+
ICANCj4gIAkJcmV0dXJuOw0KPiAgCX0NCj4gQEAgLTE4MCwxMCArMTc4LDggQEAgc3RhdGljIHZv
aWQgY29uZmlnX3B1Yl9zZXQoc3RydWN0IG1lc2hfbm9kZSAqbm9kZSwgdWludDE2X3QgbmV0X2lk
eCwNCj4gIAkJCXN0YXR1cyA9IE1FU0hfU1RBVFVTX1NUT1JBR0VfRkFJTDsNCj4gIAl9DQo+ICAN
Cj4gLQlpZiAoIXVucmVsaWFibGUpDQo+IC0JCXNlbmRfcHViX3N0YXR1cyhub2RlLCBuZXRfaWR4
LCBzcmMsIGRzdCwgc3RhdHVzLCBlbGVfYWRkciwNCj4gLQkJCQkJbW9kX2lkLCBvdGEsIGlkeCwg
Y3JlZF9mbGFnLCB0dGwsDQo+IC0JCQkJCXBlcmlvZCwgcmV0cmFuc21pdCk7DQo+ICsJc2VuZF9w
dWJfc3RhdHVzKG5vZGUsIG5ldF9pZHgsIHNyYywgZHN0LCBzdGF0dXMsIGVsZV9hZGRyLCBtb2Rf
aWQsIG90YSwNCj4gKwkJCQlpZHgsIGNyZWRfZmxhZywgdHRsLCBwZXJpb2QsIHJldHJhbnNtaXQp
Ow0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgdm9pZCBzZW5kX3N1Yl9zdGF0dXMoc3RydWN0IG1lc2hf
bm9kZSAqbm9kZSwgdWludDE2X3QgbmV0X2lkeCwNCj4gQEAgLTMxMSw3ICszMDcsNiBAQCBzdGF0
aWMgdm9pZCBjb25maWdfc3ViX3NldChzdHJ1Y3QgbWVzaF9ub2RlICpub2RlLCB1aW50MTZfdCBu
ZXRfaWR4LA0KPiAgCQkJCQlib29sIHZpcnQsIHVpbnQzMl90IG9wY29kZSkNCj4gIHsNCj4gIAl1
aW50MTZfdCBncnAsIGVsZV9hZGRyOw0KPiAtCWJvb2wgdW5yZWxpYWJsZSA9ICEhKG9wY29kZSAm
IE9QX1VOUkVMSUFCTEUpOw0KPiAgCXVpbnQzMl90IG1vZF9pZDsNCj4gIAljb25zdCB1aW50OF90
ICphZGRyID0gTlVMTDsNCj4gIAlpbnQgc3RhdHVzID0gTUVTSF9TVEFUVVNfU1VDQ0VTUzsNCj4g
QEAgLTM2OSw3ICszNjQsNyBAQCBzdGF0aWMgdm9pZCBjb25maWdfc3ViX3NldChzdHJ1Y3QgbWVz
aF9ub2RlICpub2RlLCB1aW50MTZfdCBuZXRfaWR4LA0KPiAgCX0gZWxzZQ0KPiAgCQlncnAgPSBV
TkFTU0lHTkVEX0FERFJFU1M7DQo+ICANCj4gLQlzd2l0Y2ggKG9wY29kZSAmIH5PUF9VTlJFTElB
QkxFKSB7DQo+ICsJc3dpdGNoIChvcGNvZGUpIHsNCj4gIAlkZWZhdWx0Og0KPiAgCQlsX2RlYnVn
KCJCYWQgb3Bjb2RlOiAleCIsIG9wY29kZSk7DQo+ICAJCXJldHVybjsNCj4gQEAgLTQxMSw4ICs0
MDYsOCBAQCBzdGF0aWMgdm9pZCBjb25maWdfc3ViX3NldChzdHJ1Y3QgbWVzaF9ub2RlICpub2Rl
LCB1aW50MTZfdCBuZXRfaWR4LA0KPiAgCQlncnAgPSBVTkFTU0lHTkVEX0FERFJFU1M7DQo+ICAJ
CS8qIEZhbGwgVGhyb3VnaCAqLw0KPiAgCWNhc2UgT1BfQ09ORklHX01PREVMX1NVQl9ERUxFVEU6
DQo+IC0JCXN0YXR1cyA9IG1lc2hfbW9kZWxfc3ViX2RlbChub2RlLCBlbGVfYWRkciwgbW9kX2lk
LA0KPiAtCQkJCQkJCWFkZHIsIHZpcnQsICZncnApOw0KPiArCQlzdGF0dXMgPSBtZXNoX21vZGVs
X3N1Yl9kZWwobm9kZSwgZWxlX2FkZHIsIG1vZF9pZCwgYWRkciwgdmlydCwNCj4gKwkJCQkJCQkJ
CSZncnApOw0KPiAgDQo+ICAJCWlmIChzdGF0dXMgPT0gTUVTSF9TVEFUVVNfU1VDQ0VTUykNCj4g
IAkJCXNhdmVfY29uZmlnX3N1Yihub2RlLCBlbGVfYWRkciwgbW9kX2lkLCB2ZW5kb3IsIGFkZHIs
DQo+IEBAIC00MjEsMTAgKzQxNiw3IEBAIHN0YXRpYyB2b2lkIGNvbmZpZ19zdWJfc2V0KHN0cnVj
dCBtZXNoX25vZGUgKm5vZGUsIHVpbnQxNl90IG5ldF9pZHgsDQo+ICAJCWJyZWFrOw0KPiAgCX0N
Cj4gIA0KPiAtCWlmICghdW5yZWxpYWJsZSkNCj4gLQkJc2VuZF9zdWJfc3RhdHVzKG5vZGUsIG5l
dF9pZHgsIHNyYywgZHN0LCBzdGF0dXMsIGVsZV9hZGRyLA0KPiAtCQkJCQkJCQlncnAsIG1vZF9p
ZCk7DQo+IC0NCj4gKwlzZW5kX3N1Yl9zdGF0dXMobm9kZSwgbmV0X2lkeCwgc3JjLCBkc3QsIHN0
YXR1cywgZWxlX2FkZHIsIGdycCwgbW9kX2lkKTsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIHZvaWQg
c2VuZF9tb2RlbF9hcHBfc3RhdHVzKHN0cnVjdCBtZXNoX25vZGUgKm5vZGUsIHVpbnQxNl90IG5l
dF9pZHgsDQo+IEBAIC03ODYsOCArNzc4LDcgQEAgc3RhdGljIGJvb2wgY2ZnX3Nydl9wa3QodWlu
dDE2X3Qgc3JjLCB1aW50MTZfdCBkc3QsIHVpbnQxNl90IGFwcF9pZHgsDQo+ICAJCQlyZXR1cm4g
dHJ1ZTsNCj4gIA0KPiAgCQljb25maWdfcHViX3NldChub2RlLCBuZXRfaWR4LCBzcmMsIGRzdCwg
cGt0LCB2aXJ0LA0KPiAtCQkJCQkJc2l6ZSA9PSAxMyB8fCBzaXplID09IDI3LA0KPiAtCQkJCQkJ
ISEob3Bjb2RlICYgT1BfVU5SRUxJQUJMRSkpOw0KPiArCQkJCQkJc2l6ZSA9PSAxMyB8fCBzaXpl
ID09IDI3KTsNCj4gIAkJYnJlYWs7DQo+ICANCj4gIAljYXNlIE9QX0NPTkZJR19NT0RFTF9QVUJf
R0VUOg0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9tb2RlbC5oIGIvbWVzaC9tb2RlbC5oDQo+IGluZGV4
IGY3MTdmYjAwYy4uMDM3N2QzZmRkIDEwMDY0NA0KPiAtLS0gYS9tZXNoL21vZGVsLmgNCj4gKysr
IGIvbWVzaC9tb2RlbC5oDQo+IEBAIC0xOSw4ICsxOSw2IEBADQo+ICANCj4gIHN0cnVjdCBtZXNo
X21vZGVsOw0KPiAgDQo+IC0jZGVmaW5lIE9QX1VOUkVMSUFCTEUJCQkweDAxMDANCj4gLQ0KPiAg
I2RlZmluZSBNQVhfQklORElOR1MJMTANCj4gICNkZWZpbmUgTUFYX0dSUF9QRVJfTU9ECTEwDQo+
ICANCg==
