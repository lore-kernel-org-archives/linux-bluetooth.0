Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A19C7EE25
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Jun 2023 13:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbjFLNdl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Jun 2023 09:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbjFLNdk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Jun 2023 09:33:40 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2084.outbound.protection.outlook.com [40.107.7.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62F1E9
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Jun 2023 06:33:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1HpDFuCbmuZ2G9b6X2dVRwgweXolqXbx642tziHiPyJE4+WUso1efXjobYbjkZOE5UX3QaBVP2erJaxbLkJILLogPMqgv502/6pgU1KuitasH13UZubxDjfHpf+9r16H3uvYQvykP5aQaCXYwcPSDuPYtd0UJU2ReTadjEKmDrUWugo1qj9cVL0nrrj93x8SX7ph+Ge1q6IDZkKuhpo1RiR9jimanbKqVoyfXIF9Cdp9DahQbtNPbqZKfPGhSwrxvgloeZnsxdNpxWpmGSiAnT8esgHB8Pds+FposU6LD7ePZdoFPiqDfLwo1y/q3l75+VO8Ex/d5+FTbBG1aRw5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvW2J5TZ+UApjMZpuxQjB1RumBpxlf1md8epeHPbuWE=;
 b=dysCTc72ZtUepjhNNXkG5LZJ9xU9cbC8BX/1ktfEuDrD0g6eunAe7I6iJjqvGArE9L8v7cIT9e1W3522wobdtyikxIkICCsUUx+k1OglQHINYvZLEj65o4o7zmGnAheU2ClJOeNOMnWnln1jWyip2T2cw+kiM+3F8+yuB7SgVjwEmGeWbfyHV/JWHVD74CIj1rhqiFrthl+sc4SvErZZ8zRVS+a4z0vT1fCtXPr6Ovov9/88xE1l5VJOJ1psooII/9dricdVSYaxzsxuBE5BwJpNX+r8I6dY47Kc8K8/0wn2D3Tm+MbPynMK1KapiETM8AkCmOsGi5VsH7vjYlKvIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvW2J5TZ+UApjMZpuxQjB1RumBpxlf1md8epeHPbuWE=;
 b=NEo4+XD1dsxpIa96aT8jiqrk24ZLilNvWbJYayn7D7oPrZ9dgFJFfOM3fHpA15GAkpFSyi6FBNILF3bLcHUQpeNq7U4MNSck8vO8lpDY6BzvRb8TS5tEnq3LSw5YB2tLXYYRafDlhos53zloNOrHIz2lmMojkfqXpGzE3UOfo90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16)
 by AM9PR04MB9002.eurprd04.prod.outlook.com (2603:10a6:20b:409::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 13:33:34 +0000
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::ad2c:857b:a144:9af4]) by AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::ad2c:857b:a144:9af4%3]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 13:33:34 +0000
From:   Nitin Jadhav <nitin.jadhav@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devyani.godbole@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, nitin.jadhav@nxp.com
Subject: [PATCH BlueZ v5 0/3] Code handling for VOCS service
Date:   Mon, 12 Jun 2023 19:02:48 +0530
Message-Id: <20230612133251.194-1-nitin.jadhav@nxp.com>
X-Mailer: git-send-email 2.33.1.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) To AS8PR04MB9126.eurprd04.prod.outlook.com
 (2603:10a6:20b:449::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9126:EE_|AM9PR04MB9002:EE_
X-MS-Office365-Filtering-Correlation-Id: 66dfe1b7-0a99-4785-c612-08db6b499e9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C/y0tP3ytwkGSsCFO7KhXXEHOLkFlZ82QulGZO3U/Ga7FcLgn4i9JaWAIi+NcRTudEVZFvHczbt54NchrOiSqHtks0VgO33PoMihfP8E7gOOhNF/JRdjM9L6R90RNO5nDJtWtE7uCDtFvdaRriJbowfCm0xfeGgOR6wgCf1H+MXQpf0+3HdzLO78M/w2vuJWhjMGzByro9bodzoNm9fYOul6yY5NpRKd4whq6XqPmj2avy4QBzAUb31wKHxCY4wns40hJ1Uej5HQ2aNeSOHtXv21R1w2lGLthC3c03HVJ0GufyHiXTsBd1oV3WWW9rPuRezMsxt0topAo8hdh4U40DUaUWzrZbf+Fex/ZvGwCGzYB/Y503178iOcRrnU3e8ay8GEzUxRJYFR3/62k7OO38ZKcuK8ao+5iGdjk2SkGi8zf6cucA8ChGJbMAhEAesgwrhrmKKCrzemaHKzNLDALvmd1S7LVVqLeeHAB5xYAXjdE023eBDLg4xnvpHlNltqR7XKBUSuvSEvL2EHuqhjvMg7dCG3jTUsOUxtxcSq0m4ovYJbNaHvXPeursDQx32M76c3zbF3GLiuQr90QGrgWw3/QSHH3MzxnRs9rxFsBqMYG/bjcscwS7NTeBb+SQ/i
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9126.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199021)(52116002)(6486002)(6666004)(36756003)(83380400001)(2616005)(38350700002)(38100700002)(86362001)(6506007)(6512007)(1076003)(26005)(186003)(4744005)(2906002)(5660300002)(44832011)(8936002)(8676002)(316002)(41300700001)(6916009)(4326008)(66946007)(66556008)(66476007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kcq1VJNA7qQBwqq/dt0GQ/BavTUQCgpToiTUcHKtccTAH8a98X0SzEUsxdxw?=
 =?us-ascii?Q?V5Xr1u+BGAF4+VaVayJ9M9mCkfc1ApSrftZPcJvwGY6EKLx64lT5jyUaHOUp?=
 =?us-ascii?Q?bvIHuRLLsz3db07MXE3VGdYB8KRD6w0sL59m5dz/9+AnRCyyY/yuS/LaUv79?=
 =?us-ascii?Q?lR3mXZKvX9hiPyi+7e4kiqCFLdXsu3Sfs6o2rVEOlMZl2TViPDMpTha1sC+P?=
 =?us-ascii?Q?fJ40O3C+UsnodZ6PjJLyVqMpflfLiMy8eJNSTz0KnobopJr6lIw1nBoIlbEt?=
 =?us-ascii?Q?J0CUm81U33mUTTDgMOIh91keotCB+88qF7306dXMxtZ8u9VN/5xLa7eDQq6K?=
 =?us-ascii?Q?Ge32Y+5FgEtzZljMX8hX3dSctcqujn+AKz2Ir5WkTEE+nprdfaIVRFZeuZCB?=
 =?us-ascii?Q?sO9Ks/8hdOizRHuokN2bwayQt1tFhuGl9MHHtii0j8tOxFIrEOHy6/b4Z6d+?=
 =?us-ascii?Q?LT7J0toyNytpY4lUzP8x9pJgjkTQBVwixx/IRLkEZrpdEczwiyojpoL0IqNy?=
 =?us-ascii?Q?iAbUIz14QeY/67QMok88z/zrrNuf+1zK77mjoSIg9WZBuVCEeMXnlV8SDlG9?=
 =?us-ascii?Q?6+w/mvSHscdjckqqS57FpI+bSdZ+8qCcbPiLmWebtMV9Rg6g3t9DlcVbNxXI?=
 =?us-ascii?Q?bMqIsMjQH2wssGNThjYlCYSFDY6p1rpAEsDgo798T9/dxJ8zsW1xD++NWp59?=
 =?us-ascii?Q?ULGO+4TsLOcql2Xi8vA1nKOxutx3UDM6wMF6dJ4EzzqAuecAtAPG7aUEqgum?=
 =?us-ascii?Q?HjPv+gn3e/QHn3Rigt2UYCVKAadVRgtjaK5Mas7blJReiwqKhwdBegFuR2Yj?=
 =?us-ascii?Q?6K1MeLF7SpYd4eLSzzhJiMmkPUll7J0HfJ2xsCawMKA4uADIyXd192/U2XK5?=
 =?us-ascii?Q?pQYMqmZZbTW9R2RO3NlhS1s1L5ffNsgOBxMGPlv5Jv0Ff8akWBE3uQz8F70F?=
 =?us-ascii?Q?m+BHujMKABwCsx2GQkUOhdMKjB61ZSeD+5STTHVvulhLgrPx/6cahGHvq+Sg?=
 =?us-ascii?Q?zs19guvokOTK9xOM24x3iDtYT996ctY7QHeyHIQq2qrhELIo+8v1KKyohtlF?=
 =?us-ascii?Q?5kje7XQ+M7QEe1u3YfL5aE5oVZ4pnUIiu4Mu/KdQWHVctZkvhN1ZdiWhIVtK?=
 =?us-ascii?Q?G0uELOqOi3ToO3VddvChUn558Gmx6mU48ngQn7sS4B8JXDAzG1ZBaKhluPMe?=
 =?us-ascii?Q?dx+ZoYxRmpu6YylqWOhvIzipxzTLIM3YV+ykvajPQglxXr6lSWOljso+fjG3?=
 =?us-ascii?Q?cFaP2zoZULEi8Iemq6u0zCokwjCXt4M3NsgAQo8PnXQlznsK1zmzakMqdETe?=
 =?us-ascii?Q?C/FejX+oV9/zoEPVOOjfzS04k9qT+ZlAugPPoTPFftoE7PA0QIkzdIxlKHdp?=
 =?us-ascii?Q?h0+kX6/8MyrhxIFU+mKBd87HIvXuYk5LEX9/+h1tuMoA25GF4Ap+YV5Xv5nN?=
 =?us-ascii?Q?myKw28McmBo85h9KmzEdxxeQJs6feDL4azCPDS/8UCJmIiJbQhO3hzhidJRc?=
 =?us-ascii?Q?5M0Cq3Da1zcniqcF9CO8PjFth5VLumo3g1L08szqSTBRzlj2q3Fwhu7D7Phe?=
 =?us-ascii?Q?BG1f4ZSErBNfPOJiTk/tcuonFV5gVp34K7BfP2Wb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66dfe1b7-0a99-4785-c612-08db6b499e9b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9126.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 13:33:34.4011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hr4jGqlwDEpCei0EWSufjmjO9gVG7fGG+1Hjn1yOG6UMroCJlW+kCuFOvTPSgNt6f3QaDCQYY1f15zHQ1lEVcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9002
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Maintainers

This patch series handles code implementation for mandatory features of Volume Offset Control Service.

Implementation of following features have been handled in this patch series
- Volume Offset Control Service
- Volume Offset State Characteristic (Read, Notify)
- Audio Location Characteristic (Read)
- Volume Offset Control Point Characteristic (Write)	
- Audio Output Description Characteristic (Read)
- Set Volume Offset

Reference Document:
- Code implementation is based on VOCS_v1.0.pdf
- Testing is done using PTS in reference to VOCS.TS.p1.pdf
- The verdict is PASS for all mandatory test cases.

Thank you in advance for your review.

Warm Regards
Nitin Jadhav

Nitin Jadhav (3):
  lib/uuid.h: Add VOCS characteristic uuid(s)
  shared/vcp: Add initial code for handling VOCS
  shared/vcp.c: Make VOCS as an included service of VCS

 lib/uuid.h       |   5 +
 src/shared/vcp.c | 565 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 568 insertions(+), 2 deletions(-)

-- 
2.34.1

