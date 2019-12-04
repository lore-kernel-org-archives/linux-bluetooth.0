Return-Path: <SRS0=DiUs=Z2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2CAC43603
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Dec 2019 18:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634D82073B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Dec 2019 18:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="j3Xt8oN0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbfLDSBV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:01:21 -0500
Received: from mga12.intel.com ([192.55.52.136]:4735 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729165AbfLDSBT (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Dec 2019 13:01:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 10:01:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,278,1571727600"; 
   d="scan'208";a="205474824"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by orsmga008.jf.intel.com with ESMTP; 04 Dec 2019 10:01:17 -0800
Received: from orsmsx163.amr.corp.intel.com (10.22.240.88) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 4 Dec 2019 10:01:17 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX163.amr.corp.intel.com (10.22.240.88) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 4 Dec 2019 10:01:17 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 4 Dec 2019 10:01:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MiobIn/d1bnMzWHfye7+A7gJ1cYlW/EkCxMLBSI8gfp03lPTOmbjuDtLMgxBOURfdvaPF7VVCYCvRnU7jAkgQLUn30E/Sf3EMCx2pmFuILjVh8B0zgou5iYXmTNTW9BaKkBU7xsveISVfT+rlsjMZEGP//PrgUSqVwjO93+hKlYc9UQJEpX7IKgmhaNC9fCP3z44aQ0Mld+Qf3w1V4S0mso9CmJSwPyZMpfh3wI/REL8X3teClcqzHV8CoU+R1VmoK4V/nO6qKeWoCLzShj85uWAegbZYT+rL49jxdaonrtb5qggP6ANFKCG0zLH3AMIdPitwi/FcVPQw2yrZuwb9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JeFx2r1062oKmFKzB8rXjUm6ry8Ksw3js1IMfF59veM=;
 b=NJiQvykWI1wMqnZqSWkAyxllayWR4nQUbWvFyX0c22cnTRZgCO9Wnv2gQ+GDOBXJhfxcNIlaYdj2z7y8dc8nLT1caksPX19L5WdeoLaEsTGWD3IpNPZ21ma3tKjixyRbOFa27Cb0CV0DL7uiizc/w44wd1WLpAvW70we9DO583p/rNBd7+d/UtnUMqBqgg+6ESwAp6e2U93ONjipeu5bMR0Hox29j26jgopKBG/gvXu3OmDMY8HXgz2FxoJGfuRM02P2AvQu9zFQ3s3/SqUf2iqjVA1WhPP3QTUtbavtd7V+trEbyBoqpyvPNoAg3sGIZ7xZTjWfZNsNT/ZIsPcQgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JeFx2r1062oKmFKzB8rXjUm6ry8Ksw3js1IMfF59veM=;
 b=j3Xt8oN0s3NohvTqO9q0f4pRQt6oLVnoR2KM/J5q+B/U3oorzOenJAswTA4fQIJ8IukAjgHZenFtbYTSR3PuotZApCBP8hiv8I+wQCnR5Htek2rcCdD5HioWgIUCfZ0oCoOAHq/igRQcPFRgu8W6OvGNqtHlT3yEE0dXOXZZ+ho=
Received: from CY4PR11MB1269.namprd11.prod.outlook.com (10.173.16.11) by
 CY4PR11MB1414.namprd11.prod.outlook.com (10.169.251.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Wed, 4 Dec 2019 18:01:13 +0000
Received: from CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::a12f:7254:eec:b905]) by CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::a12f:7254:eec:b905%3]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 18:01:12 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "prathyusha.n@samsung.com" <prathyusha.n@samsung.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v2 0/3] mesh: Fix various valgrind identified
 problems
Thread-Topic: [PATCH BlueZ v2 0/3] mesh: Fix various valgrind identified
 problems
