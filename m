Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7B7C7EE23
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 May 2023 14:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237067AbjEWOf6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 May 2023 10:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236640AbjEWOf4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 May 2023 10:35:56 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2070.outbound.protection.outlook.com [40.107.247.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F71196
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 May 2023 07:35:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bYnAg8604qKRhLvUORcCLS0/f5MnARRlX8EdjfLO7vCKUg5LuA3jOXKPrL8JLFCL+kfl2Bjb6FEAcurxdEwTwX0faD1hHdOuyyil7w+1P+kx9D1Mnp4D7YqEzihMf4eX02K9D4xIpcpZysf6/sGuXcpT0HZ6JszVCZhaOShHhcsCd64/YnNnRpu3i4i0sAIx6NHbqiN7i5rWNO/Hywj1+TTCuGjpr/JKW+Y4WqiyFCwXH4YiJGr+sl24nnPb6hJFHTR58YpW3I5WLBYXOk3H8UF26f831f0oO5Itq4v18rpKsTSphKVotcM6Sef0XFZ+7TKG1CRyc+kNPLZB6IzvaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xP6ZWEqTHAdIk0knDaaI6PxfC8XFpqT+0TItgIsPUOA=;
 b=HAe3Xs0XVm/GTkCkT9BOxNUzqKO8KSeZ+sCqEmaheCOuY0rwoj5YCHQK7QHnc8BHvaHWVjhA2fsosNSDcFwqVYfWkFp5a3mwzOJ//aygdhkTfAP+yt6WkaJ1I340jMUqVnCFSQlahGJkB9fyHSJOSbiqIvHceDOp+7vtwcw3i+/dA/ofAN/iv8+XhyfsFBZogq9FCBECZjHTJie5t4liWgGsTY4EAyVmFv9+xeP6pFFkNWaXgR6vjxe+QszE6UuoB/xuZcNGndgD+2P7K8pByzENvgFttliN00NL2NtGuQxc92LUJWuPPG+DYqqhe7ra7+YbXfAGoLALf1wyxcvRtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xP6ZWEqTHAdIk0knDaaI6PxfC8XFpqT+0TItgIsPUOA=;
 b=a7l8Lx3HxO+kXf9tAqZ9iMqfO0Vtc+w82nPPn7C/3FWzEsPUkd4nIye4y7lwAycgwtbDcUzER9rD/5kvZfbCuG8Zg3dtrY+zRhDhzShoF0eX/7TwNEV1ew+3PmGidvgEzV67bLrGADKRoRSR5F0n/+kteMZ5B4SVCkk8KOMn4eE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DUZPR04MB9784.eurprd04.prod.outlook.com (2603:10a6:10:4e0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 14:35:26 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%4]) with mapi id 15.20.6411.029; Tue, 23 May 2023
 14:35:26 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Subject: [PATCH BlueZ 1/6] doc: Update Docs for BAP broadcast source
