Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8170FE8FDD9
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Oct 2023 07:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241601AbjJDH5N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Oct 2023 03:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbjJDH5L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Oct 2023 03:57:11 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2071.outbound.protection.outlook.com [40.107.7.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7B6E4
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Oct 2023 00:57:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2PmiFm9MHWtG1xxe4ttFESF7Uf5iZFZ4BaM82UfafUtNp8J7oCf9YdqhShuTq1kDiuUbixIxxDw1GXA3j4wRww5rv525hw4xwZHPAwXZeawmnmiBEszxRbkSfGGdyvR3Lww7xtqCfBrqlBPsHFwRxVY/MLocWxbafpOKBRMyZ08f4r2LFDFhTfjlIcX87YRL0bleL5egYRhvUjuZJ1rAkGKVgbHaNBQYDN/iXsY0NxYvCRq8hE3FWGOKW+1l5GgcVs9Bg93FZ+ompE6YN2trukNu0ZJvalqVI/IvPixAEqX4B3ABKwNdVMjVcPyh2DE0w8WNEzZ48zBb1p7xwEPDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQEKcbv4EmQpgK4zMsnFK42Il+sX6r/sky8pm3IZU8A=;
 b=bjoWua641qedCEWGtFlZsLmxjDput7kF/KbAc55jiTt+BRz6V36GGZUB/c1N3BJolbI48qPkDBRaCHh0qQ0C7Z3L9v8Sj20H/oG9rFd1WygG43F4wAEhjKNnAcmVdx+b7MRt0+xdbp5cg99Ju7SKu2+GOgFQ84KrD+XhM4L0mx+NQCCqbjS8m8oMN7NwZ66qO/UMpUrW7ErpLtJ0uK11AR+0ga7PNbJzqqlveNOeF9hL26ueudUU3ZBgrUaASAk0LNl8HZ6Eec5b9XOJFzs9HwcKhfASC04VH0O5QH/lZBmP91qGacRiHYHXNE8+byv4hQXFK4UJRK0pW29pohLcLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQEKcbv4EmQpgK4zMsnFK42Il+sX6r/sky8pm3IZU8A=;
 b=qDmkQt/EOaWc0dJFry0B98d/hcm3DM0i4FMIf7exBHsd8b276OQ7a8rilPB/AavhhHpG1KtosQ2HPsa273hbVkJGEk5uul4TJW+uRmkGtSoaKRg/ClRid5sYsejndrVjSglyWr73B0EAMsfWOCnDr4Xc1SbuKz1EW69HTpdX9+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com (2603:10a6:10:ca::21)
 by AS5PR04MB10017.eurprd04.prod.outlook.com (2603:10a6:20b:67c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Wed, 4 Oct
 2023 07:57:01 +0000
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::c031:474b:cd00:5f95]) by DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::c031:474b:cd00:5f95%4]) with mapi id 15.20.6838.028; Wed, 4 Oct 2023
 07:57:01 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Subject: [PATCH v3 2/2] bap:Update transport acquire/release flow for bcast src
