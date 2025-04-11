Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2066.outbound.protection.outlook.com [40.107.105.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B9921CC51;
	Fri, 11 Apr 2025 16:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744389341; cv=fail; b=KP9eASWoAUbaJFixFPq2eKuifDEVojt38z42YW5aGFa6/zlfLRwJey/BbOjEJgWmVGOg+pveE2fFhmLTsOcPjoFUA2xxTZlsUTK1kkfuCag5/9USkJveX+FRUg8yVkQmvzNXmdyYBozoDWpJD+6LxfMkiQDCiWEVLBnTO1RpbkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744389341; c=relaxed/simple;
	bh=pVXgEFuCmKBWcoWrG/Wv1QME5AYjIqhuTA3aR+oZI38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mjJWKV4tV1EdJZ4JXAV6BH63TdD6OpWWcARSKRY8hdQnU5r/+yxEmZt1JdHLp+e2xhgY1rg2yOWbF8QPW+eEQSFZk2QLlPMjzNPnH0Qtau5vRjJzjWjiw1NqT2wuG3y/pYw3kCGGeBvlBOen7W4MTJbSL1lqNT8+B3/JrHdhfZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hHo6g/5P; arc=fail smtp.client-ip=40.107.105.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hHo6g/5P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oD1kVSt16Ze9HsoWKUc6Jwigfbn5sRe5yNY0gSw9nsKsS3zoYUXw5gjIr962sw4NojgmCqswQ1qhRgZDqZHQyLSQ3/9Ejbp/OhRwIpn/6W/zLHSK8dy3XQEnoA0/F6xVQM9d7NG/ZN/vvrnDYDv13dK7pHIgSv1OO4kRodS6kBjmegloXQ/ITGA28iA634Ex7KWa25JXoN2yBtSkPfzqIh5X2H3d00ywf2bNVWWOpXndcF9vL0xcvXjWD+Pa9aZ54TDRnCR97BSkqX0dp8wwuvnM1yTca1oCqgvjltZ2mtiX+HewCH4SCMM/iy1f0O7LElrW0kRFknWadhqa0C+lRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTiNPnFm8JiuQxDfUMw7zuBoe7dHefp+PCBYoXPTpQk=;
 b=uIK9bKkij3GxfNgqcXt/xq7rmNjDpRjnAcHMahK6i4ci+9MLg2hWcJfMB4Vf6/21d7L93q6VGGsfCJBSWTVoKXN67muLkEkSr/gVvMcy+NSSKzLdk/c5C29fevPxpJ6hyf0U/f8H3CP6UjMjjxmiui7U40AnQ12rcEELRlmQ4eCb1eCSlPVoxwYYzC96XUzNSV6JTEanJmj+2+RwW0MmYeN2RyOpeROALRJzNqABeb78svaJAaEU1NhqPHd3bYeTZjNPfh0MzOcDku0944Q8H1pIURZK6OfbthQK4i8CXrQoFoDZWTq8QLXYuLY7BdLykJARfhlSo3Vp31XkH3QnqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTiNPnFm8JiuQxDfUMw7zuBoe7dHefp+PCBYoXPTpQk=;
 b=hHo6g/5PTDRMLHrrpsd2M7GuN33wGVTpuZizIVmK3sJlRIyx2rQZyCUSISjlslveneyzh+TYTp5QtkpjfhEAa3ayUuJ8LpUEoj/Abx4jeF+v2Eggbk/xtBUkfp6qEkULxgelA4Piy/jkDuf4ijhmubfHPw76Gy8V0eA8aRAFp2iLnbNCNQXlggIyK/f2PPt018qnLbzlEdN7R7yyXSNSQgsmA/1WsFkowcruGvlfiXI0qrEtrozGDjuQJcmCxE6G0hNHwCY8yun3b8dE/g9bZxzW/ZJQXCxuDM/TgYYzY0L3cOHTPB8hhNiLJ8pHNZE7Ue5OTfR6Jk6T8oyA/2ZABQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PR3PR04MB7291.eurprd04.prod.outlook.com (2603:10a6:102:8c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 16:35:36 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8606.029; Fri, 11 Apr 2025
 16:35:36 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	manjeet.gupta@nxp.com
Subject: [PATCH v1 2/2] Bluetooth: btnxpuart: Implement host-wakeup feature
Date: Fri, 11 Apr 2025 22:07:19 +0530
Message-Id: <20250411163719.326558-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250411163719.326558-1-neeraj.sanjaykale@nxp.com>
References: <20250411163719.326558-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0214.apcprd06.prod.outlook.com
 (2603:1096:4:68::22) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|PR3PR04MB7291:EE_
X-MS-Office365-Filtering-Correlation-Id: 6942d08d-30f6-4c03-6b72-08dd7916e2cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f61Wqot5FaDF/413TfyGV51l+BAjI1zgZi10X6iSURF2QsrVR0PRirWHNWXT?=
 =?us-ascii?Q?czbNRwxxJWP23d3uh4GCaCiM4VUnfTZ/bLEbojuPyY8IaZXuqB4SEcpRuD6R?=
 =?us-ascii?Q?ja4BSrZcfGKnXaPq2h2QTDiPSybihc2tRgonyHTi/hhuq3NjM68v5TLzCIDF?=
 =?us-ascii?Q?TabOi+qGYB/W6FgqfQipkjvsgKSU5ain/7G9sBq3iSi9f20m0iMXRl6LSkDN?=
 =?us-ascii?Q?GDkVqSLODWSqVsu5OSSEq0xLJSllRI9LGBsF0ap4Qg23Q/jtCX6cicOD0Sji?=
 =?us-ascii?Q?BTHeExYBsG4ZakVZwX94SQ4UC5RxzJdkd3f5A7Rl8Ao4t7g91zMvvX3yk+LA?=
 =?us-ascii?Q?/pReK0vGb6sqaFwf27JCuVtsD1eP3YvUmHZD8Qy/G3jkYyThWakfDyBL+aG2?=
 =?us-ascii?Q?QB2aBCd7Vtf5fYsPE3164RSBEIY8oiGmFWiVdAM6R6ieVcF/8cCLoyDSPfHb?=
 =?us-ascii?Q?5GgsbiaG1AEAqGP+fmrSStoxsmw17S/hgEdo3ewjTQ58MeesFKhDZFYRMoH4?=
 =?us-ascii?Q?VzRWwOfBgxTUrb1JmWTIIX825s6/vpT6J3TRx5vKUwujj3r4DD+unWqlUyfz?=
 =?us-ascii?Q?GVY2VnrOzoq0219tKgm18eo2/4bQb+dao05RGfol6HVabhh++ajnFFL5skgL?=
 =?us-ascii?Q?mhbvpX3tAsLQwkf3xFcphtZep45cjD4/RIkfOWxAgk5GXbWUnuYWj1NkMm85?=
 =?us-ascii?Q?PFMAKeZNzJ0y3QmxIJhQG+Rk/7igr9BYVdt20bye/AFDURP5eb8zedrxQEeU?=
 =?us-ascii?Q?Oky+eBVWNoU7DfaUWPOM+yfZk7Ad23J2LSNxgx169BUhGHxmDBzMsQX/bhW+?=
 =?us-ascii?Q?s9Y3xDld9zoyODcJzQ2+847Mcoc/Uduyls/bCMZoIqbWRPy3m2PXL/8DgMc8?=
 =?us-ascii?Q?JrftdzacdFThbqSyvrZEoav77OslcVOSpTLbDrcLggl9NWwOelx3q8ymtotW?=
 =?us-ascii?Q?9FWrfiUlUxdSt7Yyycr6fNYyHdmeSJdMlZeRO8ttYAFOUfd0EOp2IMPJzltl?=
 =?us-ascii?Q?0IrZmsPs3QwGW579Th/n9aipTvwSv7/jSamV9iRVnS1Nj4+VGJJFgkz+fRSr?=
 =?us-ascii?Q?390TskY9Rzma6mx7FY69wZKVlhfgzhUl9/LpFqQYmNLmoNfbcc+oPzSnVKOv?=
 =?us-ascii?Q?AewAuL6wP9WX/xMBqMPOIMBxOtw2SisqBJtxLNGnaLtzuCe58AdvfBfObwJf?=
 =?us-ascii?Q?aORmJawYS3Ve8UAN1aky13uT3imj2eU9uZrY2jvuu/P+TtDGwY3674dM3Hnm?=
 =?us-ascii?Q?XCoy3Gde8MkLLCOP1y5WpxHKsR+uky02J3gZO5pUQELIl6qrxCuRX2q39i6z?=
 =?us-ascii?Q?p0WNHUlNFcsdSFp2cvP10OAeMOhVOfhm2oWTzazBfLSYf78YeCevBdA3TDxv?=
 =?us-ascii?Q?GaxT+g5p71XzUVxMs/nb2UbJ4D2wthZD3jkgjGZcwXU5O7ynT1oltUxQoIRu?=
 =?us-ascii?Q?gf7eRl+wlbsydZjwjxWew8p+D5w1UP2D3T4J0NQb2Ct6bFNV1aDkNg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MPN5qkUuF9obP3/X9irlgAl/UxKrY43VQibciYXwaaIezKmjzLAccnKgjPnm?=
 =?us-ascii?Q?ugBAcuMDzeApvsAEiodf/v8nBmYQFUlaJV73B+luxn99Bt4ZL69V+pEt7sfT?=
 =?us-ascii?Q?SB7Mpef521Dxc1IJDpGU4jn4TChRKKr47Pk9atPINNDU0atiIMmedLrqbxgB?=
 =?us-ascii?Q?jvJVYLAFA98TEhj51BiwqT3zggXG/MMq/NMRDS+BNZRuFp7DxJOgSmKKQpR1?=
 =?us-ascii?Q?sxV9AYo8/t0UThRVRgEZRn3n3B6+LPBLLey+AZQ5ArzcwXMtQRt+oMhADNzW?=
 =?us-ascii?Q?h3bY5dXSSPyrOmug3gbu4iudrBjRVKcwgdxujeUQP8KVYShNIyjb7N0+d1G9?=
 =?us-ascii?Q?dg/QdwNUjOaeBzptFACUSK9fkfPbzX1VOmpmKuWvs+fsCePPo4x/13125xJR?=
 =?us-ascii?Q?pTWQy5bHxA5uMem/2RH5kAdCqO3O2B+/7hPcYNSeP6vX/kl1YvBzlu/b0exb?=
 =?us-ascii?Q?N560vJCtXPHZuWc57EvRZq7q/rKlZCfbz5P1liZp8VBztzvv4nP5WR/5FRxR?=
 =?us-ascii?Q?PibVgRaIpD9JhLnYJIB5z7oIZ4vijWvKTNpuZM2jzuY4ZnJ8n4sXwKhLaLXN?=
 =?us-ascii?Q?TfyH18EqkJxfrXuBZNk4i8xAU0cST9UHE0nd1Z6AJgnq25gG1cnGz79iU0AR?=
 =?us-ascii?Q?hFdOS8ShIhrlRUfDYtie1ll7DBN3YQE6Uto6ygnVtS8Tarsw57Wh0bA0CYZy?=
 =?us-ascii?Q?uAA5YxJ7ckNcx6JkHtA60szNigljYo4xWgNFQ5gp8vVx112yvRnWqUURSRD9?=
 =?us-ascii?Q?bzYlq5PbqdW81oKo9DXSTVHZET5GbHdgTJRG6kw0WKttsCLPlDxt762uSzkK?=
 =?us-ascii?Q?uF1ceHiaIARQTOOUL099MWwSUR2b+r3QXvnZ7+oVdS9+oxkO23BsE+DNzMA6?=
 =?us-ascii?Q?m3RGvLUVrQcqm5dlEGU058pWPoTgAdo/iMvM/Jj11vHx3dcfvcYzxD3IyH4T?=
 =?us-ascii?Q?mYLl2VWLocGZAbmo4BPf6ceKAPEZvSTGSkju5637Xidod7ClSQRNfAkfM08n?=
 =?us-ascii?Q?QNSQHfmY6l8EFsTVKcc9fKnZ1lkgJ7Zh9RVjQU3k7f8Pq7nmHHXwHnzNjo5Y?=
 =?us-ascii?Q?96b/HtmZjhnXDujqBkscOlrI2XWiLPt905QA5TFkzc71OhA/faD5QpqO6v9d?=
 =?us-ascii?Q?wEcZqFQIVAUSnFyzsZ5/RCb4PFxKKJnrZNEBtaYQQ5Pg16cY4W8AsFzPwwe9?=
 =?us-ascii?Q?D/2RppT11p1kEGbfv3fFvTaEZOF9eWZ2epIDl+cekVI8kI6H1DrdyFstZwAt?=
 =?us-ascii?Q?r6CgkA1RuAVfcqkSoN8I/wEPrasrQcJIO19BMI6DN3PuKsN/RzkXzjBeh9Rr?=
 =?us-ascii?Q?jEe0Z/qDqibDoSrXhN1Y5MDPoyZIrjEoO7fB7qLWfe8/nSud4fF2EVMyiRBU?=
 =?us-ascii?Q?dH6SbUjTadix1Q5dUcuWqCTG0Yr//wYw3P9qs2yfkiixDVeYJL2tXZexkHH4?=
 =?us-ascii?Q?RpJowCy/SrF57qQPQbQ5aul3VL5G04Q8a2CmPQ1WAGOZyG6FUZmmY/2py471?=
 =?us-ascii?Q?eqjx6Ch2GNDBksm2jHamOy+LVC//hg8zW+uadMkMeDtZxYTbq5f/iCcZaZWX?=
 =?us-ascii?Q?JoUAYZZK0NGU1fYSmh6n62ry3wjhz6e5Wy1XcrrVj1Q/Hne7yrsAaI+mtpiM?=
 =?us-ascii?Q?QA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6942d08d-30f6-4c03-6b72-08dd7916e2cb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 16:35:35.9823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RaCOi7AO1xvrNWY8/SaHwgef4VFnJ91/2uZphw3nhZr9zctJ/Myd9KEmacA6KiuZk0pXMT8/PmFeqUXvMzqftafXzx2ZWzGR/LeU0Qddgcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7291

This implements host-wakeup feature by reading the device tree property
host-wakeup-gpios and nxp,wakeout-pin, and configuring the
host-wakeup-gpio as a FALLING EDGE triggered interrupt pin.

When host is suspended, a trigger from the WAKE_OUT pin of the
controller wakes it up.

To enable this feature, both device tree properties are needed to be
defined.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 66 +++++++++++++++++++++++++++++++----
 1 file changed, 60 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 604ab2bba231..265f6bb1c533 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -17,6 +17,8 @@
 #include <linux/crc32.h>
 #include <linux/string_helpers.h>
 #include <linux/gpio/consumer.h>
+#include <linux/of_irq.h>
+#include <linux/suspend.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -144,6 +146,8 @@ struct ps_data {
 	u16   h2c_ps_interval;
 	u16   c2h_ps_interval;
 	struct gpio_desc *h2c_ps_gpio;
+	struct gpio_desc *c2h_ps_gpio;
+	s32 irq_handler;
 	struct hci_dev *hdev;
 	struct work_struct work;
 	struct timer_list ps_timer;
@@ -476,11 +480,13 @@ static void ps_timeout_func(struct timer_list *t)
 	}
 }
 
