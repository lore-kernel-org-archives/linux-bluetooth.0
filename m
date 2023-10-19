Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6527CDB465
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Oct 2023 14:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346295AbjJSOtx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Oct 2023 10:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346300AbjJSOtk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Oct 2023 10:49:40 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2040.outbound.protection.outlook.com [40.107.8.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCDE193
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Oct 2023 07:49:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nI4EYThystlk2NSk69PZlE1Tg91uqBw0WWRhBeKcFh5h+nROT3SSvtIuRZ5QlzhMXnCCQZ30n24cvolYR4pLRe7ngPF4DfNMYDFrNJWkBafIA1HUdkJVLRhaulzAj6WdjPEV0yggQU5RHeJiWI0DQ8S2/NMJj/1NYa4WI69c3ulHszju9SOWR3KSvrJvFqrlgpr2QuiOBGNLoRy2Hi0sjCRcK/SwLbsCN4B6t4CiyeoHVSJGpMYQxpT0lmHFgnDrMjI12pWiQgPNWI8K1bzEAH1KjW5j7dvof0TJ21RqPJz9oxg+ZrcbGWQahScPkdCqu8Ti6LlXeCQLwY56LpqKpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSeYPKiTA/X4hTURzqBQCRD4gzCWNvm4uGz0eYBPHLM=;
 b=jeCD/1AzYvsRb246MHL3+cY+foZ50yjsUjkqcoGAQTyFhphc+UFRmGtnjfDBjMhgnMgpCOLXY3ycLu3yNhDTjmhv11GQ1+hURPSnREBlhU2SExYqRsSW/imc9WK9CYcLEqqfvJY0YPR4pDAa1ld9ZQjJwvCU9zfbWC4HM1LjHeRVenNmSt7CEDWV/dwfBH4V+r1Tp2ZzxXVhAiQkqHWgz2rYeH3NdspV9e9g9Ng71o+gYoEG6foOt/d9ZkpviJj9ifaxshFTuXTasNutgDGpdoR656KLebGfHImEyYHFiGfYAq76d0ZIC0FCeP5RrLGGIfbcLfjuKLurSCXDLJWofA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSeYPKiTA/X4hTURzqBQCRD4gzCWNvm4uGz0eYBPHLM=;
 b=EfCsxqvAIPiGHErpSYSFxo100WAxY4bjpLbfA//kCZ7Swdii2kxduOA67zoKjAWS39qR3wZ3FJodMzluxMqO9iPCmdcOP3yaUJsSEBDbb4VMuBVtj7rXIQLNVXijRDI7ZPnbKTlaW62EgFwuNf80qXFAdr/D92UTrVgglEvkf40=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8964.eurprd04.prod.outlook.com (2603:10a6:20b:42f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.22; Thu, 19 Oct
 2023 14:49:31 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6933.008; Thu, 19 Oct 2023
 14:49:31 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v3 0/1] Bluetooth: ISO: Allow binding a PA sync socket
