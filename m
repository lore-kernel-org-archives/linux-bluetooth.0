Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2087.outbound.protection.outlook.com [40.107.241.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5BD248BA6;
	Wed, 15 Jan 2025 10:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736937904; cv=fail; b=WTq2XEx4YWmk64OGwCheWK9La56CnnHDeGBhA++t3K5kzpG+l2FEK/xJD8d06fSEQBl6sJ+17Li1r9T5dY84pZaX7mOChe9H3ifI/nomEwGwh1bCwjQKSJf7q6dVZ0VXibD/XGTadkcJesWeaOPKWoipBE4vVLLoN+vkkOrljsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736937904; c=relaxed/simple;
	bh=UXFBwP8n2o39BhsKi0NFgENhOeytZWnpR9gm1ihvrDA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=P+XcmaB+LnGu41ebksdwlFjC5b5ntc+Ru6AH7WKem/2/UfT2didRWBd6TTkaz0d5Zt2Qxo67ZFemrLGV/cRsE6e4PmzejKvR+uQvwKn7syE1UkuX0XRSRDcqfP7RbVYU8O8HvJop/JQbIgB0/4ckAynP63Uo2jFl73h9gH8eBbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y3+F64n5; arc=fail smtp.client-ip=40.107.241.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y3+F64n5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SglLHdGhHEjTFb8IpYueOa70NyF6+a/QeciBzS0+aI/p2pxgk8Ke4vWVN+SMBgBW+DX8KUKOyjmXIAqrfGbP03QobCeu6n3eOlLufdLub+2iLp4crqS+y7ZsjNSgLNAhOb/ZbDOEyM5ORsfQfbN8V9XBvAJlolbRt+SmXP3N92uVHS1BxpJywyuT4BJMl5QN+T6rvIf4d2QkvcC0CMCWJSOur17X3aqfoEIDb9Glm6VgEZ8wXX27uF2t0SHJL2z6ezBWnUHuv9AAg3/9kzmOl59AuOdqYgJiF3j8lpIdn5gjtd5879aMu96oWoXMqCzJKpagLziqYG8tW1yZEv+OGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wnt7D0xmhRmbMDNItJVqgX7AXuEhW/3g5ueF26sw/bk=;
 b=kjERkS8itoDM9uFV0B9ji5up9V8fglZeNsfw3bkox5LMD+zgMMdD/4HghbMOpJPzxjaVPTYDoYCAz9R7HJmj7lcz7VzhBaPfkHGk24CLVR0WMUI05gh/PPOg5BTVW6bm2o1h3TEMvlNcoswH5iEu6zYZ8Vq5AQO+5C7hrY2IFblgf/51a70uOU31yUwdWHJlDA0ZZjat/+9AwPPpeQyaHkftKy66+syj3RqPV5ECuXDggcTA6Y1GLvZhFRlKV3AqChnmPGNCmvJm5mKmV//+b2Hx1pO6jB+7rCIlEkBEJBGXOkoK0toegwpu9nom4qol1lWaObUyW0svkt4SzC6uig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wnt7D0xmhRmbMDNItJVqgX7AXuEhW/3g5ueF26sw/bk=;
 b=Y3+F64n5QUYHuimzWpfV2wEufLbf7+iqjyx0/XC4Wmp/dysY7ZLYeJHrXeIB5AFx5Lj1GrNh+nS7qo/SWVtegEPB7E2cT8Om3TdPSF6EQgUephf3+2t4Warnzs1Utei/Pk0lmHVSW/17BteExqqLgxkdGJN2zAJwJRpuhnO56mo1o2yJgp+PfoFwsH8LoA6ifAft2etkeB6Sy+eXzyghfOWlqMtMDm1rqfkn60LDZI8y0mZNbWNHqAfv6R2Q2pPpbc8teIKIskdqjnlD8quL/kG/glbavN/vCiwe74Xlm7Rci5/eK5mnU+6Mqkrm5BPmXCHavOQLQLsLpI0/TpBMMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 10:44:59 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%3]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 10:44:59 +0000
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
	ziniu.wang_1@nxp.com,
	johan.korsnes@remarkable.no,
	kristian.krohn@remarkable.no,
	manjeet.gupta@nxp.com
