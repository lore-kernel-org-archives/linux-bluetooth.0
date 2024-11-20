Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AAE19ABA3
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732098388; cv=fail; b=eTouQZTQJ2ffK3XgBulpvhuv8RqcbCpuQVIeN/XHqtyR4YgiOvh9xzKO/D/jaQDykRiJXtN+sM1AZqQHssC7wkw56edxRfuUPrTzNDy29m8i56pMEzoT8tmCSFsmZKCgW2wUkbtyWrXk0AE2TajmiM6LW0BH+tNTxYiWNOblPps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732098388; c=relaxed/simple;
	bh=nd89I5G5ALyXPoM5r6oP3XUJj0/eJvT7kIliZKRxUuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uw6eZHq1Rc0uyL0W7wHn0TPJB7zWaHPc2nxU2eOuPv0UNo3FtHtGd4bmqJrQ4ASQ6jxtVA6yjXfrXh62J+Lo1wEvpmKCe6oWwbUIsZJtvkNS6I+2lI5izyoJ8//StMAz83M7vWLL8mj2GRZ8PQoa8Q/k1g8Q8Mw0hZQCwm4ToxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hF5EZ2ZR; arc=fail smtp.client-ip=40.107.22.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hF5EZ2ZR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMM0SkQm09wcJmqNhWMOTH00Mn4BWSJHWfyifFtQW0Vnm6kDgOffavVla94hXJ1Z99PN5B3QW88y6dwoN7w1vFmGASMzmw2x9EfIEGA87bBb54u+qJjGr8puZ8l7dM3dH+fyW+KE1vIg3UqXtOyK9HICLvBHrRoif5sNovapzxTuyuwExd14D75YaeRsCmP+OEGw775czAQjWaomlqTIeWDjPT2gpoEFSI5GiWXgv4ypuyWRM5xK41f/7ZQ4d3OBO38XlZq242gfSkVllKMaI5+QeEXlDpsAIXb3E7JwveGfnB++PfBKrESl6dHGSylZ1BbGTprutzSeVaz3aOErrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gesZWfGn9keodu/wYs5MwLhYNEVzE1s6U/gD38uZOw=;
 b=p8YIRzKDUzifELSY/whG9Y8OaZ4tCq7FozuXXxlWFQSDagaaLPssZkie5O8kINxJkzh2kgX1O36Ee5urJblBqOsBVaXCzUVMJXao9UOt0n7+usGCYL4ltH8/YPr5hUpcj+vpWGS48SNw1WfsOhi8UVaVyDf0Ns4gkySevLbhRvp+UGXBc29GEqTFuG/2yAXcFMk/slzm4FZZQd8glchFyEI8X1p5FF1zrFsBvkKJA3IOZ5fEdzLSvjT03mY86SK6od7NVleDpyCNAZqrHtzgV3fgPuPvoYbO2zCPk98BpIZ0W91zLrOK5sypJsx7lEjN2d9Vcf4XSk/3RjMenlBGrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gesZWfGn9keodu/wYs5MwLhYNEVzE1s6U/gD38uZOw=;
 b=hF5EZ2ZRb74otKYWGCL2lKsh3Xg8/25Nw5qtT2ac4vVGAuOGk45+yatseKLzQZou9Mm5LM5Je/S11YUWToAnarUUE3C+67QA1PIeBHwfq10Kvu8LFA+fxaCfjkjx6ByQb1v3jV7sdL1k4qsZv2xu/T4tM3oN4EDsqvzUVMymo7rw8hnmM59J+Yv+Qii4ECaIQ305WCkl7m5hLCbfbsKmoW0egv4fjJL3rscbFr2oqquitopWXpNW39iBmc0aKwp/zcZPxrtvqf6AGywYo59Q4FRVsk7cr0x4BjVXVjfS/RaTqmeYDxEhk6bdzUuHiko8/KzF4tvt3yinX+Lt8C4Kag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI0PR04MB10389.eurprd04.prod.outlook.com (2603:10a6:800:217::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 10:26:21 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 10:26:21 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 3/7] bap: Rework BASE parsing
