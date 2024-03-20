Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2084.outbound.protection.outlook.com [40.107.13.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C01481A6
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710945766; cv=fail; b=Q84Yu6uZr+r1huCrnd+4NfrJXbt0NncboE1OFvUlNhRrLR7Mxxs2IrUJ7R+93piC9lvJq2prRYH/gQfi6R6gxREYj3UfUlCYTVwVeOq+TgZX20CagI8qjsUUHR4fU+G4Hx+iO74WoDSBvfpDjteFQX5578fgJs4XJcYnvq73rJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710945766; c=relaxed/simple;
	bh=ig7zUv0/RG4x5AvLsqYkjwcSygU9Jxgx24RxTBUUT2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UrDWai49ShrQhSD6ih1EU25VkQWZdrydoeoYLbXR67KXRlOqcoo2NQU3O/WBIX7X8r/tZZlgpdVO/mAndfBDO+3g6TFMbBYos5B7GN/iW1JtRSywLzcinRS3sQxxWoCbWcG1qV4nHqRoY0M3eISsc4/K2IVohOGrKDIoD+Z3/Do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TIHbLTVr; arc=fail smtp.client-ip=40.107.13.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TIHbLTVr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2t3GyJqj+IDghlYzzaSa6G92Q0FkcNAoF8rzuxNf3DHQboLEpV9WuIbiI6H0SQhwiDNub91pDP1fbTsZnAKOm0l+GshamKb2wzcyY5FWZvcaLCsk+ZsrqgwuTen6QSf7JUboQ3Wa3TnpAtAsxlv8rAVJIkyA0MYfTfyAMNqIp8QCufXKYfWS36Kq0YyKor6Hsl1QmQS9rgig6emVGoHA8GI/kNQ9I1OIY47Y1Wl531rLPRZVSH+UTS9ITC3nmhui4ZS0V68ajGbe0XEq3ZzgYYswmBIyCU4kUWIJ8KLkQ064JoVJV05ooG8Je3i47MXvxcxp2ERBJ8iaMGvfGzOyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvL1N8TfC0FdQQ7dm1THQHUouWdD/UKkYi8/uhTYU5Q=;
 b=oSPD3fvDWk4ZcCCi2rKWVyv2z1yKjlggqTwzvUwfr8dp3Az9c3CXJyaTkASrMoYaXYCAtYg72rarzy7hEucII0s3BkKkPnAy6ZGi0nqyIi7L810OtW4Fpw1XY/QqhOV+JoZGSW+RwJ7RpjNSQgkPuLvTW4kW1yKOScJt2NSBskwgHmxsM9EQX+r5vuktahR90wWWoU5jjvAiUJ1Af7lYMoQflyrqhqaI9yaAzN64bNBG/VaBtZkzpZXDnjE/UakA6Zx66u8o6BPoIUDs+Yzqx+VwxBnRsYDpjLem5Y0+tijatRC7Dr1OJNbzYOl1WT8WlRBLBJj3mmzQHgRU8weOug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvL1N8TfC0FdQQ7dm1THQHUouWdD/UKkYi8/uhTYU5Q=;
 b=TIHbLTVrgP6kK+bZEI2lJRxbdWXSYUVanxtnOEf2P9efpWFoGGh8yEc6RAHes9vExRkqNimJHUQ9RqHCC+6t6t+Bgetmcl5WagypfzU4l4MCcETjUfHPCMMGnE8bKULh0mzkF1LXQ2KiBnbahwRx8BrwWFp85a9EiG5Jzd4kG6s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by PAXPR04MB8797.eurprd04.prod.outlook.com (2603:10a6:102:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Wed, 20 Mar
 2024 14:42:40 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf%5]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 14:42:40 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ 2/2] player: Allow endpoint config without local endpoint argument
