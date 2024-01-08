Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920CF5380F
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jan 2024 16:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pNVfzICJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABF2O6eFaweI+fH2v/sWBzo9dBp9N4wjrMW1VQLwnpMfuCTHPoV1cs/JXEOJ75XKTmrNvymxC3HCXgRgj9RRH78o9B2+/dSZMvfyFfRzgrsdt3x3trBlVWhHDpcYv+3Tywk5NU1TRtLHXc0l9FywCL/gf3gaeNG5R+3X0NXTIueAqAfWJnRY04Dfy0coa90wwI8YftM6i5A26kI1FME9pplOIHcdX4aM5sPmRAR6dcWbMsJGJ0aMhtsFRejc8oOZDNzLdlbHjku7pqTqlypc/AifGnt6BjdM73HWAFOnN/PrSiVUtYoPWHRYLJjPhQu6NRV330awOujMu4l3baGPhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJBEEsQIjv4GM79rToo4bTX/YIB107JykBQCHWnMWm4=;
 b=IjixvM10MeHFeHQE4LaMRV9vbckrmpMa8yejwUCSdg1s49H0NxDmMLerw4cX/psq3USkbY+UMpsawkwUeQxg4eDg8O45Eid6APDOxO6CK1WMX3WNKLlNpwuOI2qRwIpoMXH194+dMic6k6DXNLspVTl3nAtU4p2i13L/KUFBOqA5dnUMCEARdUSeE335pcEYg37/BM/NT8MwVoQegXIvH9jOG70rQ8YqSD9QfOYcqJrRjoEqNZTnfIySJyR+xV4+AyKfaRfwDTN95Xy6Qe7MYWbq1LsdJnZXqfdKy73kaURRyetiGbW/5PrC/jCykWxW9kp927+87jKhkeIp7NNySQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJBEEsQIjv4GM79rToo4bTX/YIB107JykBQCHWnMWm4=;
 b=pNVfzICJn8IOTVcSt/6OeM/i9X2jCe0+/lhGIF4XeJV0SiJmBOX8V4TZHRAfaNKjDLhjhZp+rCVMfbkVWQOQm8udjNeezRAW5CLmIKS+L2Q41CVVmg357ipGzS/r6u0ZK4xPSD1Q9ABwmekuPwsF2x4ASdqJFR8CSqwWlGDDGYU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 16:43:12 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 16:43:12 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH v3 1/3] client/player.c: Add support for multiple BISes
