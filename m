Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PgvuoziN"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2050.outbound.protection.outlook.com [40.107.15.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EFDA4
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Nov 2023 07:10:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GViHS4VeHCd1wXR6g2h6k4YkEa0WUID2rP9OQ8OSieV7nNqUjlEzpHKe7kEwzor2rpsHiAEcu9twK8U61oHkQpuhPvLZuV3Llitivh/qlhMkOc60pFAOh1War7J9IcYehC7U2pNZFyoaueveZLvQztmee9PYw5UidhgezTYYLcF8e23bnO7lwHlwKSGTopzdSudK+gTa2GYGKZnG0uDB6F6C6PsR9JY6xcIGY9gkVJQZS4uLmaFHKe3cum9JAadk3myaHBQJyZPDF6WQXsCZDPpvYcKVLhsiFEqTwyCsfTW9k28ofKDnwDVDNAY+lf5Ga+wmGujkPSvgZTTON4xyng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWM/uQZU9RxfJdKvLLiJrUcg9hwoKwESBKE1PIF6FLo=;
 b=XFIls27MdBO6F5GpNF8+jBrifrd6bZc650u1jjJudfNzO2AgEr8E0eZ1gRTf6ZUeQFTWN4sAn2x4d/eua9n6HmICYg1He3yQIV9/5h6o0/o1KwS1icp8y+MaReU79uJzOnIVdMg/1gcVWVlvjllFVPf7UbIEziZ/636GysJ/3KZYzeFJiltDm5Hbkx9ElJVrQrQy/KV/CBVvv46uIIYdHEpWfg3idxlD8I5N/2TjWvAOhurx9REyqqTQGLzRaNr4VhDjvJ8fT4cre8n+WRprjHlccjZ7qzNabCdkT+aUnASoE5c2uWfvcKudjUNpObxqyxJF4RWe0+oEhbdcE1c6HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWM/uQZU9RxfJdKvLLiJrUcg9hwoKwESBKE1PIF6FLo=;
 b=PgvuoziNUfjUNuT+dHhLP1nw0Ll1eDDvUHy8LdyJMkFe9sz8ZTqABaPLXFkoV9nsJrwvceMHLPZmAJ2lD8D/6JrhRJBy76Q2psAJSuUMyWF6hSKfVHjAk+51sCH1EYqKFcGJshYpHMZASYXk6d5NKBDjJO2t+X8hplZC7gGV3oE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by VI1PR04MB6928.eurprd04.prod.outlook.com (2603:10a6:803:12e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Thu, 23 Nov
 2023 15:10:40 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c38d:98a0:a823:d88a]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c38d:98a0:a823:d88a%6]) with mapi id 15.20.7046.012; Thu, 23 Nov 2023
 15:10:40 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v5 1/5] shared/bap: Fix source+sink endpoint registration
