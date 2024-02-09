Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2046.outbound.protection.outlook.com [40.107.104.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5331E7BB1B
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Feb 2024 16:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707497201; cv=fail; b=MmdcaKnZV4CBlHuaLqwMvIeCDdVJ4NICJRqsXaFq7S6zCEoAjyA6Kpi2PuHgVkmpMbcCYhDSR57cIlxXAnWy0/raERaS77nfO30FbXuAe1dQSjc1IWPlO+VBvjHLbe6y6uQgPIwsx432EK/EbPw7tg6e2HpXexjP27OOrRP5FiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707497201; c=relaxed/simple;
	bh=+e7tOTpchwwKMNgD+6yTEKru2vJwzWT1SNfz18NCRGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I4YSz2u7PU9KbCxDRTVOHUVvQ3/f2dSckVKJ6x/WNFNlS7yxBg/mmp1KodiC9M5+VidpcnHjiglg6Lcroe9GSlZyPzUz713Vo1vrKaoJbes7mdWcvHK6rbIQc/vFiSqsbAxGWnYXlOMzsaWcqXgW65dO1Nk2C0RhblCOmV7NGqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=j9uvsqkw; arc=fail smtp.client-ip=40.107.104.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="j9uvsqkw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GW+hw6B4hE6abYERtdagJDU3RoBYPE6ZE87s6tWUtrlrpxKlAPu+9OnjizHPqH0kTZyDIg0J0JqZztbyX6//lI7AcPAyDhcbCkIK4Q2ZjQ01xAR1y0XqV9IK068My0T2f+5t7zb48lYOZzv2WCskVL25Et934o484CONEVt0pXNqS45FejQduPvUaMbCp2by9CXYI40smskvZkcvS4iiEvR99bKEMwDhyd+NtZcRG6y0VZ33yyFpdfcWkhcQBS/eyo21qIrydmv2GKudZfQt0nkX/VokLHdEQcmpCH0O6GPiwH6wJTHDP3TL01NZ11E1djEl9g6SMlOrbycf0NCVQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1RkXAC8gdPldq0xPa/OigRjcbqLZvgpk3DedFeLgo0=;
 b=G2HCkxNe67jOKkpmVCaaMgtXXukNB8jWZfqurfmEco7MKvh2/3Pe7A7khE7Fn2EgRQO9gyP3Ua+E50gE0HcfNMyDGU0F+Acu4gpRFJmIAIS604gNH1TQFFIm+EQ36nU649gysJS1YcFTKt5EDb6HcHP8hdK5cwgagoTnQNxC3dB+9tR2DJUrJ8leJD2dNTEl9xFGGvZl4EAa5xUIZremOxVi1ljzJTSA9URjjwHUBcU5wxM96zpPyZiD3JWPxedNR9Hem6z8ZPoXLw8hg7D5AbOTBE9aKgpQeSOPMPsInhGoAlQG2mHhi3GzCcDsv3b5usXbUWFkBPT27SXXIrl4qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1RkXAC8gdPldq0xPa/OigRjcbqLZvgpk3DedFeLgo0=;
 b=j9uvsqkwrj/GwznGmi/OwSOvti3gvkkW2ieEw6ntvsVp279SW21lO9t+hqThtqHGIWNtgdY6xGXUMWW0GodXqaYb7YoG39FJ+UGtu8K7OB6i1MPrD26pry6suEjyQD4HFv9EumpoYCK2DLU8FKqjWV2ScwNcfbvBKZcv4e7uX0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by DB8PR04MB7097.eurprd04.prod.outlook.com (2603:10a6:10:12a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Fri, 9 Feb
 2024 16:46:35 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::bbd0:4409:3f0e:afdd]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::bbd0:4409:3f0e:afdd%4]) with mapi id 15.20.7249.039; Fri, 9 Feb 2024
 16:46:35 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ v2 1/6] shared/bap: Add API to convert BASE into bt_bap_base queue
