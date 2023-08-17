Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EA5C27C7A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Aug 2023 06:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348325AbjHQGtV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Aug 2023 02:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348320AbjHQGtR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Aug 2023 02:49:17 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2059.outbound.protection.outlook.com [40.107.14.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BA62102
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 23:49:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8X0Uw01d9QTgLNCyjkmY+GbSizZsuWbE5pMZWHC/ylOgLIQWwsPsQDpg/FNNZffF9TyBrMk5NpEY27/ZR1ctcrm8zGTTj39i7SYBezNGBig1caUYvjjvpUHcOpew9bSi3rbLfxarrHyz6c0sOeza0dTIDyPQRIxVZR5t41SkxteddF9FihIlM08l0qQdXiIA9a55n/oqY9ugleYqoRT14OxPJ6nC0YS/eePsepCChoV4iA6Yif1pOShpAonXfP2QIH3IeVxepRE05ZZHKW26KillE+FQO+B8jSf8CyxhZ8KaHecKnoStUsm5ZoWN3QlCJNirqnrH8iYJWGgL95NEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkiYrJkLd8vJ9bGclOclM3AY7KqrWuNidcUr/nYCYEo=;
 b=ZST4/k11nU6X+9x3oMol1Lc/m6k3PAugVkC7x9pmVhs3hy+1AWvold2d7rfoyAO9uCucABWd10BCZVJBlEflCEzVwmmCCpLm3pGtuEVsm7wckkSnVj7XuQSvpYQaG/vf0HEQmgt6loIyHkK4nnarGrIvz8bmpIEZhAYfKGvcOE6UDm6/D+TUw/+MMD0fLISTMbjWQQvdeXxDwjBn/nbi8Mfi2TFm0OjSoGxX2OThPtx0ymhztixnBN7xdnLlcrYiKuSBu4l2w5yl/cAxA50/FqNxRbsXcVH8N54V+JJYiZL52keL6NnropV/eioiOZ9CFDJ5tns2cf13gJvifz4vhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkiYrJkLd8vJ9bGclOclM3AY7KqrWuNidcUr/nYCYEo=;
 b=eVTRjTwFB/qNtaVFoqHZJnFjJM+n2LsNTCPzfU5OP4Vf3aRXiEqnD2nDjvrqkf05XK+fmbpgxHoz9j7GxzessWIngUpppWIP/OgNt8Wt8lo7c7gBttAQDbVnVin3MiyNb9PX8Xh80geNNHnQr77kN0La/d//cOCkwtUjQ/NOsmQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8484.eurprd04.prod.outlook.com (2603:10a6:20b:34c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Thu, 17 Aug
 2023 06:49:14 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 06:49:14 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 1/1] iso-tester: Add test for bcast receiver defer setup
Date:   Thu, 17 Aug 2023 09:48:53 +0300
Message-Id: <20230817064853.3706-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817064853.3706-1-iulia.tanasescu@nxp.com>
References: <20230817064853.3706-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0050.eurprd04.prod.outlook.com
 (2603:10a6:208:1::27) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8484:EE_
