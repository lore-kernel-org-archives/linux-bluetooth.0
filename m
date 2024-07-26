Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D5417623E
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jul 2024 10:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721988646; cv=fail; b=WGCgAUhkD1J9k0p6JvHfhJyr209HkvnBl3PwJLrO/FNB/JRVgVDHSgIzG9bVlK6+3gV3CcIe3czfsZYp72075tbEbCFqPWAChEA3qV9cQ3QLz4oxl4jamV8cYY3JOz1bn3EcEmSWQPNL/lDbJ/qmGOaIa/UYffHe/PoXabJP+gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721988646; c=relaxed/simple;
	bh=EvQTsvbSdenLBfDWrSQlaybCRLz1hqTtrP378peRH54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k8nqc0LIuZTRsxB55Gyj4GRGhqYfzBtbxBleLgKW2psmrUT/tAU5dwRE6LndqG3QeZMEVvDFzw15IxsK4vOb2/1xlKvZDMakgFUG2Ur8AVcsWwAEVwSi5Zx8Qh/xYmI+t+RqZmTLhUhNc3MrB/8HV7Kll2xIN4GfWR98acdYxRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WSZzL5S9; arc=fail smtp.client-ip=52.101.65.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WSZzL5S9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lnCFuPPrz6wIAvDgKMsB99omecvzXyRBVToCdTlk1972xcDsdpMywF5VIQo1kYvHPeK8Gctxt+Q6Cepw3Fhrx7ZHyZ6lniTcqxV3/ReHg2tJwBpNJQTynlnNAptprjAfWtRnV4lsc839VuBWuPaYhPX1cnWuwxlZiSSx4bmZj5QBXRPhiXFVRvfzBlGFnNfCOE0UYoBfUX+bz6745Rc1QFKOa+B4TOf2tt97yjIMsjxCPgJ3zfcNfxQgEU13y5CuFqUY4N4EwluuVtkZ9lj+FPvQADkm0+oiN509ehbhHUNGO+ueDN3bOd7OjRji/xrrzNzi/5G1nMZOFK7lBihkNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBEmNVgW2lSle6/5Zp1NZ+B4aTrVWw3SjTq4pN329NI=;
 b=Lql2yvyijRlqt/tCQrUvJ+hAzr655YFEibKiOs5iZ9oK3KibJALHuZsu02mD8B5RXMXLQ9JwwkbjMFDw4cUYVoO/UJAYdtEFxvdLZhp0cA1q+ZYS/Ytfvsjym3Stc+1nDAyuccGuFJhm0+GXr5Sm+G29ZGUQEGOlXCG+Q6sSC2vxt8dS+p4rjXu+5tjxslOMYjmiFbu0Y1rw5ILxirSmMgYPKa+IslabIYYHYcsJiAW670ndr/WLDQ/YNSnMq4XMU7N7yQqVe+PSdzYWXNeHxm3Dxu7XQ+IdW49Q5l5nM6u31Bj5wf4+tlChR7yKs154ZqM1BWMNMueBWT/IC/jtkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBEmNVgW2lSle6/5Zp1NZ+B4aTrVWw3SjTq4pN329NI=;
 b=WSZzL5S9FYanqKYB/BzDwy3qSbPW8EaJg/12w2FSdTMQKGRAGcMZ7bKOkMt0ZkhUkmpNFfsV5sMY7an7BQqUERPlh2rZpGNwZxhOsyodwl30wTFwhlTK1wRhbFdGcwK1sSKSWxHnhZS3Fsl/zJrz/AfyPaH7V7JLn2EnipUbVeSYUKcCJfDGKZSX7EGi6JKSRVhEeMUB712lz+UYdt6R+b3i6i3WOh3pmZJxpRL1EFqLar5Oyy1HZVEXHxJgwzmAuqTpDwnMxCNFen8jEODQyxigzGQVYvCXspkw2JE4+QHMNtubUuSdZ2/oykxEZ9lrU50XqLDSWaow1C3mhovHnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by PA4PR04MB7887.eurprd04.prod.outlook.com (2603:10a6:102:c9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Fri, 26 Jul
 2024 10:10:41 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%5]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 10:10:41 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	pav@iki.fi,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 1/1] bap: Update default sync_factor
