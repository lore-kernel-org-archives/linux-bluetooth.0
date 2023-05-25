Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40E4C77B7E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 May 2023 15:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241776AbjEYPfY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 May 2023 11:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241727AbjEYPfX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 May 2023 11:35:23 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2070.outbound.protection.outlook.com [40.107.14.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1403718D
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 May 2023 08:35:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKFFkrzl5QDgCfzkoB7bdpN01vaTIBdPlu538UZk17pKTq3yYVeWXXsEppfXzlQzoxqG/newp2UuBx1XbqkTB2P9FUPDDioF3wLPwJgTTda9eRCxRJOXS3iBe74s6997EC0DP5BLj4zlkp3BeKsYq+bxjJV4QuiUB25CwczDJXYWUkMIu/QeukeXau4lCWhOs1/6VWC7Wo/grFn/EPTDiUV5NbDQkyKg6arUKGfHb1TYWObt4/m6jW2I71XjLKnAcsFok/HsIzxV3CdkU6vofDVswhR3oopCIW+20B3PSSzLTNnFzjv/a5FPoKuzuY0XEg0MBrt8Joh5b/HggpYi5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQbYIRTkxw37VSnatKWXNe812iiKSwLGWfDfC2poVcg=;
 b=douF0x1YOtCaj18LA9b2zGIIuXA+fQaAPTxu4YZ/Fn+yG5W7OTxou+nod/Rr+ZJEAGAsKPcU1OZkpj6ACZtEx7Bp4eRBTp3RA5BqGbnqncywcG4sdSsZasLLWM2+gEYniMeLEzWk6SCeCRz/kUKnf1wSzTZGkvfASJJ9AEvnsruzbpTtdh5PvvFyQNw7hPvwHbP2mBbkXGqDVIH/VQjdvOMV9sItkVfTGWyxwBkIZP3TwiNiMcNRiNKl3avgxKj8PMrnPdMeaL2e7QCyguphPaGR4PrNxSYsd2/b46gcxKox+vwNzx6GbYpD5ihReFMaZ1ViK8J5ViQnKXKdbREtsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQbYIRTkxw37VSnatKWXNe812iiKSwLGWfDfC2poVcg=;
 b=QR1p6S2VDXOzzu9TLFtFjWeiK8Rx8BEtV0H4m8SHn+lEKBVNkwrbl06NsIrN7+biG5cVW3PYkxGP88x876hj/ljgigO1Yh8Xof++0u4l97py5tpnJl5GUAPgNM1XZn8T0KlmbMxSKhMWy/5VRgaQaD5Mfd4z7jC/IP5ZQxbhlkY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by AS8PR04MB7848.eurprd04.prod.outlook.com (2603:10a6:20b:288::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Thu, 25 May
 2023 15:35:18 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::981d:d04a:5851:1578]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::981d:d04a:5851:1578%4]) with mapi id 15.20.6411.029; Thu, 25 May 2023
 15:35:18 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Subject: [PATCH v2 5/6] Update bluetoothctl with support for broadcast source
