Return-Path: <SRS0=KN4I=5X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E82BC2BA80
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 17:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A152078C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 17:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="hKOJVcUg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgDGROM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Apr 2020 13:14:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:41044 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgDGROM (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Apr 2020 13:14:12 -0400
IronPort-SDR: lNg13EqyS9twcAiq69MGcDlMNXb6rpXuUO19FKLBOod+Do3HfubGGBwG8gR74rry1WkzC1ouJF
 em7mVdIzz23g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 10:14:13 -0700
IronPort-SDR: fTIhKwJxW9bgLG+1mIgxympOAmEdvRbUsNgDKSwf8xI93evilSP7ox46sdJy1U17h/DXhpgSEG
 occ+LnczRA5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,355,1580803200"; 
   d="scan'208";a="361594566"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga001.fm.intel.com with ESMTP; 07 Apr 2020 10:14:12 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 7 Apr 2020 10:14:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 7 Apr 2020 10:14:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=he6Gxk0K/0U0zI6NCyelRHtBUSYDlS0iijT/MqO3oX5TpVnVNQL0ZsARHJsCHOUY9t4zd+FKuPwbc9LtdmoXsjQX840qua/jSpSKhC5jn3pC2W2lSpx5Am2SJptNQbvPotQr/8bkSvYj/WAsz4zZJL2cqH+nN4prb9Jux4dtvl4CUcF707H/f00MfVrWF1SjdNLJ0YtARJ0vMdZFrRTAAokMqL0W0FU66q0APOhEknrf70GxbD3ghAU0ECGbRTO4Siv+WlPbICFcCZW/PuMILYKUGhvBOwWN6w2GDFoAq5Bdb/9/fNosU/3CdTJVSXi1nTwLIehf+4oFiOlUfuimEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FB2DCmYipeyMJEQMqMRSKGmUjREhBLWUY4/J7jIFBgo=;
 b=WO7OF8M+FXv9tJaq+5oVISspoiIp/Q8aFdrcUbPEQjIxaWUykfkutpxVE0UdPEiO6rQRmoU++xdrJnMC76KT4QQ4YRGoTjGgzjw5cyl/+p1ea1eIBTmWsdL+n3fKbdzH0QbybWFD1sP1Te9kASsmH9+PRYzkVT/hh5ioC3DckanH61ZsAY8elXFTU2mcp9OoWML7Gs1mTaYr9mpCylj73kpjQi6EBPwKR2An86azCgMcYeVbVcSbbItE/Sd5sDCSbk0FSd/7Bf3wd1c6GPbn82GarFDY8KtyQgJfQ+gBfUfqHV6MXJgw2vjGZV6PaWryAdiXpwMztbj43XHMlLt+dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FB2DCmYipeyMJEQMqMRSKGmUjREhBLWUY4/J7jIFBgo=;
 b=hKOJVcUgkmruVeLr7hv+9z5z6R9LUg59pRsSzSybh2LyEarCXGterYIED0QBE39aGqMpK5EGYYeJYeQombrNbSUJABVNCFbljx5aCuaCRwRhX+pX2woGSeeNGRYcrePC2trahQIY8+KCD0lIFEcIgV8UfAQexGlz0pBqn8o61MA=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4668.namprd11.prod.outlook.com (2603:10b6:303:54::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Tue, 7 Apr
 2020 17:14:09 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a%3]) with mapi id 15.20.2900.015; Tue, 7 Apr 2020
 17:14:09 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ RESEND] mesh: Remove redundant code from mesh/crypto
Thread-Topic: [PATCH BlueZ RESEND] mesh: Remove redundant code from
 mesh/crypto
Thread-Index: AQHWA7P/1NgK5Fw5002PJCTl12t5+6hnuk8AgAY+L4A=
Date:   Tue, 7 Apr 2020 17:14:09 +0000
Message-ID: <d17b4cdb17f1c9757f7ab2db35c32390c357ac0c.camel@intel.com>
References: <20200326211705.18678-1-michal.lowas-rzechonek@silvair.com>
         <20200403175402.xto4ub6w6uqqyfz4@kynes>
