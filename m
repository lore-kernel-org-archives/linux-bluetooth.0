Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1C2EC873A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Sep 2023 15:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbjIGPmZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Sep 2023 11:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjIGPYd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Sep 2023 11:24:33 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2073.outbound.protection.outlook.com [40.107.7.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C271B2
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Sep 2023 08:24:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5YEadlkXbWLPEUfqZePqQVOuV1VAQf50ee/IbHzEVGUlz5miLAyFZP0KFwcBo3x24zWcdqnBqtlDT6SteE5Ec46lCLJrSZNLDgDm608zM7cEQWkuxMF4JSb096Gbd2yKW36uXJsWgaXqrjwX63WMqcLjI34D/BqvtDpDC+rsoGcsIqclQfWrV2TynWeYUdzOG0+H4lhoO5U9SDJX7hzmAflv1qbQl6zDfuySvFMa2Ymr5XK7We0oaAIY9LOISsdBkhv/w++ffN08Yje9tU/EelVuBt5jEJa7XY3KdqgUYMr+obmcS99BgZQSB782KMzL6YS+JuqrYdS8DJW4E7WSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ns5bZyDE+Fsxjlx5eaGnJRzyQg2H9HFfjbK/gPJ5wU=;
 b=TbhqmVm+jpKSr5tz2Kjx89siu7JswcBVWrpJm/fZY81d0B/N1ODIO6KaGvVO14ItRXWamBGTkmmJcW5wJnhlD7OTfwhMY3iCmKvqeKnY0Y8fVcnETtgAdYg4hULjR7mmavQUgaOhwvPnpNeorEBZLJz1GvQKRTArIFMqfExm4hfSzErowepTF/iaRtA7ddXit9oqbLADRashk/wNvKtCjY5DPHum4XtpxVIMKpbjxpEmIXPy/anz7bMHKByuiz5VMNLfV5C6mDnBmUEOQ8duQ9wXe0Bl9HoOXj7Fvts6i75pMoeY3cYCOhuWk1pMwUJh9mAhdH/SW4XCnaJGmLsO8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ns5bZyDE+Fsxjlx5eaGnJRzyQg2H9HFfjbK/gPJ5wU=;
 b=R/A/HCKzxfD7coKV74hTM/aFwYhK2AGLmtfZag0GpIDoPWQBPpyLI3hwHGLQfymButOWUl0hXbNXEWRYPwXAtoBkDDxoN7waPvUU5Z9VkwOrft3lGLDR/qnMZw4ILD+Kw0pSN29WyBEIHIBaBc+BC27lK1snlXBOLKbrcj3vPnM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by GVXPR04MB9759.eurprd04.prod.outlook.com (2603:10a6:150:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Thu, 7 Sep
 2023 15:12:56 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 15:12:56 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 3/3] shared/bass: Add Set Broadcast_Code opcode handler
Date:   Thu,  7 Sep 2023 18:12:29 +0300
Message-Id: <20230907151229.7306-4-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907151229.7306-1-iulia.tanasescu@nxp.com>
References: <20230907151229.7306-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0195.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::32) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|GVXPR04MB9759:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a003328-00f3-4642-a80c-08dbafb4ea4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JVrNt/itKqwKhPrIBqqI6o3GNSdgq1I5BbCwyFPLSCXdQsZlK8Jy8y5Y2RmBA/hbCLpRHJaFimVYThpHInye/ixAXxS37p1FMExguXrj4YhyLCZpgxrED2rF7e6orqExqi8Qvv7Yk+zbuZkiim8w+egkz/kKjn1kjfUpanaQRCvzHkMn42mMT/QRvlgjcqsdbtukWT4FFt41URHZyjbupjtGQRvv/IrCTGKVwwAIFHn1xCRRgIuOfb/1OR9lrkvIOb6de08Yn91QnqC3c8KtOFGJ0M/5eIxarDjYvHMPCvd8q6rFCllGGkR8A/gqnfSVj/5tsc03NX7smKdhknaI8LwNbXHCwWWY+ypGciEyfHGwvDkqTlhlOH51I9irds7xt9NAH64mUTyW+U9ejB9hgyzokMRGOsOHxkHj6MTs8h32pZZI5pbHvxmTn6l1kghkjpVdKcZkS61mcBkfHmI3zrQmSdNDgTRg6on3eUgl2mKY1O4GhSWOPFdqJYMP0Mt0nDKV3PESGDMcWADB877Rd6z0PWCnUE1U8vaOb8zsDP9AeBsANDCCljeqiuZhodxFBuzb5M3bs7RzZeKpob/LXg4aVbuaZQUb8VcvCBfTsGj18v0IBzdRyZViHpAHv9E8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(346002)(366004)(376002)(1800799009)(186009)(451199024)(2906002)(36756003)(38100700002)(38350700002)(86362001)(55236004)(52116002)(1076003)(4326008)(8676002)(8936002)(6666004)(66476007)(44832011)(26005)(5660300002)(316002)(41300700001)(66946007)(66556008)(6916009)(6512007)(6506007)(2616005)(6486002)(83380400001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0EOZ81CXFiEDVh90Npv680xqIA0HMH47nae1b7RZuFStKalYwxkVG1aNXLU6?=
 =?us-ascii?Q?DmRuSXiOr75k5gMfq9Ixl8SiGVzJbI2eCZkgc45vhHygPYPLtslJp8qeBc7o?=
 =?us-ascii?Q?1zQwPBGD7BLn2EH9YPCxcTyY3mQgT5Gx0ztATyxTlYU61b6CM6nAVG/1XpdD?=
 =?us-ascii?Q?LVdmho1piunbTVIDuj35vMqbhl5CfICVijUkLA5lglU6vGzBFN6pZQfcOsz4?=
 =?us-ascii?Q?iJlO9yMQBpE+RT/aoATQG/X30LgNUsDJiTlikVkP2Geyp6cVJWOsjGMMzCtK?=
 =?us-ascii?Q?pyG2MoTaWUXm6tfqf8FenAoNeBSgwoiaWnrGEHjTCtNZNhpGi4CrMsELuG/Q?=
 =?us-ascii?Q?rG3IK2OXkEovTka5NtqDMw/Cu7FZNYLmhyi4twWxRjvjPq87PwHdfOltEF/I?=
 =?us-ascii?Q?lxfKelQ+LGeA/wyI/upk0PA3BJ24iXjrSDd5BF0HeZlLf23XTSiO+0EDbWeO?=
 =?us-ascii?Q?Cf9mvKTCpXLGzEtXXEWQHkT25kPacQwmveIIia0Ea9qqBGyIazSzSEz2QTl/?=
 =?us-ascii?Q?pkLjhmfm/ZniYi3DORxh/MlEpHGBwXQq2OR8ofmpcysZqhEcClOBWL9+pdSu?=
 =?us-ascii?Q?0Mfu8/j7PMmGwfoBY+Y20MDsCBliXraq534l350nDAgweyGjaU8Suzuig/4a?=
 =?us-ascii?Q?ETjqoLD/0wHTn1GYXupotXzQRS34tUllwsH0Tm/+tV6qbAXv+aPVssZR6o8Z?=
 =?us-ascii?Q?0ysVAqHjtXZS/viwKZIopLMejgqFqLg/MnA5OsLmfnNe4YYECZUO349M0rJa?=
 =?us-ascii?Q?iBkYZYttdrAcxrwYSnRcKwGCL+yHkwnSdBjqaRmeImXdrr/NWK2C46etedeC?=
 =?us-ascii?Q?4vxbixI8PNSqt2Kr1oKQXIY8/uu4q4BSXPCTGlNY0NMc+dsQc0IiIbykrTge?=
 =?us-ascii?Q?txuoNXYSFAbhwZQJnvmX4nqgf4l7mXuYPkUczCRM9m2Ra7yPRjt2nQahe6kc?=
 =?us-ascii?Q?AMzG2NCfeCkU+g8CJd8M0vppB1ClWkGBijj/drPE5zHEx0lN28S54xa6iscu?=
 =?us-ascii?Q?b9cIYis10AjEvME2/aXl1FXGF3Y8maJSz8zt5GVXjSZnK+Y2iB4KaIaeTIy/?=
 =?us-ascii?Q?UGGqGO/7+3roqoo8RC3xzBgS7ZbptvAI5xBsuwidj4WFeP/K57gHbIKFOxhs?=
 =?us-ascii?Q?G3hCtEzv6P3xZAEhHTBU1viq2mqivOePo43CEwMfJbNa3KDrmPvCUhulYhCJ?=
 =?us-ascii?Q?2zgA+jQc8EcovDpzrfWb0RS/VdNFyPHqfpQOvbYIA4fxxkG0EAxZhaPlBKVy?=
 =?us-ascii?Q?Pv9NbOmOz2G2UNP9wyZl1HANmhLGcDiEIWKKmKBGc9wtFYHjfecI7m2iR3m2?=
 =?us-ascii?Q?SaCf81dFT/1FLH9W4c9ojmrMtbVNXc3OFahinpfkr7ihCOEWRZeFmWzNyPRY?=
 =?us-ascii?Q?nLk+SASg1pmNtPvbjcn4LIwpUjrYgg7LYj3TK/kthGcNKU1rf0idEH06VjVp?=
 =?us-ascii?Q?2ZU5060PTEgyZRuq47617lg/oiyIhth4ySh/vnha+6oest/q3AV0QBf9ISEK?=
 =?us-ascii?Q?r1Ix1N8XWFLI2r/qwwmtUris7/FPCmbmOQSy1t6M8edsCB2xXSKi0WdrB3kp?=
 =?us-ascii?Q?8QLnhv01KLQ532vYDZKRVEEcp2ktPixFxESyPM9+yuYNNFB2ur06K4IlPEkf?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a003328-00f3-4642-a80c-08dbafb4ea4e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 15:12:56.5102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p1ukWST8tO0cQFcN4d8Iy15HQht/UheBkmmphkaJEVD58Evcqc7eE9LHUAT5RtJe4UHf/HGqKviv63CgGgS7fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9759
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds the Set Broadcast_Code opcode handler, enabling a BASS Server
to sync to an encrypted BIG.

---
 src/shared/bass.c | 159 +++++++++++++++++++++++++++++++++++++++++++---
 src/shared/bass.h |   1 +
 2 files changed, 151 insertions(+), 9 deletions(-)

diff --git a/src/shared/bass.c b/src/shared/bass.c
index 1bb40877f..86dab03e3 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -613,9 +613,6 @@ static void connect_cb(GIOChannel *io, GError *gerr,
 	int bis_idx;
 	int i;
 
-	if (bcast_src->sync_state == BT_BASS_NOT_SYNCHRONIZED_TO_PA)
-		bcast_src->sync_state = BT_BASS_SYNCHRONIZED_TO_PA;
-
 	/* Keep io reference */
 	g_io_channel_ref(io);
 	queue_push_tail(bcast_src->bises, io);
@@ -661,9 +658,26 @@ static void connect_cb(GIOChannel *io, GError *gerr,
 		g_io_channel_unref(bcast_src->listen_io);
 		bcast_src->listen_io = NULL;
 
+		/* Close pa sync io */
+		if (bcast_src->pa_sync_io) {
+			g_io_channel_shutdown(bcast_src->pa_sync_io,
+					TRUE, NULL);
+			g_io_channel_unref(bcast_src->pa_sync_io);
+			bcast_src->pa_sync_io = NULL;
+		}
+
 		for (i = 0; i < bcast_src->num_subgroups; i++)
 			bcast_src->subgroup_data[i].bis_sync =
 				BT_BASS_BIG_SYNC_FAILED_BITMASK;
+
+		/* If BIG sync failed because of an incorrect broadcast code,
+		 * inform client
+		 */
+		if (bcast_src->enc == BT_BASS_BIG_ENC_STATE_BCODE_REQ)
+			bcast_src->enc = BT_BASS_BIG_ENC_STATE_BAD_CODE;
+	} else {
+		if (bcast_src->enc == BT_BASS_BIG_ENC_STATE_BCODE_REQ)
+			bcast_src->enc = BT_BASS_BIG_ENC_STATE_DEC;
 	}
 
 	/* Send notification to client */
@@ -678,6 +692,66 @@ static void connect_cb(GIOChannel *io, GError *gerr,
 	free(notify_data);
 }
 
+static void confirm_cb(GIOChannel *io, gpointer user_data)
+{
+	struct bt_bcast_src *bcast_src = user_data;
+	int sk, err;
+	socklen_t len;
+	struct bt_iso_qos qos;
+	uint8_t *notify_data;
+	size_t notify_data_len;
+	GError *gerr = NULL;
+
+	if (check_io_err(io)) {
+		DBG(bcast_src->bass, "PA sync failed");
+
+		/* Mark PA sync as failed and notify client */
+		bcast_src->sync_state = BT_BASS_FAILED_TO_SYNCHRONIZE_TO_PA;
+		goto notify;
+	}
+
+	bcast_src->sync_state = BT_BASS_SYNCHRONIZED_TO_PA;
+	bcast_src->pa_sync_io = io;
+	g_io_channel_ref(bcast_src->pa_sync_io);
+
+	len = sizeof(qos);
+	memset(&qos, 0, len);
+
+	sk = g_io_channel_unix_get_fd(io);
+
+	err = getsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, &qos, &len);
+	if (err < 0) {
+		DBG(bcast_src->bass, "Failed to get iso qos");
+		return;
+	}
+
+	if (!qos.bcast.encryption) {
+		/* BIG is not encrypted. Try to synchronize */
+		bcast_src->enc = BT_BASS_BIG_ENC_STATE_NO_ENC;
+
+		if (!bt_io_bcast_accept(bcast_src->pa_sync_io,
+			connect_cb, bcast_src, NULL, &gerr)) {
+			DBG(bcast_src->bass, "bt_io_accept: %s", gerr->message);
+			g_error_free(gerr);
+		}
+		return;
+	}
+
+	/* BIG is encrypted. Wait for Client to provide the Broadcast_Code */
+	bcast_src->enc = BT_BASS_BIG_ENC_STATE_BCODE_REQ;
+
+notify:
+	notify_data = bass_build_notif_from_bcast_src(bcast_src,
+						&notify_data_len);
+
+	gatt_db_attribute_notify(bcast_src->attr,
+					(void *)notify_data,
+					notify_data_len,
+					bt_bass_get_att(bcast_src->bass));
+
+	free(notify_data);
+}
+
 static struct bt_bass *bass_get_session(struct bt_att *att, struct gatt_db *db,
 		const bdaddr_t *adapter_bdaddr)
 {
@@ -796,11 +870,6 @@ static void bass_handle_add_src_op(struct bt_bass *bass,
 	pa_sync = util_iov_pull_mem(iov, sizeof(*pa_sync));
 	bcast_src->sync_state = BT_BASS_NOT_SYNCHRONIZED_TO_PA;
 
-	/* TODO: Set the encryption field based on observed BIGInfo reports,
-	 * after PA sync establishment
-	 */
-	bcast_src->enc = BT_BASS_BIG_ENC_STATE_NO_ENC;
-
 	/* TODO: Use the pa_interval field for the sync transfer procedure */
 	util_iov_pull_mem(iov, sizeof(uint16_t));
 
@@ -852,7 +921,7 @@ static void bass_handle_add_src_op(struct bt_bass *bass,
 
 	if (pa_sync != PA_SYNC_NO_SYNC && num_bis > 0) {
 		/* If requested by client, try to synchronize to the source */
-		io = bt_io_listen(connect_cb, NULL, bcast_src, NULL, &err,
+		io = bt_io_listen(NULL, confirm_cb, bcast_src, NULL, &err,
 					BT_IO_OPT_SOURCE_BDADDR,
 					&bass->ldb->adapter_bdaddr,
 					BT_IO_OPT_DEST_BDADDR,
@@ -906,6 +975,71 @@ err:
 	free(bcast_src);
 }
 
+static void bass_handle_set_bcast_code_op(struct bt_bass *bass,
+					struct gatt_db_attribute *attrib,
+					uint8_t opcode,
+					unsigned int id,
+					struct iovec *iov,
+					struct bt_att *att)
+{
+	struct bt_bass_set_bcast_code_params *params;
+	struct bt_bcast_src *bcast_src;
+	int sk, err;
+	socklen_t len;
+	struct bt_iso_qos qos;
+	GError *gerr = NULL;
+
+	if (opcode == BT_ATT_OP_WRITE_REQ)
+		gatt_db_attribute_write_result(attrib, id, 0x00);
+
+	/* Get Set Broadcast Code command parameters */
+	params = util_iov_pull_mem(iov, sizeof(*params));
+
+	bcast_src = queue_find(bass->ldb->bcast_srcs,
+						bass_src_id_match,
+						&params->id);
+
+	if (!bcast_src) {
+		/* No source matches the written source id */
+		if (opcode == BT_ATT_OP_WRITE_REQ)
+			gatt_db_attribute_write_result(attrib, id,
+					BT_BASS_ERROR_INVALID_SOURCE_ID);
+
+		return;
+	}
+
+	/* Try to sync to the source using the
+	 * received broadcast code
+	 */
+	len = sizeof(qos);
+	memset(&qos, 0, len);
+
+	if (!bcast_src->pa_sync_io)
+		return;
+
+	sk = g_io_channel_unix_get_fd(bcast_src->pa_sync_io);
+
+	err = getsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, &qos, &len);
+	if (err < 0) {
+		DBG(bcast_src->bass, "Failed to get iso qos");
+		return;
+	}
+
+	/* Update socket QoS with Broadcast Code */
+	memcpy(qos.bcast.bcode, params->bcast_code, BT_BASS_BCAST_CODE_SIZE);
+
+	if (setsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, &qos,
+				sizeof(qos)) < 0) {
+		DBG(bcast_src->bass, "Failed to set iso qos");
+		return;
+	}
+
+	if (!bt_io_bcast_accept(bcast_src->pa_sync_io, connect_cb,
+		bcast_src, NULL, &gerr)) {
+		DBG(bcast_src->bass, "bt_io_accept: %s", gerr->message);
+		g_error_free(gerr);
+	}
+}
 
 #define BASS_OP(_str, _op, _size, _func) \
 	{ \
@@ -934,6 +1068,8 @@ struct bass_op_handler {
 		0, bass_handle_remove_src_op),
 	BASS_OP("Add Source", BT_BASS_ADD_SRC,
 		0, bass_handle_add_src_op),
+	BASS_OP("Set Broadcast Code", BT_BASS_SET_BCAST_CODE,
+		0, bass_handle_set_bcast_code_op),
 	{}
 };
 
@@ -1092,6 +1228,11 @@ static void bass_bcast_src_free(void *data)
 		g_io_channel_unref(bcast_src->listen_io);
 	}
 
+	if (bcast_src->pa_sync_io) {
+		g_io_channel_shutdown(bcast_src->pa_sync_io, TRUE, NULL);
+		g_io_channel_unref(bcast_src->pa_sync_io);
+	}
+
 	queue_destroy(bcast_src->bises, bass_bis_unref);
 
 	free(bcast_src);
diff --git a/src/shared/bass.h b/src/shared/bass.h
index fb4b72d7d..b3f83b32e 100644
--- a/src/shared/bass.h
+++ b/src/shared/bass.h
@@ -57,6 +57,7 @@ struct bt_bcast_src {
 	uint8_t num_subgroups;
 	struct bt_bass_subgroup_data *subgroup_data;
 	GIOChannel *listen_io;
+	GIOChannel *pa_sync_io;
 	struct queue *bises;
 };
 
-- 
2.34.1

