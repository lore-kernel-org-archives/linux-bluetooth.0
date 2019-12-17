Return-Path: <SRS0=Cjqc=2H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CC4C43603
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Dec 2019 19:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93DD2082E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Dec 2019 19:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="qXKs95ca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfLQTBl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Dec 2019 14:01:41 -0500
Received: from mga18.intel.com ([134.134.136.126]:10371 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbfLQTBl (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Dec 2019 14:01:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 11:01:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,326,1571727600"; 
   d="scan'208";a="209801800"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga008.jf.intel.com with ESMTP; 17 Dec 2019 11:01:30 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 17 Dec 2019 11:01:30 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Dec 2019 11:01:29 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 17 Dec 2019 11:01:29 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.52) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 17 Dec 2019 11:01:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfGre40WLSyrDuUfElXB50+saxicxSg3duUfJUyjXJ+YooDnB7IhIPPgEW9SE+LsDYP+oOBbyuaLbUdVcdJ52vcRQ6RBRvAxubOgURWy5UzJyyKTmViCrwQAFUcdLjVHKS4yZ7Cs6jlAGtsg24xDMqjAcS8oeiLSvEoQbVy8oQtng25cIFmj9VYHJTHhQct0gh2/wGIwE6Y17xURX72bB2ASkJlcHgYeEtyvFEj44ireHUplUEB2+Q4ejhDVQejU6Ku89wR4twZJyi2OOQT+F6kU8K43yXHkdR7Gz4DjK5joid7F8a7/saXgaovzl/zgurKVLmr4Kjoj+G0dEfPioQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vf/EwXRK3Eo7OoA4yTlD0pxtyi1W/8hgbleeIIiOi5k=;
 b=hj668eW/IC76D+Yg8T6oc2Trg9BdK7D1NdiNdeczqewVhahhpX+JQfLy2bvr8qY7vFpyRFuG6VcwrOQPeJZOTvXLiO7VyZlaXlC7P94SfJU/+iteQjoyYZm0y7zuqotgVQs4vhWCCwBjDGJUq8HH5V0ZSYBkMesbeE4iWR9yK8cwnJQOCIsALeuufRdWspdNCWj2mbz4psCP06n7mC9gKnBfFkJZa40sOQ3vlmDnOIQG/JouqbIxDyI5BWcfDe3KKfV+My+PLnpqXBEfDytG6cYNgf2D5TCvmFBMc+svpmw5FGehfZLmKutXRdriTyVJcYb63UBw1teCwE9ofFAnSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vf/EwXRK3Eo7OoA4yTlD0pxtyi1W/8hgbleeIIiOi5k=;
 b=qXKs95cahAIcTebpDhSAjKJuXXhzp4x0kVCP+PA86PaZIF/ZNfDvkoWgd/HNrHYe5Un0KVdO24KZfGyJlMgbmhgu12gEVI+Cv0xQggDaTjGZeb7TU56Hz2dDaiDbsr7cAqoHr8oCWJtwQ5b8cwLWJ/0lf6DTbPeEl7CTST9uul8=
Received: from CY4PR11MB1269.namprd11.prod.outlook.com (10.173.16.11) by
 CY4PR11MB1781.namprd11.prod.outlook.com (10.175.80.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Tue, 17 Dec 2019 19:01:13 +0000
Received: from CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::39e0:30e9:a8b0:fe24]) by CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::39e0:30e9:a8b0:fe24%3]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 19:01:13 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: mesh: Handling application failures on Create/Join/Import
Thread-Topic: mesh: Handling application failures on Create/Join/Import
Thread-Index: AQHVtQn6uV8/TznPHkeEUzvQD9wTFae+qsgAgAAClACAAAFCAA==
Date:   Tue, 17 Dec 2019 19:01:13 +0000
Message-ID: <d61fcfad45256fe70b0f8cfaba30e031f57d3ce9.camel@intel.com>
References: <20191217184330.coc6c7b7hw4to6vx@kynes>
         <20191217184728.qoapokv7acfyaz33@kynes>
         <a51a523c15b52b9e5d837b7b9a1110a669db4e2b.camel@intel.com>
