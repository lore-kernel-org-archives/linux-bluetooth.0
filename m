Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1037DC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 10:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B56A420786
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 10:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S314142AbhAZW7a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:59:30 -0500
Received: from mga04.intel.com ([192.55.52.120]:54518 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727036AbhAZVeJ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Jan 2021 16:34:09 -0500
IronPort-SDR: lr4mueA5UR4jwtrcbkhXYa+gif95OjzqRwjxPXq8yU5qAzaFFSu2qZT+MNVdfQceg8WQB8zCr5
 LRS8WItV+Hwg==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="177406686"
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="177406686"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 13:33:25 -0800
IronPort-SDR: m5TOsxvtv8i4q6LheXPj1GCyBPRPhr7r4L6nfZYMx16glqXXfe77AJtHEE6A/7fLr5lyP5dt2v
 JQ120Pted7mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="410297386"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Jan 2021 13:33:25 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 26 Jan 2021 13:33:24 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 26 Jan 2021 13:33:24 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 26 Jan 2021 13:33:24 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.59) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 26 Jan 2021 13:33:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkwRmkMRAS/RjriLYHMR5Vt49PQE+969JZI7qozmUJUYmdN8F8Etp2GTAFhqFoCdbq+5Kikt6x+JC/Guji8LqNjMcBPf8OULB85LbF/fqMTo0bmtvdJyx6K/qdMuie5EO50OAAe+xElChWJLp3+JW5d3G24CFY7N7uL619XYziDBoaKukP3h8MOEqIKYG+5dhMF13u+vjGYJxtGdrmnvxRffQ/F4oAWj2oUSJdWG9uu1IEgYSz/xkbz2NtJYQVWHQVurmVFkZrxwOunO+Z183umLLxuVazxXjNwIpC+yLsELQgnzfW3PzHONEcMX5ptEmRLg7AdSpU/anWYjKZx6NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJnm1cs82BCcX6G7wT817xwQPNpIBrQl+Oj/fIgrK90=;
 b=BmX7xzvOxOnE//m0/rT+wajk8wnXP6s5UYJQm1+mcxKbFCtW4M/xSgue24gCP57itZe3SEg9forGB668kUGvfdRTejhrwnMoaZcNxOvRTcqRJyBUN8VkWNEZ9EsBLPo7/mSe/xwQYuataCEkbn4XtkiUWj3aJQ4Axp7kCviHeWWxp6YgHmnHxzMrAgkqWgraRnoE2RbHmfBxoo3hA8dQ1wSg//NmU3gw+qd4UF5/CkkK+g3bHaKMe0+E822sMUkfiajp4d6cQTOZCGpRirFY6IdU8+zYwPRsRpUxCw7rL4alLsjkXjLwOYBHToEPzxMyVTQRInmU/LJbVzr+tp5imw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJnm1cs82BCcX6G7wT817xwQPNpIBrQl+Oj/fIgrK90=;
 b=pUp1Tms7acTf64oExIe9YqAWG5DLlq0oxaytwRlyczCGG7cIYpyUFB3OqA74+HbvSYFiLN16LHZGBf2z2sGkbVa7W++Bmoya18X/g7bQzZlhqiKXguF4fVFRXQvjJr35j541z53HaEdy9tQa6b2kAHTbPCEVrmbZv0TvqvKr0U0=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR11MB1981.namprd11.prod.outlook.com (2603:10b6:300:111::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Tue, 26 Jan
 2021 21:33:22 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::30c6:ea80:eabe:2aab]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::30c6:ea80:eabe:2aab%8]) with mapi id 15.20.3784.019; Tue, 26 Jan 2021
 21:33:21 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "marcel@holtmann.org" <marcel@holtmann.org>
