Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E09EEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jun 2023 07:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjFWHrc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jun 2023 03:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjFWHr3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jun 2023 03:47:29 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2054.outbound.protection.outlook.com [40.107.15.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AD81FE3
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jun 2023 00:47:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdRmGm0HUHUUsg/IdA2L9A5I3MC5tUihC3n17CYSOzRS7I/aidsL0BXFTalhLsLXlP8JUoEdKMdeq6nn7Q6C6AUISbkm4A3NPXZKIzSwCDojmr4aueu9e0FVwPu5KBER3OBvJGywqUJQZEeMIrmkGGWfKDz4yrkBHA7iFU+V63/G7B/XmG2hAPyZO32YvivMAefgtrLdZvp8rmBSA49gFpEWisapLlvYQ4Rz+9g/u+ZoCviyNYrXpio5Dt7y20OvRi7tO9K6F0GTbL3gSqUkWaeGZwajS2UIBH4N4FRgOJj3b4R80tddP7A95J1ibWcU/j6tMB/wUtsTBSGriUUTvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1YbCNTWnHnKmuX9Pj0tfve2HH2hOvmIee1WNTJTBRQ=;
 b=jwm4G7qdDDfAIOILUSBj4/hWk0qjR22CuIzLa2DluiRommonQvLJevnVsIMCWY+yTJzJ846HFtKZW3OV5q1p/FbmFwlqrvP6mINOUeuUkKJW7tzlnx+Z8UhqBgDauBc6qaw/HCbCvBKKFT9lIapb3WZuzcp3fO06qkgTB9wlorHA8yJy9hGPp9gerUKAegngVI5u0ETroy6ftdA56XhLX10bCyxbhlOqaR1cdEP4xcBJHJhPEr3cPYtbAsZwHCE6uZpKfUkFV+j1lGt82UaW4Xv1NqlvdZYABuYXzsslMCo6Re/SpsWs1zc8ir2KQGWHkpR0iLr9rU9MAq4Hphw0wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1YbCNTWnHnKmuX9Pj0tfve2HH2hOvmIee1WNTJTBRQ=;
 b=Q/jkObu6f/y5/kktD0YDlPoBqRYi8H8Y2urlktk857SWck8yDRnphe0tL+Aq/p2AJblamGvpdXi5FqpV3DW7DQzWssWu75C+uftIH+i6KsFmLybUkXv8iM32eGDMgWAgxK4wEWhsV7/7YVt9y5PTILMd8wn5SjPJO0yfBZeD/uE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM7PR04MB6918.eurprd04.prod.outlook.com (2603:10a6:20b:10c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 07:47:17 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe%7]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 07:47:17 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/2] btio: Add option for binding iso broadcast address
