Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B1FEB64DC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Jun 2023 14:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjFSOxx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Jun 2023 10:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjFSOxw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Jun 2023 10:53:52 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1A5C1
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jun 2023 07:53:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRScENKaUS6V196MLTWLcUITjRuCDTI2XS5RNS67pDl9w2c0dwcvzKc8lWEdnp4D/EmasXf9QkjBE1MC3IkEA2tA1rsb2sG1ifhQSX9vomHJZHAJrf/+jD72GWZOiA6JiEbCedHAHYF7FAqOMRzq1sydRvHfBS/GFJjkERWBOts1PCDDVT9YqUOQY2HlBTr0LJV1nyN6MHt9X+ZJYecsIAg+1Avzf3fg4UCzfiio6bPrqyz6eXeBoeWTb9ZXfUoXca9oe9I5jrDpHQvAMwyUEvCnXmSqHm84ukcuZlkAwW2XULibDGEh4mINvfFHtIz4zqXWkeUKvbrJ1OG0ycNBhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TepoPXJ34oHWmreyGigQaVxOIzTq9uMBM7ZKVMcNGKU=;
 b=kvCh/FBI3ozQ004S/R2fTrmYN3FJ1btclBChlRZ1Tqzu9AqcPYOUCk69sh7V8dB2h3p4UOvD8cQTBTtvDAapTK53c5K16ztru+NPKwfvv47KnEf9V8dEBjtQQN0CiByVxYnsNhWW90Z1oczCMWkoDcF0BDK2sEgDUo3Pt23DgUYoeBNyf79ThW/HwZw9TjvrZFF5S8kaQueAWiS2lZ1X9Y/awLgTFw2+QT73W0sXOsFBZHoo9Ml9pU+IGqKDGTzLluhavUaSxKV6jJYeB4GIa9GKfnGo3IFxg6dujN6tcrTryBeKTmja9XkbmdbpvPyXH90pWBKNJ5rhf4JAwmdmiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TepoPXJ34oHWmreyGigQaVxOIzTq9uMBM7ZKVMcNGKU=;
 b=qFfmb+X4uOIDaijS99Oargt3Vdh/x1Cp/C/ARi/4+PSPj1hvkX11AomxQOeXWCrDMe7E0p9OPD7iuSZEEJOCblmT5igTHFCHOT5rYaQXJ1M1GxvJQbIFnLPe8aYwu8uN47q16XyTG+ksODprUqTX1szg/CEl+kq1M6Mptdgt9+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DBBPR04MB7579.eurprd04.prod.outlook.com (2603:10a6:10:1f5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 14:53:47 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe%7]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 14:53:47 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     mihai-octavian.urzica@nxp.com, claudia.rosu@nxp.com,
        andrei.istodorescu@nxp.com, vlad.pruteanu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v2 0/1] Bluetooth: ISO: Support multiple BIGs
