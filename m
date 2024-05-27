Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2043.outbound.protection.outlook.com [40.107.6.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4BC3B298
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 May 2024 07:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716796486; cv=fail; b=p4EYCF9118I9KrRrZKrxy056SZC7mbKbjPnLaxMVyy4lUAw1FziiVvzCAOCDN0hF5qQzClXiVO7XCOBsqB7TKfVrIFgLCg2WpfBLedsJzeUOQdTVKMh/XxXudLr0G5y8jnLa5O1zW4onSTmVyC75q0Z3rtrHmnItEgsk8nAhpxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716796486; c=relaxed/simple;
	bh=rtFWfKrpnLcIMk+JHAgGMZyzn9vIbKTI1e+S9Oopoeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nn/46aw1BpFj2tilgRTXcbH4bUkCjv04NqnLRlwPGle1mLIc8HCRMVlRW3u5xO0UmxjSBlZwur9hZdh6bTn1V6UaVsvbS2IDNidWQnkNTD1q6e8OyhyLvZl2o0ymZsV9jFi71f136GfU1pxmM4VaXLL13d7ec8wGnviyXo9CGZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MIyLKrcL; arc=fail smtp.client-ip=40.107.6.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MIyLKrcL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQw84SRxM4WuSJREYw4bSD+cmX/ZlhywLusoA+htKyNvplSiUmLP8dkOv2FDhVd0CYO63xasSXJriIH18ISbiYb2kiZNUR79R516djkeIGa5wJ3Bsdec1FeSj0ubP7vuy01Pcip/7dexSfMT+JEoKvGBJXwI+ggyGIR66QAqKnJGZmlkhgmn0qBS7gkH8mZ12woBoLJI9hrq0oQ5E4F6J3s6rD8SbwT9Yfu2iNI/LlJIbCnlbCsrrVJzMm0obQ0vKu0SKKS9KkGY/HnghVQyPAael83c8KyleurGldSu6V/o220ZytANF4DiYq7VhLGQTzlQ7NHUGFeCNZ8+6clHxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0ue5+hpOW0cg64pu9ttu8TzAmNBk3651pCHXR3v5R8=;
 b=WOXcndUYBYUjgxrb+fqqhLnHBR/vOrYgXK8n1DuiWpCD/MTl/opqlqqJcU6FKqX1/5XUH3F5BFQm8RwvMkT5Hwd3+nEn+mclpTUPX/uDf9Q7p+JO67RJ957hVr+XeoSWJySzcPVw58+M2A5EBh14EOAm21H5Gjw6KD8OuDt9Ayu/JYLfHDU8U+v0fbTrLM/cnnQixJbKnASYfF4wlGNfb/I9g/JWgY07kJDao3d8W0iDiURml49wUNedMOhrh5nbEEWaeSH078h5D++syOaVSfCCtSkYBuM6cPGva/9xuadIYq9ghAycJPUzoSOtFd16SHgpIaH9VQKWEx3HFO60Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0ue5+hpOW0cg64pu9ttu8TzAmNBk3651pCHXR3v5R8=;
 b=MIyLKrcLCPXFuorW0bmxQvJGRNhHbUEctD+KWlVnLUSVBkR7AI/aLIL4lRsI9H73/srDbFliL2UdYx/Hq6WvGX6iWXyheSadst1Y/KMnl9Q6l6yBSompu3bGzfRWjh9obizEmJsAOiz33SdxccKZXDUwSasjQvwe9PUtDcZoo9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DBBPR04MB7836.eurprd04.prod.outlook.com (2603:10a6:10:1f3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.28; Mon, 27 May
 2024 07:54:42 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 07:54:42 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 3/6] test-bap: Update bsrc_state to just handle CONFIG state
Date: Mon, 27 May 2024 10:54:19 +0300
Message-Id: <20240527075422.18953-4-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240527075422.18953-1-iulia.tanasescu@nxp.com>
References: <20240527075422.18953-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0022.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::27) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DBBPR04MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: f8aaa9d8-ad07-49b2-6991-08dc7e2243db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7Gd80o1eYU30Kzk4Y04FIiG9dPegHEzZzwIgnyIn/qYeexmjc+z19h1ZJ1uv?=
 =?us-ascii?Q?FTqeTygemqVIHX75bF2RzAl7Sn7VK3tbEwMZLRO9urxbfnlVX1Asf+KyQkqI?=
 =?us-ascii?Q?A/nVzazk8M+fwEscE+ctuGnXqf/lzCyou3w4T6BcpgFg5cqCXwwP9EXQq5FV?=
 =?us-ascii?Q?2T46P5o2GDKML6liJS/ShWPUb/2pn8qH89Q6wEpxllBydhWDR1bUHd7yLwAW?=
 =?us-ascii?Q?ZltRccEZh6yX1VfiF5SKc5NulvNIVeu2iB2SEykozW2LcFKEZMEH5knbWfIH?=
 =?us-ascii?Q?oVmLIieWArw6B41Z1+jm2fwvlHdQNcdiA6Hymx6Dbpncrw4zJ51i6gAekIMb?=
 =?us-ascii?Q?VQwUU01/ALiHnhnm5/6TnnHhb3BlZqwl6ijpGggGMREgR2+An/BkuEzGolnz?=
 =?us-ascii?Q?YmF6gkR/zqQz9Q3kGCig9BuEhAuk0m6FS0lTASjuoCj8BhlnwjI5sedzN33G?=
 =?us-ascii?Q?HqcYRWcHg5WksdFsmcWZqsvBHHY7uhZyNtPRe1EsNnmWV2F3lZtufxghU9ZD?=
 =?us-ascii?Q?MpqxpjL6UdxzoFlz/0Ap/DKImhEpUfICztdqOURtI+srfH57Y5nk9AhLAJtY?=
 =?us-ascii?Q?10VCck1ei+sLTT4pAWQBMxYUCXkZy2vK6CpwfUHOukrw7p1gjvxgiPYXHAtm?=
 =?us-ascii?Q?JTDrpJUe5zlQAvFcWZc7DAv7iwaDEaiBSs1mlTYCyGhtz6NL8Km/L9WrSf/r?=
 =?us-ascii?Q?g7/URA7LCp5laGbHzVTtXHtPrqpnZZoCRcCvu+r0PB5JEEU+XpUMwGsIbdgS?=
 =?us-ascii?Q?BFzKdtWuVhETgH0ud/OwzptVvdXKmeX4YAJSJxwF0Odts66+fbSc/oVWdCiY?=
 =?us-ascii?Q?TS6oDJV+CfCoewXZFbJSa84OlvCDGovK/0KHRqkcj5jW80lg+omjumWsuP3P?=
 =?us-ascii?Q?o48IoAczApOoaTzRVYTksMbFjvgp6OxodU/uW1DuhCpF3lQk3yIuNKTxT7Pl?=
 =?us-ascii?Q?ZfAia6fo2K/IUFwh8l0/6ZOz6bO5zxYAzLa3tPYg9BXiEoHlORVKomlsBCiH?=
 =?us-ascii?Q?X8a0yiqB7ePtGMY/RBaDal/4HIDhxwNJHTVfHlyqaA1nEZFKAEX7lg9lwMCs?=
 =?us-ascii?Q?VUhwJaTOM6o7mTcXNjOgPyMUbMHSJrWSEqK+A/NxJbBc4l8cgUc7KfKlcme8?=
 =?us-ascii?Q?vbWi68KedULLMNvNqdGKQJpnUZB3/JPF1pxBTauIo/A/E9jdggn4o/GnmS3L?=
 =?us-ascii?Q?Tdb9QfIzHKpFSNXFUJFKAHwNw8VgUtP9bWLLVbo7hodVocODClKZ6+nZCVhI?=
 =?us-ascii?Q?jpYuhr9monMzNw8fXGigD4rWBTgRHCX1HxLAtYVJ8A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FBgUX8q7L41Zl1aq1wKbPhWgTW6QxNZZSOExORVMCb4B616i/p8+XX1GKnDC?=
 =?us-ascii?Q?+gJ7kaJpdVTF0vaApvoyWPtJZHv1SyzbfLznxXm9mXNeNp1W/ofcewxpgJzg?=
 =?us-ascii?Q?+9/m3+tSsYikkw4I9+ACElqAqzzxUUNTx6n0O1Jm5JaAHsk7hZRlM2VObKnL?=
 =?us-ascii?Q?nkWiVGLclq0yQhrPpoy4o7I56nxhiLCFSauXFp8klcKWokun7pY3ro2gyGah?=
 =?us-ascii?Q?yCXr4IZOnZ1p15ldheLhvVYTEhJ6G6fMUXE1+JDgNjIG6iIsLbzRjbCdOflH?=
 =?us-ascii?Q?o0uDw+prGmKxjx7VTg2xMLuAxbvmXsKYquZN07i7c1jXXhb+D/YhoCyGalPV?=
 =?us-ascii?Q?w1bxrkntizcz5ADW9bIoK9spV2oZRauC3kJuFz0EKP3I9dFvZYaBFvPuGQYX?=
 =?us-ascii?Q?FXv1Rjb8a8tGeOsb6mSYlQ352HVD2oPxOCzh+MtVdVUv7MCNyvfITmHSiOub?=
 =?us-ascii?Q?jy+ckYmMPH3uXO47ZGdEWpkQ53T0PIgW/qkJlyqzWDcJXNyRwK5L6cPWW6xv?=
 =?us-ascii?Q?JxoBCa1No3hipgAo92o07x29DLFOGMMg6XR2ojEr5DtUVsRrMPdAaKXNgZHS?=
 =?us-ascii?Q?ae+NelH0b4jzgpe4lV6BNuWF3vtOJcyTLgqfPGM2g0BVg/Oz9VE9paXOtGBY?=
 =?us-ascii?Q?qkW8Vn+nOLgnhUzwrS1SC1XCjcecHtMt6sQQStlk1mDh1ESgZJeWldTCHpwq?=
 =?us-ascii?Q?+0cHMjNNiJENKvuvHNjLGAZi6gbgkpkSaSGTY7plXma+wRfNsVCirEo0Kc1v?=
 =?us-ascii?Q?ew7Vh3zbDW5WGDGnCc/Gs4y1OxFwVwm1j4TPW5iAXhN4+k44eAjQxFY6lbDu?=
 =?us-ascii?Q?0LMshnTBqEYXmXCBQAw32Re1JZAhSzTA+azZIKq0ett5RJyoaqwYUJvUuzNy?=
 =?us-ascii?Q?maymro71dwO08los7HVVxwigvsPQqVOFCj9CJBqcUfclPBH2/AOIpWpyRYEt?=
 =?us-ascii?Q?p5dZIdMB+fr+rtPH/bRxTEJ4L1CKx/To8xA7zBG68F7Or6e0HEm6W4C30rkY?=
 =?us-ascii?Q?SbUGF25gF9+lgX60xKEHIvWL8zqAHZNFqjRcnoIu0YzxiUaW5/QuvLHESzk4?=
 =?us-ascii?Q?r8deePYg2GakHwpkc4TRTEWMMxUN5DjPGdIkEbYAo+whTGK+rMQl/feSevBz?=
 =?us-ascii?Q?WbGZ8s3o8LhJVn5eA8BkPsOC36P+gKMJaq5ePjqwP9i71z6gZcGxMyAGMeMa?=
 =?us-ascii?Q?qdRWjfdq8VjDmKGSxnKuhBNzowsaj3EvsNiZiDWgFvnZnmAFpaRjaDwQsyMN?=
 =?us-ascii?Q?QRl4K3heRvsD4PU0tVc3+pKWozkPqRgIYm5swKcdoPyKd5R/pS4xYzSQoVT/?=
 =?us-ascii?Q?zIiNVCtmJLcjLUdVBaKafVJktzqVgAukQT+qYytl0Nklme08BNwbVlLOuE6m?=
 =?us-ascii?Q?Q+c/IugxjTvU/oepwUoE7hZ+g+MkdIX7kZTeQ+/U32rjTwPF4UtKxqJnE/Lw?=
 =?us-ascii?Q?hcJOlpIVW9gE6X/DfQ+ezWiy2zErSytKbHpu5Wlwn3zwqdH0x5S0nGEsMxuo?=
 =?us-ascii?Q?taMKug7j8Geq61gJsPLB2ojfloVx/8Qr2Nu15GjEo7rXiELOT+y5XLbXCmZM?=
 =?us-ascii?Q?JtmQpY3vohE4qv1Br0P7xFhbGR2LOYHQtPk7rxJu5dOPYVhHpUa8l6ttiJ5U?=
 =?us-ascii?Q?Gg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8aaa9d8-ad07-49b2-6991-08dc7e2243db
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 07:54:41.9437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 42pCyFPbu/V57V7c4MAJKniVC2d0Y6gCgnw0Yn0Rs2jDKAabp4P9ZrXqBQzMfs+DRyf3B8KV7yleF63hQTDEGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7836

