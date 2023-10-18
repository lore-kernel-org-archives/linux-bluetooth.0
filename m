Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881B1CDB483
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Oct 2023 14:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbjJROhi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Oct 2023 10:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235251AbjJROh0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Oct 2023 10:37:26 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2043.outbound.protection.outlook.com [40.107.6.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56D82D5B
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Oct 2023 07:36:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUATnRUMRZ0GxWqipEpnh7I1llaiTVivAg5lpAsMPcdafmtLcD+3RfAlT92J6eUqIVXAQsf/RbTr0pFcLFo7JACFArlvVjoybytBuY+0IdsNQPo9jAvJS2XgHQkdSbw08uYLY/MIsqvdR7cAkqnNsgctCCCiT3nCo+xnFSimUgH7TqWe1Npzhax5JKgqU6dyDW+SbnfoG4cAktvpNAVsmGj420kIgeECWp+Y2xUlrvRsStoWqjBEgD0nsOt6OmaEU1IXlh+NzLMzai0JcztxhYmnu/bZkhZgmrsRZVH2KAxPhMzRZOu7HtdxijG2OjGRu97Drw9BvVraRsvXYZQWiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvnN1hBa3lGGW4Yj2fy5IiPakLGOv+uAgut2yrZwiyQ=;
 b=IaUSFUF1NSFoWPeegR6ma0tGZUNUPXp04mwrs4rUHS9rcd/T575Dm0p5sVCeOdMsETAMDa2oydc92zsM24jdrG0fJ5TJScA8RI+DdS3DxOCC+K30KDO1Sk3FWYhIi7JvYhadVx/h+EiNPJrpWTEmj3xJWDWd0JkKJ2J7hiovIhrlHrQfdFVe6IsAFon3A6eeRt9DbFiTscKjZ+xoLpq+9HBTWwBec8dAAcBt2DNwkVG+dIckLEIjIvmL16sLzfe+wlCYs0EzeTS8u+uWfJZObuH6blj/qHYIPQ0AP+fYye9FBYMjRFvdet5kfnUKycZJPsxuVCijVwAZ/SIMXgSOTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvnN1hBa3lGGW4Yj2fy5IiPakLGOv+uAgut2yrZwiyQ=;
 b=kBI0LNirecQhwz9RmawfHvUTY+ebZvrUw7QWddXBt1Ne7HmzlEjDIhCJFD3EGsNTCuePC8MGvdqOMcIQ+TJpP9k0DSIWm+boeIeh48jpezbOJQa45v3Cr6+e8K35QLR4XBLUZQ6DWjJYFecw8AqQ9HNBiv0z8+jpzoDXGhENENU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DBAPR04MB7270.eurprd04.prod.outlook.com (2603:10a6:10:1af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.7; Wed, 18 Oct
 2023 14:36:15 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 14:36:15 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/1] iso-tester: Add test for bcast receiver PA bind
Date:   Wed, 18 Oct 2023 17:36:04 +0300
Message-Id: <20231018143604.3484-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231018143604.3484-1-iulia.tanasescu@nxp.com>
References: <20231018143604.3484-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0069.eurprd04.prod.outlook.com
 (2603:10a6:802:2::40) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DBAPR04MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: f5a5f644-7434-4219-b6f8-08dbcfe79591
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ztCGiQnotLtmezkcgtdJE3HLqlVnvRPMBUiDAXsDIFxD50qxsrdsDKGx3U7vWsAErePPiLlMgDesiJN2xPEuAdZi3hWXJtuskb2lJd59fCMY/zFQhZdwFK+H+ccQEDjv2uUvD0ESEFrwdOwNk9Wo+fVQMyM//zHY1wjUWg7DcIzaw6JWIbIo/s5JbF/w7QNmFeA2rKFX8qJtVJDXlDpRAn2/otAUca9sdj1W16p52wS3x8yL3QrYuxakycRHeVVry6WKvR9TwDcd+45kHgYunT5yKtzHKE3J2lyFjI9YnbqSUYKdc1FJ16y/xflzGI34qWvJaKD+8AUTHd+PjyQv0jiKT1IbJ7Cf+UxRXFFioU7NAW0guOrwD01IeJ67mj/C7OwKYVK1oUbiGI2o6tBKqQ31RH6PmRDHaFjlKM9EkotXE4h7tf5UJ2HIfPJUmaat3Afcnhx/+rP3s1Yv+9/SFimaYGj7HrGygE0yUMNacv0AHAahXV5ZhNg+y6eq/zAiKfjNAHWHvn2jKZYBvcyU+tzzXOYseRNjvEQHB6iCsS+eoSF/Y9WVeLmNJw9feZPK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2906002)(44832011)(5660300002)(36756003)(8936002)(86362001)(8676002)(4326008)(83380400001)(38100700002)(26005)(1076003)(2616005)(6506007)(6666004)(316002)(478600001)(6916009)(6512007)(6486002)(66476007)(41300700001)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vuxpdMeSk8JvNNLNIb5u4kijJKggjlZeCPaB5xlWv+o1eMQMXGIeEMT76wcV?=
 =?us-ascii?Q?zHtEdvqln59lvvOoa3xk7eyqgJ+PyAVRnhQb7/aiBtIYbKXEd1/sa3MnrM8c?=
 =?us-ascii?Q?qXsPjrxJzDIoBPqHRKOv7cYSuKo81YmgnJ1pHRWFOwajsr+8FgDYeYlQBh5D?=
 =?us-ascii?Q?qT3RZQOHB3gl60ZsE1/QNpkzhJ3oUOUJj/zumv1G0mnigL8QzgVBWFUnPmYy?=
 =?us-ascii?Q?kR3Jx5xcufB8PfPDoOlW1yfB54KusDDqVDmgri++IZdFN2W0KjEXHN7ZMg5b?=
 =?us-ascii?Q?2pOv36+IR2B3knuxG8JUQxGWvIaOAwxEmFSwMScWyxyi4BNc+yhX+M0xd+Tr?=
 =?us-ascii?Q?qkqcQArfnnozEjXTvcdf+bnJY9aKoaMU86yO6LCHtwMmbYePHuWV66MFwIny?=
 =?us-ascii?Q?Ozq1IF/s46+jjrhnFODtSB5rWJUJrLfJQaaVaowogF9zhGvcit9R7leolZsj?=
 =?us-ascii?Q?yILDz1n9yhZdz7pFl6pFc+cOTAIsrTiphObRkECO/6PTKvrHIJMNj9/Gh7Tq?=
 =?us-ascii?Q?mKjVyH0BnYU2oH9+nOlUxsGz9nvssSiatSVIChYKGDsma0OTeLQUlDuOzUhG?=
 =?us-ascii?Q?khwosPMYjlik3NNgQFhS52IkM9RTxBtlvgpgoxW2lNZP8iDNl+NjT02P/vb7?=
 =?us-ascii?Q?llMren4DVaJdovbfrYjMXGFA5WbT6M6vzgbDgX0VeOkWFEwXho/VttTkJr/0?=
 =?us-ascii?Q?WLx3QvYy7AYWMiMesPhuCnwo+AdRWvhz9NYuOJd8ilP8O8tBgW/+zbKLZnJ+?=
 =?us-ascii?Q?FdAhJaSEiul6/N3xVkUHeBT1DMBBBESTP2zAxBih2L3dUdncFl66lL1BvPPG?=
 =?us-ascii?Q?DA5GIrxNWWuMQMU4V4AnFDHpJf1I76X/KOKDQfsanCcOG2mFVuOvwHEfwl9i?=
 =?us-ascii?Q?n3BRREWW9wuGAMuvIXmGjuPYPjkbz2ygg9sb2kot+8noz/2vCksC6xRkwyBC?=
 =?us-ascii?Q?IHmkMMhPxHAKtktjJT2O2rIfGAiq00otrjxMhSoyOuYPQ4YbzJJPVRyIjxSY?=
 =?us-ascii?Q?1VAOpEB5BLBJ4NF06hTVpSIr4nixje+/MleRfjdOBC3MtPDOEM6t30xgBr87?=
 =?us-ascii?Q?EIK5GOCKnG/R8a3U+tGSMqMYlwWVrsKHyqbof/t5ZPzmXVMZFcrOhr0Bl2bh?=
 =?us-ascii?Q?3Mu9iCHoZTwyGR2KMPoFBMNKEN4QvtrCoNqCFsBKF1Y6UkWNs2bsMWDbuEzC?=
 =?us-ascii?Q?2C0U4EB5dUVD6dF0ejD06X4WsEgjyvhrARQKXAs6k0FV/B8z86t/W0QHEDRr?=
 =?us-ascii?Q?UAga216kv7uK+oDzUxSaoL2PavLEELLOnVhZgpp76yAbcXs+jBqfUPAbZjOy?=
 =?us-ascii?Q?Wfv/fDQwqJjPftfm9ShfpfYUDLbLgBjExDW5+eoNflnPOopS/hs84M1shgW1?=
 =?us-ascii?Q?bE3zLRkIqqC0aVj9ybdAYWp3+wqHbf9N24VT7Im/D+UyjvvDVqzKZ8nBQ/ux?=
 =?us-ascii?Q?Oumhk/bfeGXtE5vRTSF3Qv2jwHxNjoi8OIDbqsYZQ62Rkx0COEdz8SAK1nZj?=
 =?us-ascii?Q?HleSW+s3MBvWQUptJ1bdLi1LZz/siDcokGiTtVz6yRlu0aL4d8ky2OEAGGMl?=
 =?us-ascii?Q?y4MK2J/9LOfDCmGGOtyHGhdTjy+rT8Rw+0PDzfjpii49DIJOdQXtCMQdydxi?=
 =?us-ascii?Q?hA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a5f644-7434-4219-b6f8-08dbcfe79591
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 14:36:15.7700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3Q+ZAulzWnwN5tnODy9cD+0ikaoPNJAK0S/EL0b2PcnmhpxeQwoKTBjfY9k4yDR1v0AtsTxh/chshPoSATaCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7270
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

