Return-Path: <SRS0=0CDr=3F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999DDC33CAF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jan 2020 20:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58BBA206D9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jan 2020 20:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="AkPV7gt7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388192AbgAPUvb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jan 2020 15:51:31 -0500
Received: from mga04.intel.com ([192.55.52.120]:10703 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbgAPUva (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jan 2020 15:51:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2020 12:51:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,327,1574150400"; 
   d="scan'208";a="248967597"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by fmsmga004.fm.intel.com with ESMTP; 16 Jan 2020 12:51:30 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Jan 2020 12:51:29 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 16 Jan 2020 12:51:29 -0800
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 16 Jan 2020 12:51:29 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Jan 2020 12:51:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPXDNz11MLfHVvSZrTlJLUCQuDk8JcMNSfGokKQV3UmOPYko3CoQi057fN7ewbCmPYaP72IkmKZ5gMTsSo2MJoA1FrtAu1sHOzAuSxEwimtSYgq8R7o1gAYS8QGESeWosCkse2FTiLDz5mbI17PBV8cnLMcGzmufUloz0cUwHMf2WrPaECE5wVi3KbQp6gAH2XW2+ZUMeuZjxJnUX6XZlYPI+3CRHGomo/phxGO1Oqf/s0Xwg1UYlCet//J0bzUnB99Wyqm73b/WSlg9lKCQtC4tNtQuGabjmwot/aRJCu4bKnMMG3KywTbzSjEO11xTYX+LwOzqu2khW0cpZ+hRwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtBkkQ0Wt02GfKuEgsko7NQgkQ5KRjqF2dVF2npvuoY=;
 b=mo4fqJsoQneRqtPFOKpT4QV/TrnDJMkofGFsGXDc1r4b/I2gkVxK4os/FdaZykEFMxFFQv5D87oO0N34mkvDIocuygj2J6AazQG4xs+jLT2WND8eryAykTbKOm6OT2tUlrWB5Av+ghZbD3l4b2hTIfxqTG0EVQ00ZfwVe305yrOAryiDm6dwZon6hn6BzB+4SBR+gQrjpljjLxm3h8U2F0UBqb5xRWqG9XeIo+zTgl8Tm2ojOkL2atM60elBOkDi+Cpve0BNsl3WEJHQUellVPvAhTBBLGV1so1wUmy0JPbO4S+iYamrz3O8sTRGv5AkpFnnBBE21uGxkuFPB4orkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtBkkQ0Wt02GfKuEgsko7NQgkQ5KRjqF2dVF2npvuoY=;
 b=AkPV7gt7mz0CGknKoa+MtNAq5qaGG/G44aRnGWvESDm0/rtbN4bKA2db20qk2TAlAhmP4NOyWoX/5Duy+lbMSLZo67GwHG9dipcfnhitrBO7n9jBOw8X9f2NJuCoz3CFZRlt5GhSR6KQp/TxbsksmHPoMtK/MXnCXRBi62r8lPQ=
Received: from MWHPR11MB1664.namprd11.prod.outlook.com (10.172.54.13) by
 MWHPR11MB1277.namprd11.prod.outlook.com (10.169.236.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Thu, 16 Jan 2020 20:51:26 +0000
Received: from MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e]) by MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e%6]) with mapi id 15.20.2644.015; Thu, 16 Jan 2020
 20:51:26 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v3 0/1] mesh: Sequence number related fixes
