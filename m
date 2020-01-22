Return-Path: <SRS0=lsET=3L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B1CC2D0CE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jan 2020 01:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B9A24656
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jan 2020 01:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="dQ7yViQr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgAVBOS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jan 2020 20:14:18 -0500
Received: from mga07.intel.com ([134.134.136.100]:53668 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728609AbgAVBOS (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jan 2020 20:14:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 17:14:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,347,1574150400"; 
   d="scan'208";a="399852465"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga005.jf.intel.com with ESMTP; 21 Jan 2020 17:14:17 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 21 Jan 2020 17:14:17 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 21 Jan 2020 17:14:17 -0800
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 21 Jan 2020 17:14:17 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 21 Jan 2020 17:14:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArsvWDZY1wZUvDSChbt6mj5/HSJXQjpNTQfxTWG4UbQP3F2uuNHJ0qPn8kr68Z+kIVoRX8HLb28cc7b6h7MjkEkhC8oLQ+5vThD48YS2dkjVeOfl6ICxEMUu3OrhFvyCNSwfiUfOAWvcx4ledzgWr/TeuZHhiyQnHTI3GstyyYnql7NSD4Gst3/9CCcHLIkdKkPJuRB79NxVdDSI5ir7q9ASU9Rw3yvXo0FiXcQFWcgO5Qtt7HSc5H6DRLiFIPMsKrQ0IRUwtelLgesjYw/W3gsYiduY1h7kzSfi+EgY8q4BcbA89ltw7W6IO39WB/BcZon8uOMq6kqGtqxAGbQVOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DG/RB3xuHekNYH0Icw2QUvmsMi9tARDYLJp6RmMwRcQ=;
 b=JOMZ4VnSKp2bvZLeHvwPz/1XTXrIGLNiLuE+74nCTrIkovSkt3yOQC9l7+Q7o9NUDrDrKreCktN/0i707aNhXkpu96zF6MR8kE3jHmFHwUNlqOlB4f/sQHR2hNv6OhVkjKYsF7jfcCs/lP/WuECn+Gn6hEGPEnV+6VRbmUHWSKDNtYaPO660iMkmfwjOjehHk9x+35287WcgLF40ZVyVHKBUJIMQt0XE4AX6Jk2cx7UhCPaL/S77lGaziK5iTQ31b3k+jU/uor4reuOibSZ1j5mjfj66OA3RUqLw/EYm0t7qfeWvkGdJ/lfUxmr788gQfQlaVUgQkg5tHTaypkfhUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DG/RB3xuHekNYH0Icw2QUvmsMi9tARDYLJp6RmMwRcQ=;
 b=dQ7yViQrPN98TiVH5JDUU/B58iayfN0bCax+gWtQMdBuBxRwXPE2F7axfl/T55zcij7olsKNXfG5+PXiKT/Eclpr7+jbwnZgV/qMznkfNcQdXmJpSPrVEtnokwTjJMOcNgvYWas28eLkdxMTbXAY6Fp3Q041Ck/jn/cAyz0+440=
Received: from MWHPR11MB1664.namprd11.prod.outlook.com (10.172.54.13) by
 MWHPR11MB1983.namprd11.prod.outlook.com (10.175.55.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.24; Wed, 22 Jan 2020 01:14:15 +0000
Received: from MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e]) by MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e%6]) with mapi id 15.20.2644.027; Wed, 22 Jan 2020
 01:14:15 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [RFC BlueZ 0/2] Fix types and names of beacon/import flags.
Thread-Topic: [RFC BlueZ 0/2] Fix types and names of beacon/import flags.
Thread-Index: AQHVxshUOnKJx79hGUyTuC4ov82Eeqf1oVqAgABLK4CAAAhvAA==
Date:   Wed, 22 Jan 2020 01:14:14 +0000
Message-ID: <ddced1e3db7d6448a2aa017ffdcb830873fee3f6.camel@intel.com>
References: <20200109083855.16000-1-michal.lowas-rzechonek@silvair.com>
         <20200121201501.v4ceigg5xngfvjb4@kynes>
         <8c665ad8c0856a3f8dd8e4d808599c953b5dfcd1.camel@intel.com>
