Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E258C284687
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 09:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753088655; cv=fail; b=jMY9AhoeYzRT4lOlCh0e2DV5qDzWavuVYhKzGpitPPEWmPjSvC5mBR9HPtXNIO+nqu3D+epWGgZ7CMllpeMPfNI/inSSugF3vpgc+SPLMzLRpOHjqlGE0VEcCzyFBklLgjBGgh0lW/6kXIK2sCIMjUZ9gH1YoaDFWoF3iAQ0llc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753088655; c=relaxed/simple;
	bh=bakU8R719wJQUv5Ppvx6z6qcLXcsSaFuCzXwtZJQqmU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y8/bum+4vaxhrPytK09a8o9wpsgcbwEoYTFd05Y3nJusyQ4KO5DHu9oj23RAYGwDQk4U23EJJJ0av8TCpN9ZeL6HbVAFR+dQrJwPDkuUf8MsfbWt08p5C/Uzcsr3eMA6epLxOsEkveTLjaotq59TMCDj/KfhgviVrt0ikCDwORg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vvp5l29U; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vvp5l29U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753088653; x=1784624653;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bakU8R719wJQUv5Ppvx6z6qcLXcsSaFuCzXwtZJQqmU=;
  b=Vvp5l29UH8iWL8i3NHiG55fruYamZrg5I/sEdA/UkJRbpvEUHfD6Z7RJ
   w0FCDnDGAd5M6rG2yglS0bQp9AtJNQabFRm+MvxsHT7evsz4IEDua7bD9
   /9nHQ4JqdM3sXXlMD8+Ir8GnQhVHKKQPLtPNWu54IYdES8clbj9GugQtU
   A0s3zP0x5O+0hVLVxxu7MqXEX2XWIou2J11fjLFK3x+oA8tMTgU3WZDbu
   O8Fh+RJ9uKMVqA+KSjAwPy1G6h1MDOpi+wQ3aC87ny9j9ImFBGljFYLrB
   ygF1NRsTM+yFHvclE9sxJlQH5JWAfq2NUXApKdsmHnrgY89sLx21yQr6K
   Q==;
X-CSE-ConnectionGUID: sgaxoUJ1QZWI6IXv7cKp2A==
X-CSE-MsgGUID: aFAkQL0OQoyTunR8u1Nerw==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="55446475"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="55446475"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 02:04:13 -0700
X-CSE-ConnectionGUID: cztH1YT+SFOi/I+QhrapQA==
X-CSE-MsgGUID: eZkOOheFRi2ldM4GmQaUBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="163080225"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 02:04:12 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 02:04:11 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 02:04:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.58)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 02:04:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJstdW8fcgcC2akonvLC7GJJF15UFSvVXxL4lbl7oCJkS6mLh2LkT9ve4a/YT0EZMXtja8kUc4YmYgmoFRone4AHdDAzpwIPQFA1IhXx2UaFK5dfm5rS74SSe3fzXjBLsmKZW1d99HdGFfNnuA0Cun1rNyYHVlYnKVQCTppYcKQSSmLx0nk9QheQQaaZ5f39aH9pvitnnOy6ZY0C1+AZhvNpxl6L8wnesB0lPEJvAG042pQ1MJPSYswmsqQBPGUp4RNhYQWFheGa4Hjsk/2GY6iVUC4Fr2WInxWoKVttBNpL0lV7Z+ERPoPDIoX+QkOJVEJ73SwZusgp6XXQo4uWiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bakU8R719wJQUv5Ppvx6z6qcLXcsSaFuCzXwtZJQqmU=;
 b=Q0kCAh1digtwM5KW1WvHaDDxRo9T/vykBBull5GDdy+AXQ8lxWGMb5IUOIdRDzjssR2geivtMzMSygoCw7RidMxrKHFhDDwU5aYBe4JLe48h5ZGIFL7WQDLH3EOqBwbNIjQUL3xAB0gdDyd+ybjv94OqttcaG4viTT7WtpM+svCq+Tg9p3AiFnCw9890lMo9EQfabdSaqYxa9pP/cTisYRQwOc/vIcf+FYsGmGTu3dRbtXCohlFQne00FZ2GqXMj9fnHPa461j6/hhCBEhZ+XM8BFJ7ud8iyBa9b3Ec+ZDE1sYshsihUCAiAh4w/FWiwnFmJddRpIk+xDvlVQI6i6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by LV8PR11MB8463.namprd11.prod.outlook.com (2603:10b6:408:1ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 09:03:42 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%2]) with mapi id 15.20.8922.040; Mon, 21 Jul 2025
 09:03:42 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, "Devegowda, Chandrashekar"
	<chandrashekar.devegowda@intel.com>, Aluvala Sai Teja
	<aluvala.sai.teja@intel.com>
