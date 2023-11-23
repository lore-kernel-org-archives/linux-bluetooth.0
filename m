Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UoN4Ztog"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2051.outbound.protection.outlook.com [40.107.249.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813FFD62
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Nov 2023 13:59:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6od9DiSD3Kc9uOXFyJLXqeJpSF7I8irLAhgul0ihEPyC8iBazzYzBRANq+5NFFN4WOaNhcY3DYN4/newsn74EltRNKyIkBYKL7r2afxhJJ1oexOqUf8SPL4yd6BaMkYDWaL9cy2AbaVwKG6MvPeEEyYFCzAum0j3zQAIJMt0bhyuqWlihrLD7aC27Kvsmc+N1VE5ogXf9jSz5SkRFWQAkq8zbTSh++BC5J9vD/Z7Hjahn888TztaOxP4slPSNQKaKYDh0u823FcjeiACCiJRSS9+ErwJu5ZRREf6ipxL7Wg1RUvmIopah/sKLzcapHLSPNycLA4lSQS99OJB3iLaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWM/uQZU9RxfJdKvLLiJrUcg9hwoKwESBKE1PIF6FLo=;
 b=ipvV2L5EbY5JN6e/bj3OZwtCItUc1+GjELVzadU7NjZOlU+T+/ZXs2l61vVRJRSyhhubDcctb5V+EFujWJ6mgkRL6KxFQnip1PPcv7jv+4yZ+zibkQkeG7a3xFIIT/zVxdBappewQLorAtXjnPGVdWcyEC/bGQAtoXlC8oA63Ju3qBpD+giuwTqz0nmtGHGWxzd0bXl36UMDguxmAfXTLaJaAuq6twXvl8x7GV+t4rygQuRkpnaY2DT0zePW/KKUFy37szVTqTvaIICXAd1TDCoYUIbQkGg5eMp1InQCrDNs8YbnQm3Gh26Q2gbrmC1W/t7wda29BHkh4Z8L7dnbhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWM/uQZU9RxfJdKvLLiJrUcg9hwoKwESBKE1PIF6FLo=;
 b=UoN4Ztogl69gKK6GOiHgYzbSHop3h0PQ99UVYcH5pVIq6ojVd2hF3OCX+h6SmYAE9NsVYk0wcAx7F8JoDfd5X4Ro51xga4ZyKE+w0+pPcsK8p5//t9AN8hZ/LzGQDI70NtvshprKKycdKtoufhLitpyFaXvpLXFTPtPzRqg0zSQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by PAXPR04MB8335.eurprd04.prod.outlook.com (2603:10a6:102:1c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.14; Thu, 23 Nov
 2023 21:59:43 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c38d:98a0:a823:d88a]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c38d:98a0:a823:d88a%6]) with mapi id 15.20.7046.012; Thu, 23 Nov 2023
 21:59:43 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v6 1/5] shared/bap: Fix source+sink endpoint registration
