Return-Path: <SRS0=PvgB=3K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2B0C2D0CE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jan 2020 18:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272C22087E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jan 2020 18:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="IZOBRsIR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgAUSVg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jan 2020 13:21:36 -0500
Received: from mga06.intel.com ([134.134.136.31]:63927 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728186AbgAUSVg (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jan 2020 13:21:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 10:21:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,346,1574150400"; 
   d="scan'208";a="250341700"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga004.fm.intel.com with ESMTP; 21 Jan 2020 10:21:34 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 21 Jan 2020 10:21:33 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 21 Jan 2020 10:21:33 -0800
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 21 Jan 2020 10:21:33 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 21 Jan 2020 10:21:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3j6tLELqB6fLLgRQIRz2jbG40MO/qV4jWyw1pPts+/LH79JEgsNx6E/Q1H1daIcEDalxR4XkobCqzcl+ZxGkSj5PMhK+7VhsEPvuZcFquNjU3Qhxm1JkcfWVsQQKu+SbrZVXKGRoTpReKUqtelovH9U/+A70niSzayr16qTqdV/AiSqBdAuEn6PHbgHr2198fMiV9Q8Sy08l7CESU6zBr+TRLKkeCBzqkWVr5VGk62DlEkhirfQFk7XMfD+wcDoILULmQtyYJVRYQUb46+JSvBkVFYzIWN3UsCj/ROwcvRCNhrTsx+44QbXsLeLlmtpLv15WpK7y5yzQFHNTImgBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hJqkn69wnQT8mJbukSybElbl/Tk2Xxw8895kGzsh48=;
 b=lAy6af3UDTz7k2cAZd+wcVtlGRjrByoESOSkVF/IzxujA+2O00OQp+RhxBqanW5FM0/GbGBhhyi2NZByV/mPi+SBfOaHp0sA0cRQcuQqles+CcC+QpzHDNS0UttRHxA+/fuu8hCgCg0UeIEa0dpU7Uoii0VaMZTskEwMG1Z5ZjtcDsiKtDZlJN3yBpfsOc4mOe5zVaztgWWhPT7Vqi4F+44K0bjnFH8tXwfm0nVFENs8V3+BoekNestZEkB3awLk3eRurWCkunL4mJTpgBPo9ZhMTAndkupf8/i+5wFKIg+dWWPVHjKSpQjwEKU6BHujT8EhRMJUiEdfjo/hU3/nig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hJqkn69wnQT8mJbukSybElbl/Tk2Xxw8895kGzsh48=;
 b=IZOBRsIRuF38dRxWBmaHPQ0QqqZUj1L7GDeeVzS+Dc5FtoE+tV3iJac9wfVcTnmbvfFYtsuuftPjH61nVb6luzMhR+Rdx8Y+/krkKjfjhyp8zXFG4+GUmuRsqTLt3LZR2udnZNegOSJiVDUriEhE+JANFYK/FiGFBE50n4hTweo=
Received: from SN6PR11MB3520.namprd11.prod.outlook.com (52.135.124.204) by
 SN6PR11MB3181.namprd11.prod.outlook.com (52.135.109.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.24; Tue, 21 Jan 2020 18:21:28 +0000
Received: from SN6PR11MB3520.namprd11.prod.outlook.com
 ([fe80::ede7:c158:93c:ca45]) by SN6PR11MB3520.namprd11.prod.outlook.com
 ([fe80::ede7:c158:93c:ca45%7]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 18:21:28 +0000
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "Gix, Brian" <brian.gix@intel.com>,
        "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 0/3] Allow to reattach with new composition data
Thread-Topic: [PATCH 0/3] Allow to reattach with new composition data
Thread-Index: AQHVz6xZ1wAuAiW9hkm/QpVacksUA6fzy7aAgAEoo4CAAHt9AA==
Date:   Tue, 21 Jan 2020 18:21:28 +0000
Message-ID: <2565ef678df9e316ac980937f0f629aad83703b6.camel@intel.com>
References: <20200120161114.6757-1-jakub.witowski@silvair.com>
         <56b3aa902dee18a45e91d826344085cf1fb3ecca.camel@intel.com>
         <20200121105927.s2a3avh7tdcnf566@jwitowski2365>
In-Reply-To: <20200121105927.s2a3avh7tdcnf566@jwitowski2365>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=inga.stotland@intel.com; 
x-originating-ip: [134.134.139.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24f1ce8d-0302-4ee7-6280-08d79e9ebb62
x-ms-traffictypediagnostic: SN6PR11MB3181:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB3181DB7CA6D87FE72F55E55CFB0D0@SN6PR11MB3181.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(39860400002)(366004)(396003)(346002)(189003)(199004)(71200400001)(4326008)(26005)(6486002)(6512007)(6506007)(186003)(316002)(86362001)(110136005)(2616005)(478600001)(8936002)(66446008)(8676002)(81166006)(2906002)(66556008)(5660300002)(66946007)(91956017)(66476007)(64756008)(76116006)(36756003)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR11MB3181;H:SN6PR11MB3520.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pL1BkAdhLHtgDVbGqgttkruVeFcv+u8aFZzCidYiIxLVUdv+X7RM/3y3z7hjFLVUeQz+YFgr4jY0AXM3bSWDmWngo7Ax6Q+PkCEObTAt6k/gwNO9w7eNUhte7F5r/NUpLpPDdDzt6Qg3uqC5zgvJBb5AtU4VHbmVB/ywsGWkzSJJTg2RhpFbNjtbAP+t2MwoYSvf0mjUOhIopOK8X8QbvAmoeQ7EcZMlZH1oQcD4xT8RSlbj6jKkmn0Fynke+436wlXayW0VjgiY7ZY2MCewkJUB8T/ZmCB4HkYQAsIhy6LpvcAN+2NnTQKC6IOzjLLZRcaHQfoiazBjTZQvMpK9R2dIEWZBEMp57lXvVC2FqlLVaGABQT2e7UDFVnXM9IxG7bF7XGQKrepUAJge4TqSb1wIXK0T4RMj0V7Cm5sn1kLhaLYS8elxca6L6YHjoCog
Content-Type: text/plain; charset="utf-8"
Content-ID: <5BAFF1D1BCF87A4A955FD8A06051E8F1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f1ce8d-0302-4ee7-6280-08d79e9ebb62
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 18:21:28.0623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yx9yZAGJ1nsWz0E0FjoECRwIAmLfVWb8dQNcYqUs5n3IV2dKPdmqOQaJLQWctxRJtNHxW918bT4+G9KPPTJLrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3181
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgSmFrdWIsDQoNCk9uIFR1ZSwgMjAyMC0wMS0yMSBhdCAxMTo1OSArMDEwMCwgamFrdWIud2l0
b3dza2lAc2lsdmFpci5jb20gd3JvdGU6DQo+IE9uIDAxLzIwLCBHaXgsIEJyaWFuIHdyb3RlOg0K
PiA+IEhpIEpha3ViLA0KPiA+IA0KPiA+IGEgZmV3IHRoaW5ncy4uDQo+ID4gDQo+ID4gRmlyc3Qs
IHRoZSBzdWJqZWN0IGxpbmUgZm9yIHVzZXIgc3BhY2UgcGF0Y2hlcyBzaG91bGQgYWx3YXlzIGJl
IFtCbHVlWiBQQVRDSC4uLl0gdG8gZGlmZmVyZW50aWF0ZSBibHVlei5naXQNCj4gPiBwYXRjaGVz
IGZyb20ga2VybmVsIHBhdGNoZXMuDQo+IENvcnJlY3QsIHNvcnJ5IGZvciB0aGF0Lg0KPiANCj4g
PiANCj4gPiBBbHNvOiAgVGhlIHRpdGxlIG9mIHRoZSBwYXRjaCBzaG91bGQgYWx3YXlzIHN0YXJ0
IHdpdGggdGhlIGNvbXBvbmVudCBiZWluZyBtb2RpZmllZC4uLiBpbiB0aGlzIGNhc2UgDQo+ID4g
Im1lc2g6IEFsbG93IHJlYXR0YWNoLi4uIiBvciAidG9vbHMvbWVzaDogWFhYWCIgZm9yIGV4YW1w
bGUNCj4gPiANCj4gT2sNCj4gDQo+ID4gT24gTW9uLCAyMDIwLTAxLTIwIGF0IDE3OjExICswMTAw
LCBKYWt1YiBXaXRvd3NraSB3cm90ZToNCj4gPiA+IFRoaXMgcGF0Y2ggYWxsb3dzIHRoZSBhcHBs
aWNhdGlvbiB0byBtb2RpZnkgdGhlIENJRCwgUElELCBWSUQgYW5kIENSUEwgaW4gdGhlIGNvbXBv
c2l0aW9uIGRhdGEuDQo+ID4gDQo+ID4gVGhpcyB3aWxsIHJlcXVpcmUgc29tZSBkaXNjdXNzaW9u
LiAgIEN1cnJlbnRseSB3ZSBhcmUgcGxhbm5pbmcgYXQgKmxlYXN0KiB0byBtYWtlIENSUEwgZW50
aXJlbHkgdW5kZXIgdGhlDQo+ID4gY29udHJvbCBvZiBibHVldG9vdGgtbWVzaC5jb25mLCBiZWNh
dXNlIHRoaXMgaGFzIGEgc2lnbmlmaWNhbnQgZGFlbW9uIGltcGFjdC4NCj4gDQo+IE9rLCBJIGRv
bid0IGhhdmUgYSBwcm9ibGVtIHdpdGggdGhhdC4gSSBndWVzcyB0aGlzIGlzIGdvaW5nIHRvIGJl
aGF2ZSBpbg0KPiB0aGUgc2FtZSB3YXkgYXMgZmVhdHVyZSBiaXRzLCBhbmQgQ1JQTCB3aWxsIGRp
c2FwcGVhciBmcm9tIEFwcGxpY2F0aW9uMQ0KPiBwcm9wZXJ0aWVzIGFsdG9nZXRoZXI/DQoNCkkg
dGhpbmsgdGhhdCB0aGUgdmFsdWUgb2YgQ1JQTCBpbiB0aGUgY29uZmlnIGtleWZpbGUgc2hvdWxk
IGNvcnJlc3BvbmQNCnRvIHRoZSBtYXhpbXVtIENSUEwgdmFsdWUgdGhhdCB0aGUgbm9kZSBzdXBw
b3J0cy4gSWYgYW4gYXBwbGljYXRpb24NCnNwZWNpZmllcyBhbnl0aGluZyBncmVhdGVyIHRoYW4g
Y29uZmlnIHZhbHVlLCBpdCB3aWxsIGJlIGNhcHBlZC4NCg0KQXMgZmFyIGFzIGNoYW5naW5nIHRo
ZSB2YWx1ZSBvZiBDUlBMIGR5bmFtaWNhbGx5IChpLmUuLCBpbiBhcHAncw0KcHJvcGVydGllcyks
IHdlIG1heSBhbGxvdyBpdCwgYnV0ICpvbmx5KiBpZiB0aGUgbmV3IENSUEwgdmFsdWUgaXMNCmdy
ZWF0ZXIgdGhhbiB0aGUgcHJldmlvdXNseSBzcGVjaWZpZWQgb25lIChhZ2Fpbiwgc3ViamVjdCB0
byBiZSBjYXBwZWQNCmF0IG1heCkuDQoNCj4gDQo+ID4gDQo+ID4gVGhlIG90aGVyIHNldHRpbmdz
IEkgYW0gbm90IGFzIGNvbmNlcm5lZCBhYm91dC4uLiAgSWYgdGhlIHNwZWMgcmVhbGx5IGRvZXMg
YWxsb3cgdGhlaXIgYWx0ZXJhdGlvbiB0aG91Z2gsIEkgYW0NCj4gPiB3aWxsaW5nIHRvIGNvbnNp
ZGVyIHRoZW0uDQo+ID4gDQo+IA0KPiBJdCBkb2Vzbid0IGV4cGxpY2l0bHkgYWxsb3cgdGhlIHVw
ZGF0ZSwgYnV0IGRvZXNuJ3QgZm9yYmlkIGl0DQo+IGVpdGhlci4uLiBUaGVzZSB2YWx1ZXMgYXJl
IGFwcGxpY2F0aW9uIHByb3BlcnRpZXMsIGFuZCBwYXJ0aWN1bGFybHkgdGhlDQo+IFZJRCBjYW4g
Y2hhbmdlIGFmdGVyIHNvZnR3YXJlIHVwZ3JhZGUsIChldmVuIGlmIGVsZW1lbnQgbGF5b3V0IGRv
ZXNuJ3QsDQo+IHRoYXQgd291bGQgcmVxdWlyZSByZS1wcm92aXNpb25pbmcgZXRjLikuIFN1cHBv
cnRpbmcgdGhpcyBpcyB0aGUgbWFpbg0KPiB1c2UgY2FzZS4NCj4gDQoNCkkgd291bGQgc3Ryb25n
bHkgcHJlZmVyIG5vdCB0byBhbGxvdyBjaGFuZ2luZyBDSUQuIElzIHRoZXJlIGEgZ29vZA0KcmVh
c29uIHRvIGNoYW5nZSBDSUQgZXZlcj8NCkNoYW5naW5nIHByb2R1Y3QgSUQgYW5kIGVzcGVjaWFs
bHkgdmVyc2lvbiBJRCBhaG91bGQgYmUgZmluZS4NCg0KPiA+ID4gQWNjb3JkaW5nIHRoZSBNZXNo
IFByb2ZpbGUgKDIuMy40IEVsZW1lbnRzKSB0aGUgbW9kaWZpY2F0aW9uIG9mIGZpZWxkcyBvdGhl
ciB0aGFuICJFbGVtZW50cyIgaXMgbm90DQo+ID4gPiBwcm9oaWJpdGVkLg0KPiA+ID4gDQo+ID4g
PiBBbHNvIGluIG15IG9waW5pb24gKGFzIHlvdSBjYW4gc2VlIGluIHRoZSAxc3QgcGF0Y2gpLCB0
aGVyZSBpcyBubyBuZWVkIHRvIHVzZSBwb2ludGVyIHRvIHRoZSBub2RlX2NvbXBvc2l0aW9uDQo+
ID4gPiBzdHJ1Y3QuDQo+ID4gPiBUaGUgc3RhdGljIGlzIG1vcmUgY2xlYXIgYW5kIGxlc3MgcHJv
YmxlbWF0aWMuDQo+ID4gPiANCg0KQWdyZWUNCg0KPiA+ID4gSmFrdWIgV2l0b3dza2kgKDMpOg0K
PiA+ID4gICBtZXNoOiB1c2Ugc3RhdGljIG5vZGVfY29tcCBpbnN0ZWFkIG9mIHRoZSBwb2ludGVy
DQo+ID4gPiAgIG1lc2g6IGFkZCBjb21wb3NpdGlvbiBkYXRhIHNldHRlcg0KPiA+ID4gICBtZXNo
OiBhbGxvdyB0byByZWF0dGFjaCB3aXRoIG5ldyBjb21wb3NpdGlvbiBkYXRhDQo+ID4gPiANCj4g
PiA+ICBtZXNoL21lc2gtY29uZmlnLWpzb24uYyB8IDQ2ICsrKysrKysrKysrKysrKy0tLS0tDQo+
ID4gPiAgbWVzaC9tZXNoLWNvbmZpZy5oICAgICAgfCAgMiArDQo+ID4gPiAgbWVzaC9ub2RlLmMg
ICAgICAgICAgICAgfCA5NiArKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0t
LQ0KPiA+ID4gIDMgZmlsZXMgY2hhbmdlZCwgOTYgaW5zZXJ0aW9ucygrKSwgNDggZGVsZXRpb25z
KC0pDQo+ID4gPiANCg0KQmVzdCByZWdhcmRzLA0KSW5nYQ0K
