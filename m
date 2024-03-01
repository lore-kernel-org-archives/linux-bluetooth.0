Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2075.outbound.protection.outlook.com [40.107.6.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A5A3AC01
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Mar 2024 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709305253; cv=fail; b=fWX3xzkUKERut2v+DzR5ojV/NF0Lzy+FhOCFw0IyJs7YkNj26t5dVuYPDepAfNp5Jw63Ccm8cFbaLzKPWGKIOuL132jADXIXaNCKuhk/+U37zH3Eton7S+Te+KlTePzX8wM18wsxmH4Kwf1Z3zRTgMu/xt4lUARk8Amp0iWWI8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709305253; c=relaxed/simple;
	bh=vIJr5CKY13VoHZl/OpCexULoDfA2jYB2X4mAsGWKzpg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aIJQodS/dHxn2+CQlYI2S/p2t/bi5HMnFGw512CflaLNl6avVa9dXLrl/q2TRc8iFZcI7tA9fe4YHQ5upkHb9FwWfLH7Pw6xnw0BlKGEP/Jmvq48IaIrY4AHN9jHsdZODjIzC7XyiPBUdfgn/rx+ez/LgKD93NB0pNbxm2ySXwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=OnaVlArC; arc=fail smtp.client-ip=40.107.6.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OnaVlArC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+smavjGocfgvn1KVQqKFrXp206kRFcmXH24GJ1qTJ3qW13EsIdxGpZT+ChOhOPb35fu1In9uhiJGppK7SisvWFBAJ+w9UP70Ql8upAdc2BBsMOuz9ZAvzDmR0DKNiln7EST/+xeFjjSyONo+avklLzEuWglIh4kYoC371MgMAfrhnl8MIJ1A2lxeWWjwLz3D1Mfp/pSZ6g5fIN5tprd6vMYXX8AMX5QQbbQVPPL2F35qZey/aVZ0P/b/2IButXLjeLO0L+2XisvSPsne3nibQdOkSYHTs1oVAQhICPBugCwsAiE7LOMjv2wC2cG+tlW8cCtLqK8N1SCB0PgeRSM+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+QpdgqtOfBafrKzBGYOFi15cM1PwupcACoQ6fGvIX8=;
 b=edDMaczOdiZ/wAs8drcznFaLkMO5aEdoQk18CLZa+D2PH46xhMuZEXOmoI2nkgAmHTUIlGyIg1yZ2kIhXQ0ElZUntXviCFO930MdjS0jbaoatx/PyYxCExQsz29m/Mq2sjIDqLtu0DHsVpZ4ENyLYb2y0APMlXdUGqc2OGsF0bEeMT/PI4Gw1D37qTXolLPspafdu7BEl0kvT8fbne/4A0AsxJ5mRICJsW7/zPinujM1890OGnRVIxqGvaTg+Yx1koxlou4V1x8A45SgTAuT1bN+pSAmbdygk90s0T3NpjXvvalkj75AhSI/7s3x6EseJ8IZzIqgh/7woWNrpE1UMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+QpdgqtOfBafrKzBGYOFi15cM1PwupcACoQ6fGvIX8=;
 b=OnaVlArC+u41Yowt1TyizNw9BmPAwF+xLEKlzEFB09qhpMeBLX7b6KcdBRPqlCLZBuMiFQ421hzFJ6GdBuTed1/EF25OgD0EE+wW8JgVuu3iwHE6E2cBx1MCjVjoBJ4ZDMU1wb4p5+9sfnybUoXrnWEQAXcfnKlxLEmobFltODg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by PAWPR04MB9837.eurprd04.prod.outlook.com (2603:10a6:102:385::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 15:00:45 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::83af:c10f:9f30:43f]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::83af:c10f:9f30:43f%6]) with mapi id 15.20.7316.039; Fri, 1 Mar 2024
 15:00:45 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ v5 5/6] shared/bap: Add API to add an observed BIS