Date:   Thu, 25 May 2023 18:34:51 +0300
Message-Id: <20230525153452.125789-6-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525153452.125789-1-silviu.barbulescu@nxp.com>
References: <20230525153452.125789-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0001.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::15) To VI1PR04MB5344.eurprd04.prod.outlook.com
 (2603:10a6:803:4b::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:EE_|AS8PR04MB7848:EE_
X-MS-Office365-Filtering-Correlation-Id: bc3e5e08-8ad7-4573-ec5f-08db5d35a4c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: novrgXT5CoFWhL0Gu6g2Cvk+0n4JNrFcP0xvhZ2wgf7MaZrSGpCGEyNrludmfteEPE/L06sFmDzQEvlDW9E/fNU5h+YK6dhh92JPoTYMNTkh3J6ot+ZmQs4US+XefgEabi9XXdvRJmY6J16MlImPahdQvEodIxbtWn3ZJ8ylFiuOEPo3/gCIjKnL6QJXlFPP0qfqYG3+mGVJajMji9/YtRsDMyYCzNJ6AVEklXmH+k5h7U8ht2VAQOttpyQkjksLaZVOsunQF3YdNa4oe5PaFv2/aCmyEpM42chfU+oRiR+hAOJ8vy1T5iSGFILNj5ruUvk8HFKMhJYQ1d7LnjXeF36lKS3q9LG9yp1YweikjLjSGqkwC9yUhvogFrHjYBIFhw7YNl1+ZTPeRt66WmGOUo6cMeBfovqqCCmzodmdeN/BQBRM3MUv0TZt2g6Bd80b5mp4nGdX8xldx/3ivibvQnMsNUtSrWyDaeW/XdVDp2Zy97BfMZaGdEQXS6WTCEdZQeTHodroQ/sgMA8Tz5za3cBb+wBSQOkaDWqZk9DHpKp1HFpkO+I/kpk686dRAbhnXoqovNktyKz1T2UaQfvs1DGe5WfXWlZYWBDJSXH2VkUGMJaQUMKI9w6Q4Y5K7j77
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(451199021)(5660300002)(36756003)(186003)(2906002)(2616005)(30864003)(8936002)(6512007)(1076003)(6506007)(26005)(55236004)(478600001)(66946007)(66556008)(66476007)(6916009)(86362001)(4326008)(8676002)(38350700002)(38100700002)(41300700001)(83380400001)(316002)(52116002)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LVxi0SWTK4H32RIvJdZcAkYOnlVIG9bSG4f7vvUgde1wE6lMPuNx82uyY4Ae?=
 =?us-ascii?Q?MirrWOfURA1KWCfPDe0CJWxAeLpknwfDzs0sz6cmHC4ryp0+B9f2JLYbYGRo?=
 =?us-ascii?Q?DOhvLunV6ArGvLpWtr2uktILtjQ4YFyTZnriIIW3mI1Q09SHqWb4MOwsL5JK?=
 =?us-ascii?Q?N50+zs4Rir9Htz2VG73VMLecwiJUjHreft8f0VK04ZQu2aVZ8MHZocJc6j4j?=
 =?us-ascii?Q?JVM68o6eab/xdzUhNFooqFYgjyvkwfNH5lz0ns6lK74C9Q4ipwnD0sz9z5bI?=
 =?us-ascii?Q?58T7WsRoC5PlMu1jCtHqmoROyyv51V2yPDvJWW6UntjtEXTPQ0TEjLGagqiR?=
 =?us-ascii?Q?xqnbNOFwkzrrue+ET5MuDNCYnUJbCU0wg8iB3KjJ8BefzuckzdKnBc1qH8nW?=
 =?us-ascii?Q?82I/CALeH5D8K2E2A5OtqggmVKGDOTRrMcJjseN0XhMhY6ipPKckPY+F2Vin?=
 =?us-ascii?Q?Xj2LReIsNw4X8XkSwyKgjaGty2m8bhdnEJS3tFvjFd7IGFJGrNL0/4xJdQr/?=
 =?us-ascii?Q?J9SGhEhVMC1lWamNNtF6InIY+kwx2ppQLxHuI1LCXuY4qrPJ76DHicqOya9Z?=
 =?us-ascii?Q?M9bCjivtPEk4McU5KpteCC5U+DSYqTEg089Vm6qsAl2xCVjIXSwjFA5g8llE?=
 =?us-ascii?Q?DkXPagTNz+ye/glNUp09nNhMFabGPQx8lp/+EWTEz9YhOf3a2ilCyB037oXu?=
 =?us-ascii?Q?/nUnJdRGq5CPUAHDm0sYOsye5K0EDplc7/gNwXirQqzDsIK18OdJMDiCU0A8?=
 =?us-ascii?Q?h3qFNNA5o5cC/CC3EFuCyz19v0ALnW9D3GH44LHGbEZN9VGB9HDNzYcNR55D?=
 =?us-ascii?Q?PFPFTAyT03LzeHsgyNlYWsJpl0cP/7at1O3BgkIYrXplkFElSjMh3TAUTvyA?=
 =?us-ascii?Q?ClLIxnEjoh+EDeQUh0S1tsd++rsMazFLyO8QvfTAefoetcE4b0X2FghRFb7T?=
 =?us-ascii?Q?34N0g64g30qj7s66CwT0/lzvK2l9B7SsfgUxTdYnU4vwu/XQfQ+EtRVt27aS?=
 =?us-ascii?Q?T/m7F5bXEzAs6Kt9escByUQrIoiPdaF3RJoHggkA6sqU7vsaVmKjV9NCY0fA?=
 =?us-ascii?Q?AdvA+JtxMjdjNWQTh0Dq+JKKJvKhCHXdD2wngIS8BPPuDieg7TmUKO3ZTZq3?=
 =?us-ascii?Q?e11XP5bE7RW1qFk8FhALxoJ0OPP0ERR9zPh4Vrf8lynKSxuwM4GgkXrmXmPz?=
 =?us-ascii?Q?msin5onrH2TaX5btAsEoUQUR6YgQShZt8eMC3jSu2kL1P/z9bQB+vPTLTgYK?=
 =?us-ascii?Q?+kXD6APqRafkddI1eCf97gp53iA7wgdWKQmSitHtxRhnm2WIQlAOnaVjejlU?=
 =?us-ascii?Q?tD5nOBgi1UysZ6Rctil1whaWWU7N3XdZMegMCdrdavH9QVntcCeTEDlkoY7Y?=
 =?us-ascii?Q?jDSfIPa/GN4u1ED7nccBv2Y0h8xmOZSN7xwTwVDYyNF9t61WBi5n9nD2KQzp?=
 =?us-ascii?Q?DDALsUkxSM77Ws3qYdgb3ei/hMMxY7NZlfVgiRIawUHX7Tuxs4SslyGCSD2D?=
 =?us-ascii?Q?V6nOSdE+4VURk9mGcqPntYVa1mo8oZ7IVUxNgjAUIVjMit/Z2vvlj/FIlkg9?=
 =?us-ascii?Q?fkskVwIuisZFXxk8ioD1Y0BwFPkLfH4BR7L0LurZ1D1WwyJs9Y6X5yC9KZ4I?=
 =?us-ascii?Q?nw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc3e5e08-8ad7-4573-ec5f-08db5d35a4c2
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 15:35:18.3912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cm4CbX9j3yRAonCZsx97FfiaDlKtowpkWnWLhmDkRVfkfVYhukyME2qJldmKQegz4LR36dVfmRuyKctKVSmaTXcVknC+g93Ezt1RxLtd6Lk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7848
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds bluetoothctl support for broadcast source.

---
 client/player.c | 209 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 185 insertions(+), 24 deletions(-)

diff --git a/client/player.c b/client/player.c
index a9f56fb94..408118fca 100644
--- a/client/player.c
+++ b/client/player.c
@@ -74,11 +74,13 @@ struct endpoint {
 	bool auto_accept;
 	bool acquiring;
 	uint8_t max_transports;
-	uint8_t cig;
-	uint8_t cis;
+	uint8_t iso_group;
+	uint8_t iso_stream;
 	char *transport;
 	DBusMessage *msg;
 	struct preset *preset;
+	bool broadcast;
+	struct iovec *bcode;
 };
 
 static DBusConnection *dbus_conn;
@@ -104,6 +106,22 @@ struct transport {
 	struct io *timer_io;
 };
 
+static const uint8_t base_lc3_16_2_1[] = {
+	0x28, 0x00, 0x00, /* Presentation Delay */
+	0x01, /* Number of Subgroups */
+	0x01, /* Number of BIS */
+	0x06, 0x00, 0x00, 0x00, 0x00, /* Code ID = LC3 (0x06) */
+	0x11, /* Codec Specific Configuration */
+	0x02, 0x01, 0x03, /* 16 KHZ */
+	0x02, 0x02, 0x01, /* 10 ms */
+	0x05, 0x03, 0x01, 0x00, 0x00, 0x00,  /* Front Left */
+	0x03, 0x04, 0x28, 0x00, /* Frame Length 40 bytes */
+	0x04, /* Metadata */
+	0x03, 0x02, 0x02, 0x00, /* Audio Context: Convertional */
+	0x01, /* BIS */
+	0x00, /* Codec Specific Configuration */
+};
+
 static void endpoint_unregister(void *data)
 {
 	struct endpoint *ep = data;
@@ -1154,6 +1172,16 @@ static const struct capabilities {
 	CODEC_CAPABILITIES(PAC_SOURCE_UUID, LC3_ID,
 					LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY,
 						3u, 30, 240)),
+	/* Broadcast LC3 Source:
+	 *
+	 * Frequencies: 8Khz 11Khz 16Khz 22Khz 24Khz 32Khz 44.1Khz 48Khz
+	 * Duration: 7.5 ms 10 ms
+	 * Channel count: 3
+	 * Frame length: 30-240
+	 */
+	CODEC_CAPABILITIES(BAA_SERVICE_UUID, LC3_ID,
+					LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY,
+						3u, 30, 240)),
 };
 
 struct codec_qos {
@@ -1435,6 +1463,7 @@ static struct preset {
 	PRESET(A2DP_SINK_UUID, A2DP_CODEC_SBC, sbc_presets, 6),
 	PRESET(PAC_SINK_UUID, LC3_ID, lc3_presets, 3),
 	PRESET(PAC_SOURCE_UUID, LC3_ID, lc3_presets, 3),
+	PRESET(BAA_SERVICE_UUID,  LC3_ID, lc3_presets, 3),
 };
 
 static void parse_vendor_codec(const char *codec, uint16_t *vid, uint16_t *cid)
@@ -1707,6 +1736,27 @@ struct endpoint_config {
 	const struct codec_qos *qos;
 };
 
+#define BCODE {0x01, 0x02, 0x68, 0x05, 0x53, 0xf1, 0x41, 0x5a, \
+				0xa2, 0x65, 0xbb, 0xaf, 0xc6, 0xea, 0x03, 0xb8}
+
+static struct bt_iso_qos bcast_qos = {
+		.bcast = {
+			.big = BT_ISO_QOS_BIG_UNSET,
+			.bis = BT_ISO_QOS_BIS_UNSET,
+			.sync_interval = 0x07,
+			.packing = 0x00,
+			.framing = 0x00,
+			.encryption = 0x00,
+			.bcode = BCODE,
+			.options = 0x00,
+			.skip = 0x0000,
+			.sync_timeout = 0x4000,
+			.sync_cte_type = 0x00,
+			.mse = 0x00,
+			.timeout = 0x4000,
+		}
+	};
+
 static void append_properties(DBusMessageIter *iter,
 						struct endpoint_config *cfg)
 {
@@ -1714,6 +1764,7 @@ static void append_properties(DBusMessageIter *iter,
 	struct codec_qos *qos = (void *)cfg->qos;
 	const char *key = "Capabilities";
 	const char *meta = "Metadata";
+	const char *keyBCode = "BroadcastCode";
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "{sv}", &dict);
 
@@ -1742,16 +1793,25 @@ static void append_properties(DBusMessageIter *iter,
 					DBUS_TYPE_BYTE, &cfg->target_latency);
 	}
 
