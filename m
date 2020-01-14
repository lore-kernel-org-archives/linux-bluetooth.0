Return-Path: <SRS0=HCMd=3D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D8CC33CB1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 14:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76F32467D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 14:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="o0KIjkHp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgANOj1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jan 2020 09:39:27 -0500
Received: from mga07.intel.com ([134.134.136.100]:50918 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgANOj1 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jan 2020 09:39:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 06:39:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,433,1571727600"; 
   d="scan'208";a="305162209"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga001.jf.intel.com with ESMTP; 14 Jan 2020 06:39:26 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Jan 2020 06:39:26 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 14 Jan 2020 06:39:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ekzla3TaoOrR286OtfqEHYBXq4H45pnIxbJG/T3x88xdTzggoRVRK6VQhpUrzeP5igGPIgkJNBGAlKJcDfAYnQpXC8VTIfZg5YuUSYs42hjwArtbg3Zq8Xl/32eXiIxENtAjCqBjOI2EtauPtMZ3IQvJhPcvPEdDeoQ+yyJml0nOipHgrcmdBtnaTF95MgpxddISZk7fEnrLbxzxEh45IyrKV0IQhS1ylsfbqFffv6Eo9Npfn+KwqTzwF00olTr/oM5f3RSJdQK9Sk5X8jgxPEejiXOqIHOK/DVNlyUslhA08rApwRjsO80WafMWQi7Upbs7Ro5tNYUDeH7To0MkSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uA4iNRIkCZZlF3DehtlSmXuEcYNRcokCkM6HKP4I960=;
 b=Fj9F7QWMdQwy9NIPbGwRl2lXLl8F2FgGEa2bOu6s3pufSQiZVpF5ZY88EjkuuhIyMixqFjO+Lm54UrXkCsQnvUWdTsXQhxlvpGlRcXViTQNAG3xLNZ0mBuAVkuuosB8vSEc3vWm70AyF1fM7KId2ZALLWdp5ODsUo5yK5UlW9NVOD1pFc0NVHEg/nxtK99JBAqW/In4c0tWVXfjpJYc6Flv6wzMFWNy42fcTNXsuzj7S85aVcNpHKk2hfBEHeYpfuR5gE2B8eXVlDf0ckEO02REDTUVFMR00AjzQmL9gm4NkooSYeP9APgb6IIF5tKEv/zTOnydsRv/Ps0/0dKDqLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uA4iNRIkCZZlF3DehtlSmXuEcYNRcokCkM6HKP4I960=;
 b=o0KIjkHpagcbdaI9fthYGAUZBZOyXlS9koaUsnWPTa2QpZUTw/wWyT6U7PR7JTENyHD/w7kqQjsGLzEWyosRFhqMgclEkoo7ruzl6lGGMBO/uN5TY/L2QCzi9LhFL1c2iQ9u18JaStbhuugWY4+8srxWwv5DYcqiPshqk7L/3CQ=
Received: from MWHPR11MB1664.namprd11.prod.outlook.com (10.172.54.13) by
 MWHPR11MB1805.namprd11.prod.outlook.com (10.175.56.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Tue, 14 Jan 2020 14:39:23 +0000
Received: from MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e]) by MWHPR11MB1664.namprd11.prod.outlook.com
 ([fe80::e8fb:c0e8:5779:367e%6]) with mapi id 15.20.2623.017; Tue, 14 Jan 2020
 14:39:23 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: Allow apps to receive DevKey messages from
 external nodes
Thread-Topic: [PATCH BlueZ] mesh: Allow apps to receive DevKey messages from
 external nodes
