Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37AD28B4EB;
	Mon, 14 Apr 2025 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744653475; cv=fail; b=kXOxQ6LPj3xiWxYPkzRK0OzEDlpasM9i6Yi7yrhi9qnA5sHyey2f/1tkQvLPiGdBxZJEDgiFIEwmCatABDSefES3BbFAViZZPuGhfAIrckW2ARgjiYLMbKvuc6xtlztmithqf5Mwud1ZOLaeRyjizYs2gWfzPbChXj8l/be331Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744653475; c=relaxed/simple;
	bh=GQqLc563ZSbJCDRPZlndTM359F5aqP9Az0/2flEEYPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dr4E2G3VKzvpr5dAH+3EGJrpayHO5G1Pd5TaOd/egAiz/lpMahG4b370AaNzSfpReVcVmZHISQ8De9LeCr1LbzltQ5eVAa1QFC6TChMb5zL6Q9luM6dpNYeRZJhDf24+xvUTFCSehahHhgCklZKQuvt6Ddjqk7NItcVkK7tURO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JlyacSuN; arc=fail smtp.client-ip=40.107.21.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JlyacSuN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b01Bpk7gOF6u0ElNqKEs2ELC74HFv8WhGU5Qz0Aj2Ykic69lzxOYMMM6Y35OaKy300uzJEI0eWrDckAECCH66Lv77bJe6IOJAvubNtxe88OGpZsZ3TBOoLEFxxb8400MtaWEepA4/FjgtWRwjdR7GngWRz6+SZCqaVsp2I1po2yGi5vApv6Q7Exe26XEIAaXg+L5xI/xtS0BZU3SLTl68cQK9R+L7M4+wRohAkqsnhsAvjLzQyV2cxdEtVYqJnXEIGBskv1hMdnt3elEK0JRa4UgqRC5s1kVKy+3TJdCp0a5bw6OB2vaIJcSlsw6HyRErpmLovgL7MZoAAJWowFktQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wFS3FsVbS8MCloZQpVchtoR1ePdsykVm1er8TXTh9k=;
 b=nia+tGmEo9DR1usCPCSipgqugMQdAnFp+a9nrs6kF+/6JieeUTogv3crp7pTtSwupiMFhsd8dAM35Zh8MznPEhepGdk2x21xHspQADyE3ja+620NdaEjztamDujuN1LcQt9ZiPI4WMIwP2y3HoLzOyh98FZ8ey+M2PLMvTTq7h7JBbHN/lG1wYHPgyVhQvJhzs/JZWsum2jgKW0Ff0a1Cf49nhBsVfmkG2VclzQlj/GGAtoo0VUaveIydG4V9fSCWiNmt5VKvCSUwcsGRh3fy8h0OZKkeUgOB4zv7FniVVQGg63yo3mTTsMouDOguGU73XfsEX8fwHdMwJ+DQ1zNfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wFS3FsVbS8MCloZQpVchtoR1ePdsykVm1er8TXTh9k=;
 b=JlyacSuNC7sWLIfz9dhaD14GtKEBMHDg++Uha/cACfwXkjyOMok9F2GK2ahNwLCB2EiNKPrRzfGzQgNlyagiR0BL5NHqWWXtOnz7U3IHKlCrHZRBd/XOS9xdE3v6egWSbpc6wHMsjG8bKrZDGHE9sbjsC9FJU3wn9nAZgLksI4jl6JHRMdmuJP9Pwz7F5v0RhzJOo/idRu6nby4yV21tmNd0RtDNseNrjOfKNWLguQBtHLa0a5qhJkFqVSHPZcq9UikGI4rEec6xO1Zj33+B9KpZa9aGm70AgPmOVDZdWwKzcMvarfsysGlDo+VYl4gDpUeH9Xg3ifgkix06sRsFDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AM8PR04MB7985.eurprd04.prod.outlook.com (2603:10a6:20b:234::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Mon, 14 Apr
 2025 17:57:50 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 17:57:50 +0000
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
Subject: [PATCH v3 2/2] Bluetooth: btnxpuart: Implement host-wakeup feature
Date: Mon, 14 Apr 2025 23:29:52 +0530
Message-Id: <20250414175952.403002-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250414175952.403002-1-neeraj.sanjaykale@nxp.com>
References: <20250414175952.403002-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0054.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::18) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|AM8PR04MB7985:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e979964-5571-4f56-c1cf-08dd7b7ddf0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IDekM+bts/imSK2h3mAtj6NqevHO+THaWi/lQoIMWtUaXG6ULPUfVr18GVhZ?=
 =?us-ascii?Q?tYpGHe4KWKFBosYnJ678YTakRAZzPxGkQ4pyXSZTuanwi2jSO4Toyp8kS0hQ?=
 =?us-ascii?Q?sXSKEU9WTGsby/moX42mR9JyjY294kGcc2QOiHhTC/ybFSo78CKyI8ud1aCn?=
 =?us-ascii?Q?ZTgHkwoMjolW1RgY6zOzv2wIlVvUT9NFX6Z8qhW20OjAzAylJnt4mqMXk9b8?=
 =?us-ascii?Q?2rPN0L1v6ONWWJWbnZrUDm0pcmgoIatiDUnoYqv7wM3hnvtvuGiOnNssSjiz?=
 =?us-ascii?Q?gfS2ks/cIAHpYCB+T4DW90a5vIjOm7twdyB5x5KVnCWgjuCwpxGdFJm98TKg?=
 =?us-ascii?Q?6r9snlqNbDIgsVnnOBgXr9NQA2O4c1BooAEuumru+xaTw5Aw9pUEripSphHJ?=
 =?us-ascii?Q?nWWFuPJ19DmSiTz8miiCu1NA3WtcGlSjgqRqbRKwWI2zcRIZbblUAzFO7ns+?=
 =?us-ascii?Q?SbmJ48S/yOcVdBkoiOPMtyZGspGPLAa7g7McEhcGe6b6onir987BfUnDGSZw?=
 =?us-ascii?Q?FmKkQkfFpSPfoi9hzStsNi6Mqlt0X+dX8kOGSPjIju50NN3XY5uZu+sTfHMm?=
 =?us-ascii?Q?yhhLMUjJE4TfZQsgCYoVk8CGe4nZAQ7P7ye3s/KPlBCCgfG370sEcPktt49G?=
 =?us-ascii?Q?0avo+3VtSC0+QK1JJKKqUKGOVIRrC+/KxKamloTQJMLJMD2QSt179CQPoQpe?=
 =?us-ascii?Q?oK8fDRqryXo0qaNWNruqghmEXDxcglSzBVDgeY2P2ADMSUw7RB44GzxpHQIN?=
 =?us-ascii?Q?+YwDxXWTPMq95fYloZ3MSUOu93m4iTHZhxLs7jHUN2yrHi/xsSjvIzYN6FMu?=
 =?us-ascii?Q?3FEAMwUEvvfBrzLaUAMwTqx5IfYdHva8RekfdChDBJpng6924EeC8sdmSUSC?=
 =?us-ascii?Q?/FIzIQn4Yb7sIJkZgrOPQB6lYWeAVs+AdTD5Wz38f9lBFI23p23BUYB2UtON?=
 =?us-ascii?Q?SvXiEyegpBK/xNjBpLYfa97626Y/HykvquSSMmGds2DYmuqQM09JwLiKBi+S?=
 =?us-ascii?Q?GgC/jM912txGoJUpTutxitnlVAM61ClIvrnKtBwaUNBEPqpRGPMVyXNjH//k?=
 =?us-ascii?Q?F4aK3pfs4S8KlS2zNxf/7/utjwmCaqSAd4OT0xN8r3nkqnZFou4FpHPB8/t9?=
 =?us-ascii?Q?O4pJsodg3Jg07uq2XbHwRZOIqi+cuCw+w/dPlO8jgsbDtmLL/Whz4I/kI8dN?=
 =?us-ascii?Q?UGpUjeEV7uezrgIpEvtYm3aqE2PEFFiC3YiJrCdb4nZvM0w4RGsFTLCIRgB+?=
 =?us-ascii?Q?Kjh2mQlKBuWNA0BBpIMONQUtC5EwyTSIE8i1afj5I0V83F6oTCx8M8++namf?=
 =?us-ascii?Q?zUAW415XkKA8Ow7OFBzR2I+xJfP0+U1Cq+JBo5ZozfidhQDOzpgTra8VBkkt?=
 =?us-ascii?Q?YK9pvlunffHKoLmiLwup1gmTHJw/cPp0+hEvsi4heRaIA4t002r7VALLslw2?=
 =?us-ascii?Q?mmRR4x2oekE7k7Ox+mdwoHVG/itJlK87BGULN3HfU0XE1OCVxwTtzQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HfmMiBQ+OHdS/1MtGRHiwba6yxlExwdynVgiWwgkoZ/cLlBO1vwAaS691dTO?=
 =?us-ascii?Q?TdUGBhjpNQdGHyu+M/QZKAqfwJymFAFGFGLOSLtaeswXVqPLyT07JxgNlma1?=
 =?us-ascii?Q?HvcyDJ8hgWdoHnTbQsT3k8mXmtCdJBx1vArk0HUo7FyZl+Q7hDJCbdHWQmxY?=
 =?us-ascii?Q?3b9gKeV9vnYOblK9WFyTk7CNcoUfG3FC9EW8Rwb2tbUqSikkQxX5AIWnpqnW?=
 =?us-ascii?Q?zEZ+3KGbFHS2BCEK++2eL55QvNM1G5Z72hrdJ/NSxOVAn7hKZB+WWgYHX7c0?=
 =?us-ascii?Q?9GhsVKemaYHcQzrMj5VfI2tPDO4wH0i3YU3OwXqtJ5Z4PdRojRLEmrYdXT3k?=
 =?us-ascii?Q?zN0G7pMowCCDA+ICAFyC3rSYLefd5mpmdNjZ2BzWr/cMFAZBqsBZbTWhMd1b?=
 =?us-ascii?Q?oyWezHwu/6Ao/3QBcSdih4yHxG4L4uU6bzDRTTZAuGl76QRmVrbAdLM1FEfp?=
 =?us-ascii?Q?AnL+kITW8sky7D03sWVFcyYNYgQCvbus2s3rEzGHQhoe3BaRpGH0AMM/17y0?=
 =?us-ascii?Q?z/y0SKd4dEXbglFdzHlToE1dSzXlcVqN1y83CgmrzEW//mxuPIyHu3zNWETf?=
 =?us-ascii?Q?a8beVG1MmdDj/C5tiNB9xWumBCpc+nKDiiWXgU2fk2nQr9pC81X/D+JXWg6B?=
 =?us-ascii?Q?8ggnXHzsVF+qSowmMBCqxoEg0M20iM+/0DjPCzDQhFecMnGzj6mLT7K6xzwg?=
 =?us-ascii?Q?5SPAZego1OXvoCssH150xSjZ7yGoZkkTcn3W2lAGrWIoyqL27OW/uWVsCJXF?=
 =?us-ascii?Q?TUTA4qQOZ5wdZgxMWIowM4s+tReaLnFIr3FgOK+FTdbTKdohG68Gem8JlJO8?=
 =?us-ascii?Q?YEdrZoKuRb8DRtDo+MoNVxStoKIpiG2ME5Pz33xMRLkju6D1bQWlrvFaHyxa?=
 =?us-ascii?Q?ecXCOH3270EQdWrJHbwXaw8YsQhddlo7Dp1ub+4aZ+shwXPpx0l7Ow2obr/C?=
 =?us-ascii?Q?1p0Ifu+YYKUeM/j0Dbs6MGznhx0uz/h2ykFNZ09GXhsrFTBKH7ML2kY8Y6sZ?=
 =?us-ascii?Q?F4f3knj+lrhJnk839kfByTxp67heDLSZH2Ba95MIxmUghcAzZPZeY+RKkpdD?=
 =?us-ascii?Q?DV+nybEsvBcoitf96ug3FbhoWecdvZIWY6xPhxnWErYn05EnvZYLiaRq7iM7?=
 =?us-ascii?Q?+iJ1p63dXagDsBQ2ftYFrRGUXlc1G14utyD0V6l/ixAuYOIFfalJ5fYDYQfr?=
 =?us-ascii?Q?RJR9X+wnhmRh4k32KDIi4COaCpJA0bK+RVNGXPEAy+nfRbr86qGPTe6B0ezh?=
 =?us-ascii?Q?NA/AVQEXkd5JcXv+8RGX0MHUJGWorUA1zcD2DuDHQnl1Z8JMhN15dZqbxjkE?=
 =?us-ascii?Q?LNKCPFbtP4u0EzvU0AE/FEi4+BAe2Q0hRNu7dJ9GLsDARAi0HtCFI0Jz9bDr?=
 =?us-ascii?Q?nzKdIrhuhBmbgSye2zuddgBt0g5OFEkHW8qnZGao2oQ7ZqV6tNkvZ+/7Sstr?=
 =?us-ascii?Q?g3ZWD2l8QWkJO8ZMzwSFbl9Nb+KsOw8djOJu4l3TYVzJHnbq9T4CEf5Ygtct?=
 =?us-ascii?Q?nBkrzTanp/n7TzFh0PJgXDaySXd6vKTokfirKYmz7A1s/iV22u84abGO4QlR?=
 =?us-ascii?Q?j5WQVob9nLO7npoqQu9v3G/pmmOGOskk7bWPany8Xl6FnW85IJI/kHZ3ijDo?=
 =?us-ascii?Q?DA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e979964-5571-4f56-c1cf-08dd7b7ddf0f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 17:57:50.3275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: POKLvfaUvyQhFzZKKZ63i1+CpTSCYVqSKFE8aq5NFaAa/K5EWARA2qCg58JmcFmb437/FHpxNQDSQthp54/tjyKJ2qQDMFprqifeuvkmzRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7985

