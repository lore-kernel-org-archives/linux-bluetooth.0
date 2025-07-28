Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81407483
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jul 2025 08:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691649; cv=fail; b=Yv+D2rTOxu25ljb3ENluhKf9kwWynU/ZPmEioSIrseuv7yewZL9DLP30Zeh5iTHIATB4FHYHkQZ21jz3e0oIvDB9FSHUt3DVCahxpfDErASNtPgZWI+nMVRuLS7TyO1bnMyad7aig1yqDXLt2a9pBPECRlBR7p8lFXMqV4rtXoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691649; c=relaxed/simple;
	bh=4slTRUy2T6IEdzW2M/RpRPyFxao2bnWZ2D9ZCkyS4EE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p5sCbA1weDq+CB8BbATPpRz6dsxidBq4CnM/Tq4H9hcQFHp/ifipmpA551xdVtU64ro6s1MfYtoUyvjUWcXcfx71LlJlHnPc8vE2zeuWrUTOYaY+91YSpYzEh82X6lyl4g6kXcrk+Gf/X4biCPno4Dk0q+u+NPg5pOJ5s4ekgkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E1XM7bSk; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E1XM7bSk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753691648; x=1785227648;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4slTRUy2T6IEdzW2M/RpRPyFxao2bnWZ2D9ZCkyS4EE=;
  b=E1XM7bSkDVE1g9nM/VZ0YcYPFttB2kT51Mscw097p7OAvCuwDg/VRZp8
   magGRaXmoUGmfOIStjOr/IlOoZiTHmIW4EMn2GyQ23XqmDGs78IMgNCbB
   1rQiZJSkm6qQiVwCZlsR7/dfg4mO2Qx/Aa2glOH3RmdeeVeWPKiKWHj9I
   Sd/JF1dyfaP6lkA9dhQFSRnc85B65y54j7ByWVQxdVpEM6grUDI2SsM6y
   09vgGJCqBKXJjYFRh6B/7ln2F7hqZfOHZWgWcZjYWys3Fd7htO636TKx8
   9RuKDBCDmE9Vbs9NNjW/EjOQb67yIgYd0J/qKiBharABVk7HN/DXVlJn0
   w==;
X-CSE-ConnectionGUID: 8m8ouu9AR3iZQGS5FbODAw==
X-CSE-MsgGUID: AwruBWV9R+GB2vbTHY/hRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="55632048"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="55632048"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 01:34:07 -0700
X-CSE-ConnectionGUID: UwM9+tbOSPCjWMnI6Pbbuw==
X-CSE-MsgGUID: dPr+7M3bR0+h+XP0cuR7kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="166534125"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 01:34:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 01:34:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 28 Jul 2025 01:34:06 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.87) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 01:34:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pATC9uR4CyvZ9O75UDYBlPjgYk6tWOVrGMzAKEzzm+ZUM4VaHhVHqYhQUi9Jz6VJ7I8LULaflgnZ3svV6m+kFTLBzzq4soUoIPFzLgceSfSUi7Y71QAVhenrukXxSLmH0cdxtLIwo0c3eSAOSZmI/l7PEKTUn54I7RZ5Aet+v6SsdjdfQfCW728PfCwhlF6qGKFflBTE6S4E3nfvorcJ3lY48EP0bcBQycmARO6aFF1Ea8me3zGBBVCNnM3FXOG0GOeHAUuHbMn1XNCsPDigY6wbS9HEMO3C5WOG4365Qv09pzDlmOchgAEOnwqxG1Mox1YrH/QiKmYn/TBUKrtzPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4slTRUy2T6IEdzW2M/RpRPyFxao2bnWZ2D9ZCkyS4EE=;
 b=RiMZAeIKfgW/FWD52WV12usWLNXN7cZxnyEGvmFxA/4h+u5bj2MpkKrlX43jUxgCwN4BLwxqtW3zu9Q3LGu0enrPvlM3+RjH4Fvo9+rDoB262DEVpY2B2A0UxF/Mu5kUwCUO6RWLUTCVy6OkcJ6iP9gACIsRmzEQInNbjv/WTL6MSMkLc70wsYYd04MsRXpfLVIWZkAvOuplDBG83RN19Ttr7J068bSJd49bClGDuEG9dpHBmxDe0IogJ5Y0W7p6aM7fclxpRM6o2psYos2cDIkec7VoThrLhJZ4kgDck+1NX8Gx5WCJDb1HVuVLqw0gYiBCKHQ5+3K4kfUwCfHUiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by DS0PR11MB8071.namprd11.prod.outlook.com (2603:10b6:8:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 08:33:21 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%2]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 08:33:21 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Devegowda,
 Chandrashekar" <chandrashekar.devegowda@intel.com>
