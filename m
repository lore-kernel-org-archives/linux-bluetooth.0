Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2079.outbound.protection.outlook.com [40.107.105.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8F319C54A
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 11:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730461920; cv=fail; b=K3zVCd/eEsbWnuv/eyPWXSnOH4aV4Tq5xK1pjUOoviz/cUcIWLqwVFnR7a4RQDRuYelI57Xm/2Xw+qlL29CUtHHS+49SMIvbU87n8eIQmx7k6Ze6rVrJEp3hzcBleW+mipuGmW/AWol50cdqJrpee8bgDWY40Rg705VC+CUR0ZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730461920; c=relaxed/simple;
	bh=YVy5MLuLVhUzKTXU36Bp+w106pOsgzGfjnGsUxRCq08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I96mjEe/rGz/Knhnx1Akz10vMLYLlYcnXAvIaI4sR/6c3jH9/CSBgJQIZ1jPY3lZrZG5o5cWKbkFvYGXcZiM8uq0YB9ORbuN/OauZSPDnYhG0aqEVhUgW7fvxRMT6qhcZFOmyhqxn2OsLC/WTL51emhr2Xru60DL32gEb+oiLjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g4CPTWHj; arc=fail smtp.client-ip=40.107.105.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g4CPTWHj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ilt38vLezFoRwjyf2GYomoXEvVh3n8zsVwzqa5Nm21fWPeY7CF8JOwkiZiZU6naU9BJXhuJ+ljzVT6rp4p0hVPVSPEi58j0Pq4Lr1tGLif5y6Dzn6+GHtpbD8Sxb/Vlxgwi/kxBOXESErIk7+bfMvlnK6gFUi1ZvCrFDxwJ+yfJcNYhR4zZKZ7/YgGcOcEZEDe2ySEC8kGIo6SlPRRrNLNTGb/JZbc0Ov3RHKhja8BRv7UGVjw8KZHU0nTHj701JZ4Jww8ProCRJzWz8NP1uvSaT2igaTZRBx1pZ8KLDxtYuu8Ze/9MFIEKKJ3HXbZJENcrfqO/bUqeJKZjg99Xxmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaXdf2MK3De/CLGuNA+GLdZV47xQG9oFCIuWa9HQhJA=;
 b=QL/tP5NgpY049YaR02XNZjezXrcUJAzkDVXVTNm7yojUuHyOg9N++b/Qw7RsOFzY/kwJ8Rl6oSUMO7lj5dMW7i62i37rGXHNlt9iPrZjpay5+iLrH26dCSiwJvhQZz3ape7jqJiDY8BVICr8LTCRoWOMqEl7U7b2mM9Dwv3wV2+roOWHCTa9eIeqc9ZhB59pBVnY766y/8ozJceHMNqzVpoFTx+MjHTFT/uqTuF8xc+q/Z56tm72sxZInxPk76WCvL6QfDBWKaKLLJ9Nmgh2RV2mmbnAG96nnOAo5Wd0al50ys234cl8fNbw4siK8+t8xpFZCngm2R1qciH0zWrtMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaXdf2MK3De/CLGuNA+GLdZV47xQG9oFCIuWa9HQhJA=;
 b=g4CPTWHjb+0JCHNFA+SWCCOqrNVd398ElfRevmGxXvVh+XUMLWwR95MShYOgM9/IpRkJ/u0E/GVnFVXkgImjOci8vko8UeKK9r7ch/Au6YIyBGeuZDMzF48g6sNnMr0ZENdzFTuSzs9heQZBPjm6jFNeti734lZegakxKOjF59v3kKN7ZCkBgiWM8tZZVBANcviOSCI6HWoJcKOLZZb01TkSsAXflmTWgKvSOyw4MLiNHdWThGybnkbPiSbl79GmNtOR0xpQmXveY64OQQ1U7v6Glnx1CSF27o1chy3aaVdflxZfA4mCYVjeVwhNIIVCpGGN42x4Bq4ih47BQhPqaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM0PR04MB6979.eurprd04.prod.outlook.com (2603:10a6:208:18b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 11:51:50 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 11:51:50 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 5/5] iso-tester: Add test for Broadcast Receiver Defer sync to 2 BIGs
Date: Fri,  1 Nov 2024 13:51:18 +0200
Message-ID: <20241101115118.43891-6-iulia.tanasescu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 186c267b-8f8a-4aba-fd7d-08dcfa6b9262
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bun7jYcXzA5es0v9uHi3bqUgl+QyFseDxNSUh4XYkr9eT3kKo/nSnSCsiUer?=
 =?us-ascii?Q?DSuoUMglhTXKt9A+bjl9rXHeDpyBi3Z7tIjK5lDLzpu+3ySDN4XLtsqOF5J/?=
 =?us-ascii?Q?s2rP4Wm8967HJvz2o9vUmLESDtuWJREZPZEXE+8qitD1Dpx8ej6sFQi+R6cf?=
 =?us-ascii?Q?S/UbntflS4URQckVJ+k05BoWXKwaJHiHUtZcJ3Y/sEZ3lfxQwyXJA3CWhqHj?=
 =?us-ascii?Q?9DVWLse0Rw7/0wjK7V5vLBCf3YexrMVMXr/9tlcAYjX/g/iix+sqQhT8gyUN?=
 =?us-ascii?Q?rqey57UAhoLBI1alLed4RYfmdH9KqgUtRQWL3Ovxj4dLKMJXPgR7mbIxwdOQ?=
 =?us-ascii?Q?ywuaoZ/Y8j2i8zUVCp+PrR3gjycmCKKZ2brlbr5l6xjye38V1UGgm3ML4SEA?=
 =?us-ascii?Q?JHMvP54/e8TwAkEcnPw6d0krgoZiZumvEwKTT6NILUzyNScO8mn3nfFR+1ZF?=
 =?us-ascii?Q?ETkbZ4Vt27B9cdZRkSqNCeIzQAPX0Qke7RoxHvCWIiEDRkUwphaVqt5NSJFS?=
 =?us-ascii?Q?6+R3FiKvDIQfZp4xIwKdT/VDeH5aiJBMSUJTYtGUZ3dqDnB+G8iLT0c75R0h?=
 =?us-ascii?Q?PipbGsX16RCeQ6eFn57aXUa5DpHmdBFMhRr4uCQiF/ZMo1PrJjJNPRVesZns?=
 =?us-ascii?Q?T5lCoYHDP1YRDb5cUXjTIneh4bgkb3vxD93lZgDM21CttGxNLCTxhXXC6x0C?=
 =?us-ascii?Q?6+ALpGXRiqoP2Ja+SQV5zzX7DRl9BSa60coEPJS/s01O2mrj858iUrXmZ2sH?=
 =?us-ascii?Q?xeeej+eppLMeuNAq8cmHsydvmqVjdsZCMvFWmpxIL1TqC2xGX2fi1FTbYSlC?=
 =?us-ascii?Q?/tDMoh8hFT7hPFaio+Qq/4fC9CBiLGiBA594KL6j+zftwh32QYnULCmkEo9g?=
 =?us-ascii?Q?ilCQBdLpkdy3uKSUHMEYwnZsa/VKm+UG2eyqu9HzO58ChcaLRs7RBZKY7cTG?=
 =?us-ascii?Q?T68Di3FFkmOgsF1F5s8St/Zf5WzP87j+jrkqK4ollC3itnD+8i2LoyHUiOtd?=
 =?us-ascii?Q?32TKGXN7/ofyYTEPbgzdOgr8XElkekqCdfNVAMjXS31qh4R9Lc1eKru6arpB?=
 =?us-ascii?Q?0JwLRh1S7Z3sE4xZz2rVtR1MSojTWe4O2tnfZM+QCRLyU5nYnb/f7A+xd/dj?=
 =?us-ascii?Q?LVSwYz9UmaILT2V1MVQlVjQY6O8WGuaKDpFxXmcqM0pALrAuqZ98mjdrayRq?=
 =?us-ascii?Q?HdpZZ2SqBlPNjIa/Lspuj9qg6nkeue3HHUar5KFFHc2B2GFxgD+NM0XAFQUZ?=
 =?us-ascii?Q?8RWp/xqiG5PMW9Jxa8ZzLCXFu3zFbu/2ks5L2+tKTB8DWsyknaYTPdkS2/kZ?=
 =?us-ascii?Q?pzjR5MpXLDff5y3dtOpeEkYZemcaJMBh9ErT+0fDoDVmdtS/EuOHzmeIjc3Q?=
 =?us-ascii?Q?Q2vSOP0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tiqfF+e2HTkWrum5I05M+nF6nIX4ebqRBcWASlOINoCCCRtPalNenYdp97aw?=
 =?us-ascii?Q?L9eYppz6dMJR7qwfN190Oo2TH7R2kiBM6xb4aHxpswxEbofBkK/8lTgUr/Lf?=
 =?us-ascii?Q?d0fA/pi7T5Rouh53y8jUAbPiPowcfBJx2egmunTlG0F6KzfR7Bg7NUIjy5De?=
 =?us-ascii?Q?kD8cXDgNCIo+Cty5gX/UNZLe7VRUFEsM3sytPMPvHhwKpSgru2nSfcKp8kwH?=
 =?us-ascii?Q?1EWjRSJjgLXNLZmMrZx2hw88J197aSVCWLyQ15Xdc0Tf5Z9q5jy2dWzu9wUF?=
 =?us-ascii?Q?brKX8b4Op4rLt/tGq3LrMho+ayGqk3698M3BNzewkuHp2korhIa7C4O2C/sQ?=
 =?us-ascii?Q?x0DibzzrivQYMkG0p1hsV3aQAcRNkJT25p0El+HnC0/FIyA2iGsSnPV7Ku0R?=
 =?us-ascii?Q?cOjUWwl7v0zqSgx6hjA0/f/p6XlM8kihLcFKUK95bBYExmGDlkPsaji8Rb8O?=
 =?us-ascii?Q?/F7MEP5JcDv08wKwr5YFef0rh5VnFXmseAxDC+iN73GCMX3AAKhkfimWc43C?=
 =?us-ascii?Q?YZWEE3CVjuc0hlr82K7mZie9lGh9up1go9sqOSTsmqp5ss8zFG3FN8dLFIZj?=
 =?us-ascii?Q?+XXZP1TrCxHs0wbEAusEgE8oamTIoshkhgmxo63KufTFjsXt1PRFBXoo8A/p?=
 =?us-ascii?Q?7cNMUW573eRgXPNiBWanl6pYxonQLFUdKO5cgJzmwv+3Kp+yM5rvxQJGEoQq?=
 =?us-ascii?Q?NQeOfCipCIWRV5EOUwWrolh1abVh2e3OOXC1VDf0P9sGXLxfiLwCfDL1DGQ2?=
 =?us-ascii?Q?37x9l3Ae/qSNz9iUWxuKwQPzGREEC4fU7xXLrJzkPk6WXkJxU0JWIbFHYrvp?=
 =?us-ascii?Q?EqMpnc0og67DnjopnpvZ+ZIDKFahAecuRlYEJFYfK1zuyWxtsAqvtcjVcGcr?=
 =?us-ascii?Q?RM7Kh3v6KtCevvTDUO8bbc1EZ1UrBSPf0Oap8gr7e6soo6caz0M3k3uN/H5d?=
 =?us-ascii?Q?QFCduuSCKcUMzHtAbRuluZ/A5WbAZA9KnKg2QvqaaAxWEk2Go8J3XcsKRltV?=
 =?us-ascii?Q?+jaCtdOqPgwTRc6xAHiBAc4fnjRrWOyJNiKo3rp1+GszBPmkZKWCaBrn+qv6?=
 =?us-ascii?Q?BGdDV2fUNRJCmEByVEisrQaVK4W9U3HVsUao0kEY4B9VvBLH3I3M3clw38lm?=
 =?us-ascii?Q?6St5riLX1hNGhfSf/c3VlPa/45sslk5lu467ob+zHcSlDCngU1SDZHGTTzM3?=
 =?us-ascii?Q?ITlmTfmjPkFgodoJLqb9Q1hI/puD0FRJbaUUJ83RZh2qMIoniBILZMR8qNO8?=
 =?us-ascii?Q?1u9KZJtw+TzNZbXsg18+4/uI6Ex3j6E/L3PwSNipgbA7+jvYWSAEMB7qxUbz?=
 =?us-ascii?Q?HeE0i3gUsRelqRFETPeZRouObRnLGrRKc1q5IDjzjND+bsLCFfKL2o621Rdm?=
 =?us-ascii?Q?qBfXuKIMFSa9ZLdm1aYerfbXdTiP+KiBUlJZycVYiEqrgHDXMxxHU79athQq?=
 =?us-ascii?Q?9Yr721yqTLQby4wmEKYU9LqlsMF7z1O4RsBJFmpdtD3OJXHatx5RVcwp2wq+?=
 =?us-ascii?Q?6/mTTCGk+WWvW/CviiJuM3vwiPDmREFheSiln3mXy2Je6Hnvy9KC74K0AnZZ?=
 =?us-ascii?Q?AoZlevBOfPPAf1XANscPjyIqOQnvZ+m2GSN+gJuKgPFgGbS9+jskDkuf8A2q?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 186c267b-8f8a-4aba-fd7d-08dcfa6b9262
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 11:51:50.5777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /FZE2+J+ES9u+2WxdUN0D2D6SSmqpgWZmBaABZQvxHOf9z7DF3cFcDDdSVUCAos+eykOZ3Tuf10JlbDIcnqRhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6979

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