Date: Wed, 20 Mar 2024 16:41:53 +0200
Message-Id: <20240320144153.46408-3-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240320144153.46408-1-silviu.barbulescu@nxp.com>
References: <20240320144153.46408-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0022.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::14) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|PAXPR04MB8797:EE_
X-MS-Office365-Filtering-Correlation-Id: 559e1ab2-cb9d-447f-2c3f-08dc48ebfe86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xDMwTTA0pq1J/w1WVd4WAUn2wY5CwltNLXn3sW8/9qKvxiE6BZA0r9OSnCwbOM07LvZDNxBsXj2TV/vrUu0V0tA72kzNX96PEeShH1E1BGm5ZxgxvlLii1pequV2/SANqzpQCU9s61Qfvny8Y02qJ9/sqoKdtbgjXvsjBzjjr8g8N1um7R/3qj8pb95Q6RVgVmuyWR6XuB0LtU/CAONgAGDOlY3vgGf0k7XK9XyMpnLs0J9l4TCSwTncahp+RMT8n2f9oz4X6KXAVqhtcOUc6a6O9Lt/dHTVvI9/6nDFl1JaF+WngNIH3Aam/W3Hss778E63WP+WEeNFXiJkFg1WBgfC/F9gXMV5ZAO+UMj1GltKqV04KMDB23VyvW96mxwJw3RbrAbfZ6haJb18CkvV8kZiBMQBVR6mtV7pOELMitz5QhjQoyYpqYOsNBY9T8ogisFyQejVnzIu5tlndpMJ90p1Wb/CP+4LV0jiUdeoU/LImUkF9KKKqlQkSoKVo+Qsl84XvxZH0yGV2a4OzyHSp82lmkOeAmU3xX/bdCPyh8OWjd24JiFK0HftL+wNvI3+QASCndNqZGt5Y6WxaYmyqbw7qJ+B9k4b+qBJkzKwnKAxw8cnp7yL651wjTvjgdjymy4sH/6i0HHY4L7r/jczBbxONc4puzO9MescNJaJpeg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w3trSEcNgA4KiBGwLBTJEz1W+ME2smOOb0azwbHOoQYAU0MdCe2+c030IqGu?=
 =?us-ascii?Q?f43PoZJrPQoPniuysZtpIXWFUmrhLKkI1UoZRHIuD0B8J/s350dbHDR5TH1o?=
 =?us-ascii?Q?nYGWDpe6QVp6BxIqCFimzqnVXi18XuvFUAkHsuCXsmVf1R/wtFL54M4pMla8?=
 =?us-ascii?Q?2rmxTIV+ji16wmwW37QvKrGcOqRhcfTJCWIqOHJGbY+gDYOsNmsWscFPhWf4?=
 =?us-ascii?Q?EDJdOZYly3TWuVMe8lEVXn4z1LH4Zk39XZZcr9lExfn+8Vx6iBDuNwrt8kKf?=
 =?us-ascii?Q?zNr4eN/C22Sw31PTgyiw/PElY7k4x63J4wPS7rDcVx1XSHriJRClgZ6kK08z?=
 =?us-ascii?Q?c7GOdAW8X/WkM/gXRx9soSPWwAe4+X42qOFq6LvG0idfdkb+s03PNbIEYffX?=
 =?us-ascii?Q?s2y2Bu2fyNLJF2jro7LDEtki17dRdvmVo88DRN/L1SYMIwzD3Zo1tIISUVmq?=
 =?us-ascii?Q?FDSPENKFQqV5QGNIqwBfeR/ckDagmQPBIwKslmHqlJj64lOZiAAKMb+zTueX?=
 =?us-ascii?Q?ZVtZRuwTZzmdz+PoY5407bUQJ0lujTXn3uI9bYI8vpXCDs3gWyU48pBqwGzF?=
 =?us-ascii?Q?se7m2Pt1jZz2nPWeCzBKpqgIbUIvf/XGWWf8lP/TxASg9eApF7c1GnXvqGx4?=
 =?us-ascii?Q?UksJa0JOEhfEuVhP8/dwMsSEa4EO5LAUTaJ8FSXcLnySdefKTu4Xjk17w88g?=
 =?us-ascii?Q?KWSl7jatHxs0ksOn3g+WbP+ikx8fwyrDzmOXgZEF9Uhlyd90Omvc+L5NOrGu?=
 =?us-ascii?Q?i+Qmq9lqL/WsRIs0BrDBo9ixB3uDJOKeZ9I4N5XLKCVR91slux8FX41vI/VH?=
 =?us-ascii?Q?BHO2rAouH1f3oH0UrVPIDmlBQriwpvuoxzRTDsjuy1CBHY+KPLkooYmM9dXM?=
 =?us-ascii?Q?822th2gIA5VM26OGAJjZKpIiZ6wR7fqHUUHKz7NoBWEzxEjOCaDG+tjuXN1/?=
 =?us-ascii?Q?lHrOsxXeKjXKjBYJ3j5XvY33FlewPj3VhV4pLLLDggvIGIEjrgtfasc39yQd?=
 =?us-ascii?Q?DX43Am/mQo4sua9giqEleKQ8bIzaADbj+ZIW63GS3G5IqPsSAqL7I/wic8Wi?=
 =?us-ascii?Q?0UzzRyNf2KSisB6Bje++LiaVE4twZhz2L57bEZYXW4uOkjpriJer9fG717Nx?=
 =?us-ascii?Q?DIdf8cN7bI3j+yjqoADsWbjAWAcPvQEKlMjNSsrXQp6+21Gq9/AiGdmXcsk+?=
 =?us-ascii?Q?NB5bP+Am4vbt5yjMCf8TOdRXoenNUwzB0BqCuGCx6YgDYxVwa5fbD9CfCxHq?=
 =?us-ascii?Q?ucw5DWJ9c3gDryS7lrtfueV9F3mJImNIisXl7NwwFkxEtHh7LtZ6a3c9QAnE?=
 =?us-ascii?Q?fbh5Lu+/1X7cfhl6v5Ee3vVUAOZfYOqFEVHTz8B1GnMUObLKNITGTO1ykhA/?=
 =?us-ascii?Q?z5zH863c3ORxM4IvsPyfBLQDOMyEeqOt8PONi3QBzCrrMLOnH7fMhW2VvV7R?=
 =?us-ascii?Q?mPfb36Zz+NlS0YxVoO4VUnbYiy72YLgDPn2YpNalKibcsflpDq2O4wQrLC5U?=
 =?us-ascii?Q?eTjXKoxlLrD4bDPx8MPHos5RcvN/N0mRbfmPZ0a4RGnDmAZuyFnqnCbDuIrw?=
 =?us-ascii?Q?O8s4+wtEL079oc9eJmFO89mGCycJ/Fz3AflYpp5iDK9NbsgA0YbiqtEVUu6W?=
 =?us-ascii?Q?gg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 559e1ab2-cb9d-447f-2c3f-08dc48ebfe86
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 14:42:40.6024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ufts/71W9wTqjhPda8upJvP/YzZl51fESi9I5qSSHfB5MPOyql+1ZT5OcJauKnOBBWdx6ABWD2pKJxe1tGeB5U+pKdtWUJoWV6wKbInYdWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8797

