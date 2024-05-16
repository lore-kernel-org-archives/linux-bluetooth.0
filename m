Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F28145B28
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 13:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715864628; cv=fail; b=FzcFzx/3CT8sphRrAw5ktEuk1UndtCpHp1xcGUv4NhyYPsYrBnQ0XMHTYGuc22MSTL+I+Oc55z17QlwOjC8pS8J9PT38DJHZuftUjv+2ckFLJ3osM2urzGphZz+blmUHxW1SLVTgpDXVphli70tl0Z1UBVJ+pLFGz98O6ilyuYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715864628; c=relaxed/simple;
	bh=Ak1mCqAH2YU/z5i6VGJvLtxT3dXWK6wUIrUcl5yS8gY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pTUvkhulbPZS+xI/I2aT6Q6oTT0814l0heNVX1tIk9melBtocWLW853xAonOkWp4c1QBMTvq1TLM4DSM63jypCVQTLWsKNI3w/SscfL4PedUK+CbVXye9uH9522+UFLr/vGuwWRZ6ELqcQFQ7UVG6qkZrfeIM4AtipBN+nEu8lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hfycm0/1; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hfycm0/1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715864627; x=1747400627;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ak1mCqAH2YU/z5i6VGJvLtxT3dXWK6wUIrUcl5yS8gY=;
  b=hfycm0/1RXcj6+l0nVjVmyEVksu1Z2nz9bOaffe/r7bq1a0oPiW11VCt
   6RUY+IF5l78b1b0mZVa7G7AR1c9jv0hNMelL+R29j0bEzBTUOiVFsIiIY
   qXb6j7kHdPnkpOhZwbqnZhxsfbGtNRgbaIEfvU0xE3cqHmp17B7VD8oIh
   PsypKewInFQV/Do53c8R1QPOPpzk2M0PG8qpkMBa9TVRwRfX9qZwm2b/k
   ApIXPUlzw+lHiDjw9IhMO+bwZX96DIw67KRYUkmYtr9xZDOT15f3KieVM
   qQj+zEkOTxqeV92eZeZ35cMWjXd4h9XIyTx122pgKH2VFft2zfjr4zrhc
   g==;
X-CSE-ConnectionGUID: KGN/XK25SviF7baKFbnWYQ==
X-CSE-MsgGUID: 45xBUgpFSzeIvU4KTkUc6A==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11781289"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="11781289"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 06:03:46 -0700
X-CSE-ConnectionGUID: Lz2tuQoMTvqfGPc7i+02rA==
X-CSE-MsgGUID: vkdDAEDqTUiegizsY5C5aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="36154578"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 May 2024 06:03:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 16 May 2024 06:03:43 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 16 May 2024 06:03:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 16 May 2024 06:03:26 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 16 May 2024 06:03:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fo9dSZug/cKBGze2WRlaYfViJlMJa8QjS2F58yatzIalFi4bisAuh5Czh5DrOmhBEMpN0afMln5oDl7DN+HSqI9CbpWWslmS6SrsusegFb0QaP8m+UIty8k4Ref6Ma28BInE5dMG/7If1j677qKwSB3oO6aF2rKZ0XpI9CllwKwIa+e1OELsk7m+twzupTcpYGqeS1/G8DOvpECAagHiCTTx7z9ArVQ2TDe3y2jM30aIh3z21RnxlI04JpE3V4Ohc1z0K3ismuwYjF3EZKl8Nfd65kjSZ1vfC0wSJV2/qhXN0KayTIhRYlqAG8WePhq91z8H1OCi/AZ5/gXPn0I5sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fn0P9qhU/hmxSMQA5OFTmZ527PGcGIBh853wGYleLQ=;
 b=VdCqenAeg2LaU9WJVzTcHjunFGtyAevX/ClK8cmG8DhPqHLVYoda8e5j4kIS8v1R5gXHa2waR+2F0F5szztAsV8/PQP4LXWipZEHjHe6VR9WxOeLBmRlfyLVDDcWD2n4aBfWgjJ89+FV3vgbqcOswP4IE750b1PD8PZNPUMntI/4ohbU4mQRbegv1fbN0NZrR683iN6uae+6bmKTMdzMOvhldrpmOPimGsSuOh6fP0KUx0eOgkWPo9Gvq29TRHAdfwiikehMJYZ2Fe0sD3Wf7FpM/kQD4tOcWBWwpiPaR+6ZVhYibVjbnAR28WCtUCe1zSHxcAuKe0wm7NZnfvshzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by CH3PR11MB7251.namprd11.prod.outlook.com (2603:10b6:610:147::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 13:03:18 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%7]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 13:03:18 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, "Satija, Vijay"
	<vijay.satija@intel.com>
