Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13E72773DE
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 04:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762488726; cv=fail; b=WAxf/W7JlQyAKy6GoZrGWYOXE9dpmQvAtOzUMcNBs3lMU5GZNrmG3dbcikl2nInp3LlNi+63GasE8KGALev+1/aAhUPLwggxgXSn/QGhJbL8I/dm3s0/yxr/6PaNlr78LxzSZQ2MxW1t+74+7q2fRwVEjDtHj+Vr6xoHvoPvlGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762488726; c=relaxed/simple;
	bh=OIY8AEupzSu4Eq12v+HL5KV0x+bYjvUgDW5dn1pw4lA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gk3ZJEwQ381tf4au46YGnzOGryZk90wwXyqN8yFlqEFNmJlEapHX52zaEAi6P55VN+cz/hTdtWLLtPvjak5THqeM7pGB/HGNMh1FLLxv5xH+zFzJJAq1UavXSS8WW+47s2pbuDRrfPEa531aOaWfAqBZYvAT2CeJZP44ZmS0Z6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lli791J+; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lli791J+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762488725; x=1794024725;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OIY8AEupzSu4Eq12v+HL5KV0x+bYjvUgDW5dn1pw4lA=;
  b=Lli791J+P/uIDh1x/GTvXvophIC3rAc+wfV6kVOpRFKDWyeiaI8wWgJ5
   FAnCl5BGezJ72CcOg9KUxBZ8fQscVpvWLbW7ur5J9pRsF3FLqSULiweDB
   fBDN7AA+MFot5EjjV0EVTlJdTAKM+wXOuR3F70qZQQTt8DqcXlQWbbQxB
   ozmkYl21nHotBP7CA51ugR0/qWdPiC8yHUKvxz6KW7f/CxI9BP8au2yM9
   5VFiDW62qM1PzZ+5T3ZSKI9ksTjmcugvur5QjMxp3BxqUlIcZOoHZU3bt
   4V9HYoHhQ1jVLuZGhL5Vtd5aAPUNpCsgZm5Ys77aREZ9cZ0A6vffRBg+d
   g==;
X-CSE-ConnectionGUID: eIaUV0GAQ9aJdad9Te0Dgw==
X-CSE-MsgGUID: QE+lFL2WTR6m39b26cSsKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="64336520"
X-IronPort-AV: E=Sophos;i="6.19,285,1754982000"; 
   d="scan'208";a="64336520"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 20:12:05 -0800