Date:   Fri, 23 Jun 2023 10:46:56 +0300
Message-Id: <20230623074657.16618-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623074657.16618-1-iulia.tanasescu@nxp.com>
References: <20230623074657.16618-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0228.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::35) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM7PR04MB6918:EE_
X-MS-Office365-Filtering-Correlation-Id: 73a85019-398f-4dab-6ece-08db73be111c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lxjuFMcW9z51rKJ94RQFv5Y4QF+CUSec+6O8xrMndyGwzN2pL0xZR7pSuj4tSOEW+3s8pfZvzcousW7ZpRdgAK+MqS548uftyAY3QlPjEOD0PUC3smnvux8HC0ndb3vQ5vYonzr/ickoySoLIRY/l8pGrhaEzH49BlCqpzDsh50+RI0nOh4RQ9QKpwsjXIbwxBtCAv/A0to+ZdcLFZzRe76MBicow7VErMq66/j24hZ6wdarkwnwzBF70KjZ1JO/iBq+kor/tcFg23Le/oCXo7Kqo4EN9r/7eZZuOMrNDARjVZFqJqz2i2bAhDgUTuJaewmcg04cFliUA94Ib8xHCia7W/BJ1bg1yQ/hOMFpDCkvC4jlsFce8jIS8a3w6NN8hvKOZVejUQxhlxIK7Ylqw9VIhrFJhiY9QFve56vEu5/KtsVFGUl6HE2P7cKBzcsw1t4gA93hjDkwfLXoGsLB3zPGGRBwyo9qpt8pzZcGYnSUl71at8C5AyrFeelcSsasn1PfS2u0k+bdGm5OFLdeAH7VXjYqw6nW/NWaoRTPImU4i9TNydKN68P/zFPFoBysWbC21AMEc47k0yDLMGrlRTQepZMJ+RBmt8lv0sEqD1kZw0oba0kO0xVtiykDsdNd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199021)(83380400001)(41300700001)(8676002)(8936002)(316002)(2616005)(186003)(38350700002)(38100700002)(6506007)(6512007)(26005)(1076003)(6486002)(52116002)(6666004)(478600001)(36756003)(86362001)(4326008)(66946007)(66556008)(66476007)(6916009)(44832011)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o/4pSoWfelHu18vBhvrAx8u+CWlkvtjI3bt8xvGgb/69n9eN7zSZG0lMB3Lb?=
 =?us-ascii?Q?hgEAefEhGWa7q2P3g1MjFxTzQ6Z4POyQoIWNHkcnlh30UJowcql8XRmkhbNk?=
 =?us-ascii?Q?DuK4qMinAEL7IAm1iLmx+1iDOTkys7d8j1Rt+pEnVyZ4vLoabLbASIBmjUOf?=
 =?us-ascii?Q?BS3BlEVvllx/AOMZUpqwqEUwXTlP8pVw25j9kmlDBzM9sp5Zx2jc1qnWZSj9?=
 =?us-ascii?Q?BkinEv8NPjaSFHAOMkqO3n+dEwem2poRKzX1cC7QoMspiv4AaUhOpRV9qe/6?=
 =?us-ascii?Q?vUUEBVwlvOVu8RjpiCNT+jKoU18NXmPy7lfNjC+SgCm5eWKgde9//ZpNGkvh?=
 =?us-ascii?Q?QI42c2MBN+qzYB6ahDfYYqG50KjCPfEDcpWNNUpvgCwYM11LxHZrZ1lHNLsk?=
 =?us-ascii?Q?uynhnk+L/l72GqXyNFZCfDDa5NYDomG1tQOtHnNT6+s1obWyku/P6itZCeOk?=
 =?us-ascii?Q?Hi/T8kMMMtAhtmkNB7zvu+G7T+XVSRoUZICYP5SKR/5/X5CoKFVdi0xhy1u4?=
 =?us-ascii?Q?j/w2mAiBA2lUVmCmwUJXleKsgYpevRgAzUxpBvW3ol0zd2AcXwSpEbaAZk+5?=
 =?us-ascii?Q?q5NKo9eXTKo4mFB0EIPRi7xidC2tKh6Imxb4q+kKnJuE7SmDaLVECbXLLyCM?=
 =?us-ascii?Q?ddr5WwVgRgRj6153BXg67Df+5Vo1PWkEiReyALO8FJBlb6abmL1B1M/z1BBr?=
 =?us-ascii?Q?h4pg90wsrqUbqEpTHUB8wbgzHPRaB8Ztg7EHoLEzDk4XgViOshvypwX752Bp?=
 =?us-ascii?Q?mDTOh/pn0ssXp8e/uAhDFS33uxmc37lf+ovfGO2UFD4eFzrWHd8ojeHjPBCg?=
 =?us-ascii?Q?4JlsNNCLZdPtYmEl3C1X6G84I/0n0d2LXzGwhvCErEyj2yYeRv3wmPeEeD3f?=
 =?us-ascii?Q?NqoaJ9BleLYvuo+Ficg8kkd6nXVJcZPbAtVkWHEaG0erx0nl9Kve4xFj0AnL?=
 =?us-ascii?Q?utMgf2QXyP4BgEU+UXfpQ5GMaw3xX4g8C+/17RCTDPxQcdOUg+c7jaHqX+9a?=
 =?us-ascii?Q?i3lJyAMYpVI8X8xeD3/zeVsDVpkF3j9Wc4S8XNo9GjavlY9GBA2Ibv9ftldD?=
 =?us-ascii?Q?AThxrqE4S0Exff+9hS7Ld4wrryZyYBE8ttXiWKYZX2RtJDBR56NqKF4rRf4d?=
 =?us-ascii?Q?Uc709yoD9VtnfnMplOMvNgR7X61YSFpymRBb5o9iea+GXM255C0vUhDfObSY?=
 =?us-ascii?Q?X6HozYWS89qQgwqvPuqXMCP5GSGS7DVIBzjSs31fkwxvtYnBZxwbzVvbYNV7?=
 =?us-ascii?Q?Ht06VrEMDQqshF2DV+iBcI3E822PZsXmlu6/MHrncrQRyC0I8MAmkPfXgh2+?=
 =?us-ascii?Q?wreON71niFmUmLchMcwPYT3wA+jKtLuw2fdri2RYjUxd0V7I+Jxkk74651r5?=
 =?us-ascii?Q?7O8xZquSx2mDlCLCtnRWsmIyPEwPCrpu6dHV1cfAjK5/9mo4Q838BJsEzvs4?=
 =?us-ascii?Q?lpetwuPU58XJz455sULD/vu0B04hwdExSkatn9ifpOWhL/WTwdEDXzee+Epq?=
 =?us-ascii?Q?z8FIrbvlHNRfo2x5UGmKWjHeCHZnJP7amE3MkOjxkZLkDERgjryADlp18Vxc?=
 =?us-ascii?Q?bNE3SQbeV1FhBPZap7ECQWY05PMGs1PHgC9XdeY4iX3hAjJtcINRRO1R1w6f?=
 =?us-ascii?Q?Og=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a85019-398f-4dab-6ece-08db73be111c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 07:47:17.2299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U1PZe7fv6m07xrlyoAtHF4p3HzasU7zeN/Nj1emfkghQW/yLh7mosFpImR7hg2RDWU0VTp6AN6stl3eE/ENgCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6918
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds the BT_IO_OPT_ISO_BC_ADDR btio option, to allow the user
to set the iso_bc field of an address at bind.

