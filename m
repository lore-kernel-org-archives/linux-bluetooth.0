Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446E2C41513
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Aug 2023 16:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjHHQ1O (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Aug 2023 12:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbjHHQZf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Aug 2023 12:25:35 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2089.outbound.protection.outlook.com [40.107.8.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C9F8913
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Aug 2023 08:50:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccKw1sN80LvCnqCaXQeMOOFo8QwqP6uKGtK/jXt/XmiYGXzbUd4nrDByUd9svizSIL+H+tOLF7F9P4j+9lyIZ8cao70lPvSdEyJGw31G+opgErWx00pmPJpMH/K2tkgBMbRqBCU8b8XS7liJOKssD1nhBxXNY8k/dSu2CUawYfXVINw0MyV8zpSoIBmp6lok493S/fOmT7qnsBv+xFVqWFNsSU3N4U3vyuKmHjAryKVLnAN6/zUgi0XJl+OLTlZuMC/kV1t3WKKXm47t4dGmGlpNK5/H8PPIGAjcACSASECs+GVVWV3B3DMaO37tD83dClrrMK0fY+IzeIAoUq0/sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2SsJNzKeLyeWtZJcwJttj3Ap2P5iRVqwXMOgdA2cEM=;
 b=kaJiv0Wm4bA45fwiyJ/9YIxBz78iiXN5sHoUJGpdI0OrSG11aDzunAdziKhKhWCt+WxlsQJ6YVEJ59PBu4sOnlMjyRhL9Qw6/VZ7l84jvIbyk5aeBQdthxLnTwOezXKoLtPJJJMWy8k9Hz39xlc4RqJ1aEtgXMdYA8gDMB3mRCuoPLmx2SozfjTnpCx/9P22+oiySP1lwVyn729iiqk+znzcBWR22SAjIeXfnPifrTmo0im3UTtZcP6w8IJ6fzE9SM3k73jPvT9pKQeHZ9OBzG1815R8um/E2G40aGPACGqkCwfdIzP5ybRThGakPCglI6Z1JNRybolQYIYgQl1s5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2SsJNzKeLyeWtZJcwJttj3Ap2P5iRVqwXMOgdA2cEM=;
 b=EEfbEU1VhJ+R07mW8ZXISZoXfqz6vBCuRrprCRcvD8bgVVwpa/i40C0eQvlHMBt25swRqsJetTI+k3roAPfAnL8Yxyzbl2SRcS4mr+GOFFj1CJasPkMXOKOaF1SUOOidI+uLSkwmZPIdw5aKhREosx2VWW9TC9g2ZjjWiknayYU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by DUZPR04MB10062.eurprd04.prod.outlook.com (2603:10a6:10:4e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Tue, 8 Aug
 2023 11:53:14 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6652.021; Tue, 8 Aug 2023
 11:53:14 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v5 6/7] media: Add broadcast sink media endpoint
Date:   Tue,  8 Aug 2023 14:50:39 +0300
Message-Id: <20230808115040.4403-7-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808115040.4403-1-claudia.rosu@nxp.com>
References: <20230808115040.4403-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P192CA0001.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::6) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|DUZPR04MB10062:EE_
X-MS-Office365-Filtering-Correlation-Id: 16227c0f-c31d-46de-e6d5-08db98060bd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q7A0hJ8SO3mFdXveT18P4G+wxYbmRz2rYa8SpfwIhDiDtvqsJETC/UNFnlvFmEh0w3LpUErEq+G3j0ZDQnFrupXcIxt9p/2Z0qzOXaZmvIQiooSCZ0QdE01ZHyXxdqqiTuGzugXzkfU0fiL4tTd/hMMrbBt2WtBoQ/2EfqpixkuzL9tZ4ze/GmMAeN6WW6c8x0ftmX/Tn7p1q5VoD2cvKyO4GfDJiWNdKI00qIWr+Nxd+4t6u3Wclz5smMsmEWhrsDOkf+OjmBZNLAckLpmN5qK6/2SDMwOJtdrpKMAby6vX964L2lgnRKjZI22IecPW5JkmXGc7RAyFQID0gVCXyEJtWa8X3ML7QaJMwRS30zA7uJ/p3aQPlAwzFIErgvdZlbuceF/tAw7vVbLRxD4GKSPz7XM2jm/doNmDBMJjwVajSVNRAAXkLg+nvOJBLc0LyR0sSXppZFoaDYBVnea6BVDVnUPRZBZVF5uxfZzUEMXpNACKRBwaklnoF8t6636ILyOFeobKHTi0P1l2A15eKH3Tnxdqe7EkNeYRGJM8QasUcPkhjhJeJkbtyBOsvKyoYC3Us4t5ZhIgLT3XoTlzof9raKjESRC1rkySjFbJo2J3XikIUx68fC/sJuNjpcPO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(1800799003)(186006)(451199021)(83380400001)(2616005)(52116002)(6916009)(38100700002)(38350700002)(41300700001)(2906002)(4326008)(5660300002)(316002)(8676002)(8936002)(66476007)(66946007)(66556008)(6512007)(86362001)(478600001)(6666004)(6486002)(6506007)(36756003)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KhcJMOGZhDELWQQIf/8cWeogvPpXyx4rrjRqOBT46R8X/JC5y6g8+SDyAmCV?=
 =?us-ascii?Q?bLXWTkJTxpd9ddsqlNCVSAzSC3qU0cYAd8yRhVn/zStlUgNJ5aCbPBcVab1w?=
 =?us-ascii?Q?4dP73G33J/20OfgIUF0fp9a716bqE6ob+1blo9NUaCgCQZz/N4MlWf8ZHzS+?=
 =?us-ascii?Q?v97lnQdIlAmooqmwXnnxmPBbETnJkHw1bWlvfNYxs1sp5z9s5RLCDDFPfW/z?=
 =?us-ascii?Q?a+QSj/RmHmwwhqTqPXPmPgSQzjXzQCiU/zLXMk4gI/qUYj/G03dheiDOrNAw?=
 =?us-ascii?Q?E8UWCKTaheumOEg63fBRpjiER2diuKIf5/Ii00PNRTcQGLACbFaBrdtIOWnU?=
 =?us-ascii?Q?3jW+e+JMXjtpPd9Atf2nEDHTxzFVRpSMb9ujaEbi4Ycvf9QRXV0PWE9nSDJd?=
 =?us-ascii?Q?//KanV77He294qOeJp4FLDNh8JChRAm4O82o7vbcpOYZ8i3taVYS4CEV5rMN?=
 =?us-ascii?Q?TS39Cmm4a7BFw/pKMKvLOin7cvCsmVtL9i12KxaNC/kKwHErRju/kF9ErnTr?=
 =?us-ascii?Q?nwkzXNbEuzsdwLn6Y87noOXsADNhu7ppN6YXkEJ4oScPdAB9I8HMbLMbYQj0?=
 =?us-ascii?Q?WAXDmfm1D1aqKSNXhAAJ2swiPRXaC2qiOfFbgNRbXC3aMRa7kg+3sNoAyRDo?=
 =?us-ascii?Q?UziDNcH09rmSS8Qw1BHbdw1HvjgfnDwMJwEVkaPcBZLnMLTy7OfmkEqvOvUH?=
 =?us-ascii?Q?yhbjf2VtfQcTTaKexChZNZf5Zp6nl9XZ24XxEtOcC9IfjBWz39o4fbWMsPMB?=
 =?us-ascii?Q?pCj3BsG9jMz0r9xHiTyEz30/axGOWHnHF+v6FSZMPV19C7vss4jv+VO80AuD?=
 =?us-ascii?Q?tYA2l6A+v0qoVgZD7K50SQ5MeL8fahCLaFEW093QpEIwQreFS07E6hrd0Ya/?=
 =?us-ascii?Q?XDruwiY0mBVILwUHQvNoSegJTNkckXeOP0aDlITr69ZZp+JM1/tys0jZSZmN?=
 =?us-ascii?Q?T6Ay8hS2enSJ8gShnWw7l+aBdEwrrjTg2j3UhDw0DhMfDgYhfyd4+cW3RsMr?=
 =?us-ascii?Q?ez1x0eZE0uhIVcKjGwdLioCTpX9yNgn//HbA71on9eysB0GYKyvBlu37UVe+?=
 =?us-ascii?Q?AGMLjZkfH5LPL9QuF8EBrAHK21pf5POo0qqdCgT8Dt2blU+Yoa/eu56GZpnd?=
 =?us-ascii?Q?ZJYpBgUNpXPQjmh0by2CNoIzGFkjmbiTm9Y6MW7AuYhz62nMi/Y4E8fMQ8su?=
 =?us-ascii?Q?sr8/cK+kGMmivZOaEjJknE7gCHcSypo3r3Ya6rmrUmRPGpVvvlLpIoJkYLZI?=
 =?us-ascii?Q?69lmIXnqgObBDMDveWeN9mPlrpYlgS/QSR27/lGLAqYhQIlh11PRYhbYpbkz?=
 =?us-ascii?Q?r3WKLXKtEw4dxdA6Rx0Anm+9RYsWZXeit30hWgCR3hm3uBMHn83POrE0wtum?=
 =?us-ascii?Q?iKlGFVMpEcn6jRjepio8zZeLYsD7G9MG/dVmsVkC6qMmr32HGFgDbcvLFVvb?=
 =?us-ascii?Q?BoHK/F0rs+8e/W/vQIpqDr6jCd2zk8Q1qNBtfXpvkoMc0qaSLAGaHnYkcEvt?=
 =?us-ascii?Q?apYzQB64LoC3CvQ9pPdjI2ewCziHKaAEbeaONcOm9944+lWst7vOg0LoBlAi?=
 =?us-ascii?Q?dslJc0RbtufHEwiEAXJdFTRBbrbWGjdoD2n1LF/H?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16227c0f-c31d-46de-e6d5-08db98060bd4
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 11:53:14.0511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /xWT6j3nUV+tmbaLJVkbwSZGIh9mlJUf7pP/IdA64wc6Lr7JaOhKE2ffCvAEIuFAvhdAw6/UmiSh0DA1QWMwlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10062
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds the possibility to register a broadcast
media endpoint if the controller has support for ISO Sync Receiver.
---
 profiles/audio/media.c | 82 +++++++++++++++++++++++++++++++++---------
 profiles/audio/media.h |  3 +-
 2 files changed, 68 insertions(+), 17 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 15c64c8d6..59143060b 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -105,6 +105,7 @@ struct media_endpoint {
 	GSList			*requests;
 	struct media_adapter	*adapter;
 	GSList			*transports;
+	bool			broadcast;
 };
 
 struct media_player {
@@ -1058,7 +1059,9 @@ static struct media_transport *pac_bcast_config(struct bt_bap_stream *stream,
 						struct media_endpoint *endpoint)
 {
 	struct bt_bap *bap = bt_bap_stream_get_session(stream);
-	struct btd_adapter *adapter = bt_bap_get_user_data(bap);
+	struct btd_adapter *adapter = endpoint->adapter->btd_adapter;
+	struct btd_device *device =
+			btd_service_get_device(bt_bap_get_user_data(bap));
 	const char *path;
 
 	if (!adapter) {
@@ -1066,9 +1069,17 @@ static struct media_transport *pac_bcast_config(struct bt_bap_stream *stream,
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
 
@@ -1238,6 +1249,12 @@ static bool endpoint_init_broadcast_source(struct media_endpoint *endpoint,
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
@@ -1351,6 +1368,17 @@ static bool experimental_broadcaster_ep_supported(struct btd_adapter *adapter)
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
@@ -1366,6 +1394,8 @@ static struct media_endpoint_init {
 				experimental_endpoint_supported },
 	{ BCAA_SERVICE_UUID, endpoint_init_broadcast_source,
 			experimental_broadcaster_ep_supported },
+	{ BAA_SERVICE_UUID, endpoint_init_broadcast_sink,
+			experimental_bcast_sink_ep_supported },
 };
 
 static struct media_endpoint *
@@ -1382,6 +1412,7 @@ media_endpoint_create(struct media_adapter *adapter,
 						int size,
 						uint8_t *metadata,
 						int metadata_size,
+						bool broadcast,
 						int *err)
 {
 	struct media_endpoint *endpoint;
@@ -1397,6 +1428,7 @@ media_endpoint_create(struct media_adapter *adapter,
 	endpoint->cid = cid;
 	endpoint->vid = vid;
 	endpoint->delay_reporting = delay_reporting;
+	endpoint->broadcast = broadcast;
 
 	if (qos)
 		endpoint->qos = *qos;
@@ -1458,11 +1490,11 @@ struct vendor {
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
@@ -1546,6 +1578,10 @@ static int parse_properties(DBusMessageIter *props, const char **uuid,
 			if (var != DBUS_TYPE_UINT16)
 				return -EINVAL;
 			dbus_message_iter_get_basic(&value, &qos->ppd_max);
+		} else if (strcasecmp(key, "Broadcast") == 0) {
+			if (var != DBUS_TYPE_BOOLEAN)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, broadcast);
 		}
 
 		dbus_message_iter_next(props);
@@ -1569,6 +1605,7 @@ static DBusMessage *register_endpoint(DBusConnection *conn, DBusMessage *msg,
 	uint8_t *metadata = NULL;
 	int size = 0;
 	int metadata_size = 0;
+	bool broadcast = false;
 	int err;
 
 	sender = dbus_message_get_sender(msg);
@@ -1587,13 +1624,13 @@ static DBusMessage *register_endpoint(DBusConnection *conn, DBusMessage *msg,
 
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
@@ -2627,6 +2664,7 @@ static void app_register_endpoint(void *data, void *user_data)
 	int metadata_size = 0;
 	DBusMessageIter iter, array;
 	struct media_endpoint *endpoint;
+	bool broadcast = false;
 
 	if (app->err)
 		return;
@@ -2736,12 +2774,18 @@ static void app_register_endpoint(void *data, void *user_data)
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
@@ -3245,3 +3289,9 @@ struct btd_adapter *media_endpoint_get_btd_adapter(
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

