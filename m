Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2F1C41513
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jul 2023 13:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjGYNsT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jul 2023 09:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjGYNsI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jul 2023 09:48:08 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2081.outbound.protection.outlook.com [40.107.6.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354D4A6
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 06:48:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Inr9dIYMyDNs2XBjh1oDRQaT/o0phLojmTG/4nUlNB+gGhT/WgPnOfb0ftV4wSFVVoVUsF2A4c2+VeEZVD47GGGMeWreC78JanIbrPkysrbRCDMiQyOP1SYTQI80Ebp25BfO4hTepxJuy1cMVeRCJ6l5ZthmPlJlBsskc6dQndMtujuw5RzP5YxVgdJlsrFjS+CaQdHnLpvn6mw4rWcniiK/Fngv3/t8r5673MyWkxV2J/ktT4Ux2MZfrFu4NjrCWyjkWX+4e927tI0DUH01d1hdoti5CmFULcdP7JKxCiFZHROPmISN8OyFpPggvFTAFBqO17EYBY9Cv1+HbrkNXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5e+kH7jbavEfXy2CI+FXctgAclZYu0bRugEzfUjGJ1E=;
 b=FiA1XHYm6Ip+vwQWoD487S6Da090+v2JKzKGDx4u7ujnKgHDeZqxoaXNAeOt7zRshEnxjrm7KkbxT6kiTI6VI5DfQnMj0imMdi2JUJ0cYVFamc4feePpBf0cKkBzH0+plfgphuVjzgRVhyBkGGlKP/E6BYxQUKn2bb2Nw3kNdOccu4mZmD4vW6dore3g835TIVWF50bbLTIudSfCZIzjrYnhtLJW0gVr9pprZ7MQtJnUliZdNqzFbf7vbwWYcNA/CGlojj7tyf+nRWWD0HmQDqP9InPAOBcIWFrhUnBgtjG4N3MWHxXwggswoHq5Tr7maqzGoLjY+T82kCuHds4c+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5e+kH7jbavEfXy2CI+FXctgAclZYu0bRugEzfUjGJ1E=;
 b=UJJXfWBdW/DNK/GfWhUc5utjuKUXgQZABu/FYCGhEjuC3bwLKZbc3qalx5J9GP50WlqZDXu8DefkNMCkJyUCwKt72jzTOuIovkZbp/MyqZ5joLOyOvhDsOlhqZec5m84T5C8MUPX8r6YIqZabdjQbUvHiL07lQTq5e19COEntwU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16)
 by PAXPR04MB9593.eurprd04.prod.outlook.com (2603:10a6:102:24f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 13:48:04 +0000
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::273d:f528:aaa9:288]) by AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::273d:f528:aaa9:288%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 13:48:04 +0000
From:   Nitin Jadhav <nitin.jadhav@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devyani.godbole@nxp.com, pav@iki.fi, luiz.dentz@gmail.com,
        sathish.narasimman@intel.com, nitin.jadhav@nxp.com
