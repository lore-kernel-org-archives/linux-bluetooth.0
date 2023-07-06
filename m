Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBE2EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Jul 2023 13:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjGFNhM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Jul 2023 09:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjGFNhL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Jul 2023 09:37:11 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2055.outbound.protection.outlook.com [40.107.22.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479EC8F
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Jul 2023 06:37:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxlbjxsrnuN0pFhpzb5c3xfoZzR3YXmuPt+wTj7UYJdVzLJPrt1IMVz3R8NOm1IaPLe6EmRQ9pLmE5wH7/M5jJxqozG/DXE3Ib9mVzDbkPhTrRLWCOaVkTWaz6y7ou7DLnEDTAS69b8+BwH7NoC+weMxA4SI0okStubbszzFNTHJ9MMYBVccme5p5L6paVs0SK1MTj8+M9SzFAc3HpSmIjBjgF40LOSi5AzGrLQVY2QD9SxliFbSRhBYsCTjEbwoSDf+JM2S+7oEG2mC6ab4/TZ/E/ubX6T/ndEwYJrbLUq6m/SZAiVZ5M3ErSxRThP9X3vLw3SNKPx0VCt+uKkMVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kujAM5FJGSvtXoeyWuCTgYBB2xqDfhnJmLrLhqFT0gk=;
 b=QTkvA73RKelyc4WDXid9aTWjip9rsJOK78VCQvCmNvA78zIuYGKVzJSmAW/fSKhEXl+2EJDOIc5KbZyi1TmCAnzl9xffzVNUcQmqnQ5FI/VFsKZeL1yXsKrwVDNF3uXo7hoiE5fVSjmibZySQnRtiqi68JT2oeP1huNrOxEMLgmG2g/i/5CCUL/yVHPIKc2PHGl46Ri6ZqtRpjxw1tg5SnfxMNZTPz5NEEpXVPqYwLhbiabFxWygawqZ+itl1WtDYzlplFjTwdli+o39y+FapTp3BEJeh3SoryAAgoo8zbNVpwkUwA1HjkL+1vpldi5fmf0YEFMTAdER6b5E6FtQUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kujAM5FJGSvtXoeyWuCTgYBB2xqDfhnJmLrLhqFT0gk=;
 b=MBHxd7ObXCf90XNjSKrcuPsex2XFAS6U0/CR8SYsK/QLgShpa5Qc1hrlxUNwafvQ7vH/nWionscVcCopSAB3XQ72x4uQKOtovuTAToy/ZTCCoaH/3Tpo4lFGXBiv7FUwhluJgKCusyBodo/vIJCcwOv8GHh9MNGE5c5bnxkzuA8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AM8PR04MB7443.eurprd04.prod.outlook.com (2603:10a6:20b:1d6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 13:37:07 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab%7]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 13:37:07 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v3 0/1] adapter: Allow broadcaster to be passed up to application