Thread-Index: AQHVxtg6PxAg3u8sUkueGZNbetoSeKfqQyKA
Date:   Tue, 14 Jan 2020 14:39:23 +0000
Message-ID: <d844a0671b5e574bfaffacc44c5ee4f600812bdf.camel@intel.com>
References: <20200109103222.31139-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20200109103222.31139-1-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4731a1cb-e803-4acf-a18c-08d798ff8c9d
x-ms-traffictypediagnostic: MWHPR11MB1805:
x-microsoft-antispam-prvs: <MWHPR11MB18051A8A62A1A05CB2E7366CE1340@MWHPR11MB1805.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(346002)(366004)(376002)(189003)(199004)(6506007)(478600001)(6486002)(36756003)(91956017)(66476007)(8936002)(15650500001)(81156014)(8676002)(76116006)(81166006)(71200400001)(2616005)(6512007)(66946007)(110136005)(2906002)(66556008)(5660300002)(64756008)(66446008)(86362001)(186003)(316002)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR11MB1805;H:MWHPR11MB1664.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +CkDQFMJg0JoFrMrqORElYYtkwJvJ/Tjs2aSHJLG97irWK7rwbxdk9Xb9rx1rM/ld6TtywJhLGUyaus+UNsG7djAtJTTGsgK/E856XKR0D79gZ4WLm38K7EfboGg9nw0Az14fWburQwwZEbFd+2zVNmF5eei9zAF1BbP5XwfZ+x5LSwW5wS9BNfQfFxwgZyVWgaKvxHvkpJmWu66ew90+x9Orr1VNho3hYdoH0iaRXKIAYu8zkSIKAi2Pm400BNysX/TWEgGAk5FlOSarGJUbYegp58YZSYCnoSAhS8JL0dsf423y3s7eUsTVrZjkOCGRzYrHfyRX+OAuOVaJy6c+ku2f8GzgifH6e5bvFOcN7ZuSETveG/uWSFPKZqCVcmVeSa4WzsEbgKYnjgUt6cQ0kvNHKpEZG/ihfIDmR0Qq/xi4Slz5M3nZL3hU2IeOGek
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0611AA4CF965BD40984134D2F6EB2411@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4731a1cb-e803-4acf-a18c-08d798ff8c9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 14:39:23.9087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6QT8kHF2O6i0/0dkVQ6P60Y+WTLLDoB8S0H/iULvwc9o8mz6wZRaeGP1bN1jjdQVoYXhjq0u/k24mx7ARWJuCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1805
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gVGh1LCAyMDIwLTAxLTA5IGF0IDExOjMyICswMTAwLCBNaWNoYcWCIExvd2Fz
LVJ6ZWNob25layB3cm90ZToNCj4gQWZ0ZXIgaW50cm9kdWNpbmcgInJlbW90ZSIgZmxhZyBmb3Ig
RGV2S2V5TWVzc2FnZVJlY2VpdmVkIGluDQo+IGM4Y2Q1YjA0Y2NkODY1ZGVlYjkwYjcwZWE2NDlj
MGI2Y2MwMzg1ZTYsIHdlIGNhbiBub3cgYWxsb3cgYXBwbGljYXRpb25zDQo+IHRvIHJlY2VpdmVk
IERldktleSBtZXNzYWdlcyBmcm9tIGV4dGVybmFsIGFkZHJlc3NlcyBhcyB3ZWxsIGFzIGZyb20N
Cj4gbG9jYWwgb25lcy4NCj4gDQo+IFRoaXMgZW5hYmxlcyBhcHBsaWNhdGlvbnMgdG8gcHJvcGVy
bHkgaW1wbGVtZW50IG1vZGVscyB1c2luZyBEZXZLZXkNCj4gc2VjdXJpdHksIGJ5IGFjY2VwdGlu
ZyBvbmx5IHJlcXVlc3RzIHdpdGggInJlbW90ZSIgZmxhZyBzZXQgdG8gZmFsc2UuDQo+IC0tLQ0K
PiAgbWVzaC9tb2RlbC5jIHwgMyArLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9tZXNoL21vZGVsLmMgYi9tZXNo
L21vZGVsLmMNCj4gaW5kZXggYWNkZDk0ZjdiLi42ZDc2NzRlZTUgMTAwNjQ0DQo+IC0tLSBhL21l
c2gvbW9kZWwuYw0KPiArKysgYi9tZXNoL21vZGVsLmMNCj4gQEAgLTEwNjYsOCArMTA2Niw3IEBA
IGJvb2wgbWVzaF9tb2RlbF9yeChzdHJ1Y3QgbWVzaF9ub2RlICpub2RlLCBib29sIHN6bWljdCwg
dWludDMyX3Qgc2VxMCwNCj4gIAkJCQkJCWZvcndhcmQuYXBwX2lkeCwgZm9yd2FyZC5zaXplLA0K
PiAgCQkJCQkJZm9yd2FyZC5kYXRhKTsNCj4gIAkJCWVsc2UgaWYgKGRlY3J5cHRfaWR4ID09IEFQ
UF9JRFhfREVWX1JFTU9URSB8fA0KPiAtCQkJCShkZWNyeXB0X2lkeCA9PSBBUFBfSURYX0RFVl9M
T0NBTCAmJg0KPiAtCQkJCSBtZXNoX25ldF9pc19sb2NhbF9hZGRyZXNzKG5ldCwgc3JjLCAxKSkp
DQo+ICsJCQkJIGRlY3J5cHRfaWR4ID09IEFQUF9JRFhfREVWX0xPQ0FMKQ0KPiAgCQkJCXNlbmRf
ZGV2X2tleV9tc2dfcmN2ZChub2RlLCBpLCBzcmMsIGRlY3J5cHRfaWR4LA0KPiAgCQkJCQkJMCwg
Zm9yd2FyZC5zaXplLCBmb3J3YXJkLmRhdGEpOw0KPiAgCQl9DQo=
