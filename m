Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fKoFhbF6"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2089.outbound.protection.outlook.com [40.107.247.89])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1900FD41
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Nov 2023 07:10:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9ub8d2yi7emPZFVf8cnAhyDUBL6v/yNpvNNynnok3ONSrptWGoYI5mJLZicTxRhtyKxHcSV50aRBak+NdjyLli5ZBYcCI7MTwjWY8h14qGte5SY2zQDawAAbub22x4o6KdxTyMaZIdtY/UnLXH/0q3oeE6RXmeAyGOtesCMl6K6Y354uz9co1UU32F3rU9hyAkckI38K+n+N4J9qJnHi5GEeuNwn6W35xCmqQs/PGGnklYtrIs2lE06cmiJo8xVJE4roHaHjwHAZ0JS6VvYN/WG2ThQerJ1zJHpBFEWa+pSJosopZbESWn0Rtq80khup1Rbv0ioffiGW8mUsK9L2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgdfL/cxWX9/zPA4c0BdYvFW3iINckaRP01RLZreDCE=;
 b=UyQjGq9Qw6VdBC5It/2kx8XcMLTumUgt5yB9tX9tnCPNvG/Q+hxEqJjCpVPb+f55D3e3VarVQJ8xPsmpcbr59cj+1xzgcjIRX4D3jhsanjxbeGAEwVNBH9Ub/klrgMuXX3CSFnkJtcsmyxkpZcvXycZrY3AQTO/NNzWtpmqmPXnfoCqCw5ujYfeiRw60mRQYzZXoLSDjo8PUFOxTRrkDq821XN8GK9uUCjg+j5MvpLwKCCd/Np89e1muPoI11gw+7Iw0xgdioeftSyoEYMozfcfoDH9kwqHx9fxG23fRQTmgSDa6boE0lpmRFgDD+0zDWPs2OTS8/kWfyOE12ofM0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgdfL/cxWX9/zPA4c0BdYvFW3iINckaRP01RLZreDCE=;
 b=fKoFhbF6TtTi5ZnKh13S31UgUp1+7RNof+6uQKQ3PPe1Lb/BOKT4m5fw0MfM/sFUY6qPgNYbYjx3ufyzf7QdKRBjc1PftK8pHyPwmoHx4s+sNlrT2OXv7h1WQ4naGYSYhVOyK+laczM5fN+hoaG2TFHTAW+ASccGhvGCgmckMrs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by VI1PR04MB6928.eurprd04.prod.outlook.com (2603:10a6:803:12e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Thu, 23 Nov
 2023 15:10:55 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c38d:98a0:a823:d88a]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c38d:98a0:a823:d88a%6]) with mapi id 15.20.7046.012; Thu, 23 Nov 2023
 15:10:55 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v5 5/5] client/player.c: Add support for multiple BISes
