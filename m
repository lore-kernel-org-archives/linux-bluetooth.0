Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DB8C7EE2C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 May 2023 14:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbjE3OPh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 May 2023 10:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbjE3OPf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 May 2023 10:15:35 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2074.outbound.protection.outlook.com [40.107.6.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F14E1BE
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 07:15:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXiMnpWleayWRDQaZLf+SdoA8/GYPlx7V4wa/8U5mNpkzeCVhw4zO6kIiDBMuiDYxGIuHC1HxWvsraHRlkQ1MLLhZr7yr5HXq5iqMrlu682XL/tP+VzT2HcM5ftoV2xAXdAAJF+Lsi1nXgm4vRjBfrF6j/WOIg0WG3tHXbhUXV5cXcmfosTi8A+eEizj6LUvXtiPtUpFJf3pwlzS1ygGQ92bbjeeD+k5P6LsLn83C0hlGevNCSdJCVkyH/drlzPUhFIwhJlrHBSV9KjuJ+Cz6VSimirUh1RkZGejiKngJiZNlvThjtQrPjQGFlPm2GhW0pKpq/k/gzzG0p82uOjqRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9PURCvLfRlWzmxstRD0oNpReiKJ28IbNP1wbLOeJgw=;
 b=NAZdHkogirtquSJZcnPl4jO+QnOt2G34zYEp46FhSEBA8orLiJuXiM0PEgTQH3qwK5yv/BQSqN13LWnaU9vIA9ts1nBkC11uGG/uPJMy2AnFpP+qCZiVrvL+Awnu9PDIvK91Fufn67i2mp6VNW7M3Ft8RVoAUsjOIffGKKxHMaQeerwIvB1/RXdXKayg8b9a9/V/JYqtxDG2grPmerzGVy4Eh1kRnRDBrC/RSCB1tUirkvXA8/42BwcGiP0UNRoBthGv6+KfvAW+Utuhwqfbp8SlM78/Zh1LQ0dLwTRw0CsYQaxnQri1/vl/KfbCEepSAtDI+J96F08svodwHOl7zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9PURCvLfRlWzmxstRD0oNpReiKJ28IbNP1wbLOeJgw=;
 b=WiGvZQnLp00PrbEf9qmKklEQCFCoND91iRsySptuTR9Bj+86tgQBEZYniOGrcT37OYMYrvCT3Xj2ayQXmDAgj0AIbC/kWEAPfxcyiBho+c1//DXeSPghns/h/e2PhkykwmsQ9dLzUT6u38JugNT546SaA6F1Eh+VcI6kRnaKtFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by DBBPR04MB7913.eurprd04.prod.outlook.com (2603:10a6:10:1ee::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 14:14:06 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::cedb:51d6:a774:f81a]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::cedb:51d6:a774:f81a%7]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 14:14:06 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Subject: [PATCH BlueZ v3 3/4] This adds the initial code for BAP broadcast source
Date:   Tue, 30 May 2023 17:13:38 +0300
Message-Id: <20230530141339.100733-4-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530141339.100733-1-silviu.barbulescu@nxp.com>
References: <20230530141339.100733-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR07CA0021.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::34) To VI1PR04MB5344.eurprd04.prod.outlook.com
 (2603:10a6:803:4b::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:EE_|DBBPR04MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: f5382157-072c-4099-5a0c-08db61182120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mkQhAwVOjarEfLeVlYWdGOaMNxcMlL0iXjGkeswdpd/Bb6/6KOkbZuQPwXycfV88PRF/GJUr1vqjEZ3XXc8se+vjvyfO1Wupw9NWtxEC8OfLf833C2Vs89GAg6udYzdYnNq9Cjy8s6JvYQ0kg0XWh4Qv4OZulJcc40nnk4Q1IfKR6OaYtRbT4oExMwploycRenvecYxG+17jS7KnpF52kygtPEi4NbTEge79zNOzl+mkuB+hAy5EE/yBU+Jx1i2jB4sUho1tzoYO9Yg/L3jz0TgslXlTUumwl8/6uY43+7N1lFTXbrboc7pUFKkJMUPfC9wYouxmvG2BofGv29ZwZmHCCn0rR7sLkXQsaHb+tjkyttxbxLaFT7PD00JwXiLwGwUfsz2eF/0MA9sNyvUwsPQWdpSjIvmBr0tg/rXW46Q+UXwaiivh3yGhqW9lwJBzBbu7513UUdiwhBhJq8eyk7VVXgyGsQ7ODp+w00IRzDB9UYF0Apad8JhgrsmgvP2CZWqLB7X9FMLFIrGiPzmJ3WI3U2K/lzO8dAB9m1XP+Kn6Dxi5rnG2sbA4UE3LQQZzo9mYUd3z5uxK42gHfcVM7c6ppdFOw8WzBlTAhx04qTv5MEJgadOISExNZ+L8dRi2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199021)(478600001)(38100700002)(38350700002)(66556008)(66476007)(66946007)(41300700001)(52116002)(6486002)(8676002)(5660300002)(86362001)(8936002)(26005)(2906002)(30864003)(1076003)(186003)(6512007)(6506007)(83380400001)(4326008)(6916009)(316002)(6666004)(2616005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t+b8j0n9Xjy3hebNZS1FNJRVnIkEUybQTTkxubj0c5dKoMlaBcGDp9R1mfvL?=
 =?us-ascii?Q?vyBTrymoXv0mAAdmQmQ0ByFnZ0JZUuT+FmSFF6zjwEjxYzqQgmG6R0BHtOv9?=
 =?us-ascii?Q?B2p9zQCVOgCYA1PwwFTzO5p3U3XugCswCT5+TolfWMhIZzJsZ0DXpH0hHTm0?=
 =?us-ascii?Q?fDsWS7qlR3tn0GyNRveXWQrgg2T5OeWMYPxJikulE42NqrsuYlJJXEQwyAkh?=
 =?us-ascii?Q?+96klSgfHvttAF3QjGnykMt4V8KEuj88zsF0X45stgMbDRkt1EGDsF2Y5quO?=
 =?us-ascii?Q?DymJ0o/e/HU2Lb4B8HCNdKQItjpViiJl20hHcWHIuQIWBgN0N279rm/bXOB2?=
 =?us-ascii?Q?FktuxhSuwUx53WwmcuOWK7VHjiPjSQo5uelXzFY1ExMtm9v+f3n7RsOfNiwe?=
 =?us-ascii?Q?W7C+malRBnDSHxGisJNB46DELbGnUSBxWgHGoii7cBpzHianlM2ktTGBlYst?=
 =?us-ascii?Q?7csYOdx1dhEIlKsXn/s3SCu6IxaRFZwyda1yq3D899hdNFfT6DBw/cGABHjz?=
 =?us-ascii?Q?Zi0dlcoAegkcmkYgfpqcL9aJR6QIJhNaN9lByy7+Q0/X35dAm7UHLqM47n99?=
 =?us-ascii?Q?boX9Cd7EaqxZdYyRsrLm/07sKsKjvAxbyx1RiHjFa8wDk9SpbEkJdxkR+ilN?=
 =?us-ascii?Q?2wSWU/Q/iYLiXUTZrT7AiQbViS0sCOk/DZfrMlm6Z9Vsy0hiqvrIC7wzHoqN?=
 =?us-ascii?Q?XNIOvoEF1UETLWJ/ECyHPXhR6cLGmaKnzNncc00dtF1rFe3qbt2OXayzpT04?=
 =?us-ascii?Q?zUBZJaBY04FL694bSrG3oT+FOrtM4CtOqqTLPqAOiw3jcMxM1gwkb8VKdAG4?=
 =?us-ascii?Q?r5KuLHvnqwHhm/zkSXZqqXXOOvEh9sPgSYzU8siD9Sv+kiUbeMg05/L3DK5Z?=
 =?us-ascii?Q?pPpQrSTnoIgUyyN6jILfJVSTdZCEg1m7KVzw/YcJvRQCJwOnnCqkjinqvI1b?=
 =?us-ascii?Q?MaBdytdrfzq6eMGA1Ab1JKw3gNnhn7Ue8v8/qSBTE+FZL8rHQ4hEWMDzr/8I?=
 =?us-ascii?Q?V/gYiw5cloYZ2BqLuSNifbMl8r8HwrHGF7QjhANSNmIPeOUIYhC9Q4VWGi2H?=
 =?us-ascii?Q?JUA9T/xBkLAGgAyWmmSWXqUYwqkKO5w7KjCsmzMlhnnlcZa3LuLqQFmPa0p7?=
 =?us-ascii?Q?iND3dTpckpzEOSGMGKxkeS61jh5x48wUYHviBHwSNAYDpugbcxEIBIqFZXKQ?=
 =?us-ascii?Q?Z6DI6Bmvcmbl2THZQ/uvG9qRTuPX7VPOMQMiTX1epDuT18NNikpKPidI/LbH?=
 =?us-ascii?Q?QX+RswX5MW/Fum3GUjIUlwJyEQbtbwMBZNwDk1tyq+Ps2IRV7sw60+7L0/ux?=
 =?us-ascii?Q?vpq42Z2ZmnepbiMcK6SHURInj+k3KMDawzkMZxOc8sRBT5gCKI1UyIvEv6RR?=
 =?us-ascii?Q?68190IL9FtML4wBRw/gj13uKphmx/FKscGCd6DKUTlySuhdezyCYdO8Venz3?=
 =?us-ascii?Q?tK9wfCJJaqQQASV2BsioJ4uuUx1sdfaKKSLXE13GvFpHeVw3YfVzKGswNSoy?=
 =?us-ascii?Q?grDOrCB/RCsjRQG2qtsdGG0gMW0yuY6RxVW5I3uXU9jnX4rP2MwZKGqDdgUT?=
 =?us-ascii?Q?J3FeG2vAay9m6ndBcbEIs9yhibXG1znjeHDEaG/6A+NVPN+QsNxioDH8JXNh?=
 =?us-ascii?Q?dw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5382157-072c-4099-5a0c-08db61182120
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 14:14:06.7500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cqgk708XD3OH7g+2+IPl+mNDBDTr0M7GXZ6bp2CSM0da+oveJyARi21Hcx0tDWuJPpiZ7v7pCxl4+7tRwbCyU4xjtaesXhG85Xb/aAiyyrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7913
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds initial support for BAP broadcast source.

---
 src/shared/bap.c | 282 +++++++++++++++++++++++++++++++++++++++++------
 src/shared/bap.h |  38 +++++--
 2 files changed, 274 insertions(+), 46 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index dd9eb797a..26f41be76 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -121,6 +121,8 @@ struct bt_bap_db {
 	struct bt_ascs *ascs;
 	struct queue *sinks;
 	struct queue *sources;
+	struct queue *broadcast_sources;
+	struct queue *broadcast_sinks;
 };
 
 struct bt_bap_req {
@@ -623,6 +625,18 @@ static struct bt_bap_endpoint *bap_endpoint_new(struct bt_bap_db *bdb,
 	return ep;
 }
 
+static struct bt_bap_endpoint *bap_endpoint_new_broacast(struct bt_bap_db *bdb)
+{
+	struct bt_bap_endpoint *ep;
+
+	ep = new0(struct bt_bap_endpoint, 1);
+	ep->bdb = bdb;
+	ep->attr = NULL;
+	ep->dir = BT_BAP_BCAST_SOURCE;
+
+	return ep;
+}
+
 static struct bt_bap_endpoint *bap_get_endpoint(struct queue *endpoints,
 						struct bt_bap_db *db,
 						struct gatt_db_attribute *attr)
@@ -645,6 +659,30 @@ static struct bt_bap_endpoint *bap_get_endpoint(struct queue *endpoints,
 	return ep;
 }
 
+static struct bt_bap_endpoint *bap_get_endpoint_bcast(struct queue *endpoints,
+						struct bt_bap_db *db)
+{
+	struct bt_bap_endpoint *ep;
+
+	if (!db)
+		return NULL;
+	/*
+	 * We have support for only one stream so we will have
+	 * only one endpoint.
+	 * TO DO add support for more then one stream
+	 */
+	if (queue_length(endpoints) > 0)
+		return queue_peek_head(endpoints);
+
+	ep = bap_endpoint_new_broacast(db);
+	if (!ep)
+		return NULL;
+
+	queue_push_tail(endpoints, ep);
+
+	return ep;
+}
+
 static bool bap_endpoint_match_id(const void *data, const void *match_data)
 {
 	const struct bt_bap_endpoint *ep = data;
@@ -1261,6 +1299,37 @@ static void bap_stream_state_changed(struct bt_bap_stream *stream)
 	bt_bap_unref(bap);
 }
 
+static void stream_set_state_broadcast(struct bt_bap_stream *stream,
+					uint8_t state)
+{
+	struct bt_bap_endpoint *ep = stream->ep;
+	struct bt_bap *bap = stream->bap;
+	const struct queue_entry *entry;
+
+	ep->old_state = ep->state;
+	ep->state = state;
+
+	bt_bap_ref(bap);
+
+	for (entry = queue_get_entries(bap->state_cbs); entry;
+							entry = entry->next) {
+		struct bt_bap_state *state = entry->data;
+
+		if (state->func)
+			state->func(stream, stream->ep->old_state,
+					stream->ep->state, state->data);
+	}
+
+	/* Post notification updates */
+	switch (stream->ep->state) {
+	case BT_ASCS_ASE_STATE_IDLE:
+		bap_stream_detach(stream);
+		break;
+	}
+
+	bt_bap_unref(bap);
+}
+
 static void stream_set_state(struct bt_bap_stream *stream, uint8_t state)
 {
 	struct bt_bap_endpoint *ep = stream->ep;
@@ -1397,6 +1466,11 @@ static void ep_config_cb(struct bt_bap_stream *stream, int err)
 	if (err)
 		return;
 
+	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_BROADCAST) {
+		stream_set_state_broadcast(stream, BT_BAP_STREAM_STATE_CONFIG);
+		return;
+	}
+
 	stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
 }
 
@@ -2222,6 +2296,8 @@ static struct bt_bap_db *bap_db_new(struct gatt_db *db)
 	bdb->db = gatt_db_ref(db);
 	bdb->sinks = queue_new();
 	bdb->sources = queue_new();
+	bdb->broadcast_sources = queue_new();
+	bdb->broadcast_sinks = queue_new();
 
 	if (!bap_db)
 		bap_db = queue_new();
@@ -2397,6 +2473,16 @@ static void bap_add_source(struct bt_bap_pac *pac)
 				iov.iov_len, NULL);
 }
 
