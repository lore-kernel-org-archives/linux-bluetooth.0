Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC9EC001DE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Aug 2023 08:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbjHBImF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Aug 2023 04:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjHBImD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Aug 2023 04:42:03 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9242B2
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Aug 2023 01:42:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBZSI02o75BQPS6RAjVS/ZETXm9iVNqW688MkIEUyewaLavgClbv41aNb4gqZ5ufZwBDv8tmy5VqVMsBCnF+ZRbmJ7gjr5ZZ1Js1+ScPvbUFZAfX0ZsazV1RJXrRYZZ+4FEqRSVAtPo98D8x0T0jlz0pt6UYJdXGAhyXF2XDA/l52jGYC/Q0oRzT0SSCXiTnTQx2q7IFKh2LwUqe3F2Vn08LBerqfJPfl1oh0R9XaVKYux4FkguAOm2xX3zJWT228lKcmBAbx0DTTWv9p7x+y8GwuR7phsizoH9mzSLTEjxRLPNcv0BRUXiUIiahJm4f/XftH0OM1twZ0m6UHQX9lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cywR7JEzuV7zKrI1xonk74lSgQYfUdDI2o8FsJNsdxA=;
 b=gVBYSeKEBlbJxkpJizQ7QkJSwbhs73CmvHd6qrlktmq0y7qByz69iCbr8zEJcuy5oFW5u46ZThg/cHAaS+7RiWDA99aQe/zLQNrFzH03B0YnOcljiNOeE+6rfwXmyIFc4g/1r+1azxi+Xdx7+LE5yfG37RdEM1Vw//hzjxbC7KkkTNlzR3+l+Ch26LsiUQPJq/W8FCmAiEmvEKd5SZS2rpvFAiYhsxN4UlSSp+0zVsAbfTsAdkTS6Nun2c31FB/Sezsz5nSBo0I8JpocqPoeLPDXCyFcJoD8XXr1fUOGEsVUz+rf9zHKiWbqBT2uc4ZkhZu/cPGruH0QBITMXEp5Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cywR7JEzuV7zKrI1xonk74lSgQYfUdDI2o8FsJNsdxA=;
 b=ms4lMWEeKDtRUx9SqKtjFY+a8tSr3pBwTtgKi3LcO9q1HFBe3vca5O89LQKbeXasxSrKru9BA/KduyMiMxyABSKT7oiLQwA/SQBdQ+4U4wffulxuTrCpXh5EXco21AfUEKZ39CyZ2J0wZafRypTEJwg+i/EP5IJM2+7EKkdVABU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by DU2PR04MB8503.eurprd04.prod.outlook.com (2603:10a6:10:2d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 08:41:59 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 08:41:59 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v3 1/6] client/player: Add broadcast sink endpoint
