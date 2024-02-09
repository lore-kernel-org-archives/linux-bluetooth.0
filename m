Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2046.outbound.protection.outlook.com [40.107.104.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0A484A47
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Feb 2024 16:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707497206; cv=fail; b=fJkOopdbwBdU1y9L9+tKPli5mvzGwjwbydeK1eTvsz43uwf1fxZWghBzmJY8nGRCl4Hslhek0Djvksp1H7guhQHl1LSuaUcmYXKY8PPUDEuvG75nVmAkZ22yd0jc5hC0NcmR4I939JOarVaZM7s/valrvafjj+CY3+Xcs1RbhrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707497206; c=relaxed/simple;
	bh=MV2lwYDzXA5drsR7keXNUHXumjBsMuAqmVgVPZLoPz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z8E8enK9XdDx0BZ9rd73QhQcrEYFOWKAz4T/Q2khZf1rjGeL5P1KYgbWrliVDIHEIwPcCrd6XzrEPC7jvkLgwts7mMBW1OMvqLkfPBtsWYGSM/C05j5v+3MB33FWkTR3nZweTWc43POBWdpjuv6E6dXaveR+2m8TsOV047JyNrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZY0DY1N0; arc=fail smtp.client-ip=40.107.104.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZY0DY1N0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELv6pAQLNV4RBVxJ2mE4gpMxsMZV5fc6hfqYpr/X5Ssx2zt8XyIQEWqiSwMY4BW0EKD9WUHN03pd3URF2gtQ6DWshMeWpzSJYHsBfvKTNRLfGayS3tFqwf6WivyjapwYuG+EkpMP9mt2SWyn+/b5JKiE5UGAHKnZiLVKNAHa+KB3u5doX0JP5XMoWaS3V4LoOt7xTHMcuqhT/PxEd7ERal9LHdob8RSl04cyoS32U4lcqujMFwIv/fYjmJvvZCfIlA+46XdAbF9pCn38Ol3DGsWSxR5bCv9hiWv5Z3/OQn1FfDNTcJ4kqPCVCVxrD4hE8/FPuWBlV/kKPeogo0O7cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hH+EGwkcyUvZZL7fMRJGj6mqBencsEqJouEnxPT4J0=;
 b=I7MjJ5e002jPpD5qV+noZUmt/1mNWvmccmGjOiUg3WqNDmpLB7c7t2kBXxwu0hxF0A0aphb+AJbsqMed7vQN9VZwld1KhmeV1tfqo95Ij6rQ0bYF+S2B0XcUHf4b5PEkjQQu1jnkVIfAIjvbSPdmab9YajtWP4U4XFp4CQE5ddiH14wZC+7Ath7FxlLKb6VGobabJHee2HRI9RO7rzpjXfP5q5N/PTaw0ktFYMWWxthES0oDA2nLw7LR27LajKc35Vr1XRCRzQRNvXraySYyOvgYNki6InzH5m8tUMo9s4i0KrVTg6JuBp6PkFznJvpP5E0csbS9kZo1mTt6oC07dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hH+EGwkcyUvZZL7fMRJGj6mqBencsEqJouEnxPT4J0=;
 b=ZY0DY1N0mcqL4iUXM1zqVADBlHikTHcL9HwcbWKbSIKDbi4vTnEHBhDksL/rSNaiq0f1RKwK0uOpvLHkkQiB/la6m/B4eosQkfBXLYZ5fFuqz+qlOLy2zxS/UDrN1LlWZq7fC8eIHSRSt/2AEV7Ft9KM+MN+tL6ZsU9jN+zkb58=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by DB8PR04MB7097.eurprd04.prod.outlook.com (2603:10a6:10:12a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Fri, 9 Feb
 2024 16:46:37 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::bbd0:4409:3f0e:afdd]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::bbd0:4409:3f0e:afdd%4]) with mapi id 15.20.7249.039; Fri, 9 Feb 2024
 16:46:37 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ v2 2/6] shared/bap: Add API to convert parsed BASE into pac data
