Return-Path: <SRS0=0CDr=3F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF831C33CB6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jan 2020 16:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F8BE207FF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jan 2020 16:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="ONHwzMJl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbgAPQs6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:48:58 -0500
Received: from mga12.intel.com ([192.55.52.136]:65352 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729199AbgAPQs5 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jan 2020 11:48:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2020 08:48:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,326,1574150400"; 
   d="scan'208";a="218595459"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga008.jf.intel.com with ESMTP; 16 Jan 2020 08:48:48 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Jan 2020 08:48:48 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Jan 2020 08:48:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCpCql0X/JVNnwz2DOUcOU/VSGHKF1sHeGajRXOxJRis7NGgB7D7EKb30SV7iBuTMODvNSRskz+N/bHLxgv3QHIt0wgvO7/pYEopSC7Ly+jSl/p1zCdt1+VlKPVJhilR5Aq64jSLRD8tioCmOotZzIaKFoBXtAoiqN5Y2qx7ANwc8wNDVZ5/CxHmPQo+Wmm2Iv5F8vitWX7Z3l/2HeyNIk5KoaednPkgl4jOtr/PGHfBWtJWNxWdR5KyIwLBOD8rMqR7Awff5nFltbXFI6mhWtD17TDTex5aU+S5IhQVsGv9Ui7LdX9uXEHNtIg2vOz2a4ai6aYhgGKvGjxFl9Y/pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Cjb26+nnnQHCJuCsnFU/hi9fztFbflm2Xt2/thCsVA=;
 b=UOipcPxvse1JG8qWxr6tBHdhi+lGdJ5mbugkfAr6HDVdSf5h6Hn10DfS3qm/FA9y0Pfh7yr/Gixv4Zi1vG+lbuagqCJpkd2k4EO/nG9iLMWL6iKXZeZEGNzGUgtCDwM7nQrX9RMh4ZKuNHMemn2mRMug48trfF4TMRIrvG2Y8qJfVxfSWBve2PF26GVO+378zIpSig3RO86bXAeSV7uOtxJRUQnL7G/C5OnBCYbO3RKQOy27YPgQvTaOOmiTQ9si0pUQUlq/fgwlsBICPg/TkX2eWuZeW4U6L93u6X1XBJhrygSjs6KbrXItbKfxRiGddnoMJ4XlazwEJJyEiUT3Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Cjb26+nnnQHCJuCsnFU/hi9fztFbflm2Xt2/thCsVA=;
 b=ONHwzMJljQWU/8bzvIUGbWotdA+m3nvN69AEYBGxQxTg1nriinZHMjN1m/Gs7fvxG0EKo94fBZyOiMVhUbXqIUH61dcIh3Z0j4hTbiRBaE6YrXOXxmMAuk7BA8kuo7nhs3tEHC8WyKJtM5pBmvgNItQ3cp7PZqlriaCG5yCprIk=
Received: from MWHPR11MB1664.namprd11.prod.outlook.com (10.172.54.13) by
 MWHPR11MB1726.namprd11.prod.outlook.com (10.169.233.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 16 Jan 2020 16:48:47 +0000
Received: from MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e]) by MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e%6]) with mapi id 15.20.2644.015; Thu, 16 Jan 2020
 16:48:47 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ v4] mesh: Rename --index to --io, support additional
 io types.
Thread-Topic: [PATCH BlueZ v4] mesh: Rename --index to --io, support
 additional io types.
