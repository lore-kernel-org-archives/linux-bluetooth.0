Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2074.outbound.protection.outlook.com [40.107.22.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130C4154431
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 15:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706542192; cv=fail; b=BOfD5Ret7gLbi7k5DCkXbSvx7iQJ7xrIu5VFX7itWPnQAXcVxRv1pzdqNmAyaLFaJmgHQzaiMaE4fp3fsCLkoSSSYNHncXYnQVluZIQzXtHzpA5Rm0cOZL+i9z3Lk1FgfOsNiEbIVV/k56iyXDIXnkRauGPjSGbc1A8R4ilKezo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706542192; c=relaxed/simple;
	bh=VV1j2yuVP3uPULRHO3qeVB5rv5G6dvPnPZWDQV1Hmok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OfG8x1qVm8tNjg5uJkNgCRDzNES1dLMw/8r9MsJou6ibum8YOiR2p5OMqqKMmnF6kAaMgT0vAf4nxJSt2RnXLu+z5JGgCk73nY9q/2X/bF1COVJtsdYzW02dkc/W1nUFlzl6MBDjm3jKGWF/SWxpUEhIuBDWjITnudHPIBZbsD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kPBV+eNe; arc=fail smtp.client-ip=40.107.22.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kPBV+eNe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFVXhDnfSFHncsviJl0oBFvOaHbGdIaYxYRosBgd9O+jQiMR4C1RufCWlvJad/WVIx//ukQ372bziNrBYdvNPWU8Fo4tpU1N3Bg7WwAqX21fn7qALskj8EfpT34VHHYlHj1DeA+0Y5AHEmLxjYf3mVAeWJGY3uPgCIp0LpRJ/ipIO7BvGhBv80OlJlymbt0Q9s9fwWfcOEvX3/uEfVAlcD4fZEaU2ST54M7wx0NkGa83woEFF4YXoAyhGB9zj1Ot0Fug+XQblEO5sOQJ33V7ewnT/lT4ynD2SrGJTDgzD6XHPXXxqwVXu0Hyrj+7d8w11jajDmjlL4vyul6UCVRGVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5IwxI3wwC78npt+PMVMZGqWsg3bOMJSp+nFxv8ZDks=;
 b=Zp3T5VotaJvRk5Fe4DYmyQZJADgoLBXpbbzp89LROv2LiKuKNAuP+rc3gCqM5u6fAiLoO8kL9LmYPJJWz/yZWXToi+EHQgzNcuqHoz5MHwpaEFTIGRPNwRH1rEZZ8TSQvEfuJhGGF2/pGFjyt4OmfIljh8xUQHIX20TwnQiawmNOoz7R8W+QUUAaHqjr4h7Yb8tYW+Es/0Zkzcc53mu5QnKqCmEjfG0tL/G4kwqy1OU+IyAxrdz+l7GKuEUpD0uwGrUD+x97c2sZZQc/timnV0ztJL011B4eN+IDB2+4s42aB8iXvXEwkXwGzDfAOYFO+uTadAha8Fyk4vTi7rmVkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5IwxI3wwC78npt+PMVMZGqWsg3bOMJSp+nFxv8ZDks=;
 b=kPBV+eNekag8150JjK3Ncx8nDnS26UORNwZJJAcvcA75PeJXKUrjNUbBrceEsjRGCsh5nthFa7Bu1NJPM7ioPcAYPuXs+uEzG1Byw70140frpfyO8vSqjV3FYuycsrS8uN+PCGqnMyqMJ3jU0VfmFxgFTCVS7mX6EACQGph4Z2Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM0PR04MB7105.eurprd04.prod.outlook.com (2603:10a6:208:19b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 15:29:48 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213%5]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 15:29:48 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 3/3] client/player: Update bcast endpoint input prompts
