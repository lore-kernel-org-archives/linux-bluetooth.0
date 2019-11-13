Return-Path: <SRS0=sa5O=ZF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF85C432C3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Nov 2019 17:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D7A206EE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Nov 2019 17:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="rlxu6Niu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbfKMRPg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:15:36 -0500
Received: from mga02.intel.com ([134.134.136.20]:62357 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728294AbfKMRPf (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Nov 2019 12:15:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2019 09:15:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,301,1569308400"; 
   d="scan'208";a="287940784"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga001.jf.intel.com with ESMTP; 13 Nov 2019 09:15:34 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 13 Nov 2019 09:15:34 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 Nov 2019 09:15:33 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 13 Nov 2019 09:15:33 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.57) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 13 Nov 2019 09:15:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyPQ9PzWKsmTUDv3CiVeyPTIzPByHqQs5dMW5o62DXawTU93WMHK3lzURU2mYZR2td12k4dclR7K+5oDZNfIROqM3d7sAkT9MmCP40exh78eVL+IIuBjtH53741m4BrFB63dd2nP88nJIWBQrIUKjpH0GwI2sJY7Txl37QsHR4W0B8BgqVAZZPscR4Fb29xnj/HTqdFroDTPopiWRdTd+wMvyNOGeXM/LytIgNlh4UtYUTijEKJPTbiSng1GQNGrMMW03X9ZGM05QjK/OEICHM+lByghG1ThRJxMXx01rVpW7gdOrvy0WiNY4UaHsfU27CQTeCUUjKaWKM798ps9tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDFkDlK/m5ZVcnV3yeKM2kP6jrwFeOGZQFpyYma9YWU=;
 b=CE8+Lo7dgYiAG0GWN0IwDhL74Zce5bmsyhjc7MOKODnPaX2PWFYdS2O73HSne84avxwgYflZZZO26Zi6yOFlB8zWsUXJMmv8ECmIwYGWZVy0VEN7b09D9zfpKs+swSz8JV0iBVXf2LdD/7OePsFtilHoP/pqE/iVsERdA02X3D3K6a6vD13rninYDlUWVOLGiUWglIq/e91lee+jLI3Fq9LgCbLXUNWBCR5i0QsN7BIG5HH/0dBZ30s8MH3QvsbFufdR8We4YzNSAY8r5ZZp/hOurERwEYp3tJ4tE/Fds7sy1wxEKrzDmbBkInsq69Mbu/yYv1Sxv7XpjH9pIL/IIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDFkDlK/m5ZVcnV3yeKM2kP6jrwFeOGZQFpyYma9YWU=;
 b=rlxu6NiuJtXfzkw7ucECdr3a0OzhrKW0chjp37bMSEuw9wbjhHmQ6tXFewHL27qr5gi2KWUK8TwnwXjNVVD3tX53/AsRbuIVfLC1JU/Zf2rxb3v9pEnMWaIWn+JRoCwhWyArrkOiTOKwMwk3KRdKCbhUSzM1v4Tg0Ox7Bcm51aU=
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com (10.172.76.7) by
 CY4PR1101MB2296.namprd11.prod.outlook.com (10.172.77.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 13 Nov 2019 17:15:32 +0000
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::44:eac4:f8c8:ad06]) by CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::44:eac4:f8c8:ad06%11]) with mapi id 15.20.2430.027; Wed, 13 Nov 2019
 17:15:32 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: Fix ignored return value
