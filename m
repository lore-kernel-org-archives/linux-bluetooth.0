Return-Path: <SRS0=HCMd=3D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0676C33CB1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 14:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A772A2072B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 14:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="U/y7Sfj4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgANOuQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jan 2020 09:50:16 -0500
Received: from mga12.intel.com ([192.55.52.136]:52183 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728868AbgANOuP (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jan 2020 09:50:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 06:50:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,433,1571727600"; 
   d="scan'208";a="397529662"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga005.jf.intel.com with ESMTP; 14 Jan 2020 06:50:14 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Jan 2020 06:50:14 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 14 Jan 2020 06:50:14 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 14 Jan 2020 06:50:14 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Jan 2020 06:50:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=faVJQ8IxoaPxE6fWFzMZQfJgAjtSZkn6PIAW6BQ//ejBLiYiMTZjfRxY8o9Zw7sNFpHDupe7x8w0U1FGSk/nsANJTpmPBr6qcLWNL7Hq2oNbYVRfXuQSdDacCJoTRnJqrc1CCyE7TJUPa4/SiRcLVdKNYlulR5+xjQkbbTEkMoEfa47gG/y9Jwkr6uW64JNw9Zo63x4ngH1PrqGN7HPjd7oaNfAqY+FVeMjKUADRyUTSUHev5nhPOiMfsIebEJVpSXgmZBhXZw3la+lMt4Gio+BH185dTZSVtiYljNAwUo3Pn7g8Pd/0F4T/mN2Xw9wfxdowac0/KqLaM7qNkpOo5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcE+w/vgahyPc/RHMu1Szsc51Kpgc44RvUFNfkSUVUU=;
 b=IGbd3/Zl2NkJnVYDZ+3ySDJM8/fVp0RwiwnHES16pzOcK/FBuqSdPvqVnFl4nHxZzncPi6Di/QoxE5h/DegEWqpz0vygDLqekJJCTbuciZhhWL0Ubsw5BOxjuDXEYRQV23R4kTzG6OjnyeDH8ng2n0w7VPuoHIrE6BjkVjv0CWA8w4z06Rhv18AragGxEYhqatz1ff5AY4X4GAtD20vTsKW5Tyi1ghL8GWAzIglGrn4ZAlYlm7Trso9TuEWarsIA+4k4FbwLQWRKybch07Qf0ch5e4RFNOkjqxh2xCgBc89e85T04E7SOurarUo5OoQ5PCtTHrDcOlWGqvBL9LpUog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcE+w/vgahyPc/RHMu1Szsc51Kpgc44RvUFNfkSUVUU=;
 b=U/y7Sfj4RDjVHBCjhr43XYFaaHq6qQ1E6AWrzZFktlLjEFms0HyrFBBqNZaD8AQRmsjd3xcZfrZ1IXJIf5PL1yTeDpaJfStAxX8kp7YhVhURNihtfMh1IUG003x7qkMnwiWIVi18LDzFzP8XPHqHuhlmYdcrcQ2d3H3EtDSAA2M=
Received: from MWHPR11MB1664.namprd11.prod.outlook.com (10.172.54.13) by
 MWHPR11MB1759.namprd11.prod.outlook.com (10.175.54.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Tue, 14 Jan 2020 14:50:12 +0000
Received: from MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e]) by MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e%6]) with mapi id 15.20.2623.017; Tue, 14 Jan 2020
 14:50:12 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH 1/2] mesh: Add sequence nr getter to the doc
