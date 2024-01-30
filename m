Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2081.outbound.protection.outlook.com [40.107.7.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE235823AA
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jan 2024 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629476; cv=fail; b=N3//9bp/opF8DjCJsoZifR5FWKOfN6QmZi3Rs+BF/WeNhp6TuC/c+CvmisfR/a4PndJLdeTKWXFdLWm43ABR9OzVzcUfQ8XFuqpb9S4/5WsMK33vUg5+65xHDF2ZrCW2NRUlkMozAxOk00AV4tvQK1pucsr2z+J0CzyMcrnnYjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629476; c=relaxed/simple;
	bh=v+sFMl/3GhfuNL5c+Qs39ER/BzRUSauSYohkgDZKJnc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XHUoGCka+0XiaBwvBEGPuxEvtboMvSueEqRCmVa/SqB93ksMM7zjDiqcpFpL+Hsr0Ym+fPLudVzeX3tr78TiKKVF7ic/EKWdc27wiY2Fn/4cjzfaLwFJF7nqw5P4cFsrancdwI6ClpN/Bf3bO6dFZB0lm/GcojvZKQY/7ype79c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=fJM6L/+4; arc=fail smtp.client-ip=40.107.7.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fJM6L/+4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQD1GQRkgY89jICDw3L9rD51hoVlI/XQ9Ep0m08uxJ8C6lPjA6cGaYQ6RzmPKIsVFdsaNAaStGO/5dHAxd2NOB4OmuNHM5SBZ8RL8v3vuL6VwZghgPenr8PGFk72Szs+p0DQWFOuvZEMENMO9epo5bDFPevK3xLZW6R+n0KmTJI3FSJP9SiQ4TsCagdMsQ0X4Lat0R0iO1fRWWhnH/6ibsBoN9e2y4Z77SoU/wzSzWUAHfYN+PqMV6bh106gVXqeQOGj/NKwzimKvrlr048ucfokRZBAWc3yoZcYAWil4tTWQWC7aTvZUGjE4BoUkaYLe5jkc35XG9ZxAZn9rZbgkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MlN+BpHd15AhP3Uqf/kPSBBXxP4ZK/YtxAz3OPluqRo=;
 b=cA5tUtHDcQRe/yjQMhl9SWSX9gmMC+6rcE3sz5nc6PC905vETiBMoLNVxlwGGQVizGLkmfCbooZhEnlMd9YETexmiilp+aRoNrG8XIU+fWffoNkONffphDAenre/98GsCvYIqhO++nqoTLuu8Cwv9sthzTDVBhuob5q4ujwqK7XqrSZBDHVoIjnwA9fEhnEeE60+3lvZh0/y+BcfN8cWCVjFpyPsKjcXAYlVA1Qs+GNxc/yHqlNUKKi5SL5ZJBcsHUyc9RHcr1Wk+iKsaknCZBExUxuHZR+q4bjckt814R/0jb+EcfG4PGsVqFZqHV8HT0uHv+IsCbpHP2z3mnLJyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlN+BpHd15AhP3Uqf/kPSBBXxP4ZK/YtxAz3OPluqRo=;
 b=fJM6L/+4IHI5ixHVUSm3LXTLXbBUHMlq8lAuqtjtYOvKVfcZ+HWSMIgLVBcEH9M6LX007gE0F/I5hkpMv24tpK7KER7AAmrwNBTei3sWzKIBWYI/nDbKND2p+tDZGuMDEARIMKzvoVUW0f3fcmDHZiOBrOKlBtRJfyZGnXMRKrI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU2PR04MB8773.eurprd04.prod.outlook.com (2603:10a6:10:2e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 15:44:30 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213%5]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 15:44:30 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 4/4] client/player: Update bcast endpoint input prompts
Date: Tue, 30 Jan 2024 17:44:12 +0200
Message-Id: <20240130154412.3157-5-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240130154412.3157-1-iulia.tanasescu@nxp.com>
References: <20240130154412.3157-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0170.eurprd09.prod.outlook.com
 (2603:10a6:800:120::24) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU2PR04MB8773:EE_
