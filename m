Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75DA1D4176
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Oct 2024 13:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728309088; cv=fail; b=sS+aS2//ZzItGtOoFkAUj3/CInfcnqJfDbFAMNswGCOrPKifqH+yGkJ9o3dn/XzGckXdCS3+4BUnKUctJCnZUPp+TtS1qIuXGAh5gK+euBZ0oXDbUaJsyC0isA44sK2eFQpkH6x5Th0yF0dAsFcfH1c0mIKePcLCkKHBX1qPZ9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728309088; c=relaxed/simple;
	bh=rJPwtOUMU6A9fHfxb0XMe/r9/R2w6GOb5mXk/fv5FP0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qw/6FHQaku2w/gceaKcxAT1rnrelKPxfsQ3tNyJqseAKXnTqcekVGsQeUnH4Ci0E4yHuLju5Ifpb+iK6mTX2CvQDdLhPhheMZv+UhJL1i0JmEdB3Bs/yqmW9J8yzGQOdJVitLsEeOPYwzadNFezmt6O7N+JpRI4tFOQLpCuyUq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eYxRPb+o; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eYxRPb+o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728309086; x=1759845086;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rJPwtOUMU6A9fHfxb0XMe/r9/R2w6GOb5mXk/fv5FP0=;
  b=eYxRPb+o1E0f1h/hH6AxrELMhms6d4nMcZtFOAwFAODqUA1RCRkijVxI
   YVNK+i3zLwuW6a6/+BRDd4cpoKTrOk4a8sxLWvv+DCc8pzkUK+OyacNK2
   oiintAonXjeuU7QUlZMwD0N8s5E0nkRoqFaJE+NuDp9KTm84Gi5pcUBmq
   uUbv26j33iHTCkouDbju7cUTzGQOV0HqSRQAMcDUunC/nYME4TildL7VL
   sXjRqvllUL0Y+2kIupX4yHVdc1AQPLDeCIxgyjuEPh4dD/jeRBhmZAIwh
   NCk+2G1TKbbO2dCdozkkU1SZnZY9bDeIz/S2o3RneGoBDt3ONrktaugYL
   A==;
X-CSE-ConnectionGUID: JkDTBkoKRvqv7nGDpiNX7g==
X-CSE-MsgGUID: 1CHjswuySpqJIqmDadOa3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27334675"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="27334675"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 06:51:25 -0700
X-CSE-ConnectionGUID: KWAFMF0GR4+uY2eNCVQjTA==
X-CSE-MsgGUID: VSfcSvy3TOqdHMwbImyp6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="80456129"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Oct 2024 06:51:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 06:51:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 7 Oct 2024 06:51:25 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 7 Oct 2024 06:51:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rlCFbLGygQ9KBMSM9T5hop8nv86B7ZO08mmquVQXmXVYixp0cE8eBZ8qOHKFtTmAzBY54Ve4UeP4QcbhSMOrkJMtsmKazoj1c0dZ6WAGAHHU7lieCphSJ0toHYp9ZhbRbrQqx8UoHRZ5WOQOx+n/ZDE7x4BvEDxOMNA3wDplV5nybWolA0841IoZy2js2Z4mDPrq98DVEmLmJuBSxLc7j7+0nFpDQ8Ebt3SLc75dy4vzYlrpQr2krv/lF+BJy6s2TXFBsKBY41AmG9RiPC4VV4E69qrkt4c0BZ5FyYIFklH/cheDkEzwhOaAB+aVp7gm+CqbZDMg58FOx/eeCmLU0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJPwtOUMU6A9fHfxb0XMe/r9/R2w6GOb5mXk/fv5FP0=;
 b=DC9yQK8rChBiu3FE4vg0nrHVZUxm740ytDpjZ3DLZ03mimRj1u1uh3BZRyzTOS1FfJAvD5rH+dd4lqy9R3iXq+UYWto73mb/vMAMMyH3wJP/rPERD6TRLKtsXXr7sA/5UM9bLVBQorOq8MANRG5G5EVhxs7Tv64VH07ONDoSLhLoaGJgWi7C3WhhlNgKeBB2pNF9Qi2iLfAjHlQ8FniOaa9kgOrla8zxWhu4dKqQlbu3cOb5RTibM6IKdrgBNzxpsFGRiQ5z4uA/rs7f6oKuQVwp6kPH4ueAjT6w2V7534y6CU9ngiZEdZI/e2DyE3hy7HEY+tfXob4QcmElTbJoNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by CYYPR11MB8388.namprd11.prod.outlook.com (2603:10b6:930:c2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Mon, 7 Oct
 2024 13:51:23 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%3]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 13:51:22 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, "Devegowda, Chandrashekar"
	<chandrashekar.devegowda@intel.com>
