Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5B41D517F
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Oct 2024 11:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729164871; cv=fail; b=lp39PkGAARw7jC31RlZfgAafeOh5BOBbuDsCA6efwkDkTyMZGM/XLyBW91fFR1ctv9m/cFXMNyFNERONiaYNULQkj2yjfV/eRCx87E3se6o2yFx9Y05MJ+rBhNoxLaxketdazepQnFPw4p821aexgP4euxuFE5TeX5ANX+BNP+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729164871; c=relaxed/simple;
	bh=+bPV5u3rmHkq59zMM4WBF2OuwvP6Uh/Wao/oJF/AbpU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L0njQcGI4jfSMVN7Xr/8pkKaDdXwbFgOnEgKV8xngwLD6DUugd+LW7v4uEWW1qRiZlfcFxELlG6uHupjpNJgudgBSJdMAXArl++wtL8ZaLg1zcQi/Mhg1QL2QEwofUl3IFGuC4FaWIXk6ZtzPRfBcgCMD8dxDGhOR5wHLOJEsWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LEFxgMqY; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LEFxgMqY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729164869; x=1760700869;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+bPV5u3rmHkq59zMM4WBF2OuwvP6Uh/Wao/oJF/AbpU=;
  b=LEFxgMqYLE55jpaEA+CoVCsneux/RxYPB2ryISyjXkM9j05P9Uu+OclR
   o2B6b8QEtguXSo7qPJfOW1ovZ9625fTQnzjOKT7Sz2Poxw/5ev45X1vYC
   iuk7shQXwl5Mr7x+cMrXxBiuY++YMEuldz3WtYvMkNhpHxtOmDBhuiv5s
   R56TKG5WJAOXASpxmBhGzaiZnPBGwACJ5Nv6Ewp+cSpggdzDVeDthoLPr
   oDTGtNcjBCEAWZ4vjcRrrJpFoouPbacsyW8pQRCrG8O+2CodGXgds+m/y
   /pgT2BBaJQ59p8U8MY5NieiP4hrAtmBr8x7Y1Q+Vylo2bCTcm4UqeZsQY
   Q==;
X-CSE-ConnectionGUID: FSlGB/HkT9uU5TtcIL44lg==
X-CSE-MsgGUID: PlMPU9GKRsOQkaHw3TefLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11227"; a="32575319"
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="32575319"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 04:34:27 -0700
X-CSE-ConnectionGUID: ggnXEvepQYivXhHt/rA/5Q==
X-CSE-MsgGUID: N0I9vwteRduNnXJvNxjIPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="78958064"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2024 04:34:28 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 04:34:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 04:34:26 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 04:34:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSWFEiUeryH93Z/hnWL2jNn4kGw5l0pz18hf5jH6PV0Go4cZJysNwqchbcTa2jWv0HvBJ5PbVLIEZVkeQO3P+WbbNIYOsre85/zf4mgLs8jSUPJ6717rFPm6UvnSGUFGYTf44wRAPTILKA69CGRvArIozE7PAM2lHnSfYPOarqSIo4Z3IrHHrYA8XClrZDO/w8u/OJIUpQ3lo7YJwP5vDdKwq4BpBBIP4zHj1PV/7A1zsAgPMIS28Pib8/e1uaV/YwWy3oqrswuZoFrTMVaqYQeLQNZtI7wC+RVVCrJDnJH+RI3ylCdIzni4p1elkSGjdXa24lWEn6U4fT6J22E1nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bPV5u3rmHkq59zMM4WBF2OuwvP6Uh/Wao/oJF/AbpU=;
 b=fhg5B7RJLPhzc66y/bTdmOVdFoZA+EVKol752IjngYMaCWjKXpPYrxfgLsLs5S4CC1HFtMw6GFMPFtclboRB0XrznyjmsZUp2rbhLPAUrYe80G/A+36Phzxa058QKDPz8tDUMHNTryV6KACSIxFhVnkyCHOHVuA+FP2qhI2szXqCHYBjxz7/isDdNGIR6Ley3IAUv6iq/uwiVKI/ypdV3iMGrp2eEr2+4PZD5SRbWA22tW9Q824Ub03MIdBF7RuoPC89yyM2j70zyP6uxW0zC4ZKlQdezuDPG8xvcZXLA8xfSNRPamOKvBN0xdDXYdfUvlKNAzkn//KDH8hEBj4nFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by IA1PR11MB7677.namprd11.prod.outlook.com (2603:10b6:208:3fd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 11:34:22 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%3]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 11:34:22 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, "Devegowda, Chandrashekar"
	<chandrashekar.devegowda@intel.com>