X-MS-Office365-Filtering-Correlation-Id: 81d61b6e-3389-429c-660f-08dc21aa5928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	p3LOs7KvtuDy8mNlVuWioRdRAJsNJuhdQhD8XRFTdNnB4ZnYnAbKd/WhoWIms/YapD/9JWX8myTCAKKYpffLu7B8jrcJQnEBMPQ3YlNeMWcm4f2y8NjFuWLtUrm8k7nettpX3Fitw1zHWPBBCpVH/1u4ma9kBocyPB3dKlUd94qGT4x8xciyRNLwp+4EQvfkyXVKhHyEcsEz/DmtqS+GbEO6ZzDOA1Hu6RHtUvsGIyJY7C+6yGpt5WfGYbH1YkaRNjmBsSjxcPw4X/InqSPN6VWqgm+SU6J5CYJX4K0eINMXcXGuyApM6xkOFh+speSL410W5ZTjCEWm4tBPUM+wjBiYucM1u3OzYmu3ZoIp5P8qF4Hz/NCBGB8maDrhHTl1ys7IFupoZXU6euoqNfcl99aJKn3wRdjJkbpE/oF7FuZCjnuFGoyDVNxqKJ4H8/c5eGVo1X3CunElSQx0c3ZT4TygP2DseKGiGTK1bCFzdTesJ+NUTTvJruhboBbe5YPnkRZqYysA+wWdIz4TcGaDOF3UeiZLNKtn8ZX1PYFuRfiOXXut5CRZc2APzutuA1FP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(1076003)(2616005)(41300700001)(83380400001)(26005)(6666004)(478600001)(6512007)(6506007)(6486002)(2906002)(66556008)(66476007)(38100700002)(6916009)(66946007)(316002)(4326008)(8676002)(8936002)(15650500001)(36756003)(30864003)(44832011)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yXzxsIldxViO6/Nc75X0ZamOAPPTU2OmN8tj2ddVKCvubLLAJkxKM/iJ9Smz?=
 =?us-ascii?Q?o3o0xhijBWZlNLQy2WIJIoO7woF32qiNoG+Mh3tPOyOQJTNc64+XWkCd08i2?=
 =?us-ascii?Q?bL0483g9NJ7ZaIgORhzaidF+y0tj3I/UJwMLo87XU7RsJULKOXl1LmlfeHk9?=
 =?us-ascii?Q?Zll+USpHuwrMOdUg7NGgVvkAdwg1oXxmWG+EkveXUafJOMOsSLLqgCxoF5V0?=
 =?us-ascii?Q?7U6oeG+Y2OY8gzwYboHkf+e4Fm6GAIlAWFx7iX3JDaILfLwxXL34jauoR1R3?=
 =?us-ascii?Q?A2q2AZ1N7pNslr4jys11bqAabLZwwfoHBJiRaukf12IjFK499IKv57t982BG?=
 =?us-ascii?Q?FAfvt+IE1biRnruUWDneDSEAFF6+IEnvhQxGpZIWm3J1OfgeeBEtPHFBHoao?=
 =?us-ascii?Q?tA4kG6opFASgyEVa4g0u/v6cpBktSGqWhx4YS2HF5GQf4+REong0VvB0I91n?=
 =?us-ascii?Q?VKMM9lIMfGZiRH2jR2OWxebQ6g4LvoADmHGLO+OJm7rgvt2yvZOSid8cIVbi?=
 =?us-ascii?Q?dqFYmqWDQI4rJOSmWQ2XrUSyQjvsJVdiZVfe8ECCPRxQ+7utEhoYHwXURViw?=
 =?us-ascii?Q?6Zw5v4Q2tBOk/SMfkI6heJOGcAZYRYZpGrVVOijUbhhZU04ApbYFIlEmC7Vb?=
 =?us-ascii?Q?+Pt0cRxDMVr6wodxnYbRo2pE84p5kWAqs+3h7vtgKFIVN7nPwuzVGAlsBpXq?=
 =?us-ascii?Q?NweuX3LeWcVCmfaY8R96UdOvOSYWM6U0/A3VdqP3Vq4B3SqRedGRvJY3+rf9?=
 =?us-ascii?Q?t6zaWXRatTCpwMS2NYmGN8Q+za0PU/PiG1T6ugRw9THvxIiFE9V2El3hDBjZ?=
 =?us-ascii?Q?poLsnSowOEsTelQPHOIgCAeAHclmpVhNRLYWlWB4raf4mUaPRr19GO7W7id7?=
 =?us-ascii?Q?rObmyub0nGBzk/NJ/lm5Z9DtGlKV34reBTIxA4+oTAbtFxHH4I6h8hOoVClh?=
 =?us-ascii?Q?kadUijf/BHDGRenGx4bee2OjJzGsDAq/qfsQY/TEF2FiRGm8Cu6xu7llsvAF?=
 =?us-ascii?Q?LwK/4V7fTv16ye4J+acAaCZVqRcnPjuGmLWy5tYRgdgouha9YaAcEZiCqQ82?=
 =?us-ascii?Q?MAqunGUnth6e2O+TieS6aOzDgPtbx7OiZW57l6C2Csb+mxPmm1kWGC8TkE/e?=
 =?us-ascii?Q?a5Afwb6hcvvSlH1qo/DgJoo8dq1/ZADpgB4bP8ufkJCKJwfXJo9jtDug/Xcj?=
 =?us-ascii?Q?OSZy2OskaxxnR2Trva7/YbvPaDYUlwEm3vNlG3kxhmKypAorz5JX5GJmqepL?=
 =?us-ascii?Q?RhpNNTBHYV1BuPbh/3gSL1uNOL/xKKICRJJhJMNIrueO+7wXvSdZZ7PI9zW1?=
 =?us-ascii?Q?lQpQf5KkSLrqmJfJuI41iHUqN1HsVzH7BPrmeGG12QCE7J7QBdI5gPms7hH1?=
 =?us-ascii?Q?9pNm3hLM+fbgEIoqsDHb9BcDEKN6bxzlh5amxh2psPf+T82Or5IcvEmRC8IQ?=
 =?us-ascii?Q?bP8use0LErgwwZ9HIsZVsd2uzi2DWUgzGtFDUBc1ns8txCNX4EwtHn0TwE3N?=
 =?us-ascii?Q?ndxxUPw+ZCXXBOl+JkAd7JEtkUMVd2VsxncuuNQ181eIfnFqf0oxFvekd/4H?=
 =?us-ascii?Q?y0kJZ2Pi/QvwuMIl9S7GyiwN9tZ7oLSrciHl9WiLBd4JkwIXXT7T6ykQsi8h?=
 =?us-ascii?Q?Lg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d61b6e-3389-429c-660f-08dc21aa5928
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 15:44:30.4770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qxhSzZJHO8eW5hXP+cRebVlesGUWwQybB+T0XysUwfOSrKBgMqeW61iu6MkbV0mF+/2Q5Rlo5VYSzdZ4Jiu3ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8773

