Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE16125A2CD;
	Wed,  9 Apr 2025 08:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744187970; cv=fail; b=sCcQgQaSMwP9NyjAy1OBCB/f/qYRb/4tKvy8d4YxTWywuAM56v5x65XmJUJbFXW3n1dJQIoxYbyM2c+3+pCavfwX22p1oUbWYi2A4xWoIKn3NUvAWmVWsRodEU5LxADhU8Xjij4GhzNWJuES946gcd6Lk/HaUpa2C/0hlyOU5Zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744187970; c=relaxed/simple;
	bh=Y0Il9etqFRK51ywGojblSGXb9BBnqIEUtmVf8USM6OI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=RhIe4fn9EPWxf4LLld6P1AM60eAeL4qvolVAXyLiFytYvTg9xXxQyeNYjP7QC18l322fKvcCpvXmgIy6imCnsccZUqPUZWzkl89duI2No1n/stbcby+aBFYNfcTxq/RfTFa0EZrFKaaPE8vNeRU6DqGOCZtI2klTrTtpQKDsKRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=m3mhxWCL; arc=fail smtp.client-ip=40.107.20.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="m3mhxWCL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQGInyitz0Fr5ezoC9p4oNukoos1tMFyr3DyDwaCwJqLwsRejf2K4eJWYi3wGIHkEJKP3LEMDcxsNmIp/pa8e+M5B2qaMRmoD/vB2nyVyzBAbgbJKMdWjffp2fEzwUmLNuVbvADzQib8pLl3g7q76xQtaivq/hJ/FO26QGdAIpvIrO5QZRoqPdauob6tGvh0pdI4FsFrEBJHFrNix0ZCNQCRgID/lWX1fSyXgmksxpyAtKakovrgWGTR00ithLInDMRj31wk/q+P0TejcYHeck4FPG+rGfM7FGF+wSaPXKNAepwHX6+MQRIfvx3cX9PpfztaqXVE5bZ0ejFeEo0BEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuFAMYmZhcakjhZ3tgPLwJUFSo88RL9rV2Wt/jZGbIw=;
 b=Ut99fzSkFK06AN/m1h0ZLFMhe5TENy8mdBosVQwIk40EB3foTBYeutA6uO+EorhDRTU5szJvXD1uVcfVAruXVM1/HhduBnBBcetfi9K9es0J6aCwr3NmBQ21Vp24wVCl90qVPAZJnsyEfkUC6jSx30BDz+S08JkDiFlhE7BUfTXRt8R4nE5anpkVpS1OM7oJ0AJG4tZ0MMzlUknWpOuEeKd3UjemPrgElWenkSCt1RAxhCskLQ0KigN3P/4EXrPAdAUCNqZxA6aU2p0xWzCDdBP3qLCKRb2rHthpszWUcyz73uYKEZiIztyJyFBY2VNshk9K33PhwAbr80NNZ+s0aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuFAMYmZhcakjhZ3tgPLwJUFSo88RL9rV2Wt/jZGbIw=;
 b=m3mhxWCLcxUmxlILDJVl67imxEU/4EW7apL2Q7jfyquJFa3Jov3Bdzg8/1z2VQFss0cXx90nYKXZgphOefXc2OJMPs8JOVysGurVg/4hEwS4PO44spOd7II2DU9NPJ79x+NlsiZihGPMelFndK7qKEIk7yB1KiV81aQkfCU20gQ=
