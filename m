Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2079.outbound.protection.outlook.com [40.107.105.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955D119CC04
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 11:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730461917; cv=fail; b=tZBmdYfFw/pheSDb2194tMSuc6Gjw+tMlt5Y4Yw5hDY1Iio0FvNca0hESrqnBftFxFzXNgLkXQLgSOuT+RIXzKpPTAfozXyNYbQ0yfxS84WJb880kYMCadDHGZm0EyaD4jopfRYbSJ1mAxaInLJiPPk0gd7C7tb/VqjcysSMvds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730461917; c=relaxed/simple;
	bh=Mivx3tE/T6A9yMetkRWxn4wNhG+d1M2d14zNXjJbin4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GerRPmYDe1ZDJUL7KYF9EEZoprRcn2f8PLleIAhpatcaNPFjb8awjGVeHs6eGZxPtnHvziiN7r80jSNgqZk+vF8I3FGYPWbBPp2/u8iXmcWYkMlsNhh0Njw4VKiZcSlhuitE5s4Cs26h9vH/oH09hpMvTW1CCXx8seh090oVe3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HUTqNqAG; arc=fail smtp.client-ip=40.107.105.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HUTqNqAG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f2oA2sl1/hx//XeknLQjEGOqVvmhXUeO4R8K11WJJy+gkq9OV81CGhVxD+5t+zCrMIJdQpdjvT4drHIfH+q+T2O4Th2nD0RgQT8pqKn+k5qjfSsk+E+tGoYIic2h6yZPCPTc+R48k0yJfjn749Ky2s2Kx2NWMvsXNKVX2h4kNdjHZhmaAmYcrs/aybg8V8g5Vo/Mu5Nri+udtDG3zMlUlhxfMLwNUjqLw6IOHOD9HjEuR+eYoanW+qd+ZP0kF5Q2GoeCGSCl9/fKoDOf+CdAWRfNY+5elq9TeOGAhNijZH+JwVbY7lEp3K7WnP5f401co72hFHwxSwWTQ7S6ldc4vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vxT3KMTxmxuODIbDPnn4ZshYittW77Ud6qZrCdfZQ4=;
 b=ma9ETTllWwRuB+jtCTrrTbIUfFmvMG+gCQW9x/9z8gDS9W4xLT5RXUd65xhE3tEoDjRM1XqO2otgFHlEOOps7oBMT0k/WyIRnltFnbD3+fReubUhjwBEhNdHGrx4Fx6V3uiAjqvZr7R8HktKACArCapRIginEl+uygK1pQwXFo0JGVi2T10IWzv67MWhbvCf1Q6D3LJ9xjqIaSp4EQ+IbrRa0G9WmPzs+MuBQ3izBuR6tKxZayTmI1gImzqaZVjhfMQsoFIthAsuEY0dcdf7CizXo3xX7GnhxkUiDiGfqcYFipN+FVfii1iO/TGagyhSExXb3opHt/gx+CIBM6daAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vxT3KMTxmxuODIbDPnn4ZshYittW77Ud6qZrCdfZQ4=;
 b=HUTqNqAGj7BcFoztyb6QM6vCRSJNloizX72CJZSQAXdaHNrxTrcBaqtMSYEPi2tcPoNaIW3OtBdYGgiJb8k6vutzrbkahO3PZu3Wm//aPEXT5OqSmItOewwYDOTIPGCLBBMDGKq2ps0keTnSoDiYzbhYWSkst6FbM5p8JWJk5qzAY4gipcOk4vaMKGFzf5mmujCfS4JnUvCEgNb7WpKfikpSbetlAddFqMn60c8oXfNLTu0cAWBvJL04IMCycuGnNbQ+ke6jRgbraW75kTkM6S786AHV8sEKKJdxdvCKIv2bkwJDJszPyHOgTimxpmk2Gt/7AYxcN6WsEKz6gRMKWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM0PR04MB6979.eurprd04.prod.outlook.com (2603:10a6:208:18b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 11:51:48 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 11:51:48 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 4/5] iso-tester: Add test for Broadcast Receiver sync to 2 BIGs
Date: Fri,  1 Nov 2024 13:51:17 +0200
Message-ID: <20241101115118.43891-5-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101115118.43891-1-iulia.tanasescu@nxp.com>
References: <20241101115118.43891-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0089.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::30) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM0PR04MB6979:EE_
X-MS-Office365-Filtering-Correlation-Id: 4657cc68-efdc-43dd-724c-08dcfa6b9120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YMv+qy6QcvzHXmJ4XFmOSaRfRFDcz/+HMe5Q74hQUfJvjO1XEsh0qwydT/ya?=
 =?us-ascii?Q?UsBEvV5p/LJrevLG2syGRZsz3hFpD7UyyNWTMRHxBjiNi6TgXUDvytpOT/k9?=
 =?us-ascii?Q?wO0MXbbKCInM+qZoWzbaLYoEIUHHkko+YmynuiPCF4UojyiT3Y/QvkJLIIu4?=
 =?us-ascii?Q?OaXuUWxH9fLMJCiT7Iig9HjP1jmVdg3yFzSssauJiCsGwN5Q6fhZr2gBbDJH?=
 =?us-ascii?Q?CU3BS9ri0CV1I9NpEFPK4JXojey4ZazHfZi7jF419rW1tzy3EaNIM+Vsek0+?=
 =?us-ascii?Q?S8yigpZdA7v5EN0y4DxzwwxOCEBWDc4BEnac3j8KlJ+BWf7Za5Hycv3kOKTs?=
 =?us-ascii?Q?6zVw8/K/10qy6CoqhvhpHigCD0vyaDVQSoHl+vQpQBjOztsTpotkhybVkV+s?=
 =?us-ascii?Q?GFeVvhei/bmAXEBW2h9OT4IsJRNn3Op8pydCj1kOy/n8aRqE1yG/Duuw2Kkh?=
 =?us-ascii?Q?JaOP6pbp+VhxCXq3SwaFDziYT8t1qCzD3/28akLx5GocqKrm7vMEnQz09vFi?=
 =?us-ascii?Q?uE09sexqjnPgivVwD4gU+oyECbMtYlVfg1djKpd9uvXLC/hIqS1XYgaF0Oti?=
 =?us-ascii?Q?POLpNJVg/gR1pfijpidDoyAaEc2g36tJwF1bp5DjGSMH3yuuLM3TJqOgaMnX?=
 =?us-ascii?Q?FjiwqHBtPS4kSq3hCARPROkO8xHuKG/0itFfihySH2yBtXPssJYqmn8sbw/D?=
 =?us-ascii?Q?sswh86RysHgcULdO1ar9tJ5Aer5IQndCNa2L5Vtv1zYDa/3u/x/53ltV46Ke?=
 =?us-ascii?Q?jEOGfzSbbgphCgrS0cjyzLhdEPK01kds8c5MCaTzUnYmtJD0g+hMZUbcHzZD?=
 =?us-ascii?Q?4JK1mfdKwHhByuk4ni8EcYHbO5exrRBmatnTaE+C4sUpFrTth6plTSnc8OGW?=
 =?us-ascii?Q?KsGJxdSHBvz053bowA3Juzt/M3m1LI3mskO5geZ0VACWov4xXhDbZFY4rIeS?=
 =?us-ascii?Q?5IM/NyvLnr444LvlXXF2rXi4+rWeb6WS7WC674LcfPdfdXmmaudrUgl4/3FH?=
 =?us-ascii?Q?isFPmcJUtLo2O0WBhKPkogGY578SIhxTDSMou0zBb7jwzO/u1SoYJFz5PJ7m?=
 =?us-ascii?Q?fhDGiPdNn1cAe0SYxKhhwTgC6tgoeaXip0jV48MVjzuUpK0jR8u49ksh1J6E?=
 =?us-ascii?Q?EetWLAFgr2sGUT5xRWeGtd9jOJkxPKXBn1oi3PtNG4xJqdVNHaRMGdD19Lpr?=
 =?us-ascii?Q?YIkNsMmB6OQeh8Poy3QXUQw1ZitXO9W3tmMETZuSAW1oFQArK+aD1oYr/geK?=
 =?us-ascii?Q?NUxpuh6dgzYnIZApqp4u5YiIqLO4FygvYwSqMT+zi+B1ngO1yKXiC6XV2p4G?=
 =?us-ascii?Q?cV32vSpzyWNaVYKSY35s7XVFc3+ACqbNcFhFPH5wdg+Y6R+0eehohaiP3IyZ?=
 =?us-ascii?Q?3/XEg1E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6JTcdt8xMoUf5BDYC6VNwbvrZQngW9AKkmoh0OvpvHBkLu1mRLVs12O49Wlm?=
 =?us-ascii?Q?YAReODUEcC7uLyFb9dEIhRFpRRVSF2gVbTYFWt0jrZEId4ftMT57EmE6n4Kh?=
 =?us-ascii?Q?lD17kPCueI+tYTXgygvEOVwU0CL7ML9V9wEgQhu/am9AYyWu3LehHslhPi3w?=
 =?us-ascii?Q?7L0ai0CPJbKEBs9lSEmOv6vGLjOge722uz8XiMIH6g4JA7akLHlEfSX7FbYJ?=
 =?us-ascii?Q?t9oewLJwwqKH18/7eZtmzjpBS6Cx+fHvYoEf+ElDMl/1XFJceEVCCfJLdS9o?=
 =?us-ascii?Q?/Mb/iiI+wJhWLFosurFX+Ebm8Z5DM2ZSh2u90hejFj3XIMGXTfb5JLMKDAF5?=
 =?us-ascii?Q?uFtjL6tmTp8c92FnDD9E0KP0v/KYHaF5qu8cXCbozUu+j+e7uclkSRHuHUPq?=
 =?us-ascii?Q?JEp0fw3BKsO3cl+KhN3GRKti8UFULKwwf9PIVwgoPFHO6v/KoBXZVevxbG85?=
 =?us-ascii?Q?KgfekrKxvzFXR1lawA71NcJqpAXgYOmN/1tJDYA0LVTnQ8AKBWSXRxE4z5Bx?=
 =?us-ascii?Q?D/iIsP86ocEI5TswEhWiMB15KU/t/WabcLHqftqportzC55Dyvvf9o4bT7M5?=
 =?us-ascii?Q?6YZtaMH0+3OpHQ12UNCH+trcKN8RDi0XZmU8YI91Sx8YrX1uN/JjBILEoeBd?=
 =?us-ascii?Q?qebLgjUXvPOB+iFR4EQ6vxpKGodtdDaiagy3+ZuVxywqJ2Lmq5FujGfMBRkB?=
 =?us-ascii?Q?cRere9c9vkTsCrUKQznOASIIYtbhkkozYJyvaPOql0omM5tm3TwAYl7x+apy?=
 =?us-ascii?Q?aIvLUQuheSdpTVRYCdiKnmPcsKX9Ik9vkNpl1YMwc2gkhcpc6p5FvYB/OmpC?=
 =?us-ascii?Q?x6KeBfIf7Zp/Fv3tUL9r8OEPGt4w/NpLjxanYocFrL8dc24NXkTkKcXWbhea?=
 =?us-ascii?Q?8s9TJD/qmYnlXVuepg/8wbqBccipezuUn39urUMOWUFDbNRn+aBXdfAZHpkR?=
 =?us-ascii?Q?PQulMPDXhf+2CoKnYhwyLjHajQUH3z9OQjexHgeXSXBV2MlE7ohEe9fMDWNa?=
 =?us-ascii?Q?3x9nXBTT0d7LS98lmNQPBgDx+GN+/w4uHqoKeYzjZithcjp9y4Sqv5/6LZuJ?=
 =?us-ascii?Q?T1iDjCuayGE2+n0Q3CyShIbu3wT6HpdyOH3e/057VqTFGMCN61q4lT4yIbnd?=
 =?us-ascii?Q?KimJP7R5V5Bp3m3KlOnVcWRfO6MCS/mU/GKQ3YbkqJeQC8ufkmT1FxaehW/d?=
 =?us-ascii?Q?KLe5d/9vx2A/e8Fo8IQ/2uvGohEF9EPGpKTLuAjSfTTDc2sjzByLCxOw5oTW?=
 =?us-ascii?Q?jC0zXq5YpyqiUGaTK7yC1S+vYCyQKysPP5BrYaK8FRuJSEjon+BM0Lp8aC5t?=
 =?us-ascii?Q?rN9/zYeQ3PIsgGA3nJYsOHoPx0JRV3hxUKROOzeNyhegttQ38raNuQz8+93d?=
 =?us-ascii?Q?6eiOAZTjlL+WKmNCvruZ5fljdAbg8QWDK+IFNAqvf3hBp9+p4/zF9ttiJ9Lk?=
 =?us-ascii?Q?9Yqi+0OPqof306S0e+YT6FR3pQr1iD70Z/7PILMMQwGnvb/+V6r4pQCLwzHp?=
 =?us-ascii?Q?tjFr9XUPIGIEBlrniGVObvLuQ5hlVS/0xJbiUtjv6RBfZiEVgpqbOSDYurK/?=
 =?us-ascii?Q?uEpkZfKLQTVP2AynJty9DK92M2SKcaDluJMopzoXHtuGVim/RhUM4Jswawxu?=
 =?us-ascii?Q?Cg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4657cc68-efdc-43dd-724c-08dcfa6b9120
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 11:51:48.4160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGnCHMdwGJqqdOMhEl05I0501SfJbiPaIg5AFp7WAvlIJrWJQE+uSGvxElrVdvLJC5BqUTEW6jompf64DUByIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6979

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

