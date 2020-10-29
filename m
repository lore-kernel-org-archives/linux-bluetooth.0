Return-Path: <SRS0=NHH5=EE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE63FC4363A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 15:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E7CE206F7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 15:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Kp7emQ7M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgJ2PWh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Oct 2020 11:22:37 -0400
Received: from mga12.intel.com ([192.55.52.136]:30195 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbgJ2PWh (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Oct 2020 11:22:37 -0400
IronPort-SDR: LyjVLW0eoXzErptGW0HAo100hncXHpJQ9RguF8Jv+bDveQvj89slGS5nRSBMykMnmAhVlPwOvb
 1hhzhITwSedg==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="147732688"
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="147732688"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 08:22:18 -0700
IronPort-SDR: FO2ui3o815plurni9riNV1mw2pngXR7mcXtVoH0fIWe+TWlURUKUiaU5DQJZSTOqA/447tAi7V
 IQgpVKbhts9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="361526961"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Oct 2020 08:22:18 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 29 Oct 2020 08:22:17 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 29 Oct 2020 08:22:17 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 29 Oct 2020 08:22:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQIRf5NoBxWDiuYY6dpZH09cyWlBO1nD91U7g098bRWWYUfR3XI4gwyxxjRwpfGo7Nf3VuBA+kCqOlLxXuSbztASXzz+6mGuSna7kH52y1xAiiYM5QFTsqWpc8RobT5H43FlR3BWaAwednm6oYaaEjkPdy4jMvgVuGQnTx4C1h8lZIkOagA9c7d2Gvh3G7QI4iGGXrAFLdwRDEvXqu0BcZBBE+ohTNfN/RAvkzd9wBkBxtG3BvwKydgBtKA1+/d6wVz//TWYuFJz9Bzz87ZBlAMT8mVVV82Htxywu9ad7JJGdMJjVbklOCNnUe/6EMOThuM3sHswvnEu+1Q1TjkcJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSaP0AnIqNJhilp4zwFjgZiTAly8Qp+KMFlVvSHC2ms=;
 b=OMbCbCVIG79PyVZuektDdhDaCh4RAWHGAkXc8HwtvWi7S6+RPYB17X0uIho2qN0w1U/vS91o023J1stGeCnBckW+L+CKU/KbEHyDviN/632NIXXCeUYiSijqLfPJ86i4qZHSJScxjULnR3JQp6yFZ0WdkKK59LKPE4445Z4+qwsFAa9Vb0byTnIoEtYpMdnJ14AVSBhheIXgBKfypPhTcdf7BbqBjezsyTD4rxzR6JOn6swMDyK+GI48B3wcjj6ROaLlCF1uix4KgmLLYWqWCHj7tD2M1x7S4OvLLmZFdi/wseo2jefhl56NjNqVBiXSugQFhx6WGzXOrG5xbEzr2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSaP0AnIqNJhilp4zwFjgZiTAly8Qp+KMFlVvSHC2ms=;
 b=Kp7emQ7M4+p48O8EgBiJ+G+VCLjUb6HGr5ekY9mopXLAoBlovBOgT/gUUKeDYcgIn/y3Sv2RZR2t2llC9sxe92N80a188SejzgDTkpdGcYKdFvBopOd2dzMCsmSgx6fwuKEkKNTj9L+sKeE0UgbS/GMiiR/zOIHY1/e9Rr5Try8=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by CO1PR11MB5169.namprd11.prod.outlook.com (2603:10b6:303:95::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Thu, 29 Oct
 2020 15:22:16 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::80b8:462a:6fde:926]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::80b8:462a:6fde:926%5]) with mapi id 15.20.3499.027; Thu, 29 Oct 2020
 15:22:16 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] tools/mesh-cfgclient: Fix errors found by static
 analysis
Thread-Topic: [PATCH BlueZ] tools/mesh-cfgclient: Fix errors found by static
 analysis
