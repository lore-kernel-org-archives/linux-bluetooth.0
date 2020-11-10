Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35411C388F7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 18:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFF8D206D8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 18:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="hY9b3KAb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgKJS0r (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Nov 2020 13:26:47 -0500
Received: from mga03.intel.com ([134.134.136.65]:17703 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbgKJS0p (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Nov 2020 13:26:45 -0500
IronPort-SDR: 0UD3D1MpDx+Pt4HhPtGrEftAb1v9CtEGVSbn7cW4X76avS/V0CLoGWGpEJfXd4Hm9RrxtXoAec
 lzG/T1rwpqqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="170134351"
X-IronPort-AV: E=Sophos;i="5.77,467,1596524400"; 
   d="scan'208";a="170134351"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 10:26:42 -0800
IronPort-SDR: qFLn0efwGNYjF25t43JqomVVIu6bEZ8aRu/V/U3ye66ARDowpyLgOLJEwn3L+BolxM65WfpWNN
 vjj8sTZh/W9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,467,1596524400"; 
   d="scan'208";a="327777452"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga006.jf.intel.com with ESMTP; 10 Nov 2020 10:26:42 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Nov 2020 10:26:42 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 10 Nov 2020 10:26:42 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.53) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 10 Nov 2020 10:26:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLhc7eCVYyNK56Fmr/A64VcaAh+uou1rEBJt8JTVEpoGJdebomVflvV2qt6++kp6aaTCLemFLNnB2GpTizwRL9TBdbCFhFtPrCsia4YIrgkdVqtIg4KU4HkskV5IDrIYW+8/QREgD90feFDl/qCDdaevR8rDx53SAAxPQRcO9m3WircHwcIQY/8dUrtwntkDoJ2GchVvNhQruPGv75SMsM8rTw1eKJxAavzQNuN4sQcsO7v2fv1b/g78FSgf2dwxKxdv07ANmn6k7LnfeY5wi/sp7HT1YTp3nDgBMN2FDtlx9t33tStRtThC7kDlLoI/kxpH4P3Lvpz3eIor+nlCvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fXN/+i3GHoq8CQpsn2irq7sM6BeOp7JasdSaVptpAs=;
 b=g8vcPCqvKbf7uwnSi41pKZ2toWpfkryT55J78+deBPwITwihqF2QJZ06WhxX6nFkkdSngnqIZ//e1q5dj9JUTgTOJNN7BK72k0/qD6CYCgGu/bPJgNbfo2MJcAmmxKXyPEtViIBlFK1QuaCXDUZ3C9YdVQtmqPvfVJQwgrt6EiARYeYDWCjungo5/sjm8ImMkh/Ys2lTpaK39GAr+SuAmV3R/I19pfWM8He3GKQBFQHO0TYiKYSLO8sHmNwHiN3pDMd6Cl383QwhxTHwp6Fd4LONKdO+xJwZBYGKDiHp5yDhrShzc+JkSvqD5/b1b6XpcaxRxw76jxzs4Gjor97xTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fXN/+i3GHoq8CQpsn2irq7sM6BeOp7JasdSaVptpAs=;
 b=hY9b3KAb1GyAIC/wtpzjmpu+k4Ky6RtTxf77+NPwbxuj08VOijuh61yFIUew/bjwVE4atz+jBa8SmNEAZcp7wQ/iV8yu9+sRHjLmEErzVdYk4NvXW6GLREO3uEJ9HeakTTrAb+a52WxD32ItZmnOCouJKSFn9e6a2b/tQFVvGHs=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR11MB2029.namprd11.prod.outlook.com (2603:10b6:300:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Tue, 10 Nov
 2020 18:26:39 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::80b8:462a:6fde:926]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::80b8:462a:6fde:926%6]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 18:26:39 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh/mesh-config-json: Fix errors found by static
 analysis
Thread-Topic: [PATCH BlueZ] mesh/mesh-config-json: Fix errors found by static
 analysis
