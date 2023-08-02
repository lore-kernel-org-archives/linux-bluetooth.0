Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4999C04A94
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Aug 2023 08:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbjHBImG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Aug 2023 04:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbjHBImE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Aug 2023 04:42:04 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A21194
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Aug 2023 01:42:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VztLM2f4XI50u8RubpAnUInF2gokYNR/8023zkoT04HGM7xJk1fpOWRVgCgieIDTcTN2vS2tC5McnRVd5rVuXjRtd0HhhGCsSkc6qB1fKgP/i1uNECCOPb6TOcHS4BBakvANcIihDSw5CUgoY0xCh14zJHBsk1kfrv9odLlPUGuxTkUhPNPm47IvEaG6QLLmiQiYj+YVkyhpdLiSUrGKSxM+O0Nj/+u0fL692HVdHP25cXW6zYXRMJh8VTxH89Jt1nPPM0lPLDd6+3RzQb0VID2Yg8QI2SOoJ7dvpWAeQIkPHhN+isN7b7LVnG2ITegdPYvsQvitlTAdrR9/msKFQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUb/B7vqA04fju93O5LRm4gQoV704vH6jrWak2+g+ns=;
 b=aragRxi/Ncd7QsoMhXT4IwFD+zZxUfO3Aa6WwimhVlnEwKXvSsSnU+szOXTE45SNu0BQfUHuQefBLmnSt6LqdNIBt2UJ/eZVsrd8xm+cDnPdhORqhDlOlvbKoj9QCkP1byaPcIlioD8zL8ElQq2XkfXegpPVe290dQVGxsgqia8NgxQiXgb1f+7wTHff6aQOMB7dGv0gefWpHRUMfrQ+RJF/FiFs/FifimHEvjPuHcVSLKEx4NXG7xT109XdFriC4VJ65rLQ9mGmwYoreUiJvOe42NBjaHV7VF75MjTuR193CNzvN6S+76+b360EzWffFPqYQhZ/Xcjmj1O6e0RLFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUb/B7vqA04fju93O5LRm4gQoV704vH6jrWak2+g+ns=;
 b=nKHd3xPmfaefIXj1gs8zaHStmhysEK7GdaXUfD1Rpznu37HJKEk7yY2alOqEHNw6F/HeMfEY7vKDMgHMUJgyxPNEFRiNec6Dc1zysrt8DsLt3szXDqsS6GzR3lHDrAxXSLnbf/isJmon2lQmM96nk/SnqhaQt+NL0X3bJgcxCjw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by DU2PR04MB8503.eurprd04.prod.outlook.com (2603:10a6:10:2d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 08:42:01 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 08:42:01 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v3 2/6] media: Add broadcast sink media endpoint
