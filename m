Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A96EE57F8
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Sep 2023 11:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243034AbjIHLMe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Sep 2023 07:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242033AbjIHLMc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Sep 2023 07:12:32 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8649F11B
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Sep 2023 04:12:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ecgmq2uXCYUBP5u/SPw2r4CWECMiyoy+XUI++Wey08hPB/6bzUJ6WA36KESJX61lf402BRw3Ncsz+EU24BBC4F9kw2etwjceSVgZHjqa92m3z077LYkBw95WCoSdJbKVGZP1WqGjK6QTo2VbD59hocdyoWDU1OT4bc35diMMi8QTDwafKmPBXTBpnNUFwOIQzz3Eusj4Aaa/8s7mO7E0dGAgjbfDLYEJR8FafrgguWQ+uRBlrIf/77Rk2VdIG4wd2tLIJd7TnhkBeSg3jaV1Gkk2XBgjIjWstMyxE6E17Lf0zccrYP0t9CKku2aqAc2HipTIVWA3joNzawcvppRkLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4O8f3H7O5aT+j11cTeWRr+QaI1CgPu6e13+dPosauQ=;
 b=ldsmUk4V2ID1YWW9Ybz+WtZ1Gz5dL0iQeHW3aG/71afQGJfUWKk9nPd3hiy8iS8YTHeK2EZmb7VYMCio0gVQ+D8diwN3S+xrNZ5TMVrmy1FpdHeav2n7r6je1G4s22okpUjeXEHfPVFPtICRsrTyVMc7kZSDhjNKuqJXhBSndBsseG3HyqmV5OHTUSeHuc6n90T7TPGWeBvmT5Iv63aIC9UaDtdZjvNfHMa0zLm/pyRU6b1EW8m7nI9c+3gtJn2c8r62Euxke1k4Y5d7TKop1BWOrM6JKKkDCY4chRHX2HZuSBTQBQBwHqa7eIjz4oHUD1Tx0xClHSrLcGeR1B1Udg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4O8f3H7O5aT+j11cTeWRr+QaI1CgPu6e13+dPosauQ=;
 b=gFjZy6yRVITyEabLSOQASNdvOq8x3OaUgsp0mVVORSWoqgJe1S5fYgT57frzP13iFEZ0TnncLLI51GkKs9CyWWgw8wakY3m/CO5gfeHLuGRJhwnWe+GzvPyNcOEmV9tVbNyDCSpNPvZpRsch/+1rUID3w9RhHihzRnC7jHQb06I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com (2603:10a6:102:2b4::19)
 by AS8PR04MB9208.eurprd04.prod.outlook.com (2603:10a6:20b:44f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Fri, 8 Sep
 2023 11:12:25 +0000
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636]) by PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636%4]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 11:12:25 +0000
From:   Vlad Pruteanu <vlad.pruteanu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, iulia.tanasescu@nxp.com,
        andrei.istodorescu@nxp.com, Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 0/1] bap: Use defer setup when syncing to a BIS source
