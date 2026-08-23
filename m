Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96380288C2D
	for <linux-bluetooth@vger.kernel.org>; Sun, 23 Aug 2026 13:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787491662; cv=fail; b=XIFlCqgdaxD2V95OBOkeMq0juJY69Qx9ukwaxJeYC6yHaqrzfp9omFf8DIYtgA3LYZaSfMMnqRjTUX92ri72Vsr2ekTEG7JACzzceM2cKdfYT5w+qCLBoDJK3MtmLYjub3dDpGCwpBYFq7sgm3DJ2CpRl0esfZdn8nmFaNgIlbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787491662; c=relaxed/simple;
	bh=VvZdBlxTOuF3WkpE0fgy/YZAZZ/1DKYWcQBduWsKiag=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=hnRFEjQO2dratrIoKG435yDcUVZVvXmx5sd9h4hbQXQYgToJng9hk0MibwRZ5A1y9wiMPsOZCBkGrDbplCVuSF1M+fp8Y3Kho83X8YwLuK5xtP1V1QWMjjSlwhLZF5Vxvyv3S/RruOArSbHNkpM5us8gzL0imJk6mr+E1RzNUYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wh/29JBN; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wh/29JBN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787491660; x=1819027660;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VvZdBlxTOuF3WkpE0fgy/YZAZZ/1DKYWcQBduWsKiag=;
  b=Wh/29JBNAk/BgmrrP7gS7pmSSsPfEgLvibM1UAKMJqPEVT/GsquNLgla
   ZxmeO8A70bDMk7PH2RPwTnMdquPdDgVy3FF0Fgas2p3Fp8SwjCvWnGQvb
   fu4tvM4pxZYpNaqrMRyzSPeMAd2IfG/kh4FbRkIvLNeJnwDJMNWXI9Mtq
   w2MLyIPPhodWuSWgD2HAvbOmRYSnaXqUJz2rRnlfCq9BtsC/cPEvixpsS
   MKVVtH/Z6zOHKNKxuugSGtn1dNOe5q+1xigTv+QhFtsEbtHzkwJiFXQ6h
   2C6YVX+xnIRbZKGkhdEecStyuLsOU5rBF/hzoAKrArq+fpFJeyQMLro31
   w==;
X-CSE-ConnectionGUID: Sr1wZLutSXeAdsUYQbpH3g==
X-CSE-MsgGUID: DwfthvQgTgmeJSQTRd3DuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11883"; a="105339568"
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; 
   d="scan'208";a="105339568"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 06:27:40 -0700
