Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2044.outbound.protection.outlook.com [40.107.105.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A513E14AD2B
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 08:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730449920; cv=fail; b=sugG213ILokso0T8yFLW7a0MPOvMpwigNbvtzDtjAGz0aV4xmwuupv9lNFmyirYefYx5RYidQ4qEH7JKpon6AkNlP1EMl4EQXs9dNwMADoG8brkyRoVP7KISdcDSCuj3xbql8fxQm0qXlwbPVhUpdgfbaY/FCbwznIOidgg0MbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730449920; c=relaxed/simple;
	bh=Mivx3tE/T6A9yMetkRWxn4wNhG+d1M2d14zNXjJbin4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pWMHrV8VmUTL6Z3m5hIxt7tZ+lxgTlYcbR9tPM1mCBSWcbeZP3Gx7EYA6IWTvITmaFfxZrN2CIZrCAYnzTtkc5Yl4Q4pLjVOIONaVZRsVVNLQrRr105UPVXhG2idDv+tQHzQfXK2ydlPP8XD94qqBhvNe9ccfnw0Shfg8cCT8yM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VZXKs/xr; arc=fail smtp.client-ip=40.107.105.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VZXKs/xr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AwuhhlLLgOeojJ7epA0wcUijHGXQvuO1SJBBazOA9QCPgUk3Rvuwa9pEq3X98tsI9mFc1BQfAS+5QdJqbUhMNpO3IzpRbSdlkXX7Vge7aqf5h53mlJyWSU6TuwT4OAzkJNgUai4PRgpmex1ioG+RNr3an1W2+HisblBGvaqa5mxxGCL1bUuNp1sCXVvdFxKqoha5Gb8F73JtVP9sqUZPR19SWNg3yQaNNbKyw5t/iyIrXhMNL3KWwQ5zJso54Xkccg5HeJkyUuAgwCU/2NjikwdYrCj0HcfpfQ3mqsHFbgKKJ/FPhNjwopsg//RxZ7w1IGcnRSMp6tWBDFOkQHtFGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vxT3KMTxmxuODIbDPnn4ZshYittW77Ud6qZrCdfZQ4=;
 b=zD2DgJVGyYWu6Z0WmqZYCy6xxXfhH3RfKYDhI5nXqK5qubAHMohKW1fspkf2QYe90zN3sB8hO4yXCXrhXAXo7EXQ7tSiQmQjRIexoWg3D3WwESySDQJyr3gAhNdBPjBGBGHbJFzOuRxvVnednHEATmjMApEDaLY9uB1IpeLWnbLUzOFQoVXgzwdh4DQ62yzK/eyncnq6LATPTmL6md/WGg8il4YQ5CN2h9ce4g0AT+ih+sh0slkAfpwivTNIXvS+XE5CrivBEkEh5QUK9KHyUn8xpXXe8RJ36gKbV1duoK2qO+bge3OmoTyGWPQoG65LmPV+rW3vVj7wot6CFNp7Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vxT3KMTxmxuODIbDPnn4ZshYittW77Ud6qZrCdfZQ4=;
 b=VZXKs/xrxywOSIjJHnRZKhqpbfrWdPJw08GL/IPAU7VlzdoTvoOHjDDN6sPkAxGPisWINmoQqJP454KubmkVO+ocwOY7+SJhtJsqM63NrIxaoxn6EipIBy8YjWsOfaG3KJBq2bl8hNgwjwPraJa6p9cWAn/ko6Sa4B6fBFlUkFnr5h4//FlONTJXPxrCWYn/Mp4989XG6+DfHXuPu2banZ36XeQR/XaoZdr06lsRmzm2D4gKCESlnXDDG8679ECZ4BxkdjEQiQSmk0ynv3PAVZhvwbRlCvnNFFopTpvwKXfPnwPN3EtTXEX7eZhetpmjYcq49fVSkXat7C5TurOBLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA2PR04MB10215.eurprd04.prod.outlook.com (2603:10a6:102:409::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 08:31:49 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 08:31:49 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 4/5] iso-tester: Add test for Broadcast Receiver sync to 2 BIGs
Date: Fri,  1 Nov 2024 10:31:18 +0200
Message-ID: <20241101083119.4510-5-iulia.tanasescu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 691f8477-67cd-42a3-45fd-08dcfa4fa15f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q95t1+rFxNh1+aFRj7Bxc90YfDhBAW2+n1uHn5wGJNhyhYu3Jzt/H+1lW+BW?=
 =?us-ascii?Q?uTJIbWRhphK1FuwV7nK/rK+A2zXueDI+StVQDYi56lOxfrNB+e7uI9OKPVRC?=
 =?us-ascii?Q?PX7ih3xuGtG9KYCSqdl6L1tbOWx3RNkAgB0oyZ2bQwgLqvPmfMeXiETVsSIo?=
 =?us-ascii?Q?2zGNuyV5BeYnkzDKr6nD2x98cddFOwH/H4goKHjWYudmpPM0M2hI2lW7F/+Z?=
 =?us-ascii?Q?5GnnbKnfUvpYxSX5/n8ferKBdtnx1yQVC55naKzXPF8h44BYx6bfUkIzOsqR?=
 =?us-ascii?Q?2Y0i5Jcb432fFkWpQ07OojFasNvTqL6uen8pOWih0Nsx5VcfNqvHHz3HVdpx?=
 =?us-ascii?Q?ADGWgXnCaqDugE+GqYVrv0uh1j3DorLjM5XwopwAxsPMsEalpl94d0JzI7R4?=
 =?us-ascii?Q?IK7zFASbX5aWE4+UEC96OzVlbHb9jceQh5WDAqkMr4VdlF41R/rKlVsAVS/N?=
 =?us-ascii?Q?sGoSe3M/tkoC05OGbNe1K5zAosOtD+sBz1fVKqabFHdYFeFTEMWxrDpRks/4?=
 =?us-ascii?Q?VgVLcFOdM3XxyJJf3oRP659a+t/ISNOw9t27Xh+/cOELgkrY7Pjdqp5GxkJn?=
 =?us-ascii?Q?TXUqIW3onZ+HsPNlxav4GKqIwpQPZsZIkOP8jygeEbEyNj3gmY6PlV+qRSyL?=
 =?us-ascii?Q?GtsXHG3hZyJMcyf+RNiqAwNSE/hNnTp+hDes0F9NOtRxAhZbNh71Lo01rIA8?=
 =?us-ascii?Q?EE7AczBrX6yh7bDmoHBWWm4eomIIVup6txG9aTLxNYanlkU2iNwhT+qtNUUQ?=
 =?us-ascii?Q?06XY7gsjtjgnKotpsESkaKapop5x+el9sWZiPMy5zcihdxO2LhZV4Pifavnn?=
 =?us-ascii?Q?p+BnSSAUqr2dl6g6RiKlYDtPwEpat7OWDKYuDm2Md+bXAFJHmmPs8SFi6PN2?=
 =?us-ascii?Q?b7iz1K8/OX8NnFuQYbNy2LRGAtrIWcoIo5akQJbhaOLWMPKhnlMMRnJme8s5?=
 =?us-ascii?Q?jkW6U5CT0FXtcusrSn83n+7wmOU+UGsX9TzZyjBHsgFytt938500vZoKDsg3?=
 =?us-ascii?Q?KzTXg/xteWoms5OFYBWmmDxkCBDShhbXvNu+lcN7DaZkSwlbIaXMxaZr/IfQ?=
 =?us-ascii?Q?w/6ZOzHC/hCVSVxOa67CiOPHJkuhJdGzCiy0bmWObQeaoPe4YlW9yVS3aVEy?=
 =?us-ascii?Q?sW3MB1eRAIb9XGGW7pB4VC68ckMurisC0hYy05Y+LNUjkB/Di1uGNnlz7dB+?=
 =?us-ascii?Q?bdiER07EkCPeVGmDmCkLDa2Ylk2CjvR/QLVGnGOdqtpjDaMxCwNdj5OQktuV?=
 =?us-ascii?Q?K8FFp9LDKXn+x5fklIxxsQ+3LAdxVTcalZkmTB63lZDEIeNiNNakkruTi2FO?=
 =?us-ascii?Q?Gfbu8QIIQt1mnTcCFKGdAXV+PB6jXR6b6j0pEAOIMrQVSz2tvTDYdiS71D9v?=
 =?us-ascii?Q?kUjQvw8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?StqvZKxdJP8cQCx/upzZ1Xell2n6tZL66SDTWyP2WHdFg3kLwvmRAfgRBUXn?=
 =?us-ascii?Q?kkQ9CuMI1qNcCLOy0E5LW6+6lJX1psNdd+PR4UJOQQUkGBG5RxWimrsv752q?=
 =?us-ascii?Q?8ERgkdjJuiFAu0Svjt95ptk4EQi6pVz0sjpWuzn5qvjn80da2qFdXRhAFwM6?=
 =?us-ascii?Q?ytCdmRU8qZybHYp9MRYdCJ+aKLIPVnIs3g5BWE+8EGiBXQVLmWCIGyWCQ6gP?=
 =?us-ascii?Q?73iPvd8OqSLdkJEi8UWVD4vIAGvciSelpX0G8XFxt8cGzTmHudiKH+oFarWa?=
 =?us-ascii?Q?Q70Yn16UQiFOau3hT4X2vxm7uMM/rTKxVXnqZ+TTOqehX2h1ujT0eqQKuSL6?=
 =?us-ascii?Q?rJZQrNEvMWlvmIWlln1JAszgaG+lb8zpLKa39cQ36GFbU75Z38nhx4SSrCWf?=
 =?us-ascii?Q?q20Mcw82dI9G02gZy55sBRuf30p5G8WcEzQh7qTp918rpSzbCnR3OFM3aNyE?=
 =?us-ascii?Q?ULBPQYCE0Xhvu5oWvxh3UFD2qPfaB9oVbvb7eVSBI+8Yl1RTUwTb7yK6EA0T?=
 =?us-ascii?Q?kfMoykz9l1aSd4shnMWwoA5uZW37IvRXoOhwA5mPkRTQ5bS7yaOd3kxp5tqt?=
 =?us-ascii?Q?kLDl0tAb8Ho/rLNT+0RPQPdQ+HPyQjWn1BgGZdEdgp3vQtvU4OaPpOksRUir?=
 =?us-ascii?Q?Ih65pxlx36VaH/CbCvGSFDaYgg3zOWK2d9ztJdho3oFpelhWzX3pA+YsUYWV?=
 =?us-ascii?Q?fBMsUpDxc1JSpKx38JAbcSmgOoR08WUtqir0H3fFtTRpqOWsN0IhRpPy5Dmr?=
 =?us-ascii?Q?IOYzTy8Okw2T5FRBm853jsPhlJrmzf+yTNvcczOkmZzdvbVZzKXu5yji1Et0?=
 =?us-ascii?Q?pAkVbb/0nsqWWFurRAYfVkCZzO43XWnL06SVCN3z3vlCedSGbNtY6mdJVjmI?=
 =?us-ascii?Q?VUN8bYcabKpqe+C/5vMaYKhO+9vo0UeRgARUa62g54RLwpFy93+CXXczRYKY?=
 =?us-ascii?Q?kt8ldYinQeYt/7duqTz7B29w0dGlnKJWJewHO8gHxzlLU4e66H+/IsoVq8cL?=
 =?us-ascii?Q?8A298bVscx3IZ8HdaYRKbzYJc2/rd3+Kf8wh6geDFZlW0jyXHVQ/dwFGTTFz?=
 =?us-ascii?Q?UehS2a49S0PLulIHMeymhpc560s5gMrOJcrPWHmiBGjLpYGF/ii/JrUO6p3v?=
 =?us-ascii?Q?wTmz1nXlBfbXDF+aW6eapDbqKR8eTOMEt+EgnE5p02FoqpQCis1l1PA+r84p?=
 =?us-ascii?Q?jqEm8DgNEv1Fi3fpUQOMe5jX1LFDsaHUnmRGjOzsD8uDjvwcU4Cl+M+JmBST?=
 =?us-ascii?Q?+tIQGffJU8A5yjhwcW20McpeS5f5/BJlFuMnkuv+gzHxPyUZcXwPoE0prFmq?=
 =?us-ascii?Q?7jOnPWoRxGfV0uvVAMF4PUv43DKmHOzu2FSFThk728ECPTIbjbmgveHLEcye?=
 =?us-ascii?Q?QzkW54CX7d9LVB127t5zMUhO8/9iLwJRgvGLHIa2k8Y5DyIA/8D8DsOvDmOK?=
 =?us-ascii?Q?Bw7/daV/oLIY2/AMxbPtFEJKlpV3x6VyEbBvTKmBrHFWVwRT3wMc4RWCCF45?=
 =?us-ascii?Q?vtJ2dkStijw0zN3KEhufogF+ULFcSidERY4PO04N7n+nyuSULrxfeBU9kYxP?=
 =?us-ascii?Q?SVpkxxlxE/f9Gi9ZdASYUAXmkXoGRGhCdxpUInNocJbcYuaiB8qSPpVawKpZ?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 691f8477-67cd-42a3-45fd-08dcfa4fa15f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 08:31:49.7945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OgVeH7JfKSUACU3U/1TbN3yAPY07FtZOFpBKd/51gRUSU0wf1ldZTSdwhOYxnvNta0aCZIcqqrPG1HdRW10yIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10215

This adds a new Broadcast Receiver test, for a Broadcast Sink
synchronizing to 2 Broadcasters.

ISO Broadcaster Receiver2 - Success
---
 tools/iso-tester.c | 101 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 77 insertions(+), 24 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 41d46f554..6215fd456 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -1418,6 +1418,14 @@ static const struct iso_client_data bcast_16_2_1_recv = {
 	.big = true,
 };
 
+static const struct iso_client_data bcast_16_2_1_recv2 = {
+	.qos = QOS_IN_16_2_1,
+	.expect_err = 0,
+	.bcast = true,
+	.server = true,
+	.big = true,
+};
+
 static const struct iso_client_data bcast_enc_16_2_1_recv = {
 	.qos = QOS_IN_ENC_16_2_1,
 	.expect_err = 0,
@@ -2763,7 +2771,7 @@ static void test_defer(const void *test_data)
 		tester_test_failed();
 }
 
-static int listen_iso_sock(struct test_data *data)
+static int listen_iso_sock(struct test_data *data, uint8_t num)
 {
 	const struct iso_client_data *isodata = data->test_data;
 	const uint8_t *src, *dst;
@@ -2793,8 +2801,12 @@ static int listen_iso_sock(struct test_data *data)
 	addr->iso_bdaddr_type = BDADDR_LE_PUBLIC;
 
 	if (isodata->bcast) {
+		struct hciemu_client *client;
+
+		client = hciemu_get_client(data->hciemu, num);
+
 		/* Bind to destination address in case of broadcast */
-		dst = hciemu_get_client_bdaddr(data->hciemu);
+		dst = hciemu_client_bdaddr(client);
 		if (!dst) {
 			tester_warn("No source bdaddr");
 			err = -ENODEV;
@@ -2857,31 +2869,36 @@ fail:
 	return err;
 }
 
-static void setup_listen(struct test_data *data, uint8_t num, GIOFunc func)
+static void setup_listen_many(struct test_data *data, uint8_t n, uint8_t *num,
+								GIOFunc *func)
 {
 	const struct iso_client_data *isodata = data->test_data;
+	int sk[256];
 	GIOChannel *io;
-	int sk;
+	unsigned int i;
 
-	sk = listen_iso_sock(data);
-	if (sk < 0) {
-		if (sk == -EPROTONOSUPPORT)
-			tester_test_abort();
-		else
-			tester_test_failed();
-		return;
-	}
+	for (i = 0; i < n; ++i) {
+		sk[i] = listen_iso_sock(data, num[i]);
+		if (sk[i] < 0) {
+			if (sk[i] == -EPROTONOSUPPORT)
+				tester_test_abort();
+			else
+				tester_test_failed();
+			return;
+		}
 
-	io = g_io_channel_unix_new(sk);
-	g_io_channel_set_close_on_unref(io, TRUE);
+		io = g_io_channel_unix_new(sk[i]);
+		g_io_channel_set_close_on_unref(io, TRUE);
 
-	data->io_id[num] = g_io_add_watch(io, G_IO_IN, func, NULL);
+		data->io_id[num[i]] = g_io_add_watch(io, G_IO_IN,
+							func[i], NULL);
 
-	g_io_channel_unref(io);
+		g_io_channel_unref(io);
 
-	tester_print("Listen in progress");
+		tester_print("Listen %d in progress", num[i]);
 
-	data->step++;
+		data->step++;
+	}
 
 	if (!isodata->bcast) {
 		struct hciemu_client *client;
@@ -2901,6 +2918,11 @@ static void setup_listen(struct test_data *data, uint8_t num, GIOFunc func)
 	}
 }
 
+static void setup_listen(struct test_data *data, uint8_t num, GIOFunc func)
+{
+	return setup_listen_many(data, 1, &num, &func);
+}
+
 static bool iso_defer_accept_bcast(struct test_data *data, GIOChannel *io)
 {
 	int sk;
@@ -2981,19 +3003,17 @@ static bool iso_defer_accept_ucast(struct test_data *data, GIOChannel *io)
 	return true;
 }
 
-static gboolean iso_accept_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static gboolean iso_accept(GIOChannel *io, GIOCondition cond,
+				gpointer user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct iso_client_data *isodata = data->test_data;
 	int sk, new_sk;
 	gboolean ret;
-	iso_defer_accept_t iso_accept = isodata->bcast ?
+	iso_defer_accept_t iso_defer_accept = isodata->bcast ?
 						iso_defer_accept_bcast :
 						iso_defer_accept_ucast;
 
-	data->io_id[0] = 0;
-
 	sk = g_io_channel_unix_get_fd(io);
 
 	new_sk = accept(sk, NULL, NULL);
@@ -3021,7 +3041,7 @@ static gboolean iso_accept_cb(GIOChannel *io, GIOCondition cond,
 			}
 		}
 
-		if (!iso_accept(data, io)) {
+		if (!iso_defer_accept(data, io)) {
 			tester_warn("Unable to accept deferred setup");
 			tester_test_failed();
 		}
@@ -3046,6 +3066,26 @@ static gboolean iso_accept_cb(GIOChannel *io, GIOCondition cond,
 	return ret;
 }
 
+static gboolean iso_accept_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+
+	data->io_id[0] = 0;
+
+	return iso_accept(io, cond, user_data);
+}
+
+static gboolean iso_accept2_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+
+	data->io_id[1] = 0;
+
+	return iso_accept(io, cond, user_data);
+}
+
 static void test_listen(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -3321,6 +3361,15 @@ static void test_bcast_recv(const void *test_data)
 	setup_listen(data, 0, iso_accept_cb);
 }
 
+static void test_bcast_recv2(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	uint8_t num[2] = {0, 1};
+	GIOFunc funcs[2] = {iso_accept_cb, iso_accept2_cb};
+
+	setup_listen_many(data, 2, num, funcs);
+}
+
 static void test_bcast_recv_defer(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -3709,6 +3758,10 @@ int main(int argc, char *argv[])
 	test_iso("ISO Broadcaster Receiver - Success", &bcast_16_2_1_recv,
 							setup_powered,
 							test_bcast_recv);
+	test_iso2("ISO Broadcaster Receiver2 - Success", &bcast_16_2_1_recv2,
+							setup_powered,
+							test_bcast_recv2);
+
 	test_iso("ISO Broadcaster Receiver Encrypted - Success",
 							&bcast_enc_16_2_1_recv,
 							setup_powered,
-- 
2.43.0

