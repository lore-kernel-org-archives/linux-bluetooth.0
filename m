Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010035.outbound.protection.outlook.com [52.101.69.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9154518E742
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 09:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724925173; cv=fail; b=BBhx+wk5IsCfoVZQmdxA2ioh1LtYcMZfSrsJMyrDB7HOrkU2TqKivxZChSN7+FpEybfWBQkdsQVC+rTjhLknInMQbAW19yDwtreqZP8KRFiXOFlO8zzg7aKJieCQgCufAQ8ePT877EXvQEWb6QEjwfAa8LSoZUSjpOjqPcfHOm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724925173; c=relaxed/simple;
	bh=IDLawUEyvX3s1kl+lmawmPvc8zXhR0vZvVKZhYumhdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S42FvvRD3EY3X7hLV7cFDTjSJxzRkbsNK/pFd+141BDh2t02+BeZva0s1T3tSu0WJExnSoJ2GMdgUdIdKC/gvo2dNa+QaOFWM1ORfpEnR0/R28PhHRQ1iQI1+gFXjjKZIhJgXHLidrMhNzpwCGAGQJVwSs+K3hGBdZd7I6bnCWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RS/m0gID; arc=fail smtp.client-ip=52.101.69.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RS/m0gID"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NzV81Mv5ME9iniMKCAhLqtrr6/vpX2qus31Aklq7pVn89gKV7kxHXrdzSZiSqE8Ro+vjAL5RCs7VL2YSiZmG9+0VONpAwDdZgnRBBxsTIc3BH7yDkwt+lQGPoexfbZXnsfR2AawFLbuogGd5GAi8NHla8nFekITyaNpKrYWpEu2PZ4YfhHCGA+wQUVzA9iwNaTsy65em8iCzbx6KC7Ye3IUcRO9D1M+7fholwgiRu+lSmqsIyWEMM3bpA27b5P0HC4joiWyEyTXYmCFQYLdadZGGu6GdJhtGTCni321pSG+o6amRKOn1uqbxqiL90QRbRLTPw3UkXj0lgpUbKZBiEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yi6f/mQOkXTT2HCAmu98ROPUTLGLhJFYiPnzUa3oRGk=;
 b=CzVs23bfxAEl3Y9CLkPu5HCL0UdZ4anisSK38Ditlcod5K8rjPvq9c4Diofx/XrPBhCFKg0GsKoo4bFYtTb0VWVKDpkZGpM9X/TsIfS8A/5StzCLDxPuBEELL3pzEtgOAV/KsSDn6iTmxfYFMv7i/83gl6SqPD8PBK7BcZ2LHpApGCDQrLc4CT/2Sr6BOEXgoRZfiDJOkG2C4HYIjIw9tyigld9twsLTisVjNm4x0n6sUFaCjAdwhSvh88qlkm7oQ58YuP+c85xgOlPH2syCcben+gZWVz7csA4ZbtJc02N185jsN/Cu5BrcJHzOmWQRCldXkQG/DDu+HOJeUDjKZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yi6f/mQOkXTT2HCAmu98ROPUTLGLhJFYiPnzUa3oRGk=;
 b=RS/m0gIDYffp5mFUQ31NI208E8FfPlX4Av64Zd8EUyouzo6o8+JKseBMK+H9BNmWOAJzpZqGwiuPttrikfsJ7aKuzeSzcFivX9HitmU+pD491jVIPR7QPb6CkIc4XY2qMj9YnkqT3JLFirOXSMoBomTiV2nxWxcs7mHCQLxxCOOg/JBj5glp8WUrD1GbGAier7Fs6kbow21kZv6YqzybkG7FHV6XMogX2BZviROabbxztvFX2Ztw7hba8EABTtG2RNvwDXmfOaK04O8Jako+hFIxiG4t/nPyvEOWGZO1LEd42ZqyRsXOvI+EvpE/uejg2MYPG7qKWGYYxriBc6WsrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by GVXPR04MB10381.eurprd04.prod.outlook.com (2603:10a6:150:1e1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 09:52:50 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%3]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 09:52:50 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v2 8/8] bap: Refresh qos stored in setup before doing BIG sync
