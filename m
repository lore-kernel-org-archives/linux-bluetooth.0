Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1EECA0ECA
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Sep 2023 06:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjILGkt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Sep 2023 02:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjILGks (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Sep 2023 02:40:48 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2075.outbound.protection.outlook.com [40.107.247.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B57AF
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Sep 2023 23:40:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkhIRZdKuZgZmbZoxoaJZlSftEE4Cg+xLi6QUr6KJ56A+OIklJ1qLQRLEXy3Vrof06G+NefhXJ47UCGf+Pq6Xb+mWOQP4RFvvKhtrc2ISeb9fxTqE1/5X9cx+yMYkHwaBRsaocDbMjYaNXTq7Ga/kk7NUWiCXcl/D9vh/KjZ3b8Tu9EhrhcFaQfF59U73mblILLzEybSrDNiTTDIAah7AK0JQqLuM8PZTjSKz+kQR7AQw3oGGLcb1g4ptT0JDqQbkgFKSQEDEwFf879MRg7Kp0YkWbkKb/XcRWKb0tFhSPeCvkAe5DjctjfM2qHito/24b+XPiFGeWzvB/04bbQNOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1x3Lx6Bmdw94bOCnAodZdnLU3cVjXDsHMlOka9MoNFc=;
 b=NVsXADCj5jyoajA6jXxcAC2r0NwgiWanSHDftjsOsK433eYSE761hIVbjkhBYIwX0JJj4Er6luYnIsuZXL2S7RI/qVjR0SXbmdnAM/Y8FHitkQm7kLN0R3m0kSpojMFsYix2QfRSPdNrMn/Ht+tKMs0SecHtE2x/q5hZ+Ni+JC89FMIV1iByVSffAWQ2solTnCP0vDlmnv/U7kuzLyTVx/pLDhAvtRmDmDKiuVfw3pvVxGTBVJqsYdgsnNRsp8j6XXwIGVGlXBDHYR7YCLtYdaHnKTsm2GQDyfYnpCEt6gypDa/WxEENsBnVefy5t/kS3fJLkBqis7aebHdxqYLhZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1x3Lx6Bmdw94bOCnAodZdnLU3cVjXDsHMlOka9MoNFc=;
 b=k9tgVLfRQ28gq2+f/UFzF+2sBd9i3x3VJ1mpxE3M6DyWX4NSAByleeOQHPjJak8DelU0P0on/T+GPiWz3Gs1vtchv2fzS/HLBFSuBEn1TJxXxCeNByZCM9WJtHoHbeMP2FxH0JG9M+9MSSsYeMQkyFlalBMpmsg6NGpSIlFthoQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com (2603:10a6:102:2b4::19)
 by GV1PR04MB9199.eurprd04.prod.outlook.com (2603:10a6:150:2a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 06:40:41 +0000
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636]) by PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636%4]) with mapi id 15.20.6745.034; Tue, 12 Sep 2023
 06:40:41 +0000
From:   Vlad Pruteanu <vlad.pruteanu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, iulia.tanasescu@nxp.com,
        andrei.istodorescu@nxp.com, Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 0/1] client/player: Add command for control of BIS encryption
