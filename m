Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE5CC83F29
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Aug 2023 18:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244202AbjH3SyE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245594AbjH3Pj1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Aug 2023 11:39:27 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2043.outbound.protection.outlook.com [40.107.105.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543CC132
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Aug 2023 08:39:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dw4GM/Kb6YrpIN83ahdrFdI5L3AHFYz7UwqtX2vO2MKPcXD0yXcmxRr2nbsSEstgtkTaBLTliLTvidIfT3zCwozq5k5SFkRoSZ9A6v0IPnWdNyHKZu1++he7K9M9xtyWLPFIXx2hsvUAY5Po/q+JGYlcpMC9RAi+TapYoIyoeXCvuzcktuacG/Q+7td7dmiA6AIMDroGnYcjhlWkNotSD+zcFRs+H5wvt++jFChej5GLYA1HjycMctK69ah6pjhczTQcE3EaBRBqI7mu2IhOkgnj0Mg6pkh8KsMPexwy1ZnXA4kBObuJGQC4dS0ZTPp8V2X531u3170sKJSS3lA2kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRw9DqH4/B278OIMRir43xNqbVjcHzrxoPUwU0L3oGM=;
 b=Z+T7QZD2yMGd/UJcIjQHOu5wH1ShOegpAQ0tJhB1UYI6GbwGEUJttBtHxjafrd22JLW8GQMV4HbKk7qq+e7pMs8rIH+3q7H41tiKBxlld1EO15vw+zMdWh6d7ixWJsv3OsovxueQjR9aG9hoa/Yltf1LiSnkU60mSxAR+ZBhg2yYrpaYJ7ii85lVxWagXZGFXwkJqoXjTiB02nB4JZUZy0O9qptqem+9prnnrvAYA9zVKoDizzL8e6Z5csLEbQKkb7vQH915rs2jBuddrxK63WE3gWgj8HMJftFgJSClk4xSKcCvMq/rVSrDQaeAqGbLOnEn7Th59DUcuWOyWhhguw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRw9DqH4/B278OIMRir43xNqbVjcHzrxoPUwU0L3oGM=;
 b=MfjjmhZF4fO5uBFFenc7h+d8Hul0CKKybuLQv9Yy0N6cwUNXVx0OfsXlsDZDQBxQk1Zv63fCI4b70iILAxRFuWHOyemOb/cn/FP6nWH5QwFl0Q+BSC0HeO3fPg4EFArxk8Av1DKGgf37V6/hyVIjqZfd6U4nujJP7nURsauc8DE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PR3PR04MB7481.eurprd04.prod.outlook.com (2603:10a6:102:87::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 15:39:21 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 15:39:20 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 0/1] Bluetooth: ISO: Fix master BIS cleanup
Date:   Wed, 30 Aug 2023 18:38:39 +0300
Message-Id: <20230830153840.518868-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0091.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::44) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PR3PR04MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: faeeb23f-9779-44b6-14cc-08dba96f473d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MLfpWz9UYr17Lwvf4zg/uQwwWgixYt86N5Pwg24gL1XbOkpbyaSOLYNudeY6LdeWOtC2gXoilsTZfAVYo5guEl3ejr9lED1q1vPZo7IfeQPYKanstqcijtJHDdd4G2NGMPQbWVLjFuDxUYI3vEfc3Jp8IafdUx+oqM+8r5tInWoSU3n1z+oRyTXIRZjhv1nKg9nzxsf/61iCV4T8cw3qkKUVnx1EVuH553hOXxKhOER2nhgmbvlzDtU4V+h2b+nT7hSYd0e/JhIIn4tXrUs9Hiltbhil5ZLfB7MhcfvBvo4a/1EoXNm8sNGql24NXCjkkBDJbB3i4DzyKif9JkEekIElIXRRI+wrWn2cFqy3h8exyeVgAs8fL26nvuI0rtwgmZsfZlAlc1p5LuVlcp+T8qHJBnBiT/cJ/OLsNehCNRpCKkeGJS5NrPW7Kbvvcqa0mMmZRz8H8U/kz+2gR6X1QO0dObOJwBE89S+so8BBnXw0b0BOi9fAWk/JXO1Z/lEn4GrSGnhuW77HV7smbNZK/Ykv149Vjc29NGrqkE8Hlyz+hneYVYEF+mcwnEvScTKPFPZUXls/c3c1ZJ9QmKfOGBHiQ6w+5yKGLKX86x3rrG1NGBXq1C3Pn4M0IHpL/TBE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(136003)(376002)(186009)(1800799009)(451199024)(6486002)(6666004)(6506007)(6512007)(36756003)(86362001)(38100700002)(38350700002)(1076003)(2616005)(4744005)(26005)(2906002)(52116002)(83380400001)(478600001)(8676002)(66946007)(66556008)(4326008)(8936002)(44832011)(41300700001)(5660300002)(66476007)(316002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lPNzHZ8HCkgsLjPdr0m+Kk9lMNNUTt19D6uFoGjXsiLclaG0VOCRJ6Pv84/t?=
 =?us-ascii?Q?7hxFdWG2ZqCnO5XvTm0i9uVafXpqETlai2gT7rC+U78N0AAvC9VVzZ6WQXUj?=
 =?us-ascii?Q?LWF6wEhkF6rwv9hAQQH0hrXU+y0AE1BDFRUXW6rG4unDu2pgBY6E+TynkPc4?=
 =?us-ascii?Q?Ot0LGcQCbnDmLZEYO0+0RLgCLiszyJ5nA6lf5zuJ5vC00qjyTOqqSUWg15ia?=
 =?us-ascii?Q?qp27LAsZltcKgsjWNTJHdei/G1uiJMVlWhYdvBsHEA3+cMCvBN/DiRsCl27D?=
 =?us-ascii?Q?dWu2coicPI3ynwXXv5k4DhqvvlIFd24VlVUhOl8zM3K2shmrl/73M+vRf8vt?=
 =?us-ascii?Q?zlMpwBuqwH8FxaI10cnxQF4OdrRlGNmEIQKa+H4PqzFAD3w2hPmzFKClx0ro?=
 =?us-ascii?Q?QOV0s/ag28LA2JBeHyTHAoeKuV7nWi+6WZtP3aKCYENUwjYir50UAegV/Mlp?=
 =?us-ascii?Q?PDxuO53nIK5VT2Aiw3e9SU7vgg5SyVRnZnxhES+JnY4nFZdXGZ6oerAQ7+8M?=
 =?us-ascii?Q?fEtbmAplPJdsr1vD5iVp/PkaqyD4aI9DArIGglEG1T0/NBWa0WSmktiKrSkA?=
 =?us-ascii?Q?v/yt6dPlzdWlNwYCuIjsWZ6Wr4AOrV+dr9ezCAHICjZ5IRlfAzVWUVN9Cx7j?=
 =?us-ascii?Q?J0DLxL+TzMM+Uy48rDbwR8QRHZb59a4Zy+0d7DHrSLOm1jq7S7nFXQQuNTOg?=
 =?us-ascii?Q?6vVCo4SQVPfUK4KrMmYRtmoAjctpkedK5L4kf5hKT4LQx2T0qj7EcxevIK9s?=
 =?us-ascii?Q?gNZxLNdt4zIombF+CXBOTy6l0ALuRt3Ijh2rZsjpUir4uNcl7vQkmqDFdf4Y?=
 =?us-ascii?Q?7q4OM0qjZAfHeREaTYbMm+MgNzPTw7cTQvFgjDoT18qBxbLHVCigzekSJ1gz?=
 =?us-ascii?Q?vbCe/h7tYrEol4Trsm3hdYFyI0vOxfzd12+VSRqs30Ib1NvVs+G7d+GIwxa+?=
 =?us-ascii?Q?eDqvIwenLBibHP9FWMDM5SPsg3WtDASarcgkFWL/qgY5RUvyRxH5NNoBaYvH?=
 =?us-ascii?Q?2Wzg3SeQjtHqVY8/VaPqeEGpPLnHoqw1Td08BNmRz4SkkruCqV+2s2p7qTiS?=
 =?us-ascii?Q?RS/DZveHezExJrhy7TPefND+YWp/42fNMVOO9zm5qtJq6Zg6G+atri53WrPB?=
 =?us-ascii?Q?kA4i6SWgv0opsaKyOL434SUGgJkgjdUdsrtyzRBMI2WdtH3i/c8l04BHc8zV?=
 =?us-ascii?Q?KRj3GGdyRGQEbWVLJBlTSC9j5xsHJdG2xWg2Bt1ZwrcGEtaLRZosgomjRsrb?=
 =?us-ascii?Q?MTq/sJdIE3ETsXlI4n5NiNM2M8/ZLeJWxRPEXK4zUkFImos8c2nHFL6vRCQp?=
 =?us-ascii?Q?QPSnQ/4hhuZAjfGlXMQpgekrdg5SFhTw/iCtZ0VmMVNR5ikn05a0jBfTJUan?=
 =?us-ascii?Q?XdvsBIlhUbjUYttDYpXNJ4WbkzwMZMYV/v+k8Ocq0dAYz/DOmgEauiAkmDPc?=
 =?us-ascii?Q?zVzSFCp7J7GvV0FiCDhnT9ASD5Kj2kwsSHGNnDUPPaWTxfwTvFEf8E589xlq?=
 =?us-ascii?Q?/hdP6QrsTkx8BQoVCcECPEULVh9UksH6nlqhEqTJvGAovc2NVzvdAg4Ktcxa?=
 =?us-ascii?Q?HuqfK0d+N5CWfcz29/gZ6yv7iHDRQXz3CvyXB1OJDXXvPoIher4YT982/Dmg?=
 =?us-ascii?Q?+g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faeeb23f-9779-44b6-14cc-08dba96f473d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 15:39:20.5897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dfoHd3dZ4slDjIBJjChT/1hjoqE6Y2KDM5r8lFcY94+aBvbs2XO89zd2BmIQpTrfxf43MTV1n/bMTlt4msb9uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7481
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes the master BIS cleanup procedure - as opposed to CIS cleanup,
no HCI disconnect command should be issued. A master BIS should only be
terminated by disabling periodic and extended advertising, and terminating
the BIG.

Iulia Tanasescu (1):
  Bluetooth: ISO: Fix master BIS cleanup

 include/net/bluetooth/hci_sync.h |  2 ++
 net/bluetooth/hci_conn.c         |  1 +
 net/bluetooth/hci_sync.c         | 29 ++++++++++++++---------------
 3 files changed, 17 insertions(+), 15 deletions(-)


base-commit: 75d095daab9fa1d299fa79ebc7ab5dfbead877ca
-- 
2.34.1

