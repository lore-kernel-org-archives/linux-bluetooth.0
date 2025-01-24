Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241803595A
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jan 2025 09:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737709652; cv=fail; b=fmK8AVBAGP5VEYbHfZtbkBJXP4ewYK4fgwIOvJcXMKa4RY9uopmwFy/sTmRLLsDTfdeLy8QvbzfeydjlM8t/INTqUvU4mdMnp3/rq9KA3lYra20j5cO96ulKbc4AklH73X1ttC0cDofFUksVf8vsi+kgnGO5x0/XmA8h3hg4U9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737709652; c=relaxed/simple;
	bh=Qdn26vYEHUpqRq7jp6a6NL/zfOzg4bdDekgPUQYknDA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=och4QdgW3Us//KB6Fm4CnF3V4urP3a5KO2u5V22XoyjxeowKpbmdxRUUTqYyvtNiVWxBnGrBeY/5pk0MrMvf9/UAP4erm6LeESiYalRSapJYdEBxE8cNvjzKDu3nJnxuJhmljzRh/nKZ4vGGVeFCFtCdro2YFHQdprttKqsUV5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cYabkdX6; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cYabkdX6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737709651; x=1769245651;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Qdn26vYEHUpqRq7jp6a6NL/zfOzg4bdDekgPUQYknDA=;
  b=cYabkdX6OFtNNYJIZ5dkzevDQ961qSBF19GzCmcV8fDBtXtieygYzFjt
   GJfL/mCK32EHUzMZhHUD1p1QC9GpEtALVh/AjEIV92LiFLVo48cuHI62V
   swAMrTo+EdrBc7UN5dzJyFxgRA0RxjGp9Lz+jKcbtx4nAFQoe9Co0mg+b
   gi5Wx+urtb2VngLztne54aMPTl9F83xHWLxGfCtLyCRA2nEd273qttl3U
   cYSuTxpHZxp1sjgljVZ3YQxZyH7ttIvCuC4uvQwvVkIPz5SyTtqJ+rr4X
   Qa6JBhGqkUcdig+Xf9TFWbmN1YL75c6ZwB8B4/bIwFxyNwP4q8CuDmbTD
   g==;
X-CSE-ConnectionGUID: 5+5jO+ORR0+CMkBx+/NLVg==
X-CSE-MsgGUID: UweFvVJ7T6aXyTQ9HqLPuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="48743622"
X-IronPort-AV: E=Sophos;i="6.13,230,1732608000"; 
   d="scan'208";a="48743622"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 01:07:30 -0800
