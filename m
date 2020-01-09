Return-Path: <SRS0=NtgA=26=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4758FC282DD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jan 2020 21:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067352067D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jan 2020 21:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="LjR5mu3p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgAIVXv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Jan 2020 16:23:51 -0500
Received: from mga18.intel.com ([134.134.136.126]:62703 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgAIVXv (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Jan 2020 16:23:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 13:23:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,414,1571727600"; 
   d="scan'208";a="236141277"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga002.jf.intel.com with ESMTP; 09 Jan 2020 13:23:50 -0800
Received: from fmsmsx156.amr.corp.intel.com (10.18.116.74) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Jan 2020 13:23:50 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx156.amr.corp.intel.com (10.18.116.74) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Jan 2020 13:23:49 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 9 Jan 2020 13:23:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfIp03GYPQgiEHCFaIML/KLaczAp8Bov0eD3UUaHBYzwo+RXlDmisORFqn83sepfMhw128iFCRFTgpIuTI8MO7tnjq4lbWyFE6L61UCVSjwm/wwAOtq+PtW6Kw59PvX4y1+WHn8+j3cuSBu9bOQGQLEfAJZGroWVlVy7QegMSWZtCd6ANLF05EagldM9oDL4q+ghT7SBES88Z72IvLEroq7s00GSqO5ZnVo5Xmtf+gtqra36N0hC2Eiq1n7k3pbFwP7o4htyhK4JBkoF9xKsncbjXbRElHGuekwRLcoTMbFoTiVj9Dxep18qhVv/W3BI6YFInJTM1PAyB3x5OgA2WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBAfi1/PvoSnQjH9fVVxJEo/ngl0Uf30cjyzqqJdSqQ=;
 b=RhICJjYsnsNX2PNnLDnm4gAgumaff8dE+n3FnT830kvGf2qn6zrH2E3TB8oDz1sKJTI/B9uGsS8R2xY8g3xlyamO/R2Tpqq2qaTJY0oNKMNnbzT+e6y/yf/cv0uJRpICbPNdfsuU4pV9nrPWWDxBL7onJXc3/2xXEvvhI2UMMpascvnh4OoFj2Y6EbqkjLo27opGf7DuNVGi4uTWP2BbIOVeqKDI67Ycwi3R9cnEcDKu2dldxAunazFD2/Y+32Vl0/PQ9uwp5L3/ElZGHK4FmaNvwDFSOjFkrUkExmNyhSz/jwMmly0x913e3HvepNLZYXsFfwzBmblzpnje/VQtZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBAfi1/PvoSnQjH9fVVxJEo/ngl0Uf30cjyzqqJdSqQ=;
 b=LjR5mu3pJly+cVd0hJSBRQru0vhoeT9JjY8rnAu2YAFtCL/4Dyvn6rArzrbCtF+5nE3Ru62/MJICnT2daYBdSlIigkDMGs8XAVT336L1LsUkM5gg61Spp/kC7gRuE8qn1ZSRnz4kmRLkw/fpD5Zx40Z+9ItwsQ9j/ATyZUbdpMs=
Received: from SN6PR11MB3520.namprd11.prod.outlook.com (52.135.124.204) by
 SN6PR11MB3327.namprd11.prod.outlook.com (52.135.111.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Thu, 9 Jan 2020 21:23:34 +0000
Received: from SN6PR11MB3520.namprd11.prod.outlook.com
 ([fe80::ede7:c158:93c:ca45]) by SN6PR11MB3520.namprd11.prod.outlook.com
 ([fe80::ede7:c158:93c:ca45%7]) with mapi id 15.20.2623.010; Thu, 9 Jan 2020
 21:23:34 +0000
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
CC:     "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: Correctly generate NetKey list
Thread-Topic: [PATCH BlueZ] mesh: Correctly generate NetKey list
Thread-Index: AQHVxxZodwkQV3uMbEymAVqZHxHaiqfi0V0AgAAGjYA=
Date:   Thu, 9 Jan 2020 21:23:34 +0000
Message-ID: <a439d3aea87eddfe13f9e9759f8d2f4c4a245e28.camel@intel.com>
References: <20200109175715.22925-1-inga.stotland@intel.com>
         <20200109210006.e3qv6uxnr2w3isc5@kynes>
In-Reply-To: <20200109210006.e3qv6uxnr2w3isc5@kynes>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=inga.stotland@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c70b6e6-5187-4d7a-a3d6-08d7954a2ed9
x-ms-traffictypediagnostic: SN6PR11MB3327:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB3327474498B0CCC2D044F1E9FB390@SN6PR11MB3327.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(189003)(199004)(8676002)(2906002)(5660300002)(64756008)(66556008)(81156014)(54906003)(6486002)(8936002)(81166006)(36756003)(6512007)(66476007)(66946007)(76116006)(91956017)(86362001)(66446008)(26005)(6916009)(498600001)(2616005)(4326008)(6506007)(186003)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR11MB3327;H:SN6PR11MB3520.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x4lvIdNq7XfFcT/t0NwGhykJfVOCfLFEgkor+OvdWCO7hN3PiJPWiBXXvLUGKvNVAvSEeP8BrQ9Xc98U1tvLtCeNgxEqao7CGel0nrOMth1rpqGXBXhreK6gKIMTQ9SwYxowgYOubysRnprExqCdaCjMhsbg7m8v1OrsRAGTKlO3EAWk/lvb+2hU6Oi1Tdy7YewFhuqJc8kMUZ96QaYGzxEyk660kTKkmj8WucQWBECfknnTCEPQzzfAToZc0ZQF3mzxlFNcRzRa2hJCDibYakjk+Ddmv22dQnLLDsKldWvO3hZNFZqi6reHWS9JigMjq1S7j13kneQOud2v3OSzMa8BKJG2QOsNSV05RkdyqAkogy4TK6wCBWQP105sMPx+XaDE7lSm0XoKKVbN0SXPIOj4vERxoYbrD2+nFEgSx5nozNYpDpY6uo+4JC3Sn5bH
Content-Type: text/plain; charset="utf-8"
Content-ID: <B24A312D899FCF438C29E9F73F4BDCDA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c70b6e6-5187-4d7a-a3d6-08d7954a2ed9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 21:23:34.1078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KgmEz8PGmzdhv4DfS3dmrYkbHMuIJedMM97fAsLFxS8k8+ExJPpE4Moiwm6bqDL+ohZUwQO/WAy3OYvI4UHHLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3327
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGFsLA0KDQpPbiBUaHUsIDIwMjAtMDEtMDkgYXQgMjI6MDAgKzAxMDAsIE1pY2hhxYIg
TG93YXMtUnplY2hvbmVrIHdyb3RlOg0KPiBIaSBJbmdhLA0KPiANCj4gT24gMDEvMDksIEluZ2Eg
U3RvdGxhbmQgd3JvdGU6DQo+ID4gV2hlbiByZXNwb25kaW5nIHdpdGggTmV0S2V5IExpc3QgU3Rh
dHVzLCBwYWNrZWQgTmV0S2V5IGluZGljZXMgaW50bw0KPiA+IDMgb2N0ZXRzIHBlciBwYWlyLiBJ
ZiBudW1iZXIgb2YgTmV0S2V5cyBpcyBvZGQsIGFwcGVuZCB0aGUgbGFzdCBrZXkNCj4gPiBpbmRl
eCBhcyBhIDItb2N0ZXQgdmFsdWUuDQo+ID4gLS0tDQo+ID4gIG1lc2gvbmV0LmMgfCAzNiArKysr
KysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDI4
IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL21l
c2gvbmV0LmMgYi9tZXNoL25ldC5jDQo+ID4gaW5kZXggMGE0ZDJlNzJjLi45MGViZGY0OTYgMTAw
NjQ0DQo+ID4gLS0tIGEvbWVzaC9uZXQuYw0KPiA+ICsrKyBiL21lc2gvbmV0LmMNCj4gPiBAQCAt
MTA2NSwyNiArMTA2NSw0NiBAQCBib29sIG1lc2hfbmV0X2dldF9rZXkoc3RydWN0IG1lc2hfbmV0
ICpuZXQsDQo+ID4gYm9vbCBuZXdfa2V5LCB1aW50MTZfdCBpZHgsDQo+ID4gIGJvb2wgbWVzaF9u
ZXRfa2V5X2xpc3RfZ2V0KHN0cnVjdCBtZXNoX25ldCAqbmV0LCB1aW50OF90ICpidWYsDQo+ID4g
dWludDE2X3QgKnNpemUpDQo+ID4gIHsNCj4gPiAgCWNvbnN0IHN0cnVjdCBsX3F1ZXVlX2VudHJ5
ICplbnRyeTsNCj4gPiAtCXVpbnQxNl90IG4sIGJ1Zl9zaXplOw0KPiA+ICsJdWludDE2X3QgbnVt
X2tleXMsIHJlcV9zaXplLCBidWZfc2l6ZTsNCj4gPiArCXN0cnVjdCBtZXNoX3N1Ym5ldCAqc3Vi
bmV0Ow0KPiA+ICANCj4gPiAgCWlmICghbmV0IHx8ICFidWYgfHwgIXNpemUpDQo+ID4gIAkJcmV0
dXJuIGZhbHNlOw0KPiA+ICANCj4gPiAgCWJ1Zl9zaXplID0gKnNpemU7DQo+ID4gLQlpZiAoYnVm
X3NpemUgPCBsX3F1ZXVlX2xlbmd0aChuZXQtPnN1Ym5ldHMpICogMikNCj4gPiArDQo+ID4gKwlu
dW1fa2V5cyA9IGxfcXVldWVfbGVuZ3RoKG5ldC0+c3VibmV0cyk7DQo+ID4gKwlyZXFfc2l6ZSA9
IChudW1fa2V5cyA+PiAxKSAqIDMgKyAobnVtX2tleXMgJSAyKSAqIDI7DQo+IA0KPiBQbGVhc2Ug
ZG9uJ3QgdXNlIGJpdCBzaGlmdHMgZm9yIGRpdmlzaW9uLg0KDQpXaHk/DQoNCj4gDQo+IEFsc28s
IEkgdGhpbmsgaXQncyBjbGVhcmVyIHRvIHdyaXRlIHRoaXMgYXM6DQo+ICAgICByZXFfc2l6ZSA9
IG51bV9rZXlzICogMyAtIG51bV9rZXlzICUgMg0KPiANCg0KVGhpcyBpcyBub3QgaG93IEkgcmVh
ZCB0aGUgc3BlYy4gV2UgbmVlZCB0byBwYWNrIDIga2V5IGluZGljZXMgaW4gMw0Kb2N0ZXRzLg0K
Rm9yIGV4YW1wbGUsIDQga2V5cyBhcmUgcGFja2VkIGluIDYgb2N0ZXRzIGFuZCA1IGtleXMgYXJl
IHBhY2tlZCBpbiA4DQpvY3RldHMuIA0KDQo+ID4gKw0KPiA+ICsJaWYgKGJ1Zl9zaXplIDwgcmVx
X3NpemUpDQo+ID4gIAkJcmV0dXJuIGZhbHNlOw0KPiA+ICANCj4gPiAtCW4gPSAwOw0KPiA+IC0J
ZW50cnkgPSBsX3F1ZXVlX2dldF9lbnRyaWVzKG5ldC0+c3VibmV0cyk7DQo+ID4gKwkqc2l6ZSA9
IHJlcV9zaXplOw0KPiA+ICsNCj4gPiArCS8qIFBhY2sgTmV0S2V5IGluZGljZXMgaW4gMyBvY3Rl
dHMgKi8NCj4gPiArCWZvciAoZW50cnkgPSBsX3F1ZXVlX2dldF9lbnRyaWVzKG5ldC0+c3VibmV0
cyk7IG51bV9rZXlzID4gMTspDQo+ID4gew0KPiA+ICsJCXVpbnQzMl90IGlkeF9wYWlyOw0KPiA+
ICANCj4gPiAtCWZvciAoOyBlbnRyeTsgZW50cnkgPSBlbnRyeS0+bmV4dCkgew0KPiA+IC0JCXN0
cnVjdCBtZXNoX3N1Ym5ldCAqc3VibmV0ID0gZW50cnktPmRhdGE7DQo+ID4gKwkJc3VibmV0ID0g
ZW50cnktPmRhdGE7DQo+ID4gKwkJaWR4X3BhaXIgPSBzdWJuZXQtPmlkeDsNCj4gPiArCQlpZHhf
cGFpciA8PD0gMTI7DQo+ID4gKw0KPiA+ICsJCXN1Ym5ldCA9IGVudHJ5LT5uZXh0LT5kYXRhOw0K
PiA+ICsJCWlkeF9wYWlyICs9IHN1Ym5ldC0+aWR4Ow0KPiA+ICsNCj4gPiArCQlsX3B1dF9sZTMy
KGlkeF9wYWlyLCBidWYpOw0KPiA+ICsJCWJ1ZiArPSAzOw0KPiA+ICsNCj4gPiArCQludW1fa2V5
cyAtPSAyOw0KPiA+ICsJCWVudHJ5ID0gZW50cnktPm5leHQtPm5leHQ7DQo+ID4gKwl9DQo+ID4g
IA0KPiA+ICsJLyogSWYgb2RkIG51bWJlciBvZiBOZXRLZXlzLCBmaWxsIGluIHRoZSBlbmQgb2Yg
dGhlIGJ1ZmZlciAqLw0KPiA+ICsJaWYgKG51bV9rZXlzICUgMikgew0KPiA+ICsJCXN1Ym5ldCA9
IGVudHJ5LT5kYXRhOw0KPiA+ICAJCWxfcHV0X2xlMTYoc3VibmV0LT5pZHgsIGJ1Zik7DQo+ID4g
LQkJbiArPSAyOw0KPiA+ICAJfQ0KPiA+ICANCj4gPiAtCSpzaXplID0gbjsNCj4gPiAgCXJldHVy
biB0cnVlOw0KPiA+ICB9DQo+IA0KPiBUZXN0ZWQtYnk6IE1pY2hhxYIgTG93YXMtUnplY2hvbmVr
IDwNCj4gbWljaGFsLmxvd2FzLXJ6ZWNob25la0BzaWx2YWlyLmNvbQ0KPiA+DQo+IA0KPiANCg==
