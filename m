Return-Path: <SRS0=EGLw=5L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0111BC43331
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Mar 2020 17:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C088320714
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Mar 2020 17:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="QYLW6Dc1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgCZRCh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Mar 2020 13:02:37 -0400
Received: from mga09.intel.com ([134.134.136.24]:37532 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgCZRCh (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Mar 2020 13:02:37 -0400
IronPort-SDR: hzH81nkVF/7Y3H2aWAcxTEUAbx9fYjO4FVjOv0NYwFhG8D7wDXjIBtzxbWVI6GO2xkdBi6EMRW
 gVDhtylnI1ww==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2020 10:02:36 -0700
IronPort-SDR: hLYtSNEv22uFA2ndVIrOh5hJQeFwEaMPUvHiCi0t5vBnZFdqddAjBpGdAhUGz6bZYXPDDjl0yC
 W1mMx4+PmFow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,309,1580803200"; 
   d="scan'208";a="448700339"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga006.fm.intel.com with ESMTP; 26 Mar 2020 10:02:36 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Mar 2020 10:02:35 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 26 Mar 2020 10:02:35 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 26 Mar 2020 10:02:35 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.59) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 26 Mar 2020 10:02:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8wtUVrNCZLSZH/sFtsFvZNlcfpU8db5T7BXbZQ2P9gnDm9Y4gtsqQiAXwAhgKITePJQA/oRmqGPtNhIwoJsFA8ZS2zgFZ9541U2K1k21Q+cLVcdGkMpoMQi9hkX8EDNhSPIsO2+miUcud/agXW5CwYRBfgzPdyOoc9J0S0A4rXarkwfB+k6R1R04A/7IQv0YJ5rQtli/nrc11y88V6Vqh7ZG6cD0UBAs/DIW+ezwS4ThSWvecCDW1TtYdJH1//EA/h1mc7I8OPRSO7e3QXRcJbtGWhDJ/iGUpZaRyNvN+fnW07H/naN3vp6v0A4TIuUK5Lyhf0qYrdJAcR5Xh5eOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Jz6KVcl/068iqGloC8VBRWa9zGH5jc2KknTIxiA2q4=;
 b=fflK79wS3qMwrejJalIWbJ8oRIEQKob7Df60yKEDEhkLa5Syf9tHb098C3jES4g64BVZzsBkKe8rG+HQMZZ4EXYEvn6489OfrzdqzFQt3pbEWaJ+TUMKCOFifci/v9LnGcp9idY+/HM6L2geBbVEHcF+ZhCQlGxDU2S3LBjqDaWoUl3BUHW9bPZGb1rabTj/CtM3zJx202z5UNAgENQOvYEPzKmY0vdWRc2UnI3TftmQ/vpfsE4dzuSJAntajIv3X7NO2GzIaJ6T+dpH5yyVVrknNSDorhnezV+O8hQQFYSbdzHKUqPAFP6nCJtS7NSowkGdQX9iBoE4+8aU1QleMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Jz6KVcl/068iqGloC8VBRWa9zGH5jc2KknTIxiA2q4=;
 b=QYLW6Dc1pYzjvKFjDtICV+atYNo10ShtFLWL/VzwcPykbytSP+yzmpo63AQaeWSfvsiLXmBZVlZZwdYbnE0VXRhk6YxJSWMOrmD+hZjGKzCxMYnHr1ud5/QzS18QuTz0dFqXyw9lzxzPWm94/hVg5ZuoJG172PYonhgeOG+NN3s=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4537.namprd11.prod.outlook.com (2603:10b6:303:5d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Thu, 26 Mar
 2020 17:02:31 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a%3]) with mapi id 15.20.2856.019; Thu, 26 Mar 2020
 17:02:31 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "prathyusha.n@samsung.com" <prathyusha.n@samsung.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "s.syam@samsung.com" <s.syam@samsung.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH 1/1] mesh: Check limits for count and interval of relay
Thread-Topic: [PATCH 1/1] mesh: Check limits for count and interval of relay
Thread-Index: AQHWAhJ8S8ll8vk7BUe5j5v1JH7GVKhZrnUAgAFuEQA=
Date:   Thu, 26 Mar 2020 17:02:31 +0000
Message-ID: <98bbd043aa74d51223e6b445ea7656851f5f8baa.camel@intel.com>
References: <1585078044-14974-1-git-send-email-prathyusha.n@samsung.com>
         <CGME20200324192820epcas5p10a4ae9a6d7e7dab22f4a5ab4ee752099@epcas5p1.samsung.com>
         <1585078044-14974-2-git-send-email-prathyusha.n@samsung.com>
         <a0d832523512cf3f4f9c7eed27a258687732e47d.camel@intel.com>