This updates the input prompts for broadcast endpoint register and
config.

To register a broadcast endpoint, the user will be asked to enter
the supported stream locations and context types.

At broadcast source endpoint config, the user will provide stream
config options: The BIG that the new stream will be part of, the
stream Channel Allocation, and the metadata of the subgroup to
include the stream. These options will be used to configure the
BASE and the BIG.

The flow to create a Broadcast Source is the following:

[bluetooth]# endpoint.register 00001852-0000-1000-8000-
00805f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] Max Transports (auto/value): a
[/local/endpoint/ep0] Locations: 3
[/local/endpoint/ep0] Supported Context (value): 15
[NEW] Endpoint /org/bluez/hci0/pac_bcast0
Endpoint /local/endpoint/ep0 registered

[bluetooth]# endpoint.config /org/bluez/hci0/pac_bcast0
/local/endpoint/ep0 16_2_1
[/local/endpoint/ep0] BIG (auto/value): 1
[/local/endpoint/ep0] Enter channel location (value/no): 3
[/local/endpoint/ep0] Enter Metadata (value/no): 0x03 0x02
0x04 0x00

To create a Broadcast Sink, enter the following:

[bluetooth]# endpoint.register 00001851-0000-1000-8000-
00805f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] Max Transports (auto/value): a
[/local/endpoint/ep0] Locations: 3
[/local/endpoint/ep0] Supported Context (value): 15

