Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC15C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jan 2022 19:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiAYTlH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jan 2022 14:41:07 -0500
Received: from mga06.intel.com ([134.134.136.31]:2796 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230222AbiAYTlF (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jan 2022 14:41:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643139664; x=1674675664;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Ja7A45vEladv/+06mSpG6tFBf6gH71fUT+dYhNBPxLs=;
  b=MaXuphxW84de9LzGz//W2jjC//vk7HEMyApaqX16xOToNjDmHO858kIl
   kWi7VZT2uK79LUSGaqKUlXFXUjIymYKHVGwIPmXMsaTyOlbs9iQ7K1RTP
   twblwHTyALneO5Or6bWDBbZJHuWzBYZJ41twxMUFym7gOTXTtqYYskbKM
   LwiYn8r366CiLqNbJ6QG72Rmwk8OgliaHLZ+LIJmrhIWyVzXwXyWA13h1
   OMotfp2Ey2/76gk/XVmyPgojwUk0QgSmuLLMG806adLFzQvMRn//7EkAB
   ywbPremN9VU4jyyn5kyLkh/a1Cjz6RyYSi/BG5J7QjEQkML6N6FzFDMjD
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="307114446"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="307114446"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 11:41:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="477235046"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga003.jf.intel.com with ESMTP; 25 Jan 2022 11:41:03 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 25 Jan 2022 11:41:03 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 25 Jan 2022 11:41:02 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 25 Jan 2022 11:41:02 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 25 Jan 2022 11:41:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erkobkk+SUOTEwk6MSDq+Pon5fIPD4d9MPpV0UGO++T095X5I/JkASitUyCRjA6ZDkZ7vww0+rflcyyo5bcic5quNIYgbWPhhf+mBosepcWDDh3cOjXMBbPb+3Be9UmTM5tDGq3xtbSDN5zunZixKAzxSr+tofWo1ZOYSOPvYstzV7zTu77fsw0XK4j2+BfM8oXyG21anz7N9wf2XSeDuR5mUTETClGJD6ZdxOFfYTAPGwhvKjHUNJs0uBrI8mUCZvY8ehrr5xCsGv9GykJMdKuBoKFts6hg8iz1GHQDqISInUpSnUJpeRVTgbLxVpiv5bRYZyRRkA43XBO9uD+NsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ja7A45vEladv/+06mSpG6tFBf6gH71fUT+dYhNBPxLs=;
 b=lwSepkikXghz7kUzgS/JBNYz0EodpgX6QsNFs0JphXaoggF5xlhMi5UnFDmVXEpfvIehNx282fnawjPwsBxkRX1ElEir1ux3apLnkJVpGMECKPHLjz+KgohuTfCHBGOnohZInWjhVz1xU2v2Rj2hqCjwvoP1/QP0Oq78hgrIU3e5fVkwiyxB5gou2X/x8WfOh6VlSfK+HCxpBtwpw/wZxIhL9MgX/5MoQTDYB882GZ95/PLWxxOFmqL0fCnzYbfWQTEoWvha220x7vJGqgWQcVOu5EPYeLF0UNuIzO+F26crJ8Wfz5DQl6BgddPbgJOoOkhr4AQohg2B9zS/ZMN1eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15)
 by DM5PR11MB2041.namprd11.prod.outlook.com (2603:10b6:3:d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.12; Tue, 25 Jan 2022 19:41:00 +0000
Received: from SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::5d0d:46b0:ffbb:54b3]) by SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::5d0d:46b0:ffbb:54b3%5]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 19:41:00 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "karl.westin@loytec.com" <karl.westin@loytec.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Bluetooth Mesh: Option to retrieve RSSI value from received mesh
 messages
Thread-Topic: Bluetooth Mesh: Option to retrieve RSSI value from received mesh
 messages
