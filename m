Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2046.outbound.protection.outlook.com [40.107.103.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6762B146A86
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 07:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719300452; cv=fail; b=PfwzfPSjOsijt1oaJE6rfGPcwxGSyzwaAHkABu7qVqXldTb/sRNdGQ4W1GmtNZey723QtyUizUUGcyop/6lplwLna0qZhLwGOX5T1bsOjRX0041PYP5mOEcE6zfanknIB0O/QCAnKWceZRkw8G5ZuZj4Q3gOPHdNykLmoE77x2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719300452; c=relaxed/simple;
	bh=gfrwksnIGcl2eWFIVwL89ySAoZp3j9qOMSiAnk9K63k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cihCKUHjAgn8kViNcG4Gagbgu4WlS7XUQioqTymAl3jlJErPgxgAqCqMw1vmu5U69x6el5c173m01IqNzXyULbTDFGwjM1QGGKKqyX2tccOswh3/d1gZU2CVYdmljl04LJDn8eaw65BE8skqjqo5PdthfCzGVPt4veNieAiS5JQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=iFLRzatr; arc=fail smtp.client-ip=40.107.103.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iFLRzatr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVi9DTYozuZ5zKJNrk/6d41n1V8ltupsUq3wl0fpcOWOgh9plYJ8osjHW9bZm/YBMUT+Bth7cX6Zf4N5Mp320lZDKqsDHcqA0z95NfazJIM14QDJIpXXZ54JsiimJdTSRTB2u5wAWrwYIxMZe7cPrQJeqcvctSuD1pi+shyXmgfbpaioWud720tuiwI9meiG0hOEwwV5bQxfBFEdLqpuqAfxG0rvnmqauVnSwx2zxffDh0BEwjE6ENH7NUSdKJd+KwHokcDXqEMEtwnuoj9VOLPKeKSKlZBm45ma2Uw+/5KYDGB/psBj1J2xlMWB88tm1DbRMGUijQbsu9iWC//nAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVN6rp5jmSMdIasCpRdsxWRTNOD9HMiaw3Q1+b9OvFc=;
 b=bZA4gwVfxaOQaFErw2xOZfsL1E1XxDtUdEoOILGswmO3QH44PvrcsB44xyxWiSAEjSGz8874wGq9GsP2j0f8Cv8QEl/qddGDMkZ3uDaqgWd8rTzB/UBXIYlE1PHzPYisW5IbnHp7QV9Sh2h3OWtThJX+6flc/zmRjwcsXGoplUDOTliH+hefz/wxHDzrvo6GVrrtB129hb9dX689EKpiEoeCnJeaIVJglzQ231Oe31nzyfbobuwWxsqFAvyo6zWspqbfLfNpETTb7RlhbkCD0/iiFcpP874rO9pcN6oulcCGDpolUuq7VYPmXr/VinaeoJNIl7Zz7wCRDJu2XB7LJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVN6rp5jmSMdIasCpRdsxWRTNOD9HMiaw3Q1+b9OvFc=;
 b=iFLRzatrl+dkaksYtyhfZBVe+l8a2SaJQ18/hz7GyFXfwwjTsf5Sv44GmudwbUXT/OkTPk+LYnTyx6WK5sXrMeshXU+Pd/L7ho3MkB4dKXurvBciGBYcMQbq+eLthNWhYI3wcQVafBsf1m5HIoyh0LP9Z4XEdkkE+i2EcNrBH7c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU4PR04MB10362.eurprd04.prod.outlook.com (2603:10a6:10:563::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 07:27:27 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 07:27:27 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 3/5] test-bap: Add support to config multiple bsrc streams
Date: Tue, 25 Jun 2024 10:27:09 +0300
Message-Id: <20240625072711.7011-4-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240625072711.7011-1-iulia.tanasescu@nxp.com>
References: <20240625072711.7011-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P192CA0027.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::32) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU4PR04MB10362:EE_
X-MS-Office365-Filtering-Correlation-Id: c444cc06-1a3b-4cfa-959c-08dc94e843b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?42aP1xB2Q03VwZkP9mzNy4KmBbReNltBglLb7kQD++aY+eI3iatVyA6J1ZvB?=
 =?us-ascii?Q?G6RRpjCgaR4Fy5PVabzTW8rv7gk6hoowRKZw0rQjEeZpPYcKFhj8dlcLIxZW?=
 =?us-ascii?Q?YrfnPjudSyz8AszjRLIHigrYjx5MXndiMPoeGWPBPMNUFgWq03JGz6ZaocyT?=
 =?us-ascii?Q?IA5v5CLggVIMuEdYO3Viaw7zbuA0UFv72PPDbKdXVRv2sjcWkoNdqEhKk4Ym?=
 =?us-ascii?Q?BAN8S9WyF3rNFVGbeUJ0WVJn9DgpETQyntrU/IgNkySBMAfTjPLgNRthpSk1?=
 =?us-ascii?Q?Lcqq69ILheuu3QPGbXY9lV5WmyudlxiAzw+sBWw/Hm/09bvtv/gJhTyVMtcE?=
 =?us-ascii?Q?aaNnK5WabLcniB4cXlTeC6pw7BGGIUU0UKIeHnaGNDXCKpNfhfJw2NCczEn3?=
 =?us-ascii?Q?TXGJrtO1F297pSA2W2MuZ6AVCbnnXv+SS45tHgler+RjxRn5LOgj9KpSa7xo?=
 =?us-ascii?Q?H/dW8Op/4ybFIXzIqcZToIqs7zFniK1TemtFawgVkgLrOy/HeUsUkGWmdb+T?=
 =?us-ascii?Q?GAKNlF8dOXVxSofjxssbqxjIJn4GZZFsO6gXlsBz1vE01Fxm/FWfG/Cnb1UN?=
 =?us-ascii?Q?8Y+8f92ctBJjzFuo86W4lmPUIQdBh+i+V1LJgB7g4CXKnAf9IXd3CiVOCgMH?=
 =?us-ascii?Q?p5DYqVqIRb5GO0Y+vdZJ6kf0uDptFR2gtQ+rmGKmN2uFdcwTmiuHalEeAv8g?=
 =?us-ascii?Q?SVPXcGspizClVVxDTi1q/K5l7JiaOm7t5DlttFTRrS2UGYN1cdZTChjzI4AE?=
 =?us-ascii?Q?aEMzfFr1rHUmP22RLEmTLDPE//0XDP95iIgc3/ZGm9vhopzFs5vvSWOq79i4?=
 =?us-ascii?Q?ysUOQAf0Hf8mNxeC5hMkWQ2S/FxyLjVIPpZqoL5c2syphX/24kA3iYG8RQRL?=
 =?us-ascii?Q?ObGjuvEoUIvjJV7aO3w2bWAZqLZ+SWuwyC6FClnNZdxmSO/G8i5MkvoJfpbq?=
 =?us-ascii?Q?h9Qsnjq4z7QwIEVyLxodrj+wrCLxncXGs3J5CCwSkp8Ke0U7VRTwbnS0T5tz?=
 =?us-ascii?Q?5BbrwrMfDYB7IvZvm//f+FLkLsV0oqOqYRe+XDWltW5CeFMQ27Y1gDU01MPI?=
 =?us-ascii?Q?Vgtu2WkJJIydEpW0RHDpBOr4RjD+Pd0VjDUNLD1HmoEUB6f15HJSaCxK89Cy?=
 =?us-ascii?Q?+ryLEvQkNIy4hv9j2q4u8/PzXPEYSafNfAtcu1NghrZL/QVdWXHifZpTrw6+?=
 =?us-ascii?Q?xNeTUuLX5GIFjjodZ/+ZqAo/7Yr3RIGuai0WWanj99E1sILRM3c/oI9H0arj?=
 =?us-ascii?Q?OsAncT+DAd27ZFFLECLs510gvS4lg/Kx50LppXDr9rrf3fwnEidBEAUEUr/A?=
 =?us-ascii?Q?jH6FKkxuHXujhWcO6Ylr9KFU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dWsdMSEhEGsKrYsqeikpZI+OI7v5Ye8rTEzXXqiTGlfP5rLmBb/L5kbTvgXB?=
 =?us-ascii?Q?zRUBZ2o6rGTQDH5ZHKxPJCu8HulAUwpWlsmzFb5ush7OLy4E36bVmQyleRHG?=
 =?us-ascii?Q?zgXoHMSePbGtMY7qecuPFbaBinxK44lLaR+QwFq3RCSmsMNEZTgvJOZugBoi?=
 =?us-ascii?Q?7ZOTOnT9f3jxScm+tswdY2cj7NlkajHXSstPZS2lvlv8OiNzgGHZn1uZAOEG?=
 =?us-ascii?Q?nqH+vPx11S8V6nj2wGhsKWiYxsdblIZXfcVprQye73jlkeIhayGRILgomKbL?=
 =?us-ascii?Q?JyMSYnLsWnf5tPsr2F9+5erlRClP+GyCXViYyoJbhD0Wg85zu2HwNah9LXuP?=
 =?us-ascii?Q?auByr59KmbyvLOsEx/0TMZRIpmV/gbPTmeMYcy0aU8CIr78N8hz8hcmWaBaY?=
 =?us-ascii?Q?OTtO0k590Wabngu4eSqA8igMTqglUS4w1Wm0aFl9vcPGU7xdaOa0q52RpqoW?=
 =?us-ascii?Q?Af5RaPJD9g/WWMxSoLBRAgHWuNggNrCf65pS/a3pflZB9ZrndIJnFcQlehUM?=
 =?us-ascii?Q?O7y8ljTPXyGCBCJKNc2H42jRVY0OI7PZic5BTL0WB4gRkUSj8xLz5scaSm7Z?=
 =?us-ascii?Q?3s1gpjEb8RtwBS5ZOeoYUCZYarVxjwGeMHFQtfJgj+jBAfDGAipSGNH+59Yv?=
 =?us-ascii?Q?lStPt5y9a2VuEWEWnPG/QkTPXFyEPlKsBKiBN00Cq1v5KAtzDNpFG5upTGts?=
 =?us-ascii?Q?P/na/wNsIo4IXwf8r/8CID3V+1fwQDH41vlujePe8ovYdr0L30qWzedEP0Tb?=
 =?us-ascii?Q?y9miqapo1zn9rSTV8cOIRj/83z3tAw/kERjVHxURzOlG15A8QNfyG/GO/3HU?=
 =?us-ascii?Q?KJGHUmgAYhpPyyDhgy973P4Z6dC6uUarUd4lZ76yGoAi6lNxxtXtT9OtvGHq?=
 =?us-ascii?Q?tMORcOqEiSXVHEmcJcihFSlIKFLMHkz8iMQlMBvzSdcdBmaJ17ukPK3UNhHC?=
 =?us-ascii?Q?y4qJBBb7mQwNdzLQF6bmeQ+qfcyrS8k13S6lQVt/vQndJyXS3sjuTL2zoGv6?=
 =?us-ascii?Q?V0iZNwZqvfcLsZjhnnLm2TiPkONYD7FLkgu/GSHTL6/uBniy7zfZ/mJLeUny?=
 =?us-ascii?Q?xUcUfic1IWN5Fiy3a0MC4Ejbu5PEiI9IujhKQl2egkXR2jic4v6i0l0VhCb3?=
 =?us-ascii?Q?zluRRH4ZOFDBhjb5Pn7eCyZjYMCH2otIcYdDSZlMQX1894A9GYa/ezkeFeN3?=
 =?us-ascii?Q?gXdFN/WgAev8BS0y16KXxvDTzoYSHZ7YWkeBWYaC70xOEdCHoGye70uHnSd0?=
 =?us-ascii?Q?oZjSfk9fgqj3e1NHiQR6rsAc4Ji8fyA+A7WcMO6ug/7zlQPyZdf0oBKGZY4Z?=
 =?us-ascii?Q?zNn/O29/xHLtAO+CkQQ3gJvMixVCd/o36aSQna5Yi/BD7gzoQoLmMlAQq6lQ?=
 =?us-ascii?Q?8Kru8Cqvbe0X6lmjKjIlXajHdnQi8pD7elKzotv2qnXUEzIjvB2L3xCAzUrm?=
 =?us-ascii?Q?1EA5tPAfaFIVpJuMbkAbdxs5/QTm55xaR3lTLhj/yuQCJoMzijqv8KhD5CMN?=
 =?us-ascii?Q?0ee2WKuZMKDhIkHIYMfhw71sdOF2f2IaTVMLt4lS8r18ysJqEECf0nply5LE?=
 =?us-ascii?Q?1cNn5C8xV41CI6KTNRC5KIdPF7YLXqSA8C6dEcq9bICMutxM3xEdXH6cpee4?=
 =?us-ascii?Q?SQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c444cc06-1a3b-4cfa-959c-08dc94e843b3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 07:27:27.0049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +PweS35lJueqKDM3PkdxGRYKsZE3Q59c4hg2mJfPInqyw4S8lGGeQ6jICX/xxmlgn2pjPMjrwergMMjUOrs+yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10362

