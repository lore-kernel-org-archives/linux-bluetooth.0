Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A4CC7EE26
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 May 2023 14:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237305AbjEWOg0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 May 2023 10:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237303AbjEWOgZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 May 2023 10:36:25 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2070.outbound.protection.outlook.com [40.107.247.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BC8E46
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 May 2023 07:36:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hq/qR4QKgux4T/0eYtX4+K3B+DPJ9CUbC5zI/sCxa4IELe/P3/etoWsqwbknyHHWRT5jE9kTbrfMeMaZDbEYtal6Dwsom83qFp5yc2tRVv8PNEn9Zjkl8fL351cw9CVHJqfB9E+Rx/nWR1w3Od5zYpKXrgWpbCM2WpSfBx66XTYZC/7hJ+jT7pm3uyPoWiYDr+s39wYKHvzY8H5xh/dmI/3HRg2wWzwfyifnSJBL8z//FWjLvxm1csa0Od+Spr/z/dQS3ZEAoRapGdbiLDfZtBHszkD5Gsm6+zczDaKtG2onJtYP27bKySdjPTMhp/CEp75E2CC9QCM6WMAQkhhkxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAYCT6flra3rDW6LX+5vmht705/gNVVD98bCuC3tnak=;
 b=JnD66OhTsg/AktuHXSdcm9EoINijiikjz/HY1LJEJ557tKS/dPpTHnKPp2XtKOmuiCbuA60NkJwBFy6k0tA+CCiP40hrOKRKhUiC4Z9eW/gs2SS9NWNn6xZCSXmLHOyDO5cSP51Ji1Y+9PGNkJD284beRDs1qBcd1qJSxUeoytWs3uQQ7/facijjiQmDMr93aSgWAuHixxEEEq6PbVJRXx/CoY6nhnTSxGPGpGX2OcwxGPL7WfPAfqDzd2y2vVGWjIXt8IUwatqLI+W4zOctEvajDJGRfvVpRoElzlvGGIU5CnOIujT97Cu6SIjDOxGPqUnJ74pz6lva8QaLQijh3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAYCT6flra3rDW6LX+5vmht705/gNVVD98bCuC3tnak=;
 b=QEHfpKDn+VQw8DIBwebDzFVm59lAlDJRB+ienTCPRehppZ8NCUyt8Ia/dANsSJDAP46b3qyCKVn6i9l9ywI0lDiOu38R5AEPpfRHZsjITFGph2vshg1H+MM9pjYkrGK4P3kHevtM0JhWfaEHNKaJFf+3vCg15W39B7Wxek5mErI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DUZPR04MB9784.eurprd04.prod.outlook.com (2603:10a6:10:4e0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 14:35:36 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%4]) with mapi id 15.20.6411.029; Tue, 23 May 2023
 14:35:36 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Subject: [PATCH BlueZ 5/6] client/player: Update bluetoothctl with support for broadcast source