Date: Fri,  1 Mar 2024 17:00:28 +0200
Message-Id: <20240301150029.14386-6-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240301150029.14386-1-andrei.istodorescu@nxp.com>
References: <20240301150029.14386-1-andrei.istodorescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0155.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::22) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|PAWPR04MB9837:EE_
X-MS-Office365-Filtering-Correlation-Id: cdbcf355-a3a9-4b97-69f4-08dc3a005f34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+jOq25CnrMG6E2c2RIuEVnHsbFas9kQnO9wPbukKRYwzOdzZXXnTNLSXG4qz1bvNyEOkOj7Sy3eb1hMHI1Qyarp6nOc13ZZknEyeRtD/hANJMQa6DKYq22VbIn7C+U5wKHhffCMCSCaulSkuqXTnd6YvYyrCKqVrRd9qPPVvy0b+8gmzmJifm0QyrAWDx7BcX38eyc5QjSuASe3mq8G2stZOo76cVHENNRtf9T2RstPBxGRoLrUlkdbB7RJ5KO5LNQZo31urxKzvJMpl4MwdYt7uhETY7j8ZkbO1At6X0ebDvu0CjsjID0ItNQ91FaxUb6LO1FJkpbu5IIXeiK9aadVXOFpo3pMBfrIuGkN2TF4H2BAfK8AYwSIKqazxv/A7A/QYQBFAov0u9ZlLODMBr/MIYnK4aP0DaCNUw+0ruNQp+Eh+hOH0lLFcX9g3Q5Jx8ebGPK+h4JmnP59yYlF/pOSYj3+nDadF0ywDwxmbTg1YQeoAReFfWZd5sGU8kHzcYgufpzth6cJ7Rp6p/+rJgF1ardkpKRGuPhRAaesHrq5+FAC2hKCjCISSqLwo3anN3GRKOWQ1TUMjfEiVKChNxkaCOrKg90f/RWmgKcgOpCDKmKStagZpCD+dYFISiwZe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?86f8JAv+sdC7DchgtK7PdcqVa8HDgtjhQ9h9cGslyeyQ8Z5WiqV9Kgwv9Pr1?=
 =?us-ascii?Q?emAIzN3pupjsW7GJeLtiZPjBfYWosUMOqFX91b8Q2ToHlvsarOKzwbxzMXqa?=
 =?us-ascii?Q?E9wNlOx8y8XJxGRrzomBnIM9Msmd4Vb27K0Tav2E+W67YEh2ciCQBAkoqFJ5?=
 =?us-ascii?Q?DbeJwnTz2I+F0x9tPzp/myhVzkhS+KzeSGI97sFYK/h46CtXq0YyL34QqzUC?=
 =?us-ascii?Q?MOSHrsz1Xk02Mfnk+C0TvQ1hPCwSjJlSP2Ys6DgrDXupf+fQFVubAEuTVD3n?=
 =?us-ascii?Q?x5+bRAkmaCXU0j+YwsJlVxKM/v3jJ4AicSgvy8R6r5L2I8eILm+cY0nx8IOK?=
 =?us-ascii?Q?w/96rBoMozAlzKqkYT1fEbhc+iFOzJrZ3p1nUEluzcTu4w8ANsdfL7W/mkSf?=
 =?us-ascii?Q?/Zc1nCPVmFzlM0K1BDOPUh08wkFftaGu7pHlZhhtyzBUVD4rMuL/JCVr4TBd?=
 =?us-ascii?Q?S7BrkFDeUxZ4fxod81OFjmkuJ5igYaI0aD5iBUIj/gG1czi82aDV4JA37XZD?=
 =?us-ascii?Q?QIO2n519Yu0JCfu+DCLs/uKAMgaAWFo5z+2qO53u05uGZO2tImNAczaeg6xe?=
 =?us-ascii?Q?i/z87b/7T7fbMW+M5kIrQgTDhhg06f+w+UzbQZghmsZvT79d2r2kO+8Kqvjt?=
 =?us-ascii?Q?gsEGgdYHn4wrBh2YNG86Afq/mIR1YLI9unJogeCOizYL8getvx1ceX4amU0C?=
 =?us-ascii?Q?J2BjyeYqR7moY5+NhAUsHp+UPPTabnrkEVEFRDlg2fJzFgD2XkyI2k1qRw0F?=
 =?us-ascii?Q?D1TwWXfIUbA2fi2SMnXDWnrqA44YAdb1YFuHeVDq7SXu07LZRM/GlGdDvIvz?=
 =?us-ascii?Q?/sNAGX9hlw1SWnHsB1+PEyuyWZtfa5yZmNjmJrtZ/P3UMzx9YAYhqIHhanf7?=
 =?us-ascii?Q?QbGIeEDZOjXEWkWOXgz9fhrfEWQ+I5cLb9KY8CMvl2sTfIjwUJ/HiaABVXmE?=
 =?us-ascii?Q?XnH3SyjaCgV4EDLkeU91YYIcDR+48IFEmCgZ0F4v2G4dYGIyDJiy9YGoZQQi?=
 =?us-ascii?Q?Va4+PA2mLb9QhReTDuI26D5TwCiVLCkAmXR9MPc8ToNkqohk2KDXQt7nU6up?=
 =?us-ascii?Q?ZJH9gldE7clFhQgAaVL/oT+c5nJCZAahbah8miR4RipRL547xD8Anb6RGIUs?=
 =?us-ascii?Q?qRTGbRVWWgUmL7vjTKOmrRHHtq8KHdVR5G7h04PP3SvqBh4aJwPT2uiCvvsj?=
 =?us-ascii?Q?+9nKVVdVpcZLHTYsXmDaWManN7WDIxgiDt+kh49bcxo5+zfW/EyoD3P3oKyw?=
 =?us-ascii?Q?fxhrHPDUbV3zgXent/VnXGpuNrT//P7fXAjt4AoTFzKS4FQq4pEY/aOq5RHM?=
 =?us-ascii?Q?3P02Kiu6nByK2bKysJ6t34kKW/bag4CYVOrtuxEr1Hb/Hm/iGUPzN/AB6Bvc?=
 =?us-ascii?Q?pE16DoH5qEPQBQshgQZhgjtIAzgGtiv2VFGhXbMVQZcXk/RXytkDwty8bmRC?=
 =?us-ascii?Q?uMeTlF8CGSqu9OhRA+irpOsuUF1MEYMqYXsH1bikyjaM1dA46m4va118zwg7?=
 =?us-ascii?Q?eUj5P46ZzQUd+kVUFWBSTk2xCX0sxSVwB1addtWxtakZcoQZoqRioMGcmLnk?=
 =?us-ascii?Q?WlDFK46uVFTb94FK2AOnm+VgPxEI5t8KZ3lTT2wbNUTzo14OX7Gc+oi+PLUf?=
 =?us-ascii?Q?bQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdbcf355-a3a9-4b97-69f4-08dc3a005f34
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 15:00:45.3223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SdmC/w1qAsF3LRWFnVY7dUpIdHkb00+ONg5KrbRJuvVcHjd7Qw329qNkxsChSa3oDSBM1WSk6IGCZQx2/Wbd8e5FNYpuJnUWQqufzL84sHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9837

