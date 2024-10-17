Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE2CC147
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Oct 2024 09:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729159146; cv=fail; b=cGgAtyKLUw8lRfc6hBlcFAncYbrdjTAtPqT3pVL/EpFDnrGnLXUSgQedzvbUcYKaOWIC8IzpwDaNxX4Oe2YJrY865gyld3wFHM5D+u2tZDSE25XxDyvePfRDS9lT8LLUdCgXd8Jbfq9py+2MGfrrK6lP+XQICX6QGXB/Es55InE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729159146; c=relaxed/simple;
	bh=WTQwtxK0VQ+Lavt99nZV6cOjKXKpVJYhHvtzZu8yxp8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NtcexdInsQZqnanLRL3wWbrpdEmgOqSQNRkeGxADq6+RiXrc5LVEzGBkVYkzC33/rL0Nu3qOrY+R2EiSNcCb0SVaeQXkno5BPcJWINZ1W1cker1HwjsdDI1Xjy+UHQkkO+gZ7MualnTiSkVL9yVsP7dLpd7WeWfo23OPJpBYkQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T+3fVvVH; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T+3fVvVH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729159142; x=1760695142;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WTQwtxK0VQ+Lavt99nZV6cOjKXKpVJYhHvtzZu8yxp8=;
  b=T+3fVvVHXclhkgRmr7DsinldqGCipdP0S2Y/hMCi26pP1ERa2gHhoyAk
   WUQOt2fSmIy2ZrJGTsu4sIDInVYWcP7yROVM07cN0RU5YCF1E83dgbT5E
   U7Ik6aTidM2sLEVI8ZCb0t/bHv74u0Q4afJ57G7zS2hvmbla45lsy6Olu
   w+/G8E3ALUo7hNaP5Vb2QeVyyXhObGvYZZgunJGzpJXzifo7jrSgrFskH
   B7j6LffhfkAJzjwp20GmGzyUzpawOVHipH4U1USgGkJkuuzMRR4z9NmIJ
   XfHVwkR82CJtFyCcT6UU89sMCY66JmDcaOrve2idzGiYDBMHdiazafPWO
   w==;
X-CSE-ConnectionGUID: AmvstJoCQkmYe08nuZg9+w==
X-CSE-MsgGUID: hti/CZCST5e2XfT6+0N16A==
X-IronPort-AV: E=McAfee;i="6700,10204,11227"; a="28108084"
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="28108084"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 02:59:01 -0700
X-CSE-ConnectionGUID: XhOMtf8mQ3yoU5SSGgAQ/w==
X-CSE-MsgGUID: plinKE48SdmSqBuRh0fH2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="78398657"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2024 02:59:01 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 02:59:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 02:59:00 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 02:59:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYtN2lgIthBOsLLs+Y/V5lnpwUmHylcpeKB8KhyZ20LVu02Eazlfcr9UBETffdPYbbq3grEA2LV7Vv1MsiZLOc2h5k7GEPKlAVXMsYcL0wdSdfuKibJjTWi1DeP+5WOd+XY6tQc7xhXYuOxEKDaQIJfM7jM8N0XBEymn4e5uIgZ1Zef7P7YMW5TgJtdYTgmcyTVlG4IgXQZJn/oNB3Lk5vf3TwnIUj4kwGg3Cpyqk7cqc/EwcJKE3AV1iByZbYOic+aErA+lo3Fh33TPgfN1lZE6Ir9ihnmGu2JeT4VYPhpkTI/6PeH2TF/xXcLrfpD6mPZ27bEuYjicWys6eHpohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTQwtxK0VQ+Lavt99nZV6cOjKXKpVJYhHvtzZu8yxp8=;
 b=eyO6fcXTUvg+uEcDAJ/txxPdUksReJcH0G/LwNqEEfpc+ZeevuxWkMWPlcbMLKdeV5N62kv1ZCVyY9+dknI35xN26yU/sT/P3KtuoOm20seWKuI9IoK+U+0Q/C5nrIAIKrtS/R7S/lj+wXG9uH97qBYijAWXRUJRXSF6dSh7Dr6Su8aiPD45iquLSx0jCbq5iETJM4kwdr0Er1hmjmjxIJIE4pB2MhCiBmTMkQd14D24+e8Le4r8Y+oNIvnMx0vMpa/sDBmeXW+EhJo4o9glqY/v0zVQGvx92OLnZslKPE6yQ/9kmAgh6It7ItY4KbLI60IOowS/k6zBwompLYVt6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by PH7PR11MB8479.namprd11.prod.outlook.com (2603:10b6:510:30c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21; Thu, 17 Oct
 2024 09:58:57 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%3]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 09:58:57 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, "Devegowda, Chandrashekar"
	<chandrashekar.devegowda@intel.com>
