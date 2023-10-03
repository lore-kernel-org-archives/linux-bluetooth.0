Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8604E7AD6B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Oct 2023 14:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjJCO6J (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Oct 2023 10:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjJCO6I (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Oct 2023 10:58:08 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2047.outbound.protection.outlook.com [40.107.247.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297DDA1
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Oct 2023 07:58:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPFlHvsDe56aC7eqPS6S/fq8AIV1LzL240grs2Vz7N4qqtpy9rdQeal8Hc72Z7G1mUu/Xw1EL2GxqzfINEQmjK5LXkJc5PPKqZFAM5NxcsWGpi3BFTjeV6dbV41+MfT9iw2yQmv3VjiZyFnzXcIcJjX4Qb3vRNkgczM5+7TsrkhpJPzpN91YNXPSrInPtQWtMsQVkv6MtcO4CezFbtxUDoLuGCXvJHMGVdzx6nCQmrzQEJMCfKd2qIiYERTt+ks/h73vH1Kknjf+juDWhfv+B2cQjCcJ2XKj9hf8wQqYLNP1Qc88VMvtDQjg9cTmz6DWu7Hde4CSKqd7n2Ave7ESmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKYf26JiSxy6Jy5mplrNxdemiKwkr6mb96uYAT2xFb0=;
 b=huTKYiB4iZipSQMoP83LehbDTow1xbe1YA0mD3ADnGBRhkUHSQQnZqDJzq0LJ75mqP+ADDbV2qfJbqQwGhIVN8NNM6XfWUEpmbAj5uXFpJPF3XmXpje07YX67mQRvfiY3G8nuDDdlWEvnIs/zH14Vf+SXEslNdOxhXWdCNsK6YzHJIwhrbd944LEvKndOKskOvuoSxMvouFEM87NrQMy+ktFJr3nPLA5X/eMppn3X0wObcJfPvWGGqD4Wt7tA89sp+KnVzAHl/6A0YUi2ORpWX1Xd91TbCuLZLqhZAL0YLUkZHGXG6uREIIMQlrLHMAorDDUb0zF/NoSDQJLWgR/Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKYf26JiSxy6Jy5mplrNxdemiKwkr6mb96uYAT2xFb0=;
 b=h+lUxmJ8IsSz3GqWqCNMHIHyYil9siPRQ+bZDmxP+Xf3S4WuP2yViP4g4aMmnSO9snbfKR6LoXVdAH07us+DG3+D4YKJmEF6tZrV9xxWLrKThhsGl73OG0T2kb4JEevXQZhLP757QIAMaRGVOtrB+oG+da0TntMPgkoh8FzsFh8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB7824.eurprd04.prod.outlook.com (2603:10a6:102:cd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Tue, 3 Oct
 2023 14:58:02 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6838.024; Tue, 3 Oct 2023
 14:58:02 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/1] iso-tester: Test bcast receiver with PA sync, no BIS
Date:   Tue,  3 Oct 2023 17:57:54 +0300
Message-Id: <20231003145754.3667-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003145754.3667-1-iulia.tanasescu@nxp.com>
References: <20231003145754.3667-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0016.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::12) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: 511c1018-dbfd-4e24-4945-08dbc4212419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XLlOaGZ6zgMw6pPJsqF2wrIR9nUIWIPpkanln1J1NrqpCA63O1J4GaWpwFQoWkh26/zL8kvPn9rINvj3T2uvgt6HAbsLMKFcHFIA99NNAOCIAYOyITQe7+5typ2kPycVcZGqLb4dnXkRt+/vJaeHABM/geXub5s6h5rpRPaoD9TrbeYVkOuzb8j7JVWSku7LukOAf7nK8PganXUsp6gN+274PlRcKgTBX6GlTsq1hObw5G5QL5jx7tCL9Y/j56v9Ov8P1YecR1Ed+1MqR4Y0KWugIuHQw+JvGxdV4zhQ8Pc5hp7oZm1P6C6CVJskI5VO4zT1gYxqmGmbns6rl1XMypLZLHa6GI8TTePG5Ggxd98/pKjhSaTG+du8QMoHe/PoDWuAtFq861ig0TWwq2IpBC04e2U/nAT5/dVOWOn2BpE1d70VJLR1ZQvq0IFHCUzquB71cIC0YjnreRUQ+vJl9MZ7yNQm6nMkBZmcJUhFRomM/RpIBVGvq6D//z5GszGOqHbnMnnOGPn4ud+EXRoS7pVzgaoFzj1KC9XA0ZMH+CFwgv1ibnRJLL073t0n1a9c
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(136003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(66476007)(6916009)(66556008)(66946007)(26005)(1076003)(2616005)(6512007)(36756003)(83380400001)(6666004)(38100700002)(86362001)(6486002)(316002)(478600001)(6506007)(2906002)(4326008)(8936002)(8676002)(41300700001)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Uu2FrpsiTcZP8Eep7GPfos83CVXeaTcHJ9GIFMBFnwUqYHOzBoABpW4GhsL/?=
 =?us-ascii?Q?kWjLlklJ4k2b7+z9freULH1cTS5g2ncIqXkXB/y5V2P3TfzH/0v7aFeStYpm?=
 =?us-ascii?Q?0qae+qesuyE71ARCx2FXZGxCMZ65i9woGhjstu5oLZxJ+r/w0g54+OsWZxpz?=
 =?us-ascii?Q?gz4/0A0+bvRbqebExNG0cHwKIrWFqImpqa1EPHfsu2ilz6z307yOCnFZ9sH8?=
 =?us-ascii?Q?yS/22pyNi0MiqEHey+NPIhm2Y5bq53uEFwkJx5iPDsAHDy4EEk9buUuKO2h9?=
 =?us-ascii?Q?+EKRult5ZxPEa4zeqTdWNlHs/z+KRswVAIQyOws6F3h6cmV7jIJlUftGwpHz?=
 =?us-ascii?Q?mPe3ehVoqDa73qY29L7KB3jnEZbCl4SzTgqjygk0Z2051OzYULB2XWe4pYoH?=
 =?us-ascii?Q?mOe5pdRmk/ne4hudok2vqi1cjUjYmEzb+1uVgr7xmnU1/w+QrmJLwW8r1u8t?=
 =?us-ascii?Q?EuIC/DqH1BbVcLIuBfN7te82m10mkk80vzsJLhV08Im4reISh69lFpwoRfHM?=
 =?us-ascii?Q?8SYrrP+17MDu+Cxyi3Y4MzgL9LsVsQpLIS/YKWGvOFIry7BsqOGDbSXd263v?=
 =?us-ascii?Q?GtYkj/voNycoaNf0IjEn/bd2bE1TFDzLH41RL1GG6lsC1gY6pAN4XJPvml7A?=
 =?us-ascii?Q?ZKpl92rw4let8MysR9EITTHKBjL4RTo1S+IEoDyiIQOuDO7TGcVLw6H30gQ0?=
 =?us-ascii?Q?pofYRVuQzor1SkP6tiLgeHEMN/LXw7dqXPny5jO9ASKBT52ecL8/it1XAzyd?=
 =?us-ascii?Q?utMbaXbGl3nRQ8+H+BxSDcA0LGBophxKwbshUpWY+9BK+LDiK4VOd/k0xq2/?=
 =?us-ascii?Q?pv9pasm9Xl5d3NMstE8Hvci+f2ki7jls3voGlHMiJZHyhJUuJSqFlyvsG/+a?=
 =?us-ascii?Q?iGYqdaNLcNvPGSZoPGYahPjiKL0qHOTyOGBsLyp8vMg1jWOqnpjHdT7E9OdA?=
 =?us-ascii?Q?V5sibQzFjYJWSbDq0JWeBuhG7c+6oj0Se44DSUvNGvy3JGRMseUUSxTXof7J?=
 =?us-ascii?Q?2eQ8x2f4XMtyvU9DCzwkvFsw7s97K1m8+lvRk+wNaUMM8nl8ZIO2+HbeeMFc?=
 =?us-ascii?Q?oaBTrFaEJES4GxSQm8MewQIBoTlJ14x3q8SK76nK2tGcazRKIvs/jedB4FNH?=
 =?us-ascii?Q?6KQo1RPCe/f0+TroSkfAcBr2KheVnoLVOoxQlDQ0DNvRZ9CLAHJv2xomMnlz?=
 =?us-ascii?Q?R/hxQDvrRMet+2fsai+FTRDlxAdZBeN73/PxGQtoi7/Rf5Jl94e7jYrfIHdk?=
 =?us-ascii?Q?UBpYQXbjXyeDuJ15WXlhC9iE47Awlistuf4bu1SH/K8J8P/Ld3UtrDhha3E4?=
 =?us-ascii?Q?GSnXZmloHd4ZSH3IZfscfXphU8vOfZB24WkWEea0SWRwZ9/Iw6U8uzneEycZ?=
 =?us-ascii?Q?h7JBSVIVTHdlWFZ8oywc5fTPlOWe+y/DG4fXB7CUmleNpRqUykMfJUGnjAYZ?=
 =?us-ascii?Q?klwdn8yKIPJbRpl+efoQ4AWu00rH3FXcxMpQMQ/nLBvAHTsW/BVVSqWqCe59?=
 =?us-ascii?Q?LnxQpNsssTDSonUs9ZLPd/RsUjb/MOAvFdCADA++9u+ALQas7ZPFy5IekTiR?=
 =?us-ascii?Q?Ig6oVGmqrYNM25uCQQ83L4UuqjeoOVDQ1fjqXp30i+yfeGE9lG1AE7E7TVci?=
 =?us-ascii?Q?bg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 511c1018-dbfd-4e24-4945-08dbc4212419
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 14:58:02.4604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4OiytoJprO8TJhEJlit4GsI9hWZaAjnvQSktfkLJWEt2sJhe+iXEhq40ldQWoAVfTz7BWiplHu+yzlcZY1ym1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7824
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This tests that a broadcast receiver is able to successfully sync to the
PA transmitted by a source, without performing BIS sync also:

ISO Broadcaster Receiver Defer No BIS - Success

---
 tools/iso-tester.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 410da2c93..6d24c4c8c 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -411,6 +411,7 @@ struct iso_client_data {
 	uint8_t pkt_status;
 	const uint8_t *base;
 	size_t base_len;
+	bool bcast_defer_accept;
 };
 
 static void mgmt_debug(const char *str, void *user_data)
@@ -1141,6 +1142,16 @@ static const struct iso_client_data bcast_16_2_1_recv_defer = {
 	.recv = &send_16_2_1,
 	.bcast = true,
 	.server = true,
+	.bcast_defer_accept = true,
+};
+
+static const struct iso_client_data bcast_16_2_1_recv_defer_no_bis = {
+	.qos = QOS_IN_16_2_1,
+	.expect_err = 0,
+	.defer = true,
+	.bcast = true,
+	.server = true,
+	.bcast_defer_accept = false,
 };
 
 static const struct iso_client_data bcast_ac_12 = {
@@ -2257,8 +2268,11 @@ static int listen_iso_sock(struct test_data *data)
 
 		bacpy(&addr->iso_bc->bc_bdaddr, (void *) dst);
 		addr->iso_bc->bc_bdaddr_type = BDADDR_LE_PUBLIC;
-		addr->iso_bc->bc_num_bis = 1;
-		addr->iso_bc->bc_bis[0] = 1;
+
+		if (!isodata->defer || isodata->bcast_defer_accept) {
+			addr->iso_bc->bc_num_bis = 1;
+			addr->iso_bc->bc_bis[0] = 1;
+		}
 
 		err = bind(sk, (struct sockaddr *) addr, sizeof(*addr) +
 						   sizeof(*addr->iso_bc));
@@ -2420,9 +2434,21 @@ static gboolean iso_accept_cb(GIOChannel *io, GIOCondition cond,
 			return false;
 		}
 
-		if (isodata->bcast && data->step > 1) {
-			data->step--;
-			goto connect;
+		if (isodata->bcast) {
+			if (data->step > 1)
+				data->step--;
+			else
+				data->step++;
+
+			iso_connect(io, cond, user_data);
+
+			if (!data->step)
+				return false;
+
+			if (!isodata->bcast_defer_accept) {
+				tester_test_passed();
+				return false;
+			}
 		}
 
 		if (!iso_defer_accept(data, io)) {
@@ -2444,7 +2470,6 @@ static gboolean iso_accept_cb(GIOChannel *io, GIOCondition cond,
 		}
 	}
 
-connect:
 	return iso_connect(io, cond, user_data);
 }
 
@@ -3031,6 +3056,10 @@ int main(int argc, char *argv[])
 						&bcast_16_2_1_recv_defer,
 						setup_powered,
 						test_bcast_recv);
+	test_iso("ISO Broadcaster Receiver Defer No BIS - Success",
+						&bcast_16_2_1_recv_defer_no_bis,
+						setup_powered,
+						test_bcast_recv);
 
 	test_iso("ISO Broadcaster AC 12 - Success", &bcast_ac_12, setup_powered,
 							test_bcast);
-- 
2.39.2

