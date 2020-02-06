Return-Path: <SRS0=lv0E=32=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8924AC33CAC
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Feb 2020 17:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536D121741
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Feb 2020 17:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="M2TlgOUO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbgBFRZr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Feb 2020 12:25:47 -0500
Received: from mga18.intel.com ([134.134.136.126]:11497 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgBFRZr (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Feb 2020 12:25:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 09:25:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,410,1574150400"; 
   d="scan'208";a="279733213"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Feb 2020 09:25:46 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 6 Feb 2020 09:25:45 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 6 Feb 2020 09:25:45 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 6 Feb 2020 09:25:45 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 6 Feb 2020 09:25:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcdmfDn0tSM9wNvy0EW8oG+emFZ9yJeTnYppXIfWUfwAvAQBGPrBiRGjTv76G+jb5QZ28RdLX5hbJRBzsJbZDNqIU1zXHijRF7Y0w7ICLAbhAOhtfTXcdgKxtIPlt3gZ6ihyGXjdySQQmF4+ST0BjNu7Lqjywj2+BhhOjybeWALQk4PuVUZQi0qC4pF4O3BDZxtuZzCTGQkhGstlGJOO5/4Ut4otX5Jjbq0cYEXesh7LWzEevT1FMX/qV3Uua6Y6GCWm3aFGTuFEbRC4nThuK5sEQGg2NScwEGWSeiMmfhLULChkAUBkxh5ACFUlE1dWultRWMcU1LXRtHZkLSOMHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQgg65m+GZyrLPpN5qzhjHP92bddvU5g3YbGbdttdOs=;
 b=I9UrKK82uQMr+21G4mPqy071gkgKD97tdc6OKHIpTOGwqUoJOqEuPx1c94XKKM7r+IQTlsQiXWgSibyI/yquIOdC4mCu6zGGDPEuF8KQYwVmGXJ1p5fr9qpOhMyDebMLDzsJZqhNIJgEiuF5UvvkCNvfOKZ1vias114XrPE60ElbqZIAxwb6zy4hL61qXhaM6t2oYsEXhXFDaJj+iFooj12mpo2HtHe5vw98S1FFk20qztgGqvojpkaCYCyZhfqJmS9jEb8QURBqgwOEMmZPRQSmf4nJ66NNRJP0ObIDRmg7qRel49fEp8mNDoWwXmZxzKwBX2CeLpNMUy2o5R7JsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQgg65m+GZyrLPpN5qzhjHP92bddvU5g3YbGbdttdOs=;
 b=M2TlgOUONicIy0GHR6qAmZS/MuqJzZ6uV/1EV2p6BTuFshzIoZPZ/vBck+BelayZD+UkSqwX2T9zniNbWtV24JpUct7n7Hc8Ss+7TW0JP5K/LdVupVQT1W8iVAc/6k3u7JbjXMGCcCV0s3GAbNEjztEVDoFlrhqP+zQcw8dl90I=
Received: from BN7PR11MB2580.namprd11.prod.outlook.com (52.135.246.155) by
 BN7PR11MB2529.namprd11.prod.outlook.com (52.135.245.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Thu, 6 Feb 2020 17:25:39 +0000
Received: from BN7PR11MB2580.namprd11.prod.outlook.com
 ([fe80::c8ca:3c11:3fc5:a9d6]) by BN7PR11MB2580.namprd11.prod.outlook.com
 ([fe80::c8ca:3c11:3fc5:a9d6%6]) with mapi id 15.20.2707.024; Thu, 6 Feb 2020
 17:25:39 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: mesh: Missing API for delivering provisioning public key via OOB?
Thread-Topic: mesh: Missing API for delivering provisioning public key via
 OOB?
Thread-Index: AQHV3RE1tvVONgrRRU6X1g5gg4omB6gOasIA
Date:   Thu, 6 Feb 2020 17:25:39 +0000
Message-ID: <cd23abb8286bfa1bd8ac2ea5eabeeaa98dd39888.camel@intel.com>
References: <20200206171600.227uzfonhepltydy@kynes>
In-Reply-To: <20200206171600.227uzfonhepltydy@kynes>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [134.134.137.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 797839c0-2d8e-4d5e-be5f-08d7ab299614
x-ms-traffictypediagnostic: BN7PR11MB2529:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR11MB2529DC2DC3F7978CFA8EAA16E11D0@BN7PR11MB2529.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(366004)(396003)(136003)(189003)(199004)(8936002)(316002)(4326008)(81156014)(2616005)(26005)(186003)(81166006)(2906002)(8676002)(110136005)(478600001)(71200400001)(66946007)(66476007)(6486002)(91956017)(66556008)(64756008)(76116006)(86362001)(6506007)(4744005)(6512007)(36756003)(5660300002)(107886003)(66446008);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR11MB2529;H:BN7PR11MB2580.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X6RKj5HCieWG6bZRD93er2g75CVZtqkPvQ2lwytIHCAkW3wH0b89CHxhL7pOetVmOewWaacJNsk65cRFEKebAtleRQXP0EjWN0MQvLkm1Zq/H5vjfNQulErhsYv84apJGZwkE8pHGYlHzmQXvEjqeOORSuHPhvacRYVGzKnep3SuBeVwJCLoSnTOSSlKsZ5o3An+5/Z/K43sZzfIxVXMG9n+Y7XUC3a6X2FpvHgssXr1NlDhdKwB1T7e6aIm8QTVVfujS6b72+d5ITRMV7aRvzP3jVdzeu0EviYoJ8Pin8ZmukIoyzPP+0jOV18BopyRVuoCy5LQokvUg5L5d9UHXQr3lGvYTd6tavD9b7WVIj09bjpDE8e/1usjYdrvcJjUvgvINkjANv1+iTiokSu9BezrumZ60VXnM6uI0by44MaJ0Uqdbbg8lJXe72nT8EsB
x-ms-exchange-antispam-messagedata: bq5EofX2iUZKtg8t7kSNjKTYq+wejlx4xRYHjsSQodZmuaevpW8x3O0L08xtaXKJ/sKwsnBk7gZl0DqQK185DgOStPOeyIivAzBFkLw5UBfUpdLMN8U4jdHd5eGT4GMcPiODShuTq7qP13eG/jKkDg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7B7E1FC2F70E440A1B77FC5B793EDC1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 797839c0-2d8e-4d5e-be5f-08d7ab299614
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 17:25:39.4796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fs8iY9/qOKHAT2i2DMmyMNrc2PAPxVM0Qx3322ycqqvaLj8GxS7tHyZrOVIy0+R1EQA5DPIbfpGZktmA49AbVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2529
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGHFgiwNCg0KT24gVGh1LCAyMDIwLTAyLTA2IGF0IDE4OjE2ICswMTAwLCBNaWNoYcWC
IExvd2FzLVJ6ZWNob25layB3cm90ZToNCj4gSGksDQo+IA0KPiBJIGhhdmUgYmVlbiBwbGF5aW5n
IHdpdGggbWVzaC1jZmdjbGllbnQsIGFuZCBJJ3ZlIG5vdGljZWQgdGhhdA0KPiBwcm92aXNpb25p
bmcgcHJvY2VkdXJlIGdldHMgc3R1Y2sgd2hlbiBub2RlIHJlcG9ydHMgUHVibGljIEtleSBPT0IN
Cj4gaW5mb3JtYXRpb24gYXZhaWxhYmxlJyBpbiAnUHVibGljIEtleSBUeXBlJyBmaWVsZCBvZiBQ
cm92aXNpb25pbmcNCj4gQ2FwYWJpbGl0aWVzIFBEVS4NCj4gDQo+IFdoaWxlIGRpZ2dpbmcgaW50
byB0aGUgY29kZSBhbmQgQVBJLCBJIHRoaW5rIHdlIGhhdmUgYSBtaXNzaW5nIGZlYXR1cmUNCj4g
aW4gdGhlIEFQSSBiZXR3ZWVuIHByb3Zpc2lvbmVyIGFwcGxpY2F0aW9uIGFuZCB0aGUgZGFlbW9u
IC0gd2hpbGUgdGhlcmUNCj4gaXMgYW4gQVBJIHRvIGRlbGl2ZXIgT09CIGtleXMgdG8gdGhlIGRh
ZW1vbiB3aGVuICp0aGUgYXBwbGljYXRpb24qIGlzDQo+IGJlaW5nIHByb3Zpc2lvbmVkLCB0aGVy
ZSBkb2Vzbid0IHNlZW0gdG8gYmUgYSB3YXkgdG8gZGVsaXZlciBwcm92aXNpb25lZA0KPiBkZXZp
Y2UncyBwdWJsaWMga2V5IHdoZW4gaXMgdGhlIGFwcGxpY2F0aW9uIHdobyBkb2VzIHRoZSBwcm92
aXNpb25pbmcuDQo+IA0KPiBJcyBteSB1bmRlcnN0YW5kaW5nIGNvcnJlY3QsIG9yIGlzIHRoZXJl
IHNvbWV0aGluZyBJJ3ZlIG1pc3NlZD8NCg0KWWVzLi4uIEl0IGxvb2tzIGxpa2UgdG9vbHMvbWVz
aC1jZmdjbGllbnQuYyBuZWVkcyB0byBpbXBsZW1lbnQgdGhlOg0KDQoJYXJyYXl7Ynl0ZX0gUHVi
bGljS2V5KCkNCg0KbWV0aG9kLg0KDQpUaGlzIGlzIGEgZ29vZCBjYXRjaCwgYW5kIG5lZWRzIHRv
IGJlIGFkZGVkLiAgDQoNCj4gDQo+IHJlZ2FyZHMNCg==
