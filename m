Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817D4C25B47
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Oct 2023 09:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbjJYJTP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Oct 2023 05:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbjJYJTO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Oct 2023 05:19:14 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2048.outbound.protection.outlook.com [40.107.21.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A51A183
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Oct 2023 02:19:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IetKa65tYEQGJv/O6XSLEXKXE3Yi/rBXYjBPBwDW+ae8h6Bij/LO43eDIJrXtQttV/VmYzE9rCI1A2Ynr7wgD5Bk+nb+oRIvWk5g83BLhh89oEGdEmzPZJm2Q/mzkEhSwL731pcFIY+aRRtuhGUVFtbKulYcohCXuO6/mzrunVnNyoOSeVfh1s1RaKodcvyaXHaIRaNJBwrkB6eL5mDCCf/0QsmHMBwHPo/jJqGarblNmGoXHtJ08sqHWeXa6zu9BL9jsYvyqcNPmWlu5Usx9IGJaWqNqSnGrXG0zCU+Tb3Zx2IcxMcmCgSFEoJyi9S9ak0cFv1qBJ0jGUKqWurqHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZAhXdFTcFK6sESUXAs6ahLe86LsoshtH6Up8HZb7fo=;
 b=cSV+nWzSxfodX8nq+ZgIa7LXt/BVPbPB+CoxGgKcuQJL/DEi2bUyDsyRkX/H8v+QvTmMCtsDn8RiOLFLRBZanYf6nFB8rHP/GCCQS6wrr1Lxqjarma+yu84XaJrdOpn9a91hpvQOHvlRuHjfAekuqbYV9dczEyxhsEZT2e/3LtzvzoIinvptm+ln7LWD5UiEZKdvYcx8tcRVCRTOu9c0vSY7RESOOvOmW3Wm8aSFdQM6sqUQGbpeF0Fjls+lo9E8xNxgKrse0IABaUDgsk9UPMepLw5Y7GRdtnEeC1Btzp1qybOax3NlHJ+KfAS35cS7cJDg5+zLkPnELVDNfnI1rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZAhXdFTcFK6sESUXAs6ahLe86LsoshtH6Up8HZb7fo=;
 b=HuyIW2o5SMxtOkroSq2D+cdU//XDLDB86xGH9BU+sQbprKFNi8VL6Zhk2Avhp4VO/Dl4TC9Ub4yeSxceHtp6IfUsgBnRA1q+2B/+xAo+1ZLEN36k/4ixW3zuLNldq/kpsW18ufci5DlaiEZ5hRo19g4uDuE0CJq9dMo7Xlfa17g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by DU0PR04MB9369.eurprd04.prod.outlook.com (2603:10a6:10:358::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 09:19:09 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::9854:5951:6f9a:7711]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::9854:5951:6f9a:7711%4]) with mapi id 15.20.6933.011; Wed, 25 Oct 2023
 09:19:09 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v3 1/2] bap: Fix source+sink endpoint registration
Date:   Wed, 25 Oct 2023 12:18:52 +0300
Message-Id: <20231025091853.18647-2-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231025091853.18647-1-claudia.rosu@nxp.com>
References: <20231025091853.18647-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0228.eurprd08.prod.outlook.com
 (2603:10a6:802:15::37) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|DU0PR04MB9369:EE_
