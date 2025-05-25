Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2280018DB0D
	for <linux-bluetooth@vger.kernel.org>; Sun, 25 May 2025 07:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748158552; cv=fail; b=gUu9UPkynJN3GUF0a2tK8QRTYLB4cYctdtXlOuBgBAV10iY+JBtGeY2uofuFUyKrr6riGCJYYfBPrHsJVUNdYUbtiWM1eF1SnSbDVD1ZSPG4ojARh/LFFtkZTJgnNIfx3SiZiOJ5cN2OwYuRuSIxliKmbZylmYzKMnVkhYFUiOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748158552; c=relaxed/simple;
	bh=MoXMUpTPVAL/g8g8fXHat/JGKmBWrfpyGU9egDAUZeo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CxRFK/d7TOog48WgRtbu4l11hhJaKWyDBVUaDHh2YLC9M3pGFthTvqOVba35WHomA12IIGcFRSU9PKAEP1x9FTfldlJ/2cLvILtfU3nmWm/SGm7scM2Piui29+vjnvsWIawE79Jnof9MUbjKjcgZ3TmS5EAyRO6PGz+2RQnfS3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I/3Kias4; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I/3Kias4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748158550; x=1779694550;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MoXMUpTPVAL/g8g8fXHat/JGKmBWrfpyGU9egDAUZeo=;
  b=I/3Kias4xFcBXPOkk3DdZhFP0fLnKLoCILHnLzFsB78FZhMA0ec6Y/V4
   eY6wc4iCnmiqNFGFq98U1IOBLqvbxsuF+SY1EbMWYSs70xZphjlLaW+0W
   ouWdz2xwy1hX73PCPMpuOgFK27F1NtcJPt6qZvr/VOLj7Wv1eQkkF4WcB
   rC0UyiaarZWMgFyH5RMQpNAfp9xgC6XVcTOVNggunyPW43HQ8N9YzY922
   uCxmcA0PcGR1iF4ClTA+vg90mxm+9YSVUNfKxBNI9Zo+gLwcSumqL4tfL
   U4Yey5CsHDNAauk2Kcsv81f+b17S3gADwZAZxeg0sSY6moqFryA9y/b5J
   Q==;
X-CSE-ConnectionGUID: 9lAwmGsBS+Sad8MTczXxIQ==
X-CSE-MsgGUID: CUfoSoASSc+dc026RsLmkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11443"; a="50311709"
X-IronPort-AV: E=Sophos;i="6.15,312,1739865600"; 
   d="scan'208";a="50311709"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2025 00:35:46 -0700
X-CSE-ConnectionGUID: 4dN9rB9tQOejp/4W255m+Q==
X-CSE-MsgGUID: WJX2a+IWSG+FceqqfS/KLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,312,1739865600"; 
   d="scan'208";a="141739687"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2025 00:35:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 25 May 2025 00:35:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 25 May 2025 00:35:43 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.66)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Sun, 25 May 2025 00:35:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GI0To3JEvYENixWUiUf/DETs3E6zwTMWdNogyiogwtqLOYpxSx4T4+cNmO1/Gi5uEFcW5URmt2tY+ziIJN6mbhe4lO+CeI9+UR6zqSErLjPlz77GO07SS3Hl8+4S6ngKTBkAmX9HQnlxNHtMlCEUqKp98rPHz0+Fr7jCamA9ziUV2FS0cX7KETw9cPWHf+Ai/Reai0r7bHB1ZfRsMxgoxNJILDo83J1yb/YiazW9NQPFkIr5e1A7lM6ef3WuNhY5vvTcBgGQb/ijzdsf3SMh5KHANWzL+h87O1K9cgobvFRp1WRp+mNz8LuBnzbULtOdehq7TCp37IvwPArvVpR1mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MoXMUpTPVAL/g8g8fXHat/JGKmBWrfpyGU9egDAUZeo=;
 b=vo96FzOhNypYqUzJ/MyeuTkw38kNKvWo9ohgJ9CQSNGZ/0x9tyNY+JyiP7DWYm84b7nLEvP4YT3lMhYpp3ibUp+4D/ETox29ZtabkB7A9RCRr+CoW1fJG4EypukoB2zc/tP6gaeA2N+E+46q5IsLoDJkT9KXchOw+/Kys8OmVQ1gUy0uMa6QFPPtxO+nY59Y1bNXbajts/rlYhs1Mgb4LyL4191ARjWiYQuNlu+WeApkw+IQ119KQEWrF+JNlL70KhSfU0TG5Us53Ak4R7j7oNWSC0G30L6F14+o4XZXHLAnVzoCDoYt30OfmfO6mUKZ+QvGppj46eGMUzJD3gWbWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by SN7PR11MB7042.namprd11.prod.outlook.com (2603:10b6:806:299::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Sun, 25 May
 2025 07:35:13 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%5]) with mapi id 15.20.8769.025; Sun, 25 May 2025
 07:35:13 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, "Devegowda, Chandrashekar"
	<chandrashekar.devegowda@intel.com>, "Satija, Vijay" <vijay.satija@intel.com>