Thread-Index: AdgR/qveFxHMZltZR7KeA1FkQqvEPgAJM5KA
Date:   Tue, 25 Jan 2022 19:41:00 +0000
Message-ID: <586e79c74800693d1a21d06073503b41828f98bd.camel@intel.com>
References: <ZRAP278MB014417E1D86BB8D4E82A6174955F9@ZRAP278MB0144.CHEP278.PROD.OUTLOOK.COM>
In-Reply-To: <ZRAP278MB014417E1D86BB8D4E82A6174955F9@ZRAP278MB0144.CHEP278.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a461d98a-8e60-45d1-3d7f-08d9e03a9d4e
x-ms-traffictypediagnostic: DM5PR11MB2041:EE_
x-microsoft-antispam-prvs: <DM5PR11MB2041493DE68400D2C933E688E15F9@DM5PR11MB2041.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IhDCQOjOKgGjEuClfBA3DEdTYyJHMKT3GxFcjj9oW38E2hIJVE4RyjYfdk3ndS6gbyF6PMjJWpsxTaH+m9AYx6hgoguhS8tCkDg2MtaiqD7/R/O7j04WvANZ1eGalPLQk2h8pPIepQNu8HOIlLuYX5hlPgA0NORjgVnBA42S1yDbJHtmncnpG6Bp87RN+k4nsoUnhIKURTZxEMph7wCBn9uYik2u9Ms/AlvY69EJTMvz/qUiWfvoi9uxpc8yHVRyPgU2Ufv1OG4ayjtoPpuz7wp2+66o2IpmKFGkdoN+mgXr85+1jWumkx12SbVTl5lCYYCgRTM0fp2/dik0ceZMiX/2gjDuAjsbZFBqGABJciT4jeszUiStwWTlzaEIckUMeyjXKfEBneuUxu7XFoePsMKIjtCr96DFbp+WS7TAfaDgZfA18hCCOM7xRtjGEb8YV9Nrg6BCPQVW+jky7iwp1guFauvaOVzC7XLCofEAIkEU2HBz2gqhY0IdZ0KosoFmcF+Mg1OtNQzdIsOYmPBgbYIMQ2TSFlD5PuyKJ68Qndc6mBEoq3x3AdiUVDHC9ktdMEXGmJHo9PNIMSFNfS3qj9j/y359Fa3SA4k8iQqbmT6OvmK42lxNQfe+h6Dt5cuSET40MAIw27Uola7lax4yW0BiKK1m7u41CtrA0371FMBxIoBDGWMhlVXTanAvMLIeko8DZOrL/lZhsthxe9gdyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4526.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(316002)(5660300002)(66446008)(64756008)(2616005)(110136005)(36756003)(66946007)(6486002)(91956017)(83380400001)(38070700005)(15650500001)(86362001)(82960400001)(8936002)(76116006)(66476007)(122000001)(38100700002)(6506007)(508600001)(26005)(8676002)(2906002)(186003)(6512007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1pLWVFob2tWb3BVUS9lUXpReVBHUkM0U0tLRzJRVWFBeER6SHU5UGhEK2R0?=
 =?utf-8?B?MXE2b0d6czg0Q2JlTVNtTjd6MkRYNTV0MUIvYi9mUW9PclF2bmVWdmhyWjBS?=
 =?utf-8?B?TzIvdld4VjBFdythUUluc2JQSGJERWZHRFp4Yzl6TVFCTkpDdEJPV2N5REtY?=
 =?utf-8?B?YnZuUTNkU2E2SDNHVHk2RUpEYmQxNitpWk11eWM1S1JMWC9QaEpPTUdzU1c0?=
 =?utf-8?B?T3hydzY5Q1E0UXluRGQ0OVNZMk5IRU4zam82T3Evcjc1MzkwZGZDcmNCWWFv?=
 =?utf-8?B?RzlxNHNDSit4VDZObFJtdER3d1pZdXAvZllZczFIcHF4OWlzZ2RpakFyWXZ0?=
 =?utf-8?B?bytTM2pwY0kxOVZDN3M3QmsvUkpIb1ZNQW9jelc4eUVSVFJveVZaNzkxS3hK?=
 =?utf-8?B?K3oxeW53QUtxdUNaVmtaQkJtU1ByMDN4ZWRPd09ZS3cyTzNxMmR1Z01qSzlq?=
 =?utf-8?B?TU5LbFFJd0tXZDQybSsxM2Eya1pUTmt2VW5TMkhJYjZEdGRnSktHN0RmK0pO?=
 =?utf-8?B?VXprRVU3R0l4U3JMUlVxbGNCdWJVMnZ4TWFtODFvOEUybEFNZ0FUTkU0dE9T?=
 =?utf-8?B?QkJLRWFsMnpiTHN1bzVacEpFZ2l4SmF4TFZxWURPWTFmUlNUTXVpZWVzVXc3?=
 =?utf-8?B?dXkzSXp1K3lVNUNiLzg3enhHc05mUjdVYm11SCtxc2p5YW11WWtJQVE4NHRl?=
 =?utf-8?B?ZGd6TEtyd0FDcnhFaGMyWWlYMmZnTzM3M3BqYTlwZ0VuR3p1dUh3REduT2pC?=
 =?utf-8?B?VFhFeHZlN1VWL0hHUFNxd0pkZXhIaUdQaHJSNk54Um5JTnJyTlJFRjBkdFVK?=
 =?utf-8?B?NXQweDZTaERHUGxiSUV4Z0RUcWZIUUVXS0ZUSE9LRXQzazNLenZOZm02eElU?=
 =?utf-8?B?SUxtU2diU3QxSTJxY3o3SHJkYmNqeGc5bXQ2cVlsK3FqYSt3VUhuMk1PSUo4?=
 =?utf-8?B?QmFYYUh1TmNlUWZIaUJZWjZhT2NrTThJdnY4bWt0T01FRzlDTkRuZXRyeEFq?=
 =?utf-8?B?MmRZS0M2eGRjSElia04xZ2UrN09xWVlVamFVVytvZFhmaDgxaFVPWWEvZEcw?=
 =?utf-8?B?dmNPdjc4V3hveFp3RFgyQ1I0ekpWcm1VQVdiOFIxd25odUR0UkpTYjdlYUpn?=
 =?utf-8?B?MFQzODBmQldtQmtsQ3Zzc0o3TWhrNGpnSkl5TnNaL2ZmU2IrRHBrRnBqREZY?=
 =?utf-8?B?Mzhqc3R0akdjN0NoT2h2Mk9MeTI3MXJpR0VGMFAvc09YOWQzdkVwb3FTSkY0?=
 =?utf-8?B?NEdiWXkrNDFOM043OGMrR2d4NFVyVlZrNmxvZW1Gd0xOejQ4bG5nMk5aRnZW?=
 =?utf-8?B?dTREZVVoWVYzL05od3A3cDRiWGxBY3VpUFJnS1loeStFTXR5V081MlBCb0Ux?=
 =?utf-8?B?bUJjTWVxQk9tUmNWelYrZVVtUnU0eGVqeVV6MDhzbnluS1IxbHh1OFpiTFNx?=
 =?utf-8?B?dWkvUzdZNjBVQTQzSWtpU00yZ0lUeVJscHd4bjFwNFpBVUFyM1V1ZUZSOXp4?=
 =?utf-8?B?YjQzVGZtd3lhQmZkVC9lRnNpUzFtUHlVTTVxR3dlS1JPaDNoQldUeGFob2Jy?=
 =?utf-8?B?OTFWSllZTUVCRi9ROWRPbXlRTkhSTk1weU9HRmg0d0I2OFRjZGRwcm0rZjlh?=
 =?utf-8?B?dUwvS1FneXJIcnhPbjlUeFVWMDdsT1lXRXh2bkQ4VW85NnJzSFVQTU5wcC9x?=
 =?utf-8?B?dUNLZFEwS0FVSE12elE4NWs5RUFrdW5pOXUrd0VHdDZVcWNlZFQvTUtUQ3Zx?=
 =?utf-8?B?ZGtLa1dmVzdQOG93TXBuRnV5V1Z3NFRWcVlKVEJEZzRIcFZ2Zlh0K3diUnBa?=
 =?utf-8?B?YWNVeXBMamtrQzdPMmRQOFh6WmV6bXM2QUFjTFZWVDVLUUQ2L1hISmFjS3pR?=
 =?utf-8?B?Lzk1RzhHK2diSElDMG0zL2ZlVU8yREE1TkwzNjRMNGVNMURMK1pIMFkvZzFS?=
 =?utf-8?B?c1J4eVBRR2RiR3ZyUFRiajRQWWFUWGVxWVExcDB6VEpMWGhiU0VVd0M4S1R5?=
 =?utf-8?B?bEZ4RWFJeDRzV3g0SU81a1hVNnIyNW43V1VvM0hKZVlkMXJVbmxjOXJrK0JY?=
 =?utf-8?B?dDYvRStvUzRoQkU1OW15RXF4L0ZHdVBsN090TXNuS2dWY0Y0anV4MUtBWDFM?=
 =?utf-8?B?b1RTQ2J0QmEyUStab3MxWEdIeUYvQ0x2c1JmSndEN3huTndmd2IrcFlTTzUv?=
 =?utf-8?Q?4SYH725zuflnpejRjIKcH+4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DEA2D87436B2E54484416F0F2C941360@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4526.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a461d98a-8e60-45d1-3d7f-08d9e03a9d4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 19:41:00.0417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J2rlam2N5KhTt3MblPDQb+DZ4eP+txzmSvpqi6YRhhq9rMxPqBO9wY3AtLJF4TwbVUdtPrsTn1nYtzw8Wvb9DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB2041
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgSXNhaywNCg0KT24gVHVlLCAyMDIyLTAxLTI1IGF0IDE1OjIwICswMDAwLCBJc2FrIFdlc3Rp
biB3cm90ZToNCj4gSGkgYWxsLA0KPiANCj4gSW4gbXkgY29tcGFueSB3ZSBhcmUgYnVpbGRpbmcg
YSBCbHVldG9vdGggTWVzaCBhcHBsaWNhdGlvbiBvbiB0b3Agb2YgdGhlIGJsdWV0b290aC1tZXNo
IGRhZW1vbiwgdXNpbmcgdGhlDQo+IERCVVMgaW50ZXJmYWNlLg0KPiBXZSB3YW50IHRvIHVzZSB0
aGUgUlNTSSB2YWx1ZSBvZiBtZXNoIG1lc3NhZ2VzIHJlY2VpdmVkIGZyb20gcHJvdmlzaW9uZWQg
bm9kZXMgYXMgcGFydCBvZiBldmFsdWF0aW5nIHRoZQ0KPiBnZW5lcmFsIHF1YWxpdHkgb2YgYSBi
aWdnZXIgbWVzaCBuZXR3b3JrLiBBbHNvLCBlLmcuIHRvIGRlY2lkZSB3aGljaCBub2RlcyBzaG91
bGQgaGF2ZSB0aGUgcmVsYXkgZmVhdHVyZQ0KPiBlbmFibGVkLg0KPiBUaGUgUlNTSSB2YWx1ZSBp
cyBkZWxpdmVyZWQgaW4gdGhlIExFIEFkdmVydGlzaW5nIFJlcG9ydHMgdmlhIEhDSSwgYnV0IHRo
ZXJlIHNlZW1zIHRvIGJlIG5vIHdheSB0byBtYWtlIHRoZQ0KPiBkYWVtb24gcGFzcyB0aGlzIGlu
Zm9ybWF0aW9uIGZ1cnRoZXIgdG8gdGhlIGFwcGxpY2F0aW9uLg0KPiANCg0KVGhlIG9ubHkgbWVz
c2FnZXMgY3VycmVudGx5IHdpdGggUlNTSSBwcm9wYWdhdGVkIHVwIHRvIHRoZSBhcHBsaWNhdGlv
biBhcmUgdGhlIFVucHJvdmlzaW9uZWQgQmVhY29ucywgd2hpY2ggYXJlDQp1c2VkIHRvIGluZGlj
YXRlIHNpZ25hbCBsZXZlbCBvZiBkZXZpY2VzIHNlZWtpbmcgdG8gYmUgcHJvdmlzaW9uZWQuICBU
aGUgUlNTSSBtZWFzdXJlbWVudCBpcyByZWFsbHkgb25seSB1c2VmdWwNCmZvciBkZXRlcm1pbmlu
ZyBzaWduYWwgc3RyZW5ndGggb2YgZGlyZWN0IG5laWdoYm9ycywgb3IgdGhlICJsYXN0IGhvcCIg
b2YgYSBtZXNoIHBhdGgsIHNvIGZyb20gYSBwZXJzcGVjdGl2ZSBvZg0KbWVhc3VyaW5nIHRoZSBs
YXJnZXIgcXVhbGl0eSBvZiB0aGUgbWVzaCBuZXR3b3JrLCBpdCB3b24ndCByZWFsbHkgdGVsbCB5
b3Ugd2hhdCB5b3UgYXJlIGxvb2tpbmcgZm9yLg0KDQo+IElzIHRoZXJlIGFuIGVhc3kgd2F5LCB0
aGF0IEkgaGF2ZSBtaXNzZWQsIHRvIGdldCB0aGUgUlNTSSB2YWx1ZXMgZm9yIHJlY2VpdmVkIG1l
c2ggbWVzc2FnZXM/IElmIG5vdCwgd2hhdCBhcmUNCj4geW91ciB0aG91Z2h0cyBhYm91dCBtYWtp
bmcgdGhlIGluZm9ybWF0aW9uIGF2YWlsYWJsZSBzb21laG93LCBwZXJoYXBzIGFzIHBhcnQgb2Yg
dGhlIERCVVMgbWV0aG9kcw0KPiBNZXNzYWdlUmVjZWl2ZWQgYW5kIERldktleU1lc3NhZ2VSZWNl
aXZlZD8NCg0KQSB0b29sIHRoYXQgbWVhc3VyZXMgdGhlIHNpZ25hbCBzdHJlbmd0aCBvZiBlYWNo
IGhvcCB3b3VsZCByZXF1aXJlIG5vdCBvbmx5IERCdXMgQVBJIGNoYW5nZXMsIGJ1dCBhbHNvIGEg
VmVuZGVyDQpzdHlsZSBhcHBsaWNhdGlvbiB0aGF0IHJlc2lkZXMgb24gZWFjaCBub2RlLCBhbmQg
Y29sbGVjdHMgbWVhc3VyZW1lbnRzLCBmb3J3YXJkaW5nIHRoZW0gdG8gYSBjZW50cmFsIGRhdGEN
CmNvbGxlY3Rpb24gcG9pbnQuICBUaGlzIHdvdWxkIHJlcXVpcmUgY29udHJvbGxpbmcgdGhlIHNv
ZnR3YXJlIG9mICpldmVyeSogbm9kZSBpbiB0aGUgbWVhc2ggbmV0d29yaywgbWFraW5nIGl0DQpp
bXByYWN0aWNhbCBmb3IgYW4gZW5kIGN1c3RvbWVyIHNldHVwIHRoYXQgaGFzIG5vZGVzIGZyb20g
bXVsdGlwbGUgbWFudWZhY3R1cmVycy4NCg0KPiANCj4gVGhhbmsgeW91IGFuZCBiZXN0IHJlZ2Fy
ZHMsDQo+IElzYWsNCj4gDQoNCi0tQnJpYW4NCg==
