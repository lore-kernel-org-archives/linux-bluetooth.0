Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB7CE71096
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Sep 2023 17:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjIURJN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Sep 2023 13:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjIURIy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Sep 2023 13:08:54 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on0627.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1f::627])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8612761AB
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Sep 2023 10:05:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvHPjvOhNnNI3ifIhw/oklgA3AGhm7RrNf3Uz8aGnuLwqF/mlPIpyB3gDYGbKw1KRuKDRISSA5GMCfkBV9V40rm1F7SksgGbDnO7I2Y5fMxm3lRtkfh8w1SOnN5DUXvJAmoIvFyyk/jvcUuj0zHKogG1gEudnCoTV8AgPaCSI8aeTUHXpVFGW6Q+Hjmd9qu9tCtMevJVfYdLtbaoDHrplQhNUUy1Ua3pJ+ZHlFfx4EcWpLS7PFSngMNvoOimXgoaPC8ymkXlrpYTt4khaZV53AwwyH0bYZ592CNfn9ixDBG2bWxtLS9lnfYlx+LAd4aBEKlxg24Yq70rYEkfWsrpGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tauo9MnvLfTD5WOgXNQFeO5NxNGLhI/roBtqtDkEtAc=;
 b=Ed4gMdqXR8jNyFtV/heLWF68jlDHA2U+sjfFxGWxiU+P+OUDaN++coHYaPgcEdA4o6yInk3IwD4wfrZOTF78tIfyjJWEtnd+GsMxsHo8dGylVXdGnDSTSnOV+gDu8XZB96qP5VojhnmdM5p0aF/cvEQvQpEMDmTKyIQrJTP1xbCRiGMZlbLCady19LaufVy3I7Q7A/i520cr3mnX6C/B/97C7AeEAixZ2o1MfteSD9SVVkAdBFddawtTgtYVYFQ1IYLf7/DQ1PFZIiY5HSnflbpEU0C3/nGO1s+eocR5MArc9Ri8JR1YVTI36rUSehtMry4+okHO+f7UvR+COvSllg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tauo9MnvLfTD5WOgXNQFeO5NxNGLhI/roBtqtDkEtAc=;
 b=pUvLvakm77kxmAIDEclAcm8C2WaBt0CNhdRg+57gR3rZejt2LmyGc/mN+PFR9Jn7ps1nFiATD+jYvUU8WSsv7xfV5r+CgpVHfzLYAcQsf9+T7NhW3xGBDY5Cp76fqHp6MS7rBA2FQEcHXtB5g+iw9U9PaBzrRhw1UXHL0mkEXVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com (2603:10a6:102:2b4::19)
 by AS8PR04MB7653.eurprd04.prod.outlook.com (2603:10a6:20b:299::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 10:40:14 +0000
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636]) by PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636%4]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 10:40:14 +0000
From:   Vlad Pruteanu <vlad.pruteanu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, silviu.barbulescu@nxp.com,
        iulia.tanasescu@nxp.com, andrei.istodorescu@nxp.com,
        mihai-octavian.urzica@nxp.com,
        Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 1/1] client/player: Allow the user to control BIG encryption
