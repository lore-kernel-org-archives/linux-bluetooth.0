Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5415C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Jun 2023 08:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239278AbjFGIX1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Jun 2023 04:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239059AbjFGIXZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Jun 2023 04:23:25 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2040.outbound.protection.outlook.com [40.107.14.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE2A138
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jun 2023 01:23:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBtKy4FU2PZzUoe09xGwM4nIYFA+baEAaZ9jEOfmvl9H34kl8lb4vtw4RfJ2ivj8fiY3AFs+oDp/kpLPL/OMx4SwBYKDBuPeKIwd/+cmWIJLf08IaN8nowftuXvbErBQ+xPQeEtoB0as+BgdqBGXYd9uXKR7zS03Pg699MoRWoBvjjll998dymR8BO1XzyR2e/3t4zW2nNlA5aChVHTdaPviULvYLrDpLZbzVaq0IRHIGbdfUY1tEu0H68zmNW6/kVEOlvxK3F+kCFwk7eWZzgudLe16g+DJi9rWbRO1BTRIHyedwWNgoQPMczl3L9EJ3TiDwAu0XY+QUxne9OaWGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4ykWHYTVC54qTXL+A2G37c9A0IHcP+mOdMu6vHMd1c=;
 b=f7TVmlsMJ/fPOcdd8Wn/e8Qsc8I0BJFOUC1yJzG4cyXLeQQR7EMhAsKiiF6Zm3SqRVIfSSRd1n3kEXYp1fyGoT8o1jUcZeRS5onxhHYUCLbOfidn87TVqbYmRzQjAnC0W+7huCJyl7OmcVsVI5V6RepKCECTVhm0XV1JHBeFVnJVM4LMc5uc/HJjchOzJx/1LnUNLDg3AMphmMLtmmqfW2SSMNQhL+UeygWjrA1o7Oy4ak6rPEJKoNmlI3g3nysJqBhoz3Ydyz7CVYxPvZ0/r/aEGOfwWs4kKyn3ZIRCryln/5+yuEBcxx+53zRm0Og+S5HxEyuQu//iNWN/d4PexQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4ykWHYTVC54qTXL+A2G37c9A0IHcP+mOdMu6vHMd1c=;
 b=Ox8OrceT5wOH1Fhxx2Gn7dgPQpa60rTGXVR5tKQUQbX7I0PxmdZPRX+O6mL4GdnAIMYyZy+03zOtvPQwDOvrp5580b7UNye/cmc9zaeEpIHEQzLIX/yHpgVGQyHIvPF/5Qo4rH8PKuDEuWXf/jhizixJfeYOsfp3RT6QNhiforw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by DB8PR04MB7114.eurprd04.prod.outlook.com (2603:10a6:10:fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 08:23:19 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::e8eb:cac:f3e3:1085]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::e8eb:cac:f3e3:1085%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 08:23:19 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Subject: [PATCH v4 3/4] This adds the initial code for BAP broadcast source
Date:   Wed,  7 Jun 2023 11:22:59 +0300
Message-Id: <20230607082300.4970-4-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607082300.4970-1-silviu.barbulescu@nxp.com>
References: <20230607082300.4970-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0101CA0083.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::51) To VI1PR04MB5344.eurprd04.prod.outlook.com
 (2603:10a6:803:4b::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:EE_|DB8PR04MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: 90dd976e-3b01-4d73-f0f3-08db67307379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zZxJqpwvMF77WlCBqlTKZ5NOSVXx9W1lQNzhYTJmbaoJ4rPrzK7spQApAM/4AmVf0LldPh2+868d4u+0w3zuW62CQu8kUHo+6Kxxag+mLluQPEHBc5mx/LRdz6YDzDaeDC54vps1Np4TMZgmRaEisFf1CFs64/4jdvVkbCXRoPO8dZOrUrqzfkPO8ddPysMVpTztQHkQr3HcoucWszt1Yjt+Fjxc4d/xc8fUiGbNrNRtAEzj1iEP3BfbahxbPpedpRGzj6IlBTvALN0iQ368dTOD4bOn6aqndlGUXWoAa3gAfwXyIBzp7lZTpx5xiChk8T02BvbspUNDqX667O9EuKogwTRtEAOVyqGcnzhi9uVSyHkUELVnZidqI7wQj716asxNYgdtOc5fjLUaQKD/qkhZZAEprGrd96F7I/gcaJeLZfz+HQYtbA+ShygeKcIo1cD1GVCsnq46oogkOo+VIMFaEv37kMEk2PdA9HbBkYVNEMFxHXXPVlBSHT1Isjalq98c5y7c93rJN8UeV+avcT/jTvEYwQBopfiAC5qjPWLi5fS7N8iV4pwver92/zMgz8rjfzGwbVcWpqdVK7D6q6E5MIJL4Cmgm/8nHC8t/1m9zEnWrCmHy2NaskU+PBVE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199021)(55236004)(1076003)(6512007)(6506007)(38100700002)(2616005)(41300700001)(38350700002)(6486002)(52116002)(6666004)(186003)(26005)(83380400001)(478600001)(66556008)(6916009)(66476007)(66946007)(316002)(2906002)(8676002)(8936002)(5660300002)(4326008)(30864003)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IzfWyaK6GBQY1EAVPoAM5Rop/U9fK+KPWYIPNh81IhKj9CUPOSMSh3hT7ozR?=
 =?us-ascii?Q?E9gDhg6KwfxAtswCeJL5eFqcijUmvXXeTPKYy0FGsmbpFuUF9nPWTnMNaeKJ?=
 =?us-ascii?Q?r5E7rVIrl+IETKzDKT2BNEMtLD2M24F4d9ERjPktQthUJd94Mp3RVS2BsdZn?=
 =?us-ascii?Q?1QJ0bgQE1FhqTu7xoFsvKS9B4TW8YQfK74XX5Q3JY8UfJlu7FiAew0akuetb?=
 =?us-ascii?Q?KMCa6LZSQlY+UAImBHlw6K2a5xaFQmm9Fc7cjnjWBYHau/kDj8mN0arRh0Ij?=
 =?us-ascii?Q?tH+IxSaX/r/vq9T0XcpypuMCBOj/B8EKnjH/lYwV7EYEt3929vWTkES88O+/?=
 =?us-ascii?Q?auixFJlNZykFdhFbY57c36oWZ4MCO56+BpgEVW1zoM7bJfg2ky0fhlQQ/AjT?=
 =?us-ascii?Q?Ys9mMmOQ5rS4r0UuqlOjed7E/JT/BMt+SJ7X5XlH+U9LOu64Xv6+UfeR7zvV?=
 =?us-ascii?Q?ECpwX45ooksCn63fDkdriXzBLrVtL52G3GD+Jt/EqcBsCQlTOA7ywJukyXbe?=
 =?us-ascii?Q?43G4DYWvTKu+dPfYIBm5q8quDIJQEPs0RaL3SCye4lNHrrw7Esw4/ZWoZAE2?=
 =?us-ascii?Q?yj7RcCLPp97V6nqbFJPvl9pmlKeOiygIR9ty12MEK4HZ8gHFhmawl+nUcvRH?=
 =?us-ascii?Q?uuZTET9gktgkT+uCZqLZ05UXmMAGzMFGTKS/RYEiZy1PGunC2fl4Cbb4dhcB?=
 =?us-ascii?Q?ocTe8lOnqDcjsLpl1tGwvhzSqmahozTV7Hsk4KPT4Nk4dYqOg1xZjFYSrcVm?=
 =?us-ascii?Q?Uenk9Z2whNCZrykZTOjRzhv4VI0ta24DhP7tUSNrsaYwkR5yqhPT4wBRmv3R?=
 =?us-ascii?Q?RjHKm0BTjmIhGJLjSuOudUNLojDWvzXqTyY7RdrOAwB6emOyZ7ilWDiQWYWz?=
 =?us-ascii?Q?fxvufDUj1CstCOQKipqJEHPvOJ2f9jhQSqkQNSEJRcqjthUwABjxfi/IW37I?=
 =?us-ascii?Q?cx++nl1IL6RLbL46hse49sM9I/I5p6UPWBfpC8veird4Kz3VTy8Jr9sMMG+3?=
 =?us-ascii?Q?Ir2IKo1XndH8GobxVQt1kN7dsaB+G3ho4jqjRGkddphEZTV1NwmTZ5mrWjpZ?=
 =?us-ascii?Q?5TwkDG6JBPPfOXGsQvMaCU0xtE7V0tNIHbPYt5I7ugKWAnpplTf/OLTLvkxs?=
 =?us-ascii?Q?CHCQFX2xaikqKjbRo/Rotq6b5SNWbXUyZN6nj2dIQ19FM2xl9I1RTazPfuN/?=
 =?us-ascii?Q?TpgytKwgZqc0BnyNSajoGJlFC78hMyWtL4kg0ccSqHauc3FYTrZoPZ4qR8Vt?=
 =?us-ascii?Q?ui+lYSxDHO3OB7zezlNjxXLp3DpgqR0+3SowUX+uViZcWVOqAOLsFEOKoR7v?=
 =?us-ascii?Q?NT+qdx4TNj9CbWFUeuBpoXNEBC/vyAqiGMlfmFWaMP8xFTa5AKmKUX1SNpOp?=
 =?us-ascii?Q?33K3ZtiGc1ogK4ekf2jzT6HUJAVKu/QdNhma4cTxOT7iz+ynmbnaHTPfKHqz?=
 =?us-ascii?Q?XL6kJuogwxQGbpW66RhX3d9Avy5xIcHrsmt6cXsULp/iCwkx93bX6IGSeqaf?=
 =?us-ascii?Q?wLG/T7saYSGsam4uc7+aw//ecyxeVdNaeyQ40TSveBknCzFhhuKs2w1HrZ3J?=
 =?us-ascii?Q?OL6OFqwmeUuNK3753TqaXpbcwAd4bWum+t4rEY7G3I7f6udcBy7ejpdhUw4k?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90dd976e-3b01-4d73-f0f3-08db67307379
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 08:23:19.7961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D2l7YeYQK8EhCGGfLd/VyYYZ+MxGEYP45vw95yI2HMSzYdK0WXx1Pb8PDFUEGutOZUM0nBgbnDZekBlGEQ11uCkiXKB/YXrcQiKqfMU1lT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7114
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds initial support for BAP broadcast source.

