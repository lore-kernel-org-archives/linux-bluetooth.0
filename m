Return-Path: <SRS0=R8GA=23=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C499C33C8C
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Jan 2020 15:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0754E2146E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Jan 2020 15:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="xKwE3xIC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgAFPgm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Jan 2020 10:36:42 -0500
Received: from mga18.intel.com ([134.134.136.126]:18990 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbgAFPgk (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Jan 2020 10:36:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 07:36:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,403,1571727600"; 
   d="scan'208";a="232855625"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga002.jf.intel.com with ESMTP; 06 Jan 2020 07:36:39 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 6 Jan 2020 07:36:39 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 6 Jan 2020 07:36:38 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 6 Jan 2020 07:36:38 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 6 Jan 2020 07:36:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AikKJVAFWtQEIQ0Q1n8kxuv9Qf1Y4/JYOL7IUWkgPo//2C3SAuuOMPx4+8Y7Hlp7TYtiJC42rj4xAw6Nd7fcHuvK3Z8tNwnv9gsJbKBpPqMj4nR1ak3FoMIWJirkIJ5dgAxC8K8uoLOS4REl20gGDI1A8l/lGIFEk784LzeOrhE7DRz2VykKSqGgo1C7t/zQ0ssYKOIjky6wzNSvRycpkc02PKgd/gLPKkBH0zQzi3xbWsMQxANzPcRHy9fCqB/mHBgSdECzDMjnpcs2flftcenZjpmyrgtRxLCLY5VcilKkaQp5/leNKMc+uzUVkNO7m3uLK9nupbUqrbe/eU3IFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6ER8C/oci1XOrnw5wyE3pP8yqTFi10glYKrIxwl9Ck=;
 b=exi18iS3uTbuf5oWD3pnyp6Vaf+WKM6TAmVjDrVIPvyy1TLgMO2IIBC+OjUmgYh2RA4GkwJrwxrWoiO7jdKsTIuAEfqm8U/NUaibbczOa6//HpknD1ZW399MAuMWyT8j7BSrZT0R2kKLMpCGB1wsxVzab8KPZ3mpyYdTZuZCOK80Why+N+q9QIsmXCazRnkfEcDNRGOVwVqidQuHuBvfJEV5jhbI1cfjtYNd3NRUZz4YqxP8nnc78GCGOnSxqN60490ewZ7O5TOuXriV0i9GMDtbBZpxvop9eV6ztPYJnjyvaveCk6C9FaGawpWIJCuZbKbq53fsKYVnT6NvJSSueA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6ER8C/oci1XOrnw5wyE3pP8yqTFi10glYKrIxwl9Ck=;
 b=xKwE3xICNEEs79Ua4BtQWtTOvtCmHHdT5hTNfHWW0+IZs44QBsLKzidX9InccvrOJdh/vlYZeqJiNyo53v0UMAFXywOZVq/jgtQMkbg6x03Z8GEPjDPLkzteupogkErGbN9TyfQbGKhaYwx2AvvGOG2AIHZhrFFA/8GqzamYllM=
Received: from CY4PR11MB1269.namprd11.prod.outlook.com (10.173.16.11) by
 CY4PR11MB1240.namprd11.prod.outlook.com (10.169.251.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10; Mon, 6 Jan 2020 15:36:37 +0000
Received: from CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::5b2:92c7:da12:1876]) by CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::5b2:92c7:da12:1876%7]) with mapi id 15.20.2602.015; Mon, 6 Jan 2020
 15:36:37 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "biradar.a@samsung.com" <biradar.a@samsung.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/1] meshctl: Fix meshctl crash
Thread-Topic: [PATCH 1/1] meshctl: Fix meshctl crash
Thread-Index: AQHVq+u0EzuR/u9Z9EC9Cr2cUmqLaafd9k8A
Date:   Mon, 6 Jan 2020 15:36:37 +0000
Message-ID: <57a71c3b8b6367de22ea0c018602043972debcd1.camel@intel.com>
References: <CGME20191206041341epcas5p4eb1504144abc74f3f25352e63eccf0bd@epcas5p4.samsung.com>
         <1575605616-787-1-git-send-email-biradar.a@samsung.com>