Update endpoint config command to create local endpoint for broadcast
 endpoint, this will be used to configure a broadcast source\sink if
 register endpoint is done from another application like PipeWire
---
 client/player.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 3 deletions(-)

diff --git a/client/player.c b/client/player.c
index ab33bfc46..b02a40423 100644
--- a/client/player.c
+++ b/client/player.c
@@ -3662,10 +3662,15 @@ static void endpoint_set_config_bcast(struct endpoint_config *cfg)
 		config_endpoint_iso_group, cfg);
 }
 
+static void endpoint_init_defaults(struct endpoint *ep);
 static void cmd_config_endpoint(int argc, char *argv[])
 {
+	DBusMessageIter iter;
 	struct endpoint_config *cfg;
-	const struct codec_preset *preset;
+	const struct codec_preset *preset = NULL;
+	const struct capabilities *cap;
+	uint8_t codec;
+	const char *uuid;
 
 	cfg = new0(struct endpoint_config, 1);
 
@@ -3680,8 +3685,75 @@ static void cmd_config_endpoint(int argc, char *argv[])
 	/* Search for the local endpoint */
 	cfg->ep = endpoint_find(argv[2]);
 	if (!cfg->ep) {
-		bt_shell_printf("Local Endpoint %s not found\n", argv[2]);
-		goto fail;
+		/* If argc != 3 then argv[2] should be the
+		 * local endpoint. Return error.
+		 */
+		if (argc != 3) {
+			bt_shell_printf("Local Endpoint %s not found\n",
+					argv[2]);
+			goto fail;
+		}
+
+		/* If local endpoint is not found verify if this is a
+		 * broadcast remote endpoint because this can be an
+		 * endpoint config command with remote endpoint and
+		 * preset. In this case we have to create its own
+		 * local endpoint.
+		 */
+		if (!g_dbus_proxy_get_property(cfg->proxy, "UUID", &iter))
+			return;
+		dbus_message_iter_get_basic(&iter, &uuid);
+
+		/* The local endpoint must have the UUID of local pac but
+		 * the remote endpoint has the UUID of the remote pac, so
+		 * based on this information we determine the UUID for the
+		 * local endpoint.
+		 */
+		if (!strcmp(uuid, BAA_SERVICE_UUID))
+			uuid = BCAA_SERVICE_UUID;
+		else if (!strcmp(uuid, BCAA_SERVICE_UUID))
+			uuid = BAA_SERVICE_UUID;
+		else {
+			/* This should be a local endpoint because is not
+			 * a broadcast endpoint.
+			 */
+			bt_shell_printf("Local Endpoint %s not found\n",
+					argv[2]);
+			goto fail;
+		}
+
+		if (!g_dbus_proxy_get_property(cfg->proxy, "Codec", &iter))
+			return;
+
+		dbus_message_iter_get_basic(&iter, &codec);
+
+		/* Verify if the local endpoint already exists */
+		cfg->ep = endpoint_find(uuid);
+		if ((!cfg->ep) || (cfg->ep->codec != codec)) {
+			/* Get capabilities to create the local endpoint */
+			cap = find_capabilities(uuid, codec);
+			if (!cap) {
+				bt_shell_printf(
+					"Capabilities not found for UUID %s, codec id %d",
+					uuid, codec);
+				goto fail;
+			}
+
+			cfg->ep = endpoint_new(cap);
+			endpoint_init_defaults(cfg->ep);
+		}
+
+		/* Verify if argv[2] parameter is a valid preset */
+		preset = preset_find_name(cfg->ep->preset, argv[2]);
+		if (!preset) {
+			bt_shell_printf("Preset %s not found\n",
+				argv[2]);
+			/* Free created endpoint */
+			local_endpoints = g_list_remove(local_endpoints,
+						cfg->ep);
+			endpoint_free(cfg->ep);
+			goto fail;
+		}
 	}
 
 	if (argc > 3) {
@@ -3690,7 +3762,9 @@ static void cmd_config_endpoint(int argc, char *argv[])
 			bt_shell_printf("Preset %s not found\n", argv[3]);
 			goto fail;
 		}
+	}
 
+	if (preset) {
 		cfg->caps = g_new0(struct iovec, 1);
 		/* Copy capabilities */
 		util_iov_append(cfg->caps, preset->data.iov_base,
-- 
2.39.2

