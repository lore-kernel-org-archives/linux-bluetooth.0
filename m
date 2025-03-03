Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170DE256C98
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Mar 2025 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019470; cv=fail; b=m7XuQdDk1GYgpTQGQJ9h8COTgubE1JHR8CW0NuemrHUjMmFonQ+KV4SmW4yfsDr8YZZ4T2LNBOtv24ju+4j+AhqIgwZqNgR397BL6zRt4XiDl2rtZC/DfgSAeT4BCyaol4bdY4ie1+sfFM/C2FuTTCoNyG8aZ4uQMyfS5pYGTII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019470; c=relaxed/simple;
	bh=vy7k+ZASBmsxPznne2uTTBdkJ//LuyteuYNVk2IUDAE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kRtlyqtMuIx49DidEGVMKrIeNWySICbrF/p4MMt8U3ViCea0StzqwuEgmGrtSwz7b1VlQhy0mCr9mDiATpDKKXj59AmsedXtFz10A0cwPm9RpbvvKB9wTC1l1gsNEYSWPEce90pz4Nw/JACVgkTnGZBtmWZS7GxKdKNZEhQpZdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h3jTS7P7; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h3jTS7P7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741019467; x=1772555467;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vy7k+ZASBmsxPznne2uTTBdkJ//LuyteuYNVk2IUDAE=;
  b=h3jTS7P7puEYsDjMhkWxg492M68+WRbov3l21woWVdsgIX2EBxQvAOWX
   hT2EddHiVNhmnL7YGWIa+lzaXPq1rLTTPBSzM4M1oysM4fCyC6CyBj7q0
   F3dnjaAyW2CfyC/20p80dSUH0ke1A+FhKulKu3SL7d1aNf9ljuTi59suW
   frqmUC1r8ChGGp2A9HjUkDrm8b8nlOvJmLH3mwV+JEvMYIL2nj45/lba2
   cTxkfTc1nMsArU8I8AU/Q0PDw1O/1i9wziY2MP5UsFDPm9/ASkz9dNYUL
   fFE9Ctzxhc1Lwwm8Crcscma0r0KJFzLQuz7E0yKcBG/oFTRKyMwE7puxK
   w==;
X-CSE-ConnectionGUID: mDCi1DXgSgS96BRdPSNicw==
X-CSE-MsgGUID: y5hOQPznRaGVHPVfjS+MEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41794786"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="41794786"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 08:31:06 -0800
X-CSE-ConnectionGUID: Yb7fz7VhQoyl9kRrjTmAiQ==
X-CSE-MsgGUID: iIFI/Bh4Re6+85Ehu4kwKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="118092785"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 08:31:07 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 3 Mar 2025 08:31:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 08:31:05 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Mar 2025 08:31:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avVvQ8VTa1T52CL0IEOdCZG1Dn0MZdIM+cvnahORYS6/wWy/8BcJi3t8JOa+otl1mBwrwK5RlA7o9UfpI5iK5L3OzAuopxEPizIFQB3/55Xzk/UJ9clt8ztYYc8OckzTJuUBqzQRcj3YVim71CvBAp6Wh2u3LPh3f3k1eYKM+ZSkfjb0AaJ9AGR5lGcR9T6RLPC2jQq5nJ6DqUEK1LT16FA8wkT3wnEtFnDKX4p5eKb7Ms6GG2WNhqlCPuHfif9pdF2YNKskac9qjT0jXQUFxM4J81dX+S+55dqVbotm1dyFnk28TI86h+QoUN9+g0VJblzblphBUqGedNJR53hyAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVfX91/z+u31jFhnE/B+Wa9TMybumIOOEZjrBGhJ5lA=;
 b=kIIu7DLjT5ShG0paDo0B4jaT4IRmbLz5Oqq5Lis7PHjw53uVAMZQUHydvP1x2dVGoDV5AjAtDitqtOwxvIXwtXvGZXkiHEb9IKoa1XAfmB1htdhxxnp445Sd40Z9yDKR1eAjWMvjQREaoyvcDR89U0th3SZlE6Hd1GHa7ZXs7w1RGY4nMzIDLwu6k0xgGtqahJdwOxbp2njqsjZg+rR616xyRugyoXHjOQUmvUSyY1ZPzv4rmXIPe8ifK9AMK8JNzLaMmYl7YoS9beVdylM6JMVPPJVGfd6hdae2WI1CaWZjVoHth7rmZo7c2fvpSNrzAVNsEDKY6ICKd7Lwz5PpMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by SJ2PR11MB8539.namprd11.prod.outlook.com (2603:10b6:a03:56e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 16:31:00 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%7]) with mapi id 15.20.8489.028; Mon, 3 Mar 2025
 16:31:00 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, "oe-kbuild@lists.linux.dev"
	<oe-kbuild@lists.linux.dev>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
