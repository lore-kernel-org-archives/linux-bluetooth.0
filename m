Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC50FEE4996
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Aug 2023 15:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbjHUPvu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Aug 2023 11:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbjHUPvu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Aug 2023 11:51:50 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D33F3
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 08:51:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0pffoNgJJFdOstN2XBQgzfkjjsQ3KkleCyNMqEpaLH4Vf0MGb70jAFD3Dv/5wFLBjmSV1Hf3U0Nlmj4l/6xukKqF2YHC3yhP2aE/t1Fk0coZxE9QWIdCbHh3vbLvFUoUp0oHjWKs4OVVy2y/Qgk+C9Wiu6fKkmRjfdYS1oYC5cfCfaeyS8RTaOF8cuDdNjioLD3MOP2f9TLiC9rUheKgK6cC3N5E7ALL+8w8h0iuJwZgxeeBio9U9eTckez6799W85n5Ji0tv+FyPvHaB26B+33q0J5FHG6+zE19hRFDQ65AE/qLWlcHMO5qGPacu8ofvEgg9dSXp2bQ9j/TxqQmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7He6Dog5FMn1fYWSNp8KmvZpTnrkqJdC40wBPVct2Yc=;
 b=lt9M6r1NuDGeou1HHf8JjbD4nZgQOpV+Fbyx1bVpbZTKt3digImg3fwGO+hFUyL8bOJhktB4JTVucs1UXewk/Cm4FlxUTMMfbABTUjZvnud2sY5sohx4Hj5GfF1vKcpsNSxxS4M1pE2nwnqls2nHC6hG4QDZcrOCN8qAdpBZnZoW8iQUf2LfCTFRl+xycNaAsSFBg1vTqV//LoVErdxEMMG2ls6crdX5OHN4QI26iB+NB83yH5nlfgZRrb5IHQOdGoIjYNeuE8R2tlOrBjpxFd8KINIcf7ZKU2BtayKnzPPaF9Dj4NslPtyyENdMk7eLYIoe5dc4Q1E5hD9k4u5Sdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7He6Dog5FMn1fYWSNp8KmvZpTnrkqJdC40wBPVct2Yc=;
 b=l/80wHVF44T6wfnR2xfw500gRpHTCN9WpS8mgFX6H6K6PfA6cOo+iGSjSxC5WLcEUeQHuqjesuSV/unbw6u8gEXDZyzmnthQLKjqzQwZEoUtyrTui72MH9SewM+qdXJ/TgryaFkKoHeH9QkRg+FWhi+gLYwEXdE381tXj6TB4Es=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by DU2PR04MB9116.eurprd04.prod.outlook.com (2603:10a6:10:2f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 15:51:40 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 15:51:39 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v7 3/6] media: Add broadcast sink media endpoint
Date:   Mon, 21 Aug 2023 18:51:01 +0300
Message-Id: <20230821155104.86954-4-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821155104.86954-1-claudia.rosu@nxp.com>
References: <20230821155104.86954-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0127.eurprd04.prod.outlook.com
 (2603:10a6:208:55::32) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|DU2PR04MB9116:EE_
