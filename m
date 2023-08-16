Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C2CC04E69
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Aug 2023 15:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344026AbjHPPKW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Aug 2023 11:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344042AbjHPPJ5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Aug 2023 11:09:57 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2078.outbound.protection.outlook.com [40.107.7.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142191BE8
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 08:09:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Le9045jElWDDeaeoTnFZR1wHFWNNLgsf/TML8wh4Yktzvmtl6pBfX4HUMR1DhiDR3wwGVF6htdEqtPiw/CRacusd2daHCrQtsZjzMgBHrUCjqjYbdGSHTZftJ79+Zf7oJ82f0yGwYjG468NUFzkOABn9KBJNTifKcMS3CCCIOuivsLurIIFkRqZYIdikBaw6CwJf64lyy0yvJgAl9hghLkSuKQ5jubHR5gD3Mn0SdkDws9ez22vj12pKcT/mHgAg+5WWyyghpAbCiAUb6Qa+5194w2FwHM7hJhqrVp53ICOi89xvixmMCZI2lW/tGYTZ3OdzTSLuoF9tAi+CrZcQWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZO8Pw7dftjVj1fh7Cws008FoAT/bdgZLUHoJRZDJoSw=;
 b=ob/B3gJIe+oK5HfEE4n8OXK289sY+u00tss2cJe7GkVeh+GEjdPs2w4PNnL1MTQpR9mGLeVechBWttf6xKWXWgeGfq2h/70RfU8ZoDPY+doBRgXLwQFp/zjONtMRmQIfSrvWvpU+fiiYzQiEvyLha/hKQVx5xCLK0u1wjAg1TtG+3pIB7YRGV5Apignwdfc21IHQP2DyoT6+ryVB3n5dXhWC1vHw8aJKbmKbXb3SzHvb6J2w4jeH7PB+mIJrwWFR5Hy7Z+/g5HlmNWJeMvKeb77CugL/G6eaclAaZNBoFC44FHawg1QuFYedrjLRWizXuuCvn061ARXVHi1mClGAgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZO8Pw7dftjVj1fh7Cws008FoAT/bdgZLUHoJRZDJoSw=;
 b=fB287GXkpQ8dHvKuSFA/oiFsGJjQIos/XnynVm//gfiguurZuVRGqVPhukVQdTIOYMPSLdEecqMqoOfZffn/8mWjGbdbaS7SCi5sGZoZVWVTchk1x9nsNE4VsV4XriQEZkC2PRk9jELp1GQg3Am4zOdyuog8b6n7AnUN6jUMvh0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB9189.eurprd04.prod.outlook.com (2603:10a6:20b:44c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 15:09:41 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 15:09:41 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/1] iso-tester: Add test for bcast receiver defer setup
Date:   Wed, 16 Aug 2023 18:09:17 +0300
Message-Id: <20230816150917.7896-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816150917.7896-1-iulia.tanasescu@nxp.com>
References: <20230816150917.7896-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P195CA0009.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::14) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB9189:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cad8d9a-d828-4298-e2f2-08db9e6ad117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 41wQcuSTljqqu9cn2gV00WrWWxPGsX56FRen29Yk2Nqp1HCJl+I2UEyPyxEDfNm0Uj0HGF+Gvd2Hp9SNAdgumwRH04+D5Tm7cC+SBnKrMlFKw/z3g9fKpk7QONB1FLgqN/xfdoOCBYD3zKZTElocJmd/5G1lNMa2HxpbmWYQ+LoD/cj37tY/6ZnpqmpYHO5uZGqlNmPY4N4Mz2DpQdaVLeklL1DNx+PKGrxM3rE/leOkky1DMzLzON5xeOH+kpZYuesinXotBgvqJrd78q0051HzN6/MJyse0j17BUpwYnzC7ytT6bC41a7r2IKxq1EkGrMEfMAEV7P8epVWbKunVJbV7EHmoEjRlYgEi/luP+stEYXYLtAxv7ydViRIaumz5jPjx1mxno5OjoVwmaDCMVCUV3lp0Jpn+G6K7xwj0ApJ6bZBZDUzVMsxQjyuTqIb+wXQHZstp4ztUFPTCGXdMTVRibtX6bi6elZOKer+qpOiT3IIXP1lRnlDXNulNUIPDJtmQ6yeMN2iODzhKtn3NceadvDFIuZqDUdrnYOFm6Dh+ZvytWjlUQTtZNOsmRnUGDyr6m98BA40Dj85TT4xYKAI6NblMfJVJjM9zyAJ//kIu8dTxj+iL6EYtYoJwL7t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(6916009)(66946007)(66476007)(66556008)(41300700001)(5660300002)(44832011)(38350700002)(38100700002)(8676002)(4326008)(8936002)(2906002)(83380400001)(26005)(478600001)(86362001)(6512007)(52116002)(55236004)(6506007)(36756003)(6666004)(1076003)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xGA22TZYrJ4xXgR8juOfwN8UQmuDF0sNJCOfZJC0cbD67akGxzeJATMDBSAa?=
 =?us-ascii?Q?vWr+y1qNDfCclZ+jtcEMr5KrDQ6jBp5UfK8TlC5Fty8+VtqO+51QbRgwp1YW?=
 =?us-ascii?Q?el2HZ15XGlHJ/hWl5PrdbcSLNZh4FWA7Rf4WRQsKhpU3LCy0P9vNgZ0janKT?=
 =?us-ascii?Q?3Ign1YntbrADFS8H5NRJXxFZ93Goyg4KgO9ERR0QYUGvgo06+EVPt2wLEZfS?=
 =?us-ascii?Q?qkQR84rg1/QOcLjHvkWLHdXYqwn1lbI2RcZz2+W5t0AOttfyEUKFkz2FOC14?=
 =?us-ascii?Q?HlW2Bw2EL8gSRb/aFWkwAkdUT+Qg6cTFhfphBk4BmtqhKZ3JPpXn81+NnZBG?=
 =?us-ascii?Q?9hLPyMeWplU3D9bTBpg3iew/0Av76IiiwiX1KfU69asFnSubTwS30E/Ch58k?=
 =?us-ascii?Q?fThasNsttVwDkb40bez62yaUqe76jc7dPZlxHOj6rLSc5VQEdqByBg7Gj1hF?=
 =?us-ascii?Q?cUXncmjSByU4e9hB9yvXqzxsf8F2Jsh/kOs7nlrHy6yxKJKCD0XPsFJ0kAon?=
 =?us-ascii?Q?ZuO9OxzeEeZEjC1StB5DsSmIHnsi0+DAvd2BGrssTRx5W+mhxZrLoSqKtvyC?=
 =?us-ascii?Q?nY9cyHXXKD4kb7U32CYdtNY1SYEyUaolAYvpbCkaUrqQAMsaYNPIgyDZ/tS5?=
 =?us-ascii?Q?GISZPyZvUEdXTUkFY3qh3wK83GZB9QK0sipaZmnO+PKVvDYkLv4DdaQYMYWy?=
 =?us-ascii?Q?jeAjaHLYAbc/HXKR3pOgDDybPzT50lQeh6KSzmFaelXy1Zxr6efTblNTcdHL?=
 =?us-ascii?Q?Xk3gwfpyq53DbeOWZXszkG8BSP2bxhoYHWe0m1XnN3HfFf9aBjlIqtck6cxy?=
 =?us-ascii?Q?nwjA9rG1fJ1Sw3JEY92gWM5CPMtxlVLACkhBB2RrGpZXVK+BY9UqtVerjjXM?=
 =?us-ascii?Q?xW4pjKhnMWAPs3YlJF8MTxQ0YHh9EIb/UyeybthluBuPtafWOeKoykkm1AA/?=
 =?us-ascii?Q?1x9bddagqKXAwEe6MHeOL0X6IgFUxt56P17si30u8Qky6V1Cx/rjrejbLvec?=
 =?us-ascii?Q?fT7KuMErDr7dqIlc7PeiaX4VMKmg3QDhaRp91LkuB6CZVANkHsyZwXCA+tj6?=
 =?us-ascii?Q?EWMmG31S7m1qrsjy0hhVjhHTVNBjcHXf05PGgKtnp1R7QILYmzLaDntMkgyA?=
 =?us-ascii?Q?82B1E65SOydtzQEu354ZjWATcKPwuTTpOivRkWu8DjthF3A/ysmgYjw++IiR?=
 =?us-ascii?Q?s+cjNm8mUwzYE2Hr5L1JGWykpeYgkGcxZ2Y8I95X6zPBO2LQd/yKAEM0mm3q?=
 =?us-ascii?Q?67mu565HyoPx/f6HP98WvqbWna94xD3fybjmLu2mFGMp1l8JiEziwM6HIuzb?=
 =?us-ascii?Q?OySlZco7zGpBtXD89n5dyMxuUp0WPRH3QByCA7hC26BrmSx0vvjZWeL5NIFd?=
 =?us-ascii?Q?rRW7mK07tJNoaRp/dUT5E8MzzkPIqqyGGW/ElQPIil0ZZSE3XRvGQCRndvJb?=
 =?us-ascii?Q?ThzoHzf1Zg7CSsYEzvjiHE+6vLLUNm0nw6zcfWqq8S9fI6yYrp55ZtXi2CRe?=
 =?us-ascii?Q?qbqmEr0jYnRnUTZfw0XN9BmbcYPUiiuZDe6+ghGp5RZxyji/Q9XrH11aGKSP?=
 =?us-ascii?Q?0E7qzqTy65B4wbwxdB98LbVHAZJu/yI0hER5Bu2eqDHhI1y9Ds+YW+fcciu1?=
 =?us-ascii?Q?Xg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cad8d9a-d828-4298-e2f2-08db9e6ad117
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 15:09:41.5759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dcCkPWBBnqR3RhjRcZk+Rtf3m8VIBu6ZDDtGJXWIda0sMy2FEyoEUd7356ioETogOo4BQresjf8R8yQzKwuw2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9189
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds the following test to validate defer setup support for the
Broadcast Receiver scenario:

