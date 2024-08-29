Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010035.outbound.protection.outlook.com [52.101.69.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8100418E35E
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 09:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724925171; cv=fail; b=sPGpjOf0n917b7uYyTKfRZX7zSRCCmeEJhGwqmbOxegb7FjdmXl/a2aoOx9RohjkvqcK1GfyI509PutHMcyQKWgGb2jQzHI8HHnMXdvEwVZtPenL1oDepT4XoMRC2uJohTMygNAualnolJNn3UWCV3BilS0qJvdfGl0SRUGUuA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724925171; c=relaxed/simple;
	bh=cBh8JA3exI/pu4B6FF0fELAZEPkTKtmCGbNWIFp9sWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PQxZ8/emnH4GEj9Z3+gh1ciDT3OwYAc3TqRyDDBgLM+b58ZfvrYUyaGxo+WLEFGSNcKE0qSbpNJd5esFQvlBGYI3KwWp/2l9m3vAr7e7Cgg226V4Bl8qIWBHz6GOjmnHD30FcC8zATMFEDFOHscq8D0zs4CYhjDhbbIaINewo9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=R4oxyeEd; arc=fail smtp.client-ip=52.101.69.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="R4oxyeEd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hhuirpbts08Hpqk9BDBW1wqAYxd9bkZnKtt70QbOC6zYSs+Ym3LkBaZ54KMD3KwoE82mbu8tOQHVHtF80j5tFMGZR8e/FMTHCGVJcHnCsj2k0femm0t/uKXTzwFSsJ9LgmK230iKdXzBNpqwtg9wChvd1G1XQ7PmXE1pzhxWvVgGwLYdtVVQKv+cfy9YIFxx3j520Tv/ssvWWW4AlEO/tWcWm/VbvCvu0BD7yQaNR1R/9aIf7bxwaDT0pOTVtnrjXCc59XAwv0QuKxyU/zXDP4bwQdnU4tw4r1Lobo1QsAT0IRsOdlvxwL32FtZWTku+IwlCidHTiycpVg5xpVAgMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0OFVizNoRRLM7UYnGeILsQoFo2SDruFPXAMdnn6wNk=;
 b=kb/o27A7/078t5EkaTtgflJ7DlVGx+rgtzGTt8ZgN2uNd/voTCK9PkFJu9DNBYolUBhVKOtBj1x0ZdZtz5Pcq9tieOhK0Maj8kHjVuHsNzokOz0eiVa9kJNzTfw4+wvcgTmqnGRgL+WWr35c7IHOZXEXUgMr59r6iHY8zBbw7HuoFY74r5Uido3vRCStKqTCw5HEo+ym5Auu3bFyr064uKqndryDDQ5vqSpXeJUHeCbLGJgOjMK30TIZQexZ9Y3ONhuxqea0e6QKU5vRd4NJ4zAb+Ll9PCRGUTGoEQvjsgE48t/G1YHMnQMrg1ramihzWymgOggKYImnIVvO42VdJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0OFVizNoRRLM7UYnGeILsQoFo2SDruFPXAMdnn6wNk=;
 b=R4oxyeEd34EmDWJ67ddaEUro8Jx0/ihJBjWhvwtK0JqiouOH2EHjSOjY0biPKA78H/HeukhiAZg/k8UVuP59U6fpIVw9NymExH4TrkyOAvnFpRQgHVuIoy41/DWpWrUzd00AdvvDm18Q4B6CQkksFcrb3nyb/YoLDJs8lWEuhS6Obr3na7HUwr5gfj9lb0TZWOLF3JUBJtnisU3tkbzj39TnOCeII+GI2mQzT42RyHDyB/H668EHufVmCu0MIrbuvegzhj59v7e5snVvV6N+44tARbjfrAaUAaa1ETyb2AXm+QROppIKZhw2eso9efoFYHh13bBUZWg9Dnwitze/6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by GVXPR04MB10381.eurprd04.prod.outlook.com (2603:10a6:150:1e1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 09:52:46 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%3]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 09:52:46 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v2 6/8] shared/bap: Enable set qos method for BT_BAP_BCAST_SINK stream
