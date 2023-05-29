Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F146C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 May 2023 06:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjE2G0k (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 May 2023 02:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjE2G0j (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 May 2023 02:26:39 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2056.outbound.protection.outlook.com [40.107.22.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED16CDF
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 23:26:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKLt3s2EqXN/nV6ToTmP/73zQbEE0zFr34PD7z5zemd3ILp9biUFVCbxA6T48DsI7VZ5QWjjLhADl7nTE7qX/XtJXS6Zv95tX7MXJpscypzjUT76t5GHTwyhoQxgjg280Tp1qfg/4fNvANHf8hmZmTEs1SgVIvbB6Fd9FbE/IqT6WdYf5oUIRQSUYE6HWz5FMvQs3myi+dy1ZaMerBt5WVY4H3UXJlnwcap8qw7w/f/DFGzTquQGgnZDp8iN9LLZxJv1NcaLBrBHkrmkjbV2LZa2cbNFjqfCddH6BYLdk+V/+F5X6xeobJgpfXOjrZ9NefmGJ930hqXcshq9lVI61A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGwOdd5+ydgYYhF+xo/E5KiV+6GmQoLHXZJhzwIHdKo=;
 b=Qdt/RjLZS7DEgSRDlrpj7lrNKvEcG9K7tN1xgO4LMS5xnVAOkit+f9QCGHsVAM+ckXZEa7YTRNG7eMLJ1tD86lBPiOBy0MmdPvu9NRzOx3PqjYi17qmqJz2S2u+kIDDAz9S6578C+u3TGWm+zbIi73S3qL3zIW1Y26m6UDAkgMZCaUnM8yoMNe9UCUXvuePpb049dHM5wm+OW4j4Xt4+tUtC13njlxOXYPs1zbPsXThS5ILh92TL3IOsIndYob3trO1GDVeqr91VdD+4TNOrSmUsEXvVQmsuUXuu2ALATw4Ge+l5JPlT8DdnEEdOwJKAEWxOPfC5hYAiC9fzfgUolQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGwOdd5+ydgYYhF+xo/E5KiV+6GmQoLHXZJhzwIHdKo=;
 b=l9O17RkmwDdx45WD57Ja6nXDEWqXR2coPaKpcY6iJqEMJ+OUpOl3VIHTYl1AUF/FjhdB4CxHE+cUrYrsR9u8ixSTDA1Whr42YfsOpRsoDdnvCWHF+eLDkTnBJPMpeqJ2GPGarGdzRMj+eVZS9kPrOz5a7QcZxxj3qv7885R3gqU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM0PR04MB7028.eurprd04.prod.outlook.com (2603:10a6:208:19a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 06:25:17 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%4]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 06:25:17 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 2/2] iso-tester: Add BAP Broadcast AC tests
Date:   Mon, 29 May 2023 09:24:58 +0300
Message-Id: <20230529062458.3632-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230529062458.3632-1-iulia.tanasescu@nxp.com>
References: <20230529062458.3632-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0007.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::7) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM0PR04MB7028:EE_
X-MS-Office365-Filtering-Correlation-Id: 69a3026f-c84d-4990-cb60-08db600d7815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9F7YJb4mpRVmC8L69Suk+E9cz1CVQHXjIkyHsd8VTxZW7NFc6s4g+oLtgd4+5Yv6EskyZON5M7Vi7PAEWgzCkgfhe4bhXIaR5fCygjVi7RhRxmG5keCLjUn2CmAqGAYQxp1MDbmnKZslGf/Zv3U/p2tiwK5QdqGcm2riKDZzrlSzj+9fC6yD91FiF58x4BrfsCQORHucN0kjilwUYBBGYKQPQDx0qjlSBgxKQIs16VspWDD2nr84FYUmKW9T30ejK/dBoSI0OhOnkIAZG/WmS8aeCMUHcCd8c+fo8o77RZ/QodXUEvrU4CN9q53pQO44su6idbebecXNey0mk1eqEKWmkXJXd4B2+py6grS82ERF77Tlx8jPebvU+zDmh6iL0Eazty08Avd7DqvIds1EFzD+WxTaWf8XP4wNbdQ4wxWvmuzcPv3DrYf6Ug8lN0XSqPT4HqjUSwHnQg1sWLGx1eHbTXenPLcvNWKPdBQ5XQ3rftHlpHRE1ThfuIVqkmXSF5ubFWBoIEge+KSc7U1Je1EObJUz+3skIv7hgHoT9YqMvZOmMfNUalrBlVSA7ttpXjGKe52bCSslu2+dakCLtQN+F71a2aDZ3wkTmKt+PBlfDDLIZ9goImNVvdE+nC8M
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(396003)(376002)(39860400002)(451199021)(26005)(6486002)(52116002)(1076003)(6512007)(6506007)(30864003)(2906002)(6666004)(316002)(186003)(5660300002)(44832011)(41300700001)(36756003)(8676002)(8936002)(478600001)(38350700002)(38100700002)(4326008)(6916009)(86362001)(2616005)(66946007)(66476007)(66556008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4OMOcVN4oRmhSxyQT5dsvuH9/XJk/hQxmGiPya5L3/HyRlsA1sO6TST7H/2Z?=
 =?us-ascii?Q?jd9xSnrogg/09GtxpOuh3TKmlGHaFVdYMo9bI01/YlkVWfte7yG/jXkq25MT?=
 =?us-ascii?Q?9KYlqTM1L5+t+szIvQK1bE/MGU+jsbMATECGr98jjHsAAuWUSqT7wO7hRRuo?=
 =?us-ascii?Q?t6wXwCYh11rD4nxBWYpJS8ZOl07f57z76XPsRcWc4buxQqFK+nMyMOWuT75F?=
 =?us-ascii?Q?Pi+EveUmFYessixnO/X/RHsO8svXFhQ2yxl8HZKzCJMJ82G993MVbhIDgN/D?=
 =?us-ascii?Q?sMy9Pq/vbrFaXOtcARd/empJGHxQfjgHTZqfEgkWxwYwia9tENdhiyucWDPZ?=
 =?us-ascii?Q?2uJr5ke2CSyE/8xT9HuOouIB7hmEZvCxED1jJYaDW3QZTeMA1F+daHOO1QCG?=
 =?us-ascii?Q?y3YWOIJME0s2F637ZU6jvNJYjmlkuARmM+wKax3FD3dfk1aHm6JbpiQ+NyuZ?=
 =?us-ascii?Q?dvypRk5KUABxygygHnDaNTk8iUgIF2bsaGXQGeRIidXEKhiOlYx7N+PocBfY?=
 =?us-ascii?Q?peI8Ps2YgztW0xgbD7CxieEch8lNjIRz6SbZVCO4Pu+qoFDnFO88tILhE+WN?=
 =?us-ascii?Q?SXTCFh5lfVSbGWzL19Ej12z/zy3vsm4Fj946D49A4zw7EZjFsYck7RL3a/NB?=
 =?us-ascii?Q?PI/2bbZGZbE9J/c0OjIRvlLqU4xbaT3XpAKZtVtHmRZCZsDsVrd5RWRS87z5?=
 =?us-ascii?Q?pp5Q2sndhwBEygtT2jv6sateD9cucPquUz49HrDe7BEHYHiCEoLcpIg+fecg?=
 =?us-ascii?Q?LJ3ob8sfuofL4hK6liY9VKX+5l7zYR5mazOxRwPWdUdPnnH4cXHky3MZH81I?=
 =?us-ascii?Q?DRWNnN6ErT7dRZJM5CvOk0/Gdlh9yHwUDA2/z2dY3CA5qdT67Qh8lyjQLzmf?=
 =?us-ascii?Q?V7WGPKguvvpAek+i2cZDfU0dWj/Dwv3/3mr1kcYy4P9C4MxaNne/Vfz0mvvg?=
 =?us-ascii?Q?0pO6vguWFlJGeqUbcK0oPUMe3s3oJc57416XqLlEKeyzxc6OenCdYxKLwe8F?=
 =?us-ascii?Q?dCsPf2Z2y+8iPRVlLLJ7p+/5HL+IysuF3X+kCjGEMLRiu7krL9qDXqw3RqGE?=
 =?us-ascii?Q?OXf7SPjU+7Sb/eEDrV1FT2yKydTR4wtAlfx5mDHgbO3Mtt/KEkUQpHE5halo?=
 =?us-ascii?Q?I2PoLMqhO3CIMNErK6NUkZXS0XNSI7IY3po0SzLh1euxUq69PJFbwNAgr1QG?=
 =?us-ascii?Q?ThdR/9YaZi0Jv0FBM9tUuYP5L9mPK9/CZonF/ezl2wzaQCbL6TUUJy4FNHtB?=
 =?us-ascii?Q?1u45mOKErea54lGP+EQ0lGpd4QPvBc5hGVrDuOBeUDEol7Q3qMV1hEddKlIX?=
 =?us-ascii?Q?CEyalgi768n7YTaBOGtNGPy09WdOB89eGTFtcgICylNrIH7DBroihEpQYUAs?=
 =?us-ascii?Q?a3pkkCEfzDQaKsU+8NBrZeer6v3N1sDB+/EZ2RnKaEC7PFglzH74i78NzPcG?=
 =?us-ascii?Q?OQLPHLReksOGjUbZK9FJMcO/nYZzv6UuPNmsBXGGBms1NdgXgpM3ZYZDcnNz?=
 =?us-ascii?Q?bwh2cWwnrwbuI8/2XZhm370P2wbmpV2Kd7Bp1vBG9iuBgIkWvdvylOHa1kKa?=
 =?us-ascii?Q?PpCpr153ipovZD6ZxtyxUDsBI2I8wGM1F0GlWFhcGWduLAP4RCuFa6aS9VJ1?=
 =?us-ascii?Q?nw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a3026f-c84d-4990-cb60-08db600d7815
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 06:25:17.0006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P08KabbF5iZCxGvCp7LioiZoNqKk9XmIanB36/Pn4m7Okl2ZOvXO847FC9K2Dr1PScVToj7DncWQPQxHfOX+Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7028
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds the following tests based on BAP Broadcast Audio Configurations:

ISO Broadcaster AC 12 - Success
ISO Broadcaster AC 13 - Success
ISO Broadcaster AC 14 - Success

---
 tools/iso-tester.c | 193 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 157 insertions(+), 36 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 63c37bd52..ae6ddb2da 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -288,6 +288,90 @@
 #define QOS_IN_16_2_1 BCAST_QOS_IN(10000, 10, 40, 0x02, 2)
 #define QOS_IN_ENC_16_2_1 BCAST_QOS_IN_ENC(10000, 10, 40, 0x02, 2)
 
+static const uint8_t base_lc3_16_2_1[] = {
+	0x28, 0x00, 0x00, /* Presentation Delay */
+	0x01, /* Number of Subgroups */
+	0x01, /* Number of BIS */
+	0x06, 0x00, 0x00, 0x00, 0x00, /* Code ID = LC3 (0x06) */
+	0x11, /* Codec Specific Configuration */
+	0x02, 0x01, 0x03, /* 16 KHZ */
+	0x02, 0x02, 0x01, /* 10 ms */
+	0x05, 0x03, 0x01, 0x00, 0x00, 0x00,  /* Front Left */
+	0x03, 0x04, 0x28, 0x00, /* Frame Length 40 bytes */
+	0x04, /* Metadata */
+	0x03, 0x02, 0x02, 0x00, /* Audio Context: Convertional */
+	0x01, /* BIS */
+	0x00, /* Codec Specific Configuration */
+};
+
+/* Single Audio Channel. One BIS. */
+#define BCAST_AC_12 BCAST_QOS_OUT_1_1(10000, 10, 40, 0x02, 2)
+
+static const uint8_t base_lc3_ac_12[] = {
+	0x28, 0x00, 0x00, /* Presentation Delay */
+	0x01, /* Number of Subgroups */
+	0x01, /* Number of BIS */
+	0x06, 0x00, 0x00, 0x00, 0x00, /* Code ID = LC3 (0x06) */
+	0x11, /* Codec Specific Configuration */
+	0x02, 0x01, 0x03, /* 16 KHZ */
+	0x02, 0x02, 0x01, /* 10 ms */
+	0x05, 0x03, 0x01, 0x00, 0x00, 0x00,  /* Front Left */
+	0x03, 0x04, 0x28, 0x00, /* Frame Length 40 bytes */
+	0x04, /* Metadata */
+	0x03, 0x02, 0x02, 0x00, /* Audio Context: Convertional */
+	0x01, /* BIS */
+	0x00, /* Codec Specific Configuration */
+};
+
+/* Multiple Audio Channels. Two BISes. */
+#define BCAST_AC_13 BCAST_QOS_OUT_1_1(10000, 10, 40, 0x02, 2)
+
+static const uint8_t base_lc3_ac_13[] = {
+	0x28, 0x00, 0x00, /* Presentation Delay */
+	0x01, /* Number of Subgroups */
+	0x02, /* Number of BIS */
+	0x06, 0x00, 0x00, 0x00, 0x00, /* Code ID = LC3 (0x06) */
+	0x11, /* Codec Specific Configuration */
+	0x02, 0x01, 0x03, /* 16 KHZ */
+	0x02, 0x02, 0x01, /* 10 ms */
+	0x05, 0x03, 0x01, 0x00, 0x00, 0x00,  /* Front Left */
+	0x03, 0x04, 0x28, 0x00, /* Frame Length 40 bytes */
+	0x04, /* Metadata */
+	0x03, 0x02, 0x02, 0x00, /* Audio Context: Convertional */
+	0x01, /* BIS 1 */
+	0x06, /* Codec Specific Configuration */
+	0x05, 0x03, 0x01, 0x00, 0x00, 0x00, /* Audio_Channel_Allocation:
+					     * Front left
+					     */
+	0x01, /* BIS 2 */
+	0x06, /* Codec Specific Configuration */
+	0x05, 0x03, 0x02, 0x00, 0x00, 0x00, /* Audio_Channel_Allocation:
+					     * Front right
+					     */
+};
+
+/* Multiple Audio Channels. One BIS. */
+#define BCAST_AC_14 BCAST_QOS_OUT_1_1(10000, 10, 40, 0x02, 2)
+
+static const uint8_t base_lc3_ac_14[] = {
+	0x28, 0x00, 0x00, /* Presentation Delay */
+	0x01, /* Number of Subgroups */
+	0x01, /* Number of BIS */
+	0x06, 0x00, 0x00, 0x00, 0x00, /* Code ID = LC3 (0x06) */
+	0x11, /* Codec Specific Configuration */
+	0x02, 0x01, 0x03, /* 16 KHZ */
+	0x02, 0x02, 0x01, /* 10 ms */
+	0x05, 0x03, 0x01, 0x00, 0x00, 0x00,  /* Front Left */
+	0x03, 0x04, 0x28, 0x00, /* Frame Length 40 bytes */
+	0x04, /* Metadata */
+	0x03, 0x02, 0x02, 0x00, /* Audio Context: Convertional */
+	0x01, /* BIS */
+	0x06, /* Codec Specific Configuration */
+	0x05, 0x03, 0x03, 0x00, 0x00, 0x00, /* Audio_Channel_Allocation:
+					     * Front left, Front right
+					     */
+};
+
 struct test_data {
 	const void *test_data;
 	struct mgmt *mgmt;
@@ -315,7 +399,9 @@ struct iso_client_data {
 	bool defer;
 	bool disconnect;
 	bool ts;
-	bool mcis;
+	bool mconn;
+	const uint8_t *base;
+	size_t base_len;
 };
 
 static void mgmt_debug(const char *str, void *user_data)
@@ -835,7 +921,7 @@ static const struct iso_client_data connect_ac_6i = {
 	.qos = AC_6i_1,
 	.qos_2 = AC_6i_2,
 	.expect_err = 0,
-	.mcis = true,
+	.mconn = true,
 	.defer = true,
 };
 
@@ -843,7 +929,7 @@ static const struct iso_client_data connect_ac_6ii = {
 	.qos = AC_6ii_1,
 	.qos_2 = AC_6ii_2,
 	.expect_err = 0,
-	.mcis = true,
+	.mconn = true,
 	.defer = true,
 };
 
@@ -851,7 +937,7 @@ static const struct iso_client_data connect_ac_7i = {
 	.qos = AC_7i_1,
 	.qos_2 = AC_7i_2,
 	.expect_err = 0,
-	.mcis = true,
+	.mconn = true,
 	.defer = true,
 };
 
@@ -859,7 +945,7 @@ static const struct iso_client_data connect_ac_7ii = {
 	.qos = AC_7ii_1,
 	.qos_2 = AC_7ii_2,
 	.expect_err = 0,
-	.mcis = true,
+	.mconn = true,
 	.defer = true,
 };
 
@@ -867,7 +953,7 @@ static const struct iso_client_data connect_ac_8i = {
 	.qos = AC_8i_1,
 	.qos_2 = AC_8i_2,
 	.expect_err = 0,
-	.mcis = true,
+	.mconn = true,
 	.defer = true,
 };
 
@@ -875,7 +961,7 @@ static const struct iso_client_data connect_ac_8ii = {
 	.qos = AC_8ii_1,
 	.qos_2 = AC_8ii_2,
 	.expect_err = 0,
-	.mcis = true,
+	.mconn = true,
 	.defer = true,
 };
 
@@ -883,7 +969,7 @@ static const struct iso_client_data connect_ac_9i = {
 	.qos = AC_9i_1,
 	.qos_2 = AC_9i_2,
 	.expect_err = 0,
-	.mcis = true,
+	.mconn = true,
 	.defer = true,
 };
 
@@ -891,7 +977,7 @@ static const struct iso_client_data connect_ac_9ii = {
 	.qos = AC_9ii_1,
 	.qos_2 = AC_9ii_2,
 	.expect_err = 0,
-	.mcis = true,
+	.mconn = true,
 	.defer = true,
 };
 
@@ -899,7 +985,7 @@ static const struct iso_client_data connect_ac_11i = {
 	.qos = AC_11i_1,
 	.qos_2 = AC_11i_2,
 	.expect_err = 0,
-	.mcis = true,
+	.mconn = true,
 	.defer = true,
 };
 
@@ -907,7 +993,7 @@ static const struct iso_client_data connect_ac_11ii = {
 	.qos = AC_11ii_1,
 	.qos_2 = AC_11ii_2,
 	.expect_err = 0,
-	.mcis = true,
+	.mconn = true,
 	.defer = true,
 };
 
@@ -915,14 +1001,14 @@ static const struct iso_client_data connect_ac_1_2 = {
 	.qos = AC_1_4,
 	.qos_2 = AC_2_10,
 	.expect_err = 0,
-	.mcis = true,
+	.mconn = true,
 };
 
 static const struct iso_client_data connect_ac_1_2_cig_1_2 = {
 	.qos = AC_1_4_1,
 	.qos_2 = AC_2_10_2,
 	.expect_err = 0,
-	.mcis = true,
+	.mconn = true,
 };
 
 static const struct iso_client_data bcast_16_2_1_send = {
@@ -930,6 +1016,8 @@ static const struct iso_client_data bcast_16_2_1_send = {
 	.expect_err = 0,
 	.send = &send_16_2_1,
 	.bcast = true,
+	.base = base_lc3_16_2_1,
+	.base_len = sizeof(base_lc3_16_2_1),
 };
 
 static const struct iso_client_data bcast_enc_16_2_1_send = {
@@ -937,6 +1025,8 @@ static const struct iso_client_data bcast_enc_16_2_1_send = {
 	.expect_err = 0,
 	.send = &send_16_2_1,
 	.bcast = true,
+	.base = base_lc3_16_2_1,
+	.base_len = sizeof(base_lc3_16_2_1),
 };
 
 static const struct iso_client_data bcast_1_16_2_1_send = {
@@ -944,6 +1034,8 @@ static const struct iso_client_data bcast_1_16_2_1_send = {
 	.expect_err = 0,
 	.send = &send_16_2_1,
 	.bcast = true,
+	.base = base_lc3_16_2_1,
+	.base_len = sizeof(base_lc3_16_2_1),
 };
 
 static const struct iso_client_data bcast_1_1_16_2_1_send = {
@@ -951,6 +1043,8 @@ static const struct iso_client_data bcast_1_1_16_2_1_send = {
 	.expect_err = 0,
 	.send = &send_16_2_1,
 	.bcast = true,
+	.base = base_lc3_16_2_1,
+	.base_len = sizeof(base_lc3_16_2_1),
 };
 
 static const struct iso_client_data bcast_16_2_1_recv = {
@@ -969,6 +1063,31 @@ static const struct iso_client_data bcast_enc_16_2_1_recv = {
 	.server = true,
 };
 
+static const struct iso_client_data bcast_ac_12 = {
+	.qos = BCAST_AC_12,
+	.expect_err = 0,
+	.bcast = true,
+	.base = base_lc3_ac_12,
+	.base_len = sizeof(base_lc3_ac_12),
+};
+
+static const struct iso_client_data bcast_ac_13 = {
+	.qos = BCAST_AC_13,
+	.expect_err = 0,
+	.bcast = true,
+	.mconn = true,
+	.base = base_lc3_ac_13,
+	.base_len = sizeof(base_lc3_ac_13),
+};
+
+static const struct iso_client_data bcast_ac_14 = {
+	.qos = BCAST_AC_14,
+	.expect_err = 0,
+	.bcast = true,
+	.base = base_lc3_ac_14,
+	.base_len = sizeof(base_lc3_ac_14),
+};
+
 static void client_connectable_complete(uint16_t opcode, uint8_t status,
 					const void *param, uint8_t len,
 					void *user_data)
@@ -1255,22 +1374,6 @@ static int create_iso_sock(struct test_data *data)
 	return sk;
 }
 
-static const uint8_t base_lc3_16_2_1[] = {
-	0x28, 0x00, 0x00, /* Presentation Delay */
-	0x01, /* Number of Subgroups */
-	0x01, /* Number of BIS */
-	0x06, 0x00, 0x00, 0x00, 0x00, /* Code ID = LC3 (0x06) */
-	0x11, /* Codec Specific Configuration */
-	0x02, 0x01, 0x03, /* 16 KHZ */
-	0x02, 0x02, 0x01, /* 10 ms */
-	0x05, 0x03, 0x01, 0x00, 0x00, 0x00,  /* Front Left */
-	0x03, 0x04, 0x28, 0x00, /* Frame Length 40 bytes */
-	0x04, /* Metadata */
-	0x03, 0x02, 0x02, 0x00, /* Audio Context: Convertional */
-	0x01, /* BIS */
-	0x00, /* Codec Specific Configuration */
-};
-
 static int connect_iso_sock(struct test_data *data, uint8_t num, int sk)
 {
 	const struct iso_client_data *isodata = data->test_data;
@@ -1283,7 +1386,7 @@ static int connect_iso_sock(struct test_data *data, uint8_t num, int sk)
 
 	client = hciemu_get_client(data->hciemu, num);
 	if (!client) {
-		if (!isodata->mcis) {
+		if (!isodata->mconn) {
 			tester_warn("No client");
 			return -ENODEV;
 		}
@@ -1295,7 +1398,7 @@ static int connect_iso_sock(struct test_data *data, uint8_t num, int sk)
 		}
 	}
 
-	if (num && isodata->mcis)
+	if (!isodata->bcast && num && isodata->mconn)
 		qos = &isodata->qos_2;
 
 	if (!isodata->bcast) {
@@ -1304,9 +1407,9 @@ static int connect_iso_sock(struct test_data *data, uint8_t num, int sk)
 			tester_warn("No client bdaddr");
 			return -ENODEV;
 		}
-	} else {
+	} else if (!isodata->server) {
 		err = setsockopt(sk, SOL_BLUETOOTH, BT_ISO_BASE,
-				base_lc3_16_2_1, sizeof(base_lc3_16_2_1));
+				isodata->base, isodata->base_len);
 		if (err < 0) {
 			tester_warn("Can't set socket BT_ISO_BASE option: "
 					"%s (%d)", strerror(errno), errno);
@@ -1323,7 +1426,7 @@ static int connect_iso_sock(struct test_data *data, uint8_t num, int sk)
 		return -EINVAL;
 	}
 
-	if (isodata->defer) {
+	if (isodata->defer || (isodata->bcast && isodata->mconn && !num)) {
 		int opt = 1;
 
 		if (setsockopt(sk, SOL_BLUETOOTH, BT_DEFER_SETUP, &opt,
@@ -1694,7 +1797,7 @@ static gboolean iso_connect(GIOChannel *io, GIOCondition cond,
 
 	if (!isodata->bcast) {
 		ret = check_ucast_qos(&qos, &isodata->qos,
-				      isodata->mcis ? &isodata->qos_2 : NULL);
+				      isodata->mconn ? &isodata->qos_2 : NULL);
 	} else if (!isodata->server)
 		ret = check_bcast_qos(&qos, &isodata->qos);
 
@@ -1879,7 +1982,7 @@ static void test_connect(const void *test_data)
 	func[n++] = iso_connect_cb;
 
 	/* Check if configuration requires multiple CIS setup */
-	if (!isodata->bcast && isodata->mcis)
+	if (!isodata->bcast && isodata->mconn)
 		func[n++] = iso_connect2_cb;
 
 	setup_connect_many(data, n, num, func);
@@ -2179,6 +2282,15 @@ static void test_bcast(const void *test_data)
 	setup_connect(data, 0, iso_connect_cb);
 }
 
+static void test_bcast2(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	uint8_t num[2] = {0, 1};
+	GIOFunc funcs[2] = {iso_connect_cb, iso_connect2_cb};
+
+	setup_connect_many(data, 2, num, funcs);
+}
+
 static void test_bcast_recv(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -2431,5 +2543,14 @@ int main(int argc, char *argv[])
 							setup_powered,
 							test_bcast_recv);
 
+	test_iso("ISO Broadcaster AC 12 - Success", &bcast_ac_12, setup_powered,
+							test_bcast);
+
+	test_iso("ISO Broadcaster AC 13 - Success", &bcast_ac_13, setup_powered,
+							test_bcast2);
+
+	test_iso("ISO Broadcaster AC 14 - Success", &bcast_ac_14, setup_powered,
+							test_bcast);
+
 	return tester_run();
 }
-- 
2.34.1

