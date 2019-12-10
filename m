Return-Path: <SRS0=8Xmo=2A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D2DC43603
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Dec 2019 18:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ECB420836
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Dec 2019 18:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="tALFcpx2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfLJSlB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Dec 2019 13:41:01 -0500
Received: from mga09.intel.com ([134.134.136.24]:47686 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727558AbfLJSlA (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Dec 2019 13:41:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2019 10:41:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,300,1571727600"; 
   d="scan'208";a="215528607"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga006.jf.intel.com with ESMTP; 10 Dec 2019 10:40:59 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 10 Dec 2019 10:40:59 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Dec 2019 10:40:59 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 10 Dec 2019 10:40:59 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.51) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 10 Dec 2019 10:40:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCE7rBbhzsIahBxh4y2+ES/ifVmGGiQPguo2xsTziQAPFLbP694m0wO28FG//PD5fTU0myEsCZZEFNmeX7BXQuTAIUW1tZYuzMrh1M3Zt8te6A0hGetFA73tlfxyMobNiuntDDTzbYX+cJIW/j5nesuCegYGq3C6EIw5JnM85ZQ2xprIkDKZ3MNiKbUNLDt5DV2ZPnLeiofB6o1vTr3tia087o5aJs+aakDfUglK1Q0h9XGuaGssd6sb+MGdNh6r67tXRh3LXyisv8EhcHVzcqz+jn09I/pr/myTuJ1OhbdNmH4lRKSLYPpHCVOxEtsy9w3+BcyQKyObeRz+qFmioQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4HhckGp8W1DNpQPmbfmMnkOy40hijxl6x+TzbX8ns4=;
 b=deOcyNAnDcSYfEB3L+CkZkLPi4tGMZWmWb2RVKMw2dMRv2CwkrX/rYvZHmc3JTYQPiczWmPYu4x8AoUm7zU77sIcmGkZ1XIZIA+cLx4vGC1qfkSSEoPmPprzCV3c7Pu80gfi45xfuTEzE7r1/AXcPwLk+BR6Df55t9D/5GappIyqMciWbyNWRlLn14rniwKRF7K80OQyUIxTqzmFHPTcV1u+ifG1bITgKthy1Z3tPYQjFyx/x0Jja6hoDVEcaTCLSkOIGbmMV3A/N7uHgi/SSCrswe2akBSL5MaZRhM95T8Sow13DPLlsdL2L9izFKbL7TB1WPyyaSRmcx1cabICRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4HhckGp8W1DNpQPmbfmMnkOy40hijxl6x+TzbX8ns4=;
 b=tALFcpx2OC6cUTy89Rp+2OMD36DVSYzVHZd6FoVwhLF9NF7HVz5sKeQBfkRtgcUvrlTy2lzVQQx9lQ2yVqndnOIOg9VTXArkXDHueqfkx12lFsCDJ/2n6D5+l0CxefUAZIH1G/8BQm5fKkFQMndzEB/KqUYbBB+8W0U7K/W+jis=
Received: from CY4PR11MB1269.namprd11.prod.outlook.com (10.173.16.11) by
 CY4PR11MB1640.namprd11.prod.outlook.com (10.172.68.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Tue, 10 Dec 2019 18:40:57 +0000
Received: from CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::a12f:7254:eec:b905]) by CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::a12f:7254:eec:b905%3]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 18:40:57 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ 0/3] mesh: clean up
Thread-Topic: [PATCH BlueZ 0/3] mesh: clean up
Thread-Index: AQHVrHfpjYKVRRm20Eap1+OZfFPXc6ezucUA
Date:   Tue, 10 Dec 2019 18:40:57 +0000
Message-ID: <778f46839963949e178bc4482093e483d00cae68.camel@intel.com>
References: <20191206205749.12918-1-inga.stotland@intel.com>
In-Reply-To: <20191206205749.12918-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11380c90-3cfa-4808-e704-08d77da07ec8
x-ms-traffictypediagnostic: CY4PR11MB1640:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB16400D2CB567150931CA18D0E15B0@CY4PR11MB1640.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 02475B2A01
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(376002)(396003)(136003)(189003)(199004)(81166006)(81156014)(4744005)(26005)(71200400001)(8936002)(76116006)(5660300002)(36756003)(64756008)(6512007)(6486002)(6636002)(66556008)(110136005)(66476007)(91956017)(66446008)(66946007)(186003)(86362001)(478600001)(8676002)(6506007)(2906002)(316002)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR11MB1640;H:CY4PR11MB1269.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dTSYQGBY3p8OXPSFrki7LyfPzUG5RzW+QQUcle9+dLquulpQreVLL1Cyw1iyOUd2hJVeUprUvfxNEMDaJC3UZl1eDQeJ39XtIPRXTPR27i816OXf6n/A4RG4TtN7FhcDOMqbu1+QJKg0tHLx6MVT1fnxAOeU3Anklhg9VZmVrUnDXgloBZGLvNYn6uBT8v69W9qXl+yavIDnepMyGxG4Vp763WLY3jKhmjjtqEh6FtPFXM5h/Kww3NgD8cOiBibtPne3JOUdE4YgO2zFuI6O02BV4zVCy6JaH/uOgM9Uv63pProagV3Z7Pqr6HKquVC2cYBeXKenUopoBCytzn7w2GhIWv8fnsvBGVjFLa/h+k06uR/XTj6NBzfWG3uHZc3y3vycWDST9UokiEiS6QF+nLHOAac2Y/DmfegUAoe+0wD/qp/ltly/DbaFRjSAEQnt
Content-Type: text/plain; charset="utf-8"
Content-ID: <AED6209F1D016A41BED3F6A69E00B751@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 11380c90-3cfa-4808-e704-08d77da07ec8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2019 18:40:57.0719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cDFf1HFGNDSzlKPnVdlsSetHY41XrZxdrB/SSkkh82bGgw+dAYacG8qDKqRGNNVhY36B2ys9XJGrBZvtj2xSdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1640
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2hzZXQgQXBwbGllZA0KDQpPbiBGcmksIDIwMTktMTItMDYgYXQgMTI6NTcgLTA4MDAsIElu
Z2EgU3RvdGxhbmQgd3JvdGU6DQo+IFRoaXMgc2V0IG9mIHBhdGNoZXMgY2xhZW5zIHVwIHNvbWUg
Y3J1ZnQgaW4gbm9kZS5jIGFuZCBzb21lIGluIG5ldC5jDQo+IFRoZSBkdGFhZmxvdyBpcyBhIGJp
dCBtb3JlIGRldGVybWluaXN0aWMgbm93Lg0KPiANCj4gSW5nYSBTdG90bGFuZCAoMyk6DQo+ICAg
bWVzaDogRGVsZXRlIHVudXNlZCBmdW5jdGlvbg0KPiAgIG1lc2g6IENsZWFuIHVwIG5vZGUuYw0K
PiAgIG1lc2g6IEluaXRpYWxpemUgbmV0IG1vZGVzIGJhc2VkIG9uIG5vZGUgY29uZmlndXJhdGlv
bg0KPiANCj4gIG1lc2gvbWVzaC1kZWZzLmggfCAgIDIgKw0KPiAgbWVzaC9tb2RlbC5jICAgICB8
ICAxNyArLQ0KPiAgbWVzaC9tb2RlbC5oICAgICB8ICAgNCArLQ0KPiAgbWVzaC9uZXQuYyAgICAg
ICB8ICAxNSArLQ0KPiAgbWVzaC9ub2RlLmMgICAgICB8IDUwMyArKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgbWVzaC9ub2RlLmggICAgICB8ICAgMSAt
DQo+ICA2IGZpbGVzIGNoYW5nZWQsIDIwMCBpbnNlcnRpb25zKCspLCAzNDIgZGVsZXRpb25zKC0p
DQo+IA0K
