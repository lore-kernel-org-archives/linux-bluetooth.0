Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DDB13D503;
	Fri,  4 Oct 2024 11:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728041765; cv=fail; b=NoZo2QcrcxkmGkfi866wXhJRcPcVpfUkKq02y2T2KQBJicwGj8lU6lyvFkkIwrVq1msOMhT780ZB1n2Ndi/ivDSnpS0Am2OtyUb0CTNxR9itmCaaUR9yuXvs2N46C+8RafGnt2gNh4MDC+t8ms/V8D5Vy9EsQ4JS6cdxxSMWWF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728041765; c=relaxed/simple;
	bh=xBC422yePdqh/2gKGeebeN5Ld4RERi0JD25NUAGi94w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=CSxeI4CYhaIIsF39s5BKHLOiScj+w9NagIjxq6/jWYus3/tSiGsfXR06UWHmKaQI5RtruOlTjcZEMWxKIIO4cYFlU9GBrJu6h/lCsfVxJqZSiouQVlWNVVq7OLEVDAa4XHYgET2GXlK5AOnwLwY5K9+CIJQ9bhmkeE9qkJFYvow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=ZZPHYGuK; arc=fail smtp.client-ip=40.107.20.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="ZZPHYGuK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j80An5ZEh6gIr3U92+0vGmhYQCZfDj26mYMIeranJg5LS2EBxrkNtXZ7AdZH0tEBriiL0ZsethKr7dAKVfsrYtJr/N3hdHHThdrp+LRabHH4mVtTo5TSG0iinDFw6G4ugFDktDNSwkpBRSN2o7MglfAaRidjK8T8KhO8J922QbzyGiyJa5jK/YWBZCz2EvPlzhbh5aeY+ZvbYw6TqAw5tDFEw590fS1k6coRycVCox3ft7Zw+c8jyxzo5cLfEmudlp3P77aZVvWR4172oqLFuyo4JwIitbNzXLyw6YP+RhxstfDbmKCDkqUV7K6P+GuE8K3066gYigu6LdpFpMon0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/WM9O3fE9v5C4sy3Iqn7JqK48wsK6eCxlNZK8U2oUk=;
 b=mFFeXOvCFv7Q0ZX2cEmVNERiwVfat27ZMCrz+SehjSYtk0f4yfE9hleCYSOmXXGFl0+qjesdZ8qsZmw6MqHYVi6zh9Y1eR5P76M1+LmaNf0Xa5hUYZu+LAe+iuklvMsY8bSYx/BdmiRmz73wamqJVY1fcYTS+rteBmjuW7OVXdwa/3uHNx9qtPclLYeoAjQfe4K4clbFKehU9UtRuMt/ckqmeuap4siVZnDx79tDZ3iBede4CAaocqtn7dhf7gvIxQO/Eh3k86jcTrg7XcngCoWgmrJtBxivtzexMOPhC8HSla0ZJmbCzoGuRfSwRQU/B1jY0b/2TlzUeuqnsSOU6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/WM9O3fE9v5C4sy3Iqn7JqK48wsK6eCxlNZK8U2oUk=;
 b=ZZPHYGuKHmNI71ccCsUZSVOcwD8b53uJWxG/li1/e0uNEjA2mOZ0GkBc7Zfum81Fgap/Vg5XHUsYf9pGMx8Dudt5il8h7QOiDuHbO8fwpgHjVOG16p1iFaBiW5kSEQIFKZ0UwG3Je40t1soiC5ak2AfNOJBWXs+RKIcU+DeC9s0=
