Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3913EC873F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Sep 2023 15:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjIGPmc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Sep 2023 11:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240389AbjIGPYP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Sep 2023 11:24:15 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2073.outbound.protection.outlook.com [40.107.7.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC39819C
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Sep 2023 08:24:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IE0b717fUDReDilsf70M1Gp9YUNv36fufdvY1r/eFkwJES1cqiXGfOOjB3o/8noZWZ2JyZL1STziFKS7hR4OLB1gpQ8DXPZ9IE75dphhZwvPMuSCHHBCK9z3XoeiQJ4KsJdiye765Mew72C+zflIZs/dT1W7Cfm6852tpt3II/z6M1m/Pi6fNjC5LmlxY1kxZWKJUGFeyEFQGEEosCsC/7aVFIr7YAZBg/vj0X12eDgbWep+9xWQbov+bAGLQwsqF2+05L+tBDsXUh2+wfQSNDdIkwkq6sTaF+FUxy5AWsIkvL1bgp1koIzOOXna+CbVzqFKc7Y4w4IDQAXMxf/W9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTFygz+BDL8tnpjC5ZKbhoNm4dXQ1utYN8z3DpGnhk0=;
 b=dd9NuNG2/St+7Xt0qqVEon7LOkbh5BaKMbRbJO/I0sI+8jm1xCz8oIvSktH7FVPrY/D4GaZ9+O0r3jZzgzIzSGcnCaszSmHmfk6hbNcnkDgGE4LhO6eZ9O52qihjRt1Dz9azpxJLLC0TlYiXycIWkEiNyXAhsV6e7GoXZ/x7/hKv//9CoIEWl5SAxuBXk7p2NefgAQb8S0zULRhkIN/p/GLwc3p/ftwDvyt6cppSNTFxhS3GnYg+C6n9E6h8uM1+gTtKNLkEfZIhl9bkydN4NQZXEAqMPaV3QBgQDl2/H6LhoQEHeZlYzB1gQHrz8KmaPUrn6T7ZJ5yTSotg052jjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTFygz+BDL8tnpjC5ZKbhoNm4dXQ1utYN8z3DpGnhk0=;
 b=QYslRFgb7jJkr2fXENhcST9DU9ixLCcKS3/s1JcIfw3iUKE14/mlYNg1TQorhjTdwq4AZdItwyTDepNI5euyOzfbsgEvn4L4IyRlN1hx4pTpKrgjgy/eqepoN/oE5yZpB6QHMxvlfvGlrY7EWOm6fFU6aFRcIXss7Bwd4bBjR9U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by GVXPR04MB9759.eurprd04.prod.outlook.com (2603:10a6:150:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Thu, 7 Sep
 2023 15:12:53 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 15:12:53 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/3] btio: Add support for accepting BIS after defer setup
Date:   Thu,  7 Sep 2023 18:12:27 +0300
Message-Id: <20230907151229.7306-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907151229.7306-1-iulia.tanasescu@nxp.com>
References: <20230907151229.7306-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0195.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::32) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|GVXPR04MB9759:EE_
X-MS-Office365-Filtering-Correlation-Id: 71b37be8-0057-4f07-a685-08dbafb4e895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LHk3A21Hlo7Gko/lAGf7BsqjKUOMIwAdwoemQCM1tWqvvtoDx02zY/0c/OZkxTbguMbjRbInx+6uPicxKqIiCGe0u+ef+GHYwCt8oS+fv5tzS0Vj9cV5ArIQ72zlCZWy0UlqIEO/g9LWsiML8dueQcEBO5yKq5VLLH3+dJjJo8nqwN1ubuO89giUUXp/mnZVuF2at7GWUTou5yLa/0XwqL/9/XpEVYB+pOROdD1rkXrP2Nyww4PFvwY4EyA5JVFsDXZh5HG1ZlZw6EI2PTvalE5nz1opMibasqJgEL95fxB+xztTn4DOa/KcaXeqt/+28EQysILoUWCnwSz/7Z25+xcl/R4dVgx+fqheTNs4jFdJpM5/ghvnHhzsI+5rpDEvevlV+zYHsQEUl0wRwPby5JOxMsT6OyhAdL2kThdghI89GJymWyPH0kymXufn7Cn6SUOLEB5SExD4iszhB0LND9rO9XTos5ufb1FKWDvQkaM/m/t+w26oFgfvjwgq4LCvkYDf9t99m3gzoXXNUwkafZvkrTkp4R66lXxVrPYTUA9jQYljyQKBy5naOgx+cPIZE2qV3yqOIr7OA22quAUK9jvs6XK0BgKQFNWNX9nwtnRGvSeIn1q50woW79scEuTs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(346002)(366004)(376002)(1800799009)(186009)(451199024)(2906002)(36756003)(38100700002)(38350700002)(86362001)(55236004)(52116002)(1076003)(4326008)(8676002)(8936002)(6666004)(66476007)(44832011)(26005)(5660300002)(316002)(41300700001)(66946007)(66556008)(6916009)(6512007)(6506007)(2616005)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZxMzVIzBDAMp/PoIWR1Qg8HC9QufyRdoacyndbhl6/3+yHHeQVpko4/5zwL0?=
 =?us-ascii?Q?otfG63Hdabex+2SoOmH84ERGDCL+Z5GbTsCXl3rXRN46PDyXbC+nwu4aEinq?=
 =?us-ascii?Q?CbnT5f+MgOgUMy1i6m2s8Zk2Bvy6WzHzafqi6tLfpOp+I6NvAiMZgNCYmOlb?=
 =?us-ascii?Q?BZBoA4ysXKyd9bmftCd/04Z+UCMEL+xzyOsbtV8cB6OMx/IpbYFXLrgel6EH?=
 =?us-ascii?Q?OKqmiGuHr/e30RlSV9ZV92zNSIryL2eSpVryITeg4BPHCWC9bAwF8dG5p2Gc?=
 =?us-ascii?Q?M0x6/yTTkAJamArCe6gQjb6oCOB4L5ktBiAOgfthBHf0yA0o/NlmrfYaO8qN?=
 =?us-ascii?Q?5ht1tkoK3rp+0OVAfDaoIr2/FYeyRiyjmjcrDmBmaIRjGXZh7K1t41S6lg/f?=
 =?us-ascii?Q?02RkvgM28O/UvnLYSPWMDDs921LDDC097YF0j5V7+K9i7s23Z6TSHvTCQgnT?=
 =?us-ascii?Q?gHyr3iKVjXI11rC2Qjv6E3SxrzxsRUnXAbHRc2UbgluD02oI7YOWTfRYQvm2?=
 =?us-ascii?Q?YvSjohns4jWp1nYDSZOTrm5+7Imt1jN7jgZXU3dK2WcGKH4mr4Y2PZb6NbOg?=
 =?us-ascii?Q?5hWRgf++IVmA01rgIr52dMupIYed+iwDVeobBTWtwH3ZY69KydQF2VT7nkyD?=
 =?us-ascii?Q?6NV8MvOfpnKW1Ih5hSANBazI6orCKiZCpn7q1VuUHqyN185F1eJH6W4EBsPf?=
 =?us-ascii?Q?MThWopH9Kz0nkEBP/r6oPRdEKIc3J4gwvo914UYxNL8LyhoLecxxnV70Zaps?=
 =?us-ascii?Q?5dLsFYc5EMOgaw1+gCRzxbLWAKfO48V6VfHcxwNe7a69fnYpJvWdKbKL+ukI?=
 =?us-ascii?Q?JkiBDaR1cY6xK+p95ZhTlIKYuFMVICF2QfLTC0cdiZ32CWUNGqM56yNbszx1?=
 =?us-ascii?Q?OcacTKHrUWrmQ3MU4tUvcQsaAp3UoXVrXoyGyLhdD+Cbo6kQ5trny5yiBVho?=
 =?us-ascii?Q?1f7YK0OliY+WSbjgLyc5Dm8NWwhtmlAVL5bAsq4I41X7YtISHzHK29lmor7+?=
 =?us-ascii?Q?jZzV1HPlAE8QGCkoIL5hgxhrSbDqCoZaKR6cSrXNYNX8dsWKuVlf6xahFnQ+?=
 =?us-ascii?Q?LffNdETQC+KJNu49VYq0x3avCdPMayf6A1Fy9DI2FeRK1eSfFVUwWvdXo6Zf?=
 =?us-ascii?Q?JqH/eQcm2YgN6cO2cUOGceoTa1iW2tcBlWc6wj82ZcnYPmJzlZG7ub6ZWYCT?=
 =?us-ascii?Q?u2Sy0m+i0ojxPXZ3nwx52Zqbn80PT6mTfhpq+F5zPXECmjMbGWE6jeTE7cSL?=
 =?us-ascii?Q?TSZXJMwom8x36Cl8OoyCaiyZR8DBiSxT+gNgQQg1m3fOIa/T4GhPrXnQYxED?=
 =?us-ascii?Q?1V7NKZdQbjkqDXxOHmyExP2Z5xdo4oGrn5RfVd3ZGHL8E5cx3k/hI89wz+Bo?=
 =?us-ascii?Q?X+nCZiU2ipf5STUeWj2spG2y/KG0C6On8beCCxmvwTe2M27fL4pSTfM0oCzs?=
 =?us-ascii?Q?4jGrrSTXRHrWfJtGjy7o4ZDv9BQ323F6Sa+pMzvc6tV8TwVNBJHBUYKBwJb8?=
 =?us-ascii?Q?6/U21c21Md4V8zbnoHg3TMmEnuVrYdux+ZaYmvBYsz6LD9jgPZKaSi+LsJvF?=
 =?us-ascii?Q?T0xF+5M9BhUHSiH+J4fDa4177jKW34rPWLmYPkQxsvrlZ70vsaFKS2BRuy26?=
 =?us-ascii?Q?4w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b37be8-0057-4f07-a685-08dbafb4e895
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 15:12:53.5374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZKy4j3lfW12qZ64TRc3rSA0ZRgM9gLuJJgMF91XT08rUWM9KQLujas+HSs+6TnToLfM+AHMNsIXCiBim+O/XAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9759
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds btio support for accepting BIS connections when defer
setup is enabled on a Broadcast Receiver socket.

