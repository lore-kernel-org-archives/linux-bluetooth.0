Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2081.outbound.protection.outlook.com [40.107.241.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC9F210F5
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Dec 2023 10:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FrqyHVRn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzBfahThGUDUuWXKNTeA8VPN/389flkumvp2YkzC3pefhsaP92eRPCtf23RK6OXQ+MVsKP8RlAnk7GG0W7UBclWRH2CgbofGST771LgvNVO6cBygrB9gR/7IxKA6h3g+eE4Lg6TiB8bLP4Ug4F91uB3QfdjMXub5OrCbYDG1VjwhdV+w44S55KH0esKHIyfxSCkJBuQiBDi9FOSlV6aLqwalMu3TDb21ZDI9ERq3CMPXqVKTdORjc6WCI8LlQcxttIIXptldA1OEDlRmKugGel2kSHH7F3gShgubbJTGGBN/cH2zAex3pHQCSe0nTbDIl2FyQ8cl7cUvVnBvTsxEEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5KVxZFeeK87fkDqfmn0l0nbTj5esg2OkXQYjZOy1HQ=;
 b=VBTgnnAsBz0/4NDWjOCMyV1IdT2jTGrc/3lFxKERw20iFM25PlV0aqD5N/i9RWgYM8K0GcgnC/vuSfUGpnL1otPQCSekdOAWb388t5wdHBrVialmPp7SmrgvVMdW2X2v/uj7PskF0mwCyh4cgSOnMJtARS/HQDQFc/dMYSgvBhTC8AQGGEFnoxTINBOJ+XtixCvwd8WsAY5ADVKHZPPewAopsLobgFJe9DIgXj8x4QQ1ZX9q2hKcMWoU8SeWRfGb+FTo9Tf20Xea18Ji59b86RAV+2CZlDfd4h7nANRjP+czJgUe6gq6NvKm4upNi0c7mt5d6MFJiF2f5Cirv1m+lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5KVxZFeeK87fkDqfmn0l0nbTj5esg2OkXQYjZOy1HQ=;
 b=FrqyHVRnnecvMBWXw63L8MegGqAeQgwmmXvN08VnlUqTkSs7v1j7VkpKlQHpkaEZtzsukSPAtUzIw4ZU2iiBAHjRNx5JwkoK3AFuNRmkeo8FWwONuGLKan+19j0U7bEfwHefmZ8P08IvSntD7666jvS0a5my0YpMRaABhWlt06M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5214.eurprd04.prod.outlook.com (2603:10a6:803:62::21)
 by AS8PR04MB8213.eurprd04.prod.outlook.com (2603:10a6:20b:3f3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 10:21:54 +0000
Received: from VI1PR04MB5214.eurprd04.prod.outlook.com
 ([fe80::396c:f971:9798:7280]) by VI1PR04MB5214.eurprd04.prod.outlook.com
 ([fe80::396c:f971:9798:7280%5]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 10:21:51 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 1/1] client/player: Allow the user to control BIG encryption
Date: Wed, 20 Dec 2023 12:21:19 +0200
Message-Id: <20231220102119.74090-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231220102119.74090-1-vlad.pruteanu@nxp.com>
References: <20231220102119.74090-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0034.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::15) To VI1PR04MB5214.eurprd04.prod.outlook.com
 (2603:10a6:803:62::21)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5214:EE_|AS8PR04MB8213:EE_
X-MS-Office365-Filtering-Correlation-Id: d09ff0c5-f06b-4ae7-f4b1-08dc01457b69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2t08+mJRSvBKXbt0zPS9otnowSWJS6bnJqol3VKmbBpCnI+689eDlRD/QI5YKtvTSuYzmCIC9QBVhQ7PDSjau6Qjbdg9YU3FBFhEoH54E0UiDclv0C6HAR9jdMWMKnb89f8MeA0bCmRUcODSTeQXQ6SQeR+OLDujKq22yHPaZvtKDA1yH75VycZEISZTU2czCx2U0toARkPYFn4NlFKu5ZHrVNsRCaQnxrZ+F8OiZ1ExL6ByrS/RSGLd/cBnFjLsMWqyeRRFOFI8vZgswbbNxpfgvVYfpr5q5Ga5VLyIhNyEcuHrWXXUJH0zXLpMbGwg+hGgCb464ekpuP/YV5Fk+WIJIilRyGTo5d1LlpKM/yy9ayHau9j+pZD8s/Ytvs7E0AK4l+a45+if56ZzTu4NXNZXILy0JAmgFAgBi8AheukVSEjqbVtxESWcP1DPYbpxJd6jl+JsiQPz5nHO0I3SbeG4b5DQRv3ryRRLmJ1HHiFSF7TOQvDqpPRr+5539bPyRMJiaaxz09cvP9qqJz2TEBGhQEsteg8F0BRptKE+fFd1/3bnj7cc92JYR7psnxAH2f6nQ3TiWzRzu2zy+1Je5VyVRwg1hugd79xWk8UmzTjELCpXQ0nk3XAvxCq+uXnJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5214.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(136003)(396003)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(2616005)(86362001)(6666004)(6506007)(6512007)(478600001)(1076003)(52116002)(26005)(6916009)(316002)(66476007)(44832011)(66946007)(66556008)(6486002)(83380400001)(38100700002)(5660300002)(36756003)(2906002)(4326008)(8936002)(8676002)(38350700005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PlgvPQ8q2kY/Gs1TiTCrq+awVA5lKiHaiO1scDFggIZTW0GNDAMMJGoj7HQU?=
 =?us-ascii?Q?udv0K0onCFwL/yoff1KBXGs+Qpys3v5sd19AayMB3lwWcTuIKvAujn0sbJwA?=
 =?us-ascii?Q?QRO8iZalUeeMqtygdadO3hN4VjaPixzcFHi4uJAv54Zts/cfTSAfomdGyCuO?=
 =?us-ascii?Q?kc8TyxN54lb3ixzifdqYzhQGySEsItslJ0zHvM4J0wsYQsMDy6Ajjmq5VFSI?=
 =?us-ascii?Q?wXP9kDfeT8GrBC0wNVxAcdb+QIxXGHqVQmpaSxogvd6tdsoEYtgOSRTmzwq5?=
 =?us-ascii?Q?+vIm+uARdtfvLJvzvYw00wAkWebdlnIIwMb0tYtbW5sWqFD4P1boLs3Gzq15?=
 =?us-ascii?Q?dYYWCCCic53gUi4S8QpdBUwhT0lup04avUlJqB0fUuT8lCcS1hDYWMlLZ5ka?=
 =?us-ascii?Q?A2R9CAaKewtkELVb0o6JKfUrCdG6yP39qHPmtwNQQeR+eR/N5Hm/fld96/jL?=
 =?us-ascii?Q?VJJ8M7RbwAH9OI/L9ycursA0RrtHwmzSu8nXJlMCAP5GaWym6NXMZ6qw0NLa?=
 =?us-ascii?Q?2ymRi0rNPFZDbz0VRHEJb6e2uvy1x4KixvTX8vQwCMOv2JDMqDNgbjMuLX5X?=
 =?us-ascii?Q?F3qpBd4mYJhQuuvpogog3oW6bfI2Gn15G2FCFmjaNOCENqPXJtJXS+1iI5Id?=
 =?us-ascii?Q?7rqNrGQrSHph6cTcbmgO5Oi7KWCLzJkkZvfGeRVMljt9Bf12s6xlarKmo9tH?=
 =?us-ascii?Q?/CScuKd2sIVWPW+8UJQWMhDQqK7/SitbuAtZnSvqZu7z0GbhQTdizKkpaNwy?=
 =?us-ascii?Q?9Xr1Y/JCeMBzUonveOY/jXx8wpKq13U3rNDRiJ88dqjHwDyd+Jui57wjckzh?=
 =?us-ascii?Q?dg8Z/g0AJ3F97d5gtu0R6ZmSrWn0F7UUgQ1CtnjHKPX2TZNycuDzpoYZAL5g?=
 =?us-ascii?Q?hqbsrCSuTOFl+bQ5uPxpNBKlMKcHQGrwv4ke0OWqev0kjacOpb2Ld7hAFf+4?=
 =?us-ascii?Q?+ExSo8dV3aEAmGsKqgqbV+5IimZGNrkSD/8yIn5+j3jnCubv1oz/HhRIerNc?=
 =?us-ascii?Q?cF89SphEtYI1pVm+oOVq6+0ULnVRynoMNDe/ezR123qvNJdRkTHPejL5jgUf?=
 =?us-ascii?Q?CollftF/mUA3OPlcjoLNtAXDK6NLkJ8VD7yxD+teYkjsqw8un2gMoH+25y+w?=
 =?us-ascii?Q?5N3BbE7wu3ZtLvfQftyz1KFU5b6BMT0AL8UunRuoiDFRjlW05/GSlUks/hVp?=
 =?us-ascii?Q?rDXrOMOp36HMATqWcoD/AdgGoH6bhuLsfManbA0sIXCPgUMrz9Tlp3woPH9O?=
 =?us-ascii?Q?BGm4zKMw/z/arvH/4Mp7AXNPc/MAWWJtMDzPvojUi+IZLEgEmf93uIcs7YhN?=
 =?us-ascii?Q?6s4Ls69Zd7qb7uSwXGWWowW3OtBoWUk4I5WYscVMTHrUlFcOrR8ssxwMdpL8?=
 =?us-ascii?Q?fgJufRR0t6Dz+PPURnHvS+9do7mC+vV7pXWFsFDTGucmcFIrimNWnQ/G3fTc?=
 =?us-ascii?Q?633GGXWtY804YHt/uWUEoqaf8O/MRhnbkJiKwBVvTXtqRJdx6i+0OIupBNr7?=
 =?us-ascii?Q?hr5BcL/242x6nmlAgtXQ0o+qTgNBhcoeshBBVhuZx6i/nW6eqU4cdsFpQ7GF?=
 =?us-ascii?Q?xS3aO2lk5nzEX2B3mGSPfLhJSZZL6tP98T+Swyqb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d09ff0c5-f06b-4ae7-f4b1-08dc01457b69
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5214.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 10:21:51.6671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rTwYXRV9/0KG3G4JOZKFvBHXgxMUwxfHTGo/o876t8ygp8wbXYhB94FhJ1+NfE9b15FJVkSVQuG3ZTnib2ZDUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8213

This commit adds support for controlling the use of encryption and
setting the broadcast code. On the source side the user will be
prompted to choose if he wants to use the BIG mode 3 encryption,
and the Broadcast Code to be used (custom/default value). On the
sink side only the Broadcast Code option is displayed as the use
of encryption is set according to the BASE of the source.
---
 client/player.c | 75 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 59 insertions(+), 16 deletions(-)

diff --git a/client/player.c b/client/player.c
index 92fc91f92..7a5277fad 100644
--- a/client/player.c
+++ b/client/player.c
@@ -1966,6 +1966,11 @@ static void append_bcast_qos(DBusMessageIter *iter, struct endpoint_config *cfg)
 	g_dbus_dict_append_entry(iter, "Framing", DBUS_TYPE_BYTE,
 						&bcast_qos.bcast.framing);
 
+	bt_shell_printf("Encryption 0x%02x\n", bcast_qos.bcast.encryption);
+
+	g_dbus_dict_append_entry(iter, "Encryption", DBUS_TYPE_BYTE,
+						&bcast_qos.bcast.encryption);
+
 	bt_shell_printf("SyncFactor %u\n", bcast_qos.bcast.sync_factor);
 
 	g_dbus_dict_append_entry(iter, "SyncFactor", DBUS_TYPE_BYTE,
@@ -3110,6 +3115,34 @@ static void endpoint_config(const char *input, void *user_data)
 	endpoint_set_config(cfg);
 }
 
+static void set_broadcast_code(const char *input, void *user_data)
+{
+	struct endpoint_config *cfg = user_data;
+	char *endptr;
+
+	/* If input is no, set the encryption flag to 0.*/
+	if (!strcasecmp(input, "n") || !strcasecmp(input, "no"))
+		bcast_qos.bcast.encryption = 0;
+	else
+		bcast_qos.bcast.encryption = 1;
+
+	/* If input is auto, do nothing, default value will be used */
+	if (!(!strcasecmp(input, "a") || !strcasecmp(input, "auto"))) {
+		bcast_qos.bcast.bcode[0] = strtol(input, &endptr, 16);
+
+		for (uint8_t i = 1; i < 16; i++)
+			bcast_qos.bcast.bcode[i] = strtol(endptr, &endptr, 16);
+	}
+	bt_shell_printf("%ld\n", sizeof(bcast_qos.bcast.bcode));
+	iov_append(&cfg->ep->bcode, bcast_qos.bcast.bcode,
+		sizeof(bcast_qos.bcast.bcode));
+	/* Copy capabilities for broadcast*/
+	iov_append(&cfg->caps, base_lc3_16_2_1,
+		sizeof(base_lc3_16_2_1));
+
+	endpoint_set_config(cfg);
+}
+
 static struct endpoint *endpoint_new(const struct capabilities *cap);
 
 static void cmd_config_endpoint(int argc, char *argv[])
@@ -3119,7 +3152,7 @@ static void cmd_config_endpoint(int argc, char *argv[])
 	const struct capabilities *cap;
 	char *uuid;
 	uint8_t codec_id;
-	bool broadcast = false;
+	bool local_ep_not_provided = false;
 
 	cfg = new0(struct endpoint_config, 1);
 
@@ -3142,7 +3175,7 @@ static void cmd_config_endpoint(int argc, char *argv[])
 		codec_id = strtol(argv[3], NULL, 0);
 		cap = find_capabilities(uuid, codec_id);
 		if (cap) {
-			broadcast = true;
+			local_ep_not_provided = true;
 			cfg->ep = endpoint_new(cap);
 			cfg->ep->preset = find_presets_name(uuid, argv[3]);
 			if (!cfg->ep->preset)
@@ -3154,9 +3187,10 @@ static void cmd_config_endpoint(int argc, char *argv[])
 		}
 	}
 
-	if (((broadcast == false) && (argc > 3)) ||
-		((broadcast == true) && (argc > 4))) {
-		char *preset_name = (broadcast == false)?argv[3]:argv[4];
+	if (((local_ep_not_provided == false) && (argc > 3)) ||
+		((local_ep_not_provided == true) && (argc > 4))) {
+		char *preset_name = (local_ep_not_provided == false)
+							? argv[3]:argv[4];
 
 		preset = preset_find_name(cfg->ep->preset, preset_name);
 		if (!preset) {
@@ -3164,23 +3198,32 @@ static void cmd_config_endpoint(int argc, char *argv[])
 			goto fail;
 		}
 
+		/* Set QoS parameters */
+		cfg->qos = &preset->qos;
+
 		if (cfg->ep->broadcast) {
-			iov_append(&cfg->ep->bcode, bcast_qos.bcast.bcode,
-				sizeof(bcast_qos.bcast.bcode));
-			/* Copy capabilities for broadcast*/
-			iov_append(&cfg->caps, base_lc3_16_2_1,
-				sizeof(base_lc3_16_2_1));
+			/* If the endpoint is configured to be a broadcast
+			 * sink or source allow the user to set a custom
+			 * broadcast code or use the default one. Selecting
+			 * 'no' will result in the broadcast not using any
+			 * encryption.
+			 */
+			if (!strcmp(cfg->ep->uuid, BAA_SERVICE_UUID) ||
+				!strcmp(cfg->ep->uuid, BCAA_SERVICE_UUID)) {
+				bt_shell_prompt_input(cfg->ep->path,
+						"Enter the broadcast code (value/auto/no):",
+						set_broadcast_code, cfg);
+				return;
+			}
+
 		} else {
 			/* Copy capabilities */
 			iov_append(&cfg->caps, preset->data.iov_base,
 							preset->data.iov_len);
-		}
 
-		/* Set QoS parameters */
-		cfg->qos = &preset->qos;
-
-		endpoint_set_config(cfg);
-		return;
+			endpoint_set_config(cfg);
+			return;
+		}
 	}
 
 	bt_shell_prompt_input(cfg->ep->path, "Enter configuration:",
-- 
2.39.2

