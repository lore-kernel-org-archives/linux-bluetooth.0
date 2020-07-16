Return-Path: <SRS0=Zco+=A3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5346C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 17:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7EA12070E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 17:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Ar8ry7qn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgGPRFv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jul 2020 13:05:51 -0400
Received: from mga14.intel.com ([192.55.52.115]:37240 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728126AbgGPRFu (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jul 2020 13:05:50 -0400
IronPort-SDR: 2WWCDn9PF/SEB5FP9WrUPwf6je+PdFgUHVAWTZpAi+zbomREPUwAjvBbprYv99mG6TmuryxXiz
 r9tkhwdz4paA==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="148597777"
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="148597777"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 10:05:48 -0700
IronPort-SDR: 48zOnxxEzgGsdQ843lassJFlmQFTr5RXegU/Q6g/SeEIb5qMXlHt8thlK6VMpbXBdmg6o2fQ+m
 YM4tRuBdYiIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="361097350"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 16 Jul 2020 10:05:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 16 Jul 2020 10:05:47 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 16 Jul 2020 10:05:47 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 16 Jul 2020 10:05:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLnycaWKbLqExdngUHeW6m2DtpjXUyQlSlDUHGPF1C2PAlBD99J9ASdCSFoUJQZdsA26FLq/fzs6SqNrCGOCJjq636MmxSc0SD3pvPgYH1coTdAguNkJIIZhVi25hLIwS9XWYTlgDyrVq5wWpewP+qFqKvSwhBi0HQuFBi4mLDOQzkYjrjP6L0LIWzTYBU9Va7fdqGUFNHe7qf7ThCEZhOGpAlfMDbPgStX+bmQKuPvOSKfz+0chl0YkloSFWBMMIVOzV2NlfcXf7esT3lTGuHMZSh6YYhBYC1XHyTclPO33H2e4DtP1950nOJb2dg1RCmuUP9VBd+VcqzBdh+1Djg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5S3JII4ZWVoR0JOHlew5XVRUTCfVKY+eO3XGOEP8rbo=;
 b=Sb0szeyxyO9ooX6QSjmbHZenbyXO7SenntYsCbCwGcZfHrjOfdq6Oro4I0l2alkUUWJzpEKfuTB8C9uVhFIgTuEeJAuMfgpyluPeuBCzZw4FKvKZaNl+/rIV9yfgBEkcYJ0iicS+mb/ICyfEr5bPIO2ns70Tbu4OFqXaAZMkTb+dJaBrlp57SndGoqsVXQmwdKAC1ODBIbtDZcSLZPRots4F9uEo//yIDN8rNjjMPj3Zw9Ixz1ZHRq2hLj8Y99UUq2ykwn/dTcBOcbr7l8EKyv79Zg885hzb/jdi7LURzlPTCwIDWNMxuvmxfGipKTNrLaLmYtj7QJQk/1G4sxT9rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5S3JII4ZWVoR0JOHlew5XVRUTCfVKY+eO3XGOEP8rbo=;
 b=Ar8ry7qnPfBitKbiiWphHp5/jMDrwD9RfvjUDxNNJsIq0ELWxQYtuRf/eyALu8lMGE3MLK7LvuHLnZVttaxXrKk6fvvrH+rDFlgeZYtkR5eGkt+bDd0h+Trx4J8qg9iE697FAW1SV4CWbcG3t3SX96GIIxP7UZovYSrGw/kCbZk=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4537.namprd11.prod.outlook.com (2603:10b6:303:5d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Thu, 16 Jul
 2020 17:05:43 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225%7]) with mapi id 15.20.3174.026; Thu, 16 Jul 2020
 17:05:43 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
Subject: Re: [PATCH BlueZ] mesh: Fix node composition change detection
Thread-Topic: [PATCH BlueZ] mesh: Fix node composition change detection
Thread-Index: AQHWWr1g1w50T/NzaE+SIikwN14EZKkKcS6A
Date:   Thu, 16 Jul 2020 17:05:42 +0000
Message-ID: <477c993f73e7bc81cb80bcd3d6e733d26415d68e.camel@intel.com>
References: <20200715153343.2115695-1-brian.gix@intel.com>
In-Reply-To: <20200715153343.2115695-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.137.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3af422f8-39df-4213-fb8c-08d829aa7971
x-ms-traffictypediagnostic: MW3PR11MB4537:
x-microsoft-antispam-prvs: <MW3PR11MB453780763D4BBBE9F5E1FFB6E17F0@MW3PR11MB4537.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RzJulGRUlGmCBIQMGkuLZxWYktwoSUHlIfCrxPHW8Mts9+BjBh7zF9BtWBl7d8RqX5+E7EcGvVVp/74rb8ZYVeoyMMvd5ccJcSaXsit6jrLkLbQ7317gXZAzP39yDVSybIesrgwhjUGlNnbToO5vB8PIIgun0MZBb6Nv3/e7WnU5o2ZhAyyQOgGtHNhsHGVVXoAYcMimSJ1v4ONaKRHqoYG1YtzNxJzlNtjsi7Xj3zbWZXFHvFlotgjTi+QdmqioTaNlXSKuM33inMFrHSQqeBDvpZvuBC/k9c2Jl+Zhq+j835nQKSb1uuwlr7gx5zrV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(5660300002)(6486002)(71200400001)(4744005)(4326008)(316002)(66946007)(66446008)(83380400001)(6506007)(76116006)(64756008)(66556008)(36756003)(8676002)(8936002)(186003)(66476007)(6916009)(2616005)(2906002)(478600001)(26005)(86362001)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: W0XmlAbT4cy5kV7fgn9Qo/34M6xYHzqUwajZ1z5vZLVI6ItZ9dPZOUsa4E0e/qZ8S8pRQF+LY76nAEa5xw1hO5iL6TryF5CyXsn7NCALST5uoUVGU3C8f7JayDXkSTYtfqWRdlN9AR7wdf2/53QIYhvZUM60XzA3QFWO2LEjsQDt+tHKso41fyNxqgo6eVVB7QWEmYhj/YbtRFStdxZSn7ghzl+QTvOi3/vTlltRpV96RyA1zdl88vtBA5wKYd16UiIhsCD4Uwz6wYJgACLTmO+LlPKiAoQYbgV7HE9QAtIRH+JxhPmOtDgge5r2HQXCScN5Ygs/QQTVKu6U2XOgkMuBTDT962N+AafsQInKeey0GXAgDi4JlEbKVK1PpLugjB1GUv+kaBMUaGyAXBG39SRRv70GpughLVlesxLp7w5vcYmku0R+s1iw16ixPWpdPJCFU+kYcwzzOaC4eLAkgUlsDU0fi0mP+8fX7A0EK2RtlSA4/aNtmf0rAIzTqawS
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <269E032DA356414E865BDC7EC3CD5819@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af422f8-39df-4213-fb8c-08d829aa7971
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2020 17:05:42.9765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zV+zZxJ1uILdzjJZ34HPnbSOO2qrDK01botimkSOi0fVYexix+26sN1waXH/696H/u/FiUf+Ih23EszjtsEXIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4537
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBXZWQsIDIwMjAtMDctMTUgYXQgMDg6MzMgLTA3MDAsIEJyaWFuIEdpeCB3
cm90ZToNCj4gVGhpcyBmaXhlcyBhIGJ1ZyB0aGF0IGNhdXNlZCBkaXNhbGxvd2VkIGNvbXBvc2l0
aW9uIGNoYW5nZXMgZnJvbSBiZWluZw0KPiBkZXRlY3RlZCBhbmQgcmVqZWN0ZWQuIFRoZSBvbmx5
IGZpZWxkcyB0aGF0IGFyZSBhbGxvd2VkIHRvIGZyZWVseSBjaGFuZ2UNCj4gYXJlIENJRCwgUElE
LCBWSUQgYW5kIENSUEwuDQo+IC0tLQ0KPiAgbWVzaC9ub2RlLmMgfCAyICstDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9tZXNoL25vZGUuYyBiL21lc2gvbm9kZS5jDQo+IGluZGV4IGM2MTE2N2JkYS4uOWI5N2FhOTI3
IDEwMDY0NA0KPiAtLS0gYS9tZXNoL25vZGUuYw0KPiArKysgYi9tZXNoL25vZGUuYw0KPiBAQCAt
MTU3OSw3ICsxNTc5LDcgQEAgc3RhdGljIGJvb2wgY2hlY2tfcmVxX25vZGUoc3RydWN0IG1hbmFn
ZWRfb2JqX3JlcXVlc3QgKnJlcSkNCj4gIAkJbm9kZSA9IHJlcS0+bm9kZTsNCj4gIA0KPiAgCW5v
ZGVfY29tcCA9IG5vZGVfZ2V0X2NvbXAobm9kZSwgMCwgJm5vZGVfbGVuKTsNCj4gLQlsZW4gPSBu
b2RlX2dlbmVyYXRlX2NvbXAobm9kZSwgY29tcCwgc2l6ZW9mKGNvbXApKTsNCj4gKwlsZW4gPSBu
b2RlX2dlbmVyYXRlX2NvbXAocmVxLT5ub2RlLCBjb21wLCBzaXplb2YoY29tcCkpOw0KPiAgDQo+
ICAJLyogSWYgbm8gcGFnZSAwIGV4aXN0cywgc2F2ZSBpdCBhbmQgcmV0dXJuICovDQo+ICAJaWYg
KHJlcS0+dHlwZSAhPSBSRVFVRVNUX1RZUEVfQVRUQUNIIHx8ICFub2RlX2xlbiB8fCAhbm9kZV9j
b21wKQ0K
