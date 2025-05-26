Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442D220296A
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 May 2025 15:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748275029; cv=fail; b=jeonjKpoAZTTgZlP7UnFcPTG9ecsW78tAsKZ+u5yrhAJMxzrtAqGCGHkf/2jdPLA0wTEEkiWyfLMRSgBIH3DRAVo+ZpigsOo5lSI/ELxkV2WHMP2PBxgrFaIh0apsVUC38nWwIdVcX6hgTXo2jOs2blTuJP6DssuttTvRNWS0b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748275029; c=relaxed/simple;
	bh=linV+1k9FTaGIgvf4/qcnQ1+NZdqX7+ZaOKY5VOfsgs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kfS8K5AbDZ/dObPz9KZGDMuv8XgjseXWtN2MoibxMJZlC2bghUSIMYgPs7gL9H+r+WGdr7NAuddDHhK17ts5AUVlVW9QsZ1tbVD9GE71AiBRsUNgfb+sm+1p5iv5LMl+f3oRcinydpvknfah7P2fUnaOzl4SrxSGeSVtWBL7/sQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d39kCyl5; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d39kCyl5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748275027; x=1779811027;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=linV+1k9FTaGIgvf4/qcnQ1+NZdqX7+ZaOKY5VOfsgs=;
  b=d39kCyl5TKTACktmk9cAa75yictX5JwYjNSCZxYb+ebErceScuHppHxX
   9g539WxO9F+AEFAoUsKq2Q6Dt8lqTr2Yw3nvPQEGFBZ1mSv+tAmaQDjp5
   Y4SADSZkvRmiUDMSef2bnZQDhnuvnB68A2u4M9ibjepTrRabLfkGC41/D
   QMr18lDXrXjV9VSkJnjvOhawhd6KwXgecfZ27IZvkZKEw+t+WFN9qYl2o
   v35nKzQYmC1g8rHWAZplJPHdpadcff0GkQQrE2wN8f5DF/ukCHudFzKPS
   U3BgW2/IzJZP5wmfj2141CTg2FiHiLuLuRsROD0MlICtShM1gR6JepD5w
   A==;
X-CSE-ConnectionGUID: wbFLfD4dQe+cQGpl5EMOuw==
X-CSE-MsgGUID: q4tymtuVTTej+s+FxKx3gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="37883578"
X-IronPort-AV: E=Sophos;i="6.15,316,1739865600"; 
   d="scan'208";a="37883578"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 08:57:06 -0700
X-CSE-ConnectionGUID: fTvF1Yc7QU2V+j6f1fbRTA==
X-CSE-MsgGUID: Lbs7l4GES5y1ze8YFYiDRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,316,1739865600"; 
   d="scan'208";a="142436907"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 08:57:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 26 May 2025 08:57:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 26 May 2025 08:57:05 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.60) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 26 May 2025 08:57:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QCiRWMZFc6jEpPxx4WLm0yVTIxJQJuB/zG3YxIK/qr7PuM6RAI7xlLFRogtau8xwn+9/CkpkPD0DYWzy+nEwEofr4CaPGWpML5lRNg27ugqt3mpNlT4D+YFn+Rr+rWZ04O+Aum8KHnduwvweYUrN/Kg/QBZ/9KFQDz9ubfBeXxWb5lH2f5/FnEzcVzl3zNqg1pZNYNN4Ot8QCiq1Z6Lwf240Ltvdh4V7cH5qdJHiRED3KKVJOan63TLyoN4f4Bsm+kEBPb8W9iYYaCBaD3OA3wOJAosue3LtSVnnl9QK67KT9pXEjIi+krx30OrQsltrxk37OcGVAR2eSkRF5ACk4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=linV+1k9FTaGIgvf4/qcnQ1+NZdqX7+ZaOKY5VOfsgs=;
 b=qWoBt5tYvC6NhLSXRgPXsJMiTBZsZczxXeTt9R4Y21AY3+Htv1HHO0J3v7kPhpcVEWBQcvUiho8BHJh0u+K+9UMp1smvexN/zHGaHVIeog3O+IoN40ZHauaG5AWFv7cQvSMC6ylZEubjqPiWi9cHBJQFckIesmisHjPvCy3lCf/nmzA+jqgQO1xgbqEi5WeLlkw0nnTbYNR3ec/ZZA7H84LbBBTfQ5IuoQv9mNl/rYPfKEsDpq6boVIFinP3X461gsIedcnoXOxjdEG7WXNtzAWwW/ezbdZdljZl4/onsAImHi0YBsL4zaYwhF6gDfvVDje9vmBbLNjVMmjC6+d6kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by SA1PR11MB6615.namprd11.prod.outlook.com (2603:10b6:806:256::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Mon, 26 May
 2025 15:56:57 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%5]) with mapi id 15.20.8769.025; Mon, 26 May 2025
 15:56:56 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>, "Devegowda, Chandrashekar"
	<chandrashekar.devegowda@intel.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, "Satija, Vijay"
	<vijay.satija@intel.com>