Subject: RE: [PATCH v1 1/3] Bluetooth: btintel_pcie: Fix driver not posting
 maximum rx buffers
Thread-Topic: [PATCH v1 1/3] Bluetooth: btintel_pcie: Fix driver not posting
 maximum rx buffers
Thread-Index: AQHbzTUg2ekZZQAzGUyPcEQiW9L/8rPi0+yAgAAaylA=
Date: Sun, 25 May 2025 07:35:12 +0000
Message-ID: <PH0PR11MB75850E9811317B69D442275FF59AA@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20250525053940.520283-1-kiran.k@intel.com>
 <2a9f871b-504d-4a7a-9af1-8eef62982bee@molgen.mpg.de>
In-Reply-To: <2a9f871b-504d-4a7a-9af1-8eef62982bee@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|SN7PR11MB7042:EE_
x-ms-office365-filtering-correlation-id: 3481b176-3a75-4137-281d-08dd9b5eaf88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YWU4YjFlQWJBSlplRlZuMDRITHhnSmoyZUl4Q2MrbklxK0ltaHRuUWYyeWp5?=
 =?utf-8?B?aHJnYWNzd1pBUExYSFhiTDdBOHgzdnJuM3JSckcvS3NTbXZBS3VOcFZtOWRq?=
 =?utf-8?B?dGFCclYwWmpzckUxaVNpVnpsc2xEeHlrNXNFVm41U2xhOERhekZlRmo3MmJJ?=
 =?utf-8?B?TitDc2tKMzdXclRCdzFBcWswa0RCaHZjOFlCcVpZWnA1eURSazJZNGoyWk9o?=
 =?utf-8?B?VWN1SmN2ZmM0Y251Y3JjSU9LeFVlN0N1RXNoM25Vb3htQ284VGNQSnFBTGdV?=
 =?utf-8?B?OHBsNG5CbkI4ajU4VERsZE5aSjF0RHovRGNMRUp3MEh4dEdKV2dNMFdRcTVz?=
 =?utf-8?B?Vm56clR3dTllRE12RDQ3NUlHNE5MREw3NVJ3ajQvY25PWldJQlBhVU5YTHZX?=
 =?utf-8?B?RmVvUXJVbTVHZVhQU3I1bU84U0NhOXMyTjBidGh5cGY4RnBvOFY0SE1FOEJQ?=
 =?utf-8?B?RXBBdUlSc2dKY1hkYWhTajRDbmxpd1NxVkdkS2pRUklvaUJjSzZrVEN6L0lQ?=
 =?utf-8?B?TTJlSDM5b1ZZNXhQSC8xSEo2YTRjYzljaHRkWUZZZmlDeDZwTjRjSGo0K1c4?=
 =?utf-8?B?N3dDemRpODhDSlZXRnJYQmFHM09NS2k1eXZRZE9lOEdRVXErOC92NVljdWV1?=
 =?utf-8?B?K3lTbUU4T3Vwd3JPOTl1MlNJY3pQSkhSR1NQbHdZd1dpdmw1OWpXUis0eFE5?=
 =?utf-8?B?RmZraVJRVkNJaWpTcWFudWpnMitjdG1Ua2dWNDFwNWJuTzJIbXJiblh3RVZr?=
 =?utf-8?B?VktPWkYyZWswUWhJanlSUGR5ODBTdlFJVGdLOExGRTFxaXlVc3o1enYxWHZv?=
 =?utf-8?B?Y1cwTWZTYU43bzRHRjlKUE1CUm9sTEFqemt1ZUs2WjZJNXVzRUVDNHBXVUhz?=
 =?utf-8?B?STZzYWpMYllod2cyWG1BaU9kZmJ0aEVvYUp3Zi8rSVJxTDZiU1Z4dm5LaTI0?=
 =?utf-8?B?eDQzMHJxb3FxZGluY3JLb1ZhNzVwbUJlWWlqeU53c251aVdqOUtQcWdITlV3?=
 =?utf-8?B?czBQYVpwNURtU29nZlJ5aGsyRm1ueVF4eVNFQWdiZHlhRkcyR3N1OXNDWEJM?=
 =?utf-8?B?RXdKbndFdVprRmJMK2R3bE5xR1RIRTVYaERGUUdYR3lvQlBRcUF3VlppenhO?=
 =?utf-8?B?V1RtUm81QXB3ZTlNOHNpbXFEWFBZeUFFdG13UGlGK01SZW9tUDg1OTg5UThj?=
 =?utf-8?B?SUZKclpmMVdYRjVlV0h2UmlWT1ZDSWlLb3FwUFV4UjlZdjhmSStBcDVIeHdO?=
 =?utf-8?B?YUFldDc2bm1ybGxIRzNkZFBhd2ZhV1p5ekR1K3kra1ZwUldySEJRVW4rVGJP?=
 =?utf-8?B?SnRHWk1IcnBaclZpSTdxeVRFdHdHbnRhc2dEd3NWVGJpdnE3STVSeGpuYzNl?=
 =?utf-8?B?Q0FoVTdOVzhsVW0vR3A1ZmJBZi8yQWxHc0R5Y3lHNzI1M01wQTUwWHFDWGZW?=
 =?utf-8?B?Tk8zYXRPUWtaaFFsaXIzeDA5UFhXSUJLUy9UZERMRlNZRFN2RE5JQ1hBWC92?=
 =?utf-8?B?VnVkQkxyR2RiSnp2bkNUNHVVcDdSdjNneUZZdUNTNzFTYk1xcXVWSEVlZVVl?=
 =?utf-8?B?eW8rVHN1aGN0bksvS3V0R0daWjZlbm9SZDk0Qk9BRU4xa1NCaXFMV0ZFNmpm?=
 =?utf-8?B?cXRjYjYwZ3NGTmZlbk1XM0U5UXBBSG1hbEppOWJRNUlwSmhxa2RpZHFPQktF?=
 =?utf-8?B?YjB2dXplWmVhU0VHNGt6RnRkLzZuaDY5V3pmRUhLS1htbnA3N0ZKZnMzWWEy?=
 =?utf-8?B?SFNFdVpHbE9HZldsMm0xUnhOazdHVFhoMjFTTkIrclRkTjdvR25jdlN0OFJu?=
 =?utf-8?B?eUZUVWxGZFBXWXRDWVcvQVJtWXN0cHFpWlI3RW9McUFjUUVGN3h0ME9lMndJ?=
 =?utf-8?B?SmhvUlo1VlpyckVhaUpoS2N6NGdpenBzbjV1aG9wL2ppSWorcnh2enkwMGJT?=
 =?utf-8?B?TWJ4LzcxOVg1ckE3SEp3Qk8zeUF4UWNuVCtoOXNFeXVTN2ROOW9hSFlBTG9W?=
 =?utf-8?B?U0J4TFRCT2FBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TldSRThXMnpZMEFSNzBJb0d5dmxQWGJUQUcyTlZrUHYvSThkTnh6UEZlcXhl?=
 =?utf-8?B?MmExd2x5bWZOcEY0dDI0UVVVMkFrOUNDa0I5bFRyVHh3NFdKYkduL296ZTE5?=
 =?utf-8?B?SlJiNERtRHJ5REhXZW5HTEJXQVlXbnJlQ0ttVDVqbitSd1R1RWZ5cGNGanFL?=
 =?utf-8?B?WVFtY2dZQVhjZHVTUFdWaHpuQStIaWxYWlMyalNjcmNpVDNtMEZaYTZMR2dQ?=
 =?utf-8?B?NDQ0UlNTMnFuc005K25OWVlOd210Szc5WGJCL0ljWngwaHRNaHVBRWtKblJz?=
 =?utf-8?B?R05sQ1dWaVNuc2l2cUo0SnZkWVpGK3VOYVRFQnQ3OUlrK3lBN3YzUjlkTHBp?=
 =?utf-8?B?dVBVWUhOVkM0b1FzYy82QmVkSXdNcnZqL3F2WEJ5Rm91dkJROEVXWVEvSVpX?=
 =?utf-8?B?Y29YY2FPbzEzTGJ4SmgzOEVtM1ZmWUFXTGVOaDZxQ056aFBUaHhuR3ZvMXVt?=
 =?utf-8?B?dzV0U2d4aE94UzVhT3lkeTliNmo4Z0NjY0NKYXM0L0dBa0FyWXBiVzJYYVpn?=
 =?utf-8?B?L2RiQzhrVzY4Zm5jUHRPaFpZQlpUTkRScFhSNStaMHpOU29GRnRZYlpLK3JC?=
 =?utf-8?B?LzFoUHNiaWxaNk1XNWtmcHBBYVZhaUZBUlYvZ2E0L1BtM25WWFpjK3UzZDZF?=
 =?utf-8?B?NGlrL0xtUDZaMy9XWW1ETm1CUkROelpsUE5DaWFyVWpLUGdYbnFxQVpxdlB0?=
 =?utf-8?B?UjJmTmZSRTJOK05jNjBYUkgrckE3Nlo0L1BWNk5CUEo5Y1U1SnBkQ0JCeXpN?=
 =?utf-8?B?RWdhSFlEZlB3cXVJdmIvUzZGdW4xQXVlWXFtYUtTMGVJeTZGMVJxbk4rN3Ax?=
 =?utf-8?B?azUvMG5xd3JGSG9ra0kyRjc5d2diWHowVmZLajIreW96R1VtUUlPamlOUFRm?=
 =?utf-8?B?ejh1a09ZdFBoeW5ZVGtlQ1FibXJEVlVPa0YyT2U0NWF2UVh4ZDNmenViNHhm?=
 =?utf-8?B?UmJmWE42eFlwUUZDR2hkbWh3emMxMGNCTnpRODF4M0hBWVpkRFFyVm8ySHZZ?=
 =?utf-8?B?KzhoWjdtcTl4ZkR1aXVGWnNsV1lyaGxzcjVFaGxHeE9qdXR4RlhYYzZydTdS?=
 =?utf-8?B?ZTVCNTRUTnFXYW42NXNSbWNmMzc4b3FjYmg5a2NPRE44YnFFNjhzb1orNThL?=
 =?utf-8?B?d2lVRVVTbjM5TUpvRGdkN3pwVzRSQ3NIN05IenNJSEZMT1REbVkxVlVpZWF1?=
 =?utf-8?B?L29rWHhJV0NJbXQxMjBFMGRwdE1IQ3o3ZmQxQXhxcXRRNFBXNzVQYU04TVln?=
 =?utf-8?B?aWR4S3ZSbEpjdnV6L3hpVzROSmpROXZpTUdMUFVJNWx4TFBib2szYVdsUUt4?=
 =?utf-8?B?czNZTDVnNmwyN25EdnRjZXBPSEl4VXVnNW02RFdCejVyZ3pobmdzYUhGRUtp?=
 =?utf-8?B?L2ZMcnh6MWV0K01PSUlRckQwMlJwNHg2NU1OQjJua3QzVlMrNzdzZTVWMFZF?=
 =?utf-8?B?OG1BOUtuaE1VWTgzWHhrMG5JZTg4cVNXMTZjbm5zbytqYVUxbVNmdjJZbmVH?=
 =?utf-8?B?MTk3ZjBza3NPSUNIbFQrYXhQSXViSE5WamVnMjdJdmRmODlITHlMcGNpb0Vx?=
 =?utf-8?B?VDkvSzhPejdHSHdBQkFMblduZGJLK2hEb2dxcURuSHdTZTBQNmJyeGxQMEF3?=
 =?utf-8?B?bHFzTnE4WkN3bVZkNTliVlIvaDBvYjk4anF5L0kxYXlLMlErU3RDMkt3YXIw?=
 =?utf-8?B?TWpjb0VRTnRUMm5VWk94TzZYKzRSSm1kc3hSTUozVFROOHJFTUh1K1FpeXBM?=
 =?utf-8?B?empoUjFMaGN6L1M0RmRqcW9BdWlqYVhleVFWblExNm1QVHdOdXFGR3hHSita?=
 =?utf-8?B?WnB2VUJRU1JxcU11Q01TRGZBSDR4ckIrVzNQd29INEZRVCtkTE1Ua0ZoTlhY?=
 =?utf-8?B?WnFBWWdQTkN0dDVHZmNUdkhlYTJNcndYUVdGdm9KQVk0T0VEZWpDaCtEVU9F?=
 =?utf-8?B?Y0VmMUNYM1R1S0ZFTjJjV3B0Snh3b1dNUXJ2eE9zdFVqK2Y4T1Erc0Examt0?=
 =?utf-8?B?UVNBSnR5SEF2aHZhVzBlQ0h0YXJZbG00MUtrYUlvTE9lT05pU0NReXhoNGx2?=
 =?utf-8?B?Si9LUVVVd0dPZHVjcHk4TTlxY0luUUY4WGhzOGg2dU5ZQ1RLNGxqeG02cEFr?=
 =?utf-8?Q?mWGk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3481b176-3a75-4137-281d-08dd9b5eaf88
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2025 07:35:13.0347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ADQ4K11Qj/qynAuUgc2+rRyKdfsuB1Fwf8mAK/4qYiv6fjesjmiTLeftnhZb8ufyquBmUIFU+HMOhC4rvYMs7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7042
X-OriginatorOrg: intel.com

