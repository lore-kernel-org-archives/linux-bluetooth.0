Return-Path: <SRS0=Cjqc=2H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFF2C43603
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Dec 2019 22:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF5420716
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Dec 2019 22:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="KpWZS0x/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfLQWJV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Dec 2019 17:09:21 -0500
Received: from mga09.intel.com ([134.134.136.24]:38328 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbfLQWJU (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Dec 2019 17:09:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 14:09:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,327,1571727600"; 
   d="scan'208";a="217659044"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga006.jf.intel.com with ESMTP; 17 Dec 2019 14:09:20 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 17 Dec 2019 14:09:19 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Dec 2019 14:09:19 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 17 Dec 2019 14:09:19 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 17 Dec 2019 14:09:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOFSq3W0Y4XGlSqk3BwJtP7DPh37SnTf2mInhuctiI71bTxp+qogUxfwVYpiEAc85l6g/XXIcXDBtKJAh9JiZLh1Cuh02v7Tsaa2MEmUW71po72nQp03+QHFJti9xzbk0LEKCQxtXmUulOj904QXoK41EONhR2O2gc/0pFLgMpKlB60l8CSd/ypJYEj0hbgX8i1TitOmNxK2WPWwnHznQPH7L+hkrcu2EcjwKwrKDkCcZl8XsVi3QQjVs/SPD/RtyO/NdHb1NHmBE1ryfBldnyw5woJObTz+X2mpzINDxPhCCPY4T3kiNib9jRUkI/Dc32VKIeYYJHIt9M9yS7wTlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7MX4lgzpPWYdJiVC1vc1eF9y7w9NcI0Afd3Pcwx/LY=;
 b=Ra1LYtKpUJUBw9ntA3uTU5Qist8p+Q27xEkMc4VN+MZJKQzNn7eVbsnw4sXWklJk/TVGIHqLDH7IvwvorQnPJn+MGWSZxKFnG2rWb+n8BJbSFd2Ynoob2+7jOhxcIP/bNKbzk5wa0c7/ZK2l1vDHN/06sOrqtG/glIS28CRZm0fwzpuZmOGdTB9j8u9tX3uF50gaytXHxQvqrAYX83+/EdAdiKykRGtl6uznqwsipUSBgwhRtiyFzp9yS14LieGrZb49INmeOWrPG+Qs0gym+0LxwWdn0YZtJtH6FDWtjOsHQWWvqks459my/Ng31HJSjl9U3gVojSm8PqlzFbL1iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7MX4lgzpPWYdJiVC1vc1eF9y7w9NcI0Afd3Pcwx/LY=;
 b=KpWZS0x/T9R8NgZ4dip55yNntq8+xoCXhyNgJlu2OndqTHLKBZuEywK10sr0VL+F6SEEVVbJT0diHoMgNu3Qqn9mpNf952zQv1bNHJY/2W5Nzd1aVqxjIpIHASkpbQP9mr58w59q3ZTCz18et2ZQj+erIFaj30Y7c8ybgu5Tszc=
Received: from CY4PR11MB1269.namprd11.prod.outlook.com (10.173.16.11) by
 CY4PR11MB1541.namprd11.prod.outlook.com (10.172.68.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.20; Tue, 17 Dec 2019 22:09:12 +0000
Received: from CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::39e0:30e9:a8b0:fe24]) by CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::39e0:30e9:a8b0:fe24%3]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 22:09:12 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: mesh: Handling application failures on Create/Join/Import
Thread-Topic: mesh: Handling application failures on Create/Join/Import
Thread-Index: AQHVtQn6uV8/TznPHkeEUzvQD9wTFae+qsgAgAAClACAAAFCAIAAAuoAgAAB/YCAAA1MAIAAElCAgAAQA4A=
Date:   Tue, 17 Dec 2019 22:09:12 +0000
Message-ID: <c41210651042aa5cc993df9adae61175b50af2ab.camel@intel.com>
References: <20191217184330.coc6c7b7hw4to6vx@kynes>
         <20191217184728.qoapokv7acfyaz33@kynes>
         <a51a523c15b52b9e5d837b7b9a1110a669db4e2b.camel@intel.com>
         <d61fcfad45256fe70b0f8cfaba30e031f57d3ce9.camel@intel.com>
         <20191217191138.ib7socqz4h4i4e5j@kynes>
         <450359d19e8b296f53b5dc03b649d7ce78d9d99a.camel@intel.com>
         <20191217200620.qnbhjevotlxfrwu3@kynes>
         <b019f8a18e0cbf814bfeba080407b02ae1490909.camel@intel.com>
