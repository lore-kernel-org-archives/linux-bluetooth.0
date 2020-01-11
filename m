Return-Path: <SRS0=d6qz=3A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A90C282DD
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Jan 2020 00:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA26220842
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Jan 2020 00:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="bXt2adBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgAKAxc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jan 2020 19:53:32 -0500
Received: from mga04.intel.com ([192.55.52.120]:23130 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727762AbgAKAxc (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jan 2020 19:53:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 16:53:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,419,1571727600"; 
   d="scan'208";a="218820051"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga008.fm.intel.com with ESMTP; 10 Jan 2020 16:53:30 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 10 Jan 2020 16:53:30 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 10 Jan 2020 16:53:30 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 10 Jan 2020 16:53:30 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 10 Jan 2020 16:53:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSNq4QfGLwjJlAKudTLlxVjiNwhplFSYR2B3GSSrxWmZ8iCiCh/e5J1jBq6EqyGMfjNs/zfyR5RI7IQ2kGBjH8JtOhUOJMXQKs76DiTc4//SrLIQAG8YLb8ZUm8YpdBHqb+d+qd3jNtJLhAEvuPEhZWGapRpO3Qg/2tchskta8iSQFCRkFN/zOJjNFkJ+oJ51oJ45Ji7rNrtzDHA+x1BDrZzRGFChNHJXtLTdcPMOyWfNyVVvAekjpMr/cOOtKwNuU4PJV5d3PntLXWk+KPp8lg6nYzhWc8CagEa3SFkP+CH6CmwyQr4p+epHdBPSTTQYPX0EbKFyH9gJGvZK251/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvLGy0zNzCxKbRCTqdQkCdnHviL+zoO2zl2ms8Bw6Oo=;
 b=hMMPpmDm90Rc1hXC5u/HX6cIf7a3aXQF8m889cPGmp2ER5dS6/QbT6Z8dULTf4IT7dY94Dn5PzdU9ElYxoTJdpNvnp9UJpIUONnA60hO0PxyVZiHOO8wHa0E9D4yyDRqqn8e+51lVVB3TUYD8Rc6ugQFuYqPWnLuAzEcmVNuuNu8RazIh+KBDA4jYbvM5oHEmS8h0Hofdn16bcWs5kL3ltmSoiYjoD5fNU7XJkTnliAC+stJylhkrDsK6ML9WU59MWjMuHwUxbscmsfyHvphrR8RaaRZrOY8ZFc6NnlEaIbVD3+HjQUhVWmOzN9v29/fSvZZdAwwaDejSSS0sPzFwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvLGy0zNzCxKbRCTqdQkCdnHviL+zoO2zl2ms8Bw6Oo=;
 b=bXt2adBTxsXNEgGs28Ejo5kf2xkcbTrwjjeSBQRMY8/tjNsLzIXJwhGh3RSqlIR1vPCBafW/IUQRHyTk4hh8bqKJ85Govd9rmju6Y15UyGuxjpwpAy8DF0rWkqva+1JcZRZzXgzqxXvqV4/SIyUkIL6WmrqieEw+iExxey4Eyo0=
Received: from CY4PR11MB1269.namprd11.prod.outlook.com (10.173.16.11) by
 CY4PR11MB1575.namprd11.prod.outlook.com (10.172.72.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Sat, 11 Jan 2020 00:53:15 +0000
Received: from CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::5b2:92c7:da12:1876]) by CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::5b2:92c7:da12:1876%7]) with mapi id 15.20.2623.010; Sat, 11 Jan 2020
 00:53:15 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Implement provisioning loop-back
Thread-Topic: [PATCH BlueZ] mesh: Implement provisioning loop-back
Thread-Index: AQHVx+ICowIo2R57NEGK1gPHCFoXH6fkkMeAgAASdYA=
Date:   Sat, 11 Jan 2020 00:53:15 +0000
Message-ID: <e2042727d45c227344bc1ded696b28b66bb45a93.camel@intel.com>
References: <20200110181437.31167-1-brian.gix@intel.com>
         <20200110234709.ihnstfmahenstspp@kynes>
