Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F881E728C0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Sep 2023 15:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbjI2Pol (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Sep 2023 11:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjI2Pok (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Sep 2023 11:44:40 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10B2DD
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Sep 2023 08:44:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DObkWamH1vTUlxm8DWzGnYqRTuDhrjqrLG92+HpobABSJdKXSJ5QCduGKhMQVoitmBZ2ThG0n2fYkLqvR9aXJUxYWZz+D+ud7dJpa0iYxqGt1mXeFJQA8ygQOTd2OnQ84iGMOAAyw/FC1Sjc9N78lzHF1dGhEuxWGsDozO0y3XGue3j8DKB05q9iKP/eWsuzlnnOOp2GfXR8KpljuPwJuSKmvR+KqbEDq8+a55UDDvdsbY+H2TylGn1F5FU0dlivcbT/7h38EnG7+Vp2nQz/DE3KDCumK3iGk4Oeoc0SffPIuNmaT5uQUgmogctygbDV1D1xBBcgTmukOs9z4BzZnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXRJDiV2ojde2iOQDQKoUnuxyoqF+I0pQshUmBDQpH8=;
 b=QfCpIX8FKO8+Sl77XmT2A2jONIPXQ1nl2WrCR1Aln+7PsINSlXmZlLdUFL842V9RB+xIQ6aWZNvjSB1tIN0xLM4fbzJOL+C0R0s10m8gl1q8i7QgitJ+8JN9TCNh5R0MEaAO6GTAvXJ3JqtSOffj7mpX7etG/WHx5ojgRn0fxLszpVlmUTpQ1mJ/hOol0p994zBLnwa+LAquN0OXubyY6jqvikDswjbejiXBOVRisyFbIc+h4K5dwdcy199/0EGAaKLIoXwcH3G/92Gz0Kb2fT7P8D8qrveBxbFgo521cW+jlIpo5WXoxQUHnn3MYla/6ZDt43hhz9KsWN/UaAkVGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXRJDiV2ojde2iOQDQKoUnuxyoqF+I0pQshUmBDQpH8=;
 b=YdKg3xdXG39iyctm7GrobS4befDPAf/QnsS8EPis2/XAOfRUl9vuf7uAvaJwVSwQbl91iDrsKUtExyei5vtWppX4BvrswUlPyeHRNnO4p3xOooV209I6kqeE8IXFkvvPTa4qHdMhNRlWN8g3hWxHdNL+son8SD8w54kpCNYhSOk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PR3PR04MB7259.eurprd04.prod.outlook.com (2603:10a6:102:8a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 15:44:33 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 15:44:33 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/1] iso-tester: Add test for bcast AC 13 BIS unset
Date:   Fri, 29 Sep 2023 18:44:20 +0300
Message-Id: <20230929154421.3820-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR03CA0065.eurprd03.prod.outlook.com
 (2603:10a6:803:50::36) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PR3PR04MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: 604d320b-d75a-4e0e-af29-08dbc102fa60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RzTVl44zKbGiFxG8d4f437s72ovjgbZ3bvGA9yrhU8lClFsk2EJEIsV0mETaQkyqGf7krQkltWvhpajKAD4rY3us1VIhNz9XPZrEdQMmst51XB3nPTDUmxSpYOS+cdXq306POS+arthX2fj4acUcShsKCqSoyBXcABU6PqXNsaPuKu/GhRCTfaV5BMgtzoRVlEkSZ6aMiyhNruh+MjmqRR2s3pXwQgg14uV1w2H++nwWYNr6/5lFL7u7gPuaPLapwCHpRE/ZfGtTKAVz7MQN2YvPHWMXuc15uP6VVXXNO6mGpPscfrbueI+PBr/NLxnF79tE7nLOArOmmUECbqWcwU4MurDIwzRnzSVY6+4JYK0L2TX7MKlQ+iPGnf+pDLm7zAOQP6HJrbzrKstrz38Zw+mgnsO7ImY2u7M7MGDTYb5bxHR0+xEhjwpHYDM2BWil/sVNN4Kk7TWAW1qjmxjtrwbWPAabeP6P9Z+qiFjgYotFs/cD3KCwCVSmYTN0YN8FcU/f3V5YuMwVh8aJDdIIkiubTIEXchkCrNrvYBNBp66kLXPq4IysbEXuY0/pD8w0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(39860400002)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(66946007)(8936002)(4326008)(83380400001)(26005)(1076003)(8676002)(41300700001)(316002)(66556008)(4744005)(2906002)(2616005)(5660300002)(44832011)(6916009)(6512007)(66476007)(6486002)(478600001)(6506007)(6666004)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?79P+FYK+Yz2Wjd/aQIzUOKmCoYci4PoePKbkHDLYiD0HSPqSpY6g0AV4icIZ?=
 =?us-ascii?Q?4upGWF6U1LQX4hoP34oytIbDIa/bz0QsLcr3P2i78yH2aQ+qLhGZmllQYVeY?=
 =?us-ascii?Q?1m2IpM0McjNRNkV9Q2ptJt+pbpibIgDvuTYFGG5eVwzmlIj+oxB3QsmTx0AX?=
 =?us-ascii?Q?AIU48RfrWTWFWMZ+hfcvBcZn3z0MWAPIOkTsOmmHsbyM5xaGj+HD9bYPlc5s?=
 =?us-ascii?Q?wdodvLCn9ALc/BcKsWIwPp8rJdaj9gZO6K9NinwPZwBywO/l8m4Td+3kuj1b?=
 =?us-ascii?Q?wQSsvEcQsyy4afxQLxZ1Uzb+U9YDxxvGqm1HcFIdc0imoc/JnKzicu52bqHu?=
 =?us-ascii?Q?6iNSd4OFrFkELondyByhzqtXN6XCfBfW7iGX8PGQPC8jKdI7xZ8RmhWDB4N6?=
 =?us-ascii?Q?iqFrtMChRSQtKcQAsT0Lh+SwsMMpXAPiSMAa36cxD9DIoMY5Sate64G6Ob5X?=
 =?us-ascii?Q?VpVaZsuxuUKTsAdG1X8oDsETOwmc2HoJqIc6TpWU4k8npobAlLy0E3BUjXpb?=
 =?us-ascii?Q?fYNf8AeFMhi+SYIKN/nuvaKPub9mRvbM9IYAUJNWNN9/YoHgK7FocAprecpi?=
 =?us-ascii?Q?YKxBcK989/2FFEYpM4TZIuXz9mAwQoAme+Aowq1MM+1Xx9kJLeIOFkWbXlJA?=
 =?us-ascii?Q?TJyPyGEBv2CM+OcYo9IuW0CixsBDkV4kHSE9RUYLpSmv3RV8nyTOT8rQUSMS?=
 =?us-ascii?Q?gEL5DeUbNNHgN+wGTXZ2Fr1mwGFT4sZPS3+Qr7xNRuTE4E8R/ikw8NUINoIa?=
 =?us-ascii?Q?ZwON1uwct7acYz+yLDuHcTHpx+3L4efQPPGo9eUyfLAOIHKAHirbTcKxG+OM?=
 =?us-ascii?Q?we72jS6sT69ypyt/ClAQkOtJQy5pGsKxVD9D5YZFwR4JaaUBjpHI8m7JokT4?=
 =?us-ascii?Q?TPVyPN/gwb1U7Ope8NRNv64dcB93GCJymd6iN3qizo3g7MTA7dwnw0kvhZAI?=
 =?us-ascii?Q?89XNB6IOz9030/gRQRYLC1gaEx4haeoQ8eRUHTSujnp20g5BP3fwX/Wjuo9N?=
 =?us-ascii?Q?tqbj0BZUE896bUBAgzD1HyGkaNzDQvJXc6jVsG2T7brp0Dd6hZdf7nc4xXsQ?=
 =?us-ascii?Q?ZaSrscDQbNO6z9kuEa/7KQNUl1VeSIko+qPgPkYVqgCxdy/mRU1Wf/RD3OQI?=
 =?us-ascii?Q?ayPIsoQg5yVRLr4xsTjZpLIWcRn8/ab1h+phZgPBSNh0rxdJO/EQSc0F5Uah?=
 =?us-ascii?Q?spKWEKHmRXwk/S/7HCXuZa2TPiqSNzezHea1zpsym08Dqjrx3PyuODvHsCzj?=
 =?us-ascii?Q?Z/oh5Ird4l+wLXz6kRDwBG2XdgK6+Y0DvdlsSp8JANvfpvWWySuoecaBAG4i?=
 =?us-ascii?Q?I+XtPG33AgKT8S5gysdqpJ8XowrUTsE130iSu6l2oMtZkAJXMRPBiTzM/6ju?=
 =?us-ascii?Q?F0XoXSJU4FLnRmsG5CiFYMZz6fQ5T0r6wC+mcY3n9dJfcP6YF0PMXqckC6e5?=
 =?us-ascii?Q?TPVwhAWF5raGIn7ko9ofBNHaYpERfmM7YLPwWjdo6MhhDMz0u7Xl5ZT7tKLz?=
 =?us-ascii?Q?UUrkRPqDAEjx6kjJ3F2WZ5cTvnXo5CJ4NCX1YclNMX6trbF8OGZP0UFa/IeQ?=
 =?us-ascii?Q?n0JgrPKb9LKlYp23MBsSse+h6YpKN+uWjchMgqhC6cYf4o5lAC4hxj9XUmwT?=
 =?us-ascii?Q?ag=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 604d320b-d75a-4e0e-af29-08dbc102fa60
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 15:44:33.8737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pRsdKA5Mm5Aju1jjx/ObBb4AlllzpmxAOZQQ5uEQTMIencBRxZw9O9UAuHeCGSjZzMhqd/J39LXwhaQeH0djcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7259
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds a new test for the ISO Broadcast AC 13, when the BIG handle
is set but the advertising handle is unset.

This test depends on the kernel support implemented in
Bluetooth: ISO: Match QoS adv handle with BIG handle

Iulia Tanasescu (1):
  iso-tester: Add test for bcast AC 13 BIS unset

 tools/iso-tester.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)


base-commit: 5ab5352531a9cc7058cce569607f3a6831464443
-- 
2.39.2

