Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712A2EE57FA
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Sep 2023 11:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242806AbjIHLMe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Sep 2023 07:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242334AbjIHLMd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Sep 2023 07:12:33 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586201BC6
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Sep 2023 04:12:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jb2Q8cYr0ViWoyY02fGV9OyER8VXJBgX/0b7ENLkc5IkSCmEumYhQSeqm/j6Tf2OhlbcuIlGrx05X3SmGvQOBiGCMWGiTfyyStvuHCjrNpvKZQ+87KbJSWGGAwfUDWkukVSm/snMzbsywEJBw6Ea7JYM7XvG+4e5ApGN7zLDfD5ycodG422+RZBt5skChYPjaMU1LpaW5ve5fZGcBM7UZHoES1hVTPhs8hCyli95iSClMrmmM1isVfqjXl+5x1WX3P8NWIOBbefx4t7/pj5wm6JEtA1ojv8Q4bzRJW/6F7N5Q7C/XO170LlsZrBkcNaLDUyIqQzbFot/x5rRjr3bVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqflcGyqEHG6/8/pqiVPhgA1d1m0gUB1eJ9YSw9/Qko=;
 b=mXOXCE8rU2KKjtIHRWy22I6znR2JbTQj8Ev7iw2nJ9f1MHaxsrmxd2P4tsRnbE7vIfRCVnBwl+N6udyOgg7df5VTX5Y4KXGw4eaVRL07Pe/IEyGp6Mggx7x4U4CwMR7f8N2P3vh1UaWJO4+v0LXKpA5f/tkMcI3yWB7WJbRFgUKDFUHD2QxeCfJveKuiFer4GaqAfO4l12hmkLEfRw5Durg/Hq1n6qH8QpAgbvgNxJ98YYmxXfaLCLbt/8tmEYz487j0WwhETsQmO5y7JV3vkI4olgvNkR4dXEspSDut3RFXbYlA2QBmFXjyij1V7ZtSG4hVmQ774OMdJdqrOL1vZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqflcGyqEHG6/8/pqiVPhgA1d1m0gUB1eJ9YSw9/Qko=;
 b=AITml3nMUt2pu6VkuUIAyWsJ21ArU72Pul2aYls3J5kUVS4vzTL2xQ5vl0GsR9INvOPFNcNojVY9euaFHX+1aSjbMBe2jmLxoviFMT7BIbgcjosv34VJnDc0hccqnXnJjSVoEOFbvrvhMGSLpBG0QQVcDEo6nvEVZY/+d+zpq7A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com (2603:10a6:102:2b4::19)
 by AS8PR04MB9208.eurprd04.prod.outlook.com (2603:10a6:20b:44f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Fri, 8 Sep
 2023 11:12:27 +0000
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636]) by PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636%4]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 11:12:27 +0000
From:   Vlad Pruteanu <vlad.pruteanu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, iulia.tanasescu@nxp.com,
        andrei.istodorescu@nxp.com, Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 1/1] bap: Use defer setup when syncing to a BIS source