In-Reply-To: <8c665ad8c0856a3f8dd8e4d808599c953b5dfcd1.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [134.134.137.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e892fbd-3b2c-4308-cbcf-08d79ed865a2
x-ms-traffictypediagnostic: MWHPR11MB1983:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1983CA8390ACCC4A5BE74FC5E10C0@MWHPR11MB1983.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 029097202E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(366004)(346002)(39860400002)(199004)(189003)(2616005)(316002)(478600001)(86362001)(26005)(6512007)(81156014)(5660300002)(8676002)(81166006)(110136005)(8936002)(186003)(2906002)(66946007)(6636002)(6486002)(6506007)(66556008)(71200400001)(66446008)(66476007)(64756008)(36756003)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR11MB1983;H:MWHPR11MB1664.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kuVFGCEyCLT987IBn9+wGs/3OWfTNJDXE3mo8DhQSf9emHnA23V//HK0Hy06OaVDUD54+Uxe2zGXhAR1pLwfXSyHnDfk/iKURIN85ZkM6AiB+X4ayd/3kgY7MmLoDgot7P9japb51EyADc+34KVi3ll6vM50D94jE460fjPBD6csAwyKt9e/KAssSqj1e9is5PhT9AZE6Xz0ARR55e/EZ0BGPOp8Hk1QmYuqtsNEAUMhIUQyfC2nci42ZwIjUzEO3wjfkvT2hOrzHc74aYxNbO+vkkxJdqtFojRyknmrMsevCLkxrv37I0GKCkahj1A5EsA2C/SNv0huXS2r/hUH3ClVmYjWwbIX1jpEMCfpyL65wBNTDEpcPGBILCaxgKg0l18tspQtuhEbtzIgXFeM8eCPcrqCTzHhmT+ORwhiDzdV28TnFaZmWAwBxLKrh5vn
Content-Type: text/plain; charset="utf-8"
Content-ID: <D50AAE6735601D4A9107534C4003D050@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e892fbd-3b2c-4308-cbcf-08d79ed865a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2020 01:14:14.8498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Bg/LmmgXjrb2zXRVdPjh3Kbto264cZCSX/fk7RjXoeXz9jYV30wCgcwlc6+r32CtNRMOdhdt19xmmhLTf32/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1983
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgSW5nYSAmIE1pY2hhxYIsDQoNCk9uIFdlZCwgMjAyMC0wMS0yMiBhdCAwMDo0NCArMDAwMCwg
U3RvdGxhbmQsIEluZ2Egd3JvdGU6DQo+IEhpIE1pY2hhbCwNCj4gDQo+IE9uIFR1ZSwgMjAyMC0w
MS0yMSBhdCAyMToxNSArMDEwMCwgTWljaGHFgiBMb3dhcy1SemVjaG9uZWsgd3JvdGU6DQo+ID4g
SGkgQnJpYW4sIEluZ2EsDQo+ID4gDQo+ID4gT24gMDEvMDksIE1pY2hhxYIgTG93YXMtUnplY2hv
bmVrIHdyb3RlOg0KPiA+ID4gVGhpcyBwYXRjaHNldCBhaW1zIHRvIG1ha2UgdGhlIEFQSSBhIGJp
dCBtb3JlIGNvbnNpc3RlbnQuDQo+ID4gPiANCj4gPiA+IFNpZGUgcXVlc3Rpb246IGF0IHRoZSBt
b21lbnQgbm9uZSBvZiB0aGUgbm9kZSBwcm9wZXJ0aWVzIGVtaXQNCj4gPiA+IFByb3BlcnRpZXND
aGFuZ2VkIHNpZ25hbC4gSSB0aGluayB0aGlzIHZpb2xhdGVzIEQtQnVzIHNwZWMsIHNpbmNlIGFs
bA0KPiA+ID4gcHJvcGVydGllcyBhcmUgYXNzdW1lZCB0byBlbWl0IHRoZXNlIHNpZ25hbHMgYnkg
ZGVmYXVsdCBbMV0gWzJdLg0KPiA+ID4gDQo+ID4gPiBVbmZvcnR1bmF0ZWx5LCBhdCB0aGUgbW9t
ZW50IEVMTCBkb2VzIG5vdCBzdXBwb3J0ICJFbWl0c0NoYW5nZWRTaWduYWwiDQo+ID4gPiBhbm5v
dGF0aW9uLCBzbyBJJ2QgbGlrZSB0byBhZGQgdGhpcyB0byBFTEwsIGFubm90YXRlIG5vZGUNCj4g
PiA+IHByb3BlcnRpZXMgd2l0aDoNCj4gPiA+ICAgICAtIEZlYXR1cmVzOiBjb25zdA0KPiA+ID4g
ICAgIC0gQmVhY29uOiB0cnVlDQo+ID4gPiAgICAgLSBCZWFjb25GbGFnczogdHJ1ZQ0KPiA+ID4g
ICAgIC0gSXZJbmRleDogdHJ1ZQ0KPiA+ID4gICAgIC0gU2Vjb25kc1NpbmNlTGFzdEhlYXJkOiBm
YWxzZSAoZm9yIHBlcmZvcm1hbmNlIHJlYXNvbnMpDQo+ID4gPiAgICAgLSBBZGRyZXNzZXM6IGNv
bnN0DQo+ID4gPiANCj4gPiA+IEFuZCBhbHNvIGVtaXQgUHJvcGVydGllc0NoYW5nZWQgd2hlcmUg
cmVxdWlyZWQuDQo+ID4gPiANCj4gPiA+IFRob3VnaHRzPw0KPiA+IA0KPiA+IEFueSBjb21tZW50
cyBhYm91dCB0aGlzIGlkZWEsIG9yIHNob3VsZCBJIGp1c3QgZ28gYWhlYWQgYW5kIHNlbmQgYQ0K
PiA+IHBhdGNoPw0KPiA+IA0KPiANCj4gSSB0aGluayB0aGlzIGlzIGEgZ29vZCBpZGVhLiBJIGFn
cmVlIHdpdGggdGhlIHByb3Bvc2VkIG5vZGUgcHJvcGVydGllcw0KPiBhbm5vdGF0aW9ucy4NCg0K
DQpJIGhvbmVzdGx5IHdvdWxkIGxpa2UgdG8gbmV2ZXIgZW1pdCBhbnkgc2lnbmFscyBmb3IgTWVz
aCwgYW5kIGlmIGl0IGlzIGxlZ2FsbHkgcG9zc2libGUgZm9yDQpTZWNvbmRzU2luY2VMYXN0SGVh
cmQgKGEgcHJvcGVydHkgd2hpY2ggbGl0ZXJhbGx5IGNoYW5nZXMgdmFsdWUgZXZlcnkgc2Vjb25k
KSB0aGVuIEkgaG9wZSBpdCBpcyBwb3NzaWJsZSBhbmQNCmxlZ2FsIHRvIG5ldmVyIGVtaXQgYW55
dGhpbmcuLi4uICAgVGhleSBzaG91bGQgYmUgcG9sbGVkIG9ubHkuDQoNClVubGVzcyBzb21lb25l
IGNhbiBjb21lIHVwIHdpdGggYSB1c2UgY2FzZSB0aGF0IHJlcXVpcmVzIHNpZ25hbHMgdG8gbm90
aWZ5IGEgc3BlY2lmaWMgcGllY2Ugb2YgaW5mb3JtYXRpb24gaGFzDQpjaGFuZ2VkLCBTaWduYWwg
RW1pc3Npb25zIGFyZSBJbmZvcm1hdGlvbiBMZWFrcyB0aGF0IHByb3ZpZGUgbm8gYmVuZWZpdC4u
LiAgdGhleSBhcmUgc2VudCBnbG9iYWxseSB0byBhbnlvbmUgb24NCnRoZSBEQnVzLCBhbmQgc2ln
bmFscyB0byBhbnlvbmUgd2hvIG1heSBiZSBlYXZlc2Ryb3BwaW5nIHRoYXQgKnNvbWV0aGluZyog
aXMgaGFwcGVuaW5nLCBldmVuIGlmIHRoZSBkZXRhaWxzIG9mDQp0aGUgY2hhbmdlIGFyZSAiaGlk
ZGVuIi4NCg0KQXJlIHRoZXJlIGFueSB1c2UgY2FzZXMgdGhhdCBuZWNlc3NpdGF0ZSBEQnVzIFNp
Z25hbHMgaW4gTWVzaD8NCg0KLS1Ccmlhbg0K
