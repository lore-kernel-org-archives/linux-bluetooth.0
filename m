Return-Path: <SRS0=p+wm=66=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436B3C433DF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 16 May 2020 15:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E14320767
	for <linux-bluetooth@archiver.kernel.org>; Sat, 16 May 2020 15:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="jwVWa1r5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgEPP4d (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 16 May 2020 11:56:33 -0400
Received: from mga17.intel.com ([192.55.52.151]:31719 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbgEPP4d (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 16 May 2020 11:56:33 -0400
IronPort-SDR: xwV8dCUYN7Nqqd3yIvwGQpdfltrthWr7D2sOXhsiuDlMXBOEWYNOY51ecTSe5e6OnwXo54v6Nv
 UCz0dN0V8+bA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2020 08:56:32 -0700
IronPort-SDR: JR5WqDhjgvEDzEuBpSguz71SCJL/wa3Bh3oP8yNcsCLsXd0zOl3aOr2LFyOsunQKtEECYE9azZ
 pt8N9HPMKwYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,398,1583222400"; 
   d="scan'208";a="299346739"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by orsmga008.jf.intel.com with ESMTP; 16 May 2020 08:56:32 -0700
Received: from orsmsx113.amr.corp.intel.com (10.22.240.9) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 16 May 2020 08:56:32 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX113.amr.corp.intel.com (10.22.240.9) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 16 May 2020 08:56:32 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 16 May 2020 08:56:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4jtmD7Im9+8BBJ3VZaGPZmYbWn9jIDTJJafjkA7ePwq0MbrW/kD26fQe7lJvrFx6YTxhH4I0N2Q129CPF/uFCNASFDbgIdg2V0im0TU/B/hQlltuAYENybJVyhSBE4ndiNQxBP8y8NTThLkzZA+37rcBvy2wwKJUTLqkR2+vHpqBhDcRCF579B6Tn5SJ/XeKLIOliWsOFO+UCu5exWBOuvshOiuoMVcq1R6XbZZ4HQmojjlskh1OuSanz8T/d0jeKu7BRxLe4GMskbrLyQARnB8zDnMleu4EEjQ94Ujr6a4e0zSTQ2eu9Ukt2GmhkZxp0YzWJgR43wNCti86lLKeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RhyNDkxcXp5OvasFIFt38wRE55H1iqIxOeOa9Llhmk=;
 b=Ffvj+4qduydp+1CQmVk8EktEvvWS4FzNx9GNMIePBgfJTE1Kb5TheOwihyAX7hz1zVaibCyes9X+uz3NNMI88GSGSyPCw5ieDoiXe6eE3qgm2r/0EvzFeICH/wU4VpwPlMDSk8ig5YDZZGBEQdWkbTWdpK/F9xuzWI4AcNOb1aYUB4UE+UcDvii1dthxJr7ixnJV+huxb0ak1ignonhZpdVK0QZcwXRo/PGuVuR9g51ijW6VEdy6k0ef0hS1IoE0VKmrIefdAWVktCiSg+RMSx1tBsW3cSLlOJ3alwTxQN+cqUAbg3BBBPMH4gMoo8uGbv/1qEw3eQfsvmaTFWYCmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RhyNDkxcXp5OvasFIFt38wRE55H1iqIxOeOa9Llhmk=;
 b=jwVWa1r5CsRg1XTpIfGHv6V7wLGWnqEUeLwXE13d2Au/JDdGbyvxJTN9VZ7123oMioTyQfhL+geU/H+ChxM4yuUq7iwyBXvfbt62rcVYXb3ErZ3LAfzjsr22Ibzqppx3JRqJNWdfVAS5x40L6xJBVmAKC8XqoKcEiAcbdATHbLE=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4619.namprd11.prod.outlook.com (2603:10b6:303:5b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Sat, 16 May
 2020 15:56:28 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0%5]) with mapi id 15.20.3000.022; Sat, 16 May 2020
 15:56:28 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v2 0/2] mesh: Valgrind Clean-up