-	if (cfg->ep->cig != BT_ISO_QOS_CIG_UNSET) {
-		bt_shell_printf("CIG 0x%2.2x\n", cfg->ep->cig);
+	if ((!cfg->ep->broadcast) && (cfg->ep->iso_group != BT_ISO_QOS_GROUP_UNSET)) {
+		bt_shell_printf("CIG 0x%2.2x\n", cfg->ep->iso_group);
 		g_dbus_dict_append_entry(&dict, "CIG", DBUS_TYPE_BYTE,
-							&cfg->ep->cig);
+							&cfg->ep->iso_group);
+	} else {
+		bt_shell_printf("BIG 0x%2.2x\n", bcast_qos.bcast.big);
+		g_dbus_dict_append_entry(&dict, "BIG", DBUS_TYPE_BYTE,
+							&bcast_qos.bcast.big);
 	}
 
-	if (cfg->ep->cis != BT_ISO_QOS_CIS_UNSET) {
-		bt_shell_printf("CIS 0x%2.2x\n", cfg->ep->cis);
+	if ((!cfg->ep->broadcast) && (cfg->ep->iso_stream != BT_ISO_QOS_STREAM_UNSET)) {
+		bt_shell_printf("CIS 0x%2.2x\n", cfg->ep->iso_stream);
 		g_dbus_dict_append_entry(&dict, "CIS", DBUS_TYPE_BYTE,
-							&cfg->ep->cis);
+							&cfg->ep->iso_stream);
+
+	} else {
+		bt_shell_printf("BIS 0x%2.2x\n", bcast_qos.bcast.bis);
+		g_dbus_dict_append_entry(&dict, "BIS", DBUS_TYPE_BYTE,
+							&bcast_qos.bcast.bis);
 	}
 
 	bt_shell_printf("Interval %u\n", qos->interval);
