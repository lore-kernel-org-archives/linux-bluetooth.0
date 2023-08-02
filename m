Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A93C00528
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Aug 2023 13:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbjHBNZs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Aug 2023 09:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjHBNZq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Aug 2023 09:25:46 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99579271C
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Aug 2023 06:25:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGQmBvLGLBPvLKcCopWK+7ePoPWH3Hx/x67nFn1eEz22pOqiT5+Mo2RY92GTLCfNNGJpLJon+/UWIbqXJnF8WfgWuKPLlQG5JkyTL7Yb5TPRi8N4sTpsHGQi9PxyQ46OAN0h9iO4r+78GMXgEMjDbzpdhpr/x7p/qi0QUU9Bdri5xj1kLgeyIqjMkAsL6rPCHnuJhHyfHXLWHpcw9lg4qs04lj/1YMbOm/8aDEXrHTbv1++oZUN6yQnK23X0JVRU0idTc5wWmJoHZee90DuFuyiHNLxl5uIPr+CkrntRC2fN5OiHmjoTa1ei0oRAAie7v+hPbPOLpzM5VXW6dkqCtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUb/B7vqA04fju93O5LRm4gQoV704vH6jrWak2+g+ns=;
 b=IAzdPAMPBvZtakJch8xzXpp/JovFfF/w+uglTthq5IqM2itV1Aj9/y4QoBBg6GHf5tK0af3T6DJLUcFxHBx5azLUj1agYhbdGm4XKB85i0suTPVwauL2P+wEpEMChYwSlqhxeVLRQB5gxJ9alHFCRWuAJa0En6mTaBGMvCdkhr0ZPZBu8YJoxV+L17JsyXhBEcYrPDiR8l27nOEXom94QHkfIiUp122Ml7/ZreDxV/QzDMKIP0vmOoLLUZTs5mobz/Q/8f3xjK5TzLHvwFywtjvc2fm88knIIxeE7hcVB5IGc4Uvx1pkW8nO8YvZvlL2YcBDOvdJZL6MADEndkHPtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUb/B7vqA04fju93O5LRm4gQoV704vH6jrWak2+g+ns=;
 b=hImo/ESRgnvxyvsiaQIqY+87oQRZb0KBhSZkhPOdv6RJ/xxt4zRe9io04OJBVr2thplpYGjqs7j8tF61rH2pbVV6N08M8lhzO8Rj47nkIrc2y8CSghQl/LHH1F7lxJ4Q5LgVc+5z6C7L0waknyjOuqDrfxS+KV0AiPmroPaB2rs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by DU2PR04MB8613.eurprd04.prod.outlook.com (2603:10a6:10:2d8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 13:25:27 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 13:25:27 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v4 5/6] media: Add broadcast sink media endpoint
