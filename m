Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A863E1706
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778593159; cv=fail; b=JeKq5XOMuk8W/EA5YAYaiFPJYG18YXxFWR/bTRtrea2Bo/Ne0VbG+JAJE5oKRr9E15Qkf6Ey80a5b1AdDSA316TEAKI/bBYgZXEDrgZqNkaORgdVvRi89TtI9pK7JN/eSXa+P6oN1WS534u46Cz1PuAtAw00JZwdd53KTJv+Pe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778593159; c=relaxed/simple;
	bh=3epcW9U9iVWaHYA1odVr1LE/suVclXC4YY70QRQe3MI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fZaZzrInNsk/J69Cy/9w7Ta5pxxhlqwc9aBITAzpEGfroMS+Jj5fGU7/qUtgkw+TK55VbIZlAINnTrwRF6BRb4iFGLVTre6xUKLBQwH9uc0nJIla1odBcmnjYf5me5Z5wwtLCdENdRaJIM1LunA6Em6M4i2AenOL6IN2VbqisMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n9/uWpJL; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n9/uWpJL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778593155; x=1810129155;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3epcW9U9iVWaHYA1odVr1LE/suVclXC4YY70QRQe3MI=;
  b=n9/uWpJLEYkNL7kgQiYSghw9FC7uIMGgt/VaWICQ3ZDZ+w/P1cp8dkoH
   9qR3/OmGLTmuReiY8oA06JOhD77WFU6kAXL+Ij0rk6FyKWLoBj0rf2IfV
   eNRqEWgMAFBBNR1FLETpadeU1PygjSw+KJQaizh1gv+IiYCtIykDKsHkb
   K14cVi8yHX6kff0t8CbZ3W59gww52ec91TCrgb2bvpuL708qeFqN+mXKj
   9WR19EmSTMYzVoUGRnrxb5S8UwFX1weq6PdIbxzOJfugvVedzF6/VXA1R
   bagWox1GjII/b1BoCIgcfz91anrPOpVLhN9fC9OU2n7wmI+/w7lYGMhsR
   g==;
X-CSE-ConnectionGUID: cnAXGkPLS7mXHERKK9ry9g==
X-CSE-MsgGUID: ZWH4PufhS2Gj2gmMYLsqaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="96926084"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="96926084"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 06:39:14 -0700
X-CSE-ConnectionGUID: MS9cweQtR5CSINvPlcNbrg==
X-CSE-MsgGUID: r0S6NhQ4RuyK0NJY+R3eug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="237700949"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 06:39:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 06:39:13 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 12 May 2026 06:39:13 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.21) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 06:39:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ua9DxpXInRJgJwzoE1Xe17HFa8VcLpFakK2G1aoXTG3cXhAg7O0F+cJBnFKM1XGok871tfx5OmK108J5yS92pCd04MSAu8ZkyR1gIszwJp1q6EkK5nRIZm1mLII5/Y12qTiAj1ugztc/xmWVgy/jAzOwiqcCKF0sHhxYQbwcIc4jVPLMFDFCsboGxf52RZT+B1i9rUyK9ywz05VPlM7OejFjZ1Asl1tJQSAYzrT/4seXlUahVwkMSX9bDtJRa91cVgMnikiRImMDhyhM9ZsNM/Yh4uf8VZqRM1GrBZjA1RBY7YZflpfAAcody0smqOKQt2+TmrrVxDX9XTQbKMc0+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3epcW9U9iVWaHYA1odVr1LE/suVclXC4YY70QRQe3MI=;
 b=WxWRGhO/CPunCDZyfvpC9ohgY9zDkamAknprs8gptCuctOiX83zF4w0OEIppGsArWy5cNk4b3x452voQJe7vNiEUDoKIKaaO9P5NA+y/kSnTZgGlX7Dh/5+Z/qyIRWKGiSwPvWs+Xbc5bWw3XqrT56+hHVmfahBQWbuMr1J+tXM6zK4zDc33BvJxVLLQqrqs1+Xjkq8TbQbiUO6hENrO4MBxhFcqMH8ycKSYy56JIjB68MRY3A8bnNP2wVOWKauaV5HiRlEbVPhvxkwMJ/e11LaJW8rRDrRvftHZyFJgZEnYlSug6uzlv1juoVPGdkcolyM6yS/GcEf4X2Xropryxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by MN0PR11MB6184.namprd11.prod.outlook.com (2603:10b6:208:3c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 13:39:08 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::3e58:d5d:4e05:885e]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::3e58:d5d:4e05:885e%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 13:39:08 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>
