Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011043.outbound.protection.outlook.com [40.107.130.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D881C392836;
	Thu, 26 Mar 2026 09:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774519169; cv=fail; b=aYGM36NqzUdQdtbBg5mVRLKP15IVZmQxLkkxZQfdBEAypBCY6wzYk4qRhupnQzak5VpfASveRM7uoQSUAa6RM2aAR1KHkTWwZ1N1KzIIxhYtjDHB4vJpDpWTV15QCgaLTcSWWQ67+qJBw5ZumipQaiIpz0HVE0GzuOQwUrlGdfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774519169; c=relaxed/simple;
	bh=8udnt9i+2PL8Qi6oNZ2Ly2mPJn063BgF9y3YW4pNKTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hcH+Ud+L0hqFeSDsZBVerlhLewbmFo8YamwB0aHPZjLoo+AAbxgcjYWj2mpponWztEJ0cl/mpKrua9dB08fLzeIcoKTf+lhPt71Rc0xJM3jysvkbiNAsSiDHtjs6eKPIC/J6YZ3903LLfgkFgI2XKnDUetVA3e84PgG8gQ9RNqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=HkCIG7cf; arc=fail smtp.client-ip=40.107.130.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="HkCIG7cf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6cpPLbGL2VdWaWXJaBbNu+VbtBO3wc34vPJy2EGTrqd9QTN7Jllz57SgcbpjTHJRXo7S2maTmDyQD4jpFF7DWnIgRSpsTK9+6w6i3JHm1GRhd7DFkQjZa3EciVXbqgkbgrQm5Fh8qW1hhhGVu5DnH1G/XGwKlP9b3kAEWo1WNOA9VcnqMNjq2JqKIIB5ZP8P/6AeKYROmdo8Ii8VXMm97Zyy428CCWyhWNlIxx+IAhL9MceNb1YWUkIrIs2KJf+ylu5f8BM32drWTnhdqOKvYOZe913MfGpRm98rl/0vTxeOGYHgrYIbzrmEZoo2JQrIHHU+mYSPtoyg6OV42qOPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdLMNF3FE+CrexfOlE0XwAXSCiBVIdR+l3Nlx3kWgDo=;
 b=uyVKSFLOVcKSoMKH1E3rQClf4ngax4FewGZ32DrU9eYbAhKuME0a2p/xcou6IRSlnezFGcqkbyb4yAK/MXV2+wC3migsScmNXwn/MmdbHHHb7ry65SQwTleu8b3AkbO+U3LlQYTISaRnOYBUWa7lGH8qLeIeLVtm3g3T9r6qfigsqdqF3Cb12II6AC+5SI1kYtkj22CmZw/gfMOJGjz/3Sc8zkZ04SmMQLpDdTLFPv9fvCciyv65//rFznZNYqwL+EGdtCNhlnix28X9Aeu0SuEp6qUFk13SN5PsuYri2ompfuoApCadSrX9UNTWBAPwrVWRexF6UgjLrBuRC1sjIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=gmail.com smtp.mailfrom=axis.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdLMNF3FE+CrexfOlE0XwAXSCiBVIdR+l3Nlx3kWgDo=;
 b=HkCIG7cfTIlalFLki1d8/90mhkGY3bSZqoVST2yYJkcwsgc8wMD6FIZseSKzzwEKZrcu92qUydIlcqzPjq8dlsW0nrNqzrKdwts5KvT0eSqppQ7jIfPyymJAqgm7sjm4KGfqb9pw2yO4UBIIEAhn/wzjUKlENPne+FEpqQ1R9HE=
Received: from DU7PR01CA0031.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::10) by AM9PR02MB7092.eurprd02.prod.outlook.com
 (2603:10a6:20b:26e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 09:59:24 +0000
Received: from DU6PEPF0000952A.eurprd02.prod.outlook.com
 (2603:10a6:10:50e:cafe::1b) by DU7PR01CA0031.outlook.office365.com
 (2603:10a6:10:50e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Thu,
 26 Mar 2026 09:59:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF0000952A.mail.protection.outlook.com (10.167.8.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 09:59:24 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Thu, 26 Mar
 2026 10:59:21 +0100
Received: from se-mail11w.axis.com (10.20.40.11) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Thu, 26 Mar
 2026 10:59:21 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 26 Mar 2026 10:59:21 +0100
Received: from pc56869-2347.se.axis.com (pc56869-2347.se.axis.com [10.94.2.37])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 8184347FA;
	Thu, 26 Mar 2026 10:59:21 +0100 (CET)
Received: by pc56869-2347.se.axis.com (Postfix, from userid 18630)
	id 8BB0A602E188; Thu, 26 Mar 2026 10:59:21 +0100 (CET)
From: Jonathan Rissanen <jonathan.rissanen@axis.com>
Date: Thu, 26 Mar 2026 10:59:08 +0100
Subject: [PATCH v2 1/2] Bluetooth: hci_ldisc: Clear HCI_UART_PROTO_INIT on
 error
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260326-hci-init-fix-v2-1-a974211d0224@axis.com>
References: <20260326-hci-init-fix-v2-0-a974211d0224@axis.com>
In-Reply-To: <20260326-hci-init-fix-v2-0-a974211d0224@axis.com>
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Jonathan Rissanen <jonathan.rissanen@axis.com>, <kernel@axis.com>
X-Mailer: b4 0.14.3
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000952A:EE_|AM9PR02MB7092:EE_
X-MS-Office365-Filtering-Correlation-Id: 68d2d05e-db28-40d3-472f-08de8b1e5c09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	l3cE8tdV25hpA68V04XpGYzV3R3HeDCKdFdfU0iKbTjuEDjXSDjTJ2bNhMWFoTnAKkq9NztGD2HbqqPMEY+241B8pXOO4QwFjs2yUwHEp9pfeX4+aTqFj9mTkjtw9f/LiPPV5IL5OtYBaIg+nYpzo816DNLzAka3GfMCrt1BaAmnQyxjGGV06Wo408MDqxSpFHt4X80vl68ePTr9NRqcmm7ZxhafuzLtBO93cJ8f4rkwW6xiPkGfsGJHlngu5XZPXiMvwZCG/GtPkLROg8lARw2cKvfX8/CMcnS81MyP1UkOHM62i0tdq2nmN34Z1EIYn7o7btFMa59/bjon/JIpPCEtKvYFU3zvQoS+0Jbo4bvQHSh2B3QW9QH0vIfDcE2qmg6Smv6H8sn5fvTKZJm39ZsCAcmAAutxtR/BFk4vOlZ/lNunGBtto8Vvudfwf+vge27hxdbNW+j0R7Ad0+hlRk3XhFQB5jn/CmgjtbGrNiOwmHP6sBWQ0Uya4dDM/+ORmLMygiBFjzT65bO1G5GciUyuL6m9gZEK1PZ9z1FoltVgXKXT9M90XSbehY4WoNmEb4XwOEprknvJyqieNNZyFhw2fI/oac7TTmfRNWvxx9CJ/VkJCd+CvVfcSbzq9eH1EVNERvQOSTZqxAWHOCcc2m2llxLuce2b+NeNOHo/WIvOT0keazEub/G1kOCcHEreoFJY4Hfl3hhPAKl07q7DdtD5rg58tDEo1Grimz0yETz49Hgi0pbP0/PjBCtSeCcqjkiSwSVBpcbgQiZABLMw6g==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nZ+yGcdEMqhEM1TpK0sM+xBtKnhOOJ0IGJaJ6Xp6IMh6HyXxsYm8/0Wvqp3hWeMFat/V8dcfGyJa4UvDE37Ukgc79hBBp7EHbRxUWdEIwUM08HzLHjvB22xD7ny5Cd9tQYC8F3NsHE3t2F/btAPvIclHL0fbfpGlOqlTAptkFYWrHJu6MS3mH/D5uwRrbBVpdeneDdVe/OU1VEhwra/wLtV5XhsIBo6bEpWv59TmqvUktWE7wlZ/yQLlicF53dQRST9rgNQOTzbArJU/u/df0IwYT61cBayKaVJ7qJijoNHe7SiHUaagfNgOYobzeuPxSQH24xgLPIzC8gPqm196LwbyD68sk3IF2N9KKxrAyPaz5ls19cOuoZFxAPyoI/JbCoSJb9UQcpvKRqTjPcbF2q3dYoKSvrizFGOBeoJxSop7dht4OjtHJ23JLH1ZaaRP
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 09:59:24.2082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d2d05e-db28-40d3-472f-08de8b1e5c09
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000952A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB7092

When hci_register_dev() fails in hci_uart_register_dev()
HCI_UART_PROTO_INIT is not cleared before calling hu->proto->close(hu)
and setting hu->hdev to NULL. This means incoming UART data will reach
the protocol-specific recv handler in hci_uart_tty_receive() after
resources are freed.

Clear HCI_UART_PROTO_INIT with a write lock before calling
hu->proto->close() and setting hu->hdev to NULL. The write lock ensures
all active readers have completed and no new reader can enter the
protocol recv path before resources are freed.

This allows the protocol-specific recv functions to remove the
"HCI_UART_REGISTERED" guard without risking a null pointer dereference
if hci_register_dev() fails.

Signed-off-by: Jonathan Rissanen <jonathan.rissanen@axis.com>
---
 drivers/bluetooth/hci_ldisc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 2b28515de92c..5455990ab211 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -692,6 +692,9 @@ static int hci_uart_register_dev(struct hci_uart *hu)
 
 	if (hci_register_dev(hdev) < 0) {
 		BT_ERR("Can't register HCI device");
+		percpu_down_write(&hu->proto_lock);
+		clear_bit(HCI_UART_PROTO_INIT, &hu->flags);
+		percpu_up_write(&hu->proto_lock);
 		hu->proto->close(hu);
 		hu->hdev = NULL;
 		hci_free_dev(hdev);

-- 
2.39.5