Thread-Index: AQHWtItkJ5m8U30RVky+xeXuVcmYt6nBtPcA
Date:   Tue, 10 Nov 2020 18:26:39 +0000
Message-ID: <fdfb8937cecdd6026dc8b07ba847b5688b8b0cf3.camel@intel.com>
References: <20201106222245.137189-1-inga.stotland@intel.com>
In-Reply-To: <20201106222245.137189-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.43]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d6bbcd2-4893-44a1-71ae-08d885a62a63
x-ms-traffictypediagnostic: MWHPR11MB2029:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB20291EAD303EC26DAFEC9E9FE1E90@MWHPR11MB2029.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6dtmKUVKwYmHCNGXihhf+7prcSn603831dgJklsTC6fxxNBtbF2zZc+kBYINXCorjcheD6hhbqvsO/EfkR4pnZuJ7dBrgAdSOSee1rrMmNzue3SDOYizE8YgRM17PJv9LeheOdT2T49wjjj4t5wr3iQC3OH9MvNLSofV8pwzKqxDn8PeCR/9Ct7L4wZY2EmZ7aOHaR5oph2oaQufyrnwcHRI//nwIufq1/jXhXHX/XWr+ozt2MnyNCXsdTAmn5BIG0GWroUn2/eHHnv8/R4o8KCflUlR+2lwm/Nx3lVHG7mEuRj3ciIfMY2txzih3dzTCNdrsS9CIazcuwDtjEelLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(8936002)(83380400001)(6636002)(86362001)(2906002)(110136005)(36756003)(8676002)(26005)(316002)(186003)(6486002)(5660300002)(2616005)(91956017)(66556008)(6506007)(64756008)(66946007)(66476007)(76116006)(66446008)(478600001)(71200400001)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: b5zFifAu6zamoQkIMdHotaHa3ifVJxkKm22cJ7SG4OLKPSvBjO2mXQX0dqR45tfOKH85QxfUlUlNIMAQ9xV5HRFPofggC0QKN+lwVC6CPaJ+llRlEhWY8hG7UAOd/n9LidSashCS8DyTRtJcbNPefkkAlquFsijueDOuvszWPsZ2vHMxV91pnLdqgNCaQ2XJYOwzTW6IF5lUDwyDo8PxnEZ0sEJmlpzQ/h+EmRkSr5Tm8L9b8Kc/0igQe4sDz13cVHnjyjPIt0bJEs92rIXBTI70JjEgIZXPuGC0YCOR/TPUhEal5X6xyUqoYfNfLjU6jO7Wx6yhcAe0BUxdjJX4Zey/0iWNA4zd2iz0UsJj8GnyTjGhW3uG9Ptp4SCnENI4aR7whQNRqbg2R3UcdJkLC9tqnKAemJkrd91d4rUnpr6Rr5gXtQjVE0K9KJYEupBdyv3ZkBNl94TDFLYhTXtMAO3GumV0dR4rZ/XH8Vi9y3kPSz6Rwk1FYnO2KrGjUIOWHW12V13jneRQbt+trCBEiS5HWnFnQB1su197HfX6KKoN9xrfLDjV4Bam+H5/TwPdivCa6cwaMS2VwK6Z0Ub116Hq2nlco6+4rBJq6M5xtF4H//f7n8BcfbYPVCUOw8UqgWjW44ZTqdckUw7F26EHEYYzBal+WgJvayuRshgPgYWP0vfWdE8DmyC/gwwCd89PE5ERTo6A4ecuTv8cVzhz+Qcv8YsUYqVVk9AXqjfL2s0vKPHLUDKUmC3PzJmHCW3ktJj/8CzyGRWh64/Eot60aAEueAjtr2ruJXGnVrBCMetQwBeRTVFVhFEBfkQ2E2/GiwsnJA83SQI9UckwCAHTsmbP1xUufoxtKitoMt1kDaVn24IKOesFn5wPhFlU3VsSdD+yAVjJMA2uOUfMIuCMXQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5BAE9B0D7E87F4BA861397736498CB7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6bbcd2-4893-44a1-71ae-08d885a62a63
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 18:26:39.4075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0u5UYkqJrcfpw172SyFMG1JOOORZxyZvzXbYwgVv6OaJZRhtn6o9X1+a6QDWtKxbL/nF0H9F/udASwVxTJkRGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2029
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBGcmksIDIwMjAtMTEtMDYgYXQgMTQ6MjIgLTA4MDAsIEluZ2EgU3RvdGxh
bmQgd3JvdGU6DQo+IFRoaXMgZml4ZXMgbWlzY2VsbGFuZW91cyBpc3N1ZXMgcmVsYXRlZCB0byB1
bmNoZWNrZWQgcmV0dXJuIHN0YXR1cw0KPiBhbmQgKHRlbXBvcmFyeSkgYWxsb2NhdGVkIG1lbW9y
eSBsZWFrcyBkdWUgdG8gZGFlbW9uJ3MgZXhpdCBvbiBzdGFydHVwDQo+IGZhaWx1cmUuDQo+IC0t
LQ0KPiAgbWVzaC9tZXNoLWNvbmZpZy1qc29uLmMgfCA2MiArKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKyks
IDI5IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21lc2gvbWVzaC1jb25maWctanNv
bi5jIGIvbWVzaC9tZXNoLWNvbmZpZy1qc29uLmMNCj4gaW5kZXggZWM5ZWNiNzg2Li5mMTQyZjBl
MWYgMTAwNjQ0DQo+IC0tLSBhL21lc2gvbWVzaC1jb25maWctanNvbi5jDQo+ICsrKyBiL21lc2gv
bWVzaC1jb25maWctanNvbi5jDQo+IEBAIC00NzUsNiArNDc1LDcgQEAgc3RhdGljIGJvb2wgcmVh
ZF9hcHBfa2V5cyhqc29uX29iamVjdCAqam9iaiwgc3RydWN0IG1lc2hfY29uZmlnX25vZGUgKm5v
ZGUpDQo+ICAJCXN0cnVjdCBtZXNoX2NvbmZpZ19hcHBrZXkgKmFwcGtleTsNCj4gIA0KPiAgCQlh
cHBrZXkgPSBsX25ldyhzdHJ1Y3QgbWVzaF9jb25maWdfYXBwa2V5LCAxKTsNCj4gKwkJbF9xdWV1
ZV9wdXNoX3RhaWwobm9kZS0+YXBwa2V5cywgYXBwa2V5KTsNCj4gIA0KPiAgCQlqdGVtcCA9IGpz
b25fb2JqZWN0X2FycmF5X2dldF9pZHgoamFycmF5LCBpKTsNCj4gIA0KPiBAQCAtNDk2LDggKzQ5
Nyw2IEBAIHN0YXRpYyBib29sIHJlYWRfYXBwX2tleXMoanNvbl9vYmplY3QgKmpvYmosIHN0cnVj
dCBtZXNoX2NvbmZpZ19ub2RlICpub2RlKQ0KPiAgDQo+ICAJCWlmICghc3RyMmhleChzdHIsIHN0
cmxlbihzdHIpLCBhcHBrZXktPmtleSwgMTYpKQ0KPiAgCQkJZ290byBmYWlsOw0KPiAtDQo+IC0J
CWxfcXVldWVfcHVzaF90YWlsKG5vZGUtPmFwcGtleXMsIGFwcGtleSk7DQo+ICAJfQ0KPiAgDQo+
ICAJcmV0dXJuIHRydWU7DQo+IEBAIC01MzIsNiArNTMxLDggQEAgc3RhdGljIGJvb2wgcmVhZF9u
ZXRfa2V5cyhqc29uX29iamVjdCAqam9iaiwgc3RydWN0IG1lc2hfY29uZmlnX25vZGUgKm5vZGUp
DQo+ICANCj4gIAkJbmV0a2V5ID0gbF9uZXcoc3RydWN0IG1lc2hfY29uZmlnX25ldGtleSwgMSk7
DQo+ICANCj4gKwkJbF9xdWV1ZV9wdXNoX3RhaWwobm9kZS0+bmV0a2V5cywgbmV0a2V5KTsNCj4g
Kw0KPiAgCQlqdGVtcCA9IGpzb25fb2JqZWN0X2FycmF5X2dldF9pZHgoamFycmF5LCBpKTsNCj4g
IA0KPiAgCQlpZiAoIWdldF9rZXlfaW5kZXgoanRlbXAsICJpbmRleCIsICZuZXRrZXktPmlkeCkp
DQo+IEBAIC01NjEsOCArNTYyLDYgQEAgc3RhdGljIGJvb2wgcmVhZF9uZXRfa2V5cyhqc29uX29i
amVjdCAqam9iaiwgc3RydWN0IG1lc2hfY29uZmlnX25vZGUgKm5vZGUpDQo+ICANCj4gIAkJaWYg
KCFzdHIyaGV4KHN0ciwgc3RybGVuKHN0ciksIG5ldGtleS0+a2V5LCAxNikpDQo+ICAJCQlnb3Rv
IGZhaWw7DQo+IC0NCj4gLQkJbF9xdWV1ZV9wdXNoX3RhaWwobm9kZS0+bmV0a2V5cywgbmV0a2V5
KTsNCj4gIAl9DQo+ICANCj4gIAlyZXR1cm4gdHJ1ZTsNCj4gQEAgLTEwMzYsNyArMTAzNSw3IEBA
IHN0YXRpYyBib29sIHBhcnNlX21vZGVsX3N1YnNjcmlwdGlvbnMoanNvbl9vYmplY3QgKmpzdWJz
LA0KPiAgDQo+ICAJCWp2YWx1ZSA9IGpzb25fb2JqZWN0X2FycmF5X2dldF9pZHgoanN1YnMsIGkp
Ow0KPiAgCQlpZiAoIWp2YWx1ZSkNCj4gLQkJCXJldHVybiBmYWxzZTsNCj4gKwkJCWdvdG8gZmFp
bDsNCj4gIA0KPiAgCQlzdHIgPSAoY2hhciAqKWpzb25fb2JqZWN0X2dldF9zdHJpbmcoanZhbHVl
KTsNCj4gIAkJbGVuID0gc3RybGVuKHN0cik7DQo+IEBAIC0xMDQ1LDcgKzEwNDQsNyBAQCBzdGF0
aWMgYm9vbCBwYXJzZV9tb2RlbF9zdWJzY3JpcHRpb25zKGpzb25fb2JqZWN0ICpqc3VicywNCj4g
IAkJY2FzZSA0Og0KPiAgCQkJaWYgKHNzY2FuZihzdHIsICIlMDRoeCIsICZzdWJzW2ldLmFkZHIu
Z3JwKSAhPSAxKQ0KPiAgCQkJCWdvdG8gZmFpbDsNCj4gLQkJYnJlYWs7DQo+ICsJCQlicmVhazsN
Cj4gIAkJY2FzZSAzMjoNCj4gIAkJCWlmICghc3RyMmhleChzdHIsIGxlbiwgc3Vic1tpXS5hZGRy
LmxhYmVsLCAxNikpDQo+ICAJCQkJZ290byBmYWlsOw0KPiBAQCAtMTA4Niw2ICsxMDg1LDggQEAg
c3RhdGljIGJvb2wgcGFyc2VfbW9kZWxzKGpzb25fb2JqZWN0ICpqbW9kZWxzLCBzdHJ1Y3QgbWVz
aF9jb25maWdfZWxlbWVudCAqZWxlKQ0KPiAgDQo+ICAJCW1vZCA9IGxfbmV3KHN0cnVjdCBtZXNo
X2NvbmZpZ19tb2RlbCwgMSk7DQo+ICANCj4gKwkJbF9xdWV1ZV9wdXNoX3RhaWwoZWxlLT5tb2Rl
bHMsIG1vZCk7DQo+ICsNCj4gIAkJaWYgKCFqc29uX29iamVjdF9vYmplY3RfZ2V0X2V4KGptb2Rl
bCwgIm1vZGVsSWQiLCAmanZhbHVlKSkNCj4gIAkJCWdvdG8gZmFpbDsNCj4gIA0KPiBAQCAtMTA5
MywxMyArMTA5NCw5IEBAIHN0YXRpYyBib29sIHBhcnNlX21vZGVscyhqc29uX29iamVjdCAqam1v
ZGVscywgc3RydWN0IG1lc2hfY29uZmlnX2VsZW1lbnQgKmVsZSkNCj4gIA0KPiAgCQlsZW4gPSBz
dHJsZW4oc3RyKTsNCj4gIA0KPiAtCQlpZiAobGVuICE9IDQgJiYgbGVuICE9IDgpDQo+IC0JCQln
b3RvIGZhaWw7DQo+IC0NCj4gIAkJaWYgKGxlbiA9PSA0KSB7DQo+ICAJCQlpZiAoc3NjYW5mKHN0
ciwgIiUwNHgiLCAmaWQpICE9IDEpDQo+ICAJCQkJZ290byBmYWlsOw0KPiAtDQo+ICAJCX0gZWxz
ZSBpZiAobGVuID09IDgpIHsNCj4gIAkJCWlmIChzc2NhbmYoc3RyLCAiJTA4eCIsICZpZCkgIT0g
MSkNCj4gIAkJCQlnb3RvIGZhaWw7DQo+IEBAIC0xMTM1LDggKzExMzIsNiBAQCBzdGF0aWMgYm9v
bCBwYXJzZV9tb2RlbHMoanNvbl9vYmplY3QgKmptb2RlbHMsIHN0cnVjdCBtZXNoX2NvbmZpZ19l
bGVtZW50ICplbGUpDQo+ICAJCQlpZiAoIXBhcnNlX21vZGVsX3N1YnNjcmlwdGlvbnMoamFycmF5
LCBtb2QpKQ0KPiAgCQkJCWdvdG8gZmFpbDsNCj4gIAkJfQ0KPiAtDQo+IC0JCWxfcXVldWVfcHVz
aF90YWlsKGVsZS0+bW9kZWxzLCBtb2QpOw0KPiAgCX0NCj4gIA0KPiAgCXJldHVybiB0cnVlOw0K
PiBAQCAtMTU4NCwxNiArMTU3OSwxOSBAQCBzdGF0aWMgdm9pZCBhZGRfbW9kZWwodm9pZCAqYSwg
dm9pZCAqYikNCj4gIHsNCj4gIAlzdHJ1Y3QgbWVzaF9jb25maWdfbW9kZWwgKm1vZCA9IGE7DQo+
ICAJanNvbl9vYmplY3QgKmptb2RlbHMgPSBiLCAqam1vZGVsLCAqanZhbDsNCj4gKwlib29sIHJl
c3VsdDsNCj4gIA0KPiAgCWptb2RlbCA9IGpzb25fb2JqZWN0X25ld19vYmplY3QoKTsNCj4gIAlp
ZiAoIWptb2RlbCkNCj4gIAkJcmV0dXJuOw0KPiAgDQo+IC0JaWYgKCFtb2QtPnZlbmRvcikNCj4g
LQkJd3JpdGVfdWludDE2X2hleChqbW9kZWwsICJtb2RlbElkIiwNCj4gLQkJCQkJCSh1aW50MTZf
dCkgbW9kLT5pZCk7DQo+IC0JZWxzZQ0KPiAtCQl3cml0ZV91aW50MzJfaGV4KGptb2RlbCwgIm1v
ZGVsSWQiLCBtb2QtPmlkKTsNCj4gKwlyZXN1bHQgPSAobW9kLT52ZW5kb3IpID8gd3JpdGVfdWlu
dDMyX2hleChqbW9kZWwsICJtb2RlbElkIiwgbW9kLT5pZCkgOg0KPiArCQkJd3JpdGVfdWludDE2
X2hleChqbW9kZWwsICJtb2RlbElkIiwgKHVpbnQxNl90KSBtb2QtPmlkKTsNCj4gKw0KPiArCWlm
ICghcmVzdWx0KSB7DQo+ICsJCWpzb25fb2JqZWN0X3B1dChqbW9kZWwpOw0KPiArCQlyZXR1cm47
DQo+ICsJfQ0KPiAgDQo+ICAJanZhbCA9IGpzb25fb2JqZWN0X25ld19ib29sZWFuKG1vZC0+c3Vi
X2VuYWJsZWQpOw0KPiAgCWpzb25fb2JqZWN0X29iamVjdF9hZGQoam1vZGVsLCAic3ViRW5hYmxl
ZCIsIGp2YWwpOw0KPiBAQCAtMTY3MSwyNCArMTY2OSwyNCBAQCBzdGF0aWMgc3RydWN0IG1lc2hf
Y29uZmlnICpjcmVhdGVfY29uZmlnKGNvbnN0IGNoYXIgKmNmZ19wYXRoLA0KPiAgDQo+ICAJCWpl
bGVtZW50ID0ganNvbl9vYmplY3RfbmV3X29iamVjdCgpOw0KPiAgDQo+IC0JCWlmICghamVsZW1l
bnQpIHsNCj4gLQkJCWpzb25fb2JqZWN0X3B1dChqZWxlbXMpOw0KPiAtCQkJcmV0dXJuIE5VTEw7
DQo+IC0JCX0NCj4gKwkJaWYgKCFqZWxlbWVudCkNCj4gKwkJCWdvdG8gZmFpbDsNCj4gIA0KPiAt
CQl3cml0ZV9pbnQoamVsZW1lbnQsICJlbGVtZW50SW5kZXgiLCBlbGUtPmluZGV4KTsNCj4gLQkJ
d3JpdGVfdWludDE2X2hleChqZWxlbWVudCwgImxvY2F0aW9uIiwgZWxlLT5sb2NhdGlvbik7DQo+
ICAJCWpzb25fb2JqZWN0X2FycmF5X2FkZChqZWxlbXMsIGplbGVtZW50KTsNCj4gIA0KPiArCQlp
ZiAoIXdyaXRlX2ludChqZWxlbWVudCwgImVsZW1lbnRJbmRleCIsIGVsZS0+aW5kZXgpKQ0KPiAr
CQkJZ290byBmYWlsOw0KPiArDQo+ICsJCWlmICghd3JpdGVfdWludDE2X2hleChqZWxlbWVudCwg
ImxvY2F0aW9uIiwgZWxlLT5sb2NhdGlvbikpDQo+ICsJCQlnb3RvIGZhaWw7DQo+ICsNCj4gIAkJ
LyogTW9kZWxzICovDQo+ICAJCWlmIChsX3F1ZXVlX2lzZW1wdHkoZWxlLT5tb2RlbHMpKQ0KPiAg
CQkJY29udGludWU7DQo+ICANCj4gIAkJam1vZGVscyA9IGpzb25fb2JqZWN0X25ld19hcnJheSgp
Ow0KPiAtCQlpZiAoIWptb2RlbHMpIHsNCj4gLQkJCWpzb25fb2JqZWN0X3B1dChqZWxlbXMpOw0K
PiAtCQkJcmV0dXJuIE5VTEw7DQo+IC0JCX0NCj4gKwkJaWYgKCFqbW9kZWxzKQ0KPiArCQkJZ290
byBmYWlsOw0KPiAgDQo+ICAJCWpzb25fb2JqZWN0X29iamVjdF9hZGQoamVsZW1lbnQsICJtb2Rl
bHMiLCBqbW9kZWxzKTsNCj4gIAkJbF9xdWV1ZV9mb3JlYWNoKGVsZS0+bW9kZWxzLCBhZGRfbW9k
ZWwsIGptb2RlbHMpOw0KPiBAQCAtMTcwNiw2ICsxNzA0LDEwIEBAIHN0YXRpYyBzdHJ1Y3QgbWVz
aF9jb25maWcgKmNyZWF0ZV9jb25maWcoY29uc3QgY2hhciAqY2ZnX3BhdGgsDQo+ICAJZ2V0dGlt
ZW9mZGF5KCZjZmctPndyaXRlX3RpbWUsIE5VTEwpOw0KPiAgDQo+ICAJcmV0dXJuIGNmZzsNCj4g
Kw0KPiArZmFpbDoNCj4gKwkJanNvbl9vYmplY3RfcHV0KGplbGVtcyk7DQo+ICsJCXJldHVybiBO
VUxMOw0KPiAgfQ0KPiAgDQo+ICBzdHJ1Y3QgbWVzaF9jb25maWcgKm1lc2hfY29uZmlnX2NyZWF0
ZShjb25zdCBjaGFyICpjZmdkaXJfbmFtZSwNCj4gQEAgLTI0MDQsOCArMjQwNiwxMCBAQCBzdGF0
aWMgdm9pZCBpZGxlX3NhdmVfY29uZmlnKHN0cnVjdCBsX2lkbGUgKmlkbGUsIHZvaWQgKnVzZXJf
ZGF0YSkNCj4gIA0KPiAgCWlmIChyZXN1bHQpIHsNCj4gIAkJcmVtb3ZlKGZuYW1lX2Jhayk7DQo+
IC0JCXJlbmFtZShmbmFtZV9jZmcsIGZuYW1lX2Jhayk7DQo+IC0JCXJlbmFtZShmbmFtZV90bXAs
IGZuYW1lX2NmZyk7DQo+ICsNCj4gKwkJaWYgKHJlbmFtZShmbmFtZV9jZmcsIGZuYW1lX2Jhaykg
PCAwIHx8DQo+ICsJCQkJCXJlbmFtZShmbmFtZV90bXAsIGZuYW1lX2NmZykgPCAwKQ0KPiArCQkJ
cmVzdWx0ID0gZmFsc2U7DQo+ICAJfQ0KPiAgDQo+ICAJcmVtb3ZlKGZuYW1lX3RtcCk7DQo=
