Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D6586323;
	Fri, 27 Mar 2026 12:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774614710; cv=fail; b=L8w9TibEh7g3ByZr4CTdjR3qZjmwGpY3FUPrQjl2Pb3J9Ec+Gz2X6Qta2sRdplH+U3FhZ/nHy3TeRqkl0Fa3G4sO5Qgw8g3PfQ1/9f4Dt6TBt1PC9jZrJq6nW0xoGOHyVx1KZnvMWiGRrdKidzsGaDoMWN7hPmolFV9W4JUZrS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774614710; c=relaxed/simple;
	bh=zaGu7bOJ1Xm0gVnk/QENguEK/ZcdlYAZ0GeNQYZbxQ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nq62A8Gr0n5lL2Zas4eXRPeOQmzNry+PsrZo960XQClt8dx8O35Dh9EAig27X7OyIv7WNKG3d32vFLCAck7w8M6nG11PKB20xP5+jZSwQk/Lzry9lYRHy83sG3SDkT4u6NVjLAwS/8CtKnPD6Y1IbEPduz4/hf8c0iUtx1bWToY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e6alvZbQ; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e6alvZbQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774614709; x=1806150709;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zaGu7bOJ1Xm0gVnk/QENguEK/ZcdlYAZ0GeNQYZbxQ4=;
  b=e6alvZbQGw2d0HOSqI0pfEyAw36JHLK27QQuZQIkr6aPFgzYtw5A3rG4
   x5JkBAcYGxHkRwgRQ1G2Z0y7d3Km02XYddTpYFG5aP7vu2ikIFsnli5G+
   sJyt/rGFic2B9TQV1cs4fgGJmWYIlutiSCaNzb4ffj1kETud5nbGvh2Ig
   HPrCAuo0FUpBxnPUtutC6xpdC71/8WG1DryhL9Y5+HfKhFPJ8fGides/z
   gUb5e0twj+dcWzwxkxbt78NzBB3TxAEdly/GQYxFPTphDiKuTnPpzesdr
   /RKapU9DsLgPPtpCPRoMWY0CF4uiUBK7JzUaRi886GePT/iTzUC4TvLI6
   A==;
X-CSE-ConnectionGUID: ZmuueedcSL2qHroBORs3wg==
X-CSE-MsgGUID: G31mhi5/RKuY0Z4TX5qvNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="86306541"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="86306541"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 05:31:48 -0700
X-CSE-ConnectionGUID: px4DUbliSD+/HrKXJzpg/A==
X-CSE-MsgGUID: 5LmacytyQj+5cXVLik1j0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="224342667"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 05:31:48 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 05:31:46 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Mar 2026 05:31:46 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.30) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 05:31:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ETREGXqdyS93J03mXUR26wtbOjzfKW93kc0NqKlbOS/VwO96KDRab7OKqi9w34gYhaOfZIAVGWJgyFhHeTGEQH/ScCMg9EmqvTZaE2J7TAvaH5aFMVqt9qoAjAu7Sosm4evdweyoehiOiRd8RlX3WkVj+E2Fe12huw47jRl9t/73j1R8jSUqhUWizQ5hc05LY0VcCZhlwNQ5dAYv8nyNWskaDX8IKYli1MwnIuRfFglG+yDbhnkrzY3Fr2h/GrBwp4/mEYKXtAZX5/5UQEKwOpiD8YovJLmFwOWw2uABFS3edDpn9cRWfva8CETiE1b8EmN+4HdR2bVqADDt10w1gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zaGu7bOJ1Xm0gVnk/QENguEK/ZcdlYAZ0GeNQYZbxQ4=;
 b=M4fkUCYQaDD8xReoFc8EkwBB8L6e85g2HRSu2qsuPtHhOTQLJ2x9eQP8ZW9tA78jtRNJUyTWiON9DSuzeboCG2Ju52U1otf8XkE3N8XncoAjTgjT5dtY5WrbnLFEa3ydzJ3f9IeoRr5phtPsy1INHz5rdIAH/V3nkLqVSeX3feMFl6APr84b0pByRPrp3hbAqd4A3N7remMtRTwG+TJqGXOrZj3isc9EbgxiS22r/F7+2rMff5KiKlyCkjPcobxt8IWJa0y5ZkoacNnNjbtCIn83IZxzMHuVm/DT5vjdprM7AI8GTtnx15VLAPiQge1iKP54TxErzwjjbJoDYGA1HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by MN2PR11MB4613.namprd11.prod.outlook.com (2603:10b6:208:26d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Fri, 27 Mar
 2026 12:31:44 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::3e58:d5d:4e05:885e]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::3e58:d5d:4e05:885e%3]) with mapi id 15.20.9769.004; Fri, 27 Mar 2026
 12:31:44 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Pengpeng Hou
	<pengpeng@iscas.ac.cn>