Subject: RE: [PATCH v2] Bluetooth:btintel: Do no pass vendor events to stack
Thread-Topic: [PATCH v2] Bluetooth:btintel: Do no pass vendor events to stack
Thread-Index: AQHbIHxx+R90vVPpGkCcPtmbDKMBkbKKyQIAgAAGYZA=
Date: Thu, 17 Oct 2024 11:34:22 +0000
Message-ID: <PH0PR11MB7585162B39B719F859BEB6A5F5472@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20241017102236.729685-1-kiran.k@intel.com>
 <0e3f0b14-00a2-428b-a673-eed37f628c17@molgen.mpg.de>
In-Reply-To: <0e3f0b14-00a2-428b-a673-eed37f628c17@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|IA1PR11MB7677:EE_
x-ms-office365-filtering-correlation-id: 4529deb0-4004-4c31-01ea-08dcee9fa5c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bVpGME5Ja1RxeHNkSGlxMmVScGxDYk82VTViRGUvb0JVSjhPNnlXSDd5OHZp?=
 =?utf-8?B?Z0dwN3BCY2hYS05weGc0ZzRlbHVObWtheFkvLzl0dlg1Um02MFUwNDVwVERT?=
 =?utf-8?B?UFUrK2hlYXU1UGRzUTRQT0NNUGE1WDBrcnNNZmhwTENhajVvdTdSWXVrQjll?=
 =?utf-8?B?a0hOMjRWV1p0OXRtdHc4MlFHZndoQkZIMlZ6L1FGV1JDTDFwdkhWMEtDemRM?=
 =?utf-8?B?dUh5VEhMVkhzNXFoeHRadUtYZUM3bkMrTjdiOVh3VkhIZWVsMVdseG0rMGhC?=
 =?utf-8?B?Z0tKUFhzaEFSZk54U29wZXViUUFhQmFyeFhiT0xlS2VuZW1GRVpQSVlGazVU?=
 =?utf-8?B?RENrblNabjJFSXBZb1BiTUMvOXBtNUZldFFCVTY1WUlocFNwazJ4dGNIWWlz?=
 =?utf-8?B?TUxvTmtkSExkU0MrUitvcVFjS2Fsa0xiWWhHeURwTm1qM3MwSURmdno3ejZx?=
 =?utf-8?B?ZDhJUXlnVTl4NW43NFQvUlZzSUpYNEFucmM0eHdjOEMyQW5GZFdqb0IzcDRp?=
 =?utf-8?B?ZnY3N3FqckNCL21ScDNPWU1PQzFlQm5nbEM1VGNtdU1WYis5UEpyOVhHekZB?=
 =?utf-8?B?bmg5SXlhdGlId1p1Nm01THVacXRhSFVGQ1pwdnF5RENXZThVWmpSSy92cDkz?=
 =?utf-8?B?bklQZ0tWQTNaODBSWElJS1NKbzl3TWVURE1yYzlXT0h3empPdFZZdVFBRTRN?=
 =?utf-8?B?T1NxZzdOdDI5eWEzaCtUMmNXdmhzWTlqOTQyUzhTNjBETjdiMzJOTkZBM09k?=
 =?utf-8?B?OTAzbjk0NUxoWWNjNDNhenNvbWpDais4S0pTclN4TDQxcnBWSDIrSktwaFhl?=
 =?utf-8?B?dG9ZQ0tqNTRLRlVBSjNIVFJrRnhGQ0VjYnRhNkU0RFB6bURna3BYYVBMOUxY?=
 =?utf-8?B?SDJJRHJVbVNVU1kwblY3OVlJL0FyVFp1NnozdlAvcGtsTmhPR05yc09oUjFx?=
 =?utf-8?B?TlNpWVZwcGJsRTdmZEtuajN5RU9hNnZFM1gwZTVjMDl0NU9mbzVYb0JzM2oy?=
 =?utf-8?B?ZStEa1hicERPZUVLUFl3RWVjRlFNYnJ0REJERTFncW1VcEFlaVhFNTY5Yzd6?=
 =?utf-8?B?QjhiNmxkM1BnemxETHlPVzBKcjVXQkpSbCt6U1J0QzJRWU5CSy9YZEpmUmVa?=
 =?utf-8?B?MDVaZWU4NFZoaTA0WmJCRVlzSEtsN1VKTkFweDRrc2VSdXM3WEM1bXlNOW00?=
 =?utf-8?B?TERMejNqSGdGTnVaeGlyZjhEdHRwWUJ0R3pYdm40NkdYQU43NFIwQ3h5UWdi?=
 =?utf-8?B?Vk5oeEI2cTlDL3lUKys5QUdyL1B2Z28wYU5qbFBNRXg0ckJzT21NWUowMEkx?=
 =?utf-8?B?OEViVFFMVjdXeHZraUtJdUk2eS80Nlk4RkNxL2dlcGdBMjdyVmdyUjVrcFNa?=
 =?utf-8?B?MXp0QVdNTS85bDNobEd1QTEvd1pRQTg5N0p5UnNGZFZGTlN4S2tVU2VrK0ZI?=
 =?utf-8?B?Z084NDZ6WTdKcCtvN2hpekRKVG56bWJkT2lnM0c4VkRHc2JJTlN1VC8rT014?=
 =?utf-8?B?NnlBZWR3c0xpTjgrRmlGYzg1RjhKVUlrdmdsODZGMXRhZFQ4elV3ZlRqUVJz?=
 =?utf-8?B?RHorU2JScXFqZ0pkTUQ4V3JaSEZSY2xRczNwOEQ3dnlWL1A3cHNZTm5PN01M?=
 =?utf-8?B?QkQxcHVWZitzTE1kWDZTMDVNY3JJejJGWEJMTFhNNUY3VEpvUVZsYjNENVNQ?=
 =?utf-8?B?ZXUxcUJSdnh5ZHdieFIyNm1hd2gyN3JzcC8yYmNQRzlOSjhVNFZaTFc5cHFu?=
 =?utf-8?B?OFFodzU1R2dNTjdPM2pGSFI3OU9OdVdCUDBmV1pKelNhd2JRWitHOFRQV2dI?=
 =?utf-8?Q?mFhgQ6834nAT6RphUUgssQPZ1/FYSObspQ24U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RExaYUQ3RGVTREZnaUJpT05Jei90RThhQjhha3dLT0pqWGFPZE04VnQ0bEM4?=
 =?utf-8?B?TUJZMHBydVV1VWs1cmNQSWhZZVp4V3ZyZzdvSGxKVVZxQUY1MkNKNFc0OFE5?=
 =?utf-8?B?Z1dQWkZ6OGVDM0QyVUFjSyt0WUhyb1Z3NXMwcVNXVGd2M3Uwd0xDSnBsQnYw?=
 =?utf-8?B?dXlOQXJiOXlFZ1lGK2xzam9lZnF3Z1NYd001SFZsTGdPcGh0Q2tQblkwbHVu?=
 =?utf-8?B?azNwZm9RbEkweDVxZTl1M083a2RpdlRBNWwvclRNNDdRL1R6T3d0MFNnNjZN?=
 =?utf-8?B?djllOERVYUk3Ti9IU3g5bU9maVlqV3JGNkltL3N6ZDdOdXF6YjlYZytLdGk1?=
 =?utf-8?B?SFVKaFUwV1MzWXpMNklVOGJYT2VKQ09hWUx5bmxJMGdidXhEbGsvSEZ3bE91?=
 =?utf-8?B?TXJYbVc2MUZHejJoZjdKcVFPdm9jUHZrZjJyR3NUcEorZ0V0MlFTZVFCK09k?=
 =?utf-8?B?czNXNzArY2JTVGFjUXVwRWF4dkp4eDhKODFBVjVNSkF0QjJJc2xSMWE4Z0dn?=
 =?utf-8?B?bFZwdTBmaytocWVDa2E3RXJwN2R4RnQwVEcyanFFRXJ1djdDVm0xN05TVFJO?=
 =?utf-8?B?VGx6ZEtRQjgrekwxOGtjQ1k1b2FJalZEWmc0WUZhMmcxTm94UnBMSnpSNExN?=
 =?utf-8?B?QzNrSzRHY25qd1ZvM1YyQlVLSXlkMWZwNHhqRGZ0VjFVRU5OdmNselhXejlN?=
 =?utf-8?B?WWFYalhLZG5pU1Z6NDd4SFBOM0pvemJnSmQvbkIvZEdqVHlzTHBpcVhrVlEw?=
 =?utf-8?B?QTZvdHhkaFg3a1JkOGt5M0N5dURIZkdYSlYwTEVhb2NuZVVMMSsxK1VZTVlw?=
 =?utf-8?B?Q00zbkJYeDRrYnRiQmI2dk5leUt1M3NLdGRLdHByN25ONW9ib0xjREdhTlIw?=
 =?utf-8?B?SnVIeGlLQStRZVZTMTlib2RRQ0pBa21taDBiVVJPU09UWk5kOWxwT09SR281?=
 =?utf-8?B?OVBpdFFwUFBHQjZRaDlHT2ZYVzlHTDNDNm1hNVpYZU9DS1pkc0EzZHdpb1V3?=
 =?utf-8?B?aHVxNjkvZmkvZ3lzK1FXRGQrUHh1eUd3N0xxVVJjMXJNdC90RGN2UG9qbENr?=
 =?utf-8?B?TEhPd2lSdW0zLy81eDgxNktqMGhlNlA0KzFiZGVwYzlBSzM3dXpEVzVhSHp2?=
 =?utf-8?B?eU1PRHlUUGt4Zmx5a1k1dFU0K1FoS2FPdEtpeWNkbkc1REQyb3g1RzJSRjF2?=
 =?utf-8?B?QWpKOWFxSWtVRkRkMnRTK1R6WHhCQnJPenpaTnZXb3hnbzBwTXdIcnpOM2w2?=
 =?utf-8?B?U29HUThkbVVuQ29hRTBsR2h4dzhwb3d6cStTWXdhZVRYeG5TeUw3Q3gyL1hU?=
 =?utf-8?B?eDZqTVJld3NYeTIxanJXNll5c2tzeWZPM2ZXVWFwaEY0Sk5JekJONTJTbjNu?=
 =?utf-8?B?YjVIMUgyTm11cThickVqTEtWU0ROV2hGN1lVRkM2TityOFJtaXZIMFhIVVZv?=
 =?utf-8?B?OFVTMTZjS2JBdzJ1VHJGbDlRdHZzSzFNM3NKOFJySUU0K2pmSlN5Wm9NZzd2?=
 =?utf-8?B?VjU2RXkwOUYxbHdLLzZLRlBUU1gySDl3eGxpOXFsZjE2WmE3UkVGY1c0dVlQ?=
 =?utf-8?B?bHhxWmxCOUQ3UmVEVFBiUDRyaHZwYzRwbGxPRjBzWUFBTHJpRWFqOUgzQTQ2?=
 =?utf-8?B?L0gwOS9mZkRuaWxzSjZXaVMwdms2UzJSUVRKaWs1dWtKSXppbnBHeVJGNjRJ?=
 =?utf-8?B?N2JXdENkRS8wbEZ2TnNqWGg5UDFoZDNOR2ZIbkI3YWVLendkRlZTdkdTaE5V?=
 =?utf-8?B?NHlZbGRueUVhRVpVd2dnaXFLMkdmTHBGZEVFR0lteWxiVnh5Y1BERU1Vak1r?=
 =?utf-8?B?ekFOWVdVYVJ1V0hmUzFYRS9wOG1NbFY1QncyY3A5UGhyRGRZZzBQbDdEYzRm?=
 =?utf-8?B?K1BPdGdwWU41TENtbUZwVTZzL24wVU8vOExYMjdwZndHZmJaQ3VvK1hSL25E?=
 =?utf-8?B?UFFVR3UvakFFdTBlZ1VYZytvUHRNL0JlTE0vbjdTOXhRSDhPcTZwTlNQanJv?=
 =?utf-8?B?Smp6RHgxRGNkM1pqd2NSQXAzamJyU2VNYjkycy9ic1YySHJJNVR4Q0h6dGRk?=
 =?utf-8?B?UStGQTNrQzFXdi93WnAyOXFib3pqK3ZKODF5ekpPVXQxSXI1TmFaNDBsS1NU?=
 =?utf-8?Q?aQGY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4529deb0-4004-4c31-01ea-08dcee9fa5c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 11:34:22.7854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T+rM2ydpFgWSSda9UkKdpuGvho5EwLXvVXA0RDEoUXojsuLeSG1bdVB1t9fPuHMDC20Uk3z9STLkUlY0XaibWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7677