---
 btio/btio.c | 56 +++++++++++++++++++++++++++++++++++++++++++----------
 btio/btio.h |  3 ++-
 2 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index b68bfb14c..00e46abb0 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -16,6 +16,7 @@
 
 #include <stdarg.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <unistd.h>
 #include <errno.h>
 #include <poll.h>
@@ -71,6 +72,8 @@ struct set_opts {
 	uint16_t voice;
 	struct bt_iso_qos qos;
 	struct bt_iso_base base;
+	struct sockaddr_iso_bc iso_bc_addr;
+	bool bc_addr_set;
 };
 
 struct connect {
@@ -771,21 +774,40 @@ static int sco_bind(int sock, const bdaddr_t *src, GError **err)
 }
 
 static int iso_bind(int sock, const bdaddr_t *src, uint8_t src_type,
-							GError **err)
+					struct sockaddr_iso_bc *bc_addr,
+					GError **err)
 {
-	struct sockaddr_iso addr;
+	struct sockaddr_iso *addr = NULL;
+	size_t addr_len;
+	int ret = 0;
 
-	memset(&addr, 0, sizeof(addr));
-	addr.iso_family = AF_BLUETOOTH;
-	bacpy(&addr.iso_bdaddr, src);
-	addr.iso_bdaddr_type = src_type;
+	if (bc_addr)
+		addr_len = sizeof(*addr) + sizeof(*addr->iso_bc);
+	else
+		addr_len = sizeof(*addr);
+
+	addr = malloc(addr_len);
+
+	if (!addr)
+		return -ENOMEM;
 
-	if (!bind(sock, (struct sockaddr *) &addr, sizeof(addr)))
-		return 0;
+	memset(addr, 0, addr_len);
+	addr->iso_family = AF_BLUETOOTH;
+	bacpy(&addr->iso_bdaddr, src);
+	addr->iso_bdaddr_type = src_type;
 
+	if (bc_addr)
+		memcpy(addr->iso_bc, bc_addr, sizeof(*bc_addr));
+
+	if (!bind(sock, (struct sockaddr *)addr, addr_len))
+		goto done;
+
+	ret = -errno;
 	ERROR_FAILED(err, "iso_bind", errno);
 
-	return -errno;
+done:
+	free(addr);
+	return ret;
 }
 
 static int sco_connect(int sock, const bdaddr_t *dst)
