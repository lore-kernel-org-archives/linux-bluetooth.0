Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA93CDB465
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Oct 2023 13:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345821AbjJSNzH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Oct 2023 09:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345827AbjJSNzG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Oct 2023 09:55:06 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC543124
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Oct 2023 06:55:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yj/8pS8yzfe0dGEkkfO373qhUQEQKRxKU0/XVjbewieu/mHyGYrdpz+GoNSYGLkoyNYarb+0pPtWXErH0VmvoAYP2rs4P/dyLL5Umb/YNdPxuKJXIrzB/vShkc8MOltQVtIay3KULYvBcntOyUp9zwH3y6k2I9hliainxnCcjA+/MJ63Rdao5/h+4g7hCmlC1tgKIZiglwt+Or1vD/J9ntZZW+gR9z12RImRJEG7kCP7JQFg5NvHSoT0Lsf0hsMGo+5sRrt4NQ55cBnKziCSZlmwVwuG/Cww+EMqu9HLNYycdVOKxMoACTzzmITod8lE/wOy7suIhBjpUINFaa7tdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7g77DBP1wAGce5yJ3vc9M7CbCH2UmU/jp8VAIXeG2Y=;
 b=WNT6dIOyZWGT4Bf0P4DGw8mft1rLXtrf+3XZCMVvT5mJEep6NLEu31rR84G4zuyaFpceTGU0TAyE+XRyHCglpJR+6V0lX+Mam+CW2UbPhdSGQajO4x+xNcVMw2nHwaLFsbiqRRumAcNKRxdJzWpaHTwm1vnPdVyTpn9a6d+SYE03Q5AmVFTMbuN9LEB8ML7pFWPEUzqqmUgTXk1l3VMmTyFdMefMOlcobjCPZLQgSLUXJVvuAWDhjEDGOkhkHgJFjmZcLtwcXaCVpPsqM9/wrydpTiqHMxdfPFuakFKLPRHuAicRL5OWvl7uPt3XKZOFbW+J0XrQPu9KWkda9WnoIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7g77DBP1wAGce5yJ3vc9M7CbCH2UmU/jp8VAIXeG2Y=;
 b=OAICG1BuojMwAdS1ADdKzMVrTF0KyXNXDRwJfwPcs/LykD2kk//h4O+25XQ1g+13l6x7WSOITK2rzdC4rfKzn+w2wN89X/RThgRaf8bK62h6D1Xtei8f6YWtW2VJpQGbPJjNxIF5mPEHrbGyMMsM9kqPmjYLB0qsTsFYOijVsSo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AM9PR04MB8729.eurprd04.prod.outlook.com (2603:10a6:20b:43c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 13:55:00 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::a53f:4bda:e012:a73d]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::a53f:4bda:e012:a73d%7]) with mapi id 15.20.6933.008; Thu, 19 Oct 2023
 13:54:58 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v2 1/2] bap: Fix source+sink endpoint registration
Date:   Thu, 19 Oct 2023 16:54:42 +0300
Message-Id: <20231019135443.3806-2-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231019135443.3806-1-claudia.rosu@nxp.com>
References: <20231019135443.3806-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0220.eurprd07.prod.outlook.com
 (2603:10a6:802:58::23) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|AM9PR04MB8729:EE_