X-MS-Office365-Filtering-Correlation-Id: 63582c9e-c251-44cf-289f-08db9eee1218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zuE8Spz7H/Y9HuRvGrxFTeh3j/HI9CTcyaBAwnEte6lVO+QzxmaqrkJZnKpY9ulmSwDOqQDkLQpbcdgF17JeK9YhRfn1yvEThAGnRMSnRgnxeD9zTGAKA+dvNKlVcAX/LufL/w4e24QK09ZW/7SN4Kjx2bYyZMol/JldimalJ24aw6oTm5DAc4YCCoJPr8zQlk96NsdxhFQWeyAoKI2h2a1bMxAyQyyOvz0Fd23vw29aaufYourifc03UobFDBETwLgf/u15X2QSkpTfdlp+M4no+qfr6MBHlNWOKrZ6Ti+rtwbGoD9JfafBjNVJLQd25pcrDs9wlMHLnLnk9BEPsHuIKpZZgxC+5BfO3DyW1ZpjvX74+vIj1ieckUumo0XvnX9M9uiHdUSwZi3VFZW5CUk4qyAYF9JpG4kaukjYtv5FHYJGoh4beRnzPcWoh62jwbtraeisUtTJ4KJC6lcWBFLJJib662X/yP4lUCb4W95oU9oQ00jkIqoXW209FacU5SicF4uvPeyspvxxoTcNUzXS9Lrvc1yRfsA9vnLuRqeSwF1D4e4uq7L3NTAwZaSPn3Kki7OyN7/Myk0eDCiRzVCai5OFRTO6dsfrjvo3mtd8wCvUpMRI+mRiZQj2pRo1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199024)(1800799009)(186009)(316002)(6916009)(66556008)(66946007)(66476007)(5660300002)(41300700001)(44832011)(38100700002)(38350700002)(4326008)(8936002)(8676002)(26005)(2906002)(55236004)(83380400001)(478600001)(86362001)(6512007)(52116002)(36756003)(6506007)(6666004)(1076003)(6486002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?90vNjGyeMLCiXLoPyk1jSHXdjBY8TaNtUjgfBudYDeM6Hf54n7Vbpfz8CB+d?=
 =?us-ascii?Q?SuU2GjMNzguVwpG8KyJBlGEPlIwVIAKCZJJB63eJOZ6HdnKbFJufKYY2XPfY?=
 =?us-ascii?Q?zdH/aK2g3cI6FoCV1dRogiUcBLs48KV4dCNPKAuNt7p2uKc+Q4qpBp5AMSs5?=
 =?us-ascii?Q?OliPkWVMZrVlKEU6QQFxkthohLJqzkbnYWH23i3wDeiTBx0q2QvmDrugprip?=
 =?us-ascii?Q?jW/aKNlMzkp7efy4sSv+qhrgvpmtnXJAWSNas5g0EHvDedAtd6i1nfO26c2n?=
 =?us-ascii?Q?j6geODP1xm0nctTYFm9WsqxtwLZ2nGBpbg6jOmNMoArdjS6XJdCF/5SdUdxT?=
 =?us-ascii?Q?c4JszqI8w3dnbwafnG/Yow9D2cIAudS52I+GbxYniPtHk/sz+HYgwHml+3N2?=
 =?us-ascii?Q?xCPEDCTzjcnY5RCsaxtyw/TF03rx6gIJHJkVh83Y1ufkJV20J60sqp1QqBGM?=
 =?us-ascii?Q?uGYgJHu2PN14pZ/FRwwAeL8TuBlrdWd1EpnmqXoD3dhAW5Pp1GtKCc32vwRQ?=
 =?us-ascii?Q?2OeMtBlbCcSz8PlqbLtF9G21F8+PZ+iAWCdRPQonXEESwqv1LoYjUZmYkaGk?=
 =?us-ascii?Q?7ANpSjvMuu+Y7N6mgncSV8oRxdAv702cPqvIEetKDzm0Krk/LJoY/fyps8pT?=
 =?us-ascii?Q?Ey+EoMKhtJO9gKmdTp9ZLCS8hk/vw4/PRXrNpFsL12mR2Ke4W/yEYDg+0YGw?=
 =?us-ascii?Q?xgK76Vs70mqjotseohKOglK8udbhlDYqmlCN2uwVaT748Io/UIXC6cdn/6pG?=
 =?us-ascii?Q?UYgCgAtjQKgC5Jb6OOICWaP/NGXqfSoEh1LA0Pq0V23h1SVZPRJzaHXO0dJS?=
 =?us-ascii?Q?nPos8gt4XN0dbYp5snlCOr5K35E1Ks1fl15bhMh5tRK1BWdPyuSmDeAFZfv6?=
 =?us-ascii?Q?eDGL/El8Kc8sJp17DkzwKfyyDTqHFp6/paRWF8qgFY3VUBPZo0xlz+wNYOBf?=
 =?us-ascii?Q?CWcApi6PVhpt/74rW1UhezcFS93Tk3PBYo9BceHcgFueGz0Lg2dgeNDTUiRS?=
 =?us-ascii?Q?dDPcfRj+FqEnx7JBsNNZsHyfywMwaxXrBZIuGmpUg9BZ3t4qJBpYBd7YsAFk?=
 =?us-ascii?Q?H5VbSI0XA8/7hpjajsI2R1C+hJPLVhYoyAMwLDZ04nqwfR9jODQG2oPYr0yp?=
 =?us-ascii?Q?4rOMN1OgSz+2o00k+5fUsY95O0kKPxNQgZlEjPrY4aSHBfX9yxZ70RkqYJd0?=
 =?us-ascii?Q?tZ0cPBvMctK0ua6sQ5Aj5Azk3zWrVo5SFMPVCxwfPpyf9GZXxZjiVc17mDMs?=
 =?us-ascii?Q?YdUtLg5qhIGrlWedUVIT4Zu7STmakvbY+3lIu3KuGrZyf1O4D3I6RyEbtHjd?=
 =?us-ascii?Q?vTMOdZAFhrFfMUxTDZNDVoO3lC7BdUTddwHGTi88pVLcbjHdshs6Wgc5Nese?=
 =?us-ascii?Q?wIMIT0OOK1ndWC5Ft8lChWUwqFdfVJoFIVsP8zP0K3MMpGmkC/WsRYU34eGu?=
 =?us-ascii?Q?OAJeHYHBBfYVXLshK3ki3XNfSKfgPRF5gIBfutdpxaw0g2/MIwaNxjWMill6?=
 =?us-ascii?Q?nGBrzja18nHqHSihoWy8hWCGhz0ok78Z5rKE8kxftWtB46OPng6M/lMKmusG?=
 =?us-ascii?Q?bW+dT0Mq76yezoD+Tpcci0bhNOhEdSTbRDh+SQE/j9MFMPkv4uJEWZO9ed7t?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63582c9e-c251-44cf-289f-08db9eee1218
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 06:49:14.7110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pRDvVq+p7rc/m5d3ZzliUjykCQ8gmPQbqPA12Juyy6eGvKOID4E9zo7au0ZjEdIPLq2OP5mWXdJNgB6ejl9pRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8484
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds the following test to validate defer setup support for the
Broadcast Receiver scenario:

ISO Broadcaster Receiver Defer - Success

---
 tools/iso-tester.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index b1a2afba0..75edc4380 100644
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
@@ -1865,6 +1874,8 @@ static void iso_send(struct test_data *data, GIOChannel *io)
 static void test_connect(const void *test_data);
 static gboolean iso_connect_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data);
