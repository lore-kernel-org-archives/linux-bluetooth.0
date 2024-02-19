Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2A82D05D
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Feb 2024 12:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708344924; cv=fail; b=INBXKCqqie/0sl5RQi3GV2O2CEPxVdOeBD8L9b/ZNupBBXwet71bNjY4l6+2V8BAxvKIrZ+wcVK+MVVZ6MgptWnH8jGopoTFWtxy3fk0Bwu68iioV9wIqfjvf31ApnQhskyP/x0Eja0lAuOKi7SW2QY8JNW4o2FfsmafBSuk2yM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708344924; c=relaxed/simple;
	bh=agQ2ziC2vfXf8irGj/zSeo9cWOKzQYf8M/krdZst8jc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uEfUDBIRiQD8C5LPNaXKbZVZ4JHpCU/EbfZ2yB2iAUhVyg3nMriWOqmABhx/cTTGq5OmkKy1gGBdl9M+Crw2D6Jyk9jZZY8+KyeotLGz5swGLV8lMCjFNBG8ZqCC+EK7KCHiKHuZ4PBYEyJY70U4rpVddpb6MrXB80elfI+xiy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=l50ET57d; arc=fail smtp.client-ip=40.107.20.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="l50ET57d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Atmafpb2wyAxFeBUCOMHKG7iNsgEvOX5KV1k5Zen8D/XtlsYRO+dBkj1c97yedFOKqqRXnTHcZnVCJCmv7po04Y7QbQ77kJre88N/LHe54zZyd/MtbwbVondat6mi3xRuchguQ7GVV06DcuMrVDu8g6T771xALkmfM8EwQpL5PQoUpzFQbLxKWj7/9jD/nAANjNTW7am0krCMcgzGsV3XwrD5e828BW0IsdAkdlIoETW5oK3+NMzhB1puQK3+f+1P4MPXZdMoKHfXlrZYICEm5pQ60hiJa9GAFkK44r7jeYvAfxX1YO99lwfV47nozo00UbR13cfY8d8mRAAtqtFXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lg++FzvjYN1134bTWbPZUK6VU8jHRQzAairVUbtJTvc=;
 b=VDltAIcMjhWxY0PsePF/r827blyB9v9QQhPfMlMABNEuNjFvQ+cH120QjmeKJ7yPjuWPFf2yZmMq8TkeZrECJ6eNhTZzraSlGehSzbPZWcAKBk0bWUNNiChq2ZQz/4T+psQ1z2EzguS5tkQrUqtvL90NrsH2p7iNn66H/iyFUk01EG4QH11nLVc7X3lizeZeIDQGGrEFzqIcqDX4J0/rKmRG8tdbCyX7ooLxH/5/6sAo5D68hrMmF+ENqjBonOSf4FF4KFwL9ZufF/9Xk4O5CdlzcWxcC845PPnMPgZTssrq0LgSJw1RRutYgdeL4vn8bRsRU0/WTUL0p+5nx9FB5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lg++FzvjYN1134bTWbPZUK6VU8jHRQzAairVUbtJTvc=;
 b=l50ET57dqcpe/UtMNGsmMbSuVyqRuTU2Hx4Ktgc/Awva9Po2RN2LOclpREEcKm/ERN/AM/YUiPVse7GA7fF57tg2sJph56+39TA31bmhrVmyhuqRFjMX2CeYkp27EZ8a1lgBQIADn8nUSqj2t/ZG4S/lX94qQSrKS4h/27iq3aQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by AS8PR04MB9141.eurprd04.prod.outlook.com (2603:10a6:20b:448::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.37; Mon, 19 Feb
 2024 12:15:17 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::bbd0:4409:3f0e:afdd]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::bbd0:4409:3f0e:afdd%4]) with mapi id 15.20.7292.029; Mon, 19 Feb 2024
 12:15:17 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ v3 2/4] shared/bap: Add API to convert parsed BASE into pac data
Date: Mon, 19 Feb 2024 14:15:07 +0200
Message-Id: <20240219121509.5702-3-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240219121509.5702-1-andrei.istodorescu@nxp.com>
References: <20240219121509.5702-1-andrei.istodorescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR07CA0025.eurprd07.prod.outlook.com
 (2603:10a6:205:1::38) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|AS8PR04MB9141:EE_