Date: Fri,  9 Feb 2024 18:46:26 +0200
Message-Id: <20240209164630.92208-3-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240209164630.92208-1-andrei.istodorescu@nxp.com>
References: <20240209164630.92208-1-andrei.istodorescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0042.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::21) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|DB8PR04MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f8fc64b-2631-453e-9e4d-08dc298eae7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2NH/JpgthcBorFetBpLIY5L5h3cSEVGuXZYB+dEhHXX4oL/FdqZ5UHqLAq213+5tSa1Yxrf9v2eCnXosAG2HGdKaiysEFZofre7PTAHPgbHeXZCZUIhtCdUWPtZE6+n/jAK36RxPK1Ts3z7dFvJMIPTR0Qbzf4ali3+RZ2z6FkxZgvj2V0nHHSIL7k2LLWBf4i557V/4avogkxINCK/S1IdXhAUb5HhupBbJrCHP/oO4WwrO5xqnIg9l6BsARSntKbAui1dP6pvFaNSjyWP4zVIsYTjb0T0xqEnG3Smdj9ePdRIuCQ3I8TbimsRAG258+xFQWDzVCYSOEJeGhDL4iMv1ZW48Nx1LjRzHhz39SGhn/tcxr9CG3UYT190AsTPH26ydeooLpPMscXzBR1xKgR39lRj/JNCvhu8UzJ1KSrkeyMm1/Qj/Cl4AGSfLtmS1aUTgGQt+hzOIQ3IiO8vuWO4DfcjrD7FfaierL3RJk1H1ZNrfPQvQ1Yy/rzyrkXzHgnT4pOdnUbwbnNZLy1vJcq6T+t/4Mxfe3PzfqR/g/YFuXYowQqnN1Tu5hUGhXUGk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(4326008)(5660300002)(30864003)(6916009)(66556008)(66946007)(8676002)(66476007)(8936002)(44832011)(2906002)(83380400001)(26005)(36756003)(86362001)(38100700002)(1076003)(6666004)(316002)(478600001)(41300700001)(6486002)(6506007)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QYxmoKEsUCEgLnllxdzQhpxKt9I3PoSHhGNIz4CTdfCfxHFdl9/Yp7tFisP7?=
 =?us-ascii?Q?DE9+80OqbaHkPPiQjeZSpfiun4VJGfA8lYdA+QU59rojxdadWWPh1T8/iics?=
 =?us-ascii?Q?MCH9SzLFhQCZjUhm3bVGDgOQnO6DQXdPrQqC+4soQzBkzujwNrf8x0NNWf4i?=
 =?us-ascii?Q?xQYAvHTbnVsLD0vz024mJo4K2X6OEzst91JatHSJZ2iX8gPMHLcO0ju8euaw?=
 =?us-ascii?Q?2AdsoNEaxXK3ItfJMaDKLcY93BzxWwbhIshx8MFmqyACBNAWIQ1CyDjKkbII?=
 =?us-ascii?Q?42D9qomOIPuREBTd8xhmpuvzTN9pbBqIfFoLFm+m39+hJqnnPDFJVrGqRCoV?=
 =?us-ascii?Q?J+uO5kOkeufBh/HqLbOFkfrpRm7621gHrhUfOwb3Li74B3FFHdQSS0MWnSrD?=
 =?us-ascii?Q?CQttjSA1wdzJ/TP1YhkkjnvcZ4FFzkkBQtqf8XjvSFNS2VHLH9BLPXZONMEO?=
 =?us-ascii?Q?9jdqvcmPifgOnHEmCAYlk3KwuxLFONUHY0yb4bZMmyeX6SeNzUdR/cVezW9c?=
 =?us-ascii?Q?/GHMqG8QXhKam8MyCDAHcA9Lh03/+0xvOw8GBh/3hS2zyhIFXhnJbRimFmS8?=
 =?us-ascii?Q?3D7E2e6heBwubAPkEE7g/u/A+rkwBiIPU8D+WqyEkMr4L3oppgEgt1ABlOZg?=
 =?us-ascii?Q?jTC9OT3kU7bbAghJmcuoU5I6aRs+CEx95jx98rbBiiQV0OJHsqI1qcAuwsUk?=
 =?us-ascii?Q?kRRL62gYqY9Ntd35hqWLlAMit5G/9VcjYwxgKl1gdIVxsUsPKAu1BNl5WSH0?=
 =?us-ascii?Q?VMQ+T5gIDpLrcDf/MoH/8z1lA/SgRseiitD2jOEgGbqhnH8Nda7zG9d2LktC?=
 =?us-ascii?Q?8+VXN5DiA+hTNghLeBKC9Ev04EBQiGAkaSLQKMLNyXHdtsrMc39X27vJatuK?=
 =?us-ascii?Q?ROekzs5DN1CVYKJLrehvE9ni3YfMQcx1gqjLQ+uUSKMrYapfsNfmCfUSD+4c?=
 =?us-ascii?Q?H0aibY/fVmVeMLerLTdpKSNpTNBiObdt66YXmLmfOuEeO4O5+/K6akexWZMq?=
 =?us-ascii?Q?3mtTs0GqtxMZi62QbSBh3xjI3UtTllRlM5oG2eNEK53fQ0p9Cowvr1fQ+eXH?=
 =?us-ascii?Q?2HQ+bu/9XquhtctauX9Q0agd+V4TI+OzjskmpOklrrDPLRLOrPeY3RmcSMUQ?=
 =?us-ascii?Q?+6mOWchPFbF78xUTSdMc3tA1GdcxZRaNQNOLQszv0Uz+EZhCsozYotU49Gqt?=
 =?us-ascii?Q?5immuTkxky8dVKQr1RLorJJnVS6nk1wOJhIuMrXzwIOaWZSYSsG96Ua2GYhR?=
 =?us-ascii?Q?Gce7/AUBlPjWZ0C3FhNjRnhFuLLfBEOSptbIuTDFnJ9BE+qIGBZVvkKmqRUm?=
 =?us-ascii?Q?z0VvMWCN/J0dQNttaGVsaqDviOfgqq9WhApz3FWVYTThE9QzENTQg1zPPklV?=
 =?us-ascii?Q?lPqpxk5qudx9SECDwBvHWdXQzu8OUe9mxswuF00vARQkItKc4M+YGkrp3gIt?=
 =?us-ascii?Q?GTUGDq1oIeIcxbeSClmHSGhBV1xX99FOGl5s4a4uCwTPQFuJTLrmW63pM2BQ?=
 =?us-ascii?Q?1cNIhdOhaKleBLL0gbf0Z9Q0pp/D+YSDuVCobdt4vvNbmV3m97aQEMCcPQdq?=
 =?us-ascii?Q?KmzD5MtrTF4ioZZwSZdpydv+7PnTyZ2uNfharbaq52qstXV0EsV72g6i3+5S?=
 =?us-ascii?Q?Ug=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8fc64b-2631-453e-9e4d-08dc298eae7b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 16:46:37.0656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xpyd+I4236iqkqsfVlCg7y1hxXzUEdPeLnM9HcMo/uvYgSapETLwlCkP8ieA2OdIFl6Tmwpi3PeAf+3FJvLfNi5q3wQdXOAqfW91SZpcAMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7097

