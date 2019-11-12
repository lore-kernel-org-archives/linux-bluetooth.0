Return-Path: <SRS0=2Kq+=ZE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45BBC43331
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Nov 2019 18:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12E820578
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Nov 2019 18:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="lXKi0sOO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfKLSCP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Nov 2019 13:02:15 -0500
Received: from mga11.intel.com ([192.55.52.93]:22573 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726957AbfKLSCP (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Nov 2019 13:02:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2019 10:02:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,297,1569308400"; 
   d="scan'208";a="194400987"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga007.jf.intel.com with ESMTP; 12 Nov 2019 10:02:14 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 12 Nov 2019 10:02:13 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 12 Nov 2019 10:02:13 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 12 Nov 2019 10:02:13 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.50) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 12 Nov 2019 10:02:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsTN74k8kttD5Pnj86I7fJ3LLzQloKO56rKXkM4SL/OUg8eQywjhjjUlCUTM8ZKWL0YJyY7VG5I/Q8jxdGQnKeyk4lcynuK3V6+K7iB77gKPMV02P+j14rrMqaNLymCqDZ/anFJvYCFh6Bsvw20U+j3SCy2e6Te1+wftVkFNOKm43tLmRICLaCVRhwV3aQ8kFI63oM89AyNCra+rSdGQYYYbmnLc/rynk0b95rjHRdpF8BNsR87pYFtHNvRe5uQws4Ybwuw5saxirx5LsoaZYBuAqlXl93RjK8VaZs01QFe0U9kVXbpfmyvRbYQvwMfxzDPnsybBGIwJyjE3CbVbWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNPrQT6jDZrn5711OgJCb+OFJE7VzuTItmgYjGmeRus=;
 b=PiXdQLBLN6tOPOAsuYkUk6iDlT+zpntRC7FCnFf2kfDfj40PEs9wFY4BnPC16ywuQsoLfk/w00X99wyrqRxixvsOPDSiOF0xcvxSZ9sO3ZRa1YfpSAf539JIn6TjPpD3FMKg1QHa/Qq6MQAAOAhhaOfYipkJ1HK04tiLntwXfFZYOXgAVY5vj8deeHi3XUk2HjV+rZsLiME6V431SAA1x7QOoyd80PC88sruHJI3IxFqeBF1WXRK7b5nZjUwAOjR2YLKG4byBWXI8fAGiUnH5OH0A27DjblDAQSbNKDj/XMFWxHSbH32C0u8i9FNyecxb9LaxqQwBTdtuGgNl+MXbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNPrQT6jDZrn5711OgJCb+OFJE7VzuTItmgYjGmeRus=;
 b=lXKi0sOOAGOAtd4HnDvOfLxYCbemxBVkJuIpV6kUcFP0NfiVOAeumcgtcw4hG754BPdGOhrIJT3R41hru+ZQmuNTOxWNIyK65Ty/P+qLvauZXYBA8oikGKJqkT+Ik7g9WeYuW9sFynOJS/2HRjoDNvrAY1HdSbNN7dgXahrUXgs=
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com (10.172.76.7) by
 CY4PR1101MB2215.namprd11.prod.outlook.com (10.174.52.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Tue, 12 Nov 2019 18:02:10 +0000
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::44:eac4:f8c8:ad06]) by CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::44:eac4:f8c8:ad06%11]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 18:02:10 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "aurelien@aurel32.net" <aurelien@aurel32.net>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH Bluez] tools/mesh-cfgclient: add unbind command
Thread-Topic: [PATCH Bluez] tools/mesh-cfgclient: add unbind command
Thread-Index: AQHVmCZp8AnbPO8L0EW1488z5NSJIKeH1HyAgAAB0gA=
Date:   Tue, 12 Nov 2019 18:02:10 +0000
Message-ID: <460bb7df8bc91d3ad8f57e86a4c1a9d3d84c3b51.camel@intel.com>
References: <20191111002407.32575-1-aurelien@aurel32.net>
         <730d19357516db53d0fec28c932c774ed53fc88a.camel@intel.com>