Date:   Tue, 23 May 2023 17:34:59 +0300
Message-Id: <20230523143504.3319-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523143504.3319-1-iulia.tanasescu@nxp.com>
References: <20230523143504.3319-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0019.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::6) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DUZPR04MB9784:EE_
X-MS-Office365-Filtering-Correlation-Id: 02d61c67-3f9a-4d85-f0d2-08db5b9af2dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +NL26QwtYTFAZKBpGx01l7Ge+ijWR0yCizYwGHxuXV8avx67W9TejT5LCJjGhxDVcN3iEfzqpkZsbAEcdHw1P++POjN8gFrnG9t4esAXY4jxDoNR1GYE2yMg9rvwotjZoZsLSs5lZUzv3LnrFKlm43Pc4tFHNukkI5NaPxl2got7n1HF/k8FvJpwoR/KrdLmLpYjfq3I3dO6Z3+glEQfcfkRJWImqjM612NQqB8d4+ZfZ277riV5zSBCR6flzrKlKDO+DXnIVxgslZcM5AhA4THO1t/tfuwR0Epi2yJM53N41iffjkm/F/6v2BFmLdmgWTYV49qMRfSzKpIwnLwLs8zwnX+lxitvoIV+8zj31f3AQ5MAu9kh2tcYSNjD/gH1Z9hHietmnm0rgS2hDi6gR+3YNzxbZ4MtWXEfsCCNwzRcJ4QdKCI/3kPKdajxO7VJ483ugIUjQGGgqwRj/+y6kP/2CujClsx8tMDX9NKkwZokoAZ2EhxNm9Sj+GZLoZfMuEgxnWComx9a+Bood3Z1TOeLnJWk+hPbg3vzjzZzcwf+aXCyA69m637AMbTVTouwQvQjbsYarXCuVH2IALEpQkl5HzVWk1GQHHmF9OtnoLrjbvVUdVvEkVEcOFTF6Lqz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199021)(83380400001)(86362001)(478600001)(38100700002)(38350700002)(2616005)(66556008)(66476007)(66946007)(2906002)(186003)(4326008)(6916009)(26005)(316002)(1076003)(6666004)(6506007)(6512007)(6486002)(52116002)(44832011)(41300700001)(5660300002)(36756003)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HmK26iGv6MxGpoAtkUaFXLBHmxf1kudFzoJPZt4FxP6r5nwWxDdvCJCmlASY?=
 =?us-ascii?Q?Sy0pdOoi7qKsCXb79UDkQvC6YB4MTOAWMGggl/Pb+6viuwHLP+QddkDsNOz9?=
 =?us-ascii?Q?c0n3yUWUVD3KGrPo9AvbKAetMGK/xbz9w3fKoJ3hjQlv42PzQEoyB7L5RbNz?=
 =?us-ascii?Q?nkln3ijOI7zAGGaGGMGx0M+d3Th4hYG+3xekHfi5xKO5Cm7Da4vanFc+nBT6?=
 =?us-ascii?Q?qvUHhy0mPunu09nHRxEoH0ntYlrNuXp8NgGPZaLq0OtNip3iN1/YTbvY1uYY?=
 =?us-ascii?Q?9e/akmUtvQgMAepM4k+TEl+p8FbH3BoP4//HCN+0mAfRIXaBeefDF85s/WCu?=
 =?us-ascii?Q?uS9ajNToP831+zuzczgwAyAZbgJzyiVyhV+z5ro6K+7vUGiJGwW3qArF2AXT?=
 =?us-ascii?Q?OWwAf7/xvGfJtSxq0FRlHu950IOraJkcepBoQ4/QQ9TiZMxwkOgmCe3p69gw?=
 =?us-ascii?Q?Sfbunwv0rggtIoY/3MPDzmn+5Qv5hI7GGyQln6tJP/4B/pK/yLn5xPibbDU1?=
 =?us-ascii?Q?an/+sC2gKYNegQe+CBr42hIPHriH7/ZBFGlkOAWTBV28pfV8OF1pzCfzEAuq?=
 =?us-ascii?Q?yOdEVNoG0uObHHR2xbRuiIV9jBvuCv7oRJOTRRUrN5L9Wqpc3gb30Ck2SROy?=
 =?us-ascii?Q?KhWIoc/g3u7E15nCWJBcyFcymaXPXKHRJyJKZzJKFQchWPse7xqUG136ZyUw?=
 =?us-ascii?Q?i07NfD7wbZ4JF5WS/vUxuvld7OOxJYGqeqFLMrSpZ9Cp8IYHPmliQVLk2CMt?=
 =?us-ascii?Q?yCojbeQNsTtzdPzlkGjItnlNuJ4HBAZGEjzrUeOrmePVDJbNJQoNN+LQHGkD?=
 =?us-ascii?Q?nN/nN7yKaC0XqRPj/4tWELyZ/N2ZhQcRPaKWpCKVIXgOugHhG0rzxs0sDN44?=
 =?us-ascii?Q?hV+WBfYhn2ZL6qXKui6qMHRi95tOtJEG1tEVzJ4wurKxzdpnIDJS0LWGVB56?=
 =?us-ascii?Q?IGl/XZFNGJdFx7Pc3jtUbWcun09gAcUVGWYGM5p+3lNk+Wfjj7OEqDPyoJPK?=
 =?us-ascii?Q?OEVGx9DIT7wcCrYIhwOExLwIQyAQUB4rsl/kdIspjEB7W7XRPjpB9ZKRShCf?=
 =?us-ascii?Q?ZgtKEf09t6yuLA5XuHe8hvdHlfkPekPJRnNEqG3GWYzOkxIpBwtn61aJ48oj?=
 =?us-ascii?Q?pXS3w1Byo3ObV0txyFHMhTVMgughaoz+yKvWjUzGO4cVIaXO2s9eak/KflME?=
 =?us-ascii?Q?lkfnvO/IgmfW97by3ouBWRAwdyxWJkRINS16vTB0KYweMhre6tBrfzVy4sSF?=
 =?us-ascii?Q?A6IiC5Qe22a3DKeSh1czGl31OlzGUej6jIUbGn7IgRu6OdRcgDo+NOSBwx0B?=
 =?us-ascii?Q?xxEcENRVdLKZUQhqTQP1KTbQxFpFKEXUuORlSn5MU1skpSO/un31BHxfjMWc?=
 =?us-ascii?Q?RjJDHvpBWayeFCLGV8B5aZsBYonEc6/zKl+qGxXmnXag6nC9B7E+cpZLd7By?=
 =?us-ascii?Q?7D/1kKDwt1tVfO41J4Vas4zRR4AMFB9yAiVKc7FKU7pnLCGR6ZXsBTyal+TM?=
 =?us-ascii?Q?FYq79CJls1SdntCe8dDQgOwi9TqCaGIwr6UlVu+Wzj1fYFyh4CE+3FhOl1ig?=
 =?us-ascii?Q?8qhohQJr4ram06qmhizvdajvX0/bem7El0XmRrFdhXgsv4Zzm+cLWhr2N7p9?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d61c67-3f9a-4d85-f0d2-08db5b9af2dd
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 14:35:26.2118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KpZQ9eRB1IFT+E6t67xyIsM1eA4ZodP+mM2WcVFW0vbcrKk99TpYIg9mKX16TQAUA/ZwpjgaCbjzOdQaMjfFxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9784
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>