SGkgUGF1bCwNCg0KVGhhbmtzIGZvciB0aGUgY29tbWVudHMuDQoNCj5TdWJqZWN0OiBSZTogW1BB
VENIIHYxIDEvM10gQmx1ZXRvb3RoOiBidGludGVsX3BjaWU6IEZpeCBkcml2ZXIgbm90IHBvc3Rp
bmcNCj5tYXhpbXVtIHJ4IGJ1ZmZlcnMNCj4NCj5EZWFyIEtpcmFuLA0KPg0KPg0KPlRoYW5rIHlv
dSBmb3IgdGhlIHBhdGNoLg0KPg0KPkFtIDI1LjA1LjI1IHVtIDA3OjM5IHNjaHJpZWIgS2lyYW4g
SzoNCj4+IFRoZSBkcml2ZXIgd2FzIHBvc3Rpbmcgb25seSA2IHJ4IGJ1ZmZlcnMsIGRlc3BpdGUg
dGhlIG1heGltdW0gcngNCj4+IGJ1ZmZlcnMgYmVpbmcgZGVmaW5lZCBhcyAxNi4NCj4NCj5UaGUg
c2Vjb25kIHBhcnQgaXMgd29yZGVkIHN0cmFuZ2VseSwgYXMgdGhlIG1hY3JvLCB5b3UgcmVtb3Zl
LCBpcyBkZWZpbmVkIHRvDQo+YmUgNi4gV2FzIGl0IGp1c3QgYSB0eXBvPw0KPg0KVGhlIG1hY3Jv
IHZhbHVlIHdhcyBkZWZpbmVkIGluY29ycmVjdGx5IHRvIDYsIGluc3RlYWQgb2YgMTYuDQoNCj4+
IFVwZGF0ZSB0aGUgZHJpdmVyIHRvIHBvc3QgdGhlIGZ1bGwgMTYgUnggYnVmZmVycyB0byB1dGls
aXplIHRoZQ0KPj4gbWF4aW11bSBjYXBhY2l0eSBhbmQgaW1wcm92ZSBwZXJmb3JtYW5jZS4NCj4N
Cj5QbGVhc2UgYWxzbyBub3RlLCB0aGF0IHlvdSByZW1vdmUgdGhlIG1hY3JvLCBiZWNhdXNlIHRo
ZSB2YWx1ZSBzZWVtcyB0byBiZQ0KPmRldGVjdGFibGUuDQo+DQpJbnN0ZWFkIG9mIHVzaW5nIG1h
Y3JvLCByeHEtPmNvdW50IGlzIHVzZWQgd2hpY2ggaXMgaW5pdGlhbGl6ZWQgdG8gMTYgIGluIHRo
ZSBidWZmZXIgYWxsb2NhdGlvbiBmdW5jdGlvbiBidGludGVsX3BjaWVfYWxsb2MoKS4NCg0KPlBs
ZWFzZSBhbHNvIG1lbnRpb24sIGhvdyB5b3VyIGNoYW5nZSBjYW4gYmUgdmVyaWZpZWQsIGZvciBl
eGFtcGxlIHJlYWQgb3V0IGluDQoNClRoZSBpc3N1ZSB3YXMgcmVwb3J0ZWQgaW50ZXJuYWxseSBv
dmVyIEFuZHJvaWQuIE9uIGNvbm5lY3RpbmcgYmx1ZXRvb3RoIG1vdXNlLCB0aGVyZSB3YXMgYW4g
ZXhjZXB0aW9uIHJlcG9ydGVkIGZyb20gZmlybXdhcmUgaW4gbGVzcyB0aGFuIDUgc2Vjb25kcyBh
cyB0aGVyZSBhcmUgbm90IGVub3VnaCBidWZmZXIgZm9yIHRoZSBmaXJtd2FyZSB0byBzZW5kIHRo
ZSBoaWQgcmVwb3J0cy4gIEFsb25nIHdpdGggdGhpcyBjaGFuZ2UsIHdlIHdvdWxkIGFsc28gbmVl
ZCAyLzMgYW5kIDMvMyBwYXRjaGVzIHRvIGZ1bGx5IGZpeCB0aGUgZXhjZXB0aW9uIGlzc3VlLg0K
DQo+dGhlIGxvZ3Mgb3IgZnJvbSAvc3lzLCBhbmQgaG93IHRoZSBwZXJmb3JtYW5jZSBjYW4gYmUg
bWVhc3VyZWQsIGFuZCB3aGF0DQoNCldoZW4gdGhlIGZpcm13YXJlIGV4Y2VwdGlvbiBvY2N1cnMs
IGRyaXZlciBwcmludHMgdGhlIGV4Y2VwdGlvbiBpbiB0aGUga2VybmVsIG1lc3NhZ2UuDQoNCj55
b3UgbWVhc3VyZWQgYmVmb3JlIGFuZCBhZnRlci4gKENsYWltbnMgcmVnYXJkaW5nIHBlcmZvcm1h
bmNlIHNob3VsZCBhbHdheXMNCj5jb21lIHdpdGggbWVhc3VyZW1lbnRzLikNCg0KVGhpcyBpc3N1
ZSBpcyBtb3JlIHRvIGRvIHdpdGggc3RhYmlsaXR5IHJhdGhlciB0aGFuIHBlcmZvcm1hbmNlLiBJ
IHdpbGwgdXBkYXRlIHRoZSBjb21taXQgbWVzc2FnZSBpbiB0aGUgdjIgdmVyc2lvbiBvZiB0aGUg
cGF0Y2guDQoNCj4NCj4+IFNpZ25lZC1vZmYtYnk6IENoYW5kcmFzaGVrYXIgRGV2ZWdvd2RhDQo+
PiA8Y2hhbmRyYXNoZWthci5kZXZlZ293ZGFAaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTog
S2lyYW4gSyA8a2lyYW4ua0BpbnRlbC5jb20+DQo+PiBGaXhlczogYzJiNjM2YjNmNzg4ICgiQmx1
ZXRvb3RoOiBidGludGVsX3BjaWU6IEFkZCBzdXBwb3J0IGZvciBQQ0llDQo+PiB0cmFuc3BvcnQi
KQ0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5jIHwgMyArKy0N
Cj4+ICAgZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmggfCAzIC0tLQ0KPj4gICAyIGZp
bGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmMNCj4+IGIvZHJpdmVycy9i
bHVldG9vdGgvYnRpbnRlbF9wY2llLmMNCj4+IGluZGV4IDUwZmUxN2YxZTFkMS4uMmM3NzMxODAz
YzlmIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmMNCj4+
ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5jDQo+PiBAQCAtMzk2LDggKzM5
Niw5IEBAIHN0YXRpYyBpbnQgYnRpbnRlbF9wY2llX3N1Ym1pdF9yeChzdHJ1Y3QNCj5idGludGVs
X3BjaWVfZGF0YSAqZGF0YSkNCj4+ICAgc3RhdGljIGludCBidGludGVsX3BjaWVfc3RhcnRfcngo
c3RydWN0IGJ0aW50ZWxfcGNpZV9kYXRhICpkYXRhKQ0KPj4gICB7DQo+PiAgIAlpbnQgaSwgcmV0
Ow0KPj4gKwlzdHJ1Y3QgcnhxICpyeHEgPSAmZGF0YS0+cnhxOw0KPj4NCj4+IC0JZm9yIChpID0g
MDsgaSA8IEJUSU5URUxfUENJRV9SWF9NQVhfUVVFVUU7IGkrKykgew0KPj4gKwlmb3IgKGkgPSAw
OyBpIDwgcnhxLT5jb3VudDsgaSsrKSB7DQo+PiAgIAkJcmV0ID0gYnRpbnRlbF9wY2llX3N1Ym1p
dF9yeChkYXRhKTsNCj4+ICAgCQlpZiAocmV0KQ0KPj4gICAJCQlyZXR1cm4gcmV0Ow0KPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5oDQo+PiBiL2RyaXZlcnMv
Ymx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5oDQo+PiBpbmRleCAyMWI5NjRiMTVjMWMuLjVkZGQ2ZDdk
OGQ0NSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5oDQo+
PiArKysgYi9kcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuaA0KPj4gQEAgLTE3Nyw5ICsx
NzcsNiBAQCBlbnVtIHsNCj4+ICAgLyogRG9vcmJlbGwgdmVjdG9yIGZvciBURkQgKi8NCj4+ICAg
I2RlZmluZSBCVElOVEVMX1BDSUVfVFhfREJfVkVDCTANCj4+DQo+PiAtLyogTnVtYmVyIG9mIHBl
bmRpbmcgUlggcmVxdWVzdHMgZm9yIGRvd25saW5rICovDQo+PiAtI2RlZmluZSBCVElOVEVMX1BD
SUVfUlhfTUFYX1FVRVVFCTYNCj4+IC0NCj4+ICAgLyogRG9vcmJlbGwgdmVjdG9yIGZvciBGUkJE
ICovDQo+PiAgICNkZWZpbmUgQlRJTlRFTF9QQ0lFX1JYX0RCX1ZFQwk1MTMNCj4NCj4NCj5LaW5k
IHJlZ2FyZHMsDQo+DQo+UGF1bA0KDQpUaGFua3MsDQpLaXJhbg0KDQo=
