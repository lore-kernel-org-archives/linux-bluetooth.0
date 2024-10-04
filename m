Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013044.outbound.protection.outlook.com [52.101.67.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F6115F3EF;
	Fri,  4 Oct 2024 12:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728044335; cv=fail; b=jz2+mgR69N2dyEbUcSCqm45E8RZXM/F+YDgvr4AY0Mzv1eB7bm1EI+VcR8OVbWXV5qM9Suzf1KlctuKL74Qc9bpx6Fq7gb/zoF3Sryesy6gnJgVc2W4VFRUHB1Zy0BCdEj5IA9gkNrv+uNOtJCFD/y09L68xN4LHpKp87VU5B/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728044335; c=relaxed/simple;
	bh=5abaw0E43hJILoDRZ8BjiHvshJG1dne5VRMPYhFHWfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J305oDo/WtUnigk4NFm+koccKZuNhTomz+3WaJTHkXJuNSwqLSfgRHmAPgv569O5UPjZA4mJDO/tDXAri6LRb4mIzF/5UENpTwpKYHOehyqTGBiIWwaByv+29BgeIhGlBUuLQMAo9vSmIbJf3d7xD9pC4EQM5fkht7nZYoibyBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cC8qvkH4; arc=fail smtp.client-ip=52.101.67.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cC8qvkH4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lhvSoK49v/Bq/CkvUhxLZK87upUtKqQggWkRYGj3k1YGLxWES7diq67rMkiGBA3wl8Vr+89RTnt/LVkApTDd0kYLL4lgkT/ZDYhSyha0Dd+zsLdzAo545x5Y2ErFu+vWh1EwX2MJs662wsjwt3vZbB05ekQUDTN9ByZxIq6eiHCeGaxfzCikAIHTZ0UBAkFUa+Wfk5F6JcVclUae3bvhnniCzwW0OfY288MkhEaGO7GKyS7UNhM8wdACNSpmJsDPDPHCPdxcwhfi5Aqa3ZqeBxQtWx0ior8Ht/1VnydYu97Hus7lKqqau9rlnYcoF4VXe5uziyikA5boqxnJ0Cz2GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVCxhbeMdxlZUh+5Ol23IzOWTXVhU/kOjw0nmA6yemY=;
 b=teB7llJvq6cRnTFOjeIAAkCf/mQGo6mfgnnwTyQE8hHiPCaq8JQGU7MEU1Tvmnax09hEy5lP7LzlUITVQ70Sc1zmr5DHcyjX9ba5MLwzAkdhOw7Zr/0rnrUj9zWaa3yoxm1VdIvpD/vS7u/rXzIR97C8QlZjZueJ2nIcniHKdbHVCj6ncAsoo4LLoUiZ4pIUc6uubmJgO+wqCCR1QUDH64mim1v5PcmI5nED3cFnCzOKdAFPpdBTmqs3MYbmhKDuJkQv9MjeBVJXZhQNYTysYSd7ycp5/Wmorhi6++ahh5XStd0vLYxjMnKbsyrSEeSqX9KtNIeUZH/8HQkWYI+gJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVCxhbeMdxlZUh+5Ol23IzOWTXVhU/kOjw0nmA6yemY=;
 b=cC8qvkH4xVqkMqyxSSx/eZY/eFJyLwEXsgNl1Qy7jANNxBsVyYQ2iSOSUrBg5+APAuRde/7R8818MKlyD4ZkHJTRncGXRF5JMnWk25q0M/vKk2v9nu9PlLIWt7S1J5zNUgFygmoAfKyxhfes2ncQIW02TfrybdVnR1VN2YvHqst6Kl/iRvUw+VuQSTQqKB9Kq55agjY0JR1mvQ2UO1EX8/Zpjhp+pvhtUuBdeuLIHZZ68/+SrfOJDC8mhTcaNBvMG+oYjILrG2mC+76Mz4wTrp7w2uA0DV5h9dPnqKFDNRN8P7xo23rNxN/1l0+oBK7t1pkpC6fSVPRx7OXkeepOpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by DUZPR04MB9871.eurprd04.prod.outlook.com (2603:10a6:10:4b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 12:18:43 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 12:18:43 +0000
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
	rohit.fule@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	ziniu.wang_1@nxp.com,
	haibo.chen@nxp.com,
	LnxRevLi@nxp.com
Subject: [PATCH v3 1/2] dt-bindings: net: bluetooth: nxp: Add support for power save feature using GPIO
Date: Fri,  4 Oct 2024 17:49:40 +0530
Message-Id: <20241004121941.572539-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241004121941.572539-1-neeraj.sanjaykale@nxp.com>
References: <20241004121941.572539-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|DUZPR04MB9871:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b65bfa-b351-4c0b-fe47-08dce46eb050
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vADzZWpnaa4Dknuis3tE8w5Io2qtIPi9VKnDmNu1OtTxAuS9FoS7B9/MghY5?=
 =?us-ascii?Q?BAdVx4rem2p+F3vipqW+DWRyag5HciR3vNfj4UqGRuNdEEie1QCGlY+XIjjO?=
 =?us-ascii?Q?wXDRdDVNNDnG03DDacyNMWrkOAMxLRcf4eXk/m0ZPu0LDTd7NnYgSYL5Ojpi?=
 =?us-ascii?Q?6ZJRnjZuoqCxFzebG1sqpc2tsKOiMWAZNuiQH/B2IqfYsln8ZoIXvZdqYkNh?=
 =?us-ascii?Q?jbrr8KXi9GrfLtEU4ZTvodaXs/BITfW1mPdQfYQKRNhemQZi+zWHDq90PuTY?=
 =?us-ascii?Q?BjZgxp29fZjOV4txVk7AoxeCu2xCVBmxShqESVYIyWaI3SKqOqwIqWoEajA6?=
 =?us-ascii?Q?6+SwPz/8TFo8PV1d6WSz0+oxdqsmq5nWpdYm05xRCgCuIwjLWIR0v8djnbTK?=
 =?us-ascii?Q?FHpTZTtsCklwYJ6gejMcqeGKhY/UVOb/mbSPLedEKlalOPUvSISn86E6JSof?=
 =?us-ascii?Q?jYtZPaP8y2V+BqpTK+rVuQ2Z1MkqITc/1ttCWs/q5GrfiJzYq45BMzG1Td04?=
 =?us-ascii?Q?AOOhR7Ng8Z0A96L8+L/DYXRNrWfkeEyjDiBKMzQciJj5ZXYmAZZhOXjx5Yek?=
 =?us-ascii?Q?opjYO/6NT/nh+UX+j4r99bw7rJHqfMt6aiSyBqsB3Z1NjZvPvcMX3hm42diP?=
 =?us-ascii?Q?rL0+NodzyulPLek05walSH5FW62U/tCTuc6KkhUDVKTQ5iv83AQEye4oM/6R?=
 =?us-ascii?Q?drDYIzKewtMdbnZFU1z20xsTvZieu9h2YxrEw02r49NGUnTV0WXRC61e7jyg?=
 =?us-ascii?Q?mo3HuhRLNVM1l6rCvxo+r0qThph2BMPr78pokRnQYi2LHP0ynwAdkFg8hgrl?=
 =?us-ascii?Q?xMC82VujpbyeFw0lib5d2qNhNo0huvEylPrn3eXFAYrTaUvX8d8fQhtxoshX?=
 =?us-ascii?Q?K3fXtVtXwHK0AIfOTqNkDcENLN/vK0uJj+8MSn4FZSpbFC4OQXpZgSuvVTPH?=
 =?us-ascii?Q?7zwBGiJUo4APX/ediPd89C/tGpcwI7XSSE3/oJKXC3HvY6gm7vk2N5mW/jgb?=
 =?us-ascii?Q?8gE5uFn8wEQMMm8vbMjI5M9HGcSlmuqrC3qifvYQ2ptNG0IitN6g37z+DOrW?=
 =?us-ascii?Q?pJnN9Z01JY/8DAjsLSR8PkprHMs8vABHnevYp+jTJFCzmjcVwjRVAsrjzILa?=
 =?us-ascii?Q?f0AJIIv/Nv+wdtF+EtWAKlL9EFtydNg5AFAviotF7NWCdo1arqCDEEF60/G/?=
 =?us-ascii?Q?XgD+z7KFkPXXi84LIX+5i92eRNbIbLy/vgXc05bEvvUZ1Tyalv3copcIYjeH?=
 =?us-ascii?Q?ugmW0ab/F2C/WBVCc6JbmbGt9vFAJVIbF5/URVl5cBoVJsjqLkEpFuMeXA++?=
 =?us-ascii?Q?lqdT54rKUwtmSW9czsj6z6dbHJSqkRAJJZon5l3a/hAo4w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RVmhXD6amcdor7fmbcBnQuyVohDc5zzsJYO/f+QQcOvN/9X/9WPMkWfS1Cb3?=
 =?us-ascii?Q?UkLORi4o8k7AVEyG3BWOeOBucK1PASUP2UXxadFb3FguVxamF2TcBSX9tAq3?=
 =?us-ascii?Q?yVeAGlgEbOAPEzwVWA8/hvbbM4F2fvTHqPDtkTEa3Li0SS2EKxCJGFeZyfXx?=
 =?us-ascii?Q?Ilb0ZJh84tyMqbL92RPAqSZ6uRY0712fPAZQVt9WDTbgvwJKkXXCXjL3lsEv?=
 =?us-ascii?Q?onZmVChUIoHN0BsDXbI6ajlcaccemsNToxdYnkYUnh1KDKSUt5QlAK8yrvcY?=
 =?us-ascii?Q?sfgMw0tddl4K5S+y3wCe7ci+HneJXGWTcqf5S1lZfTH4wBmUuLYgXzamAFfR?=
 =?us-ascii?Q?TiGcq3jH2kt/IyikKeAqhiuvF8X3YjZu6GehtSCpyfK58klxbVjjOApk5OgQ?=
 =?us-ascii?Q?/RyjYlfBt2OdrKiKxvKVlqqkP24UulMXOBc0CakUZCFtgclGw65DdYrThVCX?=
 =?us-ascii?Q?eTcvaCZU/vPU8cdZArqRfdCf4jd60U/B6YbAIwqR2QdiAq5Vce59RtDHSI38?=
 =?us-ascii?Q?pzfBTxe2Y1i1DibyOpFLaxvSABASLkUBDYYS1ljtWyssYFIVIdgScGWAlmTp?=
 =?us-ascii?Q?c47/5jgn+VkSh/KDAF5yWac7XymaZwtpBxqFkJfP7Md6xrxapPQfbfqT5Rp9?=
 =?us-ascii?Q?K7KRw59aEu9aXKdSu8Kj2VbMRzNeqcp8X8MnBfgo0dOoJaoosGSPYH3BA3Cs?=
 =?us-ascii?Q?F1lT0Dt2JQrSrIxjGANWcZFK2LBvHR8JKZfQiwsA1rggkyzOEy215LzSWu8+?=
 =?us-ascii?Q?GC5QwIllLxVFaYwezQD3uwteNHRe0v8MOVWeo/BcX1mzG+W46ldWxdKL8zEs?=
 =?us-ascii?Q?SltYVlErfCHGiHWWvw9fe9uqe3wpRbIbTYMLiEIufn1R1gXsRRPRLORP5ALo?=
 =?us-ascii?Q?yzphaOhjShFawu6HgWJ5EXU2pt+L/upnT+M+EORl/lI5zFGsAawEwRy+WPHj?=
 =?us-ascii?Q?SH4ZB8cUFLcbTA2YMrF1v1QhGg/r51wM/5cEmYxQZf1vbHY8ZMbNOeaEvWW9?=
 =?us-ascii?Q?S9EzbX1a6JceVDetjnwTj7PCQ+JFq93GFEOyMD3HTxefnjaS5tNhk2SwlYKI?=
 =?us-ascii?Q?9RDoJIkoKhnDGSq8d3YiIvWq/0JOMwYHo7yUjjTN8krSpJM8tgAsryDLajDw?=
 =?us-ascii?Q?OSD8isidlo0EQbvmsp0kPCQ45TVoMXTd8UXP6iZur/ItZLNE/9/GmvoJUIsB?=
 =?us-ascii?Q?tSxLEUB0b4psaSFkOa4foHFbjjMU438mQbyBpTxWpXzXX2a64nmSCH6eirLl?=
 =?us-ascii?Q?JHiQkpGMXfAvvbI0fVoM4dqkTVrEGHji5jqeaH+lweZSTAmv3JLSnLdC6hp+?=
 =?us-ascii?Q?UUzBOnnplL0sTTKHW5wYdOn+U1x04iJ8H+6Rci4HDC+MqB1V6EETZf9w3wvt?=
 =?us-ascii?Q?JPfJPMVNr0Cl2R4EPSFPVTHgyrppms3XzRJQulqTItIm969TpYz1H6tH2VQW?=
 =?us-ascii?Q?uGeyX0SPnR1AfslxwIKAUC9WPenuJ9tAZd3ST0mOpC8s7Dcfw139d2JT64Be?=
 =?us-ascii?Q?MPrcB3xp5HWnIGRgwfQGi6mPwyAfq24nkNDE5xm2A3QWHYGNMhLrD6hVZU0q?=
 =?us-ascii?Q?xnnXaA66TZuSB+ZHgw4eQDYJLcRIhOTSjThzui+UtbVijKDewIcFsaFUawJm?=
 =?us-ascii?Q?yA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b65bfa-b351-4c0b-fe47-08dce46eb050
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 12:18:43.7156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nSOItukBZAqd5Is9OR1S1cu7n+5Qs7t8bjYrAYIIfO1kQOw2iKZt3y5d8g6myz1hIJwqgt8JyVIQFoTWjTd4f/uSICCScwrEO4yGPy4Z/qs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9871

This adds a new optional device tree property device-wakeup-gpios, which specifies
the GPIO connected to BT_WAKE_IN pin of the NXP chipset.

If this property is defined, the driver will use this GPIO for driving chip
into sleep/wakeup state, else use the UART break signal by default.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v2: Rephrase description and use "-gpios". (Krzysztof, Rob)
v3: Use device-wakeup-gpios instead of h2c-ps-gpios. (Krzysztof)
---
 .../devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
index 37a65badb448..0a2d7baf5db3 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
@@ -34,6 +34,12 @@ properties:
   firmware-name:
     maxItems: 1
 
+  device-wakeup-gpios:
+    maxItems: 1
+    description:
+      Host-To-Chip power save mechanism is driven by this GPIO
+      connected to BT_WAKE_IN pin of the NXP chipset.
+
 required:
   - compatible
 
@@ -41,10 +47,12 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
     serial {
         bluetooth {
             compatible = "nxp,88w8987-bt";
             fw-init-baudrate = <3000000>;
             firmware-name = "uartuart8987_bt_v0.bin";
+            device-wakeup-gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
         };
     };
-- 
2.25.1

