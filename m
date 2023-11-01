Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9CBC4167D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Nov 2023 15:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbjKAPbl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Nov 2023 11:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbjKAPbk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Nov 2023 11:31:40 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D457811B
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Nov 2023 08:31:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iyf07NCealippFito8QDzGnOsE+YU3L6iW9tcjDnGtIsOtlRMfLg8r4ovR3sHjt9LLVKxM+G4d/mt/KPfyW4kILVOMC/6viEgfh3ORg1tGFJ8zdyFoTZqz9vV+yV6SzqGdbcpjk+NUodhdczvZwAfg0oSLZvakDRV23kx7t3DJhq8/RubyfHXMK9SVEtSx7ed6YhamLdWIMZ1OM7k32iiwvObX2MZ+zWKqitKfPHaGw5hu6A4LgZj+BePoABXZbf7Pp4mZDCmRRZWfXMXQDPGmzr7OyP8Heeu0tdnccePYhWNkmuKxwp2Grl3d8h04UKsQtq11Dlr6lUqGuyH8oJFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZtqAv+sSidZ21jw4s2ezgizbscRDUoKLVo5ZTCQ0fw=;
 b=hoM582/OWnp2OKc4oSfqozpfXEyQ9QCSVHGb1b4qVckwB9mD4behdvp4zhtIa3Gf3dDazbZhq7n+jyGqNfKChyNHERNzSL7yAudQkEGN4fe8ifuiETaKsFw1vW0gxhXk+xWVH010eCA2RHZV+sZxCTz9bKBseG+Xj4TBuoar4x6XMBTAmeH9ScfQIqCEUyN4OGdPir3fKHaTweKIvHei8tMl4ma3Z8yD6iXgxUIjd+TnJNvp3XpHE8qk+3oClE/rKrttsByVyz3um7lHRkFd9kCTVWmLNFJHKayYPcRMjxJZM5qs81Kl//NGjVOz/y25BHP7wf0Fup/pcnY5yp0Q1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZtqAv+sSidZ21jw4s2ezgizbscRDUoKLVo5ZTCQ0fw=;
 b=ocBiKlGGawUzNhgS2qxzPC4hdlQMb1j51Jd//I2hpErvSuAnWOWpwgSuWevfEcyUfxMTxuJqv0ijcI3LF/3KjRK5UjfNzC/pz6Yex5FSlVJ5RtxA+BTDdvpPnWhuC5v3QUtiiesYgrforYgQarAWrYm8h0dMUVUbYbdi7/Pw5H0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB9191.eurprd04.prod.outlook.com (2603:10a6:20b:44e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 15:31:29 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::9294:43e2:390:2b6d]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::9294:43e2:390:2b6d%4]) with mapi id 15.20.6954.017; Wed, 1 Nov 2023
 15:31:29 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/1] iso-tester: Add test for bcast AC 13 reconnect