CC: "marcel@holtmann.org" <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Srivatsa,
 Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan, Chethan"
	<chethan.tumkur.narayan@intel.com>
Subject: RE: [PATCH] Bluetooth: btintel_pcie: fix TX queue off-by-one
Thread-Topic: [PATCH] Bluetooth: btintel_pcie: fix TX queue off-by-one
Thread-Index: AQHcu21iKSxuXAtUHUqUAAK3AfBaNLW9yIcAgASHngA=
Date: Fri, 27 Mar 2026 12:31:44 +0000
Message-ID: <PH0PR11MB7585A5C913A9913211471BEAF557A@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20260324085152.74986-1-pengpeng@iscas.ac.cn>
 <CABBYNZKGPBFOc5EwM=2wC3rjL6zZUXG0UdAdvq2zhu963LSw1Q@mail.gmail.com>
In-Reply-To: <CABBYNZKGPBFOc5EwM=2wC3rjL6zZUXG0UdAdvq2zhu963LSw1Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|MN2PR11MB4613:EE_
x-ms-office365-filtering-correlation-id: 2434afe7-380e-49e0-0d73-08de8bfcce3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: vVl097tcvK8K+sXzv/8KXGop99M2gPegQpeu/+jGxluIxR/2T1dKf889D3noEIHl+nBdsmx0Q99rZQ/BY5ai95rBG9sH33YA6p2C8uyhfLch8o6QzDYbk50sVWdF+pXZTMy7gy1xWHABBJcQPjy9gnmZq49mOPHY8+ePhYhazgKgtCiyrev+VWUVZPKa35m0YGE+JtBOjw/VmL6zDKepXXLugfuJ/KfIgfixwn3nVCzlXTaEMepYEJ2dA/MpOxzzpMfurX0E91BHUTsJDqN4G4kaDKw+A9vlOC5d0a7QWWXMvaaUDnCBvgo2Zd7gMqyqtcOF/h/qYzY/jBXmBaI08GHhoaK/8n13RK2iYQKsqKGcrd8ymafJRr7++xvwgtSdBj5zwg+thiFmk5XErjFYUAw071+ZWXSd9VV5Bnsi9tSG+4AXiuFCVEAClgqzbd/s7WSNK+ukPdzjbhohx3wTmw3gq3pz6CqI+8lEehJDrbCGSohYbs7OQuFJQUDJhCUhEflNQ+lOHrPhkpPQNF5+YoF2s+DM7gHHz+7tCUcRDeX42H8+OxTfssL2PL6njfEce60pDnKNy7n41ODN2mGXxyvvHc/TLt+eoGNMIkC8+cxv4s4zMjnDMqw8/g3BmTsZFJ+WP787tlusCX7gKSQERsXQQp4dGhoCGZIuI4KGcTT4SxYAhUmzbwHfct1HrAreTUtv5CbXggUtaOiVGBHGoTFHqavmwVrm6NbVdKMmfn2tLdF7MG6WZqcTJ3I5H4oOTZZAxz7mw0c+4Ex79Nbt4c25YXkfAqP4JzI+S6z3CQI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEVEeWNZaXc2bHR1WUNSeGZ6WEZUdUttRUpqTStlZkR3eFZsdUVONzc2RFFt?=
 =?utf-8?B?KzcrYzM4SUNGNXNqUTdvUFhaUjZxN0t3NGtudlJWQmhMQi9PNko5RHFLOGZU?=
 =?utf-8?B?cGhrUFZxRkt5ai90d09jYldLYStJQ1luQ3FTT1hQazc2bi9pYTFFbDlmbzI0?=
 =?utf-8?B?cEk1bUJFOG9tR2FsTk1LOUtlL0ZLWEZCQjJ4elZObmZYcE9rK1BiM2d1NDNY?=
 =?utf-8?B?cTBtcnp6S3Y4RjVGKy9NcUp0ekVuQUN3dlFFYWh3UjFCTU9YbGJoSklpUis3?=
 =?utf-8?B?amFFM1NEUnovYkFEZkp0MWlEK2VqbDg5dVFCbXg1WnljMUY3RmRjb2VjVXBP?=
 =?utf-8?B?OVdhWVdpZDdEdE02ZDN5dFZnZk1Ua1pURm5XL09UNStCaWFobXIrc3JxMERy?=
 =?utf-8?B?RUdlSkE4aTJFY1ZzT01jOTZHUVhQTzk2VzgzbXBBdFNzekI1NThBSWxaTm9y?=
 =?utf-8?B?by9jUlRFYU9Cdkl4b1NVYTZibjIxa2dKdFRkTzJUZ3h6YkZKeG1RNFpHRHRq?=
 =?utf-8?B?TzIzY1QveXdoYW45eDJNdDArcFBGanZqaldHdW9iN3M3U2kraGtDOGtqdjAy?=
 =?utf-8?B?VmIwOU9aUVRrMUdYVHYyeXk5RURoWXhQVkhUWnArcGl5dG80dDF0Z0p1YnVE?=
 =?utf-8?B?UmF4cks3bG1leHhoSHBoSzc1NjNGYUdxYVdkMzdpSlNkRFV1eEFNckR6VzhL?=
 =?utf-8?B?ZXBCTEw3Y3NsNEE5SkNocHFzQzNrd0VWdkllbGRTNHBiVjBaQTVJNzVSdkcy?=
 =?utf-8?B?NVVJK1Y2MDRoMW5NaG1CeEJ0dFlZWm5aMHJIRTNpM0kvb2crVW1aYVduL2x1?=
 =?utf-8?B?Mi9iTFAvYWtaMXY0T1ZSWmh0b2pzT1hOc044Rm15ZjdJWmc1TVRaZkl2YXdr?=
 =?utf-8?B?OGprR1dVUVBRaUNPbVI3K0RWN3BwcUxhTmVXRXFsZjA0Qk9aeGxBRWZTS1Vx?=
 =?utf-8?B?WW94Ukp6Q0dyaUc4cHdrVWZCRW1rUURhQzlMN0VxUHE5eUh1azd3b0twT0JC?=
 =?utf-8?B?MHVVVytYMmt4VXhoR3pkQWF2bkwyeCs4VnZhZUZhdWw5WDlETllVdWREMjk3?=
 =?utf-8?B?WGtqdktkeklxRFZxalpCZGlweUZJYytsSVZjRlJBeGRmUW5oUG16WHFqRkYr?=
 =?utf-8?B?cGVVTzVKZkIrcWlNWm55SWFQa0EwL0FZaHYzbS9DV3R3OVczbTA4dXJWcTd2?=
 =?utf-8?B?V1lUNGlJeEpEVnlNR2N1MHdta1A4dUtIUnZqTU9mUnVvMXN4WHhZNE0venhh?=
 =?utf-8?B?M01jODVkeWRqT1hjalNjaUNSZnMrOUYvdlpTMWRoUUVVcTNHaEpPcGpQT0tG?=
 =?utf-8?B?dm5zMFBLaWpTSzhUaHUzb3FhWXREZ1hpVWRmaGdyZWs3YjluckgxcVBUcnA3?=
 =?utf-8?B?RVFMVGRxYjNKWnJZd2w3NER6R2FWWmZxUjdqRi9JOTRnempEZ21kWGhOaEVh?=
 =?utf-8?B?ZTh0SnpuTys3NEhVbkU3Qmd1YmFyZTJSZ1kxYmNFdkFpc0E3aGZWR3ByOXdJ?=
 =?utf-8?B?MXlINzN0NkUxR29Yb1hVMkVpbE90MXVkTmVKRERBSEN2cjBUNHVBaHRmNFhE?=
 =?utf-8?B?UnViaVpKZFBnNGtvL0x2R0RqOHhVL2dTSTFTMUVESnBXcE81T2NuYzhLWEtO?=
 =?utf-8?B?M2Fqc0prZ2IyVzhibExRUHlIVlk3blZZdUwyMjlDQ1E2NTJ2UXJKOFQzR05Q?=
 =?utf-8?B?YnJWUUx4THlYeElvc2hQa2JPTzlyTllHcmJwTjRNS2taRkdQbG8vNThjdVVw?=
 =?utf-8?B?VTJmaXZoVXhqeDlSNndRWDV0SDdJeFNHZDdSWmFRSjZaMFJNOWs4WVFFT09v?=
 =?utf-8?B?MXcvR1lrQVBwSnNUMlVvemoyeFRZL1NQdEt1SzN6YU9XNGJkTmJLK2tIOUI0?=
 =?utf-8?B?SlFvNkNxZ2FDREtBUTJ0THJLb2RxTkVEOTRuOUJ4RjlkTFJzaHBrcURoMmpR?=
 =?utf-8?B?Nm9sZnhNYTJiYjI2ZExNYlMwUTdvMkZ6VS9EcmtpbTloZm9ZbE95UEZZY3h3?=
 =?utf-8?B?M3pSSGw0WkJEeVFsM3dESCtlRnc3dFNualJZV25uNStZUWl0VkdDNnlNeGZa?=
 =?utf-8?B?UHlya2ZNS1VhQ00xeWUva0hhcmkvZUJaYWRxcU51VVRodE5IT2RGeVdGcWpq?=
 =?utf-8?B?RmJqTmtvUnVHTWpWeGY5TkJjTERLMEplYVBiSVFHZm9xazFva0Q0U3RuMjRv?=
 =?utf-8?B?emdNTnVTTUJMTEJtdS8rVnc3L3FsMGdkMms0K3JSYlFNMktyQTlGSjBKWWlD?=
 =?utf-8?B?azlIaTk1U04yRnc2QjYrclZCb3BxdU1meGJCNi82M0ZabkMzaDBseFpPSFFo?=
 =?utf-8?Q?7SMBY3a4cODc31aMVu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hT+4MKQQHtR3ceoxW5hzCIZqCPhTKaFNKvmPgTUY29RKp3IOWhRUUs46VR/J1KFzf0oBq/57KjWXcMd5jZaMVJoidU9SP8KdVArUiHpBJKOyRtrScfLOeuKinzP4tP0YjBetj3mA3IXw8SyUSzdUh6+D9h2vangMeotSvocTyshGmz1F9eG6zfVxsmf1PUqdkb1O5An1kpTOs1kfC35bF/QLccixRH6Um/i2mndgzlr1M08auvSfEluUlUKVPH3+wbgE6+atTnpgYJdDYSpq4XeBnFgK/dI3+Y9QhBhi0F6anmiEYwTImyb4025Eaznk6ly5ZsvHWBENJXpioK4FfQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7585.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2434afe7-380e-49e0-0d73-08de8bfcce3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 12:31:44.1093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WyEqPl83K+3Nrj3h0JB4LMivkKQWhkfuxYx5dzrhspE10X3oCvTo2fsBQ11Leq4c4Cvy9CtdU4749VEw5uB2Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4613