X-MS-Office365-Filtering-Correlation-Id: 73d78354-de01-429b-2bd5-08dbd0aafb77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SZe0LJthv0A5f8WTKQqe8EYb21pqmeXL/wmnWT2HjYISeFsjDO+SW/Q0g/ewx1BSEnC3s/32oyGD0Vo8+qZGd7u8KdyfbO5mb9VI8Rmjlu26+HQZ58L0PUv+K58A7+Mt+xC38k93nZ6fUrmGEeAJBcjdSqRUqCg4mRtBQBdMJGU3nRIu5mKHhEw9hR70XxQ63SP+QLlardcf+CjjNzI223Hiv9y99bZyqRhCw9dtTopqCShPSPqsesFyto4tRypgbgPDF8b2xswYsxFWoY783W8MYRMsw/5RsrhKvGRZ2dX9+Vh2r84l1alvMjqNd6MnuPxj+k/PrPy902N0sWnVrx71J1rnYtH+7N2j3DHEKvQR0ozhp7fNHPoSvPQulzmyHIcs1r2ktiT5ERLBm+DSMqSxjITk2tlzMEA6L/0c47x8tajikGCXPGFoFxCVSBHmZz6zEC0kUDcMpuQ9d32mYQ1O67z8RVPC6Ph9B8KfFODFpNV75A+X0wBT23vh+gjeBpr2xflrHXAz7YgEKS1/R5O65MsiIMh+2SN7HCZ9z2QMOVgdD54f7ZAhHViglJ42
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(396003)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(66946007)(66556008)(66476007)(6916009)(316002)(6486002)(478600001)(6666004)(2906002)(86362001)(5660300002)(36756003)(4326008)(8936002)(8676002)(41300700001)(2616005)(1076003)(38100700002)(83380400001)(26005)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KMCRbCYoWbga8t4JS3K8Kki/AjUSr+hy8ahXp1TOjlbp1hG2i8ylSHN3qoCf?=
 =?us-ascii?Q?O4r3yb6DKPhiNAOosp1FSjuWdGYyXIjzE3h4rW8ObmYtArDXQkazaucohYAg?=
 =?us-ascii?Q?d+Tz3YIQpmN4B3yqKv7vpYetg1tRwBG02KNQCrKiA4XY8t/Gq/C9oiG8Ljid?=
 =?us-ascii?Q?BvEz8H/i3GuK7S/4lqCVbp/i5TrB/bs+S2zXJAVpf5nrDxT9h/cl912pCb3r?=
 =?us-ascii?Q?hnVQ0lWx0TXOWJcvG/Ov3VYvJ8jR4k43+cH8Vp5HdDCWUXK0uyCttPiU8Eui?=
 =?us-ascii?Q?BX8lIHeO/Gmm19vmbPbvD7mBZ1YSyGyEcJKVVsYDFoHJnEKm5pKstsZsVKpL?=
 =?us-ascii?Q?YYWG6Nefh/dFoBWTKp8GEIq/pN8Sm3miXWvQioOoICQ1+yAvIyzT/w6Keanu?=
 =?us-ascii?Q?+VcXmP4TrMVAebct445FRqaA5faug8e2JhR36zYSoxPTcsaawrcr2AyW2z6A?=
 =?us-ascii?Q?W/QSSveczPlSMHF81HmlubFyhT/DCWa5nvgt0eAK5eacAQEV9DrhxFyrpy//?=
 =?us-ascii?Q?D2wFA7bKEGing4pnEhL5qlN1lEYuuyvsi61t72lrTLvs7jivr138KGQTMRzr?=
 =?us-ascii?Q?MvxA8id5SRFUnX8PTNKwUYmSWy68gzmVenXEqr2X8BFzMq5pmvqzyE22Yw3h?=
 =?us-ascii?Q?t8Qz9N2mxLWIAJWURvlbwNJepWK/h1G7n2b8m5Y0GXeo7TVGpf2M8U7ZG9ao?=
 =?us-ascii?Q?m0ezsO/3CovL+/VwpNta3yU32AEU9268XOKog/j6bjz25mwTni6LPvLqiZvW?=
 =?us-ascii?Q?AOSrQyLwEl73TP/Wf0neWVszL7hzQSPIqr/Me+fHSGL7d2PcumnRDEYQTWDK?=
 =?us-ascii?Q?S1zvR1GTYvaMO8tgn6iFfraaYqgcuzJMzIjlFGlsG80f5jSlV/tuclSpb8iQ?=
 =?us-ascii?Q?Mhd/s2gyqoceJ8Bzt2ml8DW1HNotjQoyUcxh77Y3bEHezb9n+1uxA5z5pE6i?=
 =?us-ascii?Q?f9pm4esbu2IdC7dMYMbZpBk68hSxL8WLtPV0SWQ9V/t4eV5iOTT6xWTj/JaV?=
 =?us-ascii?Q?VTqU/rr4bQBmd8KgZWRIhYafp6uK0h3MLyQqxBj4fez1I5XQugUblyX1IPho?=
 =?us-ascii?Q?O5dTR834btm4yeYScBPNMA6EWbn/rufI8OLtwlbgO1hxlryaBQpt/bvz1XXE?=
 =?us-ascii?Q?sH8RGmgTW4CJyFMRia85xyi9jKdxS0LaTj031R9Ml+juJ1j2gdXt+v5Dj2th?=
 =?us-ascii?Q?T3Tgx1O238nsvBHX7M8HotrvpGzYnjrLXHQ4crauP9FkKkyVK6fN52oeBc3q?=
 =?us-ascii?Q?7YcxvIX381pnMXJKXm/GI6d0vykwIRTwkAMyl+qjKatez7UWS94c80gjnsIR?=
 =?us-ascii?Q?7i2vEm0nSq1hX17f0Jf6o7Ma08/ZDSGGn8C8A2XVVmmY8tRmTDT/sKYVRnTB?=
 =?us-ascii?Q?DunUge1MEzqWIZwedUqUEs/nZRifL9HUbzaQSjUA+aAgAL+9mxjBkB9AtSYp?=
 =?us-ascii?Q?W9mxneHM5HyVMRwPRyuPza467Y2bs8Hg39PlpBXwqvVmkWJpvxv4Fe1StZFm?=
 =?us-ascii?Q?5l3DTOg9ZYHzaVC09YPD8AbVK9NKndeLkEQg5CVDz7ZEOK5SFPXOVxMwCJ0q?=
 =?us-ascii?Q?+G+dR+IHzJ7nkFr+Sly0GouI7ZLWMirQQu9CX88I?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d78354-de01-429b-2bd5-08dbd0aafb77
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:54:58.6758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMUsoNKdc+2C7z5OHrg6K+Ng6kjY2o0nYzGe0/TiJaEo96XK2XEXmQvb4IiGyJlZmRibYSu4bD2mXyWK2iul5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8729
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix the case when registering both sink and source endpoints,
the register endpoint method call results in 2 remote endpoints
for each scanned broadcast source.
Remove the need of a remote pac when creating a broadcast stream.

