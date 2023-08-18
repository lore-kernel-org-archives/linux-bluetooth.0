Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEA9C71149
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Aug 2023 13:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377181AbjHRNgk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Aug 2023 09:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377182AbjHRNgN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Aug 2023 09:36:13 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2080.outbound.protection.outlook.com [40.107.6.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBC7358D
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Aug 2023 06:36:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSWoTnO23vMT/IKPZkIpafrVxYgLWewgbXVy6MUssZP/1BwMsKFyY0AUeUB8X6fUfZgaWyjjUKemkDsluuCDLmPIXwEtZgg5JVlzESBfbzd+h12ReUAtBDXCQE8s/UZm9kUN6aIOR/IcOpZpgEe+M0JLQ6ReoiUPwoeLO6sDreVThg/Yp0YRxr1rDh4fMRBCtXOZJMXKW9Vg3DQaggnCodLo4T/eEon0HoMwvjrMPTnPSRgRpYRG7wBrVRbJRA+njuWWzg1c7K/98XaMhi40emxRd/u5vDjMdD25F38HWVDYwm7WJQSfbB/AieguhVtxSGMgw0r5n+wHcy9u/ZUWvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLAd9yHCSKLHqrczu6q1yrn1aIrU++JX916Rf2OGnEQ=;
 b=YDQuGJBPWTTPT8S+2bzoVbN4GSJe/pgnB17sToxulcbpGpXfW3UYQPnqfUJY3OPc4JfMMCty+QHsjlHyDHzVD+3M3jzdnHuOeWxCzYDBxjaHvk6O8UAzASvksFOXD46wYmTFretr2ZXPtpNsM2oEtjBWqGpGanbYNpjGlQ2U+IchJ/yX8W7oJJpibzI7/RJgBfQqrXPaq/mM1v2sD5Wlq858Q1ckQfPzmb6uOO4vnlZ6HcDyNJLKzW0jZihxEn0h/KTQXS0bnB2bVN89EiVDaOGQ64mQsf2W2tfTNwTm1ZzZwIg8dwU7Vl3PLg7JL7jZajFDj6TXtZ/q8jFvJhVW6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLAd9yHCSKLHqrczu6q1yrn1aIrU++JX916Rf2OGnEQ=;
 b=OjyUFt9knOffsZMzP+yZL+yXdqiXFLNGeiuwz4iNCcWEVPNalrARfkPGQQbW4FFgB1owPAn4K/nGJYFKtjmYiUuNWV5som/+EWOciGztYP2YeI898xegDCOuWPsOOGYMXnUok93C9CQKPuHscGpHHIBsz8ZiCSiZ4mcyuLYpzKo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by AS8PR04MB8263.eurprd04.prod.outlook.com (2603:10a6:20b:3f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 13:36:09 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::cf28:7578:cc46:bc2c]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::cf28:7578:cc46:bc2c%5]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 13:36:09 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Subject: [PATCH v3 0/3] Configure broadcast endpoint with BASE