+static gboolean iso_accept_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data);
 
 static gboolean iso_disconnected(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
@@ -2346,6 +2357,7 @@ static bool iso_defer_accept(struct test_data *data, GIOChannel *io)
 	int sk;
 	char c;
 	struct pollfd pfd;
+	const struct iso_client_data *isodata = data->test_data;
 
 	sk = g_io_channel_unix_get_fd(io);
 
@@ -2368,7 +2380,15 @@ static bool iso_defer_accept(struct test_data *data, GIOChannel *io)
 	tester_print("Accept deferred setup");
 
 	data->io = io;
-	data->io_id[0] = g_io_add_watch(io, G_IO_OUT, iso_connect_cb, NULL);
+
+	if (isodata->bcast) {
+		data->io_id[0] = g_io_add_watch(io, G_IO_IN,
+					iso_accept_cb, NULL);
+		data->step++;
+	} else {
+		data->io_id[0] = g_io_add_watch(io, G_IO_OUT,
+					iso_connect_cb, NULL);
+	}
 
 	return true;
 }
@@ -2400,6 +2420,11 @@ static gboolean iso_accept_cb(GIOChannel *io, GIOCondition cond,
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
@@ -2419,6 +2444,7 @@ static gboolean iso_accept_cb(GIOChannel *io, GIOCondition cond,
 		}
 	}
 
+connect:
 	return iso_connect(io, cond, user_data);
 }
 
@@ -2963,6 +2989,10 @@ int main(int argc, char *argv[])
 							&bcast_enc_16_2_1_recv,
 							setup_powered,
 							test_bcast_recv);
+	test_iso("ISO Broadcaster Receiver Defer - Success",
+						&bcast_16_2_1_recv_defer,
+						setup_powered,
+						test_bcast_recv);
 
 	test_iso("ISO Broadcaster AC 12 - Success", &bcast_ac_12, setup_powered,
 							test_bcast);
-- 
2.34.1

