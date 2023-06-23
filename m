Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A58EEB64D7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jun 2023 07:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjFWHqe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jun 2023 03:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjFWHqd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jun 2023 03:46:33 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2E92708
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jun 2023 00:46:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKwirScXJcGopV/88S24SySUZ2S+QFRty2gWbCsI3FshNPqkvSoU6Uq5/w1zMVArYxWquTm1DjzV0sdZdpN2sdOKa9/vFbvS9+8++jQrR0s4+0dXJLYzrWRFxLOX24My6BHvSEmNQdz4qy39Nz3dgiluVUqI4u2ikvZYCoJ0alPNTmJBfm7zzMfjwyyeZNeN6O1cxY2hJOupErFM/GGal78WZ6Muw6Q42zQeSpD6Q8PalsF5uNKUS750GgVQ1ayOfg51gEISP/vC8mlf5v1RWi3sMhR6i+hMHL4Qcjem+k7fhUhOVXnVzt73NoS02fiEaGoci9Oc3hLqAcZQLsHw5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Z5GRkItfMdUCvbAE+d0NrlxO1TM+zoYwMO8xXhHVCw=;
 b=UIZTo0mhOLU232Gzr9l7RFvXfIAvE0YwkK7QF8b9c8vAq5DquDcGZZXuhsz+txfETLkao8ATgUH4XmZbz68J3etIwxNpOkMiNbnfEa96TujgPqzjAal/Ge5h+e12Nq5yYmbko2btnKaW6eMOTruC/bCWD2ZHUHKC1KvkpbTHBydZ29SWtoNVCZKwJSZH+9vCh1kZhyTbkjw7+W4K/D1cxAU+cy3jpKMiAgCinBAprycqf5ihbv346ntISlJQsuwgKpu0iR3LRY5Yc/H69SM6QO8xbXuL1edCS3Jrv9rLpX185oMQKtWn64yUCDl2+WoO7egWO5e+elO1puT3bfHbMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Z5GRkItfMdUCvbAE+d0NrlxO1TM+zoYwMO8xXhHVCw=;
 b=SlvOByC88YlJ6/KDy/16mbVov+hzFsS+Ls+rlOCxAWZp+hYPtwjeCGUt5hk3kNG4xX8hS7MguRehBw/zYNxcfdEgD/cCWPeiY++Fx4HKfmyQCtwSfF0w5eIDloXhjRrCVOGy+aucZpKhzO/TK2ZSalw503KCdpEEm+jDy8VJcLc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by GVXPR04MB9925.eurprd04.prod.outlook.com (2603:10a6:150:112::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 07:45:08 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe%7]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 07:45:08 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/1] isotest: Add check after accepting connection
