Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A48BC76196
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Mar 2023 15:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjCaPjy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 Mar 2023 11:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbjCaPjq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 Mar 2023 11:39:46 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2042.outbound.protection.outlook.com [40.107.15.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC68B1FD0F
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Mar 2023 08:39:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBePlaUAzEZVkGmWe0bZ++d80lA85wijsh2EDkDCXyV2dYdGhNkQH9nRwISuSn0FqcaFQtdlkNSK+HQ9X8ytxxNdALMdVgqq+mVvtVXHGORkCJInQHG2oz2FuV5YAAmxZ2cbEllc7JqbfnLdJ65SbviLd8qkDrNHG0FN8WFbUEWCjsuZb/pZLv6Vb9LHmcnTKgznvnwwJ06HkcrIZb0D2wgb+So+tHvnpxApfuEWca3U1ufStUCTFTUdwkIR3fFIkCzzwTyhklUwyKj2otnThZT7YHISzuxfxiiDbXhPpeyvNhdKdVH2HLMQlWsDf8tksfKVdVTBLt2LbQLnLzwO3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GouN13BAt/bVYbgYlqHgAneqAVjmaBaqOOx2ENJwdes=;
 b=XjYCv4kuYmRKo84YPZcHmFf3iYdHH9gWxwdcA/2T+8D54W1Ba0CWM2FNoAkkpwsN8OK45IyisccTF81Ze01RTK4AnuoPclN5yMHqXBtaJ0YbyKN1FGQQgnKY4VzrE3qUqpZ5NOpqCR8Ae+cl35VfuPEbvbFnJY1dGy1pUythxpSXBW3OFbsuQxWzjgSec1fmaJ2Ndc2DeN772iC5FSDfv3oSFxB6tdkqbr1KSKxhicC4bgiyXzn4U6XgRhqw/V0isVqOb3ardVyRhwYxPjwoxqu++SC9T6FHOV0+2S/TxGoyju1CF6x50uJdR+NUaxViicGO2kNU41n/bjs7bKIwlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GouN13BAt/bVYbgYlqHgAneqAVjmaBaqOOx2ENJwdes=;
 b=RdU3qG40ocxi0mjWguEDkyYRl/JtrpMThNknQGu6mIEtKWiDFHZOuSV3uFEQ09HwOXdMJBQSR5eXl6S/ans/dSyyATlogpYvn2rzJ9WZ+W0I3ZZwioJq8m2l1evfGBfOfxpModHxJ7F4BOsbqskL/I2LkRT8w6vlm1e8Tiwm75E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PAXPR04MB9399.eurprd04.prod.outlook.com (2603:10a6:102:2b3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Fri, 31 Mar
 2023 15:39:42 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%9]) with mapi id 15.20.6254.022; Fri, 31 Mar 2023
 15:39:42 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v3 0/1] Split bt_iso_qos into dedicated structures
