Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2040.outbound.protection.outlook.com [40.107.247.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E289E2554E
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jan 2024 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P/MPYYd3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Deyy8UIZ3K7gxcdd1ZIeIs9C7Osa6m5EzELNlZe7gYFZjdwI9yEBV8F3/rFPqGj4T/CigtuJYgcNwZ38mBdw4uAmGspz5PCSbQsj5VevTT+Bebl1UOpvLjaJ4iRih6TmI9dx/53aoMI+ijDRbeY+74qn3at9r4+JSutvWOHtOl8qfTf3jT+vYl+PHZgpUGedxVKR1VUThWfnJ6hjh1AiFvPWgQPyU1xfBcrwwWxxL/GFmNRUlI7oRaQQyHkmiO0Jy/5U3PZ+Dq8wkItZv9Ibbll6Y+c+4MVhiBHg3Sr4kjQ+C7EYcppjBKW8mW3r4dfrhVQHLy3zc3Y3tvxN/q9e1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZh2OTEAcQ7NdEKbiDEHt6dP6U5R2Tir7dDuba66QtA=;
 b=ogoShDlKbNYWkPsRA08VPRPElbujBTq1Z6lUqzlRVp1PaEgo9jvn+Gg/NJ3QaIEthlLIYOPmIUJbV6md7fyZp10VkXReo7cpDSRxKHnroaJmTkpkpOUSg16eQhNzTyCXWUnC+/FaFEvfMELkKhp6rm53ETDjL/flwwMqOjCCyHrohugmE+CyMVkbyERyOr9R0KoEDT3J4ugV11UeyPi6hDazUgCX8keN/dxIa84V6YTvEMnYFPG6PFuXw1uYAEO5iM3TdKBSFC/MyJ72NUCxOqXDehAn7kBhIdrOB9s+x+TDDK2e7maLlDVE+XlrJcseoaa9ZfHWB3kxsXRZgAwY5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZh2OTEAcQ7NdEKbiDEHt6dP6U5R2Tir7dDuba66QtA=;
 b=P/MPYYd3CNXYSEF/WxDdgPS23p1irBBUoh98rslXvptUgW2dLeX5Gd3FslIZaRTCccguGFDt1+qa9gCfODec5kEE1ITJs5ervNh1VG9rpyV+fsolYhW/r9nDjhUx1KhH+iUS0ar92KiTB51Y8wlWG9xm9tTzsq+O4+12faxTyLc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by DU0PR04MB9370.eurprd04.prod.outlook.com (2603:10a6:10:359::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 14:33:40 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%6]) with mapi id 15.20.7135.023; Fri, 5 Jan 2024
 14:33:40 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH v2 1/2] client/player.c: Add support for multiple BISes