Date:   Fri, 23 Jun 2023 10:44:06 +0300
Message-Id: <20230623074406.16522-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623074406.16522-1-iulia.tanasescu@nxp.com>
References: <20230623074406.16522-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::17) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|GVXPR04MB9925:EE_
X-MS-Office365-Filtering-Correlation-Id: 294f33c5-8816-40d3-2e8b-08db73bdc499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C0To9bcoQtehhdvLpUrWExulbtFHJay0cpDBefaD7NVXHH97Wv4TtECCquMzJke2Ts5qTCB8Ij9G5KgT7RIatlSB0pVgWjdYfBmNPhYSY8YIr57/YFZa32iIjtQOpsh6AZGAB6YW+E12YV2bhioYvV1+gMfWQjX72dJiDh9hwekcBZ9lx1JeGdIgqAVPsMwMRva3znit0VTwiLkzYMqJCx8nWWF/KqteYe0I8T8eqi4+NhJPPU5uRylmsxnwSI4byiCEfObrJJGuPNedARo8qnOmJQDLQccBoqAgbRHrb7xmf2zEdiPJQbERyrXcVtSx6UE4oIaIBVfXVzoX8vqy/jYVdNap41D1xI1q8R1z1J65of2ypTAQCdEctSydRMgpzvMkY6SBSNmMFLEj3ToJFcLNrwsGkG4lS+PFExnju83Utv20JvDQBuphhfCCW/aJVjP4lEx2/4c1xp2m7S1URLkhTbbyzPT0sZFL7SHpxGf1H7KbIcnahdVM4kn/XWwpOyYxfgYZ6MM6pkxVnbfrubnisUaiD7jLK4GRcVC5oN0tNYumijvD5UMiPy+AVzMhqeZXL10wqiBgMlqneNB03KoKHkg1LcaUB1le1y7VQGRZWBg1nJaD1ndG5fk6mw4Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199021)(26005)(1076003)(6506007)(6512007)(186003)(2616005)(4326008)(316002)(36756003)(6486002)(6916009)(2906002)(66556008)(66476007)(66946007)(41300700001)(86362001)(38350700002)(38100700002)(83380400001)(52116002)(5660300002)(478600001)(44832011)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o4I0/vdLwqiidNvhb1fJIzR7usYA0esG9mBkANVjA4HiYrlJnLSqLPjDTWNd?=
 =?us-ascii?Q?hH5QFrQV8AWbyMxuo6C6K8GciTRO2RTrJMf72xjm7M2R52/IoWIDX4FQUo3w?=
 =?us-ascii?Q?Wd6RJtRf33lH4kmomingUFNU4X9FjhqASjL9J27dtM0EQPcdBKegiTLoHb4q?=
 =?us-ascii?Q?rIKc2Aaz0VANVh3SlG7jJm+zJSSKqEL9ovGiC3ykrUN5GWgifPNUOfFNgcZ8?=
 =?us-ascii?Q?/0PkAyBoLuD6PgQzPCSZ361wqusHNVKry06B2zLj1TZOtfvm7VTvf6hL4OBC?=
 =?us-ascii?Q?u/U43arI5jIhQhZ3ReIokZrr9hfb90BmTX2V15Pk3l5C+Ma9fiN0qKS7/XDP?=
 =?us-ascii?Q?ftn1wos5es1ZMnX2sbeOahBTjwk7nqtSJ7Nqxt7fBfhvCU0uTqMv4QO2l398?=
 =?us-ascii?Q?dqly2cifpws3aGLKNytXV4/RJSjbQkG8meLxczmxoqOU61PEPLiMciB3rWVs?=
 =?us-ascii?Q?IHuAmZjW+mvziPnjXtOiVr7mxVWRjtd9dzl/veRy75eusXhiCPiXE95q8m6E?=
 =?us-ascii?Q?96FUSzSRgPEMRoMCuXPOPHebiT4KTN8uOOxTYZ8kuC9LGuQELCt8W65NgH1q?=
 =?us-ascii?Q?0uY59ptLy0GbYtNEfQhS3+dUWSn0dHk+Bk+SF8ZT0w4y75VzlWUWwpGWpBS7?=
 =?us-ascii?Q?XMflhtzLZIk4Mgp5CEgVpaIQ8yN74nimFCAHGVln5YQ+u+LC7/w12MorTlRc?=
 =?us-ascii?Q?BcjWxTmTHR5NaRCmkpv0Kcv4UOxGGXYGVsDQ5ueTTO38Bd4ujLmAgj9IvANd?=
 =?us-ascii?Q?eHqYnH8zpksFNygs+qpHo3NMW/Ji8KZheMUMTQDJ8S2DCnD8k6aVnmz2jywI?=
 =?us-ascii?Q?j+ezKfybAMVqjuHZp3zyPcoigar0yFMVVgbqLFVQ+zwIYvCA5dYj6h98AQKU?=
 =?us-ascii?Q?nZIZl9+te8HTUpPnBj3k2D3qb5+zEee7hG/QqdbWNoJjobuInfFeA2CVaV5q?=
 =?us-ascii?Q?tWA8O17su6OUyYz5aECMfU0DehiHZAS4o9LFKNMDc9fZg7uSCK8i63Lni+1s?=
 =?us-ascii?Q?h31le6SZHTPHacNFPIfCgNuhUTD8ewwGUwbHZ70j7ZzrzVZ9Jye8SAZxTgSn?=
 =?us-ascii?Q?Ag4Oz62Gv9T0d4SdUW+5WtWOVMlK2Udng3D961FwIWxMJ0uKTef0fAGDapgb?=
 =?us-ascii?Q?CTsHsHY+tUdy6qR4mc3aY11pZOyWn2sozkP3PL8jPH7DL+jDB7pnF+l57Php?=
 =?us-ascii?Q?p3YBy6kJXC+NdkPHcVMAggEFlbOONcwrb8HaNgwqfJTLuNPPrfsX/JZBSOhR?=
 =?us-ascii?Q?Pg3KqPKL+DTOutTHr8ete9xRoz2NkqbqAyHjz2xdH2mmzQ9C1DpaDOdFWB2g?=
 =?us-ascii?Q?Fs8tB39l2nuVMVl4VRJdAesXui7M9DAT5FfJ8y1Y6DAsPjB299Qxkpz9Pczm?=
 =?us-ascii?Q?2yY6Vnf2yPmoIl2jtFWSWSbtTcwrpIKKX8PhAxygZxbXOq8GAop+7UCdkzdY?=
 =?us-ascii?Q?AHCFXmtU4N9zJ7qr6qAmiyfAJePmbV9RJ1psyJx53eV0cBpsG9neGJTQzGSy?=
 =?us-ascii?Q?18vNK2/ildbD/BgXy3acu3Ed4QbAb0Sk7ynXnEDtyXej87aSOkyLrLoOXFQD?=
 =?us-ascii?Q?bRfzy9RvQFa+6IewncmRwo9K4d0HCg003H9ifnUcTd5b/ARmHsc8d1YPGoSm?=
 =?us-ascii?Q?iA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 294f33c5-8816-40d3-2e8b-08db73bdc499
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 07:45:08.8161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cNGM9rCt1tHbkiuAFlsywXsLih3wLjeA9wKC11QcI01JT0VwuIjxcwZPV4XD0taMUrMxD4SnzjQ3y6F0BMxoUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9925
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This checks for the POLLERR event on a newly accepted connection,
to determine if the connection was successful or not.

