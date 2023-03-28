Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F6EC76196
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Mar 2023 07:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjC1H0v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Mar 2023 03:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjC1H0v (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Mar 2023 03:26:51 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C051C2D48
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Mar 2023 00:26:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRcOgNebSJr7lKRaU1dkrKIq2MyHKPfp91t/3JWWlwXU6MYEizbaLsbIJDKzqhfmx81buHwtJa/SeqhMGT74sjo8MjE889vPlAchxFiTcGbAVH40D+PsO9QWzzMVcGq7/Ol68XwETSEjP1y4Vhpvm3+J/RvyNV5nlKIcuKWjzIlQorQPcliFQUDAdzmVyErTMb1toJFsRmwIIsFtgqe53Is80qQeSElwe8iNAGvnS/6Bpx6zNwfVKPF9IPYuzAr6XTjuIRtvSTSVU8YmdBnepAYaLjErQ0U5VwTK1kuwqyI0FKB0ZVAHGK73SVL1fvvMtH5oq9kCDV7Q30pR+g9G4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bh0/37oG5S3dNmAIjMEACijBclwc8ApBhP4ZivwcxBs=;
 b=JQnjEXzBrXj0g2YreSD4bLlE75crUsBmd+HnYwS4oPqOTXxYQS1ic56ktTMbv6sixnWEF1qR4IcbWIwCu0DorFoQkSSOStmQI9CcnWa1GyKI2HjG7TS6xOQTr8F0QchWufR0PjAeqTLnuDatcstV0s3Ttn0EL3bN86/5WNcdy1KXty4cUyDjU03V7xs+6EoA9ueiPBI6d4XhhgVypQD4Ob4rNV/1g2r9yH0oOMWlVobMWhSnZJRtObLoOvPHJpUnvbwB9FHltU0zr/gkT35722KzJSHzBFZKRebIgsUzXIWj4V2g4dhQ4XRm3c5h30kcN34TyrUlwz4xJVe2lOtbcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bh0/37oG5S3dNmAIjMEACijBclwc8ApBhP4ZivwcxBs=;
 b=Gl2zgzy2jGxZZ/OnI8AnagL0jGxiSeJRv2HP1Zauhv5x/X87mVA30yLQR58yftd3U1zjw+Ax3h8bbDP5Z4IZSQzghuWB6kZJtwGiQ8N5pE+RoHJMqQyL0Ch4GHn3fXLTEDkYfIwJ/QD6IgNiWa5jwfAfPSBaa+a7lPOEyaqZW8M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM8PR04MB7794.eurprd04.prod.outlook.com (2603:10a6:20b:247::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Tue, 28 Mar
 2023 07:26:35 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%8]) with mapi id 15.20.6222.033; Tue, 28 Mar 2023
 07:26:35 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 0/1] Split bt_iso_qos into dedicated structures