This adds broadcast properties to the SetConfiguration method and
bits for Broadcast support to the Supported_Settings bitmask.

---
 doc/media-api.txt | 11 +++++++++++
 doc/mgmt-api.txt  |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index 3746ccd55..3a0ec38e2 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -599,6 +599,17 @@ Methods		void SetConfiguration(object transport, dict properties)
 				uint16 Latency [ISO only]
 				uint32 Delay [ISO only]
 				uint8 TargetLatency [ISO Latency]
+				byte BIG [ISO broadcast only]
+				byte BIS [ISO broadcast only]
+				byte SyncInterval [ISO broadcast only]
+				byte Encryption [ISO broadcast only]
+				byte Options [ISO broadcast only]
+				uint16 Skip [ISO broadcast only]
+				uint16 SyncTimeout [ISO broadcast only]
+				byte SyncCteType [ISO broadcast only]
+				byte MSE [ISO broadcast only]
+				uint16 Timeout [ISO broadcast only]
+				array{byte} BroadcastCode [ISO broadcast only]
 
 		array{byte} SelectConfiguration(array{byte} capabilities)
 
diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 58395dc90..c7191a028 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -334,6 +334,8 @@ Read Controller Information Command
 		17	Wideband Speech
 		18	Connected Isochronous Stream - Central
 		19	Connected Isochronous Stream - Peripheral
+		20	Isochronous Broadcaster
+		21	Synchronized Receiver
 
 	This command generates a Command Complete event on success or
 	a Command Status event on failure.
-- 
2.34.1