X-CSE-ConnectionGUID: rH6MwFiATCupxDzd4Tb8dw==
X-CSE-MsgGUID: T2CtSdA1Qyy2xxBFoo8wdw==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 06:27:39 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 23 Aug 2026 06:27:39 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Sun, 23 Aug 2026 06:27:39 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.49) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 23 Aug 2026 06:27:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FwwmpmHb3EC2S5uu4YbC37b5SOo8oZtScS/SSi5HxOT33j+ny+yWKewz9brXMIXfww/WCMXe8Q6FaJm+JRs7ajkQqUjMWMc0D4xqcpEt6DwurOv/cde0U8b+UhG4EhISJU1ScLhfW8mN9/MkW2Q4Wp7Zma0bOfelDbeXT8darTqrYTpJqon98FjsBRM5Qk5EFvmJX3z0RIBkkfVAcp3WubN3oBtztJdH0zG7Kv251kHt6uDeIK5c9ocXu9I7Jk0th39/SxYm2oZWQV8v/T0EckdxTuBb3+BBoJi73StIND91/+rWrPNh//A6tfbVDILFKbTooXeVA4yxik1YN09ZSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uL/V4iycOf9WCXeKol0mKDCqsuLYaiUctWVNQbkDu+w=;
 b=jTw8vlHco9ZjYm1EjYg49y9EMW3VNabB5uiORMAnhPffPfsg6teRrCQV9heWAPIpLMccwWVGWgJupX2vxlP2uqG9BqUr1CWq4QYYuYHAAm/PSiuMbWq5PpSD4eiQIEu7NWqFPts8jHUjhpb/TJHLYkKZbg2pg9vLJWr8mXJDnwF1cN4QppmbD4fzt5ftKgyDH+He3S9BSKlC6BiYpLDkJCAvdrD99PpG686NAZrNdAkl8y9QrYwWa32c4DA6rm525EyYigmPrJDWcecTWrFltVip2a55zFccJdCv9CSzEc0aeqW3tbK7WS7lXMVtWK+D7wBenNd5yPVV0a+olyX+CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5214.namprd11.prod.outlook.com (2603:10b6:a03:2df::22)
 by BN9PR11MB5241.namprd11.prod.outlook.com (2603:10b6:408:132::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Sun, 23 Aug
 2026 13:27:37 +0000
Received: from SJ0PR11MB5214.namprd11.prod.outlook.com
 ([fe80::5926:3836:4212:8640]) by SJ0PR11MB5214.namprd11.prod.outlook.com
 ([fe80::5926:3836:4212:8640%4]) with mapi id 15.21.0339.012; Sun, 23 Aug 2026
 13:27:37 +0000
Date: Sun, 23 Aug 2026 21:27:30 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
CC: <linux-bluetooth@vger.kernel.org>
Subject: [bluetooth-next:master] BUILD SUCCESS
 b8d936018ce2b029cd307056078a7802e9420b93
Message-ID: <202608231211.6x6b9M8V-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: TP0P295CA0044.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:4::6)
 To SJ0PR11MB5214.namprd11.prod.outlook.com (2603:10b6:a03:2df::22)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5214:EE_|BN9PR11MB5241:EE_
