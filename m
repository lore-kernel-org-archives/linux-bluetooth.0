Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC1CC41513
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Aug 2023 16:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344879AbjHPQqa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Aug 2023 12:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344934AbjHPQqS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Aug 2023 12:46:18 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2074.outbound.protection.outlook.com [40.107.22.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A66B2D79
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 09:45:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2+fs6q2J9JGV/Baxsw8UzR03ZAvVb8AMKKkesv/aPWPLIGlzMZr/af7VcIO4v7ECWTufpbnhQW+r4KFdUipPElWkr651e30e0hud7Ofc5FGWb0ugW0OQySh2o40MbLMTuvzWbmj312NUsx/T4MGT7LrMmd9S5BhMxXa2/Mm/pqiq1ldfrhC+qqbHy2DjHIGA3+yMiu9dXlmOPMtR2ImE9nQ1QOLI/TdwoYSGdTcEsQIb03Au6Ryg40ST0IpBkvddpP2WPyJR1f9b1kqNsuo67pvRI8ixL+YAdEqhYU+Pj7MIulbHB13mFQFpndJddT0XaUo8PbPeGYFmPgEEy1DNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkF/yPAn8I1Vsryzb5t1nXIkobO9YYLDkcsYstmbVws=;
 b=B1F2pQS3V+3wI/i4p5JuVQOzs4Wt+ZUFwYcv37NSl4oc4V1oxH36dJSYYbcjUe/FUS/hCjwaFq+h2VorqYKl9LPY2XKckuZTPoS38Mwvs4VYj++Z05lj3cJllC2wjkcLJRbDWNS/+FdXPLgH6Azvl6SY5kYP7Vzb1pHu08OLzcXQleW8Lb0JUoS/+EbO4q1YMc4oPPiHu58DIaGPt98W9AuQtaNFSJ6U2RYD2hG10GSHOYxHXD7qcIgR3By+lniUF0gDoKZLxiR/dY4r7vKtHrqj8MyJMbLlIRo/mzZ4wmtyGI10MVTp3mlAY+x8huvq9NU0bKDFMXYVdg3hst0Qmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkF/yPAn8I1Vsryzb5t1nXIkobO9YYLDkcsYstmbVws=;
 b=h0Lm0vof/YHYbbocd74bNcHA8ccW0vm+TrDST5SPwKQ+MRUzKipPbkx6rMXe1+2gZVHTowzAzLerQGnxXKvtjdxOiHN3RuqfrrwkWg6ywEujNKAzINCpqh+FwZzy0bUcn9BGQSgXGkjB/VyaTXOVx/2Yuagm1OmKQJqL5vg+VxI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AM7PR04MB6997.eurprd04.prod.outlook.com (2603:10a6:20b:10d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 16:45:11 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 16:45:10 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v6 1/7] shared/bap: Add support for BAP broadcast sink
Date:   Wed, 16 Aug 2023 19:44:29 +0300
Message-Id: <20230816164435.5149-2-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816164435.5149-1-claudia.rosu@nxp.com>
References: <20230816164435.5149-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0047.eurprd03.prod.outlook.com
 (2603:10a6:803:118::36) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|AM7PR04MB6997:EE_
X-MS-Office365-Filtering-Correlation-Id: 066074b9-63f5-4988-011d-08db9e7827eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rdBvPi561R1pCNQqKPvN8qYUr8+Jy+jmdwCDwuzigXv7jViJw/0ospKKq3BOaT0RlL+Sqf47meQqsCYqf0WlhEAkDx3kblHyTiIRUTg/4cT063Tv1BlL07puDJw4q0c6zcRpZlkZk9eDG4JNN/aVvBJFX6b2fmR1b+pIVr7yC5mCq0WNQqXALZpPMLs4XI5Y13DgHanIXrTVd7lQcwa1N81sizX0X7+3ZkTOaYJQv/dFrNKlztZAa4Es6WZCNqJjB8EVMyErpEHyVxKsYPiwv+skQYr6OhZ1Qayde4GfUR5fQj6znFi9vuqgy2VqsEtrB/J+GFmXQqbTqsiTnL98XGZuZfjayESn9LmVvmTjKP72ceH5EXb+UoVvHMoZcSoQH4xp0i4SQpt4m0qKQhKz9SKezIpvSapOT/NNDjCaCHZFq6Oujg66Ak4kZSM24LGIeO7h1HL+cNs/UXF1o9gf74fEGpXUf1jAbmiitb5hfMxUX8Lbb/kJHJoW9qd6jZqLlPScaoYhn2bemhoqdvzVPtdYWazE40IER9seeXQ6CfUp4azRPjGQkDCwEMwH3/fthl3Hu702WAF0TQz41VnY/FA10cMuJhbgIIdEgK7bwDJ9zbfH8gXxjyTmF0E2dnwH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(6916009)(66946007)(66476007)(66556008)(41300700001)(5660300002)(38350700002)(38100700002)(8676002)(4326008)(8936002)(30864003)(2906002)(83380400001)(26005)(478600001)(86362001)(6512007)(52116002)(6506007)(36756003)(6666004)(1076003)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dSxEdROy4HmdnGdc9eEM1XCNcg24iJQRzABlJzDi7gfGVSO8QPBCT3o4S24l?=
 =?us-ascii?Q?Nm0w4xFi2rWXBm4mwpu1MMLzfGiePmvTzCIBcs95GaDKoiVoSrUBGASSTTfO?=
 =?us-ascii?Q?Ycx+N3L3FiBNuX2phu7zb8vIAxf4m3dMJA/nBMzNkOr5hrJpyUn0gXVMCPDR?=
 =?us-ascii?Q?fHP797Vun2njpLELlvdGL/63BNnZkHo7MB+7e3aw434hllyhXX0HGbpbpQ8W?=
 =?us-ascii?Q?v0gMrLN6qb3g3Kj9pJNXPimif70U871cL+kFtrs4/JHDzSh0Wqkb+pHWyYaS?=
 =?us-ascii?Q?TCCUqVCYSUwofDoiFsN07LFJdaHlPwAAanZ6I+JcfzTjtlM6OEmbwIzb9pjW?=
 =?us-ascii?Q?9uSnliWQoVDzyiAR0LTCM+OJwBc49jGIVI0CHbzfBM8ciTFNqYjBwU5IIaJM?=
 =?us-ascii?Q?FTZ2HPOHaFCRsmrMO4jRKyRF+NR60KHEC4F9Tf6detj+bBoWq7RFqQbhUUpJ?=
 =?us-ascii?Q?ND1V4Km66q2kYq/bIi32pUgO8j0GTjzvaLYoJISxMAF6t1ytwimPxFVvLq9b?=
 =?us-ascii?Q?yrX+291TsBjioy+NfLC+RJZgyASmZEh8KxBcs7PbYytzGWUeWb1Ftw2p0ZX7?=
 =?us-ascii?Q?0fT5BrkY0qLjSnWA+LB52YMkf4oSvhk/orNZ+mAMmYPfat0oXm7t/3Z0hPTb?=
 =?us-ascii?Q?uIj2FJa+gQPd9vtz9KAuZ/7IWQdvlAHmBMx/5JmpPVonAd3i4e1VX6wZkx3e?=
 =?us-ascii?Q?yHiV3aSAbmiGthoSuu9optfy3Kyavs9YtNOY3xcJfT09QinZYo578f1evDy/?=
 =?us-ascii?Q?g9TIm9ZR2FSAwW3CXZ9F5N0UmZA+1Lh+Iv0Nt2EyaU/IoRz0xj5/hlESKTc0?=
 =?us-ascii?Q?af6Pu2X4pRk4QPS3xKcEka2NxDO6n2PzIHehxw9U4+uN19jPhswitcUveana?=
 =?us-ascii?Q?yfvwQVX6O3zIZPgp/dAXNfaPeFvhk5gart/YfaMbI+1pxrliSOVB5gehYH+O?=
 =?us-ascii?Q?oUfUCWOu5Os2XE4iEVx7VWKG3oC+jupf3BhREBHyDh62fCABRfvfQy3vp6b6?=
 =?us-ascii?Q?SN6j4d5UpfQ7mWBqcDTAxBLD9isFMqb2Fra6q4oVyMQ8wOYBAt6fGd1a96kf?=
 =?us-ascii?Q?9gzxkKVz/+ivO3SFLmQfWRIsHOGtHRIvyoYgjm57/8EpRcEHr0vSZ94TgDC5?=
 =?us-ascii?Q?S5Nu1BIITFYVxq52mVXIcA4W/Sz92SWpTvm+sJXU8BkLpvW8as7XDxM2KGRX?=
 =?us-ascii?Q?e9xONTZ5zOsexvpcnhfQAsOqVW8+qTqx+C/2RjADnyHu7vsYkl0ISq5+fk8s?=
 =?us-ascii?Q?ezwZ+YFdAxfrUPR0tkCMhiSiuzT/sWoGtDR72U5A4hndMaFwCg8f3xAWAYYl?=
 =?us-ascii?Q?ftoihZeS2Hmrlf5++hJQ/AC1sxqvc67RvauE0ZiA0FX8fLSNm0/h/nCGFKSa?=
 =?us-ascii?Q?mQYh+xVdna6UK1mJbROZb2Zd99IRQiYyP8xn6vz65s4JtmZa5eQHKiXKCDel?=
 =?us-ascii?Q?O5XCy7gNwg/kLrisoZbAEE+//KCOPjgDlkHaASIDoVvuPOQXxZQnngQZwb4G?=
 =?us-ascii?Q?S6UN7kZmvQYeMgJTEONV4Fge82DUdwAN3v02XlzmZ/50cf7Uoktzhyp3aHnA?=
 =?us-ascii?Q?eNc5uStfN6xDrYtwIIjsu756wcWbZPMboHSA7ncS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 066074b9-63f5-4988-011d-08db9e7827eb
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 16:45:10.8826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SkvbUsLsFtbqDOqIlrh1d5T6Mw1wEQvFkUr9vQIH5pCkpOBRIIWg/L0nlp/P7O7h4mzapp2so78YaQwKdtjkVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6997
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
 src/shared/bap.c | 261 ++++++++++++++++++++++++++++++++++++++++++-----
 src/shared/bap.h |  13 ++-
 2 files changed, 246 insertions(+), 28 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 72ce67c08..c943f2e71 100644
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
@@ -2923,6 +2951,98 @@ bool bap_print_cc(void *data, size_t len, util_debug_func_t func,
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
+	uint8_t type, capsLen, metaLen;
+	uint16_t uuid;
+	uint8_t *hexstream;
+
+	util_debug(func, NULL, "BASE Length %ld", len);
+	if (!util_iov_pull_u8(&iov, &type))
+		return false;
+	util_debug(func, NULL, "ServiceType 0x%2.2x", type);
+	if (!util_iov_pull_le16(&iov, &uuid))
+		return false;
+	util_debug(func, NULL, "ServiceUUID 0x%4.4x", uuid);
+	if (!util_iov_pull_le24(&iov, presDelay))
+		return false;
+	util_debug(func, NULL, "PresentationDelay %d", *presDelay);
+	if (!util_iov_pull_u8(&iov, numSubgroups))
+		return false;
+	util_debug(func, NULL, "NumSubgroups %d", *numSubgroups);
+	if (!util_iov_pull_u8(&iov, numBis))
+		return false;
+	util_debug(func, NULL, "NumBis %d", *numBis);
+	codec = util_iov_pull_mem(&iov, sizeof(*codec));
+	if (!codec)
+		return false;
+	util_debug(func, NULL, "%s: ID %d CID 0x%2.2x VID 0x%2.2x",
+				"Codec", codec->id, codec->cid, codec->vid);
+	if (!util_iov_pull_u8(&iov, &capsLen))
+		return false;
+	util_debug(func, NULL, "CC Len %d", capsLen);
+
+	if (!capsLen)
+		return false;
+	if (!caps)
+		return false;
+	if (!(*caps))
+		*caps = new0(struct iovec, 1);
+	(*caps)->iov_len = capsLen;
+	(*caps)->iov_base = iov.iov_base;
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
+	if (!meta)
+		return false;
+	if (!(*meta))
+		*meta = new0(struct iovec, 1);
+	(*meta)->iov_len = metaLen;
+	(*meta)->iov_base = iov.iov_base;
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
@@ -4008,7 +4128,8 @@ bool bt_bap_attach_broadcast(struct bt_bap *bap)
 
 	queue_push_tail(sessions, bap);
 
-	ep = bap_get_endpoint_bcast(bap->remote_eps, bap->ldb);
+	ep = bap_get_endpoint_bcast(bap->remote_eps, bap->ldb,
+				BT_BAP_BCAST_SOURCE);
 	if (ep)
 		ep->bap = bap;
 
@@ -4198,7 +4319,11 @@ static void bap_foreach_pac(struct queue *l, struct queue *r,
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
@@ -4221,9 +4346,19 @@ void bt_bap_foreach_pac(struct bt_bap *bap, uint8_t type,
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
 
@@ -4243,10 +4378,10 @@ int bt_bap_pac_get_vendor_codec(struct bt_bap_pac *pac, uint8_t *id,
 	if (vid)
 		*vid = pac->codec.cid;
 
-	if (data)
+	if (data && pac->data)
 		*data = pac->data;
 
-	if (metadata)
+	if (metadata && pac->metadata)
 		*metadata = pac->metadata;
 
 	return 0;
@@ -4382,6 +4517,11 @@ unsigned int bt_bap_stream_config(struct bt_bap_stream *stream,
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
 
@@ -4434,7 +4574,8 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 		return NULL;
 
 	if (lpac && rpac) {
-		if (!bap_codec_equal(&lpac->codec, &rpac->codec))
+		if ((rpac->type != BT_BAP_BCAST_SOURCE)
+			&& (!bap_codec_equal(&lpac->codec, &rpac->codec)))
 			return NULL;
 	} else {
 		uint8_t type;
@@ -4446,13 +4587,19 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
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
@@ -4913,6 +5060,13 @@ struct io *bt_bap_stream_get_io(struct bt_bap_stream *stream)
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
@@ -4944,6 +5098,14 @@ static bool match_req_id(const void *data, const void *match_data)
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
@@ -5132,3 +5294,50 @@ bool bt_bap_stream_io_is_connecting(struct bt_bap_stream *stream, int *fd)
 
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

