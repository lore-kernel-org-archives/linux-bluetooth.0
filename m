Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF6ECA0EC1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Sep 2023 21:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239438AbjIKVRV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235632AbjIKJJr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Sep 2023 05:09:47 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2082.outbound.protection.outlook.com [40.107.8.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AA5CCC
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Sep 2023 02:09:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcfjUzROYZMEA7wXhpFIvPsjcpr5PZeSSwrblFuk/WfXLf4DMxKuc76RIX7XqX12P0CulcLUUHRJjZbW/w+m+CwQ2j9uNxYoDKjJgpyokvOy1zOfmIIJOxmjlhjUQu3h+vLJjmjjsRgZXgsc3tuG5Y3Vw7sIakDVLl6tob8zyZjC1ZC8WNyv6mjMwC1dd0dHMuT1CJPdQNXn/2kpCD3HCUK82wQboePOombLMrmTxo4xLJ5GsmppDbd2FVqrg5c7O+SHeR/P11xqJOJGfNPZgrjXZH+N5H8k8hfMR23/dGvsTDihYav8yZdBcswEvZmn55NRnuW+Hc2mj2z7jwl+9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmsJ8UXpBn9i4xaReJo8erWNR2XGN0HZrTxYW67PYV0=;
 b=Qp49JpucS4LSwfdo27RiKYRjeyrpUbSdZK2Zbw2rMs+Aok8ZO+juQ65DbZJOOPHHcx9oXm1vBZVEP+Yo5lEiJqV8czK94J0NNz8WWGbmcMZHszV9gjPZwrX33qaZhUpHx4uJSm+hi2RQw+lQGS+mk1yyPDYV8g/Tm6wEUumZoEpwQVRQNqc18D4b49KgQ1KO6AVI/bqculhuV61NxqvplCU8dhQipWJyXahSLT8CNaiN8i2mKU4bjTvgNiusThFmtjZARUsD9NKZzwHIiqQ7vs8gkNtd7LTzTjH49yjKRRNLbY2iyIxEXpofWXLuUsFQRXtWTsTdxonHXNsDNBTOQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmsJ8UXpBn9i4xaReJo8erWNR2XGN0HZrTxYW67PYV0=;
 b=EE6eHja07/mYdlA02Qu2vhvPCdkHDhb5wrHepMfoD8TDE7iOhWhEyyJtLhCAAnoiSh9Ea0ADGYsu6bD1823RmqlQlKNXvzD0R5wMoj+HOYCkXsX0UgAA7Qbmtifdn2AKPnl3XcYb3dgKwJH/3LK4YDv80jgbuBeX0SYDYNbxSak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com (2603:10a6:102:2b4::19)
 by DBAPR04MB7366.eurprd04.prod.outlook.com (2603:10a6:10:1a0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 09:09:39 +0000
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636]) by PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636%4]) with mapi id 15.20.6745.034; Mon, 11 Sep 2023
 09:09:39 +0000
From:   Vlad Pruteanu <vlad.pruteanu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, iulia.tanasescu@nxp.com,
        andrei.istodorescu@nxp.com, Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v3 1/1] bap: Use defer setup when syncing to a BIS source
