Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2065.outbound.protection.outlook.com [40.107.21.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AB212FB15
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 16:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555835; cv=fail; b=GizT/YW6gcnsDBpUj+Da/4dcKXsIHh4S2/k2yZ0ZRjFu58hap5IsBwQegd/+KBJzEetxZRHWwMrNmuYnpDQ67JKwdo3rjqihK/Uhx/7CZaZP8WQOyMXOAbxWxVY5fhkxeTQZLYxjDsHtdnvs7xZKfKb6duQqmiSwZFsPZnX/274=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555835; c=relaxed/simple;
	bh=C5lbu3L+mly9+ImYB6UP0v5SFKXuH/TY7Ak0WGvrePM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S6Q9bE3XGtvsP8wYlSlxsS7pdZq8iP5iwa9duLkGgQubeZv+64SNr9tuf7NJxDEdqtCvRXReP/RT44zN5g8sdzgJi78i1QiDfKbqL8wA49WeYc5UozASLWKuo1p1rCb5LHdXXxFf76NNZ/UUN2ctUoLrJVk6gBgKXauPdmdVs8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ezyLeuIo; arc=fail smtp.client-ip=40.107.21.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ezyLeuIo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BsKkSNCCHhc780hWa8MWbyRvjDqR+GTAbBVmLlvrFjyfjgPSTK73TLgxVb1H++QaGJq19dMlY/2ZIWh16DXEZfU8A0hZUDZtIWEU5lkTSAi55fAjEE9Y+pWgVZg3WTWhu7DOHpKrzx0Y9vf3mkq3vkwMHHqjP3T9v2vEyToD/p685RvFvSH992hPf+RVDosUWWbisAOsRR3Y0d93toVP59WBkZSW+K6lb42TMRTGXYJ3gWWaVPeT7yjRQi93b7yfrcZPY8gX+jA6xvEgyrOWKXFLFxVdEparRkz5JmnooyBHxyt/d0eNuNOkuOkRE2cVyCiX9ooJjWRhsWjP7gLMKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKwtagoHGqt3Kyk3fcpoFHf4mBq8j6ByD4dE1PMMiBc=;
 b=CejfpewNuqdZdLVHywmGaWVAybjuvO+Uh9E8rX/eYeTRPSiQdum8ovvWxBXqQfX9Y/sJnOabhY5clJwQTaVZ9mCESLwzzD6pCheAck+347FA5nIJbrkqCY2ChwKLa37xvJTvg0LyPWmhZrXA1qmu/LMvfXyuOzx0e4SzURsuKyQp/ZpNqDwBR2iU72++LFXCFfuWuNl6VP3UlOwcwSeGjZMYYyeWqRtKSycsn/GR4V+ga4kpF31Sgbcf9oW0Rl2t0ZJizNqEENK6jkNRZiZvR8s9ZJ+DZGobACDEC6LD8ZZBo4Wg+qN4zBGQqF+iot60wmvgdGAEOezYn/qcvIvoSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKwtagoHGqt3Kyk3fcpoFHf4mBq8j6ByD4dE1PMMiBc=;
 b=ezyLeuIoOhF/b1bVgkTQ7Z4jvv4J0eDjBIQx6y06oONJePHWfwAX5XlFKiHPtUgQIBFEDUgNyIAbttTbobYMBTSoYneYoKE1WdG9E92qeXRlvXZ2nQR6jDvGUKvtkcz7CvzcsaakmEBHlovJtX3XcQx+9DthjMT6R+BD5aemIQA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB9566.eurprd04.prod.outlook.com (2603:10a6:102:26c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Wed, 27 Mar
 2024 16:10:29 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::c65:a818:c6c3:679f]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::c65:a818:c6c3:679f%7]) with mapi id 15.20.7409.028; Wed, 27 Mar 2024
 16:10:29 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 2/2] iso-tester: Separate iso_defer_accept into dedicated functions
Date: Wed, 27 Mar 2024 18:10:19 +0200
Message-Id: <20240327161019.3078-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327161019.3078-1-iulia.tanasescu@nxp.com>
References: <20240327161019.3078-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0173.eurprd09.prod.outlook.com
 (2603:10a6:800:120::27) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB9566:EE_