Date:   Wed,  2 Aug 2023 11:41:35 +0300
Message-Id: <20230802084140.51105-2-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230802084140.51105-1-claudia.rosu@nxp.com>
References: <20230802084140.51105-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR07CA0003.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::16) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|DU2PR04MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: b5418301-863a-4868-43e3-08db933455f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WFDq/p0kNto0kFtGn9LkVNwcuwq9yEVavbfErpugSqMkJQpOYjodNugr/IinWKgvTb2rIIkhLM8JulXoB0+fqyXVfpymivh9ENlxfQQIx/rBzvYCWNz0BnGb6OReKgLDF4S+p+5GOyIQxBovOp7HY05F8odVd/k9ghlK+1MZtpe/TGOfLu5vKgbnV7j3EwbpqYj9hpUWoJ1gN4El+WhvecRfymnPMjFJp5SEOMKc4GwI6W3PW/sbIf/m4QLVOCiatSsNedVIt6duK4ko38YSa3Bm0yaQVM1bnyu7isNYgqMBqtPsXw3Q9inXxVYuIoaUTGysx+k0E6zWm3BLh5oBHoxdCk4d7jGE7d+sYn5H+q4PQ4EPm//qZpUuovtdtwdLpKAeYpDjdhBJL6tZ2mvbAJ3IslwQfmdmO+V8DiprhnhyfOKgLdjECXEtz/yKZANHgSo0fk4urbWp+YTY8ICBzjZm1Pui8iJse7KCJY3eA0Ygoi7qZaAexivlshOi2ZMFoYFfvr2vQ3RAR036F3zHuhV3jHwuDg3HfPbcsxLxCeXfjerKT6ZzZ/zd17U2e4TTPJkkx8GuBgsOsqf2Ne52b8/hcbsGDLH2P/DHQSDGLFYHaU2OzTmT+EMMYkvIsY+x
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199021)(66476007)(66946007)(4326008)(6916009)(66556008)(316002)(6512007)(83380400001)(2906002)(86362001)(186003)(26005)(1076003)(5660300002)(6506007)(36756003)(2616005)(38100700002)(38350700002)(41300700001)(8936002)(8676002)(6486002)(52116002)(6666004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QakX3LsPRCGe8/lmnzpfeOVuIqx4KJs7sZ6eEc3DKikDI3fAr1rUcCNFNEW2?=
 =?us-ascii?Q?v1RNMmmLiTFXW21Qic/MuA+Yl4IPSI2PWjti5UrEcDX+5wP7DGnh6n55g9Ma?=
 =?us-ascii?Q?hDhWi8ZSz+eHD0YerQfmeOAa8m2zi6i+xiGiqywN3Ew4qvKT4jlLj8HO5Oex?=
 =?us-ascii?Q?fQKiVQyhFgLaQaSi8MrPtWH8vo0BPCH1sFEKJjWyGdpkc9ofLM7GLdwlsi2L?=
 =?us-ascii?Q?UZpd6lDGOFz29Qe0t1PKUaf54gDHpR034Z8ZxpUvRw0ezcGmgY5tdWSfeJGi?=
 =?us-ascii?Q?pNVEpwcX4tulVyoxxL8pF4eyaju38yVS+gzg4rf9WldnxHLjg+4yBjgUaoHI?=
 =?us-ascii?Q?FsWYUSIyFpX//Gg61PZp5H57OFGre92r7ZMT0y9aRANnXCeGVouy1kJq7anu?=
 =?us-ascii?Q?l3PHqI3l0C6l9U2TYupBG9wgeFRVI3BcJJOW54ic+eOSdSS7X37SlYk9cPjw?=
 =?us-ascii?Q?6N4PEdWKUH3mOmfysoZkdTH14cmpic4CIiAg3K8pEeLFl+35zOaC3iUCQASq?=
 =?us-ascii?Q?1YQS0cI5aDLXbjIpygVaSxnjYGJrnpARHJhEobCDUCNXWBQvtf79DyLBze5x?=
 =?us-ascii?Q?gVMX0VrFwM5IM6XINgVJBMba8dZvte3xN5ln6RufkIBDuyGq1D+Hrf/hFJSI?=
 =?us-ascii?Q?+3fIjSMrLIjzH4KtekcXkCJECGJEWYpcTt8clRSO7mS1DQKoC0CM/quLg9XI?=
 =?us-ascii?Q?Nzl9BL1uMkh9u+QhTHeOs0fKqqqz/yY+OicdWtpJ6H3T0yiyq/Qx4lSp/UlI?=
 =?us-ascii?Q?4Jfv3mWhW/WjluxaIxDIjh9EMIcN571dh4S/KzadOagsuf0gVpozv59bbsIM?=
 =?us-ascii?Q?qHI8Pai98YoFhy62Gd03XgK6IU9Yrn8aOVMymi2QbpJ3OyYYDeEaAfNKIG5w?=
 =?us-ascii?Q?pzkTCjVLIyYXl1ql/dPKVyxRqUoWnXDw6tm/rvaqIYtuooJ5HE5vctsRiS6v?=
 =?us-ascii?Q?yCNtwmi2T/oRgh+aLNPijoiRyBojuGI3Xnd+OWRwjTYqdp5nAnUVsUXB+/kk?=
 =?us-ascii?Q?ktD4q1/IfIm82rvb8yb498pn8N2Jb1s2wL3o+TZ3fEh5qhWqg8XNJPjFzS2N?=
 =?us-ascii?Q?FoCGIv7zyd7W1nBM6c9UGIvT+/4pRXMq29qp1i+YOJmBsppMQ8LTGofp1PSI?=
 =?us-ascii?Q?WblvMcu1728VMSr2RqCiSEiPaatjJ7pb3B2ri64HqP9EZRuHQeCOc8DqKy0h?=
 =?us-ascii?Q?H9hd66h6Bu2td0G3dgTSGQGfkCEk8T6lBHB2L0P7+inRd2Tma2C+vrh3cvak?=
 =?us-ascii?Q?N54flHPQMlmuFU56RbF76WJ0kTChshkcalhOYY/qeFj7SUPcFBWYB/XhmJGZ?=
 =?us-ascii?Q?ugUc7Dhvb6BVV0GpM/yAEWnwtbed1YKpacj9jRUfLwVcqysE8B5brdYXVqVW?=
 =?us-ascii?Q?G05brtzlUj2WikUyPA7WLU+5SWh5P6iGyLb4Zc0ZdB7ErM5e8b4mC/QCgnmh?=
 =?us-ascii?Q?ZL8e2wvvZMpBH+ttkN/YenTeaudLScoA3QEqg8XlLkgd66is4WF4vfcg4UPA?=
 =?us-ascii?Q?F09S3IL6K0eswyIyrWWUcUTfzVk6QXbXTpO5eepM8b6XFId8Lv4zT2XZOtsW?=
 =?us-ascii?Q?swVq5EJgOA5SZeW+R/sAO+k+WXvGLjfXcMGcsl4b?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5418301-863a-4868-43e3-08db933455f0
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 08:41:59.3931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c8ZfM+0X3QujGZT8BRzrwOD6Wu0LHLCh9eIexc0KxML4tb0CWq5S7neWTKxLrqzPhr4ZloTETBdHnWQkOjIINA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8503
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

