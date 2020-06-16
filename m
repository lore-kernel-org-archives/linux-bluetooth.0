Return-Path: <SRS0=6MVD=75=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67130C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 17:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34572214DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 17:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="CWd2NDKm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgFPRnh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Jun 2020 13:43:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:42831 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbgFPRnh (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Jun 2020 13:43:37 -0400
IronPort-SDR: r+YWuImsA5UE0m1BNiJhxDsWHoHzPrLQMfhJBEHUaa7A4lniAKApgnTWn9RauBhAk7t6j8G9jF
 fRU3L58wSyqQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 10:41:31 -0700
IronPort-SDR: 8LUepDPOZ8mngKuuXWzijMK3oybtEdPJoxaLUAA/cpEiYY4WexjAvQ7SGNUeTG6YAMbQTx0Dt9
 fCYJN66C1b/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,519,1583222400"; 
   d="scan'208";a="261489562"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga007.fm.intel.com with ESMTP; 16 Jun 2020 10:41:30 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 16 Jun 2020 10:41:30 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 16 Jun 2020 10:41:30 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 16 Jun 2020 10:41:30 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 16 Jun 2020 10:41:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OE4vLi643ah/prDw2z1qOZcGos0ikkdjdpyDp2HqDifC9wUyoXJhsVH7a4ouzN5G9zfOrRWQObI+Zu9HGldvEMHEEAcfdl7GTAk93GpWQfmFSXi13fFSTj20G2PGGROiM/v7JvKdlgou7rcYJ8R7Gn0if0JyT8Ikoc7OY0hiNZ1zZmQkYFfeqNGIVBMkgN5BwwsgwyC/AGkjVzc2JfiVIwBIWnSQQQXYT37mRu2hltFw0n/ziAO0dkqKmL8PDao3esHUTE0pngsICJ7ZvRzLvBFu1KPn6eCd0l3hKxIYL6R2r6cJAnDEXuFeqac1m52VoUcqML5p8KAa3DnLeloeOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekvWqTpwdjhDqPSGBkhI+VXunGiNuhov9FYNMxpwimk=;
 b=DnyVa3/nnf2UhFxIjC53OF6OFpTpx7pf7Oqj5LCP7ay1HSm5qFRokAUecZgDRXwqxKJ2TfDCr47vdJqYW6fk9+5hjAawGboJ3XdhUITkdpwbjzgiblZCcQl+V8QC4W/o6M1+UHshJfdL73Y+VtdylvF9A1Rig14/rJLkq7toCUqhUMFO/fTtGovjoTFpya3TK2qADgolxcmjx+ST2JI6ekwP+N+Y9yTj83Co4HNq9NsZ9C8JJBfns5O2M52fe0HrFBZSII256aCSK3QVeRLC6t3q9yq3qampg3lCSoPTQ28W0gg3zM+CX++V62u4yOSJgzyJYD7x8JXKu9W4pJHq6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekvWqTpwdjhDqPSGBkhI+VXunGiNuhov9FYNMxpwimk=;
 b=CWd2NDKmz5ZdPNy6s5kweXPGydJqim2KG+fsKlNu/kD2KBI4u3OrtS1L7B6T6CN5UhPwmC5AuHNeHy+VgPH8NdiR+5Ed/FFudsdYf2V1MWiy6ewJNmlU1T1+982sG3OBuLWIIVNAkUsYI31TN/4aO7l0Wpfy2Yzrx7TfOcKLu3Q=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR11MB1261.namprd11.prod.outlook.com (2603:10b6:300:28::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Tue, 16 Jun
 2020 17:41:27 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0%6]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 17:41:27 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Delete unused structures/functions
