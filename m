Return-Path: <SRS0=zRH5=6U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D934C28CBC
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 15:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E521D208E4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 15:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="oxAT9CES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbgEFPNV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 May 2020 11:13:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:42584 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728784AbgEFPNU (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 May 2020 11:13:20 -0400
IronPort-SDR: 3GWXGnapFuRfXFJvF6nTXMpeRbEXSwR0fgKqDQ7WkVU+yy4DWqIOgSY76FcI8JdVrrF9cy3oXO
 GqOA2IJSs76w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 08:13:19 -0700
IronPort-SDR: tF1a6NIc86MGvs9CFjGYrsclzX6i/6D7vsxdu2YKOHdUlJxQE7gCazwqXQd4lw40izfIxdeDVH
 4bv3MPTVcCpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,359,1583222400"; 
   d="scan'208";a="461791398"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga006.fm.intel.com with ESMTP; 06 May 2020 08:13:19 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 6 May 2020 08:13:18 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 6 May 2020 08:13:18 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 6 May 2020 08:13:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 6 May 2020 08:13:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hR/iaeQWA4WAnAMXi1QyY9/K8LtYbY4kKUWtYAtPFiFolgsuppx7vC02583sTxot92Nq8nVf0YAnsuMrIEbEF++xgSUhhmdjLd9Lr94UPxnxAJ+tgs2zXccu7WB69hgCcCUAEAD4VFysuAtFzGon5S892g3V/GyYfolSHo0PQvP+LldHouh0Io8Moc4p0YsQhRy/SJxQSrJ32eAoxS4KsPyXlqo5cfxoogkYNC3N+lbXdWZVhlIcsUx5g2rrjN+iW8fKaTsnWukLisXFTMDXvF9h5ftBs88euRGFQaS30evI5UyupJ9mNmpFKOJ2XSkz/O2DPQUAmj56P7E8q14wfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6PxMwFPkyM2n5BeoJztqeQW77qkFktFsx0rxL8A0z8=;
 b=DXh6xaq4fyO/Vrr38b5b6WFUlOk8jW3vjAnnjs4WYoA5/pF0cvwfbTbcdrnsHRPrkW7UkcK8vpYROqooScMZHdve2/7KNQLlrqA1dB4R0Ba8Z2WQloSi0UTunvuOM47AxDJT5NIt8ePQBL4M+djSca9yXfN9Eu1DUQL8rLdPmG4dLpLyHuLPwI2av+2NeCyhZXC4oZBS/pOQsVLCMMyTbjXmJ1ZxAeHl/L+NAB+SrZWmR/88HchE7YiMQepeGAZQh0/EPRSpuwqOKWQHeWggOtUjcRJZ6Pp6L6LWaqdUquhIRisDN8ngIonVtH39Xo0AUKvHGx7q46A9ggflz9bquw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6PxMwFPkyM2n5BeoJztqeQW77qkFktFsx0rxL8A0z8=;
 b=oxAT9CEShGE3gtJnLq3qY461+BYhtWm64WWHMtxVKD+PertslyJm9dSpGX0o2awp5gEisDTSylgUKOW71GlWxVP93+n9TQ38rgj4t4G+jjD4HsXN0yj5xn3l7Kij9/lWGeMfYmsB/XMz6as7y598mfOffViCEuOhmn6mbyTtm3E=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4523.namprd11.prod.outlook.com (2603:10b6:303:5b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Wed, 6 May
 2020 15:13:16 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5552:f057:3dbf:716c]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5552:f057:3dbf:716c%3]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 15:13:16 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] tools/mesh-cfgclient: Fix saving KR phase to config
 file
Thread-Topic: [PATCH BlueZ] tools/mesh-cfgclient: Fix saving KR phase to
 config file
