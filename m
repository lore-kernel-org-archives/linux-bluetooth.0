Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79960C4167B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Oct 2023 15:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344813AbjJaPzu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Oct 2023 11:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344808AbjJaPzt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Oct 2023 11:55:49 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2073.outbound.protection.outlook.com [40.107.6.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F544DA
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Oct 2023 08:55:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bV3UY+5aqagrdYFN+PCSIkqLFVvNJqHFJurahSLliKw5R0JyQ36CyMew44HIuKeFFG7zzqjvI5a230aKiYKoZJD3GPKxdV69SnH45KUlxnSgolTowgre/ccPmsqlPO+THt+XyL8+R34tpNGT+xQqjvlWU610Mo+AUCoc1bYBhsZX/eNADcUcUnr72YDcRT5qKAKmodEhlUAlO1NtawJ/AXCblbfX7EGeEFwoso/khetRwPD5K1EfolcUXFa1xxatAT4TfGFf4h4ViI4yolKb8q8RojRiteGEzjSM8qsf58Akb9h98/TPsjaIUeL8t48oJMTjaVtTcbbtrQn919sYKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWM/uQZU9RxfJdKvLLiJrUcg9hwoKwESBKE1PIF6FLo=;
 b=e+mXmXAtu1TS9fIQTvZ9e9iTA3niuWtFBEhqyHAxatpHPnOTT+Kh7KbPcZCRnpus+vttYYoF+FFFIxYjBb3x8rGQXM4Sx4e5b6Jmu8u8EGvR9ZdtkUejQsH0OMnOBMxDltODVvxdGJL7ricuIt5LMDyyBI+2QLxqrNaB2fuc5aECKS5bpJkGBl5fEfLqZWDHulh1cT+wbJXOEj/oSgwZLY/sUMtC+qUbnqX3g3QcgCUSQT0aKnlww8uOfTCFsCE9COtzEK4L466Y0Afv6zwRnSjweVRYIm4uxmZGCm6rfuKw7KbaG+R2z/NKHMrX585GvqoIuPiOj/G7gm3po2V6WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWM/uQZU9RxfJdKvLLiJrUcg9hwoKwESBKE1PIF6FLo=;
 b=DoKZBCmrtCgWSy2kCqSuIyn6TT/ZIwxUjbGcLrcjuo5d5DRh39JGzQIxRkD05pz2cCKNyJ/WQZVLGHMrAlRONmYDz6pk3qp9karJnvb/VDCl9KE4i7HeePvngbwQaTH31b9G1FKBDU/AytCaeP98aGgDp1/DcqKkDdRE/IerV6A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com (2603:10a6:10:ca::21)
 by DU2PR04MB8613.eurprd04.prod.outlook.com (2603:10a6:10:2d8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.16; Tue, 31 Oct
 2023 15:55:43 +0000
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::7c8a:c8da:e6a5:8a4a]) by DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::7c8a:c8da:e6a5:8a4a%7]) with mapi id 15.20.6933.009; Tue, 31 Oct 2023
 15:55:43 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        iulia.tanasescu@nxp.com
