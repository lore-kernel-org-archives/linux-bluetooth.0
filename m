Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF51C77B73
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 May 2023 14:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbjE3OPJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 May 2023 10:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbjE3OPG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 May 2023 10:15:06 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2074.outbound.protection.outlook.com [40.107.6.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB58F10D
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 07:14:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7NWLLv8/27hOGlPZbXyrFV7gQGY5anGG5FmLTjkGuujTPPcD+wXSJ+mOY4D4jqYlUMq5R3Nls8/J/0o3pzNOpP4OQ5I/96uqcc+t+rhTppMGTXkjZyUNqnq16O5AAW7z7VjHG8I9gDcrjff9XOfPJcNzC7U8SsaL8Lo2VjkyhUFaN1vlWl/yf7rb+9awDeGgydKTMN6QbRtwN/UaVWBU5x9IoCSxYYcgE7575s+rFEJkvd0fahSI+Gya8bHQPujd2vgsDyaIxzIkOxmvIC3YVjy2cOaGiTwb6Vq9oHbclQROa2HfTu5pMaGpP50zla/wTMLEgtrrKWVXJ1LxoYtrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZFozbnhpsbNMdYLuYWAInF30dkevK+2QMzveSTo5Bs=;
 b=gbAcZbFWa+Cfi2/wm6kQ1GDha5gqeJ5nW91hGqjiJMVC5Z758HLNClaFQTC57bx7VCHPGrXc2l7786PXb93y49hPMYPYIbmHHcRNmUZf1mNYwb8reRMypvrsGKrCKjysGtjgdZN7KljhfcJy1RTS2rXiBCH7UaONXGlGPXh96DmaMTB4+rLBP80t7+uECSwUh+gipF0jFgkF4xMKS/4MJI7yMDu8MFlit3ZuVZ5Jii9t8ktuw7oDVp1vxEWlnd3uWqmayyb/kFgh+KitMKUP8t5mNhU7T5HTUpzHomV8flaXBlSFafEZRsxciAzr8FgDtq7SPbAsN4mqkKK0NqSMLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZFozbnhpsbNMdYLuYWAInF30dkevK+2QMzveSTo5Bs=;
 b=iw+CaZMMfs944uf2ezOajUmqREp6IC/93mbrI1hzdH83EEFUyN/cvlAOC+GU/e7XmED0oQdSYCUrUHTzpy58GH7p/Z/zf20FlmfGOtXmlpELpWZ07sWGqrnnVnzKfb56HGHyuWo+etmMtmQY6e9R7ZNcSh4yqpUiN7ovv+FIbyg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by DBBPR04MB7913.eurprd04.prod.outlook.com (2603:10a6:10:1ee::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 14:14:05 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::cedb:51d6:a774:f81a]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::cedb:51d6:a774:f81a%7]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 14:14:05 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Subject: [PATCH BlueZ v3 2/4] Update bluetoothctl with support for broadcast source
