Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010053.outbound.protection.outlook.com [52.101.69.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2628387357;
	Thu, 26 Mar 2026 09:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774519170; cv=fail; b=bIbwybAx1VVJQipgdq+uZ2ctGy14XIPVnLVPCeRo3IbpA60Pfh+KuJ07rn+X4ZKksa+Wrw4irzbdfYCirtEOZfzrfeNvoP3lF8DwQIjl7XUsHM0bwaKk3lHBgFpZA682rM7L6P5we86dij3QX6xxwlz5FcbqdRa6PekZwfefBD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774519170; c=relaxed/simple;
	bh=aOjShqR+dhTKowbBEQCni7qrAypUUHojiYO97zPuAK4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=m0PAgXSNQhGc8dUe7cFzSk1WqBvHseT4LnElq/zTcNEyctOV3iFANY7VyCLtQ97YtF2VVezotEzeBqiGLQD1B3VV4Un/HSngro/0/TUhBnjpUmkx9y/5PS5JDyzo+CIqk1QSAqLIn96UT5+KnMFz+Azu5DNR8WVvTMM+zHHY5Oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=CNXUsdx4; arc=fail smtp.client-ip=52.101.69.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="CNXUsdx4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2hW88hTDuG3JOA7dSEZFd4QEOkiNMFz1ZOj8Bqn1swp9FjYgvaey70QyFMdhnotEV6DaVIkmrTLSH9+ErYm/sdNFwJWpW8Xn88hXLSV+Nih/ZJ5/E21wUkAE2cY4efxNzjTg4THOeU3Vd4YS1g8Uw4wIEtqBT5hS6GTzWqXcbXgoyBIxWMkS57gNvwLhGH9K9/ORbJu+cAfO8ZOWi7LEVdGyDjsHlh3JQWcSg9HBtGSIC5/hcM6CSatEE2+mR25beeqs/NN6JGxJ0bTMN1B+FPio9fBUbnZMMfGB4u9okoDq3/+lMs0OgZziACpVfAbhfUv/WMZ27FrfpQOqtmOng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HV33FTFSDx2C2jfk3VfjB2dSC0HMWNouUAjuRNgTK/A=;
 b=qZKAttHSuVCtVkUHerGDCAcDN+kQg1NNWs4bZJ8h4BgM9zbGjd4iXx4por4STYJaG7IrgVPdumUo6CQJjkcgcrRbnTWKZ1HSrxK+OHobz4WUYbdMi+ymcgmoOMreCUjDWMxUE50nG0dmSNdGc8dbpUtQK55AiXuHh7u/ykYjskUEtmVPzjuyfpwY1k+BcuPC6Rv/HtZrsh7k+/o7phXmVmlgK6VyMt9USTkRbYu1wWijQQpj/5jyQTttVoA24N+uameKYYswtAKv3ITGixjNSpMDYfhar2bWBLO7Rpg4x5M8Bic6BB9B/7m3JgHVr/SZF/VZZcMz3loaJjU2Ba2jPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=gmail.com smtp.mailfrom=axis.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HV33FTFSDx2C2jfk3VfjB2dSC0HMWNouUAjuRNgTK/A=;
 b=CNXUsdx4AvPK9Iq2NMhuLC9/4vIt2okaJPk2rIpdyhy+9QVEvA2HNRh1iNGLSLpWXuchoD2LgM9Kkkg6cqnKQGEz6BSHUljIiG6RbUzUG5XY7uLWqTxYJW8WScauBq5mm266RyRvGLysO/YunsndPxM+ExZzfnGhsuPb0UpQz6M=
Received: from DU7PR01CA0035.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::16) by GVXPR02MB11602.eurprd02.prod.outlook.com
 (2603:10a6:150:326::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Thu, 26 Mar
 2026 09:59:22 +0000
Received: from DU6PEPF0000952A.eurprd02.prod.outlook.com
 (2603:10a6:10:50e:cafe::bc) by DU7PR01CA0035.outlook.office365.com
 (2603:10a6:10:50e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Thu,
 26 Mar 2026 09:59:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF0000952A.mail.protection.outlook.com (10.167.8.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 09:59:22 +0000
Received: from se-mail11w.axis.com (10.20.40.11) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Thu, 26 Mar
 2026 10:59:21 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 26 Mar 2026 10:59:21 +0100
Received: from pc56869-2347.se.axis.com (pc56869-2347.se.axis.com [10.94.2.37])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 8236D480E;
	Thu, 26 Mar 2026 10:59:21 +0100 (CET)
Received: by pc56869-2347.se.axis.com (Postfix, from userid 18630)
	id 8CF7D602BC93; Thu, 26 Mar 2026 10:59:21 +0100 (CET)
From: Jonathan Rissanen <jonathan.rissanen@axis.com>
Date: Thu, 26 Mar 2026 10:59:09 +0100
Subject: [PATCH v2 2/2] Bluetooth: hci_h4: Fix race during initialization
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260326-hci-init-fix-v2-2-a974211d0224@axis.com>
References: <20260326-hci-init-fix-v2-0-a974211d0224@axis.com>
In-Reply-To: <20260326-hci-init-fix-v2-0-a974211d0224@axis.com>
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Jonathan Rissanen <jonathan.rissanen@axis.com>, <kernel@axis.com>
X-Mailer: b4 0.14.3
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000952A:EE_|GVXPR02MB11602:EE_
X-MS-Office365-Filtering-Correlation-Id: 06ade78f-6efe-48ab-3ab2-08de8b1e5ae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	aZffABHRAqtJAbV/y6IZ6/VGAYOgt+YwTR919uuNXyztsWQJ+ttoJHA4sUEbpGdX4feb6srADGIxWmbbNS0nn42hv83WaKVz529LlMLzr35Bp3KWKgWxxAePs/STCt1UnZDNrkSp+i4glCW6XiJFe5OwWS5+1Ep6M5LcVx+gLPcR/pTmClY4xkSudEmGxi7SkXRJh+hmfbNnUfTFnNlKFt6n4LuaRUnHBHO6mTZEiyQ74GqEruqiSr60BrTQ5Fzi59YNgHHdlcnaAs2Rqg7yJyCUmBVJskvmGYrCKC2IA+2W9ayAuww+3E/utDYzd3nFJg5F4HYRc+kHuBNUinhrxpxZ7/eWYy3IA8PxPlJ4iAByCbcAQDLG6Ysn0Y2iJvn6c7t2XKEOg0t/tQVb8R0F58CAZ5nbtvUfAmEVn8xkPVG66Ca9CrH03kySB4ImkGjubOyLCd7YwbU1gmkC3gNJwN/KjCoVckbPsHwQY7QLF4nQ+hGakdrwmKdePRawG4boakgVNZjQLiITDJtebA7Ccw/A/BftOBGNODyuY51ThCt2bHGFxhZJR0oRufqCNMmWasuc6biJsdNPEgNt0GrlDAeCB+Jzyb9UWWW/GuNWTz35nJvmYUxHPAxHdYZ4mXsORkXFYDnJVlDuvW/WtErIuFpz+ioeWL95/Iho6BQmCR3rqY78SnermML4FY6fq3bGfABk5svNpUV2VieQHrgnRPoRK9t4hmnEpoONOCjx53O1n2z0HtTcf+WneAvYAATTm11T0nlqEacnTEOvrC6S1w==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Rt3rT9+Hb8xZT0g20TEvemHm140yGJZ/OFY1raZhj1PUJuETZOTwrUtD3Lj0fAFS75KptkCebHjynBVLjidFgnFe9W8B3s4eUH5Re5qu2xPi/6BhGcAlO9lqcGWAJTciuMzYA/0raEvVLy1VJFu6ELxRTidAAQPvR1Yg3SdavLMzR5wCjKEYSeTd/yus2Fuo3gOs54PzekQpjFHG8pELWoxbVX26LpUuXk044P8Mj9Ou1ftztCEANnFl48efNB50h616Hq9wnjLp4uCcc4f3mNHYLgdXW2XFewnqLeNiu9Ju8+2k/btDmpyg0G3wnBcymw5UBagfxJYYkBTlWVbS3TkLJglWTB3xM5CRuzlAqji0uBszGAAbt8B66qV/A2VwyvNjkAPlFxXqlnMf+iYDmxcMo/wWKn5y0fPZR6yVMV7YWsyBtRI1jED3j26ubMlV
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 09:59:22.2679
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ade78f-6efe-48ab-3ab2-08de8b1e5ae1
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000952A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR02MB11602

Commit 5df5dafc171b ("Bluetooth: hci_uart: Fix another race during
initialization") fixed a race for hci commands sent during initialization.
However, there is still a race that happens if an hci event from one of
these commands is received before HCI_UART_REGISTERED has been set at
the end of hci_uart_register_dev(). The event will be ignored which
causes the command to fail with a timeout in the log:

"Bluetooth: hci0: command 0x1003 tx timeout"

This is because the hci event receive path (hci_uart_tty_receive ->
h4_recv) requires HCI_UART_REGISTERED to be set in h4_recv(), while the
hci command transmit path (hci_uart_send_frame -> h4_enqueue) only
requires HCI_UART_PROTO_INIT to be set in hci_uart_send_frame().

The check for HCI_UART_REGISTERED was originally added in commit
c2578202919a ("Bluetooth: Fix H4 crash from incoming UART packets")
to fix a crash caused by hu->hdev being null dereferenced. That can no
longer happen: once HCI_UART_PROTO_INIT is set in hci_uart_register_dev()
all pointers (hu, hu->priv and hu->hdev) are valid, and
hci_uart_tty_receive() already calls h4_recv() on HCI_UART_PROTO_INIT
or HCI_UART_PROTO_READY.

Remove the check for HCI_UART_REGISTERED in h4_recv() to fix the race
condition.

Signed-off-by: Jonathan Rissanen <jonathan.rissanen@axis.com>
---
 drivers/bluetooth/hci_h4.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index ec017df8572c..1e9e2cad9ddf 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -109,9 +109,6 @@ static int h4_recv(struct hci_uart *hu, const void *data, int count)
 {
 	struct h4_struct *h4 = hu->priv;
 
-	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
-		return -EUNATCH;
-
 	h4->rx_skb = h4_recv_buf(hu, h4->rx_skb, data, count,
 				 h4_recv_pkts, ARRAY_SIZE(h4_recv_pkts));
 	if (IS_ERR(h4->rx_skb)) {

-- 
2.39.5

