Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2070.outbound.protection.outlook.com [40.107.8.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE6A4CB30
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jan 2024 16:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PUuMRW6k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjV7u6TV1IQc2fQCnHkhEkQUkk+ZKB8IE2tvUCRoXVcybTdrDKHXDWb7VU939kThFzkg6PWOIdFV/t1I1+euISgcPkMqXMxQu7vnOC50fX8A7E9EGjTh50e4YGdwGgIL2TRIceUhnlxdPDAkLWl8bpN1npBNz/fA1VtyVqWz1SiYbiKewhJC014xxomlgN1rnoM/BfVUnyx7L3kZgG4siCObVZqg7MXz/WkYaST3ywJlyrVt5Ud7+iscPPCHdG+9o78w4ClBa2y+SBR5DqqjJCusexc9UPU8CDFSRInvoguIPzyYxnXqGkgIHTMAGj/eTDy8Js5C3e3NFcCm7mTDjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJBEEsQIjv4GM79rToo4bTX/YIB107JykBQCHWnMWm4=;
 b=g+Uz9mZgM+5lpt1cZpdcCgud8wv3EqMIUI0hr/BMqnsZmXtM9eWZX5RCQHNcAuwB4ndZshb77oLWXSmzJ+g7wtO/HqSVvjdIIII3VZ+HmBD7eopJPpujQ+VprJURwLTleaqNNExlfZlHpggTlKxHWSpQJAS5Ut37RuY/Jnulz2wtvI1E82zl3WzoBoDlqjivoV7PrhKNiEkfeCO3NlnZ+/KGcJFDeWEIn+T93qX1SieLpz8wNU91m12lzlq7CbFUHQYVW2PAh2/Oy/UT3XW+dr+ciepJwas2JtKWuLNaXRcPkQ0KEAQOl7aq7Gy/vlGr73jR9a0B2KmUXQpQP6Tbnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJBEEsQIjv4GM79rToo4bTX/YIB107JykBQCHWnMWm4=;
 b=PUuMRW6kvhT1Y+DSSJ9KFJWTI0nor9JVFXwJbbQmUBXJeMCffaRy9TgnqUFkyT3P8KfMIMWcdhIballeHhT3+Kg7FQ0iXgfqX2TK49sW3YQKJh470xUhl+k5nPGJF+6oQvJlFwnApLVrXvELAkXd7sfcfArrWDnZ9yWUCdh/+oM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by AM9PR04MB7539.eurprd04.prod.outlook.com (2603:10a6:20b:2da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 16:58:33 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 16:58:33 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH v5 1/3] client/player.c: Add support for multiple BISes
Date: Wed, 10 Jan 2024 18:58:22 +0200
Message-Id: <20240110165824.114022-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240110165824.114022-1-silviu.barbulescu@nxp.com>
References: <20240110165824.114022-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0079.eurprd03.prod.outlook.com
 (2603:10a6:208:69::20) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|AM9PR04MB7539:EE_
X-MS-Office365-Filtering-Correlation-Id: b03b8148-cc3e-4a04-116c-08dc11fd6111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nPLJU0lR9j6UHmAL/sBJUnQXfEWYPJLqifQngFMl94nqdfCysnr7bVNjuK9+Gdp91kiEfQshzBL5RzFhy25NppomEvEeU1RDVCGh+WdaGvuj3znFXxSqeY4rTvLDwH5jKWwIWs+iynCElrY5AgpNl3optrcL/EqH/ub6puIA8DseFOCEYo3T1AMvCdkmljwG8lvHaYW6BotqxvVtfH+PZUGggB1peG4zHXavkID55lsRTN1eaPBK05vn0nbDDruH8J4ol9JnHtVvvejlF+uz0tmgJ+160T7mJ4oL8liTeLKWkbnJWWlee1vlr3myEUtKn46zrqIbZt3MzTBsGVU4MXuh5Y1potn0cwiRDFDFwPo1oqBG3GKvkjLI/Mmq7vWATZxQG2xLna7m1jARQ0wsENinI8kSVa0rzCSWmAcbXnJrxY16vlCESAKhyrDdbcKhrL7/Gi3kTIxSzVqII+qvH1CLw6rJr12jnuSG0j6Bg364jAi95MMWIlvdr4IpVrqNbUOmiqEZpBHPnHAjnUCphNPWGoYhr+ZXOo2FPskyE09C4Zp2BP+WKQh4g1n8vB8j
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(83380400001)(41300700001)(36756003)(86362001)(38100700002)(66946007)(2616005)(1076003)(26005)(6512007)(6486002)(2906002)(6916009)(66556008)(66476007)(478600001)(316002)(8936002)(6506007)(6666004)(5660300002)(4326008)(30864003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i6NhkJCbigkwtYx58j54pqAmnG+5ku0OrSfVMNiEP4x/g2n3DV1QL06vyQnE?=
 =?us-ascii?Q?wKIRtojrILu0oLNUh+VrhtWZ/N/A5DotA3XpwSEg1ilA4oLJa3OGfwmvX+7V?=
 =?us-ascii?Q?4U0A079ayEJhkPw1U7DYu7W36HV14bnG17mpb8gI6fi56agBFpKjXj5qJ5UX?=
 =?us-ascii?Q?GiGUMu+ZeuYMfMjvBZ8c8fCycuzyEUqDmPyW8DNeww9pqMaeMWZhTmc2aBBJ?=
 =?us-ascii?Q?o/SsTzaT0bJg0lKx6hzqbD/PENxEGlkiHoH7bTRf2As2Ch2ECo84AlR1YRSI?=
 =?us-ascii?Q?nHl2BsOBV8S5pNZUBOTlAnAfu/b40Ts5bjKMFidyDYkt7Gv9plromjZuEK7X?=
 =?us-ascii?Q?5WAlVTy67wmHYX0hoRmY5WO6RhxeIyE50Odea84r+yAeV7gle5lI7dWZ5kob?=
 =?us-ascii?Q?qnTK6VQEXeyMgdDs1E6QcK7g/3OlKJ/RrHQMZij2d/sKWZ5oLvE31mIPEm+J?=
 =?us-ascii?Q?lkpuHOOskSWcyVh5LE7Js0SKL2C2GqyupTRZmZ0zmM41CJqtA9d8E8GdC7ZO?=
 =?us-ascii?Q?w9kKB8UtcjxqUPN/FMCJL1QwXtqiMFcBBzkBkIuynlOzxHZje6D/TH/WZeEN?=
 =?us-ascii?Q?GIfXTnqNI+6QWykYC72tkgC9lpH2XSONDseqKtz9PyusG5bTG6JfgKipshmq?=
 =?us-ascii?Q?/WM7hBee8SN4GxE6Gvt2ZgbUqhkBkS8i4GJqOjuhPrSJAT/zVgkkdqUultjO?=
 =?us-ascii?Q?nsL2Vfrp18S6CyLZab5ZI3Uhr8iISsAiPMsZk1MzgsT++hz13z7OpfXY9l+2?=
 =?us-ascii?Q?K4wvIml9E1l792sY84/2l+eS/6yVIjjtoqlYqqPN/q/tLT0p1nUxdKzcMZma?=
 =?us-ascii?Q?oMjxOLqANEqwp7IdUKxsugBj6I9bKsx3UbDrVRTUrqgIJADYqUUogoirujtj?=
 =?us-ascii?Q?iOWsoBj7syTowK/YNdiZV7xEZoZ4qeSyCB9RFiyh0zlRsDuxUrF+7+5p/iih?=
 =?us-ascii?Q?751sog5hkbGmkINkpZqUHI1DH6N9Sm6RfwZLMbEWUTpEO6mZT+kya/Yd+KIB?=
 =?us-ascii?Q?L15wYBpxV3X58RnHN2fgazGJWVIUdUfiKIzEi7aIPdbum/FhsOtLdOWGNjBi?=
 =?us-ascii?Q?V6lPrSU0Ik+LPG2Q1f2w5WJfSpoEJGc1zqfOsqtz23mpSFC0JiCMwLW6XYif?=
 =?us-ascii?Q?DjiGFb2zxVtwCEfuIeAcen3DaDTu2SL70OVv6KMdkri6QLtJGF4N9OBsI1EG?=
 =?us-ascii?Q?lB96Ucd8seLSrQVd+z0fk/WlNHLweo5ucCG1LC8sPIyZY4QRXxCscB1XrxfU?=
 =?us-ascii?Q?v+FXlfyIujaMfloKhHfuqZ0VNpB4MNwoh2etUZtuijyS/xUMTKlmMscs/w7k?=
 =?us-ascii?Q?bLZwyT+iIWdBfkrDX4gOn+x2qVAur6EWqt/i7CbzEwA0vSuKTa4icOdYcAvr?=
 =?us-ascii?Q?kbGSleRqzhfoe78AZoUWasAK6j2h2OwgE8PyTWzqN7n5u6Wtj3olL+QWvfZy?=
 =?us-ascii?Q?f753xiJwvrV/0BB9yGQ/t4vxJknZNgs/Sxr/RdAWF+sbw3pw6NLGt8BhYfF4?=
 =?us-ascii?Q?KaPHkeTS74BR1ziV/iiIIhRZwrpY2+4TFqzKQ0DDCJZU81eRjLMhZyNbCaj8?=
 =?us-ascii?Q?oriH+QN1SkjG+YU6JreI9aPuZvEAultBttuB0UlSndhpvw6QDQElkNw5JjEC?=
 =?us-ascii?Q?Gg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b03b8148-cc3e-4a04-116c-08dc11fd6111
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 16:58:33.4830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SsgvnFNSYI2CEwdRIHTIYiPSkqxhHkcpPLmaUl4aYZWyoWXcjY/8zlSyMoBeprApnFxJKcO3UETb8ZW4IWNhUE9jLWOLuAG1awTwUkPYOis=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7539

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

