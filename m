Return-Path: <SRS0=kuCk=2G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660D2C43603
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Dec 2019 22:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D9DB22464
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Dec 2019 22:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="d6LzZ7t1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfLPWu6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:50:58 -0500
Received: from mga09.intel.com ([134.134.136.24]:42501 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbfLPWu6 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Dec 2019 17:50:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 14:50:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,323,1571727600"; 
   d="scan'208";a="365176623"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga004.jf.intel.com with ESMTP; 16 Dec 2019 14:50:57 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 16 Dec 2019 14:50:56 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 16 Dec 2019 14:50:56 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 16 Dec 2019 14:50:56 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.57) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 16 Dec 2019 14:50:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5et7OHv4OvxtPYQ75Z/oK1rjA2RkQSNmC84qxhISeu3LFPjK/KJ4UvxitTud3b5BLNwpaCa3RwS88qp7AXp8jM9pl7r7mFc7olDF3uKaveS5PoAbkeoFETE2Lgbh32th9uudQEbvtAdKh19CNyT9ImFn29S6lpiCK01FfojTB3A7lpZpLQOuslHKHlwGR5niuj+j9V5sqKE/0c7fuUwcHJ6E5cVmvAOm8xQyJJPPmilbGsfg2254UER3Z9hW4Lj2vLgSZ4IbsCH+oMvYBPwlNa8SSBdmhLVCKLFEk64x44/l4hkbY++SThlFNCWBtE8uf2slWYM5oq0CGozOi+mtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goi+NKZjG09SCLHpYGYodY8rfT8w9Q4oQFDL5eUIzRc=;
 b=M3WYATNejGuVvXQIi54kmi2EOnCek1xiYMe8+gFGtil52Ha7jyKvm+YmeF5ucH2Bw3DeGL8lcJHuq5XdUmpaXOyvqH8HLggbP9YHaF7fSWjMS1fajq1fmMyH96917Jc91TyFkT6/cgzqry9jTd+v3oNmlFNWcSVr3gDxN+RXhSxOtgT9+Un7gDBT/RkBt7OyZf0r3EUNqCrHDQ1TQGsQgr8VU8uDEkupF13f1wjD8iL7pXjhl+y3+0iNey3KTiJoMAtwM5frnif6qEu+v38HlK5khz3zZQmUjL1Gwr6fpB/iFjqFA9B6NqRldEjpNc8aSMyQyxnTBUR3M/ndHR2+Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goi+NKZjG09SCLHpYGYodY8rfT8w9Q4oQFDL5eUIzRc=;
 b=d6LzZ7t18TFrQPMHoxG9ABCLTkrp4tE5dWllSiRqlYYp5GUS23P7tZ3Q86+3VBLo49Zbuvp5/fAU+7iHN91n4lMyijLkHd7hJelbgk/z27Xmgq2emj/hL1ywpUwIJmlNudU/vXPqm9P0GyDBBDIzpn1p+6ycubApxv1aAEvwe7U=
Received: from CY4PR11MB1269.namprd11.prod.outlook.com (10.173.16.11) by
 CY4PR11MB0022.namprd11.prod.outlook.com (10.171.254.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.20; Mon, 16 Dec 2019 22:50:54 +0000
Received: from CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::39e0:30e9:a8b0:fe24]) by CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::39e0:30e9:a8b0:fe24%3]) with mapi id 15.20.2538.019; Mon, 16 Dec 2019
 22:50:54 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "aurelien@aurel32.net" <aurelien@aurel32.net>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH Bluez v2] tools/mesh-cfgclient: add network transmit
 get/set commands
Thread-Topic: [PATCH Bluez v2] tools/mesh-cfgclient: add network transmit
 get/set commands
