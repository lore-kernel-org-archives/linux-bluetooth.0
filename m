Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1172C47F45
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jun 2024 06:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718950838; cv=fail; b=X7zrOQKu6cC10AsqFRMzkE+RWE5OF5Ot7eEc4q3BevjvMLNUMyTB84lXaHlAIzR5u0EAHGH/tiU+5RCrpP7hd3cwbSoJ7+Hp69/r7Wpnb3W7/FIt7Fr5udgZYAtQrbxx9w/3HXaBzLJbt4qcztAqQ/UJE6HSjZBGVfyc1V5Ze7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718950838; c=relaxed/simple;
	bh=xrGwjwwBhUHTNSpYdyB+eZudX1dwgJ6cHduu/flLPk8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vE7g+jQf6PvhQEc8sjfMldM17of7w7izpRMxiHL+rD/AZ87XqVJQnwD0Yr2oORQzKSjhqdKs1cofs6PuJfXFm5qUnO68KFs9eEx7+yx6F/OE4ODLQb2y6/vFpvpWgSQWTHP1h4fXN049U16A6qe9StenVCNtSXcuNMrXgQ2u59g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D7/uFbmV; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D7/uFbmV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718950837; x=1750486837;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xrGwjwwBhUHTNSpYdyB+eZudX1dwgJ6cHduu/flLPk8=;
  b=D7/uFbmVEyZIIDk+sLsCtKmNRP3zc54GudzLCr4FAsZQ9doNsEqi1+lE
   XrBD7iM7d2zpv+CBXRvWy4AzGUzCW58m9m6hQogJyCFme8Z8H9a3VmoT7
   UekGkoV58jTmTWOVgVHfV2zexPcMvZy8Edp5VdrNYbdi6hsfxoyR0PhfV
   b5O//hU65vGkUHHWKA00xeIZFDm/BSFWt/dPUFqyQxecOHNUJTg2w/4RL
   dUiK1/IhVHGQ1TTh9GU0usatAWZYs3nu/qPHTIRHc4NZhnMqWLN7bhzAz
   IH2ux5DMru5rjM1Io3ejJIJOe7P0xFjlf+/tu1DFAuY3EsKt3c/dXZCI/
   A==;
X-CSE-ConnectionGUID: Yi8KodWFRk+oiafqt1lm1g==
X-CSE-MsgGUID: iQcWN7SuS/KEFuz7KKpCqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="33512603"
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="33512603"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 23:20:37 -0700
X-CSE-ConnectionGUID: xS5hjnoWT56cIgDlxhQ5hw==
X-CSE-MsgGUID: jHlrOLIyTOWO7r2Cs+l6CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="47449164"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Jun 2024 23:20:36 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 23:20:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 23:20:35 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 20 Jun 2024 23:20:35 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 23:20:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ys5SszkOQ1jvb/jG1hoEuCEgW5i5E/BzmlZUs3pMw6zYLgMlj8mwNlIlx3EGWPX3JMLqCd1zkh6GYQ1FLo6VYgZbfr/2PqBlwuM//Uy1gRPg8flP1xZX0rGH5Y4DufJas3zYIJ6mkd71nhoiM8kCSfSQDfd93FJCy0R2owIasav7jw6MwfAR746Wf1mM2/aj0iqZy82HaV9bEyoIZQXWCAmPjKASItdmmwVTbaSTdvZLSc7vNYORhnKrFUOZCojIWHB5A6otZjCrM6OOaTEKf19yCkXxU43yJTHkh7EfecPAnq2rubKq7gP9HdxDqX6ZvQhu18VEWFAzw7+aBfxDYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrGwjwwBhUHTNSpYdyB+eZudX1dwgJ6cHduu/flLPk8=;
 b=bjAVklZnsk+snlzVLtbgtfbp7jWy09ZLLmPKGUm/bboYPXFFmZd3jfpePFVd7xVfp9IOxHDqRkh/KQ07g82IDN8KM6RBDo7Yy1uzY1GLsDKomi6vffvKn4iLJIT/rlTXd0HKWf+NnzBgjjbD2flezNZLrROR3NWKZakt7EPyUwIx5p+zZ7PFcjD1G7K7sNSEXFTxKbJSvNO/wtVoVfnCgWp7QiHLY74L8oYXr9uVcirmvcTnbSrN8l3qfYlEW1rd+GhjxzJCrAes6c3tTZWBDBxpbij1lODd8e9u6fKTCuYDXpcYPtlX3JffErYBtqMYjwQiLjYf3SbxsWdL9OxXHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by DS0PR11MB8083.namprd11.prod.outlook.com (2603:10b6:8:15e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Fri, 21 Jun
 2024 06:20:33 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%7]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 06:20:33 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, "Devegowda, Chandrashekar"
	<chandrashekar.devegowda@intel.com>, "Satija, Vijay" <vijay.satija@intel.com>
