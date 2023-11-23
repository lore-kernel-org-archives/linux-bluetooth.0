Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ea/SV4IL"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2048.outbound.protection.outlook.com [40.107.249.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E218D54
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Nov 2023 13:59:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJrVV3FX4kCYP28KAZ7qSyO4woDilgKYJ0+WGeaqu1X6MOF70XrliTJI3GmQmBfK9ZiZ3E3gv5jtcwLK1QlYtaybAX/7sD8WoYC8REarvS0ZFm9VWra5hjjGi0EZhw1tfvg0Barh9uZ4hpodYKvo5WlHc7D3JJs4L+fqlSH+frukiF7j009jV/fQJghlUlvqkOpo8DgcyshFwiyRNuhU7O4KfZZmPIF2tdSG/wa68iSRsaUWu243RMiU2QKN/fshn+NHM09wEiuv1P+FNENv3IaXLCZQgZbtbGYZ5OdISIJWNQVAM/KUlylkUiqvX9jFofyYipQiGnWtH4ALm+MuDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgdfL/cxWX9/zPA4c0BdYvFW3iINckaRP01RLZreDCE=;
 b=f5teSx91Bqbbas0FqThDkLiOzL65sExUdgFbufCNuxGKG4jCMdsu5F3qY4LmebSuGF2vLW4D223kZI1+cXPCxKBgxIVpyj9MTtK3fu/VgQrL5xzzfjG8u37x+/VaiLNiyr8LOrfs+XDl9gkV+s8m4QgZhnHIjr6XI5jL1AkDYAlp55UPF6bg1Fddr6HV5DV/t1CeXBR2cyw31bLPyrNvjB5WdzsLEI/P653s/1yNaZnmv/qokqvbX5ryCEAE4WbfW3Cv2T4siSNJjNmh38qx7D2igH5skUAnAgVqqmI5y6JA3N5biXsMX+D0m9uojnxG32JlKpEFI1sPPdkZ0u3YJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgdfL/cxWX9/zPA4c0BdYvFW3iINckaRP01RLZreDCE=;
 b=Ea/SV4ILj5HrrYf0kRgzmzYvwWNib6/Rbno7vgjoyRRhauXxRTK13DhJ1VPbA+vA1jc1nKxEryuNr0mvIG8e1m353H53d7ESKJqSnTXMOvzV2hxKtl/SPZkuvn2y2Qfrc5E4OR/S/H+ZFO4Ji/0mO1L2F80wHUNHgbOZsxNsDYA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by PAXPR04MB8335.eurprd04.prod.outlook.com (2603:10a6:102:1c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.14; Thu, 23 Nov
 2023 21:59:53 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c38d:98a0:a823:d88a]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c38d:98a0:a823:d88a%6]) with mapi id 15.20.7046.012; Thu, 23 Nov 2023
 21:59:53 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v6 5/5] client/player.c: Add support for multiple BISes