Subject: RE: [PATCH v1 1/2] Bluetooth: btintel_pcie: Add handshake between
 driver and firmware
Thread-Topic: [PATCH v1 1/2] Bluetooth: btintel_pcie: Add handshake between
 driver and firmware
Thread-Index: AQHbE+zfvY00RUFF00CmVe/BlzThyLJx9biAgAlgqGA=
Date: Mon, 7 Oct 2024 13:51:22 +0000
Message-ID: <PH0PR11MB7585EBF14F24FE7D64AF6E05F57D2@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20241001104451.626964-1-kiran.k@intel.com>
 <CABBYNZJRQV+bgYcVDCST1+_+KOMZWDSdAWMLUkVYy-Kni2WdnQ@mail.gmail.com>
In-Reply-To: <CABBYNZJRQV+bgYcVDCST1+_+KOMZWDSdAWMLUkVYy-Kni2WdnQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|CYYPR11MB8388:EE_
x-ms-office365-filtering-correlation-id: 0aff4461-5f68-4d07-a1a8-08dce6d72133
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RG1QdVNpZTFreHc1N2kxaVhxSllaQys3aTZLN2d0K1RkanJqNFFkM2ZpcXFO?=
 =?utf-8?B?UlBmQjBnL1VsZ2FLb1g0Q0pRVG1TeWFnVTBwbWRXY2VwRGQ4UzVtd3BCK0g1?=
 =?utf-8?B?N0VJTUMxZEhKNE9ndVlGcGpEeXlCOVd2UFRqY01aZTVrbmd5TmNRZEdPRDQw?=
 =?utf-8?B?SDVUcUpwTERBUTc4K3lCeUIyaHRzK2crY0ZjTm4xY1hYVlUyc3Q1ZlQvaUd0?=
 =?utf-8?B?cmY3c2JZNVFyeGpoZEhnR3hxM1o2N3RPR2JxempqNGFFNGpFWWFZT0h0SEZj?=
 =?utf-8?B?aWgvOHc4aWI3UHR4dyt2QW9URlVuN3ZJVDJXTGEzQ25oYlBHOVZSbkVuUjUz?=
 =?utf-8?B?S1RxNXIra1dCdEhMS0t1dUIvc0xUSW9vaGlJODArUDAyRzVxWkJValhmSmpL?=
 =?utf-8?B?RnlIQVJ2SklHRnNtbHpxSFJId2xjNVVoSUMyU1BJYVFSSjlWb3RUNHJwWXVl?=
 =?utf-8?B?YXJFWGtKVlArc21GU09KbDF6RnBuaUl6eTNuVExMTTNtWHJQMEMxcTJGUkYv?=
 =?utf-8?B?bTJwcjI4M0hFaTdHVXpRSi9pZS9aT3o5OHo4Vi95MTErelFkWEYreGo1RUNr?=
 =?utf-8?B?aVpta1Z0bFQwb2lYaXA0MlBoTm9kRnZnSGlLSVdRNE5zYVBJSGRlNjdVTFZU?=
 =?utf-8?B?TER6bTdXT0ZQdTBQQU5CanRScG1jZU9iUGh4N2NMc0dqbWVlSHZONDh3MlJL?=
 =?utf-8?B?SDB6S1YvUXMxM1VqWjRPTTZXUHhhQis0MUt3cVpxNVBnc0MyMGMwVk1vMG5M?=
 =?utf-8?B?aHRJU1FlMEcvSG9sbVpLQ3JsWGc2NVN5dDlnVkJoNXZrR0xCYS9vbHM2aFhw?=
 =?utf-8?B?VTlyaGdKSWVRSE9sWGdIZmp0TDdUdnZJaVJXS3dyUzBaMlZPTkVaNGVCTWl0?=
 =?utf-8?B?WVdNVkZ1dmdEcGJjdm1sakRhRlZOMGZ1VFFGVzArL3hOci9FdmRCNXN6SzZ3?=
 =?utf-8?B?YU4wbGNhcEtGVlFFRllIcWlxN1FFaGNoMWRKUHFTb2hJY2xkeEZTRkZ3UEph?=
 =?utf-8?B?a3dYNnZYWlZ5NmFEa3dlQVhwYVFHWnVJSmY2SjJnajk1REsvdkhwdmxvd01j?=
 =?utf-8?B?YzR4MGljeHFKeEVBQS9pSTVvOTZXbnE4WG1sTjAzMjgzREpwZUprQllDR3Rl?=
 =?utf-8?B?ZWUxTldmM01yMXhzQjB5TmtPUlFLWnFXWXlCUkJ6UHErTVVoYlpwdkQxQVd1?=
 =?utf-8?B?UmxTdm9COGpqVW0yR1FMc3hYdUxnQ0pEWnB6eWxpa2RFSWprK2JueHB2Snlq?=
 =?utf-8?B?UEtnQWRwZWFxU0Z6ZzVJcXc1V0dwTWxXaWFyN2dxLy9ZbVhFdi85eXNWNW5J?=
 =?utf-8?B?Mk45MS9nbUpCbm5OVExBd0xMUHpWVDNKQkFFdHFNLzd1aWZCUzBCeHlacjB5?=
 =?utf-8?B?MXpoQk5Jc2U3L09hVDJ4RnB2cmVhaEdQVGtCZ0FqUjF1M2NSOHRnY2dnSy9D?=
 =?utf-8?B?SVg1cjJ5bGtycUJzcDhJck5wMlBwV1BXTUl1QVhMdlhiQTVvTkZ4QTBSR3Zs?=
 =?utf-8?B?dUVzYS9FN2p5dG4rZTdRQVNYRjlYc1FYVkxGTm1tWm80NkxvSElIMTNHMnhP?=
 =?utf-8?B?Q2lsalRqR3M3TzJOZy9LRGVRajh2aS85R3lscXNzMXg2OU1yWjNJa21MNUdt?=
 =?utf-8?B?dFFNRnBaL3BRMzF1anFKQWVaZHgyM1l2MVZUMnFmeWVUbVB2Q3Urc21tdXUv?=
 =?utf-8?B?L3ROVDN3ZmJtSU9qeEE1WkV5Vy93VklMaXNtU2VKSldZazJEdklKekNkY3JK?=
 =?utf-8?B?dUZTYU1RYWNaTE5peVVHUVhjRHhuRkx6UWwzcVFocTlVRXZsb3ZUN3NVeDlZ?=
 =?utf-8?B?bFQwcjhqdmtYdkNKcWVnZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmVTZkxqSUpQRmdSZU9zd2hXYzY3anM0V0FRNzdLREFCQ2Q4RDdsYVoyY2pH?=
 =?utf-8?B?dC92a09QUXVnQVB0dE9PZ29UcnFOdlVSVnltLzhROXZzdTJaUWFaeGovM0Nv?=
 =?utf-8?B?OGduMkdkQlhTWVE3N0FPbzNuOU5FR2EvMERUSWJvakc2d2lxMUxyOW1PMGhL?=
 =?utf-8?B?all4UEI4Uk8rOWpTanVHUWFmQW1WbC9sanJ2aWt6RXdMVlpsRVJBNFhHNEY0?=
 =?utf-8?B?MmhRczd6Mk5HbVVtanNTb2Z5TlFYRzdWVTVVUEhGdkpOTk1kNjN0MkVicXNa?=
 =?utf-8?B?MkRPbVJTSzljamlwREU5d2ovTHJYV2hKMkFEK0hEUWw4NWhsOFpQQnYzeHZh?=
 =?utf-8?B?b24zclY3OHIyWW45S242WTloTmEzTjNzdE80VUJpYWhMMjZydElFbHJyQU9m?=
 =?utf-8?B?L0t6T3pCTTkzaXc3NXE3bWo1b0hNd2JMYzRoK1FSclpEcm9CTStNRGE4K0hZ?=
 =?utf-8?B?ZDNWUDB1bzRBQlhndVh1QkdqaUdRODJKckFZNFlmTHIvZzgrNVlpb0gvUHFI?=
 =?utf-8?B?OGNpTFBXTWdac2lGWFdNZll5QTZZYzJ4MW5DMmFIQS9MaXBIY3VrZWJkNVMy?=
 =?utf-8?B?UlI0ekZubHFoMnZWN3VzbVlwa2JFS2pkOGRrTC9ncTRXNEUvVUtFUWt5TTNV?=
 =?utf-8?B?OGs3QVJGbW9BZzgyWkgwb29mSHRtMGtMbEE3bHZ0aWFhN0dYbzhOQjFpL3A4?=
 =?utf-8?B?c0RoU3VkbERiR1NGWEpybmNIRU0vVXppUkF3RCtZeVVkQ2pTVlI4OUxvbHJL?=
 =?utf-8?B?OFduTlhkdUNxbGFWZTM5U3F4SkIxcjRERE5BMFpxYm1PejFTenRQU0l2OUNw?=
 =?utf-8?B?SXdibXlYQ0FOOXFWSVJaTk0yYzlJdG9aSVllZUtkWUl6ZUFtS2RTbW1RS1hn?=
 =?utf-8?B?bnZYYTFYUVJpd3czWURPb1BNaG9Zbmk1L1U2dENSaThWK2hrdTNTcWFrUFNT?=
 =?utf-8?B?RlFNK05nV3h2L2xadlp5dkY2eU1TaWdpOVoycm94K0RNd2NpWS9CdERVLzcx?=
 =?utf-8?B?blBtVFI0SVFXTGt1ZHg3UG0rZTNqdmp3dDF4MDZCcmdJWUtLVDg2VDFRekUv?=
 =?utf-8?B?R3A2c01aaE9LYW51c3JNVkJmZy81WHQ2ZE9FM0QwMlRqYys5ZEFnVUpUR1Iz?=
 =?utf-8?B?cURQYWpEcjVoQ2VJQk0yaENxT2NmNGFQejRFVmZ4bE8yMHBrNmFVTU9SeXBR?=
 =?utf-8?B?S1lHOVFIVlpGY1VCMk14RU1GdjZuTTFxUTYwTUpNTC9YKzhVZUUyVFo1emxj?=
 =?utf-8?B?UytndzhFRmJBR0lCdXNJaFRoQ0k3S1hBdnNBT3hSSzhmWUV1dlRkcEN3bGQz?=
 =?utf-8?B?K1dRaU5jZGlqVnRwZHJrOWptdFl1NElEczhEb243aE9RNEczUkY5NDVVZmp5?=
 =?utf-8?B?QWVmMllOcGJOUnVlQkx4SDA4UVg4QjdkVDBKZG1PL1FScmh4ZEQ4RDBObnNJ?=
 =?utf-8?B?Z08rUGlOMFlmaDdNWWZFMnRPUEphNzdOQjJLd3BpTGR1VUhIME15MTVveXkv?=
 =?utf-8?B?MHkrUG1TVE9oT3loVjhvME9xaDdNVmdjZkNzc1ZWUCs4ZEJQTEpIQ05UMzhP?=
 =?utf-8?B?cWxQYnpkblppOG14a1VSWU5jUUJScVpjS0s1WTZFelFBK3ZEZW54QTZRTnRm?=
 =?utf-8?B?UFF4YkkvQ1NiUXZEYUxEeGQ1aGw1RXNjaGhuRXdDaEo5ZkdqbDFpZmE0WW5p?=
 =?utf-8?B?TzhIMjN5TWE3dTl3RS9STEpyYUpTdnk4Z3VmUm1VMlg2R1lEYUE4VTZCbFNq?=
 =?utf-8?B?dC9uTm9ZVXVhdWRrRS9wSEdYd1djTXpaU1U1VFExdklsckxDOGRVTmpqZHpj?=
 =?utf-8?B?R3pVamFCV0djNWtpMWg2empuWkV4amxjdFRpRGJrblpoQUNTei9hRHAxTGhy?=
 =?utf-8?B?a2JBZkQ2RVZXNGZFanJ4YjBRVTMyKzRaL0lCaHFYT0xqejlNWFVuQVdOZ3lw?=
 =?utf-8?B?aXBDb2djQWt3K0VnTHBaOEZFemZVbkNEL3B3cE0zYk1iOVJOQlgwejBZOFl0?=
 =?utf-8?B?VU8xUFErd3JTMkw2RGwvV3JGc25QRi9BTFVwUDZYQUJwT2ZIU0wwMjd2U1M3?=
 =?utf-8?B?eVQrUEtOb0xUb28xU1F1cWhVenVrWUhTajI0TlJqZ0VVOGE1N3dKSHJMQjM0?=
 =?utf-8?Q?zab8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7585.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aff4461-5f68-4d07-a1a8-08dce6d72133
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2024 13:51:22.9067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L8eM+4Lair2eIxczUwXteGneLviYdhKRvFZcBInI5DlA/zj0mgWaJ41VUVZwGZgcYreqIGmeosyLvYVgHp7SFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8388
X-OriginatorOrg: intel.com

