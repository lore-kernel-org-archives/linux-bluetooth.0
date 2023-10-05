Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634F0E92714
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Oct 2023 15:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbjJEPpS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Oct 2023 11:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjJEPoy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Oct 2023 11:44:54 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on0626.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1e::626])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D8A261A4
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Oct 2023 05:16:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lT0cM/1OFRQ0rp0fjb3mntGx36kGch/23MnOWS9FLdm8NVUxoynJubR1u1SEMTPUREI289XDq03J2RbPLLMGR/5aPyPuRYAwf41rX40UHCkPx7EBHGF/Z4uBDaNr5JO2jbvSSKUYV3+a5jYnN+zvK3oje/VP2a3dpAgVf9EFi+3R/W/2kSvE+IfDgOJiyl5CpzYv+B5S70hr5LgZqHKjvEF3UiIC+O4QxtWwhGtyeLjd4qs19Ad/HGWLiaDTC/47QOT8dS162stkQSJthkNe9Efh8q4lN5etQuuHCTH7QRl0IVVz8Kxk+bV+hQfVBbhXRIId69WreA42RIu0nUqJFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeBPjaVwE2QB+bRy97g1cellZqma2wfBBlfa44x2riA=;
 b=Xfo7OD2HEHQ0eWaB5Z4TjVvDxSIiTG14NrgNp6McglYm8AlqZdTW+tEPUKTWqr+eB82GIYwRZWk4Wvq2t6mcYvkV3EIKnk1fOfTOSzNoiU2UDbmcYFr++c6pBtiyy1sarHtVJLNywDFwd7Ur19/bcrQus6P9el9/z1LTM1L07BuMWBdb/aV6QrUElKO74g28KsjOgMARnZrxXS/48D/Ujt5BBDO0sXrgvjkaVUGVvcWPl2/DZz4a273L7JpjO7QV25lqbNi3e0IRwJlI/75jAGhH+PWQOMIGW52YTn7pDikqx9eHWn/JDNLpG7GM2f8KBlAt1XsPbDhZ7PcxIr0LsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeBPjaVwE2QB+bRy97g1cellZqma2wfBBlfa44x2riA=;
 b=QCOyFMnxoc7F3bxCSrSZs5Es4AJpcqyYm2S3EbQ/M37o7Q4g/yKWnj7YWr8Nf04zVI1rj7K6FBg2PV8xiWEYvEpxILXY6bp5f2TZrUPysB/3nyeb7Sq4et/44T2/jS3SIsMDe1OQNr2nvUbQvWrd0VZ7DjxJ6fK/AKHDJ5hXN4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9654.eurprd04.prod.outlook.com (2603:10a6:20b:476::22)
 by VI1PR04MB9980.eurprd04.prod.outlook.com (2603:10a6:800:1d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 5 Oct
 2023 12:16:08 +0000
Received: from AS1PR04MB9654.eurprd04.prod.outlook.com
 ([fe80::74d9:fef3:348a:ef3b]) by AS1PR04MB9654.eurprd04.prod.outlook.com
 ([fe80::74d9:fef3:348a:ef3b%7]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 12:16:08 +0000
From:   Mahesh Talewad <mahesh.talewad@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, devyani.godbole@nxp.com,
        nitin.jadhav@nxp.com, mahesh.talewad@nxp.com
Subject: [PATCH BlueZ v4 0/2] MICP-MICS implementation's memory fix and Unit Test case's fix
Date:   Thu,  5 Oct 2023 15:15:42 +0300
Message-Id: <20231005121544.306495-1-mahesh.talewad@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0017.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::11) To AS1PR04MB9654.eurprd04.prod.outlook.com
 (2603:10a6:20b:476::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9654:EE_|VI1PR04MB9980:EE_
X-MS-Office365-Filtering-Correlation-Id: df34187b-4381-484f-6d01-08dbc59cdad5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xz3XHosax28dDqOJ7s4GPb90Bpzn4ukaf1hcXZnkMPttxyCwSlMj3NjZMHSRd5mtYjJCP8dRlVww4KBA74JiTKCeWTxVNJ3Byh/Je1p2C9PGhgQHRzkHWueTtr5sKkSkvt5qOpYtr2Ky0NgGHbvBAY3ueO0aYqeEMjP301rIU/AgTnPeqQykeKramlN8eHLF2nWK9azh0t4J+HDBYFRSWj72lUDx9kMCWuYIuMveelHYauG6hyUn8GR3B47SEyVhf7+QO7mb/SjO13nqPv6nPcxEM9NDDhHuomxxGSfUpJxOMLo7W49Rgq3TzNBC/uJcEr7J58kBEqp2h0FvcV9f3n3J5mY+JaBbVmA2As3Ep6UPEvdYgLr4aLFHRHzw/bDZK60Fpcnrd1pSKeWbMyGGtNQt4opTT1vLI9c66nnmetdYaqUZ6PsHGfPGRRksMszHYUVPXHJL4OgHBgxcWaJaL1GBqUla7rlW/l0G6TLZdpM1AmtdDmgWE/1T+zplc1mpU2P+DmEYM10rI/obN4dBS6o/jxxa0kwOf+qDo+S9GiiQT3mgl4i9SXMOl9xk3LMx9eqwe6pTG7l/HF0WnPNQsLiAkDc25FyM/SP5gt2fx7DabPgtg3j1c9L1Rb9ws/eT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9654.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6916009)(478600001)(1076003)(6512007)(26005)(36756003)(38350700002)(66946007)(66476007)(66556008)(41300700001)(316002)(52116002)(38100700002)(55236004)(2616005)(6506007)(6666004)(6486002)(86362001)(5660300002)(44832011)(4326008)(8676002)(8936002)(2906002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VlQwN7v7+GG8XLjEW3waOqV+flJjRIY4CwhVy6LQ1Xg1Sh8Cu8O1roQ6XGZ0?=
 =?us-ascii?Q?L6ZaM5tTaNE9rjoph/yZSRPbSk2/NmUgkHDOB5UoBx5wHNyahkpZOtOGup/A?=
 =?us-ascii?Q?pCe5CX+1iHf5uRkx2pEn7By8iCg87O/tsp+5waCDYpW2KsYegd9KJiEcZKLX?=
 =?us-ascii?Q?Q1/yu6QjYFrIZYzSUZWphORYG93p5wCgF6PXY8iHkeun/kUFdkTXqE+mBPnv?=
 =?us-ascii?Q?+DiAt2q8p9segpgRyakIAeY0TmQWAdo2iuFY+T86z/+VEn72TIjsKzfb8C7b?=
 =?us-ascii?Q?2FpeJWhTM4tT6Mf9M8VgJUnsSqYCu6yMEPyvMURhhmtKOJw/OS5JHLqhO31/?=
 =?us-ascii?Q?s/L+cJxSc4ni/ji12PdZ5eDkBPV5qA+2ZULGLDmS0iPawWQj/mFh/gzuStuk?=
 =?us-ascii?Q?WXcIuptBoZO/sqJAGVHTmcJYC5B2AOKFsbUGeuAD4YAMRc1Qfm/vOidBSeaY?=
 =?us-ascii?Q?TjFO207Pts7fcy/9NX80hPI457cRloNu3XpK9GU8iKsLLqppwyKqEvFZWWrr?=
 =?us-ascii?Q?hNbaCDcgXozyLjs3EYp7jRVDSSzlWpVUx1y2/8O/Zi5tdU7Q/Tokxv83RRaq?=
 =?us-ascii?Q?VvWKSVBgI55ckxK3k4FspF74ttyufQIoC0xvPCOxR2D5heMFTpVrVbkXzXGE?=
 =?us-ascii?Q?Ki2uGWcGV988uzUYZiiXritCzL954NCz/6h63XqEiaw8ADkID5DgDrvHnQA9?=
 =?us-ascii?Q?i00KBJwALGIogH83Govynwe9mu7/6xiozfWIAqpFHbzBvMeO840WYvGU621t?=
 =?us-ascii?Q?xha/ljl+xSD1NMHbOczzZEU3RHfWdxOxukWaCCc36oUx9e2gAgqq8i1oomKp?=
 =?us-ascii?Q?MviPYjTJUZAwPUwYkCOiiMsY1e/nUyB4xqZ4c+L0ScJqCtafZtHGd8JIf30p?=
 =?us-ascii?Q?9yJnIrrEimKAITsjRYWaL6NYS0eiHfpvBfIj1a7kqtJe0zGsfvGNlzUOXOWd?=
 =?us-ascii?Q?va0WfRKAuTzD1dXBJCbF6wgSykgA/1xX4xBOIX7XADwE8/3kfYQE8ndq42Jd?=
 =?us-ascii?Q?GHsl1Cgl4KEQK5dyRb0dWA5FJyCSCGaFH1m+m6Oeqku8mRS71ETFbomnSjuQ?=
 =?us-ascii?Q?pvmVNeWRABq8REIVakCmV53ZrZQctOeIxLwKr2WQgBtPcVRQptgprMEwK32M?=
 =?us-ascii?Q?SWxnOs2BvaUZeCbrt7VhWntiDTSbzMhMU1A3dnX03wgDWl+g/FjghfE7RvJf?=
 =?us-ascii?Q?MYysgU6LFTXx1mECylJGJEBHek7uez6DeLb87xCh/DVZluqmKMQehgx75zHi?=
 =?us-ascii?Q?6peAeuRu9Yp8fRt+Vs4vyrKZmCN29jOJ6sIudX05MZZBXS7qdPz+fEWqARfK?=
 =?us-ascii?Q?Kqpsos6Bifz6yFUFNJCWfZR8OisE3fAKYQA2Vh265MigFYityHOFN8Lro8w6?=
 =?us-ascii?Q?Ban42oe7eHT/eJNHXqgPM1fakaWwW6r/3KwPbSLuXfxzt9q2vKnvj3dh/NZu?=
 =?us-ascii?Q?NnTO81quUA+/EqbWsT7DGhhwaMiqeztbex2UjDJN8hjIdujDvT3gwScJT7hV?=
 =?us-ascii?Q?gzoDHXTdUNZRw9E9dZldJbcdQRxe5BUVSrINGjmjWYNKJfW5lAs0UY1hrH8T?=
 =?us-ascii?Q?8kYuIvJOd/YX0fcFnEwK2WgrOp9WVbDbeQcjC7VFyBC/9KLJb8RjZa2kLRxD?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df34187b-4381-484f-6d01-08dbc59cdad5
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9654.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 12:16:08.5347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wn+8i2ahMKTfGzgqYyY4MZXO+YdyeZgia+94XGk5rOeniOUN+/PJsI3VwyVYorD1JCekM/lSFyV5Lv4DKWUHbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9980
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Maintainers,

This Patch series contains following points:
- MICP-MICS implementation[src/shared/micp.c] memory leak issue fix.
  Tested all mandatory PTS test cases and all are passing.
- MICP-MICS Unit test cases fix: Fixed the issue that was occurred 
  when MICP-MICS Unit Test cases ran at a time.
  Tested all Unit Testcases and all are passing.
  
Thank you in advance for your review.

Thanks and regards,
Mahesh Vithal Talewad

Mahesh Talewad (1):
  src/shared/micp.c :MICP-MICS implementation memory leak fix

maheshtalewad (1):
  unit/test-micp.c : MICP-MICS unit test case implementation

 Makefile.am       |   6 +
 src/shared/micp.c |   3 +
 unit/test-micp.c  | 838 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 847 insertions(+)
 create mode 100644 unit/test-micp.c

-- 
2.34.1

