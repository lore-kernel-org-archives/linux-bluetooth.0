Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2618CDB482
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Oct 2023 15:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbjJPPtY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Oct 2023 11:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbjJPPtX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Oct 2023 11:49:23 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2077.outbound.protection.outlook.com [40.107.20.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44B2F5
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Oct 2023 08:49:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wgv+TKmKTjpKwRgIIvXFsKZ1+1c4iRW27tVivJqPBTyikRbxMaWALG0KoA0/X03eCB/zJOIJO+MisXnyIAFYwtvEYWpo2jJXjS/u+RPRXIvYrXQgZ+ghNJx5f3MhNIvZ6pGhwcsuyNEWFqbnfxAmwNy+owHe9JM6QmruHBG/LYnIBJ7nQldThAlXcN+RW1Yw+0m1MBrMH0+WHipe386uGP7i0YU3ZbSueJpkgoktOgLVJIRkgKksUsUuaQiVqvHt63F+FPxRaHqN1Kj3IH/WWCvuJxwhBDMnN1OftFJEubytfDY6mR2K7CjldOaFJGEjpz+LopUf3Qv6wiFxmMh7BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmFJwwJzDq2bxlaxQEjn8WRM8sA42SO83zvngMOaLxA=;
 b=jrNtMsU/oDvmVO/4EdZjxIDLAgBEgs7it/JS53guY8gqbEd9iZrJOgF1kz7V7T1xAGwynjWGd4QnHz7NrcDiJv2TvEbYnr79aCG2LAoT+wXQcXwwTfMetOaBwnlB9GDKSF8+2aZbIZbJyxn6T1scqC+R/0ZDzGR+HPjB6lWq5zqBShSlj8Z8NusStrLrbUeHUj+er70+XRodaRDkwYJD/ZR2CADuIHo6udZfA0x8RoyVnRsS6gdZKOYQ1+7IPO6s4DOg0+8xo/wkvcIzo2d5J59KGrUZpZztDlW02LtxowUCVQvHrAGgDDFjMyZtXPayY6qnfZ5y4lc96OQ6FlhiaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmFJwwJzDq2bxlaxQEjn8WRM8sA42SO83zvngMOaLxA=;
 b=PKVO2VgyzoBNRLCptYNWn56yCsdBCD/1zjwLMuan8KUIAC4NR+l/RbFNQYn9tcoHEDcE19B72Y02CQVotSChBGVSgG2FMwvAx+kZEmZlISc6D3OH3h8nmz7NPMp/RbtiuUqzyhbRFe1PHrZRZcOuagBDzSad7xl3hWXy1g29GL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU2PR04MB9049.eurprd04.prod.outlook.com (2603:10a6:10:2e4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 15:49:18 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6863.046; Mon, 16 Oct 2023
 15:49:18 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 4/4] shared/bass: Add Modify Source initial implementation
Date:   Mon, 16 Oct 2023 18:49:00 +0300
Message-Id: <20231016154900.3094-5-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016154900.3094-1-iulia.tanasescu@nxp.com>
References: <20231016154900.3094-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0089.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::42) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU2PR04MB9049:EE_
X-MS-Office365-Filtering-Correlation-Id: 3993c944-d800-4e62-a29f-08dbce5f74b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2XCdVpfdkQA1F7G0sl9a/zTH4ylAWwUzRHDBWaNCO6ZUnnZeNZPve1LaxvK/KhxN6IlcQeGGREFOsboILMXtRe8eEkttmvYauWhAHwNW25rQ3dgHtEueVSiDeW4Df5Wwq13bwm1Wxq11hKAXLkORrFDAFNCMm/ACI+3XZ/SxwwIHLfjTquYv4zzpkhAU3v1+RzFJZSbnJkG0qEMxZHnMu/mzrICdgntIOivowvkAB0ZuNMRatN/PbdzisnT9qHBcD1wwttf8DPuQdaYZCpFtkJikm4gDbrve7p2wCg+19C3Q4aejNt80wONTJnDBk628YrDoLCNtFqzxjPJky1dQPFIX4txT1VtmGMcj56mIzBlvoIPoiUoQVOJ0ZkUzou2K9C5DmWneSiJadFoN2GFpXgiavn9avdoTYZQtKIK3m2ifEPRO/W6LH++UoxFKwpRg5C6OEgLphXs3DCaVoXE6NK3u5aZfOugvRNKWO0LUBTNxJJKpmVY/CiQ0o44uUvB4+vMwyqulapPQ/NvxIj8/M4ylb9FxlMiSJaOetS2UrWzRaIGHDHSFogvQCsT1Pwhp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6486002)(38100700002)(478600001)(2906002)(6512007)(6506007)(6666004)(316002)(66946007)(66476007)(66556008)(6916009)(4326008)(5660300002)(41300700001)(8936002)(44832011)(8676002)(83380400001)(1076003)(26005)(2616005)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oTp/K3qrYwwLFR32GwRcuLqvYLDaXRk5TxOZKdIAw3EofYlQg24VhJ45GDfE?=
 =?us-ascii?Q?fYkYSi64yrbgXNTUiexCG7txvglXyl/t70CyZ4eUbXa2pmYKETn7bgPkMqCv?=
 =?us-ascii?Q?CJAphFFxIHQzS6SIsrsg3Rd24OqKiFs+1PjXm086GThYzMibE68Vp/1y1e+6?=
 =?us-ascii?Q?UFrfyUDvuzjsZc9ua3xQo9kOET3/n+d5kki7nuHCv+8BLxDAgS4PE9s3/4uV?=
 =?us-ascii?Q?xFOflEpGCGIOA7qy5EXrrcQ8Uof5QPOO2URjGnHAcuQ4P5V9Uc98QEtz1s20?=
 =?us-ascii?Q?4/EIVIqA4zTf+yxj1J3eO0iVLo8E9CKwM6vTgBNmXq+mvU5x590s+91a2QcD?=
 =?us-ascii?Q?bUMv/vxrHLC/QyYrxjOqaYpITaPSm7h5WZLIEaRzfl9xwrjM+UnJO4fYWgjf?=
 =?us-ascii?Q?iwY5icKO4akexYb05X3vFqbcWfhxPs2grtBAnm7xgcd61LTvUUyYKS1EHZGo?=
 =?us-ascii?Q?k/9xErZU0MbYuTYrwOFMUaW6UosdsaRijzodzKNT2ws6Ey2NyaSIBVWiPF69?=
 =?us-ascii?Q?PoSKxYfZC3hzEfTzj9ddx2KmpyFnBwODFuK0/nhILQT7FUBoN6hquVBn5io+?=
 =?us-ascii?Q?8h6Dn4tILwsPwybxpm+pr2Djm/Q0gS6haBrJHEYrH+QYUw7U6TamrJMc4K8b?=
 =?us-ascii?Q?puU4T0oqEogm0kIlIImftsXwWjdlLn7/qZvonLa1vvSz7tmXn9xNhp31oc0X?=
 =?us-ascii?Q?gUoPcJHLZSF5ot7Ups5dQmHMlRawkxeTe9oz2Fms1VP6pVABmDuCcNtvs+W2?=
 =?us-ascii?Q?QtQSVirh+aMsHIllo76xy8g5PLnt/zg1VjeDAt5uR7EfNrcidhVFe+rEANHE?=
 =?us-ascii?Q?DElkDW9B0H6kxg75OkrFOH6QK6dg2Dsn6xAmiCEq1yEmrjXiVKlKR0Muskqc?=
 =?us-ascii?Q?SXPL0WiXJHWw2zt+WWxx0XSaNPoFzfUvlAQJ5EvJtJADCPvKU5gaTHY1Xeq0?=
 =?us-ascii?Q?z0c7+vM5ANtOj9J2UQ7HgXMNIKvJ3fS/gPrUV7uP8HhOjyByeqogfjNqHn8W?=
 =?us-ascii?Q?Bg7CWt74PBIrZgnD38xWzx7SPGMqH3LVbVh+T7kLbI0LQihzFh78GqswktYl?=
 =?us-ascii?Q?jlzByiJv281+IbANs6j3pZKp5ho5EyOtEKFQP8S3WtXEsumdPcHFIJ75pmUI?=
 =?us-ascii?Q?YkPQrdzalm6fpzia/KfvoMg8CTrbolWVT6H7pb0/nCELRbTRz5Z6cu6e4n4b?=
 =?us-ascii?Q?9e4REWmlUHFo6SIIuOn2DSYMTeFFJe3Z+RVEMaFfCwTSX5+X7wliO7jY6+G7?=
 =?us-ascii?Q?tPJfqHZ7reJaRjIHYjZiYscTNf4g3JEZuzbt5Q31meqeDf63K+6Q0LasO0gs?=
 =?us-ascii?Q?1xXxjx0cUmSgTtlMQI9iYhZaPamYTh2PdSX/BoPeWKvkcGqJp5ws6C/wbVS3?=
 =?us-ascii?Q?3+uBMdON+TgPc1ZE/uSNOnJO/bLfJXnuI89k69q3JXNC67wg8mIKAHG7Lqm7?=
 =?us-ascii?Q?E2/kk7ETm+ppzi1qp2Y2OUDHlxds/TViMJqyxX6xd3z5oogky/sdjIQLCVyd?=
 =?us-ascii?Q?6rdSQ32bS1zJARuXiDTnk+vxQf08ULaw6mcqnCoMj2MBq7xWEt6Sf9CCzsfY?=
 =?us-ascii?Q?v0hO+6FAfTdywz0bcsdtKnrzrBKsrLW3g01g4lLNnI33EQJK5dAZgEJxK+Dh?=
 =?us-ascii?Q?lw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3993c944-d800-4e62-a29f-08dbce5f74b9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 15:49:17.9513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ipkFT57Rskx6eY0b2mFu/O1/EVWA6uh/lr07EUMjPpzoI5sn4EuME7gAKDSoWyDku1UptxPljrpLoI+QVujWCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9049
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds an initial implementation for the BASS Modify Source
procedure