Date: Mon,  8 Jan 2024 18:42:56 +0200
Message-Id: <20240108164258.77332-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240108164258.77332-1-silviu.barbulescu@nxp.com>
References: <20240108164258.77332-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0017.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::7) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|VI1PR04MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: 8877ffa0-3704-4990-b8d1-08dc1068e720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7wd5dcJtvRnbeT7/UnxFiDiii9eC3TYAIA6gjR+eOgL5aXoxNC8/2X2xiBqO9t8Ey0iz405SlDUbd4sl9UINuZUmgJ+QGENB+fkL7niCu0aClaGtcKMZgwEYiIcZhQ5rLMKGmxbThTNlqzbT2O2xveYNfiyJkEK6fP3sPo2R39Nsj9KO2H8Sotk0/S8dCNaZEAxt3Iy4g4yny1IrR9rc2zOnJw6Ccpcax0rJa3RiWa+o1PMMEvS81PU44lTf0R2TjBwdmjzowqFIf1TwwGOTS8KcOlMQN9jo67YdC+9dhUlLCkje11js2uAiLfIL0wjQYUuPG2GeByOnEb5Cc2nUUQoCd3gP7GKpwM19xP0cmolqbsP1Q431RfC6psHLV4DVrh8wjKlvyRH38zWfGS61D1Ub721wswFCVo/ZF2HuOLX9JKBFYYGdSyHPwzeyoEEdbXm/LuBu0Og5G2fx5EyNtHZrXeR4i5SEvnNw5ayaAbpTfD7bT+vuKts/vgqM+2ghMST4kPHpVvGHy9KwZIgwxBYQd7TRqBicA1TO5DIsOZGh0RB8W5LfpLNC+bVESIn3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(136003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66946007)(66476007)(66556008)(316002)(8936002)(8676002)(1076003)(26005)(478600001)(2616005)(83380400001)(6916009)(2906002)(5660300002)(41300700001)(38100700002)(30864003)(4326008)(86362001)(6666004)(6512007)(6506007)(6486002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ojwNYdPZ7JLAF01ysS64LrQtxjeca2InHbzBlX/FUoRGIhjC9LLRGdcACPL2?=
 =?us-ascii?Q?/VAbLQi32QJ8su525TJPCungyPerEJbahVUtD1NPPgxpOKq9dds2wZ4ZWeyO?=
 =?us-ascii?Q?/tWHM+/2EpM83uUx89jVnBVQy2fre2D/aS12Rc5eEJjfHORG0w5x5KeBk92j?=
 =?us-ascii?Q?DZPTd1qArytn2xQsuTS7n8S2cl7PB3qFBEPtozTqxbc5v2c2T+tXm/G/idUD?=
 =?us-ascii?Q?QJAu0wiDdKgOAfrTl7Oh1RZg9W+o486ckSUvwXeJxdG3hvZjuWVS0klBAR1v?=
 =?us-ascii?Q?OJ3Hm2vO8DgmMEH/5Z/Mkd5V6K9CLebYewehKQE0RPzd79uFAuQ8cFFEKsj4?=
 =?us-ascii?Q?ScYpcGAn69c9zip1nhW8LZURacm2m8TmDyGN+I+J/PhyuONX+HmkBvZb631Z?=
 =?us-ascii?Q?iEmbKAoy1cs+ZMqr0c5RiZa5TEaP4tbXQMwjyAQ9X0TyQU2xZMNH8B/YKcQx?=
 =?us-ascii?Q?7MT7vNbjpgXyeCUg/ZdZCgMqw/6EwQqInrGh1gX63fL16WCI6qBxTh6WdE4O?=
 =?us-ascii?Q?xoxWa8a/M2Fnn1S/XuS+6yXmStgTg5hGi5LEobuVdJwIlhEZxac5ItAxRcvC?=
 =?us-ascii?Q?AtiftkMoHwr5F8CoUrq8Gk9O4QK6vqjSX6Jb9G2VLIQqGN8yCgTFcL3DEsc+?=
 =?us-ascii?Q?x7YwUfLLDo0qb/3H7ugI4IvXjIpB3LHYkbN9T9ijofdE1XSc/r0MSpuyhTct?=
 =?us-ascii?Q?PUqjrdZ7WIDR8zGEoANrpOx2DBK8EDKzRCLenVLeAQyk3D6S3YzzPwIYwg51?=
 =?us-ascii?Q?g/82gGwGeaNKb8c9hu+0EV1sEIrRrnOOzzN7G2wsFPt9zv4HJTwzhUbC9Aua?=
 =?us-ascii?Q?2vns0U0bQEMF/Khgg1TWNwzUCnpK4g1tcwBSdGwDhZVArEWCZKVS9HtBMWZJ?=
 =?us-ascii?Q?apTvyQNb2UbNIS+yvpcv0+qXAM7EA6k3PCA6fetIAAf8gQ1HcUzeUHPHxaDF?=
 =?us-ascii?Q?FXOARi9x47rm8VpsHwEylFmfXSJpIJFTzTXCJ6aqfqn4l0AxtDzcR/XG5raq?=
 =?us-ascii?Q?fcUUJxIxyJ/y0X0kh4DWrodkAGwFWyGOWNuZxcYuVbalV/crvUyoRTGkMUoE?=
 =?us-ascii?Q?mCPkgpxSp09sRypD7LGO2JSaXPGJwbWToPpgD9oponH+6a+wRqxo9NWxahxr?=
 =?us-ascii?Q?RJaT4QNDvTIaOY2A+1RoyumXiaBAldO0rioYgcToLKTrpSLujdvnWTWhYzNv?=
 =?us-ascii?Q?GQhWw1ZnPxSCxZ1TgECy71REqsqfMfMPLFiXiyzfp4eao5aPWoDGlL2OmUAV?=
 =?us-ascii?Q?z2HQca/3AuTaSTK+Jlvpm7PwiI5NtSQoG1LWaBzhljPpiYoiqjHK/XqKoBtB?=
 =?us-ascii?Q?OOUrLyAiKqn6b9J1VS+oBMJW7NcntE7KUtXEGO6LfY0uBh5uR4oLyCRp7+ub?=
 =?us-ascii?Q?/2UoHH5S1lLmm8nCd2eGq/Pr0lpHvPlJywlSl2FPMUjv9wKWiOf7Iu0ww9G6?=
 =?us-ascii?Q?S9f0nhISfPOlfxhoqt6Yd8mLaA3p4s/8Ry2emDdhb/97ZybkOypR5N2Y/uTT?=
 =?us-ascii?Q?JcEKiIXbd8hyO2jqRBr+kyTZzPwzNmQCp51SSoudUogbPULX8HopJsGbmSpp?=
 =?us-ascii?Q?UUf4ofQjwm88SAXzm4lGalZWPiXpAYVcXgYuMXt+X7HKTMsar0kp05JgQrzT?=
 =?us-ascii?Q?4w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8877ffa0-3704-4990-b8d1-08dc1068e720
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 16:43:12.3012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cJvTUFm7VFhKFaUFoeU1vY0upVyWJ1zrn0vlFK6/Up7bfk9bv7FthhJGv0TRpJ2JV1BkXND0ElvHOP2JT0rqpjCVmCoI46Au9npGbPvUcV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6797

Remove hardcoded base and QoS for broadcast and use presets instead.
Remove BIG, BIS, and context from the register endpoint
command for Broadcast.
Add Location and Metadata support for endpoint config for
broadcast source.

---
 client/player.c | 301 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 201 insertions(+), 100 deletions(-)

diff --git a/client/player.c b/client/player.c
index dad243786..fc5ebd602 100644
--- a/client/player.c
+++ b/client/player.c
@@ -72,6 +72,17 @@
 #define EP_SNK_CTXT 0x0fff
 #define EP_SUPPORTED_SNK_CTXT EP_SNK_CTXT
 
+/* BAP Broadcast parameters */
+#define BCAST_SYNC_FACTOR	24			/* PA params */
+#define BCAST_OPTIONS		0x00		/* PA Create Sync */
+#define BCAST_SKIP			0x0000		/* PA Create Sync */
+#define BCAST_SYNC_TIMEOUT	0x4000		/* PA Create Sync */
+#define BCAST_SYNC_CTE_TYPE	0x00		/* PA Create Sync */
+#define BCAST_MSE			0x00		/* BIG Create Sync */
+#define BCAST_TIMEOUT		0x4000		/* BIG Create Sync */
+#define BCAST_CODE {0x01, 0x02, 0x68, 0x05, 0x53, 0xf1, 0x41, 0x5a, \
+				0xa2, 0x65, 0xbb, 0xaf, 0xc6, 0xea, 0x03, 0xb8}
+
 struct endpoint {
 	char *path;
 	char *uuid;
@@ -92,7 +103,7 @@ struct endpoint {
 	DBusMessage *msg;
 	struct preset *preset;
 	bool broadcast;
-	struct iovec *bcode;
+	struct iovec bcode;
 };
 
 static DBusConnection *dbus_conn;
@@ -105,6 +116,7 @@ static GList *endpoints = NULL;
 static GList *local_endpoints = NULL;
 static GList *transports = NULL;
 static struct queue *ios = NULL;
+static uint8_t bcast_code[] = BCAST_CODE;
 
 struct transport {
 	GDBusProxy *proxy;
@@ -118,21 +130,7 @@ struct transport {
 	struct io *timer_io;
 };
 
-static const uint8_t base_lc3_16_2_1[] = {
-	0x28, 0x00, 0x00, /* Presentation Delay */
-	0x01, /* Number of Subgroups */
-	0x01, /* Number of BIS */
-	0x06, 0x00, 0x00, 0x00, 0x00, /* Code ID = LC3 (0x06) */
-	0x10, /* Codec Specific Configuration */
-	0x02, 0x01, 0x03, /* 16 KHZ */
-	0x02, 0x02, 0x01, /* 10 ms */
-	0x05, 0x03, 0x01, 0x00, 0x00, 0x00,  /* Front Left */
-	0x03, 0x04, 0x28, 0x00, /* Frame Length 40 bytes */
-	0x04, /* Metadata */
-	0x03, 0x02, 0x02, 0x00, /* Audio Context: Convertional */
-	0x01, /* BIS */
-	0x00, /* Codec Specific Configuration */
-};
+static void endpoint_set_metadata_cfg(const char *input, void *user_data);
 
 static void endpoint_unregister(void *data)
 {
@@ -1857,37 +1855,33 @@ static DBusMessage *endpoint_select_configuration(DBusConnection *conn,
 struct endpoint_config {
 	GDBusProxy *proxy;
 	struct endpoint *ep;
-	struct iovec *caps;
-	struct iovec *meta;
+	struct iovec *caps;		/* Codec Specific Configuration LTVs */
+	struct iovec *meta;		/* Metadata LTVs*/
 	uint8_t target_latency;
-	struct codec_qos qos;
-};
-
-#define BCODE {0x01, 0x02, 0x68, 0x05, 0x53, 0xf1, 0x41, 0x5a, \
-				0xa2, 0x65, 0xbb, 0xaf, 0xc6, 0xea, 0x03, 0xb8}
-
-static struct bt_iso_qos bcast_qos = {
-	.bcast = {
-		.big = BT_ISO_QOS_BIG_UNSET,
-		.bis = BT_ISO_QOS_BIS_UNSET,
-		.sync_factor = 24,
-		.packing = 0x00,
-		.framing = 0x00,
-		.encryption = 0x00,
-		.bcode = BCODE,
-		.options = 0x00,
-		.skip = 0x0000,
-		.sync_timeout = 0x4000,
-		.sync_cte_type = 0x00,
-		.mse = 0x00,
-		.timeout = 0x4000,
-	}
+	struct codec_qos qos;	/* BAP QOS configuration parameters */
+	uint8_t  sync_factor;		/* PA parameter */
+	uint8_t  options;		/* PA create sync parameter */
+	uint16_t skip;			/* PA create sync parameter */
+	uint16_t sync_timeout;		/* PA create sync parameter */
+	uint8_t  sync_cte_type;		/* PA create sync parameter */
+	uint8_t  mse;			/* BIG create sync parameter */
+	uint16_t timeout;		/* BIG create sync parameter */
 };
 
 static void append_io_qos(DBusMessageIter *iter, struct endpoint_config *cfg)
 {
 	struct codec_qos *qos = &cfg->qos;
 
+	bt_shell_printf("Framing 0x%02x\n", qos->framing);
+
+	g_dbus_dict_append_entry(iter, "Framing", DBUS_TYPE_BYTE,
+							&qos->framing);
+
+	bt_shell_printf("PresentationDelay %u\n", qos->delay);
+
+	g_dbus_dict_append_entry(iter, "PresentationDelay",
+			DBUS_TYPE_UINT32, &qos->delay);
+
 	bt_shell_printf("Interval %u\n", qos->interval);
 
 	g_dbus_dict_append_entry(iter, "Interval", DBUS_TYPE_UINT32,
@@ -1949,71 +1943,67 @@ static void append_ucast_qos(DBusMessageIter *iter, struct endpoint_config *cfg)
 
 static void append_bcast_qos(DBusMessageIter *iter, struct endpoint_config *cfg)
 {
-	if (bcast_qos.bcast.big != BT_ISO_QOS_BIG_UNSET) {
-		bt_shell_printf("BIG 0x%2.2x\n", bcast_qos.bcast.big);
+	if (cfg->ep->iso_group != BT_ISO_QOS_BIG_UNSET) {
+		bt_shell_printf("BIG 0x%2.2x\n", cfg->ep->iso_group);
 		g_dbus_dict_append_entry(iter, "BIG", DBUS_TYPE_BYTE,
-							&bcast_qos.bcast.big);
+							&cfg->ep->iso_group);
 	}
 
-	if (bcast_qos.bcast.bis != BT_ISO_QOS_BIS_UNSET) {
-		bt_shell_printf("BIS 0x%2.2x\n", bcast_qos.bcast.bis);
+	if (cfg->ep->iso_stream != BT_ISO_QOS_BIS_UNSET) {
+		bt_shell_printf("BIS 0x%2.2x\n", cfg->ep->iso_stream);
 		g_dbus_dict_append_entry(iter, "BIS", DBUS_TYPE_BYTE,
-							&bcast_qos.bcast.bis);
+							&cfg->ep->iso_stream);
 	}
 
-	bt_shell_printf("Framing 0x%02x\n", bcast_qos.bcast.framing);
-
-	g_dbus_dict_append_entry(iter, "Framing", DBUS_TYPE_BYTE,
-						&bcast_qos.bcast.framing);
-
-	bt_shell_printf("SyncFactor %u\n", bcast_qos.bcast.sync_factor);
+	bt_shell_printf("SyncFactor %u\n", cfg->sync_factor);
 
 	g_dbus_dict_append_entry(iter, "SyncFactor", DBUS_TYPE_BYTE,
-						&bcast_qos.bcast.sync_factor);
+						&cfg->sync_factor);
 
-	bt_shell_printf("Options %u\n", bcast_qos.bcast.options);
+	bt_shell_printf("Options %u\n", cfg->options);
 
 	g_dbus_dict_append_entry(iter, "Options", DBUS_TYPE_BYTE,
-						&bcast_qos.bcast.options);
+						&cfg->options);
 
-	bt_shell_printf("Skip %u\n", bcast_qos.bcast.skip);
+	bt_shell_printf("Skip %u\n", cfg->skip);
 
 	g_dbus_dict_append_entry(iter, "Skip", DBUS_TYPE_UINT16,
-						&bcast_qos.bcast.skip);
+						&cfg->skip);
 
-	bt_shell_printf("SyncTimeout %u\n", bcast_qos.bcast.sync_timeout);
+	bt_shell_printf("SyncTimeout %u\n", cfg->sync_timeout);
 
 	g_dbus_dict_append_entry(iter, "SyncTimeout", DBUS_TYPE_UINT16,
-						&bcast_qos.bcast.sync_timeout);
+						&cfg->sync_timeout);
 
-	bt_shell_printf("SyncCteType %u\n", bcast_qos.bcast.sync_cte_type);
+	bt_shell_printf("SyncCteType %u\n", cfg->sync_cte_type);
 
 	g_dbus_dict_append_entry(iter, "SyncType", DBUS_TYPE_BYTE,
-					&bcast_qos.bcast.sync_cte_type);
+					&cfg->sync_cte_type);
 
-	bt_shell_printf("MSE %u\n", bcast_qos.bcast.mse);
+	bt_shell_printf("MSE %u\n", cfg->mse);
 
 	g_dbus_dict_append_entry(iter, "MSE", DBUS_TYPE_BYTE,
-						&bcast_qos.bcast.mse);
+						&cfg->mse);
 
