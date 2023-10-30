Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94388C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Oct 2023 15:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbjJ3Pni (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Oct 2023 11:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbjJ3Pnh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Oct 2023 11:43:37 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70745CC
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Oct 2023 08:43:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHDXsINYN3E16zobee3UcGmLIMeDKvBkfncY2NO5ddEhmDf6ee+fzAnQwO/cRLBcKPwQTWf1ISwDGiSdEcYno23EhtX6ioZ/gk9BGl7rX44CS3YNfQs4FtMT3uMVQDUUyaEhSL+l+AQjjmOuC+ydVdLeBo8/o49RCJRwwAkzG0uIXXKA6gKNzc7AyLGAbTjlNMbauASUYtaNbQF28QeBH2nEqx70+l0tgCI9kEqnZF0fvMBBwbL92H7ZKJiYFLTco5zdD7IBgyqwmDKc0GGRIJ7KeiR8Z6ymSaGU83PauxXCT7HOtFd6X85KGNb6wSLnWjb3EEJNSBU1RucxyYwMDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSv5ugpB+A0q7m46m3lazOTzUC9S5m8uM+xFQvxDUjU=;
 b=VKR5ATcpyeg42Eb/oUD0y5mXQ0srilXH8W5d6T2gqcAd5iMWjXNTGoeUVqmW92TyZdjOxNn3BydlqzO4HS6WJbdx0gze1MlVCdINoyYcIYN+xOzmYhao0Erw3uK7V4UBRhXkjypL314q7a7AfHp2tIBJdOsUQU5IjoRJ00FjDayz6gFkVEVySs6RCbwtcBKOtKy6o0VoAnCRPeIip+BV1VjueJjTjkeaVIon9Xt9rskdQf2nbXBt9+xCRdv2hQw7fLddIW6zB8OE6URWd9LhF80OiI6yidfirD7d4uoZS9Eg/elBmY5vucgzebW/Gr+HnphwcWjOYakA8xTABTmN1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSv5ugpB+A0q7m46m3lazOTzUC9S5m8uM+xFQvxDUjU=;
 b=GEpDOpHKv681pItlLMBVF8Vi0Gz7nbyz3+rAoZog23yWot6M6z2nVIT1Y3ffEchTo3gcllkk7KdKov+4YgTuFn4k/xCFhcE8Gp+ud8GTOIG7bGJTZ4IMXKaLjOqivjdk26fUHNMV/t9fH1SsKGCBlMjW/bRRZDlTGG5IlUPRw60=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VE1PR04MB7342.eurprd04.prod.outlook.com (2603:10a6:800:1a0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Mon, 30 Oct
 2023 15:43:28 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::9294:43e2:390:2b6d]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::9294:43e2:390:2b6d%4]) with mapi id 15.20.6954.014; Mon, 30 Oct 2023
 15:43:28 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 0/1] Bluetooth: ISO: Reassociate a socket with an active BIS
