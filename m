Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883CCC7EE29
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jun 2023 12:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbjFHMKT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Jun 2023 08:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbjFHMKS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Jun 2023 08:10:18 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2044.outbound.protection.outlook.com [40.107.104.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D7A184
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jun 2023 05:10:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7Vip4TMDGrgfb5f9GfvxAlWWnIIRlwR5cfEmuEx6YvjY29A38+ytnsNNzuYOR5FmSGU3hoIS0UrDuZ/T9z1m2iEYkOK0vRUH2H/gdV+8qeLwf20R4pEBZcYht7OJNDNzTJdgFy+8nX3F/2M49aPkMhKbWHWfTfBEd8wqzDIfOPjFVcGPk+UKUB52z7pHQ3PbcJc9DW5EFh9pQdqUn4K7Icfaa5DWcb6LVG0N6Vg/iIJPG8DUhZRxbFxkvpCZmdr3WFGsfKmvGUG/5YZDo6QyVy+HpDkuuX3TxO/TXi7KlCzktlJKsYciWoLF/WX2y8S4hIICYgH+ndypq2z2tf4Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89eWLGcgbKdj1/jaIrRRLRVRHqex9Z269U7abJva2hU=;
 b=OwmqDEyxuT0njRk4IuvrTyZNxWsDj6IeLhNNufqy+vbSdq0eJEgfEpwYM+bcrOf9G62ahCCzrjujxIVZIkkymSqrzYacQ8ALrsZhnqb/SMLQ+ab4qK45b/D67QOVay9Oir0ZOvluiDWY8NiFJCrNPB9GpjEAx2BKK/iVOS6rPZMgn8VoDs1ThfH6d6G9uudZB3zrmqAs5JxZoDdT6WIC1GeNHU2s8qJpH2vWzLTlefYamXhwuyInELxbfSvwokuqsojnlJz26Pru74CQ76YmaJfcUGnPGJNuFsJTubRexsI7vc2O4H0xw0vxoAxePmrZlX5Xa0OggSD6IVmn4PyonA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89eWLGcgbKdj1/jaIrRRLRVRHqex9Z269U7abJva2hU=;
 b=I4/79abbkngKDzg/Hdenz5J5Ilm7banlGfW+oDlLwmDEDR7Zpo+0NollnEDyFU3Q9kNak4vIX0Dv/v5cnev+E/UlUk/zaHDJAKio7ttC1tNfxXVP1/X8rTfUTULeSxZIxG952TmXLY5iMB7ZtRYV6onYrOHn4SmUEBzJrXEsjtI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16)
 by PA4PR04MB7597.eurprd04.prod.outlook.com (2603:10a6:102:e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 12:10:13 +0000
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::ad2c:857b:a144:9af4]) by AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::ad2c:857b:a144:9af4%3]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 12:10:13 +0000
From:   Nitin Jadhav <nitin.jadhav@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devyani.godbole@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, nitin.jadhav@nxp.com
Subject: [PATCH BlueZ v3 0/2] Code handling for VOCS service
Date:   Thu,  8 Jun 2023 15:09:43 +0300
Message-Id: <20230608120945.4478-1-nitin.jadhav@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0114.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::18) To AS8PR04MB9126.eurprd04.prod.outlook.com
 (2603:10a6:20b:449::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9126:EE_|PA4PR04MB7597:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bab3cad-4892-4f1f-56db-08db6819501f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f8IL1dG9XjtBeWCxfml/StTn20XN+D+kUB+zFR5ApLZq/WLekS9v8Htq/p89DK3TYSPZ2N/q6ske83eEK8YGtjm6tGvctwTKTmIwc7xQYR+JMcQPzI0hCUjfeAcbhq5PwoR4S36XlgugkFTRU+LLdMkJ/kKMB74rCxkoR7thYLJcrj/X1zPWkkMgdH85zXKAHmQtADil0wbsljJ3nDXuIiXoW+naIMiP9YBzdFNPkqCcVc3o/1NnlK6GWVdlWKVUjmA1nBpRHuXRtgWifyoONQYiTSweHJhzTGg1hDRCBYL+r0A74eQ59qnqAbxovhDCSYtuB9Dyq1zUb/uJDbT/xeQ0mn90ETrO1I5O5hn6xVwlTd3gf9cYHtvefNqYidl4fPQZW55kx+Y36kq8gx0+jcDhj6MFVJTBth0KiRLaN3IvLaRXU2fAaQVcKlZS9z3Zqhi9ImWFR8yXo45sfnjKxsfgiMThqPowlxQ73H8+1Gt9KST94zTRpH5lmvrZRbHOU8D4unz/kRLtwBqWjC8IgIPp8c1oqpOiWxruBLER9V45CEtEOF4SRxHYkvLKiBmfPpORYB+zm+tch6iivpRZatcwEyf17mzEEPlYc4Gq1XSBFKUPlQHEhOo0JXONjgRu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9126.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(451199021)(8676002)(186003)(8936002)(316002)(478600001)(6486002)(52116002)(41300700001)(6666004)(5660300002)(6506007)(1076003)(26005)(44832011)(6512007)(66476007)(6916009)(4326008)(66556008)(66946007)(83380400001)(2616005)(2906002)(4744005)(38100700002)(38350700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PSanFpZDEMuW1rZD6dP43K9kTELefD0Ms35DhOEj5zwEQayhXyyg4Z/cz0LF?=
 =?us-ascii?Q?QW+b+XTzsR6XLebItFUlx3WFAn69DgQWlZaf44IImDCGHL5LtCkZDLaf5CHa?=
 =?us-ascii?Q?HPd/ldg/DIyMW8u2HT3aAEsbIkPjCpKxug6IrQE/VfMuKaTvlxvKgtRFHaf5?=
 =?us-ascii?Q?U7+LGBQ9qy1iLLjY/FZpmNNhL2r91l3YPqz4wtZsrP4xWAxDZnUug+KHF6En?=
 =?us-ascii?Q?7G8Olv+dPNzHEODwu62QPDN0ipiKufoHYHEwn7E3xwNh9fLG60pUQ3WQLgIn?=
 =?us-ascii?Q?vlX5E8SUhSLfpZOa5g3nZ24zd4YT8UhksNtkKhBnw0E7M8In9DZAaD5YxE/r?=
 =?us-ascii?Q?oWVZWARJq6A63qdRn152U+QnbwQPnTWbChbJ3q3Iu2WCTz6ACJctoIFFwQ4m?=
 =?us-ascii?Q?1q/DTmSeeWFowgZITHjd8pmAdXTfKRQ9AZYY8D2EroEGLRjx4kV+UCPeSqoS?=
 =?us-ascii?Q?lk85350Pl2c5u2I4hwiR6QL7aMQ1qyy7Pxm3gXIhE639PUJWa6+PeDyKX3/i?=
 =?us-ascii?Q?osB9EZ293qOA8bLw4lruAcM6BrWnzjGdh5hEYdIYy69+jU2LVraywg1f0pcJ?=
 =?us-ascii?Q?k6UAnmaQVPq8rx58Agp5MQJTbTg/Esb2jNaKqWWQXNukGqVmusjVm4rH+1QY?=
 =?us-ascii?Q?/TVy7p3cqHodrOxidIz0S3BD0xwfy6KQ4D2eHONYaRiNxkdxE6vyYlyse035?=
 =?us-ascii?Q?ELML6KLPBLazDZ6GUqCBUkvJaOfIJF2E3ts4uHzQzlBEOVytpqMDKojotI6v?=
 =?us-ascii?Q?5uPq97MuwZZb64YfsFJ6W8w6SvF4BjDAv/ITLR8WtqRYx92k737OGgaquiTG?=
 =?us-ascii?Q?MEQ/JRM0kI1AcE7FrRSOFFIgU8Sj5T++S7ko+vTeBLTa0EF+RrjLtQPRBklB?=
 =?us-ascii?Q?rQ/GmOtFywPUHzVYqlt9mgiy8NEzEWyyVe+raWZfClx4UzOWjDDJOadQpYQq?=
 =?us-ascii?Q?15DfN8U0G3uLl+2o9JVOTZjrYk0HBG/Z3+ctotJom7fbUb/dMTjLYZlEtqMQ?=
 =?us-ascii?Q?nUQHqrv6C6WgRSz3ShIFwGTMklwgvRaWLGVy3/yo8I6iQtHrMgfvtQ9iJ4ZY?=
 =?us-ascii?Q?dSrUZKOcF9B3l7f+3ioZZ7QxKrVOPPK3gpHC3GR++zMHQQdEdH4Nb4HJfsRc?=
 =?us-ascii?Q?OK1sznGVqF78SUJoHh8FOputVw5B85vJMmC+dUlnysdDj0VDjdFCPWBdSatc?=
 =?us-ascii?Q?LMQH6sRSfXpxDzQCPOQhstCgWR5aSVKBeEOgLzUN4UwfCYryDCuxWlrRLHgK?=
 =?us-ascii?Q?SrtqOnK4keXjoWhgbDAcRR+Al5CbgP+DnfUURIcTbozUQ5b9Bqv6S7qqsdSF?=
 =?us-ascii?Q?70FsljeKQCqzhHBKi4SkNTl4zG753qDVC/2vlBTmui44z7qWgta1NH9W3qAh?=
 =?us-ascii?Q?CkuX3SJA+/zV5OfYqYtY8jLBr0ZYgE2ilzrJ+NiCQsmQbHtAWzcJD3Tys8HP?=
 =?us-ascii?Q?Hhz2F7h/iKOKty9inu/DZHInIas4wGftJO/wr/5B4C7TIaY8pxlSJ7T8LLLH?=
 =?us-ascii?Q?b7l/HBPz0kkkvln+1s5jBiHbdtI9STzOqb5choWK7EdxG/5/0qnCzBE/1rNW?=
 =?us-ascii?Q?fgDMw2tfO2ECpQfnudHi3xSTNgx4BoMVRt2zCxm1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bab3cad-4892-4f1f-56db-08db6819501f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9126.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 12:10:13.3994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GDSIhpWHecD4OP/vVOOv83s6zq95BERCO6VM0Sicrmm4ekHxTtBxzPY5bF0YJ6aZCFc6qJjVRi39H+S+CydDuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7597
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Maintainers

This patch series handles code implementation for mandatory features of Volume Offset Control Service.

Implementation of following features have been handled in this patch series
- Volume Offset Control Service
- Volume Offset State Characteristic (Read, Notify)
- Audio Location Characteristic (Read)
- Volume Offset Control Point Characteristic (Write)	
- Audio Output Description Characteristic (Read)
- Set Volume Offset

Reference Document:
- Code implementation is based on VOCS_v1.0.pdf
- Testing is done using PTS in reference to VOCS.TS.p1.pdf
- The verdict is PASS for all mandatory test cases.

Thank you in advance for your review.

Warm Regards
Nitin Jadhav


Nitin Jadhav (2):
  Title: Added initial code for handling VOCS
  Make VOCS (Secondary) as an included service of VCS (Primary)

 lib/uuid.h       |   5 +
 src/shared/vcp.c | 563 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 566 insertions(+), 2 deletions(-)

-- 
2.34.1