Date: Fri,  9 Feb 2024 18:46:25 +0200
Message-Id: <20240209164630.92208-2-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240209164630.92208-1-andrei.istodorescu@nxp.com>
References: <20240209164630.92208-1-andrei.istodorescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0002.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::6) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|DB8PR04MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: c386a598-f13b-4bd8-376a-08dc298eada8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2cYO6ymcB/tDn14h4aA0lAOPniO41jSf5hUAnSsKoGiooBAAsnd27TEZMQIJUnPNL6fYltXHnyj1y1OCPPMvI4flqgNi734znoX3OfauGnV5z7wNY9ROhHORGKtgLQakn49hDx60UVfBShx3HU2uocUPuKHh3C7uGaAWv9sbsWqvrlOz9FkVz38WeB0lfcze7FhjbGanlEaZYh0WR8uc/EvXi6zSjG2iYEwCIjbxMBflEmc8WFm6DL6cL5s1SbIodYNOJdHxeZ1o1a4yXIYdy/yO5ojq0OFU6PofxeriQKzC6FlZOzK19fFuo2XD0JFP9JamZMozH1YROPjKGcBLMWfZOQLssrkLr607MKPPsipVjpxGBrjA1SzNA0nxNcMhbgqFzCNLkX9DXbtXCieJUnvAwCbkAeXvSwAbhq3IvmYXG6b1SD1cyyH5m11VwNSOI4F7UxpejkK++7ZvRwrmYyXy29WOqn4S5I6izF9q3Z54MiZfe0G12mSK+eOD8djziK9SY/kYHLwziyNvLDBk/z1Qvv4j+U9/XH5NacM7EjKwS9bVnSM18nnLPJpRa6B9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(4326008)(5660300002)(30864003)(6916009)(66556008)(66946007)(8676002)(66476007)(8936002)(44832011)(2906002)(83380400001)(26005)(36756003)(86362001)(38100700002)(1076003)(6666004)(316002)(478600001)(41300700001)(6486002)(6506007)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h5yqFtqFbw0t4J29pNOnAMDY12tBd9xo8g5o8pu8KTR3xNhGrKQqTy+L0Ue5?=
 =?us-ascii?Q?rguaSS516+WXJPzq+x1HtY9H4GqnwbNmm/t1uNGCktvx9zhoyEScubmXUsDw?=
 =?us-ascii?Q?VOTg1e5CBDNFjbwYWFu8G6f80X7hTeQAvXSQkHXJ0aAG8Ocs8xEjz888sFir?=
 =?us-ascii?Q?wCQ1zTFD7FpaRPUjp87HV8O/xIP7hHZ4c+wQ96ABTAMnhjq8p6T/tvLqerxQ?=
 =?us-ascii?Q?LFD14q8c497yP7Eyq43EVd3uIJOvPiBO9XxGy+H7E9DeSw8SPbeO3KJQgd4b?=
 =?us-ascii?Q?xdeUuwRp+wuehBjGAmBD7u5VBBjPesTvJLVKwgL6xaNTCxu13MSMBiAxMWPX?=
 =?us-ascii?Q?TYhyMBrSKUCZWkDCav2A3z8IXlXXPE+F/2EVfwFmjraSKATDW/V1Ox+9WMRZ?=
 =?us-ascii?Q?gwSk11TiY7G0ORuMl861d3p/EYasE2SV/6igS5KEPrauo9Nnwv9a88LNPBj3?=
 =?us-ascii?Q?MCJdcKSqajzqCzjlf3iJq27aG8JRrHTyIo+mLlrMIf5YjoDBiYKTBCl4m79i?=
 =?us-ascii?Q?wCO+UvRd5npwzvW9d7LGWdND7jIwwNufQcAItNG4qdoVTvJPLjMdpSz/uwXg?=
 =?us-ascii?Q?Yb+q12UYQKwBQa5IXy6We4N4bdkEnr+7zi/ewZfJRGTX/HU8NVL5Itn164dT?=
 =?us-ascii?Q?NNOvqsNWy6/uW1XYW/jGqloH9yGTMq4+6aX/Du78v7wbllxuoP/I8Ky6q3hU?=
 =?us-ascii?Q?5exlUBPbThkEC3pVomHdOLRsH79ETgVC5DCvmPPH22mK04TqhyREdARc3DIt?=
 =?us-ascii?Q?qdWJEP2oNzfuD65DRCfZB3s1qreks4RYHofRC/Xw4VG9NI24542JuaHoqXdX?=
 =?us-ascii?Q?V6lXsvjvU+r7Ms0j8E2ByEQ9aFH1CRW68PvfAvh0exaSyCMs7sip6SsFYCCZ?=
 =?us-ascii?Q?/2dJxvqtR4pfNQk91VY4YUMxIv1HgXeGPucOld85miWvJls6X24nIzjSBg0p?=
 =?us-ascii?Q?pS79ECA+g14Pi7w65Mm2wItrtZrZmkJ/Hs92wueIUGzxm2T4hx6udspfEl0Z?=
 =?us-ascii?Q?+4UBIkBSsoGevRn0gjpvYJFl3/vecWx2s6tFmCtKvxQ4RPDtTgjes/XlKQ/U?=
 =?us-ascii?Q?1W/Ty3n+lDdNMk/BeMv8tDTtkII9f6loQ/oLUuieMtxIw9sM+UNyBpJigCVj?=
 =?us-ascii?Q?zzN3cNwSY4+LBNLnmvgoLytnMzkYWVk1pyPZzj1RFcRMnLhBSYxDmm/IOaQB?=
 =?us-ascii?Q?kfTTjJ6R9cFlFri+UKMrJgqqswOdTmzLYCt0/XJ/QG+6YkrLnLghZ5gpJIJa?=
 =?us-ascii?Q?IBhBMIGK3ytkisEQwQuyfC1IUtNYrUP5cpP7As3c9IGJymhqJy5s/bNn9Ez7?=
 =?us-ascii?Q?d/2xiFMXTSQf+9JxmbesLfaBMcQtpoKQKEmQY8rPgqj/enDX7MJY0Zds8sYR?=
 =?us-ascii?Q?ggET9D3eBvKQ+Ln1OCNCmdapFEdDsvwAwY25rw9+pvbvbdq3zkn0KYIAprTF?=
 =?us-ascii?Q?Ve4GCx9tFHQaWqab2Cd9dVaR0OXpiCudCLAekvTtVhUyxO0Xfk/kyoLy7rH6?=
 =?us-ascii?Q?9xzVx/4FmrK/XHUr5TIpR9V0odrhh1D576sVmjT6FZbgLExnz4TIXc5dRinF?=
 =?us-ascii?Q?I4OQISfBderCLLJ0DanBiQvwYSIRk2FSy2yh/BNfSBgkN9vZdpg2UI2ihHB7?=
 =?us-ascii?Q?9Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c386a598-f13b-4bd8-376a-08dc298eada8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 16:46:35.7060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t7IrKgjEFSpl91VcTD3jY8/fbUhVtroEIyhMDoTSdyYwOCi7chcCQzVQIZrebwloPGPcGO7V/RmzSaXQxlvmo4ZtSGTZwVeeLOWb/gyJ9IE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7097

