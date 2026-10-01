Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465E9301486
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 01:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790819784; cv=fail; b=d8NZIdPHMtB2z0T2OnS8OC1Y3kGW3M5NouijiLSQGDwUiyya8Bg5emQxyp1J9DAmm08NyEL3b3mNy3T1aaCHqEzM1AoKDyeovjJA/7mv6InTZfkXNx0U86YIhoZ4rdQ0Sdy9mH76fhzAnmAwpptZSBJNWIJVu2xlnAsstdxVMaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790819784; c=relaxed/simple;
	bh=/Bhe1aTOUF/SBFYzTdUUQ32w3vyDQKEqHwoztgxrBrQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CJty/kn7nJGkugx5/DjInRCD0oAnQrPjGdiZTVdudgBFlNkX73A4JvgTRCeSEokuRn3oQD8+u2uhq+Di4xT6A8gh4VGoO2IbUsbIlBgzVB9RvywkKK+G+2tZchfvCgT77wymBsXrkZQedkTyVScxbimF+m/Nvedo2ghR6qjqG5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TPP1bLxw; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TPP1bLxw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790819782; x=1822355782;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/Bhe1aTOUF/SBFYzTdUUQ32w3vyDQKEqHwoztgxrBrQ=;
  b=TPP1bLxwsptJX4PByXdR1oTrfSriZ1dfZLVeLjq03wGS1q9FOpG/LieL
   /V5hn/ZTtNTD2g4vwDk1udmopt7C1UWAQIBlJhlJv3XNsPlHaY0oq1iYT
   p4vCe6xTRKSDmz36xlwOuqEEVY0X54CIYmQ0O4ib/sIqZP5WxFsZk+KPw
   wMGA4Op6sxgqo/2+4ZOYj23TEJHRzARwBMD4e4P63JS2EfAcFsYJnsDG+
   04fDOmlTzOEY4x2LObj1ZPhBYTIxrcTT91pDCoXO4YyUxnB2O5UIRyls+
   e5taTi5TdwKdvntB6LbRwTOcf8yGKNBfFfHzgPha0zW0tl5Xc+0AIq8rD
   g==;
X-CSE-ConnectionGUID: 9htR0I6rSkWz04NCrhulQA==
X-CSE-MsgGUID: ju44o+F/SDqOmJJbUFAUJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="90624711"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="90624711"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 18:56:22 -0700
X-CSE-ConnectionGUID: JQ0htrA+QW6w6IHL2Zb/1g==
X-CSE-MsgGUID: xZWVhDLHTaO9gROJy+d1pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="280607858"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 18:56:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 18:56:21 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 18:56:21 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.16) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 18:56:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6eTHij6P/TU2ZbiGezr4yIgnAA5uadfWWQYO4hx1vcn7H4GtXzjKsGt7erYLOOnQTUmIpylmHwJojHlzx7fumLR8peNL51S3lXjxCVZ6IAnxbZTI06EG12OcT9iqbjeaRoktj4YsTXoT3XzxLNjORt04bRAK2HJ5enH1rgapC2yW1zcAjeBcbctop1FtzOZBCEIyt/8NxaahYzFcydsrLmHU3Jbk54/I/kh3bQuIlqJmalFxkjDa0rjk3z20h5DxziXdDmalgejt1ftQetlpTD0rMpuzKmnAbIm0vJNeLG/rG+8y3hEmRFVcMx0EebdaBVWFfGYohz2yeJVCsrZYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Bhe1aTOUF/SBFYzTdUUQ32w3vyDQKEqHwoztgxrBrQ=;
 b=ja59Ai+ooXGmfERBins7G2ipSRfvwSBBbSDphBPOtAHOidMNYFLyMZtjrYhVetbj4fipNoxgsLk58Pl2JZp8Q2Cxf2yGYCthas/BcBQpC3Q+FcaO/xpAU1uYhkYyQ/Dem82JUmDiwbbvSbQpugZvwWQUenL6Hy3iQKF+GvfaSeycUvQBbGtEJtxUuziTJ0vkoVWED9GPEEdtBj3S1rn6ZtV4BPU+xQPBp1nTJT0Sk2umG8U58Z90mJXtij+17uGOElvngvS4P7ICuAohH2BkYpi0i+4jI8pCnuLSKBd07OeB82k2WNCfqYLUy0WY7PyaL6wIRk739iqEW4qlDCqRvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by SJ0PR11MB4830.namprd11.prod.outlook.com (2603:10b6:a03:2d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 01:56:18 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6828:7da2:8d9f:3283]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6828:7da2:8d9f:3283%3]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 01:56:18 +0000
