Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633F8C77B73
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 May 2023 14:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbjE3OQE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 May 2023 10:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbjE3OQC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 May 2023 10:16:02 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2074.outbound.protection.outlook.com [40.107.6.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F971B4
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 07:15:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9nGiTrYdnRMpjkmO6oP5QegVSvEdNuPFoH/2jHtzFEHKiKkVyhoJje8w7LG5SWAJz0+LHsBqGZGZ0v6PQTSEpJ9y4N6Roi8XcLh88Ouj2P6g8Mc/vZKq9+eJYZ3V+LypEqntVot4k0VW4Kq41qf+B/1akgBBoiEaB40xy2SFcojhY8fLJOwjTHBPO6vtNSyECehQ9GcZc5Ywd6xoyJVTKOvbdHJLgV7pcMp192UU6KWuG/wwdMSkzhzPgzIsg/lKGm1at7x6p0jABKuTbBojZv+gGgyyp6v+ozRQjCAYm+YGcosWW+hs6Zmahr51RT/jaOvNU6eT/l7R6trrgO5VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wvl2zaw/G+bK3BhUSz82aMy8L2svBG0TUswBrJ+dxoo=;
 b=BbAkpo9FFZgBfecxT8dUuHIfF5m2vGgDGShS/YUm6kK9QDFiepZBJDZkUBjHRE4JH0y+yRw3uxTv4Bjrr53OEhjavft+CdRNFzX9ODUrhG5nAcc4yejAHaQH8uw5bmrlOOjbya3G0kwiRYKOmXzJ4RhpHHnFS2cIiWCiHEhUxBta+vMhm4p+xxCtknPTx6K18TOqocTawZABoYTx5OFFSY5T8EgyzmnX33ObaThHPXdhOn8E29Ne1W+vo5d0wyP8UaRo6Rnvxvs7qBTvkMvBX9RJIW6QWvOB6r/lJsOFKHUOg9lMhWrrm4phWM8Ikq3xmgsNF50n++by/fOpTDNr2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wvl2zaw/G+bK3BhUSz82aMy8L2svBG0TUswBrJ+dxoo=;
 b=bLadE7IJ/Eb0Si+/+n55Fiqo+cY+g5Jc1E5NuoBpNMAjZ9/OaxffRRNYEYSdiEI5W7j3emqKzMmYUPrInDyReylogsAjCTz3FRqdUNjj/lutWgEslgaQVVoScuLjUMT0a1a42WUnLODjkWoi46a9O4iDFwfz5+4nxTPNurHIxvo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by DBBPR04MB7913.eurprd04.prod.outlook.com (2603:10a6:10:1ee::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 14:14:08 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::cedb:51d6:a774:f81a]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::cedb:51d6:a774:f81a%7]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 14:14:08 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Subject: [PATCH BlueZ v3 4/4] Update BAP plugin with broadcast source support
