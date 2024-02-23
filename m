Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2076.outbound.protection.outlook.com [40.107.6.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBBF8287A
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702502; cv=fail; b=qW65dB2PAjkISRJ8q5jre37+46428/mKAu4dqyPUDd2NMMTed/t1rmEU2TgyixqfU0GSUKekKydH8Q8bl5RDHI3uMLuxCbIoqyxum1nmtp1BfMAe5I0OjZr6yFtwJWoGAMOS/PXjixFXSYhTAp9LwKpyUHb1G2YAYW1oy0rYj30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702502; c=relaxed/simple;
	bh=tZ2JR57IrDvAHcvp1OZflAAN4XDe/CAaVBS+mJYxDiU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BEd7Y93xhVuY041Pbpzpm86jKRzhaLtc9sUjuyVEdfFeOM8NUkjymebYPXOCXvGnGJbTgzsUl2MOrKqt+/QPJUoXyl3S6Bim+uwVTrg2CJfcxF9H4t2lYVE/lYn9uM683upqsMmyESMu0tGkuNIHmVYfWiX+DdMZBtwkYKAX1Z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=pMApvnho; arc=fail smtp.client-ip=40.107.6.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pMApvnho"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKZX/6eEk6PdK4lLcREIQ9HIfc+9+q8iTEbDLlyxiZHvMnAhA8nD+hu623X9ICP0UeJlvFT/gvY/4KrLVNgQcHdcQK42ZUJKoKzHCteGiQAfWYVo5MvIB5dNwZl3GLBlECjj56r96U8dRpR85EqWUvEE0S/qX9tqQoCtOLvyn74J8+c1eqsAlbw2Bo1qF5Bq30zN6H9F2DHfnL+ola9vYezCOKYpycp86nVJxlq2sXhJuX70LhS1NF0Qsk/AHC2xV7S6B+2whhhJpoxv7+8GqaxCLkqMe5S1WwXcvrvAgMCOJZRYMbqHRj2Q5Do7YDUqAm/Vu3yB7tCWL8xd/gkAEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NG7p0z+qJ0y7z935qsZVY0vi+MjOGMi7Yp40E/PiUys=;
 b=cFfz2cqdDIKiqeSrUy5DAlovnW5du2g899tARixnWT8F9p3/zlYwvs7YW5FfrsBInQnwOmNVpEHRolVESb0fhdG2A8Pe0vyvpUsLCDK0A5y3qpEoRScBqXqcdj2YzRJkCqGEaz+IPEeJVA+Bq8CTG0S2Bz13pm8orKQQ7MhJBxqVphbaRD5aBUaU5bblwgAeyMf1YvSgKhGLc5csZaGFvkprQA3w9h7k7AOx79bKC6cxc7XyFpSh1CxO45Dt1muI3fJ+oM5CKU3C85ScGPJ/eStFEAh3gmogvEaYgip9V/b38UerpdoxgMdJSply0bApcEO7I9KJCLsDuZOhvJdEmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NG7p0z+qJ0y7z935qsZVY0vi+MjOGMi7Yp40E/PiUys=;
 b=pMApvnho3xmY/j5U+fqi+Pj2dl3ysiLVJgSycWz5510Nkmzg4UPvTw7tr9pfcs7Oqzrp+D4fXf2zdNl/bmIo11+RZnF0JyWBrWtCAgT6rLd2YHX3Gyx89Axehr7j1xy0ljGd3DHwXhRop5tnlSWWqSTQcTqzeqlOUDoxg9aRzgg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by AM9PR04MB8953.eurprd04.prod.outlook.com (2603:10a6:20b:408::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 23 Feb
 2024 15:34:56 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::bbd0:4409:3f0e:afdd]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::bbd0:4409:3f0e:afdd%4]) with mapi id 15.20.7292.029; Fri, 23 Feb 2024
 15:34:55 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ v4 1/2] shared/bap: Add API to add an observed BIS