Date: Thu, 29 Aug 2024 12:52:06 +0300
Message-Id: <20240829095206.91150-9-vlad.pruteanu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: ba4d19a6-9692-4ad2-3f07-08dcc81057cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ueVibx2bWRcfBEYT0SKGHrW5PRuaDWGELikWUdQHOEUDyr9bKPCn+tQe3Ttt?=
 =?us-ascii?Q?9Bcu0k7tgRtSLg855Hvn4/dNrecLnCkfKjwzF5PV0xY+pKrcbsnW4ugRD9iK?=
 =?us-ascii?Q?SQ2ds874Ae9KWjDI9RglypnqC5+4PYN+mv5Un0Eo3WP3IXIhfU+4mj4gj7Ar?=
 =?us-ascii?Q?VE1Dtrw6F5eP5RKhlD+9GJuLi4Wu9p6Zsmc+Vq8VeG637650nXJn5E1MrKhj?=
 =?us-ascii?Q?y5xZyB4ikgZHRXN2Pp0Rj6JiTIlgrb2Ovagvbx97RH1SGU/zFJTJmCYxvZhv?=
 =?us-ascii?Q?HqULajyCK1SB74K+eMHjmvJvftN+2aYl7rw5PegWXHWRSaj7ISGLwlJS3o30?=
 =?us-ascii?Q?ISmVgx3QF0swbRHhVxshDWNqx7sNjyTDzQ576ld0pIcE+QuvfIXPkDXfVAJ2?=
 =?us-ascii?Q?iIU10Nz6F4vuU7I666uDkk8/JU39RAi5hclzw/p2/peenoLH5ZD2fm+wUUD4?=
 =?us-ascii?Q?Uj9g2yAq1DkElqJKMNVoBIekAn2IPQim0jFPadDFHjiizA4v+XI884BcIowZ?=
 =?us-ascii?Q?9TiT+dB7s26jjQ8GUMJpBa6PcCd+AeXrk423qokK62Z3Dpue5T2/iATiCkqV?=
 =?us-ascii?Q?XsQPsj+9dtc4UltddNiIOHPzI3QEdGJATvIUda7DQYU7WZjDC6SeN4tQodxR?=
 =?us-ascii?Q?qav8ZpNI1kzsPoDFs/AAkfD2sWHGZ7FHpQMkYLTu3RpCOKy0NqtU4sWAnGRj?=
 =?us-ascii?Q?evU2mVubOfO7juPmrWFsfQhjGWU9pbYvl0nrA7GwAqEe3ReUtW8/pEWZCg7O?=
 =?us-ascii?Q?6s0q/weRO114VZa6msx4A/e2QePJOCYlSv8lF5AeHf5yTnq+mMmCov9GyAhc?=
 =?us-ascii?Q?Uuc/vqZIgM1jVD8BOVEfFSp8rhs8vM6npb+tWkTtIRwmkcrY3KC5W/BNmX90?=
 =?us-ascii?Q?5g4lVBLN+eOqCZYKCo8qA7tcZlzQy189A2DHiG2rZOcQgGfBQeKdtoY7oljM?=
 =?us-ascii?Q?79yC7aQ/a6q+z7NpVrRcowyFWzyBYa6OGwv9zAUw+huJY3ISV53TyuQzxu+/?=
 =?us-ascii?Q?ZJin/eRGlv+k9a23PCs26cdfndqaX6wUR+Hx3VXLar6zSMePmzTlBDXp+EhN?=
 =?us-ascii?Q?JbtS3YuOl0OICZa5b1iH2X3uvBN3hf5jyi01OHAP9coi1REE09EpXzUgSxzf?=
 =?us-ascii?Q?Zu7RLPBbNizpUw3CP8gePmBUNY3VTPeqZB6kZFGvhVcNT6w6P1iadWQVjTNt?=
 =?us-ascii?Q?UnCwIt/g1EzNaUi4zLRxsP2DOEaBayMYueIBf9uj5tCrxLZlVQKbThO2gcKy?=
 =?us-ascii?Q?U7rCWYeM28TR5ea/iWtP7jQEYFmMsBegG7ValkuVYZc2pd9KtN1gWrl8k6xk?=
 =?us-ascii?Q?+b3cGk02ypT9SWwmkYastAC0Mp+b0ikKkxJ6GsiNIsvkfV6DLOUgJcDPZxLw?=
 =?us-ascii?Q?iQbhVTsn6/y2cVIoSuAWWfspLS8P3tJx4DvVsW60KgcW6tGa4A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bj9Q8Iouo0PJOU1KKrCTREcuwQsGGHVMmN2sWvdVEUlw/w1Tg3xFzlID5R+e?=
 =?us-ascii?Q?G//u0xakJrWQzPWi8rUaSHW91aBmV2qZd+cddV76BTfOPWA1BIUlt2TWyE7b?=
 =?us-ascii?Q?T6uhFcN6z2j7tWiIDehT/feZksJjiHcB2paeCwsNLG/3G11+oxFgdOUwIh6e?=
 =?us-ascii?Q?awNQvLBLiW9ul9bNYCkrqnzApD2en0eTH9jF8KuvC9ccqG3eFsg2PHkw4vYt?=
 =?us-ascii?Q?KCOiWVoCp4mYfqogBMKPT5gUUKBL/BqT25wuuTc5QN0MEx6Z9QEASdar3Qxj?=
 =?us-ascii?Q?lwHovJbHIbtNA9hecgNH9xuaHjQnDobSbbEXXPkgIYc7rLY/TBqGtUcn/44E?=
 =?us-ascii?Q?NzhUUMDv8A7OZcLFHQ3ROj6chPCg5JFKInSvLITgINeoilOhH2WgSj8N+1UM?=
 =?us-ascii?Q?6E7rAEDxRh8MM6E/8xWEcgBm8DKDkiW6FXIrLP+K56DAMFBcBTM4XIPZYLty?=
 =?us-ascii?Q?d8WWjq4bPi6blevAw0cqp6hz2Akr3ICD8VjVk1r+EcLXohF0L+qGTK3OXMUb?=
 =?us-ascii?Q?X4JbLHRrbHvmGm8uoZeFe5ArbvFL+NrmxaJ9GR2rAQO7HfcxMbh41gexrpJW?=
 =?us-ascii?Q?ODqYppENxXAlbwNWydtHZD85qAmSZ7MAMnH27aI23r6lhL6OmYO2JkSwu3Ff?=
 =?us-ascii?Q?woZpd+gQWDsdwBGxT3qB9BkY26rl08H3DaFBsZn0UTSU0w11VxOrziHNdfZO?=
 =?us-ascii?Q?WVNvp37cHnrSRsoXH5gDedffnHB3CwgQZXeX7OPjlsn/Iztiin3BWCGbzRqd?=
 =?us-ascii?Q?wV5rO/4rTfQrmGnlw/8fewIEWSFDTGcZ5/t7+Bdl2bn6Qh9O7jtsYHpV+gZi?=
 =?us-ascii?Q?tQCHw2hCtoxnimeIIq/9WeijbbSvHrkF0WrN0GTPHy4nRLGS4oPS/MABR8mI?=
 =?us-ascii?Q?hlM3yQUqwkLcOqLrNhKic92Z9k1SQto1bHgpU/mbj99RSo7rGLWwJiculBwO?=
 =?us-ascii?Q?66WtugaAwxpLnWVhENJrw5tbGE0xq0vrT6ZV4eS1x2/zYxUqWxMN+rLS0Wqv?=
 =?us-ascii?Q?ZIhaRPTi56JvIrQxkJXsaA3Bz2wXFg8YDISAw12brG976uiRVxAZViDoDuZo?=
 =?us-ascii?Q?Yr/WyitxBzDmg10rKFZwflPPd5n9XgNEW3WfVaJxNBpsSqGBULn4wNeGSoXd?=
 =?us-ascii?Q?r+QQO/CkpHf66iKda1Ywfgp+cO+TR0H9A6IplT2dGzFQbvfONcEmkJZa1OfP?=
 =?us-ascii?Q?dW28HryOjzjSvs6csNOELGq/HS8yDleMmCJTvlcZaJkIsdCyOoIKkERN9XpC?=
 =?us-ascii?Q?+4LSWQUxv4ltPMAvWBlRvqtrMKikJ94aujP8L5bEE688jp56jBeNDtyaxltD?=
 =?us-ascii?Q?qHGRPjGQCZiotjAEl2+l4RUUbYZVeHUvqVCvKyC1NvYaHi0MSACBbbsGm3x1?=
 =?us-ascii?Q?fBSSZbrSYbDBpHtQcF9jWoZHVLd9sCIWU2h7Iof3eAZoBlpAN8kuL0J+vaO5?=
 =?us-ascii?Q?NwQ2FEo8my+Wn3SHL8DMHdN02YeYaPduC/4ZW++jenGky/oYthlBIpee/m48?=
 =?us-ascii?Q?gNElykT6w3Z4H87FhSTuWpwA5mKQ8Ty0gcTaSumIM3wyEwegs3c6GByMTw8f?=
 =?us-ascii?Q?52cuoA9xd7aeUBQdkjsofd7bRxo/mdFUL6islT59?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4d19a6-9692-4ad2-3f07-08dcc81057cb
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 09:52:49.9956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F1KfdIVahf9fCdLjqOvQo6JkCZ2caQMxW0ScdUU5noyz5xZeDj/VNwkhRJh+Ddbo2e1JhRLZYTo2Z7EL2vZH0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10381

When syncing to an encrypted stream, after setting the broadcast
code, the qos values stored in the setup must be refreshed so that
they reflect this change.
---
 profiles/audio/bap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index a2c5a546d..80ed1a7ea 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -3066,6 +3066,8 @@ static void iso_do_big_sync(GIOChannel *io, void *user_data)
 	iso_bc_addr.bc_bis[0] = bis_index;
 	iso_bc_addr.bc_num_bis = 1;
 
+	/* Refresh qos stored in setup */
+	setup->qos = *bt_bap_stream_get_qos(setup->stream);
 	/* Set the user requested QOS */
 	memset(&qos, 0, sizeof(qos));
 	qos.bcast.big = setup->qos.bcast.big;
-- 
2.40.1