Subject: [PATCH v4 1/2] dt-bindings: net: bluetooth: nxp: Add support to set BD address
Date: Wed, 15 Jan 2025 16:16:13 +0530
Message-Id: <20250115104614.2381674-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|DU2PR04MB9180:EE_
X-MS-Office365-Filtering-Correlation-Id: 784c1b90-d50d-4d99-af50-08dd3551a88a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yBPDZCYLV2EZUQYiFMpBwXqr9scqvQ6MMpiVzxxa8bczJVQJY7vFuin1cLkD?=
 =?us-ascii?Q?Dge8ixzdsyYT1yiKNbsPtnYB3FTGUz6JEEPb6ASFMEErDt7n/yQS4wM1vbmq?=
 =?us-ascii?Q?zt6a5uTo/BCrNA28XVE8QX23R9DSTS1bVVdXf3ZSZWCIzZiHUEP5okSiUt4R?=
 =?us-ascii?Q?TgPrpZDNsvW8n7vfs7j2nRd1uUEw0J5iINAYSbZ7iSofFgDUglKTMZLTzF+Q?=
 =?us-ascii?Q?jFoEqppxM10Sxaeez3vfhBuclZy0U7JijiT9mTbJb09ScanYmTsgh0pWRTuF?=
 =?us-ascii?Q?7ZmPlTBTt9tZf4XbNyBc2pGF0WRIXeYnvl1JVopu9AEb+7RJhacK8a7GBX9g?=
 =?us-ascii?Q?ny7C0RZ6v4gK5f6+Qokc62UHbkjd5ippnnD9hHGr4hcUM0awA3CT2jEEjBUn?=
 =?us-ascii?Q?9+tpcrzao8wKpLnlzCMEgimvDDXHW2cAOXvppGG/tV+DZdtnUX+EasBpHCoS?=
 =?us-ascii?Q?v+a351UGUXX2Eos75MDH2DApVyry3oWfQmk10cFho85AtCVbOwNuD9BaQwBe?=
 =?us-ascii?Q?ivK8zSmqo33Xd8rofOtnfZIIDr3dKYIrMQbtHhQk5siis02WnN7P3qbEggwU?=
 =?us-ascii?Q?79OnUXPZlOpzz9LQ8xoYyLHBMveYjq+fdyBoQXUo22XkQ8QhScfmCWg2cizg?=
 =?us-ascii?Q?5ujImCiHSc9zEy1JggrghzVMvjMecQfwqMSrpi7v6nWviAPcukSrUK8A415C?=
 =?us-ascii?Q?m/26s5AN3PgsYNKOLaScwmWmmNk9ER7dKzLvfPX4lVPcWAgjUwSr0A71yyzF?=
 =?us-ascii?Q?9kBoJifWgW6L90XdDUjxWsP4kQgLwQIOtTjZqUOiVRNNaJP/bQ1O3xze74YB?=
 =?us-ascii?Q?V1R6ld/aVmRhkaTVw6/+xZ+wtYZYQUTYzsI3J4uRc/d2Anp0GG8KKdP6CaGX?=
 =?us-ascii?Q?dJIS6bZdATMq7/v3IowSzgHEO70YUWHfHVR2v7zfK000FDMH9ywdtjCTQsZv?=
 =?us-ascii?Q?3Ky9/+FHTlH78RZ44zttKvb+igfGT4EEtytGSZPjPYa3vV31i6aWUV/sJyyf?=
 =?us-ascii?Q?ubL6XH7RJr4EQm+gBbkrRdzrF7v3i0ClFj0Rcp5Ryhj6SSlWwU1e6aq1SIAK?=
 =?us-ascii?Q?Gh+i+0HlNnZv4GoJzkZvUpXP3CWFWeax/FX4/31BcRYRe4AYNnIa9TAZdkG3?=
 =?us-ascii?Q?shxwOlBs7/ML4H+XomcbLQW20zbqrRiNezpc7k8ZZgkqQOGPfL3p7z5PHOnQ?=
 =?us-ascii?Q?jWwfalbnazkwGvKnh+K99UoayR54Buj1gjlzErHHJV8Qef/i91V+CQJgd96s?=
 =?us-ascii?Q?FJb5VULlVUEb7DAcq6dF1ihNeJt9oiOba9skJ3c5wreWMCEwLmY822PSIkOh?=
 =?us-ascii?Q?4XMuhq/BGAxd/ngOVM4E5+cpOjn+dHOhw9LDs/J3JpeV59Y4R4KvORlITgkx?=
 =?us-ascii?Q?jt1ovu4hvueEt7RAIvSSI01gUAKolbbXqYOniz73YL91EZUOveRxPEP9gNq2?=
 =?us-ascii?Q?P74PonTI2hEJ7+P4PnzmBjjEdi9VKu4b?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+eQwe1/9XP/4hW3ffRqfHIGFJG0C+FZbT5dqWI5epqwYdaVQ2I2kahimmGV7?=
 =?us-ascii?Q?aJjP7BlsBfBJCDuJ35R50iMqjJ4b/eXNXWO/vLExUwJzCwkm4AvH6uxrY+NS?=
 =?us-ascii?Q?/CL7EU80OJFcTI/nSM0vbYF/L3l5lmOUS/E82TGDGApqJluHCR3W2Rra0SHE?=
 =?us-ascii?Q?VR8SAcbEHv/tc7xoMhQjoKZxNtovln6UVQ7716qIuQFad2ZhvVQiB+bN6Bm/?=
 =?us-ascii?Q?2cChO66oghGtDKSV+KuU8xlpms71C9pWe1YOndWINK71ZaP6V9r+KeL8wAK8?=
 =?us-ascii?Q?GAOjO5kEtDZn7eYoMyPeYPlQvQItcxZHgleMW1DZgQPpelU+ZLN5Nq7RN9xb?=
 =?us-ascii?Q?B83+p73y9O058BSmf3Z22jPPTdL8sxIEUgBOk89lS07CyDoML55j9EgBk01y?=
 =?us-ascii?Q?FvgVOZTj8zUy6hFOBUJbGfSu75/duVWLLQ1SaRiDTqDqv2FWCStB9ZVbNRIa?=
 =?us-ascii?Q?+daXMajF8R+KxcNv01TRKuOi0cDiuCjajlqV6jINI6PzrEoeoyE6wQTINQY3?=
 =?us-ascii?Q?2FbjeK7mXoWIqz0/AX0yZzYrV09iNNQ+g7xeaU2HaMkE9ggpDGexf23caTrU?=
 =?us-ascii?Q?yppUtJSOURbgChOBLUuzXkkm8p7SY2QeGyTtt3WdSgMvSjAf6Ob/v4QcHk6L?=
 =?us-ascii?Q?FKxqPQvLBUZfN5yfNejVnCb5K0XrCaSypmxtJfZ2kNagthST+a35YjaQkIGk?=
 =?us-ascii?Q?HINER3p75o1VaQ6HTMdzSauktqD+dhVl8mhnwabmHzVkFcCJJCQxrTEo8r3m?=
 =?us-ascii?Q?XX5FpW40RDbsoqK9aaRAXNABQgg7rqeoaJYx1QoY3jrjcoLsEGmBLOis5TFq?=
 =?us-ascii?Q?oJRU4lEHWP64zEhgZYH1Gk32b1vpiZh2DoB6cOBM0F5cYelu3z/nRZSC4pZx?=
 =?us-ascii?Q?guhVFD7jYx8XPY/wfpL8Y1lHGbDaLuKvC6F8cai+b3lUqaFOf5+oAH4YtiGD?=
 =?us-ascii?Q?99z1o9FuRddz1oPI20D+gcpomfi64xDpJpH8fCx0mdMRyeHEg/LcrpaC1ePG?=
 =?us-ascii?Q?5Y34JbAZl1/XNIKttJJ7k5MFVdBZ9uL3NfjVmF7rSSagK1jGLd3WRhNnibBb?=
 =?us-ascii?Q?1MGte1RVwcei8N5Lv/3LajRliBuBSzjRpSKC5AujRXII2muhBFiq/KRqW4wk?=
 =?us-ascii?Q?XHcnaiGHZq/OylFjllybZqgtNP8vRP44xlE3xzXlHcPk+KkOI1plLKikBjZ1?=
 =?us-ascii?Q?1i816rOJaFO3YCQRLxtzTBUkyRXun65r1ipPXwNn5Fxu6SrvnmNXHCK4xYLI?=
 =?us-ascii?Q?McjFfSNS4XUOwliDuhZaqkiatzPsd5oIlK4/eJC67j0ThP1XZHZjSASH4pld?=
 =?us-ascii?Q?09ZTcazJA2705/yhowsaM9N2QEnPwj+FjZHLKc840N4Opkbbab/F80BiyNA6?=
 =?us-ascii?Q?xJCHHJiYxpyyPeoVX6rqiCbt8m9PwUkVz+65rDrBgccNl7zLyPWIe2nvMmq5?=
 =?us-ascii?Q?3CKaZkOwfFEehsWVd4qcKlfmKFoRbC8cXCvda79psbdcWqu5wiMsyMgEVDip?=
 =?us-ascii?Q?pWFeITfhd6rgEb3eIOBJ7XvV4IAA+0HOQ5KG0d7S996E0Dnb93JZl90FjkhK?=
 =?us-ascii?Q?KoBe+127QDFMUzTcc2zeB4EsLBFhiFhM7v+laBvH7ztTQXlSoS05SDg/gKGr?=
 =?us-ascii?Q?UA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 784c1b90-d50d-4d99-af50-08dd3551a88a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 10:44:59.6177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZtqhxWFStdez+PWSao0xUXM/+/kJtCM0YjHH6+HLbYYvJpG04IYjyvXp/z46Fl3y2UQW50rS61skgAF6guJax6Tle0PG+KZHgPpuBeMMCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9180

Allow user to set custom BD address for NXP chipsets.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml   | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
index 0a2d7baf5db3..499c816071ec 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
@@ -17,6 +17,9 @@ description:
 maintainers:
   - Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
 
+allOf:
+  - $ref: bluetooth-controller.yaml#
+
 properties:
   compatible:
     enum:
@@ -43,7 +46,7 @@ properties:
 required:
   - compatible
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
@@ -54,5 +57,6 @@ examples:
             fw-init-baudrate = <3000000>;
             firmware-name = "uartuart8987_bt_v0.bin";
             device-wakeup-gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
+            local-bd-address = [11 22 33 44 55 66];
         };
     };
-- 
2.25.1