Date:   Tue, 30 May 2023 17:13:39 +0300
Message-Id: <20230530141339.100733-5-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530141339.100733-1-silviu.barbulescu@nxp.com>
References: <20230530141339.100733-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR07CA0021.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::34) To VI1PR04MB5344.eurprd04.prod.outlook.com
 (2603:10a6:803:4b::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:EE_|DBBPR04MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: 23af4f87-8bc9-483d-110e-08db611821fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DeeDYFhdcolnLPYAmedGjqjAic3HLywyoQK1VslYAUZwPX2x/auIHM3aaPgEfaooJiYLZqDnes0BLMqV17GI2Sc4W3ie5vmQmnBsqnyyDL+tlm8BOtqwLYRupRCe/eYTTehRAe1oL2nQnP9QPYT8MnZmq0Aw56rDiOeD2Cd8F7sJ4ffWAbSS1H2LPgxmZob8G08O0uxyvd513UjWGfILuFfwXmwm/iUIG15fvPpRr2VbnkmchKStoeiufmJIuGwXREXHqBZKhUMiDbTjJGk+JY1wNzS3guLRLbRYIi+w8Ce78nokuzkDMzm9veyR6rttQDwwk5PUOll6dakyhzPIRQPdc9CW9O31IMYCJ/qgXBdS6K7nSBhEVERnDeCjmwfKtPP/8UAeu2WirxN528bb2rzmVyo0DRyXj0W55czwNVKuM/R3xysaZcRykX4GZoFE5T0mcQDWH7rThZ4Qzzpm6hvBoEnqom7nlpQFO5nv+Zz1dMcZEtnf9g6lgApQ0TnwAKe+LCXqMtawnn67j79NIP+UGaM/Avo1RTpBZQzVTopqN0j86bXmHGmyDTM9pirjKT7jWDksGorVXXFHQGaEzJgEYA5XjolkwSXtTSusxb2wIR3FHwmsN3uUfVRU+re9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199021)(478600001)(38100700002)(38350700002)(66556008)(66476007)(66946007)(41300700001)(52116002)(6486002)(8676002)(5660300002)(86362001)(8936002)(26005)(2906002)(30864003)(1076003)(186003)(6512007)(6506007)(15650500001)(83380400001)(4326008)(6916009)(316002)(6666004)(2616005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?01Mfu4vzPJ1JeVGy0MonUdI8QKBr+j+es1qWqc0oV2Ma1pA0sLeWdVliUxQD?=
 =?us-ascii?Q?dj6aKAcBXQuAn6Sz247MlLZbVagW1GkDt00jEabb78kM5I3dsLmoK9jAKEUt?=
 =?us-ascii?Q?DY1P3Y1h9Zx5gDxvlAYeAWXUIgcvbCxq8UTlE9K5bLvBIUfop1s2s9//mfis?=
 =?us-ascii?Q?uNF8BsukpOTGOo4iOsTD0xLUbq74IwaxDugqzVyxPjGw4JGnm3GWYprvds2G?=
 =?us-ascii?Q?7Wia0z712PtlxoyPVarTVtbaHkvCq0MqxacFCbfUG2UhWRGhNXlppfqJofA7?=
 =?us-ascii?Q?IN9GHdiCT60cFrf9dDzTX6dovL0JuRcprLI2aNCb3Y0UAVvfMTpDupAXSuuO?=
 =?us-ascii?Q?he1z22jnHEy7haw0GxdaDq+qJopB579PIbxaIBxl34r/HBKKyDAYsLol77TI?=
 =?us-ascii?Q?U3ButxuD2ojFkriwN8VUQD4stCu1F25y//uC5gljKNwvQISNeKm2a4kPFjhP?=
 =?us-ascii?Q?RMY0WzXgphEqxJCFI/ZeGibgPKfJCEI3wrj2hVKkhqvmYo3CEXUriF2jeFya?=
 =?us-ascii?Q?59ziPj9gdMxgtpln7nsVt41FcVvATDXEdI7kuCauupIsJVaAe3T1Uvfi9j1J?=
 =?us-ascii?Q?jVk9qXHq65qqbrWBVdPWmCuSaIeIHTwpUURYrs0z+I9zh1Zzc+k0CWFuhiL3?=
 =?us-ascii?Q?+KcYQLEy0591Js8XhWXDhv7DT6SkY3jHL857RwqTFQXvbbAmi55f7/6L9YhX?=
 =?us-ascii?Q?HnGFtuCwuJvfdU5PFwCZgjbxSnoAiM/Jaup2agy6oYtKbXlRUllfbbRNBKbx?=
 =?us-ascii?Q?dVisAAsAp3TzfXWIyYwGtTJmwp5K+iysfna2f5wrttsAuo2V1iZTXqnAF+yQ?=
 =?us-ascii?Q?m29hkqcfkbHjBZaQgP6+RhuaCzyeLn2UAlV0zk7d31XhVPUVZEOcfEWQoZy4?=
 =?us-ascii?Q?NUpKDYT0QUfAhgKuXsIZ/ZNnc86zYTT0j2Vk994xwmHc6zx0poQMFF9Imv+i?=
 =?us-ascii?Q?KXoTOM400CSZ9YMCEigLv8zfH/xoSVoPEUrTsS0CNXzGJOIm71zt74S8rHJS?=
 =?us-ascii?Q?Z/Bsgxg0ZfHjir+vN/yGLJ094FviZFV/OwqcWPPHb62dK5zCtR8mmxiAqsw6?=
 =?us-ascii?Q?wWUwqCLXseqV5yvXZagT4hDnIzJhm0GVF7C66DOcodrvoGKsJZz7MrdxKkQR?=
 =?us-ascii?Q?p/xLjiyYWcIO2CJ6ogGpeh5CQb3yn7pDCNBWCMFMnlypVDtDk13DtoYVIPoy?=
 =?us-ascii?Q?KR3JKKzo/x38b3MzvGZwNSEz6C6kIzmnNQk6wH/1dbGRyxowwg0hnaBK2pd8?=
 =?us-ascii?Q?t2+4GTMG3MiSQDvx0LYGcrr2NDfhX8UVHcARTVTe2rWGeY7Thp6XKV90nfAC?=
 =?us-ascii?Q?gBRPRYwm0iVGJA5rnhCktWbY2gPkOtNMxxikQ5atYr9WOgikQ7sXAkylC29j?=
 =?us-ascii?Q?6az+1afFb+vzxS/dFoc6wfxagXGXgTwWOibal0jW/yniBE4Wm805yJ99Uv42?=
 =?us-ascii?Q?0FRCnJ953aC0d1npChbiqaLwHcsIVktbNCYPJwRKzlw5OsYe66Xk7nwoUnZ8?=
 =?us-ascii?Q?+fzxfkXOYFVuPdUaZu9wZhyFLrGgxJuvmfjCqk3JGvpJh7e4MN1qNlkniJfg?=
 =?us-ascii?Q?awoArZZaPau5mfdcy5BqB2Cec8QMb+51dG3pN3F71nBmpg7SQhcOlRejjsCc?=
 =?us-ascii?Q?ag=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23af4f87-8bc9-483d-110e-08db611821fe
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 14:14:08.2313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyx1zmfjsdEfSXXMLryWVmz4rFFX2pLYjqlTvUqC8PBerhYrPn/0ZYFPQKs46wr5gdPh5CW0mXEdSyW8Kd/YZDCqUiwSFoSHfqpDTm1iwLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7913
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This updates BAP plugin with broadcast source support.

---
 profiles/audio/bap.c       | 436 +++++++++++++++++++++++++++++++++----
 profiles/audio/media.c     | 113 +++++++++-
 profiles/audio/transport.c |  32 ++-
 3 files changed, 519 insertions(+), 62 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index cbaf705c0..fb8188819 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -82,13 +82,25 @@ struct bap_data {
 	unsigned int pac_id;
 	struct queue *srcs;
 	struct queue *snks;
+	struct queue *bcast;
 	struct queue *streams;
 	GIOChannel *listen_io;
 	int selecting;
+	void *user_data;
 };
 
 static struct queue *sessions;
 
+static bool bap_data_set_user_data(struct bap_data *data, void *user_data)
+{
+	if (!data)
+		return false;
+
+	data->user_data = user_data;
+
+	return true;
+}
+
 static void bap_debug(const char *str, void *user_data)
 {
 	DBG_IDX(0xffff, "%s", str);
@@ -167,8 +179,10 @@ static gboolean get_uuid(const GDBusPropertyTable *property,
 
 	if (queue_find(ep->data->snks, NULL, ep))
 		uuid = PAC_SINK_UUID;
-	else
+	if (queue_find(ep->data->srcs, NULL, ep))
 		uuid = PAC_SOURCE_UUID;
+	else
+		uuid = BAA_SERVICE_UUID;
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &uuid);
 
@@ -254,6 +268,7 @@ static int parse_properties(DBusMessageIter *props, struct iovec **caps,
 {
 	const char *key;
 	struct bt_bap_io_qos io_qos;
+	bool broadcast = false;
 
 	while (dbus_message_iter_get_arg_type(props) == DBUS_TYPE_DICT_ENTRY) {
 		DBusMessageIter value, entry;
@@ -284,11 +299,21 @@ static int parse_properties(DBusMessageIter *props, struct iovec **caps,
 				goto fail;
 
 			dbus_message_iter_get_basic(&value, &qos->ucast.cig_id);
+		} else if (!strcasecmp(key, "BIG")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &qos->bcast.big);
 		} else if (!strcasecmp(key, "CIS")) {
 			if (var != DBUS_TYPE_BYTE)
 				goto fail;
 
 			dbus_message_iter_get_basic(&value, &qos->ucast.cis_id);
+		} else if (!strcasecmp(key, "BIS")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &qos->bcast.bis);
 		} else if (!strcasecmp(key, "Interval")) {
 			if (var != DBUS_TYPE_UINT32)
 				goto fail;
@@ -342,13 +367,61 @@ static int parse_properties(DBusMessageIter *props, struct iovec **caps,
 				goto fail;
 
 			dbus_message_iter_get_basic(&value,
-					&qos->ucast.target_latency);
+						&qos->ucast.target_latency);
+		} else if (!strcasecmp(key, "Encryption")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value,
+							&qos->bcast.encryption);
+			DBG("Got Encryption for bcast");
+			broadcast = true;
+		} else if (!strcasecmp(key, "Options")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value,
+							&qos->bcast.options);
+		} else if (!strcasecmp(key, "Skip")) {
+			if (var != DBUS_TYPE_UINT16)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value,
+							&qos->bcast.skip);
+		} else if (!strcasecmp(key, "SyncTimeout")) {
+			if (var != DBUS_TYPE_UINT16)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value,
+						&qos->bcast.sync_timeout);
+		} else if (!strcasecmp(key, "SyncCteType")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value,
+						&qos->bcast.sync_cte_type);
+		} else if (!strcasecmp(key, "MSE")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value,
+							&qos->bcast.mse);
+		} else if (!strcasecmp(key, "Timeout")) {
+			if (var != DBUS_TYPE_UINT16)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value,
+							&qos->bcast.timeout);
 		}
 
 		dbus_message_iter_next(props);
 	}
 
