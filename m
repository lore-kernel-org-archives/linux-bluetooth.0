Return-Path: <SRS0=8Xmo=2A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFA5C43603
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Dec 2019 00:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE77206E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Dec 2019 00:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="efb0zaSn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfLJAns (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Dec 2019 19:43:48 -0500
Received: from mga02.intel.com ([134.134.136.20]:16646 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727213AbfLJAnr (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Dec 2019 19:43:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 16:43:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,297,1571727600"; 
   d="scan'208";a="210285160"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga008.fm.intel.com with ESMTP; 09 Dec 2019 16:43:46 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 9 Dec 2019 16:43:46 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 9 Dec 2019 16:43:46 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 9 Dec 2019 16:43:46 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.52) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 9 Dec 2019 16:43:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFdtHd/yFNjzEpK9krGMGEK6Clgi7eYXZIdpcBCvWNV6SjMSpA7XxLZxkR1eauMzttLe0COHKdOiRqiyPalEMDyuCHE87bBDDI9ubqe6sSJ54jtaPYlKBcM8FP5Coyhfw98PRz2Crx46rkox51D0PF7G+O0ZAUVv/Ve2aiVENRoofRa73Z2fxSAEK0gpN4D1r6g/w2KEpnftANYzkR15lrR8QecF/86NhsHIIb9HPPn0iTHnCFr+b9CNpyDUPDNzhNiRFjtcw3xalcnQYfPRnOUFxp/LI6vAvyCrbde+4wghBR7ztXCedD47s2fDjXFjLKMa2ktCWojlmHEisWiONA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTVmICbunGLm5zhUvTgTpfEBMChFXnOuLYNTy1S1ucw=;
 b=Rzlww/DPfIq8cLqpUSnm9lyIsqzfUEsFR2qaRWTWjEu6QsIFHYZ6IlzFAGWNeLKgaFEkNK5shCFmsRafj9/YPm1cKBkazToECILcMkoatW1TAKO6VIymxA3ISp50bwtC9uIENz49TZ2266W8qn7JZPIC4iGdynfEbN+J9IWToLfvthVlQXep6aZRv74wyy0Llmjdtcfq0+kBDBfZxQednsQEOxkvWNmmAvDkddsFi0lArNcG6wNgwh0feKQnXt7u6TFWnSgKQOYVsF03vgopfT6E5Pjrsn5Y82ULh/9ZqomRjhSl3m/lMeo1N78+/4CGSCVyRnCfY/S1G1lhNQl1MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTVmICbunGLm5zhUvTgTpfEBMChFXnOuLYNTy1S1ucw=;
 b=efb0zaSnqtQUXxb4TjoT8IB6QIPgO6hhHYKI2xFcvg7DoDXgzuMSNE89wVlQV1phBFiqYCJ2ogEt2BAX/JafJUCm0TmIY3PBlIJZ0qPn4HNe7qb6IEAFONDIUzR3SAxTN7FeBkuE0PNpiIj4RdryxBIjlM6FTf9nZMkzU2F7b8M=
Received: from SN6PR11MB3520.namprd11.prod.outlook.com (52.135.124.204) by
 SN6PR11MB3472.namprd11.prod.outlook.com (52.135.112.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Tue, 10 Dec 2019 00:43:45 +0000
Received: from SN6PR11MB3520.namprd11.prod.outlook.com
 ([fe80::ede7:c158:93c:ca45]) by SN6PR11MB3520.namprd11.prod.outlook.com
 ([fe80::ede7:c158:93c:ca45%7]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 00:43:45 +0000
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Gix, Brian" <brian.gix@intel.com>
Subject: Re: [PATCH BlueZ] tools/mesh-cfgclient: Disallow sending a
 non-existing key
Thread-Topic: [PATCH BlueZ] tools/mesh-cfgclient: Disallow sending a
 non-existing key
Thread-Index: AQHVrMVn1N4PmXv9HUugRgSgMQLskqeyjDOA
Date:   Tue, 10 Dec 2019 00:43:44 +0000
Message-ID: <baeff22c89284fb84104aa7d69477d4d3c459a9b.camel@intel.com>
References: <20191207061245.6845-1-inga.stotland@intel.com>
In-Reply-To: <20191207061245.6845-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=inga.stotland@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3ae46bb-6248-4498-c57f-08d77d0a0308
x-ms-traffictypediagnostic: SN6PR11MB3472:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB3472ADB9FD9E6BDAF2F55EF4FB5B0@SN6PR11MB3472.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 02475B2A01
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(136003)(39860400002)(366004)(376002)(199004)(189003)(6506007)(81166006)(81156014)(229853002)(2616005)(76116006)(71200400001)(5660300002)(86362001)(71190400001)(91956017)(6512007)(118296001)(305945005)(316002)(66556008)(66946007)(64756008)(478600001)(66476007)(66446008)(6916009)(36756003)(107886003)(26005)(6486002)(186003)(2906002)(4326008)(8936002)(5640700003)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR11MB3472;H:SN6PR11MB3520.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CoXH9J+mr4NcEAyTkQYtTYYecJdM+kOi3Z4vPLTpFfOA1Ul195JKNvy8BuV7LUcZTJvy0OU6gp18s7XhlVaEmtKVTu0lUBtsQTmmZhKu4jF2jzfKQJyzTsqJBoryflTIWBRFi9kSJ5gQrlp4z90fCKeCCC4czcyGr8/kWtSYxTVxYbp441Bd7UkJEzi24Qy/nABVazwCr1nLus8Rlf49mIN3l8Ot99p2jW+E8aEK+RiEYStyQUuVtHChaAvcH6xpUUvtVCRQd1tA1srdiq7HhXiwsSEpB2ROXo3G7HX3X2B6q5fpO384KJlwvTkSIvMXSaN3NknB7td2KrOYUTkTafUkV/nL62t89ExVWB8SAKyGsOkxJiP//aL8F2EiLdo5FlR5eR2fzbwuPbXqRLIIHfPad8P6PGc7yfc/6hSJNX/Ra+/3IllGwvyhrhDD9r7W
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC6776E49AD5C84984C33DEE263BD8DF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ae46bb-6248-4498-c57f-08d77d0a0308
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2019 00:43:44.8956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 98rmYHH/kjrnUPexYmjGkpegCrdxc7TPZK/vsjT+CL0n0UGnBJgezdkYnG6zCZGQcqu8eWEUlk/blfoePhRWLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3472
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGxlYXNlIGlnbm9yZS4gV2lsbCBzZW5kIGFuIHVwZGF0ZWQgdmVyc2lvbi4NCg0KT24gRnJpLCAy
MDE5LTEyLTA2IGF0IDIyOjEyIC0wODAwLCBJbmdhIFN0b3RsYW5kIHdyb3RlOg0KPiBQcmlvciB0
byBzZW5kaW5nIGVpdGhlciBOZXRLZXlBZGQgb3IgQXBwS2V5QWRkIG1lc3NhZ2UgdG8gYQ0KPiBy
ZW1vdGUgbm9kZSwgY2hlY2sgaWYgdGhlIGtleSBleGlzdHMgbG9jYWxseS4NCj4gLS0tDQo+ICB0
b29scy9tZXNoLWNmZ2NsaWVudC5jIHwgMTQgKysrKysrKysrKysrKy0NCj4gIHRvb2xzL21lc2gv
a2V5cy5jICAgICAgfCAgOCArKysrKysrKw0KPiAgdG9vbHMvbWVzaC9rZXlzLmggICAgICB8ICAx
ICsNCj4gIDMgZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL21lc2gtY2ZnY2xpZW50LmMgYi90b29scy9tZXNoLWNm
Z2NsaWVudC5jDQo+IGluZGV4IDIwMGViNWI4NC4uYjRkNzZkZTkzIDEwMDY0NA0KPiAtLS0gYS90
b29scy9tZXNoLWNmZ2NsaWVudC5jDQo+ICsrKyBiL3Rvb2xzL21lc2gtY2ZnY2xpZW50LmMNCj4g
QEAgLTMxNiw4ICszMTYsMjAgQEAgc3RhdGljIGJvb2wgc2VuZF9rZXkodm9pZCAqdXNlcl9kYXRh
LCB1aW50MTZfdCBkc3QsIHVpbnQxNl90IGtleV9pZHgsDQo+ICAJY29uc3QgY2hhciAqbWV0aG9k
X25hbWUgPSAoIWlzX2FwcGtleSkgPyAiQWRkTmV0S2V5IiA6ICJBZGRBcHBLZXkiOw0KPiAgDQo+
ICAJbmV0X2lkeCA9IHJlbW90ZV9nZXRfc3VibmV0X2lkeChkc3QpOw0KPiAtCWlmIChuZXRfaWR4
ID09IE5FVF9JRFhfSU5WQUxJRCkNCj4gKwlpZiAobmV0X2lkeCA9PSBORVRfSURYX0lOVkFMSUQp
IHsNCj4gKwkJYnRfc2hlbGxfcHJpbnRmKCJOb2RlICU0LjR4IG5vdCBmb3VuZFxuIiwgZHN0KTsN
Cj4gIAkJcmV0dXJuIGZhbHNlOw0KPiArCX0NCj4gKw0KPiArCWlmICghaXNfYXBwa2V5ICYmICFr
ZXlzX3N1Ym5ldF9leGlzdHMoa2V5X2lkeCkpIHsNCj4gKwkJYnRfc2hlbGxfcHJpbnRmKCJMb2Nh
bCBOZXRLZXkgJXUgbm90IGZvdW5kXG4iLCBrZXlfaWR4KTsNCj4gKwkJcmV0dXJuIGZhbHNlOw0K
PiArCX0NCj4gKw0KPiArCWlmIChpc19hcHBrZXkgJiYgKGtleXNfZ2V0X2JvdW5kX2tleShrZXlf
aWR4KSA9PSBORVRfSURYX0lOVkFMSUQpKSB7DQo+ICsJCWJ0X3NoZWxsX3ByaW50ZigiTG9jYWwg
QXBwS2V5ICV1IG5vdCBmb3VuZFxuIiwga2V5X2lkeCk7DQo+ICsJCXJldHVybiBmYWxzZTsNCj4g
Kwl9DQo+ICANCj4gIAlyZXEgPSBsX25ldyhzdHJ1Y3Qga2V5X2RhdGEsIDEpOw0KPiAgCXJlcS0+
ZWxlX3BhdGggPSB1c2VyX2RhdGE7DQo+IGRpZmYgLS1naXQgYS90b29scy9tZXNoL2tleXMuYyBi
L3Rvb2xzL21lc2gva2V5cy5jDQo+IGluZGV4IDdkMjA1ODI5NC4uMGNlOGNlODExIDEwMDY0NA0K
PiAtLS0gYS90b29scy9tZXNoL2tleXMuYw0KPiArKysgYi90b29scy9tZXNoL2tleXMuYw0KPiBA
QCAtMTczLDMgKzE3MywxMSBAQCB2b2lkIGtleXNfcHJpbnRfa2V5cyh2b2lkKQ0KPiAgew0KPiAg
CWxfcXVldWVfZm9yZWFjaChuZXRfa2V5cywgcHJpbnRfbmV0a2V5LCBOVUxMKTsNCj4gIH0NCj4g
Kw0KPiArYm9vbCBrZXlzX3N1Ym5ldF9leGlzdHModWludDE2X3QgaWR4KQ0KPiArew0KPiArCWlm
ICghbF9xdWV1ZV9maW5kKG5ldF9rZXlzLCBuZXRfaWR4X21hdGNoLCBMX1VJTlRfVE9fUFRSKGlk
eCkpKQ0KPiArCQlyZXR1cm4gZmFsc2U7DQo+ICsNCj4gKwlyZXR1cm4gdHJ1ZTsNCj4gK30NCj4g
ZGlmZiAtLWdpdCBhL3Rvb2xzL21lc2gva2V5cy5oIGIvdG9vbHMvbWVzaC9rZXlzLmgNCj4gaW5k
ZXggMmE5ZmFlZGU2Li43MWMzYmIzOTAgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL21lc2gva2V5cy5o
DQo+ICsrKyBiL3Rvb2xzL21lc2gva2V5cy5oDQo+IEBAIC0yMyw0ICsyMyw1IEBAIHZvaWQga2V5
c19kZWxfbmV0X2tleSh1aW50MTZfdCBuZXRfaWR4KTsNCj4gIHZvaWQga2V5c19hZGRfYXBwX2tl
eSh1aW50MTZfdCBuZXRfaWR4LCB1aW50MTZfdCBhcHBfaWR4KTsNCj4gIHZvaWQga2V5c19kZWxf
YXBwX2tleSh1aW50MTZfdCBhcHBfaWR4KTsNCj4gIHVpbnQxNl90IGtleXNfZ2V0X2JvdW5kX2tl
eSh1aW50MTZfdCBhcHBfaWR4KTsNCj4gK2Jvb2wga2V5c19zdWJuZXRfZXhpc3RzKHVpbnQxNl90
IGlkeCk7DQo+ICB2b2lkIGtleXNfcHJpbnRfa2V5cyh2b2lkKTsNCg==
