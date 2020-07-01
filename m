Return-Path: <SRS0=mBsK=AM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970C9C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jul 2020 19:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EA1520720
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jul 2020 19:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="C3tej9Q7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgGATLN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Jul 2020 15:11:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:19098 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbgGATLM (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Jul 2020 15:11:12 -0400
IronPort-SDR: WtHhUZ+EN2X0FcQOXEjYJ9LYvF2vCGtNaBwPMwRH4naV18xG6Ko39QELPze0oqVuCvJQ74BU78
 JQP+Ow5puSLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="126306171"
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; 
   d="scan'208";a="126306171"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 12:11:12 -0700
IronPort-SDR: eWeAiSZldan/YiB5I5Gyra/H1fDId6G1WRr03f2r8QD8t0liBku8iR75IE+QJUcvSv1cI58WnV
 6dDCXI4tk+UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; 
   d="scan'208";a="481704532"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga005.fm.intel.com with ESMTP; 01 Jul 2020 12:11:12 -0700
Received: from FMSMSX109.amr.corp.intel.com (10.18.116.9) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 1 Jul 2020 12:11:12 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx109.amr.corp.intel.com (10.18.116.9) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 1 Jul 2020 12:11:11 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 1 Jul 2020 12:11:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=inHVn6UAaj6/QMHdSRrMBRK86d0acN0eTKtrJpLg2O5J9w0CfSMDBf1TJ1QqAYURo9S+RqR7okf2svetWeJSdPTrDhlHJUxKIWiDz/niJ7LzIWAwMpT2GgtuKCEnSxIZvBiggxAkCKjNRkFzclKBoMutjT290/TJghnvu2OMM/8X5f1wOGXD6r/rurbp0GgegKSR44pWTiOFsfF3J0fCk+TLtwzUx3tnNP8wuK+K3tgBwl16Ck7RuhqtKS5WIhpRV8FEJ07j34fBZcAOBxQwCf83FKB4K0WUQJgAVb/JoyUUkjwAUWFSr3KBMgy9kj555c98Piq/BweAHjGOjQ5PpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMf8uLMpbiE1cyTqp337bPMRLv9tOLAhviTBrEvlDMc=;
 b=QxYwwt9whu3ZXkJujtEyVtKc4W8wC5cLWDhlhXw8WJ8ZZ4p+xbje1kHUetiY71YFrvUC9rKK9R22HeHIEbuIMFs7vfW/wiqflchJsW1z7bKjg6HWuhHF94BjuOkwx7k7LN7mLwhiL0bqWXScEKm41lqZ4kiHdm/clg7YJ240dNADLzL8qxSbjG7v7LxrAgYTpWfcgniMfXgaAgEBa0sRoIrkDluhoYRKbgikwS5kOWOvK6L7SK23sLrus/5GWtYEQ4n0CApNZXNd3vwLCUgP+TTntJJAy8z1FFR4K4Kt6B4EbqJRylUerpYRxR+b3RQKSMVuCPS7MZSEgGf9tpJokw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMf8uLMpbiE1cyTqp337bPMRLv9tOLAhviTBrEvlDMc=;
 b=C3tej9Q7Bs6ZNQlBuxqw4VQbGZFT7hCRWJN+rYBAos8bzTbmZEPDvMpXJM615P1IpMRRKb6gFDjhVCMVHh0LkYM9tzwTxGzejT1Wel6LFtyaHzFMBME5vLz3PfYI2a+jZgZSP6D095Bh4WBIcZ8+32DGaPANw1LDBVaYnZ6lonQ=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR11MB0047.namprd11.prod.outlook.com (2603:10b6:301:68::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Wed, 1 Jul
 2020 19:11:09 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0%6]) with mapi id 15.20.3131.030; Wed, 1 Jul 2020
 19:11:09 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