Thread-Index: AQHVqh2j5kauI2xYCEu6e2WcuJzv5KeqRWIA
Date:   Wed, 4 Dec 2019 18:01:12 +0000
Message-ID: <814789dacd5a5e71712634e835317ffe923f5a7d.camel@intel.com>
References: <20191203210410.25548-1-brian.gix@intel.com>
In-Reply-To: <20191203210410.25548-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1cfd9976-1254-46c2-6d27-08d778e3f311
x-ms-traffictypediagnostic: CY4PR11MB1414:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB141473B77EB9374C703A9298E15D0@CY4PR11MB1414.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(376002)(346002)(366004)(199004)(189003)(6916009)(5640700003)(229853002)(2501003)(36756003)(86362001)(305945005)(64756008)(66446008)(11346002)(66556008)(66476007)(99286004)(14454004)(14444005)(478600001)(71200400001)(6512007)(26005)(76116006)(54906003)(4744005)(71190400001)(25786009)(76176011)(5660300002)(8936002)(91956017)(4326008)(316002)(66946007)(6436002)(2906002)(186003)(118296001)(81166006)(6116002)(6506007)(7736002)(2351001)(81156014)(102836004)(3846002)(107886003)(8676002)(6246003)(6486002)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR11MB1414;H:CY4PR11MB1269.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ymTpCckKvLmOaBL2pL1P3fK/1anXmXiAMZh/sladWHF6NPw0P+KtZbC3SinpG0H3TVViBCtN71qJcEMKrEjLoHzG+4ZMUQ0vKqMvgLS6oYKb/DoIvW6y2Y6dLKoZqMO5NoyPAYwh8gTPyUad1m5+hCFnwG9vkxT1lRAW1lq8qkdLTcjMsu/F3MtXEOCY97pA0PxZPQDge22XWFxmULXfaaGR6Y2wEGMkok/qGl88h7d7v+mKwKMcNSIxaBK8lawjQGkikA1lPn25oqb768yK1P2RYFSTVlgfOX/oa+0gIzoS4n8GVN7syUx9/PorjeSsNokgpMeeAikfP7Ris4jxXghWQ+vDPPpRCDEm+w1f1OvCuK/pgpz74t3w6LE8FZ+r0GnIzc80OweRvebSG9FinFOOdyCB91GC9VO3+MIcr0tSqXO11ahG/JH0Ey9xy1ZG
Content-Type: text/plain; charset="utf-8"
Content-ID: <3AA592775538B64CA3F7CA175B734011@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cfd9976-1254-46c2-6d27-08d778e3f311
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 18:01:12.5680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rGoFKpO+/hm1DMXxCIZkUoKDs+gArF9nfBDJdlei2apw8VdzE2oMSqVkkK57k/UuWFKg7r3NYMbO84qDB+GP0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1414
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2hzZXQgQXBwbGllZA0KDQpPbiBUdWUsIDIwMTktMTItMDMgYXQgMTM6MDQgLTA4MDAsIEJy
aWFuIEdpeCB3cm90ZToNCj4gVGhpcyBwYXRjaHNldCBhZGRyZXNzZXMgYSBmZXcgdmFsZ3JpbmQg
aWRlbnRpZmllZCBlcnJvcnMsIGluY2x1ZGluZyBzb21lDQo+IGluc3RhbmNlcyB3aGVyZSBtZW1v
cnkgd2FzIHVzZWQgYWZ0ZXIgZnJlZWluZy4gIEFsbCB0aHJlZSBwYXRjaGVzIHJlbGF0ZQ0KPiB0
byB0aGUgbWVtb3J5IGFsbG9jYXRlZCBmb3IgUHJvdmlzaW9uaW5nIHB1cnBvc2VzLg0KPiANCj4g
VGhpcyBpbmNsdWRlcyB0aGUgcGF0Y2ggZnJvbSBQcmF0aHl1c2hhIHRoYXQgZml4ZXMgY2xvc2Ug
aW5kaWNhdGlvbi4NCj4gDQo+IEJyaWFuIEdpeCAoMik6DQo+ICAgbWVzaDogUmVhcnJhbmdlIFBC
LUFDSyBmb3IgcG9zc2libGUgc2Vzc2lvbiBjbG9zZQ0KPiAgIG1lc2g6IEZpeCBtZW1vcnkgbGVh
ayBpbiBKb2luKCkgQVBJIGNhbGwNCj4gDQo+IFByYXRoeXVzaGEgTiAoMSk6DQo+ICAgbWVzaDog
Rml4IHRvIHNlbmQgY2xvc2UgaW5kaWNhdGlvbiBvbiB0aW1lb3V0DQo+IA0KPiAgbWVzaC9tZXNo
LmMgICAgICAgICAgfCAgNyArKysrKy0tDQo+ICBtZXNoL25ldC5jICAgICAgICAgICB8ICAxIC0N
Cj4gIG1lc2gvcGItYWR2LmMgICAgICAgIHwgMTAgKysrKy0tLS0tLQ0KPiAgbWVzaC9wcm92LWFj
Y2VwdG9yLmMgfCAgMSArDQo+ICA0IGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDkg
ZGVsZXRpb25zKC0pDQo+IA0K
