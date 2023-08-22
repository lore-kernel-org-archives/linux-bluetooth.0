Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94459EE4993
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Aug 2023 14:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236782AbjHVOcl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Aug 2023 10:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236788AbjHVOcg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Aug 2023 10:32:36 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2066.outbound.protection.outlook.com [40.107.6.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F397F3
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Aug 2023 07:32:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PD9AzTgN4xWHSW0/xsvQ7lRj3wKengXMMjx2zK2VVvTCUzGjvPcF1WJErBpPpn2ZKFz98UbscJm966LFPEgCGy6WqjWuFAPjCoq5Fl+IBDwFUhZ0gWlDlEw7KX4F8YQBPbN9fFdGP6Cy7uhGuXhGCt4YKCUXmH22RaF1XgMS9GyWVZ8GtdjUmtjTjGvXrNsP1fFWWoMiK7q/uKXqblvAPIMQISqJRTj9dsi8wDBsUK44Q5c5qmITU2nJ+p6IV6glr4JyD+sDftGJouCoYPS6ItU8dNMgu4QH2svOS4pEfJcZNhdtg+/B7GgHSvcUTKHmcxXbD8sBOrmHb4zPTDaeKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1BKn2AJtHWg2SxweNXPXyyWKUHZ1NMmVxu7wrXNzJM=;
 b=T3JScYgH/VHT3sPHx7lliqXsuK127sgr4XSEathr7EH6kCqakQW0pDjpN1bwRqxxBxazagd2Zmpvkt6y/R6oPpTikdTyhT0AtEFU7rkurdmrUkXi5DwXLnTpkOm+8WHSwhTlQrihR9G8FmKaiLRg/6BW/RuHFRreLdhAtIuIvt3Wr6WxjVWTiARv4xV+zK1bcV5Vkk2ebY2GDpiIlm1eNjBCQiCDl34Lw6IvbF3XvQJyo7ZfAktuZBWpQIZ/qf9CWPNirLk4W7+Ui6dqY5WvULbV1shXJc7LqhTbF24sOgI3vUix4kAnX/sOBABozVFQTubAVEmtFqw3UG86JyInNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1BKn2AJtHWg2SxweNXPXyyWKUHZ1NMmVxu7wrXNzJM=;
 b=RZ05FuiocwZhe+KiTgjqW07WCyesppowKJJzXwsY7Slf/jf9IPXAb1C+VCQzpqx8ljlCiKr5sEV9w2dqfT8wO6Zbnp6ERA9Bbxn0GhwmETPp1aBDJj9IfSX8hnp1dUw7dYGU01ZGeWYuYuZjnicdWfdoUwOO9KtFFaHTSGHsRjs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AS8PR04MB8707.eurprd04.prod.outlook.com (2603:10a6:20b:42a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 14:31:50 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 14:31:50 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v8 1/6] shared/bap: Add support for BAP broadcast sink
Date:   Tue, 22 Aug 2023 17:29:30 +0300
Message-Id: <20230822142935.6016-2-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822142935.6016-1-claudia.rosu@nxp.com>
References: <20230822142935.6016-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0041.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::15) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|AS8PR04MB8707:EE_
X-MS-Office365-Filtering-Correlation-Id: ca3bb737-ad08-4b01-f605-08dba31c85dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gnsrq8UoTnRQ58B5m36rEPS8aJxWOI35bJYc+CDXbanPNcEO2zCEKVfgXwzR9CKmDRm1Mu6KNXpJ4EL6TOPLFRKURRxWIhtUO8pG4HKv74UjiUWHue1oUwejuTRPC4s5lYlLEmKXiX4SnJD3FlMy/ixF0JQ5QH1sMhA4Hb1kFAgub8sZxKPb/uFx8tF1KRMdeYngPkc7KfFzVT84S9HIiTpnPgWfBC5vkBR9ruy9Wa3dlQMAvMFcSZ9BoMKLZJrz/3LEkF6foIRuN+fA3TEqhFzuFAXMaxXe2tagi2daQcYAuhoWS9SVPO5A2juEuJRqDKOzFcO75AFniIke3ULcmtCw5OB6hltOoy3XtCVOzToSt1+z6OwraZKSo5rDlaQLOwhOjXXpsGbD49R34C5vQtCOvMFlepCXg1vPmykUmuMvxI3JoMgIgNVq2j+PLoSRDw2dQgOOejlI5p8TffTB64zUOzw5DrF3xjr2OYkChGyTeytCzCPLboEj9TqMEs0BmlAma2tzFsxVzY9NDajaQG7zMSDZ1UwJ30V2Q6k8GcLluvbCYQcyYeaFH5jZ+KNwE3y10fnTf5wW5wgglcp4I0uHPBz4V8E79iyfGNTXZRl/IlzZgXRDrJQWb32pCmuN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(346002)(366004)(1800799009)(186009)(451199024)(6916009)(66476007)(66556008)(6512007)(316002)(66946007)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(1076003)(478600001)(6666004)(38100700002)(38350700002)(52116002)(6486002)(6506007)(55236004)(83380400001)(30864003)(2906002)(86362001)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X/q4RAcgxgU/u+SYUJKeBzZyiDYPBW36ukC5kLd6KnrfIQHOv7ThBIpQAMBI?=
 =?us-ascii?Q?qJLjG7j6qZ3EL4jAZclDozGuY2jgYJIHA5E7gJn8KheKQ+oynBo+a8tbGOAP?=
 =?us-ascii?Q?Qhl+D8JXi4GHiO8TimJ8+qmk/SgEFRv7WxjPiPgP7hPOdDgnRofjfqDt+uGC?=
 =?us-ascii?Q?Cd352Y9PHvWocPCVaMkN+9NLjx51HsAxKQJbznxtDYbyBpYoLElFb52E0B2l?=
 =?us-ascii?Q?5Qr3DNs4h+jGs5WJJs77ZqPjfoCT+YMnZLv8Zw2p2x4oW6nPEsCH9nUtGAau?=
 =?us-ascii?Q?ikqzkZLWJjjcaYJOVOHrt4JR18/a+5adI92x4W09TyuFvotKUaufj14PAjh7?=
 =?us-ascii?Q?qawAEXkQSygnBeBM4bkV+Rj4OxlVufxx3l4UAFoeN0LHLHkboKlZ3xJyqRWr?=
 =?us-ascii?Q?dXCYTFDTYfu+gGek4T1dcK7crfhkBRsU542jkP3skX25rQ4URER4R0daqEb/?=
 =?us-ascii?Q?A7gMrLxmmJf9aHO2e8aCxncDLiofo8fuZzD0QgZyKn+JOMNPtwbCGsPZ691/?=
 =?us-ascii?Q?KC5NT4p0cVuaqqxKa28XieNWtQvwZNjVZYcqoSWfN9Vx9slE4gaOYzcdiPC/?=
 =?us-ascii?Q?pgrgmiV+dDgR6SyodobFz6MvJHsySDlmS3ibmg4bYiuM2zB8wuk68G6u2kDx?=
 =?us-ascii?Q?hAV66moCzvouLNSdEKE8xuaCOjQBDaJ/NAYFYG+z29FJgtRoW4W3o60wgdXY?=
 =?us-ascii?Q?wad0QqTRQ3CbcgGInllCEWjcY6mqu4E9HAGo7KmkI2oC835QLqgsZ3njVRPQ?=
 =?us-ascii?Q?VaWh0kv8rYFqQ1JAJE4I/43b9eQjrAazhOYhPkVgt8YkdtZ8h8MjFb0JVKGu?=
 =?us-ascii?Q?+KR+wGK8YRhJUo3EvSFXORGea1AB6nKP0WoWCLDgbtWcrh+1NvultWp3/67A?=
 =?us-ascii?Q?489sISPc1Vy6h+aSVNA9r+0pmqRt+9UZsqatMZqiiU2xgyhlsVy9FYW6BkIh?=
 =?us-ascii?Q?2qhUxmuYcu2yBqEtWKVpEeBbLpRbpllvUEkFxgEAnjPlB6KrcnUTE3fxXqsY?=
 =?us-ascii?Q?mPa3jMDfuqDv5tG7plnSYVG5uiUwr7h1S/v6t+u5Zsn9379wXkmJNNBUv6Bh?=
 =?us-ascii?Q?Oh5uwdWsy4cfWnGOymkCxAxAfzjDAniPoobUJ2ATofS/EPubA5is3lQA+nhs?=
 =?us-ascii?Q?yKZvMiqXnIsCfQwtwTDaK/rzPH1MTdlittvy0yyLyP4o/5VE0kPlQmdnF4lO?=
 =?us-ascii?Q?gzU8rjYLUKLp/2XDSFgdDhpLArpJ3tAsxnDU0swVs6mHD4WeWcU+U4L5pCXK?=
 =?us-ascii?Q?9AyRxWW9jwO98lI/BsiNopz7XpVxa/TEl5Z/WY9cmSFiur3nt3ULCwzZXuIJ?=
 =?us-ascii?Q?Y3DDdUfa+wLVHvGzppm+F1tVrIhi5nvOYpsnQXGrh/UMreLwMpS5SNXXGI6t?=
 =?us-ascii?Q?bJexuPyiqjyhD2Ipjtk+oknFUehurw9+oeS7Zz357fRu7L7R2zvucoSBYasG?=
 =?us-ascii?Q?/KE7o3tP71EZJ9zpxz/Noxo+nnGkcrwuhx5VSJsjUErQYXa7XPbKNKQxv8bN?=
 =?us-ascii?Q?RLqGsbAN+dL0UtVbTQk7khvLpp+Z6J/alVzVX2eeZcVTcRPEY4hUmwjsNX6W?=
 =?us-ascii?Q?SYNBFc2e5Ndp3I0i31EmfhE2RNrkg5Uox4Pw4pee?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3bb737-ad08-4b01-f605-08dba31c85dc
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 14:31:50.5259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /WhwC2zPYo2ldZ/He4hFsea95BeXL2U2LIKKXkA4+D2tWLtu89eeWj60qoGX9QQcAw9VzECq6g2/JQy7ro1RcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8707
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
 src/shared/bap.c | 169 +++++++++++++++++++++++++++++++++++++++--------
 src/shared/bap.h |   8 ++-
 2 files changed, 150 insertions(+), 27 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 72ce67c08..1c43680c2 100644
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
@@ -4008,7 +4036,8 @@ bool bt_bap_attach_broadcast(struct bt_bap *bap)
 
 	queue_push_tail(sessions, bap);
 