Date: Mon, 29 Jan 2024 17:29:28 +0200
Message-Id: <20240129152928.3904-4-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240129152928.3904-1-iulia.tanasescu@nxp.com>
References: <20240129152928.3904-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P190CA0033.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::46) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM0PR04MB7105:EE_
X-MS-Office365-Filtering-Correlation-Id: f7c96dce-d5e2-4471-92e2-08dc20df2130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	57cF3N2Pq3WNSWk9O9Q6jra/Dpcgj30GOMq7m/WnszH8MAKXx45WOW010kQFoRhP1RkADpzu9yE9g5yxsoOmeIKR0K6ZNSP1vv0a/uZjH3ORMCvIpVUTIbhqQJpWp0aPGsi3C181Fc6eg52matgLM0F+ebsOGuDaYeF8yepV8V6bYxhxuACx6RcFiBy6DVedB14DOsO7O0+7wc92e5X7BGtSKB7s8tzF9kgYAeeEzCX9R1SnNnOZLgfKgz8rJt2bqeSGrA1+9LV/7orEevF7V78j+BDdmn0kE2ZF4Mm2h2xv0NhXU1HGlezBTWFaK/orVV/ibo/xALXpk1ibUztWuwI6HxQA0T8RV1nuF8teNnslwE9W8E5p10iPXqWYCujQ5o+Tf7tgY8BvNSILkGx+A9yn2hXolfRda3o0tzXmapTftQLeGfQ1EMrsjPhQMz/xdNjhhhW060uFZmpLQYCajLkcsQvJlOQPuhm+laxnY0Y6eUK2ZW8ANrD+eaGaDUtpqavp2yEcOsnY0qeZSjOaE8VPOECL3+M1Nt3m9c2bRXGEhYPX98VqCfQfs/5O6mPS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(26005)(6916009)(6512007)(38100700002)(2616005)(1076003)(66556008)(15650500001)(8676002)(8936002)(4326008)(5660300002)(44832011)(6486002)(6506007)(2906002)(66476007)(478600001)(6666004)(41300700001)(316002)(66946007)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SG5DJux/o8kPIV++0QxHdFFFzPc/81ClXqPltmOxchkKRL9BamfaWn7XTInd?=
 =?us-ascii?Q?a7mtM4GmjeER7T/+dMtB1pYkyp+UXUT2RtWcQEyVymVJCEXsTvm27noU0rni?=
 =?us-ascii?Q?3tRVwlKiqXn5757qRw71xNIXywyWyNOA9tXxp+HkgaGepx3nzkFoKy9KZ0AY?=
 =?us-ascii?Q?toxqBRBP6tNFFgMj71nZX05j3baTJQrJTiHo4HDGnLJMBCa8fsCYq9Sld/fB?=
 =?us-ascii?Q?nCuq8/mrSLVRfMDWuKDnOBfWJVSU2af2Yew31zlxG+SGkv/NnxenUeejh7X7?=
 =?us-ascii?Q?Hl93V+ZwFgzO1ub9Gm0gQzq/09wJ9mjNIFWAh8HDBhr560aWuXHsOhluyaxX?=
 =?us-ascii?Q?2nIEfr3BFGDEBA78amyR1pX+yxmAsgBV8Hcn0MEuE57DjPq/08pLNxwoVhMi?=
 =?us-ascii?Q?zVBi5WAHcxEHAQO4FUZz7xdgMxTZpINx46F0dMs1O2ID4b/SxkZJnEwbvy30?=
 =?us-ascii?Q?Hq2Z7N+N5ROiiWxUwdmNhOxaVeTsWwc7QK02Oa2tEak4HP+2/n8Bdr1KNd2G?=
 =?us-ascii?Q?TUCSFGkjow3Jywl6ngAZvZ7K1JPAQ1iOj1iGVwhBp3KJPSNY3ZLuVIp0pfLH?=
 =?us-ascii?Q?vzKIjLYW2+nXt75sGNrGYqny/nhl8FRezRbqmO/1V9DTloOl0lousbUlN0PS?=
 =?us-ascii?Q?vA3Wmct10c9Es1L3qg85XXdCFbXbFfvVCXD11st7V5K4YZid8RBWJQ3QnSft?=
 =?us-ascii?Q?xC3PHfRzOfDEvvZd+ugD70HaAsTDL5hwxyEY+b451d8cFBeoBw66txCdSudv?=
 =?us-ascii?Q?/aTCSI43vxc4EghRswJ9hkPKO5P7k4TY506qYmwib6/o+8uxuEnSxBSSe0pw?=
 =?us-ascii?Q?qo09ZwDYJvoQupOJFeYkBXXHDEJ41JvC/DI9DoVNP0Kw3b9Z2MqJuBANCvoE?=
 =?us-ascii?Q?jMmGa4G0YWApsSyMbLhILAhAym3QFmGW+cSgVY5S7Uwo1xEqaMZ3O6VcDRFM?=
 =?us-ascii?Q?YhBwxQ5fyLaH5pmeafS1iz6errS9+QaqqrtVVjrDFJTvpS01zQWmgyNo0yem?=
 =?us-ascii?Q?7u/zVwHo+HcjGnuiGOWkWR/5UyflLUwSaTgCk9pkERj0C+k9QtkJFj6lgjXI?=
 =?us-ascii?Q?15lZ9vQS3lWOkwTSFO+MbEG5v3X5yUz1FRQY0Qf1Qymeq98foGy+yzK94RRx?=
 =?us-ascii?Q?4FtqSBgq5D/eqAaDdp+y8MAmDj2JP+cCQEYmwUb4OB5tYaUQQ9tWo8zitE8R?=
 =?us-ascii?Q?xwtezVbO521PzPc7N55kdoJ11V1h8ZG7Y5KF3YI997l0g9ol3FvQQbdIh9ie?=
 =?us-ascii?Q?HefeuGs4m19pX4y+QTm0j+mw/LnNeqY0xV1lGS6T3w27ZBJECpmCswgd0I5e?=
 =?us-ascii?Q?GHWfIoeyIvaEX529YpDdFdGUuZ4uo+UeK3OFv0lI6mzZc/TIeHwRB7jYD5FK?=
 =?us-ascii?Q?XHXLZoBwHSFFfgt80lKeitXsEN67xs4TWcqOHtPSUmStmBZqGvc9LScmPnEv?=
 =?us-ascii?Q?gWHpBBbSGFIHnArR5lOuQkkSB7xvMGIE2DRmLppbff5snZLm0fo0ZB2dQ519?=
 =?us-ascii?Q?ikVOn2iSy1lFJK+RYzZFQ2l1YeWOAULuspW/ftlrIGRsWmYpOwh11TwMqDWB?=
 =?us-ascii?Q?Kpv3UBNs+TseIFbVXJ3kpoFBP/tGflD1gqYQBgK5+oXheUiKUaaTj2LlLrEj?=
 =?us-ascii?Q?HA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c96dce-d5e2-4471-92e2-08dc20df2130
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 15:29:48.7517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ABIBYr2Z79uafIoy3kLwz/db9Qu2Bz5mSkwgSapVwizFDfbABuSy7Vu0KC1s3KqQLGgJovSiU8BXT/PEGK2LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7105