-	bt_shell_printf("Timeout %u\n", bcast_qos.bcast.timeout);
+	bt_shell_printf("Timeout %u\n", cfg->timeout);
 
 	g_dbus_dict_append_entry(iter, "Timeout", DBUS_TYPE_UINT16,
-						&bcast_qos.bcast.timeout);
+						&cfg->timeout);
 
-	if (cfg->ep->bcode) {
+	if (cfg->ep->bcode.iov_len != 0) {
 		const char *key = "BCode";
 
 		bt_shell_printf("BCode:\n");
-		bt_shell_hexdump(cfg->ep->bcode->iov_base,
-				cfg->ep->bcode->iov_len);
+		bt_shell_hexdump(cfg->ep->bcode.iov_base,
+				cfg->ep->bcode.iov_len);
 
 		g_dbus_dict_append_basic_array(iter, DBUS_TYPE_STRING,
 						&key, DBUS_TYPE_BYTE,
-						&cfg->ep->bcode->iov_base,
-						cfg->ep->bcode->iov_len);
+						&cfg->ep->bcode.iov_base,
+						cfg->ep->bcode.iov_len);
 	}
 
+	/* Add BAP codec QOS configuration */
 	append_io_qos(iter, cfg);
 }
 
@@ -2758,9 +2748,6 @@ static void endpoint_iso_group(const char *input, void *user_data)
 	if (!ep->broadcast)
 		bt_shell_prompt_input(ep->path, "CIS (auto/value):",
 			endpoint_iso_stream, ep);