-	ep = bap_get_endpoint_bcast(bap->remote_eps, bap->ldb);
+	ep = bap_get_endpoint_bcast(bap->remote_eps, bap->ldb,
+				BT_BAP_BCAST_SOURCE);
 	if (ep)
 		ep->bap = bap;
 
@@ -4198,7 +4227,11 @@ static void bap_foreach_pac(struct queue *l, struct queue *r,
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
@@ -4221,9 +4254,19 @@ void bt_bap_foreach_pac(struct bt_bap *bap, uint8_t type,
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
 
@@ -4243,10 +4286,10 @@ int bt_bap_pac_get_vendor_codec(struct bt_bap_pac *pac, uint8_t *id,
 	if (vid)
 		*vid = pac->codec.cid;
 
-	if (data)
+	if (data && pac->data)
 		*data = pac->data;
 
-	if (metadata)
+	if (metadata && pac->metadata)
 		*metadata = pac->metadata;
 
 	return 0;
@@ -4382,6 +4425,11 @@ unsigned int bt_bap_stream_config(struct bt_bap_stream *stream,
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
 
@@ -4434,7 +4482,8 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 		return NULL;
 
 	if (lpac && rpac) {
-		if (!bap_codec_equal(&lpac->codec, &rpac->codec))
+		if ((rpac->type != BT_BAP_BCAST_SOURCE)
+			&& (!bap_codec_equal(&lpac->codec, &rpac->codec)))
 			return NULL;
 	} else {
 		uint8_t type;
@@ -4446,13 +4495,19 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
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
@@ -4913,6 +4968,13 @@ struct io *bt_bap_stream_get_io(struct bt_bap_stream *stream)
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
@@ -4944,6 +5006,14 @@ static bool match_req_id(const void *data, const void *match_data)
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
@@ -5132,3 +5202,50 @@ bool bt_bap_stream_io_is_connecting(struct bt_bap_stream *stream, int *fd)
 
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
index 50b567663..edb5c1bed 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -289,7 +289,7 @@ struct bt_bap_qos *bt_bap_stream_get_qos(struct bt_bap_stream *stream);
 struct iovec *bt_bap_stream_get_metadata(struct bt_bap_stream *stream);
 
 struct io *bt_bap_stream_get_io(struct bt_bap_stream *stream);
-
+bool bt_bap_match_bcast_sink_stream(const void *data, const void *user_data);
 bool bt_bap_stream_set_io(struct bt_bap_stream *stream, int fd);
 
 int bt_bap_stream_cancel(struct bt_bap_stream *stream, unsigned int id);
@@ -305,3 +305,9 @@ uint8_t bt_bap_stream_io_dir(struct bt_bap_stream *stream);
 
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