Date:   Tue, 12 Sep 2023 09:40:25 +0300
Message-Id: <20230912064026.1203509-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0054.eurprd03.prod.outlook.com (2603:10a6:208::31)
 To PAXPR04MB9398.eurprd04.prod.outlook.com (2603:10a6:102:2b4::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9398:EE_|GV1PR04MB9199:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ae5512e-8d2e-46ae-4a57-08dbb35b2edc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XJxNM8OhWEzq76p0iBwpYA1eOxZRnm7DPHEc/nrXmy5UUXmPi2co/6n7EnumZpovhJ/T+q1DmDtjvNA/Mj6PUkJY6Y58nozgVVHPsK/MhNLeJh7hHSzOQAgoZV+Ggy+KVTchLuUsifJCUUcZ8u0HH5gHAcXjcv0B3IC6r7ko7QnnAhyvTx0IuQ9HNSUxkoVkE/4F4+YAkpa+nm/XHJagFZeV8bkmlC72bysEMwR7Z95I60Z9kn3KfALveSRpxXa83LkQMK+5/x0R1p8l1Nsrt6WkY2tGmiA9nl5TjZkEKGXDW6DU0pd3kAGyxzLCki+TRQ8mTcJqQ8jka1LSfutTelpcuct3obWu9odCv4xcAVD8QUOTz2yIywvJ5ZdNlbRotZhLVpTSppNN1P+O+3FgtL0MV8+GHek/GcaTLT8SEJ2iGXSsanwJ7z/tizqD+J1mjacHxB2xWFpDkzVp34YuU0Eyxd6LKD0LEvtoV+c8tuWUyMFFJbih+XcE6nHkCrEo5f0G1SK4LxqzQL8YlbUcawu7SOW+v+Dwr4EaloeZr5GXim02JaiScSP0iWBuApaC4zwWOPW5p/PWQ1DB3C4LCx9oTKqQmMHAF2vqtgGccSDer4zTrqRlY5d47uGhBqUy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9398.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(366004)(346002)(1800799009)(451199024)(186009)(4326008)(8676002)(8936002)(5660300002)(41300700001)(44832011)(316002)(66946007)(6916009)(66476007)(66556008)(6512007)(38100700002)(36756003)(26005)(6666004)(478600001)(52116002)(86362001)(6486002)(6506007)(2906002)(4744005)(1076003)(2616005)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ph2gGFErj7KnkcoveB8QqCa1KlpUU7D8/tRbgYsu05UUTPM/4eo4q77of+ht?=
 =?us-ascii?Q?YC5LyJeVQrNYBNA4BjuCm9genaUmQV8ScDrwQrse1LJmvgvXwsgxM2vxlE48?=
 =?us-ascii?Q?eFZhwPQqC2bj1NPVFol6++hnthgTagtTCc+AydTbBjPzxh+ZYkfjBkB4uaYb?=
 =?us-ascii?Q?O1NdYUwuaaMdEXjS/08MT1ySrP9VpY26eCUurR7pHVNkqEZeKxQi0utz0F+A?=
 =?us-ascii?Q?btX8PrivAKICXaCaxCq5B95ik7gPrJ/FSWPc+JKQ8RZ7r1hYWD4UXCLQqdiG?=
 =?us-ascii?Q?mUTnjHe2Fvrl9qzxbHUkptMXTH6PFy3QKWYwLEOG+UxVDRy5V7nRCFKh+Cgq?=
 =?us-ascii?Q?fHEI3F9xcvq+JhsUUaLM5vg8acBRMzrLkKS67R4GBic/8Gdy0VFk5n2vz2/m?=
 =?us-ascii?Q?3RJrcM0GuXv3kPC8kijlPZCsjnxm92e9sTVwAK/SX4L2KCMcFKDGWp0zWLLw?=
 =?us-ascii?Q?JTqIlxesTWyrDlk5PGypH54L9GYO61ZG28QNlNiP11YE+bNqlBeu57OQYluE?=
 =?us-ascii?Q?IcWgASUtfk2WMhOTP5kma6Sp/TOzH99fsNlnUpN7+3tECEB+x0JbFA0CI66b?=
 =?us-ascii?Q?akKPYdAo/3bBtVFVjSyLjKuS230ME/I98Qg8/Rhqh1WkBAVfWqUlhBjwOPBb?=
 =?us-ascii?Q?MKZTjy074qk0iLf7ShSZKBLW+7MxNqss7MzIiPqMGaVCBJqL4Yl50v0Wykfk?=
 =?us-ascii?Q?1+6UI8Nz5ATpaCl6uG9KmS/e3Ei8rK/NkKNJkKngvtu6bv5h9wHAR3cyZ0Ph?=
 =?us-ascii?Q?beScjbam9b36HbHbTxtTcGIUyKeaJnNVBqHQo7VEPvv4EQ4xjvPry+YTjOxP?=
 =?us-ascii?Q?b+HD9sBhDlS4puteKY+TUtJvLN1xjYjg4LaLgW/sj83aPK1Z3QeVmfCC6bmo?=
 =?us-ascii?Q?bgeO+YUrP8aU5ne4vyCrcxY7mD7X7zVB+8b4rb5sjYDh2lTMCDD4qz/EfuIc?=
 =?us-ascii?Q?OXMi0is+cTuyd/V5KBTxtBjNtPKv8Q1vCd4n2ZnonIHXkVH7Te5sEYNKMjBp?=
 =?us-ascii?Q?TEpkVPsRSDllbjwi+VeIhjVn7hZHfabOKLy8lXyMouQq/CL1FH9jOfBn28QE?=
 =?us-ascii?Q?dYI87CMGntDPgjXjav1wQe8sBR0xWCVEaq19PPt8WziJuXmsJ1ObCnie/32v?=
 =?us-ascii?Q?2x0/RBuBaDgMWlPXCfKYBrTpmTwv15Yt+tdT41/FQv9dUf5BvspG88vwvYje?=
 =?us-ascii?Q?xtgrtx+/afQ+I2tP1o/jtgGRMCN+RqD4zYpaAWCKKrXgOwZybaG25Z0txS7z?=
 =?us-ascii?Q?8ZTwsIgVjksuonHvHkdw8nixO/FzUztOa0e8VKnVdzNeiT7Qpv6tSod5zL+A?=
 =?us-ascii?Q?Rxx3kCDxOTCJLGDDvRXmwo0IQsBbE4CHDqfBuWUQcfEIP/AUVEvJ8TWmYtXi?=
 =?us-ascii?Q?7ZnWl4HJba6QNvXvgs500xH28z4PvZO00QMFvunqZ2W/m6aGSkDBrh3XND3q?=
 =?us-ascii?Q?FbkoiYqsJazlYBYiJFtCyN2WEApKNsK1h/orfjAhYrthtj39whBe4I/ydNa8?=
 =?us-ascii?Q?Eu/OQ4M9TlaHuOKtjJXGOIhrPFy6BaqDXOUNhA4HQahcBhbZOryMmE2sqkaJ?=
 =?us-ascii?Q?V7ENeYvygdy+6L4f2qpqkHkF+phBAYitHoHcmY8ZhJ+YWwvsmVyGxqfTfxL2?=
 =?us-ascii?Q?HQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae5512e-8d2e-46ae-4a57-08dbb35b2edc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9398.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 06:40:41.4089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AOTThsxGSsQPF5O5fh6xQ9O5wudE3jUxMRa0I4FV83uY2k0OH4KWbb9/Iz1xnZOCBTbO4rtAMa7QjLApRP/k6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9199
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Currently there is no way to set the BIS encryption from
the bluetoothctl application. This commit adds support
for one.

Usage:
	encryption [on/off]

Vlad Pruteanu (1):
  client/player: Add command for control of BIS encryption

 client/player.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

-- 
2.34.1

