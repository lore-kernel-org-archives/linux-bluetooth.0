Return-Path: <SRS0=HCMd=3D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AD3C33C9E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 16:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4CF2053B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 16:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="MWZNRXO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgANQkR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jan 2020 11:40:17 -0500
Received: from mga06.intel.com ([134.134.136.31]:41219 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbgANQkR (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jan 2020 11:40:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 08:40:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,433,1574150400"; 
   d="scan'208";a="219649955"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jan 2020 08:40:16 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Jan 2020 08:40:16 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 14 Jan 2020 08:40:15 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 14 Jan 2020 08:40:15 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.57) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 14 Jan 2020 08:40:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHUU9ubzSiJ+tfuokTAeggLQkNDGLmrI2DQfHwSRTyZ3oYAng5WPxUEan6vGC33/IKDuD49hnwWb6Ul+T1SWRXg2OTvHw50YusGV36HVATvEaIQbSN+HthgaJF077LuGGvWTl9TpjM3ei3KfWS1U8J/+FU2yWF4I0k7aous4xzwRZu+1fSvHjfCg+5QxQYtJ/m0nvdkNd0z7Hiss7/F2Cj/cC51gUkJEfF9b/WdrPy1HL7p4ai1A2YqWEqGVqoB83LF+8HiI6XzhiqI21UsmFmcmgc3VU+i397ef8C0MdqOYG1dpQuQOnk3oIFG/h/0ww4av8zZFjzFUpTlquAR9fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KiwsI6Nx6k5Sb9IrBfOYD5pfGX4SKq5ZF/jnYv6Zv/4=;
 b=J8foUKj4wpuu7a8/7uTHTpiU6gQ05p/kNBMCayRfX4u+zkZd4v47TA5UT+4B3Qelm5zkiSpGbfWWyz2nXR4p6njK7WI/iSeaz1Lwj2OPLFp+/uMaDW0stWYnd1CGmJQJzh5EgLFokU6jIAtF32HGX9bsC/tuMatS6g0/btSn5VCT+myKbG+72doWwwS4GCm/YQzyMJmySi3nthtJUUQhu5jD6srGzpQ87zQzgpoaCEpRqSi2VqCNnCgElmAWnSTpfz/PIEvT2s+9LLmEbA1KOnSGPsEInz7EK0ba7qAgE7WcBr6tCE6NxZVqTuKs4XUVU5KB2YhUGr6R+V8wLPD8rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KiwsI6Nx6k5Sb9IrBfOYD5pfGX4SKq5ZF/jnYv6Zv/4=;
 b=MWZNRXO/tG77JEy4ppYZFnBxz6poepPmtYxczuS1wmn/ADoc/sSkVNU9AejbLKVOOZOL9xQfxC0cHxCeOh9B9hA3Lu4zUzHnCHM0S4i6gKe1++34Gn+jvGYRmHwdNyeL78R0Zfct176/63C+Wf8m4UTRQErPQR5/c6mVe/o8LEI=
Received: from MWHPR11MB1664.namprd11.prod.outlook.com (10.172.54.13) by
 MWHPR11MB1710.namprd11.prod.outlook.com (10.169.235.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Tue, 14 Jan 2020 16:39:52 +0000
Received: from MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e]) by MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e%6]) with mapi id 15.20.2623.017; Tue, 14 Jan 2020
 16:39:51 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
CC:     "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH 1/2] mesh: Add sequence nr getter to the doc
Thread-Topic: [PATCH 1/2] mesh: Add sequence nr getter to the doc
Thread-Index: AQHVytDDP5vFmR03CEu0pPZazNAxXafqPjcAgAAN+ACAABCrgA==
Date:   Tue, 14 Jan 2020 16:39:51 +0000
Message-ID: <73e50268c7a5289a20adc8cffc3de2e04ef93acd.camel@intel.com>
References: <20200114114914.25868-1-jakub.witowski@silvair.com>
         <1382d00407f6c7836f7983e374d6c504931f6e9e.camel@intel.com>
         <20200114154012.gixnyhceabg2lrsp@mlowasrzechonek2133>