Date:   Wed,  1 Nov 2023 17:31:22 +0200
Message-Id: <20231101153122.5618-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231101153122.5618-1-iulia.tanasescu@nxp.com>
References: <20231101153122.5618-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0107.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::36) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB9191:EE_
X-MS-Office365-Filtering-Correlation-Id: 35186193-4552-41e2-d579-08dbdaef9e8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5gsrQMNRZi00ULhqvi2acqS4mz+1zilcDgLU/OrlId+pkW8fEdj7K0c+a4SLhogaZvmZR36B2gp5oLoWCOl3Wy3d6raWyyfDNAB08KQIQQ1+1L+3ShQ+4pHxNyTuwGD6kIaE1i78zXcfSOUH70qkrYHz+1heVEk/mN6kSO7rjOXCim+61oa8foW8kzgtL6TVi4pN1VDeWe2Wl/wFc5fOdCm7X5r2ewZKPEgoL/tJjIP7mr15u/XHWoxfzioI0B363lVw7fbR6dve/GXMIJVeFktJLlGBdgMhQXRrpJuX+umVoHwRGrm/+6RncFP8m+giIIkgnHWt6cVxfRsXEoVq0qFT6TP2dnvDzxEWYPoXZrtm+uR6pXlX8M8q41gV2K9GcJOKflnA19H7ptbqpj1xemEZ+SfRsgZ0wWkqK6fymReErA6BTH7IBCUHqjg+BmUgcsoaQz6qiKy6D2Z66u+sFbaFTOETtIIvZSKIKrqSgpUMVlkB1iturU9dHa4hltzSu5lvPrd65RjKX84wIN0GQqZrgh/5gYGavRWypNhVbpiw9CdvcHYCo3HH8ckqACDQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(396003)(376002)(366004)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(86362001)(38100700002)(6666004)(83380400001)(5660300002)(6512007)(6506007)(36756003)(41300700001)(2906002)(1076003)(478600001)(6486002)(66946007)(6916009)(66556008)(66476007)(316002)(2616005)(26005)(8676002)(44832011)(8936002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9NPDVIbR8wW6fEvbHM0BjLksENrCsZSwzNJUlkKh9orFLH/c8Pl1NMpKySbP?=
 =?us-ascii?Q?98rypRTsSzoJbYvtvi+Yt6TumebVK5/H2+cHvkNO2nWDmVO9oGvD5bzqBeo3?=
 =?us-ascii?Q?fTJ/qXzbYeFLd3/zLK10DijXBz9c7DcuosM+3LJ4sSTeZNkDmqmUwwpWcYfI?=
 =?us-ascii?Q?EMSuwlHC/5UjyEVvI2wyB7wL3EM7YK02j0CJwhIKZgZgElt78nCmLXXSCtJx?=
 =?us-ascii?Q?AhZG54TctR4z3AylhFyvM2fjssk5vIi8TVboqGJml+WwrGYlsR7Y8kltJ6lZ?=
 =?us-ascii?Q?mFkMMcB4lasd/hzzFxtNceUyC8gjNpxJLi1/6IHSOFB3D0hmLBxaDJ5kbUBp?=
 =?us-ascii?Q?imndzsjZkXiJQID9DOYT5OHBQKF6QrHfxvuM7HvP1jKx8tdFxzHxt0G339Rt?=
 =?us-ascii?Q?I+OLM9Si7FhFtZTIpGrrzWgOSB6x9xKcEizHBjQqFn36neBOyukVYQdvxHIh?=
 =?us-ascii?Q?fBL4b3CYAxziN6z4NaRv9MafM6/MJCI7eK3pyJzUVocZup6rPV9rEasLsoBG?=
 =?us-ascii?Q?OT0L8NXQvuYPu9q87HXKpjSimQwmm1LcjyF+cHRhfxH1Mu7pKkB3ld0+Cdzv?=
 =?us-ascii?Q?/e1nFhirnH1Ncx1w64VbgolA4gA1trEgDWUBzIuFgXS1yT4sOj2PeGy+qA76?=
 =?us-ascii?Q?EGTglHbeL7BAw8Dz7KhNBYYYEdD3rvq/8QdTg5H4CSWN6pSxo/4BisQLxk0x?=
 =?us-ascii?Q?sbqvoRU1gK3i9ba6Kt87C+mzSegRgjevt/TnfRE7NlB9HV7J/+Wd/Xl9BLKI?=
 =?us-ascii?Q?oarTf/u8EQkBHYPQrMyTuwq4ah8sezuMCXzQaUMOPhEB7CAlVVY/K15YsS2I?=
 =?us-ascii?Q?YN62Tw2uwGJRZPBpl/V7yUc4ApeNf1HVJv5lwhGer1svwC0AU2++61rDrYV/?=
 =?us-ascii?Q?eRLR+gtBzcT7HetC/cmP1wZzynHrGexfVZphCXQq58UlxOZSD6Y0xm/ZjwHw?=
 =?us-ascii?Q?baDkBpBThxlry+ATgSEYOcibPQPynIXB8RJHKaK5k2UwXIwXaKvlMXeWvqwN?=
 =?us-ascii?Q?MoWKED+vWts/z4DEZysGyvznpmxQPTOCpkyPB8K0AIAsQRujCVzI/Xrk3m9W?=
 =?us-ascii?Q?5ADVfnMGS780zHBNq+IyGAwgGggK+YTej/N37nlcBnj7mRkInIgTzrGQKumy?=
 =?us-ascii?Q?eNPWCL4AW4ltmsLCIKcpkvctGz/qKaYS+GcnpnJlKjPGJ2R48u0yA+5lzTpg?=
 =?us-ascii?Q?Q4JNauNRt2AGkV/pe6Cf1+jPEuzshDcpLZwDdD3yNb2FAiuxQmK/90SJ6sGf?=
 =?us-ascii?Q?RamGfo7ez/lS/YoYTGduZKrA81v6MeQvTPOGV++RkTrLrhZCK4ewMLcdgE1O?=
 =?us-ascii?Q?7KfZw97in4FXpURq4i19j475lxtZwp+q4pXc4Z/PL/XGHLrV9226K8SPMYO1?=
 =?us-ascii?Q?+JP3M17um9pLOmYiufls+0TPCkIVttGTxma29Z925iPPOIzSvUsY+Jfn5y4v?=
 =?us-ascii?Q?nTO7APgLAPPSu0LIdX6XGHayAJbzHAiUUNFlFCRU4bWI4TVTIvrGASlbQsIc?=
 =?us-ascii?Q?g/1HytcQRe6gB3Ow6oaKwq6b1pgWURCWBKoOUUNvd94aRO/sVxYTBCi2H3R9?=
 =?us-ascii?Q?DgEvR+mLYhORpa7OFsmjjZj/Ueb0h/uNmwE3kexOUDirxFZgQ8ZqmTCOBWjo?=
 =?us-ascii?Q?Hg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35186193-4552-41e2-d579-08dbdaef9e8a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 15:31:29.6589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dmclvhdoLa/NlEAdvFKYR6xu3i+oEvaUv4nlP3P9NbHvnK2WlXmGShXhTP084sMz2u2FpGS0YTk4mh5PD+rRsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9191
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds a test for Broadcast AC 13 reconnect:

ISO Broadcaster AC 13 Reconnect - Success

---
 tools/iso-tester.c | 60 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 6 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index ae98af775..9fccbaa80 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -32,6 +32,7 @@
 #include "src/shared/tester.h"
 #include "src/shared/mgmt.h"
 #include "src/shared/util.h"
+#include "src/shared/queue.h"
 
 #define QOS_IO(_interval, _latency, _sdu, _phy, _rtn) \
 { \
@@ -388,7 +389,7 @@ struct test_data {
 	uint8_t accept_reason;
 	uint16_t handle;
 	uint16_t acl_handle;
-	GIOChannel *io;
+	struct queue *io_queue;
 	unsigned int io_id[2];
 	uint8_t client_num;
 	int step;
@@ -592,12 +593,19 @@ static void test_post_teardown(const void *test_data)
 	data->hciemu = NULL;
 }
 
+static void io_free(void *data)
+{
+	GIOChannel *io = data;
+
+	g_io_channel_unref(io);
+}
+
 static void test_data_free(void *test_data)
 {
 	struct test_data *data = test_data;
 
-	if (data->io)
-		g_io_channel_unref(data->io);
+	if (data->io_queue)
+		queue_destroy(data->io_queue, io_free);
 
 	if (data->io_id[0] > 0)
 		g_source_remove(data->io_id[0]);
@@ -1181,6 +1189,16 @@ static const struct iso_client_data bcast_ac_13_1_1 = {
 	.base_len = sizeof(base_lc3_ac_13),
 };
 
+static const struct iso_client_data bcast_ac_13_1_1_reconn = {
+	.qos = BCAST_AC_13_1_1,
+	.expect_err = 0,
+	.bcast = true,
+	.mconn = true,
+	.base = base_lc3_ac_13,
+	.base_len = sizeof(base_lc3_ac_13),
+	.disconnect = true,
+};
+
 static const struct iso_client_data bcast_ac_13_1 = {
 	.qos = BCAST_AC_13_1,
 	.expect_err = 0,
@@ -1911,10 +1929,14 @@ static gboolean iso_disconnected(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
 	struct test_data *data = user_data;
+	const struct iso_client_data *isodata = data->test_data;
 
 	data->io_id[0] = 0;
 
-	if ((cond & G_IO_HUP) && !data->handle) {
+	if (cond & G_IO_HUP) {
+		if (!isodata->bcast && data->handle)
+			tester_test_failed();
+
 		tester_print("Successfully disconnected");
 
 		if (data->reconnect) {
@@ -2177,7 +2199,15 @@ static void setup_connect_many(struct test_data *data, uint8_t n, uint8_t *num,
 		data->io_id[num[i]] = g_io_add_watch(io, G_IO_OUT, func[i],
 									NULL);
 
-		g_io_channel_unref(io);
+		if (!isodata->bcast || !data->reconnect)
+			g_io_channel_unref(io);
+		else if (data->io_queue)
+			/* For the broadcast reconnect scenario, do not
+			 * unref channel here, to avoid closing the
+			 * socket. All queued channels will be closed
+			 * by test_data_free.
+			 */
+			queue_push_tail(data->io_queue, io);
 
 		tester_print("Connect %d in progress", num[i]);
 
@@ -2434,7 +2464,9 @@ static bool iso_defer_accept(struct test_data *data, GIOChannel *io)
 
 	tester_print("Accept deferred setup");
 
-	data->io = io;
+	data->io_queue = queue_new();
+	if (data->io_queue)
+		queue_push_tail(data->io_queue, io);
 
 	if (isodata->bcast)
 		data->io_id[0] = g_io_add_watch(io, G_IO_IN,
@@ -2758,6 +2790,18 @@ static void test_bcast2(const void *test_data)
 	setup_connect_many(data, 2, num, funcs);
 }
 
+static void test_bcast2_reconn(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	uint8_t num[2] = {0, 1};
+	GIOFunc funcs[2] = {iso_connect_cb, iso_connect2_cb};
+
+	data->io_queue = queue_new();
+
+	data->reconnect = true;
+	setup_connect_many(data, 2, num, funcs);
+}
+
 static void test_bcast_recv(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -3114,6 +3158,10 @@ int main(int argc, char *argv[])
 	test_iso("ISO Broadcaster AC 13 BIG 0x01 - Success", &bcast_ac_13_1,
 						setup_powered, test_bcast2);
 
+	test_iso("ISO Broadcaster AC 13 Reconnect - Success",
+					&bcast_ac_13_1_1_reconn, setup_powered,
+					test_bcast2_reconn);
+
 	test_iso("ISO Broadcaster AC 14 - Success", &bcast_ac_14, setup_powered,
 							test_bcast);
 
-- 
2.39.2

