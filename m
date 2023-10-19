Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D6FCDB482
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Oct 2023 14:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345790AbjJSOwg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Oct 2023 10:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbjJSOwf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Oct 2023 10:52:35 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2074.outbound.protection.outlook.com [40.107.247.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A4CC2
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Oct 2023 07:52:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOH6rXWBkK/aQ0q/VKCvdasx/EmMClFiA/AyVRBgWcMH5ImP3EugHzseRRKK0Etw51ieUJULISOjaSFYg/x8Sq+3cX7oE+APghALnpWkGjvDhNW0oK20M9clbn5jd/c6ow+gop6wD6EDYQA6shboLik5HysdclTZ/0qL8jyvObrEhAV49fq/ybyMCtGNGtadOFVGlYZR1pjJVUblKsgLSg2GTvmjP+kXfO/4gTdA1GObZi6fBu8CPOQXp/p8hJsvLEQrJ3fXzXOs9zEZO0dwTmfvPnS7O9yRslSjO8IYo6mjkhXPSZQFT33BhNsYdtfeV7oeWJz7NNRkouup3giPAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrD6V+iBUNIidA/paz6lPQuDrvOlE+aK3nG1qnu4FSE=;
 b=NDnXN3qRdHtb0E/BYl8iYFLfLqMTCDjGVB1QLFQqe6l9VkqMg+QmdvKQHFvKbUpLLtZ+lU/1B2RkkydZvOO03wA9fnmwK8AxdwkpP6JF/L0GVOfpltv60ZC0EEEJeTe7dTRBn9PE/1YUWfHNQsgYwfvrFLGSGIu0O9ijHZaru/y1pkhaKYHt0C61g+mv0I1eYcqIc+2GvtUG+nq1rHQtOs2j2yBdxw0cefrMBD682GvB3ZGOB6qkNt8l7hGM+cmNe0JrgHSGkKJAZZNOXJXWuNRoB1JKE+5F2nx8uN7xZQ+xHl5/Vj9BjOzYxpdGk56pWxJ0eOwzvfqZiIO5aLX/+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrD6V+iBUNIidA/paz6lPQuDrvOlE+aK3nG1qnu4FSE=;
 b=eEunODvB0/lej7uGx6cQ7YigerjEjcF87izliw67lyWYQ8X4qI/iVW5XIXUcp4yshGqlZe90+3ojo5yQPINPCSFnaMv1zqbEqfriejuCz9RHh4Pv4y3WsQllF+cKJBmo3tk3kq9RehNcp7UipOjlHLOBmdNwTOliOWKA/RJFJnE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8724.eurprd04.prod.outlook.com (2603:10a6:20b:42b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.7; Thu, 19 Oct
 2023 14:52:30 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6933.008; Thu, 19 Oct 2023
 14:52:30 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 0/1] btio: Allow binding a bcast listener before accept
Date:   Thu, 19 Oct 2023 17:52:25 +0300
Message-Id: <20231019145226.4879-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0092.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::21) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: a610b710-5d38-47e6-cd76-08dbd0b304b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VjbfDMcplurb9kyE4S3MurJseu1BE/rSxjrSBLQpZvNiZWv60lGszAdJuIH/mSLXU2mq4UfgYEnoikUhGJVlv0WItLBdRc1/Chi/Jg3LdyCWUZGYS7MOb6CCX4r97Jb3MLjYxawb1405O0HNqTSWClZsYX69RFH8GoiEvxPani6GIDrqPU8Py/tcUGoIzGOASn5a4O53TCEfbDJHjLw5Itv3IvcmRZrwrXKySWjDDDu1mJ4vGJHysr2cpvjbK8ZqMahzrhAlcIchnK9HFkuAoAZXf4cLEl7yDQPjhyi5on2aLMqJCByRK++OxmB/j4+8M32Qfglw771s2V8gq1HmjrrVHZM+2izWzlEbTOMai7h1r9VpSSfAEi0o19qqsY60FgmYkWiUMXikJw/vqDglklabVEKIb3ieaIjfdIXeQW+jY9w3Gd2N7PFoNZQdyD/lkRlV81pE1gdnF2yW8jDDUFJbYvPJebV387tWZNu9UnS7Ea3WmDqEyOLizWxCgK7LgETvIqWWS01zRgQsYJI9ZrNsBFjt19xTUGBvO4Ys1x0LrUaSppHbE1de/8FxkBeIm9m1U4Fc6h7u6Kk4mAEOmGpIYCe9fPg/MfLexj40uSQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(366004)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(8676002)(4744005)(66556008)(66476007)(66946007)(316002)(6916009)(6666004)(8936002)(6486002)(478600001)(5660300002)(86362001)(4326008)(41300700001)(36756003)(2906002)(38100700002)(6506007)(2616005)(44832011)(6512007)(26005)(1076003)(83380400001)(2013699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FY8vx5NoO5Z8rDDmP4CLFEX870g7CU05mRE5jvZ8PCgd/xe9ZsNthX3pAOZN?=
 =?us-ascii?Q?jk5HfKkPYdeNdXsolaUdmhEY2SNRqj6aRy1w5IlW25XsUgerUYKQpjqH1aMP?=
 =?us-ascii?Q?gK7Q2ngcbU6ZLm7oV+IMHXk70EvD5xGgZczw7oVTm27DtQZEtOAiZyZmcCid?=
 =?us-ascii?Q?QkhYQTTYr14Ms5FrblpHaCGXvcS4W3XZoTTkhCx9osvr9YqjIf01BpqT4Ngt?=
 =?us-ascii?Q?VaucAUzlQxG6XMUcZ8FSLvxOkNQqm1OyYMUPAn8XrZzeIqO63Im9RgzXSaoL?=
 =?us-ascii?Q?giTcHFUhgOcJOExN9l583nVK0dOwkWjkaOkazHdiVw0nEcdUhZRpfuLWMHxo?=
 =?us-ascii?Q?6RE47HNGZa7vy3rFNFx4Znxju3ZXUwqVEwGovgerjQL9dpr+6lkdsz37J++S?=
 =?us-ascii?Q?zL10jj5AoQp/9IYCgl4avDPgeRzM9PjVmxC/+sc6ejd9dUqujNpNhy4l+OWd?=
 =?us-ascii?Q?OPH0JpznOMClIyo1bm56vcvVmzhYbcXl9dVVPg9sK1NxWcOVRtEzNNz89cVT?=
 =?us-ascii?Q?P8wO/aIedRiPglTU1aiSefqPPq68mWGfdgZ08Dy4L6R4K70z/GjT2fYgo6Hb?=
 =?us-ascii?Q?PK0mThaEYFiVBpu3hw7o6DaQGtMCHXHw8hZsCm8RMDEGoGa6bl/72v4lrF4Q?=
 =?us-ascii?Q?Ne+PsAXYJBKadSoe5vWSszu0T/a3LNRfoIwDRCUCTCQduv1TvAeFvIk2xXSo?=
 =?us-ascii?Q?qu9axYtulTOOxFiwmQot6/iRXBfksqSKgNpeqphudSQnWNaah5wFg9MENXNo?=
 =?us-ascii?Q?uftFlz101LapN448wMR4Z/t/ONpP0Z0pXp7vqmVilueYVzlwxrie9BAH75fd?=
 =?us-ascii?Q?3FF7LqWulJtHjJzlOeEKh1ZfoZ6zx/tRoyxnd4SRM15I1RHxg02rKIZEojH7?=
 =?us-ascii?Q?YWCqrwmK/J/I/3adb8b1xTwdapE0E5rCkn4bD52osSFxErXQfpRiNodZheKA?=
 =?us-ascii?Q?Mtrgn8Ji9Dakfp0s8H4Xx1IrjAW0qYLkf3HLA1E5IwZiXKX2bIudBzT9HOp3?=
 =?us-ascii?Q?f3+4cemQmHbLfAymfd3kClu+KscPhcSdY3SzhonhLCkP8xi/1a58Wc0y/dMe?=
 =?us-ascii?Q?wjlFzmP9OIs9zPiAD7uPSNAwgK4TBqE4DOv+SdKaZuc2wuoKeNKS38URZnCi?=
 =?us-ascii?Q?QWyi4nv3CzB6FDzw+vzeOmDdzZ+7vXE7OLA3oJrXDgFyDmHypO7OIENS9PVs?=
 =?us-ascii?Q?xuKw88NFpLUOCAk7t77WVCuGPMSQc3XGogiSAkELuUlrOB1LTciQ1769o5VS?=
 =?us-ascii?Q?A+b6EHC8bkR3pHd6rOe6fZCkI1sNeL8OoTFa6+m7uSpVlJ97ConZX192ZTDW?=
 =?us-ascii?Q?4H8CorHtCT+OsoSoZSGNjF/mz/leoFvPwwcmx+/boqkw1E/LNE5o5iukBvSx?=
 =?us-ascii?Q?gIHu5oVsPqr5MUhwWjhSGPGh+jwKVsec50G1rdiAzQpqpZUNFr5rAOc9dwfa?=
 =?us-ascii?Q?vXGr6XvQzsM39gANwH71+ZJuEYWx8GL7Pge6tXW0ZkmixQ4Yvm4IcJZkcdqY?=
 =?us-ascii?Q?QDIpM9modegAJj0eyA9rlgiJ+dkNiX9Z8imOLuRvcmSy7yLXldPqz5ST3Ljh?=
 =?us-ascii?Q?iB8JwfMKF58MzbRJmXhF0UxlLq7scl62rKtfh6Ibk39E10myNWFzI9jEWdmZ?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a610b710-5d38-47e6-cd76-08dbd0b304b6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 14:52:30.0858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9kDXKJ5LbYiO+xztHWUbP4sGD6Q2QzyGyiYqHlHzhnUdrKA8rk3Z6u6mrrEkGSW4vXKbBfHOwiTYX93KrkFNDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8724
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds btio support for binding a PA sync io to a number of
BISes, before proceeding with BIG Create Sync.

This depends on the kernel update introduced by
[PATCH v3 0/1] Bluetooth: ISO: Allow binding a PA sync socket.

This patch version fixes scan-build warning.

Iulia Tanasescu (1):
  btio: Allow binding a bcast listener before accept

 btio/btio.c          | 55 +++++++++++++++++++++++++++++++++++++++++++-
 btio/btio.h          |  2 +-
 profiles/audio/bap.c |  2 +-
 src/shared/bass.c    |  9 ++++----
 4 files changed, 61 insertions(+), 7 deletions(-)


base-commit: 0c757e8eeef69ff2b1eefa59e590f171c9fe1c88
-- 
2.39.2

