Return-Path: <SRS0=HCMd=3D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932C4C33CB1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 14:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B93E2467D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 14:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="n+2tTXag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgANOlx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jan 2020 09:41:53 -0500
Received: from mga18.intel.com ([134.134.136.126]:24832 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728791AbgANOlw (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jan 2020 09:41:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 06:41:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,433,1571727600"; 
   d="scan'208";a="305162771"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga001.jf.intel.com with ESMTP; 14 Jan 2020 06:41:51 -0800
Received: from fmsmsx162.amr.corp.intel.com (10.18.125.71) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Jan 2020 06:41:50 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx162.amr.corp.intel.com (10.18.125.71) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Jan 2020 06:41:50 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 14 Jan 2020 06:41:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Za7Vqn4KsOn6VC9hcio+30d/EanPb2MuzMq25H2QhjRmPoFdtbQcNHYm/dbjzTPfiP/7lY6AXLnwMp1x0Kj9FyvS3b+TYSR1bqGI7laNWUXJfT66hoeNt+n6kqM4S0RzwBmOqZJxWKjgLzf02RPROKI7GNWZIJj0e/nGI/S858WTnSfXMiYByzyb5JLL/Mmwaalu+lCbTmgDdQEt4He+M/vQM4IbruIPCU6UbLqYozXfH5GH9BResTcu6jUcq5SPpVHa0WSzwmQcvqhEWi3XfjdY/ihWFhH5XR4yhAr2o8cUvVaq382IbDGA7i7BH7m77feciEM/yXP3XYfOPzZI8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcjH3GOpZ1wWFMfOe4Xjs/kT3E9PrXWZBU5qhV6aOsM=;
 b=ZPSAGjDftAq04oN2Pw1MNXwFQY1HX9ee8lzwKZcQHrLFQCOjsJQTmC8tcQ46/KyAxOeqgfzCGzUoX1vxdO8sS8ikHalK+5nryvfjZGJE5VJHijIpBSZ+W54xbayKodCWvG97XT8F3LukA31n8fXXYCe1ITI0HPwISSaGwqrRvfRd5HEIU3aOQHf5kCeZ7SQIVNMdod8DciMHcYPZoJ6t9sp8E2JgNhxG5m0iVOytG02pvWPQDP0hlqVsyqJmwVPOdfLTw8Gu1/1Q9CYcqwAmmDf0Vgrvt533BfD+M1PeF4PObjZe4BGhzYDXncXYpfE5p9QVtJoxbMtgvOSDNaBqSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcjH3GOpZ1wWFMfOe4Xjs/kT3E9PrXWZBU5qhV6aOsM=;
 b=n+2tTXagBYcfZ5Jt870Y7b+3J85Tm7ByRS2N0QnkwXlIF+seheknMmZn5cRU8rU/WwQhMHYXZU7jHL/ZNEZXPuYJslrXUnCi2eZf60w6hfNQSoXl/VBjJE0HAeLLLJOl9dBM7p1kEcPTy6iqgTAmxDroheCQgmJdwZWXjpB0Vos=
Received: from MWHPR11MB1664.namprd11.prod.outlook.com (10.172.54.13) by
 MWHPR11MB1805.namprd11.prod.outlook.com (10.175.56.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Tue, 14 Jan 2020 14:41:48 +0000
Received: from MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e]) by MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e%6]) with mapi id 15.20.2623.017; Tue, 14 Jan 2020
 14:41:48 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] tools/mesh: add commands for AppKey Get and NetKey
 Get
Thread-Topic: [PATCH BlueZ] tools/mesh: add commands for AppKey Get and NetKey
 Get
