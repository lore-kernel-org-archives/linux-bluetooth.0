Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CE4C7EE43
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Jun 2023 08:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239105AbjFGIXZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Jun 2023 04:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239059AbjFGIXX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Jun 2023 04:23:23 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2040.outbound.protection.outlook.com [40.107.14.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1427E184
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jun 2023 01:23:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J87oWInsV6EUX/bCNTBhMWYdQT1n0yRxkuMik4fcjfWNsynuH54cTkyLcqlNY2S6iLrgwoFvoSAtEq87NRGCuTQ/2W1ieFubQvlZmmprvJppCs5f+IRos+yTWM+EQV3RCArIjy582Tz5Jl0Oays51gtf2XjdR4jTNp8868BKlZ2IgVL10jk4Y+smqkKlaBpl4XjhxYQBpd7MWb77T/A4ivSmnNS6fwQ+Hdx+QKjYX6bqgtdxra1H+uwS67kUp7BFMHl2Up7iPODnXuB1pG4OdSO5nJStgAfsCxZ7Bq5SRwaVxlXf5/CnlldU8OYcWAc+owndASdYeGuu3pdwIBQkCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Be/fnW6tNqM9MDxSHc0sGJX78kUsjaVpfLyV3j2t5ps=;
 b=JaFihHNiu2OWJC18hKKwIWYMhMnupD3xC3wIjNWwQSsFZirKLs/Mb2N/PX4aRSx1ugaced69dDun2qCT/SJ5xOFhNt8SbEh0EMpla/3h1HMbYeOyTcYh8mjqMY2vfpIZH83YtvRlqoizhJ1cqgGySsB7EGnly3gnHFlSm02mF0Gc82/WWMs3B5z3ba1eDVsvnDOIuXwLULjT/TgiIcMpzc/1X8n87sxE9VvodE2sBP4pelgtOwKahPb6QaZfstrQxxjA1iPPetl+bqzq7A59ERNo3fvIxor3HN8qAOQCNZVS1BPKUWdstjvj//KxXqiJvZV/2AsUQLZpwun+zfg+4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Be/fnW6tNqM9MDxSHc0sGJX78kUsjaVpfLyV3j2t5ps=;
 b=qDWg/dQ5ACP+f7Rxgib+iF56eXYjYUgu+ScDOue35IT+wIba+8PpSTZr8EgHJwdX2K/lHvOS2J/ZDT/KHluAwlS3ycKcgL5BGHIGd/2I/LGujyNVkgKF+2qm1F2e2v+dcp2Fa+xsuUeqWTJHWikhReVCJFP7YmJRz8G6RfzQPhI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by DB8PR04MB7114.eurprd04.prod.outlook.com (2603:10a6:10:fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 08:23:18 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::e8eb:cac:f3e3:1085]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::e8eb:cac:f3e3:1085%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 08:23:18 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Subject: [PATCH v4 2/4] Update bluetoothctl with support for broadcast source
Date:   Wed,  7 Jun 2023 11:22:58 +0300
Message-Id: <20230607082300.4970-3-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607082300.4970-1-silviu.barbulescu@nxp.com>
References: <20230607082300.4970-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0101CA0083.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::51) To VI1PR04MB5344.eurprd04.prod.outlook.com
 (2603:10a6:803:4b::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:EE_|DB8PR04MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: 85417808-a3f5-4b54-aec5-08db673072b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RsYJAp4O9cG2ClhocUQi5/NvtYSLEfR/seJW+ZX6y22AezRdaLDDA1T4W7Y9p0QNvDjlK0eYPPF9WBO4E7e9zNXDyz5RBaSdE2WJh4zyGhbgHmVrT9rv7SmZUlIoeXxUleaEL6bDuLxmZ8oyIHQzSPqzMRbItun6icxH916PGsCn1xAmBT8Ur0LtQUHNwvnpf/X0NeluN787wzyAGNr2fX/Jhzi7hJR24tEbw0/3rBCj4uIrctUZZB/+g18kE1Y2BV+FzvT4PSq0qcJ62Bh7kQzYbCX4cNYijvSO+70EYUezRGISELwR67W/zCN0brRV6NC2bRQh4gT9yO5G9tF8waqc7DBcutWuL1Vl+rZ3KDU/Q+FegXzdKW3CiHEmlWD2cmhNn/VmObJw2e68AKSuWresu2JZzaS1voLvCE9AiFtt62W3y03Ce0LE1Ckiz9RTLolR6vy5KhfsYLCc9L+u/eWLV1XXc/5kqxOHNAvKDcI7vWCm4VzHVXpBC8WZgPj0hRvJN71ZqC2CRXcbnLWkGkBl2LUDoXHEIB5dXjoIz9l7oZP+h3ZJaCXudKFvJfw2Mn4B9jjwHDz/S1105Pzd0OkAtwkfKMbTo4Dp2AYZTMNe3i6UQ9/lNwIJ/H5G0kB0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199021)(55236004)(1076003)(6512007)(6506007)(38100700002)(2616005)(41300700001)(38350700002)(6486002)(52116002)(6666004)(186003)(26005)(83380400001)(478600001)(66556008)(6916009)(66476007)(66946007)(316002)(2906002)(8676002)(8936002)(5660300002)(4326008)(30864003)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BInOR6uZr9Frns83ckzOpiMmXWnZ7v6mecYL9whEuWZgM+WO+U50GiuzlZtU?=
 =?us-ascii?Q?F12AYZhYQFRuqvTAWhiJrMCu+rzzrsm6MOPduFcT4Ul0Y3yBhzxpkG1cYhQ4?=
 =?us-ascii?Q?TtoH5K65V/h8b+kbXTnmUhhObzplTqX8fADx5TDx+XEA1j7b28+R2rtl3NLK?=
 =?us-ascii?Q?QjtpPvo4JE1Vf3ISo4TVTBYjsJOSAzT/2dEVQTuQFCi7wlwBXW8sfI5lrWcu?=
 =?us-ascii?Q?1y+lNgvMTTjmlO5EzeBFo7VcnEMn1S2XIy0hclkYj8eRenaJ1tZmgp3s6AWj?=
 =?us-ascii?Q?Dsec+pmQVgUjuZVxwC+wOvhx1VC1DMtngjJvk6eePCTCefy0s9hQ/SLyl68m?=
 =?us-ascii?Q?eDGepNHp2YpfW+658fBOIlJ9/wjZAEGj5B42Q+AJFf5qmZnfeDyM1mgkLeue?=
 =?us-ascii?Q?+bDA5Rfbg3qjzuCaZhKp76fAGu+LPnb7ZxbsV8VHMi3EwY806pPplzmYmHRs?=
 =?us-ascii?Q?L0pQUgxcOfxb2c8NzTex85fd5H1WqBBFq5lsvH5h50x+pwDS93UrbBV4nSEC?=
 =?us-ascii?Q?/5H0Y2mxXM3yHBhkbfgVwEy3nUmy8PW4j9gEu7Mjqa+xUPfxxMOvEF6oSbWW?=
 =?us-ascii?Q?P2wz4eEee4U1xG9oS+7R6kIdY2LEjV1gAI4CAcq+7Qc9R7L3GqcNso4nrQT1?=
 =?us-ascii?Q?JJkQhJFy/devAzEnjrNZcVeXrecR5BeYSMarQ7koRo0WQDV+ILkDPs0HLmpi?=
 =?us-ascii?Q?yHclbKZp30qlrVlfG3J9bRaebfre7tYgAzkxiDjf5NJw6NzZfyJVTOuVCmR4?=
 =?us-ascii?Q?7pyZKZgsQaj8OO2eR/NsMb1j+MGcCyGQD5pMKTG/PEvIovXQ8DYxVRwTzHOE?=
 =?us-ascii?Q?pTQwTZ7FLDJCFM5+xAxj5mHq5DAnGv7kSeqHx17KUaVONZ576oIUWz2wMchz?=
 =?us-ascii?Q?ERsepPwciBz0ef6nzaa8VsRf1ukLAb19OGUIwxcWi89q+QuqP7SBkjv0xueN?=
 =?us-ascii?Q?FkbI/aJ1l1J3rtwtnr1rUprCpNhUYPEHuIjnzgCsYWIfcPeaV73tX8SqsdFX?=
 =?us-ascii?Q?L6mhnRnQLKgSP5hrGJ+NAmzrzIPztHnygcFw+Ld33LvpAHO23JvFXs0znNc1?=
 =?us-ascii?Q?QUWqwT8ViC7bBGcKH6QIVN3wpbWS7f2eK9+76qWwl4JMxgDN3noFlFHkh1L3?=
 =?us-ascii?Q?1QSB5r3ITh52csCmvPgGhhEJKIumHYFc3QxjNRMGGl5PQQndIq+aQiEe+qs9?=
 =?us-ascii?Q?1OT0xRRCzuqrzHGRYk1y6WyXxtGVfkJNqQBmRh0fvb8MmQkQi8+kKCCfF7xQ?=
 =?us-ascii?Q?6HYrVhxWCHrHHiByMlNOdtnYwt/WgK2T3BZ6Ka4xfMhfidVxK5p80Cm3nVn1?=
 =?us-ascii?Q?htJgDB5sUg+DF016qW3N/zUExcfR8nlHnXjOeHTewr7Aeugf1UNY1Xxx2IxS?=
 =?us-ascii?Q?0hPU4ohKfVFeZWi0JgWqLaN2qgLuHba6lHmj9tmEoiPdX0cY4ov2v4HI8QPo?=
 =?us-ascii?Q?8v6GWZcN7GO2rSRSgUmUhH7eOhrHKStkUFkIitxWh0B/AFZUSoi7A3gg6KfC?=
 =?us-ascii?Q?VvZDvC4Ze/60TizDkgN+Oqyaz47VoG6V3IGjns6ByrvKqrCfOi5cdWSBIV8l?=
 =?us-ascii?Q?/dtFR5oJpdZdLLoCE1QfsjNRK06i/IY2dJ/CAvIjD4BQcwfNcXZZMGbw6qEI?=
 =?us-ascii?Q?DA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85417808-a3f5-4b54-aec5-08db673072b1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 08:23:18.5110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXI8JqEGXEdaFJdU3FtstOTCLATXBt5qU5Jl9muBiO4dXHahfyIde+DsKHiIPDBbk3roTp53RJeGjl52bHvoZ7V0H53HLh+VLsfHm2eJ+jA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7114
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds bluetoothctl support for broadcast source.
To test the current implementation use bluetoothctl with the commands:
endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x06
endpoint.config <created endpoint> <local endpoint> 16_2_1
transport.acquire <created transport>
transport.send <created transport> <file.wav>

