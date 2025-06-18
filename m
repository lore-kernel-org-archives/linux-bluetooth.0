Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A193F2D12F6
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 12:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750250029; cv=fail; b=IUY/D7cTiG6MgKd0kNuYdmGbVf/mn4bEwyx/cCA5yNkfXFfX2z3dZNNypGJrh5pRGho3XUdJLt+Kjpak0sgUzRNWrMt3cwq0jCs3Uuv0auNLs6gNTNzohrI9YLVkS93OsMyUp3CpXc6gqBG+BiLy2bmGCo9cip9Fn1xE+dYn2bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750250029; c=relaxed/simple;
	bh=bHqG0ISgH28EBSL8uQ4IH8FLi/AqAwiecRKKry6c1UE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UH8FclYxXz8X+FBv7bbhFUK9KmDdZfePXDN6s+fanCD6467Se2NiOwbwMDENvGFO8Vh9756d/c2Bp/yXOnHRBAMZzMotLLo9not8ciwqEziQ8zIVHI6aQB8fNHrEkfeehXrtsdQ5Kw4T6tF03CVFdcnJxZ2e0VUauGGfhyfVx9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V/lcM7Qn; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V/lcM7Qn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750250027; x=1781786027;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bHqG0ISgH28EBSL8uQ4IH8FLi/AqAwiecRKKry6c1UE=;
  b=V/lcM7QnSEQV4axhqNnC48IIzTP+0eklMdMHDcOt8DsufQN7HZz/1Vge
   IMf8X26ZmnDmkVWwTUeVcJfI99i3l+TNUc2J4unGdNuN7wkTaLSp3RKB3
   644GWyQpr0dZPHQ6WsTwAnqpgskQ4HPQTL66cXmmbtdZSldhj2lOm96kB
   gST5gXpY7YiB8z+P9ld5TAVcWUFvPQzMAAknZa2Hb/YkuyblWpc00j/9O
   kEhsODWm+q+LMyd1w7INebMqy9+wk+5piQK/8sWMfIPGlqE9iZnlUWV60
   TwswdgehPdYha9LXDhhcKLu2f80bFlMK4ceMk4heQZh/WdlENGbmw7DE3
   g==;
X-CSE-ConnectionGUID: WLNoYpxqQPmYVpA/F36c3A==
X-CSE-MsgGUID: OyQyHyR9Sj+yVEvHAw2l5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="77872302"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="77872302"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 05:33:46 -0700
X-CSE-ConnectionGUID: pEEV6S1kTrKdo38paYz3/Q==
X-CSE-MsgGUID: Wp6RhGGWSd+7mElMxwq+eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="149374735"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 05:33:47 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 05:33:46 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 18 Jun 2025 05:33:46 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.63) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 05:33:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w86yrbc857k3Cfp5ojXYqwxr/voo4KP/IrygSD3UiwPDV1E9ZdgYdXGHLtSHTqolm14A4+WN/Yi/NcHph9WNFHkLytyU+ehdFRlsMfuOuvsKaA+cCshzEz3oAt/KV5fp9hOBGwDasKyBXeRH8lHegrmslyLmOVU9Z7smtazjyj0fjtXLr8TOSQiWwTwFxapCnFDroNaitYuUABqZLj1vo4bZ+BH9QL72M4lKve9MrJdChWf1Je+38I0Ch2VgZtzzs4ZpghStucGY0dSH1QMxDQ2FwWxMHRAOtGKisQVafXoMgfe8e1ywkh4Dd1NdyVFbPLDMBrkY1OPCFcaDYEWjUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHqG0ISgH28EBSL8uQ4IH8FLi/AqAwiecRKKry6c1UE=;
 b=LGkDBXrONb3xyRYgxBkMI0CNk7uW9kspAEHKamDuaBbdxjBVJ2km+6JPM4X7hCoWVZoyEyV7LminPql/dG4o1wVHXq7ZaZCx/W6IDFqlymgqHvUS68BddNmeU80JnxQbPri86dmsZSUeEBjdhB3ktr9Vcoq9SUF+x7aVS9riAPNXKYNCHcy/Cv3JtPP14wuIKDo2BZVpuA7e+GYm1omh1vIJEWMQslcMpQST32Uw5oHvG6Jk+/Y+AlgnKtEXZSKyssVUThxWR/750y7U8dUNRkk3oORtPYpcffuvgPzOZ1q9u0meGJGUcFWTNMY9eAbFRAgRsUmjc7GUpV80dgMrLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by MW3PR11MB4570.namprd11.prod.outlook.com (2603:10b6:303:5f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 12:33:29 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%5]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 12:33:29 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, "Devegowda, Chandrashekar"
	<chandrashekar.devegowda@intel.com>, Aluvala Sai Teja
	<aluvala.sai.teja@intel.com>
