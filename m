Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C22CC04E69
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Aug 2023 16:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344858AbjHPQq2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Aug 2023 12:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236127AbjHPQp4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Aug 2023 12:45:56 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2048.outbound.protection.outlook.com [40.107.241.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97912271E
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 09:45:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fquGmT1MR2D+5zFNuFNDYq2tMphf++SlgSx8X6DPlnzE8UrxO7vuFcRkKbo2y42wtVRbel9bnadevcXDL/i9kRv587IpwmSTVr6qawZznrD/VORxvgkYyW7clbkPAVW+kj8WEgZSNe/VF0e0o0SsLbDIE++8DhA6a43Ctq0w4xA8+00wwdSKCZEGRFDlO0cLcZQu9mWR1VloDg77hnM8WQi0z47M70ZCYc2ecNQR0qSlXZoy40ihQPCJf/A0CjBzESyF21i0yzdnV4UVxaqnuMltieIfLme11/RxWtp3J6fFgr6GiAvbEfbN8E35xwY7M1xfICPVreReQeOgOqSa5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nh6ovjMpR1HnQbAEwECFhEh6gHjV8wTxyyB9EeHc/uo=;
 b=XSlX7lEgfzGsHe0D8iAYUNmNex22VJj7yFA7aCDpHQmsy8+ODeT436zEmMUBehQppJJZ9zeEd5BCXLNHxH1YWA9xe506sacgk2KRphe31Gbx4agdeExXItsnm7Io2njkYnVPeUCN/ez0pPQ5PnIqMaVj2tTEjy0qrkdyS5pXhyp+9WLJuD2q8J3Dbxoido9i7k6hlH53gVv4csEHc7CprJoM/x0zFrqAxfCe71NPc8rfNJezEI8aRqtjhL8XzCEzQPBpOpKa7EwfbC2bsoHbwDpkkyZNXhxXxsPx1cD4bjUF59PUorVgADzI+JMThwjb/hiBy0+9Ku/cyW88g10g5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nh6ovjMpR1HnQbAEwECFhEh6gHjV8wTxyyB9EeHc/uo=;
 b=ZYk0QvRdceTjp1Jihj2sIb93IXyVtuptlZ4rOfeiqpwThOjIl1aMJjpMdhRWo49D0ytQNYOSpfopbISGPBMGzN2XpRnOZXLTMdBoNNBU3AXOcP3ShvdCZxSn0mslwSOLqnJQ9aRlJfN/oVar/TzM/+5c4PYp+ee6d4I+I+l01wI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AM7PR04MB6997.eurprd04.prod.outlook.com (2603:10a6:20b:10d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 16:45:00 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 16:45:00 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v6 0/7] Add support for BAP broadcast sink
Date:   Wed, 16 Aug 2023 19:44:28 +0300
Message-Id: <20230816164435.5149-1-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0047.eurprd03.prod.outlook.com
 (2603:10a6:803:118::36) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|AM7PR04MB6997:EE_
X-MS-Office365-Filtering-Correlation-Id: f346d989-d0fe-4539-74c0-08db9e782179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tEnT4zXxJJrNXWjjcr9JORZJ+NgChL3FK4uRM4V+vOSIiWl3IaKWA1JA9WTF/WWM5eaaLH/zS96LjVwK3Psg423ZFTtQGB1b5gJ6cNJOpTomWHajWvsP4LF8jrkiiuMa+ewwOY/Tzrcnn1hJhkzF3RHEHkduJdmctHB40Twabw2QSGU8vlyEbsOvCT6XZmXCvyZ/Z319Vb2nuy46wt9/Xr1siPlEz9YY4ncHrHM9buIjnEayLPf9Di4D9pjc8HtZftJofvZhlbPga4XPVuzyTcxXL1yvxoOJ6iJvKxUiDunbV/OLar4ii81GksBrIQq6raRCJYf8LCS3ApYwHNv9G344LuGZD1+UuVmOVVmfk63DVhaMB5U5PqsJ9GLZOWVp2EIG9NqG/IlSSDtzLxYTk2z2DljvE/ATnPXnTwgGFxlhJECUfwO/LCoWuAXcHZZMnxVY7V91u+0Y66V4sScFno3Z62VpRHDabpveSryLNzEYtE01g+uuNDytPPNbZSJ5DMFCrYAwCQzexlw0b6i2dsFpNXTLdXYi/iW4L9Bp4xiz4TQAM+yN+nM2JBZnAvv5aFicSkORs+O/RJnfwIx1njmEhkHuil9YPM9Lo9Nzv5R2wtwE8gt4hywffuF8Vr3B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(6916009)(66946007)(66476007)(66556008)(41300700001)(5660300002)(38350700002)(38100700002)(8676002)(4326008)(8936002)(2906002)(83380400001)(26005)(478600001)(86362001)(6512007)(52116002)(6506007)(36756003)(6666004)(1076003)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?woEw4Bj6l5sMLpgB39nIX3w+D5mVjJnHarxdaZkjYu9haLWP+yRcmkiu6r6R?=
 =?us-ascii?Q?VRXLA5icEAXuT1bTgNcI6+bQL4o0YasIcjsTSxfrN2nlH5Cn345+STgK1yFX?=
 =?us-ascii?Q?6FVE5iqI4b9/eRAnPVrOGWdfUUrRXX5CnN3Z165akU699W7yufv0XJNi06fZ?=
 =?us-ascii?Q?gzQF9SpWWLbvAb2jlkySL0C92+//ds/vdWlXk83uq83dWiWwk93kwUs8PApY?=
 =?us-ascii?Q?93ThvgqYW37iRgh82yeyMgFfzY5j9wzmDnRHepM2Bu0R8x5K9n4ce7MX/rPa?=
 =?us-ascii?Q?hvOhlXm4DND/dqX7pR4KdBN8R3jNkoFqxeTlsm/kANWpmod7y3w01LzmQWTB?=
 =?us-ascii?Q?d0JwWStMJ85lxufegcHf2mt9FRmofve8eG9vEsU1/VRofkrREanHgRIWlTtn?=
 =?us-ascii?Q?RYvvW5o8yKeZzKvzckfZRqTRlBmCBnirF434ilhYLSFbJeS0CxkS8PWhbQT2?=
 =?us-ascii?Q?PjgOBkUhkNo2Z31N6WLqCz/Yy4R8DqXYdsLZ7Hu0IlQ6NSZSLoyqC7csLseH?=
 =?us-ascii?Q?EWPAqvS0QQyBd4NJz2XUOWZG55ux295HrAxG9JsPtXe2SobIePjXnzQ4OmeP?=
 =?us-ascii?Q?dhXwpl/qIfJA8ws+gTFu2u0BUOIw1UsVGmocojqCm6NIWfkTMC3jPG3RVVtL?=
 =?us-ascii?Q?MYPVRdcf+Ci4u+N6hGEovpDJTCKdzPR+5lWvEv+1S7uZCp8A0AfLD57bmjXK?=
 =?us-ascii?Q?aucz+XGHoqvU6JPu8Pq/yIcKyalWSSj2GGjEhJX4qEGNiFO7fKqyCa8UBBLE?=
 =?us-ascii?Q?nwz2KtQsLbpKG39zz+MhnqfakhViBqp3QufKmYWmlc11nEOW7iZodKXeSFju?=
 =?us-ascii?Q?LS/JLV+YTD+MWyW0LpE8rCtiEMMSEXTBBw60O7wu0W3lJvVFE3r4+BWA6tFy?=
 =?us-ascii?Q?Om6e1cBW0o8U7eofO7dHhEm49Gj2ONbNs4B5MrqO2aDy3TqFc0Tp4617rWRD?=
 =?us-ascii?Q?vOXoxI1RVVLupUelmjZLYDeWLY+AsLYIwv9sGF4dtrXzFDRDuT+MkWonMn0K?=
 =?us-ascii?Q?HJwBsc2u5LBfhEYDGoA8oVXzPAV70fHoJLcaTQwuviJlR5LlR4lE2Ej/cH6n?=
 =?us-ascii?Q?ABYOV2ArjEVafNwhFXJvHznLXQjUoXtCNsCKX4ATFTSftZsUikoOqrewMcDf?=
 =?us-ascii?Q?YHCFzv5qVKt5JRL6v/0kRjcaHHyhIlhcLhHOEO76CE4CVR9Y74FndAHaQ5nl?=
 =?us-ascii?Q?9ro6yd0kFgz5KFp85ijIJZTSry1bJ01RDzwtUqRke+v3VFjluRoBmGTsjwIM?=
 =?us-ascii?Q?CBDYF6ayFq3G5SH9JEpwy83I/5KeKrnD63msbORf4of2D37u81prhVWCZSKp?=
 =?us-ascii?Q?DyFXk0Irq1vL8V7v4cOa+0rnXw/BksQ2M8xSil2vNI20ERHh1hWxydXzFSyt?=
 =?us-ascii?Q?Hj/mXc2fWc7NFkNKFux/6ETvzwoS5mwDoFVy7EXq5q6cwfmsh/uwbydhY9Bc?=
 =?us-ascii?Q?7mjAXeV1VbCy3OAqhndoFcgVi/JE010HvBwVILwkh/Ax+mFTzeknM44J3xx2?=
 =?us-ascii?Q?2PHKRlDoSlnL1nYSw2U+m0lsYwAQbsPo8DjLAC6IVuSIC8cc6pmoE+6F2bKb?=
 =?us-ascii?Q?obJEW1yq9m/l2irFWba+T5y4ptkPSIIBfvTKhpzT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f346d989-d0fe-4539-74c0-08db9e782179
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 16:44:59.9594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQi0S7MzkCL6i8Z7Um0NWziAXlraIufXY1X5ZLmQdxw46Si61wkeZlSB3IgSi1+YEWbVuTPDrANao1w8qj8aUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6997
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This series of patches adds support for BAP broadcast sink.
It consists in registering a broadcastsink endpoint using the
Basic Audio Announcement Service UUID,
discovering of broadcast advertisers that announce the
Broadcast Audio Announcement Service, synchronizes to the Periodic
advertisements of the source and synchronizes to the BIG advertised
in the PA train.
To retrieve the BASE info advertised in the PA train, the patch
Bluetooth: ISO: Add support for periodic adv reports processing
was used.

This feature was tested using bluetoothctl with the following commands:

[bluetooth]# endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
[bluetooth]# scan on
[NEW] Endpoint /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_bcast0
[bluetooth]# endpoint.config
/org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_bcast0
/local/endpoint/ep0 16_2_1

Claudia Draghicescu (7):
  shared/bap: Add support for BAP broadcast sink
  bap: Add support for BAP broadcast sink
  media: Add broadcast sink media endpoint
  transport: Update transport properties for a broadcast stream
  client/player: Remove Broadcast parameter
  adapter: Fix UUID name advertised for bcast source
  device: Set as non-temporary a device that has matching profiles

 client/player.c            |   3 -
 profiles/audio/bap.c       | 313 ++++++++++++++++++++++++++++++++++---
 profiles/audio/media.c     |  42 ++++-
 profiles/audio/media.h     |   3 +-
 profiles/audio/transport.c | 251 ++++++++++++++++++++++++++++-
 src/adapter.c              |   2 +-
 src/device.c               |   2 +
 src/shared/bap.c           | 261 ++++++++++++++++++++++++++++---
 src/shared/bap.h           |  13 +-
 9 files changed, 824 insertions(+), 66 deletions(-)


base-commit: f4aea37ee6cf6b6cb3f91e4d4c9f09611acfd610
-- 
2.34.1

