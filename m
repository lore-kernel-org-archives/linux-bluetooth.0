Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38245C25B67
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Oct 2023 14:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbjJZOvG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Oct 2023 10:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjJZOvF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Oct 2023 10:51:05 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2054.outbound.protection.outlook.com [40.107.7.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C5C1AA
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Oct 2023 07:51:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCCrRerLcs9s7mLf27XcUxQ/1r+FZ+6jMxzrRv8ob9KyatwhYK5OsGuJhNc1fdOX+zHve2OXylKVHpmth65Ishodwk0FKv8gwvdxG/IsZPkcPTHjt/x8czV7Y2v8Im+rLr/4b3I1wpCuNlUVBiGVrL7Qf96Uj1RuKsT83dWdNQxPuIAWHR7b34UbGGFK1RiEKSKw/Hko3rIlNm32S256oBytmMJQcyHjS4bPnGPnBZ2gxvqKuSHQBPw/pM5KroWq2CYO4w0T+NEBgPbBVGrjQpUXZoe7pPRYZFuZ4ybyGAhBv/orP0SuY0f8toO4EpCodYxG9LJog4AINSr8XNibHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RoFOvh+wxPq+/llL/B5gQ83id9CfCk2PdOERCKOUTTU=;
 b=gMt07UcS7mpAGlEunlKnoGfOaxzZIJObuZMCzwAC1sMFODaQM9h8Yp2cUursbrvMNurGCL3Dmtb43dYtHQtSiDijRXMG+T1VjX5dRHNBnubOj6oXu8y7YokS6J2hlctEmioC5qptzykRuYoQXkXjFRvViCXhTUrK4lIob6U50/XaAFz4/awzK7pZMLiB2LgDX0J+LLYrPnk8e+2O9prqiLkB2zQJws/KjjyLG3vGuHNluoRr0GyfakLqcA9X92a0SuVrDiLUFz936ZJFAiG8nBsgV9yQX6rfMK7ngHuLmsqry4IPFwMDbxjuYN8i14n9Jd38NeNhV1IHla2cMye4kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoFOvh+wxPq+/llL/B5gQ83id9CfCk2PdOERCKOUTTU=;
 b=LHWF7mC/6+ca+og/UmDszQ1UBzSeZaIjD+qioQuL4q6bKjW6VoMli5OU72GCg5hXJ4QoEpBWbikQ1+x/zpxvmTOWpWenUqf4XhRkhf8QQqmWvqahj4lhhQKkP1N7sN3wTdblgr3Gtz9VCWvvfDD+XMInTE9WOAI3N1Se+lbfG7s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com (2603:10a6:10:ca::21)
 by DB9PR04MB9939.eurprd04.prod.outlook.com (2603:10a6:10:4c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.10; Thu, 26 Oct
 2023 14:50:58 +0000
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::7c8a:c8da:e6a5:8a4a]) by DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::7c8a:c8da:e6a5:8a4a%7]) with mapi id 15.20.6933.009; Thu, 26 Oct 2023
 14:50:58 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        iulia.tanasescu@nxp.com