Date:   Thu, 21 Sep 2023 13:39:45 +0300
Message-Id: <20230921103945.36180-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230921103945.36180-1-vlad.pruteanu@nxp.com>
References: <20230921103945.36180-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR2P264CA0148.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:1::11) To PAXPR04MB9398.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9398:EE_|AS8PR04MB7653:EE_
X-MS-Office365-Filtering-Correlation-Id: 80d1fd3f-d78d-4aa8-1ede-08dbba8f234e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YEO7FJmuqTh++VaVnrwEBo3P4ZKDPd2APronn+csa2aKXeuUONs4H4+syPKc8aQc51XzD/gSteUPp3snF5NpIXqiD97gcoBwM+bodiGy3jTkxaul37hQVMwH4WE9LccoiOWJFk8zkn90HiUyjRqKLmpBaYi3fIuOBRcDWNZzzIdYhpvEaruqM7FiSLPXrvisApSahER3rnvLWZgsppusZ8hJqRETc9WRsENOlo+8Qf6+kWUKs7Ug+BoZlk/o9vJ3j3iP2hd3H+irKCRccUH06hg7OPuhicYFMvwcFhl0+Aw5WXM2oNr42iVSEz4cPFPWzI99e1ESE5vt+LIBelE2cwC+Ol0V1MEluNPyJaF0ITgEm09T74SGEVoJwyxrQO/lUXcXwC6HRV7Yt3l7v5e3kFwFKk8yJ6EtfVn52tYh5TjCBDCBXKQFIo17q8U4ySsfsT1q6IvqRe6qLsZr97rMGmqwBZji3mHp32Mc07EbKNPNvBFWQ6JR9OMAsa2YpEVYBY8wYFtJHUDdYuJEjjh89XJQ5QyV5+KUgSTsqQBvmeL5TfghqiNwi/tzRZsM5h2u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9398.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(396003)(136003)(186009)(451199024)(1800799009)(2906002)(6916009)(66946007)(66476007)(66556008)(41300700001)(316002)(4326008)(5660300002)(8676002)(8936002)(44832011)(86362001)(36756003)(1076003)(83380400001)(26005)(2616005)(38100700002)(478600001)(6506007)(6666004)(6486002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nk7bGjp86DXijM5n57paTohr+QjJbLl3pYodg1M5cig9cqNFrkG0LJEcDDlk?=
 =?us-ascii?Q?jlzaJ+Cvps/zs/bNRF1uWZgn3H1aoUNY8TGP2DxehRNFhlWahRmpKkCk4/Qi?=
 =?us-ascii?Q?B/KL1I4lgo2FNsFTAMQ3zW4ClkLw1G99KqU/2cZngxPX3VOfAvjp3PntYbjg?=
 =?us-ascii?Q?mfKcTBgahTOyG3aO1WG1BOXTsMPieqZo6MBV/GvFvKGmItieddc99GRgERtU?=
 =?us-ascii?Q?yiZFNw9nGm3Ok/5CJh8kIeMarPrBOtJvwknMRwyG15qma89uMLGqfwKDYHc1?=
 =?us-ascii?Q?OZUwdi+SZmO8UmUEHQYt+p+X49jr2/17HogzHlH0PSghQRRV7sc8TLFkyApr?=
 =?us-ascii?Q?Uxm43K9WYwMkMMM1m0YIcSiS9g7m6XY5RVNIigW0BHb5EXIfocHH7VWPV/Ao?=
 =?us-ascii?Q?3vnd0e8GXPqml7HGPTqgH5woFSSk1AgzMB7RylnKVVKd6USV8Prpp8blxMY2?=
 =?us-ascii?Q?mJrpxUpA768t/2SMbOuOfzP3epss11sirLGUpgDitkyVt+q/PGQvV4ZjSjce?=
 =?us-ascii?Q?o41Vau7OGt0LEte3gIfgMH+c+G08/Yk603gsp34z4LW5KqW5bsENo7ux0DDz?=
 =?us-ascii?Q?vmTkyLwe1aBRYwSlZJmJiH8anU1YYj+R9FRSNAT/P4RBFnBBzxkSHoCXtE3v?=
 =?us-ascii?Q?fsqQrEs359hM3/qv0GGJUxTXjtXKUajrCMlenCg5txMOwzgBmUUEeAKGIGtA?=
 =?us-ascii?Q?3F5n1XKea2kccwvC/DYYqu5M/ENnIBRzgEdFUW4+4gv37FPeo9BBbi5tI9fD?=
 =?us-ascii?Q?UT4MhCzUOTZJIxGcsZSktFbdHjcuJi7jH25pF4fTlGlOdlF9Ht2TCxLho2Ab?=
 =?us-ascii?Q?b7iTEOZqiRL1yYK3jzVua8ofk4nHxTY1aEEZbwqYSPwNyfBMpRYmmt1fq/KA?=
 =?us-ascii?Q?PK6r+ZbD2+ieGwo9jY28uM7PYm/orbu5eup9q3hPQjmxmc+D8WxV30ZXX2GI?=
 =?us-ascii?Q?Zlq60uELl0NFpL5rAI1vMPllFgG1u0qOIlQGUQTaCyU5Tz7rsnnTO1VvGE1o?=
 =?us-ascii?Q?kba42jR+kZ4UtAFoWYBhLqhXu9/iIa8Nj6FT4nApHUjnXyw0+PGYTwYZTVSG?=
 =?us-ascii?Q?ql2rdDsABN9PivzF/mnJfNiQ4hAhEL+HpKZnuKT04HeZBxrf9CTDhgou2Gbo?=
 =?us-ascii?Q?PHMf3Qak1IXDSrreJQQi3spoWwiCiFkp9s/UmXRg7kg4Cb15W3uyfgxqAOTl?=
 =?us-ascii?Q?w5aCrqlA1eTfX1p4sEFYQueLGwRKJRPrJeYlMg1sQ3fwrYUGVOeSQOqz1dg2?=
 =?us-ascii?Q?VN2dy3NSWzKkeBKxS5OXZOg5YRC9KIUz8YipAML9N9Zu6CsxeXEFFAxWkMsg?=
 =?us-ascii?Q?ZLM7WfzDJDWTlALZugcOl5vIRv5A8uEGo0TVmYDG1RJleXGOAYgeE1rE4mkT?=
 =?us-ascii?Q?ELcmz3QRh84x+RtyHAJBQgs+Mfr+ZnouxeOf5IhjinZ7jkQFZyHp1gZrTSk2?=
 =?us-ascii?Q?DIZD3m8+GnCDgsU0RkgB1ku6N9Zr/BSqWM/fjM4S+mDoPmWZhnuog/ZBhJH/?=
 =?us-ascii?Q?2XyyX5E9HxKz0tp+nK8cJP8qVbQSc8+cqy4n7Y3ziLFz79fAb2u2wF75shxV?=
 =?us-ascii?Q?yoRa8RpPhFpuNVqpqa5K4T2ZRxLM2vXA6bdpR1Vz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d1fd3f-d78d-4aa8-1ede-08dbba8f234e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9398.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 10:40:14.0167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r6KFcfm53reWoayBQUXWKm9wYMlU60hQ5mY3nWGkwGyC+Z7yKW1HNPC4R0hhfcqhg45Qo1uAEc1FJm9ogSR86w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7653
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This commit adds support for controling the use of encryption and
setting the broadcast code. This is done as part of the endpoint.config
command. For source endpoints the encryption flag and broadcast code can
be set, while the sink supports only broadcast code setting. If no custom
broadcast code is provided, the default one will be used.
---
 client/player.c | 50 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/client/player.c b/client/player.c
index 42721c210..492a1ce54 100644
--- a/client/player.c
+++ b/client/player.c
@@ -2750,10 +2750,10 @@ static void cmd_config_endpoint(int argc, char *argv[])
 	const struct capabilities *cap;
 	char *uuid;
 	uint8_t codec_id;
-	bool broadcast = false;
+	bool local_ep_not_provided = false;
+	uint8_t bcode_arg_position = 0;
 
 	cfg = new0(struct endpoint_config, 1);
-
 	/* Search for the remote endpoint name on DBUS */
 	cfg->proxy = g_dbus_proxy_lookup(endpoints, NULL, argv[1],
 						BLUEZ_MEDIA_ENDPOINT_INTERFACE);
@@ -2773,7 +2773,7 @@ static void cmd_config_endpoint(int argc, char *argv[])
 		codec_id = strtol(argv[3], NULL, 0);
 		cap = find_capabilities(uuid, codec_id);
 		if (cap) {
-			broadcast = true;
+			local_ep_not_provided = true;
 			cfg->ep = endpoint_new(cap);
 			cfg->ep->preset = find_presets_name(uuid, argv[3]);
 			if (!cfg->ep->preset)
@@ -2785,9 +2785,10 @@ static void cmd_config_endpoint(int argc, char *argv[])
 		}
 	}
 