Date:   Fri, 31 Mar 2023 18:39:26 +0300
Message-Id: <20230331153927.35411-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4P190CA0008.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::18) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PAXPR04MB9399:EE_
X-MS-Office365-Filtering-Correlation-Id: a91131a4-a89f-4dd2-b8e8-08db31fe2574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7k2sWcYd7uhuH9+TFKlf37LX2kXZFa6uPDoRY19u78NAFj0H+y+yNjr8+XL99GT99REBqsKCHeYQWGYVDMLAQO5wI/gt98EZ4fd2ofoqwZ60scdpieFZ0Nu8O7BoPz4a//3j7hh/00oImyOZi3vzdJAIqAakiCc+kXH/vob+2VO8GME7qMNpXhRiJE34o7Byx8bxK25SsHnQqyxzS/Hae6n8BZ5XMnxwVQdU2DpWasSKeoVamLP5srlBflwnjOSyJEr1Zby4tFi69Nb6C/ss0hyE57Q5fnYVka9ttVNIW+DcstFPZjgvbusSmeg4RenpWUmfOR72Bkm80q/k41pHzgFLKuIsDLFLrP8JF0E41Pjubayt2S3bRcn1QuJUpPSJYBdGsDBli8FDP1HVPxBX9UNRyoxq8ZN30AYbm4/GIbg4hhAESwxWtusFpWoRGKJTA6IU2flJYtH8GMpNTZSMEO7qe9b0fjoa9CoccYAtuMHJhe7/bnWQ9YjOUnDsODJHWiBMZd400e/7Tw6Zm4DhXvuUTJqhfynsCuWu+azMJB8WfGfpVNyXe8RtuSYFb8t/b4A9ROYXYunui5NSyDWnyXCvFp5Nh+Nad4ozOua8tMxMDVNuqfKASTiBCymwXEGD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(396003)(39860400002)(346002)(451199021)(2616005)(52116002)(6486002)(6512007)(26005)(36756003)(478600001)(6506007)(1076003)(55236004)(186003)(6666004)(41300700001)(6916009)(66476007)(66556008)(4744005)(4326008)(8676002)(44832011)(5660300002)(38100700002)(8936002)(316002)(83380400001)(86362001)(66946007)(2906002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?13HN29OLl/+nARFkmXuYCj7ELfcwePAFOjByDTWFJ2ga94F57L1BIBJx7taU?=
 =?us-ascii?Q?FRaX/2V2kvlZ3GgSOkhbwa6ZBvGkisU/kUEAkOfrFzXSqibEsjdt4tdooCEn?=
 =?us-ascii?Q?JOi3F48uGX6s7+SuHjjcRrE8pzV4yKg1TL/sFQI48lISZah+DmiX/R6njOCl?=
 =?us-ascii?Q?PTx9UWz5T4zRNvE4DcgVbljceglRvIukKxo+9kwRFbhMu6xDDpK1PN3nSeKI?=
 =?us-ascii?Q?2M9h7Mn5BCfx3C8QghbHkjgFur0rv6bBgThuMN4gjeckYuH0jHdtV9gwH+77?=
 =?us-ascii?Q?M2eaLVEksTXpx14Sa4lgesa992hYIUlDh5TRhWan/Z9J2j9nVVt0GPO6XXlV?=
 =?us-ascii?Q?+lLWpIC9+0DCMZevyzkewSVa79C7c7YvX7H1mfmRQpa1ET5/vbI5+DVmla9q?=
 =?us-ascii?Q?oIxX6omvbGjXFeyeFN91tAYQCn9YVBW69Zc1z9U1C2Fh1qSg0upjkTqvCYF2?=
 =?us-ascii?Q?kQyx0YFOUzHcbO8XJvgTnVkTcBsRxe7zN5j8q8ZYXmhsXV5Rc4x7HmkpplNs?=
 =?us-ascii?Q?9RYv2U7fLWDv4NgxscLiN9o9lcO23YZlT/yw2KXfjZ4RZOsMKTFbQ8zmB2n+?=
 =?us-ascii?Q?euRzf9g32h6EeHhI5ptLJ99deGIeUMlLEYrPLrvHzcN3xg/8gEWAU7xBAmXi?=
 =?us-ascii?Q?FwGWPrLk2nNhXexpu3AIgNDhV4hLmf/O24NI5oyABJiXXVMyP9S//ozbX8EN?=
 =?us-ascii?Q?Pj5A8NZlKPSGRdyaTGF8OgSbYpF0lC/iqd8q2TxdKlTsxg+8m4o9FKO6n1Zm?=
 =?us-ascii?Q?dsohZd+QpiPd3rQ0mA1xZUy2LpC0XtzPjJg9R7ZR9OBS7QjF28NpkQDSAX6b?=
 =?us-ascii?Q?MPQM4YaUYXJ/LyzHLzHn9BJfI+oJWP7/UocYnPbI1KMzJtYBakIO8zXzqX9c?=
 =?us-ascii?Q?71R/3Uku6OQsBuOkhFG+YRnlqH5ujkUsX+0m2c/gHk/denMQ1spznxMFz8hu?=
 =?us-ascii?Q?weXTKWO3bH+1NKzuxIakzoQJoVePcETwcPscUKxjJ/SOt9TuD2kUJsW8JNEp?=
 =?us-ascii?Q?A/XX5I4/TxFRMVzcC7IbDgCy/PQZn3Faw+iPiRKzruUgaeCRGpdo0IXiB3Tp?=
 =?us-ascii?Q?UasgJ6AevXN/tgXZsdok/ftMap3+Vtl4X4BGoyFPDtpEkUXMcv+QIFi8dKHn?=
 =?us-ascii?Q?Te5dPaWod2r15ioEtAdXP9SdEoUFfuj7qmPIzzQz8Eh8/Q8BSnoJE8t/Fl6r?=
 =?us-ascii?Q?Y51wzk9kbmev1FhVR1SVPGpVqpBTfrGexU0XWuIRUQqa7SJPCFsjaZvhF297?=
 =?us-ascii?Q?MpH/CFubdd5POZZ2n/YOIdPPb9DJ+8Zj38+DDELBZyNNfrMPEIPI0Kioh8hq?=
 =?us-ascii?Q?1BMxAZLGOxLs1nMQDF9OM/7zcDrE/optpnqzqqA/KYRVGX4c8dWrVlefUEZu?=
 =?us-ascii?Q?8CDmjdIFrh0BV2WYt9ARCKKi0mK4F6eesx0B6Vg1x6wgymrSu/VEvNWVD2SU?=
 =?us-ascii?Q?VIqILOWpdFnM+tuwWIx+3kG0/VK9y1MhTEu8kPjUcSHuhc432eC6lYJzLl6u?=
 =?us-ascii?Q?p+1+D6WlH1HZbYfovfVqHleXRI1xzsf4EyGiWq2qXJrjW6/oVnOfsDuQSO3i?=
 =?us-ascii?Q?E1yk8rYLE3iLldtdwZoUQ9ML4pHch8aGv2oVfD/5ZGZZPMomAriwrB/0eN4S?=
 =?us-ascii?Q?VA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a91131a4-a89f-4dd2-b8e8-08db31fe2574
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 15:39:42.4926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pkFoSNgw+pvWOTB/ijbSnAMtTDgluTArSIqk3Gt+VhkuXXxKs8FmYlxYR7hkrc98TvSHzRUmje2TyM41OAqPCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9399
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
[v3,1/1] Bluetooth: Split bt_iso_qos into dedicated structures.

Iulia Tanasescu (1):
  Split bt_iso_qos into dedicated structures

 btio/btio.c          |   7 +-
 client/player.c      |   7 +-
 emulator/bthost.c    |  31 ++++---
 lib/bluetooth.h      |  46 +++++++---
 profiles/audio/bap.c |  19 +++--
 tools/btiotest.c     |  17 ++--
 tools/iso-tester.c   | 199 +++++++++++++++++++++++++++++++++++++------
 tools/isotest.c      | 157 +++++++++++++++++++++++-----------
 8 files changed, 359 insertions(+), 124 deletions(-)


base-commit: 54601cbcf283468ecb867d3db14ddbd1badbe858
-- 
2.34.1

