Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2060.outbound.protection.outlook.com [40.107.241.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA8512880E
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 16:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708706905; cv=fail; b=WZ9WvZdooU2Kj1rNT9VkOnn6T7QKnOU8ZeoqK7r5Kj9r4ZW2umw048SxXnHsyYX+LHgjleQ4BpkanhM2IU2JhdJam1eML2zd06R2o6mpu3mA/D+IXfQTpycHKYrNErjuA7ca1DxpMe06kJMY+QJHtsQZLMzl7uWPFRmVF8IpjAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708706905; c=relaxed/simple;
	bh=xFQljZp9Y8UQKSimCcnE0Ofh/VLNQmMqh+TpxgwHN/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JklhF7/CuyTVkw+W3sCCfIzrGzFGDM7Y3gDjeCWl61QNOezHnbsJBlyT486Up12AoQzoIfCirAYgIdH+YAsnE+bEaIFTQfZA4mR/kruVC8v6QKb/X4VBu6//JMdBMMutCaRBHTDbz9gsxi4XqNTCtPDFkMlb2l3JfMq24f03ZAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=QDt7CUQZ; arc=fail smtp.client-ip=40.107.241.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QDt7CUQZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYeYQ0ZxNcjg61JZfl19BeuYzBurd6PzcxIwJT0Xa7gaFvAzfkdYunilIOPzW8+/O60yTDx/2NhB/Qbh31phQKE7Hwh03d98a/4ek4tiVV3FdQzxZKm+HMTPi6wjh5sj9B0bASbsridq05sXuNUuysf9xbzeFWKqP812QaVHPUQAgmn7z3q7jMfjmBGkvsgHFeeKT5Y0xkvEpxfUUuONOX17mGeVBYkXzESlasjoweI+SHokdjPSomG2evAO+cHIJFdmwB21b6oEGWCmllvN096wdMlSqX46WKF+mVYfcT8A6jWeUrxguwOYdEHD23eNAPIj+mrjFfJEIxTtOBM8nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYgH+pvODzD+YcGEXRrYjMyDmb0xa9sfFbcQdvHpYRc=;
 b=Drf62I8WhQnzLPTaTO04lqMZ9iqNHR+8uWDGa9ePm7we55Gv4cbW3S8hBW2q3xRkmCT9nMGusZ4tUwHhqKIWhUIOzCpxTUtBrNPX3GhHiiHiWUz/rwKTjDcN7pkudOy4vS216BjWv3yEQkf5POme6Bz0fJ8yfNGnEBcoOD8p1H7kzzMUDAoofOSbwZpr3bfBY51Kpcu49uafW3M7r2KHNr2g8GyMp/XILWn9HSnvwhv5mDgMVSM80lUhzGQExmHvij1kjC+Fpw+ZUzJBOMPu+fUDUYNAsrtbucPTw68H3clrz6X4IBMp3IiajQ73KuUpA1gtXg0VZPKbWBURY28SwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYgH+pvODzD+YcGEXRrYjMyDmb0xa9sfFbcQdvHpYRc=;
 b=QDt7CUQZ9Lpy+tDQOTxFkn2GiHWQnmYm0bkHqonnzC3qB5TPh+VS2+5nNBq8G61xWPk1AMshIg7wWU8jsYiUNnRSUtvcESF2TIEHV066HR9mCWnWlpdLCflIYyGBtrKjrYfdQlTs9RE2w6H0eybynqf8RpwMcVO0OkGLqLmiv9w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by DB9PR04MB8479.eurprd04.prod.outlook.com (2603:10a6:10:2c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 16:48:20 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 16:48:20 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v4 2/5] shared/bap: Add state in stream struct for bcast source
Date: Fri, 23 Feb 2024 18:48:10 +0200
Message-Id: <20240223164813.66484-3-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240223164813.66484-1-silviu.barbulescu@nxp.com>
References: <20240223164813.66484-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0082.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::23) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|DB9PR04MB8479:EE_
X-MS-Office365-Filtering-Correlation-Id: 53862b1e-e266-42fb-6e07-08dc348f3de1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tPAk8VPJmM9ysMfyEiUBPaj7SB6QnHJy0yIn4S41SP+wTjlYhQGf/UnEOw5JEz3w9mz0UdaUt3EaWQn0bG/tEnmLHp06XZ08YQ1HK8/WzhenLzxyNhGlS/xbpevp4ysvsMEq7uQFcokRqgrx0Vq6upK7Zj2Uqr0EfKWR1koL6V78C4CUgHi+iiBw0VOyF04DrzeeUP+P9Qx6SaBTpW5VgdV25hdqQUOV++LUHr8h9MWoGMbmEi1afGAuiosPixY7+VKrkURDUq+gcU1M5SEyVkGoV30qiAMaFFtGoJps0qs3GXBY2dPZiapdIfAKRnpDSndvQJ8GMeAHfL0JQQF+ha8g7JiTV9p/WDoF3Ua4MBendowPlK1+Miu2ojRjb68DdKqlWl/4sruJ350dlOfg+ZQDAjPP/LrAwKvu6eTgInZbnxduxZGlwWGbevaLV09TySIejXdhQHBWXkpp2ewmSv8DiuPWJp12Nx0seOzsajt1li7JVtOsdBtKE1zVhoIztJUeaH+kxORBTvBZgs/NNiEF2Kpuj3iJQemv9aqsrGQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bw3Tbk2hIxNr7YWf81SJiuAjYNMN8OEbQiH2Wghcq9/vV9DiPTeVhjP+Fabe?=
 =?us-ascii?Q?S8jzYDGo/YlCquDIN0OSulsTtOFKljRAKvHhdIEXRkoJ568bqsczYWjjfaVs?=
 =?us-ascii?Q?3B2FnDMjOuK9SAjx8YoH8UzfsSv12fNo/ZkEZrSmCjvJ9HTOBkVljBkDz3ZM?=
 =?us-ascii?Q?L2KqrkRpj20lU4kMB7zlslWft9MpuslnrwRxBA8qsFr8gJYliTdzNGsgTgEM?=
 =?us-ascii?Q?b2GwFO1F+t83WnsJOpZoY0cbTQYhU5vDCohycTWAmzy4FulzV5wh1q2YcQrN?=
 =?us-ascii?Q?rz8zpGIjaUQQkeZIUm9ZyeKmS+2EkJ6h+wAmn2uXgZBX4aSQXkNjwuEje6HS?=
 =?us-ascii?Q?IYyHpmiciMF3YyqiCL9GnohUXEhhIXRbotXVxarz+BTfdeMbclYx5lNmHKcr?=
 =?us-ascii?Q?9Oo5DUH5bav+uQ+n6h1wwAKgY8FZN9HP4pf5QFcu9c0BckeKu1GKm0TUl9fL?=
 =?us-ascii?Q?/hmMezzqesJtCNu7jgzPaLHP8lNnaBMys3v+HAWMX0EV2Te1a67Zso67Izjj?=
 =?us-ascii?Q?5S9Uv9IldZqO+8vf472Uzs28B68bIImmg8L9V6vvR7OYMjUcZebVDmlxkEuo?=
 =?us-ascii?Q?+DPmtZcWfZwyNyrAU+lgY1dosqELWHXE0A03tCHaJwTPWa249Z73qR+nXmNE?=
 =?us-ascii?Q?AvslemkdKUf1sELDq5mSyjYH3YCzBb/nP6QQERbppF9UcEBZu8W+Mb6EdRzr?=
 =?us-ascii?Q?BjZ7yzXNfdTT4rfDj6v8reWiBbRBbYJLlO0jCGw5dD7gyVB4AThfLTt7RTrr?=
 =?us-ascii?Q?JHWwmYTVpdcNItWpwi0w2v/PcAOWF/9WCAR6RLPPZOZbQ/fgcy86Ioi3rSFU?=
 =?us-ascii?Q?FrDufuHGsrPbo47MtkI26F6r5BMd0dzDiChbcWNnw9CVzW1nwZhFxrvyBrMJ?=
 =?us-ascii?Q?D5Yrak8+OhJVpoJswqHI94Q1vaIieNz6djt8fDT/J0GwKp/8aKgHyOvFLgcL?=
 =?us-ascii?Q?VcRWHuuJYR5gjyAlqZ9GoQMbPIwpAkaMiyWcfcCKldVBrvvUuB9tbDwdlidZ?=
 =?us-ascii?Q?eVSKE7N+y98n2ISoEAqhT7ahdnN+1+lbj/0yZ8ojBCofA+7SdexRUjyCE6Sb?=
 =?us-ascii?Q?NkZ8I+yC6B8LyIVbtpktffEEg4ReA95zb0HR5YC3qOMRUlV0kXlTfh3FvRxb?=
 =?us-ascii?Q?Ss/AvFSZ9QMBsT80rUBSPfCmXZTzxJFsmgsy8TyIvqPGtI66Gba9NghZgHeN?=
 =?us-ascii?Q?DvhfvGbx9IQCbxGNpoxZ2GrUCaOd8PTzv389ckFdFTAYN0hjOm5F8jXwAbip?=
 =?us-ascii?Q?/l85Tg7IzZ+RDwH0aFPQw7f3AXyyJ/q6HWa+ZpiWSPJBC/JhI8VfLxdZ5Z56?=
 =?us-ascii?Q?4HIiH0vxdCuFqSMj5fGGBqOccQN0jVaLwJInznFEAIZQCIknImBuOPREeeRG?=
 =?us-ascii?Q?WXN95zSE53OZX0/UMO52FxWfZH3yuecpaDOmmAr9jmhQn7fhUhrMMSA4KeyY?=
 =?us-ascii?Q?BT3ege4A7h1xA/HNhgtAghFaj6HIEDcfvs7/VXW1/pQKT/ZkEq1SmOdA3Nne?=
 =?us-ascii?Q?rDijPUDblPjiPa5Pwxj8ghDOTVYhoBw2iNtNMSfLt9mNoIRN7RhD+9VIckIX?=
 =?us-ascii?Q?l2dVOudOMTVecX+d+EunkyYUm0am/ryLMPp5m9m3b7OyZqGINmplVT0TPGjC?=
 =?us-ascii?Q?Wg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53862b1e-e266-42fb-6e07-08dc348f3de1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 16:48:20.4198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LLfgysveid4d4AHVh32jrC9Ge2S+2W6OLvs4v0gAfXyFJgpWcon7pu4LvHmvUq9htxC81YJFK+/vxriLLq7b4GtPc6e9MccnNYTJlI0o4Ys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8479