X-CSE-ConnectionGUID: B9RtaRS4S7++Y5QwSdSWKQ==
X-CSE-MsgGUID: VWvhQFW3SaKk9Y+uvM9G+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,285,1754982000"; 
   d="scan'208";a="188209715"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 20:12:04 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 20:12:03 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 6 Nov 2025 20:12:03 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.6) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 20:12:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kxe/nf3zlx/wWBaqX3oHjx/In8fTMBM8wLr5SXjAyQcdHjqJqY4aZeWHLZkW4SYtiog0EcLHqHTCA7amImXrJWivH8B9xKrqTWCDSDXz5T/5yve8hKD5vX8r2mbpShgqdiqlxyup5BzruOq6BPVKA91jEijo34dPWlvnds64DaqD4hsd4FbyS14O3spSlSKU7Z03DG3k49AuFSSq0zhSX3Aenosj74gllNxB2sgjdpZy2Pa43N2t/52FTrsSjdvqC+vlBLGU0cg/pA+b95Gd1Bl3Dz5AcIAM/ihp4KAc08bevZSTaSmdF9LV9n4TXKDin+SHVHGK8lufxW/p9GCNyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIY8AEupzSu4Eq12v+HL5KV0x+bYjvUgDW5dn1pw4lA=;
 b=mEx6uibo2qN0xk70UHgzqMxDTzHI/2qk649knR0NPhrMEMHC/Xr7zbWardeYpaWq8B+tChCbQn1+THzw3JXiZW9bVlYdbk1jbKavAwFusOYwTn1R1xHZi/3/yXnE1do3kudhlSEfavHEOzUx2xivIEJiQfJD67FRrv/zwfbaHLt/Ue9FrskkedNOM99EQU0zVvq8qiUZvhb94dHtK/WOtolMmTdqRfPj5YPLwl415f7vtKv9z1L4dVYs5Iwo8arBt8vAxP5Gm8v3J6q4A2ZZSwBm0NdBHu929ozSVFHgLW4/Nrycf5LDtOZhx+c+JFGzNIsrjtW0pFX5W4Qa0jUPzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB5899.namprd11.prod.outlook.com (2603:10b6:806:22a::18)
 by PH7PR11MB7571.namprd11.prod.outlook.com (2603:10b6:510:27e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 04:11:55 +0000
Received: from SA1PR11MB5899.namprd11.prod.outlook.com
 ([fe80::6bd7:dbbf:2a2b:66be]) by SA1PR11MB5899.namprd11.prod.outlook.com
 ([fe80::6bd7:dbbf:2a2b:66be%5]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 04:11:55 +0000
From: "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Devegowda,
 Chandrashekar" <chandrashekar.devegowda@intel.com>, "K, Kiran"
	<kiran.k@intel.com>
Subject: RE: [PATCH v1] Bluetooth: btintel_pcie: Introduce HCI Driver protocol
Thread-Topic: [PATCH v1] Bluetooth: btintel_pcie: Introduce HCI Driver
 protocol
Thread-Index: AQHcTVoqdIO29K+DrkuZ62JuiIRI/7TmTjQAgABJCgA=
Date: Fri, 7 Nov 2025 04:11:55 +0000
Message-ID: <SA1PR11MB5899A1CEDDA9213F2C20823CD8C3A@SA1PR11MB5899.namprd11.prod.outlook.com>
References: <20251104072222.195729-1-chethan.tumkur.narayan@intel.com>
 <CABBYNZJS3ewQ5EZN+7iZqS1BwUjC+j3GjT9xfy=vNWWf_K21vg@mail.gmail.com>
In-Reply-To: <CABBYNZJS3ewQ5EZN+7iZqS1BwUjC+j3GjT9xfy=vNWWf_K21vg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB5899:EE_|PH7PR11MB7571:EE_
x-ms-office365-filtering-correlation-id: 86079c07-70c2-43ce-d69a-08de1db3c9d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?MURkaW4yblRqd0QrVHpVYTlNWWZPYzdaQWI4SnJlWFF3cUVDMTNHRkpOSHRE?=
 =?utf-8?B?cnVhRHpDYkZBYWJMdWQxcnFSWUNOb25RdU8vTnVPbCtvdmdWQ3BmTGp3Z0NN?=
 =?utf-8?B?djJjN3FkLzkyK0Nlc2J4TUVRNVZyVGQrSVBVL01VNUppRUZxMStnV05sS0xL?=
 =?utf-8?B?OEZuNTI2WE1FTzZiYUJaR05wdGJYYk95eWpRd05QekxNTU5YRjRyVXBzdmJ0?=
 =?utf-8?B?M3Jyak00WXk1UDlZMTBjNThmVEVGSUlnVHVFRUZZR1R5eHNWc2d0YkozNGRL?=
 =?utf-8?B?dERKWXFSMVFpaDdNTmJvRExsL3V1ZXJCMUxrMm9zTkV6UWV4YnlxTmNkV3hI?=
 =?utf-8?B?MEVOSEVNSktYTCt0VVRhYWVSWmZ0K0dUN2FYTE9hYjhDc1JBNm5YZlRyZEo1?=
 =?utf-8?B?ZExyWXZkWjdKQnE1VjVJWC9kVWMxZ3RjbDNKbDF5cDVEa0syQy9FcENhN2pu?=
 =?utf-8?B?eTdOMldNTld5NzcwYzNiQm1Hb0Q4UndnZVcvcnJtWDRoQ1lRVzY0ZEdlbEZC?=
 =?utf-8?B?Slk5cmlaaDVXaGdhelp2bk5JZ2VGaldBb0NhMVJUN2RyOTduRjI2N25kSnpD?=
 =?utf-8?B?a3h4Y2NiOEpSTDZMK1ZzNnYycWttTzhNTllkVnE5VERoZEVaRTV6blV6MHNv?=
 =?utf-8?B?SWFIQ2NaYXptd3dyQmYzd3g5UXZGajJSdG81RHkzemJpcjI1cS9IdjZuVjMr?=
 =?utf-8?B?dzc1S3kwOWMrTzJkS3Z0YnVhbFFVZS8zSmliTzJkQ2VpZ05ROUlqSGdwbktK?=
 =?utf-8?B?bFlLbWllV0M0R3ZXMjhZbFg5bDVtQ2V6WXpXbUJtN0ZwNjhhbTlBTVZEODhu?=
 =?utf-8?B?b2tLd0F6cUZpK09jRGV2bFhIY2FaYVY5OUd6TWN1eTh1Z0g0OE5KTWpNM2pi?=
 =?utf-8?B?UnBLVXBDbWtqZDJNK2JIU0hSWXRNa05vZDBVcFRmaHpQdlhnTVZlaThFaTYw?=
 =?utf-8?B?NlExM3NFWGdHcFdneTVSVEJSaElLQ05uZ2N5am0vSytyZWptNjNhcHBzbmhM?=
 =?utf-8?B?OEFnQm9sTVA1MXI3LzJ2anVYUDJhaWpzOGVNaG0vemtiS0Y4NEN6bUVZRXhj?=
 =?utf-8?B?S0YwQWYvU2FPcUhaajJOaURNcW5HZ1M2NVNiZkcvNGpmUTRJRzR2dXBNbnZ0?=
 =?utf-8?B?Zko3bmNCb0dEclVWSkFIK29xVXVxQ3o1KzVkb3NmeWdTNDVGNzdNcUFSRFpn?=
 =?utf-8?B?dDNiVWRsRUdBY2hlVGQxL0Z3M2xueFZMTmR4NVVnMjFFZVhLSm5mZ3ZvWG9Q?=
 =?utf-8?B?N0ZmU25VdDYxMFpldm45S2FYbHkrUFFIbTZyMXRJVlJ2YWhoRmttcEdYMkNz?=
 =?utf-8?B?N215ZmR2RWFrM2x6OEJ1Ylh2SzdzeUxvaWZDWVlvWFBZY2VTd1I5WUp2UVBw?=
 =?utf-8?B?eVlCYkg1OHJzZkhzZUpjWFpWOXRwVlliMmRkN0JTVnpGNGZnSDlQWGRxNkph?=
 =?utf-8?B?cWx5bWF4RGpjbmZrNTdkMTR2czltcG9VYUFZZnZRdFJ0MUJzNUhnQmhHVlc2?=
 =?utf-8?B?YkpXN3drZERVQ3BXcklXSU1zRzVzSEN5clk5cElmdHk5MDJUaEkvTVZmd0pB?=
 =?utf-8?B?N1hMR1FkK05EVDJiOVFqelRYMHc1bWh6TFF4dkI3dHFaRnptbE5aVzNwd0cw?=
 =?utf-8?B?YzhxekRHQ245UjFIZG1aT1FsTFFydENGeFJXdzhPVTV3VzFObXg1anhLT2l1?=
 =?utf-8?B?VUY3MDFJUm5tZ2hVVStYNVYxR3pmUHR5c2hyY1Z0NlZWSWtzd1ZtdnIxVkxx?=
 =?utf-8?B?Tk03d3QxZXVCQVpqNzNGSE5nMUQzVkxRRHUybkI1SEl4cVVtZTNTMHRLcXpj?=
 =?utf-8?B?dUVRdWlKYU1HalVzY2NlOFlGUGVZSVZhUmU1VFlPQWZ3ckVOMzV5YzhyQnNW?=
 =?utf-8?B?K3lubXk5ZUdsZzhHTWQ4QTVmbWp1cm43NkVld0U4cngvZjFOK05YcFU3L0xS?=
 =?utf-8?B?VGplNndIYzJsSll1U2xXR0Zxdk1RemdLMmNyeW5RU3p4cUloci9qQnlraWdw?=
 =?utf-8?B?OEMzdGQwQy9SUUx5dGloOFdpTGVIUTc1QkdRYWQ2N0JCbDJHcGRFa1ozeS9P?=
 =?utf-8?Q?/7jQ8H?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB5899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzFXczZmM25yNzd6Z0dVYmRIWGdpaWZabTdNSEZVTWlhNWZ3eWZlR0NXM2RT?=
 =?utf-8?B?bkFKT3RnMS9PNFRwWE5hN1NEMlpQNmF5NzB4WkkvTjQwb1V6STJBWmV0WnRX?=
 =?utf-8?B?MGVyWDJlVmwwQ2RjTmVDZkRTTUhlblZHVFl6ekYrUVN4MVYvYkxKQXBmMEwx?=
 =?utf-8?B?UEh0UEZBOEtkdnEyYmR1dUM0M1hXTTEzVUVaTWR0NE9pdnZubGRpaHYrN0dx?=
 =?utf-8?B?enJ5QTNWVnRGNHpJZnB5N3NqT1FhTEMwODZ1TnpFSHlka0k0RkduMDFpUDht?=
 =?utf-8?B?R2lNZGJkYTdUYVR4TWNEYUNLMlNzZ1o3QXBFcXVyMXRWR280bjF0c2NOVHMy?=
 =?utf-8?B?RlVLQkxVdUFCVjNvcEFtcmtKSDRpSkRUdUVVNDhOeDU5Z3A2WWFxSGxJcFB6?=
 =?utf-8?B?aENqQkpFeU9MQ0k2UWlWZmRmTmxDMDZ3VzdGalA3MkRhUDlHS1IyQXJzUUZi?=
 =?utf-8?B?SExHQ1NkazR5N09hUDVZcUxmNWV2bmNpOFVPMWduYWRld0V2ODVEVzNyZ3dI?=
 =?utf-8?B?MU41ZWtkWlJpZEdpclNVVUhJcnVRL0JHb0tMVzJ6NUZBL2dRd3VoOE0vRjds?=
 =?utf-8?B?djJPYTBrSGl3L0w5RTVPWU0remxpbEdUWXhiV3VTWTIzRTBUcnpUS2l0NnhO?=
 =?utf-8?B?MWxFSk0raHdHejBzOWo5SnRFZ2VNWjFIRW1UbkJnNEdDd2ZPbTl6KzM1N0RQ?=
 =?utf-8?B?Q2ZVb1dNamFYT0lwTHIxMXh6azU2dXBiOUNFTzZaNXlTNE9waDFjcERvdGti?=
 =?utf-8?B?MVBIL1JhR2tYOEt6djh5WU1iT3BJN0JGVkpNR3ZrUXNwd25QMHhvei9FemYr?=
 =?utf-8?B?ZVhSN0psdGg4VytVcmNUb1dNZFN0aDFYSDl1TDdFZWRvekNlSDZzdEVQdHlP?=
 =?utf-8?B?R0poeDV2ZCtvVFNLSjNKVmNsd3BHT3FyY0pKV2JwRkF6NVZqR2VEUThxVWtL?=
 =?utf-8?B?Q2cxMXZDemM4MWZITTVIRjdCVW9lVE14cGdid1pkWVBUMk1SZDliRFc0b2ox?=
 =?utf-8?B?bng4N3l6cmhERlVXdkh6L2NiSU41eTJyWWdGVHlqRFE2ZWFwK1lTS2hlUlo1?=
 =?utf-8?B?eHMrOUVRVExLUm9DVzU2ZGlhQjYxTjk2YlVaUTVmNUw4VXNzbEpqYzJnb1dz?=
 =?utf-8?B?NjdKWFc4ZUVEcGpnSEdsMmZQWmVBd1p6SGg0RjJWOGZEbHBpd0xLakV1cTVi?=
 =?utf-8?B?QTRBOEozeFBNaTFDRGJwa2d1T2lDL0ZCS3dJb1NidVNwNjVQaWhIRWhMU1pt?=
 =?utf-8?B?dWtWeTlPR1YwOWNkMmlKMHBjM01CMlJUQk5rRFhqSXp1ZUZmQWlHeWZSbmJV?=
 =?utf-8?B?NGd6S21lOEgrV1JlUml5QlR1UXJ5Skp3Ti9xSUZ2Q1h2Tk9tcTYyR0JiSTZv?=
 =?utf-8?B?N0FSWnNadGxZK1BSZ2hJQ1djaHBYSWlrTzBPc09SeU42cFcyZDliR0xHQkRR?=
 =?utf-8?B?UEwyaFh3MXVldFllYk9Sbk10clFQazhDWkRRWlRkdzU2ekFJMzZIM0pIZk1o?=
 =?utf-8?B?K0Y5TmM2NnBERTVnUDVjcGpGRWNEL2V3RTNaUEd4akI4SXd0RlNSeVdxWW5x?=
 =?utf-8?B?aHkyRUJuU0J5OEFrbzJiRm1qWG5uQUxhN2MxK1FrVWkrQXNmbi9Fd1RBeXlv?=
 =?utf-8?B?bjNuMWdJL2pCSStTRUxQTWNLUzQybzhWTWpUYXB2Yng1UE85cDdWUnJrWmdx?=
 =?utf-8?B?SFZBRWszVGlrVisxRStDWU9pUmYxakIzT2xtZFVxNXU2bml0RGNnTEtjRWtK?=
 =?utf-8?B?ZWNWQStYU25Wem5TOUN5b2ErOU9jek1MTFh4cWhjSEtqZFh5ZDV1NnVzWE4v?=
 =?utf-8?B?d2NTUEFhaXRiMUs3MlJ4UVl2OURCelZzNlc1M04wQ2ZIZDVXOS9ZZ0dGQ0Nm?=
 =?utf-8?B?RGRzNlNVK3gySUZRai9yckVFYmxEclBWR2JCR1BKeGlmV2ZCdmZ5RklxR2V0?=
 =?utf-8?B?MWEyUlRMNXc0VDQvRzNsUjJYU3V5d3ptbEVIWFhESnE0SFJNU1pVT1A3MEoz?=
 =?utf-8?B?Wk81Q0QrZ20yOUk2SFFlMGhZMnB1N2tJbWVSR2R6SlhOYnc2U1pieC9yWCt2?=
 =?utf-8?B?c0N0VmFvTmovTDJvMm1SSlFBU3JjcFJzQXBuMXlkTXpGekx4SXZzRkcyRXZY?=
 =?utf-8?B?Wi9GUEd3Uit5VGpRLzUzZm44eUhkdVpuS1A1MWRqaHZIeDNmY0Jqb0NNa3NP?=
 =?utf-8?B?cVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB5899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86079c07-70c2-43ce-d69a-08de1db3c9d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2025 04:11:55.5937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zll+Hoy4W5OYURfmGhz5SiX+JfxovszBqAZEdCyW9EACrNHGeoMaOkYdtWitYBqYMuC5SWZKng90gs5C/oX00gwVevAnd0WJ5AmvbmgwJgsgKfFDwrAqt/ut0cdNDrUB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7571
X-OriginatorOrg: intel.com

SGkgTHVpeiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWl6IEF1
Z3VzdG8gdm9uIERlbnR6IDxsdWl6LmRlbnR6QGdtYWlsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBO
b3ZlbWJlciA3LCAyMDI1IDQ6NTQgQU0NCj4gVG86IFR1bWt1ciBOYXJheWFuLCBDaGV0aGFuIDxj
aGV0aGFuLnR1bWt1ci5uYXJheWFuQGludGVsLmNvbT4NCj4gQ2M6IGxpbnV4LWJsdWV0b290aEB2
Z2VyLmtlcm5lbC5vcmc7IFNyaXZhdHNhLCBSYXZpc2hhbmthcg0KPiA8cmF2aXNoYW5rYXIuc3Jp
dmF0c2FAaW50ZWwuY29tPjsgRGV2ZWdvd2RhLCBDaGFuZHJhc2hla2FyDQo+IDxjaGFuZHJhc2hl
a2FyLmRldmVnb3dkYUBpbnRlbC5jb20+OyBLLCBLaXJhbiA8a2lyYW4ua0BpbnRlbC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjFdIEJsdWV0b290aDogYnRpbnRlbF9wY2llOiBJbnRyb2R1
Y2UgSENJIERyaXZlciBwcm90b2NvbA0KPiANCj4gSGkgQ2hldGhhbiwNCj4gDQo+IE9uIFR1ZSwg
Tm92IDQsIDIwMjUgYXQgMjoxMOKAr0FNIENoZXRoYW4gVCBODQo+IDxjaGV0aGFuLnR1bWt1ci5u
YXJheWFuQGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBUaGlzIHBhdGNoIGFkZHMgdGhlIGlu
ZnJhc3RydWN0dXJlIHRoYXQgYWxsb3cgdGhlIHVzZXIgc3BhY2UgcHJvZ3JhbQ0KPiA+IHRvIHRh
bGsgdG8gaW50ZWwgcGNpZSBkcml2ZXIgZGlyZWN0bHkgZm9yIGZldGNoaW5nIGJhc2ljIGRyaXZl
ciBkZXRhaWxzLg0KPiA+DQo+ID4gVGhlIGNoYW5nZXMgaW50cm9kdWNlZCBhcmUgcmVmZXJyZWQg
Zm9ybSBjb21taXQgMDQ0MjUyOTJhNjJjMTUNCj4gPiAoIkJsdWV0b290aDogSW50cm9kdWNlIEhD
SSBEcml2ZXIgcHJvdG9jb2wiKQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQ2hldGhhbiBUIE4g
PGNoZXRoYW4udHVta3VyLm5hcmF5YW5AaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJz
L2JsdWV0b290aC9idGludGVsX3BjaWUuYyB8IDU5DQo+ID4gKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDU5IGluc2VydGlvbnMoKykNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuYw0KPiA+IGIv
ZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmMNCj4gPiBpbmRleCBiMGFkM2M3NTllZjUu
LjdiNDcwMDJmYmE3NSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2JsdWV0b290aC9idGludGVs
X3BjaWUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5jDQo+ID4g
QEAgLTE5LDYgKzE5LDcgQEANCj4gPg0KPiA+ICAjaW5jbHVkZSA8bmV0L2JsdWV0b290aC9ibHVl
dG9vdGguaD4NCj4gPiAgI2luY2x1ZGUgPG5ldC9ibHVldG9vdGgvaGNpX2NvcmUuaD4NCj4gPiAr
I2luY2x1ZGUgPG5ldC9ibHVldG9vdGgvaGNpX2Rydi5oPg0KPiA+DQo+ID4gICNpbmNsdWRlICJi
dGludGVsLmgiDQo+ID4gICNpbmNsdWRlICJidGludGVsX3BjaWUuaCINCj4gPiBAQCAtMjM2MCw2
ICsyMzYxLDYzIEBAIHN0YXRpYyBib29sIGJ0aW50ZWxfcGNpZV93YWtldXAoc3RydWN0IGhjaV9k
ZXYNCj4gKmhkZXYpDQo+ID4gICAgICAgICByZXR1cm4gZGV2aWNlX21heV93YWtldXAoJmRhdGEt
PnBkZXYtPmRldik7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IHsNCj4g
PiArICAgICAgIHUxNiBvcGNvZGU7DQo+ID4gKyAgICAgICBjb25zdCBjaGFyICpkZXNjOw0KPiA+
ICt9IGJ0aW50ZWxfcGNpZV9oY2lfZHJ2X3N1cHBvcnRlZF9jb21tYW5kc1tdID0gew0KPiA+ICsg
ICAgICAgLyogQ29tbW9uIGNvbW1hbmRzICovDQo+ID4gKyAgICAgICB7IEhDSV9EUlZfT1BfUkVB
RF9JTkZPLCAiUmVhZCBJbmZvIiB9LCB9Ow0KPiA+ICsNCj4gPiArc3RhdGljIGludCBidGludGVs
X3BjaWVfaGNpX2Rydl9yZWFkX2luZm8oc3RydWN0IGhjaV9kZXYgKmhkZXYsIHZvaWQgKmRhdGEs
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdTE2IGRhdGFf
bGVuKSB7DQo+ID4gKyAgICAgICBzdHJ1Y3QgaGNpX2Rydl9ycF9yZWFkX2luZm8gKnJwOw0KPiA+
ICsgICAgICAgc2l6ZV90IHJwX3NpemU7DQo+ID4gKyAgICAgICBpbnQgZXJyLCBpOw0KPiA+ICsg
ICAgICAgdTE2IG9wY29kZSwgbnVtX3N1cHBvcnRlZF9jb21tYW5kcyA9DQo+ID4gKyAgICAgICAg
ICAgICAgIEFSUkFZX1NJWkUoYnRpbnRlbF9wY2llX2hjaV9kcnZfc3VwcG9ydGVkX2NvbW1hbmRz
KTsNCj4gPiArDQo+ID4gKyAgICAgICBycF9zaXplID0gc2l6ZW9mKCpycCkgKyBudW1fc3VwcG9y
dGVkX2NvbW1hbmRzICogMjsNCj4gPiArDQo+ID4gKyAgICAgICBycCA9IGttYWxsb2MocnBfc2l6
ZSwgR0ZQX0tFUk5FTCk7DQo+ID4gKyAgICAgICBpZiAoIXJwKQ0KPiA+ICsgICAgICAgICAgICAg
ICByZXR1cm4gLUVOT01FTTsNCj4gPiArDQo+ID4gKyAgICAgICBzdHJzY3B5X3BhZChycC0+ZHJp
dmVyX25hbWUsIEtCVUlMRF9NT0ROQU1FKTsNCj4gPiArDQo+ID4gKyAgICAgICBycC0+bnVtX3N1
cHBvcnRlZF9jb21tYW5kcyA9DQo+IGNwdV90b19sZTE2KG51bV9zdXBwb3J0ZWRfY29tbWFuZHMp
Ow0KPiA+ICsgICAgICAgZm9yIChpID0gMDsgaSA8IG51bV9zdXBwb3J0ZWRfY29tbWFuZHM7IGkr
Kykgew0KPiA+ICsgICAgICAgICAgICAgICBvcGNvZGUgPSBidGludGVsX3BjaWVfaGNpX2Rydl9z
dXBwb3J0ZWRfY29tbWFuZHNbaV0ub3Bjb2RlOw0KPiA+ICsgICAgICAgICAgICAgICBidF9kZXZf
aW5mbyhoZGV2LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAiU3VwcG9ydGVkIEhD
SSBEcnYgY29tbWFuZCAoMHglMDJ4fDB4JTA0eCk6ICVzIiwNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgaGNpX29wY29kZV9vZ2Yob3Bjb2RlKSwNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgaGNpX29wY29kZV9vY2Yob3Bjb2RlKSwNCj4gPiArDQo+ID4gKyBidGludGVs
X3BjaWVfaGNpX2Rydl9zdXBwb3J0ZWRfY29tbWFuZHNbaV0uZGVzYyk7DQo+IA0KPiBEbyB3ZSBy
ZWFsbHkgbmVlZCB0byBwcmludCBvdXQgdGhpcyBpbmZvcm1hdGlvbiB3aXRoIGJ0X2Rldl9pbmZv
IHJhdGhlciB0aGFuDQo+IGJ0X2Rldl9kYmc/IElmIHlvdSBsZWZ0IGl0IGp1c3QgZm9yIGRlYnVn
Z2luZyBtYXliZSB3ZSBjYW4gY29tcGxldGVseSByZW1vdmUNCj4gaXQsIGluIGZhY3Qgd2hhdCBJ
IHRoaW5rIGlzIG1pc3NpbmcgaXMgdGhlIHNlbmRpbmcgdGhpcyBzb3J0IG9mIHRyYWZmaWMgdG8g
YnRtb24gdG8NCj4gZGVjb2RlLCB0aGF0IHdheSB3ZSBkb24ndCBuZWVkIHRvIGtlZXAgdGhpcyBz
b3J0IG9mIGNvZGUgaW4gdGhlIGtlcm5lbC4NCj4gDQpBY2ssIEkgc2hhbGwgbW92ZSB0aGUgcHJp
bnQgbWVzc2FnZSB1bmRlciBidF9kZXZfZGJnLiANCg0KPiA+ICsgICAgICAgICAgICAgICBycC0+
c3VwcG9ydGVkX2NvbW1hbmRzW2ldID0gY3B1X3RvX2xlMTYob3Bjb2RlKTsNCj4gPiArICAgICAg
IH0NCj4gPiArDQo+ID4gKyAgICAgICBlcnIgPSBoY2lfZHJ2X2NtZF9jb21wbGV0ZShoZGV2LCBI
Q0lfRFJWX09QX1JFQURfSU5GTywNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIEhDSV9EUlZfU1RBVFVTX1NVQ0NFU1MsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBycCwgcnBfc2l6ZSk7DQo+ID4gKw0KPiA+ICsgICAgICAga2ZyZWUocnApOw0K
PiA+ICsgICAgICAgcmV0dXJuIGVycjsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0
IHN0cnVjdCBoY2lfZHJ2X2hhbmRsZXINCj4gYnRpbnRlbF9wY2llX2hjaV9kcnZfY29tbW9uX2hh
bmRsZXJzW10gPSB7DQo+ID4gKyAgICAgICB7IGJ0aW50ZWxfcGNpZV9oY2lfZHJ2X3JlYWRfaW5m
bywgICAgICAgSENJX0RSVl9SRUFEX0lORk9fU0laRSB9LA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAr
c3RhdGljIGNvbnN0IHN0cnVjdCBoY2lfZHJ2X2hhbmRsZXINCj4gPiArYnRpbnRlbF9wY2llX2hj
aV9kcnZfc3BlY2lmaWNfaGFuZGxlcnNbXSA9IHt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIHN0cnVj
dCBoY2lfZHJ2IGJ0aW50ZWxfcGNpZV9oY2lfZHJ2ID0gew0KPiA+ICsgICAgICAgLmNvbW1vbl9o
YW5kbGVyX2NvdW50ICAgPQ0KPiBBUlJBWV9TSVpFKGJ0aW50ZWxfcGNpZV9oY2lfZHJ2X2NvbW1v
bl9oYW5kbGVycyksDQo+ID4gKyAgICAgICAuY29tbW9uX2hhbmRsZXJzICAgICAgICA9IGJ0aW50
ZWxfcGNpZV9oY2lfZHJ2X2NvbW1vbl9oYW5kbGVycywNCj4gPiArICAgICAgIC5zcGVjaWZpY19o
YW5kbGVyX2NvdW50ID0NCj4gQVJSQVlfU0laRShidGludGVsX3BjaWVfaGNpX2Rydl9zcGVjaWZp
Y19oYW5kbGVycyksDQo+ID4gKyAgICAgICAuc3BlY2lmaWNfaGFuZGxlcnMgICAgICA9IGJ0aW50
ZWxfcGNpZV9oY2lfZHJ2X3NwZWNpZmljX2hhbmRsZXJzLA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAg
c3RhdGljIGludCBidGludGVsX3BjaWVfc2V0dXBfaGRldihzdHJ1Y3QgYnRpbnRlbF9wY2llX2Rh
dGEgKmRhdGEpICB7DQo+ID4gICAgICAgICBpbnQgZXJyOw0KPiA+IEBAIC0yMzg2LDYgKzI0NDQs
NyBAQCBzdGF0aWMgaW50IGJ0aW50ZWxfcGNpZV9zZXR1cF9oZGV2KHN0cnVjdA0KPiBidGludGVs
X3BjaWVfZGF0YSAqZGF0YSkNCj4gPiAgICAgICAgIGhkZXYtPnNldF9iZGFkZHIgPSBidGludGVs
X3NldF9iZGFkZHI7DQo+ID4gICAgICAgICBoZGV2LT5yZXNldCA9IGJ0aW50ZWxfcGNpZV9yZXNl
dDsNCj4gPiAgICAgICAgIGhkZXYtPndha2V1cCA9IGJ0aW50ZWxfcGNpZV93YWtldXA7DQo+ID4g
KyAgICAgICBoZGV2LT5oY2lfZHJ2ID0gJmJ0aW50ZWxfcGNpZV9oY2lfZHJ2Ow0KPiA+DQo+ID4g
ICAgICAgICBlcnIgPSBoY2lfcmVnaXN0ZXJfZGV2KGhkZXYpOw0KPiA+ICAgICAgICAgaWYgKGVy
ciA8IDApIHsNCj4gPiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQo+ID4NCj4gDQo+IA0KPiAtLQ0KPiBM
dWl6IEF1Z3VzdG8gdm9uIERlbnR6DQo=
