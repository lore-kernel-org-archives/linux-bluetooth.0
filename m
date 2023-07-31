Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AA8C001DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Jul 2023 09:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjGaJSn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Jul 2023 05:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbjGaJSC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Jul 2023 05:18:02 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2083.outbound.protection.outlook.com [40.107.7.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F96A1716
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Jul 2023 02:17:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2I6VSpJ/U+LBZ3hS4SmK2VKONf9x2is0cvjHfxUvFVdgDPw61TGXNTb8eJ5g1tJmx0eODe1rGLyfjmvhBbpDlq+cOfRJVJfF7a8CKO0Vg5FVQ3eTISxGuhmdjtFmDQmF3zIDdvtw/2YAUIPrIox3qcQLU3XVPUI7zLkCY3I0Hx1zuOGtj/W017b9/y9nIRfTZ3UxoovbVmTY2nETio8+aBBVkwEpdThqv/YYOOUYkwKzUSH2Q6gBSCbqc5J2b+3jdS7sz3rcBmlDOILhv7kk5bQG21bICCMVt/Ec2hgELKTiKd1wFXXitigJVVYyPoNqo9d86OQcMNZCQaytdaB7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yn9ImI/uUD+xWuPLVvT5eW61OCozx2xwFBcOZMxBa2E=;
 b=bE7ICS4VGLY5+F/nZWFi9zNDURG1yQUrQKsaIo9baZhQTJwwqU0h0MrInoGSbZ+GafhsQvq+D9HXlkxRyxCmzJThX7m8eu2cBMHKHzPO044XTs4wkDudDTtXbDeNMnNhhxlgBmjWEIOa2W8UJvGvnUQehrrBYkWmTB371tXPm7K0Y09CyJYGTdIw2yOJ6w+qbLiWhriT/eDPo+bMGq2ls8i+IN2BOradTzEShnx8Md0KDECM0AzUzQERAwOdeIzwpsBYKfmTNN3WuQQzVLWjqAitgAWKcKAHoO0E1qCi5BS+YCmPj1bUHeFz7bD9jgO/erAgco1o9RTLdDjdtA846g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yn9ImI/uUD+xWuPLVvT5eW61OCozx2xwFBcOZMxBa2E=;
 b=n4iOJjd9pNuC2oTfHhPGQiwrb2EXavCKIdsDQ/sT1FVwOYbgAFtRw3qvEQBxUNk8abltKyxHa+Yl1t3vfuhQH26CYzyETVxvcYXWb4h9tAWHzMgqJbA/H7PyK7vnPwahw1PaVnI1n/re088WoWZKY0RkjyQAvaMGBxzU/x522D8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by AM9PR04MB8521.eurprd04.prod.outlook.com (2603:10a6:20b:430::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.39; Mon, 31 Jul
 2023 09:17:00 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::e67c:9548:36f2:ef3a]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::e67c:9548:36f2:ef3a%6]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 09:17:00 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v3 0/1] Rename BAA_SERVICE to BCAA_SERVICE add BAA_SERVICE(0x1851)