Create one remote endpoint for each BIS present in the BASE which matches
the local sink capabilities. Add API to get the PAC metadata and
capabilities.
---
 src/shared/bap.c | 497 ++++++++++++++++++++++++++++++++++-------------
 src/shared/bap.h |  11 +-
 2 files changed, 375 insertions(+), 133 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index b481e4655c2d..d205632b3c80 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -48,6 +48,11 @@
 
 #define BAP_PROCESS_TIMEOUT 10
 
+#define BAP_FREQ_LTV_TYPE 1
+#define BAP_DURATION_LTV_TYPE 2
+#define BAP_CHANNEL_ALLOCATION_LTV_TYPE 3
+#define BAP_FRAME_LEN_LTV_TYPE 4
+
 struct bt_bap_pac_changed {
 	unsigned int id;
 	bt_bap_pac_func_t added;
@@ -3282,6 +3287,13 @@ static void bap_add_broadcast_source(struct bt_bap_pac *pac)
 static void bap_add_broadcast_sink(struct bt_bap_pac *pac)
 {
 	queue_push_tail(pac->bdb->broadcast_sinks, pac);
+
+	/* Update local PACS for broadcast sink also, when registering an
+	 * endpoint
+	 */
+	pacs_add_sink_location(pac->bdb->pacs, pac->qos.location);
+	pacs_add_sink_supported_context(pac->bdb->pacs,
+			pac->qos.supported_context);
 }
 
 static void notify_pac_added(void *data, void *user_data)
@@ -3433,6 +3445,16 @@ struct bt_bap_pac_qos *bt_bap_pac_get_qos(struct bt_bap_pac *pac)
 	return &pac->qos;
 }
 
