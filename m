Return-Path: <SRS0=uFZc=BU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695C7C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Aug 2020 21:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AEDF206B5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Aug 2020 21:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Fgy/TCc9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgHJVuC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:50:02 -0400
Received: from mga14.intel.com ([192.55.52.115]:16681 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgHJVuC (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Aug 2020 17:50:02 -0400
IronPort-SDR: 469zZERuADeIRiRefUtKvvFuxbFNUTZTZ05VlHLJ7EPjBDiXJ6jPMmeR83qEq1w9DZuN7GRls3
 FmZxKvJ5SIFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="152845927"
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="152845927"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 14:50:01 -0700
IronPort-SDR: W1gCXYavQf31ZW1YsMoTsejkYMyBMiKsk9jEHV5NH1KCGJzipRxG439aIUEylFx8Q6xUUvPFwS
 ijlLyFniHf6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="324574770"
Received: from unknown (HELO fmsmsx606.amr.corp.intel.com) ([10.18.84.216])
  by orsmga008.jf.intel.com with ESMTP; 10 Aug 2020 14:50:01 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 10 Aug 2020 14:50:00 -0700
Received: from fmsmsx125.amr.corp.intel.com (10.18.125.40) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 10 Aug 2020 14:50:00 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX125.amr.corp.intel.com (10.18.125.40) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 10 Aug 2020 14:50:00 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 10 Aug 2020 14:50:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrpcUsz46dhHvewyUXsE6MHwfswz3NuFgF51hy7R8CMwfQ2RsghYzQ2kkZLmwikw+m4x81oBfLhEFlYiMK/IzuwTQuK9D4KfCHbMgU2/Emum1+80iI0+GTKzsksJeRCfBnO6epKFF55uZvb5JW0k2XTHdgWYsumeu0Iv73xq/mmqDbJ/rzvgKpl95PDSd3orqETE3EjO9xK4fF8goAcN0Y3uMhTdUAPKpJmFP5XpYvp2v4YVUtTv7dlVcSFuAFjBpxABZljRdCrEvX2wQj/aFh1eJNU8zTTVVoh1Le2vNGaz4BjgGtpziylz3jxZxG/xPlEyBFWL+CZRo9oQmBYzHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyHHK1omVb8oq1N4YRZebn+PAIEyDO9bX8V1PfEsSg4=;
 b=bDJis4TMbTry5RI0yK6cWM9S5NTalepnO7JdycbXObBF8yrPh928ndxbtotiTFho+mMnlo+KsKb3/E14GBWEkfmPqlQkagwYZPBZDJni6DWCNqBNbZ8iK48pEelkQuxfNyay4fDUJrRtBUBCFo+Lew6sb0Lr0GCjQeHT7ItDNg3MZGhT5ieSAmVTzYs+ZKF/n6sf1UG+f78E6IAqBsLr99e8mt97oFIOey+zXwat/LKg3FB74OZRXyftcb1SAqmZGY2jnSYAMm2Fz3S5P7+APO4ShkAOuHo9PBbUXxjg7qyDdXVGcIotAg71Yux2kubnR8VXllLrDkxZNdWTdvXopA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyHHK1omVb8oq1N4YRZebn+PAIEyDO9bX8V1PfEsSg4=;
 b=Fgy/TCc9OPSgiATkUfcuhJshsBN3d428vz7TkVg6X8DsIVlZyu+k/ItCAaw8G9QgVv65OCNjPEHffTvx2ILlh2rkAj6NHWAiE3zDnYZTLa4UvEp1p/BoM+EVYb5vGcuuHKfZ26GV2wawOQK/7dt90YF600rQF4xW2tDx1+ozYLA=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4602.namprd11.prod.outlook.com (2603:10b6:303:52::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15; Mon, 10 Aug
 2020 21:49:59 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225%6]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 21:49:59 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v5 00/10] Mesh Config Server clean up
Thread-Topic: [PATCH BlueZ v5 00/10] Mesh Config Server clean up
Thread-Index: AQHWbFt7eIFIOH2JaUq8r1g1sTtaw6kx56oA
Date:   Mon, 10 Aug 2020 21:49:59 +0000
Message-ID: <dd88995a7d18444affc2c1592b8894b9a9dddb6f.camel@intel.com>
References: <20200807013834.123263-1-inga.stotland@intel.com>
In-Reply-To: <20200807013834.123263-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db3ddbf7-ac90-4c76-5dcc-08d83d77542a
x-ms-traffictypediagnostic: MW3PR11MB4602:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4602AFCBB5279ABBCB385F80E1440@MW3PR11MB4602.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oGHf8wRwMnHmlWgc3q+66u+OgeWdQEowNWKGpt2//L9CmcjiOaLo+XE/7jx1uXZx8zpiferEnKzGtRuQpMjpHWRf3GjdXkFVgcS/zj0KZA4Uw/VUpbDOxn1zqXFoWWEg3ikqAdqWge37fyZ0KUAbF0tJo0/+ItdQztSGWkNHgtAq4vdcCujH3ePdDXn6p3iY86sBwFpduIVHKLSVfts28qfbazpxMhu0mhNxFfMmOYF4RO9M2kuBIwOsvhRdjexEolL0BzPMtnLxMuIcrtYkSCQ2/bWzq9QUl1Coi05XOIaQTiuiXMWaHn/m7Z/DeAlwuYmB04y3L58yg3RMsSDFYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(64756008)(66556008)(6506007)(66446008)(6512007)(83380400001)(478600001)(86362001)(2906002)(186003)(76116006)(36756003)(91956017)(2616005)(66476007)(26005)(66946007)(6636002)(316002)(5660300002)(110136005)(8936002)(8676002)(71200400001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: B38BZwTx3Cdu9bEMM5ZQk2Alom69YYjCx0y/OIOhKR6xApw7XzNn1Uw1ZLeOQOVuAhDy0HritQ4ElX6rCWBx8bEkcfGqzOXt/fQxnS/JhFnrdqrzbFKtpVjmQ0EwczP4tNxWVAZvimp4SEC7tjxkaE8D13LW1OOxy7pdONM2kA9XEalOVb0tjLIY9C/WZDGUxMKGbf41IUpDD0HAHyGgKIAbkZ610/8dqR3JqT1Rc9sVvfaFYZC/2Q9J+4JTH4LWpkI2AIq+lWcgAhrzVUF0xIbHsXCnl7STRnIjBT9fN/AZgPn1DmbWaZ6FfglxiHx71MtgXZ0GaGDRFzux4aU4P6Bnshf+o34bJgpbR0DTHEiRdqohcZjTKL0NRBTMBOHlXPVA3MU3sqwj3juoryKb6RvZ1OpavYxJwzLaa3UDQ5bShu21DQyVz8fjMSQ/VA3DuGLYGqky+DtVbxuhgHIu6xOZaUujsHSH9L3yVIyluG5v7OGxb9pFGsUhKMQPqhZFnHejtHQEtLGTahMdec2EjzpPxSjy3nFIeaHbsJEsZInYbf61aypBRve1alAbUZgR1gixduADR0GsMgZ0tu5SKK6kAABFWChAHZiGVL7l3JhKsHmTiB34o3bgskTaFQ+OK/D7hr7cXgBi88aNXLvgiA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CEB07D90A095F4B83C5CC6F86D8310D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db3ddbf7-ac90-4c76-5dcc-08d83d77542a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2020 21:49:59.3219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sfu/hVL8RoENlvh0XubFD6X8eQm4HZDvrR2IIH1Viq9/RT0LfXJWyZvgDAgeqvjK7lpG4wR3Y7bKxIsofnd6Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4602
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2hzZXQgQXBwbGllZA0KDQpPbiBUaHUsIDIwMjAtMDgtMDYgYXQgMTg6MzggLTA3MDAsIElu
Z2EgU3RvdGxhbmQgd3JvdGU6DQo+IHY1IC0gYWRkcmVzc2VkIG1vcmUgb2YgQnJpYW4ncyBjb21t
ZW50cy4gQWRkZWQgbWlzc2luZyByYW5nZSBjaGVja2luZw0KPiANCj4gKioqKioqKioqKioqKioq
KioqKg0KPiB2NCAtIEZ1cnRoZXIgZml4ZXMgaW4gaGFuZGxpbmcgS2V5IFJlZnJlc2ggUGhhc2Ug
U2V0IG1lc3NhZ2UNCj4gDQo+ICoqKioqKioqKioqKioqKioqKioNCj4gIHYzIC0gYWRkcmVzcyBC
cmlhbidzIGNvbW1lbnRzDQo+ICANCj4gKioqKioqKioqKioqKioqKioqKg0KPiBUaGlzIHBhdGNo
IHNldCBncm91cHMgZnVuY3Rpb25hbGl0eSBieSBjb25maWcgbWVzc2FnZXMuDQo+IEFsc28sIGZp
eGVzIHRoZSBjYXNlcyB3aGVyZSBtYWxmb3JtZWQgbWVzc2FnZXMgc2hvdWxkIGJlICBzaWxlbnRs
eQ0KPiBpZ25vcmVkIGFuZCB0aGUgc2l0dWF0aW9ucyB3aGVuIGluY29ycmVjdCBlcnJvciBzdGF0
dXMNCj4gaXMgc2VudCBpbiByZXNwb25zZS4NCj4gDQo+IA0KPiBJbmdhIFN0b3RsYW5kICgxMCk6
DQo+ICAgbWVzaDogQ2xlYW4gdXAgaGFuZGxpbmcgb2YgY29uZmlnIHN1YnNjcmlwdGlvbiBtZXNz
YWdlcw0KPiAgIG1lc2g6IENsZWFuIHVwIGhhbmRsaW5nIG9mIGNvbmZpZyBtb2RlbCBiaW5kaW5n
IG1lc3NhZ2VzDQo+ICAgbWVzaDogQ2xlYW4gdXAgaGFuZGxpbmcgb2YgY29uZmlnIG5vZGUgaWRl
bnRpdHkgbWVzc2FnZQ0KPiAgIG1lc2g6IENsZWFuIHVwIGhhbmRsaW5nIG9mIGNvbmZpZyBwdWJs
aWNhdGlvbiBtZXNzYWdlcw0KPiAgIG1lc2g6IENsZWFuIHVwIGhhbmRsaW5nIG9mIGNvbmZpZyBu
ZXQgYW5kIGFwcCBrZXkgbWVzc2FnZXMNCj4gICBtZXNoOiBDbGVhbiB1cCBoYW5kbGluZyBvZiBj
b25maWcgcmVsYXkgbWVzc2FnZXMNCj4gICBtZXNoOiBDbGVhbiB1cCBoYW5kbGluZyBvZiBjb25m
aWcgcG9sbCB0aW1lb3V0IG1lc3NhZ2UNCj4gICBtZXNoOiBDbGVhbiB1cCBoYW5kbGluZyBvZiBj
b25maWcgbmV0IHRyYW5zbWl0IG1lc3NhZ2VzDQo+ICAgbWVzaDogQ2xlYW4gdXAgaGFuZGxpbmcg
b2YgY29uZmlnIEtSIHBoYXNlIG1lc3NhZ2VzDQo+ICAgbWVzaDogUmVmYWN0b3IgaGVhcnRiZWF0
IHB1Yi9zdWINCj4gDQo+ICBtZXNoL2NmZ21vZC1zZXJ2ZXIuYyAgICB8IDExOTggKysrKysrKysr
KysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICBtZXNoL2NmZ21vZC5oICAgICAgICAg
ICB8ICAgIDIgKy0NCj4gIG1lc2gvbWVzaC1jb25maWctanNvbi5jIHwgICAxMiArLQ0KPiAgbWVz
aC9tZXNoLWNvbmZpZy5oICAgICAgfCAgICA2ICstDQo+ICBtZXNoL21lc2gtZGVmcy5oICAgICAg
ICB8ICAgIDYgKw0KPiAgbWVzaC9tb2RlbC5jICAgICAgICAgICAgfCAgMjM4ICsrKystLS0tDQo+
ICBtZXNoL21vZGVsLmggICAgICAgICAgICB8ICAgMjEgKy0NCj4gIG1lc2gvbmV0LmMgICAgICAg
ICAgICAgIHwgIDMyNiArKysrKysrLS0tLQ0KPiAgbWVzaC9uZXQuaCAgICAgICAgICAgICAgfCAg
IDU0ICstDQo+ICBtZXNoL25vZGUuaCAgICAgICAgICAgICB8ICAgIDQgLQ0KPiAgMTAgZmlsZXMg
Y2hhbmdlZCwgOTI0IGluc2VydGlvbnMoKyksIDk0MyBkZWxldGlvbnMoLSkNCj4gDQo=