Subject: RE: [PATCH v1] Bluetooth: btintel: Add support for BlazarIW
Thread-Topic: [PATCH v1] Bluetooth: btintel: Add support for BlazarIW
Thread-Index: AQHb3tkouzOQmUNMzEKpC3U8oU9xNrQGOoaAgAKhUjA=
Date: Wed, 18 Jun 2025 12:33:29 +0000
Message-ID: <PH0PR11MB758512FB4EABB9E4DA97D6ADF572A@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20250616162633.756567-1-kiran.k@intel.com>
 <8b3aac45-3698-4016-a83d-efaf50ee28d6@molgen.mpg.de>
In-Reply-To: <8b3aac45-3698-4016-a83d-efaf50ee28d6@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|MW3PR11MB4570:EE_
x-ms-office365-filtering-correlation-id: 81d35219-d4fd-44c4-d4b2-08ddae645454
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Vk5CbnJrZG9seUI2S3B3ekJBSDdFT2R5aWMyMFBudG5POVoydktRa2M4cDlr?=
 =?utf-8?B?OWxwYmIrSzV0YlhDS3d0SHA3cTMwSTJIK3dZamYxUUdOM0RaNkhoaFFpdmJP?=
 =?utf-8?B?SzlWcXc3c1pTL1E3cjFtUmJFa1Mxd09yY2FiSnJpbnFyaVNyZW9TbGJoOFhu?=
 =?utf-8?B?MzA3N1FKN2lkOHRMV2VETXhYeCtvT0pDMHk2aERXT2FIRC9xbWJyZzE5dXg5?=
 =?utf-8?B?YTIxZHNPeXVGdnB4VUdzZ2YyYnAvYUhrOWh2a05SZE0zNXB5VDBYak1GeUVF?=
 =?utf-8?B?UHFmRGtYOEJubHVLNjNHT0JvcXlSdlBIR1hQVnkyak1zd3grb1c1UDlEUDRJ?=
 =?utf-8?B?WDZscE1OZHF2TmhSQlhNUExjakMrUko2VDd4SUh3NXFueUdPOUN0TlJpc1hy?=
 =?utf-8?B?VElVbWlheDM4ODNySTgyM0tzR3J6cWdzb0x6ZmVUWFhxeS9uN1ZkOVNRaVp3?=
 =?utf-8?B?YjZBbUgzc2NvamtKYjVjL2srMG9DWmIzd1NPMkorbHd6cVZVL3V3MitYMEhz?=
 =?utf-8?B?MXFqSDlmSlhSOVd3cVMwd0k3OTZHbzZmbU5HTndEdTQyY2srOHBFZUdiRVpY?=
 =?utf-8?B?amIzQ0FFYlRmendic0U1c2VHOGV3ektwT0hCWlFIZ2UzZ21vdG52dzJhZ3E3?=
 =?utf-8?B?cERsVEkrSTk0dGNSUVlGRUdhNkg2WHpNMTJmbUV5R1E4R1N4d3YyOWZxR2hH?=
 =?utf-8?B?cWhiSm0raXYwUXQ1c2xEdi9BYWdYZmZuSUlpMU8vOWRXOFh4SjBCcUg1MFZu?=
 =?utf-8?B?a3AwUXRkc3hhQUNEcjlhRzNVOEFxS0N6N1M1V3NCbkZFQXRLUVhUcWYvM0lp?=
 =?utf-8?B?anZacnFIb0s5U1Y3UDlnWHZVbTg5WUoybzQxSVc2U3FOTW1pK2ZDbHpNLzAv?=
 =?utf-8?B?a01KNkhvY21tQjhiTENHM0Q5b0J2ZC9TOUZwNlpWTDFPaW1PYXFYZFFDMmc4?=
 =?utf-8?B?SzJSUlJITzExd3VVRUFQYTVMZzdkdG1EcVhVYWZRc0x5a1RUUE9RU3hZZVps?=
 =?utf-8?B?bDhPanNRZm90VW83bExNNFEwcGdPcUNaWlEwaSs0WFJPK0lxakJaenZDT3hL?=
 =?utf-8?B?SVZidVZwcVYwWHpVV1lUNHhHenJZa0x0a01pVHE3SFQ0ZXc5blkrQW05QkhT?=
 =?utf-8?B?cmZLblJMRFpBV3lrU2IxSFp0dWl1UnpWOTZBelRlVEpnVzIxVWRYcEo0cUxZ?=
 =?utf-8?B?SlZvY0k4Q0RWdkFOK29PYUlEOWQzZHpkenIxK3hya1N2R0NzU21yTWo2YXNO?=
 =?utf-8?B?Z05NZGRCM3Z6VGZ4QUx0c0ZVNG0wd043WFdGQndZYytRelBNbENEUFdadVM5?=
 =?utf-8?B?VzNuUFA1ckRxR1pJSkNTdlZDcDJ0cnNCT0FKOGtxRWkxRTNqQ3JHdnlhbTlG?=
 =?utf-8?B?ZmlPc2llR0JnMS94eDFMZWRHbjRzUnBMNWkra2J4QTJjeW9CT3Jta3hjMzhR?=
 =?utf-8?B?L3pyNkt2WjB2WnRRMEtFWWdPd1pMK3pvTmkvREhEelEweld5dGdvY3JsQzht?=
 =?utf-8?B?SUtVVjBxbGo1bWgzdDhKZ25qNFlHREsrZVVTcWFMcWF2MTB6Q2xPbi9RVVdW?=
 =?utf-8?B?bURGdS8yRVpmR1ZCcjlRSFVuU2N3TkpQS0ZIN1IvT25renhITFMvRG5IYTkv?=
 =?utf-8?B?NURRdHZlbU5jUlRzOEhtY2hqK2N2dTZ4ZXZDSnpxb09JRjBZRUhFb094ZTFm?=
 =?utf-8?B?OFpZMk0xMnI3ZDQ1NkgrUEJDVHhLTmZnN2wrQ29ORVZob01IUUIwNFhyNzBP?=
 =?utf-8?B?Mm4rUVpaY3FtbVhxbEg5NkpxREFVdCthcmJLdlErNm8vcnRNMFRxOVE4aHZW?=
 =?utf-8?B?MkNheFRxVzArQ1Y3ZmcvR1NZRU1ZcE5oRnFOQjFMMWZWY3hONEc5ZzNGVE1X?=
 =?utf-8?B?Zmt1NCtlT0lIcWljZE9jNEVBU09wU0MyVTBoVHNkb2F2QytOYjNrcHdmWkNp?=
 =?utf-8?B?MmZNOEI5emRSSFJUUjJVcFFXZTNoVUFEeHQrVVNWYk90eW53N1Q1Vi9ocE5G?=
 =?utf-8?B?YjdyQndpR1d3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THdVL0ZZVDFLK3hJZzBhTnRSYmdXNWZxTTN6cVpXWGJ4dGJpKzBrZzVuT3Er?=
 =?utf-8?B?dzlkMkpRendpWXRCVEtKSGF0T2ZPSEV4QkdPbkdob1dSd2V0RmJUN1RxMzBN?=
 =?utf-8?B?dkg4bnBPZmxDcFYwNlRqSjhINTZzYU9yTmIyVnpNK08yYkxUNzNiSFdmWTlG?=
 =?utf-8?B?cjhuV1d5Q3VDU3RVQjJrRmIxWEJqbEJYR0dkZDR2ZW1BMDFWTnlNZkdGanpC?=
 =?utf-8?B?Vm9uZG8vV1FkbGtoR005ZGdBQ2FESDdaSzZoYnNhQnpsdUxORzFnc3RySDZ4?=
 =?utf-8?B?WlJvVXo4bHpRTFNrU3pwVzJ2UVdIcmZjalM4d0NkT3g0ckE0Y0Z2K0JJdzdN?=
 =?utf-8?B?ZHhxRi95eXBNWHFua1JkMGJYM1hUaGZQdTErQ2tJTEo4NXYyMGFJeFNJVENM?=
 =?utf-8?B?a3BmUElPM210djIzYmtjbzQrNDFGSWtFQlRiWi8zSVdOTkNweGFBTkNkaWF3?=
 =?utf-8?B?QUxxZmZjSFdHRmNCaWNKTW4rVzM1OWYwRlpNUTQ1WTRQYnZtMmJkTVFkanZY?=
 =?utf-8?B?cVYyVTFGd1gxOWdyUUJQTXBScVd5TXRXODB3ZHZwblRFbU1mbEhVMGdsNERp?=
 =?utf-8?B?S0FmdjQ1eXhnajRhUXVEdlJ2bmJjUUhWcWVYU3ozTE5mZHQ3czNlcXo0RWt6?=
 =?utf-8?B?VUhhTUFDLzA3Y2VxYkhZdDBtNTRHa0gza3NNQ1VQeTF0VUhRSW56OG5FL01x?=
 =?utf-8?B?d3JlSDlJcVd0Y2FHdWZuOFlMR3ZrSENxWmpkVDFkajRxQ2sxZGZKazlpMXhl?=
 =?utf-8?B?N1IxTmpFcy9pR1YzTXVpOGdRbThVYlNlenRnRkN6M2kvbFhtbXBUZHpiSGhY?=
 =?utf-8?B?aDVYVjhzcGpRdWhFMTZCVnJLdWtYM2NOSnMrRm1Oa2xwalVyaElkelp0ODhW?=
 =?utf-8?B?Y245d2RjY1d2YWtsakNnN1RYcEVIRkhka01BdmJYelZYNGhGTzlmZHdmaVpK?=
 =?utf-8?B?NDE4RWlhZ1NmeS8vQVlzR2xKN0FjMDIySWFBMnRsN0k0dGI3S0k3RkpRWVBE?=
 =?utf-8?B?Yzd3bjkvektMMnp5UE5GV2xhbW9QTDZISXVFbUtaYjI4dVp3cjV4cUxpczBY?=
 =?utf-8?B?aGtJTzVOZDMraXFGNmZFbjZ2bzNpcEVJbU81VzZrd1pVMSt5Y1B5eUp1QnpB?=
 =?utf-8?B?ZUNXRWV6M1VzWTl2V1JwSGlNck5tTlBSdDEvd1lScHVQQUJXSFNldUxIUEoy?=
 =?utf-8?B?ZUdZSUNHYzJBeDBFZFk2c1JUWlRaS3B6dTV0Yjd1QzBGNVlpa25mbFdOeFNu?=
 =?utf-8?B?RFgyd0Nqb3JCUXVnTXA2dkdpSHIyaUtCYkxMRFZ3bDJIVjBaUWJoNS8wUGw3?=
 =?utf-8?B?cVNXMzNaQWtsQnNBcmRrclV5NDBXWFZVWnpBWVJYRy9xTk9ZbGQzSmpmZkg0?=
 =?utf-8?B?OGdRMjBFMmhJRDRXRzdCUExSOUhackN4d3lvZTM4bG51ZU84YWxMeTdxL29z?=
 =?utf-8?B?WDBDeEF2QXVEYmVMdmxLQ0xubG9sMVA1MVl3MlpxVThuZW81NE83MCtqT214?=
 =?utf-8?B?UVRBN09hYTdqSkFoNXRoUTBvUlpQR2dhU2N5UExLeGxrWFk5QnVtVm9xaUZP?=
 =?utf-8?B?cTBlVk5wWWgvL0hYcklWaU5QVGlWcy9wZ29ObEhLYnkvTXpvSmtMdFZIUXo4?=
 =?utf-8?B?TkVyRWdsUmRwaEdqdXc3VmpFV3QrbXNWUmtMK2hnN2U1WS9ZWGFhWFpyUWor?=
 =?utf-8?B?NXZGNnBLajFwNVdzUGpRS0R4WWgxc2tQaXowd3ZDZVZJWjljRnIyQmRibE5y?=
 =?utf-8?B?aEV2ZU5ycUl3M0ZWdWtCVklzbmJRL0JDaXFKVHJNUVZLajh0akV2Y0hKSEJy?=
 =?utf-8?B?UFhSdmdiOFVKcnNJTUZqaXFqVGU2KzBzOUtBTnhWdFcva240bXhnYXhXeG5B?=
 =?utf-8?B?dWZxWWFQa1UxL2dwQ1RsR1hhU2tyQWdoQUkvSlBPTUdxNkNwTjV6MUFEMVJy?=
 =?utf-8?B?VHZUTHNyUEtraGFoQUJLY1dtZnZWeTUzVHA0WVBFRHpLeVA1NVcreXFuTVpT?=
 =?utf-8?B?Ui84SXpNWVVvcCs4MEIwekJQWHpuZnZnL1A5STJtQ1JhaVpnWTcvNlI3dmcz?=
 =?utf-8?B?azVNeTRHMDh2M202ZnNaaStUQ1JlNEkveVZoNlEyOUNlZzRKZnYwbTdmSXph?=
 =?utf-8?Q?Rg+o=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d35219-d4fd-44c4-d4b2-08ddae645454
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 12:33:29.1092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +hl1Q7S26KXQYINC7/uE44hsXtMbHSXwQsms0JmAFqyw+/xOdhZOXpo6V1Kmb1X8oi7jdLguzT+6v/0MqWitEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4570
X-OriginatorOrg: intel.com