This updates bsrc_state to just handle the CONFIG stream state. Dedicated
state changed callbacks will be implemented for tests that require streams
to be established, disabled etc.
---
 unit/test-bap.c | 74 +++++++++++++++++++++++--------------------------
 1 file changed, 34 insertions(+), 40 deletions(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index b59f642ca..9cb4ae8d8 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -549,16 +549,13 @@ static void bsrc_pac_added(struct bt_bap_pac *pac, void *user_data)
 					&data->cfg->cc, NULL, data);
 }
 
-static void bsrc_state(struct bt_bap_stream *stream, uint8_t old_state,
+static void bsrc_state_cfg(struct bt_bap_stream *stream, uint8_t old_state,
 				uint8_t new_state, void *user_data)
 {
 	struct test_data *data = user_data;
 
 	switch (new_state) {
 	case BT_BAP_STREAM_STATE_CONFIG:
-		bt_bap_stream_enable(stream, true, NULL, NULL, NULL);
-		break;
-	case BT_BAP_STREAM_STATE_ENABLING:
 		data->base = bt_bap_stream_get_base(stream);
 
 		g_assert(data->base);
@@ -566,9 +563,6 @@ static void bsrc_state(struct bt_bap_stream *stream, uint8_t old_state,
 		g_assert(memcmp(data->base->iov_base, data->cfg->base.iov_base,
 				data->base->iov_len) == 0);
 
-		bt_bap_stream_start(stream, NULL, NULL);
-		break;
-	case BT_BAP_STREAM_STATE_STREAMING:
 		tester_test_passed();
 		break;
 	}
@@ -5608,7 +5602,7 @@ static struct test_config cfg_bsrc_8_1_1 = {
 	.qos = LC3_QOS_8_1_1_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_8_1),
 	.src = true,
-	.state_func = bsrc_state,
+	.state_func = bsrc_state_cfg,
 };
 
 static struct test_config cfg_bsrc_8_1_2 = {
@@ -5616,7 +5610,7 @@ static struct test_config cfg_bsrc_8_1_2 = {
 	.qos = LC3_QOS_8_1_2_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_8_1),
 	.src = true,
-	.state_func = bsrc_state,
+	.state_func = bsrc_state_cfg,
 };
 
 #define LC3_CFG_8_2 \
@@ -5632,7 +5626,7 @@ static struct test_config cfg_bsrc_8_2_1 = {
 	.qos = LC3_QOS_8_2_1_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_8_2),
 	.src = true,
-	.state_func = bsrc_state,
+	.state_func = bsrc_state_cfg,
 };
 
 static struct test_config cfg_bsrc_8_2_2 = {
@@ -5640,7 +5634,7 @@ static struct test_config cfg_bsrc_8_2_2 = {
 	.qos = LC3_QOS_8_2_2_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_8_2),
 	.src = true,
-	.state_func = bsrc_state,
+	.state_func = bsrc_state_cfg,
 };
 
 #define LC3_CFG_16_1 \
@@ -5656,7 +5650,7 @@ static struct test_config cfg_bsrc_16_1_1 = {
 	.qos = LC3_QOS_16_1_1_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_16_1),
 	.src = true,
-	.state_func = bsrc_state,
+	.state_func = bsrc_state_cfg,
 };
 
 static struct test_config cfg_bsrc_16_1_2 = {
@@ -5664,7 +5658,7 @@ static struct test_config cfg_bsrc_16_1_2 = {
 	.qos = LC3_QOS_16_1_2_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_16_1),
 	.src = true,
-	.state_func = bsrc_state,
+	.state_func = bsrc_state_cfg,
 };
 
 #define LC3_CFG_16_2 \
