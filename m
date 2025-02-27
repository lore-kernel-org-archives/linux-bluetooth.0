Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2084.outbound.protection.outlook.com [40.107.22.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9AD22839A;
	Thu, 27 Feb 2025 10:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740653846; cv=fail; b=Sm3zIEfvL8BPWGhRaHhRH1WZibzHe/aLIyYj6FcTiITe75+TdsUdok/6yhDU/Q65uVTjSNjNn+VOiTJNQ1IzUcBHQgqlqP0hPnxwN1cygx4eDuIsLCoqjlBa/7KS82hnJXLhd+wrPjT2PP54gZOcf/s43Ru6bsniF6Gv4LEWGME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740653846; c=relaxed/simple;
	bh=dSYawFJ6OOIBKBeeqMnnNkO3KAhyjUUiXYXhI792wMM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=MLAfIV/RjSkkBRgTpssY7GlaSIpAkCHD8vDMzEwMP8BUGXUKx2ZWvco2AN+mSd16djBANmE486Q5YiW02vm2kOsR27a4NOLvIjn9J2fMtgsW3090+sQ9yglHJbyFDjchY4+l7ZzgjLnU7eEvLLC8sscywDR3OoNSm3y3cd1ZDys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=uaO2Rfx+; arc=fail smtp.client-ip=40.107.22.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="uaO2Rfx+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTDQz4XZmOb23+J+ksMk3+0MEJ3R0z3vr2lLDb8UK9vOB9+N9xfM9/IEENEiapXDPgKRFo2bLWkhURQHKVFx14ly6DT7rHjtfsJ2IGNQW2EbPgt61mysJFZ5DFfeB8JlLVb2le10dzmJdjVo28UkPcIiBRCtAhZq9UEjADvRVE+QDUBP9AU2T7m1rSez+FUSXZYRbXPwyn2JeQtOVPHcS8URcDXS6rT36E8WjaMyYsYf81dbDPgAeIWmZrxUXDHg5n+1zSGYlnaGnpvP+mt88d/wt5f/vKG9pyKuKQH78xAmF1TdTilfb/TgsdoF/3Dk8ibSl/jLGJr/UwBGWIrQSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eF/Idrt3fzNPfFvTktwLzZoXQX6gPIzB1yUInQQhkRA=;
 b=pVikqAB6VhKXiZ3FUfZkgYkzNfV+YqX9tAii28CuKUygKqh3wTRn+Q5gUnVBS8bOSYXoM3odGrlhGNap5lQn8riDRj0Yn5DFsP3vGwH+q3pdrZ/lRA4fikI3hjvwWaQQJ6Nc1aJc9JatONIvD5StiIIwYG+6eWgZo6XBEdQ3VU3v/hE0MulusFcuPvxJxFhkLwdu/MosRRzXoTTO1d6pR8ZKFDdGVVdRggEU0JO/K28JWF3C3lHacxZyUv+iqJ7lPIDiF0X17Hfjq1aEaOePKXH56omelqzT6vWLl/zcZ+pt+e1ZDXsp/ZJfpQYeaSR8G4ziyahJBh2w21bABXRBAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eF/Idrt3fzNPfFvTktwLzZoXQX6gPIzB1yUInQQhkRA=;
 b=uaO2Rfx+ibJo3UprnULeIZaud+RAx+1wYnS9nEbkMs9RDjVKR26kRJAiwz/xZw4Sau0TXERVxtnurp9U5IaCO824/ekrr27xfGSm8jJN1JEPdZpZH9zHasRQVOuYFRo+JEJKkOmGyUDDuYrJCG9itcgqzoWeBNYpKz4zjac2ZrU=
Received: from DU6P191CA0072.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::25)
 by PA1PR06MB9700.eurprd06.prod.outlook.com (2603:10a6:102:44a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 10:57:20 +0000
Received: from DB1PEPF000509ED.eurprd03.prod.outlook.com
 (2603:10a6:10:53e:cafe::29) by DU6P191CA0072.outlook.office365.com
 (2603:10a6:10:53e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.23 via Frontend Transport; Thu,
 27 Feb 2025 10:57:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 DB1PEPF000509ED.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 10:57:20 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Thu, 27 Feb 2025 11:57:19 +0100
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
	Catalin Popescu <catalin.popescu@leica-geosystems.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH next v2 1/2] dt-bindings: net: bluetooth: nxp: add support for supply and reset
Date: Thu, 27 Feb 2025 11:57:17 +0100
Message-Id: <20250227105718.1692639-1-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 27 Feb 2025 10:57:19.0812 (UTC) FILETIME=[5F3BB840:01DB8906]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509ED:EE_|PA1PR06MB9700:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c3513016-95cf-42c7-2b53-08dd571d821e
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0o4Pdk9meQFGilOHevj+JCbZaWlaYhsbRN3UrNvNS8eEXNWKl8v2P9gB5tIL?=
 =?us-ascii?Q?69h/7HJ8kqobKzpvhufkpSXNyralcB85ZQMhXzHXfLnZZT+RPvzOnAVMiqd8?=
 =?us-ascii?Q?qcz9C161sjgsvppv+smI58j/CYe7+nAOL3/bCRRRKIP6FW0vFd3xe8F5MTl/?=
 =?us-ascii?Q?zrw+BzuP0xV+WUwgLuvZDqTk/V2NFM6gI7BU5gDLUDY3xtb9d5cEvUa5ktBC?=
 =?us-ascii?Q?VboFEppcgGIGOHbOLlrIBhxtEzMTuiGIps7QVs8B2JWjOEJxNgmhhjEoRF03?=
 =?us-ascii?Q?kJae9G0fMSbxri4ZzNti3ywuLEug/xlXRvCDMRoXt64GPkV27GkTftqBOAxH?=
 =?us-ascii?Q?7rcl2bKl1PPS8vg3KcpoGPBhNl8YdnyfHgzz9smtUTsj3q2TL/Vp9MzsXkZ7?=
 =?us-ascii?Q?PZlA3cOl/Asd+mfdHpIBlvHqkXXx3CmB0sPYnzNW0twop5s7qL1+MYkDQjD/?=
 =?us-ascii?Q?DtqMgIoqHYH8XLEuricWD5VfJVBB4+RLQxHVGSolmwXgq9CYPsC4sYDzUjAD?=
 =?us-ascii?Q?zW4d2N0dhzphb+dOO9A8b7fLCyOHT6tZphxCDtIIlCds67P9qXH5nL9MZwVU?=
 =?us-ascii?Q?ijYKK9TXup6W1+UHjyVdxGrfIindmCRgppb/j3k1j/8Q+cTEmyI82eCCvv4/?=
 =?us-ascii?Q?B3W1kuN1xof1Da8m7CTo9MRTgQjtRrFPFYS5GKnjeXZZkY525rY4hpop+4zW?=
 =?us-ascii?Q?3h1OX8DVrkloK+mrwMqRySP8P2nj0loP++m9k7pz0fthrlt7hG9QXnhrLB4R?=
 =?us-ascii?Q?Ux5OwPIXByTVvoObLS9bDZSPgn+Ah+CeSO54Z0L9xpDMOFGtWNKB9PEJzDn6?=
 =?us-ascii?Q?8Q9m8Ar7nbgRB06mX7rWJow00kvSJJRTktruorm3zvSKuEh8HjauTSzFYIzD?=
 =?us-ascii?Q?hc9Y3v0TturixedY8ZC134fmcaL7XVlxvDvh/5s2KcpwUm75X9EmLJHw2dY7?=
 =?us-ascii?Q?n5Mg31TOaHw4g4SdXMAiNgp123UtfyKvMpS/pH3eizRqAiLcAuw5qXc2sjMo?=
 =?us-ascii?Q?L5bGFkI5rP5IjH19fxQntnKOqRLdZug3dH51l7kyRf84HORIG47ouQEEaFG1?=
 =?us-ascii?Q?1xLpWu2zHDpCXaGj+INUZlbDpyRIvP4AVaOVcfhlBlExpPloErZ8tdU8vbh+?=
 =?us-ascii?Q?MF1MVQ8I+RCLKhJdo0u5eud+3PAEe3uY+MeCnysEDD6CBihZ5y9WgERRXw49?=
 =?us-ascii?Q?MBAPSPNofGXrr/IG7YVVkdGdNO7lV2Rv+mSmqAGqu0BaxkfiqBUw9iTttWMg?=
 =?us-ascii?Q?f2TidJkUqYhLzW9epkbhIpJ65HQpv+G2VIlLx5xBSNGKSWWMU5QpbG4N1bI0?=
 =?us-ascii?Q?DQOwuPuQDq5ZYqL1G5RD6MHzO6ZAkBM1iSY2HV0yUKRnLup6WeRFowx/8kan?=
 =?us-ascii?Q?W3tZWNSNKPsmKl33+7is3p1h2CBeAJXXxfHFf2arEbberRSlVqPcJse2MmAX?=
 =?us-ascii?Q?vDvS1lE5uShzcAaDnIzxa2Qou83n+YP8zZ6XCOw2Vm68/Cgkwr+xptKoIEav?=
 =?us-ascii?Q?dJkbVP9DS4L3Ykk=3D?=
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 10:57:20.3755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3513016-95cf-42c7-2b53-08dd571d821e
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509ED.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR06MB9700

Add support for chip power supply and chip reset/powerdown.

Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
v2:
- rebase on linux-next tag next-20250227
- add acked-by
---
 .../bindings/net/bluetooth/nxp,88w8987-bt.yaml         | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
index 04f55fac42ce..97c694f2d70a 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
@@ -50,6 +50,14 @@ properties:
     description:
       The GPIO number of the NXP chipset used for BT_WAKE_OUT.
 
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
 
@@ -66,5 +74,7 @@ examples:
             device-wakeup-gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
             nxp,wakein-pin = /bits/ 8 <18>;
             nxp,wakeout-pin = /bits/ 8 <19>;
+            vcc-supply = <&nxp_iw612_supply>;
+            reset-gpios = <&gpioctrl 2 GPIO_ACTIVE_LOW>;
         };
     };

base-commit: be5c7bbb3a64baf884481a1ba0c2f8fb2f93f7c3
-- 
2.43.0