In-Reply-To: <a51a523c15b52b9e5d837b7b9a1110a669db4e2b.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5db4e9b5-72ed-41e8-e712-08d783237cd6
x-ms-traffictypediagnostic: CY4PR11MB1781:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB1781BF316B3159991B6F9451E1500@CY4PR11MB1781.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(39830400003)(136003)(366004)(189003)(199004)(8676002)(5660300002)(186003)(8936002)(81166006)(26005)(91956017)(36756003)(6512007)(6486002)(64756008)(66556008)(81156014)(71200400001)(86362001)(4326008)(110136005)(66446008)(66476007)(66946007)(6506007)(2616005)(316002)(478600001)(107886003)(76116006)(2906002)(4001150100001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR11MB1781;H:CY4PR11MB1269.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3pNkuABVmI/bMC2AqvY64odErUEa66Up4uTQdj3YdbPA3yjjpOIoAWKHXVjzmdvbH6nXhZXFDOLiZK37Efb9B1zYFt5vCCUfnyXymFux7cU8uzydFuMlX2GhuA6ZcZ84mwc1YinLb7U86FT4Ec+iSG4/JsouZWTgBAArOn9Pq1887YFsxXOW5JrUjannFS20TjOSMe8NZz2ZcybyGE7h9nsWwidno6miw8lA3jmcebpdatLleQN7Lnhx+44DSekgVyJn2GOg+XqvflSPZGjtQQlb+oB5Cpt/fkIvaIFUJDPU75rYefBqMCUfFUFTGfjyNUro0SyPWdHaiOnPjYSXByZka6D9ZuyF72Yx6vjYPuJEwa/hdy5yfVukSwSXAiSjLinnR4ZqJmzAvMc5l8iwVuWiPYoO9L62IicoJOziiPxKGXYoX19XWHdiJPn+Qfmb
Content-Type: text/plain; charset="utf-8"
Content-ID: <1659ACFA3ED4D74BA3C4EE222A0D071C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db4e9b5-72ed-41e8-e712-08d783237cd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 19:01:13.6537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LNUBY+58siRl8xpxbq8I29OeUTZelfeBuqGyJYrfEZM3lhvv7o4DbmYKnmg7pAZ/eme4aotgy2FY+FNoqdRjKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1781
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

T24gVHVlLCAyMDE5LTEyLTE3IGF0IDE4OjU2ICswMDAwLCBHaXgsIEJyaWFuIHdyb3RlOg0KPiBI
aSBNaWNoYcWCLA0KPiANCj4gT24gVHVlLCAyMDE5LTEyLTE3IGF0IDE5OjQ3ICswMTAwLCBNaWNo
YcWCIExvd2FzLVJ6ZWNob25layB3cm90ZToNCj4gPiBPbiAxMi8xNywgTWljaGHFgiBMb3dhcy1S
emVjaG9uZWsgd3JvdGU6DQo+ID4gPiBJIHdvdWxkIGxpa2UgdG8gZGlzY3VzcyBwb3NzaWJsZSBz
b2x1dGlvbnMgdG8gdGhpcy4gDQo+ID4gPiANCj4gPiA+IE9uZSBvZiB0aGUgaWRlYXMgaXMgdG8g
Z2l2ZSB0aGUgYXBwbGljYXRpb24gc29tZSB0aW1lIHRvIHN1Y2Nlc3NmdWxseQ0KPiA+ID4gQXR0
YWNoKCkgaXRzZWxmIHRvIHRoZSBuZXcgbm9kZSwgb3RoZXJ3aXNlIGl0IGdldHMgcmVtb3ZlZC4N
Cj4gDQo+IE5vdCBhbGwgbm9kZXMgbmVlZCB0byBiZSBhdHRhY2hhYmxlLi4uICBGb3IgaW5zdGFu
Y2UsIGEgbm9kZSB0aGF0IGlzIG9ubHkgdXNlZCBmb3IgZnJpZW5kc2hpcCwgcmVsYXlpbmcgb3IN
Cj4gYmVhY29uaW5nIGNhbiBleGlzdCB3aXRob3V0IGV2ZXIgYmVpbmcgYXR0YWNoZWQgdG8uLi4g
IHNvIHJlcXVpcmluZyBhbiBBdHRhY2goKSBzaG91bGRuJ3QgYmUgYSByZXF1aXJlbWVudC4NCg0K
SSB0aGluayBvbmUgcGllY2Ugb2YgZnVuY3Rpb25hbGl0eSB0aGF0IHdlIGhhdmUgKm5vdCogeWV0
IHRlc3RlZCBpcyBOb2RlIFJlc2V0LiAgSWYgYSBDb25maWcgQ2xpZW50IHNlbmRzIGENCk5vZGUg
UmVzZXQgdG8gYW4gIk9ycGhhbmVkIE5vZGUiLCB1c2luZyB0aGF0IG5vZGVzIERldmljZSBLZXks
IHRoZSBkYWVtb24gc2hvdWxkIGJlIGNsZWFuaW5nIHVwIGFsbCBvZiBpdCdzDQpzdG9yYWdlLg0K
DQo+IA0KPiA+ID4gQW5vdGhlciBwb3NzaWJpbGl0eSB3b3VsZCBiZSB0byByZW1vdmUgImNyZWF0
ZWQgYnV0IG5ldmVyIGF0dGFjaGVkIiBub2RlcyBvbg0KPiA+ID4gZGFlbW9uIHJlc3RhcnQuDQo+
ID4gDQo+ID4gT3IgbWF5YmUgY2hhbmdlIHRoZSB0b2tlbiBmbG93IGEgYml0IGFuZCBpbnN0ZWFk
IG9mIHN0cmFpZ2h0IHJldHVybiwNCj4gPiBtYWtlIHRoZSBkYWVtb24gY2FsbCBKb2luQ29tcGxl
dGUgaW4gYWxsIDMgY2FzZXMsIGV4cGVjdGluZyBhIGNhbGwNCj4gPiByZXR1cm4gZnJvbSB0aGUg
YXBwbGljYXRpb24/DQo+ID4gDQo+ID4gSWYgSm9pbkNvbXBsZXRlIGNhbGwgZmFpbHMsIG5vZGUg
Y291bGQgYmUgZHJvcHBlZC4NCj4gPiANCj4gDQo+IEkgdGhpbmsgdGhlIEFwcGxpY2F0aW9uIGRv
ZXMgbmVlZCB0byB0YWtlIHJlc3BvbnNpYmlsaXR5IGZvciB0aGUgdG9rZW4sIG9uY2UgaXQgcmVj
ZWl2ZXMgaXQuLi4gIElmIHRoZSBjYWxsDQo+IChvcg0KPiByZXNwb25zZSkgdGhhdCBkZWxpdmVy
cyB0aGUgdG9rZW4gdG8gdGhlIEFwcCBmYWlscywgdGhlIG5vZGUgc2hvdWxkIGJlIGRlbGV0ZWQs
IGJ1dCB0aGUgdG9rZW4gaXMgY29uc2lkZXJlZA0KPiBzZW5zaXRpdmUgZW5vdWdoIHRoYXQgd2Ug
bG9jayBkb3duIGFjY2VzcyB0byBpdCBhcyB0aWdodCBhcyBwb3NzaWJsZS4gIElmIGl0IGlzIGlu
YWR2ZXJ0YW50bHkgbGVha2VkLCB0aGVuDQo+IHdob2V2ZXIgZ2V0cyBpdCBoYXMgYWxsIHRoZSBh
YmlsaXRpZXMgb2YgdGhlIG5vZGUsIHNvIHdlIG1pbmltaXplIHdobyBzZWVzIGl0Lg0KPiANCj4g
DQo=
