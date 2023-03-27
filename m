Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5129C76195
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Mar 2023 13:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjC0NqU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Mar 2023 09:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjC0NqT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Mar 2023 09:46:19 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2051.outbound.protection.outlook.com [40.107.14.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB37D3AB1
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Mar 2023 06:46:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnFs7fUyBrWO+/1KqAwr3NxHmxIJc1GOiRSBqT6UBXzZW0tXaP8uFNJ2UbtOFbEv7dcQ78tFuNILzGP5F5KoW8CinzEEvIF1O2Fsy8q3RwovqTMTgsL60vWKoSSA1qFd9Oy0TZrfGQbz3amthq2peA7jzxZfX5WuVN3G1v31S268F9sukFAE+9dIgupv8BQc9hvdNAfJzCjrglvYiO/nMWIPOg24y44DM+A3CZdpXxPq6uw5R87rLAklvToWOaWxVUJGSOba4wv1vUZreRyu8BCkex67uXXgWgQXR0EqGVFudknJr385kTd5vZpnVRtxO1Xs6SsgTRsqaleSLFdd9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zYq2IYMMn2tMDF5RnLQY2NQIh1XGfVjPTKEWRtoVoc=;
 b=C6e7DX7Fki0rE2gDGhNFDchDE4LwI5RkiBCJQSHjYaKlBcRq6AuyZVC69bCj2fMpbCFFCCqAxvYxnESamOWgh39EJ7rs3Sw1J1wr5BtAvJj64RFdqVobMhGEf7hoVT4mvICAlxjlK4JJ9/71vlf9zC3lFBUSHY7OSocnVgbKlKumDFHpraJZ+vNHiJ7nsT7KvcnVmadL0gNKDE/GWiP/4/VqKB9vONVSNiAzo9LG+ZmtbrmqWKSZgVASyfJdf1gbtMPVnZXBaK6BIDJOFtZwfAZDfDfYSf6LNrPPHnpITu7V2IlL6tZ5JXl+8HW9us0qWAnWb+Eb0e03NADQeJVrDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zYq2IYMMn2tMDF5RnLQY2NQIh1XGfVjPTKEWRtoVoc=;
 b=oJDxbMHLUtUNrP1MaCGLS8+NC4hYtfj/o4rRrvHQfiZ+j6+Gt6CjMkVRU3keZJT0rmBdh3fGyMfVXh/ahyQnzD5eEauMZMslg+PoJHgAXPlB5yEK/P/Fa3lYATq7HhH4Wdk+wLjvrKD93QQuzXiS/Siplx199TmV3o6ne3SBbFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DBBPR04MB7932.eurprd04.prod.outlook.com (2603:10a6:10:1ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 13:46:14 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%9]) with mapi id 15.20.6222.030; Mon, 27 Mar 2023
 13:46:14 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/1] Split bt_iso_qos into dedicated structures
