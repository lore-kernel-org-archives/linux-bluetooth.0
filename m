Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965B3C77B7C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 May 2023 08:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjEEIb4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 May 2023 04:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbjEEIbr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 May 2023 04:31:47 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2068.outbound.protection.outlook.com [40.107.249.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA52918FD7
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 May 2023 01:31:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcfXkp1IdS7aBjcARwrpjNHOT+mCGMxZ8DWAcap+hdBnsuU5QifSTKOk+Utufk9iTZmlo98Aj1mJL7Y+QvSKpKAq3iryYWMYgBIcajY1RP7SnUsWfVMy2MjZzyz9ABB27nGIWrJa2uUe13q/Ww01ga+raLTMZTTE87UuGhAcQplspszFxJ/+yN1yJj6Fv1Kv/syjhYPpsJguB+3c7FcPBR5KA9jvIucDc6Y3Zhoo9rczjbea5bSjYfthad65810pTm2S1k7IasvJEGMDAjW0ZdlgQ6A9FlQEyliUSC77udbx21w3Pdghy3uk9qL0su0rBQBlIXBdRdUfxTjYPTf8ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3c6M4NGcB0HRHi2DXB/m5rSiCFRP3Ggu00Wn6INDAro=;
 b=FKqkRx9uOmUKXUJxvLlQQxXES1cZliJEZ53fwo7mgQra4tEqKBQhPJPeIwSVIHAIktEnd6TVg8Mu3Rs+UU9O8j6JZ//P9qdCgJzuTSo91ge1zoYQaK1fwBsAit/4LiXET/ExyMSBePb316lsSOqnJFCQx/99k3pXEL+PWsHE+6HW7mAXkHOa67czitSha8swLDs0n9GCAHCK+5JNwLUoPN+jDHTnxtsIH6Ps8ARfMRmXLwPKzZYVXgSl1zIDRKHPMswlih1goqvkgCGjeQ/xGQ7tm8BN3eq/RCPeQ9tgSO12fjwycoC26QIqSiGUOXV1KrdV9hu3A412AxPsB9SWPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3c6M4NGcB0HRHi2DXB/m5rSiCFRP3Ggu00Wn6INDAro=;
 b=lEXXkH58mYbYRAkANG7yxlsv/ymHg1wZMHz+Ojfo9A+UELELxSG9c/O2/TUSZOrqh+dBTxlzdv4UHhnzW/BJISMSyB7DOkQ+HjVVqYtm4M1mCedxZdmAWi9Zh2DHZeafl5LrEumEdh1paIKCabnOuGqYso6o1KwtIeGEyazeekc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8101.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 08:30:23 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%9]) with mapi id 15.20.6363.027; Fri, 5 May 2023
 08:30:23 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/5] lib/uuid: Add BASS UUIDs
Date:   Fri,  5 May 2023 11:29:39 +0300
Message-Id: <20230505082943.92033-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230505082943.92033-1-iulia.tanasescu@nxp.com>
References: <20230505082943.92033-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR07CA0036.eurprd07.prod.outlook.com
 (2603:10a6:205:1::49) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8101:EE_