Thread-Topic: [PATCH BlueZ v3 0/1] mesh: Sequence number related fixes
Thread-Index: AQHVzIuTvbE0pqZmLEKtkdPznDXnqqftxFeA
Date:   Thu, 16 Jan 2020 20:51:26 +0000
Message-ID: <5ef2ebd2aeb7cb7ce7924c2f7e9338109c976db9.camel@intel.com>
References: <20200116163908.18041-1-brian.gix@intel.com>
In-Reply-To: <20200116163908.18041-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0fabdfe2-f0e9-4935-7edd-08d79ac5dacb
x-ms-traffictypediagnostic: MWHPR11MB1277:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB12774F4F912B8848240CA883E1360@MWHPR11MB1277.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(366004)(396003)(376002)(136003)(199004)(189003)(66476007)(86362001)(64756008)(66446008)(66556008)(66946007)(2616005)(71200400001)(2906002)(6512007)(76116006)(6486002)(91956017)(478600001)(8676002)(6506007)(81166006)(54906003)(81156014)(107886003)(316002)(4744005)(186003)(36756003)(4326008)(5660300002)(26005)(8936002)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR11MB1277;H:MWHPR11MB1664.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RK2DDOR2CYQKlIkNVuG2kkLc7RQsxDUTOWGyy8nHtSaQXLOB7hFNQbRUz8fgkH4aYQ8Tr5UNq/TQRKHsrIYkIt1o6CeLwnvVnlZJRKbl0nOE9rpm5JJ9Om6U89lKo1hoqDOfA4KjDhgXB9VPKrvQl/B/8flg0jvZv1XO2pv7zjWWZwSE7li3PBDsdpwZp12FIPLPEjGcCOfWDOg/kLim1qdVoc2NruZn3tJZoLGMri0oo9ipcC7Wi9ipofukXhCt5gMXzneZNl+gpclqxa0Dq2tHavRjigLa/Ohon2qRK+DMYP6figrFj2d9jdiIbGE5j6sTGiiiJQG7R1n3RDSDaPLvlW73M/chp6/6Rn1itMQZI4+oWNAxu2AZ9MyJkn8GetlpII7IyIRMxkOMXH2Vh27nKF0Zr1IBTeqETr5trnKaTDIVzMcwQmW1HDsS/Cwc
Content-Type: text/plain; charset="utf-8"
Content-ID: <4FF0BC31BEF3B0428B3AD5BBFCB39EE3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fabdfe2-f0e9-4935-7edd-08d79ac5dacb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 20:51:26.3570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WKcge47lBL/UN4y4zHR0BEy8KwBLqHkq6HENefIoAkD+Wid9YNNUpPAsW/U+VZK/SHU30vkShdDmC4V3YciLvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1277
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gVGh1LCAyMDIwLTAxLTE2IGF0IDA4OjM5IC0wODAwLCBCcmlhbiBHaXggd3Jv
dGU6DQo+IFZlcnNpb24gMyAtDQo+IEFkanVzdGVkIGNvbW1lbnRzIGZvciBjbGFyaXR5LCBhbmQg
YWRqdXN0ZWQgdGhlIGNhY2hlLXdyaXRlIGNvZGUNCj4gdG8gbm90IHJld3JpdGUgdGhlIE5WTSBz
dG9yYWdlIGlmIG5vdGhpbmcgaGFzIGNoYW5nZWQsIHRvIHByZXZlbnQNCj4gTlZNIHRocmFzaGlu
ZyBpZiB3ZSBkbyByZWFjaCB0aGUgb3V0LW9mLXJhbmdlIGJvdW5kYXJ5Lg0KPiANCj4gSSB3b3Vs
ZCBsaWtlIGJvdGggTWljaGFsIGFuZCBKYWt1YidzIGNvbW1lbnRzIG9uIHRoZXNlIGFkanVzdG1l
bnRzLg0KPiANCj4gSmFrdWIgV2l0b3dza2kgKDEpOg0KPiAgIG1lc2g6IFNlcXVlbmNlIG51bWJl
ciByZWxhdGVkIGZpeGVzDQo+IA0KPiAgbWVzaC9jcnlwdG8uYyAgICAgICAgICAgfCAgMyArKysN
Cj4gIG1lc2gvbWVzaC1jb25maWctanNvbi5jIHwgMTYgKysrKysrKysrKysrKystLQ0KPiAgbWVz
aC9uZXQuYyAgICAgICAgICAgICAgfCAgOSArKysrKysrKysNCj4gIDMgZmlsZXMgY2hhbmdlZCwg
MjYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo=