Add API to add a PAC for each observed BIS that is supported by the
local PACS data.
Each BIS observed capabilities LTV is compared to the local capabilities
and when we have a full LTVs match a PAC record is created for that BIS.
Also a MediaEndpoint is registered over DBUS and the stream can be
enabled using the SetConfiguration DBUS call.
---
 src/shared/bap.c | 266 ++++++++++++++++++++++++++++++++++++++++++++++-
 src/shared/bap.h |   7 ++
 2 files changed, 268 insertions(+), 5 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 50d03456e6cd..b84760da4510 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -48,6 +48,15 @@
 
 #define BAP_PROCESS_TIMEOUT 10
 
+#define BAP_FREQ_LTV_TYPE 1
+#define BAP_DURATION_LTV_TYPE 2
+#define BAP_CHANNEL_ALLOCATION_LTV_TYPE 3
+#define BAP_FRAME_LEN_LTV_TYPE 4
+#define CODEC_SPECIFIC_CONFIGURATION_MASK (\
+		(1<<BAP_FREQ_LTV_TYPE)|\
+		(1<<BAP_DURATION_LTV_TYPE)|\
+		(1<<BAP_FRAME_LEN_LTV_TYPE))
+
 struct bt_bap_pac_changed {
 	unsigned int id;
 	bt_bap_pac_func_t added;
@@ -6002,8 +6011,9 @@ static void add_new_subgroup(struct bt_base *base,
 
 struct bt_ltv_match {
 	uint8_t l;
-	uint8_t *v;
+	void *data;
 	bool found;
+	uint32_t data32;
 };
 
 struct bt_ltv_search {
@@ -6022,7 +6032,7 @@ static void match_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
 	if (ltv_match->l != l)
 		return;
 
-	if (!memcmp(v, ltv_match->v, l))
+	if (!memcmp(v, ltv_match->data, l))
 		ltv_match->found = true;
 }
 
@@ -6034,7 +6044,7 @@ static void search_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
 
 	ltv_match.found = false;
 	ltv_match.l = l;
-	ltv_match.v = v;
+	ltv_match.data = v;
 
 	util_ltv_foreach(ltv_search->iov->iov_base,
 			ltv_search->iov->iov_len, &t,
@@ -6075,8 +6085,10 @@ static bool compare_ltv(struct iovec *iov1,
 }
 
 struct bt_ltv_extract {
-	struct iovec *result;
 	struct iovec *src;
+	void *value;
+	uint8_t len;
+	struct iovec *result;
 };
 
 static void extract_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
@@ -6088,7 +6100,7 @@ static void extract_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
 
 	ltv_match.found = false;
 	ltv_match.l = l;
-	ltv_match.v = v;
+	ltv_match.data = v;
 
 	/* Search each BIS caps ltv in subgroup caps
 	 * to extract the one that are BIS specific
@@ -6221,3 +6233,247 @@ struct iovec *bt_bap_stream_get_base(struct bt_bap_stream *stream)
 
 	return base_iov;
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
+	uint16_t mask;
+	uint16_t min;
+	uint16_t max;
+	uint16_t frame_len;
+
+	switch (t) {
+	case BAP_FREQ_LTV_TYPE:
+		mask = *((uint16_t *)v);
+		mask = le16_to_cpu(mask);
+		if (mask & (1 << (bis_v[0] - 1)))
+			compare_data->data32 |= 1<<t;
+		break;
+	case BAP_DURATION_LTV_TYPE:
+		if ((v[0]) & (1 << bis_v[0]))
+			compare_data->data32 |= 1<<t;
+		break;
+	case BAP_FRAME_LEN_LTV_TYPE:
+		min = *((uint16_t *)v);
+		max = *((uint16_t *)(&v[2]));
+		frame_len = *((uint16_t *)bis_v);
+		min = le16_to_cpu(min);
+		max = le16_to_cpu(max);
+		frame_len = le16_to_cpu(frame_len);
+		if ((frame_len >= min) &&
+				(frame_len <= max))
+			compare_data->data32 |= 1<<t;
+		break;
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
+static void bap_sink_check_level2_ltv(size_t i, uint8_t l, uint8_t t,
+		uint8_t *v, void *user_data)
+{
+	struct bt_ltv_extract *merge_data = user_data;
+
+	merge_data->value = NULL;
+	util_ltv_foreach(merge_data->src->iov_base,
+			merge_data->src->iov_len,
+			&t,
+			bap_sink_check_level3_ltv, merge_data);
+
+	/* If the LTV at level 2 was found at level 3 add the one from level 3,
+	 * otherwise add the one at level 2
+	 */
+	if (merge_data->value)
+		util_ltv_push(merge_data->result, merge_data->len,
+				t, merge_data->value);
+	else
+		util_ltv_push(merge_data->result, l, t, v);
+}
+
+static void check_local_pac(void *data, void *user_data)
+{
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
+			CODEC_SPECIFIC_CONFIGURATION_MASK) ==
+			CODEC_SPECIFIC_CONFIGURATION_MASK)
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
+	location32 = le32_to_cpu(location32);
+
+	/* If all the bits in the received bitmask are found in
+	 * the local bitmask then we have a match
+	 */
+	if ((location32 & data->data32) == location32)
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
+void bt_bap_add_bis(struct bt_bap *bap, uint8_t bis_index,
+		struct bt_bap_codec *codec,
+		struct iovec *l2_caps,
+		struct iovec *l3_caps,
+		struct iovec *meta)
+{
+	struct bt_bap_pac *pac_source_bis;
+	struct bt_bap_endpoint *ep;
+	int err = 0;
+	struct bt_bap_pac_qos bis_qos = {0};
+	uint8_t type = 0;
+	struct bt_ltv_extract merge_data = {0};
+
+	merge_data.src = l3_caps;
+	merge_data.result = new0(struct iovec, 1);
+
+	/* Create a Codec Specific Configuration with LTVs at level 2 (subgroup)
+	 * overwritten by LTVs at level 3 (BIS)
+	 */
+	util_ltv_foreach(l2_caps->iov_base,
+			l2_caps->iov_len,
+			NULL,
+			bap_sink_check_level2_ltv, &merge_data);
+
+	/* Check each BIS Codec Specific Configuration LTVs against our Codec
+	 * Specific Capabilities and if the BIS matches create a PAC with it
+	 */
+	if (bap_check_bis(bap->ldb, merge_data.result) == false)
+		goto cleanup;
+
+	DBG(bap, "Matching BIS %i", bis_index);
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
+	pac_source_bis = bap_pac_new(bap->rdb, NULL,
+				BT_BAP_BCAST_SOURCE, codec, &bis_qos,
+				merge_data.result, meta);
+
+	err = asprintf(&pac_source_bis->name, "%d", bis_index);
+
+	if (err < 0) {
+		DBG(bap, "error in asprintf");
+		goto cleanup;
+	}
+
+	/* Add remote source endpoint */
+	if (!bap->rdb->broadcast_sources)
+		bap->rdb->broadcast_sources = queue_new();
+	queue_push_tail(bap->rdb->broadcast_sources, pac_source_bis);
+
+	queue_foreach(bap->pac_cbs, notify_pac_added, pac_source_bis);
+	/* Push remote endpoint with direction sink */
+	ep = bap_endpoint_new_broadcast(bap->rdb, BT_BAP_BCAST_SINK);
+
+	if (ep)
+		queue_push_tail(bap->remote_eps, ep);
+
+cleanup:
+	util_iov_free(merge_data.result, 1);
+}
diff --git a/src/shared/bap.h b/src/shared/bap.h
index e4785b587e3a..76f3fb0adab6 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -333,3 +333,10 @@ void bt_bap_update_bcast_source(struct bt_bap_pac *pac,
 bool bt_bap_pac_bcast_is_local(struct bt_bap *bap, struct bt_bap_pac *pac);
 
 struct iovec *bt_bap_stream_get_base(struct bt_bap_stream *stream);
+
+void bt_bap_add_bis(struct bt_bap *bap, uint8_t bis_index,
+		struct bt_bap_codec *codec,
+		struct iovec *l2_caps,
+		struct iovec *l3_caps,
+		struct iovec *meta);
+
-- 
2.40.1

