Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514A4C001DB
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Aug 2023 14:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjHDOLm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Aug 2023 10:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjHDOLk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Aug 2023 10:11:40 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2050.outbound.protection.outlook.com [40.107.15.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28C4139
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Aug 2023 07:11:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nspRPXRHDgRLbIWIqpelodPVT1GOa+B0PdyI5YNproAJNv6FizXWSP3/zLEtERU4QS4cH++C56Pie7i7ZbAHadqz64p9hdtFSBep04fQi+BvIteIbT0ouRS+v0mkhuZlj82fz6Ei5hWo2O8/zMtglgJUHjJyBqlp94Y5AACzstdPiJRK0+R6fekcSaR8LX5Wllaec4Zwc2lkCEO8wlNSsCob8qU00qqbbaQRFKC+FGTB67CnXwMTjJQ3soAOD2FUJIb0vyXYp8JoUHtNhh8VM8zsRzAkOjVzVp4LRUwYBQRhJXld0UZmFgArdLq/orAjy823DDLu4nl3/n7jLMhf9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5nx0Pthzm/TnORkL7+QY8fekA3dpWvvh6uxuYT6Cuo=;
 b=oV0vBGItNKX5JoikmK8exB8llf5LNCxSBv3OCfUhcJo8ypqSBTXMx6qqilUMo9HgmutKJ7Wm5SBErc2ml3/LYrObf8eLNUFB6kqn1r3hUrTfpV8Va52BelK4+sbXObtHBc1foq37LVAXj7WXU3Qc3fVkfCZ278Clk8NTEDUk+YTvRSQgqVaEhtTjGEuRCgZUrJHYFC8CuNAQfhCYcGPXutGNLiT05IjTYhgs7XdHw3FnfnyOuduGVfEWmY54bzGowWk5eiSrT4m8QReKvcUMUa8htx6+vubhwgmlk6Kq2E64eDckv45RCgVjxIR7K3TEigFh057Kco7OcHx2uTg8Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5nx0Pthzm/TnORkL7+QY8fekA3dpWvvh6uxuYT6Cuo=;
 b=aJ4qRdfMY0727NMAGMpO3BjCTGZPPpYObC2NiwtvSsiMAnblRS0gDNbUxE266dTbwCBdpVKbNX/dqB/AZeNABRofcXalAbwve2HlF3mPHGH5eow/K6wXrYUrDQbSXbQsZ+dvzk8SjAEd8UKwYxeH8GjlegJsO9mhu78WLKQYreE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 14:11:37 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::e67c:9548:36f2:ef3a]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::e67c:9548:36f2:ef3a%6]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 14:11:37 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Subject: [PATCH 0/2] Configure BASE using separate structure
