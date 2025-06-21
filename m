Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6C34690
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Jun 2025 06:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750486990; cv=fail; b=HGKXqA2u3Dir+6PCyq3ALzND8rH0pLLAXMLzPv4TuCxiWAZopQi+MieRLBDk4DNjzqqW3RNM+AavdvAIx/tTjkor3IhbegDUtM16wgovVE6foqwTR4GwlpZDbd0rcXdI5YdV53xOBBGq5Ud6BEoXweU9zlxwaQCUprRAXkVSMT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750486990; c=relaxed/simple;
	bh=iHxUBNE4x8BvGMroKhTiyc11y4TMF/XWZ8dJHPpCFQk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MgD/Ccs0F3guBZwrlrZGHB8d8unTLyf9S42BM6Vw0CboF9Sl8zsP6ys/pySs2GSOmIcZxQFY/aRWvuKeYCRQ71QeB0n6MGq30Or0CSKpNUB3SwypeomNkRCfO1fcLLFaXPyCF84RMP9FU9mhdOvCdRqnraFT/YXafExTTLoSncQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LbTf+FDd; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LbTf+FDd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750486988; x=1782022988;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iHxUBNE4x8BvGMroKhTiyc11y4TMF/XWZ8dJHPpCFQk=;
  b=LbTf+FDd/mHWQB0pQZIeVJ1CHpm8D1S0/zSyOcw3gIRB7yplXcZHJH2l
   QRuCwzKitx183ASufe2xzigrMlsEVLha8w+x9vOR+QSvi+QhtcALoHfmY
   PIkBaQcAd0dst2fQGq3rEQ2Fq0SUYAq9gcyWaA3Zni+7k0J+0QLnNOCnU
   2JCbYjtDNIJBoHda1oTPo2FcT94Z8yeIXrPpv7TMr/IdnEa9c/0CYJGv5
   fJlsecM75OlPF3IGAU5keMk89j+D/tkVUcfDPnw5Vy+gEHrlLd5Mzx3DV
   jzTGkszmnjuAI6a+YlORWlvrlISrM+sTCOOCFCy/10rUxlIKxmMgTCPt+
   A==;
X-CSE-ConnectionGUID: n2z5fNQHSQyvvWi6b1oZKA==
X-CSE-MsgGUID: Sz31/vncTxul2LCCB42eog==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52624637"
X-IronPort-AV: E=Sophos;i="6.16,253,1744095600"; 
   d="scan'208";a="52624637"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 23:23:07 -0700
X-CSE-ConnectionGUID: Axr2PMTkR5KrHq/u1X+g/w==
X-CSE-MsgGUID: EffajztvTu2ZgfYul9gMVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,253,1744095600"; 
   d="scan'208";a="155654317"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 23:23:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 23:23:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 20 Jun 2025 23:23:06 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.42)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 23:23:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hMaoq4dG42/Qe9Ai8ZnDmxyW6yyRXICqxq7yDLecbNeIV/QHlDrtgiRWyOsxD5/jX3CGS8AuhuJVrpHMx4sTosz3dnly+t3ZnC7MELdKL4Xu+hyJv+VE4b6kmoX6gp/nN4v2fWX8K2ubI/Fl5EvHFJ+kbLoMYpZljErt8BcINn090lT6k1olYF1iUOioXHBzG5wWW69BBUjeLaH0H1gnwJS21bhycDVrB1l143VDhIyyi5eApuQDqWaby8MKXXdTvgWz28xrg0maj2hGyO32kjURmdyXkHjS4nATX2JdQ+83MIN3mCUUO+HN6fvzYN00E6lfQpcjDDPyHayNmn2NHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHxUBNE4x8BvGMroKhTiyc11y4TMF/XWZ8dJHPpCFQk=;
 b=yZSoGaUv8rWXvvIM3Pog52MFDvzAaVg0h+qXTTtIXvy3fQLmz6xVe5C4ae22hxUHku264m5b0lJPrdJ//rnq1CLL5xPdsWFMvYDw0BK+Lqa/WpoafdcaemVvdAlzSKUJII+xZvxAVO5xhWjYwwBeQkmLUuYu+iEoDX3UGHAnPm7eb2fTywEonPQLRd4QCUHyipiFsOYtiZtTMv+n+nmcpHQRl6XJxQPBZ+PyyPY6owzto+UgM6sXxaWayL5JvhP4r6YwonDH3ml4RUCrVC6UFJSvH2/ALdioA4/84+YEY69JeYTzsXWgdKTSrNM22z71qKIrVxMLHyJWGzkcYX7aoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by DS0PR11MB8018.namprd11.prod.outlook.com (2603:10b6:8:116::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Sat, 21 Jun
 2025 06:22:57 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%5]) with mapi id 15.20.8857.019; Sat, 21 Jun 2025
 06:22:57 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, "Devegowda, Chandrashekar"
	<chandrashekar.devegowda@intel.com>, Aluvala Sai Teja
	<aluvala.sai.teja@intel.com>
