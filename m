Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2080.outbound.protection.outlook.com [40.107.104.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE98376
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Oct 2024 13:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876128; cv=fail; b=ZAPARounPCugYVVwdIjsotglvyWlphkUz78I919T55BIZCFjOzvIW3EMMEZo1hpDyk0OpByxSfNUXKvOT9X3s6ABmKVAxTgPwyaQ6jQY3lgie+7cOvupbG2NxmWLCFujPutfCt63J+s4DUB3KuamNUpTQHvkmtDSJnTHTiNDfwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876128; c=relaxed/simple;
	bh=26fwgAEg9SArEoNbKaZngqPvT/ysPUif0JaimVKM0Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=N3vAolAv/Bf0wExrQmvjn7V83yR1QWVMRarzaR6ynP7OAGyakN1FNppjty7SvmKEw4Ya9KA6sdKYqXdlPRkfJIF16sM6Txoc3U1VF9mleRPwEC1xgKsHJC77XYzLk2WDUMZBsVXQ45dxVJZ5YvgURktTwuc5lLUSE+rh4h+Ou4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h9/1y+6A; arc=fail smtp.client-ip=40.107.104.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h9/1y+6A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WUxbfyZAwEXVxO1Uy3Oi8Y8fSf+QxW5bO9WeHXBOVZp74ADx8xbxw9OHGYq/YX8rz7KIXLy8mfr16B7Pu35LecHA2R5Mf/i+eWv2DCnNyswzhxeqbiDwbVS+r1GrNKnLV2K2WyKi0XpBi07Hc6VOqnoWcVeHlccKd+GROzFrbjnAAYv/yGTSd76io3ZpBeyozv+Qucg5uO59a34fxKIjsTNqNJvXaM2giFtvloaJFTCFB7qaf1IJgZf3d9VNt37gPQBH1E6sUoHoJ/LruSmkzka6L3wpOgr39rmwpqp83ZzdX5NUW4i4hqFAiAONhdSHd7Ni4d6fJY0HycE5oMMB7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3ux5xQTJm7pUi7sZPyojwlQ2fB+/ze8IfctAaRs9NM=;
 b=j4eG8aAKpWNLt22qOlZV7ybCnX52g/lcK2L3lh+vhLknofJFG0CPiMB+WhNwRlBtUSvPH4k5xoxqf8EbmQ9pq+DhgscV9s7G7c1OVkPhDXxwgrKrOzWFLsjR35RgJNImkoUACkMqLj1rZf2Ekn4730PCBdszPf6Zh+JHOdmG1crRFV6BpaYFGrSVsZRJYMakxOg09xniLiJpY3AGVBc/Mca0uBETBsWUIZYhNk87R+cj08DQ8xuZ6vu0R3H8IKNyI2jsQ4GfRWes88nPX89afKci54z4tFTaPokD7jAWCcCPv9gaM6o9SeZu3syAoHyWd8n9vtPh3TKbayxKs36wgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3ux5xQTJm7pUi7sZPyojwlQ2fB+/ze8IfctAaRs9NM=;
 b=h9/1y+6ASsII0itkpTcLRHVCiEP6q3X0F0G24kITyQc+HmfCh4GsWy8CQxjPkV7L5WnTzxdNO/3qrcyq0Nk5BRk8d1pPuQ37/CJt+W9AtPOGfTQ6M5xXxzq5IOA2Ljj8JmjdzoRDzRG3f28xoFjzScc6naaVsa5AUt4DrdhAjdT5t9xTyEDcl0x/zQMrsq51ewSOSV3tok3Yw3fDIzHJcr8gDJFV8nTLk2EJg9nHH7mJbWxJs/kSFOW3A7oDgWluQ9Sb2kVwouSGk/hvniRnNvQmIIv8pUoOanzVkxWyA1n+1eNSTOvbklXl74YSV3f6H3+Cdrawh73A5wZyFynVHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB9365.eurprd04.prod.outlook.com (2603:10a6:102:2a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Wed, 2 Oct
 2024 13:35:23 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8026.014; Wed, 2 Oct 2024
 13:35:23 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/1] shared/bap: Fix load of misaligned address error
Date: Wed,  2 Oct 2024 16:35:05 +0300
Message-ID: <20241002133506.16834-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0027.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::37) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB9365:EE_
X-MS-Office365-Filtering-Correlation-Id: 62f6e1a7-aa22-41f6-e52e-08dce2e710e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NYLKYkbmfOF21wucU6X6pNm8FmIZRhIq4I+rWgO2XoVaak4WalVSUzAmOFLG?=
 =?us-ascii?Q?7jWnabUncCX39My6OTM+DpiQ0aJ9MlZ3HCeCK5huaT+5Q1zhPaWKKhgGRZo/?=
 =?us-ascii?Q?sTBsO7OpVCEPdKE0vwE3b9Dy8GLkvVgc5Vd8U7mviNaIqxelg+0npKvr5MNz?=
 =?us-ascii?Q?ikt4AM3ONbmNDUdxjVnCjqJXp3/4c7Q4Ul+IEdL5rH6N0YGwZeoodvDbkFyK?=
 =?us-ascii?Q?H0/34kxLvmlDjZpN7Co922dPgM3kDQ2+96v6BJem+0Puo1XeO2HO5Yau9vto?=
 =?us-ascii?Q?2RWU6j0dQncZsb/Pny3g+gCb0kn2amL5qnC3lyJ1GH8pY3ZWTIXfMy9yZg+J?=
 =?us-ascii?Q?qooxph06TJbBkNLm4aQJurjA5hkbmAulTaQ+eWGLPHhyGPrAd1F8i9eZxnFY?=
 =?us-ascii?Q?j97GJBFhwc0TlFiIL37Dd4iuYmY3U94+A7jatvNcg8sJIcVdbgqRA0+kz9Sj?=
 =?us-ascii?Q?kiJVlKN7bBAhX9n/U3VYhV8694QJnzWxzKBWtdEBs3qW4h792rZJwWs01Wgt?=
 =?us-ascii?Q?2uTFfCSl6q9XF/XJ/AZ9AS4mCA3zuLrWR9uXY1lML2f2jYKv5QSKg6GWC5Yr?=
 =?us-ascii?Q?kJ0pGdF6+k+CAJ8NCdM7b7ztwWSu5L0N16vVixCtLk9JhEcJM7z8tx8J7XPH?=
 =?us-ascii?Q?XlaFiEXJF63UxxCq3hJbjOYa2fVFBzkeJ2SeKwDvJKRVbVaHi1JTyqlM+RoG?=
 =?us-ascii?Q?dSnUqaehuCWNsdLYeFSLQEy8O1/z1F7WXppGKSo7H/Xqwf4z6MwDKc5qsEXv?=
 =?us-ascii?Q?8z4OkmkkB6+2PG5MrrblmUfpMx+KmV5sSLUpvDHiWRqciFpLiUY7U8RTea9k?=
 =?us-ascii?Q?Imilc3rrPoxKrWAidHfcB7FavJhOdj5hfdkLqb6TAQRdDgmKWTh0GafyEygZ?=
 =?us-ascii?Q?BFhdohs4dX8dDG9MGpT2+GMygXCyYQtnrTiscrc7UI6z6zZjbWovwDayf1Hn?=
 =?us-ascii?Q?IyEE4zxJfRAUSooMF8Zzo8ch97S445JN4tVyofOa8CHb4v70LIYeuqHJoUaL?=
 =?us-ascii?Q?AwST4/G98PXEEGH6PEVsE+BYkWMgTVoltW1iTK7gJJgYS6PdDqctDAhQJIsX?=
 =?us-ascii?Q?HkmkUL/fBgR+r7Alw6+gfYp4U5rbqMUYoyMT7RB0Cdt/0Hxr2l8L4riopfIZ?=
 =?us-ascii?Q?RTu/72oJX/nGVT9jHWZbyk1CrOyF2SjhHAv3yVCmmqdHt6kE1e2jQwDkspPo?=
 =?us-ascii?Q?Vk4939So4MTyQ1I/4oyAn9smO1kvroXUGN2RCUBCqkQSR3lPpJXXmolR1CJc?=
 =?us-ascii?Q?bgoctJ1EFZJAUcKFPuUhhktbEupSkRE4/Y4UXianRnDKwIp4pFW/r4FCmF1m?=
 =?us-ascii?Q?OR4XfkaDRSXSqgJ9JADP3bIazcWIksS+DVWn1ZHQS/PxIw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J7lfwASevLHHZdHF+pOjqEyhS345vCgk9Vy2XR1UuZ03mu4IxBb8b6ceTiZW?=
 =?us-ascii?Q?ghYxdmer6dxKDIg1+tlY/2Td8RmT/h01p+jKX88jQ7KF80vcAUpzx3IPV62J?=
 =?us-ascii?Q?RDN/kO9naTHFuYqX5bxSuvwmehPNxd67UW9eodFrMrHXQ5GBylSf3TBFxFxY?=
 =?us-ascii?Q?9xpLONxmAf3B92znI/78HxYDK0H+cf92mSZgeFT4HGRJwUAGJfnFOUCweuPb?=
 =?us-ascii?Q?HxuHhvkn5saEpmmmr/p31a++G7jzFH+AIodeiLaNXz5/AnwKayREwFh306gU?=
 =?us-ascii?Q?aRGMflM6gmTvgQJJw6SkH30Q9W8vypZKvPXLiOmU7BBtrgmbCrpB5722Tiiz?=
 =?us-ascii?Q?DpilKjAiXVc2d6E2Z0agJRVOfcK9yxwTggI63tGuEsfU7EKvPr2pFegIZ0kA?=
 =?us-ascii?Q?k9xRAQoNaaIGPRFe3JWFT4tvHgUychFvT7eNplT3OLqnWYd6Mva+etFzzBay?=
 =?us-ascii?Q?k9zUR/Xoeud/RWGXjcF5K7F6FSCm0GrTPMQvzlhNp5hRX1DIbO31VvfJ9ci/?=
 =?us-ascii?Q?06pC+VpvgvyP9tdqamOqiEZgB/MrZLPAPZSXXPYhiBuD4tNi59ayTcDUzO+a?=
 =?us-ascii?Q?LHHCQxVrXpxLbh4MoDvceirgNgz/HwR80hKVbXCkY4IZCczWu6zSXaIKEkkq?=
 =?us-ascii?Q?Wsb80jZRISXtiOe2iJtEVDUm89ZwWQkr43Qh3PueLlswHT61gqTRhGXpWSyP?=
 =?us-ascii?Q?knSyPH2FV7BOSNUm+PqocoMJhHs/KNWhk6Dl8lj5Qqn7G1dQ9FNDF0ICaQi4?=
 =?us-ascii?Q?BZIuuVkCNlKAxtmtupC01E2CeunuOWOS19WOH+IMckBevD2aYbrsrO0OknBE?=
 =?us-ascii?Q?HSOQ5t1g2n5+aQ0j4HlAgb0BTCpIWaOBIq+6PdnclRK9yQP6OWDpNEEM4QBY?=
 =?us-ascii?Q?WrtOsAQ8kyX55vVI9e42sxqd63jsViIH6GHeRyR7VxQrkvcu5ZjiCGYlJozu?=
 =?us-ascii?Q?IFZ0Xj6z/SKevrOkuH6HTcCM180ozTL2myobFiR39mzvWArebk15zBFTuyyA?=
 =?us-ascii?Q?8jI8HW0R61Doe3jbDuLO8UsUWq5oOETv8Ju1qu38uolNihlYiLmRFiB7/45n?=
 =?us-ascii?Q?dn9970VkYNexNGFvcSf2sj7T2pz2SPW5VJEH2bzCSY+KZv6eI19tMlGqOmAo?=
 =?us-ascii?Q?NYqcHYEZsPZ/H6DRgFBWRTqRL5T4c1P3kA/sPH5iVygILcYJUg4sbScPPFv5?=
 =?us-ascii?Q?Cb49cUHXTVREIDIBym5V3UJ/Dakc4VVmaJYLk1BOopyMg9k60dI1BzOAemBa?=
 =?us-ascii?Q?KdUQvQiB6KzbiJ784jYu+bubnxZPfi/qSTUctTAOW0O01xCdHb/ftXBXl7q2?=
 =?us-ascii?Q?8z1d+maSiFx0FrkI6kwPoDVoUtNft5AQ8fbf/M1ZHaIqej8MqSijeNkMkkiu?=
 =?us-ascii?Q?IlKKmrW8d13Vo1CwNj7b7bqXGfm8QOz0qUZ3Kb/W4G2/UdqS50XD3dBgTUvb?=
 =?us-ascii?Q?WeHIARIx1FyoIA3Tw0wkAISLyF7q+TIrj7+U0+HtWlG/WRhfwbWE4YfnIQYi?=
 =?us-ascii?Q?dSDo+Q2p7yQk4tJDDzF2BpvkUR7mUOWOnzuTqxFVcG1r2B/sGkzK/tqADjd+?=
 =?us-ascii?Q?N4TaSrLg2hkL8H7LF6yuMxyRYt1KHKOZdIhSiaZKVNmtqTMZsZJD7JpnWklV?=
 =?us-ascii?Q?dA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f6e1a7-aa22-41f6-e52e-08dce2e710e3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 13:35:23.0728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8gkFhmWXCRP1HTrtDDDSuW1EkPAlTcbd3lVg8Td6VJObcrPBn2eKdCR4HlPP+loasyXm8js4zq942H42lHZDDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9365

This fixes the "load of misaligned address" error that appears when
parsing PAC caps:

src/shared/bap.c:6497:7: runtime error: load of misaligned address
0x502000063639 for type 'uint16_t', which requires 2 byte alignment

0x502000063639: note: pointer points here
 02 03 05  04 1a 00 f0 00 02 03 01  02 11 00 00 08 00 00 00  a3 00 00
              ^                        00 00 00 00 00  01 00 00 00 01

src/shared/bap.c:6498:7: runtime error: load of misaligned address
0x502000063639 for type 'uint16_t', which requires 2 byte alignment

0x502000063639: note: pointer points here
 02 03 05  04 1a 00 f0 00 02 03 01  02 11 00 00 08 00 00 00  a3 00 00
              ^                        00 00 00 00 00  01 00 00 00 01

Iulia Tanasescu (1):
  shared/bap: fix load of misaligned address error

 src/shared/bap.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)


base-commit: 38734e02051364b4b6db6e684beda8c47a1ba452
-- 
2.43.0

