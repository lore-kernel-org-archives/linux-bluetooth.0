Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7A92136C
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DuUhKQ26"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2071.outbound.protection.outlook.com [40.107.21.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D1F171C
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 07:39:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEtj1MY/kC2RUX9ik8pSSGsmeBYSfJjnCLhPrtpI8CV86jxBsySG7izYajeSTjBc4MmkIkTkOJC0OI3QqNy3GX1uwOZqgFR3G9g7VGPIzfOE0a/F5Ai7e5m8nn9Yokhau8188pbJScGLb1z57f9PqRsAbD6pwixwCj3QXe5nNgpyN9omKuMq2bodE3hoEr+OuA33KwbDe0+qWXd3erQhyJLLc2pDUKAdRxsxou4sUgq87zsKLdYkE4L+ou5DMfpC3iFT+nT45+kfvVZWJnF0XdTesaqzKABJBCVfZ2LZxQc4ZS7Uunt5L5aUl9mM1GVdDOSMh43IMPEtuNtUAe2w1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZtqAv+sSidZ21jw4s2ezgizbscRDUoKLVo5ZTCQ0fw=;
 b=C/UA1mz+siqX2D3YKybyZ0xWL0qAAIOVQUCL79SZAMiOgCyOXKX1sXfsbEmLlD3nvWY6FbCuCqw+RhbsjxFd4x3tB+/S+U/yJlSPN4P3Uvx80Ud2+GACkv9PIqKPohB/a/sufraQSHWillmXClGJ2WUPCm1Wg78RR5a1ulD9kDUgNAq20IB9BYq+qdH82t5x/O2itNB8DZ7TRq4XxLTj8odFX9q4WvUg58Dj7yK1ArjJQkfLiaNlzx4DF3voI6lXGwkv2QWuNyXJi9YDMKYg7kSAgOcT+oyztXm6mSe/mLUqvXYEKThPPgNHF3QFVgK/+fOqqEloSecjNE6x6N8YMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZtqAv+sSidZ21jw4s2ezgizbscRDUoKLVo5ZTCQ0fw=;
 b=DuUhKQ26bh4CDNIPinm2j7sLuIMPbS//r/PO9sMdk47s4HhxAdAhBSbdbEzXMLwHcbgrAupgHGaSI4hHeveB866iKhecGc6DVms8covNg+Y8pQXB8iVk2L5MtKVdv0tu+xnqbTyMGPq/TXZbrVhulpLhPI5wNFoYUEB7EgE2Klg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8498.eurprd04.prod.outlook.com (2603:10a6:20b:341::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.15; Mon, 13 Nov
 2023 15:39:49 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::25a:e1cd:f957:6e7d]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::25a:e1cd:f957:6e7d%3]) with mapi id 15.20.7002.015; Mon, 13 Nov 2023
 15:39:49 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/1] iso-tester: Add test for bcast AC 13 reconnect
