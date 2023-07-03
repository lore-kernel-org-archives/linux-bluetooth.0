Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08F2EB64DC
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Jul 2023 13:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjGCNoQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Jul 2023 09:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjGCNoP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Jul 2023 09:44:15 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2042.outbound.protection.outlook.com [40.107.6.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8468FE60
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Jul 2023 06:44:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOiCQC91SHl5h950ex7DV8nFEnWBQXThfYXSE90WRsoaOn1LqRNlPASwY88SwEtTdgrsogXQYj5Z9WtZnCVdlfTqlbaoFUBd64SwcNTIsF1vwAJFHMuNPTZXanoxoMTEve26919XipqGhYr4+CB3EPnxE/kndlyzS5J5Jd5NcjbyO6QFIXMjOdyjSFqF331Kl86mHnhSxr7ic6MvAtsqKfuQJ93y2U/wDNoKkn4ZdEojq8L3JTTMKvtOFCGv0RpRgnm651synCEomCjTWdkMqOb+bNsJQKZFzS3cDZgcxiQKgO2LrKjXFPke99PMRzYOfHX1ZibPbsSSjdNz27AhXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOqIg0G/jQdaeOeQV+LMr9rkOM9SW41GmlShaGEkumQ=;
 b=LFGQE2/0krO+f3WHwz3Z2nEJstEw1HswKIfqXWEr4XvMT9dlcXL/g0Rk3za/jNDJXM0JOtJAlAPSnp3i8ki6pi1UxB6JbQpIEjD9qJF5OxR5yYwmRWL16kpHh3136Y+26YcjofMGg/pWZcb5dfM1xLRCLyoceML88Z5vymr7k92DPMgSKjyryXUUhbd2iJOTK0jxulMUeSMmCNbkhE+y+nvKryKig1Yl6Ax4yOgvv/DGSVA5Xcomil+e3Thr6bQL8Yf5m1bM9DtB5+FPH9mNJZTd6lyUAWdDlt1wi67xzwhK1UPv8bAf12HZivqoAwEWzgSwaN0dRidbH/u1/+yKww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOqIg0G/jQdaeOeQV+LMr9rkOM9SW41GmlShaGEkumQ=;
 b=KNhkjG0VQndCH0++fsg0LWNLBcIsJh2ceVLYcCXYU5rud9JXTIpsJjwrc7OxfXgqdgjr6GjJ02c5VIp2DIy//HTiFy2NxjD5YRQ+hp32DyLePuuh7H11VB6QVInn2x945euqNtO1XnkA1n5Dz/UC5QLUgkhHQonj6a41xfIaNXk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AM9PR04MB8356.eurprd04.prod.outlook.com (2603:10a6:20b:3b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 13:44:10 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab%7]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 13:44:10 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ 1/1] monitor: Add decoding support for Sync Receiver events
Date:   Mon,  3 Jul 2023 16:43:41 +0300
Message-Id: <20230703134341.13312-2-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230703134341.13312-1-claudia.rosu@nxp.com>
References: <20230703134341.13312-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR07CA0002.eurprd07.prod.outlook.com
 (2603:10a6:205:1::15) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|AM9PR04MB8356:EE_
X-MS-Office365-Filtering-Correlation-Id: e6d8e923-d44c-4fbb-e800-08db7bcb9464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PhD/4oTN1n/d0ffheatjEtPG1SddlxhpVQ1PiQNbFXX/QlOIyaRYfV2fBlN2PsCp72g0Vw7a3FUXOI+4yYf241JFZMJBN3p3/0/UEsKG2lOnqulR9Vr550HJPf9Kh0Yuffs5lum4DGP7uzPuLzerNQ5CflWhlb5DaYiDn1SV2Ev3UF9/F9JTagmfmg4f+a21wUqXgcWoegaFVeFEoM73Hmbp62HJt2jIJUq+tYzFBez0ZThDUqxLviOlrYpLmd+R/RyuUO2Z0pOEJent3Xyx4oxQFmdWyGwlPWwlS5vnXzzD2xrxPYcHq0di2Gv+PKQtxRaGUiE+REC3C4bu5pLyegj0kB0EEBDRBecbpR8bTNiS985GwLnnxBAnvMEwnP2uWaxtMSuNaMEW1S9wl80zeapF/z+l4s6n6tQD1G9Z0WmxPMntpC5Na5yvs59R8KyqXmfLn5AAV5Y22U+EUrWhhZprmZjhSZfB4Y3BL/+hBi9Z87jgbJIII29bruIlTeg9j/Eylr9cxfE+qa96FjKSbQ6tdeJY05uTPMDxZdVRUZQIuvmHO9wzFGrjejbmgpTKnkeTQlPGLwIms0t2DI1s5hffN2dAfPC7MVCb3D/jNjIcQKFsOUM7B2nJ7sTlTjI+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199021)(478600001)(6666004)(5660300002)(8936002)(2906002)(36756003)(8676002)(86362001)(38100700002)(38350700002)(66946007)(66476007)(66556008)(6916009)(4326008)(316002)(41300700001)(83380400001)(55236004)(26005)(1076003)(2616005)(6506007)(186003)(6512007)(6486002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p9mIVhltN07ZKwqLjjeTiUEWscvsURUQXYfBNrHs633kVHN4iWZ5g3s59pLT?=
 =?us-ascii?Q?+DQPoDQHumxEU5Q/KLc52i9sd+6Cg9EYhqZTHqivLbUtk0B/9FssphpQs2Bw?=
 =?us-ascii?Q?JcirmlcnDW6Om9FpnndrKHL42BPU8SUJGMYPdRiigqu8MVABs+eBgH9p9YFA?=
 =?us-ascii?Q?4btLsugIxqhiBPsKm8VEygNcOH/wE2Hy8wRgXSBmu+yPEUBtvb3QjK+fWs2J?=
 =?us-ascii?Q?x3s74RSS/O2ChpDcHHLVzPALAZAlkV1vpoyApBcAjd7dhLB0qr0bL/PEzgtu?=
 =?us-ascii?Q?Za37sY7yIvoxFl7F+cK1Xeiqz1T9zFxoT9iZAZmMNGVdZgASBpGSRa6YAdZu?=
 =?us-ascii?Q?6ENc5XRd8yF3JzKKinODYpNThSAszW0J1TLw92bRXI9q+TYoe4egOgIzb7kW?=
 =?us-ascii?Q?3y5hvOCGWKkcP17Q6J0rtU8rX4U1OwFCECoGR/fflkAG79PMv8uCi1eXkmK0?=
 =?us-ascii?Q?JYeN0xgmj+dVnM4ZHd/XAbhuuke9aCMINemii+GEyGqALw9N/ewSWoOI9IFD?=
 =?us-ascii?Q?hqbwPvi1/3yZuVJ17QBk+09NM5XthjaWz0OceIw/5UVJlSbsdY7h3BmvLBQi?=
 =?us-ascii?Q?UzT79ZGSM5qRgIN/rFRUNrX5xDhkZtzWW8irFedYm78lKu8239aHrwH1Ek/e?=
 =?us-ascii?Q?saxmtNVJpOGT/JnVd1KphpDwpTLJK+RQf7Y8+FV+XvFrh4POyNer+kquxwln?=
 =?us-ascii?Q?r/X3QApOVx8Nc8KX7bvOAm7+BP8elJTwLz8M1IyLKu/KXzS85/iQu4cUp4Ax?=
 =?us-ascii?Q?Yqv6tnbPpkBJ7PM00+O3+rGgzrxmQHDNvSwpcI358ACkpukYN2pGQF0pwIye?=
 =?us-ascii?Q?9bHcCFkTMm7P76B9yhYlD12cGYUlDAOuOsGjF/syzj/X6CUArfKAIRaEITkM?=
 =?us-ascii?Q?BvNauDw6w99DfA7WNYGQLoSzc6YrjX36cDRh13C1DdYuCB9PjiVuqzTEkkzJ?=
 =?us-ascii?Q?gwgIhKJpzme/F6Ymz+A4JMblV7tFMdJsCwUqXE1k8P0RbB2dTplpIJLWwf8u?=
 =?us-ascii?Q?Z28UntlpN2nW5CqZcNnzrL4hiNUEb9ofBVZNJjzlGRgXrEgIMbX8846X4J3C?=
 =?us-ascii?Q?09maDfzS3BZEy47Womvb2wkdQtpHYN24hFgiDMTnJng1fzDy4Es0Kf4MG3dj?=
 =?us-ascii?Q?lkADMfXdGp3iTZgywIBtZPWGsoYClH4Srr90mRYylozOTJE3L1qhjbAYWUZk?=
 =?us-ascii?Q?mH+N2DzKuLkC1Or4zpe8ifZuru7box7QSWKo+ym/xXhl+8DvmRSuYNB7ELR8?=
 =?us-ascii?Q?CN17pYt9C+oqhvGON7j4/uP/UGSWXU2Lc8n3BtI2sMj0irr74zX8aM7Cuuwi?=
 =?us-ascii?Q?3QNGUG3XFHQueilNUezrfxj9+xfpvEVM//gpJa4Kk4isA2ZmynwX2wxe0mhF?=
 =?us-ascii?Q?kuzoOJAa8GdXbtmbVm6nIJ8i043XNuLcXzfE316c87IhoU5PwJk//aBrS+sg?=
 =?us-ascii?Q?3Nbd4i61GA3nEnIx91bnos/RFwIoA1xNLdtcJmgtVZO+U2x25aZGj7c/dmPR?=
 =?us-ascii?Q?Lmr15SmzfC9dnce9hBMjCOj9iC30V1lNp4I2CFidTGkoXCRXAbekbeu3AowQ?=
 =?us-ascii?Q?DUMsidMKVSGlyUSlC56KmPSFVryhiY3lNozTZZ4A?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d8e923-d44c-4fbb-e800-08db7bcb9464
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 13:44:10.3283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Fuo/JqvVF0NwUQvTzyVygDvNHAkxVgrY2lEnNBjZeOThAu1wDROZV5hCdeTMQidGjJb8XUd1Hbah+lQhzSD0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8356
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This commit adds decoding support for PA Sync Established, 
BIG Sync Established and BIG Sync Lost events.

---
 lib/mgmt.h       | 3 +++
 monitor/packet.c | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 062fa0271..8f92b7731 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -1238,6 +1238,9 @@ static const char *mgmt_ev[] = {
 	"Advertisement Monitor Device Lost",
 	"Mesh Packet Found",
 	"Mesh Packet Complete",
+	"PA Sync Established",
+	"BIG Sync Established",
+	"BIG Sync Lost",
 };
 
 static const char *mgmt_status[] = {
diff --git a/monitor/packet.c b/monitor/packet.c
index a871c7f27..f2167fb52 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -3093,6 +3093,11 @@ static const struct bitfield_data events_le_table[] = {
 	{ 27, "LE Terminate BIG Complete"		},
 	{ 28, "LE BIG Sync Estabilished Complete"	},
 	{ 29, "LE BIG Sync Lost"			},
+	{ 30, "LE Request Peer SCA Complete"},
+	{ 31, "LE Path Loss Threshold"		},
+	{ 32, "LE Transmit Power Reporting"	},
+	{ 33, "LE BIG Info Advertising Report"	},
+	{ 34, "LE Subrate Change"			},
 	{ }
 };
 
-- 
2.34.1