Date:   Thu, 19 Oct 2023 17:49:21 +0300
Message-Id: <20231019144922.4700-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0253.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::20) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8964:EE_
X-MS-Office365-Filtering-Correlation-Id: 961529ad-8f11-4709-1f09-08dbd0b299cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VvGmTB3/JlfK+H+MDkQ3TO7w0OpDnWdcJ4ZIp0bocC1gMYrwd5IT0O+GN+TaHX+idMowPgld++njiYRfydfOViGiHtoXNz9t2kcv2fnk9Agvz76K26mtkLrLD/muw55/xzCLfzgVTWRM1CDF5ucguwweXBQ6ZXnBAnQpmOYc75Uu0NGz1+kMtUUexXNarUxJMbFUBEDmuSrD0vXlCoRo8FIrGg+baVeexsqs0tnaVYvDs1PYco6cOQGeRWa85By2D0DFsxUXkr94iDhOoJMjzI0KFt/D+b6luWCKILiT/kTXHLzXXSYGXHbudIFcnL1KLw8eNSorhSYFGNPWWIOGnDoqwVCWHS/1TjmveS2l6EDL/S05OLt/FeoksdzckS7bAJyGa7SavhFNlpWWTaDtY6v1j9PRZ+QRMtrl2iWy1zHwGzVo+9JQgCXNxGhVXlTS6GDhX/HLYjsGHWl9j0kfUD1ASaOBTAujv1FkfqR5sMFJkGFeXPFlqB4XEE0C0HgVrj3ZmzUyTBrlWQ8oHJvf1NMnKMjr2nU/imUEsd8qlOp6OPXe/M9JEvjujoejVCRi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(376002)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(44832011)(66946007)(66476007)(478600001)(6512007)(41300700001)(6916009)(86362001)(6486002)(66556008)(316002)(6506007)(6666004)(36756003)(8936002)(4326008)(4744005)(26005)(2906002)(8676002)(38100700002)(2616005)(5660300002)(1076003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2qEvqP0DVrR+UTatSWYGEIVqP/sY1QUou8WHmvGKzHkql2j7cEqLBGAjY2Wc?=
 =?us-ascii?Q?HlevTQn1dE6kphecWNV7KWTKTUDD7rYXpaRefDKGxSdiI8SPZzQu4/jyvklb?=
 =?us-ascii?Q?okcQEEClDxuywl0Vi+GmWS/sBb9BSL/0wodzpGu4VByvlc1X+sK2CLw4xJnT?=
 =?us-ascii?Q?K3WZKBWOYM/zOAH9JKuVxKET4AkupaWagUEEkT5tBf2bWMLPKJG6Ghsvqgpp?=
 =?us-ascii?Q?HBx3bj5InvahI67V8PVhiYNU5eJsj3VO1D92tb/LW54k0GJa/iR2B6kEbvKD?=
 =?us-ascii?Q?+fX7gAw5ln2LM/kJgr2wnU9vEetPBeUWD/JO8/8dXE4GOeteG4wGci3JiGeN?=
 =?us-ascii?Q?PK2D/7OIVsROyQ47ONPOVwgFwqqFUwr5tdltv0lA7bwQILIpxQwmZF+3gAXd?=
 =?us-ascii?Q?J07ZO+CwunSIuEPomimBf0HU9S3xDdUdk2lHV9amHNdLPCnNCsGAyfTYm6wV?=
 =?us-ascii?Q?Nu0IyPpda1NTuFKHaXmR5APd8C1Jm+8HckdevwaZrSgwWsVIjleJyTEKmr1Q?=
 =?us-ascii?Q?9V9osl2TLCgueLD1Zgbo9uSAiMIoMCgjeXPRPnkOkLMOaqiATK16qNC+RKK+?=
 =?us-ascii?Q?4knTvcQhTLEfXUbJpodczXiCt9zv+9g+2jVmgsTDxJvtvBCqKne6blAfKPxW?=
 =?us-ascii?Q?2BetYgF//6qkPUDevLYUiMTnRUGfMbhSavuPJvEjMyX7JIplLH7uPH65Dsfm?=
 =?us-ascii?Q?kSvpUG87AH69KWuYSGpS6lxhGQndrWazGjWkEpVjKlil2IOAfkbBiLpQKtjb?=
 =?us-ascii?Q?bB0prOg7emb8rFVfsusxMC1lsGlHdFIgT/naS0NCJEq54GMsKsDHwstJVY60?=
 =?us-ascii?Q?fibSQ4Xv0CB88giqxiJXXHrfoVcMvVqwWY9ZWEX6ey0vPBje4dpSHmBTQtDH?=
 =?us-ascii?Q?jOCKt9HTgYbFjz3xhorGaY1vY6CLyxNJ9sThZKB6eCh5ER+A8A8IwS7cWLrp?=
 =?us-ascii?Q?/VSOOveieRjiceITgA3R4jwTSuDitT7h/68h2N3gD7mRUHf7wlWScptzuyRj?=
 =?us-ascii?Q?vOACRFvb9DSA0yau73+7RSJmorGZERNEAcK+/KfKoEvX9Cp0fmw8/l9q8aEj?=
 =?us-ascii?Q?9FKc60JmzmvSz0z7xOBd2rZnwmd4uRvkvPxzpT+DlHS7FFW7aINDvFrQ1s8z?=
 =?us-ascii?Q?EixBmQZKItF8mmbyjP6MUKISiLZWSEcuMtED5sRxTinu0vyo89pJG65cYPgh?=
 =?us-ascii?Q?x5CVLVjcz0wNKsNiY9H/ceCoefl0DKVIjgqAUy5pB+ECD7vQDpHyDc7EvT2t?=
 =?us-ascii?Q?2vHgtLnnqQO1P6MZmcLp2aml/8iSrLwO3WP8xMqbncq1BzSeShofslV5mqFx?=
 =?us-ascii?Q?3PqMC1Yi1MPeyIYCT2tYbrA1KoJx2a5r7GWsiAKDdxVBFzkDLGIAMfVmecuh?=
 =?us-ascii?Q?gMz0YpKeQL+8qVrH9sFuKlOQbRFbwuyPnhOWTJ5qS7oaf09XcBdMIRZsNaII?=
 =?us-ascii?Q?KufBjXNmJ3Y+Sw3pdvX/VXTfssvqjWtD1qg9P7ikkar+A49/gD2Q+hv6H0jJ?=
 =?us-ascii?Q?G7MnqZ2W6YjHd70WnfGSkHksN2m8nKSYLotDkrr5FEXfiJgykCFQdzu4z1Fx?=
 =?us-ascii?Q?lj49fNnGiBw4YAn+0bIZGglaW0xum1U7DbFx6+UK+xAcnREg8bh1CnjrY/gE?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 961529ad-8f11-4709-1f09-08dbd0b299cc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 14:49:30.9456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ayl9AcxO3TWfrGhXpvwzhIC2rwh5DCrfiMUtYlvVlbvwXxnoWGjibI/mkMdF5cuPY8l2PXxEiWOg0vLjaiqDOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8964
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

A Broadcast Sink has no way to know how many BISes are available for
sync or their indexes, before establishing PA sync and reading the base
struct.

PA sync is established by calling listen with DEFER_SETUP and accepting
a PA sync socket.

This patch makes it possible to bind a PA sync socket to a number of
BISes before issuing the BIG Create Sync command.

This patch version fixes review comments.

Iulia Tanasescu (1):
  Bluetooth: ISO: Allow binding a PA sync socket

 net/bluetooth/iso.c | 67 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 62 insertions(+), 5 deletions(-)


base-commit: 2fddfadb0478a11952d4a3d543273f28d2c23c03
-- 
2.39.2

