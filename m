Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7419C04A6A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Aug 2023 07:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbjHCHUz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Aug 2023 03:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbjHCHUx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Aug 2023 03:20:53 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2082.outbound.protection.outlook.com [40.107.14.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AC53583
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Aug 2023 00:20:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWRDOyTYTxUkwi4Tb/hM8dkkvSKnFawh7XaI5IMLrQlZWO/86IMyxdoIPAqXAG0zlrUIIiszkK3TuVCk9jYQjypwRVQCGjwxTTLJHaLsHrTGlMSI8Ys2V9uFMD+Qez0WMT0Tc/bGM5gnvzIw3+6c9eWS2ad5O9CRKVA8QXmfSHjEXLUmpCYfCQGeKSpQdBMVV0YGv5b0MmhMWExraobjRjeRGrLrOf4CR51EeKgDmktHhMeDfLKO3eX654QxpNN6ouGs4dE+HvfCG6uz8XqIGHzo/7EBjaUDlgk8qMwhqxUXEQi24jEmfUzxPXaDzZZpwrPllC27L8Y52BLqfOltYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsESAQ0UXW+7GcL/+5k5Yt0udQpRvvXurRG1t+yHDCg=;
 b=ZsgYSWXFli6C/BLtjlwo/kTEGAZ/JE2hp2FFg/HlrepqdMq6+5Gx5csQthErCnoSymQltpaatEeIqkEsyiQ34vg6dmBINeDRTt8YXIpbsCCvFyXiaBHUu+ANE3EqOLAx2WaizHv0Z6WcGfDe1aA+bAfsyW9fbSxW8knQvDguset4mZ9MIstqs5LcHMCd50HljVfveJFTaTY8G4/Qo0cB+wxSKGjza/HvZvwmf3+litdEU849p0qh1cO9zdjuW2uV1QojbXub9YeQ/n8Q2zM92xyVMYTev6cRkyXn/sdt6cEDPB0x3OjCiWIGBj8ZUqs/rpuBKXQfWfWzW626WRo7MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsESAQ0UXW+7GcL/+5k5Yt0udQpRvvXurRG1t+yHDCg=;
 b=hVAOsastyfjwxpt0Hu+7BL98GOX1AVNz/TF/73z/rUc6ngLnpDYlrd/dfvkO74fxJR4Gld2inNqY8gUdhVXnRNsJ0IcNlv+X5ySglZDoEC32HM+jAdw7gwPARHVYqugC+NxOluc8d8Bb9XsVRus91pmuLY5Rx/jvVO8SeZxfp7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB6991.eurprd04.prod.outlook.com (2603:10a6:803:12d::13)
 by DU0PR04MB9418.eurprd04.prod.outlook.com (2603:10a6:10:359::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 07:20:44 +0000
Received: from VI1PR04MB6991.eurprd04.prod.outlook.com
 ([fe80::4299:5db1:461:bc17]) by VI1PR04MB6991.eurprd04.prod.outlook.com
 ([fe80::4299:5db1:461:bc17%7]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 07:20:44 +0000
From:   Mahesh Talewad <mahesh.talewad@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, devyani.godbole@nxp.com,
        nitin.jadhav@nxp.com, mahesh.talewad@nxp.com
Subject: [PATCH BlueZ v1 0/3] Implementation  of MICS and MICP
Date:   Thu,  3 Aug 2023 10:20:08 +0300
Message-Id: <20230803072011.191449-1-mahesh.talewad@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0125.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::29) To VI1PR04MB6991.eurprd04.prod.outlook.com
 (2603:10a6:803:12d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6991:EE_|DU0PR04MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: a52c4a0d-1395-410b-b4fa-08db93f2267c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6IBdzSlZV4hkZkBB2wqupFqufSrranxaVJggysbXbK2bf0cSHKSM6xmOm2q5JXeOymQUiTg+oJhWepb6IDUbdagnOuU9vFHXm+3APOs/9Mu89bh4lHPTG/mWujxFTELOOIkkgdkWsKpJ+EBpVwzT1nt/OUOML87KbIqCXEknz5K6nYBAVn+WwpL8q3uNXxvCuECZ1SXMK24CyjgCivBNCR4+W8o6FFrFu6eQm4Kv0gJsD5wp4GlssSoJek18/+ocZWw0sg/UInvCUiQgYAj7MwVpWqovilQ1UZvZJxrvTzRIb8HYM03sBGpYK+OReUgUCbGXnaup0htNUMBWP/KS+JphBb4pOf802K7RUURc4V8FtAMvR6gsRxVgmLdvIviwVngyD7ylP8G0Jzv15Ii32/U4LSL6tV4UzNvDkr+CqE1hazYFkZSvITFh4/3EkGU0nsqBL5ZPAMfdX7M0muVz1H3G0KLggXezLBRoDKStcar+fLoLPyoh5S5uGdkymelXpHVNkL4P8lTl+yTIdAsMpznxH04C3hYb4i/ekUWbYd220HNUqjiA+prlaCrtZo0oeAQHYppPqtHBM8XeK2bO7b1Hb//n2jLLebb0nrBkGDpFa7xCZTD/jUPBGZ5Antso
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6991.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199021)(36756003)(86362001)(52116002)(478600001)(38100700002)(38350700002)(2616005)(1076003)(186003)(26005)(83380400001)(6506007)(55236004)(41300700001)(8676002)(8936002)(44832011)(6512007)(6666004)(6486002)(316002)(66476007)(66556008)(5660300002)(6916009)(4326008)(2906002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h1Jbdnir16W8WQfa1wA07YZcNPJZ5F1lnJZ5Vei87xs98AZipCU8swofV2xy?=
 =?us-ascii?Q?JE6+elpICTpF3GR2lvSLRo6FUF+E/fAhcYak8zpnQNmgZft7Xz5ckEaXYPtc?=
 =?us-ascii?Q?LHsLOIkl6lk+1KJZvV8QwIoxDIcJBcqd6YRGSXmmx4rQp5fUy0xk60Oiiqc3?=
 =?us-ascii?Q?obowMMjnSa3wQKxWGtCRlzpTDbNQqSsa4OAotu/dRZIiSPkuK3S/ks8tkKKj?=
 =?us-ascii?Q?UFCUTeb7Hn0U0tQKSH52A6V1sGmzIn1qUbJhLz2lctKQD5hRifYWxNxwB2ot?=
 =?us-ascii?Q?S+YZNkUHtMytYJCeJFFwUGyw7+MyPYLQmpByEKRye9ScZ8O0lxVNIlTuB393?=
 =?us-ascii?Q?NdYJPcZ6pCKeAbFD2SAhXbiLP0JoIE2iB9K14r4g0k5iPRL4V2u0OsxrJiqL?=
 =?us-ascii?Q?n/YBcyHGt5h2AJBECXZL5ctcvLJORpFeZ3d/09kQdXM4G85mFF8JhHk5vCvl?=
 =?us-ascii?Q?j2UV+j6slu6zmoDEJqlUme/3wKiHN6F7gI6yTJCLCGB0TipGd0WLa0Glnpdm?=
 =?us-ascii?Q?tU+DiTr+Wjt+GHdxaZfm8ecUnMYCCN4qgBIaS+5sWvY5LOTgrpfvbdmhVge9?=
 =?us-ascii?Q?LL4Sndh89zgOjRMJWMbIIizD4rz6TN2FGRH5XSloGm/lPuzeWpmGbI634hQE?=
 =?us-ascii?Q?v5Hq0VJ9FNEmq+k4ZPy6J4p51iXHATh/n53QHNJ07K/3bz/bgYk/bK34f3ge?=
 =?us-ascii?Q?JK6r+HKJHFfHeA5mrTkoO/uywLVksizOxbbgljMTWc3xCOxa+8gRTefju4i5?=
 =?us-ascii?Q?eKsuUWKOj10Q7eBKFQIeC1c+X7bsHE1XXPL0QrMYbB/FxfVJRhcpzd4osAqA?=
 =?us-ascii?Q?tgpcumsjr/zn92bZoWtQu7CdkMXdrj6kUuPTsp5liS1Ns1vBbFvxb//yIFIk?=
 =?us-ascii?Q?eblV1845xq6LVu3U28TH1j1vXQPuazbjopxxOLHLdR933hg31Nfl/KKQT0NY?=
 =?us-ascii?Q?2HTBW9Ni08EFXSZy6Q08Tc8dQnb3sV2NFGzA4QgEyFl2YgGI423ipSyYQ2zQ?=
 =?us-ascii?Q?BUPUJyJnwSazx7+sfFKmeL20C5SInlyfXdJ6wFwbTUrLO/uG8ZaByINIjbEJ?=
 =?us-ascii?Q?vAJAtdsY0YMlWi+CmbgzAMPG7o97SNs8TtoNa3YYoXqhdahypul/2Yy831k+?=
 =?us-ascii?Q?RO9bAshMCu/mYXjNKmsZXC0lqGfAIyjgruFvrhv6Mt0Wc4vUHmcpdcBk5VgO?=
 =?us-ascii?Q?Pk6TnwJeHD/6HzHuZupr7tMs+uMtAfvjrjCN7knujIc2hCbhna2/t758/ujy?=
 =?us-ascii?Q?oHp7jBXcvGlRWwd4ngLAWpwbTZVKWBjYtcbsnTRa1fZWV1C+g6Jr3BVdhou/?=
 =?us-ascii?Q?Vyzd76/jIOtJ4sTk3xto7dk66EYTxDLGjM8FY9QfMB5kn9o5AlkIH/ltLTLG?=
 =?us-ascii?Q?pYpxqaQGvwPPqcUXLw67/ZYz+69m44D0htjHWYkw0BI4uAPAPj+l9FDegp3v?=
 =?us-ascii?Q?m6w77hx68D1bpDSMlk1/VvAQy1JGodgzC17pXR7D9lnYMcP1JfmaqGxkLaJf?=
 =?us-ascii?Q?c30xHe9s5CBiFR43so1xIo6taMV/keanSLU1el2HFiDIpKQE63ZYRfJTekh6?=
 =?us-ascii?Q?EgBuxlfk4W0UnCmvsuWOqu83q+K8hJloiPWmpvI1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a52c4a0d-1395-410b-b4fa-08db93f2267c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6991.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 07:20:44.3085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/9TKyjnriMPHJE9FfuDBoWEZe4Jle2WVloAUEKQYykH3P7vLVSQeMXWZ0/56fdP+H0kWh+bjwxU44WUmqr6Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9418
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Maintainers,

This Patch series contains following points:
- code implementation of Mandatory features of MICS and MICP.
- code implementation which is required for PTS testing for both MICS and MICP.
- code implementation of Unit Test cases of MICS and MICP.

Implementation of following features have been handled in this Patch series.
MICS-MICP:
- MICS Service
- Mute Characteristic[Read, Write, Notify]
- Configure Mute Notifications
- Read Mute
- Set Mute

PTS Testing:
- An interface is given in bluetoothctl/player menu, to send
MICP/MICS commands which are required during PTS Testing.
- All Mandatory BLE PTS testcases are covered in both MICS and MICP.
- All the code implementations have been tested with Mandatory
PTS testcases and all test cases are Passed.

Unit Tests:
- Implemented  Unit Test cases for Mandatory testcases as per 
testspecs[MICS.TS.p0ed2.pdf & MICP.TS.p3.pdf],for both MICS and MICP.
- All Unit Test cases are tested and all are Passed.
		
Thank you in advance for your review.

Thanks and regards,
Mahesh Vithal Talewad		


Mahesh Talewad (3):
  shared/micp: Add initial code for handling micp and mics
  client/player: Add interface menu to configure MICP-MICS during PTS
    testing.
  unit/test-micp: Add unit test code for testing MICP-MICS

 Makefile.am           |   14 +
 Makefile.plugins      |    5 +
 client/main.c         |   12 +
 client/player.c       |  164 +++++++
 client/player.h       |    4 +
 configure.ac          |    7 +
 lib/uuid.h            |    4 +
 profiles/audio/micp.c |  340 +++++++++++++
 src/adapter.c         |   87 ++++
 src/shared/micp.c     | 1070 +++++++++++++++++++++++++++++++++++++++++
 src/shared/micp.h     |   56 +++
 unit/test-micp.c      |  357 ++++++++++++++
 unit/test-mics.c      |  290 +++++++++++
 13 files changed, 2410 insertions(+)
 create mode 100644 profiles/audio/micp.c
 create mode 100644 src/shared/micp.c
 create mode 100644 src/shared/micp.h
 create mode 100644 unit/test-micp.c
 create mode 100644 unit/test-mics.c

-- 
2.34.1

