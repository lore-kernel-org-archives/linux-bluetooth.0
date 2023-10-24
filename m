Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC79DC07545
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Oct 2023 11:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjJXLED (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Oct 2023 07:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbjJXLD6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Oct 2023 07:03:58 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2077.outbound.protection.outlook.com [40.107.7.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AE2109
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Oct 2023 04:03:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/0JRKA6D61CRa77VUoKRwHbdVMAwoBcz/rtZeknA0wh3CzoHlQ2zGft8mF1OMLFaZelqFt1luHrHVghb7DyvnGvRB9WBZ9hwSCJsMMD/5IMbAIsV4clPMmBcumr534DI1oA85MgZb8ZVddyihdkaEV5RnV84RlGUwkHy6QcaNPdX9MtBP+EEUl2gXgDXbMhyzXOQ9JGeM+oNUhFajP5UkDN8n18DQIliQPev+/YZJikba2xhXsfD0gXWpN5M0Tub9tHYCuami8yVhYdzrwwIb71cfW7dMssKY5uKBXqdsv7fjUwYkpQWCtQ/0taUq6lhpL2fa0RfOlkw0PVVYYEQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvnN1hBa3lGGW4Yj2fy5IiPakLGOv+uAgut2yrZwiyQ=;
 b=fqNTrVglzaWHT6OiFL98+Jqgrx5TcQi/a+nrUbXN7DnXkzgrTi/Jy9BR06zuPtg6AD5icGh88oa9rm2F27E4SwnyinXM842kKJsEzKVv+Wylx12kgKhSjg1mkdgtZ2eXX8BIKy1dNdpb+i9p47VpJ0d2wl/m+3y/YPU2E8illZZp3aYDz/5R1WSsuva33x6lq5NkL0WTC1VcAUm+eNlNuJ/tI+ylTLh9NXrjNtAqIZEYhsBcMF+FuFVy8oPeQepIzx30EZubVHCGzvD6zIlwY7EDLXATNpXZML8WWXza+xESMcLwJDOfuFI0iRChhF1a8W4x2ZPyi0Jd7Ffuo2978Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvnN1hBa3lGGW4Yj2fy5IiPakLGOv+uAgut2yrZwiyQ=;
 b=kSqN2YzgJVYzjwg6kxropnmR9wI6cTemP7HT70vqR5N42LcjsIsx+w3Tq626ydgNjQAcYBlKTtjqjeGkZundUeju5Vf234LcWI8/3Can661csB6OYSi8AoyzfPNoek+XJ6F5n6MnQFyz7gPyRLD0DJxZtIAoFNe6C1V+Ok1SB9Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8545.eurprd04.prod.outlook.com (2603:10a6:20b:420::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Tue, 24 Oct
 2023 11:03:53 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::b21b:d65f:6b00:34a0]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::b21b:d65f:6b00:34a0%6]) with mapi id 15.20.6933.011; Tue, 24 Oct 2023
 11:03:53 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/1] iso-tester: Add test for bcast receiver PA bind
