Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366CCC7EE23
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 May 2023 06:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjE2GLW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 May 2023 02:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjE2GLU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 May 2023 02:11:20 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2070.outbound.protection.outlook.com [40.107.105.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79270AC
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 23:11:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KugjLizhbpzPnlVH96Bp0iWSvfmDBgOHvMqxph19negNk6yJwA8NCye32v3oekzpttf+kg1NClAGaE7uAsIZhJIWb8JWGhKZ+c9XFt9IQsYEY6chDUADcj33Ol6Snb6q55oq1o+JqYqUOZdvnAzZySBtePskCNoOa9VVE3HBZkhZ6pTvMS2ODAmNZAufTyvQw/9rm1zxlEQnWI/0M0eU/VbnsfjtfsYRZaxHqo+LKt/2Ap3F//is0SLX+nvN898bBcFdq7OA2nM+ZGvvsJS0n2mnONV3LvbVG0PkV8rWdPMENPEy5hm89SOPZ2y1mSgnK3dTMP39G58r4dcglYyVHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5R/1ebnmb/CDv/r6+vLH/yt730YgbS3IyFu8vKUyd4=;
 b=I1/6uomACkTejgRW+DnVRPT7FLfHfLWmGT9ApJhxcZ7+RssLrr1nzGifHtS+L0yiBAWGppJeAJU8DwxcOVpS8tjnxipgEVgQkQcfuIREc1h4DcKzmPPkPWN2vftcYt5xrm0Zpmr/u+lRRNjy7Z0jImry4QA41LCHuvBTDPG8/64pWk9sC7qlj3gcf+8Aec+D09es7pcyXPiz5J4RMR5LdNiBd6CFjtihsGmsMshF06hOMnvJiw2Ue8G55b9cpP5hSLCAoA3YvWvjMolKRHgj7uHzoUelRL1stOpB2irTnvw63wQBXBMFM/ypmVHXYviqio7cJ0nhdIyiv4SD6GvNlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5R/1ebnmb/CDv/r6+vLH/yt730YgbS3IyFu8vKUyd4=;
 b=a3Ba8Pgzse//TAVw9cVgbKxfeidGN4Ppq2rn51CyyYHWBOJvxPsuK7HQjgMNb6/n84jqJ+X99i6rh3KySwGNBovmz8EI4w1T+TB9ZlmyWEgwIc1rLSP14qZec72HzvpzqQLUhppimeYhnveZbCaJdHfPSLdZWtudeHg/RekW0VY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS4PR04MB9651.eurprd04.prod.outlook.com (2603:10a6:20b:4ce::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 06:11:17 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%4]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 06:11:17 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v2 0/1] Bluetooth: ISO: Add support for connecting multiple BISes
Date:   Mon, 29 May 2023 09:10:56 +0300
Message-Id: <20230529061057.3107-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0013.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::19) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS4PR04MB9651:EE_
X-MS-Office365-Filtering-Correlation-Id: 63cd1689-4a39-42cf-81ae-08db600b8390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aBQ3AV5Lr/1mkL/MlGKD+wJr8Lkc1Bw0i8s4tDok4ZsGX6obROy3OX66wI4GMix5ovVUp3p6lIRIBn/Th0Mq4k9RfH8Cv41I4ko3ldZR67qO6DKov2yFmfZ2bxBIIwO92LvAXmdZ80HVGCu3X3TqAedsTFaTiGAyJOPtz53azQeEz4F3yma69YeOS/rfwKGsspFTe/Dg/6Wik401mnjRfAgAOtbnG6jXRC69m/HftTDjq7eGLg1Xl93F2sAajhqoWoNDRdJYC/W9w/VlXGSjTj6wOWDoNNMkJNFDjCXcjNrGXgfkAd8BnAdBCGo/H0MEOp5NZOrjFKAaHjBViokM+OxRAfYYfVvzCxVWJT5the4kPf/unp1S0WYpeFDaIsDNyIDDEwOWKWcY2N8po4ZNWFpqGJKk40Vmbc76Q17O/Ab37fRCNe4AObheW6SC2WlRYnh+xr12r55yjLH5u/LbfgdSKWvpPnMJyhTORS23hgRNES5egVB22W/YbWjiORZx84GO/T6XTxGIB8GKqhgLK+tu2ygocgOx1avNoqQKqE6ADNfw9UCLxRT29Y0pee7v7EZyat0PS80RK/mvz8EkQ3TPvRDxxtl8VyZwHbmnzCDBWjAjsMFhfuUi2pft+2SF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(451199021)(26005)(1076003)(38350700002)(38100700002)(41300700001)(52116002)(6666004)(6486002)(83380400001)(186003)(6512007)(6506007)(2616005)(478600001)(6916009)(66946007)(66556008)(66476007)(4326008)(316002)(5660300002)(8676002)(8936002)(44832011)(2906002)(86362001)(4744005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V/zisZaS5PGkYmNrdwtPccTTilHhNkna1zEsAcX7jFO1uegVk4zkIsuc0daM?=
 =?us-ascii?Q?xoAAdgdaLT1vTKuIQCO25l0MoUUsQCS01BMM8q9avlLaZvLBXESXbypRqUfy?=
 =?us-ascii?Q?LQFXkOnf9cuobTLFCtgPwuLhAOEa+ha8T+OwZtHiN+iecz/D5GgkzvRpqqxs?=
 =?us-ascii?Q?chvvWHg3bRVNJUFD7GG/3La8Yjgz8mKHM5uWlXRP6NKQtQtLQdHp2jqHc9p/?=
 =?us-ascii?Q?RaT4mM2A4MWmUt1o2Xw92Su2u173skBnuR9C0TNb9GZ05KxL9JCZDW5neEri?=
 =?us-ascii?Q?lJiGrBQF2SccBigAmUGqD6Ws4HQxk/8IKbdR16Y97zx5+fYtDSZguQY04zbN?=
 =?us-ascii?Q?h2C0m73TTiwIgAVceFMaFUo+i8BtKZqfQ91KhDT3V2jEfJhFVPgRyy6nVOmS?=
 =?us-ascii?Q?ytjXy7G2i6FZncxkJ4/aOLfnKJWNC0FFWLkqngJFsz63f3VZXiMobMumhCX1?=
 =?us-ascii?Q?ecObbKsIwuA43Bt+EVv4gY7OUyucrWi1E1b5OD4/l5S7qztoJrd1VisPBb9c?=
 =?us-ascii?Q?ycmO6mQTIb7ZT91JxyOhk4fybA7ZdIFI87M+BqddM6ivkMgsqzW0LhWB+TzS?=
 =?us-ascii?Q?a9sV6fozegi4sCdkiwzLqTohVshvVvkQAFIUPNz1erBH+rcTXcF38KaNcvEl?=
 =?us-ascii?Q?zqxZcnBCzHlSia8uR6Nk8PA+orEDSAWSJyMEQPhUhFrwkUbRt/Z0rvni1EwU?=
 =?us-ascii?Q?PEMO1I2LIXxvmw0cBN6Pt0nEE5WdrTn9ZxVI5r6UCDcWJXMYF0T8g6++QN4y?=
 =?us-ascii?Q?hMYZPf9r+fsr+cIEZnJtAzqzEBFMT2eCbGyR7kUnA//rTGSmfOxjfA+mdDlU?=
 =?us-ascii?Q?4qabm7ghSDKBMPGv4VQLGunxbC8TJkIKY7WHCF78MkPU1ACgWOXwzdkR9T/X?=
 =?us-ascii?Q?Eh21QgDHH+yMnhKFz3VqInWdEfQ7t01I0jhAGb43koZggxT/K2dQmS+DoDUK?=
 =?us-ascii?Q?SYFaxZB2BW3BpM0unfsLMp95Wzm3VnKF3lVqHbW2CjZIRO7r8LzhVZwC/5OV?=
 =?us-ascii?Q?3V+PAJmN3V5d6ywDcbxOdmzgRjn94x6RAXrXDHR74VL/EDUXDfcHCUx8jgMm?=
 =?us-ascii?Q?Eomtr2rrg/0+JIvyGEwywcC05l2dc511AcFAwxEe12fZLszfRARZJuOKP9om?=
 =?us-ascii?Q?TifyNfZ/SdXBsuer7v8fIR6nuXJQ3MXaegs/P0gGkub9ai19QaUwaIbo6wvd?=
 =?us-ascii?Q?nZSUXxdHfIuc+XaeiJkxJS1R1BxNID2rgkhVG5TJ2gCdgAq2cqNCSW6Sohhj?=
 =?us-ascii?Q?VST6WICVP1fQhkk3S1AI2Z78C8gIz/3adjVzdOKydGfrstX1uekfKFvoREGI?=
 =?us-ascii?Q?JsX8HEaJzBxKoKNSBQRyIYOFUo3xB8oqcaIGEbB44ZttID+OslcG8utir38F?=
 =?us-ascii?Q?xc3xcvQV/kNd75W4cMJRPbLLV5wK5lLa9KfNk4nvB0dr44QJ2T+1klv0dUQq?=
 =?us-ascii?Q?qWGP9/XEDQfcQLEMmjwHNPgMhESUPD1j+ZEyiHwa+l12Wq5ShDy7rval9rW8?=
 =?us-ascii?Q?xN8cUxcGl4Z14otqVbZgLiRZvnfZYPu1PBHvMNwYSkt6bxC8j6AuKsVklU2T?=
 =?us-ascii?Q?+ZQB4xgEdXH0OrWxnlfZ4K6m+w9olqK/3TdDT6SI6Eoie2nAIpPd//6SgVOM?=
 =?us-ascii?Q?vA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63cd1689-4a39-42cf-81ae-08db600b8390
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 06:11:17.2465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7FYUopzk63H06BgqFLYhuO7HVaqWlVK0pJWa6p47uJkf6Uf2bQ93QNMQhS/VDhZbZv0+/C59uHQV5uQjr4YW7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9651
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch implements support for connecting multiple BISes as part
of the same BIG.

This proposes a flow similar to the one implemented for unicast:
DEFER_SETUP is used to bind a BIS to a BIG, without starting
periodic advertising or creating the BIG.

Connecting a socket without DEFER_SETUP will start periodic
advertising and will create the BIG, with a BIS for each bound
connection.

Iulia Tanasescu (1):
  Bluetooth: ISO: Add support for connecting multiple BISes

 include/net/bluetooth/hci_core.h |  30 +++++++
 net/bluetooth/hci_conn.c         | 147 ++++++++++++++++++++++---------
 net/bluetooth/hci_event.c        |  50 ++++++-----
 net/bluetooth/iso.c              |  28 ++++--
 4 files changed, 186 insertions(+), 69 deletions(-)


base-commit: a088d769ef3adfbc59ed86660d0de2abd86660e5
-- 
2.34.1