+static void bap_add_broadcast_source(struct bt_bap_pac *pac)
+{
+	queue_push_tail(pac->bdb->broadcast_sources, pac);
+}
+
+static void bap_add_broadcast_sink(struct bt_bap_pac *pac)
+{
+	queue_push_tail(pac->bdb->broadcast_sinks, pac);
+}
+
 static void notify_pac_added(void *data, void *user_data)
 {
 	struct bt_bap_pac_changed *changed = data;
@@ -2413,6 +2499,54 @@ static void notify_session_pac_added(void *data, void *user_data)
 	queue_foreach(bap->pac_cbs, notify_pac_added, user_data);
 }
 
+struct bt_bap_pac *bt_bap_add_vendor_pac_bcast(struct gatt_db *db,
+					const char *name, uint8_t type,
+					uint8_t id, uint16_t cid, uint16_t vid,
+					struct bt_bap_pac_qos *qos,
+					struct iovec *data,
+					struct iovec *metadata,
+					struct bt_bap_pac_ops *pac_ops,
+					void *user_data)
+{
+	struct bt_bap_db *bdb;
+	struct bt_bap_pac *pac, *pac_brodcast_sink;
+	struct bt_bap_codec codec;
+
+	if (!db)
+		return NULL;
+
+	bdb = bap_get_db(db);
+	if (!bdb)
+		return NULL;
+
+	if ((id != 0xff) && ((cid != 0U)  || (vid != 0U)))
+		return NULL;
+
+	codec.id = id;
+	codec.cid = cid;
+	codec.vid = vid;
+
+	pac = bap_pac_new(bdb, name, type, &codec, qos, data, metadata);
+
+	switch (type) {
+	case BT_BAP_BCAST_SOURCE:
+		// For broadcast, add local pac and remote pac.
+		bap_add_broadcast_source(pac);
+		pac_brodcast_sink = bap_pac_new(bdb, name, type, &codec, qos,
+					data, metadata);
+		bap_add_broadcast_sink(pac_brodcast_sink);
+		break;
+	default:
+		bap_pac_free(pac);
+		return NULL;
+	}
+
+	bt_bap_pac_set_ops(pac, pac_ops, user_data);
+	queue_foreach(sessions, notify_session_pac_added, pac);
+
+	return pac;
+}
+
 struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
 					const char *name, uint8_t type,
 					uint8_t id, uint16_t cid, uint16_t vid,