CC: lkp <lkp@intel.com>, "oe-kbuild-all@lists.linux.dev"
	<oe-kbuild-all@lists.linux.dev>, "Srivatsa, Ravishankar"
	<ravishankar.srivatsa@intel.com>, "Tumkur Narayan, Chethan"
	<chethan.tumkur.narayan@intel.com>, "Devegowda, Chandrashekar"
	<chandrashekar.devegowda@intel.com>, "Satija, Vijay" <vijay.satija@intel.com>
Subject: RE: [PATCH v1] Bluetooth: btintel_pcie: Add support for device
 coredump
Thread-Topic: [PATCH v1] Bluetooth: btintel_pcie: Add support for device
 coredump
Thread-Index: AQHbiP/RQLMG6xgGHUe1DpsHQ21cqbNhBI4AgACcUcA=
Date: Mon, 3 Mar 2025 16:31:00 +0000
Message-ID: <PH0PR11MB7585EC686318721DA3DF306DF5C92@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20250227102625.20642-1-kiran.k@intel.com>
 <d61fe144-b47c-4e60-a95e-26522792dd50@stanley.mountain>
In-Reply-To: <d61fe144-b47c-4e60-a95e-26522792dd50@stanley.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|SJ2PR11MB8539:EE_
x-ms-office365-filtering-correlation-id: 10ba6677-da47-4188-d995-08dd5a70c87d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?KitSvwcbgbjfcBp3s2kCD1Ucad+jw3ol+EyI+rva6Lc27OIX9OgsDRZNtPsJ?=
 =?us-ascii?Q?NnsChLUp20/VYssx431/G6v8PA12dH2ppn4mmLXK09LVAmHr5fU7tHyd0ziX?=
 =?us-ascii?Q?Drd9ZbQ6WF+pZ7sJUW8KikWkHxUhuQu25PncBnzw1dE8/gvBhdPfH12GuOv2?=
 =?us-ascii?Q?bLa4SSygjwweFfZTvY2OMoR6jvMqMtdg8GJLOHYgc9AKnf+hvRnQm+Xe5/rq?=
 =?us-ascii?Q?CgOtX4Ki7LyxwY/IBFffIPAewtzTqioleKXKxdj3Oz/hGGvWhOvG4jnFKVix?=
 =?us-ascii?Q?Vu0Dc301Ttk00Pu6fLBC1+8dRCAqikngRFQj1sxQf/Q4PDsXrf8qiMF2uHxH?=
 =?us-ascii?Q?3S3CyyIaleH9Xv8ItGpPFqAA26N7IDJETfWOUOsq17ImOtgvE6/wuNxYH/tf?=
 =?us-ascii?Q?AQ1/CA/T2ExPLIPtjFVJC3oEDF+o6/y/XjIJPzx7Fz3yM8i2sQEZdZ7Y0kcn?=
 =?us-ascii?Q?Glr6hQsi2Mc7G7wo1IF5tBEvDAvBqX0EbGY/yGgUfigmfu0DTHAOyN1YIBxc?=
 =?us-ascii?Q?3EJZe3RMPaQfedk2fvcEKCOxYjuILZqjHouNQfvw/ZDovNTVapMd698YoOtY?=
 =?us-ascii?Q?udRLkDlOyl25ZcV0NAsxnBF38HhYeQaTjJe+vslLhqwUm0fJPyyNxsvHTzvJ?=
 =?us-ascii?Q?eJu7K7U7C0t6XE4eP7W/bRNLIvXavyBS39U5swowVGlzswD46bc5tlLLAUdA?=
 =?us-ascii?Q?ZX5ndgKCpcPyDYIE48TEPyzs7wUEi7/v1gilX690pgGPb99GlX+doyU4VjaX?=
 =?us-ascii?Q?eONOokzADULBr2OUD6Nq+GK/DPoba+7Gk/qYaggH4Qo76erD1mPpGTqwjwtd?=
 =?us-ascii?Q?VoTI6PMsQ1Oy5OF4U+aJ5JaK2Guq8x5zsv7w48dbe3hP53zR2uANV22sagZx?=
 =?us-ascii?Q?VwBC3TnX2W4RsQ81zqn11026GlN4htN7gisj8WszNMtwXheHKQVRmwrk/+Sv?=
 =?us-ascii?Q?xMXol7B3pb8Wv2YDcA8J/bf/amUwt4/W65aRrFzciXChXdFc0XsuJX0BwMMj?=
 =?us-ascii?Q?t9210Okwxj+MsVp7C3xLSUaCnVVP1yrrEcZm8UV0gB3zwBx62OEZtmPAGgrm?=
 =?us-ascii?Q?OfAcuXYaH8dgOAduUe6lWSK8d3PcUF68ChzkuCqw35GRyA26McTfX3Qabq8L?=
 =?us-ascii?Q?wk+C5BYoz3vn/+lQhREPJ368VUffHGPCf/vtHpkDy5FYd2JFt/vHOCOLyu06?=
 =?us-ascii?Q?HBPwTnfWR2ocjaRhObO5ZPI68Uqclq/SsxIYkY0u668iGItip7VX1QSvECJf?=
 =?us-ascii?Q?aMfI3vLumwj9gxL07zpGEyr+GUjPV7b1nDQDD2/iJpjvJn5d9Zp3N0tyHIOM?=
 =?us-ascii?Q?qWDTpkHPNhvkmyERRhwLatwDYFdXTeQzuDzqyQA4OhkfnhYOXlAVf+DQbY1J?=
 =?us-ascii?Q?vgD6E3fE4n7Fl5JUjfuIWURo2QPUxe1QxFfdbszJzp7ejKoe4Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zr3nH1XpZFJRYhRRw+VGVprtANx9bYyc2MAp4KlK7uAspGwLOkh/m6Ca8Y3w?=
 =?us-ascii?Q?/Ni5wGYD8Z1sw2KO6YH7veGGwvNdjTSn7i5EnuK1BDtwUIfIfAXnBAXOa087?=
 =?us-ascii?Q?RgNUaC2jmJe8GkDK3KS2KlYrHh6wB2vQS2YOmmYSiE1yVuQcCfxvIXPL+TR0?=
 =?us-ascii?Q?Pjbq+JKoM7bAeVKr7/+O0C07KSAIZfO3+oN+3sEuGzYHjY5M/WemHa0Dz7Rr?=
 =?us-ascii?Q?ibasIh6Y++NY+IaHa1SWLS41SInE49RVf7xmne8okyfbSVnhTg/nM5xnSqq8?=
 =?us-ascii?Q?QqPSOSVn+dvqHs0nW8d0aKABfyGCoipuVL3m2jshh4Wciuc5AA49xa5GJ0bb?=
 =?us-ascii?Q?6OSsU74HVs97Vv42Of3WPcHc5I8vMBpuwIDwpHq70rJXFqDdMl9qBACJJ1i7?=
 =?us-ascii?Q?u29b4ntGsEAqsuh9A2eKhYAfux/e5RGXog729oyVgM/Z6CdGxsjAZiS3CKXP?=
 =?us-ascii?Q?PSKZMJ1psgdnRNg+NbUSqPVAahZn0IUQ93IzFqMW9YRaKCYMHpPOl7b/usbd?=
 =?us-ascii?Q?0GyQn8S/s4rtCkHhmxfebKXsVQ8lOrrLdsWssM77bPe3ESRaZ80+bs2aeXf6?=
 =?us-ascii?Q?njTaz9YAyW4YQ9hsnIETHJ3mj2lMJTJaCNB1sJMMh96Ljz/R0wIvR0kfwicW?=
 =?us-ascii?Q?C3N8Jc3NINsQyeRy7d6k26kupIy32txm6MoXArf8xKoTaHPa83JJwtjotITt?=
 =?us-ascii?Q?GPasGdWhz/gNm3iwnW2FwyjIzofxolVOmHARQtQwU62BeJBd16iooNi050le?=
 =?us-ascii?Q?YeWK+pJHJ/21PcUYxsp6qSUk9UREGWQRiNHRjPjjQBuRAXU3odyZIOUBNSUi?=
 =?us-ascii?Q?/OXUf4n8iMWZmTaW5Tg8jpKR7TVCQMR0N2LUofI779VCvQMTA8ZSk4IdMZyc?=
 =?us-ascii?Q?e/k0yhqrPDKvvVkQxbeGyaELQuO+B7RwIuFpBZo+8M5n6r+IIzkDUVlL/4Mz?=
 =?us-ascii?Q?zwKI8NsWnSSv98n2GaNOAWZxQJ7CDFFirH0OxO5LVc0FjAOIlNSngHgg9C28?=
 =?us-ascii?Q?QUGv+LVSyKF6v3LtglF+CBQWTAm0A7zyfTnjRYbikjFxf4o9zwVShrFcTQZa?=
 =?us-ascii?Q?S6WcuZ3+VET3xoxLIfPN2eU92embBg5XEvJG/fc80coT1c4RM/+rEdIHqeqI?=
 =?us-ascii?Q?DvEyaFAaxvIUqD53YZRuBkDYN9Z7lPMv56Ppxx03gaXoEgu+gkTn5qI4Zzi/?=
 =?us-ascii?Q?H0b+1sUP946Xn3QsGIA0iio47D8qRYES1m+JpuAOWYEfzGyBtb9rwbpbMLEj?=
 =?us-ascii?Q?5ju6usdYXfghMyIk+xLCXMpulahdibeAReQp17CryP7Zg/izV79jY2j7YwG0?=
 =?us-ascii?Q?EVRoVVW8OBciaezBkz/2CnCglhmRl78tDKr2hGdo2aczM8hDTqusemfq3Vm5?=
 =?us-ascii?Q?EbJbj/1e04IkbIW6jLPOuhsSr4IK/v4qVn8L+3SiUJvwDYcqa8p50ySAE3FJ?=
 =?us-ascii?Q?ikEnCmfdYfSiNhbXD2mj9djptGAtMDVV1lh7mhDCTiZS2d5S7t4ApdtlJ2+z?=
 =?us-ascii?Q?e3piw+i/WhUakF5eUZt8JYe3B4C7cc57LeYb7FO0RuF9Eh26Gq6s/J+X7L8U?=
 =?us-ascii?Q?gskq9SCUD7bj8hsfHyM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7585.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ba6677-da47-4188-d995-08dd5a70c87d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 16:31:00.2744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W66vvc0VSCVN/xlgVkV/sX9zELyLgTioEGW80lpdCW7Dr4JbWPEL2YThUid5DxA4Tm0A4YUebuHguJYPqHmU3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8539
