Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47C2CDB465
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Oct 2023 14:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345862AbjJSOuy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Oct 2023 10:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235429AbjJSOux (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Oct 2023 10:50:53 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2069.outbound.protection.outlook.com [40.107.249.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F9FC2
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Oct 2023 07:50:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlmkhP4+NpeVAe8s1nxEDo6LyDinoECFGROwPjXYhXcqi8k0Smc0iGKJKSECmYJ9pDsKPvzjxpS9lsuDRW4DXV9mrrE4pYOh+sZYivIRfHR+BmJAY1xgZYMqcMcU6y3SdjIhoq0BVVOdONuA8zbgZSjtppHVOG9NmqM/f8hac3jkSG9hcFQ9WWsrIYuFHWugSGN25VOEo1MEzIYCNWcS4626vrjQfn+L14GjANY4uIFxtGSde4mWX7/UIJHTz/P3xKh449Lx/7o8t9kG3qW42Isw3QsjLIfz3oYXhRqSHLc2bCZScim5zg3HCsdaJ5vocBToonTwgs7qi7DSxjnfEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvnN1hBa3lGGW4Yj2fy5IiPakLGOv+uAgut2yrZwiyQ=;
 b=V0iwVxGr14lPARdb5mn5AW73/I9SY+KKiZjErvLUjCQPjRkfPrbkolQ8AGs9LRpAqIR/lfIUxYoDPnchbsEDlW2s/MNOM+xAxMeODs9n/jIY7jQaPJhixjDergJrewablN7v7NMs9u525aqP1qdGdHD9uLeMXBnCRxwwoFRqL1q58NKW8aaRIdTH4fuA1j1n4TRN6/2c3njFaABeT/vEfpf4KRmvMMOlI6s0KmFub059FaevKjOiOseUVNty5vW5r/y3xf024g+/In/lSwx916jqQ9kUrmZbHOKxqyKlzvbwUcElvv1ImcZHI/SlAb8VweWelmZnWum47WAI1d78Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvnN1hBa3lGGW4Yj2fy5IiPakLGOv+uAgut2yrZwiyQ=;
 b=mj3ZHhN3Vq+UsjPdUaGZD23dk61bQCK/DBnDFu+wzKQhNL6HlFsfFxT4eF6QITpDv2WkubRND6zrGE7qMEmobfdF+Gs/had+XrGejyuYyepf5LS3vvLj1P6lNlP7X4iKbPEXOOPqBcQPt7n40fX2VQPmAbgi4pFGXyJf0ZRvLQs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM7PR04MB7142.eurprd04.prod.outlook.com (2603:10a6:20b:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.9; Thu, 19 Oct
 2023 14:50:48 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6933.008; Thu, 19 Oct 2023
 14:50:48 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/1] iso-tester: Add test for bcast receiver PA bind
Date:   Thu, 19 Oct 2023 17:50:37 +0300
Message-Id: <20231019145037.4776-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231019145037.4776-1-iulia.tanasescu@nxp.com>
References: <20231019145037.4776-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P190CA0038.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::9) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM7PR04MB7142:EE_
X-MS-Office365-Filtering-Correlation-Id: 95444e2a-71a7-40e0-665e-08dbd0b2c7fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XHErd+3/YyhA7ANQhQr3Lnp5DvRBXBwrDWviL7e74ha7BgGZNbn3iNUE+2GWHF2WWK+NHAUmo4POFQxQGZen1CGheIQ2QyNV0l4jfU/tk4BvyIB8z/2zWKLdZa2jj3uZW+7GE7A2K01JFvWrgeyVIDz5LMhZ83+R5AzOEgTMqYGm1wVoAwYcT5DMoQ+5JgCYgPVlwnRe08Bok5KvTXy9A/vhmYpcbEHr73vizwetU2F1P4zGAlOfXomvXnI63d8z8Vv+8cpQpcAWib3hovhhSEcOLunviPrl/YvXFaVNDi0pVQ7KyEmTYWa+Ap2uPnusWzCCdehlQ/YOayAmv29QF8eiZEyJioZF+dfkxlVleYRlR0P0FByu5gxdph/Jr3iWsxgW1D/DrnXxNf5EK0qFCBD5Ko4Fgp90X7nDuOTWQMpCT+XciJ212g5iPMf/tk1roA9JU2wktev3HOvHVfF9SLkxxczmgMceEcsHiTx+dCDJeqp1HOLYe1NaiUu8HUaAv5IqAAhjo/iBArP0gZu7XDz+1CTf0DDH4jB3RZhUcO19hW170m7lcovp/O1/SEZu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(376002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(36756003)(2616005)(66476007)(6916009)(66946007)(66556008)(316002)(86362001)(1076003)(38100700002)(83380400001)(6512007)(26005)(6666004)(6506007)(2906002)(8936002)(6486002)(478600001)(44832011)(41300700001)(5660300002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HCxZyBdli7nBe2sPjjmgAGghjQsmpshccn2Jl3UJJTK554/Vyp/f/E8UjtPO?=
 =?us-ascii?Q?P44+3kVePPuAeFhjro9s/ZgB9sUdYjVuXiCBi23vHhfeiwEc2Bq+J6+TTy2k?=
 =?us-ascii?Q?FBn2+w0PsNeY6fxo7HGxMH5l0NeSGSulGhYlv2qybEa1dg+Ig7ervXsd2vX3?=
 =?us-ascii?Q?wTgcIhdnExLB8r7QVaQHPB7h+ZMve7yzJ6OOkRMClJKHzfqusMnRBMCYrziO?=
 =?us-ascii?Q?lDKyW4U/+h7B9kdUr0wq3ccv1WMS6ji0FGz+WRr5KHwiF21eoGCOVsJabuOq?=
 =?us-ascii?Q?3e/KoN1bZvOPsVfbZhGhUcruJ/lDMser40VTGi1sW3x8Ki9tqSbg5PmIzMvf?=
 =?us-ascii?Q?8evwWWN8AIj7oQ9Kk+mp+/HFIKzY0HujSHsXifPjBXnpT3dYVN6TY8mrI1os?=
 =?us-ascii?Q?iN01Ubv7GR/kPQs8hBknJZs8PfdtGxZDqd2shW1hCXCPsvMqKLTNOOVZiu1X?=
 =?us-ascii?Q?hgp9cw3Od4Nlld3QwLR3Hd9Mmp3OED+6v6WswQ3UpifGvXFl9+jF8c3iT3eb?=
 =?us-ascii?Q?JaXSDKjCVWEzrqBFy7WTRccvzaJM6IqMTbs/aBAUefzpiY2b1Zs2bx9OWhB9?=
 =?us-ascii?Q?mRm/s+NKGdnnqMgskiIZ00Tio8ddIvnUC7zoA9LR8WHY1jsz7Mtw7jxU+m5o?=
 =?us-ascii?Q?72q5uQUa04ahd+H/W7AZ+nWdY1yCcTb+qyrRRaPtudKxNOfy0wEeuiXFyS8w?=
 =?us-ascii?Q?yEKu3yDrXwGbbfpfZ5mTz4stTx8eiVu4RHASgz7/tbACc6e3Vv7TARvsV+jY?=
 =?us-ascii?Q?YmXi8/75vY/rdp0d19q5VnKYQNSxo808E7uAZUEJtA9bR3Vnclr/SIB9NJF/?=
 =?us-ascii?Q?6HcPQsvZ9sXDSQyNOH7NgPrklLVYl3/xGbfkepbLKlzkCIV+D3WNcysYlp1m?=
 =?us-ascii?Q?MnkqfOqtUoGYREdu6NuHVTUmLEgqzbqTYPi8ZNa2vC+F1TY9Y5fSMpdJHL99?=
 =?us-ascii?Q?oWKbqmH514XUzSHy/yMW2Xi1xUDl1fJ8FUw0mb87dPnrYOju543v1dtkgfT6?=
 =?us-ascii?Q?Lp2vwUWJ7PYBv2DYyAZXdjULsipBkiD0jOOwSKkbLIFndLPtTziP9avcCzDI?=
 =?us-ascii?Q?+cL0dtZrsuH5Trgc1IAM/X+wuDHX+JCxDIsA81SPxlLj8YtV3y1qv+VaghhM?=
 =?us-ascii?Q?gHhw7fm3IRy+b9yP5vSRk4UqzeQ68KgoBajZEsnWCCOAQielEJEFMiQfAMk7?=
 =?us-ascii?Q?qBSGxOZjcmnoxgweXQijI6j2SvDCTyAQPAVi9l7MtxTqrd7vzsCe7+O/TmiS?=
 =?us-ascii?Q?f6IsQDC/Op+oxzpwFriKDbAhhbFm39mp1Dpr2xc+oC7i+Hmw5uTTZMtUtEJ/?=
 =?us-ascii?Q?NXDNdc7srlBsSjthbPvLgveuKaju2uIoyslEyclWBzI9mpAHviiz4C/40chC?=
 =?us-ascii?Q?YLz7YDSq6WNVTILiXA9rKWhsu+J4m2mnpSNIoS8G/qXkWhEcYpxBMFZFKTB7?=
 =?us-ascii?Q?LWqcqgWlGDZRioLNbFNQDg3nS1Ajo2ktj2h+zgqgYBACqDn85vRQSgR2J0iz?=
 =?us-ascii?Q?kLF0F7Ie0Cg+sSaLZhzZxZXTNKFKtjhzPSDALmSscqO812boKUkzItUM7kgU?=
 =?us-ascii?Q?Mw8j+mbCXlM+/Qt9o7AMzcBSw9CmtCfid0cVfwpzrCGJUpuUQt4vgcwUhk06?=
 =?us-ascii?Q?Tw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95444e2a-71a7-40e0-665e-08dbd0b2c7fb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 14:50:48.1953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zKoi3G6IHxsHzI2o83vRe0bwVe/ALXLPYXhjPGwhvRFgaANSAeLBZSlLxmbynneMy+97pAd1sJp7xWUczDO83Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7142
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