---
 btio/btio.c | 31 +++++++++++++++++++++++++++++++
 btio/btio.h |  4 ++++
 2 files changed, 35 insertions(+)

diff --git a/btio/btio.c b/btio/btio.c
index 8d9959038..c6d056b89 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -1789,6 +1789,37 @@ gboolean bt_io_accept(GIOChannel *io, BtIOConnect connect, gpointer user_data,
 	return TRUE;
 }
 
+gboolean bt_io_bcast_accept(GIOChannel *io, BtIOConnect connect,
+				gpointer user_data, GDestroyNotify destroy,
+				GError * *err)
+{
+	int sock;
+	char c;
+	struct pollfd pfd;
+
+	sock = g_io_channel_unix_get_fd(io);
+
+	memset(&pfd, 0, sizeof(pfd));
+	pfd.fd = sock;
+	pfd.events = POLLOUT;
+
+	if (poll(&pfd, 1, 0) < 0) {
+		ERROR_FAILED(err, "poll", errno);
+		return FALSE;
+	}
+
+	if (!(pfd.revents & POLLOUT)) {
+		if (read(sock, &c, 1) < 0) {
+			ERROR_FAILED(err, "read", errno);
+			return FALSE;
+		}
+	}
+
+	server_add(io, connect, NULL, user_data, destroy);
+
+	return TRUE;
+}
+
 gboolean bt_io_set(GIOChannel *io, GError **err, BtIOOption opt1, ...)
 {
 	va_list args;
diff --git a/btio/btio.h b/btio/btio.h
index 642af2e22..3169bebf3 100644
--- a/btio/btio.h
+++ b/btio/btio.h
@@ -75,6 +75,10 @@ typedef void (*BtIOConnect)(GIOChannel *io, GError *err, gpointer user_data);
 gboolean bt_io_accept(GIOChannel *io, BtIOConnect connect, gpointer user_data,
 					GDestroyNotify destroy, GError **err);
 
+gboolean bt_io_bcast_accept(GIOChannel *io, BtIOConnect connect,
+				gpointer user_data, GDestroyNotify destroy,
+				GError **err);
+
 gboolean bt_io_set(GIOChannel *io, GError **err, BtIOOption opt1, ...);
 
 gboolean bt_io_get(GIOChannel *io, GError **err, BtIOOption opt1, ...);
-- 
2.34.1