Date:   Wed,  2 Aug 2023 11:41:36 +0300
Message-Id: <20230802084140.51105-3-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230802084140.51105-1-claudia.rosu@nxp.com>
References: <20230802084140.51105-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR07CA0003.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::16) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|DU2PR04MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: bd585023-661c-458e-d659-08db93345736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FHmJD/EvzZK/7byYfmWyB5Np/4Im0uUAv83n4kra76tiMrcTbUa4G2cnFNpB0QePtyNJqwbiw0YMGwX7cZ8834XnYBWcXZTf4mS6fdjmBsGodQWpvKIsPX4OeltxkP3ZsC9Mc8uKmqxfB+l1SfZOnzXXx5k00L+dXvaRzBL0f5Wvb/RKr/tXIAiXb3E1IKplosZrsCVrzLDCQolaQ0Y4KBJGKO6kM+qU5INvZG0gqcFcEofO+kLy2Z1eoDKyy320hasni3ayG24v0/1c3Aqy0FzGioy28dQXDMJLzrxWRIyN2JSl+2wu21DyPn75Ui2MswnPwsfGWUVvGsYNWjcJfHbcCfU8SijSItXGD+xsNjwzvJ+UzyHQChmwjDplsHnQ0VUIBwLRu3PMOmihc7nrpyCRxGq3YN2L4CGfClq/HJsFLcPmIG+ilmDxl3D14JkfYMACnpF6a3jcgYSFQwduGfHEukKa5ey7FhA6jh+KkE80cY6StbF2J+mrhbcRvp/7WDzruiaTxy+8n1+KK9F8h0gzUIoSkIfLnpzBYCBalOrBBCstM/JOnHsr5HGxXNCm3e0+p//0P+PuscYabxKb0GVhjOadyP2IYUMKI7CvIM0KuqCrMjfdS+T6XFtOlC2U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199021)(66476007)(66946007)(4326008)(6916009)(66556008)(316002)(6512007)(83380400001)(2906002)(86362001)(186003)(26005)(1076003)(5660300002)(6506007)(36756003)(2616005)(38100700002)(38350700002)(41300700001)(8936002)(8676002)(6486002)(52116002)(6666004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SO13S1nLve3XgT3+KYt/cALzoetB3sxMqo4qZTUCqrHaDXDNoAb0KK2Ryx64?=
 =?us-ascii?Q?Fop7SwEYtu3MpXsXoIyKkVNR+PtJ/L/e3q/82hAU5Jnuz2Fj7eGaBy7ZNeyI?=
 =?us-ascii?Q?gibcv6kO/kZZn8B5XZQRextj2LVrww70CXLnsPdrCFGFvSJvG6nB8SM9vg6r?=
 =?us-ascii?Q?0zi+TuICZFUuCcm6z2Bn2vTig7P+YrfhQAceIqijGmlTKnZpXQp0HN+4yGNW?=
 =?us-ascii?Q?9dsOmrIHC3HNcG0L5D6h9hlrOvDGNxC54azuDDFZqa5JM7tHmrrhRIZEedZp?=
 =?us-ascii?Q?G0wM/gB7b/ZuZ/PaFsYlSUMUhy3/wPva1zcaCTZS05LTDa7PCxoh/mA0DtdB?=
 =?us-ascii?Q?W8eSbxIl6rp+2dw4KARP6iPXvuBwI+zotBDZ8mLOQzyZIdYrRrAJygmTUV7Q?=
 =?us-ascii?Q?+D0MDz+DkKf/8nW09+27oFJYz5yqMsEzwysyrJf+dQs9LaV5BwWNB3r0LucU?=
 =?us-ascii?Q?uJHiU5b9mTQW08fhQsrQt3VTSdyrPCWVyksWLVP59Rktq5wsGAanD8LdzkXw?=
 =?us-ascii?Q?kuknrMA4G4K/eBuuQ8EbQ7gcgfNXwUq59ZluIAA6r6pkvo3wbpwFYILkabAk?=
 =?us-ascii?Q?RsXe2o85yzHve0aVVqHv28WoGAYIBFRjEp86lcDfOu/qaGydnH92+Ojx0OE4?=
 =?us-ascii?Q?0kNLIug9ktuOmJ4ILj1XQXgQNoocFXNEDEJSmAZ7iJ6wxmgQ9db7JPbAfnyE?=
 =?us-ascii?Q?yV+5kvN+uBLJ9NORIypEqw4e/hYKS4jhPqSs+cXsdZhiFpS70Cv4DyYNKmWe?=
 =?us-ascii?Q?zZoHzu1Nf281/JE/XEJyZ9NBFajXX41hLnEXl9k6dLOM2tuGPaRHN/qAjJmm?=
 =?us-ascii?Q?5KME/hI8kaScomnSq3j5aibCAK3M61YIvsoEasTddQ+hQk90XMoy/OJBM1Ap?=
 =?us-ascii?Q?aaHprqolj9ZK45yc/w4wE431H/Rp8Jq3X2Mlq8nAgnoxu2qO9o1oM2QoP32G?=
 =?us-ascii?Q?TKG+3dhLjA/eT9kzsZicmAio/XoeIEfYyxbqa/bQSSAqAhnBvdJPTZQ3WO6B?=
 =?us-ascii?Q?53j9uUH+8FF5WRwuKjfU4S7bHVSoGcrao3xDZe+MYMMmYAKUHOIADgJEL7o/?=
 =?us-ascii?Q?wGajzYvZnb3FXOKx1tXDEy4KPXERdNqOovmRqjcDWo2884kj3JQ78AJE54sx?=
 =?us-ascii?Q?i7T0/E4Mbm+TDMcEUCoMD7Q6fWt39dXKnd18wkKBNqALLQI/62ruknlGHU5M?=
 =?us-ascii?Q?uqFwZ6g+EkgtDww2ZNxVUAZVosJCECZPwrrqI2n0nkJ4LGEY2qCWo7oSnAn0?=
 =?us-ascii?Q?EgofDrjXDjUcoLtarrTztuCjEJo7n5JpR6jbwqVFaPzeRexsa0+yx8SSoq2H?=
 =?us-ascii?Q?WOVVENLSVt8tK+c/2u2f80kbNC+yNVEPk9wSC55qjq5LrmC6fDWJ3MZJAuYt?=
 =?us-ascii?Q?8Z2LkTG5Hbrq08TvoKqPyC4MDejo2UKNn/b+z33NCcclyLX9Pik7ecaskfS2?=
 =?us-ascii?Q?6sSDY87BiP4CAM4MK4copXliPxvoBrZvTAHtR1szzs64d/avplZGmomPt8jF?=
 =?us-ascii?Q?2dVgcgmrYYI4kHf8sE5H0KYUmbh+Hc2454wMN+4jI7HeFyptpkWQGstZ1Bpt?=
 =?us-ascii?Q?nYKXvm1p5SZamoNGEz0YLrUz+RirvhnwEsyFBtVS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd585023-661c-458e-d659-08db93345736
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 08:42:01.5120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9mXAQbu2e5OJGlnDnz7iBJMZxhsZs3xRxaM074AVfD7zKv0+Rc9rnMMTQeCo9lIr5/faE0z3EH1/r5+NtlkIiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8503
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

