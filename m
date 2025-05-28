Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50801169AE6
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 02:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748397888; cv=fail; b=nMkkq9FCx4oXDEAGoVQdVyU47gqAWgb2rxuco8W0gU8t0JvtZIGBXNTaoi0Z7qR6Ocx+/+XYesOF/L6NFGcBwqDl80cX4twfLPtWDJpSqeIDJaIbWlVSeZOH0f0VPm9UHk1C4Z+fiMrU4P+6wlBel8Lg6mxLji77/7DeBQaOpQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748397888; c=relaxed/simple;
	bh=V64wqrJQLyuN2ATrs1bqgB2vDqA2kkwWoxsGPixnmzs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qymlKZP3jSNicCqGvpLDP0xzEJIgsTuvqCZGXYmC8dnmL0j/kFMu4dGaUBHHz4762YblJcLLrqMTJU236tQO7bUvC4UEiMKfH2HzDeulQMVmbaY2R1sAq5vCouxo05BXOxk2GHBs4XXiZMta2orNaiMrl339NsbdXas0VPd4kfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YJX35u+Q; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YJX35u+Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748397886; x=1779933886;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V64wqrJQLyuN2ATrs1bqgB2vDqA2kkwWoxsGPixnmzs=;
  b=YJX35u+Q7XXlf9bBgL6naCVZjufWfCl8q/4vgJrLXxpHKF2iG6Vg9ZRy
   WxLCnLrypGpbrtwFmu3Yei5pPYC9jQRtR5PRk3qqEqiptPByeIyC+k0DR
   bWxyIWYC49lO88HYG9oacIOtK8m1MS6Qpx3a33qlh7kz21bU4fctXPAyn
   IkXPhCBzOwIAEg/gdI7eJ1neNgzgHw7TzjdiJ7LufJLMzDBaC1mOO2fHt
   Q9BGZJhlW23bkAuFfzhZ3Lc/Casb2P1QC1MxYSGCcWGDDCe7SfYe7oqI9
   CVpqPBxQILgi+8d0tclfYZNSZuBkxfKd3luwNXlblpvUadMV0mFK9AmQS
   A==;
X-CSE-ConnectionGUID: ThXeniciRNSQA0Jg6Tvsqw==
X-CSE-MsgGUID: anqoLdiGTwWwS+DwCTSPjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="53034587"
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600"; 
   d="scan'208";a="53034587"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 19:04:46 -0700