X-MS-Office365-Filtering-Correlation-Id: 6315a400-973e-439f-1725-08dc4e786c0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ONRphZvGkzIA8sC4HrJUoaIL/5k3ya1ugbhQF2zmZ1dzsL7n9mQ9lxt0w2ByrL35MDKKvxz6PCtXAgWPm9NytASzeJ01SpaHwe0r5OYDOizPl20MjzMjckMuxP1VOrHXSi8mv18U/9ae7w1totqqbjDYduElewQlpiaozPKH0P2FXNwzXJJe1/BhXFJuzHH6sXFtp5zO9g2tkEhHVTWlvIc5PcoRq5kbsQdnPbQiguvePImOW5SuN/mHXojrzRnPXTGVUzRsEM5aRdxp1WaPt/sq1dt/ODSkFTBTVuYgI7ENowGQaWuGzjfDjTxXUmJg+5i7FPwieWXKEO6CutKK20+NlQBk3x51YgTAhJiVWIVcrPi8vyFBG9cv9qHGuUdparMVtMGv7OHaCjv0Br2h07jHasjLgczn/Wzik2WbOCO3lGJ+ntGIJwB0gDDUDalutVtO/CviH2VIY5aHrwX4L86BSKwbkfk5LBMX0JsH1iQlDScVPVehISBGqp/TMDMv7aUN31vy13hnQ+HHSmrbEQIhMMmi+jQ/hQFFkp3k8ujovKxilGqC9zx0qeW2g9g8pW08zRizbur1jL+1Ta+Iq6evRUeeS4LhriZ32bN2BgIVl7HokE5jH/Ivo0vlzElvqyftWXkeCepS8IvS75oMXQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OnyegGJstlI6dR6yNaMlOwb4oIJEcRLDmOdm9diyr7sxcIMgGROK6sz9Qswg?=
 =?us-ascii?Q?sNHxF2Jz3cbGm7Xfibtds3jRgzFNVZRSpSeFsv3kH6Uwr6WL7rV1mEnIW5e2?=
 =?us-ascii?Q?ZwF5c0rmAZmB53n+uhsU93oTOLjn7dtWMirUZXei2MVsxZZUXjb+1lNfKlkV?=
 =?us-ascii?Q?YrCPnetB0jDhvejyZnm9KqsXEL9yCD+dFbh11UH15rUgvyLG900VIVAZE7K3?=
 =?us-ascii?Q?tj7YxGp1mvL6a/wJe3/8FsWtq10vxZpmikVJAHW6jzxDjdLdbO1FsPA0MfBa?=
 =?us-ascii?Q?N/VRLGp2iVWaWv5C3Q/Xf7xz73BvRvZIdMuZZPjf/b/KIfEcKOws2v1ZsRIF?=
 =?us-ascii?Q?arxDD1TkunyPsHL6dRlF0hpSUdYNqBdiKexQJEAsK+HvtWA9k/yEvIhONKJX?=
 =?us-ascii?Q?/dUlG/uFENwN9KOEatEatV7uRwqGgOd+5nvQE+9Vs2rLNQkXyMbOXqeslXk1?=
 =?us-ascii?Q?M9z6o9BVILI5IpfgXfsjfzvZEL1olWc98l2iNbUqbiTj1sgEGTMa7ckvT5RB?=
 =?us-ascii?Q?xP1WmhJ5oC3uhCqB/6cT34Zyx24vNs0eXSzg44ICPHByfUPOiGe8GRS4Yepx?=
 =?us-ascii?Q?9vxLuVCgCLQs+jgpUyn6ZrYbf7qZeEiV8mKoTpSB3/aBcJUcQ7U8GphVJvOu?=
 =?us-ascii?Q?mAGSsRuQ+YTRAFUjRj6XLinuxcSe4EOqZHLdPiYdWe63K7NO/Zi4OV+Atefl?=
 =?us-ascii?Q?W+l5NDzHM3zuPsZPmvcUqlft4s9F9NQtltw7wOXXcsJow8lGM2u+s6p++iLY?=
 =?us-ascii?Q?e1LN7OHD3j61d2pPUq1b9tSZF2GeixIhYyx66SUzzXeDkXbtSJPD+VJGgddZ?=
 =?us-ascii?Q?lAi7eJYKISTbwSvpA6Di+3kl6lUzybhRppRr4Gm+ZkHBHUJHr6HuXzF2o8tY?=
 =?us-ascii?Q?CFe5ONc1e1saFzggAeEZ+QjMj04oiO5HqKtJVH1u1kh8hwsZw3qYYer2OojM?=
 =?us-ascii?Q?+t4jlhRvtGUNXMYPp42hXRMcjVlG7fDEJKZcCzXzkDeF7RGcMDhA3Ggy9O+f?=
 =?us-ascii?Q?i56ZYaK5LtGial1FB5zFRY68IKvDEcIrgI4wBc2TZKdQEj9k6PkygDUdovTx?=
 =?us-ascii?Q?ATxJTb4FExrUBSuCAKIPIDwhvHxVrfzXV/pG+9NCTsjzV9a+cJ0dPHV0FLDs?=
 =?us-ascii?Q?yTGu9nyJCpxjIC9fwzH+69kAqapMIyCLeBfFzOBqlRcqJOVfosVzDukM0kAk?=
 =?us-ascii?Q?lxltByEIfpKE0i9KA7ttwKRD5tZLulmdEeL29NhIU2sgQUrMwou1TJtS9E87?=
 =?us-ascii?Q?8jjq7970uDcscarJMxc4ZcY9VaTGpNTrBBRMQLXQpEcrjZwUVetDlmE5uZ7c?=
 =?us-ascii?Q?gS9WyGfM5ZB3FgpnC2LBz3R+soDWIjEj237d5RtSVKxD9k/M5Bmku7/K72Wa?=
 =?us-ascii?Q?C/Rs8rColAqta9wvHwaAvUd/iTVr8BiVF0i66ZhstryFpfTKpQVUVwOQbnY0?=
 =?us-ascii?Q?tp8BLComSDzWn9HOeH7iyFdVPBypc8pCgWMKgDPcKLqgEnSV1EZWW7bhy9Ds?=
 =?us-ascii?Q?YswWDMo7Egkdf/kBX76MzXgnNv/oR5HMxuF51dje1Sl/qqaft8T8Fgi0ZjO6?=
 =?us-ascii?Q?iZq50jM45y3cFk07ISjTBLPEAyZzecsK3p9IXeQucJSrSMvj+6mzIPJP0p8q?=
 =?us-ascii?Q?/A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6315a400-973e-439f-1725-08dc4e786c0b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 16:10:29.6629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+dJpPz25sNb94iW0nTG9kLy5tQVO4WKjnqodzdnmxuVkqONADstw+18JTYCSBAT33y/472clMcwB6RkaXrEAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9566

