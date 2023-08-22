Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA15EE49A3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Aug 2023 15:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236034AbjHVPFf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Aug 2023 11:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236800AbjHVOch (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Aug 2023 10:32:37 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1b::60a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B588CCD8
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Aug 2023 07:32:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cT3MgZhRlzui9pCTZsm3v0tJLx7PvSAWGc0bQwQxjn68Pv5Ao+9+uI5+sxGXPN0SMircVq1kQU1Yss/KtcR/wzKIpsGdjlfSMT6BoaPyheJ9VdDI/VqsSNpYzJ5LgrkcGAmLY+sS4PqxQWTlgQGT/wcd1cipmguEbQFv01TXINJN3VkshnPSSZkzxTMnHWvC0iis6sD+YoPzBORIAHSPrzdIjXNScH0o5g3ALkF8gQSRLNO46ueC6s1AP2shdhRRR8g+0mzxvmSH39PlzVYZEEmKl7fyXTbnMhGtbB/9ca1kwqoR9pcK5n+yrBxqOIqVXp2smdR7cypZZOnR27pf3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqjJ2ajp34cp4Rrzia79nTVqyNroqrDQQkYBHZpCfcI=;
 b=S4kcsr+4k96TOe8Z6Uwa3n5swJsG4ftAco9Bqj2TUFtbhpLlR/UxmhWB80Oc59s2hh5sZj11apyaqUbqqih6OLgNS3bnqsl51qaqyd5MohfVA2sAbsciXQAAodJANk5uTv9DuLj5D+s8O5J9dgWxiUr45ZkjL/PBi5oEoywDt13ms9iYF2tczX5jk+8DDoX9oJnjFBmQ+8z3xXwoz/O23C/UcIJBmNhIRKFcXK1DPKjWaYpWVytSBpN7t+IgyaP6gvEVIyummNQPAJah5ymrXUIx21Z8qD9x7y5xpIt5FVaoRZaBr6GQxyOF7LL7Xj7UVjyHBgABQXXYIup+EmcsSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqjJ2ajp34cp4Rrzia79nTVqyNroqrDQQkYBHZpCfcI=;
 b=ON7kMGrNVqHWW1T8dg4ukIW2jTZbf1np75hvi7B4NyuIXfLeltKSHAdv/S06ppKHPuOEYK7QGE0tSkPTuJxvqMiP7VuMP/qM/o5Cv0T6zTqeDjGhM/gBxkBflZTppLp36QPBIUsoHKUmTj3LtK/uDYF6qp068JmMTjvb087bs6U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AS4PR04MB9689.eurprd04.prod.outlook.com (2603:10a6:20b:4fc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 14:32:01 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 14:32:01 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v8 6/6] adapter: Fix UUID name advertised for bcast source
Date:   Tue, 22 Aug 2023 17:29:35 +0300
Message-Id: <20230822142935.6016-7-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822142935.6016-1-claudia.rosu@nxp.com>
References: <20230822142935.6016-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0041.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::15) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|AS4PR04MB9689:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c260471-4d87-49a3-1ff4-08dba31c8c4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /hY1swHvVMoHC2VFoaR3e9qS6q50SYLK//jIE2HOMYo1WZShijOUmVHjiOpGapgb/+RtD9QGp9Bad593cQfn64xQrJsUhQW+Drsm7sUS8OP73Rmav/j88Zig+/eGBfnnhT/dpLpT7w9b8k6hWesCPu86PRtVqGz0eexkVSXX1azbsQDoCFmSyPrfAD57cCrKLQ4uAw4+p6Bys8U1P0cFQiLWQMFlaw0NDQYybJurY6EfVroXdLAbNiPDie0uH8aMFlRVK9MEWa/XpLNRVBxmxj53VPyTx1ZtRkzbBWNxixLJ3HOp8pE4P0iAgwmr/k5ftoyrHRyLkiKrziu2wauwugxj9+tkThyLvddu1f8903WdAlKYUWguMCDFvBDy/w1wAqTx24+P9vUNtRbYeV4V+qK6NpoesupoL/GTvGd7sOS0Y0r0OnS//PsYX/MDTZvVISmSWadpLlxjxB+5ofA5blvP4+oAdIQ84qRrIhkUQq+VlFUJxj2BWsGw2J4BbgHO5ASxi8Mlbm6F7VK4Ovcsdbo3/0exY/IVHfF5D/JcVa30HVi0f4lOxOcAmWaRAuvgHXdqWF+Y3bxE0xCK7Mks5C5I2osFlJn+T1UB9lDcF4Pnr0LzFA2H0tpPmGfSXPd3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(346002)(366004)(1800799009)(186009)(451199024)(6916009)(66476007)(66556008)(6512007)(316002)(66946007)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(1076003)(478600001)(6666004)(38100700002)(38350700002)(52116002)(6486002)(6506007)(55236004)(83380400001)(4744005)(2906002)(86362001)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bACsbltjS8D9SBlVP2ysoIy3tfM9a6cXsYvVgWjCO122GfCUkDmstX6t7hoc?=
 =?us-ascii?Q?ZnQch3Szr9eN3jfdtTVmG9ZA7qq7olLVEN9BLZcYuOXqlXeo5oTqKflT7Qxu?=
 =?us-ascii?Q?M9dR9/cPEwSXA6uXFu+xdjDqrsW3fvgr/l/lmHzo+PxL1IeDsZuz/73203RH?=
 =?us-ascii?Q?kh1JyfgkY9qlzeWnPnc2OZbvUCXzqKzFI0V3x1KckCbGoet2sF7VHrNjjW2+?=
 =?us-ascii?Q?LtJa7G5h5J+6MdMvD0DKuiay+4AYZReUvy5rfDDzT9qbSULuOF2/fqIHHpMs?=
 =?us-ascii?Q?kQ+FHkZXyo2SRhTiLzHBVOYbbke29TrBvzDFu6JDqPUZmtKdqP5ZsLgd/lv1?=
 =?us-ascii?Q?y/K99t7P1oCu2acAhZHIGrlAYxqQunnMX8nLne9BHVMwusx2x48gqKuUC0oa?=
 =?us-ascii?Q?NtwMgS2iJPbhm7RUqiqJP534I+k7s2W4GzlSObgeo5byjBrqqokSJ8LPHFNM?=
 =?us-ascii?Q?E1bj90krXgpt36+cMg38u5kK3D0ixgYum8EfxPDoYaCWsub6nOmpjJJpHhPi?=
 =?us-ascii?Q?v4EHxJ8ZohSiIsQh6ioz7Xj8BjO3TMb0OfwI8A9cT8S6j0Vfu1HdQqgFzx+2?=
 =?us-ascii?Q?Ocq/hNDNzZtz/M9X8NesSmMHjTXBJDIS72vEQnm4icpoour8KMrcbsGgQi+U?=
 =?us-ascii?Q?HxIjqr0x8HXe1mseZnP2tBbqAOVUrh2tZNuAOeq0pVfTLbGYGwtxLYNdmISx?=
 =?us-ascii?Q?F+51WOQ+P0chb0lhClboiKXq7Su/0GubvlPk5N9ZREzJkDnFyKl5RM1oEKVu?=
 =?us-ascii?Q?X7gQECMnLiCtsClTyTQqmSN2ZiPJQaE0FSPBDzCeSPZHlHwRQVNn9pwFkuVK?=
 =?us-ascii?Q?zDVdbTYdOKQZtsMnnjlcQyS/CmYjUEB01DseHknad3JBTQfVSNK/jLxdWyF/?=
 =?us-ascii?Q?Gkmr2UjvVpcC9V1gH++639bTzAH1l1NxtMmQ6Ip38ZRa+sJ2zHPvXyRiBlPN?=
 =?us-ascii?Q?F0zksSii8fGeeKoGnoOs6aPM/HPzZF1nEmbdrheyLXLrQF1yUjuwfE1BlK8U?=
 =?us-ascii?Q?tj8YQejXSwVL9P6sfKkQpuHkmIBR79ObfjlAdb6qU2RNwEGw9q56/j4InPgb?=
 =?us-ascii?Q?hImn1YYjAstQMT6z5HSbizT8yMe45YKztSBS35RUFfrKmS55eXqZQ2vjaKAu?=
 =?us-ascii?Q?RwZPEfY4YsnJDSBVH0jFw+ASuCYb/InAWai0XcamGkJtDfxKZuWmnQsUjvF6?=
 =?us-ascii?Q?+fHQQ/vhokmKYUVL57alYXgJPIgWD8AA8XyDUdkdRwcorsuIojlglbB0IzbT?=
 =?us-ascii?Q?FiTCGLNT41Io99TPB6GKgTzJWknVn+SiVj/8b8p5/U41du27Lq8utNaPoYMu?=
 =?us-ascii?Q?/k2SBxn67IjTOpb4sWfX2g9HaSDv/Pw5x3xZgeehPgcEnEPSFboSDt9UMhmT?=
 =?us-ascii?Q?llGl42NlZi7+6+7JBjtKYc/wA68PGYJVbCg5l5UbOC7MFjPR7mT6fM9H3/q9?=
 =?us-ascii?Q?xsCAZo/2oqyVkqD+rOAlCtM1lIqOKiu7j74WIIuzDxAuU6ktdFjWNdv3F+oX?=
 =?us-ascii?Q?YSv0pm2Pa1fETr94qs1dizgstG5kesY0SlXyrI9hajgRb82uHrB7qwOsICpj?=
 =?us-ascii?Q?4mzTX2ad36jeYo/eKl8A6BKDBOXS46Ou8l01O3jb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c260471-4d87-49a3-1ff4-08dba31c8c4c
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 14:32:01.3415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sg02GThzOpQ7SFjI8I4MozfCpbUPYjwyBSTrLuhHguYyYNyOB3cysZrifSlD7AFhjGK8LcCMqDyUCPZNqAWu7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9689
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix UUID name typo.

---
 src/adapter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 004062e7c..f2f53d339 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7155,7 +7155,7 @@ void btd_adapter_device_found(struct btd_adapter *adapter,
 		/* Monitor Devices advertising Broadcast Announcements if the
 		 * adapter is capable of synchronizing to it.
 		 */
-		if (eir_get_service_data(&eir_data, BAA_SERVICE_UUID) &&
+		if (eir_get_service_data(&eir_data, BCAA_SERVICE_UUID) &&
 				btd_adapter_has_settings(adapter,
 				MGMT_SETTING_ISO_SYNC_RECEIVER))
 			monitoring = true;
-- 
2.34.1

