Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2058.outbound.protection.outlook.com [40.107.13.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DDB12AAD5
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 14:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715351285; cv=fail; b=XdQzACc5Wn0VybK5sGSaTcVbnoGnrOpNl9ryaN4pkpLuCP6MTHkFZ6HIikBR9D+RrXelV5TNLJ264OU3LHc4ZJYm/YUiEz0+7IgmT6Puw+N6R7EJwZy8GU5e2j0xGLlZZaT9Y8kD8sOIRQcPsjkRJv5NHFElgfxE1APE9Mlsz3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715351285; c=relaxed/simple;
	bh=/7dFl0WECU/ODtcjqaDS8FGE/MT4q+u+p6FqCglgz+E=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=b09GI/uVzWvsEUAk+bxnDyZrttNBEAIJrPiwawNJxGNmX1EjJdExJbbq1Lak+dcdZAQ0lvp/uX4CGmNDaM8qykHYUFdCRZ6DrbUmz4yoJP58YULUVru0jpIlBWdfszQK/NSrvFPsjLKclja0jo8vBxVBAWTupqxAxOjjgCFxV9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DktvfKad; arc=fail smtp.client-ip=40.107.13.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DktvfKad"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRacXlkN9AdTtOnXnmOHC0NU+hzfninW8ALlD7EAGhe9Z1iHEQwAOX9wjJb4HRcFPoSPNxlmG79rImhZRZud7H7uLajecYv+/wKXnyvX4qzrP693aZx7ZVHxUXN2yJfiIA0KmeNPDgEWcRS0hi3tubbWsOWbjiWjgjP5ej+6IePRjChcKAfnTdlt9jtkPIcHKiuH2ogSyJNkN5tI43jPF5PqOyk335odNini/CDvRNCQJJ4dC9f+pUESKEXJT2EVAXjgjh7diuA4i6m+okcqS+QFim2JUxwM1ooYVwJ64fsLEcOQ4uMxGo6/DbfV6Hb/wcOdEfnB+lANTemidZhHHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnPjNGXC4tj7Jk8Ixdl7XslhB6tZaqQN7pJPESnDk/A=;
 b=J/Q1HrIkuHwIG3qE/MY4TwlEJy+fdX0+DK6JR/NznqOj9wiV84tBivRNNM+mlJjR+q4EW65RrpEjnqPiPxV0oYDO3+Y5rBmqcyeMlfJEuJ0dFz6qSizv6lPTTlnaUVxtmC9hR5ylZewHBizwvmMwXgOj97m9BPtW177rJpMyLF6HZsOQThJPPLQXYqDYTyJm4E+3VDado3TQk6U34o7uMNCEdKeCHC5sWulNTw3Ydp6XftkdPFkdQkozzt/7dXJpfIFgimgqAOAp8lxQzJfJNO5z2I6awWCr4sG2Ufseb0aXFq/lklv7qkhiTi2jeQz2g0LftDEEhUmFPaiY7T0Uqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnPjNGXC4tj7Jk8Ixdl7XslhB6tZaqQN7pJPESnDk/A=;
 b=DktvfKadZVrCMI0N3sljtMj8bgSpNhfTqQoXWf6UfxZ0D0OFTIdf6EmV/ObbxQnH7nhZKF20YTqp7KZ4k23F2mkaWlVv/UxhGjDWHgrNwAVGT8sdBuKA6h2uwmrO28UwTkYIjVM8yv43oTI/i+lvANnzwwLIGigShi2mci33+0k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB9592.eurprd04.prod.outlook.com (2603:10a6:102:271::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 14:28:00 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 14:28:00 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/4] test-bap: Add Broadcast Source SCC tests
Date: Fri, 10 May 2024 17:27:50 +0300
Message-Id: <20240510142754.3901-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0239.eurprd08.prod.outlook.com
 (2603:10a6:802:15::48) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB9592:EE_
X-MS-Office365-Filtering-Correlation-Id: bbb0f01d-b93c-43c2-064d-08dc70fd64f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iVlqGi7hvhPj8u+TpX403yCuvCJDIaagutNeKnMETV8OQgydi4Oihtx1oMoj?=
 =?us-ascii?Q?QTHEEJyBv9gzJ5FrsDn+1L2uIpL6fPGwA6LPuHSBfgMGl+c6zLykTjVoE8ti?=
 =?us-ascii?Q?CsABUZMUG0owOx68K4zqpW1+3TNvRyaq3I/ng6mawi1xeJoOth/u/3+VFt10?=
 =?us-ascii?Q?Ei36pc9MjuL9g7ViUAWQfkqo0tUfrjiA+5nfFKWYC9mbiPGRXVDjDMrqIiWE?=
 =?us-ascii?Q?g8NFok2TCfEw0fWoVq7nJ/pE+nevmkODGq4EI72kCgwNLTOnang8GK2S/gj3?=
 =?us-ascii?Q?bKrnz+DNMBypnda/Jc6mqTINDmMnR4MfUUodMap0Z1XUTofVDIKI74j1iBpt?=
 =?us-ascii?Q?N4WUg7qSmAKTJCf78/Agg5haoTAvam756Dkg0R8XvvgcOWs01qvpJ4uEyctp?=
 =?us-ascii?Q?qb9s2JzTs13gthk1ZisN345pOVWW+MSXyNKFYaKefP7DPj5a6SLvdh5DLKBU?=
 =?us-ascii?Q?V2xT9xH6TfdVHTFQF2HuDMnHSIpps3Qei91eU6cXfsS1oDn7rup5bURQv/X1?=
 =?us-ascii?Q?B9nAGWT0kT+yUTkaDQfrRDY6DNGmqdLwQfK0oBw7SpsF3dpptF6tL3zCM+Ml?=
 =?us-ascii?Q?b8YR7pvvvubM0eB5/PkhMw2tjP5Tf/wqANbPFCHhuU3Rutn7O6TLP/W4LBGH?=
 =?us-ascii?Q?zEtwccThmZthdSEDltA+8jMPL4aey6C19nYGQe/sEprJPeo3H2ewEn+Vd44e?=
 =?us-ascii?Q?f4XK2/kGA2qiySML/TjZ79PAkC+GS1QNDwjV/D3YQygKwWDTx294adEJhe18?=
 =?us-ascii?Q?l0sHkJVoQ2so/7iux+pJnTIeWHsonLLLTM3GmVYLDs6wTwfwkZBsSe2hfGEL?=
 =?us-ascii?Q?a53Cy1PvD1J5L1n5sqfUmWrTMVtmzDpAIpWnBdlCboZZDc/oNURUjkmJ+u10?=
 =?us-ascii?Q?EvToL1uJlk/FC8IuNaLflXFdi04a5fTa6BlGoiLCoeAFQMZOvOAmMxMEb0cI?=
 =?us-ascii?Q?HjFGVUiVn5ouJHT5aGeaYOiVa5jyPP7gX4k9Qrh8ftFeUSgVGkH8cCgfa3ez?=
 =?us-ascii?Q?t4KfmOgbJJ1XXOM2p95esXA4DGEjCKzfT6oadtUgm/vYsB/evhhGhNPsLA/a?=
 =?us-ascii?Q?9KhCvZBbxugfkN74Ug4VF+0kR0ix4zdMI8e0iLlNJS9mqtw64yrGY24baQPS?=
 =?us-ascii?Q?nlOjmjLS2uQzTd5TTfcDFXPqlA6unuOXy6uTJiQ4x+1ALxUniOaYBbf60IlS?=
 =?us-ascii?Q?qgprWM/wfdH6nMV0yVki6og8DPFenQKdofRVkwzP/DqbRYsFaDvjoGS8ftgF?=
 =?us-ascii?Q?QAg6NmGcFl664P+/g3dqjezIK9M0vaWgkrn7wTsQYA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VCamL0QcQF+Uq2NiMc7ltUt9JPayxcwQB3k4uibnRJ5sr99Q7+5Y2v2oweM4?=
 =?us-ascii?Q?HpCAJrVyi6/7BLALGPRpdSxAtbaEaWXZA+XarmgqGMLAvPDEp8n/2olXiufB?=
 =?us-ascii?Q?mPoTekHHxmXlMoWVCdMe9KO0RCDLPaRGlo2JG3Vxbt8P0mwDgiTyDsa1cAbU?=
 =?us-ascii?Q?L7aDH2/dST+oAnFGnCu1hB1OuPI8mb7n/NK+zs8TCsci1NenEdhy8SNtOafC?=
 =?us-ascii?Q?5BTvgXh4op+6Hcd5ufE8/FMMu5PmlwB83QFoQQgO3dvCjNdPiOXaW0QTnl1n?=
 =?us-ascii?Q?HviOlO1vXaY69HMKu4RGpUXLGIwCd4g46sRcLFLlTVyrm7YvNhVzDoATvUIj?=
 =?us-ascii?Q?F0AST8a3pDJOo/BxPvRZ0TK7hZUy0xzL5cyFH3eni+5gYIWdX8P8+BbMM4Mf?=
 =?us-ascii?Q?5gWyNO8sKiPT7BmhJiigcjqOatvNLTntVcKV9J6GMCz4vLgd72VkGFIMjIkh?=
 =?us-ascii?Q?blIXJglEV85uibzU9phud9gblxayHuJTgkyW63IR/hgpS1jF5exoT2uqJU+4?=
 =?us-ascii?Q?VXWj7RB49Al3cernVNd0c4FzQE2LA4FpB4vcyD5ZmtVXgGryrrLMwyApKjYu?=
 =?us-ascii?Q?yU4Elm8Y93OuwrQqM1vYfK78BD6jE+pdUawzYN3kViXLI/+z7bWNq8ISnurO?=
 =?us-ascii?Q?N/D1BcWroOExiLOFAZ8cyLT0TKVV73qfj9X0wqmVzPba7eYlIVcGnRuO1Ddb?=
 =?us-ascii?Q?pUQ4MczGo20dufo2x4cO74JGbpXJseBK1omivQdsyhdCHLALgMyq0znWEx7v?=
 =?us-ascii?Q?30I+kFHa69zXq2w4Lw90YgNE7kREYQJAqfR3WhKqXJfDOgUGg2eSLMlzH6if?=
 =?us-ascii?Q?PKyZW/kt5vyPNEiEQ+FGAyPz4dl73f4k4MEi94sFitAO+bULP74b46Z5p2Uy?=
 =?us-ascii?Q?pASih5aerW/829IhKDxnJqBJiVs4s/oL7a2AKwPJGNU+DtebrAM508aCpzYg?=
 =?us-ascii?Q?ufSRv6Nz7HOLIP5y/xMywYc6VH2kOIojGIujIqqvXsNN2WcRvjCrYJ3Pl6bO?=
 =?us-ascii?Q?Ea/5st2qgR2gMaE3SBypxBCrBQWTF5Gisphs2o6v3ST2/B+iJi1Q/KMLLZZN?=
 =?us-ascii?Q?mcLFmFoFd5xWmESiUcAeJ8gkSWySxRX/W7mqDgAWoYYZJhKvvmKI8wsbIPUS?=
 =?us-ascii?Q?zKqUFevqPgb6IsZ0K8eKIf997H0maaRpfWsAJ9zgTG3wbHiAxyhwWzB6NIqd?=
 =?us-ascii?Q?TV4tgrq8b0Ei3hwsE8hY59WmUmM9q4LvAmFmPwPLyY0zXFAi3LW6DpAI/Ymd?=
 =?us-ascii?Q?GcxE/P+P0RpwbwsnmFXjALhVcLm4ST04DhoAm2riK15MI3Cj5qHEDn5T10TF?=
 =?us-ascii?Q?eA2bwQdx0qibp/D0J6/wtFGb/gHofAkEi3NWJrkbedz0cOFv81Gki748LxP/?=
 =?us-ascii?Q?FqftDZSoIR5kiqy86gBVFVtrvukSYBPmaCNeYk0OhtlPdVG9lzgadB7yRlh7?=
 =?us-ascii?Q?PKvGNNXWabinHmAZPaxHtE0F1I6AIm63/QH0r2pXnCO4XaE4PKoZXZ5o6YZi?=
 =?us-ascii?Q?sFVH4str3BuDJYicbtcW+C1a+GbvttSftymZrZO7lSimTc0eSYwtPH1vjNoK?=
 =?us-ascii?Q?mJroLw99MN9AkO05hlK7nhmzj24Yw6+om5m/V+WoDgPmRFjPtYNsJ6Zh1Dh3?=
 =?us-ascii?Q?lg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb0f01d-b93c-43c2-064d-08dc70fd64f4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 14:28:00.3237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KnbwLfEAYjGmhp2NYlGki6tfuQQf8Blsf4MfAu8VjdrVZglMwwjLOxorwZiMAQUkXyKUcIlqD9ENnyw8XLH3Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9592

This patch implements unit tests for BAP Broadcast Source BASE
configuration (4.13.1 Broadcast Source Configures Broadcast Audio Stream)

Some fixes in shared/bap.c and shared/l3c.h have also been included
for successful test implementation.

Iulia Tanasescu (4):
  shared/bap: Fix uninitialized field at BASE generation
  shared/lc3: Add missing LC3_QOS_8_1_2_B define
  test-bap: Pass test_setup as test define argument
  test-bap: Add Broadcast Source SCC tests

 src/shared/bap.c |    1 +
 src/shared/lc3.h |    2 +-
 unit/test-bap.c  | 1169 ++++++++++++++++++++++++++++++++++++----------
 3 files changed, 919 insertions(+), 253 deletions(-)


base-commit: f4795bf64dbf8778fc765b7dad1b1bfb365b48d7
-- 
2.39.2