X-MS-Office365-Filtering-Correlation-Id: 94ab2a04-1d54-41ab-c206-08dc31446f1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ggHxbU55PfCYJFQJC2XB7DkTGHc/Nw1+8TpV/ANiPXuczSQQahIWfaG5NMHB59nyK0N7pz9YM+pyqsojrRftcauzN+W8QDHUAPKISNXNLj7Teafx5cs2dYQtwbgWtHZ3OHe46itDdbo9mDmJmnOdEwbWoaaXW8dgOQrzdy6mO226AcQfCze0fmTtSpNVbjWLoBiaLL/+VEvxLt5nK/0wc7MykHo+TvSRu8GAiWWLRMTtH+D0GR8L+mEAm0KNXbZNKdeJzYuqq0C4PNpJ2cmj6v3kwGtti+fkJoKsP4pDMtN2j+AYjgDKpHWRUh7IPB5PCGR6sZrbu+RjYmyssk3JtmgIEDOId7UGs1pXuOSrdV2KwO1TH3PzSKvTZ+1EKJyJXxgCcvLdB9VYXzFIPqTB+GNd4dXQZMT/gJfNnBZqRN3K4eh8zbotVxzVuJZ4JxRdc18zoxBBnj8EbXZ/sN8NofK2A5Kg7DL8+arroT9K3VlQjzwqjy0eyX5eeDlhji/mrek+Cq9qyb2t32YdRre/G/YAe5bcMDnalGQ7nBoS9rQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5e9/6Fq21sKNzbWHKnZTbkQdlkSW+Wx2lfj62pNrHso/txaLPSFIjchsHQSY?=
 =?us-ascii?Q?hVUTg8Jms17o0tIkQXtnrNyrEOikhtoungHy/KkkRQs4YYdFR/NKSDJUCkXi?=
 =?us-ascii?Q?KmO+zdui+aEcGUhmSvz6+e/PfqfBQK3Y8sX4JTAc2VQ1auPCY8yWjCsPlnWz?=
 =?us-ascii?Q?Hynh50ZPXtC445HYpodaj38bOViZcmiSmteUGRplv7jJoLUt26x7MioVUDO5?=
 =?us-ascii?Q?3yoaJMpwkzQkRULZK4+Ezet/ale2C1Knl3CRHb5EZzlGHvWhglGHFTFm7ivo?=
 =?us-ascii?Q?Jo2ZmO258tEVBlMSJUlF3apAzSjaB7U2G9FS78vJcFxxEACXRPsTMs8lKoor?=
 =?us-ascii?Q?qVleisqFBaMho5DsOa2nDw3FkvGkw05//s3O932vDPQArCspGCnCCAyeqC0m?=
 =?us-ascii?Q?/6pzOWJZAUQp4a3E5usQxrC5Vh/Nrq6FiN1L492Q7mKXJbOI9FcfkjD9hIP8?=
 =?us-ascii?Q?AvVonsLV0DuvPlYjjUma7pEb0Ro4XghD/SQH8+27k3JkOuMe30jMw0zHA4uX?=
 =?us-ascii?Q?eJRONS2ekz7Pttt3YVgWXv0A+/E9JRqTSh4b+9EGfA+1OBW0mYfiujer8gpW?=
 =?us-ascii?Q?wbOupV9wsRuzSekwxBqyU4qsG7zocJH2HWZV6BCAQwVfuo9hUerkLtutXOr0?=
 =?us-ascii?Q?2jpr/k+1p7DShikd2YDiNn5QwIu5YUtMM/VtodN+KPLhfhmTEO7ne7XU9/dy?=
 =?us-ascii?Q?t+dy7tNeECy1mA706CxMaQEWI9DZ/S0E2XPPp9xBKBGy4qcSvxTWu/Wa5a/o?=
 =?us-ascii?Q?Ykq9guG1IcKYJS1i/1xemLB/OzZatl676rcgHMmZTRW6yGobPnTc1OtiKIkc?=
 =?us-ascii?Q?FkY08+BXfaKdWTqdQ/3DGP+FTuoiD2VZ0vLuJpLgFTSg0rkXXGifBOwXAGy6?=
 =?us-ascii?Q?DZO966wKiJmlIdoSE5lnNdapOC5Tskl1v1/F7FqWMCyNHDDhAHmCecVVfqlm?=
 =?us-ascii?Q?SRP7FV6o+FIT3MlREp/RZxCSDb0JHFcd/JF9MMMdItWXmlDtDvV12f+igcAt?=
 =?us-ascii?Q?AKuTdTtgWxkLAlOn4Uk2IrFTLSVhVknRL4yrtakcZxRUvz9poExejsZrxpDm?=
 =?us-ascii?Q?tw4atc7YMTj+a2+E4kGI1pDIEQFO5VqivfTpczQt8i2LZwUPFo6e4P57IGOP?=
 =?us-ascii?Q?UGZbDLPi7rj9im3m7ttXbnp2SQzxuxhfsS+AfWJ93UzsAE7Bnjhliw+1BuAy?=
 =?us-ascii?Q?SVxJURSwmCbjk93h6GiXIYSxU43g0D4A+s4c6s7rntAFD63wajci1j3aGBvx?=
 =?us-ascii?Q?YgiLBM3UlQfaNdVr27YAP8gyhSVuc0Vb4w/9/fIEMJfuuLLdOr4du6HCdoA9?=
 =?us-ascii?Q?vfKRX3lCgkWEFnXCOUtkKoiZJFkqAox4VXaukiSg372a9ZDZZwBoJ0PEFCmA?=
 =?us-ascii?Q?qnwpf1X1L5Bjt1yqj2fi4LZgYGYy3UwIdxwrm6XmniU2HlUMT9MeNw/m7eBO?=
 =?us-ascii?Q?TC/7Y+8FE5yVVfQDt6Ffzbnj69w1JE2OndrG2dkdy64qlnKn5H5+/bl0cEJJ?=
 =?us-ascii?Q?R7str8DxvOK4exT6KqWHf9oeZkVmc8lj2BvZKk/m0uwy/lyxbJA/og+XRk7c?=
 =?us-ascii?Q?TpbS7KNbQQ23PpL7bFhBp6g6bgwWeBgyavYEg02Grqx//b44h2YgXVvw4Wgn?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ab2a04-1d54-41ab-c206-08dc31446f1a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 12:15:17.3131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KXA68mpjmoEkEh0DJlQYW9G7mddgeyBF4+tCk6TJ2ty57qaS8gYzFr8CK/Jq+zJ4ng+Lt7YnxNULxdMY5YsrtQz9X3YiQGafLIPScCykhic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9141

Create one remote endpoint for each BIS present in the BASE which matches
the local sink capabilities. Add API to get the PAC metadata and
capabilities.
---
 src/shared/bap.c | 497 ++++++++++++++++++++++++++++++++++-------------
 src/shared/bap.h |  11 +-
 2 files changed, 375 insertions(+), 133 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index f688e1ad53fb..c3d96c08fddc 100644
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

