Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D262C3C3C15
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 09:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784798602; cv=fail; b=o1bPPNvMm/2OTedGTt4PEW7ld3+HlJX7+ty+5UnutNBszS0CHPKGCrq+4zQqyY9wXoQViSEJ+dv8sI8i1f9urF/GVNmyPoFhKAmr87GIddldKUE9f5m5yyx411XzlJFM87Mg197v62c0cYn6Mimxcw3srydkNOkOu/G27FraACc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784798602; c=relaxed/simple;
	bh=Z+6+upkW7S6ecquFj9SXtLAf91kSom3UsuxNJkHGxWQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rcpadw+5u4QmLc5R17Y7yShqX+aEIsr/CoBUMvZu7fuiMP2/+ZpLvzvOmxi+lQbdsNnz3Mtz5f9+h3U4ws3CiPw1gGRGbsup7Bcf/A9lt4+uyn96b423ulPKVv7PM500Crvv1jU3zk7gcShnn/xBGdWAMITv7KaEML69WKQcXaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dDgBolQ9; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dDgBolQ9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784798600; x=1816334600;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Z+6+upkW7S6ecquFj9SXtLAf91kSom3UsuxNJkHGxWQ=;
  b=dDgBolQ9PmHOY28FxGOaUaXwVkiqEjLZXbeuGgGj2Prmd6c6jd5vKR11
   COIuL7GsWYO23cTqvEz38e+HpE2u1hYTQMXbxbEJYBAgZd+6A+sNDOe15
   Kr08n0BvWUlXmG/3LyuvbO6zzM7J7KIXTCSQO7YjZnhUspvrlsmYhQMZU
   GVyOvgRBqH9jLo5Q0aiEVqjj89qpQT6c+BUlznudD9B84ayAfHyCX5QlR
   +MFSiVuLvrMcjw+Fe3nWwdgNNubiot++QfUZX9K5ktAGi1QNRKOoS3UJZ
   pIQWYaacVR7mOvFZ0UOALVdThosuekx3kLlRnArCUMOSLcm7prnJ/XkPd
   g==;
