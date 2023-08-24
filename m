Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0752DC6FA8F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Aug 2023 10:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239970AbjHXKRU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Aug 2023 06:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237235AbjHXKRE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Aug 2023 06:17:04 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2077.outbound.protection.outlook.com [40.107.7.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F21198B
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Aug 2023 03:17:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSNkLFwVhcVGcnSoM+afWtkpvoBkEOR/2AdyXCBdL3py+YBenJfg/Q/m/4ySDSDEjQhgPKb2bQXlklCCvir4/j7pS9u3Nwu8CePkN5fnldlv70oLqCw3JqAKPUCzCh0cti/KTHmC0y/laHHhrFM2ZJeSzo58R7vk+KkyxRs706pIiqNQw6ZVyyu53HSJLelvkTg9/lllZytro6KDmzZLaNlZZYpc+P22Zg6ifBVXzExjAHp0HyJdKW9Ez83m2YI5HJagu/4uV5W2P0DH/zIGCCM5+8wf5W8u7bJp2H2G5+vFQu1ijrrrm082vV62aLPaRNJiBlzPlag13OsQbMt9Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEiXZ7UYSFwBxeTuHXfwZ752ZOIQL0vFYyyx6AqZ+RM=;
 b=PzzyU+jSXzxjayQHQtzEXgDFrsAicTxMoTauxt0Q8IYlNHBKzXvCTf3wEDd8U8iZp2vQbrmZSepVqLo35EONfM0GS92nAEqsqpszX33dLZIfZqRfOwXHIgX7DIflxNk7OSRZUrIj3Yx8i089tktXAWmYA3VbQoxhjBYXUOEACl9eM+lsVrP+gc+cQKjpFKvc+LggjcvQUW9bjJNngjsuJir6rUqASE3CPFa4CZ8PhIaPuAl0rAN72lNL4f9nW/MwOCmy9acvMSk1AFwpWzbfMqyCFw0DvJALXmtPz6+5VWQwv/h64Yyqa9ScE7pdLY7udmpEVq6zDfBfc1r+uGZ+hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEiXZ7UYSFwBxeTuHXfwZ752ZOIQL0vFYyyx6AqZ+RM=;
 b=JgDa8mc0FFfUS3XlhuVCsHnR8vPX/88wXHu1rJSOOutW/pu75+HBUDuy6uf1bQmU8J15/hC/LcRpTiNRDRcnaT9Ivg/C7cO13UyKC+EnVXhK7DpIf7gv+RCD/ce9A2Vuk6JwCPa5QjQjLeSA4JSF2+gIC4dPcY7g12hDhQ2BI6s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DB8PR04MB7034.eurprd04.prod.outlook.com (2603:10a6:10:128::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 10:16:59 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 10:16:59 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 0/2] Add support for handling encrypted BIGs based on BIGInfo reports
Date:   Thu, 24 Aug 2023 13:16:33 +0300
Message-Id: <20230824101635.25662-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR07CA0005.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::18) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DB8PR04MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dc95a5a-4145-4fbe-1b5e-08dba48b40b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: plEnZoUwo2tv4LDpm5X25qMvJMUNCMuJoUGglj2bAaw0xrB1BV8YcG7hBFbtOsv1QOsKuySf+6Hujv61AONfkckBzAHcQDY1xc3iwfWFcMfLmZCHPcp0aqAYLQteFdvkrMnPHBqKNm+gFZCfnCeecvIKCw2tsfGWq1ARliC4UXqU9HPBh7upCYjtq+LjuXx99eQVEMTu2w0Rrysa4iZOoxZfc9Wni8Q1VPaGW7bMjxZ9fFUiViHzSIxUHNbZFPNeHwWz4/1F3wlwpBOk7sIdTj57m2oEvJuu8kpNwG640QYizRZzQScPfu44V+2iDf0oUr2dG73K/PRPX7QPL0+u6nZ9O2k1hAxLy5Z2PDjf+xQThmwhuKUpQaB89FEtlKb1+FOrAuVCQLYkYjIsbS2XIWgMk69uvqkHCPPJJESYpk+dFRti9bPsgZg4GCS1pfLmTHfRKogts8oNFnWFVZlbmzvu5SVHNsKfNeDgP9oQYPnWM9x1kbesQ+p+Bi61B43xfsHGBnYeeKgY0QOSYNDnY1YFg8wrbYGjPleWZ6EpdgQ0mMcsdqIiYk08yxFOne0iXLamzlKsGeCX3clNtvuAX0hi6K7/BIBQ+jzGkSbk/oSvGigXKQK+FxRoIaQc4B7R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199024)(186009)(1800799009)(66946007)(66476007)(66556008)(6916009)(316002)(478600001)(38350700002)(26005)(44832011)(6666004)(38100700002)(41300700001)(52116002)(55236004)(86362001)(6486002)(6512007)(2906002)(6506007)(4326008)(8676002)(8936002)(1076003)(2616005)(5660300002)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wj1tZMhl8TnMy54ssJEjC4BDXcKlGLDR5XvfIYKWi1RjaAqtGS7R2ZxXbCk3?=
 =?us-ascii?Q?hqKgk5wJR1qV9BupBJR5sBVjXJQE271pWWrAu5AEiCEvl2BzwCe5bfT4wJL9?=
 =?us-ascii?Q?bskKvZLbHdnPXe6NOGTmJ5TVq63IoYvtXmP9wdSmTR1xI5wGrM+FobuXOkfm?=
 =?us-ascii?Q?yDcmLosolmYPF5sAV7dC1RXy4PIWn+D7wB/4yW2GkobH6VpJiQDVFW8PylUJ?=
 =?us-ascii?Q?/ybFrfr5xhS25alMwCRLbevLoLLG2qwQimgv6DYCR0npPiSuOWgGzg9J2yQK?=
 =?us-ascii?Q?8acBH87z0pRGEvy7DscfM2Jtzpm/1BVGlVrPQXRPQTmqrLlhcLAxjwBbk4FW?=
 =?us-ascii?Q?DJjNw//9Aqm85GpHJrWNXQaAKa8mEFV47NkT1fQbvpCaspPGzlBAooLlhMSn?=
 =?us-ascii?Q?hvIlG41WRPUCpyob3A7gjnqFbWA6uRjxhr1ELHmh09JPxPj9tdZOJHGs7JMs?=
 =?us-ascii?Q?kHFkwNPr/qR58+IJShw1Pc/tZZ0i/azpkar0VS/P66FMo/yLvM2KWuMGDHOH?=
 =?us-ascii?Q?P1NguB2uQsjUxyqcZUtjPQKLGRdRbgX4VDoxo7CeM1DX1AJtH91/86QYNM7b?=
 =?us-ascii?Q?+JO8q1KEtE/b5jUTIRjYeom+DQhVJ47UPUjsdSLSUhlrrQkvyd9KFTPl8+dg?=
 =?us-ascii?Q?RRpJoFDX78YuxHjMpC4gxLuD4edWsHVIIjvZG72Lkmq/0ozzIO8AC2auGgma?=
 =?us-ascii?Q?u+N1OEHdb5BVgPAV29P/uMRP1QvgatomnILsT8iP2ZDabn/VAOKOD732ZNaO?=
 =?us-ascii?Q?4sZai6VJfVHeIT9XEeqUaIvOtXBW/To1KuAnlnCkE/Xfl96arXzm6figyQCg?=
 =?us-ascii?Q?iuY/4RDc7xSgx43BfAvvVFioAcl4uiY0DArj8yW4FoGPP58ES+fXVHEdltJt?=
 =?us-ascii?Q?a6+BL6mvysyiYwsAjpzbY7pZ8RJC2fEBSiK5KdTXZqPwO1ocL7QUmd5xYnPz?=
 =?us-ascii?Q?Exrd/3h+2F8Ct2am9XyzT6vvNWkiPymg4f1/tPxCbtcFw6F2viOqIeK9z7pi?=
 =?us-ascii?Q?gaNij81xfrncoaxdP64f8qqgd5MVdm71ZmhyuFv8LBBHxnTPQAbgAw4GLsfR?=
 =?us-ascii?Q?P9uDJCgpi2uMJcLQpWH+gy70XjTBc0gAeK8NzUP+7vU9z9x432VGLU/kDfI1?=
 =?us-ascii?Q?8Xe0gLeWc8G7A2QbD208t18MvKWurgwxI1GG2a/RuxgcwvF9a9DHviGcTEHZ?=
 =?us-ascii?Q?+Vl22t96MljJlLgGBBioXWMk/5sTQEgBE8OcdMFMyXe7ncTWuxyh52jPWt6v?=
 =?us-ascii?Q?UL5LRRfSu8xly/5lgsyXUuSYhC5F6267XhH7fxr5amMbRMPOkMA4MYZ4ilmR?=
 =?us-ascii?Q?+wMCFGZyPVjt5pEbFjG37xC+40RAzvjoSMltsF3Oaqf0jSeqO8Vm0YO0zes/?=
 =?us-ascii?Q?O/h8cJTTJKnGwdVeL3s0g2IkB0qFtVzQhwLsMOy5EyQ+J3HgbwnRx3fOuJb3?=
 =?us-ascii?Q?vb6O1OiG9PabUSAv1K+JT5vLb/f3zs3LkzAP57L975Z0rnf9Tz8dcTc3cDha?=
 =?us-ascii?Q?Juos+AQbIRJqKDlCcQh0QcVlM0oiQbj47jFAdsCdOlm343keARsT1hcfxG4c?=
 =?us-ascii?Q?94axQ4SqHGDkbDKuo3rwA65/lQIQdKOM8nXkiejCKd1XiFHxUkgQj0iG6gTz?=
 =?us-ascii?Q?bA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc95a5a-4145-4fbe-1b5e-08dba48b40b4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 10:16:59.7853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BW4VIaRdntAI0uvcYe3GUvtcQ3SgwszSf9WhWNJPHidYUL0BqDUpM1Yy0MFlP7Vr7sA/seMDalQgNdSj5SBGoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7034
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch introduces MGMT events for BIGInfo advertising reports, so
that the event can be passed from kernel to userspace.