Date:   Wed,  2 Aug 2023 16:23:54 +0300
Message-Id: <20230802132355.4953-6-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230802132355.4953-1-claudia.rosu@nxp.com>
References: <20230802132355.4953-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0023.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::19) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|DU2PR04MB8613:EE_
X-MS-Office365-Filtering-Correlation-Id: 69a9ab1e-8f08-493b-6548-08db935bef73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JaF+aZagjwSfAja6FIjrEzEJU5lPqFu9dlwY/wjSIFhnUoOJ1zQ6CNLMdv5hRFEqXun0TL3vdJhuaqwRLBt7ks5Gw33ctMqG+Wlh/6fcOHo1DV4t4YoKIDpNkO80gfkbalmbjvQH5txj01oAyCJyE9fF1TCy4C+71tgd2wLyAwLOTPkFW4FglNfqvVSg+rKErjXQYzDsIBOoNG415q87jyz+p12Uu77lXjnWZ/OC8uqwpGSFspJPq9eUxspWvYsfFz/YRB4V5dsjzpmo4uxlWrJBhcBpRz+IG2sAWYMTaQwXQP4p14dg9MrMTyEi+qFCYo7Wvwkq3ES2/Kfiwk/qmFMuBrXMh5FkmmKMCRqPHEWnKwmuLi0/+T9DiMpTHKNArMQBOgBs2mJ0oWJAIRfQGaSlxFQgUz1PX9rm4bGGx4A4zWZWxyahDfGGO5kqr5kdoNVBJL6r8DfRERkBzJQ/5HTFXeaq4ladJTQCMtwED9MzLA7dzsPBB48Uo69G8DunuqcV8Z+JgVP83wSgCtSBCdg8YxFzIcems04QIoWT9k7oxYZn2r5xBx+brcUoEgMQlrh90h8Ti0LQQhy4UZiWxpeZaoUtkswmxpM571kUGvzJ0rWsfnmtuoJY3bXqDmCp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199021)(86362001)(36756003)(66556008)(52116002)(478600001)(38350700002)(38100700002)(83380400001)(186003)(2616005)(1076003)(6506007)(26005)(8676002)(8936002)(41300700001)(6666004)(6512007)(6486002)(316002)(5660300002)(6916009)(4326008)(66946007)(2906002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QPqgY+V2GBCds9bMuyG+G8DqTyccARe54oQxuAW3tm4WVGNgETxcZ3P3qmvH?=
 =?us-ascii?Q?nZCX82n8w8qlE2sIuaD1ioi+Y0Y042LEMrBlYNfMDNmqu0nFf5rWYdDtze7r?=
 =?us-ascii?Q?TdkvPYml5yEDli9cpA7VqwPy2uJO/DSActykSCutzSTn0Qw1/YC8JzHjKC3q?=
 =?us-ascii?Q?fybbg2xXkj4v6atl2IhI3B9YjdiZLQ0slAswYx5/UP2ktKsTpqbW3OPnDblI?=
 =?us-ascii?Q?HNWgkTrkf/HAVH8MTFQjAnBkVAhnVQ6dT2q2wE4Cq5su52728TEhdnKAa9tU?=
 =?us-ascii?Q?HHS+uvMkpOXfF22YkDk8GSKfaKL4e64Xm0ArSk3pPqYwCPi6gVaEehEe5ToE?=
 =?us-ascii?Q?rpS/7bi18ode92zqiJSh4KmWwYN31Zu/EYxStfvK9+G/hLxn0lfGV/RLFlFD?=
 =?us-ascii?Q?jHb0PE6uT8iJAY94f93qmG8KAvST6ut/D8QxL5cIGDmSCUpGd5e2I9sjg758?=
 =?us-ascii?Q?60osLr0PAD23dIhtmAs3wyuNtMWDxGtw51yZcayNnbyYDeIVKhnc7t22KcbM?=
 =?us-ascii?Q?LqAwAvK33+8sxeNm4pw4VWCQ5YBeJMlzu6E1NINgZ4MkIF3kyYCousqWRGuy?=
 =?us-ascii?Q?6F/sqzdArOAHxUranDynrIacUar7uiCYHbUgPofuIV1tqBeRilZ2B9F9TV4e?=
 =?us-ascii?Q?6iVCpFNo+Y/Cv53/CHTq2xbjhDt41OHkfLq/T27lp66UZrSX0vPKzqI2tpUP?=
 =?us-ascii?Q?amDCZdce3WfAb2xcwZxoU/S1nV9L8tBoPB/NJT6eYS+AAaNNS8rfHdDIywnA?=
 =?us-ascii?Q?n5bhzBXY3q6+Gm/BywWpLeeAIgJ0aBG4SkOm6xlkYrMlFD/WGjW0WN+hKpOy?=
 =?us-ascii?Q?mMgER4jkHDGedIT+5E8iEnSrARFghxPZSr/Oqs0u/ZRQAunNyWvrOFZOy4II?=
 =?us-ascii?Q?8nscmQZFC6LtxXA/BIirvYty+eq0Wl6+I20QgLCv4AhMWdWMz9rHh5QOKTaU?=
 =?us-ascii?Q?LYNA57bpvcHc3PP2m9lJiFhDuqCN8xhFagV75a5IYV1eGZVFCnl5Kd0vL+pp?=
 =?us-ascii?Q?rQdrUTi2YNG07bA31X2i34qWEBJVMVlzr12yz/VowyNFWNFtIvQU0PonFOJQ?=
 =?us-ascii?Q?wDB+f83T/NvlxdarP8KekD7oMHZghCuAsE5NgIki19kecMHKcr0NMrME53yr?=
 =?us-ascii?Q?zi5hGL+xb2X0dGZlqaF+9faB2kZnISC2FenASCywgByROf2o3QyODzZHvwsB?=
 =?us-ascii?Q?hd0ctmbk8Xz1NqSwDHEtxhCepLawNiW5yWAbZHYUKeqrtU47OAg2rfXfulMe?=
 =?us-ascii?Q?dYOtbwy8qh1kpjPK+rn3hKYhJiRB9JwBBJ+bChBW5UKSaYkqjDI1E/QEa4WE?=
 =?us-ascii?Q?GtQuhorECP/Duqd0LoTvgd1JC3XJ8e+1ufErzVg71u/6FyxjIh9BnK/y2BtV?=
 =?us-ascii?Q?cialz4AxyeZvLYCqc5wAWl5Xn7/vqTD4Wpj6bDEwmFTotpgk5SrvHWzMSm/E?=
 =?us-ascii?Q?1UnZylw87xpl9nr0zZDDVtd+RWaMjO4T29j6hBGc3zN5KdCN42YA8/GSztzd?=
 =?us-ascii?Q?qC/IjCc17acum14X/GTUa0DsTFIEW5fXz3VfvPuNrmSt++XmiUoPB+3SYkKq?=
 =?us-ascii?Q?LkribfN9Gd00JwZftwRC83DQiB+Q62zIctfBjXfF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a9ab1e-8f08-493b-6548-08db935bef73
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 13:25:27.3587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tcyiSfbsGpSqc6U/t8W9D7YUxIGsjfuehn4vru1xHwAdHBz+d/rBr0CT+dZEN87ALw118eolpE/ciNGw5agyww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8613
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds the possibility to register a broadcast
media endpoint if the controller has support for ISO Sync Receiver.

---
 profiles/audio/media.c | 81 ++++++++++++++++++++++++++++++++++--------
 profiles/audio/media.h |  3 +-
 2 files changed, 68 insertions(+), 16 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 15c64c8d6..edf106a12 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -105,6 +105,7 @@ struct media_endpoint {
 	GSList			*requests;
 	struct media_adapter	*adapter;
 	GSList			*transports;
+	bool			broadcast;
 };
 
 struct media_player {
@@ -1059,6 +1060,9 @@ static struct media_transport *pac_bcast_config(struct bt_bap_stream *stream,
 {
 	struct bt_bap *bap = bt_bap_stream_get_session(stream);
 	struct btd_adapter *adapter = bt_bap_get_user_data(bap);
+	struct btd_device *device =
+		btd_adapter_find_device_by_path(bt_bap_get_user_data(bap),
+				 bt_bap_stream_get_remote_name(stream));
 	const char *path;
 
 	if (!adapter) {
@@ -1066,9 +1070,17 @@ static struct media_transport *pac_bcast_config(struct bt_bap_stream *stream,
 		return NULL;
 	}
 
+	if (!device) {
+		DBG("no device found");
+	} else {
+		char name[30];
+
+		device_get_name(device, name, 30);
+		DBG("device found name %s", name);
+	}
 	path = bt_bap_stream_get_user_data(stream);
 
-	return media_transport_create(NULL, path, cfg->iov_base, cfg->iov_len,
+	return media_transport_create(device, path, cfg->iov_base, cfg->iov_len,
 					endpoint, stream);
 }
 
@@ -1238,6 +1250,12 @@ static bool endpoint_init_broadcast_source(struct media_endpoint *endpoint,
 	return endpoint_init_pac(endpoint, BT_BAP_BCAST_SOURCE, err);
 }
 
+static bool endpoint_init_broadcast_sink(struct media_endpoint *endpoint,
+						int *err)
+{
+	return endpoint_init_pac(endpoint, BT_BAP_BCAST_SINK, err);
+}
+
 static bool endpoint_properties_exists(const char *uuid,
 						struct btd_device *dev,
 						void *user_data)
@@ -1351,6 +1369,17 @@ static bool experimental_broadcaster_ep_supported(struct btd_adapter *adapter)
 	return g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL;
 }
 
+static bool experimental_bcast_sink_ep_supported(struct btd_adapter *adapter)
+{
+	if (!btd_adapter_has_exp_feature(adapter, EXP_FEAT_ISO_SOCKET))
+		return false;
+
+	if (!btd_adapter_has_settings(adapter, MGMT_SETTING_ISO_SYNC_RECEIVER))
+		return false;
+
+	return g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL;
+}
+
 static struct media_endpoint_init {
 	const char *uuid;
 	bool (*func)(struct media_endpoint *endpoint, int *err);
@@ -1366,6 +1395,8 @@ static struct media_endpoint_init {
 				experimental_endpoint_supported },
 	{ BCAA_SERVICE_UUID, endpoint_init_broadcast_source,
 			experimental_broadcaster_ep_supported },
+	{ BAA_SERVICE_UUID, endpoint_init_broadcast_sink,
+			experimental_bcast_sink_ep_supported },
 };
 
 static struct media_endpoint *
@@ -1382,6 +1413,7 @@ media_endpoint_create(struct media_adapter *adapter,
 						int size,
 						uint8_t *metadata,
 						int metadata_size,
+						bool broadcast,
 						int *err)
 {
 	struct media_endpoint *endpoint;
@@ -1397,6 +1429,7 @@ media_endpoint_create(struct media_adapter *adapter,
 	endpoint->cid = cid;
 	endpoint->vid = vid;
 	endpoint->delay_reporting = delay_reporting;
+	endpoint->broadcast = broadcast;
 
 	if (qos)
 		endpoint->qos = *qos;
@@ -1458,11 +1491,11 @@ struct vendor {
 } __packed;
 
 static int parse_properties(DBusMessageIter *props, const char **uuid,
-				gboolean *delay_reporting, uint8_t *codec,
-				uint16_t *cid, uint16_t *vid,
-				struct bt_bap_pac_qos *qos,
-				uint8_t **capabilities, int *size,
-				uint8_t **metadata, int *metadata_size)
+			gboolean *delay_reporting, uint8_t *codec,
+			uint16_t *cid, uint16_t *vid,
+			struct bt_bap_pac_qos *qos,
+			uint8_t **capabilities, int *size,
+			uint8_t **metadata, int *metadata_size, bool *broadcast)
 {
 	gboolean has_uuid = FALSE;
 	gboolean has_codec = FALSE;
@@ -1546,6 +1579,10 @@ static int parse_properties(DBusMessageIter *props, const char **uuid,
 			if (var != DBUS_TYPE_UINT16)
 				return -EINVAL;
 			dbus_message_iter_get_basic(&value, &qos->ppd_max);
+		} else if (strcasecmp(key, "Broadcast") == 0) {
+			if (var != DBUS_TYPE_BOOLEAN)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, broadcast);
 		}
 
 		dbus_message_iter_next(props);
@@ -1569,6 +1606,7 @@ static DBusMessage *register_endpoint(DBusConnection *conn, DBusMessage *msg,
 	uint8_t *metadata = NULL;
 	int size = 0;
 	int metadata_size = 0;
+	bool broadcast = false;
 	int err;
 
 	sender = dbus_message_get_sender(msg);
@@ -1587,13 +1625,13 @@ static DBusMessage *register_endpoint(DBusConnection *conn, DBusMessage *msg,
 
 	if (parse_properties(&props, &uuid, &delay_reporting, &codec, &cid,
 			&vid, &qos, &capabilities, &size, &metadata,
-			&metadata_size) < 0)
+			&metadata_size, &broadcast) < 0)
 		return btd_error_invalid_args(msg);
 
 	if (media_endpoint_create(adapter, sender, path, uuid, delay_reporting,
-					codec, cid, vid, &qos, capabilities,
-					size, metadata, metadata_size,
-					&err) == NULL) {
+				codec, cid, vid, &qos, capabilities,
+				size, metadata, metadata_size, broadcast,
+				&err) == NULL) {
 		if (err == -EPROTONOSUPPORT)
 			return btd_error_not_supported(msg);
 		else
@@ -2627,6 +2665,7 @@ static void app_register_endpoint(void *data, void *user_data)
 	int metadata_size = 0;
 	DBusMessageIter iter, array;
 	struct media_endpoint *endpoint;
+	bool broadcast = false;
 
 	if (app->err)
 		return;
@@ -2736,12 +2775,18 @@ static void app_register_endpoint(void *data, void *user_data)
 		dbus_message_iter_get_basic(&iter, &qos.ppd_min);
 	}
 
+	if (g_dbus_proxy_get_property(proxy, "Broadcast", &iter)) {
+		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_BOOLEAN)
+			goto fail;
+		dbus_message_iter_get_basic(&iter, &broadcast);
+	}
+
 	endpoint = media_endpoint_create(app->adapter, app->sender, path, uuid,
-						delay_reporting, codec,
-						vendor.cid, vendor.vid, &qos,
-						capabilities, size,
-						metadata, metadata_size,
-						&app->err);
+					delay_reporting, codec,
+					vendor.cid, vendor.vid, &qos,
+					capabilities, size,
+					metadata, metadata_size, broadcast,
+					&app->err);
 	if (!endpoint) {
 		error("Unable to register endpoint %s:%s: %s", app->sender,
 						path, strerror(-app->err));
@@ -3245,3 +3290,9 @@ struct btd_adapter *media_endpoint_get_btd_adapter(
 {
 	return endpoint->adapter->btd_adapter;
 }
+
+bool media_endpoint_is_broadcast(
+	struct media_endpoint *endpoint)
+{
+	return endpoint->broadcast;
+}
diff --git a/profiles/audio/media.h b/profiles/audio/media.h
index 1de84a8ff..0eeb5746a 100644
--- a/profiles/audio/media.h
+++ b/profiles/audio/media.h
@@ -22,5 +22,6 @@ const char *media_endpoint_get_uuid(struct media_endpoint *endpoint);
 uint8_t media_endpoint_get_codec(struct media_endpoint *endpoint);
 struct btd_adapter *media_endpoint_get_btd_adapter(
 					struct media_endpoint *endpoint);
-
+bool media_endpoint_is_broadcast(
+	struct media_endpoint *endpoint);
 int8_t media_player_get_device_volume(struct btd_device *device);
-- 
2.34.1