Subject: RE: [PATCH v1 3/3] Bluetooth: btintel_pcie: Fix REVERSE_INULL issue
 reported by coverity
Thread-Topic: [PATCH v1 3/3] Bluetooth: btintel_pcie: Fix REVERSE_INULL issue
 reported by coverity
Thread-Index: AQHap4wgIzWqHInHzUGt/5hlU9MTx7GZ03Aw
Date: Thu, 16 May 2024 13:03:17 +0000
Message-ID: <PH0PR11MB7585A340F55F0B7C1961B18BF5ED2@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20240516123938.891523-1-kiran.k@intel.com>
 <20240516123938.891523-3-kiran.k@intel.com>
In-Reply-To: <20240516123938.891523-3-kiran.k@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|CH3PR11MB7251:EE_
x-ms-office365-filtering-correlation-id: 148097c2-a4c7-42bc-8941-08dc75a88e50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?AX4kS/VAyL480w65Z0eibFoEcsWCylwRX8v4nT/RCL1V0Zk2bmNnZZd9FUS+?=
 =?us-ascii?Q?++jook90EQuvns3diUZl44rkU3ynBOmCwH5N9yCWb5P8fu+bCHj/d6JzBpHa?=
 =?us-ascii?Q?1BjdEbo6rioGkX+Ntlj31i0e1CpMPtPpONtrFxQJSSaMRmOOHmUDFJ967Uid?=
 =?us-ascii?Q?Ncrxrvl9B44NhBn29MnnPuOJgCidvj5jb43Wrm9jEWGgfbVQNrNHJ3kZGf+g?=
 =?us-ascii?Q?i9jNTkTsVivyOzM/iUa/BzI9PvLnajMOhF4edOPxVZO5OlRoZUtmhH2A7NVK?=
 =?us-ascii?Q?QuXKzkDMEeJcv6q/YPcVU8UAShNabAIq3w62guBxOoXAVqkyHVIst4u+PvXo?=
 =?us-ascii?Q?c+ZTk2ZlFaeIMfBlwhR7a4a8/3W4WXtSZjTSJ5Ma3+zylM8prFNMmgxbXgyG?=
 =?us-ascii?Q?R/j/FAACM9E/I7M/9w4zb6lDj8dHvkRxLjsv4D1ZA6OCgRPbEm0SPoU6UFFS?=
 =?us-ascii?Q?8+HiZN1seSb+DAmwWYcDMwhW2tKM7Bv78bI32W/WHfk3Zgt/5uvOkaQ94Rxv?=
 =?us-ascii?Q?xii66t4AMmhDKZt561neY5DdxRNXmF/FAyu1FQ2/qdaLn8fWGRm9Bda1kXU2?=
 =?us-ascii?Q?MeisvJC6okxLFkTXUaiLDV5gceQq76ufYpsobHmWKM4iz3br1WJ+IMcgYzSM?=
 =?us-ascii?Q?eSlLWildTpw5DMcs6bChS4FTnmDcMxkcoX4ecr0c+8FFCeNQsCbK8I90mpHa?=
 =?us-ascii?Q?UDc0Eyp1IIIDVRkEjRiTia7sak198rduyseHf3h0ofFt4IN4Ly+7Mg87yM1+?=
 =?us-ascii?Q?9IZl89uB2wv2xWptWYM7VMGokCadczKObX0iQwu1xcTo2U6bxR6Hpk7L9fyl?=
 =?us-ascii?Q?TNI4O1rNdOl1iDdh6CH59phyRkUy+xlgfBjZng/FPLiXqxjmmj4YZUkmXovb?=
 =?us-ascii?Q?XL9qYy3GQsgRzyYyIWfkvXqykpKN7Kg1TiZeCcuQXY5dvj5T2RdSavgWKDBo?=
 =?us-ascii?Q?Wdh7ZwW0p1UEre+SmkzgHUM0+addX80cAqKcg7c8E7bkbSFq5a4Qf5iFERKv?=
 =?us-ascii?Q?gKATYNVJyFzJ4OL9usfZxshaWNyZgOlrwjoG3N7/tP58KVnG9HXgxGuGQlzp?=
 =?us-ascii?Q?VOf8U/IC3lBFNdCNrGPPqAiiIqCo/d/UF5GsLFpCbaZ82jpkYR1ZD4vK8nC+?=
 =?us-ascii?Q?cXqrzesBD7DUFqP1Y76QzYfohC1E6oM066yag2RMpOm0+diP7RVdp5LXXdtW?=
 =?us-ascii?Q?Eq/YZPyXuqJ9XVZ9uY7yLYvHVjyJaQ4SFFhyWW8LZvKjNtSdR+kU7kVkVoES?=
 =?us-ascii?Q?KZoaOrRmfDFLZUoHMsXtfLstuXWvOYpNJ2hy5r6YS5TqxzcCSQMgU/IGpb5a?=
 =?us-ascii?Q?VfgJOYA8cWvXX/GvpM4Y2e4BYr/XlH3DZA6v/x+4ubRCuQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p20//X648+m3dlArOeqjWeLxsKRv5rxpREk11NoC06GSsr67t1hwbA0WMmBt?=
 =?us-ascii?Q?D/N6qxywmNWXlsKAAPVIFSS8SJqeAC3Dzg8wEGhAuA6JMSjamIFvipbdbRXr?=
 =?us-ascii?Q?6VHHN6hZRI7G4EodjlRP4LE1OksMz1dk0nkbzJ1JDPDhn8gUFOT38bmZkvyl?=
 =?us-ascii?Q?ZsXC8LUqCtpaRy3RvuGqLwuWOUaucjrzhssgPP87SRJdqcEAItbXX1Bzp0y6?=
 =?us-ascii?Q?XasRym+ArNrAh31Yll/DLal3ux+Nx3iTDFe6Q1+hFmxTQZLq8Xnhllau+XCf?=
 =?us-ascii?Q?Av3MMrpbPDrMsdNV+9rp2X3j7M3aXAVtIqBMx/iGw80xkbogLXnOs4Jyq+KT?=
 =?us-ascii?Q?UQNcNeoJBnnZSbHRZ9y/oDV+kUcxh+JavQZ7IajMPR9/KP2x9qyrpwtMMyuZ?=
 =?us-ascii?Q?LSlF+dSzeUm7dv6+cJh5pm3jZBHlJ7p2lftuQTAolpCRqdIbznEVopkIIQr5?=
 =?us-ascii?Q?pE1QvRqbQnmUIpJzA2xFRb+nZssDyam76x6dUfwgHwtjzdkD6V/bjNjbeX5Y?=
 =?us-ascii?Q?lcZI+3W/QNvpVv/z2ELZ/D5T8+WiN33NAiXlPfmkIS2QkuzKgyTAUhYNuOGz?=
 =?us-ascii?Q?/cr1bVWczhe9wsVvgwehX2czJTHxfVpG4e21TWLpJlQhp47cGVEouZcr+XuJ?=
 =?us-ascii?Q?SR9Tg+rY3hXSVqrIrhIWkxctyFbJEe8TjY5gykMlMDT71102o7p/Q3P9/XfN?=
 =?us-ascii?Q?yQhjTbWzeh1fzvJXqtdnFtPxhR500o8hvNVAh1YvcBiDcRPLFpKr8QUN4q3j?=
 =?us-ascii?Q?fi9A2rQIcZKiuuG39+s0hLGKiD4fZ2xqcizqR83Jjg2NIrJr+GISXJzPzfOo?=
 =?us-ascii?Q?ReYqjmqrYg1yw8H/eJ4WmdOpfNKQUGslkC6cCV3KvoB7NcpV7xNhpGPKQlmv?=
 =?us-ascii?Q?kHdgSC9/c8k2mkcNrLrZMNTIKoaBrlsZ2CuKO7nb9cGE6WIXCk5B+d+TmXfR?=
 =?us-ascii?Q?uPUD3qoNspBPFrFUF2tksDoK0+hXbOEMTCDpUaniuU/0607TSiWIP2JiMqSl?=
 =?us-ascii?Q?tHMeVhX9zzqU7/igh6Zm52jQ1IxOlhocCl89k65sXRQttxg4Sg0+/M99dikp?=
 =?us-ascii?Q?Vf4GgMxKmY9UFUmsaJ5i1qbb0pxHsRnWStfJ3sboAw5UVqNE4IPnK4Ko1GFl?=
 =?us-ascii?Q?//0VAtwlNNaeTEik8dDgKUhd6h2PQMBZmcuXi41mbEFFskXgISmzjhM51zZw?=
 =?us-ascii?Q?64PDWG8p44noLogo/q7Bp9utcW9d3tsOA7OpefAgT5XUz8+lw9ufw1/QmfD7?=
 =?us-ascii?Q?Px8BpTxgCeaByQpOfX0F6uT9l2wXfL+vsRZc6mthSQ6pTeYFplGBV9nU68Me?=
 =?us-ascii?Q?z/klE+nBTuwIWD7p4LYQCZU2U0XQiZp+5u03hmCHSofAw2nYY2dsumCT+C22?=
 =?us-ascii?Q?wUH3bpLFa73LpPdkSvEQRqBy+3OACHxS0U+00OJEd02cWi94tVaZxHOcShuT?=
 =?us-ascii?Q?V9NKFwtgZd1CIq5IwYFXZGULwKOC7Z3WQyEb468FwpgR4rziLP6hVcM5dXCO?=
 =?us-ascii?Q?0l51iPW7hdEPg1G0ayckTjVimHjK6JCxp1V3S6yy4I831AVUpKAoytZjVDmn?=
 =?us-ascii?Q?tEh54yvTKYJwHHwmLbU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 148097c2-a4c7-42bc-8941-08dc75a88e50
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2024 13:03:18.1905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VxzVPnKn4ArInt+5UNfvLui3B97pHvM5xNFhW5kE3TzfwwRGd2X6jh+1yUUy+NTtfDY6ScSrOFYO2c5zPgSkaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7251
X-OriginatorOrg: intel.com

