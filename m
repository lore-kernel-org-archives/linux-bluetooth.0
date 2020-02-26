Return-Path: <SRS0=9bU/=4O=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6B9C4BA21
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Feb 2020 19:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C6120732
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Feb 2020 19:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="zV1KWTrk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgBZTXR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Feb 2020 14:23:17 -0500
Received: from mga06.intel.com ([134.134.136.31]:64851 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgBZTXR (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Feb 2020 14:23:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 11:23:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,489,1574150400"; 
   d="scan'208";a="241779088"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga006.jf.intel.com with ESMTP; 26 Feb 2020 11:23:16 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 26 Feb 2020 11:23:16 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 26 Feb 2020 11:23:15 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 26 Feb 2020 11:23:15 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 26 Feb 2020 11:23:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIN5zpir4ZDPRarTceIU+jAwdtvTyWKsoIGsSGwgtCyA0TXJYODvtX15DUVGTUPm1t/Z0/vakLTWK0TIXqXAXDYue68VbRkSIDoiskwpP3KUYOosR11p6R0/z3mIizhq+3B4s8k0R4aUL46I0ZhHyBMtrGh0CMDlLxoIVXGH16JTvbmJtFHUZ2WHEVPr1pu+4fnrhtXz8G/G/ZLYcWep6QOvZozSXCaJac6CBP87535yWIffn85eXFN3nTAUU3D+3JSZPZNJdGQSYMIS14K1NCDieZ190N4l0n5RNG6rs8AxEo+jHFYIiLjt29i9WcgQzI44bsa9y/PuTf00z4nN7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFxRj0gX0xffdCs8sSDe61j0XcMNaaS6REoLKvfEXuk=;
 b=HU1Ii9FvqH1TiOvK0U47SdkZV7r+PupFYw+siSFnFN25ab+8UnpbiqrOVYQO3m3AWFylpad/127HuAonfyZZVU858MSoxl0k+mLc698mlZviKqHAWA0qljzHlx2KNUTef6w6sI8RDKkTdNrKCNbamFdUuX4mNbkVODq8USKuBqIP2+xWLWQ0YXn5w+w5PjYU3LKtRvuZs1txKrSaJ76zbSp3VW2vWLBtMXvlOoAPrZD9v0YxfIHH+dEStPLVclzJ2uBFEZyNFvqS5TcqdSc7n/nArWX7fcH52YforkyfHKdoeM66CalEFwcx9lqA//w1uvJDSPQ6qvGCUblKzxcQvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFxRj0gX0xffdCs8sSDe61j0XcMNaaS6REoLKvfEXuk=;
 b=zV1KWTrkXA2l/MLVV1fGnB46LNuVFX8quM4BbcCcNEJh+h7ayh9Mi+djF5pyQEFyQnViCQtN7ExC96HIjf2ejsHveNlp1JgQY3HoOhRGH1fIlREchar6tgFvqlnGTVYxu9W6+8kTkOPmQ4/9AcFvcPq2uodlXAo11uAMvC0CjLc=
Received: from BN7PR11MB2580.namprd11.prod.outlook.com (2603:10b6:406:b5::27)
 by BN7PR11MB2708.namprd11.prod.outlook.com (2603:10b6:406:a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.22; Wed, 26 Feb
 2020 19:23:14 +0000
Received: from BN7PR11MB2580.namprd11.prod.outlook.com
 ([fe80::c8ca:3c11:3fc5:a9d6]) by BN7PR11MB2580.namprd11.prod.outlook.com
 ([fe80::c8ca:3c11:3fc5:a9d6%6]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 19:23:14 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v3 0/6] Support for virtual labels
Thread-Topic: [PATCH BlueZ v3 0/6] Support for virtual labels
Thread-Index: AQHV7Au4/gP00pQgLEC//vTaMK0wxqgt3EiA
Date:   Wed, 26 Feb 2020 19:23:14 +0000
Message-ID: <30afc21c1d9789992ad8f929d103d1019ac7fe92.camel@intel.com>
References: <20200225184418.12660-1-inga.stotland@intel.com>
In-Reply-To: <20200225184418.12660-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8b4ae38-8943-4049-8905-08d7baf1539c
x-ms-traffictypediagnostic: BN7PR11MB2708:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR11MB2708B69D3BA5238847B0AB39E1EA0@BN7PR11MB2708.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0325F6C77B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(366004)(376002)(39860400002)(346002)(189003)(199004)(66946007)(81156014)(8676002)(64756008)(66476007)(66446008)(66556008)(81166006)(36756003)(8936002)(6486002)(91956017)(76116006)(316002)(6636002)(86362001)(110136005)(5660300002)(478600001)(2906002)(6506007)(71200400001)(2616005)(6512007)(186003)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR11MB2708;H:BN7PR11MB2580.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yKhfNalYRcCf4HMpBgzSj7szhI9YZc6hSlSjYpRqz8dEGshHFDfTjbb3qLaJQTYK+kobqOCzTkYlTPDtU0sdWk8RfWk4VEmfbD9lF2D7t/jyoUbeXmOG0zuENKcIf7kUpTXszhBpJatD1KLlKM7yyMxFwEMJLyzQmrnaF1lI1wA9IzhWWLpwyqxemzrlYAfaJA03bhqZ9kxeDLQE6SoI2q6L+/7zjp1SWR/E5ZhkAysbg3rAWiHdTGhJpxdsPYQilTwWkZhRa6BjYlkk2dxUfZyG3DBGEAuOMcqG9kEFxkBKR6szgjqtonBiHUitDK7JsgR3RY7bhRmJaGfYWR6vZCi0cSBRyfIlsdprDg3pW1oCz4BL58tiHGL1h6wgTDU3/3lojobsZj6QrA6LVkOJBTSq/Rlg4746L/IC+buSkEp7grqVTVXS4FVRMqkVOBpG
x-ms-exchange-antispam-messagedata: 5bA8vH6QoD6h13C0U0MT4015YKVhbi6Xyh7VlAoJkvo4h3vd9xetvY1uQeGiNmJNHpINhq7PLDAfqIVizZLdeHTHa4qWpXQ7udUyHI7pdxmRtvtMw2AXWcYnmvLy/7m1UgNxe0p7oYICLsXm1t6tiw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C824916461E0A4C9E7C3ABB91E34246@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b4ae38-8943-4049-8905-08d7baf1539c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2020 19:23:14.7127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yjyEzOH8OBYSiulQeKHTp3tXwx+dpi+oNOTkFvEkpLWqXnm84WQVj3RDhOxfRwnV+/wLxLzPQ1MVc1TUoMm4FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2708
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2ggc2V0IGFwcGxpZWQNCk9uIFR1ZSwgMjAyMC0wMi0yNSBhdCAxMDo0NCAtMDgwMCwgSW5n
YSBTdG90bGFuZCB3cm90ZToNCj4gdjM6IEZpeGVkIHN1YnNjcmlwdGlvbiBsaXN0IGdlbmVyYXRp
b24gdG8gaW5jbHVkZSB2aXJ0dWFsDQo+ICAgICBzdWJzY3JpcHRpb24gYWRkcmVzc2VzDQo+IA0K
PiAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKg0KPiB2MjogRml4ZWQgYSAgYmFja3dhcmRz
IGNvbXBhdGliaWxpdHkgaXNzdWUgcmVwb3J0ZWQgYnkgQnJpYW47DQo+ICAgICBGaXhlZCBQeXRo
b24gdGVzdCB0byBjb3JyZWN0bHkgZGlzcGxheSB1cGRhdGVkIGNvbmZpZ3VyYXRpb24NCj4gDQo+
IA0KPiAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKg0KPiBUaGlzIHBhdGNoIHNldCBhZGRz
IGEgY2FwYWJpbGl0eSB0byBtZXNoLWNmZ2NsaWVudCB0byBnZW5lcmF0ZQ0KPiBhbmQgc3RvcmUg
dmlydHVhbCBsYWJlbHMgYW5kIHVzZSB0aGVtIGluIGNvbmZpZ3VyaW5nIHJlbW90ZQ0KPiBub2Rl
J3MgcHVibGljYXRpb25zIGFuZCBzdWJzY3JpcHRpb25zLg0KPiBSZWd1bGFyIGdyb3VwIGFkZHJl
c3NlcyBhcmUgcHJlZXNlcnZlZCBhcyB3ZWxsLiBUaGlzIGlzIGRvbmUNCj4gZHluYW1pY2FsbHk6
IGFzIGEgbmV3IGdyb3VwIGFkZHJlc3MgaXMgZGV0ZWN0ZWQgaW4gZWl0aGVyDQo+IHN1YnNjcmlw
dGlvbiBvciBwdWJsaWNhdGlvbiBjb25maWd1cmF0aW9uIGNvbW1hbmRzLg0KPiANCj4gVGhpcyBu
ZXcgY2FwYWJpbGl0eSBvZiBtZXNoLWNmZ2NsaWVudCBhbGxvd2VkIGZvciBpbXByb3ZlZA0KPiB0
ZXN0aW5nIG9mIHZpcnR1YWwgcHViL3N1YiBpbXBsZW1lbnRhdGlvbiBpbiBibHVldG9vdGgtbWVz
aGQNCj4gZGFlbW9uLiBBcyBhIHJlc3VsdCwgc29tZSBkZWZpY2llbmNpZXMgYW5kIGxlZ2FjeSBl
bnRhZ2xlbWVudHMNCj4gd2VyZSBleHBvc2VkLCBhbmQgY29uc2VxdWVudGx5IHJlc29sdmVkIGFu
ZCBjbGVhbmVkIHVwLg0KPiANCj4gDQo+IEluZ2EgU3RvdGxhbmQgKDYpOg0KPiAgIHRvb2xzL21l
c2gtY2ZnY2xpZW50OiBBZGQgc3VwcG9ydCBmb3IgdmlydHVhbCBsYWJlbHMNCj4gICB0b29scy9t
ZXNoLWNmZ2NsaWVudDogQ2xlYW4gdXAgc3Vic2NyaXB0aW9uIGxpc3Qgb3V0cHV0DQo+ICAgdG9v
bHMvbWVzaC1jZmdjbGllbnQ6IFNhdmUgYW5kIHJlc3RvcmUgZ3JvdXAgYWRkcmVzc2VzDQo+ICAg
bWVzaDogU2ltcGxpZnkgbW9kZWwgdmlydHVhbCBwdWIvc3ViIGxvZ2ljDQo+ICAgbWVzaDogQ2xl
YW4gdXAgaGFuZGxpbmcgY29uZmlnIG1vZGVsIHB1YmxpY2F0aW9uIG1lc3NhZ2UNCj4gICB0ZXN0
L3Rlc3QtbWVzaDogRml4IG91dHB1dCBvZyBVcGRhdGVNb2RlbENvbmZpZyBtZXRob2QNCj4gDQo+
ICBNYWtlZmlsZS50b29scyAgICAgICB8ICAgMyArLQ0KPiAgbWVzaC9jZmdtb2Qtc2VydmVyLmMg
fCAxMzEgKysrKysrKy0tLS0tLS0tLS0tLS0tDQo+ICBtZXNoL21vZGVsLmMgICAgICAgICB8IDI3
MSArKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICBtZXNoL21v
ZGVsLmggICAgICAgICB8ICAgOSArLQ0KPiAgdGVzdC90ZXN0LW1lc2ggICAgICAgfCAgMTEgKy0N
Cj4gIHRvb2xzL21lc2gvY2ZnY2xpLmMgIHwgMjQyICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLS0tLS0tDQo+ICB0b29scy9tZXNoL2NmZ2NsaS5oICB8ICAgNSArDQo+ICB0b29scy9t
ZXNoL21lc2gtZGIuYyB8IDEyOCArKysrKysrKysrKysrKysrKysrKw0KPiAgdG9vbHMvbWVzaC9t
ZXNoLWRiLmggfCAgIDQgKw0KPiAgOSBmaWxlcyBjaGFuZ2VkLCA1MTQgaW5zZXJ0aW9ucygrKSwg
MjkwIGRlbGV0aW9ucygtKQ0KPiANCg==
