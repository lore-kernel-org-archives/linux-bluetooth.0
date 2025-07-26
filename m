Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530DB1FC3;
	Sat, 26 Jul 2025 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753545633; cv=fail; b=ODEKboJ8oP+MHAPRnxULo6p/A3QEt37Xwx31fZUZ6ZgzVEb+HdRKwQrfA0PLQvIkykhEnPmgMliNDakvjR5FAa/E5UsCsAjVJyettHhtc1Fa4dwXF2HuvY21iZEfJxWEES/15V2K09GvGXetSJaMue4fjLvUmLTblqX+BzMabr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753545633; c=relaxed/simple;
	bh=4vwOulgQfCVOwZWHHCaeMz4SV2e3NL5v94jcLaJYDto=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aKVCbnzVY9fC4VRnotLGwoTTLZpvK0SEICZvFMTT9e67TfqocBPly7xXsulyFI1efjSiYNC4XMok5+EGZPSmSW9COHeAf2bcgjoPLMkA2quEOAnRgwmXTPax9li8UU2Po1bSEqdk0yLfMtGep9HDOUt8DtnAi9G+WLcsZmXnFAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B0pTCjCi; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B0pTCjCi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753545632; x=1785081632;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4vwOulgQfCVOwZWHHCaeMz4SV2e3NL5v94jcLaJYDto=;
  b=B0pTCjCiFmBLwUGDtaxKZ/BUlQqrJZQ1AUuLhpAIjHx+8zk/wH0XooC7
   zMFdtj6iEUDs8DR7urzluTFwSJEBrPFf5Fnm+No/bT/KFzCMT58gWOFQg
   GWGZMK6zDC/Z008PLXv1jeK7fJCms0ce8P9xM43A9tzN1lE6NBSDiKUh1
   c0HbwPFvyDyNlvfmtIrSrvNCbOJtHHYuda96TG0gT+bt3mvcwbRRrTLyD
   8hNvtPUYExC+gt1ngLEaLL3kGWHr57gXVxu1M38rHvmsj4VZvMJSBmcRS
   w0gJbOkD9pr1AloZJ+j7RrwVQeWklz+WSgR6BmsuUQeiipVz8kU7NA7Dd
   g==;
X-CSE-ConnectionGUID: oXvOHpvbScaSPeJ3FcELZw==
X-CSE-MsgGUID: zs4cXkyeRwyyVpxKYEk8Lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="67207575"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="67207575"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2025 09:00:31 -0700
X-CSE-ConnectionGUID: nzZtONsFSxGwxX+/Ll8gBA==
X-CSE-MsgGUID: hYIcIj44QnSLtAFFul3x9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="161336185"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2025 09:00:31 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sat, 26 Jul 2025 09:00:30 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Sat, 26 Jul 2025 09:00:30 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.58) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sat, 26 Jul 2025 09:00:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bt1yOvCHdj+d34bRtS5WgKZ7ffEBzK2lQ2AOFQSiWQZzkv/3e3AQY6OWr1SPq4RT6zEHo8rFL7l4UOWq4bhbfMaE+dBu7n2Hs8XztrCzZcFAKPcGaAM8BqVYuFn9yh/7GD1SJZ0Mb4yNqm+WGYcSNWKPDBFZ77XHv5lSKCCk87sI9ePGseQuFgDOooQSRA417KTl01vE0VuGJEYC11sW72CPJ+qRpUsqIiFprBk4QPtfVE9zIRYASzKIPCGo+LhTd+gLM5aliyHBFdjaE1IXpXkgCm7Bs9a0fEJjePIqUTBGQjjNjcTz5vwtYkg0Q9M+rJ+KWOxMmuBDLIeP2004ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVJ948EE0YSmTayYZb9+Y//Wx9tHBBOp7cVrNM9zzMk=;
 b=yxHtDTXW6XlUlRkbjRTe2JnVxNpJjvqw+Im51C2K1rXjAap6/ne/beNUJ3ZO67mjUpvUM8FqkvLcPz0TotgvkmjjUEFMncOcGVDZHcN/Dq5zsTcaB3SePYk5qxC1+IXp1ruBljzBMRqbkbEYY4kSSF5bH0YHqXbTdyHU1EzA17mXoTxaZLXSO8+Lqrmyq3KD1pwW6jUHGNerSh3L6rqeTx3nIBlGOr/zyNriJjFyPDGgWWgBePc6COqwJ3tp240ohwP6iWCAwdns3qnVLrkl6+eeBVawrYFbcUGjY7aAvfgkJX/MW7W5xsCthIiDKDqg1+AcZE2OZ+Z4iMQzB8x8iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by PH7PR11MB8060.namprd11.prod.outlook.com (2603:10b6:510:24f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Sat, 26 Jul
 2025 16:00:27 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%2]) with mapi id 15.20.8964.019; Sat, 26 Jul 2025
 16:00:21 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Arnd Bergmann <arnd@kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, "Devegowda, Chandrashekar"
	<chandrashekar.devegowda@intel.com>
