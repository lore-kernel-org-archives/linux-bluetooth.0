Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8BCCDB47E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Oct 2023 10:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjJMKGb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Oct 2023 06:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjJMKG3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Oct 2023 06:06:29 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2056.outbound.protection.outlook.com [40.107.104.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEE1AD
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Oct 2023 03:06:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLqTSPtR9e2dcuFSx7zCkMsuhwDNNzWLoHMbfr6rGaJY9k6NF2PRci6KTbSQek5WAg6z0HH2zR3MVH/Bq9XdD8gx7YrvYTluAOmtlb8skdRZgE8j4Wg4RNOI5lxuPc9mh78WBow7K7P9JYM+Fc9IMSK6Da6LGiy2/odohILC2Fzp7ldMXyDN0qgmDFMcrO9dlth2U+228c2ovOtfBOGi1EPjjbnw9d+zOxkgDSB2PTR9VBiu3sDmkoo3dlCu90Uxv/tfW94IxJPyc5hjVD3ALrErizf7J0GuYhzdYl9L8WxrNgLlWgu2G+B6RvwL2zUFswbwZ6jS4MSiHG108rTGcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SM6/gBbhm3WbCjeKJUdXbPisze954/Vc3mDe26p9Cuw=;
 b=G7bLSCRjtPFpWu/QekXkniuFfe7p4nn3VynITVcZwAzBQCR6fjCruo2rXs6c3rrWiN27/rCbxVvWVAx4q7CAjUrrZRxe+HOP+aZDbI9z5PUn7cON361GAorW4DyqVqBJvo7A4fdu6zPS5msCbAr2rLKIrt+Sc3tutjJKCqoLSMvEpecBNd7ETdn9PN+5r+mvtADQqUYQvI1Entp7OFoONVZGwp+Xj7Opcm5vw4OGA7x4cWz9IDUn8Kg3cJ69oD27HLcMNpNE2NVYtHJOt9goUTigc63WRmmHb8d8hwHdTbDKAm2k65LW+y2WEy1bTzeJiJInl8ov9l9HbChFZio8Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SM6/gBbhm3WbCjeKJUdXbPisze954/Vc3mDe26p9Cuw=;
 b=O2d+AM8nIUwawC73mlqdRKtby8fu/Yi1gMWz88gMaMIQU767gBlMdOP3N6ps6H/7g2mBbIFTpy13FCZizfkoFyQQ0hhb9D+uSOJznEtSvct0juC9H1rMRCSPyo8Er6QKWWcBy3i5r9egqZX/8Uof6WmGdk0egA91ouJZNzdFUBU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AS8PR04MB9080.eurprd04.prod.outlook.com (2603:10a6:20b:447::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 10:06:25 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::a53f:4bda:e012:a73d]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::a53f:4bda:e012:a73d%7]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 10:06:25 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ 1/2] bap: Fix source+sink endpoint registration