X-OriginatorOrg: intel.com

DQpIaSBMdWl6LCBQZW5ncGVuZywNCg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0hdIEJsdWV0b290aDog
YnRpbnRlbF9wY2llOiBmaXggVFggcXVldWUgb2ZmLWJ5LW9uZQ0KPg0KPkhpIEBLaXJhbiBLDQo+
DQo+T24gVHVlLCBNYXIgMjQsIDIwMjYgYXQgNDo1MeKAr0FNIFBlbmdwZW5nIEhvdSA8cGVuZ3Bl
bmdAaXNjYXMuYWMuY24+DQo+d3JvdGU6DQo+Pg0KPj4gYnRpbnRlbF9wY2llX3NlbmRfc3luYygp
IHJlYWRzIHRoZSBuZXh0IHRyYW5zbWl0IHNsb3QgZnJvbQ0KPj4gZGF0YS0+aWEudHJfaGlhW10g
YW5kIHVzZXMgaXQgYXMgYW4gaW5kZXggaW50byB0aGUgZml4ZWQgdHhxDQo+PiBkYXRhLT5kZXNj
cmlwdG9yDQo+PiBhcnJheXMuIFRoZSBjdXJyZW50IGd1YXJkIG9ubHkgcmVqZWN0cyB2YWx1ZXMg
c3RyaWN0bHkgZ3JlYXRlciB0aGFuDQo+PiB0eHEtPmNvdW50LCBzbyBhbiBpbmRleCBlcXVhbCB0
byB0aGUgcXVldWUgZGVwdGggc3RpbGwgZmFsbHMgdGhyb3VnaA0KPj4gdHhxLT5hbmQNCj4+IGlz
IHVzZWQgYXMgdGhlIG5leHQgdHJhbnNtaXQgc2xvdCBvbmUgZWxlbWVudCBwYXN0IHRoZSBlbmQu
DQo+Pg0KPj4gUmVqZWN0IGluZGljZXMgYXQgb3IgYWJvdmUgdGhlIHF1ZXVlIGRlcHRoIGJlZm9y
ZSBwcmVwYXJpbmcgdGhlIFRYDQo+PiBkZXNjcmlwdG9yLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6
IFBlbmdwZW5nIEhvdSA8cGVuZ3BlbmdAaXNjYXMuYWMuY24+DQo+PiAtLS0NCj4+ICBkcml2ZXJz
L2JsdWV0b290aC9idGludGVsX3BjaWUuYyB8IDIgKy0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9i
bHVldG9vdGgvYnRpbnRlbF9wY2llLmMNCj4+IGIvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9w
Y2llLmMNCj4+IGluZGV4IDM3Yjc0NGUzNWJjNC4uNzYwY2IzZDFhYTE4IDEwMDY0NA0KPj4gLS0t
IGEvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmMNCj4+ICsrKyBiL2RyaXZlcnMvYmx1
ZXRvb3RoL2J0aW50ZWxfcGNpZS5jDQo+PiBAQCAtMzU5LDcgKzM1OSw3IEBAIHN0YXRpYyBpbnQg
YnRpbnRlbF9wY2llX3NlbmRfc3luYyhzdHJ1Y3QNCj4+IGJ0aW50ZWxfcGNpZV9kYXRhICpkYXRh
LA0KPj4NCj4+ICAgICAgICAgdGZkX2luZGV4ID0gZGF0YS0+aWEudHJfaGlhW0JUSU5URUxfUENJ
RV9UWFFfTlVNXTsNCj4+DQo+PiAtICAgICAgIGlmICh0ZmRfaW5kZXggPiB0eHEtPmNvdW50KQ0K
Pj4gKyAgICAgICBpZiAodGZkX2luZGV4ID49IHR4cS0+Y291bnQpDQoNClVubGVzcyB0aGUgZmly
bXdhcmUgY29ycnVwdHMgRE1BIG1lbW9yeSAob3IgdGhlcmUncyBhIHNlcmlvdXMgZmlybXdhcmUg
YnVnKSwgdGZkX2luZGV4IHNob3VsZCBuZXZlciByZWFjaCBvciBleGNlZWQgdHhxLT5jb3VudC4g
IFdpdGggdGhhdCBpbiBtaW5kLCB0aGUgY2hhbmdlIGxvb2tzIGdvb2QgdG8gbWUuDQoNCj4+ICAg
ICAgICAgICAgICAgICByZXR1cm4gLUVSQU5HRTsNCj4+DQo+PiAgICAgICAgIC8qIEZpcm13YXJl
IHJhaXNlcyBhbGl2ZSBpbnRlcnJ1cHQgb24gSENJX09QX1JFU0VUIG9yDQo+PiAtLQ0KPj4gMi41
MC4xIChBcHBsZSBHaXQtMTU1KQ0KPg0KPkxvb2tzIHZhbGlkIHRvIG1lLCBpbmRleCBzdGFydHMg
ZnJvbSAwIHdoaWxlIGNvdW50IHN0YXJ0IGZyb20gMSwgc28gaW5kZXggPT0gY291bnQNCj53b3Vs
ZCBwcm9iYWJseSBvdmVyZmxvdyBhcyB3ZWxsLg0KPg0KPi0tDQo+THVpeiBBdWd1c3RvIHZvbiBE
ZW50eg0KDQpUaGFua3MsDQpLaXJhbg0KDQoNCg==
