Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013016.outbound.protection.outlook.com [40.107.159.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627662877E3;
	Wed, 18 Jun 2025 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750257496; cv=fail; b=PshGjJKcdvQ4O8Pt1kBwdlTXXIp3yy8DvljxJGvJVGYcoUpJJIqKLGTPiyoZQak2g8DH5c3wF2PyAAGygztMlvKcFs7lEWi5CBMwQkWhn4A/j83ikN+sxKa4NVdU65B04K+AEQS28v67eg0589rZxCczGHICGQmv6k8fCZfXT/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750257496; c=relaxed/simple;
	bh=q5GQc2+lJVA3w4T/C5CjzFNpjtDAXbFrlY+DVkR6tmA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YXPJJ7p5ES00SAFxvvRZMFv1tSvJ7ZLE6TwdkhZJgrtvHniZzWe1X4ako/K+HKFo27OGYlnj4OQ48kbGockzzK63859JvzzSB1Gxg5Cp1iSBDpCNaJpuiQq785Lvd3VydF51PrUgoRQAhGVO/rtFHwJVDi88JE125XBqPuM4hpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z6TsKKMp; arc=fail smtp.client-ip=40.107.159.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z6TsKKMp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BoxtsvczcpALAJdpaBuwS2B7DwcZOpyDE4kZguk6rY/aG8M1/WF2TVi+L4ogILx+vFLscp+s4kG27sn7MKdHXta/1FfZ5pg3irV6wN0n7tjII5vRozN9HbQ0WuzJJQmDcACegEZdF+DOltcl2q0iDGyeaYNwRdp6YY/LSVP6wPCnHJGgsXB+AEgAxx4lRnujASERt1yffheQ4r4eBzGTHCDto27PGyFktGRU+dmnBRhBcqUEH0YScGR8upfOM3m97pm5WECIObBC4SJuPYz9ScVgLPhqnb1K9dcj3Tf7bQMos75ZWSyt/VNStBkpG/Fk1rJ0PLMuinGSBxTdB1dUgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OscZ40IRIQDD+LdntDnirY+hXCamg3dMrZe4wU0OR7M=;
 b=lpbwzWwCAIQmfun8uPGXj5+UAqOU8jzKZSZN4zED1CTmAfkYt7lJBFumFXUcIceGfP/UQx837QH6lx2CXNvboD/795QQ3wUNbBE8u3b4/YDdqZQ6w0NlZJcAbH6mOxxPYKdpXkqK71c7p2cnmHU6Ar82VQSGCMAD2CROtSDZemOKDhC7blgMdvvYyFAW39rE5Tjt5vhyQblNlt6RszgJKYS5WnNDLbYPL2NvuD/x6OjG+Si6ZCK3OCJH3Oml8kLCJ7qAw9vlKANUJEoGq+AKCJF8Bezf2LGsw4PPZR/PXZAAwGSBAdSFJdJ2haQdwAx9mmoJNNV31/+a1oRH8U5Apg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OscZ40IRIQDD+LdntDnirY+hXCamg3dMrZe4wU0OR7M=;
 b=Z6TsKKMpu5eSGS/+bMkS4XXIPo0QrWtjsVRiQFqL7OsF8yVeCiXD40ESC0hk7OcDrjEhrlFBAryZ7QNNk6WqGCydevTChHCSuUPwP8uLgjkl9mzfHNtT/r0qhc5mWeXn0lda5VbmMQUYRpD6wM6ni/4KUDAgLBzdUtr3gKrNyKpJYK1Igd8LglRIpfciSuPaKtIjTQ9t1LDQXfjj2BiixMCE+JWacotHP9oVJ74joe4EslNBB2vgg3cfEIAtNZ1N7nsEKwFqQekj7oxsO+/Op+4Ja1Tmxar9KclthzgTfPjL5DSK5hFNtnlRJMJWXH7xbu3ah4+ciBxutM2ecENeQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PAXPR04MB9571.eurprd04.prod.outlook.com (2603:10a6:102:24e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 18 Jun
 2025 14:38:11 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 14:38:11 +0000
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
Subject: [PATCH v2 1/2] dt-bindings: net: bluetooth: nxp: Add support for 4M baudrate
Date: Wed, 18 Jun 2025 19:50:11 +0530
Message-Id: <20250618142012.25153-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0017.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::6) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|PAXPR04MB9571:EE_
X-MS-Office365-Filtering-Correlation-Id: 77fb44a4-9c0b-41b9-8924-08ddae75bf83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wld8BjBsevUDgaRRjYnHsRwpOIeMeMexQeMBAwfXG0bAqfRy0OGQONQ7rqpW?=
 =?us-ascii?Q?dOplalTGLINpgzlv+kkd8eeO1Lq0zmLoCDnxYdeFszDeti2jRDGOISV6I3C3?=
 =?us-ascii?Q?U81AusEGqLtU6dRO6uLC1OLrTicR6RjhlDv+KhZXTIGhdgEyilHPKvjRpTRG?=
 =?us-ascii?Q?RYoblp0oJhqmmZoEaLoOBZ3weIYy5+EQvto5nOIicNorGrnczI2Qu+76J/UA?=
 =?us-ascii?Q?Fw8h+LUO6IhUMF4XeUMp6JYgOy1O+qA4ynmqkmq3IuCeS/6uHZcCH9u3sXWf?=
 =?us-ascii?Q?/5GqA58B6lIEpIO2wAM07V1g/402hYWa52/Tqz632BgufNI+ZFn5OUG2B2FK?=
 =?us-ascii?Q?a+BaoBNK33NwFt3GFf4K8b9fJ82v623XrTCL56ixMjMXzIzS/GbXdMT11hJo?=
 =?us-ascii?Q?m3Me1JViZw/E5VQc2wvf0hQISd0WKQh867TlsZwGHOch8f+V6aUb7q9NTsja?=
 =?us-ascii?Q?PbBoydN0Z4vL23cwgFhfz4dW7IHkUD6agTYUCNiJM0YJ/+eFfIgiax9g+zHS?=
 =?us-ascii?Q?EiHr+EWnotaB4X72XUgKCvnXW6kNWT6Lr143miyJFSf1CA0tpMw2LRBqp888?=
 =?us-ascii?Q?OldNPQIaLGCPgDkp3dWHv6jlC3i8xihoCiTF8JHLrzkS3zLN1eDR4fC38CcZ?=
 =?us-ascii?Q?OXNHf+BsLMJrTLi/hZXYpbrzKOrijeih7uLWoG0lRRexT5vm1L229I1liJDy?=
 =?us-ascii?Q?zFDxsKRoyAJCRg17AxUL50nAjl8bNuYCD17mIi3l3RrOBz/9VqSWbOvZ2j9X?=
 =?us-ascii?Q?vhX/6gkFfjI7CnZLVB2K642PeisoiUvZwsqGnKOCYi/tI75ABu1+pFbyiwUY?=
 =?us-ascii?Q?XMCtGQzk962xgpGF/rC91YGV8WuZspzsrP7C2FMtvHnjMeCQS111tbdG5HHb?=
 =?us-ascii?Q?GVPzIayhwtlXjG8qpFpGWtEGJy2xj0s82mxV9aaQAm1OuwMYHydwu0V9M4FF?=
 =?us-ascii?Q?GvIGv/xwgMjN0Y2D6XXlWBr98+Y/aQVod1ZvIF/eqX1R2DiId3wDq+gUPlQo?=
 =?us-ascii?Q?RkuwDN+3RoVTQr82rTJBiNtLwn2EKHvYGWl0InNTqLCOpaJukX2Z4NGAe+4P?=
 =?us-ascii?Q?koPazAESY+TbKZ8WDpRxZE2Dxs6CNijd2iCuJocsdqVBYTHvGlIqqPT19G5a?=
 =?us-ascii?Q?38ylt4BcXyLu/Y0XPd1llauWhweImAt7v3xL8MDwaaD9CLj0DEUtSSN46eKh?=
 =?us-ascii?Q?KjZm82OggP3HItnxHBm3PF1eWjUWTyzqq5RVIt+0WPl6b+pB2GiseWmGHme2?=
 =?us-ascii?Q?nWqmBgsCp588j2yut90xXexxysHqSzyI28hZtVmcBm7jB0pmRAugd11kpKV5?=
 =?us-ascii?Q?BqVOWBTxDk6SoFu7R6L8o1TfGY1e5sz0u6nh0vGVqLEak9y2dLmHRAZbKjUB?=
 =?us-ascii?Q?Fk09o5h/S7edytVgUbgANf8TRsyzogzkZbpjzxbwO7QiH8UWajkyTPleYHf0?=
 =?us-ascii?Q?ivUMVOUQXAPCUNASUXG+8geHe3gqAs88CGw7yGMlTbbEbwmIYM2iRg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OfesZW2Se5T04eFVEpgtAKkLsnYvlU28Fxmtkfh4Xshr7sRSwEz26q0ZW8xU?=
 =?us-ascii?Q?D1ZUdd+B1hfdPwmbv2KUunA5j4b12fzT8Kxs98zONKkFlakcbJFW+GQm2c7T?=
 =?us-ascii?Q?1ing39jxvXJz8QL4TfVy8ADAurwKCbFwC1w14RYtMP6TnHDpfSabsS6z/5Lo?=
 =?us-ascii?Q?3ODhNTFST0+KL7OJ/LIAP6wiwYD44vllA32vUDEbYHhN3L9toh/700tUqvVn?=
 =?us-ascii?Q?l2Rxf7io6mwufMz9SlZh4sh5ArKBDB+TwXZ2BpzaV9J0XjJoCHekbxUDNlxK?=
 =?us-ascii?Q?OTeNgaS2CVMKFm8Xgq7rmHHBCGqZoeqITiLWFICMBLvKM/HBetWffKeMSB6t?=
 =?us-ascii?Q?IKIUzzvcViPLSdsWefIv0uNxem+VTXkwzFedKjh4v6OQaWqhBJf2QQ49zjLE?=
 =?us-ascii?Q?tka5hLE8pnYysVpZdG8WnL4bpfmof145cFARJhxsS6y6HUY/yTAMiFWguG4R?=
 =?us-ascii?Q?p69t1/zfKGACRznNqeQ4Le1lBIMWGcVh3ft2Xee9K6H++Q8LgxVKjGh7BYVa?=
 =?us-ascii?Q?ptjQLLZDGWBezyFWcXDsya/eYYt0SeKsq410AOYgfHRAMxMrH26hR5O3qe75?=
 =?us-ascii?Q?sm3jN9DhLM9Zi5kd+x8KPOIFvit2DVptFN2XHIYlz24sbAZVBn0TdB0qhRbk?=
 =?us-ascii?Q?MYeg4zNLqFxUpaGRsu0dZXS/blQKrU723TPdmxFn0PfOUmWcCAtqEABxvJzc?=
 =?us-ascii?Q?x3lV5GDZSZ6aQeTn4IH5VmQuNQQB83YDbdcjx8nIqtez3XiXX982iBMDwWi3?=
 =?us-ascii?Q?JrePcvt8YsvFANTsg3nA6EeRzYVMjhQVKD6unvqi3C6RP22Yskp5JdM8D9gR?=
 =?us-ascii?Q?nQAXPpqI5Gggp6VuJcNn6alkUmvgqxosxAMSmqT//yYGwybtoOuW0jrep4vS?=
 =?us-ascii?Q?BlPHpdKam0GTbWVvgjKB3XtzwP7OE4h05xdF2rJns4w+ijWkshSzwwRhE1Ps?=
 =?us-ascii?Q?D4pYhoQWNyeAVTpIqM9EfzvNNfenjywTsOa+Rh4mdXtZFDA//vFuSTndTWh9?=
 =?us-ascii?Q?ReWKyFU5HE0dL3OxNEhrfseFsVkFBPK07ewQXdj6C9am8Ep9CevVCdww7eq3?=
 =?us-ascii?Q?PHM8+cV5+gTXAUr4jM+JpAkp0KBseGPWXV+VmhWNNglCLxCqqlHK56Y1GTTp?=
 =?us-ascii?Q?Q1vs1PIS01Kd2cBwUa6dhkDx4BD73VQNGay6/pO8TUv/604DyywEcdelUv42?=
 =?us-ascii?Q?Wr0yzGNru8oalz+qY/Z8wl79283pO3PSjGsnDXE/H6+e9kg4/yfMz7KhOHHR?=
 =?us-ascii?Q?lr/eSYD+KmeIJhs2oxKlQ5/1IVrcGWHhOSAbTrVnG+AgxIyFe8QKrn4IQAZf?=
 =?us-ascii?Q?h5tmNF34p8hZ2FL7KW38Q3PlGOZ8rEgrVxDKliofGXlgkRCqAFpUVV45mEJy?=
 =?us-ascii?Q?S9a8MAW/MxiFn36h6e32sf6FU1OX85ix4JdwqLQjbyZxGPmGZr8luvu4HjlB?=
 =?us-ascii?Q?a23TWTBC+KvC9l7exmTy7m0NJLOIpoUTC4UI6rlFv5LRhyuyhB7cv0EzUOCF?=
 =?us-ascii?Q?wQJfJ4rKb/Ex9pHhqOcm5n+lR5pR8a6Mwka7B7swEj43UEBM4Xdw5QUn6n1P?=
 =?us-ascii?Q?9EWEN0YurxI0FlQJgwZp4hvOaKcyvO+G2R0KqS2SQgsyWy6M+R6+8Th8TyNZ?=
 =?us-ascii?Q?Pw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77fb44a4-9c0b-41b9-8924-08ddae75bf83
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 14:38:11.0650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RwnxUfSOKq+jLSAoVnyFDfi5HCQoZ/qZFDht2+RfoCgoq9Ghqzp3n3Cn2jPkhpbY1yW3KAPSg75MUc1BoDvIMTqIwDFM5vNqq6Hw+NRUhuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9571

Add support for 4000000 as secondary baudrate.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v2: Use the available 'max-speed' device tree property. (Krzysztof)
---
 .../devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml  | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
index 3ab60c70286f..4a1b6ea48a2f 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
@@ -34,6 +34,12 @@ properties:
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
 
@@ -78,6 +84,7 @@ examples:
         bluetooth {
             compatible = "nxp,88w8987-bt";
             fw-init-baudrate = <3000000>;
+            max-speed = <4000000>;
             firmware-name = "uartuart8987_bt_v0.bin";
             device-wakeup-gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
             nxp,wakein-pin = /bits/ 8 <18>;
-- 
2.34.1