Please ignore v1 series. I have published v2 version with Fixes tag include=
d.

Thanks,
Kiran


>-----Original Message-----
>From: K, Kiran <kiran.k@intel.com>
>Sent: Thursday, May 16, 2024 6:10 PM
>To: linux-bluetooth@vger.kernel.org
>Cc: Srivatsa, Ravishankar <ravishankar.srivatsa@intel.com>; Tumkur Narayan=
,
>Chethan <chethan.tumkur.narayan@intel.com>; Satija, Vijay
><vijay.satija@intel.com>; K, Kiran <kiran.k@intel.com>
>Subject: [PATCH v1 3/3] Bluetooth: btintel_pcie: Fix REVERSE_INULL issue
>reported by coverity
>
>From: Vijay Satija <vijay.satija@intel.com>
>
>check pdata return of skb_pull_data, instead of data.
>
>Signed-off-by: Vijay Satija <vijay.satija@intel.com>
>Signed-off-by: Kiran K <kiran.k@intel.com>
>---
> drivers/bluetooth/btintel_pcie.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_=
pcie.c
>index d8f82e0f6435..58144c82b1cb 100644
>--- a/drivers/bluetooth/btintel_pcie.c
>+++ b/drivers/bluetooth/btintel_pcie.c
>@@ -382,7 +382,7 @@ static int btintel_pcie_recv_frame(struct
>btintel_pcie_data *data,
>
> 	/* The first 4 bytes indicates the Intel PCIe specific packet type */
> 	pdata =3D skb_pull_data(skb, BTINTEL_PCIE_HCI_TYPE_LEN);
>-	if (!data) {
>+	if (!pdata) {
> 		bt_dev_err(hdev, "Corrupted packet received");
> 		ret =3D -EILSEQ;
> 		goto exit_error;
>--
>2.40.1