SGkgTHVpeiwNCg0KVGhhbmtzIGZvciB0aGUgY29tbWVudHMuDQoNCj4tLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPkZyb206IEx1aXogQXVndXN0byB2b24gRGVudHogPGx1aXouZGVudHpAZ21h
aWwuY29tPg0KPlNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMSwgMjAyNCA4OjAzIFBNDQo+VG86IEss
IEtpcmFuIDxraXJhbi5rQGludGVsLmNvbT4NCj5DYzogbGludXgtYmx1ZXRvb3RoQHZnZXIua2Vy
bmVsLm9yZzsgU3JpdmF0c2EsIFJhdmlzaGFua2FyDQo+PHJhdmlzaGFua2FyLnNyaXZhdHNhQGlu
dGVsLmNvbT47IFR1bWt1ciBOYXJheWFuLCBDaGV0aGFuDQo+PGNoZXRoYW4udHVta3VyLm5hcmF5
YW5AaW50ZWwuY29tPjsgRGV2ZWdvd2RhLCBDaGFuZHJhc2hla2FyDQo+PGNoYW5kcmFzaGVrYXIu
ZGV2ZWdvd2RhQGludGVsLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYxIDEvMl0gQmx1ZXRv
b3RoOiBidGludGVsX3BjaWU6IEFkZCBoYW5kc2hha2UgYmV0d2Vlbg0KPmRyaXZlciBhbmQgZmly
bXdhcmUNCj4NCj5IaSBLaXJhbiwNCj4NCj5PbiBUdWUsIE9jdCAxLCAyMDI0IGF0IDY6MjnigK9B
TSBLaXJhbiBLIDxraXJhbi5rQGludGVsLmNvbT4gd3JvdGU6DQo+Pg0KPj4gVGhlIGZvbGxvd2lu
ZyBoYW5kc2hha2UgbWVjaGFuaXNtIG5lZWRzIGJlIGZvbGxvd2VkIGFmdGVyIGZpcm13YXJlDQo+
PiBkb3dubG9hZCBpcyBjb21wbGV0ZWQgdG8gYnJpbmcgdGhlIGZpcm13YXJlIHRvIHJ1bm5pbmcg
c3RhdGUuDQo+Pg0KPj4gQWZ0ZXIgZmlybXdhcmUgZnJhZ21lbnRzIG9mIE9wZXJhdGlvbmFsIGlt
YWdlIGFyZSBkb3dubG9hZGVkIGFuZA0KPj4gc2VjdXJlIHNlbmRzIHJlc3VsdCBvZiB0aGUgaW1h
Z2Ugc3VjY2VlZHMsDQo+Pg0KPj4gMS4gRHJpdmVyIHNlbmRzIEhDSSBJbnRlbCByZXNldCB3aXRo
IGJvb3Qgb3B0aW9uICMxIHRvIHN3aXRjaCBGVyBpbWFnZS4NCj4+IDIuIEZXIHNlbmRzIEFsaXZl
IEdQWzBdIE1TSXgNCj4+IDMuIERyaXZlciBlbmFibGVzIGRhdGEgcGF0aCAoZG9vcmJlbGwgMHg0
NjAgZm9yIFJCRHMsIGV0Yy4uLikgNC4NCj4+IERyaXZlciBnZXRzIEJvb3R1cCBldmVudCBmcm9t
IGZpcm13YXJlIDUuIERyaXZlciBwZXJmb3JtcyBEMCBlbnRyeSB0bw0KPj4gZGV2aWNlIChXUklU
RSB0byBJUENfU2xlZXBfQ29udHJvbCA9MHgwKSA2LiBGVyBzZW5kcyBBbGl2ZSBHUFswXSBNU0l4
DQo+PiA3LiBEZXZpY2UgaG9zdCBpbnRlcmZhY2UgaXMgZnVsbHkgc2V0IGZvciBCVCBwcm90b2Nv
bCBzdGFjayBvcGVyYXRpb24uDQo+PiA4LiBEcml2ZXIgbWF5IG9wdGlvbmFsbHkgZ2V0IGRlYnVn
IGV2ZW50IHdpdGggSUQgMHg5NyB3aGljaCBjYW4gYmUNCj4+IGRyb3BwZWQNCj4NCj5XZSBzaG91
bGQgcHJvYmFibHkgc3RhcnQgdmVyc2lvbmluZyB0aGUgYm9vdCBzZXF1ZW5jZSBmcm9tIHRoZSB2
ZXJ5DQo+YmVnaW5uaW5nLCANCg0KQWNrLiBJIHdpbGwgc3RhcnQgYWRkaW5nIHRoZSB2ZXJzaW9u
IGluZm9ybWF0aW9uIGFzIGNvbW1lbnRzIGluIGNvZGUuDQoNCkkgYWxzbyB3b25kZXIgaWYgd2Ug
c2hvdWxkIHByb21vdGUgdGhlIHVzZSB1c2FnZSBvZiBzb21ldGhpbmcgbGlrZQ0KPnRoZSBoY2lf
aW5pdF9zdGFnZV9zeW5jIGZvciBzdWNoIHVzZSBjYXNlcyBzbyBvbmUgY2FuIGNsZWFybHkgZGVm
aW5lIGVhY2ggc3RlcA0KPnNlcGFyYXRlbHkgYXMgYSBmdW5jdGlvbiB3aGljaCBtYWtlcyBpdCB2
ZXJ5IHNpbXBsZSB0byByZXVzZSB0aGVtIGluIGRpZmZlcmVudA0KPmluaXQgc3RhZ2UgKG9wZXJh
dGlvbmFsIHZzIGludGVybWVkaWF0ZSkuDQo+DQoNCkkgd29uZGVyIHRoaXMgbWlnaHQgbW9yZSBj
b21wbGV4aXR5IGluIGhhbmRsaW5nIGJvdGggVVNCIGFuZCBQQ0lFIHRyYW5zcG9ydCBhcyBtb3N0
IG9mIHRoZSBmaXJtd2FyZSBkb3dubG9hZCBjb2RlIGlzIHNoYXJlZCBiZXR3ZWVuIHRoZW0uDQoN
Cj4+IEZvciBJbnRlcm1lZGlhdGUgbG9hZGdlciBpbWFnZSwgYWxsIHRoZSBhYm92ZSBzdGVwcyBh
cmUgYXBwbGljYWJsZQ0KPj4gZXhwY2VwdCAjNSBhbmQgIzYuDQo+Pg0KPj4gT24gSENJX09QX1JF
U0VULCBmaXJtd2FyZSByYWlzZXMgYWxpdmUgaW50ZXJydXB0LiBEcml2ZXIgbmVlZHMgdG8gd2Fp
dA0KPj4gZm9yIGl0IGJlZm9yZSBwYXNzaW5nIGNvbnRyb2wgb3ZlciB0byBibHVldG9vdGggc3Rh
Y2suDQo+Pg0KPj4gQ28tZGV2ZWxvcGVkLWJ5OiBEZXZlZ293ZGEgQ2hhbmRyYXNoZWthcg0KPj4g
PGNoYW5kcmFzaGVrYXIuZGV2ZWdvd2RhQGludGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IERl
dmVnb3dkYSBDaGFuZHJhc2hla2FyDQo+PiA8Y2hhbmRyYXNoZWthci5kZXZlZ293ZGFAaW50ZWwu
Y29tPg0KPj4gU2lnbmVkLW9mZi1ieTogS2lyYW4gSyA8a2lyYW4ua0BpbnRlbC5jb20+DQo+PiAt
LS0NCj4+ICBkcml2ZXJzL2JsdWV0b290aC9idGludGVsLmMgICAgICB8ICA1NiArKysrKystDQo+
PiAgZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5oICAgICAgfCAgIDcgKw0KPj4gIGRyaXZlcnMv
Ymx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5jIHwgMjYyDQo+PiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKystICBkcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuaCB8DQo+PiAxNiArLQ0K
Pj4gIDQgZmlsZXMgY2hhbmdlZCwgMzI5IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ0K
Pj4NCg0KVGhhbmtzLA0KS2lyYW4NCg0K