Thread-Index: AQHVzGXfqqCYtSTy5UeYDsaK9wt6MqftgNcA
Date:   Thu, 16 Jan 2020 16:48:47 +0000
Message-ID: <155b9994772e7aeb1b883daafb2dac5637eabca8.camel@intel.com>
References: <20200116120910.10575-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20200116120910.10575-1-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 962fe030-6b7e-4976-482f-08d79aa3f4ea
x-ms-traffictypediagnostic: MWHPR11MB1726:
x-microsoft-antispam-prvs: <MWHPR11MB172600ECCB664CBC66E9EDDDE1360@MWHPR11MB1726.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:590;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39860400002)(376002)(346002)(199004)(189003)(6512007)(71200400001)(66476007)(6486002)(91956017)(2906002)(2616005)(66446008)(66556008)(186003)(86362001)(26005)(6506007)(66946007)(64756008)(76116006)(478600001)(110136005)(8936002)(81166006)(81156014)(8676002)(5660300002)(36756003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR11MB1726;H:MWHPR11MB1664.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vMrCiEa8bYIuJJA8ZevWbTGVV0MdmY7s2j9FGUBIPf+yuZQgy9luOlrlMcLSKSWzcWDM3ccLGDdkd57VWQiIF15g9DNmzkdZobBUOZrA28lEPEu5cj9R5JCvx2brxkbHShblkCOta2J2XbshZBB7mTVVavMPRJEb6SjfrnXql60h1cLby7OvVssMmxIADpqRI684Buttzdg/CQgPwG9bW2VNR/l1ceamRDEp56crDRlwKHnyZCR86l11uRhQTwQMZ3G+/mhRC33l426HkFKVuTZ1oCWcpIggZL8Dy4EQSGdCGx9ZP5UoXosgfVPRBjKhlyQG9mXJsAgMJYUF5SCrCpNfRg+4fyARxY5ppmn2v3minkFIF4d7wvirOPhBgYH9rhr7NTW8V1YZDFQ0QhAK/KvT4+2v+ElX8wgbdr/Vxvk6Ab2fgD7QoSZSTABGQkGt
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F8075D74CCEED4FB6C5DF24D3B5BDEF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 962fe030-6b7e-4976-482f-08d79aa3f4ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 16:48:47.3816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1x1tGrVU1x7COmS8C/jpomcbkngGuDtW0XETN5ge71doYvivQxrLx6KzfjaEzfUUQlmfcgrrVxvc5vQwkK5jmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1726
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gVGh1LCAyMDIwLTAxLTE2IGF0IDEzOjA5ICswMTAwLCBNaWNoYcWCIExvd2Fz
LVJ6ZWNob25layB3cm90ZToNCj4gVGhpcyBhbGxvd3Mgc3BlY2lmeWluZyBpbyB0eXBlIGFuZCBv
cHRpb25zIHdoZW4gaW52b2tpbmcgdGhlIGRhZW1vbi4NCj4gDQo+IFdoZW4gbm8gIi1pIiBpcyBw
YXNzZWQsIG1lc2hkIHN0aWxsIHJ1bnMgd2l0aCBNRVNIX0lPX1RZUEVfR0VORVJJQyBhbmQNCj4g
dHJpZXMgdG8gYXR0YWNoIHRvIHRoZSBmaXJzdCBhdmFpbGFibGUgSENJIGludGVyZmFjZS4NCj4g
DQo+IE9wdGlvbnMgIi1pIDxuPiIgYW5kICItaSBoY2k8bj4iIGFyZSBqdXN0IHNob3J0Y3V0cyBm
b3INCj4gIi0taW89Z2VuZXJpYzo8bj4iIGFuZCAiLS1pbz1nZW5lcmljOmhjaTxuPiIsIHJlc3Bl
Y3RpdmVseS4NCj4gLS0tDQo+IHY0OiBGcmVlIHRoZSAnaW8nIHN0cmluZyBpbW1lZGlhdGVseSBh
ZnRlciBwYXJzaW5nIGl0IHdpdGggcGFyc2VfaW8NCj4gDQo+ICBtZXNoL21haW4uYyB8IDg5ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgNjkgaW5zZXJ0aW9ucygrKSwgMjAgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvbWVzaC9tYWluLmMgYi9tZXNoL21haW4uYw0KPiBpbmRleCAwMTBlZGNmODUu
LmM2YmYxZmY0MSAxMDA2NDQNCj4gLS0tIGEvbWVzaC9tYWluLmMNCj4gKysrIGIvbWVzaC9tYWlu
LmMNCj4gQEAgLTQwLDEwICs0MCwxMSBAQA0KPiAgDQo+ICBzdGF0aWMgY29uc3QgY2hhciAqY29u
ZmlnX2RpcjsNCj4gIHN0YXRpYyBjb25zdCBjaGFyICptZXNoX2NvbmZfZm5hbWU7DQo+IC1zdGF0
aWMgaW50IGN0bHJfaW5kZXggPSBNR01UX0lOREVYX05PTkU7DQo+ICtzdGF0aWMgZW51bSBtZXNo
X2lvX3R5cGUgaW9fdHlwZTsNCj4gK3N0YXRpYyB2b2lkICppb19vcHRzOw0KPiAgDQo+ICBzdGF0
aWMgY29uc3Qgc3RydWN0IG9wdGlvbiBtYWluX29wdGlvbnNbXSA9IHsNCj4gLQl7ICJpbmRleCIs
CXJlcXVpcmVkX2FyZ3VtZW50LAlOVUxMLCAnaScgfSwNCj4gKwl7ICJpbyIsCQlyZXF1aXJlZF9h
cmd1bWVudCwJTlVMTCwgJ2knIH0sDQo+ICAJeyAiY29uZmlnIiwJb3B0aW9uYWxfYXJndW1lbnQs
CU5VTEwsICdjJyB9LA0KPiAgCXsgIm5vZGV0YWNoIiwJbm9fYXJndW1lbnQsCQlOVUxMLCAnbicg
fSwNCj4gIAl7ICJkZWJ1ZyIsCW5vX2FyZ3VtZW50LAkJTlVMTCwgJ2QnIH0sDQo+IEBAIC01NCwx
NiArNTUsMjIgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvcHRpb24gbWFpbl9vcHRpb25zW10gPSB7
DQo+ICANCj4gIHN0YXRpYyB2b2lkIHVzYWdlKHZvaWQpDQo+ICB7DQo+IC0JbF9pbmZvKCIiKTsN
Cj4gLQlsX2luZm8oIlVzYWdlOlxuIg0KPiArCWZwcmludGYoc3RkZXJyLA0KPiArCQkiVXNhZ2U6
XG4iDQo+ICAJICAgICAgICJcdGJsdWV0b290aC1tZXNoZCBbb3B0aW9uc11cbiIpOw0KPiAtCWxf
aW5mbygiT3B0aW9uczpcbiINCj4gLQkgICAgICAgIlx0LS1pbmRleCA8aGNpbnVtPiAgVXNlIHNw
ZWNpZmllZCBjb250cm9sbGVyXG4iDQo+ICsJZnByaW50ZihzdGRlcnIsDQo+ICsJCSJPcHRpb25z
OlxuIg0KPiArCSAgICAgICAiXHQtLWlvIDxpbz4gICAgICAgICBVc2Ugc3BlY2lmaWVkIGlvIChk
ZWZhdWx0OiBnZW5lcmljKVxuIg0KPiAgCSAgICAgICAiXHQtLWNvbmZpZyAgICAgICAgICBDb25m
aWd1cmF0aW9uIGRpcmVjdG9yeVxuIg0KPiAgCSAgICAgICAiXHQtLW5vZGV0YWNoICAgICAgICBS
dW4gaW4gZm9yZWdyb3VuZFxuIg0KPiAgCSAgICAgICAiXHQtLWRlYnVnICAgICAgICAgICBFbmFi
bGUgZGVidWcgb3V0cHV0XG4iDQo+ICAJICAgICAgICJcdC0tZGJ1cy1kZWJ1ZyAgICAgIEVuYWJs
ZSBELUJ1cyBkZWJ1Z2dpbmdcbiINCj4gIAkgICAgICAgIlx0LS1oZWxwICAgICAgICAgICAgU2hv
dyAlcyBpbmZvcm1hdGlvblxuIiwgX19mdW5jX18pOw0KPiArCWZwcmludGYoc3RkZXJyLA0KPiAr
CSAgICAgICAiaW86XG4iDQo+ICsJICAgICAgICJcdChbaGNpXTxpbmRleD4gfCBnZW5lcmljWzpb
aGNpXTxpbmRleD5dKVxuIg0KPiArCSAgICAgICAiXHRcdFVzZSBnZW5lcmljIEhDSSBpbyBvbiBp
bnRlcmZhY2UgaGNpPGluZGV4Piwgb3IgdGhlIGZpcnN0XG4iDQo+ICsJICAgICAgICJcdFx0YXZh
aWxhYmxlIG9uZVxuIik7DQo+ICB9DQo+ICANCj4gIHN0YXRpYyB2b2lkIGRvX2RlYnVnKGNvbnN0
IGNoYXIgKnN0ciwgdm9pZCAqdXNlcl9kYXRhKQ0KPiBAQCAtMTAwLDggKzEwNyw4IEBAIHN0YXRp
YyB2b2lkIHJlcXVlc3RfbmFtZV9jYWxsYmFjayhzdHJ1Y3QgbF9kYnVzICpkYnVzLCBib29sIHN1
Y2Nlc3MsDQo+ICAJCXJldHVybjsNCj4gIAl9DQo+ICANCj4gLQlpZiAoIW1lc2hfaW5pdChjb25m
aWdfZGlyLCBtZXNoX2NvbmZfZm5hbWUsIE1FU0hfSU9fVFlQRV9HRU5FUklDLA0KPiAtCQkJCSZj
dGxyX2luZGV4LCBtZXNoX3JlYWR5X2NhbGxiYWNrLCBkYnVzKSkgew0KPiArCWlmICghbWVzaF9p
bml0KGNvbmZpZ19kaXIsIG1lc2hfY29uZl9mbmFtZSwgaW9fdHlwZSwgaW9fb3B0cywNCj4gKwkJ
CQkJbWVzaF9yZWFkeV9jYWxsYmFjaywgZGJ1cykpIHsNCj4gIAkJbF9lcnJvcigiRmFpbGVkIHRv
IGluaXRpYWxpemUgbWVzaCIpOw0KPiAgCQlsX21haW5fcXVpdCgpOw0KPiAgCX0NCj4gQEAgLTEz
MywxMiArMTQwLDQ1IEBAIHN0YXRpYyB2b2lkIHNpZ25hbF9oYW5kbGVyKHVpbnQzMl90IHNpZ25v
LCB2b2lkICp1c2VyX2RhdGEpDQo+ICAJdGVybWluYXRlZCA9IHRydWU7DQo+ICB9DQo+ICANCj4g
K3N0YXRpYyBib29sIHBhcnNlX2lvKGNvbnN0IGNoYXIgKm9wdGFyZywgZW51bSBtZXNoX2lvX3R5
cGUgKnR5cGUsIHZvaWQgKipvcHRzKQ0KPiArew0KPiArCWlmIChzdHJzdHIob3B0YXJnLCAiZ2Vu
ZXJpYyIpID09IG9wdGFyZykgew0KPiArCQlpbnQgKmluZGV4ID0gbF9uZXcoaW50LCAxKTsNCj4g
Kw0KPiArCQkqdHlwZSA9IE1FU0hfSU9fVFlQRV9HRU5FUklDOw0KPiArCQkqb3B0cyA9IGluZGV4
Ow0KPiArDQo+ICsJCW9wdGFyZyArPSBzdHJsZW4oImdlbmVyaWMiKTsNCj4gKwkJaWYgKCEqb3B0
YXJnKSB7DQo+ICsJCQkqaW5kZXggPSBNR01UX0lOREVYX05PTkU7DQo+ICsJCQlyZXR1cm4gdHJ1
ZTsNCj4gKwkJfQ0KPiArDQo+ICsJCWlmICgqb3B0YXJnICE9ICc6JykNCj4gKwkJCXJldHVybiBm
YWxzZTsNCj4gKw0KPiArCQlvcHRhcmcrKzsNCj4gKw0KPiArCQlpZiAoc3NjYW5mKG9wdGFyZywg
ImhjaSVkIiwgaW5kZXgpID09IDEpDQo+ICsJCQlyZXR1cm4gdHJ1ZTsNCj4gKw0KPiArCQlpZiAo
c3NjYW5mKG9wdGFyZywgIiVkIiwgaW5kZXgpID09IDEpDQo+ICsJCQlyZXR1cm4gdHJ1ZTsNCj4g
Kw0KPiArCQlyZXR1cm4gZmFsc2U7DQo+ICsJfQ0KPiArDQo+ICsJcmV0dXJuIGZhbHNlOw0KPiAr
fQ0KPiArDQo+ICBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQ0KPiAgew0KPiAgCWlu
dCBzdGF0dXM7DQo+ICAJYm9vbCBkZXRhY2hlZCA9IHRydWU7DQo+ICAJYm9vbCBkYnVzX2RlYnVn
ID0gZmFsc2U7DQo+ICAJc3RydWN0IGxfZGJ1cyAqZGJ1cyA9IE5VTEw7DQo+ICsJY2hhciAqaW8g
PSBOVUxMOw0KPiArCWludCBoY2lfaW5kZXg7DQo+ICANCj4gIAlpZiAoIWxfbWFpbl9pbml0KCkp
DQo+ICAJCXJldHVybiAtMTsNCj4gQEAgLTE1Myw3ICsxOTMsNiBAQCBpbnQgbWFpbihpbnQgYXJn
YywgY2hhciAqYXJndltdKQ0KPiAgDQo+ICAJZm9yICg7Oykgew0KPiAgCQlpbnQgb3B0Ow0KPiAt
CQljb25zdCBjaGFyICpzdHI7DQo+ICANCj4gIAkJb3B0ID0gZ2V0b3B0X2xvbmcoYXJnYywgYXJn
diwgImk6YzpmOm5kYmgiLCBtYWluX29wdGlvbnMsIE5VTEwpOw0KPiAgCQlpZiAob3B0IDwgMCkN
Cj4gQEAgLTE2MSwxOCArMjAwLDExIEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10p
DQo+ICANCj4gIAkJc3dpdGNoIChvcHQpIHsNCj4gIAkJY2FzZSAnaSc6DQo+IC0JCQlpZiAoc3Ry
bGVuKG9wdGFyZykgPiAzICYmICFzdHJuY21wKG9wdGFyZywgImhjaSIsIDMpKQ0KPiAtCQkJCXN0
ciA9IG9wdGFyZyArIDM7DQo+ICsJCQlpZiAoc3NjYW5mKG9wdGFyZywgImhjaSVkIiwgJmhjaV9p
bmRleCkgPT0gMSB8fA0KPiArCQkJCQlzc2NhbmYob3B0YXJnLCAiJWQiLCAmaGNpX2luZGV4KSA9
PSAxKQ0KPiArCQkJCWlvID0gbF9zdHJkdXBfcHJpbnRmKCJnZW5lcmljOiVzIiwgb3B0YXJnKTsN
Cj4gIAkJCWVsc2UNCj4gLQkJCQlzdHIgPSBvcHRhcmc7DQo+IC0JCQlpZiAoIWlzZGlnaXQoKnN0
cikpIHsNCj4gLQkJCQlsX2Vycm9yKCJJbnZhbGlkIGNvbnRyb2xsZXIgaW5kZXggdmFsdWUiKTsN
Cj4gLQkJCQlzdGF0dXMgPSBFWElUX0ZBSUxVUkU7DQo+IC0JCQkJZ290byBkb25lOw0KPiAtCQkJ
fQ0KPiAtDQo+IC0JCQljdGxyX2luZGV4ID0gYXRvaShzdHIpOw0KPiAtDQo+ICsJCQkJaW8gPSBs
X3N0cmR1cChvcHRhcmcpOw0KPiAgCQkJYnJlYWs7DQo+ICAJCWNhc2UgJ24nOg0KPiAgCQkJZGV0
YWNoZWQgPSBmYWxzZTsNCj4gQEAgLTIwMCw2ICsyMzIsMTcgQEAgaW50IG1haW4oaW50IGFyZ2Ms
IGNoYXIgKmFyZ3ZbXSkNCj4gIAkJfQ0KPiAgCX0NCj4gIA0KPiArCWlmICghaW8pDQo+ICsJCWlv
ID0gbF9zdHJkdXBfcHJpbnRmKCJnZW5lcmljIik7DQo+ICsNCj4gKwlpZiAoIXBhcnNlX2lvKGlv
LCAmaW9fdHlwZSwgJmlvX29wdHMpKSB7DQo+ICsJCWxfZXJyb3IoIkludmFsaWQgaW86ICVzIiwg
aW8pOw0KPiArCQlzdGF0dXMgPSBFWElUX0ZBSUxVUkU7DQo+ICsJCWdvdG8gZG9uZTsNCj4gKwl9
DQo+ICsNCj4gKwlsX2ZyZWUoaW8pOw0KPiArCWlvID0gTlVMTDsNCj4gIA0KPiAgCWlmICghZGV0
YWNoZWQpDQo+ICAJCXVtYXNrKDAwNzcpOw0KPiBAQCAtMjI1LDYgKzI2OCwxMiBAQCBpbnQgbWFp
bihpbnQgYXJnYywgY2hhciAqYXJndltdKQ0KPiAgCXN0YXR1cyA9IGxfbWFpbl9ydW5fd2l0aF9z
aWduYWwoc2lnbmFsX2hhbmRsZXIsIE5VTEwpOw0KPiAgDQo+ICBkb25lOg0KPiArCWlmIChpbykN
Cj4gKwkJbF9mcmVlKGlvKTsNCj4gKw0KPiArCWlmIChpb19vcHRzKQ0KPiArCQlsX2ZyZWUoaW9f
b3B0cyk7DQo+ICsNCj4gIAltZXNoX2NsZWFudXAoKTsNCj4gIAlsX2RidXNfZGVzdHJveShkYnVz
KTsNCj4gIAlsX21haW5fZXhpdCgpOw0K