Date: Mon, 13 Nov 2023 17:39:42 +0200
Message-Id: <20231113153942.3875-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231113153942.3875-1-iulia.tanasescu@nxp.com>
References: <20231113153942.3875-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0214.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::35) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8498:EE_
X-MS-Office365-Filtering-Correlation-Id: 51d1e62a-b904-4f1d-b91b-08dbe45ec595
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n5zNaVg+mhvk16oRI92xEsM3sctg2iDbz32JFSz7REe0It0OEhMCb8jyyPjjs1XumqYQS+8H1xv78vYaUDNGJ3wo+2eOtH8B1GSYxhqg9+6joR7gCFfrlRSW5JjjSaqb9kBd5u4ydVEalE8qwOvrM6zWogVlf9tbhtFuh1ux3RGUrLO+xRoNkf+Dyso/vMM0NZlq+uTyNw7AcYHrfs/vY5AKq87UP1NP8fuGBCQmYZQKGMXHpATKc3sZ2Vvens8irUtO+AjbyrIV5BEpdYUiQh8Wuiu8zhj12HlMjoH1aBclrc0cpc1U1Av2O6dAo8MUDjE2iy7rq0EgoLQ+TwihWfqKef5pzaQndr8zGZLLnR3cCCbOwKuJePi4LkhVv3LohupJF9R440GKDGN8e5maaXeVlC6XisdRf7SmpXpHZntUPWeH1T29RaFRjcN2QlwKxoG0PvdghO+Leypwn/1KuCFWQgQABy4Y1F5KzX51KfdHs+3Q1G0EUZDihvo4tZ518NQzdz059OoA3B8AuZUKW5kphXD94MwGUksx7HveUSjgViV6J4WswK/N1EEI+WFk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(376002)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6506007)(44832011)(41300700001)(6486002)(478600001)(8676002)(4326008)(8936002)(6666004)(2616005)(5660300002)(6512007)(26005)(1076003)(6916009)(316002)(66476007)(66946007)(66556008)(2906002)(83380400001)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Js7QfvYapCG4sDjP3mGx1vPsfDmxvhbayCa88NBy2HF6sK+4cPAVeSE4UAlj?=
 =?us-ascii?Q?zzP2hfNhBnKq4+tRD9VpaWxBo6WsOkHq/RtCE7wgOWflXKhfVhSdQoMrgXX9?=
 =?us-ascii?Q?TzKpHVZH01MEpd3orYJjTSSnsb5lsUvv8oD/H2gZN3jIvdVSEhExfZvbDT4O?=
 =?us-ascii?Q?jBGO3Ap+EWfllyGk8ffSzy3J+r+34SJIMMxQS0E68UjC7W1rpPF6DY9DpBZh?=
 =?us-ascii?Q?V23PqrqVYNIsKceSMAgWySjvn7Jgiq792H9sg0bGqH5s7RXbaT9STVT263jU?=
 =?us-ascii?Q?1RoMh1JO9d2Y6/IEn3FC3XLJu6kfYoIvVpv+SKv9CSf41+3d3pIJ6BCYZg6u?=
 =?us-ascii?Q?KzSKaY80ENutZE0CTwRns0ZD8Am54PgpwUheg+KElJ4uN+oybGiX14liHXOs?=
 =?us-ascii?Q?To8Nkjpi1ny7J6fZF1Lvf22a7fok6xdUyQfHv/niTQtyFDeTvuV5h+fUKxp+?=
 =?us-ascii?Q?4R9xxiAPDTESsyM3lWBCcZoJO7IgUOXFabZFMg9DpGFCxEQamBPj1IFOQLbN?=
 =?us-ascii?Q?d5tSVyitndUGdL8K5nl0MshBHh5ceT+A0dbssXmC18OxF3rNCkaOvLadCbW8?=
 =?us-ascii?Q?pETu7eFRCGcs93NJwGznVctoi5ZZDG0iVzUJKapWZt6jH1L/nL9D9vintD4q?=
 =?us-ascii?Q?fegJ0C4bLeaQKAd/jDtwdKkN3fRbRggCpsbls1dxR5N6siFbvXCcfPao+TQG?=
 =?us-ascii?Q?5MVeoiV4htTewwHMbMe8dW/G/7Yx2wUmCFNQceXfh6llw/207KPCm73iT+M9?=
 =?us-ascii?Q?om9v6Yo7armOiGRyuB7yfOOtI3V06B50GoBAPDDdfWGw5RvniPSlRsfEgA9K?=
 =?us-ascii?Q?ovnX1Al/7LIvOBctfWQmOEua4sqmS0Lob6Lt6nUp7GcL37GoCR5Qv3As86h8?=
 =?us-ascii?Q?7R2A2Fk0TycPQuFEp/eDNpbdd4to7aBCRT9GOGTMV4ZQM0lpdfV/WXzA67kn?=
 =?us-ascii?Q?j8kkGH497ZefucZxQbf176GG1w5XupYojEP1TVHS5mC7YeBpZH626EA+q0DZ?=
 =?us-ascii?Q?4utriPz9Jl9T2lJPrHSKonsLD9XzCRTJWknOluFJ0TYOnTNSVWHM/ZyLq+wA?=
 =?us-ascii?Q?2s6s5mXE+W+Tx42rgdBXjunqbhRAvczNjHXvFNi2kJwfVfeOExzRKZ2+94t/?=
 =?us-ascii?Q?nAULQJUDO/8EeLGv/A+0VPN26bqRzxR+Vjz/1TZtagcj5uygm+Pb1CpGr2W9?=
 =?us-ascii?Q?rqhMxIIoV9YDPlJuES0Br2ZRLSz/W2OPWFOdI24ccX21pwtjqvHq1Gkex3zm?=
 =?us-ascii?Q?5/huRrfEXTsaHe3w4+GjjfAIw4NeVTyub017ARpt3Me7R4K1Lr9crGHdWudN?=
 =?us-ascii?Q?5WUpWvhqahooi7xcsmOtgjf3UXE4+mdunR1U5YabiacmupcBCytAF09xrzPG?=
 =?us-ascii?Q?pYLOoTZ0txktEh4vNKvmQ3gG2PLUgmXnUeKGHtqJOr2q24ZXiuXCypoRIuWc?=
 =?us-ascii?Q?8qqQ4rRQGPezFP+g4UcyK8VSoUnmENrmF0LAvjeM50rYHE4r02t2JrLNzilu?=
 =?us-ascii?Q?OT9n+2/glQm6JO9Rv4v1I28xPVT+EED4vpc4zeR99+zGLsx1BdvS00D7WJyt?=
 =?us-ascii?Q?MzwbUrTi/EPYWgdxoiBHIc08hu85cknVlj5wWDqelYa12dAgchi9QG8jZRhp?=
 =?us-ascii?Q?uw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d1e62a-b904-4f1d-b91b-08dbe45ec595
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 15:39:49.7195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I7JdUYT5RBSQkr2WoCSI3TvAoHTKUq/RUp7s5SrwFFqW+0Xyg9zwzXWacHKRUeXYBiVUda2lt83CXhHj4cUvSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8498

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

