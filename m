Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010011.outbound.protection.outlook.com [52.101.84.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF30B3A6B82;
	Fri, 20 Mar 2026 12:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774008616; cv=fail; b=R8ANnJFjmddx2rLfNGm95AaM80W88ZibzakucH+tsQ1TCTPunuaKSsw7XbTt9K7CU9V77tb27g7RRYacrfHRJ+whNSYgPfBpX2sSZmXXW6INkpOUNqRnkNOwS8jiJuv2SUCIJp/Fdq8sSW5nLR27khls2u0zQVgrryxtG+3JVEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774008616; c=relaxed/simple;
	bh=Du8GrSmm375furHTNDSuhIH9gZ3yLzGXgSogOGMWsVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=MA7AyaXGE44UkltDJhB9hFmKYLxkY3J06GDHkHOpfv3EnEQ1Wwv7FZsAyFUgq3fyvTFMclzje1sHA17s63NbCWrl3aZzGVMlU0O4eurRFUPuPLMEBFp9iiSDZ0R5S2BwxCiSfa6gzCLx8mz0u5+XwWCzlarGmfNPdkAXSYeYrSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=FD+EPX5h; arc=fail smtp.client-ip=52.101.84.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="FD+EPX5h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oa/QZEMpsICcoAuv61jtEB7QEUSWSMIAW0J8wM0Bdvs6U/NUpnHQlgQUJrqyG29fmpWwzlEvY11fK7JJAAmUfqPc4HaldjmD7WloFA8Y/sJMAThPyXHKN3bMISmc2998Ly0L40YmBDXAfYWqIDSMaW3xDq9SIdrfQR0Wt3QR3+3jozwTmtJfVG9z3Yaps8s2QG73Eniuig4h4beJW9bsrfF2ecNF/HNj+Vy0OUwop3opXQRgZndRAhYMe7WB8pFumuHqN2daT4e/217YJKDME0ovJenAXSYkJCBEQ6Ip4SzOEPLe7m4ikGZ2Swhp2Lryp2X4hJeWO1g1Ji04bBRawQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHG2Dw9zfdKlKKtGa+T3rZz0R5bmm43aUsj49RYodGI=;
 b=SMVo43DFwMk1dO2alN7sJLvfWrmGOqfbAnGVH04s4EW2dcRBNQrqLvR4nP8+6GMD8+EHI8lreo+5YqX8wi4H/8oF/WD1EEMGksvTGowLqngbKxOmKNdZvEbZKFFXZabrnovB/Dini3RKQVE4e9DqTSMMiBem8KgV6Ern73dFG11i1LFCYPycrf7vS8CSpBcTobud/5P6nR4st6dSJSj5LdMUwP07ddmePIgZXN3sOfygMmTR2OMd2Kp/d14uAIaeSfhUIPGM90l4fAYkNzxCxD2v9diErL2trbQvEpI2SeG/yvGUkoc4sJCGapJzg2Fr1P9d3523XxR56U1Z3TQ4Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=gmail.com smtp.mailfrom=axis.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHG2Dw9zfdKlKKtGa+T3rZz0R5bmm43aUsj49RYodGI=;
 b=FD+EPX5hiw8IWYDy/1JBusOJOjvCPo+hF1ezKNX+AgX7Jmp0nFIHJaBY8j36ZAiYVhoqiv/Df8wq5P4CwhgwY9gBcBYzEPvh+ZxGfXebokNGpjHuayXpd4wVvYusj+6tEkfnOrfYCW2kaHGPukogjRzyhekIk0e3Vme5A5Itrb0=
Received: from AS4P195CA0048.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:65a::23)
 by MRWPR02MB12064.eurprd02.prod.outlook.com (2603:10a6:501:84::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20; Fri, 20 Mar
 2026 12:10:12 +0000
Received: from AM1PEPF000252DD.eurprd07.prod.outlook.com
 (2603:10a6:20b:65a:cafe::4d) by AS4P195CA0048.outlook.office365.com
 (2603:10a6:20b:65a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Fri,
 20 Mar 2026 12:10:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM1PEPF000252DD.mail.protection.outlook.com (10.167.16.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 12:10:11 +0000
Received: from se-mail10w.axis.com (10.20.40.10) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Fri, 20 Mar
 2026 13:10:10 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 20 Mar 2026 13:10:10 +0100
Received: from pc56869-2347.se.axis.com (pc56869-2347.se.axis.com [10.94.2.37])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id B93BF2F00;
	Fri, 20 Mar 2026 13:10:10 +0100 (CET)
Received: by pc56869-2347.se.axis.com (Postfix, from userid 18630)
	id B3845602F822; Fri, 20 Mar 2026 13:10:10 +0100 (CET)
From: Jonathan Rissanen <jonathan.rissanen@axis.com>
Date: Fri, 20 Mar 2026 13:09:49 +0100
Subject: [PATCH] Bluetooth: hci_h4: Fix race during initialization
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260320-hci-init-fix-v1-1-e1960a41baf2@axis.com>
X-B4-Tracking: v=1; b=H4sIAAw5vWkC/x2MSQqAMAwAv1JyNpC27l8RD0Wj5lKlFRHEvxs8z
 sDMA5mTcIbePJD4kix7VLCFgWkLcWWUWRkcuZo8edwmQYly4iI3dnXVWNcGslSCJkdi1f9uGN/
 3A92w18teAAAA
X-Change-ID: 20260303-hci-init-fix-9657128a0104
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel@axis.com>, Jonathan Rissanen <jonathan.rissanen@axis.com>
X-Mailer: b4 0.14.3
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DD:EE_|MRWPR02MB12064:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cfa04ad-b192-476a-4e8a-08de8679a310
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EFcYDxCiljhf5zxxiz4DBqJSGbV7S+7pOQIxNKnHnvtci8h+GZ2rmfWnT7783E5T5vOmSrY17QECa6HtDP589mX7vZet/ICmLdyIOUjdFA6UsaeeQgKKCyqqtuqWTCPEyjdR3xFHFdACrfK6gqVSSCvrr5iT/xw88ICMK4zeLI9QxAYGprtdVzEe+Xjofx5DzCHkXyRNQVkvYleMIfZ4RYzEayGJtMqm4OwIytBMT+e199dYunNzhw9HG1hxysAOqcAh+zaBY0HPQ0R27W05PTaGYP3ISKts0tWqOcqe4/EN/6ULVeebi2NdlidfGpQ6Sw+RJf94ehRshao7NHYG8bhwK+8kQJOXozD3px2tCr3gdtqO1Pebiv5guyT10N4A0XkmlHAuiZTeAOmuwMTY4Gf/znHXH1ZeaODSTgFUmZehcsvPkjQWLMVElovIbsI6PvetSjvVA3LiwbLM8Sdn1Rtk7KsKYezi9UOZatISOqRiUj50KMptT8MF0Cx7ckU7Yk1smcR5rVhs/P0nSv2qXoGfxNbsJuW8hKZVeRrOxb72sVrvYZvzkyCbmqcVP+sL7B+nbY4JvmlNsfIyBHzJZPw8c5WX18dN3Bv2saERKyPztz5pxhrhsqOS+fBnom5L9o8vjih49djRCXILrDi8CpMq8Wk7Af968F+Y75NTUUm1ItwL2bYoOaOPq5Mkc8yXF2qxPSVb1tIlgWe6NptQsk1YYfC62edSGnCmjXYYxPPS8aDqltgLGTRPHIZFSu1jI2o1deCwyoazG9J/rIUAbg==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2qREJVCR4dJsGMvbix+k5cyNGiZ33rVm3O7CaBx7V9HEmV5jROnMhRgsAoZK4ZoQszioWuI7Fmz2HJNbyX9ZZ4ayqG33iYsIg6im2ExSbH2Nn5GwG11Sv+NrGyI+Zu0nIvZxM4liRjvtv5YJEHJJFQ33itfpKfGiWMcfIXMvwqqWIvyi2z1x2jdl/blPINZiais4MDGsus9J1F3QinhXaXjqkqQZZhIxlWCETNvLBBZBlAYp+sNW/gp5gdoX2Yb8p7krCYx9laFF8cVbhQ3qLHyim5JBoUtlQDG65zqVCPJ4LVC0Sc4EwibZu5OXwjdk/VUJf74miajWMHQWK7TmyR4T1LyTB0ebrxSvUOUMcFo1rKqZiJC9I20n1wMQOtV3VoFJVW+doYUEUiZ1blpxvP4Gv3G8WJ3Z8tTrORTu4FmB+0Fk1BJPJqladj/b0eXe
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 12:10:11.7733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cfa04ad-b192-476a-4e8a-08de8679a310
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DD.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR02MB12064

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

---
base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
change-id: 20260303-hci-init-fix-9657128a0104

Best regards,
-- 
Jonathan Rissanen <jonathan.rissanen@axis.com>

