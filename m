Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012015.outbound.protection.outlook.com [52.101.66.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74D01B1419
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 12:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935809; cv=fail; b=K3mq/kdrYEljvK3yxdyp51Tj4bvGxeExjRh8t0JPbPv+zmln7BZll/6lKGY7qQY+juYfxOhvQCjn2+lwWQbPY6F3yME+F0ysYoqIYgiO0ycVZ3Q6a8KaTfsImjUFKOymQaKqW/NkeL3hPhOdawSl1aN5uCu2s5VsH3SwTYOD3Zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935809; c=relaxed/simple;
	bh=h1Pdzj+zfWtprnTo+hsm1383pgdYoXs7IMrbZv5XvPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mahkup5508ybKIFEkftX0Q6VRgDsFlFWb6t6OEluaTsiIrMHdljqJUTcLrkfGd/0nHWkG9WGAIVdLiTQK/jBT9FC6hDPWuDpTEaqwwLHPDEsYedVCBppDNrIBaEHEsOzJ74bTuDWscT3c2yaZCalX/X7BZxGZzObeOM0oIadZek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Iu5+nOki; arc=fail smtp.client-ip=52.101.66.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Iu5+nOki"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZIJEN/SGJWDjqX7okcWEvDlqxNmRFadcjjv/gw6So8CwCjVRl+WXUssiWTHUIQUfB0rhDJpGVrJMS7QipsuO4Kwmq7EAgzPAzd0ZlZmLcZ6rl3mB/Q43f/UMC2q5EO2nyfWRV1wRBSIjoMNPhKkejc8klUk85muIA+DiynYeRC2kCK2EYygW09RbN7McAZ+kfXCom1aGzRCdPu+gLLAY7sRVE9An5uQNLfZNRvIuhAj0LY/PCRmkOuqoguj4X04gmDkBcp2nmYqU4tWKLecOvHXkmX9la0iDfgH08kqCFKWy5ywsIKiTrs7Kec5VarVq4GrjHyjouCRZ9T5DTlQRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1h42R/mGDQqlayKksC1QpMJXK0Ml/b/moD93vmE16g=;
 b=j0oi557YyQvH3T5akjs5T8V1IBk8LBFybkCA895kQV8fv2vbVOwLEqxOH5pP5mpydhf4OP88ESRM9GT1HnAty64+UXGbB1VNTmh45DwYGSupIChY4s3pZCM6H1Yi2UsWQUttYKj8TLr2t7W/h1gpTnZWyYmBy3N17fwk703VIQOv6V4E7LLYCCFn3WuAPcsZVIdMWAAjM7dV/2XJR+bul/4dV3R+G5oZce+e5CycdF1gDN8qdT8pDAsAXaToHegDWkROq+KnO3Y6svVxcAx1nG49Ja6/QbVHhMbDmiNnsjgkeilsmMhXaGAzakaJZV1x8aA2mpHJk21bBk0eVNDFHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1h42R/mGDQqlayKksC1QpMJXK0Ml/b/moD93vmE16g=;
 b=Iu5+nOkiOag1+wrkA5B1wf8UGmx8CKsyGLtKJ/I08i8WrZJgvOZaZblPAKu7jsluuxsI/QZuzi5T80+dJn49CSRst8LVzS2l3HHPyltjnVj7R7gforh7y2+LRnKEzDzNyopSvsTpCN1ZGSxeTW9o1nBjdN2oGu7VnB1FFejc1RziSYfBzw0VqHMpg5AA5J7P1xpN77fxEzlWBAchRzQkOqvM7/0s3zHHoPiuE6bNWWoPlkgZM92AzDFPhWnBreZyF5L3JFyGQZNrmKGxaQmrTDrIrMswnKt4/zpn+6/vy8hX4Dig8U5/pXBn9q3l9sqk8LFdh6ilWms9tC+11FtUtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM8PR04MB7939.eurprd04.prod.outlook.com (2603:10a6:20b:241::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 12:50:05 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 12:50:05 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 14/16] shared/bass: Add API to check BIS required for sync
Date: Thu, 29 Aug 2024 15:49:16 +0300
Message-Id: <20240829124918.84809-15-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240829124918.84809-1-iulia.tanasescu@nxp.com>
References: <20240829124918.84809-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0090.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::6) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM8PR04MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c39a5c8-3543-4863-55b5-08dcc8291b0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?37XDvQm4GAmGqHeJxg44V0a+A6+RAlGD8d6wcgBG9iY9ICWChSssSBzFKtHb?=
 =?us-ascii?Q?9b7OnRJox/0muWqzaHeQF7ivDvI5Dka+Q3A92Zt4AxFguVFpB/OTv3kTwOX6?=
 =?us-ascii?Q?y9h94DRGTJzsnEQ5Ka+n+7uiiwLToV8NNwoRdbAxoSik2XuzFQ3YcTnBalsc?=
 =?us-ascii?Q?xMc3g8V1rxwcNWzFi6RwuF17EDTKtYL8d/1gStePa/ZruqIZKPEUPlDJNH0W?=
 =?us-ascii?Q?R0d9hBcrjZ8DV4H3NFHy3An8L40ke90LCrrY6gxEczK1/+eiqos6ntgRkPbU?=
 =?us-ascii?Q?uMZKq7ecLs2jdOfjMsIYLPdG3nNc4GjcaVLIL0+/0foULGDmJYFj+XNeHBcQ?=
 =?us-ascii?Q?QefOlt/ZOMkgMtJRRbVthUpl/Db4KLBFs2QpFiIgeei1a4bhVfWt2+Arn9Cw?=
 =?us-ascii?Q?oU3LETzSOpYHFaXcQlluOkuu2eOcXxZLeCECAiuY4xAW2yPtUomPjlSAKevh?=
 =?us-ascii?Q?yQp5IRka/n+wRQP9tarUYHLxo+OER9750w9es3mYI5GorEjiwjB1mO85+Vcl?=
 =?us-ascii?Q?vUIXNBAhol25zbnCFFy36d7ujKoz0a5WfQf+7MCCB52mHC1FuS/moCcWSVSR?=
 =?us-ascii?Q?bWnw0UKGuozGZQhhvKKaWfQISBhUP7BllN9rYOKmyluCmMYtb/BJ2/7fIMMd?=
 =?us-ascii?Q?ZYaS80CtWxSk4Ns4+QiFLNSJ91iAVcxQqr4GDGiXkYmvb3Erxx+CHZBhPlD+?=
 =?us-ascii?Q?sSDzTrDIqg7u5I6PNgHlRQY4IER0OEWSXQg35kV5c6UwQMHKo0DA0RJ/rWEm?=
 =?us-ascii?Q?izyupLrjdDQEPcghk09CgSX4X+ifwruWrmIBVKbI5+9tjnY8SOR3yS05Qm3+?=
 =?us-ascii?Q?MH/xwcp3juzYFe3ech0J06ERP0cSth5leTdHjY81LPoXIrSE2/6DYHYbFBwY?=
 =?us-ascii?Q?mU3rvYjKEOiTq041kTHAsOz2WPjz0u5UCLU6Rno1zB3SfZiodvqbEX7uhXpm?=
 =?us-ascii?Q?gUIx/mH/3BwLoDovzETzhiNo6BzdsKXOqpBxhTnt6Lp5+J3YteXffeH3mpZl?=
 =?us-ascii?Q?naZE7zyhFh6gbQyQsf98hbv364NxufvbvrQpm8xYDMKY923X15wQuRWn5bOc?=
 =?us-ascii?Q?kkcns/SyqD4y3NAOiXDPS9hXb5u6j9NpWWU705uLSIdfZZiCh6oXjMr8ufV+?=
 =?us-ascii?Q?LpyfLZvd49TFtYjDPT4EjtA0BDQfghOkZmmMSCR/Mmj4c71GLNShNx4wD8LQ?=
 =?us-ascii?Q?ppgPmsa2H6dPS7Try3uU4rL/Kv0BkYSF/4oCKVSH4pmIxF5cnBqYZR0Zk3y1?=
 =?us-ascii?Q?zkTog3hsfRpJVo4LoS312wodnryhjH4/UV5ZfUIj2Afb8XZ3TtqB6CCjK894?=
 =?us-ascii?Q?YjiZNPC+G7N0iYYa/6m03HNA+AvV1lW2OFMF4brb6Dta1Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qzIzTdzDBnNzFc7jZ3zUznkC6gPLgffE86MTN3Vl/a1U0Kd4w1A41uoHGDh7?=
 =?us-ascii?Q?7GNxemrY0TbL21VxCyWZAJ7hmgn8DzafFiJXd6wiXvNJIOUqS6XZu0Nmif5l?=
 =?us-ascii?Q?hxESDh1Y/cP7Khdl1eAMXWNFFoQCPNswOkkon8W0C0wc4daCsQDEStDhVXtt?=
 =?us-ascii?Q?NBb/sb3kP74ra0tfI8BYfutlP1vcBfENDKBAuu7dY9Q9MoAjP+L3v0x9o921?=
 =?us-ascii?Q?+ExKh5sc0Bjp2EMh3Vaq1d+Dapfph00GumZG/BO2X4xXizzl6HlKc7/fnfz4?=
 =?us-ascii?Q?XYDogd3bOJ4XyV7dkPAOjXqnaxmJPRKhoJit23r0zDRQ7Omv4Hw8Ii7NENjR?=
 =?us-ascii?Q?7om5KUfOrTJsOZMFa4plJZqwDQ7MeWw7cSOAGSYpujWu2RiDkno0eCamVP1a?=
 =?us-ascii?Q?27239urBIhRAUWFSbeYxYzJNUMSp8KsjiU5w0sposLygKWP/2wb5jNPeglZj?=
 =?us-ascii?Q?V9+eCrcx0+NffilD84lSZnZssSCoP8pOaRvMF/Tt5moI4SovUkzbIJw1/RB1?=
 =?us-ascii?Q?FOFaLv/pcFJt4bMFQBMNwkMn/pNELQPFTZLDxUFF0oBhGCPZS0dNF8PoNShK?=
 =?us-ascii?Q?XZBZ4JMkbqEj53Vpbllal1MmC4DYX/EEoVwsdAYyXfVK8baJPsLz5CFkyYaT?=
 =?us-ascii?Q?rA3KMDQ6qQt7g2Xg1aMQbVDWrt1x5rnl7bCWFzcTqInlrosgd4NWe+18/ag7?=
 =?us-ascii?Q?x7gdj4TkG1YX250snBcUFPo3CxL0MKVmzczqK1IgUu3LmCYk62LTwLU6VC+p?=
 =?us-ascii?Q?flQnZG/63VmX6ILFq8KPEq0XjaNWYIKloTUafb0DuA3vfjBgrabDlPE0eKkV?=
 =?us-ascii?Q?2O8UfibNdp07/uhtvbIdvvvlvwotnpTWT/DH+mShDFm56DB9KJwjmmoQ9Wdj?=
 =?us-ascii?Q?++IQzBG4xzEQvaqQH5zk5sY7PlGWeIhXOuRZxOdbxgCh4ncWPI6BJ6HRy/Su?=
 =?us-ascii?Q?2qxyV5vNyPO5BxcXDlfxp/aHJvJ778G1gQDCEwCEsNrrePs7eqg/HRB7iIHo?=
 =?us-ascii?Q?VU+J/p5gRxtxNwqbjJyBjFzyNpiMgV8KcOrslSgkaql00cUuhGx8xl2zp1p6?=
 =?us-ascii?Q?zzZzVkIe68XFb9QJ98dpEQkQyJZhhDW0iDsSAG/QZTNorEHK2RptLElu3ag8?=
 =?us-ascii?Q?FA41JVWXeSiYY15xakf4A8rlzGdtViAp5SR3B4b3lB5cFpsXqAnwWIequEd6?=
 =?us-ascii?Q?El38Zdl7sifbGX5MExPJ6h8Tk8pL0JCqy3rip8gbP8TLE6G7m1xZVnB73x3H?=
 =?us-ascii?Q?xIWFfFL5yV1De3TLx9A1XmHG4qlihS0ZimSKrsJHLqlbDaM1/6HXagMmLsEE?=
 =?us-ascii?Q?QLwOrAKF8LP/HMLy9sMatUlRxQnmNBpE8i4m/sfn3ZaHYDl8IWbvxfK2nZCU?=
 =?us-ascii?Q?ErfCwlA2J3M/qylT/94kXjsCWUUz6DS2zoeix87xyd7JOWOx8sfAxLsyuKHV?=
 =?us-ascii?Q?xdc2CrOPQACI/C8Ty9Dlxxdg1qzQoLOLxAYibsHKPwpAPfbSUaLckFmERioK?=
 =?us-ascii?Q?NrgqxyB0taKg8gCGUJqs83BLI26/bH06xoBjeVhtRx+8MnE6qV3RxL3un5O/?=
 =?us-ascii?Q?xIS7b/B9BSCkXwMJVY67uw8XyGPN4cqrYC2wzUFd2iV+pP1DvrqYnOgZAfP4?=
 =?us-ascii?Q?Kg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c39a5c8-3543-4863-55b5-08dcc8291b0b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 12:50:05.3923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FgjqrLO1wr1yuv9zV588UQck0hmLRH6wnBz9ElWsBN2EAlFu37rFsc8EiknnzF3ayb29aMhtIwOpSaLkYc+LuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7939