Date: Thu, 23 Nov 2023 17:10:33 +0200
Message-Id: <20231123151033.22898-6-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123151033.22898-1-silviu.barbulescu@nxp.com>
References: <20231123151033.22898-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0020.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::10) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|VI1PR04MB6928:EE_
X-MS-Office365-Filtering-Correlation-Id: bd49321e-82f8-4981-f52b-08dbec36642d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FHw0wtzR0qI1PMpD8rQ0zxSsKRcdnlW7f3d1eCebf57SaoRG0c6AzL1cAAp3wGVM++9mTLFguae2Q2Xfq6zMxUQsIo0/0KnJi7r5TI9l5+Y/JaAD+UC4fy5a1zGsoF/iuns0duiNkQdD8+8yZQesdYkHYwOSleDlJVOlNS9EmFojvdu/vcZw5S6T/heq9ad5anSPVF+mmkfPAXEU65bwN1+nT82YXyrOoRz+dGCSBSnd2MIKCwvlCmWbCCLN3HpecqjWSCgV9h1xLwhGzsXprA1QdGkK5SAi/9jYxbT3MQ6Fx9S6ER859lA+8uLb1n/qrY/WoIf6COoKg48+vP6CYbpGe6dQ9eyHIPB+PzzmYm88DMq57iM0qDxugMYc5yKutbukH+0XPTZj1a4+sa5FgIlxa5XADWOp6XcxU5a5u0VKqz79+WWi6nwIzV9ejmCh4B/QAMMsqutRE5Y2CNXeNL+7evgXQtGGsKNkoSyM49gH3+z5qh4qOaMLXFwp0YfNKMl7qJoI2ATNjnDFR0diOwTyKov0VPH3IQVc2OND2hGU18NyV+in9KZMFBl+U/Lm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(2616005)(6512007)(6506007)(26005)(6486002)(1076003)(8676002)(8936002)(2906002)(5660300002)(36756003)(4326008)(41300700001)(66556008)(86362001)(66476007)(66946007)(316002)(6916009)(478600001)(6666004)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?koGr/RXXD5EMeO1LwmX7tFhnMqoaN/LAgwpXERM0GqWEH0OdPGZgBMazVeep?=
 =?us-ascii?Q?4nU5RSOycqJSVgGUCvtZOOUSqOXH1wt5y/nlD2if0NOGVgh2N7rfVYCOIHnd?=
 =?us-ascii?Q?G15A7W9u+xJ4Aa5605MbbJhW4lJPhztGR9fr+6UpzHBlVbwGCrfrO2rJa4nV?=
 =?us-ascii?Q?qYEEyaoadPh6ipmkh5nExBniAblNLSxg174tlKNm57rdRBdt307scuNUJd8s?=
 =?us-ascii?Q?Kgupw9AKVzF73mgYEU8U0Jn7wVJjEEZUk/d6PqdgUxAIv13bltgwDwVG2bQQ?=
 =?us-ascii?Q?Ipm0o/bljMK4FHQIqZWlyLHj6DpHxJ0nO2bSNtqH8mos+Mf5B9KL4mZQFIFi?=
 =?us-ascii?Q?nCIqPuVOrI9mZdZaW9DMUwZsr49jp/CCXcnVwDvYgTICP4PGUETfQQnPm9jN?=
 =?us-ascii?Q?8Dx4Rs9tDslVrE3a/R/JB6uKrwvvKyHAcA0MQJMZPwEySyyXZmJSTnLaXt+l?=
 =?us-ascii?Q?HosZqRMfAMI2kzfTtfqI/Hed2qI95kzkI+VFj70RPEz9F21xadZcsWovPXXt?=
 =?us-ascii?Q?XliYnCY9yosNYz6b+iDXh2OaBUGHICjmc61/FT+KycBK3ijZ6lHV8ltZyn8D?=
 =?us-ascii?Q?9ebK0jTFv+v8jcPuaEcvQ9N6pycvWeEmM0WnD0UPVNo39uZzO/kB7PNWH9IU?=
 =?us-ascii?Q?IOQ9IiNqfU/GLBPzgm7JG5EHVC+pmh696d38se2ydMzmBL2yZppppyPd7TE5?=
 =?us-ascii?Q?maH9PZNriVu6wncjnYIREPP6WQ5prEaTobZvj9LBm2yLyVr2GxII/YLNg0vY?=
 =?us-ascii?Q?3dQDzUvdCiNGFWfJrcOhsIckEchGs691tlyrAiNe3Hd6/oiqpBmof95JpfyB?=
 =?us-ascii?Q?XRxjqiBlowtM1HGM9DBB5P65//Dj5Wr3drTg46cMUF0EoK1GhowYSAqXHmyd?=
 =?us-ascii?Q?UEVW5EMzDyvlm6PM3u2Cdi11MDUn8sE1MGslgvCIpm5di9mImo6GFpD9U4Ny?=
 =?us-ascii?Q?Mrvggewqh+NQznEKuuC3jFQosFdk9L8dbHEppIXnZu5RXwqr5aYFGnF2Rcjx?=
 =?us-ascii?Q?NsIm9AIS2LPZTL18kNwXPvqDq1bsMMq/9CKjnUt3qQ0+4Bm7+H+ZYxy7mZIO?=
 =?us-ascii?Q?3CpWFCh4ZpwDm02s6PCq3qSVB6xDULNR3HL6xjo/96Iqb7FY2PIs3z9hU6u4?=
 =?us-ascii?Q?H6CNl1FYKqw1qaepK4Yme0Obt5KE2M748rIq38tHQeKmef6iuuzRysfBnKBc?=
 =?us-ascii?Q?sJoFkbrFnK59Q7b9i+TkclLFCZ5fd55zur9Z28drkMe9Lf1X0lS2PlwhpJGp?=
 =?us-ascii?Q?a3Z2IaYsgteer/KI/R82euog5bBYoVEV7puHKA9S45U1YcXB/9WnSvP6kTm/?=
 =?us-ascii?Q?wr956o4wb7tw9OQmohYs1hg5/eX8K4+dnZVt3pbzAsvq7bde0DJ18TH5GHu5?=
 =?us-ascii?Q?nOFkNQNbRJ/vZVZ9DjuR5wK0HfuxCIgbHx18Wvt7cm9zlnQa8zraVZsGFGBD?=
 =?us-ascii?Q?3mXt9Y6Tpjb7UkInPzbXb5cYy2xi+2KPLQYfyiKq8RuuZlhunHF41wp6Iu2R?=
 =?us-ascii?Q?v7rNfAtQTJHFwADhI8wojkBD97s5QXnewcgFbf+KXw/+xV3/ebOYnaLfUCBc?=
 =?us-ascii?Q?V8rmQ0fYbJWMdMiqB1Cejg8GVAh4aGcp7QUB2R0lEJRCuMGrM+4UVOrlJ6TA?=
 =?us-ascii?Q?xA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd49321e-82f8-4981-f52b-08dbec36642d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 15:10:55.7800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 21ZnUwbYb73Hg/YK8u9LzuC27d23neRUMieME64RM4k4i5rGYVmbLi9o/gKN3wQPNyc0srbDOLkQkLejCrjh5q6xVT/kEynGS0zJHoDzNvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6928

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