This patch also adds the sync_handle field to the bt_iso_bcast_qos
structure.

These changes are needed in order to implement the BASS Set Broadcast
Code operation - a BASS Server is required to inspect BIGInfo
advertising reports received from a Broadcast Source, to determine if
the BIG is encrypted or not. The Server is only able to associate a
Broadcast Source with a received BIGInfo report by looking at the
sync_handle field. This is why the sync_handle needs to be available
in the QoS structure, so that it can e retrieved via getsockopt, once
PA sync is established.

Iulia Tanasescu (2):
  Bluetooth: ISO: Add MGMT event for BIGInfo adv report
  Bluetooth: ISO: Pass sync_handle through iso qos

 include/net/bluetooth/bluetooth.h |  1 +
 include/net/bluetooth/hci_core.h  |  4 +++-
 include/net/bluetooth/mgmt.h      | 18 ++++++++++++++++++
 net/bluetooth/hci_conn.c          |  5 ++---
 net/bluetooth/hci_event.c         |  7 ++++++-
 net/bluetooth/iso.c               | 18 +++++++-----------
 net/bluetooth/mgmt.c              |  8 ++++++++
 7 files changed, 45 insertions(+), 16 deletions(-)


base-commit: feed554a67ab7a602cd26cf6a4c44093dd54d4b9
-- 
2.34.1

