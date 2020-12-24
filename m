Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726D6C433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Dec 2020 17:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29130224B8
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Dec 2020 17:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgLXRwL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Dec 2020 12:52:11 -0500
Received: from mga06.intel.com ([134.134.136.31]:50098 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbgLXRwK (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Dec 2020 12:52:10 -0500
IronPort-SDR: 5wvcvUGkB+tjdSTCJrluJ4dwkDcDredtnakOC/Xg5B7F+lDZOPN8XOpkFGzPhIfHVD53I9tLgE
 Nl7KdwxTQKMg==
X-IronPort-AV: E=McAfee;i="6000,8403,9845"; a="237723328"
X-IronPort-AV: E=Sophos;i="5.78,444,1599548400"; 
   d="scan'208";a="237723328"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2020 09:51:29 -0800
IronPort-SDR: DNtkFTJf/kkljy7wvXIDx1DtqQX7TyRz+b3NpWXkL1CYSGJtOr8hKmybTcPO+K9eixKrZzkB4X
 NPzCWm3HSNlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,444,1599548400"; 
   d="scan'208";a="417692366"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 24 Dec 2020 09:51:29 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 24 Dec 2020 09:51:29 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 24 Dec 2020 09:51:29 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 24 Dec 2020 09:51:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UELcans6S93paz+tDcOHPsNgLA+lzaSyzmEGWL4q2PXirA2tIY4f/UVfLeukKTY6hMDUQgBStn8hoBzbbDpbUjrFyFw5uP1GsRFbBUX1fNLa1nMTxUPMoEx92+2JaUInjaNbH2F/RuhbAoJBVcEel/WWDntSGkyijpe31Yb/lYeTzNf30XwLVuYIUD0DaeoQ1gz4BO6NPGyYTp5yKIoaB7D82Zg2BAlZumiSPFYyHOEN6Z2OWosDzsJLFqvjIUkbciP8zCATufLJxstrKGKdTK3m/pQlCX/ZXp5seQv8jy0FN1a5RDUo3FGyOOJ/3TfLQHYvvZcw7PkWzLtcR7/MUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tg4zlD5s/vgElcWH66yDgsn5/JU+jlts5jmztriqHuQ=;
 b=EMdtadGnvVMqyQhS78/1RmdB9vUldQ3qrME/E2P4ZAki5v/4AwA/UcZcDXwn+mg6U//R6XjemmUzfoFcjZKBpAVvnehb5RG2E2Do8Lrbx9+0eczUKFJ3mJUv5UZK6UOGN9FyF+KuEOnknjFl997LS5e/KOQcWs4mdswAHCuCca5XO3M6qpbBKBmk0S9cwpgciIJGv2Eqv7OPkGT7KoBbNzFgL3wQ4aRBRmCnSO05wyIX6Qw2PUy2xzBSa8jxB/Qhvn/hG08824+dHDeeLlB6qqAKNQ8Pj69nP9kQDvK1D6E+WWNIA5dhIS6xTpLmX7wCELg2QObFWBbyUIdsWfgRxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tg4zlD5s/vgElcWH66yDgsn5/JU+jlts5jmztriqHuQ=;
 b=NYzMgWUkDoTNKXdvDWRWO8RImGYuUC+0HfP+1DPI44uEEal9KL1Y9D0KcSrP2G9JR43uvK08ABzSgHuRnHOOCLt54lg0ri9mf88qnCWqtxDjWDxsmJHIoNf/SjOpUHDHNz1JF59W4gHwxtS7nbjUiVuFHf/Mm81KGiSdo4SElpA=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR11MB1902.namprd11.prod.outlook.com (2603:10b6:300:10f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Thu, 24 Dec
 2020 17:51:28 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::30c6:ea80:eabe:2aab]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::30c6:ea80:eabe:2aab%7]) with mapi id 15.20.3700.026; Thu, 24 Dec 2020
 17:51:28 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "sbrown@ewol.com" <sbrown@ewol.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: mesh: call to Publish triggers apparent output loop in
 mesh/mesh-io-generic.c
Thread-Topic: mesh: call to Publish triggers apparent output loop in
 mesh/mesh-io-generic.c
