Return-Path: <SRS0=kLeu=CG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543CBC433E2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Aug 2020 21:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2518B20838
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Aug 2020 21:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="FY/Dn/I/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgH1Vxj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Aug 2020 17:53:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:57158 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbgH1Vxh (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Aug 2020 17:53:37 -0400
IronPort-SDR: SeW0l5No/PWpiaz5HctxNFN3j7cRlfA3HmIIRkUr7swyT00bRGMCTlOuDlZFTSlXRvu42c3Nby
 h/JUwl/iNBmg==
X-IronPort-AV: E=McAfee;i="6000,8403,9727"; a="154164468"
X-IronPort-AV: E=Sophos;i="5.76,365,1592895600"; 
   d="scan'208";a="154164468"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 14:53:36 -0700
IronPort-SDR: jvXL6snMzOuyo9UEEKZmsNJyH1ByuIjfX3ODqcSB6EP5N7mEwsdaKT3fvAj14Rcdnl4todIMTA
 xUL3sW9pqOGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,365,1592895600"; 
   d="scan'208";a="296270523"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 28 Aug 2020 14:53:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 28 Aug 2020 14:53:32 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 28 Aug 2020 14:53:32 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 28 Aug 2020 14:53:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ur22O2QnRfAIZy5g8e0gJ8wXn5cj/8U58XY9GdAIusKI9FRkR8n9AQUFcQT4rxfJj7lPNXaKBBwuW2A0w+ysxlwSW+Ks4xUw8wc7cM5ZhzWXDpqcSJKKckKt6+5xH1RxDe1LHfFo0F6XIGUGg9FfEjAb2wPfMmOSocQE39xY/wFKgVUvPtaWYRLiMh11Lzuniu1phryGN8I2YLMUFezqigCvmvOKLLdLbTOqJkkn8/GG8QjKKfUxxgGa3kUBndsIhqizHOi9RXGC4uDAa7rwZ65+f4lpTGk0KGcuo9p8BR0nc3lksDDcU/GyPrSrF/4Dm37mN5nu2uIZB4rQv6FL8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPYxisI9gkL85lO6vq6nbLTibgG740HRSirc3NJZiBw=;
 b=Ko551163lG5im65yDjP+cKlI6+7NunDoo4qpjrVK4UNGGT1DcIZD2ALpv7j9NZr0XBzvEsAK12uLhsVFu84764ZhPdUYkQmZKFcWHScwExXsK9WaFC+JVy8u69X5hlnu0Pepe55gC61iRxq/K7BW9vP4vrkYO/Lrc9+3QtkJd1fnDcRn5uYMC9XyuZMR4QM5iJ1j3Kt84xt/8SYKWrndGwtVZLGR4dI7fWcOsjY5ojM0qdbcCP4HhlyUVucqmTH77lWcHlNQBI89uvWiks5eonllNCzPl1Hkssz1BE/HkSySQkUp/x3FpkFaN/oSLs21+3ZntQMNDA5FTb3I+L6KIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPYxisI9gkL85lO6vq6nbLTibgG740HRSirc3NJZiBw=;
 b=FY/Dn/I/b/9b+iM5Ng7JDnrXI5cBuArTTWVCvzx0GSh9TtQyJ3bAn3pu9IPhbdgrCcytBSh5b68rjVpDnkRoBmbSy3iWc+F7xW4XUXhgO+LTah/f3N6luAyhbwxgeFmLWh1Vt0ZJ/3E2d8hpA+RPBCKOf0Y4Gq30RTc0i0pgMFs=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR11MB0080.namprd11.prod.outlook.com (2603:10b6:301:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Fri, 28 Aug
 2020 21:53:29 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225%6]) with mapi id 15.20.3326.021; Fri, 28 Aug 2020
 21:53:29 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ 0/2] Mesh replay protection clean up