@@ -5680,7 +5674,7 @@ static struct test_config cfg_bsrc_16_2_1 = {
 	.qos = LC3_QOS_16_2_1_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_16_2),
 	.src = true,
-	.state_func = bsrc_state,
+	.state_func = bsrc_state_cfg,
 };
 
 static struct test_config cfg_bsrc_16_2_2 = {
@@ -5688,7 +5682,7 @@ static struct test_config cfg_bsrc_16_2_2 = {
 	.qos = LC3_QOS_16_2_2_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_16_2),
 	.src = true,
-	.state_func = bsrc_state,
+	.state_func = bsrc_state_cfg,
 };
 
 #define LC3_CFG_24_1 \
@@ -5704,7 +5698,7 @@ static struct test_config cfg_bsrc_24_1_1 = {
 	.qos = LC3_QOS_24_1_1_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_24_1),
 	.src = true,
-	.state_func = bsrc_state,
+	.state_func = bsrc_state_cfg,
 };
 
 static struct test_config cfg_bsrc_24_1_2 = {
@@ -5712,7 +5706,7 @@ static struct test_config cfg_bsrc_24_1_2 = {
 	.qos = LC3_QOS_24_1_2_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_24_1),
 	.src = true,
-	.state_func = bsrc_state,
+	.state_func = bsrc_state_cfg,
 };
 
 #define LC3_CFG_24_2 \
