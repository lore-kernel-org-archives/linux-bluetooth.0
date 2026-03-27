Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CC23BE166;
	Fri, 27 Mar 2026 12:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774616309; cv=fail; b=PSJ7C5h4N7cEJQs8Nb31EY1uLEM3YsIYYylgDfJmVVGbRvsBGIqHn4C1C/Dg4pat7jMcylMCvSig8vehNbYhffHB33ZnIWbeN6AbSLq08QT5IMDlzY9OKh1EhKyEcySUTYuI0iYg/5pLBBcAso1Le0DdmioXu55osBfcIXkWZz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774616309; c=relaxed/simple;
	bh=Ekxo4/Y8ii7HIO7EqeyAAXMmQjn2j/qrr8BPl2l8hwA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iXvSY9GkS9DqrKNBb9sw1cxlnbyyTapX8KOwkbtM5ineqirETqGlHMZA9L1dfCRCMg46k/R1m1sfQ+y/r6ONijiQPZhf3sjtGYDa/fj5ipIwRQ4kpo+DbsvCy2jwMAmgdnZh74jpNF+68U8xi0qbZYjAmmMNvyL77NT4IF5dq4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PxbRzIlj; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PxbRzIlj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774616305; x=1806152305;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ekxo4/Y8ii7HIO7EqeyAAXMmQjn2j/qrr8BPl2l8hwA=;
  b=PxbRzIljkmvfm0Y2dwOx11qTSZjtgsYQSMJ5kxWHkns5aG/q+c4XIVba
   b/NXfvoJpTLQoQJBuBsqEPix0jq2+8UH+xl4coHRDiMIMVDX6HSYyRfW3
   mwGtvBusfslqzX5nmD+4cgIxxz70wf37JhK0xFrONJy9fgDum6e7CGVLg
   aDjNVBQ+GkDcgual5nxKOkXc3gAe+snuKa/jcIVgjchvm3hQoTOYkXEk0
   qtkYvm7zpTwyBI/SQ5h09k6+QUpL5x63LUKpHhWGs8qsJelj3TTy+B5m/
   xVwpTN63PVMM8yZFpWNDgt0iLM3BVahc4CfpGPKGKdneYj2yxzyslMrwk
   A==;
X-CSE-ConnectionGUID: 7Ih87zGMRFSphOaO1gv7Rw==
X-CSE-MsgGUID: 9eVn3w+VTPutoH3fdf0d7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="79288934"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="79288934"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 05:58:24 -0700
X-CSE-ConnectionGUID: X8AYlLpGQlSvtzuwHcN3xQ==
X-CSE-MsgGUID: JrzFAWFLTZ+gWf2Og/qAkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="224345923"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 05:58:24 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 05:58:22 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Mar 2026 05:58:22 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.16) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 05:58:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2gV8BNQgCFsQvapQFolkevxkzHESGcP9f7w7BEEVhk5JcO0ag5N4790Hh0SHnsgeJgxIYDpA/v5dMu6foPBCVibM5YKPF6NJBC/v7FkNHBIE2maVu1rjItx+ZELUxwKD6vaDMFCruby9ZO7ORx7lrSx0RKbbyuAE2fDtXOZKzCFrdsRei2dwVYAaj/3vUWn0HgXr7k5diysQ4w/I5DdDtJP50Gdo+3I7wi9tccUaxmxOH26YfvW2Hzxlxqnu5I6GSM4etGXTu4FaR5X1EFixS8ZiFYaya2NxrhFwe86P8RYShn7WviXXHQL1V8kgYP8+vyXOih8/7oVpwshP4NjIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ekxo4/Y8ii7HIO7EqeyAAXMmQjn2j/qrr8BPl2l8hwA=;
 b=MOkv28ZwLoK+WpdsF8cp+Zmej+5nnN7MoCHeOk+PjQslKF2VgRg9QCqGpKGv/2UOZvKBqfE8DNWKDzPZlTw4NvGZ6RAad+QLAUWYYATEuKGT2srqvWt4BVI77cuqG+kxqv+1HiiJKBr6lNSgiwE91vxo7px+S1U9Y9PmrAcpEm38cYykkt4NGFNFnGh4EBlr/9e8lK6HGvGpK6SdatQDSUyBGTLQk+Xtb0YfcyJJ5i7vV+bdmuIXzpN5XKdKXj76SFEYAU+fa4XMzfqFQSEz/duQpYtfnrXCVhhaC37bIVzIrLBPQR9zz3z2DSUvRAuHSAwAZwHHe9E1ZNOWVEAg2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by PH0PR11MB7562.namprd11.prod.outlook.com (2603:10b6:510:287::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Fri, 27 Mar
 2026 12:58:19 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::3e58:d5d:4e05:885e]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::3e58:d5d:4e05:885e%3]) with mapi id 15.20.9769.004; Fri, 27 Mar 2026
 12:58:19 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Pengpeng Hou
	<pengpeng@iscas.ac.cn>
