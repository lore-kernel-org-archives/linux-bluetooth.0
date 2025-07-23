Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1429721B192
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jul 2025 10:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753267981; cv=fail; b=C6En+VRpLi086kaYJjS6pF3QjDYye+WlXgo4WHzdx3f9Z9CvGf69RWCyyB45/hiC50u50VqchzmiYt6hxknB14BEAO+WQfcM22BhmvP4ipibG5mb8zjFX2xoHaPW4/8q9wOPyDp9YWrKIumFGUHi5CG0Kdf2Lk4qP11rGos/8y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753267981; c=relaxed/simple;
	bh=qtqoqcX7H/MQHNAIHbZlxr6AMJBllY85XnG1sFWL4LI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BBs3Lt9gydExvdDvETkyV0dB4A8zng5/X38wrTdon61HJKT4ZEX+oF7koPL6Hd/V8bBc4viRLMogaoGeZs7xAO/kLS/mK0EbbswEW+e8pnrctVanffgat+hWDIfjNL1H5yqZpGtnijY7pVNcXpsxfwjt5rza6MfiFK0vbg+S0dE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=heCz4z5i; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="heCz4z5i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753267979; x=1784803979;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qtqoqcX7H/MQHNAIHbZlxr6AMJBllY85XnG1sFWL4LI=;
  b=heCz4z5iISGqn/IS2OHCnBhflraPE+jKFQ2xRTU1yhBkSe78s7zhXFHY
   z5RDkE2IJavti5CFj5G9fdQeXcsZDkHb/i0kVcVCJku/Oj6Hg9ypRl/st
   F4xeYzWMDjVDwp/T86wqbAJYdvCf2zMCzA4NTh6JY/T+gUMbXG97PCXSj
   nUesBxl77C4l0t8P5X3sIRyKxbC56OlEUkQPxVyn13pShu+Y3fbaxN978
   UVwAkcijbntUpIDN4v5lm6lDZc1ylSph/78Qhnk9aRkndSM6cH2EYu5uv
   Q68+zHdSJ4XGQC0Jl1GRnjMwyLycbf8pvqqjsXTfkKujsNbk7Gej22zV9
   g==;
X-CSE-ConnectionGUID: 7k6nWAl5RVm3pexz1iv1/A==
X-CSE-MsgGUID: t4//0xxASvKI00k1kzHwCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55646781"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="55646781"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 03:52:58 -0700
X-CSE-ConnectionGUID: INYqz0spSvu+uvqZlVKeyA==
X-CSE-MsgGUID: wyGTJE5VRfu9NBbtMJjnxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="159539586"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 03:52:58 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 03:52:58 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 03:52:58 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.51)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 03:52:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jsv210CpAJ/zpwT/QXggR/8NY5FXv5B/2SPHzwVOSEdUODRwPYcRNXKbwKKDjoNrTJTHKbPmMLzZdR16pry4zRRHyEzUNm6dZkgNe+P28pS0f6y6+ethneb21eE2Ob3xx1WLphKb1BmnQ5MkXM76ckRNxi6jNPy6fegulRwCosURxjIGt+17IgIi+6YQMKnFft+WPnpwTAxK31XVC5lL66J4SBM/ncSrxEwlNQs5yl2FVpQJSooP6gefJFf4dCFNYSb6p0D+b1iynnKYzam7D3iye0hSTmlLnCmWMlSEAidJhtqA0rrkocNvmWaH/K4HIfofCkC6sNXIkLKjK7G0Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtqoqcX7H/MQHNAIHbZlxr6AMJBllY85XnG1sFWL4LI=;
 b=GkOI5ljl5n5KtPB4f2DzEBr2cnz+BItaVjh3CUIvBFNdvHYbvluNLXZiPgb0HCF05qeMKcqNN1kk/T6c0UMcac8g72nYol+i54Kk7k/yHriHmMjJAdttVHvWCNgA8M5cyhGlAOjaY3dsW6GxpCvAGNzeEYRKm76ZmkEdKEgnRC4EQeQg+tvdgMRghIVRRw0nE+VzrIS+yikVlqvzx57VH4enXZr1ltt11ODDMJomagPk63E/HuUr+Sa6oBuBshNom4n74wHqhv6kKTSxq38M9A8aCKss5YhbXF4ERxkh7mGoZQTBhaolAYZGRH88PMvFGuYn1RrHcV8i4hpZxO7uQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by SN7PR11MB8028.namprd11.prod.outlook.com (2603:10b6:806:2df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 10:52:56 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%2]) with mapi id 15.20.8943.028; Wed, 23 Jul 2025
 10:52:56 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, Vijay Satija
	<vijay.satija@intel.com>