-	else
-		bt_shell_prompt_input(ep->path, "BIS (auto/value):",
-			endpoint_iso_stream, ep);
 }
 
 static void endpoint_context(const char *input, void *user_data)
@@ -2778,12 +2765,8 @@ static void endpoint_context(const char *input, void *user_data)
 
 	ep->context = value;
 
-	if (ep->broadcast)
-		bt_shell_prompt_input(ep->path, "BIG (auto/value):",
-			endpoint_iso_group, ep);
-	else
-		bt_shell_prompt_input(ep->path, "CIG (auto/value):",
-			endpoint_iso_group, ep);
+	bt_shell_prompt_input(ep->path, "CIG (auto/value):",
+		endpoint_iso_group, ep);
 }
 
 static void endpoint_supported_context(const char *input, void *user_data)
@@ -2820,8 +2803,11 @@ static void endpoint_locations(const char *input, void *user_data)
 
 	ep->locations = value;
 
-	bt_shell_prompt_input(ep->path, "Supported Context (value):",
-				endpoint_supported_context, ep);
+	if (ep->broadcast)
+		endpoint_register(ep);
+	else
+		bt_shell_prompt_input(ep->path, "Supported Context (value):",
+					endpoint_supported_context, ep);
 }
 
 static void endpoint_max_transports(const char *input, void *user_data)