Subject: RE: [PATCH v1 1/2] Bluetooth: btintel_pcie: Add Bluetooth core and
 platform details
Thread-Topic: [PATCH v1 1/2] Bluetooth: btintel_pcie: Add Bluetooth core and
 platform details
Thread-Index: AQHb/RJV1STY0NG+NEqLXVkziJbhtbRC12iAgARiwxA=
Date: Mon, 28 Jul 2025 08:33:21 +0000
Message-ID: <PH0PR11MB758573ADA691CC0DC545A7D4F55AA@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20250725033134.1351301-1-kiran.k@intel.com>
 <e3fa9472-4707-4eea-b19c-de2e939c44f3@molgen.mpg.de>
In-Reply-To: <e3fa9472-4707-4eea-b19c-de2e939c44f3@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|DS0PR11MB8071:EE_
x-ms-office365-filtering-correlation-id: 13a1bff8-98b4-4d8d-b350-08ddcdb16923
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VVZBR3VPN1JCUjRGelpUbnhZYXJTZFU3cENTVVI1WnpSYmw3Qlg2SFdncklw?=
 =?utf-8?B?ZUhWaG1FNDVEWjdTQ3dEbzU1OHhtQVM5WndGQ1pXb0VCemZZVjBNaXkxbVYx?=
 =?utf-8?B?N0lYTzgxUGhoZmVIazZraVdYdVVZUkRQNVhpcWF6SjAvUFRtVEIyb0xvNklI?=
 =?utf-8?B?OW4xTkx1VTJ2QUdISmIwNjliN3EydW5ZZlNpK1Y4VlFpQzdqQ1RnaGhUZnln?=
 =?utf-8?B?SnVKZ3MyS0VaeVJyZlFjbVQ3bzdONGd4ekhMZ3dIVk5IUkt4QWVBUnJCWnZn?=
 =?utf-8?B?UXYwN0taOWNwejg3WGFjWVJsZWpoRkIzZE1CQW54NjE1a21tNnp6a0pJV2lX?=
 =?utf-8?B?ZDUzYXdCTDh1Z1ZSYTgvSVM5cUN4YnI2Ym03MjZmS0pOdm5SemNiRWNaNndt?=
 =?utf-8?B?L29leUxmSmlaeXlmRW5SajNKejFJempaNmZVK05POXBQYnRrTHJiWWN1N255?=
 =?utf-8?B?Qmk1RjZZdVFuSHRjcEJLLzlhQlFqM1RVUHZXY1ZNUiszNCtuMGh0MEpiekth?=
 =?utf-8?B?U0F2K0pWOEVTTk91dk8xRmkxbWZXMGpzNTFRTjBVQ3M2UnF3OUNSRVY3a0pS?=
 =?utf-8?B?ZSt5N3E1Q0dJenNMWVBQNHV1TkFBM2lSOWM5ZHV3R3hwRWxWVGdDb2RyOGRF?=
 =?utf-8?B?RGkvdWdFWmZJYUpnSE1nR29nM1B1QVR0SFJISnpvbE05emJuczc4TGtQQ2RV?=
 =?utf-8?B?ZEc0SDR1RHloQU9yb1hFaXhKN1lFQ1NEMDhPM2JXelNDY2REUmJ6VmZOMGpy?=
 =?utf-8?B?SFFhQXU0TEVvUHp2OXVMc09FU3BHOHZOaUV6M1VYbmk2UmlUZWh1OXVEbUJs?=
 =?utf-8?B?bkFtaEdGb2dhZlU5alozM1ZwelF6bTFiN3JDaWIwVEdaWDVZSE52Q3pTMmNM?=
 =?utf-8?B?d2I4UWdvd1gzMDJCQ0Nhdm9PTlRsOGtHcGwwZGtPdHBoVUpHcmhqYm5KUWIv?=
 =?utf-8?B?OUJTVFRXWGRxS25Lekk0bUVTNXllN0lXTkFwY0RpNkJHYXVHNzg4VmFYMjND?=
 =?utf-8?B?Y1JOVk1GVi8xY2o0U1hadURqMDRiTnVnSlZOSFBrVGdYTWlxa1lVOW5hUFFl?=
 =?utf-8?B?SnRQUzdxNE5hT3hKaTRyN3dXOCtsTUdIK3NIbTVYSjRWbnRDMjBEc3BMNVJh?=
 =?utf-8?B?cVZsNldSSXNWcGMzZ1VCNGs0b3hqYU9tOXRJYkFsTnBXOGpncDRvSURXT0d1?=
 =?utf-8?B?YlgrNHNPVTB0N3ViQU9Nc2hEYVdFdUdrQkQwNmtTNkdnaWhMZlE3MlBvdk9V?=
 =?utf-8?B?V3pXTFlveWRJT0hwalI5SFFGOWltQlQrUE1iQ3c4dnRjbDVJaWVVNTZIQnRy?=
 =?utf-8?B?VmdGbWt3NTdGRTBmSnFaWi8wMDVaUHk1Z2w2UjlqOXFlMDJFT2lWRXFPWjhk?=
 =?utf-8?B?UVBYRG9RZUgzN1VQenorSlp1dU03Y2tEbEN1M3ZsMTZwRFU3eEFsUHNiMmZE?=
 =?utf-8?B?QmNjRURsaHRkV0tFSGZEb1pXSHFNbGF1RXc4WXdpbHhoUEFoN1FRalllTHYw?=
 =?utf-8?B?OW55cVFMV2JQOWUwVWh0b2s1YzVZRG9kVHp2R2pEd0RyVEwvV1h5K0h0V084?=
 =?utf-8?B?aDE3QzBINzJuOVdSUklqcEsxdUU1QWhScC9jaFJtY0xEbjlDVjZXWHpmQlp5?=
 =?utf-8?B?aURMV2hKUTU2TmFSN2lidSt1YVlyTXJibGpjUUhNa29NREpxODZ5eVJ3L0dS?=
 =?utf-8?B?Sjk2UmZZMkRXVUl6b1YvbmdzTmdzSnZ1Y1BPa2tFczFaSHRkaGp6dXN5a2JL?=
 =?utf-8?B?Sk9zdHJwbnB5V0d0cGFJdkYwSWJDWHFsVmNIMjAzZDkzdGcwczhQQmdpTXBJ?=
 =?utf-8?B?ZlVVN24ydUJJS0o4Tm40NXIrNW9BYWhWR3oyUkJFZkJMek1kOHFjZUg2WFhi?=
 =?utf-8?B?K1BzTy9FbG1jbUdtMzVlZjVGenRsZng0WlV1cEVVRGJ2bmVYQ2dodWtKVW1R?=
 =?utf-8?B?bjJGazNKNy9tUGxkZzFuS1pKazQxMmZlYmsvUGlQbllyL1ZacjJmZGRaME1o?=
 =?utf-8?B?VlVPT2J4V2NBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkl5UjNYcE5lUTFSd0QwRlFWVVpsVzJUdDFtcE1MRlcrUDR1MkZlMEhYbVdK?=
 =?utf-8?B?WEdURi9HVzBWbzgzOEppK0orQmprQm1iMXVzVFBIVXVyamZNR25QenUrZDJU?=
 =?utf-8?B?ZHVnOWMxaUJEL1RIQjNGUklpeXB3OXFRWTJ3VTY4NFdzZFV6S2VEZ3JCaEVB?=
 =?utf-8?B?S3p6YithRnA0ek00cUJPKzF1Q0dYZ0JlZzR0VElnYzJhTVZwUVl3VWZGbW4v?=
 =?utf-8?B?M1pxeExYdTl1ZVJjSGs3cGxtZzFkeXQ1dzJOUGlPRHpBVVU3eWFGV1M0cW9F?=
 =?utf-8?B?MEowVm5EcmhkTUtwQ040QW0yNkVkaG1WeEVpY0l1SWFsZ1hUdkI3ZzlDT0pV?=
 =?utf-8?B?eHdkU1VNR21reVh1a2lEUzdyVXZZeHZ0L3YzcURYZ1J0Sy9ROGNIaHBGUjZQ?=
 =?utf-8?B?OUJMdkxXYng2NytFMVgzdTl6Tm1hb0hmZ0JDVmlWejRXaVlXQ3lTa1duQlRV?=
 =?utf-8?B?Z3ZQTWprYWhYeDNkbnM3ZGhUZzNRcnVWTEh0U2liRVBIRWFUOFFISFVxc1Fk?=
 =?utf-8?B?Q0N1TkgvUGN0YjRPVVZZTlFkbnUxTHQ5UmZPcWVhMFdqaGpjVnJiSktnZE9L?=
 =?utf-8?B?NFIwbS9UOHNKQnpKcC9PcTMxWWJ4OCtrek5xampoU2EzZGk0MWxZeERMbGVO?=
 =?utf-8?B?Vzd6c2ttajNJM3J4ejZldXZiT2RydmhGN1JFUVBhTjh3MC9UQklYelF5YlN0?=
 =?utf-8?B?Z3Fia1FtRGZic2pYSlc2eUVlMGcyTXRLMWFTeUliQklDNC9zZkJ5dy81Nzhu?=
 =?utf-8?B?VFRDYzZYNk5JVk1ONEJCeEdzS0l5SVZHQzRLSFc1OFAyZmU4RTZVcXNURWlo?=
 =?utf-8?B?STZvbFZmakFqQ1krYVBFVkdHaDBzcFM1OEdVcHpaSGc0SzhITTAvYitCOGJt?=
 =?utf-8?B?Qk41M0dqc0FibDdOSHh2cVRML09UWXhzMXEzaFRIT3poOHdtcDJ2SXJxRHZH?=
 =?utf-8?B?RTRreitRMXpOdndCQ1dSblNqUVA1Q2xZQ3BpMlBhV1drZE01eVp6bThCM213?=
 =?utf-8?B?TVcyNm11SFdlMlRrbEZCRUJWN3lLTU14RlBNeEU4VjNXb2MwTTU1cTY2b0RJ?=
 =?utf-8?B?OXNwbUk3Z3VzL1Rmc09Pb2UyYXFJLytWdXhvK01KNmhpd1FYNSsrOW5DMmRM?=
 =?utf-8?B?TUlPV1lTcjZwa3JGTlcwYm9pOU9iK1NLTmI5Ujcrc0ZkWTUwTWQwaHY5Z0Rn?=
 =?utf-8?B?SlNDTVc1NHZ2ZEZrUThDenZ3QlM3VHZqMVh5cUV2QWwvdEVEait1bWg5Sldk?=
 =?utf-8?B?UHZmS1c0cy9kdXpvbnFSaVFtdmJUSHBWSXpDcUQrdGkyQlZVYWNuUGNtRWp5?=
 =?utf-8?B?TklJck5RUWZtanhiSlpFUUt1cVBRZDVKQUJmRHF3Z1ZZdlQrU0l0TXBkWmY4?=
 =?utf-8?B?dVpXNWNaSnJTRmxUSUNDL2UxMytLNUp2d0Y2UU1teWdwYU9VRGlWOFhvd3Zu?=
 =?utf-8?B?TzA1c1B1aHdKandBWURZU1ZrM0FtWlIvMENmYlVqaGxMOGtpWkVaaTRCdHBx?=
 =?utf-8?B?Yk81c2dFTEJyT2F6czlNNzBJOG9WdDIwQ0sxWm1uYjNDeVNyWkRVUDUyOUI2?=
 =?utf-8?B?RWU2SlpUZ0xsR0hmMUZ1cmNYSnFucUtYUHlpZmdNcXRlWTN2UjQxWVJ4dWx6?=
 =?utf-8?B?M2l5SUlMd284YkduY1ZieVlqZmZ1L1cyWTRUSGZrdUM3VTFWcjNJczRyNmIr?=
 =?utf-8?B?ejFWbDUwU1JuQ2VuTW5jMm44c2VBWXlwVmQxcVREbzVJeEFEbms1dE95cnFk?=
 =?utf-8?B?anppc0VyMDlqaHhrQVpmNHQxUUprTGVyeXVvaTlmVmhQUnVYL2k0L0t0QkU4?=
 =?utf-8?B?amcrdFVHVWxwbStlb3dpTDRMVUkrZmZCbWNKSW9YN2NyK1FPUVVJcmF0SzN4?=
 =?utf-8?B?Q094ME51M2ZUdzJvVEZ6am1yblkvbDh0RUFKbTh2NDBrMGdNZ09NZWtRbDVl?=
 =?utf-8?B?ajlUZjRmNnlJckF0dlV3aUVYeUlYMDBtb25VTWR6dTl1dWUwR0l5ZUszOU1s?=
 =?utf-8?B?TzdUN1BLMjk1SzNKYk9uWmtpcDIxNURTZGtnbHkweGFkZndGeC9adUpkTU5O?=
 =?utf-8?B?bVFQVXkyTUwrZmhkcFcrM29VVHVYcTlvbVFKOTlFMVUrOGFSY1N5M2tJNWtr?=
 =?utf-8?Q?UtNA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a1bff8-98b4-4d8d-b350-08ddcdb16923
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 08:33:21.3146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zVps6KQfSDv9bmp6O52d48XoJZgehSvpnzq28s6qBm1xl7gpn1zNUj1v9ByfkipMRgh2wi9AXr3OOzIbuXzT7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8071
X-OriginatorOrg: intel.com

