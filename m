Return-Path: <SRS0=u3xs=74=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF8FC433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jun 2020 16:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12E6320663
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jun 2020 16:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="hh5JKwm+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbgFOQzM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:55:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:43826 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729772AbgFOQzM (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Jun 2020 12:55:12 -0400
IronPort-SDR: Q+H9w7GDz2JDhhlGAVHiaKO8cQ7VGe7gpnML6FN7WEdtEx1HViOV/RWA9orZa2xGq9zQ3l1kw1
 SRiu78a62RMg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 09:55:06 -0700
IronPort-SDR: B4tQ2jPMflcmzm706kNsONcs8hr9B6QqgQN7nI4FHBcAHMU/De+Z/DFkc+oUxYbdbciDiBPcIw
 gACdM+Rag/cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,515,1583222400"; 
   d="scan'208";a="261154639"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga007.fm.intel.com with ESMTP; 15 Jun 2020 09:55:05 -0700
Received: from fmsmsx102.amr.corp.intel.com (10.18.124.200) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 15 Jun 2020 09:55:05 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX102.amr.corp.intel.com (10.18.124.200) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 15 Jun 2020 09:55:05 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 15 Jun 2020 09:55:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJShIeNkuxe2TQ1rW1YmLFPkkUCXgx1YScPy6y+B5KU4mGsJt6/GRYVKQ/lTAvvmDHEEbwBkMwEkXwd20shxlTVKL6yjcvLPi95HMmJDMJBJHSGkNGFqOuNAFgLw9HpazdOkHood9VOGw9vzBAY6JF6yqtnL53/Ky6ry+5deySwxk+3aQOOG3Y0Mf2GB+qmOIzfnxoY1UCQ1FtGCG3XdmxL3ZfA3vvoDDPBLkMyQCMA7OWOQE3bQRYupSxer4EX6cR20QsptmsDODoaAvst5WFXzUznT3VY3cRICQEekuFIW5LmLmjbbbmq8MsJTykpUnvN/IXPwmqLx83hjDT+Bbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWXC44K/qSlsfMkV7Ku07Zl9893t05fROf/63jz0xic=;
 b=HjUlntbyetpsXnZYrGrYfhKClhFNDo6S56AGdzyVS7yz/uwCbyMX5d24AD9IjQFnpj6dAYE3yKOdAJQhFz3orvZWY3AZADCprVTxDD5opuUQw4K0BMSE5Qk6kDdDdqUU8Y74v55yQ+EIxZR4L/xfoLaStRu0ABjJV0UR3+LbVYpK2TbmbT/BDsaGe6wjhr3BO1CgIEZN3waEGi3y/NYBIklyYvMw7WNYuq4s8pVn4evj0qO5aA2HJmYg+tI24XWqt1sYMzJ339uy22PwSlwJw8N9zknsGmJMNuIfiEKo7/ao+N5Lu7mCbDkObNqTv3qRap/03BY4XJw4IXTyO9sxsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWXC44K/qSlsfMkV7Ku07Zl9893t05fROf/63jz0xic=;
 b=hh5JKwm+VatSfsAi9zW4auVzEiLx3cHpFpV14PWHg/M6dw5eYjtVnRFmjyJeDsBQ+UBmdFIORi5kA7Cev5nA3Cu1ieqy4byhQMomdW+/IJRZneMZULNyQfP46xDaKKAfJpNCTELsRozrOZRFiQzu9cI/rfu0/HDpcVExRyIHniY=