-	memcpy(&qos->ucast.io_qos, &io_qos, sizeof(io_qos));
+	if (broadcast)
+		memcpy(&qos->bcast.io_qos, &io_qos, sizeof(io_qos));
+	else
+		memcpy(&qos->ucast.io_qos, &io_qos, sizeof(io_qos));
+
 	return 0;
 
 fail:
@@ -510,6 +583,8 @@ static void ep_free(void *data)
 
 	util_iov_free(ep->caps, 1);
 	util_iov_free(ep->metadata, 1);
+	if (bt_bap_stream_get_type(ep->stream) == BT_BAP_STREAM_TYPE_BROADCAST)
+		util_iov_free(&ep->qos.bcast.bcode, 1);
 	free(ep->path);
 	free(ep);
 }
@@ -553,6 +628,11 @@ static struct bap_ep *ep_register(struct btd_service *service,
 		i = queue_length(data->srcs);
 		suffix = "source";
 		break;
+	case BT_BAP_BCAST_SOURCE:
+		queue = data->bcast;
+		i = queue_length(data->bcast);
+		suffix = "broadcast";
+		break;
 	default:
 		return NULL;
 	}
@@ -611,12 +691,14 @@ static void bap_config(void *data, void *user_data)
 
 	ep->id = bt_bap_stream_config(ep->stream, &ep->qos, ep->caps,
 						config_cb, ep);