SGkgUGF1bCwNCg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KDQo+LS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj5Gcm9tOiBQYXVsIE1lbnplbCA8cG1lbnplbEBtb2xnZW4ubXBnLmRlPg0K
PlNlbnQ6IEZyaWRheSwgSnVseSAyNSwgMjAyNSA3OjA0IFBNDQo+VG86IEssIEtpcmFuIDxraXJh
bi5rQGludGVsLmNvbT4NCj5DYzogbGludXgtYmx1ZXRvb3RoQHZnZXIua2VybmVsLm9yZzsgU3Jp
dmF0c2EsIFJhdmlzaGFua2FyDQo+PHJhdmlzaGFua2FyLnNyaXZhdHNhQGludGVsLmNvbT47IERl
dmVnb3dkYSwgQ2hhbmRyYXNoZWthcg0KPjxjaGFuZHJhc2hla2FyLmRldmVnb3dkYUBpbnRlbC5j
b20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MSAxLzJdIEJsdWV0b290aDogYnRpbnRlbF9wY2ll
OiBBZGQgQmx1ZXRvb3RoIGNvcmUgYW5kDQo+cGxhdGZvcm0gZGV0YWlscw0KPg0KPkRlYXIgS2ly
YW4sDQo+DQo+DQo+VGhhbmsgeW91IGZvciB5b3VyIHBhdGNoLg0KPg0KPkFtIDI1LjA3LjI1IHVt
IDA1OjMxIHNjaHJpZWIgS2lyYW4gSzoNCj4+IEFkZCBCbHVldG9vdGggQ05WaSBjb3JlIGFuZCBw
bGF0Zm9ybSBkZXRhaWxzIHRvIHRoZSBQQ0kgZGV2aWNlIHRhYmxlDQo+PiBmb3IgZWFjaCBkZXZp
Y2UgSUQuDQo+DQo+SXTigJlkIGJlIGdyZWF0IGlmIHlvdSBtYWRlIGl0IG1vcmUgY2xlYXIgdGhh
dCBjb21tZW50cyBhcmUgYWRkZWQuIE1heWJlOg0KPg0KPkJsdWV0b290aDogYnRpbnRlbF9wY2ll
OiBBZGQgY29yZS9wbGF0Zm9ybSBuYW1lcyBhcyBjb21tZW50cw0KPg0KPkFkZCBCbHVldG9vdGgg
Q05WaSBjb3JlIGFuZCBwbGF0Zm9ybSBuYW1lcyB0byB0aGUgUENJIGRldmljZSB0YWJsZSBmb3Ig
ZWFjaA0KPmRldmljZSBJRCBhcyBhIGNvbW1lbnQuDQoNCkFjay4gSSB3aWxsIGFtZW5kIHRoZSBj
b21taXQgbWVzc2FnZS4NCg0KPg0KPj4gU2lnbmVkLW9mZi1ieTogS2lyYW4gSyA8a2lyYW4ua0Bp
bnRlbC5jb20+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmMg
fCA2ICsrKy0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2JsdWV0b290aC9idGludGVsX3Bj
aWUuYw0KPj4gYi9kcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuYw0KPj4gaW5kZXggOTc5
MmE0OTg4NmZmLi4xNGQ1OWQxMzUzY2QgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2JsdWV0b290
aC9idGludGVsX3BjaWUuYw0KPj4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2ll
LmMNCj4+IEBAIC0zNSw5ICszNSw5IEBADQo+Pg0KPj4gICAvKiBJbnRlbCBCbHVldG9vdGggUENJ
ZSBkZXZpY2UgaWQgdGFibGUgKi8NCj4+ICAgc3RhdGljIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNl
X2lkIGJ0aW50ZWxfcGNpZV90YWJsZVtdID0gew0KPj4gLQl7IEJUSU5URUxfUENJX0RFVklDRSgw
eDRENzYsIFBDSV9BTllfSUQpIH0sDQo+PiAtCXsgQlRJTlRFTF9QQ0lfREVWSUNFKDB4QTg3Niwg
UENJX0FOWV9JRCkgfSwNCj4+IC0JeyBCVElOVEVMX1BDSV9ERVZJQ0UoMHhFNDc2LCBQQ0lfQU5Z
X0lEKSB9LA0KPj4gKwl7IEJUSU5URUxfUENJX0RFVklDRSgweDRENzYsIFBDSV9BTllfSUQpIH0s
IC8qIEJsYXphckksIFdpbGRjYXQgTGFrZQ0KPiovDQo+PiArCXsgQlRJTlRFTF9QQ0lfREVWSUNF
KDB4QTg3NiwgUENJX0FOWV9JRCkgfSwgLyogQmxhemFySSwgTHVuYXIgTGFrZSAqLw0KPj4gKwl7
IEJUSU5URUxfUENJX0RFVklDRSgweEU0NzYsIFBDSV9BTllfSUQpIH0sIC8qIFNjb3JwaW91cywg
UGFudGhlcg0KPj4gK0xha2UtSCAqLw0KPg0KPldoeSBub3QgYWRkIEg0ODQgYXQgdGhlIGVuZCBy
aWdodCBhd2F5IGZyb20gdGhlIHBhdGNoIDIvMj8NCkFjay4NCg0KPg0KPj4gICAJeyAwIH0NCj4+
ICAgfTsNCj4+ICAgTU9EVUxFX0RFVklDRV9UQUJMRShwY2ksIGJ0aW50ZWxfcGNpZV90YWJsZSk7
DQo+DQo+UmV2aWV3ZWQtYnk6IFBhdWwgTWVuemVsIDxwbWVuemVsQG1vbGdlbi5tcGcuZGU+DQo+
DQpBY2suDQoNCj4NCj5LaW5kIHJlZ2FyZHMsDQo+DQo+UGF1bA0K