Date: Thu, 29 Aug 2024 12:52:04 +0300
Message-Id: <20240829095206.91150-7-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240829095206.91150-1-vlad.pruteanu@nxp.com>
References: <20240829095206.91150-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0196.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::22) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|GVXPR04MB10381:EE_
X-MS-Office365-Filtering-Correlation-Id: 90a84b1e-7d43-4b0f-0991-08dcc81055a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?99kvTl1X1nVCwRYtp/fuVbWo8WOvIh8I0lyd4N+6QRnzamj82q+IbfBZDVOM?=
 =?us-ascii?Q?nExABz4/o9dkqqsaC07O3Hi8FqRMT5EmzePPXBTocDxzqv7gRuz5ENUeBUlq?=
 =?us-ascii?Q?iUtk8B2H0i/GROGORtHWdQAkB4LLjxn3sHNCz7eIzOtedNE6XMOlUGTq6gkR?=
 =?us-ascii?Q?QKkSfCaslapCDmSa5CGrOBMnqmM23FUI9f9d9zggivCq7Ls2N2Gl11IwSTxB?=
 =?us-ascii?Q?zBAPllKBVnfkAfUNNA9SW5O7sCFqNaikR6yuztrWAKZbST/EQ6yZC5quOvGJ?=
 =?us-ascii?Q?NGlXFMYLYPd8MZ+Ew219PREcMphGN5SvVg0eGpET2ivOD4dxMjx2Jj+hOjw6?=
 =?us-ascii?Q?nYMQHHRLHcpgwGMTA6a65l1hqcZrz28OoGrAn6iII0V76qJ11TeEsrcGwVZo?=
 =?us-ascii?Q?Xcvz+oRK1TjoOLdtUQzKyOZ/oYM+vecjbSJZBN5zk/Zj324mjmhpgR1VX6Hb?=
 =?us-ascii?Q?YBBvDhBbiArZMPNyewxnLC+g5H/5E+TqqGm8pARAn2rDbfsLL/7RTGaUUsUM?=
 =?us-ascii?Q?AI9FbN3arr1TemIGZk6R60kTt7R10dxVW4eh7yrR51rCZu9k1nwZXiT3TaDs?=
 =?us-ascii?Q?NaSq6btOaFkPdy3M+3AH85/Qh6ksRKcDmgdt+9Bp+oBVNuu5bqb8SxkQzacR?=
 =?us-ascii?Q?ZhW9mMbT34WVVRD8FUCfgMwAGoaNAbbqeP6ik0L/13ZFWvRIP0AnzH1iIGez?=
 =?us-ascii?Q?lN75wd+HbjZbREhLYy5MQAbXPsWiFZxALtOllzORVEbSi8q0++dJJSXp/1XS?=
 =?us-ascii?Q?u5tXb5+nSS+3A9GlN6UH8moA6Snxr3P9YdLwWeCyC9kYAwYxH3E76f36ZXIf?=
 =?us-ascii?Q?1Koym5iteb3ZhALAg+/+0DhINRcDF27oBzpcY0hZYe9S51oirbBA8djHzMTE?=
 =?us-ascii?Q?aWBGbHaw/S6lmsoJ0dQcgwzl96WU6oCa5+t0kR0RKN76n/eQEi0w4ilNxO1b?=
 =?us-ascii?Q?y9nmmxX8LtkHpAcp5MYcJEvTe/28wwuEdUIvtGEjD57oB50q9AdSN4bXa9QI?=
 =?us-ascii?Q?os6MTjfbZmTZNamwKw58Hnj2DT6XdxQSPeQvQobdjV11+5uHcEUZA4ZW9nj6?=
 =?us-ascii?Q?gmaLyx4igjQOCIqFLLem/y6hZ4gjV3LZEUq5H48PHzj5Ea1CAmvTS9vCnj5L?=
 =?us-ascii?Q?cqwH0ZEwfHnILCXpkT+sg6VSwD9D4O17lGHjDpPsYt9bIk7F+2augljyg5S3?=
 =?us-ascii?Q?Kf5vROov6M86uBkq1HZKFAYL66F5bC3N9JIQK3dDUCk4T+vwV3o+YJI68j2r?=
 =?us-ascii?Q?dtXtvp1p6w+r7PaZiFHaHRBHbt3nnD3E+/CVfZ0J3PmH6tN2In6SsjQcFceO?=
 =?us-ascii?Q?NSBS9TX62TDtc1+JhmZZZNEJPGVIfKoWnRLxp0B91eJD6ogGVWmcpcnXYVlR?=
 =?us-ascii?Q?h/1AgD09C6LUyXCUT0vf1Eqh7HIKGhcIvdHUpVg7xRL8prs6rA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B9AryGYoHaWg2A2zbbq8GITCjdhg4bmuoxiye9FESgWWp0RQeF9kiCxoVgbN?=
 =?us-ascii?Q?jeF3JIcSCjJmnKoq3DomF+PsXcWtngz+98MWPAlpsGrGm5qA93TmFjzTALdJ?=
 =?us-ascii?Q?wSDKMXN9FMCpN17Lcctfb3s9tTa6QzqCgBIJEBe2CJTNX0aopySbM435+N3X?=
 =?us-ascii?Q?zHb7T4PH3ZEjNry6xO/Vy5PRHSn1eLymDyXXR8FWdOXlOXoF8mH+Tq1J/MBI?=
 =?us-ascii?Q?v39Vt/PqEpiiSYnBI6x0eF6o+wVwHZQrG7zkOw0PX5VuARNaptZsWY6MWtvg?=
 =?us-ascii?Q?eezTrffz8VUreUIeHUU+MS2MtczGmTu+qSu10wmijDCoA1s/pvHeBIPHnVrB?=
 =?us-ascii?Q?ZjgAp8XMnrDfJQuA9CImasDazisMkt54JRxjHqaS0DUGeoP/fkbrJw/wrWdQ?=
 =?us-ascii?Q?sN7YN2FJTkpfuBicG7fgXZ7zQotJ9FeSfSYMn/7xIJ/chsLOUoVDIwGXTmk2?=
 =?us-ascii?Q?9JUYtXrz2PUqPTF34jL8fbEMeQ0tzDvAsGe3b5l2BG2WngaEugujiLcR+oTY?=
 =?us-ascii?Q?tK5iZ+jwkxEMQvnMGM7HLHjsYxz+LscVI0sdSeQsI6SlrwPeqaJqCi26gbPp?=
 =?us-ascii?Q?B8QlLmuNK8dEbHiBk+4jsRB0NH69qncKemSy7WFn8mPbo+BqWumLIYHsH36i?=
 =?us-ascii?Q?M9CZPIKD9YawmEDTaWfAdP9omIWvLm8UIQylEJyf+CI9C0k4T9p7pLS8iFeC?=
 =?us-ascii?Q?03ezmg0DMt0HxxggG7QlfRpfjq9Zp6x36Ra19Rq1wWtVgj+I8KBR54+e9wlR?=
 =?us-ascii?Q?ga+C20qbBwwARuw38TGbLmINoP5flIzJEKpr9GzgaG+1tg4iREScN3K8YOLt?=
 =?us-ascii?Q?jbACzSBP0n3E9YBamYvueGvHWXej2FGBbaNiOk3uJxNDIyj3MlPkwKs0ZxAy?=
 =?us-ascii?Q?IjqMg6/nXhaJixWxei0AbCzRmYmzmrE0O9EHpIa4v84jZPUJB64ABI4zMqCF?=
 =?us-ascii?Q?yNQEQfb+682ZTL+Sjshm5tqeEJGEM/KxC/wZN5d2Rce/I0QceU62wpezH556?=
 =?us-ascii?Q?Q2RxxQMPEj2UazM/GyrMqxWADVr69T3vKCFA/3VqrnFayUMIgZXop8PgB8Oc?=
 =?us-ascii?Q?OCyGVlr9qMEOxhn8L0c55ZPFC67ErLpX3XDKaZuEMq6KY5d6gVjdBzQia9uN?=
 =?us-ascii?Q?awcS2tXcHUwgIZO6AfhkT1gSnH0EDzX61mMAlGmfet4GIYn3F38NafsrvzOK?=
 =?us-ascii?Q?1JPryT/drREGUMi2t96rcou431yCm44ZBi9dFc280KpNKhHW8VqRXd8dpn+E?=
 =?us-ascii?Q?xbImtK44WIWFikz9wAhdAb+7+nFgli9pkzIej/UngOle4oGp6+7lOAYlmDSE?=
 =?us-ascii?Q?eM62hXwSEdLQt/BB2dOexauY4lWGcXuQCATmi0nYpYygd7AyioKZZQOh19y+?=
 =?us-ascii?Q?oavYJc/28zLXnSrxjsCwkSdAbnkM/QhVbqctR7YYFZdELp40PJ/Nw6V3r9/x?=
 =?us-ascii?Q?AB4jvWh81xotyw3juEH5E3U7P9dvyhmvOXXPZQWpQ7Q0Np2LqxqFRjVY/sAe?=
 =?us-ascii?Q?DbIMyN7arlu8pTjyaXKo7aPZkyDF/FaBbe6IonaKACAr+PLVrnWgJc9yo051?=
 =?us-ascii?Q?5lcPP2V/2xz0F4ZhiW+fRliRBWo86pbfvuHfxs38?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a84b1e-7d43-4b0f-0991-08dcc81055a7
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 09:52:46.3789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vimz8xanRazFMXU/PEDYvn5yi84ElpIdRzH8kZEQ2qcYnX7hh6jb3/zqiF22SjCfGiyoFAk3JU7jZu0cfOqD2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10381

This enables the set qos method, bap_bcast_qos, for the bcast sink
streams as well.
---
 src/shared/bap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index a7217b417..97b96e49f 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2243,7 +2243,7 @@ static const struct bt_bap_stream_ops stream_ops[] = {
 			bap_ucast_release, bap_ucast_detach),
 	STREAM_OPS(BT_BAP_BCAST_SINK, bap_bcast_set_state,
 			bap_bcast_get_state,
-			bap_bcast_config, NULL, bap_bcast_sink_enable,
+			bap_bcast_config, bap_bcast_qos, bap_bcast_sink_enable,
 			bap_bcast_start, bap_bcast_disable, NULL,
 			bap_bcast_metadata, bap_bcast_sink_get_dir,
 			bap_bcast_get_location,
-- 
2.40.1