@@ -2489,6 +2623,21 @@ uint32_t bt_bap_pac_get_locations(struct bt_bap_pac *pac)
 	}
 }
 
+uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream)
+{
+	if (!stream)
+		return BT_BAP_STREAM_TYPE_UNKNOWN;
+
+	if ((bt_bap_pac_get_type(stream->lpac) == BT_BAP_SINK) ||
+		(bt_bap_pac_get_type(stream->lpac) == BT_BAP_SOURCE))
+		return BT_BAP_STREAM_TYPE_UNICAST;
+	else if ((bt_bap_pac_get_type(stream->lpac) == BT_BAP_BCAST_SOURCE) ||
+		(bt_bap_pac_get_type(stream->lpac) == BT_BAP_BCAST_SINK))
+		return BT_BAP_STREAM_TYPE_BROADCAST;
+	else
+		return BT_BAP_STREAM_TYPE_UNKNOWN;
+}
+
 static void notify_pac_removed(void *data, void *user_data)
 {
 	struct bt_bap_pac_changed *changed = data;
@@ -2547,6 +2696,9 @@ bool bt_bap_remove_pac(struct bt_bap_pac *pac)
 	if (queue_remove_if(pac->bdb->sources, NULL, pac))
 		goto found;
 
+	if (queue_remove_if(pac->bdb->broadcast_sources, NULL, pac))
+		goto found;
+
 	return false;
 
 found:
@@ -3879,6 +4031,25 @@ clone:
 	return true;
 }
 