Date: Wed, 20 Nov 2024 12:25:57 +0200
Message-ID: <20241120102601.38415-4-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120102601.38415-1-iulia.tanasescu@nxp.com>
References: <20241120102601.38415-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0089.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::42) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VI0PR04MB10389:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ce8bbde-c39a-49ac-8d13-08dd094dc720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FYVEmdlT+3ddpyBybbiTj5xCLw9SauyK56IyaMPm92C1ftCQniJMW6VAQdFZ?=
 =?us-ascii?Q?7pgdJHNyApfqu4f/jbzuV3X2SBpTRGOHb6ho4VOAldaA2FPttXy+R1rIDqmM?=
 =?us-ascii?Q?upihZW3bcyZsOv++yA/5a9ZbJbrv7z/t7wuxyiDwRiWfhIE2/sQ/LXjE+n9Y?=
 =?us-ascii?Q?fCitOOb2/nRMfunR86PN5cYa2T1Lf/E7GIfKam7KiYsScMpXGK5tOvjGTvQ5?=
 =?us-ascii?Q?nzYqEtntgYo5Ab2WLaPhy4Rg2go7yYFO6fOMLYbp2as1QkDRlcGx+0H85wom?=
 =?us-ascii?Q?SnzES8/3TGTOzwkBXMbctH4TxYBI+nryYEx131LBoq0EIRjufUidxIwkfQJB?=
 =?us-ascii?Q?hYeIoU32J3b0+rgJwDRXPusdlgv4gGu8ZTo9RwfwRbNGSM+zopAVKR3k34rM?=
 =?us-ascii?Q?OP7vX75QDLbCSK6xfXONQtoqo2mmMJlYusEZ5D3qaNXkpYE+aQ+EjekQUSLY?=
 =?us-ascii?Q?y09+M8dQTClcvhnVbyxI7eAfqgD8Jb+rqCpOjp/N1c3sff9Jzj9o6qDyK5Pc?=
 =?us-ascii?Q?nS+/l9TaKxDyyq8dGY1XTOUwuoYGF3uOTawSi0QOSL66j4LK5UYOkCSqhGsg?=
 =?us-ascii?Q?kk+v85JYHPGhOPkfB7XxfrNKbTJA5gs5omUq0tgqCDj+3v8VgumDdVMMlp90?=
 =?us-ascii?Q?gMvHfjwbzrXJWQZ1BAlzdbU5rDXXvnxE/dHJKn9c7yESX21GkXL2IGEG5K7f?=
 =?us-ascii?Q?HjFbkCbWhI1L01gjXBQPOLGknaf54eVEKFh2kZHJvxGiq1HX19dVL/UyVArf?=
 =?us-ascii?Q?+gCQ6/0uGvvxFu7Y5LE9+Rmda4Ajr+fBCG2Y+/W4nw16yh3SBvsxPfBmqZYm?=
 =?us-ascii?Q?6+/RuPkbAAVFkOHPDsYDpy8ogmo68JzZSYH015RMoCMHh6IB5zo2arfEw1l/?=
 =?us-ascii?Q?R/5nzKEdhHP0Jvmq3Xt8K+8x2LxdY0MLpkc1kB0T5rzbtaeROpbQZY//6pPj?=
 =?us-ascii?Q?LMDgE13lH1jF7wk+NBSc58DA9gSFEOlU9UqTZlaVraFBuLviRsknhNM0QZcN?=
 =?us-ascii?Q?/BhNm9L4ZqSeSA1YYmOwpLoaxgWgW5lb3HnRi7KQXVNQU1+zbA8iNYmWeyp2?=
 =?us-ascii?Q?okMYAxGhf3tXGRYDbhuyUaW+apxob8kMeE9Sg8LrKML4uRlO7+Kdl1nJkoIc?=
 =?us-ascii?Q?AWZikBIpHhjGD8w26JgUmWAdu6oA3Dj9rVD8Wffi0RoCDvQ+fKbSI5CCKiij?=
 =?us-ascii?Q?2v/uXtp+pBKmZd1GfDB+iZ3EXvTEV6jHYMmtpoqwUlgN/QzG4dvHGatzfJRD?=
 =?us-ascii?Q?vxBzoKQHU4ycWco4woVKx2Xu/XfynaetBEFNwx2RQh8gd7ai+9td72WdUtal?=
 =?us-ascii?Q?yY9Ykid2KvRNG4VS7Pcc0Q5m?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rJABZRDKL444TLoXoE4ISJEmVWExTog4QgCSxYeJjqEQfP8nK1E+vx2P2XJ8?=
 =?us-ascii?Q?XEMPZopOBXHrL5+rEPkEvTRNVtXZYbqb+HGnv79TkLhFbSnSL7rlovcc/XDm?=
 =?us-ascii?Q?ct9bRD1+SSrbP6O1NnW/eCvJZja56Egb4VdS0AB36UXJP07wGUWESMsRu+Q/?=
 =?us-ascii?Q?uLL/HKC+XHW9Yv9ciix6bYFk98qS1+dcl6uuCYtZOjIE0HuhlBWRE/PFOGwz?=
 =?us-ascii?Q?bd1Pth5A7LdFFPLJ1QVpXHcuLxOa+UKEauXvN2wEjB1mRhEdKeALtor/FYqR?=
 =?us-ascii?Q?uPZfGSR0qOct02Tyj57/G5Ky/GMm8MWQ4z71y3qcevgUd86PUACPCW5k2w9c?=
 =?us-ascii?Q?ZQ6KXG+w97FJ30F+qmcmAPzv/hSoGlPuNTmxXXJ8MuObDVu1+0m9bhpaHvVi?=
 =?us-ascii?Q?+NCgpOszW6vjde4yvVT3KjVafLT4DvFTw+lr8k5uTRj7Wa8gxPXaKHQbq2BI?=
 =?us-ascii?Q?yvomgYOD2pDqpdU2cVtA7+cW+wSSMSaHw2mkSeZ79pj2s/xIojCl4PCdjFEx?=
 =?us-ascii?Q?COAAc4/T8VetyL9dZycD2M2U3mH4HGXA6W8dK2WvYIzJobUqgQImB/izx7b9?=
 =?us-ascii?Q?nkwijIsOAzQNtLGBtp7lt7OT+aevDg4z9u4OBVK5j5oW5yMCwhxL+LvrSH2q?=
 =?us-ascii?Q?24R6tQmjWXCaKVxaKV9UGT70cfKbvyTApfh/QOdDD3K5zEB40uFNrIDTO/1X?=
 =?us-ascii?Q?Wrf1xeEh5fL/mlwjFD0+s7p/WtSA69lbpXDQnyxhjaeXGaBOW0uBMcJmhH32?=
 =?us-ascii?Q?EtYf1BgNman3ssj+8e+8O5qxX4ei/fTrrp/JDvIsJVAdcc9bCozNgMsYiY6t?=
 =?us-ascii?Q?Axvsf0mzpP4yDHzYOtdUMk71FKfWhmPXQ9pG8HyKQ7PC+m9l5Gi9aiYwLc0t?=
 =?us-ascii?Q?IlwL//LSn2lK704eITaEIfI9aR+D1fyppIFMljvYJqYR88HB2U5LbmkySoos?=
 =?us-ascii?Q?NZkgrn+kAW9/3OU1qUAHShz3xtQNp3x/oA0Tc106HKconEsAx4ytixJdKKES?=
 =?us-ascii?Q?thbRtxVxw/6kcWBpnHFkgLNX1KngtWY7oOdasAMecx5Wguv0XuecX1hJidIJ?=
 =?us-ascii?Q?tnmWjpYEcoQtDaFJmD2Apk+JUHeF7Cq7pE3MocIkxfv14CcK6+f8q93tYO7W?=
 =?us-ascii?Q?QtpTd7kxQrcnEq26BsuyBxWDzYy+sZ3/laC1zhEu+4oVig/vmbq3PcMrOoH3?=
 =?us-ascii?Q?PZbjROWvxXKsOMkI8xM0bJ0gWFjM7NH4Km50kjmG0LCMYF4czwV4Yy0GQUfX?=
 =?us-ascii?Q?S2UENSv8g6bzfVj+FqXPlzPb+ypBe8xHq7b0ZQ2XtvN6PH5PXdX7d1j9EuCc?=
 =?us-ascii?Q?+0ka8OHHEk+O/GniGHXSzwciafk0WU+97vyjiKlPmxS2P8HTS462K4QK8FPd?=
 =?us-ascii?Q?tfHDOmG+rrwvZ31YkdKFtd7DlTY0z4Wrs/5uzn2hhnWlu1nhpc/SmisJ0YeC?=
 =?us-ascii?Q?Z+thBLBBG+qfM+tow9JlPZHge1XGlXVFUWz1EUaX7dhhXBaIR6xBJdQikVU3?=
 =?us-ascii?Q?wmU6i1naRmlLuJI43DFhvERlNF/vcg1jD/oOSuXhVq2W71uCfcVea5mo+5mW?=
 =?us-ascii?Q?wT6j3HzLaYEnAxNzGCpruCyRmDs1Rw9Kob82rZ7CvCKCrcatjwKzm0rNfcB0?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ce8bbde-c39a-49ac-8d13-08dd094dc720
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 10:26:21.6753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YsTTOwqVt2QgyrsNUUQv0mtt/k20bgRKaAs1AxUbtWLrjF6wjaPyPXkaRS3sxU9zHJYtU4L5VEOHNiq3tUY5kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10389

