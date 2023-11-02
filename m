Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB39C4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Nov 2023 15:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377031AbjKBP6o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Nov 2023 11:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377024AbjKBP6n (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Nov 2023 11:58:43 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C511B138
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Nov 2023 08:58:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J82enRc4f10usoHoQJV6AX3MQZVyf0VDC2SlHCfUmn9qhI9T8AWALyRpsZ4NBEW1klMAGadWM1fawl47CdBpmxbHRVrWA2irWcA5DPv4N/nfJAFTcexuQ+shz4e8nnsv+rWnG+YikqlFAuIV+59C6/1fTy+uou7UwcsBB39cb3X4FAMkBoivzG8t7JGKjb8YzEyuxGalc+lRHZSthG9Q465D6i2/NvnA4SvzH5rAAkIerYUxXwYNEhZgmeP5x+fI6YDf1v3d/PxdxWmedKu0KIxfJ0TnLxMutWZG1bRUAAu5nbxuJWQkZLedU8N32t5ouniG/38qrNYSE3Gu16Gwow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWM/uQZU9RxfJdKvLLiJrUcg9hwoKwESBKE1PIF6FLo=;
 b=MABaLx8fTEihScQK+bv/R/LhzoyF6qCj1nJ3IAnCOUb5s9MMT7uhE/QYKzpZnJ8PFWkujN92NbkYDpLxcaSmbFLlbZFDanqLxL/AqPxapKrjW8Qcq3fPSKBEPDlpxRcgUmej7xlh+W0ZAO7nJq+T7fpAc1OSaBRZODjNZTwd6E1l2tkATp8Ra5sU+F9VrmCTKEtjfKXRlQhYPmhpz9Yh/MTdNz9oP+e+glxk2CAZhWPvDB7B9cgf1WcZKX3aeo+tFhPXZoRCPC0ecwrxBbVFvbcMt55uNnmA3a27YdWQ5jM6H49jGvigmY6ET4lXPaPOtxrXXSy1i/Szxy8QQy30eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWM/uQZU9RxfJdKvLLiJrUcg9hwoKwESBKE1PIF6FLo=;
 b=D1K9hH2QbiIfX7RC+dL12S3y+z51p1Y7D6ShN4KP1Ns3J1khfNpPH65acBxH7ACq1Brvt+1FuWAjOyDa07dmdFJMGmsIt9rz4Ww+nB3W5bgqwyK6PA98diV6mdN3VwguPmGZ+AFp27P6Au3HxYOVZ1XRtSaL7WQ5XfSA89FlRD8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com (2603:10a6:10:ca::21)
 by PAXPR04MB9005.eurprd04.prod.outlook.com (2603:10a6:102:210::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.18; Thu, 2 Nov
 2023 15:58:34 +0000
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::7c8a:c8da:e6a5:8a4a]) by DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::7c8a:c8da:e6a5:8a4a%7]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 15:58:34 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        iulia.tanasescu@nxp.com
Subject: [PATCH v3 1/5] bap: Fix source+sink endpoint registration
Date:   Thu,  2 Nov 2023 17:58:23 +0200
Message-Id: <20231102155827.4219-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231102155827.4219-1-silviu.barbulescu@nxp.com>
References: <20231102155827.4219-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0009.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::22) To DBBPR04MB6331.eurprd04.prod.outlook.com
 (2603:10a6:10:ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB6331:EE_|PAXPR04MB9005:EE_
X-MS-Office365-Filtering-Correlation-Id: ac2b6407-69a8-4cb4-fd89-08dbdbbc9121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W45NF+bnb5/MlhZJlE0BomyjLi4HLH/gqZ79ri3MYUOG/nPiigfz8fu9+NvOAZjLYmmbep5fan4XwZBRha8t3CPWSeGqn5if3rcCICdjA5ULt/2pnNdm6qOsj37x2KfPEbFfI7Rgwk+fNz7xQwBzM+9aydaZtG8qASnGlSIWqPWxc3fCXayBDki1QCjvrepXeJb1sEJNrI6HKdr01IF6UKHqSAGGvJG4uZe18PmuLPE4MTvBdyFZMoepAZWeuwlufzpJpLVMdw89NRls4KL8XXUXlk+JZkpL6rJmmCQw1oVjbQj/0qTiRiZDrr7qsn18EVg5lm8UzoPHQoZ+8u6i3ZrONgB/CHlP3VK1+Ir5vQxQVsdKZIxTvjpPe/qNX8Qv2u/SH9/ei9N6wEsNFXV3LRtilnOcq69i9zcWdIjOwvgdBKOcsOyQxE25ZhK8uSIjLY83wxEtKhUhG9mZJwZTbNf757KagyE91xVBL66pDt0dH5U1kbWfXDCBNOh0qxPOSHcyTsCf4Rl45dXpWJ/LrLVr6EvZrSM/r3LcBY6Pr4k+VKIreXzgnDTDWhoUoJCj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB6331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(136003)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(6512007)(1076003)(478600001)(6506007)(83380400001)(6666004)(8936002)(8676002)(66946007)(41300700001)(5660300002)(66556008)(6486002)(2616005)(66476007)(6916009)(316002)(4326008)(38100700002)(86362001)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fb/729Lg8bK2QDX864sjN2pQ7phKvT0Vv8NeT8QhgPn0ilnDlbJQQ5Q+Tld5?=
 =?us-ascii?Q?vkWqiabTRfdEU27cTMMcDQUHXz5Jm+R/N1aZlEP0D/bbzchuqQKxYy8UARIz?=
 =?us-ascii?Q?jAK+1jU/nAEtbqHbSD1ej0fBp6BgvA7NcpONBL51JYBh0KjerWwZ30yz+Ooz?=
 =?us-ascii?Q?DbWyKh4j5GR96KmD+zBbntd+q8HAqB5jq8Gy89E6yBJ/RrTV21BPKxxhW79c?=
 =?us-ascii?Q?GVwcAucDcl+fuuxfUrJyeE7IQmnSIRhtuFG+upeiHh/VSms2ryyWBSytgWnl?=
 =?us-ascii?Q?+dTQiVoqQf03/vOUFer4QFrcaswBBxwqxAD0L9T9Cq3wKmAyIIgEFFwigbME?=
 =?us-ascii?Q?WNNj/cSxPWIjxttPQ60DtJ8fktNjF3gxMsaXgbqDpJAWYqYc5LLIgaZSek40?=
 =?us-ascii?Q?vgWodtJcYvE1mrS+H+fG0H6eS+7O/4ggNCtk/YRb5wg3mZb7hMFHkKpxsDlX?=
 =?us-ascii?Q?9f+rqdMdrjXWOQN6p5QyFS2Oi+YsXz4FOA49uxJiaoYzoRwG/sAqwv128qoD?=
 =?us-ascii?Q?MEubBzoxAB0Bpayc39l2FbINhPpcXbSTip3FQ4he8NngJwvJRc/+GJSfBd9V?=
 =?us-ascii?Q?RmARk6TJMkuxTPsZfiR4lNnMp2p0bj95oFZ8Kjr+/WDjFnidZ8mOp3CRjqDJ?=
 =?us-ascii?Q?UyLyYuNk4ndKUJyorAtZdgeiSwEXc5bdFHU1H2Z8Slt+8Thams+isGW9vDw2?=
 =?us-ascii?Q?9JzBEav7xQUVcDaq9yYWosuPFfcwJhDkcl+Q0I59fWtWjCNO+sYN5zeQdQB9?=
 =?us-ascii?Q?V/ak/z45gffjFT1ALfpPK6UYBrM3MOPY20JdvXvwfzmenFnTY4pohJ8FKvXa?=
 =?us-ascii?Q?E3/owyB2depArFOWeq31YNe3gT4iO+i5nTV75yrrkH/SGrbDWcE029wDJVBD?=
 =?us-ascii?Q?mtjUCyyuYRhbt8ElYqULNrkgdHShKAuHPRnKnRrLVpatlg0VbTLJwuJfEwip?=
 =?us-ascii?Q?eltC/42G4iU7W3YeZhVH8R6UTl0ehoA6z7+rOljtak8UBmYfI7sRopQwiAcK?=
 =?us-ascii?Q?QcUCBqFhRu6re+VSDp0PieqOls8jsUOV/FzTGR0n6ljLfXhNnTsdZZd9z1eo?=
 =?us-ascii?Q?ns2PCiA93NUJGpohMwIlpw1Tb1CvCvF90zGgd9on1Zt/r3Ho7OATUmeHKJL+?=
 =?us-ascii?Q?dGvnyAazLp4YC6oXgTZnPf6BrDTdTW5WbyVSZF8wl5SUWaxt1F7j2lIXe5Lq?=
 =?us-ascii?Q?yuDtF+DUHV0QDBrBD54Z5LD1gsOiM0z8iZvTfYY6D99IKTDCOyjG+Wp3Uzzx?=
 =?us-ascii?Q?0COkOAMZKzka2UjkxUzj3uOsvqRO5fazGNawrXAdfPjybRNpouS7vo8o1et9?=
 =?us-ascii?Q?yFTsaX0ofbfZekBcYPqY5z2QeLj1PZFu46nUvbNL5iJdIM1j6DTcLGp4FFEM?=
 =?us-ascii?Q?aZEU/iWF9OQJZazuXd5DZmujXyDtHnDYGbpaXCOigpXYFYgh+M2UZauKBH2E?=
 =?us-ascii?Q?k2ReuaUVt5dZIiYsHNtUHrkOzUZjKWDMPbYmUgZoPmzv66/pfx+zBoj6HZOD?=
 =?us-ascii?Q?5KBZ+Ld5FUobHVj8DLINmjxWKOtuEafIG96BXtnq71/GB1ntxR9BOQJF+0Bg?=
 =?us-ascii?Q?ZzDW2cZAwZzJtuNIn9BV5ZMFY4oaHwE0/k9jemZMXCEdXgnK7fsm4cqe/R3Z?=
 =?us-ascii?Q?9Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2b6407-69a8-4cb4-fd89-08dbdbbc9121
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB6331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 15:58:34.0245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E4533Jci6DehLP8hL5jQefwOyePBVlm7M9r1cImwIcDpMX2+K7JldLGnIuO+5yT6JfA5LQha2mOw28uZjKIre6vNlcJ3z41kzNxY7zZTA1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9005
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

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

