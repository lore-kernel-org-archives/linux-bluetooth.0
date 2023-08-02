Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E50C001E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Aug 2023 14:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbjHBOhV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Aug 2023 10:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjHBOhT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Aug 2023 10:37:19 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2046.outbound.protection.outlook.com [40.107.22.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1765A11B
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Aug 2023 07:37:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHRK63BjCgWMkb6uc4iNQQlvDBkqMDjag1bKHzkwzuuxz9EpLSzi3I5A9n9/duxegtUrrCiX+BneH/+/vAAgrPGhgIMoxMcTilGdGgirCvMv2K4l3HXKwfw9WIScXkkWIbRF6ezV0HtuAn3zLgfZrsITjzBeHkMwtVfKBlXLfR2UUxvmLTV3tCTzWzGH5ykeI0VARVspIaiGUJ1Ciy0mGQxmMUXriTcQfqapJe1zmJocIPIBuWNbo+nZxmTFJ0bwZ6P4lSxYUtqlCVdxv/9MQiy40C/NOuCjehKx/0Cvi/5+06KgwCEvsdnW7CGJxA/xq/gf1rwZ+lKR2yagPqLTHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nklKVdbnvHaGUR84e8mWHFA273qb1rQ2f93J3Zps6RI=;
 b=YtvsgNkpNYiSpoK5ecJ2AjuqATQ3STJ2DG8zWYUluQy5ES3PwYG4XtAtmeQpfO6CRcr3g6B71gKMYFVZN6peb5i62xZdaQtM+dQtSuXLzRqXwyPCxt11Dfdqgyz5vUlgQzun6x9WcXTeDz5W9ETsn7s0FC/1Z8ffuYBWDMFRk4aU05LT7Nj+wwdbZWaTBXrWcOkfUVNA6TW6LmuGisoydCTeQj4E0tdJARke6hMgOQXaQEDUqgxrpvMlLs+64ndnIn5btWTwWTMhwnYMUt8vkcdN10IduvwDuRvmhX0Dnj8dqv5SJFK8ntat8Izh9OyFnrx8+Ss00cTMF/KgyWH/yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nklKVdbnvHaGUR84e8mWHFA273qb1rQ2f93J3Zps6RI=;
 b=L/62AL9zGrr1kK6RDZeJzqUDHx17UNU4SgjTCxdRbUXrojuttlcivDMnqxxfB7cVMWed5etcQO/HxXvNFwH1vErJkaWvlGJ+JWKax/HCXDblqYmcZ6CP+ci4UOBfNirABh83H8/tEpNnRY1t3LyRuyKyojOftFF4s3nS7up6jaU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB7582.eurprd04.prod.outlook.com (2603:10a6:102:f2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 14:37:14 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 14:37:14 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 0/1] Bluetooth: ISO: Use defer setup to separate PA sync and BIG sync
Date:   Wed,  2 Aug 2023 17:36:37 +0300
Message-Id: <20230802143638.59945-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0016.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::21) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB7582:EE_
X-MS-Office365-Filtering-Correlation-Id: 00620689-0a9d-4995-bd00-08db9365f6d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rbDEJHwM555kN7WdffQ79arLwuo2Tq7vG20r8COiyPL7OiPtkF9wCohW1GQytuI2verlBTPyzFYICuvYlfPNYG8+9NqP9yyreSY6bWmI2X33VIfwJ7eghuLattbgyfxgbBRvMQWiuVDKdbxlE0Cor/SJLY20hPSlniGkkwOwepXvIJAoV8XbsUV59P1jVCvHuGbANdFjKLHyaX6rIxKZssZzh7mX1sfXW+k1MEOOrqQyaJOHTNRlu9kf8q1qLhKnw2mpo88ZkblQjITxZN9PldZNlS73dtvzQXam2aFVfu189OOiflkNiIM04KO1L/bMlLHGoyKEk4c2GJKWWVVWY/VRaVDmURfEMBWoRRYV28x/EYTFmoceFXuSaGVJaXy4YIwm/Mp58rHCigePr/0oew0jNdmFBdlWJfxDKJ+KfH1OXU/92PWTBfc4OT8BjuezVY+ral9tWEx4J419HOcAC0GEpkvtKxdn0Gu17tu0H4fRNuwxeXq/mGm2crAzzNfxsvgXmGy4TyzQi26EZQiDr36wuMbzL1QqpsYlQdE2UxNjED6kSxPy2TYzIhYsjnzn9o3ZYc3p3vF/fStfk7zBkoXMEjBtN2TlYXAQcI3VXkeXRmy3qPtelraQlTy6zYFC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199021)(4326008)(6916009)(86362001)(36756003)(38100700002)(38350700002)(52116002)(6506007)(2616005)(83380400001)(1076003)(186003)(26005)(6666004)(6486002)(6512007)(478600001)(66556008)(66476007)(66946007)(8676002)(8936002)(316002)(44832011)(41300700001)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o9DCIYLub6dXo8sAp2W83p3DNo/ljSTOEawr6/BKS55iZEz9sYLsdr6D3HHQ?=
 =?us-ascii?Q?Cm45Sl78NjNCvlxoUBoWbUWCSKeD6pqqZlIQ33mJGsWUro5BIThU2tSZz2ce?=
 =?us-ascii?Q?TqJOLs/amTstPu3lOPMugps9xqgvbKWw59mCe+I93Qzu0QLUyAeeCISxXFpT?=
 =?us-ascii?Q?nLwcHnTudN8g8biv3Uus6794g8o7YAOIcLQh7po8MTbaplKcaIarWRGsi4ju?=
 =?us-ascii?Q?stWi3QPxVK6IZMeJ7StYbmd7bjNPXHEyVYucGouEyk+dalVObYXTmBGF6PJr?=
 =?us-ascii?Q?i3kWYts43zL0i8p1AdWX5K2eLSrJRdXzNHlShdEdz7H656fYX4z5lgWVm4AD?=
 =?us-ascii?Q?oHFcXbGA0PY5NSMdPUzy0CZWe2ozth+GSahkFzQCZ1X1J5ONruilr/yF3TKR?=
 =?us-ascii?Q?H5ChwvJf7vS/eAHePSLiKgjvDK5NbCnHuw+W4wXF1c7D92CK8qbnEC4+06Cl?=
 =?us-ascii?Q?XDc+fO9Cga0KvXzD6Yfm7mBH6V9ql2Ct1Tzou8IxQr8qeHlBTgxEubJSK2s8?=
 =?us-ascii?Q?mqjh+/fC7+Q0yRpINNddbrhp4Qjz0b8iNWBcRedNnOxFClG1CmoiZKCkfKo2?=
 =?us-ascii?Q?J+ml1T9jgowTIQQfWO0Oa0eATLWU0sGVS2u5iZz+ycCwqyihmEhup8bVWjj0?=
 =?us-ascii?Q?RErjpJlwNyplyeLWM6dCABhUXSba8mXIU9vU+4KlcfVjgxkXMTS6yqeaowlz?=
 =?us-ascii?Q?uEMThf43Ri/Qm//JEWo4H1PADrscFb60NkGl8aQSK0Iepbn70xYGDQc3tK2M?=
 =?us-ascii?Q?mZfIDnNrtIgeX6ywdOg4RW1iCHQUVOe8SDIAFj+S3MzV+m3QyWEdtqo84GUL?=
 =?us-ascii?Q?jkJGQve2QgvrXH9L8WQuY9aEzyp/o0Voz4nv40g798oqliDEmsO3WeFrcMbK?=
 =?us-ascii?Q?OTR13gydVpwe14gw/j1ZGsMbam0t3OJGgOkwS0EXD1IiJSI0mRuqv1q+xVkB?=
 =?us-ascii?Q?F3MHADT4L2PuGe1tUH6xcwvaCYegBs3EPeGYrkkpg1n+Ro4J2NSr2Z6BiqK5?=
 =?us-ascii?Q?reluUzy9uQsHsVy+sbVYwkOe3QSeKHNBdkUCnv1nkbAOQh8JETLoPOCQ+1Tx?=
 =?us-ascii?Q?JQGJO01cCmyILtraLWMXjoj0mVMKv+Fo4djJVpGfN1JY31+cQfO+Xj1vQDkL?=
 =?us-ascii?Q?Tu0xDAbmPDDvjHxLUOyjxDW+i4JECG04cJycc4Xv8kJus2OH4fABlM/4pyt4?=
 =?us-ascii?Q?EAgHeow0zvEOWxH0r7BXchbvrepNOtRqkZM7mN+yZPEMP+w8LL3mvAsfrv3R?=
 =?us-ascii?Q?frMbEb4najM/SZD23WehnsEAskE2uRSBqwQeQ2KYLdvih2cQSe2UYIEh1vJo?=
 =?us-ascii?Q?JOGCXOJYAOU2wOj9kLpUmlRtTevo+VwUUyHaWA+kJ2+9iPGVb7W7YWn/8CT7?=
 =?us-ascii?Q?P8HRnpz419wD7t7TLAcb1gs0u3vqrzeWaSAlE2u0sIWa0/OaKuAsJfkMfTSG?=
 =?us-ascii?Q?/5uy89WjY0ZUwlFqAVlgXiu6ursRzOgWDDtgwVHbZKsaW6QOPGNcuF6a7ZEP?=
 =?us-ascii?Q?E4pX1zZpBwo4uPwlqAZ26hR0pt4v69OH1SAIGws6eVCVipmLyCTIhf8IpJ5i?=
 =?us-ascii?Q?IobQLnqeh7EQtS/2Cw7rI912ibm6PceGMVXYc1MOPHbze/r09ZDlVkevZDVd?=
 =?us-ascii?Q?+g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00620689-0a9d-4995-bd00-08db9365f6d6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 14:37:14.6640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x4r7o3KEGY4m50S7EhHktAJP8CWlUduCZtSjjV0I83MC8JKFSBzi0Q9rTbrkb8RZbcsqJROHDGZ4kLiJcCeMcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7582
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some scenarios require a Broadcast Sink to complete the PA sync and
BIG sync procedures separately.

For example, a Broadcast Sink might synchronize to the periodic
advertising transmitted by a Broadcast Source and it might detect
that the BIG is encrypted, by looking at the BIGInfo advertising
reports. If the Broadcast Sink doesn't know which Broadcast Code
to pass as parameter to the BIG Create Sync command, it might learn
it from a BASS Client through the Set Broadcast Code operation.
Only then will it be able to successfully sync to the BIG.

This patch implements defer setup support for the Broadcast Sink
scenario: By setting defer setup on a broadcast socket before calling
listen, the user is able to trigger the PA sync and BIG sync procedures
separately.

Iulia Tanasescu (1):
  Bluetooth: ISO: Use defer setup to separate PA sync and BIG sync

 include/net/bluetooth/hci_core.h |  30 +++++-
 net/bluetooth/hci_conn.c         |  13 ++-
 net/bluetooth/hci_event.c        |  41 +++++++-
 net/bluetooth/hci_sync.c         |  16 +++-
 net/bluetooth/iso.c              | 160 ++++++++++++++++++++++++-------
 5 files changed, 215 insertions(+), 45 deletions(-)


base-commit: f0eecb651f964da87235836157df953fc5318b9a
-- 
2.34.1

