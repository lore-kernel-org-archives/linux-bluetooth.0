Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1EC15253D
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 09:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719567472; cv=fail; b=EehlQhsdG/xqssc+LOSND85djDXDHkSm9J5999hjdS7f/57442JYA/dmw6RFN2HBPCgBAZv0kcN3+nzv055P9POTZNeHVLcrPnBP5eUIzN4Q7hvT3n9LlTZruiODECzylCBM3+88uGMuT8XEhXzezHuD0/JuY4NUxiyQf8mIxag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719567472; c=relaxed/simple;
	bh=95SrRdsMVkEdeVadlmegzSeGRoRNnfghydONSeHot6w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oISvpZp8mFZYA4sQ3I0fTQiNSut2F1HyIE3bmprDhD6A96ko7zRSqvF9sJEIVtW0IuFLgy80S/Gv2CzzidOnnJLKCPCPIEG3X3LxS7+PnADgILtWSnekyhmehoaBFN3hy+pWfpQGF+njamwSCUeA6QfugTS1C6KtGfzjFDwTUOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lVgSo5yx; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lVgSo5yx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719567471; x=1751103471;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=95SrRdsMVkEdeVadlmegzSeGRoRNnfghydONSeHot6w=;
  b=lVgSo5yxzS5c/sZPSyjTU1IVX/+84ZuI8Dgq+RAVEtjtAS3rtP7yifBH
   CCeEX8VpIQfut1uaJpWnzjWaAT+BD2tbaD/IaYgtjDvZN4x9NaSgs+2lR
   8opLcYh70WZKbQ1Dok8nkSIx/xGQT9lHqIksq+UifmuGmE8IafqtLZ09S
   IB7J4QGULFb42MVxjM52rRVzwoRgreZjhRzwt1UIIE8KY7CvGJ9a6cJ72
   CI83wQOsH63Mtnz5yjdScWjEB98jkx3KYsPHvr4Kt6fdnHhVz2fFUw33h
   CnkgazyI0VwR6ec+41xBRSpq6RmvVthAm/ZB/hkbcBrCDw2NTEt9OmOrp
   g==;
X-CSE-ConnectionGUID: dPgAr6zURTOzRGA+YhL7iA==
X-CSE-MsgGUID: NbO86z8kR22ZQRwEZRyF7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="20502890"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="20502890"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 02:37:51 -0700
X-CSE-ConnectionGUID: 2FhzLlukTnyFPaKvJI8WUA==
X-CSE-MsgGUID: R5Frl3TWR8a7Qksdzm8X2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="82231135"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jun 2024 02:37:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 02:37:49 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 28 Jun 2024 02:37:49 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 02:37:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNmFRz9rIcL1GrfJkfgHRShRf6/iAMHCDUzDelMB4bZWJl6PAFHzZTn1O0gfgAmD5BqnjMxg9HO19sOyzTXjJMz7MMPOe5J9UfaPvFG/MheqW4ipOqN/cS8A/dJKAs3w97AvreWXe+XRYxVoBGcPVlPPwGJmqM1AD0Cue9TFWQa2gyCOUaqrwLRsr4TN4BlWKH/5XhWh5/e8XH1rY6mhFhf6cUEFFOv5lqyxT66n9E1eCwXJbg44aM8NdKAQ+yIZXlMtWQe54xyy8XxY2XdbGzZ7qgz8ZfrY5VT9GwJnqxsJf+kUWmSL3S93+/phnWdzMMhUBpS1vnKjxBFdDQ7awQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95SrRdsMVkEdeVadlmegzSeGRoRNnfghydONSeHot6w=;
 b=OnEFpgz1A+Jbm9SFmsXeR8Cp+yowN9/iuf2vgnkynixnWF3V4t/gEN4MlhQP0VAsIrBC2G98heGcFDC+xTOwUIKy6BoA2G9ckSSXHXdvpkmZajsyO1PB4F/+mrZpgGQXRhrZ33Or05CgG1xvHeS/R/2MDpWxGAAVQBQn7+PKloLp2s30hVaVF5EkCZW2Qzwmw6Jn275OjUqj6gd7MoQQGI7pSdKAOXWPxntrXyy3Y5X6lOzaQW9CrNiEJK9E2qW3v09W1hKhAdlnbucXISSGYRFG42L4DC+pKCK/uHOucUTyB7P2WUxHtP8y7Z2eD0M9Re9mhmyi+aBJAR+c86DDyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by PH7PR11MB6859.namprd11.prod.outlook.com (2603:10b6:510:1ef::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 09:37:42 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%7]) with mapi id 15.20.7698.033; Fri, 28 Jun 2024
 09:37:42 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, "Devegowda, Chandrashekar"
	<chandrashekar.devegowda@intel.com>, "Satija, Vijay"
	<vijay.satija@intel.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v3] Bluetooth: btintel: Allow lowering of drive strength
 of BRI
