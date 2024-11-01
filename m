Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2044.outbound.protection.outlook.com [40.107.105.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AAD156F55
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 08:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730449923; cv=fail; b=YlytKgG4FrnnvBh5WR7VsVhmjGHX0yF4mHp1O1P2BrLcw9/beAEmFfiBM2WzlTm6L4mxu5solHPCGXuNzRVRxB1eBGsgadDvvGYVLBwIfGXhYKMbowHR2GuJIrE6jh0dtbffGrCLG7vglPgRnDhVsUxgS7hssNrxQD2FYN5Zgdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730449923; c=relaxed/simple;
	bh=YVy5MLuLVhUzKTXU36Bp+w106pOsgzGfjnGsUxRCq08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GV3Byt4tHo0LHnjKbaielzLPEtC2mP4qlgrU6jJ93n2Aj6YFomDod+aR4LteRfqXjncz+IKep77oHT7ha19gtjVe7NCj7xm9GUEcKRnRb7BBpTmZTuMKq6EieBjjfMR2lzKJ+cA2GYGqX62a13skBzBBWlU+tesbITpU6/ZhU84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nDyCmnX/; arc=fail smtp.client-ip=40.107.105.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nDyCmnX/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X++whTqS7ibh4M3BC8GNn558/anXCL3RnhbmZWCF5TTL8l5jffLR7HTehgPo/kiazSTTJBjbMOjnQyoKM/und3jQYtd5rJ+/yR7Cna/PLY7aaHgBpzvzNbLyRvXGJjdVEwGifDn6516lkeuWJuC9R14GeVBfz2ovMcVN8VBjtvuuQqD5NGQgSpGNIEVRqqoeNgH/liX+mIulMUHKAZVrLprulT1997efy3D5kidwT9NCaVY3AH4870hx/RJBr74VGcRod+0Lx9dWwCiK+9BFU1WKCSUsSO9D4Tg8GjRRCnYA3RQVb7OJ5gBeYXHEkgNKPlUK84P/zcbchTfD9Vk3kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaXdf2MK3De/CLGuNA+GLdZV47xQG9oFCIuWa9HQhJA=;
 b=AgFgtfv2nWYuVt8etw8KQVIWdj6/I6r2CwZgQD+KwzlEbnvbR8ZzEnVQaqFmH8yoEllMcihXIiKk1TiJwKRsRa0oYLaPl9GjBwPk3N2C5SVKuDHESdug1Ik0VU1VHWweVclfkqBP8WASitV0ZkM995ZoWrCbZPuBZHBvb54/CJCzZ8kH6sWnnvsguDsUl7WRUF+SNx7s8TM/jBHJ8eqNKbYhjVpm8cISgZnOYr+IgUIXH+lksZeqsl2Tb5hmwOMNSYPQ2pKZDBBsW4UfZbv96KhzH1MM8sp941YmET24Xk3TlETaiXYP31vcM9n15neE/wtYUY3BRZ6xF4v4niWdEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaXdf2MK3De/CLGuNA+GLdZV47xQG9oFCIuWa9HQhJA=;
 b=nDyCmnX/E/cX2oy/4T45cWbbqaVPUYmlYaBV4YstiGLSlwAVIMyv2jw03UlAbbl8iJ4pRLCgUyLFR7rupiK9pnGOaREQTxqEed4q/N8Wey7Ek8HMauwng4E7Qe/YjGMSYns+Vooc/8PMUfF9NmQyIG0jctssz+fl3GNdsKrbTLbUov3SCCowo8p5fh8GSnb11SSHQWra73oo4oQgXEQzAVZ6VmjwQN/QJH1d2PS/t7AxHlvIqXtNQq4FXlfGe4AkkCWnUB7fwm62+UnAeIEn1QtuhFYM9R3TND3cFMq2cfwQbuS0KuNbJICHXtY39TZ2kDzMn3vpICbue9ktysetYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA2PR04MB10215.eurprd04.prod.outlook.com (2603:10a6:102:409::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 08:31:51 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 08:31:51 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 5/5] iso-tester: Add test for Broadcast Receiver Defer sync to 2 BIGs
Date: Fri,  1 Nov 2024 10:31:19 +0200
Message-ID: <20241101083119.4510-6-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101083119.4510-1-iulia.tanasescu@nxp.com>
References: <20241101083119.4510-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR07CA0033.eurprd07.prod.outlook.com
 (2603:10a6:205:1::46) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA2PR04MB10215:EE_
X-MS-Office365-Filtering-Correlation-Id: 88d2f18d-c9f1-4dbe-f936-08dcfa4fa23d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/c8Bf8lzJOaD5HPF/K1YGpqDTysM4A7v9uVh0zJ4MDHGLSanH7kGLYJB9amR?=
 =?us-ascii?Q?ThnmRSGN1zTUkdKSFjNB7qsJvrXR1x1VypdY6UH0anbga9TioOkYWVxqKhiE?=
 =?us-ascii?Q?xGHRLBlKW+XwsfdSUPMoFQPjQjt5hsHQ4JegX4ehkR/VkU5uJuCs0GTB38SA?=
 =?us-ascii?Q?Rn+40GusnIl9a/tFkvpW0yjCS7CUa9HeVhS4uNOLzumLTOFy1gOQ6ZFe0bBB?=
 =?us-ascii?Q?rS2tnxk5mfega5jXbbawJfWdai3ICp2nw3iimnSUKwB5bFajJHO56LoEZ0o4?=
 =?us-ascii?Q?qvXw35RK8Sf4ix5KUg8QXm94a4U6QhCXZt7+K09gcNfE8IJZLooXlqlH8fDQ?=
 =?us-ascii?Q?sm0IMNlG522H+/tDu/ZmxEHz6nMBEKR565OCLBee5zN4xfwwExcH7qGyJWlq?=
 =?us-ascii?Q?id3dVsq63ewjDU7yn0oFc8f7p4dHCizRnbj482WNXyjyVL9fmvQr2b/lhi7r?=
 =?us-ascii?Q?VpYebtSZLs22l42R/4XSfzJVBHae0z/NSiZ6+Izuj8A0eFMnnRD6MlEBvot4?=
 =?us-ascii?Q?nDJIN3r1+lAfQMnN9auYNHNACa5IQHC48RYBdRwbZU7oumZx2/mdxLfVp3pw?=
 =?us-ascii?Q?Cs5j2C5LKcTpFGvh/UJyOSGeYjolo1+PQhz+0XnCTLyrEx/BZmZvFGxCiMXc?=
 =?us-ascii?Q?wKW4hX6f36hn30V0tI75kl8LQXkpuUOgBsnVngyYDaNLdPxZmKAcQ2kdNadm?=
 =?us-ascii?Q?W5M/gTHQfQNw4M6LP8duYr9rvuP0JvVNLH2z9X4DGna0gADk4LpT0eXlLkxN?=
 =?us-ascii?Q?mPA7GXMNbQj9ryesbgKhP3gZdA3HlXTVwtHnE2LYtxfICjTeDjqE+jXpPVXh?=
 =?us-ascii?Q?aGIA8zdmoorjbfpyIiS5Xy8qL1b6/1+Vpoz4kPiG5v5s75bqd6R38B0uafTe?=
 =?us-ascii?Q?i1t2xJ7IgPMD6bq8pDqLLfWiZbiMltIZs99GkQDF4PEJLqcxcOnWoy2QqaPk?=
 =?us-ascii?Q?Z6RYYphjve5rp4vtSaVMloU0sZExerY/7gnoyHgMngc1nezt/raEIw+usmXq?=
 =?us-ascii?Q?cmKtL5N3PWW61i1HD9mNxWtXaIZsMdZGKr2u+S5tDpHc7SX/1lWcQlqCrKUF?=
 =?us-ascii?Q?N8KkmDChk8HLXz02QYs9klw4nZpcrBRtBY/ey5kw1hHiKowqWlcn8386kDqJ?=
 =?us-ascii?Q?6OPrVMnnPdu8y0JcnNhGimdINw/dEPsI0aHWz8NAI2Grd1Xs34aS6FfGTu4S?=
 =?us-ascii?Q?Cu9KkGyueAyUIcMv2JSAAtlQq1H2HXNJI5YtU/xuYzWZZ/bfuUU7rvYze6cu?=
 =?us-ascii?Q?Xe/7udOEmXu+kgyvdQclRmQHEAkS6zWb43PS6zhNINHjpcoBOT37AaoiNCvV?=
 =?us-ascii?Q?0QEIkb2WI1YVMmgyKhREfZRnOqRrrnZZ+hhqXFyC8N8zeSyRMI6j/BobmKdg?=
 =?us-ascii?Q?UNbGc9I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZPKqQ6ymV7OkY9CdkdZOhwd1rJj35/qfw+2gf1oTOEefq8qo4PaEY3n6//7L?=
 =?us-ascii?Q?ccv+9ZzuEfQ4iyz0ixwsokXEDi/cXd9MhdQEtYZ1fFmRj0fXc4QqUl9erBQ2?=
 =?us-ascii?Q?XRJMC+S+b3R0VDRNULUVED6YIxmecTxf3gT0ZDZwWxx7WVLxJl/YfVo6ZdZb?=
 =?us-ascii?Q?j+PVh08kC4HR+2IvcYoEpB7FZ2dfh/mCrL+iQrutUwH7KtH3jQct+dGT2+to?=
 =?us-ascii?Q?hmx9m2vN8nseu9lGmtPiZOjSZB9CJCXwoyjtqsa+y1N7EMoU0zWGn02zhfCW?=
 =?us-ascii?Q?LzJyEfA8OxkXfnRUwCrWtb+N77R15oKqALki1LQC3Yxa5waI/otogNTm9Qj7?=
 =?us-ascii?Q?0hOA7GPLEJRuWuHurX95oYhoHuwEyNzpxiscCFsoNbDMkUUVlAqzLvK7FSUH?=
 =?us-ascii?Q?XHM5m0ABhOhWGp+ZcMe3AYd+W5kQqAqBESypZZiMnlg+9ozWxJ8YqxFxhXSS?=
 =?us-ascii?Q?sgfTMeWVJ8ECp2xPg02uktQnfmL7FTezaakF4V8qDFYOEh6i005OPfZiPsc3?=
 =?us-ascii?Q?Fi5AuREqa0rhgYVey6RSqqcgc9pbCsR8pazp9kbyxOkrNewP9BqfAHcf5fJ3?=
 =?us-ascii?Q?6SoGzH7gWmonYW4D3NBzOFItqEYJYTWG3UINECM/H0LUip7uG6+RESUyVqAr?=
 =?us-ascii?Q?peUQqTFkkkSRMWLm08G0cUtUiVqulEZwWMD9vi9RBrz14BAa5W03KoX11bNf?=
 =?us-ascii?Q?dNIYP9/dgzjU8k3jqGzv7IAcqxERA5v90lB/bX0S44ZXYKk9eDusYWoWSp8l?=
 =?us-ascii?Q?WNEMbd11iwE350q7A/jfInFr4RUKTVekVVyhT+/2fRTR6sv7E+Nlh1DC8aJb?=
 =?us-ascii?Q?58HC/NPNaLSLYbRnjohLQv0rk6NrisdZjpYTu4sikG+hZauu4MgwxFShIymD?=
 =?us-ascii?Q?j6i/ey/svzb+aXx8WVIQXvzrOiERGE6NA9T+KRLMFS5e+fnMCFB46joK58GN?=
 =?us-ascii?Q?xUfshko2HOyEPCHY3NZrf96vDprlDZ+S9Rwe9SXYfI3BnBqZALYJpeZqZuWe?=
 =?us-ascii?Q?+UxSNIyrC39TRADehuXB3gtLgtr+y9v/gyLvojRwKCAbb96lBi1G7B1n46Uu?=
 =?us-ascii?Q?B1IgORFEC8zjkkKHUE5+nYZsj0MCBSzjuqaNf+VKDD+QbTZp1kooRTuAd8Ji?=
 =?us-ascii?Q?rzrFpQ2g49YOX9owsPAwJHas9XEzMDcZl+JkdD9tHE0GhsEm1JN+6GMP0blW?=
 =?us-ascii?Q?4rcRuogsVW3+7iqqlPyShtT+bVeuwJ1s3VWWtLcams/JbpOkJ6HyqZlge6g1?=
 =?us-ascii?Q?PvfiobD0j4UQA7Xy/SNPJ6pU4Yj8Um7/BL7lOh6M13cx44DFGQSGmsuu7PyH?=
 =?us-ascii?Q?6AHLNmFpsjO+bba8C0TyOTHeqXIr4KCQKSE+IjPnXmK2g/cUBGGwtgNs7SHL?=
 =?us-ascii?Q?NFwQPdRhm3zDPMS7Rz/ki0SQTpHGYiXAv/HbhV5tfVkjIjYwozlgLqbdYMWE?=
 =?us-ascii?Q?G6cIztPXpJOQlVOv3jLvMAGUz3C0zhkLNnWuayvPxVpGs0qf812sfp7RzWxR?=
 =?us-ascii?Q?93afdNWYbumKj0vHbPp/Yx3zEyTd5xuYVKoFsYFU9gWWnyD5tBBTJYeIqQ55?=
 =?us-ascii?Q?rZ8A/1Xb2lG6z5A35tL49GTbhCJIOQmGmAt/Acx4J0rtMR5l7pEYX+dvW+ZG?=
 =?us-ascii?Q?0w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d2f18d-c9f1-4dbe-f936-08dcfa4fa23d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 08:31:51.2412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t07FcjMgDkWfphV3s4Q1MDonBj+VP7PY8HJLU5S+D2xfhbtb93OuIOp4LzGUTUFuklxoFOUioz4TCvCJ9isVRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10215

This adds a new Broadcast Receiver test, for a Broadcast Sink
synchronizing to 2 Broadcasters, using defer setup.

ISO Broadcaster Receiver2 Defer - Success
---
 tools/iso-tester.c | 80 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 61 insertions(+), 19 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 6215fd456..5ec8634ac 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -518,7 +518,8 @@ struct iso_client_data {
 	bool no_poll_errqueue;
 };
 
-typedef bool (*iso_defer_accept_t)(struct test_data *data, GIOChannel *io);
+typedef bool (*iso_defer_accept_t)(struct test_data *data, GIOChannel *io,
+						uint8_t num, GIOFunc func);
 
 static void mgmt_debug(const char *str, void *user_data)
 {
@@ -1446,6 +1447,16 @@ static const struct iso_client_data bcast_16_2_1_recv_defer = {
 	.big = true,
 };
 
+static const struct iso_client_data bcast_16_2_1_recv2_defer = {
+	.qos = QOS_IN_16_2_1,
+	.expect_err = 0,
+	.defer = true,
+	.bcast = true,
+	.server = true,
+	.listen_bind = true,
+	.big = true,
+};
+
 static const struct iso_client_data bcast_16_2_1_recv_defer_no_bis = {
 	.qos = QOS_IN_16_2_1,
 	.expect_err = 0,
@@ -2923,7 +2934,8 @@ static void setup_listen(struct test_data *data, uint8_t num, GIOFunc func)
 	return setup_listen_many(data, 1, &num, &func);
 }
 
-static bool iso_defer_accept_bcast(struct test_data *data, GIOChannel *io)
+static bool iso_defer_accept_bcast(struct test_data *data, GIOChannel *io,
+						uint8_t num, GIOFunc func)
 {
 	int sk;
 	char c;
@@ -2957,17 +2969,20 @@ static bool iso_defer_accept_bcast(struct test_data *data, GIOChannel *io)
 
 	tester_print("Accept deferred setup");
 
-	data->io_queue = queue_new();
+	if (!data->io_queue)
+		data->io_queue = queue_new();
+
 	if (data->io_queue)
 		queue_push_tail(data->io_queue, io);
 
-	data->io_id[0] = g_io_add_watch(io, G_IO_IN,
-				iso_accept_cb, NULL);
+	data->io_id[num] = g_io_add_watch(io, G_IO_IN,
+				func, NULL);
 
 	return true;
 }
 
-static bool iso_defer_accept_ucast(struct test_data *data, GIOChannel *io)
+static bool iso_defer_accept_ucast(struct test_data *data, GIOChannel *io,
+						uint8_t num, GIOFunc func)
 {
 	int sk;
 	char c;
@@ -2997,19 +3012,20 @@ static bool iso_defer_accept_ucast(struct test_data *data, GIOChannel *io)
 	if (data->io_queue)
 		queue_push_tail(data->io_queue, io);
 
-	data->io_id[0] = g_io_add_watch(io, G_IO_OUT,
-				iso_connect_cb, NULL);
+	data->io_id[num] = g_io_add_watch(io, G_IO_OUT,
+				func, NULL);
 
 	return true;
 }
 
 static gboolean iso_accept(GIOChannel *io, GIOCondition cond,
-				gpointer user_data)
+				gpointer user_data, uint8_t num, GIOFunc func)
 {
 	struct test_data *data = tester_get_data();
 	const struct iso_client_data *isodata = data->test_data;
 	int sk, new_sk;
 	gboolean ret;
+	GIOChannel *new_io;
 	iso_defer_accept_t iso_defer_accept = isodata->bcast ?
 						iso_defer_accept_bcast :
 						iso_defer_accept_ucast;
@@ -3022,26 +3038,32 @@ static gboolean iso_accept(GIOChannel *io, GIOCondition cond,
 		return false;
 	}
 
-	io = g_io_channel_unix_new(new_sk);
-	g_io_channel_set_close_on_unref(io, TRUE);
+	new_io = g_io_channel_unix_new(new_sk);
+	g_io_channel_set_close_on_unref(new_io, TRUE);
 
 	if (isodata->defer) {
 		if (isodata->expect_err < 0) {
-			g_io_channel_unref(io);
+			g_io_channel_unref(new_io);
 			tester_test_passed();
 			return false;
 		}
 
 		if (isodata->bcast) {
-			iso_connect(io, cond, user_data);
+			iso_connect(new_io, cond, user_data);
 
 			if (!data->step) {
-				g_io_channel_unref(io);
+				g_io_channel_unref(new_io);
+				return false;
+			}
+
+			/* Return if connection has already been accepted */
+			if (queue_find(data->io_queue, NULL, io)) {
+				g_io_channel_unref(new_io);
 				return false;
 			}
 		}
 
-		if (!iso_defer_accept(data, io)) {
+		if (!iso_defer_accept(data, new_io, num, func)) {
 			tester_warn("Unable to accept deferred setup");
 			tester_test_failed();
 		}
@@ -3060,9 +3082,9 @@ static gboolean iso_accept(GIOChannel *io, GIOCondition cond,
 		}
 	}
 
-	ret = iso_connect(io, cond, user_data);
+	ret = iso_connect(new_io, cond, user_data);
 
-	g_io_channel_unref(io);
+	g_io_channel_unref(new_io);
 	return ret;
 }
 
@@ -3070,10 +3092,14 @@ static gboolean iso_accept_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
 	struct test_data *data = tester_get_data();
+	const struct iso_client_data *isodata = data->test_data;
 
 	data->io_id[0] = 0;
 
-	return iso_accept(io, cond, user_data);
+	if (isodata->bcast)
+		return iso_accept(io, cond, user_data, 0, iso_accept_cb);
+	else
+		return iso_accept(io, cond, user_data, 0, iso_connect_cb);
 }
 
 static gboolean iso_accept2_cb(GIOChannel *io, GIOCondition cond,
@@ -3083,7 +3109,7 @@ static gboolean iso_accept2_cb(GIOChannel *io, GIOCondition cond,
 
 	data->io_id[1] = 0;
 
-	return iso_accept(io, cond, user_data);
+	return iso_accept(io, cond, user_data, 1, iso_accept2_cb);
 }
 
 static void test_listen(const void *test_data)
@@ -3379,6 +3405,17 @@ static void test_bcast_recv_defer(const void *test_data)
 	setup_listen(data, 0, iso_accept_cb);
 }
 
+static void test_bcast_recv2_defer(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	uint8_t num[2] = {0, 1};
+	GIOFunc funcs[2] = {iso_accept_cb, iso_accept2_cb};
+
+	data->step = 2;
+
+	setup_listen_many(data, 2, num, funcs);
+}
+
 static void test_connect2_suspend(const void *test_data)
 {
 	test_connect2(test_data);
@@ -3770,6 +3807,11 @@ int main(int argc, char *argv[])
 						&bcast_16_2_1_recv_defer,
 						setup_powered,
 						test_bcast_recv_defer);
+	test_iso2("ISO Broadcaster Receiver2 Defer - Success",
+						&bcast_16_2_1_recv2_defer,
+						setup_powered,
+						test_bcast_recv2_defer);
+
 	test_iso("ISO Broadcaster Receiver Defer No BIS - Success",
 						&bcast_16_2_1_recv_defer_no_bis,
 						setup_powered,
-- 
2.43.0