Thread-Index: AQHW2HtfgBvxZgyQSE6rNxnBNumU7qoDc23QgAKIc4CAAI34AA==
Date:   Thu, 24 Dec 2020 17:51:28 +0000
Message-ID: <55fa643ff2275a6b5c965bceaf8c78a953fccb31.camel@intel.com>
References: <cf925daf120458a23798be054865d1e39068f7b5.camel@ewol.com>
         <MW3PR11MB45394DC567668E8D0AD2081CE1DF0@MW3PR11MB4539.namprd11.prod.outlook.com>
         <b4a13800dc869d85c9d5fba9c91483da954f286c.camel@ewol.com>
In-Reply-To: <b4a13800dc869d85c9d5fba9c91483da954f286c.camel@ewol.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: ewol.com; dkim=none (message not signed)
 header.d=none;ewol.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.137.75]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca6d407d-ee06-4f24-a5cf-08d8a8348a57
x-ms-traffictypediagnostic: MWHPR11MB1902:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1902F66CFBF8F2C14A897A06E1DD0@MWHPR11MB1902.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mq5ndAZx+CT5Jh0MjZmGL6oJtMD7w8pOhHB70Bf917eAt5MqSDpsl7m2TBMQ+ZUu6J1IdJdATlBv4AMr1SU6tvKQswNmIAtWmxEt7hACG1EwamvQT4wLxZLK4SqPZkNTHWFywbudxxGHV4jHSrVzTH8x1wwg9MtsJ6q0e6xWRswUjIVMmxPeLin4JyH3evQNGaZW5ZY28BPgz78LYEf5ao8zaMYWTLny85zQxsBgp03dVxTuVG7DF7lSCm3B8k60yqFHQS16vNFOJ+K/dKJTs8SD5Qcp3SgM7bLrfh+/c3iiw/Rtu+FXwIa3U3+vWeLKuYknwJekq5CxASvpFucSEIGVVSgEdoN0LxhHPJDQ6LITrqgu9+ygxZFiNY3K/y78zWeV6Eys8HKTqW9OoAgNW5p5DzWXJJInf7i8T8wlnyjzlAsKcqi54AhklVvWgM3f
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(2906002)(8676002)(478600001)(8936002)(71200400001)(6486002)(186003)(53546011)(6506007)(26005)(4001150100001)(316002)(110136005)(107886003)(66946007)(5660300002)(36756003)(66446008)(64756008)(66556008)(86362001)(83380400001)(76116006)(66476007)(6512007)(2616005)(4326008)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?akoyS2FUK1QwWHZlQWhwQ2VMdVFobitDSGFjcnBKWENVaHJaWkM5eThQWlVJ?=
 =?utf-8?B?bzNBTGRGRms1UXRicm0yTGpFWk9wdk9IMS9lZHEzTUsvZGh1ODVLUWl3eHdH?=
 =?utf-8?B?VWVzM1lnYkNLNXpTUlVXdkZrZkFvSlRCOHFPMVhXaXQ1VkFlMmRNVHdIT1Z3?=
 =?utf-8?B?NVhIVkV3dnNkbzZCYVJBcWlnSktHR0lsT0xNdWVZb1ZpVHZ2Mm56YkhzZEdn?=
 =?utf-8?B?Smg1L0h5Vy8vVWVhRjlEWEJBYVJESDMxaVRuMWE2Ti81eGk5YVRtOVZ1cysv?=
 =?utf-8?B?UHhubVE4VVZQNzE4aGZEMGtFVnRXSHFCeGdZYjY2OTRvSXl1bC9BRjRvRHMz?=
 =?utf-8?B?MWFuMTBmK1hHbjZRMFNvcERRVEo1L2QzSmZMVElhMWtkZ09MaDh3QWQ4MkxE?=
 =?utf-8?B?ZEIzV1VHcGlYZkN2VW91ckI2SEsrWFBWQlJCYVdYSmdNVTh0dUhsci9ENjhB?=
 =?utf-8?B?NVpIZjNFcGFhV0ZoYllpcXg3WFYyWWxXK2V1UkNvOUxXbVNJaUNBNFVuczRh?=
 =?utf-8?B?ajJqa2NJWVpnc1gxbm8yWklwVERIMVkzeC9SUTMxc2JFT1BkN2Rpb0t4R0xL?=
 =?utf-8?B?T29iemlTK2QxRW9OclpsOXFXdmdzK2Z3bDV2aDlyVHJxS3ptMkZObmVUVitM?=
 =?utf-8?B?L050UTJWdVJ5aWtFRyt6Nk1UQVpFZkF5aU12WDdhQmcyc2w4b0c0dndKWTJL?=
 =?utf-8?B?a2U0d0tDcVU1WTZPSmtDTTVhMG1OOFBnTElFRmZaZStLSE1jN2t1RGdmajZ0?=
 =?utf-8?B?ZHVaWE1wM1JCVHF5aWZ4bFRuUUdsQTdIbTVNWE43RUszaER3ekUzNlV3Sk40?=
 =?utf-8?B?d29iY0lSTFhjam9kTWtHeldZVXU1RDZLcWVQeS82WTRrTXMwT2xVK1ZycEZq?=
 =?utf-8?B?ekI3c3BVU2ViSFV1YWo0OWlZcTRiN0ovaVRaSktic3Nsa2EvS0pqUFJqVXh3?=
 =?utf-8?B?OTZHb2l0UVdVcVFlcHZ6SHVpYmY1Z2pVUTZaanNwcGZTN21EekVueVZVRDdz?=
 =?utf-8?B?QmRocmJjd2lFdW55TzQwbGNyQWFFTnU3aUk0bzlsd2JkOS8zc2d0VnFLZ3da?=
 =?utf-8?B?WmtZQUxmbGNmQldNSVRtSmNTakJrQjl4eFgwK3AxM0RJTnJDSFhDNTYrQ2Z3?=
 =?utf-8?B?bi9rR0NxeG40eUd6QWVwaDdsUmlpR3ZWM2kweDVMZ0hkSDh4bmlsZThsL3hF?=
 =?utf-8?B?K0ljNjhVRXJmMUtxek0yMW5nblpXekswYTlIMmtBejZKenBIODA0SzlVZ3FV?=
 =?utf-8?B?dndraHVlYndralQvN2U4L3ZJeEcwWGUrZm5ZMmxZREdoV0xZYjJnL0x4b0FR?=
 =?utf-8?Q?70LuM1lAVKG195LEg/uPnNtAC7Yc3/6WRG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <664AB9856F68D046AE42918100794957@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6d407d-ee06-4f24-a5cf-08d8a8348a57
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2020 17:51:28.4605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: //sowWlSbc/p97vkuLtx0570UcQL5ZK8xI/fswkNwitFJ59UcrrrzWHWRfMmNvoItqUztB1SgmmJnzmygoWRAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1902
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

