Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0681309F09
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 09:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778579415; cv=fail; b=BHlkL/lkZbrXabt7WgRdmKA0+3MmR8kF71tt9xkmaXSlsujKHcqfToTWgLPB2hNDBVOIdwVrGgHY59tY/PAES/9gFvXVpRVpwwyfKJvZR33q4lOYrMSMJWAZqG+TSvw4lKBwzlTW9q6nHaP/MGs0eL0kVAPXtsFdFqc5D5J05do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778579415; c=relaxed/simple;
	bh=ewzcRLXrO64jiRh27FYVW3C2DKSH5pUvBgqh4Wf/kEg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VlAtB0WxzEkQJkA5TAaswkbDbicHdu8IHyxqjnQEg6HuVH9a87GO6iq49jNtN8tTpDP/dd9rpOw6OYmBDfqWLIn1ZHX8tkQpyl6f2nXIT9h/SkUZkIPfpOKcZAUX8Pv3NMs7bdbUuYGUSxGxjYqvmE3L0e+Q/fpZy0SedeuMBZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yi4Ww8il; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yi4Ww8il"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778579414; x=1810115414;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ewzcRLXrO64jiRh27FYVW3C2DKSH5pUvBgqh4Wf/kEg=;
  b=Yi4Ww8ildEcbfX0D+K2JEwFgt7283V9j8k/8dhG+MaVdn5RpoGWJzfXB
   Z0aYo2IFieBtMES0RtkC5D29uNldoTNq4yzmJEtq69loJw7/IZZff7nev
   RtSpMu+xSrVNsah4p/jBOHczsWRKtTKtFuvTxXWSvbrjxe7VLiogpYQX2
   1k09jOh7BosPwYH7oWXWrPBEA6KtepVN1qTnKpCSRvWZbXmTweCvGliL5
   76GEovXFgTHVvJyrR3SSN/Mm4xqZRV462RDPKEDw8wYh4qyOLpLqVQqM0
   iAEhXpaOXumaZcAdeQUWZ3mLelyFqm968vPiVpXj+gio8ktM1kpLKAM7Q
   g==;
X-CSE-ConnectionGUID: YnsLWkBhSKquS8ndK34mgQ==
X-CSE-MsgGUID: J0DlI4YgQ0a/W9ET3iMo2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="67013587"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="67013587"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 02:50:13 -0700
X-CSE-ConnectionGUID: wZ90T3JQTx2qKJzX5vleTw==
X-CSE-MsgGUID: IW8Kf5SoS5WyPMelOyfZJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="234667119"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 02:50:13 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 02:50:12 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 12 May 2026 02:50:12 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.27) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 02:50:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PhVeEp68BkACKjMPP9Od34ugbS3LoJHEpWuUKEqDenMN2fxk62LsrgZIO9G9Bj9LNp02bXTnMWkcQlRSjcxp8foGQAZKHgDW++QRsbI13FvfzevAZWl5OYKGNcdhl2mKI9bt9fVJjrxgtPMlunf5vd9ippkATifwQBpl1lr0C+rdvYtGJruYoaCgbl+BFP1yyEoKMeXNe8L8SM2zbptmTBb4tlKJM66fJrdSK39i7EhguNIYQotL+cRjf8G0qppvdd0qxFiItsC/wSPz5grK0t6DvjIOxAzZlM9vyeTlpfI+AeHiw6uI+4CbiXnEV2LWcMEGPY7D3Jb2yIMK29Bx7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewzcRLXrO64jiRh27FYVW3C2DKSH5pUvBgqh4Wf/kEg=;
 b=ZDEK+QnRtCtc9/ae4OuRLkLbNz4I1WpXgEWm/dYdsf01etTnWMFf3DDZgHNlQxE2nAs9uavTwnrvIpEMyQntsZMoiXa+WVOt8imA4KKBDaWzzEA5+BH7m4TnGSgb7dxyQlp3AR7y4VRI5Y/jnvRqGhflhFWsncOP2W1bYQIRiO7VisUBGtYnhTPEpoAIOh+4e8mQwb3lEL21v26MXkkBKacr15Ez+a4b+EZgQNOJb+u3pmKlKXBdd0oK0fgwkkraoOBE8s6WL0pTQbJiz9XimCI7HXCHeLiOP3othgEh7yqOMe5Rz0hVZP00ra56O0wqDvQy1Z+9jDhbm0vxsHO4Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by CY5PR11MB6344.namprd11.prod.outlook.com (2603:10b6:930:3b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 09:50:05 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::3e58:d5d:4e05:885e]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::3e58:d5d:4e05:885e%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 09:50:05 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, Aluvala Sai Teja
	<aluvala.sai.teja@intel.com>
