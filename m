Return-Path: <SRS0=lRrI=3M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1E2C2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jan 2020 15:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0A821734
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jan 2020 15:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="T5InFTru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgAWPlA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Jan 2020 10:41:00 -0500
Received: from mga18.intel.com ([134.134.136.126]:11716 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbgAWPk7 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Jan 2020 10:40:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2020 07:40:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,354,1574150400"; 
   d="scan'208";a="307858453"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga001.jf.intel.com with ESMTP; 23 Jan 2020 07:40:58 -0800
Received: from fmsmsx163.amr.corp.intel.com (10.18.125.72) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 23 Jan 2020 07:40:25 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx163.amr.corp.intel.com (10.18.125.72) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 23 Jan 2020 07:40:25 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 23 Jan 2020 07:40:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQAJYPNFSrHceLyDL3Rc6xXiSBjE6pkpgTG+egVuTVjuln2uMkJ642TkFJm0W6jcDYUENsffxDRK65sSM+bq8u3UNxiTDUzA6XrvuLa9PUg1wtyuq7w01WW44BnuyvYJKJLny0XIrm9MQyKoNHGn9Y5+2XDJIK50UUWtXvxZztvUWNlZ35JW1O3JaElQ4wW3IT1eyWbuaks+5n9yHrsRzX5G6JskOQUUuJKemBbIfvKkyMd07utPMBPi6+7VWAtcYAN44HGV6Gh4/BxKkFzST/Skz0wfmNWR9aGShr+V5VGWy8G2fQwmgPbDxuDDVpqz7eCLey33pVrllCfpYUPoIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXxoVbg8d2k3e8qHBYe5kfsI/1e+EyKir6KDd038Fts=;
 b=XjC2Kh1mu3kbXfYsfPWEuwZHeYN4mi/QBME4t2/atGeJ1KqpQIG0qbcjKelYygeUdAiyyC+d3eIc0bG+ATmixVEz+bREtt0i3nleLOkAzbLrPXpbVBDKObm9owbwctrh8clnpsFPPYiCMI3dje+BvftWAuIzsWNIWkq8I99O33E8uz+6aLUJvzc0Fn017fQ1Sb77ehjYAr3Oo1G0ZIgL9h66aVLkEMWFkyKaxNb2L0mg3zxs69aiNG2FLTIk7iCJkG8hvcd49aDyHskSoKYNBDV3e2+0Z0IPs6ncpVHVFaxoY8FK5i8ope5EMsVCxOpT4Giuw38XvEGh1eCzPzXKDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXxoVbg8d2k3e8qHBYe5kfsI/1e+EyKir6KDd038Fts=;
 b=T5InFTruKFBFlInUgfyjixhlqmSuT8y21YC7NN355EjZt8Urb8H7q+P3+6oZnSHjO7ey9X83ZyVQ7ap/U+JGmJ5h7oANC/wNSaRR9wbvOl1XB7WuTm6emRBGUqAJM5URhHutmdSw6mcUTHGbgmj3dSvop1nSbcmM3+djqkPc4gY=
Received: from DM5PR11MB1659.namprd11.prod.outlook.com (10.172.35.20) by
 DM5PR11MB2044.namprd11.prod.outlook.com (10.168.106.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Thu, 23 Jan 2020 15:40:24 +0000
Received: from DM5PR11MB1659.namprd11.prod.outlook.com
 ([fe80::7509:1f7f:7c88:8afe]) by DM5PR11MB1659.namprd11.prod.outlook.com
 ([fe80::7509:1f7f:7c88:8afe%7]) with mapi id 15.20.2665.017; Thu, 23 Jan 2020
 15:40:24 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "shaunak.01@samsung.com" <shaunak.01@samsung.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/1] mesh: Fix provisioning agent method call failure
Thread-Topic: [PATCH 1/1] mesh: Fix provisioning agent method call failure
Thread-Index: AQHV0R3hNfQkTiyuO0eh+3jmMt5qp6f4ZJ2A
Date:   Thu, 23 Jan 2020 15:40:23 +0000
Message-ID: <c379712c024e4122fd464a1a4933ee52bcaf1494.camel@intel.com>
References: <CGME20200122121618epcas5p1c87cda317c786f71497ad61237843227@epcas5p1.samsung.com>
         <1579695370-12779-1-git-send-email-shaunak.01@samsung.com>
In-Reply-To: <1579695370-12779-1-git-send-email-shaunak.01@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de1cf3e0-0a65-4f48-78fe-08d7a01a901a
x-ms-traffictypediagnostic: DM5PR11MB2044:
x-microsoft-antispam-prvs: <DM5PR11MB2044574C478BF979167E3828E10F0@DM5PR11MB2044.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:576;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(39860400002)(346002)(376002)(199004)(189003)(2906002)(86362001)(8676002)(186003)(2616005)(4744005)(5660300002)(26005)(81156014)(81166006)(8936002)(6506007)(6512007)(110136005)(316002)(6486002)(71200400001)(66946007)(36756003)(478600001)(66446008)(66556008)(64756008)(66476007)(91956017)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR11MB2044;H:DM5PR11MB1659.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9t0rHgDsazxM9ixPUXZJacuZfNjVw5YQpvRhLSkkRkr3y7jEOHF5zAikY3u0gYEoeVBP2rDM7Q7rMhaD/jKDcFoXy9+7KPnrXblCRhSBKG8K5fAs5IzY9ApKjb8+LKeYDj8gy6sAuFAhu5SPh0EwTfs6cL/xT94lHkueSNSto8r4LCDlmJzkBWh4xVWN/cT59wTl0/hZoJyY7xW5OerVtp2S0Lo4gCHUObA8q8JXdjHXSMOr87X6TGFcu6apTgu4fxzqcp09Db6bV7x6dzBFsbrJWyoydpdfQOYaCvQM1gqqjcA+NMe+NlJSSxuihOau4xSsSDlF0lxOXLByWuBRPb5+Mbc+wfV3LXVWdy3yh5FzITgVPOOfbB1Ldv5dI2U8OZCMdk0nUrMuIFSvpMH9sRbKErXSeovKlhfk2qlZv3z/ObLasn9gKmFH7Shxe2L+
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F7861E7C83BBA498F02F4BE57373585@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: de1cf3e0-0a65-4f48-78fe-08d7a01a901a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 15:40:24.0533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FQhIrIjemr7ZxPCHETFQK4m66qNWPT+ghvxH3lxxRxwQ6a3ey/HSxlnX/0A8rEF9drSRfwyT9mE8meUmR6BeYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB2044
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gV2VkLCAyMDIwLTAxLTIyIGF0IDE3OjQ2ICswNTMwLCBTaGF1bmFrIFNvbWFu
IHdyb3RlOg0KPiBQcm92aXNpb25pbmcgYWdlbnQgaW50ZXJmYWNlIG1ldGhvZHMgUHVibGljS2V5
LCBQcml2YXRlS2V5IGFuZA0KPiBDYW5jZWwgZG8gbm90IGFjY2VwdCBhbnkgcGFyYW1ldGVycy4g
U28sIHdoaWxlIGludm9raW5nIHRoZW0NCj4gZXhwbGljaXRseSBzZXQgdGhlIHBhcmFtZXRlcnMg
dG8gIiIuDQo+IC0tLQ0KPiAgbWVzaC9hZ2VudC5jIHwgNSArKysrKw0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21lc2gvYWdlbnQuYyBiL21l
c2gvYWdlbnQuYw0KPiBpbmRleCA5ZjkzOTlmLi4zYWIzODkzIDEwMDY0NA0KPiAtLS0gYS9tZXNo
L2FnZW50LmMNCj4gKysrIGIvbWVzaC9hZ2VudC5jDQo+IEBAIC01MTUsNiArNTE1LDggQEAgc3Rh
dGljIGludCByZXF1ZXN0X2tleShzdHJ1Y3QgbWVzaF9hZ2VudCAqYWdlbnQsDQo+ICAJCQkJCQlN
RVNIX1BST1ZJU0lPTl9BR0VOVF9JTlRFUkZBQ0UsDQo+ICAJCQkJCQltZXRob2RfbmFtZSk7DQo+
ICANCj4gKwlsX2RidXNfbWVzc2FnZV9zZXRfYXJndW1lbnRzKG1zZywgIiIpOw0KPiArDQo+ICAJ
bF9kZWJ1ZygiU2VuZCBrZXkgcmVxdWVzdCB0byAlcyAlcyIsIGFnZW50LT5vd25lciwgYWdlbnQt
PnBhdGgpOw0KPiAgDQo+ICAJbF9kYnVzX3NlbmRfd2l0aF9yZXBseShkYnVzX2dldF9idXMoKSwg
bXNnLCBrZXlfcmVwbHksIGFnZW50LCBOVUxMKTsNCj4gQEAgLTY0OSw1ICs2NTEsOCBAQCB2b2lk
IG1lc2hfYWdlbnRfY2FuY2VsKHN0cnVjdCBtZXNoX2FnZW50ICphZ2VudCkNCj4gIAltc2cgPSBs
X2RidXNfbWVzc2FnZV9uZXdfbWV0aG9kX2NhbGwoZGJ1cywgYWdlbnQtPm93bmVyLCBhZ2VudC0+
cGF0aCwNCj4gIAkJCQkJCU1FU0hfUFJPVklTSU9OX0FHRU5UX0lOVEVSRkFDRSwNCj4gIAkJCQkJ
CSJDYW5jZWwiKTsNCj4gKw0KPiArCWxfZGJ1c19tZXNzYWdlX3NldF9hcmd1bWVudHMobXNnLCAi
Iik7DQo+ICsNCj4gIAlsX2RidXNfc2VuZChkYnVzLCBtc2cpOw0KPiAgfQ0K