Date:   Mon, 11 Sep 2023 12:09:22 +0300
Message-Id: <20230911090922.68822-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911090922.68822-1-vlad.pruteanu@nxp.com>
References: <20230911090922.68822-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0003.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::16) To PAXPR04MB9398.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9398:EE_|DBAPR04MB7366:EE_
X-MS-Office365-Filtering-Correlation-Id: cce3a47e-58bc-4730-dca6-08dbb2a6d3f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n8KnNdaC6jdJRQNslGdHc89YGtCqFyK6VbXcbG/7/LlYqYhM8keTGdEpdL1Aiwe2/fbHtxDWNOnepqUOdn4wPjRFqF9pZf6LX25z0piXZLxKGAY7eh1Ba+j+Jpa/VRi+WixRHfIyF+YgeQ09uJtlGECEgaTNCfuId3SGTDEfyav0IQq66kvdbIcZC/Q8YrEPs9K84SjyPeRYrKof4Nb3FZyN2Eild7Z8awN4TUbXpesingRFD4lajK8UY8Yc28gYmkHBt8Z4ecuMR7yN8NUGES/LXk2kozHFZnsmtD5IS9974/eUyOlaTp7eJMdMfKexNN8p80cEZP0Rrk2GziaU08ONEabMVZnzuIi6baB5jCb2v1u/HrUKhNXi58yOmrSqCpTXxcwEfo61tlgsAZLXs9+J/RA04oyAs1uTEBj2lCrNj+9lmFMbgMzJmAPKAx0IFSBhjN2EP1sX8Svior0jsNFT2WIzqOgexDfT67mD0e9nOnB7OSjoHnzEn8wKxC3KWRPs5sbuq55A1ofVsXQQxiL5lCWBUifsND17nAi6dlQomMmxd0jrWDyj3SNvIBLVHmuDSyf+QtqqOz8KxZPxg41u0r0qHZnGiiXR939sZPfQ/sW6tZbjm4m0PW5S+qsj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9398.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(366004)(346002)(39860400002)(451199024)(186009)(1800799009)(6486002)(52116002)(6506007)(6666004)(41300700001)(36756003)(86362001)(38350700002)(38100700002)(1076003)(2616005)(2906002)(6512007)(83380400001)(478600001)(316002)(8936002)(8676002)(4326008)(5660300002)(26005)(44832011)(6916009)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t/xCJ2/LNAVnjto55GE1njsSGUIeg9lDfKSYL9QGick3mWR+u5fCZujNk21e?=
 =?us-ascii?Q?lQkzGFQPNNIJC9K8Qd6pCx6FMarNXKm1c951th188B/HNTkZ73piyMBr+gde?=
 =?us-ascii?Q?wCgLrh3qqUdB3sSlYcoebpdbjuWMfvBv31T9VIGjrd09Hptdrr6mDn/4683N?=
 =?us-ascii?Q?6Lw+3fOOD8RrQWtkDBjfTMVh5F7xwD1iupRoQdwsjliBOEyxKI0SlENJjp5R?=
 =?us-ascii?Q?76iRSO+bUelRiibiEWG654q1UW2/oIMeuPRIABhahznkMSWzdaQxBJktHcMT?=
 =?us-ascii?Q?c6bHrd2+KP/GnlHFawXAGEsxB8LRF44JaGHb8DKjZBS+sQ7CLUrKIx25V2Mp?=
 =?us-ascii?Q?f6cFKEYvLa8nShc7QywK13DWWwxI1ujYa2jHTRzp6OthIu2asNvqYTHX8aXM?=
 =?us-ascii?Q?t3DxUFJ2jUc5L9JIDC7wus+SjoNUTpA+0iD8umnm/MC8Z0zYMsneXQ+0rm2j?=
 =?us-ascii?Q?1Fm9bF2iGhZ/svsMnpbcBDbfeEnjS53vbUIISd9Ek4eA5SEFKl+a0BUdCblW?=
 =?us-ascii?Q?iIU717kRiBgBJrJHacdh92pbAYTn2phdUDsuHgTzgjMLaUZ1CHmKxx1d4bcL?=
 =?us-ascii?Q?Ud1le8+UTyONjpaFy4XFOW0wetysNPrzRvmnlJ9Z/Dm2rFd6YWa6+qIrACtR?=
 =?us-ascii?Q?pY7Wvn2iqOAWORgX8tDMXtWnA4iOOpDeWH0ZMqpNvVujl5rPy76VHab+gyV8?=
 =?us-ascii?Q?mUQnnn9V4kJR6A5VSgCWsaXX/JdQQA5gRih2w04EYmDsNcleLxr+pUdJeC1P?=
 =?us-ascii?Q?eYPCiwxYb10zREZsgDON9iS0B11qkE8mu/YxXgJRj2z0Qck7yGER99AkfR0e?=
 =?us-ascii?Q?QQmozMaDy7gIFo26mSxL/v98Rlnl5msIHuHEagRnaX8piJ5si9b3aAmZBzlk?=
 =?us-ascii?Q?5pFcS82Tdt9aQfU74hg2571fUXvcWTjY7effYhwJ/7Pq98gcRMFrVUQ9lHb8?=
 =?us-ascii?Q?7wn8GNrFmtP0SAhmE0OdaHfGguthV7UOJLAogMUVm9PHvBF1kfEye9XhMhTp?=
 =?us-ascii?Q?TuxmobNVP62uit6iRbayYxEAd8xCu/R1HtUIUm1GOmPA3yUiKTLOStx6vVkv?=
 =?us-ascii?Q?pXyjYDw6Bqr0YbRuTCTtz88SZYQC6OqLQdRyR7u2BdzL47mFkaubVw5k16lU?=
 =?us-ascii?Q?yTaFLTyqTrrppDtwVX1LNmzKF43LHSnQ0oycGfS0HvluYEbeldpNrDYoAsQq?=
 =?us-ascii?Q?F1CpyVqCeusewskEBg/leMDIdyVUG1PK7MY2nGHcV8kSk7gUt8CsClbI6vIe?=
 =?us-ascii?Q?TeiN8rHcqV7zHj8/xDMRwy7Exb8pDGlWh6W+i8RBa64b+00yLiu7QTVqdTxv?=
 =?us-ascii?Q?HkWFKdbSzcgoWS+TUm0Z3SgDPjSvC++MkwMda35+Ick3k1Qt/JpFdz1kR1+C?=
 =?us-ascii?Q?mSeHTBIKP5zFF+IdxXa0nL4t70p8+sx35i5o+KaN5mm3htioz6glqBnG5XBE?=
 =?us-ascii?Q?112KdiiSrXervvvxUabMtCHmpf+Hll4j/oBdWI5nzLmJq/BSb6er3QCQ3+yy?=
 =?us-ascii?Q?Jfv8RTTgROzwAMOb/jfGaWKIGxJXQt73vMbXclEHrmKc8vfhNkeFA9rRiSJv?=
 =?us-ascii?Q?8wEF5g61BSSiHoU46f8XLDqfxeJwQLSEG6zFW6TCFun0cleP3SngpJBEHwOy?=
 =?us-ascii?Q?2w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce3a47e-58bc-4730-dca6-08dbb2a6d3f4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9398.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 09:09:39.4869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YcVMCkpeONF//DOGshHk1yy2QW7C8kdQLAyVXWo/hApom8G9s4nv0OWN3d7eX1fJSCk0a0P2ld/D29iSB203mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7366
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This commit uses the newly added bt_io_bcast_accept function from
btio.c to implement the defer setup for the BIS sync process.
Now, information from the BIG Info advertising report can be
used when sending the BIG Create Sync command.
---
 profiles/audio/bap.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index ee90426b9..d70ad872e 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -840,6 +840,19 @@ drop:
 
 }
 
+static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
+{
+	GError *err = NULL;
+
+	if (!bt_io_bcast_accept(io, iso_bcast_confirm_cb,
+				user_data, NULL, &err)) {
+		error("bt_io_bcast_accept: %s", err->message);
+		g_error_free(err);
+		g_io_channel_shutdown(io, TRUE, NULL);
+	}
+
+}
+
 static bool match_data_bap_data(const void *data, const void *match_data)
 {
 	const struct bap_data *bdata = data;
@@ -1587,7 +1600,7 @@ static void bap_listen_io_broadcast(struct bap_data *data, struct bap_ep *ep,
 	if (bt_bap_stream_get_io(stream) || data->listen_io)
 		return;
 
-	io = bt_io_listen(iso_bcast_confirm_cb, NULL, ep->data, NULL, &err,
+	io = bt_io_listen(NULL, iso_pa_sync_confirm_cb, ep->data, NULL, &err,
 			BT_IO_OPT_SOURCE_BDADDR,
 			btd_adapter_get_address(ep->data->adapter),
 			BT_IO_OPT_DEST_BDADDR,
-- 
2.34.1