+static irqreturn_t btnxpuart_host_wakeup_irq_handler(int irq, void *priv);
 static int ps_setup(struct hci_dev *hdev)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
 	struct serdev_device *serdev = nxpdev->serdev;
 	struct ps_data *psdata = &nxpdev->psdata;
+	int ret;
 
 	psdata->h2c_ps_gpio = devm_gpiod_get_optional(&serdev->dev, "device-wakeup",
 						      GPIOD_OUT_LOW);
@@ -493,11 +499,41 @@ static int ps_setup(struct hci_dev *hdev)
 	if (device_property_read_u8(&serdev->dev, "nxp,wakein-pin", &psdata->h2c_wakeup_gpio)) {
 		psdata->h2c_wakeup_gpio = 0xff; /* 0xff: use default pin/gpio */
 	} else if (!psdata->h2c_ps_gpio) {
-		bt_dev_warn(hdev, "nxp,wakein-pin property without device-wakeup GPIO");
+		bt_dev_warn(hdev, "nxp,wakein-pin property without device-wakeup-gpios");
 		psdata->h2c_wakeup_gpio = 0xff;
 	}
 
-	device_property_read_u8(&serdev->dev, "nxp,wakeout-pin", &psdata->c2h_wakeup_gpio);
+	psdata->c2h_ps_gpio = devm_gpiod_get_optional(&serdev->dev, "host-wakeup",
+						      GPIOD_IN);
+	if (IS_ERR(psdata->c2h_ps_gpio)) {
+		bt_dev_err(hdev, "Error fetching host-wakeup-gpios: %ld",
+			   PTR_ERR(psdata->h2c_ps_gpio));
+		return PTR_ERR(psdata->c2h_ps_gpio);
+	}
+
+	if (device_property_read_u8(&serdev->dev, "nxp,wakeout-pin", &psdata->c2h_wakeup_gpio)) {
+		psdata->c2h_wakeup_gpio = 0xff;
+		if (psdata->c2h_ps_gpio) {
+			bt_dev_warn(hdev, "host-wakeup-gpios property without nxp,wakeout-pin");
+			gpiod_put(psdata->c2h_ps_gpio);
+			psdata->c2h_ps_gpio = NULL;
+		}
+	} else if (!psdata->c2h_ps_gpio) {
+		bt_dev_warn(hdev, "nxp,wakeout-pin property without host-wakeup-gpios");
+		psdata->c2h_wakeup_gpio = 0xff;
+	}
+
+	if (psdata->c2h_ps_gpio) {
+		psdata->irq_handler = gpiod_to_irq(psdata->c2h_ps_gpio);
+		bt_dev_dbg(nxpdev->hdev, "host-wakeup irq_handler: %d", psdata->irq_handler);
+
+		ret = devm_request_irq(&serdev->dev, psdata->irq_handler,
+				       btnxpuart_host_wakeup_irq_handler,
+				       IRQF_ONESHOT | IRQF_TRIGGER_FALLING,
+				       dev_name(&serdev->dev), nxpdev);
+		disable_irq(psdata->irq_handler);
+		device_init_wakeup(&serdev->dev, true);
+	}
 
 	psdata->hdev = hdev;
 	INIT_WORK(&psdata->work, ps_work_func);
