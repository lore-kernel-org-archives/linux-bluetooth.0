Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ED8881E
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 12:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751977846; cv=fail; b=JHrW6J7Y3ZxqRghfAAHs89oItTOUuIacrN4cp0pZ7xv0JQ5zjZI4wxw1Cy7XzvxDHj6s853VXmYOm0gSMlbBy4WYKb2Eu/EZcMDsMHCW+RIIbTo7Emd2aSKshKJGaldefbefEF6JSgbtRUAcPgzcy3hqKDR4M71cISIJ7vwgNDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751977846; c=relaxed/simple;
	bh=ytWogg4s9yo+i9xDsDBUHTf8Ds59oxeGCF4DDz69sAQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dTJka0ERqblyWUeSZvt2UTPwdNnckqxw5ewCdgUQbM4ZTboTDfbO3KvqovBtieF535kUR21ILJ1JpSB+ipeFJH3myiK0HPHh5rdmB2u4mzgouhAGNQaAKTwwEamMND9Dew+LGo4DEs2YLR2i79mC1Ib94L2ogsHV8WlEb91+o5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U1e7G+w4; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U1e7G+w4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751977845; x=1783513845;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ytWogg4s9yo+i9xDsDBUHTf8Ds59oxeGCF4DDz69sAQ=;
  b=U1e7G+w4FpUvRqBDOxaT4LZQouwttl5hDA88cHdN23Jvw4Xd0hVMUKMm
   OynUuuq/Ac+F+sQpHEQG/dh8YZgOIdmAurbbs+adRRTwXFvfodf6ZVx4w
   0OwoIQE4BBv2BHhfA6Helyp7HRoO3ELRWsJ8pRoVggk4uo7kCZrWhy5W1
   7P7uqKUhHlkqKCthF+6Zmv6yOPS56qYvGYr2BK3+ltMyplXh7OfGrCB1l
   nqXHCh8NiPb9dI2fSgIwZjBUN3xHTkL5k8r3DmSoFPUAMgmX/YAK5DKpz
   zT+F4Z2goFhVmEBD3h247JipYFmgJnTNzZxj3mnXLk5zYuJrAiPAs//1J
   w==;
X-CSE-ConnectionGUID: PXhT942KTT+jbiK5FYRNaA==
X-CSE-MsgGUID: /dblYa25QASW1vhr6nPyVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="76762488"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="76762488"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 05:30:44 -0700
X-CSE-ConnectionGUID: 1NjT2LcPT6mUiAOoiKB/Pg==
X-CSE-MsgGUID: TLGNMxmwRAyeiUM+lKVPaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="186507062"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 05:30:45 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 05:30:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 05:30:43 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.85)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 05:30:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6T4ZNsJhFg7r+knOYAaOMyU0h9h9dVoJDUpmnC9eR3bYtA5TpNo7dHHywOPfKYsCEOoe6S4Cr13WHjWVBdSPLSKcS4tYRfclgEvxWXlP9NobEw7klBGiiKvKHtvqP1dyvjCIbeYmpDdxZDI6ZBVmRnGgJownT6qX+LR0gO8fQ52RAtm1lnOAubFBjg6enWnVkL4SW8P4N/4RWS5qXbUsX9I/CahgqBlclNSw7zZrOTyhMHMwhleMArxb5LudJcwrUd9IKw8DLCTTqSG916jkNPpy/2dNkbuesSz2gE95NzQoaG/KQqqMf7y7WANPRXq5AWi9scMuj5hJPGh7e1rpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytWogg4s9yo+i9xDsDBUHTf8Ds59oxeGCF4DDz69sAQ=;
 b=fIOZ0h5CR9bUaD4qodBe6tlnT6uBYLRilVK1PWCp4P8nEz1rZkIri88HxjP1ck7YGQPEhrshnysUNQJFOOgQC1SwPX1vRbKB2IQocW2mGuurB8ZyZ2J1gUn+rhc5br+Nh8SCN7Cl6UOs4c/Ju7XtwVcL1Z9mYFCteV2kyx1ExnyqB+yXUmfUD201n6OYRK+pvZ6sn1SZCJtrgW53NlNugiSq18gFi5b/FXCN6WqK3lJT0utMPJIvoGWbM5PUoeuhKRn/YlgkEftPFvA7FOAMNHltLjNYpQDVQKZYdORY1VFTf0mC38/1v3csKjYuIP4cVxRtDVuE/eqnYvg82+p15w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by LV8PR11MB8560.namprd11.prod.outlook.com (2603:10b6:408:1e7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 12:30:00 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%2]) with mapi id 15.20.8901.021; Tue, 8 Jul 2025
 12:30:00 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>, Aluvala Sai Teja
	<aluvala.sai.teja@intel.com>
