Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8BCC001B0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Aug 2023 16:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344867AbjHPQq3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Aug 2023 12:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344894AbjHPQqH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Aug 2023 12:46:07 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2046.outbound.protection.outlook.com [40.107.247.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B53273A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 09:45:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQojW8Xycxgku04tjBfzoDsEJC+0o10UddoTLSQMk+iq6GoEnXJ20pxZRl1l+mBgTlOe4WIs1EpjvOA6Ol8VHBx3ulsv7rDVdXRYCVg+2dc8HFoQD3fA+UY2PC+R4angUiaslZ3DXqmrbdOqtJogEjI9C6w2nxyyZ8zOfExdeg5AGRu9l3Oe4/drGTvMcNCzVJ6KZoYySU1+JxlnVo/wBkleDgIAc5H2EJiWzk/Y1hU3WKKFNaC+1rF10+lGwFGkNhW8U564CQF/3CA0l/RKGaDvWcAfXoP9TaA8/ikZF/zVHdFSyR+P9BXN33ziqOv/+u2D6mRX64I5+ZgUQE9lvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7uI7w84DbYFZ/J8u/XljhtPStzt14SCiYCB0JcpPZA=;
 b=a7uOXfDHeM9Rp3etMsUB/q4IMvOWWlimF7PdyjyCtNldatVJfq5F4NQQBM2QEnV+B6Bm5gPj/fOnyRvy00Z5bcndpJCYBaTo4+T7T3wvIVk9iaI8hqdhkuefmqJcmX4K7ifv+iZnHnbUXt/wSZ+jOTqgF0HzoXBToi5sduxvvV7HjNV157gv3CJ3gV31z203lkCGZYr8r6Q2jC9HbuX42E48DbJMod1OYW/08nmndXXqiFbFW6FTW/jbiZUeOsR64LuW6CbHvM8u6d20RTyxDQrbtPyeIyyNs4abHxGELdRKECS7on86h7fcxKDiOGAMisPLFMsLpcbsjtqrJicS0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7uI7w84DbYFZ/J8u/XljhtPStzt14SCiYCB0JcpPZA=;
 b=O7ki+nhibT+xnCUzNvFb7k5fSVqBNtAso0mEAKgz3FzJ0wYhGQBmEpMMSJMaegTWDiKTHx67pm/0mft8XXEewWSrWM+pLoYEqrUFGQWS51xQbtN+eU/q0EiKKC3JdKlHZWACbhjeyavwus8kaNlcpBSSoXoY1jCK3gKrzwAweUY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AM0PR04MB7107.eurprd04.prod.outlook.com (2603:10a6:208:1a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 16:45:23 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 16:45:23 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v6 5/7] client/player: Remove Broadcast parameter
Date:   Wed, 16 Aug 2023 19:44:33 +0300
Message-Id: <20230816164435.5149-6-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816164435.5149-1-claudia.rosu@nxp.com>
References: <20230816164435.5149-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0047.eurprd03.prod.outlook.com
 (2603:10a6:803:118::36) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|AM0PR04MB7107:EE_
X-MS-Office365-Filtering-Correlation-Id: 38aba843-c9ad-4ec9-4082-08db9e782f1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B52VRhdYZOiKw5uQPuG0GChrvYf14fWUHocx1+cOd+Q5equVjecssvymkP8OREXRoXaWkoRdL/bULbQnUcd00MTVbRmkcXF2fLZJiz2tF9GJQSOyrjdWi0GLET9tjQXkXQHFNgx6GrZj4SpfNVFXj/CBiiwH0d41u4QVsZ4m4sUvArcjEa5C1p0yPo2dqoIQUrwzYOZt+qtG8JCEFXMdGo6cVQuOJbNfLsB12am9OaOxm0zFHn/D5r7G1vG980AnGzF3ZAG4NgfpAM2WI8DVUTtEmpXPtGJg7Z1ZCFbzU2YgJuWIaolzLO/bekKPhOKdNBV/KMN31hlnlymgHamSIl5kLNL2tNf7/WLg78wHzkBDdPg1b7Uym0MykonnJWeHPfnKP8ltIvcDrqqZ6iVM4KRZqd8Aj1MDWbNxvhbF+tIPDjTizyTXL8EK5NiM3Gm6CkpfFcfsaNCfM66rfGllUieVtumEwQ7OYYQkK5d5zVZ+q7E/iIwAfUNRRzEorCSXqsDY+VpqG0qDp9OOtLPdLk8N/s4o9QCTekMDUtgGeGqhJCVMKEldKvyMlotGYF+uhN54lh8xyn/PMjTn9qRLmduRbBIx/a7F9Z6ccbtTl4P9/909y/KRssWScw8ATRwa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(6916009)(66946007)(66476007)(66556008)(41300700001)(5660300002)(38350700002)(38100700002)(8676002)(4326008)(8936002)(2906002)(4744005)(83380400001)(26005)(478600001)(86362001)(6512007)(52116002)(6506007)(36756003)(6666004)(1076003)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gnux/Y64kCfMXoFKQ+RUo+Ft2Our28Hush2wai+rlwpienygbglt2b2hT2X3?=
 =?us-ascii?Q?OF9m6RR8U16tX+z+6TLIIGuKR7+NTvU+wsywuKxNFaoM9HJ+DjMANmd5iOc1?=
 =?us-ascii?Q?B29JyfzZ3XxIGNdqAGGh7PM5JfMrf6hoD3X+Ssc7St2TVt+EvjMs0r3udqA6?=
 =?us-ascii?Q?W85BGdxSPMqVY2tRdSCLZ4mG8IOVIQAo2EwmfoP9dgdHeo6zFoYcDc83JQsB?=
 =?us-ascii?Q?QH7dTq2ZZLRARLzQCOa0Epu7rEe6B3XWwa0ErOiPB6d5MvPzbOBY4txECAJt?=
 =?us-ascii?Q?t8wibiQV2M+5P1+tn6J+jkdlU+F/n54JfrMcj6ABSxQecOudBrwcbhriKIVS?=
 =?us-ascii?Q?SSrAE7w2nfb4RApxnvwx8OTLFctdVec79em+3kesgqBkWGodgzdZ+c7IAWc0?=
 =?us-ascii?Q?8Z9WyObfaLUIPaBxwPVuw6kV5PYcjw//bjG+s+HmvzJmVt/UgMp9VfZK1eaJ?=
 =?us-ascii?Q?LK4dT5CgSW7HjCunma+svvr8pKojuSGYFQh5KIOFkay9GkCokWK/Jopt7z0D?=
 =?us-ascii?Q?q6e0UM1JzYX2p9MvX9D8IFf/wh+HPaq6bqbmNrVS9T9z3DdmzyUJu2u/rW+D?=
 =?us-ascii?Q?/E8iQWkN2u51g17zDOFSmM4AZ6JAXobV61uo7DqGUOJHwqCn6j1luAszJ9Tm?=
 =?us-ascii?Q?xaljZdgwL+8OUoRgqGG3x8oerkhwEqU7Gb/PBVI+jzvLXOCdMMupsB4i169h?=
 =?us-ascii?Q?xEjEeZy+Wp2e0OlUkTwLsbEZbkVv84ZEqmeW1xN9UrOJy7Qu4uHIheyPMCS/?=
 =?us-ascii?Q?Ept7+C+Yj/ghNY1BMZWPM9tD0UpkmF0URkkYGd5wXG1SMmyX1/aKsDJXqbOR?=
 =?us-ascii?Q?a0KW6z37aIYb1Q1YTTOjSVjLe1xxm7LTEcqsnaO5DUHviyTXk3ruIfA0PvkQ?=
 =?us-ascii?Q?q9UZdAO17n9yAZW1rhHktpNgDwTH8KfJ5t0WrRIDVkI9Sp8LpaCtoFm49P+F?=
 =?us-ascii?Q?P1b36YGDNjXV4Sf7afsZg3FoXoegKqSKSWuwh+WUnXLRcE3cn7NlbN1dPRLX?=
 =?us-ascii?Q?ujzzw88no3PAhR9V54mRLEJLaH+ef1jZ/s+RMgC615n146M/URz04WhhRFTU?=
 =?us-ascii?Q?vfr8+6yW3vPfG2dNE6na76NzFqlBGH+9VMLOlNAW9hnjvSIGRB+t4d6ho+/w?=
 =?us-ascii?Q?9WdhoksokLPRjglNbrt5bqOESpPs+0KoGecND5gOaQUvxhFmGJ2k6KSghQEQ?=
 =?us-ascii?Q?XUiHUism6cxQb7xFEWSXGm43wx3UoUy087BxU+5/P9FY2l2McDJFGZklrDXu?=
 =?us-ascii?Q?332r8D7mgFN2cg3zcHXhnCqIZQphreakcZuYtypRvnBfQ4kMUZLcyBAX4GuD?=
 =?us-ascii?Q?Q7CzVJS28WzQzSwuXpp3VKt+l0H3noRhhK7YD+n7xTx5LA2qFyvszVzwS2qH?=
 =?us-ascii?Q?U3yKQ1QOz1D2qdvxMxLi1e7C2TLDgtAFDu5NEbQisQGMVb++GBV3UVp5u0ZV?=
 =?us-ascii?Q?ERjfBKF3XJSFG2REIUENDYQQ16HGrUZDLPjz1iKBs2wgaUx0jiceSmtYQXBM?=
 =?us-ascii?Q?LcUfNI6z2WgfFQmFM2zx/VradlwskTaUHrFoQy+xY6A5L24a4oG5qRKsnCM0?=
 =?us-ascii?Q?8kgBwgMN3aSgZdQqDM8PRwVS6jdlBioJoy3QlpeT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38aba843-c9ad-4ec9-4082-08db9e782f1b
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 16:45:22.8865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: soc2PNWCUaGBvvena/JVEnMBvj298qctN8UiuPXlkkh+5NQYMqQqkWlJJKk0G4Win/2tf40EEuf2pilIA30Pyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7107
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Remove unused gdbus parameter.
---
 client/player.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/client/player.c b/client/player.c
index 3611a8dfe..38590405d 100644
--- a/client/player.c
+++ b/client/player.c
@@ -2297,9 +2297,6 @@ static void register_endpoint_setup(DBusMessageIter *iter, void *user_data)
 		bt_shell_hexdump(ep->meta->iov_base, ep->meta->iov_len);
 	}
 
-	g_dbus_dict_append_entry(&dict, "Broadcast", DBUS_TYPE_BOOLEAN,
-				&ep->broadcast);
-
 	dbus_message_iter_close_container(iter, &dict);
 }
 
-- 
2.34.1