From: Aluvala Sai Teja <aluvala.sai.teja@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "K,
 Kiran" <kiran.k@intel.com>, "Tumkur Narayan, Chethan"
	<chethan.tumkur.narayan@intel.com>
Subject: RE: [PATCH v1 1/1] emulator: add generic HW rfkill test tool
Thread-Topic: [PATCH v1 1/1] emulator: add generic HW rfkill test tool
Thread-Index: AQHdULB+fnAxJHo0QkiQOTMgfDie9LbnFBAAgAAV35CAAA1EAIAAtiUg
Date: Thu, 1 Oct 2026 01:56:18 +0000
Message-ID: <MW5PR11MB588145C819FD4AB3351F268ECC8A2@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <cover.1790752800.git.aluvala.sai.teja@intel.com>
 <66971d6f85d714f2728b29fada7136d5a2fbb3c2.1790752800.git.aluvala.sai.teja@intel.com>
 <CABBYNZ+_ZMd9fh2K8ESe5V9NKuZjBcbBsqsnLVuXkTZ4YXm6-g@mail.gmail.com>
 <MW5PR11MB5881A5CB72305C8003502B0ECC8B2@MW5PR11MB5881.namprd11.prod.outlook.com>
 <CABBYNZJxKFpojqCFFmT08CUzcs97wsduBGWzKjw3fyPsn8iw=g@mail.gmail.com>
