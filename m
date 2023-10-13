Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63BACDB482
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Oct 2023 10:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjJMKFw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Oct 2023 06:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjJMKFv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Oct 2023 06:05:51 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49304A9
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Oct 2023 03:05:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnWvoNn7WwdopZllFbigosb5QJK/hbe6GjYLJjnK1KVsfV6FwtGyrqNOtxrxydbU09qM6Indu4YofxLVklyHGd6a3Tr6+s7hDilBOHzdjSy9cATCAgezftDa0Gy3/nqJUH1tPGv8joB1a42EYgQ89DC+Vab/+aEk+/w4ljrZW2/dPpEWl/729DIzCskkBfqT+UjukasL2mU95wSGrTFc6gQfX/E1yeLqyCYjAJ4zWyrUx9BeHg4y+khgZup20IyL7fnSrPf889ESUJcJdejecwKhglrmTmqvt51W3BF8Pm3ukf0ZfnSzn9KG/8iXwhkKobzOqc/5kXusMTNtxVZDjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0fV0UGGjDE+5n1oyi5KZ2QlLOySQb17WtwmjyOZXmY=;
 b=VZt9lMazEDtPrEMBFmoYPFx8RvIfNOamnfmzcY4QJl0wPultDJuzOt0Ry43NQGrNw86IyBe6kkMlLSLehxYmh4Gwru9LGK4mnFOrTxMwU42QoaVgBuE38VS7K9gd9MHJ449KjxdWfdZxWOhzjhztSsGy+h0NtjCNCNN1P8w3ke3ac4kwh3W5hvCaJ9IDrB1bZ68V14xfeFFZCAgShYoDjLbEjDgSONbAbH3aXP6T6Ai76+UB1WSWsG7wIj5PqWj8gEQaA9roYnOpG90Uf8QIU0kpC+AxkIjD0jD/1AoSI9Zc4fnxiRkT5eNAKOniMyu1kz5frwW5UAEL16kXaofkeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0fV0UGGjDE+5n1oyi5KZ2QlLOySQb17WtwmjyOZXmY=;
 b=VOTCY2q5eYdaihpDsjUlyaChuDBfMU3gruVUfAEmdkCoNdJU6do5bJCjAoHao4CYCfFA8fNF6afqR6+0t/ChodOBKoD8c+MEWb64PZiUIpyMYHFoBdN5M0hJv4e/BIes3R0so0Hcoi+k52hzaWObeAh5pI9yr/vnaZZ207WHtxQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by PA4PR04MB8064.eurprd04.prod.outlook.com (2603:10a6:102:cf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 10:05:46 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::a53f:4bda:e012:a73d]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::a53f:4bda:e012:a73d%7]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 10:05:46 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ 0/2] bap: Fix source+sink endpoint registration