Date: Fri, 23 Feb 2024 17:34:49 +0200
Message-Id: <20240223153450.86694-2-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240223153450.86694-1-andrei.istodorescu@nxp.com>
References: <20240223153450.86694-1-andrei.istodorescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0011.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::15) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|AM9PR04MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: d504c7bd-fc91-4a94-9052-08dc3484fc94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kDjPgzwCBsWnAAs0VsgF+ZlMGVE/pR6vLdb8eCKyqPmHTjaDcRIVZtXh88AWLKHMtsO4uZ+thf1zLWgoJ+zzp6WIJjaEbRU2XIzL1x1TlVUgGDIczQLiDyxypPmEC5Vfr2rxK8B/B/w0Cr1BZC4GGWFqN2Kx3OF0YfujTiXAX2R3DfgdskzxiFhDoOCf3nAlTku1110vbwkuLU3oCrvuvyDpdxJ4V9tSMsygVOlB50DJD559q3qMMMGcy9Ypq69TY6XqmCJpmLqfQmL17Bncu+ojkmhaU+y1D01/9soxxwWxlNCnVdiIldphX/v/UdC/Dl3X1frsfHwX8jwZydsviB3lVygKIbD01k3jX4s8kLkvmR48cNdormJCptzvxKCfbrMiQDzniZDmMWMz0lffG1yJYTdlGmjXH2Bo73T496bv3uztMbFVTOzIm/iMYc4R23LCSjiHeL+0XlmQTR5H4WXRPEm6qTc7Xtvay3IxKyIz5vGuO25a5vC2tHLLIpJ4xYLPBfV9UeQ2HOa681otkswG9fSa0OjxuqDPcmf0g5A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KGoCXqbbJrGWV9CYFFg0aEP07Dg3IsuvUFhFK1LR0z9GHuWdC4WFE5jiISS3?=
 =?us-ascii?Q?BHdR2ku5djLZC6pl9WXWrIMDqHrrdmKq1ZKqlJXkrRTBN/3XTBy27cEr3Ork?=
 =?us-ascii?Q?JTIOj6c1zZQv/P5kukTpbb1oovslLvyFo7IoWIuJ3vN277v2r6RQGP4TseJ9?=
 =?us-ascii?Q?GsWRx4PoHbMkomJQR6f4ONi/zTc9P2ifiuVDVN/9txVBF7xRU5vaePI1sMjl?=
 =?us-ascii?Q?nJOCAIyXynhUy1GuF0FbhzeIjM7a4c8yAAnFIdh0N/sjtOUUhSVYX+bmuyD7?=
 =?us-ascii?Q?oD8Bt/flaQUgk7mET2k6DO7VwR+Y3JLSSb9I29mglQpzQ1uVIFj1HromS05/?=
 =?us-ascii?Q?h7ms0AnmdYXEMY3ym0eNGV9qwSXEAQa2ZS/Z0A84J3BagzgkWi6bW5bW3rkD?=
 =?us-ascii?Q?KZQRxzglPjf2L5GKr/0B8jNgWCGqRiOrM/X3CyLZzjyeQIQgdXsofvJXQpR+?=
 =?us-ascii?Q?BjM3FCD71AHf/pzCkgO6cQ/HsWW11BhU0pF/0evan5Iq8kfaeajUAhyHaFNW?=
 =?us-ascii?Q?VblfTwpx6+MES1fM3Cu0Oqsec6HnXfWChLrJXYbRPiU7H8GWNfLInqAzf7Ic?=
 =?us-ascii?Q?M+3hMTTg5lRqF8yKeDIXUuPRQrYNKngEpyg7iC/pxVIFs7KPpyD9k8aRCQwy?=
 =?us-ascii?Q?3yYqsXyTNwjiEqtz+L7TeI896XPS1s3d2+PoKBIhJlqYBjtR2NGewxhKZYBU?=
 =?us-ascii?Q?NX9ZMdjcCQ7hz3HXfXWaa8RNx0+MsrJr72frkHqLeBlRlfrhuaCOqFJqDiqC?=
 =?us-ascii?Q?3pngUptn2wGBxm1S769OJE0cZQZzXBFFCIF6EMo4dpQmOS7po4ucOnPh0a3H?=
 =?us-ascii?Q?xj3RKK5IXGDQw2B/piLJIWn1CPm0mg6WmZjiNuCPJvWPqZuhnMgiTc01B2Ur?=
 =?us-ascii?Q?hVoRnYTZY36g9q2HMxSbVbpiiB1YgPCfktQrvtpahpn9ZMTz+yU+N+uQ1HGX?=
 =?us-ascii?Q?qSgLgejdtvg75U5vFstebEef5LNFETiDQBcovRpidj+HtdWZdmhR+dPpdFA3?=
 =?us-ascii?Q?1kqJt9lux1Mi0LpeD9i1l1/p+dKO3nofa/ISfBaBZGeQF1ar1Ck26KBwlPk9?=
 =?us-ascii?Q?+sSL7S++MlgJYXt75c4KCLdCV+sI5ZNCO0wMVDg+vAdvqwfMc2ceIz4UNHtP?=
 =?us-ascii?Q?zO4EoRMjZIcv/AQnJzG28M+ueakpu4w3vo9bBObtkKxO04ou6UUDdokIYKMh?=
 =?us-ascii?Q?y6gtg827IwlCKdqbAfS/3hlN0r23LthR/ESwQS8oSr42rsXorzZaqp062f8P?=
 =?us-ascii?Q?mFjH06p/3nfSIuqWviYPKHF7YBygTLL2AhlqmyV54Jsa8ABD/WdjJLW3XDyY?=
 =?us-ascii?Q?Y52gIucDIn+wnVsvG2tWafLKycL488zo4VDrkuZscPk9i7rEw620zfnJdIWl?=
 =?us-ascii?Q?DVZ5gSb+AYruRil4yWTTBMq9l8eIjiWtXFuDNsg8Oc1pKfHY9MUe+mc5obYA?=
 =?us-ascii?Q?SBOQDj2/Qn9AUaIDINMGG7E1ShYF1HyUirPWuncB7I19W8FGc7vGxDyvYrCO?=
 =?us-ascii?Q?ZhuQ1x9GFomVOnAbACF5WjLm5I3Js6y9iOlRr3fWNLP035ULvG3O9B8dQoP0?=
 =?us-ascii?Q?q8qem3FOviF4Gi/qkQjGHTv8Z43FV/GzTqbxpNn0917U2jkspY0wx14zEEms?=
 =?us-ascii?Q?ig=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d504c7bd-fc91-4a94-9052-08dc3484fc94
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 15:34:55.9394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qiLL4ymjaaWoT0JaPsdRDsOx/P9+IRufuf04vxrkGTwNpND8kkyv4qopxzvKmqq+Slxl0oPlybja2NGuKDpQz6llchhofoGtedKlXdfaFzM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8953

