Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C848C1B3925
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 04:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760588182; cv=fail; b=XKQOyO7Ow3d7asQ/Mc5pYejnx3VD6m6DoWtn67l2idJqrKfrwVnb+tVXOkdK2KICF/FqPqYUQOFPd1wETE4IiTFPVPOGPhsj/ARww2sYqD75/cqq46B4JSh7qIyx44XhNcIVcidA72EdXv8XoLfRzdVV64XirOWXxdUcVHYZcKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760588182; c=relaxed/simple;
	bh=tepAUoApngjaYgKMSq4YKSRCJtqdKgYZqBFB7HhbdWY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tklT7ngZWWzvNKVuxaHiZMkWzxn8cBq52KN1mZYUvUHXN2cJZyd4weVvPcRMjGnxjDvepF4ARE8d9dc3bVcmgFECaiJeG5cLOeQPrjq9ji9ENLdRWj21ze4ECW/0pnZHLct4NreXp0caVizud65YkWNYY5gxKuxS3eJafzgZ058=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fCnIUYV9; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fCnIUYV9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760588180; x=1792124180;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tepAUoApngjaYgKMSq4YKSRCJtqdKgYZqBFB7HhbdWY=;
  b=fCnIUYV9LrrmK53g5RhLqLBP6UT4QveJXlUo+RsReCOdT5ysoYhpqjVE
   cOQVy+F2g9eh72flTBdHoSjzbvCjTD+9TiRBE5b7mFndmt7r0SNpVieTd
   DQbM2VGgsRz2GFc5iH5HeucQHDT7ABWnZU1gD2Xaz/0riJ0Pj3c7xXCAY
   H1JaCfXoFkSTCUAXWA6iNo7c8vVaq7k5NwqbA85IrbkVnm1VMLJAig/Ge
   8JyZSVaXmXBaUUtFGsaXBRMXlJJLsyXKPdBbxZF1NGMqp3RNynV1tbk9E
   gk5brUf2HycrQ5dusUuylxu5Iq1CanakQAsIjdVBabepicNZtHq5QE8pm
   w==;
X-CSE-ConnectionGUID: v8HX4BPmTY6YVzKmxB5Kvg==
X-CSE-MsgGUID: cdKgKhMQSBm1CZYA9WNW4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="62865798"
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="62865798"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 21:16:19 -0700
X-CSE-ConnectionGUID: GiRXB02hR4SOBOmaGXTJrQ==
X-CSE-MsgGUID: cso5vA1PTkOxrbvk5L461w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="181560745"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 21:16:19 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 21:16:19 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 21:16:19 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.1) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 21:16:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IwcAv3c0k/BbmR3wj0CPh54R+bUS6AgDYv8E4PxXcEjQh0fwlGh37NKMLf8dXVMt1xw8v1FnMSfokf5nGam8Ovdw1fswxYfvsP2HtJSl5P0viZMJcLNdScvHdimAs9Traq+2xdguXP91ujTWMzawNsw7X1nONUxZvqAVMssSZJLvyh291ok61+NycKdv00bz+NrxxGWPCyT4t/VmdQIBu94pqxfT1Jmdmm3Q9jBtQ/YcuXMtT21mogl7h+expeVbXQyUu5yG+gAYDRLnQ9/XF1BWf5GQOzgNFQi5wgwofAAKM4isgtSIy077+hwvs6w1oXyFhOnMG2jeoQ0bW0I5/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tepAUoApngjaYgKMSq4YKSRCJtqdKgYZqBFB7HhbdWY=;
 b=dxBW22UFeNcaZPAodm5COV1unyL9l4c+4KNN6rN4GfqiHVMqLq7IsURKBxvuGABgr7lbuPMbr8pP+4NN3tzGh2UWxiGQnc85sQA5skD7if+AqZnEM/YugXp46XuZRERdc7IEzzDqzkN1oEi9CfLdekEVo2wZ8B9xWEPaVqlcqRX7skXGv04uOZ5ZAtMvG4Mo1SevW5k4bgBjLNwb4TC/mKjnK1u+FbPkxEGXWbY/uD2e5f0dFn0wdvhAu1t/FeeNPI4adqRN1uErDEql+IsuWAQuZhHi55Wf72R9uPDMb/HaEBSlfwVF+7UJxiWtAZx9jSIrMr4g27WjD9dLZQTiEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by PH7PR11MB6649.namprd11.prod.outlook.com (2603:10b6:510:1a7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.15; Thu, 16 Oct
 2025 04:16:15 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%3]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 04:16:15 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, Aluvala Sai Teja
	<aluvala.sai.teja@intel.com>
