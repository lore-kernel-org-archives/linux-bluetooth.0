Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA884C0015E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jul 2023 11:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbjGYLWY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jul 2023 07:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbjGYLWX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jul 2023 07:22:23 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2058.outbound.protection.outlook.com [40.107.8.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD6F9D
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 04:22:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUIIAlpvSPV2DoJPzyjsHXLDO6UdFIuhtKxzBibHSkLTpeO6f0oiqZi7RERgRSGCRyYYvNRMzAiCBzgy5+/tq3vtshTkkquFX45NjCsESMlSet0/nXkVagk2B6VAhlCpw/BT1bSlFN9W4lMyuWody3j4G+b4esepi15nFoJ6mux5XgJV79FNxxU5VuZ0fvP5hlB0OEG8+fAgoTWuDmVQvDSyIYoQlR7A0cpPdfYsRCE24PV79kQ4zo+uYytn0nrBQKXkeBYJVV12JXC8aLC6ZhBfh1zqKuhwRUNWek6GgKrRG9uNWV5l5Ce3qaMVf18ItZMiZDV+sIS0qBRtNprj8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMN0ofOl+sZj5q0RLL6t0fC6AwkbZ99WnZfhN9SKEE0=;
 b=nbqd1hW7LB8t9qcpmC0u9YuCzBBGwKexZG5KjffAkYI2oHgKQzQOwHJqN4qz+E2b8IHMXGqVyVfLfAzB7XR8U0nrdhP8nYf3w09Xz4Hoh2GiSp6N/6WqhknQxW6N5JohBYlzsQ8h5If6wmx4EM/dhTXdKdWmoeRAnVOwzRCG3xFoe3BSCGrgYHh8kB4p/3LofW67e7k0kOjJJGynmCFEZGbKLwsLLNICziIJmv2dJqSf+7eICS7vWi84V/2BK2kCvybHZOjnOAj2enwfn2KFXqZy7MJoCUtVgn0t5IAA3e39iUleSwftwdEXvrDUjobc8kH7kLLWWHzF8ibucOCWpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMN0ofOl+sZj5q0RLL6t0fC6AwkbZ99WnZfhN9SKEE0=;
 b=EV8R5qzhTG/Bp9rb7mxX+gu/w3tj867RnibdjHXdAi2SI9xcqXrH+2iW2+P7yFOSPXymUCDVIXMI6rEVItli68qHLy6HJbhAMNoASHVMaW8jOaYk/q0lzT3Mc8My9prsWCelS1rggucX3OEEcxgvW9wCF5fkHX0+jM7cM3YhrP0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16)
 by DBBPR04MB7580.eurprd04.prod.outlook.com (2603:10a6:10:1f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 11:22:18 +0000
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::273d:f528:aaa9:288]) by AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::273d:f528:aaa9:288%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 11:22:18 +0000
From:   Nitin Jadhav <nitin.jadhav@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devyani.godbole@nxp.com, pav@iki.fi, luiz.dentz@gmail.com,
        sathish.narasimman@intel.com, nitin.jadhav@nxp.com