Create public function to read the BASE bytes and populate a bt_bap_base
structure for further processing.
---
 src/shared/bap.c | 250 ++++++++++++++++++++++++++++++++++++++++-------
 src/shared/bap.h |  27 +++++
 2 files changed, 244 insertions(+), 33 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index e26dbf9440e5..b481e4655c2d 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -282,26 +282,6 @@ struct bt_pacs_context {
 	uint16_t  src;
 } __packed;
 
-struct bt_base {
-	uint8_t big_id;
-	uint32_t pres_delay;
-	uint8_t next_bis_index;
-	struct queue *subgroups;
-};
-
-struct bt_subgroup {
-	uint8_t index;
-	struct bt_bap_codec codec;
-	struct iovec *caps;
-	struct iovec *meta;
-	struct queue *bises;
-};
-
-struct bt_bis {
-	uint8_t index;
-	struct iovec *caps;
-};
-
 /* Contains local bt_bap_db */
 static struct queue *bap_db;
 static struct queue *bap_cbs;
@@ -5765,7 +5745,7 @@ void bt_bap_update_bcast_source(struct bt_bap_pac *pac,
 
 static void destroy_base_bis(void *data)
 {
-	struct bt_bis *bis = data;
+	struct bt_bap_bis *bis = data;
 
 	if (!bis)
 		return;
@@ -5778,7 +5758,7 @@ static void destroy_base_bis(void *data)
 
 static void generate_bis_base(void *data, void *user_data)
 {
-	struct bt_bis *bis = data;
+	struct bt_bap_bis *bis = data;
 	struct iovec *base_iov = user_data;
 	uint8_t cc_length = bis->caps->iov_len;
 
@@ -5795,7 +5775,7 @@ static void generate_bis_base(void *data, void *user_data)
 
 static void generate_subgroup_base(void *data, void *user_data)
 {
-	struct bt_subgroup *sgrp = data;
+	struct bt_bap_subgroup *sgrp = data;
 	struct iovec *base_iov = user_data;
 
 	if (!util_iov_push_u8(base_iov, queue_length(sgrp->bises)))
@@ -5833,7 +5813,7 @@ static void generate_subgroup_base(void *data, void *user_data)
 	queue_foreach(sgrp->bises, generate_bis_base, base_iov);
 }
 
-static struct iovec *generate_base(struct bt_base *base)
+static struct iovec *generate_base(struct bt_bap_base *base)
 {
 	struct iovec *base_iov = new0(struct iovec, 0x1);
 
@@ -5852,10 +5832,10 @@ static struct iovec *generate_base(struct bt_base *base)
 	return base_iov;
 }
 
-static void add_new_bis(struct bt_subgroup *subgroup,
+static void add_new_bis(struct bt_bap_subgroup *subgroup,
 			uint8_t bis_index, struct iovec *caps)
 {
-	struct bt_bis *bis = new0(struct bt_bis, 1);
+	struct bt_bap_bis *bis = new0(struct bt_bap_bis, 1);
 
 	bis->index = bis_index;
 
@@ -5867,12 +5847,12 @@ static void add_new_bis(struct bt_subgroup *subgroup,
 	queue_push_tail(subgroup->bises, bis);
 }
 
-static void add_new_subgroup(struct bt_base *base,
+static void add_new_subgroup(struct bt_bap_base *base,
 			struct bt_bap_stream *stream)
 {
 	struct bt_bap_pac *lpac = stream->lpac;
-	struct bt_subgroup *sgrp = new0(
-				struct bt_subgroup, 1);
+	struct bt_bap_subgroup *sgrp = new0(
+				struct bt_bap_subgroup, 1);
 	uint16_t cid = 0;
 	uint16_t vid = 0;
 
@@ -6013,7 +5993,7 @@ static struct iovec *extract_diff_caps(
 static void set_base_subgroup(void *data, void *user_data)
 {
 	struct bt_bap_stream *stream = data;
-	struct bt_base *base = user_data;
+	struct bt_bap_base *base = user_data;
 	/* BIS specific codec capabilities */
 	struct iovec *bis_caps;
 
@@ -6031,7 +6011,7 @@ static void set_base_subgroup(void *data, void *user_data)
 	} else {
 		/* Verify if a subgroup has the same metadata */
 		const struct queue_entry *entry;
-		struct bt_subgroup *subgroup = NULL;
+		struct bt_bap_subgroup *subgroup = NULL;
 		bool same_meta = false;
 
 		for (entry = queue_get_entries(base->subgroups);
@@ -6065,7 +6045,7 @@ static void set_base_subgroup(void *data, void *user_data)
 
 static void destroy_base_subgroup(void *data)
 {
-	struct bt_subgroup *subgroup = data;
+	struct bt_bap_subgroup *subgroup = data;
 
 	if (!subgroup)
 		return;
@@ -6087,7 +6067,7 @@ static void destroy_base_subgroup(void *data)
  */
 struct iovec *bt_bap_stream_get_base(struct bt_bap_stream *stream)
 {
-	struct bt_base base;
+	struct bt_bap_base base;
 	struct iovec *base_iov;
 
 	base.subgroups = queue_new();
@@ -6106,3 +6086,207 @@ struct iovec *bt_bap_stream_get_base(struct bt_bap_stream *stream)
 
 	return base_iov;
 }
+
+static void cleanup_bis(void *data)
+{
+	struct bt_bap_bis *bis = data;
+
+	if (bis->caps)
+		util_iov_free(bis->caps, 1);
+}
+
+static void cleanup_subgroup(struct bt_bap_subgroup *subgroup)
+{
+	if (!subgroup)
+		return;
+
+	if (subgroup->meta)
+		util_iov_free(subgroup->meta, 1);
+
+	if (subgroup->caps)
+		util_iov_free(subgroup->caps, 1);
+
+	queue_destroy(subgroup->bises, cleanup_bis);
+
+	if (subgroup)
+		free(subgroup);
+}
+
+bool bt_bap_parse_base(struct bt_bap *bap, void *data, size_t len,
+		util_debug_func_t func, struct bt_bap_base *base)
+{
+	uint8_t num_subgroups;
+	uint8_t num_bis;
+
+	struct iovec iov = {
+		.iov_base = data,
+		.iov_len = len,
+	};
+	util_debug(func, NULL, "BASE len %ld", len);
+	if (!base)
+		return false;
+
+	if (!util_iov_pull_le24(&iov, &base->pres_delay))
+		return false;
+	util_debug(func, NULL, "PresentationDelay %d", base->pres_delay);
+
+	if (!util_iov_pull_u8(&iov, &base->num_subgroups))
+		return false;
+	util_debug(func, NULL, "NumSubgroups %d", base->num_subgroups);
+	num_subgroups = base->num_subgroups;
+
+	for (int sg = 0; sg < num_subgroups; sg++) {
+		struct bt_bap_subgroup *sub_group = new0(
+						struct bt_bap_subgroup, 1);
+		uint8_t caps_len, metaLen;
+		uint8_t *hexstream;
+
+		sub_group->subgroup_index = sg;
+
+		util_debug(func, NULL, "Subgroup #%d", sg);
+		sub_group->bap = bap;
+		sub_group->bises = queue_new();
+
+		if (!util_iov_pull_u8(&iov, &num_bis)) {
+			cleanup_subgroup(sub_group);
+			goto fail;
+		}
+		util_debug(func, NULL, "NumBis %d", num_bis);
+		sub_group->num_bises = num_bis;
+
+		memcpy(&sub_group->codec, util_iov_pull_mem(&iov,
+		sizeof(struct bt_bap_codec)), sizeof(struct bt_bap_codec));
+		util_debug(func, NULL, "%s: ID %d CID 0x%2.2x VID 0x%2.2x",
+			"Codec", sub_group->codec.id, sub_group->codec.cid,
+				sub_group->codec.vid);
+		if (!util_iov_pull_u8(&iov, &caps_len)) {
+			cleanup_subgroup(sub_group);
+			goto fail;
+		}
+
+		util_debug(func, NULL, "CC Len %d", caps_len);
+
+		/*
+		 * Copy the Codec Specific configurations from base
+		 */
+		sub_group->caps = new0(struct iovec, 1);
+		util_iov_memcpy(sub_group->caps, iov.iov_base, caps_len);
+		util_debug(func, NULL, "subgroup caps len %ld",
+				sub_group->caps->iov_len);
+
+		for (int i = 0; caps_len > 1; i++) {
+			struct bt_ltv *ltv = util_iov_pull_mem(&iov,
+								sizeof(*ltv));
+			uint8_t *caps;
+
+			if (!ltv) {
+				util_debug(func, NULL, "Unable to parse %s",
+							"Capabilities");
+				cleanup_subgroup(sub_group);
+				goto fail;
+			}
+
+			util_debug(func, NULL, "%s #%u: len %u type %u",
+						"CC", i, ltv->len, ltv->type);
+
+			caps = util_iov_pull_mem(&iov, ltv->len - 1);
+			if (!caps) {
+				util_debug(func, NULL, "Unable to parse %s",
+									"CC");
+				cleanup_subgroup(sub_group);
+				goto fail;
+			}
+			util_hexdump(' ', caps, ltv->len - 1, func, NULL);
+
+			caps_len -= (ltv->len + 1);
+		}
+
+		if (!util_iov_pull_u8(&iov, &metaLen)) {
+			cleanup_subgroup(sub_group);
+			goto fail;
+		}
+		util_debug(func, NULL, "Metadata Len %d", metaLen);
+
+		sub_group->meta = new0(struct iovec, 1);
+		sub_group->meta->iov_len = metaLen;
+		sub_group->meta->iov_base = iov.iov_base;
+
+		hexstream = util_iov_pull_mem(&iov, metaLen);
+		if (!hexstream) {
+			cleanup_subgroup(sub_group);
+			goto fail;
+		}
+		util_hexdump(' ', hexstream, metaLen, func, NULL);
+
+		for (int bis_sg = 0; bis_sg < sub_group->num_bises; bis_sg++) {
+			struct bt_bap_bis *bis;
+			uint8_t caps_len;
+			uint8_t crt_bis;
+
+			if (!util_iov_pull_u8(&iov, &crt_bis)) {
+				cleanup_subgroup(sub_group);
+				goto fail;
+			}
+			util_debug(func, NULL, "BIS #%d", crt_bis);
+
+			bis = new0(struct bt_bap_bis, 1);
+			bis->index = crt_bis;
+
+			if (!util_iov_pull_u8(&iov, &caps_len)) {
+				cleanup_subgroup(sub_group);
+				goto fail;
+			}
+			util_debug(func, NULL, "CC Len %d", caps_len);
+
+			bis->caps = new0(struct iovec, 1);
+			bis->caps->iov_len = caps_len;
+			util_iov_memcpy(bis->caps, iov.iov_base, caps_len);
+			util_debug(func, NULL, "bis caps len %ld",
+					bis->caps->iov_len);
+
+			for (int i = 0; caps_len > 1; i++) {
+				struct bt_ltv *ltv = util_iov_pull_mem(&iov,
+								sizeof(*ltv));
+				uint8_t *caps;
+
+				if (!ltv) {
+					util_debug(func, NULL, "Unable to parse %s",
+								"Capabilities");
+					cleanup_subgroup(sub_group);
+					goto fail;
+				}
+
+				util_debug(func, NULL, "%s #%u: len %u type %u",
+						"CC", i, ltv->len, ltv->type);
+
+				caps = util_iov_pull_mem(&iov, ltv->len - 1);
+				if (!caps) {
+					util_debug(func, NULL,
+						"Unable to parse %s", "CC");
+					cleanup_subgroup(sub_group);
+					goto fail;
+				}
+				util_hexdump(' ', caps, ltv->len - 1, func,
+									NULL);
+
+				caps_len -= (ltv->len + 1);
+			}
+
+			queue_push_tail(sub_group->bises, bis);
+		}
+
+		queue_push_tail(base->subgroups, sub_group);
+	}
+	return true;
+
+fail:
+	while (!queue_isempty(base->subgroups)) {
+		struct bt_bap_subgroup *subGroup =
+				queue_peek_head(base->subgroups);
+		cleanup_subgroup(subGroup);
+		base->num_subgroups--;
+	}
+	util_debug(func, NULL, "Unable to parse %s", "Base");
+
+	return false;
+}
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 2c3550921f07..b13fef688da3 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -98,6 +98,29 @@ struct bt_bap_qos {
 	};
 };
 
+struct bt_bap_base {
+	uint32_t pres_delay;
+	uint8_t big_id;
+	uint8_t num_subgroups;
+	uint8_t next_bis_index;
+	struct queue *subgroups;
+};
+
+struct bt_bap_subgroup {
+	uint8_t subgroup_index;
+	struct bt_bap *bap;
+	uint8_t num_bises;
+	struct bt_bap_codec codec;
+	struct iovec *caps;
+	struct iovec *meta;
+	struct queue *bises;
+};
+
+struct bt_bap_bis {
+	uint8_t index;
+	struct iovec *caps;
+};
+
 typedef void (*bt_bap_ready_func_t)(struct bt_bap *bap, void *user_data);
 typedef void (*bt_bap_destroy_func_t)(void *user_data);
 typedef void (*bt_bap_debug_func_t)(const char *str, void *user_data);
@@ -323,3 +346,7 @@ void bt_bap_update_bcast_source(struct bt_bap_pac *pac,
 bool bt_bap_pac_bcast_is_local(struct bt_bap *bap, struct bt_bap_pac *pac);
 
 struct iovec *bt_bap_stream_get_base(struct bt_bap_stream *stream);
+
+bool bt_bap_parse_base(struct bt_bap *bap, void *data, size_t len,
+		util_debug_func_t func, struct bt_bap_base *base);
+
-- 
2.40.1

