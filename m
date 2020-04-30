Return-Path: <SRS0=orbE=6O=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C143CC4724C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Apr 2020 17:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91DBC20731
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Apr 2020 17:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="nnrl4CN0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbgD3R7n (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Apr 2020 13:59:43 -0400
Received: from mga14.intel.com ([192.55.52.115]:49688 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgD3R7m (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Apr 2020 13:59:42 -0400
IronPort-SDR: /z6j+9gXQU8QCDOnQ7Krl2DiK/U/IuE4+TceVixCpcSBKv6okqDwhGrTD21jc28u2Asg4Q9g9L
 lfrCTlUGFdaw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 10:59:41 -0700
IronPort-SDR: mGTowpXT+ustkdIcP1QCIvrhJ2mQU4tbVoLzGh2F+qSI6hPppEOL0CJGkmxn6DXXeocCSUZYp6
 YX0YtN30Pb9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,336,1583222400"; 
   d="scan'208";a="258379989"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga003.jf.intel.com with ESMTP; 30 Apr 2020 10:59:40 -0700
Received: from fmsmsx155.amr.corp.intel.com (10.18.116.71) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 30 Apr 2020 10:59:40 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX155.amr.corp.intel.com (10.18.116.71) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 30 Apr 2020 10:59:40 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 30 Apr 2020 10:59:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8xXSxSrAmPIsFXVE3P14u1eqNvjAvcz5ZJNQjGu3BhRZzgOfrAt3z7i9u5/S8V8RfNPVqPHfVa+qafcrcdRqLumEMDGYRfKNYiBvy00/8GW8WR4SueURae1qkt0uSsRhfa7c4yR3Yr4H7ZGH2AHe9J1NP3hXG4SAsoRK82e37WuSt6HfLcnuGRerD3Oaauh1LxIxxbDG1bQLhu0bWrUi9ub6djtbT5Rv1h5cuYBIhorQYNVikeoIQ8hQRvgXOwx6IH10SorMQ50dFcre37Ww7inf2Cd9lumEn1T3m9RIrp6W+tlY2BLt13FMxau21JYIdvZ9xwhBSvjMgJ4AZ9j8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhdPuiQ82kM4L3gSEX/hvZSkVGd7Nx4PmtGKDUVghUA=;
 b=ZnnCDmZ1245tGKmgBGTRfjuD+z87g5hvbVgLzSE1W2CwWowK1E2VUFPw4qngKV0koeH1/3rEPY9EGZT02cgRZCREDhcAbFyw5CjV3DRy68QjExaR4sK/yl7wjqPvyKW9At9wx1vIie525uVDcpyiMbJf6y5ZITNh6hZrk+KiRwL31dX/qkvzOc+aiPYD6+yR0If4rFnPjKTCC6Gvj9nG77JAxvO69hIhEt13XpTwqNlrLRTfnJlimkzg1DfFOR0VE52osQ7DrVPS5W1w3aZVo7unwwNC3CFDhGTNtWqUKkIG+nTHkbwjjEKqWbAGI9MxRWQO4BqHBfYkSYtpY4X4pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhdPuiQ82kM4L3gSEX/hvZSkVGd7Nx4PmtGKDUVghUA=;
 b=nnrl4CN0BZ/wB453V6HJYfVTTMmszqaIy74GGB4k1H4W+cnbXvyKn1m/g7rwJqKvx305LN76lp5vQEbNHmwSO3D4MnRLJTrNrmYBetaU0pNc8UfpKDHxa5zHrowvAObxCc2444U3v16qsP7opgnmfdJgltsIpmDhNcx0H99jJWg=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4635.namprd11.prod.outlook.com (2603:10b6:303:2c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Thu, 30 Apr
 2020 17:59:37 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5552:f057:3dbf:716c]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5552:f057:3dbf:716c%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 17:59:37 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Fix adding virtual subscription to a vendor
 model
Thread-Topic: [PATCH BlueZ] mesh: Fix adding virtual subscription to a vendor
 model
Thread-Index: AQHWHlDmTHlt4NhkN0e2GvypD/ZNSqiR9ZWA
Date:   Thu, 30 Apr 2020 17:59:37 +0000
Message-ID: <bd98b3ccddd1da430c86a3497e98be495cd86b0f.camel@intel.com>
References: <20200429180541.29791-1-inga.stotland@intel.com>
In-Reply-To: <20200429180541.29791-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7791a31b-7662-405b-9408-08d7ed303f3a
x-ms-traffictypediagnostic: MW3PR11MB4635:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4635FBE260BDCBB09755EDA4E1AA0@MW3PR11MB4635.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0389EDA07F
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(136003)(39860400002)(366004)(396003)(376002)(76116006)(8936002)(6636002)(91956017)(8676002)(66946007)(66476007)(66446008)(478600001)(64756008)(71200400001)(5660300002)(2616005)(66556008)(110136005)(26005)(6512007)(36756003)(6506007)(316002)(4744005)(2906002)(86362001)(186003)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B7rt0JoUyi0Ck7s0VrDh/Td2w4JPbGWbineH07G9GE8o0wYH8JnUcdw2YlO91ZeD6TkiXgikRyDtVs/8U5AHBQ8Rlu1+PhDc/Jcyru/OEbS08D3v6C+ZY+HDenblsVCbBF3vQyVIXwYVOoL82VtL3MdUSP+J/feTehPEWNo0hRPM67e246bUBTnuE6kCDP7pEj4In3SVmc6iEdhbcYVlHUEEAD4QMtV5Kw5jXUMitX/eo82tA50eJZ/R+2Y/7rDKpLM2TQJSBE6Kw8/k+Zp20YPe7EmIcogw+qaVfR/+MgPr78uLF0LcW394iqjZO/F1AzulfSZT7YBs8v4lJ1DTa+foXXfU2S1jLK58JTPiOOQDiG+RB0r7SRFjTnrCtzHJq+53sa6MDoBvzJMkKlKhfAzDUY7lyECanzCNhXY/dydGsKqplOT3kRnZW6JU63/l
x-ms-exchange-antispam-messagedata: qjuD3VQ0W8pNp81NmMTCRSWGaw/ksFdJdmfE1/2pg1TePp70AjGfnquRDAM9KpWcWQoebl9LD2LofoutzHzgL15HAsviLt6yX1202w3OkIKv2Inzd27WicvCfdb/d1Y3Hix6ISqDh82tB7kto+F+WU//gdOVZ4I7UlE7a5pF5Hvw2odJ5CJI+mr+65OnGkTHBsfV0qvDaAd9wZz2A7cABTIqI9v4ha8/REIN3IbpbtESuIMLxtoAGc4B1egmuccC+xIxQrL/rW2ry7tf9iXcmvnFsxXsU8tmd7f2/iJYTKF9PdWsrVjyLuf8isgl8OWS1zuVFvqskBxHnzvRB+UqLeIkaAGEmkfJrAIVhwY2Kfgn9J6w+OeYrPU3K0eeFxeT5yqM2yE06HHaRAUBX+I0h/utOhw1RQQzm5/tnLePngj4zxTuiJvzTCd6dmHIecIhfIVgjnOgQd6SoOQYbAuBA0xZcLz8IhibBocBiVA4u67vy7t1f4QQlqMORRwXFzXTBscMeQlBBfPa0C6T4kvEVkLEYd3wgyvaoH1qhJzIRcejhpS5Ym0mQh5hOFPeHTxeMF9rDHUNnXsVAa9bk4jr0QeqW65ZOst24sOVsygFCdVK1FvY/p5ypw5cKxj9GIjS19fgaZpufjRU7NJIvQm5Kfq/DluZO+zavBo+Iquzyq8PfdOtR/PT+XvaqO2m1JmyU+POiuYGyVt1BNgFt1TIA1N8Q58lSchJEZ3tnb51GhJC+axOchJGti39Ev7rj2w00xiJJ8e8HvfPia/LUJ/b3Xe7ybe8PpD4oLSF97Me3jk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FDA0E6FF6192E548ADB81BE416415B02@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7791a31b-7662-405b-9408-08d7ed303f3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2020 17:59:37.0773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wWbsFCRT9meu9wVgD/lPT9oce7ZQXnjX0lZgcHFGnkmYhp1UDD0hldR0thGmRWN9sfDdOgGsnPQhsHYxHY1Okg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4635
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBXZWQsIDIwMjAtMDQtMjkgYXQgMTE6MDUgLTA3MDAsIEluZ2EgU3RvdGxh
bmQgd3JvdGU6DQo+IFRoaXMgZml4ZXMgYSBjYXNlIHdoZW4gYSBjb25maWd1cmF0aW9uIHNlcnZl
ciByZWNlaXZlcyBhIHZpcnR1YWwNCj4gc3Vic2NyaXB0aW9uIGFkZC9vdmVyd3JpdGUgY29tbWFu
ZCB0YXJnZXRpbmcgYSB2ZW5kb3IgbW9kZWwuDQo+IENvcnJlY3RseSBzZXQgInZlbmRvciIgYXJn
dW1lbnQgYmVmb3JlIHRyeWluZyB0byBzYXZlIHRoZSB1cGRhdGVkDQo+IHN1YnNjcml0aW9uIHRv
IGNvbmZpZ3VyYXRpb24gZmlsZS4NCj4gLS0tDQo+ICBtZXNoL2NmZ21vZC1zZXJ2ZXIuYyB8IDEg
Kw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
bWVzaC9jZmdtb2Qtc2VydmVyLmMgYi9tZXNoL2NmZ21vZC1zZXJ2ZXIuYw0KPiBpbmRleCA4NTZl
YjZiMjcuLjk0ODI1ZWQwZSAxMDA2NDQNCj4gLS0tIGEvbWVzaC9jZmdtb2Qtc2VydmVyLmMNCj4g
KysrIGIvbWVzaC9jZmdtb2Qtc2VydmVyLmMNCj4gQEAgLTM1OCw2ICszNTgsNyBAQCBzdGF0aWMg
dm9pZCBjb25maWdfc3ViX3NldChzdHJ1Y3QgbWVzaF9ub2RlICpub2RlLCB1aW50MTZfdCBuZXRf
aWR4LA0KPiAgCWNhc2UgMjI6DQo+ICAJCWlmICghdmlydCkNCj4gIAkJCXJldHVybjsNCj4gKwkJ
dmVuZG9yID0gdHJ1ZTsNCj4gIAkJbW9kX2lkID0gbF9nZXRfbGUxNihwa3QgKyAxOCkgPDwgMTY7
DQo+ICAJCW1vZF9pZCB8PSBsX2dldF9sZTE2KHBrdCArIDIwKTsNCj4gIAkJYnJlYWs7DQo=
