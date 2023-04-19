Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA353C77B75
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Apr 2023 13:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbjDSNoc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Apr 2023 09:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbjDSNoa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Apr 2023 09:44:30 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2066.outbound.protection.outlook.com [40.107.6.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81BF6A55
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Apr 2023 06:44:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbNvPe2IzKQ4gWW0fJXE/JXlmqSGV84GPVqmtSR0UKqV1ihEK+aY3KsdlKiqZDmZRxqS+ZJhTr4bOOds2ehDzUxL+o4knKM3zSnNegr42tVXnYYrFIu+Nzj1fdydcVw6a2q/cXe5yFQ2vhJMhOwK3zsaJ6dI+8i0iXMeM78LxQckpWdXumllBTD4LeyxhiCLyyk1nKmshoAO/1EZgyduZtcuwZc3T+W3QE59KH4JZkZ4c3RrGG5qjAQSEct4B3NNP3Tfk4DpRSc4x4nB8wr3SRCr/+xxJRp3WlvBDSRvalNPENaSzENtHnAR4cDcTJitUzF22E7NEGrjK3Se1NToaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0+wvX93UnRDVOUwePd81cnPt+gcqCDO3MSIZm2HvDU=;
 b=auY7A0M/pVzjkXDxVdpwry8HVOcx0kOdXdQcQHDki1TEcgknQ0PVFfuH26M4BLdv/eI28rJcYvCvcUWJPxIPu8fbTROZj1g7CMrDJKCbVsf8qVANmsCZReVHr/sRhRuuoLktIRHUh2kUIAC2MpzB99tYAhQqF64zzk1QvmrjyomxOWB7Xnk4Xn5tkQHDCM9E12uLbLFzqXBQ3WQC/D1C8nXuu0S6D2phYTINkP21EF8v4q4muqAaEeExMo3651OkC/T4ucqLsezb2KTg24EICweFLHhSYln9HopdBIcyHsJqZpqcCbQtV39ROBfBSM8db330wOc1HpixsKxAKqokUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0+wvX93UnRDVOUwePd81cnPt+gcqCDO3MSIZm2HvDU=;
 b=pUOpuwkVrfDkhIoXS3d0Q64+5i5M6HtQvfh+1gR2GNYKNQ8cuWxvGf5FT5iU/cxQQYo26TCXWUV74Ztn3NEW/vUz0O06o7uLiWnmo3/uvNeRK6ljHMzyZJHAfgzcw4R8px1HBHNBV2JavSyvQrIrNtL1s7uk9Eg76UuhgSzfArs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DBBPR04MB7914.eurprd04.prod.outlook.com (2603:10a6:10:1f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 13:44:27 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%8]) with mapi id 15.20.6319.021; Wed, 19 Apr 2023
 13:44:27 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/3] monitor/packet: Fix BIG encryption decoding
