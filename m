Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F78CA0ECA
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Sep 2023 06:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjILGzx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Sep 2023 02:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjILGzv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Sep 2023 02:55:51 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB17910C2
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Sep 2023 23:55:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LhIlwBY2zcZtvz4Pg1CaXOWydeXcK5zzgMxvAYQ16b6AFi1vTZA00TnzG2Hc1symFALEwGZENy6TwyKI/8KEe7ksNpUhdHnokkdOGcL+qm1JnWePt2DiU+9B4SiT1ZZuzVECBywuq/W3bnQgf13AD5jPKwFapJt0ALg5y/qLrzE7qYdAPRkGRs+EChxKUW8h2LF97AaUUmRj6yAd8BtCVQAeOREwEi1iZlQONfG0LIeVkkEUhqTw7pmps5LH+p+8ZgUs/qxaEQNmIPzMXhIWj4fiWh08MoUKpZ6epJOqxYy3EWUW4CQHXocfLmG9AXKhPDSUQ7LU9Dieopy9H29jSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmsJ8UXpBn9i4xaReJo8erWNR2XGN0HZrTxYW67PYV0=;
 b=diu4Eni3uzHAh60NzGbna7vMLahYNOxuqJnrozGuvizAbcPdgqql+IskAoBjYNPTFIlP8onpjtQ8JNsPevt9cezTXbSlzCWztQ7zOIUVDlLDEk5LrWrFx6agbGfTq6Vi8neXqyueEB3qEOKF1nQA8vr3J6CfCpKqsj0onP9UMcLH9bidDOHnlvCShLmeuRwGWL5uUmRpWizlKXRMN0KPSgzstiw3olbwHdJLYAxkjvtt8+IaTVIepd0UD0VarR9TfJtIYP2cYuW8guFiZQt5FwgurMgmEJGgFGlsS4QYwTu3A7yEc8wfQ0Fxh+eEjoTVGHTAlkBLL403koiw41o8gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmsJ8UXpBn9i4xaReJo8erWNR2XGN0HZrTxYW67PYV0=;
 b=Hp54Iuu7mL0ryqbfKCKmk1Sg4ZZHEXhoWYRTdZQyNxnYuL1GW7d03EF3mLiUrYTUB3UJmo3fU0E7RASXUBvD8o8fDefHKek5wFetRXYHqBVA9fspEWNeT2N9unRmVU9PLvauLYDcSmZznjHSueU1lvZOVv6dypgAKgiQJXnxurg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com (2603:10a6:102:2b4::19)
 by AS8PR04MB8532.eurprd04.prod.outlook.com (2603:10a6:20b:423::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 06:55:45 +0000
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636]) by PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636%4]) with mapi id 15.20.6745.034; Tue, 12 Sep 2023
 06:55:45 +0000
From:   Vlad Pruteanu <vlad.pruteanu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, iulia.tanasescu@nxp.com,
        andrei.istodorescu@nxp.com, Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v4 1/1] bap: Use defer setup when syncing to a BIS source
