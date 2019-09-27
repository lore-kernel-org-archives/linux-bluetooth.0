Return-Path: <SRS0=evP7=XW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3879C4360C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Sep 2019 19:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9778E20872
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Sep 2019 19:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Ico0MrwM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbfI0TZu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Sep 2019 15:25:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:51148 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfI0TZu (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Sep 2019 15:25:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2019 12:25:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,556,1559545200"; 
   d="scan'208";a="273915427"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga001.jf.intel.com with ESMTP; 27 Sep 2019 12:25:48 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 27 Sep 2019 12:25:48 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 27 Sep 2019 12:25:47 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 27 Sep 2019 12:25:47 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.59) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 27 Sep 2019 12:25:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5YNm0+uBM4amQ/eWjdeLvhFMWOhx0OOuvkhN6iP44PU6ak3FwmLfXjd5jmOuGL6G0nzbTtPgjRIrL/IkE8wHqsKkqfgt3l7XziD3e0MBOdH9dDslY3KAoxRGy4BpBTo0ArwGrvGwypAXWI6N+FGzaOA74oReINRvnFw2xFWTGmLZgNXCl08EQyCaFmtTYU+oFwlMRtg9MqQXjMOxHp4gGcnQZmiubZayc/+86lVY8C0EPaKUqaNYzBF5pFneaDZzFOYuj5okkT1qvbPAo773lOSomZWNPn6xYwkdoXYoupxiHtvNSqiQ1dI+AFrnBvg44SSDJUENyoW2IE9QqeU5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BB83Qg1EUW7H+5uqAMTiLb/f77nRkShkeXxoYrHfvXM=;
 b=RMSoJjmSi8JTsi6AgITFZDT0pfCM/YfoSWeCj6zPostEHm8LsQiim/w+kRzdbYBqf6dfTiyWTQoA67ClLkl8Gj70QFtEMw9q/NfPkukGTyWJJO27a7D5QyXORIkvwnOjpCiaCNkjnW2zJssTXRgTpiFKEaqDIedX258J66w+81deUmIo+w9t3xz30b7hTvmkqD3STIDz3NEM+mpdV1dj9s2aKmuxzp7pu+6apurBx+q7bIVqszbue+VUL7MHTpk8cXsIbucaMu6htV/KAQKQojofT5+/v/czD4Cjf1Kmw7BbdL0d1DLGaUrWl45LhE+UCGu5nrX446OezAgYl6UwgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BB83Qg1EUW7H+5uqAMTiLb/f77nRkShkeXxoYrHfvXM=;
 b=Ico0MrwMce5uukjrOspJ6y97capM6puBEogekm05/krwX5h712XZWemZ9IlALjyip/hbgAHveOgP7uoRCCTH95gFKt2S9EbCgeo2HPZdxDGpnTHpiyht4iTe/oLhJdQHWhwt/F1GgGPN6kSGr8+Rz5k3VX8EoI6I1B/I5rfjzKw=
