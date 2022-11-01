Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88357C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Nov 2022 18:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiKAS4M (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Nov 2022 14:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiKAS4L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Nov 2022 14:56:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A301C41D
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Nov 2022 11:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667328970; x=1698864970;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=1DBpNq7t4iwJqFbbo8gWgajAOktIWHwXE88YSnuwDyw=;
  b=dC/0Yla+D7l7jGsEyw3trjeBXfvX0Tm48lXWKqDgEuYpbUXdIGbPnqCR
   PDpERurIxcYVurRpGTg29zxP6D2WblvnS+hNF+CZEkI6o6mpAgt2+oIya
   JqiiW0+kpg8Zw+uqGdAuBDMXTv1EY4ihOXyJqs0UmYnaNzw8UBGmY+qdy
   omTpcIFKMrxqmJZI0m0ATGx30LaMdgrucYTZ42GFKoc/ohvdyx1BGeAEa
   4ExjvQgrNaX53E17ZKrjkkz7E0ELmRBpbVvWV/AH3qkYWdUA738JYUhXI
   7pi4G4yd5R3PqBiRvvqtXUanrHifX0EyVwxI4edBUYSgeqcMfaWsBOa1G
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="310314374"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="310314374"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 11:56:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="585108300"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="585108300"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 01 Nov 2022 11:56:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 11:56:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 1 Nov 2022 11:56:09 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 1 Nov 2022 11:56:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZsT7vVflSXzIYoGkhX5jhkMqUoSYfqa0rRqlmGHoQI/UN7C4sf15Yn9mzHQ+LRSGie+0DyHD30vGHFqlK01TVA0XXv32pXG9lQEnJvUHWkWx1VYxM0wfJZPCmgTD9YbH6ZUaBJjHezLWdzBQ5pJcplwupoQkqDa58wibZLpqd0Q3+s3lkn+goJ/rgXw6hQKSVLmOm+DMxpWfuiFZYCQqIlgshVaOf7tSyVRg03cMU32/dJ0iVrCNbHkJKGT0RRkIzUd2BlSDqFBSey87k1BH4GqcMbbHz143MQoWoKERNCrzH6WK+s7wd4T6JBYn5dboIDjJHr+6+F486P0fqj6Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DBpNq7t4iwJqFbbo8gWgajAOktIWHwXE88YSnuwDyw=;
 b=PzZ3WRhG3dTLd7Mz+Qj0Y8dVI7zaA6ny1C5FvMdihxAYlYPsQ+4Am8zpwV7EyJn8LOimgS14S1yJ3gVhBB+g1hE1Bw0E+F3WWP4c8bo6IdX99A7nlwZKAAEdD1/T5WxHNR/cYWDZEaDaQCYFYv5Jf6Or2OTwyY3EQ92MC48l1tR+yB3WCSuXmgz0gZdS7y5gbBFQB7zsTC6mCZYIMFMfZUKbcBLNZI/TFB+IRYsxYZnhZXXGlLgAGGg9A2Xrinzbogc4w7SimYVN8s00r2G/Puise5wp4ySqbXj9FjqoHRa1wL24kFDQOYzvaCkFB6N/nf2BBY4CNCSYbF3nP6LNuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW3PR11MB4748.namprd11.prod.outlook.com (2603:10b6:303:2e::9)
 by SJ2PR11MB7574.namprd11.prod.outlook.com (2603:10b6:a03:4ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Tue, 1 Nov
 2022 18:56:07 +0000
Received: from MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::7342:3e65:ac68:85d6]) by MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::7342:3e65:ac68:85d6%3]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 18:56:07 +0000
From:   "An, Tedd" <tedd.an@intel.com>
To:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix attempting to access uninitialized
 memory
Thread-Topic: [PATCH] Bluetooth: L2CAP: Fix attempting to access uninitialized
 memory