Date:   Fri,  8 Sep 2023 14:12:07 +0300
Message-Id: <20230908111208.121996-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0007.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::18) To PAXPR04MB9398.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9398:EE_|AS8PR04MB9208:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be2603f-9d0a-4985-2c2d-08dbb05c7b2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rR5Ah1UQcEB5gDjNG3JZCY9g35TL+YtZp2w0IoHRhSgoy+qFlEWznTUmAGjW4yn9CSyuvfHuAu0ntQLXThCSUwpxvzbvYZfylPjciS3lTyXUtMr3gLaT82A1Nn/MoPTdhVF+FlWCQWFm56cMQckYZ3eCOOQ7EzXV2ESvR59/7xwa8Kll73H5ZQR7HLWoXGEk2h8i1zPCSa3YE8JPwpzIt1ETS6awbIxA0Mz5zIXGOgElIu5LVfgb4BC5TdumwH9r5r43dLV6hP5ZjXbGQPWNW5M000GenDXJhO3kiU4l0x0AhYFJ+FQIr5KixDL/AzfqyNh2MRlYT6SB/qs/WHbfyLlFqAXb6uUKYyE60HroSfFWHzfwtMes56gZ+/vfKE/LxGE0Z7/5wIF57p8Fp6yevdq5oQ04JbA6TeKx8I/f+rK9e8tNiGEcgDR+eL+/wsK/n3jkPmwUmrIHLNOdPa2+3OqPGh/Wuu7yUSffB5nHabbu/+gL4uZZIFeQZsY1brn143z73OTT4DFbd57SGx+soDtvApIprQZ2k4C0RPjkGqHf65Y8G2FWLm8jVEAm+i36LsRawXPsOh+aDXZHcyIqedmKLspfLfLRCfUscdl0q2GLkaH03QYqPt4C88DcVuQ2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9398.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(346002)(396003)(39860400002)(1800799009)(186009)(451199024)(1076003)(2906002)(83380400001)(4744005)(6506007)(52116002)(316002)(6486002)(66476007)(6916009)(66556008)(5660300002)(66946007)(478600001)(6666004)(26005)(8936002)(44832011)(6512007)(8676002)(2616005)(41300700001)(4326008)(36756003)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zUjhP1XCAE/SPFtiSlVCRijxtFnqjpOmlIQDuuPmoPdhSTkU7div06BisjRR?=
 =?us-ascii?Q?laRDmsqZjVdds07Mh/JpyBtKjtF0Xcs9MrGVybUxTGKYfe9VOyPoAcCOme75?=
 =?us-ascii?Q?rfkEQwwRKCxtea9BZCJYbbCh8k1svQml0edyQU/eiakepFK895fs1EC8jKa9?=
 =?us-ascii?Q?3A3RT5jyRPNeTTjYh3erA2Z/Alv4vJAJfgKxMboElZFvkzKRXRCCoJYUTUJR?=
 =?us-ascii?Q?dzZPN8zGalxLUT9D7g4aV8PoPXSQf6l9qGK3+HvLtUX7CM+sysMBgQ+ieHWf?=
 =?us-ascii?Q?VbkANlX9rJmIPLsCxnYvLagUCtvUezzpFia6wscyLv4wIiUg5JMX9B6illCj?=
 =?us-ascii?Q?SLfkCe9oPc3n0aZFclz87zpyW3M+JA4UqMFXNaaXBTf1x7Lp24yj7lcLwI8I?=
 =?us-ascii?Q?dpJBExBo5gmgZObrVssgQfMkxl5m7kkZyYpDQoPzrtTykOEWjDIFPog+BbOA?=
 =?us-ascii?Q?+KsY6IZafDLCGEdwmxhEpSgTSeUfr8m6hG7iZSRWk3d/pqqLY+FZqYVLor9y?=
 =?us-ascii?Q?QeJe7DCwY6En4oavn18E/CLxfaMgMnpDgL5oHT5FTe+H5HQhuYDn2m+uQ6bK?=
 =?us-ascii?Q?ah3IkXfuvUm9AqSC17uyumQWN32K01gSAP6RG5hoebzGjlCGKHcfli+DO4kq?=
 =?us-ascii?Q?zuUmv0Rivuhvrysgt3XxSF/P7hzk4BjXH5A7FiMiAssjUORQNY0WmZVicMap?=
 =?us-ascii?Q?LVX1G+GB0AbzRUMHD5u1WIGdyZw9U/Hx5+/KSFMs94NQ5CYR9FQ3urCP68aK?=
 =?us-ascii?Q?lKDIbIj5qP3z2cK2HyB5ulf8LCYCiaI4FeqpSKZUyJOOS31i08I4lgpWrAIP?=
 =?us-ascii?Q?xR1kTDARQFqUo9I8ZTU7I7QoTo+lbzzEHW4HGPn+qtHgyeM/VPPyUthqyoNb?=
 =?us-ascii?Q?Ynhw16aY5e4qNPCcMyPPcNtYSvTCwT74UXaJfYILlodD8ft6WU7gqbNQdxRJ?=
 =?us-ascii?Q?2x4lyLsMajloZb2zCx8RF+HG8GTsGYybkrBUe2hK5FU/0nxjvP3M0geN/PRc?=
 =?us-ascii?Q?+12ktt87lI0lE25WG2zk/2iG+jhDCiJpAaHDW0v7JrRtXFBAvHDcA5ymdg/k?=
 =?us-ascii?Q?Y533IYgsQiyerDcR/GCSjfU2jau4OhPK0gECmrPFoVOF52QTK8WAMd7KDG7T?=
 =?us-ascii?Q?IhiFa3jOKvwFCr5IT4H+d5PIy8TF9QTj9SXVza+MU9o6j1Xuj/BIOXw3a1iC?=
 =?us-ascii?Q?W4jmIDKXTghXBpXdjWgJ0Ftu9APXZNxPHD/Ux35woZAEMulwYcgLteopPQyD?=
 =?us-ascii?Q?PssrnxUjIEF2bVAhtdOkMNhJg+8EoLjhlcZZgZdPSAmBnGBvgEB5gwrLwqQj?=
 =?us-ascii?Q?KU7IT/x4lTiPRV2KVC5PZPbXrdigGkIkA3eWhw6fvijqX8fY7ZJ8aZzpqCJN?=
 =?us-ascii?Q?o6qA+bt7kJwgDP/iPTqNWsDrIwycZ1rVLVWPm4pgSFWJoV031LREtS6l/CQu?=
 =?us-ascii?Q?vG10TGvHG06ebr6A5GzWzphQKMognkGchu9kzUFT+WMIuPleDN/fqzc6KhUW?=
 =?us-ascii?Q?Fm2e9U/w46BhdPx3aCCCfQ6jmOWXnukb8nY+Sd309Njqem6rqumH8bt5RG/M?=
 =?us-ascii?Q?vNuozVMKnG/Uf8jeiOrlQjP5aDV8JA96O57EnN9cj43t5Xl9VisM26WoV2+A?=
 =?us-ascii?Q?1w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be2603f-9d0a-4985-2c2d-08dbb05c7b2a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9398.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 11:12:25.4424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/N926NrYhKla5MfbFvoNHr4EHkTINWKCEXc64p9d6JU+SMbOA05jShs39O7Hq7jsgYA5lDFcT2CGLd1SlHFsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9208
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This commit uses the newly added bt_io_bcast_accept function from
btio.c to implement the defer setup for the BIS sync process.
Now, information from the BIG Info advertising report can be
used when sending the BIG Create Sync command.

Vlad Pruteanu (1):
  bap: Use defer setup when syncing to a BIS source

 profiles/audio/bap.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

-- 
2.34.1

