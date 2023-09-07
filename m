Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDF7EC873A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Sep 2023 15:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjIGPmK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Sep 2023 11:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242512AbjIGPYt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Sep 2023 11:24:49 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2073.outbound.protection.outlook.com [40.107.7.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7FB1BEC
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Sep 2023 08:24:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUaKjCj1GXIzvVTF9L8TmDyaJ2rdpU76HCUWQ9RbpoB2gIUMf10JEOQsqzaV0GFrAdivjMrD9SflFCdiwQB57qTfj5uwpivgA0fjuwwUNFmpakemqcxWrz+lqXgQ7FJZZjCw5NHQmOe6e8eb0geFo/HnUoTV88+33oXd2/8dZe5vr/QErysuRPUOZWvqXg3qkO9TgjKFnfYdFHi9H9c8Ff2puzBkT4y3YCShXwSOO2LtuiGnPfdDDbbJ2kF1hiNvO5Q8xwiSDL+FmbhS5PdNgErzsH1MFv0pg11GrXvhCSa0O3ZRTmgPriEasA8m9tvEabV14GIlQ5llMSykfKlzzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPlPLnuhodJ7SSmRLPX4GhZTAsLs8Njj9p3PUrxeqNk=;
 b=IlhqJpRrnMLj8Oaw/qzDPEuTIfE6PLDZtBhvJaHALbtgK7lccSo+sxLZ9Uhmsow5knVFw5PeZABGLfQfU80ZV1jebYaHvXL6+IoQOOS67xPTy+0xaxCaLp+xAxf86Ir++lNteLRFDb0kfz9FaRnLdE5sTphxfEGxtDUwUQONRHqVbbjd/bDJ90B1hBQ89caVRQMQ7JKIMPF48GcAsEBUy/MkNuZa4fptlFdruTC22i9DS5+qj/X4rEdKC8e6HMfssArpweeMZx7dzG3jYaJAfQxidSJB5gn7aR/In3YHcitDIJhg2RhU0NcTJTZb72asC8/RxtWXmLLZoid3PPZVzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPlPLnuhodJ7SSmRLPX4GhZTAsLs8Njj9p3PUrxeqNk=;
 b=pHvHeam7yHMMY4tT2DRqvmYDPZrxWdWcAyfCm4qqXWsLFT4a1/ADtf7IdZNXOij2Y4tjuQ8Z807mHOJLed7WTimUKbq3/rdBhiKqAs226SMyUYOMZagA/K5FjJUJEBdRdsetu+x+4jhp2pU2U3XqQwOIP5v3NI1jiB3lKIPGQ74=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by GVXPR04MB9759.eurprd04.prod.outlook.com (2603:10a6:150:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Thu, 7 Sep
 2023 15:12:51 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 15:12:51 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/3] shared/bass: Add Set Broadcast_Code opcode handler
Date:   Thu,  7 Sep 2023 18:12:26 +0300
Message-Id: <20230907151229.7306-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0195.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::32) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|GVXPR04MB9759:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c1e3813-f6d6-4bb3-9a7f-08dbafb4e758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o8xuY/X7+HbCJGNYsWn05dLs++4AOi8oYrwrduI7KhSpigvz1pprwANn7yFAWtqWsF3LBsiGz3IZMW59f2kVgc6/q/K133j4Exd7h3OBg15EwfDxxbuVj0uapaMsROR3OS/W8XXNBSNKnYR9zP/IjITady6Q8d7fI3iACzm5xk+4RE7XSWKH4FXFVdykk5k125e0j4sBt05iHFVOfUZ8RU5XdIxRVAFDmxyTrtzoVGt+lcYKKdVwsDjZTAZbvr/bge+MVjm7XHPZGrAQhVI4flF9PDjYm33WULU3tGAR1rd+Ih0RmONenceiVwaJ03wOvOtsRMlgorwXeVYCucbVgr3NDJbID1uyPAx8KxxXjXImc7PcwFsEkXG5hDW2F3pjeio7v+yi6HoL0YC/SPQ4Vs0iSIYGxDbRKU0FDTpxNNagZZh74AQpPsSC19VtYZgOGtVC987po+uglLKswoF90TCDo58TimuO4K7R/tFC6fgnBdKSEwLWG7FMSvDICNIEVrOOiNeuZb9cdj0Omh85nvq+2uXiL7N78+ArtP4eK7fddQDjukVEdXsZ2fk5L/yjDkqSDrnoWqDPmiwMaCo8iU/tgEkHMUEj0vJK9fyLJc8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(346002)(366004)(376002)(1800799009)(186009)(451199024)(4744005)(2906002)(36756003)(38100700002)(38350700002)(86362001)(55236004)(52116002)(1076003)(4326008)(8676002)(8936002)(6666004)(66476007)(44832011)(26005)(5660300002)(316002)(41300700001)(66946007)(66556008)(6916009)(6512007)(6506007)(2616005)(6486002)(83380400001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XFv0QhqWTVmM+q2HBN/xBPDU7oUa0eNOUfGoF22niiyHE23RhMMowL8uf0lX?=
 =?us-ascii?Q?ypSiLMWTdc7mYlZH3LQrC3mvF6+mqNGVdbHp1H/gxsA7anAODmzfKzscDR6Y?=
 =?us-ascii?Q?fR2SsmREkzsMZPg2v1KXUVU1x9Nkwe+E1XIu6ALHbc/djpofMyRh7EOQQ7vJ?=
 =?us-ascii?Q?Igyr3S/Z8HYU27MCayPZZpJ0yb2I4E1OSF57iSrGxk7F/cdJs1m7lnndKwos?=
 =?us-ascii?Q?8BlyEK5dL7+NIB5N5MSEfQLVV0MNbp6NXjLxikjavQbiYtYmXZ4FejwM4VvC?=
 =?us-ascii?Q?dZ52qfRkadAzk0wkg0CyCCEzaUehWdvgzeQbpUyb739PzGtBhDQy7Yljb+qU?=
 =?us-ascii?Q?AlvbzHTgVDzf6kHfZNuaGM54CTpCzfVa+UIloSyk+PWQqXUIeyW6Wfe8Mt3T?=
 =?us-ascii?Q?xUaQKuzJPfX8wYrsveqWg8LFMPg/CyjVQghSwQN4a3uPr2gRYDwqvT5PTVHw?=
 =?us-ascii?Q?IkcRy/PBz06TF1MTDHDXdnX0BZA9Zx2dTlV+gsWCDj/ZR8NwEXhhgdUUUVoC?=
 =?us-ascii?Q?mgkT6KpG+yZ7N3LnSyFiHlr6w+nm224AeG4o2KSMtqO+kpmCNiPYwGePS3j4?=
 =?us-ascii?Q?SU+DHxNP4T10LSKovWnllZuF9HXcZ6KjCn9Nu0YLppgP/A+olt2E2hpRqm9b?=
 =?us-ascii?Q?FUwCuX4jbpGbnhcOlRv9WUQ2LYR0Whq7jdZVrno7sEMM8nao2NnkLzuya7E4?=
 =?us-ascii?Q?5mm5drXWwsPWz24+nBai5v/a1d6wDfw8Gl9h//apxXSHE8VYxnn4v1nt/J1D?=
 =?us-ascii?Q?1ZroBSEpgvL6lpC9+6BYEEktevIUzyjmdraOrQur30LyaDLqZfZwDzog/+vH?=
 =?us-ascii?Q?MhiNc9qyZRAIrS3cRmw4WxGyiFPjjVWs0BpmAIwhm/YqS2ZGFyBy5RAZ4inb?=
 =?us-ascii?Q?f946ktnjawTLYTlejuBNsHz+Dw4QRiBl8v346ijHv0FxNIUHdAmIydhT3wWl?=
 =?us-ascii?Q?CQ5jXZZKIFDnJvQ2TS/Rv2q6D/VEkE8VDc5sP5Bwp4iLEPCs7Z4LfnBxlAm3?=
 =?us-ascii?Q?Y7KDLWvO6gH3f1daNTQ2Web0Wjn8+HX9mK16Pbw2ahiRmWJG8Vy2S7GvkKEq?=
 =?us-ascii?Q?2e3sF/eNtrwjlBxz8KPEkhGcEt9qKzRRF3oU6QZLMxo7vEkdosdMGKF1ORxt?=
 =?us-ascii?Q?TYmRshtu/jlo8vNC4qqahMN7CPiT85MtQEKDeGDDajRmr04CIV0HYjZtH27F?=
 =?us-ascii?Q?QXwE2WvQlrNjysb9yDdo60PeH1R0D68QzKjjB+IuNzfsgvz1JbhL3lxF389d?=
 =?us-ascii?Q?//6cnayajTaRP18HCitWNMr/B/9iDi3y0WR0AkxIRCQEP1m6q1EpgKHCOcmJ?=
 =?us-ascii?Q?r/Y6byDM7pJXZElN6vw0JDLsoRAafvmGcXqRua1/CRau9QmSkdwXQ9Cc9iyJ?=
 =?us-ascii?Q?nB/iZNE8nGLboYs0KQNUAUFomyXoTsrOtBDjbCXENpIjuM8JYZvRONGG0/UO?=
 =?us-ascii?Q?bDnvVMTw1expWGcJue0/ciEJoUDuS/bPHCmrYwoiK8SG6I/2DwByRFVjp+MK?=
 =?us-ascii?Q?mYI2aCaMXhrDOcfMDrF8ddK2BDe2fetA3P77lwuYN2RZTiI0zdg1qTsCqVOe?=
 =?us-ascii?Q?0N6DtsEwsim/+fdbMUGHPfOEbC/GBZFf+85zJ6je5wqIX53Ci7YdbZLw5fEa?=
 =?us-ascii?Q?dw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c1e3813-f6d6-4bb3-9a7f-08dbafb4e758
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 15:12:51.4693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8v1aJZHBo/h8U5YOValNjIifFWXP9RLV/nmT3wj7/Bb+hhUy05Ik8Ff2Rw7FxhAAkKvzdJ7flWxPYXcsanTfZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9759
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds the Set Broadcast_Code opcode handler, enabling a BASS Server
to sync to an encrypted BIG.

The BASS Server will detect if the Source is advertising an encrypted BIG
by looking at the QoS of the PA sync socket, after PA sync has been
established and a first BIGInfo report has been received.

If the BIG is encrypted, it will wait for the Client to provide
the correct Broadcast Code, before issuing the BIG Create Sync
command.

Iulia Tanasescu (3):
  btio: Add support for accepting BIS after defer setup
  monitor: Fix ATT decoding issue
  shared/bass: Add Set Broadcast_Code opcode handler

 btio/btio.c       |  31 +++++++++
 btio/btio.h       |   4 ++
 monitor/packet.c  |   7 +-
 src/shared/bass.c | 159 +++++++++++++++++++++++++++++++++++++++++++---
 src/shared/bass.h |   1 +
 5 files changed, 191 insertions(+), 11 deletions(-)


base-commit: dc13da09d78b3df761d27ee8f4bf7089afe37788
-- 
2.34.1