This separates the iso_defer_accept function into dedicated ones for
unicast/broadcast, since the flow is different for each scenario:
For unicast, POLLOUT is checked on socket before calling read and
adding a G_IO_OUT watch. Checking for POLLOUT is not necessary for
broadcast, since currently this event is never generated on the
child socket. Instead, G_IO_IN is generated after BIG sync is
established and a BIS socket is ready to be accepted.
---
 tools/iso-tester.c | 45 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 1864b9e9d..60afef301 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -4,7 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2022  Intel Corporation.
- *  Copyright 2023 NXP
+ *  Copyright 2023-2024 NXP
  *
  */
 
@@ -489,6 +489,8 @@ struct iso_client_data {
 	bool pa_bind;
 };
 
+typedef bool (*iso_defer_accept_t)(struct test_data *data, GIOChannel *io);
+
 static void mgmt_debug(const char *str, void *user_data)
 {
 	const char *prefix = user_data;
@@ -2582,11 +2584,10 @@ static void setup_listen(struct test_data *data, uint8_t num, GIOFunc func)
 	}
 }
 
-static bool iso_defer_accept(struct test_data *data, GIOChannel *io)
+static bool iso_defer_accept_bcast(struct test_data *data, GIOChannel *io)
 {
 	int sk;
 	char c;
-	struct pollfd pfd;
 	const struct iso_client_data *isodata = data->test_data;
 	struct sockaddr_iso *addr = NULL;
 
@@ -2610,6 +2611,31 @@ static bool iso_defer_accept(struct test_data *data, GIOChannel *io)
 		free(addr);
 	}
 
+	if (read(sk, &c, 1) < 0) {
+		tester_warn("read: %s (%d)", strerror(errno), errno);
+		return false;
+	}
+
+	tester_print("Accept deferred setup");
+
+	data->io_queue = queue_new();
+	if (data->io_queue)
+		queue_push_tail(data->io_queue, io);
+
+	data->io_id[0] = g_io_add_watch(io, G_IO_IN,
+				iso_accept_cb, NULL);
+
+	return true;
+}
+
+static bool iso_defer_accept_ucast(struct test_data *data, GIOChannel *io)
+{
+	int sk;
+	char c;
+	struct pollfd pfd;
+
+	sk = g_io_channel_unix_get_fd(io);
+
 	memset(&pfd, 0, sizeof(pfd));
 	pfd.fd = sk;
 	pfd.events = POLLOUT;
@@ -2632,12 +2658,8 @@ static bool iso_defer_accept(struct test_data *data, GIOChannel *io)
 	if (data->io_queue)
 		queue_push_tail(data->io_queue, io);
 
-	if (isodata->bcast)
-		data->io_id[0] = g_io_add_watch(io, G_IO_IN,
-					iso_accept_cb, NULL);
-	else
-		data->io_id[0] = g_io_add_watch(io, G_IO_OUT,
-					iso_connect_cb, NULL);
+	data->io_id[0] = g_io_add_watch(io, G_IO_OUT,
+				iso_connect_cb, NULL);
 
 	return true;
 }
@@ -2648,6 +2670,9 @@ static gboolean iso_accept_cb(GIOChannel *io, GIOCondition cond,
 	struct test_data *data = tester_get_data();
 	const struct iso_client_data *isodata = data->test_data;
 	int sk, new_sk;
+	iso_defer_accept_t iso_accept = isodata->bcast ?
+						iso_defer_accept_bcast :
+						iso_defer_accept_ucast;
 
 	data->io_id[0] = 0;
 
@@ -2676,7 +2701,7 @@ static gboolean iso_accept_cb(GIOChannel *io, GIOCondition cond,
 				return false;
 		}
 
-		if (!iso_defer_accept(data, io)) {
+		if (!iso_accept(data, io)) {
 			tester_warn("Unable to accept deferred setup");
 			tester_test_failed();
 		}
-- 
2.39.2