---
 src/shared/bap.c | 241 ++++++++++++++++++++++++++++++++++++++++-------
 src/shared/bap.h |   9 ++
 2 files changed, 214 insertions(+), 36 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 05d814cb0..9c80d21d1 100644
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
@@ -2421,7 +2507,7 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
 					struct iovec *metadata)
 {
 	struct bt_bap_db *bdb;
-	struct bt_bap_pac *pac;
+	struct bt_bap_pac *pac, *pac_brodcast_sink;
 	struct bt_bap_codec codec;
 
 	if (!db)
@@ -2447,6 +2533,13 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
 	case BT_BAP_SOURCE:
 		bap_add_source(pac);
 		break;
+	case BT_BAP_BCAST_SOURCE:
+		// For broadcast add local pac and remote pac
+		bap_add_broadcast_source(pac);
+		pac_brodcast_sink = bap_pac_new(bdb, name, type, &codec, qos,
+					data, metadata);
+		bap_add_broadcast_sink(pac_brodcast_sink);
+		break;
 	default:
 		bap_pac_free(pac);
 		return NULL;
@@ -2489,6 +2582,21 @@ uint32_t bt_bap_pac_get_locations(struct bt_bap_pac *pac)
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
@@ -2547,6 +2655,9 @@ bool bt_bap_remove_pac(struct bt_bap_pac *pac)
 	if (queue_remove_if(pac->bdb->sources, NULL, pac))
 		goto found;
 
+	if (queue_remove_if(pac->bdb->broadcast_sources, NULL, pac))
+		goto found;
+
 	return false;
 
 found:
@@ -3867,6 +3978,25 @@ clone:
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
@@ -4071,7 +4201,11 @@ void bt_bap_foreach_pac(struct bt_bap *bap, uint8_t type,
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
 
@@ -4184,42 +4318,51 @@ unsigned int bt_bap_stream_config(struct bt_bap_stream *stream,
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
+		return 1;
+	} else {
+		return 0;
+	}
 }
 
 static bool match_pac(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
@@ -4345,6 +4488,10 @@ bool bt_bap_stream_set_user_data(struct bt_bap_stream *stream, void *user_data)
 
 	stream->user_data = user_data;
 
+	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_BROADCAST)
+		stream->lpac->ops->config(stream, stream->cc, &stream->qos,
+					ep_config_cb, stream->lpac->user_data);
+
 	return true;
 }
 