X-MS-Office365-Filtering-Correlation-Id: c99f4636-204c-49d5-c259-08db4d42f8a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dKJXyj3x8R50bhnyjszOiQ0jb/tXDxsB+6iCaIA1XhWJ9d6YDqul/eA61sWiOO/xh44k5FsHdY4J1Vz7qTEElkXt6akZ5emCXRdDmCwxN0oP5EMIx4sA90xq6uo9Q+5wrgjHY170MvWLMAdAmxnVM01mQAqTAtVstpX8di29UfmYtWlSmNV2+GRwerGIRjvxFZt1M+RqmJDCg+je4uXEL/uC7cNw0H7QsmALWj+OkVc30SVoVe/e3LDh3a/HY1cnGNCn9sQwLkfSoP7AHRTU0h0X9fj7LMDxUK6p/6pFGyO9oNFgQ70sx8Oz9ym2VmSu6OjRzaZ9O+Ocf90rhZ/MXxy3BmnkgIrq/r4jfdr0o+kXqMR5h2E/toG1Zz7a9L9mCDOFrjR/CXpQOvqdXkB3+xzME5CSILAeCXGTEAV1keU0f9mRsDSi+H49y4hawI2BZDoXQb+6206+htz6xxcliIgHi7M3n0jvrzjgxz7wrJv14CIGPxEJhuXIFXbERq0SWazcLO/pkqHBT2aKptj6pj2O05CMcCxZvSVXTweNSKaXBKssX2Bd+YUrWLleOAP23BW1lVX0RUtybTMbALh3ZzHkCuKhICSMIZdy41awixIg2G202DkYBBoiPgXMWDX8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199021)(52116002)(6916009)(4326008)(66946007)(66556008)(66476007)(6666004)(478600001)(316002)(36756003)(86362001)(6486002)(2616005)(55236004)(6506007)(6512007)(1076003)(26005)(8676002)(5660300002)(8936002)(4744005)(44832011)(2906002)(41300700001)(38100700002)(186003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oKQZUGEw0p8eL+iCSIP7Ig9tX3CN1asewVIKlv38Awfjjfj/K5K1UbVjjiqG?=
 =?us-ascii?Q?bs4XutpztoV2EzpDSy2rRgQs1WY3QJMNAL6Aq3ShPhK0eZpjNCwuAKR3yGkB?=
 =?us-ascii?Q?PZwNkNWUWt9L3QhvnQklssxVbLFYSLVDzF4H6r1B8Pz//Q2YPTr4yuFOps6q?=
 =?us-ascii?Q?m3dF2UbOLn75zNXnXxamJe1HT9Mz7D5x1tLR1MJCwI0+JAoaL7qq/5IN55XB?=
 =?us-ascii?Q?L7fK0JTWamcJlZvutXPWxB9FVmdweKWdxxMgcPldjBC0NdG6Snw6w81WM/Nr?=
 =?us-ascii?Q?SDiWvDmHAXdv9i0jUIbYBYVirZutqfUJ0Xf0KHhtxlVrlneCz4DdAZS5Rde8?=
 =?us-ascii?Q?OQwERxOu60oxsTJHgB/EBUmRWsPFhzdjcImyMucUyKmvdEsIRMJ6STuJ64XM?=
 =?us-ascii?Q?xoqdmFHmAwO2HUcUXBkK6I0So84UyYUPhCDQVuYhfckEPwpKorIlRnNspNHi?=
 =?us-ascii?Q?Rhze0yzG4tcApEcIwR+P6VV13Xhfb0xpRpUwG4L7v9KcfCyYRXhjOLRwcQur?=
 =?us-ascii?Q?MeWPlJCq+2EHXwedWtLklxhfleJjzv/6rtoBl/cl/5IIdUFWeAd/v3ypAihu?=
 =?us-ascii?Q?4XWxKzd1ICL/3GdMG88ZdHI1YJDfl08afyYUR3Luvdg7gUNVgy/J0w8FunNv?=
 =?us-ascii?Q?PGgQaGIZeGbLnE9ZUVe4KAjogedkvzUXFhiDqOSUbjwSJfUOnGC5oqx2io1d?=
 =?us-ascii?Q?I1Q6ViN8anG6SQQDUrSMUTy3fDX/zSw1Lr8AJ1yIN/gKfXY+9jZc2G03Ae6A?=
 =?us-ascii?Q?6OJSNG6xfMqWePjbWTi8wZSEQR//jTqd4uUYx23go5nunobpEOHZ+PRPb5/2?=
 =?us-ascii?Q?iexv6m8lPRXRlwpTcyiaowEbgJFmm+KCmKYcv9VjZVt86ng2JQhZZnVmg4Hf?=
 =?us-ascii?Q?z+HwioodeZwmelNVEaLU5J3t0k5rfiuVgxPkL+8OKlIe+4h2fqp3LX2v6C04?=
 =?us-ascii?Q?sRwFItTQI0rC9KZcLApU7co9gciotSdAMF+WaAkJ9ZZRulsfqaup8M46a3Ad?=
 =?us-ascii?Q?5CvfZHNhzPriYOGEglPzeQQJVYJSu4KG4KQUwcaWO7fLdoXIlTOrC4NJne85?=
 =?us-ascii?Q?/krG/d2HTvzqVePdoCEY7tUD+WcUEIGC9BBoSm7/jYctcumbcbPbfHbn9hXg?=
 =?us-ascii?Q?RvQSRka0PAhy2Lmws9hellwo3/S8+jkC2kaRegcEyM6ERBOPINsuYu/83bLA?=
 =?us-ascii?Q?y3kM7tfd92R+K56dFQfc7reLbAyXLvYA7ajTsAhKADMkXWZkYscowiZoxw7K?=
 =?us-ascii?Q?vsMtqTPtuGm91qkLVpcYfsqUaxjrpWyJCOAdPeU6uTAMYimztKPMHlpVkxto?=
 =?us-ascii?Q?xXeSwRGNFIP7bWkL6Kk9/808dideu5dTQsq8t013oQB4I0tKZiU55lwWi5q0?=
 =?us-ascii?Q?B/UNStMaqD9L+2KQn3PmlIkiKfFAOSVl42+2AcXjNB4H3vM03ncxjY/6nYvL?=
 =?us-ascii?Q?4evDIWDtBjnkfxLZ/f9ngOlGWxgaXqE5LuEc2YQv4j4bOKH0+4loUrrxY0I9?=
 =?us-ascii?Q?bjhMus2/SebLZlN21mo/Eo/bzphTOdD7Ls4W2RC7Ha1BZnHHySJ0fVBTlqJc?=
 =?us-ascii?Q?Y1qSH4vl4Sdhs6mV7FO5VMywY2wOG+h/R9JnsbsyESOP3k2j77OwTatJweRE?=
 =?us-ascii?Q?Iw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c99f4636-204c-49d5-c259-08db4d42f8a4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 08:30:23.8594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JcJ2ym6b/6Zl+ERoysprQgETI1QDUnSM38fejNaeRgqKiCjcp0zSLtSo1iZIaDdZg6aDS0uj+Q6wvYTW3C6K5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8101
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds BASS UUIDs which will be used by Basic Audio Profile.

---
 lib/uuid.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/uuid.h b/lib/uuid.h
index 84ff46cd8..ddde4bfa3 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -5,6 +5,7 @@
  *
  *  Copyright (C) 2011  Nokia Corporation
  *  Copyright (C) 2011  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright 2023 NXP
  *
  *
  */
@@ -164,6 +165,10 @@ extern "C" {
 #define ASE_SOURCE_UUID					0x2bc5
 #define ASE_CP_UUID					0x2bc6
 
+#define BASS_UUID					0x184f
+#define BCAST_AUDIO_SCAN_CP_UUID			0x2bc7
+#define BCAST_RECV_STATE_UUID				0x2bc8
+
 #define VCS_UUID					0x1844
 #define VOL_OFFSET_CS_UUID				0x1845
 #define AUDIO_INPUT_CS_UUID				0x1843
-- 
2.34.1