Date:   Mon, 27 Mar 2023 16:46:01 +0300
Message-Id: <20230327134602.14340-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0117.eurprd04.prod.outlook.com
 (2603:10a6:208:55::22) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DBBPR04MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: 58161ed3-6c9d-4233-4bea-08db2ec9a1bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d6+p2oBPNuDy9+NbshMeeAonHz7eXUzR7rEg4hADFnYYznFdGgwXRkr7FpYLUyt5q8tL7N0xqdtl1o0ex02PABqB5GuFKAh8rsLEZfV8R3AuBz7S1QMXXfzMaLZ3rOVkW7UsD+zLNWmwV7qJ9PbMKuk7ZH82WbJfjfaL9xOv1froRIEYdYVGuEZqNB56EVpvHIITiKo+LpNJZe93fVH90MF3EAsDTYccGFE93lDFMGxaFDlNt/xdbhblPc6SKmuu0NhfkUZcnF9JL/tGT7IBkkKzBAzQsCoe4UU0zZSYAFASH5ZxPQn6yNADgvdOF1ZDPkawKMzqYslyqaZH/E8a3ZFx+g00jEvkVig7qbcdoWZbONAO9sXItmGJ9ch4QY2E20O2eLgBQpPUetq0yjyfIoWwswjsZuiowibRmIqKawsK8raSImu0I6u4ibCH4Fk9ReBoCBZWroKJYgwqa6JnGLEkEShGbKLpEpXA8eriH1jHtr0UbDMn8EsP4dpFR8C+pptxqKWFMYmwZdx8W4c50sFcATLxIEAEFYSreroThibcEofFvrBEwUpyKoj8QaGwbshnY8noMYHnqp5c3C6suVx+F6no8h/avzLQOujS8dmrWrNYPSzU6P4Zs9V2SGul
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199021)(316002)(478600001)(8936002)(5660300002)(36756003)(86362001)(44832011)(38100700002)(4744005)(2906002)(38350700002)(4326008)(8676002)(6916009)(66556008)(66476007)(66946007)(41300700001)(6666004)(186003)(1076003)(26005)(55236004)(6506007)(6512007)(2616005)(83380400001)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zBVSlXJk8dc9Y1ckv7HvAqGkzwEY+xRPRZA3NsI10bfWFdjj4aMoTYr32+Fd?=
 =?us-ascii?Q?OKH6aypHebtqI3knABrxDyx/WHRGoG7XQuHd1GjlRqH3XxNpeFgPjoHZZtwS?=
 =?us-ascii?Q?X3ibFjBqrXkLZlPflLK3UJOWSSmelW+ZIqQC3zyLMO1LDmPIUcSuTwlHU2wC?=
 =?us-ascii?Q?Fuvh3KYQHjVyP0LussTVRe06VeYYw9nCegWUhxHcSYhoU6PMLvrcpmi/qSU5?=
 =?us-ascii?Q?QPz0COIKZWvev6sg6R+38MMhm6rtkm/BWf4EQUvjINCEYDDJ56xPQLGvxQvY?=
 =?us-ascii?Q?k4WFoyHsjAn+25YRW6yLhbDQ6ZXRDL6EgvPaKHP8FsieCfbVeZeoGNDA96wg?=
 =?us-ascii?Q?UW2N1N+KaeuPk5fysA4ZkSgd8FTBRz2xTwP8HrBhIMMFMXTcO+N+ieiwxsa5?=
 =?us-ascii?Q?H3L2N+xi8o/8XCP6Tj2GHJXsUqmCOsP+NWI12DKottNOnQfFytrzYawtTTzb?=
 =?us-ascii?Q?BYRq2+yVKTVWU/nNZnD54jO11B6LLb6IC+2A9CSPf/f6bLqJWcOhqAmtxIG5?=
 =?us-ascii?Q?9DMDhnRg8zfaxq0QCAj6MFil8Tw3EQ+cHNtNrEnPjJC4YJ7Pk5kjcM+MY3W6?=
 =?us-ascii?Q?iF53ThVh9hXhgcOagfp9PoI0HVoeiSHOSlh40tDxTWRoheN6yE6VGz80vQjS?=
 =?us-ascii?Q?hbCVOokA5nbtyLmPiWTjT1KThCtiqLGQYjT0zvJyhmJTP/AOG6bmrvCYUfWw?=
 =?us-ascii?Q?bOhZCvzWFqLOXpUsqlWQfWim5uvi7vPQz66iAdGMC1Sn5dTdHOtSpAOQhz1p?=
 =?us-ascii?Q?/jLVZNNPxBMXlALcjwtlTDUylKHQgNVJSNzzYSwK7vNIPMupMUpJ32x6Bhd7?=
 =?us-ascii?Q?+0x9OMsGhAcCxz4amrBPUFUW+DOZmIQxpkOV9FmlaXaprGxIhRQisIwb/XZ/?=
 =?us-ascii?Q?NTQ/cx95BgTDgzWYLT5LMsWXDUMY80/oeJCwPoIavDmQw1zA4JNMjOal+dop?=
 =?us-ascii?Q?+O+IiCdcVyWR49MFElfhKvxPsGh8fyR/HDjwAfcYDh+dEpg3VIdNkRgGWbKj?=
 =?us-ascii?Q?TmAr9ZrdCGaAMoR0P08QSSLABGUGtI3iheyvpf20wg45kiJYTQLjzjkrQUph?=
 =?us-ascii?Q?aLPUz7A6yCM1wwBQ19Q2LXw2is+MgFIz22W4ZVm1SpQVreDYm1uHGFXUqZir?=
 =?us-ascii?Q?WeEghFHzVKogaXf76DhUNCvePL8l0wG2bgKW0TpZsfPEDYgutjQCU9D6lnzn?=
 =?us-ascii?Q?DtgvCei54jK0VKlJSl94B3TzIGPmwa8lcGH+gB4coFQlw0MpX97kw2FDkNJA?=
 =?us-ascii?Q?Cx3LuqDxUAlApsUZ+524kOUJyM+xLWVkUiiYB8+5gGxYDs/jqyiq766LYXmJ?=
 =?us-ascii?Q?TafKUElZuAFFQC9eybp1pmEFeldFvmdlEdLX3QeOVSdz5pA0RwpPfPZgdHZ7?=
 =?us-ascii?Q?vrSRYi2Wu+5Y+8nWNXx1bPm/IQEuUCSuOaQSd5rJgwjoP6Kbl8fYXxoRtmQ+?=
 =?us-ascii?Q?DOt85l5gA3WUPNFr76M7T/LhYRD/tbFQhHtZshAQgHm3uOiDBlo4pN5hVgWl?=
 =?us-ascii?Q?Hz1aymyCsVUwLyoq4OxPVI5nJNte563SeHagayU3f/xU3aymoQsPr7ZdBOWx?=
 =?us-ascii?Q?DjroNH3baP31FXaAFf6M/tPomhcMeoB6kCjkj2/U89zkw+7s/cqWSM/h6VW5?=
 =?us-ascii?Q?RA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58161ed3-6c9d-4233-4bea-08db2ec9a1bb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 13:46:14.0723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0I4dnQ38qHZ7V7Fpr9/Am7QtP85THh2k+TqdadM9eCCna3tHZUUemEl3B/BgYvZBylWa9yv8BWvFwdlYc4oWEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7932
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds support for additional ISO broadcast QoS parameters,
that the user can set before performing broadcast procedures
using an ISO socket.

This patch splits the "bt_iso_qos" structure into dedicated
unicast and broadcast structures, so that ISO sockets
can be configured with dedicated QoS options depending
on the type of ISO procedures to run.

This patch depends on the bluetooth-next patch
[PATCH] Split bt_iso_qos into dedicated structures.

Iulia Tanasescu (1):
  Split bt_iso_qos into dedicated structures

 btio/btio.c          |   7 +-
 client/player.c      |   7 +-
 emulator/bthost.c    |   3 +-
 emulator/bthost.h    |   3 +-
 lib/bluetooth.h      |  59 +++++++++++----
 profiles/audio/bap.c |  19 ++---
 tools/btiotest.c     |  17 +++--
 tools/iso-tester.c   | 144 +++++++++++++++++++++++++++++++----
 tools/isotest.c      | 177 +++++++++++++++++++++++++++++++------------
 9 files changed, 336 insertions(+), 100 deletions(-)


base-commit: 338ba4352b6cadafe61808c21302c0abe2168e02
-- 
2.34.1