This adds a shared/bass API to check if a BIS index of a Broadcast Source
has been requested by the Broadcast Assistant to be synced with. This will
be used by BAP after parsing the BASE, to filter out the streams that don't
need to be created.
---
 src/shared/bass.c | 14 ++++++++++++++
 src/shared/bass.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/src/shared/bass.c b/src/shared/bass.c
index 8f02086a1..76287cfbc 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -1818,3 +1818,17 @@ int bt_bass_clear_bis_sync(struct bt_bcast_src *bcast_src, uint8_t bis)
 
 	return 0;
 }
+
+bool bt_bass_check_bis(struct bt_bcast_src *bcast_src, uint8_t bis)
+{
+	for (uint8_t i = 0; i < bcast_src->num_subgroups; i++) {
+		struct bt_bass_subgroup_data *sgrp =
+				&bcast_src->subgroup_data[i];
+		uint32_t bitmask = 1 << (bis - 1);
+
+		if (sgrp->pending_bis_sync & bitmask)
+			return true;
+	}
+
+	return false;
+}
diff --git a/src/shared/bass.h b/src/shared/bass.h
index f3f708246..b21256efd 100644
--- a/src/shared/bass.h
+++ b/src/shared/bass.h
@@ -132,3 +132,4 @@ bool bt_bass_cp_handler_unregister(struct bt_bass *bass,
 int bt_bass_set_pa_sync(struct bt_bcast_src *bcast_src, uint8_t sync_state);
 int bt_bass_set_bis_sync(struct bt_bcast_src *bcast_src, uint8_t bis);
 int bt_bass_clear_bis_sync(struct bt_bcast_src *bcast_src, uint8_t bis);
+bool bt_bass_check_bis(struct bt_bcast_src *bcast_src, uint8_t bis);
-- 
2.39.2