Subject: RE: [PATCH v2 2/2] Bluetooth: btintel_pcie: Fix Alive Context State
 Handling
Thread-Topic: [PATCH v2 2/2] Bluetooth: btintel_pcie: Fix Alive Context State
 Handling
Thread-Index: AQHb9TE1zssDKTJERUSeURNpULVsLbQ1HHqAgAc00EA=
Date: Mon, 21 Jul 2025 09:03:41 +0000
Message-ID: <PH0PR11MB75850BA96606AB4DE3BAA267F55DA@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20250715025217.1005089-1-kiran.k@intel.com>
 <20250715025217.1005089-2-kiran.k@intel.com>
 <CABBYNZKy0b0wBSrty2RqX-ArDv8eU2nrp9Z8opiDO+d7EokDsA@mail.gmail.com>
In-Reply-To: <CABBYNZKy0b0wBSrty2RqX-ArDv8eU2nrp9Z8opiDO+d7EokDsA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|LV8PR11MB8463:EE_
x-ms-office365-filtering-correlation-id: e90094b5-0f50-4ec4-c224-08ddc8357d74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TjhPVjFZS3N3Z0hONTdiTHBHaVgvTEtYdEVSM0lEVk9vaS9sNnE1cXJld0Z1?=
 =?utf-8?B?bHNwUU1yMm1jZE12MWdHY3E0WnFSSm4zc1B1bFFNaE9GTXo5RlI2bjhrbmVq?=
 =?utf-8?B?b3F0VXM5Wit5VzdlaVY2a0s5Mm1lZjlzS0J6UURFcFRZdWRpSUQzS2FyY2pj?=
 =?utf-8?B?THpyTGh4NlNUWW01K1Z1aThPWm83RzlhcjVNYVhTaG0xa2I4TTVNYTI4VTBV?=
 =?utf-8?B?Q1RWLzJHL1ZaWVA4enFtdk14WGswZHVvNEpYaWJKQSt3ZTNoZUpKdUhFeFM3?=
 =?utf-8?B?VVpjMHdyTmhVMGNma1R3eGgyaVVRMTJqSUFBOE16K2UyV2RPNlViZ2lwbGZ5?=
 =?utf-8?B?RGROUnVUVnFyZnhDQ01XWStJMjduVTl1MElQdWw5RlM5enk2VXFNQ3M1UmtQ?=
 =?utf-8?B?S1ZYVkk5ZGcvbTFQd0xZWHhQV3R3eFRqZUN4VWFDM2thQ05mY0JNdFJOMWgx?=
 =?utf-8?B?cmlRQkI5VFVmL0ptWHN0dXdCejJGMzFiU0ltUW1xUVhMT253Mm5mVzZPWkhR?=
 =?utf-8?B?U0ZSaHErNTQ5YTEvYnluMXJUSHVCVXJsdHJKQ2F1cVV6cHBxSTlhc3FSSHJy?=
 =?utf-8?B?L0FaNHFPd1pMMFhRNXJiQmNtdDFEK2JKUnovdFlFTTlEc1haWUZ2Njg4K2Jo?=
 =?utf-8?B?MlR4c3hXZDlwSW02cmh3Qk8wTTdIT1ZHVVphTmlVMllFb3VRWTlaRXViT1h6?=
 =?utf-8?B?a21keUpjdUlRaHNqRlVkb3prYlFhUkVta3dHSlFFUlhjWGFQaVBHamRZNTFC?=
 =?utf-8?B?amJrdE1rQXhTd2ZvNGQ3aVVmd21kUE53N2NlR09OOG1lcWJyMU40RVZXWDJC?=
 =?utf-8?B?bjZBajdVUTVUT2NpaTBzU2IxN1lGYkYvaFlPdDlWNkhTcnlIWjBsZWtVbE52?=
 =?utf-8?B?STB2VSt6anhZOTY2Z1NRRkJTenQvWGIraTErOVZ3VHlLTmRYU1Q0VCt3d0Jn?=
 =?utf-8?B?TkFEQjBYd2hBaGFqTU1VUEt1NDNUUys2RVBxVS9hd3k1aFBFT3NMQUpGb0Qr?=
 =?utf-8?B?bXJDVUd6U2trSkRMMkw3WllXdUZuUHpPWFJGQmN2a0g0elN2eVphZ2VBN2pi?=
 =?utf-8?B?aE90ZWJld3dtcXA5T3VkWWY3cU5BU2dSTUY1WXpPYzAvNmtMcys0QmoxcGhD?=
 =?utf-8?B?K29pV0FnbEJ4Y2ZEV2pnZHZ1eWY5Y2Y4VGlBOEpYRHR0RUxkYXJFMCs3ZS9h?=
 =?utf-8?B?TDArVUNrMGlieFlCTXd1QmJXR25wcTg1b0IxRDhFb3FzUHNxVmxRaHZxeG1Q?=
 =?utf-8?B?bnNVVGhGZGxqV3lyRWowU1RiREZDS1FYTFZ6cThsN2dRdVZVZDZTeFVRdjFl?=
 =?utf-8?B?L25iVDNPVitqQXdxakhLeTc1RU9CVEhPRXMvejBndm9GbzNrWklmMWFsQi9J?=
 =?utf-8?B?THBWZzlrMHVGY2tDa2s0Z3lqbUV4TmlQcCs2QW9kOGV4L2xwMWxlSm9LTjlD?=
 =?utf-8?B?VkFWT3B2dmpJM1ROZ2NSUVZEbzZwV2lvL0pxcHhiMXRPYlZFVnZUK0hOd0NT?=
 =?utf-8?B?SVBWYTRrTzV5clJvZnVKbDJ6K3hWTDRSakl0dTJ0bFNlRnBWWXRqWUhPczFW?=
 =?utf-8?B?b1BxM0JLWTM5OHRmSFN5KzBVZnN0UWpNUHNTUVJ1TUx4N1Yvb0tYSStqb3Fj?=
 =?utf-8?B?UlEwYis1ZWs5cG13UkhsMy8xQnJoMkl6UTMzc2ZSd1VNWFNrS1ZHcWxGQXVV?=
 =?utf-8?B?RkpGQ2Y2K1R6Ty9Feko1NnRlTXNoS3g5cU1KdHBVT0k2cDRrcFdiL1JjTU4r?=
 =?utf-8?B?NlhUWkFwbGpDS3BkZ0pIK3FrZUZnOXQ3emw2Ry8vS1lrRnZQa0VSd0dWZmNy?=
 =?utf-8?B?Sk1FbFg1TjI4U0YwZnRqSDFZcG5lOElhVnhGVXFmenVYc2hmTVhKQU9hc2VD?=
 =?utf-8?B?cXBXekI0QkdPdHdmeHlIL0FxQnlhVzliYi9MSGRraklnRGYyT1NQdWI0bE9Z?=
 =?utf-8?B?S0M0RUNXalFSa3BFYzk2NEhHZEpNNWMrb3BlaDlaUm40c3NQY1owYXQ5Nlo4?=
 =?utf-8?B?TjYxb0hmc1l3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2Y5WFQ1R3FBYlFlaEs0ZDFYUHBWVkk5VXFCUWxISm1xZDNDWXpUVjhUS2Y3?=
 =?utf-8?B?RmhsRmRhNHZXZXpZUE1zN0dKcWxYRS80OHFocktadzRIa3JLWlFCSjdvazZC?=
 =?utf-8?B?MVB6bXRGdTlIbEIrajBkU1RWeGRUekNESmhxRnNqNG1zc0VCUGIvMmU1Mm5C?=
 =?utf-8?B?MG96VXNreGpkbHYwTHVEQkRFTjJ3a2lnMEdTc1FWaVpuSXhsRFlMTlFoWnZZ?=
 =?utf-8?B?UkNHVmZOVU1Zem9IR1pXbGIwR2NSVFprYTc0UXBQc1hVeC91Z0ZyRDRSNUNS?=
 =?utf-8?B?K0VoSDk1UnljOEpzZ2dMdWVKVW5USlozUVNucFdDSExDNEkra21yWFhGU01t?=
 =?utf-8?B?c3Y5ejZ6YTFleFhPNWYvd0xZb0dvQ3dQSzRtamVpL0VUWWdyT3BOT1BpNFJ4?=
 =?utf-8?B?ektGNGpKTWpmR3hkMDNORGxldHdQU3lOMk9FOUpkbExDaWtoKzlEYlBjL3dl?=
 =?utf-8?B?UG5pRVRPMmFrV3NHcVJSMHVFTmgxaDczTFhzS0lMVmpXMVFkQ1BSWUc5NE02?=
 =?utf-8?B?UEU0OWxMV3BzODlUL1lrRVBZMEtvWkV6UGN6L2h4Nk1pNGdXb3Q5aGJyQjBn?=
 =?utf-8?B?QnhzMFU4dGtnbS9HdWgzTVp0SUJESzFPWmtBWmwxb3BNY2hWc1hxU1RaL2tT?=
 =?utf-8?B?dWpOSmZwL2p0akR6MXJOMlMyUkF2NEpwcWJQT1hkWTF3THRCZVJCSGtmQUJj?=
 =?utf-8?B?VmpTYTUwOVBwM1V6RmVGY2dHU05HOXVLWnE3dTAvdGJsbGl1R3lOSGFNbnB0?=
 =?utf-8?B?ek96V28weUxkWWFMWGNueWhob05qYnJIc3hRdkpwc2lKNE1US0JmVzBRbGtk?=
 =?utf-8?B?VTErOUZZWXJOMVVIbzdDd3VDN1psM0Rad3hRL1VMU3JhOStpMTdITTh5VzE1?=
 =?utf-8?B?elA4S3NVcDI1UUt5NFg5L3V2UmpBRlNjNGRYUGpucDZQYWtQZkxqbVg2ZEVE?=
 =?utf-8?B?NWwyZHNaclZ2MEs2RFR2aW5aZDJJbXF0OFcxaGtKQzNUeW1Wd01YRzRkdVVC?=
 =?utf-8?B?YWpnYk1UekcyOU9OU2ZDUDFpQ1pqaS9CY2xLRHcwYlpMb3VMSlkyNkcyNXp5?=
 =?utf-8?B?V0hSS1lGOUVaSE9mb2hVcGY0bU1hRHZEV2gwVGtJTlB2eG9VaWZjd3BXK3Uv?=
 =?utf-8?B?Z2hFNTN4NXpTNVBqK2s2ZHVqNStKZXNGQ2ZGOEpHN3IyY3JCdkVaUWJMaFFj?=
 =?utf-8?B?MVRSRGc5VmpkeERQei82MkhhL0QrVXlqQmtQbGJPQkdxYURYTTRpVTdTellH?=
 =?utf-8?B?NHcxMEkvUFBhVHhVSk5zeWtwcmFkL1ZkQVJDL3JiNUYyUWN5UXZuVitCNEVH?=
 =?utf-8?B?VVhTcGF2VlExbm14eDRTSUMwOWNjQ3VabisyQTR4c1JHZlpDQ29oWFk2c09O?=
 =?utf-8?B?eU9NeStaUG5talQrcHFaS3ZHVldubFpjWDlVbTRWS1FPTFdrTFlJM0VkbUlT?=
 =?utf-8?B?MmNNRnVrcmVVUmF6c2tBbWp3WTZqTmZTMHE1Rk0rSHNLekdkMUtwVWViN1BQ?=
 =?utf-8?B?cjNZcUV6YVRaWVhERlN2cTFMdVMwWi9OT3Z2SEJCdTZoWEJ3ZFZibkwxek1s?=
 =?utf-8?B?YzBkK2lxSTBpWkNrUjNlKzZVY1c0S2RDcTFDdmkxQ1htTytkOEpVWWNpanU5?=
 =?utf-8?B?d2JIUERPOFh1UzlHZTlLalRPS3JpcHl2Zi8zY1Bwd25JcDRKaEFnVHBuQm5O?=
 =?utf-8?B?VHdMWU8wblVhOU5tWXY2ZXBNOTVnTEpaamtDWjZtR2haT3o5a3lBcTZMOXlX?=
 =?utf-8?B?NkVkd3F6Y1ZRc1JmcHNCeFJQekJ4NklEMmdLeE44bWN5aXQxOW5uOTVDV1VN?=
 =?utf-8?B?SjdkeTBqUHc0VldFckU5cVdJTW0ybkJwRkRiZDJsYzdPTzZPdGcvZzdlZ3Ez?=
 =?utf-8?B?d2MrVk5aMThLY1k5bXJnQ3RzQUwzdVgveGU5Wk5kMm50NmhaQVlCUXBzdGxq?=
 =?utf-8?B?VG8xV1JvV0VHdVhuQXlPZVV2alZwS2JZYzFMRW1Makg4Q1o0S0VJVzlFZDNR?=
 =?utf-8?B?RUZkejZGc3d3aGswNUlzQU9qcTVxeExLL3BiRG5hbTNEL0gzUHJ4bGFZOVRV?=
 =?utf-8?B?bUo1Z3dzNGt2a3pvY0RiN3JRMEl3VldXd3hBOXE5bVRvOGhuakppT1ppblN4?=
 =?utf-8?Q?RUV0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e90094b5-0f50-4ec4-c224-08ddc8357d74
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2025 09:03:41.9852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u7IGb4VbK7Sm6oE1LGsNBonV7ZxzqqNBGL4SNCzCI4IVAA2hbNQ0fQmcsENbzKYQGQxkzB/5q8bm7IbFCOvw6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8463
X-OriginatorOrg: intel.com