X-MS-Office365-Filtering-Correlation-Id: b1a9c0f3-52e2-40b5-d0b3-08df011a4c5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: INIll1mYZ6Kd17KeKBcX41ubjXoo7otM43QOwVGxdjRbN7XO02gyn7gsTERO09NBAkfIjoUo+lt/w7e8tHf1tx6O19GEa74Mi/cb7c8pVUZnOP67YzpCecIwt2K4fMVLx6kj4RGVbcP8VYxbFbPAffatqXpemm60FBV+AKVNZpTredzJ0rDG18yTPLB+4JKAT+JSZRsw0z+drFI2MFOjYyQSE/101D+BuyqoKB37jLbCylLMTESlxhP8JwC47G0FnYKP9P7IuywJcpZOkLjrHlOBdbhDbnxF72pEXqOTknGkJCFhLPDfvgvyAJrcLCZLTsDmoyDAJaS18wQvYuSBxsIvwRtlbPR26PcPKhXImnuayWWsiJIVAa8GpGy08cFK098THrmzSDNJzWzQvjCyOj2I3QJLuk5pYba3uIYAx/g/fT/oJi+lUySSvIOi6dKrAbh1+78weJEGpNM1O2oS1UPXcSGEQ+0W/E50B/lF0SHe/e0zJ9lQT47V2cjtud7o/++2wG9ScP3OObyPApDuWn7pVpw0WBrwtBvhXxr9EFhRDu9xpLcN9v3bx5sOPvBkILugATtRJ90FfaUBWdM7VgdOnu79+rZWfTh40gmz0Ozf2jEwNQPYOYnbAP7Gq+4skN/7wf7b8s0Y6GytAch2+KeCjzouP1B+Bn1bF06qsmo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5214.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hExbzG16HDctcT67uOh/6k0C/5O5HzQRfcrl3M779ldSQgUOx0ygKBHwDYrS?=
 =?us-ascii?Q?i4keOCh+aaGF8kZedFo6P/nQ2Z4Wdmpci18rY68lKJMKbjTy+Q1TamtSZs9K?=
 =?us-ascii?Q?mqJB+ctLgwVXhY7rA6SpncnL+45Nq7p69wXQWfbM+Jv5pITn14GXsICaCr4m?=
 =?us-ascii?Q?wJJYjfryJlhF2/n+mxTcQgJK9FcThb3YzhcJfiSJau80HxOwinuTysqRHbsa?=
 =?us-ascii?Q?v5Fe+kY3wWbJYHesyluWsVz8aQuMtGJ1P+LhHhrH3lOurfg80DM1btW37vEm?=
 =?us-ascii?Q?vUihdxJscwSLteX1SRWqQbtj8h4C8GZa3VGDGPZzgY3Tr5M28aP3eCOnLZA+?=
 =?us-ascii?Q?FsoHMPnPnijztd+bZ50XrRqzI4mLJtjD903pypnACFyUglcXcTZMFBysMU8H?=
 =?us-ascii?Q?uxVr5iMaMTxhbqfyvQEIH3v+I5wl2V7vhfsJcRAUbionwgBenbuqg4T8JTHj?=
 =?us-ascii?Q?3eSYkJ5r2+knft1rBE3ottLwjkyVmXhSBDHCvyo7NKiY/88ISPz3ND93o7+3?=
 =?us-ascii?Q?IH15dFkfMNp+FXFZn+a9nu9His7sVRxdwmu1+EFyA26NugUT3dBh6CfS8hDl?=
 =?us-ascii?Q?uJX+9/VQ6dakUs0r/1rEdWJWn//7uq4PNhwXR0Vf7F+yixzCBK4c+HscqpJB?=
 =?us-ascii?Q?FlJdGRhczx4yi4FXy3f0KaG8Mo4rPH3q9QRrShHDTUQMM3ENMFNe5K1Nu8I8?=
 =?us-ascii?Q?fxraBEoIbtClmMlFLb9sL45l8cN/K9yrkpDRQed/ZcmUFuhdXngkhcYZxGzm?=
 =?us-ascii?Q?Dg0LF4mKisgDp/XlOQMB/TnKz6OGnq0e0kUdLMx9iNsYxidju6EBKu6HOpTz?=
 =?us-ascii?Q?H01tUjTpmuqdCLhsU+RuJvA4g8Hcot/t9SRTd+6v1N3XjQ+g8GpHqeWLDBTP?=
 =?us-ascii?Q?gkvVjUMiBTA+y96UjDeiebWPmTD/PPy5i4YNgerzLeio388NM/SweVGte8wc?=
 =?us-ascii?Q?PlaGcVPB7uDp3+i4HLRTCHIYWxp2IzP48hZtYCqznsEn1i3fMGJ7nkaYaDbz?=
 =?us-ascii?Q?qWs06t/iZdt6b8lZpitNwmhxsCGjyV7ht0vomz5NpEvwuB6aSZv1D7uX4D9v?=
 =?us-ascii?Q?7V9xB6BbZ115QaWChhym2m1Q5ZNH0oj1n7bQ7eT6yRJItd+UYcXWGKWKRZUU?=
 =?us-ascii?Q?vxDQkea7HD0mzm7NUvoAfM0WuT385NiA8xf1+S2WFiNmoDSqmqokyq8NEf5O?=
 =?us-ascii?Q?q3KsRd4eqcoJ7fnbHJV/6e2QJY2ckB4g3sBUDzJMhrQs8AGo6mot+U07uPhg?=
 =?us-ascii?Q?Vp7aowIOYsn9bI73y8HYNRjzv5cItev+eqaCPbEQtKNR0f8LkW/pBeGEXfUI?=
 =?us-ascii?Q?7rlqd63UNYFonHqF//k1Af+VDHg3qJVhoVgrmbIq8cFQ8tKVU2ucJfblWb9c?=
 =?us-ascii?Q?kMsw8Fe+RKngVQ1XKkxKsEGhMWR/i75qrbE22jSRXF/DCzf2nkYbypbTGvs9?=
 =?us-ascii?Q?KYqCaCaxa6UxE0nav9qR0FjhBhiPpCkyFZAxjvAOvaAsj1xQLYpxnL6ulzNk?=
 =?us-ascii?Q?8RnJO7UMlo40uFXZXZs4jDW92CI8wn7LfFbB1lNB0J+EXF0jf6Ao9HQlbWVN?=
 =?us-ascii?Q?cJ7knJGZ4JlF6kh+f3hxl8PdVMfIdgltBeCrj6Cyz3/jbnOV5UGVvJA72YBi?=
 =?us-ascii?Q?S1QC3W3sOPzDy/flJPztb0ADmsFaTLXGYEVWHh4uDhMT0q5Exml1oruCnHpE?=
 =?us-ascii?Q?885zH02bzQBkLFNnAdGeQ3sII89ythufBaT5s8uqsRPN6KG9vehYAfgjA68g?=
 =?us-ascii?Q?koy0GBw76A=3D=3D?=
