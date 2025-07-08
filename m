Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E10282EE
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 12:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751977445; cv=fail; b=eWPwrf39XkOvzKczYyvdnUDeBsZqv711BertkzdMUqYCVi++88/zrLbp9u3ZUXMGIU7qfyiX9WeQ2bSLZfelOZRODpx5kU7fK4H32hADB5n4/eVVXw0bdlpcaAZ0+WsjrpGnUuMNG4sMHPj66jPru4xNbaQ32KBT9zEs1Ox/cQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751977445; c=relaxed/simple;
	bh=MabGz5CZSm7NKBmCoeBdsXafe2yxe6XALM9ddWRojSw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SsOcxVNR6F7VS3vNjB1YMRzrRC9ot1zck+U9e/nn0prC9kV4J4IbbvYDOR7SCc2CQDtue2SS78pMWUyF7M3myhX09DoaJpHp0mHPCPNZAYd1bqwSEbu42ZzuT3R1YZL/efuXs1yhsBUpU1j/kpfrd8X6DcOrocpl1f52kL9Tr6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OY76Nlzc; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OY76Nlzc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751977444; x=1783513444;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MabGz5CZSm7NKBmCoeBdsXafe2yxe6XALM9ddWRojSw=;
  b=OY76NlzcQb3sGhkKCEhEak+43AvExhJwkIYi2g1CVjpdCIkIc32KIdbh
   TTWdL8d5u6WDOEX5z+V2fdI5bCIWxiVgG6sXi3fxSe9B3Tfcf+9UHsJ4a
   xE04nADUgRXZnf6et2jUSV4gDtxsB12KIa3RZZnK5V69xAfv5pWasEbxe
   rR9tAbuudXJRhXyNCD/LBKRsdjbJs6jzGaT3LFVTaCN59rY6jFXlwcEgV
   rwArzN4av4WV/mPfTlcE4VIBk4rgQGHNzUjjAD26VJnBixFHqCOQedQA+
   BtSfPCH9bu3brif/uXvY0oL4Y7uY8EQyEkQ20tXEtFu60sizRVifZa90p
   Q==;
X-CSE-ConnectionGUID: EnreghKWTLGHeLGs61yMxQ==
X-CSE-MsgGUID: Z8+dfCk1TV22Qo+G2VOBmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54308158"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="54308158"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 05:24:03 -0700
X-CSE-ConnectionGUID: vrzd8PvURCq9aqtxvblBRQ==
X-CSE-MsgGUID: 6nUlEMTVQa6CjU3oV9oIGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="154891378"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 05:24:02 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 05:24:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 05:24:02 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.89)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 05:24:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfKF6skH3eegw51YiF2WU7wMgBMxpg31DtbrNx2a5sod4od4nJ1JYnN/IugDd6L1f4rlFgUKxTVKTldBjDiSqnXKypcBzTZFmrWY9aPL0kexmKJHY29xXptPpuSdk8SCNzv6FzqrwQkkgdol8qU0H/jo3vB+I4c5ipq9iT++KwvJ0YMb44aRnnxtEeYnkfDA8TE01yRW8ZDSA0acOypbX+XtzKj6J1DwFNNMoMoTBvuJMTJQ2g/Y2H0QiyqjHJTJ4MG7or+pJ5HIBp61u6OctKkznweoMkWCg+nN+gfSKKMZCROhQ/LwDn/OMAQjjoJ1Hq/ScW6FM1bpYnainmP0tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MabGz5CZSm7NKBmCoeBdsXafe2yxe6XALM9ddWRojSw=;
 b=QJBIUHGY6HrH45qlIP23B++8g2WTpzOSR2AKPazsHiusti3EK9pqjry5QAiccyvLxaDFoFF0fk1Uv7lOG2w50H3PKlr0KfekScfJ+yIiDBtyanKJRQd8/IVHf9k2syzxz1pR6fKO5uehQ42DkCCntN0q0+VHPuc+H359lOi2QzdNZFfNV9GVis3mJ0FgtMP69rmu26JRmaQciu9p5XAdfBOyYWPIN5ZppGkAJFkX47nRh8PHIFW3SMr8Hxkmf9ys6ZFvyHrqOJE0ZDLZmtBeN34BYmoZLwrieUu5lk3NhYLBt7iw0CL+L5H1mhkr3Bq7fjhBhpwWdcCjkArzg+1W7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by PH7PR11MB5885.namprd11.prod.outlook.com (2603:10b6:510:134::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Tue, 8 Jul
 2025 12:23:44 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%2]) with mapi id 15.20.8901.021; Tue, 8 Jul 2025
 12:23:44 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>, Aluvala Sai Teja
	<aluvala.sai.teja@intel.com>
