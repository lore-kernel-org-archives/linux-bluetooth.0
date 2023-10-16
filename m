Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79794CDB474
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Oct 2023 15:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbjJPPtR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Oct 2023 11:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjJPPtQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Oct 2023 11:49:16 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2057.outbound.protection.outlook.com [40.107.7.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A377DE6
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Oct 2023 08:49:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAB45zxqQrJHYwvlegSkqjcc1Wm7Sgc/BuNUMgVr/BB65zmR1MGPV43PKmxTkjF/8Dv96v0VNcxQtGUC611216FeCNs88BLwTAtfRhtIE8tgOgr0neYy0dOFhOTWtrZ39nGtD9x/3RcPUyEMoayWCFlag/UXtXugGfzExh1gnfymW437wkmNSKE14zCnxcZK/dLDLecx2PUaZuqQCvjOQeFU0ZOGehnwje5DdI61OyweUSDFKxfAYCwZrFQyBnvnt818RuavOo4fFNIhN8k6AHFkqj/hrkeLZmQ3dr/+yyv+od0Uh/2nNlTd/ROsR1dQz8Fg/dcdBb9DttvMgb2lyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbyYR8m4Zqs2O3cFeKwsVcuYwv9OeWAHuEYTp8xEBVs=;
 b=nBgr1/RG3PNPqynrSn7gH5kd3AJsru6gZ+OfQszfCM0RkbPRs26I1vQVHAcNEMpLI6ya81ZgJWIqM3gUJ89SJ80sYAGJrGbQ+0le+QuQgRuYiE5y2TS5yDeza/ljNUhmXmk14G07wnx0OC+Lej7kkIs5Eo6nUFfMAlgDFo2TrTHsZen//lUoZtSesOp52e+igmTyn7eN0vtM9veK6W2/TUp1dNum7XbVQLOX1F2QZBArsdUJ2kNgqG/yhzEDN40U5c03xSY1NniCg2xe1TEQLQ/rh67hglZ8ewCacDLtXR2LUFMpmUER+/CrBPwNqq6VnolwK4Kvp/oF9yAV7Hj6Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbyYR8m4Zqs2O3cFeKwsVcuYwv9OeWAHuEYTp8xEBVs=;
 b=gsiIrmMN31RCq/D9dfRYcRzK6QxDzBw0ONR2mg+EWzMwGi21LzCgOiyWCQmCLa3qP8qSix7vvLSFnQkBjD2OXqCcWSHtuG37VLBes0BDhwWD7c3EOagVlWMU2LzBVH7Jq5kfmywIFf+53DMUaYwddZxdmopOg/MQsDoSwIsT/Hg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VE1PR04MB7423.eurprd04.prod.outlook.com (2603:10a6:800:1a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 15:49:12 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6863.046; Mon, 16 Oct 2023
 15:49:12 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 2/4] shared/bass: Handle G_IO_HUP on io channels
Date:   Mon, 16 Oct 2023 18:48:58 +0300
Message-Id: <20231016154900.3094-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016154900.3094-1-iulia.tanasescu@nxp.com>
References: <20231016154900.3094-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0045.eurprd04.prod.outlook.com
 (2603:10a6:802:2::16) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VE1PR04MB7423:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c95b0f5-6277-4c95-0b9d-08dbce5f712b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e4mGIG/M6KI0PS+l5ZHOSXVe7yPTqqhPLBypnYFMh1t8aBuUA9jqQLA/GKgeK3FEKL2RnNRkLrqDg0QFP8FZaNJKdEnD/YhXLM0iGliB+nWcSdPnr7Krj1wVjM6SoZnjHCff0V0b07GmMPJSYBfNpee0VO0x25dk51s/pJx5+gQypI3kTTwSPDquqZkxeyVIdGtCULwxK7oUkMplNU/dGOVKxHcifzTO03iVaZcNo9nqGCqsBdq3KZbe/kPzAO8U6PAK5s9D3Cc8wiXOmSPscjkzXKPFmLKns2961A+iVTw8ptvN2oXUydDyQ87CrBHOdT6IbVsoM/5wvo/ZuX3hhb0fYXFrsIxVmQMiNkcl2yZxfLj3K4t4X67O6vhjDhCENOLkDb6ucZlW0RPdEQHGym7u0oEuzmL1Sk7nESNNGcyRdtpgAvf7et/iFiAu/ym9fYaVx6VEWkuk1FBq9eRhNWBhJ9diZV83F2t+zrzc3pdILKkhk6Utr6ND0hOhzqqU+gsA8xTKfcE+O0YqwDbCSG2nXTuXz1kGjaI9D2PjJotaiC3nTEFMK9NrKI/Jqdes
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(36756003)(66946007)(66556008)(6916009)(316002)(66476007)(86362001)(38100700002)(5660300002)(44832011)(8676002)(8936002)(2906002)(41300700001)(6512007)(6666004)(6506007)(4326008)(2616005)(26005)(1076003)(83380400001)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qtz9R6aDsUq/BLNOf7yC8hv1S9C9/xCjgW8MlTQXYoXhcWJb4puGCV7X8DM7?=
 =?us-ascii?Q?mplKmWSVNDRpvC/rtGA3pDQemJa8Wxry9ajG49rYd7IGA5lydJN5MWp9J5qu?=
 =?us-ascii?Q?ChtJ9hQfPVMHbN7mi2tA7ZyH4iMydQ/8r5J0k3oPxH2NwBeqZON1lLIM961i?=
 =?us-ascii?Q?wJUZTybCFLhPBwH1NFDtTJ5u/w78QoXYgyera1Ya/i0Zh5FL/YGTZZ4N4gjj?=
 =?us-ascii?Q?i01WgZ67ml23e/fxmzpb/v1PnEbWgYnGTNh6VsZtGNWxL64ej9+UNdBS3qH8?=
 =?us-ascii?Q?BoqzDgTi/lqQcqXfPVbbfdnpeOrulP2NHiF4o92bQLgd0fsLZ3AFrfFH+ePY?=
 =?us-ascii?Q?SPooN0dH6fNLyYFte34uryEJ2dQHq4aV7LigOD5ksgyue/svO9n+yDSyb84m?=
 =?us-ascii?Q?+YnmyNsAUeTcL56v3jIHrtOjTkVb0eGX7lOTjm9si1vnon4kMW/+f9pvGUMM?=
 =?us-ascii?Q?83rW/Mixxmon+mYgZgQi78ZnW6YWPoJaDZdgZe2tIojyVIg0evk+KXGQiYkp?=
 =?us-ascii?Q?cupwrpojIXwpWEPDuoCD240ZtllsNnDWCq7mR1UneTj2777xjfBEEQISCs46?=
 =?us-ascii?Q?jT1JYvBMdrwv5FdKQPyOtP7k2gW25pAS+YrbpByjQcBf1sl2MA8PWm9nOExM?=
 =?us-ascii?Q?JWOGJu/ulD2H+Yzlc79/t+PDToCsT74VMCRoSut5jzZstvV85/fKCVcx2emm?=
 =?us-ascii?Q?fv+kaBrMoeCFmjjIGdOA3h5B5SkUwE9hGbSt4pitVdvZ0fcuF6ltErIBF7cU?=
 =?us-ascii?Q?sbgRITnvNMf3CJwxdachgbTNGw0mVCPU5pH4iGBrT9A8aZv3xjSKo9Crbhn8?=
 =?us-ascii?Q?Xq91uztOYHVD3MsLzsGG5+lRMMQ5ZZUk4TD3Hfqy0upsRiLMC38K3p+B940Y?=
 =?us-ascii?Q?62M8utijmasUd8gm4w6/xXyNFS28SSRyjBuLvD9X27zzEgudklhWu3zby/p/?=
 =?us-ascii?Q?IPJKvAhfpwdyxDa1ooc8zl+Lk5kPtfNt0V1R/C/PXE6NnOSmR51wbkIj8N6R?=
 =?us-ascii?Q?BspV5lDF6jPJm2hMAt4JvxrN4P20DwmRLeiArF6vphnmI3r30WDAfVMsvMDp?=
 =?us-ascii?Q?++p1MMRtAw7f+IK6odZlGC3b83gA52cN1fh1sfyrU+SihYVl7B38hfXfENXH?=
 =?us-ascii?Q?EcV65631QIJnqTzm98RAAeFNrUddsV9VUyr/A6QOV0Ln7tib248fEI/AWjWn?=
 =?us-ascii?Q?9xhNM0p4Fvv3z849j4FkJVqQ3P8PMI/i3nLCm+XJf3duytX0cQiHmFDW/r6s?=
 =?us-ascii?Q?9UuBhqy6PKBOBFDDfYmrvTC+Y1IpOWE3jzUOfYKEjops6A8GEOszsvFAYp/N?=
 =?us-ascii?Q?N6sx1O6a4VptxKELr6eLu0LUwuTbGGrXJrHeU9p6cN/B1BtaZU2GcqCkWTM/?=
 =?us-ascii?Q?IrN84vhFgEGnIFi1LHd58lDm68BQ8uBCVaAPN7eq/dlBTTAsHRhY3WeDCFRd?=
 =?us-ascii?Q?ocidUMdyKDE1+PE0r1P3SqCKgp+IqcPhuLtZnn1u1ndu8vtad/utffrWxX1N?=
 =?us-ascii?Q?uw6OLOtuNpJOzJXxhi4yibszitCnx7JWKNAj5B7fJDzenLbhIiSfIaV4JL8S?=
 =?us-ascii?Q?rn7157Ck4Ct+4mg/QNY3a8t6jB9G/WNYjuNetWtYJQo73wj1mAENbHWkpMGF?=
 =?us-ascii?Q?jA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c95b0f5-6277-4c95-0b9d-08dbce5f712b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 15:49:11.9852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TTyGm5kpgdBMjpNVGWSgk07SOuqlWTh2y9OLnmQjkp+UsILE33P4L6rs1D0kDnQOh1Rr+cCiLYtPEEAjzlLv6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7423
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds watches to handle closed sockets

---
 src/shared/bass.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/bass.h |  2 ++
 2 files changed, 61 insertions(+)

diff --git a/src/shared/bass.c b/src/shared/bass.c
index 0ee3187d1..78103d463 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -655,6 +655,11 @@ static void connect_cb(GIOChannel *io, GError *gerr,
 		g_io_channel_unref(bcast_src->listen_io);
 		bcast_src->listen_io = NULL;
 
+		if (bcast_src->listen_io_id > 0) {
+			g_source_remove(bcast_src->listen_io_id);
+			bcast_src->listen_io_id  = 0;
+		}
+
 		/* Close pa sync io */
 		if (bcast_src->pa_sync_io) {
 			g_io_channel_shutdown(bcast_src->pa_sync_io,
@@ -663,6 +668,11 @@ static void connect_cb(GIOChannel *io, GError *gerr,
 			bcast_src->pa_sync_io = NULL;
 		}
 
+		if (bcast_src->pa_sync_io_id > 0) {
+			g_source_remove(bcast_src->pa_sync_io_id);
+			bcast_src->pa_sync_io_id  = 0;
+		}
+
 		for (i = 0; i < bcast_src->num_subgroups; i++)
 			bcast_src->subgroup_data[i].bis_sync =
 				BT_BASS_BIG_SYNC_FAILED_BITMASK;
@@ -703,6 +713,18 @@ static bool bass_trigger_big_sync(struct bt_bcast_src *bcast_src)
 	return false;
 }
 
+static gboolean pa_sync_io_disconnect_cb(GIOChannel *io, GIOCondition cond,
+			gpointer data)
+{
+	struct bt_bcast_src *bcast_src = data;
+
+	DBG(bcast_src->bass, "PA sync io has been disconnected");
+
+	bcast_src->pa_sync_io_id = 0;
+	bcast_src->pa_sync_io = NULL;
+
+	return FALSE;
+}
 
 static void confirm_cb(GIOChannel *io, gpointer user_data)
 {
@@ -726,6 +748,15 @@ static void confirm_cb(GIOChannel *io, gpointer user_data)
 	bcast_src->pa_sync_io = io;
 	g_io_channel_ref(bcast_src->pa_sync_io);
 
+	if (bcast_src->pa_sync_io_id > 0) {
+		g_source_remove(bcast_src->pa_sync_io_id);
+		bcast_src->pa_sync_io_id  = 0;
+	}
+
+	bcast_src->pa_sync_io_id = g_io_add_watch(io, G_IO_ERR | G_IO_HUP |
+				G_IO_NVAL, (GIOFunc) pa_sync_io_disconnect_cb,
+				bcast_src);
+
 	len = sizeof(qos);
 	memset(&qos, 0, len);
 
@@ -844,6 +875,19 @@ static bool bass_validate_add_src_params(uint8_t *value, size_t len)
 	return true;
 }
 
+static gboolean listen_io_disconnect_cb(GIOChannel *io, GIOCondition cond,
+			gpointer data)
+{
+	struct bt_bcast_src *bcast_src = data;
+
+	DBG(bcast_src->bass, "Listen io has been disconnected");
+
+	bcast_src->listen_io_id = 0;
+	bcast_src->listen_io = NULL;
+
+	return FALSE;
+}
+
 static void bass_handle_add_src_op(struct bt_bass *bass,
 					struct gatt_db_attribute *attrib,
 					uint8_t opcode,
@@ -1023,6 +1067,11 @@ static void bass_handle_add_src_op(struct bt_bass *bass,
 		bcast_src->listen_io = io;
 		g_io_channel_ref(bcast_src->listen_io);
 
+		bcast_src->listen_io_id = g_io_add_watch(io, G_IO_ERR |
+					G_IO_HUP | G_IO_NVAL,
+					(GIOFunc)listen_io_disconnect_cb,
+					bcast_src);
+
 		if (num_bis > 0 && !bcast_src->bises)
 			bcast_src->bises = queue_new();
 	} else {
@@ -1318,11 +1367,21 @@ static void bass_bcast_src_free(void *data)
 		g_io_channel_unref(bcast_src->listen_io);
 	}
 
+	if (bcast_src->listen_io_id > 0) {
+		g_source_remove(bcast_src->listen_io_id);
+		bcast_src->listen_io_id  = 0;
+	}
+
 	if (bcast_src->pa_sync_io) {
 		g_io_channel_shutdown(bcast_src->pa_sync_io, TRUE, NULL);
 		g_io_channel_unref(bcast_src->pa_sync_io);
 	}
 
+	if (bcast_src->pa_sync_io_id > 0) {
+		g_source_remove(bcast_src->pa_sync_io_id);
+		bcast_src->pa_sync_io_id  = 0;
+	}
+
 	queue_destroy(bcast_src->bises, bass_bis_unref);
 
 	free(bcast_src);
diff --git a/src/shared/bass.h b/src/shared/bass.h
index c4b5b76ba..bd3fe900b 100644
--- a/src/shared/bass.h
+++ b/src/shared/bass.h
@@ -57,7 +57,9 @@ struct bt_bcast_src {
 	uint8_t num_subgroups;
 	struct bt_bass_subgroup_data *subgroup_data;
 	GIOChannel *listen_io;
+	guint listen_io_id;
 	GIOChannel *pa_sync_io;
+	guint pa_sync_io_id;
 	struct queue *bises;
 };
 
-- 
2.39.2

