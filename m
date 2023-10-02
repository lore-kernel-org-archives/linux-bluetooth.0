Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9D7E7849A
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Oct 2023 12:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbjJBMiA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Oct 2023 08:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236623AbjJBMh7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Oct 2023 08:37:59 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51C1B3
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Oct 2023 05:37:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtmeZ32dOuiA8DahpsETMhZaTOu60r06WqLPgfSoVZZH2av82OPTGF9ifM4VVE44GGokMzpjcmtjRoz9OBlrwA/tYZv5Ly/ztaLyEWghlAz/w0WfmWv69zHxLe/4R9NSMxmT3iJuOCgeTrrLgKhy/Hgp15HdOabZoVXB3EmILxf9sUVAaFm8oajr/1c2upjWZSQgRy6chm8b90KlFBIrYPDtHn/ufi3TECqROv+zrppCrq646H+zCaxTH2Uijd6h6kpnrWcxIdgrQTzUJ+/JSVUgDkoDfDLuuo9M/KoKS5bVzjAK0wo08UqwevtEQ2K3iR7X0RKBnb45yj2BfDoaHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9pM8kY3V8ykY73KWQY40UpOql0Qcn/3ugmc4HJ93Nk=;
 b=hAHUHxsJxytiIouM0cpGDsO0Omnkunr5EbVSaUQQuXWZOg12a6pBVmVfjmIUr00OMCCE+8c9FlgINd0MMn+rbF7hXaIComKRO7CXoxxI//WdRzCAMo/sEdKaAZemaTDxLqH3cNKd3bwpNiS3ciT60NeUFm9FND0gUITe5XbUUtxJPV6l4/MavGWqhusTf/npmmKLnORclXG1vPui8QOS9DWVresgCu5/AEG0dGt2yVq+O9RcEpdr7Wl32AJLg0gxKAQitKBwMVQ4MSMqT+LQv1nmqgXaHnHJgiUR56p/v/NtO0rFF7MkQQRA+PFWNwSeH5siGMXKi1WBU2YFoBGyFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9pM8kY3V8ykY73KWQY40UpOql0Qcn/3ugmc4HJ93Nk=;
 b=LDJ2dYEEyY9BGjHQgcxEAx3yYKD2dn5amzifv1a7l6j1ezS9x1uO/Uidxpc7MqFYAGWcU0KhGFhdwYjxutc8jh7onN2wxhwqnyq7jF2KYUZExtamoGyHXkmdPyp0c0FKcjjysw/YEdaxbqNzeJIfpgm/zm56eHRA1gFKteLnpm0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com (2603:10a6:102:2b4::19)
 by VE1PR04MB7471.eurprd04.prod.outlook.com (2603:10a6:800:1a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 2 Oct
 2023 12:37:53 +0000
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::7838:af8e:f859:cb04]) by PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::7838:af8e:f859:cb04%6]) with mapi id 15.20.6838.028; Mon, 2 Oct 2023
 12:37:53 +0000
