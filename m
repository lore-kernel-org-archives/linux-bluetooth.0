Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dB3s+K9U"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2076.outbound.protection.outlook.com [40.107.6.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39619D0
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Nov 2023 04:08:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0jyJ23oInf3hH/GeMqLqEESpU3+jGELgFUuM7rQCpdwtfzPA8ssnU1CqB6SvcGpRNYfI2+4v27lfMBfNfXsZuu1XK6CjV29rFIhubBDZR9kINzt5G7QLE5i/0sg55a1uLZqtP9mQ27BfFPhUsL9xqmZdlElWU+aeaXfTHOqjGoAKCLKh1FA4hHVqJVSxeI8R9hUfijRpy2dWjx0K7sZEEKSoztM56sIUFWFZuIjgS2eDnwozCKTnNEQwXTmYeOHRGaCfEiC29XY8dTBgSclROFqjiHKeHcTsx0a2fwdAz58kXmd5c6Xjp3DjD+ytR93+YnW5dqEsXcXdIgB0L4ERw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWM/uQZU9RxfJdKvLLiJrUcg9hwoKwESBKE1PIF6FLo=;
 b=QvWkmU1hgI2dH3zN6uk/Hc5jJlBovTQzgFnJ46Dqcw5i6L2WeVj3/5U9WYT1zTRXXgo6u2Rn5J5uCMVQcYXh6+IDQ6q3kFKlWOby5HPv/RNptfmubWayzMd58FnkG2wj87jg8mx6NKwTZzyJ3hFDzNnlPpKMq6mD2Vjs5TNdIBqxYC70yW80lBmQJRhMskRT8HQOmOvnrbY0+S1mvwyE8mKDYKwUzyJXiRrVJytp5vf4rFYTn7GWm0ve5wD2qA1bj68Yvnou8pWgcPRcESk9oQyAMHbyRfoEkBEcYRdobJ/YdlrVdgtbXJVyoq2EHUNCEUDf5VOBSpfuOHMCtmo91A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWM/uQZU9RxfJdKvLLiJrUcg9hwoKwESBKE1PIF6FLo=;
 b=dB3s+K9UyRCYg3oT8gsI1XA0EQx2DwDoHpcus3r/Ged4z4JUw0jk61CX4kWSu1Nc6aUf+XXFngD7jYCy+E3RgA9Ow1wg+2o9C3fflm/BLhkEeRmWo499pnzszgTrTPWmSBt2zZpHxBLwY3LPCxDCGb5QmX0+dcgMN1vNq8hM/UE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by PA4PR04MB7966.eurprd04.prod.outlook.com (2603:10a6:102:c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Mon, 20 Nov
 2023 12:08:38 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c38d:98a0:a823:d88a]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c38d:98a0:a823:d88a%6]) with mapi id 15.20.7025.014; Mon, 20 Nov 2023
 12:08:38 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v4 1/5] shared/bap: Fix source+sink endpoint registration