X-OriginatorOrg: intel.com

Hi Dan,

Thanks for your comment.

>Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Add support for device
>coredump
>
>Hi Kiran,
>
>kernel test robot noticed the following build warnings:
>
>https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
>url:    https://github.com/intel-lab-lkp/linux/commits/Kiran-K/Bluetooth-
>btintel_pcie-Add-support-for-device-coredump/20250227-181131
>base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetoot=
h-
>next.git master
>patch link:    https://lore.kernel.org/r/20250227102625.20642-1-
>kiran.k%40intel.com
>patch subject: [PATCH v1] Bluetooth: btintel_pcie: Add support for device
>coredump
>config: sparc-randconfig-r071-20250302 (https://download.01.org/0day-
>ci/archive/20250302/202503022332.biRVCDMP-lkp@intel.com/config)
>compiler: sparc-linux-gcc (GCC) 14.2.0
>
>If you fix the issue in a separate patch/commit (i.e. not just a new versi=
on of
>the same patch/commit), kindly add following tags
>| Reported-by: kernel test robot <lkp@intel.com>
>| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>| Closes: https://lore.kernel.org/r/202503022332.biRVCDMP-lkp@intel.com/
>
>New smatch warnings:
>drivers/bluetooth/btintel_pcie.c:493 btintel_pcie_read_dram_buffers() erro=
r:
>snprintf() is printing too much 100 vs 70

