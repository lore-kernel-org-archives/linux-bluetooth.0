Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C088C25B67
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Oct 2023 14:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbjJZOvK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Oct 2023 10:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjJZOvI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Oct 2023 10:51:08 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2085.outbound.protection.outlook.com [40.107.7.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C62B9
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Oct 2023 07:51:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbiXRbNlEsMho2TxnarYwJK6zQ1R/9YiH3dO73TGj0gGAR4hkUQB5rOCGrYuLh4eChdazWbh21vXzhyZozH+0F2Di4KhAC5cxRSKYZ0apz/3XvN37ja/Z0mDFQCm+rkfbkcy1EgbHwqm4op+rPIQLIkQBEAosASE2JMCKkrvk9zbCudj8s8RyFPm+LWh7UUruwz6iKVVofQxmMtUaHfmu819TobC2krasLuu/v8oFl67mCam4BWlgYkM+eeqyT1LZ/244O+YXlGO51t+WKDlHFnPQhscBgdrUL6ge5HcanCv1b3vVLu4tH5vNqRVOQAo4PG4GZymzGcAupBfMWO1Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QjCybU9bqY/HBQXwZu43Koktypo3+IfWCGMVt09/94=;
 b=CFB9hb9xif2/AAB3/pnPQv9NyE5lT5x/XrEQRsIxMt0Ab5Mcbp2G37wx9IC0gwiCIAB5VF3CbVQh21dUNc2j2MimS215H9P/XICB4LXhiaHoptpKZ/CW28QQGLSqnicotMDB11suP6i806jU5MZwQF44tVQ4+cEJy9BJ3SD/i/TG4G/u3CAhZIW647lM705S/cQ2kzlS3IcwXIbbyHf9rUN5Q2Iz0MSXIOjT8toDtPTUjCuwcdwkPHz7+u/nK28xFxLJmzjM4r9U44pHcKcTHNYW8PJDRq/MuT/xY8Dx2noQJ/WdlY2VghefGZdyj8DUgPHzpBnoASY1adf0wCAElQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QjCybU9bqY/HBQXwZu43Koktypo3+IfWCGMVt09/94=;
 b=XtzYA2IHSPSoAlxRdQW9Y9LCnv6zNKFUhVmNXeeGPiYy6txrWMVxo6p0+MiUvekiWqf0s1HavQmXimK6Zx1lXlXUsRsjcGk5tjdnBFB8E280yQU1K21sEJiimQzqt63YiHCPzxk7Y5mvbtzAOvZ+ArEAnWlCFRGwsUdCIQDdBF0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com (2603:10a6:10:ca::21)
 by DB9PR04MB9939.eurprd04.prod.outlook.com (2603:10a6:10:4c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.10; Thu, 26 Oct
 2023 14:51:02 +0000
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::7c8a:c8da:e6a5:8a4a]) by DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::7c8a:c8da:e6a5:8a4a%7]) with mapi id 15.20.6933.009; Thu, 26 Oct 2023
 14:51:01 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        iulia.tanasescu@nxp.com