X-MS-Office365-Filtering-Correlation-Id: 38155ef2-7ce0-47ec-e308-08dba25e8154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P6w67hBYoe4ypJ1yk3jMNFPFXXm0BGq1VH+FyeeubGNlFAbCk/TyKHfCRHKMfkuZ7aF6ss/d3idxyqE7M7sCMGQTpPaw9QQhsXBy0x4V1XaFYBesOZgOllE8ToWKZxGsK0AgF4Ndupr8n3hhi9j1+tOLh5dmVrwNugBoCivck3NNqijTvkcjzaho8OXnI4FtbTn/B/swwYByvYUhwIPyiO/iYsJEESBeCQ6/5wn1p/00yhKieUmdS4rPWVjcHEcdiT5A+xcPUrvv69RBCBuzJlZ7DpcCJfkVaz4reTGKepAv80yuFWqdb+0Epd66ZNAv/19I2qlrd/u0y1NnyEyTo3TfLKtGNkYfqEu/kAucN3bwevwk9mvGO2OHY1XGDuVJWfPKX11CS8oaK2yymtm0TreOkNl2gIRoopt0k2JPoZpkRfzFPXtiwSrLSn7Ne8g99r83BKszZhwve5mrjjz8Jg00S6EjUfLAvL/vjGvLVYFzkOWJnpSqOVm6Q5JKxJEYr/PcCkIkgzibTrv+dVFIAfM6JJqAR3FQI/U6sn3e6lZDlzM7LEyk7VfseJTrJN9+Lh4PsgVpfpnK++1AqfxeDnIl1uwTClZd473CqSUwt0bhnFbhVLuIfSjVG4l1Odbg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(52116002)(38350700002)(38100700002)(6506007)(6486002)(83380400001)(5660300002)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(316002)(66946007)(6512007)(6916009)(66556008)(66476007)(478600001)(6666004)(36756003)(41300700001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AkhOCUD510ZQ97dHNVCCeHryN3AnAbxa3dzTplHBeAuE/uFcyDrTIC1Pnoyq?=
 =?us-ascii?Q?LR5YeaL03wqs5fzUidqeFC1kM/zrriL75AwW7QDTWN4CBdzqxby1GGJ61Dxa?=
 =?us-ascii?Q?x+wmGQ5i9wqz8klWjjULItxdcL3FosJ6ARLQ/tBsDMRQuNzEjcYkupNn1bY9?=
 =?us-ascii?Q?zzt0mF0+TL6F0+tEIObpIuq4DRP9qbmLfRnzCY3uBrfHlMGytwmMpaf+1ruB?=
 =?us-ascii?Q?5Udm07jAmKBZbzznqdaA4GzbdKTKnjJe/O80Wd3TatMv0dP5x89mj6nbfEy3?=
 =?us-ascii?Q?JH7viyZSv7if8LawpIiW3J738fYm/JxH2uzIU/UA74XrLfnnueHYQAe2vpnl?=
 =?us-ascii?Q?Ft9fhLz2Kwy7Vi/ij//+u4ROg9Orzas20KtbMoAYR8rUkZjCpiOrnc2tOuBA?=
 =?us-ascii?Q?4rG7qlHgK9s5ZfHerraPRkQMVIJLk7ROZ7QTcYgNNivnYjCSMSwQyKdJ22Jm?=
 =?us-ascii?Q?wsQIAeADcV5q1p5qcSoDjcS7jmXmuW1TqQ4mksgNlRxxTddRygihqGt6gUX9?=
 =?us-ascii?Q?kn1cWko+SYekTDLeT3pJPK5Q9N2mU9txPh3E0LN72Uo3DrcVHikvorHDxl6r?=
 =?us-ascii?Q?3oS7PJo1MSvJiuiA86/MW8WORMdXQdXIr+YYbF0/At/K1/cQjMrwRCzuH5ee?=
 =?us-ascii?Q?omBjPrkhxf9qeRcggBktFKBuys1iYLiotai2jtrn9Kga7DnwHSvzZ77XLSPj?=
 =?us-ascii?Q?2TqLo4+mg0qaK1sdyqYM+gV7wv1OHD/YOLC3BGgsy20Dyorj5yJwNsO7VUFV?=
 =?us-ascii?Q?4ogx5Wqb7gHO9/vwNizjthDKSkctmXZal3UujpJRVtuXQMzDDRnIgRn+2wYa?=
 =?us-ascii?Q?LFikdwJGYhajzDMyWk8hYYffOXfExagyqvM/CoJ6xPNyumXg2cm0lHBHBmtC?=
 =?us-ascii?Q?OJnKHxJXjExcnCU4KjjWfBViVbb+wX5XBD3w0bGjW2RlKcuxIebwU2umvQM3?=
 =?us-ascii?Q?f6hdq7IMUBW9fsHZiS8weJ8olti8v110a2lrQqk0cXUkwrytEOHbROE7XT8H?=
 =?us-ascii?Q?UR3ZiTRBOVNTAkLJkCNf5iDjPbxsQyGOsQkk9wy//UcV/DJUp+dINmXjfOsi?=
 =?us-ascii?Q?zsc2W5iF9yIOYK/Y4KZIxyzW0eeE+/VRjQUMBpXdAYNzNzyoJegPv2d2Ffe+?=
 =?us-ascii?Q?DXVYUrVyVo6exxJsdNgMtNbN5gfE8yCenvqbJvnrVVVbSB24i8C9CDHhVsa+?=
 =?us-ascii?Q?Z11SEVZHgCofLDiwXJcsOVYnu34Uy4AoRcTtE2nGGl4ntrfO6A+Sninnk7oS?=
 =?us-ascii?Q?06qnCROFgvgecuRoamBLlCVzaDwIau8R9itFazbYUNhDj1/ThiN0h0RaB0rY?=
 =?us-ascii?Q?2JpylLXjyserG6I33uooy3aOLM8urpySSBp7jcafwZHwbQ974/o2B/rSEB3D?=
 =?us-ascii?Q?jha96bwdtQTJ5ovQ3kySjTfFg2+BB1qaPT6FbOpfrzWPEluGf+++iO8eL5Sa?=
 =?us-ascii?Q?mHw7ZvLSDjMJ0+i7SgmiTC0WuwaAFosevC9nqkDB942Wi7zFyLmCxTQhBwYX?=
 =?us-ascii?Q?6iBAfMhOCI6jVtNwrGki7C+kuA76ExbLshBfRHvUmSsx0HTCQdGAxsSp3JaY?=
 =?us-ascii?Q?baSe+7I3uVleEX98moOyDELAYGjARhn/nvCxlX+b?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38155ef2-7ce0-47ec-e308-08dba25e8154
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 15:51:38.9060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Br2O1ZHwklf655TYJmjAwIpjcMb0+BQnMOfGS5SrvzP98aohgjynDcNl9SMiWR7+tpbap98ZuyOjTLPZY07e9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9116
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds the possibility to register a broadcast
media endpoint if the controller has support for ISO Sync Receiver.

---
 profiles/audio/media.c | 42 +++++++++++++++++++++++++++++++++++++-----
 profiles/audio/media.h |  3 ++-
 2 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 15c64c8d6..66f512e00 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1058,17 +1058,21 @@ static struct media_transport *pac_bcast_config(struct bt_bap_stream *stream,
 						struct media_endpoint *endpoint)
 {
 	struct bt_bap *bap = bt_bap_stream_get_session(stream);
-	struct btd_adapter *adapter = bt_bap_get_user_data(bap);
+	struct btd_adapter *adapter = endpoint->adapter->btd_adapter;
+	struct btd_device *device;
 	const char *path;
 
-	if (!adapter) {
-		error("Unable to find adapter");
+	if (!adapter)
 		return NULL;
-	}
+
+	if (!strcmp(endpoint->uuid, BCAA_SERVICE_UUID))
+		device = NULL;
+	else
+		device = btd_service_get_device(bt_bap_get_user_data(bap));
 
 	path = bt_bap_stream_get_user_data(stream);
 
-	return media_transport_create(NULL, path, cfg->iov_base, cfg->iov_len,
+	return media_transport_create(device, path, cfg->iov_base, cfg->iov_len,
 					endpoint, stream);
 }
 
@@ -1238,6 +1242,12 @@ static bool endpoint_init_broadcast_source(struct media_endpoint *endpoint,
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
@@ -1351,6 +1361,17 @@ static bool experimental_broadcaster_ep_supported(struct btd_adapter *adapter)
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
@@ -1366,6 +1387,8 @@ static struct media_endpoint_init {
 				experimental_endpoint_supported },
 	{ BCAA_SERVICE_UUID, endpoint_init_broadcast_source,
 			experimental_broadcaster_ep_supported },
+	{ BAA_SERVICE_UUID, endpoint_init_broadcast_sink,
+			experimental_bcast_sink_ep_supported },
 };
 
 static struct media_endpoint *
@@ -3245,3 +3268,12 @@ struct btd_adapter *media_endpoint_get_btd_adapter(
 {
 	return endpoint->adapter->btd_adapter;
 }
+
+bool media_endpoint_is_broadcast(struct media_endpoint *endpoint)
+{
+	if (!strcmp(endpoint->uuid, BCAA_SERVICE_UUID)
+		|| !strcmp(endpoint->uuid, BAA_SERVICE_UUID))
+		return true;
+
+	return false;
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

