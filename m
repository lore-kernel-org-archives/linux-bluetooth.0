Return-Path: <SRS0=NHH5=EE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AA9C4363A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 02:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62BA220790
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 02:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="LNa3CWNS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgJ1Vd6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Oct 2020 17:33:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:60661 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbgJ1Vdt (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Oct 2020 17:33:49 -0400
IronPort-SDR: FWuXQa3cSlcKjpqugo1i0g4fSKU/w+zcLgX8N4GZ1RS/zpo82lLYfKEeMsWRj2O8jzaUne57dU
 iXx5tXmHWjiA==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="186110946"
X-IronPort-AV: E=Sophos;i="5.77,428,1596524400"; 
   d="scan'208";a="186110946"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2020 14:26:40 -0700
IronPort-SDR: ad4ioUvVC97ACtsx3DDlv9Z798kpyzzXLy465HTISeRJMcbU/zoRlg6I6DE4q71wCQ+4bZGJQR
 DWg5kWRux/cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,428,1596524400"; 
   d="scan'208";a="350746115"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga008.jf.intel.com with ESMTP; 28 Oct 2020 14:26:39 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 28 Oct 2020 14:26:39 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 28 Oct 2020 14:26:39 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 28 Oct 2020 14:26:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NbnfzwGNswd5roQXUJtIrHopWDII8glIg0ToBcYClcCqkMXpEvYW4Y/8/2jd32ZETz5azolxWhbVAqZYE0eVBN0p4oMxpxMpDfZyKhlUcORzIlD8QoO4G2sTd08OIaYdVIDRGzX+T9AyXxHtHQQhi5oyA3vkRTywBMpaaEbj5Tph8lqbg6tXO5yrB4HtJvpNgOEmgfVLQKVSCaqABRMPAV9Wj/B+TiudCu015Hlv5KZwmtcWF7Xoc/26Rek3ExCbTgVeGYuV/XGoLcluGpcr+OEWP5MCJBiJLdn7KI0+3xF3rXuejZDqMwdizpkg5ldXQhGCVAx2RleNe+YK+WsGaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSqqX4pGlHpKnwA5X19FygiSST7jqEKbKwrHR8rjx04=;
 b=BIe0oSc1uIyzlqtBY33+u7RqJuY3QswpDIWBTPOj1HN2ZzBqbEjDfYGJB2bM1ZEHweMQTyjoS8PiJzAycSVdmLDoyToF6whVmnTgV8TQiZQpChve3mHx9r5yVuEd2WyrURxsO5DcRsBYE+k6dm69r81aIV+VlXzn6vbc8zgEYuS0CqPrA4QwGq5vK8CyciXuaW1O5v2e9OwvSyPnWllWMcWUzlzwfebA2JjAZqzI/r8TXBFeOm3UpZ4fCO+uFgYS66O9klRcM8HZ4IasutpnLWk32HsqkZW06rfIHf3Bf7c3hsvVt0mrd6dopv+FmLxVYosr0HferKT4SUe1NazCow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSqqX4pGlHpKnwA5X19FygiSST7jqEKbKwrHR8rjx04=;
 b=LNa3CWNS9TvChp+EaBK/sAsbZifIH3J8UDe1amVl+F+ERiiBc37ptohcxZ8HOeoZUCKWJT8kZxZojp10zslSjI3qA4OCwph9NQSvDVYuY4qHtzUDFuVkbivZsbnkXVTa3+X9L/YyY3/0n6IVPw0DYQ+DgtHbaGfrE/05QX9T6VQ=
Received: from MW3PR11MB4748.namprd11.prod.outlook.com (2603:10b6:303:2e::9)
 by MWHPR11MB1390.namprd11.prod.outlook.com (2603:10b6:300:22::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.24; Wed, 28 Oct
 2020 21:26:37 +0000
Received: from MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::60e3:2ee5:c71c:fc57]) by MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::60e3:2ee5:c71c:fc57%8]) with mapi id 15.20.3477.029; Wed, 28 Oct 2020
 21:26:37 +0000
From:   "An, Tedd" <tedd.an@intel.com>
To:     "david.zakarias@gmail.com" <david.zakarias@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: btusb: Add support for 0cb5:c547 Realtek
 8822CE device
