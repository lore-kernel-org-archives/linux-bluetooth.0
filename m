Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DC0E7AD58
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Oct 2023 14:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjJCO6F (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Oct 2023 10:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjJCO6E (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Oct 2023 10:58:04 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2065.outbound.protection.outlook.com [40.107.247.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5E3A1
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Oct 2023 07:58:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnR+0NZt6t6TEhsSvlYbwzKOQDkr9vFx+CUPCqcU8GoGl6yKD+DuKBasB//AqmMGV5MZejfHGK1qxqzlFEdYCAJ3txE3ADvnujofyneRr7HybiLeZ1uj1yTcIgnY8QxebC6rwzhKmDLGGSC6ObZJkr+Z5Wgr4WSLp77otPIxBZ8S+wxIdRwqC5FUR1KbyvjNoQYSsgwn+Y09YCmwMQXd+W+73JIORbLhJoxwMkvn66u031NrI+CeNNaEI86qwrbXeLjBKQ+HDdot1mFCxoX7qX+DF/vSn+1ZjNwI71rWeFNpdDhK+Bkj0MevtWmJT6sMJ86G5YE2n8+HOZnp+8EnpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gE3v/pOM56quaGYoAbl9t7POFmysKkXZPvd+lGGnGIw=;
 b=XQpfPF12rqg5vcuNKZHCIkPyouaqCj5pwECubim2d+0BEg4xLAp2dsLHtGeMb1Ohia+98uDh7FQKO/vNC/H0SvZqo1TTlhXtelAgrRT9enjDC6OArAbPtqn001eYzoi7xpHxItEDtSOQ1iKeOcQxcwDMcCPd70mx45Az4yWR0Adv+JaoVaGl6Fbw3JV2fHfgH6VQZA1geIaEHUXE1hAyFTShe2YuKplxNl1tbY1iZQiJHJ+BihQ3DlzkAgl/Ufo+ahj5xGve7T2SIODWfHoEW4l87Ut3jTmpIEtRy95O8y+fq2xmzErLsiETjeFCPgHmDtgSsBARzGEs1a+59AMdag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gE3v/pOM56quaGYoAbl9t7POFmysKkXZPvd+lGGnGIw=;
 b=ayoDxa3PCCQOe/7GEAS2iVYu0BAikBR5L96qXbYgxhnwbeFyOHL5XIULaWf1q/rbNaSktkBQSTPVXJOZZflwe/MUwzLP8uSIeAUDLL6RVjVmHIjmzwAfZtKyiP/fDKFIuwCFqSW559iLSkxa97KT+KzK34aqn5IHEGZrc43Z8Ec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB7824.eurprd04.prod.outlook.com (2603:10a6:102:cd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Tue, 3 Oct
 2023 14:57:58 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6838.024; Tue, 3 Oct 2023
 14:57:58 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/1] iso-tester: Test bcast receiver with PA sync, no BIS
Date:   Tue,  3 Oct 2023 17:57:53 +0300
Message-Id: <20231003145754.3667-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0021.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::29) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: 6203a60d-24b5-4552-3f2a-08dbc421220f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ze2v0lC38jDS1IYt/1zmPJhjkPVlzziGr3udQ6p1K//h1Plia2v0asH9tzxYd3paMhL0lOL96reOe+7Skoqn6YTft2PCQMhZjYHIIBiNT/qFCLm9H5A2DC7I9tg9b+48xtlM6OiZh78JNMsqAfHLIUwS13KV5IlK+184hVUfUw2xTSqAZDiazRkEJj9yFy9C2Qq+Wrw4pyufil/D6WnUaGaT26f2lw5shwgcWz106sv5tBGTgQwGefbjmulVETsOxGMMp73lLgqDQumheegrS7B/PLiV0kT26EWaPBaryO8ICZDDjjMsdUD7Cy4wNGW19x2RZvbVH0wvP22tTrO5vxwt0trpL+hmPoM51U3XxQIOkGYwk2T0ZGOOFMYDJwQEUDWImdLwwFwq5I1cpkwxN226ePjN4Tt2/ry1oZ+WLQ2jmXg2zP4IjX96dou5VbbqkrSZnMQk1n4G/tNoLH4oVNysr64KOOGtcMCV7nEQIMwUmFIuJ6CHlxYibbohxZ6eJsoxeDisrX7s/Nm0vkQ0Zeg11ad5CksdWCobvt2kO9OZOHJ043rMVHLNNQkgv6OY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(136003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(66476007)(6916009)(66556008)(66946007)(26005)(1076003)(2616005)(6512007)(36756003)(83380400001)(6666004)(38100700002)(86362001)(6486002)(316002)(478600001)(6506007)(4744005)(2906002)(4326008)(8936002)(8676002)(41300700001)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?piEdy3pebGnNWiYAF0g3H3kqrUneaMNonisL5oa4OB74ndCjPYzgNYD4KWNc?=
 =?us-ascii?Q?drRqhnGBxuxqD3gmukIdFQkMOYV1JzDvCLC32tNOPsHsJqN6Lgsyg0c5YwlP?=
 =?us-ascii?Q?vRwJwYC5w9K9RxbgTza1FsT66cVCr4W4Fipy+FJGMGanySHOGvIYyXU3JRSt?=
 =?us-ascii?Q?+Xi+MaLAr3mq+jzN5iMy3EZarIzPESftFTZAAyEuMaTA2bKbeC3Nv830mxrG?=
 =?us-ascii?Q?stVzTiJx3/sg8izkDX+L5j0Ojw7AmAENrRyXeslUhgB/3T05kdmWmUzqLGCQ?=
 =?us-ascii?Q?L5AUSwkF/i/9oUm9mgzQYsrlmG8l2Cy+VfrvNwedyBUkyRxi+eqw7x8KJSbu?=
 =?us-ascii?Q?rvfPSVaxdn6GkS+oa1Yi5xQA+d6gcx2AQ8WlSHpy+lneywaNTXR44QipAM/i?=
 =?us-ascii?Q?nTuxd4YdVYI3r7Wvo2JECLZ87IO4tyT4Bs0Mzb68HeTjL7lp8D634vMDdjQ4?=
 =?us-ascii?Q?9BMHeXcjFLg8Vl5TrBwGwsdD54SSr4C3hblWGCs/xvwcGDmvHBOLIWS/t8BT?=
 =?us-ascii?Q?+JJHFuy1VeDIH2BPzpae9fzwT4Ztbh35d+TE32p1GZpFee2Ep15/z95N2UYf?=
 =?us-ascii?Q?V3E2EuwZuNbGKycQOW2KDShqPJymi1tgVwWo4ZiMwO5ntOstmAfkdSMEaJBm?=
 =?us-ascii?Q?Q/WrVFxgFQ+83wdlgz3m4LLCF3nN9nArJHgzSGGzw6RxMZJXyrVDZFIhV0Gr?=
 =?us-ascii?Q?9Et+Rn5oCn6TotGUVa+2FH0Hi/A6RCCJjynBUAsE/QaPdFwm+MvtzaN7m2fz?=
 =?us-ascii?Q?cvm5tEX8jcYd8WcPQFodr33aIPD21q2bVybnkdwmVm+j8Kgx7l2ktNCWLS28?=
 =?us-ascii?Q?fC3g8GcRnNhxzWyLjIS1MA4+VovrTOLndpoSVf/CC3Get5IC6aL8Xrbik9g7?=
 =?us-ascii?Q?waLgWQMKgQQ45IkQT8LCnbWjR8CIvSpX8LgD3i0sU6vmkDd8BpYbuxR7eA7w?=
 =?us-ascii?Q?TKDtyOBKYHyeFZr82D6tGj7OXEPGgzCL7194NpLqXr/UqoX3SnR3kZ1D9mCG?=
 =?us-ascii?Q?fPthZtwk0YNHPk4pMR1NG9eZIebrHfzmg9S77Ivf1IThMGzjL3fTJgVXBOxF?=
 =?us-ascii?Q?h5GWNkE3kV8WAahi0C4TfuUYMkUsZuB/qUiDxxzDrfCCKWnAkXBiXcolgxpD?=
 =?us-ascii?Q?H+FRceaaQQHTzb65GG3rLaEdapMi0sCA68M0b5PkcpP0OsHZWU7oTiCg9h5x?=
 =?us-ascii?Q?NBUI31qRsLqjPJykve0VBLp0uNTrDeaIaFgzbDbegHRqzOlmcbMUy2ENYRRh?=
 =?us-ascii?Q?qIMLbdqB6c5GZ06rsFkR+Mp0z86hai/KvDAjr40XA02G4BzUychWyCcDIsN+?=
 =?us-ascii?Q?bKayJ01Zb4/PkHjiA1uBHT+MR7Hpm272glP6bR36VEOrcV7SXQcZtYjzMaDE?=
 =?us-ascii?Q?KAPdx24e8jV+9p5RMuyzIj5g3HdW9eFEy5ehGL841Y/vkT+kWAcenywsKU91?=
 =?us-ascii?Q?VEwCSDw5s0KaLT0T3yOpfGP96NdreY3fjjxX3QchYCRzw3PKNgGYQdFD9CJ3?=
 =?us-ascii?Q?6e3ovb/v+C7ej518StDYPPpDlbDyuEbJCn5JanahwRQAVdQ5PHA+bE29bBrW?=
 =?us-ascii?Q?lI/5WDuqTgKflAgYnRzIDCuXhZMZpRWbt8CozIeXQsG7XfO9PU0jrUZsa5Nd?=
 =?us-ascii?Q?2A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6203a60d-24b5-4552-3f2a-08dbc421220f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 14:57:58.8463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PNTGTdOFJNZV1oHLO2qqI+MRNpNAkWLNZgQIq0OrE2BFqkpuOmiHU0GtnDJ6Y3U/jF1grLVZdnDv0wZx1iHJGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7824
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some BASS test scenarios require the BASS Server to only sync to the
PA transmitted by a source, and not any BIS.

This patch implements a test to exercise this scenario, where a broadcast
receiver is able to successfully perform PA sync, without listening for
any BIS.

This teste depends on the kernel support added in
Bluetooth: ISO: Allow binding a bcast listener to 0 bises

Iulia Tanasescu (1):
  iso-tester: Test bcast receiver with PA sync, no BIS

 tools/iso-tester.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)


base-commit: 5ab5352531a9cc7058cce569607f3a6831464443
-- 
2.39.2

