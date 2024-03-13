Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2071.outbound.protection.outlook.com [40.107.6.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522EA196186
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349391; cv=fail; b=hp6aZc/lFUOzRaueyUG+NMbC3MhQd+DHEN0HmQCJN4qMIqWahBFK0k9wAQX40xE9AfZalMcKW8SVHkgeUC82vMPtp68KCLgM9vPOG2M1L2VUIk8NwG4vQKJYFQp9MV8gs/REQ+j0eHEg6zjJRI8Y73vsOqAT16o0ELfhW97rpTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349391; c=relaxed/simple;
	bh=CAgBBnmXPEzJEuI8p3aCGv1yElbjI9xtc0yMh3Dveho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dksSUW8PhsY2aJBhgjHwX7tRjv5KdiFyMbDyed9C+3In4yPYh9VTXQdM8z0wprz9xDQ26eepWUjTquT63h70iaBiWE4xbwgt8tkqZL0Bk5mR7iz29OymIdtd3nF8GKmOA/WTYWfI3P1ZOonH+GIlyOLemLtqbuflF9frEZIlKvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HQy0wHiq; arc=fail smtp.client-ip=40.107.6.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HQy0wHiq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjooD5nLdJEk8vWAtr3VAL8swfIqdzXLiI8paHwDcD7APQJVCCCYJduh02JOFio0qpWju0mmnvhhKVV1TIlbTw1+Sg2ZVxkmePwIvotRS+pozTGyD/ORet5MMwxGKoizDTnQqaaJ6s/EWdGmOnvP/90X16hw5hd7f4vuqFfBBnjA647kbr2BQN85WUMw1HdBGqOAUtmEhJPCGeeM8X+YdwvujTnQqYNfUhV1zeX8+mcqS27qjx8YfBZnOtYM0ElNGDnMRTyFSZdkGgLhmIOk4s68cWvwomx4rHPcjAU3aRKtK5Ak1PepCaC+v3Or4t26s0fbCuxhddQ333SD+bBLsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAuRi3p/BbhKn0Luyg68a4MHTKM8XOkZYy1hlQg2JNs=;
 b=k6L9Ht5pnJbGdRZmMLl4Yn+1NU7GxCF2elAERH+5or3qeEVR5FV/erDF9fY7dKQ8AnrDmrja2/x+eUc+gOOlz+99om+ak8C1wmY/DqxC5uA0oRvYRjB7GOut1Yx/9hdSjGgXjcevb01w4Bnt6QbCycjBLbbITZHs8rbl1QrBL6zt9R8jhuXOCbrD/Xt7a/E/KoCgeVgAMlgHltxuHGhKpi1rXdONIu+FmpIidwNjfuKkuJ7XH5h5SFyzbwdVB57+1+Xd+I7DE+XHemOdDF0JoCbcMcX8QTA2b5dQQE7/ucZxBu86/86I0dJLMt2VgtrszMGfvDI80a3RsDuF4XuDAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAuRi3p/BbhKn0Luyg68a4MHTKM8XOkZYy1hlQg2JNs=;
 b=HQy0wHiqQatgtS3RCs3YnyA4avFHFa39fKJdbLABoFHr9u4gxp2c9fYpc/ywB/Cz7ZCOj8HlbH5rex+KzUoLPaoTglH/o+11DaSWrox8dPRUy0ATbxzNlLRp7+E1KM3HiXO1iD+OPc33sckAIy+gHvmPJAqWtVvsXDEI3+OAI4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by PA4PR04MB7517.eurprd04.prod.outlook.com (2603:10a6:102:e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Wed, 13 Mar
 2024 17:03:07 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf%5]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 17:03:06 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v2 1/3] player: Add reconfiguration prompt for broadcast source