[bluetooth]# scan on
[NEW] Endpoint /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/
pac_bcast0

[bluetooth]# endpoint.config
/org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_bcast0
/local/endpoint/ep0 16_2_1
---
 client/player.c | 238 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 190 insertions(+), 48 deletions(-)

diff --git a/client/player.c b/client/player.c
index 623519209..620420cd6 100644
--- a/client/player.c
+++ b/client/player.c
@@ -4,7 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2020  Intel Corporation. All rights reserved.
- *  Copyright 2023 NXP
+ *  Copyright 2023-2024 NXP
  *
  *
  */
@@ -3259,12 +3259,8 @@ static void endpoint_iso_group(const char *input, void *user_data)
 		ep->iso_group = value;
 	}
 
-	if (!ep->broadcast)
-		bt_shell_prompt_input(ep->path, "CIS (auto/value):",
-			endpoint_iso_stream, ep);
-	else
-		bt_shell_prompt_input(ep->path, "BIS (auto/value):",
-			endpoint_iso_stream, ep);
+	bt_shell_prompt_input(ep->path, "CIS (auto/value):",
+		endpoint_iso_stream, ep);
 }
 
 static void endpoint_context(const char *input, void *user_data)
@@ -3282,12 +3278,8 @@ static void endpoint_context(const char *input, void *user_data)
 
 	ep->context = value;
 
-	if (ep->broadcast)
-		bt_shell_prompt_input(ep->path, "BIG (auto/value):",
-			endpoint_iso_group, ep);
-	else
-		bt_shell_prompt_input(ep->path, "CIG (auto/value):",
-			endpoint_iso_group, ep);
+	bt_shell_prompt_input(ep->path, "CIG (auto/value):",
+		endpoint_iso_group, ep);
 }
 
 static void endpoint_supported_context(const char *input, void *user_data)
@@ -3305,6 +3297,11 @@ static void endpoint_supported_context(const char *input, void *user_data)
 
 	ep->supported_context = value;
 
+	if (ep->broadcast) {
+		endpoint_register(ep);
+		return;
+	}
+
 	bt_shell_prompt_input(ep->path, "Context (value):", endpoint_context,
 									ep);
 }
