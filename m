Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013061.outbound.protection.outlook.com [40.107.162.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05506342526;
	Fri, 27 Mar 2026 10:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774608465; cv=fail; b=sFbiKhRJS++aTKPqVjcc7Z/frz0nZiAd8On7nli3Cj4JQCzRer0SCOxYDscIxxB/vAOSR+0tKpy9gnOPgcsfjd5tR4XFWpmEte4k6PVuKlVTSjefl2QQzUQUWRhTHtvO4iC9qVfpyNG56s9EdVgSpvPZbmTLCtfHxlsfv7xZYZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774608465; c=relaxed/simple;
	bh=ASYUbwR+fSJjokd71imK7X8yJwC1tsc+XjA/HBzXrpw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=IhLIaemLGQadt1YWtkinwfdeIPboBXJtHAYyS3gGqWct/fYtHyY3xTuG5ykKhYS5KedSzxc5WBoMvcbF6e3Yr/HSw8a5YJQ3vY1LqCk6L6AAKPomInBFe90Crk8f8pXSTc0mXRiF7rp3+ag0BftswfoYiDqA+j5xMkUB5m0Lp40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=dVsdcxwC; arc=fail smtp.client-ip=40.107.162.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="dVsdcxwC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGRAYUcbjrGAVmMCVfE4H0d2SibdChc6jJMtX8kDecsQ17u8+JRudgYcuxsdpmvRur837gGtVnk79uMlZTEzuHIjSQt9m0qZKKV5ZDd30uTIlC0i5RJofntvvEvvEjT2ihEpGwY+LiZjPBXkid9sUPTAyviBK46tdAuNAONIegYmU6VSawihBgwx0jzxBD9tL8Uau3sCBZa8QsK40EFvAfynTn6KHbRPFaBepotDzaE16E7RvfSv/BZIcvgjtr29xqnn+wOA4pvonjVlF1OTk3qjVcMmsLOapJKn7MPVDLcOqSqtiUNNPkgO9eajddg/PjWJEZEyd6RNlgrlKnxo7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MItg2jpCl7yUQOWEl3sboxNyzLPRweRLUfpTaO2WpXw=;
 b=U4tgczVnQ0k2O7YqIvk700S2uiKEv43WxpQ+ovhyCd11TybBflbPrtmDiMawmfbKH5q2eDPJY6/Ze7PoMgrnCXMmyFtNm5zCz2GPEZxME2JYFwKhp6rBAAFHRoOHBCIOBM7I9/a6JGUVWFkCXKI4C7M17cZ6vdTRmdzHDzwRhJoNezGNpGxR4BrwVyJ0Jh/EFeHJROntA4aee+NuqVGL6BmsJlfXL9FcEKOzM+7/j+7Ntz8o9/h/Of7lNsuhbdG25XJa8j7BP77kwgJO4Sf8ecxVZm+1dOqhIl73BXEKpWXrQ6Qv/CLOiIv8JsbVcJmFSCEugGZ8s17JRDiLgh/O6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=gmail.com smtp.mailfrom=axis.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MItg2jpCl7yUQOWEl3sboxNyzLPRweRLUfpTaO2WpXw=;
 b=dVsdcxwC+ZfHpaa+9nMMim441eJZHWMJ73ekOE9/pzpgcrBZkVr1YrAQ76mGpFyg3xHgCytQHKeI1q+Z6oy1Qx7GZhdu9dtydBBFwC4PZYoyrK7KUOEt8hfUBcZ3POQjQJAA085+FsBwoJUug2d8HDf6Qae2LyhAHBSIJTKbhk8=
Received: from DUZPR01CA0298.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::15) by PA6PR02MB10688.eurprd02.prod.outlook.com
 (2603:10a6:102:3cc::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.23; Fri, 27 Mar
 2026 10:47:37 +0000
Received: from DU6PEPF00009525.eurprd02.prod.outlook.com
 (2603:10a6:10:4b7:cafe::24) by DUZPR01CA0298.outlook.office365.com
 (2603:10a6:10:4b7::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.23 via Frontend Transport; Fri,
 27 Mar 2026 10:47:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF00009525.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 10:47:37 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Fri, 27 Mar
 2026 11:47:35 +0100
Received: from se-mail11w.axis.com (10.20.40.11) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Fri, 27 Mar
 2026 11:47:34 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 27 Mar 2026 11:47:34 +0100
Received: from pc56869-2347.se.axis.com (pc56869-2347.se.axis.com [10.94.2.37])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id E25796E6;
	Fri, 27 Mar 2026 11:47:34 +0100 (CET)
Received: by pc56869-2347.se.axis.com (Postfix, from userid 18630)
	id DDDE8602BC95; Fri, 27 Mar 2026 11:47:34 +0100 (CET)
From: Jonathan Rissanen <jonathan.rissanen@axis.com>
Date: Fri, 27 Mar 2026 11:47:20 +0100
Subject: [PATCH v3 1/2] Bluetooth: hci_ldisc: Clear HCI_UART_PROTO_INIT on
 error
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260327-hci-init-fix-v3-1-1b54bad4ef0f@axis.com>
References: <20260327-hci-init-fix-v3-0-1b54bad4ef0f@axis.com>
In-Reply-To: <20260327-hci-init-fix-v3-0-1b54bad4ef0f@axis.com>
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Jonathan Rissanen <jonathan.rissanen@axis.com>, <kernel@axis.com>
X-Mailer: b4 0.14.3
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009525:EE_|PA6PR02MB10688:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fdd8968-f70f-47be-85d9-08de8bee42dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	hn7hLCKjYXeW6+U/jDICamaBIJ2QjmDMbpfHkCpaUSiJJvztn7JDLI8Is81iiLVNfCWlzVklCcKvrZEtSL9ekwo9PS5C3hRUA0+vm+dCsOC38iMX/au2opWc6klITGfLgCw9zG2E11/zr7Fb3KKAD/ERnqSHQOvat1H6rX3bmhyiqz0ySxraheX9dbn9+MYWAmTumiEsWFg7cRxzyd0luoaNoMxjbmRiN4jxY6d8XSWP+hWKjicLeJimPOqzUqZMT3cdwkkcXaxtHaKGtN8eNkWvHL2FYsr7ePfN04UNQPqft9wyHj69SeptW6nV+whfKi+93IYJ6Mn0tsIkeg6MxNXQgzCNHwfdFlTcMt0Q4kVGOoSmam19p2BEXTntW5Xj/QPBhaLLw5DiWAZVSGvdJBlIlZ3S+DeueS4liivF3IdOsC7n6GDuVW/1cloMKczmzflqw1dopy+K52SOE19+MHSSZgZAUCewdXYit1MAij7NgWx+M9Dit6xlMU0hP8Metcnx+6jWWxMYDejekATFRI3I2l/WApIpR/wiYpYBWpUNjdcIaSvc1lp/IVYbQ2uHgpRPyFuNVAuWBS82gnLUA8q1ehtw0CqL4w5MI8Wft6uOk8WHOHR0Xb2HdPavorUaWawQGEb17TwzcajUmqiE0TT7PHzqf5LIpd4FQXty/CVsXgV7DKwCr9o46W/3angTxx/aa7JX1asaDyvYVTBb4UIKrkmwLm54HQ9GsCn1hA8yvrk/MVpTYN11f0So6Xni1rZ9z0BWLHWbuth6dCRFKA==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2qWDYFKIL7o29H9W8bpj1goBeNol6pcm491Au5ds3kp21gSbFKw9VND1/SB8UkNMnsHqX2OuSxvw2CW51HzL0z/z9qGBqQ/u5Mkqe8HFCR9Gm6Xtb4XBAh57NaiMwdR7EPsXyyNBpvXFFMUOlmAVJ8KdpQVzQIKuiZeD4hnKdaGykv2ZjdSIfryvSP48R46CyCVRjG/TjEHu5k0QHbflBj6QUBsTkCx/2RFK269PQd2pAtHVlQd1WV8Z0M3r3t9ZUMo290JrQ1qfQ44PEt6HO/fSgAGBoIyZXfSWd+JW5+Bz4Vvkxxd14g1GQXM7F3Y/8bjxX56BWfNlwuR5iOT13kSJjk3ZB1dt+qdFOSN3rvsz9DarN9Kw++8SBSR5bvRcZaJnaL0gR0pYDLATGcieKVdzZkNE7a48mBdZjXsMkQnNe5mL3RnbwnoQAINpPeng
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 10:47:37.2984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fdd8968-f70f-47be-85d9-08de8bee42dd
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009525.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR02MB10688

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

Fixes: 5df5dafc171b ("Bluetooth: hci_uart: Fix another race during initialization")
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

