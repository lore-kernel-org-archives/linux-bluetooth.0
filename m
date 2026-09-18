Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D1B466B00
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 05:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789710855; cv=fail; b=sty376g/ppEYr31YWk60+jfAkN1XC7hZKHsMh6WX5eI0sbt5eFBhcDaptibJF8EQ8QPoJenoOmbX3HO9vnk2UJbge+AXdzOwr8M4s4qa4i6lQnuT6HHn6P6iNcyL1ItNlCYiV9dm9ZJkNDCKumUjmqzg//DIs+WIY1UM4mNemyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789710855; c=relaxed/simple;
	bh=D8nukAicgOwOGW5h0B29IniaIanWngDzjLGukRHJJxc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q++fkzaLVnNaczRoN7Xo9jNkVoXoUTOuDLnG+lmtYBYkZ44FgpkaGaPMxyZVcThsysM6KtMBesMu77WNh4QW0u0yfi19rTHeiLEChdx5fTyGJFsSX2a8RpRJnHUuzHfwHw5xDR+XiUocix4FUMzj/aU5rHlPwHVMjyIN69AKnco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D404kYyQ; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D404kYyQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789710853; x=1821246853;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D8nukAicgOwOGW5h0B29IniaIanWngDzjLGukRHJJxc=;
  b=D404kYyQQlNxizV7/0QaJ9rfOG9dZgC4i9h8j+r7p3qExxx/rxvVMdyd
   MoN2+vDsz6x5st/KtRKqzuMp8Ieyc4FPXnyFNAd/fBAoRc0quSpOvs5cJ
   EwS67+CiZbu4vFW1Eka8IE5f7Un0QEmN9bM5PxAwHFenwyns+tH9kV0FY
   vslypryldYN4o4BrC6Nh+LMM7mP3GfG+fI0j9vxmgkCbsfWu8sWhKlLg8
   4SqErHwzhIJlzoVa9whXhIndcKILE87Fma7rRZRJJ1aGsKt2sEVo36Lcm
   vmOqNBYL26Ttr5ns2VxkjIjBH7qayBZT3eji1pFwjfbDzccHmL9O71Bf/
   A==;
X-CSE-ConnectionGUID: HIk9DaRtQzmQH0g0A4W+wQ==
X-CSE-MsgGUID: rYsjpvucTPStgv89k5jodw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="77758746"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="77758746"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 22:54:12 -0700
X-CSE-ConnectionGUID: odZGlmc9QG6Pv2EtkIhPeg==
X-CSE-MsgGUID: HWuQkwBbRiK9UFrZgJLHJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="267971509"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 22:54:12 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 22:54:11 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 22:54:11 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.21) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 22:54:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5zFaenXVuFU9TjWCr4FbPp8zpt3csTfzpMxCdANk59As7ieknZla4jwj5FfOvGGWAFXUjYjkvyt1cb6/k+jA9cOZLzBCPe+SSTSKmpCl7X4nnZ4qnKIuvq0NpS3MxUzGVzb+DvxWX94UR2ZbXeG+mOrmeg4C2V537mdR6fu31Qc8M7LTnQkRZDF1NYEPeKbDMUROW1fxQ3sM/YPBxPm0/EkxC3Au2EP5LFQuQiY937LMeq/zg/7r40tgt2IC7LaX2fcNDTHhziTHqakacejJ+NCPF2fS771sQRPyzt0FBKsUeVl1fqk5+cwiq60leU2PJQB0EBNA/hD5+PQ5huSMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8nukAicgOwOGW5h0B29IniaIanWngDzjLGukRHJJxc=;
 b=UU4rXut8Ex+AWwzLFmHq89SLx3HkG9DgfyVuFr+dSndLo6dIunECybBUtV6trUXzxNox2C1bNubJo/hAE7BxzMuTHlgE0F5VVrLnK7IYNA53V+QFGdeye8GBMaYDiiXVqdxs8DzJ00HtKvpYq56abEF6UoDOIiGUjPjb41N6GKGYolvzChp/WEej9qHdOvU+9P6LpwjtMW8UAuXqRfYUTkheu+JcM9sCyr0yGqWkERrdsYGLPanyz6n6xlTwM68akR/4YiRkDCum8e61fcfu2efhNJJx7nAmpCFqRhYcxbK31m0TvnElYdjYwaW3PjY6fee0wMlqQBSZApasUvbxeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7877.namprd11.prod.outlook.com (2603:10b6:8:f4::7) by
 PH9PR11MB006246.namprd11.prod.outlook.com (2603:10b6:510:414::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 05:54:03 +0000
Received: from DS0PR11MB7877.namprd11.prod.outlook.com
 ([fe80::e0c7:a964:df69:57ce]) by DS0PR11MB7877.namprd11.prod.outlook.com
 ([fe80::e0c7:a964:df69:57ce%3]) with mapi id 15.21.0406.007; Fri, 18 Sep 2026
 05:54:03 +0000
From: Ravindra <ravindra@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>, "K, Kiran"
	<kiran.k@intel.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v1] Bluetooth: btintel: read ROM debug registers on FW
 download failure