Subject: Re: [PATCH BlueZ] ELL: Up-rev the ELL file list to version Rel 0.37
Thread-Topic: [PATCH BlueZ] ELL: Up-rev the ELL file list to version Rel 0.37
Thread-Index: AQHW9Crek2m3PxdImEOmsXRWK9r39w==
Date:   Tue, 26 Jan 2021 21:33:21 +0000
Message-ID: <cddd91d955531cb3268dbbd7cea5b6ddcfbb25db.camel@intel.com>
References: <20210114211322.328712-1-brian.gix@intel.com>
In-Reply-To: <20210114211322.328712-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 841daaed-3141-4ae3-87dd-08d8c2420163
x-ms-traffictypediagnostic: MWHPR11MB1981:
x-microsoft-antispam-prvs: <MWHPR11MB19811C98328FD611D18CA728E1BC9@MWHPR11MB1981.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zCIjLXUmxyujNCtAzV+pR9RduoH1CZfy/fkbIkHwU8xj2mal3j0gYnVhf2dRLnDk0EBK+9NjhKBqIZMd/0Y39AbUPKFdDexi6Js/IIfPG+i3plJNExLgQt+RoJiM7mPYMWfJHOpPnN1A6FmZzdKe3cm1bt7fM7Z2sc+E4oumTgMMYrnvFkJlZqZb6d60GgfQMopqsuUBLUz/LvAnSDHNHMv1yltQ7C0lYGxAG1S5BRK98WE5PPQgh4yz5Xx9ViEUqdhXwQB9jXZSZnZFi0sAWdlkqR4vBQ+Hvuav48l6ilbsZmaG2H+gZy02a75astDeDTOC3PoOF8/CJOYs5ZxzIEVZMy6QrtvExeGieQPeDnDB8mK+WIqNWEDosN3mHI/sRS2/C7CszC5MysrKoui6Y4Va2fdoS95qnzaOkMxXzuQVAOwR93DJQrFoTHvaKGQ8dmodGbAYAPgK6VcdnHvUHMVxm2mDSVWIrMGD/MSgp/hJbknDFjMwyv8RDkv6wgwHTIkLmQw7YVp2zY4+DbnLjg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(36756003)(76116006)(91956017)(8936002)(316002)(6916009)(71200400001)(6512007)(54906003)(2906002)(66446008)(66556008)(64756008)(66946007)(66476007)(86362001)(8676002)(4744005)(6486002)(478600001)(5660300002)(6506007)(186003)(26005)(2616005)(83380400001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SHo1N0hMbzVBZnhkVVpyc3AzUUhsQkNEUWlvaG0xQ1poK2hPcHl4K29YY0xK?=
 =?utf-8?B?cElmak9ubGgyc3UrR0NRcG5DdUQrZmExQ1lMdGs5aG8rMjB2WndML1R3ZzZ5?=
 =?utf-8?B?anFNWGYzVE4xRjVIaFBiU0dBOEJkL0hLRkhYM0RuN0JTQVcwUDU1bkwwK2o5?=
 =?utf-8?B?WTJNTU5BZUlNSm1aM3VvemF5TXU2U3p5TjNHK09YRUl1VERJMUs3UkRPRnFL?=
 =?utf-8?B?emYrcGJMc1lzQ2ZsRHBNK1NMOFJQZ0pYSXVGOTA0dG5raXpXS3pRd3pjd0ZR?=
 =?utf-8?B?WGJkN2ROOUxsaWszK2tpaXMyVWRhMnIrVlFrbmIyZ056S3V6b3hUQnpJajZ0?=
 =?utf-8?B?TDJZbkhpUktqTml2WTJ5TXBYWGYyZWtYdm4rVmJBMnVHdThSbDNkeVVCWi9F?=
 =?utf-8?B?RWZOU1F4WVdEQ3BiUnhnejNjM0FOU1U2a3JERDRMbEhhdnZwd1FkUllLcTQ1?=
 =?utf-8?B?bi91Wis4UGwrK1UySGNzOW5qa3hxVnZvUWZLMXdDU3BBMXRKNTNJVitodGdM?=
 =?utf-8?B?YUpTVWNycml4bGlkNksrL2FoSHhZUnM4MFBRdXRMUS83NjR1QVhtbHRmQ3po?=
 =?utf-8?B?MmorODIxRVh6dVgzNDBMT2lGMEFzcTdyK0N3eXJXOGtBZHpqQVRSZHNDekl0?=
 =?utf-8?B?a0RxQWhZRjBsb2paWTlVdEE1d2VGUXJ1eGh3aTUrU3ErQjZCVVl2L2ZmcTg1?=
 =?utf-8?B?cVFIaE52RmVRUDhVM045UlZuYkVxWHJFWXMyL1ZaaTdlUzA1aVZRM25Hd3V0?=
 =?utf-8?B?aTJwWnQyU1FrR0pwc3NnRDZqak9qNEtHSmJlNXJwYnpRR3JWdlo4ZDJxbUwx?=
 =?utf-8?B?ZlhCRzNJUmgrSnlBL0I3ZDRGK1pEY1A0REh0RFdManRkMGs0blRjS0FEZjMw?=
 =?utf-8?B?TVRRRTVUYjViR1FhL2xmQlpmNzRvSWZIbUhvUll6dGc5N29LeTVwaUtmd2Zk?=
 =?utf-8?B?c0dOclZiaXRxUWpGRk9oekJnNG5xMGx2OXRpR0VRQjk0RGZib1pRWFFOZ3dI?=
 =?utf-8?B?bjAxbDBDcllHMEFaUjgxZUdrcUlZUW9SVjNkZkZaNklHTm9KaURVb0FHYVF4?=
 =?utf-8?B?emJDaWJqbGJqUGJvSk5pSzlYRmdCWGFnWGtYMXErbjFZdHZoVTJZZERINmR4?=
 =?utf-8?B?RDVvV1VKeWxRSWM5a2NYeUpxS1g5ajE0ZmNkOVU2Q09aNmlDME9qZC9jSnpp?=
 =?utf-8?B?S01JMENIblp6ZXlWUzFyTTlDU3NuUGNpT2lpUUJWN2VGSGQydnEzdTNSL1RM?=
 =?utf-8?B?ZnFyMmhFRDRKUWJjS1hWTDdnT0RHQVhRVDBoS2d1aXlVTngxTmtaeUFOdEdL?=
 =?utf-8?B?bWNYZm94ZDU0NFhjWXVmbHJJTForUWhOK3F2NjNKVFNJK1g3M2NzbkZ1REFw?=
 =?utf-8?B?T3NpbVNueThCYjBqRC94VW1vRnZiaDEyM1B0anJNNzhHYUl1VU9JMEU1aDBS?=
 =?utf-8?Q?emuGy1Vq?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E480104EA3AA984B9D29B4F2429308DE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 841daaed-3141-4ae3-87dd-08d8c2420163
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 21:33:21.8949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qAlL+bREQkGCPLw5A0PFZaNBM04N8vvju0uqccHENzpq4ZSLErFbBQX2zgCxcpHQ+/MXfviQuaZEM29u4eKG1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1981
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBUaHUsIDIwMjEtMDEtMTQgYXQgMTM6MTMgLTA4MDAsIEJyaWFuIEdpeCB3
cm90ZToNCj4gVGhpcyBoYXMgbm8gZnVuY3Rpb25hbCBjaGFuZ2UuICBJdCBzaW1wbHkgY2hhbmdl
cyB0aGUgRUxMIGZpbGUgbGlzdCB1c2VkDQo+ID4gZm9yIHRoZSBzdGF0aWNhbGx5IGxpbmtlZCB2
ZXJzaW9uIG9mIEVMTCBpbnRvIEJsdWVaIGV4ZWN1dGFibGVzLg0KLS0tDQogTWFrZWZpbGUuYW0g
fCAzICstLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxDQo+IGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMo
LSkNCg0KZGlmZiAtLWdpdCBhL01ha2VmaWxlLmFtIGIvTWFrZWZpbGUuYW0NCmluZGV4IDk1OTE3
ZjY5NS4uODNhYzM2NDg1IDEwMDY0NA0KLS0tIGEvTWFrZWZpbGUuYW0NCisrKyBiL01ha2VmaWxl
LmFtDQpAQCAtMTM0LDcgKzEzNCw2IEBAIGVsbF9oZWFkZXJzID0gZWxsL3V0aWwuaCBcDQogCQkJ
ZWxsL2Jhc2U2NC5oIFwNCiAJCQllbGwvcGtjczUuaCBcDQogCQkJZWxsL2FzbjEtcHJpdmF0ZS5o
IFwNCi0JCQllbGwvcGtjczUtcHJpdmF0ZS5oIFwNCiAJCQllbGwvY2VydC1wcml2YXRlLmggXA0K
IAkJCWVsbC9wZW0tcHJpdmF0ZS5oDQogDQpAQCAtMTU2LDggKzE1NSw4IEBAIGVsbF9zb3VyY2Vz
ID0gZWxsL3ByaXZhdGUuaCBlbGwvbWlzc2luZy5oIFwNCiAJCQllbGwvY2hlY2tzdW0uYyBcDQog
CQkJZWxsL3BlbS5jIFwNCiAJCQllbGwvY2VydC5jIFwNCisJCQllbGwvY2VydC1jcnlwdG8uYyBc
DQogCQkJZWxsL2tleS5jIFwNCi0JCQllbGwvcGtjczUuYyBcDQogCQkJZWxsL2Jhc2U2NC5jIFwN
CiAJCQllbGwvdXRmOC5jIFwNCiAJCQllbGwvZGJ1cy1wcml2YXRlLmggXA0K
