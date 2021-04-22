Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D63C433ED
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Apr 2021 21:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7C1A61422
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Apr 2021 21:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239244AbhDVVcB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Apr 2021 17:32:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:25725 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237092AbhDVVcA (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Apr 2021 17:32:00 -0400
IronPort-SDR: TFvKYcU9Fdi/8p4waDGThZGueZ2Lc7irrmTJZ84AT1dJbotb+sVFpJUm7+GKsGR0BaVGOLHSii
 T5NLGv/jm6kA==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="216657293"
X-IronPort-AV: E=Sophos;i="5.82,243,1613462400"; 
   d="scan'208";a="216657293"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 14:31:25 -0700
IronPort-SDR: 9tsprqvXzQTNZmiJbJTqwuHD8V/CpOHBc6gmUVS4ugcWZAzMRfiDAxk4/lN6aF5O+7IyHAUcVt
 G+69ApQ5QoJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,243,1613462400"; 
   d="scan'208";a="455960036"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 22 Apr 2021 14:31:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 22 Apr 2021 14:31:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 22 Apr 2021 14:31:24 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 22 Apr 2021 14:31:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHA5t4Aw5CJQlw8w5wBlH0GquP4OelO4ORkJmle4Pz7RrgeOzNsXRpKTIbT3Q3j46quoaPUofoZ8MS5YczvVF4WzZ4ZY9b05DVUB0QdbRA6zK9ki8sNp+oWJ9nHelZE8GMS+GuMEqNjLLblq9KaEB6cklgGHK05+pCWWGTfbk5qwmd3U7wlnUsfQwN7fL0OPgZNUo7iC/CxBZqaygWkjo02JcLqfSh4w8+yvKY3vI71HROc6s3Q0gZIWRXO2jgiGnNbzDNGLpXX2Kmc0j8unSiiwok76o8LlIRJ8iQk3t6dtjZ6r24veLpiX1BaAqRV08Vq9n5u06H1nr3xT68byAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4/8xuoV/xOjv0lEf5+DZNmUk8jG6oKpS1ZbozKYIxs=;
 b=XMfQAGx47EYVvAqazeqlTFYgsyg1/qGtJxhZOP+liDIuUioVMoVLxAWrQqDNifmetqr0CgNajS/FcCMtG8MbMMuqaK9f3J4OuSLrFdRH71zILKsUi1u0kd7HIhn6yU4z2XfDqXZ/BWauql1DnYmOe4YByDhy1G6EKEjPKBV5WSIS+yswH6FA4D3LgIU1cxhf6+O6Wpa+7tbQi2MlqCXeNLFrT6cUzQIP9DREGln56t9+c/kZc45ViYJZz+0uqhdSbWn/lDoMKk+ZQKkg6wTWMDpgftAaVi8NAqZbRGCA81r6GwKAmDnw3fFeLc2n4ijM2uvH1sYbwzLHaV20fn4h+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4/8xuoV/xOjv0lEf5+DZNmUk8jG6oKpS1ZbozKYIxs=;
 b=xUlEtwnY5hmB9qhE++5Wfmzci/nIahQoI1aS1NY8OC3xKz3IxgEu7DGfvtE7JogLh8VJEXaa/ZChJM1qJf11l1qvkjGDoL8Sk2LIfhDw0tKX7XX5a+hROSilFu9qr5oVWru1tPWy/3IqNw97s0C5Zt1ggdjoAqmAJ7JjRh4S338=
Received: from SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15)
 by SA2PR11MB5020.namprd11.prod.outlook.com (2603:10b6:806:11f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 22 Apr
 2021 21:31:22 +0000
Received: from SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::6d41:f56f:80e8:ef15]) by SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::6d41:f56f:80e8:ef15%8]) with mapi id 15.20.4042.024; Thu, 22 Apr 2021
 21:31:22 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] shared/timeout-ell: Fix timeout_add()
 implementation
Thread-Topic: [PATCH BlueZ] shared/timeout-ell: Fix timeout_add()
 implementation