-	if (!ep->id) {
-		DBG("Unable to config stream");
-		util_iov_free(ep->caps, 1);
-		ep->caps = NULL;
-		util_iov_free(ep->metadata, 1);
-		ep->metadata = NULL;
+	if (bt_bap_stream_get_type(ep->stream) == BT_BAP_STREAM_TYPE_UNICAST) {
+		if (!ep->id) {
+			DBG("Unable to config stream");
+			util_iov_free(ep->caps, 1);
+			ep->caps = NULL;
+			util_iov_free(ep->metadata, 1);
+			ep->metadata = NULL;
+		}
 	}
 
 	bt_bap_stream_set_user_data(ep->stream, ep->path);
@@ -652,6 +734,7 @@ done:
 
 	queue_foreach(ep->data->srcs, bap_config, NULL);
 	queue_foreach(ep->data->snks, bap_config, NULL);
+	queue_foreach(ep->data->bcast, bap_config, NULL);
 }
 
 static bool pac_found(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
@@ -668,8 +751,13 @@ static bool pac_found(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 		return true;
 	}
 
-	/* TODO: Cache LRU? */
-	if (btd_service_is_initiator(service)) {
+	if (bt_bap_pac_get_type(lpac) != BT_BAP_BCAST_SOURCE) {
+		/* TODO: Cache LRU? */
+		if (btd_service_is_initiator(service)) {
+			if (!bt_bap_select(lpac, rpac, select_cb, ep))
+				ep->data->selecting++;
+			}
+	} else {
 		if (!bt_bap_select(lpac, rpac, select_cb, ep))
 			ep->data->selecting++;
 	}
@@ -700,11 +788,18 @@ static struct bap_ep *bap_find_ep_by_stream(struct bap_data *data,
 {
 	struct bap_ep *ep;
 
-	ep = queue_find(data->snks, match_ep_by_stream, stream);
-	if (ep)
-		return ep;
+	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_UNICAST) {
+		ep = queue_find(data->snks, match_ep_by_stream, stream);
+		if (ep)
+			return ep;
 
-	return queue_find(data->srcs, match_ep_by_stream, stream);
+		return queue_find(data->srcs, match_ep_by_stream, stream);
+	} else if (bt_bap_stream_get_type(stream) ==
+			BT_BAP_STREAM_TYPE_BROADCAST) {
+
+		return queue_find(data->bcast, match_ep_by_stream, stream);
+	} else
+		return NULL;
 }
 
 static void iso_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
@@ -943,6 +1038,69 @@ static void bap_connect_io(struct bap_data *data, struct bap_ep *ep,
 	bt_bap_stream_io_connecting(stream, g_io_channel_unix_get_fd(io));
 }
 
+static void bap_connect_io_broadcast(struct bap_data *data, struct bap_ep *ep,
+				struct bt_bap_stream *stream,
+				struct bt_iso_qos *qos, int defer)
+{
+	struct btd_adapter *adapter = device_get_adapter(data->device);
+	GIOChannel *io = NULL;
+	GError *err = NULL;
+	bdaddr_t dst_addr = {0};
+	char addr[18];
+	struct bt_iso_base base;
+
+	/* If IO already set and we are in the creation step,
+	 * skip creating it again
+	 */
+	if (bt_bap_stream_get_io(stream) && (defer == true))
+		return;
+
+	if (ep->io_id) {
+		g_source_remove(ep->io_id);
+		ep->io_id = 0;
+	}
+	base.base_len = ep->caps->iov_len;
+
+	memset(base.base, 0, 248);
+	memcpy(base.base, ep->caps->iov_base, base.base_len);
+	DBG("ep %p stream %p defer %s", ep, stream, defer ? "true" : "false");
+	ba2str(btd_adapter_get_address(adapter), addr);
+
+	/* Just create socket and advance to the configured state
+	 * (when defer = true)
+	 */
+	if (defer == true) {
+		io = bt_io_connect(bap_connect_io_cb, ep, NULL, &err,
+				BT_IO_OPT_SOURCE_BDADDR,
+				btd_adapter_get_address(adapter),
+				BT_IO_OPT_DEST_BDADDR,
+				&dst_addr,
+				BT_IO_OPT_DEST_TYPE,
+				BDADDR_LE_PUBLIC,
+				BT_IO_OPT_MODE, BT_IO_MODE_ISO,
+				BT_IO_OPT_QOS, qos,
+				BT_IO_OPT_BASE, &base,
+				BT_IO_OPT_DEFER_TIMEOUT, defer,
+				BT_IO_OPT_INVALID);
+
+		if (!io) {
+			error("%s", err->message);
+			g_error_free(err);
+			return;
+		}
+
+		ep->io_id = g_io_add_watch(io, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				bap_io_disconnected, ep);
+
+		ep->io = io;
+
+		bt_bap_stream_io_connecting(stream,
+						g_io_channel_unix_get_fd(io));
+	} else {
+		/* TODO: Advance stream state to Streaming */
+	}
+}
+
 static void bap_listen_io(struct bap_data *data, struct bt_bap_stream *stream,
 						struct bt_iso_qos *qos)
 {
@@ -989,22 +1147,51 @@ static void bap_create_io(struct bap_data *data, struct bap_ep *ep,
 	if (!queue_find(data->streams, NULL, stream))
 		queue_push_tail(data->streams, stream);
 
-	if (!bt_bap_stream_io_get_qos(stream, &qos[0], &qos[1])) {
-		error("bt_bap_stream_get_qos_links: failed");
-		return;
-	}
-
 	memset(&iso_qos, 0, sizeof(iso_qos));
-	iso_qos.ucast.cig = qos[0] ? qos[0]->ucast.cig_id :
+
+	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_UNICAST) {
+		if (!bt_bap_stream_io_get_qos(stream, &qos[0], &qos[1])) {
+			error("bt_bap_stream_get_qos_links: failed");
+			return;
+		}
+
+		iso_qos.ucast.cig = qos[0] ? qos[0]->ucast.cig_id :
 						qos[1]->ucast.cig_id;
-	iso_qos.ucast.cis = qos[0] ? qos[0]->ucast.cis_id :
+		iso_qos.ucast.cis = qos[0] ? qos[0]->ucast.cis_id :
 						qos[1]->ucast.cis_id;
 
-	bap_iso_qos(qos[0], &iso_qos.ucast.in);
-	bap_iso_qos(qos[1], &iso_qos.ucast.out);
+		bap_iso_qos(qos[0], &iso_qos.ucast.in);
+		bap_iso_qos(qos[1], &iso_qos.ucast.out);
+	} else if (bt_bap_stream_get_type(stream) ==
+			BT_BAP_STREAM_TYPE_BROADCAST) {
+		if (defer == true) {
+			iso_qos.bcast.big = ep->qos.bcast.big;
+			iso_qos.bcast.bis = ep->qos.bcast.bis;
+			iso_qos.bcast.sync_interval = ep->qos.bcast.sync_interval;
+			iso_qos.bcast.packing = ep->qos.bcast.packing;
+			iso_qos.bcast.framing = ep->qos.bcast.framing;
+			iso_qos.bcast.encryption = ep->qos.bcast.encryption;
+			memcpy(iso_qos.bcast.bcode,
+					ep->qos.bcast.bcode.iov_base, 16);
+			iso_qos.bcast.options = ep->qos.bcast.options;
+			iso_qos.bcast.skip = ep->qos.bcast.skip;
+			iso_qos.bcast.sync_timeout = ep->qos.bcast.sync_timeout;
+			iso_qos.bcast.sync_cte_type = ep->qos.bcast.sync_cte_type;
+			iso_qos.bcast.mse = ep->qos.bcast.mse;
+			iso_qos.bcast.timeout = ep->qos.bcast.timeout;
+			memcpy(&iso_qos.bcast.out, &ep->qos.bcast.io_qos,
+						sizeof(struct bt_iso_io_qos));
+		}
+	} else
+		return;
 
 	if (ep)
-		bap_connect_io(data, ep, stream, &iso_qos, defer);
+		if (bt_bap_stream_get_type(stream) ==
+				BT_BAP_STREAM_TYPE_BROADCAST)
+			bap_connect_io_broadcast(data, ep, stream,
+							&iso_qos, defer);
+		else
+			bap_connect_io(data, ep, stream, &iso_qos, defer);
 	else
 		bap_listen_io(data, stream, &iso_qos);
 }
@@ -1043,12 +1230,16 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 			}
 
 
-			/* Wait QoS response to respond */
-			ep->id = bt_bap_stream_qos(stream, &ep->qos, qos_cb,
-									ep);
-			if (!ep->id) {
-				error("Failed to Configure QoS");
-				bt_bap_stream_release(stream, NULL, NULL);
+			if (bt_bap_stream_get_type(stream) ==
+					BT_BAP_STREAM_TYPE_UNICAST) {
+				/* Wait QoS response to respond */
+				ep->id = bt_bap_stream_qos(stream, &ep->qos,
+								qos_cb,	ep);
+				if (!ep->id) {
+					error("Failed to Configure QoS");
+					bt_bap_stream_release(stream,
+								NULL, NULL);
+				}
 			}
 		}
 		break;
@@ -1059,6 +1250,13 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 		if (ep)
 			bap_create_io(data, ep, stream, false);
 		break;
+	case BT_BAP_STREAM_STATE_STREAMING:
+		if (bt_bap_stream_get_type(stream) ==
+				BT_BAP_STREAM_TYPE_BROADCAST) {
+			if (ep)
+				bap_create_io(data, ep, stream, false);
+		}
+		break;
 	}
 }
 
