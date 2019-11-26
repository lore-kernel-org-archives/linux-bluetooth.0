Return-Path: <SRS0=oE9z=ZS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242F5C432C0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Nov 2019 19:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6EC20835
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Nov 2019 19:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="dczrjMns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbfKZTAG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Nov 2019 14:00:06 -0500
Received: from mga05.intel.com ([192.55.52.43]:1170 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbfKZTAG (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Nov 2019 14:00:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 11:00:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,246,1571727600"; 
   d="scan'208";a="206542313"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga008.fm.intel.com with ESMTP; 26 Nov 2019 11:00:05 -0800
Received: from orsmsx122.amr.corp.intel.com (10.22.225.227) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 26 Nov 2019 11:00:05 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX122.amr.corp.intel.com (10.22.225.227) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 26 Nov 2019 11:00:04 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.52) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 26 Nov 2019 11:00:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3tNpOzieXGp+4ulwjYVLshoU/XL24G9RV08ELyQrErhKr3WKPgmEtF7k4SznErYmMIIhEPR63VXHI3Ub3ys+Bou/8tR7s08JdUt3cKZ7y31iP6yfZpKLB+jE+x+x73x1UyMcE6qX8m1CmjGXwIpJK2vL27KuuPoJwHFFualHmXyONF0/wdTMWIk0nIzQ0FryvKSmqyiwuvIF3tZ0aRCkr/Mk9JB9dQcZ4S5zOh2HdZJOsK8vbAvi3moTCVeK6cnQWObLJ7ltTXfxg0TiZPnMXjZTfztEgbSxBYPduLPuAKZSv6YP5CYIfiPE+eq8DOt+PpLVEao/HGJvsij+uHpow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77Dwyl3geWCXC8z5Jel5Y+svOEIKMH56Cddp1nbwU0Y=;
 b=CXmCZzypGFhBAAMalDedJpH/oP5Y2y8zJxe3y8uFcx8msIw5at4172WBF3YouLHvp0Xp5us7SPuv3KbVd2orX+uiRf9k+cIwYOUBU4tjmUwOQrVF0pivd/HA5fp2prHmk3Cx7gHiXB/qk56R51JEbyPTLl+UjlgqDoB0BRG9zNdcSB0v2uj0X+BDpvgDuVEBv3w0dLI5KCWkPzE0yDMUgr7SsX6WfvP3Dr3rE9c4ewnLAY06FYtNqbSoXS264xo1mTIaxpdbMfmX1f0qzelhwG/3FDYTz+IsiVDlIhCQQ7MXFmR5oNfFys6upFNQ7QkCWmF05uyxpPjYKuR5IIuK7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77Dwyl3geWCXC8z5Jel5Y+svOEIKMH56Cddp1nbwU0Y=;
 b=dczrjMnsz2VZsZYnHnpp0E3d9fN8AQ1nMlq9fPaQZxYZOalqqeInUC4usMXjLTrz1piTfCCpnFg1g4RzFf9Xca4tIE2/GLz5mvXSqLpeD1RFwdYQk3GY2WV1srm/oCHMO9jwRvjlfDem0Q4mwjWuNLS731byRedT0IvX6yeTYvQ=
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com (10.172.76.7) by
 CY4PR1101MB2328.namprd11.prod.outlook.com (10.173.191.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Tue, 26 Nov 2019 19:00:03 +0000
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::44:eac4:f8c8:ad06]) by CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::44:eac4:f8c8:ad06%11]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 19:00:03 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ v3 0/3] Include destination address in
 MessageReceived API
Thread-Topic: [PATCH BlueZ v3 0/3] Include destination address in
 MessageReceived API