Subject: RE: [PATCH v1] Bluetooth: btintel: Add support for BlazarIW core
Thread-Topic: [PATCH v1] Bluetooth: btintel: Add support for BlazarIW core
Thread-Index: AQHb+5rC7mmkDY/MLEGfFwNxXDzXobQ/PNKAgABJcGA=
Date: Wed, 23 Jul 2025 10:52:56 +0000
Message-ID: <PH0PR11MB7585699960868D4D1E7F7819F55FA@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20250723062644.1296860-1-kiran.k@intel.com>
 <f8bf5700-6589-46e7-8630-865e21a59d26@molgen.mpg.de>
In-Reply-To: <f8bf5700-6589-46e7-8630-865e21a59d26@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|SN7PR11MB8028:EE_
x-ms-office365-filtering-correlation-id: ebdd6a5e-e537-479d-81fd-08ddc9d714db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Y0VqaGV3eUdGYTl2cWJQVlVyc1BMMm0xeHllZ3dYeE0xTzM1TWxCTDFENDVk?=
 =?utf-8?B?Tkdyc2ZDMmhlR2pPb3I0WktqYWhSMGp5b05Ibk0weWJRdURmdW1pMGtEcFl3?=
 =?utf-8?B?cTMyNGJ5TTNtZUdXZnl3TE1DVG1pMmhXZ21YT0tRSmdHY3p2eDRYWE4wRTFR?=
 =?utf-8?B?cll2Ujdackx3d3ovSUFOVUhadkZwSVRmTFRtWVBuWU8xUnY1OSs5TzhGWnk0?=
 =?utf-8?B?NUd6ZmpVTXdiR25MQUNYd3ZVWnhOVzY0ZTZzdEJuOVU4VFRlL1luYmhUWnV6?=
 =?utf-8?B?bWt5R2l3QzByZ3BTK1A1RkFTeHpjVjhsVERKS3huWkpHYUZodHFyLzI3alZP?=
 =?utf-8?B?RXZ4VmRDQUFrQVFXL05qd0lTZVlySWF2UkZRYkZMSW4wc2c3c2RtQzNoSXZK?=
 =?utf-8?B?dG5qcVR3MFgvc0FwbDdFeTFwM2VvcVdMUHF5bU01SkpBcmxyanZ2UDVnOW9i?=
 =?utf-8?B?NTR0WHdYZ1pQR1ZBWithTnhqZ1RUam8zK0ovNGdsMisweno1MExYQktEc1Ir?=
 =?utf-8?B?OEJFL3hKSzNBSmxFTTFmQVQxKzNQNzNDcXJMVldKZGowMXIrdVhsc1F6SFpW?=
 =?utf-8?B?L01iZ0ZPL25ta0FzK2M1b2NUU2loTEtUUlNDaFU0cmpUcnhtNXV2eit0a3VM?=
 =?utf-8?B?VVR0L2pCU0tlYy9FWHgybi8zcmthRVAvMWF5OVFoSEJpNTNWL1R2OU5kbHhn?=
 =?utf-8?B?cWMzRnpXVlMwT3JzRWJTSkhtK3kyYXZtU3lnMVdBVFJyeWdOeGlUWkg1Tmoy?=
 =?utf-8?B?M2RGUm1IekxVM3FzWm8rbDczM2thTjdZdlNiVVErbkozWlZxamdlajdEeDlU?=
 =?utf-8?B?MWtsWkhLc29NZFpKK3JvNXIxR1NZTDdXcEhhemNJek9NVTVZajhaMXJtb3VQ?=
 =?utf-8?B?ZlFzYTBLbXJUaE8rUkhueHgzUmJhdEpRam1PMGNoVHpVVHl0ZDgzSkJhZHpF?=
 =?utf-8?B?bmVvaU1sd1BjdHRPTFRjM21aeEl6WllYcUJENUxpcElrSkFzb1l1Nk92bzV4?=
 =?utf-8?B?SXpmSFV6bHRqWk9JL3UxUEtuZG1WaUl4aUorbjZHUlNNMVJhbTdGUkM3REwz?=
 =?utf-8?B?cXhzcG5OMnlXRmJ3Zm93YlQvdmJxN3Z1S0pRMzVJMWZnV1pFOC92QnRSZUww?=
 =?utf-8?B?anYrN0ZiQ0RRUXBwcDVoaStzOEFjOXJRNW9jeGxEdFhxd0lkRU42eThsR3N3?=
 =?utf-8?B?NGFTa2Q3NC95dTlITktCNURPeUtEb1QzZmV5U0hxY25XNmNrNWh1QlRqdVJR?=
 =?utf-8?B?cTZhbmVEc2JMT2tHMHpPdUdyMVh0dmxoWXB3UytuWnd6VXdKZkRrUFc3Wjg3?=
 =?utf-8?B?UVRoS0lGSlhYZDM1Q1NaSjNiajVpeW1UTjNHdGNmNEhHK3kwYlJRSFpkUlRX?=
 =?utf-8?B?UThvYzNQNzlsTzl2YjJ6RU55SGp5b3lHZ3E5MUIvNEVxZ3ZDMWpaRWxWWmIx?=
 =?utf-8?B?T2MwVW9WeXhIVnNXWmloNzJlMTFRNlBYSDJ6VU1yYURJVGxLS2JpVDRGTkI2?=
 =?utf-8?B?Tm1uT1RYVnZRMGZ5cW9ONWY5amp0bCtLUHh4Y2ZrUzRNTCtZQ0ZWMTZGRzBL?=
 =?utf-8?B?dEFTNFE1bEJ1c255Um84Z3RZQXBheHdST3NVdWJIcnpneG9TS3hIYUhBYTYy?=
 =?utf-8?B?Z0x5SXhwQjV2d0hvbXlQN091cVV2Wm50SzQydStnUEtrSEZNTDc0bmJuU0Uw?=
 =?utf-8?B?SjVQU2Z3enlWbVhCVkUyZXFrQ0FFTms4MGN6L2N0L2xmTm9NZmxZUUNXN3U3?=
 =?utf-8?B?bTFpeDNQTDFCWWkrc09lL0VvRlF5a2UxU05Nbm9yaVlReG9SY2lYVnMrK0Rh?=
 =?utf-8?B?b0l4cXE5bDhiemh4UmFSVUxRRFlZamdxM0ZDcjE4aVBuSVRyUTRLUU91SUNI?=
 =?utf-8?B?VjgrU3RKUDBWNDd0M3pKY2tMenV5WGlVL3NlYWpYMVZGMkNFK056QTd6amwr?=
 =?utf-8?B?c1lVVjhwMVpOWHVTbXIwRStIZFEwQ1FQdlg1SmliSW04WDNQUFFaN1c3ck01?=
 =?utf-8?B?Umt5cktLVDdnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXRrMGh4a0JWRmJYdlZtYjhxOEtJbUJLTHJNU0Y1aFJ1MzZmZ1pqK2R2SDFB?=
 =?utf-8?B?bDk4NUkrZGpvZHpSZEU0Vkc5M0oyejROK2c4WEZSa3VXVkZMR2pqRnkxNmNn?=
 =?utf-8?B?OUZMUUtkbnNkTlNhRkhCYW0rQllKTWdINXVheTFPeE5rRkpzMmVaeGVEa2tT?=
 =?utf-8?B?YzdHcTQ4S1N3Qld2dWkrL3JBYklkQ3cwYXFrWjFoUHEwdVVpU2pNbDBkZjY1?=
 =?utf-8?B?YWdQWEJsRWNRaUhsYThmc0llZkhSR29odnBjV0tOcXU3ZDl1MnNUUllWK2t1?=
 =?utf-8?B?NktLeWl0ZlhhUlNqV1c2TGRwcGpBWEY2cVJrazJITmMwMFAyTjN2QUQ5d3Bn?=
 =?utf-8?B?TmJHVXF2em5ibHQyT1A0TmMvQXphdFpVR1VSaU9Da1RnN2lQVTlCKzR1UXpq?=
 =?utf-8?B?SUFKdksxVDZwaWlyK09aY2hRRVRwdnh5N1ZCbVBPL0JydFJFVnZsVVVaNGRZ?=
 =?utf-8?B?a0Qvb0s4L2lMbzIwTVVmNFhVMk9tZWYzeEJMeUcvTm91L3lDbUVXZEtsWjUr?=
 =?utf-8?B?bFhBbHlkaUxSSWl0NWZqcjQ0RjVRMllsOE51K2hoYmdFMkJlMkhQTHFpZlJG?=
 =?utf-8?B?elprUXdiNm9ubTVuR3BuUXBScXZUVFBIZGpwdk1XTk1XQzBkV3Frbm5UNnJt?=
 =?utf-8?B?RVlvRm1McFJQNzJFV2NRVHlaUkVqMDJ0WCtWVUtWRi9HdExUc0RPYWkrUFIw?=
 =?utf-8?B?OW40dDg4N1Zqdk5yajlhSEpNWDJvb1RKWk0vUG8zUEhJQ29CQjU1SUNuZ0VB?=
 =?utf-8?B?QVp0QTlyVkFxcjlGNk13eDZpcmhRYlFqS2tsdnRGZmpDUm5tM1MzWS9BNVdH?=
 =?utf-8?B?bnF1UUVMMDJJdWtzTXVqUVZxbjhKWlRXR3Ztekh2V094NXhkNG1zT09oTmpu?=
 =?utf-8?B?YnBGRXZvRGZFZjBGOU4xQ2JPLzdKc3hFUzRoUll1RW93eFRBbFZTTUtHYXN6?=
 =?utf-8?B?cENReFNRR2RQY29OQkdrd2JTaENCSDU2bkFBU0F6d2xOc1NCVGRTc0d4cFZk?=
 =?utf-8?B?OWZOUWdNQlUvaHJ0aUpGTElidERjeVdLN1l0YmVVb05Td3lWcVFwbzdjRnNY?=
 =?utf-8?B?ek5odzVhdEpwd0VzRkNlQmlIa1IxMVYyalhnTkpCWHVhYXB4YmIyTGZjc1BP?=
 =?utf-8?B?MDBVdStaRUdsUitvejRWK1ZEamNkTEpCcXZ5Tk4wT0VnSWp1TFp0SU9YZTNI?=
 =?utf-8?B?Q2xvNCswSCtVMnZyenpzS09za0hKdzFkMVE0SzdZeXZWeW5COFlwQm8zSldX?=
 =?utf-8?B?Si9kZHBVT2xtTlZuMkxQbU0rQVk1N29iaUxkckJBVm9DSkk3akhNdG1zeUdy?=
 =?utf-8?B?Q05iT2pQYkVVQVRGc3MzL3dUNG1DdG9zMkR4bXBxMEllK2pyWFlJVHVqTzFx?=
 =?utf-8?B?Y0pLbWRvalloMm5taUw1Z2toQ2t0TTFiVk9lSTdDT2VrQXdHYWFFUmRpSGQ5?=
 =?utf-8?B?a0hVblFWN0pmM2hmS0ZsVHpONklTU0hJSE83NkJrTDFDSDU2OTJkUXpKNG1K?=
 =?utf-8?B?QlFSRHZVUEVNcUJDd01CbVdsV3QyWFFPMDNQc1hGK0RpeDJROUJxVitKY3oy?=
 =?utf-8?B?RlJuTXhZczYyWnFoNTFJa0p1VURDZmovczd0dzhJZXRDZFMwN3V3MXlya1lI?=
 =?utf-8?B?SEpxWEt2UXBuQnlkeXZpM1R5WjdnSG1yeWU0b0dvWlB3SGJVMzdRT0NtRjc2?=
 =?utf-8?B?dTFPSmgvc3Bqa3F2dWhNQ0F1UnZjcGFVZDJjcGFvbmtOOXpReHg5ZXQ4UkVP?=
 =?utf-8?B?elNNNzhYdXlCVXRxOHQzeVoyaXdYa3B3Q1FKSkIrYy8wcm1tZVpGUTFrSmsy?=
 =?utf-8?B?dzVqK3hVS0V2Y3JoekUyU0ZXVFI4ZlFLUWFIRFo2SFN5UStLQXRLUUVKLytJ?=
 =?utf-8?B?WDN4OERERzFUYTI4ZGFzV1FCS2FBY0RLWExYeG10NkpTdnZZdG1lTFZmLzh6?=
 =?utf-8?B?eHcvME53WlZKb1VEN1BxYytwSXRFdjUreXRXQzBmZmZmWmhmTVV2Ulk4YU85?=
 =?utf-8?B?QWVocFp2VWF1Zm96eCs3Q0Q3MDQ0ckFIeXZvU1MvbEtQMWNjOHpSS2NSMVlD?=
 =?utf-8?B?bkExNzBXbGhhL3BWdmVUVzhjVGhCdnNVcmVhczdreU4xdWVSaERjd2NIVnJY?=
 =?utf-8?Q?RRVo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ebdd6a5e-e537-479d-81fd-08ddc9d714db
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2025 10:52:56.1339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: csXp/77ArTI/hOXmR0jbZ/xOb0EtcU+n7L4SBj8atKeEGbyrSccEs6JN9vRojfPRKlnaFBdP2CpzpqEW5M9xlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8028
X-OriginatorOrg: intel.com