Date:   Tue, 12 Sep 2023 09:55:26 +0300
Message-Id: <20230912065526.1217334-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912065526.1217334-1-vlad.pruteanu@nxp.com>
References: <20230912065526.1217334-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0012.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::12) To PAXPR04MB9398.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9398:EE_|AS8PR04MB8532:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fae048f-67fc-4fe6-bf76-08dbb35d49bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m+vHv3tHax9FnFFiXHJIEO7UiHtFxXNI8wIU2+UzQYyA5nbInKddtbPz7leOkoocxv2Opyo2dTDC6lLK0dZaM++gDr+LpZ0Kjl8XpO/Vfr4QG5XH2sWxmw66Z14z8oKcUhPFsnlcsxcuZWRDWuefkuBlcIW+6K5auTjEWoDyJqoQF75JuMZmBCu97Pz8Zg2vyzpe72ur0NoYsAwES9uf56zPbmIStATpN97jG2J4xTf8xH3fWUuK6WMiiCfbUUANnZ1EAZYy2LfEfinU9NLxYSqoH1tNRKeUdd8YGCb+hXMMaTI4L4Iy3G3AipZWuXEP3xmfSSSPIqSbmyUxOq4qzHdaFiaW0lRXv8fVCVn9zYYtknYDekCtS/R1vQRq2lKTtlSUlsiEGdri5RkwRYWmdYxlr6hmoM1RwBWhm2bR+AANRokdNooFHotzblE0RFVXmLEHDKS2yLvJ4tx/wGUSo2qjhPaf5N31wzJzsHpIZdnOsUOgSaXUU+pErQJzMsmqIt3iL1PQa2ki77vpvxKdWhQGepqMuTaTKfZ+PtBU8LtEqQpl2MzP5DI4X3SdOY0nXapHf6vgWSUL9MnWQzhIwsndTgNCq5aiaD7cfKmfBtIjuqUJBBvMbT7dE6sIAR8x
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9398.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(39860400002)(136003)(186009)(1800799009)(451199024)(38100700002)(38350700002)(86362001)(8676002)(4326008)(41300700001)(5660300002)(8936002)(44832011)(6916009)(316002)(66946007)(66556008)(66476007)(2616005)(478600001)(2906002)(6512007)(52116002)(83380400001)(6506007)(6666004)(6486002)(26005)(1076003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jSI3NXQHeMP75R5LhlGHkjK4rpKq8drfOmIKUjuz6OLmZdevOMUTOGpN53gw?=
 =?us-ascii?Q?q/0Ppc9B7ymc4gKOjeZg4wigA8oG+fwjp5zX9LGEZRyPm0ze83tvQ5G6ab3o?=
 =?us-ascii?Q?rdvmT26VEYQ+G0YM8YD2mh/2A/DUr7J7jtcA33ARJ4CbKUEB4OidzKVI6/jM?=
 =?us-ascii?Q?wYp2DFvh5PVdeBndfHNDDZ+RwXUj3EhA3l0+eYDAY+4Klq9eNvuzakM9Meyo?=
 =?us-ascii?Q?IcNfT1W1KjP1VfewKqmujIAWZqRFiKboxW7shAZeoNDNNSOybOaTqIHMWr7W?=
 =?us-ascii?Q?zKsgQHG8q/gsso4PXrS58OzUoZvGGV4THN6zjAWN3npac5q9r/5m5REalrwj?=
 =?us-ascii?Q?VGeUTbLgTG+FgbdznffIvpeQytE34sAC/LfJ9CDr0MzeCduuv0EyQAXuAeEo?=
 =?us-ascii?Q?lh9h5HlUoZHLu+NaTnITSSAgT9ViFg5ye4GKiVihpBcT4txOaPbWXW9en5Mb?=
 =?us-ascii?Q?3eiKmI7zEmSwnZG8vEqmcGOV/u47IDzAEU62J7npJOSxT+S0iLim38XysYFm?=
 =?us-ascii?Q?Me6X2UsKll9az2zc4Yy3tuwL8nkLIq1kzLe0VQw9LK3Mv8ucPx9GlVKB4Ghz?=
 =?us-ascii?Q?XSQAjAfeawzqyayB9GzMcj36XKcRzxFgmJsGzcx5MBdWyd9GxSTgfRmlO3Ni?=
 =?us-ascii?Q?s9FJNT/XKPVYIqN895hdbJtHE4FsERaDYoGEF081g+bqMw8NEJzbXGJvf/ay?=
 =?us-ascii?Q?oZRYW07Uku/vYhm+du0esA/PS2T2xCt+Rc6BFJ1j5BmUw0V8xR8BDmSsL+/K?=
 =?us-ascii?Q?Qai3hXI/IZZxLGkwaie4+YFyyIQIt2AlsfUycagSzpyus4H3JZFootaK5G87?=
 =?us-ascii?Q?UjyJqCsrQhSLJlIutzA9PbxGLdC2MetsZklj8XizNTZ8juL2UeL5LRcLuini?=
 =?us-ascii?Q?T5KkZ/IrZCkODco4PdolHJH0xOq1qPOQXNDQAvHH/RUvM/Qt9UU+sL7DiQDD?=
 =?us-ascii?Q?rum2wtIdImQMMMuS7bZHGAXfY2c0L085Kmw71YMCEXfHsbb5hVMAjL+d5lZM?=
 =?us-ascii?Q?ABflqCoR3bwVizlGCVQDE0JR7uRE+SupuwDTVNyfowkKuLqBHoB2sVt1dqSG?=
 =?us-ascii?Q?RmECSc3O4ekbk/J+Y5mlvqMJIMZDr9Gd+RhMQ04KCPrmerjWZIS8WDD5aYRu?=
 =?us-ascii?Q?BMvrEkBirPp6hJ5ptAri6jw3V/1GL+Ctpfi9OUpMQTaR+zodiKnftQSFIXzl?=
 =?us-ascii?Q?6yyUXn5M2vrMU9yZm0jEf3+bg2IHqrZGE0MyE3E9e77cmosAtzFPNx8W42Dw?=
 =?us-ascii?Q?NI0EjsAf6NyFf87CzQ3eeIAQTCXfb0HdP2yrpGhnCbKdYp3EdCma8BWs0Sod?=
 =?us-ascii?Q?N6APuWz8yc8TthagQzVIxtxXfmfjLAKHjYTpn6MblejM+N/cP5D1aT75ai8b?=
 =?us-ascii?Q?zZmQpZLcE3Zfp1uKRPY5M0+OL4cpVK9wRamP1MhHXXybPG3v14VLWbgwMX+g?=
 =?us-ascii?Q?S6s4MeRbDSoRhm/oxsuq4+xD+ndQgG9GSaMAIfFjyz4rG1ZOBUiGb2f5SgYw?=
 =?us-ascii?Q?agHIx1gyVwHulQkn0nGZLhwTKv8q++v8qciB/U02tGlHff53Ch4qJkU4odk6?=
 =?us-ascii?Q?La1GqluYVjVab3SY2UGwDD6w43SHDCyXQeT3t52XLQ88ADY7Z6igOa55OznG?=
 =?us-ascii?Q?wQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fae048f-67fc-4fe6-bf76-08dbb35d49bd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9398.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 06:55:45.5199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRm4J+JIIRedqyt2IFT2opsR/+mvBVQ/qaNjTG9od6eDJMvD8TGp9MNLMS4fY9sJOcRZhJCoXNqHp0E/cXZN3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8532
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This commit uses the newly added bt_io_bcast_accept function from
btio.c to implement the defer setup for the BIS sync process.
Now, information from the BIG Info advertising report can be
used when sending the BIG Create Sync command.
---
 profiles/audio/bap.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index ee90426b9..d70ad872e 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -840,6 +840,19 @@ drop:
 
 }
 
+static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
+{
+	GError *err = NULL;
+
+	if (!bt_io_bcast_accept(io, iso_bcast_confirm_cb,
+				user_data, NULL, &err)) {
+		error("bt_io_bcast_accept: %s", err->message);
+		g_error_free(err);
+		g_io_channel_shutdown(io, TRUE, NULL);
+	}
+
+}
+
 static bool match_data_bap_data(const void *data, const void *match_data)
 {
 	const struct bap_data *bdata = data;
@@ -1587,7 +1600,7 @@ static void bap_listen_io_broadcast(struct bap_data *data, struct bap_ep *ep,
 	if (bt_bap_stream_get_io(stream) || data->listen_io)
 		return;
 
-	io = bt_io_listen(iso_bcast_confirm_cb, NULL, ep->data, NULL, &err,
+	io = bt_io_listen(NULL, iso_pa_sync_confirm_cb, ep->data, NULL, &err,
 			BT_IO_OPT_SOURCE_BDADDR,
 			btd_adapter_get_address(ep->data->adapter),
 			BT_IO_OPT_DEST_BDADDR,
-- 
2.34.1

