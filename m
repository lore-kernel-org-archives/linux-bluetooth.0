Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199A0C001E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jul 2023 11:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbjGYLWR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jul 2023 07:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbjGYLWQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jul 2023 07:22:16 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2058.outbound.protection.outlook.com [40.107.8.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6E410F1
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 04:22:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZTHEfK9ijctmG1ss4M70fu8yxfBj1tzJ4gKym2tkHiVrJ51dNmRCG9PoBPuxVp/xvDSE60gt0mgw3bu90uqnHtDIY+3Z5ZGrI8Cc26wgKsRC9rfr2ZT5DZ9xhTYOcstNZ2twpMnBqBg0kpVilEYuLNhaRd5Xeutb8QcYA2O98FYq2tykH8RFWiXCRBikVDrrwdqPLERdDwHvuFcfNJe6ngEI/Nj5/LKdWw3JMLPTkmbkNZ+QQx9+edpqOhuWyEADJWNbp8jBiWKbGKyNBJn37R8yRK0s4jrAq1N5XRwDUkfl/S72etYeWBUtxig4KElgW4FpANfKEqxUOSV6n6ZNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5e+kH7jbavEfXy2CI+FXctgAclZYu0bRugEzfUjGJ1E=;
 b=Baq0bIwoh1NibeGUnBZncjeINybpd0iwrUVorqIp4X/bMgxnwfKD5m7nV3HPyU1OfmlRqFIXeElGN2I2+jhMRfB+8bTgyWd+bK3IWNAbp25wrbCmlt+FzlF/KZmGbtgyawsHwrGj+I2YS+ccPmlooSPvTpP8+0upuYWA6YmarsFUYiJWzHzVuaLhaBiEOZLTeGBtbRwZd/tQBtFjIOoVftZZg2FOVIGsXHt7feIafR0WMtozVqch6IZ3dZptkRoRcpLro9qyiJvXYpkUgQs21Gb72kMHJzrnGEvghurHZPI0dSuRP8dTQxXqbzPnCxaKIPfv5e2O2jguEfUS8s1CRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5e+kH7jbavEfXy2CI+FXctgAclZYu0bRugEzfUjGJ1E=;
 b=EKp/QdFJCK6hxolHZMna7A7arU6uJMQtnJYuPuQFZNI8f0IHdxl9LMD6bgd8mT51xq44mpx5RnPmFGvAXjNjTe5vdV1/CD5LsjBBikU+7MCIBdJJb+VgCQ/wfDFeFF6t9jgFAzxXJu1DH2I6/A6u8p4k/pMdctO9J+55bma9izg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16)
 by DBBPR04MB7580.eurprd04.prod.outlook.com (2603:10a6:10:1f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 11:22:09 +0000
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::273d:f528:aaa9:288]) by AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::273d:f528:aaa9:288%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 11:22:09 +0000
From:   Nitin Jadhav <nitin.jadhav@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devyani.godbole@nxp.com, pav@iki.fi, luiz.dentz@gmail.com,
        sathish.narasimman@intel.com, nitin.jadhav@nxp.com