---
 tools/isotest.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/isotest.c b/tools/isotest.c
index 0eae3cdc1..c71bc6fa0 100644
--- a/tools/isotest.c
+++ b/tools/isotest.c
@@ -33,6 +33,7 @@
 #include <time.h>
 #include <inttypes.h>
 #include <sys/wait.h>
+#include <poll.h>
 
 #include "lib/bluetooth.h"
 #include "lib/hci.h"
@@ -440,6 +441,9 @@ static void do_listen(char *filename, void (*handler)(int fd, int sk),
 	socklen_t optlen;
 	int sk, nsk, fd = -1;
 	char ba[18];
+	struct pollfd fds;
+	int err, sk_err;
+	socklen_t len;
 
 	if (filename) {
 		fd = open(filename, O_WRONLY | O_CREAT | O_APPEND, 0644);
@@ -529,6 +533,28 @@ static void do_listen(char *filename, void (*handler)(int fd, int sk),
 			goto error;
 		}
 
+		/* Check if connection was successful */
+		memset(&fds, 0, sizeof(fds));
+		fds.fd = nsk;
+		fds.events = POLLERR;
+
+		if (poll(&fds, 1, 0) > 0 && (fds.revents & POLLERR)) {
+			len = sizeof(sk_err);
+
+			if (getsockopt(nsk, SOL_SOCKET, SO_ERROR,
+						&sk_err, &len) < 0)
+				err = -errno;
+			else
+				err = -sk_err;
+
+			if (err < 0)
+				syslog(LOG_ERR, "Connection failed: %s (%d)",
+						strerror(-err), -err);
+
+			close(nsk);
+			continue;
+		}
+
 		if (fork()) {
 			/* Parent */
 			close(nsk);
-- 
2.34.1