Subject: [PATCH v2 1/5] bap: Fix source+sink endpoint registration
Date:   Tue, 31 Oct 2023 17:55:31 +0200
Message-Id: <20231031155535.228994-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231031155535.228994-1-silviu.barbulescu@nxp.com>
References: <20231031155535.228994-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0137.eurprd07.prod.outlook.com
 (2603:10a6:802:16::24) To DBBPR04MB6331.eurprd04.prod.outlook.com
 (2603:10a6:10:ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB6331:EE_|DU2PR04MB8613:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f73d4f4-8e74-4b2b-6ff1-08dbda29d6c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0OaUVcAizB85Avlp9W6kNSlGn1/24fBAAaB+Aw/+XSaj4SOctCnEEColZO0FwCJxgDy1W5TwcZODOwkjcrmtJPC5FmnR542B+ouNIPGhUxNP/KwAXQgZQ2n4sAz51hzpA+toC/r0UDMM+3X0rLUTmRP9IPZsmFszCgSdATgsBserPPPpcjLiI3PxO63vkw1n65Tjauc5+gVFLoiIUIoH7Y0K/YFIoJX+Oe4EhN6wBnk1AQFeV1Bn7vvtM6ZWxqPRmP1pIidS39aTUKs3bbjJio45joiMoC+3EQLDSetjM6ls8ElEWzBNO8ms1XSjzGkDOESI4/jp8y7wNv6yMbPYzEHbKuEctPdjfo1a/T8K27zQjjOLMwhmnTiaWhrpolBLJYVAhdJ4Ocj+0vFJQZ2cz2fB/ZfIDGKuPWCTrJyjMcPYLioriqVHznzi3gpY5MoBxshDcfGdkeRIvYkW7e3RyOal3hU1RuAnKs2eyNBPQqIHnA7kzj1jghqkMOpj2ikq3xFc3WJLaH4Vhi5hZjMCtCDiNyfaVTued8JrR9WhzQ2qyOEODLOGXoNO2iFoUWaA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB6331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(366004)(346002)(376002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(38100700002)(5660300002)(86362001)(2616005)(1076003)(26005)(83380400001)(478600001)(36756003)(6506007)(6666004)(6512007)(6486002)(2906002)(66556008)(66946007)(66476007)(41300700001)(8676002)(8936002)(316002)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TnH761cS9IV/iDyZXQJFjW3CtqLi1lt3WHr131jMOy3kGvnZIwPMzvKQ6Mon?=
 =?us-ascii?Q?OWvkzUMB3bNOr1YblGIYi89K87vWrCZRyuFJPEpdvao90isldb+4EOaY8tP6?=
 =?us-ascii?Q?quWGruqxR7mMkfG4EByuQwTs70FUXXa+vi5z6OoRbzFyDWmmRjQgR0rID4eb?=
 =?us-ascii?Q?PnNrHed4hb7UT25fpGi///xn4sETPznSBaRjeRULL3WLmGUy+73I0vezROfo?=
 =?us-ascii?Q?TEL2mp2c1XwxL2HpqEZjKDk4UjlHchPuigvNEeG7u3L3L2gvLX/alIM5H/4Q?=
 =?us-ascii?Q?XlfdOwj+EjmFvFECT3jOMHgcklCdawScgrLrkGCf54GNdGmcnIk9IKkjdSw3?=
 =?us-ascii?Q?R2NhBs72GTszPGX5IcUrs8aVxDfvdcfRwAaU1FTGSzIJfH9cGNkeugHT4vi0?=
 =?us-ascii?Q?whLiZ0zizGrbLHU5o52wjNq7ksg62SzaVZbjrQBf2TdW3hMrzvquG5RSlwg2?=
 =?us-ascii?Q?psVgG7RziVgZJ1emZV5cewV38u+fUK6GNYbILP3D51VD8dxn4icCWq4ZuCQd?=
 =?us-ascii?Q?knypfTqj3Y76tqzurp9atXoz3hXxjKQQ+cDbtSRCT7p7n8Sq1UUnuBJBrpnx?=
 =?us-ascii?Q?5jEGx+M0fad0Q8HPrxbTRybaINHGXGC1/8yWOsM7OmhsqEqcJaHjwOnjIRLg?=
 =?us-ascii?Q?F8/PCM2rEE+idHEqDGNcMqnr+xLPhWEJIe7D8xIRapeNDlfT4fyNloDTfkwe?=
 =?us-ascii?Q?FMfDRKGkmJhXIaWMzKXkHMY7mkBLgySf9llVebCR/3UN2c/y6rLHbAyn6uZu?=
 =?us-ascii?Q?yj9y+g9LEGAFrT4yPkHA2KlRRXt5CLDRuozRG7bMgCKfKgf3LKcKAQrEZl5z?=
 =?us-ascii?Q?51X5gJcvAeAffyfqyQ9enSnlxO4yb0nrR0Y1Xn0dKal8CzRUrBdgEKerdtwi?=
 =?us-ascii?Q?6AxnD6cnwN8niUdPbuhWuViTExb5CFF7ALzc+qtgnYg1hHPdkQW1Q0Eu/Fc/?=
 =?us-ascii?Q?uhLTgpz3T1Wv5QnQpbe2v2zpgauapAu61K3KSs1Dtsa/I3vpp2fjAkXo+5uB?=
 =?us-ascii?Q?C6xafyeKUrYXqdS+Jnw6abGn7jSTFfD+DwvmkznAAOTbHGN5TK69nd/IipZ3?=
 =?us-ascii?Q?Sif2GeEKuL1hc66Yx5ysO3AZBhuPei38dWcBBKZA7oebFgn0VnGXkUvhbham?=
 =?us-ascii?Q?LIcF37osq1vvXj8pkJee7lsfMky+8eeGS/LhitcY0r/d7TLBiazIxy/+9gfU?=
 =?us-ascii?Q?79sn0auv/lfPGV0cPsipSm5tpd8jeKDWH2GrIRcjg+F2iLtjfAwKAwRiXF54?=
 =?us-ascii?Q?z+pXcL3SvH8n+xJ2K+3//H8eakyasrLRVpNdNrWABMRjLfpyrh95Xh7del4h?=
 =?us-ascii?Q?LGdN4HPRkWyIe63eKRKBMTWjhtZK4fjLSgsXnev9oJx5mVaWQifcj8ht2HsM?=
 =?us-ascii?Q?g5jzSYZqSyP3SoshPzbdWdQ7OhApt56sDjBX9f0aPovL0T6VIV+wlRTlB3cz?=
 =?us-ascii?Q?b158GtrFYS/nmX5wSZPpWX7riuEqEbT6zlBDNNl16skHGidWfTyhXRB4xehE?=
 =?us-ascii?Q?C17CNGjlNUS+0jHf5hbO77kDsgjgeVh8mtTu+ZPnX6yDI/Jsp+nkw/ULkM9S?=
 =?us-ascii?Q?1ZRCl5Z5Rmadq0t9bYjEkpQ5TI/Zth7CvkXQGoLptji3CxcFMqRmmQDu1hAI?=
 =?us-ascii?Q?3Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f73d4f4-8e74-4b2b-6ff1-08dbda29d6c6
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB6331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 15:55:43.6375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jb3S1N6XqA6VDMzm9ouwdieWZ8mc3ox8b4nT7Re7qT3AEFsValtm/kYC7bIJkJdBLaCA39vdIrTNz7kXhL3PBVmt0G0NT7xRBpKkl/69Z14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8613
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