Date:   Mon, 19 Jun 2023 17:53:15 +0300
Message-Id: <20230619145316.3185-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0012.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::17) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DBBPR04MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: d7fd33c0-7028-4b90-224c-08db70d4fc79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZzvoNyAIntBouLN4LbCfyksDFWzWmiCRRVHSKtJrrVy6ocI3ZFNjOgxX3bALGg4TuFhp77qjt2S8OAb6854VWt6oT6/k6MGSOIahHXU2cuXgG+ZXWhGxGSFvPMRtTwZ+tjBpzk1n6q5ApcYO9Faq6lz9SlLkeGr8jF5iVN3r/nL8cSQ6M995jhKO9nthgDtuY/Gg/bWCSq3AGyFAyT/OM0oWcKMD5MUN8S+O/DjfVwVFML+BY2S3VcxIARuDiGVEvq8DtFwRqQPjqgtImV8gn4Cf/voYqnXfe5kH+d66dZktSHh2l9/VlkRq65TpXcMi6eFOOJwbdM1dx0DK3Dz21W1mz8yeKzkxHJ1U+0TACXyP3k4X6cwEGB1htRcTfBOHvRxSPJXxZzvJZ8ZWbZi3feYHV83GMmK9TFFuGTYX30VOdony90wKrgv4/cfg9JQFp42miK9sypaHpQ/4fE6iMhOd4u9qbxJaY9r4O2e0W+Mlj9ueQ7J8nhOSI5cQjuY9HDOwe2ZWI8xmAPf22F0OYBsQf1848PuuIau93+P2XB6MUrSfNuCdB/XQmk6yhR/lvD2u4mp4BnkjVOwXa+kFfC55aWz4OWleSstLmBxIrw0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199021)(66946007)(8936002)(8676002)(66556008)(66476007)(1076003)(26005)(186003)(6506007)(6512007)(36756003)(83380400001)(41300700001)(38100700002)(38350700002)(5660300002)(4326008)(6916009)(44832011)(316002)(52116002)(2616005)(6666004)(6486002)(478600001)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K8llYmpDa4bPV8aIqgMDui5oipYV4Wnoe3PEYSNa3mliR+fvcvGByAqE8xEW?=
 =?us-ascii?Q?ToRIKaFk/Y1XE/IFfNVgo5p6/lGmIxa+xmDK7IB9QXqB9nFy2HJue8nCfmt2?=
 =?us-ascii?Q?WB5QdPFi3zog9oYhUAli8FL9PPQmsUBFyRciLxaXd9VABvSN2pnRAtfEB11x?=
 =?us-ascii?Q?MHl379XriGxe04N/8WT/HCTPMJs3f/iK2W7C5PbfKmsZlFxr7BjkwdECtaj9?=
 =?us-ascii?Q?Hokcea4jKl9MNCilYdxJ2UjBXe5TrvlXnLioaPCsL6GjMRzXa7Zs6lwbGCdW?=
 =?us-ascii?Q?XGtWSO5Xu6MnpKpc49YoLYZRzOMXUqCWvZIo0QKNFvX0PoTmFrwKdmuz4lRt?=
 =?us-ascii?Q?wArbvkA7Q8HQJWK6rUvccWQRwxvOOyeQpUYCSkISfO0OdHbULC3kHBdu/ESt?=
 =?us-ascii?Q?HGcVLc1JDHgfnNw5wIkaVMCh+FrD99nQ0enWTcA9fAj5uKbvDVcljfUs9CWz?=
 =?us-ascii?Q?JMxkangsmxA42WeQ9bua0m/IK3R9od1IO+T8VKApGS/fIrZ8XbElc1UAqfjn?=
 =?us-ascii?Q?M4E89EJlzJzI7yCt0ZR5W6rLwUrMoOed9mN/+xv1gSinACr7L38vhPMJ23sG?=
 =?us-ascii?Q?f9IDhwiyb0dE/MYN2tGcMBxPS3ABy2KBWpAc5YnxBhhbj0gA3Zl9bgA2smzc?=
 =?us-ascii?Q?UadAPMOhlP3Z1Lok2gXyiCMDwcXYRHDuLbXf/zaRLl1IhAZ/sF++LDpBiFLJ?=
 =?us-ascii?Q?IIbONhk5inzKcEpmf4zHzTvSovnaTzwdYyAjyomw3CkExgaoVQKKZL4TpbxV?=
 =?us-ascii?Q?bOVeswhnC9+YFosuENNJxeNKMryYFj2rb6cKp4Jne+4xt44J7CTfWVUIngKC?=
 =?us-ascii?Q?5mfTL1ohmFaZNmrtlw9v1PfR0bPaLQDHtiqOx9Hl/eDeg0OT2j/4JQR73rdJ?=
 =?us-ascii?Q?HQFI+cQlzlu8RV20Knn27k+zqpKMTJHNbA/S9un5dLKMYohruORo/HjQM+gP?=
 =?us-ascii?Q?Rn6V2p0i8z/4rvIYD/Nd28aEN09C3BC1M5R4WjwHbDSy1wiMOkbtJlDN2K2W?=
 =?us-ascii?Q?WVGpOE0/IvSEGjNDc1xPKKWtV9+4ORQIfC6c+YwwbdV3Bm6GpfBFgojysmEV?=
 =?us-ascii?Q?28IWOP77747dD4I9GQVEK3mni+tgZXMLEajt4uLDKZmxdzUk10f4d293MIRa?=
 =?us-ascii?Q?p94FaQc32o4zam9qQPi7v2n9wimSzjigL4f+6CmbvQlSmQkiApmYFeLZ/WTu?=
 =?us-ascii?Q?nFS75f63gJ75zLL9aAP2B8SATFge2vj/j0TLlMK5qTR7hAJnP61TNEceuC7F?=
 =?us-ascii?Q?HLL+LapYK8AzIbtbQ/dxeWaMT28HctnmwaPWNDtEkJgQOIGI6hRMSO6hCtk/?=
 =?us-ascii?Q?qotrbkXg7QGD0fnu8e43S9MI7XNMlPQnnfuqu8F2ZFV0FRWZemHP8upmNbbB?=
 =?us-ascii?Q?HtZpqxWhZcRA1O3x7gmDNBlJ5JMtkYwIEz45kxuISVhpIgNuEpQfCZsQQKMr?=
 =?us-ascii?Q?FG6etf1KQldEV2L0EQOg0USV8GsxlkRZN+Xc0ZBxXx9R6U2hhqBdBkaTYmYN?=
 =?us-ascii?Q?tyK2JE3plRDmT1VtOM2tP6votegSm0nffiZPy7pgmorYm8pKSv5w2lxF2ZcK?=
 =?us-ascii?Q?IiK7FPOP4ZgZqF9OjEN+drmgd0ZNOrKu+V/8S2dFwCoerW571ZUs5SdapLUF?=
 =?us-ascii?Q?QQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7fd33c0-7028-4b90-224c-08db70d4fc79
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 14:53:47.5602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z140XgDRjZungo6J8Kule6WMBo6dO3xYgvSywNEwMz0NlDzP5aZZukBKTIS7t+AVEn+oSYagaNY+VLIkFdg76A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7579
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds support for creating multiple BIGs. According to
spec, each BIG shall have an unique handle, and each BIG should
be associated with a different advertising handle. Otherwise,
the LE Create BIG command will fail, with error code
Command Disallowed (for reusing a BIG handle), or
Unknown Advertising Identifier (for reusing an advertising
handle).