Date:   Tue, 23 May 2023 17:35:03 +0300
Message-Id: <20230523143504.3319-6-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523143504.3319-1-iulia.tanasescu@nxp.com>
References: <20230523143504.3319-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0019.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::6) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DUZPR04MB9784:EE_
X-MS-Office365-Filtering-Correlation-Id: 10d3558f-4f65-4dd0-c037-08db5b9af90c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9DgJ0EBWS+DzT+SNa/WJISY73aVcTlIZNSxBI3RCjFN0nBQUQOfUucbNdGjW2tm/ahigs8kyu2vmvvLAUYl7PyvL/xhCcxMkdXrfwfXNCkC+ptJCHefV30/1NTgGuc/s494EfBs92EBmZnQRP8J7qwPK6GeZjV1K9GGU8JfpvVRPGF30rwGdwuagxZe1h/7KA61dE5PLEz2VG6MDDk13Qxhl8IG/DAJUJzinxv+18zhRKVr+qsDCWXbIy51tSB6MEVrSg5pY0mBkIA9iC6h8/r6Fz5EfBbbgvgtriklLhOE6AymgoEX+VMDrgnSiHsoCH0Ik7BjCkIR3Inkk0ZVB4pOoSEimezwy4EN5zDIgE8nQHzpNaVIAvdmSlpDGKL4Ta34/tnm0/j/hKCbdMwAs3/g9DE/U5Z1w7AFTE+lYi4rm9hbr+sM57vrSOGKxblK/uTrVD3kOTCnFU5ORj8WgGm/LEyJaOq+/qZIEnEqnJTW2OJquOwbWXVQT8CE/zY9mAH2oNRuq8nVSmEuY/nqDJ+Ondcits5rs9SDTK+OpOOe62zhPZUIo7tV4BaPTihrs2N9A+XTObmuwqo4ifOTG6GZKTbp1Ye3cic12XQvIcSbPMjSrWN7uUVtwl4JDQtVz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199021)(83380400001)(86362001)(478600001)(38100700002)(38350700002)(2616005)(66556008)(66476007)(66946007)(2906002)(186003)(30864003)(4326008)(6916009)(26005)(316002)(1076003)(6666004)(6506007)(6512007)(6486002)(52116002)(44832011)(41300700001)(5660300002)(36756003)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?awNdnNBVIlouXpfKTTw0cvE9cduRELDmwG/KiR+BXQN0U6FIEl+x/LL7X+8n?=
 =?us-ascii?Q?gmJj2oWZTLe0D7oYUBslgWAtevWgUdvcbgaoN+nYLZVxr8+EK5SZP1xqRuSB?=
 =?us-ascii?Q?oqOp+goGi2naDCGo8gh1cXIY4TBs8zs5wKX6xqeWyzikLZJ2kCGcqW0afILQ?=
 =?us-ascii?Q?XXAxpkEv/qvYwywRbTdjKDONxdhy1eeKKGLmbSmRpE700lADozivAzvcrguT?=
 =?us-ascii?Q?BMaECeaTQZCLnYno6E3nHXHFbkWLxJ/+CHOy9QVbPn0qskbjYaFAkF9CjP2e?=
 =?us-ascii?Q?Kj+EJ7ECXVl77Nie0bl346yi44uHkHTr0YC6H9mSS2sHGaAbTENqD6z/oo8k?=
 =?us-ascii?Q?PqZJe2cLFC/Yfg86g7aEpX1RBzSi7hfbcSyaCcLpAS2PlkKgqBBPUy0GG/gi?=
 =?us-ascii?Q?ipWVAtu2LIl76toIn2G+WWc+CZYFpsvOhwr1iONYx40mx5Z/Ph/GJu1uOicP?=
 =?us-ascii?Q?9wtMVM9K6s3RTrq5Ucbg3Zi8Z2QPnNyQJuzVMm8cftIYiqPxpsr4DOBENdFi?=
 =?us-ascii?Q?b3Nm2YVK/JvILKrL6fWoPM1NGwIlneupSmtoNAtCJqRhhvvAOsLMbpUGHSWU?=
 =?us-ascii?Q?BXlkV5ZXoWo+KzcfyUCnLdCcTjB6UvJ7o/uCUNslvGQRmkIctJ/CzBjsrgQs?=
 =?us-ascii?Q?gdp2Ex6arqJiNSJ8zErN30wRny7Oj79CsThx7r2c2hQqTvkZae7qsHCJWaon?=
 =?us-ascii?Q?e2ZP05eCalwJYX+l/8A4FsilXUZA2yJqb5llu2D/Rul0EIArcbpBfNkBQzmS?=
 =?us-ascii?Q?eNlthkC3QI+4kCjOY1AgB3tBfKucGhcuaRDmvdTXzgzYxbG5J2fnXgVShjXs?=
 =?us-ascii?Q?dJBPH7lOstLsg/o7ELNzNYU+RwnPWCRdaIpZ8bx1T1GlspvTeU4rXTQx8kZ+?=
 =?us-ascii?Q?/nWdnWpyKhlarcc3RFoiY+qSQYvyLzuBc7PVreMqgG5p4oP6/3Txz6/rTiCS?=
 =?us-ascii?Q?/SWxmcBH6i6CzVH8VaHQVQcTiXosfDdEoiDj2LH8TFDhYSNlrq4QNdsVeOmW?=
 =?us-ascii?Q?6Po1ypuvu9gkral6dNUelpa4/4O7UVtJ2MAf1BiO3o7tppttBJycda9328eG?=
 =?us-ascii?Q?uk5mqi/18WaJiIqtCaKJCRd8r0BjKYZopvC5hZJMtkJx44g/V1vftB+Naj1I?=
 =?us-ascii?Q?3y3mdH64pPz6163T2BoHJY6kaISfTQ85QVlIHDrOLozx9FFOThgvbaMYUiua?=
 =?us-ascii?Q?hq0bmHEaDXPyqo41/AY9erRLHj8dKQYTShj9ZOkszzswnHTkM4TgPZtm0d//?=
 =?us-ascii?Q?wE70EzAxXgt6TokjpPAMQQV8ahX/+d1PyG8pWpb97NzXM0sinARWeE+jzhsu?=
 =?us-ascii?Q?kIaGrnMsXLpzDO6X28LSFPBHgDReJWtrEzBpoN1iGTDrQBLgroUicQC4xJnP?=
 =?us-ascii?Q?C8RVx9hv1w+w2IBfrdPfsMAJp/pO2TYKujo6TDVcjg43XIMU9EHHFfBZE5xZ?=
 =?us-ascii?Q?aZ7+85k3XBAJ4SHCI/EW6Z+QmoRZZJZk+dtpk8th3KHSKw2va93aCJmSazTi?=
 =?us-ascii?Q?6sva/gX5dCYhyqeni5CB17rTMVONg4+Q1Pop8BA9lw3hjGNRRxz0Ikv6H3VV?=
 =?us-ascii?Q?I3uwVlw/2A24yhXujt5B1+MqR3PSaZnCTBv/3hjWDVV/diJTWPQlOzSISNPS?=
 =?us-ascii?Q?jg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d3558f-4f65-4dd0-c037-08db5b9af90c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 14:35:36.5720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k4PnWC/nqRJEDSzLJBwl1YhlGaFVGFTlAhvTwUpPLSL2WrLJ6IVCrJELy0sK90gFPiAVQSs9Eyzrv0NEgHkLqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9784
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>

