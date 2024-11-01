Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2044.outbound.protection.outlook.com [40.107.105.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DAC144304
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 08:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730449914; cv=fail; b=MFrblCuvzAX+tiA+1QCG3SKrACNz+sfmVDw3ymPQ+/MuSGk66wnbeUvvLTbE436Gxn5AK7puXhlMsbUOKl0gJheavGacvikYq1yXGLHrFmPwNa/Bd03Zzdn7Yltma9hpSJlhtW6EOHspr2fkkR26AjQL7YoKi4tb7KpTq9EJOeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730449914; c=relaxed/simple;
	bh=INoxnH5G8E5iNRM/EDi69NxOoE9cGBC9KUQfjD5C8P8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=baILkKT9/kntYLRg9besiyJROLGsaSsvp/FrGAJe+5ak9L4bGACgzN57c9sW2809VrV78sXurzEoNcbib0SjZzogPiBaK4dyA1LD5ckyMMCl4vV9fEJC9v7mrc/mjUwh/Bf7IKKcXMakrPrZj+wXlGIkHxkIA0HyZ6tzMjsYaSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bh+JSH3Y; arc=fail smtp.client-ip=40.107.105.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bh+JSH3Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHcvGyy/1oNW+9LAqKEg/Empka7usQy4+HnHBUpR9i50FObJsoCvvy059kD0IzAfeqoIIadUgFb9WV5VflbiIWpjJl1p7Z8BnJf1MhD0Hff557oyYPCCBfS6gHnFcJO11FnGMsq3s9Zd9uIlK7d/s1awTSlE1ao9y6t8Fb6SXeagS4lNu+a9xNIVORBfMSXtEgI5lZz2MdR2CR4EBZE3YwI4AJ+1km8iI2+Lsik/rKGEZf8Z+45FxJb45h9dWXJARfH9x2kXefaMGE/nUD1bKGkfoHUcODJ5xRUPhkZ/Nz0fOifamRROL1LUCu/zRfBQLYaCJu6kKHymwzlMR/XsOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCwaQ9Hq09SsVPxUlzYSO1XtPgXK4Li2xaEVsOmxTMg=;
 b=H0lYbBqW1FZK86TCatnTERWKbtFHPFY8r65yJYUnFY9KE8AtOEeJs3RilOSs64FWi1Or3Jz3oRm8DC+a6f5JyFgS1z094DF1aSybmYd3xLIqqT8eiZUPZ6listF1OWWdHEuB6pX17+WW0DyRKwzaA6tbrpWZfaW4U7PJwSFqQY+rJF08j5iIUyybXHd/vCNqRaOzusIRDvZBNxgmMygYgGsR/GOe0FAAosdD6pwWVVudrIDG8cNHci2Xxeu72xta0DkVQ8YQN7tqNaWZG+1FwrvHqpuBJS1GlF88KzjAt91Ex+sfM1mED5h2B9zCoYMZR056WoOxoICe8AVcmKGTnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCwaQ9Hq09SsVPxUlzYSO1XtPgXK4Li2xaEVsOmxTMg=;
 b=bh+JSH3Yi6aik+oYNhdHT4Un/Mn6BLm71rXqNlWmfnsIAmCJ4rTM5or87rXeAL4vnfiAz4VyQEl/Bm19Di+8I0O6+hDimcvDSKfel4iML3uZQGZgN70nLgVrvNvNTDJHMpawzR9bKPQYoIp8gqXY7yoBn61/h7ZB//IOPOKttOJ2I8Tk7Z0tRrmPQ++sOufNBgObYaLYdpWzeCh6uDJND6ZW9av4+0JYDzR2tGixGixyioRzidKjLlmxFEoZ5PvaM/4UVloIz56nhxVTdMCJUfkE0YqgOtBqaTQrYIFoti8MdPGaUuHT+OhZ6a7OeB/BaPkBoXwbM5gUZHfzj1QPkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA2PR04MB10215.eurprd04.prod.outlook.com (2603:10a6:102:409::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 08:31:47 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 08:31:47 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 2/5] btdev: Add support for syncing to multiple BIGs
Date: Fri,  1 Nov 2024 10:31:16 +0200
Message-ID: <20241101083119.4510-3-iulia.tanasescu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4ecb1166-3722-4fb4-9fa7-08dcfa4f9fb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LD6suuOjb1k9OIcM9HEMYOPv+LW6ofqnd8ua0VqRQvSrV8L79jhACD35a+PQ?=
 =?us-ascii?Q?a2VRLbjhvn2ASK3VGZEiBmP/30T75ymu2eVsl8PxP1QgcA/wFDSHaM4xBrti?=
 =?us-ascii?Q?IMD3Lbr9ecg18DZqULiMvzDZxcj5w0FM+B0b+fy9h1UWKMIVUyG4uaiw8HDG?=
 =?us-ascii?Q?Rpa6FaUCI2J8N/1C6zisjbirDwaapBplHwitCMDqh3F56lk9D+fMVTjKoDCf?=
 =?us-ascii?Q?tCDEb3CrxIS7gKKtTmIW7H0uBXo/noEizJiFlim5utnbLK82lEiWLhJ5Dd8H?=
 =?us-ascii?Q?TxmLXsaGJHDfGCrFucEECqwRr5HF4BsFSjRNozE/TfhKxEjzW1vgmv9tMiUT?=
 =?us-ascii?Q?iwrjLWzI1n/tP59DmZJGYwvwih4DWHQXTtEcTwC2FAxMeJY3pUe1VJBsZUKY?=
 =?us-ascii?Q?a8TmINpf6X4ICcmNFmNOcDP6C3BtH3rKTkFJEhrbwod/WGMKwa20sUENw2uA?=
 =?us-ascii?Q?kzK6oQsDRBdCuavdA0BcvmtVFOxj3bTaaNbrXL7yTNSv5u/X4OVQxoVdrVd0?=
 =?us-ascii?Q?y1McYOLixWWXOX4G0EiHyDTcgMpuLlLGtkYzUYFI+oN8ntZDoTLhrK+MglZi?=
 =?us-ascii?Q?D3bcrlGEN+G6lF5+kqfF8faD2Ce07L+WfUpMU69pRNTpGpty1EI3UDMO3ELk?=
 =?us-ascii?Q?WO9QkI54DX2T4BM7+ddPNahJraiDo7eKu7c6vf2sFtUaJQQPjVAmgk0ilAs/?=
 =?us-ascii?Q?Io7HN7CO98ti35Nn60aMfHT84X2kSB2L8qb5NAiQ1Q88A9TI1GvbwKtFBzfn?=
 =?us-ascii?Q?RtAUNMcJu9ZooWDtNA2vCNHjXbzg6zLys1m8r1yha+7vTaSPC6taTkWFfFAE?=
 =?us-ascii?Q?aA3gNntPgdNDnkQryuzpft9sVFQOPG/Agb0lZe/4o+K9OsNL5f0/axMZaJLp?=
 =?us-ascii?Q?MVg6CQjaZjQjFpYsiP8nGHVOAQsfgJsWR35ilnGEi2WOFHM0XddSGxYWkLny?=
 =?us-ascii?Q?kqrRL5gKS87DdGfG0XgkIPPIu71ERO8KLGzkcr73iF99Ufa36N3r9A/TkCmN?=
 =?us-ascii?Q?sVkCsLRZeZ25hs4R8M/dVX496OoYvsa7ORhtEBeXG47LI0/LPXd36u7DxupW?=
 =?us-ascii?Q?xgPq8J7eKOkUJV/sNQU/NSCs7LnZOlFjL7e4i9xU/NdW8CtUN7JaMHm98kJn?=
 =?us-ascii?Q?yZrIYST3L/F4sLo4ow2VA8e5WTswBkYHOkaOjZC2TrnGVEszCiROsKpBSs9o?=
 =?us-ascii?Q?IQn5X0F4YwqeibAqLzTmTwrQ80aIKrrK+bLlxaKxY/7jBkhVfhS/2LsDFP4f?=
 =?us-ascii?Q?RragutArh3J+DixXfMj06qSKr4UaIm/ipfUa7RlIH69I8Iodl6eAGUustJ6u?=
 =?us-ascii?Q?rBOIN0hhdCenQH+BYiECEXyLHhHF6jQ59bquvprKB5P14GEWP8IJvo1ACqQG?=
 =?us-ascii?Q?H+q2awE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cQ30L154b1J/IeAAnRMITdEwCui66UJ2OBQt0e77DwZWt5IS5+Es5i3ISZ23?=
 =?us-ascii?Q?Pjgae416hwpqcKK76YXBOiQnIRvVuMgqCNMeT3q9RPaud4YKj02oyJYmrixC?=
 =?us-ascii?Q?3iZYje/xul6xBMufcuCb4+qf8f6788McD15PdK4wVlxNzMJ2/dIQWMPxxt2g?=
 =?us-ascii?Q?woMEf0DcI2qBNkc9JHzc6SYAHbz4gv4JtP4r0p/4WS2cq2OVvInULJyquxsa?=
 =?us-ascii?Q?3/uGJ+SF+5K2wrnqSa04V7W2KauBNZ5muvtXpWAe8DqWuBVxTt0MkPrB4lzt?=
 =?us-ascii?Q?bC4hp8Mc45YGptW2sZjZFAIzXnFU4BMbSlvh3TtV1yCRl8TMt+XCylMzA8xx?=
 =?us-ascii?Q?Tpzb7kYMoqrAjQD9ZUKcPElsVLxFzZN/lcDWwY9SiYZGJQ8RQzQav2IVenuq?=
 =?us-ascii?Q?CPwcexzIwENMhAdMIt1xGlRwT9pBRgPSkoHB8weR7Jb2WoYhDUYtwGn8eKes?=
 =?us-ascii?Q?atoLQQuR1mw4laEn2sSO/Mos0BJMtc7ClzcmdRkRDFAgKpb3w7Q5pOn4egw9?=
 =?us-ascii?Q?bBvmu/yeb7/MvoTm8oBble7ON/x+ugCRkZuZ+rYg49Nt2cvO3ARdOC6F0/5m?=
 =?us-ascii?Q?tGPvcYM288EBbmpVYtN9l4RT7XIezV9uRlYl2tX0hLuN4s4dzOUCIH11JnBO?=
 =?us-ascii?Q?4idzPQkGbVEgTkg0wSd4AnWvprDcayXwc2fs9t8xKZT2uQxGdKWrPSJ2xbFC?=
 =?us-ascii?Q?LXpsYA5vSw/EVyNWmHUt5YaaGXERSVfNZpufrRX81JUdEyIQSh98A+RO0V7D?=
 =?us-ascii?Q?rxUbr6TLzN5mlnyZmEyrpDbA9CwgEqzGVSuiVfBypDnpGuI9ln4xPP8NIO2X?=
 =?us-ascii?Q?FW+UEbzR2eh354DPwOxr/bV5XXNbcXUx68k2r3kRnopKy2wOjS8Z+XEIZA2L?=
 =?us-ascii?Q?jsCWkwNNkMaaXB7TSdFMPftmsfHelCBlLa2wjLCv9SM/zH0N6M4qysxQV5oS?=
 =?us-ascii?Q?6ElkspHT+SKGsRVEDxqHc8GkPoq+ngby2lcgZ52TxnyRWMGP8yP2/4YWqN3W?=
 =?us-ascii?Q?Y9Ie/st4UbxRaWAPlx8D821fTNI1dH8HZRvz0a4qxHz/s5gmPaTT7zKnvwFZ?=
 =?us-ascii?Q?ugWWfmH/nm4sCJLYLHhDw+aFeGyNAO2HWI5NJ0Mimten0sTkMUSHE4jYqvNP?=
 =?us-ascii?Q?6TifEZ1ITx6OxjO/3q5TG+cA/B8AxkwG9JGbFDbjUXuTQwRUdtcpVFrf2rkj?=
 =?us-ascii?Q?dXbdT1hQZ8z/ZyPhzgiLVrI73wMXBGyGfo8/jKbDEW48faeJnFUxy+bqUJSL?=
 =?us-ascii?Q?GOfYwH6zp5OBtc1X/0m0b0gny/Xh/aVuMBKpghoGMP99NBHEyb8TGyKe8qjF?=
 =?us-ascii?Q?l4uQhBQ8zmudpYO7vCCYtnX5RuK5097MNLzpNiJWO2kbcUZsUNEofPrj+Ys0?=
 =?us-ascii?Q?G2NYt6OnK4LmhbqDqpQh91qnAChVnzy9FQFQORKQXHamgpC6CDMxlUtyis0/?=
 =?us-ascii?Q?gN9aedMcHlMuV2LqC4YLqdPGRpAvG5c6wjbco5W4AFJ3mJWPeAzQsPRON+e4?=
 =?us-ascii?Q?ithk9LUSPq5YYJ/O3SqO5+vv6B2z5QizOBdoORqyaQkFwIoNSTxn8xWw8Dsa?=
 =?us-ascii?Q?Qhq7/y2Xtlf+plvfVBkmlLwOU7mLDHVIVO3ShbBpCIXqYI3MUIClmjMzZhOu?=
 =?us-ascii?Q?9A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ecb1166-3722-4fb4-9fa7-08dcfa4f9fb1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 08:31:47.0091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0rVDf1wGi4RfRjXpa4I9IFGF2HWe1G1U14D30sZl7X7JQ3/ym5q0MFSTOddNuSWkAg+XPzIa2++29YlWIEBuBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10215

This adds support for synchronizing to multiple BIGs.
---
 emulator/btdev.c | 102 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 79 insertions(+), 23 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 3b0a267d1..08af873a2 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -112,6 +112,12 @@ struct le_per_adv {
 	uint16_t sync_handle;
 };
 
+struct le_big {
+	struct btdev *dev;
+	uint8_t handle;
+	struct queue *bis;
+};
+
 struct le_cig {
 	struct bt_hci_cmd_le_set_cig_params params;
 	struct bt_hci_cis_params cis[CIS_SIZE];
@@ -219,7 +225,6 @@ struct btdev {
 	uint16_t le_pa_max_interval;
 	uint8_t  le_pa_data_len;
 	uint8_t  le_pa_data[MAX_PA_DATA_LEN];
-	uint8_t  big_handle;
 	uint8_t  le_ltk[16];
 	struct le_cig le_cig[CIG_SIZE];
 	uint8_t  le_iso_path[2];
@@ -245,6 +250,7 @@ struct btdev {
 
 	struct queue *le_ext_adv;
 	struct queue *le_per_adv;
+	struct queue *le_big;
 
 	btdev_debug_func_t debug_callback;
 	btdev_destroy_func_t debug_destroy;
@@ -575,6 +581,15 @@ static void le_ext_adv_free(void *data)
 	free(ext_adv);
 }
 
+static void le_big_free(void *data)
+{
+	struct le_big *big = data;
+
+	queue_destroy(big->bis, NULL);
+
+	free(big);
+}
+
 static void btdev_reset(struct btdev *btdev)
 {
 	/* FIXME: include here clearing of all states that should be
@@ -584,7 +599,6 @@ static void btdev_reset(struct btdev *btdev)
 	btdev->le_scan_enable		= 0x00;
 	btdev->le_adv_enable		= 0x00;
 	btdev->le_pa_enable		= 0x00;
-	btdev->big_handle		= 0xff;
 
 	al_clear(btdev);
 	rl_clear(btdev);
@@ -595,6 +609,7 @@ static void btdev_reset(struct btdev *btdev)
 	queue_remove_all(btdev->conns, NULL, NULL, conn_remove);
 	queue_remove_all(btdev->le_ext_adv, NULL, NULL, le_ext_adv_free);
 	queue_remove_all(btdev->le_per_adv, NULL, NULL, free);
+	queue_remove_all(btdev->le_big, NULL, NULL, le_big_free);
 }
 
 static int cmd_reset(struct btdev *dev, const void *data, uint8_t len)
@@ -5331,6 +5346,14 @@ static bool match_sync_handle(const void *data, const void *match_data)
 	return per_adv->sync_handle == sync_handle;
 }
 
+static bool match_big_handle(const void *data, const void *match_data)
+{
+	const struct le_big *big = data;
+	uint8_t handle = PTR_TO_UINT(match_data);
+
+	return big->handle == handle;
+}
+
 static bool match_dev(const void *data, const void *match_data)
 {
 	const struct le_per_adv *per_adv = data;
@@ -6426,11 +6449,13 @@ static int cmd_big_create_sync(struct btdev *dev, const void *data, uint8_t len)
 {
 	const struct bt_hci_cmd_le_big_create_sync *cmd = data;
 	uint8_t status = BT_HCI_ERR_SUCCESS;
+	uint16_t sync_handle = le16_to_cpu(cmd->sync_handle);
 
 	/* If the Sync_Handle does not exist, the Controller shall return the
 	 * error code Unknown Advertising Identifier (0x42).
 	 */
-	if (dev->le_pa_sync_handle != le16_to_cpu(cmd->sync_handle)) {
+	if (!queue_find(dev->le_per_adv, match_sync_handle,
+					UINT_TO_PTR(sync_handle))) {
 		status = BT_HCI_ERR_UNKNOWN_ADVERTISING_ID;
 		goto done;
 	}
@@ -6439,7 +6464,8 @@ static int cmd_big_create_sync(struct btdev *dev, const void *data, uint8_t len)
 	 * allocated, the Controller shall return the error code Command
 	 * Disallowed (0x0C).
 	 */
-	if (dev->big_handle == cmd->handle) {
+	if (queue_find(dev->le_big, match_big_handle,
+				UINT_TO_PTR(cmd->handle))) {
 		status = BT_HCI_ERR_COMMAND_DISALLOWED;
 		goto done;
 	}
@@ -6457,6 +6483,25 @@ done:
 	return 0;
 }
 
+static struct le_big *le_big_new(struct btdev *btdev, uint8_t handle)
+{
+	struct le_big *big;
+
+	big = new0(struct le_big, 1);
+
+	big->dev = btdev;
+	big->handle = handle;
+	big->bis = queue_new();
+
+	/* Add to queue */
+	if (!queue_push_tail(btdev->le_big, big)) {
+		le_big_free(big);
+		return NULL;
+	}
+
+	return big;
+}
+
 static int cmd_big_create_sync_complete(struct btdev *dev, const void *data,
 							uint8_t len)
 {
@@ -6469,12 +6514,27 @@ static int cmd_big_create_sync_complete(struct btdev *dev, const void *data,
 	struct btdev_conn *conn = NULL;
 	struct bt_hci_bis *bis;
 	int i;
+	uint16_t sync_handle = le16_to_cpu(cmd->sync_handle);
+	struct le_per_adv *per_adv = queue_find(dev->le_per_adv,
+			match_sync_handle, UINT_TO_PTR(sync_handle));
+	struct le_big *big;
+
+	if  (!per_adv)
+		return 0;
 
-	remote = find_btdev_by_bdaddr_type(dev->pa_sync_cmd.addr,
-						dev->pa_sync_cmd.addr_type);
+	remote = find_btdev_by_bdaddr_type(per_adv->addr,
+						per_adv->addr_type);
 	if (!remote)
 		return 0;
 
+	big = le_big_new(dev, cmd->handle);
+	if (!big) {
+		pdu.ev.status = BT_HCI_ERR_MEM_CAPACITY_EXCEEDED;
+		le_meta_event(dev, BT_HCI_EVT_LE_BIG_SYNC_ESTABILISHED, &pdu,
+					sizeof(pdu.ev));
+		return 0;
+	}
+
 	memset(&pdu.ev, 0, sizeof(pdu.ev));
 
 	for (i = 0; i < cmd->num_bis; i++) {
@@ -6483,6 +6543,8 @@ static int cmd_big_create_sync_complete(struct btdev *dev, const void *data,
 			break;
 
 		pdu.bis[i] = cpu_to_le16(conn->handle);
+
+		queue_push_tail(big->bis, conn);
 	}
 
 	if (i != cmd->num_bis || !conn) {
@@ -6492,7 +6554,6 @@ static int cmd_big_create_sync_complete(struct btdev *dev, const void *data,
 		return 0;
 	}
 
-	dev->big_handle = cmd->handle;
 	bis = conn->data;
 
 	if (bis->encryption != cmd->encryption) {
@@ -6522,7 +6583,9 @@ static int cmd_big_term_sync(struct btdev *dev, const void *data, uint8_t len)
 {
 	const struct bt_hci_cmd_le_big_term_sync *cmd = data;
 	struct bt_hci_rsp_le_big_term_sync rsp;
-	const struct queue_entry *entry;
+	struct btdev_conn *conn;
+	struct le_big *big = queue_find(dev->le_big, match_big_handle,
+			UINT_TO_PTR(cmd->handle));
 
 	memset(&rsp, 0, sizeof(rsp));
 
@@ -6530,7 +6593,7 @@ static int cmd_big_term_sync(struct btdev *dev, const void *data, uint8_t len)
 	 * exist, the Controller shall return the error code Unknown
 	 * Advertising Identifier (0x42).
 	 */
-	if (dev->big_handle != cmd->handle) {
+	if (!big) {
 		rsp.status = BT_HCI_ERR_UNKNOWN_ADVERTISING_ID;
 		goto done;
 	}
@@ -6539,24 +6602,16 @@ static int cmd_big_term_sync(struct btdev *dev, const void *data, uint8_t len)
 	rsp.handle = cmd->handle;
 
 	/* Cleanup existing connections */
-	for (entry = queue_get_entries(dev->conns); entry;
-					entry = entry->next) {
-		struct btdev_conn *conn = entry->data;
-
-		if (!conn->data)
-			continue;
-
+	while ((conn = queue_pop_head(big->bis))) {
 		rsp.status = BT_HCI_ERR_SUCCESS;
-		disconnect_complete(dev, conn->handle, BT_HCI_ERR_SUCCESS,
-								0x16);
-
 		conn_remove(conn);
-		break;
 	}
 
 done:
-	if (rsp.status == BT_HCI_ERR_SUCCESS)
-		dev->big_handle = 0xff;
+	if (rsp.status == BT_HCI_ERR_SUCCESS) {
+		queue_remove(dev->le_big, big);
+		le_big_free(big);
+	}
 
 	cmd_complete(dev, BT_HCI_CMD_LE_BIG_TERM_SYNC, &rsp, sizeof(rsp));
 
@@ -7249,7 +7304,6 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 
 	btdev->iso_mtu = 251;
 	btdev->iso_max_pkt = 1;
-	btdev->big_handle = 0xff;
 
 	for (i = 0; i < ARRAY_SIZE(btdev->le_cig); ++i)
 		btdev->le_cig[i].params.cig_id = 0xff;
@@ -7268,6 +7322,7 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 	btdev->conns = queue_new();
 	btdev->le_ext_adv = queue_new();
 	btdev->le_per_adv = queue_new();
+	btdev->le_big = queue_new();
 
 	btdev->le_al_len = AL_SIZE;
 	btdev->le_rl_len = RL_SIZE;
@@ -7288,6 +7343,7 @@ void btdev_destroy(struct btdev *btdev)
 	queue_destroy(btdev->conns, conn_remove);
 	queue_destroy(btdev->le_ext_adv, le_ext_adv_free);
 	queue_destroy(btdev->le_per_adv, free);
+	queue_destroy(btdev->le_big, le_big_free);
 
 	free(btdev);
 }
-- 
2.43.0

