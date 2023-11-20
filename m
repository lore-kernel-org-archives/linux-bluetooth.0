Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="B+SbHxZ7"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2057.outbound.protection.outlook.com [40.107.241.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A076B8
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Nov 2023 04:08:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbRxPYrhJss+mA9G2k6nhOu3rTERWKwx1pu2X1o0TTmg6+lG7ntHFQuK4NtoDe1hfHE3Fh9PMF+i68c7nICR6DsFJcBCkyD1Bv8JpvFiUrmRTxEuU+1cLyGCHnJRcFGAMy026Ak6AmK+LtzYQkwQW3KoQW/xaHRzVzqudy4f3C9s4amIuockpA2BX4lp4i8Fab6w8W0OzPOc6mJp/WGeY/gSWogcDrond+WULG8LRqcV0LXdZK9lFDB8dUSSn5f0ANfQW0zA5uTd4jQbat86ffWF/2oIHCpPThVIGIY5UqBuko9TOZMP+8N0ow6nHz/dL6MIjlvS79TU8xqXEbBwrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgdfL/cxWX9/zPA4c0BdYvFW3iINckaRP01RLZreDCE=;
 b=fxTA6JEUTUp7oNl2CjJt02mOrKa4Ujq7P6sG1MPf/MdfFE+9WnLRJRGXUHOT/bAb05HYS8FkrPq2vZzl4EoJM6slCzr20IlsBLusItpuIQ9NhdYklKd3SI+9qM35cMDZQN4/KR7+IsrLVkdpQcJXqtcN9aCoTjLHxwwWqDz2+L0akT08iWSMVC87eX25h0bDx3gNd5AxqId0jYlf+VRRyytYtMMjMOOmxgIDnlljqEkOZok24c6TKSvnZCB9Tcs4o4I1heACm13EY6oflfIbv2TieAHgp7nmJZBKmDX8EYlG8Xho1Rcv6yaGGAfxZd0yg83s9UYDJLG/XhGb9Ahwnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgdfL/cxWX9/zPA4c0BdYvFW3iINckaRP01RLZreDCE=;
 b=B+SbHxZ7QXwVTcr280MZQUFHoHUtKjLM4Ors2D7jjnHskjbHTScobfaBHIsBzHAb8RL86fR17wtIpLKGy0B04eB9uZdQQGKiokWALE5VYFCswui0pM9lQDFmbAXRmQanKaZEZHDjw9heQ6Vr6eNq4W9mNVgiwU+3TfTxAudgroU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by PA4PR04MB7966.eurprd04.prod.outlook.com (2603:10a6:102:c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Mon, 20 Nov
 2023 12:08:49 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c38d:98a0:a823:d88a]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c38d:98a0:a823:d88a%6]) with mapi id 15.20.7025.014; Mon, 20 Nov 2023
 12:08:49 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v4 5/5] client/player.c: Add support for multiple BISes