Subject: Re: [PATCH BlueZ v2 0/4] Add options to Models and VendorModels
Thread-Topic: [PATCH BlueZ v2 0/4] Add options to Models and VendorModels
Thread-Index: AQHWTxAwejpo6g0RsEuWp6Vedp/nLKjzGKCA
Date:   Wed, 1 Jul 2020 19:11:09 +0000
Message-ID: <7f9da664fa4c34b42d5174f937c06e4ed9902cfe.camel@intel.com>
References: <20200630185617.14755-1-inga.stotland@intel.com>
In-Reply-To: <20200630185617.14755-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f608d76-764b-4a18-a067-08d81df2838e
x-ms-traffictypediagnostic: MWHPR11MB0047:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB00470554277A07211FBE4351E16C0@MWHPR11MB0047.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ewU70pi3ZxtDW0V0rkQp7xJqihE1yNeYoanR0MJybDlsPY/rvbbWwR7M7Xe2Qml4JDRYDPffYMYxpJaJLDdLi7ZUQo9h9OK4b+JquAjIC0nDAWN8mw4rPrprC1XxnNhxvW9UR+9R/JYk19fdpZ4BLkZQvFwa5qgQO2cslla+P3mSHb7qAyh3CcJFicdagyaHEQpLWwtmrN0kSii2KUr5ivl+jyLut9lzvEc5xzpHnYHEEbPzQnWgLxHdtx2KS4zuZ1tKHGcRWHaMNJL16ajYOoV6omIWyO+YAewpjy2SyijCZ8v8Y8oHi8v20tjczb34Ji/qvbTT1MXiDtVe8ustlA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(36756003)(110136005)(6506007)(6512007)(8936002)(8676002)(316002)(6486002)(26005)(86362001)(5660300002)(83380400001)(2906002)(186003)(6636002)(66946007)(478600001)(4326008)(76116006)(71200400001)(91956017)(2616005)(66476007)(66556008)(66446008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: QQEq7sJyHeosgRqyXigcGeBHHTdffqy53FaUjGLsiFwRJuDHAhwAOvaOoAdEhtH3BfkreegqJ5cxAOlIBPx2/snHB6Zkw4x51fv5fRCa65OGHpNr/69fZlTMTZtC7NTmfBe1WDriUBItJ2ahRjBoEjt3E+ZSyYJFPx/bNlyL1qW1xnUDoiaaLhliJFVUEII2e8MUmEyICN2ZDZ3HBqpbLup3ncXx8qXIFYLRRkCYkR2BDbjnWVG5Rl9BfFpQtGIGT2P11eC4gBc4DB0y1MjbdxCodQssEIKVCT9e1g1o0kUoJglFekyXFvr+12aBBRnQAO3c/ilE6eQd4QFTx7W0DTIyxniH23aBzJp8oEZEts3iY9OCMsHNabhdbePUl1zFyIXeVi/davGLeOADWzGmZFv+PLp6aXAnlnazyYwDMGhbCBtSOVoDelvpWQPxw32TvvXaiaU6sH11/D/K1SVsqCGFb20MpXllaAGfxPCx7ic=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B315EF35D7C01148A9B3680607F5AF28@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f608d76-764b-4a18-a067-08d81df2838e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 19:11:09.9010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tSixO+/8FRuM5nqcErJ1ubM/j+vTzsySINnYgbaB4p21c1hBhePPxOjUZ7td02415RJf9sKKZ/17E6SIheSh2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0047
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2hzZXQgQXBwbGllZA0KT24gVHVlLCAyMDIwLTA2LTMwIGF0IDExOjU2IC0wNzAwLCBJbmdh
IFN0b3RsYW5kIHdyb3RlOg0KPiB2MjoNCj4gDQo+IENoYW5nZXMgY29uc3RhbmVkIHRvIHBhdGNo
IDAwMDI6DQo+IA0KPiAtIEZpeGVkIHJldHVybmVkIHN0YXR1cyBpbiBjb25maWcgcHViL3N1YiBt
b2RlbCBjYWxscw0KPiAtIENvbnNpc3RlbnQgdXNlIG9mIHB1Yl9lbmFibGVkICYgc3ViX2VuYWJs
ZWQgaW4gdGhlIGNvZGUNCj4gDQo+ICoqKioqKioqKioqKg0KPiBJZiBhIG1vZGVsIGRvZXMgbm90
IHN1cHBvcnQgZWl0aGVyIHN1YnNjcmlwdGlvbiBtZWNoYW5pc20sDQo+IENvbmZpZyBTZXJ2ZXIg
aXMgc3VwcG9zZWQgdG8gcmV0dXJuICJOb3QgYSBTdWJzY3JpYmUgTW9kZWwiIGlmIGEgQ29uZmln
IENsaWVudCBzZW5kcw0KPiBhIHN1YnNjcmlwdGlvbiBhZGQvb3ZlcndyaXRlIG1lc3NhZ2UuDQo+
IA0KPiBTaW1pbGFybHksIGlmIGEgbW9kZWwgZG9lcyBub3Qgc3VwcG9ydCBwdWJsaWNhdGlvbiwg
IkludmFsaWQgUHVibGlzaCBQYXJhbWV0ZXJzIg0KPiBzaG91bGQgYmUgcmV0dXJuZWQgaW4gcmVz
cG9uc2UgdG8gUHVibGljYXRpb24gU2V0IG1lc3NhZ2UuDQo+IA0KPiBTaW5jZSBjb25maWcgc2Vy
dmVyIGlzIHJ1bm5pbmcgZXZlbiB3aGVuIGFuIGFwcCBpcyBub3QgYXR0YWNoZWQsIHRoZSBvbmx5
IHdheSB0byBjb2xsZWN0DQo+IHRoZXNlIG1vZGVsIGNhcGFiaWxpdGllcyBpcyBvbiBBdHRhY2gs
IEpvaW4sIENyZWF0ZSwgSW1wb3J0IG1ldGhvZHMgd2hlbiB0aGUNCj4gb2JqZWN0IG1hbmFnZXIg
Y29sbGVjdHMgYXBwIGluZm8uDQo+IA0KPiBUbyBhZGRyZXNzIHRoaXMgaXNzdWUsIHNpZ25hdHVy
ZXMgZm9yIHByb3BlcnRpZXMgIk1vZGVscyIgYW5kICJWZW5kb3JNb2RlbHMiIG9uIEVsZW1lbnQN
Cj4gaW50ZXJmYWNlIGNoYW5nZSB0byBpbmNsdWRlICJvcHRpb25zIiBkaWN0aW9uYXJ5Og0KPiAg
ICAgTW9kZWxzOiBzaWduYXR1cmUgY2hhbmdlICJhcSIgLT4gImEocWF7c3Z9KSINCj4gICAgIFZl
bmRvck1vZGVsczogc2lnbmF0dXJlIGNoYW5nZSAiYShxcSkiIC0+ICJhKHFxYXtzdn0pIg0KPiAg
ICAgDQo+IFRoZSBkZWZpbmVkIGtleXdvcmRzIGZvciB0aGUgb3B0aW9ucyBkaWN0aW9uYXJ5IGFy
ZToNCj4gICAgICJQdWJsaXNoIiAtIGluZGljYXRlcyB3aGV0aGVyIHRoZSBtb2RlbCBzdXBwb3J0
cyBwdWJsaWNhdGlvbiBtZWNoYW5pc20uDQo+ICAgICAgICAgICAgICAgICBJZiBub3QgcHJlc2Vu
dCwgcHVibGljYXRpb24gaXMgZW5hYmxlZC4NCj4gICAgICJTdWJzY3JpYmUiIC0gaW5kaWNhdGVz
IHdoZXRoZXIgdGhlIG1vZGVsIHN1cHBvcnRzIHN1YnNjcmlwdGlvbiBtZWNoYW5pc20uDQo+ICAg
ICAgICAgICAgICAgICBJZiBub3QgcHJlc2VudCwgc3Vic2NyaXB0aW9ucyBhcmUgZW5hYmxlZC4N
Cj4gDQo+IEluZ2EgU3RvdGxhbmQgKDQpOg0KPiAgIGRvYy9tZXNoLWFwaTogQWRkIGRpY3Rpb25h
cnkgdG8gbW9kZWwgcHJvcGVydGllcw0KPiAgIG1lc2g6IENoZWNrIGFwcCBtb2RlbCBzZXR0aW5n
cyBvZiBwdWIvc3ViIHN1cHBvcnQNCj4gICB0b29scy9tZXNoLWNmZ2NsaWVudDogQWRkIG9wdGlv
bnMgdG8gIk1vZGVscyIgcHJvcGVydHkNCj4gICB0ZXN0L3Rlc3QtbWVzaDogQWRkIG9wdGlvbnMg
dG8gIk1vZGVscyIgcHJvcGVydHkNCj4gDQo+ICBkb2MvbWVzaC1hcGkudHh0ICAgICAgICB8ICA0
MCArKysrKysrKy0tDQo+ICBtZXNoL21lc2gtY29uZmlnLWpzb24uYyB8ICA3NiArKysrKysrKysr
KysrKysrKy0NCj4gIG1lc2gvbWVzaC1jb25maWcuaCAgICAgIHwgICA4ICsrDQo+ICBtZXNoL21v
ZGVsLmMgICAgICAgICAgICB8ICA5OCArKysrKysrKysrKysrKysrKysrLS0tLQ0KPiAgbWVzaC9t
b2RlbC5oICAgICAgICAgICAgfCAgIDYgKysNCj4gIG1lc2gvbm9kZS5jICAgICAgICAgICAgIHwg
MTY4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0NCj4gIHRlc3QvdGVz
dC1tZXNoICAgICAgICAgIHwgIDIxICsrLS0tDQo+ICB0b29scy9tZXNoLWNmZ2NsaWVudC5jICB8
ICAyNSArKysrLS0NCj4gIDggZmlsZXMgY2hhbmdlZCwgMzc0IGluc2VydGlvbnMoKyksIDY4IGRl
bGV0aW9ucygtKQ0KPiANCg==
