Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FB4EE7FF4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Sep 2023 06:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjIKGQq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Sep 2023 02:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjIKGQp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Sep 2023 02:16:45 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2077.outbound.protection.outlook.com [40.107.22.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD74100
        for <linux-bluetooth@vger.kernel.org>; Sun, 10 Sep 2023 23:16:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqUpxMlRJ6TxpKfut9c7I5anbYKFonpl0N+us9VMHbDGZoBC12pkETUfCjJmQEzvD0FoGRL79HvPy5OH4+tlZEXBCWZdHkxruQQnL49FrYbuo6cuET1M7pcA8Z8QVukBXxmbyG8R2qyReRqnl3VUwBrwyRd2jg4XANzIcxt1MoIDQCx3fXZfahLCOwj0f8lqSCfCzmkTY0kzsUEWGq2BTn9502uMbWuME2enWrrnbReJnakPFSYEfchdiQDeb6u/NtZrl5Ex+VvhUNbK5OIM43KwJUC1FYoinDw3JZ+pwCiW3k8PcPsn5l/A1Z2g49/gRTwSxAIZK63S7KpE0kRSVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xg/e2ZBbfgV6QLdVqmYi9prTsnAdfIZLKevmLPxPNWU=;
 b=N0/T4EyvSdzekejvQCwcV5v5V2KYX08Od7Jwi/8UdI/LPN2uzKKYRF0x3blUa/sadCW/v9DYFr4l0TUthmJI0ze4DCcDt/7q7NYwgUJA9id5D1G66eh/GcU6+jgjhuKg8W2Xl1oZRw1ZuAwkppYUsaPf+iF+NamNjS4RHz0eMolF2/9mxGiAFRu+B8/BrbRTXpPokEGe+C6dZnGAX3jgJQe07otEYHkFNp8sAtnFv9LqXwLnTjJ5ZUDAvOQcGq6mR6t0EvNoEp8xu4bEAhWiZ6DbxCh+9QFruh5lLRWBmKFoeew+ttorbm6XnwepnWBmWopRtrknhsJdTlCajcoDqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xg/e2ZBbfgV6QLdVqmYi9prTsnAdfIZLKevmLPxPNWU=;
 b=WKIDe7uLbyye38gLmwnQDMPTVilwZGAwlfK7bet9Fv4OLZtHT1GUuIdGKZJXl+xYEYcrExBqFDKhinV7MIPhXQCVECdNzEqgEm8H192lon02N4b3BuS0OTgBAdlGCgH/Q3iXIHRgZyAxre6wyNr49HaAHZAbVnnnqsE/vy4uo+Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com (2603:10a6:102:2b4::19)
 by DBBPR04MB7915.eurprd04.prod.outlook.com (2603:10a6:10:1ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Mon, 11 Sep
 2023 06:16:38 +0000
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636]) by PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636%4]) with mapi id 15.20.6745.034; Mon, 11 Sep 2023
 06:16:38 +0000
From:   Vlad Pruteanu <vlad.pruteanu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, iulia.tanasescu@nxp.com,
        andrei.istodorescu@nxp.com, Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v2 0/1] bap: Use defer setup when syncing to a BIS source