Thread-Topic: [PATCH BlueZ] mesh: Delete unused structures/functions
Thread-Index: AQHWQB54T0GGYQXTRE2ZlzEeWsG8D6jbinoA
Date:   Tue, 16 Jun 2020 17:41:26 +0000
Message-ID: <7efc5ad5d582567e974e94148a7c82fe29bd1051.camel@intel.com>
References: <20200611183038.96969-1-inga.stotland@intel.com>
In-Reply-To: <20200611183038.96969-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40655135-f94e-44e0-68d3-08d8121c7f1d
x-ms-traffictypediagnostic: MWHPR11MB1261:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB12613952BF7B9075595479CFE19D0@MWHPR11MB1261.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 04362AC73B
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vT6Yii4l+NBSMn7DvhwSYCAzp/9GDKUMrEkOoGHXDxUCtr9QHaXIOdASycvi5EBsDalohlYYk8u1G3NL9NHxqk52R2wp0Yk5frSIcryornYKlI/ZGciobffMpiZEeHfZmBnRNtIfPN6BM6ofexZlOT6AEP2bo9WAmbPaEvHch11un8J1rlnQCI0cHQfivonJA5e0ndk4F1PumjjMu6Om0D1JGFdfprma2w3Tj63+vNNBbZ/7bcjsaI3zRsucUuagzo8zo1RCe/Ut7VTYaKEK4gfBA3T1Uxt2sWxF/sxaWgOpCTeHBiMItHFqPZwXV2rlESDlka4bI6HINEdM7eAQEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(2616005)(86362001)(8676002)(110136005)(316002)(8936002)(66476007)(6636002)(64756008)(66446008)(83380400001)(71200400001)(66556008)(186003)(76116006)(66946007)(91956017)(36756003)(26005)(6512007)(2906002)(478600001)(5660300002)(6506007)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: RhoSCYg0qjsxxXmoktiSUE1ruP9+w8rY//Oh0g7KxBJ7s0AlqWMm9j2EyHHGsjovaZ611vEDTW9hYph/UcM6xqLmPOr98qdj4OWc0wDUAZs+rFsVj2jVxh9ZFAkMiSGNHNdB4QI3HY6RBA2FQ0U3mSs1xlhOZKhfga+tE+bJp9HnMOf/Rte3KrSLZGOp274QdHAgTYgn7Hwukjf74XUMB/rgQ6HEtMpPvVWlkNEUWGkPk5RlkN2CXRO8zQm0anCLWCPxkbbRH5qX+94/Z7YO9lUHEQkqAh1JSy977stA9C1SMYp0YmMjU77Z90tQtZlg3DmlNxJKqFazxyF4H/24Pd5cP3OtflxwKFinKFPu8WHBAZ/FuFqRR9UA79As31cCnZpkqIqeoTDIvEWa7lfInOMS3BEsITfQ7Z58Cg4e7YDcfeNxBi4tQ6cS/rXwLMhoxW0dNopViO4Hl6+qvTP/guunzNn0W+gMiJCgM+pkaXA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9BD040A79D0FCD4C9429FC4D33736190@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 40655135-f94e-44e0-68d3-08d8121c7f1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 17:41:26.8965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: by7psj9Lbz/Z8UvU2uUsnUXEVE0BzfNyB5Pb3gcJQJZPQ3Rym3Q3qaPQIJXUQyh/WQ7/7DlJVWJjTMbhKZE2Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1261
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gVGh1LCAyMDIwLTA2LTExIGF0IDExOjMwIC0wNzAwLCBJbmdhIFN0b3RsYW5k
IHdyb3RlOg0KPiBUaGlzIGRlbGV0ZXMgdW51c2VkIGZ1bmN0aW9ucyBhbmQgc3RydWN0dXJlcyBp
biBuZXQuYyAmIG5ldC5oLg0KPiBQbHVzLCBzb21lIHN0eWxlIGNsZWFudXAuDQo+IC0tLQ0KPiAg
bWVzaC9uZXQuYyB8IDY0ICsrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KPiAgbWVzaC9uZXQuaCB8ICAyIC0tDQo+ICAyIGZpbGVzIGNoYW5nZWQs
IDE1IGluc2VydGlvbnMoKyksIDUxIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21l
c2gvbmV0LmMgYi9tZXNoL25ldC5jDQo+IGluZGV4IDdkYmU0NWY3ZC4uM2FiOTQ4YmU1IDEwMDY0
NA0KPiAtLS0gYS9tZXNoL25ldC5jDQo+ICsrKyBiL21lc2gvbmV0LmMNCj4gQEAgLTU5LDYgKzU5
LDggQEANCj4gIA0KPiAgI2RlZmluZSBTQVJfS0VZKHNyYywgc2VxMCkJKCgoKHVpbnQzMl90KShz
ZXEwKSkgPDwgMTYpIHwgKHNyYykpDQo+ICANCj4gKyNkZWZpbmUgRkFTVF9DQUNIRV9TSVpFIDgN
Cj4gKw0KPiAgZW51bSBfcmVsYXlfYWR2aWNlIHsNCj4gIAlSRUxBWV9OT05FLAkJLyogUmVsYXkg
bm90IGVuYWJsZWQgaW4gbm9kZSAqLw0KPiAgCVJFTEFZX0FMTE9XRUQsCQkvKiBSZWxheSBlbmFi
bGVkLCBtc2cgbm90IHRvIG5vZGUncyB1bmljYXN0ICovDQo+IEBAIC0xNzksMzAgKzE4MSw2IEBA
IHN0cnVjdCBtZXNoX2Rlc3RpbmF0aW9uIHsNCj4gIAl1aW50MTZfdCByZWZfY250Ow0KPiAgfTsN
Cj4gIA0KPiAtc3RydWN0IG1zZ19yeCB7DQo+IC0JY29uc3QgdWludDhfdCAqZGF0YTsNCj4gLQl1
aW50MzJfdCBpdl9pbmRleDsNCj4gLQl1aW50MzJfdCBzZXE7DQo+IC0JdWludDE2X3Qgc3JjOw0K
PiAtCXVpbnQxNl90IGRzdDsNCj4gLQl1aW50MTZfdCBzaXplOw0KPiAtCXVpbnQ4X3QgdGM7DQo+
IC0JYm9vbCBkb25lOw0KPiAtCWJvb2wgc3ptaWM7DQo+IC0JdW5pb24gew0KPiAtCQlzdHJ1Y3Qg
ew0KPiAtCQkJdWludDE2X3QgYXBwX2lkeDsNCj4gLQkJCXVpbnQ4X3Qga2V5X2FpZDsNCj4gLQkJ
fSBtOw0KPiAtCQlzdHJ1Y3Qgew0KPiAtCQkJdWludDE2X3Qgc2VxMDsNCj4gLQkJfSBhOw0KPiAt
CQlzdHJ1Y3Qgew0KPiAtCQkJdWludDhfdCBvcGNvZGU7DQo+IC0JCX0gYzsNCj4gLQl9IHU7DQo+
IC19Ow0KPiAtDQo+ICBzdHJ1Y3QgbmV0X2RlY29kZSB7DQo+ICAJc3RydWN0IG1lc2hfbmV0ICpu
ZXQ7DQo+ICAJc3RydWN0IG1lc2hfZnJpZW5kICpmcm5kOw0KPiBAQCAtMjQxLDcgKzIxOSw2IEBA
IHN0cnVjdCBuZXRfYmVhY29uX2RhdGEgew0KPiAgCWJvb2wgcHJvY2Vzc2VkOw0KPiAgfTsNCj4g
IA0KPiAtI2RlZmluZSBGQVNUX0NBQ0hFX1NJWkUgOA0KPiAgc3RhdGljIHN0cnVjdCBsX3F1ZXVl
ICpmYXN0X2NhY2hlOw0KPiAgc3RhdGljIHN0cnVjdCBsX3F1ZXVlICpuZXRzOw0KPiAgDQo+IEBA
IC0yODksNiArMjY2LDcgQEAgc3RhdGljIHZvaWQgdHJpZ2dlcl9oZWFydGJlYXQoc3RydWN0IG1l
c2hfbmV0ICpuZXQsIHVpbnQxNl90IGZlYXR1cmUsDQo+ICAJc3RydWN0IG1lc2hfbmV0X2hlYXJ0
YmVhdCAqaGIgPSAmbmV0LT5oZWFydGJlYXQ7DQo+ICANCj4gIAlsX2RlYnVnKCIlczogJTQuNHgg
LS0+ICVkIiwgX19mdW5jX18sIGZlYXR1cmUsIGluX3VzZSk7DQo+ICsNCj4gIAlpZiAoaW5fdXNl
KSB7DQo+ICAJCWlmIChuZXQtPmhlYXJ0YmVhdC5mZWF0dXJlcyAmIGZlYXR1cmUpDQo+ICAJCQly
ZXR1cm47IC8qIG5vIGNoYW5nZSAqLw0KPiBAQCAtNDAyLDE3ICszODAsMTUgQEAgc3RydWN0IG1l
c2hfZnJpZW5kICptZXNoX2ZyaWVuZF9uZXcoc3RydWN0IG1lc2hfbmV0ICpuZXQsIHVpbnQxNl90
IGRzdCwNCj4gIAlzdWJuZXQgPSBnZXRfcHJpbWFyeV9zdWJuZXQobmV0KTsNCj4gIAkvKiBUT0RP
OiB0aGUgcHJpbWFyeSBrZXkgbXVzdCBiZSBwcmVzZW50LCBkbyB3ZSBuZWVkIHRvIGFkZCBjaGVj
az8uICovDQo+ICANCj4gLQlmcm5kLT5uZXRfa2V5X2N1ciA9IG5ldF9rZXlfZnJuZF9hZGQoc3Vi
bmV0LT5uZXRfa2V5X2N1ciwNCj4gLQkJCQkJCQlkc3QsIG5ldC0+c3JjX2FkZHIsDQo+IC0JCQkJ
CQkJbHBfY250LCBmbl9jbnQpOw0KPiArCWZybmQtPm5ldF9rZXlfY3VyID0gbmV0X2tleV9mcm5k
X2FkZChzdWJuZXQtPm5ldF9rZXlfY3VyLCBkc3QsDQo+ICsJCQkJCQluZXQtPnNyY19hZGRyLCBs
cF9jbnQsIGZuX2NudCk7DQo+ICANCj4gIAlpZiAoIXN1Ym5ldC0+bmV0X2tleV91cGQpDQo+ICAJ
CXJldHVybiBmcm5kOw0KPiAgDQo+ICAJZnJuZC0+bmV0X2lkeCA9IHN1Ym5ldC0+aWR4Ow0KPiAt
CWZybmQtPm5ldF9rZXlfdXBkID0gbmV0X2tleV9mcm5kX2FkZChzdWJuZXQtPm5ldF9rZXlfdXBk
LA0KPiAtCQkJCQkJCWRzdCwgbmV0LT5zcmNfYWRkciwNCj4gLQkJCQkJCQlscF9jbnQsIGZuX2Nu
dCk7DQo+ICsJZnJuZC0+bmV0X2tleV91cGQgPSBuZXRfa2V5X2ZybmRfYWRkKHN1Ym5ldC0+bmV0
X2tleV91cGQsIGRzdCwNCj4gKwkJCQkJCW5ldC0+c3JjX2FkZHIsIGxwX2NudCwgZm5fY250KTsN
Cj4gIA0KPiAgCXJldHVybiBmcm5kOw0KPiAgfQ0KPiBAQCAtNDM2LDggKzQxMiw3IEBAIGJvb2wg
bWVzaF9mcmllbmRfY2xlYXIoc3RydWN0IG1lc2hfbmV0ICpuZXQsIHN0cnVjdCBtZXNoX2ZyaWVu
ZCAqZnJuZCkNCj4gIH0NCj4gIA0KPiAgdm9pZCBtZXNoX2ZyaWVuZF9zdWJfYWRkKHN0cnVjdCBt
ZXNoX25ldCAqbmV0LCB1aW50MTZfdCBscG4sIHVpbnQ4X3QgZWxlX2NudCwNCj4gLQkJCQkJCQl1
aW50OF90IGdycF9jbnQsDQo+IC0JCQkJCQkJY29uc3QgdWludDhfdCAqbGlzdCkNCj4gKwkJCQkJ
dWludDhfdCBncnBfY250LCBjb25zdCB1aW50OF90ICpsaXN0KQ0KPiAgew0KPiAgCXVpbnQxNl90
ICpuZXdfbGlzdDsNCj4gIAl1aW50MTZfdCAqZ3JwX2xpc3Q7DQo+IEBAIC00NjMsMTUgKzQzOCwx
MyBAQCB2b2lkIG1lc2hfZnJpZW5kX3N1Yl9hZGQoc3RydWN0IG1lc2hfbmV0ICpuZXQsIHVpbnQx
Nl90IGxwbiwgdWludDhfdCBlbGVfY250LA0KPiAgCWZybmQtPnUuYWN0aXZlLmdycF9jbnQgKz0g
Z3JwX2NudDsNCj4gIH0NCj4gIA0KPiAtdm9pZCBtZXNoX2ZyaWVuZF9zdWJfZGVsKHN0cnVjdCBt
ZXNoX25ldCAqbmV0LCB1aW50MTZfdCBscG4sDQo+IC0JCQkJCQl1aW50OF90IGNudCwNCj4gLQkJ
CQkJCWNvbnN0IHVpbnQ4X3QgKmRlbF9saXN0KQ0KPiArdm9pZCBtZXNoX2ZyaWVuZF9zdWJfZGVs
KHN0cnVjdCBtZXNoX25ldCAqbmV0LCB1aW50MTZfdCBscG4sIHVpbnQ4X3QgY250LA0KPiArCQkJ
CQkJCWNvbnN0IHVpbnQ4X3QgKmRlbF9saXN0KQ0KPiAgew0KPiAgCXVpbnQxNl90ICpncnBfbGlz
dDsNCj4gIAlpbnQxNl90IGksIGdycF9jbnQ7DQo+ICAJc2l6ZV90IGNudDE2ID0gY250ICogc2l6
ZW9mKHVpbnQxNl90KTsNCj4gLQlzdHJ1Y3QgbWVzaF9mcmllbmQgKmZybmQgPSBsX3F1ZXVlX2Zp
bmQobmV0LT5mcmllbmRzLA0KPiAtCQkJCQkJCW1hdGNoX2J5X2ZyaWVuZCwNCj4gKwlzdHJ1Y3Qg
bWVzaF9mcmllbmQgKmZybmQgPSBsX3F1ZXVlX2ZpbmQobmV0LT5mcmllbmRzLCBtYXRjaF9ieV9m
cmllbmQsDQo+ICAJCQkJCQkJTF9VSU5UX1RPX1BUUihscG4pKTsNCj4gIAlpZiAoIWZybmQpDQo+
ICAJCXJldHVybjsNCj4gQEAgLTc0OSwxNCArNzIyLDYgQEAgYm9vbCBtZXNoX25ldF9yZWdpc3Rl
cl91bmljYXN0KHN0cnVjdCBtZXNoX25ldCAqbmV0LA0KPiAgCXJldHVybiB0cnVlOw0KPiAgfQ0K
PiAgDQo+IC11aW50OF90IG1lc2hfbmV0X2dldF9udW1fZWxlKHN0cnVjdCBtZXNoX25ldCAqbmV0
KQ0KPiAtew0KPiAtCWlmICghbmV0KQ0KPiAtCQlyZXR1cm4gMDsNCj4gLQ0KPiAtCXJldHVybiBu
ZXQtPmxhc3RfYWRkciAtIG5ldC0+c3JjX2FkZHIgKyAxOw0KPiAtfQ0KPiAtDQo+ICBib29sIG1l
c2hfbmV0X3NldF9wcm94eV9tb2RlKHN0cnVjdCBtZXNoX25ldCAqbmV0LCBib29sIGVuYWJsZSkN
Cj4gIHsNCj4gIAlpZiAoIW5ldCkNCj4gQEAgLTMzMTUsOCArMzI4MCwxMCBAQCBzdGF0aWMgdWlu
dDE2X3QgZ2V0X2ZlYXR1cmVzKHN0cnVjdCBtZXNoX25ldCAqbmV0KQ0KPiAgDQo+ICAJaWYgKG5l
dC0+cmVsYXkuZW5hYmxlKQ0KPiAgCQlmZWF0dXJlcyB8PSBGRUFUVVJFX1JFTEFZOw0KPiArDQo+
ICAJaWYgKG5ldC0+cHJveHlfZW5hYmxlKQ0KPiAgCQlmZWF0dXJlcyB8PSBGRUFUVVJFX1BST1hZ
Ow0KPiArDQo+ICAJaWYgKG5ldC0+ZnJpZW5kX2VuYWJsZSkNCj4gIAkJZmVhdHVyZXMgfD0gRkVB
VFVSRV9GUklFTkQ7DQo+ICANCj4gQEAgLTM1NTMsMTAgKzM1MjAsOSBAQCBib29sIG5ldF9tc2df
Y2hlY2tfcmVwbGF5X2NhY2hlKHN0cnVjdCBtZXNoX25ldCAqbmV0LCB1aW50MTZfdCBzcmMsDQo+
ICAJCQlsX2RlYnVnKCJJZ25vcmluZyByZXBsYXllZCBwYWNrZXQiKTsNCj4gIAkJCXJldHVybiB0
cnVlOw0KPiAgCQl9DQo+IC0JfQ0KPiArCX0gZWxzZSBpZiAobF9xdWV1ZV9sZW5ndGgobmV0LT5y
ZXBsYXlfY2FjaGUpID49IGNycGwpIHsNCj4gKwkJLyogU1JDIG5vdCBpbiBSZXBsYXkgQ2FjaGUu
Li4gc2VlIGlmIHRoZXJlIGlzIHNwYWNlIGZvciBpdCAqLw0KPiAgDQo+IC0JLyogU1JDIG5vdCBp
biBSZXBsYXkgQ2FjaGUuLi4gc2VlIGlmIHRoZXJlIGlzIHNwYWNlIGZvciBpdCAqLw0KPiAtCWVs
c2UgaWYgKGxfcXVldWVfbGVuZ3RoKG5ldC0+cmVwbGF5X2NhY2hlKSA+PSBjcnBsKSB7DQo+ICAJ
CWludCByZXQgPSBsX3F1ZXVlX2ZvcmVhY2hfcmVtb3ZlKG5ldC0+cmVwbGF5X2NhY2hlLA0KPiAg
CQkJCWNsZWFuX29sZF9pdl9pbmRleCwgTF9VSU5UX1RPX1BUUihpdl9pbmRleCkpOw0KPiAgDQo+
IGRpZmYgLS1naXQgYS9tZXNoL25ldC5oIGIvbWVzaC9uZXQuaA0KPiBpbmRleCBmN2ZlM2YxNTAu
LjcxMTdmMWE0NyAxMDA2NDQNCj4gLS0tIGEvbWVzaC9uZXQuaA0KPiArKysgYi9tZXNoL25ldC5o
DQo+IEBAIC0yNzAsNyArMjcwLDYgQEAgdm9pZCBtZXNoX25ldF9zZXRfZnJuZF9zZXEoc3RydWN0
IG1lc2hfbmV0ICpuZXQsIGJvb2wgc2VxKTsNCj4gIHVpbnQxNl90IG1lc2hfbmV0X2dldF9hZGRy
ZXNzKHN0cnVjdCBtZXNoX25ldCAqbmV0KTsNCj4gIGJvb2wgbWVzaF9uZXRfcmVnaXN0ZXJfdW5p
Y2FzdChzdHJ1Y3QgbWVzaF9uZXQgKm5ldCwNCj4gIAkJCQkJdWludDE2X3QgdW5pY2FzdCwgdWlu
dDhfdCBudW1fZWxlKTsNCj4gLXVpbnQ4X3QgbWVzaF9uZXRfZ2V0X251bV9lbGUoc3RydWN0IG1l
c2hfbmV0ICpuZXQpOw0KPiAgdm9pZCBuZXRfbG9jYWxfYmVhY29uKHVpbnQzMl90IGtleV9pZCwg
dWludDhfdCAqYmVhY29uKTsNCj4gIGJvb2wgbWVzaF9uZXRfc2V0X2JlYWNvbl9tb2RlKHN0cnVj
dCBtZXNoX25ldCAqbmV0LCBib29sIGVuYWJsZSk7DQo+ICBib29sIG1lc2hfbmV0X3NldF9wcm94
eV9tb2RlKHN0cnVjdCBtZXNoX25ldCAqbmV0LCBib29sIGVuYWJsZSk7DQo+IEBAIC0zMTAsNyAr
MzA5LDYgQEAgdm9pZCBtZXNoX25ldF9hY2tfc2VuZChzdHJ1Y3QgbWVzaF9uZXQgKm5ldCwgdWlu
dDMyX3Qga2V5X2lkLA0KPiAgCQkJCXVpbnQxNl90IHNlcVplcm8sIHVpbnQzMl90IGFja19mbGFn
cyk7DQo+ICBpbnQgbWVzaF9uZXRfZ2V0X2lkZW50aXR5X21vZGUoc3RydWN0IG1lc2hfbmV0ICpu
ZXQsIHVpbnQxNl90IGlkeCwNCj4gIAkJCQkJCQkJdWludDhfdCAqbW9kZSk7DQo+IC1jaGFyICpt
ZXNoX25ldF9pZF9uYW1lKHN0cnVjdCBtZXNoX25ldCAqbmV0KTsNCj4gIGJvb2wgbWVzaF9uZXRf
ZHN0X3JlZyhzdHJ1Y3QgbWVzaF9uZXQgKm5ldCwgdWludDE2X3QgZHN0KTsNCj4gIGJvb2wgbWVz
aF9uZXRfZHN0X3VucmVnKHN0cnVjdCBtZXNoX25ldCAqbmV0LCB1aW50MTZfdCBkc3QpOw0KPiAg
c3RydWN0IG1lc2hfZnJpZW5kICptZXNoX2ZyaWVuZF9uZXcoc3RydWN0IG1lc2hfbmV0ICpuZXQs
IHVpbnQxNl90IGRzdCwNCg==