Thread-Index: AQHWIwS1a1uI3dCWh0qNonXi/ocMt6ibK7GA
Date:   Wed, 6 May 2020 15:13:15 +0000
Message-ID: <7c21e1760366bdb20438ff3339c9df68657ac57e.camel@intel.com>
References: <20200505174303.6224-1-inga.stotland@intel.com>
In-Reply-To: <20200505174303.6224-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebea6c65-5b7c-469e-9242-08d7f1d0007f
x-ms-traffictypediagnostic: MW3PR11MB4523:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB45236930F6EB8F0906103DF5E1A40@MW3PR11MB4523.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 03950F25EC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rebjYoKDZmEu8qHLLcICGiBgSnAbVVYNgZQRtpbgzOBeNAqA09vnCR3V7PA2I0l8C6zRXoWkpH+J4T6PmML+wFNOFdDT5poxlpiVlhNcZnOT58kjK6vBDGmrToXIOkxDMqVVyH4Z2JsZ+NNeuM05IVBWXR/MsB9LPicif5pF4t6hvCV8zn+IQjnJQAFQQ72kZDOiYCMxlQGWgZrB2IMbbt60wYgSJkBvzCK9avM1jFsslvQBqmn2Jhw5YU3dofx9X86yROtnlFnTV8SQm89tw7BvUoDo0+9plOFrgWhm5iIsOrYokNNrZbLqFfYgB7GozGavIDG3rzhLSnrbfrAgr9rkitRFw6OOEKmZmM9lWH9QD6WB6g5JqKa1s9mvpvXVxn/Hg994Tdoz8B9FJw+lN0JkmlHsarMK7HFL9OdOcKHlsqezwl5j19g8AQmqqCiikPAH7yt6dOdzBL8Z3gC1TkHvVYavHA6DFE618E0GNmktNjAkoTMmE54OijlE6B3RAymexs4qayReBWdIV+ih5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(39860400002)(366004)(136003)(396003)(346002)(33430700001)(76116006)(91956017)(316002)(66446008)(66476007)(66556008)(186003)(478600001)(64756008)(110136005)(33440700001)(2616005)(26005)(6506007)(6486002)(5660300002)(36756003)(6512007)(86362001)(2906002)(8676002)(8936002)(6636002)(71200400001)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: NATCp1rTC2AbN6qmmnC/0hC4ZBZDV32XCFhpbfAETy1hNQyHb1QZIZoVZ/M+K6nVxJchznvUn/ABwAcGsZx23qrwBYEw2V2Xtmd6YVlXsMNlIF7I5btWAYAaz0aeZx2f8+Ee/PWCdbobHZIVcmfid208sIWMaTrFuRXCumqjSHprXgd/twx6l97cpIHV6Evhlfen5/RroROMU0gvIJGxNSlDBNVDtLUc7kLyWPkPiO9Qm1LxEDW6lrW2JgbwztUhkXFXbeI4Fe87MATc8slxFVJqheR3INWIyVJ1697Wzxjp3WMrvZfDCys+Ipz542GNkExUAn8lz0Fd+pZZ6iiP2TeAS0y/wyzvuGLHNBL0S3g6yKlCywqElF06m6gHre9m68evwSl2nb69IqvcWmB4cMCfb8R8OlQEQRJZ+CfOj3NbgtnkWkucCY5Q9n1frhXs/JYb+TXUwrAuSyqds886o6RvWs3cZcE+TUX7GKjpxFb+BIASUgxIcTiHLxvkyzUD0LBPr1L0ztwbWMS62hSnrVBCTu+ssnK0mCyWhiR+2vZtaxHcSncwSM5r4vQ9/hkFHwyR4PpEuRkaZmBQGJd5rfvlxSfenazWaryokame6/qCYhTEJGizu7aIFB7K01CKWHNBOeWYHvNxkOjPFhMNhNhZELvY4RPBmff3PqpZw1U1TPMhc9JHB2ukq2i5Zyk2Q2ReeRihBHaryRR+eWS4tz+oKlvHVGDfPbUkVt+nR4lv5xKbpGb+/SsqZt+h/EAEzc9EODw1bIScZtVXlYiuKRErcmBzAsHDZ1q46KDAyyY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9CA9A7F59E478D47AE8BF9D6B90251D2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ebea6c65-5b7c-469e-9242-08d7f1d0007f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2020 15:13:15.8214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2SBGVBbpljqRIsj0peo6FOb4j5AH86GrZye6dHwS1XGb+f88NLpID0D3kYyUu3K3IUyjrl9fc53SDyibkkHXIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4523
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gVHVlLCAyMDIwLTA1LTA1IGF0IDEwOjQzIC0wNzAwLCBJbmdhIFN0b3RsYW5k
IHdyb3RlOg0KPiBUaGlzIGVsaW1pbmF0ZXMgZXh0cmEgd3JpdGUgb2YgS1IgcGhhc2Ugd2hlbiBs
b2FkaW5nIGtleXMNCj4gZnJvbSB0aGUgY29uZmlndXJhdGlvbiBmaWxlIG9uIGluaXRpYWxpemF0
aW9uLg0KPiAtLS0NCj4gIHRvb2xzL21lc2gtY2ZnY2xpZW50LmMgfCA0ICsrLS0NCj4gIHRvb2xz
L21lc2gva2V5cy5jICAgICAgfCA0ICsrLS0NCj4gIHRvb2xzL21lc2gva2V5cy5oICAgICAgfCAy
ICstDQo+ICB0b29scy9tZXNoL21lc2gtZGIuYyAgIHwgMiArLQ0KPiAgNCBmaWxlcyBjaGFuZ2Vk
LCA2IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdG9v
bHMvbWVzaC1jZmdjbGllbnQuYyBiL3Rvb2xzL21lc2gtY2ZnY2xpZW50LmMNCj4gaW5kZXggNmRi
NjVjZDQ5Li5kNzMxOGZmYjcgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL21lc2gtY2ZnY2xpZW50LmMN
Cj4gKysrIGIvdG9vbHMvbWVzaC1jZmdjbGllbnQuYw0KPiBAQCAtOTQ0LDcgKzk0NCw3IEBAIHN0
YXRpYyB2b2lkIHN1Ym5ldF9zZXRfcGhhc2VfcmVwbHkoc3RydWN0IGxfZGJ1c19wcm94eSAqcHJv
eHksDQo+ICAJaWYgKHBoYXNlID09IEtFWV9SRUZSRVNIX1BIQVNFX1RIUkVFKQ0KPiAgCQlwaGFz
ZSA9IEtFWV9SRUZSRVNIX1BIQVNFX05PTkU7DQo+ICANCj4gLQlrZXlzX3NldF9uZXRfa2V5X3Bo
YXNlKG5ldF9pZHgsIHBoYXNlKTsNCj4gKwlrZXlzX3NldF9uZXRfa2V5X3BoYXNlKG5ldF9pZHgs
IHBoYXNlLCB0cnVlKTsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIHZvaWQgc3VibmV0X3NldF9waGFz
ZV9zZXR1cChzdHJ1Y3QgbF9kYnVzX21lc3NhZ2UgKm1zZywgdm9pZCAqdXNlcl9kYXRhKQ0KPiBA
QCAtMTAxNCw3ICsxMDE0LDcgQEAgc3RhdGljIHZvaWQgbWdyX2tleV9yZXBseShzdHJ1Y3QgbF9k
YnVzX3Byb3h5ICpwcm94eSwNCj4gIAkJa2V5c19kZWxfbmV0X2tleShpZHgpOw0KPiAgCQltZXNo
X2RiX25ldF9rZXlfZGVsKGlkeCk7DQo+ICAJfSBlbHNlIGlmICghc3RyY21wKCJVcGRhdGVTdWJu
ZXQiLCBtZXRob2QpKSB7DQo+IC0JCWtleXNfc2V0X25ldF9rZXlfcGhhc2UoaWR4LCBLRVlfUkVG
UkVTSF9QSEFTRV9PTkUpOw0KPiArCQlrZXlzX3NldF9uZXRfa2V5X3BoYXNlKGlkeCwgS0VZX1JF
RlJFU0hfUEhBU0VfT05FLCB0cnVlKTsNCj4gIAl9IGVsc2UgaWYgKCFzdHJjbXAoIkRlbGV0ZUFw
cEtleSIsIG1ldGhvZCkpIHsNCj4gIAkJa2V5c19kZWxfYXBwX2tleShpZHgpOw0KPiAgCQltZXNo
X2RiX2FwcF9rZXlfZGVsKGlkeCk7DQo+IGRpZmYgLS1naXQgYS90b29scy9tZXNoL2tleXMuYyBi
L3Rvb2xzL21lc2gva2V5cy5jDQo+IGluZGV4IGI3ZDM2NTk5YS4uZmYzYjIzZjYxIDEwMDY0NA0K
PiAtLS0gYS90b29scy9tZXNoL2tleXMuYw0KPiArKysgYi90b29scy9tZXNoL2tleXMuYw0KPiBA
QCAtOTksNyArOTksNyBAQCB2b2lkIGtleXNfZGVsX25ldF9rZXkodWludDE2X3QgaWR4KQ0KPiAg
CWxfZnJlZShrZXkpOw0KPiAgfQ0KPiAgDQo+IC12b2lkIGtleXNfc2V0X25ldF9rZXlfcGhhc2Uo
dWludDE2X3QgbmV0X2lkeCwgdWludDhfdCBwaGFzZSkNCj4gK3ZvaWQga2V5c19zZXRfbmV0X2tl
eV9waGFzZSh1aW50MTZfdCBuZXRfaWR4LCB1aW50OF90IHBoYXNlLCBib29sIHNhdmUpDQo+ICB7
DQo+ICAJc3RydWN0IG5ldF9rZXkgKmtleTsNCj4gIA0KPiBAQCAtMTEyLDcgKzExMiw3IEBAIHZv
aWQga2V5c19zZXRfbmV0X2tleV9waGFzZSh1aW50MTZfdCBuZXRfaWR4LCB1aW50OF90IHBoYXNl
KQ0KPiAgDQo+ICAJa2V5LT5waGFzZSA9IHBoYXNlOw0KPiAgDQo+IC0JaWYgKCFtZXNoX2RiX25l
dF9rZXlfcGhhc2Vfc2V0KG5ldF9pZHgsIHBoYXNlKSkNCj4gKwlpZiAoc2F2ZSAmJiAhbWVzaF9k
Yl9uZXRfa2V5X3BoYXNlX3NldChuZXRfaWR4LCBwaGFzZSkpDQo+ICAJCWJ0X3NoZWxsX3ByaW50
ZigiRmFpbGVkIHRvIHNhdmUgdXBkYXRlZCBLUiBwaGFzZVxuIik7DQo+ICB9DQo+ICANCj4gZGlm
ZiAtLWdpdCBhL3Rvb2xzL21lc2gva2V5cy5oIGIvdG9vbHMvbWVzaC9rZXlzLmgNCj4gaW5kZXgg
M2E5MGZhMTRiLi5mYTUxMDQ0ZWYgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL21lc2gva2V5cy5oDQo+
ICsrKyBiL3Rvb2xzL21lc2gva2V5cy5oDQo+IEBAIC0yMCw3ICsyMCw3IEBADQo+ICANCj4gIHZv
aWQga2V5c19hZGRfbmV0X2tleSh1aW50MTZfdCBuZXRfaWR4KTsNCj4gIHZvaWQga2V5c19kZWxf
bmV0X2tleSh1aW50MTZfdCBuZXRfaWR4KTsNCj4gLXZvaWQga2V5c19zZXRfbmV0X2tleV9waGFz
ZSh1aW50MTZfdCBuZXRfaWR4LCB1aW50OF90IHBoYXNlKTsNCj4gK3ZvaWQga2V5c19zZXRfbmV0
X2tleV9waGFzZSh1aW50MTZfdCBuZXRfaWR4LCB1aW50OF90IHBoYXNlLCBib29sIHNhdmUpOw0K
PiAgYm9vbCBrZXlzX2dldF9uZXRfa2V5X3BoYXNlKHVpbnQxNl90IG5ldF9pZHgsIHVpbnQ4X3Qg
KnBoYXNlKTsNCj4gIHZvaWQga2V5c19hZGRfYXBwX2tleSh1aW50MTZfdCBuZXRfaWR4LCB1aW50
MTZfdCBhcHBfaWR4KTsNCj4gIHZvaWQga2V5c19kZWxfYXBwX2tleSh1aW50MTZfdCBhcHBfaWR4
KTsNCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL21lc2gvbWVzaC1kYi5jIGIvdG9vbHMvbWVzaC9tZXNo
LWRiLmMNCj4gaW5kZXggM2JkNmIwZDA2Li5kMzk0MzVjYTAgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xz
L21lc2gvbWVzaC1kYi5jDQo+ICsrKyBiL3Rvb2xzL21lc2gvbWVzaC1kYi5jDQo+IEBAIC02MDcs
NyArNjA3LDcgQEAgc3RhdGljIGJvb2wgbG9hZF9rZXlzKGpzb25fb2JqZWN0ICpqb2JqKQ0KPiAg
CQlpZiAoIWdldF9pbnQoamVudHJ5LCAicGhhc2UiLCAmcGhhc2UpKQ0KPiAgCQkJcmV0dXJuIGZh
bHNlOw0KPiAgDQo+IC0JCWtleXNfc2V0X25ldF9rZXlfcGhhc2UobmV0X2lkeCwgKHVpbnQ4X3Qp
IHBoYXNlKTsNCj4gKwkJa2V5c19zZXRfbmV0X2tleV9waGFzZShuZXRfaWR4LCAodWludDhfdCkg
cGhhc2UsIGZhbHNlKTsNCj4gIAl9DQo+ICANCj4gIAlqc29uX29iamVjdF9vYmplY3RfZ2V0X2V4
KGpvYmosICJhcHBLZXlzIiwgJmphcnJheSk7DQo=
