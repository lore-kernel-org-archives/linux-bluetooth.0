Return-Path: <SRS0=kdk/=ZN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A40AC432C0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Nov 2019 15:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2CFC20692
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Nov 2019 15:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="HRXwy1Q6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfKUP5j (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:57:39 -0500
Received: from mga05.intel.com ([192.55.52.43]:4096 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbfKUP5j (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Nov 2019 10:57:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2019 07:57:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,226,1571727600"; 
   d="scan'208";a="219124603"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga002.jf.intel.com with ESMTP; 21 Nov 2019 07:57:37 -0800
Received: from fmsmsx161.amr.corp.intel.com (10.18.125.9) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 21 Nov 2019 07:57:37 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX161.amr.corp.intel.com (10.18.125.9) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 21 Nov 2019 07:57:37 -0800
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.50) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 21 Nov 2019 07:57:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xuab1KJbBlzruIP1zyH9+bKyIusajfm40nhAG9MD+KuTZ47NyVFaRpvxbdyx+wN+7GVuQ+R5viRDCgQCqmOPbxhQmc4ULdyriycfPxHL44LmvilzMmTwN/FLGikW7/ppS0EJ2OVjoYRCRg8ehvlioD00egkSOnImhV2XJSa7hTwaC0QRJ98MsIcz+XfHHdNnxdzD0JlI39xuevc8hGSiqrxXjZNsql7MNJu8a1ONNpVCzrcBWF3CR2jTbk4OstbOIBLUjBN+ZNi+UFpB9q4km85u8SXi8H97g+CIFJhbKZsphbqM1ltfWjjjmtXX/kGIu61M00oxdFdIIzKuMgNm+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TE0gd291ckEaz6cZ+IJJ5T4HotrFCP7ko193qOwPfNM=;
 b=ESLN3GIQM2iKbRbfVzAd/s3rWN8LspuaL30dZ0DspJpaQcwd51F2i1K07IDqeIV0xcrPbLhQMWkbQAiGfF1WwQ2HKYBx+bNkiyU/8whxByJ9O8NHAUcr6GXRUVGQJF6wM01rpCefmBySDTsKtPHPzmkNShmsWn7ZPBsNI4j8tyqLaiSkPZmkKzsr4lCp9iX1QgvMLgY+xsssMohqlnMY1oRb3ODxCCaXYLm1aZ4OEybwy1xp8b3sfEMbSsr1muV0JB5VfC2RjQ0ukWeA3rcNXowLjHT0+1B59AHHvJpATSA0DcVKeoRDy1Z9XdDOFHI/c7PYa0I2Z00Gmsgzcz4MuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TE0gd291ckEaz6cZ+IJJ5T4HotrFCP7ko193qOwPfNM=;
 b=HRXwy1Q6UJ/1AEHGE3QVlVwsSkUKl/dII28JPDRSJcGKcoy4asXYfs6tufxAXdsh2mIhbWfy+62ZZdiBovPBVElczG8xnJCGbnh1o/3v3+v3yfrsUJsJLaxdTavEXC229USnD+gj7qcobmhTjYWOWV10YTttgH8Se3tu2/x0w94=
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com (10.172.76.7) by
 CY4PR1101MB2183.namprd11.prod.outlook.com (10.172.76.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.27; Thu, 21 Nov 2019 15:57:22 +0000
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::44:eac4:f8c8:ad06]) by CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::44:eac4:f8c8:ad06%11]) with mapi id 15.20.2451.031; Thu, 21 Nov 2019
 15:57:22 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ 0/2] Include destination address in MessageReceived
 API
Thread-Topic: [PATCH BlueZ 0/2] Include destination address in MessageReceived
 API
Thread-Index: AQHVnibLcvuir4OpSkScxr1NbOV+EaeVTF+AgACACoA=
Date:   Thu, 21 Nov 2019 15:57:21 +0000
Message-ID: <46204393f93bd9a3d6eada6be35a7ec85934ee49.camel@intel.com>
References: <20191118154147.3589-1-michal.lowas-rzechonek@silvair.com>
         <20191121081905.zb4m5gqj5kywjl3v@mlowasrzechonek2133>