Date:   Fri, 13 Oct 2023 13:05:35 +0300
Message-Id: <20231013100537.3867-1-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0079.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::32) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|PA4PR04MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bfb700e-21eb-451c-940c-08dbcbd3f829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HdkspC8AOWlDG/FJgT3rWzvi2WdQFRTJ2VpKOKjxrvGG9Fvfcb7jmcLM+K15EUlikd5MaMh3zJKKU6zmjKAPUmLJor8kSJpwv6cf2/oSxIlXudB9TRdBXzqA8TGXiw4wwcKg/JBGAMMT6bv+MAPYKa/bqT4kacO00iVmjBZhCaSOJGSaefAZdj/86fIp9ZTW3mpVa+sM48YpsPumWqBYtTVZQiwxhP0O4BWklrmQ7dMhIfuMhpvMmL2gwHU1pQbaPB9+D9Gk40riLvQgQU0DoFFX2lcACmLRlDf4FLZVH7OiMNGD504gVvHLUMwkBT52kXo29cohjQ9FiF7JKz3Lpw6xwGokf6xB9xtTgZS6WLhqchtFrT7iCKg8ChDroQsrrB5aFvmrc7SYrG2pGVPaNKNaLWSVlR/rbwcKgTW8ghSxuSzh2+eMWt13tX3SEAvetZoyVv7tqKI3iW/58UCa3id0u4ziR2cB8MeE1RsQ+49Kt7Nxdqs5fxQlyxd490E9p3ZLxe0aqzeuhGJnAPJ1u2HuIVMRS9UyVnO7z28sWmw5rj4tbO1PfLRP30+1hmgq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6512007)(38100700002)(26005)(2616005)(478600001)(1076003)(6486002)(4326008)(5660300002)(8936002)(8676002)(86362001)(4744005)(2906002)(6666004)(66556008)(6916009)(316002)(36756003)(41300700001)(66476007)(66946007)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IBRJOe1KzZhcW6Wp6397JlGnQNLXC/gv/H3bhRa7x7DQmURT7w2BR2wsrmmp?=
 =?us-ascii?Q?73ezxHpl09DzYFegTNva8xeHztBMAvuDcnPSmx5IqaXyE0zUMADdRBUE/d3K?=
 =?us-ascii?Q?BAoPqGPg3Qb61WUZMTgzflRRalile7QSewTizU1Xy5SkTddWmobjxrpgoefS?=
 =?us-ascii?Q?Ebd1hD4aOf6mtcw+Qc/4osT74FW8ZP8u698m1TRgSAe0E0/DIAmZd6dwkC0Z?=
 =?us-ascii?Q?V9G2Bk6Bnlv2ppVd7ummYiBProt2e484ZBLVSWxHAmeHktKbiUapny/JAK9X?=
 =?us-ascii?Q?/QxGefKIowdZL+lpwc26EoRJfrCFSf4JKUHeaFjaNbHSIGLp3n1yVeidqIwy?=
 =?us-ascii?Q?HhGcQn+JtAajYcIzPr/KaWZtlR4n1bVediBHH92WRSYxrA0lvl6tNRLZkeZ3?=
 =?us-ascii?Q?hHcaQ3au/JJeubym2tAvNrnbxfX4rK555qxGyc3td8b3h61LGLCM30lk87ZJ?=
 =?us-ascii?Q?Mc1oghST4JoWysZ3pi24ru2exTsAIFRXaCy0pmfiAJHYou4J/5n3O3jugDw8?=
 =?us-ascii?Q?bHzR53wugWHN64vJDaSPQF5z1xSFFLh/dQAHaRx0v1gNgqiXc0ftnJYQ3zjS?=
 =?us-ascii?Q?+gEMjfu8ePxMUEn9FuxRZLwgRVX4EK41H2AxEtCzRD29QIjpxWQrYTZByQL/?=
 =?us-ascii?Q?5YY6/gRbphDH12vTltTeYaH2zv55T5egukHHCULznfi+4KWrlPz0CCFZHHV+?=
 =?us-ascii?Q?K3fLsp7vVkn83Qstxqfyg0NZRHztawosOcxhTpOZi0cUF+TpjMtIbT+JuQw2?=
 =?us-ascii?Q?TLdH9uYbQvwTC3ljJPPIFiQY9blhF5sDbzLcebZhKxVQgbOj8FWEuRyQGxVf?=
 =?us-ascii?Q?9tg/JUQ+r93TtF7JNp9ZKUkfZYViGg7Ri0wyPmYf0StPVuMt9jdyk0GjsJ+3?=
 =?us-ascii?Q?e8V5hMD3tDA9WcnHg3wICNWN86W8+snC4/vgcJNql5nchGbhVOcLk/bUEtLo?=
 =?us-ascii?Q?Yc7uAvYkIIgig+l05ZzaXarfGuiyyZBfoytttwwhw/ElV60XLqEaLJu4uzZM?=
 =?us-ascii?Q?esQserJdvkJyZt0yJsEa2MLpMxSI+w6OVzcTUBy7FOGe/6y78twCVCjsJfPE?=
 =?us-ascii?Q?Hgch3wiNwoLwheJ2rOuELmiiKeStsqfGzuZ3nIqyBzkGpgme0oYKH+GbQwt/?=
 =?us-ascii?Q?yFcuBzC1WHr8wweOPj4tesAwcdsBie0DxvpQGcRHLKi3GzDIFyBrYwLfGvgT?=
 =?us-ascii?Q?2GWb70+q+SKXA8LCubk32aEgtkioGvSpKWA4Ws7/iJbzsqHRH21DEmnWW+om?=
 =?us-ascii?Q?GI97EkyjuvsJXZ9EnqfDrRUj2fYjLmjhsSx4I5+g+kJZ12d+wkTg/sO3DJyL?=
 =?us-ascii?Q?W+ryN+U/yV8HlZh5ZjAoDIZYcySy+5a1Z0r7ecnxHnvcKC1ggEQkY7UXvp52?=
 =?us-ascii?Q?MolOGdtkcfOsbKuIc2fTsNl75bG06Bp+IAr9UiwPjuA6wKmaJ+Is1nog11E7?=
 =?us-ascii?Q?3jQXfDbvO5wsbc1y1Oi3j6YiFM5FLTCL7620/WAHoxOTGTMMaV9pndJRg5vL?=
 =?us-ascii?Q?+/+E6d8JT+vTZvplm/M7xp17cPmp81HphHMFksiKdV9S+2v5VyzTu0fOmr0M?=
 =?us-ascii?Q?Khoyc/H1IvTUvjZD1s1DvKc7/fcIeVx9+f8oUIy/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bfb700e-21eb-451c-940c-08dbcbd3f829
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 10:05:46.6708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vWPXRerVeVp/XCG8CQAbNV9LlxPrzrqY4S4VrwQyk80kdbCUGNwzgFMPhLCEhQGJnK9Her8olwaqtMvYUCcIvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8064
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Create new endpoint name for the simulated broadcast sink that is
created when registering a broadcast source endpoint.
This removes the ambiguity when having registered a local
broadcast sink and fixes the situation when multiple remote
endpoints are created when discovering a broadcast source.

Claudia Draghicescu (2):
  bap: Fix source+sink endpoint registration
  bap: Fix source+sink endpoint registration

 profiles/audio/bap.c | 15 ++++++------
 src/shared/bap.c     | 54 +++++++++++++++++++++++++-------------------
 src/shared/bap.h     |  1 +
 3 files changed, 40 insertions(+), 30 deletions(-)


base-commit: e347792f41a8ab2cf4f789b6544a4f8ec8464a53
--
2.39.2

