Return-Path: <SRS0=kXS7=33=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0335AC2BA83
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Feb 2020 17:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20772082E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Feb 2020 17:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="A3CAlKlc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgBGR2I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Feb 2020 12:28:08 -0500
Received: from mga18.intel.com ([134.134.136.126]:20292 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726901AbgBGR2I (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Feb 2020 12:28:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 09:28:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,414,1574150400"; 
   d="scan'208";a="312088281"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga001.jf.intel.com with ESMTP; 07 Feb 2020 09:28:07 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 7 Feb 2020 09:28:07 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 7 Feb 2020 09:28:06 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 7 Feb 2020 09:28:06 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 7 Feb 2020 09:28:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/zGG/+XbIWSymsIM8x9EGXGfw8K61EKs2m8iXuG5wgcaMTXfoqucVM0MN8rbEdpexI2iYd8rsdpKVn1mEPH5hb90qm/v5zvu0nU+GBjTOxQyZI4op8/BK//8ARVaMw07dm3M7Ac+S4GDvVs9uSJLkcIHTWIKAfuMgGjd3cz1Sj+BgUzwWBAlVy0e2gefDossZR/1J0rE6zUlD9Yc+3ZuKY/QjNBKSj/xOJKU2CLmuWfgTEEacXV3k1Gc640rVyZCux7asAZ7gG+z5kR6uiVHOOmDk4Ue+EoSEGn+PwpJHJ6QUKB00YJrR9sn0ks1WCXzyDbYU35T9X2bxH+FfYd/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzNAxhL6eSZsid3PJNqVA7IDtUuVmOyGsWOBbAnlW68=;
 b=lgm7HHTVNDz5N6C/1gqFYrj69gHL6V3CZNKRLsPKxt2u1q96/vo8NhwrPVgsVH8w9szisRpeep5Bp9BRib5fBFRWJO+tXzKRKFF9PHK3Y+71qxp1wRvwHxPS9ySDPeFtcSB3uJ6wRYAGBh8k78hl3uVE0NssJOVbjUljlYcfktclWrWYfj4vhUQYfRDklN9mB7jALep2ughXpOHL+JlCQt+KBERwBYZ6H37Mm1zm87LnPdJ7lnlDHmOebCdKzDJ42IgDJmsSB7v0hqCde0HdI7AKYlfgeu9gubBC4tMy/mLOWq947GlQmNE9YqGIGAY4YtYaNl2/hkJc0PqocgiB4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzNAxhL6eSZsid3PJNqVA7IDtUuVmOyGsWOBbAnlW68=;
 b=A3CAlKlcrZmAKhLRsViMq1EXQDnVuTnwn/puo/mOtuHMMTzactMyN/UrpeJIKDRh0qxyEpeuGwop6NS1shz5xGcs+SLBz/MuwsuRXXVwEZUFA4oUhXMBq7D+kPAyEwFRpGgaBIhfKuqeRnnPVv/9/yE5+TssrVtz0fSi3tXLcOQ=
Received: from BN7PR11MB2580.namprd11.prod.outlook.com (52.135.246.155) by
 BN7PR11MB2676.namprd11.prod.outlook.com (52.135.254.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Fri, 7 Feb 2020 17:28:04 +0000
Received: from BN7PR11MB2580.namprd11.prod.outlook.com
 ([fe80::c8ca:3c11:3fc5:a9d6]) by BN7PR11MB2580.namprd11.prod.outlook.com
 ([fe80::c8ca:3c11:3fc5:a9d6%6]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 17:28:04 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Fix keyring app keys directory iteration
Thread-Topic: [PATCH BlueZ] mesh: Fix keyring app keys directory iteration
Thread-Index: AQHV3YFx9s8bVEieqUWcE7IP5TyAcagP/OSA
Date:   Fri, 7 Feb 2020 17:28:03 +0000
Message-ID: <bae967fc6137344054860d57dd24e1a0c22cb799.camel@intel.com>
References: <20200207063945.21943-1-inga.stotland@intel.com>
In-Reply-To: <20200207063945.21943-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72afd6fd-7a85-4f8d-a7ce-08d7abf316a1
x-ms-traffictypediagnostic: BN7PR11MB2676:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR11MB2676713035F45462D30D0E68E11C0@BN7PR11MB2676.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:546;
x-forefront-prvs: 0306EE2ED4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(346002)(376002)(366004)(199004)(189003)(26005)(6512007)(6636002)(2616005)(86362001)(6506007)(478600001)(186003)(2906002)(5660300002)(36756003)(6486002)(110136005)(71200400001)(81156014)(8676002)(8936002)(66946007)(91956017)(66446008)(66556008)(64756008)(66476007)(76116006)(316002)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR11MB2676;H:BN7PR11MB2580.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fucjyQdScj38XqxV2wTpG8xOx7KwUEXg8dErgHJU5lN6mo7V4JtDJ9Z1jSE5y2bPjlL1bF7NQSVSW9FrmGn62L+urMMyvZrJYlp9dsIY91ya1QbFrDJ1Ui1mokJ9LiPAqak6FLbtUCcmfqQbHXITHWFR5P9EK97xfhsEYQEvkU+oJoU9OWfWSTY7K/g4iJQVwxcZLPaeZRsq0lEihug8vtjw4fAFUnlfCM+jpRSHUHSjddfi0OSt79uVJ5tvNQUJ2loVpaFIHovvADzkl3zUjgp2YVTV1KeJqR98/zDLUEhhdlRdlLugXl2+WvYD0by/Sjslukom5cZfCY9ldSNiIH65DPwnKs6zRt3jVV2sPceb1wGOUc0kAmXGgeFIjvtvh2qNJ2pXtQj546WCHOb1xGhY6O7HfAaTZQ0r3geaDZ6THo1W1drx7lhozjafme7k
x-ms-exchange-antispam-messagedata: 6ejTA+aVdoAjuEN8aR9smPZWTpi3wcbpNoIN0+3eZIgRtXlsNTy7JDZV6NyYVAG5xB6Uh6ahD4ylvI9SYYtleRXZdxFlJyDWvqxWmyV3msop1krnr1fKoM8ZfvHhGVhBKoNzsgvXNIRq8xi3X6c/XQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <949AB1239A85F140B9043569724093E6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 72afd6fd-7a85-4f8d-a7ce-08d7abf316a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2020 17:28:03.8761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aMJjmBU3IdNHYuw1czSrqYpT5MvN2dToK/ViPBOdTxlWrDtVrbxSx2R4BiKmea2OMCVTiMJeZCvcuCZJMMi8iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2676
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gVGh1LCAyMDIwLTAyLTA2IGF0IDIyOjM5IC0wODAwLCBJbmdhIFN0b3RsYW5k
IHdyb3RlOg0KPiBUaGlzIGZpeGVzIGhvdyBhcHAga2V5IGZpbGVzIGFyZSBhY2Nlc3NlZCB3aGVu
IGZpbmFsaXppbmcNCj4gS2V5IFJlZnJlc2ggcHJvY2VkdXJlLiBJbnN0ZWFkIG9mIHVzaW5nIG9w
ZW4oZW50cnktPmRfbmFtZSwgLi4uKQ0KPiB0byBnZXQgZmlsZSBkZXNjcmlwdG9yLCB1c2Ugb3Bl
bmF0KGRpcl9mZCwgZW50cnktPmRfbmFtZSwgLi4uKQ0KPiBzaW5jZSBlbnRyeS0+ZF9uYW1lIGNv
bnRhaW5zIGEgcmVsYXRpdmUgYXBwIGtleSBmaWxlbmFtZSwgbm90IGFuDQo+IGFic29sdXRlIHBh
dGguDQo+IC0tLQ0KPiAgbWVzaC9rZXlyaW5nLmMgfCAxMSArKysrKysrLS0tLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9tZXNoL2tleXJpbmcuYyBiL21lc2gva2V5cmluZy5jDQo+IGluZGV4IDQxY2IyZTk4MC4u
MjljNWYxZThlIDEwMDY0NA0KPiAtLS0gYS9tZXNoL2tleXJpbmcuYw0KPiArKysgYi9tZXNoL2tl
eXJpbmcuYw0KPiBAQCAtMTIzLDEyICsxMjMsMTIgQEAgYm9vbCBrZXlyaW5nX3B1dF9hcHBfa2V5
KHN0cnVjdCBtZXNoX25vZGUgKm5vZGUsIHVpbnQxNl90IGFwcF9pZHgsDQo+ICAJcmV0dXJuIHJl
c3VsdDsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIHZvaWQgZmluYWxpemUoY29uc3QgY2hhciAqZnBh
dGgsIHVpbnQxNl90IG5ldF9pZHgpDQo+ICtzdGF0aWMgdm9pZCBmaW5hbGl6ZShpbnQgZGlyX2Zk
LCBjb25zdCBjaGFyICpmbmFtZSwgdWludDE2X3QgbmV0X2lkeCkNCj4gIHsNCj4gIAlzdHJ1Y3Qg
a2V5cmluZ19hcHBfa2V5IGtleTsNCj4gIAlpbnQgZmQ7DQo+ICANCj4gLQlmZCA9IG9wZW4oZnBh
dGgsIE9fUkRXUik7DQo+ICsJZmQgPSBvcGVuYXQoZGlyX2ZkLCBmbmFtZSwgT19SRFdSKTsNCj4g
IA0KPiAgCWlmIChmZCA8IDApDQo+ICAJCXJldHVybjsNCj4gQEAgLTEzNyw3ICsxMzcsNyBAQCBz
dGF0aWMgdm9pZCBmaW5hbGl6ZShjb25zdCBjaGFyICpmcGF0aCwgdWludDE2X3QgbmV0X2lkeCkN
Cj4gIAkJCQkJCWtleS5uZXRfaWR4ICE9IG5ldF9pZHgpDQo+ICAJCWdvdG8gZG9uZTsNCj4gIA0K
PiAtCWxfZGVidWcoIkZpbmFsaXplICVzIiwgZnBhdGgpOw0KPiArCWxfZGVidWcoIkZpbmFsaXpl
ICVzIiwgZm5hbWUpOw0KPiAgCW1lbWNweShrZXkub2xkX2tleSwga2V5Lm5ld19rZXksIDE2KTsN
Cj4gIAlsc2VlayhmZCwgMCwgU0VFS19TRVQpOw0KPiAgDQo+IEBAIC0xNTMsNiArMTUzLDcgQEAg
Ym9vbCBrZXlyaW5nX2ZpbmFsaXplX2FwcF9rZXlzKHN0cnVjdCBtZXNoX25vZGUgKm5vZGUsIHVp
bnQxNl90IG5ldF9pZHgpDQo+ICAJY29uc3QgY2hhciAqbm9kZV9wYXRoOw0KPiAgCWNoYXIga2V5
X2RpcltQQVRIX01BWF07DQo+ICAJRElSICpkaXI7DQo+ICsJaW50IGRpcl9mZDsNCj4gIAlzdHJ1
Y3QgZGlyZW50ICplbnRyeTsNCj4gIA0KPiAgCWlmICghbm9kZSkNCj4gQEAgLTE3MCwxMCArMTcx
LDEyIEBAIGJvb2wga2V5cmluZ19maW5hbGl6ZV9hcHBfa2V5cyhzdHJ1Y3QgbWVzaF9ub2RlICpu
b2RlLCB1aW50MTZfdCBuZXRfaWR4KQ0KPiAgCQlyZXR1cm4gZmFsc2U7DQo+ICAJfQ0KPiAgDQo+
ICsJZGlyX2ZkID0gZGlyZmQoZGlyKTsNCj4gKw0KPiAgCXdoaWxlICgoZW50cnkgPSByZWFkZGly
KGRpcikpICE9IE5VTEwpIHsNCj4gIAkJLyogQXBwS2V5cyBhcmUgc3RvcmVkIGluIHJlZ3VsYXIg
ZmlsZXMgKi8NCj4gIAkJaWYgKGVudHJ5LT5kX3R5cGUgPT0gRFRfUkVHKQ0KPiAtCQkJZmluYWxp
emUoZW50cnktPmRfbmFtZSwgbmV0X2lkeCk7DQo+ICsJCQlmaW5hbGl6ZShkaXJfZmQsIGVudHJ5
LT5kX25hbWUsIG5ldF9pZHgpOw0KPiAgCX0NCj4gIA0KPiAgCWNsb3NlZGlyKGRpcik7DQo=