Date: Thu, 23 Nov 2023 17:10:29 +0200
Message-Id: <20231123151033.22898-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123151033.22898-1-silviu.barbulescu@nxp.com>
References: <20231123151033.22898-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0012.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::15) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|VI1PR04MB6928:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cc3dc02-8cd2-47ae-9613-08dbec365af5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e69WTR8fwODZ78El2v+ywtRE5Fvs3RhBO3uV09EYxJAkTTeBVeNDTx6QcoOMbhT1k0usOwn3fAv7u2EPG12udfopRQFDJvsMkexaVpBZpX7csIotkGnurrX6XFQAouciZ0b18T5HlrqW8kT3qNnDQs2whq9KtPOxKPaFD/3xCaaQokIL32DItOWTz5oZF+9HM4ZqMUKXStoIEhwBEGeqSXLrumrmOtPZqQ1aZRzNqMc3UiBjM9GXO6W4kR7qrQB32iN5GFS0dNfnZH03nDVEb3kDjNK357UHsW3/Pc/z7W//xsGrEKg7u86RfMTx3r0VrPhrHWYyVe01NS9Pxp1df0zUQ8+cY0Ic5zNftVAtGNb8qS168FH5JMLIPVQ7l3PzP7ElTTBZb6qAOiWFTCheVhKHSjHyRSrhOApfMUYTalAcl8Fc1fIkRk91tjSle5uZTax+GrqFQjjIlgvseBkd+ZkQ/yETmdfvJ8CRPPdNgDWJ30HvGwN8cxXvOrvybcGl68m8ckEbI7/5/zxlowvnNNJTrKHsO2SRYhJDqBk+29WTg6UYVj9p1Vj07AZ7+mME
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(2616005)(6512007)(6506007)(26005)(6486002)(1076003)(8676002)(8936002)(2906002)(5660300002)(36756003)(4326008)(41300700001)(66556008)(86362001)(66476007)(66946007)(316002)(6916009)(478600001)(6666004)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UY8+fOThK9hiGpdSfs3dt8sG0qUPu5SbHhGXLVsX3Ti/1ymRX9Ae95TFVhmK?=
 =?us-ascii?Q?rk+1p1fKY1fdiFj51IYpsDmy+zpRDjmFz56u337TUUsLZ45S+DvpdFOhA8iL?=
 =?us-ascii?Q?K390AF1/iD4MCWfclXvZKJzcvVadukMeqd+JgaKkGDTyMFBXhtsCJf4zW09G?=
 =?us-ascii?Q?LLRKrRWBG9XItvYS3XsT4Vv5xpJERczPbK9PL0mgO4o4myWt4B+cCPLaXKYW?=
 =?us-ascii?Q?rZqoLMxNvdE7qvwVUENcI/+fdPmgrgLXEuK1h3genqrX08bznxH6WhoVp7iH?=
 =?us-ascii?Q?URJo9WnMpWKPhZkSbRFjvJoMRmMgN8etI6DozpAXUstdYAzhTCsCcm+QT0xK?=
 =?us-ascii?Q?wf8UbahopZMli2hx1Top19ta4urj6+OUanj63g+LEm1bE3G2L9v8G+LSyLtn?=
 =?us-ascii?Q?GhdPvwTGdfhZwful97cvJ6TYKm3Po8kfxGm1UIN2/YjIGX9IevJLAZ6gs+NQ?=
 =?us-ascii?Q?lpohxv8Cl0Z4wy3yAXRYEbKMgjTMt2nwKy2Gw0vPsBYEulmUpnTIYf9vIB9+?=
 =?us-ascii?Q?XeOk92h7jePHXzRSlwx5DYqwTZGolZzEtlCW2Za+PLXdFu3wlk1c0+kftYUE?=
 =?us-ascii?Q?amuol6jdobshNhecB4SlQMhfAixNIcB6lqeGWrcdKsaXWYLs2xOKCN0piSFE?=
 =?us-ascii?Q?Ai3RoUF/66xIJsmkxad0IAc5NrrYOiHF84bxdhKXqsP1WmRvTjmEerJvFWPM?=
 =?us-ascii?Q?2K9NxEbRLcFl7xrOQuKCeu1NxtTrHEhEGZx99yoD/mfavpp85IiFsiAIxMRE?=
 =?us-ascii?Q?1W3nNpJhs/8RGopbVl8jh2TuCB+Np5hkPB/vDs2NGpMnwsS1o3C8bT+ogRFH?=
 =?us-ascii?Q?i+p83S17CSNJvg9QOrZK/8toDVo6y1HORaAccMYfgnMI9UF4NYFPRVPBJWT8?=
 =?us-ascii?Q?Z0cK4FcIF/5dfslW/HFxlWrAmthDAph+mqjPvjkDmL6N6Oog9BETE91S8eFX?=
 =?us-ascii?Q?FBTmClixapnVcXGhjL/AKeX0Z1KtxZH/0NGMpYZH0JTXDAA6Ee5kNiOaFGda?=
 =?us-ascii?Q?zBJf125ilOvqcZ46B5vlK82mBk0K1gItHKuT9hHw/NG7BC/L/Pj3QaijNswW?=
 =?us-ascii?Q?szifCX+IsvDKvMLDW4wL/W4LWh3repPyuoU55XwY2GNvlMRt7pAFeMVnEw6j?=
 =?us-ascii?Q?E1jl290q6era6JuS29RAGhkvmpBapPXOiUBwBy+exuK85Nwmo+jSll8G8+ry?=
 =?us-ascii?Q?RBE5BxMvsEKB9ElKxhRMWaOu1g5mqjiCxbpgMKqy4Zi195ioxggRL3T2Uf4L?=
 =?us-ascii?Q?rD6uvue/AlNeFh2DLW8q9KKTOafJYK8Y0h34vGyAeKfXwFtk/aH3S6NJBNEn?=
 =?us-ascii?Q?hIyut+STfdgjldQU7iBIUHNW5z/Uo1Kgdy9Wu6mXrk5RQYNjXJoduFn7UDmW?=
 =?us-ascii?Q?i6+fHH+yhbAYSivKlYhozj+TheoTNcuYx+F8AO217EO5U99alT74AIvQcD6k?=
 =?us-ascii?Q?VqJJFXlL5UjUXsLWKIe2hSEqfkKVQysCOJ4LIGOys3V7IaoviXNW9ag90+NU?=
 =?us-ascii?Q?peuF33euE3OmJKvQToghl0HQ0UKv0V8cPji97EapQ47gI00g2o6Cy3NFWfba?=
 =?us-ascii?Q?BrhLCaWeofODbh1NaV7Ns1ZcHgQZsUEYaUKQJHLWzqKcpOg9sLdCnBZgV9qD?=
 =?us-ascii?Q?Dg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc3dc02-8cd2-47ae-9613-08dbec365af5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 15:10:40.3012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E0YMQLljn9IrzT1ZXPvd4B55hrXh21txTHsUhUfvVJRPwF6np4ETM+Lc9pltwwrgpD50hdmg9Xl/iXGlmiq92tU0eVIfZ9poI7rkFwUx29k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6928

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