@@ -637,12 +673,10 @@ static void ps_init(struct hci_dev *hdev)
 
 	psdata->ps_state = PS_STATE_AWAKE;
 
-	if (psdata->c2h_wakeup_gpio) {
+	if (psdata->c2h_wakeup_gpio != 0xff)
 		psdata->c2h_wakeupmode = BT_HOST_WAKEUP_METHOD_GPIO;
-	} else {
+	else
 		psdata->c2h_wakeupmode = BT_HOST_WAKEUP_METHOD_NONE;
-		psdata->c2h_wakeup_gpio = 0xff;
-	}
 
 	psdata->cur_h2c_wakeupmode = WAKEUP_METHOD_INVALID;
 	if (psdata->h2c_ps_gpio)
@@ -1697,6 +1731,15 @@ static size_t btnxpuart_receive_buf(struct serdev_device *serdev,
 	return count;
 }
 
+static irqreturn_t btnxpuart_host_wakeup_irq_handler(int irq, void *priv)
+{
+	struct btnxpuart_dev *nxpdev = (struct btnxpuart_dev *)priv;
+
+	bt_dev_dbg(nxpdev->hdev, "Host wakeup interrupt");
+
+	return IRQ_HANDLED;
+}
+
 static void btnxpuart_write_wakeup(struct serdev_device *serdev)
 {
 	serdev_device_write_wakeup(serdev);
@@ -1821,6 +1864,12 @@ static int nxp_serdev_suspend(struct device *dev)
 	struct ps_data *psdata = &nxpdev->psdata;
 
 	ps_control(psdata->hdev, PS_STATE_SLEEP);
+
+	if (psdata->irq_handler > 0 &&
+	    device_may_wakeup(&nxpdev->serdev->dev)) {
+		enable_irq_wake(psdata->irq_handler);
+		enable_irq(psdata->irq_handler);
+	}
 	return 0;
 }
 
@@ -1829,6 +1878,11 @@ static int nxp_serdev_resume(struct device *dev)
 	struct btnxpuart_dev *nxpdev = dev_get_drvdata(dev);
 	struct ps_data *psdata = &nxpdev->psdata;
 
+	if (psdata->irq_handler > 0) {
+		disable_irq(psdata->irq_handler);
+		disable_irq_wake(psdata->irq_handler);
+	}
+
 	ps_control(psdata->hdev, PS_STATE_AWAKE);
 	return 0;
 }
-- 
2.25.1