Date: Mon, 20 Nov 2023 14:08:31 +0200
Message-Id: <20231120120831.5353-6-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120120831.5353-1-silviu.barbulescu@nxp.com>
References: <20231120120831.5353-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0063.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::16) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|PA4PR04MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: bed742e9-f690-49db-71e0-08dbe9c17446
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wCwtoktjEuvwMfFMO6CVJ1KKL6ZezKvXgbddTWNiGxOnRnmmtCXaQyOLLWJjguq94UKfLxfGOpIAMSj5AVudsLLSFGQpZK96fuKfMY3zBmNTlbC7GuiEyk8t0KtDY2fUAu823RMe9TXIuiMtD/aDH5BuDPZMe4SeFhsyseUsXSHqyKeOvIgxvkA4RTVIE7hTG9gLkd3s/lBoibUUpNYGjoX3NXO7i5dClvp4XF3c224uuc3kIUVkIBK19bMUq5jaw4pTsafXMXCsOc3CzFXEeDrcugv9sn8o/QH/ibrFwGX4IXLCtZX3//MFqNYwSKx64ghD8CtS/C7seN9ZJmjATaAArv7wowMWAgpN/j9z9VAgs+vmrbOwttJD25+GkLImH6esSFkh7yVNhrxLh7Pia+Rd5PbhVkA0J0JwXVmOmBdkExqsyC+j4TOIYAYbceWkzHM8VT3JSMVkZiiJPCWHlOGwfJDxupEx+OZOBugt/x+9rvF0gtVz9Uax2HtzbDgl/WXDqxyIoUl85mwiHIq3y6agAjQ6ugRn9jbc7JLnuNtnWTB6qLpRHK8Hxq66uMuR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2906002)(41300700001)(8936002)(8676002)(4326008)(5660300002)(66476007)(66556008)(66946007)(316002)(6916009)(38100700002)(6512007)(36756003)(6506007)(6666004)(86362001)(6486002)(478600001)(83380400001)(26005)(2616005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J9oDslWr1xgSCNbx9CS4KrJ96cpznmgUDq6vEV0mA8g60bp28nQlZfC1IKCr?=
 =?us-ascii?Q?EclmYg7Bf/yV/RlOYKbLQAyssDTB90wTJhc0Fy8cn5t/Q7xzqStYXZO0Z6yf?=
 =?us-ascii?Q?MCH568Wf0zvNQCRzaIXw0jfZOcZj6bTa29/e4+mISH9e4XdIIWM2sW2ISJJw?=
 =?us-ascii?Q?qSFqcwhEg1bh9cooiROGvnZXunTrpZA5t9wv/17AZCE67lg2NlAnIZRmnhZm?=
 =?us-ascii?Q?cLQVxK4EEvFmehAgGHH8XMUc/76sbnJStYdIRrzyt2Q0rfO9y0Pvf9x+BGNn?=
 =?us-ascii?Q?i01EpN4Qv4x0LoGmoTuh5d6uwK84nl38RDmhrQkBgtX9jnUjmNeyVDUEnBeT?=
 =?us-ascii?Q?d91fd7uAuZlrpNSD6FkqF9mUZyWViNFERQZeYHx72ElAnz1ZL2uaZuoKfYKS?=
 =?us-ascii?Q?a8ci3jIvbU0eQWGVCe0r3Qz9G0JstauxV6ej7jgBZ5eSUKW4n5vsdhRX25wR?=
 =?us-ascii?Q?yI15WfFXtlnOHa4TKB2hS+vWKhcRkc6/g1sT4Sa50KF0IdwkCGyVX2fi7ND1?=
 =?us-ascii?Q?SjKOO64Ev1K2JGmqWYzR48VohFvNPGk9ULgYCV+GMJhfR3Xqa3DIz6DkzpOT?=
 =?us-ascii?Q?gPfWjW2+RnRyQ4OW+Lb74hcmogJnL7Zj878npCsVyFkGs6CfsY6/Tp8wLMQy?=
 =?us-ascii?Q?gxgmX2x8+jCQEfi0IPQaM+BacWCrm1WcjIl2sQtKgXnkouovqJ+v3I+yQQ/w?=
 =?us-ascii?Q?zG1XV3k9sq7txs/utnAEsuIWhq3ukIBi+A3YSUeuGRlnzk5lfcnTpWjKb3lL?=
 =?us-ascii?Q?vNYYCdJKT8gaA4Mrq5RfINNuejVSnZ8YfUNb9hsZEBJHKM4xhinyzwcDXtpw?=
 =?us-ascii?Q?w9p/QxR4WBS+ifwxboMOllnhMcqEoSwz56xWqHTxcCJHtiOPmhORkSrN0XGF?=
 =?us-ascii?Q?Pb/88VM1z7cyq5xAAEOmRusEYHgy6N9DJXfVVhOoLMyIpQkjO4v94cXdbjt9?=
 =?us-ascii?Q?6+NCVgkggtC8gEL+6n/pwHOV71aCeMCerebyk8yJeL1XNzYe1bvUxT0BzlCb?=
 =?us-ascii?Q?qHrEtOZtDVg+dDS606Uaw7OQ6hJgJwYJdjF8gxOlNrHbfBQvlSQ+C9QvgltL?=
 =?us-ascii?Q?0z87cDgZO8XmvufIk8T2W8PuxmAes83/MO/AMksrl52IK1yTXsIQl6DXt79V?=
 =?us-ascii?Q?eTL+5Xdf3hsNvgO9QnyoU1cEoLLYbCUuP+2wZRjPorGyhpGSDIYXjn4y/AlD?=
 =?us-ascii?Q?HpDExVhmnmXMtfbKQWL83FChF30xx9l6nj/t3aWk7Xh6gZIu0mazFeEyvqeI?=
 =?us-ascii?Q?FduDDTwWSprWTCWgdFQ0UeHcaUTCi0XEwdDCN1hK/PayY75/2M0ijkC24Lt/?=
 =?us-ascii?Q?mHspSYnXW7zzm7RYVwVqNzjsVQpDLYXDd6M5HhoO4R36WdJy/hT2yuTgRhBt?=
 =?us-ascii?Q?vPkeWA5plGsagA/26gcEvoXsHGW1nG3nO9nOgNMNm5mQrugHT7uBsBGc4FCx?=
 =?us-ascii?Q?pWR0SSzLZ1A2PoevIYKmOg1Y9aG8AFe6w3hiBNuuDzzZGzlGTEoQcg5lEQKT?=
 =?us-ascii?Q?vQW6EBSw2sias5mOirekk12Cup07hCbessjq4RttucAefFUyWf35w0AGZNmq?=
 =?us-ascii?Q?y/7m+zKktqdcM5WOz1CeYJJfXO1lNB5TUWTKaRHDHWVbuQEvCuGBb9H7AdjH?=
 =?us-ascii?Q?Hg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bed742e9-f690-49db-71e0-08dbe9c17446
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 12:08:49.2998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B+K55GhR9gTrEY/klwYCWn/tJla1tDXRPMxMUeG4pztPtGoABYk155QlwBVHbYYXAr3GC1FxVVYmcgdxLWSomTLXK7PKbvFNOPRol+AfPLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7966

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

