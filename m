Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011046.outbound.protection.outlook.com [40.107.130.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6364D1388;
	Mon, 23 Jun 2025 07:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750664748; cv=fail; b=IcvgXaNxzTMEW5DEYN0qzn0sKxL/B6HjwLhf+Vz5NR147j+pdHvcG4ysYRI0pqvBrUttgu2nTvtmT4pL+1pUO0Ij/7czLtFix62JB9PfCHFCuWJfMI4soPeVsy5cTiX93zyM7EriuAIeRKcAix3byj2fQOY/r4tr2DZDYNYTx3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750664748; c=relaxed/simple;
	bh=peDXOj4Zur8LGSgLvPrUMmfQNdE5YfI/12pJxVFXpBc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=N68od1rO/ktMJ+jhoOTGQqQLe0dzCtX+TkQBNvz2KTO33v32YuP02aR0GbYkcn8A5r4TBJpYQAFaDccRGmtdmTqv/eFyF0bEPMHFPnIuCHZ+LpX/w6tIC8f5shAezEuy8xpOcBbLyDrlDe6Z5HDCLH9iozN1TLdzlUA5NhDJYoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mlwnh6dd; arc=fail smtp.client-ip=40.107.130.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mlwnh6dd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=miw1vW73r8YHZ8sbzWHOS1vTL0YFoT04k178CfkskFxPJT5PTzablSzwszIucdyKPDyKwgZSMT5/UaozMHQZtGst+aq2xS4S1gZl7TQBIR2dS0PHDPgFr3jwgPtCXpD9NiN8yrH7QNVpLW2C6gnN8/jAIArCW+7UUzogVLP4O3G+zb7n+y777lAvEKeF0ouV13Fxw57QEXU2qbI45GngNuvlQzPtQ7fDl/+QTdXPMEQQveE6udNWSj9aLHIdOu9hpZgHcBVwXnm+CD9MMG55fpgHfADC2ILeEgEoulGhprv8mVZw1g3j3Cx7UNBLstFUwf/Ad36kpgzpNk/GQS6ckA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZ2PruycbnXWq/64uRCovewwiAl+EoDJkwBrlyf89+o=;
 b=ou2HICDRvEwBVmzRr33+eQj6RpDVW1aKkffPhPz49cfBOAm4CGYZD+iG+dAx54YW+tfKnKTPQZhuqrfokBc4kWwFfs66hAG9M3oVCVZWWFLbj8xOk1Wh4qHjDFfTNDIpmJL2AFliKvWrXGHd6i5ZsHIVkcrD/g/r3SrTmoaMgNqLiUrrgp3MusWNt5iev/3AufLNMz6mX4d3773RLipSE0Ga2F9JYUp8HnK8o0UhLTBkg9kvXeZB3YTGhv/KFW9fFCjg0E9OR3EMzDdIpst7MwAE8DUYUItsnpV6U8D1jt+dNObEgBEqBQXGbytlm5dhIlGDXQnkH3V/MAb31ioXjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZ2PruycbnXWq/64uRCovewwiAl+EoDJkwBrlyf89+o=;
 b=mlwnh6ddgFLboYr/1uPbM/ALYN3LiDuEkMdmvC8O9Y9D0XyaQkzRl4mWfGQrvmEGkSU0cBrx8d/C7vjdDuBiKXfgV1xkRGqByF1OenmY04j7zcyqF5l0cTwcV1K9tO7MYIWqy9hyZMOr8T7EzEysa5snWsCBKINYK4SamL4PKRLDvBiaQKkmBO0Hc8JECHee4Kcu5IKR/lVSfNqdKYi4G1FALvE9DyECkbzb2TRy1zNTPwTIQmBgOl/YTh1yuNv3qD3hr8F6g3bl8KivIRHIpDSBaoRRmscc2Yut0ThZqJ7EcXfiNE/+f+QmibSTdDFkjs72eT8PPPEZi6IU78wlag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PAXPR04MB8443.eurprd04.prod.outlook.com (2603:10a6:102:1da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 07:45:43 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8857.025; Mon, 23 Jun 2025
 07:45:43 +0000
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
Subject: [PATCH v5 1/2] dt-bindings: net: bluetooth: nxp: Add support for 4M baudrate
Date: Mon, 23 Jun 2025 12:57:43 +0530
Message-Id: <20250623072744.130594-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:4:186::20) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|PAXPR04MB8443:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bd007b3-e661-4d44-83ef-08ddb229f4e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nMzWBR5utrR/TdHtoLDrMtgtfhIYjGA6MXQtDP73HPmQrTsqRIKgOjaPNpPQ?=
 =?us-ascii?Q?Zw1eBtAmNWbcxv1RcnMUuU0NtRxPE6HbjIy/YWk+sdhMqQOPUYg73riXZ+VH?=
 =?us-ascii?Q?f3xdcdw48qzNOjCeqmrWo1wZlmATKPgLsZS9tQ5v0Gk50SPlgRPTUVMAlMdM?=
 =?us-ascii?Q?cs7/6B/szKmbMbWYCKR1ZEBQklNwUQspWfWCC+aGw5Zv6ged0zSWzCYTUYLn?=
 =?us-ascii?Q?HH36NHoinU2pyhtbsgVfLdgIColaQEBlZ4vmLjnwk0X9ONQ3XdkmLl47NIMZ?=
 =?us-ascii?Q?BpQ/GeiBUP9XTdT7zh74agfn4PSooxa/GutwOj/3OLeV1uUOATSWAb11e07Q?=
 =?us-ascii?Q?lOGfUZkNKlmPi81+NXQHyLCJ6v4aCGo4pMKkY0SiiZ5fVgXlctB5YfdKXj2M?=
 =?us-ascii?Q?buziAQcMcS/UelysVXXGN6PVtP6f4GMC0PZ+uP3isuy5BitPx6BsXCf1j6HV?=
 =?us-ascii?Q?HaSGRYLKnWQ5Y7T3QyrXfsECizUTgXCuxP9ge9q6R8jV2WOcIm8a7vFxiabN?=
 =?us-ascii?Q?vh9TwsvAmxmdp2zrbIrVn6AGxZpnElAkKukJsRBKYug8BYndubwO4pIDZMVq?=
 =?us-ascii?Q?iaYnr/K9/AYOEEVo5c5Vteu9gc2zorrxhogEf33zM4cDo4ykuwfaI2k7vKyD?=
 =?us-ascii?Q?75y8s2V87ABansVZPTltxINht4fgdGp89IXBIbQqciE25/dQVskv5KnejcHv?=
 =?us-ascii?Q?JTySIjCwBe/Ha7tSb+MLm7MZPuZWsr3onxpdCzTvUMqLenjbI80FMb3FYcB4?=
 =?us-ascii?Q?XyiOH1p1o7imeaio0rWNnmppfEtEbQCuh6A9dP7Z3bLm/QhccAsMhk7Nkdgb?=
 =?us-ascii?Q?E9tJLTBSKH41OLxKvNzWC7MQnW0Wyzobn9x1SP5n8QO/52IZ6z6zl998rmpM?=
 =?us-ascii?Q?/IzIBJC2myaOiLVSBnVaj/FXgUVQyL/TcYgTQD915XZzopQgXXcdtSua5lkp?=
 =?us-ascii?Q?chigHdcc9pcPA2jcoipyLfRxptibE0ebiQyYqvYxJ3tZLHP59usPcsASidR7?=
 =?us-ascii?Q?iPi7Stnh7iDf4ALpnW5gixBynfU6iUaZLzM2ebsz79hyvj8VQmr/OQSPU05Q?=
 =?us-ascii?Q?+rcBF1mi5ckD1/8aPC2cspbUA93vhxLrZk8MYKcCCyJytBFoYkh8sSk/YNqP?=
 =?us-ascii?Q?5PDV+2HNMg7Yd3bbo6fHZAeoFVUC8UrrfhhZz4Ubfo2NJylm3bzypav9hVFb?=
 =?us-ascii?Q?m5rH/iN8NFjCv5slUJnXcPBs6Y6TwAIQn1zfX3bl9cf2XkJGK8t5b4Ey69yG?=
 =?us-ascii?Q?fdlQF/nLJsVs/eSDbAmRUfWUOlAJsNwezeKBRBR5zbOxklfxiT+sqRP/A6p8?=
 =?us-ascii?Q?reZBxCRjFy5YIoxij+Cd+S0+BlcuzKo5g680eHf2As2GfNMZRr90YQ9w2TJ+?=
 =?us-ascii?Q?KwmmIuqGf6YE4EjoC13lYd4TInDCL/gXwh6p9r0W4BrUyGCbwdp9OTvevD9J?=
 =?us-ascii?Q?/5fKmlRdBhdrefLfuXLhCARGshYtrN59HS7MNlmDnALmSsVXdnNyuA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0kLK4MwtN+5qUR4oCpUYgU60cVRpt5YLEh7oqLfcMkLZHSyALLMFx3/uons5?=
 =?us-ascii?Q?JqmpHyupUUF7p+wR0l/b5NBiyO0WIpfmHtOZtB2eHKu9bl9s4+/iq6yo4yIj?=
 =?us-ascii?Q?WI+TqnhZbZ09pMRoPow+DIQZxIcoNPAWIbUSelfMaa+0lKIx0rZROXHTH/Bo?=
 =?us-ascii?Q?TmkmKQUCbwxfsjxuSqDQg/quwJUxUEEQK6jsdWXOllKPdDg9VXwAcgO6vHbu?=
 =?us-ascii?Q?nvozhzNglMec/sJh1RC/rS7Slx79Qxyu+nBlORLu2GrOOTevecr4pzghlzzr?=
 =?us-ascii?Q?OZmiXOWbOZeLsi4lS4M8pMtUTr53evy3NHtZeR8DZpsx2Czr14J1IXnOqJ+y?=
 =?us-ascii?Q?53sjDtu27IBFdl3q0hqjHE1pDg1KNwz4rQ4+LGI6Eu9dR3CS10GGUmezTtze?=
 =?us-ascii?Q?rsGDCNFJjqkydwB17vEMOdjfwkxc6Sp9qLl+Z6w63fwNDAuDQvmKZYdIZZRO?=
 =?us-ascii?Q?gsIsXFZK78uhsBwqml80UovE8kGmKNWPsOZQ0H9AlvJsBdlakSFv2C3P7YIk?=
 =?us-ascii?Q?KGGMXm4TXuV3rjLRnITCWVFue+8NMC3pPMJJopBRfScntjFw/IXnHkEFdwRZ?=
 =?us-ascii?Q?c6goWPFYdvj2Q3/p5iSW+ReKQk6pqCSOu9e6prI/m4DG2yiCbNQ8NYxURxHX?=
 =?us-ascii?Q?q1lte4EnPT/d3Ct3WrehUrHT5XxWEpOSxxMg8m3++oyqTCLUIikHWjIqoaHx?=
 =?us-ascii?Q?X7rSEqKTeImdZuQRiZyCd3kbRg1/HE7z6P1MgseNEL19oToTMY/lRydNyoXh?=
 =?us-ascii?Q?/XtEDO9Ou3y+i5syBI1wdEr7cHzvRvgTQ/xRRFEb5Ti2Og5tGU60VC7QneeD?=
 =?us-ascii?Q?dNgY/h0jl9CRJnzBOVzX5OuQy1nnjyk+skZ1iGrcSNEtkoXEqsWly6R5Xh/D?=
 =?us-ascii?Q?AzDZtN67DhmQHm13CuFprRo515phi1QDa7jW0lDd2K6h3g82I+8D1KLgOZu9?=
 =?us-ascii?Q?5j4guXWpdHYGGRbb6gbyLmOp0E54oBtcKPxFQ6t63qI3lGo5emu9r9q74LSM?=
 =?us-ascii?Q?DnSe0YjpKURBoR2syV3mEsYs0Nfdf3mOZj+Cddo1nG9QGRuQLEnCRZvjsNbO?=
 =?us-ascii?Q?is6HlEOqGCGCUPSsyXn2oteZdQOZEZjIKTHAU6WnZHRvprX2rltmjlRzYrBf?=
 =?us-ascii?Q?Kjdb9wTuzROFa3nBsQCNmV7MPnVYNx4Sr165TrkuL7onzPOU6a8q5fGfC/or?=
 =?us-ascii?Q?KLQNC8HNctFPd/EjIJa0tKoH+9Jsyd/fqY0WEjC7Y4dBnczNI4esbWOh2n0k?=
 =?us-ascii?Q?bGb4HCEeogVD740DPtxRkNW2RJpaasRYVVXi+6OeRF1UImbfEBVfg4o7UFS6?=
 =?us-ascii?Q?2S7dKAQtdqiVwR4U1tQPbkvLwJkNzU6+zxSRQZVZb77b3WfiMVewmyY1HgB4?=
 =?us-ascii?Q?n2bQjOoySp9Zk0q5UoG8AnFDlZdakSEFaagLNWxJzdIaPTJ/mVWcz+Qb/9of?=
 =?us-ascii?Q?xDaq1aM1fEPG3N/J2fxASWHWfmhWbfZC0PM8NGdJljybrqE6+CsPrKUkO7za?=
 =?us-ascii?Q?hQdsG5td7lCYENO29E/Xa2hJeeenR9ko6v1KIrLOHe9nOa150X4jLfgzyJT8?=
 =?us-ascii?Q?DjiWCGgTYnz3Sc/KXRGrEUgDAgWShgy1CfOB664U9TEc+W/EMYSbarqALfja?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd007b3-e661-4d44-83ef-08ddb229f4e6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 07:45:43.2417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ugWKFTkeMm+8AazOZbMpvsHjxajxZtJCBInM+GdDAVtBx2eB+xmfe+ek2Y7NLeokrAH6kyvCl37VxvffPZG0FAmMDKsxKHX6/yCQ/vLj0kw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8443

Add support for 4000000 as secondary baudrate.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v2: Use the available 'max-speed' device tree property. (Krzysztof)
v3: No Change
v4: Add ref for max-speed. (Krzysztof)
v5: Add ref for serial-peripheral-props.yaml. (Krzysztof)
---
 .../devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
index 3ab60c70286f..40f6e1841fca 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
@@ -19,6 +19,7 @@ maintainers:
 
 allOf:
   - $ref: bluetooth-controller.yaml#
+  - $ref: /schemas/serial/serial-peripheral-props.yaml#
 
 properties:
   compatible:
@@ -34,6 +35,12 @@ properties:
       This property depends on the module vendor's
       configuration.
 
+  max-speed:
+    enum:
+      - 3000000
+      - 4000000
+    default: 3000000
+
   firmware-name:
     maxItems: 1
 
@@ -78,6 +85,7 @@ examples:
         bluetooth {
             compatible = "nxp,88w8987-bt";
             fw-init-baudrate = <3000000>;
+            max-speed = <4000000>;
             firmware-name = "uartuart8987_bt_v0.bin";
             device-wakeup-gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
             nxp,wakein-pin = /bits/ 8 <18>;
-- 
2.34.1