Thread-Index: AQHVpGmDXQGsTm9NYU2Xaj6Aws/ZP6edzpYA
Date:   Tue, 26 Nov 2019 19:00:03 +0000
Message-ID: <da50a6b34ea9b5b33bb0e48b7b2d7809280d09a4.camel@intel.com>
References: <20191126145401.25129-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20191126145401.25129-1-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d0fae17-346e-416c-1fad-08d772a2d841
x-ms-traffictypediagnostic: CY4PR1101MB2328:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <CY4PR1101MB2328735620C1B645F076EDF9E1450@CY4PR1101MB2328.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0233768B38
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(39860400002)(346002)(376002)(189003)(199004)(6486002)(71190400001)(6512007)(6306002)(6436002)(71200400001)(8676002)(81166006)(81156014)(6116002)(3846002)(26005)(229853002)(8936002)(2906002)(5660300002)(316002)(2616005)(25786009)(11346002)(186003)(6246003)(110136005)(76116006)(66946007)(66556008)(66476007)(64756008)(66446008)(66066001)(478600001)(102836004)(966005)(2501003)(118296001)(446003)(4001150100001)(86362001)(36756003)(76176011)(6506007)(305945005)(15650500001)(7736002)(256004)(14454004)(99286004)(91956017)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1101MB2328;H:CY4PR1101MB2262.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XsU4cd+4uogEEXdSPAUGAkyZ8z8BUNoDc35QIiHtC2x2ty5EmVyf+6Ag3pKj0XtHLL49RC9/h4dXUc8dcm6YmK3VGhDoyg0ZwyaaksWI0hWTKtDV14avkDDPs3//JrPXCQvyAQBoZYxu/lQ4TGCFnBLfOpfVC6hQiBBcrwXxQKBtO1PEbsnx1EWjm2e+FYNqPhdvbRHva66PPmgmHIjnx254FSYcjHhpJcNLXj7UJJUxq4DED4zz5sCa/xTGopOHCeRgzDDMkE5yzMjntnCDRc+X3kUd98RwT+a+lG9a7ywMkv1h9InDrv0qDXRZ8hPFVMKeEoRTqlynCDB7MUW6w1TJOZ4wS0yorgNWOJfSNue3aT7EINkTg7RiDyYg8fi+K6SEBP0RXWnKU0Ec7iT4H/Q9kzFi6Af1YgAMRXXEaAfa3/1owMljYIF756ON11AE4XQ8JS10Lu8aejmFFH0myeHYHLVDiYitsWWIYhlFGhA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <90B2D0A173ECAD448A179832F202BD6D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0fae17-346e-416c-1fad-08d772a2d841
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2019 19:00:03.2330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2398F5dNiwIT1khCeQbZCCvJWeA71s75hgXTVXrjGlHvSJdjZDz8nI2+aChrSK+FCiTVkha5Dn1Skxj9+U8yrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2328
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2hzZXQgYXBwbGllZCwgVGhhbmtzDQoNCk9uIFR1ZSwgMjAxOS0xMS0yNiBhdCAxNTo1MyAr
MDEwMCwgTWljaGHFgiBMb3dhcy1SemVjaG9uZWsgd3JvdGU6DQo+IFRoaXMgcGF0Y2hzZXQgY2hh
bmdlcyB0aGUgTWVzc2FnZVJlY2VpdmVkIEFQSSwgcmVwbGFjaW5nICdzdWJzY3JpcHRpb24nDQo+
IGZsYWcgd2l0aCBkZXN0aW5hdGlvbiBhZGRyZXNzIG9mIHJlY2VpdmVkIG1lc3NhZ2VzLg0KPiAN
Cj4gVGhlIGFwcGxpY2F0aW9uIHJlY2VpdmVzIGRlc3RpbmF0aW9uIGFkZHJlc3MgYXMgYSBELUJ1
cyB2YXJpYW50LA0KPiBjb250YWluaW5nIGVpdGhlciBhcyBhIHJlZ3VsYXIgMTZiaXQgYWRkcmVz
cyAodW5pY2FzdC9ncm91cCkgb3IgYQ0KPiAxNi1vY3RldCB2aXJ0dWFsIGxhYmVsLg0KPiANCj4g
U2VlIHByZXZpb3VzIGRpc2N1c3Npb24gaHR0cHM6Ly9tYXJjLmluZm8vP3Q9MTU2NzE5MDY3MzAw
MDAxJnI9MSZ3PTIgZm9yDQo+IHJhdGlvbmFsZS4NCj4gDQo+IHYyOg0KPiAgLSBmaXggQVBJIGlu
IHRlc3Qtam9pbg0KPiAgLSBkaXNwbGF5IG1vZGVsIHN1YnNjcmlwdGlvbnMgaW4gdGVzdC1qb2lu
IGFuZCB0ZXN0LW1lc2gNCj4gDQo+IHYzOg0KPiAgLSBzdHlsZSBmaXhlcw0KPiAgLSB3aGVuIGFk
ZGluZyBzdWJzY3JpcHRpb25zLCBjYWxsIFVwZGF0ZU1vZGVsQ29uZmlndXJhdGlvbiBhZnRlciBz
dWJzDQo+ICAgIGFyZSB1cGRhdGVkLCBub3QgYmVmb3JlDQo+IA0KPiBNaWNoYcWCIExvd2FzLVJ6
ZWNob25layAoMyk6DQo+ICAgbWVzaDogRml4IHRlc3Qtam9pbiB0byBpbmNsdWRlIG1hbmRhdG9y
eSBWZW5kb3JNb2RlbHMgcHJvcGVydHkNCj4gICBtZXNoOiBQcm92aWRlIGRlc3RpbmF0aW9uIGFk
ZHJlc3MgaW4gTWVzc2FnZVJlY2VpdmVkIEFQSQ0KPiAgIG1lc2g6IEluZm9ybSBhcHBsaWNhdGlv
biBhYm91dCBtb2RlbCBzdWJzY3JpcHRpb25zDQo+IA0KPiAgZG9jL21lc2gtYXBpLnR4dCB8ICAz
MiArKysrKysrKysrKy0tLQ0KPiAgbWVzaC9tb2RlbC5jICAgICB8IDExMyArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLQ0KPiAgdGVzdC90ZXN0LWpvaW4gICB8
ICAzNyArKysrKysrKysrKysrLS0tDQo+ICB0ZXN0L3Rlc3QtbWVzaCAgIHwgIDMzICsrKysrKyst
LS0tLS0tDQo+ICA0IGZpbGVzIGNoYW5nZWQsIDE4NCBpbnNlcnRpb25zKCspLCAzMSBkZWxldGlv
bnMoLSkNCj4gDQo=