Date: Mon, 20 Nov 2023 14:08:27 +0200
Message-Id: <20231120120831.5353-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120120831.5353-1-silviu.barbulescu@nxp.com>
References: <20231120120831.5353-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P189CA0022.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::35) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|PA4PR04MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: 28014595-68f3-43c7-6ef4-08dbe9c16d8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KdAr9r4iKW7KGBTu43Do8SqM18C4D9qTGCrPqmGswvczKKFd8z//gM+xDh7kXIErOvAXpDL5WVCEEgMeKyYwm14pzIQom6fCn/yNXGn8gUBmc3j2J4GYz0p41ST6Lr8fIaFw0uwiTPmR9L4ejJjkvLSKYU80zKsvlepEAfERox5wCAGZAF0Dpjp4poR2hCOeHTBc52UT5MJ6rvIYGwpcs0hCPF7fF09TXkMD2wAYXZcfEERUId17dWr6rIC/h/TN+oBu8vawJAYKbgvCFnhaWd3VTCHeZ+iHRUVawUwQ+ZCaWxY1cyYe0LK5wwyi34dsXucRB/hTeCj1ClKXwnqKfsqpaq3b1A32xl9fT5ZeFSkTIjp/FzjlY/YkFDzOX2xP/PNjBqcOEHNqcsdBkwWNTvoHjsjX6mepplztOFEP4ClGvkVDuEL8gJPSXMmJmH3D8QicaLTiYVr6n2ZG1iiXgNkYHEx1NoXcO6gkl96IMLMTbdrMOYq49cA4HMw3CaAWBdC0KZWSDK/MUWYO4ttIiqOJAYGs2fN24KlLD1FF5RvXK1sWumKu7TQBEZU0PypE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2906002)(41300700001)(8936002)(8676002)(4326008)(5660300002)(66476007)(66556008)(66946007)(316002)(6916009)(38100700002)(6512007)(36756003)(6506007)(6666004)(86362001)(6486002)(478600001)(83380400001)(26005)(2616005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3/v+TKU1DlXmtS/OR7t6d985/MaMclyrFcY47ExBbQJ14IhMO/sRjb+X5mzK?=
 =?us-ascii?Q?pcXaxsHVyebmZqOKN0uRJJOKAGeJx2j2W2/0aXXY1CYrCBHM6Z+sRSiWhQbB?=
 =?us-ascii?Q?iZSlirBnp+yNWFRoXdQAfKsemU88H52BYcG2WC9jXCmX2vjVT+9BrTEjdryK?=
 =?us-ascii?Q?ObjTjjt5Z961sUbIx7VtOecUtYUJDBAWWfb2HGzWFwJHaWYoTxZLxafTajtt?=
 =?us-ascii?Q?EbsIwzkslcwoIOPbOJwINcqKkAx5AMSsm+wCXLXAj0vUoGCVl58nLY5uZ4W/?=
 =?us-ascii?Q?pnxe23rlFdWTVF7p3WeCFwo97zMqZrHsax9zrK28/WQcAMZeJhJaBa4d/qoK?=
 =?us-ascii?Q?x4BuQbnZ05vnmCPSIe9aOx7fdEigvzpnOmFCaQYmCe10eX9YojNbQvU1ssRp?=
 =?us-ascii?Q?9+BSAPSGn58dd7RJ/l/izqQ53ZdFpLEF06ONTVbuSfpKtp1vzug7KrCwQtMk?=
 =?us-ascii?Q?uy9N1jxBNI4pzyBhU9SNRbf8XohPciblGrQjYyZcPDvC+vjLP4gOlptmJgbd?=
 =?us-ascii?Q?aDNDTLmwUpk9Y8fISuc89jF8/1ufmwhEf1VVjaXpxKlIDhrhMB5S3wB8Ptwx?=
 =?us-ascii?Q?vxCQUcfpIgArYbZRTxHg2CCDjdZu2sxTZNvMvC29PfUvwRZfXeP4Y8rE+O+k?=
 =?us-ascii?Q?0qbC7fpMzeLZnCTs0BTzq/k2kG34zga9fFeopBqicIszkh2ikV+ORhM+3bLv?=
 =?us-ascii?Q?jy8RzVvQb8m/QIA6wKpkUXmhPlG/TyL6aZXbMwELcdPusPlmdHnLfQlEmYgN?=
 =?us-ascii?Q?llxO3sSyg2GuZs1CviAWfRke8Vy2yHkt8Tokqzkp5uGA/rHAqtTuNyfw1fnt?=
 =?us-ascii?Q?EwZv4ho/+862Tj9iuRPhQo7AKhT5nqqv+7ws3yh+NRWCWYXjAd6MJs71rrxf?=
 =?us-ascii?Q?sGAyqJycWN2oXIprmfywpqQOorH9MVp9Wdl+Krfh/mrTilYJRZE1GCMty1WS?=
 =?us-ascii?Q?zM5rO3GUSPRyqSvJV7zN4/guiLsXgVk+brtBaFPwFk+nOdicNVPJpnXrHmSY?=
 =?us-ascii?Q?NlfiRqoWFPCzu1l8fzxtL9Xp10yjmJ7o4CC4eeEbFNXx+s37HT3Sk6+hz3lM?=
 =?us-ascii?Q?BLwBt7as674/G6urfzfbydhG5EmBdgF7ErRZBS1PrY4HJQSJ4o0NbL5VOElW?=
 =?us-ascii?Q?wJ/FTVjBY9MUQBRlMfeuZH2pKophP2CF/we+MXAxnZOd7Fr6w/4GvyMeYXt9?=
 =?us-ascii?Q?Y9l7E2CQXBJVt2NKLK+E0EuNVlBsIO0AofL3YYwtFUqqXlzGqtJ/4sT8kkuJ?=
 =?us-ascii?Q?TPOCw9OpTvAiEpxZbfs7trsRCYnnfBKSXQ2YSotKwtdKyBO6ARKLUyALpxab?=
 =?us-ascii?Q?nttf+X9fuOQdAI7RJyFOZt89oRSrcbEhTlLpT6bAQMpvbpJetjWl9kc+F6ZB?=
 =?us-ascii?Q?OTTyV/SPoQa/BD6Gbv/khvekxcbgU9OOxjx8hso6H6YommhRdOtBxh4WQn2b?=
 =?us-ascii?Q?/hdDQUP4W/m98q82J4OKxFMBCwinussJtAnhQNQhJZ2IoCdiu2kZXekFGg5F?=
 =?us-ascii?Q?ixlQ7Jtf9wqg28sjeL7N+fApwCqSPvPpIamiFTPmbKhWnJ0Is95+QMZpEfyo?=
 =?us-ascii?Q?0u6lTBHcgrPbqpU0J5fwY5P7DaTfVt9fdNCqb2KctcQxuC1c8ydRnqzuPtmw?=
 =?us-ascii?Q?ig=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28014595-68f3-43c7-6ef4-08dbe9c16d8f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 12:08:38.0141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XKhJors3PEVbRbLLpYQp2ZtmCG5Oo5n5h00rgN6Q6SUhttlqEztM164mY/f5Slqr6l+rZN0Ca2s/HEoQxvoJj3+71BrgNNpY98T6I+QsiQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7966

