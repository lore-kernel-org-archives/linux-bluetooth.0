Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5141B53394
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Mar 2024 16:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710779944; cv=fail; b=RRM2/0BTfBV3Zb/QU7iiWuDMpgEulr/VWwAqk80DUh68IedR58KOgSSgYrW3CthHxH+FLnp3P3eWBFuYV4oyqFJ7ovtLbkLDO0biZzgCmLBJ8FW7pn1QSk1J8zjFbB5l31puAvSIb0n2DiLD1INNF53c1oD4Ox9/SkPUEa1lDjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710779944; c=relaxed/simple;
	bh=lLYao8EhHygo93Y+pfjgKI2W4lsWFp+LH1W+vvJMptw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MRgYT96O5IO+mFmTfniQazeWg9q6LFhrTy6JadZf0f8PMPgmgCDgBxwaHl0MqRN9vydPXuwlBDiWBRBC6GfktgoO5pNt8+gsN5z/oMPyygs+s+J5/6ftDfvntGSzUJJKtD4C9jUIw7IwkQyURLHyPxbKcrmmcNcIqxVyoie8XTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=LL+MYI91; arc=fail smtp.client-ip=40.107.21.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LL+MYI91"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0/AHmb7UfHMfct249ymb+2sgYCFka9/8t/s38vGgZoIFSdipixuQpHRZfSigNmnT2UxyS2iwen+tzFYJ5CXHD6htyqswrYf0B+EZSI4o2Sfrv9BPpKGyDofvy6A1ADL77BQqXP0Ea6djLdFYgP1qtrsnphxqwaaTrIHoAH4XUkmdvgHudqWmOS1V4Z39X7EX6YJSbeqBoYvcl3gkCss6hZpo/pCpTv4pDEK8rRvTxrDDoYYJ/8bTFhNZymSv2G1JpgEma/UofD8ELBd+a2Mbm1TmQ7n+MdQF8jw0MA/qydOZb40LKGNtIvXKZK5xYuaAzccW7cyMHkIoQI8WBPhEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rM5keipGQnbBG3oK5I64dIHOyzMagPPf5y3nGqaSExM=;
 b=fJIH3fncYetOhXNCnyYb7cDoVK0AJw/hk6Q1K7mm3TeLxHyVF+4qO8YrfCYFL65WtqWHAa/7VuuHq8RqxFMbiNrqzElbcwU10RFz58+JaAwVZqvw1+ZdIDSCs3rf3IR/hmkXjF2gOdIc7oPauTgJtsdk9rqcDfPyH7dopX219YVv5Wwx6XQ0TOkeebj5qQNPUAFLAaZIRST6lb/E55Hk8mMRYMMMMNs9jLLgDHaWbeHtP1yKA2GxqNdgl/tGsumT95STKvSwpO0QFMTuHSGlw2sLwI7pwamqK0dULBBj17DHzeZj8CIz5XHJFlNK1s+W8x50sp710Y6sw+YzW387GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rM5keipGQnbBG3oK5I64dIHOyzMagPPf5y3nGqaSExM=;
 b=LL+MYI913c5nzh6Ve9lHkZaVGSQaM/TQ0v1l1GaTVPx4sDN3Dcg+Ck6tF+Kuah1Ef7g1R35aTYkWSBWwFwyf19yHQLOUiCT0wI1LR8cEMowISJYG9/a8qSe457nDOXn2+sNVdjROIDqqvBJj2q4wb05jy61oNHFOVEXjukhAApM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by DU2PR04MB9132.eurprd04.prod.outlook.com (2603:10a6:10:2f7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 16:38:59 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf%5]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 16:38:59 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v4 1/5] player: Add reconfiguration prompt for broadcast source
