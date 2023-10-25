Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C882C0032E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Oct 2023 09:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjJYJTK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Oct 2023 05:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbjJYJTJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Oct 2023 05:19:09 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2082.outbound.protection.outlook.com [40.107.7.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0238F
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Oct 2023 02:19:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfVUZp66oHXOdpG6rQQ/D7Vp7V8AOoRKzEMF+bfIAi4qqCkVFFRmdItGQ345icq/8fciq1pD1K6UA0bHnAUXM1Ov1WetgAyraLJtlEBBMUyIWzmnyuZ/7VhEZ1fkR9YBVdiAld9cvZEtF5a8KbdxA4ugEvIPFLoV3y76pPDMBx9KJp7+W+DKjei+VnYLqlfzyrEuM+HDtgmUq1germhix80m5lZKYYdoUFHtT9n5um/piSsPA3kcUhsFjTPl+v1mRVVvTit9eYEIGr3/Y6XDQyZ9bIv1B9YMtGnYlCldwoLWNaF6BTxLranR8y9OQKPQ2ZSeAu5q53gazgDeGVdwow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9ikvSrMfY/uXVH6ua/tcp+0oNw2+SwGSORUCEQWgA8=;
 b=cswy3WSmcngvFuHcqZ498ShralFla53nVnfzs/vnu1bVkrC5hvyFF7+10aTobJOxvqJBopqaq3HoupbIMu9qRwHqEbLlwLd29UCcy4EKA5FQZ/jLLSR0q9Q5IP5wRy1FuVTVFl9McFRiX/YL2ldHLuTGEOxvdetNzy3HdWiatKKtwnfOfxMINakivd83BZlonfkHeJxDZ656swHtsHl2sl+On5NpFqhcTrxRWsY1z74fIeyZb1rO6sQxz6sKajTBrNw+ssbz+VO+2ul8JbBLUFT9ivT+4qJwxmrZKyEEq1nrMKUjMlr+bVzR6TNiKQyMpi9FLNHjJdFd8rEW6g5m/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9ikvSrMfY/uXVH6ua/tcp+0oNw2+SwGSORUCEQWgA8=;
 b=gAhb2wPRQouEKk3UMbE9ZPeqdAvkVg///i1LD/WFchMv94h4CX1NZVqUqgUGQh/p7OIl+9BLM0DTbiyqwedi9fG2ZocRIAsyWa4pkLGTB7zsmLbd4M38OiHqX+WfH5tWNDTeV2/IqNCRKxdRKYWPfo3tuC1lo+wMUJz3UyPRS3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by DU0PR04MB9369.eurprd04.prod.outlook.com (2603:10a6:10:358::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 09:19:03 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::9854:5951:6f9a:7711]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::9854:5951:6f9a:7711%4]) with mapi id 15.20.6933.011; Wed, 25 Oct 2023
 09:19:03 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v3 0/2] Fix source+sink endpoint registration
Date:   Wed, 25 Oct 2023 12:18:51 +0300
Message-Id: <20231025091853.18647-1-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0162.eurprd09.prod.outlook.com
 (2603:10a6:800:120::16) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|DU0PR04MB9369:EE_
