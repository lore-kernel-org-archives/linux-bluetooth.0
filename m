Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E3CEB64DC
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Jul 2023 07:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjGCHDD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Jul 2023 03:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjGCHDB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Jul 2023 03:03:01 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2087.outbound.protection.outlook.com [40.107.8.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5435898
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Jul 2023 00:02:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFZ3sRFjgHuSoAxjhhh0QVZTGOOKFRRzrd5amF75F2JHeVLfPNuCXgOxXwxuux+DEyr411LN6v0mIRH+FosJwdG/xJoZBjwT2hfq1QuXiSng5dJismBd6z+5CZit2n76iz0vYlAtxpttqaU34XeoGNJc6uGV2S1gv01GxKWXy+TGWqMNrJV7/8/aDrWe/KtRJDXDjvSyVpqcks/QdqRplDiVelabezuHXr3sp18yRStQ/waO/DHA24VNgqkNV3SAma1NTvHJKqAA38APd0TGATn8ZK90hiUwUYTLJzGypSsdm1igbVCao4xscZKsBXXVHpcpzclt42s3AiyjfBLfkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRAloPdDOaB6PP+z0ljCOa7AerfmJwGsEMeg569ZWPc=;
 b=MDTU8wPJqXiMNB8EyGC8fMJJ2WlK81HpgM+hfdDSTGocVJ/gZNS6A2e60GRJ2L0mNUi6O4UFPcxmkarTJ9ahpeFyBemC7u9e1W9lI+dv5eeB3skND1gJ7vOFGNBUlvULmFkrKZ7SdS1mg7DCrRLtHCpcWV2BP8Z3ZVD7j5C53AZ1CaUzZdBNxHk+UkXfHWuoOlfWEOwsjxC4SHdw2TxNBucUsgTDMyiBURfnY077dj7zNtfEACAQM37VUSYO/qvoJNt1bSQzWZMm0YwMcEP8zChPb3b4D+60DpUCQnr6AxG14G5qCFM/9LOXZv8SidruEJODaWlEhA2uQMbgQmDRzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRAloPdDOaB6PP+z0ljCOa7AerfmJwGsEMeg569ZWPc=;
 b=jCjPBl6p/u9UA6Fj5pWP2+XPOHA/M2v7o1kFPwIKV4xj81BA/Fg/+/zJwm9IcBzYS1+vfyOZgb9y+59JqLmAQYKap1fuEHtpDuM1/h/Fl1IuWtefdw7mcnk34R468kPL+aY/kDgbwn0qqCAcRjANQZbo3SR8GpWnSW85Wdw6Gu8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DBAPR04MB7317.eurprd04.prod.outlook.com (2603:10a6:10:1b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 07:02:56 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe%7]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 07:02:56 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v4 0/1] Bluetooth: ISO: Notify user space about failed bis connections