SGkgUGF1bCwNCg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KDQo+LS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj5Gcm9tOiBQYXVsIE1lbnplbCA8cG1lbnplbEBtb2xnZW4ubXBnLmRlPg0K
PlNlbnQ6IFR1ZXNkYXksIEp1bmUgMTcsIDIwMjUgMTo1MSBBTQ0KPlRvOiBLLCBLaXJhbiA8a2ly
YW4ua0BpbnRlbC5jb20+DQo+Q2M6IGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmc7IFNy
aXZhdHNhLCBSYXZpc2hhbmthcg0KPjxyYXZpc2hhbmthci5zcml2YXRzYUBpbnRlbC5jb20+OyBU
dW1rdXIgTmFyYXlhbiwgQ2hldGhhbg0KPjxjaGV0aGFuLnR1bWt1ci5uYXJheWFuQGludGVsLmNv
bT47IERldmVnb3dkYSwgQ2hhbmRyYXNoZWthcg0KPjxjaGFuZHJhc2hla2FyLmRldmVnb3dkYUBp
bnRlbC5jb20+OyBBbHV2YWxhIFNhaSBUZWphDQo+PGFsdXZhbGEuc2FpLnRlamFAaW50ZWwuY29t
Pg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjFdIEJsdWV0b290aDogYnRpbnRlbDogQWRkIHN1cHBv
cnQgZm9yIEJsYXphcklXDQo+DQo+RGVhciBLaXJhbiwNCj4NCj4NCj5UaGFuayB5b3UgZm9yIHlv
dXIgcGF0Y2guIE1heWJlIGZvciB0aGUgc3VtbWFyeS90aXRsZToNCj4NCj5CbHVldG9vdGg6IGJ0
aW50ZWw6IEFkZCBCbGF6YXJJVyBUTFYgaWQNCj4NCj5BbSAxNi4wNi4yNSB1bSAxODoyNiBzY2hy
aWViIEtpcmFuIEs6DQo+PiBBZGQgc3VwcG9ydCBmb3IgQmx1ZXRvb3RoIGNvcmUgLSBCbGF6YXJJ
VyBvdmVyIFVTQiBhbmQgUENJZSB0cmFuc3BvcnQuDQo+DQo+QSBzdGF0ZW1lbnQsIHRoYXQgb25s
eSBpZHMgbmVlZCB0byBiZSBhZGRlZCwgYW5kIHRoYXQgc3VwcG9ydCBleGlzdHMsIHdvdWxkIGJl
DQo+bmljZS4NCkkgd2lsbCBhbWVuZCB0aGUgY29tbWl0IG1lc3NhZ2UuDQoNCj4NCj5BbnkgZGF0
YXNoZWV0IHJlZmVyZW5jZT8gRG8geW91IGhhdmUgdGhlIGhhcmR3YXJlLCBhbmQgd2VyZSBhYmxl
IHRvIHRlc3QNCj50aGlzPw0KU29ycnksIEludGVsIGRvZXNu4oCZdCByZWxlYXNlIHRoZXNlIGRv
Y3VtZW50cyB0byBwdWJsaWMuIEkgYW0gYWJsZSB0byB0ZXN0IHRoaXMuDQoNCj4NCj4+IFNpZ25l
ZC1vZmYtYnk6IEtpcmFuIEsgPGtpcmFuLmtAaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgIGRyaXZl
cnMvYmx1ZXRvb3RoL2J0aW50ZWwuYyAgICAgIHwgMyArKysNCj4+ICAgZHJpdmVycy9ibHVldG9v
dGgvYnRpbnRlbF9wY2llLmMgfCAxICsNCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlv
bnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5jIGIv
ZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5jDQo+PiBpbmRleCA1NWNjMTY1MmJmZTQuLmY2ODA1
MDI3YmUwYSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYw0KPj4g
KysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5jDQo+PiBAQCAtNDg0LDYgKzQ4NCw3IEBA
IGludCBidGludGVsX3ZlcnNpb25faW5mb190bHYoc3RydWN0IGhjaV9kZXYgKmhkZXYsDQo+PiAg
IAljYXNlIDB4MWQ6CS8qIEJsYXphclUgKEJ6clUpICovDQo+PiAgIAljYXNlIDB4MWU6CS8qIEJs
YXphckkgKEJ6cikgKi8NCj4+ICAgCWNhc2UgMHgxZjogICAgICAvKiBTY29ycGlvdXMgUGVhayAq
Lw0KPj4gKwljYXNlIDB4MjI6CS8qIEJsYXphcklXICovDQo+PiAgIAkJYnJlYWs7DQo+PiAgIAlk
ZWZhdWx0Og0KPj4gICAJCWJ0X2Rldl9lcnIoaGRldiwgIlVuc3VwcG9ydGVkIEludGVsIGhhcmR3
YXJlIHZhcmlhbnQNCj4oMHgleCkiLCBAQA0KPj4gLTMyNTMsNiArMzI1NCw3IEBAIHZvaWQgYnRp
bnRlbF9zZXRfbXNmdF9vcGNvZGUoc3RydWN0IGhjaV9kZXYgKmhkZXYsIHU4DQo+aHdfdmFyaWFu
dCkNCj4+ICAgCWNhc2UgMHgxZDoNCj4+ICAgCWNhc2UgMHgxZToNCj4+ICAgCWNhc2UgMHgxZjoN
Cj4+ICsJY2FzZSAweDIyOg0KPj4gICAJCWhjaV9zZXRfbXNmdF9vcGNvZGUoaGRldiwgMHhGQzFF
KTsNCj4+ICAgCQlicmVhazsNCj4+ICAgCWRlZmF1bHQ6DQo+PiBAQCAtMzU5Myw2ICszNTk1LDcg
QEAgc3RhdGljIGludCBidGludGVsX3NldHVwX2NvbWJpbmVkKHN0cnVjdCBoY2lfZGV2DQo+Kmhk
ZXYpDQo+PiAgIAljYXNlIDB4MWQ6DQo+PiAgIAljYXNlIDB4MWU6DQo+PiAgIAljYXNlIDB4MWY6
DQo+PiArCWNhc2UgMHgyMjoNCj4+ICAgCQkvKiBEaXNwbGF5IHZlcnNpb24gaW5mb3JtYXRpb24g
b2YgVExWIHR5cGUgKi8NCj4+ICAgCQlidGludGVsX3ZlcnNpb25faW5mb190bHYoaGRldiwgJnZl
cl90bHYpOw0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2JsdWV0b290aC9idGludGVsX3Bj
aWUuYw0KPj4gYi9kcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuYw0KPj4gaW5kZXggY2Iz
Y2YyYjlhY2VhLi4xMDA0MjY0MTI4ZTMgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2JsdWV0b290
aC9idGludGVsX3BjaWUuYw0KPj4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2ll
LmMNCj4+IEBAIC0yMTM3LDYgKzIxMzcsNyBAQCBzdGF0aWMgaW50IGJ0aW50ZWxfcGNpZV9zZXR1
cF9pbnRlcm5hbChzdHJ1Y3QgaGNpX2Rldg0KPipoZGV2KQ0KPj4gICAJc3dpdGNoIChJTlRFTF9I
V19WQVJJQU5UKHZlcl90bHYuY252aV9idCkpIHsNCj4+ICAgCWNhc2UgMHgxZToJLyogQnpySSAq
Lw0KPj4gICAJY2FzZSAweDFmOgkvKiBTY1AgICovDQo+PiArCWNhc2UgMHgyMjoJLyogQmxhemFy
SVcgKi8NCj4+ICAgCQkvKiBEaXNwbGF5IHZlcnNpb24gaW5mb3JtYXRpb24gb2YgVExWIHR5cGUg
Ki8NCj4+ICAgCQlidGludGVsX3ZlcnNpb25faW5mb190bHYoaGRldiwgJnZlcl90bHYpOw0KPj4N
Cj4NCj4NCj5LaW5kIHJlZ2FyZHMsDQo+DQo+UGF1bA0KDQpUaGFua3MsDQpLaXJhbg0KDQo=