Thread-Topic: [PATCH BlueZ 0/2] Mesh replay protection clean up
Thread-Index: AQHWfXZyNR3qUURG4Ua5e0Xzxgi9P6lOEGUA
Date:   Fri, 28 Aug 2020 21:53:29 +0000
Message-ID: <e9869cfd5eb4ebb48e9716987a2407bca33903b7.camel@intel.com>
References: <20200828200427.18753-1-inga.stotland@intel.com>
In-Reply-To: <20200828200427.18753-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e2c9134-0d49-4bc9-2e65-08d84b9ccc7f
x-ms-traffictypediagnostic: MWHPR11MB0080:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB008047635BD6B18111CF1E23E1520@MWHPR11MB0080.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JPOGQUgYYVXZafwmf9ZVnGVfpRuFrhH4wKbk5pKWVahHoWVC0PsavAGqLJxj+a9p7YoWAZQqCv8xme6FH7O2fFY+MZwEyh+ACpP0X1bN8kQk3InS0GjrLvvJbfmMZBC78OLb/5+E9EheriUmWRD+bryLre8COjAX4pTARLZb/JtBi3xeJ2LSJYIEzK3aHPL/R3Qj61SS03l6l5K18bgoLSsplMMfAlCi11MImegtDiMMLHgYPMW7EgXFSezhV0JE+4jCSFtmdrhDHFbCI67BqYLDNXno88oZqfGcK5wdBrOfHF3yiUxDngGh/MrnCdZTY+z/VgwXVt9tPSdpkLdkeA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(86362001)(8676002)(8936002)(316002)(83380400001)(478600001)(110136005)(6486002)(36756003)(66476007)(5660300002)(6636002)(66556008)(71200400001)(4744005)(76116006)(6506007)(26005)(186003)(91956017)(66946007)(6512007)(2906002)(66446008)(64756008)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 3Dh4R7UhxzUWj11peEc3WN/3514PiKjoGyC9pJJNZ+k76N8xElHOez1agjjNlnTir39WfWiaj77yAqX+GrxpFEcQy83WoLgadIeIN7GS+hq0hcZ/xYXmdiCIwbLvlGxKDezmyeH04SObWabSK81MEFkkASfF3H0uE278+WHyX0FaUh2L8V7sFXzgfAiAs6cladUVp1/0MfKTnOJlxXRyRKi7cwP3Orq1hQ2Y3/EzICKIZwxInmLUfoROYNs78XD5YaNNYJsiEErtTQXyN9QfhPfbIp9XdMSvezhV7VUc/la9qXTDzKresZvjWC2xCF/tvoblQ5EtS/HcnMQZmzijtPHF27Fu0+A4KkRABVme5xghvAmbUOLPm3tkXuxhgARO6/LYf8HMKlQMCxLcgMvIIQkEIBHe/rVd5vs3Nz/dIM+RCaY3iWUAc5pB4KSdoHt7Ffl2hxfEJ0ILEOYFXiSN7K8GJBG4E8lWKF0boFCJapK+SMoZoqLVAlPhFhCnP507CmSEdEnSMsCKgHGKwk2v47nDwPSAYAwYv6KsSThdNoUIaSy4hOHSo3DWeG0HjZFm5xpwE/mw8Anw8LmemUDYA1uuiULMBhKJT312499wTFew2vMihqfKxG3KK6zjOSG2FAQ0lJbxOshjTN75I+jC9w==
Content-Type: text/plain; charset="utf-8"
Content-ID: <29B3B246E628B94FA0369EB7E3B1A2CC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2c9134-0d49-4bc9-2e65-08d84b9ccc7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2020 21:53:29.0395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oyh0duNgxqc2dcRB6M0xpHbD5T8XsYNF+8xPjUhFmTKpJOCGiPWvXzqLYn8JSIeaNDNQhMo89COD0RRBouHDvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0080
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gRnJpLCAyMDIwLTA4LTI4IGF0IDEzOjA0IC0wNzAwLCBJbmdhIFN0b3RsYW5k
IHdyb3RlOg0KPiBUaGlzIHBhdGNoIHNldCBtb3ZlcyBSUEwgaW5pdGlhbGl6YXRpb24gdG8gdGhl
IG5vZGUgaW5pdCBzZXF1ZW5jZQ0KPiBpbnN0ZWFkIG9mIGNoZWNraW5nIGZvciBldmVyeSBpbmNv
bWluZyBtZXNzYWdlIHdoZXRoZXIgUlBMIGhhcw0KPiBiZWVuIGluaXRpYWxpemVkLg0KPiANCj4g
QWxzbywgdXNlIGNvbnNpc3RlbnQgc2l6ZSBjaGVjayBmb3IgUlBMIGRpcmVjdG9yeS9maWxlIHBh
dGhzLg0KPiANCj4gDQo+IEluZ2EgU3RvdGxhbmQgKDIpOg0KPiAgIG1lc2g6IEluaXRpYWxpemUg
UlBMIHdoZW4gY3JlYXRpbmcgb3IgbG9hZGluZyBhIG5vZGUNCj4gICBtZXNoOiBNb3ZlIFJQTCBj
aGVjayBmcm9tIG1vZGVsIHRvIG5ldCBsYXllcg0KPiANCj4gIG1lc2gvbW9kZWwuYyB8ICAxOCAr
Ky0tLQ0KPiAgbWVzaC9tb2RlbC5oIHwgICA2ICstDQo+ICBtZXNoL25ldC5jICAgfCAxOTggKysr
KysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICBtZXNo
L25ldC5oICAgfCAgIDUgKy0NCj4gIG1lc2gvbm9kZS5jICB8ICAxMSArLS0NCj4gIG1lc2gvcnBs
LmMgICB8ICAyOSArKysrKy0tLQ0KPiAgbWVzaC9ycGwuaCAgIHwgICAzICstDQo+ICA3IGZpbGVz
IGNoYW5nZWQsIDE0MyBpbnNlcnRpb25zKCspLCAxMjcgZGVsZXRpb25zKC0pDQo+IA0K