Thread-Index: AQHY7X4jSTen6Xa03065PaBMpp12S64qbDUA
Date:   Tue, 1 Nov 2022 18:56:07 +0000
Message-ID: <2289ea95dd315ec64f7391ee2c0286b336b2b60d.camel@intel.com>
References: <20221031231052.2718430-1-luiz.dentz@gmail.com>
In-Reply-To: <20221031231052.2718430-1-luiz.dentz@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR11MB4748:EE_|SJ2PR11MB7574:EE_
x-ms-office365-filtering-correlation-id: 13bf3c50-b6cc-45b3-5898-08dabc3abc23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vFztUItDgIcnB5fqkD1LXpGhlfOXUVq5QUqtnuK1hvRd32hWbJCAtTt64Nuxmwip+/Gr+n4tmOhnOeHmlPvjVHZtDqLyPkgXrg0dXV7OjXD5tewFwtbw1CJpmKwbLv0huVoPoFKGc1yBzcW2fMAfv9d3nggY3s68cibui02P6N1sbSnU+TdteMPA9pQB/0Nv0qtTcojlnjTJUFvN7lshMGPfLyYExE0uh7klQt+Z5KCzzPlEItvfLIEEyJLSbHC7hHKQ9VFpFumyHQsP6WOBklt2J4QqrHrzBAa/ecXbfm2j2vnFn1hhGnawhX4RJIwsjk8uwajTZUmvzS+K7tnu4zaHef9AFCe+fryMw9i6WG9c0vmAm6I7TbSAP0YhVFNr1n1803BaqP5BmY4KnA7it1vPtn3mTANZ1m5EiOlY2p+iFPN0tMJTmCRKVslyUnRhHtmaflfh7H1YFwLVwo2Qf41botiQ0MnYhoMxFVQ2v4AkwmwFEL35oAqnwEX60LiRB/lgkahyT0gmgrrTL7SsHR3uwptmylMslfexIE/czdzedYveSC9C5ql4iHkdTkJ1gD3OGv2RvYLPHLQ3dVrLTBS181d3qHdZLHKr0VkTfjWAVy4xTon3t3kRSEQUgxpCN+3quSNTy0WL08mZysR/o519McvbZdvk9Il4zlra+HQ50jt3ldlCENGx4MoSO96CHNTzy2hYCtxoXB7GAXy7bvE4EzybiFSIC41XiZx9HH2YMhtgowgHffK2axmXKPZYc5kbyQE2BTXUWDTc9VEUaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4748.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199015)(66556008)(82960400001)(38100700002)(5660300002)(36756003)(122000001)(86362001)(66946007)(83380400001)(64756008)(8676002)(110136005)(76116006)(66476007)(38070700005)(91956017)(66446008)(478600001)(316002)(41300700001)(4001150100001)(66574015)(71200400001)(8936002)(2906002)(186003)(6512007)(6486002)(2616005)(26005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHZ1ZHA5YXVPMUFGcXFnMkJPVE1kMlozenlXc3RhMVN4V3RsaWx4UVRJZE9P?=
 =?utf-8?B?QmM5alNaVnZRcS9EQnlHbDk4b0F2UEo2L3YrZ1JYcVZzRWxQZGZHQnc4WC80?=
 =?utf-8?B?Q1R4OVRUOVgrMG9EQjBjSUFyeGV4MTZ4enpYL3NVcys5UjJwQUR1M3JvZXE1?=
 =?utf-8?B?QjhnUXN0SjRhWERmQjI4dUxhYW0ya1AvUEI4OGp5RFkzaUNnMU12VTFLd1Js?=
 =?utf-8?B?YkRFKzVYYzlCdVZPZ2tCVytFWktnRko3TkYyUWhxLzJBV3B6RkE1S2pVUU5F?=
 =?utf-8?B?RHlhZ2w2a3pMSzh0b3J4OHA2bzBWT01ldXZ0cDV2ZXJxdDRjRlMrS0NZdnlT?=
 =?utf-8?B?TlRlZ3FPTThFdjNCWGV5dnBwYU5WdHFOL1k2N213MVc1dE12eE8yaitLNGhh?=
 =?utf-8?B?L2N4NXdFbzBTZndHbXN5UWpmcUhFQldCVkMvYzZxd0JFU3h4Q21iY09hUE1K?=
 =?utf-8?B?VC9HRERta0VJc21NNEZDRVRRNDEwaEJPa3Y4RlB2T2c5c0F6dXJmV2hFQSs3?=
 =?utf-8?B?TXpVb0RjT3ZNSWh2NlhUTVZLWmM1NHB2cUthZDJJeFFFaHk5OW1PSmVSQWVC?=
 =?utf-8?B?WGFzWkxLVFRVZEdZaURyQ3hTeVd5RjZjcFNlVXRzYkVnUUxaVHZ1QWJTbXpI?=
 =?utf-8?B?TTA5SGYzaUs2NCsyREtrcGE0WnM5YzdMeXZ4a0hCc2ozbXNhNjNJaWQyMmpm?=
 =?utf-8?B?QklEamhPcEs4R0FVMmEwOTFBSmhjaVp5V3h1dktzVm9tbTJCUzlVSjVvcFhS?=
 =?utf-8?B?Z2ZXK0RudlpRVzJTUUJkTG94L2xaaFV3enhLUXJZQjcrU2ZmSE5jODYxb1Ni?=
 =?utf-8?B?ZHlIZ1pEbjJpQXlPcWdHdWZEQUYwa1orZFR2UHBZZEJNZnlqZkVRRHV4MXlz?=
 =?utf-8?B?MUFabHRPR01ZeTQ1R0FOYTcrU3pQblh1SHdrOUl2VmlaQzBNcm4yL0d1ZXIr?=
 =?utf-8?B?Ykg2Z1UzU2YrSW0zQ2VINjJTdkZ4MC9SK2xFNnpLemhTcmF2VUsvMzFNeUFM?=
 =?utf-8?B?bVV4SS9qWlpKb1BaWmFmN0ZTT3RZRDE1b1h0Zk1EZnpVSGNMb3FwWDI0a1ZR?=
 =?utf-8?B?M3RMQk4rREVDSmcwbjFFVGxzckozVEpTbitxSkhLdFRXcm9FUmZuK0I0ek9y?=
 =?utf-8?B?QkhXMTFRZnh3amtrbHhYRkF2L094b0FqempGYVB1d2IxVjZmejdycWZGcTF1?=
 =?utf-8?B?NStiUHZnMXd4ZXYvK1VIMmlaRURMcjVoVEcwWlFkR0wwRU9XeitScUp0WWpJ?=
 =?utf-8?B?QjM3eG9CTWhxWWRCN3AvcnlSaFJXcSsyR3dmRUVxL00xRnlKOVRLQkRZSUdV?=
 =?utf-8?B?Ylh3Z1VCaDFvVFFzVjViM3lwOUsrS2IwVk9TN3lJd1VXQzh1WUpXb3Nla1Y5?=
 =?utf-8?B?OElDUTZJZnU0TkJHZ0pNOHEwbjhBL0lVdzNqVzQ1N2JmSVl3YlR4YWhtOGhN?=
 =?utf-8?B?QTh0U2lhZFFxYlFRdVRWeExUM3cwOHA5QmlMQ2FwSThsWFZUeW5wUFEydkd4?=
 =?utf-8?B?ZUJKWm1LZ0VHeEhUVGJCNmRkL0tGQ1ZkWVplYTJxbVBKSFJKVUNXSDFhV1Rn?=
 =?utf-8?B?K3JrRklwemNXTFZTYit1WVE0b1Z1WmxSQzkxQ2hCOGZtWW9maTlmU1JobkFp?=
 =?utf-8?B?eVdCZUIxenI3akI3dUZ4QnhpZHZLcld5MHFSRU0vSW8vL0hCZGtVQmhmMVZO?=
 =?utf-8?B?TkNpdWFlNHcrd3UvRzV4Vi9ldW85dUJuREFlRUNOcVhyZzRvSHJwOVZDcU1V?=
 =?utf-8?B?aklQdUZDN0M0dGEzblhBSTNhbS9LZVV5b1RoT1B5ckpnK2JUZCtKc0UwcHBi?=
 =?utf-8?B?c3p6UTd3WFJSdzZvUmRGUkdScGhMSVBZMUc5R2Iyd0NDQjltVFp6SVk2eGsw?=
 =?utf-8?B?cGc0SE4ySkZBUXZvTjlwVjdOUkhHeFlVWitqNmYrUmlPS0dJcFQzOHQ5WHQr?=
 =?utf-8?B?akJpWVFlUW9vZEUyM1l3TncvbXJGc3FOQVhsSTZTbW9ZdUdDejdPS0FneEVN?=
 =?utf-8?B?YlFGSDU1OGR2RElzcGt3andlM2NvYTdGTllYY1VzV1hkREtPTkdaQ0Y5VGZ2?=
 =?utf-8?B?akZnN3NiZnhWdkM3TnV4cVYxM0FLdzJLRjl5SWZUeDFZR1RwSEV4ckNzamV4?=
 =?utf-8?Q?H7YakgIEdV/6nMVDwQfFYPCtN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4D4032F8F66D3469F2F5E5942784EEB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4748.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13bf3c50-b6cc-45b3-5898-08dabc3abc23
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2022 18:56:07.6748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kB9jCCtb8kPJulGH5JYhtG0tiTZoK5PfrRdgtI6JkKhPC51Am/46M2pnJzgLq5PmXygpnzoC1DVyi9P5KP+Iqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7574
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpegoKT24gTW9uLCAyMDIyLTEwLTMxIGF0IDE2OjEwIC0wNzAwLCBMdWl6IEF1Z3VzdG8g
dm9uIERlbnR6IHdyb3RlOgo+IEZyb206IEx1aXogQXVndXN0byB2b24gRGVudHogPGx1aXoudm9u
LmRlbnR6QGludGVsLmNvbT4KPiAKPiBPbiBsMmNhcF9wYXJzZV9jb25mX3JlcSB0aGUgdmFyaWFi
bGUgZWZzIGlzIG9ubHkgaW5pdGlhbGl6ZWQgaWYKPiByZW1vdGVfZWZzIGhhcyBiZWVuIHNldC4K
PiAKPiBDVkU6IENWRS0yMDIyLTQyODk1Cj4gQ0M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKPiBS
ZXBvcnRlZC1ieTogVGFtw6FzIEtvY3prYSA8cG9wcmRpQGdvb2dsZS5jb20+CgpSZXZpZXdlZC1i
eTogVGVkZCBIby1KZW9uZyBBbiA8dGVkZC5hbkBpbnRlbC5jb20+Cgo+IFNpZ25lZC1vZmYtYnk6
IEx1aXogQXVndXN0byB2b24gRGVudHogPGx1aXoudm9uLmRlbnR6QGludGVsLmNvbT4KPiAtLS0K
PiDCoG5ldC9ibHVldG9vdGgvbDJjYXBfY29yZS5jIHwgMyArKy0KPiDCoDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvbmV0L2Js
dWV0b290aC9sMmNhcF9jb3JlLmMgYi9uZXQvYmx1ZXRvb3RoL2wyY2FwX2NvcmUuYwo+IGluZGV4
IGNkZGRkMmM3NzlmMi4uOTM4MDJiMjdmMmE1IDEwMDY0NAo+IC0tLSBhL25ldC9ibHVldG9vdGgv
bDJjYXBfY29yZS5jCj4gKysrIGIvbmV0L2JsdWV0b290aC9sMmNhcF9jb3JlLmMKPiBAQCAtMzc2
NCw3ICszNzY0LDggQEAgc3RhdGljIGludCBsMmNhcF9wYXJzZV9jb25mX3JlcShzdHJ1Y3QgbDJj
YXBfY2hhbiAqY2hhbiwgdm9pZCAqZGF0YSwgc2l6ZV90IGRhdGEKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBsMmNhcF9hZGRfY29uZl9vcHQoJnB0ciwg
TDJDQVBfQ09ORl9SRkMsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNpemVvZihyZmMp
LCAodW5zaWduZWQgbG9uZykgJnJmYywgZW5kcHRyIC0gcHRyKTsKPiDCoAo+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHRlc3RfYml0KEZMQUdfRUZT
X0VOQUJMRSwgJmNoYW4tPmZsYWdzKSkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgaWYgKHJlbW90ZV9lZnMgJiYKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0ZXN0X2JpdChGTEFHX0VGU19FTkFC
TEUsICZjaGFuLT5mbGFncykpIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY2hhbi0+cmVtb3RlX2lkID0gZWZzLmlkOwo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBjaGFuLT5yZW1vdGVfc3R5cGUgPSBlZnMuc3R5cGU7Cj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNoYW4tPnJl
bW90ZV9tc2R1ID0gbGUxNl90b19jcHUoZWZzLm1zZHUpOwoKUmVnYXJkcywKVGVkZAo=