CC: "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, "Devegowda, Chandrashekar"
	<chandrashekar.devegowda@intel.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v1 2/2] Bluetooth: btintel_pcie: Fix alive context state
 handling
Thread-Topic: [PATCH v1 2/2] Bluetooth: btintel_pcie: Fix alive context state
 handling
Thread-Index: AQHb7u+FIJM3uUpiRUaJUhiWwfHCSrQmL0AAgAH5N9A=
Date: Tue, 8 Jul 2025 12:30:00 +0000
Message-ID: <PH0PR11MB7585A3C89449C58883012E23F54EA@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20250707034657.929092-1-kiran.k@intel.com>
 <20250707034657.929092-2-kiran.k@intel.com>
 <c670c490-04eb-4d5e-921e-e2645489e180@molgen.mpg.de>
In-Reply-To: <c670c490-04eb-4d5e-921e-e2645489e180@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|LV8PR11MB8560:EE_
x-ms-office365-filtering-correlation-id: 61e8073e-c7d6-4181-e148-08ddbe1b2877
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bkRmTDkxL3dncHgzcmFxR3Z3VExndmRuWUwwMXJqV3pwYWRUTWI2RkJTVW9P?=
 =?utf-8?B?Y0x6QW5YS0NKaDRqblArNzNoUmlKQkJoWHdDZHZ4eGQ2MlBaQ1RGUVJvS2FJ?=
 =?utf-8?B?VmE2TG41MDc2SktHTCtlWVp3QW1nSVh6YWZ0MXhlZ0lsbmppYmJiUXdMT2FQ?=
 =?utf-8?B?NnVGd09vQjlKa2wyZjkvekdMdEZYL2oyMC9OMlZMeC9Fbm5YOG44UG83Mjda?=
 =?utf-8?B?TkF4Wi9BZHZBUDFVUWdOdWlzRnVkZURDTDVHaXBiaGt2Q0RrMGIxU0ZLQVN5?=
 =?utf-8?B?UFU1Tzg0TndTL3hrRzFzbW56elJQTlVnYnJNY1dGL2RZM05ybG4rZGRaWEx2?=
 =?utf-8?B?SkkxbUk5c1JBMWFYR1htWlpIdUIzcVVyeU9nQ2drQU5HNEk4K3MyeFp6QXFC?=
 =?utf-8?B?TEhQcGFzQ1llaUxGc2NtTlhWaFRaOUx5L09xTlN2OCs0SXJ6bFZPNTl4TGVJ?=
 =?utf-8?B?dzZsdEIwYUp2YlpsbUcrcWxlV2lhc1dJalc3YWZJdHRLd0hmZXB0ZllOSUVm?=
 =?utf-8?B?MTV4M0w3Y2xmeFAvUExVbStiUDNkUXlZanc1Y0tWaFVKb1hzU0Z6WDJ3Vm1q?=
 =?utf-8?B?UVh0ZlcyYnd5MnVLZFlPcnJIdHFkMEJYMGl5UFRGOVZCNHNMdm0vS2d6MUpy?=
 =?utf-8?B?SjFET1ZnS0YrN1ZnNVR2cThsZ1R0aHVXcWNLeDRKZ1hWaHpHMUhpemp3N1dq?=
 =?utf-8?B?c21yeHBnOC83RFVSTUlzUEJpSkhwd2hsVkl3Zk5KZU0xS0h0alhxQ3A5YWU5?=
 =?utf-8?B?bm5kMjZ0ZFlVNW54ZHNsWGNaOEt6WWYwVTdrWjRuSEs4cXUvYkJhM1RsRWFJ?=
 =?utf-8?B?RUU4TnhCVkcxZkcyRXdKQ3hkOFN5TDM5cE1vY095ZWlKRVlCTFZsRUhTOXZy?=
 =?utf-8?B?ZXpJRGo5eXpzLzI2Z0tZT0RkcTVrRWlXejgxZ2IvT0xYVjJXeEUzQWkyeDBN?=
 =?utf-8?B?RkI4RjIreDY3aXZOd2N2UWJaalZBVVdTQWZEbStsVmdoWnBhaGJhVVVPajdn?=
 =?utf-8?B?U2hvdllYOXpTUDFaaEI2dzd0V3lNTWs4WUZRMTRwSGZuK2t1b1l6czRMY1cw?=
 =?utf-8?B?TDBPdDAweENsMjcyR0JaUzdCT1lRSlZTNDl4RUVrSXpUeHJMUFZlYjhXejhN?=
 =?utf-8?B?Qnh0VUhKQUZEWTRkemRTRHRTbnBaVFg2QXc1dVRDK3h4cGJFOUduRmJyY2ZT?=
 =?utf-8?B?OHpVVDV3UVUyc3RrY3ZqSCtRQWg3d3BQcWxaZDdPZThrRzhaRHR5Y2FOTWdP?=
 =?utf-8?B?eStDc3BZVXZMRHk3MGxZYjRJUUw3QmhpNFduYmdZTzR0N2xFMlc5WDBEM1Fv?=
 =?utf-8?B?Y2d2Tnl3RnpmMy81VlloTkRvSXNHZW1NTHFnTUduVHd4d09hWjY5dytWclNF?=
 =?utf-8?B?SVRFSG5qVG90TXZFdXV5bjhmVE4yamI3QUVaMW5Ld0tsMGFudUhSd1VERWJh?=
 =?utf-8?B?VHovelY1NmUrTlpCYTh1OUVDL0o3Wjd2eGY5bE4xd1R6Ylh2QVhLWmErYTFm?=
 =?utf-8?B?YmpadG9naXRvdTY5MHhUVkZ3RzhvV0RYc1orYlFyTzJXU1FRZm5CZ1hFWmRm?=
 =?utf-8?B?MEljUjB0cFJ3UXU4THJvNEVFaHU2Yk4raDZLakEvNXg5K3htaDY5RGtWbGJD?=
 =?utf-8?B?R3BMR2RMcUpOTVo4Q0ZiZE9FRTBra2VHUnV1TC9QdC9jQjJJQXRaUFNrMUwy?=
 =?utf-8?B?VzNqRWZReEZMWndVNzBvQXBtUXV2N2pBUVFvQlNFeFErZWZUYXd6Tm1qZ3Z3?=
 =?utf-8?B?NHJLS1ljcjU0Yi9qK1lSSUFGZFV1dER6YlhRL3BLWVV1eWMxZHlzWmVNeTVZ?=
 =?utf-8?B?a3VDa1kza2dnQ2hxWlFKNjQzNmNxRVhibWpjUDVCU1c3SFJWZlNoeVA4Q3N5?=
 =?utf-8?B?Y1Q1S3JIL1R1YUdBK2xKVlpiV0EwOHpGYzVpNzYxMXFsSkRHeDZXQ0V4SGlh?=
 =?utf-8?B?VHJMR1ptOTFyNTgzTmJwL051MSs5NExLTUp1ZkxBRDRXa3hvYWRzUDdoZVJQ?=
 =?utf-8?B?b1ZUOUVOS2N3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amRvTFBETjA4bFhRSU45LzRyc0RkWmN3NjdDV09DQmxCOWpYYmlraVY3eTls?=
 =?utf-8?B?c0p3SGZZTXFqeGpLSEh1L2JUeHNBbHNNVmVhTkNQZFgvVStjTDF1S1NWYTR2?=
 =?utf-8?B?SFlSZ0t5WVg1N3AvYndmR1lhaVZmdEhRcVdNaEx5a0lsMVNTOWozK204OWNT?=
 =?utf-8?B?azRjVnNNbmxDZUpoUGRLeFhEL01pcFhLTjF1L3FmRWI2SG8xY1J2VG8zcllV?=
 =?utf-8?B?Si9TWjVNVTkxMUtNMVBHaDQvT1JxOWl4RVVyYzVKME40dkJwTi92ZFNuSVY3?=
 =?utf-8?B?OTBnREttOTVySnhnRDhtYlB2RUpzeGJMbXAzSXd4eVZIWGQ0NlVWS1hSek5r?=
 =?utf-8?B?R2NnN0h5dGtORENPZFdJT0tDVC9mc0tNMjcxR1dEZEVPWGxScFQ5ZGhyUlNC?=
 =?utf-8?B?Y1IvUkxrck10WnNxVDE4Tk1HYjZQQTkzUkxBS1MvZUNGeW1nK2srdmtSL0h3?=
 =?utf-8?B?WS92UWdJUEFteUpZTHpiNE55a0VLdGwvNG9CSnE2ZWRjajNEaGpFZFlsdHlI?=
 =?utf-8?B?U3ZoQ2l4RlQ3c2VLTG81VUFCWkdwTnRBS21PVjh3d0haWnpaZFhEVXVMZjJa?=
 =?utf-8?B?amVaSG5VRVR4ZE9yR25ueDVJaGhqdGV2Q1J3ZXdTT3hVbUlqcU85NXFYTmN2?=
 =?utf-8?B?dWxXaFFKUThGdEs0Wk1oWXB6Vko5V284c2YxdHVpNjRiMk5hcGFRZ1d1a1Jz?=
 =?utf-8?B?YVBoQkFhNU1SWDdxS3lpZFU3bVFScEdpam1Ham1aMTBNcllESkdKV2hJWk4r?=
 =?utf-8?B?cjJBcEltS29xd2k5cmIwWkZWMHU4dnA1Qk8wZEV5ZmdaRmFIYWJXemxnb3B0?=
 =?utf-8?B?U0RNR3FQTytFbFN3WURiUmZLdkVTejB5RTJKOXZwbkIyZjNqYXFZNUNEYTR4?=
 =?utf-8?B?L2EwMnVGNi9PS05ZdnBDMGlRdW1yTEdTMzAwSUJweGh1YjAyelIzTUIxVWgv?=
 =?utf-8?B?WHFOQU9RRFdjdEhJR0ttbjhWYy90ajZyVnI2YVpoZ2cvMXVVRW1LdE1wTjVB?=
 =?utf-8?B?RThSUlNHUnZKakJFeU14Y2lVMHZoWWVwKzhKOW10bzRQQUkyd3pWWHdFYy9N?=
 =?utf-8?B?TWJoUElWM1lyMkdEWlR2Sy80YmFxTW9FeHFLOVhhRjBkZE1XQ21XdGRHS3Fx?=
 =?utf-8?B?aFFuVzZZRFR4QjRzaUI3R1NvUVdHbGlrdk9pdGdQUkZQUnhIYjJGekNUSUg4?=
 =?utf-8?B?T0QxV2NBc0JUakY4WDdWVGdqYzNacVJJL3QrUWE0MmxvbXE0LzcrMXp6Z0tH?=
 =?utf-8?B?Y2IrWm5OY3pMZzI1M3N4T2Rhako0azVIZDBTMU1zSlYzNDV3T2NIQ013MFNj?=
 =?utf-8?B?SEc4V0ZiallKcFJhQVRDZEJjeWFSUzlnSDZPMi8vVHptNFNRRHJQeU83RFVJ?=
 =?utf-8?B?QjYzdldMSHcyVWxEcmVndTBPSGI3cEwrNzB6YjlHeEszQ1MwN3hUeDNzS2RK?=
 =?utf-8?B?dnU3S3M5Z1p2SHk0MTFpMlBmWHZNTlFKRC84bUpYYTNjYUZlc25xRmNSdUpj?=
 =?utf-8?B?QmZaMzNSSWM4aEJLd01kNCtYVFRES2JpZXZIQXFJTVZoR0dTb25PR3l1ZUZP?=
 =?utf-8?B?Smh4YUxnRitxK1dQMWwxOFI1RktLVm1JZ2FxUXVudVVvTU5lYzJQajdubnND?=
 =?utf-8?B?TFlzR29lUloyMGNPR1MwRVNzbDMvOU1ndjNGcU5lcEZ2YmQ1Mzk1TEM2MUtm?=
 =?utf-8?B?M3o5Zk1yRHFqd1dOZjNJMTlGbXZiZ3IvVDlWcGorbGgydnhNY3FUMWxzYlp2?=
 =?utf-8?B?WmxGbFkzdUVZOHRtQjRPRHgwbTlBTld5LzZ2UWxPQ09mUDNkc3FjVmFNQTBQ?=
 =?utf-8?B?L0hha3hJcHBlb1V4N01GVXZ3L0VqTWZFcCtxY0c4MFVEQ2NYNlplR2FiNjlL?=
 =?utf-8?B?V0ExY2xMclZ3NXY1cG5BeUt5UWF2eHlmSkNIRjFENkwwYnB2eEtURkNXTk5S?=
 =?utf-8?B?MXZ3dUtGSXVWMUVuVE02STNNeFpaUElhMEJEOUtQSG9CRUR4eC9RSm14bTAy?=
 =?utf-8?B?UzJlUlF4TDlkYnJyM1BTL1pQVXRLQU12dVpwUm05Q1kvWHVObW1lQUJMazFT?=
 =?utf-8?B?T2JmVFV6MWFLeEZuaDU1bWtYNFRQa3lqZTFPT3U4SVJrbmU1cnJtUEVnTmZD?=
 =?utf-8?Q?HKZc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e8073e-c7d6-4181-e148-08ddbe1b2877
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 12:30:00.8323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1i0hbDQQ2Kr2XoQ5mCIeQQVeEqQFINozHp9LhD6WXVuOXty33s0SAIeVqiKQF97HzVe8O/WJgJqOJDfr0atR7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8560
X-OriginatorOrg: intel.com