X-CSE-ConnectionGUID: m9mxnSW2SFaQMrCgr1SrZA==
X-CSE-MsgGUID: oSq/IumhQ7urrg49EBfBTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="84576009"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="84576009"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 02:23:19 -0700
X-CSE-ConnectionGUID: iQE3hSCrQvymPm7FCqUBCg==
X-CSE-MsgGUID: g77xBNkHSGiYny4BnxqGBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="256559108"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 02:23:19 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 02:23:19 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 02:23:19 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.9) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 02:23:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ue+0BQ91qnTNJ1y++GHR9ho1ynCwdufYctH48s3O/8GzqiZjyBD4vvVbq+qGbm36AsMhfeOti3KALkw0Eolvk7ln3rm1+zlBJUzzg9stDtHngq5FiHWRSmO0Hf5Og8cj385k5yqBievh3BaMNZbEe8GKecEz8Ea51LKZgmLMBqwc7lIHlGbhBNGI3J75K1Wo6JCeZuJDxmICYUItrpqcuZuyIdf3aG5Nzw4RwholHCjtNEH+jgFHoDhGReIVLqxJV6Qzt5/sWPD1NzG/R3TAv35UyNLkxOH4EbLSj+z1f6MvzcIlUDWHNJVMjSvB1kh9WiW7bnNS6wHrXfSjlh0A/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+6+upkW7S6ecquFj9SXtLAf91kSom3UsuxNJkHGxWQ=;
 b=sr9ERUnWP/SFRlFMSW+IZSnEhcyp3hG3MbjlgV2ClRHwf6L07lPmEDWSWtv079sUh43pDpiEMRaf5dG0naxTwAUwVK4TBpJNi+p/TJzRm2IbOXspoBixgIqFat4i59JNEz2ZjCTKwtFUiEb3d/RnI4y5lge6Kle1iM0VW0oEqwWNMravEO/BMXmab+rkjt3cgzsjttSiqAPqC6PEpIh8gK2FvLFUaeaZGxNqZ2HEAWzTi6ILWy1HpBqEqkPNbGznZsNLxdjmicmY8B0eW6O67Lif1Vi4IRlDsdZbvLcVxTcKwpqqlSpGHnMJp09p7nmOCE0s8WOeZnsJ5gNiDYHhuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9016.namprd11.prod.outlook.com (2603:10b6:208:582::17)
 by DS0PR11MB7681.namprd11.prod.outlook.com (2603:10b6:8:f0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 09:23:15 +0000
Received: from IA3PR11MB9016.namprd11.prod.outlook.com
 ([fe80::bb82:7df8:d6c5:5ce0]) by IA3PR11MB9016.namprd11.prod.outlook.com
 ([fe80::bb82:7df8:d6c5:5ce0%3]) with mapi id 15.21.0223.017; Thu, 23 Jul 2026
 09:23:09 +0000
From: "Devegowda, Chandrashekar" <chandrashekar.devegowda@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "Srivatsa, Ravishankar"
	<ravishankar.srivatsa@intel.com>, "Tumkur Narayan, Chethan"
	<chethan.tumkur.narayan@intel.com>, "K, Kiran" <kiran.k@intel.com>
Subject: RE: [PATCH v4] Bluetooth: btintel_pcie: Add vendor_rst PCI sysfs for
 PLDR
Thread-Topic: [PATCH v4] Bluetooth: btintel_pcie: Add vendor_rst PCI sysfs for
 PLDR
Thread-Index: AQHdGXihxqU0ksAjt0msAl36AAcd3bZ5rqQAgAEmRwA=
Date: Thu, 23 Jul 2026 09:23:09 +0000
Message-ID: <IA3PR11MB90160EE8F2DFC564ACE29AA1FCC02@IA3PR11MB9016.namprd11.prod.outlook.com>
References: <20260612012832.2395034-1-chandrashekar.devegowda@intel.com>
 <20260722012158.813793-1-chandrashekar.devegowda@intel.com>
 <CABBYNZJ6NM55ykYVrMxx-HLZOPC53bZrBzXWhjQnZ7gKSEwNWw@mail.gmail.com>
In-Reply-To: <CABBYNZJ6NM55ykYVrMxx-HLZOPC53bZrBzXWhjQnZ7gKSEwNWw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9016:EE_|DS0PR11MB7681:EE_
x-ms-office365-filtering-correlation-id: 6d2c4d7d-1734-43ed-0fdc-08dee89c032b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|38070700021|56012099006|10067099003|22082099003|18002099003|7136999003|6133799003|4143699003|11063799006;
x-microsoft-antispam-message-info: ZbciNQ1VyIdj2hvnUBAzu2jMWapwO8EFhMFZ9kaQ0R1/UwntJYfVNUtUfRzPfQIIS+uZWQKUeBUZtl5Kfssle1RfwU013k9EfMRsPeVfMo6wp5r57aiNBUqEBA+Uswb7PfKLUpgQMiPhyp+63rdhMXQsCOwMPW9Iv5PD+/F+6gCR5tAyMNVGHrJYtrhGYl6kf+4FGER82aJrApPQIQXItJnkNVWouwQjVBB8sw5xAZ/HAOb9WWwG68He4jqEUFpepGwvaVfmnfAQiVeGZUPY2v6xFeyVBOBXpzPqVcU8iyfrGgl9uay5raiOOOKkJiLwkXwpqgPusm86twiQetNmj5LlwNl2x3jPZ+hL8AT4QiuV21Miiw4HFRAz8OIhMN6TDIMcuBzoZ68nKep5FbyNPvPOhPfmq3mBna2NkNey3tEsaDDlNdJ0AMWQCgjCUSuhnEjnoLVFkTlAtGNHFY87wKgFse5egZHqG3f2Ttdzx3tiLZhgqdmQBm7RrmHQLiCyu2uNUswZ+PKGlDuHI9jB4OWeoxgF0BAi9IVZth7NRDQz/j17pkIygxr+eMsMjEegN3YcxDIyJjzpkEQq9adt4uyPjK08YNTJ+vMYyeTfrvj7T6s/7fbivDqrmL6eDVQ6l7gvww6pO8Q7N2ivDvB29eNir/ff0YmOgYQV+EIYNDUzMLXWAy//WIa7tP6inGnWnk/VEhtzA07nJ6EDnyw1wWCKJ8Ed9e2LQvGa+1UDDGc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9016.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(56012099006)(10067099003)(22082099003)(18002099003)(7136999003)(6133799003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3djNlR0ckprQXVBRmlmVC9ZTlFpMUR5NGc4Ky80WmhjRlNhRDJ3QjlTSjlT?=
 =?utf-8?B?YzdZaXlIQ1lxQ0tDNUFvNnVmTkc1Z0E3OUxRVEh6VUlSMTM1bC90aVVpV2VP?=
 =?utf-8?B?eXJiOTFBUW5Ec2tkWk5tUWhEMk1mZXh6RDkrZXhPa1A5L01iMmpjRkdsejFs?=
 =?utf-8?B?bnZHdHhZd1REalQ5UDBsRm9iVmpkUlJIS2ZlajJXS2JxOXVBaE94eG9tK3dk?=
 =?utf-8?B?L3hCZWF5aXZSOTE4S3U4UjRDRTZxTjVwTTJkV1NaQnIwcllUYjZBbXRCWFlG?=
 =?utf-8?B?eTkrUU9NTHR4YXhqTVVHSkFKVnhWcVBUbEJNUzlpOEtBbEFudXVZVU02NnVO?=
 =?utf-8?B?YnYxcFh4WFhxVTFGREEzODJvdnVwR1pJclNqSStDVG5DQTYrVUxBNWtjWklq?=
 =?utf-8?B?SlRuRmZSRTVkb2RhSmVJdDNtWVZlRXNCVEwxMndiNllxWUtiUFFMb3ludjlH?=
 =?utf-8?B?MmVYcVZKQXlzNUJiZDhUdTFPa3hvZVhiVzJ4NnMrZ3JyaVg0TTNFQXY0WmUw?=
 =?utf-8?B?cStPL2prZFVpSFV0M3ZicWRnVEZpck4zcEcrMVZncDRRVVBwcU9ZY2p6bzdN?=
 =?utf-8?B?QTExLys4VnE2bVJtUFE2dzJ1R3NXU0pZQ1ZvcGwrRW1IRHErU0RjL1BXRHBH?=
 =?utf-8?B?WUdGczE1ZTJjQVJUTm5COHI2NVRZTzVtckc5aXZmVHMvakVLbHdOcmFnZ2RW?=
 =?utf-8?B?R3h2aVc4dW9VNXBMaldkNnZlMzF4elZwK2NpT3V3azVQTXBES3dCdGxLOUxS?=
 =?utf-8?B?Ty9OQkd6NEwvalhsdE1UcUduMTZmbkpOalpBWDRuSDM2YVlLamJEZjRtUmpH?=
 =?utf-8?B?aXR3a1dVaXNyVkt3WmxJMHhnVW8rMmV2WFV3ZnpxY2Zka3l0VEt0VzhqeWJ5?=
 =?utf-8?B?N3RWeG11YllDT091UDBsSVRhTXRVd1NXSVVha205bDh4YjN1RWZmV2ZXM013?=
 =?utf-8?B?YmNkWVJKK2hIcEt1SncvRGV4Z3NhZk56QnVBZU9YOEk5MWlTeDE4SWxjbito?=
 =?utf-8?B?ODdoT2IvaTV2cUszVFNUdkVsdnpyb3QzODR2K3k2d2FFTjVrcGdXQS9sSUVq?=
 =?utf-8?B?UjdVckJkUU1hWWgramJQWlpJdVRjSUhlQncxMnZWMXIrUlFxK1pmbngrWEwy?=
 =?utf-8?B?TWlkSG8xbGJFRFJ0ZFF2akNLZWNCWHcxeThjeEh2OUFvb09tRHRZLzhSbnR1?=
 =?utf-8?B?Q3ZoZXJlWmtLL1Nyc0E2STdhRm4xSVZ0ZXlmcDBEMm9oelZBUWZWR3p4M3lW?=
 =?utf-8?B?VG5yeGtJS1JJVlZEYjJkSElCRzZPbFA1d1lhSlFvMFluUlF1eEk5Tm43Ykl6?=
 =?utf-8?B?VTkxTXZpcTVrT01hbDhvZG5HVmFaL0hIc2dPZFRCaWJrYUN0elhYdGUrWHly?=
 =?utf-8?B?MDBnMG9ZOVZHQlRiUE54YnF3YUhXNG5iN1VwZUs1anM3dXM3aElNNEs0Q0cr?=
 =?utf-8?B?QmUzT1o5UFUySUxlSzdZSC9kNmhVWERkaFE0VmZrbUMydENrUU9yUmpyNWJp?=
 =?utf-8?B?VVhsYzdDd0UwR3BLdkhsWWRTVUh2NzlZN01YNGlzdC84YUVvVFdRenVteXJQ?=
 =?utf-8?B?aEFyajl1TFFXV1NBb3hCQXovNDJnaVJsTjRZZXdMV3hLRWJ6MFppVEtGVFk4?=
 =?utf-8?B?ZHZobnp4b1lVbnMrblE1ek9NKzU0T1B4LzljMlUrWHMzWGxnV3RKalNBeFUv?=
 =?utf-8?B?WW5nZE12c2lmR1ZQNjhsclBYUC91SzE1bUJNWE9RaThwSzBsTHRCUDAyNVJx?=
 =?utf-8?B?Wk4xVkVlSi9GdS9VQlFrNWphWjJBQ09RMks2OWRNMDZXZEM2bFEyYkVzOGs4?=
 =?utf-8?B?NFRwTjlGMXdLTzU2bmR3MVZmK0JlWVJzeUs1NEs4SDJwY3o3T21ET0RsMUkz?=
 =?utf-8?B?c3pFeUM2cGxWd1Q4L1RGdzZ3V2wrRjZKWDZ2T0xmSzNMa2srTW9lNnhPWlRt?=
 =?utf-8?B?L1B1WVZVMWk3NHVrbEJ0MTFvV2JtalQ2bU5CQkEwVmJQTm9PWEg4UWF6OFd0?=
 =?utf-8?B?UmRRaitKZ2ljbk5qR1lVbXF2L3ZLTkE0Nk9VMWlFbTJOd29oYm9BRDRLdzdj?=
 =?utf-8?B?TGEwQ3l5SU96cmI1d0VHdG1vano1eW5MK0lvN21SVTNIb1FIajFlY1lidDVl?=
 =?utf-8?B?UzBnUXo2YU5HQzNUeGphK2RYZVk3eXhoTThrbnFaVnUvSDVFbjNmeXlwSHlp?=
 =?utf-8?B?TFY5NjZ2UHdXaHdiY2xzWnc3NGlKTnRJOThadnpnanRmK0lVVWRXN25NNHkv?=
 =?utf-8?B?aGk1c3ZFeHBrYk5nR0RQQ1hjQVhjeW5UNGp1aldBVjUvOGd3Ukx0ektRVXZm?=
 =?utf-8?B?WCs2NEg0Wkx2Tko4RzM4bVlIc2pvZUZNMWJXK0RLYXBGb1lMMC85ak9HUnpv?=
 =?utf-8?Q?bnTT0W9jFuO3wq+Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MJwK92G3Gcwaj55tkxN+96nKKzkt51vq0saJK5rR8a9vUx/HCwzkJ2nhZWigJ8LgJHJr6ac7UdpqlrTahSqMFkwHUE1H0iPIPZzKr70PEVPkUIHCjnjp5zyV9b1gKYYBQpQurmSFAS1YxaHVdIZW/C/2e302GFZAKPk1vPGEN3tBzecsVMgMIsKYhpE6EvDIInx6s/IwnxYtMArnkI6XZfn/5AkyBVKjs4z0/ElGNJhJP6OqCYcfm8sevz1quGKwIV2Bge/mzBcMtjNijFMNCo1aPv7zMYa/hOvzO87ozZi70wwBhSR36VypZINCyjz62b3VIzwd6BNwBXjOZOpaQQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9016.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d2c4d7d-1734-43ed-0fdc-08dee89c032b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 09:23:09.8587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bUwDun/VjevKsNGxl6hMYZrk0PfJhtPjlBK2Nr4SGOwCuU9Kiw7wQo3ieleRV3EEpQoEkYVHJ/b74R7ImZ2oH7oczCUQKsd4IpxvFq3EWpoWhEism7QMSO7uqKyrugPS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7681
X-OriginatorOrg: intel.com

SGkgTHVpeg0KICAgICBUaGFua3MgZm9yIHRoZSBjb21tZW50cy4NCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LmRlbnR6
QGdtYWlsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDIyLCAyMDI2IDk6MTMgUE0NCj4g
VG86IERldmVnb3dkYSwgQ2hhbmRyYXNoZWthciA8Y2hhbmRyYXNoZWthci5kZXZlZ293ZGFAaW50
ZWwuY29tPg0KPiBDYzogbGludXgtYmx1ZXRvb3RoQHZnZXIua2VybmVsLm9yZzsgYmhlbGdhYXNA
Z29vZ2xlLmNvbTsgU3JpdmF0c2EsDQo+IFJhdmlzaGFua2FyIDxyYXZpc2hhbmthci5zcml2YXRz
YUBpbnRlbC5jb20+OyBUdW1rdXIgTmFyYXlhbiwgQ2hldGhhbg0KPiA8Y2hldGhhbi50dW1rdXIu
bmFyYXlhbkBpbnRlbC5jb20+OyBLLCBLaXJhbiA8a2lyYW4ua0BpbnRlbC5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjRdIEJsdWV0b290aDogYnRpbnRlbF9wY2llOiBBZGQgdmVuZG9yX3Jz
dCBQQ0kgc3lzZnMgZm9yDQo+IFBMRFINCj4gDQo+IEhpIENoYW5kcnUsDQo+IA0KPiBPbiBUdWUs
IEp1bCAyMSwgMjAyNiBhdCA5OjIy4oCvUE0gQ2hhbmRyYXNoZWthciBEZXZlZ293ZGENCj4gPGNo
YW5kcmFzaGVrYXIuZGV2ZWdvd2RhQGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBBZGQgYSBy
ZWFkLXdyaXRlIHN5c2ZzIGVudHJ5IGF0IC9zeXMvYnVzL3BjaS9kZXZpY2VzLzxCREY+L3ZlbmRv
cl9yc3QNCj4gPiB0byBhbGxvdyB1c2Vyc3BhY2UgdG8gdHJpZ2dlciBQTERSIChQcm9kdWN0IExl
dmVsIERldmljZSBSZXNldCkuDQo+ID4gUmVhZGluZyB0aGUgYXR0cmlidXRlIGRpc3BsYXlzIHN1
cHBvcnRlZCByZXNldCB0eXBlcy4gV3JpdGluZyBpbnRlZ2VyDQo+ID4gMCB0cmlnZ2VycyBQTERS
LiBBbnkgb3RoZXIgaW5wdXQgaXMgcmVqZWN0ZWQgd2l0aCAtRUlOVkFMIGFuZCBhDQo+ID4gd2Fy
bmluZyBsb2cuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaGFuZHJhc2hla2FyIERldmVnb3dk
YQ0KPiA+IDxjaGFuZHJhc2hla2FyLmRldmVnb3dkYUBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4g
Q2hhbmdlcyBpbiB2NDoNCj4gPiAgIC0gUmViYXNlZCBvbiBsYXRlc3QgYmx1ZXRvb3RoLW5leHQg
KDZmNTVhZDhmYjBhYykgdG8gZml4DQo+ID4gICAgIENJIGFwcGx5IGZhaWx1cmUNCj4gPg0KPiA+
IENoYW5nZXMgaW4gdjM6DQo+ID4gICAtIERyb3BwZWQgcmVzZXRfdHlwZSBwYXJhbWV0ZXIgYXBw
cm9hY2ggZnJvbSBoZGV2LT5yZXNldCgpDQo+ID4gICAtIERpcmVjdGx5IGNhbGwgYnRpbnRlbF9w
Y2llX3JlcXVlc3RfcmVzZXQoKSBpbnN0ZWFkIG9mIG1hbnVhbA0KPiA+ICAgICBmbGFnIG1hbmlw
dWxhdGlvbiBhbmQgc2NoZWR1bGVfd29yaygpDQo+ID4gICAtIEFjY2VwdCBvbmx5IGludGVnZXIg
MCBmb3IgUExEUiB0cmlnZ2VyDQo+ID4gICAtIEhhbmRsZSBzY2hlZHVsZV93b3JrKCkgZmFpbHVy
ZTogcmVsZWFzZSBwY2lfZGV2X2dldCByZWZjb3VudA0KPiA+ICAgICBhbmQgY2xlYXIgUkVDT1ZF
UllfSU5fUFJPR1JFU1MgZmxhZw0KPiA+ICAgLSBGaXggcmVtb3ZlIG9yZGVyaW5nOiBkZXZpY2Vf
cmVtb3ZlX2ZpbGUgYmVmb3JlIGRpc2FibGVfd29ya19zeW5jDQo+ID4NCj4gPiBDaGFuZ2VzIGlu
IHYyOg0KPiA+ICAgLSBBZGRlZCByZXNldF90eXBlIHBhcmFtZXRlciB0byBoZGV2LT5yZXNldCgp
IGNhbGxiYWNrICgxLzIpDQo+ID4gICAtIHZlbmRvcl9yc3Qgc3lzZnMgdXNlZCByZXNldF90eXBl
IHRvIHNlbGVjdCBQTERSICgyLzIpDQo+ID4NCj4gPiBDaGFuZ2VzIGluIHYxOg0KPiA+ICAgLSBJ
bml0aWFsIHZlbmRvcl9yc3QgUENJIHN5c2ZzIGltcGxlbWVudGF0aW9uDQo+ID4gZHJpdmVycy9i
bHVldG9vdGgvYnRpbnRlbF9wY2llLmMgfCA0Mg0KPiArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNp
ZS5jDQo+ID4gYi9kcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuYw0KPiA+IGluZGV4IDJl
Mjg4NDcyNjNhYi4uYTQxMmNhN2ZmM2FkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvYmx1ZXRv
b3RoL2J0aW50ZWxfcGNpZS5jDQo+ID4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9w
Y2llLmMNCj4gPiBAQCAtMjc4MSw3ICsyNzgxLDEwIEBAIHN0YXRpYyB2b2lkIGJ0aW50ZWxfcGNp
ZV9yZXF1ZXN0X3Jlc2V0KHN0cnVjdA0KPiBidGludGVsX3BjaWVfZGF0YSAqZGF0YSwNCj4gPiAg
ICAgICAgIGRhdGEtPnJlc2V0X3R5cGUgPSB0eXBlOw0KPiA+DQo+ID4gICAgICAgICBwY2lfZGV2
X2dldChkYXRhLT5wZGV2KTsNCj4gPiAtICAgICAgIHNjaGVkdWxlX3dvcmsoJmRhdGEtPnJlc2V0
X3dvcmspOw0KPiA+ICsgICAgICAgaWYgKCFzY2hlZHVsZV93b3JrKCZkYXRhLT5yZXNldF93b3Jr
KSkgew0KPiA+ICsgICAgICAgICAgICAgICBwY2lfZGV2X3B1dChkYXRhLT5wZGV2KTsNCj4gPiAr
ICAgICAgICAgICAgICAgY2xlYXJfYml0KEJUSU5URUxfUENJRV9SRUNPVkVSWV9JTl9QUk9HUkVT
UywgJmRhdGEtPmZsYWdzKTsNCj4gPiArICAgICAgIH0NCj4gPiAgfQ0KPiA+DQo+ID4gIHN0YXRp
YyB2b2lkIGJ0aW50ZWxfcGNpZV9oY2lfcmVzZXQoc3RydWN0IGhjaV9kZXYgKmhkZXYpIEBAIC0y
NzkxLDYNCj4gPiArMjc5NCwzNiBAQCBzdGF0aWMgdm9pZCBidGludGVsX3BjaWVfaGNpX3Jlc2V0
KHN0cnVjdCBoY2lfZGV2ICpoZGV2KQ0KPiA+ICAgICAgICAgYnRpbnRlbF9wY2llX3JlcXVlc3Rf
cmVzZXQoZGF0YSwgQlRJTlRFTF9QQ0lFX0lPU0ZfUFJSX0ZMUik7DQo+ID4gfQ0KPiA+DQo+ID4g
K3N0YXRpYyBzc2l6ZV90IHZlbmRvcl9yc3Rfc3RvcmUoc3RydWN0IGRldmljZSAqZGV2LA0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUg
KmF0dHIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICpi
dWYsIHNpemVfdCBjb3VudCkgew0KPiA+ICsgICAgICAgdW5zaWduZWQgaW50IHZhbDsNCj4gPiAr
ICAgICAgIHN0cnVjdCBwY2lfZGV2ICpwZGV2ID0gdG9fcGNpX2RldihkZXYpOw0KPiA+ICsgICAg
ICAgc3RydWN0IGJ0aW50ZWxfcGNpZV9kYXRhICpkYXRhID0gcGNpX2dldF9kcnZkYXRhKHBkZXYp
Ow0KPiA+ICsNCj4gPiArICAgICAgIGlmICghZGF0YSB8fCAhZGF0YS0+aGRldikNCj4gPiArICAg
ICAgICAgICAgICAgcmV0dXJuIC1FTk9ERVY7DQo+ID4gKw0KPiA+ICsgICAgICAgaWYgKGtzdHJ0
b3VpbnQoYnVmLCAxMCwgJnZhbCkgfHwgdmFsICE9IDApIHsNCj4gPiArICAgICAgICAgICAgICAg
YnRfZGV2X3dhcm4oZGF0YS0+aGRldiwgIlBMRFIgcmVqZWN0ZWQ6IGludmFsaWQgaW5wdXQiKTsN
Cj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gKyAgICAgICB9DQo+ID4g
Kw0KPiA+ICsgICAgICAgYnRfZGV2X2luZm8oZGF0YS0+aGRldiwgIlBMRFIgdHJpZ2dlcmVkIHZp
YSBzeXNmcyIpOw0KPiA+ICsgICAgICAgYnRpbnRlbF9wY2llX3JlcXVlc3RfcmVzZXQoZGF0YSwg
QlRJTlRFTF9QQ0lFX0lPU0ZfUFJSX1BMRFIpOw0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiBj
b3VudDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIHNzaXplX3QgdmVuZG9yX3JzdF9zaG93
KHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
c3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsIGNoYXINCj4gPiArKmJ1Zikgew0KPiA+ICsg
ICAgICAgcmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCAiMCAtIFBMRFJcbiIpOyB9DQo+IA0KPiBPaywg
c28gSSBhc3N1bWUgdGhpcyB3aWxsIGJlIGJ0aW50ZWxfcGNpZSBvbmx5IHJpZ2h0PyBOb3QgQmx1
ZXRvb3RoLXdpZGU/IEluDQo+IHRoYXQgY2FzZSB5b3UgY2FuIGNhbGwgaXQgcGxkciBkaXJlY3Rs
eSBzaW5jZSBpdCBubyBsb25nZXIgbmVlZCB0byBnZW5lcmljIGFuZCBvbmx5DQo+IGFwcGxpZXMg
dG8gYnRpbnRlbF9wY2llIGRyaXZlci4NCj4gDQoNClRoaXMgaXMgb25seSBmb3IgYnRpbnRlbF9w
Y2llIGRyaXZlciBjdXJyZW50bHkga2VlcGluZyBpdCBhcyBpbnRlZ2VyIHNvIHRoYXQgaXQgY2Fu
IGJlIHNjYWxlZCBmdXJ0aGVyIGZvciB0b3Atc2lsZW50IHJlc2V0Lg0KDQoNCj4gPiArc3RhdGlj
IERFVklDRV9BVFRSX1JXKHZlbmRvcl9yc3QpOw0KPiA+ICsNCj4gPiAgc3RhdGljIHZvaWQgYnRp
bnRlbF9wY2llX2h3X2Vycm9yKHN0cnVjdCBoY2lfZGV2ICpoZGV2LCB1OCBjb2RlKSAgew0KPiA+
ICAgICAgICAgc3RydWN0IGJ0aW50ZWxfcGNpZV9kZXZfcmVjb3ZlcnkgKnJlYzsgQEAgLTMwMTAs
NiArMzA0MywxMSBAQA0KPiA+IHN0YXRpYyBpbnQgYnRpbnRlbF9wY2llX3Byb2JlKHN0cnVjdCBw
Y2lfZGV2ICpwZGV2LA0KPiA+ICAgICAgICAgaWYgKGVycikNCj4gPiAgICAgICAgICAgICAgICAg
Z290byBleGl0X2Vycm9yOw0KPiA+DQo+ID4gKyAgICAgICBlcnIgPSBkZXZpY2VfY3JlYXRlX2Zp
bGUoJnBkZXYtPmRldiwgJmRldl9hdHRyX3ZlbmRvcl9yc3QpOw0KPiA+ICsgICAgICAgaWYgKGVy
cikNCj4gPiArICAgICAgICAgICAgICAgYnRfZGV2X3dhcm4oZGF0YS0+aGRldiwgIkZhaWxlZCB0
byBjcmVhdGUgdmVuZG9yX3JzdCBzeXNmcyAoJWQpIiwNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgZXJyKTsNCj4gPiArDQo+ID4gICAgICAgICBidF9kZXZfZGJnKGRhdGEtPmhkZXYs
ICJjbnZpOiAweCU4Ljh4IGNudnI6IDB4JTguOHgiLCBkYXRhLT5jbnZpLA0KPiA+ICAgICAgICAg
ICAgICAgICAgICBkYXRhLT5jbnZyKTsNCj4gPiAgICAgICAgIHJldHVybiAwOw0KPiA+IEBAIC0z
MDQ2LDYgKzMwODQsOCBAQCBzdGF0aWMgdm9pZCBidGludGVsX3BjaWVfcmVtb3ZlKHN0cnVjdCBw
Y2lfZGV2DQo+ICpwZGV2KQ0KPiA+ICAgICAgICAgZGlzYWJsZV93b3JrX3N5bmMoJmRhdGEtPmh3
ZXhwX3dvcmspOw0KPiA+ICAgICAgICAgZGlzYWJsZV93b3JrX3N5bmMoJmRhdGEtPmZ3dHJpZ2dl
cl93b3JrKTsNCj4gPg0KPiA+ICsgICAgICAgZGV2aWNlX3JlbW92ZV9maWxlKCZwZGV2LT5kZXYs
ICZkZXZfYXR0cl92ZW5kb3JfcnN0KTsNCj4gPiArDQo+ID4gICAgICAgICAvKiBDYW5jZWwgcGVu
ZGluZyByZXNldCB3b3JrLiBTa2lwIG9ubHkgd2hlbiByZW1vdmUoKSBpcyBjYWxsZWQgZnJvbQ0K
PiA+ICAgICAgICAgICogd2l0aGluIHRoZSByZXNldCB3b3JrIGl0c2VsZiAoUExEUiBkZXZpY2Vf
cmVwcm9iZSBwYXRoKSB0byBhdm9pZA0KPiA+ICAgICAgICAgICogZGVhZGxvY2suIGN1cnJlbnRf
d29yaygpIHJldHVybnMgdGhlIHdvcmtfc3RydWN0IG9mIHRoZQ0KPiA+IGNhbGxlciBpZg0KPiA+
IC0tDQo+ID4gMi40My4wDQo+ID4NCj4gDQo+IA0KPiAtLQ0KPiBMdWl6IEF1Z3VzdG8gdm9uIERl
bnR6DQo=