Date:   Fri,  4 Aug 2023 17:10:57 +0300
Message-Id: <20230804141059.24352-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0092.eurprd03.prod.outlook.com
 (2603:10a6:208:69::33) To VI1PR04MB5344.eurprd04.prod.outlook.com
 (2603:10a6:803:4b::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:EE_|AS1PR04MB9287:EE_
X-MS-Office365-Filtering-Correlation-Id: c1b2ce91-3f59-4979-1b11-08db94f4b750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6oMQtb93yF39dPbv9I2hOFP48QhuvZ9UfIUp4cxt8uQJ9yQqcSDfcGJtgUyOouGBQDDds7Eesc1NYD3YbvIuGGPw/QW+effcFjGzVvc71AL4RNayrx+matWfQUmMvbaN3UrzAlsjLKfWQjEaMIIbOrs4RPDAdmDBCrxNJUl6GnYlomZtfkyIInATo2Yde2N7M9ij05odiXZ0Dp0wJSALcAmcIDLuNTTnlG21eBkecmxgSP/4qucHO5NC2O9WlOx+biXsEOlZ7OJyEAdoqLtUbbmP+/BqKKIh267GmHNe9tqncj6YNoG0w8NGzwDxFNfXQhydoBO59EBmuM0A08EvxOEBL8fgoLKIRg3rJqre+W0EyPMqI1oB685Oixy+4Fw0qJ/yMqkVA1G4z5qz+GaVQ8tJRkoYQ+BLct1FwowMNNChl0+8i6ZNCHKDfuS83FMjI86g78yCATrPB6qmlZp4SIBhZDtVzEJlyHpIknsWiSpsVIxKF6aY3vbbL3mqBvAsYHadffiPnu7coaA0VjDuPKye9p1rMhaxC3y1nSlfjdPJtn+hnKtNqOSA1rseEBL3TU51ALstlHFCo6cQYH15PyT/KADPHmQy5+RYThYv4hI8dYodDnJB/sMgZ8zg6S5s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199021)(186006)(1800799003)(6486002)(52116002)(6666004)(6512007)(86362001)(26005)(1076003)(6506007)(36756003)(2616005)(83380400001)(38100700002)(38350700002)(66556008)(66476007)(66946007)(4326008)(6916009)(2906002)(4744005)(316002)(5660300002)(41300700001)(8936002)(8676002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MKC93oijZgVpDT4PMJ6qWW0BSQ0NJlZK9I/pZ4nbivHAkPTTccjnJxqZhoFT?=
 =?us-ascii?Q?3xTKmiSHaOUjcZ/NOQYJskPRHyUrzie4prVpN0vTFUgGFZIOuhsuGWjmt3Wd?=
 =?us-ascii?Q?7A88M9PpujCrayBieUgmMBfYGaCZWbu3+0cXZ8yjew09F0/9pnLKaOunDweF?=
 =?us-ascii?Q?xPplWeeOU8iaySh/aGb2Jg3GQ+5xhBzh+Abetyv5XY9FrQZayAxpluRPRmTP?=
 =?us-ascii?Q?Pws2TP8ganmuo2JR/yhkN/GBsExfsrMIReYwe4p6f8QHllZ4Luiazt9OAmXM?=
 =?us-ascii?Q?3GfDem2FxyhEeibdzY4nIWVLYePNktSC5lEEqxLlZt5HP2OTdeHx+D/Zox/f?=
 =?us-ascii?Q?joauDdd4AT+uyLHzTr26jYFTUpNdPnlBlKOqRWVtxl+npvEFWXoCxSp9c1nT?=
 =?us-ascii?Q?I7+/lN/nxp15hC9m/iZ+liuLkE/fpU+OGjV1pR4LiJCih3k9u5uY/bY60jT/?=
 =?us-ascii?Q?7ombcFrsvyRwCcF4zhnRqCN3Av/NZdMhYV0Ttn/mJOz3sBAubpulkd/7CJAr?=
 =?us-ascii?Q?kG1+gSZTU7LC9zViXgXj9OhOQowZFfqgdrY2wi8NC/XmPM5cTyrpWPQg5thS?=
 =?us-ascii?Q?yCCXXFyrwQ4mG7y2eXJBGTi+rYNSpQSImxMdkLYeyjj0mowYsVGjuq3L4KuC?=
 =?us-ascii?Q?toQnXQGB9mJ1NL/d+87IRvhN1NwItKlbl34HdoC2gdPMREyDh7Pr10+1aD4+?=
 =?us-ascii?Q?xZ1brwzcMk5MBPLZLpW3lHDdAhp7U8x2O08sV/oThDNvjeOaZfDRLLQo0mQs?=
 =?us-ascii?Q?FgqZIHCAxPkrwdzDoBcxqoQR0x5UsKpIhaBBKY97f+yLGCQDr7ciUESLkmNM?=
 =?us-ascii?Q?YICm8/pUhOln589xvfnpXNVerUK046gbY+S6+jIpkgNSC4D77EjZdsSwt1cV?=
 =?us-ascii?Q?xz+d2d8hfs76ZWjhrd6jPxD7Ugxr5SXNrjQDcmz0DsDc2WKQ1VdstAHcCnRj?=
 =?us-ascii?Q?SK8z0jSQmKofSvqcrkUIQW69dtZKlNkos2q/06avXsFiY4WAVqkOo6QBIfLy?=
 =?us-ascii?Q?4UQwpSU01B2oDMeVAjvztWUaE7eIdAs3rArWk1jc8aFhPIzQy0tIgyas5FQB?=
 =?us-ascii?Q?POX7lEcFasn9BSc5iOuIJEO0Niu8OIuWQiaEdMN6HOYs2Xq+ZIhEVcRA7lMy?=
 =?us-ascii?Q?nNKjxv2UaG6Rfmx/C0TT+VTVjokbsNl/PpuTg7Am6P9dN1ewYe6FKBtYpAFp?=
 =?us-ascii?Q?t/pNAQbX6YB81v5lP9ADEZ+/QGQ12mleRHRiYJlT0feiGobVhJWb4nlo7iM4?=
 =?us-ascii?Q?oAQjg/E84m00njdcgrQ1UpgQ2fr6kEIVNka7Nl4oGU1dOPk1hNPVimft3hVx?=
 =?us-ascii?Q?l1SU04vSpQohVsJGn1xuYmrN8rDtNtzolaetPT4xFex2/NYNUQTZWNOvl6bI?=
 =?us-ascii?Q?IRdFJft8f3Y01ruCnOdtS/NM4AB+DOQ/RegmQ2iKo/s5KseU6weIESXhjcj9?=
 =?us-ascii?Q?j5FecMc59AyPCdh3YyCgiY1/kbjcJTlnEZfGCRt9nHoBmTje4UNF7l/Y19pO?=
 =?us-ascii?Q?2F+/PqVhICA0aQHSf6jFCUzn0JHv776Xtkwe9BU2BWtUNBjLnFt5KnCrOiR7?=
 =?us-ascii?Q?3OFXM8zx51AfbIgjX8hKR0H6OxZueS4b2krRYc91gep+oJQY/VGgbexaUBaA?=
 =?us-ascii?Q?oA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b2ce91-3f59-4979-1b11-08db94f4b750
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 14:11:37.2995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V3uLJs4GViRVJaIADkGFfoJHwbzNwDHUxmPYd/7R3FXuWle0cPQ5jakNcvN6MYkXYaL02tUOR12aLj9f9D8S9x8LeJi21F9RtHE7pjnHQY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9287
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Use preset configuration in capabilities.
Configure BASE using separate structure

Claudia Draghicescu (2):
  client/player: Use preset configuration in capabilities. Configure
    BASE using separate structure
  bap: Use the BASE structure received from upper layer

 client/player.c      | 24 +++++++++++++++++-------
 profiles/audio/bap.c | 13 ++++++++++---
 2 files changed, 27 insertions(+), 10 deletions(-)


base-commit: 80107630396d3d3a3984c599e0cb9b015be0499c
-- 
2.34.1

