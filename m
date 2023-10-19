Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347CBCDB465
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Oct 2023 14:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345929AbjJSOwl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Oct 2023 10:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345862AbjJSOwj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Oct 2023 10:52:39 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2057.outbound.protection.outlook.com [40.107.247.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BF5C2
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Oct 2023 07:52:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWgx3eV7HqSWmL6/LSifZAHrNvqogPDZ0rcTUOky4FO59mPOMdNrwY0CSEXbsbkB57MbkTu+xPZgJ/5VQpXCqw7qCQfSbMEkP4LAYjbAWKYdgHrzyX+L/PeE3OmVsJiSZ+SGy68tXF2sOcR5yu1xWZHSOe6VbQoBQKlPW+h5N695wHBQwh6BKpqdEInJstNU2f14/1ivpa+Wo9qJ73kTwYNaAv0z4V0RVZyKh3kypgDzgrkEprsBLrdjD++vCBgQd43KiZWMth/B/CCf3bPnT35u+a5CIiE3NahWHeFRFTFopo8R31SRI3Jj2lFJkBPXTiKBMoBrZU9YXgJnvMrW4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dx7B4EKMOTK+EX0UpL1IhF1E+EOXLjFNSug0xsRLozw=;
 b=hB9JV87jFd4+2hUlrV4MDwBdxaGuGeke0dhMscZxFLv+jK6FxHZFVtBt0XaUScxyxzQlFE6lrEPGipfB56D9Cfgj/MiPT3Cr5UALj4ADDG51GK7eRM5wW9F/KDccYBbL4iaLde5E23a9C9v5I20BWaW8y5r8pnxOCokmUQENQiH2gRwg1XkvDUt/BWTR61SBYcyAlPBibd1YEQCNYzEx9ikadCeCG1MDZ5rGr4164HxLMGEgcpxcA3g4CXjNJ8KET3nNwQB3tuKXNClzhikzBzSjLhjiCce3nf+f8IduT6xFkfBBQ3jHuYAiKKeFHyYJ9IITiOFVjKQtdVYzMCus6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dx7B4EKMOTK+EX0UpL1IhF1E+EOXLjFNSug0xsRLozw=;
 b=V0LWTi5I79sDNinSJ7oW62SDY45KJ1XekY77j2cWF3yoRtwGgMrjjq9uu1FunijBAeIKS167JsTHYfOMrH+QU9MRY5feenD4rNXG4MhEj5+msRuS9/V9DaNHsKmBmKVgMmrdcH1qhLBz1z2k3Uav64dZf6tg8ekGJil8vaMwmmQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8724.eurprd04.prod.outlook.com (2603:10a6:20b:42b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.7; Thu, 19 Oct
 2023 14:52:35 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6933.008; Thu, 19 Oct 2023
 14:52:35 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 1/1] btio: Allow binding a bcast listener before accept
Date:   Thu, 19 Oct 2023 17:52:26 +0300
Message-Id: <20231019145226.4879-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231019145226.4879-1-iulia.tanasescu@nxp.com>
References: <20231019145226.4879-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0030.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::19) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: a223acae-b967-47ce-48f3-08dbd0b307bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RbBwQgzIiBXAEPS6C6/3JYry/8VmaQi0RxOPQKjhlbh8ZXSHyxcoH3f2ejS7OxsnTNpjmN/peJqHPhEQ7G/lDrEE5AqKtfhGPBzM4wKJfhg1WHWrxdlQzYCOnON4LvvVIJyjxX1h195U0/i9xMPu2k9czOVUTR1SBYBU0JtYi4uM/kd6umUqIfhhFXnh1ooBA8kjZd4wqro2kYaSTBGfpg1hijHkHi7GD6WhtszH1bt8s1t7yJ0rnTh0ixtNa5at1uPuKVf4bzBg/ckhFnJ8FPp1TbmAIwPvfS5JMxDcXMBtbduRpgg+7pJQ50ViMgD6TmBkfvb2CRr+rNeMI4DYB7U9elU9JhWtEMWJI/vIcvhXtHyf0hzfKJapTVsPhyJSloSy+bHdMRe7G1afhzc9SyT6cZWWrCJTx8GnGKgoIooqtWAHyPJqa6KY3LmkdSBHT8j5wnk9a5qpS1alnXd5h8+4GndFefd82zuqDyY1xs654AuyotEcng+axA38EMfb0AHe6qgM3GWyTIzwzJe1oZcdadaQE540nFrIudvFSYYG8yNhdgW15wd203zrXvgnu7vV1+b6iAnLcSA6lQyq+T5EpjFHOuAqM0Us0dWYBhJt+XBzhpknoJgbSa/dh/4e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(366004)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(8676002)(66556008)(66476007)(66946007)(316002)(6916009)(6666004)(8936002)(6486002)(478600001)(5660300002)(86362001)(4326008)(41300700001)(36756003)(2906002)(38100700002)(6506007)(2616005)(44832011)(6512007)(26005)(1076003)(83380400001)(2013699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qpz2JVVOuvFMuNOL6P29PW0bLTXPB6ij7HOgvnHFz+TN63NzUXstFZIHETYa?=
 =?us-ascii?Q?NCx8dyiu9xpACE7fpLcR8s69BmxHC/8NIDckPlUUxD7l3FqjiNCXj+iJ8x/P?=
 =?us-ascii?Q?jQG2pzhTdol7vUtDNuLe544FuDtAD52chnn/hzL3qoptugh7Kml8+PTQOlIH?=
 =?us-ascii?Q?3dxgCOvPWHaUOPGashi8ND2y+3uZEG6VTCtxAT7Ykf6qdklvj2f3cHkOM8NO?=
 =?us-ascii?Q?cS1l06eJRgej58F/YQQHvMjKENr2SerDvb8vjNquaQMZqPmbuHtI20FuUPjW?=
 =?us-ascii?Q?H7vs4SzGj46eItsQ7BFaMlgv7MQpLxJYpF0z1dtEhLDlX+yoipVX/Cr0WI8l?=
 =?us-ascii?Q?HhNg3Oa7ZT0SpjcNbS73nY2GdEIITbYWV2pr3u7gJeS3+Ck5S4EUxqkpc1LT?=
 =?us-ascii?Q?36QJPUkzQrH4edHy5uj19AISW5YCvGufutaAPHYymTMM5oIqov4kTAt/oUev?=
 =?us-ascii?Q?nn9Gm6D+k+JXzvJBYzCFuHYrDw0WNQOnae/ThRc7M5gtazsG90d6ryNgyf0y?=
 =?us-ascii?Q?3Mb57t5/xEJOgT6naGj69FdlGTknDcCRg2jKXkUJMrInxsh3PU8XrcJGeYVn?=
 =?us-ascii?Q?tTWWEoFbjSwM7MQ2Eep4JffZl0xZGYt8gOFn6IvcUmc+Tf9KI5Sc6d5mtp1p?=
 =?us-ascii?Q?yH0v1yT5ords8G1ubJPYu6vGNbf8ThMgigwl02uwEqPBHi539Gx6fAKJ9IqB?=
 =?us-ascii?Q?9h7L8od/0snSEbEly2WZluno9kHV/ydOH8RZjj55lixaQw/PLpSntGCtCPEz?=
 =?us-ascii?Q?MfED0I2aPZZDmkzIET/3DlnubpOizSD+r7KkbAmkkqAjRURqyWOp/X0fE96m?=
 =?us-ascii?Q?Q1Zufy2wUjm37yWbGwteTJ0vnbTJybPYOb7ifo6+8nTAZMnY3d7RF9FkSmSt?=
 =?us-ascii?Q?nGbvL9ehCFGKoqwBUZMzw69gG9eZWTn7p6KGX7ElRDh5yP6WzpbOTtU3TiJ/?=
 =?us-ascii?Q?g44KLCme6E/CbOrqSb7TYXowiom2uDHFcKkSduNoh95LWQmwObFyn4BX4lG6?=
 =?us-ascii?Q?gUqolGncsBZImGx8Gtap71sXCdLMdkjSEe5POwidOxj7Qi8Tcj2MALkFOneI?=
 =?us-ascii?Q?9hiPU6UJl002NaPF6l72+JmTYBWb5D7U+Ibyus9miXsfZahDrz02UQ3MlO3a?=
 =?us-ascii?Q?xmWdhmFZzqljP/Wsq6F7va4CjkDJOpKIDCEake3ChiF+O9Wn/j4mVXagLla4?=
 =?us-ascii?Q?drGo4tRdh+VhwQI4GaJ38HM0wsePkNLJ2HqICU94XPDbE57OlEXjesnrRAVz?=
 =?us-ascii?Q?+N0bq8QYDYatn6NdVwwX3mr3/o0Nh/gpcSvhgqLUsYoWkkYH2CRAJ0Lc8NvP?=
 =?us-ascii?Q?XF7IQ4dVMYFjONhsf7stM9PbwzrLOO0biYzMd955WsedBkfuL3Dv48+EsihA?=
 =?us-ascii?Q?RuN1P8njOPJlgXcXDbWtOnMe75h5OnYbFlqtcNu4VM77AU6GkYHjOLGBpZpq?=
 =?us-ascii?Q?AOisA4hVZz8fq8Mi3gjUmkpB1OQ3QeeRVpRa+/BLcGDddIthGKwzIRznocdv?=
 =?us-ascii?Q?czrUJxGRS5lhGj0FnrCeVQr09POua2gFc113rDQDQmO7UywdPlWkOC1pkAlz?=
 =?us-ascii?Q?uWN62oKjgHjfHj76lCv6Xs4HotNzWBXTcVr9EMD6755U2Od8wUcFpv569lkc?=
 =?us-ascii?Q?pA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a223acae-b967-47ce-48f3-08dbd0b307bb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 14:52:35.1469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EMmJf0rc1jt4LH+nGOd1Y+tmDH8S8gnR3mTSVDjr9PfimJwFJgk2Gn61puJaJePeWAlGd4pthIC6XWj4HQmaLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8724
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds btio support for binding a PA sync io to a number of BISes,
before proceeding with BIG Create Sync.
---
 btio/btio.c          | 55 +++++++++++++++++++++++++++++++++++++++++++-
 btio/btio.h          |  2 +-
 profiles/audio/bap.c |  2 +-
 src/shared/bass.c    |  9 ++++----
 4 files changed, 61 insertions(+), 7 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index d45b8240d..d30cfcac7 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -1796,14 +1796,67 @@ gboolean bt_io_accept(GIOChannel *io, BtIOConnect connect, gpointer user_data,
 
 gboolean bt_io_bcast_accept(GIOChannel *io, BtIOConnect connect,
 				gpointer user_data, GDestroyNotify destroy,
-				GError * *err)
+				GError * *err, BtIOOption opt1, ...)
 {
 	int sock;
 	char c;
 	struct pollfd pfd;
+	va_list args;
+	struct sockaddr_iso *addr = NULL;
+	uint8_t bc_num_bis = 0;
+	uint8_t bc_bis[ISO_MAX_NUM_BIS] = {0};
+	BtIOOption opt = opt1;
+
+	va_start(args, opt1);
+
+	while (opt != BT_IO_OPT_INVALID) {
+		if (opt == BT_IO_OPT_ISO_BC_NUM_BIS)  {
+			bc_num_bis = va_arg(args, int);
+		} else if (opt == BT_IO_OPT_ISO_BC_BIS) {
+			memcpy(bc_bis, va_arg(args, uint8_t *),
+					bc_num_bis);
+		} else {
+			g_set_error(err, BT_IO_ERROR, EINVAL,
+					"Invalid option %d", opt);
+			break;
+		}
+
+		opt = va_arg(args, int);
+	}
+
+	va_end(args);
+
+	if (*err)
+		return FALSE;
 
 	sock = g_io_channel_unix_get_fd(io);
 
+	if (bc_num_bis) {
+		addr = malloc(sizeof(*addr) + sizeof(*addr->iso_bc));
+
+		if (!addr) {
+			ERROR_FAILED(err, "poll", ENOMEM);
+			return FALSE;
+		}
+
+		memset(addr, 0, sizeof(*addr) + sizeof(*addr->iso_bc));
+		addr->iso_family = AF_BLUETOOTH;
+
+		addr->iso_bc->bc_num_bis = bc_num_bis;
+		memcpy(addr->iso_bc->bc_bis, bc_bis,
+			addr->iso_bc->bc_num_bis);
+
+		if (bind(sock, (struct sockaddr *)addr,
+			sizeof(*addr) + sizeof(*addr->iso_bc)) < 0) {
+			ERROR_FAILED(err, "bind", errno);
+		}
+
+		free(addr);
+
+		if (*err)
+			return FALSE;
+	}
+
 	memset(&pfd, 0, sizeof(pfd));
 	pfd.fd = sock;
 	pfd.events = POLLOUT;
diff --git a/btio/btio.h b/btio/btio.h
index 3169bebf3..3e69092b1 100644
--- a/btio/btio.h
+++ b/btio/btio.h
@@ -77,7 +77,7 @@ gboolean bt_io_accept(GIOChannel *io, BtIOConnect connect, gpointer user_data,
 
 gboolean bt_io_bcast_accept(GIOChannel *io, BtIOConnect connect,
 				gpointer user_data, GDestroyNotify destroy,
-				GError **err);
+				GError **err, BtIOOption opt1, ...);
 
 gboolean bt_io_set(GIOChannel *io, GError **err, BtIOOption opt1, ...);
 
diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index fa5cf1f54..b74498c4c 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -981,7 +981,7 @@ static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
 	GError *err = NULL;
 
 	if (!bt_io_bcast_accept(io, iso_bcast_confirm_cb,
-				user_data, NULL, &err)) {
+				user_data, NULL, &err, BT_IO_OPT_INVALID)) {
 		error("bt_io_bcast_accept: %s", err->message);
 		g_error_free(err);
 		g_io_channel_shutdown(io, TRUE, NULL);
diff --git a/src/shared/bass.c b/src/shared/bass.c
index 0ee3187d1..ce8b239f3 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -743,8 +743,9 @@ static void confirm_cb(GIOChannel *io, gpointer user_data)
 
 		if (bass_trigger_big_sync(bcast_src)) {
 			if (!bt_io_bcast_accept(bcast_src->pa_sync_io,
-				connect_cb, bcast_src, NULL, &gerr)) {
-				DBG(bcast_src->bass, "bt_io_accept: %s",
+				connect_cb, bcast_src, NULL, &gerr,
+				BT_IO_OPT_INVALID)) {
+				DBG(bcast_src->bass, "bt_io_bcast_accept: %s",
 				gerr->message);
 				g_error_free(gerr);
 			}
@@ -1129,8 +1130,8 @@ static void bass_handle_set_bcast_code_op(struct bt_bass *bass,
 	}
 
 	if (!bt_io_bcast_accept(bcast_src->pa_sync_io, connect_cb,
-		bcast_src, NULL, &gerr)) {
-		DBG(bcast_src->bass, "bt_io_accept: %s", gerr->message);
+		bcast_src, NULL, &gerr,  BT_IO_OPT_INVALID)) {
+		DBG(bcast_src->bass, "bt_io_bcast_accept: %s", gerr->message);
 		g_error_free(gerr);
 	}
 }
-- 
2.39.2

