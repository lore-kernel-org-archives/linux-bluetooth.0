Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87586C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Nov 2021 00:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FB876135E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Nov 2021 00:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbhKKAyV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Nov 2021 19:54:21 -0500
Received: from mga01.intel.com ([192.55.52.88]:15728 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230311AbhKKAyV (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Nov 2021 19:54:21 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="256519955"
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="256519955"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 16:51:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="564806675"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 10 Nov 2021 16:51:32 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 10 Nov 2021 16:51:32 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 10 Nov 2021 16:51:32 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 10 Nov 2021 16:51:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fro/zmmW6qXIpQL8wJ/YYdxf9XK2Q3iYVUZs9spiuWZC16gldOTspCdJ2aaIqzezmMiNWb7ROqQsIa+zoCGQjQ3UHg1cqNkTSmSuqbj6VMOUtGO/GJxdoOFE6BH2yDWVljW+y1cGr/RnIwlhLN8GYr+RU9cJ+1HpHcEgsZuEVpn9pIX+7zCrFowaBNddPyobQKQK3MXk+6aAIcapqnuJYvtynN8mizK5z4nuNJLGG2d/Hh4y2bw3bODsoD7RBSrEUlALxMuZiPtgLEzoV3NCSWKXQcdQjF74blh8bm0ZaR/PpOGZk0VrqNJKr7AEUJBbf0e7V7bwVAg56+kb7DVFkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yYkgAvjgJ6luKTFz0bLhPb6E3b/t2IwmWB30yL0yqI=;
 b=POYnkGuB83skQkK0LMbJ/dJrK8L7f55Ugqg9QZn7P4v/vy02CTef9VoL62K0tqgl+PmrLT/hlgvkJRdio0Nn9VeW7ZKfxX9YYpPrRohqS0cScYDal5y0rN0gujqHeD+9+PcVmETysBS4+GKDLHL0VkB7a8JEMyTqu24vlJigBDCOMqqATpFyDPOdwDPr8+EILbb7k1lw3POwvZikjwOgNEQz0CiPCaEplbOr1Ydy/RH7q4UY9fNEPlAL7Sj+xwrGyiBs6jXUjmF3AIR5k0k1Js/1PAaR38JvsbYRZj8zrghtnERHXoxozGvIv7ut6pSVz/pN5flAgLfSBnPPrGXIrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yYkgAvjgJ6luKTFz0bLhPb6E3b/t2IwmWB30yL0yqI=;
 b=oMnslCySuT8ZTg7Ix2rD26CZvB7ViCsPn0RkA3y4g98APbsElP6fRzW9XWbD6wwrSWFcDvh2HaV+rNjBLQCHBfVmCF/krPPUuQphrw12nJgwrakrT80E7QHo9pcfQTldrtO5sme28N7rzR9UAOWQXeEmpjLYgMGSJuBYaVZge5g=
Received: from SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15)
 by SN6PR11MB3421.namprd11.prod.outlook.com (2603:10b6:805:cd::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Thu, 11 Nov
 2021 00:51:31 +0000
Received: from SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::d4ff:c285:74cb:c2d6]) by SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::d4ff:c285:74cb:c2d6%6]) with mapi id 15.20.4690.016; Thu, 11 Nov 2021
 00:51:31 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "goodgame13241324@gmail.com" <goodgame13241324@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "jefferson@zhai.ca" <jefferson@zhai.ca>
Subject: Re: [PATCH BlueZ 1/1] FIX: Fixed oversight of not supporting vendor
 model in Meshctl tool's sub-add command
Thread-Topic: [PATCH BlueZ 1/1] FIX: Fixed oversight of not supporting vendor
 model in Meshctl tool's sub-add command
Thread-Index: AQHX0mcS/ib6uQxSCk+cTLtjoDmAEKv9h7qA
Date:   Thu, 11 Nov 2021 00:51:31 +0000
Message-ID: <441371f1561e4504880850db796e59de9a28bf62.camel@intel.com>
References: <20211105165735.13606-1-GoodGame13241324@gmail.com>
         <20211105165735.13606-2-GoodGame13241324@gmail.com>
