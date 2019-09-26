Return-Path: <SRS0=vBm7=XV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DE7C4360C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Sep 2019 15:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1FA9222C6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Sep 2019 15:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="C6CntJRv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfIZPSt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Sep 2019 11:18:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:17437 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbfIZPSt (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Sep 2019 11:18:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2019 08:18:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,552,1559545200"; 
   d="scan'208";a="214508879"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga004.fm.intel.com with ESMTP; 26 Sep 2019 08:18:48 -0700
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Sep 2019 08:18:48 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX114.amr.corp.intel.com (10.18.116.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Sep 2019 08:18:47 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (104.47.41.52) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 26 Sep 2019 08:18:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJ6HLEqaSJ6wDnXIZu3NRNUWrP7wXmVt1hgg5QFiPQpooyPOA9VSRQY5wUY2xDxoRDG1v1KqZHvgOZ92P2vOH0PQWa45Wo2p0pHgCwQgnZ02nPdvOyFqROLVXShV8Dap98XPu2Qrg8lpXRuKnNV5MhiHjo4gzk/wrX4fze4X8w7B0PAaDxf4SZeiD8kUuUa82d1zglyFtfya7CHMVlXwCfqsUKqUqSfCihM8zyYB1hbC5YgAGQdnhs7Xu/5+9u+fD5BbwG5ErACUIgJn8nmh3xmpn0NevqFdCHaB+fH+vPnJ0cLskMCPZjTSwuyfzk/NdRgOxv0rnlS8+GIN0Uvp+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkZyCTsjSnS9En3GK1NKnKh1ORl2jwhW175fwLE+M1E=;
 b=O8Ni768FP+Cqm3ZUfitdVY+z9n+GjnR+tHxtk8UhQrWyM4uDSIdZ7w2pymUe2RsKwYoSWs7U6MP8qNRs5Oq013bzd2/sB+SS/L5TebbfE6MHsgaadzyVQSXErAwkxkZXJ37URwdEOdZAyPMzfn1xHHrxF74p1n47izHK6fDwrw9cI/Jvaq89nGkBRT1WjRXJZNEHRRMoBVgp6l2TDGbXMv7weoJaHeixH4hfpya1v3451EAnGo08Z1/+PyKnN/LIDoHNcMb7DchB69IPUL9l9PZUJxlrKXnsG5pa84bC8Gt/EGYzto6f/Xq5jMMlm3tHWEZqeHBtpKxTQY/XQbkZbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkZyCTsjSnS9En3GK1NKnKh1ORl2jwhW175fwLE+M1E=;
 b=C6CntJRvHVsd7nsnW7DVySDAttIUqix9Kc6muvkC85UXYMAon1YlHnB825XFGbkzlgDoH9xhVBaX6qUQwZT56TnZAQ4cqzU9hLlrt+73uTLTDmBu9jiZJy+6x5SDfv8leXLV3V0H39wnTNK8zi86xavaErdZxgD2sqqecjMIYNM=
Received: from DM6PR11MB4412.namprd11.prod.outlook.com (52.132.248.86) by
 DM6PR11MB3018.namprd11.prod.outlook.com (20.177.218.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.23; Thu, 26 Sep 2019 15:18:46 +0000
Received: from DM6PR11MB4412.namprd11.prod.outlook.com
 ([fe80::5d45:636:6a4a:9397]) by DM6PR11MB4412.namprd11.prod.outlook.com
 ([fe80::5d45:636:6a4a:9397%7]) with mapi id 15.20.2305.017; Thu, 26 Sep 2019
 15:18:46 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "piotr.winiarczyk@silvair.com" <piotr.winiarczyk@silvair.com>,
        "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>,
        "simon@silvair.com" <simon@silvair.com>
Subject: Re: mesh: org.bluez.mesh.Element.MessageReceived method does not
 provide destination address
Thread-Topic: mesh: org.bluez.mesh.Element.MessageReceived method does not
 provide destination address
Thread-Index: AQHVX2LEF/rrCs91wE6OiENpKqkMj6cxPhOAgAuqqYCAAVPegA==
Date:   Thu, 26 Sep 2019 15:18:45 +0000
Message-ID: <4b57242b15ccb44ac123858ce7bdf6e0e526b3e0.camel@intel.com>
References: <20190830184301.zd3zaqrw7mv6r252@kynes>
         <20190918085239.xhahxoeqjkcrk3bl@mlowasrzechonek2133>
         <3c5858c94b3e08a61c5ff8493f9b00f5f77d0aac.camel@intel.com>
In-Reply-To: <3c5858c94b3e08a61c5ff8493f9b00f5f77d0aac.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [134.134.139.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0bb22a99-d5cb-47c2-6982-08d74294d327
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR11MB3018;
x-ms-traffictypediagnostic: DM6PR11MB3018:
x-ms-exchange-purlcount: 1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB30189BA2D8CEC5C14220533FE1860@DM6PR11MB3018.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(396003)(136003)(366004)(346002)(189003)(199004)(54094003)(2906002)(81166006)(36756003)(446003)(71190400001)(81156014)(5024004)(8676002)(76176011)(2616005)(71200400001)(256004)(7736002)(110136005)(6512007)(2201001)(66066001)(316002)(6246003)(2501003)(76116006)(118296001)(7110500001)(229853002)(86362001)(25786009)(5660300002)(6306002)(14454004)(305945005)(66446008)(6436002)(66556008)(966005)(66946007)(91956017)(66476007)(64756008)(186003)(6506007)(26005)(6116002)(3846002)(478600001)(6486002)(8936002)(102836004)(11346002)(486006)(476003)(99286004)(2420400007)(15650500001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR11MB3018;H:DM6PR11MB4412.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qMoyo55vyiThPZ0q/T8iVu5uQq/9StZjsc5MczyvNt9Zkz73ytDTGSM5/UbmjWxsls5P9W9WiEZ1obVvVaTBFCFa4T0bLtDSV+pPhQnZC1NUWijZkIuNmDTJEEokc3tix4I1Qz8v0u+sFCK4WWfxFId8DZVoWd/5Muvmu1+mzw8SY3Bz/HetfFbg8K8UelJ/1lUtCwP9weFFiqjYR9CpGQqGnDbqSfSNvHE3oH69FnwqX3IN46XFsgsIySvKO+76NKgx8iuuUissx6DAsJMU4j/XUDgRsdDz+RlrOnsdSWDjfwcwtHPXt1PGc+KsnpzOMHv1KLY1EFXZ0ksJQRbYo4z0LrUPMDORyP3SZWjOph9B7rXCBh6FX+iFp+oYpIg/uBiokNDL1giDQ4e2J4gyl9/3cVW/2wUKrPqWaBHwp3OOlED66GlmJyTjiVF1ER641fmprYG5A2INxDQtr993yw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2AE7DC01F709D4C81843690EBF06F58@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb22a99-d5cb-47c2-6982-08d74294d327
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 15:18:46.0043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nCbX1XJkNC4SvkLZQotwogGxUVuVC5tX1vPwinWd054X09jDGUfaLm7RVUm7jyUTuBUcJZdKWaucWNLkchX/Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3018
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgSW5nYSwgTWljaGHFgiwNCg0KT24gV2VkLCAyMDE5LTA5LTI1IGF0IDE5OjAyICswMDAwLCBT
dG90bGFuZCwgSW5nYSB3cm90ZToNCj4gSGkgTWljaGFsLA0KPiANCj4gT24gV2VkLCAyMDE5LTA5
LTE4IGF0IDEwOjUyICswMjAwLCBNaWNoYcWCIExvd2FzLVJ6ZWNob25layB3cm90ZToNCj4gPiBI
aSBCcmlhbiwNCj4gPiANCj4gPiA+IEltYWdpbmUgYSBkb3QtbWF0cml4LCB3aGVyZSBlYWNoIHBp
eGVsIGlzIGEgbWVzaCBub2RlLg0KPiA+ID4gDQo+ID4gPiBFYWNoIG9mIHRoZXNlIHBpeGVscyBp
bXBsZW1lbnRzIHR3byBtb2RlbHM6DQo+ID4gPiAgICAgb24gZWxlbWVudCAwLCBhIEdlbmVyaWNP
bk9mZlNlcnZlciBjb250cm9sbGluZyB0aGUgbGlnaHQgb3V0cHV0DQo+ID4gPiAgICAgb24gZWxl
bWVudCAxLCBhIEJsaW5rZW5saWdodHMgU2VydmVyIG1vZGVsDQo+ID4gPiANCj4gPiA+IEJsaW5r
ZW5saWdodHMgU2VydmVyIGV4dGVuZHMgR2VuZXJpY09uT2ZmIFNlcnZlciBhbmQgR2VuZXJpY09u
T2ZmDQo+ID4gPiBDbGllbnQsIGFuZCBvbiB0b3Agb2YgdGhhdCBjb250YWlucyBhIHRyYW5zbGF0
aW9uIHRhYmxlIG1hcHBpbmcNCj4gPiA+IGdyb3VwDQo+ID4gPiBhZGRyZXNzIHRvIGVpdGhlciAn
T04nIG9yICdPRkYnLg0KPiA+ID4gDQo+ID4gPiBOb3csIHdoZW4gQmxpbmtlbmxpZ2h0cyBTZXJ2
ZXIgcmVjZWl2ZXMgYSBHZW5lcmljT25PZmYgU2V0IG1lc3NhZ2UsDQo+ID4gPiBpdA0KPiA+ID4g
bG9va3MgdXAgdGhlIGRlc3RpbmF0aW9uIGFkZHJlc3MgYXQgdGhlIHRyYW5zbGF0aW9uIHRhYmxl
LCBhbmQNCj4gPiA+IHNlbmRzIGENCj4gPiA+ICpkaWZmZXJlbnQqIEdlbmVyaWNPbk9mZiBTZXQg
dG8gKml0cyBvd24qIGVsZW1lbnQgMCwgd2l0aCB0YXJnZXQNCj4gPiA+IHZhbHVlDQo+ID4gPiBk
ZXRlcm1pbmVkIGJ5IHRoZSB0cmFuc2xhdGlvbiBlbnRyeS4NCj4gPiA+IA0KPiA+ID4gVGhpcyBh
bGxvd3MgdXNlcnMgdG8gY29uZmlndXJlIGVhY2ggbm9kZSBpbiBzdWNoIGEgd2F5LCB0aGF0DQo+
ID4gPiBzZW5kaW5nIGENCj4gPiA+ICpzaW5nbGUqIG1lc3NhZ2UgdG8gYSBncm91cCBhZGRyZXNz
IGNhdXNlcyBhbGwgcGl4ZWxzIHRvIHN3aXRjaCB0bw0KPiA+ID4gYQ0KPiA+ID4gcHJlY29uZmln
dXJlZCBwYXR0ZXJuICphdCB0aGUgc2FtZSB0aW1lKi4NCj4gPiANCj4gPiBQZXIgY29udmVyc2F0
aW9uIHdpdGggUGlvdHIsIEknZCBsaWtlIHRvIHJldmlzaXQgdGhlIGRpc2N1c3Npb24gYW5kDQo+
ID4gcHJvdmlkZSBtb3JlIGRldGFpbHMgYWJvdXQgb3VyIHVzZSBjYXNlIGZvciBtb2RlbHMga25v
d2luZyB0aGUNCj4gPiBkZXN0aW5hdGlvbiBhZGRyZXNzLg0KPiA+IA0KPiA+IFBsZWFzZSBzZWUg
YSBkaWFncmFtIGF0IGh0dHA6Ly91amViLnNlL0JtVElXLg0KPiA+IA0KPiA+IFRoZSBtYWluIHJl
YXNvbiB3ZSBtYXAgc2NlbmVzIHVzaW5nIGRlc3RpbmF0aW9uIGFkZHJlc3NlcyBpcyB0aGF0DQo+
ID4gc3VjaCBhDQo+ID4gc2V0dXAgY29uc3VtZXMgbXVjaCBsZXNzIHVuaWNhc3QgYWRkcmVzc2Vz
Lg0KPiA+IA0KPiA+IEFzc3VtaW5nIHRoYXQ6DQo+ID4gIFMgLSBudW1iZXIgb2Ygc3dpdGNoZXMN
Cj4gPiAgQiAtIG51bWJlciBvZiBidXR0b25zIChlbGVtZW50cykgb24gYSBzd2l0Y2gNCj4gPiAg
TiAtIG51bmJlciBvZiBsYW1wcw0KPiA+IA0KPiA+IFdpdGggYSAncmVndWxhcicgY2FzZSwgbnVt
YmVyIG9mIGNvbnN1bWVkIHVuaWNhc3QgYWRkcmVzc2VzIGlzDQo+ID4gICAgIFMqQiArIE4qKEIr
MSkNCj4gPiANCj4gPiBXaXRoIHRoZSBkZXN0aW5hdGlvbiBtYXBwaW5nLCBpdCBiZWNvbWVzDQo+
ID4gICAgIFMqQiArIE4qMg0KPiA+IA0KPiA+IFNpbmNlIHdlIHR5cGljYWxseSB1c2UgNCBidXR0
b24gc3dpdGNoZXMgKEI9NCksIHdpdGhvdXQgdHJhbnNsYXRpb24NCj4gPiB3ZQ0KPiA+IGNvbnN1
bWUgdW5pY2FzdCBhZGRyZXNzIHNwYWNlIGF0IGEgKm11Y2gqIGZhc3RlciByYXRlLg0KPiA+IA0K
PiA+IHJlYWdyZHMNCj4gDQo+IE9rYXksIHRoaXMgaXMgYSBnb29kIGFyZ3VtZW50IGZvciBleHBv
c2luZyB0aGUgc3Vic2NyaXB0aW9uIGFkZHJlc3MgaW4NCj4gTWVzc2FnZVJlY2VpdmVkKCkuDQo+
IEl0J3MgYmV0dGVyIHRvIHNlcGFyYXRlIHRoZSBtZXRob2QgaW50byB0d28sIGUuZy4gTWVzc2Fn
ZVJlY2VpdmVkKCkgYW5kDQo+IE1lc3NhZ2VSZWNlaXZlZFZpcnR1YWwoKS4NCg0KSSB3b25kZXIg
aWYgd2UgY291bGQgc3RpbGwgZG8gdGhpcyB3aXRoIGEgc2luZ2xlIG1ldGhvZC4gIEkgY2FuIHRo
aW5rDQpvZiAyIG1ldGhvZG9sb2dpZXM6DQoNCjEuIEEgc2ltcGxlIHdheSB0aGF0IGp1c3QgdXNl
cyB0aGUgVTE2IERTVCBmaWVsZCBpbnN0ZWFkIG9mDQp0aGUgInN1YnNjcmlwdGlvbiIgYm9vbGVh
biAobm90IGEgMTAwJSByZWxpYWJsZSBkaWZmZXJlbnRpYXRvcg0KZm9yIFZpcnR1YWxzLCBidXQg
bWF5IGJlIHN1ZmZpY2llbnQgZm9yIHRoZSB1c2UgY2FzZXMgZ2l2ZW4pLg0KDQoyLiBSZXBsYWNp
bmcgdGhlIHN1YnNjcmlwdGlvbiBib29sZWFuIHdpdGggYSB1MzIgIlN1YnNjcmlwdGlvbiBJRCIu
DQpBIHN1YnNjcmlwdGlvbiBJRCB2YWx1ZSBvZiAweDAwMDAwMDAwMCB3b3VsZCBpbmRpY2F0ZSB0
aGF0IHRoZQ0KbWVzc2FnZSB3YXMgcmVjZWl2ZWQgd2l0aCB0aGUgVW5pY2FzdCBhZGRyZXNzLCBh
bmQgdmFsdWVzIGZyb20NCjEgLSAweEZGRkZGRkZGIG1lYW4gYSBTdWJzY3JpcHRpb24gdGhhdCBj
YW4gYmUgcXVlcmllZCBmb3IuIFRoaXMNCndvdWxkIGJlIGFjY29tcGFuaWVkIGJ5IGEgbmV3IGRh
ZW1vbiBtZXRob2Qgd2hpY2ggY291bGQgbG9vayB1cA0KdGhlIGRldGFpbHMgb2YgdGhlIHN1YnNj
cmlwdGlvbjoNCg0KCXtkaWN0IHN1YmNyaXB0aW9ufSAgTG9va3VwU3Vic2NyaXB0aW9uKHUzMiBT
dWJfSUQpDQoNCkJvdGggb2YgdGhlc2UgbWV0aG9kb2xvZ2llcyB3b3VsZCBhbGxvdyBhbiBBcHAg
dG8gYmUgc2ltcGxlciwNCndpdGggbm8gYWRkZWQgRC1CdXMgTWV0aG9kcyByZXF1aXJlZC4NCg0K
V2l0aCB0aGUgMm5kIG1ldGhvZG9sb2d5LCB0aGUgc3Vic2NyaXB0aW9uIG9ubHkgbmVlZHMgdG8g
YmUNCmxvb2tlZCB1cCBvbmNlIChvciBub3QgYXQgYWxsKSB0byAxMDAlIGRpZmZlcmVudGlhdGUg
YmV0d2Vlbg0KZGlzY3JldGUgc3Vic2NyaXB0aW9ucy4NCg0KSSAqcmVhbGx5KiBkbyBub3Qgd2Fu
dCBhbiBhZGRpdGlvbmFsIG1hbmRhdG9yeSBBcHAgTWV0aG9kLiBNb3N0DQpBcHBzIHdpbGwgYmUg
c2ltcGxlciB0aGFuIHRoYXQsIGFuZCB0cnVlbHkgbm90IGNhcmUgdG8NCmRpZmZlcmVudGlhdGUg
YmV0d2VlbiBzdWJzY3JpcHRpb25zLi4uICAgUGFydGljdWxhcmlseSBDbGllbnQNCmJhc2VkIEFw
cHMuDQoNCj4gDQo+IFRoZW4gaXQgbWFrZXMgc2Vuc2UgdG8gYWRkIG1vZGVsIHN1YnNjcmlwdGlv
biBhcnJheSBhcyBhIGRpY3Rpb25hcnkNCj4gZW50cnkgaW4gdGhlIFVwZGF0ZU1vZGVsQ29uZmln
dXJhdGlvbigpIGFzIHdlbGwgYXMgZm9yIHRoZSBub2RlDQo+IGNvbmZpZ3VyYXRpb24gcmV0dXJu
ZWQgd2hlbiBjYWxsaW5nIEF0dGFjaCgpIG1ldGhvZC4NCj4gUHJvYmFibHkgd2lsbCBoYXZlIHRv
IGhhdmUgc2VwYXJhdGUga2V5czogIkdyb3VwcyIgYW5kICJWaXJ0dWFscyIuDQo+IA0KPiBSZWdh
cmRzLA0KPiBJbmdhDQo=