CC: "marcel@holtmann.org" <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Srivatsa,
 Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan, Chethan"
	<chethan.tumkur.narayan@intel.com>
Subject: RE: [PATCH] Bluetooth: btintel_pcie: validate completion ring indices
Thread-Topic: [PATCH] Bluetooth: btintel_pcie: validate completion ring
 indices
Thread-Index: AQHcu200PgcnpEIPDkCgGbnBSztIDbW9x5GAgASShXA=
Date: Fri, 27 Mar 2026 12:58:19 +0000
Message-ID: <PH0PR11MB75851C79259453EA057A8A06F557A@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20260324085143.74785-1-pengpeng@iscas.ac.cn>
 <CABBYNZJs5swzc7tGdDZbG0a-tFpHGB_y4Yq6G_+4+984+4joyg@mail.gmail.com>
In-Reply-To: <CABBYNZJs5swzc7tGdDZbG0a-tFpHGB_y4Yq6G_+4+984+4joyg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|PH0PR11MB7562:EE_
x-ms-office365-filtering-correlation-id: bebda4bb-754d-49ec-bd54-08de8c008534
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: SepuRfsN0ecZoTQu7pG0tRHLfKitlhyHwhDCkxaQMDLlD96qKSOWMbw5HmgwmyzYnxWYzmHc3GbynjGNNZN/q8+jYjGLzOaAXPpI2J6ZoYaPMwygq5qCm7AaRUqxvZWfIOK4JkLlCbqsbCEKURfTzN/0dAqODsouR9AchXsRw7PcEA+xSq04vL4CMHzXihFVQsOOhnLgGcTDFvLcXT91l16LU9LjxaQ/PAfUSGuDR5Ocl0e4Ns7FLz4GB9kU7GYhVSak91ILecv8j9nwzg/Sv1viDeVt6yOpcCHBpKC1LHBMwd07Grx1l3J2hB5WUUv2Ayjn/RCeiaATuYrJL2L2Nyga5iKe+U957tayiPcpyRjjS+2py0zrt0T6j8mlnntFJRw+qS2YGQ/rkVnqgs/t7CogIMQCfumDEGpAQteM90DBteVlZEQt7yr/wiv4yvQ8bdvjA7lsTR8n7fShOfvgbBkgwDxIAcpWPmLlUvakSiaG7IlNX3N+L+DxrH3P0B5c9k7zx/SpYoRLQMcVVoLKkfulBK3weMYfFUH1Cg93cc9UrmgoDMU1bWhayFjsiTatXxiCpCEKsxjSi+22fXshasBorZLba8nrA3irom9YQHePb/3G1H/Lx/zUKiLHei0/0swV3WtZf9n8fOI5/x3uCO/lr/0hBcjdZ1/XgOSzRZ69VvnttpfbdH8uKBIKzA8DWgeDDcnJ12g+iTusGi+zBS0rozHLgEEmJZzwD0eT2VQJMKeJ/b9EZO3yp1Tz9JexLaK+pZf036IJJdVzPY3bqknmRikIBa7T2uUP3vS4vIk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUVWSmh1d2pEb2lENjlNaUdobGI2RG81Wkt3L0JOUHEvVFZ6cEJJSGN3aXN4?=
 =?utf-8?B?eUdiNE9DNHpBaTFtUFFDME1wQVZxUWtwRmxPNlAzY29TZktxS0hKenMyems2?=
 =?utf-8?B?ajBmblByWkZxWi82cUltWjdEamI4Q3FxanJ6eDVtdHQ1SHZqOFdhTkVwbkVs?=
 =?utf-8?B?VUI3WVVoSHNGQlVEUUJpTnlRdmRmd3RVYWRlYnNSbUVIbXk0bGpOL2ROb2dM?=
 =?utf-8?B?bnJGdnNTcFdYOEtjOTlBUDRxdEVRS2ZhaUNOSUlJOFpKb2FVSThTaDc4dWxo?=
 =?utf-8?B?T2pydWlpUkxyUVJjTHZQaDE4WnRJN0hkWTJWRzRYWHhYeE1hUkUyemgwbGZw?=
 =?utf-8?B?U1lSY2dTZDg2K0NRNTRaMXZpNU5RWkZYN3FWU0dybERTRERqM2FvOWZuaWpJ?=
 =?utf-8?B?WmJPTjg1aVBqNitqRUZ4ekNKTmFCVWZNbVd1M29ReDdDZ0ozdHc2TVFpZlhX?=
 =?utf-8?B?YThXZlZEQjBaWEx3V2kwWXFDRVJNZjduSjVDZi9lUE14dnZzTGdLTUk0Z2o1?=
 =?utf-8?B?Vm5tbmhEZUxqMVZRTTBVbDhjSlNUUTNsbUZSdHllbzB5d2E2YUNpb2VLT21i?=
 =?utf-8?B?dGVOcnMyUHozTWo4Y3dpbTZxbUdGeVprZlVOYzh2ZEdmbmJiTmNKaVptSFFU?=
 =?utf-8?B?SzBCejlKUGtLUUVrdmxDVFdLZzN1QkxnYmdPc0hOUyt1NFNNNlRzR244Ny9l?=
 =?utf-8?B?YUlXVGFaRjVNSFV3SmVvVThqNzI4Q3R0WTBTTUtRVVkrc1loSVR5Rk9ncEdm?=
 =?utf-8?B?MXZzMkphVTloblBEa1pNdDlUWFhlRjFEclFDNU93TmVWL2VrS0M1bytUeVRN?=
 =?utf-8?B?L1A4WHBWN0l0RmhvTVJmaVh1RVB5enZQQzdGM1NYR1pHa09YRGZaQzNwMFU2?=
 =?utf-8?B?TmtIRm5pQlp0cVBHekxaWnpXNXFKQU9qekJOWHBQbmpyZzZUdDJMOUpQQjFw?=
 =?utf-8?B?aDU4K0I5cndsRkwzckJJK2NMNTQ3NHIzMzFXMXVvbmFxUG1ueWpkbFozZ3FF?=
 =?utf-8?B?ZnNkTFc3N0hJamx5R0RiNzFUbHBSN0JocnlHRytTWnlwN25zRlltSkw0UjRH?=
 =?utf-8?B?M3J3bjNDQUZicy9rUmhyMXZnYURqelpmNFZkTDBlY0R6ZWEvcHFpb3pjYTFs?=
 =?utf-8?B?N0ZWR1B3TjZBM0h2MXlpMVZzNnl1MnF0aTRHanozQUY1Sy84YWhKSzVBSkwv?=
 =?utf-8?B?Y25lbzlMcGRCUmlJMG15cjAvTXMvdlVoL0crTmV0bDByNDhOOEExbHJpQW9N?=
 =?utf-8?B?TkJnZTlCTitUSlZUTC9DcmpiUkFJaElMWk1tVWgzLzNUQnRvV0NISkp1TTIy?=
 =?utf-8?B?OUxyRFN0QTRiQlBYT0xrYjU3ZE5SczdCUXgzU3NocElRR0tta0RMNzRqSjlq?=
 =?utf-8?B?K2JNVERBL29nSWo0c1MrZEtBSEFHVGFza1BXUWhrdEFPeUhZYjQzU0tYUDNZ?=
 =?utf-8?B?L1BHc0d3eDA0MU1IWU5KYjhZR2Ftc1oycGR5VjJBNkl2VmpaWWhySG92cTdV?=
 =?utf-8?B?allhQ0Z0dWJYNWNaNlNkeFZPOVRmbENXRzRqZWw3bCswWVRUYnEvTFFHT25C?=
 =?utf-8?B?R2U5aGQxUFZEblhMbitvYlo5blkxUk5zODZWYXU3UzBJOWF2U2J2MlYvWmgv?=
 =?utf-8?B?UUI3bE8vUy9BRkQySGpJVWpHcllxQU83UVQxa2JHcXNPUTNNOW93eDkwYXdm?=
 =?utf-8?B?RVgrTS9KVWxEVy9QSEU4Q2tYVHM3QVVJUjRQZkMzaGNJU3hnTUpueGYvalZV?=
 =?utf-8?B?ODdMdDRiT3Z5ZGdzaFMwMFVmRW80OTQrN1JLVmJLbS9DNFJpTGh5T2s2dmxM?=
 =?utf-8?B?WEptS2w2cGQ5aXRJUVhiejRidnB4akgwVjVSK0lZbnZ4SmNkcXlUeUhFcWxP?=
 =?utf-8?B?eFB3Z21wNXB0NnVESktKb1lkMi9tTVJXb3Q0TmNWTjdrRnVQZjRkL2N1UlNT?=
 =?utf-8?B?SEdBZzU4L2JSQkNoa2x1dmVMbDgrS2Nud3cvV3NLZlFieGdOMjliTUswUUY2?=
 =?utf-8?B?YlF4UExVVzc2REFrWmxza0RmK1FoYURUWWZmOGxiaEJPUFdzL0FaNXlZck44?=
 =?utf-8?B?aVpjaTdFZUdSWFJ5UWwyaE5pdWdjQi9hMVc4THFtSG9hQ2dMaFB0eXZJa2NQ?=
 =?utf-8?B?Y3hwZWN5THNnTHJwbjJnR3hoNFJzY1dFNEQvVWVjaHFVdEpJSTZjY25xbHpj?=
 =?utf-8?B?clRMRytMcVFFeElzR3paZUhUWEV5NDdLa3QyMG8xdTNnbDRTYmM3ditvQUZ4?=
 =?utf-8?B?V1BINjdvOFpIRGpIdGJ6YUgraUxiU0NuRjRYTFlnZXZ4SG12ZVR5a2Y3cFlR?=
 =?utf-8?Q?QNdn2vzes1IDW9GMcg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jMFpfXTKCuu5w1v6Hdw+syXVmrCxglgCOxraAzt48Bw7S6PKNIZsqsCykp7J/1BDPodjMNrOq7ca8Ir4Yzcx3br3ZnWF7xsJLkHIIvkVZjw4zhzBN0NaiPbKF9bN36ngH7Kdo/RNUijmw0qynx5cAn0jXJVHr3SUqv/GEwrST7rRe786ujqbnCcaoA9D/bTooCTtZRvtYB0L59JoF/f6P/yISwZROD6nQ1K6qxKO8uWI+ycQyAS6IgqfNIXfS7i/EU7VZb2NJ54UNh4NdcxvF8lcLZ/cROthV/k5BH9TYdUG/N3Qf0dSmntnxD8EiWZKS/QawYa6MN9gqQ65XiHzTA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7585.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bebda4bb-754d-49ec-bd54-08de8c008534
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 12:58:19.4984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xk+p3AIq0O83MIfje3lSt4ig8RwcKxLsPgvyIsJ/WXtfy3TSUL73g1PKmtxxedrsHWZYdq2pFzltmfwZ3yohUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7562
X-OriginatorOrg: intel.com