Received: from DU2PR04CA0080.eurprd04.prod.outlook.com (2603:10a6:10:232::25)
 by VI1PR06MB6639.eurprd06.prod.outlook.com (2603:10a6:800:18e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 11:36:00 +0000
Received: from DU2PEPF00028D06.eurprd03.prod.outlook.com
 (2603:10a6:10:232:cafe::88) by DU2PR04CA0080.outlook.office365.com
 (2603:10a6:10:232::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Fri, 4 Oct 2024 11:36:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 DU2PEPF00028D06.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Fri, 4 Oct 2024 11:35:59 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Fri, 4 Oct 2024 13:35:59 +0200
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
Subject: [PATCH 1/2] dt-bindings: net: bluetooth: nxp: add support for supply and reset
Date: Fri,  4 Oct 2024 13:35:56 +0200
Message-Id: <20241004113557.2851060-1-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 04 Oct 2024 11:35:59.0559 (UTC) FILETIME=[95998570:01DB1651]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D06:EE_|VI1PR06MB6639:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a70b8e06-75cb-4f00-398f-08dce468b851
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lKA9K3+ZZ7sVvJfhNKbL+LDdSG+Zr8g7cJwVQOPNYst+BboAKTtYm84yF7SO?=
 =?us-ascii?Q?CQ/M87jr2qpgxj2VkyeybUyQLjb53ja/l0cZgv5cX62KaBDJgsrHB2amWsrJ?=
 =?us-ascii?Q?gBwmLNpEoG24Ym7ngotLN9th9gZUx5Zm2nEPmINKB15w73O9NkQpgMz7BMQS?=
 =?us-ascii?Q?71dW2LX20J/OAtnqteBMFeS2IvZ8/8YEzuHROQkX/ZZEsZCiBns5pwk6VuH9?=
 =?us-ascii?Q?mq6RbZUf6GKU9YVtZBuhjxAfpIx1Vqb0lUevoTE8XHbnYVlYPfOnq8Z+X3r0?=
 =?us-ascii?Q?6P+T/5Q8oxdtdM5cBQl420uDQijZ/5YSQwzHRYFqWtOIA8pHVyCg6J3CHI48?=
 =?us-ascii?Q?/E0VgjfBKeoKBi1Gl65WNPEAIRfOiMmFvN0+NRy/UlshDjbByjFrCuxlqlOP?=
 =?us-ascii?Q?lwGJHLkkMfKx5D0z9VAeK02ABq4ch3OQnAe5mvvgRLtnOnJr8Vh0MSz0FCbG?=
 =?us-ascii?Q?G84FoV02eyNc5Stfwh0WB8/9KfbdF1fQG4h1OaewklbdEYVZErvUxa+IiAyn?=
 =?us-ascii?Q?MB9UOuz3zNuJAiYTjCbwwK8iEQzUqtLfycwSyZZ5+TU1PxgEC8CdJATVjD05?=
 =?us-ascii?Q?DvMGY8Mhu9JHCk5Z6FVOmKkY6GalMh8MGc8djh1X2DlufeWeJCEwu7ZxQBRm?=
 =?us-ascii?Q?FswgrfK1MpqlBXeFAcOKfED8EknYwDyMrtPNw84SQaSPaEDDAUDq6+mRIABd?=
 =?us-ascii?Q?KV+tOYrcU+7G+6NTMPfAF76yHlI54KxSWcpZwyYuMzjaGyR+5CYY20EMd4/v?=
 =?us-ascii?Q?c4EsuSThRIem+BYBo3w6rECbezUHHZ4gPNjUqqgWTLg1yu5BfoR8LtykRnNe?=
 =?us-ascii?Q?Ng5isd/khQUv5lOL/Jf2hMSLZlDtvTUYfFYiZUQ+GFpk3LhYb106Hfg1Qblf?=
 =?us-ascii?Q?Y3h1BtrAejFC1frh6eZ2/CyCK2hmFK2/2Zqx0OeKCsAZJYAo651Q7FEYYybA?=
 =?us-ascii?Q?lZhwmAMY8qycWBozjbGjrvZbRI2xA+iA9sBf9Ansg5/6o+HPHKi8C0+OeAfy?=
 =?us-ascii?Q?GfZKmNA9ZY6anKDz6XK8hHssO81EGq6/omBS7qu7eq/AE5RHhrtxfDQObeGM?=
 =?us-ascii?Q?qwMkr4TGNkRqIm4YRONpvBeihClNApJSfu0y1nRBqAYmF7bulgllaHWGRq/X?=
 =?us-ascii?Q?e5ZVx8hIzF5v96UTWAa2rYSfhj0n7UdxlIfZH3GhZn1my4Bf7rFabvHUJeB5?=
 =?us-ascii?Q?nSMDV3tvgH2rrHZzeWsATMxmbHSyjNwQqK4RbPH5i5pviaHt+KXUVAgm8jFr?=
 =?us-ascii?Q?rL3zBtetGxPjsb8sx2kxITM8TkCS/KlhG90n5OYsfQ8g4zmiWIZQ/DCz4cd8?=
 =?us-ascii?Q?CqYxxyoPYfIN2jLH1dpcXC15RU57BfoFqaqlCPAiTMsHSNyeomzcdRdOSa9o?=
 =?us-ascii?Q?4PE5Ty2bmwhkfLLbaGSS9JGoURB+?=
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 11:35:59.8580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a70b8e06-75cb-4f00-398f-08dce468b851
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D06.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB6639

Add support for chip power supply and chip reset/powerdown.

Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
---
 .../bindings/net/bluetooth/nxp,88w8987-bt.yaml        | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
index 37a65badb448..8520b3812bd2 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
@@ -34,6 +34,14 @@ properties:
   firmware-name:
     maxItems: 1
 
+  vcc-supply:
+    description:
+      phandle of the regulator that provides the supply voltage.
+
+  reset-gpios:
+    description:
+      Chip powerdown/reset signal (PDn).
+
 required:
   - compatible
 
@@ -41,10 +49,13 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
     serial {
         bluetooth {
             compatible = "nxp,88w8987-bt";
             fw-init-baudrate = <3000000>;
             firmware-name = "uartuart8987_bt_v0.bin";
+            vcc-supply = <&nxp_iw612_supply>;
+            reset-gpios = <&gpioctrl 2 GPIO_ACTIVE_LOW>;
         };
     };
-- 
2.34.1