---
 src/shared/bap.c | 73 ++++++++++++++++++++++++------------------------
 src/shared/bap.h |  3 ++
 2 files changed, 40 insertions(+), 36 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 925501c48..665cd76b0 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -644,7 +644,7 @@ static struct bt_bap_endpoint *bap_endpoint_new_broadcast(struct bt_bap_db *bdb,
 	if (type == BT_BAP_BCAST_SINK)
 		ep->dir = BT_BAP_BCAST_SOURCE;
 	else
-		ep->dir = BT_BAP_BCAST_SINK;
+		ep->dir = 0;
 
 	return ep;
 }
@@ -1500,12 +1500,12 @@ static void ep_config_cb(struct bt_bap_stream *stream, int err)
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
 
@@ -2682,7 +2682,7 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
 					struct iovec *metadata)
 {
 	struct bt_bap_db *bdb;
-	struct bt_bap_pac *pac, *pac_broadcast_sink;
+	struct bt_bap_pac *pac;
 	struct bt_bap_codec codec;
 
 	if (!db)
@@ -2710,15 +2710,6 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
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
@@ -4482,21 +4473,12 @@ void bt_bap_foreach_pac(struct bt_bap *bap, uint8_t type,
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
 
@@ -4541,6 +4523,20 @@ void *bt_bap_pac_get_user_data(struct bt_bap_pac *pac)
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
@@ -4549,7 +4545,10 @@ static bool find_ep_unused(const void *data, const void *user_data)
 	if (ep->stream)
 		return false;
 
-	return ep->dir == match->rpac->type;
+	if (match->rpac)
+		return ep->dir == match->rpac->type;
+	else
+		return true;
 }
 
 static bool find_ep_pacs(const void *data, const void *user_data)
@@ -4708,7 +4707,11 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
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
@@ -4745,7 +4748,9 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 			return NULL;
 
 		bt_bap_foreach_pac(bap, type, match_pac, &match);
-		if (!match.lpac || !match.rpac)
+		if (!match.lpac)
+			return NULL;
+		if (!match.rpac && (lpac->type != BT_BAP_BCAST_SOURCE))
 			return NULL;
 
 		lpac = match.lpac;
@@ -4927,12 +4932,12 @@ unsigned int bt_bap_stream_enable(struct bt_bap_stream *stream,
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
@@ -5465,10 +5470,6 @@ bool bt_bap_new_bcast_source(struct bt_bap *bap, const char *name)
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
index ebe4dbf7d..edc88c834 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -320,3 +320,6 @@ void bt_bap_update_bcast_source(struct bt_bap_pac *pac,
 					struct bt_bap_codec *codec,
 					struct iovec *data,
 					struct iovec *metadata);
+
+bool bt_bap_pac_bcast_is_local(struct bt_bap *bap, struct bt_bap_pac *pac);
+
-- 
2.39.2

