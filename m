Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2086.outbound.protection.outlook.com [40.107.241.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65561DC997;
	Thu, 27 Feb 2025 10:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740653847; cv=fail; b=RQEM0jI2fcW+y+Cu6x3ppFxBl0GR5kDTGWIs2OI4sjqSeDQ6xAJbfqUNMUZSjxVrSC9dLWN2jk9iL5D7D9L3aGZ3wlOGw9p5vizgd+/Ebi12+oPETSYdr7dVr+WpgSea/3cYPriBgBQfjUVGt4daYjyobO1eIGS+aOgb857jmCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740653847; c=relaxed/simple;
	bh=FBuvtKQoH9rRR2V0nyia4P1jrvbt75/iIqFGXg5bPAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iD5/QqkLjMNiZrggxScNk5Tk3i1sRk7aNe4y9z1lPPyduc7+ozyBvoSEP+s8/jVRsVUCB6itR8KrgqFIAT4WgzGAKbKJbVk37fifNJvJ9wQ8LgZeeAcbZ8BCs/3PwXtVJNWPyjhwWlvdNN3LwQexBAE+wmNIb8afwU93uZSw5JM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=jMVJkIjB; arc=fail smtp.client-ip=40.107.241.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="jMVJkIjB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fOoHrDQoomaIcK776XbZQpA646M2qdh4lLuUbrP62BaJlWHGB6ozsS+WQvaOP1Q+fdNtsTWUlI/O3sVx3ZE4sWWMqAkpDaPR5FfDozw3obZGfRLF7p++a+17yAfY5GQGar/oM07fxM2bq8NU4KQKWBtrCWWXa5CIiHaWhyAVce6F/+McLEHYX3MzDZvE8rRs3qbOQI+6mq/H7ZIzq3bzL32Pv/HpbHWtja4JvbRqAnBd6L0Ll/T0xrLqzUXiECdKayOthnjyE+3kaLgEzMNIju5bJyVUZ6cQzYz4XMFJ2iLB+U89hN9mZSbqbNtDaxTnjVOcC6ZCU7DJCDmRYcEDJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YU2K3+mlTJEuvXWjTNmJLFJCZTKoqlwksomBBxrPMA=;
 b=qzH0b98qsz5bGWkngKRsLLxbvomtTDJWPtaefICXVO4gswR3zkAkbCM57QTBW2UamG5yS4tJOz48xBI0r+PcCSVgu7guP1mXkNjX8MMMMCitEn9tbGICz2IfZrIXaAn+W2wUKKjA6YxkwQ5xQPza8fNlx0yiSQ737QcX/PINLErZF+M80DAoFpUPHIw8+YYO0KcByCTnGDJJRsnD2qkf8oS66duYq7eF6QlBQYVfM6YfM/zFcTM8oQ+CcUSpJSmP+CR7XT+sfFcOJxYWtEhxMcsvWjOq2P5j8RL+8bBFjBjmgXTwKGBm/GdWZeHSWg71BcGsTfwKxGb9TcbvD/tRnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YU2K3+mlTJEuvXWjTNmJLFJCZTKoqlwksomBBxrPMA=;
 b=jMVJkIjB1D8Mpuncsh2aJkImRqEvmGCCpBv08jWlrFGldfDC4fBEa0plMRFvNoUMEHVjx0fElyzzcXZ84fxxXfg+Ml/Jl/QRianV3Soy5LsgWEsG1/NjOKfvnaENJSw/sRTV/+XJsE0I1byrArspZv/jJBZWBgnZ8VrwIcJzZio=
Received: from DU6P191CA0069.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::22)
 by VI1PR06MB6799.eurprd06.prod.outlook.com (2603:10a6:800:181::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 10:57:21 +0000
Received: from DB1PEPF000509ED.eurprd03.prod.outlook.com
 (2603:10a6:10:53e:cafe::96) by DU6P191CA0069.outlook.office365.com
 (2603:10a6:10:53e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.21 via Frontend Transport; Thu,
 27 Feb 2025 10:57:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 DB1PEPF000509ED.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 10:57:21 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Thu, 27 Feb 2025 11:57:20 +0100
From: Catalin Popescu <catalin.popescu@leica-geosystems.com>
To: neeraj.sanjaykale@nxp.com,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	loic.poulain@linaro.org
Cc: linux-bluetooth@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	m.felsch@pengutronix.de,
	amitkumar.karwar@nxp.com,
	conor+dt@kernel.org,
	Catalin Popescu <catalin.popescu@leica-geosystems.com>
Subject: [PATCH next v2 2/2] bluetooth: btnxpuart: implement powerup sequence
Date: Thu, 27 Feb 2025 11:57:18 +0100
Message-Id: <20250227105718.1692639-2-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250227105718.1692639-1-catalin.popescu@leica-geosystems.com>
References: <20250227105718.1692639-1-catalin.popescu@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 27 Feb 2025 10:57:20.0577 (UTC) FILETIME=[5FB07310:01DB8906]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509ED:EE_|VI1PR06MB6799:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d41df6e7-f69e-489d-5295-08dd571d8282
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nQM2HpjWYmS9KQfSFCyvnOcmCPyME8AIjfbaJl1z7VFceYePnNvCiLUyb1ds?=
 =?us-ascii?Q?FgV7Ctiwg8I4x/BkFHOGjJjY+YtOojo9LSB6cM+DUb7VrGlY6v3+pE/3M1oz?=
 =?us-ascii?Q?QVQ6X1P5e3+4rjGO7Ilr0xJTwr7nZ/QzvRzKE41Oibd9DihIQ0WV3+PUTYkU?=
 =?us-ascii?Q?zSSWVpl1ioeiVL7dUV3HduUAtB710IsvaeMb1onXUsjOH3AmHRQKyMDPc46C?=
 =?us-ascii?Q?zmd8GfM8Ko2L1q0/hDzSd6m8APzp7FSmYuTXounPc7M7WH0MkVc34EsmzIrQ?=
 =?us-ascii?Q?awcekXWH1gsDbFZ8nEPKd1eC2TWm57YLSF4FcV0U7dWLBqrv6cDB/TL8P4Y2?=
 =?us-ascii?Q?Vvh332oGK4jlonNOYUYxA7DWLrG4PDlNKqdH9L9oX1Unw315EK+sY6hQ33rx?=
 =?us-ascii?Q?ycqY9Nv8JWOqT02HsUw1IIBnI06+qMbvXBZzsz6FqcqHnCgKrmb82QRjaNXa?=
 =?us-ascii?Q?/GTpgY6wx6jmfCBkCqy9qB3NHzAFMWYAmvCj1RjSDVKsYAxq/ujskPLgLp0u?=
 =?us-ascii?Q?H7F02IOPYzMIKj1BECOjWmXrGXicyc5SoIshV5NbbqD6YZIO/+TD659OMSRb?=
 =?us-ascii?Q?z1tPCoLfyA+wKLrlCotPOdj6rpV+8hmj8AN0XRZ6KcZGwVi/81tB2Byc67ax?=
 =?us-ascii?Q?pMgYVi0a/9nwz/9bzsYDihu2lN/5wHHV8Im9MlcxOn4ygo0+Xe5aYx9oNq7f?=
 =?us-ascii?Q?QE7NlpNLcCiEGexmkrSfsS45r3phsyiBgvbYKo0xbWKvErztIySU7NdA9nlq?=
 =?us-ascii?Q?goT8FCR2maz3ExAo2ptAiX+Ywt6mG3QGT0l9rQcTej+36JYGRJrNnhczz0P5?=
 =?us-ascii?Q?C6W+95pe7nsk5llSWpi9c83YnAaB/lon1+C635RAQmjc8Ra9QpPkLXZPHrCd?=
 =?us-ascii?Q?1XXrpJLs0wEZgiLVO3oKR27RwVqu0a3BLoqFGBDKt5nK7ql12rYQ9Sft4FEk?=
 =?us-ascii?Q?QVzBMY96yHGvzhvbV37KYv39jAr0sGytaHYnsnuFAxp7oy+r6V1Bl7mO9ZWS?=
 =?us-ascii?Q?Sx9gZr7/Gq3LabVnKvAwD/+eoa7ECgM1LPHDUaf6RzHj4JcJAoUBxex5/lL7?=
 =?us-ascii?Q?32aNkMEFLEMq7xB9gS/oOr9ZDatX4+zuUr8pFvIP7NsbKZHpL06XKjQE/pHq?=
 =?us-ascii?Q?trcOnTY6uNVOP/yU86h3qKUs3P9MlxeEF4FmmfjhQpkPX3NMP/KK/g6aZ7FT?=
 =?us-ascii?Q?kkGvBYp5PYTN+H/jBd2INPfel5Lo0I2JXsvFVNZ7bNypzDgQiHUpNMOKQTDa?=
 =?us-ascii?Q?bnhBvNYzIjcRLkob8lKD6xymaZocDdjrbFffbdOE4wQ6HorCwhaocqoN5v+N?=
 =?us-ascii?Q?yGPrqqPMzMm49z5OTy4r568quWRCAGmWpXmIy5gxmDJHQgxjExW0DoD+EadQ?=
 =?us-ascii?Q?rxyFUt2UnI2Q6w/r3mBkXNOxtmkMJwzpJ+viCLgZl5c0djcFPaS8XiP6YCDw?=
 =?us-ascii?Q?rWBun+ObkhJAQPxyiRdIA5wFpd6pCMCFLEmx529RShTiqeJr1HqE+oa9K1GB?=
 =?us-ascii?Q?5BuZCG3es6FgTtk=3D?=
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 10:57:21.0318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d41df6e7-f69e-489d-5295-08dd571d8282
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509ED.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB6799

NXP bluetooth chip shares power supply and reset gpio with a WLAN
chip. Add support for power supply and reset and enforce powerup
sequence:
- apply power supply
- deassert reset/powerdown

Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
Reviewed-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v2:
- rebase on linux-next tag next-20250227
- add reviewed-by
---
 drivers/bluetooth/btnxpuart.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 4f2f429c9800..81d1c9b97146 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -17,6 +17,8 @@
 #include <linux/crc32.h>
 #include <linux/string_helpers.h>
 #include <linux/gpio/consumer.h>
+#include <linux/regulator/consumer.h>
+#include <linux/reset.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -191,6 +193,7 @@ struct btnxpuart_dev {
 
 	struct ps_data psdata;
 	struct btnxpuart_data *nxp_data;
+	struct reset_control *pdn;
 };
 
 #define NXP_V1_FW_REQ_PKT	0xa5
@@ -1522,6 +1525,7 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 {
 	struct hci_dev *hdev;
 	struct btnxpuart_dev *nxpdev;
+	int err;
 
 	nxpdev = devm_kzalloc(&serdev->dev, sizeof(*nxpdev), GFP_KERNEL);
 	if (!nxpdev)
@@ -1549,6 +1553,16 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 
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
@@ -1556,6 +1570,8 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 		return -ENOMEM;
 	}
 
+	reset_control_deassert(nxpdev->pdn);
+
 	nxpdev->hdev = hdev;
 
 	hdev->bus = HCI_UART;
@@ -1583,6 +1599,7 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 	return 0;
 
 probe_fail:
+	reset_control_assert(nxpdev->pdn);
 	hci_free_dev(hdev);
 	return -ENODEV;
 }
@@ -1609,6 +1626,7 @@ static void nxp_serdev_remove(struct serdev_device *serdev)
 	}
 	ps_cleanup(nxpdev);
 	hci_unregister_dev(hdev);
+	reset_control_assert(nxpdev->pdn);
 	hci_free_dev(hdev);
 }
 
-- 
2.43.0