Thread-Topic: [PATCH] Bluetooth: btusb: Add support for 0cb5:c547 Realtek
 8822CE device
Thread-Index: AQHWrKM2ILAjKf0XiEqJ6oPfMbY4y6mtiMEA
Date:   Wed, 28 Oct 2020 21:26:37 +0000
Message-ID: <d492a9ad6467d881a7ff325d4210707194f534ca.camel@intel.com>
References: <CAC_SeizxoD1PkNHWYg1FcV9x6tote2JyJNX3Kwu3XtHkCF+FPQ@mail.gmail.com>
In-Reply-To: <CAC_SeizxoD1PkNHWYg1FcV9x6tote2JyJNX3Kwu3XtHkCF+FPQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.54.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef529239-1569-4b80-2d83-08d87b882732
x-ms-traffictypediagnostic: MWHPR11MB1390:
x-microsoft-antispam-prvs: <MWHPR11MB1390CE3B4573819AC9CE7C58FF170@MWHPR11MB1390.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:785;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3D8YoCr4wvcoeg5eJVij7mCe3jJbfKBXZzXi/DD+ghaBzPnbQnlrQqe/7OZtehmNLr8Ua10tS5/UVTP5Bz9VS5qx7CH88LVjK26Ikz8skZ/p7VYNp978AwTqb1XNBxcFhaW4WgLWOM+MtyjYvLW1T3zBChg1DYzdkAJ2g2Bo9frXaTLczuoW2AO9v4+NJ4nN2cJTW9848aEvKh12X0b451e5yv1W9aTCqG3ubgKbxdjLZlglTP/zQzAslAOcUYdKJmSDQuewtyxPyLqTrHFtvDerkR+DgGwukxKMByXU2cgYB9Pzcno7GuNQLCb5r0f0Q7+pv+Ug2Uc/K0hKYp4WgbtAgneg6Urs8N7t78ZzucP3UTqBMUgkmXVGyPG+MZDiybY3x5SdYh35+LrX1Eyw28hqlDu1i758aaADNsS5bL7UmEGWxcRTjX4/bFXtg3IAnMw/RCZ+TuDbIjAaR+1/KA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4748.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(6486002)(4326008)(2616005)(83380400001)(316002)(71200400001)(966005)(478600001)(5660300002)(6512007)(36756003)(66946007)(86362001)(66476007)(4001150100001)(66556008)(66446008)(2906002)(64756008)(91956017)(76116006)(6506007)(26005)(186003)(8676002)(6916009)(8936002)(6606295002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 1GgNR+aHf8B/JtPtBflKQMA93zNAX159GVQ+xRbT25Kgx3Qu9V45on6A1r2WBaeCbloZXpjfgWQ3Banhm/ZPmaOiLGRXydYYCjjHu14YCx3kUshY9kibHWSCua/gBcJr+5+MYiiIAn8RaFgeZ2cV+az6wryirjNWodhWQVIMdfPcfKsH/28Z8Vl5Vucd5K2UmehMPZeSLGiDAG/Y0evdBicA8Rtwvc0Vhd0TpIrJNELDH0mOXmZ5lsjxlTmI2z7psKdCVY/LYfjt+Y0X8OePm347WXuEC3NyHhlm2GXhvIvdmTb4ZapmfDwJjLq8ROCTX8qymMmmXFey6qBxjWe7hTjd+EDoVMmoAU9J15x6fPiH1hx0fWdyRdnTG8FLiD30OmTAcJRzN4jB4eC1u1cdRhMZ2PQmlZVIfmYF+olGGZGBGgo1z1Qzod8dSjkwCY5EUBfnVnn+Tk4F3kgDwIv6L+WJzcnidTEs+CpdVaHG4oiEnBqxAuRXQYOISlyrTIlZHWSUqq7dNZ1xB40mjEhrhy+z6YHx48wk+Wwwwb/2yEOlYMOMbSMvY+vpbh7TOM6lg8118czzQU7U14iZ9VnpZ7MqTX9QZ/kulSKFU/YPJlsbXTVANTQVELrQv8fcWMeqGvoQG5bKXiRxv+VVCsKzIA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF763EFB1C309A4EA6F2913B8769DFEB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4748.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef529239-1569-4b80-2d83-08d87b882732
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 21:26:37.4820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +7XtcpCTWLsvO+VlNCkaFkKH8Zof3Z9RZHV7RyBaVUPdgmecG7y29LnQMebhupbuVqvBtxnr+ODT/IMS80821g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1390
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgRGF2aWQNCg0KT24gVHVlLCAyMDIwLTEwLTI3IGF0IDIxOjUyICswMTAwLCBEYXZpZCBaYWth
cmlhcyB3cm90ZToNCj4gTXkgUmVkbWlib29rIDE2IEFNRCBsYXB0b3AgY29udGFpbnMgdGhlIFJU
TDg4MjJDRSBjaGlwIGhhdmluZyB0aGUgVVNCDQo+IGlkZW50aWZpZXIgMGNiNTpjNTQ3LiBUaGlz
IHBhdGNoIGFkZHMgdGhpcyBJZCB0byBidHVzYi5jJ3MgYmxhY2tsaXN0DQo+IHRhYmxlLCBlbmFi
bGluZyB0aGUgbG9hZGluZyBvZiB0aGUgUmVhbHRlayBmaXJtd2FyZS4NCj4gVGhpcywgdG9nZXRo
ZXIgd2l0aCBhbm90aGVyIHBhdGNoIGJ5IEVkd2FyZCBWZWFyIChoY2lfY29yZTogRml4DQo+IGF0
dGVtcHRpbmcgdG8gc2V0IFJQQSB0aW1lb3V0IHdoZW4gdW5zdXBwb3J0ZWQsIHNlZQ0KPiBodHRw
czovL21hcmMuaW5mby8/bD1saW51eC1ibHVldG9vdGgmbT0xNjAzNzgyMjI2MzIzNjYmdz0yKSBt
YWtlcyBteQ0KPiBibHVldG9vdGggbW91c2Ugd29yay4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERh
dmlkIFpha2FyaWFzIDxkYXZpZC56YWthcmlhc0BnbWFpbC5jb20+DQo+IC0tLQ0KPiAtLS0gYmx1
ZXRvb3RoL2RyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmMub3JpZyAyMDIwLTEwLTI3IDIxOjI0OjUx
LjMzMTAzNTk3NA0KPiArMDEwMA0KPiArKysgYmx1ZXRvb3RoL2RyaXZlcnMvYmx1ZXRvb3RoL2J0
dXNiLmMgMjAyMC0xMC0yNyAyMToyMTo0Ni4wMDAwMDAwMDAgKzAxMDANCj4gQEAgLTM4Niw2ICsz
ODYsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHVzYl9kZXZpY2VfaWQgYmxhY2tsDQo+IA0KPiAg
IC8qIEFkZGl0aW9uYWwgUmVhbHRlayA4ODIyQ0UgQmx1ZXRvb3RoIGRldmljZXMgKi8NCj4gICB7
IFVTQl9ERVZJQ0UoMHgwNGNhLCAweDQwMDUpLCAuZHJpdmVyX2luZm8gPSBCVFVTQl9SRUFMVEVL
IH0sDQo+ICsgeyBVU0JfREVWSUNFKDB4MGNiNSwgMHhjNTQ3KSwgLmRyaXZlcl9pbmZvID0gQlRV
U0JfUkVBTFRFSyB9LA0KPiANCj4gICAvKiBTaWxpY29uIFdhdmUgYmFzZWQgZGV2aWNlcyAqLw0K
PiAgIHsgVVNCX0RFVklDRSgweDBjMTAsIDB4MDAwMCksIC5kcml2ZXJfaW5mbyA9IEJUVVNCX1NX
QVZFIH0sDQoNClBsZWFzZSBpbmNsdWRlIHRoZSBjb250ZW50IG9mIC9zeXMva2VybmVsL2RlYnVn
L3VzYi9kZXZpY2VzIGZvciB0aGlzIGRldmljZSBpbg0KdGhlIGNvbW1pdCBtZXNzYWdlLg0KDQpS
ZWdhcmRzLA0KDQpUZWRkIEhvLUplb25nIEFuDQo=