@@ -5728,7 +5722,7 @@ static struct test_config cfg_bsrc_24_2_1 = {
 	.qos = LC3_QOS_24_2_1_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_24_2),
 	.src = true,
-	.state_func = bsrc_state,
+	.state_func = bsrc_state_cfg,
 };
 
 static struct test_config cfg_bsrc_24_2_2 = {
@@ -5736,7 +5730,7 @@ static struct test_config cfg_bsrc_24_2_2 = {
 	.qos = LC3_QOS_24_2_2_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_24_2),
 	.src = true,
-	.state_func = bsrc_state,
+	.state_func = bsrc_state_cfg,
 };
 
 #define LC3_CFG_32_1 \
@@ -5752,7 +5746,7 @@ static struct test_config cfg_bsrc_32_1_1 = {
 	.qos = LC3_QOS_32_1_1_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_32_1),
 	.src = true,
-	.state_func = bsrc_state,
+	.state_func = bsrc_state_cfg,
 };
 
 static struct test_config cfg_bsrc_32_1_2 = {
@@ -5760,7 +5754,7 @@ static struct test_config cfg_bsrc_32_1_2 = {
 	.qos = LC3_QOS_32_1_2_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_32_1),
 	.src = true,
-	.state_func = bsrc_state,
+	.state_func = bsrc_state_cfg,
 };
 
 #define LC3_CFG_32_2 \