Subject: RE: [PATCH v1] Bluetooth:btintel: Do no pass vendor events to stack
Thread-Topic: [PATCH v1] Bluetooth:btintel: Do no pass vendor events to stack
Thread-Index: AQHbHhTUoqIQ8sx9fEeJdK/DClxlNbKJioqAgAEvZJA=
Date: Thu, 17 Oct 2024 09:58:57 +0000
Message-ID: <PH0PR11MB7585F0639F78CBC629F4F8D1F5472@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20241014085602.711258-1-kiran.k@intel.com>
 <CABBYNZJDsR8HjHb83x6bOZT0ZCoxLvHKcD+CqmFjK4Ct3mzpxQ@mail.gmail.com>
In-Reply-To: <CABBYNZJDsR8HjHb83x6bOZT0ZCoxLvHKcD+CqmFjK4Ct3mzpxQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|PH7PR11MB8479:EE_
x-ms-office365-filtering-correlation-id: 16f2be83-6e15-4017-bf85-08dcee925164
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?N0wxckFPUmFhU2Q5OCtqRDl1TjhKQUpTeXMwcHFlalpjRHk4TVZaSDlUYW12?=
 =?utf-8?B?SEFlUnJEc0hVQXBxanF1ME50YjdTRU5BQjhnSXAzMW1YU1dVVm15dkVhdThU?=
 =?utf-8?B?Rm1DTGJ6c1J6N0c4RnNUaVgyZnc0NzVFZ1FMdmhQZ05aamlBTVFmc24wMjJC?=
 =?utf-8?B?RUxUSTJtNTJzUGlERjMzUjEzeWFLWnhWdFMzZURYOE05MG5KM3JjVUd6UWpU?=
 =?utf-8?B?VHl5cXFVYkFpaUVlL0pCMUdrOHZ0a00wQmNscUNYdHRKTk5LaHJjc2FqSnYv?=
 =?utf-8?B?UGVKalBpQlU0Z1VSQmlxdDVGeU1wLzFGSFVQZlNBTVlKZmFscHIwakQyNW50?=
 =?utf-8?B?dzRncWRmNjZ6OWlRYnhhZVQ4R0JsMzB3MVZnaWMrWDAxazV0ekQ5WE44emNM?=
 =?utf-8?B?TXI5T0VESHZKbjFUaHRrQkJPSzgycy92bmVLQUptWmJqc0hsMnZzTk8yOWl0?=
 =?utf-8?B?MzlrOXFGUXdmQlBSM0tmSmp6b2xoM0hJbng0YTJFTmlIMlBNbWplUDl0UmRH?=
 =?utf-8?B?QXI5ZlpYQTlmalE0S3JuWk5KS2NvNC9sUkE1WXN5b1pwMzcvQlp2TldVMEtt?=
 =?utf-8?B?c2hHQzUxeHNxT2pvMTBySTVTeG5tRWo4ZlhOeHVJV2ptMlBwVmpLRkx0RUJP?=
 =?utf-8?B?ZEh0SW8rUS9MVlFQazZWcTQ3a0pYQ2FmY2Zka3hIb2tkdnhmanViV3NjL0I4?=
 =?utf-8?B?dGFxKzI0NGVIdlp3dkdpelFDSFB2V0E2alMzVkpFUlJxeVJTQmtMbE9UajUr?=
 =?utf-8?B?Nnk4ODExSWFKcDVRWkdWUUNJaGJvMlViZm5Jd0RxejRXWDhhWG9HY1Y4bm8r?=
 =?utf-8?B?WjErd09WSzBPRHNCSWV1UGl4Y1VOYVNxV0tYWFMwNDZYZTd5T29RWEY1WExj?=
 =?utf-8?B?VGZVMWVVK0kvYkF5VUd6NHF1VVBIZjB1Um8xUjhPZnBsV29TZ1V4NG9ON3o2?=
 =?utf-8?B?QnBOT1VZSG5FeVdLZS9kNStjM09wZTJ3WUN6RW9kVVh3OCs3ZTd2OTlVYzVw?=
 =?utf-8?B?cko3ZUtpSFcrQWtHamFFbkt3bzZPSmVFYVdUZ0lMNnVuNHd0Q3ZlZkJnRy9S?=
 =?utf-8?B?RDFNNTdzbFR1K3JoeGY5NGhuL0dsK3NoMUVmMk9DQTg0ZXpUcnh4ampFbVhB?=
 =?utf-8?B?aDFNc3BUdTBLK0JMTk44Q2ZHTHdDd0hRTzNYQ0c3WDZWZ2FvMTQxanIreHVO?=
 =?utf-8?B?SnNCdHE1N09VcGw2dnhvSXZtZHFQNWw0aDBsK3FGN1dmNzhkbmozT1BsZmpP?=
 =?utf-8?B?bHd6NC9NRG1qajJheis0eFplNU5TV003Z05QbEFnd3huTnc0WEExVzlCMGZB?=
 =?utf-8?B?ekI3U3V2VFFwa2VrOWxIWStWaHhCL3pMREZLMzBkaVNCblI4cHZ4aStNdWo2?=
 =?utf-8?B?NUZJNXIzNFlVVDgweWxGMmMyeTlkNFMrWVhTVHg3Qi9FTFdDem0yNU9KamtS?=
 =?utf-8?B?UGl0a2VsdUF2YnJWRitjaXplOGpzNzZnUVd5SG5VdmQ1K2ZZaU5ubE9PdE5n?=
 =?utf-8?B?Mnhpc0FsdmI5MEhwZm1XbzYyZmJwaFBablY3NGMwZDdwdEpMbHNWM2pLditN?=
 =?utf-8?B?eDB6SVNXRFMyUk9BdXR6TDl2WXE5TTVmVWcxRUt6ekpTaXBIYVdJanlGQTB1?=
 =?utf-8?B?NTNtWnhKU1R1a0lvQUhrcFRUS1p3SmdRbjUzMDRmQmZSZEFnNlcyWnFOcERW?=
 =?utf-8?B?K3NvdzFPUnhUblFTSWhUeHhMWnQ4VEFsR2JZTHRqMlJPaWZiNWhsRHRzbGhh?=
 =?utf-8?B?K2RFODEza3JVL3R4aHFCMTl3M2Q0VVBRUWJPcnRGUXN0c2dJMWQxaFZiWXJq?=
 =?utf-8?Q?jMTfsP7eTX0STWOGkcCby30jZqIIXRBn9yrw4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dE9CTlZ3ZDZCZURBWjZUWFRwMDBuY0NDdStKWWRXaFBLRFlaRSthVVRnSXVV?=
 =?utf-8?B?UFdtRFBDSHp0eG5GZklzRm5la2JLQmF3UTFrTHQ0VXRNb0ZQaVF4cG9FTWY5?=
 =?utf-8?B?bG5CRFBYNGpqbURkcFFIdHpSY2hqbmxSOGx4YnNhbkgxcmZzUUkrZnlhcDlU?=
 =?utf-8?B?R1JlNVNXS1MxZnUrWHZOK3JLL0l1WnQ4SVl6emUzV1hSKzlIUVJqTDBkRC9D?=
 =?utf-8?B?d0hlclBGcXNTSk9EVStad3ZNTXBJeTdmclBOdlpWUzR1UllXVFRFeXkrbWhn?=
 =?utf-8?B?cG9YV1BrbHJTY2xqbHA4V1REc0pYaEZ5TkNLYVc4Zkw4Y1lrOFRUKy8xSU1V?=
 =?utf-8?B?WWxyeFZLTmgyejFFZDhZVHVOYUIrTll6U0JPUkxFTzA4WVQ4M1hkSlpPUDUy?=
 =?utf-8?B?Um05VGlqdWhQZ0VlSGtITVFpc2hBbjBKcnBzVmthaVJxUGIzK1c2ajdlUjJN?=
 =?utf-8?B?aXg4OTdkcGlhWkQzQUQ5dS9aNG9BUEd2WDRjdjZERUU1UmcraG1rQUdXK1lI?=
 =?utf-8?B?NTRmZHo3dkZnNmJvMEc4L2ZtaHVCbG04UGZld01GYUMrbVB5aTEvVzNJMDBv?=
 =?utf-8?B?eWhJM0k5WGs0ZW9iZ3puT2dqNHkvaDN0ak1oaFNCTDRZY0s3YlducmFtQTFj?=
 =?utf-8?B?cElhT1JRclRmZXhOOSs2V0cxQkg5aDdXMjhQdFppWkd1RTEzcDQzMStudzJK?=
 =?utf-8?B?U1JXcHFBRWIzR3JBOUF3dmRjc0EyWEl2SHZIZm53cGpUeTUxZklJb1JWS2pY?=
 =?utf-8?B?ZkJGTlZnTW5KZzhZUFpQYzhwWkdkUER3b3RsU1BaYnpMb3p2VVRnbGJ6RSty?=
 =?utf-8?B?eUM5Yi9QNnFucmg0MFVUbTg1eEN1ZGFaeTNQTnpxc0xGbzdFaVZldG1pOG1G?=
 =?utf-8?B?bENZcTRoaGhkTFlERm1XS29XYVE4N2dubWl3QzJBeDRWK1VDd3hnUWFhTVl4?=
 =?utf-8?B?UFZXRmlmdi8wLzd3QmZOa01DdDdmakJjYVAxQ0Yxc25FSUtIZU4xL21Pdnh1?=
 =?utf-8?B?MndrS2dzTWpoTVVnZzhwb1gzcU4rMkRJd2pqaHcwcng0eDZtWmNXWXNnSjBk?=
 =?utf-8?B?WXVzd0gvT05MMG95c2VpVGh4YUZsaGVoL1NQZ1VYY3RMK1RrS1RpSEF2RlNk?=
 =?utf-8?B?TnZxK3E3SHN3dTdQYzJiM3AwRnpmUkh4VEpNRnVCNEVvYWlZaGdEdUxaaFRq?=
 =?utf-8?B?SU9icnYrbGpwNEFkc2pwSTk2bDFNQU9FSmU3TkpPQ0JRTEJISnY2bmdIeEtT?=
 =?utf-8?B?ZU5tcWwvS0xLYjJ3NGYwZHdrOGFveU83K21oVTI1SUxaeTBRN0dmajZyYUg4?=
 =?utf-8?B?dFc1OUpXalBzcTZoSzN1Z0E0dGhkSTJWNVJxRGR2TnB4WXdRbDQ2SGFQYXVH?=
 =?utf-8?B?aWY1YmZMa29YNHJPU3dpaG5KaGk4Qm9TRlY1Z0tnZXdvdmhrUmtNZXlXaFhn?=
 =?utf-8?B?bEwvUE82c2pwWjkrVmlCcDk5Z0JPcVBhZXNiR3pBb3pUVzdsQ3NhOWc2Q0hp?=
 =?utf-8?B?T3FQUUFzMk96QVFjMlhvUmVHaTJwRWEvc0pFQVNKZGpoV0J6aENXM2ZqZlZP?=
 =?utf-8?B?b2xPNVQ5QTdTRU9HV05RNWpENVoxMEl2T3RjZGJhN3NBWUVrVE43enpSdlpz?=
 =?utf-8?B?VzhVTFdCV1hsb0hOTzFSa0xGL1JHL05lQVlhWEQxZFdGWktvWUpIWVFzQnEv?=
 =?utf-8?B?VnJvTTlWZUxtZFFMbVVGOXlkb3UzdFRTWElVeTVzakRkMXFyQlRqYi9qQmtX?=
 =?utf-8?B?b1kya3VlZGxWMVgxaW1zL1VwcklLeUNIbXN1cEJsTkl2WmRUd2JCTFd1dnJ0?=
 =?utf-8?B?UGY0YzFMRFBlMHFGYjl6eUJoSUtWNGN0TXQwWFR1RHN1NVpKbGR0K3Q2TDdI?=
 =?utf-8?B?MFNLd29jOGZSU2Vpa09uR21kWVNXRGg5T2dsM29qcFFKSWFVaHJiOUw3V2Yv?=
 =?utf-8?B?TXMwR3RrZkF3cjhWY3k5OGNVT0VwSjRCRHdUdXNVb2wyeVlib0UxUGl5V1lF?=
 =?utf-8?B?QncrVlg4dW9TSFRCNU5CemNwTGRvOHJlbkVyb0lYQjNuTUpqdEdxRTFTZFpr?=
 =?utf-8?B?NzZOSXZlcFphTlV4ZytNVFRaWUQ5dEkwYlluOFEycnVUL1VlTVVCdHVGSFVu?=
 =?utf-8?Q?QEGM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f2be83-6e15-4017-bf85-08dcee925164
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 09:58:57.7484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /pbQ5wwAN9+lZ9a0meuinLWqZImv1C3MVskmQIIrCO6wCBpwjzX1Yr24797KL6WWF5RTSZbCvcrERM1Z8SdKDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8479
X-OriginatorOrg: intel.com

