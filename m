Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D30C7619A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Mar 2023 13:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjC0Nps (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Mar 2023 09:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjC0Npn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Mar 2023 09:45:43 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2043.outbound.protection.outlook.com [40.107.21.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA2840D6
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Mar 2023 06:45:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chB1+nuGNi5kDrxgPiv9LN/Qw+BiRx55Z/iSVQ8Z+oeojdodNYvLSsV7b4sCm2CFEHeOYm9BZe6WQzAUa1WTZTSvGO+2/iGcBZkqrgEoJ11Hc5z1Q4ve1O3BUpKkmVZ2Ep1V1aWqeJvNvLxPnrKkrnyzJ55fGgQT/SQcdP//navkHzrN4oHzJwixfZwQ451C2J82mjDIt6IXzmh2pye5QFImPCSrFqnKnMavczRyVow0HQr1vHBJKERgFQcJu2c2pH67x8EnTa/vkyCjdtQOjq+FoLy4aX+/42ojskyKyE6ol8Gio1cU6PJJ2nBtwP1C5PGfVTJMZQugmbHQmcxzXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2ZenPBlyBRx15+6VwMtsby3QEwSMGv/C9uhZQmXUqA=;
 b=CQXDYZhgV7Ysr5ODD3SzluXTMCUk84Ml0dTBNCoS6JVPW90rJ0OLVKYQ6FiQTTLHCQ8EY/dzvvMSu59rHP0yMELl9uYPABNyi4VY7AJYBb0YIuqNjmKbctTNYKfFEPABO6p/2FoG9+PDlP6YIED14gKXNyPCSvZXUUuti2+kxNKqvJWvOd1dvIh5BskEqvtf9IuSgIEH1jYUtL9PH3baeLUqU+Q9rddgct9g7wJc8Q6E4YL4D+7wetRVy2wem/owWnJSM94IoutZRxG0jCfBxj1IYuxWIi87I6gz81lmAJqitK2RmRLQRr7sxsGAK821+3ty43D2ol7uEobh5OE7Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2ZenPBlyBRx15+6VwMtsby3QEwSMGv/C9uhZQmXUqA=;
 b=XWf3iKl4XfXJHPTcK2aNPcolfcktFiSvnBI0kxi1kzZ2OqWXGVTssjyf80AKN7F/aFpLs08N6ER0ixMty46nwinzTU40GEh1qoBwnQELiChBH4BRlarB+hZfw93rnMhyGx0lf+MpTpD7qCN2+u61Ic3ZT+MJNGMCCIF0Rh3RzHM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DBBPR04MB7932.eurprd04.prod.outlook.com (2603:10a6:10:1ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 13:45:38 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%9]) with mapi id 15.20.6222.030; Mon, 27 Mar 2023
 13:45:38 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 0/1] Split bt_iso_qos into dedicated structures
