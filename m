Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7D6CA0EC5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Sep 2023 21:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbjIKVQx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235628AbjIKJJn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Sep 2023 05:09:43 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2059.outbound.protection.outlook.com [40.107.8.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9861CCC
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Sep 2023 02:09:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9qte0x5sdznuRMkFOjc7mQYSvQu5NWx/MrQlcUUYakjBjJAALEhIi3Ty6SPvG72fST95otkAGY+pMALYA4WWQehq5IAeVQMPMjm1BWP4j81Lo+/ci3uUlOh5L13JIiDkEA8JhVIB64vIvsoYmYmvWvsLfLOi7ZDW+gEZDWaQpJTuUm6lv97AdKf0AUoNMkxRw/Nc/y8tG11BGqCKh/LNa0JgXwkxcUi5mVc4wmjOPZfQ+3indCImePHbUuthmAzYrpUu4QwtU+6rWgo0X2DIf9Kidobx+96XdsuYOHtoV+Xe6BQHRzqeSXk1ja0WE9/2yHTUO3tMIrG5LsUqbSbvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJMwPSQ/SPAFMzgkbEyUOBCF7getvmQG/d0BZ/wzTBg=;
 b=dHrkmwBMTDPYIcCNyGIZ/c2NUb5nk/LjI2PDteX+l5ZbBQkJMiOjluFvetnUpxmY8tTrI38R0iQnIFOy1sDkoa6//sSnJxow5V143e1uRDSqqp5tZIdrhARgldHR7xP1v2RNX4zkh0wegrHQsfKQEP8jI9XvW216MIoZR0XhtBnA2exKzSARKw11KNRSHwAHV32Ob1b4cpsRaBXEgpV+KqVAxDR4N4Vi32EttVqOQq89VpImUvPdJplOMb5Y+MPzVcTTqxODItDAeG9IfC7R8e/BgLXAaLZ8M6QSIt0Gek4WH+qNrGtDYb94pM/z9BJIFEWj7l65pXFLSvNuo5Av9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJMwPSQ/SPAFMzgkbEyUOBCF7getvmQG/d0BZ/wzTBg=;
 b=YRhBFgaPcXrbz0U+UIZZzKpCEVSx5KvEWiq3xQK9BkvsAqmCgATfnDTolhn64ZkDFE6JJm/cVRL+8VTGtrz7me+ciHlWJ1E1WEnI4YBEHPC/cbWgRkwPZTf45ImC5i3tVOxCpQHFkZT2NveNExVcTQg/dHNZ4q2tBvBnpjEvS9w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com (2603:10a6:102:2b4::19)
 by DBAPR04MB7366.eurprd04.prod.outlook.com (2603:10a6:10:1a0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 09:09:36 +0000
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636]) by PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636%4]) with mapi id 15.20.6745.034; Mon, 11 Sep 2023
 09:09:36 +0000
From:   Vlad Pruteanu <vlad.pruteanu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, iulia.tanasescu@nxp.com,
        andrei.istodorescu@nxp.com, Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v3 1/1] bap: Use defer setup when syncing to a BIS source
