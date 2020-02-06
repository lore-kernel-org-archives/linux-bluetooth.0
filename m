Return-Path: <SRS0=lv0E=32=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3ECC33CAC
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Feb 2020 17:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690C9218AC
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Feb 2020 17:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="l1f+sLI8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbgBFR33 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Feb 2020 12:29:29 -0500
Received: from mga04.intel.com ([192.55.52.120]:35991 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgBFR32 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Feb 2020 12:29:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 09:29:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,410,1574150400"; 
   d="scan'208";a="432288776"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga006.fm.intel.com with ESMTP; 06 Feb 2020 09:29:28 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 6 Feb 2020 09:29:27 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 6 Feb 2020 09:29:27 -0800
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 6 Feb 2020 09:29:27 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 6 Feb 2020 09:29:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChsFxdR5qWQz2nJFGHTq9KmiP0R///xfHAvJBn0HnuwOLM2hUwZ3YGQDhpxM8G5vT3Fj2efPqN4mn8dxbqKz07w/gKvebuJnEa4MJ40S8wLRfRuQL/uQ4/LFIxn4RTzh94Xvpl99FIncJWHPg2/4X4bjnuUOfM8LwJneAN0WhzDsSe/EV3pSfWx4OwFX/i7U4iSwExkZ3eXljDFn/uFLCcx/E+DDqgOzBn9yGyubS9RXIzo1ZBlmdylM3h69qa0G1BiSc2807WCb0SyiSkH44DDXsmD3aX7VIUcLoXCiHIlgH/Wx5OmlC5CLLJAmGqxrVfIV6vlvo3pNE5Zb6E4Dxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcSUWJhKaiQAWLQHQ/TfnePlYFxSOfytdWqBt/1Kq/M=;
 b=L1ZFl9EIoWQM5mSOc14bBF93yqPvMP0uBoP6F6RCZhEFXjyC2KRWtzhG2Czt+5Y4XBZqPUMypXPXK4OjMi15FJYA44wv2g8XmahmWrw1OofUh4yGW/2swNQdB21j4o2105IEhuB4mUM550s3mOnkCJP/cjF6haJ3xFaQuX1prntMGM9+vwLwKuOQwho7c5MVTodfzIauqkSuyvyhA4zsZmdvGkWNwnSSwCfkcodxMRL//cF7Z/O3h0ywPc+Y06FjLt7HCihvVhgSTIxLkbPFDMM/F38mIs4AMmd4MFUNZNKoecR2KFZn1sBCh2biqtJF01u2+v+nFxu0iZQBDq6H4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcSUWJhKaiQAWLQHQ/TfnePlYFxSOfytdWqBt/1Kq/M=;
 b=l1f+sLI84Nc29Ux5vQ4vK7WbCM11X5Y6uBsBdBHkssLZ7h4e73c6QH3MTwwTWJ4AbYRfqnfN7qIDbUqGs1NsBBvAFDuHFx2tDksLBP3NshelAyZPjd19GsLMCtQmtDtO0zJoCQvIBpYEd9Fj1e4i19NokjCrEw+5zjtJWz4C0cE=
Received: from BN7PR11MB2580.namprd11.prod.outlook.com (52.135.246.155) by
 BN7PR11MB2580.namprd11.prod.outlook.com (52.135.246.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Thu, 6 Feb 2020 17:29:23 +0000
Received: from BN7PR11MB2580.namprd11.prod.outlook.com
 ([fe80::c8ca:3c11:3fc5:a9d6]) by BN7PR11MB2580.namprd11.prod.outlook.com
 ([fe80::c8ca:3c11:3fc5:a9d6%6]) with mapi id 15.20.2707.024; Thu, 6 Feb 2020
 17:29:22 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: mesh: Missing API for delivering provisioning public key via OOB?
Thread-Topic: mesh: Missing API for delivering provisioning public key via
 OOB?
Thread-Index: AQHV3RE1tvVONgrRRU6X1g5gg4omB6gOasIAgAABCwA=
Date:   Thu, 6 Feb 2020 17:29:22 +0000
Message-ID: <e07c9ba29c42f8a97c4f74a27a5252e00c97a44d.camel@intel.com>
References: <20200206171600.227uzfonhepltydy@kynes>
         <cd23abb8286bfa1bd8ac2ea5eabeeaa98dd39888.camel@intel.com>
In-Reply-To: <cd23abb8286bfa1bd8ac2ea5eabeeaa98dd39888.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [134.134.137.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cfeb9071-e7e8-449b-bada-08d7ab2a1b32
x-ms-traffictypediagnostic: BN7PR11MB2580:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR11MB2580227DBE8F412D49CF862BE11D0@BN7PR11MB2580.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(199004)(189003)(2616005)(64756008)(66476007)(91956017)(66446008)(66556008)(76116006)(66946007)(110136005)(8936002)(8676002)(81156014)(81166006)(107886003)(498600001)(6512007)(86362001)(4326008)(26005)(186003)(2906002)(71200400001)(5660300002)(6506007)(6486002)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR11MB2580;H:BN7PR11MB2580.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +G8c4XNtnJl8RPkOs4OKvOfY2U65eIkF8MZl8PdAHAZuF6lLxkGbPNfLgLgpVUvkXWtkWqQ5boufQaj3PXRyKGoswl32r/JdKfooxzjIx5qiXGq/+zzv4ywVXdwqv9cvSsjsfLTmxNOaUn+pIRDP2rn+8MnrjGqm44kSLCADm8PT8ZsRERSZR0IVx1JsePrxxUgD+TcEoWR81wOP4HTdB2en+Dm9SuSCF5yEyCFFklVS0jNXl/41RARmV9dbRzaVNLU7RNAqc0Z68wAWvmvknq1R7gVbCjTi+/yZhUQyBCLWjs64z69+PXr05oTEvWxBqegjn2ofaQTzCK9Lq/8mXj7aNLK76Y1WbkY2E3OGwqZfd4m3QQzhCn74EUI9rjS3BMEOkCSWGCrb7E03DibhH04C3+DtlO4hh4Tz/+r0PZwFi2/zWU0l88sMpJJTALGO
x-ms-exchange-antispam-messagedata: KflhGMp7p8O4+GZf1K5DbmHRVNUDXH0FYCYUF3mreKHSHEnaz/VkChFJHeG9Bi+PGj9nTMTECpKHjPwB6ulrytQ/mR7zvRrGd5/keyz9HwPVbWM5sjqeJQEwOhVLMXbXpb8TBk4n8Vluzd+Jo1oINA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DD80470A9DDB94CBAB7BDCE176305FD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cfeb9071-e7e8-449b-bada-08d7ab2a1b32
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 17:29:22.8210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Mmpg1FsCwoC8tg8rEPxoz1+v+rrqvIQq8EzLiHfuhQZrjlrqEZhY+BYYxATLepjybrsBu4lnU9+8/tSQjJJUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2580
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

T24gVGh1LCAyMDIwLTAyLTA2IGF0IDE3OjI1ICswMDAwLCBHaXgsIEJyaWFuIHdyb3RlOg0KPiBI
aSBNaWNoYcWCLA0KPiANCj4gT24gVGh1LCAyMDIwLTAyLTA2IGF0IDE4OjE2ICswMTAwLCBNaWNo
YcWCIExvd2FzLVJ6ZWNob25layB3cm90ZToNCj4gPiBIaSwNCj4gPiANCj4gPiBJIGhhdmUgYmVl
biBwbGF5aW5nIHdpdGggbWVzaC1jZmdjbGllbnQsIGFuZCBJJ3ZlIG5vdGljZWQgdGhhdA0KPiA+
IHByb3Zpc2lvbmluZyBwcm9jZWR1cmUgZ2V0cyBzdHVjayB3aGVuIG5vZGUgcmVwb3J0cyBQdWJs
aWMgS2V5IE9PQg0KPiA+IGluZm9ybWF0aW9uIGF2YWlsYWJsZScgaW4gJ1B1YmxpYyBLZXkgVHlw
ZScgZmllbGQgb2YgUHJvdmlzaW9uaW5nDQo+ID4gQ2FwYWJpbGl0aWVzIFBEVS4NCj4gPiANCj4g
PiBXaGlsZSBkaWdnaW5nIGludG8gdGhlIGNvZGUgYW5kIEFQSSwgSSB0aGluayB3ZSBoYXZlIGEg
bWlzc2luZyBmZWF0dXJlDQo+ID4gaW4gdGhlIEFQSSBiZXR3ZWVuIHByb3Zpc2lvbmVyIGFwcGxp
Y2F0aW9uIGFuZCB0aGUgZGFlbW9uIC0gd2hpbGUgdGhlcmUNCj4gPiBpcyBhbiBBUEkgdG8gZGVs
aXZlciBPT0Iga2V5cyB0byB0aGUgZGFlbW9uIHdoZW4gKnRoZSBhcHBsaWNhdGlvbiogaXMNCj4g
PiBiZWluZyBwcm92aXNpb25lZCwgdGhlcmUgZG9lc24ndCBzZWVtIHRvIGJlIGEgd2F5IHRvIGRl
bGl2ZXIgcHJvdmlzaW9uZWQNCj4gPiBkZXZpY2UncyBwdWJsaWMga2V5IHdoZW4gaXMgdGhlIGFw
cGxpY2F0aW9uIHdobyBkb2VzIHRoZSBwcm92aXNpb25pbmcuDQo+ID4gDQo+ID4gSXMgbXkgdW5k
ZXJzdGFuZGluZyBjb3JyZWN0LCBvciBpcyB0aGVyZSBzb21ldGhpbmcgSSd2ZSBtaXNzZWQ/DQo+
IA0KPiBZZXMuLi4gSXQgbG9va3MgbGlrZSB0b29scy9tZXNoLWNmZ2NsaWVudC5jIG5lZWRzIHRv
IGltcGxlbWVudCB0aGU6DQo+IA0KPiAJYXJyYXl7Ynl0ZX0gUHVibGljS2V5KCkNCj4gDQo+IG1l
dGhvZC4NCj4gDQo+IFRoaXMgaXMgYSBnb29kIGNhdGNoLCBhbmQgbmVlZHMgdG8gYmUgYWRkZWQu
DQoNCkFuZCBiZWZvcmUgeW91IHJlc3BvbmQsIHllcyBpdCBhbHNvIG5lZWRzIHRvIGJlIGFkZGVk
IHRvIG1lc2gvYWdlbnQuYw0KDQoNCj4gICANCj4gDQo+ID4gcmVnYXJkcw0K