SGkgTHVpeiwgUGVuZ3BlbmcsDQoNCj5TdWJqZWN0OiBSZTogW1BBVENIXSBCbHVldG9vdGg6IGJ0
aW50ZWxfcGNpZTogdmFsaWRhdGUgY29tcGxldGlvbiByaW5nIGluZGljZXMNCj4NCj5IaSBAS2ly
YW4gSw0KPg0KPk9uIFR1ZSwgTWFyIDI0LCAyMDI2IGF0IDQ6NTHigK9BTSBQZW5ncGVuZyBIb3Ug
PHBlbmdwZW5nQGlzY2FzLmFjLmNuPg0KPndyb3RlOg0KPj4NCj4+IFRoZSBNU0ktWCBSWCBhbmQg
VFggY29tcGxldGlvbiBoYW5kbGVycyB0cnVzdCB0aGUgc2hhcmVkIHJpbmcgaW5kaWNlcw0KPj4g
cmVhZCBmcm9tIGRhdGEtPmlhLmNyX3RpYVtdIGFuZCBkYXRhLT5pYS5jcl9oaWFbXSBiZWZvcmUg
dXNpbmcgY3JfdGlhDQo+PiBhcyBhbiBpbmRleCBpbnRvIHRoZSBmaXhlZCB1cmJkIHJpbmcgYXJy
YXlzLiBJZiB0aGUgZGV2aWNlIHJlcG9ydHMgYQ0KPj4gc3RhbGUgb3IgbWFsZm9ybWVkIGNvbXBs
ZXRpb24gaW5kZXgsIHRoZSBkcml2ZXIgY2FuIHN0ZXAgcGFzdA0KPj4gcnhxLT51cmJkMXNbXSBv
cg0KPj4gdHhxLT51cmJkMHNbXSBiZWZvcmUgaXQgZ2V0cyBhIGNoYW5jZSB0byByZWNvdmVyLg0K
Pj4NCj4+IFZhbGlkYXRlIGJvdGggY29tcGxldGlvbiByaW5nIGluZGljZXMgYWdhaW5zdCB0aGUg
cXVldWUgZGVwdGggYmVmb3JlDQo+PiB3YWxraW5nIHRoZSBkZXNjcmlwdG9yIGFycmF5cy4NCj4+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBQZW5ncGVuZyBIb3UgPHBlbmdwZW5nQGlzY2FzLmFjLmNuPg0K
Pj4gLS0tDQo+PiAgZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmMgfCAxMyArKysrKysr
KysrKysrDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmMNCj4+IGIvZHJpdmVycy9i
bHVldG9vdGgvYnRpbnRlbF9wY2llLmMNCj4+IGluZGV4IDM3Yjc0NGUzNWJjNC4uMDZjMmI4MWYy
YjZlIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmMNCj4+
ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5jDQo+PiBAQCAtMTAwOCw2ICsx
MDA4LDEzIEBAIHN0YXRpYyB2b2lkIGJ0aW50ZWxfcGNpZV9tc2l4X3R4X2hhbmRsZShzdHJ1Y3QN
Cj4+IGJ0aW50ZWxfcGNpZV9kYXRhICpkYXRhKQ0KPj4NCj4+ICAgICAgICAgdHhxID0gJmRhdGEt
PnR4cTsNCj4+DQo+PiArICAgICAgIGlmIChjcl90aWEgPj0gdHhxLT5jb3VudCB8fCBjcl9oaWEg
Pj0gdHhxLT5jb3VudCkgew0KPj4gKyAgICAgICAgICAgICAgIGJ0X2Rldl9lcnIoZGF0YS0+aGRl
diwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICJUWFE6IGludmFsaWQgcmluZyBpbmRp
Y2VzIHRpYT0ldSBoaWE9JXUiLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgY3JfdGlh
LCBjcl9oaWEpOw0KPj4gKyAgICAgICAgICAgICAgIHJldHVybjsNCj4+ICsgICAgICAgfQ0KPj4g
Kw0KPj4gICAgICAgICB3aGlsZSAoY3JfdGlhICE9IGNyX2hpYSkgew0KPj4gICAgICAgICAgICAg
ICAgIGRhdGEtPnR4X3dhaXRfZG9uZSA9IHRydWU7DQo+PiAgICAgICAgICAgICAgICAgd2FrZV91
cCgmZGF0YS0+dHhfd2FpdF9xKTsgQEAgLTE0MDMsNiArMTQxMCwxMiBAQA0KPj4gc3RhdGljIHZv
aWQgYnRpbnRlbF9wY2llX21zaXhfcnhfaGFuZGxlKHN0cnVjdCBidGludGVsX3BjaWVfZGF0YQ0K
Pj4gKmRhdGEpDQo+Pg0KPj4gICAgICAgICByeHEgPSAmZGF0YS0+cnhxOw0KPj4NCj4+ICsgICAg
ICAgaWYgKGNyX3RpYSA+PSByeHEtPmNvdW50IHx8IGNyX2hpYSA+PSByeHEtPmNvdW50KSB7DQo+
PiArICAgICAgICAgICAgICAgYnRfZGV2X2VycihoZGV2LCAiUlhROiBpbnZhbGlkIHJpbmcgaW5k
aWNlcyB0aWE9JXUgaGlhPSV1IiwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgIGNyX3Rp
YSwgY3JfaGlhKTsNCj4+ICsgICAgICAgICAgICAgICByZXR1cm47DQo+PiArICAgICAgIH0NCj4+
ICsNCj4+ICAgICAgICAgLyogVGhlIGZpcm13YXJlIHNlbmRzIG11bHRpcGxlIENEIGluIGEgc2lu
Z2xlIE1TSS1YIGFuZCBpdCBuZWVkcyB0bw0KPj4gICAgICAgICAgKiBwcm9jZXNzIGFsbCByZWNl
aXZlZCBDRHMgaW4gdGhpcyBpbnRlcnJ1cHQuDQo+PiAgICAgICAgICAqLw0KPj4gLS0NCj4+IDIu
NTAuMSAoQXBwbGUgR2l0LTE1NSkNCj4NCj5DYW4geW91IHJldmlldyB0aGVzZSBjaGFuZ2VzPw0K
Pg0KTG9va3MgZ29vZCB0byBtZS4NCg0KVGVzdGVkLWJ5OiBLaXJhbiBLIDxraXJhbi5rQGludGVs
LmNvbT4NCiANClRoYW5rcywNCktpcmFuDQo=
