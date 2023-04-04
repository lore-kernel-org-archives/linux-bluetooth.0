Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB71C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Apr 2023 14:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbjDDObR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Apr 2023 10:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbjDDObQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Apr 2023 10:31:16 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2075.outbound.protection.outlook.com [40.107.21.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D4BEC
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Apr 2023 07:31:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYnf9Qqgkn5KNzCQrp8UGnHUov97gkIjPFhlRD8v+T7mv4kxxkGTE5YMkDJR9a1UPJqKbbEE/UB4Q2RDsw5FJLLx313ouamx7oqAYTzZY8keaYEocGxy5qdUCaX7OkmLVOBrzXuZg0OsBzDVKBy1ZKetPSw+GBMKnsky9YdT++oJazZdONAe0atVm7m4aVEcXoGPIHE2r1o+t8udiyQQNFjF+xdkMTvlxd/Gp+M+XYnSzDXtGlj4Rbcnl5M06YOnZGk0WJ2Zelfu2sNC81uRyjlCtzSL1+KbgH9ri2wqbnKtIBh2DEuzTT33nA5Yit7F1G5adnG8jbomswJocO5o8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKvRUERkGp+LPMbt19QCqgEQO1uiPKKXvjosri+OyH0=;
 b=Ca59kBD2PCNXQ0mAvxInBsJjak2m+bW9nR6mlrun4PkzpRMldyz9JZOQday/DR5tUbhVwkhT2nuX/YJ/G5Gf0YFaO56J8mqpqBIFdYZ529s7v1BTFcS0J4D0Z0xuIaC7JMBvM1+WdFCXa2mokdo4aqc3FVZd7fUpVCTmOsZHm6+kBJHIaB89vT/V4etYzBz/+0UtJ6wgb+vBsTC9wtai9G6gdLzDIrir+a/6ZrAn69/NQp65GvFee8VXxV1eqiwaSp/+fMWcBvCYdyvuQ4b0Nl6Rc8jzyEZAb+qRz1tpoQxoFmVMOSyzXJSdl+CmnYfbsIcWWgNp4TX/K9ucaWlSig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKvRUERkGp+LPMbt19QCqgEQO1uiPKKXvjosri+OyH0=;
 b=JuW7mwIuqA3zjZ4BmXZMTIBEOPBZbZ6PlOwUmEleJmSxS5FeGjs5oiR8tBBmremq4Fg/jMwYYgsaHwDXiOPFy9iNY4eiUwKdZLkl6stDKwjWwQ+FXWAoqEHIEm5xGNI8VUix+kgGeqU4nf5X8geikJmjGTX31z+0yHxfM5u/ARA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB7645.eurprd04.prod.outlook.com (2603:10a6:102:eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 14:31:12 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%9]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 14:31:12 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/1] monitor/att: Add decoding support for BASS
