Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15796C25B47
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Oct 2023 09:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjJYJTX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Oct 2023 05:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbjJYJTV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Oct 2023 05:19:21 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B09DC
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Oct 2023 02:19:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxBARi1riWbk0RdPGiqvu+Ckd9/gEnMG8MiD5sb/fI3VxZLzMVit1mC6xrddk71Ef5ex+VH3DYhEtGekUlyn004nutKYNMritH5brmUnxzSo2vJ6W6ccWtOYvIn29QIQAIa5AwS2MmQ7M2Xvt7apWL7S0dzHWevBzY8v5l+qN083fqfTO3+sz1UwPWXMHgklvsOb1rh74GckGPGOb1Ym1d+Z2RhW6PVjdQp61PxbWy+bEQ3bfHdkO6BoOnkRvwJ1Jnx3wWudh6gswbxoRr60XjYH/xEVxNGbPRyKol3/jvo+teKFxyUYqdtlo1MaQ/3HqjvzO+tYmsmnaRwFTUC5bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbxda7dWLm+UZ1LKe6olQN3n9L4UFHiMLCix2FcnH7I=;
 b=khzkmuPBulKQdD3uipAhn3X84EZCkkIhIS2aPS2XnZX1aSQJzy/15n4GXJYPb8yyzPL+/JeKimyIay/YFIuKUguFMhB+lzl3lCLeaE3Jq4DbwplpkNHKA941cGG8PJ31I1W0b5Ceyhxt+llsVUTk6xuYYRlSxc71I6YTbot5V9SSgVAa70/42TVdDidxjWhn9HqjEin4U3aKdNCSSx9fWkU6s7SF52qfDt1MzJZs2sbp1zjBvj5xSXG7EA4Olz7ySPTZg8IH4cEZgQyn4yjeHCr+vPIhK0blN15jQcWVW6eKtswrNBONbsT9h5o1N+5Ljh5o9jV12QTLN2LiQIKDBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbxda7dWLm+UZ1LKe6olQN3n9L4UFHiMLCix2FcnH7I=;
 b=HWlSxdgTx8opDf5k5Sly86JKf0QudJ2vjfBD3PmupYfZJiU6Q0wY0d0QFyOrwI7MY+NoxG2/YmY518TqprODbpyD7gKtec4MKZLqFuEzIww8Iw09TOaIDgTOWSmHDT2jdWnEu/Ygh9UMfdyo0o7CTuMizbz0JaER6kpkdL55lZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by DU0PR04MB9369.eurprd04.prod.outlook.com (2603:10a6:10:358::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 09:19:14 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::9854:5951:6f9a:7711]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::9854:5951:6f9a:7711%4]) with mapi id 15.20.6933.011; Wed, 25 Oct 2023
 09:19:14 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v3 2/2] bap: Fix source+sink endpoint registration