Subject: RE: [PATCH v1] Bluetooth: btintel_pcie: Simplify MAC access
 request/release
Thread-Topic: [PATCH v1] Bluetooth: btintel_pcie: Simplify MAC access
 request/release
Thread-Index: AQHc4UkFKcWw5kmsAUuOP6KvGkxGDLYJMSIAgAD1+LA=
Date: Tue, 12 May 2026 13:39:08 +0000
Message-ID: <PH0PR11MB75854BD26CAC4AE7CDD4EEA5F5392@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20260511133932.1217624-1-kiran.k@intel.com>
 <4c1fb760-55b5-4392-9c89-7c8a3ce5201c@molgen.mpg.de>
In-Reply-To: <4c1fb760-55b5-4392-9c89-7c8a3ce5201c@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|MN0PR11MB6184:EE_
x-ms-office365-filtering-correlation-id: 8ea08e80-0d6b-4bd1-274f-08deb02bd7a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|22082099003|18002099003|56012099003|11063799003;
x-microsoft-antispam-message-info: 4vZaCso4ZPvU0P+EYUwv+oopte8eN/FyNL/Xu1Np0dwD5NrAT2Oi3/Mgy2fxrvt8H2bZazQViT5icvwb/QOPL7gV/I6zAfsR8cU8cn30M9/eBeLUuL74HUQ+LuWSlIysSMVJeoH8RggJVXerelF+oBFXcBqWodnJcfzmTM224gXb2ByJmbqLhM2qf5fjsZc/B8ZzEQ9ywbPjvrM0H5EK7qVYVUSFcCuExU9JJMqXP+0+zFhy8+N06v6m5sEnfuua2k4gpO0CN3d6PEoH9LWnFPjsX/whc0qrLgIr8pVzfDp6XTH0QPosPAnucEg1KkswSf5ssbE2doYosOPyLXIwg84od73hWwxFkJQ+zVvkk6KgWffD+MyTPEdg68K/rpbL96rsyR1rgEMuoADwncvlOsckMDweMBmGbAXfV5G4XM5QQpXGHvWu/U/6PXxxAXUFqeTbld9pxgGAjcuQ/ms0NKRtWwh8xwBh9Gly+HJIs+loV4WUlsiV6TaZ8LrYHp5QTT0p5/xjuLlGfgbw9ZqHg2hfnLEw+3zrlAw6bviSIrlD3Qz4CpMzPtWIWrPyVHgI0hE0e7EcfFSH62Glj/HkmBO+lCArD1Yg9yoy7pjAAX3x7rIfn1qrJbkf/7TvWh/tLbfj+IsTcrfJrREpdnyF6Vi0ucNrPfYMabdiujKD56bQ+F5of+0++iKDlu0LOVoUZ967Jbi0AYnlwrRzGGGWz1ot7fPPK+GGeVjh3mIdPcBZJPNj1F4Mppa4NviHNxQZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTMxYXRRNUl2RE5tUXRGL0pUZXZkWlgzdC9BeHNCQ1pPb2FUQzc1VVlwWXJo?=
 =?utf-8?B?SVNwVFBkQmNGQjR3dU9uRDVzVGlRNVNyVzlnczNQcHdxTXZ1aW9uRnVJZWRT?=
 =?utf-8?B?dmZFWnRDeHlab3VtNE5xc1BPV3FubVNVNndEc2xnNkdQWjViWjF1aG44R0pK?=
 =?utf-8?B?VEVvSW9ZQXd5OEVTZHZwbGc5cWlLMlFLbmEwZDBUUkRYY2hLUlRTSjZUNHlj?=
 =?utf-8?B?TjBGbm5QdStzTnVVcmRDRHFxOVhURTJqZkFPdThLbW9lODJnZUNCSUVKeGcx?=
 =?utf-8?B?aDgxWkdzTEI3MXJHOFlYTzBSOXZwaGYrZENtS0t2eWJhVS83NVFkeGF5K0Zw?=
 =?utf-8?B?czlSWnlrOXJZR0N3YnNqVEFZaW41WVJ6TEtST3ZFelFxazErOHNXRkR2K0xq?=
 =?utf-8?B?K2lMNnltem1YR3BWM3dsVVFaZEFBd0U0c29HRjhtYUVUY3JoYXJ6NUQ2c2xh?=
 =?utf-8?B?c1UzMnVLdUZHMmt0ZzdVQXlBbVNmbnRKMHpxaEJIREFTYk84bTFFNDZxaW1i?=
 =?utf-8?B?T1ZYYTRBanRpVUxIalZ5TjJEMk90RUwvc1BGeGFGWEs3VGx5aTBXU1AyTzZU?=
 =?utf-8?B?bWZnalBPanNWUHVpNWE4Z3p5L0ZEVVYzM3krWmJ3L3VnVHJreWtkdStMZFpK?=
 =?utf-8?B?LytjT3JOaHI1RzhJbnc0bUpGK0dQS1l3elhBMVpjWTNvaGRtNXhCOXowZEgv?=
 =?utf-8?B?bTNqRlR2dk9rYURrR0ZJTThiZEZ1SExZd1IzMXNnLzM1amNWcHBvdkhBcW5O?=
 =?utf-8?B?OEU4aVJ0blp1UVM5cUNISHdkQnRyYTN3VHZpbGcyUThXTGRPeGVyNmJkUFlG?=
 =?utf-8?B?cDYxNENIa1RNR2RFckU3MDB2Uk5DWDVkMzVicUw2ZUZRVVBxZFF2QXprTUVp?=
 =?utf-8?B?QUNXbXBieWkzNTZyUzF5OFJqNUp2bSs4NTRJSW13azRiOFdNMlZnTXF2d2hN?=
 =?utf-8?B?Yy9UMEYzcFUweE1KOGVVcGcwc1dsL0M0dUJEbHhPQXdxNkVOMTNjSHFYVXp5?=
 =?utf-8?B?TWdONk9PR2h1ZXJGTjl6Q0RKR1B1ZkRuUzQxMyt1OWw0ZVYydzhDOE5GQlVP?=
 =?utf-8?B?NmNadWcyREVSRVY0SysrckVQMW5LRGtGamNZMktEcEl5MCs2VTdMeTlRUXBk?=
 =?utf-8?B?TUR4cFhjNjhGMXN3RVVXV2ExS2tWVEJvc1BhQU9TQ0VlR1Bob2ZmSFVoRGtR?=
 =?utf-8?B?RzByQ25JRldXS1lOUTgxbW5BNjdlc1RhMGpIVXlQTHlBZE84ZEYrUkVVVnJ1?=
 =?utf-8?B?bXU4RXZmdkFRUHhlSk0wYnV0aERMVCtCb3cxRzgvUEdTRCt3UU95dHE1NXUy?=
 =?utf-8?B?ZWNKQkppS2RNODcvVFN4ZXY2M1FZenZDYXhFZXBmRFZaRGRNU05YUkZBRFJ1?=
 =?utf-8?B?SSt1UUVCOExCUWU1c0txQ0FZay9PeTIyTjVXOGxCQXpFNk1wb2ppR0lCV3lH?=
 =?utf-8?B?K0RFVmNNeEV1WTRiSVQ1TUlJT2RtK3phb3JBeTl1K1B5cHJRSnBnT2hsYnZX?=
 =?utf-8?B?Qzl6T3FEMUx4OGZnTk0xVklJTjREYjhiSXlvcFBDOGx5blpQb1RwZURDdEg2?=
 =?utf-8?B?UDc1Y0ZXaUF4Y28yNEZKem5wRkVxbW8vNkNHT0lSckVOQzdPZGxKUkg3QUFx?=
 =?utf-8?B?cHVveTN3STJhNU81VjBseUc4azd4bVh1WGZRcjRJODNMeHBDUGgwaEVKZU5v?=
 =?utf-8?B?SjdoV0JTYnhRQXdDUWY0a2YxUjJNcnFmd1RvU25odS9NVi9aUk9oRnd1c3RS?=
 =?utf-8?B?ZDhxZWhLR2NoMXhwQXFaOW9FOU9PWGZZbStzbUlnSzREMVNEeUNTMXo0aWFU?=
 =?utf-8?B?Qzl6UzFTVjVjbHU1RVhZLzhIY1ZwTnRMeFAwT1daNkU0MUg2cFdoaXUrM0Qw?=
 =?utf-8?B?d1RWYzF0YmNYVE16d1ptV21vSU1tc3UzMmRDL1haTEF0UW9TVmdSb1ZMa0Jz?=
 =?utf-8?B?a3gwMXBmVExRMlJaOGxiTmZzQmpXaVJFMlJXWmNPeTFycm9heWZ1VUJRU25Q?=
 =?utf-8?B?c0haTVdweVRJRVVjdXVoZzVRQTdIcVA2SGd2WmpUUDZjNTlhUFgySUxmZFNR?=
 =?utf-8?B?Y29NQTlNbm5BSDlpZmMxV29kZklJWWRwbGtkdXVabVFhcTJ1dlFzSklQcXR4?=
 =?utf-8?B?NWgwZ3JzaEtZMWRqdXlNRGtVdlBPL0trY2tCdjR0YkhSRUtwN1VSZk0xa2pn?=
 =?utf-8?B?ZVJ3TWVRQTl5UWg3KzkwODBIeEhOTTFpSENUZGtSNUluQnY2OVFvQUJhbFh2?=
 =?utf-8?B?aFYrdmszMEFNekFNYXpTMUZNRG1wNENjd1lXMkxiWHdwWWxERkwrWWN2dUlO?=
 =?utf-8?Q?2R5Qnr0++x9uwXa6Ix?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Uz6oMhotk9yyO9xHOPTuSN6cvufVmODGHaBHXF/3v7tts6PTTJNMa1PeT4PzxbnRtgYfsqgSABprRf9GqDzJDaC4wO8DmoJW+l9mjSCYKjMpc//TEyXsNLyB65xGIsccnOVJG74qgp4Qv/xTdJrQ8/hRo/4Q9dTAsFu1JXutPwsYmOSma/Lf2EDaUk2ts7q7WJXSGRh+9UdnwSxqTxrvWkrhow8W+IZjPhrgteDvrP5PQRFOSy+OR5ojTaOlPZ+gZMZQOGOIg2TkRPy9LOlwD9PQqDwuqc0HlsPcbuvgI9IfP7ucGg2TWsYQf/lKO/ZKlp+K02CtEbFOCFdoyH+DFQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7585.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea08e80-0d6b-4bd1-274f-08deb02bd7a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 13:39:08.0608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bID5BefYzfSwi4oXr4Jglj5p+1pNdlFmfFMhg2Z+W+ZRQEacmZAFsn6qACyOLXcTR+1xeFwV111oxnDWy2NuQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6184