-	if (((broadcast == false) && (argc > 3)) ||
-		((broadcast == true) && (argc > 4))) {
-		char *preset_name = (broadcast == false)?argv[3]:argv[4];
+	if (((local_ep_not_provided == false) && (argc > 3)) ||
+		((local_ep_not_provided == true) && (argc > 4))) {
+		uint8_t offset = (local_ep_not_provided == false)?0:1;
+		char *preset_name = argv[3 + offset];
 
 		preset = preset_find_name(cfg->ep->preset, preset_name);
 		if (!preset) {
@@ -2795,7 +2796,42 @@ static void cmd_config_endpoint(int argc, char *argv[])
 			goto fail;
 		}
 
+		/* If the endpoint is configured to be a source allow
+		 *the user to decide if encryption is enabled or not.
+		 */
+		if (!strcmp(cfg->ep->uuid, BCAA_SERVICE_UUID) &&
+			argc > 4 + offset) {
+			uint8_t value = strtol(argv[4 + offset],
+							NULL, 0);
+
+			if (value < 2)
+				bcast_qos.bcast.encryption = value;
+			else
+				goto fail;
+		}
+
+		/* If the endpoint is configured to be a source or a
+		 *sink allow the user to set a custom broadcast code.
+		 *If no broadcast code is set, the default will be used.
+		 */
+		if (!strcmp(cfg->ep->uuid, BCAA_SERVICE_UUID) &&
+			(argc > 5 + offset))
+			bcode_arg_position = 5 + offset;
+
+		/*The broadcast code is found at a smaller index due to the sink
+		 *config not using the encryption flag parameter.
+		 */
+		if (!strcmp(cfg->ep->uuid, BAA_SERVICE_UUID) &&
+			argc > 4 + offset)
+			bcode_arg_position = 4  + offset;
+
+		if (bcode_arg_position != 0)
+			for (uint8_t i = 0; i < 16; i++)
+				bcast_qos.bcast.bcode[i] =
+				strtol(argv[bcode_arg_position + i], NULL, 16);
+
 		if (cfg->ep->broadcast) {
+
 			iov_append(&cfg->ep->bcode, bcast_qos.bcast.bcode,
 				sizeof(bcast_qos.bcast.bcode));
 			/* Copy capabilities for broadcast*/
@@ -3213,7 +3249,7 @@ static const struct bt_shell_menu endpoint_menu = {
 						"Register Endpoint",
 						local_endpoint_generator },
 	{ "config",
-		"<endpoint> [local endpoint/UUID] [preset/codec id] [preset]",
+		"<endpoint> [local endpoint/UUID] [preset/codec id] [preset] [encryption] [broadcast code=xx xx ...]",
 						cmd_config_endpoint,
 						"Configure Endpoint",
 						endpoint_generator },
-- 
2.39.2

