Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2E5EE49A6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Aug 2023 15:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbjHUPvl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Aug 2023 11:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236462AbjHUPvj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Aug 2023 11:51:39 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2064.outbound.protection.outlook.com [40.107.241.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A41A1
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 08:51:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MoDnvOmwms3OlSOzjYIJys3U7H/RhfiP06YaPlK02+WUlPy9yuscO5vRyQJz+KIWMyXP4nhwpUCBXF+f4jwNkZt8PKG5JubcHhQScH54Dopk9z995TeyUGel4jDkWi9DsoE3dXu0Bl+zCVE3D3pFjVRjfg4se4yXdwGmKJwxmwcWG0eWK2FbypU93BrBCj9mXwr1HadQYOxgfuMlNYEBCSeJFXsmTr2/zGRvj0JLgMaEzqoxb6PDVO0mOpPfeCfSwvXnNxlIvPhDI46LUjyxt/+slUpDyjlyLeCgr7q5uz/sG6WFZd4Fpa6aDQ+vkpEofj7C8B3o7Z4VypvC+Yb51g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vftM1PO1nVvxK/O/Aq+ZVl6bkDRzJoRm3SRkx2t2ZUI=;
 b=D/ObNAaRhCkgoMZWtOGDGhCCPM6LMFPcB9MVDzJaZGXlhsOlT5G/qpN1+SshjEQWeu/WP6JhUubWwhw6CnqNXpo50zfvIHHtbVQngtUET/3rsVOq6Fz5OQvcZIdIgJNkpnrt7cp33DusAbFJQNTCca9X3SnoTBicu4PDChg67CPlkdptA2DE3G0bXi69IpEEOhENgogKqESb51W9w0WiFj1ojv07lkKKKA444ISvvNsqGVeDZra6HQoD193//r3hg8xkTz/bs+jT3XNisjAzSJIytUvr8msQH2OQsrlWepgpsyEAPMt+SyLNYRAaH+iBi0k7Bur5A5C96OXyZaBPvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vftM1PO1nVvxK/O/Aq+ZVl6bkDRzJoRm3SRkx2t2ZUI=;
 b=VwK9A5YanzEL9DP7zyRrYYjzTOE/YpJUlCx+p4tXYURLvr+/3pP0brMaYSw+bPCVdOox3eLitLsi7yaNGNl0vWSUr98KWOgydpfA8/1oAt4fTtvmTndWvhpiEuUEf/mjg+3C1N3gi7I40X7jmbSzZKe15IkHJD/9GhTnySmdWPM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by GVXPR04MB9952.eurprd04.prod.outlook.com (2603:10a6:150:117::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 15:51:32 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 15:51:32 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v7 1/6] shared/bap: Add support for BAP broadcast sink
Date:   Mon, 21 Aug 2023 18:50:59 +0300
Message-Id: <20230821155104.86954-2-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821155104.86954-1-claudia.rosu@nxp.com>
References: <20230821155104.86954-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0127.eurprd04.prod.outlook.com
 (2603:10a6:208:55::32) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|GVXPR04MB9952:EE_
X-MS-Office365-Filtering-Correlation-Id: a2805cf0-6ca7-4903-b067-08dba25e7dc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vvKoaR09BgHh5wKmAL1+YorlX9oHEEKZBI1dnnI0NotCngE44K+OLWRTryqNej2PB+6MQhnpq4zH1nK9ms8rSlG5VVx8vSxpL8ZbHec/TwE3m9IzfBJpygowstj/GdOXYS5tPf0ckI9lo8GKV8la5u7X1uLX4CAE768WmVNmGUH5FeMLJ0ybLVTsL5RM5uZoOubmorL6PpzANWSJoCI0+MDDMthbpvZExAMxPH5BPh7FvMb4PaP41NITFMT/qlKuDO3tkF1ewgqcCscGOlplhAfWj3drmzZx5u5/HZXwzuzE8wxPyE069QXDOcjr4tIxZ37MwW0iBDW3/8d5lcf7pk41lxJfIsC7gbMuHNxmxadq702Wy8CRvZ9bIQQyVO502U5QBSqMiJS7UeBhvT/MAcmVoMrEuWMNwgkhM0Gy5YLcG1Sm1827E8SZusoATopZ/EmhHJqCaf7nNT45c7CDI3j93As63g9hQIO4Qk0Os1gIx3w3SJcGDycmJCSGC6+IFMk5BgJdGINAmwFw8q/eimpw578lwqd1IpudQYSkO6C4VS/okOqIfwtN3J15fCjsy+1kls0rG1tkNxAPQy2jzI4V/FhJ9GSdSma4YHmNXTm09LfemeWmeZER/Xr/2hFQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(30864003)(52116002)(38350700002)(38100700002)(6506007)(6486002)(83380400001)(5660300002)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(316002)(66946007)(6512007)(6916009)(66556008)(66476007)(478600001)(6666004)(36756003)(41300700001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w5TubJyWs8ajKo1vuoFeMM5FNiFv0XpvbhRNjrPX9/lZTuIy53xWkbd+UKwH?=
 =?us-ascii?Q?EllQIqQM7LYlyIv3KZI15ziJo9NEB9jJFECFEXlExExF8A3ynZB3BOUAlD/K?=
 =?us-ascii?Q?/ZSJZoZoufPblmUj12r/mOwkW2JN+ETV4UA73cTREQMDiXsNmm1v9Y/OSo/d?=
 =?us-ascii?Q?Yj3u4fq+lA+gTKFgZH0ccq99rJrr90A88ic6pL0Wh7VBP7zywmUU43FF7fcB?=
 =?us-ascii?Q?+ClbI5t+qGx60ua3TexEpAh4jz6Inrfhp8VvXVvdOlrkzi8JgrQufptvFVTu?=
 =?us-ascii?Q?8wb+aBtszluDooE34K0lSe6ceVGl6Dyszvi4aqKdtgmIF7lwlCfBzhMC+U4C?=
 =?us-ascii?Q?e50NUB5ooAjLOyaLL2xslTz3mPcJtz5yyMizc43wZJCqrVzB0hrdlvHluo1o?=
 =?us-ascii?Q?vc5X0t9lGhk4BfxtrihPHMKF2V+k2+5PvaMzAdY+GAlZlhj1cWDhuaiNMGhg?=
 =?us-ascii?Q?jyMR30JfHYDwyEDrK3d3uRqILuQMG7/Ach7WyxBrfYaj8XnlVggIOZ+RMU/K?=
 =?us-ascii?Q?PBKyAhwAg7epYH5Eha7M/wPC20Pm08l3aInokh+JlRQizvb6/Enq+GFNOUQx?=
 =?us-ascii?Q?SDMaMidQ3NsgEYzq24RQn3J+904dJwkaCnvwg4gFQE+KU4QA26+wcinLEZuJ?=
 =?us-ascii?Q?WLkCLDLMN9xdnfoL40LmujQVc4c9X2jQiApuTqr5JP8pxFfVRlcrCZ3abxgJ?=
 =?us-ascii?Q?7K8kPV3U4peTZAq4c0+lFjmxxDY8n+L2dks2g+rTkqmGx7sqIa8IxC6fqGI7?=
 =?us-ascii?Q?ASfCcJJN8eu/FN+E2HXt+wpJvKkxGdoLcMd5CB8j70H2asZ8nHDHCdKReQf5?=
 =?us-ascii?Q?Rqvez3phGGghW07iPQwx+7xvT15tZCnZazP6FvETZdZ7PVH+gqx43Jmswlf9?=
 =?us-ascii?Q?Ym84Cqoj4821lspvPMMjGwaLRsd61c8P6o3Esv0UQYaz6pdutDitz2SZyFku?=
 =?us-ascii?Q?ugrnLSOkzh9ch7c35ZOoWI1Pzfv0F8Obm7SdP/lbbFkLs0cWet2MtIB7E+Vz?=
 =?us-ascii?Q?AzT5DGnBHjBzVIwRG5Ved4/k6xksL8XFoLl2T7OIHI4GsIuI/brUJvULK3iy?=
 =?us-ascii?Q?Vt/9p5l6xnRQoRwoSzw+zGHqI0RbO/Hpri5D/bG4IiFbB9dQTJLGm9q98nzS?=
 =?us-ascii?Q?hCAcmdGRnkVXUAtIWDM8eTpZsWQwRJ/YbrPF+Dnmb+OV1j40QzL1XkAGK3YY?=
 =?us-ascii?Q?jbxKFYBDAM9VsnZCSbsH0hJRTdJc/5TXgD/UirDaP7L9l9JYpbyNPT50/2XC?=
 =?us-ascii?Q?YlJT5BK7AwdiH4uAcVHFVP0nS7if43A4ma8X6R2HOPDXyUFVf0fCOiZaUfnZ?=
 =?us-ascii?Q?QfJHLTwXbcKHQzvrctP2fQ7d2Yfrv7E5I6K1uxDCHug+/F8GKqA/4mam6RnG?=
 =?us-ascii?Q?fg2vT7DnkAPQ4zlONwYGfkCtmGMigaBasRCzRQg9wJ8XYurRBhLVnNHxaoVQ?=
 =?us-ascii?Q?iZTQcMiOkFKV7F9yQvOOdK0fHTvDZ8NIG1vIWDBYwrx4KS/0iRRZ/F0hglZN?=
 =?us-ascii?Q?gzOr0p/elO8Gdzj/NEdP5ErSFOes/uj8twPo9PknyMiqEb0Unt9zwHEOOGY9?=
 =?us-ascii?Q?4eBNF7Xr9sTbm4+7QDvfkiGIFO4WQdqUPkEjF/YO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2805cf0-6ca7-4903-b067-08dba25e7dc8
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 15:51:32.6154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: savBfgsPV6N9sZ/vHEQlMA/Oct4iBu4dBCSIseUuUrP2Z10kQ92OeR1xukJ8VNcG6RoTjEuMgl/46k1xxVQHvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9952
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds support for BAP broadcast sink, creates a remote endpoint when a
broadcast source is discovered and synchronizes with the source upon
endpoint configuration.
This feature was tested using bluetoothctl with the following commands:

[bluetooth]# endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
[bluetooth]# scan on
[NEW] Endpoint /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_bcast0
[bluetooth]# endpoint.config
/org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_bcast0
/local/endpoint/ep0 16_2_1

---
 src/shared/bap.c | 266 ++++++++++++++++++++++++++++++++++++++++++-----
 src/shared/bap.h |  13 ++-
 2 files changed, 251 insertions(+), 28 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 72ce67c08..d548b7734 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -633,14 +633,18 @@ static struct bt_bap_endpoint *bap_endpoint_new(struct bt_bap_db *bdb,
 	return ep;
 }
 
-static struct bt_bap_endpoint *bap_endpoint_new_broacast(struct bt_bap_db *bdb)
+static struct bt_bap_endpoint *bap_endpoint_new_broadcast(struct bt_bap_db *bdb,
+								uint8_t type)
 {
 	struct bt_bap_endpoint *ep;
 
 	ep = new0(struct bt_bap_endpoint, 1);
 	ep->bdb = bdb;
 	ep->attr = NULL;
-	ep->dir = BT_BAP_BCAST_SOURCE;
+	if (type == BT_BAP_BCAST_SINK)
+		ep->dir = BT_BAP_BCAST_SOURCE;
+	else
+		ep->dir = BT_BAP_BCAST_SINK;
 
 	return ep;
 }
@@ -667,22 +671,27 @@ static struct bt_bap_endpoint *bap_get_endpoint(struct queue *endpoints,
 	return ep;
 }
 
+static bool match_ep_type(const void *data, const void *match_data)
+{
+	const struct bt_bap_endpoint *ep = data;
+	const uint8_t type = PTR_TO_INT(match_data);
+
+	return (ep->dir == type);
+}
+
 static struct bt_bap_endpoint *bap_get_endpoint_bcast(struct queue *endpoints,
-						struct bt_bap_db *db)
+					struct bt_bap_db *db, uint8_t type)
 {
 	struct bt_bap_endpoint *ep;
 
 	if (!db)
 		return NULL;
-	/*
-	 * We have support for only one stream so we will have
-	 * only one endpoint.
-	 * TO DO add support for more then one stream
-	 */
-	if (queue_length(endpoints) > 0)
-		return queue_peek_head(endpoints);
 
-	ep = bap_endpoint_new_broacast(db);
+	ep = queue_find(endpoints, match_ep_type, INT_TO_PTR(type));
+	if (ep)
+		return ep;
+
+	ep = bap_endpoint_new_broadcast(db, type);
 	if (!ep)
 		return NULL;
 
@@ -1317,6 +1326,8 @@ static void stream_set_state_broadcast(struct bt_bap_stream *stream,
 	struct bt_bap *bap = stream->bap;
 	const struct queue_entry *entry;
 
+	if (ep->old_state == state)
+		return;
 	ep->old_state = ep->state;
 	ep->state = state;
 
@@ -1348,6 +1359,9 @@ static void stream_set_state(struct bt_bap_stream *stream, uint8_t state)
 	ep->old_state = ep->state;
 	ep->state = state;
 
+	if (stream->lpac->type == BT_BAP_BCAST_SINK)
+		goto done;
+
 	if (stream->client)
 		goto done;
 
@@ -2379,6 +2393,10 @@ static struct bt_bap_pac *bap_pac_find(struct bt_bap_db *bdb, uint8_t type,
 		return queue_find(bdb->sources, match_codec, codec);
 	case BT_BAP_SINK:
 		return queue_find(bdb->sinks, match_codec, codec);
+	case BT_BAP_BCAST_SOURCE:
+		return queue_find(bdb->broadcast_sources, match_codec, codec);
+	case BT_BAP_BCAST_SINK:
+		return queue_find(bdb->broadcast_sinks, match_codec, codec);
 	}
 
 	return NULL;
@@ -2428,10 +2446,12 @@ static struct bt_bap_pac *bap_pac_new(struct bt_bap_db *bdb, const char *name,
 	pac->bdb = bdb;
 	pac->name = name ? strdup(name) : NULL;
 	pac->type = type;
-	pac->codec = *codec;
-	pac->data = util_iov_dup(data, 1);
-	pac->metadata = util_iov_dup(metadata, 1);
-
+	if (codec)
+		pac->codec = *codec;
+	if (data)
+		pac->data = util_iov_dup(data, 1);
+	if (metadata)
+		pac->metadata = util_iov_dup(metadata, 1);
 	if (qos)
 		pac->qos = *qos;
 
@@ -2518,7 +2538,7 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
 					struct iovec *metadata)
 {
 	struct bt_bap_db *bdb;
-	struct bt_bap_pac *pac, *pac_brodcast_sink;
+	struct bt_bap_pac *pac, *pac_broadcast_sink;
 	struct bt_bap_codec codec;
 
 	if (!db)
@@ -2545,11 +2565,19 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
 		bap_add_source(pac);
 		break;
 	case BT_BAP_BCAST_SOURCE:
-		// For broadcast add local pac and remote pac
 		bap_add_broadcast_source(pac);
-		pac_brodcast_sink = bap_pac_new(bdb, name, type, &codec, qos,
+		if (queue_isempty(bdb->broadcast_sinks)) {
+			/* When adding a local broadcast source, add also a
+			 * local broadcast sink
+			 */
+			pac_broadcast_sink = bap_pac_new(bdb, name,
+					BT_BAP_BCAST_SINK, &codec, qos,
 					data, metadata);
-		bap_add_broadcast_sink(pac_brodcast_sink);
+			bap_add_broadcast_sink(pac_broadcast_sink);
+		}
+		break;
+	case BT_BAP_BCAST_SINK:
+		bap_add_broadcast_sink(pac);
 		break;
 	default:
 		bap_pac_free(pac);
@@ -2923,6 +2951,103 @@ bool bap_print_cc(void *data, size_t len, util_debug_func_t func,
 	return bap_print_ltv("CC", data, len, func, user_data);
 }
 
+bool bap_parse_base(void *data, size_t len, util_debug_func_t func,
+		uint32_t *presDelay, uint8_t *numSubgroups, uint8_t *numBis,
+		struct bt_bap_codec *codec, struct iovec **caps,
+		struct iovec **meta)
+{
+	struct iovec iov = {
+		.iov_base = data,
+		.iov_len = len,
+	};
+
+	uint8_t capsLen, metaLen;
+	uint8_t *hexstream;
+
+	if (presDelay) {
+		if (!util_iov_pull_le24(&iov, presDelay))
+			return false;
+		util_debug(func, NULL, "PresentationDelay %d", *presDelay);
+	}
+
+	if (numSubgroups) {
+		if (!util_iov_pull_u8(&iov, numSubgroups))
+			return false;
+		util_debug(func, NULL, "NumSubgroups %d", *numSubgroups);
+	}
+
+	if (numBis) {
+		if (!util_iov_pull_u8(&iov, numBis))
+			return false;
+		util_debug(func, NULL, "NumBis %d", *numBis);
+	}
+
+	if (codec) {
+		codec = util_iov_pull_mem(&iov, sizeof(*codec));
+		if (!codec)
+			return false;
+		util_debug(func, NULL, "%s: ID %d CID 0x%2.2x VID 0x%2.2x",
+				"Codec", codec->id, codec->cid, codec->vid);
+	}
+
+	if (!util_iov_pull_u8(&iov, &capsLen))
+		return false;
+	util_debug(func, NULL, "CC Len %d", capsLen);
+
+	if (!capsLen)
+		return false;
+	if (caps) {
+		if (!(*caps))
+			*caps = new0(struct iovec, 1);
+		(*caps)->iov_len = capsLen;
+		(*caps)->iov_base = iov.iov_base;
+	}
+
+	for (int i = 0; capsLen > 1; i++) {
+		struct bt_ltv *ltv = util_iov_pull_mem(&iov, sizeof(*ltv));
+		uint8_t *caps;
+
+		if (!ltv) {
+			util_debug(func, NULL, "Unable to parse %s",
+								"Capabilities");
+			return false;
+		}
+
+		util_debug(func, NULL, "%s #%u: len %u type %u",
+					"CC", i, ltv->len, ltv->type);
+
+		caps = util_iov_pull_mem(&iov, ltv->len - 1);
+		if (!caps) {
+			util_debug(func, NULL, "Unable to parse %s",
+								"CC");
+			return false;
+		}
+		util_hexdump(' ', caps, ltv->len - 1, func, NULL);
+
+		capsLen -= (ltv->len + 1);
+	}
+
+	if (!util_iov_pull_u8(&iov, &metaLen))
+		return false;
+	util_debug(func, NULL, "Metadata Len %d", metaLen);
+
+	if (!metaLen)
+		return false;
+	if (meta) {
+		if (!(*meta))
+			*meta = new0(struct iovec, 1);
+		(*meta)->iov_len = metaLen;
+		(*meta)->iov_base = iov.iov_base;
+	}
+
+	hexstream = util_iov_pull_mem(&iov, metaLen);
+	if (!hexstream)
+		return false;
+	util_hexdump(' ', hexstream, metaLen, func, NULL);
+
+	return true;
+}
+
 static void bap_parse_pacs(struct bt_bap *bap, uint8_t type,
 				struct queue *queue,
 				const uint8_t *value,
@@ -4008,7 +4133,8 @@ bool bt_bap_attach_broadcast(struct bt_bap *bap)
 
 	queue_push_tail(sessions, bap);
 
-	ep = bap_get_endpoint_bcast(bap->remote_eps, bap->ldb);
+	ep = bap_get_endpoint_bcast(bap->remote_eps, bap->ldb,
+				BT_BAP_BCAST_SOURCE);
 	if (ep)
 		ep->bap = bap;
 
@@ -4198,7 +4324,11 @@ static void bap_foreach_pac(struct queue *l, struct queue *r,
 		for (er = queue_get_entries(r); er; er = er->next) {
 			struct bt_bap_pac *rpac = er->data;
 
-			if (!bap_codec_equal(&lpac->codec, &rpac->codec))
+			/* Skip checking codec for bcast source,
+			 * it will be checked when BASE info are received
+			 */
+			if ((rpac->type != BT_BAP_BCAST_SOURCE) &&
+				(!bap_codec_equal(&lpac->codec, &rpac->codec)))
 				continue;
 
 			if (!func(lpac, rpac, user_data))
@@ -4221,9 +4351,19 @@ void bt_bap_foreach_pac(struct bt_bap *bap, uint8_t type,
 		return bap_foreach_pac(bap->ldb->sinks, bap->rdb->sources,
 							   func, user_data);
 	case BT_BAP_BCAST_SOURCE:
-		return bap_foreach_pac(bap->ldb->broadcast_sources,
+		if (queue_isempty(bap->rdb->broadcast_sources)
+			&& queue_isempty(bap->rdb->broadcast_sinks))
+			return bap_foreach_pac(bap->ldb->broadcast_sources,
 					bap->ldb->broadcast_sinks,
 					func, user_data);
+
+		return bap_foreach_pac(bap->ldb->broadcast_sinks,
+					bap->rdb->broadcast_sources,
+					func, user_data);
+	case BT_BAP_BCAST_SINK:
+		return bap_foreach_pac(bap->ldb->broadcast_sinks,
+					bap->rdb->broadcast_sources,
+					func, user_data);
 	}
 }
 
@@ -4243,10 +4383,10 @@ int bt_bap_pac_get_vendor_codec(struct bt_bap_pac *pac, uint8_t *id,
 	if (vid)
 		*vid = pac->codec.cid;
 
-	if (data)
+	if (data && pac->data)
 		*data = pac->data;
 
-	if (metadata)
+	if (metadata && pac->metadata)
 		*metadata = pac->metadata;
 
 	return 0;
@@ -4382,6 +4522,11 @@ unsigned int bt_bap_stream_config(struct bt_bap_stream *stream,
 		return req->id;
 	case BT_BAP_STREAM_TYPE_BCAST:
 		stream->qos = *qos;
+		if (stream->lpac->type == BT_BAP_BCAST_SINK) {
+			if (data)
+				stream_config(stream, data, NULL);
+			stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
+		}
 		return 1;
 	}
 
@@ -4434,7 +4579,8 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 		return NULL;
 
 	if (lpac && rpac) {
-		if (!bap_codec_equal(&lpac->codec, &rpac->codec))
+		if ((rpac->type != BT_BAP_BCAST_SOURCE)
+			&& (!bap_codec_equal(&lpac->codec, &rpac->codec)))
 			return NULL;
 	} else {
 		uint8_t type;
@@ -4446,13 +4592,19 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 		if (rpac)
 			type = rpac->type;
 		else if (lpac) {
-			switch(lpac->type) {
+			switch (lpac->type) {
 			case BT_BAP_SINK:
 				type = BT_BAP_SOURCE;
 				break;
 			case BT_BAP_SOURCE:
 				type = BT_BAP_SINK;
 				break;
+			case BT_BAP_BCAST_SOURCE:
+				type = BT_BAP_BCAST_SINK;
+				break;
+			case BT_BAP_BCAST_SINK:
+				type = BT_BAP_BCAST_SOURCE;
+				break;
 			default:
 				return NULL;
 			}
@@ -4913,6 +5065,13 @@ struct io *bt_bap_stream_get_io(struct bt_bap_stream *stream)
 	return io->io;
 }
 
+bool bt_bap_match_bcast_sink_stream(const void *data, const void *user_data)
+{
+	const struct bt_bap_stream *stream = data;
+
+	return stream->lpac->type == BT_BAP_BCAST_SINK;
+}
+
 static bool stream_io_disconnected(struct io *io, void *user_data)
 {
 	struct bt_bap_stream *stream = user_data;
@@ -4944,6 +5103,14 @@ static bool match_req_id(const void *data, const void *match_data)
 	return (req->id == id);
 }
 
+static bool match_name(const void *data, const void *match_data)
+{
+	const struct bt_bap_pac *pac = data;
+	const char *name = match_data;
+
+	return (!strcmp(pac->name, name));
+}
+
 int bt_bap_stream_cancel(struct bt_bap_stream *stream, unsigned int id)
 {
 	struct bt_bap_req *req;
@@ -5132,3 +5299,50 @@ bool bt_bap_stream_io_is_connecting(struct bt_bap_stream *stream, int *fd)
 
 	return io->connecting;
 }
+
+bool bt_bap_new_bcast_source(struct bt_bap *bap, const char *name)
+{
+	struct bt_bap_endpoint *ep;
+	struct bt_bap_pac *pac_broadcast_source;
+
+	/* Add the remote source only if a local sink endpoint was registered */
+	if (queue_isempty(bap->ldb->broadcast_sinks))
+		return false;
+
+	/* Add the remote source only if a local sink endpoint was registered */
+	if (queue_isempty(bap->ldb->broadcast_sinks))
+		return false;
+
+	/* Add remote source endpoint */
+	if (!bap->rdb->broadcast_sources)
+		bap->rdb->broadcast_sources = queue_new();
+
+	if (queue_find(bap->rdb->broadcast_sources, match_name, name))
+		return true;
+
+	pac_broadcast_source = bap_pac_new(bap->rdb, name, BT_BAP_BCAST_SOURCE,
+			NULL, NULL, NULL, NULL);
+	queue_push_tail(bap->rdb->broadcast_sources, pac_broadcast_source);
+
+	if (!pac_broadcast_source)
+		return false;
+
+	queue_foreach(bap->pac_cbs, notify_pac_added, pac_broadcast_source);
+
+	/* Push remote endpoint with direction sink */
+	ep = bap_endpoint_new_broadcast(bap->rdb, BT_BAP_BCAST_SINK);
+
+	if (ep)
+		queue_push_tail(bap->remote_eps, ep);
+
+	return true;
+}
+
+void bt_bap_update_bcast_source(struct bt_bap_pac *pac,
+					struct bt_bap_codec *codec,
+					struct iovec *data,
+					struct iovec *metadata)
+{
+	bap_pac_merge(pac, data, metadata);
+	pac->codec = *codec;
+}
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 50b567663..8a8be9495 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -194,7 +194,10 @@ bool bt_bap_set_debug(struct bt_bap *bap, bt_bap_debug_func_t cb,
 
 bool bap_print_cc(void *data, size_t len, util_debug_func_t func,
 						void *user_data);
-
+bool bap_parse_base(void *data, size_t len, util_debug_func_t func,
+		uint32_t *presDelay, uint8_t *numSubgroups, uint8_t *numBis,
+		struct bt_bap_codec *codec, struct iovec **caps,
+		struct iovec **meta);
 unsigned int bt_bap_pac_register(struct bt_bap *bap, bt_bap_pac_func_t added,
 				bt_bap_pac_func_t removed, void *user_data,
 				bt_bap_destroy_func_t destroy);
@@ -289,7 +292,7 @@ struct bt_bap_qos *bt_bap_stream_get_qos(struct bt_bap_stream *stream);
 struct iovec *bt_bap_stream_get_metadata(struct bt_bap_stream *stream);
 
 struct io *bt_bap_stream_get_io(struct bt_bap_stream *stream);
-
+bool bt_bap_match_bcast_sink_stream(const void *data, const void *user_data);
 bool bt_bap_stream_set_io(struct bt_bap_stream *stream, int fd);
 
 int bt_bap_stream_cancel(struct bt_bap_stream *stream, unsigned int id);
@@ -305,3 +308,9 @@ uint8_t bt_bap_stream_io_dir(struct bt_bap_stream *stream);
 
 int bt_bap_stream_io_connecting(struct bt_bap_stream *stream, int fd);
 bool bt_bap_stream_io_is_connecting(struct bt_bap_stream *stream, int *fd);
+
+bool bt_bap_new_bcast_source(struct bt_bap *bap, const char *name);
+void bt_bap_update_bcast_source(struct bt_bap_pac *pac,
+					struct bt_bap_codec *codec,
+					struct iovec *data,
+					struct iovec *metadata);
-- 
2.34.1