Date:   Wed, 25 Oct 2023 12:18:53 +0300
Message-Id: <20231025091853.18647-3-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231025091853.18647-1-claudia.rosu@nxp.com>
References: <20231025091853.18647-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0250.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::17) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|DU0PR04MB9369:EE_
X-MS-Office365-Filtering-Correlation-Id: 7933af0d-b3ea-46d4-d736-08dbd53b74be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ITi4kEBfRfMA2kkwBrNFy/none6mfzs36Ey/ZZfZvZt/RhxlOJ31UMNLVwCn7BEPHQyB4vBcaMTdC5Dj392KffcQ/XUdWyAVTypd7Low5JAgoLMlWGEkJdv5GaTnyvWVLLc4C5+dLQtAFIFbzP1+ZbENtqlJcHrhzzqF+3yeVopiptZErhZSh4LIKPSwEvteJbuTm0yVKQ/5TY0oxEmuwjXFfVGCQifXoUJ9izIjCTaujZLJFOE5mGYgD+rGsPe4cTo4RW+yOQEyqa3j+gU4PG62lYkyoRH10wdWASOXkKEODE4QtxO5GF16w0I2jOq4PuSEZmOVNaSuCf38c4vM4EtbLV8j+Lvp7Bb0SACJzgqqhfsjGEoe4OTN53T0MnnAhwL86dl8C86a8CWAqD9Y1VOJdH/25Qplt8B0pBZP+UPAAEvw7l9i7tqkiPfvLvEdRRJqHWrSqefNq4R6pO3YqMT0QaJyYJy/cjWLI8NgbeT+ES3yaVamFUmYJxapLFnYHeLh96NfxWfR0l0xs92MMb2+LiOK9Tmj/lO0+0MIVDSgLYT70OE81FvYcousn8M
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(346002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(26005)(6512007)(1076003)(2616005)(38100700002)(86362001)(36756003)(83380400001)(66556008)(66946007)(66476007)(316002)(6916009)(4326008)(8676002)(8936002)(41300700001)(5660300002)(2906002)(6506007)(6666004)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vI42RjoXlaD4gTJZteyQ/BcHenpaQIzy5NgDGotUCQckkuDlJDzmDd99LE8C?=
 =?us-ascii?Q?o7KPuUFaqjt1poWU3kP4YjzOOIWixd8iBELkc2+d+XJ2j9beFzhJOK+JERSp?=
 =?us-ascii?Q?vf1YsuiST2+tPwGp3XKjzvxzkRQ5JxNQHtSVCvvRwPEn7nJV7zHv4UeD4sxH?=
 =?us-ascii?Q?rUPqcGqrjEMaaUerqGJj+yxtGvDZC+Z3QShODtrNKKnTH+0b8Abx1bI2ZsWq?=
 =?us-ascii?Q?Q1kEwwjECBjHRYgjxlKEtmIBgxh/VB1yq9A5q/JsxhGqAvx5QKPMGdP8osYG?=
 =?us-ascii?Q?4YizBTgXgwXx3O+/Tn77gBIMVIdf7qtJYc6sgtg+NGmh1+PN6mZtfEucNfUE?=
 =?us-ascii?Q?r5pL1bOvDhqoa7RaPdOoy3YMXX2AxIsOcZuQnkhkppgdYFsmxRWNM2rr65mE?=
 =?us-ascii?Q?SsymxUqDeJL0dRMBMLjslWHIkh0krsZCS3R9LHncikno2hL5B38LAI1uGptw?=
 =?us-ascii?Q?TS6wW8+bN/Hz9rtesg8bD3expXHUZNt8pNIx0cq5qPhnPm2rvE37+RcHohdr?=
 =?us-ascii?Q?x14qzuWSOOjgCXr0oKqosvpFLGBTd/jAq3J4VN/L1TyAAp6pCNQfK5yuJjqV?=
 =?us-ascii?Q?L2Nj57aSZErVFoPJyMnDGZHI9XNLlRqBNMWGLD1ZN5B462cWPW+bKEVwWnHb?=
 =?us-ascii?Q?kWyrNo01l4GAnKzpvdgy5flvukTOwQBKImqttFXjgj11Obo5+YFka0lH8lA7?=
 =?us-ascii?Q?VeszKMKItEKC9FPy6UBNVt6kq8OsWjxGEMnRfFr2fmshgWindHdzcO3FjfqC?=
 =?us-ascii?Q?Rm7zzxtazcO6RgMuLxHErAUIn/8cyD2ATMr5kIZM5LHNWFwAHrtWmkc+IN4m?=
 =?us-ascii?Q?M8fk4Q0a5WZ1kBscbFjdJEqXvjmH5FMavjWWE1BAg5/fYD8kBJSrmf5ec8dS?=
 =?us-ascii?Q?uNAe+en9+dy6qG+nKDnKv2jYFg2PVznGiy++dgzwn0FnANSYRlDvS5B8zs1w?=
 =?us-ascii?Q?ezKZOecxRQZ3nUfXlDTeU+sfItCgJMhVSXGUrlyBZgW3PVUq8atTwDUJw//L?=
 =?us-ascii?Q?NcuLDDnu/uofphJbKR+EMMzAMN58JNkD9asPPRTO35Oclm/IyqrQm7KjmYWo?=
 =?us-ascii?Q?RBfaBcjkXzsKRnXbOrwAIhXEg0BXZA5Dvs8U6ocY2EKslrd3Fm1tuOejZQ1a?=
 =?us-ascii?Q?JQM1OKLgzJh5BUbszFh/4WRBeUM5Fr6aV0FQPhtnTVUse5n2Me69r8zBh5sT?=
 =?us-ascii?Q?sfbMcMlbMT9Vy1pEdwhbRC8mz79WJfLqw+Yv+Qow9Xwb1JTgPYVSZm2J/c36?=
 =?us-ascii?Q?35Tf6XsLyHF6AV6EbNVesXZ1xy2lAbcg6LGd0RrNkpq0ckRb2EQEo6yMzDv7?=
 =?us-ascii?Q?wDWID9ImpjurEYi/UYPMzUgrlif7m9W46oWh9aVW0LohmoZsl6MDRFwsOBbl?=
 =?us-ascii?Q?Os3yXLEkS8rQ6pzSARmjapB5wWWK4CiQPYaNagYnfZqD51dKChJnqaI8fDG5?=
 =?us-ascii?Q?/JqpDXuXS/AFVB63bqZkzOsRkRIs+AQjWiuYbDoZevfucfeLg9A3DHk/1BDg?=
 =?us-ascii?Q?iVHBiK5b9Qjo7pTMeoyqreAAOR79oQcqV9Pwghk9HisSH9QXD6F9F4STG/Vy?=
 =?us-ascii?Q?0jd4ZwwtVHxL7FOaLRTANaw62SNQADPgkXH2hnVw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7933af0d-b3ea-46d4-d736-08dbd53b74be
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 09:19:14.2860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uvqeF8RPf36CgHexADD+xcEhHs9FqLU4eRNp2/84Z91kBu/wwWO1dHrhfZm07ejCX35RIg/i3QlU0+bk9MYIng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9369
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix the case when registering both sink and source endpoints,
the register endpoint method call results in 2 remote endpoints
for each scanned broadcast source.
Remove the need of a remote pac when creating a broadcast stream.

---
 profiles/audio/bap.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index b74498c4c..a84181e1a 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1050,7 +1050,7 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 	const char *suffix;
 	struct match_ep match = { lpac, rpac };
 
-	switch (bt_bap_pac_get_type(rpac)) {
+	switch (bt_bap_pac_get_type(lpac)) {
 	case BT_BAP_BCAST_SOURCE:
 	case BT_BAP_BCAST_SINK:
 		queue = data->bcast;
@@ -1073,13 +1073,13 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 	if (device)
 		ep->data->device = device;
 
-	switch (bt_bap_pac_get_type(rpac)) {
-	case BT_BAP_BCAST_SINK:
+	switch (bt_bap_pac_get_type(lpac)) {
+	case BT_BAP_BCAST_SOURCE:
 		err = asprintf(&ep->path, "%s/pac_%s%d",
 				adapter_get_path(adapter), suffix, i);
 		ep->base = new0(struct iovec, 1);
 		break;
-	case BT_BAP_BCAST_SOURCE:
+	case BT_BAP_BCAST_SINK:
 		err = asprintf(&ep->path, "%s/pac_%s%d",
 				device_get_path(device), suffix, i);
 		ep->base = new0(struct iovec, 1);
@@ -1101,7 +1101,10 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 		ep_free(ep);
 		return NULL;
 	}
-	bt_bap_pac_set_user_data(rpac, ep->path);
+	if (rpac)
+		bt_bap_pac_set_user_data(rpac, ep->path);
+	else
+		bt_bap_pac_set_user_data(lpac, ep->path);
 
 	DBG("ep %p lpac %p rpac %p path %s", ep, ep->lpac, ep->rpac, ep->path);
 
@@ -1792,7 +1795,7 @@ static void bap_listen_io_broadcast(struct bap_data *data, struct bap_ep *ep,
 		error("%s", err->message);
 		g_error_free(err);
 	}
-
+	ep->io = io;
 	ep->data->listen_io = io;
 
 }
@@ -1958,12 +1961,12 @@ static void pac_added_broadcast(struct bt_bap_pac *pac, void *user_data)
 {
 	struct bap_data *data = user_data;
 
-	if (bt_bap_pac_get_type(pac) == BT_BAP_BCAST_SOURCE)
-		bt_bap_foreach_pac(data->bap, BT_BAP_BCAST_SOURCE,
-						pac_found_bcast, data);
-	else if (bt_bap_pac_get_type(pac) == BT_BAP_BCAST_SINK)
-		bt_bap_foreach_pac(data->bap, BT_BAP_BCAST_SINK,
-						pac_found_bcast, data);
+	if (bt_bap_pac_bcast_is_local(data->bap, pac) &&
+		(bt_bap_pac_get_type(pac) == BT_BAP_BCAST_SOURCE))
+		pac_found_bcast(pac, NULL, user_data);
+	else
+		bt_bap_foreach_pac(data->bap, bt_bap_pac_get_type(pac),
+					pac_found_bcast, data);
 }
 
 static bool ep_match_pac(const void *data, const void *match_data)
-- 
2.39.2