Date: Thu, 23 Nov 2023 23:59:35 +0200
Message-Id: <20231123215935.73501-6-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123215935.73501-1-silviu.barbulescu@nxp.com>
References: <20231123215935.73501-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:66::11) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|PAXPR04MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e94de57-ea04-4e60-1660-08dbec6f8585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LPtOeDJGTxB/EXI1yHeETf8oR1qhZVZcRdicaO0jsYiRrAFNQ3/3zdkCjY2tP10jxpssUoLCgycpSPTs+2kdmktpXNvoXP527K+EehRKNW3xHXtw97oBtJSd69fnEdQ41c+sI6hvH1s2AO6aVGCeGIiZyogM+DURx8zw2Uf5o654Zl5ky6h/AbzIC+5eUUN7ZuDiLdtPHwqRiK4Fg1MdVJHsMkEknd9zGJqUtCs72me8McRvjwr1HxRR7OX00K+/cKi4qGvlP7CZuAbulFAQEhwRbmCvsa1//trY7BmdbnH51tXtr/Rwalo/CHz6/EH37xV6dIY/r9IIgun9jpyvIxjOVFYmRe9vBUvmWthYbIMS3AqSEqjp0dCxX9WJiugATQgnFPmUL4s6TVOsaW5oMGoXFzCVaqfQz7ywoSFNlHfxQZoNMow2HB4/LVr3Re2qlGZKq1IFZXUzOmdBBmVxLSgR9zcOQeun53nAmPu3TwTwXb2Vw7ob+IIrrniIQSUHFvHcaTiKxW2+Lvriz5zlONhCnKSxg7nadm3kxvjIPWSZjBlzbAt7nT7iwvgKLafn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(2616005)(316002)(66476007)(6916009)(66556008)(6512007)(1076003)(26005)(66946007)(8676002)(8936002)(83380400001)(478600001)(6486002)(6666004)(4326008)(6506007)(5660300002)(2906002)(38100700002)(41300700001)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eKfQ7+Ektcos2fl6q/SmykUZgAJ4ii9RXKBlf8STZycZQlWS7+GaYxb5RmxP?=
 =?us-ascii?Q?Cy5GvxOEwvtawtJhqJNqbe/j+8o+sOXIDmRy/yZRuVf8L8fx0PaHxv9B+0MA?=
 =?us-ascii?Q?0DD9Ny7Nay/Mu+dnKPF5+qJIHrn4qQOuMLlX+ULNbKekSh+VSG9s4ZJvVdlZ?=
 =?us-ascii?Q?Lp1zv01fosYudc0FQWz7/ExzJqDhWFwVMOSmcTMXB7g+9jxO5VudRH+RD7wb?=
 =?us-ascii?Q?SFBihTELyNsiFFPDEAa/TdDMiF4IoCWsSPDEkzEozsGt6YTQegbvufMw1HfC?=
 =?us-ascii?Q?BQOsCrBJ+mqdDg5CZbaCnjlXzqugETjZQkh8NG8zOoHgmfAsZVOpsxIXWlZg?=
 =?us-ascii?Q?nL5HJwTwNdD0J1gTYyrJ6NaJpiWsYUN1IaprXCnbqo9H16gpWo3+kmrNks6h?=
 =?us-ascii?Q?jW/A5jhTFevInNNZVyn86UeA2S6qOdknFeoIuLeM4q1+TlQFjg8Dyw/BCzny?=
 =?us-ascii?Q?g7Va2Om3BEPr7JaeA7EJjjZcdwc1CIMhmdsAGcA71WTA0tq5A02NE2930a86?=
 =?us-ascii?Q?/7j5gz8zcUbZ2DpnmUmUlpXTUQoad/5vxYkszAbtWJnt4hfSCT7I3xvqbs6U?=
 =?us-ascii?Q?uWi/GFwniNnPbZ2N4vnvqTmb66143wSnA9ScwHHT73II1PiC3C1yBwxP4cVT?=
 =?us-ascii?Q?TCDhWAaP/JnPuLq0o7iMEnRRYe6dxQpZ603hTiXkMpFmwEkVOoCjSxntPMPk?=
 =?us-ascii?Q?HSXyZ1cxY8S6Z1+D1E6HFRqppUgLpyF72lNtUSsVxNoehvgsL1Mawyb+nYPw?=
 =?us-ascii?Q?k0eNHG/EQ48iB4PJHd8q5QBhRdszaoC+A/F3NRQ3vLEXSTrNcS+MMn6NQ6Aj?=
 =?us-ascii?Q?dPg9K3RWhS+wjuEKUxqMEkFbgprxDDckA/+Rlte14+48Ph73EMjM1uAU2suS?=
 =?us-ascii?Q?d8vn7ItbHwBNDc+j+u36kXPYjip8B/hvR5HpH31+7T4EeTrCrgblO1Y+ukiy?=
 =?us-ascii?Q?ne8P3ATwwKDYljnHs6QTQ4LTstgn96kWKQskq0SrE7kqz6yLAbRQZmCf1Rda?=
 =?us-ascii?Q?6dXCTzpm0iYzTMcQZkEy4cE4ulxFUfOWLaGmm8qwIAli7ba7DJ1mabGQC4Ux?=
 =?us-ascii?Q?SaZ0ySm7qJsigPU5KaQJMQr7axFRWdg5dBzX222JG+hblXnCWUFn8iPS1Q9Q?=
 =?us-ascii?Q?AfcdHaMyYAewZeUa4K+j4EvQwK+MR2u5zjmrqaQjVANmp6gru9GhnML2Q+R+?=
 =?us-ascii?Q?jxZZnedEisR+7LcU8g0sOt1UzRzY3rMbI9SqUrA5XzPn5u5/RKNBLoTYUgtw?=
 =?us-ascii?Q?GbFnuqGYh5OiF60W4MV+Cm6kjMmyNFeZksVQfXbLZ+z3kWdTtPX+ovc5uHNY?=
 =?us-ascii?Q?RVZ2/4LN0g9bGOSlG2KyJM5I44AK+bMDPFNefn89MFDObIvdPBKuS0Ymagu8?=
 =?us-ascii?Q?LdxL6q/Gg114DlzWj9yKsLtcGu5lwwOApbYemnRmT4fRdQkop3zj3y266b8/?=
 =?us-ascii?Q?pbgUvRfTIpdE4AClU29Dt7yn4FMoEXMnA7A3DpUlpA9YhU5+0Z7gHNJ2uKHX?=
 =?us-ascii?Q?m3d3Kp5NWqxKDAv+AhPwyFIhUA+jDT05+T0iRZYazZgNOYvc0NPS46507Tji?=
 =?us-ascii?Q?TmDxdK53u4jFebldrKy/pvDJayP/9LAE4/eit2qlNmevfuNpIp3N2hxzH7Uw?=
 =?us-ascii?Q?lw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e94de57-ea04-4e60-1660-08dbec6f8585
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 21:59:53.0152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4kdP2UCoMH6jPC/+Hx1alvomboHAzVjLSkOzLOLs1cQtgJ8KyXsfzGcD6aqn0HR7UwdCww+Y7O+tXcnpPfBeLEOBxKswL9g4LN1hqZPqtjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8335