Date:   Fri,  8 Sep 2023 14:12:08 +0300
Message-Id: <20230908111208.121996-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908111208.121996-1-vlad.pruteanu@nxp.com>
References: <20230908111208.121996-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0007.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::18) To PAXPR04MB9398.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9398:EE_|AS8PR04MB9208:EE_
X-MS-Office365-Filtering-Correlation-Id: 55782ca5-46b6-4614-9630-08dbb05c7c88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M3FzBBZKlTH3rfF6b0/+XswLOvNO1DZkq9lAMOQWqwjoaa7HvwPIrcV3HgdJ958JoVHNVKzAiwmYBD3tQ1gcj6P3dnq4sLVCYyz4Am5HSNPBO6hJgSoHxIqgsZubZoB8r7wBqwrhfKPKjyip990dzLAY/szl0fOV7hxuH+IcsGrmRUL8t+/5k7oBxowH2f/lHRGlp8E7ilX54vXPhKAP4rMthiE4l1fbxxPiZhYHRSUT+c9lcEzplnPh+nhWL56EQU5bFjr9PCRy9AdeUqyUMczzk7UC5K0gMC08kE7sjbcvZlDntnVJ9ahBfD+pwKlPFIj+m4SPjjpfza7MtE13yGlambYBecwTSYPaV7VGCNG6Ra97DmqleJQVInIJmZTK5thkHJ7p4Xn1ACd2vVn7aZs5j3kN2ZR/PW6C/WPIpB8DmYUv9upry5n3K4cDroeE+sShhx53RaTpAeNBqTbZnPytUY0JJJPjb8QU5cstwNR9GFnQz3a63pAc+yDosLlIRPW87rjJCI4JTUJUX3xM6rEkBKjnrY7cHh6+BvcqVcSxEuSgItMMvoxDqhFV7ART3E8lQCUTVst/WX+UHvkJO9U0hDI70bZKypMLM9yex+06IN70s5d7/Nhwql5pCbnL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9398.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(346002)(396003)(39860400002)(1800799009)(186009)(451199024)(1076003)(2906002)(83380400001)(6506007)(52116002)(316002)(6486002)(66476007)(6916009)(66556008)(5660300002)(66946007)(478600001)(6666004)(26005)(8936002)(44832011)(6512007)(8676002)(2616005)(41300700001)(4326008)(36756003)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KaLTSHSolByTzm0oLAKHzvXELpOg7sp+fEv+rCWpEPcGqqbXVBf/D8XlX6X4?=
 =?us-ascii?Q?BANzvgPXc2EnANau+3PkXIFP2cxfJFsvcxhuS1rN3YRvp4n8VvnVD3A9Y5aV?=
 =?us-ascii?Q?v7Mhwz/+eBkp7hxi/DRRxriXpVzZnVaVSheUelPZ6gw7XmIYCbg6HPbf3km9?=
 =?us-ascii?Q?bZWyaBpMEEJhX0sWyzfz6CmmGm3DFCSh/Yd6zjiUqJItFWIggTClfSdSqRjp?=
 =?us-ascii?Q?ZQmJLS5+37vdKgYHt7lCCiz4Ae09i0bjL6YAfDWP91zW8aqFKasWodq2A0s0?=
 =?us-ascii?Q?dsI31GBHCeyaxLM497qtKzXN+HwB8YNO5CFFSgaxKxAKIrsQHhwrtxFxQf0S?=
 =?us-ascii?Q?tqCAlXjB/APtSPbHRg8pLJyUMNT+K7CeccsrXHlP8qEDUaCtXiaGmW7amhGI?=
 =?us-ascii?Q?bQ5ZRNXX5sWjtBaJHtyDMNkHEkHD2l6af/wNxa4ROELYB+Yh1J7Sg5gQYFvV?=
 =?us-ascii?Q?O4yROJs9e7YZyJX4grdbcYB8FcaniOpyCowKmQHNAI4hsCPjA19KZ48hqj/j?=
 =?us-ascii?Q?1zmg0HrmUrRnV5S0fKhYAE4pN8QGfy37t4yJTuOXygPJzRhBP0kSz+/IIP+G?=
 =?us-ascii?Q?xxNOdm3/L+cenSkFHTaCoUPcUpn+7bLvs6OkLYk2BcufFgKv4oCQqstoHELo?=
 =?us-ascii?Q?58ELs6wzrBHFoodTCoAd/J4QlD+wGLbklx5CW0ambSDXuHocSvSNYKu4eah0?=
 =?us-ascii?Q?HMh9PqitLapwEoqjsYI3ozaB3DhN5OaJSpSjTG1KSSOtu+RjNNnTGMNLLagL?=
 =?us-ascii?Q?a9tOKiKE0n8gqbCMjPO5AYLRZM67RR7COrjofneyTs7yU48auhsY7iRtzJ2w?=
 =?us-ascii?Q?flCn2HYWqmeWqlYKUCglKXZ3cmg0S5nqBsdKP0yOr3USXLsaYwCStmEX+0U/?=
 =?us-ascii?Q?TFW/gT/X1+tHTKyQL+xii4O0jKJtD7eEcfqpzfHGH+RzHdMbneGlhzm5DxBY?=
 =?us-ascii?Q?7BU7S0pdtd2ixsM8QWk9EI4wADRlL+QpjKVyU2igZH7gWdzIjhDcl+YKe/f5?=
 =?us-ascii?Q?COXo0zb7I5MVWmYei0BaB0sEtCOzhEEhuhP/qKRrbWiroQshROF8M46JmZJY?=
 =?us-ascii?Q?PHhyotclluPWulnx3pnFHURnQ2j/u32y3n3fho/0iB8dZ84FWKv3lw7Hi4Oj?=
 =?us-ascii?Q?7LKQWfqrx5Bj6PeF39G6Om2axIeQxspka6DPiRVsQtVSAKGe1yicGBzsuOSd?=
 =?us-ascii?Q?LamI6TnTHsMhdU0KTgCOil8d3hEXHxDY7I7ymYxS4PC8Y2qZStYar9VaMI2j?=
 =?us-ascii?Q?UMA6bEoeoCrvOA2LKWeSTi/pR4hlzdESVvxL0DXrv0zyy7WF2fN5e4OvhY/w?=
 =?us-ascii?Q?/KCg+7BjTYCMmZkMYylWwF3BwRQNpiCvrdutb9n+cb6Y/a6lBn5e9z1LrlVM?=
 =?us-ascii?Q?9FhWDtscZ71fiUAEUfR9QQQypslPiGGpFTztLv5gbOkvIMav1Xhac2Ozj2AS?=
 =?us-ascii?Q?xUzwJNTQXLPHB3p7ZJmlkrbivWhxWU2loLkhU0+f71GXOsktXUODfhnltLdg?=
 =?us-ascii?Q?AxBbc4QrrfAh1ZWidLA/ze0NvNg/8uGFWuuEh8qZTPfkzvP2/eAEiSNsiFPz?=
 =?us-ascii?Q?LocjZdKLYyrE7FpATYQfUJ/i6Swe4n4gSUFEP+uHYXbdXFkGyycGS/Kqeo55?=
 =?us-ascii?Q?HQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55782ca5-46b6-4614-9630-08dbb05c7c88
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9398.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 11:12:27.6909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1j4z99cb03EkI+M7mKU0dA0etspntGiXf6FnGETGOuTS7sB4VDrPuBD03hjQdfDjMhHamimkLSQAVM071xWsKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9208
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This commit uses the newly added bt_io_bcast_accept function from
btio.c to implement the defer setup for the BIS sync process.
Now, information from the BIG Info advertising report can be
used when sending the BIG Create Sync command.
---
 profiles/audio/bap.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index ee90426b9..981296422 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -840,6 +840,21 @@ drop:
 
 }
 
+static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
+{
+	GError *err = NULL;
+
+	if (!bt_io_bcast_accept(io, iso_bcast_confirm_cb, user_data, NULL, &err)) {
+		error("bt_io_bcast_accept: %s", err->message);
+		g_error_free(err);
+		goto drop;
+	}
+	return;
+
+drop:
+	g_io_channel_shutdown(io, TRUE, NULL);
+}
+
 static bool match_data_bap_data(const void *data, const void *match_data)
 {
 	const struct bap_data *bdata = data;
@@ -1587,7 +1602,7 @@ static void bap_listen_io_broadcast(struct bap_data *data, struct bap_ep *ep,
 	if (bt_bap_stream_get_io(stream) || data->listen_io)
 		return;
 
-	io = bt_io_listen(iso_bcast_confirm_cb, NULL, ep->data, NULL, &err,
+	io = bt_io_listen(NULL, iso_pa_sync_confirm_cb, ep->data, NULL, &err,
 			BT_IO_OPT_SOURCE_BDADDR,
 			btd_adapter_get_address(ep->data->adapter),
 			BT_IO_OPT_DEST_BDADDR,
-- 
2.34.1