Subject: RE: [PATCH v1] Bluetooth: btintel_pcie: Add support for device 0x4d76
Thread-Topic: [PATCH v1] Bluetooth: btintel_pcie: Add support for device
 0x4d76
Thread-Index: AQHb4E8C/UY6/+VdV06A6HitS3pb4LQI6q+AgAADF4CABDsZoA==
Date: Sat, 21 Jun 2025 06:22:57 +0000
Message-ID: <PH0PR11MB7585A2CE5D7671ED7D1E3FF1F57FA@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20250618130251.774085-1-kiran.k@intel.com>
 <CABBYNZJf9wGcQSR9PPH9RfvrpRYtm_HScmVV6iBQOYwBowMk6A@mail.gmail.com>
 <1eaa30e8-3a4e-4ff4-8fc8-07e3a25aa443@molgen.mpg.de>
In-Reply-To: <1eaa30e8-3a4e-4ff4-8fc8-07e3a25aa443@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|DS0PR11MB8018:EE_
x-ms-office365-filtering-correlation-id: 21985655-e288-484c-bf0b-08ddb08c104a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cjA0LzRmbkdIVnVYYUkrdU1Ic3FUdW9aK21LanVyMWFLVmc1NHQ0VnQrcHJZ?=
 =?utf-8?B?WGszSXVQNWVhOHBHaUh6RWJaNjNERW9rK0tTQVorY1ZWQ015YkpURDVRU0F6?=
 =?utf-8?B?NHNUWkZIeTh5U05hNEMvcG1ad0c5US9PcjhZMXV3eERXT2RkSk9sWGwxbC9X?=
 =?utf-8?B?Tm1razJTTzBwa3lFVmZmUmQrKzRDcllFV21OQjF5ME9qMitEUStmd3JMem1O?=
 =?utf-8?B?RXNUdXVQc1lwdGRVOHk0ZFVOVjRUczVuTDFQMnRLNnY3WEQ1b01tQzAzNEph?=
 =?utf-8?B?eXduaE9ORkc2Q3h5UzdyRTVJYlE4Z0szdUt6Z0ZiRXVzd1ZQZ2JlNTdLWCtZ?=
 =?utf-8?B?K0NIZVpQY0FpTlZPbEFBMndsSytKaEd5WHdLSkNNMXFsUTg0c3VLR2tqOFRW?=
 =?utf-8?B?dGFuRkZIU1UyR3lUak5QTmN1N1JhdnZFclV4Mnp3N3FKdGlpQU5pckxoZ1lo?=
 =?utf-8?B?NDlhaldiKzlWaUZVVFBMTkluZHJRQ29rSWRWM1piQUZkZ0VIYkY4eUN3TTRQ?=
 =?utf-8?B?Z1Ewby91WTRYeCtYUzdjaVZTNSs0NXVrWGwvM29uZEVTY3NZM0dQd1BJWFJ3?=
 =?utf-8?B?b00wRnp0VmVZTGw5dUNjVnBQcC9lckljeHVHSXh0bVBWMUdkeURnR0FaQ09E?=
 =?utf-8?B?bENzYWp5dDJQYkxpajZwNkxkZnJZTmxTbFY3SjIwYTAwV04rVEc1T005OGlW?=
 =?utf-8?B?RFNDbnE5TGlYSUMzVkhoOEhwbFlKZnZyeUplZDBlZWN5QmpSMkorVDJvYzVo?=
 =?utf-8?B?eU9udk1PRVFQQ0g1WlR3Z3B1cm1OLzJtd1g4Wjk3amRuZVE1ZjVJbjNzRnlL?=
 =?utf-8?B?SjlLNDdzSU1lbkdZd0pqTlJQSEs5ajlyc3F3ZmFoaUx6eUsrVzBNRTU4T1N0?=
 =?utf-8?B?QTUzWGJ1TWtUYkE2QzZhUzdhMGUxT1RrUHNtcE1FcGZRTG9SZnRLeGh5RnpB?=
 =?utf-8?B?QVNrWU9mOUxOY090QUQ1bGd5ZFV2UzdDQ0d4L2FhNTZ1a25QdDZ2WnZQMXVu?=
 =?utf-8?B?MzVoOUtDNGgrbE91ZXh6NlFMRk1nZkRkbk8vQ2xxdWQwSVN6RmJsUkVhOU5m?=
 =?utf-8?B?aldpSk5IRW4zR1dHeDlFbzNaYmxWS1E0bWFKYlJTV2QyN1UvZWZGR3pCa1g5?=
 =?utf-8?B?NW9Rd2xOKzhGNE9oVHpoNEtxaFcwcXpGdEEwNUY1MUk4UWJyckVaT3Nmd2tF?=
 =?utf-8?B?VTZjbjdRU1hYRHdWWlpkYWpWalJ4YkV2WElGbjU2MHdIbWh3dDJQdHE3RmF1?=
 =?utf-8?B?VHErWTNWUXBoa0Q5eWdXT1J1dG1hc3c3ZWhZOXF6YWsvQlBWYUpVMWRTcURw?=
 =?utf-8?B?d1BqZThJbWRpZHE5YWFCVGJjTEJPVGcvNU1NcEZFQmpjSkcrTlIyUjNLSDgy?=
 =?utf-8?B?clFTRXFoU0hiRXFTRU45K0FRYU4zTlVGZW9qcTBzcnhRZmlXY2VVTjJiOENP?=
 =?utf-8?B?M1ZlcmY2Z1gydkx2NldpdHM1SCttZ2JqOCttWHdKOHV2OURBSkFkdHZpWG5o?=
 =?utf-8?B?b1pEclNTanBJd0lzSjVQSEhOK1hvT0JBQWlhdXN6dHQ5OFo3RytUcmxZZFZm?=
 =?utf-8?B?V0FWRVk5eTc0Q2RKYWpudmRTdXFMSEd4WDFCVzc0TU1HREUvNUlhMVNtQ3NV?=
 =?utf-8?B?K21qdStpYUxNdW5qVWZBUkI2K3FTMU1NUGlyTmlHTFNiZ0lSMEgzemZ0Tkpi?=
 =?utf-8?B?OVhsaVpNaW1KdDIwcjZveDJVUzVUblEvQkVpNk9kN21Ocm1Fbms2amJMOUhM?=
 =?utf-8?B?aFFncDBsRzdLTUVYOFljMkY2NEFhOFpBTGpqK3VYZXNJbUhQcC8rSnFOS0t3?=
 =?utf-8?B?YUg5bnRoTEQvRE1sWG1GUGk0Nm1aQnkrT2JuRmFIclZKWC9LQTcvMzBUNDl6?=
 =?utf-8?B?L3NnRmtzY01FdGVvUnRpdlFsY29hTlBvWTRXOHI4WlhidnkxRVpXWEFQR0Nu?=
 =?utf-8?B?SVNuL2RtUFptZldZOXBPaTFkc0x0UkI4aUcrOUIyeCtvSnQ2K2tkUE41bSto?=
 =?utf-8?Q?LhFMV5ETIrTWVJYwHzV62M9Ckq43ak=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkwwM0ZlS1pJWFVGQTg3VWdxQXJpdEJ6RFNic0FIOXQzUzJRd0tVc0hHdXdB?=
 =?utf-8?B?dUxidWpwbExBUWU1bDVzVkJQZXpPREtjaDZoTFJTT1VLRGtUckJpOWk3TXJ3?=
 =?utf-8?B?TEUwUjRHODhXSURzRm9GTVlSTXRoeGpYSnZyVjNiTW9nMFc4dEhDMEE2WlE2?=
 =?utf-8?B?WkUwSmNOK2xkVU1KZUhxRGFPWTd6TTkvL1RGaDZJRytJam5WazlTVjgxNXR1?=
 =?utf-8?B?S0VzL3VSU3JLL0lUak02Y3EvMTE0SkEzMEl5d25JK0NlZHdRU0Y5Qy9wTUto?=
 =?utf-8?B?MklUY1ZNLzFrTjkyTnBRQ2liNzdLU0x3U212OXEyUytaUHhBL29hanFyQUt2?=
 =?utf-8?B?NEFwTmlJN3YwQ3JtbmJZL3VyRE1TUnYxSFU0cXZYb2JPb2tyKzFtcnU5YVlC?=
 =?utf-8?B?ai9KRjlrUnc1cHA1VkhORnhaZGV3L1cxaGhNU3FOam5mSUcxQ2NQTUNncGhv?=
 =?utf-8?B?N2k5REZSdXVoeHN5dmJNTS9QWk41YUQ2U3EwaEZ5eDR1bkJTZnJrUDIwTDAw?=
 =?utf-8?B?bFdtamhRb0JDOEZyK0o4TEhKem1JaE1FUHJSOWNOUnV3Tytici82OFB5M0lj?=
 =?utf-8?B?NVpCS2d4K3VCb3RuUjU5Wjd6dEJQL0JtK2lUWG1kN1BKMi9HdWExNk5BQjFt?=
 =?utf-8?B?Q1dZUEtsZlNLY3NzMnlucG0rbUZwQllPWHVwWHFrcFY4Q1JvWEFlN0ovbGR4?=
 =?utf-8?B?L1FvRG9lVC8xL1dldWJLeng3bTRNdUFqUnU1ZXdkVkp0ZFRqcTdJeU5lRUpJ?=
 =?utf-8?B?ZXRXMWFSTzNYTUw2Wkk3SVMzNFpPMjdONDJpNXN5alZLSHhhQno5SGdCRFdr?=
 =?utf-8?B?WDdOVmFnWU00TTk3aWJVQXVoeTZXMlF6YytkZUgyUjlEWEdvVm5oaDJFU2Q0?=
 =?utf-8?B?bzY1U1hKNzZFUmdRN1JvM0VCb0M5a0VuV21qTkVJdG5pMWlRUzErSlZrNXJX?=
 =?utf-8?B?ZmRiQ1dDejMvMHlOdFY0UmRjcm5XTVlpNFhSemlWWndFakpielNsVDBXWXRO?=
 =?utf-8?B?RTVic2I0UFVWejE3ZW5wRmtUaEF1MlJiMEp5QnNBMjFvbmdmM1ByYkpnZkR3?=
 =?utf-8?B?emJEUGt0L1U2elBzOUVZeW1SZlMzRDFFWGpncTFXbjlTUDR2dGUyZ0ViZ09p?=
 =?utf-8?B?WERzY0t0Y1ByaFpTLzJoaG1nKzlEc3RVY2Rha3dHVzJFNGllMlZkN3h0TFJy?=
 =?utf-8?B?Z2ZEbFZmaDc0ODFCTE1oZVZVOW1BSzFEOXZ6NVFhYm0wMFFVbVZoSHd1UDhr?=
 =?utf-8?B?Y3ZyMFZic0lTbkZqeEpjSmpwQjBNM2dTNXdXN2hnTnh5VTZibHJvWFZGcHZP?=
 =?utf-8?B?QWlOcmNCa3JqZmpEQkhNN1ZtOEtrVWVycnljcTFEN20rdDBweHA3RWxvYWhQ?=
 =?utf-8?B?NDFEYU4vOW1xUVBQTlhPNUJNZk1sTG5ZVFh2UStUZ1N2d1BFd1Nta0FXSWgr?=
 =?utf-8?B?SVNlNXh4Qy9sSEFtL2ZFUnh2V1hES1hPZktwQWE2U3o5dldiU1pZcytMT3RQ?=
 =?utf-8?B?WVhpbC9wdVpad0JMZlBHOFBOYlc4TkNRQ09Pd0p1OE4wWmJnUWV4ZjN1U0pa?=
 =?utf-8?B?OE5QYU9MZmVWV3RCRVhCcEVicmlsaGNnblFiSWEvMWt3dGJvcXNvMitUMWwr?=
 =?utf-8?B?RGd4dU9ka2lSdnZYbEwzMUhaaDduUUZkdG53ZEIxN09aWGhiYk5QMytldFFS?=
 =?utf-8?B?Qkt5U2hldEp0M2Fzd1R1SHRCcUVUVkp5MDVNOE50bE1Ua3czNHlLR0t0V3NL?=
 =?utf-8?B?elNUYU4vR1hYaEtJOUxpT1hrR1lHbUlJa21sWVl1OTZwWG9SdlFGWitBcVQr?=
 =?utf-8?B?ZXREL21vREVETFdXSzVsL1QyWVhIRjgxOVdZMjRPYUxLVzRiUCtNK3FsbVR6?=
 =?utf-8?B?UU40WG9PN0dENWxkaGRQK0QwTkNQdi9FaUZHbDNMYWxiSlllWithZlVhRnhC?=
 =?utf-8?B?QzBHSTFWeldwejdQbzViOUpxYVR1VHBjVnZlaXl0Tk5yK1NhTkdGNEsrK3Ft?=
 =?utf-8?B?c0ZPZHNvSWd6OFpBY2pZb2g1K21lb0RxeCt4ZG1DbHpQOEpaSmZ0dXRWeDc3?=
 =?utf-8?B?SmQrZ0k1cWR5RVNSNkZFMW9MRG0vcnVaVXUxS2NiN2pEYzQzS2JBdkRob2Uv?=
 =?utf-8?Q?Pkgo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 21985655-e288-484c-bf0b-08ddb08c104a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2025 06:22:57.1371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yCipGXPSvbcoYgEi0JtrA2oWd7D/ooilF+BkiN+50nuPRhEi/ehLvwq4tkj+aHGlQ8iDenp5lG5ecbiZNHzyDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8018