Date:   Mon, 30 Oct 2023 17:43:17 +0200
Message-Id: <20231030154318.4339-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0502CA0020.eurprd05.prod.outlook.com
 (2603:10a6:803:1::33) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VE1PR04MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: fc10eae1-37d4-4b5f-c6c1-08dbd95ef64e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h4cts3t3HSwibzK6dZpEaL828UkS1FifVW7oKCADnKXiR54B6EOpDWItbfxCGioUFa1yenAlfYojiiq3KXCyGg+/Fv/QPsw6t6A5Wxq6Zljz5AEGlfzkMnUyp7MyBf2CbNQ3pHMkOhdnwki1btC9B99ysHSGnnQdVmN38td2qAsA0IB8mMQCs+JIUf/pDFpNYx42vTKGfalOUDFO2OeeijW2JhBrMxDD+3taIzTAQCTpErkrPEV3hsjrYN/oKzRSgTI1P1VcHbWbhK0hO+n+2n3SMaHslhkkrquHX6xwWAlShf9n5clI+VAkgIZ6H23SYm7eI5fHDymiMIf8RehPKQlpeP9Xv1Vuegt/XdZU/oXNCongmwx6px2qxGGI0cmF5UayHzZd1FVMnEOSbGTbPSFi1cwC/O/cov5MFUDmiYLeVf2caeKAkqJ1c4mp4sr79tljhL09TXnnjZqUfhfVJHww1eSxQ0jnV0gnhpGuS6K5jR/2R5dACRKWAlUB3Lei+bXPrsd/tP5CTcIX8V4TbR2HGpixQYLbb1q+lGLMxc0SAZerLPrmYIbM1h1tVVaq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(136003)(346002)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(478600001)(2906002)(38100700002)(8936002)(41300700001)(36756003)(4326008)(8676002)(44832011)(5660300002)(6916009)(66476007)(66556008)(6486002)(316002)(2616005)(86362001)(6666004)(6512007)(66946007)(1076003)(26005)(83380400001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?luOcDyegAyHNmewinrWQgJdYjCCO9U4hNV7FjGvx9E00Agtnc4WQ0XBgtio4?=
 =?us-ascii?Q?qn7x6PcnBrRki+xi8hqG5oy0VUgsmiy4saUvf2FHVVIbKMu88gZiB1FOw80y?=
 =?us-ascii?Q?RD8rVgDkQIqiIdJpTKGpO6NGZtlPqg+kAn3N5MxDDl9grfK7HoeoWfDCOdWv?=
 =?us-ascii?Q?qzTE7C35CCLE4zrb+qrGs1pFUunjYy0/TimByVcdlj+YgDmnoY2TpVTTSs24?=
 =?us-ascii?Q?A6ImvAq7xoZq8vcn2vGkwufSBbXTUuOTgQhrzLLGKL2rmFtjaOFxcQkz4FVo?=
 =?us-ascii?Q?BW5lOH+sTVaiHA032dOur115DkfHsLK+kcJFcN68MfjkfErh3S9V+NT5NO+8?=
 =?us-ascii?Q?v//RdOB5TzCuoUFsCRoQVEQukSFIILTqbzdP+0QIjM7vmK4vFsHoNBABgf1Q?=
 =?us-ascii?Q?hRS/K4H3a7lKuYwov3El8rwT8UBRGYVzXjJiHXVaTN7h6itHl1HXlKG1pnmH?=
 =?us-ascii?Q?ntVdLYqT+0y4umbjZmS3U7fYUo88pdU2GKaCaGT0nVdd/+yDgv+JXHxBHm6d?=
 =?us-ascii?Q?83OEwlnJoYa5q/d1t8NMvvjWTruc/hQicOEX7CyrYMBQezFE71F5v5TnDmfw?=
 =?us-ascii?Q?j2CxXBJw02BQiKaoL/RCxEu3aM1Y5RDlONvu88k61cpf/ltvqz/slncIf9jn?=
 =?us-ascii?Q?NsbMmxCwntOITCErxEgceG7d+uG+8e8YAK27uaIGGLwUDcKvnd95yuF/aEOZ?=
 =?us-ascii?Q?DNRONWWs2IRTr3u1HN+3nJUf4/wzLU42YQn8YsvpWmUT+OEKJoiuhY/Grl5o?=
 =?us-ascii?Q?/khWVFUXx1MS2SiU7EwKohm3vBiQ2J+8NHmu9yYPrDP/kGjQZ8tnxDXk1Kr7?=
 =?us-ascii?Q?SEh9QMfXSMX8hqCUZoirWApcokpnlb7TjpSQNcGCTpKMIEfEM7d7gMycA7pG?=
 =?us-ascii?Q?utLVEQPG7Nts2uXU5HLaVjM2MoXkgMc78FxzccsSsTMST9OqezTlQOcoEIub?=
 =?us-ascii?Q?FYiBw6e+lQlytqAG3ScPdhBlemXs3L9BG/X+xWixwgis5A7nBDHbObzZVqRt?=
 =?us-ascii?Q?4dfanVvzTS0SmGkEuNBYmZtMtGOJhlviG7eVs7fICyh1I9U/PvG2XKcrlK/D?=
 =?us-ascii?Q?jZahpEGgCg54IRyqutaomiPO2eBt9CBfJj835zuHkIBWkjzCZBzokdsfPPQ6?=
 =?us-ascii?Q?11efBNqYpRdeBup0O6g9pCQU67EG2eI2Rjp+2+FPGIKRk3LamC7wKXgfDpym?=
 =?us-ascii?Q?JCNk3pfivYg50K8pp1UwjQclDyNF85lwSTYfiFGIOC5haAJjg+U6ciewAOFp?=
 =?us-ascii?Q?PCUTQPyZmWxrAAQa9BV/iUlgandzvVb0BFHgH8E12bYc+C4xDic1Wj4H1Xj9?=
 =?us-ascii?Q?goQ2uPVbWZEqx1Dg+sDF93/aVK1wpzPX2sGs13pAU9dy6XcQsNi1OYk6EDZ+?=
 =?us-ascii?Q?VQho0nwURt5iv4gzNIxihzGJfR7WFba3UTGajjIuu2TA2tf9lVgS6O6ydtgI?=
 =?us-ascii?Q?gRfUJP1PjsPMXXYkBoIYvYbrhyHM5HGi9ggROQAcMRXYIZX88fS691UHEaLb?=
 =?us-ascii?Q?5yRemmywkUAjDZYJzfKm/SlHj+qNqd3hkE73wv4od7+2cBeRu1T5FPqQGqIV?=
 =?us-ascii?Q?oVD53Fff5Mcsy4LcOqiu1N+bEm95xG5lR+3U4o8E2tbL+Zy66p4rmWNlGMUF?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc10eae1-37d4-4b5f-c6c1-08dbd95ef64e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 15:43:28.6573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdRLYvnUIEJUjhocT4AoTivuNAdbCFweDD+wfd4IVFxUxa0mhoaaZzjUoFfwF8kD59im/kQulLKEc8+ebtP6iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7342
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch implements a kernel improvement, to be able to reopen a BIS
socket from userspace and reassociate it with an active BIS connection.

This is useful for a Broadcast Source with multiple BISes - since a BIS
cannot be terminated independently from other BISes in the BIG, all BIS
hcons should be linked and kept alive as long as the BIG is active.

If multiple BIS sockets are opened for a BIG handle, and only part of
them are closed at some point, the associated hcons will be marked as
open. If new sockets will later be opened for the same BIG, they will
be reassociated with the open BIS hcons.

All BIS hcons will be cleaned up and the BIG will be terminated when the
last BIS socket is closed from userspace.

Iulia Tanasescu (1):
  Bluetooth: ISO: Reassociate a socket with an active BIS

 include/net/bluetooth/hci_core.h | 24 +++++++++++++
 net/bluetooth/hci_conn.c         | 27 ++++++++++++++
 net/bluetooth/iso.c              | 60 ++++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+)


base-commit: 0783375f2c56ca17719d5ec670e498dc661ea5c3
-- 
2.39.2

