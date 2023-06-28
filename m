Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B42DEB64D7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jun 2023 15:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjF1PH3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jun 2023 11:07:29 -0400
Received: from mail-dbaeur03on2042.outbound.protection.outlook.com ([40.107.104.42]:61344
        "EHLO EUR03-DBA-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230196AbjF1PH2 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jun 2023 11:07:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPelIljsyH7aKsx7JlrB7q+afo6Cvbrcpjh6XSGSpd4C29QABk/++qYP3U886GYIN/XzlowuFAHZWE/2iCKt1xx2MFalj+PcEdUQ976TvNOJCXFgjqHT73gp31m0il1BgKtXMFbW45Upotk5Kx0Ij2dSTAvYxYGuPvtKiPP6onEL9NU8/G1+/A1TkTZk3Hq8ISv/1kXLcu0QbZuana0SVKSGPGKnDe5YvHShXqgYEyG75X7mbhqzEmBPYZHZmRUdvrF7khC5q5qXTNzMhb4B4Zsst9xqdfY21hZlz8mZHHENsGuVT02qcRghqUP+/qYl0e0FbH+389Fegpz1L8T4Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USaAfLY3ESzWNbAsFSe6VyuZoaO2IGXDrO85zzUd/Pw=;
 b=CkBMFPZIDLu9DeVlKzsNQn4NliDmeNwfo6XKogQW1ubfyjjaNCozvC0TAkhzX8JGyei708upz0uppSZ8Ob7IvHfvk8+rq6TngMASHQ4+Okym0UKN8J/cEDfJCNMCjL9cdOjWaOolSoLe2YlKUUk47uT6rOwuhrIkeTfpLvnz8W+YHwGQs+AuBhEtSfR0/V4tQpYgil34zuDXnid/WB58D/VK0HJ5zfHw8bwbVx8aX1sh5hO/CTkDv02YSgREzcw8NLunLSOFD8YkWWFWHtZXBR8T1da12kaf9JmRScvUksVwf6kEpjuIIK9UQGFfjJIxFV+C968URzY6wlX3awgXhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USaAfLY3ESzWNbAsFSe6VyuZoaO2IGXDrO85zzUd/Pw=;
 b=ln4bC1lNtiN/dRG7wiQlXdO8NbIgDBn6ds5cV2nYN+/mfW19VmCQZkud8ZvMGOZdPVa8sq1KRfM9AU+jZhaP6+FkMT6/bo4QqP3Kt/tkFZ+6pXDi+50a/8G0JA85lxP8iCaFAFU5Plpb681lhYqbfCUlDKTnScFyo2aNVbnAP6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DB8PR04MB6953.eurprd04.prod.outlook.com (2603:10a6:10:111::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 15:07:26 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe%7]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 15:07:26 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 0/2] shared/bass: Introduce Add Source opcode handler