In-Reply-To: <20191121081905.zb4m5gqj5kywjl3v@mlowasrzechonek2133>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f4ef837-e80a-4006-7d29-08d76e9b7eae
x-ms-traffictypediagnostic: CY4PR1101MB2183:
x-ms-exchange-purlcount: 1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1101MB218342F35F04671E8FF8AEE5E14E0@CY4PR1101MB2183.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(376002)(396003)(136003)(199004)(189003)(4744005)(76176011)(36756003)(8676002)(15650500001)(86362001)(508600001)(4326008)(446003)(11346002)(71190400001)(71200400001)(5660300002)(6486002)(14454004)(81156014)(81166006)(966005)(76116006)(91956017)(26005)(6246003)(6436002)(186003)(3846002)(6306002)(6506007)(6512007)(102836004)(6116002)(2906002)(66476007)(66946007)(2616005)(256004)(99286004)(316002)(107886003)(7736002)(66446008)(64756008)(4001150100001)(25786009)(118296001)(229853002)(66066001)(66556008)(305945005)(110136005)(8936002)(2501003)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1101MB2183;H:CY4PR1101MB2262.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +07gxK35PK4ifNeEki4EdnnENIXCjQ2sil9/hIvR3v58EZPw6FbU6YTv2ExqdmZ9Im/+BNhAEqkty43alG+/QvqlKTnZ+er+zcR3xN0DUWNQrWqyF3zGhqpjTHaUsXJ73Sr0Z2DFcBsyEbKluRN7HBk9RtKri1QYYXTtOXmgfda5Vp4Fp9UDgMfuTwLrfgBiwNiPVIPFRndxxnT2rgugRUSXB51lW+gUreS8G86vFzlFykdsOobmy1axsofwu/tq7lfYO3sK/gwhwbwmbM0GkR8Y6zCmqYDP8geYPOwgd8lM04RPtSxFOXnyQK2Sr9I40lUI7IOzbCN+jRpZR2wQjZkL7PKUZTrWnn6KMg7FwP9cKSIE8R37df2+wCHT/iqNMX6aTXLqG+5kOAUlqq0ThXMzqWccUhZzoK7m9mUcwWhCGEfpR8gtSQJWb4+wZvHVIy51NSCDyeZCiHbN2tVEKuqhuepAk1eKBPo6ZASisfU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38127671EAFC1040AC833170F4961DFA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4ef837-e80a-4006-7d29-08d76e9b7eae
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 15:57:21.9675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YFuFuQkBZZUkJot3/z08SMk+XWAz4B9xuJYiUjvKSTlRbsamwiMeqqrHCA/E85KasoLd6gnEec8JdikQvIOmEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2183
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGHFgiwNCg0KT24gVGh1LCAyMDE5LTExLTIxIGF0IDA5OjE5ICswMTAwLCBNaWNoYcWC
IExvd2FzLVJ6ZWNob25layB3cm90ZToNCj4gSGkgQnJpYW4NCj4gDQo+IE9uIDExLzE4LCBNaWNo
YcWCIExvd2FzLVJ6ZWNob25layB3cm90ZToNCj4gPiBUaGlzIHBhdGNoc2V0IGNoYW5nZXMgdGhl
IE1lc3NhZ2VSZWNlaXZlZCBBUEksIHJlcGxhY2luZyAnc3Vic2NyaXB0aW9uJw0KPiA+IGZsYWcg
d2l0aCBkZXN0aW5hdGlvbiBhZGRyZXNzIG9mIHJlY2VpdmVkIG1lc3NhZ2VzLg0KPiA+IA0KPiA+
IFRoZSBhcHBsaWNhdGlvbiByZWNlaXZlcyBkZXN0aW5hdGlvbiBhZGRyZXNzIGFzIGEgRC1CdXMg
dmFyaWFudCwNCj4gPiBjb250YWluaW5nIGVpdGhlciBhcyBhIHJlZ3VsYXIgMTZiaXQgYWRkcmVz
cyAodW5pY2FzdC9ncm91cCkgb3IgYQ0KPiA+IDE2LW9jdGV0IHZpcnR1YWwgbGFiZWwuDQo+ID4g
DQo+ID4gU2VlIHByZXZpb3VzIGRpc2N1c3Npb24gaHR0cHM6Ly9tYXJjLmluZm8vP3Q9MTU2NzE5
MDY3MzAwMDAxJnI9MSZ3PTIgZm9yDQo+ID4gcmF0aW9uYWxlLg0KPiANCj4gQW55IGNvbW1lbnRz
IGFib3V0IHRoZSBwYXRjaHNldD8gSWYgdGhlIGNoYW5nZSBpdHNlbGYgbG9va3MgT0ssIEknbQ0K
PiBoYXBweSB0byBpbXByb3ZlIHRoZSBwYXRjaCBpZiBuZWVkZWQuDQoNCldlIGFyZSBzdGlsbCBy
ZXZpZXdpbmcgdGhlIHBhdGNoLCBhbmQgaW50ZW5kIHRvIGFwcGx5IGl0LiAoV2UgYWNjZXB0IHRo
ZSByYXRpb25hbGUpLg0KDQpXZSBuZWVkIHRvIG1ha2Ugc3VyZSB0aGF0IGFsbCBvZiB0aGUgZXhp
c3RpbmcgdG9vbHMgYW5kIHRlc3RzIHdvcmsgd2l0aCB0aGUgQVBJIGNoYW5nZS4NCg0KLS1Ccmlh
bg0K