@@ -980,6 +1002,11 @@ static gboolean parse_set_opts(struct set_opts *opts, GError **err,
 		case BT_IO_OPT_BASE:
 			opts->base = *va_arg(args, struct bt_iso_base *);
 			break;
+		case BT_IO_OPT_ISO_BC_ADDR:
+			opts->iso_bc_addr = *va_arg(args,
+						struct sockaddr_iso_bc *);
+			opts->bc_addr_set = true;
+			break;
 		case BT_IO_OPT_INVALID:
 		case BT_IO_OPT_KEY_SIZE:
 		case BT_IO_OPT_SOURCE_CHANNEL:
@@ -1305,6 +1332,7 @@ parse_opts:
 		case BT_IO_OPT_VOICE:
 		case BT_IO_OPT_QOS:
 		case BT_IO_OPT_BASE:
+		case BT_IO_OPT_ISO_BC_ADDR:
 		default:
 			g_set_error(err, BT_IO_ERROR, EINVAL,
 					"Unknown option %d", opt);
@@ -1460,6 +1488,7 @@ static gboolean rfcomm_get(int sock, GError **err, BtIOOption opt1,
 		case BT_IO_OPT_VOICE:
 		case BT_IO_OPT_QOS:
 		case BT_IO_OPT_BASE:
+		case BT_IO_OPT_ISO_BC_ADDR:
 		case BT_IO_OPT_INVALID:
 		default:
 			g_set_error(err, BT_IO_ERROR, EINVAL,
@@ -1571,6 +1600,7 @@ static gboolean sco_get(int sock, GError **err, BtIOOption opt1, va_list args)
 		case BT_IO_OPT_VOICE:
 		case BT_IO_OPT_QOS:
 		case BT_IO_OPT_BASE:
+		case BT_IO_OPT_ISO_BC_ADDR:
 		case BT_IO_OPT_INVALID:
 		default:
 			g_set_error(err, BT_IO_ERROR, EINVAL,
@@ -1660,6 +1690,7 @@ static gboolean iso_get(int sock, GError **err, BtIOOption opt1, va_list args)
 		case BT_IO_OPT_FLUSHABLE:
 		case BT_IO_OPT_PRIORITY:
 		case BT_IO_OPT_VOICE:
+		case BT_IO_OPT_ISO_BC_ADDR:
 		case BT_IO_OPT_INVALID:
 		default:
 			g_set_error(err, BT_IO_ERROR, EINVAL,
@@ -1790,6 +1821,7 @@ static GIOChannel *create_io(gboolean server, struct set_opts *opts,
 {
 	int sock;
 	GIOChannel *io;
+	struct sockaddr_iso_bc *iso_bc_addr = NULL;
 
 	switch (opts->type) {
 	case BT_IO_L2CAP:
@@ -1836,7 +1868,11 @@ static GIOChannel *create_io(gboolean server, struct set_opts *opts,
 			ERROR_FAILED(err, "socket(SEQPACKET, ISO)", errno);
 			return NULL;
 		}
-		if (iso_bind(sock, &opts->src, opts->src_type, err) < 0)
+		if (opts->bc_addr_set)
+			iso_bc_addr = &opts->iso_bc_addr;
+
+		if (iso_bind(sock, &opts->src, opts->src_type,
+					 iso_bc_addr, err) < 0)
 			goto failed;
 		if (!iso_set_qos(sock, &opts->qos, err))
 			goto failed;
diff --git a/btio/btio.h b/btio/btio.h
index e9a8a01a3..516220504 100644
--- a/btio/btio.h
+++ b/btio/btio.h
@@ -46,7 +46,8 @@ typedef enum {
 	BT_IO_OPT_VOICE,
 	BT_IO_OPT_PHY,
 	BT_IO_OPT_QOS,
-	BT_IO_OPT_BASE
+	BT_IO_OPT_BASE,
+	BT_IO_OPT_ISO_BC_ADDR,
 } BtIOOption;
 
 typedef enum {
-- 
2.34.1