Subject: RE: [PATCH v1] Bluetooth: btintel_pcie: Reset controller before
 configuring MSI-X
Thread-Topic: [PATCH v1] Bluetooth: btintel_pcie: Reset controller before
 configuring MSI-X
Thread-Index: AQHc4UdKhzn/CRJJQEy6tj5CaOBqHbYJTM4AgACoYUA=
Date: Tue, 12 May 2026 09:50:05 +0000
Message-ID: <PH0PR11MB75857CC2718A15E5F1212ADFF5392@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20260511132711.1216139-1-kiran.k@intel.com>
 <58a3bb31-a730-49b1-9c80-930f4099b0e8@molgen.mpg.de>
In-Reply-To: <58a3bb31-a730-49b1-9c80-930f4099b0e8@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|CY5PR11MB6344:EE_
x-ms-office365-filtering-correlation-id: 7dd92aaa-35b6-496d-8281-08deb00bd845
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|18002099003|56012099003|22082099003|11063799003;
x-microsoft-antispam-message-info: n8Phjek0bjVt5yLznYPfry13tNaY8/4gLdlD5AIMYvxqwOP1ufO8OdFIX/CfZyFBSiYbAoFB/Q1wBUaVJiHXj9/HNAHnzEWzV2lbN1mEXh+e93bS7uq29ohTrL6cb+e2sQzWWzMSlE6J84OGgPFvfwKjBv39/qwVq0gw2RVe9B1IjS2H49gZEwLqQUFExqmpF9lFyUaFgRwaTlpJsGcatuJUsdHtiJBieKicTX7ybIATkDKC0goEl/NABB/QA1JpootV+2JN5AC8KH6aAvIV+qlomHJuI21pVAo8j428W8Ci/+YRbTiGwxINnwW3WABNU1cE6Xe+m3C/En5jwt0mIm5y92I7g8YF+1/bzYqH7bsVaolwqWRp6R1F64A66Pl2EHPcW93dbPHmQXALpRJrxfhCAixrAgUjblko1+6lT6JK+IEZ4lnOGmwfGXj9cnDSQTJjzaaLHRCPjrEvCalRMiHu+nQ09ncFSnBl/uomQOfE0CuUPqQgbzeslWV/P3WoFEgMtKCNBjl44xjffcGSnGfgB1sR78KridGbjwIV3+q8Kn1BSpZi+JmgS0dWvtpgjndWiYad/3RtQlgafAh9PRI09phr71kJw6Ie1b0WZtO7Zta0s4GOt+gG9o32bsjLufY5mpbVNpPMvntpkE7QreGz3IQ8/QC4Mqj5Fhvw+mtXQpkPZKC+XQLPCfQmSE2dnd9mnxlMrNVSaL/354YDuQvFr/scysLSfsZ5IpPVEGf4EfZD3b4BJBvZist4NuuB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(18002099003)(56012099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGlzRUhqNnZVS211YzJWUHBxaVJ6SHhEOFYwSXdHaGZ5eUxTc204a1IydE4y?=
 =?utf-8?B?bUR5akRUbDhNTHphUVdLanZiQ0dKcUJCUnR0Smx5dXFNcG8zWm9oV1NLaVpu?=
 =?utf-8?B?VVZGdXB3dU9WNUJSMVRlcU16UlhnNmJDWVhmQVhSQzIyT0k2enBGQlZMYmM5?=
 =?utf-8?B?YnN6amY2U2Q2YW9YbXNkZXhMZFppUmFrWXZyRjJkTkF2WWRraW5Od1F5N1Jq?=
 =?utf-8?B?ZFNUWktncnNWOVJvOEEweXpsRXMzRklCRmVDeEk3bnpCdWRXMDVLQzhJQXcx?=
 =?utf-8?B?ejJSeXljOTFWZStYOEp0T2UvZGV2cWl4SWlnOEpLUUdCZGRONnM0elhXNFlT?=
 =?utf-8?B?ZGRKWFpSeUltVUpDL0RJMHVLbFFlQ3J6RW8wVk1XbTlaVE9aVGQxUW5ieisz?=
 =?utf-8?B?M0FKUFduc0hOdkpKa0M2bEIvWjdDNGxrMmZIcVBJMTlCcW5abzJ4cFNUYzBo?=
 =?utf-8?B?RDNnby9nK3hJbVR0Y3NsS0hpLzV3SXNsN29oSTlBS0ExK2dYdXRNcXlSN2pl?=
 =?utf-8?B?ekdTWEpzTUlsTmNvb3llNkJVQ0wwdm1rWmpTU0VFZ2dhU3NESEV1QnArUVpS?=
 =?utf-8?B?a0J6dE1wV0kvSHVad2dsbytXVXZIYjRKb3ZNakdqSFJmL0hqU25sMFRVOFd4?=
 =?utf-8?B?N05SS0NDZnY0UFlDa2x1K25la3ZNVFBPRTBLd3B0Tk1iS2JrMVBtQTdBc1c0?=
 =?utf-8?B?YXQyNGtheHptNnp3WGsrZ1J3cGFKYTlBbDg0S3FtSHpCVkxUd0dPUlR2Mm5a?=
 =?utf-8?B?QzJjMEwyVWRyYnZhOVZLdDZmYVoxcXhUYmh5VHBuWmMwUUttcHN6TG9uNmR5?=
 =?utf-8?B?cFFLUmZIa3EyMW5rVnpQOHBGTXBxMUVhZkZ1NXZxTHNqdVMyWVlNbjRMUGMw?=
 =?utf-8?B?MVVOQTBxaksxeHVWMmxISktZdm5vMUdLbmtPWHRRd0M2ek04RWE0TkgreFo5?=
 =?utf-8?B?SEphMm1DeTRDa240N2g5QzNhYkRGd2YxNXlPMVdYdzQvaFlBZGJ6UTJRcWdV?=
 =?utf-8?B?cnkyVm53OW9YSmZnK25UYVpFTGhvcHNLTGd1OHoxQUpFNVQ3cjJ2VEkxL0o2?=
 =?utf-8?B?OTlqRmpCMzNyODB0aDFUWDg5cU0zeFRab2tlYWZEV2Nub0dmeGlzZkRHdW04?=
 =?utf-8?B?RnBWVmVReENOWjFXZEMrRCsrTHZacUZmUDltT21qRTV2aTErVmlxMFdPbXl0?=
 =?utf-8?B?Zy9QWjJZd0tSMWtIbFhnaFREeFdPK2ZJUisvam83Vk13YldLZ0dZeWFTWDdE?=
 =?utf-8?B?dmVZS09DNGpsUFVYN2pSaVdoODdjSzN2M3pmbFlkd09MUmdGdXhvL0VzU1F0?=
 =?utf-8?B?ZUJHU0Q5b1NpNVlkcWJ1NTJUK2ZGQWl2ZGpYVzZidE5GZVVNL053Unh6YW0r?=
 =?utf-8?B?dnNycHoxU0dRQ3BMd09OZDh6OWpHTHhZc2NGQkJYZkxZVVNwVjhlVFZERkNr?=
 =?utf-8?B?MWpDT0VLdG5kenRxaDZSOStkOHBraW50eGZ4QzlqbjdJUnJJWnVsOGR2TDBU?=
 =?utf-8?B?VEU5dmNnMllmWjdKeVZWMUsyVmhoNE1zQ1NTSldvbEdweGZWNVNqa2xBOEhV?=
 =?utf-8?B?aGJoajV5MXVOVXZOd3NpWHc4Nm8xTXAwM28zakh0VFpvdms1SGtLRG16UkVD?=
 =?utf-8?B?bGlSL2ZKZGpuZWtvdDdsa1ZMSXpjbVd6S2NjWUpWU2JPWnhsaUtqRjVtUEpi?=
 =?utf-8?B?ZDBIZW9uYjRvQkVwYnNhQ3lVeWhGcERvTk0xV0sxWW1YSGx2NVYzbWZLc2Iv?=
 =?utf-8?B?K25Xc0R0K1FYSWQ3YUdkRU1ad0N2ZE5tK2YyMWMwbVVWVlpvN2RYRmV2ZElQ?=
 =?utf-8?B?Z09rYWRyWnliMnVqZ2c2ekJJRzhGQlhla1QxZmpzVUNHS1NUTFZ5ZU9pNlZM?=
 =?utf-8?B?dkE3SWdkVVVtdGRRWjRVMUxRMzdiL1diTTVXWHByQXVkLzB4Wk9sVW9aUWlN?=
 =?utf-8?B?TndNeVNLZnhzZnJsT3NRbjFrSTV4OGZVRGRCcXF1bWlvdHMxN2lXZExDM1hB?=
 =?utf-8?B?UnNjUVFZbjQ4aHc1eWtmbEZqZW1XSDl5WDBUWGZoVU4xVkI3VDg0TnpWazgx?=
 =?utf-8?B?STFwbi9DbHk1QUlkaVBUVWJ3ZHBMcEJsTkhxWmdXY1NJUkhiR3ROYTJEa1VH?=
 =?utf-8?B?MFdoWHVLWE1icVZMaEsxREF2K0RGWmZjU0dUcmxwbHNId3lVaksvL2ZIQ3Jn?=
 =?utf-8?B?UUVIRmQvZ04wS3ptNDRUaGUvamdQTitNN1lNQTBNRDg5TkdaWWQvaDVFcmxO?=
 =?utf-8?B?MDRIRTNtS3ArZGZwa09UTDhTYmFVNkNKL1U2R0hUMVNhdGRSTXhIK0RRcFV4?=
 =?utf-8?Q?wjQgRmg3k468suJTCx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: taNCqORktHDWm/eN0vmBaNVSanCr+r+itZFr7frEEW2iTazAA6zVZSUKHVBmw1j0kR0irxRGcuQzukbFp75TIPENV+bncuM32Mb2XsIYBIX7L2YvphhN1wmY66nEyU5U8ttiJ8vFoEsBspyR2wzO76ssx/LaMjxiHAx6H3wGBeBWwFLbcWS7Kl8EDlMW0p+IG03a+29Y/Hb6hm1c5CL0tDx1wOaqIZuiuHfL7JvCPod+iykU98l9R5iAzqX+oo5u4jXJ5ZTBJzYkPPPjiLqKu7iXIYXAj52c7+in+EV9AMXe6GPcNry+9wrwPFxwjUoeQHorjwHOclUjQuCb4bF9Ow==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7585.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd92aaa-35b6-496d-8281-08deb00bd845
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 09:50:05.2454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nPvhSQnICY6GM7blIvkoyKEgORaob8fdIH+Adc9w+q/kR9oshf8m6U3HEC504xW/CXlwWW0PTrZFntv/l1DVIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6344
X-OriginatorOrg: intel.com

SGkgIFBhdWwsDQoNClRoYW5rcyBmb3IgdGhlIGNvbW1lbnRzLg0KDQo+U3ViamVjdDogUmU6IFtQ
QVRDSCB2MV0gQmx1ZXRvb3RoOiBidGludGVsX3BjaWU6IFJlc2V0IGNvbnRyb2xsZXIgYmVmb3Jl
DQo+Y29uZmlndXJpbmcgTVNJLVgNCj4NCj5EZWFyIEtpcmFuLA0KPg0KPg0KPlRoYW5rIHlvdSBm
b3IgeW91ciBwYXRjaC4NCj4NCj5BbSAxMS4wNS4yNiB1bSAxNToyNyBzY2hyaWViIEtpcmFuIEs6
DQo+PiBGcm9tOiBTYWkgVGVqYSBBbHV2YWxhIDxhbHV2YWxhLnNhaS50ZWphQGludGVsLmNvbT4N
Cj4+DQo+PiBQZXJmb3JtIHRoZSBzaGFyZWQgaGFyZHdhcmUgcmVzZXQgaW4gYnRpbnRlbF9wY2ll
X3Byb2JlKCkgYmVmb3JlDQo+PiBjb25maWd1cmluZyBNU0ktWCBzbyB0aGUgY29udHJvbGxlciBz
dGFydHMgZnJvbSBhIGtub3duIGNsZWFuIHN0YXRlLg0KPg0KPkRpZCB5b3UgcnVuIGludG8gcHJv
YmxlbXMgd2l0aCB0aGUgY3VycmVudCBvcmRlcmluZz8NClllcywgd2UgZm91bmQgaGFyZHdhcmUg
aW5pdGlhbGl6YXRpb24gaXNzdWUgZHVlIHRvIHdoaWNoIF9wcm9iZSgpIHdhcyBmYWlsaW5nIGFu
ZCB0aGUgaXNzdWUgd2FzIHNlZW4gb25seSBpbiBzaW1pY3MgKHZpcnR1YWwgZW52aXJvbm1lbnQp
LiAgVGhpcyBoYXBwZW5zIGlmIGhhcmR3YXJlIGlzIG5vdCByZXNldCB0byBib290IHJvbSBtb2Rl
IGJlZm9yZSBpbml0aWFsaXppbmcuDQo+DQo+PiBXaGlsZSBoZXJlLCBtb3ZlIGJ0aW50ZWxfcGNp
ZV9jb25maWdfbXNpeCgpIG91dCBvZg0KPj4gYnRpbnRlbF9wY2llX2NvbmZpZ19wY2llKCkgYW5k
IGludG8gdGhlIHByb2JlIHNlcXVlbmNlLCBhbmQgcHJvcGFnYXRlDQo+PiBlcnJvcnMgZnJvbSBi
dGludGVsX3BjaWVfcmVzZXRfYnQoKSBzbyBwcm9iZSBmYWlscyBjbGVhbmx5IGlmIHRoZQ0KPj4g
c2hhcmVkIEhXIHJlc2V0IGRvZXMgbm90IGNvbXBsZXRlLg0KPg0KPuKAnFdoaWxlIGhlcmXigJ0g
YWxzbyBzb3VuZHMgdG8gbWUgdG8gc3BsaXQgdGhlIGNvbW1pdCBpbnRvIHR3by4gQnV0IHlvdXIg
Y2FsbC4NCkkgd2lsbCB1cGRhdGUgdGhlIGNvbW1pdCBtZXNzYWdlIGluIHYyIHZlcnNpb24gb2Yg
dGhlIHBhdGNoLg0KPg0KPlBsZWFzZSBhZGQgYSBwYXJhZ3JhcGggaG93IHRvIHRlc3QgaXQuIChN
YXliZSB3aGF0IGxvZyBtZXNzYWdlcyB0byBsb29rIG91dA0KPmZvci4pIElzIHRoZXJlIGEgd2F5
IHRvIGZvcmNlIGBidGludGVsX3BjaWVfcmVzZXRfYnQoKWAgdG8gZmFpbD8NCj4NCj4+IFNpZ25l
ZC1vZmYtYnk6IFNhaSBUZWphIEFsdXZhbGEgPGFsdXZhbGEuc2FpLnRlamFAaW50ZWwuY29tPg0K
Pj4gU2lnbmVkLW9mZi1ieTogS2lyYW4gSyA8a2lyYW4ua0BpbnRlbC5jb20+DQo+PiAtLS0NCj4+
ICAgZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmMgfCAxMSArKysrKysrKy0tLQ0KPj4g
ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4NCj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuYw0KPj4gYi9kcml2
ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuYw0KPj4gaW5kZXggZmRhNDc0NDA2MDAzLi42ZmYw
OGRlOWVjNzggMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUu
Yw0KPj4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmMNCj4+IEBAIC0xNjQ2
LDkgKzE2NDYsNiBAQCBzdGF0aWMgaW50IGJ0aW50ZWxfcGNpZV9jb25maWdfcGNpZShzdHJ1Y3Qg
cGNpX2Rldg0KPipwZGV2LA0KPj4gICAJaWYgKGVycikNCj4+ICAgCQlyZXR1cm4gZXJyOw0KPj4N
Cj4+IC0JLyogQ29uZmlndXJlIE1TSS1YIHdpdGggY2F1c2VzIGxpc3QgKi8NCj4+IC0JYnRpbnRl
bF9wY2llX2NvbmZpZ19tc2l4KGRhdGEpOw0KPj4gLQ0KPj4gICAJcmV0dXJuIDA7DQo+PiAgIH0N
Cj4+DQo+PiBAQCAtMjY1OSw2ICsyNjU2LDE0IEBAIHN0YXRpYyBpbnQgYnRpbnRlbF9wY2llX3By
b2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LA0KPj4gICAJaWYgKGVycikNCj4+ICAgCQlnb3RvIGV4
aXRfZXJyb3I7DQo+Pg0KPj4gKwllcnIgPSBidGludGVsX3BjaWVfcmVzZXRfYnQoZGF0YSk7DQo+
PiArCWlmIChlcnIpIHsNCj4+ICsJCWRldl9lcnIoJnBkZXYtPmRldiwgIkJsdWV0b290aCBzaGFy
ZWQgSFcgcmVzZXQgZmFpbGVkDQo+KCVkKVxuIiwNCj4+ICtlcnIpOw0KPg0KPldoYXQgaXMg4oCc
c2hhcmVkIEhXIHJlc2V04oCdPw0KU2hhcmVkIEhXIHJlc2V0IHJlZmVycyB0byBpbml0aWFsaXpp
bmcgaGFyZHdhcmUgdG8gYm9vdCByb20gc3RhdGUuDQo+DQo+PiArCQlnb3RvIGV4aXRfZXJyb3I7
DQo+PiArCX0NCj4+ICsNCj4+ICsJLyogQ29uZmlndXJlIE1TSS1YIHdpdGggY2F1c2VzIGxpc3Qg
Ki8NCj4+ICsJYnRpbnRlbF9wY2llX2NvbmZpZ19tc2l4KGRhdGEpOw0KPj4gICAJcGNpX3NldF9k
cnZkYXRhKHBkZXYsIGRhdGEpOw0KPj4NCj4+ICAgCWVyciA9IGJ0aW50ZWxfcGNpZV9hbGxvYyhk
YXRhKTsNCj4NCj4NCj5LaW5kIHJlZ2FyZHMsDQo+DQo+UGF1bA0KDQpUaGFua3MsDQpLaXJhbg0K
DQo=