Date:   Fri, 13 Oct 2023 13:05:36 +0300
Message-Id: <20231013100537.3867-2-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231013100537.3867-1-claudia.rosu@nxp.com>
References: <20231013100537.3867-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P191CA0003.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::7) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|AS8PR04MB9080:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e5406dd-e716-4019-a1fd-08dbcbd40f43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hRGoMCO+AJenQA3VDPUceGLd1LCE8cGYrdP6fZQqte86XfUtafQGqgc+9tUP7Jdt+XPIaCahf4m6+fKmhH7UyHBNRxxjj/SUlrEzOZ5buP5GHIw9XocxXSaDaPkxDsnebjxirPl3OYWRg49jt4Hyz7algAxs9e6kExRmCFAHyqIURaOknkFSrFsTL52X3xuNRGHfEcxn39muWESx+jK3TjzPrnP3H/YGbpmz9T6hJPC+A36kW/H0pnegydGnqPbGOiKjvSBWyhe78ALOB51rKKe7HgxnirfHPHe4mTTVYmB4PaOleE384NyUdy4UAzeAoGrZTFf5+dziTnzHdi5eUhYSyUXk3HmbrtkZTHyuUlko1ZMQISPQ/l1oXRcCCrDOKtMikiBaEYg79qoGLKx84IccUXc3kMOE8pRFGEq/ebUM1ukNYrLF+R3mT7pSBIHXOFXC+lpdcr3RnXtP5riP/+zf+H1cJ1piuXlahaWfVd9KDSp7xoVNvsRfpQdqp2JXBxlVlV29X7JEvdkUIRW/ZKfJKm916FSvGsN/6uB7EWIrXUr5ey6T7RCqkZkvC1um
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(346002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(6512007)(6666004)(6506007)(38100700002)(86362001)(1076003)(2616005)(83380400001)(26005)(8936002)(8676002)(4326008)(2906002)(41300700001)(316002)(6916009)(5660300002)(6486002)(66556008)(66476007)(66946007)(36756003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZcIJnyK8IJQ3sKvX4yt+lJ8E+NrBcwaK7xcuGc5GZ/HRwSG+x36xtq8EM4Ty?=
 =?us-ascii?Q?bvSF2Tz2JcqSL+riETzsKytPu0oLLqXbRMZ6vskMO9oRs5uwIS8wPT/RNsWj?=
 =?us-ascii?Q?lO+UAd8UrUzrWWf+pAPwq4Or67n9jHiWBdLMofozn+4du4BRPEZCrYUNF+Q8?=
 =?us-ascii?Q?/0vvRakMXPUWSaXYlNsy35JCqht2CKFxJswWGC6v/41GT+z9Nz5MO3ywEGcJ?=
 =?us-ascii?Q?Gnh4IDlS1JjOfgXVFn4X2bGhPkD52FtCqWc2X54zZ90C01mlAl+OYmkH2U/U?=
 =?us-ascii?Q?6PfG9PHz+L8/TDz0tJPYcH2OJinn5PN4N0EZyG7M99MBk5nj7DI8C/ys4Y4h?=
 =?us-ascii?Q?qRkHSelPZVVrya3AJ4YiSActgm95H4tOnil+2I1qYxrxkOEqYEDDNt/LNndG?=
 =?us-ascii?Q?PUXgxPOV0Pw9Y0vA21wPZiUSTX7/PiyEC1wIGzPAnRuszu+jLW33NWavnpGq?=
 =?us-ascii?Q?8aCrCsDfwc3YAsBjetS4grviNNt1vDp/3tEyBf2Q1IlGGJfMc16IWGiFfBZj?=
 =?us-ascii?Q?kTjLsiuzJsgowMeyl/rINqdXYj0Mcijh0QpAay4aw5Ty9UM2X5lq6qbkfFnU?=
 =?us-ascii?Q?Bg1YMVIESkL39RO4eSjdTNFOrVPmWZl0BUgBaxdbMAClrZGY6WAOnLEcN/9f?=
 =?us-ascii?Q?5uDTQfTkmPGgC2vGOuDEzj96UkK2Cm1p0JUBSO2LkpqlQV+bOFFX/Q/b/iTM?=
 =?us-ascii?Q?EfPCg9D/n38U6rSwpK1/BzfFjbq25QiJ8OV5VVeJ1HGyJW51kZYKleYaTuXf?=
 =?us-ascii?Q?69aD00nqf6+ksbgOI2v9242JPEJcAQpR1zN0kHqzaWnxBlkRdUrS2muW3p60?=
 =?us-ascii?Q?hL7x5cxml+55+yxeIWcENQ+lMfeT+5/XkvSDiGj4r5InNTMm8EK/DHW6bePw?=
 =?us-ascii?Q?mQQhrDVuyc05aJ8HXcxgU7j1A6J+yo9y5/4XCFuaBjA87ZewV9YJ8AsHAUXl?=
 =?us-ascii?Q?1vWC/vzpKCV8df6ibCJ6akVzXD172CDCKPQjimGLvq/xkd/WTeZ4ig5RrOpj?=
 =?us-ascii?Q?wpsGKg4MGlFsqlA3et/9+F+IUfyaktVCfHmg/MC265W1yFAMtyd73fmXvDpB?=
 =?us-ascii?Q?reRfWhjBVwbYydNtGCeZSos8zpLcM8+i0SNphaQgV/Hw9B3Qz69edt5FXEXH?=
 =?us-ascii?Q?46p5tACeKVSCWgZl7n7J9qfXxO9LXcEi/bnb1QKqHLNI7+UQ1Ya2b5UWIFOk?=
 =?us-ascii?Q?xqkOxD66RDZpSFq45GuzmV/B2PrWOzJ8blkvnCxgdAF6RwuK0MufAVvtFVr7?=
 =?us-ascii?Q?rvRa5A7ABlQmDK1Gz3SRsh/9CibO13MTnsVbuZ8oBW8LI73/0GpMC7DiSUct?=
 =?us-ascii?Q?FCR3SufsEt4JlrJe5JZ3Apwhek45+S5oT9XNtFa/f12VtvcdeA7HkL7XuBJy?=
 =?us-ascii?Q?TfK6SJ3k+duH/kkEfgxpiGEGu2KUPH/lPzQmnvpBMJTCbNfOL5injpUZm4wV?=
 =?us-ascii?Q?KFS615C5Qh5cGa4cDtvH1BcNqxdied/WJrvC5ItGyahud1zYoovb0sB/MnWk?=
 =?us-ascii?Q?7ko6MPI1XA2WU6maIWy9Bj2IcNPMVP6nLNgY+wj22XojTK67KQyiAJc8n9ZP?=
 =?us-ascii?Q?D1GSrGM8NA4dgnyBbcsXhQxmcRmm7eig0mTd3Iv4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5406dd-e716-4019-a1fd-08dbcbd40f43
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 10:06:25.4596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGWPMGDwJG/H/7+ciMXOh9lbP4ibdv3jFZwLzK8Joe/S1OGRMRXTH3kB89yl6gVVuOSRzP4OOk+zSB83J/cCKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9080
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Create new endpoint name for the simulated broadcast sink that is
created when registering a broadcast source endpoint.
This removes the ambiguity when having registered a local
broadcast sink and fixes the situation when multiple remote
endpoints are created when discovering a broadcast source.

---
 src/shared/bap.c | 54 +++++++++++++++++++++++++++---------------------
 src/shared/bap.h |  1 +
 2 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 925501c48..266116235 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -644,7 +644,7 @@ static struct bt_bap_endpoint *bap_endpoint_new_broadcast(struct bt_bap_db *bdb,
 	if (type == BT_BAP_BCAST_SINK)
 		ep->dir = BT_BAP_BCAST_SOURCE;
 	else
-		ep->dir = BT_BAP_BCAST_SINK;
+		ep->dir = BT_BAP_SIMULATED_BCAST_SINK;
 
 	return ep;
 }
@@ -1500,12 +1500,12 @@ static void ep_config_cb(struct bt_bap_stream *stream, int err)
 		return;
 
 	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_BCAST) {
-		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SINK)
+		if (bt_bap_stream_io_dir(stream) == BT_BAP_SIMULATED_BCAST_SINK)
 			stream_set_state_broadcast(stream,
-						BT_BAP_STREAM_STATE_QOS);
+				BT_BAP_STREAM_STATE_QOS);
 		else if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
 			stream_set_state_broadcast(stream,
-						BT_BAP_STREAM_STATE_CONFIG);
+				BT_BAP_STREAM_STATE_CONFIG);
 		return;
 	}
 