---
 client/player.c | 226 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 201 insertions(+), 25 deletions(-)

diff --git a/client/player.c b/client/player.c
index a9f56fb94..389fc1d07 100644
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
@@ -2239,14 +2361,14 @@ fail:
 
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
 
@@ -2255,20 +2377,20 @@ static void endpoint_cis(const char *input, void *user_data)
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
 
@@ -2277,10 +2399,15 @@ static void endpoint_cig(const char *input, void *user_data)
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
@@ -2302,13 +2429,24 @@ static void endpoint_max_transports(const char *input, void *user_data)
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
@@ -2321,7 +2459,12 @@ static void endpoint_auto_accept(const char *input, void *user_data)
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
@@ -2598,9 +2741,17 @@ static void cmd_config_endpoint(int argc, char *argv[])
 			goto fail;
 		}
 
-		/* Copy capabilities */
-		iov_append(&cfg->caps, preset->data.iov_base,
-						preset->data.iov_len);
+		if (cfg->ep->broadcast) {
+			iov_append(&cfg->ep->bcode, bcast_qos.bcast.bcode,
+				sizeof(bcast_qos.bcast.bcode));
+			/* Copy capabilities for broadcast*/
+			iov_append(&cfg->caps, base_lc3_16_2_1,
+				sizeof(base_lc3_16_2_1));
+		} else {
+			/* Copy capabilities */
+			iov_append(&cfg->caps, preset->data.iov_base,
+							preset->data.iov_len);
+		}
 
 		/* Set QoS parameters */
 		cfg->qos = &preset->qos;
@@ -3050,8 +3201,8 @@ static void register_endpoints(GDBusProxy *proxy)
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
@@ -3595,6 +3746,7 @@ static void cmd_acquire_transport(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
 	int i;
+	struct endpoint *ep, *link;
 
 	for (i = 1; i < argc; i++) {
 		proxy = g_dbus_proxy_lookup(transports, NULL, argv[i],
@@ -3610,6 +3762,30 @@ static void cmd_acquire_transport(int argc, char *argv[])
 			return bt_shell_noninteractive_quit(EXIT_FAILURE);
 		}
 
+		ep = find_ep_by_transport(g_dbus_proxy_get_path(proxy));
+		if (!ep || ep->acquiring) {
+			bt_shell_printf(
+				"Transport %s already in acquiring process\n",
+				argv[i]);
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
+				bt_shell_printf(
+					"Link %s is in acquiring process\n",
+					argv[i]);
+				return bt_shell_noninteractive_quit(
+								EXIT_FAILURE);
+			}
+			link->acquiring = true;
+		}
+
 		if (!g_dbus_proxy_method_call(proxy, "Acquire", NULL,
 						acquire_reply, proxy, NULL)) {
 			bt_shell_printf("Failed acquire transport\n");
-- 
2.34.1

