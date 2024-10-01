Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011023.outbound.protection.outlook.com [52.101.65.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41671CC157;
	Tue,  1 Oct 2024 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727804387; cv=fail; b=Us8aCqo86JegBqKrWqywMC06OfAumBvLoBWUhFL+QpLBQ8QRz8QijZmpcfZslrhO59Fcn08YK28Soi9RLI9T1XnLoSlwzuInLygYJfRBA+pQLcDwUcFzFszy9BsHcMB7pfGipE7HGlv3d3bLAqHj0kxMoOATWFQUewIo0iqNcJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727804387; c=relaxed/simple;
	bh=Ht6NcNXC5NU2fywyiL9Z1pwQOBKHwUv18OPmjYpb66M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vug3LqV0UA+28m+WEFBWCXDJTJSrlc6/YO5nirJsHc9VOaqK5hNVgJCrgi2jI2QO7Z53CsMttAASvjGhscDqpSdLKb6jG0MsPrrOuUwCwlUhcC75CzLJUOWYgFmH/OHar796wF+Wnj3vnnp8qAc2WVYUqo1z9MDZF0eNABSCU4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=avQy0tRx; arc=fail smtp.client-ip=52.101.65.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="avQy0tRx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWltVbLCwW71fGXSFTriJSUX6NmO/qGvzZxQbNYyGJfVeLT5UQ5mDHWwHQXXYUPDdLvYkgfZ3kV2W2vj5KqXtTaqiYESgKWYr4TFvWDHbeDJCzoB50XUlxZrE6hLAfMtMlWcYTWqzXijl/gR9oflWn0atgh41UuFQVjUgwBsu1kiJ6xJi3M6du0PDt66+kGzYLoGdZXJ4W/TPBB6PSbal0QLBAA+cGkFEyza7EyVSfvS13G45vAQOD3HRHCs8Hhyx0iwYp1uHeXZra4kYonQd3RcKHJ37kesSyDbPbFAMhjHjUfZ5kStwcRP8cCuHSet2RwoEzFMIte2EoIBWpgd3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K709c1NIBwjC9N1dOeMBNnnPe9fWB2phStDOj7npOtY=;
 b=amhx8REaO8yQg2T3YUWC7qxJw7Rh+tsJRB1VQx21D/Ysyk+B2NbQjxXwCk8NpiiVEqTibKY6kg2DccEtvwNEwQ+A37zFmS7xM3zlT7Vu/xF+T9HFiaMQyI+eaFSHQ0xmxoP9Jfg/LwNcWS2BQ/8x98k5cY1TOQdrM8ilYquJmOkrJ0e42jz90vCYs7n+7JDs7xe+XoVd+FAvLHH5bi2Qy5Nv6OjQNVONjjrSbyQmOPFcBpTw0YfGBeA52UEaQatxEHctXnveyRbTqmYKq1pcilv+jtHfYEnqIuG0DMrKrhlvduvxFqDwAaw9YnoFcP6F9B/QpldX5vv4PjCRT1PHxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K709c1NIBwjC9N1dOeMBNnnPe9fWB2phStDOj7npOtY=;
 b=avQy0tRxl2qBWmtUGpDSGJhpDpyxysk1zno8HmBZixGf+U3TPaExbioxdwzr8hU2gA9O6EkwRx/Yr43+DiUQvzBG2+FUFLxdo/SDwV+4eeddImFoM5FjS09re8p0Rz0wLumw9uUJ6EBwDnennzkifGe28spBfiyds+cgqiMD5+qeIbi/HikE4lKNnObRfghwMuPsOF1m/3qBSPBfZA+KjtIrQKWi84L5WXJEVdtkEYQUBsnS02RQ9ltCaphKOWq+Mc+cJbYnaSytUNbWLrDFveMh2KKYEfvmb+e8isTBfq2071thm0gMPOWKLkHQoUlzO+Rux697mfHMOnpEeCbHCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by DB9PR04MB9789.eurprd04.prod.outlook.com (2603:10a6:10:4ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 17:39:42 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 17:39:42 +0000
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
Subject: [PATCH v1 1/2] dt-bindings: net: bluetooth: nxp: Add support for power save feature using GPIO
Date: Tue,  1 Oct 2024 23:10:20 +0530
Message-Id: <20241001174021.522254-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241001174021.522254-1-neeraj.sanjaykale@nxp.com>
References: <20241001174021.522254-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0130.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::27) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|DB9PR04MB9789:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a9887d5-d241-42b6-3038-08dce240082c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gHVgjDxPAYIX/PNZaOxbezzL0LTV/B65J/WeSUdj40s9gmveZWyrb/QJ4REi?=
 =?us-ascii?Q?NU8MnnVHb0l5zVRbBleIWPMW6bMw0cZCKfeK5IubDQAEnPy4F/GoxfIUM5Z9?=
 =?us-ascii?Q?74V7n81i72K56P07n2/0ONSWa5xxOnjnBSOIYgrI8Lv5gwSx+8nCu24zDkF6?=
 =?us-ascii?Q?n2d9+hvvxIgrVGw1+A03Ro4LUa7pKJLrr5QkY6u+wMMEbigWI8HA9yJBTWBU?=
 =?us-ascii?Q?uvthaY03S4RQ9p8r9D5pv6wtT9U8RJvBYfCrxKDqLc1oCf7Oi6JJJcde7ps3?=
 =?us-ascii?Q?0BHqP9DXBPsB9hDqHCy8MECytlGRdRUySZEtbbcPFLjLiuxUifyHk4Fs27d9?=
 =?us-ascii?Q?XTMs6f0hHdLDnuEPza9byf5rdI6dz88GfpxpxVsm7ZzGQ6wpdGmzTC5C2CCu?=
 =?us-ascii?Q?SaCKuzda7UXOW6WF7FlfOwzeyeN3zetxMW1wa5PkjpVywQfpAgNCnFmELb/R?=
 =?us-ascii?Q?zKw0JyjXGma3Y8IqwytYEg7YEaTebJlKO6CPQg8NWjBx+kQZ+cnYVmlHC2/K?=
 =?us-ascii?Q?/oivqagivb0dIPQ4BUzlWArjX+uZb918fQy8qqln1nWaYCzQCK77HIl0OOUf?=
 =?us-ascii?Q?9jTXpT+b05SbC+eNe9mC2Mp58mXAOaMkdEc9/LROac+uedArbjXNgDbfl1Sx?=
 =?us-ascii?Q?NPQSToqw5oaWf3x1apBh0BKFlDjVg6eip7lACOvQORkc6X4UOznEa7AdkS6Q?=
 =?us-ascii?Q?5UeU91dMWypdz2DMK+YvvSjgqlB+cWGkpi+PFbTJfbgi9CKO/nMFkRgR+vdZ?=
 =?us-ascii?Q?8u8vQvmBiJN4RcWrqRHk2iRaXAgYSchJ3U6fA1LgaQBmAu8KBmXs1GOHYw3I?=
 =?us-ascii?Q?xieh/EUNijTHOUhKD37GklX2e9yaav8cM8x5TV/wuX2hz0mAj6O94qb2sZ0r?=
 =?us-ascii?Q?rr3HXG8qAgt5ANn4JzaK5eTs8eez4UFbrw3ymwPezikzLBAPx+f8mlnPgzuM?=
 =?us-ascii?Q?VKitti37FyE4MSmkZTNd//Vgf8teseACEOBu/QargaZc5TILnK4bWWyr/70e?=
 =?us-ascii?Q?bIoMgJNgQyz0hULgNX8APSzaGs7Z2xIxx+HwumpH3lxzEYQ5LlTeYvrh0jcu?=
 =?us-ascii?Q?xmv575whnVQz/sUY+YNpV7R4R0eaI3i+4DyYU5JBhSGMKL+BuTbRfpgW77I9?=
 =?us-ascii?Q?wOwBUi0pg4lkSx2jBG7sJWgPRtcBc8c/0XfDN5XeF1cRaZkKRHpJiA6Gvzmk?=
 =?us-ascii?Q?NiU+gSYQHokhwd6T/HyZ6hN/+5TNxd0F2BROOGcunuvcBG9zJI6qjvF9t9T2?=
 =?us-ascii?Q?SYprGR8z03AkHxAn1cjYHZUeOl53R4iHJMtsrK/GEu1CGMyLeJbbmuMzZAYx?=
 =?us-ascii?Q?/WZS2rTXeKGz72/KB8dP5VAwYedACk6VvNWuCzLIxI5gnA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2HBrDRXhXK+D5m/WxChgXh6xgdr8VH1U1VkKxskK/pSn2Yh8XeH8gWtggk99?=
 =?us-ascii?Q?bdMpG6FvtoyXJbwiI/HJL+PJIxIQT1H1oXjLdck/BKPiv+//pFVpClvH3Y94?=
 =?us-ascii?Q?px8diF2r8jra6M9Lx20rlO4JCYTVcc6d2BWFnJExYFvZNJ0JwQXp1qKScMo7?=
 =?us-ascii?Q?lByztqRsZC/AUt0q+S3DoJCWPlPtkRt/ZtVRkFH4rPXpSmA+WObtVNo0yI11?=
 =?us-ascii?Q?YXxxTLPS1dLZmzIiha0Qpy7VWgiAgEA/rhNKWd51PMY+ZZrulMHhemWlejrx?=
 =?us-ascii?Q?80iiLAzjNDghGro8OjtWbGcrTLOT7il00xS8YI6RVP90N1AVIS1q3usHBh7N?=
 =?us-ascii?Q?TaQgW/JKCR1VkmZfUkyef136/p/WXvngbupgWWjpfGd0rGctl53qW2qnMryh?=
 =?us-ascii?Q?99Azfm9F+foKPfLJbpvZT/65jTdI1d9qTa/Fv7No1fOAsPw6KOyd5yFLtFNl?=
 =?us-ascii?Q?TzrtDuYg4L/Sfrk2XSaOBD95AGO1e5VrM9c891oJ1NqwGK6Cqmux1R1ZA++E?=
 =?us-ascii?Q?ChPT1QrhRk29Rd5h5/lomoVLD8tMVc9Bhm8RYovqRYimHPeDg6H9QwxqCjR7?=
 =?us-ascii?Q?Ns+JNlO4niyzeyjaARfDl4riIKJ2ZBuhSp2BiSyJjI9w4Of1cyq3tpmgOrIP?=
 =?us-ascii?Q?dO6r3YQyKOSOumfO/dD8V8IOBc1bjIDkHKrMFRdqWRVgABNhvNjLFrcLyd3G?=
 =?us-ascii?Q?rlaTnq11kcW1g9quOaBrsIfKRnQIeQs7e7ZxUCWUebKopha56ETXKg+Vb2hm?=
 =?us-ascii?Q?Ob1o+9aY4VodlZ/kp1k7AclxDYGdNpu4sjGNOAUrAPH+lwTeVTydmUdVuSEW?=
 =?us-ascii?Q?zBRX8wa+PCk86rirfzarg/uSSBw7hiaKdZ+QjQ7YC9E5VE1MUXBas9cvDdGw?=
 =?us-ascii?Q?a53krVW3jYuJjblrtyLoUH63J3g+e5/5Vi99nyh8H/Gb4OXNcjERzyVEdA4m?=
 =?us-ascii?Q?n/0CCFMqv/Y81dbEyGEODaHkgc4gK/cNHrTiMKfGr67So9pdWaRrH3tYMyHg?=
 =?us-ascii?Q?MB33Q5qNcqomZaEsS4yJTc4bqrSSgt6uHvoi7KhIFgL+ku4J4sUxnbSeBQLH?=
 =?us-ascii?Q?fSfEi2+37jH1Ots4oF6iGwUIdOz7WgcqEt0sd2+WGDS48fCg/F0XFKWRhSBt?=
 =?us-ascii?Q?1ApIyiiv0KD15tW1fel7nOpDfDSE+E3Eu77gtbDRTQiNKgXVyz2nyltJvw/y?=
 =?us-ascii?Q?jvC954mF7yYuGgADCfNTaUJM8i/LzXXoxL3G5aqkIJIetNHLw9450iAfn5Kp?=
 =?us-ascii?Q?1qbkCPtjIgNheK+PiOPjLkpwqBYhlrf2tFoxCztYk6og8nNDKFGIkgsPgIPh?=
 =?us-ascii?Q?gJ5KVV/1RjzCYdeKvuFdh3iWcaTmNovlFO7LxbFgicjgULU+brzefSNdBOtF?=
 =?us-ascii?Q?lVZTPm7eQDrrbIqHzt/RkBJV1c0sLTBFguN5swm9BJ5Jsg8i+5v+08Ahm5vm?=
 =?us-ascii?Q?PaF5nti0BsI/mTLW23ExyTnk+b9b92qmmD7+RRwH6h5Dyl8qu3NjXIGhVhD1?=
 =?us-ascii?Q?uMu759mI0vUEMtOagPLE0iMlkhcPLWjZqVO4QTPA67w5BwqEX1R/LhSqIEXq?=
 =?us-ascii?Q?ASqws3KBMs7wE1hy4SUQthGMI6FzvFe1+GgMD3+fKWV+FwfyH9rxtZite0Zv?=
 =?us-ascii?Q?6g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9887d5-d241-42b6-3038-08dce240082c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 17:39:42.5214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3gRnw/93Xv7qLQVvKfH+OIgjAdVESzaE8SRWl60luSMAXcWRIanviqJq1k7+eJeW6B/O8r6qHo5BF02YfBVxU2F75p0xDbQYep1D5Gafig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9789

This adds a new optional device tree property called h2c-ps-gpio.

If this property is defined, the driver will use this GPIO for driving chip
into sleep/wakeup state.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 .../devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml  | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
index 37a65badb448..e4eeee9bed68 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
@@ -34,6 +34,11 @@ properties:
   firmware-name:
     maxItems: 1
 
+  h2c-ps-gpio:
+    maxItems: 1
+    description:
+      Host-To-Chip power save mechanism is driven by this GPIO.
+
 required:
   - compatible
 
@@ -41,10 +46,12 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
     serial {
         bluetooth {
             compatible = "nxp,88w8987-bt";
             fw-init-baudrate = <3000000>;
             firmware-name = "uartuart8987_bt_v0.bin";
+            h2c-ps-gpio = <&gpio 11 GPIO_ACTIVE_HIGH>;
         };
     };
-- 
2.25.1

