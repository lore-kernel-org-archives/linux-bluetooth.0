Return-Path: <SRS0=HCMd=3D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1190DC33CB1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 14:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC3E2467D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 14:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Ab1JZXnu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgANOm2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jan 2020 09:42:28 -0500
Received: from mga04.intel.com ([192.55.52.120]:7744 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727285AbgANOm1 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jan 2020 09:42:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 06:42:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,433,1571727600"; 
   d="scan'208";a="397527978"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga005.jf.intel.com with ESMTP; 14 Jan 2020 06:42:27 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Jan 2020 06:42:26 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 14 Jan 2020 06:42:26 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 14 Jan 2020 06:42:26 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 14 Jan 2020 06:42:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0fvdH3+/cQXJV2IptVIl7D6lwGeAGq6BV2GAtvbrwrdQe93WdEVF2i03irrXEvpAEeZslffdtsi35QD/cppujzmGXZ9WNBrjs+3cDsneSfPvSMT89n9BzyDSXNLi9m3QHdh3uFXn1RZYauWaoQhhERnicx0ifqyeJm8RW+4OCi08LqEdUhNMur0hrK9ufP42HX6JnGBRYUYImBtxH59YiH4ZT3l6zL9Tutu6TeacLRq1+wsbNWzi2tMv2R5O93VVOkr3hcs8+z306SRMyGKBCTlkaHlnmRAZh0w8OBp9JE/seX6MZhMxpV6Ttm2Ni+y2+KfV6Cf+QPJNShoB/YtRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWytlJmrzqXJhxVKKK1c8j0HmdYoN1/CpBDI3pHPgkc=;
 b=NBlj061k6zuwcdawB7g5HE/7nlRt4u06ZMo0axN3FlW95mdtB13/WvTHCV+GXTGYXxVVnt2p7sUOqPaLtUb/n5Hw0y8V1XsJRt9D+rfSveUQTdgHBUBP+6gIdz055mTw8qJZezc/ZmTXyrYrovbZ3peCHEb9ZkYCwIDmNV1TIt8riSCo4IzSrwrrwbZnM+FLVm+dLlyvQGrVO8KYPAiOT0qkxTMHuG8lv/qjYhVSqk5E4TzRYbjm75HfBDVm+zt+xPGyoHh+zIaGyPHFm4EBTSE036qSw3NOXNZQJCa49ds9hs4vbNYkBPrIsmtK/sb0gDigYfpkH1lsyekljzUCtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWytlJmrzqXJhxVKKK1c8j0HmdYoN1/CpBDI3pHPgkc=;
 b=Ab1JZXnuISp19JGyZcgyJjUM8A+xjanfGV+28mqZ5dJuoQbYi5UvqRfIIRG2h8/dnoS6zUl9JDguurAnNjKd4aWWCguzHIMS2iIySHHSxFhIdnODPzffZCSl/8nDzLqwdHbIAAOtu1fxjgnfNvkb4mjddvMABObfYZA/WEDhuI4=
Received: from MWHPR11MB1664.namprd11.prod.outlook.com (10.172.54.13) by
 MWHPR11MB1805.namprd11.prod.outlook.com (10.175.56.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Tue, 14 Jan 2020 14:42:21 +0000
Received: from MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e]) by MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e%6]) with mapi id 15.20.2623.017; Tue, 14 Jan 2020
 14:42:21 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] tools/mesh: Fix check condition for model ID