X-OriginatorOrg: intel.com

SGkgUGF1bCwNCg0KVGhhbmtzIGZvciB0aGUgY29tbWVudHMuDQoNCj5TdWJqZWN0OiBSZTogW1BB
VENIIHYxXSBCbHVldG9vdGg6IGJ0aW50ZWxfcGNpZTogU2ltcGxpZnkgTUFDIGFjY2Vzcw0KPnJl
cXVlc3QvcmVsZWFzZQ0KPg0KPkRlYXIgS2lyYW4sDQo+DQo+DQo+VGhhbmsgeXVvIGZvciB5b3Vy
IHBhdGNoLg0KPg0KPkFtIDExLjA1LjI2IHVtIDE1OjM5IHNjaHJpZWIgS2lyYW4gSzoNCj4+IERy
b3AgdGhlIFNUT1BfTUFDX0FDQ0VTU19ESVMgYW5kIFhUQUxfQ0xLX1JFUSBiaXQgbWFuaXB1bGF0
aW9ucyBmcm9tDQo+PiBidGludGVsX3BjaWVfZ2V0X21hY19hY2Nlc3MoKSBhbmQgYnRpbnRlbF9w
Y2llX3JlbGVhc2VfbWFjX2FjY2VzcygpLg0KPj4gVGhlc2UgYml0cyBhcmUgbm8gbG9uZ2VyIHJl
cXVpcmVkIHRvIGJlIHRvZ2dsZWQgYnkgdGhlIGhvc3QgZHJpdmVyIGZvcg0KPj4gTUFDIGFjY2Vz
cyBvbiB0aGUgc3VwcG9ydGVkIHBhcnRzOyB0aGUgY29udHJvbGxlciBtYW5hZ2VzIHRoZW0NCj4+
IGludGVybmFsbHkuDQo+DQo+RG9lcyB0aGUg4oCcbm8gbG9uZ2Vy4oCdIHJlZmVyIHRvIHNvbWUg
Y29udHJvbGxlciBmaXJtd2FyZSB1cGRhdGU/IFBsZWFzZQ0KPmVsYWJvcmF0ZS4gKEkgcGVyc29u
YWxseSBwcmVmZXIgdGhhdCBhcyBtdWNoIGFzIHBvc3NpYmxlIGlzIGRvbmUgb3V0c2lkZSB0aGUN
Cj5maXJtd2FyZS4pIEFsc28sIG1heWJlIGJlIGV4cGxpY2l0LCBhbmQgbWVudGlvbiwgaWYgaGF2
aW5nIHRoZSBjb2RlIGhhcyBhbnkNCj5wcmFjdGljYWwgZG93bnNpZGVzLg0KDQpObywgdGhlIOKA
nG5vIGxvbmdlcuKAnSBkb2VzIG5vdCByZWZlciB0byBhbnkgY29udHJvbGxlciBmaXJtd2FyZSB1
cGRhdGUuIFRoZSBjaGFuZ2VzIGFyZSByZWxldmFudCBvbmx5IHRvIHRoZSBkcml2ZXIuIFRoZSBk
cml2ZXIgbm93IGNvcnJlY3RseSBwcm9ncmFtcyBhIGZldyByZWdpc3RlcnMgYmVmb3JlIGFjY2Vz
c2luZyB0aGUgZGVidWctcmVsYXRlZCByZWdpc3RlcnMuIFByZXZpb3VzbHksIGl0IHdhcyBwcm9n
cmFtbWluZyB0aGVzZSBiaXRzIGluY29ycmVjdGx5LCB3aGljaCBwcmV2ZW50ZWQgYWNjZXNzIHRv
IHRoZSBkZWJ1ZyByZWdpc3RlcnMgZHVyaW5nIHN0cmVzcyB0ZXN0cyBhbmQgY2F1c2VkIGRldmlj
ZSBjb3JlZHVtcCBmYWlsdXJlcy4NCj4NCj4+IEFsc28gZml4IHRoZSBpZGVtcG90ZW5jeSBjaGVj
ayBpbiBidGludGVsX3BjaWVfZ2V0X21hY19hY2Nlc3MoKTogb25seQ0KPj4gYXNzZXJ0IE1BQ19B
Q0NFU1NfUkVRIGlmIGl0IGlzIG5vdCBhbHJlYWR5IHNldCwgaW5zdGVhZCBvZiBrZXlpbmcgdGhl
DQo+PiByZWFkLW1vZGlmeS13cml0ZSBvZmYgdGhlIE1BQ19BQ0NFU1NfU1RTIGJpdCAod2hpY2gg
cmVmbGVjdHMgZ3JhbnQsDQo+PiBub3QgcmVxdWVzdCwgc3RhdGUpLg0KPg0KPipBbHNvKiBpcyBh
IGdvb2QgaW5kaWNhdG9yIHRvIG1ha2Ugc29tZXRoaW5nIGEgc2VwYXJhdGUgY29tbWl0LiBBbnkg
cmVhc29uIHRvDQo+bm90IGRvIGl0Pw0KSSBrZXB0IHRoZSBmaXggaW4gdGhlIHNhbWUgcGF0Y2gg
YmVjYXVzZSBidGludGVsX3BjaWVfcmVsZWFzZV9tYWNfYWNjZXNzKCkgaXMgbWVhbnQgdG8gdW5k
byB3aGF0IGJ0aW50ZWxfcGNpZV9nZXRfbWFjX2FjY2VzcygpIGRvZXMuIFNwbGl0dGluZyB0aGVt
IHdvdWxkIGJyZWFrIHRoZSBwYWlyaW5nIG9mIGdldC9yZWxlYXNlIG9wZXJhdGlvbnMsIHNvIEkg
ZmVsdCBpdCB3YXMgbG9naWNhbGx5IG9uZSBjaGFuZ2UuDQo+DQo+PiBSZW1vdmUgdGhlIG5vdy11
bnVzZWQgU1RPUF9NQUNfQUNDRVNTX0RJUyBhbmQgWFRBTF9DTEtfUkVRIHJlZ2lzdGVyDQo+PiBk
ZWZpbmVzIGZyb20gYnRpbnRlbF9wY2llLmguDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogS2lyYW4g
SyA8a2lyYW4ua0BpbnRlbC5jb20+DQo+DQo+Tm8gRml4ZXM6IHRhZz8gQXQgbGVhc3QgdGhlIHNl
Y29uZCBpc3N1ZSBzb3VuZHMgbGlrZSBzb21ldGhpbmcgdG8gYmFja3BvcnQuDQpJIHdpbGwgYWRk
IGFwcHJvcHJpYXRlIEZpeGVzOiB0YWdzIGFuZCBzZW5kIGEgdjIuDQo+DQo+PiAtLS0NCj4+ICAg
ZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmMgfCAxMCArLS0tLS0tLS0tDQo+PiAgIGRy
aXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5oIHwgIDMgLS0tDQo+PiAgIDIgZmlsZXMgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuYw0KPj4gYi9kcml2ZXJzL2JsdWV0b290
aC9idGludGVsX3BjaWUuYw0KPj4gaW5kZXggZmRhNDc0NDA2MDAzLi41M2E0YWQ4MGI4NzEgMTAw
NjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuYw0KPj4gKysrIGIv
ZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmMNCj4+IEBAIC01OTQsOSArNTk0LDcgQEAg
c3RhdGljIGludCBidGludGVsX3BjaWVfZ2V0X21hY19hY2Nlc3Moc3RydWN0DQo+PiBidGludGVs
X3BjaWVfZGF0YSAqZGF0YSkNCj4+DQo+PiAgIAlyZWcgPSBidGludGVsX3BjaWVfcmRfcmVnMzIo
ZGF0YSwgQlRJTlRFTF9QQ0lFX0NTUl9GVU5DX0NUUkxfUkVHKTsNCj4+DQo+PiAtCXJlZyB8PSBC
VElOVEVMX1BDSUVfQ1NSX0ZVTkNfQ1RSTF9TVE9QX01BQ19BQ0NFU1NfRElTOw0KPj4gLQlyZWcg
fD0gQlRJTlRFTF9QQ0lFX0NTUl9GVU5DX0NUUkxfWFRBTF9DTEtfUkVROw0KPj4gLQlpZiAoKHJl
ZyAmIEJUSU5URUxfUENJRV9DU1JfRlVOQ19DVFJMX01BQ19BQ0NFU1NfU1RTKSA9PSAwKQ0KPj4g
KwlpZiAoIShyZWcgJiBCVElOVEVMX1BDSUVfQ1NSX0ZVTkNfQ1RSTF9NQUNfQUNDRVNTX1JFUSkp
DQo+PiAgIAkJcmVnIHw9IEJUSU5URUxfUENJRV9DU1JfRlVOQ19DVFJMX01BQ19BQ0NFU1NfUkVR
Ow0KPj4NCj4+ICAgCWJ0aW50ZWxfcGNpZV93cl9yZWczMihkYXRhLCBCVElOVEVMX1BDSUVfQ1NS
X0ZVTkNfQ1RSTF9SRUcsIHJlZyk7DQo+PiBAQCAtNjIyLDEyICs2MjAsNiBAQCBzdGF0aWMgdm9p
ZCBidGludGVsX3BjaWVfcmVsZWFzZV9tYWNfYWNjZXNzKHN0cnVjdA0KPmJ0aW50ZWxfcGNpZV9k
YXRhICpkYXRhKQ0KPj4gICAJaWYgKHJlZyAmIEJUSU5URUxfUENJRV9DU1JfRlVOQ19DVFJMX01B
Q19BQ0NFU1NfUkVRKQ0KPj4gICAJCXJlZyAmPSB+QlRJTlRFTF9QQ0lFX0NTUl9GVU5DX0NUUkxf
TUFDX0FDQ0VTU19SRVE7DQo+Pg0KPj4gLQlpZiAocmVnICYgQlRJTlRFTF9QQ0lFX0NTUl9GVU5D
X0NUUkxfU1RPUF9NQUNfQUNDRVNTX0RJUykNCj4+IC0JCXJlZyAmPQ0KPn5CVElOVEVMX1BDSUVf
Q1NSX0ZVTkNfQ1RSTF9TVE9QX01BQ19BQ0NFU1NfRElTOw0KPj4gLQ0KPj4gLQlpZiAocmVnICYg
QlRJTlRFTF9QQ0lFX0NTUl9GVU5DX0NUUkxfWFRBTF9DTEtfUkVRKQ0KPj4gLQkJcmVnICY9IH5C
VElOVEVMX1BDSUVfQ1NSX0ZVTkNfQ1RSTF9YVEFMX0NMS19SRVE7DQo+PiAtDQo+PiAgIAlidGlu
dGVsX3BjaWVfd3JfcmVnMzIoZGF0YSwgQlRJTlRFTF9QQ0lFX0NTUl9GVU5DX0NUUkxfUkVHLCBy
ZWcpOw0KPj4gICB9DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50
ZWxfcGNpZS5oDQo+PiBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5oDQo+PiBpbmRl
eCAyZGI4NWY3MWIyZjguLjdmYzhjNDZlZDY4OSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvYmx1
ZXRvb3RoL2J0aW50ZWxfcGNpZS5oDQo+PiArKysgYi9kcml2ZXJzL2JsdWV0b290aC9idGludGVs
X3BjaWUuaA0KPj4gQEAgLTM0LDkgKzM0LDYgQEANCj4+ICAgI2RlZmluZSBCVElOVEVMX1BDSUVf
Q1NSX0ZVTkNfQ1RSTF9NQUNfQUNDRVNTX1NUUwkoQklUKDIwKSkNCj4+DQo+PiAgICNkZWZpbmUg
QlRJTlRFTF9QQ0lFX0NTUl9GVU5DX0NUUkxfTUFDX0FDQ0VTU19SRVEJKEJJVCgyMSkpDQo+PiAt
LyogU3RvcCBNQUMgQWNjZXNzIGRpc2Nvbm5lY3Rpb24gcmVxdWVzdCAqLw0KPj4gLSNkZWZpbmUg
QlRJTlRFTF9QQ0lFX0NTUl9GVU5DX0NUUkxfU1RPUF9NQUNfQUNDRVNTX0RJUw0KPgkoQklUKDIy
KSkNCj4+IC0jZGVmaW5lIEJUSU5URUxfUENJRV9DU1JfRlVOQ19DVFJMX1hUQUxfQ0xLX1JFUQ0K
PgkoQklUKDIzKSkNCj4+DQo+PiAgICNkZWZpbmUgQlRJTlRFTF9QQ0lFX0NTUl9GVU5DX0NUUkxf
QlVTX01BU1RFUl9TVFMJKEJJVCgyOCkpDQo+PiAgICNkZWZpbmUgQlRJTlRFTF9QQ0lFX0NTUl9G
VU5DX0NUUkxfQlVTX01BU1RFUl9ESVNDT04NCj4JKEJJVCgyOSkpDQo+DQo+VGhlIGRpZmYgbG9v
a3MgZ29vZC4NCj4NCj4NCj5LaW5kIHJlZ2FyZHMsDQo+DQo+UGF1bA0KDQpUaGFua3MsDQpLaXJh
bg0KDQo=