Date:   Mon, 11 Sep 2023 09:16:23 +0300
Message-Id: <20230911061624.30600-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0050.eurprd03.prod.outlook.com (2603:10a6:208::27)
 To PAXPR04MB9398.eurprd04.prod.outlook.com (2603:10a6:102:2b4::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9398:EE_|DBBPR04MB7915:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cc0b4b8-1487-425c-d458-08dbb28ea864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ICGgb7boJbkcg3/IBGbnTWwZnMcEBRk4Dmuj5jqdk7+vrZi0fcLzFQNE2/cqswwppiEPI0v3VPLczym4sk72wNK6VEmZZfLHmcC24WnAgUdWmXJlAvlV1+NpZcO6An4YFK19p+UGT89gdvEd4nkdq+HA3cM3r4bsPcxfmyD8kDc3ZZta0BEeTR/Cqsgo7xkf7LM3Z3QOzKNtyAndU1jE9+MyIaekY7KIglznxrmhf09iSjesnJuCyT3zfDgWS8rs9MHYq4ooC35Zs49rNu6AtPJjuRGjl7j3sB5wp6+cMzWsthT2HadN6YH0QEmQgj+yealZJJIWc2RZeIRUwdt8IP8rkLMzkYiKK7dfzzuju4twv0tZppZcQSAF7Fsql0ovKHGMdIhwR1acpwxea6QB/cPKR5/y2Tq81UiFUCrfVfUdkDaZrx9VI1+U+Re27iixV01ho4MhAJWGac1fdvQq982QG/bhXurLh7+NpxiDFh5NOTUNxOcYki03BAszzClroArCOCRQHyUSur1lI8Ry+11i3wAIak1zzRfFdc03+8HmuBVM0VlVm3eKVnHPKA4qBCETMIktiOncXajxWNkV3pRvt7UL07SuERE55ZGVSqibg7vTilUh1mfXXm1ApvKu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9398.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(136003)(376002)(186009)(1800799009)(451199024)(52116002)(6486002)(6506007)(41300700001)(316002)(38350700002)(4744005)(2906002)(36756003)(478600001)(86362001)(66556008)(66476007)(66946007)(6916009)(6666004)(38100700002)(83380400001)(1076003)(5660300002)(2616005)(8936002)(4326008)(8676002)(26005)(44832011)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A+UuAyAHA/ZRfppT04S26aizQSMXzMOpay7ION38x1XP14MCRTgDEvPTPrgy?=
 =?us-ascii?Q?HZzXZoH1YSNDhoP6KCPh11n2GhNbiD/cxVxst9ILJbjq3f+Ego7j5ia87yDW?=
 =?us-ascii?Q?Unk5W4de3hi6hM8Tb9R+a+MBY+cGwEIGus3Px3amTBTpNWXTN/z0GYm7tWyZ?=
 =?us-ascii?Q?iEimaPMGtpMiGZr3fFyOQzlh1xbKzUszcpbYqaoSB4Ln/3T7lhCjAE0ZJp5t?=
 =?us-ascii?Q?AZ2vFh+wLUN3i2Omt9haqSLIoVHj1rrJ7N+TduEyDo81ES+e6NAqYyLFKfYH?=
 =?us-ascii?Q?r6brsQxFxIWiC+VLuNkKEaLDJDDPZ8HIHYftaCMENB+8rlSIc4rTaraF8sp5?=
 =?us-ascii?Q?O0tqGzWHJ5SvdCv1562rushHPqR+UCa2v2mUZTkfZtLHw8ogDlRPqkCXovLh?=
 =?us-ascii?Q?eXzwJdVAfR7Arkj8/Tdn/v79Z0ubqfajjOgAVl460x1B2AwR8olOqvU4I8rZ?=
 =?us-ascii?Q?4ivKQ5jZqJ3nuzScNuJgBF5lHz/w2FEygYpVYbfLhfhDC9XId97bxciIq1Dk?=
 =?us-ascii?Q?Z3dez0mbjC8w79fhJpgFWbrOtlS15osapWJG0KutpJFP82Ib6Ezr4Tqms3jg?=
 =?us-ascii?Q?ytnia5KyFzf74jt2wcazdFlO59uYuA1iAwRcxlK25LmhMgMQ5twMqeopWdLo?=
 =?us-ascii?Q?DIqjWDgQVlFVkS0dG0eEFt1RAueKGdGQAN7jUD2+lc914mGQ9T6ZHadAaX3y?=
 =?us-ascii?Q?ELPj3g78iyDL4If0ZmDMFbBpGUVY6NGK9d/nKnod8L6unQx89tHq1ebq52sw?=
 =?us-ascii?Q?7TljAGEUKq9wkpeuOBPtDNDZgmQzOTEbPhMOotZC1N8ZAG592YCXRaP1JfPF?=
 =?us-ascii?Q?wgwPDZZcfysUpEGDsJKuCWyPFLQATVszNPG1p3NxlQwpOC8VsUgMDmen+kCK?=
 =?us-ascii?Q?4O+OxCGXMbO0xbrp2VI6A7HjGxsKDRApBjSP2uzAuQ+gyRcs4JEECPUMBB7L?=
 =?us-ascii?Q?f8M+zPgGaYsP4FASfNHbqSjvohcacC1BU8LZD+4R8tzsYwdod5wSTddl7/1z?=
 =?us-ascii?Q?Dh9KUty/svEfpMpFbGsOp/J2L2LauGmUeuDbgjcwfzWfMeyEUaR1zBsLuaYI?=
 =?us-ascii?Q?hm/lPnuqKJtxLey2Utfw+zlgSC3fptaocvhSYFjLDDofHvsl3qIPmanl9nYU?=
 =?us-ascii?Q?XHlj94TArUiw621F1Xyjumpi+SL9brNAMl1zglSxKav8O+/OU6oh5Lqe1JGe?=
 =?us-ascii?Q?FuVXSPMsi7F7sTyaEN/aRXl7gQgvCkhSbvWim0ld5j3mRkh4BKTJjn0WTefN?=
 =?us-ascii?Q?Q+gFgf5+nOZULEtX2Vp/r9TuctBIhY+m4BGuFQ1/H2K54Kez0aIsG/5yNI/N?=
 =?us-ascii?Q?FpMVSytvzosZq2C9i9JpxLmxSL14CIs4v2GAo8QSB/22thpJXH5DvOX5Y+0D?=
 =?us-ascii?Q?BqKefniGBUIPVBPEM1yGuo8vEe/o1XJYaPR8tRy7QpM6ICZESeNdMtbLtclJ?=
 =?us-ascii?Q?gyiiPU6w5gSxHnzyYW77JxY98qswRdgNzbxh4h7oPnvJoigLr/MnJNlrV+Te?=
 =?us-ascii?Q?BrDBc9DBtsHWgiF2evB0e7ihcZH83pY6bwmFNXbxefJF2IwjZdDBk82kmQZ2?=
 =?us-ascii?Q?A1u2q65nrNEjHXfotdietAYH+i/6l7UuwgAuTbp27v1PxlbZP8EGNvzaoU/e?=
 =?us-ascii?Q?gA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc0b4b8-1487-425c-d458-08dbb28ea864
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9398.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 06:16:38.5809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: stJdjOl7WS+/B7GSy+eZM+eP43t9TseyF1kGzlATMLpNCaRGIXhbAHFoOxjPUrP//tqSUsQGQ6LCiiwqm3ptzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7915
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This commit uses the newly added bt_io_bcast_accept function from
btio.c to implement the defer setup for the BIS sync process.
Now, information from the BIG Info advertising report can be
used when sending the BIG Create Sync command.

Vlad Pruteanu (1):
  bap: Use defer setup when syncing to a BIS source

 profiles/audio/bap.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

-- 
2.34.1