In-Reply-To: <1575605616-787-1-git-send-email-biradar.a@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d958fb15-7347-42f3-3f00-08d792be37cf
x-ms-traffictypediagnostic: CY4PR11MB1240:
x-microsoft-antispam-prvs: <CY4PR11MB1240327F2772291CD76CD72EE13C0@CY4PR11MB1240.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0274272F87
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(376002)(136003)(366004)(189003)(199004)(5660300002)(110136005)(66476007)(64756008)(66446008)(4744005)(26005)(71200400001)(36756003)(6512007)(8936002)(66556008)(86362001)(316002)(478600001)(81156014)(76116006)(8676002)(6506007)(91956017)(81166006)(2616005)(6486002)(66946007)(186003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR11MB1240;H:CY4PR11MB1269.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pGcY6YK+TykzWfXhPnWTaOWCJ9sbwd4eQalstoqIBTyNDARQRg9bWb+aaNC2+kHgfVHyfag9yt6thpsNF57YqK4bx003xQ2e67b/xpEv7eOzJ6RR1pa+KydeKUJs5PZD6BuC5MNXlczULW53HR3vi3+SMXXx3VxWSjDzv/RyQFPrMnvF82aPLpFxAIuB+A+kFt9tTdc8fiN1gEovgrb5mxG6qVkFsnbbMrUrgtPUT2ys9e42kAKm3QwT/r2MPUr1bcTApbtXFfvjgUtL0HveeNwCGSFTLmrhzKr7XSMcb7NsjqNhUHQuBP5nbozIDfUBpq2g1Ni16fsCPk8EvkESOx9/+85CFOr/Z1bYDtOo5MhlV8V7RQSSQjuXbGp7Azr0WLGW1nR8j/DNNZHyaL6AZ6ujdXrIuMHTykRnwd5dMOAEnkEeBkqwtJPqKxdZ4IaK
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9884663F8DE4B4A98307788E7305D3F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d958fb15-7347-42f3-3f00-08d792be37cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 15:36:37.1586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e5s2ZcFdDK9lLIpIPdV2h+VrQ0kZGApysKZfUxN/tfvpUDzOQmMxbeqELg45Fp/QYU7yQLKVnG+1J6NBs70XKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1240
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gRnJpLCAyMDE5LTEyLTA2IGF0IDA5OjQzICswNTMwLCBBbnVyYWcgQmlyYWRh
ciB3cm90ZToNCj4gbGlzdCBlbnRyeSB3YXMgbm90IHVwZGF0ZWQgcHJvcGVybHkgZHVyaW5nIGZs
dXNoaW5nIG9mIHBhY2tldHMNCj4gDQo+IDxjYWxsIHN0YWNrPg0KPiBmbHVzaF9wa3RfbGlzdCAo
bGlzdD0weDYzOGI0MCA8bmV0KzY0PikgYXQgdG9vbHMvbWVzaC1nYXR0L25ldC5jOjExOTkNCj4g
bmV0X3Nlc3Npb25fY2xvc2UgKGRhdGFfaW49PG9wdGltaXplZCBvdXQ+KSBhdCB0b29scy9tZXNo
LWdhdHQvbmV0LmM6MTk3OQ0KPiBkaXNjb25uZWN0X2RldmljZSAoY2I9Y2JAZW50cnk9MHgwLCB1
c2VyX2RhdGE9dXNlcl9kYXRhQGVudHJ5PTB4MCkNCj4gICBhdCB0b29scy9tZXNoY3RsLmM6Nzkx
DQo+IGNtZF9zdGFydF9wcm92IChhcmdjPTxvcHRpbWl6ZWQgb3V0PiwgYXJndj0weDZhOWZiMCkN
Cj4gICBhdCB0b29scy9tZXNoY3RsLmM6MTc4OQ0KPiAtLS0NCj4gIHRvb2xzL21lc2gtZ2F0dC9u
ZXQuYyB8IDEgKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvdG9vbHMvbWVzaC1nYXR0L25ldC5jIGIvdG9vbHMvbWVzaC1nYXR0L25ldC5jDQo+
IGluZGV4IGU4MTcxYzYuLmQ3NGUxZjUgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL21lc2gtZ2F0dC9u
ZXQuYw0KPiArKysgYi90b29scy9tZXNoLWdhdHQvbmV0LmMNCj4gQEAgLTExOTcsNiArMTE5Nyw3
IEBAIHN0YXRpYyB2b2lkIGZsdXNoX3BrdF9saXN0KEdMaXN0ICoqbGlzdCkNCj4gIAkJcGt0ID0g
bC0+ZGF0YTsNCj4gIAkJKmxpc3QgPSBnX2xpc3RfcmVtb3ZlKCpsaXN0LCBwa3QpOw0KPiAgCQln
X2ZyZWUocGt0KTsNCj4gKwkJbCA9IGdfbGlzdF9maXJzdCgqbGlzdCk7DQo+ICAJfQ0KPiAgfQ0K
PiAgDQo=
