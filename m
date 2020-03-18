Return-Path: <SRS0=jOg2=5D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9E1C10DCE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 18:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C2C20786
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 18:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="ReqgK4fg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgCRSRE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Mar 2020 14:17:04 -0400
Received: from mga09.intel.com ([134.134.136.24]:7160 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbgCRSRD (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Mar 2020 14:17:03 -0400
IronPort-SDR: Q8wWt47dS8V55ArRSEFPQ/qZVDv4hp3kmQM4DYjHM5p+uGE4190PBH3yVNvAQJZta3uPzXTCx9
 /5lehmhiPcqw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2020 11:17:03 -0700
IronPort-SDR: lYaAJ/q/Am6yG7Qe4WeEVOOrD8gS/ueLOYHvM9O9YB6nZvpF0MiEh54bYhGLl89ma7D+cHFjoX
 XgSy7Ot3afmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,568,1574150400"; 
   d="scan'208";a="238686125"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by orsmga008.jf.intel.com with ESMTP; 18 Mar 2020 11:17:02 -0700
Received: from orsmsx112.amr.corp.intel.com (10.22.240.13) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 18 Mar 2020 11:17:02 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX112.amr.corp.intel.com (10.22.240.13) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 18 Mar 2020 11:17:02 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 18 Mar 2020 11:17:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mklLqHNNgJD0GihFWA2i5q0n8YbReF7WEdH74VYV4HvFx1CFi8LG/vH661Jsl1v0cDGudp63bIAymHO42lH0ii5gqNTiu0CpaXV/RffdlqUWkwKv5e2gxP4HwyYjoB1RRIdyH/RF06MsvNLwiudWusu79uGeWClKEl+QtIyBHb6Y6GTa4fkbct/JcsUm2ecIONy9R/PzMmTfK2KtsuC8NASAZPTDfqlEVe2WxwKFGjGbv/JGOWQRCEdMqURSDl36fFhvxfCVAOMGhuG0+/bDclcEtB4WBpLpGGfFc2dO+AVPCuyRHruSTPuKk67wujwnpEyn6I298GqszYuM5ffDaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScCVLjlSYguBplIqk8w5bl3LoBdFaGYVW75pGQ4+A4s=;
 b=YI8rMMAqHn2fwyvf5k7to07xEYc2BE6uZ87HSbT7G5dDEs3y79uhgnj31UMo0I6865vro6C2BjdpuWOMA2B0r9Ms1wTx0f+XEMv5jsuz4O0+iW1/hGSFInKSYqW/diyCvsL8fMIagowWJeaRei7d1YS+bLOB/w2vCSJhZRxYd93xa/2zStsMz/HcOCZ7n8QUDoqE0c6sMYLbxpxpoXBKWx4M4AAfGrPYrhI/R8gz/4YYfJWbShAVBajYt9iN2sVmScrgbORfcRZkzYMpVcioWe/iRwC5XfNmueFOLno+wVV1J3DmaV0YHPgQR7NeCkgwX4khRRWi+d2SOfuSMy40eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScCVLjlSYguBplIqk8w5bl3LoBdFaGYVW75pGQ4+A4s=;
 b=ReqgK4fgBX/qYY6QcpGkUBkrxkyb25pKyzDTaaT5zUnrYwQuuvi4VcJewBqjJfWyxRuZ5wVpnMC/pdoNZB5wo1BFdw3g7/c4KT9alpXOZ2H64tWbj3n4qICImgQtVq7469zV+0O0cpkULM72+zKtKpBVAqx1L752R3iNe+w30TY=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4586.namprd11.prod.outlook.com (2603:10b6:303:5e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Wed, 18 Mar
 2020 18:17:01 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a%3]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 18:17:01 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] tools/mesh-cfgclient: Increase app's CRPL size
Thread-Topic: [PATCH BlueZ] tools/mesh-cfgclient: Increase app's CRPL size
Thread-Index: AQHV/U2ZchJUneCYtE+dPBzBaCq2eqhOqDuA
Date:   Wed, 18 Mar 2020 18:17:01 +0000
Message-ID: <62e46a6ceb7c2913b0a857e0c3d10e327ed6340f.camel@intel.com>
References: <20200318174859.27387-1-inga.stotland@intel.com>
In-Reply-To: <20200318174859.27387-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 987ac19c-d94d-4280-a891-08d7cb688e0c
x-ms-traffictypediagnostic: MW3PR11MB4586:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB45866B7C124DFB357D4B6471E1F70@MW3PR11MB4586.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 03468CBA43
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(366004)(346002)(136003)(199004)(5660300002)(478600001)(76116006)(6512007)(91956017)(66946007)(26005)(2906002)(64756008)(66446008)(66476007)(6486002)(66556008)(71200400001)(316002)(6636002)(110136005)(186003)(36756003)(2616005)(81166006)(81156014)(8676002)(86362001)(6506007)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW3PR11MB4586;H:MW3PR11MB4539.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /VEj+iwfToUCjTFe9a1+6Mb4h3sE0bijM8/byjHzYvqKQHLGcEXSXO/2gkS1YPm8aiwtA1sqqD7Wwgg3rdsRIAhBbrVGgsqOuStOxXc5GKIGqKm/bXh+lEC41HF+RNfU3Oj1UPVxtohDa6RIXrzwNIsjPimdAruMpjSGtu+DJpJH6S/qivorLVvEdPXVwL8pxUNVCOEVlJhCkmOnrGIgC6H2Imwa4y/L9mPdIzeMmVRhk80tTzk+ib3J3E4vXHWiMx2wZWnPL88P37s3aWjQAqla/N8u/Qp7xUKgXJUnB77/C/mihKG8kr4NscU9pXJfdstMI5NwdujxqoG4lukcNFkQbCJH7EXm9qa/3M92Igida9N2T2JFYPxgsr6r6fckPyiWITwJRnJBvcpPVRyJ4tIm/5XIEdd0zxiWhYZCspOc1OB+rXnGzmi6WEXr698Y
x-ms-exchange-antispam-messagedata: k5H+CbL3F8qUnQSfnkM315YV5hyWyNX72McdjPmkuWpzFfwf4ifIFOcLuuDZpeGbvPgtJ0U1nV+Ulb0OcyJyvfr3tvkriKaaKvFg9VXaS3Pjd/PJPBOgvrY5KlVEbIV6F5WYFnrmFiRnvIL0cX01/A==
Content-Type: text/plain; charset="utf-8"
Content-ID: <62F06B7042D7844AA51C053C15D7A8A2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 987ac19c-d94d-4280-a891-08d7cb688e0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 18:17:01.5958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VRwmhfxIF+iZOmmAIMOX8TLkF1J+/Xw/E1q+bO9PBmS+TEMdt9aC+/02dMrWtkF+zG0pqNhyr8S41QoBdd1fPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4586
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gV2VkLCAyMDIwLTAzLTE4IGF0IDEwOjQ4IC0wNzAwLCBJbmdhIFN0b3RsYW5k
IHdyb3RlOg0KPiBUaGlzIGluY3JlYXNlcyB0aGUgdmFsdWUgb2YgdGhlIENSUEwgc3VwcGxpZWQg
YnkgdGhlIGFwcGxpY2FpdG9uDQo+IHRvIDB4N2ZmZjogc2luY2UgdGhlIHRvb2wgaXMgaW50ZW5k
ZWQgdG8gYmUgYSBwcm92aXNpb25lciBhbmQgY29uZmlnDQo+IGNsaWVudCwgaXQgbWF5IGhhdmUg
dG8ga2VlcCB0cmFjayBvZiBjb21tdW5pY2F0aW9ucyB3aXRoIGEgc2lnbmlmaWNhbnQNCj4gbnVt
YmVyIG9mIHVuaXF1ZSBtZXNoIG5vZGVzLCBlYWNoIHdpdGggaXRzIGNvcnJlc3BvbmRpbmcgQ1JQ
TCBlbnRyeSBpbg0KPiBjb25maWcgY2xpZW50IG5vZGUgc3RvcmFnZS4gVGhlcmVmb3JlLCBhIGxh
cmdlIENSUEwgc2l6ZSBpcyBuZWNlc3NhcnkuDQo+IC0tLQ0KPiAgdG9vbHMvbWVzaC1jZmdjbGll
bnQuYyB8IDMgKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvbWVzaC1jZmdjbGllbnQuYyBiL3Rvb2xz
L21lc2gtY2ZnY2xpZW50LmMNCj4gaW5kZXggZTQ1MjNlNWZjLi5hZTEzYzQ0MDkgMTAwNjQ0DQo+
IC0tLSBhL3Rvb2xzL21lc2gtY2ZnY2xpZW50LmMNCj4gKysrIGIvdG9vbHMvbWVzaC1jZmdjbGll
bnQuYw0KPiBAQCAtNTcsNiArNTcsNyBAQA0KPiAgI2RlZmluZSBERUZBVUxUX1NUQVJUX0FERFJF
U1MJMHgwMGFhDQo+ICAjZGVmaW5lIERFRkFVTFRfTUFYX0FERFJFU1MJKFZJUlRVQUxfQUREUkVT
U19MT1cgLSAxKQ0KPiAgI2RlZmluZSBERUZBVUxUX05FVF9JTkRFWAkweDAwMDANCj4gKyNkZWZp
bmUgTUFYX0NSUExfU0laRQkJMHg3ZmZmDQo+ICANCj4gICNkZWZpbmUgREVGQVVMVF9DRkdfRklM
RQkiY29uZmlnX2RiLmpzb24iDQo+ICANCj4gQEAgLTEyMiw3ICsxMjMsNyBAQCBzdGF0aWMgc3Ry
dWN0IG1lc2hjZmdfYXBwIGFwcCA9IHsNCj4gIAkuY2lkID0gMHgwNWYxLA0KPiAgCS5waWQgPSAw
eDAwMDIsDQo+ICAJLnZpZCA9IDB4MDAwMSwNCj4gLQkuY3JwbCA9IDEwLA0KPiArCS5jcnBsID0g
TUFYX0NSUExfU0laRSwNCj4gIAkuZWxlID0gew0KPiAgCQkucGF0aCA9ICIvbWVzaC9jZmdjbGll
bnQvZWxlMCIsDQo+ICAJCS5pbmRleCA9IDAsDQo=
