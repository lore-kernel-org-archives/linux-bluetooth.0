Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6B1CD80A4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Oct 2023 11:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbjJJLG1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Oct 2023 07:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjJJLG0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Oct 2023 07:06:26 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2051.outbound.protection.outlook.com [40.107.105.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AC894
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Oct 2023 04:06:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjHQJTGNNMIokug6uzDT32oXep8u0tu7cZuuehkJWvTzWqPZfXAGzPGo+AE2m9FIZFHNS9IBMDH8Ts0eELFMtQraDPIQjSdhlvLMWRTMmsuZiIRRBBa9xglDgpFS3u48OxrHLlnURFThe58SFIlo7obKXiTlYqggBdBk6M7waGQvy1ORh3pRSltuPfit+efGPIIUZrIvXmmMcOj4O13Ungw9w2y3DrjBRPYuSH7XN7/nCMCrwjY4eDN+q7B4zIqL5FexPDfmhdD497zZpGIJkMwYhbrDbrhYKn0hvcNlEQblx0D55VUXJb2zRbRvF92lNlVLezQMyZrTaxo5oH6x1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMezK0KJ6EsUalmiOakox593b7iUm/rL6fxFskqfraI=;
 b=LXQpUKUV/jr8WkBAazBO3XwVMG07fn1JI03D+JYLVIO8QwPu/IkNvAamplWJ9Km7B5+NrbZE7oeIXtd8cm+tVOxPnn6lldtH81hbYJ3FnKU/2pW50hGON2EB3V7bUquE0QQUSrLrNlDCRdTa2gKA/sNyJ8M7pOQJwL2J5lp4EbOTbOamL1MLH4Mh+jxNHVvjQr8cdiZeKSv1KGTGK1Z2tCOUVMeARpLKdNKwxlFRbXaJIiNbubHYywMaxqI/0LpS35lW1Y7yGe4E55ufhCMQv7Q1s9zb7xyspvKQCxeRyEWdJVvF4gqMruQ3yVsaX2MTm40vfrt59VoyBlBFS30p2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMezK0KJ6EsUalmiOakox593b7iUm/rL6fxFskqfraI=;
 b=c/51wnsy+LBesQZbHPqKXZ/9Nd57Vmi1yzc2wkA3mYALXH87qpkfmp754SQoogZCBGTzduM0EJND436ILE90n9C1BqhzENSoRrfClSdCDopHLvw3xanLL9lVhil4ucHZ5v4RfpX8/5mQELvDSv1PZkuziS3jMa3HSjFs1hy6Ils=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9654.eurprd04.prod.outlook.com (2603:10a6:20b:476::22)
 by PAXPR04MB8112.eurprd04.prod.outlook.com (2603:10a6:102:1cd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 11:06:17 +0000
Received: from AS1PR04MB9654.eurprd04.prod.outlook.com
 ([fe80::74d9:fef3:348a:ef3b]) by AS1PR04MB9654.eurprd04.prod.outlook.com
 ([fe80::74d9:fef3:348a:ef3b%7]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 11:06:17 +0000
From:   Mahesh Talewad <mahesh.talewad@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, devyani.godbole@nxp.com,
        nitin.jadhav@nxp.com, mahesh.talewad@nxp.com
Subject: [PATCH BlueZ v1 0/1] VOCS Unit Test case implementation
Date:   Tue, 10 Oct 2023 14:05:48 +0300
Message-Id: <20231010110549.14302-1-mahesh.talewad@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::15)
 To AS1PR04MB9654.eurprd04.prod.outlook.com (2603:10a6:20b:476::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9654:EE_|PAXPR04MB8112:EE_
X-MS-Office365-Filtering-Correlation-Id: 06c09019-214e-4709-bbb2-08dbc980ed0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kd/FD4m+rRCPyApzyx97O/j+5pyhI2QQTHLqr9fae6VeHxNm/R4HVK461bRaFm0dUdXfg7eTv2zZ5HmaXu0mk3c91eYDXMh/rBVdqcw8imGtHXCFoOXJcvP0zJxNnxwKfpG/lXLjzc39Cto+kUmEDgFbpNf+peETbngG8jgo1txBtpR4h3ijnBcmZ/alCPZz+/bJbSBIB8/ann6w9jYQC7qLOmef+lI7omGKq5l0HkIoNbcZ+tiL9h4+NiLsKUm0yDxZK2qAyLGyql60+rURwVqful+BSJaPw+oQyn1ghxbRZXrmhISiFscMywAC4WBfRP+RyT45YGdv4EXq50ysGg85ZB5zER7Nj4RMMVHlIxgUn85WYSxwKN1ATVeqHdlokOLrl/iEc5tMBaoOmu7Bv8DGe+7/ivKQBa3Vz4qnh9xL6cftb/MwWxyL3xHnx6H1VwIO0KMpHX8tL2brLUlXnQ3LKiWt3ApuHxA8W10fYgMo32t33kW511XtYMst2RAncJY41QR2uxAeXfkByAMUPIZYIkmbGxzlglqvLlonRGuWkZY5jsXDMXcXVRuqwQakrMg+61+fYWxsXhe69RNVVGGuPhCSLDZTSqTtXUv3AVQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9654.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(396003)(136003)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(52116002)(55236004)(1076003)(6512007)(36756003)(86362001)(38100700002)(38350700002)(26005)(44832011)(4744005)(2906002)(6486002)(6666004)(2616005)(6506007)(478600001)(4326008)(6916009)(8936002)(8676002)(41300700001)(5660300002)(316002)(66556008)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7137Sg/3kiGy1B7qwpkvvVQ5mF4k5fKIQrLZJitIRt6P0cqAQAU+xmoiniwA?=
 =?us-ascii?Q?IHyYmAcdhayK315NzUnoFVqdRelbckn4lvZRglXAImz8kxMTW174o7603+3i?=
 =?us-ascii?Q?Fe3fvkJtL7s55TTouA1ujJgmp2KuCvhhOIm3KkhZp+MeP18Zc4SS+Pne6vZ1?=
 =?us-ascii?Q?Czks2h0V+j1GygzOfrmQhxwyhyQK24ltI/AcJqGm0QV0P+8nckRnm6m/iVDX?=
 =?us-ascii?Q?Cqk4yU+VYVIA41Izj8kp/ze58Ddufq8DgBg5HJu3HmUhH8W/cpkl4OyIeBmH?=
 =?us-ascii?Q?Hp6pDvpbFknniLjiy/9RpS3/6w31KIGMzdoj2NCLrs1rGKWAyRq8EhliT9mj?=
 =?us-ascii?Q?NRVUBjCCNktenGOUCxcKCZU+tGcJ+yn1UgHsL7ne3nyEa0aadip+FVLQFYWD?=
 =?us-ascii?Q?hJqr7Wmb0nE1cD07PmKthpxxQgt0AStopLuGNbtZ/C42KbxAcE0enNCa/qlX?=
 =?us-ascii?Q?W0KoBMyYhchLCMMBMhIvVcX+FAGi+8PTD3eYO2N8texZ1mPFuZpE4Ee5/4dJ?=
 =?us-ascii?Q?Ki5EgYKlrH9IWexvtVPn0+uTtgHAY7VxqT8Y1mo2QwIV1wrlmhC6FAS2lehd?=
 =?us-ascii?Q?/dtZgBwDNjQckJT9oc5VXp2ZCuySOSutg7qyGh4hieKWBrlG/Ypm4PnocaW6?=
 =?us-ascii?Q?UghPf3ZklJ/vOSoXB0vTpwb4oeLqa8JCmtWRdGIz7uNHm/5HTinlUfq0vJWC?=
 =?us-ascii?Q?UpTfqqQ0DLt3+PXUjgpTRiPJLpeGWBH/HongGsNQDjl0HAgkQBrO/XYrS3Rf?=
 =?us-ascii?Q?QIDhosD9/Yrt8uA7WZYeY8OPQVJZD3bu45VjVt8bebGUZgug6SfpcSMAJzpK?=
 =?us-ascii?Q?ZTjPtmGSsPm9nyA70gfAXapDoQ1NzRB8i5bNXHJ5O8IuqLvCj0Quffher5Yt?=
 =?us-ascii?Q?HtKdFRKAq35W2RJwc82WMwzAjv+eJ3D9ZouvLub/GL90oJ9oAlMG/VtekZwd?=
 =?us-ascii?Q?mVh53AauW5nF5zGryW73toIo8o7ETswihwkmjoY9l5cvjH2TEnX7iCk8OUj9?=
 =?us-ascii?Q?23VB7VvdB87E77lMsRA2bqXlG9Eo4fI+/tBaA7ElVQ0QMc2rMPTIojaazTZd?=
 =?us-ascii?Q?Yk0uj0oJXW9Sd1TvYn+vG9NdTJBC+GhmF9vCtbmC8OSB8VZog8WSFf2KvCMg?=
 =?us-ascii?Q?FsTNLX0q2G42IOcinzlWCzB5hcsFHY9vk/xEFNjzN14KRZ+2P+Iyt0PzCDTx?=
 =?us-ascii?Q?deG0esFlyBTgjrD22DbKHH8nMrBloTeM8Sjv1pqPKXQQGn+idvHMKKYHDoCf?=
 =?us-ascii?Q?S1PjPqxUR6Rgdrew/V9t6GCyr4SpEClXhKw6L4kP0mNUtsTu4cm+KR6f7x0O?=
 =?us-ascii?Q?UdPR4MCa2IM9w9qdvz94CwkxuzALwkpFIwRYyA3uwDkvuyDIaVlJylNX04Zv?=
 =?us-ascii?Q?1PALCghZkDm96TTTLNXreDzSLWh9wEDuQ1ssnAIBg9ewZFUOBYxBRZh+UaSP?=
 =?us-ascii?Q?ercgmjFds2gsIzoWN1TDV1L8G4Lx4iQkIob910//vxIvt2xtnO2ysJVRjtKF?=
 =?us-ascii?Q?qa4lzHUQMkyH06LmByKjOEZ7ezYBFXteY6ebNdYBWzAASEgqakYxd2mUui0V?=
 =?us-ascii?Q?JmJwNJV9oDYj5HKggiAJXTkYi3FEgCnF+eZIHBpZUMm/8gQs6b4SBBaGsDbO?=
 =?us-ascii?Q?Yg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c09019-214e-4709-bbb2-08dbc980ed0d
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9654.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 11:06:17.6525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kIm+S+MP9shmhVXpvnuPow+ocPCN5y2DYIKvo/0U4Zeb8ZlT7/lJ6nfwx6BZdXscvQkSSwEnLgC50NgFd2QWaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8112
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Maintainers,

This Patch contains VOCS Unit Test case implementation:
-Implementated all(10) mandatory VOCS unit testcases.
-Tested above all mandatory testcases and working fine.
-Specification referred for implementation:
	VOCS.TS.p1.pdf

Thank you in advance for your review.

Thanks and regards,
Mahesh Vithal Talewad

Mahesh Talewad (1):
  unit/test-vcp.c: VOCS unit test case implementation

 Makefile.am     |    6 +
 unit/test-vcp.c | 1359 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 1365 insertions(+)
 create mode 100644 unit/test-vcp.c

-- 
2.34.1