@@ -1078,6 +1276,21 @@ static void pac_added(struct bt_bap_pac *pac, void *user_data)
 	bt_bap_foreach_pac(data->bap, BT_BAP_SINK, pac_found, service);
 }
 
+static void pac_added_broadcast(struct bt_bap_pac *pac, void *user_data)
+{
+	struct btd_service *service = user_data;
+	struct bap_data *data;
+
+	if (bt_bap_pac_get_type(pac) == BT_BAP_BCAST_SOURCE) {
+		DBG("pac %p", pac);
+
+		data = btd_service_get_user_data(service);
+
+		bt_bap_foreach_pac(data->bap, BT_BAP_BCAST_SOURCE,
+						pac_found, service);
+	}
+}
+
 static bool ep_match_pac(const void *data, const void *match_data)
 {
 	const struct bap_ep *ep = data;
@@ -1118,6 +1331,38 @@ static void pac_removed(struct bt_bap_pac *pac, void *user_data)
 	ep_unregister(ep);
 }
 
+static void pac_removed_broadcast(struct bt_bap_pac *pac, void *user_data)
+{
+	struct btd_service *service = user_data;
+	struct bap_data *data;
+	struct queue *queue;
+	struct bap_ep *ep;
+
+	DBG("pac %p", pac);
+
+	data = btd_service_get_user_data(service);
+
+	switch (bt_bap_pac_get_type(pac)) {
+	case BT_BAP_SINK:
+		queue = data->srcs;
+		break;
+	case BT_BAP_SOURCE:
+		queue = data->snks;
+		break;
+	case BT_BAP_BCAST_SOURCE:
+		queue = data->bcast;
+		break;
+	default:
+		return;
+	}
+
+	ep = queue_remove_if(queue, ep_match_pac, pac);
+	if (!ep)
+		return;
+
+	ep_unregister(ep);
+}
+
 static struct bap_data *bap_data_new(struct btd_device *device)
 {
 	struct bap_data *data;
@@ -1126,6 +1371,7 @@ static struct bap_data *bap_data_new(struct btd_device *device)
 	data->device = device;
 	data->srcs = queue_new();
 	data->snks = queue_new();
+	data->bcast = queue_new();
 
 	return data;
 }