This updates the input prompts for broadcast endpoint register and
config.

To register a broadcast endpoint, the user will be asked to enter
the supported stream locations and context types.

At broadcast source endpoint config, the user will provide stream
config options: The BIG that the new stream will be part of, the
stream Channel Allocation, and the metadata of the subgroup to
include the stream. These options will be used to configure the
BASE and the BIG.
---
 client/player.c | 186 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 149 insertions(+), 37 deletions(-)

diff --git a/client/player.c b/client/player.c
index 623519209..d9a4bce87 100644
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
@@ -3626,6 +3623,134 @@ static void endpoint_config(const char *input, void *user_data)
 
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
+	{
+		uint8_t ltv[6] = { 0x05, LC3_CONFIG_CHAN_ALLOC };
+
+		location = cpu_to_le32(location);
+		memcpy(&ltv[2], &location, sizeof(location));
+		iov_append(&cfg->caps, ltv, sizeof(ltv));
+	}
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
+	bool found = false;
+
+	value = strtol(input, &endptr, 0);
+
+	if (!endptr || *endptr != '\0' || value > UINT8_MAX) {
+		bt_shell_printf("Invalid argument: %s\n", input);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	cfg->ep->iso_group = value;
+
+	/* Check if Channel Allocation is present in caps */
+	{
+		uint8_t type = LC3_CONFIG_CHAN_ALLOC;
+
+		util_ltv_foreach(cfg->caps->iov_base,
+				cfg->caps->iov_len, &type,
+				ltv_find, &found);
+	}
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
+		"BIG (value):",
+		config_endpoint_iso_group, cfg);
+}
+
 static void cmd_config_endpoint(int argc, char *argv[])
 {
 	struct endpoint_config *cfg;
@@ -3662,24 +3787,11 @@ static void cmd_config_endpoint(int argc, char *argv[])
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
 
-- 
2.39.2

