Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012016.outbound.protection.outlook.com [52.101.66.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781162367B1;
	Mon,  4 Aug 2025 08:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754297802; cv=fail; b=n2/qwJAHZGhyjO9p0lYaUyGNvWI5d9bMkjy+kB9CCP8HJnNC361yJaJSiWZIBaREjUC/W6TKkuJdi5D/Hu5q6P4236CWS4OrZFlA4zAolbiQn608zIXCf0aTz7P303W+MOQMY507NohQ640nEj7XAgYZHZmoZcTG+K8RenYj+ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754297802; c=relaxed/simple;
	bh=1McPWgaWpakVcQsfK2jYxfK+reaT4f6RlDOsAlbP+uE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=AGKGRT5zC4bUtbiXqSFWk5Bhw5gA/+/7gKzF4ZS4hBojf7LaAHhBMGwYoJm8iHWq3yPZ5+Fqa3KGgRbTgWWKhM90qLyG6ohfedFUNuroPcnvkLkhXpgAICGVUJizOdKOymMoqJlG5dhJsiJkN7LnXtdX3XJOOyZaCI468L7OxL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SU3t6WP+; arc=fail smtp.client-ip=52.101.66.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SU3t6WP+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KoJ0Qp/wRHi7dBFw+LVmPHGiZiKf3ag4xMLMdGf48vs6+Yxbpzm3qUOaDMnQnfDoLzSNO22JRD0CA7sBJjgsoqBUy/onbY+pT03IWBBJy/q1VVPqKVLrBmFjlaz1wHZ31zFYEuAHJGXPw9PR1BdErqf3Df/l4g4lNqrZkLIAseDV+Y6qIMvMPzOYgjBeVkH/gKT+uR6Uy6w9H6tOi+k/dfwvq8x3VoJVytzdwHoUp6qdl11RezCmFEinr9mLWM/NordUTd6z8JhguXP73KlrYzSyx0XsUFwkLoFbW/iiW5p1pSFjHgblU1Nrl46eciUNu02ukgQoRftMZ1DT2TOjJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MaTAwZ+Qg+A6GFNDnsks3t/+Sa5cHmrjRMrvRVwgihk=;
 b=CIpvZZbJ8SB9pBGn8sGkOhLQC9Z4HLJxIwkMxuvEUeX9l33P9bHMHLnJfDEuJ49jDkuwNOEx2fM7BQ8gL3MZEomOG/7yfRCb1SWYCLnDdhx0PwknimtU7t8NNukikWdUfweH8JWMyRoRDKIj5LbCQ7WxeZa3XJ/2S2dqPS04up0TbYPm5L85CPXMePfkipSqg69Z3DCEW+QirMjQcnW+Cg9nKVZyrmebQwNoxvHKdkpkHIz1uByUlJTCO0qXvTyoSLNkv31HRPoDJa7IDGApKdJCPCHeS9wsBHmiiILAJV1U0HVg6dTsKU6DcUGue6N23Luoq+7Ssauf1v0vAXQMkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaTAwZ+Qg+A6GFNDnsks3t/+Sa5cHmrjRMrvRVwgihk=;
 b=SU3t6WP+ExrDRVWbISBNfOTPwDBxmyYWvhyw1CJSf1Jh5saKKa61NZPpQcS0mZ1i7rRCVPhrpcb04DAL5cJyKx1hgBfaWLt6aeN61BOmcG83ocgIPGT+GGGS753AMX7wWuJb3LFMWr9DsFcNLgQRdU14LFDa4OSECfWeUqYnkmKCC5VYo6pKx1w1LNE9mGKE8ROuun45ylNmFkmZGZwTe0D6IozmBLc7OJuV+d8IyNdwltHC8i2g84rcQcG/S2EnkR92ijUfbE92PuIp3uJGJP05mfxDcxS/bjGQYuo8f/UGKrvL+BlAWte73Shx83EhWRWeKkbsBUIY6+G/Gif4wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AS5PR04MB9798.eurprd04.prod.outlook.com (2603:10a6:20b:654::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Mon, 4 Aug
 2025 08:56:33 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 08:56:33 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	sherry.sun@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: [PATCH v1] Bluetooth: btnxpuart: Uses threaded IRQ for host wakeup handling
Date: Mon,  4 Aug 2025 14:26:30 +0530
Message-Id: <20250804085630.1082251-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|AS5PR04MB9798:EE_
X-MS-Office365-Filtering-Correlation-Id: 75f945bc-2921-4995-611f-08ddd334cf9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VxpbVgrezma8TP/rlovFOjDSlgZG2ROQTFJidKI9H11hqE0ob9TxnaCeB0YM?=
 =?us-ascii?Q?/plj9GzX49ikoXnx7dJM0NxDthhnyp2ataPxR6NZNV80G1zC0hznAhX4lBnt?=
 =?us-ascii?Q?IuPfG8/XUCJ1GY4PdItgE3iOAA1n/apENY2xu3XfaFDzijP5RDCJkhHRPsum?=
 =?us-ascii?Q?yoF6e5kwn9yqvkCSN4kRuJe0I02xCaAinerYuNYWBC+5cx6HH/IXonjEAcqe?=
 =?us-ascii?Q?/fuZ6LlMRcj08cC0lTrjoMTcUZo5E3QALwrtRYCEbqTLkPOEZ6t0EX6MDBvo?=
 =?us-ascii?Q?CDqfuZsVP7BpHrleRCgxBReoO1H64iE6ayrrBPJLIZyGDxqivOssT58eBnnT?=
 =?us-ascii?Q?RaKZ2vj5VSy3MmGIuqJuydPr4zhH8Abgb/49Thnz/wRBob5pg3XnLR+0oGNy?=
 =?us-ascii?Q?Yokq6hwsmCKVQQixUbKN9+Kub6l/SCVh7B65dkvE+rU38TeaoDpzHFuJprow?=
 =?us-ascii?Q?az8YP5g1eAqaaO1c9kTXHzbqmcsE1PWD0atuuPn2sAqjZU9RXowwYIBjkeHB?=
 =?us-ascii?Q?gnzxrZJdN3Wl/wBVfc6+0UTYByGqIMnH/VzuGLF1q/uDmnXnUSuU6xy/uArM?=
 =?us-ascii?Q?IYd48ww/7zUcOSMTPKu00hypfYpGZrtOpjmCTR6JCC7HJiI3+TsCAckG78ev?=
 =?us-ascii?Q?KZmahFXjdGiwGGwkEDKXFI84X4RWthQozmqjeY4AbgpHhoJygoiaQMkE2Bim?=
 =?us-ascii?Q?n3YW0qV0l05tzCUXGvbaOtb919V8CRfwcjdGK6yMecp/y+VJCKeAP//f1Tli?=
 =?us-ascii?Q?ewcFK/3BxdUDoaLHcmWqehOA2JkT0eMrvC2xS4XW6/0dwFSYs3Z1X5bK4WuA?=
 =?us-ascii?Q?c215CELYza+ieuk7FpmpdJb+AY4oz1TqA+Dxpwqvl4DEz/8jfQXnqVsbs+/h?=
 =?us-ascii?Q?l9qjYDq3gZoftOpvORE/z/p1rjzaMuQRg/4W5GITVZ5y5DG3NbVOf4CYWfAp?=
 =?us-ascii?Q?m3WdNXRJgA0rmM7Nj47Tr4h/+o4JMkkr43ncTmXg9X3APxc8XoJI+N5tlpRA?=
 =?us-ascii?Q?yr2jNMKU/xvAePS3uK61lpwdliCf4tIBjY20ANFaNU+FudGY1rvB+oUdgc2Q?=
 =?us-ascii?Q?8eHyV5gR00Yl0OiGqyB9snhXOkTfSdRQsjoXvOsip5qEHZx3USOOTgpGMH7N?=
 =?us-ascii?Q?5MGYtnF0lQPvW3hQZAx1bnG3Fv3yc/rjskW2CAORrzo3SW7UVlvzTbCIk9V1?=
 =?us-ascii?Q?KGNUoI0AwscUba5KUyXyWoU1cd0Ls0iLjkMNiIklNicJZGfZ5DMZDY8zUNxo?=
 =?us-ascii?Q?jbPyibz0a1uozK4yuFGoESzJwXFXpzRGS4vEIR9j6UUXtpzIjmB1gDbYXUVh?=
 =?us-ascii?Q?QbLwUIZVqJmGEUv0+YQ+nn2uRgAo3fBlqAFhR5kV7jbpmeQH+DP+r5uGh8b7?=
 =?us-ascii?Q?m/Xf9d8MLFYyoyaYvlRtwXAuiQZvoBlUnpn72kI6onRdeURrzzTcHASLUGI/?=
 =?us-ascii?Q?ozaPEFif2GPPRjDuyggQR5Z60AYFZc8yHRm8mpz8mYTQ1JACU790rCsAvopY?=
 =?us-ascii?Q?ooHQvxjkSpv+7tM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FoFhHl+LlDzQBwx+wN4ngCRRZ8W3vzfz17oE6wEoC60T94KUTU9tYKFR6AEv?=
 =?us-ascii?Q?IEp+RyVADI67LC8yYIPr4UF7lqCj+FBw2/q2N34/NCyrixXlXF20bCupRp1n?=
 =?us-ascii?Q?fMKMMG8PO+7R/zd7GDNAEytDdZxdsXKsPNKm0V2kvK/8nib6pmj55CEfWZ33?=
 =?us-ascii?Q?V3vi9Bj4LYWR2ARxYmT8SRYQYc72oIkrx6eEyYQpD09dJpqXu6wzwC6DAjf4?=
 =?us-ascii?Q?TOhS2vN5RnLNlRK6yGA4SAfm47i2H867NFmukL+Z2ZjqXFRGLwJHZ7Uen7/C?=
 =?us-ascii?Q?b6qgIuODKXmdaKpk8i+TlGWzHFAF4GMqxlzng2UtafCBWhq2wVwI7Useft24?=
 =?us-ascii?Q?558yNWIFAqACfLJ+FZhhcgyaL/xptoyIBm/FQmkijJb7WGAIcWzQJVvntaRU?=
 =?us-ascii?Q?Xa7HLqmVTLjxFAxuFQcCi1N4b32wzrlWhcB6pD8q89hfwAU60Wf1fg+byzjq?=
 =?us-ascii?Q?ujerleGyuI6VE6WxF8hxFqufgfjGMMomWzvOhRPmYDc9AS+ywEArudVum/PS?=
 =?us-ascii?Q?fXgzK38kVvEVIpU2rKgkd2FDR8jruzaQLl1cDgWO5NRe08+YKiWaOAOJqdZi?=
 =?us-ascii?Q?7H/DrHhkatebcYiuGWFNTST51UxktpfbQQdYhGwI3FTXSF28QVg1UXzH/aMT?=
 =?us-ascii?Q?60/qE/xjrzW3aHPE/VEZai/a+QhGt4O7oLYwkJtNNQCxvIMZkv0+YNej37Bf?=
 =?us-ascii?Q?WGGfmTbF1R1aP2unAm/YPrMmjiwToInU0futxC1h7Wfaj/XH70zqYJcttHat?=
 =?us-ascii?Q?IWvo2B+INBxlfa/TmdWRkC+OLUxCbjPE45lR2L4d4n2RJ6wrxOkhdTEWJQIK?=
 =?us-ascii?Q?0XfcPuwf8Eo5dilR/jFq57RPPEJZpF2+rBbBU3LrbwS4uvMRbWfr4/RdwDgu?=
 =?us-ascii?Q?LMH9qfDpxJB0ljvROcspwOYqrsa/8NeWCUg4c7hSqRZ0oVsMjaC8+dbZqPp3?=
 =?us-ascii?Q?6Aqk1IorzxwgFkEOPXBarKTCTyhxT1wkGQAZT3ERpQ4N/bKzEQDGBVXWnzeq?=
 =?us-ascii?Q?mU5MRb9FmWsa0bJxHd7dEgxQaPEvUOiTEKecqyRGwu4Cn2yG4Rb8QKRHdOQv?=
 =?us-ascii?Q?qSKkMBSD9RntpvsYHnc3d4anzEVueWm1pbHDnB6cdvNqBXwURa4mLptGl3qO?=
 =?us-ascii?Q?KRVjcg7sbyPuLXzMeyok+NOySDZM6dMlU1nFYvZtihqImeLklYdmEQtO1N2d?=
 =?us-ascii?Q?SjAKTMYBytrywIA2pVg1uYyQejXI5nEeE58eLx2yS324SQaJQV+Z9ZhRhkHq?=
 =?us-ascii?Q?TKQ5Pa7VMv+poSTqK4AwLCs8+CclOycV7rC59Qicg1ysVTPIMBXLBR1sEMWX?=
 =?us-ascii?Q?TAK6cHp8P11Bm5010w7jwB+5ukqeJ86KHEWkRNtlEpGgBsIqyH8xl/LtfrYK?=
 =?us-ascii?Q?DQSsvZWvWeQ0+42nj8T3tRXtLDMs4Y9KwM0ZA9H+lUkMuKnYyDtfbangsCOD?=
 =?us-ascii?Q?mSalXrVfvuKI2M7054yU9yMhVV+rENGxgxPpysdwOIa1NAIyHTsYJEStxlmJ?=
 =?us-ascii?Q?HU/seaVmSKoDZZz5vgT9U4RLd+G6T0xJezMLXOLssTUFff+W6dWzu3VWVmZJ?=
 =?us-ascii?Q?FmDsqQ+FSj4aSOdtaP7mKd9SBfFK2kNEkRKOXEoP1SEgGx9/TuAdUxE8GaF8?=
 =?us-ascii?Q?Hw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f945bc-2921-4995-611f-08ddd334cf9d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 08:56:33.4336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8eajeT+vnFfLJbrTYoWbRABfc1nDz6KBEgsQFUHRXkjjvNqOZ60ksYpwegBf8oG/ucO5JK3HzoerPriz/IEvNhbZ8ti9j9x8NCXzjgG8rA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9798

This replaces devm_request_irq() with devm_request_threaded_irq().

On iMX93 11x11 EVK platform, the BT chip's BT_WAKE_OUT pin is connected
to an I2C GPIO expander instead of directly been connected to iMX GPIO.

When I2C GPIO expander's (PCAL6524) host driver receives an interrupt on
it's INTR line, the driver's interrupt handler needs to query the
interrupt source with PCAL6524 first, and then call the actual interrupt
handler, in this case the IRQ handler in BTNXPUART.

In order to handle interrupts when such I2C GPIO expanders are between
the host and interrupt source, devm_request_threaded_irq() is needed.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
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