Received: from DM6PR11MB4412.namprd11.prod.outlook.com (52.132.248.86) by
 DM6PR11MB3498.namprd11.prod.outlook.com (20.177.220.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.23; Fri, 27 Sep 2019 19:25:45 +0000
Received: from DM6PR11MB4412.namprd11.prod.outlook.com
 ([fe80::5d45:636:6a4a:9397]) by DM6PR11MB4412.namprd11.prod.outlook.com
 ([fe80::5d45:636:6a4a:9397%7]) with mapi id 15.20.2305.017; Fri, 27 Sep 2019
 19:25:45 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: mesh: org.bluez.mesh.Element.MessageReceived method does not
 provide destination address
Thread-Topic: mesh: org.bluez.mesh.Element.MessageReceived method does not
 provide destination address
Thread-Index: AQHVX2LEF/rrCs91wE6OiENpKqkMj6cxPhOAgAuqqYCAAVPegIAAWhSAgADMPACAAHTBgIAAGq4AgAAhlwA=
Date:   Fri, 27 Sep 2019 19:25:45 +0000
Message-ID: <86e707237937cfb5c4e8fea8e96924f4590ab0a3.camel@intel.com>
References: <20190830184301.zd3zaqrw7mv6r252@kynes>
         <20190918085239.xhahxoeqjkcrk3bl@mlowasrzechonek2133>
         <3c5858c94b3e08a61c5ff8493f9b00f5f77d0aac.camel@intel.com>
         <4b57242b15ccb44ac123858ce7bdf6e0e526b3e0.camel@intel.com>
         <a0442c7485fef2bfde9bc52283a5c9dfc0b43515.camel@intel.com>
         <20190927085208.sxy2x5656ci3opo6@mlowasrzechonek2133>
         <01c84f55db98fbcc2790d11fd6090589881c36cf.camel@intel.com>
         <856d4e6bfdbe84b7b7ac3742ebede263c7801346.camel@intel.com>
In-Reply-To: <856d4e6bfdbe84b7b7ac3742ebede263c7801346.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [134.134.139.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6275b22-5598-4aaa-0971-08d743807ea1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR11MB3498;
x-ms-traffictypediagnostic: DM6PR11MB3498:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB34989E1A1D4CEC20F4A3B4ACE1810@DM6PR11MB3498.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(136003)(346002)(39860400002)(199004)(189003)(2501003)(25786009)(3846002)(8936002)(6116002)(110136005)(305945005)(6246003)(102836004)(76176011)(186003)(5660300002)(7736002)(476003)(486006)(5024004)(316002)(71190400001)(81166006)(118296001)(11346002)(81156014)(2616005)(446003)(26005)(6506007)(66556008)(64756008)(2906002)(91956017)(76116006)(66446008)(8676002)(15650500001)(6636002)(256004)(6486002)(71200400001)(229853002)(6436002)(14454004)(66946007)(478600001)(6512007)(66476007)(99286004)(66066001)(86362001)(4326008)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR11MB3498;H:DM6PR11MB4412.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9gVf496yB2pZQyIuv7wsNHRXvvU7ZbVmY7ILK88Y6AGC10zfrKog0WJx0nnP+lrIP5zyRbsbj+sJ2ukIZ/EWgPfS/+W+vSmSs+ecYFhldKwHKy/WbD7NM8Au7tWcWAzQDpLbfxl0ABs9Ek5/78Ib2C/CEuZuTRN4CO0LYzv4jyJaT38PjEZEyRyxz/dw0lFD9NfrSEuVXmAKva8R2HVEW4w62PQpc2pvHBMpnTAKlbOBFjeoaZ9jt02VQY/1K92M1EsIjBh/iHiW74tbYIvwoVz+ngqPsTfVcjyivRGA8tMpkcNTq+DbXLezRIFNlGGeKCAG3AFYFVwHHkv4P8I0CkV7jWmZswrJr58Ff88Gh6ot60/2p/4fp2C0ZPV5Pw2Dq0kh7RP3COWP4Qahmt5u5Y4Aq70vSRwOPWjuVLAp454=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40105EBAF9E25B44BA108C55B8312FBC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e6275b22-5598-4aaa-0971-08d743807ea1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 19:25:45.4173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yjv/+xp5FqpiTHMsUbPtH5dLEWCI5Ge9L9rgo1OMN25v0AnGpX2izrahxZHMpxChz2R7Ixi9QUZ3E7XepywflA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3498
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

T24gRnJpLCAyMDE5LTA5LTI3IGF0IDE3OjI1ICswMDAwLCBTdG90bGFuZCwgSW5nYSB3cm90ZToN
Cj4gSGkgQnJpYW4sIA0KPiANCj4gT24gRnJpLCAyMDE5LTA5LTI3IGF0IDE1OjUwICswMDAwLCBH
aXgsIEJyaWFuIHdyb3RlOg0KPiA+IE9uIEZyaSwgMjAxOS0wOS0yNyBhdCAxMDo1MiArMDIwMCwg
bWljaGFsLmxvd2FzLXJ6ZWNob25la0BzaWx2YWlyLmNvbQ0KPiA+ICB3cm90ZToNCj4gPiA+IElu
Z2EsIEJyaWFuLA0KPiA+ID4gDQo+ID4gPiBTdGlsbCwgZXZlbiBpZiB3ZSBhZGQgYSBtZXRob2Qs
IHRoZSBhcHBsaWNhdGlvbiBpcyBmcmVlICpub3QqIHRvDQo+ID4gPiBpbXBsZW1lbnQgaXQsIHNp
bmNlIHdlIGFncmVlZCBiYWNrIGluIHRoZSBkYXkgdGhhdCBjYWxscyB0bw0KPiA+ID4gTWVzc2Fn
ZVJlY2VpdmVkIGRvIG5vdCByZXF1aXJlIGEgcmVzcG9uc2UsIHNvIGFueSBlcnJvcnMgd291bGQg
YmUNCj4gPiA+IHNpbXBseQ0KPiA+ID4gaWdub3JlZCBieSB0aGUgZGFlbW9uLg0KPiA+IA0KPiA+
IFRoaXMgaXMgbm90IGFuIG9wdGlvbi4NCj4gPiANCj4gPiBBIG5vZGUgZG9lcyBub3QgZ2V0IHRv
IGRlY2lkZSB3aGljaCBzdXNic2NyaXB0aW9ucyBhcmUgInZhbGlkIi4gIElmIGENCj4gPiBWaXJ0
dWFsIEFkZHJlc3Mgc3Vic2NyaXB0aW9uIGlzIGFkZGVkIHRvDQo+ID4gYSBub2RlLCBhbmQgdGhl
biBhIG1lc3NhZ2UgaXMgc2VudCB0byB0aGF0IHZpcnR1YSBhZGRyZXNzLCB0aGUgQXBwDQo+ID4g
bmVlZHMgdG8gYmUgYWJsZSB0byByZWNlaXZlIGl0Lg0KPiA+IA0KPiA+IFllcywgYW55IGRpc2Ny
ZXRlIG1lc3NhZ2UgbWF5IGJlIGxvc3QsIGJ1dCBJIGRvbid0IHRoaW5rIHdlIGhhdmUgdGhlDQo+
ID4gb3B0aW9uIG9mIGxldHRpbmcgKmFsbCogdmlydHVhbCBhZGRyZXNzZWQNCj4gPiBtZXNzYWdl
cyB0byBhbiBBcHAgdG8gYmUgaWdub3JlZC4gIElmIHdlIGFkZCBhbiBBcHAgQVBJLCBpdCB3aWxs
IG5lZWQNCj4gPiB0byBiZSBtYW5kYXRvcnksIHdoaWNoIGlzIHdoeSBJIGFtDQo+ID4gYWdhaW5z
dCBpdC4NCj4gPiANCj4gPiBJIHN0cm9uZ2x5IGJlbGlldmUgd2UgbmVlZDoNCj4gPiANCj4gPiAx
LiBBIHNpbmdsZSBtZXRob2QgZm9yIGRlbGl2ZXJpbmcgKG5vbiBkZXYga2V5KSByZWNlaXZlZCBt
ZXNzYWdlcw0KPiA+IDIuIEEgbWV0aG9kIHRoYXQgZG9lcyBub3QgcmVxdWlyZSBkaWN0aW9uYXJ5
IHBhcnNpbmcNCj4gPiANCj4gPiBIb3cgYXJlIHdlIGZlZWxpbmcgYWJvdXQ6DQo+ID4gdm9pZCBN
ZXNzYWdlUmVjZWl2ZWQodWludDE2IHNvdXJjZSwgdWludDE2IGtleV9pbmRleCwNCj4gPiBhcnJh
eXtieXRlfSBkZXN0aW5hdGlvbiwgYXJyYXl7Ynl0ZX0gZGF0YSkNCj4gPiANCj4gPiANCj4gPiBX
aGVyZSBkZXN0aW5hdGlvbiBsZW5ndGggb2Y6DQo+ID4gMCAtIFVuaWNhc3QgYWRkcmVzcyBvZiBl
bGVtZW50DQo+ID4gMiAtIEdyb3VwIEFkZHJlc3MNCj4gPiAxNiAtIFZhcmlhYmxlIExhYmVsDQo+
ID4gDQo+ID4gSSB0aGluayB0aGlzIGZ1bGZpbGxzIGFsbCBvZiBvdXIgcmVxdWlyZW1lbnRzLg0K
PiA+IA0KPiANCj4gRm9yIGEgc2luZ2xlIE1lc3NhZ2VSZWNlaXZlZCgpIG1ldGhvZCwgdGhlIGNs
ZWFuZXN0IHdheSBpcyB0byBoYXZlIHRoZQ0KPiBzdWJzY3JpcHRpb24gYWRkcmVzcyBwYXJhbWV0
ZXIgYXMgYSB2YXJpYW50IChzdWdnZXN0ZWQgYnkgTWljaGFsKSBvciBhcw0KPiBhIGRpY3Rpb25h
cnkuDQo+IEFuIGFycmF5IGludHJvZHVjZXMgYW4gZXh0cmEgY29uc2lkZXJhdGlvbiBvZiBieXRl
IG9yZGVyaW5nIGZvciBncm91cA0KPiBhZGRyZXNzZXMuDQoNCklmIHZhcmlhbnRzIGFyZSBlYXN5
IHRvIHNvcnQgaW4gc2NyaXB0aW5nIGxhbmd1YWdlcyBsaWtlIHB5dGhvbjMsIHRoYW4gSQ0Kc3Vw
cG9zZSBJIGNvdWxkIGxpdmUgd2l0aCB0aGlzLiBXb3VsZCB0aGVzZSB3b3JrIGxpa2UgQysrIG92
ZXJsb2FkaW5nPw0KT3IgaXMgdGhpcyBzdGlsbCBhIHR3byBzdGVwIHByb2Nlc3Mgb2Y6DQoxLiBE
ZXRlcm1pbmluZyB0aGUgdTE2IHZzIHUxMjgNCjEuMSB1bm1hcnNoYWxsaW5nIHRoZSBjb3JyZWN0
IHR5cGUuLi4NCg0KV2hhdCB3b3VsZCB0aGUgc2lnbmF0dXJlIG9mIHRoZSBtZXRob2QgbG9vayBs
aWtlPw0KDQo+IA0KPiBXaGF0IEkgbW9zdGx5IGFib3V0IGlzIHRoYXQgdGhlIHJlcHJlc2VuYXRp
b24gb2YgdGhlIHN1YnNjcmlwdGlvbg0KPiBhZGRyZXNzIGluIHRoZSBNZXNzYWdlUmVjZWl2ZWQo
KSBtZXRob2QgY29ycmVzcG9uZHMgdG8gdGhlDQo+IHJlcHJlc2VudGF0aW9uIGluIHRoZSBjb25m
aWd1cmF0aW9uIGRpY3Rpb25hcmllcyBmb3IgdGhlIEF0dGFjaCgpIGFuZA0KPiBVcGRhdGVNb2Rl
bENvbmZpZ3VyYXRpb24oKSBtZXRob2RzLg0KDQpDb25maWd1cmF0aW9uIGRpY3Rpb25hcmllcyBj
YW4gZ2VuZXJhbGx5IGJlIGlnbm9yZWQgYnkgc2ltcGxlIEFwcHMsIHNvDQpEaWN0aW9uYXJ5IHBh
cnNpbmcgaXMgYWx3YXlzIG9wdGlvbmFsIGZvciBBdHRhY2goKSBhbmQgDQpVcGRhdGVNb2RlbENv
bmZpZ3VyYXRpb24oKS4gSG93ZXZlciBldmVuIHNpbXBsZSBBcHBzIG5lZWQgdG8gYmUgYWJsZSAN
CnRvIHRlbGwgdGhlIGRpZmZlcmVuY2UgYmV0d2VlbiBVbmljYXN0IGFuZCBOb24tVW5pY2FzdCBk
ZXN0aW5hdGlvbnMNCmZvciByZWNlcHRpb25zLCBiZWNhdXNlIHRoZSBydWxlcyBmb3IgcmVzcG9u
ZGluZyBhcmUgZ2VuZXJhbGx5IGRpZmZlcmVudC4uLg0KV2hpY2ggaXMgd2h5IHRoZSBjdXJyZW50
IG1ldGhvZCBoYXMgdGhlIHNpbXBsZSBib29sZWFuLg0KDQoNCg0KDQo=
