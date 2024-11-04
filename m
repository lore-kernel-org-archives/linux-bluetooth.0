Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BAB10F1
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Nov 2024 05:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730697090; cv=fail; b=Gq0O4TxDi11DbV2CruaJUAA7EJKWv2GLmsRJ1wOoFtTK8mWBQLMAtHUqgRN5Cd6y1iKYVDHnxs/9dt2GnQbF42KhB5/hsAB8EkExtRpUInFObVT+mx7v67hCpBDmhNg9GPANpZ/tMsuY6NPefO5asdCdMs+l07Yu1juJu5+EhJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730697090; c=relaxed/simple;
	bh=o2WIirvqlJ/JDrP4D5aqulxBd/1P96UVrMSVasmVuME=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pxEvzTeGFm3xUymJxB/v++6leFh1/c9fxAe+nInxbo/XNCWLLRKtZAsZEXXS6MPVeBeAIe83QCHzXc9v778v5aBnIt97nFN2H36oqT5eVdIcqmDGz2Um0TwD+heDcXbamtS9sXkI6Xo6mbL5HKMVnrIENpjrqHWfXRLEGV4Iwew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RYsfhOJb; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RYsfhOJb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730697088; x=1762233088;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o2WIirvqlJ/JDrP4D5aqulxBd/1P96UVrMSVasmVuME=;
  b=RYsfhOJbGn0jNRofCRV3AYF68Nx6KReMGQ152KG1creJN7bmx6bREYjW
   nOJoZD1zls/J0fdXV5HxztBbnVjnK38Mr06rAgm40J65k0BtjY30LEAbx
   Xoyw48b1qTQyghKn20ikEpf2SfoTNjNKtSW/ymb4/etjTrgdu73LalFxO
   KaZLh7xp3gOo+uU3+sQ3Buwdld/U88SBBHpvedx9obpcyFQvgCivKUo5E
   bc5pi6RWw6ncOF5niUMSrWyxL4C0Nk8aY4hPpxzSSlJwqkG6W7gFT0Uym
   xC4B/EYmTJu4IE0bxHxFV5TMqbwhiBN+mihhMyXIQmQtDfAndKKs8/dar
   w==;
X-CSE-ConnectionGUID: rAzTREXHShGtoq7ypFDbdQ==
X-CSE-MsgGUID: 6RbuM6VLRTySmtDzEMYayA==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="30483708"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="30483708"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 21:11:28 -0800
X-CSE-ConnectionGUID: wG//cBMYT06wIosFQmj3AQ==
X-CSE-MsgGUID: fw782IyCQZaTUYDr3ewevA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="88056461"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Nov 2024 21:11:29 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 3 Nov 2024 21:11:27 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 3 Nov 2024 21:11:27 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 3 Nov 2024 21:11:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RecRuQMB5nlm/KCgGKXNeSXFpVVAAr7v6YjEBMLx+XvemA42JpkRUEvHG8Kc9qb1/lDgmK2exHGy3hh7qQl7wYBNPOsfslk9uKb7B7wswl6RoA2fjz0azsPuxV3j+mvaVorVTksG7X2TEHAmIH2C1SeT0SdsanqwrXBO8cSFhHVtGdbwNe70pIJJXPioXnUOHzAp/Ginz5+RulwAZWGrOahOnU20MPnOb0k/bNnIc8xXdWQsQlmxl42MqOGxaM4N9n2Dq0jAIQU676vYoZFoWyGJkDOxfI/ww8HRKOShMTIjymzPfh1o9BDGUnVUB8zyiytdEpkPcLYJVr0OG9CQqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62ZqXlYoWy4y5OepOaH+LUVjc9U/nHRPbWwkomW10ic=;
 b=aJPbonLeZu0ewSmNp2/Acrrs1e/7tnpG2Z32K6taXosWPsTioNQ0mr/qPiSLZEFaq3dITv/d4pCuLwynFZofd9wAZN/xLCIapVmj+2VVHwvK9H/cq7s3aAc3AYg9h7gjG9ECJraBkmf7Oc38QdSFbudTYg1RyyLQCw8xQljURflKhrTconRCOEaAw5+N3CP/COYuApJdBxOOIhRpi9KyCd/J3J9Hw+5Tl2GLemt1GY1UYdUEIUiM6AK5NHTpYAF1ruVguvRaUGAc4IHHJy9l6gYNSqlr7DdgcIpOg0ziWqOCOR+DEqdhU1S8kEntbyAZAiEYhkze5yGlCz+m108dXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by SJ0PR11MB5135.namprd11.prod.outlook.com (2603:10b6:a03:2db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 05:11:25 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%3]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 05:11:25 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, "Devegowda, Chandrashekar"
	<chandrashekar.devegowda@intel.com>, "Satija, Vijay" <vijay.satija@intel.com>