Currently, if the user tries to connect 2 sockets with the
BIG/BIS QoS fields unset, the kernel will assign the same
BIG handle for every BIG, as seen in the btmon log below:

< HCI Command: LE Create Broadcast Isochronous Group (0x08|0x0068) plen 31
        Handle: 0x00
        Advertising Handle: 0x01
        Number of BIS: 1
        SDU Interval: 10000 us (0x002710)
        Maximum SDU size: 40
        Maximum Latency: 10 ms (0x000a)
        RTN: 0x02
        PHY: LE 2M (0x02)
        Packing: Sequential (0x00)
        Framing: Unframed (0x00)
        Encryption: 0x00
        Broadcast Code: 00000000000000000000000000000000

> HCI Event: Command Status (0x0f) plen 4
      LE Create Broadcast Isochronous Group (0x08|0x0068) ncmd 1
        Status: Success (0x00)

> HCI Event: LE Meta Event (0x3e) plen 21
      LE Broadcast Isochronous Group Complete (0x1b)
        Status: Success (0x00)
        Handle: 0x00
        BIG Synchronization Delay: 912 us (0x000390)
        Transport Latency: 912 us (0x000390)
        PHY: LE 2M (0x02)
        NSE: 3
        BN: 1
        PTO: 1
        IRC: 3
        Maximum PDU: 40
        ISO Interval: 10.00 msec (0x0008)
        Connection Handle #0: 10

< HCI Command: LE Create Broadcast Isochronous Group (0x08|0x0068)
        Handle: 0x00
        Advertising Handle: 0x01
        Number of BIS: 1
        SDU Interval: 10000 us (0x002710)
        Maximum SDU size: 40
        Maximum Latency: 10 ms (0x000a)
        RTN: 0x02
        PHY: LE 2M (0x02)
        Packing: Sequential (0x00)
        Framing: Unframed (0x00)
        Encryption: 0x00
        Broadcast Code: 00000000000000000000000000000000

> HCI Event: Command Status (0x0f) plen 4
      LE Create Broadcast Isochronous Group (0x08|0x0068) ncmd 1
        Status: Command Disallowed (0x0c)
        
Since different BIGs need to be associated with different advertising
handles, this patch also adds support for starting multiple periodic
advertising instances. If an avertising instance has the periodic
flag set, the enabled flag will be used to indicate whether both
extended and periodic advertising are enabled for that handle.

Iulia Tanasescu (1):
  Bluetooth: ISO: Support multiple BIGs

 include/net/bluetooth/hci_core.h |  5 ++--
 net/bluetooth/hci_conn.c         | 40 ++++++++++++++------------------
 net/bluetooth/hci_event.c        | 35 +++++++++++++++++++++++-----
 net/bluetooth/hci_sync.c         | 28 +++++++++++-----------
 4 files changed, 63 insertions(+), 45 deletions(-)


base-commit: 817efd3cad7481ce2ee25fac5108afecbad56228
-- 
2.34.1

