Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6134CCA0EC3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Sep 2023 07:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjILHDn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Sep 2023 03:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjILHDl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Sep 2023 03:03:41 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2063.outbound.protection.outlook.com [40.107.105.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E83510C1
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Sep 2023 00:03:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8kU63otHJaGSlEr+zbfEqLvzwkkyxBTAWFjFGGV4d0AD21Qlwf9mgx2CIc12jxHh8V+cW6P9TKcC5UsZ34ZkZW9HfDdSws61mv17jPhVdIyTvkMbo+o1SUYSK0AYJAJb9n4cakiPtKKMRwla/DEvJV04kedXr2ug7lWG8onN9sQz/sCBGa4VXjYrXaPzf56cAQaMoKveXdiDL6Wj+F7AUdwp1uXdZXHIxRpjBnVIzKOhPZXrZQFUscNX8gcp8nDJYrJ5qlj29rZ+OFIhcMWAQ6q35Bg9sFeNSgV5Jjc+Er1u46WERjDP8zrKXnl6UJL3unZV1zvBI05jxBSnprRVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZViuvYCYjQ/DNpv72EOJqQe6SgWp7YZEBsaUZV0oATE=;
 b=j3+DXOs91P/sdBPyOrInQqKRvIr19g1lwTIJK53gb6opLIVa5Tq/oD0qPDsP5A/DVbDBh05ggJx9VEU2OVNK7okjHJVPTA7wE7EuYBHk7Ni/USsWMg9y9Tdr1SRG0tzQfnCVDY9zfVBoiyhB2Bed2i/ISYabtH6LESQKAataGgjNU6N+08CxlOJBfScI9+0UKAnKodd7dTpGCF7RzhdHrcMRx+NZNAmEjBLm52uXmlnPk+aHW40E5tZaMmEeBaQp18PkI104K/GvZRk2xhubnxbfybjHFgkFpVrd74bWGdL3vkKGywmZpyjeptkH7zK71FbqdH5pv/47vqrk6EhmmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZViuvYCYjQ/DNpv72EOJqQe6SgWp7YZEBsaUZV0oATE=;
 b=UmUvyvKomRGN3WOsCdLyk2uHxnTNbX/qitlJ6aFxwbodRLWU1wfjgRR83g8C8sZPHLdj6NAgjCLP0TtXWiG8GsAAjdYUhVDGwA5oSV35Tfy3kIi/M0BaH8Jk12PQkYUrzzMt0UIRvdW3kFLYojX1lkgc6jDRHHcbHvSER1jdV8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com (2603:10a6:102:2b4::19)
 by DU2PR04MB9084.eurprd04.prod.outlook.com (2603:10a6:10:2f3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 07:03:35 +0000
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636]) by PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636%4]) with mapi id 15.20.6745.034; Tue, 12 Sep 2023
 07:03:35 +0000
From:   Vlad Pruteanu <vlad.pruteanu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, iulia.tanasescu@nxp.com,
        andrei.istodorescu@nxp.com, Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 1/1] monitor: Use proper name for CIS bit