Add support for multiple BISes
Register the broadcast source endpoint
endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x06
After registration a new remote endpoint is created
Use the endpoint.config command to set the BIS codec configuration by
specifying the BIS when prompted by the command
endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 16_2_1
[/local/endpoint/ep0] BIG (value): 0
[/local/endpoint/ep0] BIS (value): 1
Based on the number of BISes seted in the base_lc3_16_2_1 more
remote endoints wil be created (If more then one bis is setted)
Use the endpoint.config command to set the BIS codec configuration by
specifying the BIS when prompted by the command
endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 16_2_1
[/local/endpoint/ep0] BIG (value): 0
[/local/endpoint/ep0] BIS (value): 2
Use the endpoint config command to configure all the BISes
After all BISes are configured, use the transports to send data

---
 client/player.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/client/player.c b/client/player.c
index 715598aa9..e060e6a5f 100644
--- a/client/player.c
+++ b/client/player.c
@@ -2999,7 +2999,45 @@ static void endpoint_config(const char *input, void *user_data)
 	endpoint_set_config(cfg);
 }
 
+static void config_endpoint_iso_stream(const char *input, void *user_data)
+{
+	struct endpoint_config *cfg = user_data;
+	char *endptr = NULL;
+	int value;
+
+	value = strtol(input, &endptr, 0);
+
+	if (!endptr || *endptr != '\0' || value > UINT8_MAX) {
+		bt_shell_printf("Invalid argument: %s\n", input);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bcast_qos.bcast.bis = value;
+
+	endpoint_set_config(cfg);
+}
+
+static void config_endpoint_iso_group(const char *input, void *user_data)
+{
+	struct endpoint_config *cfg = user_data;
+	char *endptr = NULL;
+	int value;
+
+	value = strtol(input, &endptr, 0);
+
+	if (!endptr || *endptr != '\0' || value > UINT8_MAX) {
+		bt_shell_printf("Invalid argument: %s\n", input);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bcast_qos.bcast.big = value;
+
+	bt_shell_prompt_input(cfg->ep->path, "BIS (value):",
+			config_endpoint_iso_stream, cfg);
+}
+
 static struct endpoint *endpoint_new(const struct capabilities *cap);
+static void endpoint_init_defaults(struct endpoint *ep);
 
 static void cmd_config_endpoint(int argc, char *argv[])
 {
@@ -3033,6 +3071,7 @@ static void cmd_config_endpoint(int argc, char *argv[])
 		if (cap) {
 			broadcast = true;
 			cfg->ep = endpoint_new(cap);
+			endpoint_init_defaults(cfg->ep);
 			cfg->ep->preset = find_presets_name(uuid, argv[3]);
 			if (!cfg->ep->preset)
 				bt_shell_printf("Preset not found\n");
@@ -3068,7 +3107,12 @@ static void cmd_config_endpoint(int argc, char *argv[])
 		/* Set QoS parameters */
 		cfg->qos = &preset->qos;
 
-		endpoint_set_config(cfg);
+		if ((cfg->ep->broadcast) && (strcmp(cfg->ep->uuid,
+						BCAA_SERVICE_UUID) == 0))
+			bt_shell_prompt_input(cfg->ep->path, "BIG (value):",
+					config_endpoint_iso_group, cfg);
+		else
+			endpoint_set_config(cfg);
 		return;
 	}
 
-- 
2.39.2

