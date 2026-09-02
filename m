Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13369492187;
	Wed,  2 Sep 2026 13:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788355509; cv=fail; b=ekSQ18hD8aM2u6f5X6pgxsZY1Fj96Ez3ZMpHkDRJb7zj3PiR544IM2C0Os/8qpIITTIuLcnc1wU18N43kb8oQyIM9pnHMnsluYwni6BraRawUsE7Yo570kyrRSTRGfEgvXi121+C7jEjfJ3WEDSYxPqhdgq4XjxXMcLAG+MqYYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788355509; c=relaxed/simple;
	bh=NsFmpJwVK3K3l47ENucAlQ60Q5dcTedejPKkX/Thh4A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rpxM0kf8rrjL3rLL6T+psGADmZ/yCdCqwH5pGRZoO6O/Y1v/BGaX52qYRaN8XHswtEXe3HqMJ0IEvsER2xarSvnbnFof18DnafftBjcbNzMMcO1VUueJ7Yqe2NZnIXqHP4weAstVMmpAPUcll6jYfFcn4b7iVrDreXno7Z0zjps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l4hesbDY; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l4hesbDY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788355509; x=1819891509;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NsFmpJwVK3K3l47ENucAlQ60Q5dcTedejPKkX/Thh4A=;
  b=l4hesbDYOyNbbgVfnMY67LN5IeXJlMWZLron4A23RKTe4VdJ9UF6+xlf
   /ZozZWLTtW/1v+4jdk1UXvtH5mzG5vdOEN4WOeyk7tkAdmLNqgnBKndLU
   YmPmxUwgcS0WwHFJPTTqYCc0bh29sN22JygP7MAU62sUhNihG5uV7viE3
   QJbIzXVsS8s22kTSc+rOMcu/mTq6taMtmDxMEVVQEMCOaxP4sCt+7vh0j
   LDbp5N4NlAilz7FWIDrh8uT3ZVdd9PObOecbXtDAxzVrMLiqWU2jDnay3
   QU+SAX3U9u+YlWspH1RGwTQmIvhxgD7r/nC8A9mwAHKbM+a3UTlazPxNB
   w==;
