Return-Path: <SRS0=vBm7=XV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC087C4360C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Sep 2019 23:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DA8206B7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Sep 2019 23:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="n9zpJz2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbfIZXsR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Sep 2019 19:48:17 -0400
Received: from mga18.intel.com ([134.134.136.126]:34708 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728925AbfIZXsQ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Sep 2019 19:48:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2019 16:48:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,553,1559545200"; 
   d="scan'208";a="273635351"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga001.jf.intel.com with ESMTP; 26 Sep 2019 16:48:15 -0700
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Sep 2019 16:48:14 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX114.amr.corp.intel.com (10.18.116.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Sep 2019 16:48:14 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.52) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 26 Sep 2019 16:48:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOJp1V3+rmtj9OXS8GutYHIAVU9YvJ15axJggd8BkhiSQyLicSDbArxqP1pz5lrF3C9Y2lcEXpvctxfuRiZzctoNLHAREjtMBI3ErOq6RUjSUsW5nRmBt18jeZHVGcCoNttYNlrpxcpe7h3ZpTQl4M9NX7SgmflMR0q0JnsVTEJvzznXWKsshrMyu5EoHj8nIdn0PAkkLYN+fKq+HcaRPxrZeuzNZ1OuSiTgknIaLahpJ2Mn6vdfxRxj7IChxkk48DZs0zlacsqO+GAlZ7XYWaSWviFphJrrXpGmji0XZ1aEEoNf4zUmbjj6CgFi6FxGWH7ToAgoVOMsRtTL+vkeAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKn/QQIKss9W9Dpi/9CGj1HyoBu6GB0LOnmfVbYjISk=;
 b=Y0yNzfhU3mt/ZgaZPnPPUGH3P1Gv5PYb+4yxmX/bVdnvIJ8tRMme+HAdp6Z3W0Ke3Biv+rwKB2pk1pmLtOak6cVmfkycByo8VFWkbTw2Ml3qFys+UiJxRomWP7ZTSV3U1LfySCK5KK3O6rycPlBiSAdbgDUoHXcJIS3c80+b23Y4dPD06LfuOczMYAFuo1sZGLZ731GS2vMMne1YaFfVohUI9OjX+kXUOYMpWB25LgXPdjmKvMIJ5p5Se9E7cTQGiBWy0xXTeVmsV2SUV/UFBh3LiWQz0SaUTpxCrntP7HqtUsm5ZmAxAlxzn7kNMFNN9LQQ9CDghCjr5KUhIPtZyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKn/QQIKss9W9Dpi/9CGj1HyoBu6GB0LOnmfVbYjISk=;
 b=n9zpJz2TG5HZ6oBWT9svWXjWj6WpTDJ2VZj5BHHaTvnQEoV1dMGbt9ehe9Ji8CLG2TrExO+B8Zo0tbgvalK90Nh4goWWaikYNT5UWGOQIlJv2B6gxU6lffcLOzySrI5A2c8MZHOsbv9sCENjgUPf7dvCCsBePrnevX/pz5xk5WI=
Received: from DM6PR11MB4412.namprd11.prod.outlook.com (52.132.248.86) by
 DM6PR11MB3419.namprd11.prod.outlook.com (20.177.219.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.23; Thu, 26 Sep 2019 23:48:12 +0000
Received: from DM6PR11MB4412.namprd11.prod.outlook.com
 ([fe80::5d45:636:6a4a:9397]) by DM6PR11MB4412.namprd11.prod.outlook.com
 ([fe80::5d45:636:6a4a:9397%7]) with mapi id 15.20.2305.017; Thu, 26 Sep 2019
 23:48:12 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: mesh: org.bluez.mesh.Element.MessageReceived method does not
 provide destination address
Thread-Topic: mesh: org.bluez.mesh.Element.MessageReceived method does not
 provide destination address
Thread-Index: AQHVX2LEF/rrCs91wE6OiENpKqkMj6cxPhOAgAuqqYCAAVPegIAAWhSAgAA0QoA=
Date:   Thu, 26 Sep 2019 23:48:11 +0000
Message-ID: <b7e8c06d747e4625cdeaf59989ba3d8195d430cb.camel@intel.com>
References: <20190830184301.zd3zaqrw7mv6r252@kynes>
         <20190918085239.xhahxoeqjkcrk3bl@mlowasrzechonek2133>
         <3c5858c94b3e08a61c5ff8493f9b00f5f77d0aac.camel@intel.com>
         <4b57242b15ccb44ac123858ce7bdf6e0e526b3e0.camel@intel.com>
         <a0442c7485fef2bfde9bc52283a5c9dfc0b43515.camel@intel.com>
In-Reply-To: <a0442c7485fef2bfde9bc52283a5c9dfc0b43515.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29824b68-8d73-4fd4-9ade-08d742dbfdd9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM6PR11MB3419;
x-ms-traffictypediagnostic: DM6PR11MB3419:
x-ms-exchange-purlcount: 1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3419F914F6D251DF650D99A3E1860@DM6PR11MB3419.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(136003)(346002)(396003)(54094003)(199004)(189003)(66066001)(478600001)(229853002)(5024004)(81156014)(7110500001)(7736002)(81166006)(8676002)(2906002)(2420400007)(15650500001)(6486002)(305945005)(6512007)(36756003)(966005)(5660300002)(8936002)(6246003)(25786009)(99286004)(6436002)(6636002)(66476007)(118296001)(91956017)(76116006)(66946007)(71190400001)(256004)(26005)(71200400001)(76176011)(6306002)(11346002)(476003)(186003)(2616005)(64756008)(14444005)(66556008)(2501003)(6116002)(86362001)(486006)(3846002)(6506007)(14454004)(102836004)(110136005)(66446008)(446003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR11MB3419;H:DM6PR11MB4412.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8jxnft1I1/KTIrpTiZw+rLFOJaxwNZhUtsHdo14Pt6dE2QNlOG3l7yFrEyrxnV73MfhFLjkiCrsvZWqa6556rQPID7Xjmi2WPWDlKeZQtTiKzhVZKD9+NoCr2PBS4UsoGY6YxmrZ1cMEozOICQWDWshwmKTHJs5APyrJO5SLsnrNECVVAgX6gZY48shDlpsFIo5Tr8tegVqBVboNfivRBmU/aT+eQ4mB7bjU3WHwkyLL+kD0J2nO4vDakc2VvtdsvFumxc/PwL9nPGlgdJyGuBRr0n9vF9tIbwr0n2cNA/Se0FGxypOhYtshQ7L32qzJCookrj7l2LCwyBXPo7cXDXQZMvrXOvn+m7yofeuuqu72XnLPIfNmdy7bMuFEr/2+pO7Z0ZAqv+aLL6LullUjLZWJDSdsgmaEC+yLEVr0OhMh+/bz/O25osNeJPQtZtoXATkJ8yuhwV3ZSE5aGVkKUQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EFD3424688DE040B1584C8452772291@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 29824b68-8d73-4fd4-9ade-08d742dbfdd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 23:48:11.9342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YNy+oCN/gc4GetdV1z2cRgMeAaa1YUrmAGItlQZezn2st20dxpVDkq97Z4EIEPIzFz4wyfriCjrUdqQfhi2gVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3419
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgSW5nYSwNCg0KT24gVGh1LCAyMDE5LTA5LTI2IGF0IDIwOjQxICswMDAwLCBTdG90bGFuZCwg
SW5nYSB3cm90ZToNCj4gSGkgQnJpYW4sIE1pY2hhbCwNCj4gDQo+IFBhaXJpbmcgZG93biB0aGUg
Y2MgbGlzdCBzaW5jZSB3ZSBhcmUgZG93biB0byBpbXBsZW1lbnRhdGlvbiBkZXRhaWxzLg0KPiAN
Cj4gT24gVGh1LCAyMDE5LTA5LTI2IGF0IDE1OjE4ICswMDAwLCBHaXgsIEJyaWFuIHdyb3RlOg0K
PiA+IEhpIEluZ2EsIE1pY2hhxYIsDQo+ID4gDQo+ID4gT24gV2VkLCAyMDE5LTA5LTI1IGF0IDE5
OjAyICswMDAwLCBTdG90bGFuZCwgSW5nYSB3cm90ZToNCj4gPiA+IEhpIE1pY2hhbCwNCj4gPiA+
IA0KPiA+ID4gT24gV2VkLCAyMDE5LTA5LTE4IGF0IDEwOjUyICswMjAwLCBNaWNoYcWCIExvd2Fz
LVJ6ZWNob25layB3cm90ZToNCj4gPiA+ID4gSGkgQnJpYW4sDQo+ID4gPiA+IA0KPiA+ID4gPiA+
IEltYWdpbmUgYSBkb3QtbWF0cml4LCB3aGVyZSBlYWNoIHBpeGVsIGlzIGEgbWVzaCBub2RlLg0K
PiA+ID4gPiA+IA0KPiA+ID4gPiA+IEVhY2ggb2YgdGhlc2UgcGl4ZWxzIGltcGxlbWVudHMgdHdv
IG1vZGVsczoNCj4gPiA+ID4gPiAgICAgb24gZWxlbWVudCAwLCBhIEdlbmVyaWNPbk9mZlNlcnZl
ciBjb250cm9sbGluZyB0aGUgbGlnaHQNCj4gPiA+ID4gPiBvdXRwdXQNCj4gPiA+ID4gPiAgICAg
b24gZWxlbWVudCAxLCBhIEJsaW5rZW5saWdodHMgU2VydmVyIG1vZGVsDQo+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gQmxpbmtlbmxpZ2h0cyBTZXJ2ZXIgZXh0ZW5kcyBHZW5lcmljT25PZmYgU2VydmVy
IGFuZA0KPiA+ID4gPiA+IEdlbmVyaWNPbk9mZg0KPiA+ID4gPiA+IENsaWVudCwgYW5kIG9uIHRv
cCBvZiB0aGF0IGNvbnRhaW5zIGEgdHJhbnNsYXRpb24gdGFibGUgbWFwcGluZw0KPiA+ID4gPiA+
IGdyb3VwDQo+ID4gPiA+ID4gYWRkcmVzcyB0byBlaXRoZXIgJ09OJyBvciAnT0ZGJy4NCj4gPiA+
ID4gPiANCj4gPiA+ID4gPiBOb3csIHdoZW4gQmxpbmtlbmxpZ2h0cyBTZXJ2ZXIgcmVjZWl2ZXMg
YSBHZW5lcmljT25PZmYgU2V0DQo+ID4gPiA+ID4gbWVzc2FnZSwNCj4gPiA+ID4gPiBpdA0KPiA+
ID4gPiA+IGxvb2tzIHVwIHRoZSBkZXN0aW5hdGlvbiBhZGRyZXNzIGF0IHRoZSB0cmFuc2xhdGlv
biB0YWJsZSwgYW5kDQo+ID4gPiA+ID4gc2VuZHMgYQ0KPiA+ID4gPiA+ICpkaWZmZXJlbnQqIEdl
bmVyaWNPbk9mZiBTZXQgdG8gKml0cyBvd24qIGVsZW1lbnQgMCwgd2l0aA0KPiA+ID4gPiA+IHRh
cmdldA0KPiA+ID4gPiA+IHZhbHVlDQo+ID4gPiA+ID4gZGV0ZXJtaW5lZCBieSB0aGUgdHJhbnNs
YXRpb24gZW50cnkuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gVGhpcyBhbGxvd3MgdXNlcnMgdG8g
Y29uZmlndXJlIGVhY2ggbm9kZSBpbiBzdWNoIGEgd2F5LCB0aGF0DQo+ID4gPiA+ID4gc2VuZGlu
ZyBhDQo+ID4gPiA+ID4gKnNpbmdsZSogbWVzc2FnZSB0byBhIGdyb3VwIGFkZHJlc3MgY2F1c2Vz
IGFsbCBwaXhlbHMgdG8gc3dpdGNoDQo+ID4gPiA+ID4gdG8NCj4gPiA+ID4gPiBhDQo+ID4gPiA+
ID4gcHJlY29uZmlndXJlZCBwYXR0ZXJuICphdCB0aGUgc2FtZSB0aW1lKi4NCj4gPiA+ID4gDQo+
ID4gPiA+IFBlciBjb252ZXJzYXRpb24gd2l0aCBQaW90ciwgSSdkIGxpa2UgdG8gcmV2aXNpdCB0
aGUgZGlzY3Vzc2lvbg0KPiA+ID4gPiBhbmQNCj4gPiA+ID4gcHJvdmlkZSBtb3JlIGRldGFpbHMg
YWJvdXQgb3VyIHVzZSBjYXNlIGZvciBtb2RlbHMga25vd2luZyB0aGUNCj4gPiA+ID4gZGVzdGlu
YXRpb24gYWRkcmVzcy4NCj4gPiA+ID4gDQo+ID4gPiA+IFBsZWFzZSBzZWUgYSBkaWFncmFtIGF0
IGh0dHA6Ly91amViLnNlL0JtVElXLg0KPiA+ID4gPiANCj4gPiA+ID4gVGhlIG1haW4gcmVhc29u
IHdlIG1hcCBzY2VuZXMgdXNpbmcgZGVzdGluYXRpb24gYWRkcmVzc2VzIGlzIHRoYXQNCj4gPiA+
ID4gc3VjaCBhDQo+ID4gPiA+IHNldHVwIGNvbnN1bWVzIG11Y2ggbGVzcyB1bmljYXN0IGFkZHJl
c3Nlcy4NCj4gPiA+ID4gDQo+ID4gPiA+IEFzc3VtaW5nIHRoYXQ6DQo+ID4gPiA+ICBTIC0gbnVt
YmVyIG9mIHN3aXRjaGVzDQo+ID4gPiA+ICBCIC0gbnVtYmVyIG9mIGJ1dHRvbnMgKGVsZW1lbnRz
KSBvbiBhIHN3aXRjaA0KPiA+ID4gPiAgTiAtIG51bmJlciBvZiBsYW1wcw0KPiA+ID4gPiANCj4g
PiA+ID4gV2l0aCBhICdyZWd1bGFyJyBjYXNlLCBudW1iZXIgb2YgY29uc3VtZWQgdW5pY2FzdCBh
ZGRyZXNzZXMgaXMNCj4gPiA+ID4gICAgIFMqQiArIE4qKEIrMSkNCj4gPiA+ID4gDQo+ID4gPiA+
IFdpdGggdGhlIGRlc3RpbmF0aW9uIG1hcHBpbmcsIGl0IGJlY29tZXMNCj4gPiA+ID4gICAgIFMq
QiArIE4qMg0KPiA+ID4gPiANCj4gPiA+ID4gU2luY2Ugd2UgdHlwaWNhbGx5IHVzZSA0IGJ1dHRv
biBzd2l0Y2hlcyAoQj00KSwgd2l0aG91dA0KPiA+ID4gPiB0cmFuc2xhdGlvbg0KPiA+ID4gPiB3
ZQ0KPiA+ID4gPiBjb25zdW1lIHVuaWNhc3QgYWRkcmVzcyBzcGFjZSBhdCBhICptdWNoKiBmYXN0
ZXIgcmF0ZS4NCj4gPiA+ID4gDQo+ID4gPiA+IHJlYWdyZHMNCj4gPiA+IA0KPiA+ID4gT2theSwg
dGhpcyBpcyBhIGdvb2QgYXJndW1lbnQgZm9yIGV4cG9zaW5nIHRoZSBzdWJzY3JpcHRpb24gYWRk
cmVzcw0KPiA+ID4gaW4NCj4gPiA+IE1lc3NhZ2VSZWNlaXZlZCgpLg0KPiA+ID4gSXQncyBiZXR0
ZXIgdG8gc2VwYXJhdGUgdGhlIG1ldGhvZCBpbnRvIHR3bywgZS5nLiBNZXNzYWdlUmVjZWl2ZWQo
KQ0KPiA+ID4gYW5kDQo+ID4gPiBNZXNzYWdlUmVjZWl2ZWRWaXJ0dWFsKCkuDQo+ID4gDQo+ID4g
SSB3b25kZXIgaWYgd2UgY291bGQgc3RpbGwgZG8gdGhpcyB3aXRoIGEgc2luZ2xlIG1ldGhvZC4g
IEkgY2FuIHRoaW5rDQo+ID4gb2YgMiBtZXRob2RvbG9naWVzOg0KPiA+IA0KPiA+IDEuIEEgc2lt
cGxlIHdheSB0aGF0IGp1c3QgdXNlcyB0aGUgVTE2IERTVCBmaWVsZCBpbnN0ZWFkIG9mDQo+ID4g
dGhlICJzdWJzY3JpcHRpb24iIGJvb2xlYW4gKG5vdCBhIDEwMCUgcmVsaWFibGUgZGlmZmVyZW50
aWF0b3INCj4gPiBmb3IgVmlydHVhbHMsIGJ1dCBtYXkgYmUgc3VmZmljaWVudCBmb3IgdGhlIHVz
ZSBjYXNlcyBnaXZlbikuDQo+ID4gDQo+ID4gMi4gUmVwbGFjaW5nIHRoZSBzdWJzY3JpcHRpb24g
Ym9vbGVhbiB3aXRoIGEgdTMyICJTdWJzY3JpcHRpb24gSUQiLg0KPiA+IEEgc3Vic2NyaXB0aW9u
IElEIHZhbHVlIG9mIDB4MDAwMDAwMDAwIHdvdWxkIGluZGljYXRlIHRoYXQgdGhlDQo+ID4gbWVz
c2FnZSB3YXMgcmVjZWl2ZWQgd2l0aCB0aGUgVW5pY2FzdCBhZGRyZXNzLCBhbmQgdmFsdWVzIGZy
b20NCj4gPiAxIC0gMHhGRkZGRkZGRiBtZWFuIGEgU3Vic2NyaXB0aW9uIHRoYXQgY2FuIGJlIHF1
ZXJpZWQgZm9yLiBUaGlzDQo+ID4gd291bGQgYmUgYWNjb21wYW5pZWQgYnkgYSBuZXcgZGFlbW9u
IG1ldGhvZCB3aGljaCBjb3VsZCBsb29rIHVwDQo+ID4gdGhlIGRldGFpbHMgb2YgdGhlIHN1YnNj
cmlwdGlvbjoNCj4gPiANCj4gPiB7ZGljdCBzdWJjcmlwdGlvbn0gIExvb2t1cFN1YnNjcmlwdGlv
bih1MzIgU3ViX0lEKQ0KPiA+IA0KPiA+IEJvdGggb2YgdGhlc2UgbWV0aG9kb2xvZ2llcyB3b3Vs
ZCBhbGxvdyBhbiBBcHAgdG8gYmUgc2ltcGxlciwNCj4gPiB3aXRoIG5vIGFkZGVkIEQtQnVzIE1l
dGhvZHMgcmVxdWlyZWQuDQo+ID4gDQo+ID4gV2l0aCB0aGUgMm5kIG1ldGhvZG9sb2d5LCB0aGUg
c3Vic2NyaXB0aW9uIG9ubHkgbmVlZHMgdG8gYmUNCj4gPiBsb29rZWQgdXAgb25jZSAob3Igbm90
IGF0IGFsbCkgdG8gMTAwJSBkaWZmZXJlbnRpYXRlIGJldHdlZW4NCj4gPiBkaXNjcmV0ZSBzdWJz
Y3JpcHRpb25zLg0KPiA+IA0KPiA+IEkgKnJlYWxseSogZG8gbm90IHdhbnQgYW4gYWRkaXRpb25h
bCBtYW5kYXRvcnkgQXBwIE1ldGhvZC4gTW9zdA0KPiA+IEFwcHMgd2lsbCBiZSBzaW1wbGVyIHRo
YW4gdGhhdCwgYW5kIHRydWVseSBub3QgY2FyZSB0bw0KPiA+IGRpZmZlcmVudGlhdGUgYmV0d2Vl
biBzdWJzY3JpcHRpb25zLi4uICAgUGFydGljdWxhcmlseSBDbGllbnQNCj4gPiBiYXNlZCBBcHBz
Lg0KPiANCj4gV2hpbGUgSSBhbSBzdGlsbCBpbiBmYXZvciBvZiB0d28gZGlzdGluY3QgbWV0aG9k
cyAoZ2l2ZW4gY2hvaWNlLCBJJ2QNCj4gYWx3YXlzIGdvIHdpdGggc2VsZi1leHBsYW5hdG9yeSBB
UEkpLCBvbmUgbWV0aG9kIGFwcHJvYWNoIHdvdWxkIHdvcmsgYXMNCj4gd2VsbCBpZiBhY2NvbXBh
bmllZCBieSBkZXRhaWxlZCBhbmQgY2xlYXIgZGVzY3JpcHRpb24gaW4gdGhlIG1lc2gtDQo+IGFw
aS50eHQgZG9jLg0KPiANCj4gSSB2b3RlIGFnYWluc3QgdTE2IGRlc3RpbmF0aW9uIGZpZWxkIHNp
bmNlIHRoZXJlIGlzIG5vIHJlYXNvbiB0bw0KPiBjcmVhdGUgYWRkcmVzcyBzcGFjZSBjb2xsaXNp
b24gZXZlbiB0aG91Z2ggdGhlIGNoYW5jZXMgYXJlIHNtYWxsLg0KPiANCj4gQSBzaW5nbGUgbWV0
aG9kICJNZXNzYWdlUmVjZWl2ZWQiIG1ldGhvZCBjYW4gYmUgbW9kaWZpZWQgdG8gaW5jbHVkZSBh
DQo+IHN1YnNjcmlwdGlvbiBwYXJhbWV0ZXIgYXM6DQo+IDEpIGEgZGljdGlvbmFyeSB3aXRoIGtl
eXMgIkdyb3VwIiBhbmQgIkxhYmVsIiAoc2VsZiBleHBsYW5hdG9yeSBpZiBhDQo+IGJpdCBjdW1i
ZXJzb21lKS4NCg0KSWYgdGhpcyB1c2UgY2FzZSBpcyBjaG9zZW4sIGlzIGl0IGVhc3kgZW5vdWdo
IGZvciBhbiBBcHAgaW1wbGVtZW50YXRpb24NCm9mIHRoaXMgbWV0aG9kIHRvICppZ25vcmUqIHRo
ZSBkaWN0aW9uYXJ5IGlmIHRoZSBzdWJzY3JpcHRpb24gaW5mb3JtYXRpb24NCmlzIG5vdCBpbXBv
cnRhbnQgdG8gdGhhdCBtb2RlbD8gKEFnYWluOiAgVGhpbmtpbmcgb2Ygc2ltcGxlIGFwcGxpY2F0
aW9ucw0KdGhhdCBqdXN0IHdhbnQgdG8ga25vdyB3aGV0aGVyIHRvIHJlc3BvbmQgdG8gdGhlIG1l
c3NhZ2Ugb3Igbm90IGJlY2F1c2UNCml0IHdhcyBvciB3YXNuJ3Qgc2VudCB0byB0aGUgVW5pY2Fz
dCBhZGRyZXNzKQ0KDQo+IG9yDQo+IDIpIGEgdTMyIHN1YnNjcmlwdGlvbiBJRCB0aGF0IHJlcHJl
c2VudHMgYSBzdWJzY3JpcHRpb24uIFRoaXMgDQo+IHJlcXVpcmVzIHRoZSBkYWVtb24gdG8gbWFp
bnRhaW4gdGhlIHJlbGF0aW9uc2hpcCBiZXR3ZWVuICJpZCIgYW5kIHRoZQ0KPiBhY3R1YWwgYWRk
cmVzcy4gSSBiZWxpZXZlIHRoZSBkYWVtb24gZG9lcyB0aGlzIGFueXdheSBmb3IgdmlydHVhbA0K
PiBsYWJlbHMsIGJ1dCBmcm9tIHRoZSBBUEkgZGVzaWduIHBlcnNwZWN0aXZlIHRoaXMgaXMgbm90
IHZlcnkgY2xlYW4NCj4gSU1ITywgc2luY2UgaXQgaGFzIGEgd2hpZmYgb2YgaW1wbGVtZW50YXRp
b24gZGV0YWlscyBsZWFraW5nIGludG8gdXNlcg0KPiBpbnRlcmZhY2UgQVBJLiANCj4gDQo+IE5v
IG1hdHRlciB3aGljaCBhcHByb2FjaCBpcyBjaG9zZW4sIHRoZSBzdWJzY3JpcHRpb25zIG11c3Qg
YmUgaW5jbHVkZWQNCj4gaW4gdGhlIG1vZGVsIGNvbmZpZ3VyYXRpb24gZGljdGlvbmFyeSBmb3Ig
VXBkYXRlTW9kZWxDb25maWd1cmF0aW9uKCkNCj4gYW5kIGluIHRoZSBjb3JyZXNwb25kaW5nIGRp
Y3Rpb25hcnkgZm9yIG5vZGUgY29uZmlndXJhdGlvbiByZXR1cm5lZCBvbg0KPiBzdWNjZXNzZnVs
IGV4ZWN1dGlvbiBvZiBBdHRhY2goKS4NCj4gDQo+IElmIHdlIGdvIHdpdGggYSBzaW5nbGUgbWV0
aG9kIGFuZCBhIHUzMiBzdWJzY3JpcHRpb24gaWQsIHRoZQ0KPiBkaXNjdGlvbmFyeSByZXByZXNl
bnRhdGlvbiBvZiB0aGUgc3Vic2NyaXB0aW9ucyBzaG91bGQgYmUgYSBwYWlyIHtpZCwNCj4gYWN0
dWFsIHN1YnNjcmlwdGlvbiBhZGRyZXNzfS4gVGhpcyB3YXkgdGhlcmUgaXMgbm8gbmVlZCBmb3Ig
YW4NCj4gYWRkaXRpb25hbCBkYWVtb24gbWV0aG9kLg0KDQpXZSBoYXZlIGF2b2lkZWQgZGljdGlv
bmFyaWVzIHNwZWNpZmljYWxseSB0byBhdm9pZCBtYW5kYXRpbmcgdGhhdA0KQXBwbGljYXRpb25z
IG5lZWQgdG8gaGF2ZSBsb2dpYyB0byBwYXJzZSB0aGVtLi4uICBBbmQgd2l0aCB0aGlzLA0KdGhl
eSB3b3VsZCBoYXZlIHRvIHBhcnNlIHRoZSBkaWN0aW9uYXJ5IG9uICpldmVyeSBtZXNzYWdlIHJl
Y2VpdmVkKi4NCg0KQWdhaW4sIEkgYmVsaWV2ZSB0aGF0IDk5JSBvZiBhcHBsaWNhdGlvbnMgd2ls
bCAqbm90KiBiZSBpbnRlcmVzdGVkDQppbiB0aGUgc3BlY2lmaWNzIG9mIHRoZSBzdW5zY3JpcHRp
b24vZ3JvdXAgYWRkcmVzcyBpbmZvIGV4Y2VwdCB0byANCmRpZmZlcmVudGlhdGUgYmV0d2VlbiBV
bmljYXN0IGFuZCBub24tVW5pY2FzdCBhZGRyZXNzaW5nLg0KDQpUaGF0IGlzIHdoeSBJIGFtIGlu
IGZhdm9yIG9mICpub24qIGNvbXBsZXggYXJndW1lbnRzIG9uIHRoZQ0KTWVzc2FnZVJlY2VpdmVk
KCkgbWV0aG9kLiAgQW4gYWRkaXRpb25hbCBkYWVtb24gbWV0aG9kIHRoYXQgcmV0dXJucw0KYSBk
aWN0aW9uYXJ5IG9ubHkgd2hlbiBhc2tlZCAod2hpY2ggZXZlbiB3aXRoIHNjZW5lcyB3aWxsIGJl
IHJhcmUgb3INCm9ubHkgb25jZSBhIHNlc3Npb24gcGVyIHN1YnNjcmlwdGlvbikgd2lsbCBjcmVh
dGUgbGVzcyBvdmVyYWxsIGRidXMNCnRyYWZmaWMuDQoNCj4gDQo+IE1pY2hhbCwgYW55IGNvbW1l
bnRzPw0KPiANCj4gPiA+IFRoZW4gaXQgbWFrZXMgc2Vuc2UgdG8gYWRkIG1vZGVsIHN1YnNjcmlw
dGlvbiBhcnJheSBhcyBhIGRpY3Rpb25hcnkNCj4gPiA+IGVudHJ5IGluIHRoZSBVcGRhdGVNb2Rl
bENvbmZpZ3VyYXRpb24oKSBhcyB3ZWxsIGFzIGZvciB0aGUgbm9kZQ0KPiA+ID4gY29uZmlndXJh
dGlvbiByZXR1cm5lZCB3aGVuIGNhbGxpbmcgQXR0YWNoKCkgbWV0aG9kLg0KPiA+ID4gUHJvYmFi
bHkgd2lsbCBoYXZlIHRvIGhhdmUgc2VwYXJhdGUga2V5czogIkdyb3VwcyIgYW5kICJWaXJ0dWFs
cyIuDQo+ID4gPiANCj4gDQo+IFJlZ2FyZHMsDQo+IEluZ2ENCj4gDQo+IA0K
