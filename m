Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2059.outbound.protection.outlook.com [40.107.105.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835997353F
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 May 2024 10:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716288951; cv=fail; b=Pns6HyREoChuQNX4lp67FEZ9gyGWd0pd/9IV4qVd3x5Fq+HJ+ZPQmV41s710RN/xed6BJHrAdRAWoB0JkAkL0q3DSPCnaV6WDwQdRJT3SBgdRV9ZYjCK20FO2lwzVInPf3gPEhRBYfKOjp4QG9En8y3j8rhgqJft/GIObFVGijk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716288951; c=relaxed/simple;
	bh=eillIdEFyw4KIJQFp/mTxpp0JAeHI4uWsIAHdCRJ8y4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QDi15vjTuZCySFGJ33ob7p1lc7WzoeROcd2h/cRd0cknrFm0q4MvyWThrQBiQNF/jXsj7qpzfGA8j+PhpM6kC0rR3yRJKu+luOM0n7hGrhI8BLDcYcmtR8fKvVqCMMSpNFzvSUTWANO4+RifrjGh3Et/irJTrTeiDKejtP02EL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=fR0d79ZV; arc=fail smtp.client-ip=40.107.105.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fR0d79ZV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glquDQ1jBzh3XyBGd2vshI2mC/W5/WbUkgBk+XU3hCORLTntW3vGwFLwy5g0IiJClV7M0Vvv5n1Zav73mRH7/TFpvYUbGXK1pZqQutazbhSrbAY0N8CdW/4OCg3e2juroMQoDwkagGf8QMSdbhEV3SFweU3XpuUrHbpApUU+di32K3uudkaj4J4nGGuP06w8211dvmKcTE1Z7t8QUZMdwOdMXispXdwoZk9m6g3pFjHOHVXrEKsKtZIOIjnsojwpV2tn+6uwTnSo9aix7KALoSIk6mQEdVooEcohjqW7qXLSwnAkLu4vW6jmxnuuBevai6w4kl2ROxd9A2OVNZRqsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfdZkau3pUkjytA/Tt70DW5YI9CwOeD8BaaNsl55q7U=;
 b=c+v/WFb6WqJmBTqzrUVKyMBgdhiiW7qbcfn8oXQw6faD5dFPPuhYsbGVjEB0ubMWfyqocFJdAiU5k0vADWWVfruWAiTgepBZs+rs0t+FU0mewRxfHuyU3CJ7yCmMpBQlc5D7ObIsVJVAKoUzT1VbaI8ncKB0+PI+KtqfV+TDgK0paszyy187JOiK8ue621EceWLN+VfP/ObD5J24qluM5Txo474D4V5kEI2VFVUh/PEfTOmqWy3o4LmUUH63WM1HE/Qb73Y/IOH5xdGwwSSR1MSOFo59zln06QnAkmre9oiH9CTtnACu1RqeOKDB0lCJJiwCfuR4Vo8XEEF265Aw3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfdZkau3pUkjytA/Tt70DW5YI9CwOeD8BaaNsl55q7U=;
 b=fR0d79ZVLbdQHiPnz2Dn2SDhryVeeD33/CSIcgsIdg3jgmZbITyvHmcx6iZwQ0Fk+DiK6EB2JdKUGfSmxX3dCZmeY+OMGCT55ZItMhCgsCtlpFkar1lGsKL22fts1xdEeIO/w3LtDPVf25sECtlDOjSko07ojMTKgP0ETwQQtgA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by GVXPR04MB10947.eurprd04.prod.outlook.com (2603:10a6:150:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 10:55:47 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 10:55:47 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 2/3] test-bap: Add support for multiple bcast streams
Date: Tue, 21 May 2024 13:55:14 +0300
Message-Id: <20240521105515.103972-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240521105515.103972-1-iulia.tanasescu@nxp.com>
References: <20240521105515.103972-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0018.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::11) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|GVXPR04MB10947:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d5d5dcf-e7b1-4e09-3cda-08dc798491e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X99Kvy3HziN/c0K8lv4NAzxEREArpatGDPk7la86cCO/ZGcyj57cbfC3k1EA?=
 =?us-ascii?Q?SCfczNsvMiGJTWxS1rJ+gdpBjWx3Xae+hFM/becfICGc+QPGmahHwjuBL7gT?=
 =?us-ascii?Q?RjgFvHKDKsXp/lfYrFmxRHxcnGzv87pTqnMBUFsOnEb7/XBZs6Wv8eysUutc?=
 =?us-ascii?Q?GK1gFUT9Zgal6fIEnbJ/2rHYOnljze3weq1tUe0H7CtsWT84D5f60iKzBsHF?=
 =?us-ascii?Q?btxmnC+hQseSFBWKDaqmgxon0Q5PuO0h34F6EL9WwB6p1YuT6bbj/Idx/zjb?=
 =?us-ascii?Q?ddICvU0zQkjbP6aczxh3+fRoHRnaUzzHLjj7q8B+jvXBDA06pnruuqz0qkDY?=
 =?us-ascii?Q?qjd61Cayep2M7l4WkSnW7QceA2MDpPLwV/l4tYOzeZ2WT1lRSWusikHh8ZIg?=
 =?us-ascii?Q?AAOZOB/NiRy9AakZrbWT43EDGI8rmSUbi9/psQdGrE+4qoorqrYQoozzsb5q?=
 =?us-ascii?Q?OOPk7sRtKNzYRzekoDwOk2Nmcg6gyqIRFhBwYeg0Ibx43WtvCt2a9KojCEqa?=
 =?us-ascii?Q?3DN66ayPRqMOR7kkwq9FMrAw2Byr+g/AyE/vA7AS+NEfk1mWduW2X2obqIH9?=
 =?us-ascii?Q?cDCxUNXzynw1dE0DoldRuDvvZqexEw04WQvVae5677VQYUwNZR2xYTzi8Wv+?=
 =?us-ascii?Q?tG+H5tbt19MZaSBXuRIgkRDDIPqcNuuln2aH3TD3o+4QeWHCZINMceLTRpnR?=
 =?us-ascii?Q?JEhSTdgC8kVi2cAQhaMLxGvmpvj4YPgjD+43SWXGR1yGeWcS+Laz7v5qrNFT?=
 =?us-ascii?Q?vdgo7As50A6CC93qWminyPwhZEx6ZJnxApip8O+Ud1dmjDABtaKu0QMGP0he?=
 =?us-ascii?Q?Ovwnx/Nzs900UqBZ5al/1oyINV0otAycU4NX6VxK5AmQ6YrdhC+1xbdtu6l+?=
 =?us-ascii?Q?rxPFydLrymI5j+OlPv8suP5YEpEAPyD0M2XXu8/bUduX5ZNdxSSHgQSahoxl?=
 =?us-ascii?Q?ci+vORg5qXgvRb/rYrS5G62oRi+2kwwqcW1+ELmc35Xom0U6bpTIpjUV2qnr?=
 =?us-ascii?Q?pptpE5c/e7PTWgH8vMu3n4NPhJFywUxgBG9FfHhCaShcGz7floug/aD5i0gT?=
 =?us-ascii?Q?WmQtkiK9ZAZmLyktI6yC9bE2hZWh8vwNS5c3Pf3Us11EeF7zIm+iiVdMs0+C?=
 =?us-ascii?Q?WXAqrHAModNhEeIIAqekYasKnwHoFsvbye73NrrLa31Yqje+zEpwiQ4A+CKF?=
 =?us-ascii?Q?jJpmXnK/tz9w/bnG4KNXFxv4woUwdcRyBAMzZIun6/rgrtvspKAnssV8de/U?=
 =?us-ascii?Q?8/kvqm+ZwXr/ORpGzFcuxfRrwVrs4qaGYuluXnKHYQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hWEyBQPaRlhpvT0BU6vraUI+5HhaKjBKPuwu4P5cX8sEYTadB9uJSbrg2CAV?=
 =?us-ascii?Q?kKXBIUdW4bnNByJZQ8O5GyWJelFqvZJ+T05iKvizUkwASqeAdxR011VOOzaa?=
 =?us-ascii?Q?s9XHsNd1AjCh+veHZ9wHlWwsrMfGEJ+kYRX9EYI5L8u38ImS5I6MnbxrR/Dm?=
 =?us-ascii?Q?D55eD+92lEqmvUoJyDBPxPBN/pPTIcKwO6BfAl/kg1J+arA8ckTk9hx3mSmQ?=
 =?us-ascii?Q?O+pUqCykvzIE+Z3mbDNfl9pBxyjvhLFeT4jyDFhVyuTMVVjy2SJHKiS2V9PR?=
 =?us-ascii?Q?tMqZ3VD0zQNeBsLkIuE+4vJYw6d7plWSyHpyRSnaajPv3dw23Sq4O+fFOknN?=
 =?us-ascii?Q?FI0V8YP8M2g0VL7i+3omx/GiZumZ0kopuzmVbEeWH0w5FhAXX2FhQTQnB0pI?=
 =?us-ascii?Q?tvWvMwolKhW9DAEbGM2cgpfFl01InIvOmRdhaXA5Sm6DnK9xJX1vvSZ8p74+?=
 =?us-ascii?Q?9VyTHM8F7yP+jPBJW7/VQ4ppd0puzvg7Gcxb0LPn+ZQ13xkXQxDAddrTsal3?=
 =?us-ascii?Q?q4HDOxlsbQ83MSUajrEavfkejArDbyGU07lGhEpHYTJaWaflyIYbdmO6cjNB?=
 =?us-ascii?Q?8IxXORNTgcCo7kU+oNzLgJziB9FWtE5qyYXUFsnNzeg5M77aY+bJO11bhkhz?=
 =?us-ascii?Q?tqWoqbfmY0vwVTS5hvmoyEOOi7b89JGvns00cJoX1iYjbkxVMBF/f6p9ZGbH?=
 =?us-ascii?Q?4NT5gGGE7kJf73QYux/8tj/2AB+Q/mAgJnXbtlHw/kc9Gl9a0dAmOk8/dmXG?=
 =?us-ascii?Q?UjRv+PTj/YMb/+7i4uMEb+YMMZY0ac2HINYE8KnFsfP5Lv5+As3Azcf8svoi?=
 =?us-ascii?Q?Qipmiq1xP1vFHgZESb1c5+EYk8GxCtg4e5SNZEqnFUu1di0rCJhhaEil/BP/?=
 =?us-ascii?Q?ucftm7zJ5zGVK1FfbV8IKfX4GianxigxB88pd7+1Bjq6qeqLQJHshg0avqn0?=
 =?us-ascii?Q?hExI3qxFUk/LoURp4MK348bpxP1JDSBdpaSzOMFagz7k9DodKhlU4Vf5qGIj?=
 =?us-ascii?Q?5AGI2wvdgkX+FlDAoBWv76kPIRBdntrmUmVU09oA+7OpRFHKXuNe2C52vXc0?=
 =?us-ascii?Q?JFGBrTN4Qic32x1Fu8IFtAS+4JgTHJEGRZYFshZHX/lyaWf38CNQbzJlAA9L?=
 =?us-ascii?Q?w4M2LfN9EDaVXyd82gKkTBU4cLzrYkPCqttKoUKjnHQhpIn8RYxIZXrJYmbF?=
 =?us-ascii?Q?ATs7dMBQYcWND+8gzsfzJu3hcI7RCSdcR9vwEYv6BE7PxY2PkIpbQgr8gNXC?=
 =?us-ascii?Q?Wl5/THyn/eLTTIKiQfm9CzOCU0Xv91CXc/xx7EWM4Se79xh4Q8tLynyb/cAL?=
 =?us-ascii?Q?VBnO1Yk/82Rxn3dhOwj6UUEpurSekDg2Bc1m44vK7za4eX3CdeCYB8CJVpjN?=
 =?us-ascii?Q?TnzbxsssMA5gOXmPNnxcWvqbOxyK0wPUr9BGzBMXVJYf4hgWG7IU42NlyabW?=
 =?us-ascii?Q?468SeyhG+8J+FIU9/Z40Wkk0yxFUo50VJwzK+6ebv6rXN3mItpF6gfyQVnEg?=
 =?us-ascii?Q?Pw2HHyjDnUbJPS87BqnWpQaEHZ1bL61QXRRwTG+FwGmjk53FE8SzpCt4XTMe?=
 =?us-ascii?Q?rmpUjq7FU+FsznmwkAiRdMQHUzaUuhto4KCN3fMuRGihCXyUyDmtykJ5vNeq?=
 =?us-ascii?Q?lQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5d5dcf-e7b1-4e09-3cda-08dc798491e4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 10:55:47.3177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6U6fGzorxZcEIygy1nWljDVSKqISpJVSVABJHMEU6XXA+SpT4+WgG5MT8BpiJJR1uyEWVXO749WfD06Fx5u+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10947