This adds bluetoothctl support for broadcast source.

---
 client/player.c | 207 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 182 insertions(+), 25 deletions(-)

diff --git a/client/player.c b/client/player.c
index 7719076c8..1ba722150 100644
--- a/client/player.c
+++ b/client/player.c
@@ -73,10 +73,12 @@ struct endpoint {
 	struct iovec *meta;
 	bool auto_accept;
 	bool acquiring;
-	uint8_t cig;
-	uint8_t cis;
+	uint8_t iso_group;
+	uint8_t iso_stream;
 	char *transport;
 	DBusMessage *msg;
+	bool broadcast;
+	struct iovec *bcode;
 };
 
 static DBusConnection *dbus_conn;
@@ -102,6 +104,22 @@ struct transport {
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
@@ -1142,6 +1160,16 @@ static const struct capabilities {
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
+	CODEC_CAPABILITIES(BROADCAST_AUDIO_ANNOUNCEMENT_SERVICE_UUID, LC3_ID,
+					LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY,
+						3u, 30, 240)),
 };
 
 struct codec_qos {
@@ -1419,6 +1447,7 @@ static struct preset {
 	PRESET(A2DP_SINK_UUID, sbc_presets, 6),
 	PRESET(PAC_SINK_UUID, lc3_presets, 3),
 	PRESET(PAC_SOURCE_UUID, lc3_presets, 3),
+	PRESET(BROADCAST_AUDIO_ANNOUNCEMENT_SERVICE_UUID, lc3_presets, 3),
 };
 
 static struct codec_preset *find_preset(const char *uuid, const char *name)
@@ -1588,6 +1617,27 @@ struct endpoint_config {
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
@@ -1595,6 +1645,7 @@ static void append_properties(DBusMessageIter *iter,
 	struct codec_qos *qos = (void *)cfg->qos;
 	const char *key = "Capabilities";
 	const char *meta = "Metadata";
+	const char *keyBCode = "BroadcastCode";
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "{sv}", &dict);
 
@@ -1605,7 +1656,7 @@ static void append_properties(DBusMessageIter *iter,
 					DBUS_TYPE_BYTE, &cfg->caps->iov_base,
 					cfg->caps->iov_len);
 
-	if (cfg->meta->iov_len) {
+	if ((cfg->ep->meta) && (cfg->meta->iov_len)) {
 		g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &meta,
 				DBUS_TYPE_BYTE, &cfg->meta->iov_base,
 				cfg->meta->iov_len);
@@ -1623,16 +1674,25 @@ static void append_properties(DBusMessageIter *iter,
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
@@ -1640,10 +1700,17 @@ static void append_properties(DBusMessageIter *iter,
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
 
@@ -1668,6 +1735,56 @@ static void append_properties(DBusMessageIter *iter,
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
@@ -1707,12 +1824,20 @@ static DBusMessage *endpoint_select_properties_reply(struct endpoint *ep,
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
-	iov_append(&cfg->meta, cfg->ep->meta->iov_base, cfg->ep->meta->iov_len);
+	if (cfg->ep->meta)
+		iov_append(&cfg->meta, cfg->ep->meta->iov_base, cfg->ep->meta->iov_len);
 
 	if (preset->qos.phy)
 		/* Set QoS parameters */
@@ -2073,14 +2198,14 @@ fail:
 
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
 
@@ -2089,20 +2214,20 @@ static void endpoint_cis(const char *input, void *user_data)
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
 
@@ -2111,10 +2236,13 @@ static void endpoint_cig(const char *input, void *user_data)
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
 
 static void endpoint_auto_accept(const char *input, void *user_data)
@@ -2130,7 +2258,13 @@ static void endpoint_auto_accept(const char *input, void *user_data)
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	bt_shell_prompt_input(ep->path, "CIG (auto/value):", endpoint_cig, ep);
+	if (!strcmp(ep->uuid, BROADCAST_AUDIO_ANNOUNCEMENT_SERVICE_UUID)) {
+		bt_shell_prompt_input(ep->path, "BIG (auto/value):", endpoint_iso_group, ep);
+		ep->broadcast = true;
+	} else {
+		bt_shell_prompt_input(ep->path, "CIG (auto/value):", endpoint_iso_group, ep);
+		ep->broadcast = false;
+	}
 }
 
 static void endpoint_set_metadata(const char *input, void *user_data)
@@ -2227,6 +2361,7 @@ static void cmd_register_endpoint(int argc, char *argv[])
 	char **list;
 
 	ep = g_new0(struct endpoint, 1);
+	ep->meta = NULL;
 	ep->uuid = g_strdup(argv[1]);
 	ep->codec = strtol(argv[2], &endptr, 0);
 	ep->cid = 0x0000;
@@ -2861,8 +2996,8 @@ static void register_endpoints(GDBusProxy *proxy)
 
 			ep = endpoint_new(cap);
 			ep->auto_accept = true;
-			ep->cig = BT_ISO_QOS_CIG_UNSET;
-			ep->cis = BT_ISO_QOS_CIS_UNSET;
+			ep->iso_group = BT_ISO_QOS_GROUP_UNSET;
+			ep->iso_stream = BT_ISO_QOS_STREAM_UNSET;
 			endpoint_register(ep);
 		}
 
@@ -3409,6 +3544,7 @@ static void cmd_acquire_transport(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
 	int i;
+	struct endpoint *ep, *link;
 
 	for (i = 1; i < argc; i++) {
 		proxy = g_dbus_proxy_lookup(transports, NULL, argv[i],
@@ -3424,6 +3560,27 @@ static void cmd_acquire_transport(int argc, char *argv[])
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