Subject: [PATCH BlueZ v4 1/3] shared/vcp: Fix the crash observed with VOCS
Date:   Tue, 25 Jul 2023 16:47:40 +0300
Message-Id: <20230725134742.51651-2-nitin.jadhav@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230725134742.51651-1-nitin.jadhav@nxp.com>
References: <20230725134742.51651-1-nitin.jadhav@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0037.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::8) To AS8PR04MB9126.eurprd04.prod.outlook.com
 (2603:10a6:20b:449::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9126:EE_|PAXPR04MB9593:EE_
X-MS-Office365-Filtering-Correlation-Id: aa9e3cd9-729e-44d7-271d-08db8d15c556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: odQLTL3MDOQXJwXtau4iRgPdjOc8PcPBF8GKGas2haOuA68CIfLUnIw7A6GThEZE9bTmoAgIsIB/YYfI232pgjX/C2elSQ90ibMqBxD9DXGKw3HiZSzA4EMYFS6DMxFvcbHuScXS87B5nezxgHzDtdSwq1AxPhpwzwhmDj7xsI6nxMyORwgVBIwBiWUjW3INJUPjDKOycbOh/U/D+cppuWkNP4IYiR/nxulvsSQjFl9l54dvTo3qjDSHjRd+q0EXUOsvso6qGEt3Oq5v7AiceiG/NKMA8JOfIJ9ttANYc8ExViNNkfosGLVktqX4vVgVL8z6XO1eT+nCewYulaheSOABgvVxeCSmiMtXcwqKxcy6/RM6mBbHscv/5YvDIySYlbYmzyhWukmtH8GlEBUEdeHokucuMkuVP+1o+PqcAQlMOydXCYBnS6cunm3SmljIWaMfOsQb2mGUWY25gH46NHi81mvKqSbCAvls2j9gNgpX/GJruc9kwTROLFWAGvqXxyZgQIbuvGO8wio8BJYgKxaiiDLzb5gU4HYVzMx3XTYLuWvrFwKXLXGN3Y/h2H/+B1Zc2tstBTW2eJqHp3P+Et59wisHD0YDHI7BEUhiR5Q/PGfVAS440xdLjJSVwSfw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9126.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199021)(36756003)(86362001)(2906002)(52116002)(478600001)(38100700002)(38350700002)(186003)(1076003)(26005)(2616005)(6506007)(55236004)(5660300002)(8676002)(41300700001)(6666004)(6512007)(44832011)(66946007)(6486002)(66476007)(4326008)(83380400001)(316002)(66556008)(8936002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bwcdMmKlUP3dQVzzOo1CF8RLf8gAYBOZ4zBjxSN/VcGHJQyRdo5k/kNud7Fq?=
 =?us-ascii?Q?0hHjY9jJug8RZNbe+bL3whH0wwDiFzHo1l6Cqg5JmToxGVmUTpzAJbpj6dg1?=
 =?us-ascii?Q?9Cxyp/VWqiT1ofXFFCdvybjX4vorj8JfdytqrlQOtkfSczahX9ZtxpPpWA8k?=
 =?us-ascii?Q?8Vztl8zxlpBNk8duO8H4dq8f5t17V+f+UrFBhV0YHDCJnllagPf1XYH7nV2N?=
 =?us-ascii?Q?g61rVCE8DO4eAT1syjtoQuhHv2kiUkQvfHaWOBoOAKU8gWyyykfiJEpmDIUn?=
 =?us-ascii?Q?zZnX3XKV++r5GxE0S5Oas5Iehz41f/G95rVL3MBURPDS8/DLJrjNRizkrqhg?=
 =?us-ascii?Q?SvOdbK8a1UoQ6ft6RYdk992IW6LWF0PrO4R6MKiPIcK+KzJglsHCm+WcHWQG?=
 =?us-ascii?Q?NwdRNRRJaAXkp6GrchJxKi3qk2ZPA6BeDZrATMjZg75r4DiJ1GNKoETl1VuS?=
 =?us-ascii?Q?cns9Eex7pDbQiFPuuwzpufcKJL/6WX27fdFSIfgY6yXZMQeP1gRkO8++mnuS?=
 =?us-ascii?Q?79/gPJTHDVXfiVcUALZa2e0TqMy6ziqsoGbvsYsfHmE4R3EiBDPKsNa3b1k9?=
 =?us-ascii?Q?BfaE+FMvj8Krlsd62TDGB6JbKwl2/M2fgf8IKuzCXCW2opgfIvmrieH62WyE?=
 =?us-ascii?Q?eZP1Dd6qymjiwecD4fjCCBnd7+C9U7VmMHglw2etDe3Lp1Ho9kyD7szW2s3b?=
 =?us-ascii?Q?GBaZJGxzkG91yYzChpcc1JCHPQPrfQlSEbuB+9IpStdAGhk2uDQYhesnOZBH?=
 =?us-ascii?Q?PgTrunx40h2Grax64MGgghnNlsjcWj6yCTrSw+Fvip6N9fJMCo7bhyWTRsxG?=
 =?us-ascii?Q?5RF/93gsvQ69xotTMqFzoroF2WicUVIm/87AO2G/S7HtvvotlqSSY9+Hc2Ep?=
 =?us-ascii?Q?dwEr4s8Oo7R9oQk54TsQ0K+zDFkMcOUDEZl65625tujhqhYzayOt3RFUIn0y?=
 =?us-ascii?Q?gqThtP9BmLfSK4LTyz+1Z6lETwBpLCVOLwN/uqFmpLXAIJAtJbSemRrJeTDt?=
 =?us-ascii?Q?FvUbco/rM4h3tVI7F+T7IRwilPmyBrwvABMUIR/xr3zhhnhUd4kPQRBa0qyS?=
 =?us-ascii?Q?2FAPI11nw7gvzNm3GEbHWi6Nto+kAQkpUSWG9fBFsFFUt3QudC2o0KJyw7mV?=
 =?us-ascii?Q?OFcT/i8IMGszogfeXQZ6Y0G0oQ5AB7esNl/2t5gPljnfX0z2oIf5ocDiftnV?=
 =?us-ascii?Q?I1cBc+ALULP0SWvunPQK8HTpFfHMleVDY3Faa4soyKqW3rVCRwahQ0BOJoKv?=
 =?us-ascii?Q?VO+nZ0Jitb86NIKMWyBgo+sDqsXDqOEvBcdF9E5ihxxSclkjRtW8rNoGiex+?=
 =?us-ascii?Q?d4Zx7L0fMXT+fpsSLP9yTQIsWOEjVt4hjCrxT51dAQ2YZLXb47S0on3ONDoL?=
 =?us-ascii?Q?tnz30m7/5r1jdqPUJ/GVIArh0di0v1rWAi3+wA3JUUvaDahX+T18+R8KGGPu?=
 =?us-ascii?Q?xSu/F82iCgWiZ8rRU9tnjju31Ea4VHIfkomoAFJf8zQv5ed7j+0XI1x7xFdQ?=
 =?us-ascii?Q?lG9vvY270NNme6Mlk2teIUO3sKkARv2HMKiqmNr2yKEA1qH1b2JoodNapzNP?=
 =?us-ascii?Q?V8JCDDM96SDSSviCQDZPC1y9jxBbvwf0d4aJaBTu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa9e3cd9-729e-44d7-271d-08db8d15c556
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9126.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 13:48:04.8423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a8wWlgxVvvmn8qd+F+ovxhb6we7sZGODHWM3rIl9VziPiCiqmFfwYrWU2UeyTnD1bgowVpJZly5uQLcw+YvZag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9593
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Root cause
- There are two types of database- Remote and Local (rdb and ldb).
- In client mode currently the code was written to access ldb.

Fix
- Correcting it, to access rdb has resolved the problem in VOCS.
- Same correction is done for VCS.

Reported-by: Pauli Virtanen <pav@iki.fi>
---
 src/shared/vcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index 74bd01729..314618664 100644
--- a/src/shared/vcp.c
+++ b/src/shared/vcp.c
@@ -1719,10 +1719,10 @@ bool bt_vcp_attach(struct bt_vcp *vcp, struct bt_gatt_client *client)
 		return false;
 
 	bt_uuid16_create(&uuid, VCS_UUID);
-	gatt_db_foreach_service(vcp->ldb->db, &uuid, foreach_vcs_service, vcp);
+	gatt_db_foreach_service(vcp->rdb->db, &uuid, foreach_vcs_service, vcp);
 
 	bt_uuid16_create(&uuid, VOL_OFFSET_CS_UUID);
-	gatt_db_foreach_service(vcp->ldb->db, &uuid, foreach_vocs_service, vcp);
+	gatt_db_foreach_service(vcp->rdb->db, &uuid, foreach_vocs_service, vcp);
 
 	return true;
 }
-- 
2.34.1