In-Reply-To: <20200114154012.gixnyhceabg2lrsp@mlowasrzechonek2133>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5a722c4-e459-4cce-bc4a-08d7991060d5
x-ms-traffictypediagnostic: MWHPR11MB1710:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1710DFED93FDA59D8FC984A9E1340@MWHPR11MB1710.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(199004)(189003)(107886003)(71200400001)(2906002)(4326008)(66946007)(66476007)(66556008)(64756008)(66446008)(6916009)(76116006)(91956017)(36756003)(54906003)(498600001)(2616005)(6506007)(186003)(8936002)(86362001)(26005)(6486002)(81166006)(5660300002)(81156014)(8676002)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR11MB1710;H:MWHPR11MB1664.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1WfKSGl3BIabFnRxEKchc/dU9lYPsfVL1HQ6YW5SN/2s1WgSMxqdOwe9AbyY2aKR6GJYa4mRqgN+/jj9AB0CPv8lzHUDgGi4KgsNABWCW5Evo0JgLBf+FSHpWUEKqFukeWnIUDIcAYbBRkmxrycNwZFUPlGCdkZZvqukJAFEbE8NTQkrXR//RSUJZ2fjjE7cPIQhKMiVLLv8hdzYqy4B1BS5eg8/B6/sk/m10iM3MALlkT6/JfzhcSUmk+zGj7u6wtD6bhClXw5oVJ+B0wfp/5lxCVOC0BD9umRVxiNJD8K3GdAqL7BU6N4coolEviJyk+l55L0ZTCg5PAWxImAB7OS8FG7UPmHdKhfvW1vygabsgowMUyfI/WZ8cg5D1e8eUF1CevdIKzOuUETEQOxjbKmFmjmb2iF83eSzaWgu5sQP+gZHVRsRhcIM9Sa6Km0Y
Content-Type: text/plain; charset="utf-8"
Content-ID: <0FDAE24CD239954F95B9B79B47FF57BC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a722c4-e459-4cce-bc4a-08d7991060d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 16:39:51.8911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7PleotsMuPuk7TGz4WTFRNCveuViE2WFbfE7udfye2js5iEmtF9lEMpPEJbNg9GD2NDihQkFAVVbFXzMDyUqdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1710
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGHFgiAmIEpha3ViLA0KDQpPbiBUdWUsIDIwMjAtMDEtMTQgYXQgMTY6NDAgKzAxMDAs
IE1pY2hhxYIgTG93YXMtUnplY2hvbmVrIHdyb3RlOg0KPiBIaSBCcmlhbiwNCj4gDQo+IE9uIDAx
LzE0LCBHaXgsIEJyaWFuIHdyb3RlOg0KPiA+ID4gKwl1aW50MzIgU2VxdWVuY2VOdW1iZXIgW3Jl
YWQtb25seV0NCj4gPiA+ICsNCj4gPiA+ICsJCVRoaXMgcHJvcGVydHkgbWF5IGJlIHJlYWQgYXQg
YW55IHRpbWUgdG8gZGV0ZXJtaW5lIHRoZQ0KPiA+ID4gKwkJc2VxdWVuY2UgbnVtYmVyLg0KPiA+
ID4gKw0KPiA+IA0KPiA+IElzIHRoZXJlIGEgdXNlIGNhc2UganVzdGlmaWNhdGlvbiBmb3IgZXhw
b3NpbmcgdGhpcyB2YWx1ZT8gIFdoeSBhbiBBcHBsaWNhdGlvbiB3b3VsZCBuZWVkIHRoaXM/DQo+
IA0KPiBUaGVyZSBhcmUgMiB1c2UgY2FzZXM6DQo+ICAtIGRlYnVnZ2luZyBhbmQgbW9uaXRvcmlu
ZyBSUEwgYmVoYXZpb3VyDQoNCkkgbmVlZCB0byB0aGluayBhYm91dCB0aGlzIGEgYml0IGFuZCBk
aXNjdXNzIHdpdGggSW5nYQ0KDQo+ICAtIHdlJ2QgbGlrZSB0byBhZGQgYW5vdGhlciBBUEkgdG8g
aW5jcmVhc2UgdGhlIHNlcXVlbmNlIG51bWJlciAtIHRoaXMNCj4gICAgaXMgdXNlZnVsIHdoZW4g
eW91IEltcG9ydCgpIGEgbm9kZSBmcm9tIGFub3RoZXIgZGF0YWJhc2UgYW5kIHdvdWxkDQo+ICAg
IGxpa2UgdG8gYnVtcCBpdHMgc2VxdWVuY2UgbnVtYmVyIHVwIHRvIGEgcHJldmlvdXNseSBrbm93
biB2YWx1ZSwgc28NCj4gICAgdGhhdCB0aGUgcmVzdCBvZiB0aGUgbmV0d29yayBjYW4gdGFsayB0
byBpdA0KDQpJIGhhdmUgc29tZSBzZXJpb3VzIGRpc2NvbWZvcnQgd2l0aCBhbiBBUEkgdG8gaW5j
cmVhc2Ugc2VxdWVuY2UgbnVtYmVycy4gIE9uIGltcG9ydCwNCnRoZSBzZXF1ZW5jZSBudW1iZXIg
c2hvdWxkIGJlIHBhcnQgb2YgdGhlIGRhdGEgYmVpbmcgaW1wb3J0ZWQsIHNvIEkgZG9uJ3Qgc2Vl
IGENCmRpcmVjdCBuZWVkIHRoZXJlIHRvIGJ1bXAgdXAgdGhlIHZhbHVlIGFmdGVyd2FyZHMuDQoN
ClBsdXMsIHdlIGhhbmRsZSBzZXF1ZW5jZSBudW1iZXJzIGRpZmZlcmVudGx5IHRoYW4gbWFueSBv
dGhlciBzZXR0aW5ncyBpbiB0aGUNCnN5c3RlbS4gIFRvIHByZXZlbnQgc3RvcmFnZSB0aHJhc2hp
bmcsIHdlICJQcmUtUmVzZXJ2ZSIgYSBjaHVuayBvZiBzZXF1ZW5jZQ0KbnVtYmVycyB0aGF0IHdl
IHN0b3JlIGluIG5vZGUuanNvbiwgYW5kIHRoZW4gcmVhbC10aW1lIHVzZSB0aGVzZSBzZXF1ZW5j
ZQ0KbnVtYmVycyBmb3Igb3V0Ym91bmQgcGFja2V0cyB3aXRob3V0IGhhdmluZyB0byB3cml0ZSB0
byBzdG9yYWdlIGVhY2ggdGltZQ0KKGEgcG93ZXIgZmFpbHVyZSBvciBvdGhlciByZXNldCB3b3Vs
ZCB0aGVuIHBpY2sgdXAgYWZ0ZXIgdGhlIHJlc2VydmVkIGNodW5rKS4NCkFuZCB0aGVuIGl0IGFs
c28gZmVlZHMgaW50byB0aGUgSVYgSW5kZXggdXBkYXRlIGZlYXR1cmUgYXMgd2VsbC4NCg0KR2l2
aW5nIGFuIEFwcCB0aGUgYWJpbGl0eSB0byBhcmJpdHJhcmlseSBpbmNyZWFzZSBpdCdzIHNlcXVl
bmNlIG51bWJlciBwdXRzDQppdCBpbnRvIGNvbmZsaWN0IHdpdGggdGhlIG5hdHVyYWwgdXNhZ2Ug
b2Ygc2VxdWVuY2UgbnVtYmVycywgYW5kIHdoZW4gd2UgcmVxdWVzdA0KdGhlIElWIEluZGV4IFVw
ZGF0ZS4NCg0KDQo=