Date:   Mon, 27 Mar 2023 16:45:21 +0300
Message-Id: <20230327134522.14308-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0015.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::25) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DBBPR04MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: 44847416-ad0f-4de4-7ab8-08db2ec98c8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Deg0KDQTDGHDyXkBKmPe5jqP4bFHniXJ1GTYeHo1hsVwQgNeGiqmmDegHDmjakCLn6sU1dWIbVGJAiPD9HU1HNQS7hixZzNT19s/Kqi3S4dSNO581XoZU9f0QucBgllR7wnDzjZWsiKUyoSnabaGt4s54frko/RI3+U3eNfJ1jJpgbqd1i1hLpQ09N4CyTuIgA7HVFIWxNtaOhiCfmA0TT0zyj2TQQcPdHiKyFmySw1w88cm8nJwbpZIoFcDGiXB9bjTF1Ho6qiuhq2KrJsx+VW/LuzB4N+mBDRp3HR3P//npJq79cxDsM3ppR9azWzio9egD6oPkOla4AOFerXjsyZRanA+EZPXNV6wJHBfxLpOlS/zfDpDUFY/qnngQ3hodmSTmZzINqGsoUA8TjaxJ346L92eEKFV7dR2E0UT0tZnkEH37x6cn3enZfGmRjSLBAkE9+LbcYxynHPoNhHdEdkhGpuQ7t5bSO9pbBmIML/Cr+sILUSDZZJnX9Thh6IL/W77j4TwWW2yL9QXro8dp1eufjf+dFyfXa6zu0reu7CCH9/YxN6z9aCoCM6ebiWsiuB5SP/rDOvEqDagC1tAOhjqORbzqNVuZXLZG7Lk/Gs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199021)(316002)(478600001)(8936002)(5660300002)(36756003)(86362001)(44832011)(38100700002)(4744005)(2906002)(38350700002)(4326008)(8676002)(6916009)(66556008)(66476007)(66946007)(41300700001)(6666004)(186003)(1076003)(26005)(55236004)(6506007)(6512007)(2616005)(83380400001)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8veKgbQ2eDGuUaSi1ZwdNGHxhEzTN6eKRyPJuI566klk4goobx5/xwsLTJ8w?=
 =?us-ascii?Q?MFm+dWdmykyPol5x9mJGze4EqV6I2RXfVQRMH9KQRLk+phjuwF9mn/Fg8Yjw?=
 =?us-ascii?Q?6T8U2e++wQBpEkNOlskqqvcT2ZhIFjhECTRrsOfe9ceYVKdQG7zElaOqbnM8?=
 =?us-ascii?Q?uS6nvYTkuN+oUMO+QJodskdXjj0Bp8xLDosRKZuWZNipuBD1Gwr4VvT3FfuI?=
 =?us-ascii?Q?ucKs70fpwA2mAwdsLMJZW3GTFmK9wV63k3/frT2HwAHg29eb24aT4xaV5HRz?=
 =?us-ascii?Q?avcD16HKRB3tNhDHUycy6BP7YK4IStGq2sooD802PWNlOWN+K/RMYpDwD8S0?=
 =?us-ascii?Q?HOk274PhqKPggBwljh0G2WbsrP1Z10CyH+iLfrOFxh3iQfIu93lU+YJOUTmA?=
 =?us-ascii?Q?ND875JU3RyJXADy3ovKAhnKpS9zkbvYPYGLyco7F+AnH7q5ZI5luxicJqZ1G?=
 =?us-ascii?Q?pctBvcZehQiHNV6clgrIjXzr+pxmGgI1I6Q8yTYryNM/j1GX7+kU3igLT6w/?=
 =?us-ascii?Q?2ZxLtKgUMgceDArBfunTnEk3DU1vGfl4dIWX926nBbhKtUEgYgibJER694on?=
 =?us-ascii?Q?uA+XImO2GdBi9PWTm4ZRAy1aJnUKFlN4T2IJ6q4nOYgxUimRoQdvh4Ps9MEJ?=
 =?us-ascii?Q?iwTl48PvKh4l8LCR5qRKExlptnaup1JcQOcLENZb4SAcsc4SyEiyDIu0WgUd?=
 =?us-ascii?Q?ZlGavvNKaOpYxYDVN559iFtGHcHMVmn3KvGGepb0kjSsc7Lh9+uSK8iA8iPz?=
 =?us-ascii?Q?ynRGMBg45mBtYFon93ToANvSAcu2XC5S/6M3AV1wwwacnsgV/J0snPspOnh8?=
 =?us-ascii?Q?VeYJYspX4/g7RqIJvOIMjvUPvz0JqLgJZcuacl61khBvmsUmR7//xZrk3+Mz?=
 =?us-ascii?Q?qdhOflHUqQWycchiyZ/J/GIQNo01bjZVYMDxruZJbk7Qjpm+Uqcs3EgfEjFe?=
 =?us-ascii?Q?HspT5o31x+NHuSt43bT66M0eEGw0lo1d05VqmwCsxE9dKRc/oTHRzQf9F+/D?=
 =?us-ascii?Q?leHiU6UDnM0M5A6T9cZG5es8676sC+4ymSrqcCjaAvzYH1GmzQ2Qb6B8YdJi?=
 =?us-ascii?Q?HszuqLquUIGOew++tWzofmbqrOymZdRoZ8ty9xsYJgfT0D6mXjTSGw1pY4lY?=
 =?us-ascii?Q?sktL2+Fm1uwkmceOdbxoVlxUH4Q7JD+n041kVHJzOxyAAG5ulgdJgdYjDN/h?=
 =?us-ascii?Q?ei/WduFx8m+QoNbuC5GnT2Gei8mojCnFYO1dbsDOwXc5H5MxmC/jTQNctfjs?=
 =?us-ascii?Q?WC4m5bVTwj47vOjM7E3bj1ce59jvoI74n0UFbfnDY3n5Y4Q7LuOb3tC07jd5?=
 =?us-ascii?Q?RyR7E8Q3Zuf1j4lvmzCt4pAna8LOW3lvlrHSXKwlHW72K0SUzGszWt6bdgJg?=
 =?us-ascii?Q?rx6yynncp5PKTnxuYeHIMR1MIMPBz0Jqg/AJNrbBqwak3jrmR7EJc3sukODR?=
 =?us-ascii?Q?kMgFFliwHpKE1qecgIRGb+sP6qGFQe/TkXUMY5PYgpG9b6a+mX/rSRKUtK5F?=
 =?us-ascii?Q?IJKVBxWpYF0SDItd8E2Ui7m28XHp0UEpnajnhCoZeiIArln03hHoSrnWfheD?=
 =?us-ascii?Q?P778VmtjxTdAe6EUwAWIFc0KcDJbWosdq7rNyuWl7kv8cW9LggHaDyvvN3dr?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44847416-ad0f-4de4-7ab8-08db2ec98c8e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 13:45:38.5875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sbQR5IaQwRF+gklQ3bc9RPQYT8s6ogoJloyXnIBiw7PKQNzndQJim+6gJCeQn2y1Qajz3J5TX/jvFzBwZAKSbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7932
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds support for additional ISO broadcast QoS parameters,
that the user can set before performing broadcast procedures
using an ISO socket.

This patch splits the "bt_iso_qos" structure into dedicated
unicast and broadcast structures, so that ISO sockets
can be configured with dedicated QoS options depending
on the type of ISO procedures to run.

This patch depends on the BlueZ patch
[PATCH BlueZ] Split bt_iso_qos into dedicated structures.

Iulia Tanasescu (1):
  Split bt_iso_qos into dedicated structures

 include/net/bluetooth/bluetooth.h |  56 ++++++--
 include/net/bluetooth/hci_core.h  |  17 +--
 net/bluetooth/hci_conn.c          | 104 +++++++++------
 net/bluetooth/hci_event.c         |  38 +++---
 net/bluetooth/iso.c               | 205 ++++++++++++++++++++++++------
 5 files changed, 305 insertions(+), 115 deletions(-)


base-commit: db0fc80ec686774f1ca4606e752bf42af1f1cd97
-- 
2.34.1

