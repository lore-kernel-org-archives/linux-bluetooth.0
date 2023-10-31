Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A99C4167D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Oct 2023 15:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344839AbjJaP4E (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Oct 2023 11:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344856AbjJaP4D (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Oct 2023 11:56:03 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06D7107
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Oct 2023 08:56:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkMoQN9K76opQ9M3+IssosrSj0Q6NcZKr6zqaMDH8GdSzn2uYw2tqncSUU/ZZ02RRWa/dXW9kq/5hX5Uuw4PAj+YSEAraGPRSiNasVVujLZKJczbOSexHdAd4IzKvU6wnYDvg7Xtmqh5GpPx1P/Q2G/OASUxAxUb/kQghjrXow0Yh6+HxAlvhbs0N8KeahGcIuvmh2AZgyryVBNFCRUP0hrYadDYWvk6SAEaPbIbLOHXENxICM6FgkdijNS+N0GhORFiKQEg2i6GPsQeLzpBmpyflZP2YlZkGz+/kSnRagFdRWi1QSRdmmLRLH88KO919aWhcD9KXtuGyDfovnKSLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYp93LFk/IG/8TjGxqth6o2cTLM7cttKDKRWExlXMWs=;
 b=MJnF/FXt8T1XV5Uu0CajaKrvE5sNNSV0M3qu7S60ukhTADtLehNaY3KcDMhqpJef49DCHKaWmwV0IsfFNP5baA1hd9tthzcwaLbD2Jbej1yEIflEC7jIyJUlnGvongQznpQV0rveuUI5OiYMZCle9uF8gOqqe+uR/Fr6eMCThSH7N3+cgK0ic8KAGFb1sH1I4Orzt8894JN+8TPauWntANOOk4Kb5/emppoh64RiZR2PuwDL/5fEdxElkWxyph0mO83wpvoqcjYSuJ5O2j2snHUNNjxwtln3oQ1O9jmAgU+6mCjSA1R1ba8E4L5ziCQ/D+/otKwVI/Dg73+OITojcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYp93LFk/IG/8TjGxqth6o2cTLM7cttKDKRWExlXMWs=;
 b=kKsewdE2+S+Ywc0eEwD3/PXLWmKKjlCdFazRvDKXFqBlpb4+xGTe+jruRR9ljET88S5n7QcD7JJrUsZa4rbcRZvVuoy8ZRdF+2FDaJ6JeceS/U14pB65C3iowfMJJI2WSGfcDcLfD1/txcnBaBUd/42xB9xYFllj9VmqZzrUcB0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com (2603:10a6:10:ca::21)
 by VE1PR04MB7440.eurprd04.prod.outlook.com (2603:10a6:800:1b2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.17; Tue, 31 Oct
 2023 15:55:56 +0000
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::7c8a:c8da:e6a5:8a4a]) by DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::7c8a:c8da:e6a5:8a4a%7]) with mapi id 15.20.6933.009; Tue, 31 Oct 2023
 15:55:56 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        iulia.tanasescu@nxp.com