@@ -2710,15 +2710,15 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
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
+		/* When adding a local broadcast source, add also a
+		 * local broadcast sink
+		 */
+		pac_broadcast_sink = bap_pac_new(bdb, name,
+			BT_BAP_SIMULATED_BCAST_SINK, &codec, qos,
+			data, metadata);
+		bap_add_broadcast_sink(pac_broadcast_sink);
+		queue_foreach(sessions, notify_session_pac_added, pac_broadcast_sink);
+		return pac;
 		break;
 	case BT_BAP_BCAST_SINK:
 		bap_add_broadcast_sink(pac);
@@ -4457,13 +4457,23 @@ static void bap_foreach_pac(struct queue *l, struct queue *r,
 		for (er = queue_get_entries(r); er; er = er->next) {
 			struct bt_bap_pac *rpac = er->data;
 
+			if ((lpac->type == BT_BAP_BCAST_SOURCE)
+				&& (rpac->type != BT_BAP_SIMULATED_BCAST_SINK))
+				continue;
+			if ((rpac->type == BT_BAP_SIMULATED_BCAST_SINK)
+				&& (lpac->type == BT_BAP_BCAST_SOURCE)) {
+				func(lpac, rpac, user_data);
+				return;
+			}
+
 			/* Skip checking codec for bcast source,
 			 * it will be checked when BASE info are received
 			 */
 			if ((rpac->type != BT_BAP_BCAST_SOURCE) &&
 				(!bap_codec_equal(&lpac->codec, &rpac->codec)))
 				continue;
-
+			if (rpac->type == BT_BAP_SIMULATED_BCAST_SINK)
+				continue;
 			if (!func(lpac, rpac, user_data))
 				return;
 		}
@@ -4484,12 +4494,6 @@ void bt_bap_foreach_pac(struct bt_bap *bap, uint8_t type,
 		return bap_foreach_pac(bap->ldb->sinks, bap->rdb->sources,
 							   func, user_data);
 	case BT_BAP_BCAST_SOURCE:
-		if (queue_isempty(bap->rdb->broadcast_sources)
-			&& queue_isempty(bap->rdb->broadcast_sinks))
-			return bap_foreach_pac(bap->ldb->broadcast_sources,
-					bap->ldb->broadcast_sinks,
-					func, user_data);
-
 		return bap_foreach_pac(bap->ldb->broadcast_sinks,
 					bap->rdb->broadcast_sources,
 					func, user_data);
@@ -4497,6 +4501,10 @@ void bt_bap_foreach_pac(struct bt_bap *bap, uint8_t type,
 		return bap_foreach_pac(bap->ldb->broadcast_sinks,
 					bap->rdb->broadcast_sources,
 					func, user_data);
+	case BT_BAP_SIMULATED_BCAST_SINK:
+		return bap_foreach_pac(bap->ldb->broadcast_sources,
+					bap->ldb->broadcast_sinks,
+					func, user_data);
 	}
 }
 
@@ -4927,12 +4935,12 @@ unsigned int bt_bap_stream_enable(struct bt_bap_stream *stream,
 		queue_foreach(stream->links, bap_stream_enable_link, metadata);
 		break;
 	case BT_BAP_STREAM_TYPE_BCAST:
-		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SINK)
+		if (bt_bap_stream_io_dir(stream) == BT_BAP_SIMULATED_BCAST_SINK)
 			stream_set_state_broadcast(stream,
-						BT_BAP_STREAM_STATE_CONFIG);
+				BT_BAP_STREAM_STATE_CONFIG);
 		else if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
 			stream_set_state_broadcast(stream,
-						BT_BAP_STREAM_STATE_STREAMING);
+				 BT_BAP_STREAM_STATE_STREAMING);
 
 		return 1;
 	}
diff --git a/src/shared/bap.h b/src/shared/bap.h
index ebe4dbf7d..af3b6be71 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -19,6 +19,7 @@
 #define	BT_BAP_SOURCE			0x02
 #define	BT_BAP_BCAST_SOURCE		0x03
 #define	BT_BAP_BCAST_SINK		0x04
+#define BT_BAP_SIMULATED_BCAST_SINK	0x05
 
 #define BT_BAP_STREAM_TYPE_UCAST	0x01
 #define	BT_BAP_STREAM_TYPE_BCAST	0x02
-- 
2.39.2

