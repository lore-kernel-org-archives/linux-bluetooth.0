Return-Path: <SRS0=34D5=X2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FE8C352AA
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Oct 2019 18:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F5D8215EA
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Oct 2019 18:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="YhVexwrj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbfJASHY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Oct 2019 14:07:24 -0400
Received: from mga05.intel.com ([192.55.52.43]:51453 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727850AbfJASHX (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Oct 2019 14:07:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 11:07:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="205120029"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga001.fm.intel.com with ESMTP; 01 Oct 2019 11:07:23 -0700
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 1 Oct 2019 11:07:23 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX114.amr.corp.intel.com (10.18.116.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 1 Oct 2019 11:07:22 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.59) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 1 Oct 2019 11:07:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhhBWEJsC95haH3W21SojQwVtj/CiaHtRt7TZeroJm8Moy3pMl+/j5cjIB4cHQ/XtqUYPXu/JJSKqz+2i53IWPOPSsGEO54B7Vq9+Ki+ZO9H13s8MyrltOwzOmqV0FFZlJEJSgU221A0WqrKteq6l0/RTFvoUQNQIXve7GGxAWv4aHMlj8HwIFG5AHdZhnAkqZOB2et3w/gy1qyR3L/WkB5Rhi5oxQ++3AQunYRLjJxMAWk8MXXONsl8AVJ95mLQ+j1RYf/1eS56k6Q5toXEF2EoxpMG4F2IHEHf3+2g63RmKMpsmJaIyPb0q4Ym9BMPkxyBG/vsaaz9kuqRQhr41w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8Rb39+mQVLms6vrk1q1b99mUSVGCnyQwD3PzAV8LiE=;
 b=m3jVAiKRYcZxUrwoiidxHKDh6x/eXVSE+q8Nr3anC7SZTYKBl3fw3jA/SwlVbpQoQJKOwtxnqQLVQeH7+KT1bIMLJaDQ+b/iEIg+kjiXhdKt4sLyLDdUGpgZ+CzdNc0K+jjdlw9LuG7o0iXnoSW+szuB0d6OJeD68ojNRoxUvkAp7Xme4ieSCxxebffd8uweUBS56dQh+nJDt3yi0tJbgtF0S8qQkIa9QZ19c1wb6svNrrTdVL1nwx02KG1sUiIvSCRzOQK78Z+2d8RjjDlW6C93bF6cbLGH25P3kWklIbTQo1MVwl/vBilQ5dU3gsay+ZtwKWiNzlBig4g5cE6CLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8Rb39+mQVLms6vrk1q1b99mUSVGCnyQwD3PzAV8LiE=;
 b=YhVexwrjCucJjKdzBI5Xems82sIuWOJ6WaDGb7A4G3h/8pm7jF2Vdp0/mSONSJEgeISZz3rjIpqsMvXcPylO6EJ1/MyxHb1ubb24CJO2y3BRkLYm8UkeJTy+E95lZrf916gbgpUbNTZF/pSFljBRLn+J2idPE5V4hpFzqrMHohM=
Received: from DM6PR11MB4412.namprd11.prod.outlook.com (52.132.248.86) by
 DM6PR11MB3145.namprd11.prod.outlook.com (20.177.219.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Tue, 1 Oct 2019 18:07:17 +0000
Received: from DM6PR11MB4412.namprd11.prod.outlook.com
 ([fe80::5d45:636:6a4a:9397]) by DM6PR11MB4412.namprd11.prod.outlook.com
 ([fe80::5d45:636:6a4a:9397%7]) with mapi id 15.20.2305.022; Tue, 1 Oct 2019
 18:07:17 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v3 0/3] mesh: Fix Remote/Local dev key usage
Thread-Topic: [PATCH BlueZ v3 0/3] mesh: Fix Remote/Local dev key usage
Thread-Index: AQHVdJZYV2YKIXwDYk6jDaeKD4gafKdGHPAA
Date:   Tue, 1 Oct 2019 18:07:17 +0000
Message-ID: <9ec407c5e97832e514fcabac0d50138f7477f8c1.camel@intel.com>
References: <20190926181444.4916-1-brian.gix@intel.com>
In-Reply-To: <20190926181444.4916-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64a14234-29d7-4faa-d8c4-08d7469a3222
x-ms-traffictypediagnostic: DM6PR11MB3145:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3145DB686C695BFBE7B7DEB1E19D0@DM6PR11MB3145.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 0177904E6B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(136003)(39860400002)(346002)(366004)(199004)(189003)(71200400001)(305945005)(91956017)(14444005)(7736002)(36756003)(316002)(11346002)(446003)(76116006)(486006)(476003)(2501003)(256004)(66446008)(66556008)(66476007)(64756008)(66946007)(71190400001)(2351001)(118296001)(6486002)(6116002)(66066001)(3846002)(25786009)(6512007)(229853002)(2906002)(86362001)(102836004)(5640700003)(8676002)(8936002)(5660300002)(14454004)(81156014)(81166006)(6436002)(2616005)(99286004)(76176011)(107886003)(4326008)(6916009)(186003)(6506007)(54906003)(26005)(478600001)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR11MB3145;H:DM6PR11MB4412.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vptkRikvQIz5opFawac8USoPNTZe2ojGMlY73iSLogTwUc8sNbjmCL67DBkrk7WnOTUsufme74BHMonjwTxt7gRB/4a4gj2doHTljbbMsY+KHMYAIRDu9goFdg35k8+ZMsUdZ51wwh++vQmznd/YZtTmlIlx/jXGyPnBd8bb/i0gSred8ySWc9fxKEHuRFB5Kdi2Iey9lU5TL6ftWhyztp+yzQH5tegvoe9ZPtJFuEZqnk9B2uWt3Mmze+L5gl8BGaBgoyhHNvmj2CMhZG+I7zaajdMqQTuAfRgKU8FbFYGZjHrE9eDZvmIrMyrptGmLeqRoS15Aqd3J3N2+LK6YRaQmd4H2b1i2bDya0/ykNJYRvLEkbcbiYsi6RIDkVXlJ8uo3sJZTTQh1CIdeXqu4aQ4ne/kABWbdONI0xMyj+ls=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8BE0B3378A6DCC4A8E488062530D2D36@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a14234-29d7-4faa-d8c4-08d7469a3222
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2019 18:07:17.3078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eM8FLb+c3HxySAf0/20xJiNo3qsyNy49lnJyQ8ZmYZEKSEvGLxC1sZyQgAsADyugBOYNphmRL+HvRdhFfdzrDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3145
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCBwYXRjaCBzZXQgd2l0aCBjb21taXQgbWVzc2FnZSBjaGFuZ2VzDQoNCk9uIFRodSwg
MjAxOS0wOS0yNiBhdCAxMToxNCAtMDcwMCwgQnJpYW4gR2l4IHdyb3RlOg0KPiBWMzogIEJ5IHBv
cHVsYXIgZGVtYW5kLCB0aGUgbmFtZSAicmVtb3RlIiBpcyBub3cgdXNlZCBmb3IgYm90aCBEZXZL
ZXlTZW5kKCkNCj4gYW5kIERldktleU1lc3NhZ2VSZWNlaXZlZCgpLg0KPiANCj4gSW4gRGV2S2V5
U2VuZCgpLCBzZXR0aW5nIHJlbW90ZSA9PSB0cnVlIG1lYW5zIHRoYXQgdGhlIEtleSBSaW5nICpt
dXN0KiBiZQ0KPiB1c2VkIHRvIGVuY3J5cHQgdGhlIG91dGdvaW5nIG1lc3NhZ2UsIGFuZCBhIGZh
aWx1cmUgd2lsbCBiZSByZXR1cm5lZCBpZg0KPiB0aGUgcmVxdWVzdGVkIGRlc3RpbmF0aW9uIGFk
ZHJlc3MgZG9lcyBub3QgaW5jbHVkZSBhIGRldmljZSBrZXkgaW4gdGhlDQo+IGxvY2FsIGtleSBy
aW5nLiBGb3IgcmVtb3RlID09IGZhbHNlIHJlcXVlc3RzLCB0aGUgcmVxdWVzdCB3aWxsIGJlIHJl
amVjdGVkDQo+IGlmIHRoZSBkZXN0aW5hdGlvbiBpcyBhbiBlbGVtZW50IG9uIHRoZSBsb2NhbCBu
b2RlLg0KPiANCj4gSW4gRGV2S2V5TWVzc2FnZVJlY2VpdmVkKCksIHRoZSByZW1vdGUgYm9vbGVh
biB3aWxsIGJlIHNldCA9PSB0cnVlIGlmIGl0DQo+IHJlcXVpcmVkIHRoZSBrZXkgcmluZyB0byBk
ZWNyeXBvdCB0aGUgbWVzc2FnZS4gIElmIHJlbW90ZSA9PSBmYWxzZSwgdGhpcw0KPiBtZWFucyB0
aGF0IHRoZSBsb2NhbCBub2RlcyBEZXZpY2UgS2V5IHN1Y2Nlc3NmdWxseSBkZWNyeXB0ZWQgdGhl
IG1lc3NhZ2UsDQo+IGFuZCB0aGUgbWVzc2FnZSBtYXkgYmUgdXNlZCB0byBjaGFuZ2Ugb3IgcXVl
cnkgcHJpdmlsZWdlZCBzdGF0ZXMuDQo+IA0KPiANCj4gQnJpYW4gR2l4ICgzKToNCj4gICBtZXNo
OiBBZGQgbG9jYWwvcmVtb3RlIGJvb2xzIHRvIERldktleSB0cmFuc2FjdGlvbnMNCj4gICBtZXNo
OiBVc2UgZXhwbGljaXQgTG9jYWwgdnMgUmVtb3RlIERldmljZSBrZXkgdXNhZ2UNCj4gICBtZXNo
OiBGaXggS2V5IFJpbmcgcGVybWlzc2lvbnMgZm9yIGxvY2FsIG5vZGVzDQo+IA0KPiAgZG9jL21l
c2gtYXBpLnR4dCB8IDE3ICsrKysrKysrKysrKysrLS0tDQo+ICBtZXNoL21hbmFnZXIuYyAgIHwg
IDUgLS0tLS0NCj4gIG1lc2gvbW9kZWwuYyAgICAgfCAxMSArKysrKysrLS0tLQ0KPiAgbWVzaC9u
b2RlLmMgICAgICB8IDQwICsrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
Cj4gIDQgZmlsZXMgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKSwgMzcgZGVsZXRpb25zKC0pDQo+
IA0K