Subject: RE: [PATCH v1] Bluetooth: btintel: Allow lowering of drive strength
 of BRI
Thread-Topic: [PATCH v1] Bluetooth: btintel: Allow lowering of drive strength
 of BRI
Thread-Index: AQHawyF4yr2re7PrZ0qGV1ORTFixZ7HQwcKAgAD9zIA=
Date: Fri, 21 Jun 2024 06:20:32 +0000
Message-ID: <PH0PR11MB7585CA80E7689543DB683DECF5C92@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20240620150635.2119398-1-kiran.k@intel.com>
 <CABBYNZJ1wxgEU0xQvtYc+gr1U886DpbTDJUGhszjY_5ifEuRXA@mail.gmail.com>
In-Reply-To: <CABBYNZJ1wxgEU0xQvtYc+gr1U886DpbTDJUGhszjY_5ifEuRXA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|DS0PR11MB8083:EE_
x-ms-office365-filtering-correlation-id: 9f531e17-d2b6-4cb7-ed1c-08dc91ba4190
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?RFE5YTU4UzJWUjNibnFwWjBOYlNnTmpRcmozOTU5NTVJcjZ4d0xYeVFSTWoz?=
 =?utf-8?B?RDc2U0dUMlRNUjhqZk0zclhKdmcxN1gyU05aZzBCRXVaL3g4SWZCUFpIaURO?=
 =?utf-8?B?ZE0yZWhyZDRxeGFRTzYrL3RoQk5UeFNMRUQxWE8ralU0Wk1udUxIVWNBSFBk?=
 =?utf-8?B?YXp5ak5LQzFCRzJNMTdsT1Q1TEpBc2d4dTd1bWNFTHA2SDhubkdqdnVHdXpy?=
 =?utf-8?B?cFpncXFiT0U0dVBFUnl0N0lBNnRSdWVmaXArQnlsWWZ3dFlQczA2ZWtrdUp3?=
 =?utf-8?B?ZUxLa0Z3MWo1K1BFVG9VS1hYWEZ5K2toYTJZU0V2K0xtbjZNbk43Y2tEdWli?=
 =?utf-8?B?NEJ5c1FYSzhCakFwSTRpaFp2Mlkza1RSTzdHVjFLTHBXbEZaWGN1YjQzM1Jw?=
 =?utf-8?B?TDhKZDdNdG1hakpNMW0zVFowK3duMWFZclpHZWNEaU82Z29EcVluZXB2Z1Z3?=
 =?utf-8?B?ZGVNVFV6Z0szRUJaZkhtK3FaUWRBOFZSU21lMlFLMFdQblJtRVJoZjlGNGRh?=
 =?utf-8?B?YUVzTGxORXhQMWhqaksxTDZDczNoSjF0eXZRaWwyOUgrdUlQYVdMUlAyTTBl?=
 =?utf-8?B?QktCOHNhcy9sL3ZQRUkwZkdxdzdKWUdwM0U4SGZYejRyNU5PMmRwR3dLQ3Nr?=
 =?utf-8?B?RXo0ZUg0M0xKM3Rqeno0cktKc0lLQmFkKzZvcmE2YTA5UzVzZnBqMkh2MFpS?=
 =?utf-8?B?QU9INzJJN25ZM0JTakdIbXZWVHY2Vjhodk9Rd08wc3ZZRHAzZjBBYzhYWVZU?=
 =?utf-8?B?SlhYcWtwd0dlTlhBN3RJcVgwbmFvZGdYSUdobkw0ODBmazhZaXNDM2h1V2JG?=
 =?utf-8?B?WUE0UlB4ZnhlK1pXbVNxOVhwY05JQk43WE5CRU5Tbi9ObDBsdnhybnUzQzdh?=
 =?utf-8?B?L0g1cnlISUQ0bTc0cTRNUEx0N3VPL1NDRnZXY0NQcnlrbzBUbVNPMFArWnl2?=
 =?utf-8?B?QnNZVTN6by9GYUgxRlZrbnhBNGNaUGxBWkt4dEhmNm1iaFArRTQwYmlmU1ZL?=
 =?utf-8?B?eTE0UEhVRU9mbnBSS3h6R1lMakdKMWJ6RGYvNS9NcG9CcC9pZXpVVTdBRXN1?=
 =?utf-8?B?ZVFUZWRHZzVqUHlWQkFpN0laMTJBTFBtaTUyWjY0NCtXWjQyL0NTVzFuYzk0?=
 =?utf-8?B?OWZkbWh5VkFxeGNXOW1QUmxhcWRjWTUxYk5XY1B3dGl4WFJhdk9VRzVvVWF1?=
 =?utf-8?B?aEJHMjI4cmtWdVFCTS9xeXNBY1BiWGlyeGYrSjlkWlFKUjUwaGZPWFJxZE1h?=
 =?utf-8?B?Mjl4TzBjb1ZnZU1XTExhcyt2dlora0EvZVlIUkYyM0Z2cWRUMnYyR0wyYzZr?=
 =?utf-8?B?b2VuNXQramp3cklEUUNiZ3Q0cVErejBKb1RnQlIxcFdnSTNLSTVjNUhQQmJJ?=
 =?utf-8?B?eWFYbERVRDlPaGhJMklNa1NoeFZiSHZlVXprK0tFZXpoaGVqMjNsK042MlBk?=
 =?utf-8?B?c1JhOGNhWCs4ZndsSmZaUTJhYU1NZEduZ2NBMXEwblB2OEZ3S0dFa2dtdFFt?=
 =?utf-8?B?Q1FiQlNzMVlTMkgzMXBiNzIzTG1PcFRpeExuOWxFYm1iM1pIMENtZkhOZkJ0?=
 =?utf-8?B?c0psaXlYSmJpYVhMbW9TSDFUYkdJNGpqNFRrQkJuTzdTWjEzeGFmK0taR25K?=
 =?utf-8?B?OVRxMnUrNWNzaEJsbDhGRDZGa2lMNlp6NzFWc2NRS2VHbk9udWI5VmI0bDdJ?=
 =?utf-8?B?RDJObytySEhNc3JSeWFXRUdIWVFBYm15TlJ5K3FNUG4rK0hqNFE2cUIyZnFQ?=
 =?utf-8?B?WERxWU9mejkxVkZkSnV2Wmp2WFhpKzhIZlFiT3ZMOGRSekEvb0MrQ2NmNk85?=
 =?utf-8?Q?5TfNFMpzR1PzN83TQT72VQrfN4Gn8gREXdtbg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3BhSm44ejZhUERrNGxtcnQ1QVRKV0FDR2dWNTFLbld6U2ZoMkIxWTV5Ti9t?=
 =?utf-8?B?Y1lxc3hHeG1mRnNwcEM2R2huT2dJRXVHQUMvL3N6Y3FNemV4WkNPMk5DTWYr?=
 =?utf-8?B?WW5BY1c3R0lPY3lMMkMxK2UxbDZlUGF2cXpkb2VXSUwvRnd0dDJlSzVkSy9W?=
 =?utf-8?B?U1BsZkR6dTY5eVNVbW5oMXp1Z3dwSWdZRDRDUXZabE9QaEFZM1JzSjF6d21Y?=
 =?utf-8?B?ZDRXWWQ3a3MweTc2ejZ1N3Nrancwek5pUG52QzZmZ3hMdG1PM3dERGw1UjVD?=
 =?utf-8?B?SzlNTlNwajhOYmNQNWFManJlRmo1SjgwT0Zhb1UzOGNqb3hXcmhNdTdNdnIx?=
 =?utf-8?B?SnkrU2JZOWxhZEI1ZUQ1cGdBcktpeUpZUGVZQTRLam1pUE4rOUphS2VRVk54?=
 =?utf-8?B?NEV4dUVjdnpTeVVSY09kSWR5WjVsYkFMUkZJZXJJbElzaENuNjdJVThrVTJh?=
 =?utf-8?B?QjV0YnljbnpEYXVFdzN1MUs3KzJrODIrRjNPU0JEZ3hLWEtUVUh2Q1hoV2l0?=
 =?utf-8?B?Q0xSSEdjQVlOV2g4WUtMOUpSTW94UlVXcjVDNUhHRWhTcFRQL3hBNTIxOHBL?=
 =?utf-8?B?NUd0NGJWdEZPRkhpNUc5SkRqMG85Y1Z1aTdUelY3MnFtNExWamZNdW1TV3Vu?=
 =?utf-8?B?TkdVUzhGdlNMYVYrRWtESzZleldOZ0hMZjZ2VWJkL29xc0ZyVVpxRlVGekJY?=
 =?utf-8?B?MjQ2a1ZmOXpaL2xiOVFZSUc2RVlzR0w5VmVoMVA0TUt2dEM5cTRaeWFBa2My?=
 =?utf-8?B?VlVqSFlWZEc0V3lkeGVpQ3B0aUVGZm1kQ0dnNEQzSUxuZmlud3BvQ3I0UFB5?=
 =?utf-8?B?MmR0aWZqSGFub05NWmhuV2h2WHpBQWFaZUZvaWpGTFNxVDRRUm5pZ2hTSE84?=
 =?utf-8?B?RTJjbXdqcVBtc0tWL0QxMjVKMG5uYlJkUkF1b3dDQkhpY0hpaGNVdm9TTmRk?=
 =?utf-8?B?QXN6NDhlM01xRnh2V2lURytNT0o0VmFnTUh4dHA4bktsZjBWanZobzB0WmpS?=
 =?utf-8?B?L215cFZXRWQydFFjaUJJUGhJTUE4cUR5UFlwajgxWDRYdnhXb2pSclJlNE15?=
 =?utf-8?B?Zjl2TXZiK0R3OCtpck5vY0pGMUdSNjZqeFVuWHo5V05NRm9qMk5LZWpGbzZJ?=
 =?utf-8?B?Tk84QklwR2ZYMDhGdUJUakRQVWlicWVGYlBsU2JHdEVJcVk5MHZYL2V3MEQ5?=
 =?utf-8?B?ZEVXenZSUEhHdmtVYm9nUk5IMUUxS1YyWGE5REZTTi9oendOZTMxbVJ1TWNr?=
 =?utf-8?B?NmdXcmRUYnpNOTJXM3dzaXlzb0hhOFgyOHFlVVh3elVBTmllWSs1SlN5NURW?=
 =?utf-8?B?bHdpcWtndmc5YW1OSGFxYVdEcjJoaTVGUGZGTVFwUUZGYi9Vd05nTXdYSkEy?=
 =?utf-8?B?L1VxbkFuNmN1TWZtei9tSXltbHk5aWM2WWpDRHl5NE9PR3F3dHlkbDRnUFJK?=
 =?utf-8?B?SWIyZ25Wb0UwbTFCMXdlcmVxb3hRVXh0VnQ0cDU5SGVpc3lRN3p1WERuZUt5?=
 =?utf-8?B?RjZhQ2NybWEvUUNjTGJ0Q3JRZ2xFNUhoR0RrQ2dOYWpFZ3laUVg4bE1vcnlv?=
 =?utf-8?B?YkV2NW8rWm9sek5VNWdqU0pPSE43ZFRoMjdxSjZaQkdObW94NVNnLy8xMXcz?=
 =?utf-8?B?ejBReWZrQTkzZklVclVIMjlJU1RDZWUxQlpkeWsxV0NCUHE4SDlGOUZuZzhn?=
 =?utf-8?B?eURjOGhLYisyZWxzaDgrSUpRemJIV3dLZU5GSjRRbHJqdFJ1NmcybDBKZGFV?=
 =?utf-8?B?eXI0cjYvdEtOMkx2eWlTWCtsVnBYR1hMMGw3cHJ1R2xKTENSTEtvWC9UMnRh?=
 =?utf-8?B?L1Vtc1I0UXdsc1VNYnpRYmMvbXc4NE8xZHUxVFhvNmZ2TG1DN1J1WnlLN2lp?=
 =?utf-8?B?bjNvUkhSZldhODlwVHNjSjZEbmF2ckVLdkdURzhydERnS0lVck96UVIvSE5R?=
 =?utf-8?B?Q3czYVByaFFwZWFQLzRsV25ZOU82MVg5d0hMQzYzR2pYLy9ReU9LTjRxaWV4?=
 =?utf-8?B?R3IzanJhdjJXRTl4Q1QxQmxVdHhTaSt5amJsMEVFeEtPWTJoVWRhb1c5cUt6?=
 =?utf-8?B?Zy8zMlZGV3NVN0FZVFliaVRGaVVITTJEN0VibzByUU9Fc2tPMEZGMUFlMnFT?=
 =?utf-8?Q?+w0U=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f531e17-d2b6-4cb7-ed1c-08dc91ba4190
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 06:20:32.9480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0fhniCU/gusngGaEOo0ErFpfty5uNJQIgSLC09vEiv0+ci1osx7xmK1L8m+TdwbY07H4xUt/LpVhcoL882M/Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8083
X-OriginatorOrg: intel.com