@@ -1759,10 +1819,17 @@ static void append_properties(DBusMessageIter *iter,
 	g_dbus_dict_append_entry(&dict, "Interval", DBUS_TYPE_UINT32,
 						&qos->interval);
 
-	bt_shell_printf("Framing %s\n", qos->framing ? "true" : "false");
+	if (!cfg->ep->broadcast) {
+		bt_shell_printf("Framing %s\n", qos->framing ? "true" : "false");
 
-	g_dbus_dict_append_entry(&dict, "Framing", DBUS_TYPE_BOOLEAN,
-						&qos->framing);
+		g_dbus_dict_append_entry(&dict, "Framing", DBUS_TYPE_BOOLEAN,
+							&qos->framing);
+	} else {
+		bt_shell_printf("Framing %s\n", bcast_qos.bcast.framing ? "true" : "false");
+
+		g_dbus_dict_append_entry(&dict, "Framing", DBUS_TYPE_BOOLEAN,
+							&bcast_qos.bcast.framing);
+	}
 
 	bt_shell_printf("PHY %s\n", qos->phy);
 
@@ -1787,6 +1854,56 @@ static void append_properties(DBusMessageIter *iter,
 	g_dbus_dict_append_entry(&dict, "Delay", DBUS_TYPE_UINT32,
 						&qos->delay);
 
+	if (!cfg->ep->broadcast)
+		goto done;
+
+	bt_shell_printf("SyncInterval %u\n", bcast_qos.bcast.sync_interval);
+
+	g_dbus_dict_append_entry(&dict, "SyncInterval", DBUS_TYPE_BYTE,
+						&bcast_qos.bcast.sync_interval);
+
+	bt_shell_printf("Encryption %u\n", bcast_qos.bcast.encryption);
+
+	g_dbus_dict_append_entry(&dict, "Encryption", DBUS_TYPE_BYTE,
+						&bcast_qos.bcast.encryption);
+
+	bt_shell_printf("Options %u\n", bcast_qos.bcast.options);
+
+	g_dbus_dict_append_entry(&dict, "Options", DBUS_TYPE_BYTE,
+						&bcast_qos.bcast.options);
+
+	bt_shell_printf("Skip %u\n", bcast_qos.bcast.skip);
+
+	g_dbus_dict_append_entry(&dict, "Skip", DBUS_TYPE_UINT16,
+						&bcast_qos.bcast.skip);
+
+	bt_shell_printf("SyncTimeout %u\n", bcast_qos.bcast.sync_timeout);
+
+	g_dbus_dict_append_entry(&dict, "SyncTimeout", DBUS_TYPE_UINT16,
+						&bcast_qos.bcast.sync_timeout);
+
+	bt_shell_printf("SyncCteType %u\n", bcast_qos.bcast.sync_cte_type);
+
+	g_dbus_dict_append_entry(&dict, "SyncCteType", DBUS_TYPE_BYTE,
+						&bcast_qos.bcast.sync_cte_type);
+
+	bt_shell_printf("MSE %u\n", bcast_qos.bcast.mse);
+
+	g_dbus_dict_append_entry(&dict, "MSE", DBUS_TYPE_BYTE,
+						&bcast_qos.bcast.mse);
+
+	bt_shell_printf("Timeout %u\n", bcast_qos.bcast.timeout);
+
+	g_dbus_dict_append_entry(&dict, "Timeout", DBUS_TYPE_UINT16,
+						&bcast_qos.bcast.timeout);
+
+	bt_shell_printf("BroadcastCode:\n");
+	bt_shell_hexdump(cfg->ep->bcode->iov_base, cfg->ep->bcode->iov_len);
+
+	g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &keyBCode,
+								DBUS_TYPE_BYTE, &cfg->ep->bcode->iov_base,
+								cfg->ep->bcode->iov_len);
+
 done:
 	dbus_message_iter_close_container(iter, &dict);
 }