In-Reply-To: <730d19357516db53d0fec28c932c774ed53fc88a.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [134.134.137.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c1f0ae7-486a-4181-9936-08d7679a7099
x-ms-traffictypediagnostic: CY4PR1101MB2215:
x-microsoft-antispam-prvs: <CY4PR1101MB22156D6F26F53134A286F310E1770@CY4PR1101MB2215.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(376002)(346002)(396003)(199004)(189003)(186003)(99286004)(6436002)(71190400001)(118296001)(25786009)(305945005)(486006)(6506007)(102836004)(76176011)(446003)(11346002)(26005)(7736002)(66066001)(476003)(2616005)(6512007)(6486002)(229853002)(256004)(71200400001)(6246003)(66556008)(66476007)(64756008)(81166006)(81156014)(66946007)(66446008)(8676002)(76116006)(14444005)(2906002)(6116002)(478600001)(3846002)(91956017)(2501003)(316002)(4001150100001)(36756003)(14454004)(8936002)(5660300002)(110136005)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1101MB2215;H:CY4PR1101MB2262.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xkoPfQBzSnG9a7DnowAz0PLGzld4CwUBGUWVBU5S6mVab712QdSh8Mav0vRAxZ9RRIMOwe9mm/Gu6Fb+chhiLpc5H9O6zL+rGX64v69fvPkogQ5jO7oPNM/lXQik70Q38n20h0FAvDwM2hFOu2fambMOWqN8boRL/OK7xZE0aym8/UICT7Vz2+kb3F7QdWUmzpYVvok0K8uXFpEDnZO/IUImekgUmUhXbYIwx5UzoMFsFIaZ/bwJtmFDdRppZf7mKwZTlSGAsD1e59pa3fF7Pyr5kHJcaU66o8Wb/EhwL/O6dZtmUlJCy2QXYzEhkKKf6SR7rKBvFTyXyuKFR2yumhjRN1Q9m3k6PcD00Nbnaoe3eo4vXKOmRowwwinQhjZ5vUZ6wH+1zQ//E17iiAHyyC2QfquqD5RKKzC/L4woLgrM1U3ksOrukJhoEK8cnVZ8
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C32F141F22A8F4881C3B685358AA546@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1f0ae7-486a-4181-9936-08d7679a7099
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 18:02:10.6364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iscfKHrt2dzdWTjIIIUmNsyJkXzzbgj3TD1+hz9+mzk8aW6ySmnVnGI9Y357N77YMkEr/FroATGrCj28airZKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2215
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QWN0dWFsbHkgYXBwbGllZCB2MiBvZiB0aGlzIHBhdGNoDQoNCk9uIFR1ZSwgMjAxOS0xMS0xMiBh
dCAxNzo1NSArMDAwMCwgR2l4LCBCcmlhbiB3cm90ZToNCj4gQXBwbGllZCwgVGhhbmtzDQo+IA0K
PiBPbiBNb24sIDIwMTktMTEtMTEgYXQgMDE6MjQgKzAxMDAsIEF1cmVsaWVuIEphcm5vIHdyb3Rl
Og0KPiA+IFRoaXMgaXMgYmFzaWNhbGx5IGEgY29weSBvZiBjbWRfYmluZCB3aXRoIE9QX01PREVM
X0FQUF9CSU5EIHJlcGxhY2VkIGJ5DQo+ID4gT1BfTU9ERUxfQVBQX1VOQklORCBhcyBjbWRzW10g
YWxyZWFkeSBoYXMgY29kZSB0byBoYW5kbGUgaXQuDQo+ID4gLS0tDQo+ID4gIHRvb2xzL21lc2gv
Y2ZnY2xpLmMgfCAzNiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDM2IGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEv
dG9vbHMvbWVzaC9jZmdjbGkuYyBiL3Rvb2xzL21lc2gvY2ZnY2xpLmMNCj4gPiBpbmRleCAwODY5
OTg5MTAuLmE0ZGU0Mjk0MyAxMDA2NDQNCj4gPiAtLS0gYS90b29scy9tZXNoL2NmZ2NsaS5jDQo+
ID4gKysrIGIvdG9vbHMvbWVzaC9jZmdjbGkuYw0KPiA+IEBAIC04OTcsNiArODk3LDQwIEBAIHN0
YXRpYyB2b2lkIGNtZF9iaW5kKGludCBhcmdjLCBjaGFyICphcmd2W10pDQo+ID4gIAlyZXR1cm4g
YnRfc2hlbGxfbm9uaW50ZXJhY3RpdmVfcXVpdChFWElUX1NVQ0NFU1MpOw0KPiA+ICB9DQo+ID4g
IA0KPiA+ICtzdGF0aWMgdm9pZCBjbWRfdW5iaW5kKGludCBhcmdjLCBjaGFyICphcmd2W10pDQo+
ID4gK3sNCj4gPiArCXVpbnQxNl90IG47DQo+ID4gKwl1aW50OF90IG1zZ1szMl07DQo+ID4gKwlp
bnQgcGFybV9jbnQ7DQo+ID4gKw0KPiA+ICsJcGFybV9jbnQgPSByZWFkX2lucHV0X3BhcmFtZXRl
cnMoYXJnYywgYXJndik7DQo+ID4gKwlpZiAocGFybV9jbnQgIT0gMyAmJiBwYXJtX2NudCAhPSA0
KSB7DQo+ID4gKwkJYnRfc2hlbGxfcHJpbnRmKCJCYWQgYXJndW1lbnRzXG4iKTsNCj4gPiArCQly
ZXR1cm4gYnRfc2hlbGxfbm9uaW50ZXJhY3RpdmVfcXVpdChFWElUX0ZBSUxVUkUpOw0KPiA+ICsJ
fQ0KPiA+ICsNCj4gPiArCW4gPSBtZXNoX29wY29kZV9zZXQoT1BfTU9ERUxfQVBQX1VOQklORCwg
bXNnKTsNCj4gPiArDQo+ID4gKwlwdXRfbGUxNihwYXJtc1swXSwgbXNnICsgbik7DQo+ID4gKwlu
ICs9IDI7DQo+ID4gKwlwdXRfbGUxNihwYXJtc1sxXSwgbXNnICsgbik7DQo+ID4gKwluICs9IDI7
DQo+ID4gKw0KPiA+ICsJaWYgKHBhcm1fY250ID09IDQpIHsNCj4gPiArCQlwdXRfbGUxNihwYXJt
c1szXSwgbXNnICsgbik7DQo+ID4gKwkJcHV0X2xlMTYocGFybXNbMl0sIG1zZyArIG4gKyAyKTsN
Cj4gPiArCQluICs9IDQ7DQo+ID4gKwl9IGVsc2Ugew0KPiA+ICsJCXB1dF9sZTE2KHBhcm1zWzJd
LCBtc2cgKyBuKTsNCj4gPiArCQluICs9IDI7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJaWYgKCFj
b25maWdfc2VuZChtc2csIG4sIE9QX01PREVMX0FQUF9VTkJJTkQpKQ0KPiA+ICsJCXJldHVybiBi
dF9zaGVsbF9ub25pbnRlcmFjdGl2ZV9xdWl0KEVYSVRfRkFJTFVSRSk7DQo+ID4gKw0KPiA+ICsJ
cmV0dXJuIGJ0X3NoZWxsX25vbmludGVyYWN0aXZlX3F1aXQoRVhJVF9TVUNDRVNTKTsNCj4gPiAr
fQ0KPiA+ICsNCj4gPiAgc3RhdGljIHZvaWQgY21kX2JlYWNvbl9zZXQoaW50IGFyZ2MsIGNoYXIg
KmFyZ3ZbXSkNCj4gPiAgew0KPiA+ICAJdWludDE2X3QgbjsNCj4gPiBAQCAtMTMzNSw2ICsxMzY5
LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBidF9zaGVsbF9tZW51IGNmZ19tZW51ID0gew0KPiA+
ICAJCQkJIkRlbGV0ZSBhcHBsaWNhdGlvbiBrZXkifSwNCj4gPiAgCXsiYmluZCIsICI8ZWxlX2Fk
ZHI+IDxhcHBfaWR4PiA8bW9kX2lkPiBbdmVuZG9yX2lkXSIsIGNtZF9iaW5kLA0KPiA+ICAJCQkJ
IkJpbmQgYXBwIGtleSB0byBhIG1vZGVsIn0sDQo+ID4gKwl7InVuYmluZCIsICI8ZWxlX2FkZHI+
IDxhcHBfaWR4PiA8bW9kX2lkPiBbdmVuZG9yX2lkXSIsIGNtZF91bmJpbmQsDQo+ID4gKwkJCQki
UmVtb3ZlIGFwcCBrZXkgZnJvbSBhIG1vZGVsIn0sDQo+ID4gIAl7Im1vZC1hcHBpZHgtZ2V0Iiwg
IjxlbGVfYWRkcj4gPG1vZGVsIGlkPiIsIGNtZF9tb2RfYXBwaWR4X2dldCwNCj4gPiAgCQkJCSJH
ZXQgbW9kZWwgYXBwX2lkeCJ9LA0KPiA+ICAJeyJ0dGwtc2V0IiwgIjx0dGw+IiwgY21kX3R0bF9z
ZXQsDQo=