In-Reply-To: <CABBYNZJxKFpojqCFFmT08CUzcs97wsduBGWzKjw3fyPsn8iw=g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|SJ0PR11MB4830:EE_
x-ms-office365-filtering-correlation-id: fafa9fca-ffcb-49d3-e7ee-08df1f5f2f4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|38070700021|56012099006|5023799004|11063799006|4143699003|3023799007|6133799003|10067099003;
x-microsoft-antispam-message-info: F+ddkH0pFHtMzr2IG9Y4UlbYZRiXyS1TK8ZN/3z1On+TTqxLiOK7hVtvE6bV1xVTkM6gSGQq10wjdavn2hDl3E6As6NJQe5Mmw0LvW/Tvhj4Gei/gvGlokogsDS9zltEsEyRv+yHTtF8E+tBs5lJ0z+ByV4Dn708Ay5KVFBQ7MdWm2NuAtE4G67zWPFF3TqKvalVn3QBaDhgep/7BjjqpZPzdBEEfpaTglp5O1WE+9VKpgw+Tc7bE2D23yQSwXD1vnJFNblUaXGSgr2rW6R+0gd5qNZU8Cx5S76sDtZzzAdsqoykHsAKoW4tNRsxERFDmKfhcbJWqeF84L/VfAdVmOQtkm/Cc9RzK5onzf6myuOIvCWVcQTVdoaDjxfk6DFBmkDKogjxzfPxD3KOeix0fY2M3APX4abLThSVzzL1Z4anqtzcPXSyPl5tcnO1CapsISiS+5p48+6c0lyDrXY2BJkw8kHWXJXqQCxVDpUKZW74dJ1KuF7PfDXuuvsswjpVH5Dpz/NRfyoTT+wVKB773W9eJJJ4T9uGNHcukym0BtL04KOJaYY4eM4s/xMk1vaZ/4SmnT372FD5kQZr+yrj4H9IMSkLs+yNs/U3XTZe2u5HykjUBmcx+U9TVdrUmv1tJEhTG521Z+7BXhzDr2VuLzs2yDOMFDSxZUfs6gQQPxFEGcQcdoYEl0lTlhveLcryDsiXIKGTtv3TkGgmpWPhmI9j7xvG4fnH/gC8yTjm1sw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(38070700021)(56012099006)(5023799004)(11063799006)(4143699003)(3023799007)(6133799003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUpETUR2Z0hLeTY4ZGNZR0JvV1NzMXBpWEdlQnN0NldaZnYyT0Q3dHdrMnlG?=
 =?utf-8?B?YzlHSnAzcVNyRlBML3N5UGtuTnNIRW9wUGkvclZmcHcyWmJXZzFibWZmVHZ6?=
 =?utf-8?B?NTc3NGw3RFlnTjhKZWtmdkljbWU3czlRcVBIT2pvNk41L0tuNld1aDRQRnR1?=
 =?utf-8?B?aEd3TWpERGJpK3Q3b0I3ZUtybkoxU2ZIRFNIckJOaVdQUlluaHA2MnhUKzVY?=
 =?utf-8?B?NWR3TC9sZDlDaFlEekk2VUhUSFBYTWtwTU5GTEtIRkNCU0lHS2NUUFFNWEUx?=
 =?utf-8?B?ZEVvWnZRazJ0SkU4Ry9aVnNMbEtPQ2c3RlRCK3N1YmJ0UFo5Q2QvaW5XZmUw?=
 =?utf-8?B?aWNBY1pUTWZOUmNyZXVHbTFDWGIrdU55UjhxTXJvY3U0elNJK05Wam5uYVpP?=
 =?utf-8?B?TUtoS2NNdDl4TFd5RmJIWXZJYzlMTVR6KzdWM1NsWGhPRktWeWpka3V5Y3FD?=
 =?utf-8?B?aEpQZVFjc0dRU1M2Q09Ca0FSMmllZDZoZWJCVDdySjNzWnFtK2dpOTl0WWgz?=
 =?utf-8?B?T0VaZDhTcnlwRFpoNmRWWllpTmM0anh5RFZUMjlPN1NkbDdPdEh4ZWFQZERw?=
 =?utf-8?B?QlpDYS9DSEU5K1hPVjAxMEx3REFjY1U5SlpCSlhvbW4rdnFzMUVEeDFpWHNu?=
 =?utf-8?B?d0JzQWVuQ3V1b0lSRURDMXM4T3pCYlpJVi9qcENIdWNMMU1ENXg4K2ozejlC?=
 =?utf-8?B?RWt4VjZSUW43N0dCZE02K0d2czhUZGlCRXl2dHVKTnlpQXd0akNrWkxrU1lZ?=
 =?utf-8?B?UVpHdzY1eDJUQVBjQzhvM0ZhcUtoNWt5WGZQRWo2Z2laUVJFeHBwaGNha0JY?=
 =?utf-8?B?Z29nbk5ZNUFkZjA1bGJ0dktJWnJjdFRYUy9tTm1BcU1XM004b0Zidmxva0JO?=
 =?utf-8?B?RjdTSithd3k0K3NLaS9SUTRVSkRzY0hzQXhja0FvdXB1LzhOVVFHL1BLdFly?=
 =?utf-8?B?RHBVNHI1dkc1c0RqOGVnS1RMR1J2ZEgvRWZhVm9XRUg0YUlDMWFiTS9YdStn?=
 =?utf-8?B?UHp0UURjeWswR2FPOU5rSS9ia0FvVnV2eTc3M0x4UzJVZ3A4OWdYeU9zV2Q4?=
 =?utf-8?B?K0ZmTWlaNFhIbmJXYUZENXM3MXE4V0pOU1dlREVCZ01Tc0YzYVdwNDVqZWJL?=
 =?utf-8?B?WVhqaHMyb2wxbEo0NTNFVnlsaWIzVDE2OHJXaHF3bmRhUmtURGd1U2R6ZUhX?=
 =?utf-8?B?VytZN1ZkR0pPdnozUmtWMVZiQ2NJc093ci9jQWVpVFhvQ09qWkZVTUtwdmMx?=
 =?utf-8?B?dXN1NDlLVmQwSkhEV015cFQ3QVpqbitkRXhBRWh4UmNCM3lpaE5URnovb0pO?=
 =?utf-8?B?bjl6bmJsYVZoZE1mV3BRUUxVNWtCdEFIeW9UVllUVjdFOTBmWnNtZHhaNENO?=
 =?utf-8?B?allWbVJ2RnI2UHY0TkRKY2g4L2ZhZ3QvNVkra1hHZFpxZjF1Y0xjVVM0RzJw?=
 =?utf-8?B?WHBsTnFEZGdpb0dEL3hwaTRLdzc0VzNIbFduMDltT2VmemRzcVZNdmMwYTlP?=
 =?utf-8?B?RC9YNis1WmRWWGdJUzNZTmRRNkp6dU9LUWUrQ0lIUGc2d1RoaVNRRnhXcFZT?=
 =?utf-8?B?dUZ3SGtSMUtGaHMrSG51eUFlRzNGeW1FR2ZHQUFLdkZSTWUrT2JCMEY2RmN2?=
 =?utf-8?B?V1I5VDY1M09kN2crVDUwWExMQWY2ak9GNXRkbm0vK1JzZU54N05JNExsS2pJ?=
 =?utf-8?B?YXF3Ym9sSFpFVEZWR0pSWFFqVlBRaVp1R3NwZVdBRUxFL0dUYjhSVnFmeUFi?=
 =?utf-8?B?Y2dUTDhvV1RranNVaURodUZFQjhOSkpVQndMdXh2M2J1bGlKU293OXhLajNG?=
 =?utf-8?B?Y3dTR1ljclFxblhkV2htL1l6dkZjOExuazdxNWlHSFdoejdGb21ESDdKZUx5?=
 =?utf-8?B?bVE3c1hhRjBHTWx5QkpVcFRzWXNkc1BvYWNCNXl0dnFqbGF0V2xkSGZ2a1dt?=
 =?utf-8?B?VDRzQzUwV29MMGRKWDVHZ2o1RkFPcks4WFVYUTFnR0UrVkNyTjMwU1lCKzln?=
 =?utf-8?B?dVBRbDlBcnh4SGZ5RHdrcGlydm8zSkpVa0EzcHJlNnJyeU9JVllWbEtrVTI1?=
 =?utf-8?B?WnNkYkl1dUxMY2wxL3Exek5OdlNJbVhXSi9zL0xZTVdIcXF3MDJTUW96ODc0?=
 =?utf-8?B?T1V2YXdVQVI5MVFnSHZMNVNNUWVEN3FBaEdISFhtZy9FeXVYTEdzYTEydkt6?=
 =?utf-8?B?c0RUL2FyekNPTlMwcXo5UWZXOGN4Z1I1QnNnaHJQUjFDcmtCM2cxVUdOQXhZ?=
 =?utf-8?B?RmRIZzk5ZnVhRkVqaFExbUIzOXVqelBRcDBEZHQ1TzZVeDFOS1I1Z1d6NFVL?=
 =?utf-8?B?anUvZDdPTCtzdWp6OWtLcTliVGMwcUttQ21jcWJPaENQUDY4YnZ5dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 3zsh8OVo/HI31M/Yb1+rVJP0cP457wus/0U/OHlYDxf+E4VcglPnTtq6wxQ3L6E6yiBsYVDwx7V4bPPGgGDwM4G3veg6QAiBd0motgGQqqPmwwIeQpx6SicGbtn6hE2jVun2zRkFzWiLuqLUnhcfaMwx0B583wqlYQPa5aw7He4vJEqv4MAM2KULS8n8gd6hz6fNANhrpinaSoODxv42MqwgPwUGjDh+bRmPqhGE/VMdlQsl5Bd8EltuxzfIeGzmJrxOz0lxgjxw2dOQ92lrm3VtM1mFbeZLDkL3UOL6kNDsWBztkrAXE528FNX1yB+DUHXga6x51UbCoEvrE5S8Xg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fafa9fca-ffcb-49d3-e7ee-08df1f5f2f4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 01:56:18.5106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xd826/53FpuJ5gY+OMrbFrX6ukKG0dMJd++GU/4lQfb1V4zb+88OT7MWy0qcGhNCETCW9PXLemIJXKXLeMxF3uvepmVuwUQ0hjeFGwf4wB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4830
X-OriginatorOrg: intel.com

DQpIaSBTYWksDQoNCk9uIFdlZCwgU2VwIDMwLCAyMDI2IGF0IDEwOjQy4oCvQU0gQWx1dmFsYSBT
YWkgVGVqYSA8YWx1dmFsYS5zYWkudGVqYUBpbnRlbC5jb20+IHdyb3RlOg0KPg0KPiBIaSBTYWks
DQo+DQo+IE9uIFdlZCwgU2VwIDMwLCAyMDI2IGF0IDM6NTPigK9BTSBTYWkgVGVqYSBBbHV2YWxh
IDxhbHV2YWxhLnNhaS50ZWphQGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBBZGQgZW11bGF0
b3IvaGNpX3Jma2lsbCwgYSBzdGFuZGFsb25lIHRvb2wgdGhhdCBkcml2ZXMgdGhlIA0KPiA+IGZv
cmNlX2h3X3Jma2lsbCBkZWJ1Z2ZzIGhvb2sgZm9yIGFuIGhjaU4gZGV2aWNlIGFuZCB2ZXJpZmll
cyB0aGUgDQo+ID4gcmVwb3J0ZWQgaGFyZHdhcmUtYmxvY2sgc3RhdGUgYWdhaW5zdCAvc3lzL2Ns
YXNzL3Jma2lsbC4gVGhlIGhvb2sgDQo+ID4gZXhlcmNpc2VzIHRoZSBnZW5lcmljIG5ldC9ibHVl
dG9vdGggcmZraWxsIHBhdGggZm9yIGFueSBIQ0kgDQo+ID4gdHJhbnNwb3J0OyBpdCBkb2VzIG5v
dCB0ZXN0IHRoZSBkcml2ZXIncyBoYXJkd2FyZSBpbnRlcnJ1cHQgb3IgcmVnaXN0ZXIgaGFuZGxp
bmcuDQo+ID4NCj4gPiBTdXBwb3J0IGFzc2VydC1vbmx5LCBkZWFzc2VydC1vbmx5LCBhbmQgdG9n
Z2xlIG1vZGVzLiBWYWxpZGF0ZSB0aGUgDQo+ID4gaGNpTiBhcmd1bWVudCBiZWZvcmUgdXNpbmcg
aXQgaW4gZmlsZXN5c3RlbSBwYXRocy4gSW4gdG9nZ2xlIG1vZGUsIA0KPiA+IGlmIGFzc2VydGlu
ZyB0aGUgYmxvY2sgd2FzIHdyaXR0ZW4gc3VjY2Vzc2Z1bGx5IGJ1dCBzdWJzZXF1ZW50IA0KPiA+
IHZlcmlmaWNhdGlvbiBmYWlscywgc3RpbGwgYXR0ZW1wdCBhIHZlcmlmaWVkIHVuYmxvY2sgd2hp
bGUgDQo+ID4gcHJlc2VydmluZyB0aGUgZmFpbHVyZSByZXN1bHQuIERvIG5vdCBhdHRlbXB0IGFu
IHVuYmxvY2sgd2hlbiB0aGUgDQo+ID4gYXNzZXJ0IHdyaXRlIGl0c2VsZiBmYWlscy4NCj4gPg0K
PiA+IFRoZSBvcHRpb25hbCAtci8tLXJlc3RvcmUgbW9kZSBzbmFwc2hvdHMgdGhlIGFkYXB0ZXIn
cyB1cC9kb3duIHN0YXRlIA0KPiA+IHZpYSBIQ0lHRVRERVZJTkZPIGFuZCByZXN0b3JlcyBpdCB2
aWEgSENJREVWVVAvSENJREVWRE9XTiwgZm9sbG93aW5nIA0KPiA+IHRoZSByYXcgSENJIGNvbnRy
b2wtc29ja2V0IGFwcHJvYWNoIHVzZWQgYnkgdG9vbHMvaGNpY29uZmlnLmMuDQo+ID4NCj4gPiBV
c2FnZTogaGNpX3Jma2lsbCBbLWV8LWR8LXRdIFstcl0gaGNpTg0KPg0KPiBJIGhhdmUgYSBoYXJk
IHRpbWUgdW5kZXJzdGFuZGluZyB3aHkgd2UgY2FuJ3QganVzdCB1c2UgdGhlIGByZmtpbGxgIHRv
b2wgZm9yIHRoaXMgcHVycG9zZSwgb3IgZG9lcyBpdCBub3Qgc3VwcG9ydCBoYXJkd2FyZS1ibG9j
az8gSXQgc2VlbXMgaXQgZG9lczoNCj4NCj4gcmZraWxsIC0taGVscA0KPg0KPiBVc2FnZToNCj4g
IHJma2lsbCBbb3B0aW9uc10gY29tbWFuZCBbaWRlbnRpZmllciAuLi5dDQo+DQo+IFRvb2wgZm9y
IGVuYWJsaW5nIGFuZCBkaXNhYmxpbmcgd2lyZWxlc3MgZGV2aWNlcy4NCj4NCj4gT3B0aW9uczoN
Cj4gIC1KLCAtLWpzb24gICAgICAgICAgICAgdXNlIEpTT04gb3V0cHV0IGZvcm1hdA0KPiAgLW4s
IC0tbm9oZWFkaW5ncyAgICAgICBkb24ndCBwcmludCBoZWFkaW5ncw0KPiAgLW8sIC0tb3V0cHV0
IDxsaXN0PiAgICBkZWZpbmUgd2hpY2ggb3V0cHV0IGNvbHVtbnMgdG8gdXNlDQo+ICAgICAgLS1v
dXRwdXQtYWxsICAgICAgIG91dHB1dCBhbGwgY29sdW1ucw0KPiAgLXIsIC0tcmF3ICAgICAgICAg
ICAgICB1c2UgdGhlIHJhdyBvdXRwdXQgZm9ybWF0DQo+DQo+ICAtaCwgLS1oZWxwICAgICAgICAg
ICAgIGRpc3BsYXkgdGhpcyBoZWxwDQo+ICAtViwgLS12ZXJzaW9uICAgICAgICAgIGRpc3BsYXkg
dmVyc2lvbg0KPg0KPiBBdmFpbGFibGUgb3V0cHV0IGNvbHVtbnM6DQo+ICBERVZJQ0UgICAgICBr
ZXJuZWwgZGV2aWNlIG5hbWUNCj4gIElEICAgICAgICAgIGRldmljZSBpZGVudGlmaWVyIHZhbHVl
DQo+ICBUWVBFICAgICAgICBkZXZpY2UgdHlwZSBuYW1lIHRoYXQgY2FuIGJlIHVzZWQgYXMgaWRl
bnRpZmllcg0KPiAgVFlQRS1ERVNDICAgZGV2aWNlIHR5cGUgZGVzY3JpcHRpb24NCj4gIFNPRlQg
ICAgICAgIHN0YXR1cyBvZiBzb2Z0d2FyZSBibG9jaw0KPiAtPiBIQVJEICAgICAgICBzdGF0dXMg
b2YgaGFyZHdhcmUgYmxvY2sNCj4NCj4gW1NhaV06IFRoZSByZmtpbGwgdG9vbCBjYW4gbGlzdCBS
RktJTEwgZGV2aWNlcyBhbmQgY29udHJvbCB0aGUgDQo+IHNvZnR3YXJlIGJsb2NrIHdpdGggYHJm
a2lsbCBibG9ja2AgYW5kIGByZmtpbGwgdW5ibG9ja2AsIGJ1dCBpdCBjYW5ub3QgDQo+IHN5bnRo
ZXNpemUgYSBoYXJkd2FyZSByZmtpbGwgYmxvY2suIFRoZSBoYXJkd2FyZSBzdGF0ZSBpcyBub3Jt
YWxseSANCj4gcmVwb3J0ZWQgYnkgdGhlIHRyYW5zcG9ydCBkcml2ZXIgYW5kIGlzIHJlYWQtb25s
eSBmcm9tIHVzZXJzcGFjZS4NCj4NCj4gVG8gc2ltdWxhdGUgYSBoYXJkd2FyZSBibG9jayBmb3Ig
dGVzdGluZywgd2Ugc3RpbGwgbmVlZCBhIGtlcm5lbC1zaWRlIA0KPiBpbmplY3Rpb24gcG9pbnQs
IHN1Y2ggYXMgYSBkZWJ1Z2ZzIGVudHJ5LCB0aGF0IGludm9rZXMgdGhlIHNhbWUgSENJIA0KPiBo
YXJkd2FyZS1zdGF0ZSBub3RpZmljYXRpb24gcGF0aCB1c2VkIGJ5IHRoZSBkcml2ZXIuDQo+DQo+
IGhvd2V2ZXIsIFRoZSB0ZXN0IHRvb2wgZG9lcyBub3QgbmVlZCBhIHNlcGFyYXRlIFJGS0lMTC1j
b3JlIEFQSSBmb3IgDQo+IHZhbGlkYXRpb24uIEFmdGVyIHdyaXRpbmcgdGhlIHNpbXVsYXRlZCBz
dGF0ZSB0aHJvdWdoIGRlYnVnZnMsIA0KPiB1c2Vyc3BhY2UgY2FuIHJlYWQgdGhlIGV4aXN0aW5n
IGAvc3lzL2NsYXNzL3Jma2lsbC9yZmtpbGxOL2hhcmRgIA0KPiBlbnRyeS4gVGhlcmVmb3JlLCB0
aGUgZGVidWdmcyBlbnRyeSB3b3VsZCBvbmx5IHByb3ZpZGUgZXZlbnQgaW5qZWN0aW9uOyB0aGUg
c3lzZnMgaW50ZXJmYWNlIHdvdWxkIHByb3ZpZGUgdmFsaWRhdGlvbi4NCj4NCj4gVGhlIGRlYnVn
ZnMgcmVhZCBvcGVyYXRpb24gYW5kIHRoZSBzZXBhcmF0ZSBgcmZraWxsX2hhcmRfYmxvY2tlZCgp
YCANCj4gaGVscGVyIGFyZSBub3QgcmVxdWlyZWQuIHdlIGNhbiBkcm9wIHRoZW0NCj4NCj4gVGhl
IHJlYXNvbiBJIGNvbnNpZGVyZWQgdGhlIGVtdWxhdG9yIHRvb2wgaXMgdGhhdCB0aGUgZXhpc3Rp
bmcgDQo+IGByZmtpbGxgIGluamVjdGlvbiBwYXRoLCBjaGFuZ2VzIGluIGBuZXQvYmx1ZXRvb3Ro
YCBzdWNoIGFzIHRoZSBIQ0kgDQo+IFJGS0lMTCBub3RpZmljYXRpb24sIGBIQ0lfUkZLSUxMRURg
IGhhbmRsaW5nLCBhbmQgdGhlIHJlc3VsdGluZyANCj4gY29udHJvbGxlciBwb3dlci10cmFuc2l0
aW9uIHdvcmsgYXJlIG5vdCBkaXJlY3RseSB2YWxpZGF0ZWQgZm9yIGh3IA0KPiByZmtpbGwudGhl
eSBhcmUgdmFsaWRhdGVkIGZvciBzdyByZmtpbGwgcGF0aA0KPg0KPiBteSB1bmRlcnN0YW5kaW5n
IGlzIHRoYXQgdGhlIGV4aXN0aW5nIGByZmtpbGxgIGNvbW1hbmQgaXMgdXNlZnVsIGZvciANCj4g
dGVzdGluZyB0aGUgc29mdHdhcmUgYmxvY2svdW5ibG9jayBwYXRoLCB3aGlsZSANCj4gYC9zeXMv
Y2xhc3MvcmZraWxsL3Jma2lsbE4vaGFyZGAgYWxsb3dzIHVzZXJzcGFjZSB0byBpbnNwZWN0IHRo
ZSANCj4gaGFyZHdhcmUgYmxvY2sgYml0LiBOZWl0aGVyIGludGVyZmFjZSBpbmplY3RzIGEgaGFy
ZHdhcmUgZXZlbnQgb3IgDQo+IGV4ZXJjaXNlcyB0aGUgY29tcGxldGUgQmx1ZXRvb3RoIHN0YWNr
IHBhdGguDQo+DQo+IERvIHlvdSB0aGluayBpdCBpcyB3b3J0aHdoaWxlIHRvIGtlZXAgYSBzbWFs
bCBgaGNpX3Jma2lsbGAgZW11bGF0b3IgDQo+IHRvb2wgdG8gaW5qZWN0IHRoZSBoYXJkd2FyZSBz
dGF0ZSBhbmQgdmFsaWRhdGUgdGhlIEhDSSBSRktJTEwgDQo+IG5vdGlmaWNhdGlvbiwgYEhDSV9S
RktJTExFRGAgaGFuZGxpbmcsIGFuZCBjb250cm9sbGVyIHBvd2VyLXRyYW5zaXRpb24gDQo+IHBh
dGggaW4gc3RhY2s/IElmIG9ubHkgU1cgUkZLSUxMIHN0YXRlIHZhbGlkYXRpb24gaXMgbmVlZGVk
LCB0aGVuIHRoZSANCj4gZW11bGF0b3IgY2FuIGJlIGRyb3BwZWQ7IGlmIHRoZSBnb2FsIGlzIGNv
bXBsZXRlIEJsdWV0b290aCBzdGFjayANCj4gdmFsaWRhdGlvbiBmb3IgaHcgcmZraWxsLCBJIHRo
aW5rIGtlZXBpbmcgaXQgaXMgd29ydGh3aGlsZS4gSSB3b3VsZCBhcHByZWNpYXRlIHlvdXIgc3Vn
Z2VzdGlvbiBvbiB3aGljaCBzY29wZSBpcyBwcmVmZXJyZWQuDQoNCk15IGFzc3VtcHRpb24gaXMg
dGhhdCBpZiB0aGlzIGZ1bmN0aW9uYWxpdHkgd2VyZSBuZWVkZWQsIGl0IHNob3VsZCBiZSBwYXJ0
IG9mIGByZmtpbGxgIGRpcmVjdGx5LiBBbHRlcm5hdGl2ZWx5LCBpZiB5b3UgcmVhbGx5IHdhbnQg
dG8gZXhlcmNpc2UgdGhpcyBjb2RlLCBJZCBwcm9iYWJseSByZWNvbW1lbmQgZG9pbmcgaXQgdmlh
IHBsYXRmb3JtIGxheWVyIHdoaWNoIGltcGxlbWVudHMgdGhlIGFjdHVhbCBoYXJkd2FyZSBsaW5l
LCB0aHVzIGV4ZXJjaXNpbmcgdGhlIGNvZGUgcGF0aCBleGFjdGx5IGFzIHJlYWwgaGFyZHdhcmUg
d291bGQsIHJhdGhlciB0aGFuIHRocm91Z2ggYSBCbHVldG9vdGgtc3BlY2lmaWMgZGVidWdmcyBl
bnRyeS4NCg0KW1NhaV06IEFncmVlZC4gRm9yIHRoaXMgc2VyaWVzLCBgYnRpbnRlbF9wY2llYCBp
cyB0aGUgaW1wbGVtZW50YXRpb24gdGhhdA0Kb3ducyBhbmQgZGV0ZWN0cyB0aGUgYWN0dWFsIGhh
cmR3YXJlIHJma2lsbCBldmVudC4gVGVzdGluZyB0aHJvdWdoIGl0cw0KaW50ZXJydXB0L2Rvb3Ji
ZWxsIHBhdGggZXhlcmNpc2VzIHRoZSBmbG93IGZyb20gaGFyZHdhcmUgbGluZToNCg0KICAgIGJ0
aW50ZWxfcGNpZSAtPiBoY2lfcmZraWxsX3NldF9od19zdGF0ZSgpDQogICAgICAgICAgICAgICAg
IC0+IFJGS0lMTCBzdGF0ZQ0KICAgICAgICAgICAgICAgICAtPiBIQ0lfUkZLSUxMRUQgaGFuZGxp
bmcNCiAgICAgICAgICAgICAgICAgLT4gY29udHJvbGxlciBwb3dlciB0cmFuc2l0aW9uDQoNCkJh
c2VkIG9uIHlvdXIgc3VnZ2VzdGlvbiwgSSB3aWxsIGRyb3AgdGhlIEJsdWV0b290aC1zcGVjaWZp
Yw0KZGVidWdmcy9lbXVsYXRvciBwYXRjaGVzIGFuZCByZXRhaW4gdGhlIEhDSSBub3RpZmljYXRp
b24gY2hhbmdlcyBhbmQgdGhlDQpgYnRpbnRlbF9wY2llYCBpbXBsZW1lbnRhdGlvbi4gSWYgYSBn
ZW5lcmljIHNvZnR3YXJlIGluamVjdGlvbiBtZWNoYW5pc20NCmlzIG5lZWRlZCBsYXRlciwgaXQg
c2hvdWxkIGJlIGRlc2lnbmVkIGFzIHBhcnQgb2YgdGhlIFJGS0lMTCBzdWJzeXN0ZW0NCnJhdGhl
ciB0aGFuIGFkZGVkIHNwZWNpZmljYWxseSB0byBCbHVldG9vdGguDQo=