X-OriginatorOrg: intel.com

SGkgUGF1bCwNCg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjFdIEJsdWV0b290aDogYnRpbnRlbF9w
Y2llOiBBZGQgc3VwcG9ydCBmb3IgZGV2aWNlIDB4NGQ3Ng0KPg0KPkRlYXIgTHVpeiwgZGVhciBL
aXJhbiwNCj4NCj4NCj5BbSAxOC4wNi4yNSB1bSAxNTozNCBzY2hyaWViIEx1aXogQXVndXN0byB2
b24gRGVudHo6DQo+DQo+PiBPbiBXZWQsIEp1biAxOCwgMjAyNSBhdCA4OjQ24oCvQU0gS2lyYW4g
SyA8a2lyYW4ua0BpbnRlbC5jb20+IHdyb3RlOg0KPj4+DQo+Pj4gbHNwY2kgLXYgLWQgIDgwODY6
NGQ3Ng0KPj4+IDAwOjE0LjcgQmx1ZXRvb3RoOiBJbnRlbCBDb3Jwb3JhdGlvbiBEZXZpY2UgNGQ3
Ng0KPj4+ICAgICAgICAgIFN1YnN5c3RlbTogSW50ZWwgQ29ycG9yYXRpb24gRGV2aWNlIDAwMTEN
Cj4+PiAgICAgICAgICBGbGFnczogZmFzdCBkZXZzZWwsIElSUSAyNTUsIElPTU1VIGdyb3VwIDEy
DQo+Pj4gICAgICAgICAgTWVtb3J5IGF0IDEzMDEzMzI4MDAwICg2NC1iaXQsIG5vbi1wcmVmZXRj
aGFibGUpIFtkaXNhYmxlZF0NCj5bc2l6ZT0xNktdDQo+Pj4gICAgICAgICAgQ2FwYWJpbGl0aWVz
OiBbYzhdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAzDQo+Pj4gICAgICAgICAgQ2FwYWJpbGl0
aWVzOiBbZDBdIE1TSTogRW5hYmxlLSBDb3VudD0xLzEgTWFza2FibGUtIDY0Yml0Kw0KPj4+ICAg
ICAgICAgIENhcGFiaWxpdGllczogWzQwXSBFeHByZXNzIFJvb3QgQ29tcGxleCBJbnRlZ3JhdGVk
IEVuZHBvaW50LCBNU0kgMDANCj4+PiAgICAgICAgICBDYXBhYmlsaXRpZXM6IFs4MF0gTVNJLVg6
IEVuYWJsZS0gQ291bnQ9MzIgTWFza2VkLQ0KPj4+ICAgICAgICAgIENhcGFiaWxpdGllczogWzEw
MF0gTGF0ZW5jeSBUb2xlcmFuY2UgUmVwb3J0aW5nDQo+Pg0KPj4gSXNuJ3QgdGhlcmUgc29tZXRo
aW5nIGxpa2UgL3N5cy9rZXJuZWwvZGVidWcvdXNiL2RldmljZXMgdGhhdCB3ZSBjYW4NCj4+IHVz
ZT8gRm9yIGluc3RhbmNlIGxzcGNpIGRvZXNuJ3Qgc2VlbSB0byBzaG93IGFueSBpbmZvcm1hdGlv
biBhYm91dCB0aGUNCj4+IGRyaXZlci4NCj4NCj5UaGUgc3dpdGNoIGAta2Agc2hvdWxkIHNob3cg
dGhlIGRyaXZlci4NCj4NClRoYW5rcyBmb3IgbGV0dGluZyBtZSBrbm93IHRoaXMuICBJIHdpbGwg
YW1lbmQgdGhlIGNvbW1pdCBtZXNzYWdlIGFuZCBwdWJsaXNoIHYyIHZlcnNpb24gb2YgdGhlIHBh
dGNoLg0KDQo+Pj4gU2lnbmVkLW9mZi1ieTogS2lyYW4gSyA8a2lyYW4ua0BpbnRlbC5jb20+DQo+
Pj4gLS0tDQo+Pj4gICBkcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuYyB8IDEgKw0KPj4+
ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmMNCj4+PiBiL2RyaXZlcnMvYmx1ZXRvb3Ro
L2J0aW50ZWxfcGNpZS5jDQo+Pj4gaW5kZXggY2IzY2YyYjlhY2VhLi4xMTEzYTYzMTBiZDAgMTAw
NjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmMNCj4+PiArKysg
Yi9kcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuYw0KPj4+IEBAIC0zNSw2ICszNSw3IEBA
DQo+Pj4NCj4+PiAgIC8qIEludGVsIEJsdWV0b290aCBQQ0llIGRldmljZSBpZCB0YWJsZSAqLw0K
Pj4+ICAgc3RhdGljIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkIGJ0aW50ZWxfcGNpZV90YWJs
ZVtdID0gew0KPj4+ICsgICAgICAgeyBCVElOVEVMX1BDSV9ERVZJQ0UoMHg0RDc2LCBQQ0lfQU5Z
X0lEKSB9LA0KPj4+ICAgICAgICAgIHsgQlRJTlRFTF9QQ0lfREVWSUNFKDB4QTg3NiwgUENJX0FO
WV9JRCkgfSwNCj4+PiAgICAgICAgICB7IEJUSU5URUxfUENJX0RFVklDRSgweEU0NzYsIFBDSV9B
TllfSUQpIH0sDQo+Pj4gICAgICAgICAgeyAwIH0NCj4+PiAtLQ0KPj4+IDIuNDMuMA0KPg0KPktp
bmQgcmVnYXJkcywNCj4NCj5QYXVsDQoNClRoYW5rcywNCktpcmFuDQoNCg==