In-Reply-To: <a0d832523512cf3f4f9c7eed27a258687732e47d.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c907c25f-5b43-4e4e-3485-08d7d1a77917
x-ms-traffictypediagnostic: MW3PR11MB4537:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB45378E5BABE5E6DE3E1C1BFAE1CF0@MW3PR11MB4537.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:163;
x-forefront-prvs: 0354B4BED2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(366004)(376002)(136003)(346002)(54906003)(478600001)(316002)(8936002)(110136005)(86362001)(5660300002)(6486002)(6512007)(64756008)(36756003)(26005)(81166006)(186003)(8676002)(81156014)(76116006)(91956017)(66446008)(66556008)(66476007)(66946007)(2616005)(4326008)(2906002)(71200400001)(107886003)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:MW3PR11MB4537;H:MW3PR11MB4539.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8WGSlDGBtMYFQTESCbopHhYlcx6G56xosq3VIzaKxRLpBIgbGS/LQrgISbow3mcqs6Qv39VA3j4mIwtZsTSCHVtRqyj+GlLO+5OJyXm+RRz9FBH6C71Ly2uPyuwNbM0Cm9cXT88HJZEh9pLLO2gujaxZmBT871zpIsLYYwGpI3kiJgcbgNseBWbhQLjDOjadflg60Hb1vgEb+zszq/DwJPMJtKfaTvMSRCvLQvNcnxV5k97hRgUrZidF17GfRtqmXGdD7GK8h2hONsvMYGXQ+Bs85fsrKn2H2e5l5d0h8Jw/JTmLAOUtjNkOUZo7e1CAToX8aRCYL/ahJHYlqD9Ye3fZwMr2IU6AZ2oT8PDd5x6aznzvs4iwzdtAy0MIHrnaMjxcnUtyrTsivOcYQKCVA7A/4KIkcEyBFHsgH/T/N6649RWDPhBbuTntf4d9GyYX
x-ms-exchange-antispam-messagedata: H/OTdz959847Yndm2DiQbsJn1HKCgZQT8jUfrGLFBSpTjSfWy7ZMpo17WWl7YGyJU+9hBeffG5HcSFgrMIPSaTHap/bQfIfq0aUCY8yhwO9pti6WK8gayLwxygxvNyA7uRFiQIuct/v0aeZXfL1sbw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <2238EBE96963ED4CA42BF007BA8E2E86@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c907c25f-5b43-4e4e-3485-08d7d1a77917
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2020 17:02:31.5789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N+MFd6K6yEB8s7Nc4VINmB2qk8OL/80wZL2ovFvRQNxUjTFQwS34HJvC4gilU80p8F6lPn67AVj9JEB6KWufLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4537
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gV2VkLCAyMDIwLTAzLTI1IGF0IDE5OjEyICswMDAwLCBHaXgsIEJyaWFuIHdy
b3RlOg0KPiBIaSBQcmF0aHl1c2hhLA0KPiANCj4gSW5nYSBhbmQgSSBoYXZlIGJlZW4gdGFsa2lu
ZywgYW5kIGNvbXBhcmluZyBiZWhhdmlvciB0byBzcGVjLCBhbmQgd2UgYmVsaWV2ZSB0aGF0IHRo
ZSAqb25seSogd2F5IHRoYXQgaW52YWxpZA0KPiBkYXRhIGNhbiBtYWtlIGl0cyB3YXkgaW50byB0
aGUgc3lzdGVtIGlzIHRvIGhhbmQtZWRpdCB0aGUgbm9kZS5qc29uIGZpbGUsIHdoaWNoIGlzIG5v
dCBzb21ldGhpbmcgd2Ugd2FudCB0bw0KPiBlbmNvdXJhZ2UuICBXZSBzdWdnZXN0IG1vdmluZyB2
YWxpZGF0aW9uIHRvIHdoZXJlIHRoZSBub2RlLmpzb24gaXMgcmVhZC4uLi4NCj4gbWVzaC9jb25m
aWctanNvbi5jIGluIHBhcnNlX2ZlYXR1cmVzKCkNCj4gDQo+IEJhc2ljYWxseSwgd2Ugb25seSBj
YXJlIGlmIA0KPiAgICAgIm1vZGUiOiJlbmFibGVkIiwNCj4gDQo+IGluIHdoaWNoIGNhc2UsIHdl
IHJhbmdlIGNoZWNrIGludGVydmFsICgxMC0zMjApIGFuZCBjb3VudCAoMS04KS4NCj4gDQo+IEFu
eSB2YWx1ZXMgb3V0c2lkZSB0aGF0IHJhbmdlLCB3ZSAiRmFpbCB0byBQYXJzZSIgdGhlIG5vZGUs
IGFuZCB0aGF0IG5vZGUgd2lsbCBub3QgYmUgbG9hZGVkLi4uLiAgU28gZWRpdCB0aGUNCj4gbm9k
ZS5qc29uIGJ5IGhhbmQgKm9ubHkqIHdpdGggbGVnYWwgYXJndW1lbnRzLg0KPiANCj4gQmV5b25k
IHRoYXQsIGlmIHJlbGF5IGlzICJkaXNhYmxlZCIgb3IgInVuc3VwcG9ydGVkIiwgdGhlIGludGVy
dmFsIGFuZCBjb3VudCBhcmUgZG9uJ3QgY2FyZXMsIGFuZCB0aGVyZSBpcyBubw0KPiBvYmxpZ2F0
aW9uIGZvciB0aGUgMm5kIHBhcmFtZXRlciBvY3RldCBvZiBSRUxBWV9TVEFUVVMgdG8gYmUgemVy
bydkLiAgQXMgZm9yIHRoZSBpbmNvbWluZyBSRUxBWV9TRVQsIHRoZXJlDQo+IGFyZQ0KPiBubyBv
dXQgb2YgcmFuZ2Ugb3IgZGlzYWxsb3dlZCB2YWx1ZXMgZm9yIGNvdW50IG9yIGludGVydmFsLiAg
DQo+IA0KPiANCj4gT24gV2VkLCAyMDIwLTAzLTI1IGF0IDAwOjU3ICswNTMwLCBQcmF0aHl1c2hh
IE5lbGx1cmkgd3JvdGU6DQo+ID4gRnJvbTogUHJhdGh5dXNoYSBOIDxwcmF0aHl1c2hhLm5Ac2Ft
c3VuZy5jb20+DQo+ID4gDQo+ID4gQWRkZWQgbGltaXQgY2hlY2tpbmcgY29uZGl0aW9uIGZvciBj
b3VudCBhbmQgaW50ZXJ2YWwNCj4gPiBiZWZvcmUgcHJvY2Vzc2luZyBmb3IgY291bnQgYW5kIGlu
dGVydmFsIHN0ZXBzLg0KPiA+IC0tLQ0KPiA+ICBtZXNoL2NmZ21vZC1zZXJ2ZXIuYyB8IDYgKysr
KystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvbWVzaC9jZmdtb2Qtc2VydmVyLmMgYi9tZXNoL2NmZ21v
ZC1zZXJ2ZXIuYw0KPiA+IGluZGV4IDcxMTE0MTFjNy4uMTUxY2FiMTU0IDEwMDY0NA0KPiA+IC0t
LSBhL21lc2gvY2ZnbW9kLXNlcnZlci5jDQo+ID4gKysrIGIvbWVzaC9jZmdtb2Qtc2VydmVyLmMN
Cj4gPiBAQCAtODgxLDcgKzg4MSwxMSBAQCBzdGF0aWMgYm9vbCBjZmdfc3J2X3BrdCh1aW50MTZf
dCBzcmMsIHVpbnQzMl90IGRzdCwgdWludDE2X3QgdW5pY2FzdCwNCj4gPiAgCQluID0gbWVzaF9t
b2RlbF9vcGNvZGVfc2V0KE9QX0NPTkZJR19SRUxBWV9TVEFUVVMsIG1zZyk7DQo+ID4gIA0KPiA+
ICAJCW1zZ1tuKytdID0gbm9kZV9yZWxheV9tb2RlX2dldChub2RlLCAmY291bnQsICZpbnRlcnZh
bCk7DQo+ID4gLQkJbXNnW24rK10gPSAoY291bnQgLSAxKSArICgoaW50ZXJ2YWwvMTAgLSAxKSA8
PCAzKTsNCj4gPiArDQo+ID4gKwkJaWYgKGNvdW50ID4gMCAmJiBpbnRlcnZhbCA+PSAxMCkNCj4g
PiArCQkJbXNnW24rK10gPSAoY291bnQgLSAxKSArICgoaW50ZXJ2YWwvMTAgLSAxKSA8PCAzKTsN
Cj4gPiArCQllbHNlDQo+ID4gKwkJCW1zZ1tuKytdID0gMDsNCj4gPiAgDQo+ID4gIAkJbF9kZWJ1
ZygiR2V0L1NldCBSZWxheSBDb25maWcgKCVkKSIsIG1zZ1tuLTFdKTsNCj4gPiAgCQlicmVhazsN
Cg==
