Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OUxOJlU+"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2055.outbound.protection.outlook.com [40.107.105.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7541AB9
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Dec 2023 08:59:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hU1eEgf3B+oeISsMdbZxZM+ERmkyhqFrLysG5d4vHXzNAOmBRL5n2D7/yQ7XzJP5XS0Nu4wDwYfIRPzSOulMVvFdIx+NXlj9Pr7b88x74iV849brwCqba8sSmwfBKl/QpYgv0oxfx21tDV/ErVDy/XpZMX+2Z30c+Wd+ooy/Hv1ZZLIbVt+alyFpt8bA0XQ+xYz0balUP00E3N+U/YixxhZqmarvfM8uXXePpuU9ZkcQ4W5SyQsIfeE96QNEd2vZiZaQN3DLH83Vs4Hc0ezzcaBmj53LYHxjmjstLHXd0l8QE+nCRcxU7uADzoqJaXAJJYwso6HRrydtWKdNxIiIKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDU70rn4UYD/Yj7K+7okibS80S05fB2eLnHNsOb2Tqg=;
 b=oWWGF/lqSORIlXu2aKbifWX7QptWMqJkz2iJKuNw4fLIzi45hlYMBb2i8QuiKp1kmxxV2MEZnmdvpusNJb3ZpcX+R38uLj1mhefW0HgBuqyJ1PyWG51yMuqu0qOjTlq60jQ6yQejoh7B0NohAmfKWHRX+bWrzl3UBVQ4m17vU0EXqpEOfTqp+MrmvI+UoaumGuX3Snvc4zXZ6E3uoEHVp+7CrmFYxb6O/xwEayhyBbud9txHjPRAhc6qW59mANVUTqid2fWLVfxYp3x7TZ9xOqRBDzhmdZi4oWZwofHlBqFQbz/4b1750kq7lq87jrrkx+T+5Rf1tBIIjZB0jNg0gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDU70rn4UYD/Yj7K+7okibS80S05fB2eLnHNsOb2Tqg=;
 b=OUxOJlU+zbvSpzIwUJkbRQdV16d8BwvzBmU9U92/ZFlFFQq3+dPoN8gxurB1LCGC1Nf7VxtcGCxBTJX7811Sp7QQI7MZO9+LakCmN8BV3knTijBQtiDNwZYcNQP5jMaEeyUX9JYCSRtTiDs1ljZ5iXB/+PjFItR+94QYZ3WOvfE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS5PR04MB9942.eurprd04.prod.outlook.com (2603:10a6:20b:67e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.22; Mon, 4 Dec
 2023 16:59:47 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::25a:e1cd:f957:6e7d]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::25a:e1cd:f957:6e7d%3]) with mapi id 15.20.7068.022; Mon, 4 Dec 2023
 16:59:47 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/1] shared/bass: Functions cleanup
Date: Mon,  4 Dec 2023 18:59:34 +0200
Message-Id: <20231204165934.2847-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231204165934.2847-1-iulia.tanasescu@nxp.com>
References: <20231204165934.2847-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0179.eurprd09.prod.outlook.com
 (2603:10a6:800:120::33) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS5PR04MB9942:EE_