@@ -1158,6 +1404,14 @@ static bool match_data(const void *data, const void *match_data)
 	return bdata->bap == bap;
 }
 
+static bool match_data_bap_data(const void *data, const void *match_data)
+{
+	const struct bap_data *bdata = data;
+	const struct btd_adapter *adapter = match_data;
+
+	return bdata->user_data == adapter;
+}
+
 static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
 							void *user_data)
 {
@@ -1182,26 +1436,50 @@ static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
 
 	g_io_channel_set_close_on_unref(io, FALSE);
 
-	/* Attempt to get CIG/CIS if they have not been set */
-	if (ep->qos.ucast.cig_id == BT_ISO_QOS_CIG_UNSET ||
+	if (bt_bap_stream_get_type(ep->stream) == BT_BAP_STREAM_TYPE_UNICAST) {
+		/* Attempt to get CIG/CIS if they have not been set */
+		if (ep->qos.ucast.cig_id == BT_ISO_QOS_CIG_UNSET ||
 				ep->qos.ucast.cis_id == BT_ISO_QOS_CIS_UNSET) {
-		struct bt_iso_qos qos;
-		GError *err = NULL;
+			struct bt_iso_qos qos;
+			GError *err = NULL;
+
+			if (!bt_io_get(io, &err, BT_IO_OPT_QOS, &qos,
+						BT_IO_OPT_INVALID)) {
+				error("%s", err->message);
+				g_error_free(err);
+				g_io_channel_unref(io);
+				return;
+			}
 
-		if (!bt_io_get(io, &err, BT_IO_OPT_QOS, &qos,
-					BT_IO_OPT_INVALID)) {
-			error("%s", err->message);
-			g_error_free(err);
-			g_io_channel_unref(io);
-			return;
+			ep->qos.ucast.cig_id = qos.ucast.cig;
+			ep->qos.ucast.cis_id = qos.ucast.cis;
 		}
 
-		ep->qos.ucast.cig_id = qos.ucast.cig;
-		ep->qos.ucast.cis_id = qos.ucast.cis;
-	}
-
-	DBG("stream %p fd %d: CIG 0x%02x CIS 0x%02x", stream, fd,
+		DBG("stream %p fd %d: CIG 0x%02x CIS 0x%02x", stream, fd,
 				ep->qos.ucast.cig_id, ep->qos.ucast.cis_id);
+	} else if (bt_bap_stream_get_type(ep->stream) ==
+				BT_BAP_STREAM_TYPE_BROADCAST) {
+		/* Attempt to get BIG/BIS if they have not been set */
+		if (ep->qos.bcast.big == BT_ISO_QOS_BIG_UNSET ||
+				ep->qos.bcast.bis == BT_ISO_QOS_BIS_UNSET) {
+			struct bt_iso_qos qos;
+			GError *err = NULL;
+
+			if (!bt_io_get(io, &err, BT_IO_OPT_QOS, &qos,
+						BT_IO_OPT_INVALID)) {
+				error("%s", err->message);
+				g_error_free(err);
+				g_io_channel_unref(io);
+				return;
+			}
+
+			ep->qos.bcast.big = qos.bcast.big;
+			ep->qos.bcast.bis = qos.bcast.bis;
+		}
+
+		DBG("stream %p fd %d: BIG 0x%02x BIS 0x%02x", stream, fd,
+					ep->qos.bcast.big, ep->qos.bcast.bis);
+	}
 }
 
 static void bap_attached(struct bt_bap *bap, void *user_data)
@@ -1349,6 +1627,70 @@ static int bap_disconnect(struct btd_service *service)
 	return 0;
 }
 
+static int bap_adapter_probe(struct btd_profile *p,
+				struct btd_adapter *adapter)
+{
+	struct btd_device *device = btd_adapter_get_device(adapter,
+						BDADDR_ANY, BDADDR_LE_PUBLIC);
+	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
+	struct btd_service *service = service_create(device, p);
+	struct bap_data *data;
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("%s", addr);
+
+	if (!btd_adapter_has_exp_feature(adapter, EXP_FEAT_ISO_SOCKET)) {
+		error("BAP requires ISO Socket which is not enabled");
+		return -ENOTSUP;
+	}
+
+	data = bap_data_new(device);
+	data->service = service;
+
+	data->bap = bt_bap_new(btd_gatt_database_get_db(database),
+					btd_device_get_gatt_db(device));
+	if (!data->bap) {
+		error("Unable to create BAP instance");
+		free(data);
+		return -EINVAL;
+	}
+
+	bap_data_add(data);
+
+	if (!bt_bap_attach_broadcast(data->bap)) {
+		error("BAP unable to attach");
+		return -EINVAL;
+	}
+
+	data->state_id = bt_bap_state_register(data->bap, bap_state,
+						bap_connecting, data, NULL);
+	data->pac_id = bt_bap_pac_register(data->bap, pac_added_broadcast,
+					pac_removed_broadcast, service, NULL);
+
+	bt_bap_set_user_data(data->bap, service);
+	bap_data_set_user_data(data, adapter);
+	return 0;
+}
+
+static void bap_adapter_remove(struct btd_profile *p,
+					struct btd_adapter *adapter)
+{
+	struct bap_data *data = queue_find(sessions, match_data_bap_data,
+						adapter);
+	char addr[18];
+
+	ba2str(btd_adapter_get_address(adapter), addr);
+	DBG("%s", addr);
+
+	if (!data) {
+		error("BAP service not handled by profile");
+		return;
+	}
+
+	bap_data_remove(data);
+}
+
 static struct btd_profile bap_profile = {
 	.name		= "bap",
 	.priority	= BTD_PROFILE_PRIORITY_MEDIUM,
@@ -1357,6 +1699,8 @@ static struct btd_profile bap_profile = {
 	.device_remove	= bap_remove,
 	.accept		= bap_accept,
 	.disconnect	= bap_disconnect,
+	.adapter_probe	= bap_adapter_probe,
+	.adapter_remove	= bap_adapter_remove,
 	.auto_connect	= true,
 	.experimental	= true,
 };
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 515263af3..185478efa 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -750,6 +750,7 @@ static int parse_select_properties(DBusMessageIter *props, struct iovec *caps,
 	const char *key;
 	struct bt_bap_io_qos io_qos;
 	uint8_t framing = 0;
+	bool broadcast = false;
 
 	memset(&io_qos, 0, sizeof(io_qos));
 	while (dbus_message_iter_get_arg_type(props) == DBUS_TYPE_DICT_ENTRY) {
@@ -781,11 +782,21 @@ static int parse_select_properties(DBusMessageIter *props, struct iovec *caps,
 				goto fail;
 
 			dbus_message_iter_get_basic(&value, &qos->ucast.cig_id);
+		} else if (!strcasecmp(key, "BIG")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &qos->bcast.big);
 		} else if (!strcasecmp(key, "CIS")) {
 			if (var != DBUS_TYPE_BYTE)
 				goto fail;
 
 			dbus_message_iter_get_basic(&value, &qos->ucast.cis_id);
+		} else if (!strcasecmp(key, "BIS")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &qos->bcast.bis);
 		} else if (!strcasecmp(key, "Interval")) {
 			if (var != DBUS_TYPE_UINT32)
 				goto fail;
@@ -840,13 +851,75 @@ static int parse_select_properties(DBusMessageIter *props, struct iovec *caps,
 
 			dbus_message_iter_get_basic(&value,
 						&qos->ucast.target_latency);
+		} else if (!strcasecmp(key, "Encryption")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value,
+							&qos->bcast.encryption);
+			broadcast = true;
+		} else if (!strcasecmp(key, "Options")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value,
+							&qos->bcast.options);
+		} else if (!strcasecmp(key, "Skip")) {
+			if (var != DBUS_TYPE_UINT16)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value,
+							&qos->bcast.skip);
+		} else if (!strcasecmp(key, "SyncTimeout")) {
+			if (var != DBUS_TYPE_UINT16)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value,
+						&qos->bcast.sync_timeout);
+		} else if (!strcasecmp(key, "SyncCteType")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value,
+						&qos->bcast.sync_cte_type);
+
+		} else if (!strcasecmp(key, "SyncInterval")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value,
+						&qos->bcast.sync_interval);
+		} else if (!strcasecmp(key, "MSE")) {
+			if (var != DBUS_TYPE_BYTE)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value,
+							&qos->bcast.mse);
+		} else if (!strcasecmp(key, "Timeout")) {
+			if (var != DBUS_TYPE_UINT16)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value,
+							&qos->bcast.timeout);
+		} else if (!strcasecmp(key, "BroadcastCode")) {
+			if (var != DBUS_TYPE_ARRAY)
+				goto fail;
+
+			parse_array(&value, &qos->bcast.bcode);
 		}
 
 		dbus_message_iter_next(props);
 	}
 
