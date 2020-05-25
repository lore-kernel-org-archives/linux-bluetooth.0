Return-Path: <SRS0=GU2S=7H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD89BC433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 May 2020 14:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95E472087D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 May 2020 14:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Jb7u4ilj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388825AbgEYOPr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 May 2020 10:15:47 -0400
Received: from mga07.intel.com ([134.134.136.100]:24067 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388714AbgEYOPq (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 May 2020 10:15:46 -0400
IronPort-SDR: KKQCL0W0CYi4R2Y6kx7wW2jAEK6ZfElKiK8IzDVcS8UjNC+r2JnsSFDv0GIQloXyP0yecN7jor
 4gDhWPrIgSPg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2020 07:15:45 -0700
IronPort-SDR: we24BcdO3+rBZPxX3SjQPXyYUdZpA5PeoItjFdxuuWvkDuiNsr2DsjqypDJ40AItiVOLbP8HGv
 KP0YU8ZWh+sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,433,1583222400"; 
   d="scan'208";a="290882608"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by fmsmga004.fm.intel.com with ESMTP; 25 May 2020 07:15:45 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 25 May 2020 07:15:45 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 25 May 2020 07:15:44 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 25 May 2020 07:15:44 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.51) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 25 May 2020 07:15:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggb413Ns1B6DDsDbLDaiiEQ/1F9zlwYnWiRb4FkuZJnbG1nIAtbG41yUPH9RTt4ARWcxF6wJn+PDRZz4vHmTE6ofQ/YEXSmznZlQfUMYTZGQL6iVRvV1Y8kD66kW8URvW/gmQbrrJXau4wXrrxCS1CPL5NKtCKrAHmV0GLz8e+FPh4bLZhgzgkJG2wJMXpJkz7OxM3fcAFjVCMAUI6ivpT+nls1w4xti8e9ZJjKaz1iYqVmEueuOVLhPhLQ7FnqvVbLzqL2ulCgF2tE6IhkTZZIx+3v6FIkWso2m4Nym8MUeX8Ewles+WEa1NrGuaI9dFCMeE9dn753CRiorSd6KPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6hHE7pMD13dr37GA4EhRPKWgLJRjGR0DWipqr0A/mc=;
 b=O8KSjglDvzca84rcM0BOw1XeWQ5Hmbed9LdoMZN2CwTFDsE3vq1pcYlOiyM1rW5+mDeXJsxvMDKu57ZSvOEnEzRpezjmWgKTo6LmVHG8rpJWTQe6/4mLYr0tFenqH6XY0XpI1Y+bELWuXDDsd9igdKr+bbwnCRcXwflEm7KgcSTFOF15k/UDrAA9hsitWP/uXsZ5HMSuSmuZ6xN85WSr2eAMn7K7e43LSOsSeLZZBcFEBnHBJ+BNZXgupULVjNlyIQ6QHcSW+s8kML7x/cmuUms39Hu2yC0iqeMslrehnUZPTGbZctrO5cAyRmH4oqiEYqPJGJ+iecFg0AhOl4yrhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6hHE7pMD13dr37GA4EhRPKWgLJRjGR0DWipqr0A/mc=;
 b=Jb7u4ilj4+wZH2RxK0Z5/fWGfrtW3UA2ShrAj0eggijStDALSvHWJ8lhqu2MTbFS6mi/5S+msm8Gf4H/Ft5traQvmgM5f1JszqCfpejKQx0qtuK1hYTk2ZP0OUwUV/CoZ1ginQdHkDDXrP2NjRsSd9nhPu7KztvtCSyXr3iASPI=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4572.namprd11.prod.outlook.com (2603:10b6:303:5e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Mon, 25 May
 2020 14:15:41 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0%5]) with mapi id 15.20.3021.029; Mon, 25 May 2020
 14:15:41 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v2 0/4] mesh: Static Analysis clean-up
