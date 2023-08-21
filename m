Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974A6EE4993
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Aug 2023 15:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbjHUP0A (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Aug 2023 11:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbjHUPZ7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Aug 2023 11:25:59 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2056.outbound.protection.outlook.com [40.107.241.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306B1D9
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 08:25:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIPHnZfWU1GPsyZW23H4qwCHbE3+y4OgObjdYQLoRkGoHDZl4zv8AlvnsgIQSVLYio98iFSRhRZohVRcop/BnKmojT9Xo6HLIYYtTeqNBjKYsQOlc+Xtmbpf4ymIWwkDPAA+ShqO4Uk8G1OxD9+DlasLHMJg+Di/0ID8tJ+Ie0oND+/QTw3avXDb5ZqU099bg5XXAP6RGvgETeNVktVjNAskaHeb4Nucpd1M9zBdcpVDbcu8n3QgqTWsr/qfNcWKO7umr53X3H/75UZNujhBtKO19xeq630C7uYH/cLI0XEhUfkf0li1vmQ/LG6uwPWtCpI6JKJ00KJ6cJKZhw+/zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2ifvNi7kdjMN0ZxG1/mXGfNexUnRe8ZPuTqxsjEV8M=;
 b=e8dbwySsD57ITK3hi/L+rUw/9pU5++fmkRe+hld6oY3E1lYZ2JqxtG+xYfDQ41VmSCoTSjHSYVYw/Iwpwgu9CZbIkByn7eq9ChKa5X7zwzJmpIm3Th3+D71HizoyHGU2N49wz+JsEC6k/TM7ie3Hirzc8AqywotGK1q8yS/OJiB9rFS4mmfXYfkiuDV0Q0mFTvUms9Md7Eq/0FkcHbxiALkwlaLShE2Gen+CuTm18cMD2Jl6+Ipm8YostdmGi9/mM1bOvRQW37OtSt7PKcHkPLHiqYL4OLw8vpAC7GEBa72A7zCKaTj3yoUbDtqa6H+yY+c7MRUidyAjBjCMowhFjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2ifvNi7kdjMN0ZxG1/mXGfNexUnRe8ZPuTqxsjEV8M=;
 b=spjN138DeBaGoF/xCARKXqmSOnkkR2r+vfnZBHiMYu7yaiKwAl7rFFGW4rG5pNrzG1AUainIOz/uZUSn6pu0In/9gxZKxYLGfBLXfP37/T5KCAnm46YPhvDiw6Wi4RGGbRvzTfdtqZCqF1MXaJgtE5xu669hqe+9r7WMPtfvHOM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by DB8PR04MB7002.eurprd04.prod.outlook.com (2603:10a6:10:119::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 15:25:54 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 15:25:54 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH v3 0/1] Bluetooth: ISO: Add support for periodic adv reports processing
Date:   Mon, 21 Aug 2023 18:25:28 +0300
Message-Id: <20230821152529.23000-1-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0002.eurprd05.prod.outlook.com (2603:10a6:205::15)
 To GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|DB8PR04MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: cac86a7e-bf3d-4468-325b-08dba25ae8be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YhHYEy+Tu4GZugcuDfdE83qqYGVoIHKXm3q1kleeeGkVscd7S/prNQA65uYp+SJ65Irj6UGrgfTZUmiFxioz2Wnpfb0g3MNtSqtj90hO+p2DVd1n3FflpV6FfXT/sEG5GF9jp5dfOB4he8dCQCnm3V3iQv8Y+EWbkSCEbkvivPl5C1R1SQOoMJ30/EGb9uR+XaPqe0xif7g/0NC2H/JF/ke5Yrk5UXETonawKB1xtg6XRPMRZ6eIAflz5jwEX3mHdE+3ogp0WTpuiLKF3GaSc5YwB1M39319DR0pcvizUMBxkJV/cxcgWZGZBMYscj48o0+g8DVPiMdzvBZFSs9Xhqq1DbyKPCwx5eTqSoLLwA6rRW2bUVFXPoSHOu0CbA6aD5JL5kg7DHBijdBSeiK7Kv3RXchwA2MYGhfz7U4LAWhwHx2jXcaisTMClwQtuuS+lSZw+RjNxfZEuLJGm8GDOPtxj/vkc9PcHPYj5d5mLhY3l6uBFm5zTcWEL71YowGQ38VouqbpblqEpw244RHpZRLCAmjLawMvHc08TzQDe9lWCrwaEXLr6JUj0rwXoxD2GwS1rb7jR6OD1vg4SsZTICbB93uFYupImI5LeLM1YrDDjgZ6I7CblX+GF2UPdquZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(366004)(396003)(1800799009)(186009)(451199024)(6666004)(6486002)(6506007)(38100700002)(6512007)(38350700002)(52116002)(1076003)(83380400001)(36756003)(26005)(2616005)(41300700001)(66556008)(6916009)(316002)(2906002)(66946007)(4744005)(66476007)(86362001)(5660300002)(8676002)(478600001)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BWk38Cq6Ek9cj16beqpDSL+aMGuvhLyDIW9TG+AoL73C4t1msfd+A8xzMWRx?=
 =?us-ascii?Q?svhdxmE/ICmSQuYqwBwqjPLhC7k4o1S7pAF/6eMq8lRK7svMLlXxfjKO7KRR?=
 =?us-ascii?Q?W5BIo/ISfwOMbCVMbktRltmWZbqaDlzapWlRMY4aP8nxhc2MDhvy4S9EFgNS?=
 =?us-ascii?Q?g90R68TgBFcmkty9aPGUHs7fhquJxOTN6byUWgd3LYRNyzI2crhlpjF2Oqoq?=
 =?us-ascii?Q?mKHOrTybhOouARXqgRPi9NFJCJwapBbo6UUPg6DO5pyHbtlCVE+GOrkTD5lD?=
 =?us-ascii?Q?qVXM+iR+jc0tMbYS1jq4VQ9o0cdyjh5rcUl3kFnqVFp8DELXeIrwYObacQRE?=
 =?us-ascii?Q?ikYOOHAvz+w6VY9Oax+UMTpSlsSWH6ICw1eRe399vNvnGGaER1Q5Hgw21AO0?=
 =?us-ascii?Q?wu0Nv4y6hmfioZ/ipT7uv3ffRCpXWGJ1AGo+ZQXlr8BxzWe+0/c/VnNISwAv?=
 =?us-ascii?Q?Uokz1w2pUbEVHayxXM13rniK35P5/I1P6d/SJnx+pzWIvSoiorie4x2KSyVl?=
 =?us-ascii?Q?ToCgV5taaWR1tw9aF9c9x/gg/cyIENbPsTXgwcKM6lAS17mLjsFrlILZfbPX?=
 =?us-ascii?Q?kUB4psiVhaXShKpiuiTHJM+HeLP6SFy4dxmUHNy+0dfvuywyPD1/NDzGrLgK?=
 =?us-ascii?Q?bQrY0Nrh27dhVjb1SCiLS5970qaidyuwK0cxDOQeziFInxYfrSvDqAKp2Zpp?=
 =?us-ascii?Q?ruNEXRCCeMJIZvi1U4+iV4ThVemhcLxsPH3dmSJjq90T3KXKWR9OmsycUnuV?=
 =?us-ascii?Q?lyS1t+jqEichgKkxhmgu/GJn61KZsoli+soJGeij6cquN8magtM1mkTWxISC?=
 =?us-ascii?Q?ymZ9yQnM+edvba0emMrAT53YDKp0h5WSU07YMxBEOExRbPLgkQIXUGjqW71E?=
 =?us-ascii?Q?7gmGeTV2ih2xNonTbk6GSDjZKNRl6qL7DK5dQ2YXswxolZtY9aR1pt90RB7z?=
 =?us-ascii?Q?SGFQm/iPLn3dmwmEgkl/1hgWp6ma+WJVFJORH+wJPWdvIoZOzQuy5MFH2qWg?=
 =?us-ascii?Q?qHCsb2GOwtgPJKDMLHfjPu7AJeVmRgfsbpcx4VRErlT7fV/9rFu6Ipazppoy?=
 =?us-ascii?Q?JooD1SabyYkQoqCi7ph1Ibd9jLsnEYBmFqBqnfmpI1TsZmTA1epNPqVoHylF?=
 =?us-ascii?Q?U5/Bb74Y4KRaNGoJgsDNfEjl6Y/P174n7it3KZngZDwv/Q0fvnWLccBdq/RF?=
 =?us-ascii?Q?oRTuclm/Vv3kk3hCC5TPg3fp8XND12BD0ncjNL+dhNKQLf0rKX9GcqDWMQmX?=
 =?us-ascii?Q?q5CukWH4h3cABk7kYOaJZzQHWyd80jo47O6Cki4d4fiS3CFPvcVeASq/BjQA?=
 =?us-ascii?Q?hrLgVQtf7YEulpSs9HC05O1BYhwpePtOzn1iXcd9xnVmp6IgiCpAapKIuyjp?=
 =?us-ascii?Q?kGUjDB7LrecBNFjKPo9kBkRrF4eOJXD/FK8lpoECeNHO4K5YPtcbOPzQZvNz?=
 =?us-ascii?Q?0n2IxXdoFn7bOpUMLugSLk7/wMYYfMQBl5SIocg9nHLT/mlVal98SKQOGLX9?=
 =?us-ascii?Q?uXv3ZYT0yLu3p8NOPA6/k4NZpxzf5y5bcOF9OEZidTtvhmn50pXOvjJ8CdzR?=
 =?us-ascii?Q?tgrLNIROH7ZhoNaUPjV6DIXjthuFBF1oXXccadFM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cac86a7e-bf3d-4468-325b-08dba25ae8be
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 15:25:54.1200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o2K/ZB0hcfwlgm2lSQ1pS1RLGRGkpnmsBhoENGw6NOTtNM+mHRGTlDxq9a9DklGFIOxSqA7eMnJW57bJ7bdzTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7002
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In the case of a Periodic Synchronized Receiver,
the PA report received from a Broadcaster contains the BASE,
which has information about codec and other parameters of a BIG.
This information is stored and the application can retrieve it
using getsockopt(BT_ISO_BASE).

Claudia Draghicescu (1):
  Bluetooth: ISO: Add support for periodic adv reports processing

 include/net/bluetooth/hci.h | 11 +++++++++++
 net/bluetooth/hci_event.c   | 23 ++++++++++++++++++++++
 net/bluetooth/iso.c         | 39 +++++++++++++++++++++++++++++++++++--
 3 files changed, 71 insertions(+), 2 deletions(-)


base-commit: f0835e7404b7f6fd825fc1ad7a174253a54234cf
-- 
2.34.1

