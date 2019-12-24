Return-Path: <SRS0=L7UJ=2O=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C87C3F68F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Dec 2019 19:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C007206D7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Dec 2019 19:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="DR4wPPyD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfLXTFP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Dec 2019 14:05:15 -0500
Received: from mga06.intel.com ([134.134.136.31]:52057 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbfLXTFP (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Dec 2019 14:05:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Dec 2019 11:03:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,352,1571727600"; 
   d="scan'208";a="419063372"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by fmsmga006.fm.intel.com with ESMTP; 24 Dec 2019 11:03:13 -0800
Received: from orsmsx113.amr.corp.intel.com (10.22.240.9) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 24 Dec 2019 11:03:13 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX113.amr.corp.intel.com (10.22.240.9) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 24 Dec 2019 11:03:13 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 24 Dec 2019 11:03:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNkg1GSsa88UdmKuC8N3TOzrURsLFZoazZJe3jxfEm8oQF9G2A4Q03jjmAigVTnA7xdagqdoyZLELJ/0SGFfN69z2rg9R0YK1Xcq8tVA2JvmpmCc5BHA8/l6e2P+ppbgBbhkGDxgyyjkKbJYwtPF/YOnVdmzblbVi+qSVGSZUNZGrhxD7wq+3B+tds/khfYEOUAzF3CrVrDluajTekRdBi/047Fggrs9NuRdqTBVuhnmWHxs7HfzIq3i2K6hs+qHk/KxWELAYmhMfrxYwDvPzc4uNBWheieL7SqjMr13ARmtGr5s09c/1zAKQ4eB1skfUcDc62ZepBLh7qge8POGZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+r7qHGaO3FNyP2rfy2qcMbdr+VOr6A++naIxDmd+s6g=;
 b=L6oxC2wVcNjJrLP2g/P2p5uy7o7mMFyBLlv/4l5wfsriQjgBqeIxEUfRlZU2EG5rnzJcKJ1qgQd2QNwaKMzFVQrkcvhU2qApg+SUbD5KYblTtpOb36MhNdJTaI354lRUCWec4Mfr/vQ+n3IjeeCltx3Nt32DPF6xCJgKy4IZ6ALR/Hw/BFbqrO3QlBH4bwl9GnvyVOgx4ap9yBH3fb+nKhqSRD28iZk851plpzdUbcsMeq4gFmYw03MDmLwQRPduPkNAbW2Zks0zF0gfub9hTvxqrl4DVjdPSO375ndtQNvKsIum+Cq3gjkA6cdkKWNejBpLBWXsxLrGYoj2vRZLeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+r7qHGaO3FNyP2rfy2qcMbdr+VOr6A++naIxDmd+s6g=;
 b=DR4wPPyDbfYUMxVWBOC5HLeaeHmrEO/oS+4p51KNfsHdRtY9Qj0WB4WSqDFAhqKqznRV6aGplAgwD2aygahupgc4Qg449s/3kH527Jwt3rlHZ0BzhiBWqPtmAZobpOMkPSGKxwJ7e0uEjQDsc+YjEjB/G5UeRwTL5gdl7qQOcI8=
Received: from CY4PR11MB1269.namprd11.prod.outlook.com (10.173.16.11) by
 CY4PR11MB1750.namprd11.prod.outlook.com (10.175.81.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.20; Tue, 24 Dec 2019 19:03:12 +0000
Received: from CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::39e0:30e9:a8b0:fe24]) by CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::39e0:30e9:a8b0:fe24%3]) with mapi id 15.20.2559.017; Tue, 24 Dec 2019
 19:03:12 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ 0/2] mesh: Fix some SNB details