SGkgTHVpeiwNCg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMi8yXSBCbHVldG9vdGg6IGJ0aW50
ZWxfcGNpZTogRml4IEFsaXZlIENvbnRleHQgU3RhdGUNCj5IYW5kbGluZw0KPg0KPkhpIEtpcmFu
LA0KPg0KPk9uIE1vbiwgSnVsIDE0LCAyMDI1IGF0IDEwOjM24oCvUE0gS2lyYW4gSyA8a2lyYW4u
a0BpbnRlbC5jb20+IHdyb3RlOg0KPj4NCj4+IFRoZSBmaXJtd2FyZSByYWlzZXMgYW4gYWxpdmUg
aW50ZXJydXB0IHVwb24gc2VuZGluZyB0aGUgSENJX1JFU0VUIG9yDQo+PiBCVElOVEVMX0hDSV9P
UF9SRVNFVCBjb21tYW5kLiBBcyBwYXJ0IG9mIGhhbmRsaW5nIHRoZSByZXNldCBjb21tYW5kLA0K
Pj4gZmlybXdhcmUgaW5pdGlhbGl6ZXMgdGhlIGhhcmR3YXJlIGFuZCBkYXRhIHBhdGggYW5kIHJh
aXNlcyB0aGUgYWxpdmUNCj4+IGludGVycnVwdC4gVXBvbiByZWNlaXZpbmcgdGhlIGFsaXZlIGlu
dGVycnVwdCwgdGhlIGRyaXZlciBtdXN0IGVuYWJsZQ0KPj4gdGhlIGRhdGEgcGF0aCBhbmQgZ3Jh
bnQgUlggYnVmZmVycyB0byB0aGUgZmlybXdhcmUgYmVmb3JlIHNlbmRpbmcgYW55DQo+PiBjb21t
YW5kcy4NCj4+DQo+PiBUaGUgYWxpdmUgY29udGV4dCBtYWludGFpbmVkIGluIHRoZSBkcml2ZXIg
bXVzdCBiZSB1cGRhdGVkIGJlZm9yZQ0KPj4gc2VuZGluZyBCVElOVEVMX0hDSV9PUF9SRVNFVCBv
ciBIQ0lfT1BfUkVTRVQgdG8gcHJldmVudCBhIHBvdGVudGlhbA0KPj4gcmFjZSBjb25kaXRpb24g
d2hlcmUgdGhlIGNvbnRleHQgaXMgYWxzbyB1cGRhdGVkIGluIHRoZSB0aHJlYWRlZCBJUlEuDQo+
Pg0KPj4gVGhlIGlzc3VlIHdhcyBvYnNlcnZlZCBpbiBhIHN0cmVzcyByZWJvb3QgdXNlY2FzZSAo
MS8yNSkgdXNpbmcgInN1ZG8NCj4+IHJlYm9vdCIgY29tbWFuZCB3aGVyZSB0aGUgZmlybXdhcmUg
ZG93bmxvYWQgd2FzIGZhaWxpbmcgYXMgdGhlIGRyaXZlcg0KPj4gd2FzIG5vdCBncmFudGluZyBS
WCBidWZmZXIgdG8gZmlybXdhcmUgZHVlIHRvIHJhY2UgY29uZGl0aW9uLg0KPj4NCj4+IEJsdWV0
b290aDogaGNpMDogQVBJIGxvY2sgaXMgZGlzYWJsZWQNCj4+IEJsdWV0b290aDogaGNpMDogRGVi
dWcgbG9jayBpcyBkaXNhYmxlZA0KPj4gQmx1ZXRvb3RoOiBoY2kwOiBNaW5pbXVtIGZpcm13YXJl
IGJ1aWxkIDEgd2VlayAxMCAyMDE0DQo+PiBCbHVldG9vdGg6IGhjaTA6IEJvb3Rsb2FkZXIgdGlt
ZXN0YW1wIDIwMjMuNDMgYnVpbGR0eXBlIDEgYnVpbGQgMTE2MzENCj4+IEJsdWV0b290aDogaGNp
MDogRm91bmQgZGV2aWNlIGZpcm13YXJlOiBpbnRlbC9pYnQtMDBhMC0wMGExLWltbC5zZmkNCj4+
IEJsdWV0b290aDogaGNpMDogQm9vdCBBZGRyZXNzOiAweGIwMzAxMDAwDQo+PiBCbHVldG9vdGg6
IGhjaTA6IEZpcm13YXJlIFZlcnNpb246IDE2Ny0xMi4yNQ0KPj4gQmx1ZXRvb3RoOiBoY2kwOiBX
YWl0aW5nIGZvciBmaXJtd2FyZSBkb3dubG9hZCB0byBjb21wbGV0ZQ0KPj4gQmx1ZXRvb3RoOiBo
Y2kwOiBGaXJtd2FyZSBsb2FkZWQgaW4gOTk5MDIgdXNlY3MNCj4+IEJsdWV0b290aDogaGNpMDog
QWxpdmUgY29udGV4dDogZndfZGwgb2xkX2Jvb3Rfc3RhZ2U6IDB4YTBkYjAwMDMNCj4+ICAgICAg
ICAgICAgbmV3X2Jvb3Rfc3RhZ2U6IDB4YTBkYjAwMDMNCj4+IEJsdWV0b290aDogaGNpMDogc2Vu
dCBjbWQ6IDB4ZmMwMSBhbGl2ZSBjb250ZXh0IGNoYW5nZWQ6DQo+PiAgICAgICAgICAgIGZ3X2Rs
ICAtPiAgaW50ZWxfcmVzZXQxDQo+PiBCbHVldG9vdGg6IGhjaTA6IFdhaXRpbmcgZm9yIGRldmlj
ZSB0byBib290DQo+PiBCbHVldG9vdGg6IGhjaTA6IERldmljZSBib290IHRpbWVvdXQNCj4+IEJs
dWV0b290aDogaGNpMDogRmlybXdhcmUgZG93bmxvYWQgcmV0cnkgY291bnQ6IDENCj4+DQo+PiBG
aXhlczogMDVjMjAwYzhmMDI5ICgiQmx1ZXRvb3RoOiBidGludGVsX3BjaWU6IEFkZCBoYW5kc2hh
a2UgYmV0d2Vlbg0KPj4gZHJpdmVyIGFuZCBmaXJtd2FyZSIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBL
aXJhbiBLIDxraXJhbi5rQGludGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFNhaSBUZWphIEFs
dXZhbGEgPGFsdXZhbGEuc2FpLnRlamFAaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgZHJpdmVycy9i
bHVldG9vdGgvYnRpbnRlbF9wY2llLmMgfCAyOCArKysrKysrKysrKysrKystLS0tLS0tLS0tLS0t
DQo+PiAgMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0K
Pj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuYw0KPj4g
Yi9kcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuYw0KPj4gaW5kZXggYTE3YzQzODc4NGFl
Li42NjgwZWYzMjA3ZWQgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2JsdWV0b290aC9idGludGVs
X3BjaWUuYw0KPj4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmMNCj4+IEBA
IC0xOTg4LDEyICsxOTg4LDYgQEAgc3RhdGljIGludCBidGludGVsX3BjaWVfc2VuZF9mcmFtZShz
dHJ1Y3QgaGNpX2Rldg0KPipoZGV2LA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBidGludGVsX3BjaWVfaW5qZWN0X2NtZF9jb21wbGV0ZShoZGV2LCBvcGNvZGUpOw0KPj4gICAg
ICAgICAgICAgICAgIH0NCj4+DQo+PiAtICAgICAgICAgICAgICAgLyogRmlybXdhcmUgcmFpc2Vz
IGFsaXZlIGludGVycnVwdCBvbiBIQ0lfT1BfUkVTRVQgb3INCj4+IC0gICAgICAgICAgICAgICAg
KiBCVElOVEVMX0hDSV9PUF9SRVNFVA0KPj4gLSAgICAgICAgICAgICAgICAqLw0KPj4gLSAgICAg
ICAgICAgICAgIGlmIChvcGNvZGUgPT0gSENJX09QX1JFU0VUIHx8IG9wY29kZSA9PSBCVElOVEVM
X0hDSV9PUF9SRVNFVCkNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgIGRhdGEtPmdwMF9yZWNl
aXZlZCA9IGZhbHNlOw0KPj4gLQ0KPj4gICAgICAgICAgICAgICAgIGhkZXYtPnN0YXQuY21kX3R4
Kys7DQo+PiAgICAgICAgICAgICAgICAgYnJlYWs7DQo+PiAgICAgICAgIGNhc2UgSENJX0FDTERB
VEFfUEtUOg0KPj4gQEAgLTIwMTQsNiArMjAwOCwyMSBAQCBzdGF0aWMgaW50IGJ0aW50ZWxfcGNp
ZV9zZW5kX2ZyYW1lKHN0cnVjdCBoY2lfZGV2DQo+KmhkZXYsDQo+PiAgICAgICAgIG1lbWNweShz
a2JfcHVzaChza2IsIEJUSU5URUxfUENJRV9IQ0lfVFlQRV9MRU4pLCAmdHlwZSwNCj4+ICAgICAg
ICAgICAgICAgIEJUSU5URUxfUENJRV9IQ0lfVFlQRV9MRU4pOw0KPj4NCj4+ICsgICAgICAgaWYg
KHR5cGUgPT0gQlRJTlRFTF9QQ0lFX0hDSV9DTURfUEtUICYmDQo+PiArICAgICAgICAgICAob3Bj
b2RlID09IEhDSV9PUF9SRVNFVCB8fCBvcGNvZGUgPT0gQlRJTlRFTF9IQ0lfT1BfUkVTRVQpKSB7
DQo+PiArICAgICAgICAgICAgICAgLyogRmlybXdhcmUgcmFpc2VzIGFsaXZlIGludGVycnVwdCBv
biBIQ0lfT1BfUkVTRVQgb3INCj4+ICsgICAgICAgICAgICAgICAgKiBCVElOVEVMX0hDSV9PUF9S
RVNFVA0KPj4gKyAgICAgICAgICAgICAgICAqLw0KPj4gKyAgICAgICAgICAgICAgIGRhdGEtPmdw
MF9yZWNlaXZlZCA9IGZhbHNlOw0KPj4gKyAgICAgICAgICAgICAgIG9sZF9jdHh0ID0gZGF0YS0+
YWxpdmVfaW50cl9jdHh0Ow0KPj4gKyAgICAgICAgICAgICAgIGRhdGEtPmFsaXZlX2ludHJfY3R4
dCA9DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAob3Bjb2RlID09IDB4ZmMwMSA/IEJUSU5U
RUxfUENJRV9JTlRFTF9IQ0lfUkVTRVQxIDoNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBCVElOVEVMX1BDSUVfSENJX1JFU0VUKTsNCj4+ICsgICAgICAgICAgICAg
ICBidF9kZXZfZGJnKGRhdGEtPmhkZXYsICJzZW5kaW5nIGNtZDogMHglNC40eCBhbGl2ZSBjb250
ZXh0DQo+Y2hhbmdlZDogJXMgLT4gJXMiLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBvcGNvZGUsIGJ0aW50ZWxfcGNpZV9hbGl2ZWN0eHRfc3RhdGUyc3RyKG9sZF9jdHh0KSwN
Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnRpbnRlbF9wY2llX2FsaXZlY3R4
dF9zdGF0ZTJzdHIoZGF0YS0+YWxpdmVfaW50cl9jdHh0KSk7DQo+PiArICAgICAgIH0NCj4+ICsN
Cj4+ICAgICAgICAgcmV0ID0gYnRpbnRlbF9wY2llX3NlbmRfc3luYyhkYXRhLCBza2IpOw0KPj4g
ICAgICAgICBpZiAocmV0KSB7DQo+PiAgICAgICAgICAgICAgICAgaGRldi0+c3RhdC5lcnJfdHgr
KzsNCj4+IEBAIC0yMDIzLDEzICsyMDMyLDYgQEAgc3RhdGljIGludCBidGludGVsX3BjaWVfc2Vu
ZF9mcmFtZShzdHJ1Y3QNCj4+IGhjaV9kZXYgKmhkZXYsDQo+Pg0KPj4gICAgICAgICBpZiAodHlw
ZSA9PSBCVElOVEVMX1BDSUVfSENJX0NNRF9QS1QgJiYNCj4+ICAgICAgICAgICAgIChvcGNvZGUg
PT0gSENJX09QX1JFU0VUIHx8IG9wY29kZSA9PSBCVElOVEVMX0hDSV9PUF9SRVNFVCkpIHsNCj4+
IC0gICAgICAgICAgICAgICBvbGRfY3R4dCA9IGRhdGEtPmFsaXZlX2ludHJfY3R4dDsNCj4+IC0g
ICAgICAgICAgICAgICBkYXRhLT5hbGl2ZV9pbnRyX2N0eHQgPQ0KPj4gLSAgICAgICAgICAgICAg
ICAgICAgICAgKG9wY29kZSA9PSBCVElOVEVMX0hDSV9PUF9SRVNFVCA/DQo+QlRJTlRFTF9QQ0lF
X0lOVEVMX0hDSV9SRVNFVDEgOg0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBC
VElOVEVMX1BDSUVfSENJX1JFU0VUKTsNCj4+IC0gICAgICAgICAgICAgICBidF9kZXZfZGJnKGRh
dGEtPmhkZXYsICJzZW50IGNtZDogMHglNC40eCBhbGl2ZSBjb250ZXh0IGNoYW5nZWQ6DQo+JXMg
IC0+ICAlcyIsDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICBvcGNvZGUsIGJ0aW50ZWxf
cGNpZV9hbGl2ZWN0eHRfc3RhdGUyc3RyKG9sZF9jdHh0KSwNCj4+IC0gICAgICAgICAgICAgICAg
ICAgICAgICAgIGJ0aW50ZWxfcGNpZV9hbGl2ZWN0eHRfc3RhdGUyc3RyKGRhdGEtPmFsaXZlX2lu
dHJfY3R4dCkpOw0KPj4gICAgICAgICAgICAgICAgIHJldCA9IHdhaXRfZXZlbnRfdGltZW91dChk
YXRhLT5ncDBfd2FpdF9xLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBkYXRhLT5ncDBfcmVjZWl2ZWQsDQo+Pg0KPj4gbXNlY3NfdG9famlmZmllcyhCVElOVEVM
X0RFRkFVTFRfSU5UUl9USU1FT1VUX01TKSk7DQo+DQo+TG9va3MgbGlrZSB0aGUgY29tbWVudCBh
Ym91dCBtb3ZpbmcgZXZlcnkgd2FpdF9ldmVudF90aW1lb3V0IGludG8NCj5idGludGVsX3BjaWVf
c2VuZF9zeW5jIGhhcyBub3QgYmVlbiBhZGRyZXNzZWQsIG9yIHRoZXJlIGlzIGEgdmFsaWQgcmVh
c29uIHdoeQ0KPndlIGFyZSBoYW5kbGluZyB0aGlzIGFzIHBvc3QgcHJvY2Vzc2luZyBvZiBidGlu
dGVsX3BjaWVfc2VuZF9zeW5jPw0KDQpBY2suIEkgYWdyZWUgd2l0aCB5b3VyIGNvbW1lbnQuIEl0
IG1ha2VzIGxvZ2ljYWwgc2Vuc2UgdG8gbW92ZSB3YWl0X2V2ZW50X3RpbWVvdXQoKSBjYWxsIGZv
ciBhbGl2ZSBpbnRlcnJ1cHQgaW5zaWRlIGJ0aW50ZWxfcGNpZV9zZW5kX3N5bmMoKS4gDQoNCj4N
Cj4+IC0tDQo+PiAyLjQzLjANCj4+DQo+Pg0KPg0KPg0KPi0tDQo+THVpeiBBdWd1c3RvIHZvbiBE
ZW50eg0KDQpUaGFua3MsDQpLaXJhbg0KDQo=