X-Exchange-RoutingPolicyChecked: hMakee8aUYlWipzdTFOCsIPvSu9pYHqzbfqZnvJFooRy5VcYVoDeQYYZ6olZzUuJoKBD+yi/VImdZXUaO7DgAR0WkIPvBLL3s+d5c9IC8rmBjTirkk+k5daWUrLfxBAPGADXVUm4n8+/sRSYM8t5+wT7RTov+vd9VrgmeIl3RUF+NJYhUaH5dOyXIXJ8O0PRmoi9ghhNZTkvu2ELEPWdTWGkKDVbBYPcxMsL35/ornbDounNUxddUxGox75gaYK1JKE3q+22c8OQ/3RenvSGl2DWAyf0JvwzVzQBqFVlxqem4oyJkMLAbOjSTN/UbaqO/WlXzBu/jD8qSg7niZC/cg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a9c0f3-52e2-40b5-d0b3-08df011a4c5a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5214.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2026 13:27:37.3824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 59zOp4C/gThaaH4g9P8fNCyG1iSfZf593lvl+m0L/DNuo8UJ2WVvubBGA0lL8CGxid/pxvZhn1VSFDcR4xYiTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5241
X-OriginatorOrg: intel.com

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: b8d936018ce2b029cd307056078a7802e9420b93  Bluetooth: hci_uart: Fix false success return in hci_uart_setup()

elapsed time: 1479m