Subject: RE: [PATCH v1] Bluetooth: btintel_pcie: Fix event packet loss issue
Thread-Topic: [PATCH v1] Bluetooth: btintel_pcie: Fix event packet loss issue
Thread-Index: AQHcPbo8D25v4YapdkKuG70GAhZJZLTDqP8AgACCUEA=
Date: Thu, 16 Oct 2025 04:16:15 +0000
Message-ID: <PH0PR11MB7585F127C190083DE8149A07F5E9A@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20251015101436.2579377-1-kiran.k@intel.com>
 <c31398c7-4476-4e3e-b773-0143e53bd301@molgen.mpg.de>
In-Reply-To: <c31398c7-4476-4e3e-b773-0143e53bd301@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|PH7PR11MB6649:EE_
x-ms-office365-filtering-correlation-id: 2d18b62c-1e98-45e2-bfd7-08de0c6abf7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?SWxrcVR5aHJvZ0ZzOGRBTXEydmdzT0oyWmg3R002bHNac2pGTFZjMFlpeFVa?=
 =?utf-8?B?T29DZXNsZTh4RDZJaW1NR1I0UEFDVEZkc0dKSlVORzFsb1liaDYxYUVnR01r?=
 =?utf-8?B?eDBydXBYSHBhemlPRVl3TCs0ZUVjVmJMNG0zUlN2bk4xcVVYcXFJNjA1bXRN?=
 =?utf-8?B?WlljQXo2ZEU2L1hLeEFNNGJ3UHppSXphTkhVRlJIQ2VaWE1VMzQ0QjdvakRn?=
 =?utf-8?B?dDhJVE1FVU1DNTI5OE9IclFOcDVOTzVaMWhYTXdlL1I4bThaVWU5MUNKc0pa?=
 =?utf-8?B?bmVjSGs4VWExT1NDdHpkTGJreDB4VEJwN0ErMjZFTFdzcGl2UjJvQXduaVFV?=
 =?utf-8?B?U0VRVmtiNzl0MjJCUlJJZkhiUi93SUNtUXZKVUozVUFRcnpVNWhqM3JpU3VD?=
 =?utf-8?B?dm96RE84cmttUDk5bHdiUTJ3R3orRGxlUDdQVVZHTXJMd0NxMmhBQldqTjg0?=
 =?utf-8?B?N29UZE9OYzBrcG5xY0RDMnBJV282Q2NYS0pXYitGUVZhZS9oOW9qR2QwZnBr?=
 =?utf-8?B?QkduQWozd1h3NHlkUE93ZkVlNG9ZT2p1ZFlWMCtqUmlpNVUwSndzWVZOZWpI?=
 =?utf-8?B?SmovaXBpTDMwZEJIdlIwdGhLOFltaGtURCt5MTRmY0lrN2w4bXlyMHZsYWcy?=
 =?utf-8?B?Q3EycjFKdTJiVC9IdEZ3d0d0L2tmRGFlTHFOL1FmcmVFKzdQVnUwTEZxcVY0?=
 =?utf-8?B?MjkxekxFRGlHRlFhSlprQUFDWi9DMEswa2YzSGtnS0JGcGpnck82emZheWpy?=
 =?utf-8?B?clJuUFdhcHF4cmx0aGNVQW1LWjBHeWt3MzdGdytiS1dRQ014d3RMVHhnSDZG?=
 =?utf-8?B?RjE4UmJaMXJvNFRoY09pbFVHUGc4clgxVER1L0daMjh6bktmWWtvQU12MUFy?=
 =?utf-8?B?cFNFNGhJVFV5YU5uN2tKWEdUMXl5K21QZThRbkZxNjYrOEVNSzR5bVlId0Rw?=
 =?utf-8?B?SGZJWEljNWNOOXJmS1cwTUZlSFp6UlRCTXZlTHF1S0xkRmxCZ1hRdzNxNUcv?=
 =?utf-8?B?OHRvQzNZMmdmelhjTXdBUURCa3VUd2kzbXRqQUh6SHVUYlBrQ0ROMWpNQnlN?=
 =?utf-8?B?NCs2SkVJc09XSUxTci9kK21yRUJtVnNsT3NlOTV6SVhHU1Bxelc0TEpCT1VT?=
 =?utf-8?B?cEZHeXpydDF5b1B2U0tBMWhBVWlCZzl3UG5CWlVNeFhBYlJtNmFsUk43MmRS?=
 =?utf-8?B?Qm40MjV2VWFIWk55NmxQd0pMOHZVVXNpT2J5MDJta1VoczUrcDlQZFdUZ2c3?=
 =?utf-8?B?Uk9JRnZDMm5za2lQUDFwRm0zOEx6U2ZjaXZpZG5ReGFheDBIU2NoYXNYZlZF?=
 =?utf-8?B?NG1MdVY0b1hGazFpcm5mbDVFK3dXZ05EaERrckxUaTUzVlp2ck5sd1dQRTVM?=
 =?utf-8?B?OForb0NwSnJ3ZHZ6UTZXTXZ5QUdOZlNzK2N3aFNwa1E5bzRzSjVOeUpFSUkz?=
 =?utf-8?B?WUFtbXM4T3VTdENRNFdXR1MyYTdNM3JiWlJkdm8wcElpOEdzclREVnpOQlc4?=
 =?utf-8?B?bjQveXdjTDRmMVJWUm9FNGU4S2d6dmdQMXM3UUc5UVNRc0p1YzhGcHRkeWQv?=
 =?utf-8?B?WEJIUmlNSTNGYTZPWDNxYzVVWXc1OUpKVmdJeVR2RHdCQWhXS0hSK3NTdU1P?=
 =?utf-8?B?cFQyVFFRaDlrZWhLRjJPTTRNdlo5ZUg0Uk5VKzVjK3lhR0plYWpTZTVnQXdL?=
 =?utf-8?B?TlptZWU0RlBzN3YxT1N6aC9VZ2NLYXVNd0VrQUsyUmJJcHZXanQwdlBUbXRP?=
 =?utf-8?B?d0YzV1hySGpnZE9NVG8veDh1WVZDdUhIRm5NR1BxS2hhWnZpOTExdFZNK2RR?=
 =?utf-8?B?RktjcHNpdHlmRnBwaXg4UXFOWFh2V3dGVjNPb2w4dEFXbE91UkJBM1Z0ZzV4?=
 =?utf-8?B?TDQrMmZTMmlVOVJqaTYzN1hrRWg4ZDlYaVI3YVcrM3RIL0dZa3lGMEh4WTMr?=
 =?utf-8?B?V1FWYXVFNXM5UW4vNmc0bEMySFR2MXR0L2dvMU0vV0s1eDlLYnRwSHROd3Nj?=
 =?utf-8?B?aGhVVXJwRm9HOGJsWWRrTk96TG1NbjEzbDNJV0syVjB6RzZvUWJRRWhoZ05s?=
 =?utf-8?Q?OawMp0?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXBaQTR6amMzVWFqZnd5R2c5amNPTE5Tb2hQQVFsOGI4REpJbkpobkxXa21Q?=
 =?utf-8?B?ck9rclFTQmVMY2U2WHlsanNIZEo3ZE54N3l2VnRDbXVFaUhrbXBlU1oxZ0w0?=
 =?utf-8?B?WDF4NjNKNVRtMlM0b1d2K20zSTd2VDU3MFdTK3ZMMmovZGt1RzQ0VzkwY2Y1?=
 =?utf-8?B?ODhNVlNHWGRQN3hKNXFnUDlROHNCcVRZUTlFUFdhSGhORmlVQWZvV3VKUlZX?=
 =?utf-8?B?MytENHY2eml0bFNkb0huMFc5eUovZFpqTzB2eTlwQ09qaFVGVDUvdFptSjF4?=
 =?utf-8?B?SG5OUHJ4cFFtVGNIVGJpczlxSXJXaXdPdUF3WFc0V3pyOC9YMmg1Z1RDRTdL?=
 =?utf-8?B?eHpRUDBnZ005ZDQycDZZMi90S1FSc2tJNTk4QW5yRG1vVFQ5alViM1l6d0M4?=
 =?utf-8?B?eC9yZXBGTVhaS2VvQWNOZVFtdUs3cmM5VmQ3ZnZNWHdxZGlYcU5KaFVsd1k0?=
 =?utf-8?B?RExLK1ZQK1NHaGhtZUo2L3ZVcXBjRGZLQkt2NEc4Z3hnRGhabkpzQkF3UG1Y?=
 =?utf-8?B?SW45YzY2bEpZeXBOM1A1MFBWOS9qUk5DRmlQYjRUZUFGRzdZN0JPdzYweTJV?=
 =?utf-8?B?NlAwWUVwMnpCeTRqV3R2Si9uSDRQU253VW9vZFBHYWxWb0ZCb0lJazczbU5k?=
 =?utf-8?B?ZlBNT2lnOGlLTzZGRE96NXhaZS9PYjZxR213MGdWR3FxMHZMN2p4RU5FYTAz?=
 =?utf-8?B?WUNhMTU4VzVwWVVzamxpZEJDUkwxR0xreDFRb21TY1VidWVENXNrcXNlOW02?=
 =?utf-8?B?WTJMRHBxUkd3RWFaY1RkOVpnVEM2M2FsU0k4WFcyeWtvaDFPUmhReWNnUlhM?=
 =?utf-8?B?L0RCaWhld21tTERkY2VjekJLMlU2T1F4am1IaUJPVE9VYUxhQi9IQlpnQitL?=
 =?utf-8?B?UVQ0dFE0Y3ZrVUx0dXlDUU9WSlVaNkxKZjJ3eDl6d1JKTGo5Wm5aNGNqeGI5?=
 =?utf-8?B?UE9FbGFNYVRLdXBpOGRrZWh5WmpUazY1VGowUWxQUTlUZ1BHSnhKSGdxWjA5?=
 =?utf-8?B?bVVSbmRPUHNHWERvZGs4bGFkOFEySHEzWWJ5Q3FScnNjNmMwRFlxckJaL0ZP?=
 =?utf-8?B?SXVlVWpmeDJ5cUlGeG9ad3hpZzlBc0ptOTQ3NFRVblhTUkVnNG1lTHJtRkpM?=
 =?utf-8?B?NzI0WEo4RnZGb3l5a2ZQZitkR3dDVlhuNE9NdlpnYjNRZHA1NHM1YTFmTzIz?=
 =?utf-8?B?MitoY1BhWTJid1ZyMG9FUHIvS3cxQXBVaWJsaDBVQmFBZFZMRWtrZjdqWjZi?=
 =?utf-8?B?OExOa2Y5YUR2QVZMd0FKUkxZaXVoOS8wQnNpOWF5Nkt5NEVraXlLMTIxdUFn?=
 =?utf-8?B?c1pCMW90NDBXWkZkV2JLNHZXcTVrSlAzM1ZpeGRRVlJGY2N6dkR5ZHdxSjJD?=
 =?utf-8?B?NWE1cXZ6d1dlWjlhU3U0RnVmcmtzNzRiMFg2a1A5Y2xkZk1FUmlRWGpsYlBn?=
 =?utf-8?B?bkxaM3htaG1NWm5lZlRwVWczOTBaUk5wb1Jwc0FyYVhqb3pHdDFhTU5BVmVZ?=
 =?utf-8?B?RnJSU0o0ME5xTFgxSlZBTkhOb1lvRStjT3FZVUFiS09ZNjJzUnIrbnIvMlRU?=
 =?utf-8?B?NlZNbmd5NERoclFZbVR4WllFYUdWdzY1d2RDTWFNTEFndzJNV0dRZFF3R0lu?=
 =?utf-8?B?eDlNR05CNGlabG1oK2dmRDQzRStEVWE1VS8zc3pSbTJDc2Q5MUN2MDFRaDhj?=
 =?utf-8?B?Z2RpNW5ycjR6cXRhc0ZNbTZFc3dSeGMzakl6bmkyTnBqUUtYNElITi9QMEhS?=
 =?utf-8?B?SlNRRTUyeGM2WGszNTRCWkxwM1pQVDRBWTVmQ05zbG5FcmxUQjRCUS9oUUN5?=
 =?utf-8?B?Q2E4SVh0OXNmTFBEdjhFQ04reXVxci9WRkNqZG1yamg5MWpLZ0puWHBBMCt3?=
 =?utf-8?B?R2JUYlowWktqU0xsQjUxMS9YNG1xa1JvMmJwelVsN0gvVU1CemIwQlNndEV0?=
 =?utf-8?B?dUlFaGg1R0o2bVF6NmlBR1hHelF1VGhjV2YrVTJ0UGVtNStJUHhFNEZQNjdW?=
 =?utf-8?B?VW1kN0dmV05KcCsxVU1jMjEvUnhHampvNVVrVHArUDZqSmhkZVJKYjRoZHZh?=
 =?utf-8?B?ckMwYVNVWDBxbWhDN3VETWE1ZEFjeFlrQkJEUVFhb3RMbU1XNlJ3N3NBSFlU?=
 =?utf-8?Q?HhlQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d18b62c-1e98-45e2-bfd7-08de0c6abf7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 04:16:15.1673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qu6tk3wbdUlWd0euC/Q/INfLhI1r1uMlXlI5Eom1IZDxOF5DWWP0WoidMj5/+wmvT+iqPpkajp46+CQuRdlPrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6649
