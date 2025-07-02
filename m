Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013002.outbound.protection.outlook.com [40.107.159.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F97225A31;
	Wed,  2 Jul 2025 11:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751456495; cv=fail; b=KznkZ+/ITlLI3e8mhmUabmSByYe1hR5RXRbIe2MmmS5dNRhZOT5bTUmnOOLBQ29fMAO9Z22EtwFN1FUbistkx5FFYgvg/KkldhmHw7PEadYarxq4J4V7E45xm0/wSI0fYmKGKh+j/h/wDtfMDzF/jyI1MA1FUk6A+p6TrJuFMic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751456495; c=relaxed/simple;
	bh=bOyq/899DaMJKxssbP0rEa3MN8RZ2CbB4z4105CUGI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fx9CmiJ1insg1cXyQt8L8Az9n8a/B9M+cvT+vDpBQVoXExoJNCdjQ2tjQPKlM91dkkfJAMYeVAvMBv/SmfiVMOivzKVHbWVpUhr2GzZ6VkvDg3D5DEX4EFvwJcPh5aNAMG9T9wgIPjoP9zkvMobYjCh5agGKcTqqlIOt9rwip/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=kk5//f3u; arc=fail smtp.client-ip=40.107.159.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="kk5//f3u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r6fVIAr844YC0NCot3hRRy/RmEWxK/jRZE+gubmQbeD5mAo+gyRg+pHyzlfK/PIYD1HpwEnNUp3/qwQyfMNU1fkA0m5yok4rhQ2NNednorw0FEmD7J7nENwGsFrW+OKiYwWoBANKl/1PaRy1F7e0bIhGbS8SCTkeVCI36ylibk/C/JDljIv8ykrwB7cnvrzeh04tp1mPGadjzbUDCXeGWFmExsnbpikSX0+HggBWXQI2Qxb0msxWw2aMAWx6Dt6oc0yzKhn2Z/PtZ5mklurxwotgnw+vP7wimwixN5ORqmrkEdApx4qRK0VC/uGit6FVceAka4Lt8rN97J9gI8LcWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fraWZgSDlPhyjIFb18LKLCHq7bsu3shrTkN0xkrlKn8=;
 b=FEYHlJYF/nPAvfNiLtijgS8Wan1XGhsDheJc0948avo2oMOX1cQijrJ2180RxZFtwtMwDsqHtN66f5HN+lH9l6IX9Kk50TL0rRwsmkO6aE+Qk7kkyRlGLEGRUyfTKMK81rVeSXAK01mVciGKWJgW4hhZu+ZCdxBfTlTx4F0Z3U83/UxmSL+DzpjgL9m/MqJWEigDjdiWyYIqV1Ar0V4qSyCuDSgRwYRX5vKHA4IbkDLd/gEZtOOJruk6qzK+XVzEP9Qeq+Kv4xjtQmr9pqEOjxelCZxlEhpLTa/DElc4SOch5Fskep072/AOTVi/tVkBZf9qeVsPq3jcr4o22fTokQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=temperror action=none
 header.from=leica-geosystems.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fraWZgSDlPhyjIFb18LKLCHq7bsu3shrTkN0xkrlKn8=;
 b=kk5//f3uqv1SMnTibUKB8LQloaARD8YbjU8uEPn+OpeJ3E0s9el2pVCBojiYLPbLeU/d27H+TIWE87DBwTkWNrr4NR8bEkJshKXUPDLuTX6zhgDqTyNUW/ejGR86+apVBvDc6I2INM6G3VISJIOk1yH4F0x1bpKCWMqJpV8yVos=
Received: from DB9PR02CA0013.eurprd02.prod.outlook.com (2603:10a6:10:1d9::18)
 by AS8PR06MB7271.eurprd06.prod.outlook.com (2603:10a6:20b:251::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 11:41:29 +0000
Received: from DB5PEPF00014B8E.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9:cafe::32) by DB9PR02CA0013.outlook.office365.com
 (2603:10a6:10:1d9::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Wed,
 2 Jul 2025 11:41:29 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=leica-geosystems.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of leica-geosystems.com: DNS Timeout)
Received: from hexagon.com (193.8.40.94) by
 DB5PEPF00014B8E.mail.protection.outlook.com (10.167.8.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Wed, 2 Jul 2025 11:41:28 +0000
Received: from AHERNOBLEIH55.lgs-net.com ([10.60.34.120]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Wed, 2 Jul 2025 13:41:27 +0200
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
	Catalin Popescu <catalin.popescu@leica-geosystems.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH next v4 1/2] dt-bindings: net: bluetooth: nxp: add support for supply and reset
Date: Wed,  2 Jul 2025 13:41:04 +0200
Message-ID: <20250702114105.2229008-1-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 02 Jul 2025 11:41:27.0810 (UTC) FILETIME=[3F32E620:01DBEB46]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8E:EE_|AS8PR06MB7271:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: dea9152e-c16c-4137-6ee0-08ddb95d61f9
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7aX7tIYkrtH3pqY+fev5gyLARdm58oPBtMjTb5zgb+fmvYlUrSr+AAuY+4eB?=
 =?us-ascii?Q?2C7UFVeezmxUAJL0oN9JL/iYikuTegOaHlGkC0JlNC4IDBGe7uNwcWNymoOb?=
 =?us-ascii?Q?me3bC7sW0NxS0MEGHK72smKpc8SgFAmNHUlEY2BzZDyWT+2r42ETqyOWJJ+q?=
 =?us-ascii?Q?OFsLzCe1YPNk//rtsh9gr+CQtCp9klamR2mV9pvlcA/Bm1J4t0dlgSooG+TE?=
 =?us-ascii?Q?IncGH+j1YLag3ttTa302Ost1syULkW54RHyxlj9ajivmWF66dq3Z+e01ROym?=
 =?us-ascii?Q?hAKWM0azjZPrzTeLuJTGjZicZkErcDJ3+xTrtYEJHcL8+dSmQlmxCuTcqVg3?=
 =?us-ascii?Q?nyTlti8Ut9JgSuB+LrKIE7y97Ib2zDdKuPv0GGEHP5Fic16MaiZDZ7m723F/?=
 =?us-ascii?Q?eo9+W3cMie6f5bcZztTNViWtpJbhqVCeZUZ2sTzG9HFLUTVjyRrAeqQhrr0q?=
 =?us-ascii?Q?gGklZVNvIPKkwJ+Thf5VK5iW4XxVXUUvk3+cnaLR3HppHuZIOD03dJdGbDtO?=
 =?us-ascii?Q?nTyujhPHiXWdHOEFGZFDP9zP2yGa+wzarwekpKyrm9PfF6YQWO+UwjkJQdvY?=
 =?us-ascii?Q?UOc6p8xpB+FTlMdqSIIpqeZVlj7t4GqsLgRlaeRZ5oky5yF0gbeKenUXDFfg?=
 =?us-ascii?Q?+ORwtQymJKnZnYZMXBR3tA1r0nz6v1bBrFnE4rRhKbVEwUE4UYRpUYZr1bA0?=
 =?us-ascii?Q?18ZLygfEi5+FPxkJF+qsOxU4BhFg8PeS9sqZ73Ux/t5mMqs5I9GCGQpoN+Wl?=
 =?us-ascii?Q?FwLlrMuqEZdTaU/skoC3xXDchf5eXr+ZKY4LCxiPVOBNOBqo/9O9ox01q0Pu?=
 =?us-ascii?Q?06+kSul46966R/Xy0ANEQcfAULNX5OWIChcCeQWdYkqhtCqhmYKXniKQ1YQ5?=
 =?us-ascii?Q?WKP1QuZK4R00rt3Yc4TzFffcMrsevxYI6ePvwb1ynUJZ+9lIUAYUJj2gYAIh?=
 =?us-ascii?Q?iCadKCZYvW9qro42SloNanvDBHLFph3SMSmSIg2Hp8xJ3lhgkcpBvbt1lWNq?=
 =?us-ascii?Q?RM3E1dyA3Z87EbyFwulk3iHTaTFiEHe0iG/EBRYO1cqjepvvwirb5XZRH4vR?=
 =?us-ascii?Q?BgypgYkmJ2YuHe2znaM/njlUd4rSaLPtcxvFp0z7juYkDtGml6+YCs5hjL+p?=
 =?us-ascii?Q?7ArXy1W+mj5dw0+r8rKCx9IPRJmpzEgBQ+zo7XIApLX6bBgSinDnizUmc/EQ?=
 =?us-ascii?Q?XTQGT4h28oYzgLNDmaUXyLUc5LWkEBTG+3Ksjw4RfPnsXenLu46HZGZ2yiRJ?=
 =?us-ascii?Q?MOfCtFSnOiauIqVNtccyPH1RhsoKD0j0BDaJV6RCOtdgzqgMfUt6t101FveD?=
 =?us-ascii?Q?lwGyNYlIQpszmSTAXs6Rws/jwFIOmFVJCiN7roA47xje8P3E6RbaPmpHaRxY?=
 =?us-ascii?Q?cA+1b2N1REize19zuh2+lWDRMgyccB6kRkI3+XcjdMvLS3mOKB3WuR/mjgpW?=
 =?us-ascii?Q?N8eS7WurEX6E9S2fJCA2exrUaRd4Fa8ryUnHbLge/BvzEKiSzkZJlPdbCm93?=
 =?us-ascii?Q?Z81Wo7sJD1u1GoNTAykisfe9rh/oRe/z6tZv?=
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 11:41:28.1783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dea9152e-c16c-4137-6ee0-08ddb95d61f9
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7271

Add support for chip power supply and chip reset/powerdown.

Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
v4:
- rebase on linux-next tag next-20250701
v3:
- rebase on linux-next tag next-20250409
v2:
- rebase on linux-next tag next-20250227
- add acked-by
---
 .../bindings/net/bluetooth/nxp,88w8987-bt.yaml         | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
index bb9ab5dd3b4a..857c6234ba9b 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
@@ -72,6 +72,14 @@ properties:
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
 
@@ -90,6 +98,8 @@ examples:
             device-wakeup-gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
             nxp,wakein-pin = /bits/ 8 <18>;
             nxp,wakeout-pin = /bits/ 8 <19>;
+            vcc-supply = <&nxp_iw612_supply>;
+            reset-gpios = <&gpioctrl 2 GPIO_ACTIVE_LOW>;
             local-bd-address = [66 55 44 33 22 11];
             interrupt-parent = <&gpio>;
             interrupts = <8 IRQ_TYPE_EDGE_FALLING>;

base-commit: 3f804361f3b9af33e00b90ec9cb5afcc96831e60
prerequisite-patch-id: 0000000000000000000000000000000000000000
-- 
2.43.0