@@ -4454,7 +4601,7 @@ unsigned int bt_bap_stream_enable(struct bt_bap_stream *stream,
 					bt_bap_stream_func_t func,
 					void *user_data)
 {
-	int ret;
+	int ret = 0;
 
 	/* Table 3.2: ASE state machine transition
 	 * Initiating device - client Only
@@ -4462,12 +4609,19 @@ unsigned int bt_bap_stream_enable(struct bt_bap_stream *stream,
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
@@ -4646,6 +4800,16 @@ unsigned int bt_bap_stream_release(struct bt_bap_stream *stream,
 
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
@@ -4681,8 +4845,13 @@ uint32_t bt_bap_stream_get_location(struct bt_bap_stream *stream)
 
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
index 0c42e730f..891b4b5d8 100644
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
@@ -160,6 +166,8 @@ uint8_t bt_bap_pac_get_type(struct bt_bap_pac *pac);
 
 uint32_t bt_bap_pac_get_locations(struct bt_bap_pac *pac);
 
+uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream);
+
 struct bt_bap_stream *bt_bap_pac_get_stream(struct bt_bap_pac *pac);
 
 /* Session related function */
@@ -179,6 +187,7 @@ struct bt_bap *bt_bap_ref(struct bt_bap *bap);
 void bt_bap_unref(struct bt_bap *bap);
 
 bool bt_bap_attach(struct bt_bap *bap, struct bt_gatt_client *client);
+bool bt_bap_attach_broadcast(struct bt_bap *bap);
 void bt_bap_detach(struct bt_bap *bap);
 
 bool bt_bap_set_debug(struct bt_bap *bap, bt_bap_debug_func_t cb,
-- 
2.34.1