@@ -2850,13 +2836,6 @@ static void endpoint_auto_accept(const char *input, void *user_data)
 {
 	struct endpoint *ep = user_data;
 
-	if (!strcmp(ep->uuid, BCAA_SERVICE_UUID) ||
-		!strcmp(ep->uuid, BAA_SERVICE_UUID)) {
-		ep->broadcast = true;
-	} else {
-		ep->broadcast = false;
-	}
-
 	if (!strcasecmp(input, "y") || !strcasecmp(input, "yes")) {
 		ep->auto_accept = true;
 		bt_shell_prompt_input(ep->path, "Max Transports (auto/value):",
@@ -2897,6 +2876,34 @@ done:
 					endpoint_auto_accept, ep);
 }
 
+static void config_endpoint_channel_location(const char *input, void *user_data)
+{
+	struct endpoint_config *cfg = user_data;
+	char *endptr = NULL;
+	int value;
+	uint32_t location;
+
+	value = strtol(input, &endptr, 0);
+
+	if (!endptr || *endptr != '\0' || value > UINT8_MAX) {
+		bt_shell_printf("Invalid argument: %s\n", input);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	/* Add Audio Allocation LTV in Capabilities */
+	{
+		uint8_t ltv[6] = { 0x05, LC3_CONFIG_CHAN_ALLOC };
+
+		location = cpu_to_le32(value);
+		memcpy(&ltv[2], &location, sizeof(location));
+		iov_append(&cfg->caps, ltv, sizeof(ltv));
+	}
+
+	/* Add metadata */
+	bt_shell_prompt_input(cfg->ep->path, "Enter Metadata (value/no):",
+			endpoint_set_metadata_cfg, cfg);
+}
+
 static void endpoint_set_capabilities(const char *input, void *user_data)
 {
 	struct endpoint *ep = user_data;
@@ -2974,6 +2981,13 @@ static void cmd_register_endpoint(int argc, char *argv[])
 					g_list_length(local_endpoints));
 	local_endpoints = g_list_append(local_endpoints, ep);
 
+	if (!strcmp(ep->uuid, BCAA_SERVICE_UUID) ||
+			!strcmp(ep->uuid, BAA_SERVICE_UUID)) {
+		ep->broadcast = true;
+	} else {
+		ep->broadcast = false;
+	}
+
 	if (strrchr(argv[2], ':')) {
 		ep->codec = 0xff;
 		parse_vendor_codec(argv[2], &ep->cid, &ep->vid);
@@ -3120,7 +3134,81 @@ static void endpoint_config(const char *input, void *user_data)
 	endpoint_set_config(cfg);
 }
 
+
+static void endpoint_set_metadata_cfg(const char *input, void *user_data)
+{
+	struct endpoint_config *cfg = user_data;
+
+	if (!strcasecmp(input, "n") || !strcasecmp(input, "no"))
+		goto done;
+
+	if (!cfg->meta)
+		cfg->meta = g_new0(struct iovec, 1);
+
+	cfg->meta->iov_base = str2bytearray((char *) input,
+				&cfg->meta->iov_len);
+	if (!cfg->meta->iov_base) {
+		free(cfg->meta);
+		cfg->meta = NULL;
+	}
+
+done:
+	endpoint_set_config(cfg);
+}
+
+static void config_endpoint_iso_group(const char *input, void *user_data)
+{
+	struct endpoint_config *cfg = user_data;
+	char *endptr = NULL;
+	int value;
+	bool found = false;
+
+	value = strtol(input, &endptr, 0);
+
+	if (!endptr || *endptr != '\0' || value > UINT8_MAX) {
+		bt_shell_printf("Invalid argument: %s\n", input);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	cfg->ep->iso_group = value;
+
+	/* Check if Channel allocation is present in caps */
+	{
+		struct iovec iov;
+		int i;
+
+		iov.iov_base = (void *) cfg->caps->iov_base;
+		iov.iov_len = cfg->caps->iov_len;
+
+		for (i = 0; iov.iov_len; i++) {
+			uint8_t l, t;
+
+			util_iov_pull_u8(&iov, &l);
+			util_iov_pull_u8(&iov, &t);
+			l--;
+			(void *)util_iov_pull_mem(&iov, l);
+			if (t == LC3_CONFIG_CHAN_ALLOC) {
+				found = true;
+				break;
+			}
+		}
+	}
+
+	/* Add channel allocation if it is not present in caps */
+	if (!found) {
+		bt_shell_prompt_input(cfg->ep->path,
+				"Enter channel location (value):",
+				config_endpoint_channel_location, cfg);
+	} else {
+		/* Add metadata */
+		bt_shell_prompt_input(cfg->ep->path,
+				"Enter Metadata (value/no):",
+				endpoint_set_metadata_cfg, cfg);
+	}
+}
+
 static struct endpoint *endpoint_new(const struct capabilities *cap);
+static void endpoint_init_defaults(struct endpoint *ep);
 
 static void cmd_config_endpoint(int argc, char *argv[])
 {
@@ -3154,6 +3242,7 @@ static void cmd_config_endpoint(int argc, char *argv[])
 		if (cap) {
 			broadcast = true;
 			cfg->ep = endpoint_new(cap);
+			endpoint_init_defaults(cfg->ep);
 			cfg->ep->preset = find_presets_name(uuid, argv[3]);
 			if (!cfg->ep->preset)
 				bt_shell_printf("Preset not found\n");
@@ -3174,22 +3263,34 @@ static void cmd_config_endpoint(int argc, char *argv[])
 			goto fail;
 		}
 
-		if (cfg->ep->broadcast) {
-			iov_append(&cfg->ep->bcode, bcast_qos.bcast.bcode,
-				sizeof(bcast_qos.bcast.bcode));
-			/* Copy capabilities for broadcast*/
-			iov_append(&cfg->caps, base_lc3_16_2_1,
-				sizeof(base_lc3_16_2_1));
-		} else {
-			/* Copy capabilities */
-			iov_append(&cfg->caps, preset->data.iov_base,
-							preset->data.iov_len);
-		}
+		/* Copy capabilities */
+		iov_append(&cfg->caps, preset->data.iov_base,
+				preset->data.iov_len);
 
 		/* Set QoS parameters */
 		cfg->qos = preset->qos;
 
-		endpoint_set_config(cfg);
+		if (cfg->ep->broadcast) {
+			cfg->ep->bcode.iov_base = bcast_code;
+			cfg->ep->bcode.iov_len = sizeof(bcast_code);
+
+			/* Add periodic advertisement parameters */
+			cfg->sync_factor = BCAST_SYNC_FACTOR;
+			cfg->options = BCAST_OPTIONS;
+			cfg->skip = BCAST_SKIP;
+			cfg->sync_timeout = BCAST_SYNC_TIMEOUT;
+			cfg->sync_cte_type = BCAST_SYNC_CTE_TYPE;
+			/* Add BIG create sync parameters */
+			cfg->mse = BCAST_MSE;
+			cfg->timeout = BCAST_TIMEOUT;
+			if ((strcmp(cfg->ep->uuid, BCAA_SERVICE_UUID) == 0))
+				bt_shell_prompt_input(cfg->ep->path,
+					"BIG (value):",
+					config_endpoint_iso_group, cfg);
+			else
+				endpoint_set_config(cfg);
+		} else
+			endpoint_set_config(cfg);
 		return;
 	}
 
-- 
2.39.2