Date:   Tue, 24 Oct 2023 14:03:45 +0300
Message-Id: <20231024110345.3292-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231024110345.3292-1-iulia.tanasescu@nxp.com>
References: <20231024110345.3292-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0012.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::24) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8545:EE_
X-MS-Office365-Filtering-Correlation-Id: eff8f2c7-6124-4fa5-3dc8-08dbd480e8cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eYFnjH+AZoplLi4J/sEIuXivpSnaeKK+UrcEfQXjSMdWOVfDNqUzKtSsbwduYWn6kfrbL2EDV4xZVApzhdSGdElMmQh5J+B0ZqSdUqbPZjXA+uf8SlLh10/5gC+yUjso2nmlcFUPDxCMRWnW6ykeS75J9oCTq6ckNe9qSUjgCJpN6EX1lMcfcebTwcexVTkt5W1XoDgjcMoCN+nh7UNTaFPYzNN6X433+6aCZBAjawB9HY+FrTKwm5mYBOvyacTGquikhlOAbkg0msshxEbHbFwORy7BJmXi7QCs+qIy/5e8thqVbUskTAKuoyypZEqIFF5uSzhUcqfrkYtY9gAty4TvCDPdNBUCT7HQ6q9O35IGkw8OQ+X4knQT7NE3tu0YslHrFDaNBD3iG4qrkigCERlR6vQpvwEalMdt1Gj/TqA0gkaz/E5Pr1YyqPiM96xTsT5a84ID2MV+Sbppl5TgXHn7xcYheIjpk3Zzafx0l/sEOIKPyb52FAbsI5osqJJ89myb66ZUwJwAa8rIPUWwcYnwhNsqnTE90N5Md3/TXS7GUng0t2eQ/XqlqoJHUUYT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(396003)(346002)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(6512007)(6666004)(83380400001)(6506007)(1076003)(41300700001)(4326008)(8676002)(5660300002)(2906002)(8936002)(478600001)(44832011)(6486002)(66946007)(66476007)(6916009)(316002)(86362001)(2616005)(66556008)(38100700002)(26005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IQNboe044iVsWDuI/nhFtm/DPBejkVBCqES4hODCBm6dvJ0FfW6Mjc6oyKax?=
 =?us-ascii?Q?4LT4uPTbNhP3beAlB9yu+oENglgv3Ole6IH/OZn0ZFGHEDdVlajs3KpLzJ7/?=
 =?us-ascii?Q?jzu6J3sWvRhpWTUUNotaP5N5LBblxe7n/hjsh9kTEkBIAMHf35JED1pKaFFj?=
 =?us-ascii?Q?uDxG1EOCUFK923rlwOPDnABR51KAPucr79L2Xquco+44zt+W2xtijZsX24OP?=
 =?us-ascii?Q?EgpZCmdPPXTrct924fDPsAz9NZe1fAS54kOF7T9Irwap4udgaw38zmvYmiX/?=
 =?us-ascii?Q?3vuHLVG4yLc1L3vAGvu0gbyGsRSIZhfft1kFaXQ7lc3HvIM86etArpPL/nPC?=
 =?us-ascii?Q?X01PHijduYfdpaj3dSIRtRUOJe533A/i9CKNcsfSKWqAZGvH7vmibB1p+5xX?=
 =?us-ascii?Q?q0XfPEOJhW5lyqZkt1C3rPMgm52c1fNf0QD1vsL3AGul4Xb6Q8aaXx7Ec/1H?=
 =?us-ascii?Q?mCoHVZ9PMB1woi9SWUzfS4Abirl/fNE2fLAQkkJKDfXDSkB+wcfBoIGTeNfL?=
 =?us-ascii?Q?CBVYspXahkf3tVYa6xHAkqjk5bP22FF5e4kPou+t7yv0dP61VFzeZUmZxv9/?=
 =?us-ascii?Q?jpKVgE+NNqd4j45Y5IZwXldft3OdOXPDdO4QIfLaT9KNvx60c7jRBc4GeGoN?=
 =?us-ascii?Q?aHAbBE0hBlzbetRo6W/Qba7A7kqTEMWX3RHJRR7WhKlOva/em20tOfUPFrJq?=
 =?us-ascii?Q?LDoT4LpnHXUxXt4QFpEZOztX+yyUr2GEty3UA0lxxcWmrPidXZ9n8a9pB/tI?=
 =?us-ascii?Q?KzsGLoJxkzW2hVYvMtB1j70IER/yQQh3uyfbDIjqx+co3efF1FUy8oIOWbV5?=
 =?us-ascii?Q?uxwxHV3IHVPtzJubr5dVSRPDd9QLqfc69+z2eI4/1HwxxX2DnUMwnrUe2u8U?=
 =?us-ascii?Q?rNIriWA0MIPTMnMGxXrjeoC/TVVesqYZfcxb8Ocg2bMG4NfVCscsSSHBaLCW?=
 =?us-ascii?Q?CRpkPMyD9CsPHqc4DDDAN1ZNcnTFSHa82ey52hIaP7lUBcV009PvBortaHdZ?=
 =?us-ascii?Q?S9bnImwyiSQB2gAwskeOgBC77cbKBGEiZ0ft+YwjPITtaAwPfoB8k+So0wol?=
 =?us-ascii?Q?g65V2VMXaoC2Zu4VOpFiGRMjeIuCJqTvr/RgfzwMPEjbipoukp1682VEuscQ?=
 =?us-ascii?Q?OgFAFbrYXmJElTvj0M9GEJ9mhXRdlTyiMJkH4nOPaO9m0/HYy0PAaMebi0Yt?=
 =?us-ascii?Q?N9xoobqtF5zKYl6llrn6J0Pq6dE81n1vzjJzb/jpvQNNsTQX7/cZcUShugod?=
 =?us-ascii?Q?7Z2aG3WidU4IHavKQb6y9jzO77xSbq17Zr4o3oIPMmLojqh2GRu4pHy1g1ck?=
 =?us-ascii?Q?54jMn61YCBEDwG02AWK+bMRRF0Z1NWnG9kujIUKGH7Fhf0U7GKe+oY0e6ZwA?=
 =?us-ascii?Q?BWVpIOv1ognNf3MiCLvjiQzb2tjzpcGTRrpTPeXtJGwSmICYwv996XE0iKoo?=
 =?us-ascii?Q?jE/GcRe4WInn0GsRc57WPXrb86hg+G/ButRSaa6b/hMcWst76LPbFu3F9Rcb?=
 =?us-ascii?Q?lFjlI0xhlagqtW4T8DoHL7s0qnTsYo/TFJRZRzFlN1IhV35ZoAEW55KfimUC?=
 =?us-ascii?Q?QM3rC8AkGchqg/9K1PhN7nCP5zIwiXUW0x+skLxSASKrdP3+k+AF9uZ9ZQd0?=
 =?us-ascii?Q?/g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eff8f2c7-6124-4fa5-3dc8-08dbd480e8cb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 11:03:53.0903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jYScok40aD1dV0KmUOnktWMjCEn+jzpY0t0qzn/7zDOvNTYrFiHplxl7zQfyqRiKAKt17vXqlKpLsiDSqgzVgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8545
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds a test for binding a Broadcast Receiver to a number of
BISes after PA sync has been established.

---
 tools/iso-tester.c | 70 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 51 insertions(+), 19 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 1337229e1..ae98af775 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -412,7 +412,8 @@ struct iso_client_data {
 	uint8_t pkt_status;
 	const uint8_t *base;
 	size_t base_len;
-	bool bcast_defer_accept;
+	bool listen_bind;
+	bool pa_bind;
 };
 
 static void mgmt_debug(const char *str, void *user_data)
@@ -1143,7 +1144,7 @@ static const struct iso_client_data bcast_16_2_1_recv_defer = {
 	.recv = &send_16_2_1,
 	.bcast = true,
 	.server = true,
-	.bcast_defer_accept = true,
+	.listen_bind = true,
 };
 
 static const struct iso_client_data bcast_16_2_1_recv_defer_no_bis = {
@@ -1152,7 +1153,15 @@ static const struct iso_client_data bcast_16_2_1_recv_defer_no_bis = {
 	.defer = true,
 	.bcast = true,
 	.server = true,
-	.bcast_defer_accept = false,
+};
+
+static const struct iso_client_data bcast_16_2_1_recv_defer_pa_bind = {
+	.qos = QOS_IN_16_2_1,
+	.expect_err = 0,
+	.defer = true,
+	.bcast = true,
+	.server = true,
+	.pa_bind = true,
 };
 
 static const struct iso_client_data bcast_ac_12 = {
@@ -1996,6 +2005,7 @@ static gboolean iso_connect(GIOChannel *io, GIOCondition cond,
 	if (err < 0) {
 		tester_warn("Can't get socket option : %s (%d)",
 							strerror(errno), errno);
+		data->step = 0;
 		tester_test_failed();
 		return FALSE;
 	}
@@ -2008,6 +2018,7 @@ static gboolean iso_connect(GIOChannel *io, GIOCondition cond,
 
 	if (!ret) {
 		tester_warn("Unexpected QoS parameter");
+		data->step = 0;
 		tester_test_failed();
 		return FALSE;
 	}
@@ -2028,6 +2039,7 @@ static gboolean iso_connect(GIOChannel *io, GIOCondition cond,
 		tester_warn("Expect error: %s (%d) != %s (%d)",
 				strerror(-isodata->expect_err),
 				-isodata->expect_err, strerror(-err), -err);
+		data->step = 0;
 		tester_test_failed();
 	} else {
 		data->step--;
@@ -2279,7 +2291,7 @@ static int listen_iso_sock(struct test_data *data)
 		bacpy(&addr->iso_bc->bc_bdaddr, (void *) dst);
 		addr->iso_bc->bc_bdaddr_type = BDADDR_LE_PUBLIC;
 
-		if (!isodata->defer || isodata->bcast_defer_accept) {
+		if (!isodata->defer || isodata->listen_bind) {
 			addr->iso_bc->bc_num_bis = 1;
 			addr->iso_bc->bc_bis[0] = 1;
 		}
@@ -2382,9 +2394,28 @@ static bool iso_defer_accept(struct test_data *data, GIOChannel *io)
 	char c;
 	struct pollfd pfd;
 	const struct iso_client_data *isodata = data->test_data;
+	struct sockaddr_iso *addr = NULL;
 
 	sk = g_io_channel_unix_get_fd(io);
 
+	if (isodata->pa_bind) {
+		addr = malloc(sizeof(*addr) + sizeof(*addr->iso_bc));
+		memset(addr, 0, sizeof(*addr) + sizeof(*addr->iso_bc));
+		addr->iso_family = AF_BLUETOOTH;
+
+		addr->iso_bc->bc_num_bis = 1;
+		addr->iso_bc->bc_bis[0] = 1;
+
+		if (bind(sk, (struct sockaddr *) addr, sizeof(*addr) +
+						sizeof(*addr->iso_bc)) < 0) {
+			tester_warn("bind: %s (%d)", strerror(errno), errno);
+			free(addr);
+			return false;
+		}
+
+		free(addr);
+	}
+
 	memset(&pfd, 0, sizeof(pfd));
 	pfd.fd = sk;
 	pfd.events = POLLOUT;
@@ -2405,14 +2436,12 @@ static bool iso_defer_accept(struct test_data *data, GIOChannel *io)
 
 	data->io = io;
 
-	if (isodata->bcast) {
+	if (isodata->bcast)
 		data->io_id[0] = g_io_add_watch(io, G_IO_IN,
 					iso_accept_cb, NULL);
-		data->step++;
-	} else {
+	else
 		data->io_id[0] = g_io_add_watch(io, G_IO_OUT,
 					iso_connect_cb, NULL);
-	}
 
 	return true;
 }
@@ -2445,20 +2474,10 @@ static gboolean iso_accept_cb(GIOChannel *io, GIOCondition cond,
 		}
 
 		if (isodata->bcast) {
-			if (data->step > 1)
-				data->step--;
-			else
-				data->step++;
-
 			iso_connect(io, cond, user_data);
 
 			if (!data->step)
 				return false;
-
-			if (!isodata->bcast_defer_accept) {
-				tester_test_passed();
-				return false;
-			}
 		}
 
 		if (!iso_defer_accept(data, io)) {
@@ -2746,6 +2765,15 @@ static void test_bcast_recv(const void *test_data)
 	setup_listen(data, 0, iso_accept_cb);
 }
 
+static void test_bcast_recv_defer(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	data->step = 1;
+
+	setup_listen(data, 0, iso_accept_cb);
+}
+
 static void test_connect2_suspend(const void *test_data)
 {
 	test_connect2(test_data);
@@ -3065,11 +3093,15 @@ int main(int argc, char *argv[])
 	test_iso("ISO Broadcaster Receiver Defer - Success",
 						&bcast_16_2_1_recv_defer,
 						setup_powered,
-						test_bcast_recv);
+						test_bcast_recv_defer);
 	test_iso("ISO Broadcaster Receiver Defer No BIS - Success",
 						&bcast_16_2_1_recv_defer_no_bis,
 						setup_powered,
 						test_bcast_recv);
+	test_iso("ISO Broadcaster Receiver Defer PA Bind - Success",
+					&bcast_16_2_1_recv_defer_pa_bind,
+					setup_powered,
+					test_bcast_recv_defer);
 
 	test_iso("ISO Broadcaster AC 12 - Success", &bcast_ac_12, setup_powered,
 							test_bcast);
-- 
2.39.2