CC: "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, "Devegowda, Chandrashekar"
	<chandrashekar.devegowda@intel.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v1 1/2] Bluetooth: btintel_pcie: Make driver wait for
 alive interrupt
Thread-Topic: [PATCH v1 1/2] Bluetooth: btintel_pcie: Make driver wait for
 alive interrupt
Thread-Index: AQHb7u+DytQ/+OqxGUy5ACz03ltmJrQmLRAAgAH3lsA=
Date: Tue, 8 Jul 2025 12:23:44 +0000
Message-ID: <PH0PR11MB7585AF4917BFA37FD1A29AE4F54EA@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20250707034657.929092-1-kiran.k@intel.com>
 <e3bcf617-7b9f-4229-89a0-12ea9e0e001b@molgen.mpg.de>
In-Reply-To: <e3bcf617-7b9f-4229-89a0-12ea9e0e001b@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|PH7PR11MB5885:EE_
x-ms-office365-filtering-correlation-id: 8b843d6b-d899-4d5c-4417-08ddbe1a482c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eXFidjRWbWpvbXQyVzZ2WDhUdnp0UDVlaDF1aGxjY0VSZmxyRnBSRXhvM2tM?=
 =?utf-8?B?Q0xrVU4zNzFROVpyaStFMDJ5TWNOcW03UGJsNFp5T3Q5OHBxZGEyZ3lOSkEz?=
 =?utf-8?B?VFRmN1VsL2R2akM5YnlNUVJSUUwzVDFReDk1OXk5TERBeWdiMFJuYnI5aUxI?=
 =?utf-8?B?akJ0cWt0SUN5S3d3S0hLdXJ1cGVab1ExQWxQSkxuVmFiTTBxTjVFa0xmTHZH?=
 =?utf-8?B?QW5BUFlhSzJkdlcvT1B6a0ViUW5ucFpiNWpzR3JtejNsRlRaMGdNMkg4enht?=
 =?utf-8?B?ODlyRGJJK3RCc0tpK2NIZ0lqV3VXZHJyc28vN0pzaVA5QlBxZnFCeE9iR2F0?=
 =?utf-8?B?VGdYelhDaENVQ0JvK2RFdHVLQnVrbXFKNHlUa0tuU05NZ0ZSZ1dJTXh0Vi95?=
 =?utf-8?B?a1c1a2hDZGEzUElodDQ3b3ZkaU1sbnhBdUdQZk5zeGI3S0dNQ2c3bytaRkl6?=
 =?utf-8?B?KzBTczF2cmdySUlSdlJMRmd3OC9DZWM4RlpPMDZ6Y29mNEh0M21WVFkyNVAr?=
 =?utf-8?B?Mlp3SGNBTW5EN0ttU3hvZG1wNjMzYlBWTWNBK2krM1RuV0hDWm9ONUFRNC9y?=
 =?utf-8?B?TTN6MElqQjZNSy93Y2Q5QkUxaGgzZ3F5cFRZdjRma0R2SVhLdkxIQUczUGpS?=
 =?utf-8?B?elJjd04zd0RyTzZXNTVEWmcyWWJOQTltS3JlQ29iaDA2dC96bWRNNm5lVU9h?=
 =?utf-8?B?c0VEb3c1U3EzZU5ScTh1OXhkVFN3bGV0NlFQRS9SNGo2dm4xclhGQkxhQUNC?=
 =?utf-8?B?YWRXb2JaL09pb1FxbXVWb2pCK2ordUlkanI4OUF6eVlHV2pHbVgza3EwVHQx?=
 =?utf-8?B?QWVFM1E4eWZxWmJ2MGgvY0VNUVFVMVVwRlducVNGRFFXbDBFWncrMEhLTXp1?=
 =?utf-8?B?bWhWa0p4K1Vod2YzRG9HRjVxa25NZmRDMGVMMktsTlNkejF4c3RvVHI5eEtF?=
 =?utf-8?B?YTdaTUYwajJjc0VGTTZKcDBXK1VFTndqNUtGK0k2bE5aZFZiWFgxajR1dXYy?=
 =?utf-8?B?TDN3VFJtQlRGQXBzRS9ZMHRBVHk0TDBGWTFuVzhPUFRWS3lnTlZLYk5rQUZH?=
 =?utf-8?B?ZXRRVG5rckNZdTJNWlpnUXFDY1dJRS9SQ2IxS2ZQRmljdEdpQklDK1IrK01Z?=
 =?utf-8?B?V0Jnc25PdGhyOWtzWjYyanZRTnMyR2lDS2pwR0RoUHNyZzF2TGw2UTJuT0hu?=
 =?utf-8?B?dTFOZmhWMTZxNk9EODlCREYveDZscEYyS05FclRxZEk3TTZ3YUZuTVdJWjBz?=
 =?utf-8?B?QTAyUklnekxVRWhnU3A4cElhYnppZzJydjZheGJmUHZINzM2b2xVYW9KdnhN?=
 =?utf-8?B?dG5ldHFDWTVrQTFsVllYaWYrYUVNQlBvT3NFZG1YVFcyZFdaN203RU1IVGNP?=
 =?utf-8?B?ZnB3Y1pTR1dTVkhQcnZjVkFPdVRLQUlaN285VzRwaFVzdkcrOWMzd0NpWEhB?=
 =?utf-8?B?MFFmYldsMkdtZnE4a0tXZ09FcFEwekxtZFVOc0dJWG5lblRMamZMRWlLK3VH?=
 =?utf-8?B?cVlNVlBpa2NvWUdJbEdoalFybUJzRjMyVnRwNW12ZUJiL1E3QjErNVpsSENq?=
 =?utf-8?B?RlNOZHlVSy80NUYrT0hqeXVrMU13ZlNac2tDTXBEZmJWSVBsaytveW5OQVFE?=
 =?utf-8?B?RzNkK1krMlRsTWFrV3JlYis4czVTV000bjk2WTdjM0lPT3VXK2lBWWZsdnht?=
 =?utf-8?B?dGxkK1JOU2ZmVDhOZk9HRXdCd0JNVE1VblJTQVhDcnhENFVIaWJWYmE5eFhH?=
 =?utf-8?B?eEt0b2lXclJ3YUIyNVpXc2ZZM2Y1bUtrUkhqMkUyUSt5RmJ4dTVjaVJSbVND?=
 =?utf-8?B?NVFveW9WVS9ZcTlCdzRNR2lqaTZxZnpCMDZxYWFuU0Y1ZmlmRzhGeHEvTHZx?=
 =?utf-8?B?T1RmYlZsVE5QT1pSbXd3WVBkRWVMMlQ2c0FMRlRCa3lsY1FsaWtoQXlOZS9y?=
 =?utf-8?B?cnQzN1E4NER1Vzl6c0dBRnV4TUpjeG1VUW5BOVFwN0ErcjcvZEFoT1RUQjU0?=
 =?utf-8?B?Nmg3UHFKeEtRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TW9CM0MzZFhiV3pEZk9MeXk5blozWHVWVTcrc0JGQlBTbEt0L1drR3RpeEVa?=
 =?utf-8?B?aWtJT1R0eFY3eHEwRm5MMkswMVUzSVRIb3dRa0prdm5acitKUzVZZm52bHBR?=
 =?utf-8?B?N28rdmp5TXNLV1EvSGt5SGJKeGJBSEw3UnNrUS9FMktMVkpkMExXK0kvQXQz?=
 =?utf-8?B?a0F5eDdnVktPMXNLZEk4VDNLak1QWCt6TG1ySVNtYjNHVGtBN3c3WTNnQ09r?=
 =?utf-8?B?YkFQK3JkbzlFalJ0MUZldE0zYm50MWhBcXd2WnJOVHJMbHdRLzVTcTR0dC9K?=
 =?utf-8?B?aVZUSnlHZG8xTEJ5NkZ6QXlmYnlmejk4UnVIcXlTK3FpVHFKdWkwTTkyUVFG?=
 =?utf-8?B?YmtKNVhwMFFsOHhvZG53Wi9GTU5GTEl4dWdQalVUMlkwaTl2aXROcjJWVzJ1?=
 =?utf-8?B?Z21ZYVg4bk1qRGtIVEU4YXhvR3BickEzVkxlZkkxNExzZFpNeUhUYmNYVXoz?=
 =?utf-8?B?Q0c1ZGx4L0RKUk1lVFhObHViL0Qza1V4VUNqb09meS9nVFNRNmFCdDB5TDBj?=
 =?utf-8?B?Y2tFUEw0UHVWV083dkJ2VkNPcStYOWZjU2JaU1FYSkFvZTEwalNUREppT1Q1?=
 =?utf-8?B?ajVCYzNZWWpzYzlqeHNFdjRRd0xzbkUrQTkwUnBUVHpSbCtadCtLY3d2Vi83?=
 =?utf-8?B?dTByYXN2OUlaZUVKYXNtYmtVMndURmZDQVN5U1FSSGcxbWJCMzAwRTJud2w5?=
 =?utf-8?B?VmI5YzBjUkx4R3BlR1FaSzFKcktvL0Y4NnQ3NmE1cEgwSm0zUjhnbnVlbExY?=
 =?utf-8?B?aHJ4M3NpSk1pR0hxOUJITXpsN2VVRFB0RjhmQjRoanp0dUltcnV5UTl6aE93?=
 =?utf-8?B?cnhhUFFnTlNBRC9TK2NNS1VKcHFBbGQxeFlqTjJKNGRaSU5vSEs0RHNWME5a?=
 =?utf-8?B?VE1INklWNWZqc3VBK2V5OHM1bFhWbmFvZFNMT0pJMmcwNEUwRnpKV0RwOEY0?=
 =?utf-8?B?UGplUGNsMThQNERXY200akR3Tk5rK1o5RnVJclBwTTBkZlh3OEN1QnowZjV0?=
 =?utf-8?B?WmxwbWxMbWVac2pYQmtvbkNIQlJpQVg4WVV0L0l3eFcrOUxmeDlGN3FvOWp5?=
 =?utf-8?B?dnZ4ZzE5R3ZBNUlrNEpSTHUyNkpCaFdCeEkxTklxM2NLb3BERnBuSnBiL2dO?=
 =?utf-8?B?dWtVN3BqZUtUR0F4VHpyeWIrWERkQjB0ejZrcEdia3NodVBrZUpkU3B1RVkw?=
 =?utf-8?B?SFBUbVhjNFB3V1ErS0ZRVFBtQWtNMXRyRGxiQlJwYUdYcE1iVUMzdFZmK09J?=
 =?utf-8?B?MXd6VU9heTF5MUNXOGliNzVkaVUvbHgzalNjT1pHeWZoME40SHRoSWFlcUxq?=
 =?utf-8?B?eVVkUEJ6eVhVMnZ6RTJOK3BMNzhtY052dnFLZkVWbG9rWENlelIvUC9RQWU5?=
 =?utf-8?B?bzcxeFZkeWJ3M2dYa2s5WFFFV2U2Z1Q0R3ZFNVU3ZjBqSHJwbXk3Z1VPMWZo?=
 =?utf-8?B?TEZHZ0RSci80TEt0TkJHYTdKbEZhY0hBWGphVUxuMlo5Rm15YXova2dGdC9L?=
 =?utf-8?B?b21EZ2hnbldtZFZQOWFXM2NYTGxBam9OR0NWT1JONjBTQ3hOd0I4TGloeHpM?=
 =?utf-8?B?UlUrbHZwRmM2TXo3QTk1ekRiZHVTZTRtZEFyVzRQcVVucFUrVDdhL2NVZ0ZR?=
 =?utf-8?B?RDJUM2k0NGhMU3Y5TEcyTEFFTmdHSHRtVnVNNlVCNTZtenFIbTJLc2JGQVV2?=
 =?utf-8?B?QTdXRUJLTEpKQkFVUVREVGJkVG5HUmF6L2lDUTMwdEFPOHJSKy9Da3FCUXJW?=
 =?utf-8?B?L3lEYXdJSjZsSzJER0VKUDhXWDNPT2tRbklkZlNyNVY3WEVRanRSVi92am05?=
 =?utf-8?B?Ukd6V0NFYi9IVk1SM2VUVUtGR09RT21OZk05ZktibVMycmRRWXRWKzlWNk5w?=
 =?utf-8?B?S1pKR1RFTnJXN1VlTVJNMkVYeklHajRBdndHaHp1SHMvcCtZTGQvVy9zSnFn?=
 =?utf-8?B?dHNUUTZUWjN4WHg2Y3hzeXZ4dzBzRnlabE1QUVNoK2tRZnlHWC84SGJLOC9x?=
 =?utf-8?B?WEt0Ty9maDRPbFluUkpnUklNVGZVRGw2dzBVTFRZVHJyK2piOFBDeXZDTjl0?=
 =?utf-8?B?b3NGcHdmWTFaSHU5ZWlyOXJMdGNKTFlscmRWbXZFWGwwQXlvL2dVTDFjQUZC?=
 =?utf-8?Q?5nOQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b843d6b-d899-4d5c-4417-08ddbe1a482c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 12:23:44.5144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RP3ob5uXBid1B3F5wUrH1OqRxZ3Caa29ltv0adv+ED/NWedwIsQlHJ8pz2xXHuY/kORvmwsqlgy5PT/lrK2Ykw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5885