Date: Fri, 26 Jul 2024 13:10:15 +0300
Message-Id: <20240726101015.263668-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240726101015.263668-1-vlad.pruteanu@nxp.com>
References: <20240726101015.263668-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::10) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|PA4PR04MB7887:EE_
X-MS-Office365-Filtering-Correlation-Id: de4ca81c-c02b-4ad1-8aab-08dcad5b346e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RIalieFW3b0QoLk4mZSBpuR25OZR6gM8GWw1/v4i3DaSGG0ssO0ijQ77VrZ8?=
 =?us-ascii?Q?uIZajFsN/0+Oa+lfCrKbBn1qjR631MpThAuqqa4lUIo0XbSP/tVgaxbQrNX8?=
 =?us-ascii?Q?RSxbPah1BIIQm/YnxLqXO1gsgdOrLL4WhfTw9j2dZ9FhK5b3dzwa5egHpJRh?=
 =?us-ascii?Q?kfA8wtDAgOp5lwY3vl70IRRobRgm638kHtBRhaXl8L3Iszf0mmFP5ErbTNym?=
 =?us-ascii?Q?s7DaTSoVZuaA447Mz3sI8H8h4lQK9VUPk5A6G70ETbQfdW/yB1PESOXmRoSc?=
 =?us-ascii?Q?N23HWbM4OloupX+MFemBMCE2/YePIbN9DzWh62G97XrIbsATyWakhgj3IYk9?=
 =?us-ascii?Q?ft7RpIRO9uwpYit5o0dW46ueUCu6h5pIRqSmWq9DNpvSJl2CNMLVRJkzOYlw?=
 =?us-ascii?Q?cZRmQi2O/nfb1Qw2V+GLpC7EfqsR1fDs5C9MpI7QasCKyBtD1fzFjr9nkiI0?=
 =?us-ascii?Q?tXSS4H6IP6PNDundMSoP83uqX8QFu7ZpaWeHjkjoyivzXmGQ6EFZqyBdkg4T?=
 =?us-ascii?Q?u7C5Aw3Wx3JubTQIR7UmFLGbM/nAqVXAgWDQECS2QiJRsnDs/RpzeC0EEGL6?=
 =?us-ascii?Q?wmuDwJ+r9ZYwafKUUSv4RrhtMbCQ4RgQ467zWTpcsM853bzxIfcoPYSqZXl1?=
 =?us-ascii?Q?Tr+8rIsOQ5Tno5PabIYucRG4Moeg3a6EM4PsrLgxKOFpcYPa7iXPAd4WqSVG?=
 =?us-ascii?Q?5ovTkpX2yXdwjQyE3ZEJafG5JcblR/+vlzBuoKjA5KSreaRZgcjmiNjvHURh?=
 =?us-ascii?Q?9jLth+uSqhOsBVxzqBI+ibUcFWxRUam3hmgKnbdF8uOFvlH0G1RhN16TucrV?=
 =?us-ascii?Q?F/ZfNZCesnAeufW/lz0fTXNpCHdIYa+r9nVnv8lesq1IDlcYk3om31UA3GJ2?=
 =?us-ascii?Q?tzehrYOZaYDsgmbqKEr8BjSCRt5gMyJfeg8T7l04O9VUcxkOAX2pL91nkc5D?=
 =?us-ascii?Q?It5Y5UweoDRJtrPg10Mlqq5jCn2KFcR1IpeCRcRVjB+EOp9gI66Beb+iy/DZ?=
 =?us-ascii?Q?DQO8Z3JrKleSS/0Zvr/ZJAZx2uKFuAFSrGGzGQtxHko+EAKm2HwHkEb3VNnp?=
 =?us-ascii?Q?YZqBDLyqzJGnMToG98jHmqyQZ+Y8iQbz5eDYTpLjWjYxlHgfMwn7Gid54RQz?=
 =?us-ascii?Q?SjX59rWAXVI1N3EYbEfLm0EnnLO0qihjvIVgCdI0PYSSdGX8DiN6VFZSoNUH?=
 =?us-ascii?Q?1gxQ8ilZgqfmuTwDkqR61dcIlbX1lSrbt6tXpsKt+kF6XPbLl1A64zbLALSd?=
 =?us-ascii?Q?WZfcCwg6eW6TgC0yai7upCgWTp78WoZFSIIiPcZm6FndrIseGiceycAQagTc?=
 =?us-ascii?Q?bJv/oN8IJOs5PL/IAh8bZnA+BjVRf62m1+e9omVFyz7tgngCqpirX27PtLPv?=
 =?us-ascii?Q?eHbFjj8cusda0AjMw1DCWbMJestVGrbyyMeyABmbNm/HbsT7KA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1Cf2adM0aau8fingBnOANepdFubyaJRD6pP+vdoLomgYkLDVQV4DiEZljH/Z?=
 =?us-ascii?Q?1D7nUcKsQHxhjfiTVWatw4yXEEKlF9+0LFwH1p5lab6EV1BxKgsrawNCsfDr?=
 =?us-ascii?Q?1j2jQiZahbLslZVNp+rfL6oY9K15sodQMPgbLrbFGRf+I/89rAyQx9Dl3gxA?=
 =?us-ascii?Q?vYkU4t1TBUppX/NTRH736Rwd4tVqLdJXteSPAtG+IJKOkGIVe8D7zQ4gYNjb?=
 =?us-ascii?Q?msO7xMrK7FBofhwJhKFZ28/ZLNn3DZAaQpDkx/fHNk3SrqPSphL2lFQSO+oH?=
 =?us-ascii?Q?hPDU4Jor/JXBQtoVOX7f91dIyF3BJ05KNyE2cZl9ZgY2uYMLXOqDwQmswLJg?=
 =?us-ascii?Q?ZBTLD35kUG/eG2k0hyMfteBH6+AU2zbFXXKky2TZX0jTPJ1Q1hrJyH0HT6aF?=
 =?us-ascii?Q?qqqEUhLrhT2Wga93IaS1eaNeObO9HUZUn+v5L/JRMHCYjt5vQQA2fuqxcRTW?=
 =?us-ascii?Q?gdCEjDlvwbHgPCGLhHc6KXLj8xCg4MjyZHlFIxtK2zhuTfQLdR8hvAlywvfH?=
 =?us-ascii?Q?MuaX0pXn7GvuGj+UIVJQuUXdo1VDhHc5eBLBsbZMGUen21NGH5t7jChX9u8t?=
 =?us-ascii?Q?zLIQvFsThjTTqmIx8epI5UOUtlnY5LSEZLo3eWYIpH9U+Dl0a5i95+fLBI0e?=
 =?us-ascii?Q?g4KOczy8BdleRq53jttpcpR2XYijnCpwRxjC5PlYf6FLyJk1wCXGZwVKEN9S?=
 =?us-ascii?Q?JlTUsWpQ249THYj5xNFna4bByV2+G3ChTWUkGQ71Jg8skcoeA39S82cwZAFK?=
 =?us-ascii?Q?kSs2pYJuiT2cn9q1jW20ZPQBQjZKK88Wdd3qZ3CXnENFL4xb9IwNfS/lIyLw?=
 =?us-ascii?Q?Qj8A9XHRrwGtpZqpYZWoqJUzhMJVyTQ8hz8Gi5lnqEksC1YBfiMaG9BvvdwK?=
 =?us-ascii?Q?MlENKpUy9frith8nGuM8/8q8qB4c5X9vpZf4P2TGTlvMjo/6hXeYLwYzCCYx?=
 =?us-ascii?Q?RXhqEmsQ7BRwOwtlKhZOH1Dq+inql8WJ8Cyv0uZ5I4TPmcIibg7I36Tu5pPQ?=
 =?us-ascii?Q?P029vk6U7QGLQ+abLcXDX+chFepSLol1LVRSKBDEiCVhw4lOLMb2KYWorIJ8?=
 =?us-ascii?Q?wJSl7xjVoKrUniJC9BulCv6pRTslBJhYXghqTDhXNeepvlc9P7sDiDykIgnW?=
 =?us-ascii?Q?BNXewiMJ6u+/M2FontQU4N0FzbDcA0M4CwDw8H+99bArduKvKA2rK8Zn/m2K?=
 =?us-ascii?Q?oaMGLYi5gywA/NJYu41TOUAlx9R7CE9ImFtASLTo3Anvk4XEl6qiKVFF/j1Y?=
 =?us-ascii?Q?VT+SKDK0zPAzEABEyaiqAUyZnDD9Twy/UxUXXvHTZ7MlmCj0qyJSWoM+DMok?=
 =?us-ascii?Q?FKx9bIncNJE3f1qtg46AZteadqzOnPQYwAMNqztEk9uVWdqVe+3CSGIsAsPf?=
 =?us-ascii?Q?Bl427aJMQH1YagwYl7ElLPHvCvGXeanyY5yKKv90OIidgDKEjxv5upkG7FsX?=
 =?us-ascii?Q?HYgyet3j3WcwMEIFFMe47r41YNEcrkbqlsSoeglz+gwVEKA2ITawyzGI1vbu?=
 =?us-ascii?Q?Cpvy2LoT7oNW7iacymHsZdcq3/dxzXyAyLvYz+yhGBoJzHomCtEJPXdmAIip?=
 =?us-ascii?Q?HmJD5ysTCa3Njti/TKhUweVQrPV7P9cxnZYgRk6j?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de4ca81c-c02b-4ad1-8aab-08dcad5b346e
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 10:10:41.4943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZNlj9erEu/2biufnw/FKAW7w0qe1trXhtITekp/whTLNvVZqRJUpTM2ZWtvGXl7d0mjMVbo0xukermYTPmfsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7887

