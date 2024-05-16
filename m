Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDD11487DD
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715866143; cv=fail; b=EL5p6qay8mddMwSsI+XjLQb6LIQrvT7VB8YusTHH5jfOUymCaKNLSv/WbIjClCWrH00bLIUIB3iKXHBqUhOKiInufpbDCB4WICiTPczNFAj1i7F5n7x8xHaOiwt/v+izQsxBcxjHkhHS1sXwgp3BfNwLkfRjZO32R2IobcREsGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715866143; c=relaxed/simple;
	bh=6kyqLLBM4j/26tBAktNmvfI0VSKw1dsQ+Ox4nU7CeLg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T8QKSJ0nkYPG1s1//cd38tJmuVU0mjGuud9HtN31A4MNQWiouOJSna5a9m8CqfnTT3baQxEnz5QMHYX1gDeRQ8Zu0cSLLwDAeAFPU2ZvCQ72zybFZRQ/WZVmvMqM4mS0O4efm1iZSiurIbXQEMwIHKvy6ZZZJ3rXLGb/68AOrXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dumIUti4; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dumIUti4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715866142; x=1747402142;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6kyqLLBM4j/26tBAktNmvfI0VSKw1dsQ+Ox4nU7CeLg=;
  b=dumIUti4mTh70VUBY/WlSjw0bqaHRcixFwTJKRG//LgBH4ihblZytGRo
   frTXcy8bqt/KrzcMllDa6HA/oVQnsLpkVjofPcM9hPnKkdtOEN1zHWNcG
   2uRy1/FFQoMyMO8LW5sq2DUWX7KYPZGBbkAi3XbOR+gCr7rIhP7p+2SQY
   Ta+AILimixYjuQ3iQDzhoUSD8VRhPhyrF3CFrHTy1UwpzUitSGVQlEogX
   9H3bE3n6vJRp1z2iv8D/LLlcGVjUTwZdtfFhhuVavvhkzPHc7BZwdov5M
   X7gg+U/VLYd880WTEgjQQTXdeSrH+ecf0K0/lvCs29JrhrTTNKjSBNfIn
   g==;
X-CSE-ConnectionGUID: IAs8ZCrhRnqTVV3ln3fiWA==
X-CSE-MsgGUID: RYleUewNT4yMKkVejE1LMA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="23112845"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="23112845"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 06:29:02 -0700
X-CSE-ConnectionGUID: mCLL++c3THqoA6Ye+6g9lQ==
X-CSE-MsgGUID: vPPWDmR4Stmma4XJHPeRvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="35979024"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 May 2024 06:29:01 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 16 May 2024 06:29:01 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 16 May 2024 06:29:01 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 16 May 2024 06:29:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsLwVLamNnuo0WJ4wqPIXGnnlKiAiFnH2EDZdvuXQekKg0QaUIyeTF79Zmfzh1pksbraqlB1NierLlvkQx7E0q717tuY5N6d+ML7ZkLnxFdYAA5pkCyUuiOD2mCAqsH2ao9MAf/lqNZ/RUqwkQhebug6RdVenQIKy9hfO9NSNINKyKmixaJaarK0Xd5u2OJ6c2rDGhSZVAbWjqUxruxa0mmG70jGI7waHRlPG0j1vnqpktE14nn8v0FPlEqFSY51dbBWVwpELolbM0kwUi8hRf+a9Cc47DU/lBTVUjYKcGwgFGpkgjdvPmUB1hHlFQZYu0CXRAaPbIZoI4NvS5fDDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kyqLLBM4j/26tBAktNmvfI0VSKw1dsQ+Ox4nU7CeLg=;
 b=FQtIuFQWvHA+ZpDcLEAUu/oZMkk8bWK6X6NzmRwWoP4I7it1VIR+cdlVxIqBqf+Oec2drz2JdGl9R2NFWInmouatLF0RQVaNU5EaNaggfMuh5xMXXyzZFXnt+t/c2yPlw8NG8ZZqyX0HaZrczfdjwdHmV5C3bWIXTFhEfVVi621pWhEmkOzMD9SloyUWM5JVneprOR8v8yLqmhx3zefE9Ul/0OBzJLbS5mLW/j1J527rUVMmr01Bn7dk5wpYUpNBxXkJ1yBhsopp7QAFNbfau9sA72ba03FKt+SwZbgcl2nDt8YcTnu39yurUkYroeILD6S8akMdovStGOzPtZYVuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by IA1PR11MB6073.namprd11.prod.outlook.com (2603:10b6:208:3d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 13:28:58 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%7]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 13:28:58 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Oliver Neukum <oneukum@suse.com>, Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Devegowda,
 Chandrashekar" <chandrashekar.devegowda@intel.com>, "Tumkur Narayan, Chethan"
	<chethan.tumkur.narayan@intel.com>
