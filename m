Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2075.outbound.protection.outlook.com [40.107.21.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FFD5EE97
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 12:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014319; cv=fail; b=O5p8aBXOKRdvxCJ95nN62SDRUUmywVKpxt6E2h2OQlSwZpvHZg27wnTan5R0E2XCyETle95Yoc2cTRhRd38TWhslQHHqze62RpeHXMuuH3qbOdseqh53RM0fSx/bP/MM5J7n+UN9iamPh6tlAoMdRZSa3IAGwzNQvNgMZBNDAKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014319; c=relaxed/simple;
	bh=ZJ2GS3wokN043gPS02tPZb1yXmr/6o7okwFRjJM2nwk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JjpnhAj7aCAqZGS/b18OY18BuM/0TnHDLcgwLEQs2UsPFWC3W50QsHBznx4zllOnEugnPtBbbtD3bu3pjHxW0JjM70+zw/QhRSxU55YdIEmT2zTCwnPAOZvUQ8HSBAKOOvWEj23BZFMPiYRbS+kDCcGnpIUdeKT9sg6ubRSSyq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CU+hp47c; arc=fail smtp.client-ip=40.107.21.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CU+hp47c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlpkB9y4QNtcOC0H4wgAL78eBSCwMivbhmi8E49cY2LpM7Y6R6QSyoEioZ4p3ZEjJkro0vRt4PRmvQHy34BikMT/Dcw3XkTE7lAU5U3ZNi66t/9g9GWsht7NvOcK9KxImH/poZOaniFK4elMH0o3ddD8gddh9i70bERbCiLhzSRHOSSyjPBIs3Z9PUeBXLwCasJilUKN1mdJRK85fTfZgEyD7Ju8IwNiljkEoFb6TlZzaF0b3LKSe8hKgVFEifw6Bn1It7ZwRHBqmlw9D1dRIh9tRE9lVFPsuZdUoDYFDrO0Re440OULGpoVsBUmfSvJgXnRgI1Nsm1wJnjxABhjdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2TuUu37+KUMc1GodPeNEpXticwqsZbzRNnx8msHobA=;
 b=YUow1VnogQdLzQfTK9+mFMZgQ+8rAvceU8A4qkN0VyitIXlQwCEjkAty4zznycbLGdFN+78b8nU5pH9qsdaQq2t9hAf0q1Sdr8EN3xSKdqF3stbnWL9i42b1eRJmIjHLb7TOrISgXoBUNJ+qHJKMDAK2D6dv0h1Vi/YL3aTBxSK6Y0b2OLhX8k+8blIjBvjgta7cgEkTUng7pmBaTh469REqQmccd9JBAIWKnWfuWGUygMp8ySrfuqXq8HluIopDovCJ7sUiweqZsh+n05DxieG0Qol8HVwwBfyVqbiWmwycT4gDLK4NZUSnU+mnUyTMjslpPhlHxTAxVUrAa760XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2TuUu37+KUMc1GodPeNEpXticwqsZbzRNnx8msHobA=;
 b=CU+hp47c4l1eI9feaxdceFSt1c8/voM3nSSNiW6ZkOY/WUKpS7i9HDdguaHnuX566E8wyJ68gnCjh3bis72svhv16fjHMRf8C5KLaOwLTAdTAhOrfZiBcdIhKDUg2YhDsOYpVirisiHtJ/NKQU3Wj5NeF2Aps+dcgwv2dCwkfZg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by AS8PR04MB7864.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Tue, 23 Jan
 2024 12:51:54 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 12:51:54 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v4 2/3] client/player: Remove hardcoded BASE from player