Date: Thu, 23 Nov 2023 23:59:31 +0200
Message-Id: <20231123215935.73501-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123215935.73501-1-silviu.barbulescu@nxp.com>
References: <20231123215935.73501-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:67::19) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|PAXPR04MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: f3e5f544-e472-4b3d-0811-08dbec6f7fc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MRyrmE7ebbDnnbKIf00ojRsxpZOedfOTMw/Lf8A6SSOuD79ynQDZe8C5AA4jucoG2RWYMTXBBR4vHy0dxLKWr1sVfMTzFpf9YhGG5G+6TJy80K3vRlns87N34tMZURYefbYENU1hgkUS3Dt/FuSSdWPwyoVWyPWeGy+HoVpCGhbAZG5mP4IwTeBv9NeybqDkcJP6YF/3c2D48xvLKCr85Uc2pOC2cPxsPXJaFZQtDpapTlqsiPJywWovJ8kNJhNsKdQA/1plHItn/iUCTdM5MESJ8Ijm5Rj4Ncy2G4MjBDDy2KG+s+VBwfr3uUP+oBdvKcLqWN6woRYx2Wod/6R1jxmapRXLp5S/tYy7gW8h6ipG77thod4m54iam8JBH1ARLIogN9ypu+sOIDjm6+FR8rUfltY2ulVuQQcry3FDgv2GEOZ1Ryqb67Y+jcxCVw2GZ1YtP5BzxLrLlqpwZblsxQuDNfxaCIqXAwtc+t9+UIIjp40QT3bIrc8mILeNHkChSn6A/gy4MdkbmWA9Lmfm4PmDAQ2gAJsuujYYXxztRwqUOGct6UgqgjigB5a+gFCY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(2616005)(316002)(66476007)(6916009)(66556008)(6512007)(1076003)(26005)(66946007)(8676002)(8936002)(83380400001)(478600001)(6486002)(6666004)(4326008)(6506007)(5660300002)(2906002)(38100700002)(41300700001)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rF4E2bN+tDxSXhdFVWiT0sQ9ACZHF0MShLhZ75QKkkVxfbVk5tH27LiZlkTV?=
 =?us-ascii?Q?3iV47TmUN28ULRj87VqHklAO5ww1f0VYSf6f9/fS8ORXe0q3rtTNJ4pXa/9K?=
 =?us-ascii?Q?MO0eqNlX/k+5hRLoFrQDnxCXtWajrLLuywfofA65hpSZ0wFQ/lL9Ot5OdUvP?=
 =?us-ascii?Q?UaDgtFxuaNCWq23sMvD6gTumAO4iZJmH6+DZf7E3H4WjlQuhYrpauutI7xTq?=
 =?us-ascii?Q?eIpGTPvCs/ihYO3KtBbk15ScltUPGZlN+PuyiNN+G2L7g4QynUBdKOGr10Lp?=
 =?us-ascii?Q?LRv4d20yBiOi4+89MiD6EyYo43iwl6LqiIoN7Rm9E3Q0xSDXd0/Z2KzBjsPs?=
 =?us-ascii?Q?qjP3wp8UMkzBZzZOTfSo3pkpBzSs1DKcYRtMndGsF06wMFQXtB4prWrcrGMx?=
 =?us-ascii?Q?LDU6qlgcxSrd/ujre2zMJJ5vUOgdUEyNDL0gsUg6lQ749swpxmBINNDXRAlG?=
 =?us-ascii?Q?Lx4u4PBdT2QFl4GDoRHzBhs7MkOb1Xzb9CpJGd65bo7FQkWnINsyBNjr016R?=
 =?us-ascii?Q?KncX/fhGa58/MVov7z3UBuZ8+Ny5TQQ56dxPuGAh5SPcL54fzGA8CnbnUNY+?=
 =?us-ascii?Q?Ld6/7RaJIeJE6k7sF2REyZeeSXDfaPPL2UTvoMR8sZ2A4oY95Tp8Evt/BI+E?=
 =?us-ascii?Q?KSd0Du3OptW3l/q5wGOmZbO602AsdG1vWf27fkPKPUf8NLQGQkunaKeGUv8f?=
 =?us-ascii?Q?yMh0NUkCU9fK9I5iWNXTTLMEFHx7MAbXk/FRh+9uZY/t4Z4N6JGN79vHj+AY?=
 =?us-ascii?Q?vkwUbzL/kfltc3UbJoOyvaRau0sat3C47TxKw7ijRXEIYm8jaBjt5GbsAsA2?=
 =?us-ascii?Q?z2eULUk59gmtikkmoldvQ3yNn47BN3EDQY9jSRWv9RxZcwgQAwlMkiiwfTov?=
 =?us-ascii?Q?eHwcasO1wjU/xwsJz3GlQISoL+AuFGVkXBcvZCBAPtZnH3pStIu6qodJ0Kze?=
 =?us-ascii?Q?oikChMaDVhvzFu4gvIEVOPy1/FZkoQc5kH6FBa7s/FrVXOahzrwo9nlqw04e?=
 =?us-ascii?Q?I2596GHfvqOY9d4XX8MKuA+LHlQSNe/KuwUsZWdKV+qMjTuLEy+iaK8GHpOm?=
 =?us-ascii?Q?JiFmLYZ6uRLD1ljIqi+mOa5Dt0ZKxyPCsFWvIGScxbtsbuuUCAuy/g1/vpCy?=
 =?us-ascii?Q?mqsT5xOstGFrY1z9sZkk4VU8tN0aLHc92CC0k8nuC1BENNu7iJ0ZpQmtKWAr?=
 =?us-ascii?Q?hxtKcRMgv5GuXSFdEaSJutVHk9sYwIfDY9GNCgHRZh/PVrH2bJca+HeoZBSn?=
 =?us-ascii?Q?VQt1wbpTZiW3+pNXAqO80x0tS0YiII6DSlUwB3egRSRQB0pTZJFpvRrTFqh5?=
 =?us-ascii?Q?UcIzMYQcnVVSGZdyvxi3xxjYujxzYFfyH84UloRgZoZW0hFAUfodJIOwwR+/?=
 =?us-ascii?Q?aos4rP2V7Hc1qYaFVf86PcBwWlElAgxVPPK7leEDp6zNhYHsBEhcJJ8I6ENq?=
 =?us-ascii?Q?e98rANyHx5PfzuLAJtEqASb9m6u8DWQQN6/JFYPJjj/SlZEUfFxKbXLSAL2y?=
 =?us-ascii?Q?Bz+pthJIfKM8y8Qsz0w65PHdqxhZxqECqFVz8MADqeYzsPrwkB5Ckc7kHxwB?=
 =?us-ascii?Q?FfswJTooulGc7hwKUDvoSjalV9+ZZBBZT9aZprn5Dq4WZQtJbvS/JEmf5pB4?=
 =?us-ascii?Q?OQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e5f544-e472-4b3d-0811-08dbec6f7fc6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 21:59:43.3466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83c68Rwp3UChra45k+nOvJOO7m7XNVrlQrWqEqzmr5hxKIYEHvmQaGIUbb01pm/61g9cZPzBH6ZPVy8eN3NkQN7BVCzSnK3N7zdm+oYm6xA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8335

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