Date:   Fri, 18 Aug 2023 16:35:49 +0300
Message-Id: <20230818133552.20673-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0132.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::37) To VI1PR04MB5344.eurprd04.prod.outlook.com
 (2603:10a6:803:4b::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:EE_|AS8PR04MB8263:EE_
X-MS-Office365-Filtering-Correlation-Id: 10e7e176-6c9b-411e-efc7-08db9ff014c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lvaPi1ZulvZxRVbx+SWguiShO82McV1UWiKDLCwqmA3+bghy7jao32fAsktlpaSWTDB9Yu+EWJkrwcpTU6rHPBtiz6Bk9bTVIB66KvzWenyAhHVWW6RCt3ocbjxdlndakzI60UGAg7xveacbrc1e14RQS7sdMgvruc0fxpS3WqBtGmCa/HBPskflHZci8niRBZ2TPXu+q7tuFap7QFBe1sWDciCCNtoyIT4o6vpUht/UdAGtzC5H5ol9W+vfX3gkljsS5s3pwNJL8OOLj/MFHzsCZGOHEwjTD6+P0GCFvhYw9Ln/Tj3hVCpL7nVLuQttkWmc7/+4LokaNqXWHb36OLZXspBN2WUsNu5A/qJeVHz/FjaSpqlO3cetsf080HvnSPc/yOKEgkxbOkDFmTSAdyT5Ke5YCNHDycBoHzzygEbIyJ5stgyfGiPgcZosxiT8JruFCWK8orFj3XW2P8LLbFmuq11vvovyLqnFHI8IULGp6FalT2QyBZQhdJopL+JigUorfHIMFy0ulg6O5oYWi9bvz0w9iWAMnJ/qTmz0t33/MZJgVD93ZePLMk9SOxHa50Bph9JwyRS6J0hPEfSlnbBY0YNC+Zs8eY/z1RpwVmpQMfTGhijYJkCB1rMaSJtf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(376002)(346002)(396003)(1800799009)(186009)(451199024)(86362001)(36756003)(66476007)(66556008)(66946007)(316002)(6916009)(478600001)(41300700001)(38350700002)(38100700002)(6512007)(6486002)(6666004)(26005)(6506007)(52116002)(1076003)(2616005)(8676002)(5660300002)(8936002)(4326008)(4744005)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9KfTwlRzfS9+kgYRANZD1abv5jGS/3Ue8/cooSXau9H12MWAqzjgrvy91cwv?=
 =?us-ascii?Q?oQbTHY68FCc+Pyt/oeHPW8pBwfoX821UOFfg7K1IY4nq1O+swDOXJ9sTqApP?=
 =?us-ascii?Q?q07sacV8XxLwczJ4yR+NqnLY+laKHgr/YC0RFrpNVpIdqgqzoIOsNpfEO0Au?=
 =?us-ascii?Q?iRwpP+MCFLJRPlca/PKdLOeNYyj0K0te1mFS03UK1UKCev06BwfbqNM18+uu?=
 =?us-ascii?Q?h/heeYlreLqRJr5vsMQYKQg4Nz+Pl3aSpSsk7x3ygLXzIxGYEb410HCCTXvf?=
 =?us-ascii?Q?22DGcTLfZqTC13shaoBbsAW0A5+aDcwcgLf0RSB2TmU66izGTH0gKs3aI2aU?=
 =?us-ascii?Q?+REwd+4b3j+4+hXTPgCRl+1pztIUa+Ox69WjlMk7wwsXRzluhYZK3/E74q+X?=
 =?us-ascii?Q?IY9S5o/NwCSneAFnzIhRcpodEXOYc98WiObmegUAxyyeDCMRVBge5LIAKh8N?=
 =?us-ascii?Q?+8msbPBUvhsjZzvvHFbU6lsq+9nlAewKpJT3M11YJTSBfRfhdE0yl7+67tkx?=
 =?us-ascii?Q?WcmEH11GM9+j4XT04V7s9Mxw5NJFVzJDe9w6A9eneQLIVa7NqcHbTVKJLNPa?=
 =?us-ascii?Q?u9aALMtsQXEkU7hTv9V7v+H8TM/D6pgUqScwjH4TyV+uYmzWPb89pxChzFoW?=
 =?us-ascii?Q?QslWKRPS2nB6boeVOP0PtexxiCJ47e8J6Bus0Wjbghy0ckk5m1VD03LQV5XT?=
 =?us-ascii?Q?GDbWvJYEx7wLYoJsnn+XgLbuv1En2s/VFB8qEy7d/OlVDx92JkoqkCSvXGry?=
 =?us-ascii?Q?HxO/tUvuOWG/wsw3KgiSbgEVsAzLgTq9k2c6qHDM4KLLzc4U5+BwigYSIVDC?=
 =?us-ascii?Q?KQwQcWw62DcJ6t3z/Av1Kpk6zNbpZOKpUCyIdi8zSjA6/1P7FA3ZoyBmWUba?=
 =?us-ascii?Q?V9oKQYonDYo59e9LIhGZSQirjOU4dqgwD/y+159K5z4xRJcKGghiwM8TpBY3?=
 =?us-ascii?Q?X6e/s5J8AJPf+OLPMDTnyVIASwfbvOwOqv2FcKi/PXHBsk2RPvWjpv01++8q?=
 =?us-ascii?Q?OrI4XorkZcNbvu8zJVIkMGhe+5Xe/4jJJl7SefSt8Q4JvPmmsGl7Talx9N2Y?=
 =?us-ascii?Q?GO2kgb4MDRlXBptnkrrY+FOxVXgeMgT3IRaggsrbHNF7V9/R5O0UxcIyVDot?=
 =?us-ascii?Q?KE+T6TMjexCIq7rwMA/wQcRdNYVL9UvP4KYvzY9hDyHbVF6fJD01P2Oi/UHH?=
 =?us-ascii?Q?Dp8xVInVqvWa+7xvjiMZuoSu6E+D5eCTC8uFjmn90K17lavfzrgI8omOZOzI?=
 =?us-ascii?Q?GD6NiGFewSykvE4Rth/UIothAc+S0bBh9h3MSRF/vsAbxMfJl5XY/jGE0HN0?=
 =?us-ascii?Q?4/4KbFpIfh+fKVW0x6ZMDxgQHuPP/9ZjRbzoHHCmVYQTycqfJyBLV6rO0OAy?=
 =?us-ascii?Q?zBE3dpVwOJmt77qeJ+jP+6Za0ccSQaqLgPuMGEgWCl+ORkwbk6XdBPRGvvCC?=
 =?us-ascii?Q?26eYIen1BuSeNCG66xKi7h3B/svSCmXEQoiJfOXWN2dja8Ny06ank+QvqUzh?=
 =?us-ascii?Q?lyZsR4fm1r3jH7NVOohqrmplq0ENOkQhl1S21uobhh0k9o0RhsnAOV9VBe9m?=
 =?us-ascii?Q?BVA8kNDfbcDaL/46yI+jJFuCOr5Tf4MRXSog+c2y6ZIAz/UHTp1dCn5uKP1Y?=
 =?us-ascii?Q?ZA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e7e176-6c9b-411e-efc7-08db9ff014c0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 13:36:09.4110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vm5Axzv1Ak27YyIkdsHfWwFPMGsS0bIVgjQH3ofx+xdpueEXUNny72TI3Ay5oOxRAIbwlBtyU2lVDowMjRMiC7vAexi7umC6J8szUQGrZmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8263
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Configure broadcast endpoint with BASE

Claudia Draghicescu (2):
  shared/bap: Add utility function that parses a BASE structure
  bap: For broadcast ep parse BASE to extract capabilities

Silviu Florian Barbulescu (1):
  client/player: Update Codec Specific Configuration size from the base
    structure

 client/player.c      |  2 +-
 profiles/audio/bap.c | 24 ++++++++---
 src/shared/bap.c     | 97 ++++++++++++++++++++++++++++++++++++++++++++
 src/shared/bap.h     |  5 +++
 4 files changed, 122 insertions(+), 6 deletions(-)


base-commit: 60731cab5891ad2be01f5fcdbf5908aff7df4fd1
-- 
2.34.1