X-MS-Office365-Filtering-Correlation-Id: 2284bc7d-489c-4015-6f6b-08dbf4ea6bbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Hn6qWdf9DkzTfoXKKcjhvd/m1cjG6pnlTJvgzKpZv9ANrt+htQBJgthvEi5bLWX1BoyC01c9lm6sD6ReoNSwvEJ8JN8diXSVdTEE/U0RSL3w2r7dhFRPVtkn7kSQ6aF4dqBipJr+XjOKyUIU87FTtkELFEJlatRVRa+1nvGfZz4ntwERZ0Ta7VaD+L1kvjQjKZfO15CIPAELdnuxWpzN/+Mjl5tqzGlVuDrP1I79cx+CIeEVA6KotZDEJ8OdBW8ggBtTHu/VBn4b16Xwrs19PCn1tjKYk7bGjB1ylJVMYkZ+88Ev6E9AduPyDgycjy0h/3Elrra/gSG74XcKVtqy7OMPmNkQ8JhVVf6IFJqSiEynV7VOJhYlJRN6dyKUAAKtLlLMHFzQZXw2lwOrO9OTm6KJQUmD5I0pJ52KKQ5NI+Tk6wJ1TbPvoCI8Br3c0wXr6Wziu2rjjGNxW8yM+9OB3w2oLNf2bguPMpDNoX7lsXJllbG6lwXtHAJziRNnr7SKy70TeyR0o0Ktp//AL352SRaZuoGhcn/CZb5gniCJFhrLMGKIw5VrdxMJ9hujF8V5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6916009)(66556008)(66476007)(66946007)(4326008)(8676002)(8936002)(316002)(6486002)(478600001)(6666004)(30864003)(36756003)(41300700001)(2906002)(5660300002)(86362001)(44832011)(83380400001)(2616005)(26005)(1076003)(38100700002)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2/fDqjKbYmJqQM5eLWs83WVS16dBVbEVkwC19L5C/67Z9NuHUVMJcNU3qoK2?=
 =?us-ascii?Q?gIJSs5H0dSDtzQ7h/ybbtlHX3IiVleZ0BCW9BeY+9mmjJzEPrGuoXGrM7QVk?=
 =?us-ascii?Q?sIa3BLcl/J+3IBP1UKtjtcjR7JGe6dfO8lqbsdQ8c3/nDV8bBOcuNLdkLyvu?=
 =?us-ascii?Q?E5NPfLhqMhnUMgoZwJCbFfZCkZ9VxwKk+XMbXBFtnhpyUdyBzS5EDz4dnaTy?=
 =?us-ascii?Q?pqBnwANytfyxQIt+36NyOp3MNf+000FagxG+ukxGthp3Zb/B0aSOJOrlcO3H?=
 =?us-ascii?Q?DYdLj2VtXDbzQTQF/ME2HZOhN23vJIis6OmpiTbWwml9gxS7ke4bn4cddHjq?=
 =?us-ascii?Q?ZimFZJzHdhxkUPspCxvtyoTuqShMdhAsQZMcjpgiBKsH3uZfcBMpfS0nOitv?=
 =?us-ascii?Q?mId3g42lV9tA21A71iG7iTNou8LU7RWijUW7MPhC6FGNosH2vv3AXu0w4sx3?=
 =?us-ascii?Q?H8FP+lw2+HzXI7sjS7d13AJsFyruYhTasHpgn83mlTMUSpoelRWQ9JepZxJ5?=
 =?us-ascii?Q?s5jYAXj8UDXZOx3/TIdPjDWZnkmBCGQ1H5mW4KEYFwYeUYjn1yH3uiyV/VgZ?=
 =?us-ascii?Q?MihuO7axfpolb/wouda59uRqJEmLL7JLbba+8GUKpLPQe0rZYe1kzBScLlp1?=
 =?us-ascii?Q?jNAnsuyH3uvtNUdENi9kPY24U1GYPSqg2/0wPx7qHaK5G4sYLUtlc4s2K0wb?=
 =?us-ascii?Q?UpLRBuy1rW0asnSY2ADUZMIRlcp+LZGZHK/6IakPQ86MeO/q9ljX94n3qIcl?=
 =?us-ascii?Q?9WpBbYvmFjaaNDhYQnEAratPLU4F29mSbGDmxV94WqpDP3EXYo5sQBmHp/Km?=
 =?us-ascii?Q?S12PugunePsgGOa/DDnLOQCbD0m2WxY+IY2GZAzePv1mFR7XK81TLB0pjjCz?=
 =?us-ascii?Q?1JkCOyNBt5guKq9KBWUSK98w0lo5SHkgjBFyxNQHfSkfsQlxQoeB34opUkrx?=
 =?us-ascii?Q?Og45fbZTVzsAbduWu7kH91ZnBVgjxKlhYQ0njXStne+rL5ikLNQ38ftOJ7cj?=
 =?us-ascii?Q?pWumVVy/fDT0plhu2DYVeKRthPAPcVONvkZehgvQVT9jp+Sx4PmFpZOt4P0r?=
 =?us-ascii?Q?05mUNGpRTyvEf0PE40KOHpXUBBuWRaze7DvQZt8MFJy1zxCGdwpCUb916z+2?=
 =?us-ascii?Q?xUkStaQIHr2cZb7Kf0LMjO52B1kHFMadtBwCZOUzKjGnbGz8396WzjfXjqRc?=
 =?us-ascii?Q?1bM/qdxtg62qkcC5Hyaukl/ZKQxPfJ0IhNAp/A2uxeFdYO2tPGldnkIGKUez?=
 =?us-ascii?Q?tA96fBG3ez4ruigw/RbdGBp5C3PcisjfMolEFCKuzXcR5/WFdeZPanFGUE9m?=
 =?us-ascii?Q?a9eUXFGtIwnbBQOWeWhpsa0EAWzbLvaaT5+Nl8nL/7iVe8EWi4fgi2ny0Oxz?=
 =?us-ascii?Q?0giX7YZgbI98MEy3Y/ucleta7XLzYi1+NqPR6NkYI/qupg9SbZgK7l2M2g6F?=
 =?us-ascii?Q?Bf5p04wRTrGA9ItcyVw3HcHuELKMKja5L6nWQVWFhX4nbm2hWTszWlSQT59u?=
 =?us-ascii?Q?wGIk+u4anDYme7pYUjXUdMG6aZNUqCRNFllT98PmaBCSn9s2Mvp0lYoPA4pg?=
 =?us-ascii?Q?zWJfjyuxbW2G9W7xPBOTF4fAE/VhC5Y6rZ3b4MB1AUZAn6yw4R5AHMMYwis1?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2284bc7d-489c-4015-6f6b-08dbf4ea6bbe
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 16:59:47.2812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4QeYEWpLhMwNW37zJiQRVuxBI2rfzLls7UOaG6acFBoE71NtLippdubP+UIirNtr59yXeJTIHJdRw/WKbckLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9942