Date:   Tue, 30 May 2023 17:13:37 +0300
Message-Id: <20230530141339.100733-3-silviu.barbulescu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: fd4e0179-ae7d-4406-b788-08db61182036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qr4rpfzyOo62fOMGPUD/TydFs9w9CO/iJATDqPpMhHOZ5NYVR3utfcuyGT5EM4t2apgLqPe0shzi+kiOvyeoTq9E585KWSNsvP4+M2PbST0mVrQ23Sbxqz53BSCj4H1/oVbM6+L43cYLN2PcRRCIGgxaEEi0SZYaDs1evZ9eOQotSncrC2xpTu6DFCzUBQQqOVKfoGaN54h5Rip91Q+c1QgOvD6ElOzYq/8SkG+0ucnjJyh5khzQN+dfjg4f7suCt+cHWMthc151QOPqpxo8mFwaH9gavnIJEz31Z11DomIGRsTjyaMVViSgF8hPJarbgwudk5TrgTJ2G84lR2j8KjlOrXCTbImurtyFBu2Lfhh1yVKAOWC39lxhEEOkwG/faEAbIDfQlvfGS2/cyKQHr9bCxmCaylRlt6FvCDRWf1rxuiNsqzihneKeuv6nsp1+v6PFkkrHRClVifa2kvrbWV1WWqJAyKgRC8Ylbv3y2Pizbgn8no7/1ewtP8I49iHI2ikXK8eV50nc8V2l2bOW8wKOlfJdjS7MTnq4I9gBAHUgjCS45I9tswamcMvgVBix5+JTh+CI/orFHYbhcKNZw7SmzrG4g6vlOINSmHLAru9LLW/CIdxkPEi72TL2Wf6q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199021)(478600001)(38100700002)(38350700002)(66556008)(66476007)(66946007)(41300700001)(52116002)(6486002)(8676002)(5660300002)(86362001)(8936002)(26005)(2906002)(30864003)(1076003)(186003)(6512007)(6506007)(83380400001)(4326008)(6916009)(316002)(6666004)(2616005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DGKnCMAfp0cV/8NthgOQE+u5pmGRAQ3L01RHtswJ+i31rr3G1GNNI1uwBPPp?=
 =?us-ascii?Q?ZCJyNFcwYuNTd2SYoXQP1yDsEpxkrC2/30U9qbg3FNAD4jTh4bJoJxQc3UCC?=
 =?us-ascii?Q?Kgy+FSKWgwkcJqeNx/SxyZDm3OTKtU32kLPxmY3WbhBVV/4cxfJtY3rJz9YM?=
 =?us-ascii?Q?cybkOmQXlawH3pADBRp1xEHBfGvOOoZxcUjzTNB08jYtmhl/9DeWzWstV2+S?=
 =?us-ascii?Q?UL1vC0WZwTSs0IzAc/ZfDHDjLVIrLBzBPYtmUCNHEKVHmdBepg/H6abj/ifA?=
 =?us-ascii?Q?WAY1cIKrPPbiN9YTyJlakE0qLvqeolEcM82Tnczh7vDE2ALwJ5YSe+v3Sd3m?=
 =?us-ascii?Q?PzNGjIoiKXD3+p6xbavr0fibaecaxlkA2Z3DGHgQJPHp7gyUDeBK9/DWYgXE?=
 =?us-ascii?Q?+vp7UKLJmemavwVt5VY4l4ILiKTgD6STIafJSuC2QvaZkuyCx6vUHtknQixG?=
 =?us-ascii?Q?FF93RftuBzwqPYNBDeCEshb8go0ylcp31Io/Q1yZCDYkPdaflgGZwRdjMZpe?=
 =?us-ascii?Q?yrmEm9GbJy7ZqU48msrRjlq5/tAbhascmkaAfsKf+oGor3EmKGn02tHExbyC?=
 =?us-ascii?Q?4XhzJqi8rTOe0DefnbTsnJ1PpRFAwys7/ZIqxN+L4aacqZh70ALHYktZ61Sa?=
 =?us-ascii?Q?syZPgWWBZgeWL0f4ZWhj9t6aEiVZGVEaZY9DCVqKc6PHCH2rLSC1U2Ha5ppB?=
 =?us-ascii?Q?FtsNn27rEmLhQpImtCUi3H9ZRIN9SrH/24nzFM1IuEo/hAgg2Rne4uMJY+w2?=
 =?us-ascii?Q?gcyRqGEK0ZeZBWfTLB2BVdQheQYSeyfUGWYJwL4iS0udxhja9bK324p48pmp?=
 =?us-ascii?Q?GTlH5CriKaJoXBxYdg+SzqydSICC4/tHv8z/JkJgWUQkDyA7cEpbZV9khdr5?=
 =?us-ascii?Q?Q0Hpg7ln/EO73LNyt572IkhDZlUrdW+dXBP+pj95KrxO0EoYC/sj3mfuo4gw?=
 =?us-ascii?Q?hCJDzwS+1wE7WQDfHevjbPIod0EY64ZEl+xVJMFwFBASggt1Duw3FV3lpeTE?=
 =?us-ascii?Q?yAzl6I8AdkdTBDfB1QDsTC14HvLo0w8sCHERtac0LbCW5pUIEcKubf3RLkGV?=
 =?us-ascii?Q?vv1FdjtSo5+0y3Zil9GFKPjR6cLnO6HM7spx7kMlKIxSHGDtq/s7/6tAogwB?=
 =?us-ascii?Q?PJeXMgnt5aIxbjZ/hREXmOQeiKGqgCx/zNLos1B9jQVM+BxX+xwx112Pb6vJ?=
 =?us-ascii?Q?T2HxUGX3G3MmGkVIeb02c7EK8RJAnEznhSO846qzb07ov+0/Su2uEAVN60+q?=
 =?us-ascii?Q?WZ1oTM09UKJ6ZYCaIIywPLUGCRbl7U7O7Tv16cMohxTFoNpzvUSgorazMneJ?=
 =?us-ascii?Q?FMj4JEKPQkvKqsIsCCgdKi7PXf4C4aKy324XcU6IHIYE/cMqzw09MCDaFamN?=
 =?us-ascii?Q?207/5KVEnSwOtuVgrVNScV0Dxbj3zWSCg2Kx+EF0TpxcxOGugt9Vq/0RqT46?=
 =?us-ascii?Q?BxT+w660CbR0TQpwPAIDfWQpTFZWz5zBlu60RQGT0d4HNqN6VoLOegFrqcC1?=
 =?us-ascii?Q?vIQ9QLiDCL6xbTqFl6XasSY1dGiwO28kPQwLkTjGTSWUDyIYnkMJfopfwty3?=
 =?us-ascii?Q?/toUyMuTlEDDGpKV1cgFrVh5/jQk8TdN0+3iqLQVixv8BSZVERna7bhA1/W+?=
 =?us-ascii?Q?rQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4e0179-ae7d-4406-b788-08db61182036
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 14:14:05.2294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NweQUhnMtH75bY+YA6S2qvyUht39prrZY3tviO87W3x0BsnifbzTWz6d5HUgToEursH8OAb1FR/Pxtsa4Y17JmlFLT43j/DquOL6ZIDoN1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7913
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds bluetoothctl support for broadcast source.

To test the current implementation use bluetoothctl with the following commands:
  endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x06
  transport.acquire /org/bluez/hci0/dev_00_00_00_00_00_00/pac_broadcast0/fd0
  transport.send /org/bluez/hci0/dev_00_00_00_00_00_00/pac_broadcast0/fd0 <file.wav>


---
 client/player.c | 223 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 199 insertions(+), 24 deletions(-)

diff --git a/client/player.c b/client/player.c
index a9f56fb94..be22e8ab9 100644
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
 
@@ -1742,16 +1793,27 @@ static void append_properties(DBusMessageIter *iter,
 					DBUS_TYPE_BYTE, &cfg->target_latency);
 	}
 
