Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012013.outbound.protection.outlook.com [52.101.66.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EE628DB3
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jul 2024 08:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720515567; cv=fail; b=o6jAQqC+Mhq5+apMI46JPdTrojgxyfJm5XmmexcisfgslcoOgaHAu8Xfhp+10o6ELzi/sYv/IEl5+1A3bP0IMooK4VRKaSKYKIYW6DqOlL9zJX1BsewR2bd9DXX/maylbOUkyAgz5MGobMnhLO2O1kTWJG+ma+aCOBZgYuL+9Ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720515567; c=relaxed/simple;
	bh=sEmyNoFzCl3yUsZSWuaAwZh1a64TL1L8uRZLmcq9oQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XDq0ZQorzCPJuoJqaS/vNZD+MjYTrRisQk9gSLQ1oS25ALTTpBF7HkNF/LoTgNlHSZQVKlabXETazKtBGOjmK7jBbpiwte1oiMkpXqJJWPR5rt3jkZifnWjNX8Pa7rHw6rLyyNzwHJB7fH7IQSna92nHpx0jMVeFWCKzmqc4qKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Lzio2U+P; arc=fail smtp.client-ip=52.101.66.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Lzio2U+P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9gaY/TuXoTjjYfaWULNW4njDyZoeNtOWTZ/vta3yHY0VdvCi3x0y+7pxDnzpJI2Z8Nt9LJnMWju3IyKKCCKoREPGscEgP1wjHhnmTbreK2sxC38lWIOHNYFBzGo0md5T1tGRh7MM0wZyi676CMq4lQdbRPJEPiNf62k4fnmjt3io1Oiw60aPGJIgNykGa67t4XKDJj+yN2ieuT7zKUkGyvgoeaZr8OE/6Ip6egKuxTlSWRFpVKaT9B6bBQtFlSywjb3xZfwPMcs5ugvbl8KpEHaC2m44smOQMhMiu9GWKQLhZM13HrdfSzPe8pmBgoVOWlfv77G8lRIAi27+wVzcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXDGXA+zC49twjqOmQhfTj7hD3ADXKSiHzGkc9mbnLM=;
 b=LBHB+JtS60d1TmsXjUVgEriJYE4xBBYUyG8rvwoKc/FriDQOX0gZde7lIu/hQj6K8K7yqfg6UdfdyL6/dmUnAU2oxbGn+m4tGq0Uy9FTGePF5vEkgZGr0GRw0d7y4emjkvqxCCHi+7iofW8RFhG6iE2ihmzR9awJVs3a3rwwLsLcTI5jSI6qGDJVO6c1GjpKmhp7rU2BehgtQZMHV7BuGO8StH1/iIWIK3wat5D8gux/384T2P4EnezuzeVxjt/Mf0tcvGI9nXS8vXUUAzbVkMeoU2vwiB0uCMhLrN0u3unfFaOkdECTYfV5JPiVJsJYV9gRmLmQOylwha5XPAT8bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXDGXA+zC49twjqOmQhfTj7hD3ADXKSiHzGkc9mbnLM=;
 b=Lzio2U+PYwSrYaVcCSw5TNRgt6FIZveHopHmlnWEKJnxca6ZHhWwyGDSxwnUcbJF2LOqkaIrgwH0b21i4ouO3PsjLwqzqChR7NdJVPjT760xCF0GjJBsDZHGAr+Zb35jTVQZ/NEdSprlT+T+R1ndxtxZamBjveuhTBfiT+eglsU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by AS4PR04MB9505.eurprd04.prod.outlook.com (2603:10a6:20b:4e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 08:59:22 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 08:59:22 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 1/1] bap: Wait for BIG Info report event before creating streams
Date: Tue,  9 Jul 2024 11:59:03 +0300
Message-Id: <20240709085903.125001-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240709085903.125001-1-vlad.pruteanu@nxp.com>
References: <20240709085903.125001-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0054.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::17) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|AS4PR04MB9505:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f5c2013-f3b5-4470-150e-08dc9ff56c9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mGDxr/+xI9x1J+M7HWI57TKUtG4cgN8f/xUQNGNtg0Wfx4mp7JBxFSdqgyHK?=
 =?us-ascii?Q?J6XEhFdp20WDj1JGaN+u75kJj0ebQ4H7bvUvfKZyKGDTf/yyQfVABiJfYn9j?=
 =?us-ascii?Q?P/oMe9Z/nVZ5JCIEfgHKrrYKBhOw2SGT48Y2kMWJ4ZAIGNHZKNEBATV6I6VP?=
 =?us-ascii?Q?AMBqYAcVRpO7lZQsrMOFYaWcUzc1E1czajr8sCGHs1Aj8inJOje9cRDZ+Kc1?=
 =?us-ascii?Q?wXvHkSj//Z6dA3vaDWlfr2Olqiu5LHmuCU50kZtnDQimACT5Vy50FoEPR7J0?=
 =?us-ascii?Q?nQtF8skQQm+GtzRUeK5Yfdpd65D1/QiTBj+o+NcjvfC1WufdYWMUWVRFxzAi?=
 =?us-ascii?Q?urbZ4eEccikltXIXnbHE2u/tux2YvBD04zSeq+6dW+HMoQisCOj/WNYuMP6a?=
 =?us-ascii?Q?cOdTQhuQ5S9erD5NYL3oULT1FoJJPwRu7Q5A9ODnKY/zQLvKc02OnczDfeeT?=
 =?us-ascii?Q?vcK8pjGqtmlh0adMVh2KkwREW0IyOBURYwGmojwUO7wOg3k1AQsCisRzC98D?=
 =?us-ascii?Q?yhYFdjyLGcD6W+oqEjdaZvCGkJNqT0yurrPHEZRphNkJRbfha4FlYiyX6M1Q?=
 =?us-ascii?Q?r085XmvionGeWl9wTkrDCHQBRRc0nohc6K2UA4BqAn4uNq0H74PKLaR3BG1X?=
 =?us-ascii?Q?DXOXfhjtE/mdDjKnhdfjOEcIy5vwZUeUvM0qLt+Ys5ZsYhJMkZLO6q/I6tJH?=
 =?us-ascii?Q?1FiHk3t9tCERQQbtr/IEGmEtivisoHW/wpYuhYC5fePouBloFo2sl7T+YATm?=
 =?us-ascii?Q?un7/68m9IVAHvEz6C4xzb1fVpXC5MfPSmL3Ak3q79xOOT1OZcoV7H5Fr9/V8?=
 =?us-ascii?Q?u+d5M5wZQrBKA+/kkmCMwp9weSmGk1IGPe7fj7oi2xw1gQOMJYZgCCL93FmC?=
 =?us-ascii?Q?g8vyPLw23Tl19s19Ulo1gzcQHjVk8ciUOI4DkV0cSiMrBZ+KC0QFOo1Fcuml?=
 =?us-ascii?Q?32Cy0ra1PpFQzyUpMDej2gdvZ4QyZehSn7ts5bqx1Yglqj5Qhlqhs2UpNJ33?=
 =?us-ascii?Q?AH73XAiWMH2YZB9yo+IlglYlCnr7nTuVSjgXyJAnHib5zj4PD2TA28X3taAE?=
 =?us-ascii?Q?bk8kzn3eI74uAepXR/OjOa2BdbgJbjSDHNy8hhaqJ2QEcDVlgzZlwJYnLT/m?=
 =?us-ascii?Q?Xsg8O5jVJyZjnBvOL0yHWBP0VkOK/dKfLqSb/LZfSGOCOVMu1Tu1/RYq746I?=
 =?us-ascii?Q?ztYCDdse5CdSSdlQTGcd29o2tOMOiDiozs2cfYbO2ZYdyvHUZInpKOsXx8So?=
 =?us-ascii?Q?JOjcMrgC5ZVpxmvOL+K86RQNHwIcRLNRKUPpGD7RXTuInthMTAMVpEke/w6B?=
 =?us-ascii?Q?TEjj6e33k+kPMSWf25PvYb3T//uP9Oc/k7F/Q3DnQ5l95TRb2P0rzlJv5/Wr?=
 =?us-ascii?Q?VFVLiQe3CauX2PU1sOKR557ygHxngraBVt0XGg4jvESD9852Uw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tu4dkgZ1oi8yfKcwl1rVwcCXJBUU+mHGBRNOJfa8cDjAJVW352YlMeqvizOn?=
 =?us-ascii?Q?HH1MwwazscftYKGNw/Upc9Z4fBKx6pDAoEUV3KWL3TFIvzLq7a4YWFZ/t32K?=
 =?us-ascii?Q?PFK9HkA8vHkmAS6VCHETC4OWARIDLU+rzBraTzZmuWM/1wk4n5aGkelDQitD?=
 =?us-ascii?Q?ah4kvAZuMs+SRPJ9X6HlD2hgiSLlYTrrAilk6nDUoIw1OWSOYXzOULAB9l3K?=
 =?us-ascii?Q?05hZmB3TNYgZEmcfaFlLpRvaqMgiFyy/69jsmo20WyaRh79MaHC2IK1ptCdb?=
 =?us-ascii?Q?fzDKNERAvwGpwx6aKEgmO1PC6MG8eNnbUBF1jtAr8ONPxvaNaYn6N4GONNRL?=
 =?us-ascii?Q?aZqKnx3fjTIqV//IKvFRuiUj5W95PmEyFKQgSDDF2T4GgqAq5m62PCjrlx/z?=
 =?us-ascii?Q?RXetLGVx95T8kV3fryP55VYipxHnjnNM/LoBoGbLrqC7IvDmmvvbtWuhyXH4?=
 =?us-ascii?Q?nlYAf0FZA+3+MvEAn1CKHLTDtB+Cgku54+7rLy1YBiogVYFjfhCqp08yxjdo?=
 =?us-ascii?Q?ZYoBzhmUOCPtzi5jy1whm/BV3Gpk9/fpKCubnUamV/3+T1PcDqrJxyJ8cQEN?=
 =?us-ascii?Q?ylIqe54vGLt7CbK6/8RAMfTWv7vcFjvDsboJl5/EWAqA1tfD7ktICXe78slT?=
 =?us-ascii?Q?0MaCJ4vi6IXyADoWuTK8iChALtdM/FwI1yBBUvtqE3mEzOB8A4TLtYfReYAZ?=
 =?us-ascii?Q?jhYCPzqmA4tb2EwIwHMpX68RAItKAWUtdVOQPIKQ21et6ZIXnrC9PhuQongH?=
 =?us-ascii?Q?hiXoB0zpcHIL6gkzbYVuqb3Ki26mMCSkKEk6qhKEkbU3MNnKbkId7H/wqUD8?=
 =?us-ascii?Q?Cy9o7S7KlOVhxkiwM/DT5FHqVrlcQ8NG7c6Vgdco1+VqnUX+8X9gGSFBqWWN?=
 =?us-ascii?Q?uXGXzAEG56u+Try7gU3qg8oytqXHSSNrJ93T1/+ZNohYmh8zzPg5Zl6NZls2?=
 =?us-ascii?Q?OWPclcvhwJ+kYs97yoEmj/W6/W+EoDt8G7uVvGB29ud+HQQ9Xahsg/lm1VsS?=
 =?us-ascii?Q?40iEu9xJ0GaI95vsdQ5eLvDioodKIADByZ2RSYkkvctth7lY2FcOeti4VOOp?=
 =?us-ascii?Q?+YLYYDZYVqmMMIVnMGjF1ameN8Toi/dlJTnYKxTv8C7cme41uvRVDeFHDc22?=
 =?us-ascii?Q?OUUnIveuwaFs+8kvKu0IfCIZ1FCGHQqQyE03pND3RH8Sb/VYsxNtDSZZUulu?=
 =?us-ascii?Q?9YH0ERXC7uQ9a9ZPxXkUA35B+aUqxNhkZEyUyut5RQDW2Nmi8OI7V3bSY+k8?=
 =?us-ascii?Q?M9vibi7ZF56wT3laFjqfrLaAJ0pfrstvIhnlbDZbIeOMybuIi5hPLBAhOt8S?=
 =?us-ascii?Q?Z2kFIvobEXKLzWCbED+Yj74r04ETKtMwIEwgm49FG2pY5Vtn9gFynpWmtpbs?=
 =?us-ascii?Q?+KULxZWlxKEF/WUFxvvzVkDi+8eQvgy0VEcrUsf75YwEQ4gU7azX69iqYSVk?=
 =?us-ascii?Q?UxIVgKmBuP6g0RXcrg2TznqEXM4g9lsGpDYPiL45qVXktkMR+D/eKJftcoAB?=
 =?us-ascii?Q?Ryf6Z9qCqTsD1PWQlFHMg5QXafPyUkJc777Zwn6KtUMvMZkSo5Ip9pnk0KB/?=
 =?us-ascii?Q?FIEBMVV+g1/zbmJW1qhabTKfppkGGDDKwJ1wnUi/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f5c2013-f3b5-4470-150e-08dc9ff56c9c
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 08:59:21.9427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x42uf/Q1DBlXuKCU27Ab+jiq0ri2a9pq/kxlc25vLa1jt7w7CvoW9Ch1RhUGidbUiXXEoMItrCEcs59lcXAHcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9505

