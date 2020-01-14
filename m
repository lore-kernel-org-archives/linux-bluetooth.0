Return-Path: <SRS0=HCMd=3D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5884C33C9E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 19:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6947024655
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 19:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="nky5xWIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgANTjA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:39:00 -0500
Received: from mga09.intel.com ([134.134.136.24]:5608 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgANTi7 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jan 2020 14:38:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 11:38:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,320,1574150400"; 
   d="scan'208";a="242592515"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga002.jf.intel.com with ESMTP; 14 Jan 2020 11:38:59 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Jan 2020 11:38:58 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 14 Jan 2020 11:38:58 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 14 Jan 2020 11:38:58 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 14 Jan 2020 11:38:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EcfEU5L6eNTE1QbTFiofp7+lr6VAv+Gl42cY7Vc7PBwAcbUr66/62pXnJ8XdLaatwYnGMIGSieCvkciY266NepV5n2XewJ+3eeHRqHMQXrlfTV8T1RyGse7bmPIJ1QNuKJ86VHRF/ZEzbNdWX0w8WluFQLeXvCJQYAXWmwDzVg1d+uHlHtCGS9QW2qx1ncBfVE2ZX/VTOn/wJ6DVyg1jGvlkAess/N3Rp8bsikTmzvLVSQsaOJ42Fq2jv6J9uOHDzPeVm9uXzhgxCnzhCU29mbAJqjDK5j5vuOas5fCb+Fs09C6fGqVxmK1EEDucU01tekrOPCBzAOg3hM/9QkkTmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ud9ZcjhZhmc0c4N4jXgoYCwW/1TBFWBD5KuyiG3BfPk=;
 b=JFXVnsMwd/5nuv2d0H9YY90FuVjvjlTjgFTW9G+Qhr3nEM+os1n2oWb4jn1mkgqypkWl99vchC2PXAjV6n3+A65CUyQDlkdjXNA8KW2ZjJ1Ytk4GLde8TYraJJhctR8XC/n2QvfHNGp4E2Zst5tjz3K843U8n+EjVjFdrljews9gAxHafNWktcYMXkAt+h9QBWScqtMcrNiQQpo+SthPfbR8VPd063q7OxU6yvUQ0EZgR2LZpZm050AKTOBEYzZoKupgAVOLvtcg9W1HVT6AIOtbZfF+KffkKIt4OOyhYcRiR/YzcersbP9lmJjUiyB7x/vmTHYdM9459crfKwUf4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ud9ZcjhZhmc0c4N4jXgoYCwW/1TBFWBD5KuyiG3BfPk=;
 b=nky5xWIKgYoMqIqRu8xgtILEfpPz2ZhEL6wSoLW83PEDdCzl/sMNolBP6weiV5JXIblFltZAYudPAcv0orwP8yUOIB7CUmVkGve6VGG+7YbV1QxVnxe2S6elhC0YvPmqkR0qpCt5waNFr6xEMTcXtNiP2ziRcRrDCJda0u+L2IE=
Received: from SN6PR11MB3520.namprd11.prod.outlook.com (52.135.124.204) by
 SN6PR11MB2736.namprd11.prod.outlook.com (52.135.92.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Tue, 14 Jan 2020 19:38:55 +0000
Received: from SN6PR11MB3520.namprd11.prod.outlook.com
 ([fe80::ede7:c158:93c:ca45]) by SN6PR11MB3520.namprd11.prod.outlook.com
 ([fe80::ede7:c158:93c:ca45%7]) with mapi id 15.20.2623.015; Tue, 14 Jan 2020
 19:38:55 +0000
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH RESEND BlueZ 1/1] mesh: Add --io option
Thread-Topic: [PATCH RESEND BlueZ 1/1] mesh: Add --io option
Thread-Index: AQHVygznq9eTqKX+ZE+azCGu4sREHKfqkGMA
Date:   Tue, 14 Jan 2020 19:38:53 +0000
Message-ID: <e2a55b9eca724eafb6c019a0e306d33cfb45a617.camel@intel.com>
References: <20200113122726.768-1-michal.lowas-rzechonek@silvair.com>
         <20200113122726.768-2-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20200113122726.768-2-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=inga.stotland@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a355620-e913-4ae5-6a6b-08d79929646a
x-ms-traffictypediagnostic: SN6PR11MB2736:
x-microsoft-antispam-prvs: <SN6PR11MB273628D5B51A5D707EB06AA5FB340@SN6PR11MB2736.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(396003)(39860400002)(366004)(199004)(189003)(186003)(6486002)(81166006)(81156014)(8676002)(26005)(2906002)(66946007)(71200400001)(76116006)(91956017)(66476007)(66556008)(110136005)(66446008)(64756008)(316002)(36756003)(2616005)(8936002)(86362001)(5660300002)(6506007)(478600001)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR11MB2736;H:SN6PR11MB3520.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1oIBOmSQ5v2A4e6ZcGZPTSX9wb0GnV2g7gz34Vgig8BCTnZhlF7p1Cf/XIAP57JCYLdbS8y4SzRN8wvAVNT1IXjUygYXhJx1KKQ9lRBvn2SOO0PXyDUXYKSDmJRPzxl+G0fUZk9Deh7q0QVFWb/WX5K7+1fuB9SWyRFvXP6zum3aU1P5AI0Gk7in/bvsr0t0PHCspzCr/GyID0VbbHdmuKxDAoFKzqgj5oqkYyTjEiEjf+zBOPdoRTNQkbC+UNcivHPp6fkeA/r63a+uHw216gOgAESUun3RTi2rGStxksLGwrkabw0E8yGiDCXZ4NFSXk+AugzpdD+hGxv1hR1qHzpAjYYkq8xUC4K28UlI6t63nkSF0piKq5z5potcabfPjTf8t5jPKuAFjqZ0pXBjWOW20QsWGal9k3f0Pv95/Q1BDqPBmrOaKP2AU64h+vmZ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5FBD2C7762481A40B93BA1F0B5DF61B3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a355620-e913-4ae5-6a6b-08d79929646a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 19:38:54.9821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U7RMLRvjbbrIv7ZxMP0tjytkMe1m2FtVHETqePgboE1YYV5YZlD2+rurvSBgVZpT8KFlqY4zXcZ+G6HErIjnJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2736
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGFsLA0KDQpPbiBNb24sIDIwMjAtMDEtMTMgYXQgMTM6MjcgKzAxMDAsIE1pY2hhxYIg
TG93YXMtUnplY2hvbmVrIHdyb3RlOg0KPiBUaGlzIGFsbG93cyBzcGVjaWZ5aW5nIGlvIHR5cGUg
YW5kIG9wdGlvbnMgd2hlbiBpbnZva2luZyB0aGUgZGFlbW9uLg0KPiANCj4gQnkgZGVmYXVsdCwg
bWVzaGQgcnVucyB3aXRoIE1FU0hfSU9fVFlQRV9HRU5FUklDIGFuZCB0cmllcyB0byBhdHRhY2gg
dG8NCj4gdGhlIGZpcnN0IGF2YWlsYWJsZSBIQ0kgaW50ZXJmYWNlLg0KPiANCj4gT3B0aW9uICIt
LWluZGV4PTxuPiIgaXMgbm93IGp1c3QgYSBzaG9ydGN1dCBmb3IgIi0taW89Z2VuZXJpYzo8bj4i
DQo+IC0tLQ0KPiAgbWVzaC9tYWluLmMgfCA5OSArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDgxIGluc2VydGlv
bnMoKyksIDE4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21lc2gvbWFpbi5jIGIv
bWVzaC9tYWluLmMNCj4gaW5kZXggMDEwZWRjZjg1Li4yNDNlNzU2ZjkgMTAwNjQ0DQo+IC0tLSBh
L21lc2gvbWFpbi5jDQo+ICsrKyBiL21lc2gvbWFpbi5jDQo+IEBAIC00MCwxMCArNDAsMTIgQEAN
Cj4gIA0KPiAgc3RhdGljIGNvbnN0IGNoYXIgKmNvbmZpZ19kaXI7DQo+ICBzdGF0aWMgY29uc3Qg
Y2hhciAqbWVzaF9jb25mX2ZuYW1lOw0KPiAtc3RhdGljIGludCBjdGxyX2luZGV4ID0gTUdNVF9J
TkRFWF9OT05FOw0KPiArc3RhdGljIGVudW0gbWVzaF9pb190eXBlIGlvX3R5cGU7DQo+ICtzdGF0
aWMgdm9pZCAqaW9fb3B0czsNCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvcHRpb24gbWFp
bl9vcHRpb25zW10gPSB7DQo+ICAJeyAiaW5kZXgiLAlyZXF1aXJlZF9hcmd1bWVudCwJTlVMTCwg
J2knIH0sDQo+ICsJeyAiaW8iLAkJcmVxdWlyZWRfYXJndW1lbnQsCU5VTEwsICdJJyB9LA0KPiAg
CXsgImNvbmZpZyIsCW9wdGlvbmFsX2FyZ3VtZW50LAlOVUxMLCAnYycgfSwNCj4gIAl7ICJub2Rl
dGFjaCIsCW5vX2FyZ3VtZW50LAkJTlVMTCwgJ24nIH0sDQo+ICAJeyAiZGVidWciLAlub19hcmd1
bWVudCwJCU5VTEwsICdkJyB9LA0KPiBAQCAtNTQsMTYgKzU2LDIzIEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3Qgb3B0aW9uIG1haW5fb3B0aW9uc1tdID0gew0KPiAgDQo+ICBzdGF0aWMgdm9pZCB1c2Fn
ZSh2b2lkKQ0KPiAgew0KPiAtCWxfaW5mbygiIik7DQo+IC0JbF9pbmZvKCJVc2FnZTpcbiINCj4g
KwlmcHJpbnRmKHN0ZGVyciwNCj4gKwkJIlVzYWdlOlxuIg0KPiAgCSAgICAgICAiXHRibHVldG9v
dGgtbWVzaGQgW29wdGlvbnNdXG4iKTsNCj4gLQlsX2luZm8oIk9wdGlvbnM6XG4iDQo+IC0JICAg
ICAgICJcdC0taW5kZXggPGhjaW51bT4gIFVzZSBzcGVjaWZpZWQgY29udHJvbGxlclxuIg0KPiAr
CWZwcmludGYoc3RkZXJyLA0KPiArCQkiT3B0aW9uczpcbiINCj4gKwkgICAgICAgIlx0LS1pbmRl
eCA8aGNpbnVtPiAgRXF1aXZhbGVudCBvZiBgLS1pbz1nZW5lcmljOjxoY2ludW0+YFxuIg0KPiAr
CSAgICAgICAiXHQtLWlvIDxpbz4gICAgICAgICBVc2Ugc3BlY2lmaWVkIGlvIChkZWZhdWx0OiBn
ZW5lcmljKVxuIg0KPiAgCSAgICAgICAiXHQtLWNvbmZpZyAgICAgICAgICBDb25maWd1cmF0aW9u
IGRpcmVjdG9yeVxuIg0KPiAgCSAgICAgICAiXHQtLW5vZGV0YWNoICAgICAgICBSdW4gaW4gZm9y
ZWdyb3VuZFxuIg0KPiAgCSAgICAgICAiXHQtLWRlYnVnICAgICAgICAgICBFbmFibGUgZGVidWcg
b3V0cHV0XG4iDQo+ICAJICAgICAgICJcdC0tZGJ1cy1kZWJ1ZyAgICAgIEVuYWJsZSBELUJ1cyBk
ZWJ1Z2dpbmdcbiINCj4gIAkgICAgICAgIlx0LS1oZWxwICAgICAgICAgICAgU2hvdyAlcyBpbmZv
cm1hdGlvblxuIiwgX19mdW5jX18pOw0KPiArCWZwcmludGYoc3RkZXJyLA0KPiArCSAgICAgICAi
aW86XG4iDQo+ICsJICAgICAgICJcdGdlbmVyaWNbOjxpbmRleD5dXG4iDQo+ICsJICAgICAgICJc
dFx0VXNlIGdlbmVyaWMgSENJIGlvIG9uIGludGVyZmFjZSBoY2k8aW5kZXg+LCBvciB0aGUgZmly
c3RcbiINCj4gKwkgICAgICAgIlx0XHRhdmFpbGFibGUgb25lXG4iKTsNCj4gIH0NCj4gIA0KPiAg
c3RhdGljIHZvaWQgZG9fZGVidWcoY29uc3QgY2hhciAqc3RyLCB2b2lkICp1c2VyX2RhdGEpDQo+
IEBAIC0xMDAsOCArMTA5LDggQEAgc3RhdGljIHZvaWQgcmVxdWVzdF9uYW1lX2NhbGxiYWNrKHN0
cnVjdCBsX2RidXMgKmRidXMsIGJvb2wgc3VjY2VzcywNCj4gIAkJcmV0dXJuOw0KPiAgCX0NCj4g
IA0KPiAtCWlmICghbWVzaF9pbml0KGNvbmZpZ19kaXIsIG1lc2hfY29uZl9mbmFtZSwgTUVTSF9J
T19UWVBFX0dFTkVSSUMsDQo+IC0JCQkJJmN0bHJfaW5kZXgsIG1lc2hfcmVhZHlfY2FsbGJhY2ss
IGRidXMpKSB7DQo+ICsJaWYgKCFtZXNoX2luaXQoY29uZmlnX2RpciwgbWVzaF9jb25mX2ZuYW1l
LCBpb190eXBlLCBpb19vcHRzLA0KPiArCQkJCQltZXNoX3JlYWR5X2NhbGxiYWNrLCBkYnVzKSkg
ew0KPiAgCQlsX2Vycm9yKCJGYWlsZWQgdG8gaW5pdGlhbGl6ZSBtZXNoIik7DQo+ICAJCWxfbWFp
bl9xdWl0KCk7DQo+ICAJfQ0KPiBAQCAtMTMzLDEyICsxNDIsNDQgQEAgc3RhdGljIHZvaWQgc2ln
bmFsX2hhbmRsZXIodWludDMyX3Qgc2lnbm8sIHZvaWQgKnVzZXJfZGF0YSkNCj4gIAl0ZXJtaW5h
dGVkID0gdHJ1ZTsNCj4gIH0NCj4gIA0KPiArc3RhdGljIGJvb2wgcGFyc2VfaW8oY29uc3QgY2hh
ciAqb3B0YXJnLCBlbnVtIG1lc2hfaW9fdHlwZSAqdHlwZSwgdm9pZCAqKm9wdHMpDQo+ICt7DQo+
ICsJaWYgKHN0cnN0cihvcHRhcmcsICJnZW5lcmljIikgPT0gb3B0YXJnKSB7DQo+ICsJCWludCAq
aW5kZXggPSBsX25ldyhpbnQsIDEpOw0KPiArDQo+ICsJCSp0eXBlID0gTUVTSF9JT19UWVBFX0dF
TkVSSUM7DQo+ICsJCSpvcHRzID0gaW5kZXg7DQo+ICsNCj4gKwkJb3B0YXJnICs9IHN0cmxlbigi
Z2VuZXJpYyIpOw0KPiArCQlpZiAoISpvcHRhcmcpIHsNCj4gKwkJCSppbmRleCA9IE1HTVRfSU5E
RVhfTk9ORTsNCj4gKwkJCXJldHVybiB0cnVlOw0KPiArCQl9DQo+ICsNCj4gKwkJaWYgKCpvcHRh
cmcgIT0gJzonKQ0KPiArCQkJcmV0dXJuIGZhbHNlOw0KPiArDQo+ICsJCW9wdGFyZysrOw0KPiAr
DQo+ICsJCWlmIChzc2NhbmYob3B0YXJnLCAiaGNpJWQiLCBpbmRleCkgPT0gMSkNCj4gKwkJCXJl
dHVybiB0cnVlOw0KPiArDQo+ICsJCWlmIChzc2NhbmYob3B0YXJnLCAiJWQiLCBpbmRleCkgPT0g
MSkNCj4gKwkJCXJldHVybiB0cnVlOw0KPiArDQo+ICsJCXJldHVybiBmYWxzZTsNCj4gKwl9DQo+
ICsNCj4gKwlyZXR1cm4gZmFsc2U7DQo+ICt9DQo+ICsNCj4gIGludCBtYWluKGludCBhcmdjLCBj
aGFyICphcmd2W10pDQo+ICB7DQo+ICAJaW50IHN0YXR1czsNCj4gIAlib29sIGRldGFjaGVkID0g
dHJ1ZTsNCj4gIAlib29sIGRidXNfZGVidWcgPSBmYWxzZTsNCj4gIAlzdHJ1Y3QgbF9kYnVzICpk
YnVzID0gTlVMTDsNCj4gKwljaGFyICppbyA9IE5VTEw7DQo+ICANCj4gIAlpZiAoIWxfbWFpbl9p
bml0KCkpDQo+ICAJCXJldHVybiAtMTsNCj4gQEAgLTE1Myw3ICsxOTQsNiBAQCBpbnQgbWFpbihp
bnQgYXJnYywgY2hhciAqYXJndltdKQ0KPiAgDQo+ICAJZm9yICg7Oykgew0KPiAgCQlpbnQgb3B0
Ow0KPiAtCQljb25zdCBjaGFyICpzdHI7DQo+ICANCj4gIAkJb3B0ID0gZ2V0b3B0X2xvbmcoYXJn
YywgYXJndiwgImk6YzpmOm5kYmgiLCBtYWluX29wdGlvbnMsIE5VTEwpOw0KPiAgCQlpZiAob3B0
IDwgMCkNCj4gQEAgLTE2MSwxOCArMjAxLDIwIEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICph
cmd2W10pDQo+ICANCj4gIAkJc3dpdGNoIChvcHQpIHsNCj4gIAkJY2FzZSAnaSc6DQo+IC0JCQlp
ZiAoc3RybGVuKG9wdGFyZykgPiAzICYmICFzdHJuY21wKG9wdGFyZywgImhjaSIsIDMpKQ0KPiAt
CQkJCXN0ciA9IG9wdGFyZyArIDM7DQo+IC0JCQllbHNlDQo+IC0JCQkJc3RyID0gb3B0YXJnOw0K
PiAtCQkJaWYgKCFpc2RpZ2l0KCpzdHIpKSB7DQo+IC0JCQkJbF9lcnJvcigiSW52YWxpZCBjb250
cm9sbGVyIGluZGV4IHZhbHVlIik7DQo+IC0JCQkJc3RhdHVzID0gRVhJVF9GQUlMVVJFOw0KPiAr
CQkJaWYgKGlvKSB7DQo+ICsJCQkJbF9lcnJvcigiVXNlIGVpdGhlciAtLWluZGV4IG9yIC0taW8s
IG5vdCBib3RoIik7DQo+ICsJCQkJc3RhdHVzID0gRVhJVF9TVUNDRVNTOw0KPiAgCQkJCWdvdG8g
ZG9uZTsNCj4gIAkJCX0NCj4gLQ0KPiAtCQkJY3Rscl9pbmRleCA9IGF0b2koc3RyKTsNCj4gLQ0K
PiArCQkJaW8gPSBsX3N0cmR1cF9wcmludGYoImdlbmVyaWM6JXMiLCBvcHRhcmcpOw0KPiArCQkJ
YnJlYWs7DQo+ICsJCWNhc2UgJ0knOg0KPiArCQkJaWYgKGlvKSB7DQo+ICsJCQkJbF9lcnJvcigi
VXNlIGVpdGhlciAtLWluZGV4IG9yIC0taW8sIG5vdCBib3RoIik7DQo+ICsJCQkJc3RhdHVzID0g
RVhJVF9TVUNDRVNTOw0KPiArCQkJCWdvdG8gZG9uZTsNCj4gKwkJCX0NCj4gKwkJCWlvID0gbF9z
dHJkdXAob3B0YXJnKTsNCj4gIAkJCWJyZWFrOw0KPiAgCQljYXNlICduJzoNCj4gIAkJCWRldGFj
aGVkID0gZmFsc2U7DQo+IEBAIC0yMDAsNiArMjQyLDIxIEBAIGludCBtYWluKGludCBhcmdjLCBj
aGFyICphcmd2W10pDQo+ICAJCX0NCj4gIAl9DQo+ICANCj4gKwlpZiAoIWlvKQ0KPiArCQlpbyA9
IGxfc3RyZHVwX3ByaW50ZigiZ2VuZXJpYyIpOw0KPiArDQo+ICsJaWYgKCFwYXJzZV9pbyhpbywg
JmlvX3R5cGUsICZpb19vcHRzKSkgew0KPiArCQlsX2Vycm9yKCJJbnZhbGlkIGlvOiAlcyIsIGlv
KTsNCj4gKwkJc3RhdHVzID0gRVhJVF9GQUlMVVJFOw0KPiArCQlnb3RvIGRvbmU7DQo+ICsJfQ0K
PiArDQo+ICsJaWYgKChpb190eXBlID09IE1FU0hfSU9fVFlQRV9OT05FKSAmJiAhaW9fb3B0cykg
ew0KPiArCQlpbnQgKmluZGV4ID0gbF9uZXcoaW50LCAxKTsNCj4gKwkJKmluZGV4ID0gTUdNVF9J
TkRFWF9OT05FOw0KPiArCQlpb190eXBlID0gTUVTSF9JT19UWVBFX0dFTkVSSUM7DQo+ICsJCWlv
X29wdHMgPSBpbmRleDsNCj4gKwl9DQo+ICANCj4gIAlpZiAoIWRldGFjaGVkKQ0KPiAgCQl1bWFz
aygwMDc3KTsNCj4gQEAgLTIyNSw2ICsyODIsMTIgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIg
KmFyZ3ZbXSkNCj4gIAlzdGF0dXMgPSBsX21haW5fcnVuX3dpdGhfc2lnbmFsKHNpZ25hbF9oYW5k
bGVyLCBOVUxMKTsNCj4gIA0KPiAgZG9uZToNCj4gKwlpZiAoaW8pDQo+ICsJCWxfZnJlZShpbyk7
DQo+ICsNCj4gKwlpZiAoaW9fb3B0cykNCj4gKwkJbF9mcmVlKGlvX29wdHMpOw0KPiArDQo+ICAJ
bWVzaF9jbGVhbnVwKCk7DQo+ICAJbF9kYnVzX2Rlc3Ryb3koZGJ1cyk7DQo+ICAJbF9tYWluX2V4
aXQoKTsNCg0KDQpJIHdvbmRlciBpZiBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gcmUtdXNlICItaSIg
b3B0aW9uIGJ5IGNoYW5naW5nIGl0J3MNCm1lYW5pbmcgZm9ybSAiaW5kZXgiIHRvICJpL28iLg0K
DQpTbyB0aGF0ICIgLWkgaGNpPCM+IiB3aWxsIG1hcCB0byBnZW5lcmljIGkvbyBvbiBhIHNwZWNp
ZmllZCBjb250cm9sbGVyDQphbmQgbm8gIi1pIiBvcHRpb24gbWVhbnMgYW55IGNvbnRyb2xsZXIu
DQogDQpZZXMsIHdlIHdpbGwgbG9vc2Ugc29tZSB1bmlmb3JtaXR5IGFjcm9zcyBhbGwgb2YgdGhl
IGJsdWV6IGluIGEgc2Vuc2UNCnRoYXQgIi1pIDwjPiIgd29uJ3Qgd29yaywgYnV0IGltbyBpdCdz
IHByZWZlcmFibGUgdG8gaGF2aW5nIHR3byBvcHRpb25zDQp3aXRoIGludGVyLWRlcGVuZGVjaWVz
Lg0KDQpCZXN0IHJlZ2FyZHMsDQoNCkluZ2ENCg0KDQogDQo=