Subject: RE: question regarding ordering in btintel_pcie_send_sync()
Thread-Topic: question regarding ordering in btintel_pcie_send_sync()
Thread-Index: AQHap1YHXc5StzfSukirn71hKLpSbrGZ117Q
Date: Thu, 16 May 2024 13:28:58 +0000
Message-ID: <PH0PR11MB7585901BCD41AC665844FF73F5ED2@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <2ec916ce-c7b9-40f5-bb08-d1d2ba564456@suse.com>
In-Reply-To: <2ec916ce-c7b9-40f5-bb08-d1d2ba564456@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|IA1PR11MB6073:EE_
x-ms-office365-filtering-correlation-id: 7c2f88d8-9928-4c22-c88a-08dc75ac248f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?cVhYdGhvRFVPOC9mOSsxbkxZOWwwQTMwbmZIZ0Q2dWkyeldGME5tbnluMmFE?=
 =?utf-8?B?VDk2M2Z0L0E2NFpyNTY0bkEydWtlYzZBMGw5U1I4a2srUDI3ZGlCSVpIV1Rt?=
 =?utf-8?B?SzA2c2xUOEtnSjNFdU1XdTlpOVQ0ZCtVbTRkZEErLzk3bTVld1VKeG1TRnlZ?=
 =?utf-8?B?MTVKRUV1OS8yMW9sOGNBZHJwNGtLcFRpRTBKdDZhZXkvNjg0TTY0ZmppUWNJ?=
 =?utf-8?B?YUZzNWtyVDF5U1B2K0FqYkdXYjlrNVNoVlpHQ0VJQTNQTWFPaUs4V2gwOVVH?=
 =?utf-8?B?ajdnVWF5M3BmUlZyckpWQTFXcFNLR1NESWJCSnM0Yk5BYTkxN1VrMlgrbEJ5?=
 =?utf-8?B?NG40UzhaQk4razJJLzVmK09zTVlLN3NHeFJjWU12bkk5TVR0VDlSMThJVngz?=
 =?utf-8?B?TWFWMU5IZXI4UENHT0QvNVRjT1BaWUxnWFE4SXZ0QkZYK2ErWGdJNTFyTGRB?=
 =?utf-8?B?ZlNrbGQrdVYvUTN1dGZrWm80ZWZPM2dpMERVbWl6RkwvaTVzeXhoeEYzb1Zo?=
 =?utf-8?B?R25SQnNxSkh6am1XV0EzWGhhOFFNQU1TY25sdE1TZUhxRXhKQXVFZHdlVFA4?=
 =?utf-8?B?cWFCdy93Z2gzb0cvcWcyc0ppS0w2dlZERTlsc1hOamNuYlR3MHUwMzdtM2dP?=
 =?utf-8?B?VHhQR1Q4Q2J4WUJYYlFjN3M4N2JrbjZFZk5JNHgwWVpsbUYvc3V4Y3dSc2h4?=
 =?utf-8?B?MjArZ3RYalNzK0JWY1V5YUQ5amZyUXNyVDJWZ1hKU1dnWU0yMW9nYmlmZ214?=
 =?utf-8?B?eUkyYU5hM0dyampVUnJmUTgwWjBURDI2ZFVpNXNobmVPVWxPdkEzSVhEN3cv?=
 =?utf-8?B?OU9hbW9SRTRiRkZ2OUdSMUZ1eG9GQVhDQlljYjkvODRQUHNxdmdYNllLWHNa?=
 =?utf-8?B?MEVDekZpRUMyQ0RUeElhcTNXMDh2Ry8veVBmTzdxUXRXRlBvaDJvTjdtbUw5?=
 =?utf-8?B?UVZvRTNRa1Vmc04rVVR0UFJpSVFWSCtYUWdSNFlQeDhZZk9TVDM2VzRxcVh3?=
 =?utf-8?B?dUVnYnFWVHQ1a1JEZUt0bm5BY3lWd3c4cXJvREVtdXg5RGVGR095Z1lFWjJs?=
 =?utf-8?B?VUcrYjc3RWJQMmtyNHFWUHJRdG8yZGF4VG9TY1FDTEdMTEJsUmdIdWR4dWlW?=
 =?utf-8?B?QU5NL1RGM1h4dCtqYmNBcnpaQ3QwY0JtRk5CaWNielBJbVN2QnZWdXJYMnA4?=
 =?utf-8?B?UTRRVzVISVNoMVZiQXJqZzQ3QzkyZS9DM3U1MWx5MXlaazBKbHVwaDNCUGdr?=
 =?utf-8?B?Y1BmY281aXVzWXVlQStFbXdvSmNVWDBoRjJqWko4Wlp4Mk56L2MwUmtGcmlI?=
 =?utf-8?B?cmJmbFF1ZzRNakd1OEdNeSs4M013dUF3WU1zaHl2cEI3aXFMTTVLczlFcWZq?=
 =?utf-8?B?Qm11Q0VsbFQzZ1MveHh0VkZvL1llMDBhR2VmRXdpOGEwSmd4aTBLZG8wNUpI?=
 =?utf-8?B?ZS9VWVJ4cllrUWtLcXVLTXk3MG9ZbTkxb05YcnhPTDNZbGhPdE04bmZicjRl?=
 =?utf-8?B?bkI4T2JtcEdyQUNsUFliVTlObzkweWpJek1zdkUzT2VqS1JpcGRpcHhvYmJp?=
 =?utf-8?B?Mm1FMmM4b1JSUGcvK1ZRUmNONjZReTB5dHVHQzhlLzdKaURwZzUvWE9NRFN5?=
 =?utf-8?B?elhpQ21qWStVK3Y4cTRRZE9sUW10OGljREJvekxVdFFzcFI0bXFnSGhWT0Jh?=
 =?utf-8?B?WnZJMXhMcjVyR3lSdzRWSXc0dkgwS0tUU1FhNnNjVDdrcVJMSXhQRlZ1Wmho?=
 =?utf-8?B?YnV3aXRibld6Q2szUUZsWUZxbTE5THJCRk5OMHdxVExRVWVFZVJOY1VkU0NV?=
 =?utf-8?B?WGU2Y1NzY0QvS215OVUrUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVZxenBjTmNjVklyM0I1a0Vhck01QmNXZjR6WjhXd3RqaEdTR005SnFuUEts?=
 =?utf-8?B?UytoODlVREZRNUZMTHJUdEgxNW1HdUJ5NEVGOWhZSkxLTVhhUVpTRFhpOExU?=
 =?utf-8?B?eHhvUmdRRjdFRVU0SERHTEFDWVZTMmw0QjRKMU9kdDlMd1ZkLzFTRHBIYmd6?=
 =?utf-8?B?UDVzcDhqcS9WdHhiaWExWFhOK1VWTUw5WnlaLzVwelZkbTFQUVVxTEp4Mk5P?=
 =?utf-8?B?WG0wN0s0cmRTMGJrc3lGelkwZ0EwSVhJVDJmbVliSEl1Uk02VVAybERuU3RL?=
 =?utf-8?B?V2JwWXhUVnMvK3ZwVnh1SXV1SzBuZlZwcFhBYVFLOEV2bU5uMGtJbzRVVDRN?=
 =?utf-8?B?UHZ2aWl5SEtkNjNzMWZVMVFZSkxtdStQZ0xrWFN2UzJYZzNJT2JsUk9FMnVm?=
 =?utf-8?B?MWVFaUhsTzMrdFhOeGNqTk1RS2tWRHJPanhsWWtZVXk4bXNPcnRpdldiSlpL?=
 =?utf-8?B?SUMxYTlOZU9RZXMwc2psWEdUUDVXRkxhSXJsbWFNZ1JYZTBXY3RYdGlkSmYr?=
 =?utf-8?B?akZBT1RHbm5nNWdsbXRRNk1ENGUvMDVoTTQyMDFLaE5ybWR2dWFHdllQcGJY?=
 =?utf-8?B?bHVIT29MMDhTaUJVM2FwZlZIckZQalk4RDkzc3BNdDdzeG1KWjBzWlV5VzBt?=
 =?utf-8?B?MGhXK0luTzJ6R1B3UEhrbmpmS2owVjE0TjJaZXF4UVhYVXZRbXFHUURwNUx6?=
 =?utf-8?B?eWhOaklFMHJnYUlvRWtsSVhJQ0FudFJqRGhOZ0x2UU9NMTBNWFJzaktPNjJB?=
 =?utf-8?B?bU9hNFUvdk9iOXVlcnRCcmhJdGRxeDJ6YVlxZXFnQ3h5N05STkxXMHZSRTFv?=
 =?utf-8?B?NE8wWmxhbVhXc0t2Zmp6eXJzVFdCSGJvUXEzRGkyalVzMFZSblpIUFF3Nk05?=
 =?utf-8?B?SzN6amFjTEFiVXptanIzM0VuR1o2V3pEQlJxMHBMZEczMzc5Y2FadGlOWEtV?=
 =?utf-8?B?bDBYbXNyMHdHUzJlT25tNmtUM0VxM3kxSlFkaENUTk0rU0tPbGc2MTdxMHc4?=
 =?utf-8?B?S1duZGhOTStraHVLc3pWczY1ZlIwQlN6OWkwTXA0bjVyM3JVTC9Jbjc0VmNX?=
 =?utf-8?B?MDk3Ykx6QXdXZS9nbXpOMFlUWnU4c3F2WWtYR2czWmxlRWlLY3R0UjF2U3Ix?=
 =?utf-8?B?bGpYZExEeXJXaUF4REk1ZDFkelg1YjZXcTBaeW03SHRLMUdZSkZRM3VQWGJU?=
 =?utf-8?B?S0NUdXRySThUcWpBUDJtbm0wNlp4WFJPOVQ0ZEsyZWs2S3IrOWIraWc0RGk4?=
 =?utf-8?B?Ujgvdld3ejcxMWhYcXl5ZUVVWDJFWW1DQUpxbXdxQmZHVzQ0bGN1bDU3b1lM?=
 =?utf-8?B?cWVYSHVnYUI4RDYycWlTZUhtWGxNbVpVVmRHalNXcWpBTU1FZDlLTnZsQy9U?=
 =?utf-8?B?djlKYU0rMFhTbDMrU0hkZG5SdlB4MHFCdXNYNWFJd3hTd2xBaWQ1d1Eyd2Zi?=
 =?utf-8?B?dk9KQm5LRXdkT2pyS3BjRnNMVGI5eHZtbTNhRW5UMkN0ZUJHT01JUjRuSUp0?=
 =?utf-8?B?SUw4S2VkNWlXUFM3eUhNSDhUZVhsa3RTdkwvNm9Ib3dMRTJIekMrUUEvaFdI?=
 =?utf-8?B?dXdHTjNwWWU1blh0ZkxMUjJxeTFPR0lmYUdkL0FNY0Rramx1ZUdQTWFuQTl3?=
 =?utf-8?B?aDRYa2tvQ3V5V1Z3U0s5b0JBOGVjelM3bjlrZ3B6MCtuQVIyYWFpd00yNWwv?=
 =?utf-8?B?NFJXSkJnMTJpNjhEVmVxM280aTdnK0h4M2VXTGFqTFg4RFpoNk8raXY2a2Fn?=
 =?utf-8?B?R0JhREd0ZWg5c1l4c2VZZlVpUHpEU0hMZFh4QzFjQk1LU0dGWWxSMlZHRDJl?=
 =?utf-8?B?VjIxd1RsTmh1Q1BTWllvakQ2LzVBdTd5UG5Ja2kzdGErS1NFMEhieXlEalVW?=
 =?utf-8?B?aVp0b0QyV0drRUU3bWJJUkVzWTVGTDAxYUY4R0QrMkV5K3ZhNGV0VDlURWdy?=
 =?utf-8?B?STBvSzBxM0ZCR0o5WXh1NENjR0NiY1hXTE9WWUlQKzIvelJ2UFU1K0xvR1M2?=
 =?utf-8?B?c256cE9LdWhDVFhHS2hqRzYzUUNvaWxLc29RTmRkZHVrM0hOYnVCYVI4SnRC?=
 =?utf-8?B?b2hQWm9aT2NZZ3BUNXJab21IbGJnY3Q4TnhTNGI1czY4QkFlejNtYXcrY3pI?=
 =?utf-8?Q?Kq8s=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2f88d8-9928-4c22-c88a-08dc75ac248f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2024 13:28:58.7661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gQ9NOiywzTlwWxuJCQHp99ZCiOB1rGrOtf8NNBhzNDGLM3kx8+6WN2W8nn1Mgtnc2+9iS2hnWxlo7rdMDDbqSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6073