Thread-Topic: [PATCH BlueZ v2 0/4] mesh: Static Analysis clean-up
Thread-Index: AQHWMH3kt5kNS3fW/k+KNgA1H8qRRai43PQA
Date:   Mon, 25 May 2020 14:15:41 +0000
Message-ID: <837c5bd96fc3bf44e6bb791fbd2e4bab79556ba1.camel@intel.com>
References: <20200522211309.233824-1-brian.gix@intel.com>
In-Reply-To: <20200522211309.233824-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.139.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 092686ea-09c9-491d-1611-08d800b61b6a
x-ms-traffictypediagnostic: MW3PR11MB4572:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB45728430D22C0C4D26FA0705E1B30@MW3PR11MB4572.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0414DF926F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MPuHcUllx0WF2igxzbvwh5tKxTLbhYzWfuPAFK3enqASIDI3q8BcxVTTolbonCMlv3ZZrwmhdc+fVnAvX32oDzKFKurmgf2XINXO9TxbK9Lc6TYZbUyC2Hlm0sFuriTJ1Yth20Ipq0Hr5Xkn46RCHPXBBKYr1H6LiuzPPEi56c22oGAJVn6lSnoeUNOx1aEfnsZgP5H/TyzSeVV7ChkEpcs++M8H2VE20IXwzQ0DvLHKvS7HF2z+Qo0qxNzapBWhZsKth9VxJLokj2Py1LVSlcmteyL5tLDbLA3ZRHvFwt2jeXwT8x7HJoanai/DxaaFeIVUGaMIu6oL8ghRusCMoA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(366004)(39860400002)(346002)(376002)(6506007)(86362001)(26005)(316002)(478600001)(6486002)(8936002)(186003)(6512007)(8676002)(6916009)(2616005)(2906002)(66476007)(66946007)(66446008)(64756008)(66556008)(76116006)(36756003)(107886003)(4326008)(4744005)(5660300002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: W0jLyliLYIS761aYYWOCENcUjzayoJ61+vHRYamdH4nv1P9Qx6cq8EhKOprPGO/788kRPuZz6hmH0vt+pnNnBuTZMJaJiqOE3IY6E3/Yn9CBoKgWSegMiZU0eMjfTQ0MkHI7msKovmlVhzVj2vAQFDLj9We9Uceug4t40dBaCI5gs76B+g05VaCit0Z7fXI11SKshbIMu12gfOfmgbAkYjPAI4jZP9dQiS53rk2YreraTRvQWcXJQA6MA5cxWRmdyUPTX+fqG/5pDjd+QndF7RJQ0R7jJ+0XislQWi6xy+f+4BClKJfowquvL5Fk2qGM+k+XNjt0IF1OsLg0hbaWW3TjHLmuZ3nQHjOfHht+gPXPF5a+asAyWDqpfdJqIx1OpMcuHkcb6BinqJg54m/gR8jqy9MFcWX2tHL8KGdh2q85ip51JBDLIDgmML+ZbuivTpnLhumtMi9aWphBRoD27RE3tmmM/zfN7T+ewHceymOXXC6ZhlkxPn5qYEb4b5zK
Content-Type: text/plain; charset="utf-8"
Content-ID: <92FD67D5E5C5DA429DB51AD40E19004E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 092686ea-09c9-491d-1611-08d800b61b6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2020 14:15:41.5297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 91RSxQ5IjfbXnl/dV2IAYeQdlqm6uzxqbqLFQ7UN4zPrO1MLSPRyCwbJwXC/86aVlu28P/yRKi5ea0NFPr9uwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4572
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2hzZXQgQXBwbGllZA0KT24gRnJpLCAyMDIwLTA1LTIyIGF0IDE0OjEzIC0wNzAwLCBCcmlh
biBHaXggd3JvdGU6DQo+IFRoaXMgcGF0Y2hzZXQgZml4ZXMgc3RhdGljIGFuYWx5c2lzIGlkZW50
aWZpZWQgaXNzdWVzIGluIHRoZQ0KPiBtZXNoIGRhZW1vbi4NCj4gDQo+IHYyOiBDbGVhbi11cCBQ
Qi1BRFYgcXVldWUNCj4gDQo+IA0KPiBCcmlhbiBHaXggKDQpOg0KPiAgIG1lc2g6IEZpeCB1c2lu
ZyB1bmluaXRpYWxpemVkIGJ5dGVzDQo+ICAgbWVzaDogRml4IGxlYWtlZCBtZXNoX25ldCBhbGxv
Y2F0aW9uDQo+ICAgbWVzaDogRml4IGxlYWtlZCBtZXNzYWdlIHJlZmVyZW5jZQ0KPiAgIG1lc2g6
IERlc3Ryb3kgUEItQURWIHF1ZXVlIHdoZW4gcHJvdmlzaW9uaW5nIGRvbmUNCj4gDQo+ICBtZXNo
L2NyeXB0by5jICB8IDEgKw0KPiAgbWVzaC9tYW5hZ2VyLmMgfCAzICsrLQ0KPiAgbWVzaC9ub2Rl
LmMgICAgfCA0ICsrLS0NCj4gIG1lc2gvcGItYWR2LmMgIHwgNSArKysrKw0KPiAgNCBmaWxlcyBj
aGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCg==