Subject: RE: [PATCH v2] Bluetooth: btintel: Direct exception event to
 bluetooth stack
Thread-Topic: [PATCH v2] Bluetooth: btintel: Direct exception event to
 bluetooth stack
Thread-Index: AQHbJGBe3orr0REAe0m6kiraomaF0rKmpx+w
Date: Mon, 4 Nov 2024 05:11:25 +0000
Message-ID: <PH0PR11MB758591BFD4AB76C224E1C88DF5512@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20241022091134.791527-1-kiran.k@intel.com>
In-Reply-To: <20241022091134.791527-1-kiran.k@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|SJ0PR11MB5135:EE_
x-ms-office365-filtering-correlation-id: b72074b4-1971-4e7e-f8e8-08dcfc8f2169
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?x945Uoho4EfmhJk+AB1Rd3jVq2PsALpw6h9UXg0IXo+g5DGhmAyQs1289QXq?=
 =?us-ascii?Q?C0Hmo3Hi6sIv+kM/P1I04tLU/UBOFdDz3QlgkIpc0Cr62I1hfW5MEMCfjT7+?=
 =?us-ascii?Q?BLyYud+H7T67b3ioPD8Ljm4aHEOrNtBpKdLrxvBhQ8N/4fIusw6Xk7cQAlEr?=
 =?us-ascii?Q?/yFxkqFm9CwMTqZCG3TguhwpmvFnJD1igbveeCV8pD3+RzQF2yswQfryF9dP?=
 =?us-ascii?Q?kuAPaNOxlxCLhYXfcI/ivGn1ZOqJ0F91PQeBh83T4c6RACTlgY56sqO4uIgE?=
 =?us-ascii?Q?4jKmk2QFuLitDHdDon400Ox48pMxYflpZ0u6bg11iAZx2sed3gdu+cwfX9/t?=
 =?us-ascii?Q?7A/cTiNJQ+3Dwq1vAYrQgNLO09ZQgC5Hws5rZr9rA+WTVLF/mo5mbDrbAid7?=
 =?us-ascii?Q?VGKT/TvOk2ZH0z1B30hbRXoJ4GtYKWaXviLkng0zb73ghLyYqFDBASSG6gy8?=
 =?us-ascii?Q?fDasIjqYWX7S0OwLVPVFNldqj56FI3v3Z0zlp/OAVGPwubxiNpgL0dI2ixNj?=
 =?us-ascii?Q?IFvBDjTb9f7b8yp+H5BdEml3/v4w2Zhv7X1qs3CvVJYzOosvlFoi1k4x5uSC?=
 =?us-ascii?Q?HuOrLQfV5jF+NNIExPhW1snixjfdQrqK4MT3n7Fode/9Q+nHjhbVJV0qTpe9?=
 =?us-ascii?Q?6W/cerkyzrxl3PZEediTO4CesIE9fsac5fL6gtZoRwMG2/Y+IkfjiY5Rk4Vo?=
 =?us-ascii?Q?5ANMlbOoEskCwTKrTR9DSVMvLCX+6yk/0gAmxaD8pz87C2eKGBu0XVsOLTzX?=
 =?us-ascii?Q?J4zunQZuJqRhYtXkIg9eViJrbWTZhNzohxp/YD4TNFzptGap5frRoECbEUvR?=
 =?us-ascii?Q?q4rZPP8PYk9097xJJxeYp/gHWG//5VZDZgt4QskwBkKnnOdZUFSSduc9r+td?=
 =?us-ascii?Q?TB8KGiVok9ABBwtKsO82OzR6FdiTdu//R49EH3aeP8Ec49fTxafyPetNLaqJ?=
 =?us-ascii?Q?nzZfZGRfc9Es23/FJeNvqktzFHStMR7D+7WDpO4kdTvWllWXpMVBABVa7tyu?=
 =?us-ascii?Q?9Pt0BHEu6tMjmc5dwKHzrpM5mKwB8ACk5MXIuCbkeAb+ScAmZHUv5XVhmfxq?=
 =?us-ascii?Q?sD46hCOZgGS8H9UIHPDZfP5uU1FYYx4iH1XQ6ZDcZKzn1CyI5jl1uoWyupew?=
 =?us-ascii?Q?aWrAtj/pDlh5DhC+cOj7LoVhpmKR3niJ5eCQ+3JTWpjd4Ad3dl4BC8OHyw30?=
 =?us-ascii?Q?aYU7Lid2saJ9nlh8aFpl560IIe+6tqlUMtsb3hREPs2lHvtHdR1fNj5ZnJpE?=
 =?us-ascii?Q?vazYMSUk4ay8WPRfk7QbigKIiYIN6gZjjbiMrI9n78TYzBzOneoZmLX0P4Os?=
 =?us-ascii?Q?JqZeHM18Eq/b0QzueFVXeUVlZhYNy5J9FpJLX4qbtV7z1rs2HPOrr9TxczVP?=
 =?us-ascii?Q?rRNfe/Y=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HBiPMIo5iLDyTDOIZn3P4t0BAbWqSxaUF7sp0Wzn1zvuLy63JKIl8v6i6YF3?=
 =?us-ascii?Q?krMgL16Y+wwx/uJVO285+maAQreQPNshrAKh2J2WoaB/DoRlWTswoxJyOcju?=
 =?us-ascii?Q?0uBl+xKqgBInOYlz/84m30DcRxg8si39/VmPiYBtHOgOFlGUw6j263A8LG34?=
 =?us-ascii?Q?7rWPyzEYTQlvLEGi2H9i7ffzgGq2oeiwi5GjtMaaybe4n1B6XMcJzNGb/XyE?=
 =?us-ascii?Q?+prgeVTFkPwlaOGk0q2I5jFff4xiSMX01ledQrJxEBnxbpcXMS1ShQMIINDR?=
 =?us-ascii?Q?1HpBk5PIeks0n8NndgzUKYWmLu9SK25t2hroZmyL3V6gNddA/voCUeJPM7yT?=
 =?us-ascii?Q?1g7aLOahiyuMZ9IS7dahVTf0oIzYH4tiVHC57j4HyMXi958Apmt5bFvQrqYP?=
 =?us-ascii?Q?O00l8pILAaKfwRfse71Zy8f2KaqK9JfFhQ2Uuf1HQtB4P6rDqcw9CCKD9u1y?=
 =?us-ascii?Q?jH9LUeFwNl6jllh5uOTfXfU0VyKdO1TgeAZQGjs1YydbSJ90G8E+T4nksu1w?=
 =?us-ascii?Q?JPpW0SUi20XZ58cqv6f8zZ2hrdPtSLtdweLQ9FRJayAmkfqYVoXWd5xifrE1?=
 =?us-ascii?Q?2q6yvCBPcWQ27T3Vx89csc8Il/OwqPRE/9ue60EKvG2lmXjrhY4ISArUr2OH?=
 =?us-ascii?Q?sAg1SgYSTTi8FDXVr4WfjZJlEuKhvwb2uSMpmWiJW+CezQ/03zGgkHSt/5mN?=
 =?us-ascii?Q?f2zm8DJshO2+PwZ8jq5K+W6r2YVSU089mVAzrc4UXgutQ8ddxlfz73qzfyi3?=
 =?us-ascii?Q?9RcsHh7eLwXTcJOWLsvlmQkJWNUL567R4cuSp2OKtKxTqkOXYUGyAc2F7hGX?=
 =?us-ascii?Q?QPIYIjd+JsBkQjoSOeyHc2uLBlf8OIfgGXwQqnd0q0KLcY+RlAWup3U2vAG1?=
 =?us-ascii?Q?mMj0kXWNCy12M734p3zUG9btnLAZ2ph4/0+p08AlDUGbpNOFuN+7hjkZxe6h?=
 =?us-ascii?Q?3dSmCjGjDhcojDoZ4A1ZayO8q/MbT73VWz3mopgjnurFBh7tMcpeUkpds2X1?=
 =?us-ascii?Q?0jx35syF5qbwQhydKMmHfdZXVnL3jzu0Q45eqNqwDn9N4kXNOabA/51U4sgR?=
 =?us-ascii?Q?9gmjR9dDneDk+PQ2No0HVqOrtCcxorP10UtximSWiO2/amrubAvvDpuqOLzn?=
 =?us-ascii?Q?OL0onsj5n0EdXWRycHhz2nVcLWVRd5vD+/MTSdNdLBSw9Q7Qw3PFrSOANRmO?=
 =?us-ascii?Q?OG0UtdjroHSQZhblDxrPwXeQ7KZXHo2EZObTGTR3jN5V4jqIcGi2O9jngFP3?=
 =?us-ascii?Q?rvKzrVI+te9xGSdRTJiMqJY/pz1VYqv7uZjSQU8xtgTD8hPWfvp7hyokhySO?=
 =?us-ascii?Q?RZpmFQZeURo0mbbJDR7Nhvl5p4xpammn3eRMUOWr3Wra9SRpS7YC7N9aiR/G?=
 =?us-ascii?Q?ofKegV4S9zEUoi46ay4dNlvZe7Lm9TlA//hxfK4clCMviuegLXloaTSDQPjf?=
 =?us-ascii?Q?sTh37L8gWHvkG8bElwGcnpxo7wZMvxtAi0fEYatuhjeCdvNQiRk0+Bqmaogf?=
 =?us-ascii?Q?JQcHrENfiAxqBCkEzhDpHv+RirLCAS8M6ZMrRpAowoSJrXVZ1P7LbL1MjVds?=
 =?us-ascii?Q?veX5OI5ygKCrKXJykZU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b72074b4-1971-4e7e-f8e8-08dcfc8f2169
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 05:11:25.0603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V9+71NSxxCNzXAN2DJRURS3QFUD7+rcfnfKsx9fCNzyTU632Ard4xMdWcbg/M0n00NUPp5aoOSRatp53o13Viw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5135
X-OriginatorOrg: intel.com