Received: from MW3PR11MB4556.namprd11.prod.outlook.com (2603:10b6:303:5b::21)
 by MWHPR11MB1789.namprd11.prod.outlook.com (2603:10b6:300:108::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Mon, 15 Jun
 2020 16:55:03 +0000
Received: from MW3PR11MB4556.namprd11.prod.outlook.com
 ([fe80::4de0:98c5:c41a:8b6]) by MW3PR11MB4556.namprd11.prod.outlook.com
 ([fe80::4de0:98c5:c41a:8b6%8]) with mapi id 15.20.3088.029; Mon, 15 Jun 2020
 16:55:03 +0000
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Gix, Brian" <brian.gix@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Fix updating CID, PID, VID & CRPL on node
 attach
Thread-Topic: [PATCH BlueZ] mesh: Fix updating CID, PID, VID & CRPL on node
 attach
Thread-Index: AQHWQwXKFs1zOP8qg0mVQaD57jQ/6qjZ5WGA
Date:   Mon, 15 Jun 2020 16:55:03 +0000
Message-ID: <7e3d9cc85bca1dc0198bd82f92d87441bce31416.camel@intel.com>
References: <20200615111152.29089-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20200615111152.29089-1-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.3 (3.36.3-1.fc32) 
authentication-results: silvair.com; dkim=none (message not signed)
 header.d=none;silvair.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.139.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c53657e-6e01-44e8-784e-08d8114cd992
x-ms-traffictypediagnostic: MWHPR11MB1789:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1789FD379C5E21DFD6D3DF42FB9C0@MWHPR11MB1789.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 04359FAD81
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W98LqZLKOcjmf3TR9h8LVZZayumqpiwUWQY2v+KyuZ/SU2g48C3qdh5DlNQ8bpjEvug69Fcczb7YrZlqKZvXw73FTIvL1KjFFQ/XumPBMBWg3JSigvg+/VttZC6u4VmF9NJRv15xkcoL3cgNi63dwE1z/5wwnR1fChrCw/isuFgSxp1peoSStDkWBfiIXJy7NI/9lkkYyZi3dtG4ayg5dsYDNnSSx0LRXGqHdn5HJoZjxhmScvWeGEXgFrcaBnnDw31pNER5ua4kta7pPZX/lABlMfQcHK87ZG7eUEOYF+HTPvKpMkFxWRqo0GEFMKwBJ+2xaG1E8hdUHPM/kTwybw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4556.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(39860400002)(136003)(396003)(346002)(376002)(66946007)(2616005)(66476007)(66556008)(64756008)(66446008)(2906002)(8936002)(36756003)(186003)(478600001)(316002)(76116006)(6506007)(6486002)(6512007)(4326008)(26005)(86362001)(71200400001)(8676002)(107886003)(5660300002)(83380400001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: tZ5Skvaxxg4fIQjEopWTq1nfH+RMHCAcH6sTbfKdEHJlJQu7MlBg+BdMeuqaCJSb+MMbMdaQII24qskR4gVbL9zh+YGEUyX0JuVZluyuViL6BkH8k9CY+w91zq0NCsAJDDMbmfoxhxVQAS9zGtKD/dEbtIP4uFIdQsG7riBi+Rhu2FofA9buHRxzB0NMm7yjSOFnmhRjaN/Yec8M6250mDCCS/IeGdybSx4jcntD+UQfDzD/yhZuA370gmpSOGS4ntDfmyKfKeBGQlVR734Y5Z1Kzt//OT3SrUXVr03qvs1r/tK1RbSKJqqNrXqsg8naA2NVD83smIzqf8jArHoUejcpB6la0noidbkhRYsdMAqJo2KnxF/yJZG2m20qho27jaNdbREF9Bs4ajmkeW37Xq1yHoKDEJkX2FUrF3A8bds0CVu5apzg5D2bOdzKGxE5JyN0PggjqvNYSOtRNuENSae5LKX7U0uwAe6yP2ksGorWaNmXZh11gH9pb4CzYe4V
Content-Type: text/plain; charset="utf-8"
Content-ID: <108A2EDAAD45DD478FA6FF17A944528B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c53657e-6e01-44e8-784e-08d8114cd992
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2020 16:55:03.7082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z1YKfCAXiqEn53FgfJANkAJT75oGA8DWDF0ZqdlNbXxhUIflhSXgNWO4RycNbvIDIrDjNuw0ilkaMddsZdVJ1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1789
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

R29vZCBjYXRjaA0KDQpPbiBNb24sIDIwMjAtMDYtMTUgYXQgMTM6MTEgKzAyMDAsIE1pY2hhxYIg
TG93YXMtUnplY2hvbmVrIHdyb3RlOg0KPiBJbiA4YTM4MjI2MjEyNTc4N2NhZjM4YTFmODAwZWM4
OTU2YTFiZjcxZDg1LCB3ZSB3YW50ZWQgdG8gYWxsb3cgdGhlDQo+IGFwcGxpY2F0aW9uIHRvIHVw
ZGF0ZSBjZXJ0YWluIGNvbXBvc2l0aW9uIGZpZWxkcy4gVGhpcyBwYXRjaCBtYWtlcyBpdA0KPiB3
b3JrLg0KPiAtLS0NCj4gIG1lc2gvbm9kZS5jIHwgMTAgKysrKysrLS0tLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9tZXNoL25vZGUuYyBiL21lc2gvbm9kZS5jDQo+IGluZGV4IDEwYjQ0YzhhNS4uNjE0MGZkZjlm
IDEwMDY0NA0KPiAtLS0gYS9tZXNoL25vZGUuYw0KPiArKysgYi9tZXNoL25vZGUuYw0KPiBAQCAt
MTM2NSwxNiArMTM2NSwxOCBAQCBzdGF0aWMgYm9vbCBhZGRfbG9jYWxfbm9kZShzdHJ1Y3QgbWVz
aF9ub2RlICpub2RlLCB1aW50MTZfdCB1bmljYXN0LCBib29sIGtyLA0KPiAgc3RhdGljIHZvaWQg
dXBkYXRlX2NvbXBvc2l0aW9uKHN0cnVjdCBtZXNoX25vZGUgKm5vZGUsIHN0cnVjdCBtZXNoX25v
ZGUgKmF0dGFjaCkNCj4gIHsNCj4gIAlpZiAobm9kZS0+Y29tcC5jaWQgIT0gYXR0YWNoLT5jb21w
LmNpZCkNCj4gLQkJbWVzaF9jb25maWdfdXBkYXRlX2NvbXBhbnlfaWQobm9kZS0+Y2ZnLCBhdHRh
Y2gtPmNvbXAuY2lkKTsNCj4gKwkJbWVzaF9jb25maWdfdXBkYXRlX2NvbXBhbnlfaWQoYXR0YWNo
LT5jZmcsIG5vZGUtPmNvbXAuY2lkKTsNCj4gIA0KPiAgCWlmIChub2RlLT5jb21wLnBpZCAhPSBh
dHRhY2gtPmNvbXAucGlkKQ0KPiAtCQltZXNoX2NvbmZpZ191cGRhdGVfcHJvZHVjdF9pZChub2Rl
LT5jZmcsIGF0dGFjaC0+Y29tcC5waWQpOw0KPiArCQltZXNoX2NvbmZpZ191cGRhdGVfcHJvZHVj
dF9pZChhdHRhY2gtPmNmZywgbm9kZS0+Y29tcC5waWQpOw0KPiAgDQo+ICAJaWYgKG5vZGUtPmNv
bXAudmlkICE9IGF0dGFjaC0+Y29tcC52aWQpDQo+IC0JCW1lc2hfY29uZmlnX3VwZGF0ZV92ZXJz
aW9uX2lkKG5vZGUtPmNmZywgYXR0YWNoLT5jb21wLnZpZCk7DQo+ICsJCW1lc2hfY29uZmlnX3Vw
ZGF0ZV92ZXJzaW9uX2lkKGF0dGFjaC0+Y2ZnLCBub2RlLT5jb21wLnZpZCk7DQo+ICANCj4gIAlp
ZiAobm9kZS0+Y29tcC5jcnBsICE9IGF0dGFjaC0+Y29tcC5jcnBsKQ0KPiAtCQltZXNoX2NvbmZp
Z191cGRhdGVfY3JwbChub2RlLT5jZmcsIGF0dGFjaC0+Y29tcC5jcnBsKTsNCj4gKwkJbWVzaF9j
b25maWdfdXBkYXRlX2NycGwoYXR0YWNoLT5jZmcsIG5vZGUtPmNvbXAuY3JwbCk7DQo+ICsNCj4g
KwlhdHRhY2gtPmNvbXAgPSBub2RlLT5jb21wOw0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgYm9vbCBj
aGVja19yZXFfbm9kZShzdHJ1Y3QgbWFuYWdlZF9vYmpfcmVxdWVzdCAqcmVxKQ0K
