Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F45AE728C2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Sep 2023 15:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbjI2Pon (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Sep 2023 11:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbjI2Pom (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Sep 2023 11:44:42 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93971AC
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Sep 2023 08:44:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=icbH6bs6QNDiJAQPEOvd/1LlYnH60IZOLYTQZ4gIU0nziqfFRwl5h1SCjVMlfIPj0qsMHd9w5SJS62oeoDE8d5OblUXKPvBbbenSqEm9HKVuPun3hMa5NiciLRDPaFhv9XbWrikgYLDbLh4KScTe4XGy148RIsuIjBMcf52dgvOIQl+kjhq7wV9C2OHQACZp7LAsIgwhUhAtzrf7AuQgltIEj3pv9nnADZW2Bh7zzRJkVWxcx0rlG0iWqpQwFY92MjE/gy9gg2Umo1AdhP++X9F35/vtXiW1LQU69mKH7IchjnSe/Mxr1fxQg68WC2U983qT7r6q7UYESNIVxnt7/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=op0FYvyLP263u5DCW2Rc8A1bAQeOeZq1BEMHFA6VztU=;
 b=e42oaQ0UPEy/Ebc+Inr5zbnraIXjbGO5EtIvBJn139e7lciDfVKBkK2L7BLV8oMrfbDA9QjCD+z4jXr/FZevgfNPaaadUP1V3PYg4sr4R2/6fCJG+RK3CvrGEi68Ed3nZQgRQ5WQQZkJuKT6H6z5xLzYFA4vRobFIKxQyCCmgEw8+XE18fmv7vv80zhHyvpwVrnR/XeimY4AvpcDnmND1FUeMgxGvhRVlCzYjGTXp7eLmCe83zNnO5RDnr5jT9i4Es4KexdPVIPraszscAGHeOIaoIDjI7n16Rb1YZf+XgBinEE5dDUqgx5bfOAebbdmA7D2uL5RUjZoRvpdYJzWKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=op0FYvyLP263u5DCW2Rc8A1bAQeOeZq1BEMHFA6VztU=;
 b=bu6NmLINS23O42Dp9FocFdhH/CG+LlnDpoLnNRZRKY+erBCMW8UH4dN7vaGb6FEeijGxKEQalvGq/yrChEChA6SaVC3KBbOHWVLFiloz93FBq2HPtCOZhzXboOtCOBqiHjxe5hQ5n+zq9Y1obDRp/AiKAgKjtf2HpSJmniWtfYs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PR3PR04MB7259.eurprd04.prod.outlook.com (2603:10a6:102:8a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 15:44:37 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 15:44:37 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/1] iso-tester: Add test for bcast AC 13 BIS unset
Date:   Fri, 29 Sep 2023 18:44:21 +0300
Message-Id: <20230929154421.3820-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230929154421.3820-1-iulia.tanasescu@nxp.com>
References: <20230929154421.3820-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0219.eurprd08.prod.outlook.com
 (2603:10a6:802:15::28) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PR3PR04MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e59f719-22f4-460d-6882-08dbc102fc9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KrnKaDI25pD3UrFWNzm/YinkwbYfPEkq19xLym6bpY6FbP1jdH32C2IunFl1EnxqCnWuLWmQ4HeZ+hzLI7wwZdQO/L9E0ajI50kZGTIijzjH5b+UKA/szPnUakDbliZARdc682hv++jGchPifgENW/QAz2WnLf4kWR/hzn9dJ9yFmlBjnqaDi+56P7PhOxC9JlXdfFLKk2bpVezVxjLS9kq6X7Q/JHqyosqut8baB4T8jsQv04bVDHSZ1GdK3U7CivNNHbGWAg2JMAIXifXW/qqGFt7dOYB5XsYY7wK77y+MaY8krKlI/nwstsfz7pj/Nvp8sUBKHbg4UYKfsxuvmYs9Te19m9hgFV1taMr18zAz45iBSREQIqHzsYC6h+5lfpMuBMG7AWhvpuXlmVb/NdQRRirsFW1Z+DAixwOkpN5oIrj6D1TAasVseaY6sonig8I0BohEZLynAprzkkWd7Twip/vwICXeDU8eBcHp8we5Z+RkDKAT59QxCJ4OUwcEaNKTBpTWEJrhiaJC0+m9jog7pdmu2k5HeZV4xezg+ygtVBNQs2Iq/uacfOlVLXOY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(39860400002)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(66946007)(8936002)(4326008)(83380400001)(26005)(1076003)(8676002)(41300700001)(316002)(66556008)(2906002)(2616005)(5660300002)(44832011)(6916009)(6512007)(66476007)(6486002)(478600001)(6506007)(6666004)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E2OmP4mNLIM5rGQ1IuZ7qWC0b5j0Q0203HIB84RLFNKAeFZbxI4C2BRIZfwF?=
 =?us-ascii?Q?/fO9v9Up57jy1mhTy5ZNY5ina9bqujmURbOejZ9W9TrGK2fDq5+Fs/nv5/vu?=
 =?us-ascii?Q?gBcTYlWL4cQo2bfIgE08RiXsL2wf18w/0DuFxGxWhqLm5DgtgP8icfesq1lT?=
 =?us-ascii?Q?s+6v0eo0rfSfPkKgzfcg2KT7S8wSWJAsmXyQTIeizgUzwu33jEj/tncQ3hh/?=
 =?us-ascii?Q?Si1QfVYOy5WxsJKKQpxy2P7D1jVgCW56KZIuTPybg2C3M++JC3YKsnuhkN0i?=
 =?us-ascii?Q?FflUTM4fPzIscTUlnNal0iAbKjj23PUVC0IIZcZDvISm108Ww8OzAt8DQFb6?=
 =?us-ascii?Q?hZMfzhOtSpo9PRIO1E/E+HYQ/NXnwogcmRxBala33+AFdnPAzA+iw6rDXCvk?=
 =?us-ascii?Q?Me3kNBq128K/vPLMTIQi9QJGMjrlKxj4Qaf58a/rtk52++4TVQmXnXFUbt8N?=
 =?us-ascii?Q?R/Rx0Raowb+lwi4h89Q+tvz6NtTIxpBEj/j8f4h1BLDB3u10vMUUl8957Xd3?=
 =?us-ascii?Q?5fqAN5slBFKvvDPRT3vg3Epc/dqWFKhU6rry4uoUFnewQl0aSpF0Fk1YtJGC?=
 =?us-ascii?Q?y2vn7sRlp1mu8J50dMOQLh7B82JKuFsSTcumlaJJ0LfnzNOzzLOgwYOkTbnZ?=
 =?us-ascii?Q?AcMj9Ld40zsR9WamwWxR5TP8llAQ6NvFPDPOdFgNT+asgnHHPbDZwS2SKmw9?=
 =?us-ascii?Q?zEiwYAi+zpPwngo80SZGaeC7X4sM1/LE4jxhgpreunVFvdp52mR5Jw0adnO1?=
 =?us-ascii?Q?yQkuGkyV9hqO4lMoCsZFDx1Gb3/0++uYP9ubVXmYoW4hYMCYMGkbu0nywJMn?=
 =?us-ascii?Q?am3dcUmF1Lhor6woYUzgGRMCCv5Cj2XfYNZU6iUERbyUdbAXooNaXnaUSqEi?=
 =?us-ascii?Q?LDbjyTMURux0QToSHwwYd8WX8yVX9chcYfbce45KGi+h/eZQc52LOk3pB4j2?=
 =?us-ascii?Q?HbRQqO/ClfHk0S2yyCif111Y11XE895Sn1gogdl59Vtv7/OVPKMldNxPWvuT?=
 =?us-ascii?Q?IzWA4xHHIKPKp99w7t2KS+Wdr3kXvY1sn3+KiAUQpGKnBV4v/6EsvACMByye?=
 =?us-ascii?Q?PPIW1coHTZl9HlrzH9lVyK1nkmOzpsE4Z5HQSn9yzIv8N+4kZ5l2ifNCFhfb?=
 =?us-ascii?Q?FtFHtfSoN2acD5KtezTlerpSwu4NQxDaG8QtUm0FpQBgblchj0XfdBFGJFcj?=
 =?us-ascii?Q?Swp1DSEhpBYpinZ1suk9kfs8mBH6tRKqI0ZDrX/kmN4uIcAqwSvMO0Xi44I5?=
 =?us-ascii?Q?FnSw71cyNFxk7CUFlR8hB5ZeZk09RldfTOE7NejFPCK5wkxIzdMNnhg9jVyx?=
 =?us-ascii?Q?jUdYUlZUpKMIv/FGMCSPqAWOTT5HwiwT+PhiEXm9YLjgKiivOtMNJVA01O+3?=
 =?us-ascii?Q?58XWqV0b/Ys5y1EQf+ZAyoiaGeGFXxp8ZMcZjldfz4IvwX1sj4974hTn7Syt?=
 =?us-ascii?Q?8E0JcGCkjlqwbk//nbqamgxC2zEBnlUhFJv/ZAPAqBdaZ0Qy0kaqzR0aJb1q?=
 =?us-ascii?Q?Ylvq3Nbo+8NzDe97n/jcXIl5pbrTh6KXtfwVKR1CEZgwQr8AbIwxagibNbnY?=
 =?us-ascii?Q?kmCLr7bWJEkwGj70S+YCsRix7Up0YvsRTK4vjBqK+WkiDi5cX5wRKFnrcehM?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e59f719-22f4-460d-6882-08dbc102fc9a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 15:44:37.6213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LjBSX94wpt5ccs1uUdKWBWtAxCK/0NKHgAjrS39e5WV4gATWG0eYdvTqB+Ef+Z0mUyGtCGqMxPpj4nVHrFVdxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7259
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds a new test for the ISO Broadcast AC 13, when the BIG handle
is set but the advertising handle is unset:

ISO Broadcaster AC 13 BIG 0x01 - Success

---
 tools/iso-tester.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 410da2c93..10b42dec2 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -330,7 +330,8 @@ static const uint8_t base_lc3_ac_12[] = {
 };
 
 /* Multiple Audio Channels. Two BISes. */
-#define BCAST_AC_13 BCAST_QOS_OUT_1_1(10000, 10, 40, 0x02, 2)
+#define BCAST_AC_13_1_1 BCAST_QOS_OUT_1_1(10000, 10, 40, 0x02, 2)
+#define BCAST_AC_13_1 BCAST_QOS_OUT_1(10000, 10, 40, 0x02, 2)
 
 static const uint8_t base_lc3_ac_13[] = {
 	0x28, 0x00, 0x00, /* Presentation Delay */
@@ -1151,8 +1152,17 @@ static const struct iso_client_data bcast_ac_12 = {
 	.base_len = sizeof(base_lc3_ac_12),
 };
 
-static const struct iso_client_data bcast_ac_13 = {
-	.qos = BCAST_AC_13,
+static const struct iso_client_data bcast_ac_13_1_1 = {
+	.qos = BCAST_AC_13_1_1,
+	.expect_err = 0,
+	.bcast = true,
+	.mconn = true,
+	.base = base_lc3_ac_13,
+	.base_len = sizeof(base_lc3_ac_13),
+};
+
+static const struct iso_client_data bcast_ac_13_1 = {
+	.qos = BCAST_AC_13_1,
 	.expect_err = 0,
 	.bcast = true,
 	.mconn = true,
@@ -3035,8 +3045,13 @@ int main(int argc, char *argv[])
 	test_iso("ISO Broadcaster AC 12 - Success", &bcast_ac_12, setup_powered,
 							test_bcast);
 
-	test_iso("ISO Broadcaster AC 13 - Success", &bcast_ac_13, setup_powered,
-							test_bcast2);
+	test_iso("ISO Broadcaster AC 13 BIG 0x01 BIS 0x01 - Success",
+						&bcast_ac_13_1_1,
+						setup_powered,
+						test_bcast2);
+
+	test_iso("ISO Broadcaster AC 13 BIG 0x01 - Success", &bcast_ac_13_1,
+						setup_powered, test_bcast2);
 
 	test_iso("ISO Broadcaster AC 14 - Success", &bcast_ac_14, setup_powered,
 							test_bcast);
-- 
2.39.2