SGkgTHVpeiwNCg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjFdIEJsdWV0b290aDpidGludGVsOiBE
byBubyBwYXNzIHZlbmRvciBldmVudHMgdG8gc3RhY2sNCj4NCj5IaSBLaXJhbiwNCj4NCj5PbiBN
b24sIE9jdCAxNCwgMjAyNCBhdCA0OjQx4oCvQU0gS2lyYW4gSyA8a2lyYW4ua0BpbnRlbC5jb20+
IHdyb3RlOg0KPj4NCj4+IER1cmluZyBmaXJtd2FyZSBkb3dubG9hZCwgdmVuZG9yIHNwZWNpZmlj
IGV2ZW50cyBsaWtlIGJvb3QgdXAgYW5kDQo+PiBzZWN1cmUgc2VuZCByZXN1bHQgYXJlIGdlbmVy
YXRlZC4gVGhlc2UgZXZlbnRzIGNhbiBiZSBzYWZlbHkgcHJvY2Vzc2VkDQo+PiBhdCB0aGUgZHJp
dmVyIGxldmVsLiBQYXNzaW5nIG9uIHRoZXNlIGV2ZW50cyB0byBzdGFjayBwcmludHMNCj4+IHVu
bmVjZXNzYXJ5IGJlbG93IHdhcm5pbmcgbG9nLg0KPj4NCj4+IC0tDQo+PiBCbHVldG9vdGg6IGhj
aTA6IE1hbGZvcm1lZCBNU0ZUIHZlbmRvciBldmVudDogMHgwMg0KPj4gLS0NCj4+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBLaXJhbiBLIDxraXJhbi5rQGludGVsLmNvbT4NCj4NCj5XZSBuZWVkIHRoZSBG
aXhlcyB0YWcuDQo+DQoNCkFjay4gSSB3aWxsIGluY2x1ZGUgaXQgaW4gdGhlIHYyIHZlcnNpb24g
b2YgdGhlIHBhdGNoLg0KDQo+PiAtLS0NCj4+ICBkcml2ZXJzL2JsdWV0b290aC9idGludGVsLmMg
ICAgICB8IDYgKysrKy0tDQo+PiAgZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmMgfCA5
ICsrKysrKy0tLQ0KPj4gIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgNSBkZWxl
dGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5j
IGIvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5jDQo+PiBpbmRleCA0MzJmNzIzZTM4NjkuLjY1
MmE1NTk1ZmIxNiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYw0K
Pj4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5jDQo+PiBAQCAtMzM4Myw3ICszMzgz
LDggQEAgaW50IGJ0aW50ZWxfcmVjdl9ldmVudChzdHJ1Y3QgaGNpX2RldiAqaGRldiwgc3RydWN0
DQo+c2tfYnVmZiAqc2tiKQ0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKiBp
bmRpY2F0aW5nIHRoYXQgdGhlIGJvb3R1cCBjb21wbGV0ZWQuDQo+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAqLw0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBi
dGludGVsX2Jvb3R1cChoZGV2LCBwdHIsIGxlbik7DQo+PiAtICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGJyZWFrOw0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBrZnJl
ZV9za2Ioc2tiKTsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIDA7
DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICBjYXNlIDB4MDY6DQo+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIC8qIFdoZW4gdGhlIGZpcm13YXJlIGxvYWRpbmcgY29tcGxldGVz
IHRoZQ0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKiBkZXZpY2Ugc2VuZHMg
b3V0IGEgdmVuZG9yIHNwZWNpZmljDQo+PiBldmVudCBAQCAtMzM5MSw3ICszMzkyLDggQEAgaW50
IGJ0aW50ZWxfcmVjdl9ldmVudChzdHJ1Y3QgaGNpX2RldiAqaGRldiwNCj5zdHJ1Y3Qgc2tfYnVm
ZiAqc2tiKQ0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKiBsb2FkaW5nLg0K
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKi8NCj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgYnRpbnRlbF9zZWN1cmVfc2VuZF9yZXN1bHQoaGRldiwgcHRyLCBs
ZW4pOw0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAga2ZyZWVfc2tiKHNrYik7DQo+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAwOw0KPg0KPlBlcmhhcHMgd2Ugc2hvdWxkIGhh
dmUgYSBjb21tb24gd2F5IHRvIGRyb3AgdGhlIHNrYiBlLmcuIGdvdG8gZHJvcC4NCj4NCj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgIH0NCj4+ICAgICAgICAgICAgICAgICB9DQo+Pg0KPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5jDQo+PiBiL2RyaXZlcnMv
Ymx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5jDQo+PiBpbmRleCBkNTgxYTUzOWQ0MzkuLmIyZWViNjgz
ODI0NyAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5jDQo+
PiArKysgYi9kcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuYw0KPj4gQEAgLTU1MSw3ICs1
NTEsOCBAQCBzdGF0aWMgaW50IGJ0aW50ZWxfcGNpZV9yZWN2X2V2ZW50KHN0cnVjdCBoY2lfZGV2
DQo+KmhkZXYsIHN0cnVjdCBza19idWZmICpza2IpDQo+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGlmIChidGludGVsX3BjaWVfaW5fb3AoZGF0YSkpIHsNCj4+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBidGludGVsX3BjaWVfd3Jfc2xlZXBfY250cmwo
ZGF0YSwNCj5CVElOVEVMX1BDSUVfU1RBVEVfRDApOw0KPj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGRhdGEtPmFsaXZlX2ludHJfY3R4dCA9DQo+QlRJTlRFTF9QQ0lF
X0lOVEVMX0hDSV9SRVNFVDI7DQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgYnJlYWs7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
a2ZyZWVfc2tiKHNrYik7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIDA7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0NCj4+DQo+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChidGludGVsX3BjaWVfaW5faW1s
KGRhdGEpKSB7IEBADQo+PiAtNTY4LDcgKzU2OSw4IEBAIHN0YXRpYyBpbnQgYnRpbnRlbF9wY2ll
X3JlY3ZfZXZlbnQoc3RydWN0IGhjaV9kZXYgKmhkZXYsDQo+c3RydWN0IHNrX2J1ZmYgKnNrYikN
Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJ0aW50
ZWxfd2FrZV91cF9mbGFnKGRhdGEtPmhkZXYsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJTlRFTF9XQUlUX0ZP
Ul9EMCk7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0NCj4+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGtmcmVlX3NrYihza2IpOw0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICByZXR1cm4gMDsNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgIGNhc2UgMHgwNjoNCj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLyogV2hlbiB0aGUgZmlybXdhcmUgbG9h
ZGluZyBjb21wbGV0ZXMgdGhlDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAq
IGRldmljZSBzZW5kcyBvdXQgYSB2ZW5kb3Igc3BlY2lmaWMNCj4+IGV2ZW50IEBAIC01NzYsNyAr
NTc4LDggQEAgc3RhdGljIGludCBidGludGVsX3BjaWVfcmVjdl9ldmVudChzdHJ1Y3QgaGNpX2Rl
dg0KPipoZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQ0KPj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgKiBsb2FkaW5nLg0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgKi8NCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnRpbnRlbF9zZWN1cmVf
c2VuZF9yZXN1bHQoaGRldiwgcHRyLCBsZW4pOw0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBicmVhazsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAga2ZyZWVf
c2tiKHNrYik7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAwOw0K
Pg0KPkRpdHRvLg0KPg0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgfQ0KPj4gICAgICAgICAg
ICAgICAgIH0NCj4+DQo+PiAtLQ0KPj4gMi40MC4xDQo+Pg0KPj4NCj4NCj4NCj4tLQ0KPkx1aXog
QXVndXN0byB2b24gRGVudHoNCg0KVGhhbmtzLA0KS2lyYW4NCg0KDQo=