Subject: [PATCH 0/6] Add support for multiple BISes
Date:   Thu, 26 Oct 2023 17:50:41 +0300
Message-Id: <20231026145047.4637-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P190CA0007.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::20) To DBBPR04MB6331.eurprd04.prod.outlook.com
 (2603:10a6:10:ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB6331:EE_|DB9PR04MB9939:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b7502f3-d1bc-4f36-4b21-08dbd632f6b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q26PgL9ZpQg8AZLak0u1/jXwPb/PMCNXeeg0BlUzC9U0zmhP/eBWm7TTEJUZcnXQDYVMvXScoCJcK9JNWrG+3MCucQDrDeQyrFLBlVqOozoJVlgY7AW7KnD2mEGPCvQ0pzcunVzarqvjEYIqbnesE7/MdX402vMNMfK/EzqgkkHJ93+nuYiuJLHv42XKQvyARcUHnGUIK+xuU+UEdFEauXQa0sI29JD97L/AxOjBiiBzvR7prN64ESPNHhL95advrLm6kukdmIqGkauVW/DpUgO0vl+74OwWkYrXFb6uoUiDCZpMDeClIH/50o6pFV37A6Pf5xDq1p+OnAfiLo+VgL8ZAA5d1x1gxjZyn2ecRreTNKMYoJoLrj7cyToSTlQA/BXmu3IiRaS8sWkpj0qLA333DllSkpuhp76mqgOp7WZ/EfTcn5oPHRBamqrg/3dWh221NF0wkpn8FyYagaB8CeUZXInpN8qvcfzx26GevvsmFFiKGC1HP3/APSKycPvK+CaBkAI57JM8R/C11pB8GUZ7HBqNCCtApJEO0DN78e09yTJJVUUKGIXBLG6kOB+Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB6331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(66556008)(66946007)(316002)(41300700001)(66476007)(478600001)(6916009)(4326008)(6506007)(6512007)(6666004)(8676002)(8936002)(6486002)(1076003)(26005)(5660300002)(2616005)(83380400001)(2906002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lg3F4VSDy18eCOjBuNUYXjBGJtNeXtTy+f2g0u6HKUtzKit2/Yv1UJ7FL5I7?=
 =?us-ascii?Q?P2sZE2lDu59lUlsnr/xxFBwGdGEKOE8ucUiMD98v/ofbrvAgve+ofgP0yOfs?=
 =?us-ascii?Q?KlxrqgkgCG3AOblwhvAQq2kWR0RL2jexN/hRcgFqR7U1impbhz+bgCYkwDAH?=
 =?us-ascii?Q?yDcG2gfBpuJ+/0MQuHj6z3b49rBEcIneetX29y0CSHnMuhLwh/Ip+6a58wtE?=
 =?us-ascii?Q?g0QFGghymmao+8IfghubxIs7JYNT6PJiDKpSn/YaKzCmWzNnNobzavJUDWLk?=
 =?us-ascii?Q?HeGCWWfpWdWeYitQU4BeReBhACIbe+t7oINe2feOIgdU/p/CcfWwwKyeCiMb?=
 =?us-ascii?Q?MsNp0HhopaWFXeZjOrbck/oEThtAZ+Hh5q8eLu5ifewwCg74nKWGbTQjjsx4?=
 =?us-ascii?Q?D+72dNQV/milWYVR8UoNd78bQQPnrLtlb8Ne+Tye0LqfFyNcGUUbqy+JNk01?=
 =?us-ascii?Q?UwnGkmx5etAEOdnogFaIM9oXWnjqpLJFqWomEdJpG5k7TVBYt+10mpUY79v1?=
 =?us-ascii?Q?I1G60vm8cGYJdLLUGjm0y3pkFD7+2E8j6vn//1fMv7ZzYJOAz65u43rU0ZOU?=
 =?us-ascii?Q?sSXTNwiEakpZdfRIO9BdW/S/3ndLUG/aprMma/+OZkmsPlEeQYF4jYizYas7?=
 =?us-ascii?Q?sUem7e0K13eGPC5IgpiE+k9xQQd04Ftp+ztf3ODaUQWvvQCkbV6kMufcW9Gk?=
 =?us-ascii?Q?9CsG54qgfWh7irGa7Lr3SNV+gmb0Q4IPk/NdNX0UdEL0C+faoruWH1iWbPpd?=
 =?us-ascii?Q?u7I+98OsOfjoxqQvN++bboMuRjIMSbcbsSqfkAufK14+4RHzTM/trDy3ZyFU?=
 =?us-ascii?Q?DMjO/icchQCTtGXipZ8yWAYUwfGEmbO/tBUHIlZyxiHUKJ4CHYlhgt83EsBH?=
 =?us-ascii?Q?/2qd8YLQOITUilVBKviu9joGUsL0JI6IbH6lhgUXL3iqywQi/8u8tAXf2/d1?=
 =?us-ascii?Q?i8YEssLrXepPfl9XsZJ4buc24YDzS8Hw6zFSTPxYM/26ZYtD110ecDKfWBMu?=
 =?us-ascii?Q?GpQ8ByofBVi5oQfZxajYtjPR5et9OcemNtopPbyJi35i4hLoqInKbw+kXE7Z?=
 =?us-ascii?Q?j50Asd8MtuMSzqFK6w2BpLM0Q5kQ5ZRUEr9cY/DRSO/zWDQKXuqncW+PHBoD?=
 =?us-ascii?Q?i8XMGx0Hhp6B6s8vgjnwNJNd24nwrjLG3NCBbPIk+GFW8tmh9SVBXJw+p38p?=
 =?us-ascii?Q?7/kDcMGYokvDcGuDc/B1FV4UOd9ey2EZ7CYxKjwdF4eE2S+1YRu6sbck4oDT?=
 =?us-ascii?Q?TUxy28NY6+g6YDWHlUP5A7cNMhn+P58acBIis/C1HbSfxbFbDlgqlkzstHmz?=
 =?us-ascii?Q?E1mcXsv9gmbg6tUoneG29S56BsgFYTPqfR/88iYetr+IJiY/uQBWm4fVVqDN?=
 =?us-ascii?Q?xBxl3Y3e6veC/e9270iOhFL4JZBe6Bl0Z/NY7kKOJcCRCm0gpYKyuH9kz2Rd?=
 =?us-ascii?Q?mK8bPRpbNAxSXHg/IN8LYIumZncbg4fxq7qjTucKNXpuSQmDQqBwDqt3ep/D?=
 =?us-ascii?Q?gYfuqq6L/3R/1QXwBPtO1idTRM0AWEkoW0aS/efhZi8H89piy/inEuCxK/cF?=
 =?us-ascii?Q?eqz13aFO4CrF+rjII0tBBrci9BPbVCShfFJNct527kM9azcx4iUPh9XgQ6f+?=
 =?us-ascii?Q?Ow=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7502f3-d1bc-4f36-4b21-08dbd632f6b2
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB6331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:50:57.9693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q2SmAFfFJU9YPMlYKpqhaxlpfndQ6vNbKBgSxJs663FP6nkVaRmbaaix2/ykt7W0XhB+uCYBEivgQlHLAhiKhvWkjosM8E1KM37WYBU0g00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9939
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add support for multiple BIS-es
How to configure multiple BIS-es:
In main.conf set the number of required BISes in NumberOfBISes field of
the newly added Bcast section.
In the base_lc3_48_4_1 struct set the configuration for the base
Continue with the registering endpoint for the broadcast source
endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x06
Use the endpoint.config command to set the BIS codec configuration by
specifying the BIS when prompted by the command
endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 48_4_1
[/local/endpoint/ep0] BIG (value): 0
[/local/endpoint/ep0] BIS (value): 1
Use this endpoint config command to configure all the BISes
After all BISes are configured, use the transports to send data


Claudia Draghicescu (2):
  bap: Fix source+sink endpoint registration
  bap: Fix source+sink endpoint registration

Silviu Florian Barbulescu (4):
  src: Add support for defining the number of BISes in the main.conf
  Add support for multiple BISes
  profiles/audio/transport.c: Add support for multiple BISes
  client/player.c: Add support for multiple BISes

 btio/btio.c                |   4 +-
 client/player.c            |  57 ++++-
 profiles/audio/bap.c       | 483 +++++++++++++++++++++++++------------
 profiles/audio/media.c     |   3 +-
 profiles/audio/transport.c |  49 ++--
 src/btd.h                  |   6 +
 src/main.c                 |  10 +
 src/main.conf              |   8 +
 src/shared/bap.c           | 254 ++++++++++++++-----
 src/shared/bap.h           |  39 ++-
 unit/test-bap.c            |  12 +-
 11 files changed, 678 insertions(+), 247 deletions(-)


base-commit: 00fdb61d56161f523e975b4c044030f4b40abb6d
-- 
2.39.2