@@ -1826,8 +1943,15 @@ static DBusMessage *endpoint_select_properties_reply(struct endpoint *ep,
 	cfg = new0(struct endpoint_config, 1);
 	cfg->ep = ep;
 
-	/* Copy capabilities */
-	iov_append(&cfg->caps, preset->data.iov_base, preset->data.iov_len);
+	if (ep->broadcast) {
+		iov_append(&cfg->ep->bcode, bcast_qos.bcast.bcode, sizeof(bcast_qos.bcast.bcode));
+		/* Copy capabilities for broadcast*/
+		iov_append(&cfg->caps, base_lc3_16_2_1, sizeof(base_lc3_16_2_1));
+	} else {
+		/* Copy capabilities */
+		iov_append(&cfg->caps, preset->data.iov_base, preset->data.iov_len);
+	}
+
 	cfg->target_latency = preset->target_latency;
 
 	/* Copy metadata */
@@ -2239,14 +2363,14 @@ fail:
 
 }
 
-static void endpoint_cis(const char *input, void *user_data)
+static void endpoint_iso_stream(const char *input, void *user_data)
 {
 	struct endpoint *ep = user_data;
 	char *endptr = NULL;
 	int value;
 
 	if (!strcasecmp(input, "a") || !strcasecmp(input, "auto")) {
-		ep->cis = BT_ISO_QOS_CIS_UNSET;
+		ep->iso_stream = BT_ISO_QOS_STREAM_UNSET;
 	} else {
 		value = strtol(input, &endptr, 0);
 
@@ -2255,20 +2379,20 @@ static void endpoint_cis(const char *input, void *user_data)
 			return bt_shell_noninteractive_quit(EXIT_FAILURE);
 		}
 
-		ep->cis = value;
+		ep->iso_stream = value;
 	}
 
 	endpoint_register(ep);
 }
 