SGkgUGF1bCwNCg0KVGhhbmtzIGZvciB0aGUgY29tbWVudHMuDQoNCj4tLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPkZyb206IFBhdWwgTWVuemVsIDxwbWVuemVsQG1vbGdlbi5tcGcuZGU+DQo+
U2VudDogV2VkbmVzZGF5LCBKdWx5IDIzLCAyMDI1IDExOjUxIEFNDQo+VG86IEssIEtpcmFuIDxr
aXJhbi5rQGludGVsLmNvbT4NCj5DYzogbGludXgtYmx1ZXRvb3RoQHZnZXIua2VybmVsLm9yZzsg
U3JpdmF0c2EsIFJhdmlzaGFua2FyDQo+PHJhdmlzaGFua2FyLnNyaXZhdHNhQGludGVsLmNvbT47
IFZpamF5IFNhdGlqYSA8dmlqYXkuc2F0aWphQGludGVsLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BB
VENIIHYxXSBCbHVldG9vdGg6IGJ0aW50ZWw6IEFkZCBzdXBwb3J0IGZvciBCbGF6YXJJVyBjb3Jl
DQo+DQo+RGVhciBLaXJhbiwNCj4NCj4NCj5BbSAyMy4wNy4yNSB1bSAwODoyNiBzY2hyaWViIEtp
cmFuIEs6DQo+PiBOZWVkIHRvIGFkZCBzdXBwb3J0IGZvciBCbGF6YXJJVyBCbHVldG9vdGggY29y
ZSB1c2VkIGluIFdpbGRjYXQgTGFrZQ0KPj4gcGxhdGZvcm0uDQo+DQo+TmVlZCB0byDigKYgc291
bmRzIHN0cmFuZ2UgZm9yIGEgY29tbWl0IG1lc3NhZ2UuDQoNCkFjay4gSSB3aWxsIG1vZGlmeSB0
aGUgY29tbWl0IG1lc3NhZ2UuDQoNCj4NCj5XaGVyZSBpcyB0aGUgaWQgZnJvbT8gSXTigJlkIGJl
IGdyZWF0IGlmIHlvdSBhZGRlZCB0aGUgZGF0YXNoZWV0IG5hbWUgYW5kDQo+cmV2aXNpb24uDQpJ
ZCBjb21lcyBmcm9tIGhhcmR3YXJlIHJlcXVpcmVtZW50cyB3aGljaCBpcyBtYWludGFpbmVkIGlu
IEpJUkFzLg0KPg0KPkFsc28sIGhvdyBkaWQgeW91IHRlc3QgdGhpcz8NCkl0IHdhcyB0ZXN0ZWQg
b24gc2lsaWNvbi4gIE1heSBiZSBJIGNhbiBhZGQgdGhlIGZpcm13YXJlIGRvd25sb2FkIG1lc3Nh
Z2VzIGZyb20gZG1lc2cuDQo+DQo+PiBTaWduZWQtb2ZmLWJ5OiBWaWpheSBTYXRpamEgPHZpamF5
LnNhdGlqYUBpbnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBLaXJhbiBLIDxraXJhbi5rQGlu
dGVsLmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL2JsdWV0b290aC9idGludGVsLmMgICAgICB8
IDMgKysrDQo+PiAgIGRyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5jIHwgMSArDQo+PiAg
IDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYw0K
Pj4gaW5kZXggYmU2OWQyMWM5YWE3Li5lYTE1MjFjNmIyZDMgMTAwNjQ0DQo+PiAtLS0gYS9kcml2
ZXJzL2JsdWV0b290aC9idGludGVsLmMNCj4+ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50
ZWwuYw0KPj4gQEAgLTQ4NCw2ICs0ODQsNyBAQCBpbnQgYnRpbnRlbF92ZXJzaW9uX2luZm9fdGx2
KHN0cnVjdCBoY2lfZGV2ICpoZGV2LA0KPj4gICAJY2FzZSAweDFkOgkvKiBCbGF6YXJVIChCenJV
KSAqLw0KPj4gICAJY2FzZSAweDFlOgkvKiBCbGF6YXJJIChCenIpICovDQo+PiAgIAljYXNlIDB4
MWY6ICAgICAgLyogU2NvcnBpb3VzIFBlYWsgKi8NCj4+ICsJY2FzZSAweDIyOgkvKiBCbGF6YXJJ
VyAoQnpySVcgKi8NCj4NCj5NaXNzaW5nIGNsb3NpbmcgKS4NCkFjaw0KPg0KPj4gICAJCWJyZWFr
Ow0KPj4gICAJZGVmYXVsdDoNCj4+ICAgCQlidF9kZXZfZXJyKGhkZXYsICJVbnN1cHBvcnRlZCBJ
bnRlbCBoYXJkd2FyZSB2YXJpYW50DQo+KDB4JXgpIiwgQEANCj4+IC0zMjUzLDYgKzMyNTQsNyBA
QCB2b2lkIGJ0aW50ZWxfc2V0X21zZnRfb3Bjb2RlKHN0cnVjdCBoY2lfZGV2ICpoZGV2LCB1OA0K
Pmh3X3ZhcmlhbnQpDQo+PiAgIAljYXNlIDB4MWQ6DQo+PiAgIAljYXNlIDB4MWU6DQo+PiAgIAlj
YXNlIDB4MWY6DQo+PiArCWNhc2UgMHgyMjoNCj4+ICAgCQloY2lfc2V0X21zZnRfb3Bjb2RlKGhk
ZXYsIDB4RkMxRSk7DQo+PiAgIAkJYnJlYWs7DQo+PiAgIAlkZWZhdWx0Og0KPj4gQEAgLTM1OTMs
NiArMzU5NSw3IEBAIHN0YXRpYyBpbnQgYnRpbnRlbF9zZXR1cF9jb21iaW5lZChzdHJ1Y3QgaGNp
X2Rldg0KPipoZGV2KQ0KPj4gICAJY2FzZSAweDFkOg0KPj4gICAJY2FzZSAweDFlOg0KPj4gICAJ
Y2FzZSAweDFmOg0KPj4gKwljYXNlIDB4MjI6DQo+PiAgIAkJLyogRGlzcGxheSB2ZXJzaW9uIGlu
Zm9ybWF0aW9uIG9mIFRMViB0eXBlICovDQo+PiAgIAkJYnRpbnRlbF92ZXJzaW9uX2luZm9fdGx2
KGhkZXYsICZ2ZXJfdGx2KTsNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibHVldG9vdGgv
YnRpbnRlbF9wY2llLmMNCj4+IGIvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmMNCj4+
IGluZGV4IDZlN2JiYmQzNTI3OS4uZDA4ZjU5YWU3NzIwIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVy
cy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmMNCj4+ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0
aW50ZWxfcGNpZS5jDQo+PiBAQCAtMjE0OSw2ICsyMTQ5LDcgQEAgc3RhdGljIGludCBidGludGVs
X3BjaWVfc2V0dXBfaW50ZXJuYWwoc3RydWN0DQo+aGNpX2RldiAqaGRldikNCj4+ICAgCXN3aXRj
aCAoSU5URUxfSFdfVkFSSUFOVCh2ZXJfdGx2LmNudmlfYnQpKSB7DQo+PiAgIAljYXNlIDB4MWU6
CS8qIEJ6ckkgKi8NCj4+ICAgCWNhc2UgMHgxZjoJLyogU2NQICAqLw0KPj4gKwljYXNlIDB4MjI6
CS8qIEJ6cklXICovDQo+PiAgIAkJLyogRGlzcGxheSB2ZXJzaW9uIGluZm9ybWF0aW9uIG9mIFRM
ViB0eXBlICovDQo+PiAgIAkJYnRpbnRlbF92ZXJzaW9uX2luZm9fdGx2KGhkZXYsICZ2ZXJfdGx2
KTsNCj4+DQo+DQo+VGhlIHJlc3QgbG9va3MgZ29vZC4NCj4NCj4NCj5LaW5kIHJlZ2FyZHMsDQo+
DQo+UGF1bA0KDQpUaGFua3MsDQpLaXJhbg0KDQo=