-	memcpy(&qos->ucast.io_qos, &io_qos, sizeof(io_qos));
-	qos->ucast.framing = framing;
+	if (broadcast) {
+		memcpy(&qos->bcast.io_qos, &io_qos, sizeof(io_qos));
+		qos->bcast.framing = framing;
+
+	} else {
+		memcpy(&qos->ucast.io_qos, &io_qos, sizeof(io_qos));
+		qos->ucast.framing = framing;
+	}
+
 	return 0;
 
 fail:
@@ -1169,16 +1242,26 @@ static bool endpoint_init_pac(struct media_endpoint *endpoint, uint8_t type,
 		metadata->iov_len = endpoint->metadata_size;
 	}
 
-	endpoint->pac = bt_bap_add_vendor_pac(db, name, type, endpoint->codec,
-				endpoint->cid, endpoint->vid, &endpoint->qos,
+	if (type == BT_BAP_SINK || type == BT_BAP_SOURCE) {
+		endpoint->pac = bt_bap_add_vendor_pac(db, name, type,
+				endpoint->codec, endpoint->cid,
+				endpoint->vid, &endpoint->qos,
 				&data, metadata);
+	} else {
+		endpoint->pac = bt_bap_add_vendor_pac_bcast(db, name,
+				type, endpoint->codec, endpoint->cid,
+				endpoint->vid, &endpoint->qos,
+				&data, metadata, &pac_ops, endpoint);
+	}
+
 	if (!endpoint->pac) {
 		error("Unable to create PAC");
 		free(metadata);
 		return false;
 	}
 
-	bt_bap_pac_set_ops(endpoint->pac, &pac_ops, endpoint);
+	if (type == BT_BAP_SINK || type == BT_BAP_SOURCE)
+		bt_bap_pac_set_ops(endpoint->pac, &pac_ops, endpoint);
 
 	DBG("PAC %s registered", name);
 
@@ -1198,6 +1281,12 @@ static bool endpoint_init_pac_source(struct media_endpoint *endpoint, int *err)
 	return endpoint_init_pac(endpoint, BT_BAP_SOURCE, err);
 }
 