-static void endpoint_cig(const char *input, void *user_data)
+static void endpoint_iso_group(const char *input, void *user_data)
 {
 	struct endpoint *ep = user_data;
 	char *endptr = NULL;
 	int value;
 
 	if (!strcasecmp(input, "a") || !strcasecmp(input, "auto")) {
-		ep->cig = BT_ISO_QOS_CIG_UNSET;
+		ep->iso_group = BT_ISO_QOS_GROUP_UNSET;
 	} else {
 		value = strtol(input, &endptr, 0);
 
@@ -2277,10 +2401,13 @@ static void endpoint_cig(const char *input, void *user_data)
 			return bt_shell_noninteractive_quit(EXIT_FAILURE);
 		}
 
-		ep->cig = value;
+		ep->iso_group = value;
 	}
 
-	bt_shell_prompt_input(ep->path, "CIS (auto/value):", endpoint_cis, ep);
+	if (!ep->broadcast)
+		bt_shell_prompt_input(ep->path, "CIS (auto/value):", endpoint_iso_stream, ep);
+	else
+		bt_shell_prompt_input(ep->path, "BIS (auto/value):", endpoint_iso_stream, ep);
 }
 
 static void endpoint_max_transports(const char *input, void *user_data)
@@ -2302,13 +2429,22 @@ static void endpoint_max_transports(const char *input, void *user_data)
 		ep->max_transports = value;
 	}
 