X-OriginatorOrg: intel.com

SGkgUGF1bCwNCg0KVGhhbmtzIGZvciB0aGUgY29tbWVudHMuDQoNCj5TdWJqZWN0OiBSZTogW1BB
VENIIHYxXSBCbHVldG9vdGg6IGJ0aW50ZWxfcGNpZTogRml4IGV2ZW50IHBhY2tldCBsb3NzIGlz
c3VlDQo+DQo+RGVhciBLaXJhbiwNCj4NCj4NCj5UaGFuayB5b3UgZm9yIHRoZSBwYXRjaC4NCj4N
Cj5BbSAxNS4xMC4yNSB1bSAxMjoxNCBzY2hyaWViIEtpcmFuIEs6DQo+PiBJbiB0aGUgY3VycmVu
dCBidGludGVsX3BjaWUgZHJpdmVyIGltcGxlbWVudGF0aW9uLCB3aGVuIGFuIGludGVycnVwdA0K
Pj4gaXMgcmVjZWl2ZWQsIHRoZSBkcml2ZXIgY2hlY2tzIGZvciB0aGUgYWxpdmUgY2F1c2UgYmVm
b3JlIHRoZSBUWC9SWCBjYXVzZS4NCj4+IEhhbmRsaW5nIHRoZSBhbGl2ZSBjYXVzZSBpbnZvbHZl
cyByZXNldHRpbmcgdGhlIFRYL1JYIHF1ZXVlIGluZGljZXMuDQo+PiBUaGlzIGZsb3cgd29ya3Mg
Y29ycmVjdGx5IHdoZW4gdGhlIGNhdXNlcyBhcmUgbXV0dWFsbHkgZXhjbHVzaXZlLg0KPj4gSG93
ZXZlciwgaWYgYm90aCBjYXVzZSBiaXRzIGFyZSBzZXQgc2ltdWx0YW5lb3VzbHksIHRoZSBhbGl2
ZSBjYXVzZQ0KPj4gcmVzZXRzIHRoZSBxdWV1ZSBpbmRpY2VzLCByZXN1bHRpbmcgaW4gYW4gZXZl
bnQgcGFja2V0IGRyb3AgYW5kIGENCj4+IGNvbW1hbmQgdGltZW91dC4gVG8gZml4IHRoaXMgaXNz
dWUsIHRoZSBkcml2ZXIgaXMgbW9kaWZpZWQgdG8gaGFuZGxlDQo+PiBhbGwgb3RoZXIgY2F1c2Vz
IGJlZm9yZSBjaGVja2luZyBmb3IgdGhlIGFsaXZlIGNhdXNlLg0KPg0KPlBsZWFzZSBzaGFyZSBh
IHRlc3QgY2FzZS4NCkkgaGF2ZSB1cGRhdGVkIHRoZSBjb21taXQgbWVzc2FnZSB3aXRoIHRlc3Qg
Y2FzZSBkZXRhaWxzIGFuZCBwdWJsaXNoZWQgdjIgdmVyc2lvbi4NCj4NCj4+IFNpZ25lZC1vZmYt
Ynk6IEtpcmFuIEsgPGtpcmFuLmtAaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogU2FpIFRl
amEgQWx1dmFsYSA8YWx1dmFsYS5zYWkudGVqYUBpbnRlbC5jb20+DQo+PiBGaXhlczogYzJiNjM2
YjNmNzg4ICgiQmx1ZXRvb3RoOiBidGludGVsX3BjaWU6IEFkZCBzdXBwb3J0IGZvciBQQ0llDQo+
PiB0cmFuc3BvcnQiKQ0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNp
ZS5jIHwgMTEgKysrKysrLS0tLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygr
KSwgNSBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibHVldG9vdGgv
YnRpbnRlbF9wY2llLmMNCj4+IGIvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmMNCj4+
IGluZGV4IDZkMzk2M2JkNTZhOS4uYTA3NWQ4ZWM0Njc3IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVy
cy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmMNCj4+ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0
aW50ZWxfcGNpZS5jDQo+PiBAQCAtMTQ2NywxMSArMTQ2Nyw2IEBAIHN0YXRpYyBpcnFyZXR1cm5f
dA0KPmJ0aW50ZWxfcGNpZV9pcnFfbXNpeF9oYW5kbGVyKGludCBpcnEsIHZvaWQgKmRldl9pZCkN
Cj4+ICAgCWlmIChpbnRyX2h3ICYgQlRJTlRFTF9QQ0lFX01TSVhfSFdfSU5UX0NBVVNFU19HUDEp
DQo+PiAgIAkJYnRpbnRlbF9wY2llX21zaXhfZ3AxX2hhbmRsZXIoZGF0YSk7DQo+Pg0KPj4gLQkv
KiBUaGlzIGludGVycnVwdCBpcyB0cmlnZ2VyZWQgYnkgdGhlIGZpcm13YXJlIGFmdGVyIHVwZGF0
aW5nDQo+PiAtCSAqIGJvb3Rfc3RhZ2UgcmVnaXN0ZXIgYW5kIGltYWdlX3Jlc3BvbnNlIHJlZ2lz
dGVyDQo+PiAtCSAqLw0KPj4gLQlpZiAoaW50cl9odyAmIEJUSU5URUxfUENJRV9NU0lYX0hXX0lO
VF9DQVVTRVNfR1AwKQ0KPj4gLQkJYnRpbnRlbF9wY2llX21zaXhfZ3AwX2hhbmRsZXIoZGF0YSk7
DQo+Pg0KPj4gICAJLyogRm9yIFRYICovDQo+PiAgIAlpZiAoaW50cl9maCAmIEJUSU5URUxfUENJ
RV9NU0lYX0ZIX0lOVF9DQVVTRVNfMCkgeyBAQCAtMTQ4Nyw2DQo+PiArMTQ4MiwxMiBAQCBzdGF0
aWMgaXJxcmV0dXJuX3QgYnRpbnRlbF9wY2llX2lycV9tc2l4X2hhbmRsZXIoaW50IGlycSwgdm9p
ZA0KPipkZXZfaWQpDQo+PiAgIAkJCWJ0aW50ZWxfcGNpZV9tc2l4X3R4X2hhbmRsZShkYXRhKTsN
Cj4+ICAgCX0NCj4+DQo+PiArCS8qIFRoaXMgaW50ZXJydXB0IGlzIHRyaWdnZXJlZCBieSB0aGUg
ZmlybXdhcmUgYWZ0ZXIgdXBkYXRpbmcNCj4+ICsJICogYm9vdF9zdGFnZSByZWdpc3RlciBhbmQg
aW1hZ2VfcmVzcG9uc2UgcmVnaXN0ZXINCj4+ICsJICovDQo+PiArCWlmIChpbnRyX2h3ICYgQlRJ
TlRFTF9QQ0lFX01TSVhfSFdfSU5UX0NBVVNFU19HUDApDQo+PiArCQlidGludGVsX3BjaWVfbXNp
eF9ncDBfaGFuZGxlcihkYXRhKTsNCj4+ICsNCj4+ICAgCS8qDQo+PiAgIAkgKiBCZWZvcmUgc2Vu
ZGluZyB0aGUgaW50ZXJydXB0IHRoZSBIVyBkaXNhYmxlcyBpdCB0byBwcmV2ZW50IGEgbmVzdGVk
DQo+PiAgIAkgKiBpbnRlcnJ1cHQuIFRoaXMgaXMgZG9uZSBieSB3cml0aW5nIDEgdG8gdGhlIGNv
cnJlc3BvbmRpbmcgYml0IGluDQo+DQo+VGhlIGRpZmYgbG9va3MgZ29vZC4NCj4NCj5SZXZpZXdl
ZC1ieTogUGF1bCBNZW56ZWwgPHBtZW56ZWxAbW9sZ2VuLm1wZy5kZT4NCkFjaw0KDQo+DQo+DQo+
S2luZCByZWdhcmRzLA0KPg0KPlBhdWwNCg0KUmVnYXJkcywNCktpcmFuDQoNCg==