In-Reply-To: <20200110234709.ihnstfmahenstspp@kynes>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55544ee3-3b3e-46d9-ace3-08d79630a407
x-ms-traffictypediagnostic: CY4PR11MB1575:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB157554CF559CFA235799D3D2E13B0@CY4PR11MB1575.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0279B3DD0D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(376002)(346002)(189003)(199004)(6486002)(6512007)(107886003)(8936002)(54906003)(478600001)(86362001)(4326008)(316002)(26005)(6506007)(81156014)(186003)(8676002)(2616005)(81166006)(71200400001)(36756003)(6916009)(66446008)(76116006)(91956017)(2906002)(66476007)(66946007)(66556008)(5660300002)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR11MB1575;H:CY4PR11MB1269.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ys+RNgOdqyOs3q+2MeshSvE8cUlePC8HMUj/vcUSxG+jCcukjsurTee8BkDVGGkx+mEPaRaYgZ0iiU5pik6mcvnAxq6PFaedFhgJAKKBVmZr1qO6MCO9vpbjCWLcuvkltZmGWLh2dydO1zI5yLGM7MiscFFak9UsteRT0TbCdfoBl5cvJaPJRnQxQuChfhgukoCFWTl6JNYO4/1/A2rJ1dBV7gbsXpIFcgcibUoH2l696jgxd0hnIAw7izcIrsAE/jEOzkbZSpycyXXhrJDUHpSwA8YeDRof9Z+xBCacyMIW+dvFGiw8XMPqVJFC71diqtW276sYrvPu0NgIMDrsFEsNO84EwcUQruoOAuVRzZMmh3zp46U1S0UhQiDDT8JsMVn+OBqnA3498UI83Tg87AaO/FjpAJs71E4cBNFGKn6npD9VETRfjNOVHT4fK4i3
Content-Type: text/plain; charset="utf-8"
Content-ID: <B6F92A005899924DBA6A8CDB2B95DAD7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 55544ee3-3b3e-46d9-ace3-08d79630a407
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2020 00:53:15.0437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4+Np6ic/WDU97FAsgFwsO0lGZw81ejLJgR3pFqSzIHVpYslgFLvqXSQcyNKH7k+EVCQPkvmiwxWE/hVD4wZliQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1575
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

T24gU2F0LCAyMDIwLTAxLTExIGF0IDAwOjQ3ICswMTAwLCBNaWNoYcWCIExvd2FzLVJ6ZWNob25l
ayB3cm90ZToNCj4gSGkgQnJpYW4sDQo+IA0KPiBPbiAwMS8xMCwgQnJpYW4gR2l4IHdyb3RlOg0K
PiA+IFRoaXMgYWxsb3dzIG9uZSBBcHAgdXNpbmcgdGhlIG1lc2ggZGFlbW9uIHRvIHByb3Zpc2lv
biBhbm90aGVyLg0KPiANCj4gVGhpcyBwYXRjaCBjb250YWlucyBhbHNvIHNvbWUgd29yZGluZyBj
b3NtZXRpY3MgYW5kIG90aGVyIFBCLUFEViBmaXhlcw0KPiB0aGF0IGRvbid0IHNlZW0gcmVsYXRl
ZCB0byB0aGUgbG9vcGJhY2sgbWVjaGFuaXNtLg0KPiANCj4gQ291bGQgeW91IHBsZWFzZSBzcGxp
dCB0aGlzIGludG8gYSBwYXRjaHNldD8NCg0KU3VyZSwgSSB3aWxsIGxvb2sgYXQgdGhpcy4NCg0K
PiA+ICguLi4pDQo+ID4gKwlpZiAoc2Vzc2lvbi0+bG9vcCkNCj4gPiArCQlsb29wX2FkdihzZXNz
aW9uLT5sb29wLCBidWYsIGluaXRfc2l6ZSArIDEwKTsNCj4gPiArCWVsc2UNCj4gPiArCQltZXNo
X3NlbmRfcGt0KE1FU0hfSU9fVFhfQ09VTlRfVU5MSU1JVEVELCAyMDAsDQo+ID4gKwkJCQkJCQli
dWYsIGluaXRfc2l6ZSArIDEwKTsNCj4gDQo+IFRoaXMgY29uZGl0aW9uIGNoZWNrIGlzIHJlcGVh
dGVkIHRocm91Z2hvdXQgdGhlIGNvZGUuIEkgdGhpbmsgaXQgd291bGQNCj4gYmUgY2xlYXJlciB0
byByZXBsYWNlIG1lc2hfc2VuZF9wa3QgdXNhZ2VzIHdpdGggc29tZXRoaW5nIGxpa2U6DQoNClll
YWgsIEkgY2FuIHByb2JhYmx5IGRvIHRoaXMuLi4gIE9uZSByZWFzb24gSSBkaWRuJ3Qgd2FzIGJl
Y2F1c2Ugb2YgdGhlIGNvdW50L2ludGVydmFsIGRpZmZlcmVuY2VzIGZyb20gcGFja2V0DQp0byBw
YWNrZXQsIGJ1dCBzdXJlIEkgY291bGQgYWRkIGEgbGV2ZWwgb2YgbmVzdGluZyB0aGVyZS4uLg0K
DQo+IA0KPiBzdGF0aWMgdm9pZCBwYl9hZHZfc2VuZChzdHJ1Y3QgcGJfYWR2X3Nlc3Npb24gKnNl
c3Npb24sIHVpbnQ4X3QgY291bnQsDQo+IAkJCQl1aW50MTZfdCBpbnRlcnZhbCwgdm9pZCAqZGF0
YSwgdWludDE2X3QgbGVuKQ0KPiB7DQo+IAlpZiAoc2Vzc2lvbi0+bG9vcCkgew0KPiAJCXN0cnVj
dCBpZGxlX3J4ICpyeCA9IC4uLg0KPiAJfSBlbHNlIHsNCj4gCQltZXNoX3NlbmRfcGt0KGNvdW50
LCBpbnRlcnZhbCwgZGF0YSwgbGVuKTsNCj4gCX0NCj4gfQ0KPiANCg==