Subject: [PATCH 1/6] bap: Fix source+sink endpoint registration
Date:   Thu, 26 Oct 2023 17:50:42 +0300
Message-Id: <20231026145047.4637-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231026145047.4637-1-silviu.barbulescu@nxp.com>
References: <20231026145047.4637-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0010.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::22) To DBBPR04MB6331.eurprd04.prod.outlook.com
 (2603:10a6:10:ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB6331:EE_|DB9PR04MB9939:EE_
X-MS-Office365-Filtering-Correlation-Id: 42f23f7d-392d-4b2f-0d25-08dbd632f89b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ybYWRhjTq7ONXjCU61eEswLqGTJrEIh9OFlAVCjmpnwcF6M+ZgOoOKMkCupSqxj9aA7YIjDsQ3tPTngzkXh3DphlLPFgvKWDfrfpy841NFe88HQ5X7g/nAM3BGEI1ByRBVL8p6/HKd2kQnx/XOUXeNmEQHIgsXbFnf4Iy144Z9G84rMtAfW7tzQCH4SHTPSkdgtKDte8UlaDg8A/RHBS8YUSp/M65jYAv64CNC5M5l8Ga/KkSbKySdLBAaEjCF72Xg8rHYSlJH6Sby5qukosfg6fOHsORJDamRMQL32c4tUC0WkE5/Sa6JiCgF3Nwxcb6cKmy39S56ReiMTp+G7pPQDVzKDL4Pz2JAEgUZuryC7HPYZ2aHk3nZwe0M7k84FhANH/q1oqhNo+nWBFNQEEkDzSE3EzUud+CzqEa9RGK6SW9DwlL5wX65845Zfp/M7jZAe21zRqae3KrGWPWHW3KsP7bV6TMKuhzc5v0IMensQ8oAnI+3YtUl7nRFKjJqoHqA7C9wm2RQsJmkusMazJ3t9Rdx1zH8q22Q7zogac5gFzZbKubZmHORcKThRIq3nq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB6331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(66556008)(66946007)(316002)(41300700001)(66476007)(478600001)(6916009)(4326008)(6506007)(6512007)(6666004)(8676002)(8936002)(6486002)(1076003)(26005)(5660300002)(2616005)(83380400001)(2906002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2SdU3jFNUHKbU5WTQOTwUpBESA0tn5AccvC9RbP0gAfqquLNGCWpj+A2kbEw?=
 =?us-ascii?Q?OoBf7vKQjqf6AVE+hRotdCUzP3j4Lzsyp4r5Rwch0sv33TsO+5qd7pHgXy+u?=
 =?us-ascii?Q?03Opf1l4w/H3SZEUNJJAHDJZnGZ6s5Vx9DZzJyJ75dNgCdEGNYkAnJDDwG5M?=
 =?us-ascii?Q?JycsUvDbWipEYgpYpCYuUP6jKEnVde0kDfxa1SfkMx6Hl6QKzORqn4I+CZsw?=
 =?us-ascii?Q?pJ5frCM+s8kjipzt+7oqHn5aq86ImhN/qBef8Nt1QXa+U1ZI+BgGbVT45V3e?=
 =?us-ascii?Q?0dNNSxvwRgrOlHm12D8Ekxsa/65DurFPHKwb/C1OqQo/Z4fyT+jRMCO++5OC?=
 =?us-ascii?Q?Ro2HqviiciY76FmX77digFLspYRwgrPP4nB3XbhzTkYFJLO8e8NTb8B9RK7I?=
 =?us-ascii?Q?blteIfre47V9KYQDmxW941224Zty7ji+w9KJrBNsEl8E56V3tE+h0kiOoDzm?=
 =?us-ascii?Q?MYL5peBlHdBWU0XR1ONeW+Rv1exidDN1Qv/sIBN75AVKhiidsVzdMnERcyMc?=
 =?us-ascii?Q?mY4Zzn+Y+WiwDMfIbFuA6r1gg/M314C1bqb5VXLVNl8EoD0rLAAAovQNSFQ3?=
 =?us-ascii?Q?xEWIzgvAY1zPztrViSYu9TB3PW8Lrm7f7mVtCOPz6f39P0RvE9omkgd+FhPT?=
 =?us-ascii?Q?oX46HVQiAX5S7CoBpkDNsMBnX3F82kHLLmxi+0D+QkJ9KpoBNkNwVKDNiAWs?=
 =?us-ascii?Q?+ZTw9tprxFKLL3n2sXxXTndhg1m6qi1PNjMvC/mxcL2GdHT7Xw+TbhCie1nl?=
 =?us-ascii?Q?pBH8OulH1V5VNA82L/sOVHxvMiEOHmnTOvfXT6z6WZB4s3yJiRjVg/JiQC8M?=
 =?us-ascii?Q?Z+CRekRsXXxPGkb/fZtwVPUlNy8s5IR/KlZarbTt/BOdhIR3soxzQ/ch1wya?=
 =?us-ascii?Q?Fkak37aDplhQUVuW66e5IVrnYX0YLSG5MalhkeVAXVeCPP02i3+tpEHTTl0r?=
 =?us-ascii?Q?aSmJ3u0drZpACEB7drGvvwpGgbOmvdT7M8+O+AdIm7sVJ0Hge/1lAqeEfzZi?=
 =?us-ascii?Q?KEzh0IrayN+DwJqIYzNhbr/QAwQLu3aWy0AWTauQmRovQQarMoUAHH/mKP7q?=
 =?us-ascii?Q?sqxvvXpwgJyBTSk5zt5Dm76pKAal0ggI5fvC2myPIumkx5mg/IIdVNFAP+bq?=
 =?us-ascii?Q?rBu58KlH1IBv+XiRMJFd3AlXhd62B4FFXJCKLSU0AO317fqkJbcs7cJ+by8k?=
 =?us-ascii?Q?wISx5GelogNCDrE2p6YxY/lANv0CIFnvgjagIvQ41uQxCabj89P5GEv5TOPK?=
 =?us-ascii?Q?eJA8+BkWK8aTECCMV/yyR1VzhZJyQHMWpZUo2aJ1NxiF9uRk5znsF0pfh7GD?=
 =?us-ascii?Q?kMjZI3a4lpkK07QFFEnQAVMUNIolR8wks6Gc+o+PfgMgwYyG9CB5GnkBexUK?=
 =?us-ascii?Q?/fWi5PCkQux2XsIJWQ38CE/AONCNnG8m56sJjFGaZRrLcK6bwyjetYiLWZOO?=
 =?us-ascii?Q?k7HXY46NzdEMSBYYPBFex+ODIh4lppKZaf5GcZ5MSel4cLILTpAkk1Q/yKnV?=
 =?us-ascii?Q?TXi03YYtxJo1tr5AkxXq71RVYLK3AKZKdbhQF5RCDTbV55N/oXfxCCmcQfjX?=
 =?us-ascii?Q?uGC8KWMLTvFOZa3ioZndB10m6MODBJ1qcdfg1Qhzg7pD2j8Y6XlaKjWdU3nf?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f23f7d-392d-4b2f-0d25-08dbd632f89b
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB6331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:51:01.2382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +GDXtoAZpNvm6efKOwfiOpdJso/zNVLSLQGRnOHQ3FX7PdXjXngce8bc819PBH99HLxjU6LTNPZTJOODA1J5pH16sxtHCojJFzpGHc87YO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9939
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