Thread-Topic: [PATCH v3] Bluetooth: btintel: Allow lowering of drive strength
 of BRI
Thread-Index: AQHax6kjeYSrWj+1tUOOSiEx27rXDLHZ+LmAgADSwUCAAGmfAIABr9rg
Date: Fri, 28 Jun 2024 09:37:42 +0000
Message-ID: <PH0PR11MB758565928C5A66E618BF38EDF5D02@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20240626092801.2343844-1-kiran.k@intel.com>
 <390bb99a-55ce-4a97-b268-93ce62bedbac@molgen.mpg.de>
 <PH0PR11MB7585AD51482CA4FC1F1035A9F5D72@PH0PR11MB7585.namprd11.prod.outlook.com>
 <5a5027f2-dbe0-41c6-abdd-c1ac9605cfd2@molgen.mpg.de>
In-Reply-To: <5a5027f2-dbe0-41c6-abdd-c1ac9605cfd2@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|PH7PR11MB6859:EE_
x-ms-office365-filtering-correlation-id: b461a2a3-d6db-4939-09d3-08dc9755f52b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aHlDcjZCRmlhaWhiMkRhaWV6VTFUTFVHRWxTWTZyYmJGOS9GSWtXbXdTNGhj?=
 =?utf-8?B?V2VNQmVhVnBEZkh1NmZpTDh1RHlzaENsWThENzlvRVRVQ21YTlRKanpla1F2?=
 =?utf-8?B?L2VqM0xGYzlDUzlWU2lhWE5ybGx2YmtkbEtNTGhhWmdWT2ozVXRsT0czUGhG?=
 =?utf-8?B?VCtuMnREQUo2YWU5cWppZnordmp3SmQ1OEVxSnovcDc3T0ZVTnliNFA4RE05?=
 =?utf-8?B?dmZZblJyRTYwelFYQzlWbGxoMkF5VjcyclJmNW04cGVNZERkZHFxZ0JqOVA0?=
 =?utf-8?B?ay9xMDJYMDZnaDBWSEJUMll0NG1vL0JkWlQ0cjhRL1NKOTBnRnZpZUVqN0VK?=
 =?utf-8?B?aE5lNFVmck81bWM1aGtMcFhWZTZKUVJlWEFpMDVaWEIyTi95YjcwbnlXNmZJ?=
 =?utf-8?B?ZzRCUk4xYW9Hczd5VytkUG51TDFHc0N3T3RWR2ZydHF1UnhwcnVRWDdzUFp1?=
 =?utf-8?B?dWc5MVphbnFtWmUrWnR3RFl1U2liRzVKeVZkVTEzOFFxMm14S3l2bDhSczRl?=
 =?utf-8?B?R3EvZC81dEZFMmdyVWZsdllybDF5NXBEdlkyZkdScWRRbG4yN2tDbUFIMHhw?=
 =?utf-8?B?bVB6UUtYTEpaNFBtN0lEOGw3UmV2R2FPcUxzY2FZRFhrTERsWFArS1Y1dHZa?=
 =?utf-8?B?L3JWNWxjSnNEZmtEMjN0ajcrbFR2c1Nrelp2dVllUlBuWXJxN1kyUEM2R291?=
 =?utf-8?B?VzVhTmJ1SkF1LzlmSzlIa01tRmJBYk5xVytYbmlpZHJ6RzZINzFPKzQrc2VG?=
 =?utf-8?B?dTEzRDFSdEpiOEJWK1AxY1NCeHdaZUF0dkM0c1BwZmU3OEZOUDl3bmRBeU4v?=
 =?utf-8?B?RkpTT1FydGlrRld2R1l6WUtBc244VFBCVEJKdDlwVzFYclNiMTdxcG5zNnN0?=
 =?utf-8?B?dDdrY1IvT011WUU2S1cwdksrUHJsenV1a0NxKzZRRWVJTUhNOUNsa3BPdG1j?=
 =?utf-8?B?YWtLMjJiTXVyV2JWU0JoaW50ajN5aERaWjZ5cE5vd1FPSVFDWlhvUTh1TEh1?=
 =?utf-8?B?TUwrYVkvZjhDZHRhM3JhV21OMVg0NkJGbzN2ZjdPcGlWMEJ5WjlkT0pSeXgw?=
 =?utf-8?B?OGdUblhuS0hGazJIZnFoQW5ob2RjcmFPREZncGJ3RC8rcGVKL2YwQmZkM3lO?=
 =?utf-8?B?bzVxbjJKNi94S3AxTk1aOGg2azBxdGlGTG1BaVNUZmNyVnQrYlRVUEZaa0JZ?=
 =?utf-8?B?d0dKQm5BNVNLSHhqdEhmSzB5Y21SZHRFYm9QaTlYYThKNVlyLzZoTlJucWpr?=
 =?utf-8?B?RTZCQ1pXSmhrbHkvTGJLSDY3am1iU0xYVWEvV1FrOVAyK0p4em1yNjNqZWhk?=
 =?utf-8?B?MFdBM3BkRGZMT3dGN3JwRWZlT1JleVQ1U1lrTkFjVUNobHF1czJQWTgxM2Vs?=
 =?utf-8?B?SVpsUWJabFEybVBjeW5GTzczcElHUFpxcGpsS0NYdEJDcmpCOUJJcnhTbTJv?=
 =?utf-8?B?d3dmaWEzWUdvT011K0ZvckVUUWhmNC9rbmRzWmkzckQ5R3lNekdMcTRSRFBa?=
 =?utf-8?B?cmpQV1VKMjBVQXQ4clkwYVdwMEhnejZDSE5GUE45U3FybW52U2RtU1hJdkw0?=
 =?utf-8?B?UURaVkYrN09vYzh2dnV3OHZ3ZlNKYmc3dzZyWFRrV3YyNTBsRGlsTUlDNUlT?=
 =?utf-8?B?L0I4S0hTeVhaaEpGWTVKcnFyaDZFSTdSa3I0QjBEMk1VNDkxRXQwNkZXT2VX?=
 =?utf-8?B?K21SSlRydWo5UUhZZmtCZWJHMFV0MFFtNUxQNCswU3AyeHV4NWFiNHdXTU83?=
 =?utf-8?B?RVB1ZGJIcUNXVlBVcWJybXNCMTNLT2pDOGZNM292V29MZ0ZGNjhYSFlOSnV0?=
 =?utf-8?B?WVYzT2l5Ry9mNU9ydUhINTN3b3B3VWFOYy81dGZuczlUeTdZUFhPb0pTb2c5?=
 =?utf-8?B?Q3dRZjhXNzJvTVNIUnBrTk9OQmRPZ0NWdk9RMFRuNWNFR1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2s1eFp0UFQ3MlNWNEF5MGt4c1NrbnAyUGo3bFdrMXJuNFY2K09MWHRpdXJQ?=
 =?utf-8?B?b1hYU0cyTmpsWU0zN3dCNk1oTjVicVZRQmlLYnZ3VlUxb09nNkdpSGpYNG1Z?=
 =?utf-8?B?SDUyeW5EVzlES1ZtcEJ0UW91bE8vdUJGUzk2SHkwZHgyZGFBYldtZWFGa3ZQ?=
 =?utf-8?B?ZnU1aFptT2VORlhiTVczN1hVY1dyTU9sRjFKM3lQdnBlM2R6Tk1tVzhQWFMv?=
 =?utf-8?B?K0t4aGNjenJGVi9pOGJiS1Z5WWMzQk1OMmFpalJ5dHRaSnlQeU1mSDZYNHgy?=
 =?utf-8?B?K0hUSUN4VUt4YmRKQUpzRzhRVHFUR3MvellaWXVpYVlaeXB2UmFwaFVUclJE?=
 =?utf-8?B?Zmk0eVh2d3lJZ1FDbnU5ZHZsMCtxRmR6RmFmK2djdHYzM2JWRFd6Nm1FcXRF?=
 =?utf-8?B?aTdmQjFQVENRT1JNTWQwZGUvakdVME5ERFVRYUFmdVdLTnVhUWpiV0dRaTlH?=
 =?utf-8?B?azgzNUxpTnM4VjcvbUN4ZVhOakRBdmhNbUE3czE4MCtjZ0E0OGhqYVFxK1p6?=
 =?utf-8?B?a3RuYnVEUStBMElkNkRTK0g4N3pybUtGY3d5WjFEZHZDeTZLMUdKWlFoS2NH?=
 =?utf-8?B?Kzk1Lzd6Rk01WHB5SkZwTU9tdUJTU0pPNXluWVJNU3JTNHI3NkNSNGxvNy9K?=
 =?utf-8?B?bjMvTWZEdnNaMHBZdFFEUm9tQUIxSEhiQko4K2R4RFc4Q25rUHJicXZHY3Bz?=
 =?utf-8?B?ZUVLL1VBKzJ4MVpLQ0lGWEpXVCt1SWRhamlFNUZXcURkQkR2RDFOb3hFeFNS?=
 =?utf-8?B?NnNsM25Ed3dQdWUzTU1ENVpFVzBsMVNQeENGdk1ZOEJ1N25GZmtmSnE3eHgx?=
 =?utf-8?B?WTUySm9hdGU4aWJNTVAvUFo0KzRxdjExUnpwUjU4L05NbUozZmdLeE1mbWsz?=
 =?utf-8?B?aUpPaHByUjNPR3k5bk5IQmt3MW9sUXJwZVozdkZPSjIwZjJqaThvdWhmWlN6?=
 =?utf-8?B?cFRKYXMweitxQWQrV2IxaXFzeWZkMUYvckpPLy9MWDhQMC84T1ZuakZNNHpW?=
 =?utf-8?B?Rys0WkxQbjBudU5tVGJ3ekNBUHJOemJDdEdhRG11TUJnY29aMHlkM0k1ZVhV?=
 =?utf-8?B?Z1lGaVFWeFpUdDRIOU9tZGFlSXZ0QW1WTE1YdUkva2d1amVPYzIvTCs5SE1r?=
 =?utf-8?B?cXFocmovV0FwUU15VzlJOHllY0QybGZEVlZkTnpycjU1UkdwZm43VzBFSGg1?=
 =?utf-8?B?dGVPUmdia1RRUXVqVzlyZFExRTNBNnpjV1BUN1VhVkQ0SCtUVm5NOGljcFRy?=
 =?utf-8?B?K2xEdlltLzNyS2FaTnB2UDN6b25YazFXTmNtdklnSVhBem1rd3RXMHd6eXFO?=
 =?utf-8?B?N3ZtcjJIc3hrOFVnc0ZpRWM0cVBxeHlWM2Y5cEJzeHpHUWxSdysxTStncjlC?=
 =?utf-8?B?ZmQzMWx0UUtiTDMyd2VsSkc3S2VmTXBXak0xVmtDKzZTKzJWdkdySXoyRVZv?=
 =?utf-8?B?eExpTHpwLzJJbThSRHIwdENDYWhXL09hVlBaMFhodytoUFFucng1TElmQm1Z?=
 =?utf-8?B?bXhCWHgwcldRaWhwWjE0VGtNdFdoVDIzYUQvNy9qNmNjTVZUQnpUMitzMTlW?=
 =?utf-8?B?S09UeVYvaUZvMURvbTJZZ1JFWndoaUdVajVxRmpJTUo5UFV1aC9WNnNlWUpZ?=
 =?utf-8?B?QzR0dEwyT0htdEpFVUJDbS9MSWpVRm1tUHBRdGxsbHFVTDJFcHcvRVp3VHky?=
 =?utf-8?B?cFozd3pSM21oUjBScWN2S1c1NmZYZWFTRi9qNkVxMlJkRkk5Z2dGL29TczR2?=
 =?utf-8?B?dk5CVUlvazBqWDZWbGtXVFlUaGhJQk9vK1NhYnMrQXJTeTZzM1VESUtCMXM4?=
 =?utf-8?B?SEZkK05iMFJjeEFxVTY1bU5wNkx4VUZpMnlKZlBzRVlHZENZcDByR3FBS29o?=
 =?utf-8?B?VWl6YUQzT2tsYlBBNTJZcFpVZ29JcGNwdURqRzZsNmZld0VUMjkyZ3pydnRl?=
 =?utf-8?B?WlFWc0FZM2p5YnhhT0FJUVdIaWZwTUNnYzZya3JISVZ6NGlYcjM3YVN4TTY4?=
 =?utf-8?B?NVl6WUlUeXlVUGpidVA3ZHlNRWRMSjA3L0tSaTZaN0FyZ2x6NTI4SmcwSnVJ?=
 =?utf-8?B?NVdXemVhNC9XS0ZpRS9HdnlJb2pvalhVMUNBV0xaL2FQUE0xNmE3WUpxWEJX?=
 =?utf-8?Q?SI4I=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b461a2a3-d6db-4939-09d3-08dc9755f52b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 09:37:42.0420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wIB8/FV8y1Dhq9fPgKoHkYmX4fuEW9nZgI/2il3n9cpYnkR24k4uCn66CD+/zHxhqQD5iSiD7YqnR0JQvNCD2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6859