From: Claudia Draghicescu <claudia.rosu@nxp.com>

When registering both sink and source endpoints,
the register endpoint method call results in 2 remote endpoints for each
scanned broadcast source

---
 src/shared/bap.c | 73 ++++++++++++++++++++++++------------------------
 src/shared/bap.h |  3 ++
 2 files changed, 40 insertions(+), 36 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 13bbcf793..d8a3adde6 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -629,7 +629,7 @@ static struct bt_bap_endpoint *bap_endpoint_new_broadcast(struct bt_bap_db *bdb,
 	if (type == BT_BAP_BCAST_SINK)
 		ep->dir = BT_BAP_BCAST_SOURCE;
 	else
-		ep->dir = BT_BAP_BCAST_SINK;
+		ep->dir = 0;
 
 	return ep;
 }
@@ -1485,12 +1485,12 @@ static void ep_config_cb(struct bt_bap_stream *stream, int err)
 		return;
 
 	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_BCAST) {
-		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SINK)
+		if (!bt_bap_stream_io_dir(stream))
 			stream_set_state_broadcast(stream,
-						BT_BAP_STREAM_STATE_QOS);
+				BT_BAP_STREAM_STATE_QOS);
 		else if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
 			stream_set_state_broadcast(stream,
-						BT_BAP_STREAM_STATE_CONFIG);
+				BT_BAP_STREAM_STATE_CONFIG);
 		return;
 	}
 
@@ -2622,7 +2622,7 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
 					struct iovec *metadata)
 {
 	struct bt_bap_db *bdb;
-	struct bt_bap_pac *pac, *pac_broadcast_sink;
+	struct bt_bap_pac *pac;
 	struct bt_bap_codec codec;
 
 	if (!db)
@@ -2650,15 +2650,6 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
 		break;
 	case BT_BAP_BCAST_SOURCE:
 		bap_add_broadcast_source(pac);
-		if (queue_isempty(bdb->broadcast_sinks)) {
-			/* When adding a local broadcast source, add also a
-			 * local broadcast sink
-			 */
-			pac_broadcast_sink = bap_pac_new(bdb, name,
-					BT_BAP_BCAST_SINK, &codec, qos,
-					data, metadata);
-			bap_add_broadcast_sink(pac_broadcast_sink);
-		}
 		break;
 	case BT_BAP_BCAST_SINK:
 		bap_add_broadcast_sink(pac);
@@ -4416,21 +4407,12 @@ void bt_bap_foreach_pac(struct bt_bap *bap, uint8_t type,
 							func, user_data);
 	case BT_BAP_SOURCE:
 		return bap_foreach_pac(bap->ldb->sinks, bap->rdb->sources,
-							   func, user_data);
+							func, user_data);
 	case BT_BAP_BCAST_SOURCE:
-		if (queue_isempty(bap->rdb->broadcast_sources)
-			&& queue_isempty(bap->rdb->broadcast_sinks))
-			return bap_foreach_pac(bap->ldb->broadcast_sources,
-					bap->ldb->broadcast_sinks,
-					func, user_data);
-
-		return bap_foreach_pac(bap->ldb->broadcast_sinks,
-					bap->rdb->broadcast_sources,
-					func, user_data);
 	case BT_BAP_BCAST_SINK:
 		return bap_foreach_pac(bap->ldb->broadcast_sinks,
-					bap->rdb->broadcast_sources,
-					func, user_data);
+						bap->rdb->broadcast_sources,
+						func, user_data);
 	}
 }
 
@@ -4475,6 +4457,20 @@ void *bt_bap_pac_get_user_data(struct bt_bap_pac *pac)
 	return pac->user_data;
 }
 
+bool bt_bap_pac_bcast_is_local(struct bt_bap *bap, struct bt_bap_pac *pac)
+{
+	if (!bap->ldb)
+		return false;
+
+	if (queue_find(bap->ldb->broadcast_sinks, NULL, pac))
+		return true;
+
+	if (queue_find(bap->ldb->broadcast_sources, NULL, pac))
+		return true;
+
+	return false;
+}
+
 static bool find_ep_unused(const void *data, const void *user_data)
 {
 	const struct bt_bap_endpoint *ep = data;
@@ -4483,7 +4479,10 @@ static bool find_ep_unused(const void *data, const void *user_data)
 	if (ep->stream)
 		return false;
 
-	return ep->dir == match->rpac->type;
+	if (match->rpac)
+		return ep->dir == match->rpac->type;
+	else
+		return true;
 }
 
 static bool find_ep_pacs(const void *data, const void *user_data)
@@ -4642,7 +4641,11 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 	struct bt_bap_endpoint *ep;
 	struct match_pac match;
 
-	if (!bap || !bap->rdb || queue_isempty(bap->remote_eps))
+	if (!bap)
+		return NULL;
+
+	if (!rpac && (lpac->type != BT_BAP_BCAST_SOURCE)
+		&& queue_isempty(bap->remote_eps))
 		return NULL;
 
 	if (lpac && rpac) {
@@ -4679,7 +4682,9 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 			return NULL;
 
 		bt_bap_foreach_pac(bap, type, match_pac, &match);
-		if (!match.lpac || !match.rpac)
+		if (!match.lpac)
+			return NULL;
+		if (!match.rpac && (lpac->type != BT_BAP_BCAST_SOURCE))
 			return NULL;
 
 		lpac = match.lpac;
@@ -4861,12 +4866,12 @@ unsigned int bt_bap_stream_enable(struct bt_bap_stream *stream,
 		queue_foreach(stream->links, bap_stream_enable_link, metadata);
 		break;
 	case BT_BAP_STREAM_TYPE_BCAST:
-		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SINK)
+		if (!bt_bap_stream_io_dir(stream))
 			stream_set_state_broadcast(stream,
-						BT_BAP_STREAM_STATE_CONFIG);
+				BT_BAP_STREAM_STATE_CONFIG);
 		else if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
 			stream_set_state_broadcast(stream,
-						BT_BAP_STREAM_STATE_STREAMING);
+				 BT_BAP_STREAM_STATE_STREAMING);
 
 		return 1;
 	}
@@ -5399,10 +5404,6 @@ bool bt_bap_new_bcast_source(struct bt_bap *bap, const char *name)
 	struct bt_bap_endpoint *ep;
 	struct bt_bap_pac *pac_broadcast_source;
 
-	/* Add the remote source only if a local sink endpoint was registered */
-	if (queue_isempty(bap->ldb->broadcast_sinks))
-		return false;
-
 	/* Add the remote source only if a local sink endpoint was registered */
 	if (queue_isempty(bap->ldb->broadcast_sinks))
 		return false;
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 23edbf4c6..2c8f9208e 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -317,3 +317,6 @@ void bt_bap_update_bcast_source(struct bt_bap_pac *pac,
 					struct bt_bap_codec *codec,
 					struct iovec *data,
 					struct iovec *metadata);
+
+bool bt_bap_pac_bcast_is_local(struct bt_bap *bap, struct bt_bap_pac *pac);
+
-- 
2.39.2

