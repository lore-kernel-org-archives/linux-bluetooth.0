Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2068.outbound.protection.outlook.com [40.107.104.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311DE155733;
	Fri,  4 Oct 2024 11:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728041765; cv=fail; b=EPhEIVfjLXbjfPzsJ18kAO1CUkky/tjfYktsEzcfAkGtzTmroLXHXnemkDtguGiZrHnsAdwsyBkKPpqWP8OO0EKTIEPjO+CVtR7H5ze7Havhr+s8fJnThhQ/Gbb0hhtB3Qw/Q9aYPbStjoujhGwyWwNyFjfywCi5d7UvWPRIg2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728041765; c=relaxed/simple;
	bh=k8vrUUACOULgNoi5Hw/3DBApYJZJo1+eDdAs+sp0mx4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eQrHxopbgy2vZ0SGoLjhDOFHCqgljClkrJMY02W2EIfMyfGTo5A0vqvPUbJ6ExsEeA0d0BoH1dmemCmqA4E0iY6dFBX7vYCFrpxEH7Bj412mXECuIPbVHTIVBJsab+My3CSfJveZxJEeWx7pTEwqq+hY0wWbdQ04yxQ+IFbYGF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=GTJ71AX5; arc=fail smtp.client-ip=40.107.104.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="GTJ71AX5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=li9plVXPytIAVyxj5OdUrsQQXUHHwM/dZ2AV4MpYJJGdesB58qT6Sp+OG5O5ENHw6JAiNfZUo98m5vbwlmpHSsj86ShYq2Fz9GcR12sFnF7HlQspRRJeQ+HBhaRj7Ar2p8iZigsYHAItgM8+eBxGSUm+74h7teFfRiAGkCpGSxrtB3nqlpV9PvrfWvEqikNNqgdSp8YR7JyqOM/cJGgRW63bg1g6aF1CJhlOEb5+rhM8bwwSEqzNCLz1CDjb/q8Vzkj+WPnEq0ZFwzda8usx5EdZBa1qji2zgh7oC0/gdWfGLxRJusaiOaA9EFCRaaCPjaiYawXh8sJilsKRbG4BzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UC7DbBaom0AncncKCw/yT16yG8BeyQOm9N6vzlRhz8=;
 b=nd7qRIXUM5KemTWTJiYbWtghIr9lpboIsZ7XeQZO3Y3l7Ptbw9rG9dOZzE7kNsquXzADzTexfXUx9/3jzQb+rfjPKh9QTCIv17H20OcarIeP59Jy6YTFpNSPuqzFHP19Oyza1uJqrb2Fe8JRpeFKMwMs3tjhwSgZTcPTxaWUm3WKYWv2OTNEZOAtRIsNbW6YuUTUlzn1Zdktd/A9kZv+RH1V8bsLuftPLSo7Cd8RhnN37/OKS5IusBFjbM9zOvhPTB0IoQ2o5ntPlm0ooeTU5POljoZFL1A7tjWNL8xygfuQqn5iED1p+/G67jW0pxU2/s4ZKE/YcDLoRqJqse4kJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UC7DbBaom0AncncKCw/yT16yG8BeyQOm9N6vzlRhz8=;
 b=GTJ71AX5r7/+JsCJH2u58oYnCNYQOA9mD2zwJ/bfmYrNp8uEIgVGTy6q2WJPejG9W78CvIBmBgOkGb8klVWYcxn2RMa/BhZ8ovvy6O0rYR0ZIiUzoxjRFD62zxVH52uUkEq6y4VokAq79NLz6vpfTuUfexEFVNOns0xtV3eKLiw=
Received: from DU2PR04CA0064.eurprd04.prod.outlook.com (2603:10a6:10:232::9)
 by PA4PR06MB8449.eurprd06.prod.outlook.com (2603:10a6:102:2a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 11:36:01 +0000
Received: from DU2PEPF00028D06.eurprd03.prod.outlook.com
 (2603:10a6:10:232:cafe::b3) by DU2PR04CA0064.outlook.office365.com
 (2603:10a6:10:232::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Fri, 4 Oct 2024 11:36:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 DU2PEPF00028D06.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Fri, 4 Oct 2024 11:36:00 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Fri, 4 Oct 2024 13:36:00 +0200
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
	bsp-development.geo@leica-geosystems.com,
	Catalin Popescu <catalin.popescu@leica-geosystems.com>
Subject: [PATCH 2/2] Bluetooth: btnxpuart: implement powerup sequence.
Date: Fri,  4 Oct 2024 13:35:57 +0200
Message-Id: <20241004113557.2851060-2-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241004113557.2851060-1-catalin.popescu@leica-geosystems.com>
References: <20241004113557.2851060-1-catalin.popescu@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 04 Oct 2024 11:36:00.0355 (UTC) FILETIME=[9612FB30:01DB1651]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D06:EE_|PA4PR06MB8449:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9184b558-592f-4092-4574-08dce468b8ff
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PTmMTSN+IB2rYLJAXq6WjpCr+54pe4o1dpSAnRlev9AFFvNCAH5BkO3TAKbP?=
 =?us-ascii?Q?DSjB2/WGeAKNqozUNbB2Cs1/CJRqVhDRfRrWYpT2kxcPHkMw1BRfZ0ygKWZ5?=
 =?us-ascii?Q?1zIc1rb32yxQ/0Updi8/5KgDAHykALY9J8dFrHEzQF8jtCjvHri/V6Qw1rxj?=
 =?us-ascii?Q?Q1tkGqgEFk7+OyTlWe0KCwPrJ72LTgHkBdGHH0mFk3fAp5uzKY3l2f2RrkRa?=
 =?us-ascii?Q?bJSvqy7VBXa1eC/NTvCHnF41L4CGpApyBOVE04vRTIL/De4kt0hd+BtDRTJQ?=
 =?us-ascii?Q?mtZ5xlA/+FYZchySzOcy2Qv90ET+PqCmCKw07AqbESDlv6/5Igem6e15kuS4?=
 =?us-ascii?Q?+4JCLa0wpK7rgfThk6QkaSU2o5s5Hl2qOepYra3+vJrGd3hfMKFfLfAXX/ae?=
 =?us-ascii?Q?JVcWQdYVJ6e/+cC0mJLAG9UbiHTEkK20VSoyCAr8nND5E4QjTafuWx65j4h1?=
 =?us-ascii?Q?AVbdF4wNyRqaEgBmPKmbAZhnYuxDW9trw1btxk+4if379GxlRBpAb3nRE9My?=
 =?us-ascii?Q?ffN2FmDgFGO814KAiIJXGA4fwcRm5dkBpJ3JS5KFZT1KJA6y+lURILS3aSRe?=
 =?us-ascii?Q?XAZJhcugx8eTjKmOeSRwPAbzebexi43tBas+HoQRv1TuWzpi4mN+jR668M9x?=
 =?us-ascii?Q?msUEDI6kaZPL78sQQStb+xLRTRgmlIXiKQiVfgNMmjzi43QLa91CkSjYxMbP?=
 =?us-ascii?Q?mdK2LdJzw4WtaBafpA1oy2M3hEnTWdgudpX/WlAR39LnyhFTsyUhkXp2pOOc?=
 =?us-ascii?Q?UY5rOjQLI7OGGjJOixCeCcBRRjL7JI3lv8P3XNYFbaY1gflJNIL91pb6ZH4t?=
 =?us-ascii?Q?QN1/zuwsBRbbeCjKGGGe3MMvKViB4DjF98zLg2ORZLuDIwtOco63PTxVjRK4?=
 =?us-ascii?Q?UXwPxbbaKmJUerNhyMdeCY9iJYX1EoJj2TDygnTOSl+wtW2DI7Nyx698j8wW?=
 =?us-ascii?Q?2Y4boL6jT/BecdrbIk2ERON+5vM/nU7IFaPNHXa7pSOveVpGa7J1QrRM2EGQ?=
 =?us-ascii?Q?OUTLOXUDQ5Meg1QbDMXL+AoHtSAPakHCrQq/OM8lNfdPlguftP1JhOZ8ZJPr?=
 =?us-ascii?Q?FZzFwL0b/L4jeU0q8dmYfmtSk9evhGQoE/hKJbN/9xS5eJP6VVelyFURW17h?=
 =?us-ascii?Q?0+GYxhDZcqXDNNVuYBx/LwcoCo2pYzExQHhcdTOzP7Rth4lzQZ3q7UjP+6dp?=
 =?us-ascii?Q?NuMbcQJ7VH+V/HSffGQ9k33J0v+9IL9dToEn0OVktnHnU2RihQtsORoWpqqF?=
 =?us-ascii?Q?FSa1voXv7BR6EQuw8boAwz7Ska2dJVkMujny8sJEDUR1pmFFJHO0sh70VwUi?=
 =?us-ascii?Q?Li4RdFlsQlLuDu5s6ucR5Bazg3vR3CN9gsaam+ctgwL75lnvdYyX0qCSx3VF?=
 =?us-ascii?Q?rOnpBZ/XCqhTmOR7T5w1ZqNq9J5g?=
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 11:36:00.9986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9184b558-592f-4092-4574-08dce468b8ff
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D06.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR06MB8449

NXP bluetooth chip shares power supply and reset gpio with a WLAN
chip. Add support for power supply and reset and enforce powerup
sequence:
1. apply power supply
2. deassert reset/powerdown

Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
---
 drivers/bluetooth/btnxpuart.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 4f493be763b8..e58e7ac7999f 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -16,6 +16,8 @@
 #include <linux/crc8.h>
 #include <linux/crc32.h>
 #include <linux/string_helpers.h>
+#include <linux/regulator/consumer.h>
+#include <linux/reset.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -188,6 +190,7 @@ struct btnxpuart_dev {
 
 	struct ps_data psdata;
 	struct btnxpuart_data *nxp_data;
+	struct reset_control *pdn;
 };
 
 #define NXP_V1_FW_REQ_PKT	0xa5
@@ -1458,6 +1461,7 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 {
 	struct hci_dev *hdev;
 	struct btnxpuart_dev *nxpdev;
+	int err;
 
 	nxpdev = devm_kzalloc(&serdev->dev, sizeof(*nxpdev), GFP_KERNEL);
 	if (!nxpdev)
@@ -1485,6 +1489,16 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 
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
@@ -1492,6 +1506,8 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 		return -ENOMEM;
 	}
 
+	reset_control_deassert(nxpdev->pdn);
+
 	nxpdev->hdev = hdev;
 
 	hdev->bus = HCI_UART;
@@ -1509,6 +1525,7 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 
 	if (hci_register_dev(hdev) < 0) {
 		dev_err(&serdev->dev, "Can't register HCI device\n");
+		reset_control_assert(nxpdev->pdn);
 		hci_free_dev(hdev);
 		return -ENODEV;
 	}
@@ -1540,6 +1557,7 @@ static void nxp_serdev_remove(struct serdev_device *serdev)
 	}
 	ps_cleanup(nxpdev);
 	hci_unregister_dev(hdev);
+	reset_control_assert(nxpdev->pdn);
 	hci_free_dev(hdev);
 }
 
-- 
2.34.1