Date:   Mon, 31 Jul 2023 12:16:41 +0300
Message-Id: <20230731091642.3712-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0032.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::9) To VI1PR04MB5344.eurprd04.prod.outlook.com
 (2603:10a6:803:4b::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:EE_|AM9PR04MB8521:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f7c4ce-fcb1-4f6d-60bf-08db91a6e574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gsd1+4W2qaynvRsrP0YfQH6YD/LsjsJXwk1rQWkhfEENt+ycKXrpG0i/MUyKZKoXwaXJzzgO/kDPN1yAZeyBngwwRLdGNZKSOzhow+fW8HECg1Xebqq3VU5aEQUZuAmZU5FeE4611RQPvV4d7oNpMYt6Vg24fXKzWcBOjtGet+5mUSj4tYoq4w/zYntV4Y0CmvgHt+ZxcbB28+4t9Y9QSVgLx4Bvil+uWR5v7G1gwjQDH/wegzupvXSG8Nyx89rHvngy/sEj6PLQGBhk764wCb9t743iHPJIDmy8bRaiuLgzQpNs9Vbvw4cBhldn9wJrR4NxfjhfcBnaSZptulbfyPwbXNJuyVZ7yDAVjZa5Y4q58Rz7wV6Jyu4FgyLL2DyNzpdzlKO17IG+QGAa4i2IJuMYVYfAEAygcuj461kQ6KALzJLkLi7RL+zRzh2tACBvUphtcfV5sMFhTWmZzVHHxlAB18HNyxFMlwn7PABL9nfOzorgatkrDSwPlaN11yDEMyXva9mLz++ED6eUz6UpbeGOKk5Iqwm+AEBUJtMoSxFzUcdRQByxjDVSl7iivIJq/5KICkC3+Atpbr8ZO1sKCrPgpZapoplnOI65UIGx1jI3mlAPaf7h3ZoFv9tWw8Jv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(451199021)(4326008)(41300700001)(5660300002)(6916009)(66946007)(8936002)(8676002)(478600001)(316002)(66556008)(66476007)(4744005)(2906002)(6486002)(6666004)(52116002)(6512007)(38350700002)(38100700002)(6506007)(1076003)(26005)(186003)(36756003)(83380400001)(2616005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tc1f0ofLfHqoJz6v/vX+In5mo9VYjof7mzQMZtnLQe3up64QnmWqGzhlEceH?=
 =?us-ascii?Q?DoZI2DZvjFqeK9VYD60pPMU7hDJNeIFPRbe5YW9aLXURzoYC/iEh1A7SHGiM?=
 =?us-ascii?Q?uSg782lh8LjNsM8TNVykVLFzKdl2UvL3eailsbe/J8uQSsDI7cdslAlYNMBg?=
 =?us-ascii?Q?t/lDDbvFFCbZtZnqc4dSPLUpaZIRb8v/QsIJRa7UCL+XRdli9+iLKyzY3Wgb?=
 =?us-ascii?Q?LsqDr3n2s3rf9PzNfpN/GUSfSMONyYr/Jg/2+noTx2MJY5mGY3cLffk2AHPI?=
 =?us-ascii?Q?8kBGRBwbLSuxQs8CoilxGj/dQsYo680pOBz2yrHgLhYUrqkfo+E0qnxUUpXp?=
 =?us-ascii?Q?qFuVGzX5Kdq2JBelD5IxnzFMaZFXOheeoRTuwYk7/mazIlIUi2mnSNDhcDFk?=
 =?us-ascii?Q?KN4lJrojDVFuEER4Q1PWUoHIaf98HtYNQFgBKzc9ZbG72RrDh6BuP0hZsAEu?=
 =?us-ascii?Q?8mMqHT+GVrJP4zToPp5NfgBeytP6HsNIYC55z9vYeDZXjFVWdw13bKv7rsrK?=
 =?us-ascii?Q?rl15pJ3dX2qamPb0Znr9auXR03xIMh2yt05E7VhK6CK91ay9s5GPqRq5QtRq?=
 =?us-ascii?Q?mnM2DWAqu3nSbI2mPRcnnQE9OKJdm5s8YIeJWI5Vbiiz6jlx5dFzMYT30noM?=
 =?us-ascii?Q?VAbKIGdhao0c9UTL8zvmvLVip8kYpAyCN/cT8nPPH7wOXX3VeZVkZZbr2sny?=
 =?us-ascii?Q?UziuzWRU8d44iXXpRVGD6xbeVjQ4+0mqz54M0rqnFufKjp5FUnPzJDvfuDXD?=
 =?us-ascii?Q?7HFs5a921S7osK6+4Q918gDiV0gnwnKM1i4r42yDygMV3f+CPJMtkQqYBWWR?=
 =?us-ascii?Q?5eQZbuXSQ7BloN49crV4ZkMlC0CXTrJOQW1py0kBfjsSsrzXzaE6E+rPoufy?=
 =?us-ascii?Q?eG4xfAZzSi+PPty4XKE2vtUSIvO+yKPRqlj0Xatn8SN8tPTdNGJarVB/z4Yf?=
 =?us-ascii?Q?gd4ZoUsjCQhveC+lEtLBhZ13EetN7/N25CTRbcQGiRWwa4fvb8H8kSsBgF3I?=
 =?us-ascii?Q?mrXRlASZbb9AlVrLZz2nxMKSZqbEI/gipm/aXA+bMlWjsqNOsN8gInrZ2Fbn?=
 =?us-ascii?Q?Zs4gkwN7nJU3vMpBW3yTc7/rZ3k0cyw8pLkgP8ZZ4QH6oe6mE+cYG0SxDBdv?=
 =?us-ascii?Q?pTuH8p6eU5C5gITu35TMvgp6umwQ5GHgXBRUOfp0DNNbFv9cI1O3PkeTkbrc?=
 =?us-ascii?Q?G7LZeqcy8ME2ynFiyFwGaWewne/cdmO73tYlhtjrKBDu7GYLSRCDJZp4yjW0?=
 =?us-ascii?Q?hNU8AaqmkP/qnI1KD1/2IZ7H/9g7fixDnS20EEJXngDiwnqbG12hthlKDjWm?=
 =?us-ascii?Q?sYoI+8Fs8nV8u9OQgRj5Vp80yJxiaXG/aBrYSUc7NIskyqmPdu47pSkpbW+4?=
 =?us-ascii?Q?iUkXs7xP9l88Z6M8xmCfpiWJMk+E2Wj48XhT1PEOYZ/Cc/vG7atEt9ui90ZW?=
 =?us-ascii?Q?Pp+dzUFLzT9/tdT0HnCicPDYZa3JcASXHqo7TzHV735f+GiZiMplYonrZOsw?=
 =?us-ascii?Q?wjvk0uYh1SXviBdLMKw91rrrOEvaawFB0INmEZqnpZyG39rn+nQOu4417Yks?=
 =?us-ascii?Q?6ucQ7knQlR5Xz138EcwcdKH/KWZir/wPnQEcrXdCZTK343MumMoHHNHM5/TP?=
 =?us-ascii?Q?vA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f7c4ce-fcb1-4f6d-60bf-08db91a6e574
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 09:17:00.6153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wB1No/t3s8wCOpW0nUmEfvWoTV3AD0bqe75xDS6PogjlzE0+9zs45eX5CXXT/z9JEjl3hPjIsRoc60N6sRRdbsak/dFgmX5TNl914ibCMto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8521
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Rename BAA_SERVICE to BCAA_SERVICE and added BAA_SERVICE(0x1851)
as UUID for the broadcast sink.

Silviu Florian Barbulescu (1):
  Rename BAA_SERVICE to BCAA_SERVICE and added BAA_SERVICE(0x1851) as
    UUID for the broadcast sink.

 client/player.c            | 8 ++++----
 lib/uuid.h                 | 7 +++++--
 profiles/audio/media.c     | 2 +-
 profiles/audio/transport.c | 4 ++--
 4 files changed, 12 insertions(+), 9 deletions(-)


base-commit: d8ca06631b7434ea8837f9c571bfe31d6602d31f
-- 
2.34.1