Date:   Wed, 28 Jun 2023 18:07:03 +0300
Message-Id: <20230628150705.248285-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR07CA0034.eurprd07.prod.outlook.com
 (2603:10a6:205:1::47) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DB8PR04MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bd09350-09a7-463f-cf83-08db77e96216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T4kUlZ5IxnC55+J+qkFXv3LPU3JDVjzsPqcA33fgYj84sgwocJJiZkxigt+fOjqvuCdeZR4fMdMIi9WMCqjavelilozT9qo0pw/CKjOBsrL/vvmwph7KOISk5psiH7V2RvqEIS2n0nEtf7jBsxUPRmIl8wDqUpMOCJBd8BU9fD1S4l91peO6YvFVlw1IVgU6RU7JbsdLanOC+LZ+uei6qNwt2TZ8xQeuPKw+92QyF13kmCrEMvk4bf3OYlEqt49+prbG11349kBaPw8Hhfe2my0KpxrDjfciVEg9FPFHvJx4raorXrvIflXdjhds7HWg8Ole1dG9+wX1zs6LmRTUnPrqsXzijqlN/jqsi6fA52l7WRxq7EKRQ5fNp8MCiTuVrgAmPllZir3s7ZqxDmqndRxW39JuylDVS4cf199FQROANCdVi8WhNj4vOwH2uVoPwYoof9CGMDlrvc6+NJeHwUCXTsBZqDRRWzRKTFE9GAizDuY/pHGbod5rOzRufcd+8e3Aj2HOxtqNU1I6lHQhzO2SLCvbnjmvDjyy2Xmd6pivmTkPI636ZO+xXC2o1POucAJ7hlNNhPkkCYjwWgEOt/TlQxVr262OzwW55FnbvFsSeJdSZXn3UnflJGfbhCTA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199021)(186003)(2906002)(26005)(66476007)(5660300002)(41300700001)(8676002)(6666004)(6916009)(36756003)(52116002)(316002)(2616005)(478600001)(6486002)(86362001)(4326008)(38100700002)(38350700002)(1076003)(8936002)(83380400001)(44832011)(66946007)(66556008)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3DTWV3A18kO4N470kweknVb+IHEkB2geRupItfuP5yKpWhHN3dBR7aWr22Hv?=
 =?us-ascii?Q?iUwoka1EbRAI/XZyBZDPJWwUv5m6+eBJ9g9YcjF9TXUZDnjA86aqgzk0Rp6N?=
 =?us-ascii?Q?Q0dXhf5f/QjpcxAMT4r45t7FvpOQk8pye7agFi53zyNZDHX0ZghYZKxVhIY0?=
 =?us-ascii?Q?LjU+EV5synYUDlL1KLJhnChZaSMWL5vwQSg5uUsvqYAOklQESs4F5ENjnuKc?=
 =?us-ascii?Q?qKTUFB2KSXYtjgyDACBAjIPxzI9ti5VfsSKMWDOBMyebftJPoKPJ8BzJgrI2?=
 =?us-ascii?Q?8JTL8bWwLPRUEqS2SuMh3HDqEXyatSOYyYwfqC+caKp5CuNsg82EcV4MYxEO?=
 =?us-ascii?Q?znba5QX067EVS/kDT2EonWaiYN6ISOHB2rCqNNX7dkuu4Y8UEDk7buR6zLa/?=
 =?us-ascii?Q?JHppf61Cz9dVNDwSbgcfaxVLAjfq5QqGNss+iFAL7vCiEMZxeUTOb+i+F+rZ?=
 =?us-ascii?Q?ZJ9rfY3c7yeSSMD73myTzqraeWzhV01myx7m0kdm2hnHRcj1sAV+kHIc42Sl?=
 =?us-ascii?Q?0g+PAB/6Aic3s/nWUanVzmF5ErFjH40izhJ93FCEvkishWINqJBRSU1K5f6l?=
 =?us-ascii?Q?RY+/Uhh1dArULn01NzkFHRVnWEwVZMGSkOa6B/gKctDgsDwbRouaykL5C5l2?=
 =?us-ascii?Q?nIpNHXLAUUpCdv0y9Ld20JdHwRapN0blIlpdpOZnnue4lzReaQj15WjKY755?=
 =?us-ascii?Q?kh/AwqdgiV17gmVE9oKxIKwwJM28YMJvPdMeWLhhn1LIYmxdSMs38QsFwSLU?=
 =?us-ascii?Q?RqylvQ4xHHPIjT9pNzwVHzd4MflqOsCbtBjbEbIkBEwZpeIjxsYVAPwhED+Q?=
 =?us-ascii?Q?dlNoxZKkJbVsVN3rGXc3vyQutbO0pZ7vAWPliluQIBYKdSROPRSyDqtPUoSS?=
 =?us-ascii?Q?QsrajMnUkG7Zwkcc2d47K42rTGcq+jhBSlOv/BlycBlY/2D611p5OI7CPGAf?=
 =?us-ascii?Q?z5KihvLnLT1qJD97Tbi1/4mcVuIMLGd40f/ASgTNWPuUbXElYfcXekTUpHAL?=
 =?us-ascii?Q?bpq3FsZzuOjbjBDZVur3EY9yOQAH1+MrmK57B3hMxmPwZVbP7R4DJK7StH9Y?=
 =?us-ascii?Q?OJcAHvzwTrJF2H9KQ62Qvr7k9B7eqnsyNTU2j8YSzyl3oE0otJmLOTwRL42/?=
 =?us-ascii?Q?d7w+FdIXF7zWzRE+WZhAzXTbLT1iWXw/2Y1cnjYUuvP9XIdEGzJiJEGoZ/Kn?=
 =?us-ascii?Q?Y8Byi4qrr8+LTT7CazPTERc/eIW2b9TX1Gyx8pZF6ovXMLOAzuXVVpPPb+V+?=
 =?us-ascii?Q?ZgzqWzaBGRi5EZLLHNku7ApIqcjaUW0hjsDGCHUHusM5zBjW4bhUlZbX5BfU?=
 =?us-ascii?Q?WkLbgR+DVQoenF51TRTEH+4dZEyM8RS4E+3DoDLuwDBr8Lf29PrjpNZ7GI34?=
 =?us-ascii?Q?mkKcUjrOpOrL8ASXGJOiH/GMigrsxx+qJc6NA6oWaKbmhWIiyDj+TLGN04xy?=
 =?us-ascii?Q?REq/wLdu1k6/6zBsUMNYF9MkRxRi7Y/wLitxTlwGTLSJGQ8RZ1b6KoC1FeYr?=
 =?us-ascii?Q?5BA8fX4ynQFcP7c6J9RFXTijWW59+3yJfugH4iHsvWqurl/KGrInGu30pQ6o?=
 =?us-ascii?Q?2/7VZWHXf3a2azThBVXELUJ9xuR+0ShOBW2I+j2ARvBOW3ATsL9RGYX+p5Un?=
 =?us-ascii?Q?QQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd09350-09a7-463f-cf83-08db77e96216
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 15:07:26.0853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1814navtv8iT6DJFhQUgBAnB+hXibjYFqX5cE9ivzaqiYEu3oBiNfKx9WXaqSNLSpjddodvG1STIOlMfZWisTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6953
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch series adds the BASS control point handler
for the Add Source operation.

If instructed by a Client through the Add Source opcode,
the BASS Server attempts to synchronize to a Broadcast
Source, by opening a btio channel.

Some additional btio options have been added,
to allow binding a socket to a broadcast address.

The BASS adapter_probe callback has been implemented,
in order to automatically configure BASS into the adapter
database. The adapter bdaddr is also stored along with the
BASS database configuration, and this address will be used
as the source address when binding the btio channel.

Iulia Tanasescu (2):
  btio: Add option for binding iso broadcast address
  shared/bass: Introduce Add Source opcode handler

 Makefile.am           |   2 +-
 btio/btio.c           |  76 +++++++-
 btio/btio.h           |   5 +-
 profiles/audio/bass.c |  26 ++-
 src/shared/bass.c     | 430 ++++++++++++++++++++++++++++++++++++++++--
 src/shared/bass.h     |  14 +-
 unit/test-bass.c      |   2 +-
 7 files changed, 526 insertions(+), 29 deletions(-)


base-commit: d6bfbd28420edf91382635b229b9f8b2f94dc060
-- 
2.34.1