X-CSE-ConnectionGUID: B2VdhaxKTtKpXE4ylh8/6g==
X-CSE-MsgGUID: UUkNxQ9ETti4WObDpo1clA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600"; 
   d="scan'208";a="142885307"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 19:04:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 May 2025 19:04:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 27 May 2025 19:04:45 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.43)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 27 May 2025 19:04:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BdKheVLHK0Vhe2uumrMSNvdCUcjcYasjTH/DhkZE1kvuIBAGFASw5I4uIZxpnDYSOElQYIn6j4Ua+SVsgp47tIZnrEd+C8w6BpPKUBH/aoT4F+sY+ThwbL2OW/97hIOMz+/oaRDA4MCINgHBKDeUWHnmsPQQ2oEZRf9vezfttPoPGdJjMJNxS1khpTwHeZFMkikNXUV8WqCGcsRKADRcvQ10y8kIaRSIqYyuCnGkXEXtD3LF0Csy+/TOH3hHN7DvGyUFVA3S80vuVhF2EzPdk78NF8XimKQrePrd5WzrGv6Xlgp+WtVg9yOWdtf0Xu09PWu13eka9LKPD/d7pFmM+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V64wqrJQLyuN2ATrs1bqgB2vDqA2kkwWoxsGPixnmzs=;
 b=RGMwjy4p6Y3aXk/3LMll+KMDHhyc1AAhQoXBd1Ku+vdk+lBXixB6YZk9uXWAB6jvNh8bDLIgB/Ao07Y5kys4ZdlbWtxk6j3yiOFf4Xw8DCKxB3cV1XXneO49YM1GVlnFWnhkdMNPyeTW7+So/l6mpXJDZXsxQVnA81wckqnp3b9zqtlzvKmrdGKpJLkL08jWCH7NwnGcb4CZlxatQPDP+XbiTgd6MD0ZAqIsutrMwfGJ2g1dkJHMYkphry5ozgHzy983cHFsrHsvBQcnMCPLeU1S+FXHAYhjZtWj2j6+Y2x+6NzYW4+wXLyFqh/ibr+rw5x5cDvyFsclBQC8NFUh7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by IA0PR11MB7954.namprd11.prod.outlook.com (2603:10b6:208:40e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Wed, 28 May
 2025 02:04:36 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 02:04:36 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Paul Menzel <pmenzel@molgen.mpg.de>, "Devegowda, Chandrashekar"
	<chandrashekar.devegowda@intel.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "Srivatsa, Ravishankar"
	<ravishankar.srivatsa@intel.com>, "Tumkur Narayan, Chethan"
	<chethan.tumkur.narayan@intel.com>, "Satija, Vijay" <vijay.satija@intel.com>
Subject: RE: [PATCH v1 3/3] Bluetooth: btintel_pcie: Reduce driver buffer
 posting to prevent race condition
Thread-Topic: [PATCH v1 3/3] Bluetooth: btintel_pcie: Reduce driver buffer
 posting to prevent race condition
Thread-Index: AQHbzTUl+MO30+Jw9k6G/5DqoJdbkLPi1dYAgAI40yCAAXM4gIAAyFwA
Date: Wed, 28 May 2025 02:04:36 +0000
Message-ID: <PH0PR11MB758574DCA2FABB700828178BF567A@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20250525053940.520283-1-kiran.k@intel.com>
 <20250525053940.520283-3-kiran.k@intel.com>
 <921c6c41-ca94-4833-a095-12162e70f90a@molgen.mpg.de>
 <PH0PR11MB75856C3FA9ACE3A0B795F5DCF565A@PH0PR11MB7585.namprd11.prod.outlook.com>
 <CABBYNZ+BkFpJuXoqB-pgNDRNd0-+NJLVEA8wEgyUNK3qBCHU2A@mail.gmail.com>
In-Reply-To: <CABBYNZ+BkFpJuXoqB-pgNDRNd0-+NJLVEA8wEgyUNK3qBCHU2A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|IA0PR11MB7954:EE_
x-ms-office365-filtering-correlation-id: 13dc3be9-5c24-4184-f238-08dd9d8bff44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WDVSUy9KNXQrMm1TekJEaGF6aXg3ZDhmbndEVXdMZ2EwdU5ZanU0UVpPTW5K?=
 =?utf-8?B?TXgrbkNTS0d2NTNDa0NlQWlkZTMxakhYZ3h0Q2VPVnJXOWZvSGx4TTJ2eE5s?=
 =?utf-8?B?RGh0YjlCckhvbkJRZ1hUQXF4bjNHb1NKeTNhKzNtSTVsM3lQOWkwdk9rUkdP?=
 =?utf-8?B?bVBLakJROElmT1hVTEdrdGg5VEtjUFJGY1NjNXNJcTlrY3IyVVBleFgrdGJQ?=
 =?utf-8?B?aXBsNlFOTG1WYllKQ2JwM1NaQnVJYnRYS1RVTUlGYkhHdFJwQk1US0QvVDQz?=
 =?utf-8?B?RFlyVlQ0OVNUdzJ2cldWN0E0cTNnR1BPQ3hxd3pEa2dxRXJXL0lDdkFrYTYy?=
 =?utf-8?B?MVZJaTA4Q05UN1p6L2NLaEZVL3F3S1F5dGd6NktsZ0MzZHVvMUpUS0kvRmVC?=
 =?utf-8?B?UlhsZDRKempyMElRcjc1U25rbEE3bmxrbHFEaURHbnNZb0JWUDRDVEFQOUh4?=
 =?utf-8?B?NzVFbFV5ZVVoZ0ZRdFhDdGhLVCtvTTMycmhiUWZLYjVodHFiT25FcW1yZzl5?=
 =?utf-8?B?M0ZDQWJNb3BSM3dxeEN0dC9TTkxyY053anowdlF6a2JXUHVuNCt4YVlHUXp2?=
 =?utf-8?B?NkVndWNyTFhobXNqUGdVNkh3dG1kRTc2TmRQR1REcDVoR3Y5VnNIaVUzdWRH?=
 =?utf-8?B?UHE4dXcyQVNsRFhGU3hZZHpGU2c3MzduRWY1ZDZhRUF0Q1NqT1lhREl1MGtm?=
 =?utf-8?B?VnI5UEZUbkZIT0NxNG1malhtc2c2NEVuQ1dFTkttSklENHZtTU84a2xxejdS?=
 =?utf-8?B?TDcydlIwUzhBd2xvUzQ5UDIwMTk1cHFLNDFmZklIeUJlaXZKQ2dyc2h3Tnd3?=
 =?utf-8?B?WlVTcS9URk1McTdyK2dFUjJEbUZEVS9SQlZjeCtBaFhPdDRyYUx0QVRUQTFp?=
 =?utf-8?B?UmdWc2UvRkhWQ3Fnc3g5Nmt6NElqUzZxbUwwejEzTjY2M2VkSTVmTGpVdFpm?=
 =?utf-8?B?WkVNN0lxMVRIaDRnR1NkbkpPdHpILzZNSTU2RWorU2srZjI1MEVxWTUvQnJM?=
 =?utf-8?B?MWtuNC9PalJJVUVoaERLWGRFKzN2SVRKamVWanE0bkZkd2hibGlELzU1eTVD?=
 =?utf-8?B?bE9qa3k1blhuV1EwUkNFZDZKckdjd1pmK1o0OGxGNjhxYWpqUGZ5NHlUU1U5?=
 =?utf-8?B?eVdIakFmekdGOHhieGZIWlltdFFNWWo2SXpYTGFSWGh3encveDRPM2tabjBv?=
 =?utf-8?B?bzkrUzJ3Y3ptVmpoL2dwNFlXRUpDcm9FSDZxK3ZmVjBmVFpnN0xObUNkN3NH?=
 =?utf-8?B?WVVtNXY1bVZybVlDWWZWVXpRdXZ5QnRDbHZtTkRNUmZXYVpZMmFCaUgrdFov?=
 =?utf-8?B?U2tpZ2FyM1o1MjFpRG0zM1A1aDVtWEx4eTBLcGFuRkcrMnNPQWdHV3F1L1ps?=
 =?utf-8?B?R2JZT0pYUENLdmloTDZkL2VVVFVCbWFsWUMxR3htMXNYenNsUlFCZXhiMXFH?=
 =?utf-8?B?bkxrWFZVaDhsU2ZXczkwRW4wUDJBZjh0Vk9YZWJoZkU2enNGZlFyemZUZEs5?=
 =?utf-8?B?RFgxUGdMNmRUWHF6bmovS1EzbWpML20zaTRBMi9iamN5U2NYVk9Ba2hyenJU?=
 =?utf-8?B?a0dzTGkydjkxeXNzL3pvdmxpZG5zK21IdW5UWGlBdUYrT3Q2eHcxdWVRMVBk?=
 =?utf-8?B?OWF0ZVBaWXRDU3pVdnd3d1U2eExoWC9yTjdHYi9QMyt3TDgxTkd0dHpNenR4?=
 =?utf-8?B?RU0rYm5nVEhHaFpWcGQzOVhIc0V6dTdkZ1hObzB5NWR1NFk2WFdxaTdZWHpy?=
 =?utf-8?B?d3RRek1MaDhxNDdXMGZYeFdHNmJnU21FM1ZsSWVtYkRyOG02SGlMQmtxZGY2?=
 =?utf-8?B?eVgrR0Vwei9ENVJFTkFyNWFKMis0SEduVVhFYURrcVpUMmcza2N2Y25Ma3J0?=
 =?utf-8?B?a2xlYm0xdDNmRVhjRjMxTy9oSnpnM3A3djZhS3VhZWdiWnJHQ1U1ZE9XdnNL?=
 =?utf-8?B?dUpSRXY2N3BIb0N4SC9UUDB5NjI5UGFKMTgzYWdZenBvZlRZUEl6ZU9mWGFj?=
 =?utf-8?Q?hzkq7TxPkdk9FU3FG8plduv9lVCJ2M=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2lRT21EUk9ZUXVsWVB6UFZPMno4U2NlVWJ5dXpVbVk5dU51aEZWVG1qK2VZ?=
 =?utf-8?B?Si8yc1JaWFhpdU13ay9jbDdYL2VDdXRIYnpXSWhmRndSZUJLSTJNNmpaa3Rp?=
 =?utf-8?B?a05SWTZxR3FzNFRkS1R4NEJMWW11WVFLOEh0cSsvSTlhS1V4UUpEYzJlckhl?=
 =?utf-8?B?R3RRYVJJNjczZWIzSVFYTG1DdjQreGtYSkZkRUZiczE1NnNkdGZ1aDdPUDBs?=
 =?utf-8?B?QzZMenVIb0t5WnlTRi9LOEJsQ3J3OXBQNWhqVTBzWklQL1JXZmtUU0ZTRUFU?=
 =?utf-8?B?TGdSTHR0bjRZZ1F6VmJxeS9HYWJZVUR4TTcrMHRJd29kaGl5OEZMWmQ1b3R3?=
 =?utf-8?B?RGRmL0REY1R2dzl2THMreEJNUko0UDZwY0hzRjEyTFhMbjZsdXVUc21IM1Ew?=
 =?utf-8?B?WDFZVDNnZHBjR1lRMFZCMWhUakF1RTU1UmJnbVQzd3dlYzMzbFJOUHpESlNN?=
 =?utf-8?B?Y2wxeFdXQUdnTDBlVGlDOEhiTUxJNmdENk8yMFNoUkM3SmV0OTRkcm43NTdQ?=
 =?utf-8?B?empLdjdVYnIvNFJTTnRCOVExSHA1YW43cmxoRUpCdmNkU1VsK3FidjdoYlZy?=
 =?utf-8?B?d2hNMjFJdUxCd2tUemJOaE5Wem0xTjFYUUZ3S2RodlZzVE5UdmNLUmI5RjYx?=
 =?utf-8?B?clpXbEJhanU0emw4OGV2dVRiaXdpT2FueW1XOC8vR3ozMmJUR2Vuc1dvVnRO?=
 =?utf-8?B?eDVBWjFZcVdLQ1JheDk3aVdaRFJNUlZBalEwNFUzUmR6RURzUFVRK3l4aU1Q?=
 =?utf-8?B?K3Q5UHJjOVRPY3FFdllzRlZjZm1FMU9UMnBmRVQ2ajZPbUNvNGNWc3hHWHJU?=
 =?utf-8?B?c1VhZDFwaTVYUnZHUS8vMHBINk1CTDJYdXdlc1UrRGsvLzJ4Ykl3aWdJcEl3?=
 =?utf-8?B?UUJCcW9aSUZlbnVYRi90SEsyL3pZMmxsQTNXRzYzZXBWMjNySVVLLzFIYkJv?=
 =?utf-8?B?N3hBQ3dhWFJpNlZWTjdXNGZXdzhsR0VaZmFybG92WnhWOWJOdk52cHN2SUIv?=
 =?utf-8?B?aVRKTGNNUG1FWUt5L01zTmxOSW96QkUwNFlPTWNGaHl6MFFaR2h2VjNZZ0Yz?=
 =?utf-8?B?MWNvS1ZGT3JQQmRSbXE1SmRRdDU5eUlFcW0yWlBVblZtdnpuSFM0dTJzRE15?=
 =?utf-8?B?ZGxMdmdpWUJ1OXVUV3F1dFhJVU1ZQy83YkZvZDlRM2FuczhVQWpPSmR1dWov?=
 =?utf-8?B?ZDZKQitYRmpUU3B6Ni9SOTRwNldNdkZjTDlBeWhyZ0NsbmViNUVHM2c0MExk?=
 =?utf-8?B?TnVqaDQ1cXpWOUZlMy9sMkxNVHpUQUxpN1R6MUJZS2llUy9ITHRac0Y3N2hT?=
 =?utf-8?B?dEV2NjdWa0l4L3hHM3NOWDR1S3ZsaWh5N3YveHAvVkFEYlhUTE1CV0ZvV3RE?=
 =?utf-8?B?Uml0dWxMZjdQdDVmQnJTRk9za3h3d1VNbDlQOExSOXVvLzhpMUwvN1JGVWVY?=
 =?utf-8?B?Nno4eXNVR3E4bFJrYzBsN3dwVG9uWWYzY0RQK0d5MnF3N0U0RDBVNnFtb2RS?=
 =?utf-8?B?aUhDcllnckxUeVZRR3BpcGQ5aEEreU0zRFpNTkl3cWVWcmNTYjdYVExmenlj?=
 =?utf-8?B?aWdIcS8rZ1NCWGVEQkZ6UllGN3pleHRlWWxFMElPV1BvOThxNnorakRRcUJK?=
 =?utf-8?B?dk1jNFhJU0hqMGJwcmJPeHJhRXEwWXZDM3NlNm5yQjh2ZmdLaFpGMzNBWFdz?=
 =?utf-8?B?ZGQ5OWxadGxkNUJMN3ducGpQY1oveWlRbWcxS1J1YkVUOFI4NDJQeFJhYnhu?=
 =?utf-8?B?M2pOQUtHUU1SQ2xIV09CL05YL1N5SWh5RjBmVGVRSkxYOW96U2k2U3YwS0J0?=
 =?utf-8?B?UnR3cDBaclJON2J3U1o1d05CTFhOaFUzTmxKUnhHbDUxNmpaTmhTZEthUU5Y?=
 =?utf-8?B?TkNPd1M2RStZRWZURUkrWXlxYUZCdWhqZGJLc1lNSjI1R1UrTzg3VmNlaXhq?=
 =?utf-8?B?TDhkTi8yZ2dzSldLemJOL0RyY1dsM1F5RWxlRkd3NTJIcDdsVmhwQW51Qndw?=
 =?utf-8?B?Uy9VVkZVVjB4bE13dUZ3S1RYN0lPMmhsM3lrTHR5RWJpS0xNR3VWNGZSQjc4?=
 =?utf-8?B?UFBTY2Y4eVRLTnlaQmdIcHJSTjkyRCtuVFVBUGx6R0k2cURZS25EMFdmZlFZ?=
 =?utf-8?Q?b/fE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 13dc3be9-5c24-4184-f238-08dd9d8bff44
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 02:04:36.4815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FQZekdQ4qnNCVBBlSm1/jcM18KzBizNRtAEKJXgIEtQrAU5nfIKvKDTfAHwr1GmPilO5Zc/Ac+v3qjeZEdNxag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7954
X-OriginatorOrg: intel.com

SGkgTHVpeiwNCg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMy8zXSBCbHVldG9vdGg6IGJ0aW50
ZWxfcGNpZTogUmVkdWNlIGRyaXZlciBidWZmZXINCj5wb3N0aW5nIHRvIHByZXZlbnQgcmFjZSBj
b25kaXRpb24NCj4NCj5IaSBLaXJhbiwNCj4NCj5PbiBNb24sIE1heSAyNiwgMjAyNSBhdCAxMTo1
OOKAr0FNIEssIEtpcmFuIDxraXJhbi5rQGludGVsLmNvbT4gd3JvdGU6DQo+Pg0KPj4NCj4+IEhp
IFBhdWwsDQo+Pg0KPj4gVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KPj4NCj4+ID5TdWJqZWN0
OiBSZTogW1BBVENIIHYxIDMvM10gQmx1ZXRvb3RoOiBidGludGVsX3BjaWU6IFJlZHVjZSBkcml2
ZXINCj4+ID5idWZmZXIgcG9zdGluZyB0byBwcmV2ZW50IHJhY2UgY29uZGl0aW9uDQo+PiA+DQo+
PiA+RGVhciBDaGFuZHJhc2hla2FyLCBkZWFyIEtpcmFuLA0KPj4gPg0KPj4gPg0KPj4gPlRoYW5r
IHlvdSBmb3IgdGhlIHBhdGNoLg0KPj4gPg0KPj4gPkFtIDI1LjA1LjI1IHVtIDA3OjM5IHNjaHJp
ZWIgS2lyYW4gSzoNCj4+ID4+IEZyb206IENoYW5kcmFzaGVrYXIgRGV2ZWdvd2RhDQo+PGNoYW5k
cmFzaGVrYXIuZGV2ZWdvd2RhQGludGVsLmNvbT4NCj4+ID4+DQo+PiA+PiBNb2RpZnkgdGhlIGRy
aXZlciB0byBwb3N0IDMgZmV3ZXIgYnVmZmVycyB0aGFuIHRoZSBtYXhpbXVtIHJ4DQo+PiA+PiBi
dWZmZXJzDQo+PiA+PiAoNjQpIGFsbG93ZWQgZm9yIHRoZSBmaXJtd2FyZS4gVGhpcyBjaGFuZ2Ug
bWl0aWdhdGVzIGEgaGFyZHdhcmUNCj4+ID4+IGlzc3VlIGNhdXNpbmcgYSByYWNlIGNvbmRpdGlv
biBpbiB0aGUgZmlybXdhcmUsIGltcHJvdmluZyBzdGFiaWxpdHkNCj4+ID4+IGFuZCBkYXRhIGhh
bmRsaW5nLg0KPj4gPg0KPj4NCj4+ID5JbnRlcmVzdGluZy4gUGxlYXNlIGVsYWJvcmF0ZSwgd2hp
Y2ggZmlybXdhcmUgdmVyc2lvbnMgYXJlIGFmZmVjdGVkLA0KPj4gPmFuZCBpZiBhIGZpeCBpcyBn
b2luZyB0byBiZSBleHBlY3RlZCwgYW5kIGhvdyB0byByZXByb2R1Y2UgdGhlIGlzc3VlLA0KPj4g
PnNvIGl0IGNhbiBiZSB0ZXN0ZWQgd2l0aG91dCBhbmQgd2l0aCB5b3VyIHBhdGNoLg0KPj4gPg0K
Pj4gVGhlIGZpcm13YXJlIGlzIGZvciB0aGUgdXBjb21pbmcgcHJvZHVjdCBhbmQgaXMgbm90IGF2
YWlsYWJsZSBpbiBwdWJsaWMgeWV0Lg0KPkFzIEkgc2FpZCBpbiAxLzMsICB0aGUgaXNzdWUgaXMg
c2VlbiBvbiBhbmRyb2lkIGtlcm5lbCBhbmQgIGl0J3MgdmVyeSBoYXJkIHRvDQo+cmVwcm9kdWNl
IHRoZSBpc3N1ZSBvbiB2YW5pbGxhIGtlcm5lbC4NCj4NCj5JZiBpdCBhZmZlY3RzIEFuZHJvaWQg
c3BlY2lmaWMgdmVyc2lvbnMgb25seSB0aGVuIGl0IHNob3VsZCBiZSBwb3N0ZWQgZm9yDQo+dXBz
dHJlYW0sIGFueXdheSB0aGlzIHNvdW5kcyBsaWtlIGl0IGlzIG1vcmUgb2YgYSB3b3JrYXJvdW5k
IHRoZW4gYSBwcm9wZXIgZml4DQo+Zm9yIHRoZSBwcm9ibGVtLg0KDQpUaGUgaXNzdWUgaXMgc2Vl
biBvbiBMaW51eCBhbHNvIGJ1dCB0aGUgcmVwcm9kdWN0aW9uIHJhdGUgLSAoMS8yNSkgaXMgbGVz
cyBjb21wYXJlZCB0byBhbmRyb2lkICgxLzUpLiBBcyB0aGUgZmlybXdhcmUgY29udGVudCBpcyBz
YW1lIGZvciBib3RoLCBJIGZlZWwgdGhpcyB3b3JrIGFyb3VuZCAgaXMgYXBwbGljYWJsZSBmb3Ig
TGludXggYXMgd2VsbC4NCj4NCj4+ID5JcyB0aGUgZXJyYXRhIHB1Ymxpc2hlZD8NCj4+ID4NCj4+
IE91ciBpbnRlcm5hbCBkb2N1bWVudHMgYXJlIHVwZGF0ZWQuICBJIGhhdmUgYWxzbyBlbnRlcmVk
IGEgY29tbWVudCBpbg0KPmNvZGUuDQo+Pg0KPj4gPiBXaHkgdGhyZWUgYnVmZmVycyBsZXNzIGFu
ZCBub3QgdHdvIG9yIGZvdXI/DQo+PiBUaGUgcmVjb21tZW5kYXRpb24gZnJvbSBmaXJtd2FyZSAv
IEhXIGlzIHRvIHVzZSBhdCBsZWFzdCAzIGJ1ZmZlcnMgYXMgZ3VhcmQNCj5idWZmZXJzLiBBbnl0
aGluZyBsZXNzIHRoYW4gdGhyZWUgY2F1c2VzIFJGSCAocmVjZWl2ZSBmbG93IGhhbmRsZXIgLSBS
WCBwYXRoKQ0KPmJsb2NrYWdlLg0KPg0KPkFyZSB0aGVzZSBidWZmZXJzIGRpc2NvdmVyZWQgYXQg
cnVudGltZSBvciB0aGV5IGFyZSBoYXJkY29kZWQsIGZvciB0aGUgZm9ybWVyDQo+dGhlbiB0aGUg
ZmlybXdhcmUgc2hhbGwgYmUgYWRqdXN0ZWQgdG8gZ2l2ZSBhIHByb3BlciBudW1iZXIgYW5kIGlu
IGNhc2Ugb2YgdGhlDQo+bGF0ZXIgdGhlbiB0aGUgZHJpdmVyIHNoYWxsIGJlIHVwZGF0ZWQsIGVp
dGhlciB3YXkgaGF2aW5nIHRvIGRvIC0zIHNvdW5kcyBsaWtlIGENCj5iYWQgaWRlYSBpbiB0aGUg
bG9uZyB0ZXJtLg0KPg0KVGhlIG1heGltdW0gbnVtYmVyIG9mIGJ1ZmZlcnMgZm9yIFJYIChOKSBh
bmQgdGhlIGJ1ZmZlcnMgZ3JhbnRlZCBmb3IgZmlybXdhcmUoTi0zKSAgYXJlIGhhcmRjb2RlZC4g
QXMgdGhlIGlzc3VlIGlzIHJlbGF0ZWQgdG8gdGhlIGhhcmR3YXJlLCBpdCB3b3VsZCB0YWtlIHNv
bWV0aW1lIHRvIGdldCBpdCBmaXhlZC4gDQo+DQo+PiA+T3V0IG9mIGN1cmlvc2l0eTogRG9lcyB0
aGUgTWljcm9zb2Z0IFdpbmRvd3MgZHJpdmVyIGRvIHRoZSBzYW1lPw0KPj4gWWVzLg0KPj4NCj4+
ID4NCj4+ID4+IFNpZ25lZC1vZmYtYnk6IENoYW5kcmFzaGVrYXIgRGV2ZWdvd2RhDQo+PiA+PiA8
Y2hhbmRyYXNoZWthci5kZXZlZ293ZGFAaW50ZWwuY29tPg0KPj4gPj4gU2lnbmVkLW9mZi1ieTog
S2lyYW4gSyA8a2lyYW4ua0BpbnRlbC5jb20+DQo+PiA+PiAtLS0NCj4+ID4+ICAgZHJpdmVycy9i
bHVldG9vdGgvYnRpbnRlbF9wY2llLmMgfCA1ICsrKystDQo+PiA+PiAgIDEgZmlsZSBjaGFuZ2Vk
LCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+ID4+DQo+PiA+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmMNCj4+ID4+IGIvZHJpdmVycy9ibHVl
dG9vdGgvYnRpbnRlbF9wY2llLmMNCj4+ID4+IGluZGV4IDAzZjEzZGU0YTcyMy4uMTRmMDAwZTA4
ZTFlIDEwMDY0NA0KPj4gPj4gLS0tIGEvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmMN
Cj4+ID4+ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5jDQo+PiA+PiBAQCAt
Mzk4LDcgKzM5OCwxMCBAQCBzdGF0aWMgaW50IGJ0aW50ZWxfcGNpZV9zdGFydF9yeChzdHJ1Y3QN
Cj4+ID5idGludGVsX3BjaWVfZGF0YSAqZGF0YSkNCj4+ID4+ICAgICAgaW50IGksIHJldDsNCj4+
ID4+ICAgICAgc3RydWN0IHJ4cSAqcnhxID0gJmRhdGEtPnJ4cTsNCj4+ID4+DQo+PiA+PiAtICAg
IGZvciAoaSA9IDA7IGkgPCByeHEtPmNvdW50OyBpKyspIHsNCj4+ID4+ICsgICAgLyogUG9zdCAo
QlRJTlRFTF9QQ0lFX1JYX0RFU0NTX0NPVU5UIC0gMykgYnVmZmVycyB0byBvdmVyY29tZSB0aGUN
Cj4+ID4+ICsgICAgICogaGFyZHdhcmUgaXNzdWVzIGxlYWRpbmcgdG8gcmFjZSBjb25kaXRpb24g
YXQgdGhlIGZpcm13YXJlLg0KPj4gPg0KPj4gPklmIHlvdSBoYWQgYW4gZXJyYXRhLCBpdOKAmWQg
YmUgZ3JlYXQgdG8gZG9jdW1lbnQgaXQgaGVyZSB0by4NCj4+ID4NCj4+ID5J4oCZZCByZW1vdmUg
KnRoZSouDQo+PiBBY2sNCj4+ID4NCj4+ID4+ICsgICAgICovDQo+PiA+PiArICAgIGZvciAoaSA9
IDA7IGkgPCByeHEtPmNvdW50IC0gMzsgaSsrKSB7DQo+PiA+PiAgICAgICAgICAgICAgcmV0ID0g
YnRpbnRlbF9wY2llX3N1Ym1pdF9yeChkYXRhKTsNCj4+ID4+ICAgICAgICAgICAgICBpZiAocmV0
KQ0KPj4gPj4gICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4+ID4NCj4+ID4NCj4+
ID5LaW5kIHJlZ2FyZHMsDQo+PiA+DQo+PiA+UGF1bA0KPj4NCj4+IFJlZ2FyZHMsDQo+PiBLaXJh
bg0KPj4NCj4NCj4NCj4tLQ0KPkx1aXogQXVndXN0byB2b24gRGVudHoNCg0KVGhhbmtzLA0KS2ly
YW4NCg0K