Subject: RE: [PATCH v1 3/3] Bluetooth: btintel_pcie: Reduce driver buffer
 posting to prevent race condition
Thread-Topic: [PATCH v1 3/3] Bluetooth: btintel_pcie: Reduce driver buffer
 posting to prevent race condition
Thread-Index: AQHbzTUl+MO30+Jw9k6G/5DqoJdbkLPi1dYAgAI40yA=
Date: Mon, 26 May 2025 15:56:56 +0000
Message-ID: <PH0PR11MB75856C3FA9ACE3A0B795F5DCF565A@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20250525053940.520283-1-kiran.k@intel.com>
 <20250525053940.520283-3-kiran.k@intel.com>
 <921c6c41-ca94-4833-a095-12162e70f90a@molgen.mpg.de>
In-Reply-To: <921c6c41-ca94-4833-a095-12162e70f90a@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|SA1PR11MB6615:EE_
x-ms-office365-filtering-correlation-id: 41858a2d-c384-401c-d6bf-08dd9c6df137
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WDhzYVF5ZFhoZ3prWWg1K0Z1Qm1jMW84TWVIVmFwczByaGdaeTF5Y3MwWHRM?=
 =?utf-8?B?a2lKWGhnd0tPakFCamxHbkVSUnA3RE5aMkx5K1JPS1NDMzE5T3RsTHZGb2d4?=
 =?utf-8?B?OGkxcjR0ZDN0YitwMHJzc2trRHlzTUl5NWRaSzJqdWFBWEpjaVNQanBJbk1E?=
 =?utf-8?B?d0oyYjhnMVZLZ3RxWUpSTkdqa1dlM1FBZno0TWphSm5nMEIxWTlXTGdMaWNH?=
 =?utf-8?B?Qzd2cXg5aGxJdUVpUTRtb1gwOHM2M1hkOCtXbWNzc0tQcmtmVWdaSmJra0Jv?=
 =?utf-8?B?WHNVcTkwMEhtRlFUUE5OMlgrVEU0UjZTYzlld1AwZnNlcWdGL0dWZkJNeThm?=
 =?utf-8?B?cThvWDBOT0M5UVRBZUFQODQzM2U3d09INm1tdGR4Qk10VXk1UVNGbVJqbW9m?=
 =?utf-8?B?TjNuMHQ3dGcwSHVLL3V2cXNKODdJQkt1RE5CQkRLMGl5MkZMZjl5UTdlYnJy?=
 =?utf-8?B?Y1QxRFVBV2daZEVUSnVvRVl2TUlvRjlRcGJ3VlNQTHF4Z2tnbnk3MThTK3Nn?=
 =?utf-8?B?aDBQWTlNVE9lZUl0UHZzRVg5Y1lkd2JGN0ovYTNqb3Q4SkNxaCtmUVAybFNr?=
 =?utf-8?B?aEVpWjBFUzI3b3lTK0RrajdSTW9oUHpoakxXRVVMN1pMR2xXME1mUHpJY05a?=
 =?utf-8?B?NkpTR21CdXFJc1g3c0JVb0hDZ29qenpKajR6OHI1cjM0TGpBZVdOaVNJM3ZB?=
 =?utf-8?B?d1M4aGdqdTRVVW9vWER3NVRoZFJ1dE55NFNQeTNVZWpVRklJMVdocWtGY1cv?=
 =?utf-8?B?WU1YS0hPTmF0dngvWXVBd1NVbXd2ZTNDTW1HaTBEbmx3ZU9wOUw0c3VOTXJv?=
 =?utf-8?B?ZzV2S2tWQmg3QWlqdERMOXgvUUVDZkJ1eUtSaHJySzVUcHVFZHRyaTNvOTVH?=
 =?utf-8?B?NnhDWUxYMUVDRUphQmFYaWtsd0d6cTJhZHFvMUxyWWkrcE5YNi9lKzZSaUFP?=
 =?utf-8?B?dWlqMUV3MmxLVzh6N0xaSGRxcERrWVZxSTIvRmoyeGFuL3dDQis1UEkwRk9H?=
 =?utf-8?B?L2I0K0dCeCtyWFR3bkdvalU2UDVMaGg0bG9Pdjlhalpld3NXMHYzQVNXOEgv?=
 =?utf-8?B?bXZhV2RpV2dNeHl2eStvV3hNYTZqenRveDFoV2pENEVualdDWFJkY0h0VDZv?=
 =?utf-8?B?ZFpRaVdvTjNXUWgyM0ZJcm1BWlUwOEY0SHR3ZUdyV1g3ZXRHV3JSTFNJUjdW?=
 =?utf-8?B?UTVrbEsvUFJMa3RhTjdOblJXckQzVGFpeDRTL3kra1E2Z3gzbzJVako1b1NM?=
 =?utf-8?B?MFI3SGptSVM4YkN3Sy83bUFwbXJOeXNjQmtCSHNsR2pwcDRDM0ZDUEFTZTd4?=
 =?utf-8?B?MEI2NFZ2T2dtNEFKZmJnNlRmTnpIY254NkFiUXlFV1pCL2ZBcVdiZTJ0elc3?=
 =?utf-8?B?TEljUlc3aHJxWW9zNkVrR3V5azE1dDJjYm0vUTMzMzhmS0dwU2dlaFdEbkNV?=
 =?utf-8?B?UFlBeGZJWll5ME9EOG1JNytWUENzL2xhNFZjclcxK2piTUZvb1BkcmdnVmVT?=
 =?utf-8?B?bGdKUncrWThlUDc1VTh0cm9vVmtFeVdHbGlibklWd3I0alZkT1I3NTRCVU9V?=
 =?utf-8?B?QzVNTnBhZ0kyN2ZvV2pQVTl1Y1VaRzB6SnM2ZVJ5djNGY1BJZTlZMHJmWjVw?=
 =?utf-8?B?QjVXYjZUendtbE5lbXFtcVRSdTRCL2tiQTl6N0VDV1hZNXJ0NFpucEJrMmo3?=
 =?utf-8?B?YXpZdlIxczUxTjMzYytLaTFXTnZXZVFhWFcyUlpaQk00VnMwQjI5anNaRHlW?=
 =?utf-8?B?RVpVa0dMdnE2VldMSm5ZaG1DVkxyWkFNeDZRNnhZM3d5OTh6Q2FKem90UzVG?=
 =?utf-8?B?L3BPc1lIRUU4UFFqNm9EWlJIbnlSZmh2Q2UzRnk3Q2szMU95eHZDdWNHL29o?=
 =?utf-8?B?cnhURWRnY1BXYjlwYkpmam8zL2JJcUlkY2hNVlF3UVU2TEdNYkpZYlJJS0VG?=
 =?utf-8?B?SU51MXIwVHJscnBveWRMc0tGYjRoSEM2aVEyNG8vejNBZTZYVkZSZ2RVcFVU?=
 =?utf-8?Q?zG2P3YVs3ukjXvOJstBKqjsPgsbcZQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S29qTTRSTi9hUmR0OTQ0Si95VVZtMXJGajVmV1ZpV29ENnJETmc4YTE2Z1pw?=
 =?utf-8?B?L0ptZEVmV1QrWkgwdHNRQUZ3aHFxNkpaVENxK2FIakhvSXYxYy9SUUxUalph?=
 =?utf-8?B?dWN2dVNoTGxpM0NiK2hzcnlyZFZSQ3NjM0JMMVFhblBXNk9UOWs3UlJqb0hP?=
 =?utf-8?B?UEpaalZoZ1UwZ2FVQ2wyWHdMcE4zdTlGbE11dXNRd0FPNjhvYW1TaGdDWU90?=
 =?utf-8?B?Y21ycW9TUThXU3V0aC9WYytRbTN1cmdyT2Q5bWZ6V0RET0laYjRqVWFNS1p4?=
 =?utf-8?B?ZnBsZUJZWTdkaXdxTDVSTG41R2ljcmJmSHdWTXJ5VTg5UEdFUnVGc2VObVNq?=
 =?utf-8?B?OUhZdnpPTkhaZUNVUVVvazZUTXN0bnBlMlg4RmJxY1ArZkFQU3duN0NacFhu?=
 =?utf-8?B?QXlPY2xyVS93eTJnbzdHc0lsdDR5QTRCVjZVMDJMcGl1enJWM3Z0bm4vSVpO?=
 =?utf-8?B?OVFjMDh4T2gwRlIyTGY0Q2dQL1BqOXFub0p6WUYyekp3aDVIa1JZdVh4dW9K?=
 =?utf-8?B?WThweklobTZKRzdpemhsZG51SnJ2T3dTY0Erckd4TWhtQ0UxeGhvSld3T3Nv?=
 =?utf-8?B?NkpWNmFjZ2FWcHFSQUpYZjdtQkcySlQraisvWkxjV2JoZmowbmd1dXJuU2Jy?=
 =?utf-8?B?d29SVE5hZG5zZ3NYZHRBTUZYSWVkT09mTTlJNTY2aXhDUXZ5T3E3ZkhoSXND?=
 =?utf-8?B?bjhPeUZsVlJnZHlnQzdzN3pCWk0vT0gwQWpGVzk0WVFDcloxMHM2NHYxZmdY?=
 =?utf-8?B?VzV2ZHN1SEJ5UjhmQ1l6Qm5HNVRGREljWXpTNmVPNmU1N0tQNUQ1S05sVFE4?=
 =?utf-8?B?UjV1YW5GOEM4UnBMSkVlZ0p4ajh6cFhRcnZSeXR3U0xRLzdNWWlVK3VaZm9l?=
 =?utf-8?B?L1pkd1NoME9aMmRUdnRNT3VWMHgydUc2T1Y3VzJHZGJNekZWVUZXWWYzazVB?=
 =?utf-8?B?akZOVzU1YWFIbTQxbW5FTUxuUmtJeGFqTGtFck01bERSM3hsUHBCRWtYRks4?=
 =?utf-8?B?elhJaG45QnBDWEp2R2R4L0tWRUUrQm5QTDNQRnkzdTd3R1VzVzBodFpqSmVS?=
 =?utf-8?B?dFhSTWhwYkp2WVBsWit4ZFBvdTlTb0pHVWVyTEIyWERXVDQwUXhPbjUvcGdw?=
 =?utf-8?B?VEVWNUNoOXowUHN1RW9qVlFIbC9pTUVCcnRXRzUxRkJGVkdraENCSWJtRDFN?=
 =?utf-8?B?d1dhcmFicVFhcmxrdEFPRW93a01WVld4aVhmbldtM0dHM1hOSWxEQ0YrbktS?=
 =?utf-8?B?R1NCajNoUTNRWUpKbU5SWTBKUFdrYUtzVXN3elE4cnlHbGl1Z0MzSUpIZ2xx?=
 =?utf-8?B?YjhsOUlnVmhiVVdKSjljYUlYUUdyYlBWOW11TmRheXBqa3dKYklqcFdEdUYw?=
 =?utf-8?B?MXU1c0c0dGZFMkZMSlJKTUdaVW5wVlNQcm1FeXZsUXlGNGNLemJtL3B2SmFi?=
 =?utf-8?B?ek9VV2FzcGtLVlNkcEtHdW1SQmJwbDhDRkk5MXlPeDllZ1czUlRJbFg3RGRB?=
 =?utf-8?B?bUIrVExlbnpsTVhzQU91U3RGVUQxblk0U1QwVmhOM0tlckIxdERZSVR3aHcx?=
 =?utf-8?B?VDlvckdvSGVvYmtzWHZFS092S2pueW00anVySW4rTys5MjQ3YzlUZUtPY1N6?=
 =?utf-8?B?ZzJtZWtEN0lpaXZjT1dMMGhVMVBtZTlXUEJSakx4ZHdjYy9Xbnp2SUtZMlJk?=
 =?utf-8?B?RFBpVG1aelNGbnFOU2JuOFlxWkxwRnFLS09pb1RxcUhwK2VqeGFKZ09UcE50?=
 =?utf-8?B?K3JyWGU1ZUxGYTZRUzNBRmtNbGJ2WjJmT2NjUFJpUFAvN3VOWHpwN3RjSnFx?=
 =?utf-8?B?ZWRhS1VqbWRPMXBLbGpNVGtRZEl5RXF3UVJWN1o5R2JudDNCanllZ1JlT202?=
 =?utf-8?B?NU9zWTFlWEVhdGQ2QThQNHBRT1JYeWNTR1NXcWxhTm5Pc1JiMWppQlNLdTNL?=
 =?utf-8?B?dFdUaGZWRld2NC9wZXplcHBSWlhYeTVoTXJxb1grNFpLRmovNGZZOUlvMm5H?=
 =?utf-8?B?L1UxUmhNcFF5dC9BOHZQanJIZkVOTzV4dmZvZEhqOXM4bXhmeWozNG1QV2ww?=
 =?utf-8?B?ZHRxeXFUVXhlWCtmNWZ1cHd2MUoyb0NaRTZQNUNqWWxrUGFHa01rbTFMeVh1?=
 =?utf-8?Q?Ujg8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 41858a2d-c384-401c-d6bf-08dd9c6df137
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2025 15:56:56.8568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: crFdJFuUVnT6r7L1q6NBXyjjD3OxfRwc1FSuUo1xLE+iZSS0qgN9wMzAOb5u9Wp433KNye3BkPgNvsEvey6YVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6615
X-OriginatorOrg: intel.com

