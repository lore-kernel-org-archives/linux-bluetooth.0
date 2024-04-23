Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D4447A73
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Apr 2024 07:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713858286; cv=fail; b=kEMbULQmYaItDfjZ/AcnuR0KbEmjn5e0S/v/ITaJ3LPDK9mQQprSTuHF7GmM1sABDpUsRxs1s9I4HMKohes+VjdFWZS+5Ylw18pX1PgqnTa0Pn9jhNh22g+CUJ1W9B3xDaCUVxRCdOhPjN0z5uVP49M+5DJDfHokFnfjLjdH5qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713858286; c=relaxed/simple;
	bh=t3rQjh05zt6DsQagQgZQcdlXz0xh+aaNoHOkJ803UkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=e7zxTPYiG9kiyZEuB/XaH7LO/LaRbS2SOQevcpSP6+4o7psmyVbeu/IdNnpjixLyR6tGUScaNZDaAI47PWEsWptOcxGSZiaQo/tZRg2GOFKqBjrchTHxlhsNePZs8PNpRf+eOfqjGUoV13NBDO3ZgW5Ja4xckQpb44UGg0Ypf9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=oE5SThEO; arc=fail smtp.client-ip=40.107.20.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oE5SThEO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7OO96aQaLoP/QRZ+uQv2O4bgTvLS3ZNht6TREqi7zx+TuzMOL1jArvdpUCaf0JDqkxYNyA/tnOELsrGUnQQKir91L3hNaM3ccCVG5dzPkfrCE1a373y9ZaBXfbQUZHc6axFQn4qTk/olztSx6NF+QTD3imWHcKHCnbY5Mt1eWDogxG6hRnlGLCgl/YfXI4qe5BS93Tlc5GidtjVplvjcDrJXeGSBkYWXq0mx+iUYYVtUz9jzz6Wb4DkF2IFmLGTD80IMERJuCGiL2u7Q6EuhQ4nfqI52Jzo6lYOTx0GEL8NJQq3JwtYTyalBRGw3bDZsccqqUDBVr/lGGcgwCJ+CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeFybeu9nC66hu1+nqH8kGVSwL/KoHf49jJmUnt7dNc=;
 b=U+0tPujArxSuGwE98Np/n+2ncRFgdeqmQDn2H1m4keD3aGzh67B9QdHsKutbfTgbR4+9292JR1cYwpgBFjl3/B5qAzBYKq8CPZkQTtfZpQpxYMsK4bN/dBLuSZsDT0FQF9O9+2uyZeIpjHQUWDL/xFreb5d9J0bMWTBZG0HfB2y+5x63IhfI7wGNtS3HBTVHdwdzJqX6Hc/NT/743LqHg9epA0dd3GykU4E/YcxiW/325tCIPyfTaIcqGTmRxM3iN/SdHTwKy5QYzyt02tZ4+PE9lBrhDr+cAkbVr9l11rQiB1YiVE1HlRBXdCywDNHiQ9hIyYiDpAf6P7wpwzjFLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeFybeu9nC66hu1+nqH8kGVSwL/KoHf49jJmUnt7dNc=;
 b=oE5SThEO/SX9HWX2Y04FOIlDA2LOf3LFuaEi/W/dwePPzqrlsT0kmaj+EFuI5uKRc6GAHX8zvVzjfMv21PG9IG+MG932Q549OuJbq/uO3oHRyqYDw2lBQzpH7i0M0XUUHlq4eEP3ekKztTEjhLqjJDzckY9fyqGdYuqpJFGhm9w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9630.eurprd04.prod.outlook.com (2603:10a6:20b:475::16)
 by AM7PR04MB6920.eurprd04.prod.outlook.com (2603:10a6:20b:101::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 07:44:42 +0000
Received: from AS1PR04MB9630.eurprd04.prod.outlook.com
 ([fe80::b627:61b5:39c1:91c0]) by AS1PR04MB9630.eurprd04.prod.outlook.com
 ([fe80::b627:61b5:39c1:91c0%3]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 07:44:42 +0000
From: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: vinit.mehta@nxp.com,
	devyani.godbole@nxp.com,
	mahesh.talewad@nxp.com
Subject: [PATCH BlueZ v1 1/1] Fix null pointer deference in bap_get_ascs()
Date: Tue, 23 Apr 2024 13:14:25 +0530
Message-Id: <20240423074426.62480-1-sarveshwar.bajaj@nxp.com>
X-Mailer: git-send-email 2.21.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:3:18::28) To AS1PR04MB9630.eurprd04.prod.outlook.com
 (2603:10a6:20b:475::16)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9630:EE_|AM7PR04MB6920:EE_
X-MS-Office365-Filtering-Correlation-Id: 20be2008-3971-4f1f-2920-08dc63693cc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6bmyEuyyMN6gavluQS526SUqsGBr0KBDiDmZ9d2yWuPTcI3HLGK3uVAXHnc8?=
 =?us-ascii?Q?BEoJnq/1+nuHswkD9iHdE0EL0wUxWelckBPYxNNQMIN5nbfQNDiHbMoKUmLj?=
 =?us-ascii?Q?qd5y/6uOQJkzlKh02SJ2IwuFfeRne278qbQRdLfmapkK7tv6a5lcI1/l28oP?=
 =?us-ascii?Q?O+ickVDAmfvnZKdCLfwT4YMRJdpx9tBfFqu2LvVxOIfk0vatXm0FYOTuzbEC?=
 =?us-ascii?Q?vmVn8Yj0MKli9mdNLXcDEMeZS1WDXp2Bgg7aD5rz5hDRJw09+itWJ67c0Lt9?=
 =?us-ascii?Q?3IOhLpAJyfPHurzQx6v9Zq5g+UfKTcnjtbiCJrZDSr0rg8KAwdHPNYWw0Zrv?=
 =?us-ascii?Q?w51BEtyYRbfuQ4WfVgnlXRpZN+fKQrWkxB6jTAdB/HQUGPa+PHC8IiZnwDZj?=
 =?us-ascii?Q?PdE3poOH5VJZW5nvBqzzIOE+oSuOWAuEku1cxVfvon1ezkSzu6KcH57swqgk?=
 =?us-ascii?Q?2eAHYdQm+Dq/RnvP5kpx6Js8cYsk/WDERS9m5jehPT4b7fy4pwuJZTsyxd5E?=
 =?us-ascii?Q?Gn/WDcPoWBfEb7cfObJw8RfhnJiUjBd0aUIvfvAn57YnwbKDFxeJ1uLMtqGW?=
 =?us-ascii?Q?4RmrIofjQgffwIEY6NoMc0OWu5tXpfb/k5W6LQh5OBC01HiTRQQNau2QcrZN?=
 =?us-ascii?Q?+dodFga14N78yLOLZa1ZR0WTzV/C+vDSttWlRwqUAnD/ODWO0+CSBI+u9j5t?=
 =?us-ascii?Q?c+FCMiIehS6Jp4VaVVQKhqzFAcdgQTb42aaT4oa62VZFZhKCMNh0uGF4f6tF?=
 =?us-ascii?Q?jrR/hbhZyARNxLP2OYtwp1FNj5ByjO7CWuFeHIr9QPJCpAV6/TuVF8SO1uoy?=
 =?us-ascii?Q?AVh186JCKsbRsdKvcXsXu3lV2Gzqa5vNOMjtLz+4W2fwNtVNiT3cReCzx3yx?=
 =?us-ascii?Q?6dNJ4MMoxQUmTP6neUrEeNCwz1mM55MJoC/JEPQDDY6cN34EeKuWGsy9d0ZC?=
 =?us-ascii?Q?JesZcPj2mm87Th1vvtrWKECE0S6VUkYf0PglZaOyBcvCokOsJw0pBXy9HoE7?=
 =?us-ascii?Q?3wyHBjBBMjLZ9AE+3SDIhY+xftfj9Oekz2/B/9V8AQCPJE2R3RlWC6UUhoNP?=
 =?us-ascii?Q?iCd2xwc7ta0qjP6S0Fs9Pj8u5kFFDM8mwrpzRdRkjmMUt3S1p4OJmqe+taRU?=
 =?us-ascii?Q?XT3DqDLanAurNhWH+0/vceloU5hKWlqUzmDPuY3tdboBivog11SfEMd0JU31?=
 =?us-ascii?Q?3v3G2B2n279URbREUS4ihdckJairA1MFOfKfKWiBs4i+wae826kqI72qiXp0?=
 =?us-ascii?Q?BTMPY1IeccGDCVRj7r087B36pjuKebyYGn7c/gKF4if4krqcmhgJ4U57DLb8?=
 =?us-ascii?Q?2KCvkupLB8F9fFLi7k/UKS6d+ZH/qLsq4HV3+zv799EbvQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tHm8vshlmKaNsJuy+nal6TxDsjiFpYhfjXwLIWslATIymBNRNb3Za6fHD2JR?=
 =?us-ascii?Q?j+iRYprVMMosQ14R/Mreo0PK1pxVjYk/97NYzQtcEP2T3mpPloppR/dDnhHK?=
 =?us-ascii?Q?SrofRuuNvTo4bXDlzqdeEV8kf4t3XjqXXpO7y+NGyTMFTfGdAGaZzTHCuFuu?=
 =?us-ascii?Q?VPOxmLMBpq+W9L7PUE8eWuVahUj7HKWWsMcfhGXoQKIehA3wjGfs3Tqcko68?=
 =?us-ascii?Q?ZTWrHsW02gCqBPOGADDDjkj5Cc3DiRL5zlemst+3WI9EQdboAXv3LfrVzPw3?=
 =?us-ascii?Q?RKLexZk8R4fHyHw7VL1pCsl7HN8FkJnvn+59u6A+oOPSKZMTUVQCGUDUiVjn?=
 =?us-ascii?Q?MVX3+PnGQ+PKf5EwJxlbEwSnWwIIAlxHjP0GqGUpVjqQ4OaoeST2nAvgauut?=
 =?us-ascii?Q?bcNrEgPgFGNsbIl1N1+xfOtRD85sRK4mQlPYhFu3zY0hpvHU/VXbm4NGUDIC?=
 =?us-ascii?Q?tX8hG04QUgqhxTSXb25sqKDHvJ6fpKUexy/XW/YWLRiPbEpY5yg099o/zxm9?=
 =?us-ascii?Q?p1JscJmioDerzJsnt07XnrPMjjEPZebNu3aNTQDCEMbcpbcuFB2tTesgBGnc?=
 =?us-ascii?Q?OrwJx0/6Rcth2QVNfKoa3t2SyhzM3hmz45096+p/YmZAIeEl4HVp/Ag3Rk8n?=
 =?us-ascii?Q?9/Q7c32wMmYw2T7FY0bmOERNEysPz5pdVoYjiStXKXlOri3I6NS46hfaxTyC?=
 =?us-ascii?Q?fz5Hs0hlB98fBlgnLB+2jcCYH+KnCJahfQsSzN6QC4tuV0v3OlaJ25nw2AHv?=
 =?us-ascii?Q?JZN9imNggacUK6JwGJZi8oaiY2//8+LRfc6/JK7ROy946cSxKF80/CNBTuvt?=
 =?us-ascii?Q?WdxP/GSMeIGthI1jMVNKfHG8boIvbz8+nZhmGlcKZgCKS+QBGYw59T8ZsuXh?=
 =?us-ascii?Q?Hhs8IhRw6fNOeZfRjU8OSQ5pZdSC28IHAnp5qtEaYLPDj51BMEEuFUm2NFf3?=
 =?us-ascii?Q?C22rcJE1mXTYLiKMOlTYYE4dzAXUHNR1aHtkdyJAKT3EcAocSzr41VHO9kDZ?=
 =?us-ascii?Q?Ggi+yrCpH2s3ajnLAYMEmeze5QO9h4p0nrPM0Xv21YTtPDXt/MrsZeQQ/yrC?=
 =?us-ascii?Q?T0XductIsTmb7a9ONgE2iJupqBhVn2jH/7QXyY6cH1zoQzo6BW7rTU7OoIwJ?=
 =?us-ascii?Q?J1HhoJJfM/ujoc3gklyWfxVh9sctW8/sQ88VnpICy8OWRfYcnQVre2vK28D0?=
 =?us-ascii?Q?1PzFXCSSrI4LjosbritEMYvvWU2cehvFzyDfSiJGFuqTWa16aTR1yy1TYFPA?=
 =?us-ascii?Q?/dE/tgkJ5N9ttAF84m5qsVQozZOuITaMrYDrKxsMJydlM1xd2b8YAJ5wHbol?=
 =?us-ascii?Q?tCZYAXhbjx89VfEbivvXFXyFEMVgNknG86M+UL2hOW7MyNC3/SevlxHpqeCw?=
 =?us-ascii?Q?B7SCQPcTgK37G0uxewPGqpH4fQAkmR8wgZP09eAsdOcJfDykdRy/4SJEtCPb?=
 =?us-ascii?Q?Ore8W/qMN4dJwd2TTIBC7UJO1Fy7UaBHj9uLKuK3AWRS8foNZsccGvSnkgpM?=
 =?us-ascii?Q?3F7aZPDE0D9T2B+Q9qwjVGIS9j07fZJja1wnSOO84WPnLUnth7xZnagvswmi?=
 =?us-ascii?Q?rU7yzo4LgTYYdojW0JLUOLqNqah7+lqbaFPJvpaYoNu1EU88CIrY2jFVvvmh?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20be2008-3971-4f1f-2920-08dc63693cc9
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 07:44:42.5942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EFOACHfpJHtKZm2RfDX4Fg1P3c5A+YMyGuEvHUyeIt1a3hbrZYcNafxd26q9S0RhkkBnsnNQx6d8mb2x3VU1y8vUiVNdGIy5vFoKCf2EJTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6920

Ensure that bap and rdb pointers are valid before accessing or
allocating memory for ascs. Added  null check to prevent potential
crash
---
 src/shared/bap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 71eadbdb6..0db9ba285 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1405,7 +1405,7 @@ static bool match_req(const void *data, const void *match_data)
 
 static struct bt_ascs *bap_get_ascs(struct bt_bap *bap)
 {
-	if (!bap)
+	if (!bap || !bap->rdb)
 		return NULL;
 
 	if (bap->rdb->ascs)
-- 
2.21.0.windows.1