Subject: [PATCH v2 5/5] client/player.c: Add support for multiple BISes
Date:   Tue, 31 Oct 2023 17:55:35 +0200
Message-Id: <20231031155535.228994-6-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231031155535.228994-1-silviu.barbulescu@nxp.com>
References: <20231031155535.228994-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0042.eurprd03.prod.outlook.com
 (2603:10a6:803:118::31) To DBBPR04MB6331.eurprd04.prod.outlook.com
 (2603:10a6:10:ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB6331:EE_|VE1PR04MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ac98e5-bcf1-4e12-a116-08dbda29de8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R7CCV3Ic1D4WNUGb8GrmDIqWc0jzGOCjyAqvdQIWZ+z/mQyIN8D3W3DhOp65HAOPXoHQs8juPWqc9O/+38pm9fg56tU18n2BE9SKC8yIka6h0Ggui0PtqydRBUV3WKIZz0UWTfBtkj4BsPKDt6OnmKRO7d3nD4gbXo+A0BLyFttGe+JksEkqX+ujmyxxtIZyFqhx0/eSNXxOPjdUjN9Aca1dwFOjw+zERgISUUH/rwypJ0bTzNusVRdmDJ+S5kz2JFVP/69XvnGe9zL19x2u0D8ztGNmqLUlRdbSy4gvpUqVsZnM8K8qQGXP9xvqcGvqF790m6uMN26xu+XYTCyRxED2z8m0/NX8IQAq/ZXyltIxQIIwgSYZcliXe37cLJkAQ9iYICesdmbSMc/AC27mNac/kXQpX0/Ugdw9odBdQExTZ93HfYzKdleDl4mC0wxeoV8uezhaMB4wuqZqCK4Omp6dk2mb2oAbAU8CZoHmlOnr8xps2MIgHUSIfncYGq4VvBwqxSAvAyjTnRW+TyleCPScaLPMT0uaIKyXHsksMNweQ4jTfrzB8Kxhgc4jpzL3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB6331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39860400002)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(66946007)(66556008)(66476007)(6916009)(316002)(26005)(8676002)(4326008)(8936002)(83380400001)(5660300002)(41300700001)(38100700002)(6486002)(478600001)(6506007)(36756003)(2906002)(6512007)(86362001)(6666004)(2616005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/jsKX4WKsHCiXHo0XOYA4+5xef31WvJsQBFAnASpBO44UqV7dILHpggIiXPR?=
 =?us-ascii?Q?4ZI+fIGSJQ+9ERTOkO4Hib7Ffbik1G/qagbPNlkHsz+8Wag7VYVUYVkbjLT5?=
 =?us-ascii?Q?ZLliuevr8n+S1uOExI5L8h+GgF2fi7xWeRbdEvwjKyWpX3Gvs2s+j3aT+GVE?=
 =?us-ascii?Q?XLWsqar9w6Rel2BT9qpMFacxNTThDW+vi6V3tgxOwBkr5esK7Hr0WsAXJr1T?=
 =?us-ascii?Q?XE1rrBeaJ5yVRxz8nn3l/6xhM1s5axLWrC3dIZm4GYJxAdVxCbuaQltTOr3f?=
 =?us-ascii?Q?QVs+76kZeHN6cjvFtEbF5A9MhuBuf5PQGQR5a62zKvVvGflAYpfl4OnxDSdU?=
 =?us-ascii?Q?+X4E4PEuhNaUcLdYCU09kDwhWEadXa0kuZCCU7zKaC0vIouq3RQoJ3qKh/Al?=
 =?us-ascii?Q?2YgWCjdUlCHutCCbruDsMgYtToWsRmqfu1jpG3LF9K/eYK8AIzZfHjC831Qg?=
 =?us-ascii?Q?Dg9dPeMHCOUg9EPX6gb2XD6HZxDecR037D1x47wyThzz8BsZvtGmvFl53nO1?=
 =?us-ascii?Q?PKPXLvYtsA60yzv7PWRrCwAt5wNVqDKvbJkyN7PElkuhG43XGBykiuFvprWr?=
 =?us-ascii?Q?sFHbnr9ZA2w5PpSb2rAgTd5RcdUjs2UFhxzNbE0PnK0/rKu92i2NPKiWrhNP?=
 =?us-ascii?Q?QE9qhKE3UhYkDK1v8YiyRClg+bT5veBYh6LQ7DtUoLfdm9D1TdJ6UTWmwVUH?=
 =?us-ascii?Q?WdGBGRiBTW94eVTL4lysldC6cQfNd4CoCLvjY/BfDz8byOEZ3MxMaCx4tK/f?=
 =?us-ascii?Q?N7pN+qd/bnKjwuH5bPNN1Ns3xEljc3agvM3PxIlZfKXXBfR9Pgu+vapCC68P?=
 =?us-ascii?Q?9qUyANt3+nVGlRxY5r77CsBaAbOJqJPJmZch4UfdfcgItA46JgfL8CXwa3by?=
 =?us-ascii?Q?rb8BmeBygckaFbP+gIEWg5l7icwsHaLxP9B+ynn3nuqI5sETnRP7zk7Nfvkj?=
 =?us-ascii?Q?nMPK9QtikIZ4GcXiPLc+xd6LPQZvHwME9ljGd3nKmx3C+MYtp4JkBPjtAhsE?=
 =?us-ascii?Q?5HgR4/STQpg7Ju/dBg+39AtzPuKDM0nHZWJNpmDqRGr0oAaIYj8OJj/XVBCc?=
 =?us-ascii?Q?uBLuqic9fQ30dPVR1qhQE6M+ufD6mm8n/KIzqWhuqwweWuNC1zoG1/qM/4P7?=
 =?us-ascii?Q?3avhDVNrOl3EWAbX1JbERDFUFqHPJ26wcpEWxeiOFMcSrb05BjAY1pLizU9S?=
 =?us-ascii?Q?FGfCQfaFy6EMqZXuZq2YwOyH4pK4gAn6IkI/ARTxR2D2FQ3t0BsFOFswZrPJ?=
 =?us-ascii?Q?8Cuc1Y8tBAm45iGFCVKV1z+jWFBlk2PWtDJIU2l/aI9F8k65BVG/KyCJFyh8?=
 =?us-ascii?Q?B7YcUeLpZEWC2CZPcNwr9fIrjESpqboh9uH8RIokMFAqmMyhbhecvAcYKQFG?=
 =?us-ascii?Q?khjma9wrrC+8liU8qar+dKBQBSYTenz4Tz9ZUP1yRNo8PIcu1/AvK3koYpnp?=
 =?us-ascii?Q?QadJBCbxk1zkEk4YtHHgH0EeeZmPmJAfJPqN6kLAVRjYmZyM4VwryRNep78S?=
 =?us-ascii?Q?vOjXufZCaPtgRrSNV0sCic19OTVZmFtjQGGzbrU6U+fpfJRx2XIvoiG5glnx?=
 =?us-ascii?Q?QFyTGXvSlj5bRdeUuf1xpGt9TnaOPE/97p4YuqpyPm34LMr5dkTk82JUPXUp?=
 =?us-ascii?Q?Tw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ac98e5-bcf1-4e12-a116-08dbda29de8f
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB6331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 15:55:56.7214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/OWBZxma7O1P9WpmHeo4oEz7eoCpVqkgAv18rdgoXhGI5k3ga1BCRLZsO+8Ce7os6gujepbsih0Xboge6BddIj2ubWXFdQVVGfFTpVtwQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7440
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add support for bcast multiple BISes

---
 client/player.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/client/player.c b/client/player.c
index 715598aa9..7c517f80a 100644
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
@@ -3068,7 +3107,11 @@ static void cmd_config_endpoint(int argc, char *argv[])
 		/* Set QoS parameters */
 		cfg->qos = &preset->qos;
 
-		endpoint_set_config(cfg);
+		if (cfg->ep->broadcast)
+			bt_shell_prompt_input(cfg->ep->path, "BIG (value):",
+					config_endpoint_iso_group, cfg);
+		else
+			endpoint_set_config(cfg);
 		return;
 	}
 
-- 
2.39.2