+bool bt_bap_attach_broadcast(struct bt_bap *bap)
+{
+	struct bt_bap_endpoint *ep;
+
+	if (queue_find(sessions, NULL, bap))
+		return true;
+
+	if (!sessions)
+		sessions = queue_new();
+
+	queue_push_tail(sessions, bap);
+
+	ep = bap_get_endpoint_bcast(bap->remote_eps, bap->ldb);
+	if (ep)
+		ep->bap = bap;
+
+	return true;
+}
+
 static void stream_foreach_detach(void *data, void *user_data)
 {
 	struct bt_bap_stream *stream = data;
@@ -4083,7 +4254,11 @@ void bt_bap_foreach_pac(struct bt_bap *bap, uint8_t type,
 							func, user_data);
 	case BT_BAP_SOURCE:
 		return bap_foreach_pac(bap->ldb->sinks, bap->rdb->sources,
-							func, user_data);
+							   func, user_data);
+	case BT_BAP_BCAST_SOURCE:
+		return bap_foreach_pac(bap->ldb->broadcast_sources,
+					bap->ldb->broadcast_sinks,
+					func, user_data);
 	}
 }
 
@@ -4196,42 +4371,51 @@ unsigned int bt_bap_stream_config(struct bt_bap_stream *stream,
 	if (!bap_stream_valid(stream))
 		return 0;
 
-	if (!stream->client) {
-		stream_config(stream, data, NULL);
-		return 0;
-	}
+	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_UNICAST) {
+		if (!stream->client) {
+			stream_config(stream, data, NULL);
+			return 0;
+		}
 
-	memset(&config, 0, sizeof(config));
+		memset(&config, 0, sizeof(config));
 
-	config.ase = stream->ep->id;
-	config.latency = qos->ucast.target_latency;
-	config.phy = qos->ucast.io_qos.phy;
-	config.codec = stream->rpac->codec;
+		config.ase = stream->ep->id;
+		config.latency = qos->ucast.target_latency;
+		config.phy = qos->ucast.io_qos.phy;
+		config.codec = stream->rpac->codec;
 
-	iov[0].iov_base = &config;
-	iov[0].iov_len = sizeof(config);
+		iov[0].iov_base = &config;
+		iov[0].iov_len = sizeof(config);
 
-	if (data) {
-		if (!bap_print_cc(data->iov_base, data->iov_len,
-					stream->bap->debug_func,
-					stream->bap->debug_data))
-			return 0;
+		if (data) {
+			if (!bap_print_cc(data->iov_base, data->iov_len,
+						stream->bap->debug_func,
+						stream->bap->debug_data))
+				return 0;
 
-		config.cc_len = data->iov_len;
-		iov[1] = *data;
-		iovlen++;
-	}
+			config.cc_len = data->iov_len;
+			iov[1] = *data;
+			iovlen++;
+		}
 
-	req = bap_req_new(stream, BT_ASCS_CONFIG, iov, iovlen, func, user_data);
+		req = bap_req_new(stream, BT_ASCS_CONFIG, iov, iovlen,
+					func, user_data);
 
-	if (!bap_queue_req(stream->bap, req)) {
-		bap_req_free(req);
-		return 0;
-	}
+		if (!bap_queue_req(stream->bap, req)) {
+			bap_req_free(req);
+			return 0;
+		}
 
-	stream->qos = *qos;
+		stream->qos = *qos;
 
-	return req->id;
+		return req->id;
+	} else if (bt_bap_stream_get_type(stream) ==
+			BT_BAP_STREAM_TYPE_BROADCAST) {
+		stream->qos = *qos;
+		return 0;
+	} else {
+		return 0;
+	}
 }
 
 static bool match_pac(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
@@ -4292,7 +4476,7 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 		if (rpac)
 			type = rpac->type;
 		else if (lpac) {
-			switch(lpac->type) {
+			switch (lpac->type) {
 			case BT_BAP_SINK:
 				type = BT_BAP_SOURCE;
 				break;
@@ -4357,6 +4541,10 @@ bool bt_bap_stream_set_user_data(struct bt_bap_stream *stream, void *user_data)
 
 	stream->user_data = user_data;
 
+	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_BROADCAST)
+		stream->lpac->ops->config(stream, stream->cc, &stream->qos,
+					ep_config_cb, stream->lpac->user_data);
+
 	return true;
 }
 
@@ -4466,7 +4654,7 @@ unsigned int bt_bap_stream_enable(struct bt_bap_stream *stream,
 					bt_bap_stream_func_t func,
 					void *user_data)
 {
-	int ret;
+	int ret = 0;
 
 	/* Table 3.2: ASE state machine transition
 	 * Initiating device - client Only
@@ -4474,12 +4662,19 @@ unsigned int bt_bap_stream_enable(struct bt_bap_stream *stream,
 	if (!bap_stream_valid(stream) || !stream->client)
 		return 0;
 
-	ret = bap_stream_metadata(stream, BT_ASCS_ENABLE, metadata, func,
-								user_data);
-	if (!ret || !enable_links)
-		return ret;
+	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_UNICAST) {
+		ret = bap_stream_metadata(stream, BT_ASCS_ENABLE, metadata,
+							func, user_data);
+		if (!ret || !enable_links)
+			return ret;
 
-	queue_foreach(stream->links, bap_stream_enable_link, metadata);
+		queue_foreach(stream->links, bap_stream_enable_link, metadata);
+	} else if (bt_bap_stream_get_type(stream) ==
+				BT_BAP_STREAM_TYPE_BROADCAST) {
+		stream_set_state_broadcast(stream,
+				BT_BAP_STREAM_STATE_STREAMING);
+		return 1;
+	}
 
 	return ret;
 }
@@ -4658,6 +4853,16 @@ unsigned int bt_bap_stream_release(struct bt_bap_stream *stream,
 
 	bap = stream->bap;
 
+	/* If stream is broadcast, no BT_ASCS_RELEASE is required */
+	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_BROADCAST) {
+		if (!bap_stream_valid(stream)) {
+			stream_set_state_broadcast(stream,
+					BT_BAP_STREAM_STATE_IDLE);
+			stream = NULL;
+		}
+		return 0;
+	}
+
 	/* If stream does not belong to a client session, clean it up now */
 	if (!bap_stream_valid(stream)) {
 		stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
@@ -4693,8 +4898,13 @@ uint32_t bt_bap_stream_get_location(struct bt_bap_stream *stream)
 
 	if (stream->ep->dir == BT_BAP_SOURCE)
 		return pacs->source_loc_value;
-	else
+	else if (stream->ep->dir == BT_BAP_SINK)
 		return pacs->sink_loc_value;
+	else
+		/* TO DO get the location values from metadata
+		 * for brodcast source and sink
+		 */
+		return stream->bap->ldb->pacs->source_loc_value;
 }
 
 struct iovec *bt_bap_stream_get_config(struct bt_bap_stream *stream)
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 0c42e730f..f1dab5f39 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -17,6 +17,12 @@
 
 #define BT_BAP_SINK			0x01
 #define	BT_BAP_SOURCE			0x02
+#define	BT_BAP_BCAST_SOURCE		0x03
+#define	BT_BAP_BCAST_SINK		0x04
+
+#define BT_BAP_STREAM_TYPE_UNICAST	0x01
+#define	BT_BAP_STREAM_TYPE_BROADCAST	0x02
+#define	BT_BAP_STREAM_TYPE_UNKNOWN	0x03
 
 #define BT_BAP_STREAM_STATE_IDLE	0x00
 #define BT_BAP_STREAM_STATE_CONFIG	0x01
@@ -128,6 +134,25 @@ struct bt_bap_pac_qos {
 	uint32_t ppd_max;
 };
 
+struct bt_bap_pac_ops {
+	int (*select)(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
+			struct bt_bap_pac_qos *qos,
+			bt_bap_pac_select_t cb, void *cb_data, void *user_data);
+	int (*config)(struct bt_bap_stream *stream, struct iovec *cfg,
+			struct bt_bap_qos *qos, bt_bap_pac_config_t cb,
+			void *user_data);
+	void (*clear)(struct bt_bap_stream *stream, void *user_data);
+};
+
+struct bt_bap_pac *bt_bap_add_vendor_pac_bcast(struct gatt_db *db,
+					const char *name, uint8_t type,
+					uint8_t id, uint16_t cid, uint16_t vid,
+					struct bt_bap_pac_qos *qos,
+					struct iovec *data,
+					struct iovec *metadata,
+					struct bt_bap_pac_ops *pac_ops,
+					void *user_data);
+
 struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
 					const char *name, uint8_t type,
 					uint8_t id, uint16_t cid, uint16_t vid,
@@ -141,16 +166,6 @@ struct bt_bap_pac *bt_bap_add_pac(struct gatt_db *db, const char *name,
 					struct iovec *data,
 					struct iovec *metadata);
 
-struct bt_bap_pac_ops {
-	int (*select)(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
-			struct bt_bap_pac_qos *qos,
-			bt_bap_pac_select_t cb, void *cb_data, void *user_data);
-	int (*config)(struct bt_bap_stream *stream, struct iovec *cfg,
-			struct bt_bap_qos *qos, bt_bap_pac_config_t cb,
-			void *user_data);
-	void (*clear)(struct bt_bap_stream *stream, void *user_data);
-};
-
 bool bt_bap_pac_set_ops(struct bt_bap_pac *pac, struct bt_bap_pac_ops *ops,
 					void *user_data);
 
@@ -160,6 +175,8 @@ uint8_t bt_bap_pac_get_type(struct bt_bap_pac *pac);
 
 uint32_t bt_bap_pac_get_locations(struct bt_bap_pac *pac);
 
+uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream);
+
 struct bt_bap_stream *bt_bap_pac_get_stream(struct bt_bap_pac *pac);
 
 /* Session related function */
@@ -179,6 +196,7 @@ struct bt_bap *bt_bap_ref(struct bt_bap *bap);
 void bt_bap_unref(struct bt_bap *bap);
 
 bool bt_bap_attach(struct bt_bap *bap, struct bt_gatt_client *client);
+bool bt_bap_attach_broadcast(struct bt_bap *bap);
 void bt_bap_detach(struct bt_bap *bap);
 
 bool bt_bap_set_debug(struct bt_bap *bap, bt_bap_debug_func_t cb,
-- 
2.34.1