In-Reply-To: <b019f8a18e0cbf814bfeba080407b02ae1490909.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d013ddd7-6115-45b4-de30-08d7833dbfa9
x-ms-traffictypediagnostic: CY4PR11MB1541:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB1541FDEF9AE58B0D986563F4E1500@CY4PR11MB1541.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(396003)(366004)(39850400004)(189003)(199004)(5660300002)(91956017)(6636002)(8676002)(4001150100001)(478600001)(316002)(8936002)(76116006)(64756008)(66556008)(71200400001)(86362001)(110136005)(4326008)(66446008)(81166006)(81156014)(36756003)(6486002)(66476007)(2616005)(2906002)(26005)(6506007)(6512007)(66946007)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR11MB1541;H:CY4PR11MB1269.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UX1TT27qcY63HuBip520TbcyRIm6SUTNCKmZ9qmGxBmh9L34Li5dOyEX5CB5zmyj2vKW1wjfMpVcVoo2TCSt8g1/dPMbKqNBi7/3Z0P2K9DFbMpiZ7593T6hUh6Kde3fwkN5pJCnW+BenuH3OEum7ftxS5dqhri89XEWXAxypQDA1StJbfARS+KZyFWxCuHn7aQgzTERWbf2VQk2yAGjRVX2uBPRsbDOs2z1zaRsYb9od3ffhc4dMVSaiAJNU3haBzRZP0ExqpWq1IPqKtgc9mzs/a/6jTA7ldsczUzZmxSWQafCEB+v9L0JHZ6UT/XYXyInUqVdn+52TzgsSZwczgufuaPMy/f0pEVssVQb5hVHA2cooirLUyUmzr/jJ4qcPEeX/vHm/PuU58BaMQzn/SSEQjbVQeoDh96E0WVByIw52DcT/cKDS7M/JARqeGR0
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DF871E4DB4EA94DBB75088FC4143841@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d013ddd7-6115-45b4-de30-08d7833dbfa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 22:09:12.7609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6bA257qgmBQQvrLkfotoXoJQUAd2adpxM4nXkkXLDJ3alasAWgzmx1DEEbDwuJyj4exO2sNZW+vw0wptKXGbOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1541
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

T24gVHVlLCAyMDE5LTEyLTE3IGF0IDIxOjExICswMDAwLCBTdG90bGFuZCwgSW5nYSB3cm90ZToN
Cj4gSGkgTWljaGFsLCBCcmlhbiwNCj4gDQo+IE9uIFR1ZSwgMjAxOS0xMi0xNyBhdCAyMTowNiAr
MDEwMCwgbWljaGFsLmxvd2FzLXJ6ZWNob25la0BzaWx2YWlyLmNvbQ0KPiB3cm90ZToNCj4gPiBP
biAxMi8xNywgR2l4LCBCcmlhbiB3cm90ZToNCj4gPiA+ID4gSW5kZWVkLiBXb3VsZCB5b3UgYmUg
d2lsbGluZyB0byBhY2NlcHQgYSBwYXRjaCB0aGF0IGNoYW5nZXMgdG9rZW4NCj4gPiA+ID4gZGVs
aXZlcnkgdG8gdXNlIEpvaW5Db21wbGV0ZSBjYWxsIGluIGFsbCBjYXNlcywgYW5kIGNoZWNrcyB0
aGF0IHRoZSBjYWxsDQo+ID4gPiA+IHJldHVybnMgc3VjY2Vzc2Z1bGx5Pw0KPiA+ID4gDQo+ID4g
PiBNYXliZS4uLiAgSSBuZWVkIHRvIGRpc2N1c3MgaXQgd2l0aCBJbmdhLiAgSG93IGRvZXMgdGhp
cyByZWxhdGUgdG8NCj4gPiA+IENyZWF0ZSgpIHRob3VnaD8gIFRoZXJlIGlzIG5vIEpvaW5Db21w
bGV0ZSgpIGNhbGwgY3VycmVudGx5IGF4cyBhDQo+ID4gPiByZXN1bHQgb2YgQ3JlYXRlKCkuLi4g
IGp1c3QgdGhlIHJldHVybiB2YWx1ZSBmcm9tIHRoZSBDcmVhdGUoKSBtZXRob2QuDQo+ID4gPiBJ
cyB5b3VyIHByb2JsZW0gdGhhdCB0aGUgZGFlbW9uIGNhbm5vdCBiZSBzdXJlIHRoYXQgdGhlIHJl
dHVybiB2YWx1ZQ0KPiA+ID4gKHRva2VuKSBmcm9tIENyZWF0ZSgpIHdhcyByZWNlaXZlZD8NCj4g
PiANCj4gPiBZZXMsIGV4YWN0bHkuDQo+ID4gDQo+IA0KPiBBcyBtdWNoIGFzIEkgZG9uJ3QgbGlr
ZSBBUEkgY2hhbmdlcyBpbiBhIHJlbGVhc2VkIGNvZGUsIHRoaXMgc2VlbXMgdG8NCj4gYmUgYSBs
ZWdpdGltYXRlIGNhc2UgZm9yIGRvaW5nIHNvLg0KPiANCj4gU28geWVzLCBsZXQncyBjaGFuZ2Ug
dGhlIGxvZ2ljIHNvIHRoYXQgYWxsIHRocmVlIG1ldGhvZHMgKEpvaW4sIENyZWF0ZSwNCj4gYW5k
IEltcG9ydCkgaGF2ZSB2b2lkIHJldHVybiB2YWx1ZXMgYW5kIHRoZSB0b2tlbiBpcyBkZWxpdmVy
ZWQgaW4NCj4gSm9pbkNvbXBsZXRlKCkuIEEgbm9kZSBpcyAiZmluYWxpemVkIiBvbmx5IHVwb24g
c3VjY2Vzc2Z1bCByZXR1cm4gb2YNCj4gSm9pbkNvbXBsZXRlKCkuDQoNCkFuZCBpZiB0aGUgY2Fs
bCB0byBKb2luQ29tcGxldGUoKSBmYWlscywgdGhlIGRhZW1vbiBzaG91bGQgZGVsZXRlIHRoZSBu
b2RlIHN0b3JhZ2UuDQoNCg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEluZ2ENCg==