Subject: [PATCH BlueZ v3 1/3] shared/vcp: Fixed the crash observed with VOCS
Date:   Tue, 25 Jul 2023 14:21:24 +0300
Message-Id: <20230725112126.49656-2-nitin.jadhav@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230725112126.49656-1-nitin.jadhav@nxp.com>
References: <20230725112126.49656-1-nitin.jadhav@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0185.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::19) To AS8PR04MB9126.eurprd04.prod.outlook.com
 (2603:10a6:20b:449::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9126:EE_|DBBPR04MB7580:EE_
X-MS-Office365-Filtering-Correlation-Id: ab54e28d-1f82-4d6d-4328-08db8d016287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0OkSnL4ixDdhDrOe8ctpCZf5WpualrVKivEaJZK24+nsu9rIodqstfRpebS/SEqvRG88k83XrNc72EZiU4TTX6RburgMFy/0cA4kdnTwW2ShyT6O/+PubbqHjZ9B0PhTqkIvJv1dNu0+Jq76iaZZxvxy+ZhzdJiv4IwCHI6oqvIu/q7VfmsH/Hetzhyf6WnJQpV0oddmgBstbm1HSNq0OhNyfPhVI904I8bdngKft1eRQO9OckC6eZzqCpOBP5Dy/UAZtC61z12g30IV4s5ulszfKPDys6wtFe/UOEyof9PVZwpMJqk6d2QY0tVqBotUiG7h3Ng3AvLdoY7eZd1lFMkOOI+REKYzdJAunExQjZ+05YSYH4RwtjM7IdFXL1fsguzAUgGjj92k3+Cy7hjGCMt02F+0HMi74PSRgcwu7V2xbcOAm+QvZH8GQO4pd5NTkHT/W8ZS2dJIUMqsCmRSxi3eLkq5ax2bL5ovtt0mJv5nhbeMc7F6thve5y/+CbOAhOiu6aF14jtapGoGwGdp7NWaFnXcmBqFzOkBHVKszxIvP1/JbxXmk3wHZNEfXquqB1/LldqjFUIXP0fYPZz7zq3ZVaQL6Qh5qh9Fy7p8hwgSp/rUelS+6IbnFIypDGoC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9126.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199021)(86362001)(36756003)(2906002)(52116002)(478600001)(38100700002)(38350700002)(26005)(186003)(2616005)(1076003)(6506007)(55236004)(41300700001)(44832011)(5660300002)(6486002)(8676002)(6666004)(6512007)(8936002)(66556008)(66476007)(316002)(66946007)(4326008)(83380400001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?adUk+pYKkW39KOWL8ldgNGW3HuM4d/YoFSxARjRuhiF224Mk3J7bQ1zsHRAF?=
 =?us-ascii?Q?tEoBxCcVhnCdbCJG/6p16BXR7/eVoIqUwOdZwSoK1EhVcA13KPmtPPJIFsuF?=
 =?us-ascii?Q?lHKr3sN1U6k1kPDUmrLmuMQFF7CcMtpOx0GdOeFhKFqoz2yMM+GTCORJbbJx?=
 =?us-ascii?Q?TV7pyWbawdawd7gWlJIWdNUDV74k1/8KvS4lJ23O9EBGpettIGfS28NeCvqP?=
 =?us-ascii?Q?4WhfEn20wzt4XqfAZALvMU4HbwnuTXX9TPvgOu5gu/WgLRiWqlzrar/6RBZj?=
 =?us-ascii?Q?lzFY9qWy/zN65yDYL9bdw5dk+ddr9UOnfI03QFCNZNy5VKr0qFU+1i/M/dt4?=
 =?us-ascii?Q?HnpAvD1cQ3bSTmm2ngEYnmm4Zkybo8DgpSPR5FQd6pCHyAOHmCKb0Z1xQgtH?=
 =?us-ascii?Q?cyk2wVmXZREBlDp+MZzQkGSd8i490f3mj7bcNUUMVMU9sPQhTmsKyQC2bvox?=
 =?us-ascii?Q?UHPUKlCaWWyAAprAMEgSiA/5Ss5juyESjs1YBAhzO9UuGqyyZ80/8jw7aMni?=
 =?us-ascii?Q?3N3lS1JeHNI8w+QajumGfHy0Ci9Z2TB+c5uLZU6eqOJM1Yxjr48ItriOd/Wj?=
 =?us-ascii?Q?IynekkFouoV4NRaXwJgwRUvAnvt4P66DGsi3Sow/plDWcCu8qFKO7xuwLO/H?=
 =?us-ascii?Q?I1F0cDysRpalGh4W3/3S6akhES3yJ0A6gDkgXgI/984kRUEKEmzYyK3buq5X?=
 =?us-ascii?Q?mh7zVlT50QvCXgpYeqNrRfHRu7JF3EPuxMIW/19yQf81hGFr8JVPBUW6fh/a?=
 =?us-ascii?Q?cUJ4KiUNpH3L2NGHqbIOisRqZwYq7cEUhZ+ZhB9B7CR5YuZA8Nbl34+eSbkl?=
 =?us-ascii?Q?ln5TCQmW4G5zch9nO5+Pb5OoOk6zEKVmAi6lTp4EHyKUh6/42ZwdeXrVV/96?=
 =?us-ascii?Q?tHXtHBOF0YdQoszxJnEdRKH60KELDdYRmo/oYC5HWU8uJeUA6tz0atlpU834?=
 =?us-ascii?Q?kisf7SJbwIRPVhRrYqgQnjHljFIgdPukrwcJMVL+0/ssXAK3FeAcCK+pSznD?=
 =?us-ascii?Q?hRAtgm5yDtFC3vARA2UPQvTH3DZYWzZyLM+JgszkspIua5bnDqb+rO9vDbb0?=
 =?us-ascii?Q?/LX7InhH8h1XEEQ28lYctBA/7BbjsdJ+UrbZeeAZpv7xUVsntRhkrCqEW7FR?=
 =?us-ascii?Q?dFTBco+naBTzUirBiOOXYnwxFeGN1tRTXDV9akeMSkP5nO5OFKJvS4DtQCc5?=
 =?us-ascii?Q?z8Afm9dfLgV6wxe6AyTNHQpI2R8GZj881p9Z7b9GKO5nVW/9kHBlAwqah2zn?=
 =?us-ascii?Q?wXb62rRKCOVnNBc9Kt0tqbpoSqip5siJo4u/x2HYFk3yhoRLHndseGcOj2xI?=
 =?us-ascii?Q?R1ZiPLQ24BY29UPkSkOktDPt1UzbDXyArWrHM4q0LqiuoQ2V7Vrq7YRcutFF?=
 =?us-ascii?Q?O6JQoYyj6VDqzdr3nSt/3cDua11VsljmsbZKOe/+kXhxoD4xw8MKpSRJYhSL?=
 =?us-ascii?Q?lD9trE5meJ0WGiZqxAXW+7x4cC7jt9gm1sIBzjBmd7NYjoNzYo+Khf8oBU5N?=
 =?us-ascii?Q?IQXFPT+Y+St+iYCBq4+wLMtdimkyKB7ScQ675Q0HzeX++es4J8sFjv9WYzdC?=
 =?us-ascii?Q?BG6NaAW9D4HLS9bsdi+MCZ7oBwxSFZSM0TPOTm5j?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab54e28d-1f82-4d6d-4328-08db8d016287
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9126.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 11:22:09.3701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LrmhGZ0GrbYf5C4nVDCQ6J8xnNa4vTMLCXN33CcM8ivaTEKUuRBFqDwseg40FRIy7WaHfpYvNhFO+CVX4tkjJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7580
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

