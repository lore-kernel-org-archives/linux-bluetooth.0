Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2674CDB47E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Oct 2023 14:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbjJROhg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Oct 2023 10:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjJROhZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Oct 2023 10:37:25 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2043.outbound.protection.outlook.com [40.107.6.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A7CD5A
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Oct 2023 07:36:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRq5BYy6+IViUJuEDOKpl/rDqZ1iRORZDGMg4WjBhJqqy1p+HqcHurA7puirk36eJctJ66fcYdS4uG031UhMYIZLGEBWJ0MW1iieJwq/Ot5vC75L+hkOLRnoQK+fWAFTe+TuS015rKXeohhHB5Tiq9BrMh/WNzIoI3LMWPTDGbEU42z3zVe/qn6uxVIJ0N7tYUtGWF4IepnztclgacPcDBYft/IG25bgnwIfYqZ6nMk87OnVAYwTLFOcD5W3x00BnndYFLf8YsB/DZK2+Q85uYa15oHfx8Ltt4TimX31aa10CWKnaSVcn3qYQDkqUqXRAQZX4e/j+kAaRg9l1GCK5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XM36liG4auPAyIHl1ad+B1U+IXu8L5C7gbNuocwFKbc=;
 b=IJc7R8+pKx4MnT2yDEWBCuccYIqBxbhHpXslqgRRi8ZT7cRqimtaKQcgvPbbzKLfrkT5qIiAvjI13u6/PZctInai7dzDbJ5dIiGd84RuYYopbuqDvS8gVc3zHSjFdl6DOTnQUcnF4nhLyryk6QeDcXuB5up+i7gCLFx/Nqkcbauw6FiGWhp6CAe4xfiLNsiPsvnuBdfmLMQVWWTn48qpkGCCL/BZsu5xNa48lb1D9Y/lS08pOLDeEG5FoDOtCtWXDH6B/J7CoXLw6/gabby3WMunY00OQwXktw/WrTzUbZyCEC/TdsTxrGLlDl7D3IhKexfdTgJN15KFI1Q8DtGXIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XM36liG4auPAyIHl1ad+B1U+IXu8L5C7gbNuocwFKbc=;
 b=M+3RIExch5oo1TVp4xzQmLpZkFrBuWHqTLUJhU/B79QQGdKa3hPj1VtEgdpjv1t8cpoRrFq0EcMP/w9dk3ABJmSdduvcomvTgyFejWzDqlp05YaNZuha7V0vePds3IjBXZC++XfoARbAZdT4GUTWCN1Ssd6sKa5SwowkeNm2a2Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DBAPR04MB7270.eurprd04.prod.outlook.com (2603:10a6:10:1af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.7; Wed, 18 Oct
 2023 14:36:12 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 14:36:12 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/1] iso-tester: Add test for bcast receiver PA bind
Date:   Wed, 18 Oct 2023 17:36:03 +0300
Message-Id: <20231018143604.3484-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0096.eurprd04.prod.outlook.com
 (2603:10a6:803:64::31) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DBAPR04MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: 456d34bd-257e-45a2-4e36-08dbcfe7938c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JSSfgbm3/n2tr14VLCGrSYZHN8v2IPW+Y0N+UcV4vwJVW9zawTEqRvJMPHcqMqaGU3Bak1lN483fiBIJNheZbDB/46Hm0K4fDD9hp9ks7rtJsTShhL5RuFtPp3vWPFvii3mhZ+HU3BrOqy6ogNE/7yVXElWDrId+b67wa0ZZKp3HyyioDQTVdMGTJu/Ydg/sKN0cDviKdIypUmtZwC+3T8iDuuveLL7Mj60fJ17t/1qCv0dRmT8xgkg4utcfEKNgUnC1otvcUgZ/cZj3be405vDbVRrrMoTWLKvPzyhIIb9SZCSfT0c2C2Vi1gBdUxphsn1ak7wYlHjLgCF2bByNlfJv2FOS2YlsoJOLwNRvEgyNemO2YHRU52Mp99qriBVjxJHmhh4FR4BR/mff7MI2xE0GT1ckkq6BKc4VR4gbge1Bev2CufYi9Doz/DnFjtIYNXLtoLRCBQA8FygitEX0bfWd360kGtLiopLjthC1UqN7T9rvLKZFt1nIGRG6KWi2HderjWspsSPR3b+rUQw6VclWplKbR78OejxLkrdmLrxznqFoA5mxx6gg5UWDFeeg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2906002)(4744005)(44832011)(5660300002)(36756003)(8936002)(86362001)(8676002)(4326008)(83380400001)(38100700002)(26005)(1076003)(2616005)(6506007)(6666004)(316002)(478600001)(6916009)(6512007)(6486002)(66476007)(41300700001)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oGBkbrysxNsLV+ypEA46HUhuADyAGS/Q3viw28LzYvGeA2EYLM+kICuPishH?=
 =?us-ascii?Q?Mp3HRz2O0mu3puFk1gWg63Kc8VTi0J5xGS4livvoJLHpSvM4dgZUxlRQvR19?=
 =?us-ascii?Q?vtnQgyje4C06QrdQTdEXV+VtIEomi6jgrnhlRIS9Wd0cT/1Da2rxzRnnpAGh?=
 =?us-ascii?Q?HZbcWn/PMG+pZ+Hs6QkyKv6hqrgnsfN8KTCSbESzzBkOpmsqobsGJgX3w01h?=
 =?us-ascii?Q?JFLdD5PGzD65hQWtKwY4BQmRF/f/c8PxhBgTT6vlVsVv3jxloNJA1UShsuae?=
 =?us-ascii?Q?IUocfaYMqw5usS+SLFcqCuu14LpnGo3N3jpdXipfHCLRJEqs89aWtsTl7kZg?=
 =?us-ascii?Q?lrpRn24T/x3N5nlzPtDqHVxMEyYRnP+XpKGAN5hvP2cLNpy72OAf220AhK4P?=
 =?us-ascii?Q?yF61/E//jgVQpJKZjkX1cWxGpzuqMcJj27iugqQw/kyUmD3smqCLZpzyS1MK?=
 =?us-ascii?Q?4O2wxeBH3AKqdBbY0G/xYQI8sCTRW0iPgAwFq9ix6bsITv9jzxSAz+m+ObiA?=
 =?us-ascii?Q?SVUCZDUCQdcnRmhyRKtg36tJIe7MyM6UOiV/iPwOc6jF5GlKqEMIM95qbN8s?=
 =?us-ascii?Q?FlWEWH6RL/Hh1g6qVlWV9pwxdbXKN7r7rTdHxDG9jjSqmuBSmjAHFOab0sp3?=
 =?us-ascii?Q?Wip+FUALWZGYGNpjjnPnryk743QysHFDQ1XAPHOLngKyirj9CgpxMR0WZvHj?=
 =?us-ascii?Q?gESJs08b9L0yBvCZo/eh3zeIZ/BqUz/eKyZ1omDSger3q/h+Ryoqx86cxfJs?=
 =?us-ascii?Q?lRx8N44vjjf57/AIxxvSESZ3x32ODkjyGoW6zguPK8H1w/8/aFjpSdRG94YK?=
 =?us-ascii?Q?rCqbZ6vBdszFBLZ6Iys1HMwhyONdVT5HLBh0e9s/hjUDp/zcApRLwN1+wCM3?=
 =?us-ascii?Q?Ek6P89qAC8zkhwojr22EEgFyxZAelK3Syxg8QDj560lm6nUGNQvXbw73/oiW?=
 =?us-ascii?Q?PYqvl+VgpSVeHhoUyIx1bLrvY8yYGT1UQQuG4GaI+86oKmQ6Xx1/b9ZvDr/C?=
 =?us-ascii?Q?8VSMzKS4Q3nYP7TgIiWnHdFEt34Ya5ZmtoIcyU39+cgnwSq/KPICX8Oru5vg?=
 =?us-ascii?Q?jNTMbjpeaEclmGZ4gp6ZSvUN83/VdE2aWwBCwlSPnmqkuouKvDUI9Zylx/3K?=
 =?us-ascii?Q?dT55QSjvam9rXJuBtf29gPgAMYsZH8F4PJQY1HxTkb+TDstbBvPmJT+hWru9?=
 =?us-ascii?Q?Oqe/bHvvWUybo/vc4iIEhsv9t6sHUgC1UQE9ngKd/V+LEfef0sS6eGG9Raih?=
 =?us-ascii?Q?+AsXFwhoBycg7qnknlALc5zA+fEDLDDg6ilQQ1MBXGq3f57/tlOJ0trhGXP/?=
 =?us-ascii?Q?y32B+NWCWJVcd0WqWLitX4uNZtM5CcKlS9jYaAd6WxiUyRHPs9+ZhhB5vOFi?=
 =?us-ascii?Q?jk0ekjo3h779c1EwfTvpW/2QUAOc6uyxt8WIi9bJM/p8LH+igTefuRmTD1Hd?=
 =?us-ascii?Q?Rg764D0atlbhb1RR9wwlEqPgn8IM/V62oPjdsW7jPG644bBdQu6uUDCBUIeG?=
 =?us-ascii?Q?VzhgWPGpQQK8SOnelAMhRuv7s4OJK0kZ6WP/+ZFLWhZeHmXHwxBXIzrBHnzM?=
 =?us-ascii?Q?p7+MNTGiBLT7Pb5d6tCCEc4cLkV8EDZLhmnn2r2wk+SxuWr3zlJoH5/wTTf6?=
 =?us-ascii?Q?RQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 456d34bd-257e-45a2-4e36-08dbcfe7938c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 14:36:12.3812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ncpaKevOUM/hcUbRqbRhAjhYV4FiSdNJ9M5RelnVIgN9LCR/vstpnS3iBrt8C6H2wHtRV/XZSxoS4BpAA7Ai5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7270
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds a test for binding a Broadcast Receiver to a number of
BISes after PA sync has been established.

This test depends on the kernel update introduced by
[PATCH v2 0/1] Bluetooth: ISO: Allow binding a PA sync socket.

Iulia Tanasescu (1):
  iso-tester: Add test for bcast receiver PA bind

 tools/iso-tester.c | 70 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 51 insertions(+), 19 deletions(-)


base-commit: 0c757e8eeef69ff2b1eefa59e590f171c9fe1c88
-- 
2.39.2