Thread-Topic: [PATCH BlueZ v2 0/2] mesh: Valgrind Clean-up
Thread-Index: AQHWKyFCFr+qYeQrEE+AvkjNILf6VKiq3tqA
Date:   Sat, 16 May 2020 15:56:28 +0000
Message-ID: <220533947be7b56c12013ac726b14a0370418575.camel@intel.com>
References: <20200516012742.573151-1-brian.gix@intel.com>
In-Reply-To: <20200516012742.573151-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b87efeb-7ff2-4ad2-7608-08d7f9b1b1d4
x-ms-traffictypediagnostic: MW3PR11MB4619:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB46193C87521F9D44A1066380E1BA0@MW3PR11MB4619.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 040513D301
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x1QL3xGsSpyEg6oDBafN8oUXB8GVbcAeV/ZL/nyPrprzWOjoSsuftMNyYPLgT5L1bkLMPC6orUywXvH7JqMLPyb/9TWhmHEHVUVE2N3LgTauyvpTxEjMfSHjHlXVxU7CLI+loEk1Pzv1gMyj2KPEbofvzNcVqGl7zh3Y/3CGaYTStPcBSipkRj7yPvhFZAPoExQETJf5buhsN9ess5iWPi0R35l+UvcxoBe1iIIDHicYe0jObhqE7cZn2d5iP4Zv62/JCEgq1vi05ZAh6Nk3kn1AnwC7QReADayhO1pgyINPFR2/XOEdxN1ePpzlZ+pF4fKQQIk0+OIq6/acMrlaHvyu3ayRpW0ZPcBmnIJuNbKdsFAu8r4ZQSuxU4DupjdrpMzHHIEtqOcmaSYd0SkqD0SPgTKAEpD/Q6aEgXQQXjOIMU4DD7y6TiAhnpMqY3y5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(366004)(136003)(39860400002)(396003)(8676002)(5660300002)(107886003)(86362001)(66946007)(36756003)(91956017)(71200400001)(4326008)(76116006)(316002)(6486002)(2906002)(4744005)(2616005)(6512007)(478600001)(6506007)(186003)(6916009)(64756008)(66446008)(66556008)(26005)(66476007)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: YcD/qcQvR5tzbI+mF2NDNTIHP/KBwkeZff/blO6pm2H1e6bXxoJQc6yfkcR+zMiNMPjNRT43OtY9H0LUGUazMkgHRtDvcXhi2VWUPJQyH1m0sSGp+xAAQaYUINqETmBWumgCKjxfSWhnREF9TRtGsdpBjnpwRFjU4z5xVmKIZDlk/7pNbD0/kyjMvxWyieivW9DN+btBSYjv77WgqBUCRcvPv3k5M+hkdp9R0f5pprvQ1PZqIySXR1VLTiF3s00RIk9CxeSpp0Yg+AiGBoMuB3L3bcMh3y39x8wjY7e4dK5xtxRm+qIqY0ZSdukLaTQywOuXtHDjV6BnfTCbw0zyYrNTgkUMOjlhh5/RitWZQ/Dz9QSludORFxdSxViEIW8G+EHGELZgenoEaa2WX46SW/etZxsYDLiK9cvDSqlQwne6QVAvT+J7RJ+iVSZ4J9R40CUdhk4cmBO1gR352/LWnp0pvoj0xfNJc8g1w31Z2xc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F7DE865DA294D44B98AFA3EDF6F002B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b87efeb-7ff2-4ad2-7608-08d7f9b1b1d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2020 15:56:28.3586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9sCKbqGLzYMkdxyvMigZFMoic5YG/eKFKYv4hWJ3YSm9OZpvGYmY2Ce7/gfYyH2k3DJUUdS6Nw6H3MXM1+uoXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4619
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2hzZXQgQXBwbGllZA0KT24gRnJpLCAyMDIwLTA1LTE1IGF0IDE4OjI3IC0wNzAwLCBCcmlh
biBHaXggd3JvdGU6DQo+IFRoZXNlIHR3byBwYXRjaGVzIGFkZHJlc3MgYWxsIGtub3duIG91dHN0
YW5kaW5nIHZhbGdyaW5kIGlzc3VlcyB3aXRoIHRoZQ0KPiBtZXNoIGRhZW1vbi4gIFRoZSBmaXJz
dCBwYXRjaCAoMS8yKSBmaXhlcyBhY3R1YWwgbWVtb3J5IGxlYWtzIHRoYXQgd2lsbA0KPiBjb21w
b3VuZCBvdmVyIHRpbWUuIFRoZSBzZWNvbmQgcGF0Y2ggKDIvMikgZml4ZXMgbGVzcyBjcml0aWNh
bCB3YXJuaW5ncw0KPiB0aGF0IHNvbWUgbWVtb3J5IHdhc24ndCBlbnRpcmVseSBmcmVlZCBiZWZv
cmUgZXhpdGluZy4NCj4gDQo+IHYyOiBGaXhlZCBjaGVja3BhdGNoIGVycm9ycw0KPiANCj4gQnJp
YW4gR2l4ICgyKToNCj4gICBtZXNoOiBGaXggdmFsZ3JpbmQgbWVtb3J5IGxlYWtzDQo+ICAgbWVz
aDogRml4IHZhbGdyaW5kIG1lbW9yeSBsZWFrIHdhcm5pbmdzDQo+IA0KPiAgbWVzaC9hZ2VudC5j
ICAgICAgICAgICAgfCAgMSArDQo+ICBtZXNoL21lc2gtY29uZmlnLWpzb24uYyB8IDE2ICsrKysr
KysrLS0tLS0tLS0NCj4gIG1lc2gvbWVzaC5jICAgICAgICAgICAgIHwgIDkgKysrKysrKystDQo+
ICBtZXNoL25ldC1rZXlzLmMgICAgICAgICB8ICA2ICsrKysrKw0KPiAgbWVzaC9uZXQta2V5cy5o
ICAgICAgICAgfCAgMSArDQo+ICBtZXNoL25ldC5jICAgICAgICAgICAgICB8IDEyICsrKysrKysr
KysrLQ0KPiAgbWVzaC9uZXQuaCAgICAgICAgICAgICAgfCAgMyArKy0NCj4gIG1lc2gvbm9kZS5j
ICAgICAgICAgICAgIHwgIDEgKw0KPiAgOCBmaWxlcyBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCsp
LCAxMSBkZWxldGlvbnMoLSkNCj4gDQo=
