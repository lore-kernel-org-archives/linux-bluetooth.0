Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37674CDB47E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Oct 2023 14:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjJROjZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Oct 2023 10:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjJROjX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Oct 2023 10:39:23 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2058.outbound.protection.outlook.com [40.107.7.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B111B10F
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Oct 2023 07:39:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HrFpk8McYq+6bGVwl3Sa5ubfPzz6AQoXoSOuy5cp/kO7Km56Ys3IG+27+Yp/230mYklajzpP085nPgI2iaQSqGTegPK/f8mgWH00YRBaatjXVlhdaVZZQtXpYb9VzlHVUOCX2xWE6hlVrPcOMY1YQ7KenK4BMmGZOZGv8Bgt9kGQ92JD6ZE/289z/bvtP34lInsyhqTDh9Son80hgHkF6Md8LyqM4Jp/1Ug30vYMVm3YdrjidbHMfmyJglTVYh2OEA1G1Mkk48M88y3NQACTxvGhlC3OhNQWfGrD7rwrkps0qSo39aEeeXo6cRwmhCFGgfYzGcKqIXVnrMIai5qc6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mSWxj9i+x/yVdJiveWsnVlkMHjcBiIfeV6MFSefz6g=;
 b=An4tyDKWMUfdXkWyl/3NG/oC9x0/70xcGE55AIHwXqXPEXCkA6lEVxwKqCQvjc0V+rMIjWrMPdq7ELIEGlYjyilmKYym+QFESpwNysqUxCETU7zA+kg2d6kcqm0nzrgzeEjRJL8QSQsUkVm5rifucgQJ+ZGZpDPJST3MnNq0gTQhoVH3b1EPV1vSCHWmml5MJJju+Z4kLiS6jyARCVxktlbuWcz46O5bYiuxoXqIAQOHmlD8NGKKio6p0P1p481sU/Z5EPhRJZQ2DKv6wqnZvO21u/x6mcywWolC3XLNBEqYMUQfoUtNJ6uwvZ38YhohefBJAAaEKWmf4h3QpqnY1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mSWxj9i+x/yVdJiveWsnVlkMHjcBiIfeV6MFSefz6g=;
 b=dZnTn3qkWxI2dLVO0hwB3FSv5U6wVT5Oi8jGkO7uhd+p66FTt97rkMxWOOrIs4yrngn4h0byulsspQ9YHQUDLCRSHw4B/Z5DOv9xP6filjUJ8Ozqkde8cZsA8prIclsNejr2XJxCRVtkxQ0OMKBkDZUwtS6noyfknr5+z4M7tL4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PAWPR04MB9909.eurprd04.prod.outlook.com (2603:10a6:102:385::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 14:39:17 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 14:39:17 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/1] btio: Allow binding a bcast listener before accept
Date:   Wed, 18 Oct 2023 17:39:11 +0300
Message-Id: <20231018143912.12284-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0092.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::45) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PAWPR04MB9909:EE_
X-MS-Office365-Filtering-Correlation-Id: aeeb06f8-4d69-4a74-c091-08dbcfe80207
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: stu/3Suj9oThSLoiGwWKxkHv1VHAnt/KQGS3A+S3Fvl1RYhN6n+/X2zdgFf6ZaPftHvVQm0tTTZADXVL+pyLfcX79ugjFqAznUwSg2WwNT+wTPCxOu4lturvscrZXP66IdE3tjyYBedPlQHjpGc4S927ImLTVyLZOehJ8RJR/khRzjD8L3wJsbrF3E2YRpxY8bNmE3rZrv2hp097g8diD/f8xrykF5pqDrJ50LIrEbdipIZ9TI0IJChDSxoKBnQRDd2FaupOC7oHfU1f5mehO6zElQZmuHu12ZTm7jNE5Nt7BxyVmhsX9aR6D4pMiythlYWByYfFvINuZS4+JOwnEZqYCZuXRzkV4aWZu+wnzrLXug2lT1RM7w11SdsJCqC+Lwyb9YX30Bfzv76qayPvQ5poy7S4DVP8lOLNsh+a8o6sPVnrVdKnLFqqGQULu7JlnDJUD1DB30fwWFskNGBI7HfZRtm8ImfdttUYNRLkBUJe6zBe81Mr/0PT0mJuouvZQAkpT3iJo2MUyeK+yUKpkX8mURv/7mAKL7tB+SFrDjOB3Foz8ru5/fYFbCBeFLv696xT1m5Ixe05AOfckslGrlCKI1RtT0jm2LuYqOPqbyk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(2013699003)(83380400001)(4744005)(2906002)(8936002)(5660300002)(8676002)(36756003)(38100700002)(26005)(44832011)(2616005)(1076003)(4326008)(41300700001)(86362001)(6506007)(6512007)(6666004)(478600001)(316002)(6486002)(66476007)(6916009)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZysF30yMNDTc2sKDaC4C5sTvOQsRN2n1favHs/qRk22fId3drG46AxZViQ/3?=
 =?us-ascii?Q?GnqaU9qEODh+Wp69DQ3NuG/YBdajttyNBXtKKlWoj4PprFZ2pEa4uMtUn2tl?=
 =?us-ascii?Q?3FnDD5XGFXSjI0O+atW3ty4WqgXxYe17xGXi8guHD37gxZQdeN6633R9gQ3Z?=
 =?us-ascii?Q?p93kkWpVkocD1gFxZP+wGFBgPUmNsORCyCFJGqap9HXB17m0sUj07mw9beBp?=
 =?us-ascii?Q?JhmDlDf7TKb/X+fCnNTt+32NP+FIhS2FX8yFa9LY7hLdcPfhN3itdAMgj2Qw?=
 =?us-ascii?Q?IahzGrjcMJEJwRDmtbBH0+rq4tdHvVhIlhOS0QniFuhTjymqN5vcgueSlLtI?=
 =?us-ascii?Q?cEMVJIJZxt44qOuKAdmCuseb6jeo3/ULa4Z3CM9zBbrSX0g1v9JwJw1bIp5R?=
 =?us-ascii?Q?trngncuIhASp5+9XB8J+2BvmJnswxU+28IW7tyi11S0oaZ8JzAHCKXh3XD47?=
 =?us-ascii?Q?6TV6Z/jR91ON74x1igozz1FyLMVQ/zEaVLzVwd8DuTnCFHrp7KUvJ+aBnIjL?=
 =?us-ascii?Q?+6dMUumYPGNFVkMtci/wHgsqaEzokITTD/YT5tb27aF/0aFpLV+k5WRK/eBQ?=
 =?us-ascii?Q?EgxF6BCiFh0XPmI00RD9DZEhQV43f14ake8uDYSk/sXGJshtLlHLXsBQkQ7z?=
 =?us-ascii?Q?EmKtlu0/5e2TbFRKjrvYQ4fIHOLpU51ZWGXn3nIUM7pOhQeWOxFJ31n++yrB?=
 =?us-ascii?Q?YZFe6WlZmobwNQCrjYy6y/YDbj93hJ75MAdtJQuDRtuCxqBnWSl35AaM4FcM?=
 =?us-ascii?Q?45Cb/WR0YBSlNlOrz7MxYYNtVIGLplA7dF4FcIckzpfP1G5NZIxHvD+vdHqP?=
 =?us-ascii?Q?gH2TeJidpCPy+KZUyPGkyVq2cddB9xUL79z4i4ziJS3BHEdCh3UyISYJL9un?=
 =?us-ascii?Q?C+pjQ/SNIIltgYI1yDPHIJmSxnz0Im7G+1X/x/EJxpSmm0v5HMSIhjz+2CTo?=
 =?us-ascii?Q?KF9schbfEA+eB2cPVdFcEOC7+lQv2eMWSyAZ/Q3utsqNn8iCZHUqaJCVKuzD?=
 =?us-ascii?Q?l01MdJbky7BpKr0Dwi0gvLrKVYTPwJXSNaoNYpZnUIGjXH9UkQQMk+XSV9db?=
 =?us-ascii?Q?lmnHP9KQyZdT2Pztv6qbofW2OtP/m1MdH3TRCC2FqG+3p2fiu39jGXBFar6u?=
 =?us-ascii?Q?fyhJhgnFPUDlieK3b+TW+YGZcN606iMIO7lilPvTuzqIuuG3qYvrv/QwVBSn?=
 =?us-ascii?Q?8K70KWvbGxXd8Rk9SSefc3xZS0p6aOc8ACasUghnpvTYVkCdz/22y4oEkLYY?=
 =?us-ascii?Q?KJ8h7v4ePIC/O/KP+kZ+3uHFBD0o43ALmvhnN+8CDbPsu76Aeor7JYk/wqyp?=
 =?us-ascii?Q?dXtv1poA7z1WPqNTfG/xonfcJYKGZKb+5ay+tfjW726HR8145vis+AQvo+pm?=
 =?us-ascii?Q?agBkg2XHl7S23qJegdmAyqfmC93HLgo6rB1ZVn56t3fR465r1n3L0gKfjVeS?=
 =?us-ascii?Q?NwpyCImJNIyDcHTT2kB3ywaFRjz8O4hJHG9YU9FStzzPwWeDxbh9XWfo8ex1?=
 =?us-ascii?Q?eM2vlA+Lp10ZzTVbAiD9HPX4jX9n/SRxLXEc505yGWPP2ThTfoa3+5WPPnkI?=
 =?us-ascii?Q?+i9NsgWgC84Lvv9feJrIFwVEznB+Xt4+x0ojQegtR8O+1NltdTHu5bY8zJXU?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeeb06f8-4d69-4a74-c091-08dbcfe80207
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 14:39:17.8035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FaXhqdg7bOC8SrEo06Qh9ZenRqeswFDsKMml1Ht5TAI5TsMOrpVTSgeFM7Hd1sAJCaoKQspcs3vbl1E/GlPi3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9909
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds btio support for binding a PA sync io to a number of
BISes, before proceeding with BIG Create Sync.

This depends on the kernel update introduced by
[PATCH v2 0/1] Bluetooth: ISO: Allow binding a PA sync socket.

Iulia Tanasescu (1):
  btio: Allow binding a bcast listener before accept

 btio/btio.c          | 51 +++++++++++++++++++++++++++++++++++++++++++-
 btio/btio.h          |  2 +-
 profiles/audio/bap.c |  2 +-
 src/shared/bass.c    |  9 ++++----
 4 files changed, 57 insertions(+), 7 deletions(-)


base-commit: 0c757e8eeef69ff2b1eefa59e590f171c9fe1c88
-- 
2.39.2