@@ -3354,13 +3351,6 @@ static void endpoint_auto_accept(const char *input, void *user_data)
 {
 	struct endpoint *ep = user_data;
 
-	if (!strcmp(ep->uuid, BCAA_SERVICE_UUID) ||
-		!strcmp(ep->uuid, BAA_SERVICE_UUID)) {
-		ep->broadcast = true;
-	} else {
-		ep->broadcast = false;
-	}
-
 	if (!strcasecmp(input, "y") || !strcasecmp(input, "yes")) {
 		ep->auto_accept = true;
 		bt_shell_prompt_input(ep->path, "Max Transports (auto/value):",
@@ -3478,6 +3468,13 @@ static void cmd_register_endpoint(int argc, char *argv[])
 					g_list_length(local_endpoints));
 	local_endpoints = g_list_append(local_endpoints, ep);
 
+	if (!strcmp(ep->uuid, BCAA_SERVICE_UUID) ||
+		!strcmp(ep->uuid, BAA_SERVICE_UUID)) {
+		ep->broadcast = true;
+	} else {
+		ep->broadcast = false;
+	}
+
 	if (strrchr(argv[2], ':')) {
 		ep->codec = 0xff;
 		parse_vendor_codec(argv[2], &ep->cid, &ep->vid);
@@ -3626,6 +3623,147 @@ static void endpoint_config(const char *input, void *user_data)
 
 static struct endpoint *endpoint_new(const struct capabilities *cap);
 
+static void endpoint_set_metadata_cfg(const char *input, void *user_data)
+{
+	struct endpoint_config *cfg = user_data;
+
+	if (!strcasecmp(input, "n") || !strcasecmp(input, "no"))
+		goto done;
+
+	if (!cfg->meta)
+		cfg->meta = g_new0(struct iovec, 1);
+
+	cfg->meta->iov_base = str2bytearray((char *) input,
+				&cfg->meta->iov_len);
+	if (!cfg->meta->iov_base) {
+		free(cfg->meta);
+		cfg->meta = NULL;
+	}
+
+done:
+	endpoint_set_config(cfg);
+}
+
+static struct iovec *iov_append_ltv(struct iovec **iov, uint8_t l,
+					uint8_t t, void *v)
+{
+	if (!*iov)
+		*iov = new0(struct iovec, 1);
+
+	if (!((*iov)->iov_base))
+		(*iov)->iov_base = new0(uint8_t, l + 1);
+
+	util_iov_push_u8(*iov, l);
+	util_iov_push_u8(*iov, t);
+	util_iov_push_mem(*iov, l - 1, v);
+
+	return *iov;
+}
+
+static void config_endpoint_channel_location(const char *input, void *user_data)
+{
+	struct endpoint_config *cfg = user_data;
+	char *endptr = NULL;
+	uint32_t location;
+
+	if (!strcasecmp(input, "n") || !strcasecmp(input, "no"))
+		goto add_meta;
+
+	location = strtol(input, &endptr, 0);
+
+	if (!endptr || *endptr != '\0') {
+		bt_shell_printf("Invalid argument: %s\n", input);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	/* Add Channel Allocation LTV in capabilities */
+	location = cpu_to_le32(location);
+	iov_append_ltv(&cfg->caps, LC3_CONFIG_CHAN_ALLOC_LEN,
+			LC3_CONFIG_CHAN_ALLOC, &location);
+
+add_meta:
+	/* Add metadata */
+	bt_shell_prompt_input(cfg->ep->path, "Enter Metadata (value/no):",
+			endpoint_set_metadata_cfg, cfg);
+}
+
+static void ltv_find(size_t i, uint8_t l, uint8_t t, uint8_t *v,
+					void *user_data)
+{
+	bool *found = user_data;
+
+	*found = true;
+}
+
+static void config_endpoint_iso_group(const char *input, void *user_data)
+{
+	struct endpoint_config *cfg = user_data;
+	char *endptr = NULL;
+	int value;
+	uint8_t type = LC3_CONFIG_CHAN_ALLOC;
+	bool found = false;
+
+	if (!strcasecmp(input, "a") || !strcasecmp(input, "auto")) {
+		cfg->ep->iso_group = BT_ISO_QOS_GROUP_UNSET;
+	} else {
+		value = strtol(input, &endptr, 0);
+
+		if (!endptr || *endptr != '\0' || value > UINT8_MAX) {
+			bt_shell_printf("Invalid argument: %s\n", input);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+
+		cfg->ep->iso_group = value;
+	}
+
+	/* Check if Channel Allocation is present in caps */
+	util_ltv_foreach(cfg->caps->iov_base,
+			cfg->caps->iov_len, &type,
+			ltv_find, &found);
+
+	/* Add Channel Allocation if it is not present in caps */
+	if (!found) {
+		bt_shell_prompt_input(cfg->ep->path,
+				"Enter channel location (value/no):",
+				config_endpoint_channel_location, cfg);
+	} else {
+		/* Add metadata */
+		bt_shell_prompt_input(cfg->ep->path,
+				"Enter Metadata (value/no):",
+				endpoint_set_metadata_cfg, cfg);
+	}
+}
+
+static void endpoint_set_config_bcast(struct endpoint_config *cfg)
+{
+	cfg->ep->bcode = g_new0(struct iovec, 1);
+	iov_append(&cfg->ep->bcode, bcast_code,
+			sizeof(bcast_code));
+
+	/* Add periodic advertisement parameters */
+	cfg->sync_factor = BCAST_SYNC_FACTOR;
+	cfg->options = BCAST_OPTIONS;
+	cfg->skip = BCAST_SKIP;
+	cfg->sync_timeout = BCAST_SYNC_TIMEOUT;
+	cfg->sync_cte_type = BCAST_SYNC_CTE_TYPE;
+
+	/* Add BIG create sync parameters */
+	cfg->mse = BCAST_MSE;
+	cfg->timeout = BCAST_TIMEOUT;
+
+	if ((strcmp(cfg->ep->uuid, BAA_SERVICE_UUID) == 0)) {
+		/* A broadcast sink endpoint config does not need
+		 * user input.
+		 */
+		endpoint_set_config(cfg);
+		return;
+	}
+
+	bt_shell_prompt_input(cfg->ep->path,
+		"BIG (auto/value):",
+		config_endpoint_iso_group, cfg);
+}
+
 static void cmd_config_endpoint(int argc, char *argv[])
 {
 	struct endpoint_config *cfg;
@@ -3662,24 +3800,11 @@ static void cmd_config_endpoint(int argc, char *argv[])
 		/* Set QoS parameters */
 		cfg->qos = preset->qos;
 
-		if (cfg->ep->broadcast) {
-			cfg->ep->bcode = g_new0(struct iovec, 1);
-			iov_append(&cfg->ep->bcode, bcast_code,
-					sizeof(bcast_code));
-
-			/* Add periodic advertisement parameters */
-			cfg->sync_factor = BCAST_SYNC_FACTOR;
-			cfg->options = BCAST_OPTIONS;
-			cfg->skip = BCAST_SKIP;
-			cfg->sync_timeout = BCAST_SYNC_TIMEOUT;
-			cfg->sync_cte_type = BCAST_SYNC_CTE_TYPE;
-			/* Add BIG create sync parameters */
-			cfg->mse = BCAST_MSE;
-			cfg->timeout = BCAST_TIMEOUT;
-
-			endpoint_set_config(cfg);
-		} else
+		if (cfg->ep->broadcast)
+			endpoint_set_config_bcast(cfg);
+		else
 			endpoint_set_config(cfg);
+
 		return;
 	}
 
@@ -4090,6 +4215,30 @@ static const struct bt_shell_menu endpoint_menu = {
 	{} },
 };
 
+static void endpoint_init_bcast(struct endpoint *ep)
+{
+	if (!strcmp(ep->uuid, BAA_SERVICE_UUID)) {
+		ep->locations = EP_SNK_LOCATIONS;
+		ep->supported_context = EP_SUPPORTED_SNK_CTXT;
+	} else {
+		ep->locations = EP_SRC_LOCATIONS;
+		ep->supported_context = EP_SUPPORTED_SRC_CTXT;
+	}
+}
+
+static void endpoint_init_ucast(struct endpoint *ep)
+{
+	if (!strcmp(ep->uuid, PAC_SINK_UUID)) {
+		ep->locations = EP_SNK_LOCATIONS;
+		ep->supported_context = EP_SUPPORTED_SNK_CTXT;
+		ep->context = EP_SNK_CTXT;
+	} else if (!strcmp(ep->uuid, PAC_SOURCE_UUID)) {
+		ep->locations = EP_SRC_LOCATIONS;
+		ep->supported_context = EP_SUPPORTED_SRC_CTXT;
+		ep->context = EP_SRC_CTXT;
+	}
+}
+
 static void endpoint_init_defaults(struct endpoint *ep)
 {
 	ep->preset = find_presets(ep->uuid, ep->codec, ep->vid, ep->cid);
@@ -4105,18 +4254,11 @@ static void endpoint_init_defaults(struct endpoint *ep)
 
 	ep->broadcast = (strcmp(ep->uuid, BCAA_SERVICE_UUID) &&
 			strcmp(ep->uuid, BAA_SERVICE_UUID)) ? false : true;
-	if (ep->broadcast)
-		return;
 
-	if (!strcmp(ep->uuid, PAC_SINK_UUID)) {
-		ep->locations = EP_SNK_LOCATIONS;
-		ep->supported_context = EP_SUPPORTED_SNK_CTXT;
-		ep->context = EP_SNK_CTXT;
-	} else if (!strcmp(ep->uuid, PAC_SOURCE_UUID)) {
-		ep->locations = EP_SRC_LOCATIONS;
-		ep->supported_context = EP_SUPPORTED_SRC_CTXT;
-		ep->context = EP_SRC_CTXT;
-	}
+	if (ep->broadcast)
+		endpoint_init_bcast(ep);
+	else
+		endpoint_init_ucast(ep);
 }
 
 static struct endpoint *endpoint_new(const struct capabilities *cap)
-- 
2.39.2