X-MS-Office365-Filtering-Correlation-Id: ab08bcbe-b0f6-40bb-0d2c-08dbd53b71ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uc4pq2l/qYXtXG2GwSr+IZZqtnGXb6ii4lC5Hki8Kq+L0DXBnc33PIkSzfgn+1xynB+rV5aMVz5wiOM7uGNJdSSSuj/FfUBUYLn9JAF4K+yQJLLYUnPc3MSPDVWZ018u05QHjVYCAAoDGzN3U3HhInHcx/0OKUvE2r8LwLHI7pMYp9cjXTB3jkilpCQozIh/bb3OfnuNS4FMxfIy4vavqSG868SyxIbw4EFPwm8ptX5tXxNlxh/CVld3wAUIW4ufd93vFCeFt9iF5X/Mr3CawTeMwDv4SpyTL9zS7jFNSpWP25reCaG3jE1CnEEkr2I5IDPvbJbqivBocmVj04DmI+P04/xHlkTOQCyyEAWhDD/tOZgzpo1fxH9Q6WBNijIRgj1a2j+KIpGF7f5yySehyp/4IWIULN3MnT16d7LiL1C/mPl7Prcg2O6P797UAk0g1lToM37sP2FWU5INoTeKyjPEEQ6HgBEqD6U7RKWAhegcB89bTav4jsBZqpjfg28saww6aLPlXzzEPX/YUQ5ZfsKqUxOmz1EqlKzSZBhHlxBI08Kj3wJfvF9gd372UCyG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(346002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(26005)(6512007)(1076003)(2616005)(38100700002)(86362001)(36756003)(83380400001)(66556008)(66946007)(66476007)(316002)(6916009)(4326008)(8676002)(8936002)(41300700001)(5660300002)(2906002)(6506007)(6666004)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G7Mkf9qwuLEhBtMGMz3eSx3ZEBk8OEfz1SgDyFzuNy9pWXXZLfUItIHJEZlF?=
 =?us-ascii?Q?YNiczi8a2eVbzLVp3hC2LQv0/i+UT8eX6qSfss47Ci8lvDJiRWIeU3hqbBcE?=
 =?us-ascii?Q?GFus8GnkQFXW1Cfzqvane808JPpNQgs+X0NGiYJmTQz3xB1zOj5vmhx5Szqx?=
 =?us-ascii?Q?r8yneE3smayoW/x1A3XaTl7I0H0IjEE7HPXJJCN4UxBu8BI5FXQk0JCldmNo?=
 =?us-ascii?Q?GTaGRXtk3DsHQYi6h5yz11dSUH+nybl3EPwFGnMW1R34eBi+SIIBPWP+F+XO?=
 =?us-ascii?Q?efCgyw9JRuhx5X7F2yGcbC1JguBKpTvqqIV0E2R//AI3WNK0jdERJfTcsati?=
 =?us-ascii?Q?2JuiVtv5eCksKenR1Bw3u0rPxyOMip7jkUs+8+NrczJA+wUv2Yx3qzDUirmU?=
 =?us-ascii?Q?y5EXpyq8HnIRpz6fTvsAo4B0NEFqWvSKy9LyvCcdbEwkKrUajQtYWAYJcQkZ?=
 =?us-ascii?Q?rH9C+E4qj3XuCRYpjEernpi22ERLp1Nd2hTfgOkxYl+haLccBbC85j9mPSEC?=
 =?us-ascii?Q?3i3Mq7kxZPtG2e7SIhrh5EYQrRlumwakHrUc7a6opgxhNnCHKClLWGpxSLoS?=
 =?us-ascii?Q?j5YZWFVQdGeg5NmHW0L1Dr+rJSyeUnhFA0xG9wbM1bx66+KufQALnsV+ydtc?=
 =?us-ascii?Q?4y5g7PMRuPozIB/juAlOgLr/KHuIYyB3H1cilrSkUCsacy0h2oAY/jT7609S?=
 =?us-ascii?Q?Gk609VyNtqmd84+AeKdAk6ypel4cgraylxTSZ69MomdJKsCGht0fEtHIqMY6?=
 =?us-ascii?Q?qtAMJJbqhhw5Z7QQWppFDIPi0upQrBVhaglQ45wKBQw0X5VMajR6P+vbRUp3?=
 =?us-ascii?Q?Qk5dJwhhuxX8okQRoScTbBtNtl13qLQOH0VxTJpKIX6iQfCEns3E+F7dQHPn?=
 =?us-ascii?Q?5kh6vwbuu871PkYtaLCF48JlSFSlSWn0N/DKL5bkvGXRfmdduWioFP+A6/C8?=
 =?us-ascii?Q?5sUXovyqgiQq917/lP+dX/f/rsTGhWAQM30+Zt+E6zY8SXNN0sLdKkiWUDDB?=
 =?us-ascii?Q?XQky6GJKTQm49ML1ejZOa1amtKZbDYjT2SdubbqNFdo34Klj0c/JVV1ecVo8?=
 =?us-ascii?Q?OC3WfoaFVqm5WIHu/KrCqidiUlTHuwqBzkRWcdp+JFImUpfSDXqGoBAIYvZG?=
 =?us-ascii?Q?HfHYOZxamljl/1WrQqVEzG25Edj4/JpuoHcwG1dJvJ2NkVngZ4XFXr6lZJQe?=
 =?us-ascii?Q?k08my6hDJ4zmylHcHz5CDuIp3QWz4XDvz1lD65J6DwdWlutTVG106C2s1vYs?=
 =?us-ascii?Q?2xcWvtOtuqsmrok5YNHh1wAxTZGbjlW6YRJZPs0Vsjrnjt+0uxqKkkf7bLdX?=
 =?us-ascii?Q?xY/NH9NgofFAbNU3yQCSxS5hduRwzpNoH5lEQC80kGf1RppuaIPBMefz/lMr?=
 =?us-ascii?Q?bPozE/l8PPfM8mGJUHMlYmPqf015MX7aMkyQQslNOgJ2/iXTAdDQWHxehyS3?=
 =?us-ascii?Q?nW52LKoGXCkjCxC8v4N+v7ZDj0OhYlAmI5sgyNx/uENxsI9GmVceaFmv80ip?=
 =?us-ascii?Q?PxtDxUkrOOtPRkIToQjrH3IKjDOII9Tye4Zl0P+jTrB/10dAdbG1k34iM6Ok?=
 =?us-ascii?Q?k3CycI6KzWysgqFg8VjcUuf8jSsj33tpJuc0TmSW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab08bcbe-b0f6-40bb-0d2c-08dbd53b71ac
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 09:19:09.1070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vOITkWWrpbXHKZYnb2puzO/wgnznIg0GnRRna3CNHTZRoTmABRLSUb5U3+ff8jfIHXlbwjzWnf3x9IH12IpR7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9369
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
index 13bbcf793..54ad713f2 100644
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
+		if (!match.rpac && (match.lpac->type != BT_BAP_BCAST_SOURCE))
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