X-CSE-ConnectionGUID: fMbp/he5SCiyapODEOW20Q==
X-CSE-MsgGUID: z+ZhnewJQm+xNgBH+NgvAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88860766"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="88860766"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 06:25:08 -0700
X-CSE-ConnectionGUID: 82zcXf3DTVKYecE1OSJPsg==
X-CSE-MsgGUID: UAIv2yCtRZuTGhnR/tJOJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="307620530"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 06:25:08 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 06:25:07 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 06:25:07 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.26) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 06:25:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKhdmtAV3z13Kty1dhcJ5GWNJt7PGbHbQ9tb1qDVqmEUJL4Yo3DuwsVoUIunEfAkl7Ntw2C47QweFRtDMmVvU1Q3Q+mgJaqbtWFvogGkvKZhOJ5AFGKWSYZDOmNWDeOn5K+2gLMCnn90bXyVR0U/H/z1Lsc+6Rjej3sZY+b1ON9o705ysG2RozxcBWhnj+WQKhPGP5JlrPVMJ4g2iCUF6tG6eQCM/qgQVfOL28qblXIydikMnMjyati7YwdW3VF1X7IFW8+Iob+enPwU92zs+vJ0LYpqjWcJRGOO3NKICBRDs6EBfj6WihaR1y61cNlOUD30VVv0rW0/LGXt92cZlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsFmpJwVK3K3l47ENucAlQ60Q5dcTedejPKkX/Thh4A=;
 b=j/zkdvSGJXwJgn7GK33SHCJx2Mx6q9BPBr2eWyWzfhncAVKgXTN51MDXeLBdWcEYz7Kxl/cOlAXRWT3dA4he+sJ2EJeEzdhH0KjHe0C+zJPPQsmi1uD4eOur8fvlXRN1jjir19Df7+uBhwIYGXRqbAs910nJfkWiFZo1Z7Qw0eGElWzASEFkqsWAL97KibhReFYH84kbWrAr4cfNGP7QGD30wnrufUXIRoDOsRdX2u6enArKhQJMDAq8i9eJcOsxGfrfpd5KINCwFlo3UIlft/Oz6a7jtyNbZgpQqCOecGqesK1JlRiiB8bWs8fbmyIZgecYeBdF1tDGWaSlSznUww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV8PR11MB8557.namprd11.prod.outlook.com (2603:10b6:408:1e8::15)
 by CH0PR11MB8144.namprd11.prod.outlook.com (2603:10b6:610:18d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 13:24:59 +0000
Received: from LV8PR11MB8557.namprd11.prod.outlook.com
 ([fe80::ff75:7102:4056:b2d5]) by LV8PR11MB8557.namprd11.prod.outlook.com
 ([fe80::ff75:7102:4056:b2d5%7]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 13:24:59 +0000
From: "L, Catherine" <catherine.l@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "K, Kiran" <kiran.k@intel.com>,
	"L@web.codeaurora.org" <L@web.codeaurora.org>
Subject: RE: [PATCH v1] Bluetooth: btusb: Add support for Intel Otter Peak2
 (OrP2)
Thread-Topic: [PATCH v1] Bluetooth: btusb: Add support for Intel Otter Peak2
 (OrP2)
Thread-Index: AQHdOsaptHr4SxYlVUy1hfByJUpjG7a7INmAgAAfGbA=
Date: Wed, 2 Sep 2026 13:24:59 +0000
Message-ID: <LV8PR11MB8557856033B8361FC3A8CCC8E6B72@LV8PR11MB8557.namprd11.prod.outlook.com>
References: <20260902160407.257899-1-catherine.l@intel.com>
 <c02e3bfb-dd46-4c58-96e4-8f8bb5ca3508@molgen.mpg.de>
In-Reply-To: <c02e3bfb-dd46-4c58-96e4-8f8bb5ca3508@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR11MB8557:EE_|CH0PR11MB8144:EE_
x-ms-office365-filtering-correlation-id: 95730558-6d57-4fd1-73cd-08df08f59655
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|38070700021|10067099003|11063799006|22082099003|18002099003|4143699003|56012099006;
x-microsoft-antispam-message-info: QJqge6247qU09jbPDUQkswYPDH52oAyfGXIQvU3CGVpuA0yNN8YuYX/2pq5gkyNzkrOJhV0wff9OO8q76yZWeyaY3I/g9zHnPlqyOefQvRGaLnx1htesQXM06H70YhWBb98H5Dx8CVVwJTIygHnTfnGBJuWwUpvfdIqfnkBI8TsfD0eN+NSJMTn77TVAm4sSMKz4ZuuV96s0u3EsJO29+XpbAs/S/SbadCU+jhb+1Bq14nk2Xqmd8BFLhQVRSYBbXYewFiqr5QfHs3GbRorYt++MpsbKRcw/dU762jamj0IVGf1n5GiGwMZkdEnJUAaY+h6YXqTImnXdVB2bK5ejMCOwxmdOxjp2Do4DlI6/7U5PDXZn0W7zI1SE6WBPXLlc05qUaB/P4gcHta33OcBn3lW4V8+fojAWYI+dQElCpQmw7dP0ttO+XCleg9buR1l0q6Z1FBsk4szrclFtp6wm71X9WfYG4qOeuyROUEY2arYJafpuY3yZiXTicVxaGFubvexT30/1EaHwrJw8L6u/1onioNv9DOxy+107rdsD0qJfh4+9GC6TTam6d12Vnyn51wAqJqVzx9ydESZC+bsQ9iBGk+k1qs+DmShT9+XBpy/Xirl9epZmD/BnByc8qLbsRr49XScCqzk9jiVbtPIrMajgRYPxND4XnTZZqxRTF9Kj68Ct/ymylqjs5yQrROJQM6I+I0BEdlVcoX52gl+UVqA/Uey53ClYi/DP15ug6vo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8557.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(38070700021)(10067099003)(11063799006)(22082099003)(18002099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUt0Tm1tWERTRjcvS1FveUhGT0RKdXV3d2VRYS9OM3hEeldocW5qRGdoeEZ5?=
 =?utf-8?B?RHpCVG85V3Q2RElaaVBtYnJsWDJaSjZqRkc1Y3M5Y0ZNb1g1TmUrd0dSTDVs?=
 =?utf-8?B?NWNXRlJaQmZGTlQ2QXV4VlFzb04xYjR2NVovaWJnVWJTV3VhUTY3Tjk4YW40?=
 =?utf-8?B?Q1hjMjJqTkxFamp5YjkrNzQzL3VkUUhVa2w4WHdDbUZDMjJTclQrUzYzQkpD?=
 =?utf-8?B?L2I5Y2xleTh2VG0xTFBaYmc4THVIRGF6dHlaV0psME9YWXp5RjN5dUdGMDlO?=
 =?utf-8?B?U1JITGd5bDI4R3BCSERidDFQSjJvMUZCMkIxbG15Yk5YeE9oZkVOdDk4VHRW?=
 =?utf-8?B?cW1oVFI0OGg1RnNGMWRKKzJ2VFBiMDdvTUhHakdwbmJwSXpYSEJZaUlqNnk5?=
 =?utf-8?B?WGRHYis5VWlKeWt5WmltbjZvV042OHNVQXF2bzh2SU1zSVNVWjZQaFo3aFZL?=
 =?utf-8?B?SzlENUFJQjFNTlF0VEJEYkJwcmpwbGdjUWo1cWR5VHZaRUloNVd0VXVHNFRX?=
 =?utf-8?B?dEN6QXFPd3RLRnFwWUtrLy9TMkExU2NDS2lqdmErWlF5ZjBFVGhna0VGSzFI?=
 =?utf-8?B?VFRYT3Q4aXA1SnJKS1NybVM5ZWZ0WkYwTVJPYjE4TXg2YTdxR2grVjRDU2tE?=
 =?utf-8?B?N0lCUktCTDJ1Q0pKK0YxTlJONWZ1bXYxQWtSc3pnVWNTaWRFVXA4ZWVFVUVX?=
 =?utf-8?B?cncvNUJwbDBwU2dxS3BMbFFIazBVekxxNGNhaU5rcnBabWhmY0xXK3FrT2hF?=
 =?utf-8?B?ZkhUMFY0bmdJcmYrMkpnNDhBNDBNaUNXY04vNnFVdVVlcjNSUmNjMWkwVjI0?=
 =?utf-8?B?NjFvS2EyRklsdjZCbzFrRStwck1iOFFYTno4bGY5N3dtbHhWbE9LMzJyaExh?=
 =?utf-8?B?d2IrL3FCa0tMRS9Td1ZnZ2R6WWJrTE50TkQxbVVtVUEvNC9ic2d3bmxYQ0V0?=
 =?utf-8?B?Z2RCdHFBNjFlMDNvWlNYQTlEOUdRc3M3cE1XSkE2aXBaSUwyakJ2eDBYU3N2?=
 =?utf-8?B?VllpdHQ1NUd6MW5XNU80eHJMS3RaNUdvWlF0OTJRUTBWTC9CMjdMblp3QnZC?=
 =?utf-8?B?MVpBNnB4L09JcHVpQUhMZWhpdDJoZ1ZQeTIrVDVwaFp0QisrZXI4MVNHSHcr?=
 =?utf-8?B?Nkk1SzZmWU5sQksvbW1LamRlUU1YRS9wQjZTSWx2Y1c3eHdYNys4VkdsQ2lz?=
 =?utf-8?B?bmpVOEFhQm1TMTd3UmhUYWNrc0Z5bExpVTQ1bVE5Q3R3VE9CYWdRbnFyb1ps?=
 =?utf-8?B?cHRZNlVrS3U0VHlycmFSV3lPVGZybk5Manp5MzZSdm90Y0RueVJBOXFnbzFt?=
 =?utf-8?B?WGcxMnN4Ulh1NE5oaVpjcHJDMnZiZXVNMWtKTWVHZFBsQm9yTGIrZlZ0WEVK?=
 =?utf-8?B?ZzA0VTZZc2NJV24rblhzVVFhQm91L1lCcklHNUg5NTMzaUgwY3hmS0lzN0wy?=
 =?utf-8?B?VDNTc2piVWZKNEdjRHpLVTJxellMSWowSnYvV3g3eVZDdDlKajZ2bm5WUnkr?=
 =?utf-8?B?cXJ5am9OYnJFWk5ZcWR5bzNWVno0cWlaTEdob3ovakF4anR4TWp0c0xnbDVK?=
 =?utf-8?B?cGpYZU1sUkVrZ01WcXJ0bWVuSTRrRm9zS0dkeGg2VHBUL2toYm95c0lrd3hk?=
 =?utf-8?B?VHI2ZEU5cG92azlpZERRcUVVVmVvNlUrM3pUdmtyd08vVVJjTFJFTmlGTXBN?=
 =?utf-8?B?OUNEZVVHbC9USjJXUVlEUlpQWHlKY1NDZUozWkhzdGJCNG9lUzZyNnloMFBC?=
 =?utf-8?B?WFpYNGFDdjVrTDdZYW0rOEQ0WUhHZmlWQTBocWk1REJLL2MyRVBsY2M5SGJ0?=
 =?utf-8?B?YnVGaUxEc0Q2enpXRVJSYkphZFowVmFQNjVvOUNMVlRjbFNZMWJhR2FjL3Iy?=
 =?utf-8?B?cVVzbzVkQm5IQlNYWmF6OUVNQUhvc1RDSGRUeXNqdEk4TmxpeGFUSU4vdGlT?=
 =?utf-8?B?ZVJseXcxR0t6WnpUV3VpMzJ5WTlmMC9aZEdEeCtGT0R5SzVGZDNBT3Yxb0k4?=
 =?utf-8?B?eDJqRlVMSkxCdXY2azNzM08zZ1JtMUJ5TEJtbUdsNTNJMjc4QitrSVQwZ2px?=
 =?utf-8?B?SnozNGZTWkRNU1pTOGZVUmVTTC9sUkZYYnpkOGZnT2FsUE1HaCt5VlMvTmdI?=
 =?utf-8?B?SUdYbE1VbWdTY25yQVRqY21hNCs0MmhRWW1oOHRBODQzcyswYnB3cHVkZ0hp?=
 =?utf-8?B?cnVOa2FWdzBOUHNmNGhTeEVYRjcwQmxMY3NSQzlzWld1cGdaY2RUamxTOXoy?=
 =?utf-8?B?eXJtR1J3c29JTzVVVkNNQUhkdFdkZWxidXF4MmZ1M2RLWTRKUHR3TlBIVFBo?=
 =?utf-8?B?QThWeGRBSFVGMDAxZlY0cUt4aDF5bTkrTU1qWGl1YlVyY09FMGF4UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: xR1he/7qUU30Psxx8gL3Va7VzQ73MZpT5jOELLY/zqpwmraBdWSsCk/7Wf8/odx+Yu2rQ6c5/ud3jzNmdJA0gnvulsdnnFlKpDrLafc+DTwRMuMVSM/sMXQxmdjGz0AE0WYghOjTgZ2yG6hlRpiZRdXcO++pIs0OVjfPJt1V+wGK2xlC3aVD+w7uqpXxuNEc/XpBL9kYdScvicuS3qgetbzJl8CgGqU0/00mKHarMNSF6vVj7wpwG4X+w5pEFKWj4kQ3K+uKsFYPkOgZ3RCgEQfAMcoTOeiIW+Q1MaMfh8dX4Lf/bTbSG15o7pU81QniPfFtClsmQ2XDVx+/NDyp+w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8557.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95730558-6d57-4fd1-73cd-08df08f59655
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 13:24:59.1469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3BdgfMAR98yDZbzHkOdfS1iACuqs3kdG9NjmZc4WHSt1djpTSTPnIqxfEc3yHaMbxiBwOJdr+5V/V+JstvDFdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8144
X-OriginatorOrg: intel.com

SGkgUGF1bCwNClRoYW5rcyBmb3IgdGhlIGNvbW1lbnRzLg0KDQoNCi0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQpGcm9tOiBQYXVsIE1lbnplbCA8cG1lbnplbEBtb2xnZW4ubXBnLmRlPiANClNl
bnQ6IDAyIFNlcHRlbWJlciAyMDI2IDE2OjM3DQpUbzogTCwgQ2F0aGVyaW5lIDxjYXRoZXJpbmUu
bEBpbnRlbC5jb20+DQpDYzogbWFyY2VsQGhvbHRtYW5uLm9yZzsgbHVpei5kZW50ekBnbWFpbC5j
b207IGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IEssIEtpcmFuIDxraXJhbi5rQGludGVsLmNvbT47IExAd2ViLmNvZGVhdXJvcmEu
b3JnDQpTdWJqZWN0OiBSZTogW1BBVENIIHYxXSBCbHVldG9vdGg6IGJ0dXNiOiBBZGQgc3VwcG9y
dCBmb3IgSW50ZWwgT3R0ZXIgUGVhazIgKE9yUDIpDQoNCkRlYXIgQ2F0aGVyaW5lLA0KDQoNClRo
YW5rIHlvdSBmb3IgeW91ciBwYXRjaC4NCg0KQW0gMDIuMDkuMjYgdW0gMTg6MDQgc2NocmllYiBD
YXRoZXJpbmUgTDoNCj4gRnJvbTogIkwsIENhdGhlcmluZSIgPGNhdGhlcmluZS5sQGludGVsLmNv
bT4NCg0KUGxlYXNlIHVzZSB0aGUgZm9ybWF0IHdpdGhvdXQgY29tbWE6IENhdGhlcmluZSBMLg0K
QWNrLCBXaWxsIGNoYW5nZSBpbiB2MiBwYXRjaA0KDQo+ICQgbHN1c2INCj4gQnVzIDAwMyBEZXZp
Y2UgMDAzOiBJRCA4MDg3OjAwNDMgSW50ZWwgQ29ycC4NCj4gDQo+ICQgY2F0IC9zeXMva2VybmVs
L2RlYnVnL3VzYi9kZXZpY2VzDQo+IFQ6ICBCdXM9MDMgTGV2PTAxIFBybnQ9MDEgUG9ydD0wOSBD
bnQ9MDIgRGV2Iz0gIDMgU3BkPTEyICAgTXhDaD0gMA0KPiBEOiAgVmVyPSAyLjAxIENscz1lMCh3
bGNvbikgU3ViPTAxIFByb3Q9MDEgTXhQUz02NCAjQ2Zncz0gIDENCj4gUDogIFZlbmRvcj04MDg3
IFByb2RJRD0wMDQzIFJldj0gMC4wMA0KPiBDOiogI0lmcz0gMiBDZmcjPSAxIEF0cj1lMCBNeFB3
cj0xMDBtQQ0KPiBJOiogSWYjPSAwIEFsdD0gMCAjRVBzPSAzIENscz1lMCh3bGNvbikgU3ViPTAx
IFByb3Q9MDEgRHJpdmVyPWJ0dXNiDQo+IEU6ICBBZD04MShJKSBBdHI9MDMoSW50LikgTXhQUz0g
IDY0IEl2bD0xbXMNCj4gRTogIEFkPTAyKE8pIEF0cj0wMihCdWxrKSBNeFBTPSAgNjQgSXZsPTBt
cw0KPiBFOiAgQWQ9ODIoSSkgQXRyPTAyKEJ1bGspIE14UFM9ICA2NCBJdmw9MG1zDQo+IEk6KiBJ
ZiM9IDEgQWx0PSAwICNFUHM9IDIgQ2xzPWUwKHdsY29uKSBTdWI9MDEgUHJvdD0wMSBEcml2ZXI9
YnR1c2INCj4gRTogIEFkPTAzKE8pIEF0cj0wMShJc29jKSBNeFBTPSAgIDAgSXZsPTFtcw0KPiBF
OiAgQWQ9ODMoSSkgQXRyPTAxKElzb2MpIE14UFM9ICAgMCBJdmw9MW1zDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBMLCBDYXRoZXJpbmUgPGNhdGhlcmluZS5sQGludGVsLmNvbT4NCg0KRGl0dG8uDQpB
Y2ssIFdpbGwgY2hhbmdlIGluIHYyIHBhdGNoDQoNCj4gLS0tDQo+ICAgZHJpdmVycy9ibHVldG9v
dGgvYnR1c2IuYyB8IDIgKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYyBiL2RyaXZlcnMvYmx1
ZXRvb3RoL2J0dXNiLmMgDQo+IGluZGV4IDAzMDM5Y2VhYTc3ZC4uYTRmZGY2NTQ5MTI3IDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2JsdWV0b290aC9idHVzYi5jDQo+ICsrKyBiL2RyaXZlcnMvYmx1
ZXRvb3RoL2J0dXNiLmMNCj4gQEAgLTQ4OCw2ICs0ODgsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IHVzYl9kZXZpY2VfaWQgcXVpcmtzX3RhYmxlW10gPSB7DQo+ICAgCXsgVVNCX0RFVklDRSgweDgw
ODcsIDB4MDAzNyksIC5kcml2ZXJfaW5mbyA9IEJUVVNCX0lOVEVMX0NPTUJJTkVEIH0sDQo+ICAg
CXsgVVNCX0RFVklDRSgweDgwODcsIDB4MDAzOCksIC5kcml2ZXJfaW5mbyA9IEJUVVNCX0lOVEVM
X0NPTUJJTkVEIH0sDQo+ICAgCXsgVVNCX0RFVklDRSgweDgwODcsIDB4MDAzOSksIC5kcml2ZXJf
aW5mbyA9IEJUVVNCX0lOVEVMX0NPTUJJTkVEIA0KPiB9LA0KPiArCS8qIE90dGVyIFBlYWsyLCBX
aWxkY2F0IExha2UgKi8NCj4gKwl7IFVTQl9ERVZJQ0UoMHg4MDg3LCAweDAwNDMpLCAuZHJpdmVy
X2luZm8gPSBCVFVTQl9JTlRFTF9DT01CSU5FRCB9LA0KDQpQbGVhc2Ugc29ydCBhbmQgcHV0IHRo
ZSBjb21tZW50IG9uIHRoZSBzYW1lIGxpbmUgYXMgYmVsb3cuDQpBY2ssIFdpbGwgY2hhbmdlIGlu
IHYyIHBhdGNoDQoNCj4gICAJeyBVU0JfREVWSUNFKDB4ODA4NywgMHgwMDQwKSwgLmRyaXZlcl9p
bmZvID0gQlRVU0JfSU5URUxfQ09NQklORUQgfSwgLyogTGl6YXJkIFBlYWsgMiAqLw0KPiAgIAl7
IFVTQl9ERVZJQ0UoMHg4MDg3LCAweDA3ZGEpLCAuZHJpdmVyX2luZm8gPSBCVFVTQl9DU1IgfSwN
Cj4gICAJeyBVU0JfREVWSUNFKDB4ODA4NywgMHgwN2RjKSwgLmRyaXZlcl9pbmZvID0gQlRVU0Jf
SU5URUxfQ09NQklORUQgfA0KDQoNCktpbmQgcmVnYXJkcywNCg0KUGF1bA0KDQpSZWdhcmRzLA0K
Q2F0aGVyaW5lIEwNCg==