In-Reply-To: <20211105165735.13606-2-GoodGame13241324@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b53b987-772e-4deb-277f-08d9a4ad6721
x-ms-traffictypediagnostic: SN6PR11MB3421:
x-microsoft-antispam-prvs: <SN6PR11MB34211BBB120BA215C56EE779E1949@SN6PR11MB3421.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:72;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nUAXY2pWeTFJEmAlSyrnr40OqUpVnJ0ytNkHfai5BHXSDP/XoWt4QnIni525wMf3J+5h7zDJMAl0QtrdNvuh4SbpR+PZ5IeaTOkAz2UAr/D01DB4Udaq150A9eDgocnyjMWwnf2WLi+eUGBv/nx+pJmr/njMHf2uR7Fa13wNuYUumvrnWrMibeGKugheZgfpVO0F/sGH1/2bRG7OQt6nu0hisimTodrxPF60cvqufYNqAqwtLDIkY6t4G1ZbkzTBFfA4Bgv3Q+O7GYrSMMeIjN8r1Oc14njCDJNanhmLYo4Kc5wmUSoUsKdXiXegRvax+7P1lohaNF9H5IlNUItvjGVMGnrrw+CGb68ydZ5HXUbhOQbmb3XYEPG4Vc1hLFrWIRPRa8BGLynwvVG2KpPBnrRanMj3CPzpF7Z+ajyPLudlAZcE9PjjVfXzmcDTKgTGM05JX4ekDmDnJTxM2H+LP9ORwWIEz3zxv9zShVktjx9UmHLuLYqkkEl1TkEWbzo3nSVd61YjG6aqUBa+sjfUobWui/TsyJxTjIhKthIeE8nPOk5dFOiNSh4u96wAFQ7QpkkIvIBNGOS+tIcloo/TiQbh3ENWRQWIk0bY60VT+nEcLtUm3ZPFnBFZAtnoEPDEw0TWyr6EO5K1Z8J9z5xEp7VyzJxezdpRJDAcgUapCLmG94Hj8rHhl4O+YP3ZO+1JO8BeuLsyaONvfM/dzjkKbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4526.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(5660300002)(316002)(4326008)(76116006)(110136005)(2906002)(86362001)(6512007)(2616005)(508600001)(71200400001)(38100700002)(66446008)(8936002)(36756003)(91956017)(26005)(66476007)(8676002)(122000001)(186003)(6506007)(66556008)(38070700005)(82960400001)(66946007)(83380400001)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ukt6TXpZZHFqY0dzSFJHWW1aejI0SWhoRk9vMUxORkNXRVJyNklrM3o3eVpn?=
 =?utf-8?B?M2pUaXJDMFMxbW9EanhSbFZDS011NUNMdU1Uekx1dVIyQTZXeGU4T2p5Vzdk?=
 =?utf-8?B?MnNZUVhtR0xpeFZueWlGZWhpb2dQMzRSTSthVFYvWUROeUE4WW1yQkcyczh0?=
 =?utf-8?B?NGdyV3JGUXVVK3I3d0QrM0pMRkxZdWFleTBFUlVUTlhSU2VHMW1rOENzTnAy?=
 =?utf-8?B?YU8xSTdJUDZPN1gwVDJtV3IvSE55Sm5zOTNJcWJOYmxZVHYrRnFReU1ra3l1?=
 =?utf-8?B?bElJeGxPck9ES0M5QzFmYmcrUGFLVEFYUHZGNEVqS1h1TjRzUnFyNVZ4cDZp?=
 =?utf-8?B?ZzBadlhsNFdQU2x0WGkrUnFYdEFGZDJTOHV0dlozOWVlenpEMWtDdURCYTdC?=
 =?utf-8?B?Wk1wbHJuYzZDYmQ2THNMdEphUnpHY1VWa2UzME5jQUhpSjk3ZUFpL0RRLzZN?=
 =?utf-8?B?M0xUaWw0dFJtMTYvK29QQm12R3MrREcyMnFQOVB0UW1IbUlXZTB5ZENrNmwy?=
 =?utf-8?B?dmtWQStiVzJUSkFaZWkrRlM1aG5zVXlhSGcvZlZTamNQOHgzazZWVUZ1RWdQ?=
 =?utf-8?B?VmZqSm5PcVZWazUwMUh2QmRiU05aN1BubjVmeHgrY0NIQ0xNRUtENUlKRXFu?=
 =?utf-8?B?dnJFWkpiR0N3N2tVTWRyZ0pWOXIrZndPdnZXdlVZdmJSbWRDSkh3TlpBTFJW?=
 =?utf-8?B?T3c4ekkyaTVJYWM2L2RORWN5aklZSUJSdDU2VGovd3BpdTJDNUhPc3VxaTZF?=
 =?utf-8?B?OXhpVFVzeWFxM21BKyt4UWZUN283UzlwdHJJMERYQW5uZlRYTmxMeXdyN0dz?=
 =?utf-8?B?bFM3dDFUK1BFWWxQaU9oTXExdXJydmh6ZHkzb21xMnVBZkorbllnRFJlT2N1?=
 =?utf-8?B?Y3lDTXh6QUFyaUJNRU16Z3ZDa0hDSUpRQnNoa0NrbXlKblQ5ZG0vK1ZqbUlR?=
 =?utf-8?B?ZTUyNXZhQmI0VDdKN0VXcUp1d0cxbVhmdU9DaGZ2UFNhbTNoL0pMTVgvdEtQ?=
 =?utf-8?B?MjIyYjN6RmFGanZSV1JPRjl4STl3TGRyZmR0K2xDVFF6dmw5SmlPaDdOYy9O?=
 =?utf-8?B?TmsrZzdRMDhCWmpXRGxjR0pLbFl1TU8zTm9aaWlEVGJqRXVRY3JibjlGSG1N?=
 =?utf-8?B?ZjZkdU1WZ0MxRmNaM3dqWi8xZTZUcGh3UGpzSkthVStMc2M3YnhRODlQUWFT?=
 =?utf-8?B?S1A3TURJSXBLa1h3b29UWEx1anpOTEZVOHpKc1pnNjUyaHNFT2Y5dldnSG1J?=
 =?utf-8?B?RnZGSG9pZ0J0SnRnLzNDOTJjMGxDZFZoaDJSZVRXdkZKRFBYY0ZTYkl1OUNz?=
 =?utf-8?B?NjBRSWdtSmQwL0Mwak80MW1xQU9QaWhIU3NMeGxSS1VQRm15aVk3NDhCNnFY?=
 =?utf-8?B?NVJYWVF5MVNSODI1ZTJBNUtPZmVLSHBvdy9xZXllTVBHa2x6MVlYK3d0VjRV?=
 =?utf-8?B?ZmN4UUFjUHRkV0VWVitzeWQrT1YrMUpUbm4zdnB1ZXZqempwZjhGckdqU003?=
 =?utf-8?B?bXpzbzVxL3BBNSt1VVJZV1pQcjhvaWdFdkFQaXdKOVpwTXN4NW1QZmhLQXRL?=
 =?utf-8?B?N050UkNRR2kyVDRZVXVJenhrQ1pvcmRua3cxMS9ac2JTd0RpbGlSQVlGZ3Yv?=
 =?utf-8?B?ZlJhNE02UFhuaFFzbklLb3JIY21USGJ1bzJpck5lYVlFYWl0TUdneWVmakxH?=
 =?utf-8?B?UWpSRlpzT3NOeUNsazdvb3pWbUgrc0FDRXhaUkpSenFpbzlud09yY0N6dFF4?=
 =?utf-8?B?UzhMUXZkOEZOSWVoYW15bFFNUnVQNzNkVkM1YW51NkswRGpTN3JrUndLRWs4?=
 =?utf-8?B?MW1hMzlySkVqUFVlMVlNWi9ISFdPK0JKTURYckNKWVhTcXpxY0hiTzRYYUxw?=
 =?utf-8?B?TVJoVW5nelZvWDVIdkY3MytQNnAxOTIxVE1FNWN5UWdTZy8zOXNvalNENE5s?=
 =?utf-8?B?N0FiSjV4ampZZjhHTXBpeDd1a3NqUmtEWFMvOS9qNXRESUppYkh3bC90d0dJ?=
 =?utf-8?B?bTNmeTVpREVoT2ZvQUVjZ0k3WmwwR0xHRXdETHNoUkRIU01kSmx6K21UUm11?=
 =?utf-8?B?MVkvRHRMWUNRQzVlY0xjeEFDeVlmMjBSWXZENVpVN0dvR3ltUHpUeTl6c29s?=
 =?utf-8?B?YlRnS1FVcWJnUWJCQUdVWE5RcmRqSXZUZ0NFUlhtcnE4Sk5uWktSZENSS3ZO?=
 =?utf-8?Q?FyP6dMw5oZ6JjRXuVH16kXk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <63DD3E64D3BF014FA53C8D6C73A3A77A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4526.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b53b987-772e-4deb-277f-08d9a4ad6721
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2021 00:51:31.4576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JM97j4lrYdtmE6xN8R+/lf5Ci5dBIzcxMj6GnuGDv439+tQeJQDFxUGvXyz41B93dlviqhruar4me9835NoHUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3421
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCB3aXRoIG1pbm9yIGZpeC11cCBvZiBjb21taXQgbWVzc2FnZS4NCg0KT24gRnJpLCAy
MDIxLTExLTA1IGF0IDA5OjU3IC0wNzAwLCBKZWZmZXJzb24gWmhhaSB3cm90ZToNCj4gRnJvbTog
SmVmZmVyc29uIFpoYWkgPGplZmZlcnNvbkB6aGFpLmNhPg0KPiANCj4gLS0tDQo+IMKgdG9vbHMv
bWVzaC1nYXR0L2NvbmZpZy1jbGllbnQuYyB8IDE2ICsrKysrKysrKysrLS0tLS0NCj4gwqAxIGZp
bGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS90b29scy9tZXNoLWdhdHQvY29uZmlnLWNsaWVudC5jIGIvdG9vbHMvbWVzaC1nYXR0
L2NvbmZpZy1jbGllbnQuYw0KPiBpbmRleCAzZWM0MmQ5NGEuLjdiZGQwMjhkMiAxMDA2NDQNCj4g
LS0tIGEvdG9vbHMvbWVzaC1nYXR0L2NvbmZpZy1jbGllbnQuYw0KPiArKysgYi90b29scy9tZXNo
LWdhdHQvY29uZmlnLWNsaWVudC5jDQo+IEBAIC05NzIsNyArOTcyLDcgQEAgc3RhdGljIHZvaWQg
Y21kX3N1Yl9hZGQoaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkNCj4gwqDCoMKgwqDCoMKgwqDCoG4g
PSBtZXNoX29wY29kZV9zZXQoT1BfQ09ORklHX01PREVMX1NVQl9BREQsIG1zZyk7DQo+IMKgDQo+
IMKgwqDCoMKgwqDCoMKgwqBwYXJtX2NudCA9IHJlYWRfaW5wdXRfcGFyYW1ldGVycyhhcmdjLCBh
cmd2KTsNCj4gLcKgwqDCoMKgwqDCoMKgaWYgKHBhcm1fY250ICE9IDMpIHsNCj4gK8KgwqDCoMKg
wqDCoMKgaWYgKHBhcm1fY250ICE9IDMgJiYgcGFybV9jbnQgIT0gNCkgew0KPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJ0X3NoZWxsX3ByaW50ZigiQmFkIGFyZ3VtZW50czogJXNc
biIsIGFyZ3ZbMV0pOw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBi
dF9zaGVsbF9ub25pbnRlcmFjdGl2ZV9xdWl0KEVYSVRfRkFJTFVSRSk7DQo+IMKgwqDCoMKgwqDC
oMKgwqB9DQo+IEBAIC05ODQsOSArOTg0LDE1IEBAIHN0YXRpYyB2b2lkIGNtZF9zdWJfYWRkKGlu
dCBhcmdjLCBjaGFyICphcmd2W10pDQo+IMKgwqDCoMKgwqDCoMKgwqAvKiBTdWJzY3JpcHRpb24g
QWRkcmVzcyAqLw0KPiDCoMKgwqDCoMKgwqDCoMKgcHV0X2xlMTYocGFybXNbMV0sIG1zZyArIG4p
Ow0KPiDCoMKgwqDCoMKgwqDCoMKgbiArPSAyOw0KPiAtwqDCoMKgwqDCoMKgwqAvKiBTSUcgTW9k
ZWwgSUQgKi8NCj4gLcKgwqDCoMKgwqDCoMKgcHV0X2xlMTYocGFybXNbMl0sIG1zZyArIG4pOw0K
PiAtwqDCoMKgwqDCoMKgwqBuICs9IDI7DQo+ICvCoMKgwqDCoMKgwqDCoC8qIE1vZGVsIElEICov
DQo+ICvCoMKgwqDCoMKgwqDCoGlmIChwYXJtX2NudCA9PSA0KSB7DQo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBwdXRfbGUxNihwYXJtc1szXSwgbXNnICsgbik7DQo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwdXRfbGUxNihwYXJtc1syXSwgbXNnICsgbiArIDIpOw0K
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbiArPSA0Ow0KPiArwqDCoMKgwqDCoMKg
wqB9IGVsc2Ugew0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcHV0X2xlMTYocGFy
bXNbMl0sIG1zZyArIG4pOw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbiArPSAy
Ow0KPiArwqDCoMKgwqDCoMKgwqB9DQo+IMKgDQo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoIWNvbmZp
Z19zZW5kKG1zZywgbikpIHsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBidF9z
aGVsbF9wcmludGYoIkZhaWxlZCB0byBzZW5kIFwiQUREIFNVQlNDUklQVElPTlwiXG4iKTsNCj4g
QEAgLTEyMjIsNyArMTIyOCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYnRfc2hlbGxfbWVudSBj
ZmdfbWVudSA9IHsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNtZF9oYl9zdWJfc2V0LMKgwqDCoMKgICJTZXQgaGVhcnRi
ZWF0IHN1YnNjcmliZSJ9LA0KPiDCoMKgwqDCoMKgwqDCoMKgeyJoYi1zdWItZ2V0IizCoMKgwqDC
oMKgwqDCoMKgwqDCoCBOVUxMLMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBj
bWRfaGJfc3ViX2dldCwNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IkdldCBoZWFydGJlYXQgc3Vic2NyaWJlIn0sDQo+IC3CoMKgwqDCoMKgwqDCoHsic3ViLWFkZCIs
ICI8ZWxlX2FkZHI+IDxzdWJfYWRkcj4gPG1vZGVsIGlkPiIsDQo+ICvCoMKgwqDCoMKgwqDCoHsi
c3ViLWFkZCIsICI8ZWxlX2FkZHI+IDxzdWJfYWRkcj4gPG1vZCBpZD4gW2NpZF0iLA0KPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgY21kX3N1Yl9hZGQswqDCoMKgICJBZGQgc3Vic2NyaXB0aW9uIn0sDQo+IMKgwqDCoMKgwqDC
oMKgwqB7InN1Yi1nZXQiLCAiPGVsZV9hZGRyPiA8bW9kZWwgaWQ+IiwNCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNtZF9z
dWJfZ2V0LMKgwqDCoCAiR2V0IHN1YnNjcmlwdGlvbiJ9LA0KDQo=