@@ -5776,7 +5770,7 @@ static struct test_config cfg_bsrc_32_2_1 = {
 	.qos = LC3_QOS_32_2_1_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_32_2),
 	.src = true,
-	.state_func = bsrc_state,
+	.state_func = bsrc_state_cfg,
 };
 
 static struct test_config cfg_bsrc_32_2_2 = {
@@ -5784,7 +5778,7 @@ static struct test_config cfg_bsrc_32_2_2 = {
 	.qos = LC3_QOS_32_2_2_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_32_2),
 	.src = true,
-	.state_func = bsrc_state,
+	.state_func = bsrc_state_cfg,
 };
 
 #define LC3_CFG_44_1 \
@@ -5800,7 +5794,7 @@ static struct test_config cfg_bsrc_44_1_1 = {
 	.qos = LC3_QOS_44_1_1_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_44_1),
 	.src = true,
-	.state_func = bsrc_state,
+	.state_func = bsrc_state_cfg,
 };
 
 static struct test_config cfg_bsrc_44_1_2 = {
@@ -5808,7 +5802,7 @@ static struct test_config cfg_bsrc_44_1_2 = {
 	.qos = LC3_QOS_44_1_2_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_44_1),
 	.src = true,
-	.state_func = bsrc_state,
+	.state_func = bsrc_state_cfg,
 };
 
 #define LC3_CFG_44_2 \
@@ -5824,7 +5818,7 @@ static struct test_config cfg_bsrc_44_2_1 = {
 	.qos = LC3_QOS_44_2_1_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_44_2),
 	.src = true,
-	.state_func = bsrc_state,
+	.state_func = bsrc_state_cfg,
 };
 
 static struct test_config cfg_bsrc_44_2_2 = {
@@ -5832,7 +5826,7 @@ static struct test_config cfg_bsrc_44_2_2 = {
 	.qos = LC3_QOS_44_2_2_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_44_2),
 	.src = true,
-	.state_func = bsrc_state,
+	.state_func = bsrc_state_cfg,
 };
 
 #define LC3_CFG_48_1 \
@@ -5848,7 +5842,7 @@ static struct test_config cfg_bsrc_48_1_1 = {
 	.qos = LC3_QOS_48_1_1_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_48_1),
 	.src = true,