Thread-Topic: [PATCH BlueZ 0/2] mesh: Fix some SNB details
Thread-Index: AQHVt3IHnxCrVzSK10Ohbpw8uMA/bKfJqq6A
Date:   Tue, 24 Dec 2019 19:03:12 +0000
Message-ID: <b8867b5c50b99393d8b62cc3d1e8444afca2c0b0.camel@intel.com>
References: <20191220201340.8039-1-brian.gix@intel.com>
In-Reply-To: <20191220201340.8039-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db27b7df-cdd4-47c2-ec50-08d788a3ec66
x-ms-traffictypediagnostic: CY4PR11MB1750:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB1750F9665F966297A35ECB9AE1290@CY4PR11MB1750.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0261CCEEDF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(346002)(39860400002)(366004)(199004)(189003)(8936002)(2616005)(81166006)(6916009)(8676002)(2906002)(6486002)(66476007)(66556008)(26005)(316002)(4744005)(81156014)(5660300002)(71200400001)(86362001)(76116006)(91956017)(64756008)(6512007)(6506007)(66446008)(478600001)(36756003)(4326008)(4001150100001)(186003)(66946007)(107886003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR11MB1750;H:CY4PR11MB1269.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VOMsOlsCe/FA54TPL2IA07dNk+WGvOYxj+1xME12JvWvJj2K2CPEnzhItKlyXM5+VJ3vHOfBCCgriZPRLRTFuMim+q9YuPmi1U6TXX/bL2bVLzhfr25njHoPrFRyxOdNNsTJ6einmofvoL1NjP6JQHLkY6wkazOzbc21m1XTAhhvPeofH26TvSGqz3wzbGqQAVRAoyoI1hfq1a7Xbs/W1ODxw4pdkuB6UqmpnPnXBRTZWWRO6fJ+cAtn1f35Dk5VIhK/H9bi5C8OfPxmODOh+anvPAa7aY0VkW6p45h+nbE9ZLRDmV9P+CzA9Edegig52bZOb0FC2rfskz908xTQGRl76Fi7g/LQDt8oMbfmfsVvKew882qweqPY+EDMi9GKD96q/40QnimVXhW5LNHZZVbXR1ytVin+lHHaBGicPbltXcM9cnE3+sVcGRqMrU5W
Content-Type: text/plain; charset="utf-8"
Content-ID: <3693E6A8501C474CBC89C4D3E9298740@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: db27b7df-cdd4-47c2-ec50-08d788a3ec66
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2019 19:03:12.2599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f5qlpYumBygJ0zBowseL6ujEO6IN4TDEgI6UN6P2IMlq7JtpjL8b+SnEiMFbnhMy2eV/HoNFcuOX21Z2SVMHCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1750
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2hzZXQgYXBwbGllZA0KDQpPbiBGcmksIDIwMTktMTItMjAgYXQgMTI6MTMgLTA4MDAsIEJy
aWFuIEdpeCB3cm90ZToNCj4gVGhpcyBmaXhlcyB0d28gbWlub3IgZmxhd3Mgd2l0aCBTZWN1cmUg
TmV0IEJlYWNvbnM6DQo+IA0KPiAxLiBXaGVuIGEgbG9jYWwgbm9kZSdzIFNOQiBjaGFuZ2VzLCBh
bGwgbG9jYWwgbm9kZXMgc2hvdWxkIGJlIG1hZGUgYXdhcmUNCj4gb2YgdGhlIGNoYW5nZSBhIHRo
ZSBzYW1lIHRpbWUgd2Ugc3RhcnQgc2VuZGluZyBvdXQgdGhhdCBiZWFjb24uDQo+IA0KPiAyLiBU
aGUgc2Vjb25kIHRoYXQgYSByZW1vdGUgYmVhY29uIGlzICJzZWVuIiBuZWVkcyB0byBiZSByZWNv
cmRlZCBzbw0KPiB0aGF0IHRoZSBTZWNvbmRzU2luY2VMYXN0SGVhcmQgcHJvcGVydHkgY2FuIGJl
IGNvcnJlY3RseSB1cGRhdGVkLg0KPiANCj4gQnJpYW4gR2l4ICgyKToNCj4gICBtZXNoOiBEZWxp
dmVyIG5ld2x5IGNvbXBvc2VkIFNOQnMgdG8gbG9jYWwgbm9kZXMNCj4gICBtZXNoOiBSZWNvZ25p
emUgU05CcyBpbiBTZWNvbmRzU2luY2VMYXN0SGVhcmQgcHJvcGVydHkNCj4gDQo+ICBtZXNoL25l
dC1rZXlzLmMgfCAxOSArKysrKysrKysrKysrKysrLS0tDQo+ICBtZXNoL25ldC1rZXlzLmggfCAg
MSArDQo+ICBtZXNoL25ldC5jICAgICAgfCAyOCArKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+ICBtZXNoL25ldC5oICAgICAgfCAgMSArDQo+ICA0IGZpbGVzIGNoYW5nZWQsIDQ2IGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0K