This adds support for implementing Broadcast tests that require multiple
streams to be configured (for example, 4.14.4 Broadcast Sink Receives
Audio Data Over Multiple BISes).

The number of required streams is added inside the test_config struct.
The bsnk_pac_added and the bsnk_state_str callbacks have been updated
to support multiple streams.
---
 unit/test-bap.c | 85 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 70 insertions(+), 15 deletions(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index 061c7a119..38a9f5c12 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -43,6 +43,7 @@ struct test_config {
 	bool vs;
 	uint8_t state;
 	bt_bap_state_func_t state_func;
+	uint8_t num_str;
 };
 
 struct test_data {
@@ -580,32 +581,35 @@ static void bsnk_pac_added(struct bt_bap_pac *pac, void *user_data)
 	struct iovec *cc;
 	struct bt_bap_codec codec = {0};
 	struct bt_bap_stream *stream;
+	uint8_t bis_idx = 1;
+
+	bt_bap_pac_set_ops(pac, &bcast_pac_ops, NULL);
 
 	if (data->cfg->vs)
 		codec.id = 0xff;
 	else
 		codec.id = LC3_ID;
 
-	bt_bap_verify_bis(data->bap, 1, &codec,
-			&data->cfg->cc, NULL, &lpac, &cc);
+	for (uint8_t i = 0; i < data->cfg->num_str; i++) {
+		bt_bap_verify_bis(data->bap, bis_idx++, &codec,
+				&data->cfg->cc, NULL, &lpac, &cc);
 
-	g_assert(lpac);
-	g_assert(pac == lpac);
-	g_assert(cc);
-
-	bt_bap_pac_set_ops(pac, &bcast_pac_ops, NULL);
+		g_assert(lpac);
+		g_assert(pac == lpac);
+		g_assert(cc);
 
-	stream = bt_bap_stream_new(data->bap,
-		pac, NULL, &data->cfg->qos, cc);
+		stream = bt_bap_stream_new(data->bap,
+			pac, NULL, &data->cfg->qos, cc);
 
-	g_assert(stream);
+		g_assert(stream);
 
-	queue_push_tail(data->streams, stream);
+		queue_push_tail(data->streams, stream);
 
-	bt_bap_stream_config(stream, &data->cfg->qos,
-			cc, NULL, NULL);
+		bt_bap_stream_config(stream, &data->cfg->qos,
+				cc, NULL, NULL);
 
-	util_iov_free(cc, 1);
+		util_iov_free(cc, 1);
+	}
 }
 
 static void bsnk_state(struct bt_bap_stream *stream, uint8_t old_state,
@@ -6138,6 +6142,7 @@ static struct test_config cfg_bsnk_8_1 = {
 	.qos = QOS_BCAST,
 	.snk = true,
 	.state_func = bsnk_state,
+	.num_str = 1,
 };
 
 static struct test_config cfg_bsnk_8_2 = {
@@ -6145,6 +6150,7 @@ static struct test_config cfg_bsnk_8_2 = {
 	.qos = QOS_BCAST,
 	.snk = true,
 	.state_func = bsnk_state,
+	.num_str = 1,
 };
 
 static struct test_config cfg_bsnk_16_1 = {
@@ -6152,6 +6158,7 @@ static struct test_config cfg_bsnk_16_1 = {
 	.qos = QOS_BCAST,
 	.snk = true,
 	.state_func = bsnk_state,
+	.num_str = 1,
 };
 
 static struct test_config cfg_bsnk_16_2 = {
@@ -6159,6 +6166,7 @@ static struct test_config cfg_bsnk_16_2 = {
 	.qos = QOS_BCAST,
 	.snk = true,
 	.state_func = bsnk_state,
+	.num_str = 1,
 };
 
 static struct test_config cfg_bsnk_24_1 = {
@@ -6166,6 +6174,7 @@ static struct test_config cfg_bsnk_24_1 = {
 	.qos = QOS_BCAST,
 	.snk = true,
 	.state_func = bsnk_state,
+	.num_str = 1,
 };
 
 static struct test_config cfg_bsnk_24_2 = {
@@ -6173,6 +6182,7 @@ static struct test_config cfg_bsnk_24_2 = {
 	.qos = QOS_BCAST,
 	.snk = true,
 	.state_func = bsnk_state,
+	.num_str = 1,
 };
 
 static struct test_config cfg_bsnk_32_1 = {
@@ -6180,6 +6190,7 @@ static struct test_config cfg_bsnk_32_1 = {
 	.qos = QOS_BCAST,
 	.snk = true,
 	.state_func = bsnk_state,
+	.num_str = 1,
 };
 
 static struct test_config cfg_bsnk_32_2 = {
@@ -6187,6 +6198,7 @@ static struct test_config cfg_bsnk_32_2 = {
 	.qos = QOS_BCAST,
 	.snk = true,
 	.state_func = bsnk_state,
+	.num_str = 1,
 };
 
 static struct test_config cfg_bsnk_44_1 = {
@@ -6194,6 +6206,7 @@ static struct test_config cfg_bsnk_44_1 = {
 	.qos = QOS_BCAST,
 	.snk = true,
 	.state_func = bsnk_state,
+	.num_str = 1,
 };
 
 static struct test_config cfg_bsnk_44_2 = {
@@ -6201,6 +6214,7 @@ static struct test_config cfg_bsnk_44_2 = {
 	.qos = QOS_BCAST,
 	.snk = true,
 	.state_func = bsnk_state,
+	.num_str = 1,
 };
 
 static struct test_config cfg_bsnk_48_1 = {
@@ -6208,6 +6222,7 @@ static struct test_config cfg_bsnk_48_1 = {
 	.qos = QOS_BCAST,
 	.snk = true,
 	.state_func = bsnk_state,
+	.num_str = 1,
 };
 
 static struct test_config cfg_bsnk_48_2 = {
@@ -6215,6 +6230,7 @@ static struct test_config cfg_bsnk_48_2 = {
 	.qos = QOS_BCAST,
 	.snk = true,
 	.state_func = bsnk_state,
+	.num_str = 1,
 };
 
 static struct test_config cfg_bsnk_48_3 = {
@@ -6222,6 +6238,7 @@ static struct test_config cfg_bsnk_48_3 = {
 	.qos = QOS_BCAST,
 	.snk = true,
 	.state_func = bsnk_state,
+	.num_str = 1,
 };
 
 static struct test_config cfg_bsnk_48_4 = {
@@ -6229,6 +6246,7 @@ static struct test_config cfg_bsnk_48_4 = {
 	.qos = QOS_BCAST,
 	.snk = true,
 	.state_func = bsnk_state,
+	.num_str = 1,
 };
 
 static struct test_config cfg_bsnk_48_5 = {
@@ -6236,6 +6254,7 @@ static struct test_config cfg_bsnk_48_5 = {
 	.qos = QOS_BCAST,
 	.snk = true,
 	.state_func = bsnk_state,
+	.num_str = 1,
 };
 
 static struct test_config cfg_bsnk_48_6 = {
@@ -6243,6 +6262,7 @@ static struct test_config cfg_bsnk_48_6 = {
 	.qos = QOS_BCAST,
 	.snk = true,
 	.state_func = bsnk_state,
+	.num_str = 1,
 };
 
 static struct test_config cfg_bsnk_vs = {
@@ -6251,6 +6271,7 @@ static struct test_config cfg_bsnk_vs = {
 	.snk = true,
 	.vs = true,
 	.state_func = bsnk_state,
+	.num_str = 1,
 };
 
 static void test_bsnk_scc(void)
@@ -6355,11 +6376,21 @@ static void test_bsnk_scc(void)
 		NULL, test_bcast, &cfg_bsnk_vs, IOV_NULL);
 }
 
+static void stream_count_streaming(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = data;
+	uint8_t *num = user_data;
+
+	if (bt_bap_stream_get_state(stream) == BT_BAP_STREAM_STATE_STREAMING)
+		(*num)++;
+}
+
 static void bsnk_state_str(struct bt_bap_stream *stream, uint8_t old_state,
 				uint8_t new_state, void *user_data)
 {
 	struct test_data *data = user_data;
 	struct iovec *cc;
+	uint8_t num = 0;
 
 	switch (new_state) {
 	case BT_BAP_STREAM_STATE_CONFIG:
@@ -6384,7 +6415,14 @@ static void bsnk_state_str(struct bt_bap_stream *stream, uint8_t old_state,
 
 		break;
 	case BT_BAP_STREAM_STATE_STREAMING:
-		tester_test_passed();
+		queue_foreach(data->streams, stream_count_streaming, &num);
+
+		if (num == data->cfg->num_str)
+			/* Test is completed after all streams have transitioned
+			 * to STREAMING state.
+			 */
+			tester_test_passed();
+
 		break;
 	}
 }
@@ -6394,6 +6432,7 @@ static struct test_config cfg_bsnk_str_8_1 = {
 	.qos = QOS_BCAST,
 	.snk = true,
 	.state_func = bsnk_state_str,
+	.num_str = 1,
 };
 
 static struct test_config cfg_bsnk_str_8_2 = {
@@ -6401,6 +6440,7 @@ static struct test_config cfg_bsnk_str_8_2 = {
 	.qos = QOS_BCAST,
 	.snk = true,
 	.state_func = bsnk_state_str,
+	.num_str = 1,
 };
 
 static struct test_config cfg_bsnk_str_16_1 = {
@@ -6408,6 +6448,7 @@ static struct test_config cfg_bsnk_str_16_1 = {
 	.qos = QOS_BCAST,
 	.snk = true,
 	.state_func = bsnk_state_str,
+	.num_str = 1,
 };
 
 static struct test_config cfg_bsnk_str_16_2 = {
@@ -6415,6 +6456,7 @@ static struct test_config cfg_bsnk_str_16_2 = {
 	.qos = QOS_BCAST,
 	.snk = true,
 	.state_func = bsnk_state_str,
+	.num_str = 1,
 };
 
 static struct test_config cfg_bsnk_str_24_1 = {
@@ -6422,6 +6464,7 @@ static struct test_config cfg_bsnk_str_24_1 = {
 	.qos = QOS_BCAST,
 	.snk = true,
 	.state_func = bsnk_state_str,
+	.num_str = 1,
 };
 
 static struct test_config cfg_bsnk_str_24_2 = {
@@ -6429,6 +6472,7 @@ static struct test_config cfg_bsnk_str_24_2 = {
 	.qos = QOS_BCAST,
 	.snk = true,
 	.state_func = bsnk_state_str,
+	.num_str = 1,
 };
 
 static struct test_config cfg_bsnk_str_32_1 = {
@@ -6436,6 +6480,7 @@ static struct test_config cfg_bsnk_str_32_1 = {
 	.qos = QOS_BCAST,
 	.snk = true,
 	.state_func = bsnk_state_str,
+	.num_str = 1,
 };
 
 static struct test_config cfg_bsnk_str_32_2 = {
@@ -6443,6 +6488,7 @@ static struct test_config cfg_bsnk_str_32_2 = {
 	.qos = QOS_BCAST,
 	.snk = true,
 	.state_func = bsnk_state_str,
+	.num_str = 1,
 };
 
 static struct test_config cfg_bsnk_str_44_1 = {
@@ -6450,6 +6496,7 @@ static struct test_config cfg_bsnk_str_44_1 = {
 	.qos = QOS_BCAST,
 	.snk = true,
 	.state_func = bsnk_state_str,
+	.num_str = 1,
 };
 
 static struct test_config cfg_bsnk_str_44_2 = {
@@ -6457,6 +6504,7 @@ static struct test_config cfg_bsnk_str_44_2 = {
 	.qos = QOS_BCAST,
 	.snk = true,
 	.state_func = bsnk_state_str,
+	.num_str = 1,
 };
 
 static struct test_config cfg_bsnk_str_48_1 = {
@@ -6464,6 +6512,7 @@ static struct test_config cfg_bsnk_str_48_1 = {
 	.qos = QOS_BCAST,
 	.snk = true,
 	.state_func = bsnk_state_str,
+	.num_str = 1,
 };
 
 static struct test_config cfg_bsnk_str_48_2 = {
@@ -6471,6 +6520,7 @@ static struct test_config cfg_bsnk_str_48_2 = {
 	.qos = QOS_BCAST,
 	.snk = true,
 	.state_func = bsnk_state_str,
+	.num_str = 1,
 };
 
 static struct test_config cfg_bsnk_str_48_3 = {
@@ -6478,6 +6528,7 @@ static struct test_config cfg_bsnk_str_48_3 = {
 	.qos = QOS_BCAST,
 	.snk = true,
 	.state_func = bsnk_state_str,
+	.num_str = 1,
 };
 
 static struct test_config cfg_bsnk_str_48_4 = {
@@ -6485,6 +6536,7 @@ static struct test_config cfg_bsnk_str_48_4 = {
 	.qos = QOS_BCAST,
 	.snk = true,
 	.state_func = bsnk_state_str,
+	.num_str = 1,
 };
 
 static struct test_config cfg_bsnk_str_48_5 = {
@@ -6492,6 +6544,7 @@ static struct test_config cfg_bsnk_str_48_5 = {
 	.qos = QOS_BCAST,
 	.snk = true,
 	.state_func = bsnk_state_str,
+	.num_str = 1,
 };
 
 static struct test_config cfg_bsnk_str_48_6 = {
@@ -6499,6 +6552,7 @@ static struct test_config cfg_bsnk_str_48_6 = {
 	.qos = QOS_BCAST,
 	.snk = true,
 	.state_func = bsnk_state_str,
+	.num_str = 1,
 };
 
 static struct test_config cfg_bsnk_str_vs = {
@@ -6507,6 +6561,7 @@ static struct test_config cfg_bsnk_str_vs = {
 	.snk = true,
 	.vs = true,
 	.state_func = bsnk_state_str,
+	.num_str = 1,
 };
 
 static void test_bsnk_str(void)
-- 
2.39.2