X-CSE-ConnectionGUID: +VC3CJzwQWawvBx22AXxCw==
X-CSE-MsgGUID: liryzCQNSGermwJAYN2LPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,230,1732608000"; 
   d="scan'208";a="107634441"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2025 01:07:30 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 24 Jan 2025 01:07:29 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 24 Jan 2025 01:07:29 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 24 Jan 2025 01:07:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UokRea0/EzmbmkkNwPD4tox5PET/R7i5eBJpLaWRUqfVrbfCanEEoqQzA/z5G91tTk9mUVPv6AOa1neNRdHpT89LoWVfr1kAtVQ5sg8tjf07jo/1L9Xgv80eDXTHj11VFuA70P0/6f5rF91UhnaYC7JeigcOzSiKnU6MAiGl45KhQ4yyKf9R+JPJj4owKjBvDJbkZ+cOCckHkyXz3/ibAL20k7CdlX3hiXKglXNUeeR0QHbjhH6GDEEHtdcRQI0iaOi1B9lEQgi0XeWW4yCtX7S2SDYuYr6w3ZArHmw+Mh8hPYXTvkMtPQu2DPotLw152D/I8VzQ9RQTOPnBy/R4SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o96Fw5NP/j/Qyx2mCYYbDGhPRtyLIvLL3WUUd0+I5rk=;
 b=wxyfJXjT25sgmPuhMvPc6p8oLBJYLFEkdoILwqUhKS9nrgVED/O++tx/+j0MSbjluPLyNaFWRF96eNtA0aRZq1CVCJtsz5D1ZEMEGThjIP7PTPDHmLXlh2jYjSrPNM97wDHONKsKgKIddBwvThoA25uhj9QHUdI2eZT2peFlaWlsf5ou2So1beQi02Pk5xhiwEXCu1E0f4432ga+uhx/QlzRz1yzIjozE1O14t9LH6QXXqAzU8xTo13p48DZEiadY0Z/Ej5wx90WI68y0WWeNni+qtPCog9zkVPPXxnXm34qy/RmCldbLjO8PnqiDcYQAXnUCGVZG/4nmbAAVTei6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5952.namprd11.prod.outlook.com (2603:10b6:510:147::7)
 by MW4PR11MB8268.namprd11.prod.outlook.com (2603:10b6:303:1ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Fri, 24 Jan
 2025 09:07:27 +0000
Received: from PH0PR11MB5952.namprd11.prod.outlook.com
 ([fe80::b961:2a71:c5e8:460]) by PH0PR11MB5952.namprd11.prod.outlook.com
 ([fe80::b961:2a71:c5e8:460%5]) with mapi id 15.20.8356.020; Fri, 24 Jan 2025
 09:07:27 +0000
From: "Devegowda, Chandrashekar" <chandrashekar.devegowda@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, "K, Kiran" <kiran.k@intel.com>
Subject: RE: [PATCH v2] Bluetooth: btintel_pcie: Support suspend-resume
Thread-Topic: [PATCH v2] Bluetooth: btintel_pcie: Support suspend-resume
Thread-Index: AQHbMbvIxage3zLxU0CexpI7qMWqbbKtGv4AgAVUKgCAc6vREA==
Date: Fri, 24 Jan 2025 09:07:26 +0000
Message-ID: <PH0PR11MB5952A0094CD5862015A0C0E2FCE32@PH0PR11MB5952.namprd11.prod.outlook.com>
References: <693d09b6-edab-4ed4-8df5-11ca74bb02e6@molgen.mpg.de>
 <20241111184126.GA1805689@bhelgaas>
In-Reply-To: <20241111184126.GA1805689@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5952:EE_|MW4PR11MB8268:EE_
x-ms-office365-filtering-correlation-id: b5b8bb72-54d6-46d6-a6f2-08dd3c56860d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?cXSb0spL5hSPrHWlf/LNnM7K8gWtdof1AN9/qir66Vran90lPhy879/XmcGw?=
 =?us-ascii?Q?bLuCuyqUA3NhRLlyBbvZavC57X9oFGM/Vd521jV1orgu8sUXsw5cYUqfHQ+z?=
 =?us-ascii?Q?kGiKew5Bg9fdfq/Yvy0DRXwJCusHBd+2pDK1wvNmiKS7vrdJzgTmQu8vF0Sn?=
 =?us-ascii?Q?MUwVQLN2mMNxgI3W9AeYdnqFaDjPX8DQhNkio4ls/uEYHZCtvJ6PJVDcaztY?=
 =?us-ascii?Q?IwQkhAAmtQ5/apu/gf/OyJyYngkmlfq0iWuRSUMr42+4QiagFuWk0Ttvx1No?=
 =?us-ascii?Q?ybnfB8rCo8REynyc1U+Fug5zmdcEMTuLQjjX2XJrM1LOOfV/ACKcrjba/qUu?=
 =?us-ascii?Q?8So5LCIcniizdHh2Fv09Zlpxot/ZA8D7Dwy//EOxe/NoU0YtxHgy7wwV+AmK?=
 =?us-ascii?Q?k8ut1KX0gKg4Mc/qk/LVKx7tE9dFtueVpq+ZYx9xAgnvc6IdhwfFXOgSWC0E?=
 =?us-ascii?Q?IPP67/5eOYsnBhyAv/nnADXzwTJzNsmuVWCuVNipdnqLXmTEaPYk9NgMS8WN?=
 =?us-ascii?Q?rHB/46ya7KE+NWTFVv5CktbDxx2dXkK0gcIEp3qe4lep76tVzjnTgpXE5sd/?=
 =?us-ascii?Q?+YrCL1eRqi34zgs8rCX8FJR9gXFKYN0rDFPHR/IXwPt4WGBNWHKSsYwnkQtk?=
 =?us-ascii?Q?eWb0keqkWTzmDJh3IJ1POJFgAAWxS246iUyPPiikSjo29G/3TCeMhJ4gNIXy?=
 =?us-ascii?Q?wlps9a3knh/DM8hpnNOPYpOPd8I/Q2zc0lKApLS9d26wHUAhFliKFxjZ/L1j?=
 =?us-ascii?Q?xmuR4Uc71Tu8OiIx+H78mgm11XqmWjRFcJDFCsv+gZfHS4797EqOOMVKtpoR?=
 =?us-ascii?Q?FO/JqYx+oaBFcEaaIONLRDHbGf+m9vXPV9F5KqA5PgfFFWoW5gvkx2FJPn5S?=
 =?us-ascii?Q?WST1JrQcTq1QMwWOjY1NfYtMU0jsZjCoZf4gIAnYhQMRyJwC7apFHoV9Z42y?=
 =?us-ascii?Q?eO826NH8pb1L14x9obh+axw2u+T8KhGgU5BvQf9MR6pEkapCDUAnudCRTeg6?=
 =?us-ascii?Q?UGi+M0YL4yguIyV+tTO0PRk7kWchY4gqTjg2ikISHyDUBFtm8MBdelrkXHWB?=
 =?us-ascii?Q?tjnd76Q1jZidQ81djEFQKgaoaOLfokNFWORU7jCZit68eh15NKrQC2tmLicL?=
 =?us-ascii?Q?MvnVr2+zjp1BdvQS6qT/P/BMopVmPOyzzZDbsL4Q7fUG+9u/Pq2fi1YFFvX7?=
 =?us-ascii?Q?P7haZOa1UZ98mednPnU9yzVx4BSaqlFLP8rl/TlJrg/gbNpPa9nGpYL8twtX?=
 =?us-ascii?Q?8lchgzlJWVhrcsxX38jaeMTb1O6W5q1o088JNX28RlpmUgAJa9H5td3hK5nu?=
 =?us-ascii?Q?Evv5pqUEnY5ou/73mOyPSQjf3x0VOim6KvWdWycz7WVjfOtranEDNtUN6MuV?=
 =?us-ascii?Q?hM0FuRMrHvst24LSOt9bXdKIf4el581MFu8MIhg5MRyE4WbNOPzmqVRqVeP8?=
 =?us-ascii?Q?6eWDiLaKrxLj+veSlf/Wx6oYPviNmxXy?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5952.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZE3+qRZHczV5ViKuSZPsmRNKeyiFRp/Ps3l8aNoLyqhmF5wRzoj+8eEp8VJ1?=
 =?us-ascii?Q?2ef2FcdHMR+M2SDoXuY2awJc6M864rOr1zXUBsWy1MI8CwF3ZFAvb3wkT2CN?=
 =?us-ascii?Q?ZR8ngMhEPnYkf15IoPY9Wu1rWcXHYi2xfkQ7oZ+H/D1DhHeMGMyl+NBFzM6x?=
 =?us-ascii?Q?y6riabPOzlDBz4V4uK4aG/Ovxu43rpOIELcexFHnubGFTFYDkpbb54exXrbP?=
 =?us-ascii?Q?oTPQN4IuIb8dbkHk396ukDr1YuXe8+jnQRbU2ZnRhJJHoiluYiCgyNxcesZ8?=
 =?us-ascii?Q?lOqRI4pcOTXpeFx3box5H9yF8zsqQAHAHnTIlZfM03xkRJPn5yIAIpEmLvhz?=
 =?us-ascii?Q?dHDHag/xpqum8cMrHEeo5bhCZGPpS2ee2keEEdtaMP7fKsxAtiZobeMsd/Za?=
 =?us-ascii?Q?waMeFt0qexVK4U4QEZqG+2/2Y0A7imFca+Abu3FxE6pZ7i1ZJjblaA6mApW7?=
 =?us-ascii?Q?CzrrPdZCnUJPIbM74vcsGdGwGV7gYsK5xFYmSm1zBHDj/UXk93L+v32CldfX?=
 =?us-ascii?Q?UGh7M+WeGIoeXOQRlDoyg1sW8/vqVjwj7tmppBYiRO6UTaCowBQdjlQCZLWa?=
 =?us-ascii?Q?+bjSoLIsRFa86nEmOOyYME5NRdI8zieycCLzYvX7vN1O2eNlEtxBhPh61rKH?=
 =?us-ascii?Q?CPOk3IAiipngjoYBXrKiFc++TWII748im0BFVsCYlqC1WRjGDSFoACOKxzHf?=
 =?us-ascii?Q?FO0pPIhx31648xbdy9gNut60G7Ug1j1tg7C1KRcPkJ1t+EAD9ddoJx1Znq42?=
 =?us-ascii?Q?kHOF4C3Y0liljZ1hv6QG2p1VXyq7pqWTD+JX4c2erBwFsdLXL/vAVvnBJonC?=
 =?us-ascii?Q?IVHHJB1Q9lm1DXtcRGnPH3xc9Ngct//3IYiBREVqjJYa6mXkk6js0TAryeSh?=
 =?us-ascii?Q?h0BmNLb76yLBHalm4OQBWTrnuubc3zFTgQ3k2hwtxc6bRq32bh/PG38nNsL0?=
 =?us-ascii?Q?MBIMtYxaN24glA5H/6cIUbq0l0Nw/mmkKcph4+GgTNHTfbUGrdnRfvUQLkIQ?=
 =?us-ascii?Q?hj3NH9ZajqnQ/PXNE/vYe1YV8ldJUXbgJ2MmClvwtpFIeDsBU57/Ld/d4nO+?=
 =?us-ascii?Q?GiKnFzghU7yO8iWT/AyQqvYNmjtettT73KyVj0LNVHj5uQIJEOUj5W+Wndvx?=
 =?us-ascii?Q?IX2Axk0Aiw3KkBOqE47UfMrvIW8oiNhWejOO865k6Wj3/zhfUTC3oNIjsV/+?=
 =?us-ascii?Q?j1hfQftZ2F4hlutEtl0kMBZv+GdIbdfbMsz9YTzu/+jyYpdbJaadQ8V4CHSE?=
 =?us-ascii?Q?ebV7zL2155g+35wu+RsI7bAW5Sa0e5ZU4zrwwNJTBg5EoIWWJ2DCvrmvbKdL?=
 =?us-ascii?Q?FjxU5MFIfivBNGzEyDSogrCXIBme64InowNH5UPQvtTbl/ewLYtjqTik9Qtd?=
 =?us-ascii?Q?eVa60XmioaAR/iriENHtnCq9YrVs+oKkfzn3m8j+57dfndSU5Ko3zulQJp9O?=
 =?us-ascii?Q?gCcSmay+wjoqTkpSqHxiD4vD3nuePM+A6b+OkoKZFVy7Mc4EJtU9g4CtDtB6?=
 =?us-ascii?Q?UyK+9OUMARrFHpXTikS8O2QuXM3FvxH4CmODb6ClM4+QH5GVyLRhVgXjd56g?=
 =?us-ascii?Q?rvBBIr/1fosU+IibwFXr3BiV9DY083x3ignLCsQvtTxN7zOwnwOqFzmIuzGw?=
 =?us-ascii?Q?0Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5952.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b8bb72-54d6-46d6-a6f2-08dd3c56860d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2025 09:07:26.9983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tIlAfIWAgHTHv2V5lUHfe/eXOFleefFwmjYImljn1erfm57ahqjZRQAXLWPPruOYaNm7PyJQzp221p5Z2KJndHoWJ7x1mJudYihpMH9RerNEuo6uAaA1ZSdhCIi36/LL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8268
X-OriginatorOrg: intel.com

Hi Bjorn,
    Thanks for your comments

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Tuesday, November 12, 2024 12:11 AM
> To: Paul Menzel <pmenzel@molgen.mpg.de>
> Cc: Devegowda, Chandrashekar <chandrashekar.devegowda@intel.com>; linux-
> bluetooth@vger.kernel.org; Srivatsa, Ravishankar
> <ravishankar.srivatsa@intel.com>; Tumkur Narayan, Chethan
> <chethan.tumkur.narayan@intel.com>; K, Kiran <kiran.k@intel.com>
> Subject: Re: [PATCH v2] Bluetooth: btintel_pcie: Support suspend-resume
>=20
> On Fri, Nov 08, 2024 at 10:18:54AM +0100, Paul Menzel wrote:
> > Am 08.11.24 um 15:39 schrieb ChandraShekar Devegowda:
> > > This patch contains the changes in driver for vendor specific
> > > handshake during enter of D3 and D0 exit.
> >
> > Please document the datasheet name and revision.
>=20
> Please also include a section reference for this vendor-specific handshak=
e
> required for transitions between D0 and D3hot.
>=20

Ack, I have added the Intel specific SAS document name and the sections whi=
ch details the flow in the commit message.

> Most devices don't require this kind of code, and its existence is a hint=
 that
> extra work will be needed to maintain it.
>=20
> Bjorn

Regards,
Chandru