In-Reply-To: <20200403175402.xto4ub6w6uqqyfz4@kynes>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [134.134.137.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab460f74-3c20-44c2-63a9-08d7db171632
x-ms-traffictypediagnostic: MW3PR11MB4668:
x-microsoft-antispam-prvs: <MW3PR11MB4668CF4671034E3F28B67818E1C30@MW3PR11MB4668.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 036614DD9C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(136003)(39860400002)(376002)(396003)(346002)(366004)(6512007)(4744005)(71200400001)(76116006)(478600001)(2616005)(6486002)(66946007)(8676002)(8936002)(316002)(81156014)(66556008)(66476007)(81166006)(2906002)(64756008)(186003)(5660300002)(6506007)(110136005)(66446008)(86362001)(26005)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EGC1GHY2xiBxrUpWDgMGaK546horuDCDD8HQbL/IX6qfqJMsI6RjcFHNSrK9jfGav94OkQ0to/QS+YSxJVEzyP8Ek2nmz9MTJ6UzBYocMsV0b/B3HUQBpmL2IeiOChy3iqhY2wwLQhDffV8wpbNSKizeGOzv2xi/pbQ5tKqnurxXZIiVdPldKKQs2g4U+CpYfWgYLb+MnYDZsnfyRbXw9pyAh+6ndSyTZAlzqmWu71pqQq1fr91w+gEVfBSn2B/+lKNFtbk/ulGOgl6EmzI8m/NVCKTRDM4h9n5ZOvluZhXAspHGS5ChgFjDgS48QpZtvvF/Xjj8pxR/GBThgTxDrFRZm/PKSvAWyACG+WHFok/RvkSWfM16dL3goj2FAzwn1bJOMkhsIAS3PKdHxUNvo1lzi6IQxYyt/WggMLsSOkjgsrvlNje9SP04stUiJPHj
x-ms-exchange-antispam-messagedata: CXB1OTeuwSEN6Pg/ksBMQCUByZt5ucuOAZkFRaQswbvSNZh604x+lRX7mlVd9M5bbFjLW5ufLrRMmkjBfwEkCONT95eOUT0A8oKrMefR4qfCykvGXCeL8HYYQDd5/dmf1wsdhoMdOjNojUUiGtFidA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2B7FEE87CE485418B2A810F6F319451@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ab460f74-3c20-44c2-63a9-08d7db171632
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2020 17:14:09.8161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x/fHNxlqsdyid+RGXi4P3wgSk5XTP/c3d9orcHt7fUy2egOh4ggAeRqr3jdV4BLT91UNzVnUO/zYLTrvqnp/1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4668
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2ggYXBwbGllZCB3aXRoIGFncmVlZCB1cG9uIGFkanVzdG1lbnRzDQoNCk9uIEZyaSwgMjAy
MC0wNC0wMyBhdCAxOTo1NCArMDIwMCwgTWljaGHFgiBMb3dhcy1SemVjaG9uZWsgd3JvdGU6DQo+
IEJyaWFuLA0KPiANCj4gT24gMDMvMjYsIE1pY2hhxYIgTG93YXMtUnplY2hvbmVrIHdyb3RlOg0K
PiA+IC0gUmVtb3ZlIGFwcGxpY2F0aW9uX2VuY3J5cHQvYXBwbGljYXRpb25fZGVjcnlwdA0KPiA+
IC0gTWFrZSBtZXNoX2NyeXB0b19wcml2YWN5X2NvdW50ZXIgcHJpdmF0ZSwgYWRkIG1lc2hfY3J5
cHRvX3BlY2INCj4gPiAtIE1ha2UgKl9ub25jZSBmdW5jdGlvbnMgcHJpdmF0ZSBhbmQgYWxpZ24g
dGhlaXIgaW1wbGVtZW50YXRpb24gdG8gYmUNCj4gPiAgIG1vcmUgY29uc2lzdGVudA0KPiA+IC0g
UmVmYWN0b3IgbmV0d29ya19lbmNyeXB0L25ldHdvcmtfZGVjcnlwdCB0byB1c2UgKl9ub25jZSBm
dW5jdGlvbnMgYW5kDQo+ID4gICByZW5hbWUgdGhlbSB0byBwYWNrZXRfZW5jcnlwdC9wYWNrZXRf
ZGVjcnlwdA0KPiA+IC0gUmVmYWN0b3IgcGFja2V0X2VuY29kZS9wYWNrZXRfZGVjb2RlDQo+IA0K
PiBQaW5nLi4uDQo+IA0KPiBUaGlzIHZlcnNpb24gb2YgdGhlIHBhdGNoIHBhc3NlcyB1bml0IHRl
c3RzLiBJJ2QgcmVhbGx5IGxpa2UgdG8gZ2V0IHRoaXMNCj4gYXBwbGllZC4gT3IgYXQgbGVhc3Qg
dGVsbCBtZSBzdHJhaWdodCBpbiB0aGUgZmFjZSB0aGF0IEkgc2hvdWxkIGJ1Z2dlcg0KPiBvZmYg
OykNCj4gDQo+IHJlZ2FyZHMNCg==