configs tested: 182
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260822    gcc-10.5.0
arc                  randconfig-001-20260823    clang-24
arc                  randconfig-002-20260822    gcc-10.5.0
arc                  randconfig-002-20260823    clang-24
arm                  randconfig-001-20260822    gcc-10.5.0
arm                  randconfig-001-20260823    clang-24
arm                  randconfig-002-20260822    gcc-10.5.0
arm                  randconfig-002-20260823    clang-24
arm                  randconfig-003-20260822    gcc-10.5.0
arm                  randconfig-003-20260823    clang-24
arm                  randconfig-004-20260822    gcc-10.5.0
arm                  randconfig-004-20260823    clang-24
arm64                         randconfig-001    gcc-14.3.0
arm64                randconfig-001-20260822    gcc-14.3.0
arm64                randconfig-001-20260823    gcc-15.2.0
arm64                randconfig-002-20260822    gcc-14.3.0
arm64                randconfig-002-20260823    gcc-15.2.0
arm64                randconfig-003-20260822    gcc-14.3.0
arm64                randconfig-003-20260823    gcc-15.2.0
arm64                randconfig-004-20260822    gcc-14.3.0
arm64                randconfig-004-20260823    gcc-15.2.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260822    gcc-14.3.0
csky                 randconfig-001-20260823    gcc-15.2.0
csky                 randconfig-002-20260822    gcc-14.3.0
csky                 randconfig-002-20260823    gcc-15.2.0
hexagon              randconfig-001-20260822    gcc-16.1.0
hexagon              randconfig-001-20260823    gcc-16.1.0
hexagon              randconfig-002-20260822    gcc-16.1.0
hexagon              randconfig-002-20260823    gcc-16.1.0
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260823    gcc-14
i386       buildonly-randconfig-002-20260823    gcc-14
i386       buildonly-randconfig-003-20260823    gcc-14
i386       buildonly-randconfig-004-20260823    gcc-14
i386       buildonly-randconfig-005-20260823    gcc-14
i386       buildonly-randconfig-006-20260823    gcc-14
i386                 randconfig-001-20260822    clang-22
i386                 randconfig-001-20260823    gcc-14
i386                 randconfig-002-20260822    clang-22
i386                 randconfig-002-20260823    gcc-14
i386                 randconfig-003-20260822    clang-22
i386                 randconfig-003-20260823    gcc-14
i386                 randconfig-004-20260822    clang-22
i386                 randconfig-004-20260823    gcc-14
i386                 randconfig-005-20260822    clang-22
i386                 randconfig-005-20260823    gcc-14
i386                 randconfig-006-20260822    clang-22
i386                 randconfig-006-20260823    gcc-14
i386                 randconfig-007-20260822    clang-22
i386                 randconfig-007-20260823    gcc-14
i386                 randconfig-011-20260822    gcc-14
i386                 randconfig-011-20260823    clang-22
i386                 randconfig-012-20260822    gcc-14
i386                 randconfig-012-20260823    clang-22
i386                 randconfig-013-20260822    gcc-14
i386                 randconfig-013-20260823    clang-22
i386                 randconfig-014-20260822    gcc-14
i386                 randconfig-014-20260823    clang-22
i386                 randconfig-015-20260822    gcc-14
i386                 randconfig-015-20260823    clang-22
i386                 randconfig-016-20260822    gcc-14
i386                 randconfig-016-20260823    clang-22
i386                 randconfig-017-20260822    gcc-14
i386                 randconfig-017-20260823    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260822    gcc-16.1.0
loongarch            randconfig-001-20260823    gcc-16.1.0
loongarch            randconfig-002-20260822    gcc-16.1.0
loongarch            randconfig-002-20260823    gcc-16.1.0
m68k                      m5249evb_defconfig    gcc-16.1.0
mips                        bigsur_defconfig    gcc-16.1.0
mips                         eyeq5_defconfig    gcc-16.1.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260822    gcc-16.1.0
nios2                randconfig-001-20260823    gcc-16.1.0
nios2                randconfig-002-20260822    gcc-16.1.0
nios2                randconfig-002-20260823    gcc-16.1.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260822    gcc-15.2.0
parisc               randconfig-001-20260823    gcc-10.5.0
parisc               randconfig-002-20260822    gcc-15.2.0
parisc               randconfig-002-20260823    gcc-10.5.0
powerpc              randconfig-001-20260822    gcc-15.2.0
powerpc              randconfig-001-20260823    gcc-10.5.0
powerpc              randconfig-002-20260822    gcc-15.2.0
powerpc              randconfig-002-20260823    gcc-10.5.0
powerpc                    tqm8560_defconfig    gcc-16.1.0
powerpc64            randconfig-001-20260822    gcc-15.2.0
powerpc64            randconfig-001-20260823    gcc-10.5.0
powerpc64            randconfig-002-20260822    gcc-15.2.0
powerpc64            randconfig-002-20260823    gcc-10.5.0
riscv                         randconfig-001    clang-24
riscv                randconfig-001-20260822    clang-17
riscv                randconfig-001-20260823    clang-24
riscv                randconfig-002-20260822    clang-17
riscv                randconfig-002-20260823    clang-24
s390                 randconfig-001-20260822    clang-17
s390                 randconfig-001-20260823    clang-24
s390                 randconfig-002-20260822    clang-17
s390                 randconfig-002-20260823    clang-24
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260822    clang-17
sh                   randconfig-001-20260823    clang-24
sh                   randconfig-002-20260822    clang-17
sh                   randconfig-002-20260823    clang-24
sparc                randconfig-001-20260822    gcc-8.5.0
sparc                randconfig-001-20260823    gcc-10.5.0
sparc                randconfig-002-20260822    gcc-8.5.0
sparc                randconfig-002-20260823    gcc-10.5.0
sparc64              randconfig-001-20260822    gcc-8.5.0
sparc64              randconfig-001-20260823    gcc-10.5.0
sparc64              randconfig-002-20260822    gcc-8.5.0
sparc64              randconfig-002-20260823    gcc-10.5.0
um                   randconfig-001-20260822    gcc-8.5.0
um                   randconfig-001-20260823    gcc-10.5.0
um                   randconfig-002-20260822    gcc-8.5.0
um                   randconfig-002-20260823    gcc-10.5.0
x86_64     buildonly-randconfig-001-20260822    clang-22
x86_64     buildonly-randconfig-001-20260823    clang-22
x86_64     buildonly-randconfig-002-20260822    clang-22
x86_64     buildonly-randconfig-002-20260823    clang-22
x86_64     buildonly-randconfig-003-20260822    clang-22
x86_64     buildonly-randconfig-003-20260823    clang-22
x86_64     buildonly-randconfig-004-20260822    clang-22
x86_64     buildonly-randconfig-004-20260823    clang-22
x86_64     buildonly-randconfig-005-20260822    clang-22
x86_64     buildonly-randconfig-005-20260823    clang-22
x86_64     buildonly-randconfig-006-20260822    clang-22
x86_64     buildonly-randconfig-006-20260823    clang-22
x86_64                                 kexec    clang-22
x86_64                        randconfig-001    gcc-14
x86_64               randconfig-001-20260822    gcc-14
x86_64               randconfig-001-20260823    clang-22
x86_64               randconfig-002-20260822    gcc-14
x86_64               randconfig-002-20260823    clang-22
x86_64               randconfig-003-20260822    gcc-14
x86_64               randconfig-003-20260823    clang-22
x86_64               randconfig-004-20260822    gcc-14
x86_64               randconfig-004-20260823    clang-22
x86_64               randconfig-005-20260822    gcc-14
x86_64               randconfig-005-20260823    clang-22
x86_64               randconfig-006-20260822    gcc-14
x86_64               randconfig-006-20260823    clang-22
x86_64                        randconfig-011    clang-22
x86_64               randconfig-011-20260822    clang-22
x86_64               randconfig-011-20260823    clang-22
x86_64               randconfig-012-20260822    clang-22
x86_64               randconfig-012-20260823    clang-22
x86_64               randconfig-013-20260822    clang-22
x86_64               randconfig-013-20260823    clang-22
x86_64               randconfig-014-20260822    clang-22
x86_64               randconfig-014-20260823    clang-22
x86_64               randconfig-015-20260822    clang-22
x86_64               randconfig-015-20260823    clang-22
x86_64               randconfig-016-20260822    clang-22
x86_64               randconfig-016-20260823    clang-22
x86_64               randconfig-071-20260822    clang-22
x86_64               randconfig-071-20260823    gcc-14
x86_64               randconfig-072-20260822    clang-22
x86_64               randconfig-072-20260823    gcc-14
x86_64               randconfig-073-20260822    clang-22
x86_64               randconfig-073-20260823    gcc-14
x86_64               randconfig-074-20260822    clang-22
x86_64               randconfig-074-20260823    gcc-14
x86_64               randconfig-075-20260822    clang-22
x86_64               randconfig-075-20260823    gcc-14
x86_64               randconfig-076-20260822    clang-22
x86_64               randconfig-076-20260823    gcc-14
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260822    gcc-8.5.0
xtensa               randconfig-001-20260823    gcc-10.5.0
xtensa               randconfig-002-20260822    gcc-8.5.0
xtensa               randconfig-002-20260823    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