This makes it so that stream for each BIS is created after BIG
Info report is received. This ensures that when the stream is
created the encryption field is correctly set.
---
 profiles/audio/bap.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index e82a25382..afa938091 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -134,6 +134,7 @@ struct bap_bcast_pa_req {
 		struct btd_service *service;
 		struct bap_setup *setup;
 	} data;
+	unsigned int io_id;	/* io_id for BIG Info watch */
 };
 
 static struct queue *sessions;
@@ -1220,7 +1221,8 @@ fail:
 	return ret;
 }
 
-static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
+static gboolean big_info_report_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
 {
 	GError *err = NULL;
 	struct bap_bcast_pa_req *req = user_data;
@@ -1228,7 +1230,7 @@ static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
 	struct bt_iso_base base;
 	struct bt_iso_qos qos;
 
-	DBG("PA Sync done");
+	DBG("BIG Info received");
 
 	bt_io_get(io, &err,
 			BT_IO_OPT_BASE, &base,
@@ -1238,7 +1240,8 @@ static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
 		error("%s", err->message);
 		g_error_free(err);
 		g_io_channel_shutdown(io, TRUE, NULL);
-		return;
+		req->io_id = 0;
+		return FALSE;
 	}
 
 	/* Close the io and remove the queue request for another PA Sync */
@@ -1255,7 +1258,21 @@ static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
 	service_set_connecting(req->data.service);
 
 	queue_remove(data->adapter->bcast_pa_requests, req);
+	req->io_id = 0;
 	free(req);
+
+	return FALSE;
+}
+
+static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
+{
+	struct bap_bcast_pa_req *req = user_data;
+	/* PA Sync was established, wait for BIG Info report so that the
+	 * encryption flag is also available.
+	 */
+	DBG("PA Sync done");
+	req->io_id = g_io_add_watch(io, G_IO_OUT, big_info_report_cb,
+								user_data);
 }
 
 static bool match_data_bap_data(const void *data, const void *match_data)
@@ -3177,6 +3194,10 @@ static void bap_bcast_remove(struct btd_service *service)
 	 */
 	req = queue_remove_if(data->adapter->bcast_pa_requests,
 						match_service, service);
+	if (req->io_id) {
+		g_source_remove(req->io_id);
+		req->io_id = 0;
+	}
 	free(req);
 
 	bap_data_remove(data);
-- 
2.40.1