+struct iovec *bt_bap_pac_get_data(struct bt_bap_pac *pac)
+{
+	return pac->data;
+}
+
+struct iovec *bt_bap_pac_get_metadata(struct bt_bap_pac *pac)
+{
+	return pac->metadata;
+}
+
 uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream)
 {
 	if (!stream)
@@ -5872,8 +5894,9 @@ static void add_new_subgroup(struct bt_bap_base *base,
 
 struct bt_ltv_match {
 	uint8_t l;
-	uint8_t *v;
+	void *data;
 	bool found;
+	uint32_t data32;
 };
 
 struct bt_ltv_search {
@@ -5892,7 +5915,7 @@ static void match_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
 	if (ltv_match->l != l)
 		return;
 
-	if (!memcmp(v, ltv_match->v, l))
+	if (!memcmp(v, ltv_match->data, l))
 		ltv_match->found = true;
 }
 
@@ -5904,7 +5927,7 @@ static void search_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
 
 	ltv_match.found = false;
 	ltv_match.l = l;
-	ltv_match.v = v;
+	ltv_match.data = v;
 
 	util_ltv_foreach(ltv_search->iov->iov_base,
 			ltv_search->iov->iov_len, &t,
@@ -5945,8 +5968,10 @@ static bool compare_ltv(struct iovec *iov1,
 }
 
 struct bt_ltv_extract {
-	struct iovec *result;
 	struct iovec *src;
+	void *value;
+	uint8_t len;
+	struct iovec *result;
 };
 
 static void extract_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
@@ -5958,7 +5983,7 @@ static void extract_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
 
 	ltv_match.found = false;
 	ltv_match.l = l;
-	ltv_match.v = v;
+	ltv_match.data = v;
 
 	/* Search each BIS caps ltv in subgroup caps
 	 * to extract the one that are BIS specific
@@ -6112,12 +6137,16 @@ static void cleanup_subgroup(struct bt_bap_subgroup *subgroup)
 		free(subgroup);
 }
 
+static void print_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
+		void *user_data)
+{
+	util_debug(user_data, NULL, "CC #%zu: l:%u t:%u", i, l, t);
+	util_hexdump(' ', v, l, user_data, NULL);
+}
+
 bool bt_bap_parse_base(struct bt_bap *bap, void *data, size_t len,
 		util_debug_func_t func, struct bt_bap_base *base)
 {
-	uint8_t num_subgroups;
-	uint8_t num_bis;
-
 	struct iovec iov = {
 		.iov_base = data,
 		.iov_len = len,
@@ -6132,161 +6161,369 @@ bool bt_bap_parse_base(struct bt_bap *bap, void *data, size_t len,
 
 	if (!util_iov_pull_u8(&iov, &base->num_subgroups))
 		return false;
-	util_debug(func, NULL, "NumSubgroups %d", base->num_subgroups);
-	num_subgroups = base->num_subgroups;
+	util_debug(func, NULL, "Number of Subgroups: %d", base->num_subgroups);
 
-	for (int sg = 0; sg < num_subgroups; sg++) {
-		struct bt_bap_subgroup *sub_group = new0(
+	for (int idx = 0; idx < base->num_subgroups; idx++) {
+		struct bt_bap_subgroup *subgroup = new0(
 						struct bt_bap_subgroup, 1);
-		uint8_t caps_len, metaLen;
-		uint8_t *hexstream;
 
-		sub_group->subgroup_index = sg;
+		subgroup->index = idx;
 
-		util_debug(func, NULL, "Subgroup #%d", sg);
-		sub_group->bap = bap;
-		sub_group->bises = queue_new();
+		util_debug(func, NULL, "Subgroup #%d", idx);
+		subgroup->bap = bap;
+		subgroup->bises = queue_new();
 
-		if (!util_iov_pull_u8(&iov, &num_bis)) {
-			cleanup_subgroup(sub_group);
+		if (!util_iov_pull_u8(&iov, &subgroup->num_bises))
 			goto fail;
-		}
-		util_debug(func, NULL, "NumBis %d", num_bis);
-		sub_group->num_bises = num_bis;
-
-		memcpy(&sub_group->codec, util_iov_pull_mem(&iov,
-		sizeof(struct bt_bap_codec)), sizeof(struct bt_bap_codec));
-		util_debug(func, NULL, "%s: ID %d CID 0x%2.2x VID 0x%2.2x",
-			"Codec", sub_group->codec.id, sub_group->codec.cid,
-				sub_group->codec.vid);
-		if (!util_iov_pull_u8(&iov, &caps_len)) {
-			cleanup_subgroup(sub_group);
-			goto fail;
-		}
 
-		util_debug(func, NULL, "CC Len %d", caps_len);
+		util_debug(func, NULL, "Number of BISes: %d",
+				subgroup->num_bises);
 
-		/*
-		 * Copy the Codec Specific configurations from base
-		 */
-		sub_group->caps = new0(struct iovec, 1);
-		util_iov_memcpy(sub_group->caps, iov.iov_base, caps_len);
-		util_debug(func, NULL, "subgroup caps len %ld",
-				sub_group->caps->iov_len);
-
-		for (int i = 0; caps_len > 1; i++) {
-			struct bt_ltv *ltv = util_iov_pull_mem(&iov,
-								sizeof(*ltv));
-			uint8_t *caps;
-
-			if (!ltv) {
-				util_debug(func, NULL, "Unable to parse %s",
-							"Capabilities");
-				cleanup_subgroup(sub_group);
-				goto fail;
-			}
+		memcpy(&subgroup->codec, util_iov_pull_mem(&iov,
+				sizeof(struct bt_bap_codec)),
+				sizeof(struct bt_bap_codec));
+		util_debug(func, NULL, "Codec: ID %d CID 0x%2.2x VID 0x%2.2x",
+				subgroup->codec.id, subgroup->codec.cid,
+				subgroup->codec.vid);
 
-			util_debug(func, NULL, "%s #%u: len %u type %u",
-						"CC", i, ltv->len, ltv->type);
+		/* BASE Level 2 */
+		/* Read Codec Specific Configuration */
+		subgroup->caps = new0(struct iovec, 1);
+		if (!util_iov_pull_u8(&iov, (void *)&subgroup->caps->iov_len))
+			goto fail;
 
-			caps = util_iov_pull_mem(&iov, ltv->len - 1);
-			if (!caps) {
-				util_debug(func, NULL, "Unable to parse %s",
-									"CC");
-				cleanup_subgroup(sub_group);
-				goto fail;
-			}
-			util_hexdump(' ', caps, ltv->len - 1, func, NULL);
+		util_iov_memcpy(subgroup->caps,
+				util_iov_pull_mem(&iov,
+				subgroup->caps->iov_len),
+				subgroup->caps->iov_len);
 
-			caps_len -= (ltv->len + 1);
-		}
+		/* Print Codec Specific Configuration */
+		util_debug(func, NULL, "CC len: %ld",
+				subgroup->caps->iov_len);
+		util_ltv_foreach(subgroup->caps->iov_base,
+				subgroup->caps->iov_len, NULL, print_ltv, func);
 
-		if (!util_iov_pull_u8(&iov, &metaLen)) {
-			cleanup_subgroup(sub_group);
+		/* Read Metadata */
+		subgroup->meta = new0(struct iovec, 1);
+		if (!util_iov_pull_u8(&iov, (void *)&subgroup->meta->iov_len))
 			goto fail;
-		}
-		util_debug(func, NULL, "Metadata Len %d", metaLen);
 
-		sub_group->meta = new0(struct iovec, 1);
-		sub_group->meta->iov_len = metaLen;
-		sub_group->meta->iov_base = iov.iov_base;
+		util_iov_memcpy(subgroup->meta,
+				util_iov_pull_mem(&iov,
+						subgroup->meta->iov_len),
+				subgroup->meta->iov_len);
 
-		hexstream = util_iov_pull_mem(&iov, metaLen);
-		if (!hexstream) {
-			cleanup_subgroup(sub_group);
-			goto fail;
-		}
-		util_hexdump(' ', hexstream, metaLen, func, NULL);
+		/* Print Metadata */
+		util_debug(func, NULL, "Metadata len: %i",
+				(uint8_t)subgroup->meta->iov_len);
+		util_hexdump(' ', subgroup->meta->iov_base,
+				subgroup->meta->iov_len, func, NULL);
 
-		for (int bis_sg = 0; bis_sg < sub_group->num_bises; bis_sg++) {
+		/* BASE Level 3 */
+		for (int bis_sg = 0; bis_sg < subgroup->num_bises; bis_sg++) {
 			struct bt_bap_bis *bis;
-			uint8_t caps_len;
-			uint8_t crt_bis;
 
-			if (!util_iov_pull_u8(&iov, &crt_bis)) {
-				cleanup_subgroup(sub_group);
+			bis = new0(struct bt_bap_bis, 1);
+			if (!util_iov_pull_u8(&iov, &bis->index))
 				goto fail;
-			}
-			util_debug(func, NULL, "BIS #%d", crt_bis);
 
-			bis = new0(struct bt_bap_bis, 1);
-			bis->index = crt_bis;
+			util_debug(func, NULL, "BIS #%d", bis->index);
 
-			if (!util_iov_pull_u8(&iov, &caps_len)) {
-				cleanup_subgroup(sub_group);
+			/* Read Codec Specific Configuration */
+			bis->caps = new0(struct iovec, 1);
+			if (!util_iov_pull_u8(&iov,
+					(void *)&bis->caps->iov_len))
 				goto fail;
-			}
-			util_debug(func, NULL, "CC Len %d", caps_len);
 
-			bis->caps = new0(struct iovec, 1);
-			bis->caps->iov_len = caps_len;
-			util_iov_memcpy(bis->caps, iov.iov_base, caps_len);
-			util_debug(func, NULL, "bis caps len %ld",
+			util_iov_memcpy(bis->caps,
+					util_iov_pull_mem(&iov,
+					bis->caps->iov_len),
 					bis->caps->iov_len);
 
-			for (int i = 0; caps_len > 1; i++) {
-				struct bt_ltv *ltv = util_iov_pull_mem(&iov,
-								sizeof(*ltv));
-				uint8_t *caps;
-
-				if (!ltv) {
-					util_debug(func, NULL, "Unable to parse %s",
-								"Capabilities");
-					cleanup_subgroup(sub_group);
-					goto fail;
-				}
-
-				util_debug(func, NULL, "%s #%u: len %u type %u",
-						"CC", i, ltv->len, ltv->type);
-
-				caps = util_iov_pull_mem(&iov, ltv->len - 1);
-				if (!caps) {
-					util_debug(func, NULL,
-						"Unable to parse %s", "CC");
-					cleanup_subgroup(sub_group);
-					goto fail;
-				}
-				util_hexdump(' ', caps, ltv->len - 1, func,
-									NULL);
-
-				caps_len -= (ltv->len + 1);
-			}
+			/* Print Codec Specific Configuration */
+			util_debug(func, NULL, "CC Len: %d",
+					(uint8_t)bis->caps->iov_len);
+			util_ltv_foreach(bis->caps->iov_base,
+					bis->caps->iov_len, NULL, print_ltv,
+					func);
 
-			queue_push_tail(sub_group->bises, bis);
+			queue_push_tail(subgroup->bises, bis);
 		}
 
-		queue_push_tail(base->subgroups, sub_group);
+		queue_push_tail(base->subgroups, subgroup);
 	}
 	return true;
 
 fail:
-	while (!queue_isempty(base->subgroups)) {
-		struct bt_bap_subgroup *subGroup =
-				queue_peek_head(base->subgroups);
-		cleanup_subgroup(subGroup);
-		base->num_subgroups--;
-	}
 	util_debug(func, NULL, "Unable to parse %s", "Base");
 
 	return false;
 }
+
+static void bap_sink_get_allocation(size_t i, uint8_t l, uint8_t t,
+		uint8_t *v, void *user_data)
+{
+	uint32_t location32;
+
+	if (!v)
+		return;
+
+	memcpy(&location32, v, l);
+	*((uint32_t *)user_data) = le32_to_cpu(location32);
+}
+
+/*
+ * This function compares PAC Codec Specific Capabilities, with the Codec
+ * Specific Configuration LTVs received in the BASE of the BAP Source. The
+ * result is accumulated in data32 which is a bitmask of types.
+ */
+static void check_pac_caps_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
+					void *user_data)
+{
+	struct bt_ltv_match *compare_data = user_data;
+	uint8_t *bis_v = compare_data->data;
+
+	switch (t) {
+	case BAP_FREQ_LTV_TYPE:
+	{
+		uint16_t mask = *((uint16_t *)v);
+
+		mask = le16_to_cpu(mask);
+		if (mask & (1 << (bis_v[0] - 1)))
+			compare_data->data32 |= 1<<t;
+	}
+	break;
+	case BAP_DURATION_LTV_TYPE:
+		if ((v[0]) & (1 << bis_v[0]))
+			compare_data->data32 |= 1<<t;
+		break;
+	case BAP_FRAME_LEN_LTV_TYPE:
+	{
+		uint16_t min = *((uint16_t *)v);
+		uint16_t max = *((uint16_t *)(&v[2]));
+		uint16_t frame_len = *((uint16_t *)bis_v);
+
+		min = le16_to_cpu(min);
+		max = le16_to_cpu(max);
+		frame_len = le16_to_cpu(frame_len);
+		if ((frame_len >= min) &&
+				(frame_len <= max))
+			compare_data->data32 |= 1<<t;
+	}
+	break;
+	}
+}
+
+static void check_source_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
+					void *user_data)
+{
+	struct bt_ltv_match *local_data = user_data;
+	struct iovec *pac_caps = local_data->data;
+	struct bt_ltv_match compare_data;
+
+	compare_data.data = v;
+
+	/* Search inside local PAC's caps for LTV of type t */
+	util_ltv_foreach(pac_caps->iov_base, pac_caps->iov_len, &t,
+					check_pac_caps_ltv, &compare_data);
+
+	local_data->data32 |= compare_data.data32;
+}
+
+static void bap_sink_check_level3_ltv(size_t i, uint8_t l, uint8_t t,
+		uint8_t *v, void *user_data)
+{
+	struct bt_ltv_extract *merge_data = user_data;
+
+	merge_data->value = v;
+	merge_data->len = l;
+}
+
+static void bap_push_ltv(struct iovec *output, uint8_t l, uint8_t t, void *v)
+{
+	l++;
+	iov_append(output, 1, &l);
+	iov_append(output, 1, &t);
+	iov_append(output, l - 1, v);
+}
+
+static void bap_sink_check_level2_ltv(size_t i, uint8_t l, uint8_t t,
+		uint8_t *v, void *user_data)
+{
+	struct bt_ltv_extract *merge_data = user_data;
+
+	merge_data->value = NULL;
+	util_ltv_foreach(merge_data->src->iov_base,
+			merge_data->src->iov_len,
+			&t,
+			bap_sink_check_level3_ltv, user_data);
+
+	/* If the LTV at level 2 was found at level 3 add the one from level 3,
+	 * otherwise add the one at level 2
+	 */
+	if (merge_data->value)
+		bap_push_ltv(merge_data->result, merge_data->len,
+				t, merge_data->value);
+	else
+		bap_push_ltv(merge_data->result, l, t, v);
+}
+
+static void check_local_pac(void *data, void *user_data)
+{
+#define Codec_Specific_Configuration_Check_Mask (\
+		(1<<BAP_FREQ_LTV_TYPE)|\
+		(1<<BAP_DURATION_LTV_TYPE)|\
+		(1<<BAP_FRAME_LEN_LTV_TYPE))
+	struct bt_ltv_match *compare_data = user_data;
+	struct iovec *bis_data = (struct iovec *)compare_data->data;
+	const struct bt_bap_pac *pac = data;
+
+	/* Keep searching for a matching PAC if one wasn't found
+	 * in previous PAC element
+	 */
+	if (compare_data->found == false) {
+		struct bt_ltv_match bis_compare_data = {
+				.data = pac->data,
+				.data32 = 0, /* LTVs bitmask result */
+				.found = false
+		};
+
+		/* loop each BIS LTV */
+		util_ltv_foreach(bis_data->iov_base, bis_data->iov_len, NULL,
+				check_source_ltv, &bis_compare_data);
+
+		/* We have a match if all selected LTVs have a match */
+		if ((bis_compare_data.data32 &
+			Codec_Specific_Configuration_Check_Mask) ==
+			Codec_Specific_Configuration_Check_Mask)
+			compare_data->found = true;
+	}
+}
+
+static void bap_sink_match_allocation(size_t i, uint8_t l, uint8_t t,
+		uint8_t *v, void *user_data)
+{
+	struct bt_ltv_match *data = user_data;
+	uint32_t location32;
+
+	if (!v)
+		return;
+
+	memcpy(&location32, v, l);
+
+	/* If all the bits in the received bitmask are found in
+	 * the local bitmask then we have a match
+	 */
+	if ((le32_to_cpu(location32) & data->data32) ==
+			le32_to_cpu(location32))
+		data->found = true;
+	else
+		data->found = false;
+}
+
+static bool bap_check_bis(struct bt_bap_db *ldb, struct iovec *bis_data)
+{
+	struct bt_ltv_match compare_data = {};
+
+	/* Check channel allocation against the PACS location.
+	 * If we don't have a location set we can accept any BIS location.
+	 * If the BIS doesn't have a location set we also accept it
+	 */
+	compare_data.found = true;
+
+	if (ldb->pacs->sink_loc_value) {
+		uint8_t type = BAP_CHANNEL_ALLOCATION_LTV_TYPE;
+
+		compare_data.data32 = ldb->pacs->sink_loc_value;
+		util_ltv_foreach(bis_data->iov_base, bis_data->iov_len, &type,
+				bap_sink_match_allocation, &compare_data);
+	}
+
+	/* Check remaining LTVs against the PACs list */
+	if (compare_data.found) {
+		compare_data.data = bis_data;
+		compare_data.found = false;
+		queue_foreach(ldb->broadcast_sinks, check_local_pac,
+				&compare_data);
+	}
+
+	return compare_data.found;
+}
+
+static void bis_to_pac(void *data, void *user_data)
+{
+	struct bt_bap_bis *bis = data;
+	struct bt_bap_subgroup *subgroup = user_data;
+	struct bt_bap_pac *pac_source_bis;
+	struct bt_bap_endpoint *ep;
+	int err = 0;
+	struct bt_bap_pac_qos bis_qos = {0};
+	uint8_t type = 0;
+	struct bt_ltv_extract merge_data = {0};
+
+	merge_data.src = bis->caps;
+	merge_data.result = new0(struct iovec, 1);
+
+	/* Create a Codec Specific Configuration with LTVs at level 2 (subgroup)
+	 * overwritten by LTVs at level 3 (BIS)
+	 */
+	util_ltv_foreach(subgroup->caps->iov_base,
+			subgroup->caps->iov_len,
+			NULL,
+			bap_sink_check_level2_ltv, &merge_data);
+
+	/* Check each BIS Codec Specific Configuration LTVs against our Codec
+	 * Specific Capabilities and if the BIS matches create a PAC with it
+	 */
+	if (bap_check_bis(subgroup->bap->ldb, merge_data.result) == false)
+		goto cleanup;
+
+	DBG(subgroup->bap, "Matching BIS %i", bis->index);
+
+	/* Create a QoS structure based on the received BIS information to
+	 * specify the desired channel for this BIS/PAC
+	 */
+	type = BAP_CHANNEL_ALLOCATION_LTV_TYPE;
+	util_ltv_foreach(merge_data.result->iov_base,
+			merge_data.result->iov_len, &type,
+			bap_sink_get_allocation, &bis_qos.location);
+
+	/* Create a remote PAC */
+	pac_source_bis = bap_pac_new(subgroup->bap->rdb, NULL,
+				BT_BAP_BCAST_SOURCE, &subgroup->codec, &bis_qos,
+				merge_data.result, subgroup->meta);
+
+	err = asprintf(&pac_source_bis->name, "%d", bis->index);
+
+	if (err < 0) {
+		DBG(subgroup->bap, "error in asprintf");
+		goto cleanup;
+	}
+
+	/* Add remote source endpoint */
+	if (!subgroup->bap->rdb->broadcast_sources)
+		subgroup->bap->rdb->broadcast_sources = queue_new();
+	queue_push_tail(subgroup->bap->rdb->broadcast_sources, pac_source_bis);
+
+	queue_foreach(subgroup->bap->pac_cbs, notify_pac_added, pac_source_bis);
+	/* Push remote endpoint with direction sink */
+	ep = bap_endpoint_new_broadcast(subgroup->bap->rdb, BT_BAP_BCAST_SINK);
+
+	if (ep)
+		queue_push_tail(subgroup->bap->remote_eps, ep);
+
+cleanup:
+	util_iov_free(merge_data.result, 1);
+}
+
+/*
+ * Parse each subgroup, check if we can create PACs from its BISes and then
+ * clear the subgroup data.
+ */
+void bt_bap_parse_bis(void *data, void *user_data)
+{
+	struct bt_bap_subgroup *subgroup = data;
+
+	queue_foreach(subgroup->bises, bis_to_pac, subgroup);
+	cleanup_subgroup(subgroup);
+}
diff --git a/src/shared/bap.h b/src/shared/bap.h
index b13fef688da3..aed3bf52b8d9 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -4,7 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2022  Intel Corporation. All rights reserved.
- *  Copyright 2023 NXP
+ *  Copyright 2023-2024 NXP
  *
  */
 