Date:   Mon,  3 Jul 2023 10:02:37 +0300
Message-Id: <20230703070238.4193-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0006.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::11) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DBAPR04MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: b0d794b9-692c-4e33-382f-08db7b93878d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s28twvfEuJ0Ib7xiUZAtO953S5+7BurIRizXxu0nzjDrvxDuteZqpTZDxlJ5yCLRUUqrO284MrhA+FZWqZHSFR09khbL+kqLtekpVeLBYEdWDSjl66jupT48dNP+isuttuH6JDzPY8gYyd9BCdPn+oc04HQQ3I0IW3Oidt+J8NguYg196uZQwFhXcmJQbrTQv9Vb6rskO4x/M+Ku1acs8bpHSVTAFRZp2cVp82k7ZABEFxioTQ7SLiCuih/XLk+XJKa8SGwCMoz2WsUYWuEh4rEym/8WwwHFRTCy7o+d8Hu5HiLIJpxTr2VLrhoyXdkJjlnEExBq48Dmk3NewJ4cd8yn7F11KsdgSHKUwZ8v8urtvRLVAk6Tv+GHPpLkAigOkR7oVKn3nMO49GKYzrLrWun/zJ768doJlxGtHCkmbwLO3z2lz6MRarjK7H0Bj7jaL60kMup6OCBfbdqGPPQqjRKqkwXcQMSdTZO2C6jZix8habXnfCMD/i/c05yxA984DmjGd9eClbRfkSdYqzxckDkySLUUyf8kzGX1sy7cW/lXq1RO1E19GBALgqWzY9Oxr/THufohfVlX+Wwta6kw8U5e23Hj+r4M0ZHGdp/2vtFxQ2gx+V+b336kv+624zVY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(451199021)(2906002)(41300700001)(5660300002)(44832011)(8936002)(8676002)(36756003)(86362001)(6512007)(52116002)(6486002)(478600001)(6666004)(83380400001)(186003)(26005)(55236004)(2616005)(66556008)(1076003)(6916009)(66476007)(4326008)(66946007)(6506007)(316002)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QMEYvnoSTctoP28VMeTqCWMtnJv2j5j5j2ZH66O7wu8rXvdRiSyMIsjDZmTk?=
 =?us-ascii?Q?ApBRL5CGpNUtSHfUmjAu5on2R9AmeXrIA78ThkdczjRJcanzLHytuJGYAnXH?=
 =?us-ascii?Q?XIp5dqSbUicLTRQQ6BcMdBRlVyA8R81lCkoDzM6W6kP9RQ2J3jvM6E3hTEVh?=
 =?us-ascii?Q?crgjXMM6leHcBZqlff9t6u8UsQ19Qxk5V4Bll4toCIH3EDrn2OcpOJQ6bDov?=
 =?us-ascii?Q?2xQcLyseMl2wKH/CmcdgwBgQqo60n4MWC0rTai+co5uQfsIc7NNB+5TGuU8X?=
 =?us-ascii?Q?KDtmES3NBLvF/DBS07WM8b3YmFQYdniOTZ3GBasTBn43UHau1u89OsdDSSwC?=
 =?us-ascii?Q?QdDOVi2uHIt/hNHOzuXRK/1JJy7Krs23X+C4jO42wI2+YE18dOgwHy60rIwE?=
 =?us-ascii?Q?IGeMPQ4zuzqffw77qJEIIMS65qssEiiaoMr8bmV7aEM2PzNaLIdfTlfv9x0e?=
 =?us-ascii?Q?VoXNf54IQ4TZyuVBf1+U17hkOa7ptxEvA7/c/Zf3YYSOslx6dmna0tN88uRZ?=
 =?us-ascii?Q?J89sm9Fb4+lUgPE2bjrbXO3z1z3WzXIfGD0iqQTfNOrVf9m0wUQ3LXkyBZTc?=
 =?us-ascii?Q?Fn6o+NR5pYRoWvbtR6hp5B/CTKx5SgTAiTV9q8zn+5hODAYSfgTklBlc7hsA?=
 =?us-ascii?Q?ItSgScu6z6jskMijIHHWH5dr/eRP/XNTnHLPIO82WHd0ACxeZwSH9zBF70a8?=
 =?us-ascii?Q?Ovz6A52Sre8tAB8mtKPNiLhF9Q6/L8R2r4hsMNYHTsRmHo3t3qawJiHN26Hc?=
 =?us-ascii?Q?aVtyh2rnMnOhiso5SNwuFbCNqeTFhFOvCoOXdO0k/MBiMaCpwu5iTV/LotKn?=
 =?us-ascii?Q?BjxL9NRZfHZ6lucIpSvH73rMoSsGew1TvLJDwUcwYx8PGV7qcNMw1F0sMXph?=
 =?us-ascii?Q?45XiCaClQiaykUd7hwNKEHgq+bEelcDOkoM2n0QHyJ3Juy23BngQoKYIygFt?=
 =?us-ascii?Q?f1oI7APzgpla5H8FnVy/760ZaxRVqeOQgGhAyOOHcQbrnm2qYDXCcrYwpVQ3?=
 =?us-ascii?Q?dDl+d747Syumdxs4m6sUi/thuP0lYn1Vsch9u2bMfxB6f3SB4662xt6v/I5W?=
 =?us-ascii?Q?b8gTSh4Pp5biPjy8ZqsiFmLgEp4WjGRPdJHtfQnFDFAYzZPEAb8silOWu3IT?=
 =?us-ascii?Q?LHBJ3b1aA96/4auBNPN9BF/lLTYlA4eluPHn8XhdMokj1JHoAEdwVbb6QGNW?=
 =?us-ascii?Q?hAOJT0kLveVp96J98YT/uQEcFfgqk4GUkIaAt48610fzQ8DMK4+oaB34A5O8?=
 =?us-ascii?Q?CXCpkmILgfS5Za+BoaHpYEoaHaV6SJQNiJnqdntlP28FHtSKrjRLuyemTtu+?=
 =?us-ascii?Q?8OUJb/tW0TLk2JSR6CUn4s63Nya5bhRAUmza9qNtPI5O0Y6Cdx2dqtBtVzxo?=
 =?us-ascii?Q?Rmp/GSr5oOgtT4SYyLRB5JjXPfBYB6YqYmHexfeWf9fM4mixOY3xE85WtLY5?=
 =?us-ascii?Q?0in46U8VrP19b7mrW/wTztPzdQsbz+xOm2z9Zs+/E1QMOFZUw0g/DprEh7GC?=
 =?us-ascii?Q?ru4M3aYRxudjBMWIY+08qeANEy9+pD1VWMb++gD/rn+889LHmyCrVafFIZPt?=
 =?us-ascii?Q?/i0IFCCLZTotwQIVTKoxcnshzT9/5C8jp9h8XLWz/oIWvzP47mU2KJngGpZF?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d794b9-692c-4e33-382f-08db7b93878d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 07:02:56.8738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OY3qhcDj+mAoogukMfJiUSz5ppJc2lKHNl3g6JyqoleKQjzZazlL8x6up2T6MBie7A7seD/qP6YiceXZF0vjvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7317
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch makes it possible for the user to be informed if BIG sync
has failed.

There are situations when certain procedures must be started in this
case, like it is, for example, when a BASS Server fails to synchronize
to a Broadcast source, as a result of a BASS Client writing the
Add Source opcode to the control point characteristic. The BASS server
should be able to detect if the sync was unsuccessful and it should
send an appropriate GATT notification to the BASS client.

Currently, only successful bis connections are notified to the user,
using the listen and accept socket procedures. This patch proposes
an implementation so that unsuccessful bis connections are also added
in the accept list of a listening socket. The connection error is
marked by setting the sk_err field and generating POLLERR on the child
socket. This way, the user can detect if an incoming connection is
successful or not.

This patch version fixes review comments.

Iulia Tanasescu (1):
  Bluetooth: ISO: Notify user space about failed bis connections

 include/net/bluetooth/hci_core.h | 25 ++++++++++++++++++++
 net/bluetooth/hci_conn.c         | 37 +++++++++++------------------
 net/bluetooth/hci_event.c        | 21 +++++++++++++----
 net/bluetooth/hci_sync.c         |  8 +++++++
 net/bluetooth/iso.c              | 40 +++++++++++++++++++++++---------
 5 files changed, 93 insertions(+), 38 deletions(-)


base-commit: fd859b4a38153b4d9e1942ade471f4fdcd8d224b
-- 
2.34.1