Thread-Index: AQHWq9w0Cy0xQnadREO6hTlq54oBqamutteA
Date:   Thu, 29 Oct 2020 15:22:16 +0000
Message-ID: <1b98169336bdf954fad83b6a9b7a33660352e96d.camel@intel.com>
References: <20201026210817.50167-1-inga.stotland@intel.com>
In-Reply-To: <20201026210817.50167-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.43]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7166e7ef-f077-4474-2dd7-08d87c1e6b49
x-ms-traffictypediagnostic: CO1PR11MB5169:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB516940A834DF4EBACC2C0328E1140@CO1PR11MB5169.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wSemrcua5phCtmQz3kTetRGDh5z8Lguu7/nA8HiGAP3r3ZOWkzgpv5gAi85E+EUJ1xaKeaZoL/1BSVlfyU2kQVMSLXrk1yIfx+/LNk4pngKzBaCnaDLnF2x4sP05auy/aZ1QTrbTBLPm0Pk4j12J9G8vaw2A3pir5JXfJkCMWw3scZHwcYSXCIHefr7cwGwDpydOQqJRwFQaMKu2bp2aSOAD8PfvDX2yufSgXdkYh5XUuWxoh9OPH87Z1tv9kt0oFoydZYQiFG6QMizCWJUGCdT5nneXLqsem3qeRL2MWZGkbxtx3ypUaiFQXs3qNjn3jKmbnxjYUo28V2sUjCVmAw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(186003)(316002)(26005)(110136005)(71200400001)(8936002)(2906002)(66946007)(76116006)(6506007)(6486002)(8676002)(6636002)(478600001)(6512007)(86362001)(91956017)(5660300002)(64756008)(66446008)(66556008)(66476007)(2616005)(36756003)(4001150100001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: T/r1emwbE0P55ujS4npREj4JTBlKSe3iEb0xxOY5C1knM+X9gfBuVbZL7L8WgyshgkfcFc1awIYkzcRoyBxlh0ioIGsYqoW4RySQTmOhAK/Q+Pqv8yVeIuNXllQLXv0Lm60TLLPZN5T4bJ0e0P6dS3hy7y4PQD4u4e1EvAzaNx464rg3dYiNkHe3f49ka5StXusw6fNeAGCTYTOOQ2St/nlUcXRO5rqtZfHn3FD5B59xTLNYH1tb2MEw9wuj1NRkWEHh6kVTy8GHPWuBywJL4yndlQma8w7/xle7gOChBr0SZBxlQ101ZYqiRvDOc0TF8651XUlI3G8/pwSgc8j91Ii0S7KuXWrjRvNMnqqObnnXLqz/mWIM8U5l36TOurEMEzSXMi6Nhjluqdusiehk2Qlgn9/eLfIYNrcEIFADev79vkrVmBWbNi0unyfXBtnafutluIoq47F2yz7oiQcI5EMfkyt8PwWskPLk26cV98CkrmYyiXrLTrRNyjxcBcm4Lfe6ILeOrfkQNGS9yLQ89OLd2pUpZjgl8zHws0ejbmavJueTZoAgOv+t0OY9wGEiXgvJs2BhttXBREOlej/OC9GW4kA2s8q1zNUWqoXNm9+EsfT+Ewmzf6IQyDMtcLPTg36bKW6CJJwcaOd7k845gQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A571210151C4345A5B59562A187683E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7166e7ef-f077-4474-2dd7-08d87c1e6b49
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2020 15:22:16.2282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NGUGpPShuR2hdHT3WCD8zOQrB4ngAdXeogddSrfMhpJ0BpQA8p4V+bHwKH7kKfQFuJIIuGU5bz2POAudqdSYEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5169
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBNb24sIDIwMjAtMTAtMjYgYXQgMTQ6MDggLTA3MDAsIEluZ2EgU3RvdGxh
bmQgd3JvdGU6DQo+IFRoaXMgZml4ZXMgYSBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgZXJyb3Ig
aW4gc3Vic2NyaXB0aW9uX2NtZCgpLg0KPiANCj4gQWxzbyByZS1vcmRlciBjYWxsaW5nIHNlcXVl
bmNlIGZvciBsX2ZyZWUoKSAmIGxfcXVldWVfcmVtb3ZlKCkNCj4gaW4gbXNnX3JlY3ZkKCk6IGV2
ZW4gdGhvdWdoIHRlY2huaWNhbGx5IGl0IGlzIG5vdCBhIGJ1ZyB0byBwYXNzDQo+IGEgdmFsdWUg
b2YgYSBmcmVlZCBwb2ludGVyIHRvIGxfcXVldWVfcmVtb3ZlKCksIGl0J3MgYSBwb29yIGZvcm0N
Cj4gYW5kIGNvbmZ1c2VzIHRoZSBhbmFseXplci4NCj4gLS0tDQo+ICB0b29scy9tZXNoL2NmZ2Ns
aS5jIHwgMTUgKysrKysrKy0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25z
KCspLCA4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL21lc2gvY2ZnY2xp
LmMgYi90b29scy9tZXNoL2NmZ2NsaS5jDQo+IGluZGV4IDFjMjBkYjg1YS4uZDhlZWU0ZWRjIDEw
MDY0NA0KPiAtLS0gYS90b29scy9tZXNoL2NmZ2NsaS5jDQo+ICsrKyBiL3Rvb2xzL21lc2gvY2Zn
Y2xpLmMNCj4gQEAgLTQxMCw4ICs0MTAsOCBAQCBzdGF0aWMgYm9vbCBtc2dfcmVjdmQodWludDE2
X3Qgc3JjLCB1aW50MTZfdCBpZHgsIHVpbnQ4X3QgKmRhdGEsDQo+ICAJcmVxID0gZ2V0X3JlcV9i
eV9yc3Aoc3JjLCBvcGNvZGUpOw0KPiAgCWlmIChyZXEpIHsNCj4gIAkJY21kID0gcmVxLT5jbWQ7
DQo+IC0JCWZyZWVfcmVxdWVzdChyZXEpOw0KPiAgCQlsX3F1ZXVlX3JlbW92ZShyZXF1ZXN0cywg
cmVxKTsNCj4gKwkJZnJlZV9yZXF1ZXN0KHJlcSk7DQo+ICAJfSBlbHNlDQo+ICAJCWNtZCA9IE5V
TEw7DQo+ICANCj4gQEAgLTE0NzAsMTUgKzE0NzAsMTQgQEAgc3RhdGljIHZvaWQgc3Vic2NyaXB0
aW9uX2NtZChpbnQgYXJnYywgY2hhciAqYXJndltdLCB1aW50MzJfdCBvcGNvZGUpDQo+ICANCj4g
IAlncnAgPSBsX3F1ZXVlX2ZpbmQoZ3JvdXBzLCBtYXRjaF9ncm91cF9hZGRyLCBMX1VJTlRfVE9f
UFRSKHN1Yl9hZGRyKSk7DQo+ICANCj4gLQlpZiAoIWdycCAmJiBvcGNvZGUgIT0gT1BfQ09ORklH
X01PREVMX1NVQl9ERUxFVEUpIHsNCj4gLQkJZ3JwID0gYWRkX2dyb3VwKHN1Yl9hZGRyKTsNCj4g
LQ0KPiAtCQlpZiAoIWdycCAmJiBJU19WSVJUVUFMKHN1Yl9hZGRyKSkgew0KPiAtCQkJcHJpbnRf
dmlydHVhbF9ub3RfZm91bmQoc3ViX2FkZHIpOw0KPiAtCQkJcmV0dXJuIGJ0X3NoZWxsX25vbmlu
dGVyYWN0aXZlX3F1aXQoRVhJVF9GQUlMVVJFKTsNCj4gLQkJfQ0KPiArCWlmICghZ3JwICYmIElT
X1ZJUlRVQUwoc3ViX2FkZHIpKSB7DQo+ICsJCXByaW50X3ZpcnR1YWxfbm90X2ZvdW5kKHN1Yl9h
ZGRyKTsNCj4gKwkJcmV0dXJuIGJ0X3NoZWxsX25vbmludGVyYWN0aXZlX3F1aXQoRVhJVF9GQUlM
VVJFKTsNCj4gIAl9DQo+ICANCj4gKwlpZiAoIWdycCAmJiBvcGNvZGUgIT0gT1BfQ09ORklHX01P
REVMX1NVQl9ERUxFVEUpDQo+ICsJCWdycCA9IGFkZF9ncm91cChzdWJfYWRkcik7DQo+ICsNCj4g
IAlpZiAoSVNfVklSVFVBTChzdWJfYWRkcikpIHsNCj4gIAkJaWYgKG9wY29kZSA9PSBPUF9DT05G
SUdfTU9ERUxfU1VCX0FERCkNCj4gIAkJCW9wY29kZSA9IE9QX0NPTkZJR19NT0RFTF9TVUJfVklS
VF9BREQ7DQo=