Date: Mon, 18 Mar 2024 18:38:49 +0200
Message-Id: <20240318163853.68598-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240318163853.68598-1-silviu.barbulescu@nxp.com>
References: <20240318163853.68598-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0020.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::25) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|DU2PR04MB9132:EE_
X-MS-Office365-Filtering-Correlation-Id: 117361d7-7f00-41e0-5ddd-08dc4769e937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o8fNZAkkh3nqKrFnth5+WIHcQu8/AzS1xX4xZ3i/v87ILwlP9EeH272pvwuMZfxXCijsuoIdeAPHVr8/Lyd3CZXcmnzOOsJpdXtTzgCXuvMSGnLl3v4zk4Ekw5gpHiUcsliwybzY+uD5CVpt74nkCqdu7JBy3ycUNdEM/Q86O33tlXC0fx37K5ddoQr0ElYyLeaCcsshv0zSFe0xHrPzTI5/kz8hLbABlxK4q7uZ2CWcTc7p//1YZLNA5ntJucSy35G/twmykfBW5Sl131Id4vGc9qd5HZg/lmkFvQCuTTij09aBKwPoOeNYYX1VY/rXP8/0xF/yZEW9oyIiaRC6gKxGuNKe+lJvvRFCBLKnNg05ZYHC8SFAIg5YQXvFH3DrlbYCtY0rr9beU1BkiXzbf/X30ZAfrVEbYtOehF9SqdO289C56rwSxIDdqNqa4o5UlNTbAHjn8yTK/5tL5sMz35qVTj3FeKj/xE7umiAkD+cpTZgQS5vHzqH+xedp8hE6akfGiv6ZRazRw8WlubKqzTtwTaiS3hgC+4R95ZuAR6DXUStySfEVvrQS0qvBuaYkErlLSzRz+jdkG4R/OGsHpPGFqnE28vxMzi+WFP3nLdVhnoZRvLuVwUAxINJa9oSEDupI02BEIlcxhRr9N3TBpa4+Y7IrYxt5/IfAH4kKuG8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dtCwqiBg4t89nePCZYLR6NKQGB7i7TkhVjONpt1ZWIASFS0d7Ss7sQEien5W?=
 =?us-ascii?Q?fYagSqKNmE1sUqTkEE+Zz0x5mM7d/s9tXtLRk9NnspeHZxZw27CNEuDMVbt2?=
 =?us-ascii?Q?FDrmlMYtIJE5Pk5icKg4rFeR9HiVzJTFZ+RYrtDyYnG9oKu1yIzEodS4871a?=
 =?us-ascii?Q?Ujh4CTXkEQ0Qagxi/S45V6S7qQGCdx/n14sYCP8bQ1De5yUo0vstwjVRDTHW?=
 =?us-ascii?Q?U5F7Sr8wDreFmV+1FWAahy3jVXi+gbv3xTqOrfygG1EMaMQ9H+oRGVcUeZfN?=
 =?us-ascii?Q?ZZCJp1q+E81Y7qDfGDtISGwa1BVxV2R58GAtgAVYx53r/7rF+VBWihIBwLoz?=
 =?us-ascii?Q?64a3rW8WHHEeVkr3aOSqg9NK4oahIN7YmPgHCtnBjB2zFauXlqgZbrumT871?=
 =?us-ascii?Q?eNlnF5jTf+7seXlr/tEbQgjkHx4MaBOeBx+OW0yxdadMM6sstH20+WH9ITwX?=
 =?us-ascii?Q?3kyFR34ajG1uPNYo95fNryRLvIAgwAk4F9eSlboNei2dyXS3Ir63R5H2pgP0?=
 =?us-ascii?Q?LO7xWPEIboASWlmFPPlrimOLM7oi1Wr4FKUKnqbISCf4be+udTzRq/0fws7R?=
 =?us-ascii?Q?P4I/IjylA0S+WVlTALeLPZ9lroz/TkAIBR4c6nGMSdx9P26eaLoYgAi/VsQk?=
 =?us-ascii?Q?2p/k18AT07fhM/DTbAOaEsZWjljWOe0cI2GlMaEbdyloqN9uSai7jQMQcKcr?=
 =?us-ascii?Q?Xh+QbRixUmiyb2pPAh8WdnGIUiHrIcRoQ4xkK+JRcSlJeZEPHZceeLyjzZwi?=
 =?us-ascii?Q?R5gZFlVg0ckrt/0lVTbMeMaSDc3xGbA5NqfKOun2e4+5Idsb4N4Eyo6vPNFF?=
 =?us-ascii?Q?lc/UW5kPWili6Etleulp4rRASUuOTpx3T13ajwprSpghcmK1rOTgej+7trvQ?=
 =?us-ascii?Q?q/uAexzwxmz1jwfoXmLASvisJXl1VBO39SfpEP6QKPtMn94NHwL+UtL3Nox8?=
 =?us-ascii?Q?OrYdZ225k2y6H1a21cHo2t2iJJcAwTpUsrov/waCYqRAQMfKDYHJh0lyx3OA?=
 =?us-ascii?Q?ogq8KbxFkfJ0yNkD86QqXz0yn2VEvUG1LSbK3Jo7ChpIXfF5thLhiJ/gqkUs?=
 =?us-ascii?Q?n8Je35/uMEQwnN5OkLw4bD6WY6WmSlkvuOoTYZcnWwFCWS6oBotv07Rvn7W+?=
 =?us-ascii?Q?SFjmDK4qisSekaITcEYqrybVSDBauioBBj8R22Llohtwb+GlUNsINU0jpZaJ?=
 =?us-ascii?Q?3eqnSOaKOdEuhHIjnsgMSB8YFgcrqDaXIk6OgVksW2Knk5BRBhYuh3H1Ys5+?=
 =?us-ascii?Q?jTl6/RXCTZilsK48b2BKwSD/tSY3JGwkzyZfTVpkZyez5FccDfUy8L1ip/kF?=
 =?us-ascii?Q?xMclq0EbVjN2MYdbCWv+FJtqVbuj2j319gTC9xhtEd67T7//EJuSiYdHyS+I?=
 =?us-ascii?Q?FkdQXX18Pp2IBn6OVyY1RfwGZrXJWW3Vt95BYG9hmqflgW767bljDMW4MpOD?=
 =?us-ascii?Q?cjpvqvPINxtsiNTzrAS+D4cwc5cSAcMA28rYn4JDzjpnYG7H712j2+YsH2AS?=
 =?us-ascii?Q?PyG2TLe1Z+jSL5ho4mi+qXvuWjPW8oW2Bo8X+CZsrOvKY/+WRsG6vFAckTxt?=
 =?us-ascii?Q?b0JwrwT7OSY37osno4KVu5WGOBn2rcCDroisbo/qH27p/HybWcdnVYA3hT/h?=
 =?us-ascii?Q?wg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 117361d7-7f00-41e0-5ddd-08dc4769e937
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 16:38:59.0805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e+RZHpZey6Qh0NJhtdMQ1K2mt3WPDT5AtmaO1QX7TqhHPy9XYgbKg8SZEroZNlU3wHK3OfHKg0v033t+TCLqrYsfngpGh9C8fToQJ4wcEWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9132

endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 48_4_1
[/local/endpoint/ep0] BIS Index for reconfiguration? (value(1-31)/no): n
[/local/endpoint/ep0] BIG (auto/value): 0
[/local/endpoint/ep0] Enter channel location (value/no): 1
[/local/endpoint/ep0] Enter Metadata (value/no): n
---
 client/player.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/client/player.c b/client/player.c
index 8081ddc13..c9c6779f3 100644
--- a/client/player.c
+++ b/client/player.c
@@ -3659,6 +3659,33 @@ static void config_endpoint_iso_group(const char *input, void *user_data)
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
+	bt_shell_prompt_input(cfg->ep->path,
+		"BIG (auto/value):",
+		config_endpoint_iso_group, cfg);
+}
+
 static void endpoint_set_config_bcast(struct endpoint_config *cfg)
 {
 	cfg->ep->bcode = g_new0(struct iovec, 1);
@@ -3674,8 +3701,8 @@ static void endpoint_set_config_bcast(struct endpoint_config *cfg)
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