Date: Wed, 13 Mar 2024 19:02:58 +0200
Message-Id: <20240313170300.40974-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240313170300.40974-1-silviu.barbulescu@nxp.com>
References: <20240313170300.40974-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0018.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::11) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|PA4PR04MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: e86cc4c7-a5da-4c46-4c8e-08dc437f7411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zeWgi+uJwnqDeWY8JexL9RRP/oxT3xBcIakVdHvLWITEFPeluUxkNDuOJuqC+89mpuJuqEU3OAdC5l4OM2KYj5JbkIY/Sp1omjzDNBnhX9BCW6wCx+JkS6P1L7NZbze7QlzlSRbF8Wx0p+f2znBTVLpB+bBcKyMHeVKuKeaiOUiSZyCscpjna6w0t4RZh719QRFN+1pa6L4PHnvERDdXXSEVsfDP3v/3PDPpBW4zTm/LjjrXr57pMyQ0/NvqVY0ihoal7RB1aXDMOtfQudf9gZy5AFWI6qv1kY2D4dkP86iJUHOgz5vzH6q6pU47lau+PWWEcGsDYq7tT38qBPtWohHjOPzW2B3Hi/sNl/SjjluMBnwZlKfF2V+248RHjRKBXpm5cbd128ABh1PKqjlSd+4onsQGr+qviMC3J7KZghr3ANM1N/k06OJIeAjlvER6Zo1DvozupIWIbNmgHFutg2tNKHwM7GZNHZmnlbGSdebw3NITuxkoA5BgFURCgmuq90jk5QKALkVJoWcHqblp+KBJnr0IF0efnHGTztGb9zEkJ/DpljPpMdsNKGl01NjPuxeMJ76woZ1yIpKSU4wpuGUnZbrBiMLLHcwDADsoHmEW3d7fydRMVQXkdRMjExRLmWOSFakZ+eB9W95ZNgqSwjwRUDBVajEcgMEAiyWlzsU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aBBX4amjDclug5Tuoew+Iifz2tqgafEJjta96ipAHTbj+H1WjsI90KPpy5Gd?=
 =?us-ascii?Q?P0S0tFCRPWccISsVTBnrK8+DY/FOZ/YM2qrxEAgYQXtR02q5Q3o74t4IuS+r?=
 =?us-ascii?Q?lZNJS1O5BP6O6EwoDyaz9rZ+AohZMNMaCna81zfD4Ly0/ECTwFsA5mKpUG/u?=
 =?us-ascii?Q?1rg5AlWLPSqFLZB+IgGqzggrjYvJrkFpyLRw+VNyOs8r5vNLfxrF3ZtUhgLu?=
 =?us-ascii?Q?CdWKj4LeEKow5hPhi8NgBV6mRGWJR1X1ECxoqOEmmFIZZYHsC2ois18pV3rx?=
 =?us-ascii?Q?z4P917VviqJJH6YssygXicECi235uD08mm1ZkNA3xLndw912SYJkHIv3gIGi?=
 =?us-ascii?Q?SDimVn0RoyRpTHfxwefMWrIpZ6IuHYnigoF9xi1BKardSRZjS0D6s7r/aS8j?=
 =?us-ascii?Q?Eg1qMnM19/ExhueMvBl5GriwSTW8gGrkcvKxg871HVvyTX8v3UKOh8a9fibm?=
 =?us-ascii?Q?00UUtt9i7uNJGjd8vaQaZaNM94CC/0uXqmsomzGtzdGBI04slo+Jj4m/lrJB?=
 =?us-ascii?Q?D1B2GuknT91GdtQKCceriyGvx6en+5ni3nPI0u0xOw4SPPtnzfaCIWtaqW+M?=
 =?us-ascii?Q?VDzZMXzqKK34jR0zSusBLrBDoUwdbcClKPhBABi9FXAMTfZIwXIDR5M+Oa5p?=
 =?us-ascii?Q?zc/fvw1BxaOtohBRrhUi2PcqQxelzwJP1UQ8TZczCkws8ptCnjzCHsv4uAhX?=
 =?us-ascii?Q?89SdptTjRNKxySVNpd6js0G+Azl1I2jVQ8XVKPPMORFz2+Y+AVG1evqI2rCn?=
 =?us-ascii?Q?5CAYdXUT0BzsV9cvr6d4wQwb+2irXrD/AGFdus5sylVgCod27i/04SLmZns7?=
 =?us-ascii?Q?2GHrBntQSP1F75VA7URzJFA6/S04/tCtwlHl+Bk+N2tNpSKj4FIlXcXfjhXi?=
 =?us-ascii?Q?lB70rIAoxAt0eaW8dhsMKQo32EupS/70vJFoVd6+r5MBKydOBHWfLDR0gP/8?=
 =?us-ascii?Q?hcGM5PIno61MdTcqo34zGnmAnzN4p64SJdO8B9K5CwJUfxSftrsv+v8w91Q1?=
 =?us-ascii?Q?dZ5xg+GaeJOGtks7NQkoMQnrCU3YNi6SEIY8rjViOdOxpeCzIP6sJvxAoVVM?=
 =?us-ascii?Q?jHD+mO6Agp0oTHUS7SpsVok3gOEE739/HHT0wP6ZkrtDGlwMkiHbLJzYJF/T?=
 =?us-ascii?Q?5aLGjjIPkZyBSO5cVXnXjb9K27/0Mr91vYNlOFCSxJjN7qI4OtpG4SJ0Q3Lz?=
 =?us-ascii?Q?hl2wqEsTZasO3ad2PP07m5EdQHii4vLZmFpX5WQnQUnVDqi5aj/U9RDZ5tO6?=
 =?us-ascii?Q?4g7dWnu81ZxXiEgg0vsTDRZDTi8ORBkzq2dfccS1sFORginSpf7C4jD30n5t?=
 =?us-ascii?Q?y82Z5MRYeruk6UBCCfcd2OjcN5PEZZeHOGA+sDt4hgX+lHmD6f8C0a1ivD4u?=
 =?us-ascii?Q?Xkfa0uJvkSF2H0Q1vMeR3NfMJX+Pu63WYKxmfNVz19CrN0cx6Hf+ChP+rPzW?=
 =?us-ascii?Q?/lf0smVW++Hah+jGmD7gtgIgZU0XM5CJsmun4IBwt27Ch/vAJOtcjtBoZvtZ?=
 =?us-ascii?Q?66IdrJgXK5BIfOxE5aSHWcgZEGs6GrPhSf2rkaMX/ECDhsaI679o9wJBNklE?=
 =?us-ascii?Q?u++nkPPYDnL16qwf7aWnPdLEzwDglFE3cF1vLzeDyaffPBRfp1WZjTypq/4f?=
 =?us-ascii?Q?FA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e86cc4c7-a5da-4c46-4c8e-08dc437f7411
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 17:03:06.8750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zkLbHC4numTsGnVDCIPaYM3ryYAyQVYR8uOHHoBSNGx/LwBeuyJVWFzkD8rtNUYYJEZX4hpnmcf4flaiAD1UFFqfjxkLMPGVt4S8hMHAtww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7517

endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 48_4_1
[/local/endpoint/ep0] BIS Index for reconfiguration? (value(1-31)/no): n
[/local/endpoint/ep0] BIG (auto/value): 0
[/local/endpoint/ep0] Enter channel location (value/no): 1
[/local/endpoint/ep0] Enter Metadata (value/no): n
---
 client/player.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/client/player.c b/client/player.c
index a40bf66e3..688ad02ab 100644
--- a/client/player.c
+++ b/client/player.c
@@ -3809,6 +3809,35 @@ static void config_endpoint_iso_group(const char *input, void *user_data)
 	}
 }
 
+static void endpoint_is_reconfigure_cfg(const char *input, void *user_data)
+{
+	struct endpoint_config *cfg = user_data;
+	int value;
+	char *endptr = NULL;
+
+	if (!strcasecmp(input, "n") || !strcasecmp(input, "no")) {
+		cfg->ep->iso_stream = BT_ISO_QOS_STREAM_UNSET;
+		goto done;
+	} else {
+		value = strtol(input, &endptr, 0);
+
+		if (!endptr || *endptr != '\0' || value > UINT8_MAX) {
+			bt_shell_printf("Invalid argument: %s\n", input);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+
+		if (value == 0x0)
+			cfg->ep->iso_stream = BT_ISO_QOS_STREAM_UNSET;
+		else
+			cfg->ep->iso_stream = value;
+	}
+
+done:
+	bt_shell_prompt_input(cfg->ep->path,
+		"BIG (auto/value):",
+		config_endpoint_iso_group, cfg);
+}
+
 static void endpoint_set_config_bcast(struct endpoint_config *cfg)
 {
 	cfg->ep->bcode = g_new0(struct iovec, 1);
@@ -3835,8 +3864,8 @@ static void endpoint_set_config_bcast(struct endpoint_config *cfg)
 	}
 
 	bt_shell_prompt_input(cfg->ep->path,
-		"BIG (auto/value):",
-		config_endpoint_iso_group, cfg);
+		"BIS Index for reconfiguration? (value(1-31)/no):",
+		endpoint_is_reconfigure_cfg, cfg);
 }
 
 static void cmd_config_endpoint(int argc, char *argv[])
-- 
2.39.2