X-MS-Office365-Filtering-Correlation-Id: e0fcc8ca-7620-47ac-9543-08dbd53b6e4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ozbnm5bpZgc4Lp3czlqJjbD4aV4nwF4WcShawhG0Ah3O2NvO48Szot2LbKvS4uCYXYv3gz2ZEqbMbwXN11BCBATNE1yR6w5fp7iGXvmRINYQOA1zB9HevHVmX9qwITcRHEqM0GysKcxnHWnMPFZKPagZ2F6fiSrBzmkMrmNE45mAdzJILpGi0Gqu6KnIeTF61F8fbZbkrOSKlj/HxFNZFdz7HZc5/pCpzrdzxEWlaKsKWlKpekVOFcAVT5+8FalE0heAmG0+a93gJHff4K9gA6ImPCWm+tWdMgtxv/qQ/gK+5x5ehQSs9phYjLkr8+FHgIe0AGH3DUZSkciy9dacOIPB5P+HYc6dJePi7t/8J1wzgEPdVR+KfcUFiIHUuClma//iEH37adIDdWQ0jzGqkteBDRB1DkhbXdrI2KdDDoAiPyx73gmuu6s13hOu/CaFoYUo9KdQjvulaDd4fRMXNeU1IoKIgQZFP8F4MZe+YdpDroTabd2e2oigjUIb1sPmovOq4xUBAzqc0PuQsTiflcbnv0Cru6acZt7K3D16tnD0Q3Q98heQdDi3OTJd8Bn2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(346002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(26005)(6512007)(1076003)(2616005)(38100700002)(86362001)(36756003)(83380400001)(66556008)(66946007)(66476007)(316002)(6916009)(4326008)(8676002)(8936002)(41300700001)(4744005)(5660300002)(2906002)(6506007)(6666004)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LAju4UYLykb/bY4x+EOqhu86Qa3+2ezSe3JYWhoL4kimCdQqt9MeL1eg45wb?=
 =?us-ascii?Q?PWI0PNtHxCD9DkcRB/Hc+gxIlouo143iBDm+B1QRMUWN1mj61W5F7IGG2lye?=
 =?us-ascii?Q?O6AWlpsY077iDWC72eZ7BXDEzFA17hhoyyo7TmmA6hYs1T8V8Uqch/G1pzqR?=
 =?us-ascii?Q?wEkmUGCkFw4NzALF5XY0fG1lXS9OnJxlSbo/pEepMG1slnueyvq47YhWlf6n?=
 =?us-ascii?Q?LDJPaPGVM+WNrjzvXUY9aVeNfZIy6TPJCNair1hGAyjIHt6dWyC6cAejFUo1?=
 =?us-ascii?Q?vVLNecyXRlFUBK+aIKyQN1wHmGUZsZqJH7nGFk1zfaj0jR/5SK05mZNZNUqr?=
 =?us-ascii?Q?kDKJbczLrbMw9/vvGvJO6aGz2X5RbK0UJdXAplwGuvRS7W593ZEXfILihdTx?=
 =?us-ascii?Q?l+Tn8LiSwu27G7lroEfJtCavFbH9HdYSABPI8A2GeDOTl0hAruGhKPVHU/ZA?=
 =?us-ascii?Q?Lh9IOSsKe3xusnAn/FbPZCTbVnQ06tXps/5Lnx2bhUoREkD7vFfBnKgi8YmU?=
 =?us-ascii?Q?y63uZ7nGeuoHcF2KT//91bMLnz+7QxaVMU2z5atfADom/wS+LtsuhIOOzP1O?=
 =?us-ascii?Q?kN+tGvLL0yKk7nXfC/oueJ0qeYDRqrdya3q4hdSAyGTsB0FskSPbiheVnH3Y?=
 =?us-ascii?Q?5WJVdhHJ+GM4cJw09Cbix6Tx3qcP3ZERdUkd74YIHlZn8b00mvlzC5HZ09JL?=
 =?us-ascii?Q?ExskuDTIf65A56fV2c1yzt/MoDzmOTF2/1JS7bRn6lrG4jNn+j/+a+zujbJz?=
 =?us-ascii?Q?meXbDa+Az8SZu6mqX+bCIYmsROsf72dVDF2IYJC4Y2279e427EBe9sE2p1y7?=
 =?us-ascii?Q?fSLjsyqqNb+IIVNPeyF/T9ZntY4vxhfH6RgkI0Puya+zeub60Vsh6pLHVdHl?=
 =?us-ascii?Q?soV+prBci0jRo6FkrgGN6i1+fWqgichDSmqQAmUZJ3oxwj4xojRiASfEQUpA?=
 =?us-ascii?Q?9MmRlVHNk5KJ4QMYNQkqj/ZMJaD08XMXPgUck2N6IM3amiHEJ2Mo94h/jyVW?=
 =?us-ascii?Q?w7UPasATKz7eBYbuda/VjCqgfhWrJzHeuTmD9Jez2JhSY0+77uOcmexx7NN6?=
 =?us-ascii?Q?2KB6YWs6WmpvJguLzme0xv0R287cBYF1rTn7UWqzR4j/XeJFmWvdn1SrNmjk?=
 =?us-ascii?Q?p/JJlX0jY+KKAlWGRbSdKh+Gjo1nSFMJYnS+IKgo5Vw7YYV0e7vef2PopLKb?=
 =?us-ascii?Q?vNe/zrVQjOMHyx7vpRFKuTt59j4HbteIoXNKXTf/4qRnsvUwa5l2zPvvFT1E?=
 =?us-ascii?Q?om4GdEk/lVhU5RviVqOi7ERTtDo/nPpKV/z7Nnf4YCS+P9Kv3lXrA2oNj6px?=
 =?us-ascii?Q?2dPhpZyfySF2T1Wf1f7AcYsf/Gv7D0HcgxGH3IHIbaDWFxk/AfNunFoGV9ba?=
 =?us-ascii?Q?sAhH+p2ZeBFTJ0QGuqKjRr3NV0m5oIK+5iQ8vXX/lGdOAIBqXS95Yj6YMbWX?=
 =?us-ascii?Q?gzj79Wy7t9kaXLmAy+dz5VglbV0dzhT9NzYtL0Ktc3rmQ1vzyPT2kARcNX44?=
 =?us-ascii?Q?6JxZ1ZTh+4vNQXHm+agtNBD1LRQl/9SCqi1m5fHWshIodXxrshqLB1G7YXyX?=
 =?us-ascii?Q?VMq0xY+ouz2I/LpALdwMGf1EBAg/9opCJRMpKDwm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0fcc8ca-7620-47ac-9543-08dbd53b6e4a
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 09:19:03.5134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lPJTyczArcThvvZFy4nx3hRuifhDFOhSk1FJxdP3TAHtDlWnW1CHtqP9lQM0yGNMp+Yx4Cs1Y+YAElmRarKaSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9369
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Create a broadcast source endpoint using only the local endpoint.
This removes the ambiguity when having registered a local 
broadcast sink and fixes the situation when multiple remote 
endpoints are created when discovering a broadcast source.

Claudia Draghicescu (2):
  bap: Fix source+sink endpoint registration
  bap: Fix source+sink endpoint registration

 profiles/audio/bap.c | 27 ++++++++--------
 src/shared/bap.c     | 73 ++++++++++++++++++++++----------------------
 src/shared/bap.h     |  3 ++
 3 files changed, 55 insertions(+), 48 deletions(-)


base-commit: 00fdb61d56161f523e975b4c044030f4b40abb6d
-- 
2.39.2