Formula for extended advertising interval set by kernel for Bcast:

interval = (qos->bcast.out.interval / 1250) * qos->bcast.sync_factor;
sync_interval = interval * 4;

According to CORE SPECIFICATION Version 5.4 | Vol 4, Part E page 2451,
the extended advertising interval should be at least 0x20 (32). Thus,
interval should be at least 8. If qos->bcast.out.interval = 7500,
it follows that the sync_factor should be at least 2.
---
 profiles/audio/bap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 53f430d66..ad722ebb0 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -871,7 +871,10 @@ static struct bap_setup *setup_new(struct bap_ep *ep)
 		/* Mark BIG and BIS to be auto assigned */
 		setup->qos.bcast.big = BT_ISO_QOS_BIG_UNSET;
 		setup->qos.bcast.bis = BT_ISO_QOS_BIS_UNSET;
-		setup->qos.bcast.sync_factor = 0x01;
+		/* sync_factor should be >=2 to avoid invalid extended
+		 * advertising interval value
+		 */
+		setup->qos.bcast.sync_factor = 0x02;
 		setup->qos.bcast.sync_timeout = BT_ISO_SYNC_TIMEOUT;
 		setup->qos.bcast.timeout = BT_ISO_SYNC_TIMEOUT;
 		setup->qos_parser = setup_parse_bcast_qos;
-- 
2.40.1