Add state support in the stream struct for broadcast source.
---
 src/shared/bap.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index fd29557b1..0a336fc01 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -251,6 +251,8 @@ struct bt_bap_stream {
 	struct bt_bap_stream *link;
 	struct bt_bap_stream_io *io;
 	const struct bt_bap_stream_ops *ops;
+	uint8_t old_state;
+	uint8_t state;
 	bool client;
 	void *user_data;
 };
@@ -1271,7 +1273,6 @@ static void bap_stream_state_changed(struct bt_bap_stream *stream)
 
 static void stream_set_state(struct bt_bap_stream *stream, uint8_t state)
 {
-	struct bt_bap_endpoint *ep = stream->ep;
 	struct bt_bap *bap = stream->bap;
 
 	/* Check if ref_count is already 0 which means detaching is in
@@ -1283,14 +1284,6 @@ static void stream_set_state(struct bt_bap_stream *stream, uint8_t state)
 		return;
 	}
 
-	ep->old_state = ep->state;
-	ep->state = state;
-
-	DBG(bap, "stream %p dir 0x%02x: %s -> %s", stream,
-			bt_bap_stream_get_dir(stream),
-			bt_bap_stream_statestr(stream->ep->old_state),
-			bt_bap_stream_statestr(stream->ep->state));
-
 	if (stream->ops && stream->ops->set_state)
 		stream->ops->set_state(stream, state);
 
@@ -1527,6 +1520,14 @@ static void bap_ucast_set_state(struct bt_bap_stream *stream, uint8_t state)
 {
 	struct bt_bap_endpoint *ep = stream->ep;
 
+	ep->old_state = ep->state;
+	ep->state = state;
+
+	DBG(stream->bap, "stream %p dir 0x%02x: %s -> %s", stream,
+			bt_bap_stream_get_dir(stream),
+			bt_bap_stream_statestr(stream->ep->old_state),
+			bt_bap_stream_statestr(stream->ep->state));
+
 	if (stream->lpac->type == BT_BAP_BCAST_SINK || stream->client)
 		goto done;
 
@@ -1942,22 +1943,25 @@ static void bap_bcast_set_state(struct bt_bap_stream *stream, uint8_t state)
 	struct bt_bap *bap = stream->bap;
 	const struct queue_entry *entry;
 
+	stream->old_state = stream->state;
+	stream->state = state;
+
 	DBG(bap, "stream %p dir 0x%02x: %s -> %s", stream,
 			bt_bap_stream_get_dir(stream),
-			bt_bap_stream_statestr(stream->ep->old_state),
-			bt_bap_stream_statestr(stream->ep->state));
+			bt_bap_stream_statestr(stream->old_state),
+			bt_bap_stream_statestr(stream->state));
 
 	for (entry = queue_get_entries(bap->state_cbs); entry;
 							entry = entry->next) {
 		struct bt_bap_state *state = entry->data;
 
 		if (state->func)
-			state->func(stream, stream->ep->old_state,
-					stream->ep->state, state->data);
+			state->func(stream, stream->old_state,
+					stream->state, state->data);
 	}
 
 	/* Post notification updates */
-	switch (stream->ep->state) {
+	switch (stream->state) {
 	case BT_ASCS_ASE_STATE_IDLE:
 		bap_stream_detach(stream);
 		break;
@@ -5243,7 +5247,10 @@ uint8_t bt_bap_stream_get_state(struct bt_bap_stream *stream)
 	if (!stream)
 		return BT_BAP_STREAM_STATE_IDLE;
 
-	return stream->ep->state;
+	if (stream->lpac->type != BT_BAP_BCAST_SOURCE)
+		return stream->ep->state;
+	else
+		return stream->state;
 }
 
 bool bt_bap_stream_set_user_data(struct bt_bap_stream *stream, void *user_data)
-- 
2.39.2