SGkgTHVpeiwNCg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KDQo+DQo+SGkgS2lyYW4sDQo+
DQo+T24gVGh1LCBKdW4gMjAsIDIwMjQgYXQgMTA6NTLigK9BTSBLaXJhbiBLIDxraXJhbi5rQGlu
dGVsLmNvbT4gd3JvdGU6DQo+Pg0KPj4gQlJJIChCbHVldG9vdGggUmFkaW8gSW50ZXJmYWNlKSB0
cmFmZmljIGZyb20gQ05WciB0byBDTlZpIHdhcyBmb3VuZA0KPj4gY2F1c2luZyBjcm9zcyB0YWxr
IHN0ZXAgZXJyb3JzIHRvIFdpRmkuIEFzIGEgd29ya2Fyb3VuZCwgZHJpdmVyIG5lZWRzDQo+PiB0
byByZWR1Y2UgdGhlIGRyaXZlIHN0cmVuZ3RoIG9mIEJSSS4gRHVyaW5nICpzZXR1cCosIGRyaXZl
ciByZWFkcyB0aGUNCj4+IGRyaXZlIHN0cmVuZ3RoIHZhbHVlIGZyb20gZWZpIHZhcmlhYmxlIGFu
ZCBwYXNzZXMgaXQgY29udHJvbGxlciB2aWENCj4+IHZlbmRvciBzcGVjaWZpYyBjb21tYW5kIHdp
dGggb3Bjb2RlIDB4ZmMwYS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBLaXJhbiBLIDxraXJhbi5r
QGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYyB8IDEx
NQ0KPj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgMSBmaWxlIGNo
YW5nZWQsIDExNSBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1
ZXRvb3RoL2J0aW50ZWwuYyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYw0KPj4gaW5kZXgg
NWQ3MzUzOTE1NDVhLi4xZDY1ODZiMzBjOGQgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2JsdWV0
b290aC9idGludGVsLmMNCj4+ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYw0KPj4g
QEAgLTEyLDYgKzEyLDggQEANCj4+ICAjaW5jbHVkZSA8bGludXgvYWNwaS5oPg0KPj4gICNpbmNs
dWRlIDxhY3BpL2FjcGlfYnVzLmg+DQo+PiAgI2luY2x1ZGUgPGFzbS91bmFsaWduZWQuaD4NCj4+
ICsjaW5jbHVkZSA8bGludXgvZWZpLmg+DQo+PiArDQo+Pg0KPj4gICNpbmNsdWRlIDxuZXQvYmx1
ZXRvb3RoL2JsdWV0b290aC5oPg0KPj4gICNpbmNsdWRlIDxuZXQvYmx1ZXRvb3RoL2hjaV9jb3Jl
Lmg+DQo+PiBAQCAtNDksNiArNTEsMzkgQEAgc3RhdGljIGNvbnN0IGd1aWRfdCBidGludGVsX2d1
aWRfZHNtID0NCj4+ICAgICAgICAgR1VJRF9JTklUKDB4YWExMGY0ZTAsIDB4ODFhYywgMHg0MjMz
LA0KPj4gICAgICAgICAgICAgICAgICAgMHhhYiwgMHhmNiwgMHgzYiwgMHgyYSwgMHhjNSwgMHgw
ZSwgMHgyOCwgMHhkOSk7DQo+Pg0KPj4gK3N0YXRpYyB2b2lkICpidGludGVsX3VlZmlfZ2V0X3Zh
cmlhYmxlKGVmaV9jaGFyMTZfdCAqbmFtZSwgZWZpX2d1aWRfdA0KPj4gKypndWlkKSB7ICNpZiBk
ZWZpbmVkKENPTkZJR19FRkkpDQo+DQo+aWlyYyBJU19FTkFCTEVEIGlzIG5vcm1hbGx5IHByZWZl
cnJlZCBvdmVyICNpZiBkZWZpbmVkLCB3ZWxsIGV4Y2VwdCBpZiB5b3UgaGF2ZQ0KPnVuZGVmaW5l
ZCBzeW1ib2xzIGJ1dCB0aGF0IHVzdWFsbHkgaW5kaWNhdGVzIHRoZSBBUElzIGhhdmUgbm90IGJl
ZW4gZG9uZSB3aXRoDQo+dXNhZ2Ugb2YgSVNfRU5BQkxFRCBpbiBtaW5kLg0KDQpBY2suIEkgd2ls
bCBmaXggaXQgIGluIHYyIHZlcnNpb24uDQoNCj4NCj4+ICsgICAgICAgdm9pZCAqZGF0YTsNCj4+
ICsgICAgICAgZWZpX3N0YXR1c190IHN0YXR1czsNCj4+ICsgICAgICAgc2l6ZV90IGRhdGFfc2l6
ZSA9IDA7DQo+PiArDQo+PiArICAgICAgIGlmICghZWZpX3J0X3NlcnZpY2VzX3N1cHBvcnRlZChF
RklfUlRfU1VQUE9SVEVEX0dFVF9WQVJJQUJMRSkpDQo+PiArICAgICAgICAgICAgICAgcmV0dXJu
IEVSUl9QVFIoLUVPUE5PVFNVUFApOw0KPj4gKw0KPj4gKyAgICAgICBzdGF0dXMgPSBlZmkuZ2V0
X3ZhcmlhYmxlKG5hbWUsIGd1aWQsIE5VTEwsICZkYXRhX3NpemUsIE5VTEwpOw0KPj4gKw0KPj4g
KyAgICAgICBpZiAoc3RhdHVzICE9IEVGSV9CVUZGRVJfVE9PX1NNQUxMIHx8ICFkYXRhX3NpemUp
DQo+PiArICAgICAgICAgICAgICAgcmV0dXJuIEVSUl9QVFIoLUVJTyk7DQo+PiArDQo+PiArICAg
ICAgIGRhdGEgPSBrbWFsbG9jKGRhdGFfc2l6ZSwgR0ZQX0tFUk5FTCk7DQo+PiArDQo+PiArICAg
ICAgIGlmICghZGF0YSkNCj4+ICsgICAgICAgICAgICAgICByZXR1cm4gRVJSX1BUUigtRU5PTUVN
KTsNCj4+ICsNCj4+ICsgICAgICAgc3RhdHVzID0gZWZpLmdldF92YXJpYWJsZShuYW1lLCBndWlk
LCBOVUxMLCAmZGF0YV9zaXplLCBkYXRhKTsNCj4+ICsNCj4+ICsgICAgICAgaWYgKHN0YXR1cyAh
PSBFRklfU1VDQ0VTUykgew0KPj4gKyAgICAgICAgICAgICAgIGtmcmVlKGRhdGEpOw0KPj4gKyAg
ICAgICAgICAgICAgIHJldHVybiBFUlJfUFRSKC1FTlhJTyk7DQo+PiArICAgICAgIH0NCj4+ICsN
Cj4+ICsgICAgICAgcmV0dXJuIGRhdGE7DQo+PiArI2Vsc2UNCj4+ICsgICAgICAgcmV0dXJuIEVS
Ul9QVFIoLUVPUE5PVFNVUFApOw0KPj4gKyNlbmRpZg0KPj4gK30NCj4+ICsNCj4+ICBpbnQgYnRp
bnRlbF9jaGVja19iZGFkZHIoc3RydWN0IGhjaV9kZXYgKmhkZXYpICB7DQo+PiAgICAgICAgIHN0
cnVjdCBoY2lfcnBfcmVhZF9iZF9hZGRyICpiZGE7IEBAIC0yNjE1LDYgKzI2NTAsODAgQEAgc3Rh
dGljDQo+PiB1OCBidGludGVsX2NsYXNzaWZ5X3BrdF90eXBlKHN0cnVjdCBoY2lfZGV2ICpoZGV2
LCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQ0KPj4gICAgICAgICByZXR1cm4gaGNpX3NrYl9wa3RfdHlw
ZShza2IpOw0KPj4gIH0NCj4+DQo+PiArc3RhdGljIGludCBidGludGVsX3NldF9kc2JyKHN0cnVj
dCBoY2lfZGV2ICpoZGV2LCBzdHJ1Y3QNCj4+ICtpbnRlbF92ZXJzaW9uX3RsdiAqdmVyKSB7DQo+
PiArICAgICAgIHN0cnVjdCBidGludGVsX2RzYnJfY21kIHsNCj4+ICsgICAgICAgICAgICAgICB1
OCBlbmFibGU7DQo+PiArICAgICAgICAgICAgICAgdTggZHNicjsNCj4+ICsgICAgICAgfSBfX3Bh
Y2tlZDsNCj4+ICsNCj4+ICsgICAgICAgc3RydWN0IGJ0aW50ZWxfZHNiciB7DQo+PiArICAgICAg
ICAgICAgICAgdTggaGVhZGVyOw0KPj4gKyAgICAgICAgICAgICAgIHUzMiBkc2JyOw0KPj4gKyAg
ICAgICB9IF9fcGFja2VkOw0KPj4gKw0KPj4gKyAgICAgICBzdHJ1Y3QgYnRpbnRlbF9kc2JyICpk
c2JyOw0KPj4gKyAgICAgICBzdHJ1Y3QgYnRpbnRlbF9kc2JyX2NtZCBjbWQ7DQo+PiArICAgICAg
IHN0cnVjdCBza19idWZmICpza2I7DQo+PiArICAgICAgIHU4IHN0YXR1czsNCj4+ICsgICAgICAg
ZWZpX2d1aWRfdCBndWlkID0gRUZJX0dVSUQoMHhlNjVkODg4NCwgMHhkNGFmLCAweDRiMjAsIDB4
OGQsIDB4MDMsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDB4NzcsIDB4
MmUsIDB4Y2MsIDB4M2QsIDB4YTUsDQo+PiArIDB4MzEpOw0KPj4gKw0KPj4gKyAgICAgICBtZW1z
ZXQoJmNtZCwgMCwgc2l6ZW9mKGNtZCkpOw0KPj4gKyAgICAgICBkc2JyID0gYnRpbnRlbF91ZWZp
X2dldF92YXJpYWJsZShMIlVlZmlDbnZDb21tb25EU0JSIiwgJmd1aWQpOw0KPj4gKyAgICAgICBp
ZiAoSVNfRVJSKGRzYnIpKSB7DQo+PiArICAgICAgICAgICAgICAgLyogSWYgZWZpIHZhcmlhYmxl
IGlzIG5vdCBwcmVzZW50LCBkcml2ZXIgc3RpbGwgbmVlZHMgdG8gc2VuZA0KPj4gKyAgICAgICAg
ICAgICAgICAqIDB4ZmMwYSBjb21tYW5kIHdpdGggZGVmYXVsdCB2YWx1ZXMNCj4+ICsgICAgICAg
ICAgICAgICAgKi8NCj4+ICsgICAgICAgICAgICAgICBidF9kZXZfZGJnKGhkZXYsICJFcnJvciBy
ZWFkaW5nIGVmaSBEU0JSICglbGQpIiwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgIFBU
Ul9FUlIoZHNicikpOw0KPj4gKyAgICAgICAgICAgICAgIGRzYnIgPSBOVUxMOw0KPj4gKyAgICAg
ICB9DQo+PiArDQo+PiArICAgICAgIGlmIChkc2JyKSB7DQo+PiArICAgICAgICAgICAgICAgLyog
Yml0MDogMCAtIFVzZSBmaXJtd2FyZSBkZWZhdWx0IHZhbHVlDQo+PiArICAgICAgICAgICAgICAg
ICogICAgICAgMSAtIE92ZXJyaWRlIGZpcm13YXJlIHZhbHVlDQo+PiArICAgICAgICAgICAgICAg
ICogYml0MzoxIC0gUmVzZXJ2ZWQNCj4+ICsgICAgICAgICAgICAgICAgKiBiaXQ3OjQgLSBEU0JS
IG92ZXJyaWRlIHZhbHVlcw0KPj4gKyAgICAgICAgICAgICAgICAqIGJ0MzE6NyAtIFJlc2VydmVk
DQo+PiArICAgICAgICAgICAgICAgICovDQo+PiArICAgICAgICAgICAgICAgY21kLmVuYWJsZSA9
IGRzYnItPmRzYnIgJiBCSVQoMCk7DQo+PiArICAgICAgICAgICAgICAgaWYgKGNtZC5lbmFibGUp
DQo+PiArICAgICAgICAgICAgICAgICAgICAgICBjbWQuZHNiciA9IGRzYnItPmRzYnIgPj4gNCAm
IDB4RjsNCj4+ICsgICAgICAgICAgICAgICBrZnJlZShkc2JyKTsNCj4+ICsgICAgICAgfQ0KPj4g
Kw0KPj4gKyAgICAgICBidF9kZXZfaW5mbyhoZGV2LCAiZHNicjogZW5hYmxlZDogMHglMi4yeCB2
YWx1ZTogMHglMi4yeCIsDQo+Y21kLmVuYWJsZSwNCj4+ICsgICAgICAgICAgICAgICAgICAgY21k
LmRzYnIpOw0KPj4gKw0KPj4gKyAgICAgICBza2IgPSBfX2hjaV9jbWRfc3luYyhoZGV2LCAweGZj
MGEsIHNpemVvZihjbWQpLCAmY21kLA0KPkhDSV9DTURfVElNRU9VVCk7DQo+PiArICAgICAgIGlm
IChJU19FUlIoc2tiKSkgew0KPj4gKyAgICAgICAgICAgICAgIGJ0X2Rldl9lcnIoaGRldiwgIkZh
aWxlZCB0byBzZW5kIEludGVsIERTQlIgY29tbWFuZCAoJWxkKSIsDQo+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICBQVFJfRVJSKHNrYikpOw0KPj4gKyAgICAgICAgICAgICAgIHJldHVybiAt
YnRfdG9fZXJybm8oUFRSX0VSUihza2IpKTsNCj4+ICsgICAgICAgfQ0KPj4gKw0KPj4gKyAgICAg
ICBzdGF0dXMgPSBza2ItPmRhdGFbMF07DQo+PiArICAgICAgIGtmcmVlX3NrYihza2IpOw0KPj4g
Kw0KPj4gKyAgICAgICBpZiAoc3RhdHVzKSB7DQo+PiArICAgICAgICAgICAgICAgYnRfZGV2X2Vy
cihoZGV2LCAiU2V0IERTQlIgZmFpbGVkIDB4JTIuMngiLCBzdGF0dXMpOw0KPj4gKyAgICAgICAg
ICAgICAgIHJldHVybiAtYnRfdG9fZXJybm8oc3RhdHVzKTsNCj4+ICsgICAgICAgfQ0KPj4gKyAg
ICAgICByZXR1cm4gMDsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIGludCBidGludGVsX2FwcGx5
X2RzYnIoc3RydWN0IGhjaV9kZXYgKmhkZXYsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBzdHJ1Y3QgaW50ZWxfdmVyc2lvbl90bHYgKnZlcikgew0KPj4gKyAgICAgICAvKiBGb3Ig
QmxhemFySSArIEIwIHN0ZXAsIERTQlIgY29tbWFuZCBuZWVkcyB0byBiZSBzZW50IGp1c3QgYWZ0
ZXINCj4+ICsgICAgICAgICogZG93bmxvYWRpbmcgSU1MIGZpcm13YXJlDQo+PiArICAgICAgICAq
Lw0KPj4gKyAgICAgICByZXR1cm4gdmVyLT5pbWdfdHlwZSA9PSBCVElOVEVMX0lNR19JTUwgJiYN
Cj4+ICsgICAgICAgICAgICAgICAoKHZlci0+Y252aV90b3AgJiAweGZmZikgPT0gQlRJTlRFTF9D
TlZJX0JMQVpBUkkpICYmDQo+PiArICAgICAgICAgICAgICAgSU5URUxfQ05WWF9UT1BfU1RFUCh2
ZXItPmNudmlfdG9wKSA9PSAweDAxOyB9DQo+PiArDQo+PiAgaW50IGJ0aW50ZWxfYm9vdGxvYWRl
cl9zZXR1cF90bHYoc3RydWN0IGhjaV9kZXYgKmhkZXYsDQo+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBzdHJ1Y3QgaW50ZWxfdmVyc2lvbl90bHYgKnZlcikgIHsgQEANCj4+IC0y
NjQ5LDYgKzI3NTgsMTIgQEAgaW50IGJ0aW50ZWxfYm9vdGxvYWRlcl9zZXR1cF90bHYoc3RydWN0
IGhjaV9kZXYgKmhkZXYsDQo+PiAgICAgICAgIGlmIChlcnIpDQo+PiAgICAgICAgICAgICAgICAg
cmV0dXJuIGVycjsNCj4+DQo+PiArICAgICAgIGlmIChidGludGVsX2FwcGx5X2RzYnIoaGRldiwg
dmVyKSkgew0KPj4gKyAgICAgICAgICAgICAgIGVyciA9IGJ0aW50ZWxfc2V0X2RzYnIoaGRldiwg
dmVyKTsNCj4+ICsgICAgICAgICAgICAgICBpZiAoZXJyKQ0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgcmV0dXJuIGVycjsNCj4+ICsgICAgICAgfQ0KPj4gKw0KPj4gICAgICAgICAvKiBJZiBp
bWFnZSB0eXBlIHJldHVybmVkIGlzIEJUSU5URUxfSU1HX0lNTCwgdGhlbiBjb250cm9sbGVyIHN1
cHBvcnRzDQo+PiAgICAgICAgICAqIGludGVybWVkaWFlIGxvYWRlciBpbWFnZQ0KPj4gICAgICAg
ICAgKi8NCj4+IC0tDQo+PiAyLjQwLjENCj4+DQo+Pg0KPg0KPg0KPi0tDQo+THVpeiBBdWd1c3Rv
IHZvbiBEZW50eg0KDQpSZWdhcmRzLA0KS2lyYW4NCg0KDQo=
