Return-Path: <SRS0=kdk/=ZN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF3FC432C0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Nov 2019 21:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BDD52067D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Nov 2019 21:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="pcYHqTUe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfKUVOW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Nov 2019 16:14:22 -0500
Received: from mga12.intel.com ([192.55.52.136]:2909 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfKUVOW (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Nov 2019 16:14:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2019 13:14:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,227,1571727600"; 
   d="scan'208";a="210222921"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by orsmga006.jf.intel.com with ESMTP; 21 Nov 2019 13:14:21 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 21 Nov 2019 13:14:21 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.51) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 21 Nov 2019 13:14:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njZFxZg8qjYphsxXG9fFPq7e/IQKY1SxJwhZof35u3bO5Z6hxXYMOD8NbqbvkZr5F6i+QWN4/soR2e4LSAcVvL3mqzkSfaLXNesml44T68sGwLDrFpOg/t88tPNunic7E+3WNBatd88tRy5cJE+h6hxO73juG6WY9YVZw9LYJByazp1izEDbZL1cG9AtU5lJs1HzapTVEWIIa4xTEeRCY/dt1BQJ6yVwcAm7W34sKtlntVoEqvqj7zq2xfNtb+Ydpk4PmZoA26Ua5upReBIT+DIq8umbyeLiym6f8i90sdzMuY24QnoXuFvb3NuD21CVYuDXY4rH0DEC2LsUqUpG7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQrN6jEEIUy5pOEw+ghJElcptBny1Whe2WEwKII+S4Y=;
 b=Ekw5JqW/ouUxg1/d8LaWFZPL+eAAQNA7aL+OrRo9Zqp0CuYPgahdOQWmItYMdQY0TiykRlJO/nBhSujNYStV5zMViLGNAexFkG2RtbUlbU4ajKHhkK8PclDiPJwUwEvHzZ255AR7OI205Qt7eJVzkh75VBQcFrfEoegWPqDY5bsvKS7vA7lABK9E3AT5NakgWh+BovTLQleP89icuEZdFeuaJMVXe06M+BOOzJWHrcKf5BAF3H1NboBFHZ8kyWMG0aN3t3MNErXpqvtVpcqWY55WF7fUUOr/xL8Dl+kvTAVMQ7Vs/QfCALv1t2eOaurvVF9wJNPrSyWEjngqS8YcuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQrN6jEEIUy5pOEw+ghJElcptBny1Whe2WEwKII+S4Y=;
 b=pcYHqTUee/d3dbHrTCazLK+HQSN1cn5e+ozwIryRAPrtzO0QNGyuWkMuMgbjwHCiE3Y10NmTblRgYMXv/JiBkXcQkqMFkwHcAiL8Q5aLWg8sjJRVZvJLt8jOzJ/DuuW9Ihz2CXUrJYtYWifVYgQ7WpYHVm2sQ+2ClQsM6f45VmU=
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com (10.172.76.7) by
 CY4PR1101MB2184.namprd11.prod.outlook.com (10.174.54.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.28; Thu, 21 Nov 2019 21:14:19 +0000
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::44:eac4:f8c8:ad06]) by CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::44:eac4:f8c8:ad06%11]) with mapi id 15.20.2451.031; Thu, 21 Nov 2019
 21:14:18 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ 0/2] Include destination address in MessageReceived
 API
Thread-Topic: [PATCH BlueZ 0/2] Include destination address in MessageReceived
 API
Thread-Index: AQHVnibLcvuir4OpSkScxr1NbOV+EaeVTF+AgADYlYA=
Date:   Thu, 21 Nov 2019 21:14:18 +0000
Message-ID: <41658354b81f6ff078b62f32aa1e21847286f5d2.camel@intel.com>
References: <20191118154147.3589-1-michal.lowas-rzechonek@silvair.com>
         <20191121081905.zb4m5gqj5kywjl3v@mlowasrzechonek2133>