ISO Broadcaster Receiver Defer - Success

---
 tools/iso-tester.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index b1a2afba0..d5d2284ab 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -1134,6 +1134,15 @@ static const struct iso_client_data bcast_enc_16_2_1_recv = {
 	.server = true,
 };
 
+static const struct iso_client_data bcast_16_2_1_recv_defer = {
+	.qos = QOS_IN_16_2_1,
+	.expect_err = 0,
+	.defer = true,
+	.recv = &send_16_2_1,
+	.bcast = true,
+	.server = true,
+};
+
 static const struct iso_client_data bcast_ac_12 = {
 	.qos = BCAST_AC_12,
 	.expect_err = 0,
@@ -2341,11 +2350,15 @@ static void setup_listen(struct test_data *data, uint8_t num, GIOFunc func)
 	}
 }
 
+static gboolean iso_accept_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data);
+
 static bool iso_defer_accept(struct test_data *data, GIOChannel *io)
 {
 	int sk;
 	char c;
 	struct pollfd pfd;
+	const struct iso_client_data *isodata = data->test_data;
 
 	sk = g_io_channel_unix_get_fd(io);
 
@@ -2368,7 +2381,13 @@ static bool iso_defer_accept(struct test_data *data, GIOChannel *io)
 	tester_print("Accept deferred setup");
 
 	data->io = io;
-	data->io_id[0] = g_io_add_watch(io, G_IO_OUT, iso_connect_cb, NULL);
+
+	if (isodata->bcast) {
+		data->io_id[0] = g_io_add_watch(io, G_IO_IN, iso_accept_cb, NULL);
+		data->step++;
+	} else {
+		data->io_id[0] = g_io_add_watch(io, G_IO_OUT, iso_connect_cb, NULL);
+	}
 
 	return true;
 }
@@ -2400,6 +2419,11 @@ static gboolean iso_accept_cb(GIOChannel *io, GIOCondition cond,
 			return false;
 		}
 
+		if (isodata->bcast && data->step > 1) {
+			data->step--;
+			goto connect;
+		}
+
 		if (!iso_defer_accept(data, io)) {
 			tester_warn("Unable to accept deferred setup");
 			tester_test_failed();
@@ -2419,6 +2443,7 @@ static gboolean iso_accept_cb(GIOChannel *io, GIOCondition cond,
 		}
 	}
 
+connect:
 	return iso_connect(io, cond, user_data);
 }
 
@@ -2963,6 +2988,9 @@ int main(int argc, char *argv[])
 							&bcast_enc_16_2_1_recv,
 							setup_powered,
 							test_bcast_recv);
+	test_iso("ISO Broadcaster Receiver Defer - Success", &bcast_16_2_1_recv_defer,
+							setup_powered,
+							test_bcast_recv);
 
 	test_iso("ISO Broadcaster AC 12 - Success", &bcast_ac_12, setup_powered,
 							test_bcast);
-- 
2.34.1

