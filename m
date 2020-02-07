Return-Path: <SRS0=kXS7=33=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B85C35250
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Feb 2020 17:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9EC321741
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Feb 2020 17:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="A24Awrn2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgBGRWY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Feb 2020 12:22:24 -0500
Received: from mga07.intel.com ([134.134.136.100]:33933 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbgBGRWY (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Feb 2020 12:22:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 09:22:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,414,1574150400"; 
   d="scan'208";a="225602821"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga007.fm.intel.com with ESMTP; 07 Feb 2020 09:22:22 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 7 Feb 2020 09:22:22 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 7 Feb 2020 09:22:22 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 7 Feb 2020 09:22:22 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 7 Feb 2020 09:22:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bq4cZiVzD66vlnOAKs7L09j73wuTNwfEVldf7fsaRJ+dtwBcO+/L3V8BjIASGsd/htuo9JUS78c9QdcAt0lkkaJhxTsT8rV9b5NC4UvqxvWVrwudXxUbfxBuXlTusrE+ag4hf8YwbXHrVy7KmatMYfPUFwCk9YeGifkWR9jC2pTty90NIkV5l8Xc4OcWg7CI2Kaf+KAVNanHLigKA2jd1HztPv4LSGpiN9UfQLbeJkpAbDg+slc6A7qGtUm6IYX2hLLcjS0F/0LGacX9BHiRz55lErubXxyPUZfDfxXvTIFTxK/UTzW1XOukms/b7YJzYZy7zdnYT7QasomUhnVKeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoJrWqSudindyx02Ih9wEUzqAX5vJPpG0HyD3VScVkQ=;
 b=no8loAfpjCwAskVba6mX2artxeG8PArkk7sqAdm8QxEL/bXBGuBs3t2B+lWFTkWuwYqJUnsUjYJekhJTqJvYQQWK26PT8/eYI+gQHisP9aEvCw4dxMUAkbA0WuR4J+JmLjEqgpttk05M6p1jNCmT3T35DxoWh8terVfKD+lLzzP4eHkDmkf+SfHHsaDYmSyfDLCBBlHQ6UQwGuSg28QvKgvlnjNhAfuOtwLoKKhCblb/yqDUtv8ladVGB3meUcOmAQj+ICbi58tCdDP9GO2QThuZSZ+ITexyS/8Yge1xeKFThzXPo7rjXKO5v//hxxwX6hO7RbtYgMUQawOocGNvyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoJrWqSudindyx02Ih9wEUzqAX5vJPpG0HyD3VScVkQ=;
 b=A24Awrn2s2pK2xyN2UWS7jFdVLVBNyDObiCOBKWJVz8/nB6Ka3CWrffy9we6xHzMb9WSgJth81nyhZ7SE8MCqPxo5se0SGjm2TmCHC/7WUHcZYJxj9wMudTD35XnlfSHiFz+M7fJxLIQ7c8z2Hd1FVK1PVvG/HInUDuEoPbcqPc=
Received: from BN7PR11MB2580.namprd11.prod.outlook.com (52.135.246.155) by
 BN7PR11MB2786.namprd11.prod.outlook.com (52.135.245.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Fri, 7 Feb 2020 17:22:19 +0000
Received: from BN7PR11MB2580.namprd11.prod.outlook.com
 ([fe80::c8ca:3c11:3fc5:a9d6]) by BN7PR11MB2580.namprd11.prod.outlook.com
 ([fe80::c8ca:3c11:3fc5:a9d6%6]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 17:22:19 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Allow to finish key refresh when no AppKeys
 are stored
Thread-Topic: [PATCH BlueZ] mesh: Allow to finish key refresh when no AppKeys
 are stored
Thread-Index: AQHV3HdDEfDnUjNWE0uD/GZlmZ9m0KgP/V0A
Date:   Fri, 7 Feb 2020 17:22:19 +0000
Message-ID: <e250cb802a320e0d73fcc6599f4c9c359c54a630.camel@intel.com>
References: <20200205225343.6271-1-inga.stotland@intel.com>
In-Reply-To: <20200205225343.6271-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc7e279d-1575-4757-bcc4-08d7abf2495e
x-ms-traffictypediagnostic: BN7PR11MB2786:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR11MB27864B9F7FA59278824D4F63E11C0@BN7PR11MB2786.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 0306EE2ED4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(346002)(366004)(39860400002)(199004)(189003)(91956017)(76116006)(66946007)(2616005)(478600001)(86362001)(6512007)(8936002)(66556008)(66476007)(66446008)(8676002)(6636002)(5660300002)(64756008)(2906002)(71200400001)(316002)(6486002)(81166006)(186003)(81156014)(110136005)(26005)(36756003)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR11MB2786;H:BN7PR11MB2580.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7RgIRxM3WBVnBIpIIEIXZnQb1KQgdKQjgHlrhvFdxVH/knJOtDp9PNQL0mLn2bKzPXgC8nCaUMukvwOHOzDJtDPec29q6/bNyNtkQ5RLKuoVp2NIz/tknS/8fRTkRKSz4NQVaGsOjf95Dw3Tgd8QEJvXfp9j8Y/6zyfTZ9C5uOxVR4HXZfWRS7jxYKh57VQnXZOZr2d90izQnXeUxyL2xrkeT0WdYrGBIC+a73cN5szm6Ulr30OK/QNn0O9+aVO7oDv5rFw6yM8tomv+M2Zdyqrb9k5wT/lMTC1ZrMgiHaysRazUXXFFWRxfbeRHTpwgmv/flC7+ck+Cqu+Ph8b12Yal41exD+y0E3oNYuDWCt6xaOz1QulVBX5XPxbxKH/dgA8gLXYA9N2Tenr/+cORyoGCvGXXk3rp19uURS4D1dlfjJwOsX0lL6zZsYD4XVtT
x-ms-exchange-antispam-messagedata: qtAlzib6BhdCIjVKFuymo1f09hzaiTa62tWwLi/Kcmx+CcSkS+4DsShXP8vKBwOIWw1gO1b16mjyVyfcMsMINKKHJuVeTtPmJCwAhgWTqSXF84B1/Do5e8rsxFubQPDvfOX3UlEMka7h62wxOrDVEw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B1891E3CB282640A4A4081A1759BEC3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bc7e279d-1575-4757-bcc4-08d7abf2495e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2020 17:22:19.4956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9a7SqE1a98E18S4ow6zGBeNgOc1hoYSV+j33EssSnGDIGkl0kZxJs03AAOd4tzeRf6KEp9DgIuj5K94XP/hg8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2786
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gV2VkLCAyMDIwLTAyLTA1IGF0IDE0OjUzIC0wODAwLCBJbmdhIFN0b3RsYW5k
IHdyb3RlOg0KPiBUaGlzIGhhbmRsZXMgYSBjYXNlIHdoZW4gYSBLZXkgUmVmcmVzaCBwcm9jZWR1
cmUgaXMgaW4gcGxhY2Ugd2l0aA0KPiBubyBhcHBsaWNhdGlvbiBrZXlzIHN0b3JlZCBpbiB0aGUg
a2V5cmluZy4gV2hlbiBLUiBwcm9jZWR1cmUgaXMNCj4gZmluYWxpemVkLCB0aGUgY2hlY2sgZm9y
IHRoZSBwcmVzZW5jZSBvZiBBcHBLZXlzIHN0b3JhZ2UgZGlyZWN0b3J5DQo+IGRvZXMgbm90IHJl
dHVybiBmYWlsdXJlIGlmIHRoZSBkaXJlY3RvcnkgZG9lcyBub3QgZXhpc3QuDQo+IA0KPiBBbHNv
LCByZW1vdmUgZHVwbGljYXRlIGluY2x1ZGUuDQo+IC0tLQ0KPiAgbWVzaC9rZXlyaW5nLmMgfCA3
ICsrKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9rZXlyaW5nLmMgYi9tZXNoL2tleXJpbmcuYw0K
PiBpbmRleCA0MWNiMmU5ODAuLjRhNmY5ZjI3ZCAxMDA2NDQNCj4gLS0tIGEvbWVzaC9rZXlyaW5n
LmMNCj4gKysrIGIvbWVzaC9rZXlyaW5nLmMNCj4gQEAgLTI0LDEwICsyNCwxMCBAQA0KPiAgI2Rl
ZmluZSBfR05VX1NPVVJDRQ0KPiAgI2luY2x1ZGUgPGZjbnRsLmg+DQo+ICAjaW5jbHVkZSA8ZGly
ZW50Lmg+DQo+ICsjaW5jbHVkZSA8ZXJybm8uaD4NCj4gICNpbmNsdWRlIDxsaW1pdHMuaD4NCj4g
ICNpbmNsdWRlIDxzdGRpby5oPg0KPiAgI2luY2x1ZGUgPHVuaXN0ZC5oPg0KPiAtI2luY2x1ZGUg
PGRpcmVudC5oPg0KPiAgDQo+ICAjaW5jbHVkZSA8c3lzL3N0YXQuaD4NCj4gIA0KPiBAQCAtMTY2
LDcgKzE2NiwxMCBAQCBib29sIGtleXJpbmdfZmluYWxpemVfYXBwX2tleXMoc3RydWN0IG1lc2hf
bm9kZSAqbm9kZSwgdWludDE2X3QgbmV0X2lkeCkNCj4gIAlzbnByaW50ZihrZXlfZGlyLCBQQVRI
X01BWCwgIiVzJXMiLCBub2RlX3BhdGgsIGFwcF9rZXlfZGlyKTsNCj4gIAlkaXIgPSBvcGVuZGly
KGtleV9kaXIpOw0KPiAgCWlmICghZGlyKSB7DQo+IC0JCWxfZXJyb3IoIkZhaWxlZCB0byBBcHAg
S2V5IHN0b3JhZ2UgZGlyZWN0b3J5OiAlcyIsIGtleV9kaXIpOw0KPiArCQlpZiAoZXJybm8gPT0g
RU5PRU5UKQ0KPiArCQkJcmV0dXJuIHRydWU7DQo+ICsNCj4gKwkJbF9lcnJvcigiRmFpbGVkIHRv
IG9wZW4gQXBwS2V5IHN0b3JhZ2UgZGlyZWN0b3J5OiAlcyIsIGtleV9kaXIpOw0KPiAgCQlyZXR1
cm4gZmFsc2U7DQo+ICAJfQ0KPiAgDQo=