This implements host wakeup feature by reading the device tree property
wakeup-source and 'wakeup' interrupt, and nxp,wakeout-pin, and configuring
it as a FALLING EDGE triggered interrupt.

When host is suspended, a trigger from the WAKE_OUT pin of the
controller wakes it up.

To enable this feature, both device tree properties are needed to be
defined.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v2: Use interrupt instead of host-wakeup-gpios. (Rob Herring)
---
 drivers/bluetooth/btnxpuart.c | 58 +++++++++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 604ab2bba231..069a394a7eb8 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -17,6 +17,7 @@
 #include <linux/crc32.h>
 #include <linux/string_helpers.h>
 #include <linux/gpio/consumer.h>
+#include <linux/of_irq.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -143,7 +144,9 @@ struct ps_data {
 	bool  driver_sent_cmd;
 	u16   h2c_ps_interval;
 	u16   c2h_ps_interval;
+	bool  wakeup_source;
 	struct gpio_desc *h2c_ps_gpio;
+	s32 irq_handler;
 	struct hci_dev *hdev;
 	struct work_struct work;
 	struct timer_list ps_timer;
@@ -476,12 +479,21 @@ static void ps_timeout_func(struct timer_list *t)
 	}
 }
 
+static irqreturn_t ps_host_wakeup_irq_handler(int irq, void *priv)
+{
+	struct btnxpuart_dev *nxpdev = (struct btnxpuart_dev *)priv;
+
+	bt_dev_dbg(nxpdev->hdev, "Host wakeup interrupt");
+	return IRQ_HANDLED;
+}
 static int ps_setup(struct hci_dev *hdev)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
 	struct serdev_device *serdev = nxpdev->serdev;
 	struct ps_data *psdata = &nxpdev->psdata;