In-Reply-To: <20191121081905.zb4m5gqj5kywjl3v@mlowasrzechonek2133>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 425f8611-778d-449a-2c71-08d76ec7c59f
x-ms-traffictypediagnostic: CY4PR1101MB2184:
x-ms-exchange-purlcount: 1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1101MB21841155EE7981B61884F0A3E14E0@CY4PR1101MB2184.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(396003)(346002)(376002)(136003)(366004)(199004)(189003)(81156014)(3846002)(8676002)(6116002)(25786009)(446003)(11346002)(2616005)(4001150100001)(6246003)(5660300002)(107886003)(2906002)(81166006)(8936002)(71190400001)(71200400001)(14454004)(256004)(15650500001)(91956017)(2501003)(76116006)(508600001)(66946007)(66476007)(26005)(6486002)(66446008)(7736002)(6436002)(6512007)(6306002)(99286004)(305945005)(118296001)(4744005)(110136005)(966005)(86362001)(76176011)(66066001)(316002)(4326008)(6506007)(186003)(229853002)(102836004)(36756003)(66556008)(64756008)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1101MB2184;H:CY4PR1101MB2262.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xWyf0aaHSqEpxWSzS+rao9tUVljaaY2lKOwnQUrldL5duWTE6JDe3d5zMe/MEazzt6IcniobwgX/iFGfEVRQzouW/gg0198ANFIfV0uaN5i1T2btOnuovjWe0gg1UsTztED21LZFqZp9Wf9J3dWHYJveJ75tcoFmWDRcdp6hTFjIrOYfUtIDfUkWuU5ZYC+MCugMCjFwMRbBfUBcg2h/4Rrby42QVl+yY1KVtn1BFP2zWUF5Xsi2QeBKVCu2iw8yBbKxk2ODl1sNAcCekAu7Nwgwyo7gSd7iPF29d103Sxt5LX1zk3feK+JMFTWuB/BqbLxMAtMOzCKFgQltkMOOn+ajzGPF7ojEofDy2GtLWGrfNmYeD+Pc3kJXhHYu29cyJY4gnmYt7pGpPqgktSwom0p029cnBw43SQL4iPjzMj7XElCAOFv4OHjKw/ATy1VSAm27SjJdPpufa886f8E2hHydVCwLgUjHorI+qTFlWzk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8FD1DD72A053E4A9911EDDF185AA117@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 425f8611-778d-449a-2c71-08d76ec7c59f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 21:14:18.7395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2rlrXKHWFzHZ6XdxKk8IIcL9/ITrNWPygHjSKZyYvdEZ7E8LszKIN2+9Qe50GPwyhztDYMg+9J9cL7q2W2lQew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2184
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGHFgiwNCg0KT24gVGh1LCAyMDE5LTExLTIxIGF0IDA5OjE5ICswMTAwLCBNaWNoYcWC
IExvd2FzLVJ6ZWNob25layB3cm90ZToNCj4gSGkgQnJpYW4NCj4gDQo+IE9uIDExLzE4LCBNaWNo
YcWCIExvd2FzLVJ6ZWNob25layB3cm90ZToNCj4gPiBUaGlzIHBhdGNoc2V0IGNoYW5nZXMgdGhl
IE1lc3NhZ2VSZWNlaXZlZCBBUEksIHJlcGxhY2luZyAnc3Vic2NyaXB0aW9uJw0KPiA+IGZsYWcg
d2l0aCBkZXN0aW5hdGlvbiBhZGRyZXNzIG9mIHJlY2VpdmVkIG1lc3NhZ2VzLg0KPiA+IA0KPiA+
IFRoZSBhcHBsaWNhdGlvbiByZWNlaXZlcyBkZXN0aW5hdGlvbiBhZGRyZXNzIGFzIGEgRC1CdXMg
dmFyaWFudCwNCj4gPiBjb250YWluaW5nIGVpdGhlciBhcyBhIHJlZ3VsYXIgMTZiaXQgYWRkcmVz
cyAodW5pY2FzdC9ncm91cCkgb3IgYQ0KPiA+IDE2LW9jdGV0IHZpcnR1YWwgbGFiZWwuDQo+ID4g
DQo+ID4gU2VlIHByZXZpb3VzIGRpc2N1c3Npb24gaHR0cHM6Ly9tYXJjLmluZm8vP3Q9MTU2NzE5
MDY3MzAwMDAxJnI9MSZ3PTIgZm9yDQo+ID4gcmF0aW9uYWxlLg0KPiANCj4gQW55IGNvbW1lbnRz
IGFib3V0IHRoZSBwYXRjaHNldD8gSWYgdGhlIGNoYW5nZSBpdHNlbGYgbG9va3MgT0ssIEknbQ0K
PiBoYXBweSB0byBpbXByb3ZlIHRoZSBwYXRjaCBpZiBuZWVkZWQuDQoNCg0KSSB0aGluayB3ZSB3
b3VsZCBsaWtlIHRoZSBmb2xsb3dpbmc6DQoNCjEuIE1ha2UgQVBJIGNoYW5nZXMgdG8gTWVzc2Fn
ZVJlY2VpdmVkKCkgaW4gdGVzdC90ZXN0LWpvaW4NCjIuIEFkZCBwcmludGluZyBvdXQgU3Vic2Ny
aXB0aW9ucyBwcm9wZXJ0eSB0byBib3RoIHRlc3QtbWVzaCBhbmQgdGVzdC1qb2luDQoNClRoZW4s
IEFzc3VtaW5nIEluZ2EgaGFzIG5vIG90aGVyIGNvbW1lbnRzLCBJIHRoaW5rIHRoaXMgcGF0Y2gt
c2V0IGlzIHJlYWR5IGZvciBhcHBsaWNhdGlvbi4NCg==