From:   Vlad Pruteanu <vlad.pruteanu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, iulia.tanasescu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 1/1] client/player: Allow the user to control BIG encryption
Date:   Mon,  2 Oct 2023 15:37:38 +0300
Message-Id: <20231002123738.22210-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231002123738.22210-1-vlad.pruteanu@nxp.com>
References: <20231002123738.22210-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0064.eurprd04.prod.outlook.com
 (2603:10a6:802:2::35) To PAXPR04MB9398.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9398:EE_|VE1PR04MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: 46ac2106-19ca-4152-f198-08dbc344658f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: plJUrdI8pHSbqxSHBDor9GT+feLMKyL8tm4EXKbGdFHiw99IhOCwzdzpVzy7yfDeUESEVRAqfuPOGYSMIFEnH24uSQPoO0qMui3lGTkkMhbFt/IPyUFbKq73lUXyF3Ij3QEBPl6JdB7DrrKEJz/XMD1wn5jwGyr/eEFbbljJ6u8zCcWx93eLynJFG3NsPzjhLioKoYYM1WuVU/3RIVBDoeci9RXN8MLiLecUlrSDRYxsoDiOidIHteDOOwJOFGdC6ve+V46bYsMsLc8y9RUFc0O0LT/1TrvuAJfHcy5ljITGs05EopXi5/t2iv6HCWJcvLM1phuY1+LxgjMwhyOB7x150pVvppkp4IQf2C5vpxdwhu1K2xQ7qsycWUe0YC1CnkUA7LeABhtU0OyMlvyI+kW23x3mPos13WM2yd6vNFvyTKi+7dJ8pMFR13FDM2DzzdQyOCkBkg7H8xSqw2VN5Co+X5kMYFSIrtzESUZ02CuUQ+5XrzWEgsOP7tCgcUq5VEMiryovvsEZPth/u+NhXH3dZxseUu14umfm6nhgykg8F0fP7ZcwRRS5CRHz0fkP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9398.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(346002)(376002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(6512007)(6666004)(6486002)(6506007)(83380400001)(86362001)(1076003)(38100700002)(2616005)(36756003)(26005)(2906002)(41300700001)(316002)(66556008)(66476007)(66946007)(8936002)(6916009)(4326008)(478600001)(8676002)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PSzJQEaTcPhDun07htHQZDFPAXAATTpT6dnineVahMI1jlAy6a1f2emn7c9n?=
 =?us-ascii?Q?x7FXw0KD3YoJD0F+O7nBNNtlBYe9WgDjW04GnErV20zvppNDqHFooktfL/qM?=
 =?us-ascii?Q?AF3+MbRa5DuvBXwDsHNaxUIwnG5/Dq7jhrwuW60EKBs6q6H1JNnibgTsLFMe?=
 =?us-ascii?Q?ugMr/VyaPj5HgmiPh5X8/3Oy47e8ylAXVlqYUovZdcUfI0bVmHpV9vdLP7SE?=
 =?us-ascii?Q?wuVnKcuTWs5T6gniDNX0zJl9asuf8+3XCS6pRhADtuFUm5N/g1IRUDe43Bio?=
 =?us-ascii?Q?g8I3jkNBmpV4f3HcmzqLInuaFqsOuLz05U8fhN6CwHWe5A/qVeJLtihPWd6c?=
 =?us-ascii?Q?iM0OSOorywZzxODt+AiAOi6+XMfg8KoyyiFCH6vyZQLQCUmD4KulXntO7fSv?=
 =?us-ascii?Q?0jAV515tZYM+PANAVp3/cTxWlAm5SnhEB4DA7N5/W5FutM0Fb10UopgEfh47?=
 =?us-ascii?Q?1o9Mr8ZsJ4VsYDD8vVJmpPaEGO/c7ghvRnbFQCjViXyY6IfkGrSVeo9FfMQX?=
 =?us-ascii?Q?0bzKsgkvftz3qYVcgOWYUU4UaLgC7vtYK758YLJ0FcFFImVtyuH80PP99B00?=
 =?us-ascii?Q?cu6PsmT5kjBmkP7qZeqDLL4TrecITGsjog7dAFPD7HY5Td511ODAEl6Wp3OE?=
 =?us-ascii?Q?94RfEAbKk/i8/gl+dlITEOtYJHZLg6BQgxr4jt38i5tXKS2Jgsqw1q9kH3UL?=
 =?us-ascii?Q?NWf0MFXt6R2cR2Wx5ZRReuK9zTjQdqMQT9ZQdvIxJpbUE0ofKB6tu/qNBIo+?=
 =?us-ascii?Q?/Wlixrf6MFQNlNjBreOPcG97FymcRAW841xEkfC9fzhNFapSOy+rBD+s+EL8?=
 =?us-ascii?Q?qyAPCtztKPjspfbe8M5rve4xoPxg/bdJz16yARkSucjhaQ7PLGuW8i25+VQS?=
 =?us-ascii?Q?dgBx2w2U+msZurgUO3lmH5y7R/XoniX7oSIIXpt8TgB9ZVc5hHJO52pyYp1D?=
 =?us-ascii?Q?ftOSiSBxKBCjNVzyJ57bV84dWkDz6BJIxNzcRstkNXM8KcFSOUTWGQDCoUIh?=
 =?us-ascii?Q?uCm8rP+bRH4blSuYg/mgNfOSaiGpm0B7S25SZ3izpvP35RZbXDBPvwurmsa1?=
 =?us-ascii?Q?kiKLtbY3L1WbFqA8po9ItJltChErzsSggaPTJruXX7VZEaQZBFcXsOyTdAel?=
 =?us-ascii?Q?oOOYdpQQZdXlwX2hMe1rumJl2xMlwG4Mt2nlbMcnwwlST/x0xq7bqE+BCyr/?=
 =?us-ascii?Q?qtPAGCV+SToKnOqFrXO/Sggka6xUxQlcoTTlAdCuiIQbnwzVRCiwWWXVdikk?=
 =?us-ascii?Q?mIlV9Q3u/GAvpm9ZLUGvEpC4ymImuFv3qlv484dRrHoKZ+JaGLLk2FLXI7H0?=
 =?us-ascii?Q?isG2QaluhamCp04309swPqqCYGzmfqWYo/bAFUfkHCZHRIxjT85R8O0KraDb?=
 =?us-ascii?Q?708bkcQ+GzYL0dMP9nC3heqOzWnXKtJuU9y0DYJExggQ4pOYgYwB+dDAvi0X?=
 =?us-ascii?Q?5U3GSBDmNazqiOiwd2DspL1W2Sxb0Mv6jAsih7dtalxVAT6MUBcqF3KtFY8p?=
 =?us-ascii?Q?bkw5YfG0Ajwy6SjVpZ0ZkeAeDdwOC9YQwEAzAeWW38vQP4uNi9kFzu8o4ORQ?=
 =?us-ascii?Q?6XlrJgg9Oirk2KFKDX05IjqkYxjwxMVEeEIr6ROg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ac2106-19ca-4152-f198-08dbc344658f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9398.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 12:37:53.3585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EQXocZv0VtatS+FT12Uxqec3tJjv64sNIBy4r+6VIxzFyvG7V+G0UJCusIoWpp5JJeaHR/BTQWVQvpudg++2xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7471
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
index d1809f24f..3a9313bfd 100644
--- a/client/player.c
+++ b/client/player.c
@@ -2792,10 +2792,10 @@ static void cmd_config_endpoint(int argc, char *argv[])
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
@@ -2815,7 +2815,7 @@ static void cmd_config_endpoint(int argc, char *argv[])
 		codec_id = strtol(argv[3], NULL, 0);
 		cap = find_capabilities(uuid, codec_id);
 		if (cap) {
-			broadcast = true;
+			local_ep_not_provided = true;
 			cfg->ep = endpoint_new(cap);
 			cfg->ep->preset = find_presets_name(uuid, argv[3]);
 			if (!cfg->ep->preset)
@@ -2827,9 +2827,10 @@ static void cmd_config_endpoint(int argc, char *argv[])
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
@@ -2837,7 +2838,42 @@ static void cmd_config_endpoint(int argc, char *argv[])
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
@@ -3253,7 +3289,7 @@ static const struct bt_shell_menu endpoint_menu = {
 						"Register Endpoint",
 						local_endpoint_generator },
 	{ "config",
-		"<endpoint> [local endpoint/UUID] [preset/codec id] [preset]",
+		"<endpoint> [local endpoint/UUID] [preset/codec id] [preset] [encryption] [broadcast code=xx xx ...]",
 						cmd_config_endpoint,
 						"Configure Endpoint",
 						endpoint_generator },
-- 
2.34.1

