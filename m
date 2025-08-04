Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013045.outbound.protection.outlook.com [52.101.72.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7871ACECE;
	Mon,  4 Aug 2025 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754303426; cv=fail; b=I0VX3MleGx9Ekns0jBR2Y/9AmSPdKfYHTB29vE1zYjgP7EjEmCwV1mjPfN401pDr0ADERapsSJLlRtm1+k3U2bGNpdWS5tNVcQmB4c2Widg5vXpuhttJ4dkJOEg/qNR3zfpJ//MUJdFORBpsLYyN1DANCwWWo903b873CVzF2Ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754303426; c=relaxed/simple;
	bh=E1u+AIsxLTvDjqpKrPpl5N+NgtAEGPfePOqewP7cd3U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=efqoSCgLUOEitm0BNRwSXkzu7glfUJNaldo7chVoptOTZgNcVrqzVqvj/Z3C1pTQhUtv93OLrAJ0Q/rR2esuH4CItokA7MWf6gZuwm6rZ71hTaSO4C3CvRqrk8GsTPKVrnNhQy+fE7bhkv6p2VvOkCKMGoBdu9YJMiWd4ppe61E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QAa8wodl; arc=fail smtp.client-ip=52.101.72.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QAa8wodl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Um62bZnX0+Dd9yXYZ1JYmlVJ42mLdgbxm/3VSxbW8Ac+mVcG64U4k0V61fZAOk84BQ+KXRPrHAdWnDAY1gnSSzbiuvQeBbD2JVJTr1W5VcDnIwcTDEnNVPnL4WxjcVGrCar0OKhzPg6wJhTxF+IwovE9dMlPkLnNDAI1X8hu7zoLtPLyEwmVmZWOg++1EtW1f0aypwtPrllkQMYSi3/Wpj+0pRBOWYR8PYObtrsTVMOMZC7ujowjXrog0tkOejKUJqxDLV/V6M/oWZLo89K64y6iII76Laktm/7GUrdiIZ9UJsQ2/WAouFpweM/JfnWHrVutzsVRvvu1DyS/k6WRRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rt1VOzncmNIq3yFodtbG6D0Pbw3ZRe8PyuZLDoVl5c=;
 b=hp4RXMZ/eJ1npc1+HKeeg/uBuXEo5q892jzazkUHMckcMsIqCCwy2mf5EUZ8qZn3sVWQ8KDHIm5/9hHtUx5ut+rmOVM3DXEZBu+IuPSApECUGSCfHUMV+X0DkHXSv6X1IOKs5WPvEtcTRnoSCeRiwHdSl7qVwcEJy9QKUSPwvBj42n8hszgArA+99OseDHvN8elPEufVhsyqnz+RsE+whjNW8XDlXfDAW7/YysCiDaW8c5fM74hsurYNTZ8FDxRSolC6Fza7BTk2SSuUwR8Mnv7siED57AbzAuvpZtgmLJ22AqfO1aD+cuId6lWpt2300VlVvb8RINEmVabomKwXxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rt1VOzncmNIq3yFodtbG6D0Pbw3ZRe8PyuZLDoVl5c=;
 b=QAa8wodlE4eNDxgDMPDaIyzc4a9JPN/bSPfDjCWVpbnQ0Iuv15bJXHyqju5ZcyDSdqk2OqRIq4VLljR+RTCByiRqGEgwZ+geVWh+TZsQrPTRuHdBFZFsxiHtVRGGVCTmBd1AUrUudvzTvRzOYL19Df28BlLqNjVDTw3uiJ39mmdHMOheYr6CKkZNARDQP2/kB4cq+TL20M2++wrWo48PrU4GVquQrf1tfOMvQtSSa7wzNHmtBlxFEioFKe8LpNxOgv05EDjo9QyupVDP0fIPbM9n8KpHq0yDR+BJJqSm+Fi5qke69jSd5kLwQiJQ+p2ziYhE5tDgnW9WMczKVxSXig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by VE1PR04MB7423.eurprd04.prod.outlook.com (2603:10a6:800:1a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 10:30:20 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 10:30:20 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	sherry.sun@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: [PATCH v2] Bluetooth: btnxpuart: Uses threaded IRQ for host wakeup handling
Date: Mon,  4 Aug 2025 16:00:15 +0530
Message-Id: <20250804103015.1104289-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::10)
 To AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|VE1PR04MB7423:EE_
X-MS-Office365-Filtering-Correlation-Id: 60b75eee-719f-4e3e-d328-08ddd341e97e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KKT0hQgoHUNK+1g5qh+SJzhrvWprOp1Q2xV3AD1weXhTdaorrH1mfMsDXeKV?=
 =?us-ascii?Q?8pFvA6XujANvJJnQ+Scl8U7zYyZPFN2VOAQhxo3O77oYf7rilsNHoBJQJXFE?=
 =?us-ascii?Q?ejmt9aAgmrHtIVd/SVR1o696XzUxetle3cAUTAr0RZpkW3R6BsoAiqLVWKub?=
 =?us-ascii?Q?EL8ffvADPgq++wgY3JJl7iQIdb8vLKM86F0EO+bLM51fqRNZ2UjvDrkRzhDm?=
 =?us-ascii?Q?ynmqTPy/DW3pbE3VAgxiQAXoY+FX07BpQljsf0HUfe99rFHkdALEeoFzpMld?=
 =?us-ascii?Q?RUzu+mGJt0DKBqjkFvXpmQwyeWuFkbsA6ziHhlXZ7CDiWKfmZoDRhZYDS+yM?=
 =?us-ascii?Q?xeeMDQ63jEh6lVg5npSUmyWmWLNeZxm52eF45F3j/7aHYu6jRy6RePbO6Zv8?=
 =?us-ascii?Q?DiJo1Ja9d9CkFOAQnD+2HIo9fLRvT8yHcBm6iuajHHaAjjdZ2ovOZ/egqEVa?=
 =?us-ascii?Q?CFodEG/TimGplUsIUmQr+AdnjteDj5WWZ5b3AtBvNO9diUxgd06PHBfojJxA?=
 =?us-ascii?Q?+r2x4ybpOWpNTfhQWgeY+Bqk+uIfGS6dPFQNuJcdFy/opz2h3FGpqcRyQ/Vh?=
 =?us-ascii?Q?YvCafW55QKg9oRX0ZSJutjpcJ9s5NtIBXkI3C+k0EK5DYAAl7CJ+yuE3BOdm?=
 =?us-ascii?Q?IYMskrSigaj4I7b4xf6D9YsI8o5Yj77Y5whV+BiIDrnxhxCRH2PMkqJ3RPoy?=
 =?us-ascii?Q?GW/gbwg3f/4hGlBMmyejfypEcdVPwtoENc4TEIENWGrXjw5MEJPqHdo5iUrY?=
 =?us-ascii?Q?WgXHSuAsUBoEyooRx5ooWxeRJ7te3FWUsG5SQtgm4bwHtCY3h8ii9lN0hUcN?=
 =?us-ascii?Q?ToWtOLqFIjhtLTQl9JGYUfNRmINVPp7iEQVkc3gh8RO5kOwvqiHNJIvacAh9?=
 =?us-ascii?Q?UA/6/KTtWdZ4ie8popZJ24UBcTq1esdVtcXsreKfs3/bSZdOCLm6DDEeBa4C?=
 =?us-ascii?Q?/SS1EINL1U4v6yLiWi5zcJwhNs5gOGAZI12qoR2mji+o3/Z/j1MzAS8rXe9R?=
 =?us-ascii?Q?BOa4leFL24tvWoejIK5PXAYJTACKvBu25nTmRKx0FcZ9cYmjpVkY7/0lOjwz?=
 =?us-ascii?Q?wCQDyWKidVNVVah0aLgP9RYk+xP3KxX4JMuvEt9MLpdZYLwd17LMU680mCQG?=
 =?us-ascii?Q?sm7mclbHfL62vbetssEGyPe9SIaFe5j42jWY0rdbWE3q7p8aSF1EOBjn4+ni?=
 =?us-ascii?Q?5raqo/rdcUeUYNGnvOuxQsrOqFXqWC38TumUpNTnlJF1FQRdgUy22XnS2DT1?=
 =?us-ascii?Q?Y1XUia2xFoXDjwigZ2FRFgoiXvMIXSOKGawR4bNK62pO9DxEwkVV4t3Cy5rw?=
 =?us-ascii?Q?NQs9kYcrRfdy4Xj+E51LjurFfrP0LW30sn5893uGztIXQGaD0pD33PmkiZ6j?=
 =?us-ascii?Q?x/UlY2HeLkh+G5gbbQGXv1KHbmc5O8815Ybd2tp7iSySK4ULoRSq9Afmd9yY?=
 =?us-ascii?Q?W5qMEStnf2xNJpLj1zYeUBxokhAu37kqz0seEvFAn7Jd3oBtl+mkQA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IygIdRxIKhWKb2vERMZTF7DJXTqZOtJCRfCRTJsVOyrvK2kAeMVIGbFfk2fx?=
 =?us-ascii?Q?WRlq00A5kzlFJo46G9RqMzgcc9ojMAdKlqBUe4X8ene8uxIWyKAhpYjE4Dm6?=
 =?us-ascii?Q?SQnsVvmKAGoI4YhBvByuQUZvYVORMlsviQOpUyiH5TCkjpvCNWDM0kFNaMGx?=
 =?us-ascii?Q?CiupCeTFQuYLhEv46FwLDb9WgF+fd9YGSKC+dRwBX+tOArWM+Nd1YfLHZV+v?=
 =?us-ascii?Q?MlbLp2SO8nJ0WLfQO3nGOp0lTOOPK9bRpL7VH8tygApwfPn2QX8kX1nGiDdn?=
 =?us-ascii?Q?HYvVMSqT8tkr+10MvcXtKJTxNtwKNOgdzTUs2L4mXBGmPgXTKjBBWpymVaFH?=
 =?us-ascii?Q?qiHYzLwIA3JWjWW6whzq4zubAWkdL8CuBsUtZuTw0SW8DSKdtxIvGyDsC27V?=
 =?us-ascii?Q?9vU/BR2j2QA2klu/zKgJOeZ3wpBRtQyvFIYpPOYRjYhPGtVtCTNMYrTsBwcE?=
 =?us-ascii?Q?qhObbvkgQlYzwiEcInCTtTsOVYpm9ARqN5O7ceWDIjyjAkZ/9F5F3nbBNKIc?=
 =?us-ascii?Q?rErq7Zc+oe9d2nFGNhHUbQIIQaCYSCPWnOfkFw3EUy3watS4LQADUeMNWsOG?=
 =?us-ascii?Q?xrnuidP9IzUDBf80s9UlCdUWEVeA9Dauq0Wcnl+mi1UuLVP28s/oUD0dmDaa?=
 =?us-ascii?Q?yTKT89TF2rdJ39A0hVas+4iBGYNYYMbYcCG3qJGXq5WhIfrllcmZgCIY0ce1?=
 =?us-ascii?Q?1H5VlvrBl+/Sh2hlqwBZAFQZtsUF8oy+KhRyJtmZRJU0BGcb11ATrt72HnIh?=
 =?us-ascii?Q?u0dZBVcWsl26zSFVno2cLUZVkIjHa7JLQoqkaRrs+J7GQOEXDBehQ9j9d5PA?=
 =?us-ascii?Q?LlUAJpVpjeXfQRa7YscE26HN8QxVAoQuL2u/PpT4EG2gxjIyWQga9Zgnza1X?=
 =?us-ascii?Q?gPNXiH38bjBccJ4jBAljEsdWx/b3SVcCsh68rL1bTEItjOAu7EPs06IXB7UZ?=
 =?us-ascii?Q?G6+YVJbnhQux2mFfnZ2KQMxbEyijEU/y1OzGXp81FJH1nQDvP1P9NqfmunQB?=
 =?us-ascii?Q?wd2cxgwoHS7JkixxEsT7j3/rF3TdezOwROTMyyvdv/3BulTxAvEZ1iuUkMYP?=
 =?us-ascii?Q?SUhC20pjBpOoftU1ED1HGhoB+Gl8GP96+vkj6fh1XLXlIVGNnRfVANCZn2+r?=
 =?us-ascii?Q?4q2WHQxaF+0sADgjv0TT7eT6vkBbjCtFzHy5UHh+ARo9eZfjPHRwwLVjxgoK?=
 =?us-ascii?Q?41RPNSByIdvjYncj1EKCdzCOMtOImfGxMwNq2qabZzF1xlu+yL2mzmeYqrWE?=
 =?us-ascii?Q?E5dHylxsL3hYSKuQbeWEyQ2jpljpIPLjLtRYrP00VdYrM9ICd2K0ogpmXcT7?=
 =?us-ascii?Q?PN20PmRkX/pLWeN3+bSEqmALuA5UvzUIccyY7P1brpc1YiltdlQBrly2OZx+?=
 =?us-ascii?Q?XV6crATbdMzdga5BBfSPebDc3sfoqfSczSbMFTInjb3hTbZdgCG/ToLra/0c?=
 =?us-ascii?Q?dS7VnkdbBaOH2OIetW+UU8MKF4hB6EOjTAi5wkfE8dEa/xUPiKJftOjSH4zw?=
 =?us-ascii?Q?cfUY/cFgR8ive3gwMArwy1s0GQbiSm4bCYWTR/RHKSmQnbnkTzNEJUF/kwCZ?=
 =?us-ascii?Q?VURlloDEGHRyJ06wd23te3z+GB+YxchIIUheIhhqpDAPl8uYBBQG6OhBzYnF?=
 =?us-ascii?Q?Gw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b75eee-719f-4e3e-d328-08ddd341e97e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 10:30:20.2915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6X0By5FzXThPfqRJil42bVoiNFuy5ntANQx0sXUm7KlzM9ss2UXISlOQf1sWNyHpXDr1UtF/xh9EqUhZlrI7v/gU2Nox/7+ltjTzVsku/uE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7423

This replaces devm_request_irq() with devm_request_threaded_irq().

On iMX93 11x11 EVK platform, the BT chip's BT_WAKE_OUT pin is connected
to an I2C GPIO expander instead of directly been connected to iMX GPIO.

When I2C GPIO expander's (PCAL6524) host driver receives an interrupt on
it's INTR line, the driver's interrupt handler needs to query the
interrupt source with PCAL6524 first, and then call the actual interrupt
handler, in this case the IRQ handler in BTNXPUART.

In order to handle interrupts when such I2C GPIO expanders are between
the host and interrupt source, devm_request_threaded_irq() is needed.

This commit also removes the IRQF_TRIGGER_FALLING flag, to allow setting
the IRQ trigger type from the device tree setting instead of hardcoding
in the driver.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v2: Add reason for removing IRQF_TRIGGER_FALLING in commit message.
    (Sherry Sun)
---
 drivers/bluetooth/btnxpuart.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 73a4a325c867..76e7f857fb7d 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -543,10 +543,10 @@ static int ps_setup(struct hci_dev *hdev)
 	}
 
 	if (psdata->wakeup_source) {
-		ret = devm_request_irq(&serdev->dev, psdata->irq_handler,
-					ps_host_wakeup_irq_handler,
-					IRQF_ONESHOT | IRQF_TRIGGER_FALLING,
-					dev_name(&serdev->dev), nxpdev);
+		ret = devm_request_threaded_irq(&serdev->dev, psdata->irq_handler,
+						NULL, ps_host_wakeup_irq_handler,
+						IRQF_ONESHOT,
+						dev_name(&serdev->dev), nxpdev);
 		if (ret)
 			bt_dev_info(hdev, "error setting wakeup IRQ handler, ignoring\n");
 		disable_irq(psdata->irq_handler);
-- 
2.34.1

