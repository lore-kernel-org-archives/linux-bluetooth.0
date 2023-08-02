Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C392C00528
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Aug 2023 13:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbjHBNZW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Aug 2023 09:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbjHBNZU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Aug 2023 09:25:20 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2040.outbound.protection.outlook.com [40.107.7.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB37B199F
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Aug 2023 06:25:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W45+K8BISO6wsUBskgy1idfa8qdAiD82J65T+oElsMoRiXl3ermsy2Y/kGbfcZ3GvWE4Wm2u38yXFJ4yPOPSaPKE6D74kjHMFIoWj1nWhbFw3FXkPj1VY62CaI9F3qNm4fzIEecajKMIY/6p7mHmLU7CGHjm08/A98qZCM6ZczYKqkRpFegYkcODwXesRMVC7FQCpdjoPamv6OEtNXGkAIX4ghPXuB/nhPVmEeckrBcN/dkWrrxkiQAMpzXNXchvOzM51Belnpt0VuVQ6rgcSyVA+fGclA0CMhlAyT6s7PBUAm5d2BukmE8zMVq8xXnO/BVAS5oSSnqv5SZ40pcl2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cywR7JEzuV7zKrI1xonk74lSgQYfUdDI2o8FsJNsdxA=;
 b=doI/ij7wwriICgSSRdvo5WIxYxJoUkOJD8eoNn9sbFGxtdMcVUoWf36Aw/CxGMk2oq2xUBbO5VRu8pnTPpZVEUpL2zeViMy+XGpnlMTT0TWiAom/aSW7jBqkuqyCeiFKnmvkYYIrQlK/QiFsoLFZc+XUkeSw1XSlLQ8bI9Lj264LJUBEXisfrWmQBVJMTrK9v0DJeNGmoOBBAW60xhBgxOr4zmfp+DDwls4K7fcjW0utHi7nEattCehkNcaHtv2XToLAkvbKwVzOoDwz2kqVZ/LBVOKSj5BRi0LiegiIA13tihINE5K4z83HOC9yNsCDg7vcPKBnoNISsCvx7M0rNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cywR7JEzuV7zKrI1xonk74lSgQYfUdDI2o8FsJNsdxA=;
 b=chtdot5T9spLYPPpTp0V8AVK1ITUK/7XN3pW1T6WlPQM1DMkVdt350bLoOnuLuXx2XOi984v55MiU3RHT5Hjz5qJGno7+I479AAtsOxLJP+6RIfuWEKDc9u2XGrXOjrfHzEGDZiyhaLUrwCWlD0M6XjOqyf1OhGEYPJG4erijkQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AM0PR04MB7010.eurprd04.prod.outlook.com (2603:10a6:208:199::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 13:25:17 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 13:25:17 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v4 1/6] client/player: Add broadcast sink endpoint
Date:   Wed,  2 Aug 2023 16:23:50 +0300
Message-Id: <20230802132355.4953-2-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230802132355.4953-1-claudia.rosu@nxp.com>
References: <20230802132355.4953-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0023.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::19) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|AM0PR04MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: a69111ec-4ce2-4c36-08e4-08db935be979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kYvq2xdx/r7KK0lXYi/YDMFHfd4nXQjvsrYuj8Wb9boLlp4aw6smgECQ3N929qdIthq6H6/YLoIePg9lEOX2HLst4ED1CB5F3d4g/8aCVD+8bwp7kjtquc1s7b7hl2Qc4Y4yLQV4ikXfVnvpQUTkRICL9yuzI1Tq6TDr5bDLv+NKj2tplWmJ3oeQqKBF51cKGzwQ7iTBQF4yjE+Na58wMxr4dhcyahJihoVBAd3JXP1zXBHbcyuCUy5lFO7nNojXRnostEXArp4qF6/gVg3a0y0DJxD+PjhUHdhc0Qx4zIBj3nNDkid+NwkhGqa3y9MpI5BHKnZC3ZMUzV7fFQDRAxXG+45Cn2leqZf9mqpqGxrCIoO4Nf/Rda/DfDyOAYhNlNU4+y25Iuruwt6hpCJ1u1F2ebGvrSrKQiYBpmfOccaGCiREzUQ+r5cUvJMNDBHOLOxW6peclaiOh5za2jaGtbgZG3B3FxfHxRgrULNRr8fp+8xCkpUOyYRa4T854OjBmn+RQB+JR4LBrq6AiP/klePh/UFkZwVBzbY5O8yopUseOrvMV1cnRGnghdqhlFPkLlAwDYiAr393Bgg0qN004CfpHecdSEzyHw/KU+iF/zyk7n8H5ElxDYA2i5ot7Yk2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(186003)(8936002)(83380400001)(8676002)(26005)(41300700001)(2906002)(5660300002)(2616005)(86362001)(478600001)(38350700002)(316002)(38100700002)(1076003)(6506007)(6486002)(52116002)(66946007)(66476007)(6666004)(66556008)(6916009)(4326008)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g5ZyTPaOBFKd63Ji1sAfF2/5blzzgjZM3393fWj9wcIchqRiUmDDwxd7U71x?=
 =?us-ascii?Q?QmqOmm8btQ7wqZNY/kT5MtfUcDql05Jf1Itc1uKIZZGL3xjZv9ozFYJUyo46?=
 =?us-ascii?Q?fiD67oNi7AsdO2AU+KzrHEdmcJlGTSE0aKlycRqwCCl/6Fw6HZXSaDWWH3g6?=
 =?us-ascii?Q?muRUeou1EqSMH99/3EjoUSt01KSbOqOIEnrbn8g1FQGI+0LC32aUrsov/O4t?=
 =?us-ascii?Q?j7iH2x6ilD+yMmfha0OxxL0MErrtuD1QyZt87mj6uwqJ++AF/KdqWeEsKC6W?=
 =?us-ascii?Q?YLvN8GhyzdXC3aAVOgzRVsyY2NVtEHxme2tj1f+1G9EiMr2XV5XMLC9vb4+Y?=
 =?us-ascii?Q?4CtUcpN+MVmP6csvSMplh9JuhGTZApyjTc+T/CcsqHO4gT4zS++OjsY130bU?=
 =?us-ascii?Q?gOyJHqN2SELDikyvTk2344Y2ytBDQ/KmVfgChdRGjG3czZju0kLuORE7HtnE?=
 =?us-ascii?Q?ml/JHIFfnzZFlaszBgTe7AB/cWAN6nknMd/ZiBq79SBHlYZZK1Vtp3poeHqF?=
 =?us-ascii?Q?mhgRrMRvDn+k4RQhYJMHZczuMt5cXWcjtB865x+aiVBTp0TW766Bv8uRjupV?=
 =?us-ascii?Q?sFpL9R18xlvDkDCFwPG9sdVzz8ipk7rcYY/te8tHJDOuAFB9nTmQ0jd3nKF4?=
 =?us-ascii?Q?HdA2R+sCPOC8GCIVIxdUrvbFG595HNUNlcSD8xQVkL+Z29H5cMmqF3CqX4ZG?=
 =?us-ascii?Q?9rQEhf3zXgEKeToms5q67Qyp+mFC1DNhkAoaE0zxLkjSyoXiVXN+t8G16PTh?=
 =?us-ascii?Q?wYY+EXRyst/oiQh3Um0Z9IxcMica4ZBuR/ICdnQ1bKyNkzszlj/2KuCMuD1A?=
 =?us-ascii?Q?EleVtqvnYib8T1H+MJWgy+oEHyR9BcdWlZgGeV2+duvLhFTGtHED4vVNPTYG?=
 =?us-ascii?Q?hSGSeGKWNRMCrFjt/xD6CGs1kfgQ9X4jd8NZSI1+aEzzRsxWG4a8/JTAhG6G?=
 =?us-ascii?Q?BmfO48DVjaRmFFeZASZ/H2vtq72ZruADyi/HUgvjaieZg9lB6Jbi1wSgb3wI?=
 =?us-ascii?Q?DmTZUsWDFKHDv1Mmt9DyaqXZjpAjksDJgRjo80RFctHu/2JGf0LUOxfBlw1F?=
 =?us-ascii?Q?4yKsTef9ih4Mr1Nju/eQ9aeCjv+4LUOoC6FDKcVQx5YDNOOew5/xKp2GXZDc?=
 =?us-ascii?Q?PCD41GXcLb3sOoKEZr9BGSOIIp4DTHJNOMyVfG4MH+1osJiBnNNSW33Mqq9n?=
 =?us-ascii?Q?3izQH4eurce/9HDmDzLISA6XTRqkEJWK3oHmcXQAbxkfsuaRNGgxi9dx+9w6?=
 =?us-ascii?Q?TVHgTmu8T50IluYhLCGderlutvJFfScVWNx2BcH4AyWLZoKvbH3uKYvQ2cLy?=
 =?us-ascii?Q?dfkOtzPrgxLxGdW+7JhUAyKnHcy4zz3tr2KcxbMgYVOf8Kn5wdHeJEqLtS9m?=
 =?us-ascii?Q?pFYcWneWrjGfTQCUBhju32JwtXoBzM+H8s3msdADPIAQTknMpyIVGK64acrG?=
 =?us-ascii?Q?2STxiRfiB3eDmiZPT4ixigADQxj8EzSgUV9MZ69Ce6ElV6Y8MlR/7WnfF2wD?=
 =?us-ascii?Q?mleC4/KRw+dilXjpmHHoGjcZeOIfEppuMNMuz7uDLmItzkgHbcmbXdVnf/gW?=
 =?us-ascii?Q?TNPVpUv0H1h/UtJ9QgpDPpic9OqvPpvByVG1sVmS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a69111ec-4ce2-4c36-08e4-08db935be979
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 13:25:17.3071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: syq5+xm1LNe4iDxh5msdOjI+fwbwGVDTur+SbfIN4o8Ggh4cwisnA8W0kfcUUb978hYiSkaxswdj3RX5S9SVYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7010
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