This adds support to configure multiple bsrc streams.
---
 unit/test-bap.c | 52 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 7 deletions(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index c92c4f671..9b75cfc80 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -538,15 +538,17 @@ static void bsrc_pac_added(struct bt_bap_pac *pac, void *user_data)
 
 	bt_bap_pac_set_ops(pac, &bcast_pac_ops, NULL);
 
-	stream = bt_bap_stream_new(data->bap, pac, NULL,
-						&data->cfg->qos,
-						&data->cfg->cc);
-	g_assert(stream);
+	for (uint8_t i = 0; i < data->cfg->streams; i++) {
+		stream = bt_bap_stream_new(data->bap, pac, NULL,
+							&data->cfg->qos,
+							&data->cfg->cc);
+		g_assert(stream);
 
-	queue_push_tail(data->streams, stream);
+		queue_push_tail(data->streams, stream);
 
-	bt_bap_stream_config(stream, &data->cfg->qos,
-					&data->cfg->cc, NULL, data);
+		bt_bap_stream_config(stream, &data->cfg->qos,
+						&data->cfg->cc, NULL, data);
+	}
 }
 
 static void bsrc_state_cfg(struct bt_bap_stream *stream, uint8_t old_state,
@@ -5580,6 +5582,7 @@ static struct test_config cfg_bsrc_8_1_1 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_8_1),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_8_1_2 = {
@@ -5588,6 +5591,7 @@ static struct test_config cfg_bsrc_8_1_2 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_8_1),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_8_2_1 = {
@@ -5596,6 +5600,7 @@ static struct test_config cfg_bsrc_8_2_1 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_8_2),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_8_2_2 = {
@@ -5604,6 +5609,7 @@ static struct test_config cfg_bsrc_8_2_2 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_8_2),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_16_1_1 = {
@@ -5612,6 +5618,7 @@ static struct test_config cfg_bsrc_16_1_1 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_16_1),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_16_1_2 = {
@@ -5620,6 +5627,7 @@ static struct test_config cfg_bsrc_16_1_2 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_16_1),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_16_2_1 = {
@@ -5628,6 +5636,7 @@ static struct test_config cfg_bsrc_16_2_1 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_16_2),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_16_2_2 = {
@@ -5636,6 +5645,7 @@ static struct test_config cfg_bsrc_16_2_2 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_16_2),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_24_1_1 = {
@@ -5644,6 +5654,7 @@ static struct test_config cfg_bsrc_24_1_1 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_24_1),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_24_1_2 = {
@@ -5652,6 +5663,7 @@ static struct test_config cfg_bsrc_24_1_2 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_24_1),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_24_2_1 = {
@@ -5660,6 +5672,7 @@ static struct test_config cfg_bsrc_24_2_1 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_24_2),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_24_2_2 = {
@@ -5668,6 +5681,7 @@ static struct test_config cfg_bsrc_24_2_2 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_24_2),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_32_1_1 = {
@@ -5676,6 +5690,7 @@ static struct test_config cfg_bsrc_32_1_1 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_32_1),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_32_1_2 = {
@@ -5684,6 +5699,7 @@ static struct test_config cfg_bsrc_32_1_2 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_32_1),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_32_2_1 = {
@@ -5692,6 +5708,7 @@ static struct test_config cfg_bsrc_32_2_1 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_32_2),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_32_2_2 = {
@@ -5700,6 +5717,7 @@ static struct test_config cfg_bsrc_32_2_2 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_32_2),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_44_1_1 = {
@@ -5708,6 +5726,7 @@ static struct test_config cfg_bsrc_44_1_1 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_44_1),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_44_1_2 = {
@@ -5716,6 +5735,7 @@ static struct test_config cfg_bsrc_44_1_2 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_44_1),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_44_2_1 = {
@@ -5724,6 +5744,7 @@ static struct test_config cfg_bsrc_44_2_1 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_44_2),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_44_2_2 = {
@@ -5732,6 +5753,7 @@ static struct test_config cfg_bsrc_44_2_2 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_44_2),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_48_1_1 = {
@@ -5740,6 +5762,7 @@ static struct test_config cfg_bsrc_48_1_1 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_48_1),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_48_1_2 = {
@@ -5748,6 +5771,7 @@ static struct test_config cfg_bsrc_48_1_2 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_48_1),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_48_2_1 = {
@@ -5756,6 +5780,7 @@ static struct test_config cfg_bsrc_48_2_1 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_48_2),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_48_2_2 = {
@@ -5764,6 +5789,7 @@ static struct test_config cfg_bsrc_48_2_2 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_48_2),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_48_3_1 = {
@@ -5772,6 +5798,7 @@ static struct test_config cfg_bsrc_48_3_1 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_48_3),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_48_3_2 = {
@@ -5780,6 +5807,7 @@ static struct test_config cfg_bsrc_48_3_2 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_48_3),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_48_4_1 = {
@@ -5788,6 +5816,7 @@ static struct test_config cfg_bsrc_48_4_1 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_48_4),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_48_4_2 = {
@@ -5796,6 +5825,7 @@ static struct test_config cfg_bsrc_48_4_2 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_48_4),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_48_5_1 = {
@@ -5804,6 +5834,7 @@ static struct test_config cfg_bsrc_48_5_1 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_48_5),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_48_5_2 = {
@@ -5812,6 +5843,7 @@ static struct test_config cfg_bsrc_48_5_2 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_48_5),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_48_6_1 = {
@@ -5820,6 +5852,7 @@ static struct test_config cfg_bsrc_48_6_1 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_48_6),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_48_6_2 = {
@@ -5828,6 +5861,7 @@ static struct test_config cfg_bsrc_48_6_2 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_48_6),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 #define VS_CC \
@@ -5860,6 +5894,7 @@ static struct test_config cfg_bsrc_vs = {
 	.vs = true,
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 /* Test Purpose:
@@ -6005,6 +6040,7 @@ static struct test_config cfg_bsrc_8_1_1_estab = {
 	.qos = LC3_QOS_8_1_1_B,
 	.src = true,
 	.state_func = bsrc_state_estab,
+	.streams = 1,
 };
 
 /* Test Purpose:
@@ -6049,6 +6085,7 @@ static struct test_config cfg_bsrc_8_1_1_disable = {
 	.qos = LC3_QOS_8_1_1_B,
 	.src = true,
 	.state_func = bsrc_state_disable,
+	.streams = 1,
 };
 
 /* Test Purpose:
@@ -6094,6 +6131,7 @@ static struct test_config cfg_bsrc_8_1_1_release = {
 	.qos = LC3_QOS_8_1_1_B,
 	.src = true,
 	.state_func = bsrc_state_release,
+	.streams = 1,
 };
 
 /* Test Purpose:
-- 
2.39.2