Date: Tue, 23 Jan 2024 14:51:44 +0200
Message-Id: <20240123125145.70371-3-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240123125145.70371-1-silviu.barbulescu@nxp.com>
References: <20240123125145.70371-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0031.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::11) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|AS8PR04MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: 11c437a3-ae9e-4cb8-3e99-08dc1c1213b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aWCEKzXrfuNKTe4ry0Z5xma0Nd73wiFxv9FfGkFzTcPjaayk1YiaGM5vH+aREOrpz9AyZ5DDCBG7ockMuWEQv4/Y6n1nmg/DffT04snZnvB24rBXEPjsFo9GkO1Ie/aXbpWP/txzZZV9cZvVFVD92BIyeMJVQFFylGxRq/elSZJk/HUOpj8/SIJ4fYQVUemTk6FzVQmlqy4MW4qtd5ILcKu6kNLydyvn4SNT4CvYlgTto6I8TLVIQd90RAu+kPiUB8XOGaTq3e8E3sN+EyzIgMGsWRtIIrrdpTPOL2xmA8SaEgR6pd6uWzuNBOq8Ia99ma59I6LKPvDb2Pw3EFkyzLGOqojvuDwNnha1IgQ63Ca4gl96Ez4EG70cZoGoSrqIJ4kzro+9Dy+NFlTkwLblnhMbUP/Y+OI5b682qgEvlFcVKMUl6wlGeizaI24bLU1Oepxg+FBBerJECCsFqovq5Wj2K3Gx/2Z56ZAuhmzuUUulGnKK3r2baJAhmOuTRV1eu5TQF5MYSJZZNkzuZOVaA8GWGzeS5sndRVL/7fOGDROjjivQHWcjnEYAG0qEAo14
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(136003)(346002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(5660300002)(8676002)(8936002)(4326008)(2906002)(41300700001)(1076003)(83380400001)(6512007)(6506007)(6486002)(478600001)(6666004)(26005)(2616005)(86362001)(38100700002)(36756003)(316002)(6916009)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0XXFGE8osNu3e+QHVlj2bd1jdBvfNfX1g+YuWwDxUda5dsVkbtfjYUd3U3HA?=
 =?us-ascii?Q?xFLPX3tfc2eWlXpVCo6NZBVKSHpugqda+B7lshjFdOfpZZhDGOpR+BouKMAE?=
 =?us-ascii?Q?C2Z9f3tnpf2cK70aPq3nIYEDY6pp4w4bxS7ITCpvDIwIdGKvJU5/6tIJ3CbQ?=
 =?us-ascii?Q?/S6XTJG805PQJV7x6Bj2eUWBMeodXjkPVdvZt1HJ7Vm//NZ237Gt74qV7ZCm?=
 =?us-ascii?Q?qpNk0duI+O+cDhr1WG3Q7B6AuJEXawwYTunU4D1gVCqL9yyBwxZZ05Q9vjq6?=
 =?us-ascii?Q?ZcC2lHo8elDl/owgI1UEW3Gkg98L8xtuz6e6B9i/3aA3VXt65ZdG30mp7bt1?=
 =?us-ascii?Q?tzABOBbbQ6Qy61EoU5jC7909Q83EfyAQT4Aoz7eTUJlvccnouprkPd/k1byp?=
 =?us-ascii?Q?VQptZSPvWyO5a8I18QXd0oaW2qlembRoZUsnZcvYjSl8Fx7u8Ehpg8D6WY43?=
 =?us-ascii?Q?wjjohFlUo2pnIbCEhyzyvL/FQR/BeSS5OsZnnhSLcko+2ECKRLZkULcisB0I?=
 =?us-ascii?Q?VvJ5kbimHVJ2RfOTAH9oTuajgXxQH1LGi0X/5fp7M3CQ+au58ixoCxWInhoZ?=
 =?us-ascii?Q?0vT3lgW1tHE0QfvrDNuVTUuNPg8Bmz3U+Afe/1MKH4uxeV0LCZ203Fr1nJbo?=
 =?us-ascii?Q?OBe1gSrPhoJFHp2PS45a8c9xOChjele3akRl/bW2EEsqhkycdNed7R6ksUUT?=
 =?us-ascii?Q?12iXzcAzBmaayGoKK9Dg87GKg1ivMqL8jbAd5iVyWNR56XPDFQxBSh+I4+JF?=
 =?us-ascii?Q?j0Szmc9d6rrO2+e1DvayzMt49bBFyV0NeRdsoKlzt+yETz1ADcskbHojLeNM?=
 =?us-ascii?Q?TlLpH6+M/nl3GpGXWuK3s3vaz12wK8DM4boeQGREEaaNXL3GGU6OiCKLGjB4?=
 =?us-ascii?Q?OBrdCUFa3FjxbUL4ziRXI97utb0b9Z1wf9SRrephXArFgGNuFVsOSGdX8bA1?=
 =?us-ascii?Q?a3ZgME/RO5ihhPUpZE6/a360O2bOcM6teh1QS1uTn4lBQCGHdnT12IPeUjUJ?=
 =?us-ascii?Q?mqfCJwhI/HBaTCKQ39si04BWWXgjkG/2q6d1iGz0l+68vwd5xlXp10PdL82K?=
 =?us-ascii?Q?nSn2UujwVjMYzUfOxkDA1xEEbNKYnc9jSrwHTRdjGnBw7UcTXEB/CWfP3d7t?=
 =?us-ascii?Q?xDAZgNeY5OiHx7+lp48OXa+sH24G9mpGiNi+UTVO2kHN0ZlzOLjLuTjORpoY?=
 =?us-ascii?Q?FA7S1DDxN4lS2YlOeQmQqiVcfvAx4pK2qI35AODGdf3t1SOAevr4QEcfyTNt?=
 =?us-ascii?Q?mTR+z8So/Z4WcnM+DMvm/Q3yudWWio6ppXBQqkJgAAupBfbGkMO3PQmKAe8k?=
 =?us-ascii?Q?T3M94bZrFgsrG0J+iknalUs6soUzTXjV/B32+OcEwWtFWXE+ZHWDZVHi+wwM?=
 =?us-ascii?Q?G/0a7TzcbEL4ViJfOZQ+tQWPCIA1rN5uT+Jjk3xCyQFlvQTDyANpMHpm7lPr?=
 =?us-ascii?Q?GUVtokr9JoNPtxC3Qe90TQ2c4wUXE63aKK8a0GlQXk2wi2LVaYXPt0ljwSLQ?=
 =?us-ascii?Q?sLZeyFJ63PC+w2PFg4k6wt4wPSaifUZOrFMMlBGbMh4RCsjVp4kEiLrgQFxT?=
 =?us-ascii?Q?vXYAskaTL56srH1cjiCmsk7NFTVCv32eatB31Pt53N+dgIL5FB9Erfo+whFN?=
 =?us-ascii?Q?fg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c437a3-ae9e-4cb8-3e99-08dc1c1213b8
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 12:51:54.7037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJArlVx0D1H/WIuVumQv2Ce8jIt0ouyXanQvDPrGyotobzK3px006c+H2DNZSbLMyCOFSKI21CvGdjUBBOyQSFWV4go7J72m4Oq19E+5FME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7864

Remove hardcoded BASE and QoS for broadcast and use the information
from the preset instead.

---
 client/player.c | 153 ++++++++++++++++++++++++------------------------
 1 file changed, 75 insertions(+), 78 deletions(-)

diff --git a/client/player.c b/client/player.c
index 1bc64af3c..623519209 100644
--- a/client/player.c
+++ b/client/player.c
@@ -94,6 +94,17 @@ struct avdtp_media_codec_capability {
 #error "Unknown byte order"
 #endif
 
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
@@ -127,6 +138,7 @@ static GList *endpoints = NULL;
 static GList *local_endpoints = NULL;
 static GList *transports = NULL;
 static struct queue *ios = NULL;
+static uint8_t bcast_code[] = BCAST_CODE;
 
 struct transport {
 	GDBusProxy *proxy;
@@ -140,22 +152,6 @@ struct transport {
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
-
 static void endpoint_unregister(void *data)
 {
 	struct endpoint *ep = data;
@@ -1879,37 +1875,33 @@ static DBusMessage *endpoint_select_configuration(DBusConnection *conn,
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
@@ -1971,59 +1963,54 @@ static void append_ucast_qos(DBusMessageIter *iter, struct endpoint_config *cfg)
 
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
+	if (cfg->ep->bcode->iov_len != 0) {
 		const char *key = "BCode";
 
 		bt_shell_printf("BCode:\n");
@@ -2036,6 +2023,7 @@ static void append_bcast_qos(DBusMessageIter *iter, struct endpoint_config *cfg)
 						cfg->ep->bcode->iov_len);
 	}
 
+	/* Add BAP codec QOS configuration */
 	append_io_qos(iter, cfg);
 }
 
@@ -3667,22 +3655,31 @@ static void cmd_config_endpoint(int argc, char *argv[])
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
+			cfg->ep->bcode = g_new0(struct iovec, 1);
+			iov_append(&cfg->ep->bcode, bcast_code,
+					sizeof(bcast_code));
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
+
+			endpoint_set_config(cfg);
+		} else
+			endpoint_set_config(cfg);
 		return;
 	}
 
-- 
2.39.2