Received: from AS9PR04CA0112.eurprd04.prod.outlook.com (2603:10a6:20b:531::13)
 by VI0PR06MB9108.eurprd06.prod.outlook.com (2603:10a6:800:249::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Wed, 9 Apr
 2025 08:39:24 +0000
Received: from AMS1EPF00000045.eurprd04.prod.outlook.com
 (2603:10a6:20b:531:cafe::4c) by AS9PR04CA0112.outlook.office365.com
 (2603:10a6:20b:531::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.37 via Frontend Transport; Wed,
 9 Apr 2025 08:39:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 AMS1EPF00000045.mail.protection.outlook.com (10.167.16.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Wed, 9 Apr 2025 08:39:23 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Wed, 9 Apr 2025 10:39:23 +0200
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
	loic.poulain@linaro.org,
	m.felsch@pengutronix.de,
	Catalin Popescu <catalin.popescu@leica-geosystems.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH next v3 1/2] dt-bindings: net: bluetooth: nxp: add support for supply and reset
Date: Wed,  9 Apr 2025 10:39:20 +0200
Message-Id: <20250409083921.3701280-1-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 09 Apr 2025 08:39:23.0431 (UTC) FILETIME=[E50FF370:01DBA92A]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000045:EE_|VI0PR06MB9108:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5169883a-8963-4717-81ce-08dd774207c2
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Eymwtt0ES/7xnvricaXTWDx7r0c/cRFudDI1075Jq3PNMrkk7f6tNJ4hZLPz?=
 =?us-ascii?Q?2BHLJzn6+rk6nWNmksGZRze6902GUqR+Wm5W8RVFe7eUqjlOKsxr5LO11Uo3?=
 =?us-ascii?Q?svKwak/IEsdiyRLU6ftl2rI/B/rQIib6N4pwJ9A98steldOF7z8nkMQxBxpy?=
 =?us-ascii?Q?et53nJA4R2FfWmb/0Ewz5pa5/Q3x5Td4jGIOdBnh9MtooHGBeMwy8gmoltH1?=
 =?us-ascii?Q?pu0NzNfPnfWIQitPRZJgWleaAMtBT8hGYF/cHBrMCtceDJP3EbkOGj3cHeCT?=
 =?us-ascii?Q?BJUbOAk08maz6BZBs0emJ+RHJxsNGzAp75nrDic+J8iYu7P8XXNF/vpSVDsq?=
 =?us-ascii?Q?IvssXTn+oYGOGRLqelhIKeLX5Zsv1TdqX/jDdLsqAly6Fid/7oPavNCZqnGg?=
 =?us-ascii?Q?T/pe2QroHfHw8uqX3AirvAbjXj0+utvMUSDJTiz1csVqo0zKHLyK9bXT10hn?=
 =?us-ascii?Q?rLxn8tcFYEfni5GvF38HMcfZSzBHJsU7jb8HQX+ILlinW+7RblIKi6m1YqUd?=
 =?us-ascii?Q?IVY9QQ68vLDK+s9yF68pF7YEI5ChiOK6nQjwRzj1ufaz9lldd38RWH9cC7l3?=
 =?us-ascii?Q?diit2OoYhXSNDAtn97cbbvDM7bdL16pqfckVc9znujBUBFY/wSfn8DR+D4A3?=
 =?us-ascii?Q?cNqvBEddcjHx9sNuGqB49XoJ7WzadXnPxcgYxi2p/PXoURnBbJIWPMVcNF/Z?=
 =?us-ascii?Q?LjXEq+SzKvbi1ReeDHS28sWt+BTNAudO4MgirGaKDNJIWrcR0MpfnHbCJefH?=
 =?us-ascii?Q?f2clEd1G7A31IqI9mDlwfaK+1xvntPXb4hwnuDDEpihwSCxxdIsQ0H3V/ics?=
 =?us-ascii?Q?SzaXdSPwAeFm5mSllc+BHJ6zoOkV6IM0CYCP5eFSXVuUVwuu2R1jChi5mW9j?=
 =?us-ascii?Q?e66s9pKO4H5GP9CCUOWLF36a7+y5J3zf2xcMWQlESjOwyeI1LITw0YME1ipR?=
 =?us-ascii?Q?YNbu5Ei6sW/L/Gs52AVLEZzf3lnQvTGjq7pPfP5qBysjAuqOyHdOw8MSabXr?=
 =?us-ascii?Q?0gV8w2dQHItuBT4FRihJHhVbDSkh0UXMxlS2jFIJWffeaNp//X4t5ibTnGF2?=
 =?us-ascii?Q?hU3NsUsq3wGT/aZGovg5YZGBryosm9pfWsFQmtqHygrfpOIBYXyEH7TWYlwW?=
 =?us-ascii?Q?RNGcFxwU7EccBMiFo/Ca1db4FX1lJdI9sbkqrvqOMFgwxt+uPlxIE++JYsGf?=
 =?us-ascii?Q?UlRXXdO2Pi22t3O/fdc9XEK7QWkay86WpZ1A6p6cB9K0XH7mQ5Gs4Z553POi?=
 =?us-ascii?Q?54Nql3quZcWc363+xbIfA4EreldnGyE+TaG/zejRjqTnVK9qdksvPduTpsYu?=
 =?us-ascii?Q?i1hoWuKW4Xyfw+27+0vGaYBJyHUYKrwFXLGbh8ADEQoZvy3kMmmmJzwhCsi3?=
 =?us-ascii?Q?VAguV9fxWOd0BbII2Tb8tDSMBYAnYX9QmmSp+8jKbC6x8s1FWtcz+5FPl1Jd?=
 =?us-ascii?Q?VIe5IsktRKZ0ampH7CCQHgJfMTseNTm9MEuKJYOZveiW2OhMQIaW3QcG/2dV?=
 =?us-ascii?Q?Bdq2KCtSqdxYTnE=3D?=
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 08:39:23.7275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5169883a-8963-4717-81ce-08dd774207c2
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000045.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR06MB9108

Add support for chip power supply and chip reset/powerdown.

Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
v3:
- rebase on linux-next tag next-20250409
v2:
- rebase on linux-next tag next-20250227
- add acked-by
---
 .../bindings/net/bluetooth/nxp,88w8987-bt.yaml         | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
index d02e9dd847ef..7b72b2aa6e8d 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
@@ -53,6 +53,14 @@ properties:
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
 
@@ -69,6 +77,8 @@ examples:
             device-wakeup-gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
             nxp,wakein-pin = /bits/ 8 <18>;
             nxp,wakeout-pin = /bits/ 8 <19>;
+            vcc-supply = <&nxp_iw612_supply>;
+            reset-gpios = <&gpioctrl 2 GPIO_ACTIVE_LOW>;
             local-bd-address = [66 55 44 33 22 11];
         };
     };

base-commit: 46086739de22d72319e37c37a134d32db52e1c5c
prerequisite-patch-id: 0000000000000000000000000000000000000000
-- 
2.43.0