-	.state_func = bsrc_state,
+	.state_func = bsrc_state_cfg,
 };
 
 static struct test_config cfg_bsrc_48_1_2 = {
@@ -5856,7 +5850,7 @@ static struct test_config cfg_bsrc_48_1_2 = {
 	.qos = LC3_QOS_48_1_2_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_48_1),
 	.src = true,
-	.state_func = bsrc_state,
+	.state_func = bsrc_state_cfg,
 };
 
 #define LC3_CFG_48_2 \
@@ -5872,7 +5866,7 @@ static struct test_config cfg_bsrc_48_2_1 = {
 	.qos = LC3_QOS_48_2_1_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_48_2),
 	.src = true,
-	.state_func = bsrc_state,
+	.state_func = bsrc_state_cfg,
 };
 
 static struct test_config cfg_bsrc_48_2_2 = {
@@ -5880,7 +5874,7 @@ static struct test_config cfg_bsrc_48_2_2 = {
 	.qos = LC3_QOS_48_2_2_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_48_2),
 	.src = true,
-	.state_func = bsrc_state,
+	.state_func = bsrc_state_cfg,
 };
 
 #define LC3_CFG_48_3 \
@@ -5896,7 +5890,7 @@ static struct test_config cfg_bsrc_48_3_1 = {
 	.qos = LC3_QOS_48_3_1_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_48_3),
 	.src = true,
-	.state_func = bsrc_state,
+	.state_func = bsrc_state_cfg,
 };
 
 static struct test_config cfg_bsrc_48_3_2 = {
@@ -5904,7 +5898,7 @@ static struct test_config cfg_bsrc_48_3_2 = {
 	.qos = LC3_QOS_48_3_2_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_48_3),
 	.src = true,
-	.state_func = bsrc_state,
+	.state_func = bsrc_state_cfg,
 };
 
 #define LC3_CFG_48_4 \
@@ -5920,7 +5914,7 @@ static struct test_config cfg_bsrc_48_4_1 = {
 	.qos = LC3_QOS_48_4_1_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_48_4),
 	.src = true,
-	.state_func = bsrc_state,
+	.state_func = bsrc_state_cfg,
 };
 
 static struct test_config cfg_bsrc_48_4_2 = {
@@ -5928,7 +5922,7 @@ static struct test_config cfg_bsrc_48_4_2 = {
 	.qos = LC3_QOS_48_4_2_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_48_4),
 	.src = true,
-	.state_func = bsrc_state,
+	.state_func = bsrc_state_cfg,
 };
 
 #define LC3_CFG_48_5 \
@@ -5944,7 +5938,7 @@ static struct test_config cfg_bsrc_48_5_1 = {
 	.qos = LC3_QOS_48_5_1_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_48_5),
 	.src = true,
-	.state_func = bsrc_state,
+	.state_func = bsrc_state_cfg,
 };
 
 static struct test_config cfg_bsrc_48_5_2 = {
@@ -5952,7 +5946,7 @@ static struct test_config cfg_bsrc_48_5_2 = {
 	.qos = LC3_QOS_48_5_2_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_48_5),
 	.src = true,
-	.state_func = bsrc_state,
+	.state_func = bsrc_state_cfg,
 };
 
 #define LC3_CFG_48_6 \
@@ -5968,7 +5962,7 @@ static struct test_config cfg_bsrc_48_6_1 = {
 	.qos = LC3_QOS_48_6_1_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_48_6),
 	.src = true,
-	.state_func = bsrc_state,
+	.state_func = bsrc_state_cfg,
 };
 
 static struct test_config cfg_bsrc_48_6_2 = {
@@ -5976,7 +5970,7 @@ static struct test_config cfg_bsrc_48_6_2 = {
 	.qos = LC3_QOS_48_6_2_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_48_6),
 	.src = true,
-	.state_func = bsrc_state,
+	.state_func = bsrc_state_cfg,
 };
 
 #define VS_CC \
@@ -6012,7 +6006,7 @@ static struct test_config cfg_bsrc_vs = {
 	.base = UTIL_IOV_INIT(BASE_VS),
 	.vs = true,
 	.src = true,
-	.state_func = bsrc_state,
+	.state_func = bsrc_state_cfg,
 };
 
 /* Test Purpose:
-- 
2.39.2