-	if (cfg->ep->cig != BT_ISO_QOS_CIG_UNSET) {
-		bt_shell_printf("CIG 0x%2.2x\n", cfg->ep->cig);
+	if ((!cfg->ep->broadcast) &&
+			(cfg->ep->iso_group != BT_ISO_QOS_GROUP_UNSET)) {
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
+	if ((!cfg->ep->broadcast) &&
+			(cfg->ep->iso_stream != BT_ISO_QOS_STREAM_UNSET)) {
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
@@ -1759,10 +1821,19 @@ static void append_properties(DBusMessageIter *iter,
 	g_dbus_dict_append_entry(&dict, "Interval", DBUS_TYPE_UINT32,
 						&qos->interval);
 
-	bt_shell_printf("Framing %s\n", qos->framing ? "true" : "false");
+	if (!cfg->ep->broadcast) {
+		bt_shell_printf("Framing %s\n",
+					qos->framing ? "true" : "false");
 
-	g_dbus_dict_append_entry(&dict, "Framing", DBUS_TYPE_BOOLEAN,
-						&qos->framing);
+		g_dbus_dict_append_entry(&dict, "Framing", DBUS_TYPE_BOOLEAN,
+							&qos->framing);
+	} else {
+		bt_shell_printf("Framing %s\n",
+				bcast_qos.bcast.framing ? "true" : "false");
+
+		g_dbus_dict_append_entry(&dict, "Framing", DBUS_TYPE_BOOLEAN,
+						&bcast_qos.bcast.framing);
+	}
 
 	bt_shell_printf("PHY %s\n", qos->phy);
 
@@ -1787,6 +1858,57 @@ static void append_properties(DBusMessageIter *iter,
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
+					&bcast_qos.bcast.sync_cte_type);
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
+						DBUS_TYPE_BYTE,
+						&cfg->ep->bcode->iov_base,
+						cfg->ep->bcode->iov_len);
+
 done:
 	dbus_message_iter_close_container(iter, &dict);
 }
@@ -1826,8 +1948,18 @@ static DBusMessage *endpoint_select_properties_reply(struct endpoint *ep,
 	cfg = new0(struct endpoint_config, 1);
 	cfg->ep = ep;
 
-	/* Copy capabilities */
-	iov_append(&cfg->caps, preset->data.iov_base, preset->data.iov_len);
+	if (ep->broadcast) {
+		iov_append(&cfg->ep->bcode, bcast_qos.bcast.bcode,
+			sizeof(bcast_qos.bcast.bcode));
+		/* Copy capabilities for broadcast*/
+		iov_append(&cfg->caps, base_lc3_16_2_1,
+			sizeof(base_lc3_16_2_1));
+	} else {
+		/* Copy capabilities */
+		iov_append(&cfg->caps, preset->data.iov_base,
+			preset->data.iov_len);
+	}
+
 	cfg->target_latency = preset->target_latency;
 
 	/* Copy metadata */
@@ -2239,14 +2371,14 @@ fail:
 
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
 
@@ -2255,20 +2387,20 @@ static void endpoint_cis(const char *input, void *user_data)
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
 
@@ -2277,10 +2409,15 @@ static void endpoint_cig(const char *input, void *user_data)
 			return bt_shell_noninteractive_quit(EXIT_FAILURE);
 		}
 
-		ep->cig = value;
+		ep->iso_group = value;
 	}
 
-	bt_shell_prompt_input(ep->path, "CIS (auto/value):", endpoint_cis, ep);
+	if (!ep->broadcast)
+		bt_shell_prompt_input(ep->path, "CIS (auto/value):",
+			endpoint_iso_stream, ep);
+	else
+		bt_shell_prompt_input(ep->path, "BIS (auto/value):",
+			endpoint_iso_stream, ep);
 }
 
 static void endpoint_max_transports(const char *input, void *user_data)