Date:   Tue, 28 Mar 2023 10:26:21 +0300
Message-Id: <20230328072622.16896-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0122.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::27) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM8PR04MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: b441428c-8284-4154-5ccd-08db2f5dc304
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JzIBbxUsVdrunjgbHMd92+xHlivDSH4UBzSYQC8cqD9dmqWGPpmBDKYrNkcUXe8/Es8SiVy52R6S3DMYBNjJyElCAe7OI6M/43JZsL9X/bEIjP5XQb4DPzXzC7pXk0DqP+yTEy/OrYtU8CFX4vN/7j34/9Y5usYAqsV2vk5S71r2jRRew5om9nm5dMJ64IcKvYto/msNM3j0uyC0OJAoeOiZN0k40hG5EncvAhpSjg+/PacgrdmPWWr/UZKXa/hmIUt39n7HTx9i+9YmhlobG3ZC3DAaNZ7XgZQVqTOlOOxOqY0Mam9qV+pepICk1Iu0MnicwPw1PPhfuZExTIkTBX1GhNawLaWr/V8TGgZrd3keR2LUipMuZQDBrTR6cukLtEwfCzUMBcuwPNbWVS2d0cAO6O4qOUtEaDfUwapqZuPQuaaHcUIbQdjHFnKwPP4juACULLJ8reUZvVLIb2Eh1ToEVX9OAA7Ov+K08stkIw0k/KPWekce/fa/SeSu1LMstqJJI/6AeWAYoEiCO+lGS+RWsfzH7T9pRN3maNk3xGlpRwnlNppy6hjYiL3ZaTbmgReX8kTyCAzso5/4M6PeYwRe0M4cvi6SuWRXCswmOs43mdxLNHSjSom9JsKNNnFP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199021)(1076003)(83380400001)(186003)(86362001)(26005)(6506007)(55236004)(6512007)(36756003)(316002)(41300700001)(66556008)(4326008)(6916009)(66476007)(66946007)(8676002)(6486002)(8936002)(478600001)(52116002)(2616005)(5660300002)(38350700002)(44832011)(4744005)(38100700002)(6666004)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VgmF90U3TyxL4jCpGJmUmpT22+VDoQlvyZTaKMMqEikw1toWfXStarV7mD4o?=
 =?us-ascii?Q?nIem+8jmOAz4N+EElnR/5IoqQtnQZAsibyuuM/hvNgqDDewtY6hBSEQuOios?=
 =?us-ascii?Q?ypx8hHJVLbxNeYgU6ax6tcoNIqrlo6LYs6i7wFhFxwonPhYiLFQ+/IEqLzhX?=
 =?us-ascii?Q?ZZGM/daG48Yze/HJzlv0x9tFgKNajgfK5BPix9PhyOv+xeD1AzCsv1KQOY6D?=
 =?us-ascii?Q?s3+f9DXq0GskR8HhzRok0xysFyeO3hCb0+oBKQ4EOgBtWJ+hhiW8gXBSCEt0?=
 =?us-ascii?Q?O+9QlezYr3FgkVmI2EF5igBPfUdqYD3hMfpbGoCafkjhhIy7VUD1YHOq4UrN?=
 =?us-ascii?Q?8/tmZOiuJhFoPUM0RoJCVDhSBJHf2INCKaIgtH0VFWIZgC+HdwiQYXJj57aI?=
 =?us-ascii?Q?S7JY1r7RBH2sTARD16NTFh69NvBnwskvfZ3f+bsoQDHMxJl4rP+Vdkk63qm0?=
 =?us-ascii?Q?vw+qYx+H2BjSkd3/AWCStJ5rzacITiaeS784Aac19IaBoXh/prW1UDPbRkez?=
 =?us-ascii?Q?xAsnpr/wBx5As8ndo3tc/+Grc4auNQDycmGjjAxf3KmGgRFHTjGX/w364QNg?=
 =?us-ascii?Q?AjQfgdMgg9TmBDkwDh9AYDnqG0EGTfDAQp5JQgNoo8gIaHpGH0hcAy1YW6ik?=
 =?us-ascii?Q?i3QDKLlw9BwC/L/iePz6109E9BYreHkoHL+2zLjSGb74b8jpPDnPaDHHCllS?=
 =?us-ascii?Q?jwux4C+CtpWg5s97MQo7bviExkegPc+SA49QY3bV254aK16FBxnpOoUZAFCV?=
 =?us-ascii?Q?sKYqaiBPNqFEznhay0FKJT+L8u9re0x4kenj7544x37inxVUVmT1iEl9govb?=
 =?us-ascii?Q?F9PbrKfbD+enoRmd0OcGEdeTwGJdrsiuKz/hkDI8nPUq4xdPAMtG3L8MFHJc?=
 =?us-ascii?Q?Qx3du6+uqVmLSGAuFBWAYTu8F1wHiVymKw3Hl/Hs/DWY71LqaZXjLtegZWMW?=
 =?us-ascii?Q?OrD0q7P6VPk+2uSnwLIRA8ZaC421qgW0evHHsxeZMrHkpAEtI+W83PDAET/9?=
 =?us-ascii?Q?ilSsnEQbdqrZW5cacxaO3fha8wlRMqSLQ36628PzXZNIwYGuxsLRRdiSqsYS?=
 =?us-ascii?Q?IX2E9gpnvWzr5SWzMnv8FuVrs9/913dz0ez7qg0+angT+Yo/uR8l3s7Er9iR?=
 =?us-ascii?Q?2/eXqZIojQs0X1mDjEbvuVLbjWcFfGRIISbmLQtlwLC01pRj3205nWWRJGYb?=
 =?us-ascii?Q?6vYRwpwvt4Uku5Dbu9YuQVjuqT+kc9R8SEc5T1M19AZI3d2xGf3bpKlUYk6T?=
 =?us-ascii?Q?v70/nXiwxKrxrzlHGlAPL/XWkqpXVz9iPwPtbBR5cw3BoNR3X2flJ/KDNaZc?=
 =?us-ascii?Q?YEHeUaauFJ5eI6ZxuMZ0KJMDks9+fDs3eXMnSI7RCBTQwbF6E2GufQq6ARxE?=
 =?us-ascii?Q?16mOBdv2NlNtstmTZVlrHnld5nekvEwfCglR4ih8D/GhKkBL8GlAUXLQJ5z+?=
 =?us-ascii?Q?szlGELtMeuiFw49XKGKP7ZmJXSN/7rSj6vIMsbPg9uwTfoPz+dA60vYnBI5j?=
 =?us-ascii?Q?2AW0OlXZa+mAW5llJR10EHGYOnerApRLhoZpiwklgIqQcehfnSAA7zMa16Or?=
 =?us-ascii?Q?VA8fIDmMr+/va9b+ctytSNdh2JLv81ji7yr+EoPjB6CarqQTzF6V7Hez986u?=
 =?us-ascii?Q?cg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b441428c-8284-4154-5ccd-08db2f5dc304
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 07:26:35.4921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CuMqJHFpGdvhw05fhxkGbRRdi7SwplSq6eLmGCMUNE0YkLRGpuBtdFThVLVGwKeoCou4GvjTuHOnzmyNqQX4hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7794
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds support for additional ISO broadcast QoS parameters,
that the user can set before performing broadcast procedures
using an ISO socket.

This patch splits the "bt_iso_qos" structure into dedicated
unicast and broadcast structures, so that ISO sockets
can be configured with dedicated QoS options depending
on the type of ISO procedures to run.

This patch depends on the bluetooth-next patch
[v2,1/1] Bluetooth: Split bt_iso_qos into dedicated structures.

Iulia Tanasescu (1):
  Split bt_iso_qos into dedicated structures

 btio/btio.c          |   7 +-
 client/player.c      |   7 +-
 emulator/bthost.c    |   3 +-
 emulator/bthost.h    |   3 +-
 lib/bluetooth.h      |  59 +++++++++++----
 profiles/audio/bap.c |  19 ++---
 tools/btiotest.c     |  17 +++--
 tools/iso-tester.c   | 144 +++++++++++++++++++++++++++++++----
 tools/isotest.c      | 177 +++++++++++++++++++++++++++++++------------
 9 files changed, 336 insertions(+), 100 deletions(-)


base-commit: 338ba4352b6cadafe61808c21302c0abe2168e02
-- 
2.34.1

