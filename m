Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347FEC77B7A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 May 2023 06:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjE2G3p (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 May 2023 02:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjE2G3o (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 May 2023 02:29:44 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on061d.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe02::61d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25ED188
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 23:29:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcpBdJ/jLMz8WFgJxMayuArr78eG7IUYrOkYULt0cFlT1T4m3BZd4pJICtRhTPDnroVNv9Jn4HJ1E9cQCNdYBsk4SW0XsGP3xeECAYixaSrEiTn+/t0idHyRQONx0MtDo1A6qr7S3emU5HNPcPuMCdM91FlLXxti+xxpZZWQv+8rAgyQqn3/5pyQL3Iung2thxLhVY18x0PRtHiqMVq4hmSlF+Eq3hlQh5tHI6Cc/NFg7OP8umuYa12PzIOddij5z+k+b43PfYl7VIEsU0plZehPEySCF0ZmaXONMyBy8RjiEXp0Zby6CRnSDEzuBWR86w/ccgQru/1mlKtI0RLlRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewmSeDiBjiJUbmwXYTFK8E6A8+pfCxcAw/WQ9ECO5XU=;
 b=BXrylZ57pnQhzGL/V9PrgA18JFIgPak5W+FkfkaZf2Lq00NZmmbn3LRx+owtHXHPm82Ny5sm3W0akSw1J+DJwicltPGNsMw/NX3yop8uRdtPpgz5Y/qASsVEZmdFB1MLLpiyFPvtZbuanJGnlI3d7vtFfVdpIOZmm59A/l+2A/kepJNePf8wpySVxZZn62ek8fLQcfD2IZTIiKGvHmpEbqXoKivBGDduJTsKF/Np6LKHZaoQ33I4SbjCfoNlhfrL+Dr2VVJQtO4sq6PgMQWrhnFdXAETQxaAQcpn2FO7pnP2dUPE1dQGBBm+gcvXv8kaxrUZRT8YbglayZYrZOfmHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewmSeDiBjiJUbmwXYTFK8E6A8+pfCxcAw/WQ9ECO5XU=;
 b=qGtaDbsdjgHkEIfK//fUUcFBIS/GDoJFa4kknGOSZ0avVtmMEOVtzZ4BIq+pxvLAN0oxn/BgE+uzgQ+mc2VtJqzFJfC2/YOmMckMKzjXpN97r55c/TcctfxN8NOnpEt37FqbRJtHEHQLSTx1we+ISI72D8veHgXLl1djyHLzjyQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM0PR04MB7028.eurprd04.prod.outlook.com (2603:10a6:208:19a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 06:28:18 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%4]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 06:28:18 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/1] isotest: Add support for creating/synchronizing to multiple BISes
Date:   Mon, 29 May 2023 09:27:33 +0300
Message-Id: <20230529062734.3685-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0077.eurprd04.prod.outlook.com
 (2603:10a6:208:be::18) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM0PR04MB7028:EE_
X-MS-Office365-Filtering-Correlation-Id: a9e05321-8904-4c5a-874d-08db600de40f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vUz7BnR7Hiz6PlLd/gVnBM+lrSNJV/iOFC7fSHNcMY0aCEor4gmcWPrDrj1hCtw/jAqqY3iQdr82bmkZMoVTDPyk2Nm5oCdiweeUTXPjuvtJyoAPhCu1o+g/2q0QIn/uYI7HYHtBHXgKmjdI0wzHu0arvn3yjmakC9eMN3EBEqFjgNVx9lsC4L7h/dywMy+1fs8UuonEQ5wZ4IdHu12Ww9Z+YDiBeoHEOtMXW7S5dKghp78QhOMpIjz2P7+OARKHtefWocM7t4KH5lL6xAoAIMeefcOEwY+gz467hGnsvNqZy4ZM4iu/4KShWuoIUSDHMzKpCRn7tMfCuei5EzPGkQGFYSFOm6nhQzx3sslDG0ejTy0rCI67er+7z5cY6zHi9Q+6Yn5sSYLpuLV+D9HGu37yGNaOwD3Jv1avVenWsg+ysNW1/FgXJgVErmp9tatIe0N41DlDzKjOuASvkdrX89HF39yVunKKm6vIZneHi+blpKcLmgClEFwfkR3oBtGmcX7xrWMB2Ndg9rVHtxzOABfPuI756+jYDnURMFETIJ+TsXbHta/Jzfg2J9cdmhIoCnlUcGRzkbt+7G1d/YBvj++MEYG0MGo/yb0XFKk3F+Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(396003)(376002)(39860400002)(451199021)(26005)(6486002)(52116002)(1076003)(6512007)(6506007)(4744005)(2906002)(6666004)(316002)(186003)(5660300002)(44832011)(41300700001)(36756003)(8676002)(8936002)(966005)(478600001)(38350700002)(38100700002)(4326008)(6916009)(86362001)(2616005)(66946007)(66476007)(66556008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nOr9dmM5viSokCFOd7EKA0NS8Ob5KvHvom2wBMlauYkBTmqEsOim7nq/myIT?=
 =?us-ascii?Q?Vh6zo7gMfAK/E2YQb3jiXfuuOu4wVg9vUkRmhBxbq0w2NAiv3vaZKWDfd3QK?=
 =?us-ascii?Q?jWJGj3I/3YuhZujfyZ3/Hm1VqOJ3d8RBPbDijLNDmEqGvvMClhLJdqoRU8tG?=
 =?us-ascii?Q?ublodpBrEwN7gskueOGG0vtp39wWqzdnUuJjcpAUuDJfhv4ctchbRKMiEOz6?=
 =?us-ascii?Q?U4pm7vqjbCV6yrsFFIEnxmY4ykTWesrxOtfGl0FCc962U7Zq9RdKnokJWVoi?=
 =?us-ascii?Q?UDVZNw14DmZcPHZxA27m2zmaiZIUTMaM0FYF9hIdxZuCSyuHwTs3J638vqYR?=
 =?us-ascii?Q?Q4CdJsct2bkJYkvOg3coLakwLJAEwbafI7NjbCyJPYOopDnIpSk9NvwX+Uzs?=
 =?us-ascii?Q?1IeyJGf6lAQgjv9eHMsblOrWqoxCT5L9/oVxCagJnswUP/46SaKURDXTFrAX?=
 =?us-ascii?Q?2a7+Y5GPWlULDJ2/hLQgUM6Ps28lFeP5c4JzV6WW59hg0XtVWOTpBK+7tNjt?=
 =?us-ascii?Q?j+27NnSRJGh19XxhEk3pT2SF/jVIP5FMWBHevyZWlWw73T/qCQqe9w2nVwKQ?=
 =?us-ascii?Q?iWisweNDw8xY78KcVB7hQjB4AC8kkiJuu+uCT1xJLCIwPOY4qqe9tL14yCsD?=
 =?us-ascii?Q?5Z1no//psNEohVKqJvEGIXRgTeDPwULq1CmAw94ZFDDMvDUseGf9/jEAFCXF?=
 =?us-ascii?Q?/VTnHWiu2rW4+S+R8s3b0vsuhV55eeL93bMcW99IBhZj6y3xEQeknNaMKof7?=
 =?us-ascii?Q?FghrZ1dUbHw25YbVrM3itsHpnk7GHORyQvXSzhIFbk/RBgILSd0FYZcNk3mM?=
 =?us-ascii?Q?ceF4X0wlg4uhPTuNhdO2dF4g716y3iT4RvZgXDQ8zPl3zRCxaU6HaLYeatOA?=
 =?us-ascii?Q?SGd+tGnDP41izCX9pbASLNxzJutNpWcv/ashbxzJ1eDHoRKAP5ztHO9rbXWL?=
 =?us-ascii?Q?Qd0Pu6h619b/umIuTw8i4QeREvlRsJ3+gIFSDUcjzOeblzSPnDu+euQPAQ4y?=
 =?us-ascii?Q?rGosYn6X1Le6W3/YoS7v/Kc+LMHuWsuddncBy66nep/zS86DTIK9zmDgBksw?=
 =?us-ascii?Q?6l0voVoEQEWg+Uz9WgVkK1ibjfNZg2KP5hTAMD5oBn/aqkYPamBFawnPZVtv?=
 =?us-ascii?Q?mmOcut+GkF0Xs8MGCZ1wKtaFCEP3XCzjgTVG6WVen6IBd3qgm2aBDZr9FnHP?=
 =?us-ascii?Q?izk66qfo/RvgFuPxymA8CSOBQgH+EPe99pK+0SpVdUBNNgDYU6zMAz96HVdg?=
 =?us-ascii?Q?s9OH3Beob/zu0UH6RGq9pw9K1CxKXn8vYGy4sLfsohk7oMpbfaC4jzerwf2V?=
 =?us-ascii?Q?YxsDtCP7pPKaBRaJb+hb9ziJEPsaZbnQhr17JyDGIZDNGQHHjt+mEQ2EqL1f?=
 =?us-ascii?Q?mYgfJXBFlLZDRwTYolJ30eK2ij1b3YdD7wOXWN0KU4WMVa9hwxirOJ9ehR6G?=
 =?us-ascii?Q?bo+pe9EHF/FcPgcBgBdTlO3A6FLFw8xfP17zx2FF1h3S3iAHSADK/WSRhU/C?=
 =?us-ascii?Q?X9eaYvcRPsRvDPJQAOlCmPm6kMZIT2j24VJ31J0PbxoTCI3TlvXC1tmru/Od?=
 =?us-ascii?Q?NL+z/pEcAbKnIrHpp5jJe2t00aw/QMwyY18zz8T2coiGm1xUI2MYIu9nPETf?=
 =?us-ascii?Q?dQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e05321-8904-4c5a-874d-08db600de40f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 06:28:18.1261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5T0rbUjZyyD1R1TQ+DUS5A7gcS7Sv6PmGnhDQZn7l0I3gXDAa0eZZg0zZ8L+If6AXoDy/QysEggxbhEDjSbymg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7028
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds an additional command line option for the Broadcast exercise,
so that the user can indicate the number of BISes to create as part of a
BIG (Broadcast Source), or the number of BISes to synchronize
to (Broadcast Sink).

This implementation depends on the kernel support for multiple BISes,
introduced by the following patch:

https://patchwork.kernel.org/project/bluetooth/patch/20230529061057.3107-2-iulia.tanasescu@nxp.com/

Iulia Tanasescu (1):
  isotest: Add support for creating/synchronizing to multiple BISes

 tools/isotest.c   | 290 ++++++++++++++++++++++++++++++++++------------
 tools/isotest.rst |   4 +
 2 files changed, 218 insertions(+), 76 deletions(-)


base-commit: 7002ecc8914ab1f22e36bd98c4d46eb760edf767
-- 
2.34.1