+	int ret = 0;
 
+	/* Out-Of-Band Device Wakeup */
 	psdata->h2c_ps_gpio = devm_gpiod_get_optional(&serdev->dev, "device-wakeup",
 						      GPIOD_OUT_LOW);
 	if (IS_ERR(psdata->h2c_ps_gpio)) {
@@ -493,11 +505,37 @@ static int ps_setup(struct hci_dev *hdev)
 	if (device_property_read_u8(&serdev->dev, "nxp,wakein-pin", &psdata->h2c_wakeup_gpio)) {
 		psdata->h2c_wakeup_gpio = 0xff; /* 0xff: use default pin/gpio */
 	} else if (!psdata->h2c_ps_gpio) {
-		bt_dev_warn(hdev, "nxp,wakein-pin property without device-wakeup GPIO");
+		bt_dev_warn(hdev, "nxp,wakein-pin property without device-wakeup-gpios");
 		psdata->h2c_wakeup_gpio = 0xff;
 	}
 
-	device_property_read_u8(&serdev->dev, "nxp,wakeout-pin", &psdata->c2h_wakeup_gpio);
+	/* Out-Of-Band Host Wakeup */
+	if (of_property_read_bool(serdev->dev.of_node, "wakeup-source")) {
+		psdata->irq_handler = of_irq_get_byname(serdev->dev.of_node, "wakeup");
+		bt_dev_info(nxpdev->hdev, "irq_handler: %d", psdata->irq_handler);
+		if (psdata->irq_handler > 0)
+			psdata->wakeup_source = true;
+	}
+
+	if (device_property_read_u8(&serdev->dev, "nxp,wakeout-pin", &psdata->c2h_wakeup_gpio)) {
+		psdata->c2h_wakeup_gpio = 0xff;
+		if (psdata->wakeup_source) {
+			bt_dev_warn(hdev, "host wakeup interrupt without nxp,wakeout-pin");
+			psdata->wakeup_source = false;
+		}
+	} else if (!psdata->wakeup_source) {
+		bt_dev_warn(hdev, "nxp,wakeout-pin property without host wakeup interrupt");
+		psdata->c2h_wakeup_gpio = 0xff;
+	}
+
+	if (psdata->wakeup_source) {
+		ret = devm_request_irq(&serdev->dev, psdata->irq_handler,
+					ps_host_wakeup_irq_handler,
+					IRQF_ONESHOT | IRQF_TRIGGER_FALLING,
+					dev_name(&serdev->dev), nxpdev);
+		disable_irq(psdata->irq_handler);
+		device_init_wakeup(&serdev->dev, true);
+	}
 
 	psdata->hdev = hdev;
 	INIT_WORK(&psdata->work, ps_work_func);
@@ -637,12 +675,10 @@ static void ps_init(struct hci_dev *hdev)
 
 	psdata->ps_state = PS_STATE_AWAKE;
 
-	if (psdata->c2h_wakeup_gpio) {
+	if (psdata->c2h_wakeup_gpio != 0xff)
 		psdata->c2h_wakeupmode = BT_HOST_WAKEUP_METHOD_GPIO;
-	} else {
+	else
 		psdata->c2h_wakeupmode = BT_HOST_WAKEUP_METHOD_NONE;
-		psdata->c2h_wakeup_gpio = 0xff;
-	}
 
 	psdata->cur_h2c_wakeupmode = WAKEUP_METHOD_INVALID;
 	if (psdata->h2c_ps_gpio)
@@ -1821,6 +1857,11 @@ static int nxp_serdev_suspend(struct device *dev)
 	struct ps_data *psdata = &nxpdev->psdata;
 
 	ps_control(psdata->hdev, PS_STATE_SLEEP);
+
+	if (psdata->wakeup_source) {
+		enable_irq_wake(psdata->irq_handler);
+		enable_irq(psdata->irq_handler);
+	}
 	return 0;
 }
 
@@ -1829,6 +1870,11 @@ static int nxp_serdev_resume(struct device *dev)
 	struct btnxpuart_dev *nxpdev = dev_get_drvdata(dev);
 	struct ps_data *psdata = &nxpdev->psdata;
 
+	if (psdata->wakeup_source) {
+		disable_irq(psdata->irq_handler);
+		disable_irq_wake(psdata->irq_handler);
+	}
+
 	ps_control(psdata->hdev, PS_STATE_AWAKE);
 	return 0;
 }
-- 
2.25.1

