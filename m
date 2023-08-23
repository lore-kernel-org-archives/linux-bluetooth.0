Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FDCEE49B0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Aug 2023 15:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236860AbjHWPLt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Aug 2023 11:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236854AbjHWPLs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Aug 2023 11:11:48 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2043.outbound.protection.outlook.com [40.107.8.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B69E74
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Aug 2023 08:11:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECJyb3N5+fp7PLCrqnH0HKEl/9XyOZ+7ZWQEcD3Mv677/apJRTi9Q91Y3yknagaqbmjI9rTka2CYfs2sgfUHUlGg8ZM4WlTCgDIVPV8HenPZjS3Uv32gY24sbN6jDPp+JB4RqSBWb+TogYp4peTA7s2EJxJwIICTJRPdRSCX1H5tn9B8y4iJlVfoPTkjZU+hM7uTtJGfc41lnpRk3OlaoRNG1cZnwOuoPt8ZjGm73AsjaViBdhP6FQkQJMOKFU6P39MMsCsNhQbFbnmdcuSdIUD8p+w66nBKIrYJWdgKiFzguOmgcaAttIKk1QhElWVCZJUXoT7AVr3RbZXPnJ/E5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdKd4CNtJs5MuQEywEg9lgreWTwIzrlMNoI4RNR1ge0=;
 b=WDjkc1KOD1Sit5tmE4+p15plX9VG66qC138Fi9ABqSiGJnIFQDYQ3oEK0YRHCwqNsEqg7ptnG+hlhWQiyiSVn3SiKD6nVJ8XNapIrIPFWJtNDDJINdD7OPppYQ0S2mbzoYMz/5UoAvLSKsW5S/34mCXfrDr+saGgaAtMGoBF2aBMsLKfAIPV//mcbei6NelbtlonS0ZAWtKcsu0Xd8o/JJS8NKStg2g1ZPBk+PJ3Py3Whffo5V4F3CS5wM4N56uEvmdMPKParNRFhjT1y216WaO1po+W5O+bB1k0ephzv27Ba+oT5SC/KABI3SYXjUkB2+PxM1Fx/eGrXHPP/dN5ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdKd4CNtJs5MuQEywEg9lgreWTwIzrlMNoI4RNR1ge0=;
 b=S9jALKmjFdo4Ia+F+46gO2/5xLl13KhcoJLYPU2JIKDqxr/GHO87zcdmaAIomDCG8SAi5KgamIYHWb8gMVkQEWbJqeIN1Siebhlx44UBDeS4R1CBO1BAeKOpT9wKatzbMg5wk8w1TO/zjUDgKVuA96WSoNIN4GIQyz/lm1HnQDc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB9190.eurprd04.prod.outlook.com (2603:10a6:20b:44d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 15:11:43 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6678.031; Wed, 23 Aug 2023
 15:11:43 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/1] isotest: Add defer setup support for Broadcast Receiver
Date:   Wed, 23 Aug 2023 18:11:24 +0300
Message-Id: <20230823151125.16100-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0093.eurprd03.prod.outlook.com
 (2603:10a6:208:69::34) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB9190:EE_
X-MS-Office365-Filtering-Correlation-Id: 468dbef6-c64e-4a7b-c620-08dba3eb42bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BmL4QWb5jRLWcM+0hw72/K+j+HjyKc6JVGePUjZrfjPKT8aN6u2K7k7k/3TAF5h6KiRc050zz9KwrA7erb4YIiYtz1oeNsxLQyR+SwI5B7w/dodEy/vOj2WnHJbScA3DjZozM7af3/gJ/EACzJ9gk2g1VZXYGT8p2uxlHGzDIXr6AKFiutPPxM1ZtNDbSsAFVQoZh412eQAsNn5IMb66hzRvomMX1VDR5xUTFJYsjD77oQU4Hl0Ko346a62h/hc0SlRWq3gjCXXI6D+TScSD+pqC/NRe/1QxXerVCA+9cxJj2B4pOuQf47STY6n+mkmx8/upBG+DbQLyKP8pGibe6xSNcl1GbChj2KMSGZpqfwWHrtbl2WUdPBVgO+1dZwFtO/+D6cBCf8wJGmCzBxPhoCJRn2K4GZfa8jKPmKs3cn3m5WtkczmQUqYDwfPEaBh1TvZ4jwbd6AEOmJ67vQr0vldoI6OyiIymcXnHehJv+Q9iFnFcsY6/tK+DbQ45hcXPulv3ND+dxgxlZlOnAYgijcEkp+FOG3yqQ4Bbp7ykB9Q/jGYzMcdDsghSDFtTNcLQwoNIwETulFF0RSIlctvRr6LJ1KPq45yz4vc8RrcNeiC3LZn1di7vWNo0n4vpKUeb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199024)(186009)(1800799009)(2906002)(4744005)(38350700002)(52116002)(6506007)(38100700002)(55236004)(6486002)(83380400001)(5660300002)(44832011)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(316002)(66556008)(66946007)(6512007)(6916009)(66476007)(478600001)(6666004)(36756003)(41300700001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BlPWmiNgUO3oVjn6DBu0DBwNGDYgu5HOvdghM7W8Ev7G4bOp5hy47KZKng8r?=
 =?us-ascii?Q?emRc7hLq8Z9WoDIL9Gl6D0e2jG4ogCmX6SzFktnrWOLO1CIr9iV1a8GhPzcP?=
 =?us-ascii?Q?jrq/Epa9PHHteVKvRY+GeerswnliLYFKBTiO6UPK9pCNEowv4sz1lAxM2m+M?=
 =?us-ascii?Q?q6ka/fw4Ue0rYI7lFUdRclAcYeLkgPRxgXkHrxzEa1kwHiKk3k9Q+AZSBJQv?=
 =?us-ascii?Q?+Lz4Dnt21ujRztlSGLDAobRgRbRdJ/YtqrH5Ysl9rHHAOCYmjFJbOL/o9+br?=
 =?us-ascii?Q?reJx0tgz+LoLB4HswcwVcU9GhXQlTvdEkyuD/u+dK4OPxhq4cJj5HpyQ2kAk?=
 =?us-ascii?Q?akz0OnJ/8U2ySe+h9TcK3MomwQSA4KL24bgrsAAagCkOtg+JR4vBRlmSANo/?=
 =?us-ascii?Q?7eDnkvFXlOhF/0mYKjzZl0v2stV3yM/hV2rhmoBxxPvkOgimTDQWIcY14Uvh?=
 =?us-ascii?Q?RmxYVe55TLlTQcBnSQ70tvtBH1jBqBZyLj0mXI1+hIvPcC6KVdyRaAezByzj?=
 =?us-ascii?Q?PyFEoyW6B36RC3x4ZcJqSv7JOucOh8LYtR1dmDOX/bwjwWWr/ISb7O9QLgSl?=
 =?us-ascii?Q?m9NmgZNRvM5AGAgUWR2hZPn0gY35ekniRNc3PULDS/sUCP4DHm0btA19UtWO?=
 =?us-ascii?Q?mA3MBOmX+H61VIDYoldueukTzAGE73UNtwkNn5W9gLGOQ1MdacvaBJKFGGz5?=
 =?us-ascii?Q?eXHG+aX45NFTl3BvpiyQnL2muLh0ZXMkp84YSsp5HmFeDyBpP+Il64KKzVOi?=
 =?us-ascii?Q?5y0GEKYMA/aTGtNqUdLc35mS1TLjGG0Zz2JDAi/BMM2Fqe15/os/rQ634oIF?=
 =?us-ascii?Q?VPOKAzvnFw4lqVcjyjpSPknolDRQgotedfOMhtIAC9gbAyPwklDusVAe/711?=
 =?us-ascii?Q?uXxaUmwoZYlMd93SYh7fKFGxtvHllIGwCcP9f/EIVVhhS0aUUOYE58EcoM3P?=
 =?us-ascii?Q?MzHAgc+ONGRXOJEkohSaF4FZeT0h4aXISZgYWTbRCTLehl1prMjx5e7Qvfd5?=
 =?us-ascii?Q?Dyc4O3gwUZ3FsCupwyLC/KksnpoOJ9fI9ikVniHomlYMWIJS7QM/vz8miezX?=
 =?us-ascii?Q?8Y0CUfhli9n0KZZW3vMMtHxuIS9oyinAPL5GG9xJV4K/IFXA5bKWGcyhqRf8?=
 =?us-ascii?Q?0K83r3C4jknCww1ESv5si9mrAiXavm8HGBHbkWhyfildA8EmTC4LNVzQ8/rE?=
 =?us-ascii?Q?uNXx8pu0gns+lSaSIsPXsubVyQHr3ax5GAayyIYpwicU1nG5LBwBjQtba5qH?=
 =?us-ascii?Q?vgLgn6xvmfL5ti+wjHzDGe3KBYYNlFdgLOuQJ+NVHMlosVkMdNMyzmVbEPfp?=
 =?us-ascii?Q?Uf6c0X6hlrjhnXnaK4fxYgqVxQf3LYqrDALkAYDkjOY//vmP1o679WNf4cyl?=
 =?us-ascii?Q?CyeznnzY9rYrYMLsyaF/oA5dvAqDGVX62C6ddlSjqmUD1jqlhCRM1gYIuGVC?=
 =?us-ascii?Q?7qdEPMa7+M6Fv24GdZ5jGmG6VGx/sKOrvhFxMTxIoWx/bnjcv/MJd8zou4GZ?=
 =?us-ascii?Q?MFLiUJdHe3fTnKVP+X+6tQRS2cyG9DHtnDPpz+TU0gwdjX0RYrbFmNPlVSxR?=
 =?us-ascii?Q?4CIpmN4vsCMgqf5rqW6X77Ccd3eX6WBTwGcRrERGILZriNY59hZZJhdXtxS7?=
 =?us-ascii?Q?WQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 468dbef6-c64e-4a7b-c620-08dba3eb42bd
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 15:11:43.6893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yzsoo/fXntrD2JKYQLt0E3BsH6CTk0ItHfKDZkvTXYQLWaEA40k5FA67UAYAjnSRJh5lK+TsdNRie3TIuujMpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9190
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds defer setup support for the Broadcast Receiver scenario.

In order to create a Broadcast Receiver with the defer setup option,
the -W command line parameter should be used, as described in
isotest.rst.

Iulia Tanasescu (1):
  isotest: Add defer setup support for Broadcast Receiver

 tools/isotest.c | 122 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 80 insertions(+), 42 deletions(-)


base-commit: 8eb1dee87e019f29b6c8233dfe0f9aef8ee44461
-- 
2.34.1

