Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E54C8300C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Jun 2023 12:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240105AbjFGMOR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Jun 2023 08:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239449AbjFGMOO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Jun 2023 08:14:14 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2048.outbound.protection.outlook.com [40.107.15.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23ECE1BD7
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jun 2023 05:14:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBFzn4Ee97oL6XsApGK3ktaQR6R5CkAXmqF9xKdZHlURCgbpib/nzJuJAdveUDAa5N/VphnyZ0G9v3AbC3r0hYCXY/4T0MN+nxXAsE6Nl1k7AGOBJocpuDYgUcFADNOwyL/+809Ru0Wpe5/mPvmiGVYs8t9HgDH7VxoAYJ7lkRJGWBLEShKUwcJVDFy4O5EewwHS/6cjslwdRxovEIVnL08VSSNAp9la0leiEvmGppq/STdoGpOyaemR+dcrGOowkULqa7CER3GnDNg9OAUbIRMXaGb71NXneHhK9Yl6h5adtoZKZh6eLSLFtRxuJHKOR/pW65VaCOcctP/GKHA1Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=521eyav7bp4gKp2h1i/k55Os+cQXokWOz229m/Y0egM=;
 b=S6z8tztr4ofW6BG77QcUG36G0SpjffK/MHx6KedxlsKcmOYm+7QCpf2xdKsk8SFpE2e1mi7lOrXrBzIGF9HZkCK1C7JWyOx9JcYHLAeu5n2tfCYHn6b4uUa6m3MO18lLkFkfu4dsjG7czRsU0NCjKx3P1qNKQOwl33fmylCtSJ6L4ma9WOsoycEJ1DSXFBV/AJNru/cQEEe1gGa0rH9KQ3+jNa4zxH3x0jabQosZvFeHpWw6mQ7us3OQumkQMsmF8ZI2hGP9biMjfdXQaKoTYzc3wo6FeHGSG9SGmJFlcggzus7qKWFeqjNbhtW/azLrbzmGSP4kvEih9Jw1YicYag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=521eyav7bp4gKp2h1i/k55Os+cQXokWOz229m/Y0egM=;
 b=Ur+4LS388gJpzjmbyrMcZlRzzrAa8EVkC0kt5Yj1SMnFqhxqY2CUpbNihy5AlmaDUy1iQdfFlkeq+hXohdCui0QUUxhnwWRnwFRBekDzLiZ3bxlmvqb2kYIqpMuHOQTKDjLZ/oPTODpNDeCSZWF6JhVUrAC28pYag7KKQcJpml8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16)
 by AS4PR04MB9434.eurprd04.prod.outlook.com (2603:10a6:20b:4ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 12:14:09 +0000
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::ad2c:857b:a144:9af4]) by AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::ad2c:857b:a144:9af4%3]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 12:14:09 +0000
From:   Nitin Jadhav <nitin.jadhav@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devyani.godbole@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, nitin.jadhav@nxp.com
Subject: [PATCH BlueZ v2 0/2] Code handling for VOCS service
Date:   Wed,  7 Jun 2023 15:13:40 +0300
Message-Id: <20230607121342.6136-1-nitin.jadhav@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0110.apcprd02.prod.outlook.com
 (2603:1096:4:92::26) To AS8PR04MB9126.eurprd04.prod.outlook.com
 (2603:10a6:20b:449::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9126:EE_|AS4PR04MB9434:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f2e6409-ac30-46f4-4b08-08db6750b276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M+vvueMMRZizDpJEay41Dht3iVVxED+XxMYBnEK956Aacury5iwobyr2HydQuOcTFPcjqzB+1wKvBSxZReSx38bvs2duvQvQPrlmxnNbgChwxOllkjdQezOnlBRnF2Qm+olaoKBzDm0RFgAlRNSNvZCvWK36MZMiKxZp7kysqcMFRRSZs202D9HKp0/CB0CjWDV62R03vFTEaViZBsar2SS3+T7G9epMlIRzeWp7GZ4lbxBGtL33yqlVWSYl9Z4sisgd1j+R7cfZ0x30E9DMzi9n0NGpOpo3MxcIonmMqT2qqAW5wHQFNVJ/UeyGZ2cLvk6PODACHTACX2VSnOMWQ1r8fdFS25Pglv3CveZ02CwGM8ANwpg3NTUBYMTzk6AvqI9tDV0QhfHdFP8c2VG6uYsYL8yV23iEU4LHfK8hzZYmfakm7dljKr/PDjK57LKfDaez7KpiK6rzTdeFzoZFsfhd73X0TIVsIYUaim5E8LM0wJ6JCRd0YdZmJdVTliZbsfsyqa3cRb9vO0aVddbSFFtH6eGXN+1cF1iEvQl3tmNdZ//2qaY2ItMnkXVLM59JoH9oQieiu3E/gWGLIVfL+1Fp9/RG/4+XEar94BOgQXPiMq3hQBP2kiR10lr/J7xA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9126.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(451199021)(478600001)(5660300002)(8936002)(44832011)(8676002)(36756003)(86362001)(2906002)(66556008)(66476007)(6916009)(66946007)(316002)(4326008)(6506007)(41300700001)(38350700002)(2616005)(38100700002)(6512007)(1076003)(26005)(83380400001)(6486002)(52116002)(186003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tUx1Oue8cOtEJtMYhTpN37ODQOc3qKZfVN4Bpy37XV9XE5j+x6pFoG+cn7jA?=
 =?us-ascii?Q?MdsDeI/8h/ZjZBgtYkRD7o5rcSuZlvc4vUHV6NKw4ejadA706U6eBkLPlDsi?=
 =?us-ascii?Q?9g/wlBVpP3HnIQolGTO4VRTF+qK0yoiMtXwW6g9m8s2UPkozuWPPQWaMg3nR?=
 =?us-ascii?Q?iDVxzHYkKuWL30Db3v+uZvbJu5LWUuzr7ypFsTsxZEVF4V2WkTq9tfJRHJDU?=
 =?us-ascii?Q?I3xLVXccG1wkhdSoQtj5mnUQ5L5D60Eb7HfEsKqyW9w8R7u4uSFYtYfJdTrK?=
 =?us-ascii?Q?gxZStA0B14rPD+sVc3ipLi6gHzi9rr4EXQsCUBx1K7xT+/LNAbk6ZxIASFnq?=
 =?us-ascii?Q?ekJk2eiz3Hu5cR4Gd4xu8xlePFRhREQv4vpCocfHyRpnNUcF3h3kRTZ5XKz7?=
 =?us-ascii?Q?+S2FmFSzRQGUapGD0EZhwQ4CtyI3xbwUjHjSvjmVjoCqHZdpTDDAyUwp0SXL?=
 =?us-ascii?Q?FOE9ZIeV4J7oZ5CA8OUzbHnRT7NKQl8VOWM36FcrjzfzhR1JIz8Rk7DyPgO0?=
 =?us-ascii?Q?OPquZUvFITWnf9dT+nHvTB/M3oPwUbLifSp6YLYVL3CRDcnhrviKNM7sKt5E?=
 =?us-ascii?Q?Fodt7DJjsJj5QzYGEOO7I3b57EzYmUKW5Saf3FrnFDZDJ/EvrOprYVDcNmRa?=
 =?us-ascii?Q?WLj5iDaoFIYWXeJnE2Gjzj1Snz3f16cM0DDo/GjPdCCcQgXkX72xnc7LTUqb?=
 =?us-ascii?Q?UCE08usCkPFG70fS7/qlxv8Bqk9V50k81c6g3hmnZhId+6M8aQ4o+Nql8eEv?=
 =?us-ascii?Q?118oEuozjkoj10kQ3bM786USPcSi9W7eaytZeIyipvsEfevzb+86SI7zikDn?=
 =?us-ascii?Q?jdqoZ1TOkfo9syHwu1rWKCOEjbbShEh6VUaP0MM94V38Aj8GMppEPJhoF9Y/?=
 =?us-ascii?Q?kEj7/MJakGdAGbvVPy5+2E5zBA0KeCb2yaFKOZFnbdPPeddD5q0b82HyO1pM?=
 =?us-ascii?Q?4bsR2Kc9f1sK54SKvJVckHkyFNEmGB7Ez7ykYUx4xWwzVgie88I7VTqGHJi5?=
 =?us-ascii?Q?OSquZsumXsD/ZY4KDWgdbolbWBVihb0+JFy588t7jmCbk0zUvVOxFKMX0/Wu?=
 =?us-ascii?Q?7tMp3sPplSDEzK9imTUO9dOo7GHJak3YEI/E9fNw1nvhNZO5PxVxktk2XJD8?=
 =?us-ascii?Q?FVDeubOGnpvYoOmc2pi51nJNNpieITC03rnXFD4hSz7Ow94g3JtkUYYrUHO1?=
 =?us-ascii?Q?HJhoZ74ot5h1A5tvEXBp3BPF/B4n++uKDpEkKDONCL0STI55jBHDIzIC6uL5?=
 =?us-ascii?Q?zQNgKUz2iPp6hj9udaEHFrq7mxt//prXDKFtl33s3MLX6s5FAOUbkM4vOunP?=
 =?us-ascii?Q?uDKVNllQ9biUucYjIr53C1SBEjhFJ5MkzYnNzS/AEg8MvNWsrZ3yD9eZgqRL?=
 =?us-ascii?Q?ELshUo3WbWxojrJE+cVZqWOT+bkeOOAf2QtPFtldBqE8+5z4ln63ttyWc89T?=
 =?us-ascii?Q?2NnLq3A8I/oMXFkdArHDOraO0ywNsTlg0GJRpm7eNwDcKkd5hoKFDEO0TWac?=
 =?us-ascii?Q?ErSM4v0BmThOHsNmkbYn8cwD/nrFZam9gA5QtdY41AFwSvlpt4irm++IrxOS?=
 =?us-ascii?Q?cjBG/HqEH2qoI2qP5MmzLH7G8VPvAZy9VPyk0060?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f2e6409-ac30-46f4-4b08-08db6750b276
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9126.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 12:14:09.5665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qtpWSBM/U+FeCsoHfSWZvXoRNtjJi6ndxZW9e5P0EVGAVmLx3BHgS5+ThmKzSdfK3gV7TzWjug+BJgHJrRXrwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9434
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

All the code implementation has been tested using PTS testing the verdict is PASS for all mandatory test cases.

Thank you in advance for your review.

Warm Regards
Nitin Jadhav


Nitin Jadhav (2):
  Added initial code for handling VOCS
  Fixed the following issue observed during PTS testing for mandatory
    test cases - Specified Upper and Lower Limit for Volume offset -
    Corrected the number of handles for VOCS - VOCS is made as included
    service of VCS because VOCS is secondary service and VSC is primary
    service

 lib/uuid.h       |   5 +
 src/shared/vcp.c | 552 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 555 insertions(+), 2 deletions(-)

-- 
2.34.1