Date: Fri,  5 Jan 2024 16:33:33 +0200
Message-Id: <20240105143334.7248-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240105143334.7248-1-silviu.barbulescu@nxp.com>
References: <20240105143334.7248-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0063.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::16) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|DU0PR04MB9370:EE_
X-MS-Office365-Filtering-Correlation-Id: 20a97a28-16d6-4edb-d0a6-08dc0dfb4f8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xC8lEzANqPCU/gUCPy30iJK+BZv0fxxZe4EdynNUlYAnEIQG669CoeLS4a/Mej42ES6uy+CXWPe62qjYhSz7Nrvr/C1/Bxjx+YGYU6rWfHdgfErd/x+TK5VQyoAeMifNhDeBOy6Uz4P7h1IeidYE2OwSZhKtLcjJfIiMN3qmZVdKP/gRF+fpIAWEX2et9WmFRB5TjfqpEq6b34lmoZZ1nEJ/HQEWreNFN+687nBPVQJSmt5ovwgmg8tBTIRYEV9hKx27fO8ALphXdk6WFwii8jiTaktQdJwZBLIIH83XIqk8RtWGkiWGbtGZj4yl6Vs/lhHG+B22ZA0FBmp4S3eviW/xzxjj2NrbqLgzOHaAOaTOmrdd4aa9qepUWBqGVWXheDTEi5PiqCmz2Vxi8Me/xSXOYaMNaaKKPvwK/NvMaMzXi0CpMJMZrR6dywbmRCZqXWqLGS/zCbEnAKuwPQOcEToj/6+H/z23JU2msfBfba8URlmXnFbR9k41Oy7hFmKXnKccVTr1V72xegDZRhaSDur0yBgGwvMi2FdJX817ZzT181wvq2TK/x/RZi3vxMfL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(376002)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(38100700002)(36756003)(41300700001)(86362001)(6506007)(316002)(6916009)(2616005)(66556008)(66946007)(66476007)(6512007)(6666004)(6486002)(5660300002)(478600001)(83380400001)(30864003)(8936002)(8676002)(2906002)(1076003)(26005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xE5kssaIhAOCtxboleHc1OTuO5+jBTgNWmHSoYv4L56Ab4SiOrZAAtBAFT5A?=
 =?us-ascii?Q?35Mmem1H0Bxi21SWGkTmCgZKjgEAIJcYHnTjzudbYA++BAsjNeS5ECx+fhwI?=
 =?us-ascii?Q?D6YvOXLHfSfmAJ5hpF1oT22G1Q4nLwEMUj6vZ9TYGlTukh8kIjVa0m+wqCt+?=
 =?us-ascii?Q?kIrKJCWL/AivXwJ+De7joPARAjyZXtkZRFFXxvGTad6Ja6DShG+Q9BOmd3xF?=
 =?us-ascii?Q?/PyXBKzLmFmZjNp5piq709Rs2uMZCJ3lMg6LZHzelr1k/l5CyltDliZbUqxn?=
 =?us-ascii?Q?VCoVr3HCpEfarfRMz5XaXvxEP1F8KUv4gis4fPJOpTwaDTB3MuMACJ3dtqDh?=
 =?us-ascii?Q?dXLt78aC1C2BUyMDQp8AOiXYodhIBbJJqoIefHoyNV7zCoNtxBoH/G0EQAZv?=
 =?us-ascii?Q?X57TerCsex4fNHdXJyIAYPdZo9ppEDlncDGJZ2AwbmOrVEYzj91H2Mvy38X0?=
 =?us-ascii?Q?wXsOpGNpwedY4JWloYz6fTvewdCHNccuOYjH2DAditv6rKVPZ/3q3fQwI+TK?=
 =?us-ascii?Q?O80JlPEK71Ia3EHTkTMwtmvIkJ81b+y3DQtaX7m1TaaDpIgxuGNzmsmtBFAv?=
 =?us-ascii?Q?HVLhjB3TEdP9QHw7A9MlMDjtZRkfsTN1yR4gD+8662exjQspIxpAI0szsAUL?=
 =?us-ascii?Q?ByO3dt8uhAki12YuSZHkmaVr1mgnd3gVBALQkzTOyVv8cqrTok0c/JMzFb6R?=
 =?us-ascii?Q?m47h9HEbnoe/yk/F0wTH+7UtbtBX0bvpjIUzp8zFnNfjuCrZK+affXnkvwKy?=
 =?us-ascii?Q?oVd0SaUTLDU4cSn8Rr9uN79oOKB3uUZa/yd0k7KfW+maxDdEuy3choH5uhJb?=
 =?us-ascii?Q?1f7SMJYa9+R4k+SOAgBr0Dn0c+qZdzV7dFe9/FBMmSPm/5D/bBUqiIACYb1l?=
 =?us-ascii?Q?qy47NhUaUmGNjqh8xumXBeHxYiJgWPGG10wA1OeCIH8rR5R54poHemU+0aNV?=
 =?us-ascii?Q?B1aMEgKOLBr4l1wS956u5SbIhK4AqOsN9ZbmCYRWl3US7Ef0fXn+iTcuAwNx?=
 =?us-ascii?Q?DVzuX5oHorX/zfVfwznDwgNkPdxs5o+mYM5qLq+d15HRr0/hw0B1keRuGLYB?=
 =?us-ascii?Q?CaR2CgceHmqPRm697VHGndl2yUqNAdRWxHojhUQJEyeHnqpuQoDVLlp9oKAF?=
 =?us-ascii?Q?sqiZuD6UOSbpNwVWXtG/7IWoBuVDpQbAsRWb1P/yUl8OfShbPW92T4Uwix1G?=
 =?us-ascii?Q?U+fYF4mdbgovNTEJW6ZN0wA18W88hS0X8HeavD4wh9oBz4QnnO5faNKlI21Z?=
 =?us-ascii?Q?QHyOVIRjKc4ptc9HEUDYx1tU/1AtwLaqIeavEp4fF4LNXp3vlTt6/isMsd5y?=
 =?us-ascii?Q?1X+dkrsdbdUCWywLXUQUn716B3I4rtp22dnp5uBadEY+8vubgN25fTpA/0FR?=
 =?us-ascii?Q?CYxSGOQYJRyX/yrz/pubMTB+N+2hY6F8iyQnhglbqjqBjOfPoUQ915LcfEk9?=
 =?us-ascii?Q?HVYls05+U8ITGQb/usboDjstWtWZe+gPANQHKU59SCgPiCua4jpFWA4k4zlg?=
 =?us-ascii?Q?YDSnHr5pomaLD9x4L0jA8ksj0uPskVjB60Rv6Sd5IAYdaXNx6vnLzKL4jp0X?=
 =?us-ascii?Q?9n34VUhE3ZXMyvTfKV8vrOCCFGWm9a5r8jptAvDWryziBtfRqWfFmlaylx2B?=
 =?us-ascii?Q?og=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a97a28-16d6-4edb-d0a6-08dc0dfb4f8f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 14:33:40.4271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Axqez2ZF6o9EEbdfgy6UIvqWUPRxEG8BJFJcZNi/lInYIdMHG5d7RGLbPVFa/F1ZfzupR/0ctPq65k30+Ms6U/43p0gLWZkogyCZDBfchWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9370

Remove hardcoded base and QoS for broadcast and use presets instead.
Remove BIG, BIS, and context from the register endpoint command for Broadcast.
Add Location and Metadata support for endpoint config for broadcast source.

---
 client/player.c | 301 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 201 insertions(+), 100 deletions(-)

diff --git a/client/player.c b/client/player.c
index 92fc91f92..cf4d9a4f2 100644
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
-	const struct codec_qos *qos;
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
+	const struct codec_qos *qos;	/* BAP QOS configuration parameters */
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
 	struct codec_qos *qos = (void *)cfg->qos;
 
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
 
@@ -2748,9 +2738,6 @@ static void endpoint_iso_group(const char *input, void *user_data)
 	if (!ep->broadcast)
 		bt_shell_prompt_input(ep->path, "CIS (auto/value):",
 			endpoint_iso_stream, ep);
-	else
-		bt_shell_prompt_input(ep->path, "BIS (auto/value):",
-			endpoint_iso_stream, ep);
 }
 
 static void endpoint_context(const char *input, void *user_data)
@@ -2768,12 +2755,8 @@ static void endpoint_context(const char *input, void *user_data)
 
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
@@ -2810,8 +2793,11 @@ static void endpoint_locations(const char *input, void *user_data)
 
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
@@ -2840,13 +2826,6 @@ static void endpoint_auto_accept(const char *input, void *user_data)
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
@@ -2887,6 +2866,34 @@ done:
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
@@ -2964,6 +2971,13 @@ static void cmd_register_endpoint(int argc, char *argv[])
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
@@ -3110,7 +3124,81 @@ static void endpoint_config(const char *input, void *user_data)
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
@@ -3144,6 +3232,7 @@ static void cmd_config_endpoint(int argc, char *argv[])
 		if (cap) {
 			broadcast = true;
 			cfg->ep = endpoint_new(cap);
+			endpoint_init_defaults(cfg->ep);
 			cfg->ep->preset = find_presets_name(uuid, argv[3]);
 			if (!cfg->ep->preset)
 				bt_shell_printf("Preset not found\n");
@@ -3164,22 +3253,34 @@ static void cmd_config_endpoint(int argc, char *argv[])
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
 		cfg->qos = &preset->qos;
 
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