Thread-Index: AQHVmMoPwwPuSUM3Kkuxdv0Vk2ifnqe9lPcA
Date:   Mon, 16 Dec 2019 22:50:54 +0000
Message-ID: <8bae4a6e1e60b612f4092487ac1e661f6c623efe.camel@intel.com>
References: <20191111195530.3354-1-aurelien@aurel32.net>
In-Reply-To: <20191111195530.3354-1-aurelien@aurel32.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38cb7412-9654-486e-7292-08d7827a689e
x-ms-traffictypediagnostic: CY4PR11MB0022:
x-microsoft-antispam-prvs: <CY4PR11MB00221B1AE83C555A4BB2FEDEE1510@CY4PR11MB0022.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:655;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(136003)(376002)(346002)(189003)(199004)(5660300002)(316002)(478600001)(71200400001)(26005)(81166006)(36756003)(6486002)(186003)(4001150100001)(110136005)(8676002)(86362001)(6512007)(81156014)(91956017)(66946007)(66476007)(76116006)(64756008)(66446008)(66556008)(2616005)(8936002)(6506007)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR11MB0022;H:CY4PR11MB1269.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UkX2mwdjYJFhGIALAICNRI5WIexDKkNJieoWWYVaOzoZVHXiOSTg8VbKfRzvjx5rBC8Ie3JJ/SVLPb7DQf3DEAE3LvWG4+3ES9D4tSD45I/9w/4tlyGaqAB6yIq7inQcCfP0EB1C1XxwyqMosvooFIRNUisFN/85GSu/L8a8H0Z200uE+jyPyxrU+ur7032fZRZOL3381yzPGAZyNiZup9SmvzPAqgriH1Zxiplz3gGREFWsiIAO7qtXJ1MX/FbiHXkHuq+yJo/kgGffQ4Je1SdK5ROeyae6tDy13blV3H+8/pcL107kCI43o84fMh8Llqrc5i4XfnLluz0LhQZ+SmyPc2DbZZcjUmaL/Vmu/fVaiBCnWVV+olvTa79BC0I2SFizvUuiLATadI+0XV0frG9blr+nt2a5mTmN5cMQ6Xxf7MosFIsW6WMhnBUdIrxV
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <76D253D8FE924E4381B26549F547E920@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 38cb7412-9654-486e-7292-08d7827a689e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 22:50:54.6811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0399nBchhS9+5ezsvIGrWOBcSsv6QZnR0LM9t0rhS2fRfTouWWKF6Tebo9Fj4c3zicQxPxPbZq6AY4jZSL1NEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB0022
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCB3aXRoIG1pbm9yIHJlLWFycmFuZ2UgZm9yIG11bHRpcGxlIGNvbW1hbmQgYWRkcw0K
VGhhbmtzDQoNCk9uIE1vbiwgMjAxOS0xMS0xMSBhdCAyMDo1NSArMDEwMCwgQXVyZWxpZW4gSmFy
bm8gd3JvdGU6DQo+IEFkZCBuZXR3b3JrLXRyYW5zbWl0LWdldCBhbmQgbmV0d29yay10cmFuc21p
dC1zZXQgY29tbWFuZHMgYXMgcGVyDQo+IE1lc2ggUHJvZmlsZSA0LjMuMi42OSwgNC4zLjIuNzAg
YW5kIDQuMy4yLjcxLg0KPiAtLS0NCj4gIHRvb2xzL21lc2gvY2ZnY2xpLmMgfCA0MCArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNDAg
aW5zZXJ0aW9ucygrKQ0KPiANCj4gQ2hhbmdlcyB2MSAtPiB2MjoNCj4gIC0gRml4IHRoZSBjbnQv
c3RlcHMgZmllbGRzIG9yZGVyaW5nDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvbWVzaC9jZmdj
bGkuYyBiL3Rvb2xzL21lc2gvY2ZnY2xpLmMNCj4gaW5kZXggYTRkZTQyOTQzLi4wNGVkYzcwNmMg
MTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL21lc2gvY2ZnY2xpLmMNCj4gKysrIGIvdG9vbHMvbWVzaC9j
ZmdjbGkuYw0KPiBAQCAtNjIxLDYgKzYyMSwxNSBAQCBzdGF0aWMgYm9vbCBtc2dfcmVjdmQodWlu
dDE2X3Qgc3JjLCB1aW50MTZfdCBpZHgsIHVpbnQ4X3QgKmRhdGEsDQo+ICAJCQkJc3JjLCBtZXNo
X3N0YXR1c19zdHIoZGF0YVswXSkpOw0KPiAgDQo+ICAJCWJyZWFrOw0KPiArDQo+ICsJLyogUGVy
IE1lc2ggUHJvZmlsZSA0LjMuMi43MSAqLw0KPiArCWNhc2UgT1BfQ09ORklHX05FVFdPUktfVFJB
TlNNSVRfU1RBVFVTOg0KPiArCQlpZiAobGVuICE9IDEpDQo+ICsJCQlyZXR1cm4gdHJ1ZTsNCj4g
Kw0KPiArCQlidF9zaGVsbF9wcmludGYoIk5vZGUgJTQuNHg6IE5ldHdvcmsgdHJhbnNtaXQgY250
ICVkLCBzdGVwcyAlZFxuIiwNCj4gKwkJCQlzcmMsIGRhdGFbMF0gJiA3LCBkYXRhWzBdID4+IDMp
Ow0KPiArCQlicmVhazsNCj4gIAl9DQo+ICANCj4gIAlyZXR1cm4gdHJ1ZTsNCj4gQEAgLTEzMzQs
NiArMTM0MywzMyBAQCBzdGF0aWMgdm9pZCBjbWRfbm9kZV9yZXNldChpbnQgYXJnYywgY2hhciAq
YXJndltdKQ0KPiAgCWNtZF9kZWZhdWx0KE9QX05PREVfUkVTRVQpOw0KPiAgfQ0KPiAgDQo+ICtz
dGF0aWMgdm9pZCBjbWRfbmV0d29ya190cmFuc21pdF9nZXQoaW50IGFyZ2MsIGNoYXIgKmFyZ3Zb
XSkNCj4gK3sNCj4gKwljbWRfZGVmYXVsdChPUF9DT05GSUdfTkVUV09SS19UUkFOU01JVF9HRVQp
Ow0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCBjbWRfbmV0d29ya190cmFuc21pdF9zZXQoaW50
IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkNCj4gK3sNCj4gKwl1aW50MTZfdCBuOw0KPiArCXVpbnQ4X3Qg
bXNnWzIgKyAxXTsNCj4gKwlpbnQgcGFybV9jbnQ7DQo+ICsNCj4gKwluID0gbWVzaF9vcGNvZGVf
c2V0KE9QX0NPTkZJR19ORVRXT1JLX1RSQU5TTUlUX1NFVCwgbXNnKTsNCj4gKw0KPiArCXBhcm1f
Y250ID0gcmVhZF9pbnB1dF9wYXJhbWV0ZXJzKGFyZ2MsIGFyZ3YpOw0KPiArCWlmIChwYXJtX2Nu
dCAhPSAyKSB7DQo+ICsJCWJ0X3NoZWxsX3ByaW50ZigiYmFkIGFyZ3VtZW50c1xuIik7DQo+ICsJ
CXJldHVybiBidF9zaGVsbF9ub25pbnRlcmFjdGl2ZV9xdWl0KEVYSVRfRkFJTFVSRSk7DQo+ICsJ
fQ0KPiArDQo+ICsJbXNnW24rK10gPSBwYXJtc1swXSB8IChwYXJtc1sxXSA8PCAzKTsNCj4gKw0K
PiArCWlmICghY29uZmlnX3NlbmQobXNnLCBuLCBPUF9DT05GSUdfTkVUV09SS19UUkFOU01JVF9T
RVQpKQ0KPiArCQlyZXR1cm4gYnRfc2hlbGxfbm9uaW50ZXJhY3RpdmVfcXVpdChFWElUX0ZBSUxV
UkUpOw0KPiArDQo+ICsJcmV0dXJuIGJ0X3NoZWxsX25vbmludGVyYWN0aXZlX3F1aXQoRVhJVF9T
VUNDRVNTKTsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGJvb2wgdHhfc2V0dXAobW9kZWxfc2VuZF9t
c2dfZnVuY190IHNlbmRfZnVuYywgdm9pZCAqdXNlcl9kYXRhKQ0KPiAgew0KPiAgCWlmICghc2Vu
ZF9mdW5jKQ0KPiBAQCAtMTQxNCw2ICsxNDUwLDEwIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYnRf
c2hlbGxfbWVudSBjZmdfbWVudSA9IHsNCj4gIAkJCQkiR2V0IHN1YnNjcmlwdGlvbiJ9LA0KPiAg
CXsibm9kZS1yZXNldCIsIE5VTEwsIGNtZF9ub2RlX3Jlc2V0LA0KPiAgCQkJCSJSZXNldCBhIG5v
ZGUgYW5kIHJlbW92ZSBpdCBmcm9tIG5ldHdvcmsifSwNCj4gKwl7Im5ldHdvcmstdHJhbnNtaXQt
Z2V0IiwgTlVMTCwgY21kX25ldHdvcmtfdHJhbnNtaXRfZ2V0LA0KPiArCQkJCSJHZXQgbmV0d29y
ayB0cmFuc21pdCBzdGF0ZSJ9LA0KPiArCXsibmV0d29yay10cmFuc21pdC1zZXQiLCAiPGNvdW50
PiA8c3RlcHM+IiwgY21kX25ldHdvcmtfdHJhbnNtaXRfc2V0LA0KPiArCQkJCSJTZXQgbmV0d29y
ayB0cmFuc21pdCBzdGF0ZSJ9LA0KPiAgCXt9IH0sDQo+ICB9Ow0KPiAgDQo=
