Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011030.outbound.protection.outlook.com [52.101.70.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C490255E4E;
	Wed,  2 Jul 2025 11:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751456496; cv=fail; b=pdRi7qGX/Bt/gVxPAKKWPDVtQh5IJHq6VB8I8cJ1nid8hCtRvZSD50xQjm1Uj+ENqjF4H9Ex0UMDi2LRYISCeWKzx7K3/Fy5GWRaX1I1dFYqmyUMX/+K6p1gVCxZ704UFcqUbdLKNMtEkNX0bGrq1YPwUGQb5YhbOmJdmo+hbOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751456496; c=relaxed/simple;
	bh=RNbNJTEuKC9dms5AatRyssohGMBbky82tU1w+HGBaPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ec5kJfdY+pN7MygQk+ZAVv37rtbrc8i4lPthKFRSRoGFpwdxYW5sieNdVP8EvkFGaLsz8QNfKbKNtzEF7ntIIzaY8pUzq98Q+CcYjP/9yhBJyFjZAA7wgWi5kUmCVPfknNIdU/oJHR6qaqkzFzUCZPzhn2CkGfsOfovhlxJmc8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=uzO4camL; arc=fail smtp.client-ip=52.101.70.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="uzO4camL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SWtOsDT3fRHFwIYz1D+zGM168Jkolbr4/WfE44fNy5ldbet2Ufr4BtWYtjKB2zIxA7shwVaHacibQEA6iPnoJvIaUw49hgS/nRpr3RVDx+h3sW4PgYgLYpqBfRmkOgT+SCtMMPuUKXHCdL/OykXUYWpCHr1cAO/BZ9xlSv1ibLt8jiT13G/1mZsmMYgvPmSgb4CVwDlCOXcC1L1EfPi0vd+UUCyjoExCP3rHgTCaH1stZERETPXrJpsoKCGn9I5TZsitdED0zfAWUn6RI4FOoGatxr2fq6l8S5oV7YcS84kcEiPgMFM9ZVeJ35MuUW2RPcCDGWsXKpQQ3XkMo3djlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ii5D4TvskPm6w+9hsyAtuddG1j/nrystbqrrVwB7hQI=;
 b=xnDHEYGWPzsvQlGIZifq2vn+6B2/apFZae0+SfKeI9RqCYy+pSZgpk6wsRLjIXV8MtOij/8k4FLxIlk7GCeiJRyx+i/0Egt9evKcG+1Os8th9l3+ZSBAPAElrWejGPEz/bpKof+rKmd0w3d4Hjx90jP/nbyWK1yqYo8riNjhpBq1KI9TjVdR7TaDg757Cma7GGbYR7WSS30niPBAmQ+k5rBpjeaSSck3B22Lxhaww2ef3vHXl9Ja8sfI5qPgjPPeHsyZWsigrBsJnL7dAeu4kIspsDa1nzud7IMrnC/TJzJr+IERpaA8EK6dMtcZEn8q3TM9onBRf1L7fw5ColeDhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ii5D4TvskPm6w+9hsyAtuddG1j/nrystbqrrVwB7hQI=;
 b=uzO4camLg2blWf11GslRwxN74AMoAnk8OmPpivxBwt0gkyVsRRsD/TSw8hKKRUfxUDsbv3oVCOg3nxo3ytVUPA34yge0+oy9nAUOdkutCCWhfPCmKlH0qbfLgRwHZt9lwrCiPEQqD9TgMVuZtD6ecvEs+m7eZBuFbCNPoqunaNs=
Received: from DB9PR02CA0026.eurprd02.prod.outlook.com (2603:10a6:10:1d9::31)
 by PA2PR06MB9173.eurprd06.prod.outlook.com (2603:10a6:102:404::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 11:41:31 +0000
Received: from DB5PEPF00014B8E.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9:cafe::eb) by DB9PR02CA0026.outlook.office365.com
 (2603:10a6:10:1d9::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Wed,
 2 Jul 2025 11:41:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 DB5PEPF00014B8E.mail.protection.outlook.com (10.167.8.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Wed, 2 Jul 2025 11:41:31 +0000
Received: from AHERNOBLEIH55.lgs-net.com ([10.60.34.120]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Wed, 2 Jul 2025 13:41:29 +0200
From: Catalin Popescu <catalin.popescu@leica-geosystems.com>
To: amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de
Cc: linux-bluetooth@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	m.felsch@pengutronix.de,
	Catalin Popescu <catalin.popescu@leica-geosystems.com>
Subject: [PATCH next v4 2/2] Bluetooth: btnxpuart: implement powerup sequence
Date: Wed,  2 Jul 2025 13:41:05 +0200
Message-ID: <20250702114105.2229008-2-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702114105.2229008-1-catalin.popescu@leica-geosystems.com>
References: <20250702114105.2229008-1-catalin.popescu@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 02 Jul 2025 11:41:29.0232 (UTC) FILETIME=[400BE100:01DBEB46]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8E:EE_|PA2PR06MB9173:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 91776632-cf26-41e7-ea66-08ddb95d63e0
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lt0z3zqjAsN3e+KjSaszYbn38ZVdEsK/lafGuDJX0IPa4O3jsijHpqdKbKAM?=
 =?us-ascii?Q?ENJYglA7NvPVpiPNOG3oYqDbzsoHYSUgFF2qwUrZI/eazDc6LLBMUOKX55Oo?=
 =?us-ascii?Q?R0IYAurAxBDbkqfLgPNWQh9JAyZl84NTt6s6hXD4Z6ewYdIBl3y3T4GpVThJ?=
 =?us-ascii?Q?XMXNvf3Y5nwqWvDNMgkxmzKWUf5uFfoIaxBY4GfD+7ggqp/4+5U/VJ5N9Rnx?=
 =?us-ascii?Q?/8K+dA3TwCX+WGhqTbgMWJtRCrUsC7zVr1O+kpzVfngi1zyilQ+Xrt0nKOmj?=
 =?us-ascii?Q?h9qcn+MjWSRQi7au2G4wFfQp6X0Mr6poavGD5FK0m1THrJ6795ZSVmn/DCoO?=
 =?us-ascii?Q?5Eq9wNGNHC+k1BYKjLMm4uRtFLtUenShDMFp3veyv+Obp6BmGkvEJvwe8bgb?=
 =?us-ascii?Q?10BHSFwGa7LzpFPNwAjU/sWf0H/Iny/RD+b0ENvsUJGAQUNrrzRuy8MVNi6x?=
 =?us-ascii?Q?cvMjQKbN87P3vwfxD2JM5Ngc9+NlfPGTxBpTfCDw+QxrLN94qirqCWQRowIa?=
 =?us-ascii?Q?1A0174M7knT1T+2ac0QIwrNVoAfqxsVPJ7iggfwjt+bGMmA5vbS6fVqyGPcN?=
 =?us-ascii?Q?ilwxNEHKgszwF3vxTAh01OJONtPrKRwTrTBrroifRqgefXhxuwY6feyGcPJ7?=
 =?us-ascii?Q?cj0Voh2mDrrB7TSBlYeuZVn82Aplh2lST0ctN3RFVZhUo5+vsQ8nyAVhEpzw?=
 =?us-ascii?Q?vRxNBKSic/JmqPD3ZwGOzKac0CLAcntkXgJVYCw1W7qRBFNapXAMIQ8qBHII?=
 =?us-ascii?Q?XuXbqFELF+WoCOX7mQcFPGfIBSWl7L2286Ty64WncpfQ3/+ojeqhOQWhJU5y?=
 =?us-ascii?Q?oaJPninN3aCTx9oVPpJ+8Bl4GiLCI0dGa4KOSapEuxIG8fOttir4Hq1bR0sK?=
 =?us-ascii?Q?a7ufGYhRV7sWPYb5eb7vIdBOM02GZqPhtbMd5bPZavCxOOGLnaga9Tgd/VHN?=
 =?us-ascii?Q?gEjwRKVmcyAxnwSbkWCkX4AOENU/vQr5vObnpjcNhOaPaCngf7Vf3uiPN20C?=
 =?us-ascii?Q?1qOkrFsa479b81wxupUi6Ov11qCOJJJi3a4xYAjq0ZaX1UceA0W2H3KHFsp4?=
 =?us-ascii?Q?e439OAc0DE2T3Y80oAQnCXquJysUL/SI5qe40fr7CSWwRE+wH+uyWLtozsFx?=
 =?us-ascii?Q?lgVtXoUknj4bjMNS5AJEoNEWZesY9W2SZM3U8RNpZasVQH27bXH0r699sSCF?=
 =?us-ascii?Q?MZ8jRsgXj+7C16sWHZ9FUctxrb+5dxKeJPGK6HPAokzMhGTEjfgNUQ0lY4eI?=
 =?us-ascii?Q?TqeuKLw+vnffq/APpkp94pIrqJld5Qu7tMQ105QPX22Fm//m+qk88aml8i+9?=
 =?us-ascii?Q?iunF4oDrX2sAMybyqNzw0uLs4vDg9b6jqJcTLHQXVEdKCekxq1Fo/H2mO0/J?=
 =?us-ascii?Q?oJiM+HvfK0Ge5wUlVj+KH6pS2vXmA6/qli+xXHxCljoDPzqwJ1DyQizSIqp6?=
 =?us-ascii?Q?JbdFRqJqDfZI6Qd03YF+/ZVyn1OqlUnWoIddRwVbMuvH3vuC6WN5kWYLEk1F?=
 =?us-ascii?Q?8lftgOoncTcWE73Sqky6NORPrt8s7Vc9YDaz?=
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 11:41:31.3814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91776632-cf26-41e7-ea66-08ddb95d63e0
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR06MB9173

NXP bluetooth chip shares power supply and reset gpio with a WLAN
chip. Add support for power supply and reset and enforce powerup
sequence:
- apply power supply
- deassert reset/powerdown

Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
Reviewed-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v4:
- rebase on linux-next tag next-20250701
v3:
- rebase on linux-next tag next-20250409
- fix issue reported by CI regarding the subject
v2:
- rebase on linux-next tag next-20250227
- add reviewed-by
---
 drivers/bluetooth/btnxpuart.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 25857919359e..b25096b8980b 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -18,6 +18,8 @@
 #include <linux/string_helpers.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of_irq.h>
+#include <linux/regulator/consumer.h>
+#include <linux/reset.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -209,6 +211,7 @@ struct btnxpuart_dev {
 
 	struct ps_data psdata;
 	struct btnxpuart_data *nxp_data;
+	struct reset_control *pdn;
 };
 
 #define NXP_V1_FW_REQ_PKT	0xa5
@@ -1757,6 +1760,7 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 	struct hci_dev *hdev;
 	struct btnxpuart_dev *nxpdev;
 	bdaddr_t ba = {0};
+	int err;
 
 	nxpdev = devm_kzalloc(&serdev->dev, sizeof(*nxpdev), GFP_KERNEL);
 	if (!nxpdev)
@@ -1795,6 +1799,16 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 
 	crc8_populate_msb(crc8_table, POLYNOMIAL8);
 
+	nxpdev->pdn = devm_reset_control_get_optional_shared(&serdev->dev, NULL);
+	if (IS_ERR(nxpdev->pdn))
+		return PTR_ERR(nxpdev->pdn);
+
+	err = devm_regulator_get_enable(&serdev->dev, "vcc");
+	if (err) {
+		dev_err(&serdev->dev, "Failed to enable vcc regulator\n");
+		return err;
+	}
+
 	/* Initialize and register HCI device */
 	hdev = hci_alloc_dev();
 	if (!hdev) {
@@ -1802,6 +1816,8 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 		return -ENOMEM;
 	}
 
+	reset_control_deassert(nxpdev->pdn);
+
 	nxpdev->hdev = hdev;
 
 	hdev->bus = HCI_UART;
@@ -1840,6 +1856,7 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 	return 0;
 
 probe_fail:
+	reset_control_assert(nxpdev->pdn);
 	hci_free_dev(hdev);
 	return -ENODEV;
 }
@@ -1867,6 +1884,7 @@ static void nxp_serdev_remove(struct serdev_device *serdev)
 
 	ps_cleanup(nxpdev);
 	hci_unregister_dev(hdev);
+	reset_control_assert(nxpdev->pdn);
 	hci_free_dev(hdev);
 }
 
-- 
2.43.0

