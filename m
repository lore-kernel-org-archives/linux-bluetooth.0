Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5B8C04A6A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Aug 2023 16:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344886AbjHPQrB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Aug 2023 12:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344905AbjHPQqg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Aug 2023 12:46:36 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2074.outbound.protection.outlook.com [40.107.22.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7412D5A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 09:46:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0cfcEeZQ9PrjQ+0s2idUDQHQREWpxgZDZaZ3bPr/0YNwFKUkV7YEvyuHln8kOiign92UMqzhsyyJfV97J4abFBjFFWe9FCk23qDcNMTg2FdxuRjRd5lBKlB+34xlb66yjsd3ST/Vq0VohqyChzgkEYfHNHe9W5Ia18NTezLs7sR7t+YbJstLCPeEa9TBuf32019Fxu5levLUuDCBNuV1pWGY/HWL68XWcjD5ralX0j3ghvr9pHfuqKu90O7R/8fbk+FFnFzaYF2v7LTwpztuvMiLm25YxyVetWKL+UEyPoQ9T93TQHmNtz15DgtPiQ/puddwCbX/NSRLP4W8lA/6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zk51XRdRPoiZL44px+EVPmHqBQQJJ3OpxPpz0oXCnuk=;
 b=GODxVyfjwIPa8ZEWjuxqGkIMNsdmGkpHUXG9uoTS81+5P8qt82J+znB1H3nPvKr9Bbczm/6ZtVFSzcIsn2nxNFWfN+PwuTVhUTugMAwnHe5XGvG/2YJLLa0ZrEX8BdMutuR4bk/i8KumfzBbZ9zwJ2gFX6S2mJFyNRpq6TTKKbr3w4+JWbyJ+9buywt13d8hGpgtxqACi1jj2rYLpamLW/PXeTw+ouGZ1DIYTDGprNTF/kRFVTyFYkL0uB92V+pwmFHFm5GEPecOshsc3NeXYC/44cB9TyW5C+Z0cORlgh7n90umGC7QroUUU8g28c270xqOa0NT2BTt1KRSRkf3tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zk51XRdRPoiZL44px+EVPmHqBQQJJ3OpxPpz0oXCnuk=;
 b=WQh5gmNaZb6GvxXXmK4FVrB2gezFLMtGvZ34ouGxa7UmKRdi8Jy6UJkWug+PU92xReenfu2iwKB3E9clp/zFvoo9BJ8JduG7pvLwxt2Sf9LKMa+D/KDQQV8BhJJpeIyDzO6mHCjj/0Dj1tBZvMYw0idVf5+/pqIiU50DlA4inC0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AM7PR04MB6997.eurprd04.prod.outlook.com (2603:10a6:20b:10d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 16:45:18 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 16:45:18 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v6 3/7] media: Add broadcast sink media endpoint
Date:   Wed, 16 Aug 2023 19:44:31 +0300
Message-Id: <20230816164435.5149-4-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816164435.5149-1-claudia.rosu@nxp.com>
References: <20230816164435.5149-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0047.eurprd03.prod.outlook.com
 (2603:10a6:803:118::36) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|AM7PR04MB6997:EE_
X-MS-Office365-Filtering-Correlation-Id: a9456e09-69d4-4144-865c-08db9e782c33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k4c6u7Dlbci3mKmy29xlYdQn+wUKbZoOVJSyhOBGEx0ta9+p5y1Z7MkvaWxB5yYa0Tjpmu06I56NA9UhsYIPWqy7YktPhnX7HPAVBnFdtYplVOZFgL+jhweAfZhUdGRa+jsP54t1zUkdItQoOnEI6mCaXK7bYba0Gu/c8tYjTkaOnEuXzDGERZoaXq+XNN6ICc7fZNQVIkaSereiIm531sJ6tmMTyKkTJEnofj29hrtbqQiZmbwdliOnhXIbtjOKTiL8+d7hq5VT0tG49fe5wTgKJgrztj3Nb2/4GacexXxSY6wgEEFV0PRZIyjtUSk/v33amevPjW1I5uFz+EyoJSmw6oCPcFt0foXrlJ8bz8d/Z+Ui/1R3A70uxUTwnr7GoKA54vzYk7OgCbe9FLtCXsSytmEFbNS/8/GX76toDVr9m5rvuxy/4FJLDax+xgiJoCtQFgtzEWucSRV/UjingGMZLYJcRf7pdljgQJYzctqrj5OuVIhwUi8Z6hCxm5O0rfDxORyrEp2GE8dly2qjanTxiF/a5rwI00k/8pl++5u5AREywOjpm/y6ya4UAHOn4YEpjMpKSRsvsog3piIymik5fXyefwMvdfqqp0X/pXfcRYMl/sc4BIjDRV3PXiiA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(6916009)(66946007)(66476007)(66556008)(41300700001)(5660300002)(38350700002)(38100700002)(8676002)(4326008)(8936002)(2906002)(83380400001)(26005)(478600001)(86362001)(6512007)(52116002)(6506007)(36756003)(6666004)(1076003)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2Aq758luXeSrM7nS3yp9eBA3U9bj2rRcZZzfu/vLN++rJe1KjOv+fDYIEX9L?=
 =?us-ascii?Q?Iz8kumRuK9yR1bjRX2AKrLg43LzU+yBqumDR3XOvn5M1SQotznF/+96pEfzQ?=
 =?us-ascii?Q?iazLVMh9DIF1dgwG3eEnuZ1UrQc4kcCODtF9cfrT4DYBhqqKkBanhmo0h2Hc?=
 =?us-ascii?Q?S/QDHTDq8z+eP6DRRqHbQQnbW0CmPj86JC6wOt9cbAeLj2dYDZeUY9WdZK8l?=
 =?us-ascii?Q?zMNjYh51rfUQ/cicYPfQn9hBQcugMAgvG7/JLw46TVxHoW9qKHm3MFs77RoY?=
 =?us-ascii?Q?bnYOCq6Nq+FpxFG0LPAUTECDbeu5T+1U68VxSBPGAguh7P6ER+jhV+mo71aW?=
 =?us-ascii?Q?c8rCGGqrQHvahyO85quH0nQexT3OSY107CTqf44A57Fcc001kvNIsJm+eQ5t?=
 =?us-ascii?Q?JR2PBjSDls5+enpZktoRBvW2GGl091ZYpZkYl0v7T9BwQSc3bj1geE+gz0Ic?=
 =?us-ascii?Q?G0BXpS5JgFv0XXEaV9ilnKaLmYu091HiN7aUAAU58GJXzwkccCQdqY4f5rli?=
 =?us-ascii?Q?lfiHHpYa8Jm1VER64HH+4+phXtxl7uop/gGaze1Su3eSnTJJ89zIi/qoNgwm?=
 =?us-ascii?Q?+OdSQYHc3+MMlcx/PicaWWfFe2QDhA3KTtFgqxzOUOH0+OdGWbvUesS9FlFM?=
 =?us-ascii?Q?K/Qr6pT1Jf5mwrbj0jw0xRukldd6dDJTZqLeVBiL0ZGYXP7q6QouFus4OxUi?=
 =?us-ascii?Q?kOnQq7XnuHfQnEtYhxjpQfM6P2KMY1m6op5thqNO1nLYCr1wXvwMzOGD4S69?=
 =?us-ascii?Q?hJiQ/LPXA6n4kJ6FL1ugoEIsgi64QPNVKQrp/2x3buNy59zAOs0Tq014SlD2?=
 =?us-ascii?Q?cGbDLR6ZcXez5LG/w6F9ZuDilcn1lZM0mlTrs4RWCJFZ8qR3sG/WwkiEOehD?=
 =?us-ascii?Q?Y8FvT609L5tfHd0HFnQYq/Nl58ymVaib2dMhFx6hmlDXboRB6q6MO+yozNEg?=
 =?us-ascii?Q?wjLxx+OSCgkGYJW2Jse/f1YsRSKSVijypnL1OZ6l75t9M3VHx4AskgAGCwav?=
 =?us-ascii?Q?Uv4C6HPK6VgMbc4468pHB+MWWIzWdeprx3YA10G3g0eZKG7qx2cqTITV13s9?=
 =?us-ascii?Q?HtzDBmj8InJ/e1oxAxPCFUMGOAf7isnAccCBliPhBPy3kCXH9Rxl6TtxpISo?=
 =?us-ascii?Q?fZSgPiTMt9DO26C+qmlkE0PrJujXD4Izneo7+4z7ajgxFfbUwGofxewDHHEb?=
 =?us-ascii?Q?/9xnnHcimEEXvBwwmiUBfRNetJaLYw4lFZ4B0JEkiIp/TL4eUo3V2bAQlskw?=
 =?us-ascii?Q?ujPz6ffmD1XM9ocsjq2EiY1MxhLQo7KlR8rETEuUTBr04H7s/AEeO7jK6B7h?=
 =?us-ascii?Q?MNbIyaAsompTiVL02t/zfmIeeisLipH++aO69rw1thRCC6M+PhetMKJFazNy?=
 =?us-ascii?Q?AK1G8i9jEzShvPGW3qHDhwW+iAea+ugsrkEpkzl+viPDwFAGlY5SHzM1EiML?=
 =?us-ascii?Q?+1i6OGvU9jz8qYZi0/ReLMZ7t6TIGqMUVxJGJfrTYAZDjaE+sgRiuOHJQO8l?=
 =?us-ascii?Q?jMAt8I0mCotQsSSMKcrTTbh41ZMF5iTJsjkKwJ0cfiRS00s+MfFH3XPCq1oA?=
 =?us-ascii?Q?5rg+A2bbpquZExags6roBLU59SVbOSqoUYny9wpV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9456e09-69d4-4144-865c-08db9e782c33
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 16:45:17.9540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n6XlWdYJ3pXoQ68bUfwz3Erq3YNue0KthYDIHwZ5qnfN/f1PAmcQeNgPIEtxVxaMrkX7dZcT/7luv2IX7SV30A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6997
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