@@ -101,13 +101,13 @@ struct bt_bap_qos {
 struct bt_bap_base {
 	uint32_t pres_delay;
 	uint8_t big_id;
-	uint8_t num_subgroups;
 	uint8_t next_bis_index;
+	uint8_t num_subgroups;
 	struct queue *subgroups;
 };
 
 struct bt_bap_subgroup {
-	uint8_t subgroup_index;
+	uint8_t index;
 	struct bt_bap *bap;
 	uint8_t num_bises;
 	struct bt_bap_codec codec;
@@ -198,6 +198,10 @@ uint16_t bt_bap_pac_get_context(struct bt_bap_pac *pac);
 
 struct bt_bap_pac_qos *bt_bap_pac_get_qos(struct bt_bap_pac *pac);
 
+struct iovec *bt_bap_pac_get_data(struct bt_bap_pac *pac);
+
+struct iovec *bt_bap_pac_get_metadata(struct bt_bap_pac *pac);
+
 uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream);
 
 struct bt_bap_stream *bt_bap_pac_get_stream(struct bt_bap_pac *pac);
@@ -349,4 +353,5 @@ struct iovec *bt_bap_stream_get_base(struct bt_bap_stream *stream);
 
 bool bt_bap_parse_base(struct bt_bap *bap, void *data, size_t len,
 		util_debug_func_t func, struct bt_bap_base *base);
+void bt_bap_parse_bis(void *data, void *user_data);
 
-- 
2.40.1

