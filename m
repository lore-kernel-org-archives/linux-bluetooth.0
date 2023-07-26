Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F40C001DC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jul 2023 14:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbjGZOxl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jul 2023 10:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbjGZOxi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jul 2023 10:53:38 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651A32135
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jul 2023 07:53:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwcJqaMV6tJEM0izCoxjc2iyBIlcI9fKRKRl87eh9+bIp/9YU3q6anHLbbOGbclT5MvFyk10JLK2VKBwReTdruptG3mzuZJ23GoY9lsE1eXtGJ3FHmmegrz9lMrmbnIuMWpirbIj75A2KmoJHwO5I1D58u//mLtJnfYFXH6GWp7hlvVodMHUhPOWhCNpsVpHytRVMPU6QM+xVU2acgh0lUbjaoxFwoFAdeL/n+V6CAY3k43nM0cFAtuhFORrCErEldpwbvCBSS2RqExlmHg4WeX3qXucRrO0D8pW+yDIjDWjUjIOefUO/GXpxTKB0uqYtViwvJzejMLse7ME7RDgog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6V2LxkxP6jJmND2NK3AgExmBy2/lzgV6jTWSr9ytkw=;
 b=JwT9y9Iq6mZ/iaxT+X7ChTxETtC5Tb8G8mJ4MMVzN+rlASSnhe8DWjfSZC0jyW8MD5vsYXKDfACcdYg2lMRIp8eH+vNJWysuLzlQEb0uX5nds6PUbtvdqs73vsyhWl6cbFVEN3QraPECUz5xBJ9pSK0v6bF0gSJ7zyBIeSM7MsJmdx9ULTsUrq1DpJEqQCTO0cY3liAIMdwtbuHy1Qx+fGvliE7Xb/jWNGkdDQBa2u0YcdtLIzTb5tDMt6lQbcDhKMzQ2svfCh8uY7XB52Cfz22/ACcJWUqbHj2su+jw7ptCyiW232PiH6bLIJIvGZg+a1cZ6TpyvdUv8gfSxR0cbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6V2LxkxP6jJmND2NK3AgExmBy2/lzgV6jTWSr9ytkw=;
 b=ijdvjd/2x6V/w4Gc6E01A4mZiL6xRFhkMcMNymEl+2QYKl/s7Wzjjo/gVmTy3qybvtmMizhYMvKs/T15eySt2lPFisnynjRyRUM+KTUI32lQf8Md8x86L8Je6eEeztv0x4JZDslFwLhS/s1CoO/RKdUZzdF0OmIKCSf9Onx0dkc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by PAXPR04MB9707.eurprd04.prod.outlook.com (2603:10a6:102:24d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 14:53:34 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::7fe7:582c:e250:bd4e]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::7fe7:582c:e250:bd4e%2]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 14:53:34 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v2 0/1] Rename BAA_SERVICE to BCAST_AA_SERVICE add BASIC_AA_SERVICE