Date:   Mon, 11 Sep 2023 12:09:21 +0300
Message-Id: <20230911090922.68822-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0003.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::16) To PAXPR04MB9398.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9398:EE_|DBAPR04MB7366:EE_
X-MS-Office365-Filtering-Correlation-Id: ff42d694-c1b5-4221-be40-08dbb2a6d1b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2c+jrydY2Mmc6DxlbvLFP9lsp6OKIoK+LoPMR3lbY4jbJh/yvtlMcTTyBFIygKz6lg/rINc1S9J7gxWVykKHE9NGPcyYx6nkKKWM4Fldv+6MpSlQUhTE2nsS2IbJYx5wG6moFwCY//M+NhqIwNqB4KeuVHimZOKS3cwkjynCDMSwZfJI01ChIwAGNdF2B6zz4S37MkjBsZWTNnO5Zx4ow0UobGCiopGj/0wpvVrVkt8IEQuv1gtuNvc029HbgMf3GT6u9/x7XwhAdFlzuqSh9MZkEZutR09tJoWo60bUTWT/VhqiX39QIKsCwEE3QdJlxVxTziyFVSd0gPO/AbCm9JLSwdVna4RYBetNJtTYTCpuJjuZuFu10bFRUeeK6I7aZ0JIORt9Qa6cREW8qNcWbwKDoBIJlkSQEdR1OLMo+Z6CE/M0zX5VFOAefe1q7nqRaqiDNe4EIAFqveTzQLAHpEAQD+vSQqga8KcCD3IWyC+Re/vFCJrK4QFSpNeL3Ao9X9CT/A4gyj7vXtITc/Sg+LgaenIp1Hj8qN5ohlRYyN0PqxkFBPWDmW/D57+OeBUeXKnVxV6lRdYC2VUqqH2zpJoBiu5dH4CGHwpQFH9H1Z7j7ImcGn9fLtf9sIHwEGfE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9398.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(366004)(346002)(39860400002)(451199024)(186009)(1800799009)(6486002)(52116002)(6506007)(6666004)(41300700001)(36756003)(86362001)(38350700002)(38100700002)(1076003)(2616005)(4744005)(2906002)(6512007)(83380400001)(478600001)(316002)(8936002)(8676002)(4326008)(5660300002)(26005)(44832011)(6916009)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?niO1qSKUoigaQJuY3F7qwp2B7+/tqn37sqBW4SWNjuiqTdLPYToL6NWw0jj5?=
 =?us-ascii?Q?/2vwXkNrCobeGwZTnwou1u+9vtiUMLvxee8n4NvPHFUHNWgTkpX8u5alqXnB?=
 =?us-ascii?Q?kDVyEbYwZVVA8q+kUAwo6RkWSt+iAtTvcvkCVbr9aXogezeGpUUcqEvmQ9Qm?=
 =?us-ascii?Q?yS0MSPCR+aqDfc+cH3nM6VQj1npJTceVg7rGqv4YKNGpWMixhzAfx3KjM7oo?=
 =?us-ascii?Q?zi0hOX/pci2/dILyeR0icoKeKDtr85frNMg42CyJm2wWV4Z+KiJMGO0f3zEB?=
 =?us-ascii?Q?EXkxspXc3Cpp5TIy7pHJqzqkgj52CJAOQSVh7mrlGEp7RV4aim463ebvpVNg?=
 =?us-ascii?Q?gyxLZPx9O9BcZua6V2GT6wJqXyK7mqK9o6LDJyj54oQx/lmb64ovMOypfAPV?=
 =?us-ascii?Q?+O24bVbQGlWuEB7WaZ5rwHM7kXHl1hgtF+TrvDBo3XzfnvL5hyv+ipqnm72u?=
 =?us-ascii?Q?BUrZ2x/2yxvAimP7ZCplQcHc6FyXJDZqk5iSbojp85ihwlMrqpxUNSKvkSOJ?=
 =?us-ascii?Q?Lzs6MOWyO5dkLEgyu2PufwtLHLdYecHKLSevYx0qeKEHutxkvNabSlDT5PdA?=
 =?us-ascii?Q?cM33woHJbItvRwFX5MxJALU+5avswezU2IiRnEStX2pdWrpsNEEjPfldIVB7?=
 =?us-ascii?Q?Vah5JVDUEfZpsWU7Eg2q8mXgnjkgxmOlqDv+6qhNIYxp1UY3Jfi+uh3suzL6?=
 =?us-ascii?Q?fABvxiFccRmyvxM2s90sqpWZknTWI5diPqq60YxX1+IDVoItFfAOxa87ehGT?=
 =?us-ascii?Q?2PDJgX8JEoSd/YhuGyox3L6LD5dqPiJut2wpIdK4TXxGJjEReESuwW+DI1Je?=
 =?us-ascii?Q?/JLO9g7U/PmhoMHYjUCJoJxDVY8KWFNgkIw376pfbcn/DbYWMZZvx3moCAAI?=
 =?us-ascii?Q?FqrUtDQLlFprkIWtKIurZhYzD6RCCOA2uM9gTvqvHBZbdEtFyEhb1JUwlyVL?=
 =?us-ascii?Q?CWvKWx41sRLPPMtYyoMobXjkrgqMXsT/AYdTOz8+is5rjePIqo5auiJZRJz3?=
 =?us-ascii?Q?u+fyxCxyi1cNQ62byf1qsC9L0Kcuz3QAsc/oboU6XrttEPEUisDioDtz3gc4?=
 =?us-ascii?Q?cxwzXOmEUvgj49kOZYItBvsZq2WrGc0PVts9ofkU21tCdZhW60AtP3A36I+N?=
 =?us-ascii?Q?32wy7zQY7IpB9TMUDmbT3opWZcETp+LMz7UVJPg27raN2doO6RnCz5ecuFZy?=
 =?us-ascii?Q?kfL8qQBG4DqZWWUh9a8CT3Fck9ozuIB0oMCZvJ9ZWj0NRRI68YmO78jWcorq?=
 =?us-ascii?Q?Vr76vnHlcWojbSNtVSmyQqEjGEHyeAKYBcCzyEQarHI3WpJiEPrr2XZhLc/i?=
 =?us-ascii?Q?5y097EncZXHBE/FnSZvf2JK+aeocvSUr9sULTytSt3N+IxwNXrKaNM1P13VN?=
 =?us-ascii?Q?9JL+ahawwj2kmpj9s2K/rMoSBHnyRxl1PMgfLcz2LVRe89Q4Sr8LOyxN1pQ7?=
 =?us-ascii?Q?A0RKpwN3pwKmBMR5qWp9Je3QHvFIIdSjcDzNUj1WqfNBWaWexVGI7CQv8BMX?=
 =?us-ascii?Q?QCxxTerbi2Zk6htGw9U5FfOnE2H5qvE62W9kxgN0BbwVNaqzvkmIYi8oalTD?=
 =?us-ascii?Q?XhkSCDdrFx/KRdIo00HyNItZCa/9XQ3lFQZXKEvuVHv+xk0Wk1pTfz/ZIszG?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff42d694-c1b5-4221-be40-08dbb2a6d1b8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9398.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 09:09:35.9870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mSckdIe7ph8nUWfSqgia3YhefgQymcj1+BwJPWTJQtyT2npksGb5gdFoaUnGaByYMjnQjxO2LGDbioZmVN5I5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7366
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This commit uses the newly added bt_io_bcast_accept function from
btio.c to implement the defer setup for the BIS sync process.
Now, information from the BIG Info advertising report can be
used when sending the BIG Create Sync command.

Vlad Pruteanu (1):
  bap: Use defer setup when syncing to a BIS source

 profiles/audio/bap.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

-- 
2.34.1

