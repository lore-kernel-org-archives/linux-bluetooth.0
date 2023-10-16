Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D56CDB465
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Oct 2023 15:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbjJPPsF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Oct 2023 11:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbjJPPsE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Oct 2023 11:48:04 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2050.outbound.protection.outlook.com [40.107.14.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82577F1
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Oct 2023 08:48:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYJh6YO063fZij9F5M7iFXamfFNh/n5tkH1a6xO/cYMC/3yk8vHBONzGFrf83L38L8wq8VcOvAafzgE7F5zjJuZuckf2yi5kFuAfGmNqpL8MeGhnB2yV6aGtaf/j7pOmsi8BKYqA4mv1/+eFFhXGJp9idhFlOgErd1WlzBI/M2y+25vF1qdbU2VeJpcI4UyrXvpLcjAyY0oo6kd85cLFPDQigtst8Tj8XcKP6CgmLdlanyAmhWLLhQsG23HraAk092yrVWbkgQag8A7gIcBklGwd/NLqstu9CDMmms+Uaw413PRJ4ZR9Xybdx8JcMx9fRiL1MFHCY67FdRucAf6Egw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJNGNakPgKbzK2yo7V4nNBaZoVSSWQFqHHZbHtaZxAk=;
 b=dDorTGBuN1+Dahi930aHSyKb7w6aOyrzrzMIES7LsYnIk7V0PJQE2htKRZn4c90ssQXYf2XdOoe2C0CPEPfMerD/9DR+xjoHR31UKg5UBolYNuJGndFA/to/onvgPc3ldrOoSm2B6ryTHwNE/ZWUHXjJNbUkg/GQJCY5w1adX/mUduqei0njXDgcbJyFjic53SWb333AL9rQIy1uYQbPeoUhv6je1bNFlAi0pGmoKn77VSHEOt+uUV/hB3y8rCFZJBoMqMLgt6JPdwzhpJcKwpt+LMdSjNMFwi+bhzHNpRyB/m2+TAnjihDFGbIU5+CC4rp1PZpZC49yDgLyF+X9UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJNGNakPgKbzK2yo7V4nNBaZoVSSWQFqHHZbHtaZxAk=;
 b=H7apPC6x8ZK8YGgX/bqRtc+4XF2YJRUmYJzn3FvCIed3qaoPqEZ4aGr0W1b196BDIoOZAgfL5wHNZLFIkpp74mbCu90SQMsPqp4zxyDBOqc/3uWNAuLlSZWnyv7wSG2JQFZypKX7hcx5lVRW+KtCq5QCCAIx6WDC8x+Sp2IhF4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VE1PR04MB7423.eurprd04.prod.outlook.com (2603:10a6:800:1a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 15:48:00 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6863.046; Mon, 16 Oct 2023
 15:48:00 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/1] iso-tester: Add test for bcast receiver PA bind
Date:   Mon, 16 Oct 2023 18:47:49 +0300
Message-Id: <20231016154749.3016-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016154749.3016-1-iulia.tanasescu@nxp.com>
References: <20231016154749.3016-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0502CA0005.eurprd05.prod.outlook.com
 (2603:10a6:803:1::18) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VE1PR04MB7423:EE_
X-MS-Office365-Filtering-Correlation-Id: 499f6747-40fe-4d4e-359c-08dbce5f4658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FNIZ7HF6eq+8Jv2U6EZj2xCFrD4hhe6wbmNEq+vCYQhSdqcZwjqbXo2OBoYPyVD5451TzapGL51IWa5DfHwOgpH4L/LD8L5JKi44HWy2BeKmSJ5jX+cQdjgrnJKXZhVrbbwKTAvDUXVvDER4+t6MrVVXuBzrGtOC8QLnXDZV8Aa1qGMOOsCXcUtJkUiSftB+gL2Fb5kCCQwuHHB6gUeIqQWO2SQCLukhVCwUDsoZ14mXQNm+mamMSQBtc4zpeZlqcLBjGHJeDESGYdPwV0eX/v/pqYrCrIM/pGMhP0SnxK8t9r1y3LK7hNDA0eQjTLLkHy0im8nid0D4i4iGSUofFchbaGhexlByte7ZYlGEtBhfRVWrBjL0HgsY2VxoqKPOwtPpJLk9MFpx4VsiMr6u5pT31B8YjaT+A8CML0FHDst1NLywzpmkh1UpU+R1xNb+IaDbo+hxGHWd8E9UeA4J2OC328Exi2EGNwum5kJ4BSMVqrVtqblglwpATuHrsFaHAvQ4HMFsOHPmG5z/v7GwtE/nsmuf9uWyMwl5XFsO+TjHFgZd3dAqKzWL9g9q/ltI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(36756003)(66946007)(66556008)(6916009)(316002)(66476007)(86362001)(38100700002)(5660300002)(44832011)(8676002)(8936002)(2906002)(41300700001)(6512007)(6666004)(6506007)(4326008)(2616005)(26005)(1076003)(83380400001)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zlr0lhFPwTgFVelXw/CGQ4JpN3lcQgYnJYktBl3eaA5yLT+x+dItKkT76wBW?=
 =?us-ascii?Q?REwRGd+0kzMRfNiRK6tWFZCUUx7wI3o0mq7nO2woAmkQRcm9ZzO9zVmx262t?=
 =?us-ascii?Q?OeROnkZq8Tz6XWc4qGALdbMYgZCGKvp9h27MjxeeYtLlV/RoMTnKwRzMP/5r?=
 =?us-ascii?Q?nJMDX4mg5OBbxE3RZjyNdudn2bcBDXgfwJmYCy+voTf3ljfwdl0xf+Z0ePAp?=
 =?us-ascii?Q?ldeBAsic3E4M19yn8Ix61eIVv0u5uOrw1yQ1dvYpVkjUZb8iBXV+THoX8fcg?=
 =?us-ascii?Q?hnzO+mHAJlzjIadHcWnjTi7M5Z493Rw7Vdi1CDIZgre7FrKhTRiy/S0JFzh3?=
 =?us-ascii?Q?+iiCMpQKztzYpsXAwdQ+XC21DH2mPq4qgkPxUv9P/IIW4L1n61DvcrYmulhy?=
 =?us-ascii?Q?ZKJ+/cVhdmOQhoablApdqPjc+DM7ru9tPCpkV1pCJk39N7oBa34Y2Chlzxvz?=
 =?us-ascii?Q?7ouY63CfNmvmW1n0sFYD4IkSM/M0ZfaJNv9YUzN/8wWp81QYBXypCh96Aivt?=
 =?us-ascii?Q?Qg+3j1idBjq/rG6EGWTHWjc251hM7nOBGhdjkDV11AV9NU58CFgsfoFmdYz7?=
 =?us-ascii?Q?hJrn4QBtZz7S2I2jQeA6CdROGIq0/8gysEFhEJRBESZND/+I07t4nwYryrY+?=
 =?us-ascii?Q?z+7PbbF/tAYS4UXSLduOGqyITjbnKENwsjvkAj+ob0s0kD/x/KsM0RXJs+Na?=
 =?us-ascii?Q?qFix5vycP634dbP6zG2M054NmjBFy9kSvK2zGcMr7es22KIR39xQbhSMcMbO?=
 =?us-ascii?Q?ap41ghZi/VPjyiC2W00dWSPCd/SWZ2RY62jw+KOLMQS2VFYs8OKmJ8/2xb0X?=
 =?us-ascii?Q?4FLu1naeNOiedl+tS1W6qBQXnaKnY2S42bGANw6Qu+9rndSaOpI0gv8oqFwH?=
 =?us-ascii?Q?6MyXWFFNHSwwrtGJp3+0t/5LumhtA5Fk/sZMYKQ6TAt6DucRhbB9Gd0PiLTX?=
 =?us-ascii?Q?+pXRLbRwspPwVLr+4CyXpNNCjQUes2FhexFy263KY7PRZ+3a5qhBhAz77xgM?=
 =?us-ascii?Q?r4iMIJ2fsdfdORZ71TzFXRLoDGKUqGJOXM3P/cFxAJKzcRMoAPKBHYEccceV?=
 =?us-ascii?Q?z+3GM4gEah6PMsQe9etKn1TMOO8nu0KxnUECYxeAWm1q9umwBFyw+AckfyPC?=
 =?us-ascii?Q?hzRPycgIPfmJWt8jFoJhqCuLquU91PZymO3x2i5YsFYi6WV9Amw8Vc34EJwq?=
 =?us-ascii?Q?N6pGtvk8VtKpRUf8EjJigwHoMoRiUL89Gh24SLqWWrbS82N1veFxrUMmQ29/?=
 =?us-ascii?Q?oSjSs6B5FYU1k5FPhFuOIIwAK+20pjo+0HcqRg5tUZAd+ZMUiPScoumQW7hE?=
 =?us-ascii?Q?GXdWEf1hXYikszVbEFLtYVudbLNoN/5H4EuUCmZtpP8XkBMjjkpeNwR8w/1k?=
 =?us-ascii?Q?ffqxQHhvUh0k7P67J5SISfrVRDT/Iq87hIQ4jz/IE9A7FIrwITnt7LvNlVEn?=
 =?us-ascii?Q?AqvOOCofYjz7qJvX7j7PCiCTkccNTP4wHIlevIVEZ95EUiK0cEsHkpLhw26h?=
 =?us-ascii?Q?IDGx/JQ1XDPkjCKMUQzkBnpZZbvZn1zRlpr/X8HOwqo66M/BjpzB5iMX0qbU?=
 =?us-ascii?Q?VY7CJQ7Rj4pksXam9gbqgrsKH04fW88QU/CO50yJvEDPRMkcN8ZT9QVK4khL?=
 =?us-ascii?Q?Xw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 499f6747-40fe-4d4e-359c-08dbce5f4658
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 15:48:00.1910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LoeUyYLUIL9EdhFWrarzUPRu2REOT+JlTRAT87nQRx1UZ8Zpz0xA0nFfeHeD1JCQMZ8se/HBzudXXIhQX63fCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7423
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds a test for binding a Broadcast Receiver to a number of
BISes after PA sync has been established

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