T24gVGh1LCAyMDIwLTEyLTI0IGF0IDA0OjIzIC0wNTAwLCBTdGV2ZSBCcm93biB3cm90ZToNCj4g
SGkgQnJpYW4sDQo+IA0KPiBPbiBUdWUsIDIwMjAtMTItMjIgYXQgMTg6NDMgKzAwMDAsIEdpeCwg
QnJpYW4gd3JvdGU6DQo+ID4gSGkgU3RldmUsIEkgd2lsbCBpbnZlc3RpZ2F0ZSBvbiBteSBSUEk0
DQo+ID4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBTdGV2ZSBC
cm93biA8c2Jyb3duQGV3b2wuY29tPiANCj4gPiBTZW50OiBUdWVzZGF5LCBEZWNlbWJlciAyMiwg
MjAyMCA3OjU3IEFNDQo+ID4gVG86IGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmcNCj4g
PiBTdWJqZWN0OiBtZXNoOiBjYWxsIHRvIFB1Ymxpc2ggdHJpZ2dlcnMgYXBwYXJlbnQgb3V0cHV0
IGxvb3AgaW4NCj4gPiBtZXNoL21lc2gtaW8tZ2VuZXJpYy5jDQo+ID4gDQo+ID4gUHVibGlzaCBm
dW5jdGlvbnMgYXMgZXhwZWN0ZWQsIGJ1dCByZXN1bHRzIGluIGNvbnRpbnVvdXMsIHZlcnkgaGVh
dnkNCj4gPiBIQ0kgdHJhZmZpYyAofmV2ZXJ5IC43bXMgcGVyIGJ0bW9uIGxvZykuIEkgZG9uJ3Qg
dGhpbmsgaXQncyBteQ0KPiA+IGFwcGxpY2F0aW9uIGFzIHRoZSBwcm9ibGVtIHBlcnNpc3RzIGFm
dGVyIHRoZSBhcHBsaWNhdGlvbiBkaXNjb25uZWN0cw0KPiA+IGZyb20gZGJ1cyBhbmQgZXhpdHMu
DQo+ID4gDQo+ID4gVGhlIGNhbGxzIHRvIExFIFNldCBBZHYgUGFyYW0gYWxsIGZhaWwuIFByaW9y
IHRvIHRoZSBQdWJsaXNoIGNhbGwsIExFDQo+ID4gU2V0IFBhcmFtIGNhbGxzIHN1Y2NlZWQuIFRo
ZSBvbmx5IGRpZmZlcmVuY2UgSSBjYW4gc2VlIGlzIHRoZSBmYWlsaW5nDQo+ID4gb25lcyBoYXZl
IGFuIGludGVydmFsIG9mIDUwbXMgYW5kIHRoZSBvbmVzIHRoYXQgc3VjY2VlZCBoYXZlIDEwMG1z
LiBBDQo+ID4gc3VjY2Vzc2Z1bCBvbmUgaXMgYXBwZW5kZWQuDQo+ID4gDQo+ID4gSSdtIGF0IGN1
cnJlbnQgQmx1ZXogaGVhZCAoNjUyMzE4OTJjZCkuIFRoZSBwbGF0Zm9ybSBpcyBhIHJwaTQuIA0K
PiA+IA0KPiA+IEJlbG93IGlzIGEgcHJldHR5IG5vcm1hbCBsb29raW5nIG1lc2hkIGxvZywgYSBi
dG1vbiBkdW1wIGFuZCBzb21lDQo+ID4gbW9yZQ0KPiA+IG5vcm1hbCBsb29raW5nIGRidXMgdHJh
ZmZpYy4NCj4gPiANCj4gPiBTdGV2ZQ0KPiANCj4gSSB0aGluayBJIGZvdW5kIG15IHByb2JsZW0u
IE15IHJldHJhbnNtaXQgY291bnQgd2FzIHNldCB0byB6ZXJvLg0KDQoNClRoYXQncyBhIGdvb2Qg
Y2F0Y2gsIFN0ZXZlLiAgVGhlIENOVCB2YWx1ZSBmcm9tIHRoZSBQdWJsaXNoIG1lc3NhZ2UgaXMg
c3VwcG9zZWQgdG8gYmUgdGhlIG51bWJlciBvZiAqUkUqIC0NCnRyYW5zbWlzc2lvbnMsIG5vdCB0
aGUgdG90YWwgbnVtYmVyIG9mIHRyYW5zbWl0cy4gIDAgaXMgc3BlY2lhbCBjYXNlZCBpbnRlcm5h
bGx5IGFzICJJbmZpbml0ZSIsIHNvIHdlIG5lZWQgdG8NCmFkZCAxIHRvIHRoZSBDTlQgdmFsdWUg
Zm9yIHRoZSBhY3R1YWwgdG90YWwgdHJhbnNtaXNzaW9ucy4NCg0KSSB3aWxsIHRhbGsgd2l0aCBJ
bmdhIHRvIHNlZSB3aGVyZSB3ZSB3YW50IHRvIG1ha2UgdGhpcyB0d2Vlay4NCg0KPiANCj4gSWYg
dGhlIHB1Ymxpc2ggcmV0cmFuc21pdCBjb3VudCBpcyAwLCBtZXNoLWlvLWdlbmVyaWMuYzp0eF90
bygpIHJlcGVhdHMNCj4gdGhlIG1lc3NhZ2UgaW5kZWZpbml0ZWx5LiBIb3dldmVyLCA0LjIuMi42
IG9mIHRoZSBtZXNoIHByb2ZpbGUgc3BlYw0KPiBWMS4wIHNlZW1zIHRvIHN0YXRlIHRoYXQgMCBt
ZWFucyBubyByZXRyYW5zbWlzc2lvbnMuDQo+IA0KPiBTdGV2ZQ0KPiANCj4gDQo=