X-OriginatorOrg: intel.com

SGkgT2xpdmVyLA0KDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IE9saXZl
ciBOZXVrdW0gPG9uZXVrdW1Ac3VzZS5jb20+DQo+U2VudDogVGh1cnNkYXksIE1heSAxNiwgMjAy
NCAxMToyOCBBTQ0KPlRvOiBLLCBLaXJhbiA8a2lyYW4ua0BpbnRlbC5jb20+OyBNYXJjZWwgSG9s
dG1hbm4gPG1hcmNlbEBob2x0bWFubi5vcmc+DQo+Q2M6IGxpbnV4LWJsdWV0b290aEB2Z2VyLmtl
cm5lbC5vcmcNCj5TdWJqZWN0OiBxdWVzdGlvbiByZWdhcmRpbmcgb3JkZXJpbmcgaW4gYnRpbnRl
bF9wY2llX3NlbmRfc3luYygpDQo+DQo+SGksDQo+DQo+SSB3YXMgbG9va2luZyBhdCB0aGUgY29k
ZS4gSSBkbyBub3QgaGF2ZSBkb2N1bWVudGF0aW9uIGZvciB0aGUgZGV2aWNlLCBidXQgaXQNCj5s
b29rcyByZWxhdGl2ZWx5IG9yZGluYXJ5LiBIZW5jZSB0aGlzIHBpZWNlIG9mIGNvZGUgY2F1Z2h0
IG15IGV5ZToNCj4NCj4NCj4gICAgICAgICAvKiBTZXQgdGhlIGRvb3JiZWxsIHRvIG5vdGlmeSB0
aGUgZGV2aWNlICovDQo+ICAgICAgICAgYnRpbnRlbF9wY2llX3NldF90eF9kYihkYXRhLCB0ZmRf
aW5kZXgpOw0KPg0KPlJlcXVlc3RpbmcgYW4gaW50ZXJydXB0LiBIb3dldmVyLCBhcmUgeW91IHN1
cmUgdGhlIElPIGNhbiBiZSBwcm9jZXNzZWQgYW5kDQo+dHJpZ2dlciBhbiBpbnRlcnJ1cHQgb25s
eSBhZnRlciB0aGUgUENJIHdyaXRlLCB3aGljaCB0aGlzIHRyaWdnZXJzPw0KPg0KVGhpcyB3YWl0
IGlzIGZvciByZWNlcHRpb24gb2YgcGFja2V0IGF0IHRoZSBkZXZpY2Ugc2lkZS4gIEJsdWV0b290
aCBjb250cm9sbGVyIGNhbiByYWlzZSB0aGUgaW50ZXJydXB0IHdpdGggZGlmZmVyZW50IGNhdXNl
cy4gSGVyZSBkcml2ZXIgd2FpdHMgZm9yIGludGVycnVwdCBCVElOVEVMXypfQ0FVU0VfMCB3aGlj
aCBpbmRpY2F0ZXMgdGhhdCBUWCBoYXMgYmVlbiBjb21wbGV0ZWQuIERldmljZSByYWlzZXMgQlRJ
TlRFTF8qX0NBVVNFXzEgaW50ZXJydXB0IHdoZW4gVFggcGFja2V0IGhhcyBiZWVuIHByb2Nlc3Nl
ZCBhbmQgdGhlcmUgaXMgc29tZSBkYXRhIGluIFJYIHF1ZXVlIHRvIGJlIHJlYWQgYnkgZHJpdmVy
Lg0KDQo+ICAgICAgICAgLyogV2FpdCBmb3IgdGhlIGNvbXBsZXRlIGludGVycnVwdCAtIFVSQkQw
ICovDQo+ICAgICAgICAgcmV0ID0gd2FpdF9ldmVudF90aW1lb3V0KGRhdGEtPnR4X3dhaXRfcSwg
ZGF0YS0+dHhfd2FpdF9kb25lLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBt
c2Vjc190b19qaWZmaWVzKEJUSU5URUxfUENJRV9UWF9XQUlUX1RJTUVPVVRfTVMpKTsNCj4NCj4J
UmVnYXJkcw0KPgkJT2xpdmVyDQoNClRoYW5rcywNCktpcmFuDQoNCg0K