Date:   Wed,  4 Oct 2023 10:56:46 +0300
Message-Id: <20231004075646.4277-3-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231004075646.4277-1-silviu.barbulescu@nxp.com>
References: <20231004075646.4277-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P191CA0003.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::7) To DBBPR04MB6331.eurprd04.prod.outlook.com
 (2603:10a6:10:ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB6331:EE_|AS5PR04MB10017:EE_
X-MS-Office365-Filtering-Correlation-Id: 128dd344-c52c-43b0-53ee-08dbc4af7db4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VZPdv1kvnKiMHb6tXGJSe3SnnVAKUoebXs+CULe/eSce7ZOvtNfESLDxBM1PWktzDQwAipLKsE6GHzk84BA71rPVslwuUnGgpUDz24U8YIRHNPp5M6KJb/0DvxAbSwqFa8MGyCqcFFlDhnMewYll64BRqsEHRDr4Uf2QdJOelbiN6Vfg/Ev/QuSOE/MDKpsVTRb66JINtbBpWuceJkW+LwdRUlSB0lNLQK1pfWPdN7JliBUU1ZAvuDGiGm7eubaHhoWs3YDLNo9HKwOhLxjSFTMS3vtyDLaJP1UtIf1pxlOl7GkwXTw8f71O/2krVLjwPFG0RE2q4TPdI2qitEcro36PAED3cC85nY7sGQq9Dina2ypplTWwxUsk3ZOtx80g/yLokXqHz7rJu1Fjcj9/BMYSQ+crAHAi0mb5rf9mDHRmx9QioQnl64oRIFSVi+hcN7WsWq8cmJIujFQnVvduum5dfuS9fKa2dixMIrL3PuQCyLPdxcMxvs32G0e3uq+4+qGw8iTKuLXmaLYCNQ8zw96hyqRcQSXPVGZ8oLIYKP/lDtlXsmeVV/5mrmrGowVX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB6331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(376002)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(83380400001)(6486002)(6666004)(478600001)(1076003)(15650500001)(2616005)(26005)(6506007)(6512007)(2906002)(5660300002)(6916009)(66556008)(4326008)(8676002)(86362001)(36756003)(66476007)(8936002)(41300700001)(66946007)(38100700002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B7j5al9ie2b8/H5hUaU5RMWkRh+5MUbxGg26ZE0J1r2JTdyxtll+kOPUrVX0?=
 =?us-ascii?Q?fBtT6MuG0P77if0/OT/K273f9XHrGqKzc4AarzvLnkbr1KJdZ9htTb+9Yq3Y?=
 =?us-ascii?Q?zvlJvLpqs7KZYJJUY9I7MVy9sk87a6SGP05SFOPXRiYgPk5B5DnBPHLrqL93?=
 =?us-ascii?Q?VhuPrRHvq+bfZrJagZ4DCGVGKeA0E3x0wqH0Vv1KdbB24koZIY7/EfK4ajtK?=
 =?us-ascii?Q?gyITawlaIQbPsxzkS3tVtB42F++eEGIpvwfT1bkVRPqEboqo50uNRmg87INd?=
 =?us-ascii?Q?vjq9IiuPMb7tZhod+K2a07SQqI/tSitPVKy2XajS1mwT74vHZElFpV7vBi9C?=
 =?us-ascii?Q?nsdzM8OLqB1GGJsBDwO4tZj7GD1x72E9QrqxV6xDKMICElznLXU9oOjSE224?=
 =?us-ascii?Q?s5jeb9sagUhWN0hxN8gpe1Skyjaq1B69gxpEcMIK0ZUaUuIOey02WPeZf5Gd?=
 =?us-ascii?Q?s63vlfU7kJ3AtgLywnuDJ22xly/Z118Srmeq0R8kprzqH6J3ny9WRt2VxZH4?=
 =?us-ascii?Q?agLov4+GZQRF2lIh/ddCntGSTxokb7vq/AyvNrc1G7eRFJ56gNjDT3fJz/FN?=
 =?us-ascii?Q?cIDW8uwgAB5iT1pggyc5zqLdzvMT2OpIUWPBjeVlw6ksgogL5bcCuupjYJVj?=
 =?us-ascii?Q?8+IB1NKKTftkB+w4rkkJGYCqcU6xii9RAade+hQmI8EwAnCmwoaJ1lLea9aq?=
 =?us-ascii?Q?YtPBkDGMG+Y1jnl9AwbZ1uJABOBm3tocLiO1hdVT1nr7jsyZvSrX7S3CgCeo?=
 =?us-ascii?Q?xDbOcQ0o8NQpEtmfy9o1MHuNjrKKbq9/OTszBdaERCImqWsh3OnKGywF+0kZ?=
 =?us-ascii?Q?zH1RIFSAnBjgERgnSrcuCbdewZfpvKb9/SaUK50ZDsJ0imWmdNHvjKAJRMyV?=
 =?us-ascii?Q?KujChZmFvchh3QBWpt2Pd5zxMuEOOAoczse8Qvs8V+enNwitItYop1Xtni97?=
 =?us-ascii?Q?KdfIZJH+dhpRWL9Jchwjmo7tHigkz7hIjqGCjBsOCqDEQLgHEDMJDzQ/7PyV?=
 =?us-ascii?Q?TBcebA02RmT9cS9ZO+mSprKvU2yvHQfJD/cKS1v5F/C8npnyTQa1H8AiPm2E?=
 =?us-ascii?Q?zp0koQMT6pcSKZcsv6NBmC8H5VAfZ35WycNkJTsjMHopb1u389/9qvFPg0jN?=
 =?us-ascii?Q?WqqdMLJOZg4xet7EF7CWSKvxGz/5dBDYuLnQqB1AY4kLYyJiaQ0OgBCa3vFp?=
 =?us-ascii?Q?qE4W5vcQ8weKLNxC9qib0rSYFF0eCz8W990MVhgzWk+dkJCo6U0FVD4l0eSn?=
 =?us-ascii?Q?UQHdyNvh8HvfYXEMuIxCNe/ZBXRCspF60xOpZCun1WM4zI9OR2HYz7M6oESr?=
 =?us-ascii?Q?uKAUosUmrGniAoB8WeR00l7hpm8HyuS+Wg9dPrPXHLPevNx1Z/m4jJbcz93A?=
 =?us-ascii?Q?7R/olKan1/YBiZYVx7MSNIlXIq3mMXMd6H8k2UZFjFo428LvbEdaenKfLfUO?=
 =?us-ascii?Q?oo3++eka1P3IQoCBwEG/8yNlVtm5sx7BpcQW7h5mMjRgSrqD6M6HXg5oLVpe?=
 =?us-ascii?Q?ou40v3Gj9V776Gap+CblXPAOVZZJi98Fehp9jJwhUpZjWW8JQPziWob/RhVl?=
 =?us-ascii?Q?I/Gtsukdhgs87/LXUsrKyd+OuW5B/yCCrdYP30smRY2kirCgElhAj6K3JerE?=
 =?us-ascii?Q?Dg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 128dd344-c52c-43b0-53ee-08dbc4af7db4
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB6331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 07:57:01.1570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3JyB6f8eR70Xv7wCEhUne/oa5/5Bxt2JkjKAowZYrBEJtvUqr3iHlSRRTC3z8lQhHlBXsVGn51YC5vLdg6DzoHxRBzJ0xEi1Y/BhnYAaTJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10017
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Update transport acquire/release flow for BAP bcast source

---
 profiles/audio/bap.c | 51 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 48a1a4f86..f23e04f00 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1312,6 +1312,32 @@ static struct bap_ep *bap_find_ep_by_stream(struct bap_data *data,
 	return NULL;
 }
 
+static void iso_connect_bcast_cb(GIOChannel *chan, GError *err,
+					gpointer user_data)
+{
+	struct bt_bap_stream *stream = user_data;
+	int fd;
+
+	if (err) {
+		error("%s", err->message);
+		bt_bap_stream_set_io(stream, -1);
+		return;
+	}
+
+	DBG("ISO connected");
+
+	fd = g_io_channel_unix_get_fd(chan);
+
+	if (bt_bap_stream_set_io(stream, fd)) {
+		bt_bap_stream_start(stream, NULL, NULL);
+		g_io_channel_set_close_on_unref(chan, FALSE);
+		return;
+	}
+
+	error("Unable to set IO");
+	bt_bap_stream_set_io(stream, -1);
+}
+
 static void iso_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 {
 	struct bt_bap_stream *stream = user_data;
@@ -1560,6 +1586,17 @@ static gboolean bap_io_disconnected(GIOChannel *io, GIOCondition cond,
 	return FALSE;
 }
 
+static void bap_connect_bcast_io_cb(GIOChannel *chan, GError *err,
+					gpointer user_data)
+{
+	struct bap_ep *ep = user_data;
+
+	if (!ep->stream)
+		return;
+
+	iso_connect_bcast_cb(chan, err, ep->stream);
+}
+
 static void bap_connect_io_cb(GIOChannel *chan, GError *err, gpointer user_data)
 {
 	struct bap_ep *ep = user_data;
@@ -1661,7 +1698,7 @@ static void bap_connect_io_broadcast(struct bap_data *data, struct bap_ep *ep,
 	DBG("ep %p stream %p ", ep, stream);
 	ba2str(btd_adapter_get_address(adapter), addr);
 
-	io = bt_io_connect(bap_connect_io_cb, ep, NULL, &err,
+	io = bt_io_connect(bap_connect_bcast_io_cb, ep, NULL, &err,
 			BT_IO_OPT_SOURCE_BDADDR,
 			btd_adapter_get_address(adapter),
 			BT_IO_OPT_DEST_BDADDR,
@@ -1887,18 +1924,16 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 		}
 		break;
 	case BT_BAP_STREAM_STATE_QOS:
-		bap_create_io(data, ep, stream, true);
+		if (bt_bap_stream_get_type(stream) ==
+					BT_BAP_STREAM_TYPE_UCAST) {
+			bap_create_io(data, ep, stream, true);
+		}
 		break;
 	case BT_BAP_STREAM_STATE_ENABLING:
 		if (ep)
 			bap_create_io(data, ep, stream, false);
 		break;
 	case BT_BAP_STREAM_STATE_STREAMING:
-		if (bt_bap_stream_get_type(stream) ==
-				BT_BAP_STREAM_TYPE_BCAST) {
-			if (ep)
-				bap_create_io(data, ep, stream, false);
-		}
 		break;
 	}
 }
@@ -2116,6 +2151,8 @@ static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
 
 			ep->qos.bcast.big = qos.bcast.big;
 			ep->qos.bcast.bis = qos.bcast.bis;
+			bt_bap_stream_config(ep->stream, &ep->qos,
+					ep->caps, NULL, NULL);
 		}
 
 		DBG("stream %p fd %d: BIG 0x%02x BIS 0x%02x", stream, fd,
-- 
2.39.2