Hi Luiz,

Friendly reminder.

>-----Original Message-----
>From: K, Kiran <kiran.k@intel.com>
>Sent: Tuesday, October 22, 2024 2:42 PM
>To: linux-bluetooth@vger.kernel.org
>Cc: Srivatsa, Ravishankar <ravishankar.srivatsa@intel.com>; Tumkur Narayan=
,
>Chethan <chethan.tumkur.narayan@intel.com>; Devegowda, Chandrashekar
><chandrashekar.devegowda@intel.com>; Satija, Vijay <vijay.satija@intel.com=
>;
>K, Kiran <kiran.k@intel.com>
>Subject: [PATCH v2] Bluetooth: btintel: Direct exception event to bluetoot=
h
>stack
>
>Have exception event part of HCI traces which helps for debug.
>
>snoop traces:
>> HCI Event: Vendor (0xff) plen 79
>        Vendor Prefix (0x8780)
>      Intel Extended Telemetry (0x03)
>        Unknown extended telemetry event type (0xde)
>        01 01 de
>        Unknown extended subevent 0x07
>        01 01 de 07 01 de 06 1c ef be ad de ef be ad de
>        ef be ad de ef be ad de ef be ad de ef be ad de
>        ef be ad de 05 14 ef be ad de ef be ad de ef be
>        ad de ef be ad de ef be ad de 43 10 ef be ad de
>        ef be ad de ef be ad de ef be ad de
>
>Fixes: af395330abed ("Bluetooth: btintel: Add Intel devcoredump support")
>Signed-off-by: Kiran K <kiran.k@intel.com>
>---
> drivers/bluetooth/btintel.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c ind=
ex
>e122dff855ba..d496cf2c3411 100644
>--- a/drivers/bluetooth/btintel.c
>+++ b/drivers/bluetooth/btintel.c
>@@ -3361,13 +3361,12 @@ int btintel_diagnostics(struct hci_dev *hdev, stru=
ct
>sk_buff *skb)
> 	case INTEL_TLV_TEST_EXCEPTION:
> 		/* Generate devcoredump from exception */
> 		if (!hci_devcd_init(hdev, skb->len)) {
>-			hci_devcd_append(hdev, skb);
>+			hci_devcd_append(hdev, skb_clone(skb,
>GFP_ATOMIC));
> 			hci_devcd_complete(hdev);
> 		} else {
> 			bt_dev_err(hdev, "Failed to generate devcoredump");
>-			kfree_skb(skb);
> 		}
>-		return 0;
>+	break;
> 	default:
> 		bt_dev_err(hdev, "Invalid exception type %02X", tlv->val[0]);
> 	}
>--
>2.40.1

Thanks,
Kiran