Date:   Wed, 19 Apr 2023 16:43:52 +0300
Message-Id: <20230419134354.61950-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419134354.61950-1-iulia.tanasescu@nxp.com>
References: <20230419134354.61950-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR05CA0119.eurprd05.prod.outlook.com
 (2603:10a6:207:2::21) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DBBPR04MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ac0fde8-dbe0-4d7f-e152-08db40dc31e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OP9TAWcyCzj8AnnQhi6Pb3Xg8NfoZvDzlxj8UqhWoK3snbFCObUt49Nj3Iw99omCHcVvVQMWwgL3bqUdtxEqvY3Jhr48tRPtlecQvrgcDASbFGOo5J3xjB9IGAkBIDgd9Mpp0HbVQfxcIxNIu677nrdoNjb57xvVjgalvj/2nFFtNEfPCi9l4CysiC6LXiLezb0m2Qxdmi3JHdyBHRiYXCrtPizjd1MpzNCPPxq+AUbz3PDHF8QAWpmjphxn3QecEw6ymZk0iENia10690oC+8SJ8z2riFbrMBEt1xnC1ougEDNqOnmUaD6hLLqvl/t9JnKfdiTGuVFtPEFrBAGYXdgfSBI9GMeVXXMkBLGihxXlvfeH0Ai+Se2UdbrtDokC5C7HRUGVVwrN7HgAZlDOp1o0H1xIAjKfrVgmsYqoPgq8TQSopzpllN5ljAuazv61PpFLA9YS6UXXa6ZGw0TCeTsXYw86xf1LL5+71yKaO1NKzoCIYTlWD7tTtH3Axx66aJAdgMfltBQqDML5jv2rfZB6k74iYrZEVed3uZWu9Rnn1a+dsLal2ukchXnObqMPm0NLz5a7MlCI5+8ZBGmf+ADYsV8uLOIe633aEhiLfmEVPEA5vJVhFQ9U2NwQ0MN2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(451199021)(5660300002)(44832011)(86362001)(2616005)(83380400001)(55236004)(6512007)(186003)(6506007)(1076003)(26005)(38350700002)(38100700002)(8676002)(8936002)(478600001)(6486002)(316002)(6666004)(52116002)(41300700001)(36756003)(4326008)(6916009)(66946007)(66556008)(66476007)(2906002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tZAanMk3AucO7u6486a28gxypEW04uTrJFbtzJRcf1PURUwuHppbMUD91Vp5?=
 =?us-ascii?Q?DRbFhaKjJ1JL2c9POT2DXonv7z37w/eMG8RG6/ZQnrCVLupDk+gH5z267GvV?=
 =?us-ascii?Q?44P2BrBnNp8GlDEymtFe8sXqmYkoRx0PtrNHh1YtKrx3mk0bbFdReZwDjmmr?=
 =?us-ascii?Q?yBl+tfTv5f5j+C0jdC6k4g53NCJF6pltqyuI7ewNFM0VwfsnlJJdZE6QXHWo?=
 =?us-ascii?Q?3N3mjnyRbSjE3zm+2thofuSF+g9sY60swpv7D654epxPKcHuMxvz5e7Jodnq?=
 =?us-ascii?Q?/JAp2QIoMoIjri56xXQN5Kvi1jOXKm1x/SBLWJ6gxa8vRiJ7fB1HriKz9hHK?=
 =?us-ascii?Q?Y82Yc4PAENS0lfB5FIdDjD5nKwnYhmXZtrWTDk6zT0JIyd4nQ3vmj/6PKnyX?=
 =?us-ascii?Q?tQGlYAIXhwMvxNKrYbZK5ZAooigQpqQFBTk6k2rT0X4lVM88HR0RJDqqAsmk?=
 =?us-ascii?Q?+S+4WcJrP2JNjoc8XRy2okJT1mZupzkBBRwBBIwIEYGjyjv4TSJ+CUlMyaRk?=
 =?us-ascii?Q?E+CSAthMpXg1M5z+m4y1YZK9HtGFlEMLCTqDVQT67fqshIaN5IR4foaTUzqM?=
 =?us-ascii?Q?J8ZCtkTNGoojDF7mRviuTyOtRimaVYn5bZ/kAxB26wF4X4t9APKBcZRuq/kz?=
 =?us-ascii?Q?KbafYAHK2hIg4dDfJP2IvIWyq/v/0Vj73qnJkT5tcAX/UCDnlWsuWiTuHv1C?=
 =?us-ascii?Q?kSREBMIygdyDJxV3ek/dUoVBgIWoDOpmcCEN09za9aLjjQJA0+aKnn1dAvGe?=
 =?us-ascii?Q?F88K66v73+JwIyhqgEApTW6XBRSGQkGnhbZLbv6lgiijoNwpXxnUmbf/+yMG?=
 =?us-ascii?Q?XTw4QHZyC1KtmVaUnCLrTmc0USsm7M4ZUVgtSlxaliJTmlHk3y68771f3l6z?=
 =?us-ascii?Q?imhBjScyCj4JyZfrt6Y15G//wYjR++dBSHecqnWM2sYO2DDmQXBRnUWc0Jc1?=
 =?us-ascii?Q?VIgBDo0A2s7olgGiCB/Me/SPNkZ9Ct0qW3PO6XEpA3OTHdiEgrMzsw+cfryG?=
 =?us-ascii?Q?AGzJhomjZB26HuZ3z0bVHbzOtxIpfqHXFUCncPjtGYBU6GxFlugI7eZNn1EQ?=
 =?us-ascii?Q?drP1gdfEDjYWAaVjaEcAyeNtbZDAhxKxfOP2Gyd39bcFOfnodwFWkBwyF/1q?=
 =?us-ascii?Q?AXa3geBfMIqrh5U8tfePyaaatXUB3O/U5bYpJTdfdse1uF4/m9dSUBF16xa4?=
 =?us-ascii?Q?FobwhwfNRwJyQZFwoJKjqoHxtMp9MF8MQjkRtqe3KEr/YPHIvaTw7UIjYhwO?=
 =?us-ascii?Q?C5Jl+Zc2DhjbkH3XcsxwTXouZxoCgiQsKYPMpxfMDEbWKoiAVS9r+nBHsG7c?=
 =?us-ascii?Q?zKdyGO0OJOA8U4fsQEgPzZ3P/ch0cYEGKrEaTPfuFsxtXb/sxQzuJqsj7kE5?=
 =?us-ascii?Q?lIpq9wVoRP58Pgl1zFRMetQZX+SeKFx211/EWewRfbhhBUByITu+E5tZG52P?=
 =?us-ascii?Q?kXT9Fd+BrVmLWVuBU6210JRX15R3nXJf9DZbPeGXTYygOgnrw6Y291qKXqF8?=
 =?us-ascii?Q?Ny9xws25oBtlMfZm+Q5JH7/l/XGDHWiBq5/xr5PkQxCGYTzGx4CtXITID00u?=
 =?us-ascii?Q?3IyvxZJluq3k+iL0PRIPBhhdjOYWCjA44I3lsL4Ilb3TJvkhVVbsojTFr+Ln?=
 =?us-ascii?Q?GA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac0fde8-dbe0-4d7f-e152-08db40dc31e5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 13:44:27.8498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h/mPsPT+WiFatkHuQEn35xdEbvhGohDO9ihv3sWU8y+5ibieSP6T9lArknaFPev/suo12F0nNChhRUJC2TR0lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7914
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix incorrect decoding of the encryption parameter when logging
the LE BIG Create Sync command.

---
 monitor/packet.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index c6ff16eda..645e3f97e 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -5,6 +5,7 @@
  *
  *  Copyright (C) 2011-2014  Intel Corporation
  *  Copyright (C) 2002-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright 2023 NXP
  *
  *
  */
@@ -8808,7 +8809,7 @@ static void le_big_create_sync_cmd(uint16_t index, const void *data,
 	print_field("BIG Handle: 0x%2.2x", cmd->handle);
 	print_field("BIG Sync Handle: 0x%4.4x", le16_to_cpu(cmd->sync_handle));
 	print_field("Encryption: %s (0x%2.2x)",
-			cmd->encryption ? "Unencrypted" : "Encrypted",
+			cmd->encryption ? "Encrypted" : "Unencrypted",
 			cmd->encryption);
 	print_hex_field("Broadcast Code", cmd->bcode, 16);
 	print_field("Maximum Number Subevents: 0x%2.2x", cmd->mse);
-- 
2.34.1