Thread-Topic: [PATCH 1/2] mesh: Add sequence nr getter to the doc
Thread-Index: AQHVytDDP5vFmR03CEu0pPZazNAxXafqPjcA
Date:   Tue, 14 Jan 2020 14:50:12 +0000
Message-ID: <1382d00407f6c7836f7983e374d6c504931f6e9e.camel@intel.com>
References: <20200114114914.25868-1-jakub.witowski@silvair.com>
In-Reply-To: <20200114114914.25868-1-jakub.witowski@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f12f24f9-ff26-417b-67b1-08d799010f62
x-ms-traffictypediagnostic: MWHPR11MB1759:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB17595EED884377EED2EE6C2EE1340@MWHPR11MB1759.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(199004)(189003)(86362001)(36756003)(6486002)(81166006)(81156014)(8936002)(8676002)(4744005)(498600001)(91956017)(110136005)(76116006)(26005)(71200400001)(186003)(64756008)(66446008)(66556008)(2906002)(66476007)(66946007)(2616005)(5660300002)(6512007)(107886003)(6506007)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR11MB1759;H:MWHPR11MB1664.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8UEyxMJuBIAX2XvIqP69hs8VRuDQS66IGlrfR3jaMIUZ7qNS0iTJxyk8HoAx2lqjIZRKEobbXZuXfrb/uGlbH/d1mCPqWSD4hB16ax6hfcr2z8eTrQ0qCei1vzGwIuVrwcDC9C3DoAm7+XbKsHD4blIZWqikTeXdJLfcKPovvT3m9IKbeOKTycCPWk8RwAWY0mMxmTdrOGXg75tUVMW+Pem17mVVMGz0jB4Rtxfm3fjl+mIUv+JwRd+gQYwwQ7WBWSv9kGS2JJkvqQK5bScSmXQGqgqqeYYzt+Oi7KQ1oBImrQIH432tkkOEfAFlQEo4D4kvIPJGaXr2RznzQqEGg07d9ZWjHVeyXXcifUrfV9NHuPVIZq+c+6dvxRRZ+HIGX3YfIS0ZkE51ciofUxLhEecPR7lqPAW+xNOsHrczyf8uQ+5nldkpw5uxDUBb02ut
Content-Type: text/plain; charset="utf-8"
Content-ID: <5EF59B095AB09041BF181319F003C0D7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f12f24f9-ff26-417b-67b1-08d799010f62
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 14:50:12.7109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mWPJe7E4fgRMK9OdO3cwzZGgio8BAArjlCaQ5IE+HaWspqvY9AWBL3ugc6t3cPSgjWu1dsYh4ucA84d65jdAhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1759
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgSmFrdWIsDQoNCk9uIFR1ZSwgMjAyMC0wMS0xNCBhdCAxMjo0OSArMDEwMCwgSmFrdWIgV2l0
b3dza2kgd3JvdGU6DQo+IC0tLQ0KPiAgZG9jL21lc2gtYXBpLnR4dCB8IDUgKysrKysNCj4gIDEg
ZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kb2MvbWVz
aC1hcGkudHh0IGIvZG9jL21lc2gtYXBpLnR4dA0KPiBpbmRleCBlYmZmODQ5MmEuLmQ4M2M2OGJk
YyAxMDA2NDQNCj4gLS0tIGEvZG9jL21lc2gtYXBpLnR4dA0KPiArKysgYi9kb2MvbWVzaC1hcGku
dHh0DQo+IEBAIC00NDEsNiArNDQxLDExIEBAIFByb3BlcnRpZXM6DQo+ICANCj4gIAkJVGhpcyBw
cm9wZXJ0eSBjb250YWlucyB1bmljYXN0IGFkZHJlc3NlcyBvZiBub2RlJ3MgZWxlbWVudHMuDQo+
ICANCj4gKwl1aW50MzIgU2VxdWVuY2VOdW1iZXIgW3JlYWQtb25seV0NCj4gKw0KPiArCQlUaGlz
IHByb3BlcnR5IG1heSBiZSByZWFkIGF0IGFueSB0aW1lIHRvIGRldGVybWluZSB0aGUNCj4gKwkJ
c2VxdWVuY2UgbnVtYmVyLg0KPiArDQoNCklzIHRoZXJlIGEgdXNlIGNhc2UganVzdGlmaWNhdGlv
biBmb3IgZXhwb3NpbmcgdGhpcyB2YWx1ZT8gIFdoeSBhbiBBcHBsaWNhdGlvbiB3b3VsZCBuZWVk
IHRoaXM/DQoNCg0KPiAgTWVzaCBQcm92aXNpb25pbmcgSGllcmFyY2h5DQo+ICA9PT09PT09PT09
PT09PT09PT09PT09PT09PT09DQo+ICBTZXJ2aWNlCQlvcmcuYmx1ZXoubWVzaA0K