+static bool endpoint_init_broadcast_source(struct media_endpoint *endpoint,
+						int *err)
+{
+	return endpoint_init_pac(endpoint, BT_BAP_BCAST_SOURCE, err);
+}
+
 static bool endpoint_properties_exists(const char *uuid,
 						struct btd_device *dev,
 						void *user_data)
@@ -1300,6 +1389,18 @@ static bool experimental_endpoint_supported(struct btd_adapter *adapter)
 	return g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL;
 }
 
+static bool experimental_broadcaster_ep_supported(struct btd_adapter *adapter)
+{
+
+	if (!btd_adapter_has_exp_feature(adapter, EXP_FEAT_ISO_SOCKET))
+		return false;
+
+	if (!btd_adapter_has_settings(adapter, MGMT_SETTING_ISO_BROADCASTER))
+		return false;
+
+	return g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL;
+}
+
 static struct media_endpoint_init {
 	const char *uuid;
 	bool (*func)(struct media_endpoint *endpoint, int *err);
@@ -1313,6 +1414,8 @@ static struct media_endpoint_init {
 				experimental_endpoint_supported },
 	{ PAC_SOURCE_UUID, endpoint_init_pac_source,
 				experimental_endpoint_supported },
+	{ BAA_SERVICE_UUID, endpoint_init_broadcast_source,
+			experimental_broadcaster_ep_supported },
 };
 
 static struct media_endpoint *
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 82f5fa6fe..fac8261bf 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -526,6 +526,13 @@ static void media_owner_add(struct media_owner *owner,
 	owner->pending = req;
 }
 
+static void *get_stream_bap(struct media_transport *transport)
+{
+	struct bap_transport *bap = transport->data;
+
+	return bap->stream;
+}
+
 static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
 					void *data)
 {
@@ -541,15 +548,24 @@ static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
 		return btd_error_not_authorized(msg);
 
 	owner = media_owner_create(msg);
+	if (bt_bap_stream_get_type(get_stream_bap(transport)) ==
+				BT_BAP_STREAM_TYPE_BROADCAST) {
+		req = media_request_create(msg, 0x00);
+		media_owner_add(owner, req);
+		media_transport_set_owner(transport, owner);
+	}
 	id = transport->resume(transport, owner);
 	if (id == 0) {
 		media_owner_free(owner);
 		return btd_error_not_authorized(msg);
 	}
 
-	req = media_request_create(msg, id);
-	media_owner_add(owner, req);
-	media_transport_set_owner(transport, owner);
+	if (bt_bap_stream_get_type(get_stream_bap(transport)) ==
+				BT_BAP_STREAM_TYPE_UNICAST) {
+		req = media_request_create(msg, id);
+		media_owner_add(owner, req);
+		media_transport_set_owner(transport, owner);
+	}
 
 	return NULL;
 }
@@ -1483,13 +1499,6 @@ static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
 	bap_update_links(transport);
 }
 
-static void *get_stream_bap(struct media_transport *transport)
-{
-	struct bap_transport *bap = transport->data;
-
-	return bap->stream;
-}
-
 static void free_bap(void *data)
 {
 	struct bap_transport *bap = data;
@@ -1560,7 +1569,8 @@ struct media_transport *media_transport_create(struct btd_device *device,
 			goto fail;
 		properties = a2dp_properties;
 	} else if (!strcasecmp(uuid, PAC_SINK_UUID) ||
-				!strcasecmp(uuid, PAC_SOURCE_UUID)) {
+				!strcasecmp(uuid, PAC_SOURCE_UUID) ||
+				!strcasecmp(uuid, BAA_SERVICE_UUID)) {
 		if (media_transport_init_bap(transport, stream) < 0)
 			goto fail;
 		properties = bap_properties;
-- 
2.34.1

