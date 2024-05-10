Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2043.outbound.protection.outlook.com [40.107.13.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994CA170886
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715351292; cv=fail; b=O6j/80t5KsKcb2clchuPZtu8IGJmboe4NrRiCjHt88Q0bfhDceRHVXeq/pgMqOW3jlNJJTFsUw/7DhKVnCSen/b9uPv8aXEZi0A+ZbKviFRnUjDGT1KCYmAZPWDzU0vs2DvI3TF3iyx6ha9s686QD4vWAQbOzwr2+FHshylFDow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715351292; c=relaxed/simple;
	bh=48RXrvNy375EeYETYM5mPSOrNGDt5z0GlW795TO4Iz8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q1/1GBqtqQVM6aUa1FPEhlvfks2LXgv5dvYCHRiM43g9z6/1VW3FxIXltBXDJQrRK0PDhXtJI/8kPEzQQCpelj6zIs0S4pqUYgVrHTbK1FSydLYoVpckNjAIEMAHLXpJPpv7OXo1o0bq4R6z6k4hYTNw4mt1ZyG2nPGnZV6Yr6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=iILP+nMf; arc=fail smtp.client-ip=40.107.13.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iILP+nMf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqedJOjLtFxi9fchtX2RxRxEX6GcA6Sz2wwZua/tzWpF9Az1EGj94WldtCw3cCJ7daXLC+p3wzyt3QKkwDzJMXnF7rpQC5EJ1+PkoJubQwW72yAXEG3+o8D7ZyCbzRqhr2ITJ3cSyucPY6T8/8lGgzhQZCsW4kAAIMJ12iyRcTtWYNJkWp9rov5MCeTgS/QPeAAgF3hbAygHu9ev46mni7A19bfrC658JwPC5ZnJnZkic8OQrckBc8IFY5oH8xFkh+NpIzcmVPU+7VQlEvY/etpWDkZP8C+UXIBsjRAVFm75PB3r8cODXfQP01oFhycWK5xuEL6yhfnuloM3X7MCpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7IgsxSrztHt0gsfJWJO1PUV+gNRseW5zhxrF8KNJgY=;
 b=NbcNNdmvb3lZa8Rpd8LnLGk8WIoy5owTKZd/GWAY/+/mR3MJsjk13EmOkbUnw+4yQN3zGsxRDOS1XfUNcXzs1O4Z8K9G88wTaibODbsa8IfwqATXrCyjvS3Eyy3lYyC50yXZ0HrrJztcEzSDZQ+x3jYLvwwbzTN1byCHCfG82J3Qiyg68rdP58OGosAEGg+XJqn6jBCu+U2qc1ZPWBZ2IZM4FgsJ/hXHPsMHEUYXoyQH0wTckvjQSEMvuNeNc66xXbhcgH1njZAdWjHNSHaG8h2BWRCaKLPmGp5Kx2GpynGcGYTro6cMNUD0mJOuLSJmK0ce7EwYbXc90MeXb/fRQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7IgsxSrztHt0gsfJWJO1PUV+gNRseW5zhxrF8KNJgY=;
 b=iILP+nMfgCg3IfFD6IFBxCg8yEncddVKidmiK8c3Yt0AWLektBLAcT2DXM+SH3G4GrTeLEDaUpkQJEjXsQwTv5q6OllMKv4wxp+qPWRqRW6lgKftfmosLtJ5krgby6yLVKyzGkI3gx8syqIMWR1ahIXoGdX5aNfE7yiePdwRlMA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB9592.eurprd04.prod.outlook.com (2603:10a6:102:271::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 14:28:07 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 14:28:07 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 2/4] shared/lc3: Add missing LC3_QOS_8_1_2_B define
Date: Fri, 10 May 2024 17:27:52 +0300
Message-Id: <20240510142754.3901-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240510142754.3901-1-iulia.tanasescu@nxp.com>
References: <20240510142754.3901-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0216.eurprd08.prod.outlook.com
 (2603:10a6:802:15::25) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB9592:EE_
X-MS-Office365-Filtering-Correlation-Id: 433d0e9f-b9a2-4bca-d0e2-08dc70fd6952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iLgrcYCJ3Ioy9Rk1QKxwvhOOzNdXauFXOdpEzOx+RgqF4KQu5OQ93vZmAwFH?=
 =?us-ascii?Q?JwNx88qKQuo+MNQFMAAJW2iLzi2Ce7PCxmsFYFQnxFarEIx9OszUnFd3ul7c?=
 =?us-ascii?Q?g3fmbzmcWE4aVEXC1K144H6D4MlVNNR9nFlJ1ZKDp2MGZcQ2D0iOqMGCVwCb?=
 =?us-ascii?Q?6/0BzMfCk7sNDAz3fFzIAaenXqjenPFWr63J/uIUaX3/2Nj9kVoMC/Y2/apv?=
 =?us-ascii?Q?5vaUHDbj+PjXTs16fs5AVaAYEC3NvuXdbVnS7sQmFXJOhmyUOdZoCOT5ZWOW?=
 =?us-ascii?Q?leb+26/lwXbo3dmW7elH7LN8T5+X5srHhe6/tr1FWXP+znSMSJaZw5wxlwwY?=
 =?us-ascii?Q?UbOAk9hoasySp0U2Xp4feBLHImElkl+JmdyukGaO+B8DJ7/LqeSBK1RyH7zK?=
 =?us-ascii?Q?iLALBUGes1HeLCMsnScRQaeNQE9wN5NO+pxOMMrkg5QH85RAEDXLqe6xDRtF?=
 =?us-ascii?Q?9RBor5dvdmDAOgT7jkyt/eKNtaE63EPbCm1jK28muFK/+ZOv6/Kb/gMuFZDW?=
 =?us-ascii?Q?IhvkseV21Wq1fJAe6fS/qeqDLTyh9ynEgS50tNAsbKxkw8OLEj+j4dKswwwU?=
 =?us-ascii?Q?aX04E0HDt38H8f+jN23S8rCMIul5TVuWKIDr23gC/o7aSiwJI52YPpnW5lcs?=
 =?us-ascii?Q?62ZhTkYCSrrEElbBQJg5z4/0SV7936fWqi5CyzlTPrw23WJE4ZO7F4dumswg?=
 =?us-ascii?Q?IU2yCt0zizjHaSCgin3p5rOm6+H247H77+841UposMoCoVqS+p7LxNy3fcJH?=
 =?us-ascii?Q?PJSu5naXKsOIBvVwmmxKVmqMz5XZL5+dNAIy5B9WZ18tuht1epa1XCOZVVfe?=
 =?us-ascii?Q?DVz+2j7IH3i7pLYQdF+gS+gTXto6ZMMeqjaZ0zI/xD8uCXkY3SBFeO6NAer/?=
 =?us-ascii?Q?Oaxm+dSdDYFArUIH8Itz/1WhtuNgiBsA5WwwDnRbmHuYhus8mBMkLGS9FhbZ?=
 =?us-ascii?Q?v+D8E6DvqRbyejOZjiahHuwZ3sQHUtaRU9nGHexNC3/h8g+Xkh/4Dk67p9yH?=
 =?us-ascii?Q?ml5UjYQMMzwNvRGqmAIIQKpxwUz8A10haFT+Cp3Eih/QV2VVzoV3RdD7g5kF?=
 =?us-ascii?Q?Szka29hLLq/X7PFJQHWmqeOKr1UTWn/XH/8D2UK2oNZ1cBSbTGi8Y63JUdOB?=
 =?us-ascii?Q?boGFxckCau2+Rz5OeDpsPXXA34Zmol6BoqsL6n5wiHNmPM/ssGAtENPQ2T/9?=
 =?us-ascii?Q?ZIlPPrUfCyScnBZzjPtYwsuOSW0HyQcfX4uBYD+BPKGLUBte2OwvRF1Q+uIx?=
 =?us-ascii?Q?6do5R1GPOK/fK6Fa4Ju0qu+A6FCHPV0yGHyOcZC0tQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lyPkPAmwaAF0Se/fICLLJCGgCZ394RiVxV7Bd37zDazbnf19vNfgucT1RVV8?=
 =?us-ascii?Q?62aBScT8EtuT/30fGNSKcoZmzWC8zpCUSgfEZ6l2fJBS6MfixhOxU1SUHTsV?=
 =?us-ascii?Q?R0/CSpmlrSjQ7svXYLam5iLlUySUB/Sq8K4BjcCXdv9Rr4/lj1ACSibi+RQ3?=
 =?us-ascii?Q?WineIkT/4zQNCuLEeU4WNGC3QCvLa9s8nnph1qGbBvX2hIGJyNrme6HvEpZ4?=
 =?us-ascii?Q?BjD8xBTj9X/JqPmFV5UL4TG1oKs7RL38xQY9Afr9K0b448CDjuVrK8U8j4ZO?=
 =?us-ascii?Q?AvSkpckiBmWdhqqF+r82Pwrgje05N3HOJ/dKz8g2SmuFQ1dBZB8CMy+r07Gf?=
 =?us-ascii?Q?U3uVtBetFbWDDVJplCw5gReE0vLqSgZI9AL4LQ8vgEn70VoL7wZFkmlEnvU3?=
 =?us-ascii?Q?6a3pskOZR2Ox/LxGSFphSFlqzsxvWEaVK1Y3UZ1UFmoWDvcOhUBvWIvJtXZo?=
 =?us-ascii?Q?v7VDcTtNBE7JBZPQiKLZC7nL4qCMdNwc/H58m3OyfbI8J6L7kUQ+leyNY47Y?=
 =?us-ascii?Q?/iJNyompa1XgeB/Aq0wy5LhKDciDOR9DSQmS7/wKa7ySx/Y5Og2sJahA4DeS?=
 =?us-ascii?Q?u02cpSzqc8jbdyRs9YwEjRizITWHOKdXBRVQLdZE0RypPvnoWQU27jOg3VzO?=
 =?us-ascii?Q?R7CBp6FQWCUduwFkfk5Og8/qoi0/DF6FHRi/07nD1jxHyXFqFrMSUztq0Ohs?=
 =?us-ascii?Q?bZcxEy1GRG6sfPlbyqNCVSgH1txcUOxvdV9zYYE/1yKWm23GcmJPoDFO3sA1?=
 =?us-ascii?Q?4r+0V7ysOy5MdCjNXKBisrWyEKBNasrIAILyWy+TTc+6Gmv2FMVvBkdTor1j?=
 =?us-ascii?Q?8gkC5zZNeSq39D8cQFwNZi4+bxh9YQ8YTJiHpdu2hF7POI34I2LDUC/ms9AG?=
 =?us-ascii?Q?iORTButOzGsaZNQmJmvCMzW0w7s9jiT2b9mscBmT/anjCJpytIWak0YYGM/0?=
 =?us-ascii?Q?AIZlDaXqB5iPOCCtMY5Q+H3dZjLXal2/g3f82K3gKwfHxwqcVIYuy6b4ukdR?=
 =?us-ascii?Q?YbJCx60sRbWesB4OYA0h3M5Q4BLBxALbaZ+LpNFljURzsFLwLYatQChnlNte?=
 =?us-ascii?Q?mYfutS5voGV5p/VlLslZ32V5AYBe3qHWt5S5159CBOazxqLUIQjg0g+QwW3l?=
 =?us-ascii?Q?AQ5BVgpem+SWIMMxT9KO2wR761s41doEJW7R8WXZMmE+plsIhosa64w4g389?=
 =?us-ascii?Q?2Aa6husDBEGzQciqD0wjhIfK4By9o/OB2iiwJq6fJC+EpkA6XLg45H1QQILf?=
 =?us-ascii?Q?c/AjutP1rgLVlqVSecE8Y4e98jLtGtJkdU011XON1KOHbAsqZcMjgndIeb9c?=
 =?us-ascii?Q?CTxXZGb/H5xRf6hbl606MlSBe4vGr33FbRhU7CPMxr8v6wbU3i2CRtE6ZU2H?=
 =?us-ascii?Q?WdhOwgSmIN3wIesArrMKg8njZtPdJFhi5EFcvxkD1WH2iu90ZadUZSIRk36j?=
 =?us-ascii?Q?FAOEyevVRuMENzsThBHClEy8kK1pLCV2i8fLuXyPXpmq9qpNmVU0Hn0qKpPy?=
 =?us-ascii?Q?abQe4cfF/RSVBMislWAvA4Ins0XvPlRVmxK4c38SBZmZOdXcT072eOx0qlZe?=
 =?us-ascii?Q?BV1pSUDn18Ba5Dl158NNh03/jqGFSEx7dx3562OJlKtE9CPQC11kMuaAZAdo?=
 =?us-ascii?Q?3A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 433d0e9f-b9a2-4bca-d0e2-08dc70fd6952
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 14:28:07.7257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5WL7UK7VtDPJyi1nNIA5n7i+cVx7ezMKxgvV08IW4apQKSuU3a379AU2ETTt8cOJQAcX5G9M7u+xCDdz9JlsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9592

This adds the missing LC3_QOS_8_1_2_B macro and removes the
duplicate define for LC3_QOS_48_1_2_B.
---
 src/shared/lc3.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/lc3.h b/src/shared/lc3.h
index d74412719..95aa21702 100644
--- a/src/shared/lc3.h
+++ b/src/shared/lc3.h
@@ -769,7 +769,7 @@
 	LC3_QOS_BCAST_7_5_UNFRAMED(40000u, LC3_QOS_8_1_2_B_LATENCY, \
 					(_ac) * LC3_CONFIG_FRAME_LEN_8_1, \
 					LC3_QOS_8_1_2_B_RTN)
-#define LC3_QOS_48_1_2_B LC3_QOS_48_1_2_B_AC(1)
+#define LC3_QOS_8_1_2_B LC3_QOS_8_1_2_B_AC(1)
 
 #define LC3_QOS_8_2_1_B_AC(_ac) \
 	LC3_QOS_BCAST_10_UNFRAMED(40000u, LC3_QOS_8_2_1_LATENCY, \
-- 
2.39.2