Thread-Index: AQHVx2LJEUoFJQY790ugi66+C9ZJLKfqQroA
Date:   Tue, 14 Jan 2020 14:41:48 +0000
Message-ID: <d13c97c94c1c98e2c56b3e9eb8e4c67032211b4e.camel@intel.com>
References: <20200110030440.5725-1-inga.stotland@intel.com>
In-Reply-To: <20200110030440.5725-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c698cbe5-338f-4d59-0a29-08d798ffe30f
x-ms-traffictypediagnostic: MWHPR11MB1805:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB18051EFBD8D9A0F6BBFF3A14E1340@MWHPR11MB1805.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:126;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(346002)(366004)(376002)(189003)(199004)(6506007)(478600001)(6486002)(36756003)(91956017)(66476007)(6636002)(8936002)(81156014)(8676002)(76116006)(81166006)(71200400001)(2616005)(6512007)(66946007)(110136005)(2906002)(66556008)(5660300002)(64756008)(66446008)(86362001)(186003)(316002)(26005)(2004002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR11MB1805;H:MWHPR11MB1664.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z4P1Jjx8zAnSsV4fZtJPdR/ma8lSZ3GNogO1uBNqybV2RSWpKye4jBT1OcF0Yngyq0753c8dHAmFJb603dTc8WvUUVNf46JpQUYf9tHXtZRqOojpAi3Vf+u/1dGrx4C1fE9RHRJJqo9NR8BivMgj3Dlev5/dXm4lLJu5x1EU67TjqtKXSLXpD/eBM7TvgGp1CY1PY+sSdLuF1AiBUTfdO/KaH4PkrT2TY2MOqLT+SzAP8sMIlzfHtmwyvBD0aOF4QGebZYInKDll2e/0XqnBKcGehDdhBUojS+ep9swp3leOaS/NBfAKEKUKGiLV7yCQObaL3JhsDzlJ5JgVW4O7YnOZWU/RI3KcupbIHmJZ13CJWDkToRLDIsyCC+XoDQQD6kVNz2t/mJ1bGWb+T3wmbSpBIcormvz36z+vrgh5XojOSbdcl7Km08G6feq5hiEp/SA5RIUxNTTHhjPv14XXM8xNKwqju+FmfrwYlfWcy+Q=
Content-Type: text/plain; charset="utf-8"
Content-ID: <30C3CE4903BDED449A2FA448B05B0300@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c698cbe5-338f-4d59-0a29-08d798ffe30f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 14:41:48.9270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xzRxWGYrmCfeaCSsHa9pNVNI78gM/JFqgNT9eMR+zWNTFRkw+vh5IieTQ9qefXjTljSNXU82ZQIXvIKVIM2e4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1805
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gVGh1LCAyMDIwLTAxLTA5IGF0IDE5OjA0IC0wODAwLCBJbmdhIFN0b3RsYW5k
IHdyb3RlOg0KPiBUaGlzIGltcGxlbWVudHMgY29tbWFuZHMgdG8gc2VuZCBBcHBLZXkgR2V0IGFu
ZCBOZXRLZXkgR2V0IG1lc3NhZ2VzIGFuZA0KPiB0byBwcm9jZXNzIEFwcEtleSBMaXN0IGFuZCBO
ZXRLZXkgTGlzdCByZXBvbnNlcw0KPiAtLS0NCj4gIHRvb2xzL21lc2gvY2ZnY2xpLmMgfCAxMDAg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCA5MSBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL3Rvb2xzL21lc2gvY2ZnY2xpLmMgYi90b29scy9tZXNoL2NmZ2NsaS5jDQo+IGluZGV4IDI0
MDNjOTI5My4uNTBkMmNlNzA2IDEwMDY0NA0KPiAtLS0gYS90b29scy9tZXNoL2NmZ2NsaS5jDQo+
ICsrKyBiL3Rvb2xzL21lc2gvY2ZnY2xpLmMNCj4gQEAgLTIsNyArMiw3IEBADQo+ICAgKg0KPiAg
ICogIEJsdWVaIC0gQmx1ZXRvb3RoIHByb3RvY29sIHN0YWNrIGZvciBMaW51eA0KPiAgICoNCj4g
LSAqICBDb3B5cmlnaHQgKEMpIDIwMTkgIEludGVsIENvcnBvcmF0aW9uLiBBbGwgcmlnaHRzIHJl
c2VydmVkLg0KPiArICogIENvcHlyaWdodCAoQykgMjAxOS0yMDIwICBJbnRlbCBDb3Jwb3JhdGlv
bi4gQWxsIHJpZ2h0cyByZXNlcnZlZC4NCj4gICAqDQo+ICAgKg0KPiAgICogIFRoaXMgbGlicmFy
eSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3INCj4gQEAg
LTQwNiw2ICs0MDYsMzMgQEAgc3RhdGljIGJvb2wgbXNnX3JlY3ZkKHVpbnQxNl90IHNyYywgdWlu
dDE2X3QgaWR4LCB1aW50OF90ICpkYXRhLA0KPiAgDQo+ICAJCWJyZWFrOw0KPiAgDQo+ICsJY2Fz
ZSBPUF9BUFBLRVlfTElTVDoNCj4gKwkJaWYgKGxlbiA8IDMpDQo+ICsJCQlicmVhazsNCj4gKw0K
PiArCQlidF9zaGVsbF9wcmludGYoIkFwcEtleSBMaXN0IChub2RlICU0LjR4KSBTdGF0dXMgJXNc
biIsDQo+ICsJCQkJCQlzcmMsIG1lc2hfc3RhdHVzX3N0cihkYXRhWzBdKSk7DQo+ICsJCWJ0X3No
ZWxsX3ByaW50ZigiTmV0S2V5ICUzLjN4XG4iLCBsX2dldF9sZTE2KCZkYXRhWzFdKSk7DQo+ICsJ
CWxlbiAtPSAzOw0KPiArDQo+ICsJCWlmIChkYXRhWzBdICE9IE1FU0hfU1RBVFVTX1NVQ0NFU1Mp
DQo+ICsJCQlicmVhazsNCj4gKw0KPiArCQlidF9zaGVsbF9wcmludGYoIkFwcEtleXM6XG4iKTsN
Cj4gKwkJZGF0YSArPSAzOw0KPiArDQo+ICsJCXdoaWxlIChsZW4gPj0gMykgew0KPiArCQkJYnRf
c2hlbGxfcHJpbnRmKCJcdCUzLjN4XG4iLCBsX2dldF9sZTE2KGRhdGEpICYgMHhmZmYpOw0KPiAr
CQkJYnRfc2hlbGxfcHJpbnRmKCJcdCUzLjN4XG4iLCBsX2dldF9sZTE2KGRhdGEgKyAxKSA+PiA0
KTsNCj4gKwkJCWxlbiAtPSAzOw0KPiArCQkJZGF0YSArPSAzOw0KPiArCQl9DQo+ICsNCj4gKwkJ
aWYgKGxlbiA9PSAyKQ0KPiArCQkJYnRfc2hlbGxfcHJpbnRmKCJcdCUzLjN4XG4iLCBsX2dldF9s
ZTE2KGRhdGEpKTsNCj4gKw0KPiArCQlicmVhazsNCj4gKw0KPiAgCWNhc2UgT1BfTkVUS0VZX1NU
QVRVUzoNCj4gIAkJaWYgKGxlbiAhPSAzKQ0KPiAgCQkJYnJlYWs7DQo+IEBAIC00MzIsNiArNDU5
LDI2IEBAIHN0YXRpYyBib29sIG1zZ19yZWN2ZCh1aW50MTZfdCBzcmMsIHVpbnQxNl90IGlkeCwg
dWludDhfdCAqZGF0YSwNCj4gIA0KPiAgCQlicmVhazsNCj4gIA0KPiArCWNhc2UgT1BfTkVUS0VZ
X0xJU1Q6DQo+ICsJCWlmIChsZW4gPCAyKQ0KPiArCQkJYnJlYWs7DQo+ICsNCj4gKwkJYnRfc2hl
bGxfcHJpbnRmKCJOZXRLZXkgTGlzdCAobm9kZSAlNC40eCk6XG4iLCBzcmMpOw0KPiArDQo+ICsJ
CXdoaWxlIChsZW4gPj0gMykgew0KPiArCQkJbmV0X2lkeCA9IGxfZ2V0X2xlMTYoZGF0YSkgJiAw
eGZmZjsNCj4gKwkJCWJ0X3NoZWxsX3ByaW50ZigiXHQlMy4zeFxuIiwgbmV0X2lkeCk7DQo+ICsJ
CQluZXRfaWR4ID0gbF9nZXRfbGUxNihkYXRhICsgMSkgPj4gNDsNCj4gKwkJCWJ0X3NoZWxsX3By
aW50ZigiXHQlMy4zeFxuIiwgbmV0X2lkeCk7DQo+ICsJCQlkYXRhICs9IDM7DQo+ICsJCQlsZW4g
LT0gMzsNCj4gKwkJfQ0KPiArDQo+ICsJCWlmIChsZW4gPT0gMikNCj4gKwkJCWJ0X3NoZWxsX3By
aW50ZigiXHQlMy4zeFxuIiwgbF9nZXRfbGUxNihkYXRhKSAmIDB4ZmZmKTsNCj4gKw0KPiArCQli
cmVhazsNCj4gKw0KPiAgCWNhc2UgT1BfTU9ERUxfQVBQX1NUQVRVUzoNCj4gIAkJaWYgKGxlbiAh
PSA3ICYmIGxlbiAhPSA5KQ0KPiAgCQkJYnJlYWs7DQo+IEBAIC04MTgsNiArODY1LDMyIEBAIHN0
YXRpYyB2b2lkIGNtZF9hcHBrZXlfZGVsKGludCBhcmdjLCBjaGFyICphcmd2W10pDQo+ICAJcmV0
dXJuIGJ0X3NoZWxsX25vbmludGVyYWN0aXZlX3F1aXQoRVhJVF9TVUNDRVNTKTsNCj4gIH0NCj4g
IA0KPiArc3RhdGljIHZvaWQgY21kX2FwcGtleV9nZXQoaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkN
Cj4gK3sNCj4gKwl1aW50MTZfdCBuOw0KPiArCXVpbnQ4X3QgbXNnWzMyXTsNCj4gKw0KPiArCWlm
IChJU19VTkFTU0lHTkVEKHRhcmdldCkpIHsNCj4gKwkJYnRfc2hlbGxfcHJpbnRmKCJEZXN0aW5h
dGlvbiBub3Qgc2V0XG4iKTsNCj4gKwkJcmV0dXJuIGJ0X3NoZWxsX25vbmludGVyYWN0aXZlX3F1
aXQoRVhJVF9GQUlMVVJFKTsNCj4gKwl9DQo+ICsNCj4gKwluID0gbWVzaF9vcGNvZGVfc2V0KE9Q
X0FQUEtFWV9HRVQsIG1zZyk7DQo+ICsNCj4gKwlpZiAocmVhZF9pbnB1dF9wYXJhbWV0ZXJzKGFy
Z2MsIGFyZ3YpICE9IDEpIHsNCj4gKwkJYnRfc2hlbGxfcHJpbnRmKCJCYWQgYXJndW1lbnRzICVz
XG4iLCBhcmd2WzFdKTsNCj4gKwkJcmV0dXJuIGJ0X3NoZWxsX25vbmludGVyYWN0aXZlX3F1aXQo
RVhJVF9GQUlMVVJFKTsNCj4gKwl9DQo+ICsNCj4gKwlwdXRfbGUxNihwYXJtc1swXSwgbXNnICsg
bik7DQo+ICsJbiArPSAyOw0KPiArDQo+ICsJaWYgKCFjb25maWdfc2VuZChtc2csIG4sIE9QX0FQ
UEtFWV9HRVQpKQ0KPiArCQlyZXR1cm4gYnRfc2hlbGxfbm9uaW50ZXJhY3RpdmVfcXVpdChFWElU
X0ZBSUxVUkUpOw0KPiArDQo+ICsJcmV0dXJuIGJ0X3NoZWxsX25vbmludGVyYWN0aXZlX3F1aXQo
RVhJVF9TVUNDRVNTKTsNCj4gK30NCj4gKw0KPiAgc3RhdGljIHZvaWQgY21kX2tleV9hZGQodWlu
dDMyX3Qgb3Bjb2RlLCBpbnQgYXJnYywgY2hhciAqYXJndltdKQ0KPiAgew0KPiAgCXVpbnQxNl90
IGtleV9pZHg7DQo+IEBAIC0xMzgyLDYgKzE0NTUsMTEgQEAgc3RhdGljIHZvaWQgY21kX25vZGVf
cmVzZXQoaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkNCj4gIAljbWRfZGVmYXVsdChPUF9OT0RFX1JF
U0VUKTsNCj4gIH0NCj4gIA0KPiArc3RhdGljIHZvaWQgY21kX25ldGtleV9nZXQoaW50IGFyZ2Ms
IGNoYXIgKmFyZ3ZbXSkNCj4gK3sNCj4gKwljbWRfZGVmYXVsdChPUF9ORVRLRVlfR0VUKTsNCj4g
K30NCj4gKw0KPiAgc3RhdGljIGJvb2wgdHhfc2V0dXAobW9kZWxfc2VuZF9tc2dfZnVuY190IHNl
bmRfZnVuYywgdm9pZCAqdXNlcl9kYXRhKQ0KPiAgew0KPiAgCWlmICghc2VuZF9mdW5jKQ0KPiBA
QCAtMTQwNCwyMSArMTQ4MiwyNSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGJ0X3NoZWxsX21lbnUg
Y2ZnX21lbnUgPSB7DQo+ICAJeyJjb21wb3NpdGlvbi1nZXQiLCAiW3BhZ2VfbnVtXSIsIGNtZF9j
b21wb3NpdGlvbl9nZXQsDQo+ICAJCQkJIkdldCBjb21wb3NpdGlvbiBkYXRhIn0sDQo+ICAJeyJu
ZXRrZXktYWRkIiwgIjxuZXRfaWR4PiIsIGNtZF9uZXRrZXlfYWRkLA0KPiAtCQkJCSJBZGQgbmV0
d29yayBrZXkifSwNCj4gKwkJCQkiQWRkIE5ldEtleSJ9LA0KPiAgCXsibmV0a2V5LXVwZGF0ZSIs
ICI8bmV0X2lkeD4iLCBjbWRfbmV0a2V5X3VwZGF0ZSwNCj4gLQkJCQkiVXBkYXRlIG5ldHdvcmsg
a2V5In0sDQo+ICsJCQkJIlVwZGF0ZSBOZXRLZXkifSwNCj4gIAl7Im5ldGtleS1kZWwiLCAiPG5l
dF9pZHg+IiwgY21kX25ldGtleV9kZWwsDQo+IC0JCQkJIkRlbGV0ZSBuZXR3b3JrIGtleSJ9LA0K
PiArCQkJCSJEZWxldGUgTmV0S2V5In0sDQo+ICsJeyJuZXRrZXktZ2V0IiwgTlVMTCwgY21kX25l
dGtleV9nZXQsDQo+ICsJCQkJIkxpc3QgTmV0S2V5cyBrbm93biB0byB0aGUgbm9kZSJ9LA0KPiAg
CXsiYXBwa2V5LWFkZCIsICI8YXBwX2lkeD4iLCBjbWRfYXBwa2V5X2FkZCwNCj4gLQkJCQkiQWRk
IGFwcGxpY2F0aW9uIGtleSJ9LA0KPiArCQkJCSJBZGQgQXBwS2V5In0sDQo+ICAJeyJhcHBrZXkt
dXBkYXRlIiwgIjxhcHBfaWR4PiIsIGNtZF9hcHBrZXlfdXBkYXRlLA0KPiAtCQkJCSJBZGQgYXBw
bGljYXRpb24ga2V5In0sDQo+ICsJCQkJIkFkZCBBcHBLZXkifSwNCj4gIAl7ImFwcGtleS1kZWwi
LCAiPGFwcF9pZHg+IiwgY21kX2FwcGtleV9kZWwsDQo+IC0JCQkJIkRlbGV0ZSBhcHBsaWNhdGlv
biBrZXkifSwNCj4gKwkJCQkiRGVsZXRlIEFwcEtleSJ9LA0KPiArCXsiYXBwa2V5LWdldCIsICI8
bmV0X2lkeD4iLCBjbWRfYXBwa2V5X2dldCwNCj4gKwkJCQkiTGlzdCBBcHBLZXlzIGJvdW5kIHRv
IHRoZSBOZXRLZXkifSwNCj4gIAl7ImJpbmQiLCAiPGVsZV9hZGRyPiA8YXBwX2lkeD4gPG1vZF9p
ZD4gW3ZlbmRvcl9pZF0iLCBjbWRfYWRkX2JpbmRpbmcsDQo+IC0JCQkJIkJpbmQgYXBwIGtleSB0
byBhIG1vZGVsIn0sDQo+ICsJCQkJIkJpbmQgQXBwS2V5IHRvIGEgbW9kZWwifSwNCj4gIAl7InVu
YmluZCIsICI8ZWxlX2FkZHI+IDxhcHBfaWR4PiA8bW9kX2lkPiBbdmVuZG9yX2lkXSIsIGNtZF9k
ZWxfYmluZGluZywNCj4gLQkJCQkiUmVtb3ZlIGFwcCBrZXkgZnJvbSBhIG1vZGVsIn0sDQo+ICsJ
CQkJIlJlbW92ZSBBcHBLZXkgZnJvbSBhIG1vZGVsIn0sDQo+ICAJeyJtb2QtYXBwaWR4LWdldCIs
ICI8ZWxlX2FkZHI+IDxtb2RlbCBpZD4iLCBjbWRfbW9kX2FwcGlkeF9nZXQsDQo+ICAJCQkJIkdl
dCBtb2RlbCBhcHBfaWR4In0sDQo+ICAJeyJ0dGwtc2V0IiwgIjx0dGw+IiwgY21kX3R0bF9zZXQs
DQo=