Date:   Tue, 12 Sep 2023 10:03:19 +0300
Message-Id: <20230912070319.1224301-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912070319.1224301-1-vlad.pruteanu@nxp.com>
References: <20230912070319.1224301-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0039.eurprd03.prod.outlook.com (2603:10a6:208::16)
 To PAXPR04MB9398.eurprd04.prod.outlook.com (2603:10a6:102:2b4::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9398:EE_|DU2PR04MB9084:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ca54a7-9e5a-4312-1120-08dbb35e61a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X7l8hDxzYx8x/OHF8CjjQ/3zTxyd98at2nzAVjVfoABcJVns+3Nvjhw2p2FWZjsl3zl4zBu53UKY+XsNeHpvuIeIhqBrk/Fvifc1an1reImAnvqM5+/Oogz2zrFVZxJFJh83yLMRPRTgMe9/zAjI/8S1NIWvWw6lOkKR06FNjWNdTBVvTMThV527T8VVw7MhkjPHQKQ8Fi+NVgawewyhQb65N2O4u74JMyaMQMuUzVN3VnDaHnS3t8ioTHGxszmWXhHYW3OqlkciZFB0cS5Anjus7aO6AOvGbpFEuwXncmWHEYJt6UjbQDCe8G0paSaH4VJFNXCNK1u2oBIZxQdfBsqcRNSyEwDWFimk9M0T5Db9q6Ny1EnmiwnZ7N4f3EphTAaQ43IrUcJKHBLNRyOVtczLOMvlV3BefTYrPmWPuippWA+YXweiq0c5dPGwZIo9Qqf34x8wljY0jJ0Q9QwqBYrCXKqCvo03keHz4aNkKHf+EIbjGetI1DexPedRlpB40vYO+h7xZC9VYRSRl/stxPjY6nnAQ6xZPAag/r8F5gx8OHYmxdIsIz4/b9kmTUP+iPYxpDjGjLxEsTNIBgad5S3tHpjhjiSgIsJhwCmQFGGW7jQv4LtsqkpWIpaJnJ+o
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9398.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(366004)(346002)(186009)(451199024)(1800799009)(316002)(6916009)(66556008)(66476007)(41300700001)(66946007)(478600001)(38100700002)(38350700002)(4744005)(86362001)(36756003)(2906002)(44832011)(5660300002)(4326008)(8676002)(8936002)(26005)(1076003)(2616005)(83380400001)(6486002)(6506007)(52116002)(6512007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?se0iS9tqmFc8q7z8OmhNn1GeRTpxwFPF9HfsWUWZ4DWNgWztv2JDy9xuLh9E?=
 =?us-ascii?Q?hLsh/TJQkJJHD2bTKKN6cqqDjz1Os/WFTyCTzxj628+u6t6WC5kSZ6phGRrK?=
 =?us-ascii?Q?rhK0UJwPCs9MjcvtSrV9utz4SkY7tw7VuMqXrxQ8CPDDjf0F+gwvso3ZPcTz?=
 =?us-ascii?Q?BNjE0ShkRhnpCj8erwdhZtikihIV5mc8Xyatzs1cd+AYo0mMGfALiS56OvXq?=
 =?us-ascii?Q?Fu6cccn6SbqARaiWU7NoTVPfMWvJbOtmi4XUplsje/rnz9NOEzoj4GpMCv1M?=
 =?us-ascii?Q?Ksm7lqSNK1+nH42xzvZxE3wuMv5CDXpaNyyt4dFHlGe1JL6beRGSMOhg6Nik?=
 =?us-ascii?Q?nucMimj6MD0OL8l+NRGTqAMAUTy3T0oSoC6oekf6T8mu440We3I+aKl0Bwmn?=
 =?us-ascii?Q?lvn4CM+XLwSs4VZxvnUnnpewHKThujz3cix2UesDAQNPHVLg3abRB/BEp9Tr?=
 =?us-ascii?Q?fMgS8+qjlaJAaI0phhlQmW5SCbIxBmcCpOM355mBt/q53jeiw9ASM3cSra15?=
 =?us-ascii?Q?qL4B1idKHgB8xQ5vkvkVDvIbM3Dk7eHH/xeat884KGHO/vstWJjsvSng+vHM?=
 =?us-ascii?Q?hNhbDJqOioI+cum03P9V0l/+eb6Buv2Jd8TRvnnOzfO7aK0k0ZBnW8Tfa/wA?=
 =?us-ascii?Q?Q+o0APN0ix4Saaxa1Uzn1SmRZ9waUdtQbdMKz8vPIQjllicuv0C7u1T7LC96?=
 =?us-ascii?Q?+Z9hvbJgd3FKdIJgSy/nwJZ6gvN2evgbRSOZMru+w/7IhxzRcMsGSS/foQi3?=
 =?us-ascii?Q?SdwI/WkIs8PzxA8k0Ngl6i7YXXQRQ8yzff2qjMvWW+CA6W2lzPk+G7nEr6xU?=
 =?us-ascii?Q?saZHJyNxRXtcIgISVSyTE4zg/2pVKmjzzeHFnD8VnCM6PaXFbLMT0LsFhwaI?=
 =?us-ascii?Q?0U11RIvtqNW/tfLwS8NXOHH3jnBA8K+JoMkyWoH5p2LmkmnUbA5ghFTLgdu/?=
 =?us-ascii?Q?FH/BHwl+2JF2bCG2Pes4w4r/Jxo7O4aHhvSB+nHJCxg4IFVqlf9bnXr/LQ0n?=
 =?us-ascii?Q?k4Lo8XBU71WKOFUEkYvUOH8X6saKnJ35NTbwSO4TKYHlxhCHUGXRfFpeJ6pF?=
 =?us-ascii?Q?++vfYamV3DuRtxF2Qx6P08cLSUlQb5lT6GwkWjnevZRX67JvFm7G4C1TdWuW?=
 =?us-ascii?Q?JgEEgwWjkAIUB4dL2ORVLRdGJzMlhuk+nT21p6lkaLq2SNe8h5FPwc0TAHtp?=
 =?us-ascii?Q?6mIGWKdwlYXhsFmZMD1sVJ6p36l5RGWDpcPQ7FpwKPXP1YqVODGbG7Xr54gW?=
 =?us-ascii?Q?0tQJ+dzCkx2Tp1M+E+T3EPGnT0cjmr7gcOW426VhO80oZdd53U4oAQb5GErl?=
 =?us-ascii?Q?cQMAXC0b+yMRSdNyaRRHu+IR9s6whAZWyVPTiLVuwTSEhLJ/PDiQtsgE9r52?=
 =?us-ascii?Q?PQe/tNOiT7exI2oDRtcMzc8tNR552z0eDirWpPY4y5uHKP2xWgw/llZMWHo4?=
 =?us-ascii?Q?PVcYqab5cEsMebPM0AIJEYNRD5gbIFaEXklMZ1682rF+6cLr+5GOyxgZTxCi?=
 =?us-ascii?Q?akZ1LSnYZVhsjKPJJuZSYnUxPsTXMo8IfSQIshl0RIkXBsMtJvMIhMAgemgY?=
 =?us-ascii?Q?nZAQGucHamB8YrKhKshq03gEttwd5B20vUZyR636g1Zn/YNOclsxtWbtKGas?=
 =?us-ascii?Q?0g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ca54a7-9e5a-4312-1120-08dbb35e61a8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9398.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 07:03:35.1418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4iVckav/MY/wlgrWrrExLnyBfKGX/g1vDIzxtR5JSg5gQSYqKMa0jenwnf0zZEw7XhuEqO6ki8KuUuMGofwMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9084
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In the Bluetooth Specification the complete name for bit
number 32 is "Connected Isochronous Stream (Host Support)".
---
 monitor/packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index f88a11539..76bc2120f 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -2723,7 +2723,7 @@ static const struct bitfield_data features_le[] = {
 	{ 29, "Connected Isochronous Stream - Peripheral"	},
 	{ 30, "Isochronous Broadcaster"				},
 	{ 31, "Synchronized Receiver"				},
-	{ 32, "Isochronous Channels (Host Support)"		},
+	{ 32, "Connected Isochronous Stream (Host Support)"	},
 	{ 33, "LE Power Control Request"			},
 	{ 34, "LE Power Control Request"			},
 	{ 35, "LE Path Loss Monitoring"				},
-- 
2.34.1