X-OriginatorOrg: intel.com

SGkgUGF1bCwNCg0KVGhhbmtzIGZvciB0aGUgY29tbWVudHMuDQoNCj5TdWJqZWN0OiBSZTogW1BB
VENIIHYxIDEvMl0gQmx1ZXRvb3RoOiBidGludGVsX3BjaWU6IE1ha2UgZHJpdmVyIHdhaXQgZm9y
IGFsaXZlDQo+aW50ZXJydXB0DQo+DQo+RGVhciBTYWksIGRlYXIgS2lyYW4sDQo+DQo+DQo+VGhh
bmsgeW91IGZvciB5b3VyIHBhdGNoLg0KPg0KPkFtIDA3LjA3LjI1IHVtIDA1OjQ2IHNjaHJpZWIg
S2lyYW4gSzoNCj4+IEZpcm13YXJlIHJhaXNlcyBhbiBhbGl2ZSBpbnRlcnJ1cHQgdXBvbiByZWNl
aXZpbmcgdGhlIDB4ZmMwMSAoSW50ZWwNCj4+IHJlc2V0KSBjb21tYW5kLiBUaGlzIGNoYW5nZSBm
aXhlcyB0aGUgZHJpdmVyIHRvIHByb3Blcmx5IHdhaXQgZm9yIHRoZQ0KPj4gYWxpdmUgaW50ZXJy
dXB0Lg0KPg0KPldoYXQgaXMgdGhlIGNvbnNlcXVlbmNlIG9mIG5vdCB3YWl0aW5nPw0KDQpUaGlz
IGlzIGFuIGFsaWdubWVudCBiZXR3ZWVuIGRyaXZlciBhbmQgZmlybXdhcmUuIElmIGRyaXZlciBk
b2VzbuKAmXQgd2FpdCBmb3IgYWxpdmUgaW50ZXJydXB0LCB0aGVuIHRoZXJlIGlzIGNoYW5jZSBv
ZiBzdGFjayBzZW5kaW5nIGNvbW1hbmRzIGJlZm9yZSB0aGUgZmlybXdhcmUgaXMgcmVhZHkgdG8g
YWNjZXB0Lg0KPg0KPj4gU2lnbmVkLW9mZi1ieTogU2FpIFRlamEgQWx1dmFsYSA8YWx1dmFsYS5z
YWkudGVqYUBpbnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBLaXJhbiBLIDxraXJhbi5rQGlu
dGVsLmNvbT4NCj4+IEZpeGVzOiAwNWMyMDBjOGYwMjkgKCJCbHVldG9vdGg6IGJ0aW50ZWxfcGNp
ZTogQWRkIGhhbmRzaGFrZSBiZXR3ZWVuDQo+PiBkcml2ZXIgYW5kIGZpcm13YXJlIikNCj4+IC0t
LQ0KPj4gICBkcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuYyB8IDI3ICsrKysrKysrKysr
KysrLS0tLS0tLS0tLS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwg
MTMgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0
aW50ZWxfcGNpZS5jDQo+PiBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5jDQo+PiBp
bmRleCAxMTEzYTYzMTBiZDAuLmY4OTNhZDZmYzg3YSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMv
Ymx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5jDQo+PiArKysgYi9kcml2ZXJzL2JsdWV0b290aC9idGlu
dGVsX3BjaWUuYw0KPj4gQEAgLTk0NywxMSArOTQ3LDEzIEBAIHN0YXRpYyB2b2lkIGJ0aW50ZWxf
cGNpZV9tc2l4X2dwMF9oYW5kbGVyKHN0cnVjdA0KPmJ0aW50ZWxfcGNpZV9kYXRhICpkYXRhKQ0K
Pj4gICAJY2FzZSBCVElOVEVMX1BDSUVfSU5URUxfSENJX1JFU0VUMToNCj4+ICAgCQlpZiAoYnRp
bnRlbF9wY2llX2luX29wKGRhdGEpKSB7DQo+PiAgIAkJCXN1Ym1pdF9yeCA9IHRydWU7DQo+PiAr
CQkJc2lnbmFsX3dhaXRxID0gdHJ1ZTsNCj4+ICAgCQkJYnJlYWs7DQo+PiAgIAkJfQ0KPj4NCj4+
ICAgCQlpZiAoYnRpbnRlbF9wY2llX2luX2ltbChkYXRhKSkgew0KPj4gICAJCQlzdWJtaXRfcngg
PSB0cnVlOw0KPj4gKwkJCXNpZ25hbF93YWl0cSA9IHRydWU7DQo+PiAgIAkJCWRhdGEtPmFsaXZl
X2ludHJfY3R4dCA9IEJUSU5URUxfUENJRV9GV19ETDsNCj4+ICAgCQkJYnJlYWs7DQo+PiAgIAkJ
fQ0KPj4gQEAgLTE5ODUsOCArMTk4Nyw5IEBAIHN0YXRpYyBpbnQgYnRpbnRlbF9wY2llX3NlbmRf
ZnJhbWUoc3RydWN0IGhjaV9kZXYNCj4qaGRldiwNCj4+ICAgCQkJaWYgKG9wY29kZSA9PSAweGZj
MDEpDQo+PiAgIAkJCQlidGludGVsX3BjaWVfaW5qZWN0X2NtZF9jb21wbGV0ZShoZGV2LA0KPm9w
Y29kZSk7DQo+PiAgIAkJfQ0KPj4gLQkJLyogRmlybXdhcmUgcmFpc2VzIGFsaXZlIGludGVycnVw
dCBvbiBIQ0lfT1BfUkVTRVQgKi8NCj4+IC0JCWlmIChvcGNvZGUgPT0gSENJX09QX1JFU0VUKQ0K
Pj4gKw0KPj4gKwkJLyogRmlybXdhcmUgcmFpc2VzIGFsaXZlIGludGVycnVwdCBvbiBIQ0lfT1Bf
UkVTRVQgb3INCj4weGZjMDEqLw0KPg0KPkEgc3BhY2UgaXMgbWlzc2luZyBiZWZvcmUgKi8uDQpB
Y2suDQoNCj4NCj4+ICsJCWlmIChvcGNvZGUgPT0gSENJX09QX1JFU0VUIHx8IG9wY29kZSA9PSAw
eGZjMDEpDQo+DQo+UGxlYXNlIGRlZmluZSBhIG1hY3JvIGZvciB0aGUgbWFnaWMgbnVtYmVyLg0K
Pg0KVGhpcyBpcyB2ZW5kb3Igc3BlY2lmaWMgb3Bjb2RlIGFuZCBpcyBhbHNvIHNoYXJlZCBhY3Jv
c3MgYnRpbnRlbC5jLCBidHVzYi5jIGFuZCBoY2lfaW50ZWwuYy4gV291bGQgaXQgYmUgYWNjZXB0
YWJsZSB0byBzdWJtaXQgYSBzZXBhcmF0ZSBwYXRjaCBmb3IgdGhpcyBjaGFuZ2UgYWxvbmU/DQoN
Cj4+ICAgCQkJZGF0YS0+Z3AwX3JlY2VpdmVkID0gZmFsc2U7DQo+Pg0KPj4gICAJCWhkZXYtPnN0
YXQuY21kX3R4Kys7DQo+PiBAQCAtMjAyNSwxNyArMjAyOCwxNSBAQCBzdGF0aWMgaW50IGJ0aW50
ZWxfcGNpZV9zZW5kX2ZyYW1lKHN0cnVjdCBoY2lfZGV2DQo+KmhkZXYsDQo+PiAgIAkJYnRfZGV2
X2RiZyhkYXRhLT5oZGV2LCAic2VudCBjbWQ6IDB4JTQuNHggYWxpdmUgY29udGV4dA0KPmNoYW5n
ZWQ6ICVzICAtPiAgJXMiLA0KPj4gICAJCQkgICBvcGNvZGUsIGJ0aW50ZWxfcGNpZV9hbGl2ZWN0
eHRfc3RhdGUyc3RyKG9sZF9jdHh0KSwNCj4+ICAgCQkJICAgYnRpbnRlbF9wY2llX2FsaXZlY3R4
dF9zdGF0ZTJzdHIoZGF0YS0NCj4+YWxpdmVfaW50cl9jdHh0KSk7DQo+PiAtCQlpZiAob3Bjb2Rl
ID09IEhDSV9PUF9SRVNFVCkgew0KPj4gLQkJCXJldCA9IHdhaXRfZXZlbnRfdGltZW91dChkYXRh
LT5ncDBfd2FpdF9xLA0KPj4gLQkJCQkJCSBkYXRhLT5ncDBfcmVjZWl2ZWQsDQo+PiAtDQo+bXNl
Y3NfdG9famlmZmllcyhCVElOVEVMX0RFRkFVTFRfSU5UUl9USU1FT1VUX01TKSk7DQo+PiAtCQkJ
aWYgKCFyZXQpIHsNCj4+IC0JCQkJaGRldi0+c3RhdC5lcnJfdHgrKzsNCj4+IC0JCQkJYnRfZGV2
X2VycihoZGV2LCAiTm8gYWxpdmUgaW50ZXJydXB0IHJlY2VpdmVkDQo+Zm9yICVzIiwNCj4+IC0J
CQkJCSAgIGJ0aW50ZWxfcGNpZV9hbGl2ZWN0eHRfc3RhdGUyc3RyKGRhdGEtDQo+PmFsaXZlX2lu
dHJfY3R4dCkpOw0KPj4gLQkJCQlyZXQgPSAtRVRJTUU7DQo+PiAtCQkJCWdvdG8gZXhpdF9lcnJv
cjsNCj4+IC0JCQl9DQo+PiArCQlyZXQgPSB3YWl0X2V2ZW50X3RpbWVvdXQoZGF0YS0+Z3AwX3dh
aXRfcSwNCj4+ICsJCQkJCSBkYXRhLT5ncDBfcmVjZWl2ZWQsDQo+PiArDQo+bXNlY3NfdG9famlm
ZmllcyhCVElOVEVMX0RFRkFVTFRfSU5UUl9USU1FT1VUX01TKSk7DQo+PiArCQlpZiAoIXJldCkg
ew0KPj4gKwkJCWhkZXYtPnN0YXQuZXJyX3R4Kys7DQo+PiArCQkJYnRfZGV2X2VycihoZGV2LCAi
Tm8gYWxpdmUgaW50ZXJydXB0IHJlY2VpdmVkIGZvciAlcyIsDQo+PiArCQkJCSAgIGJ0aW50ZWxf
cGNpZV9hbGl2ZWN0eHRfc3RhdGUyc3RyKGRhdGEtDQo+PmFsaXZlX2ludHJfY3R4dCkpOw0KPg0K
PkluIGEgZm9sbG93LXVwIHBhdGNoLCB0aGUgbG9nIG1lc3NhZ2UgY291bGQgYmUgaW1wcm92ZWQg
YnkgYWxzbyBhZGRpbmcgdGhlDQo+dGltZW91dCB2YWx1ZSB0byBpdC4NCkFjay4NCg0KPg0KPj4g
KwkJCXJldCA9IC1FVElNRTsNCj4+ICsJCQlnb3RvIGV4aXRfZXJyb3I7DQo+PiAgIAkJfQ0KPj4g
ICAJfQ0KPj4gICAJaGRldi0+c3RhdC5ieXRlX3R4ICs9IHNrYi0+bGVuOw0KPg0KPg0KPktpbmQg
cmVnYXJkcywNCj4NCj5QYXVsDQoNClRoYW5rcywNCktpcmFuDQoNCg==
