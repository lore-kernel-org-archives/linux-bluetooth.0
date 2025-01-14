Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2080.outbound.protection.outlook.com [40.107.103.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DCD20F960;
	Tue, 14 Jan 2025 13:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736861687; cv=fail; b=dugRwmLBLtA2NTxj9F8/PloGOLttiEJGjGLihIqAWlNPybvbnfU9n25Q7gCiUyGO2gP+f/1LrAgZ3mQx9Z2krSeCuDDjAKGMMy6G3kYyi8b+rboCfet1PnfhXMhqm9UB+DAyEjb+DnhdLfDW1pkdl+kAwPbU5FrmvFS7+ADHuXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736861687; c=relaxed/simple;
	bh=lOr2ynDC3rVHzudBhL2rzyatyYuBUbWQNL1wZgvPxaI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Hoc8znjIjKpM9j4hICEBeeK5wpkUcu5bsgwTD43aQjYPhkmDUtklhR/NLP2FAOoheUoOMX9eVywtsI5qO3pc5rG5J6h9Ll+GuAvM9LLTo/iHQhgHwooJ28cqCSH1Ki6/AtUqARm0J2ZqeJOIkYNIxh8jmpnOh7VH7oCMGlPNEOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nU+Abs3p; arc=fail smtp.client-ip=40.107.103.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nU+Abs3p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SDgsIQgIABaxcI1vx5K9Flrhj/mFIPa3FmHQ9TGNX+w4j1qFBHfY8VeuFkmbXVpQfxmjicBnA5rOo9pnHQiw8iEHaTnZS68aKwkJHFkY0MxxiJJCuXYzhmDfZTVZB0pxukTCBLFtbXC3otTuxso4EtdDXyjtTz7F4z6xNsdBZofO1BRonhCzwJL1WPOdwv3Ww+75AZqSNIeBbKuawJecKDqti0Uam8dLquCy8lkKZQgYjN2NjF0Ru/wb2Csffy3AvDwkjQmrZFJnIoz2oT/83wAvBMbIsC1mvW+CdmPKwnLsQt6sBvwMpzTdbMWdtsLhFYo0lIFlyrM2Yw5zHZ7ynQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z07CRdol8+YWxA0ylPz7VlRfoOx00FZgxis0xuMQPck=;
 b=boSqHwoaJQRpX2w4eTj4EE0ZQn4NC47GkLbtz427wbUo5olQMy9ItWh+XzCuTXrdhIx6HLut3uygfOfzBRpBso/vXaxa8vAOlAQlvqn3OYTyEuQvrcCWFIjHU581o0DTHzeN2/Xdb/3b7HgiL4ALuJzu/MfIAkMFZfijuAv6SW2iMorOCUwYMRJu/epmWJnF/gMx9firIXpL3aM7/2juDzzcyLIU6l9Vom267lZPny2ez98dx8XXGUNTQuUCPoJc8B+sJvQ5h5CHM+vAQuWtFQjZ2XgUMECQyMrZTJMr34EQ2klLY6aNkXo4VuKgE4HljKrz4BZRDWHyc91utfgDBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z07CRdol8+YWxA0ylPz7VlRfoOx00FZgxis0xuMQPck=;
 b=nU+Abs3pNacIDhNGQqouVbp0Ql4Jb6eHp9xYsVL67s4T+8OsSsnIlFJyYLgs8AbFgNxZGD9cJe7OltHy0PUad6Ioq/BivzngXWASUQAVIYZgYZGPsOsXFu1WvIXzF4xkJu7kbvVXkX8jep5F8oLWa2Bg9j2pdOZSh+VxWhD6oCbuQ+GeU143JfMrNg9xIVT6EAIPRSFXufHUFSDFUTZIrQtcsTi6CKV5qm9TD8WN47RhhCez+Tpi/p4y+fePanorACExHPRzQH0rqwv47fZHmo8QVqd40QN+8n2jQ3zVFZfTtzAOHp+3dqDjRsIfC2XnEwkRhdOQEgxtMdnRVpONyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9687.eurprd04.prod.outlook.com (2603:10a6:102:270::15)
 by DB9PR04MB8252.eurprd04.prod.outlook.com (2603:10a6:10:24d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 13:34:42 +0000
Received: from PA4PR04MB9687.eurprd04.prod.outlook.com
 ([fe80::742e:a5ac:15f4:116a]) by PA4PR04MB9687.eurprd04.prod.outlook.com
 ([fe80::742e:a5ac:15f4:116a%5]) with mapi id 15.20.8335.015; Tue, 14 Jan 2025
 13:34:42 +0000
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
Subject: [PATCH v2 1/2] dt-bindings: net: bluetooth: nxp: Add support to set BD address
Date: Tue, 14 Jan 2025 19:05:47 +0530
Message-Id: <20250114133548.2362038-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::16) To DB9PR04MB9676.eurprd04.prod.outlook.com
 (2603:10a6:10:308::13)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9687:EE_|DB9PR04MB8252:EE_
X-MS-Office365-Filtering-Correlation-Id: 599534bd-6dfc-4c4a-0852-08dd34a03353
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QrV8rxLUNBCi5nQWLn97xrshi7n+TARsZadBxClsKTTaLhNJzS72W4GexFw8?=
 =?us-ascii?Q?y/tRX6mfATeJbQySEJyn0q3svtlMQMNo/fUYT4yEmp3byPrsvBQwWqKIjDUi?=
 =?us-ascii?Q?BH++B+rErpDQov8GLxnNuZFZfu21P9ticPvPpwL88dh+COQgcIe0QKzcPBFt?=
 =?us-ascii?Q?pBydbgi9RrbsCdMIasqNK49TZYmYQA0/XaV6nJM3plL/JHKpC/gt0oqUlANs?=
 =?us-ascii?Q?6EeCl/k6A3SuFGYNDKkfZWglE944UIGdaxCoqgKCbcokWjFko96xtmKKSQNf?=
 =?us-ascii?Q?NzUDrWVnIQMKIcXX9h7UgJlYumNCE5j0O5Fm6QTHwRN9wX8YuJ9Y/qP+9yWl?=
 =?us-ascii?Q?4rJ/CNhCm+D1t6+LoJUvoFkwZyrOQeArl/mObQLrKxyiQgQzcOFqOqe3d/WB?=
 =?us-ascii?Q?BXHIp6U1xeTnnx2ZOor0/Ua09wbq/xE8IxPQG30hdDQEF9sv1vtnjBN1g9cr?=
 =?us-ascii?Q?X3WKexTn7mu5/qDeTxoTXy/whykT1LHEzgWb6/nLmE97g/iSkOcCZ8ezuGMI?=
 =?us-ascii?Q?T/Y2YTQeicT25esoEBbj3qs4640jv4i+vGzUdnDl27xlN9A+9Lyl2r39NcWv?=
 =?us-ascii?Q?W03EAX4xAhiqzL5Pnv2IKfsHQjh48XEluVkazqTg/UTEyj7k1knrCDYk6IlZ?=
 =?us-ascii?Q?dviJoo43/nGDbqWIBsPBna5cytS0uXD8p0JStf2inCyhxsNC4nyhKXdl1xTy?=
 =?us-ascii?Q?kAbqNPI9atznJspx38bWPvzz8RETxUNW2KqMTA249fubSAkdnziTdYFRTb3U?=
 =?us-ascii?Q?4dRnWMsXboDrls81lQZWChyDODPOE6J9Nm/nXzUmOnabpz2D5p+UVaLkVtkU?=
 =?us-ascii?Q?5sPZOLOVYeqOKtNsOVM93iVLLTAFSgdTjtdbb1nbtDMwrzgcp2nSxDCtSGMT?=
 =?us-ascii?Q?yM6JGAlxL1gog9w5kDYgdZnN7HNy4S2GpWRKpz0nBL8W58cIyt6Gh6gXuoHI?=
 =?us-ascii?Q?e1We/YARwIhQO793wKsXbNxtwRCiji3ATgrLZlRpe3B8obiLaMPrcXCwOI23?=
 =?us-ascii?Q?asH2qKs2XnSKNFsE4aJDUH6ojRLW6VTvOiZjLjsHuCO/Mh94tdpYKU3S5BxH?=
 =?us-ascii?Q?rfNWLCPCLlGxYm3K05oiiwZFlSGcFlepxiLjdjrGoKxNaZTStd4kFsNxW4Um?=
 =?us-ascii?Q?aOP240/t+qAGqmR8GPSLSkQkGuRkH9AiMf3vb7QPm5pcSvw/f4gyavGoVXBz?=
 =?us-ascii?Q?8X3UB73fumSxkSlcs9+sDKCvpWBZCzm2YpN+RXGVVd12hxqJxkW4WKcUImfx?=
 =?us-ascii?Q?YkhXeA6rbkhbtL0m8sBPDmU3Tn0KpQCfkfhwjov7NcebnB1B9B6qFtiD86JO?=
 =?us-ascii?Q?LVkn6QD8tcj1jr6Y6VdbjJeqVApbEEfC8CHKoLZT/LlvsJ646OqPTFEQbqGf?=
 =?us-ascii?Q?WCYvWaf80G+bI3G8uhMQyq8kBcIWRXlNbaqnUdlymNsAZWymddjTpiZAnm2j?=
 =?us-ascii?Q?Jxwf1ARZgqoB7Z0x2kzWnhvaWMj9acqV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9687.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cHqAepqUI5k3kMKNoxWcG4qsQqlXz9TcFCBGowUmPY5jbxN8gokzCxfmjoFY?=
 =?us-ascii?Q?sNlbHcvh///sUyixTyKjYuIkUrlUVTNYEFb1C4wRz1TW9UFa0xA/ycMUyESw?=
 =?us-ascii?Q?s23R82UQ7ETq3zcoxAcc8eTcufZNtkNs0rOpyrnH9dCdnl0b2J4MKmFooyeG?=
 =?us-ascii?Q?8oXfNB87WYD3zW8kfMUuCa1ADs9PDRTQdYZhe+VbHBDYf9JqSZs5csfVdNyu?=
 =?us-ascii?Q?hMRCJ28a18V7MwPBRN1Dw9Ve8BuNyNQffsf2NFyAJEXR7+6pDhu4/jaz5IyD?=
 =?us-ascii?Q?RcIEjBopdpUKdhwYAJlu+IUaUkDOYG9/D62weLLimbV23ANYFpGxAnc/ELv9?=
 =?us-ascii?Q?D7z5l+zlHQ7zl7B/Hp3htms8h+I+hWCMx3oJffOWZNITM4jAeVlUevYZ/yrz?=
 =?us-ascii?Q?PjA9+0SzENegLRcAdaubk9T+8VEdTag72CngrVXq0j91iZdswbx3zXsTXJmb?=
 =?us-ascii?Q?hh7ZE/RmHUVaeHXN52TGFR1AgUdeO5/S5MLSKz4F0ogCpc6U1QU4sS0YPXpS?=
 =?us-ascii?Q?WXi4jp1Jrx4fRThQCUYTAepBxXZHjM2/9CpgsZ3hysKKM/sBE2Oxz+ASefeB?=
 =?us-ascii?Q?7EI/P6N5Ha+I0CbQL8ApADEfXyTgrv6Af/DCI2QIM3jiVJGW9fGA0INBOE1Z?=
 =?us-ascii?Q?XT8yj5Y6vrydDKTfNeHF4HcT59M/8I1C6V8nCjkPt+IIJbDlw9eva7tcdkPG?=
 =?us-ascii?Q?fPt6KxtpjZb5zNo2LlUJHYav6bRQH4wfV3zgGI6JKd3QqFtTMixNlnwPJVGa?=
 =?us-ascii?Q?WcTV+2w/VVAatIzomUAq1r/MPCVkcYKqHhp/xwckW+UO5smDrWdrAv3u6pJv?=
 =?us-ascii?Q?v7YKktk6FO3i1t8YrCIRUx6BSg8nJ+SPdnueZ09zTBTuSApczxnuCIZ9Ef9v?=
 =?us-ascii?Q?b/liLSk0NETuM0H9dJ3Gu/oVsq4Ydb9Mt5c3oHuLVIEvi4FnfZHRXMbxCfVC?=
 =?us-ascii?Q?oREuVnvXwU4zCgC3PqSKdcKqQK4S1wrTx3im8btcewIJ84yrtq1ydpRvJ7nA?=
 =?us-ascii?Q?gyc5InfduTIgKmQLTVBXlGWC5t7RPe8KT5olbe0P9YFl2Gl9d5lq/girU/lE?=
 =?us-ascii?Q?h3HSrTYoRPsw/1mjOIJqa1czirPBgMRo2HbZr1zRlzw7KQKFWbcKq37bfe9p?=
 =?us-ascii?Q?5pkptCmc0tKCMlxrV8bJ6yfsUHlR3zLp3zptDULtxPli/bdq0tIyQqaaz0Zh?=
 =?us-ascii?Q?8tw/a9iV5fX5tX1uswWt/D1077hZMhKjmGno1AjD79wBKNFUblALi4YElyO4?=
 =?us-ascii?Q?j7Wt0MS2BhIbDsjxOzZlJCLtfFQItfpDEPUyAZ+V2fe9yCwBZlan6oUQjdHE?=
 =?us-ascii?Q?P7B6o3t7vVMCa+3oG8xrErohf+T+gnyMcBKbGDt3hox9/6SHM69XPrOv9GiE?=
 =?us-ascii?Q?3xePPZrXNhTpA9LlTHZc1QAwa1TqB7zBkuKmRG8i8OyX3qJlko3+HExHTBfa?=
 =?us-ascii?Q?qiXKY4bIE3AzGZd5hTqUTNV/10QVZJWwtPekXLbWg3KrLemG6RyLxpSToyxq?=
 =?us-ascii?Q?pLtnbUm3oPZ+PthlCGZnBCQyrho8Q3hv65HdXRJi98j3TCoDKFwB9/UObfIZ?=
 =?us-ascii?Q?cnJ45RhllyxrDjSSwguPIlNPopdU9Rq8gDTAnp1emzb5ZhPkvmXmVFhWnc3v?=
 =?us-ascii?Q?gg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 599534bd-6dfc-4c4a-0852-08dd34a03353
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 13:34:42.4058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HLmm5MC4RmYUXRedKaGK1U3XFFRNL6fk89bTccDKA+KzHfe+Nlg6VFHdXjqdWVkVv9JZpGIbux7go5m70XPBXaSNymRCoMxpUV2isDZu9JQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8252

This adds a new optional device tree property local-bd-address to allow
user to set custom BD address for NXP chipsets.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v2: Add allOf and unevaluatedProperties: false (Krzysztof)
--- 
 .../devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
index 0a2d7baf5db3..5d75a45cac14 100644
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
@@ -40,10 +43,12 @@ properties:
       Host-To-Chip power save mechanism is driven by this GPIO
       connected to BT_WAKE_IN pin of the NXP chipset.
 
+  local-bd-address: true
+
 required:
   - compatible
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
@@ -54,5 +59,6 @@ examples:
             fw-init-baudrate = <3000000>;
             firmware-name = "uartuart8987_bt_v0.bin";
             device-wakeup-gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
+            local-bd-address = [11 22 33 44 55 66];
         };
     };
-- 
2.25.1

