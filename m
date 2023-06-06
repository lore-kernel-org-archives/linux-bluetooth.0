Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB6DC77B7A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Jun 2023 12:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbjFFMJV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Jun 2023 08:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjFFMJT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Jun 2023 08:09:19 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2052.outbound.protection.outlook.com [40.107.247.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFDEE7D
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jun 2023 05:09:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mogAJrZsi3UvLrSpeATiDMebG5WhylbPyU/HlLMIswZXd7BeEO3uCYYBRcaukQszrByV1mj3WoiypLBBETMq6K372221eaqgD4FaqpCuJ+Uk0AcJeQBFuO50Hmr7g8iFoPrKHkQ/E8IRnfhVGws9FwV2LaSgyRknBSYaVw0uJCJR8bbFpLzyM564CzN5NCJxqTLMKsL2vcQz3lmJyKySRgyX6e8SMNkt8q86JuXeeV3lbSz+BFVtA2E0U0Q0iygoMFDmhpsrDhpf3ZCwKRtoMoEIZ3ioeJ3YtKF4njgl4x2CB5mVLYiGY3qaq8yg4X1JjqdO+I35VQWzf1FJUFe56g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTG7LTfAkTP+vpynBxGzOv1UNCFGWGwOr7cQqZaqjbw=;
 b=COm7D7rA+0Ic5NXbrtwZKvE8FMbRd+irKSHxgLxDRr+0nrRUlq2LhL4T+Xj6E2B68AkuejZ4zlTDk0eiOSaEIm01vOUcAovuZCNMbcXgD5UbnDcKcRw/X2w+7eza1ODicHLNgvUgmmT4kgedAugqmCSZkJ3U6ACVFIFe8kPx5/nJVqsE6gn7ZduVuKSiy+CIPzZKJT/ThPCfbHUM3GGftH1xcMLCVQl71fjtLig3c3PdO7mgZEDxSuX8MJeKkp8PAcfzE6mXoPmWWAKah0Wi871qAWwMbJ07cqlYxHXOZwZukJAAJ3zy2armk2hGBMm95Myzc2wmSuJ29elURNX0QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTG7LTfAkTP+vpynBxGzOv1UNCFGWGwOr7cQqZaqjbw=;
 b=L7Jdz02ZNvPuY1ViknekIU0BTQTbF5M37L3hHkb8ghhy7NqQKsj2TWSs5NjbZZNvTeskNQisTDqU/fIaazfhSkKw8T8VaoORrNoYaLIreRcSt7D8nGbv1DftZlv/mZQqXqWPRVNUDcXF1yLqwc9YP64mqwhK6uQ2xMjWpHZOZ2c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16)
 by DU2PR04MB8919.eurprd04.prod.outlook.com (2603:10a6:10:2e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 12:09:12 +0000
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::ad2c:857b:a144:9af4]) by AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::ad2c:857b:a144:9af4%3]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 12:09:12 +0000
From:   NJNXP <nitin.jadhav@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devyani.godbole@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, nitin.jadhav@nxp.com
Subject: [PATCH BlueZ v1 0/2] Code handling for VOCS service
Date:   Tue,  6 Jun 2023 15:08:22 +0300
Message-Id: <20230606120824.4705-1-nitin.jadhav@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0208.apcprd04.prod.outlook.com
 (2603:1096:4:187::10) To AS8PR04MB9126.eurprd04.prod.outlook.com
 (2603:10a6:20b:449::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9126:EE_|DU2PR04MB8919:EE_
X-MS-Office365-Filtering-Correlation-Id: 70483b67-fb40-48d6-a59c-08db6686d6e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eaGOSFVk3CQ4vr6nm2Uva4hmMFqHOtKtybc7pMkswUr9NG61Au39k+V6t1fzd/L444jod2N7QUcGMQpIAbumU8OwI52nPZOcBfjUKfbd5QL5X4Mj+PCOT+fYICTDQ3oFA3P8nUIHl0CdyV19J+fUGzIv3C1pic+Z/uJl3iPhlRLam0t8FYpv1ide7XFy2EX7y21/moKEeCl4UqIf9iLKMIvWvzTe38j0VbswHK0HQxPaFpCtClq8LlKRSdayVT2TpvkdwYIlny+44EUGQPRraIqHaTeoV8pvrLKbHydynzfX5KTEZnds5PnhBg5I33y127Y/ijH0fgBPcr2T66k7GTtFctoK23VwXnAU4SpgqpIbnwM1fa5+lA0QiksM2cmOd7LgLibftxeL1nBGXJ74GuGk5WmKfIO2e37K9fzlm5wbehevg/4baW6zE3e/2rlFC7bjjV2OJGF1ACAMtgM21dAQ2hue5kL14EgZl3tZ8/dPK53ovaNkxGD6jKMwxdebL5idKLWLGtE0Lxwwgk/wclEwlf3WdzS7vvtaQkmOhAwu8vD2ActWibGTaLvS2af1N9Ow0t1obw8rZC5jY3/5RzlySxo8Ftk7sOxQF51ON7Y4JoTCQAJGT6RKw9vmsFVt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9126.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(1076003)(6512007)(6506007)(38100700002)(2616005)(41300700001)(38350700002)(6486002)(52116002)(6666004)(26005)(186003)(83380400001)(478600001)(66556008)(6916009)(66476007)(66946007)(316002)(4326008)(5660300002)(8676002)(8936002)(2906002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?04g0DzzFZFsxEquDEDcd1PriafaDWXXnjHbygi0p468Tut0afN0fDPcAkB/A?=
 =?us-ascii?Q?QlaNfBNKYlgubpQZvi4tRXWgkGAA7wWDdYUUfhoQU7PutcUYoVpJryMpG96J?=
 =?us-ascii?Q?ySqsiJzv+VgbJB8+WBwjv/64LFApowYmJ42nwm+VHCvM5PBAsqC8yltQNHaw?=
 =?us-ascii?Q?4nu28s9HmzjnqeoVZzC2GSMPsZlWyFCAayX4Mc2zzWghCJ3SfmaxsWvbf72S?=
 =?us-ascii?Q?O18zZv9+UBVP/0uxK3H8A5KcruKKAkBNAeLTsIcPSkZMatJiF6twOYyu2IOt?=
 =?us-ascii?Q?uNkhXOUBEcE7E+MJf3CsQCgmI3zoe9ub4wyeknJmUIIsbmfuYqzxXTuRyJR5?=
 =?us-ascii?Q?uwnfg6VQ+4FA3gXowxv76uS2hIH8yPKqwOlDMsQ239bioEEqf2jgcUpfFEp+?=
 =?us-ascii?Q?ADaABvU8peooUUTp60QeC9QOjgn7yo1P3Vdotu2cTXkbwINNtIk97ZwX5rAM?=
 =?us-ascii?Q?H5jCo/UvSn9u9+bAEYYovd3qt3ajGJwPRZRJjvaKmL/OlXQLh16G7uNNtuPi?=
 =?us-ascii?Q?plViyc1+jLdHtp2V5SdRzQUSNQR5x4YKHAgEoxHStPq6cAZ3KNFRHaBMupkt?=
 =?us-ascii?Q?9jPxsm7LtyD+cjXNLnlvqTtJZ5ntTMX8EH4aDbkAydL0u7iKHy9vSXcF7biY?=
 =?us-ascii?Q?h44+I30FVRBCAjx4vYp9NDz44DaneFFEIOyemyAEm8RG50fiEtyXYu0kw1XG?=
 =?us-ascii?Q?CqZqDpLnaEmboH8PMDGV08mNOiVCstMj/6jgnpKd11ETf/Ri1wDdGbHQAEB/?=
 =?us-ascii?Q?soTxo919JHyQrKJUZbCVOqPrmFOVNYoYUAiQ1qX7J1HkUE9z/gi/6wG+LPB9?=
 =?us-ascii?Q?1kJWIhETWk9UUWaJbYPaEI3OPzEabgwUB9XHnswSgxle8wVwY8kg8S1UI4ZF?=
 =?us-ascii?Q?UbGD+PjDj6zw/7ecFZ2MY+gIaaIBlSnrDVpOtTlDt9B+SdeDgxsnWKYo23uV?=
 =?us-ascii?Q?t13eKhX26H2t2YlL5ul9l74nZrHvj65jFSt9Wau8MkSLz3r+1JNygS83DnJY?=
 =?us-ascii?Q?KVr2UUa+ujgSl4pCE+a+xgpMJFC3063XPie3GZ4qym9DjUMYTjedqlwbULF6?=
 =?us-ascii?Q?CBOONlmce8KCbjbXbfbgvlkWGI1a2bpvRl8Yd6cRTgktxSJZo+86Vrw7sBYe?=
 =?us-ascii?Q?LPyVOOyzvMrIIQ9Znm6KPPDvJlgwaw1wKSb+mxBj8qqzY1NJjlRO3nby1gz/?=
 =?us-ascii?Q?Z2DHkdvMZQp6MVlmmFinnnZyIHvuvCU099g7555j058GD4yBpJ4ZGKtl2OJc?=
 =?us-ascii?Q?XtdXIOqda2yuYThmlDFMjWebfQWZDUs1wDF7XpsLvaCEgIggPdfRbxG5jr9U?=
 =?us-ascii?Q?ZBin9HGLyb9SOmfVoKA1cmQLf1hc2AprcGfZAFj6cEK4koZcSOXBMOSNpbNy?=
 =?us-ascii?Q?N26b0KpfX8i6pGn8L9ALZxIjs1OZmiLosO69Z1dyuon6sV78OKAyF6qSt92n?=
 =?us-ascii?Q?Ci9OsBjB8Xcx+qUISm3RMp3uIfxGtcL2RP5VHPooXvmAl3+Sn+rMrsYeWeHq?=
 =?us-ascii?Q?SAp6Rbluqpfn6/4kAyXmH+zFrRAAAD+jJErrSxeBL+bU5XBfG05NShAZIFoo?=
 =?us-ascii?Q?k61wnHmM1kfpFy303M1vWf/d4xQViQGTAQSY7oKE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70483b67-fb40-48d6-a59c-08db6686d6e8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9126.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 12:09:12.3684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HISKkIXosc/9x4/PRe18xNthpbuX//4HXoKBlRwnN0qdy1fxr61XKDEZoWlfR+xpJskpT6rmIZRpH5hMgSSLaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8919
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Maintainers

This patch series handles code implementation for mandatory features of
Volume Offset Control Service.

Implementation of following features have been handled in this patch
series
- Volume Offset Control Service
- Volume Offset State Characteristic (Read, Notify)
- Audio Location Characteristic (Read)
- Volume Offset Control Point Characteristic (Write)	
- Audio Output Description Characteristic (Read)
- Set Volume Offset

All the code implementation has been tested using PTS testing the
verdict is PASS for all mandatory test cases.

Thank you in advance for your review.

Warm Regards
Nitin Jadhav

NJNXP (2):
  Added initial code for handling VOCS
  Fixed the following issue observed during PTS testing for mandatory
    test cases - Specified Upper and Lower Limit for Volume offset -
    Corrected the number of handles for VOCS - VOCS is made as included
    service of VCS because VOCS is secondary service and VSC is primary
    service

 lib/uuid.h       |   5 +
 src/shared/vcp.c | 547 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 550 insertions(+), 2 deletions(-)

-- 
2.34.1