Date:   Tue,  4 Apr 2023 17:30:52 +0300
Message-Id: <20230404143053.101464-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0018.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::23) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB7645:EE_
X-MS-Office365-Filtering-Correlation-Id: d270253f-51b7-4aa6-f82e-08db35193d89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dmAp5S1iN5yDp9L59xpGHdD8icotGe07OwdGKcLbXEUFnKXxOK8VzQ9OH685nNlG7Gw8Etjq6F0aCsLA9stNJ2QOF7sXvKj3inPFNW1KmhN2oeoxl7NkJ1io4s48FeD/SSQLU+Asdd0pCOBGYHzHJqekZfSqMZO9lwYVEgHK4ZY/Zr4BXX1avDxL3Ji3uW/ZGtpATMjiIQ8kbXtHw6KilKm+kDd68vutBlMQlYKVLCLrjnEomOQ35upvYjMqSo6wW31xwLbzOzrDZLeMhT7eFiRrEUat3CQPz/B65HuM5Cw3J608vgO7S43eLoTymTyVpm+UUA6OjtI6+x6yBEs2YCTHg/O58T5di8YYPoapIBefAAGB+/BYwyqEEbaZpKADXfuua1aRNSgeyBl0cpVx3N3qKPxsPuFGhlVCx19BItBSGGDoclngWkEH07OaC5mzoZ7A/YXGh66SITPJL2UcW9RdJqFoN3z1+H2aUT/eCahkemsG+5jFbKKLNQ96LvQoSlVRu1avY1CRWc/29R6qYzQBhBVOVw+h3UPLtVuhr0mWlSQ4Rbb/Y731qFOefsBrjiPwB5FLcvObxQinpMhchXhY8liwlggSUaDLd5i5/Umnj083zhixmZ4rofrHFF3z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199021)(2616005)(6486002)(6506007)(316002)(6512007)(52116002)(478600001)(1076003)(2906002)(26005)(6666004)(55236004)(186003)(44832011)(5660300002)(558084003)(38100700002)(38350700002)(66946007)(66556008)(66476007)(41300700001)(86362001)(8676002)(8936002)(6916009)(4326008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7tvqOYqHZEERUwiiJPi9/631wKcwwHvzHNVep39cuchyvwvCm7knKdKFSHx8?=
 =?us-ascii?Q?2Wn5s9kRMGgiPiOf0jq7EavagbfYPKI0LNK6izwF9oHbTLQB57UNuDHREqHK?=
 =?us-ascii?Q?7MgZnQDariOVaonZpL55JhbFPsI/hp53p2qLLuaWx1C1dZDNeie74Sb8MzIQ?=
 =?us-ascii?Q?8d8D4yhkek8X8g3trPrrk+FQle+0iatykq9S43FQgZEP7YNoXys65e5+GJUm?=
 =?us-ascii?Q?EhI4MDHm9KxIK3sRaOEUGc3eDdQS+PLAqVT4W7yqutwZ52N9313cKvRFHWjs?=
 =?us-ascii?Q?5sKdH1GGjSjxgOIOd7mGnGJ2pVikjH2OKxDa/nm3KROlDeNnHmqQ0RZr00dc?=
 =?us-ascii?Q?li2HaQAs+mPz7fJ3xt5+vI8rGcLMfdBcIDZISZVWpHithFAWjimISVZ/xNrQ?=
 =?us-ascii?Q?EiM1M2pCDPqcxN2LuHq61yGTBXumLNJcK1/0eEBTAvITyLuexjBeKl/j/p+C?=
 =?us-ascii?Q?+HnllvCaEcBYk1XeIpB3MAbhGGaKZSnYz/kjLs1YdYt09SRdQ9hwGlzv7jYe?=
 =?us-ascii?Q?ulxoCdETSyyEEiFm7Nb0psZEppWOheFGZZUT2JoSSjXt+sdRzfyUPV6ID/fR?=
 =?us-ascii?Q?r+tTyq7UNiAAEC4pH2NZMhl9QkES2wqsuKNIwbm6WB3068DXONuArEZnyLlj?=
 =?us-ascii?Q?g95R5F99GfaRrqPpLBiQFJMnC7jOGw6U/MRRXRssYtOhJ3b0TmKbaexSozSe?=
 =?us-ascii?Q?/gfDgedH0cGkMoIgklXtWt60K8IGgV1xnch7QSbiG2Li1tgPYgla8wSSaZjq?=
 =?us-ascii?Q?hkc09FbvqXdMRSVrUD+OjAelHa1DivQyO7h3XKzcPf5p0Dky4XiN8/hTBOuF?=
 =?us-ascii?Q?l7epUdfX4x1FZdm4BeNspBO5+wwCiWPPXRdVP/aeHO/5kFXeo7eVevbuoHpq?=
 =?us-ascii?Q?shCyJFiUDt3bVVl48yFOEAxtCiDYpjxF7+Wu5RvIC32IDFDesADAeoftBwcB?=
 =?us-ascii?Q?hhbp/AlRP/V4RW7W0iAW0E2V2mezFdx8M7u10TBMWcidRdHwD6wqC7aoFCxm?=
 =?us-ascii?Q?YqIEsP3/PU+qLi1ATte7hQkCdD+ZukvO65SVP4bUCg2jBD8OXCGnDSpdt+Ly?=
 =?us-ascii?Q?27Y/RQ2+di3QV2pKXhO0dOBRh3SdFr6/JRKNig9YSlT8X8Dsq+HQX1EQErYj?=
 =?us-ascii?Q?hdg3kppPHpM6H2ScS9zaxnBlCvIHiZ/VWvdA7LMOdTPywYco67QA56OOQdYT?=
 =?us-ascii?Q?Ab5zwj525h6SI4Iaj4GcpR1oo14M4atMSjwIL91KP+Vw0Wk5tsFjH3QnSwNV?=
 =?us-ascii?Q?jpQ0pu6+r4x9HDgVERBsMMHj0c1bqacFapziSNaWlwCU7yH1Ch52WhQ5O2iH?=
 =?us-ascii?Q?Gpzd9/LER11mVN7Z6TCMx2UR+PY0IAKQKMN6FFLnIe7BrJjDd1CvmJWUnBhk?=
 =?us-ascii?Q?Gxvs+JsZL9I+iRjJDPB4B1S/BRKbdh9dC5/BFMjYswwtFUxO3yutb442MOxO?=
 =?us-ascii?Q?BpJDlc90CVVbvz2M6jMu91CRI53RLnmRNPizgnkv7ysLoUaCPW7eQg8ZswMz?=
 =?us-ascii?Q?c7MW8Y5bX5LRA5Ggxbv9dA56hDATwxAVZoLeX9QZ2ynlGj9IEWMNx3/G+Ld5?=
 =?us-ascii?Q?5tB8Ix2J/G4jyBkPHSyX+O3Zha3c9fSvDb0+P3AQNVtcButzxa1K8efK9qgi?=
 =?us-ascii?Q?XQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d270253f-51b7-4aa6-f82e-08db35193d89
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 14:31:12.6965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +4VRstmya90ryC8hk3nELYhHs7qnE32AGXPgRe9IcVME+sPc7dlmlq0cVYZTmRzKxkhGfN7g4bM7STNt5eYA0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7645
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds decoding support for BASS attributes

Iulia Tanasescu (1):
  monitor/att: Add decoding support for BASS

 monitor/att.c | 461 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 461 insertions(+)


base-commit: de8e7cfce25b8d717f5ee60ee3b79d426fdcc681
-- 
2.34.1