DQpIaSBQYXVsLA0KDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMuDQoNCj5TdWJqZWN0OiBSZTog
W1BBVENIIHYxIDMvM10gQmx1ZXRvb3RoOiBidGludGVsX3BjaWU6IFJlZHVjZSBkcml2ZXIgYnVm
ZmVyDQo+cG9zdGluZyB0byBwcmV2ZW50IHJhY2UgY29uZGl0aW9uDQo+DQo+RGVhciBDaGFuZHJh
c2hla2FyLCBkZWFyIEtpcmFuLA0KPg0KPg0KPlRoYW5rIHlvdSBmb3IgdGhlIHBhdGNoLg0KPg0K
PkFtIDI1LjA1LjI1IHVtIDA3OjM5IHNjaHJpZWIgS2lyYW4gSzoNCj4+IEZyb206IENoYW5kcmFz
aGVrYXIgRGV2ZWdvd2RhIDxjaGFuZHJhc2hla2FyLmRldmVnb3dkYUBpbnRlbC5jb20+DQo+Pg0K
Pj4gTW9kaWZ5IHRoZSBkcml2ZXIgdG8gcG9zdCAzIGZld2VyIGJ1ZmZlcnMgdGhhbiB0aGUgbWF4
aW11bSByeCBidWZmZXJzDQo+PiAoNjQpIGFsbG93ZWQgZm9yIHRoZSBmaXJtd2FyZS4gVGhpcyBj
aGFuZ2UgbWl0aWdhdGVzIGEgaGFyZHdhcmUgaXNzdWUNCj4+IGNhdXNpbmcgYSByYWNlIGNvbmRp
dGlvbiBpbiB0aGUgZmlybXdhcmUsIGltcHJvdmluZyBzdGFiaWxpdHkgYW5kIGRhdGENCj4+IGhh
bmRsaW5nLg0KPg0KDQo+SW50ZXJlc3RpbmcuIFBsZWFzZSBlbGFib3JhdGUsIHdoaWNoIGZpcm13
YXJlIHZlcnNpb25zIGFyZSBhZmZlY3RlZCwgYW5kIGlmIGEgZml4DQo+aXMgZ29pbmcgdG8gYmUg
ZXhwZWN0ZWQsIGFuZCBob3cgdG8gcmVwcm9kdWNlIHRoZSBpc3N1ZSwgc28gaXQgY2FuIGJlIHRl
c3RlZA0KPndpdGhvdXQgYW5kIHdpdGggeW91ciBwYXRjaC4NCj4NClRoZSBmaXJtd2FyZSBpcyBm
b3IgdGhlIHVwY29taW5nIHByb2R1Y3QgYW5kIGlzIG5vdCBhdmFpbGFibGUgaW4gcHVibGljIHll
dC4gQXMgSSBzYWlkIGluIDEvMywgIHRoZSBpc3N1ZSBpcyBzZWVuIG9uIGFuZHJvaWQga2VybmVs
IGFuZCAgaXQncyB2ZXJ5IGhhcmQgdG8gcmVwcm9kdWNlIHRoZSBpc3N1ZSBvbiB2YW5pbGxhIGtl
cm5lbC4gDQoNCj5JcyB0aGUgZXJyYXRhIHB1Ymxpc2hlZD8gDQo+DQpPdXIgaW50ZXJuYWwgZG9j
dW1lbnRzIGFyZSB1cGRhdGVkLiAgSSBoYXZlIGFsc28gZW50ZXJlZCBhIGNvbW1lbnQgaW4gY29k
ZS4NCg0KPiBXaHkgdGhyZWUgYnVmZmVycyBsZXNzIGFuZCBub3QgdHdvIG9yIGZvdXI/DQpUaGUg
cmVjb21tZW5kYXRpb24gZnJvbSBmaXJtd2FyZSAvIEhXIGlzIHRvIHVzZSBhdCBsZWFzdCAzIGJ1
ZmZlcnMgYXMgZ3VhcmQgYnVmZmVycy4gQW55dGhpbmcgbGVzcyB0aGFuIHRocmVlIGNhdXNlcyBS
RkggKHJlY2VpdmUgZmxvdyBoYW5kbGVyIC0gUlggcGF0aCkgYmxvY2thZ2UuIA0KDQo+T3V0IG9m
IGN1cmlvc2l0eTogRG9lcyB0aGUgTWljcm9zb2Z0IFdpbmRvd3MgZHJpdmVyIGRvIHRoZSBzYW1l
Pw0KWWVzLg0KDQo+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaGFuZHJhc2hla2FyIERldmVnb3dkYQ0K
Pj4gPGNoYW5kcmFzaGVrYXIuZGV2ZWdvd2RhQGludGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6
IEtpcmFuIEsgPGtpcmFuLmtAaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvYmx1ZXRv
b3RoL2J0aW50ZWxfcGNpZS5jIHwgNSArKysrLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1
ZXRvb3RoL2J0aW50ZWxfcGNpZS5jDQo+PiBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNp
ZS5jDQo+PiBpbmRleCAwM2YxM2RlNGE3MjMuLjE0ZjAwMGUwOGUxZSAxMDA2NDQNCj4+IC0tLSBh
L2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5jDQo+PiArKysgYi9kcml2ZXJzL2JsdWV0
b290aC9idGludGVsX3BjaWUuYw0KPj4gQEAgLTM5OCw3ICszOTgsMTAgQEAgc3RhdGljIGludCBi
dGludGVsX3BjaWVfc3RhcnRfcngoc3RydWN0DQo+YnRpbnRlbF9wY2llX2RhdGEgKmRhdGEpDQo+
PiAgIAlpbnQgaSwgcmV0Ow0KPj4gICAJc3RydWN0IHJ4cSAqcnhxID0gJmRhdGEtPnJ4cTsNCj4+
DQo+PiAtCWZvciAoaSA9IDA7IGkgPCByeHEtPmNvdW50OyBpKyspIHsNCj4+ICsJLyogUG9zdCAo
QlRJTlRFTF9QQ0lFX1JYX0RFU0NTX0NPVU5UIC0gMykgYnVmZmVycyB0byBvdmVyY29tZSB0aGUN
Cj4+ICsJICogaGFyZHdhcmUgaXNzdWVzIGxlYWRpbmcgdG8gcmFjZSBjb25kaXRpb24gYXQgdGhl
IGZpcm13YXJlLg0KPg0KPklmIHlvdSBoYWQgYW4gZXJyYXRhLCBpdOKAmWQgYmUgZ3JlYXQgdG8g
ZG9jdW1lbnQgaXQgaGVyZSB0by4NCj4NCj5J4oCZZCByZW1vdmUgKnRoZSouDQpBY2sNCj4NCj4+
ICsJICovDQo+PiArCWZvciAoaSA9IDA7IGkgPCByeHEtPmNvdW50IC0gMzsgaSsrKSB7DQo+PiAg
IAkJcmV0ID0gYnRpbnRlbF9wY2llX3N1Ym1pdF9yeChkYXRhKTsNCj4+ICAgCQlpZiAocmV0KQ0K
Pj4gICAJCQlyZXR1cm4gcmV0Ow0KPg0KPg0KPktpbmQgcmVnYXJkcywNCj4NCj5QYXVsDQoNClJl
Z2FyZHMsDQpLaXJhbg0KDQo=