Date:   Thu,  6 Jul 2023 16:36:04 +0300
Message-Id: <20230706133605.23325-1-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0109.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::6) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|AM8PR04MB7443:EE_
X-MS-Office365-Filtering-Correlation-Id: b7bcffc7-d6f7-41ce-f736-08db7e261782
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n+yxFMCWcxF2bLcedypBfDAMl/b0qA5158PNPsP44PgD4MSlYrjSSaznAeK+iNwWWIB+fnAcm56CNEmaMGHsuiYGSsuyXqBCU56YtVrsJSoyb2muJNdep4ZUGFQUKPvCOD2RvflGT/dfEO11xnhZMnw23RKd31vMmTPu5XyJOLskbgrvGvgdQ4Vvbg5MuUmY00g4MsBsPJhHam7lg341FdUTJ2ZGIa2fWvjDT2TNZahocD5Q937XXSZsDG12iY71lWv6Ndrq0ZUsptyro3BxSIfiQQst8wfacgRiYYJPq85vkYSefa2lfOWuu3UyHBzDph3EJ4ZD0ajd2KIU3F6xJwew2cTG6k5z/+i7dEn37MAwydxOd/2GCN4JMM6YdF/CDDn5neJs8382PTAxVtu3Y4dkiCz7WEMs25qmfFr+S1JTNyiO+Rs3gt4vA5QxjTDNOR6C4gAHWX37zg2efaSCw8SMQaUNCgNqPUXXHFBP3qnP9SP1n2ZLWOaj3laLkuZ+lqE3PCVODhr+nWjIx8HGNEHOviwWlgseLIbfT8uBUX+nH0WZHYpyHhlgzngupE725hdmoVNuYAN3PYadNQzBNHb+AFyi+zqXjTL7M4YrAMUbqDQ0dIrZtUazWU9kup3S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199021)(6916009)(38350700002)(38100700002)(66946007)(66476007)(4326008)(66556008)(2616005)(186003)(86362001)(55236004)(36756003)(6486002)(6666004)(6512007)(1076003)(26005)(52116002)(6506007)(478600001)(4744005)(8936002)(8676002)(5660300002)(316002)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RifGi8uBtM8xvndPdcEhDyy3PX5Lp3GHOwCMWKsJdoAq/oLsWrhh2DIQdjhM?=
 =?us-ascii?Q?oCOAY7SWMRog0T+MdDcusfyWuGxlScTPZ3x8Ido3TTsXZcbzYx4RioAUBEEO?=
 =?us-ascii?Q?DEPGzJ1qhiUdDWYJWgGWSGtzXKfZTDFEFTrVGAk7Qrj4xZdlmkcr5xmcapku?=
 =?us-ascii?Q?Rj8IGA1oTL4XV00Qy9PKABdl3Z6TNUIBxjtzINoVJAYQPugPU25B1FCJwpE6?=
 =?us-ascii?Q?iqTGgk78wz9LM4J3GjpcpxFzZirGqX/CBrj4EStjUr2Rxf7SBfKwzLFGXIMV?=
 =?us-ascii?Q?AOZLL6bZ+gDLvfERRM8g7OZwgF5L7HXlPGKk3rX65dBARS9iL65XY3g0UTT9?=
 =?us-ascii?Q?0qjlqv3+xf7al624+jmDUOBxm00QtozcpC5S9AxuSjsqgyvCuvN4qfEXpO1b?=
 =?us-ascii?Q?spMsS3MSDALtdLXVElMc/lX6IwIvfmURdYDBYHUWRgJa9uZH8h58wGCOctuE?=
 =?us-ascii?Q?DnwPbpgumWCnHCWSU7Wek0T65fpy/dPsB8/3xhRgxmETQNpVykYX8K/WOgk8?=
 =?us-ascii?Q?S34xvAdZCTbfYni51HnRVG2U+6ftlGic4gOtZ8H6NoYqbtNNBrXSa+pg/lIB?=
 =?us-ascii?Q?OW0Ma/2az9w3mc2XwtBvugPAQLgrnN6Vc6MhyLBU4gCVAyezYYdD1Von0DT6?=
 =?us-ascii?Q?5r59qrQqBuLTeO1WS167U37GRhhPYzYCnmKchS1VSQGNYHp5sdBdQgNTAJQS?=
 =?us-ascii?Q?iAdIyvwJBwdq4PUiIVb7W0AypzGyk887vEXezZ6gBDtjMdV/KOiCfcNLa2UE?=
 =?us-ascii?Q?oD6b7Lqjr6a2/wLc6l0S8NVoyT31o7M+Ql8d4LesJDS5rlXh9FgWkyR1lIMH?=
 =?us-ascii?Q?a5VKHccbWVgX/4CJLK4KmmuLNJuwfp3QMM3Z4CayHZfNbvVnsak5F9QvbAu6?=
 =?us-ascii?Q?KHLuqSPpa9Zihs/L7mR+hhFPanvte8VXJuq0XalCxrdXOi7RU8Mm+v6Q8a8k?=
 =?us-ascii?Q?J3O8LzGonCUYsXvAQSShTEAtqHl0nVCmxXzOpUwcK0NSj3lbXNcMinrfHtu3?=
 =?us-ascii?Q?b/4KvJevKj47wRMuKWncfGbE+MQ1TecEP3bdHaspSCoWXGr0bq3k0dYqnR/c?=
 =?us-ascii?Q?d7zdRkNIx1KVsVTDbnmKQ7syBtIUKWZnQGzesAuqbFJTxp6KakGVgsgOYi16?=
 =?us-ascii?Q?dSbf26p6RzrpXoEn76Eb1iJGBHDEXBOlweInUnnQ8MbWNbY/4NiFqxfcC9Vb?=
 =?us-ascii?Q?ETk5EUfAk0h3oKZtyuLLY4PDGJps4a33q06oLOiU1GMfJd5PqVuhM4fouOf2?=
 =?us-ascii?Q?KpAy8kQg4/gorOL+qfHvM8HKg86UMFpXYo+cYUvqIhO7UMldRcK9esrYyg5x?=
 =?us-ascii?Q?Q9tcizxVGPTBDMdEBCJyB7lqT2+paW1qAW3IZnCZLpIsW7ypQyI913XuxP7y?=
 =?us-ascii?Q?2/vmbGu6xRl9M8ynM0JW4SoyHw5FI4bwHdEs5a6qNyl1/poW1XHmEddMhS7C?=
 =?us-ascii?Q?ctxLtlJogTqtJYK+qWe3+bgjk0trPGwWzYLgkW8K8pG+Mp+t68MGXISQ9ahN?=
 =?us-ascii?Q?gwlMgf3Qb2p3e6Bej0DTuhe0LmF8JauyuJVVDVhZp7wGnGx8QEqBY943wUVL?=
 =?us-ascii?Q?iErbJGHC1j7Ct0kPqXcjf7C2xHlsiYk+F7b4c+lg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7bcffc7-d6f7-41ce-f736-08db7e261782
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 13:37:07.3473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rrML2RWl5LPYH+AVRFXFRTbyNtjLhcJocLQRHLPBp0WsnwlJYmFXCwRGzWqkywxKWioIFmmh67QaBEPNvInT/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7443
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Allow a broadcast advertiser to be passed up to application,
if the scanner is an ISO Sync Receiver capable device.
This allows for a broadcast sink to discover broadcast sources.

Claudia Draghicescu (1):
  adapter: Allow broadcaster to be passed up to application

 src/adapter.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)


base-commit: ddfa40977c7e7b8723fc3ba9389822631ddeeb5c
-- 
2.34.1