---
 src/shared/bass.c | 289 +++++++++++++++++++++++++++++++++++++++++-----
 src/shared/bass.h |   2 +
 2 files changed, 263 insertions(+), 28 deletions(-)

diff --git a/src/shared/bass.c b/src/shared/bass.c
index 326ce6dae..5765ef6ed 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -614,6 +614,9 @@ static void connect_cb(GIOChannel *io, GError *gerr,
 	g_io_channel_ref(io);
 	queue_push_tail(bcast_src->bises, io);
 
+	if (!bcast_src->bises)
+		bcast_src->bises = queue_new();
+
 	for (i = 0; i < bcast_src->num_subgroups; i++) {
 		struct bt_bass_subgroup_data *data =
 				&bcast_src->subgroup_data[i];
@@ -650,29 +653,6 @@ static void connect_cb(GIOChannel *io, GError *gerr,
 		queue_destroy(bcast_src->bises, bass_bis_unref);
 		bcast_src->bises = NULL;
 
-		/* Close listen io */
-		g_io_channel_shutdown(bcast_src->listen_io, TRUE, NULL);
-		g_io_channel_unref(bcast_src->listen_io);
-		bcast_src->listen_io = NULL;
-
-		if (bcast_src->listen_io_id > 0) {
-			g_source_remove(bcast_src->listen_io_id);
-			bcast_src->listen_io_id  = 0;
-		}
-
-		/* Close pa sync io */
-		if (bcast_src->pa_sync_io) {
-			g_io_channel_shutdown(bcast_src->pa_sync_io,
-					TRUE, NULL);
-			g_io_channel_unref(bcast_src->pa_sync_io);
-			bcast_src->pa_sync_io = NULL;
-		}
-
-		if (bcast_src->pa_sync_io_id > 0) {
-			g_source_remove(bcast_src->pa_sync_io_id);
-			bcast_src->pa_sync_io_id  = 0;
-		}
-
 		for (i = 0; i < bcast_src->num_subgroups; i++)
 			bcast_src->subgroup_data[i].bis_sync =
 				BT_BASS_BIG_SYNC_FAILED_BITMASK;
@@ -741,6 +721,17 @@ static void confirm_cb(GIOChannel *io, gpointer user_data)
 
 		/* Mark PA sync as failed and notify client */
 		bcast_src->sync_state = BT_BASS_FAILED_TO_SYNCHRONIZE_TO_PA;
+
+		/* Close listen io */
+		g_io_channel_shutdown(bcast_src->listen_io, TRUE, NULL);
+		g_io_channel_unref(bcast_src->listen_io);
+		bcast_src->listen_io = NULL;
+
+		if (bcast_src->listen_io_id > 0) {
+			g_source_remove(bcast_src->listen_io_id);
+			bcast_src->listen_io_id  = 0;
+		}
+
 		goto notify;
 	}
 
@@ -1037,7 +1028,7 @@ static void bass_handle_add_src_op(struct bt_bass *bass,
 					data->meta_len), data->meta_len);
 	}
 