CC: Arnd Bergmann <arnd@arndb.de>, Vijay Satija <vijay.satija@intel.com>,
	Aluvala Sai Teja <aluvala.sai.teja@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Bluetooth: btintel_pcie: avoid unguarded 64-bit division
Thread-Topic: [PATCH] Bluetooth: btintel_pcie: avoid unguarded 64-bit division
Thread-Index: AQHb/UODoLhUFpFBLEiy47KT1UqiZLREkUug
Date: Sat, 26 Jul 2025 16:00:21 +0000
Message-ID: <PH0PR11MB758570724403EB405BED32CAF558A@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20250725090651.2495984-1-arnd@kernel.org>
In-Reply-To: <20250725090651.2495984-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|PH7PR11MB8060:EE_
x-ms-office365-filtering-correlation-id: 343ab0ab-4955-48f7-583d-08ddcc5d8633
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?rcHhT0dTXAgfx+J6sO8x4Jyri27z3jckkuP0HTDbfrki4OaM5ENwO4lq38YH?=
 =?us-ascii?Q?BDO6ZEV0SzIeuEMqnRrYUv+CSlA/AVLmrqrP6axrgXZxakA9Uc6So1PVU23S?=
 =?us-ascii?Q?QFAHQ3sTLx6sAB9ofSub83NtIrHpwU9sMi3Co0KlwFOLxm/VBCLUVrprmWst?=
 =?us-ascii?Q?3X1b0m2IOxPkQLoMmvoh6tbwAgj64HXG7fcXbuDu23+ir4bg50iKCR7HqdwG?=
 =?us-ascii?Q?3ZPpLOq+/BUopGKf4TJW9pGlvcRJ/fuAdPhnfWfJx8DZh58MIqt/ILFdkbYQ?=
 =?us-ascii?Q?w73+3b8L9EPn8jOVDaSw2lwRJvlBgYbPmrVhZEIifxWF/UnGB0hXy6PNcYlf?=
 =?us-ascii?Q?0lLnpkTpuqERNv6GLxmwUbMIpS8XoGBoDV3D7pG9UZRG6HqS05LBVsPW/yCQ?=
 =?us-ascii?Q?42vgMLufVXFT5Jac6gy795sVaAV5slnRxXWbmNrFfc404qUtyjbDEkVhXKLh?=
 =?us-ascii?Q?hKy53iJvBAlBm3nwYn7GeruFizJagbh1o/b7Ts/GOv66UGgbM3ooNTp/L5V6?=
 =?us-ascii?Q?918ebr4WO3InyDscfT3ocvUcox0uxqxHfdIU1tnE4CzkRYZG2WvHAorhcNpH?=
 =?us-ascii?Q?XtkzPfhMcWIrka7AcHSj6iqHwGg1vy5ds9QsPnOjpVDQs4pkJYdZ+LtBFWDN?=
 =?us-ascii?Q?JyxKFYjoo0qlEaYNjaVSC6BNgO7n0EVIrLKzK1MVVRhKOQTfmpC6CP3wKjKf?=
 =?us-ascii?Q?toWPRMMbsW5UeMUtt01La4WNgbn0Dg6VSNCm2T0/ggxscz9ORhpNwP0Vw9O9?=
 =?us-ascii?Q?7kh8LtMqZ9IcTESQs2lWwSUzVeDTdrHgucF7y2AxZTiLTUbNFs7bq2AwxGBg?=
 =?us-ascii?Q?cuDWExVY4AVQaQE5nVIX2Ux4vJrRRPb2fO+j50e192s15e1QVi/1na0kLNCW?=
 =?us-ascii?Q?sN7e409Cq3IKS+TcEyoMUeb3bxmsqiASplIxGC/8T7KPwNicvpKH4rqFyTCY?=
 =?us-ascii?Q?vs9y4MDVR37HV6A34hMUphSG3UBVOZu8uj+ZfuAh7ajesmdDQSbQ7Wi42xrG?=
 =?us-ascii?Q?bxHFoJ1fSV3BnUiBIQ2c8zQ31NFkgoF2MuwH8+jr5ZWPSIRKc77R6v4g9kzW?=
 =?us-ascii?Q?H6SclLT/MXeuMgLhPujsG/6P729a5ps0tZcbCia2dXBK5qTsLxvdTM4ee+JZ?=
 =?us-ascii?Q?FUM1GUztP2M7wc8OaXZIbG6DkKg95Xq8gKpYaScaNjIcwNamujTStuU8jkHE?=
 =?us-ascii?Q?bgkFRXMTlMu+ZQGAYbwPrBM6L4EUzwr4cJzMOPNIlopiqFRq+0Fmcyt2Uyr8?=
 =?us-ascii?Q?rxmDV+x956tjOtdDAJVgUD4mL5AWhyISyZpbvgb+m3bw/TCu1Ddfp9QVtmyP?=
 =?us-ascii?Q?Z04iARKMPeRDcXbfvfesP0jpH6YdAdjTFawl62ax+6IGQL/fenX0EMbw1A5P?=
 =?us-ascii?Q?QcKtsaLmH9B4nkgMBLFtVU7Eu2hVUOoYRDrlbD8JpTbk3l9JlJTyhA+VJeu4?=
 =?us-ascii?Q?cZoax8wEWv0sub1dlwebgnvzdETwRGHaTBML+84vLg4fCav5dnDwp/fAx1ib?=
 =?us-ascii?Q?taZ3udIArQASWis=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GEoeEqHRQVOAn70p1sYDRtrBBx7B60aKB6wPz5r/Whdvrp+Jwtws/hBdIDQ9?=
 =?us-ascii?Q?IJqlyWp8AVk50mOz9vUkA5Dx1UQoHaci5hmZQrvZ4JC9c3+koqYdZq0WVz/o?=
 =?us-ascii?Q?Uja7kXZh68WCJPDs9c+5WeGW9ErrM/E2vcS1UnZxnLRwgpacX7rypa3mfEWG?=
 =?us-ascii?Q?cvW6bxxKV4K4FS0y9ZZgetowMlq6cB31HuJSHZoWWOmbovVvJ+R0mtQuyirF?=
 =?us-ascii?Q?0dZEWMSPHr5F7U/7+qjPTuobp1kH4SbKGGU/VU8ZZ3p4GFTlnQUVzEoeh8zb?=
 =?us-ascii?Q?yay8pBJpqi6Pzzc5nTZAeWdiBgrhOi4MA9GqgHyD0/HxEvrm1SEUzX7n3kTF?=
 =?us-ascii?Q?Clax5I/Zw5naOK0C4YTYz1D8sYvZp4Rn16gme6f9rWEcsK42+B5LXE9i4VAh?=
 =?us-ascii?Q?y31UNiYQpbymTkGTyIgIxpnhEAhY7x7fRd642u4Kz1NyQ39P/ktTXok5zWXL?=
 =?us-ascii?Q?ZyVLGp3uTE4zoXIqhzcLx8RwNqM+we2mATcUoBJwAuJR6eHG/IsrCfHjLaRp?=
 =?us-ascii?Q?sMab2yscdj+dcs5D8koFuePsU24B31mhedfEBViqmx5gXgJQY7wjT6jenlP2?=
 =?us-ascii?Q?htRqSCSPIRedzQhN1h1uFXIsOnQ/4ZxRsSuMJViYIYVDxlBo9jYWx3vkOc4u?=
 =?us-ascii?Q?aZmE3zqAcfAwOOpCKBgQE1OTOY4RQSMvAUtJtK7wU6u/ezL4j+36U3b4XRbW?=
 =?us-ascii?Q?xSWl68RTAjoB/BlqxYQE1+aFHjYUu/+ljsPc5yOCI0yoVw2J0ZQvJc98Gdhv?=
 =?us-ascii?Q?QjurmqqplQBe+gAMUKeL4iqcSfPxdzd5lRIfECJOYUHpJvR0Egn4AoAQoAaP?=
 =?us-ascii?Q?2/W29nMAqCeLvEZGywbOp/2Zu1FsuaHhToEy3NPjRVIWdEuMGd77ir3uxzVe?=
 =?us-ascii?Q?u2uWhyDkLG79lEAzwyZQe8C7MGGl+AMOZ5BpUkXg9/O106EXN9sV87BpTU3z?=
 =?us-ascii?Q?9fodbK3SRlnzTv6HaP3XbPlfG7y6kxQNixzHipH7lGJqNbNAebf/+h3/Fa/F?=
 =?us-ascii?Q?nuUrSUvv/Mugqh8QYxeE35+8Bx35U/H5IkhtGY49G6B2qIto5K1tPMX0s0YQ?=
 =?us-ascii?Q?b8N3hLLdo5zKFt962pc1T3YCm144dEDB3fse0srNfMcyFjK+bG88whi5WAq/?=
 =?us-ascii?Q?5YnYkfIyOWwfN79/5zZ3lRufBRJ0CRwPUYfIsK0Dj9K6lxakVkQWy8ufC0eT?=
 =?us-ascii?Q?SIwzhusMjL4YyhhT9FH4YsV/fFO1qrcalESijUe7Nrh4i/SXqYdJdsWUETTc?=
 =?us-ascii?Q?Tu/s2OOGW/wMH05Jjw4rPPEo9pgs26ygdje5dncTTfOdiHZw1s768ca3T7zL?=
 =?us-ascii?Q?dB3MW4PzqaxcCvJqDcKpMxkdkGYCuguM5HdzM35GQl65l49XkpWD0uJHFDkO?=
 =?us-ascii?Q?sXQ00J8i9NI6zyk/9ZravAAnvRk+4SfcD/mMQjvPxXRLjqDirhaaP7rIsNrs?=
 =?us-ascii?Q?1i/b5dtA7vvbHUOw80BOdRHOX4DqC6tPynstx1eNaz1HPr7vD8K2ROxU8U+H?=
 =?us-ascii?Q?7w6E++jZh1YITX/F8c3AVwCu/a4n0kWhgAqazd8hJ2sVfWj2UdId6SM4kHpv?=
 =?us-ascii?Q?eeE8skw3cgPNJ9qAkx0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 343ab0ab-4955-48f7-583d-08ddcc5d8633
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2025 16:00:21.1506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: os+31N5v9aQl8XxreF3PZ4jlz0mdT5kwEQ+5B9T9R4kE78nWzc+XvXaOz05F14pHH35vbpCy4GqORmQ8ZAVWfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8060
X-OriginatorOrg: intel.com

