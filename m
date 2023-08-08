Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920D5C001DB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Aug 2023 16:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjHHQ21 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Aug 2023 12:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbjHHQ1N (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Aug 2023 12:27:13 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2089.outbound.protection.outlook.com [40.107.8.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0A211F52
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Aug 2023 08:50:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwP6G8ujXkXSS7oRIWcO2SD2znPi+3wsi3xBxWvD4QirY7PbrTk4vxacfcwDyVDQfx5dv7RvAR/LHyNVOwSV/Zj4OAQLkuMqWVuII4hxkQF/vxi61vQh2dOKV987pA0L9S07TdHkXcIQgaA99w4DnBP9kQ0eotEJJAqaFdJBpNevHUekvi2cb5f2zpxjxS5+/6Y2mxq0WAyCAdyf095mxnBZekK0wImrZeXxp4grodlKfmSg5a06hDFGDL24J8Oyb4n7PodDBYN6i6hH4RHlEQ0mkDf667AsC5i01SoXr6xKVadGYfbP0YXZZVWwc/qTDNWSdyWhvFPIf5MQcEqmfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cywR7JEzuV7zKrI1xonk74lSgQYfUdDI2o8FsJNsdxA=;
 b=lZ0vj9Pn+dlPlw6GjfFfhsMK5a+zjGE47Y52hxTALflhVD+eQ4XpAkcKwaxMBVwj9o3sSzxh7jO9KarGFt2eYmSsPYHV/gQd9MfyvVZ5xnBPNkWBxpZofg5M3IvmkcfWScEG5Nf4rb1/GR7pvjhgYlcQYWppNSWZ+i9PChOtSwLMCeDAvjE1EfE5IddJslFOLQgK7WzlOgPbZi1dvoaGejiNyCyx98/XHSqVl2qGfu7HY2iJVgr/0PrNUcUGFG9Lm2N4fGSpoy0CadKGkPY5acrVkkxAutZ6htEzIaJKFJ+HqrOyjgbz57mtVzOgTkve0QeUxjDaVqjbuQxHFHaa4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cywR7JEzuV7zKrI1xonk74lSgQYfUdDI2o8FsJNsdxA=;
 b=ZUkVXWkYG7qf+F74XV9yUENreQz2BaWsHXsFXp1BJ4h/ghP1s+7EHsZNkw7NxcTZQCA74LEpcN0Mzhamr/ZGcuAGB/JJxtEp3X/umBkHHu6AWJRnX+UO4DID5OIH347U7lCqh8TBqTNjthZ8kvWRIbNm8cvO11FB7MjzZw1IE8E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by DUZPR04MB10062.eurprd04.prod.outlook.com (2603:10a6:10:4e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Tue, 8 Aug
 2023 11:53:01 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6652.021; Tue, 8 Aug 2023
 11:53:01 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v5 1/7] client/player: Add broadcast sink endpoint
Date:   Tue,  8 Aug 2023 14:50:34 +0300
Message-Id: <20230808115040.4403-2-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808115040.4403-1-claudia.rosu@nxp.com>
References: <20230808115040.4403-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P192CA0001.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::6) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|DUZPR04MB10062:EE_
X-MS-Office365-Filtering-Correlation-Id: f52b11ad-9c11-4499-a41a-08db980603f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S6FuORQhlXchA3mqJb8YxkkPyKWEr6e4e7oHRQZ0sH4LLXp+2FAvnJdyyh1yDeGCERo2PY34C0hGw38XUYjx6wTpnht1CvKWossrNzZz+r0BWaP+8Zg/TAd2ayQshb6myKfAHFBW2dyrqp5Gn7aUIEqVorF+ByVP/ZDqOZhjm6FPn5+mRgMQaakzoXbI/DZszvVfY/71go9wg+xchPaLLYN2Z80i2Yvwo4LFQYyB/rPpFCvTKL1hcX1Sr2kPXq931Q+z/qJUBs1PyCOar6bHy8TNJcjrHs/dMGw5kx2KtI0/y/Je7y00FOdB/qarSpm3U8+nM3ZtMk27vATHfuqfi6IRRvNqxjNaiGJ2bCRsujfS/3dOHA1MvMI2Ukx4dv3OY3cka19hOBxL4jSvch8QvKj58wRxa9eEATGNEEdII8H3d3y1aACinGfdHvQevf4lAaCD40+hvSzvukxvDwEVfQMjMBzDkm/EQl8hGRdt3BqrtX8UvmqRpQwNnmIBCfuazW7RotFXT+1sgaq4TMmzuGLNxJmqI/074Zz+MVZWVd77RN3nWrtIxQHY0CKRSkWrTU6oVHqjsMJdYaN3oaQMwrb2JK3nkNrxBhwskAP77F5Ini5Y2jmSOoKR1NWb96uN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(1800799003)(186006)(451199021)(83380400001)(2616005)(52116002)(6916009)(38100700002)(38350700002)(41300700001)(2906002)(4326008)(5660300002)(316002)(8676002)(8936002)(66476007)(66946007)(66556008)(6512007)(86362001)(478600001)(6666004)(6486002)(6506007)(36756003)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ozfJTpdOmdGJ4T0+3WY9lg5MZaNp4eAKpzc1mxtr16WgzHRI1AO9hq0LCSj4?=
 =?us-ascii?Q?+B+rfSnh7VgprWUv/oxrgeu0K89Non+8xtusdI7iQ7XZTz8UEqznD6A/rqXM?=
 =?us-ascii?Q?hTAOwPIRXyntaOb76INaebT0lOB8Qp1gfm/SqwBatVpeYSrIThGv0O7r1AAT?=
 =?us-ascii?Q?YY7ZhASc2AxncuCiSEpso22NDJ0jdF3z4D1eCgqd2I8IO/OszYLXEf2s8GTm?=
 =?us-ascii?Q?d4aNDKA/kU059hjWwL77C3zjM3S39QnJO3Isk01eQbmsfi4H5wIrKL/E7edw?=
 =?us-ascii?Q?Fr5Zo0TBr66YSAZ5U8YLqT/2APn1NVr/sTIuu9dIjmUik7GwHrG0BZeHKKyX?=
 =?us-ascii?Q?TSDCTWoOS6ZEC0bJnsm9be8dd+vie/3fMrSpvotcj+hDKrFEIFnJcOjDeXeX?=
 =?us-ascii?Q?vOdvLQ6jFfi7tah11guMBcvM3E6npUsw3OhYOJF6yNoKBNuFf3zl1vTqsDM/?=
 =?us-ascii?Q?HVmoGqzZgMdTxebGHeEoc7SfDJ+v700onK5MGZKzQ+JuRV+BtHIuXrcqOp7k?=
 =?us-ascii?Q?jLr7+KgkV+WeEWB6iDA6PsKmInO2Mv2bfxL1HQvb9qnl3+eXB3EBYVBRMeLc?=
 =?us-ascii?Q?KqVxxiOx6HBKC3cKDoBRCXsqG/uAqp32jjBv7ERQ2WsMFc2n98MOyfQ14TOA?=
 =?us-ascii?Q?+mmN4X1mCaFGjGfMVmCHBcERA7s/hH/c8LcLpuYUeDcRTCZCmx8e5UCII9f6?=
 =?us-ascii?Q?vF9hbpIOMsnJ01TMS0Nk25jq+n8/6ka9LKpbL6Fo1sZsqS1PO1hd7VtBq/Yr?=
 =?us-ascii?Q?aqKk7wKeIIdKujYN0eldTbW0gyYBZgcngC3oAa5CGigkoNqwQOmIww5RrvBI?=
 =?us-ascii?Q?AdZiHc3D8WW3L0l7F/9uV4cMkgzy9y9qbRmgDkgzw6ojixm9lhb7oecEtA2w?=
 =?us-ascii?Q?/FMmxrw70Wl9F1+YVfn1Eb1dV3L00XS8pQZz2dZxhYoPK50+DRDLIFDBBzBn?=
 =?us-ascii?Q?X6m1zEI8u2PGNgSG6pHj+e+fG3FlFiPRX+5IUewj3aP/y+tw/3c3ehb3bXKQ?=
 =?us-ascii?Q?QwMayEyDv1wEs7Q7lWH+/kPMujX65CjWmHe61k1dRecjS8UN9XnPPkvJmooI?=
 =?us-ascii?Q?JP+M3XGgfPz4qG8Z2efXa9CpzKxsm7OkALw8qNtngJGiA8AiyxRw3m/+vnZw?=
 =?us-ascii?Q?qDJHQwG0rIYr3za01h2076PnKx0u9U/axcG78QYg9lNamXcpLKaNx6409Tgn?=
 =?us-ascii?Q?TGqOu8Oahojae4s/dnA8Nj9EwGGhc/28cocjv/y/nLgh5ZRYc5i6YvUtKpOD?=
 =?us-ascii?Q?KKCHk9ST4pd5hakNRcx+F/Un0vKcYKLtFxg3ThPfMzK0bHyOidVlRGlAiK7f?=
 =?us-ascii?Q?GQQ8uMoZ1ZUeIWidIrmtpcpgg4R1cZRG7Ld2Ot2PPQ6I5EN2nvkhrfo4Huem?=
 =?us-ascii?Q?pD3G6aFBh/p+CocJu7xp0maxUmsFqpZEEzp4NRX3mvU0Z9T++FXkzX28STQB?=
 =?us-ascii?Q?DywtoeAv1NjI8Jv7Az5yGIit90B0yFMoBdHpGhTe96AW52tqEyP9SXvL1z+I?=
 =?us-ascii?Q?vP+73BP1ByWoDrt8sGz0JYYU4+l8HYpACC8Q6UF1/l8JLpsFpzRkFjiDfm2h?=
 =?us-ascii?Q?FBI4YQLlVAD8M5gvEiRjCFTSeA5867/PuWtOjqYSifEKuAYxlvWrsZQwBExh?=
 =?us-ascii?Q?ww=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f52b11ad-9c11-4499-a41a-08db980603f6
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 11:53:00.9485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5imGn6p+ES0YKZAhc5qQU6fJpdtF8D3MfgDmPrPNIb0WOjG5sTvBxGt4IYdCXzJn2SDFGm5zUft6ac0+Zo4Inw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10062
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Added support for broadcast sink registration using the 0x1851 UUID.
Added support for remote endpoint creation when a broadcast source
is discovered.
Added support for creating a local endpoint when the broadcast sink
endpoint was registered from an external application (Pipewire).
To test this feature use the following commands:

[bluetooth]# endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
[bluetooth]# scan on
[NEW] Endpoint /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_bcast0
[bluetooth]# endpoint.config
/org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_bcast0
/local/endpoint/ep0 16_2_1

---
 client/player.c | 61 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 8 deletions(-)

diff --git a/client/player.c b/client/player.c
index 9bc5f2a36..3611a8dfe 100644
--- a/client/player.c
+++ b/client/player.c
@@ -1183,6 +1183,17 @@ static const struct capabilities {
 	CODEC_CAPABILITIES(BCAA_SERVICE_UUID, LC3_ID,
 					LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY,
 						3u, 30, 240)),
+
+	/* Broadcast LC3 Sink:
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
@@ -1465,6 +1476,7 @@ static struct preset {
 	PRESET(PAC_SINK_UUID, LC3_ID, lc3_presets, 3),
 	PRESET(PAC_SOURCE_UUID, LC3_ID, lc3_presets, 3),
 	PRESET(BCAA_SERVICE_UUID,  LC3_ID, lc3_presets, 3),
+	PRESET(BAA_SERVICE_UUID,  LC3_ID, lc3_presets, 3),
 };
 
 static void parse_vendor_codec(const char *codec, uint16_t *vid, uint16_t *cid)
@@ -2285,6 +2297,9 @@ static void register_endpoint_setup(DBusMessageIter *iter, void *user_data)
 		bt_shell_hexdump(ep->meta->iov_base, ep->meta->iov_len);
 	}
 
+	g_dbus_dict_append_entry(&dict, "Broadcast", DBUS_TYPE_BOOLEAN,
+				&ep->broadcast);
+
 	dbus_message_iter_close_container(iter, &dict);
 }
 
@@ -2455,7 +2470,8 @@ static void endpoint_auto_accept(const char *input, void *user_data)
 {
 	struct endpoint *ep = user_data;
 
-	if (!strcmp(ep->uuid, BCAA_SERVICE_UUID)) {
+	if (!strcmp(ep->uuid, BCAA_SERVICE_UUID) ||
+		!strcmp(ep->uuid, BAA_SERVICE_UUID)) {
 		ep->broadcast = true;
 	} else {
 		ep->broadcast = false;
@@ -2728,13 +2744,20 @@ static void endpoint_config(const char *input, void *user_data)
 	endpoint_set_config(cfg);
 }
 
+static struct endpoint *endpoint_new(const struct capabilities *cap);
+
 static void cmd_config_endpoint(int argc, char *argv[])
 {
 	struct endpoint_config *cfg;
 	const struct codec_preset *preset;
+	const struct capabilities *cap;
+	char *uuid;
+	uint8_t codec_id;
+	bool broadcast = false;
 
 	cfg = new0(struct endpoint_config, 1);
 
+	/* Search for the remote endpoint name on DBUS */
 	cfg->proxy = g_dbus_proxy_lookup(endpoints, NULL, argv[1],
 						BLUEZ_MEDIA_ENDPOINT_INTERFACE);
 	if (!cfg->proxy) {
@@ -2742,16 +2765,36 @@ static void cmd_config_endpoint(int argc, char *argv[])
 		goto fail;
 	}
 
+	/* Search for the local endpoint */
 	cfg->ep = endpoint_find(argv[2]);
 	if (!cfg->ep) {
-		bt_shell_printf("Local Endpoint %s not found\n", argv[2]);
-		goto fail;
+
+		/* When the local endpoint was not found either we received
+		 * UUID, or the provided local endpoint is not available
+		 */
+		uuid = argv[2];
+		codec_id = strtol(argv[3], NULL, 0);
+		cap = find_capabilities(uuid, codec_id);
+		if (cap) {
+			broadcast = true;
+			cfg->ep = endpoint_new(cap);
+			cfg->ep->preset = find_presets_name(uuid, argv[3]);
+			if (!cfg->ep->preset)
+				bt_shell_printf("Preset not found\n");
+		} else {
+			bt_shell_printf("Local Endpoint %s,"
+				"or capabilities not found\n", uuid);
+			goto fail;
+		}
 	}
 
-	if (argc > 3) {
-		preset = preset_find_name(cfg->ep->preset, argv[3]);
+	if (((broadcast == false) && (argc > 3)) ||
+		((broadcast == true) && (argc > 4))) {
+		char *preset_name = (broadcast == false)?argv[3]:argv[4];
+
+		preset = preset_find_name(cfg->ep->preset, preset_name);
 		if (!preset) {
-			bt_shell_printf("Preset %s not found\n", argv[3]);
+			bt_shell_printf("Preset %s not found\n", preset_name);
 			goto fail;
 		}
 
@@ -3172,7 +3215,8 @@ static const struct bt_shell_menu endpoint_menu = {
 	{ "unregister",   "<UUID/object>", cmd_unregister_endpoint,
 						"Register Endpoint",
 						local_endpoint_generator },
-	{ "config",       "<endpoint> <local endpoint> [preset]",
+	{ "config",
+		"<endpoint> [local endpoint/UUID] [preset/codec id] [preset]",
 						cmd_config_endpoint,
 						"Configure Endpoint",
 						endpoint_generator },
@@ -3189,7 +3233,8 @@ static struct endpoint *endpoint_new(const struct capabilities *cap)
 
 	ep = new0(struct endpoint, 1);
 	ep->uuid = g_strdup(cap->uuid);
-	ep->broadcast = strcmp(cap->uuid, BCAA_SERVICE_UUID) ? false : true;
+	ep->broadcast = (strcmp(cap->uuid, BCAA_SERVICE_UUID) &&
+			strcmp(cap->uuid, BAA_SERVICE_UUID)) ? false : true;
 	ep->codec = cap->codec_id;
 	ep->path = g_strdup_printf("%s/ep%u", BLUEZ_MEDIA_ENDPOINT_PATH,
 					g_list_length(local_endpoints));
-- 
2.34.1