Subject: [PATCH BlueZ v3 3/3] shared/vcp: Corrected handle size to accommodate included service
Date:   Tue, 25 Jul 2023 14:21:26 +0300
Message-Id: <20230725112126.49656-4-nitin.jadhav@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 89deb0ef-8bb0-458e-c39c-08db8d0167da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2gX/sKz6h8NOPeENbL8lOa/DqymuRMG8RGuBgWXBDi97Z/HEgOR4a89+DrEuG+KjqnS3k46CxkXFth4LfsnVo/h4wN3JtfERDXCfBp8x5+yMAyLcFuReoVeeQjTsFV49rOXRgCLyNIT7e8mUX0YV1hj9qrOFpJTbtb41iyDpgPAG/u4rPvmjMhstIOu2edvXDG/fB6/YwLJLe3PuZ4u0EdWL15bJCHtzAX1wY7mILLsZbAbOdCOE7Uto39JdO0yuemoA78WF/+MRq6tKEWhWMQbWbGTFLnA6EMH6grdk6dREjGj11hRiwynHfDIii4nMTz7dOzNCX1dDLcpuvVIK1R2hiFrd2ozT1OxqLSvzaqFR/t0BxwCfFFyzBF2H0Aax2nv7zcLELMNYNLnZe8S7G2P2ybkPHHEGdUg7d60OXV4J7a+xpKjox1Bz2ktStU/B3WunXj1eAgVenNBJUA+M0o5e536Gopc0Q+1oY2judyzsw0e6YdXQu6Cg8g9xweJkSdezV0GXCBrcHkRFtOdhcjucTc6uGMRDYH9L6AcBl3MGJawE9cQb7u2QeGlgppTTPatfsYgDF56fNqzdfEcLOU1KGl/0EKWsh6UbTFnh9F+n7rl7xlRXsEKtcinKdFGa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9126.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199021)(86362001)(36756003)(2906002)(52116002)(4744005)(478600001)(38100700002)(38350700002)(26005)(186003)(2616005)(1076003)(6506007)(55236004)(41300700001)(44832011)(5660300002)(6486002)(8676002)(6666004)(6512007)(8936002)(66556008)(66476007)(316002)(66946007)(4326008)(83380400001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ECw5szsJt6MYyQEpKL5v1iOjKP7Oa/riP9w9PoxP92F1FtX6WbW7f07+Hyui?=
 =?us-ascii?Q?iB1vVLvNb5SrnbHmI/rzXiSMTkqebbPySLCP7WM22LrMQKZxnL+3yHwPcfqD?=
 =?us-ascii?Q?HmjFCc4nYty2ZAVwRwXEN3zOuutsmmB40QYSfvXHNW9EtclTZ27FLrd3Uk0v?=
 =?us-ascii?Q?9KfRLsaTWej+edi+lOJIVBmdgqXzSehL3DFjc3KkoHfYTAuOnb1snRhTy5XZ?=
 =?us-ascii?Q?cFRjve/tmdcaVgOT7yh/uYX6ZHHcvnejYEMJ0Cg/oMDHc0r54fnBAuJua6n4?=
 =?us-ascii?Q?B34MB2uLlCKeMs2Kn653sIm3YQHZW2ce3wjFoW4SDVC/10HDllSHmJmcLNQ4?=
 =?us-ascii?Q?VIMfXVOPcTEXwlY60YCIuE2tHCmppuFD/Tp3DPFMSouAcf83YJJOyuN23geb?=
 =?us-ascii?Q?jZjciwQGh7WE/F+oEz6IhqLDT0FybKm70b8mLhrBa1eJ6GRfFtliBAwoxDRl?=
 =?us-ascii?Q?ukwQFRnmuQnmK/NI73E8HLVKnhIgX2UAp0v81PuoydntMBNYzpMzcEouo416?=
 =?us-ascii?Q?yN189pAhqDWzO146/MyanO+Q6QVtUTlTobbwdUKT56sOF14Slzj9fowMHRby?=
 =?us-ascii?Q?27wNBXxIljEFjn3Nuub63TETqmJKsMwQkhk32198769HlBIGvsnmwFEb83e4?=
 =?us-ascii?Q?1+z0a7BOgrjXwKowhYgEVarDpp2bN8dDD2jDvN1QMKqUz6qjsL1PRqZ0mkT0?=
 =?us-ascii?Q?o0b8nHbSpCIVElWncFDHkOry3XclIJx5Bv6gURzZRwd5vw43G8hgcq0SyVsv?=
 =?us-ascii?Q?2DLarotlbAqM+gj+YP1Mux7Pune2HEgfNizYtPustH1d55ipTQ/cZXJeBU8q?=
 =?us-ascii?Q?fn6CNjOqRQXP18D6Ua8f1kHzhErOwnBkvgS2Ytb4QpTj7IjtXU2lHcqO8jQi?=
 =?us-ascii?Q?iaQzMt/OlanV2LPqFNdUb+QaVRDfP1020YGvkar37KMVofTiH0DtJnBdvvNB?=
 =?us-ascii?Q?yb2r0N/0MvrGhVVWfyzoEom59K+P8rI/9hBBkgwCTKSkQFIsS9uT8tBKDtyp?=
 =?us-ascii?Q?P02XjvqHNtpRoGrEJfYgVOJsJeRz4oIwXWPxuP+tm8v9EsXppnVwnA72sO0Q?=
 =?us-ascii?Q?uiraBxPWXJzBDrc13yLZtCatrgfMmm7QNqd8KC0L1Sa1RioS6x5kKKsrlG5V?=
 =?us-ascii?Q?X3j7tW0G6juI6o/7dK3EJ0BJrWLYKikWv61fj3/AtwudhpqTsyJ/6fMPDtqM?=
 =?us-ascii?Q?/YZJ4V+HWVNRh1XgvNC8GzSBY5MVemST1e+lJh+DG8a37NaLvfCyqVPwcyBo?=
 =?us-ascii?Q?Xt1wh0HKXy+9/P3cWLkuEh/jeVaaTvt+ofdN9Sj6aSEOf8WEBCrE8RnAkCtv?=
 =?us-ascii?Q?sdJS5U0hyN9gm6CGqApfqqGG/xGLUvk1KIp/xEBFJOjfUFlRvodJO0rMJOTb?=
 =?us-ascii?Q?4l6e2OQaqWb6Iw/CkJUX0ts0Z/NzV56ng1WtT4JTbuw69HOlnoz7517DPhwp?=
 =?us-ascii?Q?hWTNnKDbe3KF2Qp05D4v2PXE/xtC3USg2UOkMarLWWAr4bBorIFNckQf2zdv?=
 =?us-ascii?Q?tEetNiQjd86M8/sAayV/J3e9h6/XcFCiiYgAdlcYkWfm8718cZfXMzpXE++r?=
 =?us-ascii?Q?qKvLpQ6c7VxB2hbcSS2HI4XMinurp8A53pda/tuf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89deb0ef-8bb0-458e-c39c-08db8d0167da
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9126.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 11:22:18.2856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qIBYMOISFzu0GKYkY74L+Fb/X2IgJGyX5manLr7g0RxbvQ6N90fMQKO0tGi5plAcVDWdWTSJJ5dk1dbUuXOMQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7580
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix: As per specs VOCS is secondary services hence it should be included
under a primary service VCS. Current number of handles should be increase
to accommodate the included service.
---
 src/shared/vcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index 0408531b2..263da4c30 100644
--- a/src/shared/vcp.c
+++ b/src/shared/vcp.c
@@ -998,7 +998,7 @@ static struct bt_vcs *vcs_new(struct gatt_db *db, struct bt_vcp_db *vdb)
 
 	/* Populate DB with VCS attributes */
 	bt_uuid16_create(&uuid, VCS_UUID);
-	vcs->service = gatt_db_add_service(db, &uuid, true, 9);
+	vcs->service = gatt_db_add_service(db, &uuid, true, 10);
 	gatt_db_service_add_included(vcs->service, vdb->vocs->service);
 	gatt_db_service_set_active(vdb->vocs->service, true);
 
-- 
2.34.1

