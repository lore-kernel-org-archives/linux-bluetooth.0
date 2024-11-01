Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2079.outbound.protection.outlook.com [40.107.105.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7931990A8
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 11:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730461911; cv=fail; b=Z4xxlzbmRMAs4hk6qGYf4D09/j8L5EYiTyzUBWexfWJVEFDJYGDsmvIa9ry3vCW9I8mQycqoZXxEm/2stIJ9evho+Fxi9RCzplfI7NpH3wxbjSx+sU0Eg26dosNRKBtmG9tR3jFM0VaiCS+l3k7Lpw/l8qbbKwO7d2tvaeedOXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730461911; c=relaxed/simple;
	bh=/PGFYvps+2gvh43o5CvWezdr90tWsEFQbiI43TUUdBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P0Oz9CmINKHSzWMETmJn9cIbTcwDm11pIDZOTKABj8rvQoW/8SAIBVRZ0ticiIhUyIzAlkrZ13T8m/hPWLdG45Nu/kRkiPq5TVc8Z7+hTwZE/zmU5Vm0WJ4ATp8JlWNKIeppRZBc9+RWknjbtIMXCcGXJHiRFAEDtDggmYJW5qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ds0U6MRv; arc=fail smtp.client-ip=40.107.105.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ds0U6MRv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3uCuvAUGXX3WafuocWlHgNyBa31b0aRsZ63MCZiNoOMHaSUbm2+drsaSmC4Wv4kZPb8ybAiHouaz5rptCXmrFl6nvG7WHeVvNe24W5kgYpw+QJXCkbTxeemp3HcDdoGCdSVWSdEo9SDwtEDAuS8saTt6QzVrMslY+KG0KppNheFRj1PHr6IkKToIf+U+pfUzj63wMKg4hsbm/t2cuVxfIkYLk4zK4moF8+ek1vxPn8p/w0zRSxOj7LH5x54M1ThO89/2St+/E8t/6Vb08lZY7uxlymMmyLXabxBunFK0LAtECra/o7gBcB+UYHqTdSd/pG0hOL+HqCdDAVNWtHZ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YP74ZssFdL0wrkBg40Eq6oYGc6ol62JUsFkqWfFUEA=;
 b=rzDtrn4L4TU3n/bmxgOd9G2IRKHOYJTASTyiUJLQvE+ru+zYGaD9YnYKntVNC+6RnWm2Ly+4yxv6hUiN1AyVCuEVvXEP7+6czEJGtpO5QhX4Y2kbBCGKU392PcJ50UvnTOi82anyHcyn3ven7xWS/L3YcDf1Nt8+hMN0Gwop+mdXRzwJlshf8pv9pE/lOMde/Iodfqq8xCFlUG7LNMPwUvyAMlX+nZjDIoBffCGVA87AzoVBMh2YoG1FFRORmP9WK87TdC2aeVszhXwEh+H3Jm3oFVI7lM4PD9kAF6WhQUBawge/z1yOyPGh7NFFrXaaryPtSaG/NGLTCdmuNImr9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YP74ZssFdL0wrkBg40Eq6oYGc6ol62JUsFkqWfFUEA=;
 b=ds0U6MRvYh44rkX0NTgCVV1O7KwP/ruxAwJBfeulcSNLCnc9n0yaF3H9rhyKaGT2pdGwAWIIuHXQI3QlQhtEeFs3z1WC3EZhd9BUsuz0FPpIImUSXpyWOq24mzzuZxlUF5xpEePWecuEFbxZ6fU6FVzfnOz6wFY/pyLvTkbYmf61KCRqXl0HYRTPtlHyLNOu8rQRRJ8BRjCP+K2Wb+0C4tPbFrVhSHvzj7eyv6wsD0CScomh+OF8P/l2qTOZXQAbj1AOh1GzNmaJtuxjBZdvqdwynmzu0r6ZJqUxoxP0Ykk/FIjcp5C9rgFc6VFvBZzDDjEPk2GbxGkniOw5E7C1OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM0PR04MB6979.eurprd04.prod.outlook.com (2603:10a6:208:18b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 11:51:44 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 11:51:44 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 2/5] btdev: Add support for syncing to multiple BIGs
Date: Fri,  1 Nov 2024 13:51:15 +0200
Message-ID: <20241101115118.43891-3-iulia.tanasescu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 54202f34-3051-4531-4911-08dcfa6b8ec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QlaGgaOEc4fOXSBBU+oMBs/S8buLX5nR1YqSKqmKcIgEaPU2KF5trtBOGClS?=
 =?us-ascii?Q?n2kO40SKYDol9PTTOsbibxRCgrpTG9iB5pXnxMqT9Pu7CjvIGFm9weq9jRQn?=
 =?us-ascii?Q?f2keK48hr9Tnk3jo7Wqz9AWW4PAd6rjWb8pIWJVBImrju9fbPQWUrp/qHbCo?=
 =?us-ascii?Q?nDseVtNc4APS1Pb9V4gfNQbncLO40pN36oK1nJAqdG+h0Dz70hU/NYx7rZ/t?=
 =?us-ascii?Q?K/A78SG8UTzD9g0BQJrA8E4DWfAGCCNxJojsncIB0DyAIlw4vs3PVk+De3hh?=
 =?us-ascii?Q?Xv63Umkwa0vItsSg/756CQkt78BB1rGWjlViz/lsvrZplO5F1r/R3BVeArZs?=
 =?us-ascii?Q?LmGjWZ652oZ5Jhvga5aLk3+s0hECKs8D0Muc+tq1vw6rQd29U0eZuJkMD1uW?=
 =?us-ascii?Q?JapKBtrofwTkfnnHBp7nUCF0rMsWZaAXzzvFEqof+djbIy0B3AqgYCAF3qSb?=
 =?us-ascii?Q?2eMpJhx9dpSNF7q3LqdISor30hG/vxAmyVp174JUHkf5mO8nWUBfGTrKaS9o?=
 =?us-ascii?Q?u852ehZIdtZS1MH24vDl5Mbd4VYhRB/PJDG6wxyUanrx5/f2ttbVpw5xJchE?=
 =?us-ascii?Q?a4thywYKF5RM2HMdzPny1ENXwpE5doXIis3dUi+L6hBjEI5jvFVc2K9mZ35z?=
 =?us-ascii?Q?1L8HArxMZ57Gho6UxjYAe+XkU7S43sdA7SsUufvlhaYLMthJAFmHkjXDJuvJ?=
 =?us-ascii?Q?2P3ihBt2TE21mwP3/BBz5NGZj2CTSlIl4PHGBm94xYNERJ1uztvGsiYR2NbL?=
 =?us-ascii?Q?t0VW0cnEdq8Pf5Fis6nq0kA288EHIxoCgBtGtJtnbNEadExfAfCj97/3Kan9?=
 =?us-ascii?Q?gszKdNsVZw81lTHZHlo+cEpZCHr36yiC3v/++odpWKeYyCrPzTHQhvOTmhu3?=
 =?us-ascii?Q?ETUy7lPXkEHlDURAE1LdQTDIRv1mWLQ/tYo68CwCaAci7/sHsM95b0P1BOkA?=
 =?us-ascii?Q?zFgPtiHuTyjzV9W8ZvlVIZ6VafK3HFlSqZ/WHGHLV3wojM3VR0q3bouwCBRv?=
 =?us-ascii?Q?u8ZQ0ZicdYsx6axsixUO8CVdkYvZeYGkcq6YJ57luKKymN7aEcKVpjWosRtA?=
 =?us-ascii?Q?XvYbGauf1GU4K8p1KdPk46RB9fFu9/cNNuXpSDtXD/6lj2E+7a/l19QJbrV7?=
 =?us-ascii?Q?B9PjiF7xSlkK/eKlcnShBZgBic8bJkKIyWTZWTpD5acG+6NsTMVF7qyKl/GZ?=
 =?us-ascii?Q?j7WAJOiDUR5+26bwxgaMBo3JQ8+XfdkzqfWlYOCynXz8XadV/YmBYulEd15K?=
 =?us-ascii?Q?tBaEJ2dtFeFtbMoYz1llZ1D/18zin3LCJMa1Ut28wJC8Gm4sdfrkahhwT07E?=
 =?us-ascii?Q?vw6IASI/sYcwxB6pYJoTc9/6jUR60i6sPOxmul3EYXLWuQoxirF4sgMg96P6?=
 =?us-ascii?Q?x40NRbw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Es/W8nBhptinBZvZwlsPUL6/pIOKuHHAaEaLhX24KJWty/UwCKVi0gB1WsTb?=
 =?us-ascii?Q?IojdU8R8LiSToQVKNEFUZsnuRM8V7kInR7xKcdy2Bv74T9cssiE9UIdg2Zzu?=
 =?us-ascii?Q?7RdPPzS6UbA/dIFVQGsjGQe9XOQH+0wtIaKjD9uArakWruSExQBT/LEp9P7D?=
 =?us-ascii?Q?jmU/t9I64AdCTl3r3muCP/AuSnsad/7TdZJtnLSJrcxOWUq0SazZlISMBbmo?=
 =?us-ascii?Q?f5jG/Eisl1TwS03B0q3rBTOVlxu5O8KzhsJqMutgTjsYN3hgjcuA/uU9//5i?=
 =?us-ascii?Q?nJrf8Se8mbD4ETbzbRPKIsv9Lq5TPoh0oRfcx/B6GeDmLTeR+ZCEbN659mQ3?=
 =?us-ascii?Q?ejCQ+eJioCWWYYBs9A4X0spqyuJDYFDzUoR2M1mDxbyBHpQdvKKZa5zSVtGc?=
 =?us-ascii?Q?yPA5dsd0uEN3RithdvRuOUE7E5qEcDRLKmBLO/eMFehADeE7tBU+n7s+UYyY?=
 =?us-ascii?Q?dglcW3cEJ3T8ILzBzRb70fCBNT+4gnG748AwBkfM4Vw8GRP19ZFu1v2gRZAB?=
 =?us-ascii?Q?n2oycTO+3Oz/iFLNoHH/skWHqye/Imxco4WTFXD0hviLFftoMk6lA8p62Hpj?=
 =?us-ascii?Q?QcBSNjOzFWXpfuznuHAoUfGv3TBDg0hHjqyeXzRaRVVAqThq8fY+bsscvbQF?=
 =?us-ascii?Q?FZMrNDHoITgxIGDTqtyiHB90iH5slAzjZ89G+Ljer03Pz1QG2pUVjqIJB0/c?=
 =?us-ascii?Q?WL/UO6leVos3GBt6hDj3SlFoeyV+kIZq5MFAUhPIgBUcC0DHjY85WxA38kZL?=
 =?us-ascii?Q?y1jtuLCghpuEXdCyzlLsGLEXrzDKkEq5M1Iwdk7r/Fe/Kjc2gPYNygMtaxO9?=
 =?us-ascii?Q?zc+cfKGMlSD4nXd0QcpuIeEsjkfTR1KjyRF/Rj0aON1qQr9vtyWVToYvn91y?=
 =?us-ascii?Q?AkfJ/DaB4DVy2VTC7uw2z2vQapRTJz0Fp3X7Qa2HZJqVZha6OLDlTXjcchdq?=
 =?us-ascii?Q?6CVjsQXp4WhK4E5VZAcYbdinqOyJihuo9u3sS3NRZ+1cqqrnxI+XkUVJOdJA?=
 =?us-ascii?Q?5nLd3/iNE3ObhHjPMxoJfs7lk3zgTg2MZdiaV3Xd0sU8NvCvtLMyr3HJSsF6?=
 =?us-ascii?Q?sOPb1dYlvx0Pdi1RFOqVL9qPZCyN1cVrmp50yzHS8Nj9Cf6RLx2MtWkTkuK0?=
 =?us-ascii?Q?Q9C2WjWpKRlByJS6+uxJnhRx5HiubS0VrZ9t4oFEzsGrwjPAnr/TYO15exUw?=
 =?us-ascii?Q?AL1XjuiKaemtiwYsrw3mNU9X9qePn4gXadNPbqVbb6oD6nw4Nhds3CTvrnDY?=
 =?us-ascii?Q?PX1eqnYv8yvHYv6zZGPrj1kBHAS6c3na7k4h2tFex03peF8yLmwL8OFwPnLa?=
 =?us-ascii?Q?AlUudtqfnSV5QZQqg4qGMful4Rd48u+RKHKfYRsn4Ljt10Ubmd29037LopZG?=
 =?us-ascii?Q?Tfdr1v8U706VJj5nB3ZAwi6gnFTfxGKovDK67VI1qVetwrwpJTyYFfw01Ajt?=
 =?us-ascii?Q?b3Tn7VeI5hUdjN710Yh4Di7ADDIR5/cfv9AKflZjirMB80R0SxSOX6TAz/ec?=
 =?us-ascii?Q?E+Hmg7kLP/tfs3YrUvKxJMl7AVPDKRKr56yArdmdJklmFFs8lpyqyy9UBorZ?=
 =?us-ascii?Q?B6bbXhEmivK1Np01WZRxh2MI7VsXnpeF+mFTc105HYh1o8t5HZy7ky0C4krT?=
 =?us-ascii?Q?AA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54202f34-3051-4531-4911-08dcfa6b8ec7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 11:51:44.5648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xhwmSX6WfuYgC+nKlnRNK/EViAVt7IRiqsYgoppeqQuIrIewVujGhMxtzmHv1ZNsBEWHa0uwomwuMHBAefA3yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6979

This adds support for synchronizing to multiple BIGs.
---
 emulator/btdev.c | 88 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 68 insertions(+), 20 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index ca70ad076..08af873a2 100644
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
@@ -6441,7 +6464,8 @@ static int cmd_big_create_sync(struct btdev *dev, const void *data, uint8_t len)
 	 * allocated, the Controller shall return the error code Command
 	 * Disallowed (0x0C).
 	 */
-	if (dev->big_handle == cmd->handle) {
+	if (queue_find(dev->le_big, match_big_handle,
+				UINT_TO_PTR(cmd->handle))) {
 		status = BT_HCI_ERR_COMMAND_DISALLOWED;
 		goto done;
 	}
@@ -6459,6 +6483,25 @@ done:
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
@@ -6474,6 +6517,7 @@ static int cmd_big_create_sync_complete(struct btdev *dev, const void *data,
 	uint16_t sync_handle = le16_to_cpu(cmd->sync_handle);
 	struct le_per_adv *per_adv = queue_find(dev->le_per_adv,
 			match_sync_handle, UINT_TO_PTR(sync_handle));
+	struct le_big *big;
 
 	if  (!per_adv)
 		return 0;
@@ -6483,6 +6527,14 @@ static int cmd_big_create_sync_complete(struct btdev *dev, const void *data,
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
@@ -6491,6 +6543,8 @@ static int cmd_big_create_sync_complete(struct btdev *dev, const void *data,
 			break;
 
 		pdu.bis[i] = cpu_to_le16(conn->handle);
+
+		queue_push_tail(big->bis, conn);
 	}
 
 	if (i != cmd->num_bis || !conn) {
@@ -6500,7 +6554,6 @@ static int cmd_big_create_sync_complete(struct btdev *dev, const void *data,
 		return 0;
 	}
 
-	dev->big_handle = cmd->handle;
 	bis = conn->data;
 
 	if (bis->encryption != cmd->encryption) {
@@ -6530,7 +6583,9 @@ static int cmd_big_term_sync(struct btdev *dev, const void *data, uint8_t len)
 {
 	const struct bt_hci_cmd_le_big_term_sync *cmd = data;
 	struct bt_hci_rsp_le_big_term_sync rsp;
-	const struct queue_entry *entry;
+	struct btdev_conn *conn;
+	struct le_big *big = queue_find(dev->le_big, match_big_handle,
+			UINT_TO_PTR(cmd->handle));
 
 	memset(&rsp, 0, sizeof(rsp));
 
@@ -6538,7 +6593,7 @@ static int cmd_big_term_sync(struct btdev *dev, const void *data, uint8_t len)
 	 * exist, the Controller shall return the error code Unknown
 	 * Advertising Identifier (0x42).
 	 */
-	if (dev->big_handle != cmd->handle) {
+	if (!big) {
 		rsp.status = BT_HCI_ERR_UNKNOWN_ADVERTISING_ID;
 		goto done;
 	}
@@ -6547,24 +6602,16 @@ static int cmd_big_term_sync(struct btdev *dev, const void *data, uint8_t len)
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
 
@@ -7257,7 +7304,6 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 
 	btdev->iso_mtu = 251;
 	btdev->iso_max_pkt = 1;
-	btdev->big_handle = 0xff;
 
 	for (i = 0; i < ARRAY_SIZE(btdev->le_cig); ++i)
 		btdev->le_cig[i].params.cig_id = 0xff;
@@ -7276,6 +7322,7 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 	btdev->conns = queue_new();
 	btdev->le_ext_adv = queue_new();
 	btdev->le_per_adv = queue_new();
+	btdev->le_big = queue_new();
 
 	btdev->le_al_len = AL_SIZE;
 	btdev->le_rl_len = RL_SIZE;
@@ -7296,6 +7343,7 @@ void btdev_destroy(struct btdev *btdev)
 	queue_destroy(btdev->conns, conn_remove);
 	queue_destroy(btdev->le_ext_adv, le_ext_adv_free);
 	queue_destroy(btdev->le_per_adv, free);
+	queue_destroy(btdev->le_big, le_big_free);
 
 	free(btdev);
 }
-- 
2.43.0