Hi Arnd,

Thanks for the patch. I would like to amend this patch with - https://patch=
work.kernel.org/project/bluetooth/patch/20250725090133.1358775-1-kiran.k@in=
tel.com/

I will include your name as part of Signed-off-by tag.=20

>-----Original Message-----
>From: Arnd Bergmann <arnd@kernel.org>
>Sent: Friday, July 25, 2025 2:37 PM
>To: Marcel Holtmann <marcel@holtmann.org>; Luiz Augusto von Dentz
><luiz.dentz@gmail.com>; Devegowda, Chandrashekar
><chandrashekar.devegowda@intel.com>; K, Kiran <kiran.k@intel.com>
>Cc: Arnd Bergmann <arnd@arndb.de>; Vijay Satija <vijay.satija@intel.com>;
>Aluvala Sai Teja <aluvala.sai.teja@intel.com>; linux-
>bluetooth@vger.kernel.org; linux-kernel@vger.kernel.org
>Subject: [PATCH] Bluetooth: btintel_pcie: avoid unguarded 64-bit division
>
>From: Arnd Bergmann <arnd@arndb.de>
>
>Directly dividing a 64-bit value is not allowed on 32-bit architectures in=
 the
>kernel.
>
>arm-linux-gnueabi/bin/arm-linux-gnueabi-ld: drivers/bluetooth/btintel_pcie=
.o:
>in function `btintel_pcie_suspend_late':
>btintel_pcie.c:(.text+0x224): undefined reference to `__aeabi_ldivmod'
>
>Since this is a ktime_t value and dividing by 1000 gives a microsecond num=
ber,
>just convert it into microseconds using the appropriate helper.
>
>Fixes: 33bb9b1ce6f6 ("Bluetooth: btintel_pcie: Add support for _suspend() =
/
>_resume()")
>Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>---
> drivers/bluetooth/btintel_pcie.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_=
pcie.c
>index 9792a49886ff..4dfd5365bb4e 100644
>--- a/drivers/bluetooth/btintel_pcie.c
>+++ b/drivers/bluetooth/btintel_pcie.c
>@@ -2607,7 +2607,7 @@ static int btintel_pcie_suspend_late(struct device
>*dev, pm_message_t mesg)
> 	btintel_pcie_wr_sleep_cntrl(data, dxstate);
> 	err =3D wait_event_timeout(data->gp0_wait_q, data->gp0_received,
>
>msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
>-	delta =3D ktime_to_ns(ktime_get() - start) / 1000;
>+	delta =3D ktime_to_us(ktime_get() - start);
>
> 	if (err =3D=3D 0) {
> 		bt_dev_err(data->hdev, "Timeout (%u ms) on alive interrupt
>for D3 entry", @@ -2651,7 +2651,7 @@ static int btintel_pcie_resume(struct
>device *dev)
> 	btintel_pcie_wr_sleep_cntrl(data, BTINTEL_PCIE_STATE_D0);
> 	err =3D wait_event_timeout(data->gp0_wait_q, data->gp0_received,
>
>msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
>-	delta =3D ktime_to_ns(ktime_get() - start) / 1000;
>+	delta =3D ktime_to_us(ktime_get() - start);
>
> 	if (err =3D=3D 0) {
> 		bt_dev_err(data->hdev, "Timeout (%u ms) on alive interrupt
>for D0 entry",
>--
>2.39.5

Thanks,
Kiran