-	if (pa_sync != PA_SYNC_NO_SYNC) {
+	if (*pa_sync != PA_SYNC_NO_SYNC) {
 		/* Convert to three-value type */
 		if (bcast_src->addr_type)
 			addr_type = BDADDR_LE_RANDOM;
@@ -1072,9 +1063,6 @@ static void bass_handle_add_src_op(struct bt_bass *bass,
 					G_IO_HUP | G_IO_NVAL,
 					(GIOFunc)listen_io_disconnect_cb,
 					bcast_src);
-
-		if (num_bis > 0 && !bcast_src->bises)
-			bcast_src->bises = queue_new();
 	} else {
 		for (int i = 0; i < bcast_src->num_subgroups; i++)
 			bcast_src->subgroup_data[i].bis_sync =
@@ -1179,12 +1167,255 @@ static void bass_handle_set_bcast_code_op(struct bt_bass *bass,
 	}
 
 	if (!bt_io_bcast_accept(bcast_src->pa_sync_io, connect_cb,
-		bcast_src, NULL, &gerr,  BT_IO_OPT_INVALID)) {
+		bcast_src, NULL, &gerr, BT_IO_OPT_INVALID)) {
 		DBG(bcast_src->bass, "bt_io_bcast_accept: %s", gerr->message);
 		g_error_free(gerr);
 	}
 }
 