This adds some cleanup in shared/bass code: use util_iov
APIs to extract/push bytes, use new0 to allocate structures,
remove redundant functions.

---
 src/shared/bass.c | 241 +++++++++++++++++++---------------------------
 1 file changed, 101 insertions(+), 140 deletions(-)

diff --git a/src/shared/bass.c b/src/shared/bass.c
index ce8b239f3..3f5bf307c 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -132,22 +132,21 @@ static void bass_debug(struct bt_bass *bass, const char *format, ...)
 	va_end(ap);
 }
 
-static int
-bass_build_bcast_src_from_notif(struct bt_bcast_src *bcast_src,
+static int bass_build_bcast_src(struct bt_bcast_src *bcast_src,
 				const uint8_t *value, uint16_t length)
 {
 	struct bt_bass_subgroup_data *subgroup_data = NULL;
-	uint8_t *id;
-	uint8_t *addr_type;
+	uint8_t id;
+	uint8_t addr_type;
 	uint8_t *addr;
-	uint8_t *sid;
+	uint8_t sid;
 	uint32_t bid;
-	uint8_t *pa_sync_state;
-	uint8_t *enc;
+	uint8_t pa_sync_state;
+	uint8_t enc;
 	uint8_t *bad_code = NULL;
-	uint8_t *num_subgroups;
+	uint8_t num_subgroups;
 	uint32_t bis_sync_state;
-	uint8_t *meta_len;
+	uint8_t meta_len;
 	uint8_t *meta;
 
 	struct iovec iov = {
@@ -156,14 +155,12 @@ bass_build_bcast_src_from_notif(struct bt_bcast_src *bcast_src,
 	};
 
 	/* Extract all fields from notification */
-	id = util_iov_pull_mem(&iov, sizeof(*id));
-	if (!id) {
+	if (!util_iov_pull_u8(&iov, &id)) {
 		DBG(bcast_src->bass, "Unable to parse Broadcast Receive State");
 		return -1;
 	}
 
-	addr_type = util_iov_pull_mem(&iov, sizeof(*addr_type));
-	if (!addr_type) {
+	if (!util_iov_pull_u8(&iov, &addr_type)) {
 		DBG(bcast_src->bass, "Unable to parse Broadcast Receive State");
 		return -1;
 	}
@@ -174,8 +171,7 @@ bass_build_bcast_src_from_notif(struct bt_bcast_src *bcast_src,
 		return -1;
 	}
 
-	sid = util_iov_pull_mem(&iov, sizeof(*sid));
-	if (!sid) {
+	if (!util_iov_pull_u8(&iov, &sid)) {
 		DBG(bcast_src->bass, "Unable to parse Broadcast Receive State");
 		return -1;
 	}
@@ -185,19 +181,17 @@ bass_build_bcast_src_from_notif(struct bt_bcast_src *bcast_src,
 		return -1;
 	}
 
-	pa_sync_state = util_iov_pull_mem(&iov, sizeof(*pa_sync_state));
-	if (!pa_sync_state) {
+	if (!util_iov_pull_u8(&iov, &pa_sync_state)) {
 		DBG(bcast_src->bass, "Unable to parse Broadcast Receive State");
 		return -1;
 	}
 
-	enc = util_iov_pull_mem(&iov, sizeof(*enc));
-	if (!enc) {
+	if (!util_iov_pull_u8(&iov, &enc)) {
 		DBG(bcast_src->bass, "Unable to parse Broadcast Receive State");
 		return -1;
 	}
 
-	if (*enc == BT_BASS_BIG_ENC_STATE_BAD_CODE) {
+	if (enc == BT_BASS_BIG_ENC_STATE_BAD_CODE) {
 		bad_code = util_iov_pull_mem(&iov, BT_BASS_BCAST_CODE_SIZE);
 		if (!bad_code) {
 			DBG(bcast_src->bass, "Unable to parse "
@@ -206,24 +200,21 @@ bass_build_bcast_src_from_notif(struct bt_bcast_src *bcast_src,
 		}
 	}
 
-	num_subgroups = util_iov_pull_mem(&iov, sizeof(*num_subgroups));
-	if (!num_subgroups) {
+	if (!util_iov_pull_u8(&iov, &num_subgroups)) {
 		DBG(bcast_src->bass, "Unable to parse Broadcast Receive State");
 		return -1;
 	}
 
-	if (*num_subgroups == 0)
+	if (num_subgroups == 0)
 		goto done;
 
-	subgroup_data = malloc((*num_subgroups) * sizeof(*subgroup_data));
+	subgroup_data = new0(struct bt_bass_subgroup_data, 1);
 	if (!subgroup_data) {
 		DBG(bcast_src->bass, "Unable to allocate memory");
 		return -1;
 	}
 
-	memset(subgroup_data, 0, (*num_subgroups) * sizeof(*subgroup_data));
-
-	for (int i = 0; i < *num_subgroups; i++) {
+	for (int i = 0; i < num_subgroups; i++) {
 		if (!util_iov_pull_le32(&iov, &bis_sync_state)) {
 			DBG(bcast_src->bass, "Unable to parse "
 				"Broadcast Receive State");
@@ -237,8 +228,7 @@ bass_build_bcast_src_from_notif(struct bt_bcast_src *bcast_src,
 
 		subgroup_data[i].bis_sync = bis_sync_state;
 
-		meta_len = util_iov_pull_mem(&iov, sizeof(*meta_len));
-		if (!meta_len) {
+		if (!util_iov_pull_u8(&iov, &meta_len)) {
 			DBG(bcast_src->bass, "Unable to parse "
 				"Broadcast Receive State");
 
@@ -249,12 +239,12 @@ bass_build_bcast_src_from_notif(struct bt_bcast_src *bcast_src,
 			return -1;
 		}
 
-		subgroup_data[i].meta_len = *meta_len;
+		subgroup_data[i].meta_len = meta_len;
 
-		if (*meta_len == 0)
+		if (meta_len == 0)
 			continue;
 
-		subgroup_data[i].meta = malloc(*meta_len);
+		subgroup_data[i].meta = malloc0(meta_len);
 		if (!subgroup_data[i].meta) {
 			DBG(bcast_src->bass, "Unable to allocate memory");
 
@@ -265,7 +255,7 @@ bass_build_bcast_src_from_notif(struct bt_bcast_src *bcast_src,
 			return -1;
 		}
 
-		meta = util_iov_pull_mem(&iov, *meta_len);
+		meta = util_iov_pull_mem(&iov, meta_len);
 		if (!meta) {
 			DBG(bcast_src->bass, "Unable to parse "
 				"Broadcast Receive State");
@@ -277,7 +267,7 @@ bass_build_bcast_src_from_notif(struct bt_bcast_src *bcast_src,
 			return -1;
 		}
 
-		memcpy(subgroup_data[i].meta, meta, *meta_len);
+		memcpy(subgroup_data[i].meta, meta, meta_len);
 	}
 
 done:
@@ -292,41 +282,31 @@ done:
 		free(bcast_src->subgroup_data);
 	}
 
-	bcast_src->id = *id;
-	bcast_src->addr_type = *addr_type;
+	bcast_src->id = id;
+	bcast_src->addr_type = addr_type;
 	memcpy(&bcast_src->addr, addr, sizeof(bdaddr_t));
-	bcast_src->sid = *sid;
+	bcast_src->sid = sid;
 	bcast_src->bid = bid;
-	bcast_src->sync_state = *pa_sync_state;
-	bcast_src->enc = *enc;
+	bcast_src->sync_state = pa_sync_state;
+	bcast_src->enc = enc;
 
-	if (*enc == BT_BASS_BIG_ENC_STATE_BAD_CODE)
+	if (enc == BT_BASS_BIG_ENC_STATE_BAD_CODE)
 		memcpy(bcast_src->bad_code, bad_code, BT_BASS_BCAST_CODE_SIZE);
 	else
 		memset(bcast_src->bad_code, 0, BT_BASS_BCAST_CODE_SIZE);
 
-	bcast_src->num_subgroups = *num_subgroups;
+	bcast_src->num_subgroups = num_subgroups;
 
 	bcast_src->subgroup_data = subgroup_data;
 
 	return 0;
 }
 
-static int
-bass_build_bcast_src_from_read_rsp(struct bt_bcast_src *bcast_src,
-				const uint8_t *value, uint16_t length)
-{
-	return bass_build_bcast_src_from_notif(bcast_src, value, length);
-}
-
-static uint8_t *bass_build_notif_from_bcast_src(struct bt_bcast_src *bcast_src,
-							size_t *notif_len)
+static struct iovec *bass_parse_bcast_src(struct bt_bcast_src *bcast_src)
 {
 	size_t len = 0;
 	uint8_t *notif = NULL;
-	struct iovec iov;
-
-	*notif_len = 0;
+	struct iovec *iov;
 
 	if (!bcast_src)
 		return NULL;
@@ -342,61 +322,49 @@ static uint8_t *bass_build_notif_from_bcast_src(struct bt_bcast_src *bcast_src,
 		len += bcast_src->subgroup_data[i].meta_len;
 	}
 
-	notif = malloc(len);
+	notif = malloc0(len);
 	if (!notif)
 		return NULL;
 
-	memset(notif, 0, len);
+	iov = new0(struct iovec, 1);
+	if (!iov) {
+		free(notif);
+		return NULL;
+	}
 
-	iov.iov_base = notif;
-	iov.iov_len = 0;
+	iov->iov_base = notif;
+	iov->iov_len = 0;
 
-	util_iov_push_mem(&iov, sizeof(bcast_src->id),
-			&bcast_src->id);
-	util_iov_push_mem(&iov, sizeof(bcast_src->addr_type),
-			&bcast_src->addr_type);
-	util_iov_push_mem(&iov, sizeof(bcast_src->addr),
+	util_iov_push_u8(iov, bcast_src->id);
+	util_iov_push_u8(iov, bcast_src->addr_type);
+	util_iov_push_mem(iov, sizeof(bcast_src->addr),
 			&bcast_src->addr);
-	util_iov_push_mem(&iov, sizeof(bcast_src->sid),
-			&bcast_src->sid);
-	util_iov_push_le24(&iov, bcast_src->bid);
-	util_iov_push_mem(&iov, sizeof(bcast_src->sync_state),
-			&bcast_src->sync_state);
-	util_iov_push_mem(&iov, sizeof(bcast_src->enc),
-			&bcast_src->enc);
+	util_iov_push_u8(iov, bcast_src->sid);
+	util_iov_push_le24(iov, bcast_src->bid);
+	util_iov_push_u8(iov, bcast_src->sync_state);
+	util_iov_push_u8(iov, bcast_src->enc);
 
 	if (bcast_src->enc == BT_BASS_BIG_ENC_STATE_BAD_CODE)
-		util_iov_push_mem(&iov, sizeof(bcast_src->bad_code),
+		util_iov_push_mem(iov, sizeof(bcast_src->bad_code),
 					bcast_src->bad_code);
 
-	util_iov_push_mem(&iov, sizeof(bcast_src->num_subgroups),
-				&bcast_src->num_subgroups);
+	util_iov_push_u8(iov, bcast_src->num_subgroups);
 
 	for (size_t i = 0; i < bcast_src->num_subgroups; i++) {
 		/* Add subgroup bis_sync */
-		util_iov_push_le32(&iov, bcast_src->subgroup_data[i].bis_sync);
+		util_iov_push_le32(iov, bcast_src->subgroup_data[i].bis_sync);
 
 		/* Add subgroup meta_len */
-		util_iov_push_mem(&iov,
-			sizeof(bcast_src->subgroup_data[i].meta_len),
-			&bcast_src->subgroup_data[i].meta_len);
+		util_iov_push_u8(iov, bcast_src->subgroup_data[i].meta_len);
 
 		/* Add subgroup metadata */
 		if (bcast_src->subgroup_data[i].meta_len > 0)
-			util_iov_push_mem(&iov,
+			util_iov_push_mem(iov,
 				bcast_src->subgroup_data[i].meta_len,
 				bcast_src->subgroup_data[i].meta);
 	}
 
-	*notif_len = len;
-	return notif;
-}
-
-static uint8_t *
-bass_build_read_rsp_from_bcast_src(struct bt_bcast_src *bcast_src,
-					size_t *rsp_len)
-{
-	return bass_build_notif_from_bcast_src(bcast_src, rsp_len);
+	return iov;
 }
 
 static bool bass_check_cp_command_subgroup_data_len(uint8_t num_subgroups,
@@ -605,8 +573,7 @@ static void connect_cb(GIOChannel *io, GError *gerr,
 				gpointer user_data)
 {
 	struct bt_bcast_src *bcast_src = user_data;
-	uint8_t *notify_data;
-	size_t notify_data_len;
+	struct iovec *notif;
 	int bis_idx;
 	int i;
 
@@ -678,15 +645,16 @@ static void connect_cb(GIOChannel *io, GError *gerr,
 	}
 
 	/* Send notification to client */
-	notify_data = bass_build_notif_from_bcast_src(bcast_src,
-						&notify_data_len);
+	notif = bass_parse_bcast_src(bcast_src);
+	if (!notif)
+		return;
 
 	gatt_db_attribute_notify(bcast_src->attr,
-					(void *)notify_data,
-					notify_data_len,
+					notif->iov_base, notif->iov_len,
 					bt_bass_get_att(bcast_src->bass));
 
-	free(notify_data);
+	free(notif->iov_base);
+	free(notif);
 }
 
 static bool bass_trigger_big_sync(struct bt_bcast_src *bcast_src)
@@ -710,8 +678,7 @@ static void confirm_cb(GIOChannel *io, gpointer user_data)
 	int sk, err;
 	socklen_t len;
 	struct bt_iso_qos qos;
-	uint8_t *notify_data;
-	size_t notify_data_len;
+	struct iovec *notif;
 	GError *gerr = NULL;
 
 	if (check_io_err(io)) {
@@ -759,15 +726,16 @@ static void confirm_cb(GIOChannel *io, gpointer user_data)
 	bcast_src->enc = BT_BASS_BIG_ENC_STATE_BCODE_REQ;
 
 notify:
-	notify_data = bass_build_notif_from_bcast_src(bcast_src,
-						&notify_data_len);
+	notif = bass_parse_bcast_src(bcast_src);
+	if (!notif)
+		return;
 
 	gatt_db_attribute_notify(bcast_src->attr,
-					(void *)notify_data,
-					notify_data_len,
+					notif->iov_base, notif->iov_len,
 					bt_bass_get_att(bcast_src->bass));
 
-	free(notify_data);
+	free(notif->iov_base);
+	free(notif);
 }
 
 static struct bt_bass *bass_get_session(struct bt_att *att, struct gatt_db *db,
@@ -855,14 +823,13 @@ static void bass_handle_add_src_op(struct bt_bass *bass,
 	struct bt_bcast_src *bcast_src, *src;
 	uint8_t src_id = 0;
 	struct gatt_db_attribute *attr;
-	uint8_t *pa_sync;
+	uint8_t pa_sync;
 	GIOChannel *io;
 	GError *err = NULL;
 	struct bt_iso_qos iso_qos = default_qos;
 	uint8_t num_bis = 0;
 	uint8_t bis[ISO_MAX_NUM_BIS];
-	uint8_t *notify_data;
-	size_t notify_data_len;
+	struct iovec *notif;
 	uint8_t addr_type;
 
 	gatt_db_attribute_write_result(attrib, id, 0x00);
@@ -872,7 +839,7 @@ static void bass_handle_add_src_op(struct bt_bass *bass,
 		return;
 
 	/* Allocate a new broadcast source */
-	bcast_src = malloc(sizeof(*bcast_src));
+	bcast_src = new0(struct bt_bcast_src, 1);
 	if (!bcast_src) {
 		DBG(bass, "Unable to allocate broadcast source");
 		return;
@@ -880,7 +847,6 @@ static void bass_handle_add_src_op(struct bt_bass *bass,
 
 	queue_push_tail(bass->ldb->bcast_srcs, bcast_src);
 
-	memset(bcast_src, 0, sizeof(*bcast_src));
 	memset(bis, 0, ISO_MAX_NUM_BIS);
 
 	bcast_src->bass = bass;
@@ -932,36 +898,32 @@ static void bass_handle_add_src_op(struct bt_bass *bass,
 	bcast_src->id = src_id;
 
 	/* Populate broadcast source fields from command parameters */
-	bcast_src->addr_type = *(uint8_t *)util_iov_pull_mem(iov,
-					sizeof(bcast_src->addr_type));
+	util_iov_pull_u8(iov, &bcast_src->addr_type);
 
 	bacpy(&bcast_src->addr, (bdaddr_t *)util_iov_pull_mem(iov,
 						sizeof(bdaddr_t)));
-	bcast_src->sid = *(uint8_t *)util_iov_pull_mem(iov,
-						sizeof(bcast_src->sid));
+
+	util_iov_pull_u8(iov, &bcast_src->sid);
 	util_iov_pull_le24(iov, &bcast_src->bid);
 
-	pa_sync = util_iov_pull_mem(iov, sizeof(*pa_sync));
+	util_iov_pull_u8(iov, &pa_sync);
 	bcast_src->sync_state = BT_BASS_NOT_SYNCHRONIZED_TO_PA;
 
 	/* TODO: Use the pa_interval field for the sync transfer procedure */
 	util_iov_pull_mem(iov, sizeof(uint16_t));
 
-	bcast_src->num_subgroups = *(uint8_t *)util_iov_pull_mem(iov,
-					sizeof(bcast_src->num_subgroups));
+	util_iov_pull_u8(iov, &bcast_src->num_subgroups);
 
 	if (!bcast_src->num_subgroups)
 		return;
 
-	bcast_src->subgroup_data = malloc(bcast_src->num_subgroups *
-					sizeof(*bcast_src->subgroup_data));
+	bcast_src->subgroup_data = new0(struct bt_bass_subgroup_data,
+					bcast_src->num_subgroups);
 	if (!bcast_src->subgroup_data) {
 		DBG(bass, "Unable to allocate subgroup data");
 		goto err;
 	}
 
-	memset(bcast_src->subgroup_data, 0, sizeof(*bcast_src->subgroup_data));
-
 	for (int i = 0; i < bcast_src->num_subgroups; i++) {
 		struct bt_bass_subgroup_data *data =
 				&bcast_src->subgroup_data[i];
@@ -985,7 +947,7 @@ static void bass_handle_add_src_op(struct bt_bass *bass,
 		if (!data->meta_len)
 			continue;
 
-		data->meta = malloc(data->meta_len);
+		data->meta = malloc0(data->meta_len);
 		if (!data->meta)
 			goto err;
 
@@ -1031,15 +993,16 @@ static void bass_handle_add_src_op(struct bt_bass *bass,
 			bcast_src->subgroup_data[i].bis_sync =
 				bcast_src->subgroup_data[i].pending_bis_sync;
 
-		notify_data = bass_build_notif_from_bcast_src(bcast_src,
-							&notify_data_len);
+		notif = bass_parse_bcast_src(bcast_src);
+		if (!notif)
+			return;
 
 		gatt_db_attribute_notify(bcast_src->attr,
-				(void *)notify_data,
-				notify_data_len,
+				notif->iov_base, notif->iov_len,
 				bt_bass_get_att(bcast_src->bass));
 
-		free(notify_data);
+		free(notif->iov_base);
+		free(notif);
 	}
 
 	return;
@@ -1068,8 +1031,7 @@ static void bass_handle_set_bcast_code_op(struct bt_bass *bass,
 	socklen_t len;
 	struct bt_iso_qos qos;
 	GError *gerr = NULL;
-	uint8_t *notify_data;
-	size_t notify_data_len;
+	struct iovec *notif;
 
 	/* Get Set Broadcast Code command parameters */
 	params = util_iov_pull_mem(iov, sizeof(*params));
@@ -1091,15 +1053,16 @@ static void bass_handle_set_bcast_code_op(struct bt_bass *bass,
 	if (!bass_trigger_big_sync(bcast_src)) {
 		bcast_src->enc = BT_BASS_BIG_ENC_STATE_DEC;
 
-		notify_data = bass_build_notif_from_bcast_src(bcast_src,
-							&notify_data_len);
+		notif = bass_parse_bcast_src(bcast_src);
+		if (!notif)
+			return;
 
 		gatt_db_attribute_notify(bcast_src->attr,
-					(void *)notify_data,
-					notify_data_len,
+					notif->iov_base, notif->iov_len,
 					bt_bass_get_att(bcast_src->bass));
 
-		free(notify_data);
+		free(notif->iov_base);
+		free(notif);
 		return;
 	}
 
@@ -1221,8 +1184,7 @@ static void bass_bcast_recv_state_read(struct gatt_db_attribute *attrib,
 					void *user_data)
 {
 	struct bt_bass_db *bdb = user_data;
-	uint8_t *rsp;
-	size_t rsp_len;
+	struct iovec *rsp;
 	struct bt_bcast_src *bcast_src;
 	struct bt_bass *bass = bass_get_session(att, bdb->db,
 						&bdb->adapter_bdaddr);
@@ -1238,7 +1200,7 @@ static void bass_bcast_recv_state_read(struct gatt_db_attribute *attrib,
 	}
 
 	/* Build read response */
-	rsp = bass_build_read_rsp_from_bcast_src(bcast_src, &rsp_len);
+	rsp = bass_parse_bcast_src(bcast_src);
 
 	if (!rsp) {
 		gatt_db_attribute_read_result(attrib, id,
@@ -1247,9 +1209,10 @@ static void bass_bcast_recv_state_read(struct gatt_db_attribute *attrib,
 		return;
 	}
 
-	gatt_db_attribute_read_result(attrib, id, 0, (void *)rsp,
-						rsp_len);
+	gatt_db_attribute_read_result(attrib, id, 0, rsp->iov_base,
+						rsp->iov_len);
 
+	free(rsp->iov_base);
 	free(rsp);
 }
 
@@ -1348,7 +1311,7 @@ static void read_bcast_recv_state(bool success, uint8_t att_ecode,
 		return;
 	}
 
-	if (bass_build_bcast_src_from_read_rsp(bcast_src, value, length)) {
+	if (bass_build_bcast_src(bcast_src, value, length)) {
 		queue_remove(bcast_src->bass->rdb->bcast_srcs, bcast_src);
 		bass_bcast_src_free(bcast_src);
 		return;
@@ -1367,7 +1330,7 @@ static void bcast_recv_state_notify(struct bt_bass *bass, uint16_t value_handle,
 					bass_src_match_attrib, attr);
 	if (!bcast_src) {
 		new_src = true;
-		bcast_src = malloc(sizeof(*bcast_src));
+		bcast_src = new0(struct bt_bcast_src, 1);
 
 		if (!bcast_src) {
 			DBG(bass, "Failed to allocate "
@@ -1375,12 +1338,11 @@ static void bcast_recv_state_notify(struct bt_bass *bass, uint16_t value_handle,
 			return;
 		}
 
-		memset(bcast_src, 0, sizeof(struct bt_bcast_src));
 		bcast_src->bass = bass;
 		bcast_src->attr = attr;
 	}
 
-	if (bass_build_bcast_src_from_notif(bcast_src, value, length)
+	if (bass_build_bcast_src(bcast_src, value, length)
 							&& new_src) {
 		bass_bcast_src_free(bcast_src);
 		return;
@@ -1474,7 +1436,7 @@ static void foreach_bass_char(struct gatt_db_attribute *attr, void *user_data)
 						bass_src_match_attrib, attr);
 
 		if (!bcast_src) {
-			bcast_src = malloc(sizeof(struct bt_bcast_src));
+			bcast_src = new0(struct bt_bcast_src, 1);
 
 			if (bcast_src == NULL) {
 				DBG(bass, "Failed to allocate "
@@ -1482,7 +1444,6 @@ static void foreach_bass_char(struct gatt_db_attribute *attr, void *user_data)
 				return;
 			}
 
-			memset(bcast_src, 0, sizeof(struct bt_bcast_src));
 			bcast_src->bass = bass;
 			bcast_src->attr = attr;
 
-- 
2.39.2