Thread-Topic: [PATCH BlueZ] tools/mesh: Fix check condition for model ID
Thread-Index: AQHVxxSDqlePmUjl60K+ta9KcIBYnqfqQ30A
Date:   Tue, 14 Jan 2020 14:42:21 +0000
Message-ID: <1c7ef73f9f9c190048ab375d3711a7a2785366df.camel@intel.com>
References: <20200109174409.18135-1-inga.stotland@intel.com>
In-Reply-To: <20200109174409.18135-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6ef5dd0-daa7-429d-93a8-08d798fff66b
x-ms-traffictypediagnostic: MWHPR11MB1805:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1805633AA103FBFB05868F79E1340@MWHPR11MB1805.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(189003)(199004)(498600001)(6506007)(6486002)(36756003)(91956017)(66476007)(6636002)(8936002)(81156014)(8676002)(76116006)(81166006)(71200400001)(2616005)(6512007)(66946007)(110136005)(2906002)(66556008)(5660300002)(64756008)(66446008)(86362001)(186003)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR11MB1805;H:MWHPR11MB1664.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h8HAmVvq5itJ2kVEjytA3vTZYwO/WUl3q1so6PN4io68TjRut1owWQbIQxXnly1ksceGu6foqLeC+RyiiSSYj4cbZI/YqIMuGsAHmQ+Yl48QM7ST1nYhUXXpnUiz2zyDecYzGZbL/9ZTNOHia4fzHod5OYLxHqKZxkNZglye7nYfwW69an5sN4cJSK5stBez6xyvL1tW1ooHErtMyynW4c8vk9AHYmZwZCulE7ektM85AVAtuq+vkYmSRuAY1igwaga2z6coPe0l3wkqF0DRud+3Je8O5vQHP2fHVSL3hCCRbR02BlbT3KUSB4WgWidv6htJZIB/wgyt7Tik09dMaSfS1fsLAko5LAzkU+IPjD95D9NRvgTHZwl6v5LO47xnexyfx++PK7JQ1kIyp5yyli8YF9j1DJFlz25RyTQGEczTKLb8mFspdIBCkSve0DFU
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F7CE84E55174249B88553AC1384696A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ef5dd0-daa7-429d-93a8-08d798fff66b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 14:42:21.3542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dDcSXGsEZCwOGvj0JY30eYk73zWUCdffIDi7soXyH+Iif4tNZN+FHPWXigRmZHKLgj0n1KP/SN/DzdjvzylSUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1805
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gVGh1LCAyMDIwLTAxLTA5IGF0IDA5OjQ0IC0wODAwLCBJbmdhIFN0b3RsYW5k
IHdyb3RlOg0KPiBVc2UgdGhlIHZhbHVlIG9mIFZFTkRPUl9JRF9NQVNLIHRvIHNldC9jaGVjayB2
ZW5kb3IgbW9kZWwNCj4gYW5kIFNJRyBtb2RlbCBJRHMNCj4gLS0tDQo+ICB0b29scy9tZXNoL2Nm
Z2NsaS5jIHwgNCArKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL21lc2gvY2ZnY2xpLmMgYi90b29s
cy9tZXNoL2NmZ2NsaS5jDQo+IGluZGV4IDFmY2Y4MjAzNS4uMjQwM2M5MjkzIDEwMDY0NA0KPiAt
LS0gYS90b29scy9tZXNoL2NmZ2NsaS5jDQo+ICsrKyBiL3Rvb2xzL21lc2gvY2ZnY2xpLmMNCj4g
QEAgLTI0Nyw3ICsyNDcsNyBAQCBzdGF0aWMgdWludDMyX3QgcHJpbnRfbW9kX2lkKHVpbnQ4X3Qg
KmRhdGEsIGJvb2wgdmlkLCBjb25zdCBjaGFyICpvZmZzZXQpDQo+ICAJaWYgKCF2aWQpIHsNCj4g
IAkJbW9kX2lkID0gZ2V0X2xlMTYoZGF0YSk7DQo+ICAJCWJ0X3NoZWxsX3ByaW50ZigiJXNNb2Rl
bCBJZFx0JTQuNHhcbiIsIG9mZnNldCwgbW9kX2lkKTsNCj4gLQkJbW9kX2lkID0gMHhmZmZmMDAw
MCB8IG1vZF9pZDsNCj4gKwkJbW9kX2lkID0gVkVORE9SX0lEX01BU0sgfCBtb2RfaWQ7DQo+ICAJ
fSBlbHNlIHsNCj4gIAkJbW9kX2lkID0gZ2V0X2xlMTYoZGF0YSArIDIpOw0KPiAgCQlidF9zaGVs
bF9wcmludGYoIiVzTW9kZWwgSWRcdCU0LjR4ICU0LjR4XG4iLCBvZmZzZXQsDQo+IEBAIC0zMjcs
NyArMzI3LDcgQEAgc3RhdGljIHZvaWQgcHJpbnRfcHViKHVpbnQxNl90IGVsZV9hZGRyLCB1aW50
MzJfdCBtb2RfaWQsDQo+ICAJYnRfc2hlbGxfcHJpbnRmKCJcdEVsZW1lbnQ6ICU0LjR4XG4iLCBl
bGVfYWRkcik7DQo+ICAJYnRfc2hlbGxfcHJpbnRmKCJcdFB1YiBBZGRyOiAlNC40eFxuIiwgcHVi
LT51LmFkZHIxNik7DQo+ICANCj4gLQlpZiAobW9kX2lkID4gMHhmZmZmMDAwMCkNCj4gKwlpZiAo
bW9kX2lkIDwgVkVORE9SX0lEX01BU0spDQo+ICAJCWJ0X3NoZWxsX3ByaW50ZigiXHRNb2RlbDog
JTguOHhcbiIsIG1vZF9pZCk7DQo+ICAJZWxzZQ0KPiAgCQlidF9zaGVsbF9wcmludGYoIlx0TW9k
ZWw6ICU0LjR4XG4iLA0K