Thread-Index: AQHXMbTJiv9IrHEW5EOaoFz8m2SuT6rBGkOA
Date:   Thu, 22 Apr 2021 21:31:22 +0000
Message-ID: <3d376e1dfc031af9d3d5778e8d8084f9d254ffb1.camel@intel.com>
References: <20210415050347.253831-1-inga.stotland@intel.com>
In-Reply-To: <20210415050347.253831-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.137.85]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8315574-cb8f-43c8-6bb5-08d905d5f996
x-ms-traffictypediagnostic: SA2PR11MB5020:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR11MB5020C35CC611BC624D2A09E3E1469@SA2PR11MB5020.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gfR676NC2STOLQ6ctcJ1yIWb9j3kfPDNTiNczyCYBmdHzTK8GRq9n4kCnb6Y/A+68vHkojt8Kxpe/mVDT7Cze2HHYwXG3fXgnqQ/r1b72deiDcAMLo71hLBL1sruwM32ircbEqnnXYDwjA9xZgNhDrnpDJ6z55QwkXTKdjw3jMwYlXqdx8BshRolGOrMsltmkGQXGGgIgSGCmIy/5VIaMu3n1EzqyvIcvh1N/S5xgoZKYihrHUXWoMzPh1xJHS3e4CnNw79hg7OSy3Ng4sP6hQ/c45O7Lax8ZZHv6lUQY/19Jp0lEcImK6EDNbve2100TDWgPA5aDlAZ0jr4UemY0Zh1Bq5prDWJ1N4jtiQGf9TuJdXxX0gLyvATOoRlA0uGLqvVIaQ5Ht8cJL0fl8tgczQxf589Vx4haBfgaH2n8IotvZ0CxQcc4U0qYMcc/qhWhgEVBQPUJ1+5I7R3xbsr7bxN9+Fal2CmPyyCznO0FDDrsmxahg9KQp2BvH3W2GuDhc4PYAWwXlhD/MEkZmNMoyYk3nFhM+zguSYn4miockNxlctOjz20Fj1zRTNjCJoTlebMTOBRPvnpiVE6Y+BtK8fGAZJIHEsOONI1uaQftx8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4526.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(39860400002)(346002)(376002)(396003)(8676002)(71200400001)(122000001)(8936002)(2906002)(478600001)(38100700002)(110136005)(66476007)(36756003)(2616005)(64756008)(66946007)(6636002)(26005)(186003)(66446008)(83380400001)(76116006)(66556008)(91956017)(4744005)(316002)(5660300002)(6506007)(6486002)(6512007)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZkdvZzN1WGVxZ2hmYjcrQnFyWWxMUjdaQXg0K2FiM1VseGMwcEJCaHBVUXY5?=
 =?utf-8?B?NU9URzl0eWVzYVk1Q2M2emFYejFPQS9pVWkrZ0F0ajk1YjdaSlB4QVhyQXk1?=
 =?utf-8?B?UmsvZTBHWnpJcWRnaFRMMjlwS0dBOEpRa3RUV3luREJSZ1dzNDdUeUs1TWVq?=
 =?utf-8?B?TnUvcFJFeGVob2dpbXZseGRsRUNjVFdScnZtclozbk0xbUdmRGlEc1VxdHNa?=
 =?utf-8?B?dkprN3d6NDhMSzBjR0pYS1BqMGt1TldCV0dnZXArQlpoVWV1akR0dXhvL3hN?=
 =?utf-8?B?V2thU1B4U2xpUnQxaXVzanI3YUJXOFVpUjM3UmRPakFoVUUya3BaRjdWUGlj?=
 =?utf-8?B?TC95MzZxRGx4UjBoSHdqS2NGQnVPRnU2UlZvZzcxT3NtVytnQWJwUW9udHZY?=
 =?utf-8?B?US9xaHRYV0VPcFVBbmpjSzdsOXE4QjV6K2JuWFV3bjVoK0JYdzNmUDk2QmJn?=
 =?utf-8?B?QmUwQ0xLMktSdmFFaUp1SFRiZzkrSVR6MjBjSndPdm5EcFVzNC9nczBwSnVk?=
 =?utf-8?B?SG9iVDJXaElBU0tDcVYrNVc4WS9RdDkvdGZxbzNxN3pMSXBCRVcxMnBGeFox?=
 =?utf-8?B?Um9xcjBTT1BsNUxVN2M4VzdtTFo0Q3dOK2hYZFR3dE44blAyNlh1ZFNnVGVU?=
 =?utf-8?B?c2tCK3dPV0M4T3pPenpvR2U0dWxsNEVRUHR0UXJha2xIUG5TQWVtV2k4L0w2?=
 =?utf-8?B?dWZLQ2dYNDQ4SlhGUEJWcDRiNC8rZVVjYVpZOW1Td1QyZ2JoTU5QUS80WTFD?=
 =?utf-8?B?Um9hTUZ1QXVDUWgwOXRaNXlheGU3VU9xa1VacmVLMnFJZnZGQzJTdVZENDFM?=
 =?utf-8?B?SEdJRkFSRU4xY295c0VoODJjNU9KeVBkaWM0VlQrMFFneDR0cXh6UWpXQlI4?=
 =?utf-8?B?NU9yWHdXQTdXeFFrNGJPZ1FyM0VhZjlUQ0txL28xdjZISjh4dkZpeEJaYVJH?=
 =?utf-8?B?cENnT0dUd1JxMWk5blo3NE1sODJLSlFHRzJwRUJLL2JoZ3NYeFRJL1lKLzkv?=
 =?utf-8?B?TXUzb0hGM0RnVSs1eEtLRkwvWThqTER0UnhBTTlGQTVxK2tsejd2THVPb1ZU?=
 =?utf-8?B?U1F2aFRzbFJ3azF5QmNKSUFYUjJyZHl1VDdaL3BXd0RvVEhKdTk5QitlUDRr?=
 =?utf-8?B?dFRFdHEyVnRwT0hheUhrQXV3ajEyRU4vWWFDOVpZbDhSU3FYS3JPNE9kTU1E?=
 =?utf-8?B?Q2VFeHJpU0RpQktwYVB1cmRaenJBekxCSVpXdUk2SEtFSlZMalJyV0JaVEUy?=
 =?utf-8?B?eDJMZ3Z6SEx0QkIrNUI1eGF5NGR3ekhUM1BhbGpNV0hTTnhDcDlZUHExTFhF?=
 =?utf-8?B?WHc4RFFhZGduTmVrTjFEcmp2VXk1cG9WVjF3SXhKdFpKN1I0Vzg4NldJK0FZ?=
 =?utf-8?B?YVM2WVlOZmtCekFDa2hDejExck54QzF1V0pIRmFtNFpFTEZ5Y0lZeHVtVXJ2?=
 =?utf-8?B?Nk1ESnpSMGRqRTVGVzFpVWlVaFltM2h6amVhQ1FWNGkvNDVXTzl6c1I3eWtO?=
 =?utf-8?B?M1ZBY3k2VXp3MWtCZFVEMHNiaWVRbWtySDVwWDVNeGloQmxlMmNSMnFQZ1cx?=
 =?utf-8?B?Wi9mWUxTWGxiTHlwenFsWDIzc2hpSmZxL1FCVW1TeDFkbTVXYnRzOUlmbWVL?=
 =?utf-8?B?Z01nRDI1ems2T0UyWXk3K0czSlZVNDVsSVZWZVJ5YXcrZnhuTmQ4dDlNMXkv?=
 =?utf-8?B?aXhRWnVUQ2pvSVo1MEJYSnBxR2U4bzRlUXpXZ243WTZhN1FVTFBpQ3BDYjgx?=
 =?utf-8?Q?tO8louRFF4DPWB0pR/hCHc8ZwbjppDq6lltYLkZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57902DC32719564DB4FC2E55FEF287AB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4526.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8315574-cb8f-43c8-6bb5-08d905d5f996
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2021 21:31:22.2327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j93/JV0nLsIxGwC1VgWiVTLNI+Yg+WnfzfepiNBkWtVauNfhHiUABY4o6FkHPqapL68Hac9OAk09K3JnG4mcEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5020
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCwgVGhhbmtzDQoNCk9uIFdlZCwgMjAyMS0wNC0xNCBhdCAyMjowMyAtMDcwMCwgSW5n
YSBTdG90bGFuZCB3cm90ZToNCj4gU2luY2UgdGltZW91dF9hZGQoKSBleHBlY3RzIHRoZSB0aW1l
b3V0IGluIG1pbGxpc2Vjb25kcywgdGhlIGNvcnJlY3QNCj4gRUxMIHByaW1pdGl2ZSB0byBjYWxs
IGlzIGxfdGltZW91dF9jcmVhdGVfbXMoKQ0KPiAtLS0NCj4gIHNyYy9zaGFyZWQvdGltZW91dC1l
bGwuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3NyYy9zaGFyZWQvdGltZW91dC1lbGwuYyBiL3NyYy9z
aGFyZWQvdGltZW91dC1lbGwuYw0KPiBpbmRleCA2NDE2ZDg1OTAuLjAyNjI4NjkyNiAxMDA2NDQN
Cj4gLS0tIGEvc3JjL3NoYXJlZC90aW1lb3V0LWVsbC5jDQo+ICsrKyBiL3NyYy9zaGFyZWQvdGlt
ZW91dC1lbGwuYw0KPiBAQCAtNjgsNyArNjgsNyBAQCB1bnNpZ25lZCBpbnQgdGltZW91dF9hZGQo
dW5zaWduZWQgaW50IHRpbWVvdXQsIHRpbWVvdXRfZnVuY190IGZ1bmMsDQo+ICAJZGF0YS0+dGlt
ZW91dCA9IHRpbWVvdXQ7DQo+ICANCj4gIAl3aGlsZSAoaWQgPT0gMCAmJiB0cmllcyA8IDMpIHsN
Cj4gLQkJdG8gPSBsX3RpbWVvdXRfY3JlYXRlKHRpbWVvdXQsIHRpbWVvdXRfY2FsbGJhY2ssDQo+
ICsJCXRvID0gbF90aW1lb3V0X2NyZWF0ZV9tcyh0aW1lb3V0LCB0aW1lb3V0X2NhbGxiYWNrLA0K
PiAgCQkJCQkJCWRhdGEsIHRpbWVvdXRfZGVzdHJveSk7DQo+ICAJCWlmICghdG8pDQo+ICAJCQli
cmVhazsNCg==