+static bool bass_validate_mod_src_params(struct bt_bass_mod_src_params *params,
+							struct iovec *iov)
+{
+	struct iovec subgroup_data = {
+		.iov_base = iov->iov_base,
+		.iov_len = iov->iov_len,
+	};
+
+	if (params->pa_sync > PA_SYNC_NO_PAST)
+		return false;
+
+	if (!bass_validate_bis_sync(params->num_subgroups,
+					&subgroup_data))
+		return false;
+
+	return true;
+}
+
+static void bass_handle_mod_src_op(struct bt_bass *bass,
+					struct gatt_db_attribute *attrib,
+					uint8_t opcode,
+					unsigned int id,
+					struct iovec *iov,
+					struct bt_att *att)
+{
+	struct bt_bass_mod_src_params *params;
+	struct bt_bcast_src *bcast_src;
+	uint8_t num_bis = 0;
+	uint8_t bis[ISO_MAX_NUM_BIS];
+	uint8_t addr_type;
+	GIOChannel *io;
+	GError *err = NULL;
+	struct bt_iso_qos iso_qos = default_qos;
+	struct bt_bass_subgroup_data *subgroup_data = NULL;
+	uint8_t *notify_data;
+	size_t notify_data_len;
+	bool changed = false;
+
+	/* Get Modify Source command parameters */
+	params = util_iov_pull_mem(iov, sizeof(*params));
+
+	bcast_src = queue_find(bass->ldb->bcast_srcs,
+						bass_src_id_match,
+						&params->id);
+
+	if (!bcast_src) {
+		/* No source matches the written source id */
+		gatt_db_attribute_write_result(attrib, id,
+					BT_BASS_ERROR_INVALID_SOURCE_ID);
+
+		return;
+	}
+
+	gatt_db_attribute_write_result(attrib, id, 0x00);
+
+	/* Ignore operation if parameters are invalid */
+	if (!bass_validate_mod_src_params(params, iov))
+		return;
+
+	/* Only subgroup metadata can change */
+	if (params->num_subgroups != bcast_src->num_subgroups)
+		return;
+
+	/* Extract subgroup information */
+	subgroup_data = malloc(params->num_subgroups * sizeof(*subgroup_data));
+	if (!subgroup_data)
+		return;
+
+	memset(subgroup_data, 0, params->num_subgroups *
+		sizeof(*subgroup_data));
+
+	for (int i = 0; i < params->num_subgroups; i++) {
+		struct bt_bass_subgroup_data *data = &subgroup_data[i];
+		struct bt_bass_subgroup_data *old_data =
+				&bcast_src->subgroup_data[i];
+
+		util_iov_pull_le32(iov, &data->pending_bis_sync);
+
+		if (old_data->pending_bis_sync)
+			goto err;
+
+		if (old_data->bis_sync && data->pending_bis_sync &&
+			data->pending_bis_sync != old_data->bis_sync)
+			/* The Server cannot resync to different BIS indxes */
+			goto err;
+
+		if (data->pending_bis_sync == BIS_SYNC_NO_PREF)
+			data->pending_bis_sync = DEFAULT_BIS_SYNC_BITMASK;
+
+		if (data->pending_bis_sync != 0) {
+			/* Client instructs Server to sync to some BISes */
+			for (int bis_idx = 0; bis_idx < 31; bis_idx++) {
+				if (data->pending_bis_sync & (1 << bis_idx)) {
+					bis[num_bis] = bis_idx + 1;
+					num_bis++;
+				}
+			}
+		}
+
+		data->meta_len = *(uint8_t *)util_iov_pull_mem(iov,
+						sizeof(data->meta_len));
+		if (!data->meta_len)
+			continue;
+
+		data->meta = malloc(data->meta_len);
+		if (!data->meta)
+			goto err;
+
+		memcpy(data->meta, (uint8_t *)util_iov_pull_mem(iov,
+					data->meta_len), data->meta_len);
+
+		if (old_data->meta_len != data->meta_len ||
+			memcmp(old_data->meta, data->meta, old_data->meta_len))
+			changed = true;
+	}
+
+	if (bcast_src->sync_state == BT_BASS_NOT_SYNCHRONIZED_TO_PA &&
+		bcast_src->listen_io)
+		return;
+
+	/* If subgroup information has been extracted successfully,
+	 * update broadcast source
+	 */
+	if (bcast_src->subgroup_data) {
+		for (int i = 0; i < bcast_src->num_subgroups; i++)
+			free(bcast_src->subgroup_data[i].meta);
+
+		free(bcast_src->subgroup_data);
+	}
+
+	bcast_src->subgroup_data = subgroup_data;
+
+	/* Client instructs Server to sync to PA */
+	if (bcast_src->sync_state == BT_BASS_NOT_SYNCHRONIZED_TO_PA) {
+		if (params->pa_sync == PA_SYNC_NO_PAST) {
+			/* Convert to three-value type */
+			if (bcast_src->addr_type)
+				addr_type = BDADDR_LE_RANDOM;
+			else
+				addr_type = BDADDR_LE_PUBLIC;
+
+			/* Try to synchronize to the source */
+			io = bt_io_listen(NULL, confirm_cb, bcast_src,
+						NULL, &err,
+						BT_IO_OPT_SOURCE_BDADDR,
+						&bass->ldb->adapter_bdaddr,
+						BT_IO_OPT_DEST_BDADDR,
+						&bcast_src->addr,
+						BT_IO_OPT_DEST_TYPE,
+						addr_type,
+						BT_IO_OPT_MODE, BT_IO_MODE_ISO,
+						BT_IO_OPT_QOS, &iso_qos,
+						BT_IO_OPT_ISO_BC_SID,
+						bcast_src->sid,
+						BT_IO_OPT_ISO_BC_NUM_BIS,
+						num_bis,
+						BT_IO_OPT_ISO_BC_BIS, bis,
+						BT_IO_OPT_INVALID);
+
+			if (!io) {
+				DBG(bass, "%s", err->message);
+				g_error_free(err);
+				return;
+			}
+
+			bcast_src->listen_io = io;
+			g_io_channel_ref(bcast_src->listen_io);
+
+			if (bcast_src->listen_io_id > 0) {
+				g_source_remove(bcast_src->listen_io_id);
+				bcast_src->listen_io_id  = 0;
+			}
+
+			bcast_src->listen_io_id = g_io_add_watch(io, G_IO_ERR |
+					G_IO_HUP | G_IO_NVAL,
+					(GIOFunc)listen_io_disconnect_cb,
+					bcast_src);
+		}
+
+		if (changed)
+			goto notify;
+
+		return;
+	}
+
+	/* Client instructs Server to stop PA sync */
+	if (params->pa_sync == PA_SYNC_NO_SYNC) {
+		/* TODO */
+		return;
+	}
+
+	/* Server is already synchronized to PA, and Client now
+	 * instructs the Server to also sync to some BISes
+	 */
+	if (num_bis && !queue_length(bcast_src->bises)) {
+		/* Since the Server has never been synced to any BIS before,
+		 * the PA sync socket must be bound to the num_bis to sync with
+		 */
+		if (!bt_io_bcast_accept(bcast_src->pa_sync_io, connect_cb,
+					bcast_src, NULL, &err,
+					BT_IO_OPT_ISO_BC_NUM_BIS, num_bis,
+					BT_IO_OPT_ISO_BC_BIS, bis,
+					BT_IO_OPT_INVALID)) {
+			DBG(bcast_src->bass, "bt_io_bcast_accept: %s",
+				err->message);
+			g_error_free(err);
+		}
+
+		return;
+	}
+
+	/* Client instructs Server to keep PA sync but stop BIG sync */
+	if (!num_bis && queue_length(bcast_src->bises)) {
+		/* TODO */
+		return;
+	}
+
+	/* If no change has occurred, just return */
+	if (!changed)
+		return;
+
+notify:
+	notify_data = bass_build_notif_from_bcast_src(bcast_src,
+						&notify_data_len);
+
+	gatt_db_attribute_notify(bcast_src->attr,
+			(void *)notify_data,
+			notify_data_len,
+			bt_bass_get_att(bcast_src->bass));
+
+	free(notify_data);
+
+	return;
+
+err:
+	if (subgroup_data) {
+		for (int i = 0; i < params->num_subgroups; i++)
+			free(subgroup_data[i].meta);
+
+		free(subgroup_data);
+	}
+}
+
 #define BASS_OP(_str, _op, _size, _func) \
 	{ \
 		.str = _str, \
@@ -1214,6 +1445,8 @@ struct bass_op_handler {
 		0, bass_handle_add_src_op),
 	BASS_OP("Set Broadcast Code", BT_BASS_SET_BCAST_CODE,
 		0, bass_handle_set_bcast_code_op),
+	BASS_OP("Modify Source", BT_BASS_MOD_SRC,
+		0, bass_handle_mod_src_op),
 	{}
 };
 
diff --git a/src/shared/bass.h b/src/shared/bass.h
index bd3fe900b..ee958bf7a 100644
--- a/src/shared/bass.h
+++ b/src/shared/bass.h
@@ -32,6 +32,8 @@ struct bt_bass;
 #define BT_BASS_BIG_ENC_STATE_DEC			0x02
 #define BT_BASS_BIG_ENC_STATE_BAD_CODE			0x03
 
+#define DEFAULT_BIS_SYNC_BITMASK			0x00000001
+
 /* BASS subgroup field of the Broadcast
  * Receive State characteristic
  */
-- 
2.39.2