-	bt_shell_prompt_input(ep->path, "CIG (auto/value):", endpoint_cig, ep);
+	if (ep->broadcast)
+		bt_shell_prompt_input(ep->path, "BIG (auto/value):", endpoint_iso_group, ep);
+	else
+		bt_shell_prompt_input(ep->path, "CIG (auto/value):", endpoint_iso_group, ep);
 }
 
 static void endpoint_auto_accept(const char *input, void *user_data)
 {
 	struct endpoint *ep = user_data;
 
+	if (!strcmp(ep->uuid, BAA_SERVICE_UUID)) {
+		ep->broadcast = true;
+	} else {
+		ep->broadcast = false;
+	}
+
 	if (!strcasecmp(input, "y") || !strcasecmp(input, "yes")) {
 		ep->auto_accept = true;
 		bt_shell_prompt_input(ep->path, "Max Transports (auto/value):",
@@ -2321,7 +2457,10 @@ static void endpoint_auto_accept(const char *input, void *user_data)
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	bt_shell_prompt_input(ep->path, "CIG (auto/value):", endpoint_cig, ep);
+	if (ep->broadcast)
+		bt_shell_prompt_input(ep->path, "BIG (auto/value):", endpoint_iso_group, ep);
+	else
+		bt_shell_prompt_input(ep->path, "CIG (auto/value):", endpoint_iso_group, ep);
 }
 
 static void endpoint_set_metadata(const char *input, void *user_data)
@@ -3050,8 +3189,8 @@ static void register_endpoints(GDBusProxy *proxy)
 								ep->cid);
 		ep->max_transports = UINT8_MAX;
 		ep->auto_accept = true;
-		ep->cig = BT_ISO_QOS_CIG_UNSET;
-		ep->cis = BT_ISO_QOS_CIS_UNSET;
+		ep->iso_group = BT_ISO_QOS_GROUP_UNSET;
+		ep->iso_stream = BT_ISO_QOS_STREAM_UNSET;
 		endpoint_register(ep);
 	}
 }
@@ -3595,6 +3734,7 @@ static void cmd_acquire_transport(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
 	int i;
+	struct endpoint *ep, *link;
 
 	for (i = 1; i < argc; i++) {
 		proxy = g_dbus_proxy_lookup(transports, NULL, argv[i],
@@ -3610,6 +3750,27 @@ static void cmd_acquire_transport(int argc, char *argv[])
 			return bt_shell_noninteractive_quit(EXIT_FAILURE);
 		}
 
+		ep = find_ep_by_transport(g_dbus_proxy_get_path(proxy));
+		if (!ep || ep->acquiring) {
+			bt_shell_printf("Transport %s already in acquiring process\n",
+					argv[i]);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+
+		ep->acquiring = true;
+
+		link = find_link_by_proxy(proxy);
+		if (link) {
+			bt_shell_printf("Link %s found\n", link->transport);
+			/* If link already acquiring wait it to be complete */
+			if (link->acquiring) {
+				bt_shell_printf("Link %s already in acquiring process\n",
+					argv[i]);
+				return bt_shell_noninteractive_quit(EXIT_FAILURE);
+			}
+			link->acquiring = true;
+		}
+
 		if (!g_dbus_proxy_method_call(proxy, "Acquire", NULL,
 						acquire_reply, proxy, NULL)) {
 			bt_shell_printf("Failed acquire transport\n");
-- 
2.34.1