X-OriginatorOrg: intel.com

SGkgUGF1bCwNCg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLiBJIHdpbGwgaW5jb3Jwb3JhdGUg
dGhlICBjaGFuZ2VzIGluIHYzIHZlcnNpb24gb2YgdGhlIHBhdGNoLg0KDQo+U3ViamVjdDogUmU6
IFtQQVRDSCB2Ml0gQmx1ZXRvb3RoOmJ0aW50ZWw6IERvIG5vIHBhc3MgdmVuZG9yIGV2ZW50cyB0
byBzdGFjaw0KPg0KPkRlYXIgS2lyYW4sDQo+DQo+DQo+VGhhbmsgeW91IGZvciB5b3VyIHBhdGNo
LiBQbGVhc2Ugbm90ZSwgaW4gdGhlIHN1bW1hcnkvdGl0bGUgYSBzcGFjZSBpcyBtaXNzaW5nDQo+
YmVmb3JlICpidGludGVsKi4NCj4NCj5BbSAxNy4xMC4yNCB1bSAxMjoyMiBzY2hyaWViIEtpcmFu
IEs6DQo+PiBEdXJpbmcgZmlybXdhcmUgZG93bmxvYWQsIHZlbmRvciBzcGVjaWZpYyBldmVudHMg
bGlrZSBib290IHVwIGFuZA0KPj4gc2VjdXJlIHNlbmQgcmVzdWx0IGFyZSBnZW5lcmF0ZWQuIFRo
ZXNlIGV2ZW50cyBjYW4gYmUgc2FmZWx5IHByb2Nlc3NlZA0KPj4gYXQgdGhlIGRyaXZlciBsZXZl
bC4gUGFzc2luZyBvbiB0aGVzZSBldmVudHMgdG8gc3RhY2sgcHJpbnRzDQo+PiB1bm5lY2Vzc2Fy
eSBiZWxvdyB3YXJuaW5nIGxvZy4NCj4+DQo+PiAtLQ0KPj4gQmx1ZXRvb3RoOiBoY2kwOiBNYWxm
b3JtZWQgTVNGVCB2ZW5kb3IgZXZlbnQ6IDB4MDINCj4+IC0tDQo+DQo+SeKAmWQgcmVtb3ZlIHRo
ZSBgLS1gIGFuZCBqdXN0IGluZGVudCB0aGUgbWVzc2FnZSBieSBmb3VyIGNoYXJhY3RlcnMgdG8g
Zm9sbG93DQo+TWFya2Rvd24gbWFya3VwIHN0eWxlLg0KPg0KPk9uIHdoYXQgZGV2aWNlIGRpZCB5
b3UgdGVzdCB0aGlzPyBBcmUgdGhlcmUgb3BlbiByZXBvcnRzIGFib3V0IGl0Pw0KPg0KPj4gRml4
ZXM6IDMzNjhhYTM1N2YzYiAoIkJsdWV0b290aDogbXNmdDogSGFuZGxlIE1TRlQgTW9uaXRvciBE
ZXZpY2UNCj4+IEV2ZW50IikNCj4+IFNpZ25lZC1vZmYtYnk6IEtpcmFuIEsgPGtpcmFuLmtAaW50
ZWwuY29tPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYyAgICAgIHwg
NiArKysrLS0NCj4+ICAgZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmMgfCA5ICsrKysr
Ky0tLQ0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25z
KC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYyBiL2Ry
aXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYw0KPj4gaW5kZXggMmJlNmQ0OGEyYTY1Li5lMTIyZGZm
ODU1YmEgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2JsdWV0b290aC9idGludGVsLmMNCj4+ICsr
KyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYw0KPj4gQEAgLTMzOTUsNyArMzM5NSw4IEBA
IGludCBidGludGVsX3JlY3ZfZXZlbnQoc3RydWN0IGhjaV9kZXYgKmhkZXYsIHN0cnVjdA0KPnNr
X2J1ZmYgKnNrYikNCj4+ICAgCQkJCSAqIGluZGljYXRpbmcgdGhhdCB0aGUgYm9vdHVwIGNvbXBs
ZXRlZC4NCj4+ICAgCQkJCSAqLw0KPj4gICAJCQkJYnRpbnRlbF9ib290dXAoaGRldiwgcHRyLCBs
ZW4pOw0KPj4gLQkJCQlicmVhazsNCj4+ICsJCQkJa2ZyZWVfc2tiKHNrYik7DQo+PiArCQkJCXJl
dHVybiAwOw0KPj4gICAJCQljYXNlIDB4MDY6DQo+PiAgIAkJCQkvKiBXaGVuIHRoZSBmaXJtd2Fy
ZSBsb2FkaW5nIGNvbXBsZXRlcyB0aGUNCj4+ICAgCQkJCSAqIGRldmljZSBzZW5kcyBvdXQgYSB2
ZW5kb3Igc3BlY2lmaWMgZXZlbnQNCj5AQCAtMzQwMyw3ICszNDA0LDgNCj4+IEBAIGludCBidGlu
dGVsX3JlY3ZfZXZlbnQoc3RydWN0IGhjaV9kZXYgKmhkZXYsIHN0cnVjdCBza19idWZmICpza2Ip
DQo+PiAgIAkJCQkgKiBsb2FkaW5nLg0KPj4gICAJCQkJICovDQo+PiAgIAkJCQlidGludGVsX3Nl
Y3VyZV9zZW5kX3Jlc3VsdChoZGV2LCBwdHIsIGxlbik7DQo+PiAtCQkJCWJyZWFrOw0KPj4gKwkJ
CQlrZnJlZV9za2Ioc2tiKTsNCj4+ICsJCQkJcmV0dXJuIDA7DQo+PiAgIAkJCX0NCj4+ICAgCQl9
DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5jDQo+
PiBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5jDQo+PiBpbmRleCBlNGFlOGM4OThk
ZmQuLmRlZWQ4MDUyYjQ4MiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50
ZWxfcGNpZS5jDQo+PiArKysgYi9kcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuYw0KPj4g
QEAgLTU1MSw3ICs1NTEsOCBAQCBzdGF0aWMgaW50IGJ0aW50ZWxfcGNpZV9yZWN2X2V2ZW50KHN0
cnVjdCBoY2lfZGV2DQo+KmhkZXYsIHN0cnVjdCBza19idWZmICpza2IpDQo+PiAgIAkJCQlpZiAo
YnRpbnRlbF9wY2llX2luX29wKGRhdGEpKSB7DQo+PiAgIAkJCQkJYnRpbnRlbF9wY2llX3dyX3Ns
ZWVwX2NudHJsKGRhdGEsDQo+QlRJTlRFTF9QQ0lFX1NUQVRFX0QwKTsNCj4+ICAgCQkJCQlkYXRh
LT5hbGl2ZV9pbnRyX2N0eHQgPQ0KPkJUSU5URUxfUENJRV9JTlRFTF9IQ0lfUkVTRVQyOw0KPj4g
LQkJCQkJYnJlYWs7DQo+PiArCQkJCQlrZnJlZV9za2Ioc2tiKTsNCj4+ICsJCQkJCXJldHVybiAw
Ow0KPj4gICAJCQkJfQ0KPj4NCj4+ICAgCQkJCWlmIChidGludGVsX3BjaWVfaW5faW1sKGRhdGEp
KSB7IEBAIC01NjgsNw0KPis1NjksOCBAQCBzdGF0aWMgaW50DQo+PiBidGludGVsX3BjaWVfcmVj
dl9ldmVudChzdHJ1Y3QgaGNpX2RldiAqaGRldiwgc3RydWN0IHNrX2J1ZmYgKnNrYikNCj4+ICAg
CQkJCQkJYnRpbnRlbF93YWtlX3VwX2ZsYWcoZGF0YS0NCj4+aGRldiwNCj4+DQo+SU5URUxfV0FJ
VF9GT1JfRDApOw0KPj4gICAJCQkJfQ0KPj4gLQkJCQlicmVhazsNCj4+ICsJCQkJa2ZyZWVfc2ti
KHNrYik7DQo+PiArCQkJCXJldHVybiAwOw0KPj4gICAJCQljYXNlIDB4MDY6DQo+PiAgIAkJCQkv
KiBXaGVuIHRoZSBmaXJtd2FyZSBsb2FkaW5nIGNvbXBsZXRlcyB0aGUNCj4+ICAgCQkJCSAqIGRl
dmljZSBzZW5kcyBvdXQgYSB2ZW5kb3Igc3BlY2lmaWMgZXZlbnQNCj5AQCAtNTc2LDcgKzU3OCw4
IEBADQo+PiBzdGF0aWMgaW50IGJ0aW50ZWxfcGNpZV9yZWN2X2V2ZW50KHN0cnVjdCBoY2lfZGV2
ICpoZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQ0KPj4gICAJCQkJICogbG9hZGluZy4NCj4+ICAg
CQkJCSAqLw0KPj4gICAJCQkJYnRpbnRlbF9zZWN1cmVfc2VuZF9yZXN1bHQoaGRldiwgcHRyLCBs
ZW4pOw0KPj4gLQkJCQlicmVhazsNCj4+ICsJCQkJa2ZyZWVfc2tiKHNrYik7DQo+PiArCQkJCXJl
dHVybiAwOw0KPj4gICAJCQl9DQo+PiAgIAkJfQ0KPg0KPg0KPktpbmQgcmVnYXJkcywNCj4NCj5Q
YXVsDQoNClRoYW5rcywNCktpcmFuDQoNCg==