@@ -2302,13 +2439,24 @@ static void endpoint_max_transports(const char *input, void *user_data)
 		ep->max_transports = value;
 	}
 
-	bt_shell_prompt_input(ep->path, "CIG (auto/value):", endpoint_cig, ep);
+	if (ep->broadcast)
+		bt_shell_prompt_input(ep->path, "BIG (auto/value):",
+			endpoint_iso_group, ep);
+	else
+		bt_shell_prompt_input(ep->path, "CIG (auto/value):",
+			endpoint_iso_group, ep);
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
@@ -2321,7 +2469,12 @@ static void endpoint_auto_accept(const char *input, void *user_data)
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	bt_shell_prompt_input(ep->path, "CIG (auto/value):", endpoint_cig, ep);
+	if (ep->broadcast)
+		bt_shell_prompt_input(ep->path, "BIG (auto/value):",
+					endpoint_iso_group, ep);
+	else
+		bt_shell_prompt_input(ep->path, "CIG (auto/value):",
+					endpoint_iso_group, ep);
 }
 
 static void endpoint_set_metadata(const char *input, void *user_data)
@@ -3050,8 +3203,8 @@ static void register_endpoints(GDBusProxy *proxy)
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
@@ -3595,6 +3748,7 @@ static void cmd_acquire_transport(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
 	int i;
+	struct endpoint *ep, *link;
 
 	for (i = 1; i < argc; i++) {
 		proxy = g_dbus_proxy_lookup(transports, NULL, argv[i],
@@ -3610,6 +3764,27 @@ static void cmd_acquire_transport(int argc, char *argv[])
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

