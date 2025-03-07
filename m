Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2059.outbound.protection.outlook.com [40.107.103.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36CC21CFF6
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Mar 2025 15:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741362322; cv=fail; b=I9yAbmwnhpolz+i21cMHzGy10T9TMJfJCYhQXJoJzZOe5Vft/5aREDWSwgoB8Ku8m1Plu+CWH1R78kpTBUOOL3wWEJPAZH6GoqcOyNJttNsShYgfTW84M8Qx4OKL/Sfj5O11DPoG9r40Mo6zlEgD9ETj9eY5ZN/ukeSEXVvqCq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741362322; c=relaxed/simple;
	bh=VWmyLK+EYr6DwPSjA9FxGRbV2HXtabPBeSoidpeFslU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TSqWp9VpQOz4gv8aDPcY4uL5qWOl5Jx8FFcgj20CzCOQWZ5aHOCkQz5AOiCU7+64GWjmSqdtSEkpp1s4hhhW1zePPTm9wc3Za5Fc/wyUvdI9xbBuHWG5HpybQn5oYBEy5eHh103X8rLMKii6om0+hHtfBHQYemCAaYBCO/uUlSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EcQBApd0; arc=fail smtp.client-ip=40.107.103.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EcQBApd0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8gRFuBngsNnn0WhunYB5XOaltZO/4cjYp36D1d4+uHShutIgEGnOMUb/5T+BPmqQOZpRx4kftEdU8mv/kvsmSbjxqNhhTtj3YWp8d9atpjAfe0TPB+j8vR5FXQ5DvRJrbPLP1RSu1UcRl1QzgU5F0ysdJNPVAmNVklsKXhfNHgOcNGzFd0jAlSWdVjJpi5/Zn43faFGRNF+izgPYQ5vtmABfpvx1sRyBn5GUteAo5NmeDUBWhaFIPT47enCoNKOmfdrCssW8xycN6jhwcjwv40Ay0H9hXzh1+QLZgadNtfBnlQfKQ6EiHamsDIudyBruHCZjr3K3a3KCJdH6hl4iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jm2k2N2pQIooaCo68VJHCvIhVdgpaHjObFYoQ0C74Q8=;
 b=MjDlx4ttr6AgYiM8FhErx0k/HHjn9DPMP8FDvrREz5a6eFE3PvF2Yg2+q9Er7yPseVxmpPFe5JVPJg1yEbB/6gYULwBWGFMXE9+NO2zoIbHgDRApeTYS4JDK7wPZEMa6o/AjAYoVQwc3gsp7Cw06AEmcV25Ss4ULahGfwrPwzMtr0hIiBQ3I0ZSBDkc+PZIovu9a6TVJRkAwWWOlQ2b7dPF43PO2a/waGtHX+vlZszqpxZXUnjCiuvG13rYw6ZPijSirlN+n5fWpesy7XE0c79PBJwd2yh+IKeYc219bFtBJClK26l+0JrDprmjpbMETBiZFaU1E4viGPcZ7pXaIQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jm2k2N2pQIooaCo68VJHCvIhVdgpaHjObFYoQ0C74Q8=;
 b=EcQBApd0BgbkU3OlMrX7PWWo75enoMEAAfqWXNxPV2K+N9zCh+P6RTMEO8lwz3Vo4fCeh5VriyX8hROAt98uJzjC6/+wXpWzIfc4H12MXpzAfOUMrgfBp7sK0qapNve05ppfZpymDYxoFccBlBretSjFRGbB3/Zgl1nqfUL7hBD+ZhnuM03uomuZA9Pg3FZ2YFa3yjmgTsZFOCsImpdG5Kg7WV2hH3TEi/QEqQBLr1mhy3NN708iil9gWhAWmgpdnUhbuN+TI2DPgFkEtgv7IDQxF3cbKXXkOc8ouwu2iefR60U5B9rkymJYsq+ybWHr7ray2yBWdpf0fRKDI0eaEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB7727.eurprd04.prod.outlook.com (2603:10a6:102:e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 15:45:15 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8511.019; Fri, 7 Mar 2025
 15:45:15 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/6] bap: Remove interface
Date: Fri,  7 Mar 2025 17:44:51 +0200
Message-ID: <20250307154457.85751-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7a::18) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ed2f69e-3e3b-42d3-eae7-08dd5d8f0e39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vn5M2KC/lmbhuIySNpR4E7tNpgaw7FInoZt5YkkILG6+WTt3lLCKsoDu9hWc?=
 =?us-ascii?Q?1mPQM3u8Y5kb36vEI7mGPyagEPyK/OA8/Z1ifm5BwMCd529UTn2EaoPD12ii?=
 =?us-ascii?Q?kS9jUE5czahvvudrJGYkWG/6rLDY+OwGgNzutCJHgJxNh1RImYYe0nRzG3oM?=
 =?us-ascii?Q?mlLaTYZ1SA5v/b8MT9JgbzCTA+ONK908+29q+0Q04cgbemq4YyX2vE18VOpp?=
 =?us-ascii?Q?M49GdarjyLK66T3OL5aFEbLsuiF6fWJfxesnhnfnnakQkkblKsyBr72d6529?=
 =?us-ascii?Q?7OHIv49iVHneOS0Z7b/pHSK+X7LYebLmG2xqdCu720WCtrOV67BjtXKDdAuY?=
 =?us-ascii?Q?Wsquj6p0XFKYkgR+IQoYYvjkvS4lnWvS3cEadKcAVIcv1inbhtap9RbafjF8?=
 =?us-ascii?Q?MrJWDpGuE7Ut0IUxUNri3zKCar6E1o/rF+Zk9tcIBrGYUhG7k5MNwH38/WGB?=
 =?us-ascii?Q?R3bdwJyF/hgpi1JX/ooJJXZJFIhYurWPQgdl46vWZIys2Gdqb0nbtqHOn+4Y?=
 =?us-ascii?Q?o1sPlTnvVImJK+HJcPrVAeRwH135JEFhlb/d5NMc5WgYt4IvApAmHhzqFVfV?=
 =?us-ascii?Q?BZGELYYdUK96GTkL6Yjk4X/uZcGz677jyfnBRBQgdDipGABwCfBbNAaGXSxp?=
 =?us-ascii?Q?uj3PcRApKFJuIJgKVdw+n++QNO95TREreoP+/1nlmBgr1SCWJKQjM4uNo7Ht?=
 =?us-ascii?Q?9cA7UxZXBIvM/oxfOWC8WPfz06n1dDNDBsChGvNCYIONstRJylqVwA5PaSss?=
 =?us-ascii?Q?TB4kg8fMFXM2h6CsqOzzGSVTugYq/RtmYEEHvHm0kikQ7aS99yGywkRUudNG?=
 =?us-ascii?Q?NK0AnVHxVMvlRxzUFauUwttdcNVuLSR4/CGXZXzdjzDPovaB8Q6hmtrws/P6?=
 =?us-ascii?Q?dM8rNqbNJOxWKQh1hVmPu7RBLTKFTdRnsEW/4OCmZM5SBv0lfn9uGFEIce6R?=
 =?us-ascii?Q?xRibU9/aPd2CQZzSOzfaRnbJ3vKs4mTYG9RP5xH22AmmBMZcvXmpNSe+TIpT?=
 =?us-ascii?Q?qyrqvN3YYxmgY/xMDmdMVXuMlW3EM3RQ0uM56Y2vAJDUb7up2et/yH/tcBef?=
 =?us-ascii?Q?TvjQLtfvk+gU3+jGxrq/w+goJ1U9scp6sJ11duOcljs01837lsoXbNvC1y2V?=
 =?us-ascii?Q?2D7/xpkABHFoDpBie2yQ6Rv+S5NoOwYLemnVP+V8RCfiPvX+j3e/9lfUWK9L?=
 =?us-ascii?Q?r8CBQi68Ob95rn5fBvmscb7EdgMZjH9onwCOU290GXCPYvH4TpU0AePQXoe6?=
 =?us-ascii?Q?TmzuaP3603Rleb5yhfgbLtGBFeUV3xjo4Mpu2U3eOP9WDF/e1lXNSWYhSElT?=
 =?us-ascii?Q?LvpUME9Ez/Qd8DXETbH3Jf6ex8ndySsthTChOkrhxh+p9iceMVxdIOTy99R5?=
 =?us-ascii?Q?VYuJ6anorBq8fD1JnGEqnZdK5ozj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sbMalaEz3ZVFdwBNk9lPHDE+4HNPlWwDn1e/tfp0ndbem+CUv0xqsmA71PNt?=
 =?us-ascii?Q?fvXrY7j4rLA86XEdMwo7fDA/zTHb7FBjTA8ulkEDSCmwgEbeoOlMKKxmtWjV?=
 =?us-ascii?Q?3Bmqpi9kXVGXvFeRHIfVYSfPmKIyq0eWhF4C1SCyQMu0XVZW6Neaej9By/a4?=
 =?us-ascii?Q?ar6pSWPoGa2f1/cT8Q15bbSz7+9/lxFw2RhryzeoV61fkCLtK1JFQuya2bQv?=
 =?us-ascii?Q?tvDJoyV48dt5yJc7vh4BtKORiqqpFo6hCsDUD8DBGlEVmLdoSYWDQ0yyI3i5?=
 =?us-ascii?Q?yQHoXdiHPwH8wnYiDB+CJ2rYk6611PoVSRi2bk3p/vZCOVrRi8FdSHos0x0w?=
 =?us-ascii?Q?k3zs/8TFnXfmAtkfgkuWqiusTXTj9xj4BRKBRefNtKogmnu01hMc9Ql2r/bL?=
 =?us-ascii?Q?a7MqZxcbz51kpp4YCbT4xxrYEXu9d7TjJu+o+aS6nyTfEphWucMj23Cuhmnp?=
 =?us-ascii?Q?lyyjYYvmCUfNi6cpkz/wu66smoMRmhkqlneR73uKV7IqQj+B1uy9TX0QDwSy?=
 =?us-ascii?Q?o3D/yWogcZLP19dsrvdagglhrYmapF9kIlKdLCCZMqh7ca9GFcRkc/2jPWLc?=
 =?us-ascii?Q?Trv041C4DT4g7ieLd8A3SDw69WipmJwUYmuLyqjdAGxRbsF8cFLDBz6aOb7s?=
 =?us-ascii?Q?yoEyKCsrEAZb91V+Gq9A3RNk1aKrn1nXFUFKfP8ifXEMm0jXwbOTI0OUke9W?=
 =?us-ascii?Q?ze5cdhjndJoIYtcQzYPsOpAN5x6uXXf/e5/5/B4r/Ff52ErlkIlpzvJVNsFQ?=
 =?us-ascii?Q?kf7OlQqV+L3lvrhn8gOMUVBuND4+YGHKd6QxvHNrBP/EKoVTvhW/X9kfTe7b?=
 =?us-ascii?Q?MpHzKFcmdcimSFDF4/cKdD+pi2fdeqke99x/68PPJ4pWdoVkr4PXVf3BEsMd?=
 =?us-ascii?Q?Of+ENtJxLasn53EmoVxEq0UDhu/HFIw3+lCLKctKatVuKj8d/zW35WmbeFjZ?=
 =?us-ascii?Q?ZD3ikTXCsA6nDumNDZjlHeqaFW2LBL3KE7XPPvzwoZ+QTest7AoPxY/joQax?=
 =?us-ascii?Q?bgXkmPVp/XIiF2rxDQm/DUnAVRNQUYFQSbf8W/1DDPmwOLTQBWBRWktiR69p?=
 =?us-ascii?Q?RlEOXKk6ZV6DXeHnu+vc6nuzFRQycxUQd1bqOcJT+vGgCbYOwfZkmxf1z0kB?=
 =?us-ascii?Q?Jd/CYiejEHqfsgMZKKXiaWunQ+EpONWS34rK+pU/8aFZNmXPlGZ0+VNZCjJP?=
 =?us-ascii?Q?xfuiNO70Ricxv/2HzbJaUezoEvgRTw3jqwmE9qg25Zi4453EZqVawaF6DR/q?=
 =?us-ascii?Q?76togx89TAyy9POtfWV2hIDspxpRz/nVc2juOdULx0Pd14r8nHl+Ms00vviV?=
 =?us-ascii?Q?99vHpSMQ6AOJE9OAiSlr/NBbuof4THMHFq0FYz03BAItiD03sta0MX2Bf4UB?=
 =?us-ascii?Q?gMu3BvML3pOtoOO99JOkDB7hRKN6YL/bjwBNZPHV1dxJ7vy5oeRsxfLUICc0?=
 =?us-ascii?Q?YXg+fdb8GXtmiu8GwqXxmuY31uaaWjdnGbKemhhxWKDVWVQnaH4CrX0Wvqjm?=
 =?us-ascii?Q?pKeJ19u1WOnL7BsgdENzodvYNaGWB/hwqDwrmwjvAkNfEkZ9EQ/+ghL6tRXI?=
 =?us-ascii?Q?za3hRBCrNMLa64GImcAARoc2qk+3rLC/R7l1u0jNTvDy0UDmQaMuxuBg9tP1?=
 =?us-ascii?Q?Ag=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed2f69e-3e3b-42d3-eae7-08dd5d8f0e39
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 15:45:15.8451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H1/BsmvEpaEuDFG5uHLx5WHMxYfd6/UCZE6U96JTngg9S02BgBtsan4yeHv/2gVc9GpDDP2ZtwW5MtDWNWqzVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7727

This patch removes the BAP plugin interface and moves the required
APIs and data structures inside shared/bap, to avoid making calls
between plugins.

Iulia Tanasescu (6):
  shared/bap: Make bap_get_session public
  bap: Remove bap_get_session
  bap: Move default qos to shared/bap
  shared/bap: Add APIs to convert iso_qos to bap_qos
  bap: Remove interface
  bass: Free stream path

 Makefile.plugins      |   2 +-
 profiles/audio/bap.c  | 107 +-----------------------------------------
 profiles/audio/bap.h  |  17 -------
 profiles/audio/bass.c |  16 +++----
 src/shared/bap.c      |  99 ++++++++++++++++++++++++++++++++++++--
 src/shared/bap.h      |   9 ++++
 6 files changed, 115 insertions(+), 135 deletions(-)
 delete mode 100644 profiles/audio/bap.h

-- 
2.43.0