This replaces the internal parse_base with bt_bap_parse_base from
shared/bap. A bis callback is added to handle parsed streams.

The Broadcast Assistant implementation in the BASS plugin is also
updated to use bap qos instead of iso qos, since the BISes are
now parsed along with bap qos structure.
---
 profiles/audio/bap.c  | 207 ++++++++----------------------------------
 profiles/audio/bass.c |  30 ++++--
 profiles/audio/bass.h |   2 +-
 3 files changed, 61 insertions(+), 178 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 6acb0895c..2a194d709 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1034,13 +1034,6 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 	}
 }
 
-static void print_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
-		void *user_data)
-{
-	util_debug(user_data, NULL, "CC #%zu: l:%u t:%u", i, l, t);
-	util_hexdump(' ', v, l, user_data, NULL);
-}
-
 void bap_qos_to_iso_qos(struct bt_bap_qos *bap_qos,
 				struct bt_iso_qos *iso_qos)
 {
@@ -1093,15 +1086,16 @@ void bap_iso_qos_to_bap_qos(struct bt_iso_qos *iso_qos,
 }
 
 static void create_stream_for_bis(struct bap_data *bap_data,
-		struct bt_bap_pac *lpac, struct bt_iso_qos *qos,
+		struct bt_bap_pac *lpac, struct bt_bap_qos *qos,
 		struct iovec *caps, struct iovec *meta, char *path)
 {
 	struct bap_setup *setup;
 
 	setup = setup_new(NULL);
+	setup->qos = *qos;
 
-	/* Create BAP QoS structure */
-	bap_iso_qos_to_bap_qos(qos, &setup->qos);
+	/* Create an internal copy for bcode */
+	setup->qos.bcast.bcode = util_iov_dup(qos->bcast.bcode, 1);
 
 	queue_push_tail(bap_data->bcast_snks, setup);
 
@@ -1116,170 +1110,37 @@ static void create_stream_for_bis(struct bap_data *bap_data,
 			NULL, NULL);
 }
 
-static bool parse_base(struct bap_data *bap_data, struct bt_iso_base *base,
-		struct bt_iso_qos *qos, util_debug_func_t func)
+static void bis_handler(uint8_t bis, uint8_t sgrp, struct iovec *caps,
+	struct iovec *meta, struct bt_bap_qos *qos, void *user_data)
 {
-	struct iovec iov = {
-		.iov_base = base->base,
-		.iov_len = base->base_len,
-	};
-	uint32_t pres_delay;
-	uint8_t num_subgroups;
-	bool ret = true;
-
-	util_debug(func, NULL, "BASE len: %ld", iov.iov_len);
-
-	if (!util_iov_pull_le24(&iov, &pres_delay))
-		return false;
-	util_debug(func, NULL, "PresentationDelay: %d", pres_delay);
-
-	if (!util_iov_pull_u8(&iov, &num_subgroups))
-		return false;
-	util_debug(func, NULL, "Number of Subgroups: %d", num_subgroups);
-
-	/* Loop subgroups */
-	for (int idx = 0; idx < num_subgroups; idx++) {
-		uint8_t num_bis;
-		struct bt_bap_codec codec;
-		struct iovec *l2_caps = NULL;
-		struct iovec *meta = NULL;
-
-		util_debug(func, NULL, "Subgroup #%d", idx);
-
-		if (!util_iov_pull_u8(&iov, &num_bis)) {
-			ret = false;
-			goto fail;
-		}
-		util_debug(func, NULL, "Number of BISes: %d", num_bis);
-
-		memcpy(&codec,
-				util_iov_pull_mem(&iov,
-						sizeof(struct bt_bap_codec)),
-				sizeof(struct bt_bap_codec));
-		util_debug(func, NULL, "Codec: ID %d CID 0x%2.2x VID 0x%2.2x",
-				codec.id, codec.cid, codec.vid);
-
-		/* Level 2 */
-		/* Read Codec Specific Configuration */
-		l2_caps = new0(struct iovec, 1);
-		if (!util_iov_pull_u8(&iov, (void *)&l2_caps->iov_len)) {
-			ret = false;
-			goto group_fail;
-		}
-
-		util_iov_memcpy(l2_caps, util_iov_pull_mem(&iov,
-				l2_caps->iov_len),
-				l2_caps->iov_len);
-
-		/* Print Codec Specific Configuration */
-		util_debug(func, NULL, "CC len: %ld", l2_caps->iov_len);
-		util_ltv_foreach(l2_caps->iov_base, l2_caps->iov_len, NULL,
-				print_ltv, func);
-
-		/* Read Metadata */
-		meta = new0(struct iovec, 1);
-		if (!util_iov_pull_u8(&iov, (void *)&meta->iov_len)) {
-			ret = false;
-			goto group_fail;
-		}
-
-		util_iov_memcpy(meta,
-				util_iov_pull_mem(&iov, meta->iov_len),
-				meta->iov_len);
-
-		/* Print Metadata */
-		util_debug(func, NULL, "Metadata len: %i",
-				(uint8_t)meta->iov_len);
-		util_hexdump(' ', meta->iov_base, meta->iov_len, func, NULL);
-
-		/* Level 3 */
-		for (; num_bis; num_bis--) {
-			uint8_t bis_index;
-			struct iovec *l3_caps;
-			struct iovec *merged_caps;
-			struct bt_bap_pac *matched_lpac;
-			char *path;
-			int err;
-
-			if (!util_iov_pull_u8(&iov, &bis_index)) {
-				ret = false;
-				goto group_fail;
-			}
-
-			util_debug(func, NULL, "BIS #%d", bis_index);
-			err = asprintf(&path, "%s/bis%d",
-					device_get_path(bap_data->device),
-					bis_index);
-			if (err < 0)
-				continue;
-
-			/* Read Codec Specific Configuration */
-			l3_caps = new0(struct iovec, 1);
-			if (!util_iov_pull_u8(&iov,
-						(void *)&l3_caps->iov_len)) {
-				free(l3_caps);
-				free(path);
-				ret = false;
-				goto group_fail;
-			}
-
-			util_iov_memcpy(l3_caps,
-					util_iov_pull_mem(&iov,
-							l3_caps->iov_len),
-					l3_caps->iov_len);
-
-			/* Print Codec Specific Configuration */
-			util_debug(func, NULL, "CC Len: %d",
-					(uint8_t)l3_caps->iov_len);
-			util_ltv_foreach(l3_caps->iov_base,
-					l3_caps->iov_len, NULL, print_ltv,
-					func);
-
-			merged_caps = bt_bap_merge_caps(l2_caps, l3_caps);
-			if (!merged_caps) {
-				free(path);
-				continue;
-			}
-
-			bass_add_stream(bap_data->device, meta, merged_caps,
-						qos, idx, bis_index);
-
-			if (!bass_check_bis(bap_data->device, bis_index)) {
-				/* If this Broadcast Sink is acting as a Scan
-				 * Delegator, only attempt to create streams
-				 * for the BISes required by the peer Broadcast
-				 * Assistant.
-				 */
-				continue;
-			}
+	struct bap_data *data = user_data;
+	struct bt_bap_pac *lpac;
+	char *path;
 
-			/* Check if this BIS matches any local PAC */
-			bt_bap_verify_bis(bap_data->bap, bis_index,
-					merged_caps, &matched_lpac);
+	bass_add_stream(data->device, meta, caps, qos, sgrp, bis);
 
-			if (matched_lpac == NULL) {
-				free(path);
-				continue;
-			}
+	if (!bass_check_bis(data->device, bis))
+		/* If this Broadcast Sink is acting as a Scan
+		 * Delegator, only attempt to create streams
+		 * for the BISes required by the peer Broadcast
+		 * Assistant.
+		 */
+		return;
 
-			create_stream_for_bis(bap_data, matched_lpac, qos,
-					merged_caps, meta, path);
-		}
+	/* Check if this BIS matches any local PAC */
+	bt_bap_verify_bis(data->bap, bis,
+			caps, &lpac);
 
-group_fail:
-		if (l2_caps != NULL)
-			free(l2_caps);
-		if (meta != NULL)
-			free(meta);
-		if (!ret)
-			break;
-	}
+	if (!lpac)
+		return;
 
-fail:
-	if (!ret)
-		util_debug(func, NULL, "Unable to parse Base");
+	if (asprintf(&path, "%s/bis%d",
+			device_get_path(data->device),
+			bis) < 0)
+		return;
 
-	return ret;
+	create_stream_for_bis(data, lpac, qos,
+			caps, meta, path);
 }
 
 static gboolean big_info_report_cb(GIOChannel *io, GIOCondition cond,
@@ -1290,6 +1151,8 @@ static gboolean big_info_report_cb(GIOChannel *io, GIOCondition cond,
 	struct bap_data *data = btd_service_get_user_data(req->data.service);
 	struct bt_iso_base base;
 	struct bt_iso_qos qos;
+	struct iovec iov;
+	struct bt_bap_qos bap_qos = {0};
 
 	DBG("BIG Info received");
 
@@ -1329,7 +1192,15 @@ static gboolean big_info_report_cb(GIOChannel *io, GIOCondition cond,
 	/* Analyze received BASE data and create remote media endpoints for each
 	 * BIS matching our capabilities
 	 */
-	parse_base(data, &base, &qos, bap_debug);
+	iov.iov_base = base.base;
+	iov.iov_len = base.base_len;
+
+	/* Create BAP QoS structure */
+	bap_iso_qos_to_bap_qos(&qos, &bap_qos);
+
+	bt_bap_parse_base(&iov, &bap_qos, bap_debug, bis_handler, data);
+
+	util_iov_free(bap_qos.bcast.bcode, 1);
 
 	service_set_connecting(req->data.service);
 
diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index 6237f5acc..d3b35f62a 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -92,7 +92,7 @@ struct bass_assistant {
 	uint8_t sgrp;
 	uint8_t bis;
 	uint32_t bid;
-	struct bt_iso_qos qos;
+	struct bt_bap_qos qos;
 	struct iovec *meta;
 	struct iovec *caps;
 	enum assistant_state state;
@@ -399,8 +399,8 @@ static int assistant_parse_qos(struct bass_assistant *assistant,
 				return -EINVAL;
 			}
 
-			memcpy(assistant->qos.bcast.bcode, iov.iov_base,
-								iov.iov_len);
+			util_iov_free(assistant->qos.bcast.bcode, 1);
+			assistant->qos.bcast.bcode = util_iov_dup(&iov, 1);
 
 			return 0;
 		}
@@ -592,7 +592,12 @@ static gboolean get_qos(const GDBusPropertyTable *property,
 {
 	struct bass_assistant *assistant = data;
 	DBusMessageIter dict;
-	uint8_t *bcode = assistant->qos.bcast.bcode;
+	uint8_t arr[BT_BASS_BCAST_CODE_SIZE] = {0};
+	uint8_t *bcode = arr;
+
+	if (assistant->qos.bcast.bcode)
+		memcpy(arr, assistant->qos.bcast.bcode->iov_base,
+						BT_BASS_BCAST_CODE_SIZE);
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
 					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
@@ -648,7 +653,7 @@ static void src_ad_search_bid(void *data, void *user_data)
 
 static struct bass_assistant *assistant_new(struct btd_adapter *adapter,
 		struct btd_device *device, struct bass_data *data,
-		uint8_t sgrp, uint8_t bis, struct bt_iso_qos *qos,
+		uint8_t sgrp, uint8_t bis, struct bt_bap_qos *qos,
 		struct iovec *meta, struct iovec *caps)
 {
 	struct bass_assistant *assistant;
@@ -666,6 +671,10 @@ static struct bass_assistant *assistant_new(struct btd_adapter *adapter,
 	assistant->sgrp = sgrp;
 	assistant->bis = bis;
 	assistant->qos = *qos;
+
+	/* Create an internal copy for bcode */
+	assistant->qos.bcast.bcode = util_iov_dup(qos->bcast.bcode, 1);
+
 	assistant->meta = util_iov_dup(meta, 1);
 	assistant->caps = util_iov_dup(caps, 1);
 
@@ -689,7 +698,7 @@ static struct bass_assistant *assistant_new(struct btd_adapter *adapter,
 }
 
 void bass_add_stream(struct btd_device *device, struct iovec *meta,
-			struct iovec *caps, struct bt_iso_qos *qos,
+			struct iovec *caps, struct bt_bap_qos *qos,
 			uint8_t sgrp, uint8_t bis)
 {
 	const struct queue_entry *entry;
@@ -998,7 +1007,7 @@ static void bass_attached(struct bt_bass *bass, void *user_data)
 static void bass_handle_bcode_req(struct bass_assistant *assistant, int id)
 {
 	struct bt_bass_bcast_audio_scan_cp_hdr hdr;
-	struct bt_bass_set_bcast_code_params params;
+	struct bt_bass_set_bcast_code_params params = {0};
 	struct iovec iov = {0};
 	int err;
 
@@ -1007,8 +1016,11 @@ static void bass_handle_bcode_req(struct bass_assistant *assistant, int id)
 	hdr.op = BT_BASS_SET_BCAST_CODE;
 
 	params.id = id;
-	memcpy(params.bcast_code, assistant->qos.bcast.bcode,
-					BT_BASS_BCAST_CODE_SIZE);
+
+	if (assistant->qos.bcast.bcode)
+		memcpy(params.bcast_code,
+			assistant->qos.bcast.bcode->iov_base,
+			BT_BASS_BCAST_CODE_SIZE);
 
 	iov.iov_base = malloc0(sizeof(params));
 	if (!iov.iov_base)
diff --git a/profiles/audio/bass.h b/profiles/audio/bass.h
index 257346374..845949117 100644
--- a/profiles/audio/bass.h
+++ b/profiles/audio/bass.h
@@ -8,7 +8,7 @@
  */
 
 void bass_add_stream(struct btd_device *device, struct iovec *meta,
-			struct iovec *caps, struct bt_iso_qos *qos,
+			struct iovec *caps, struct bt_bap_qos *qos,
 			uint8_t sgrp, uint8_t bis);
 void bass_remove_stream(struct btd_device *device);
 
-- 
2.43.0