Thread-Topic: [PATCH BlueZ] mesh: Fix ignored return value
Thread-Index: AQHVmWkxFozuuTCX2E6tE58LG7L0VaeJWRMA
Date:   Wed, 13 Nov 2019 17:15:31 +0000
Message-ID: <ab35191812d811ebab64fa36e6e2b290a38c5f57.camel@intel.com>
References: <20191112145425.6318-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20191112145425.6318-1-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [134.134.137.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad9d8b5b-c57f-41a0-a36b-08d7685d16d3
x-ms-traffictypediagnostic: CY4PR1101MB2296:
x-microsoft-antispam-prvs: <CY4PR1101MB22969F3A489D7C566F02977CE1760@CY4PR1101MB2296.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(136003)(39860400002)(366004)(396003)(346002)(189003)(199004)(36756003)(6506007)(102836004)(76176011)(486006)(446003)(11346002)(2616005)(476003)(186003)(99286004)(26005)(8676002)(76116006)(305945005)(7736002)(91956017)(4001150100001)(8936002)(256004)(81166006)(81156014)(14444005)(66066001)(118296001)(3846002)(6116002)(14454004)(6246003)(6512007)(2501003)(2906002)(478600001)(25786009)(110136005)(5660300002)(71190400001)(71200400001)(4744005)(229853002)(66556008)(64756008)(66446008)(66476007)(6436002)(66946007)(316002)(86362001)(6486002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1101MB2296;H:CY4PR1101MB2262.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M8YyiNu+usqzEUqJUtvCcCvyMowuWti/+XU+jCxajOj2Ma31a7/0zNwOZ0cS8j90Ig1oMpjm/U8OycovKGrV5p9jMHuELsqVSyDEUOam3ZbRa/hxwr8XW0v9h4xsWicmP5DSoKLCB4IjBNzdoo7d2Yc4lp0Q9fXEqIZiEmbR9EEm9dSuzXXYnHAHNRx7O+xqPp+ErgiHGiD+01gr6PSsXhc5aqZQDMFsXVPiIJInKhh1Antu1hutcSKXsI5/Savq39FPsjV+zORExO65/b4AHeGgzz2bzOUz401HLhA9AcE516EXOWECyxIRH3xzyB+whKRA+hn4M/KzrmIv/Whw8fUZKi5/GsrbTRLIs31zxCNFZ4E1Thywn+nmgVjMiaUDRVNJq3qX28LAL8/eFUsBGSHEoNJm+QjBx8CZgHOX1TFIsRKaok0xXpDpyQAgD7TD
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <829F3AC35E909445AF4F7219406ED5D1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ad9d8b5b-c57f-41a0-a36b-08d7685d16d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 17:15:31.8236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D336mVQlJ3E9k7aQ0M2WT6xER0eVzxkxbwsbNxsK6quk88QINw2jNzr5szBTNszjiJsGMYECmBzw45mjBvRj7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2296
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCB3aXRoIHN0eWxlLWd1aWRlIGNvcnJlY3Rpb25zOg0KQmxhbmsgbGluZSBhaGVhZCBv
ZiAiaWYiDQoNCk9uIFR1ZSwgMjAxOS0xMS0xMiBhdCAxNTo1NCArMDEwMCwgTWljaGHFgiBMb3dh
cy1SemVjaG9uZWsgd3JvdGU6DQo+IFRoaXMgZml4ZXMgdGhlIGZvbGxvd2luZyBidWlsZCBlcnJv
ciB3aGVuIGNvbXBpbGluZyBpbiBtYWludGFpbmVyIG1vZGU6DQo+IA0KPiBtZXNoL2tleXJpbmcu
YzogSW4gZnVuY3Rpb24g4oCYZmluYWxpemXigJk6DQo+IG1lc2gva2V5cmluZy5jOjE0Mjo4OiBl
cnJvcjogaWdub3JpbmcgcmV0dXJuIHZhbHVlIG9mIOKAmHdyaXRl4oCZLCBkZWNsYXJlZCB3aXRo
IGF0dHJpYnV0ZSB3YXJuX3VudXNlZF9yZXN1bHQgWy0NCj4gV2Vycm9yPXVudXNlZC1yZXN1bHRd
DQo+ICAgKHZvaWQpd3JpdGUoZmQsICZrZXksIHNpemVvZihrZXkpKTsNCj4gICAgICAgICBefn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+IC0tLQ0KPiAgbWVzaC9rZXlyaW5nLmMgfCAzICsr
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL21lc2gva2V5cmluZy5jIGIvbWVzaC9rZXlyaW5nLmMNCj4gaW5kZXgg
OWZhN2Q2YmQwLi5mZTI5MmI0YTcgMTAwNjQ0DQo+IC0tLSBhL21lc2gva2V5cmluZy5jDQo+ICsr
KyBiL21lc2gva2V5cmluZy5jDQo+IEBAIC0xNDAsNyArMTQwLDggQEAgc3RhdGljIHZvaWQgZmlu
YWxpemUoY29uc3QgY2hhciAqZnBhdGgsIHVpbnQxNl90IG5ldF9pZHgpDQo+ICAJbF9kZWJ1Zygi
RmluYWxpemUgJXMiLCBmcGF0aCk7DQo+ICAJbWVtY3B5KGtleS5vbGRfa2V5LCBrZXkubmV3X2tl
eSwgMTYpOw0KPiAgCWxzZWVrKGZkLCAwLCBTRUVLX1NFVCk7DQo+IC0Jd3JpdGUoZmQsICZrZXks
IHNpemVvZihrZXkpKTsNCj4gKwlpZiAod3JpdGUoZmQsICZrZXksIHNpemVvZihrZXkpKSAhPSBz
aXplb2Yoa2V5KSkNCj4gKwkJZ290byBkb25lOw0KPiAgDQo+ICBkb25lOg0KPiAgCWNsb3NlKGZk
KTsNCg==