SGkgUGF1bCwNCg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMi8yXSBCbHVldG9vdGg6IGJ0aW50
ZWxfcGNpZTogRml4IGFsaXZlIGNvbnRleHQgc3RhdGUNCj5oYW5kbGluZw0KPg0KPkRlYXIgS2ly
YW4sIGRlYXIgU2FpLA0KPg0KPg0KPlRoYW5rIHlvdSBmb3IgdGhlIHBhdGNoLg0KPg0KPkFtIDA3
LjA3LjI1IHVtIDA1OjQ2IHNjaHJpZWIgS2lyYW4gSzoNCj4+IEZpcm13YXJlIHJhaXNlcyBhbGl2
ZSBpbnRlcnJwdCBvbiBzZW5kaW5nIDB4ZmMwMSBjb21tYW5kLiBBbGl2ZQ0KPj4gY29udGV4dA0K
Pg0KPmludGVycip1KnB0DQo+DQo+KEkgd291bGQgaGF2ZSBob3BlZCwgdHdvIGRldmVsb3BlcnMg
d291bGQgc3BvdCBzdWNoIGEgdHlwbywgYSBzcGVsbCBjaGVja2VyDQo+YWxzbyBoaWdobGlnaHRz
LikNCg0KQWNrLiBVbmZvcnR1bmF0ZWx5ICAnaW50ZXJycHQnIHdhcyBtaXNzaW5nIGluIG15IGNv
ZGVzcGVsbCBkaWN0aW9uYXJ5LiBJIGhhdmUgdXBkYXRlZCB0aGUgc2FtZS4gVGhhbmtzLg0KPg0K
Pj4gbWFpbnRhaW5lZCBpbiBkcml2ZXIgbmVlZHMgdG8gYmUgdXBkYXRlZCBiZWZvcmUgc2VuZGlu
ZyAweGZjMDEgKEludGVsDQo+PiBSZXNldCkgb3IgMHgwM2MwIChIQ0kgUmVzZXQpIHRvIGF2b2lk
IHRoZSBwb3RlbnRpYWwgcmFjZSBjb25kaXRpb24NCj4+IHdoZXJlIHRoZSBjb250ZXh0IGlzIGFs
c28gdXBkYXRlZCBpbiB0aHJlYWRlZCBpcnEuDQo+DQo+RG8geW91IGhhdmUgYSByZXByb2R1Y2Vy
IGZvciB0aGUgaXNzdWU/DQpZZXMuIElzc3VlIHdhcyByZXByb2R1Y2VkIGluIHN0cmVzcyByZWJv
b3Qgc2NlbmFyaW8gYWx0aG91Z2ggcmVwcm9kdWN0aW9uIHJhdGUgaXMgbGVzcyAtIDEvMjUuIA0K
Pg0KPj4gU2lnbmVkLW9mZi1ieTogS2lyYW4gSyA8a2lyYW4ua0BpbnRlbC5jb20+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBTYWkgVGVqYSBBbHV2YWxhIDxhbHV2YWxhLnNhaS50ZWphQGludGVsLmNvbT4N
Cj4+IEZpeGVzOiAwNWMyMDBjOGYwMjkgKCJCbHVldG9vdGg6IGJ0aW50ZWxfcGNpZTogQWRkIGhh
bmRzaGFrZSBiZXR3ZWVuDQo+PiBkcml2ZXIgYW5kIGZpcm13YXJlIikNCj4NCj5J4oCZZCBhZGQg
dGhlIEZpeGVzIHRhZyBiZWZvcmUgdGhlIFNpZ25lZC1vZmYtYnkgbGluZXMuDQpBY2suDQoNCj4N
Cj4+IC0tLQ0KPj4gICBkcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuYyB8IDI1ICsrKysr
KysrKysrKysrLS0tLS0tLS0tLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMo
KyksIDExIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2JsdWV0b290
aC9idGludGVsX3BjaWUuYw0KPj4gYi9kcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuYw0K
Pj4gaW5kZXggZjg5M2FkNmZjODdhLi5kMjkxMDNiMTAyZTQgMTAwNjQ0DQo+PiAtLS0gYS9kcml2
ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuYw0KPj4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgv
YnRpbnRlbF9wY2llLmMNCj4+IEBAIC0xOTg4LDEwICsxOTg4LDYgQEAgc3RhdGljIGludCBidGlu
dGVsX3BjaWVfc2VuZF9mcmFtZShzdHJ1Y3QgaGNpX2Rldg0KPipoZGV2LA0KPj4gICAJCQkJYnRp
bnRlbF9wY2llX2luamVjdF9jbWRfY29tcGxldGUoaGRldiwNCj5vcGNvZGUpOw0KPj4gICAJCX0N
Cj4+DQo+PiAtCQkvKiBGaXJtd2FyZSByYWlzZXMgYWxpdmUgaW50ZXJydXB0IG9uIEhDSV9PUF9S
RVNFVCBvcg0KPjB4ZmMwMSovDQo+PiAtCQlpZiAob3Bjb2RlID09IEhDSV9PUF9SRVNFVCB8fCBv
cGNvZGUgPT0gMHhmYzAxKQ0KPj4gLQkJCWRhdGEtPmdwMF9yZWNlaXZlZCA9IGZhbHNlOw0KPj4g
LQ0KPj4gICAJCWhkZXYtPnN0YXQuY21kX3R4Kys7DQo+PiAgIAkJYnJlYWs7DQo+PiAgIAljYXNl
IEhDSV9BQ0xEQVRBX1BLVDoNCj4+IEBAIC0yMDEyLDYgKzIwMDgsMjAgQEAgc3RhdGljIGludCBi
dGludGVsX3BjaWVfc2VuZF9mcmFtZShzdHJ1Y3QgaGNpX2Rldg0KPipoZGV2LA0KPj4gICAJbWVt
Y3B5KHNrYl9wdXNoKHNrYiwgQlRJTlRFTF9QQ0lFX0hDSV9UWVBFX0xFTiksICZ0eXBlLA0KPj4g
ICAJICAgICAgIEJUSU5URUxfUENJRV9IQ0lfVFlQRV9MRU4pOw0KPj4NCj4+ICsJaWYgKHR5cGUg
PT0gQlRJTlRFTF9QQ0lFX0hDSV9DTURfUEtUKSB7DQo+PiArCQkvKiBGaXJtd2FyZSByYWlzZXMg
YWxpdmUgaW50ZXJydXB0IG9uIEhDSV9PUF9SRVNFVCBvcg0KPjB4ZmMwMSovDQo+PiArCQlpZiAo
b3Bjb2RlID09IEhDSV9PUF9SRVNFVCB8fCBvcGNvZGUgPT0gMHhmYzAxKSB7DQo+DQo+V2h5IG5v
dCBrZWVwIHRoZSBmb3JtIG9mIGp1c3Qgb25lIGlmIHN0YXRlbWVudCB3aXRoICYmIGluIHRoZSBj
b25kaXRpb24/DQo+YXMgYmVsb3c/DQo+DQo+PiArCQkJZGF0YS0+Z3AwX3JlY2VpdmVkID0gZmFs
c2U7DQo+PiArCQkJb2xkX2N0eHQgPSBkYXRhLT5hbGl2ZV9pbnRyX2N0eHQ7DQo+PiArCQkJZGF0
YS0+YWxpdmVfaW50cl9jdHh0ID0NCj4+ICsJCQkJKG9wY29kZSA9PSAweGZjMDEgPw0KPkJUSU5U
RUxfUENJRV9JTlRFTF9IQ0lfUkVTRVQxIDoNCj4+ICsJCQkJCUJUSU5URUxfUENJRV9IQ0lfUkVT
RVQpOw0KPj4gKwkJCWJ0X2Rldl9kYmcoZGF0YS0+aGRldiwgInNlbmRpbmcgY21kOiAweCU0LjR4
IGFsaXZlDQo+Y29udGV4dCBjaGFuZ2VkOiAlcyAgLT4gICVzIiwNCj4+ICsJCQkJICAgb3Bjb2Rl
LA0KPmJ0aW50ZWxfcGNpZV9hbGl2ZWN0eHRfc3RhdGUyc3RyKG9sZF9jdHh0KSwNCj4+ICsJCQkJ
ICAgYnRpbnRlbF9wY2llX2FsaXZlY3R4dF9zdGF0ZTJzdHIoZGF0YS0NCj4+YWxpdmVfaW50cl9j
dHh0KSk7DQo+PiArCQl9DQo+PiArCX0NCj4+ICsNCj4+ICAgCXJldCA9IGJ0aW50ZWxfcGNpZV9z
ZW5kX3N5bmMoZGF0YSwgc2tiKTsNCj4+ICAgCWlmIChyZXQpIHsNCj4+ICAgCQloZGV2LT5zdGF0
LmVycl90eCsrOw0KPj4gQEAgLTIwMjEsMTMgKzIwMzEsNiBAQCBzdGF0aWMgaW50IGJ0aW50ZWxf
cGNpZV9zZW5kX2ZyYW1lKHN0cnVjdA0KPj4gaGNpX2RldiAqaGRldiwNCj4+DQo+PiAgIAlpZiAo
dHlwZSA9PSBCVElOVEVMX1BDSUVfSENJX0NNRF9QS1QgJiYNCj4+ICAgCSAgICAob3Bjb2RlID09
IEhDSV9PUF9SRVNFVCB8fCBvcGNvZGUgPT0gMHhmYzAxKSkgew0KPj4gLQkJb2xkX2N0eHQgPSBk
YXRhLT5hbGl2ZV9pbnRyX2N0eHQ7DQo+PiAtCQlkYXRhLT5hbGl2ZV9pbnRyX2N0eHQgPQ0KPj4g
LQkJCShvcGNvZGUgPT0gMHhmYzAxID8gQlRJTlRFTF9QQ0lFX0lOVEVMX0hDSV9SRVNFVDENCj46
DQo+PiAtCQkJCUJUSU5URUxfUENJRV9IQ0lfUkVTRVQpOw0KPj4gLQkJYnRfZGV2X2RiZyhkYXRh
LT5oZGV2LCAic2VudCBjbWQ6IDB4JTQuNHggYWxpdmUgY29udGV4dA0KPmNoYW5nZWQ6ICVzICAt
PiAgJXMiLA0KPj4gLQkJCSAgIG9wY29kZSwgYnRpbnRlbF9wY2llX2FsaXZlY3R4dF9zdGF0ZTJz
dHIob2xkX2N0eHQpLA0KPj4gLQkJCSAgIGJ0aW50ZWxfcGNpZV9hbGl2ZWN0eHRfc3RhdGUyc3Ry
KGRhdGEtDQo+PmFsaXZlX2ludHJfY3R4dCkpOw0KPj4gICAJCXJldCA9IHdhaXRfZXZlbnRfdGlt
ZW91dChkYXRhLT5ncDBfd2FpdF9xLA0KPj4gICAJCQkJCSBkYXRhLT5ncDBfcmVjZWl2ZWQsDQo+
Pg0KPm1zZWNzX3RvX2ppZmZpZXMoQlRJTlRFTF9ERUZBVUxUX0lOVFJfVElNRU9VVF9NUykpOw0K
Pg0KPg0KPktpbmQgcmVnYXJkcywNCj4NCj5QYXVsDQoNClJlZ2FyZHMsDQpLaXJhbg0KDQo=