Date:   Wed, 26 Jul 2023 17:53:02 +0300
Message-Id: <20230726145303.137597-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0035.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::14) To VI1PR04MB5344.eurprd04.prod.outlook.com
 (2603:10a6:803:4b::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:EE_|PAXPR04MB9707:EE_
X-MS-Office365-Filtering-Correlation-Id: 674afe1a-1d23-4950-7b71-08db8de815ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0T3xW8F7OZNbBEdTE1PmQzg5nctdVi1YG7jioC6bQAiPj+obAxeG6zp5yZ7FPrR2dFNfkOzUp1bvFFHXtMUYohgKNil+LCwRHE6+B4MqfWsvcc+AniMTLJ9HSw80m7Lr2KQA9Rqk8ruOGr/Fyv1JSE0MTA1v9Un5dGDSAvJBn54ah5Korw0vep6WQUNvFVMqMJZ9Sp7k7dkndHppMpS+A1qrv71Sckh2L1PGvcUZaCCFPckW5XO1zd2hL3dklqvQpbO4vJboLsw9k4bm1pGp1TiP1HeYSp5H5RVM4VMKJCXLzvlfE+Wr8g8TvsyuLTBQCg/CxxtL/BAz0YNjS7/Z5jEywEkRhhndbAmlf5ljtir1cSqv/VdZRfRiRSkdZ5rRhjlf94oO5+guvAookdQ14ayZ1k+YTYeiTaBJlz+T7q+T+QsgG6mAXWS4sm37nOAqy9HyOVCNn4XjCzIgiqWhMkEC1+Jfr0lk9j/c6TaTQs8u457rUHOOf62WgkD8G/dPi4FmgWq8dIavxaZB5Y45xDS1sULpFS+6s5C5pupR6c6x1lZioqP2LVHfUvxf3I6ZvLatUQLWZFxdLvAGM5eiO4jKe1WvjgUyUPbF6TjBAVwPtmvKl6RhkwMA1rOjWUOG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199021)(2906002)(41300700001)(316002)(8676002)(8936002)(5660300002)(4744005)(36756003)(86362001)(6512007)(6506007)(1076003)(26005)(478600001)(6666004)(6486002)(52116002)(83380400001)(186003)(2616005)(66946007)(6916009)(4326008)(66476007)(38100700002)(38350700002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rqYlQQTpLgQM0p3SvXYeyITwch4HkBIUeLMsCcGvIAdqbPGOHPGF0qvLoLRD?=
 =?us-ascii?Q?47LjLYnG5vS7txnTRkiXPGyEhi2hv3xuTi6lkstkEXmuVepBcAc8NDgbO2Cd?=
 =?us-ascii?Q?IdSsZ3at2rPOh8aBd4XUExUkMQfQKV6n7QtGT0zlvmx1e1SnYex/J3BgWOAG?=
 =?us-ascii?Q?/lBJ2glLrUrFOGO6ubGRYAhPyhAIQfTJS1VIH6CnnxHhF/bnpxd787Wb/cle?=
 =?us-ascii?Q?EVPP8JxEYIoqp2Jng0xlCvFmuaimBNavDVlnbHrmhRVBHkWcrk6Lya5IIfhp?=
 =?us-ascii?Q?VEoQIMPdRrsoyfVDrHi0kVew2Yb0IrMTfoyharK48yw0V3OgXkFFsJaY6iHF?=
 =?us-ascii?Q?4Nq9lffk1LrT8rHlNuRDZCR49D2bmK3nvemDL7XmtWxPwKeQCnigkmdrstZP?=
 =?us-ascii?Q?iJ7baYFs/+/4P2pi3C7JeowVUl7dIYWVCFu2u/B1PBFTA0NDwV73kc+jz2DG?=
 =?us-ascii?Q?ub0go9XW8wX5RB1aw4BRtyOT5nkuIHN7yknbyEfE4TFQrilE9Deqq3ugIQca?=
 =?us-ascii?Q?/u+MwgF6HbVkmt/BTkUlFH5wweqJkHQnvu15w2kI4iiYub4B9RMjNY7qcxC+?=
 =?us-ascii?Q?oQVOml4yAG5tubYfUvIJjO6Zr7Sl6+301Tco4dVGSkF2eiryPlYNDh5PIYjV?=
 =?us-ascii?Q?iRieZqftTdVdi3gQncxjVUecFvIXNHe6pMwU+cpoQHJTLhJGT5NEJTYuIKNP?=
 =?us-ascii?Q?kE8Q0M1G6EyBhao61qpl5VNsxReu9S//GKO0uHxK5tkmcQbg8wrUN0cetyKQ?=
 =?us-ascii?Q?u3T+19vXPfo0eBHAiJYaPlqz9mtVm0IW5LQc90bR3gbLFMNQa15jrGn1tYEr?=
 =?us-ascii?Q?mvPehugbk4sR6rql1/98/OJ0GiVVzzSjsY89LiGtq8yQE8YwpiRcmZKtoU1L?=
 =?us-ascii?Q?FqxYFMr44XI1CZuUPOULFt4R3Zq8t6YLIMW8SGJRz1y/a7Owm86f+Q16cHcl?=
 =?us-ascii?Q?uq3Z+Pjf7h2PtX7SOayOlij9NkGeSn49uSLTDPiXTM86FXFd7lrZedr5Nfoh?=
 =?us-ascii?Q?pDV/2zLnp32x0lYnE2E5CJlvjZwzunA6th9uPEHQ3p297K4e7SKA8pHqRG+s?=
 =?us-ascii?Q?wOvmxZgd9poQOVM4Wzw1InrDA4PvOMgX/GiAtjWGPMtH0ILan9dG3Rk+pavq?=
 =?us-ascii?Q?S8PFlOpEw/09rH5/4JRh+6pn3TdpqEc1VRqKyBOnp3uDaHg1KqtE7Zs80qqk?=
 =?us-ascii?Q?Gqfsi+DOCTAa4DG5J5NDaIQEKzDL604oAkmqecJRGx71JQCQzHqNT1aZirhH?=
 =?us-ascii?Q?OfQAQAaI+bB3ECtCBaVjHd4baAoiARK1gQdXZNzN1Og+SdcJ5GAhT3QBOE1E?=
 =?us-ascii?Q?27RU4OXQyVskJe4zMHpzKTjYpd7Fz9mY+R43wmtponwfMK1u8BXsAjIZ2M18?=
 =?us-ascii?Q?oikgwvzhM2ew/TaSvMfbLvcRAOMmy14p5hMrm+ylatRVX/IQdUY1vASXORlF?=
 =?us-ascii?Q?r7/RRmDKiUp0O/vjdxoJ+b2efN3ScNWw+LP42Zd+LHJbk8XTRRU2qDZ3n9LU?=
 =?us-ascii?Q?tuzAsPjK0Un/G4Lt1PZEuAQklbaoUgVlbIPMzoPV0SnyyxA9NwCFxGbyfgTU?=
 =?us-ascii?Q?G3+yDUKrfROjg4MVMSDfnLc+ItRhTgxV0113f87eL+UQLQbCnL1jjiZYy5mI?=
 =?us-ascii?Q?6g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 674afe1a-1d23-4950-7b71-08db8de815ac
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 14:53:34.0445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNgifd0TAFL4d/959eoeZ326aVIfVxpv6ZpX/1up8VlZtFdqa8eKKLPPq2BDQH6+xoNmY1L0SHvYUkdgoGgcOCXgsGvILQkSN+OJSQWUS60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9707
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Rename BAA_SERVICE to BCAST_AA_SERVICE and added BCAST_AA_SERVICE(0x1851)
as UUID for the broadcast sink.

Silviu Florian Barbulescu (1):
  Rename BAA_SERVICE to BCAST_AA_SERVICE and added
    BASIC_AA_SERVICE(0x1851) as UUID for the broadcast sink.

 client/player.c            | 8 ++++----
 lib/uuid.h                 | 7 +++++--
 profiles/audio/bap.c       | 2 +-
 profiles/audio/media.c     | 2 +-
 profiles/audio/transport.c | 4 ++--
 5 files changed, 13 insertions(+), 10 deletions(-)


base-commit: d8ca06631b7434ea8837f9c571bfe31d6602d31f
-- 
2.34.1