Thread-Topic: [PATCH v1] Bluetooth: btintel: read ROM debug registers on FW
 download failure
Thread-Index: AQHdRln2qHfiyTYDHUitZbbE80Sr9rbSPASAgAGZEsA=
Date: Fri, 18 Sep 2026 05:54:03 +0000
Message-ID: <DS0PR11MB7877E808AE10638834EC91F7DA872@DS0PR11MB7877.namprd11.prod.outlook.com>
References: <20260917040853.2719484-1-ravindra@intel.com>
 <2547d76b-98a9-4fc4-b240-d8cfb25cbffe@molgen.mpg.de>
In-Reply-To: <2547d76b-98a9-4fc4-b240-d8cfb25cbffe@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7877:EE_|PH9PR11MB006246:EE_
x-ms-office365-filtering-correlation-id: df596189-3111-4842-7ffe-08df15493e45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|18002099003|22082099003|38070700021|5023799004|11063799006|56012099006|4143699003|3023799007|10067099003|6133799003;
x-microsoft-antispam-message-info: VB8EGyCUwEmclB0HS9Wv8eWxjMUepJ2blXBZMLp5QBfP9wIX5BBAdl6+Aq6ct+8GVZM0SiTVKkH2DzDl95WQZpsOhJuhJn9afAmfup/NBo+9/Gchc2LiSjspJ2EABhEExg+j6cpS5c8Pkc6eaNN7qQEuabzsPLjxwhOnOfa5S4OZGH5lCc9OAjO637qEnJXy9EwE/R6eHeum180ecUbcGHpvI9XMFQUo2YHrFNM4ltLhulfhBTfw5adqoLP4Fj9pjiMXg7fwYgWXWaYE0nEpj9XLBpqkfYW7MP/8a1K5gDKbF1mmwHKyj41Bz8iZKrBfDWBl9b1wFNgjNj/Ilvq+SFSWsq0KiZIIXRaxAD6Ex6AANmtZPQjb2Fhw5PTtwgaHQgHDFPxsA39tFCg5xDNqsfxHvnp50KB675UsWnbz6W5aZgEbeugPzjVnSASmdpo97Hb6v7aOFzLsDEFGeHHtReNXprRD6R/4KarLnxDw6uY9hSi2vWdbBuylSx3ySgMXlL8s4jFAcxsKVkmV0+f+iWV35f8lycWaToqXTQ5ku31Pf8Fz9tmcBd3vWVsuS8Rwd7bj7QGG985ca22tFa20EerrqWeqKF59s6WVGF2NVEKjnQuVmd2bjBZifm1ykvkDkG75kPL+2OQsAQNUNoaPxdHBrnQJb1mvu+RDZrQNBweh+PIqB8VtdBwh2UdgCyhtahhhmwPR3KK+rTcR9kL2HQor8LGWLHSub+DUuaKri6Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7877.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(38070700021)(5023799004)(11063799006)(56012099006)(4143699003)(3023799007)(10067099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXg1N1RDTDZRV3pBQnRhSTZFcVdwTmJlQWc5em1XTEUrWmlaVDA2VDZwOUNo?=
 =?utf-8?B?TXQxTWFXOVVmYUJqOFYydFRjMkNhR3FtTU1OTHZDY3JmejNFRnpvRFhhQnJZ?=
 =?utf-8?B?Z05nWXZhOWRKRHNmUzdsMmNlTkVvcDEwT1EzWHpoWUxzMzNkVEtPU3ZvNEVC?=
 =?utf-8?B?TjFpRTYyNVA5VUVsUUpkbDlLTEFWVmZEZGx4b0tEMTFaTmZVYStrZnREdGlQ?=
 =?utf-8?B?SzVkeWV6MytkRHNQOFpscVRQVnFZYndmUUJPbm4vVmRRZm82NmRGeHp4TlFr?=
 =?utf-8?B?UHFhVDhSWmFRSVFjcWNncndlaUtxK2tUSkc1Z1V3aXpMdDU5S1BackFWMmxO?=
 =?utf-8?B?YTZsN1M1ZlI4RlpKNFdGUng3MzdKTk9ab2NycjBaQmZHSGtlK2wrZUxWQmNw?=
 =?utf-8?B?dkN4QUs1Nmp3VVNMUDFqZ1ZaWm12eEFoWlplZGJVbjNncVdLeWo3QUNFNVZi?=
 =?utf-8?B?dVJydzZQQTk1Zk1hUmlleGVaalNlOFkwb2c0RE1hZUZ6N2xFSGREaGsvS3pN?=
 =?utf-8?B?TTl2ZDE0TDZUYU9zWGc2SkM1YW96ZzVjUC85Vm94SkZpWFJGOHUwWlR6NmIr?=
 =?utf-8?B?bFRWWVBXSVV3Tm80aHhuM0Y3SWpSKzl4d0o4clUya0ZOc0k4QzhJRGxwNGVr?=
 =?utf-8?B?VXV1MVk5Mk9VWHd5RkFRMDRKTzR2anZpc3ljbEdhR3ZEZkJpZnFvL1JhTC92?=
 =?utf-8?B?VlJLUnA3ZUFnalJ2ZDAydjJMQncrN0haTWJVQ3dldEhDU2Qzakk0dHVVSitu?=
 =?utf-8?B?YTIyYjUwRGZndFRxOXNxUjdiZlM1S3Z2a2E0NVJSQU1mVlZ6Vy9QU0JzZU5S?=
 =?utf-8?B?bnd2bGhxYlN1eUhTMFZ1Rmc2REtUQjJ2eVNEaEg5QktrYnpBL2VhUVlVVWJS?=
 =?utf-8?B?TUd4OVZwMUw0M1c0YmlySURGM3dnUjhKTWhZQ2JzUG1qNWowSE1qV3RzTmM2?=
 =?utf-8?B?ZE1aWFJHbkY1eTRjeFI3VXpaTTVBVkl0RExYZ1p0YzVRN25sS3hRZFhtcmtZ?=
 =?utf-8?B?YlZPbzhjMnZIRHJhWXg5UlBSWU9IN09VeUJPeEVJNCszRFNrbmw1WExwVlp0?=
 =?utf-8?B?elRFN0tHY0VHTFd4cWhKTXk5TDduN042MXVnOW1ER1RhcHl1Z0Fnczd0b0sz?=
 =?utf-8?B?V2trZ2I5SVNFNGNKbk1idXlNR3J0VkxBU3VLNkpGM0xtSVgwTXc2OGV2dWI4?=
 =?utf-8?B?djNTSWFRVklxaWMzSHp6MmpRR0VnQjNtdTh2WitNY2dNamE4YmRFU3U1RGhR?=
 =?utf-8?B?WTdoeHQxNEV2SEVtQTd5SVJsb2JrOUpBZ2w4elBOSEdDN0J5M05TaXpFaXVG?=
 =?utf-8?B?MHBoeGtwU0s4RkZuRGJ1d1JMWXNCVjhwWGNJRHlTUWw4ZWNVUEpJSytBUW41?=
 =?utf-8?B?RnVKdE10VndCWlgyRyt3OEg3d3N5eFlpVE9CZnhqMytzWWlSTFkvTW1QVW4x?=
 =?utf-8?B?eEREem83RHZGSFZZcTh4QWFVNTJTNEQzSzg5Q2cvb1hkNGgxRUd1NFJyRkF4?=
 =?utf-8?B?VjQ0ZWo3QmpyTHdTVDd0Mm91NmJKZ0Nha1JTdmZ0cGZvTlFmS1lPMnFVZVdz?=
 =?utf-8?B?Y2YvbWg0eWV4dDFaaWRsZHNHbE9SazdvQmJMdGc1SkRRRkVWMUQyUkRJUmUz?=
 =?utf-8?B?ZGhMZk9jYndTeTl3RnhUMmhKU2tlNlZWbHl1Yk5UTWVlUDZSNThyeUo3TWhn?=
 =?utf-8?B?aGptbmRCS0o4dkZ5cUhYT013NENXU2UwVzYyYS9xT0dPOVEveGxwM0o2UCtZ?=
 =?utf-8?B?aTdsUENNckY5VE10WlQrNEIvMzFkTk5va2VuK25TT2lSSkk4THBJdWY3UXh1?=
 =?utf-8?B?NEIycUVIRnREMTVVeDJ3N1QvL0VOTGVKaTJjbXVaS250Vm1vMlZFSmVHMnIv?=
 =?utf-8?B?YmNlRUhxbm1uREFnZE5tN3ZCYmliMGZqejcwRkxnTDNxVjQxOTFvaGdTaDdH?=
 =?utf-8?B?QmxEZWtwUXMrYnY3QlpTZHkvUmpWU3hvNlZIV2I4c2RoM1RGYjJyeDdRcm55?=
 =?utf-8?B?YURoVTMxZzNFNTQ0TGJCVlJIMzFwOGlwWDhubVFRT2NlbVNUK1FmN0NxZnBH?=
 =?utf-8?B?RUcrL1c3UzZvbm53M2t2TkgzVDhjVUlDaE52QkxSZ1FqNGxkUWNMT1FCRE9k?=
 =?utf-8?B?allXRnkwdGlVSTFaS2NVZU1QdHBmaXV3SjhxMDdEZmU0YnZQT2tLY0l2dzRM?=
 =?utf-8?B?YW9jU3BhZGFZOGpHTXl4UmFtSWFUM1RFWU1ZQU9IS21GK29OVzJjUDA5alA1?=
 =?utf-8?B?dlY5NDBFbDhBV2l4dmJ2VTQ4ellyRkpmbmIwLzgvNTAyMTdhd3p5QnRPbUNL?=
 =?utf-8?Q?d70+1zh4IqrK327F5M?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Rb0sTJx3HaTo/1QUNPXMpVN1EB4n9GjBU4kglhLcCqgFhsz+f8rscNDX9N471VkMug8sJs+UZX82UcVg3jVCFROArHsF7lUl0P7BBEZZ5itmO7PAJ1yra38MXcTvZqiPs7/JBpT1qm95eCY7kET2YwQUDplGtkfbYhHJHVQZ/Du5BquqSdrEHL/HAQfr5Gw21Dzcl6OF+Y0KA2elE9iLF+Zv7C/8+LHjr7nlgUcDmJToEGrQYVTAhZZn+pre1Dh6XeooRKuQMKM1nmb7CfZW4Q352Q2K8GjGdcN41buibkqOYfR8FUm71W3JKtr3Q7IFMcgGJQ/pj2MQUK8FMBDxFw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7877.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df596189-3111-4842-7ffe-08df15493e45
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 05:54:03.1100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JRYaVlOrkj3VBVRRzfHzY8NZPXRIMDAq9deTsfXOL/YZPjEn8MQJFLP0asd1RxKqiAVV/+MBtsKOVLcXqJtZIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR11MB006246
X-OriginatorOrg: intel.com

SGkgUGF1bCwNCg0KVGhhbmsgeW91IGZvciB0aGUgcmV2aWV3Lg0KDQpJIGhhdmUgYWRkcmVzc2Vk
IGFsbCB0aGUgY29tbWVudHMgaW4gdGhlIG5leHQgcmV2aXNpb246DQotIEFkZGVkIGFuIGV4YW1w
bGUgb2YgdGhlIFJPTSBkZWJ1ZyBpbmZvIG91dHB1dCB0byB0aGUgY29tbWl0IG1lc3NhZ2UuDQot
IEluY2x1ZGVkIGJvdGggdGhlIGV4cGVjdGVkIGFuZCBhY3R1YWwgc2l6ZXMgaW4gdGhlIHNpemUg
bWlzbWF0Y2gNCiAgbG9nIG1lc3NhZ2UuDQotIFVwZGF0ZWQgdGhlIGNvbW1lbnQgdG8gdXNlIGlt
cGVyYXRpdmUgbW9vZC4NCi0gSW5jb3Jwb3JhdGVkIHRoZSByZW1haW5pbmcgcmV2aWV3IGZlZWRi
YWNrIGFzIHN1Z2dlc3RlZC4NCg0KVGhlc2UgY2hhbmdlcyBhcmUgaW5jbHVkZWQgaW4gcGF0Y2gg
Mi4NCg0KVGhhbmtzIGFnYWluIGZvciB0aGUgcmV2aWV3Lg0KDQpSZWdhcmRzLA0KUmF2aW5kcmEN
Cj4NCj4gRGVhciBSYXZpbmRyYSwNCj4gDQo+IA0KPiBUaGFuayB5b3UgZm9yIHlvdXIgcGF0Y2gu
DQo+IA0KPiBBbSAxNy4wOS4yNiB1bSAwNjowOCBzY2hyaWViIFJhdmluZHJhOg0KPiA+IFRoZSBi
b290bG9hZGVyIHJlY29yZHMgaW5pdCBzZXF1ZW5jZSBwcm9ncmVzcyBhbmQgZGVidWcgaW5mb3Jt
YXRpb24gaW4NCj4gPiBmb3VyIGNvcmUgZGVidWcgcmVnaXN0ZXJzLCB3aGljaCBoZWxwcyBkZWJ1
Z2dpbmcgRlcgZG93bmxvYWQgZmFpbHVyZXMuDQo+ID4NCj4gPiBBZGQgYnRpbnRlbF9nZXRfcm9t
X2RlYnVnX2luZm8oKSB0byBpc3N1ZSB0aGUgdmVuZG9yLXNwZWNpZmljIEhDSQ0KPiA+IGNvbW1h
bmQgQlRJTlRFTF9HRVRfUk9NX0RFQlVHX0lORk8gKDB4ZmNkZSkgYW5kIGxvZyB0aGVzZQ0KPiBy
ZWdpc3RlcnMsDQo+ID4gYW5kIGludm9rZSBpdCBmcm9tIHRoZSBlcnJvciBwYXRoIGluIGJ0aW50
ZWxfcHJlcGFyZV9md19kb3dubG9hZF90bHYoKQ0KPiA+IGJlZm9yZSByZXNldHRpbmcgdG8gdGhl
IGJvb3Rsb2FkZXIuDQo+IA0KPiBQbGVhc2UgcGFzdGUgYW4gZXhhbXBsZSB0byB0aGUgY29tbWl0
IG1lc3NhZ2UuDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFJhdmluZHJhIDxyYXZpbmRyYUBpbnRl
bC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2JsdWV0b290aC9idGludGVsLmMgfCA0MA0K
PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICBkcml2ZXJzL2Js
dWV0b290aC9idGludGVsLmggfCAgOSArKysrKysrKysNCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwg
NDkgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3Ro
L2J0aW50ZWwuYyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYw0KPiA+IGluZGV4IDk2NGQy
ZGUzMGU2NS4uMTUzNjZhNmI1NGM2IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3Ro
L2J0aW50ZWwuYw0KPiA+ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYw0KPiA+IEBA
IC05NjMsNiArOTYzLDQzIEBAIGludCBidGludGVsX3NlbmRfaW50ZWxfcmVzZXQoc3RydWN0IGhj
aV9kZXYgKmhkZXYsDQo+IHUzMiBib290X3BhcmFtKQ0KPiA+ICAgfQ0KPiA+ICAgRVhQT1JUX1NZ
TUJPTF9HUEwoYnRpbnRlbF9zZW5kX2ludGVsX3Jlc2V0KTsNCj4gPg0KPiA+ICtzdGF0aWMgdm9p
ZCBidGludGVsX2dldF9yb21fZGVidWdfaW5mbyhzdHJ1Y3QgaGNpX2RldiAqaGRldikgew0KPiA+
ICsJc3RydWN0IGJ0aW50ZWxfcnBfZ2V0X3JvbV9kZWJ1Z19pbmZvICpyb21fZGVidWdfaW5mbzsN
Cj4gPiArCXN0cnVjdCBza19idWZmICpza2I7DQo+ID4gKw0KPiA+ICsJc2tiID0gX19oY2lfY21k
X3N5bmMoaGRldiwgQlRJTlRFTF9HRVRfUk9NX0RFQlVHX0lORk8sIDAsDQo+IE5VTEwsDQo+ID4g
KwkJCSAgICAgSENJX0NNRF9USU1FT1VUKTsNCj4gPiArCWlmIChJU19FUlIoc2tiKSkgew0KPiA+
ICsJCWJ0X2Rldl9lcnIoaGRldiwgIkZhaWxlZCB0byBzZW5kIGludGVsIGdldCByb20gZGVidWcg
aW5mbw0KPiBjb21tYW5kICglbGQpIiwNCj4gPiArCQkJICAgUFRSX0VSUihza2IpKTsNCj4gPiAr
CQlyZXR1cm47DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJaWYgKHNrYi0+bGVuICE9IHNpemVvZigq
cm9tX2RlYnVnX2luZm8pKSB7DQo+ID4gKwkJYnRfZGV2X2VycihoZGV2LCAiSW50ZWwgZ2V0IHJv
bSBkZWJ1ZyBpbmZvIGNvbW1hbmQNCj4gcGFyYW1ldGVycyBzaXplDQo+ID4gK21pc21hdGNoIik7
DQo+IA0KPiBQbGVhc2UgYWRkIGJvdGggc2l6ZXMgdG8gdGhlIGxvZyBtZXNzYWdlLg0KPiANCj4g
PiArCQlrZnJlZV9za2Ioc2tiKTsNCj4gPiArCQlyZXR1cm47DQo+ID4gKwl9DQo+ID4gKw0KPiA+
ICsJcm9tX2RlYnVnX2luZm8gPSAoc3RydWN0IGJ0aW50ZWxfcnBfZ2V0X3JvbV9kZWJ1Z19pbmZv
ICopc2tiLQ0KPiA+ZGF0YTsNCj4gPiArDQo+ID4gKwlpZiAocm9tX2RlYnVnX2luZm8tPnN0YXR1
cykgew0KPiA+ICsJCWJ0X2Rldl9lcnIoaGRldiwgIkludGVsIGdldCByb20gZGVidWcgaW5mbyBj
b21tYW5kIGZhaWxlZA0KPiAoJTAyeCkiLA0KPiA+ICsJCQkgICByb21fZGVidWdfaW5mby0+c3Rh
dHVzKTsNCj4gPiArCQlrZnJlZV9za2Ioc2tiKTsNCj4gPiArCQlyZXR1cm47DQo+ID4gKwl9DQo+
ID4gKw0KPiA+ICsJYnRfZGV2X2luZm8oaGRldiwgIkludGVsIGdldCByb20gZGVidWcgaW5mbzog
ZHIwOjB4JTA4eCBkcjE6MHglMDh4DQo+IGRyMjoweCUwOHggZHIzOjB4JTA4eCIsDQo+ID4gKwkJ
ICAgIGxlMzJfdG9fY3B1KHJvbV9kZWJ1Z19pbmZvLT5kZWJ1Z19yZWcwKSwNCj4gPiArCQkgICAg
bGUzMl90b19jcHUocm9tX2RlYnVnX2luZm8tPmRlYnVnX3JlZzEpLA0KPiA+ICsJCSAgICBsZTMy
X3RvX2NwdShyb21fZGVidWdfaW5mby0+ZGVidWdfcmVnMiksDQo+ID4gKwkJICAgIGxlMzJfdG9f
Y3B1KHJvbV9kZWJ1Z19pbmZvLT5kZWJ1Z19yZWczKSk7DQo+ID4gKw0KPiA+ICsJa2ZyZWVfc2ti
KHNrYik7DQo+ID4gK30NCj4gPiArDQo+ID4gICBpbnQgYnRpbnRlbF9yZWFkX2Jvb3RfcGFyYW1z
KHN0cnVjdCBoY2lfZGV2ICpoZGV2LA0KPiA+ICAgCQkJICAgICBzdHJ1Y3QgaW50ZWxfYm9vdF9w
YXJhbXMgKnBhcmFtcykNCj4gPiAgIHsNCj4gPiBAQCAtMjQ2NSw2ICsyNTAyLDkgQEAgc3RhdGlj
IGludCBidGludGVsX3ByZXBhcmVfZndfZG93bmxvYWRfdGx2KHN0cnVjdA0KPiBoY2lfZGV2ICpo
ZGV2LA0KPiA+ICAgCQkJZ290byBkb25lOw0KPiA+ICAgCQl9DQo+ID4NCj4gPiArCQkvKiBGVyBk
b3dubG9hZCBmYWlsZWQsIGhlbmNlIGNvbGxlY3Rpbmcgcm9tIGRlYnVnIGluZm8gKi8NCj4gDQo+
IFVzZSBpbXBlcmF0aXZlIG1vb2Q6IGNvbGxlY3Rpbmcg4oaSIGNvbGxlY3QNCj4gDQo+ID4gKwkJ
YnRpbnRlbF9nZXRfcm9tX2RlYnVnX2luZm8oaGRldik7DQo+ID4gKw0KPiA+ICAgCQkvKiBXaGVu
IEZXIGRvd25sb2FkIGZhaWxzLCBzZW5kIEludGVsIFJlc2V0IHRvIHJldHJ5DQo+ID4gICAJCSAq
IEZXIGRvd25sb2FkLg0KPiA+ICAgCQkgKi8NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibHVl
dG9vdGgvYnRpbnRlbC5oIGIvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5oDQo+ID4gaW5kZXgg
YzAwZjc5M2Q5ZGM4Li5kZWRkYTNlNzc0ODcgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ibHVl
dG9vdGgvYnRpbnRlbC5oDQo+ID4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5oDQo+
ID4gQEAgLTE3OCw2ICsxNzgsMTUgQEAgc3RydWN0IGhjaV9wcGFnX2VuYWJsZV9jbWQgew0KPiA+
ICAgCV9fbGUzMglwcGFnX2VuYWJsZV9mbGFnczsNCj4gPiAgIH0gX19wYWNrZWQ7DQo+ID4NCj4g
PiArI2RlZmluZSBCVElOVEVMX0dFVF9ST01fREVCVUdfSU5GTwkweEZDREUNCj4gPiArc3RydWN0
IGJ0aW50ZWxfcnBfZ2V0X3JvbV9kZWJ1Z19pbmZvIHsNCj4gPiArCV9fdTgJc3RhdHVzOw0KPiA+
ICsJX19sZTMyCWRlYnVnX3JlZzA7DQo+ID4gKwlfX2xlMzIJZGVidWdfcmVnMTsNCj4gPiArCV9f
bGUzMglkZWJ1Z19yZWcyOw0KPiA+ICsJX19sZTMyCWRlYnVnX3JlZzM7DQo+ID4gK30gX19wYWNr
ZWQ7DQo+ID4gKw0KPiA+ICAgI2RlZmluZSBJTlRFTF9UTFZfVFlQRV9JRAkJMHgwMQ0KPiA+DQo+
ID4gICAjZGVmaW5lIElOVEVMX1RMVl9TWVNURU1fRVhDRVBUSU9OCTB4MDANCj4gDQo+IFdpdGgg
bXkgY29tbWVudHMgYWRkcmVzc2VkLCBmZWVsIGZyZWUgdG8gYWRkOg0KPiANCj4gUmV2aWV3ZWQt
Ynk6IFBhdWwgTWVuemVsIDxwbWVuemVsQG1vbGdlbi5tcGcuZGU+DQo+IA0KPiANCj4gS2luZCBy
ZWdhcmRzLA0KPiANCj4gUGF1bA0K
