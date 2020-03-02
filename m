Return-Path: <SRS0=RPtH=4T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9714AC3F2D1
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Mar 2020 17:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F9422173E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Mar 2020 17:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="yAuYMVFa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgCBRPq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Mar 2020 12:15:46 -0500
Received: from mga03.intel.com ([134.134.136.65]:54440 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbgCBRPp (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Mar 2020 12:15:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 09:15:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,507,1574150400"; 
   d="scan'208";a="228528965"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga007.jf.intel.com with ESMTP; 02 Mar 2020 09:15:44 -0800
Received: from FMSMSX109.amr.corp.intel.com (10.18.116.9) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 2 Mar 2020 09:15:43 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx109.amr.corp.intel.com (10.18.116.9) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 2 Mar 2020 09:15:42 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.53) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 2 Mar 2020 09:15:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8iNoYc5pngYoHOgzgnxgCmXiHAzIGdhYIbSaTw9NDdg9TQLDJ/iw1jFsKT4NU93DNd0nwNTWRhu5WtPvnHUtCFugNTj0wTXEfCYsudczt6pgcKypwpTwGoS3GAi7PjyYusL8kDxxLzJW5jIFfB6DLkRSLSGci0g3NW/chtHu6wtkX2sldqpO+6EvSgWIwwStf5Fo6QVc5lARCyRbDFdnf32Lrp4/aqrdsQiQ3VY1os6m8c+t3FJGuSUa3O5SPnD7ULh3MWNq7uwleWiDFd5nCefSttTtLRld9qUPQzYLHDYJXyOLdMbKXM4y+Whz+LVEdy3tula/l7qlqki00ufbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rYpLVvQENqOpKc2mAMjb0R6cGahC3gVshCjXOIP8Qg=;
 b=NxGXO3J//HUw8QCZ1XOHRNN7UzYVxkYl1LZaD5TTM3VKyOYHJa8UaP58/yPttAjZ5hZz8E9XXxXBhzadzP2lTrAY/ahJDJweTCFyOkW604WJjbEBUC79e2RPbN3vqbQwraWvivWNrOtiXM64nz2caSCrsN92xJFiB7r/ANNU/uZBxtdbXUP5i52B45MBMntWBDV1V8qhWPIUSxd9ZFckmnN8zNJUZkvTGUjd972+E0l24wA/oF+o1Cbyv4V2X8ifsLnww5dT1n3DU9qj+STXW5cfM21But67ywx5mYvmX6+ClExx1wzeiPto5m7T3IDksB4avo5nvmbAwEs9fqZ0Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rYpLVvQENqOpKc2mAMjb0R6cGahC3gVshCjXOIP8Qg=;
 b=yAuYMVFag6HoN93bzhO0l1uCUmOxvkyTEouxPS4cPoK91YR3EH1D32igLMjWcTyx6UApd3MgdlSoyAcucGvC8iMt3VyQOeA3W+pCusNc0id9bccEbjr0BuuZTFiE7ZZNperrhBjB6R10uxr8K/vCwGb+7xxrWmQRPe6/yyNoOg4=
Received: from CY4PR11MB1734.namprd11.prod.outlook.com (2603:10b6:903:125::20)
 by CY4PR11MB2038.namprd11.prod.outlook.com (2603:10b6:903:30::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.16; Mon, 2 Mar
 2020 17:15:40 +0000
Received: from CY4PR11MB1734.namprd11.prod.outlook.com
 ([fe80::bcf6:f44f:5482:399]) by CY4PR11MB1734.namprd11.prod.outlook.com
 ([fe80::bcf6:f44f:5482:399%6]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 17:15:40 +0000
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "Gix, Brian" <brian.gix@intel.com>,
        "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "anupam.r@samsung.com" <anupam.r@samsung.com>
CC:     "semun.lee@samsung.com" <semun.lee@samsung.com>,
        "dh79.pyun@samsung.com" <dh79.pyun@samsung.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Re: Regarding OOB authentication method & action for Mesh
 provisioner
Thread-Topic: Re: Regarding OOB authentication method & action for Mesh
 provisioner
Thread-Index: AQHV8JHI+IdENwBuv0iFEygzoC/b5Kg1WuqAgAAJHwCAACHgAIAABVeA
Date:   Mon, 2 Mar 2020 17:15:40 +0000
Message-ID: <f2ea1cd7ff4a84671a53c518e3bdbabc286343cd.camel@intel.com>
References: <20200302142239.re57glm4ixjot7d3@mlowasrzechonek2133>
         <20200302125344epcms5p3e31d97ef6263e0513b94f6306536269b@epcms5p3>
         <CGME20200302125344epcms5p3e31d97ef6263e0513b94f6306536269b@epcms5p7>
         <20200302145518epcms5p7ec2da0403de9efa6733e12290f3cc80d@epcms5p7>
         <7686b0b5ec818946fef72d8eb438460898d53c40.camel@intel.com>
In-Reply-To: <7686b0b5ec818946fef72d8eb438460898d53c40.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=inga.stotland@intel.com; 
x-originating-ip: [134.134.137.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76b0a2f2-dc55-449e-9ae7-08d7becd5585
x-ms-traffictypediagnostic: CY4PR11MB2038:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB2038CC2AE264E10F69C5D75DFBE70@CY4PR11MB2038.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(136003)(376002)(366004)(189003)(199004)(6512007)(5660300002)(26005)(81156014)(71200400001)(2616005)(81166006)(8676002)(66574012)(186003)(66446008)(54906003)(66946007)(66556008)(64756008)(91956017)(76116006)(66476007)(316002)(110136005)(86362001)(6506007)(478600001)(4326008)(6486002)(36756003)(8936002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR11MB2038;H:CY4PR11MB1734.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ToEe/ZVkHyRLL+tZf6Wm7sepOEr/Pr3Mrkvb8D4Z/l9Zf7JjP0GAqCKU+xDbUxeHLno2BXjDvuTqRVpKe/EAELEbudkHZLF0uoSLu5XR9xutTegeXrvtjAW6mXYt0SZh2/HLu8Kn51eHmSLSAXypVA3MiPItWtHlbWsIBI1srBRUH++ccQ/ku69qZbpZLTvqgj1jLBZqXvJGMQaI3gl/3UYycM7wBexzUV+fevOfUdAPBkmJ1p2RxLWzrF98R5yTuWHp353/aU60x6FedFZDwIlWhzLMni3UErxTSnAybi9FLlyiHqORhRStSzcg825AdOHuNIg3hQFte8BbKQkyAw34Mi/HcX87XQw4DiPRdAlPLaOlbyjBuuT5cyXoc3ciHCJfIRPM0H0U+oJj1L8GP9gMWKfCDcWSTWwFSypLy+fbUmPQvExKy8KDl3DaJ9i2
x-ms-exchange-antispam-messagedata: ZIoQVeOUL7cgIB7/518VpNZbpzfxIe5mf+8j6gXIogoQG3ZJM18s09Bh4QPT60tbk3rHhoNbeVkPnqvNUkewAHSxGRAPeboLyVPGdBW6S9TQ/H/RDiUtMgYTMcy8/EgdOfk4v8uk6tqJuX9yTrT07A==
Content-Type: text/plain; charset="utf-8"
Content-ID: <082ACCB4567C3546965AAAFE884257FE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b0a2f2-dc55-449e-9ae7-08d7becd5585
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 17:15:40.6767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yvE8EqTBoCdHb39Wh4dAlAUYF55sNNjNy4f4OeUJsWUyCsdzU/ij9VN6VKT/7qf93NGI61eZ0LRJ/G1h28nEAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB2038
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGksDQoNCk9uIE1vbiwgMjAyMC0wMy0wMiBhdCAxNjo1NiArMDAwMCwgR2l4LCBCcmlhbiB3cm90
ZToNCj4gT24gTW9uLCAyMDIwLTAzLTAyIGF0IDIwOjI1ICswNTMwLCBBbnVwYW0gUm95IHdyb3Rl
Og0KPiA+IEhpIE1pY2hhbCwNCj4gPiAgDQo+ID4gPiAtLS0tLS0tLS0gT3JpZ2luYWwgTWVzc2Fn
ZSAtLS0tLS0tLS0NCj4gPiA+IFNlbmRlciA6IE1pY2hhxYIgTG93YXMtUnplY2hvbmVrIDwNCj4g
PiA+IG1pY2hhbC5sb3dhcy1yemVjaG9uZWtAc2lsdmFpci5jb20NCj4gPiA+ID4NCj4gPiA+IERh
dGUgOiAyMDIwLTAzLTAyIDE5OjUyIChHTVQrNTozMCkNCj4gPiA+IFRpdGxlIDogUmU6IFJlZ2Fy
ZGluZyBPT0IgYXV0aGVudGljYXRpb24gbWV0aG9kICYgYWN0aW9uIGZvciBNZXNoDQo+ID4gPiBw
cm92aXNpb25lcg0KPiA+ID4gDQo+ID4gPiBIaSwNCj4gPiA+IA0KPiA+ID4gT24gMDMvMDIsIEFu
dXBhbSBSb3kgd3JvdGU6DQo+ID4gPiA+IEFsc28sIEkgd291bGQgbGlrZSB0byBrbm93LCB3aGV0
aGVyIHRoZXJlIGlzIGFueSBwbGFuIHRvDQo+ID4gPiA+IFJlcXVlc3QNCj4gPiA+ID4gZXh0ZXJu
YWwgcHJvdmlzaW9uaW5nIEFnZW50IHRvIGNob29zZSBQcm92aXNpb25pbmcgbWV0aG9kICYNCj4g
PiA+ID4gc3BlY2lmaWMNCj4gPiA+ID4gYWN0aW9uPyAgVGhlIHJlYXNvbiBiZWluZywgc29tZSAq
YXBwbGljYXRpb24qIG1heSBiZSBpbnRlcmVzdGVkDQo+ID4gPiA+IGluIGENCj4gPiA+ID4gcGFy
dGljdWxhciBTZWN1cml0eSBsZXZlbCAmIEF1dGhlbnRpY2F0aW9uIGFjdGlvbiwgZGVwZW5kaW5n
IG9uDQo+ID4gPiA+IGl0cw0KPiA+ID4gPiBvd24gSS9PIGNhcGFiaWxpdGllcy4NCj4gPiA+IA0K
PiA+ID4gRm9yIHRoZSByZWNvcmQsIHdlIGFsc28gbmVlZCB0aGlzIGlzIGZ1bmN0aW9uYWxpdHku
IE9uZSBvZiB0aGUNCj4gPiA+IHBvc3NpYmxlDQo+ID4gPiBzY2VuYXJpb3MgaXMgaGF2aW5nIGEg
cHJvdmlzaW9uZXIgd2hvIGRvZXNuJ3QgaGF2ZSBhIHJlbGlhYmxlDQo+ID4gPiBJbnRlcm5ldA0K
PiA+ID4gY29ubmVjdGlvbiBhbmQgbWlnaHQgd2FudCB0byBmYWxsIGJhY2sgdG8gKGxlc3Mgc2Vj
dXJlKSBPT0INCj4gPiA+IGFjdGlvbnMgaWYNCj4gPiA+IGl0IGNhbm5vdCBvYnRhaW4gT09CIHB1
YmxpYyBrZXkuDQo+ID4gPiANCj4gPiA+IFdlJ3ZlIGJlZW4gcGxhbm5pbmcgdG8gc2VuZCBhIHBh
dGNoIGltcGxlbWVudGluZyBhIEQtQnVzIEFQSSBmb3INCj4gPiA+IHRoYXQsDQo+ID4gPiBidXQg
aXQncyBub3QgcmVhZHkgeWV0IDooDQo+ID4gDQo+ID4gT2theSwgdGhhdCB3b3VsZCBiZSBuaWNl
ICYgYW5kIHdpbGwgaXQgYWxsb3cgYXBwbGljYXRpb24gdG8gY2hvb3NlDQo+ID4gYm90aCBhKSAi
T09CIFB1YiBLZXkoV2l0aC9XaXRob3V0KSIgYXMNCj4gPiB3ZWxsIGFzICBiKSJPT0IgQXV0aCBN
ZXRob2RzKElOL09VVC9TdGF0aWMvTm8gT09CKSAmDQo+ID4gQWN0aW9ucyhCbGluay9CZWVwL1Zp
YnJhdGUvTnVtL2FscGhhIGV0Yy4pIj8NCj4gDQo+IFRoZSBvcmlnaW5hbCBwbGFuIGZvciB0aGlz
IHdhcyB0aGF0IGFuIEFnZW50IGRlZmluZXMgaXQncw0KPiBDYXBhYmlsaXRpZXMgZC1idXMgcHJv
cGVydGllcyB0byBpbmRpY2F0ZSB0aGUgT09CDQo+IG1ldGhvZG9sb2dpZXMgaXQgaXMgd2lsbGlu
ZyB0byBzdXBwb3J0ICpmb3IgdGhhdCBzZXNzaW9uKi4gSWYgeW91DQo+ICpzb21ldGltZXMqIHdh
bnQgdG8gc3VwcG9ydCAic3RhdGljLW9vYiIgb3INCj4gInB1YmxpYy1vb2IiIChmb3IgaW5zdGFu
Y2UsIHRvIGRvIGEgQ2VydGlmaWNhdGUgbG9va3VwIHZpYSBhIFdBTikNCj4gdGhlbiBmb3IgdGhh
dCBzZXNzaW9uLCB0aG9zZSBjYXBhYmlsaXRpZXMNCj4gc2hvdWxkIGJlIGluY2x1ZGVkIGluIHRo
ZSBBZ2VudCdzIENhcGFiaWxpdGllcyBhcnJheS4uLiAgIGFuZCBpZiB0aGUNCj4gV0FOIGlzIG9m
ZmxpbmUsIGFuZCBDZXJ0aWZpY2F0ZXMgY2FuJ3QgYmUNCj4gcmV0cmlldmVkLCB0aGVuIGxlYXZl
IHRoYXQgY2FwYWJpbGl0eSBvdXQuDQo+IA0KPiBPdGhlcndpc2UsIHllcy4uLiAgVGhlICppbml0
aWF0b3IqIGRhZW1vbiB0aGVuIGxvb2tzIGF0IHRoZQ0KPiBjYXBhYmlsaXRpZXMgb2YgdGhlIHJl
bW90ZSB1bnByb3Zpc2lvbmVkIGRldmljZSwNCj4gYW5kIHRoZSBjYXBhYmlsaXRpZXMgb2YgdGhl
IGxvY2FsIGFnZW50LCBhbmQgY2hvb3NlcyB0aGUgaGlnaGVzdA0KPiBzZWN1cml0eSBtZXRob2Qg
dGhhdCBjYW4gYmUgc3VwcG9ydGVkIGJldHdlZW4NCj4gdGhlIHR3byBkZXZpY2VzLiAgQnV0IHRo
ZSBsaXN0IG9mIGF2YWlsYWJsZSBtZXRob2RzIGlzIHN0aWxsIHVuZGVyDQo+IHRoZSBjb250cm9s
IG9mIHRoZSBBcHAuDQo+IA0KDQpUaGUgZGFlbW9uIGluZGVlZCBpcyBtaXNzaW5nIHRoZSBkeW5h
bWljIGFjcXVpc2l0aW9uIG9mIHRoZQ0KcHJvdmlzaW9uZXIncyBhZ2VudCBjYXBhYmlsaXRpZXMu
IEkgdGhpbmsgdGhlcmUgaXMgbm8gbmVlZCBmb3IgYSBuZXcgRC0NCkJ1cyBtZXRob2QsIHRoZSBj
dXJyZW50IEFQSSBpcyBzdWZmaWNpZW50LiBXaGF0IGlzIG5lZWRlZCwgaXMgdG8gYWRkDQpjYWxs
IGZvciBHZXRQcm9wZXJ0eSgpIHJlcXVlc3Qgb2YgIkNhcGFiaWxpdGllcyIgb24gdGhlIEFnZW50
IGludGVyZmFjZQ0KKGluIGFnZW50LmMpIHByaW9yIHRvIHNlbmRpbmcgcHJvdmlzaW9uaW5nIGlu
dml0ZSAoaW4gcHJvdi1pbml0aWF0b3IuYywgDQpiZWZvcmUgb3IgaW4gcHJvdl9pbml0X29wZW4o
KSkNCg0KUmVnYXJkcywNCg0KSW5nYQ0KDQoNCg==
