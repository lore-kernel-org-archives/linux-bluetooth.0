Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010018.outbound.protection.outlook.com [52.101.69.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C030342514;
	Fri, 27 Mar 2026 10:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774608465; cv=fail; b=qYNrHkjBEF8gRorWzMaTLoVYizH1sOo6TQI29t0M7pv+WNT4KnVrX1w3nTFbDhrtszxcQn4pnNa0H93HxSCZGyerrVUgjlTCx19Aw5SG/VMHvdW/6lBsK9UpECY+CRZzRSM7GRzKAX5lOGJeiPZBjTU3dwy4RFXOKNFZOokafHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774608465; c=relaxed/simple;
	bh=zkp0NZbjcqNthis0qEje2Ard7Ttp2SnZ3DdNlBpPHww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=FzCU/456vL5jpZw6Ai5q6KAR8AfqcpQbVfALLOsKL7CA2THkK/iR9tLeJVJmKeMXMcAtCn8ZOFlAdDpxdlLjZZMUvwWsDaNO2EyqrOdZr5XZASNBFD16r22FSIKgl9eBZ5R9oR8jTn5PWA+nS9HoJ2kixQcvjDtMFtEWK5lM/uQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=HOzCYH+z; arc=fail smtp.client-ip=52.101.69.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="HOzCYH+z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FgfAlLJE8T1PoH2o0BdNUqHUN++a7jQoumipb/FtZQw4KgZcbaXbxxB7uvYbsu5XXYlnWcqwEf0q0G+6REIo++D/amTOot8i2Jt9lC3thJxzktNlqTSI0qcwiFqMTID+itLfYyu29aQ0nIiv1uI4LIgNH3TTO0VkJJ5R0LNP+Y7+nUpHnOJcbujY/Nx2FjVlrcA/VnKGlsTNmjh7csp8V86HVBPgyl58j5GTGOp2y4oFWZ1s1ZX3GQOt6pNzY2BoQexZ8cGVyhNK+NF9soYR2GWXgKXLoJ3ReYbu7BwXn/IiZy3PQYwsCbVh3VDocrth6mMp3dqA0iLe+TJ1/7+t2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OtcpnrONRdHbg//S68FfzhzUWtWVTCGD1UvXJApCNxk=;
 b=FMYVoaqbh05Tv92NSAuGA0T7aSzmd8QX+k0yrqIgcYOz+yY56yUC42RYCMKXPLf3tqoMb+s2VJ7+Dy/qXGfe0zIJXHXYiUEkpH0vjQ4j2cM7w0/HPYUj8c0daAEnAKXaBrcL1Yellh8zOVTet+iLwFw8436qv4+7emYjNeZ5ottkw4VrIbLWAo0X/NEiXPHu/Gv+Ur0yDbUFFoLIhswMkzFZTMPyzMMfBc4yQH8WLPUg/bWFmTkF72tUl/acfWU8S3cnFZnR2XegU9O2Wikh+M9pjE9sOrXY2rNp5rKDNFoinRzO9aXZbcEYv0nCt2TfghICDKf491SgUxJ9mTEG0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=gmail.com smtp.mailfrom=axis.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtcpnrONRdHbg//S68FfzhzUWtWVTCGD1UvXJApCNxk=;
 b=HOzCYH+z0pHXWt7VMGNvFttkcgDXxoxZYj3IIWz6Q1y8SRm0w3+WlkjZogI4ixiuBFI5HE9dn85UmG9F4wDk3gV7iF4UPDXoH5PwKiEPbPkbo4S3qraoJ4IDrEN+Y93xGxSWqAMjvQHDbclm4A1No4zmubXV7mMWmaz4T87FtZY=
Received: from DU2PR04CA0010.eurprd04.prod.outlook.com (2603:10a6:10:3b::15)
 by PAXPR02MB7813.eurprd02.prod.outlook.com (2603:10a6:102:225::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 10:47:38 +0000
Received: from DB1PEPF000509F9.eurprd02.prod.outlook.com
 (2603:10a6:10:3b:cafe::58) by DU2PR04CA0010.outlook.office365.com
 (2603:10a6:10:3b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Fri,
 27 Mar 2026 10:47:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509F9.mail.protection.outlook.com (10.167.242.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 10:47:37 +0000
Received: from se-mail11w.axis.com (10.20.40.11) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Fri, 27 Mar
 2026 11:47:34 +0100
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 27 Mar 2026 11:47:34 +0100
Received: from pc56869-2347.se.axis.com (pc56869-2347.se.axis.com [10.94.2.37])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id E23F08EE;
	Fri, 27 Mar 2026 11:47:34 +0100 (CET)
Received: by pc56869-2347.se.axis.com (Postfix, from userid 18630)
	id DF63B6022493; Fri, 27 Mar 2026 11:47:34 +0100 (CET)
From: Jonathan Rissanen <jonathan.rissanen@axis.com>
Date: Fri, 27 Mar 2026 11:47:21 +0100
Subject: [PATCH v3 2/2] Bluetooth: hci_h4: Fix race during initialization
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260327-hci-init-fix-v3-2-1b54bad4ef0f@axis.com>
References: <20260327-hci-init-fix-v3-0-1b54bad4ef0f@axis.com>
In-Reply-To: <20260327-hci-init-fix-v3-0-1b54bad4ef0f@axis.com>
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Jonathan Rissanen <jonathan.rissanen@axis.com>, <kernel@axis.com>
X-Mailer: b4 0.14.3
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F9:EE_|PAXPR02MB7813:EE_
X-MS-Office365-Filtering-Correlation-Id: 41242f26-b36f-4e8c-050e-08de8bee433b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	FcTAQIkNMTtdvk62GkNIHcGq79oylVPMWo432coQ5Tknufx00k1DZ7Cj0NMZToyvJd26xUFr5ixKgB8G3nLOOL4c0niCWoPxwxcjVXc4kDMjFdrjH8BwnJJ6CNIk9VEvWguHY0x0FCyOk0GSfM1jpwTx2h4zm6c2pyrnhj7E8Sk7JqHPDbLwInV4tkDRQ/wTLsZeq+QVC1fSw0ErTEHFAHx4IaxofEqBpcUpieb4bGma8BYA5X9yetNEb+gTqtO1Sz+41w6TCfjAbkHanJcv7Zms1LnFW8YaPZHi2h3OKAxte9lDzX0p9V4LBKtQxtb/YhN6dOPCR40+q9kbRchzo0E/VWez7FgDrFGHFDxj+hYGabdHKPKTcItrkPWd9JClt7Wjb8spOAhePoSpbSJoyV0NdTjJgm2+3A+LvpQPQlgkBGqfxD0Ng+z7xceK/MzDf8nWZ20PbJgLzKP1hdxyFTVs7WKTlPABAoeTdOjuE1oHeXhDUEGjrBcRzkItqDiHDkSiMlW7r3Mq5R4naVriFhQtOUk7joG/2Lr/gMm4CWrxJTlp7pfrULcV6oJ89m7XUwA/t5BfVjeUcY77yTz0nDLOunFKnHTgviDEfwntsHsrA9xzGD02wo10V97uMrBE5P8L4eZHzKVbmFMzOXx5wGbTBRX7Ep9OfcG8w5qEXHe1thb86ZG46VcJznFfz43Ig6S1vSuEy0IAMAJApXuaD2M/VTM7x4A3zcHzLiTBrpClkJw0VXmc984AScYe6KnWL9GBFS/ckN4NJEXk+33Arw==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dD6udnA7Csj1u7dyFWluGn5sPiP5UyVpMfNHuP2CWESYKsrHW0ClD3rlY6QYgfML9XGxNZM09LgVwe96P9GvoD2w5csi8FGH0Kh9/Y2iaubu+vfhbxUvPPotd+3iwIzHLI1Sb91bEI6IO5EtPUMHanYOVS+xZdazUOOYpkpsAd3yxOjmfaBxyMYAbqH+Umcjdv667Yb/0QJgWGubdPzIceZzsz9pcx5YTnNM0J4mnkUQ0gB2tgni77P0YG4ufDHHOt8ddMqm6FeJMYLztp7Wf4N8uVawgfhHFifZMHGYsIPADWdJheuqpOnSkYYtUPx0P6/hP5LwJegv+/u+GAOI3h4+hiEQqI9nTnMiqG0CQTvfiIY+eLDC7+zgGJVE4306SgLAq0Jmwg60KTVLg2g7s+iBunMZVntQePn6CNSMrTgKUrEuqWFusQAFS5Yth91w
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 10:47:37.8979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41242f26-b36f-4e8c-050e-08de8bee433b
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB7813

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

Fixes: 5df5dafc171b ("Bluetooth: hci_uart: Fix another race during initialization")
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