Ack. I have fixed this issue in v2 version of the patch.

>
>vim +493 drivers/bluetooth/btintel_pcie.c
>
>b8cc1a1cce30cc Kiran K 2025-02-27  454  static int
>btintel_pcie_read_dram_buffers(struct btintel_pcie_data *data)
>b8cc1a1cce30cc Kiran K 2025-02-27  455  {
>b8cc1a1cce30cc Kiran K 2025-02-27  456  	u32 offset, prev_size,
>wr_ptr_status, dump_size, i;
>b8cc1a1cce30cc Kiran K 2025-02-27  457  	struct btintel_pcie_dbgc *dbgc
>=3D &data->dbgc;
>b8cc1a1cce30cc Kiran K 2025-02-27  458  	u8 buf_idx, dump_time_len,
>fw_build;
>b8cc1a1cce30cc Kiran K 2025-02-27  459  	struct hci_dev *hdev =3D data-
>>hdev;
>b8cc1a1cce30cc Kiran K 2025-02-27  460  	struct intel_tlv *tlv;
>b8cc1a1cce30cc Kiran K 2025-02-27  461  	struct timespec64 now;
>b8cc1a1cce30cc Kiran K 2025-02-27  462  	struct sk_buff *skb;
>b8cc1a1cce30cc Kiran K 2025-02-27  463  	struct tm tm_now;
>b8cc1a1cce30cc Kiran K 2025-02-27  464  	char buf[100];
>b8cc1a1cce30cc Kiran K 2025-02-27  465  	u16 hdr_len;
>b8cc1a1cce30cc Kiran K 2025-02-27  466  	int ret;
>b8cc1a1cce30cc Kiran K 2025-02-27  467
>b8cc1a1cce30cc Kiran K 2025-02-27  468  	wr_ptr_status =3D
>btintel_pcie_rd_dev_mem(data,
>BTINTEL_PCIE_DBGC_CUR_DBGBUFF_STATUS);
>b8cc1a1cce30cc Kiran K 2025-02-27  469  	offset =3D wr_ptr_status &
>BTINTEL_PCIE_DBG_OFFSET_BIT_MASK;
>b8cc1a1cce30cc Kiran K 2025-02-27  470
>b8cc1a1cce30cc Kiran K 2025-02-27  471  	buf_idx =3D
>BTINTEL_PCIE_DBGC_DBG_BUF_IDX(wr_ptr_status);
>b8cc1a1cce30cc Kiran K 2025-02-27  472  	if (buf_idx > dbgc->count) {
>b8cc1a1cce30cc Kiran K 2025-02-27  473  		bt_dev_warn(hdev,
>"Buffer index is invalid");
>b8cc1a1cce30cc Kiran K 2025-02-27  474  		return -EINVAL;
>b8cc1a1cce30cc Kiran K 2025-02-27  475  	}
>b8cc1a1cce30cc Kiran K 2025-02-27  476
>b8cc1a1cce30cc Kiran K 2025-02-27  477  	prev_size =3D buf_idx *
>BTINTEL_PCIE_DBGC_BUFFER_SIZE;
>b8cc1a1cce30cc Kiran K 2025-02-27  478  	if (prev_size + offset >=3D
>prev_size)
>b8cc1a1cce30cc Kiran K 2025-02-27  479  		data-
>>dmp_hdr.write_ptr =3D prev_size + offset;
>b8cc1a1cce30cc Kiran K 2025-02-27  480  	else
>b8cc1a1cce30cc Kiran K 2025-02-27  481  		return -EINVAL;
>b8cc1a1cce30cc Kiran K 2025-02-27  482
>b8cc1a1cce30cc Kiran K 2025-02-27  483  	ktime_get_real_ts64(&now);
>b8cc1a1cce30cc Kiran K 2025-02-27  484  	time64_to_tm(now.tv_sec, 0,
>&tm_now);
>b8cc1a1cce30cc Kiran K 2025-02-27  485  	dump_time_len =3D snprintf(buf,
>sizeof(buf), "Dump Time: %02d-%02d-%04ld %02d:%02d:%02d",
>b8cc1a1cce30cc Kiran K 2025-02-27  486
>tm_now.tm_mday, tm_now.tm_mon + 1, tm_now.tm_year + 1900,
>b8cc1a1cce30cc Kiran K 2025-02-27  487
>tm_now.tm_hour, tm_now.tm_min, tm_now.tm_sec);
>b8cc1a1cce30cc Kiran K 2025-02-27  488
>b8cc1a1cce30cc Kiran K 2025-02-27  489  	fw_build =3D snprintf(buf +
>dump_time_len, sizeof(buf),
>                                                                          =
               ^^^^^^^^^^^
>
>This size should be "sizeof(buf) - dump_time_len".  It's better to use scn=
printf()
>here vs snprintf().  The scnprintf() function returns the number of bytes =
which
>were actually printed vs the number which were printed if there was enough
>space.
>
>b8cc1a1cce30cc Kiran K 2025-02-27  490  			    "Firmware
>Timestamp: Year %u WW %02u buildtype %u build %u",
>b8cc1a1cce30cc Kiran K 2025-02-27  491  			    2000 + (data-
>>dmp_hdr.fw_timestamp >> 8),
>b8cc1a1cce30cc Kiran K 2025-02-27  492  			    data-
>>dmp_hdr.fw_timestamp & 0xff, data->dmp_hdr.fw_build_type,
>b8cc1a1cce30cc Kiran K 2025-02-27 @493  			    data-
>>dmp_hdr.fw_build_num);
>b8cc1a1cce30cc Kiran K 2025-02-27  494
>b8cc1a1cce30cc Kiran K 2025-02-27  495  	hdr_len =3D sizeof(*tlv) +
>sizeof(data->dmp_hdr.cnvi_bt) +
>b8cc1a1cce30cc Kiran K 2025-02-27  496  		  sizeof(*tlv) +
>sizeof(data->dmp_hdr.write_ptr) +
>b8cc1a1cce30cc Kiran K 2025-02-27  497  		  sizeof(*tlv) +
>sizeof(data->dmp_hdr.wrap_ctr) +
>b8cc1a1cce30cc Kiran K 2025-02-27  498  		  sizeof(*tlv) +
>sizeof(data->dmp_hdr.trigger_reason) +
>b8cc1a1cce30cc Kiran K 2025-02-27  499  		  sizeof(*tlv) +
>sizeof(data->dmp_hdr.fw_git_sha1) +
>b8cc1a1cce30cc Kiran K 2025-02-27  500  		  sizeof(*tlv) +
>sizeof(data->dmp_hdr.cnvr_top) +
>b8cc1a1cce30cc Kiran K 2025-02-27  501  		  sizeof(*tlv) +
>sizeof(data->dmp_hdr.cnvi_top) +
>b8cc1a1cce30cc Kiran K 2025-02-27  502  		  sizeof(*tlv) +
>dump_time_len +
>b8cc1a1cce30cc Kiran K 2025-02-27  503  		  sizeof(*tlv) +
>fw_build;
>b8cc1a1cce30cc Kiran K 2025-02-27  504
>b8cc1a1cce30cc Kiran K 2025-02-27  505  	dump_size =3D hdr_len +
>sizeof(hdr_len);
>b8cc1a1cce30cc Kiran K 2025-02-27  506
>b8cc1a1cce30cc Kiran K 2025-02-27  507  	skb =3D alloc_skb(dump_size,
>GFP_KERNEL);
>b8cc1a1cce30cc Kiran K 2025-02-27  508  	if (!skb)
>b8cc1a1cce30cc Kiran K 2025-02-27  509  		return -ENOMEM;
>b8cc1a1cce30cc Kiran K 2025-02-27  510
>b8cc1a1cce30cc Kiran K 2025-02-27  511  	/* Add debug buffers data
>length to dump size */
>b8cc1a1cce30cc Kiran K 2025-02-27  512  	dump_size +=3D
>BTINTEL_PCIE_DBGC_BUFFER_SIZE * dbgc->count;
>b8cc1a1cce30cc Kiran K 2025-02-27  513
>b8cc1a1cce30cc Kiran K 2025-02-27  514  	ret =3D hci_devcd_init(hdev,
>dump_size);
>b8cc1a1cce30cc Kiran K 2025-02-27  515  	if (ret) {
>b8cc1a1cce30cc Kiran K 2025-02-27  516  		bt_dev_err(hdev,
>"Failed to init devcoredump, err %d", ret);
>b8cc1a1cce30cc Kiran K 2025-02-27  517  		kfree_skb(skb);
>b8cc1a1cce30cc Kiran K 2025-02-27  518  		return ret;
>b8cc1a1cce30cc Kiran K 2025-02-27  519  	}
>b8cc1a1cce30cc Kiran K 2025-02-27  520
>b8cc1a1cce30cc Kiran K 2025-02-27  521  	skb_put_data(skb, &hdr_len,
>sizeof(hdr_len));
>b8cc1a1cce30cc Kiran K 2025-02-27  522
>b8cc1a1cce30cc Kiran K 2025-02-27  523  	btintel_pcie_copy_tlv(skb,
>BTINTEL_CNVI_BT, &data->dmp_hdr.cnvi_bt,
>b8cc1a1cce30cc Kiran K 2025-02-27  524  			      sizeof(data-
>>dmp_hdr.cnvi_bt));
>b8cc1a1cce30cc Kiran K 2025-02-27  525
>b8cc1a1cce30cc Kiran K 2025-02-27  526  	btintel_pcie_copy_tlv(skb,
>BTINTEL_WRITE_PTR, &data->dmp_hdr.write_ptr,
>b8cc1a1cce30cc Kiran K 2025-02-27  527  			      sizeof(data-
>>dmp_hdr.write_ptr));
>b8cc1a1cce30cc Kiran K 2025-02-27  528
>b8cc1a1cce30cc Kiran K 2025-02-27  529  	data->dmp_hdr.wrap_ctr =3D
>btintel_pcie_rd_dev_mem(data,
>b8cc1a1cce30cc Kiran K 2025-02-27  530
>			 BTINTEL_PCIE_DBGC_DBGBUFF_WRAP_ARND);
>b8cc1a1cce30cc Kiran K 2025-02-27  531
>b8cc1a1cce30cc Kiran K 2025-02-27  532  	btintel_pcie_copy_tlv(skb,
>BTINTEL_WRAP_CTR, &data->dmp_hdr.wrap_ctr,
>b8cc1a1cce30cc Kiran K 2025-02-27  533  			      sizeof(data-
>>dmp_hdr.wrap_ctr));
>b8cc1a1cce30cc Kiran K 2025-02-27  534
>b8cc1a1cce30cc Kiran K 2025-02-27  535  	btintel_pcie_copy_tlv(skb,
>BTINTEL_TRIGGER_REASON, &data->dmp_hdr.trigger_reason,
>b8cc1a1cce30cc Kiran K 2025-02-27  536  			      sizeof(data-
>>dmp_hdr.trigger_reason));
>b8cc1a1cce30cc Kiran K 2025-02-27  537
>b8cc1a1cce30cc Kiran K 2025-02-27  538  	btintel_pcie_copy_tlv(skb,
>BTINTEL_FW_SHA, &data->dmp_hdr.fw_git_sha1,
>b8cc1a1cce30cc Kiran K 2025-02-27  539  			      sizeof(data-
>>dmp_hdr.fw_git_sha1));
>b8cc1a1cce30cc Kiran K 2025-02-27  540
>b8cc1a1cce30cc Kiran K 2025-02-27  541  	btintel_pcie_copy_tlv(skb,
>BTINTEL_CNVR_TOP, &data->dmp_hdr.cnvr_top,
>b8cc1a1cce30cc Kiran K 2025-02-27  542  			      sizeof(data-
>>dmp_hdr.cnvr_top));
>b8cc1a1cce30cc Kiran K 2025-02-27  543
>b8cc1a1cce30cc Kiran K 2025-02-27  544  	btintel_pcie_copy_tlv(skb,
>BTINTEL_CNVI_TOP, &data->dmp_hdr.cnvi_top,
>b8cc1a1cce30cc Kiran K 2025-02-27  545  			      sizeof(data-
>>dmp_hdr.cnvi_top));
>b8cc1a1cce30cc Kiran K 2025-02-27  546
>b8cc1a1cce30cc Kiran K 2025-02-27  547  	btintel_pcie_copy_tlv(skb,
>BTINTEL_DUMP_TIME, buf, dump_time_len);
>b8cc1a1cce30cc Kiran K 2025-02-27  548
>b8cc1a1cce30cc Kiran K 2025-02-27  549  	btintel_pcie_copy_tlv(skb,
>BTINTEL_FW_BUILD, buf + dump_time_len, fw_build);
>b8cc1a1cce30cc Kiran K 2025-02-27  550
>b8cc1a1cce30cc Kiran K 2025-02-27  551  	ret =3D hci_devcd_append(hdev,
>skb);
>b8cc1a1cce30cc Kiran K 2025-02-27  552  	if (ret)
>b8cc1a1cce30cc Kiran K 2025-02-27  553  		goto exit_err;
>b8cc1a1cce30cc Kiran K 2025-02-27  554
>b8cc1a1cce30cc Kiran K 2025-02-27  555  	for (i =3D 0; i < dbgc->count; i+=
+) {
>b8cc1a1cce30cc Kiran K 2025-02-27  556  		ret =3D
>btintel_pcie_add_dmp_data(hdev, dbgc->bufs[i].data,
>b8cc1a1cce30cc Kiran K 2025-02-27  557
>		BTINTEL_PCIE_DBGC_BUFFER_SIZE);
>b8cc1a1cce30cc Kiran K 2025-02-27  558  		if (ret)
>b8cc1a1cce30cc Kiran K 2025-02-27  559  			break;
>b8cc1a1cce30cc Kiran K 2025-02-27  560  	}
>b8cc1a1cce30cc Kiran K 2025-02-27  561 b8cc1a1cce30cc Kiran K 2025-02-27
>562  exit_err:
>b8cc1a1cce30cc Kiran K 2025-02-27  563  	hci_devcd_complete(hdev);
>b8cc1a1cce30cc Kiran K 2025-02-27  564  	return ret;
>b8cc1a1cce30cc Kiran K 2025-02-27  565  }
>
>--
>0-DAY CI Kernel Test Service
>https://github.com/intel/lkp-tests/wiki
>

Thanks,
Kiran