X-OriginatorOrg: intel.com

SGkgUGF1bCwNCg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjNdIEJsdWV0b290aDogYnRpbnRlbDog
QWxsb3cgbG93ZXJpbmcgb2YgZHJpdmUgc3RyZW5ndGggb2YNCj5CUkkNCj4NCj5EZWFyIEtpcmFu
LA0KPg0KPg0KPlRoYW5rIHlvdSBmb3IgeW91ciByZXBseS4NCj4NCj5BbSAyNy4wNi4yNCB1bSAw
MzowMyBzY2hyaWViIEssIEtpcmFuOg0KPg0KPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+Pj4gRnJvbTogUGF1bCBNZW56ZWwgPHBtZW56ZWxAbW9sZ2VuLm1wZy5kZT4NCj4+PiBTZW50
OiBXZWRuZXNkYXksIEp1bmUgMjYsIDIwMjQgNTo1NiBQTQ0KPg0KPlvigKZdDQo+DQo+Pj4gQW0g
MjYuMDYuMjQgdW0gMTE6Mjggc2NocmllYiBLaXJhbiBLOg0KPj4+PiBCUkkgKEJsdWV0b290aCBS
YWRpbyBJbnRlcmZhY2UpIHRyYWZmaWMgZnJvbSBDTlZyIHRvIENOVmkgd2FzIGZvdW5kDQo+Pj4+
IGNhdXNpbmcgY3Jvc3MgdGFsayBzdGVwIGVycm9ycyB0byBXaUZpLiBBcyBhIHdvcmthcm91bmQs
IGRyaXZlcg0KPj4+PiBuZWVkcyB0byByZWR1Y2UgdGhlIGRyaXZlIHN0cmVuZ3RoIG9mIEJSSS4g
RHVyaW5nICpzZXR1cCosIGRyaXZlcg0KPj4+PiByZWFkcyB0aGUgZHJpdmUgc3RyZW5ndGggdmFs
dWUgZnJvbSBlZmkgdmFyaWFibGUgYW5kIHBhc3NlcyBpdCB0bw0KPj4+PiB0aGUgY29udHJvbGxl
ciB2aWEgdmVuZG9yIHNwZWNpZmljIGNvbW1hbmQgd2l0aCBvcGNvZGUgMHhmYzBhLg0KPj4+DQo+
Pj4gSSBhbSBzdGlsbCBzdXJwcmlzZWQgdGhpcyBpcyBkb25lIHZpYSBhbiBFRkkgdmFyaWFibGUu
IENvdWxkIHlvdQ0KPj4+IHBsZWFzZSBhZGQgYSByZWZlcmVuY2UgdG8gc2VjdGlvbiBpbiB0aGUg
VUVGSSg/KSBzcGVjaWZpY2F0aW9uPw0KPj4+IEhvcGVmdWxseSB0aGF0IGV4cGxhaW5zIHdobyBp
cyBzdXBwb3NlZCB0byBzZXQgdGhlIHZhcmlhYmxlLg0KPj4NCj4+ICJVZWZpQ252Q29tbW9uRFNC
UiIgZWZpICB2YXJpYWJsZSB3b3VsZCBiZSBjcmVhdGVkIGJ5IE9FTXMuDQo+DQo+SXNu4oCZdCB0
aGF0IGFwcHJvYWNoIGZ1bmRhbWVudGFsbHkgYnJva2VuPyBIb3cgZG8gdGhlIE9FTXMga25vdywg
d2hhdA0KPnZhcmlhYmxlIHRvIHNldC4gSXQgbmVlZHMgdG8gYmUgc3RhbmRhcmRpemVkIHNvbWV3
aGVyZSAobmFtZSBhbmQgYWxsb3dlZA0KPnZhbHVlcykuIEFsc28sIHRoZXJlIGFyZSBub24tVUVG
SSBmaXJtd2FyZXMsIGxpa2UgY29yZWJvb3QgYmFzZWQsIHVzZWQsIGZvcg0KPmV4YW1wbGUsIHdp
dGggR29vZ2xlIENocm9tZWJvb2tzLiBMYXN0bHksIHVzZXJzIGNhbiBtYW5pcHVsYXRlIFVFRkkN
Cj52YXJpYWJsZXMgdG8gbXkga25vd2xlZGdlLg0KDQpJbnRlbCBzaGFyZXMgdGhlIGluZm9ybWF0
aW9uIGFib3V0IHRoZSBVRUZJIHZhcmlhYmxlcyB0byBjdXN0b21lcnMgKHZpYSBjb25maWRlbnRp
YWwgZG9jdW1lbnRzKS4gT0VNcyBtYXkgbW9kaWZ5IHRoZXNlIHZhcmlhYmxlcyBiYXNlZCBvbiB0
aGUgcGxhdGZvcm0gLyByZS13b3JrIC8gQlQgTklDIGV0Yy4gQWxzbyB0aGVzZSB2YXJpYWJsZXMg
YXJlIGxvY2tlZCBpbiBCSU9TLCBzbyBJIGJlbGlldmUgaXRzIG5vdCBwb3NzaWJsZSB0byBtb2Rp
ZnkgdGhlc2UgdmFsdWVzIGxhdGVyLg0KRm9yIG5vbi1VRUZJIGZpcm13YXJlcywgIGRyaXZlciB3
b3VsZCBmZXRjaCB0aGUgZGF0YSBmcm9tIEJJT1MgZnJvbSBBQ1BJIHRhYmxlLiBDdXJyZW50bHkg
d2UgZG9u4oCZdCBoYXZlIHJlcXVpcmVtZW50IHRvIHN1cHBvcnQgY29yZSBib290LiBJIHdvdWxk
IHN1Ym1pdCBwYXRjaGVzIGZvciB0aGUgc2FtZSBpZiBpdCBjb21lcyBpbiBmdXR1cmUgOikNCiAN
Cj4NCj4NCj5LaW5kIHJlZ2FyZHMsDQo+DQo+UGF1bA0KDQpUaGFua3MsDQpLaXJhbg0KDQo=
