Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA90ACD6E78
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Oct 2023 14:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjJKOY2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Oct 2023 10:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjJKOY1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Oct 2023 10:24:27 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2077.outbound.protection.outlook.com [40.107.105.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14ED690
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Oct 2023 07:24:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCCs90LE0sNUI3IKt+E5GZ2e5xVaJLTiBbejlHofaoTLXN2BNUBeISyLPDbjLq3knBbrQYOrqZ2lkSo+Vcsk3+uAdUQlWd9zoYD30VfOZUco9j1IJ8OtlyWFPHXciLzTl+QKkQ/C5ZtX64bK6xrPNfkxNayrKPmGo9vfjCJGtt/39zni89AD/8UYHTF3h5rQ5WfzNbezBhPGmrHBZbI2EPn+eLC05BqY35Wv7dwAKxhw5W7zOnN+EsRYlo5GuiI/0I8QjZOHQ87SvBnDza7ik3I26wXaOgQYJ8C4v00QLq7dOACvvqEsylmcR9/Phu2aj382+t5WFryYX3zAj4LBbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xi2+QY5/lrISRe7IdQWQOiRKNBJLdVji/5Y1H+XYC2w=;
 b=NiVgVYN4V1wnkuj4wTRjGR4CwmEh2nx30MYoBFM7rYhKmPLwvJOT4+OZikRkgPLYGuR7rbZBFIiaWDkMya1fGLzL+SZu2EY/YZlZw5qoagL1Z8u8LsOy6yY8G+qZm3HjwOayHmp62mxIJKEb495s9d3wCrZ1mMjQ5zKiCelfHdw7BN/l0tcXi3LGez5oQ+sHWaDY6Dr7Uh0CBMEw3x4XlkH2WDbuXXsDtzFF2D0U3q1POW44bu74P8vZrgLEhFTJcV1ndHH1YeqY3K3VtlpltTXjuaGVLOlxzNe6waDygoOcL6fL4uhkvaLk8QQf1yuBzj4EJQGrD6ygFqIu4iXjPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xi2+QY5/lrISRe7IdQWQOiRKNBJLdVji/5Y1H+XYC2w=;
 b=BoFqS0Vd2JX9Z0eviZvzec0SPA5F6iQ5lfGtjoj4BB9uWt1S6xR8HsNnn30ltx2g347nYRQBlTKKNvRpt+kE3VMRYFupwftJAzM6Wt3T/Xd4n/Zb5aA5H7toZjAn8QjNpm8ZvZDXe4GyeNH5ZHAvciZZCZXFLxb9953Z1H0rarY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VE1PR04MB7471.eurprd04.prod.outlook.com (2603:10a6:800:1a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 14:24:22 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 14:24:22 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 0/2] Bluetooth: ISO: Miscellaneous fixes
Date:   Wed, 11 Oct 2023 17:24:06 +0300
Message-Id: <20231011142408.5529-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0129.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::13) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VE1PR04MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: ea61f3cf-2487-427e-0041-08dbca65c334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x+y0Ahnw4uFmTLA17MZjSGpsfGDzdV8GZZTcl/s5DQKvrTKSxMdmaBuglJMfMNR5FLynubTvG2n4TS12bHoQRZRycyuxrJ8zKk2hItXKt9WRQjJF8ApKr+FL++QDJKlgdfeuvMfOYV+mBgIXTjuA8Obk47vL4Gk8R/WO9UyFJ9KG2Pe/DKBn1fbqUKQul0h23th30TkNGqwEsQRYAZW9bIpqWAvn5A7ixopnqrlQObYA3hiAIaBWQTPvucYJFwoRZ/6H+cR5Vl0Dsd/RwELB5NSjvXtkib1w7gIbB5ryFm9wKh/e3JESdDpW1MVojrgPuEVW/UfOLGGM02xPIxNo6GkWzQH/97vn+tsOglw0qHTWswDa00Yv52XeFndNu0iZQtgAiyQlgZ6PvYQederyT9zxg0l9+oFN0aWEEUbfhADSZvSo3KkRQiDeJ28RWr9qUkLvFnLu2oQW/B39O6iRt0Uag7fArAtPWtagPWaWvjQEqasKt8MROsdMBRrEX9rxWZ2M9+IoUtPNnGvyI8adEbeXA+o0wtjj1tJj9DldJCa18oNxogSOQXRBNzbLyKRg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(4326008)(41300700001)(5660300002)(6916009)(316002)(8676002)(36756003)(8936002)(44832011)(2906002)(2616005)(26005)(1076003)(86362001)(83380400001)(6506007)(6512007)(6666004)(38100700002)(6486002)(478600001)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fVr7nuAFFMFmXofTI6Ex3a5yFZ8Ke0qtipjMQKq1HlAFCspaUhtB6Jyrsn5w?=
 =?us-ascii?Q?caWc3pyh8lHOu8xUA7tHeUKZs+BCcAlVmEAdEtrR5Z9evdOC0btHZ81IrzBm?=
 =?us-ascii?Q?jnHiVWUBV9c86RQcPRQj8QXAnqeax5Pw8GOFyqjwU4GCarhSDECDfdpZNVQX?=
 =?us-ascii?Q?G1TIWO+buni0nKMGLfTic7wFvWJU3oNBQSLXrTziCbgDgRXzKpgk0rmOCLl2?=
 =?us-ascii?Q?h9EDXq9WjIOjho3H524OCYFO8MoSclua6wLdLjHTLo2adW1V6I/zFU8Q2FIe?=
 =?us-ascii?Q?6iil3NtTt4xJkw5gMZQY+A3qsd4mYP4aMB6sUB0W+Lm7e6AjgpkRAuHnj5O1?=
 =?us-ascii?Q?imLfA/3/GY5y/6slSZ0g9DSbgK+mzOF+DVBiW42Tr5MwdqRagk3MmrHIZc6m?=
 =?us-ascii?Q?z5yTaX6tuwxwylHpN3d43DZWfMipk28Qa0vaQtBJha9Go0swgJ9DEHZ/RSJG?=
 =?us-ascii?Q?//YYYqYXyMe9yZ6boRlkZYwasGSHlceG3QE1Cf7+va4D08Yj8xi1cOHgArPj?=
 =?us-ascii?Q?2P1Fh5DEEQIOkR2mxL0ezC6+zGHxHBGXRSweVBzaqKZQIZILQy7n4E3fdXY8?=
 =?us-ascii?Q?cxTQyGFtw3H375Ddxyjo3QJiidbt5PzDuVkwQ7LP1DlHzr88D5cWIERPLKdT?=
 =?us-ascii?Q?RZ0aqHv6uI1Jj77U67uwDcks8vg9D88TGJ0pt6o2+RNLqC6Qx0to4cRt3yEM?=
 =?us-ascii?Q?iHRtXGiW7CC72jcGTR05r5ZPeFUPH91s6ISChIiIXv8Il/tITkpjeAZwKRS8?=
 =?us-ascii?Q?SvLlT5FZIC08D8QWXoKJyBaEeqmqM4zRMuJIFs4dnJ2Ph9QOCa4BEInqrNOT?=
 =?us-ascii?Q?csNypMewK8MtgW5dnGiEv6W78i8RAIz0uHt1J71mlK9HDS3+XVwXPwlw03iz?=
 =?us-ascii?Q?9mFU5q51YVvzVXqvQojAxxmtSUq/IGRllzw+DD2pItpzNpVIXNsjE6LigAl9?=
 =?us-ascii?Q?Np2DdOgaMSECLWcGgAcrOUCAw5VPHFp57v05czf2ywA2tOuFvz4V2OI+fQtO?=
 =?us-ascii?Q?5bpvBVaP+rK7vile6h7tlYospWBLydi4RmjBTG1m2db6A5vi3t+ohTVmONf0?=
 =?us-ascii?Q?qMSNDdENw/tJYZ+6ADYm9kRnA1A6YWfiiMvehTI8MkDxCJpoCX5L0Wlf+OfL?=
 =?us-ascii?Q?Q8t6MtH1tDQb8R1rKT8BYQvRh2PGJQy8OwygBoQeLQF73EBx7bFIAZUp85Dq?=
 =?us-ascii?Q?8Sdi40lBTCRz29YcOMbf6NDtkRrnzueiz3gS2TwXH0DYsiiktMg25qz5HiPu?=
 =?us-ascii?Q?Cjek840PuQ/HPLGMgPaboINGKlA1SSFnUlzt9Z85jEl4CixEy1O5N6F3YWlr?=
 =?us-ascii?Q?AHm+hRJov0tx5VOTFW7mEeAwZNOSG5lcIgvNg8bgmHUVP1P3V7r5BXF4LG9j?=
 =?us-ascii?Q?U+jp2/3X6g5Ihijyrs742dciputH1PNFd8XDUyRHvRAxnJromcbtrxpzvP6Y?=
 =?us-ascii?Q?ON5Vf6lmjGpn9N/v3KDZmN1/tOJMdsyR20XFBRaMvt0DGojGuDPTqIIJtpC3?=
 =?us-ascii?Q?YF56aCLCNQfzRJA8ZTPeXFLF8MwkRnj6mIRUVvtaSL4DH5qfP7nSN2wkGtwx?=
 =?us-ascii?Q?6ypstDQyegpD41fysKGqc7TZY5/f40FIb6L2lux/KXSgROEFzdPZw+rmUmE1?=
 =?us-ascii?Q?bA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea61f3cf-2487-427e-0041-08dbca65c334
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 14:24:22.0476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IqbPeie6QITZ/365fY3LTAFFFu3s346rOLocCuZ36agPA2Hj7MOl8oX0wI/rqdzSSmUXZdicpB6A/4sFJEUtkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7471
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Currently, slave bis hcons and pa sync hcons are marked with the
same flags, so they are handled the same at cleanup.

The first commit makes it so that closing all bis hcons will
trigger BIG Terminate Sync, while closing all bises and the
pa sync hcon will also trigger PA Terminate Sync.

The second commit fixes the way broadcast events are handled
by the ISO layer: A new slave BIS hcon is notified after the
Command Complete for LE Setup ISO Data Path is received, not
after BIG Sync Established.

The iso_match_pa_sync_flag function has also been replaced with
more specific matching functions, depending on the event being
handled.

Iulia Tanasescu (2):
  Bluetooth: ISO: Fix bcast listener cleanup
  Bluetoth: ISO: Fix broadcast event handling

 include/net/bluetooth/hci_core.h |  46 +++++++-------
 net/bluetooth/hci_conn.c         |  38 +++++++++---
 net/bluetooth/hci_core.c         |  50 ++++++++++-----
 net/bluetooth/hci_event.c        |  10 ---
 net/bluetooth/iso.c              | 101 +++++++++++++++++++++++++------
 5 files changed, 169 insertions(+), 76 deletions(-)


base-commit: b8ba8e65e84b99d58e278900b4261ef17a20eb27
-- 
2.39.2

