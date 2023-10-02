Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55678E784BE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Oct 2023 15:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238129AbjJBPeE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Oct 2023 11:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238123AbjJBPeD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Oct 2023 11:34:03 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2069.outbound.protection.outlook.com [40.107.241.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA29AC
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Oct 2023 08:34:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+RUKT4nEpxZoEbzoFt/K7rqzgTLWPY74ab7+AX+Zy7eJ87Sb/ecHfuUfqYk6qGMuOU1wumA9mJnBHNYxUjOGJVFT0WDsrLMXMF2CfsTby8igdN38kWjEGmRYLiW9+IQ4+Z9ZLa5XmNizWlUZ7HeFQSQmdx791zd71ehgeU2vNQBh95S+SFzi/++WbYF1ofCLqhztkjcH6LT3A0t66z0RRaFtFbERnaEz8DqZKSsaKnSs4s61+oAxnwO4sFSoB/j5HL67YwaNAQ3AiTh1wPAo6uPLAo6tlUpRlzPN8qCKkVPYS6VXc7WatUtll7/D4VSampd5BMz5n1D1b2J+ja70Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTOkF84pjyf82F/+O0736afRseteefBwPNaIXV/xTMQ=;
 b=GU/suQdfiYtkRFISvBfEGnFIIrkIUy3KdYtmbHB2b3JL10HkpyBY6r/PPpx7wC8QLLFd8slAa2eQA+ZWRPe8k5rUqdx/Pc8r1FE/XNwDqRIgcxtdo3lq0FiWrxmRSji4Miw3KtG8YX1aHe3UkDx47FM4VUvKCfCwMlmkLV7HPo0aImtr0asagPypcGn30K+VhiDu82B+m6FYiJBLM5iRi4GltkjiJXrSRv87zb7r/7CNMtvJFJC9z8gM1x+q9vYpsFrlHGwsm+W3bHbmRXkhxRheUwEaVEqi/B5cCbAGv2sh+Lhijgmf0fNWwyAs4vJI8H4n0VXled9jGVV2R6i69A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTOkF84pjyf82F/+O0736afRseteefBwPNaIXV/xTMQ=;
 b=rO0eem6iFVQ39tzrWdu1rKx/Teaj59SaORMHPjslBAG5CW3ppejC74Xy1poj3qok2CO7JENafUzZpL+zYnyqrq0/HwpS05GsfhcVpZMKvu7Lgm82sTyKdeyDTi5M8jLKxUN8OfA0miw+SSyqJW9DYCqxoJiSEgrZD0oY6ywxYqE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU2PR04MB8839.eurprd04.prod.outlook.com (2603:10a6:10:2e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Mon, 2 Oct
 2023 15:33:57 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6838.024; Mon, 2 Oct 2023
 15:33:57 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com
Subject: [PATCH v2 0/3] Update transport acquire/release flow BAP bcast source
Date:   Mon,  2 Oct 2023 18:33:49 +0300
Message-Id: <20231002153352.3163-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0067.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::44) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU2PR04MB8839:EE_
X-MS-Office365-Filtering-Correlation-Id: a45cc0eb-ad25-4a0b-c075-08dbc35cfe3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: reuNT3TzzmLmRo7n/cs1OQ353SqVNxOQJyCBRe3IfRY4HX9HG6h9g2M0UrFzAmONV/i56PrAnAB30cqRhpd4PFDTYrXuxiQ+i7CnTDyZnfUJnHW93MumkvMQ2HgBPhN/YaH+f3O14BAPdgyHhTxre+eRuhjaYtAJBN95JRtGHA5MJNmEW2OI6j0IlabSCitftFnOlbjyO5JNAUOwc0STsdy+9TDtmHfRG6xvEhBMIV2J5ihy6C9+9FtlyA74XHaQfv1pFv/HWDp1xQxyQYad5ECmh7naHIUklQ7nfcvhoDQgWd2/ccRs84l1ruMBnukoqbrHnWCloxoPQK4M+cdN0pW8Px0i8ZLCPFxQP3xvkJUY/XDayDIMMwBr+kvqM/KacfOJ5b7oC3rs/Q7o+c1OEyqDnrMQg9eEeRBC9syaQeAuWzPljZtlM7PqJ2iJKjvcZn6DlL+j95WShzZwEl0jNMm1MKn7ifC6TH0P6zgU3zwx4XCksrItcqshoPJy2fRYbrT3DKNdNT5GcB4tirtCYhrQWUyhDRdinrfq+QDkBbfar0l4Dz7r//QVP2c9t+eW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(396003)(346002)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(36756003)(2906002)(41300700001)(6916009)(316002)(4744005)(66476007)(86362001)(4326008)(8676002)(8936002)(44832011)(5660300002)(66556008)(66946007)(15650500001)(83380400001)(6486002)(2616005)(1076003)(478600001)(26005)(38100700002)(6666004)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R+HURR559GiTPsL9Ry1Fi624ivBez1YZExiMFs/fikDZ5tCCI+8CP24VgtM1?=
 =?us-ascii?Q?hRzxOOPWYqrtGQaXhl4/06/O841SBv+WtiK4EbE2vYuPB9jAGSDn4uRuKJG5?=
 =?us-ascii?Q?K61Z4WnknTHKq1jJkb60gpTw8yP7uoz42dTxZ27xuO33Q7ZnuEAkhS+7pA8h?=
 =?us-ascii?Q?BgyDZIb3Zbqv88DBbotFhZEEpKxzt0JYYf16+2UzWGDxLJPlkKYeuzwnI5Dx?=
 =?us-ascii?Q?KsY5omhM+NWY+a8O63J8VhDOBq5YpEO3zd5QLrPR+A/oE3cES5EIMLrhhRl7?=
 =?us-ascii?Q?sh2BymRguJcC0QHmgYmDZsHXC5P5QU2pGeMsuz6OcqPoNHOpbGIYlXDJ/Lfu?=
 =?us-ascii?Q?+o365/7Oc2I5zs5I+UtWXwSvKowyh53bOrcQpclio28KtfUezUC4EyoUuPYZ?=
 =?us-ascii?Q?C7om0UlYTE6uA8zLSIFk8WV2kIbdoQBz+R1YCYY/sQvtd9ftBUUvE/ChhJS/?=
 =?us-ascii?Q?xNRZ0NPOmRLrTQFtMStiyDz4hzfbIoCEIGaL7NTI+B42YTKKG5GoiSRgKexv?=
 =?us-ascii?Q?zc61kJf/X9VxtGZMTTg9s/9ZB3fvWshEqy7ccm+M3A2mEMlshn2oaxiijy/+?=
 =?us-ascii?Q?w/xA9dTaBgSHphb8ghbwXYwMWu9BYc8bZ+VEIU4jERG57JacuHfsZHio2DbX?=
 =?us-ascii?Q?pprnUsiiEF70oX82fzrW8nl/XjhSmpPubB2nZ1DHng+6Js7jGUI9OEeFym6O?=
 =?us-ascii?Q?Ad3EEBUUlWeuhR3z5MkN9D7zN9fkX/kSKQ3n/KQ8LAOM0rjta4bK9A5ZNH4a?=
 =?us-ascii?Q?jepdwWKOjYdcAtmluQJm1CsrczRFvLs1p1DgnMKX2uhyBEEED/vdC2xt+kGJ?=
 =?us-ascii?Q?dHK6iPUUz/sfjLEn6Uz7o+HYUrqCPLVYy9W8e18r3saeBaARSJL7A+QGQ24X?=
 =?us-ascii?Q?7vMNL0TFoB6NSXb42cZAPkE8nzvHG//apyez2kW8W7SGT43oXJDUSDiJJ3aE?=
 =?us-ascii?Q?3DKK6P0F9jo07h+XdMVmBpmSNkFNA9Ei5RyOOdSv4EWU1KdN0Em/7sA5DdcX?=
 =?us-ascii?Q?NbMtw9aNWkwesX5fR/PwwRmNTzKuPPQth2Q8E1uzQ2S/BTCTkp93SnqpZjQ8?=
 =?us-ascii?Q?wU3cyzOYxqOTqZyLW/pOA1FmIHd0JhkRbtGWL9bX100kPOov4fgXVurykhib?=
 =?us-ascii?Q?E8K6Jaa19ULJNpGMpfpKTSYHos+21abSUS2r/Cjo7vl/13GUXeUsdqKqEPpW?=
 =?us-ascii?Q?VXJhRSv2aSVG0mzyQeoyym7iV+MjhcDMLCCLWcoQoA/Fs3JocpB2HJ+m9c32?=
 =?us-ascii?Q?OVTjAVYkZQ8VP7KvAvgI191yRhjro/C2QCFjYo5EbCH6ZRxYztA17B0ntZUo?=
 =?us-ascii?Q?SvNGjXcZSCksaG79B8sVkHL4r/VUWLxD8rAyUuR0zmROgje2YESplEWMR+9P?=
 =?us-ascii?Q?ptMtllgPERSxGxzqJCmJ03pvBX4Q9wJ0f4XFBcSfQotOVVCNJeJ8AwmjUa+z?=
 =?us-ascii?Q?CJM3j3horAXX3a31bcMj/P9qAk12H5Ngp6IFbmCRhm7ULYpGSXVzL8z76USG?=
 =?us-ascii?Q?VcX5TsQNmYHqDSohWiGuvwp/J9l0hqEifAR0ciNgJqYvrjonF9ScXWL4u2XQ?=
 =?us-ascii?Q?4QWstsLI+IExJ/hybSevkpQb33PKVLitqP0hBvkMXqeTKjy31IrC8ROP7zy2?=
 =?us-ascii?Q?sw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a45cc0eb-ad25-4a0b-c075-08dbc35cfe3d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 15:33:57.3862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LIzDaLbP6ucNzWSbm3dIjZlQbDIz2/ya1scRmnib99B3sV7WdTZTO0PGbY+d41gcEeUm577HnD9/ntmg4dDUNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8839
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>

Update transport acquire/release flow for BAP broadcast source to 
fix failure on transport release, and second acquire

Silviu Florian Barbulescu (3):
  shared/bap:Update stream enable/disable flow bcast source
  transport: Update transport release flow for broadcast source
  bap:Update transport acquire/release flow for bcast source

 profiles/audio/bap.c       |  16 +++---
 profiles/audio/transport.c |  63 +++++++++++++----------
 src/shared/bap.c           | 100 ++++++++++++++++++++++++++-----------
 3 files changed, 116 insertions(+), 63 deletions(-)


base-commit: ae9bf50a27922f2f62a465b62800e90f0fba7831
-- 
2.39.2