Add API to add a PAC for each observed BIS that is supported by the
local PACS data.
Each BIS observed capabilities LTV is compared to the local capabilities
and when we have a full LTVs match a PAC record is created for that BIS.
Also a MediaEndpoint is registered over DBUS and the stream can be
enabled using the SetConfiguration DBUS call.
---
 src/shared/bap.c | 304 ++++++++++++++++++++++++++++++++++++++++++++---
 src/shared/bap.h |  13 +-
 2 files changed, 302 insertions(+), 15 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index f5fc1402701c..853919111835 100644
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
@@ -1692,11 +1701,8 @@ static unsigned int bap_bcast_config(struct bt_bap_stream *stream,
 				     bt_bap_stream_func_t func, void *user_data)
 {
 	stream->qos = *qos;
-	if (stream->lpac->type == BT_BAP_BCAST_SINK) {
-		if (data)
-			stream_config(stream, data, NULL);
-		stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
-	}
+	stream->lpac->ops->config(stream, stream->cc, &stream->qos,
+			ep_config_cb, stream->lpac->user_data);
 
 	return 1;
 }
@@ -3302,6 +3308,13 @@ static void bap_add_broadcast_source(struct bt_bap_pac *pac)
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
@@ -3453,6 +3466,16 @@ struct bt_bap_pac_qos *bt_bap_pac_get_qos(struct bt_bap_pac *pac)
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
@@ -5253,10 +5276,6 @@ bool bt_bap_stream_set_user_data(struct bt_bap_stream *stream, void *user_data)
 
 	stream->user_data = user_data;
 
-	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_BCAST)
-		stream->lpac->ops->config(stream, stream->cc, &stream->qos,
-					ep_config_cb, stream->lpac->user_data);
-
 	return true;
 }
 
@@ -5892,8 +5911,9 @@ static void add_new_subgroup(struct bt_base *base,
 
 struct bt_ltv_match {
 	uint8_t l;
-	uint8_t *v;
+	void *data;
 	bool found;
+	uint32_t data32;
 };
 
 struct bt_ltv_search {
@@ -5912,7 +5932,7 @@ static void match_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
 	if (ltv_match->l != l)
 		return;
 
-	if (!memcmp(v, ltv_match->v, l))
+	if (!memcmp(v, ltv_match->data, l))
 		ltv_match->found = true;
 }
 
@@ -5924,7 +5944,7 @@ static void search_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
 
 	ltv_match.found = false;
 	ltv_match.l = l;
-	ltv_match.v = v;
+	ltv_match.data = v;
 
 	util_ltv_foreach(ltv_search->iov->iov_base,
 			ltv_search->iov->iov_len, &t,
@@ -5965,8 +5985,10 @@ static bool compare_ltv(struct iovec *iov1,
 }
 
 struct bt_ltv_extract {
-	struct iovec *result;
 	struct iovec *src;
+	void *value;
+	uint8_t len;
+	struct iovec *result;
 };
 
 static void extract_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
@@ -5978,7 +6000,7 @@ static void extract_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
 
 	ltv_match.found = false;
 	ltv_match.l = l;
-	ltv_match.v = v;
+	ltv_match.data = v;
 
 	/* Search each BIS caps ltv in subgroup caps
 	 * to extract the one that are BIS specific
@@ -6111,3 +6133,257 @@ struct iovec *bt_bap_stream_get_base(struct bt_bap_stream *stream)
 
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
index 2c3550921f07..b2826719f84f 100644
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
 
@@ -175,6 +175,10 @@ uint16_t bt_bap_pac_get_context(struct bt_bap_pac *pac);
 
 struct bt_bap_pac_qos *bt_bap_pac_get_qos(struct bt_bap_pac *pac);
 
+struct iovec *bt_bap_pac_get_data(struct bt_bap_pac *pac);
+
+struct iovec *bt_bap_pac_get_metadata(struct bt_bap_pac *pac);
+
 uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream);
 
 struct bt_bap_stream *bt_bap_pac_get_stream(struct bt_bap_pac *pac);
@@ -323,3 +327,10 @@ void bt_bap_update_bcast_source(struct bt_bap_pac *pac,
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

