Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2057.outbound.protection.outlook.com [40.107.255.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7FA13B2A5;
	Sun, 29 Sep 2024 08:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727600287; cv=fail; b=cSWC9uQXd9c8uuJgQgfxGhdSwBcz6ODMyp5vqQDw6jp4qMRzIF8nkPKrgBrOlO0a+/RkxhWiY1bgu/GQn36Lc08Q8y4zaLaiw+UWZg0+vzZlES5hvXM1TYj9SMFc/qXVkNyaWXpze5rZVYD3aTV2HoEsiMfRdO9eNpnbsTfRlgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727600287; c=relaxed/simple;
	bh=CAmIJp6AudtOTW90PM8t+73w0iEz1txHDaO1+9gHrzY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=B0iYjoaVtNXhxrO47E4rGiDWubrOwGyIobyJvSCUwy2WNef5Ckfn/jROfPe4QNBpMFuV34Nx9f41dXKgm7XDmYB3DHyKQpo/TeFJTagO13rWu6qoNxjP3b/85YSpPCKnnB40276SKhCQLx62AX8lUESE/ucY8gC3+g+Io2Wzg4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=M32EMghO; arc=fail smtp.client-ip=40.107.255.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="M32EMghO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6KEL4hijPyJ9gqulMnT2SOyQ6pARXh78V2MUKJqlXKlTCBqSbSAmGxopl/lecVeqcxhvzuQwa0Clf1m/aLVicfuxw4Fl2RVsLx4kDgqGtCSfy7qKL90EkEAIxAIcdF/OtwvUaTT/gBtsQpf5lN3ePjfo1hjJ5M/gUPQ3bqL8C0yyj0n6pu1yBSkgAfhMFZLmqzuSn8Akp67b2fUVnbA4RTUZEAujxhGD55SXQcJmAG05McHIr5NclN3EbFMpdi7pP/hvuHviLWghVAqcIkhQgdLFy3ePqxyGStk7bevw7sEapE/UVIVZoVkhClqCC4Tz3EIUtvdaEwjydGU8ByVcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wL+9qYlXA5v0qqJwbzIDExW/c8fms3JbMVl5nHst4qM=;
 b=ULeH2ExHxHT8blkLfvG/EDlkuww0UBohQ6sRqIP7x+3ET99K5d/UERs7rLaWgi6fsWNB42A+vctr2bFw3pHqwhSTVNM3t3LD1dMcvyJpgPkWBiWt7fX8iB9G16/bW+d9kcH5oD6898aAXEbrGhQ0taUuy6GwovYi3sJKErQURUXd0uSFcbvoBWjzV5+CyAIUvquEp/PCjxguBL0yBefK5aeuJYMk5zOkoktSLIvbMXY7FJ6C3QDdlphjcH7kjaBLkubnE6ErX25CXGPrUQUH5R/n7teHkXYbYx/FDGHimzvKZnR049JXkamAKgNEuX/qWWPFikGk/PdQk7qI76jCGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wL+9qYlXA5v0qqJwbzIDExW/c8fms3JbMVl5nHst4qM=;
 b=M32EMghOL1UhC/CeSPlXlxp4JGRdgFANFkc/HZI98BeoWmCFP6Aqsz3XqJccKHqoc5eZ8b329dGXq/BncdVYCT47PoFe1IFU9K/OHKS2NY+KDSciaeeSp0VblehMuQYtcOONEFC+3ygFzyZeFg7IuzypfngFUwc3wSkpN2ROkJHC/t08+bPCjzakXhoCi237ixoE3py8vX4Yst5HwwYdzPCA90Z7BMbpKiw8BOiYeTZRSHqo7YA/yuNyb2/HYZ8tk15UHK60Ck/rLZZ0bZEV1+TW3gmIWmw40lITGxVqcImc2ieVm4EgOkv10tnIvnXOsqjGn9wrnSvqrydCFjyqvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by SG2PR06MB5213.apcprd06.prod.outlook.com (2603:1096:4:1d2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Sun, 29 Sep
 2024 08:57:59 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.8005.024; Sun, 29 Sep 2024
 08:57:58 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	sean.wang@mediatek.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	opensource.kernel@vivo.com,
	Yan Zhen <yanzhen@vivo.com>
Subject: [PATCH v1] bluetooth: Fix typos in the comments
Date: Sun, 29 Sep 2024 16:57:27 +0800
Message-Id: <20240929085727.523732-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0084.jpnprd01.prod.outlook.com
 (2603:1096:405:3::24) To KL1PR0601MB4113.apcprd06.prod.outlook.com
 (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|SG2PR06MB5213:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c23fc17-94af-4914-8ba1-08dce064d0b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RlZc+KgoTJVHCvuPPHAEIZ6OB/eA5vdqU2Om3X0P/hpDOgjpt6S9K0AHLkrf?=
 =?us-ascii?Q?8NV7JrPJA2tQXn16OzBQvSqPQ6xfIrWQHFj+uh80xgqnXwCovYOPcahuLAyf?=
 =?us-ascii?Q?3sQ1R+IkUYIPsf/xKbxeVdE9TKObfLkGfU5u2gNViEKwZjQScn+WznVOb7ex?=
 =?us-ascii?Q?2kdC7QjgL8MeIzOmVOxyIwkkjTZOCi2lPBJ0T/xUuO+prZL5RQwM/+0Vgye3?=
 =?us-ascii?Q?TxNgepVwBKwJySzU2t61aAyNoU/+Bm8uJK0lfiC11jGVoEnBYIu49Qj8ArAH?=
 =?us-ascii?Q?YSv3N3pUKqrSNcjJEhpnvZZF0X9GdRuQxu1CpRxc+Fgv54fiCr3ZchvEgLgq?=
 =?us-ascii?Q?HN+1rI9391lnGux5NZYh8FPzRFeaeq34ro+QTVMT4Kbmx/Td7lfEPA/edQsF?=
 =?us-ascii?Q?5rzeVm8Mc+q+usifrdovEYNbMlBVLKZq5f95WZAB/4rxGg47d5YkG8pSKCu4?=
 =?us-ascii?Q?yuXLQbh5shRV6Vz96TWcTO0ZfRppJ+dLGIE+IhqoP0IXcBmzyPJqVCoPMMcQ?=
 =?us-ascii?Q?Lr/SKm1LpxBJ1FylBqng6fCNyA1tLmLDbmq/GzlARLDeo//7ZtrYtocEuht7?=
 =?us-ascii?Q?NkcNSZRN7pconFdI8oG6j7D+aF/1wpD9zT5FTT1OET4K+q7w/6PDcTVdh098?=
 =?us-ascii?Q?FW1tCwWLkEXJrGkfJqQVwYwzb0Ij6zrMfzccQR+mY33gQYX4BH3hALBRjFD9?=
 =?us-ascii?Q?vKU15/4Wby1vzqwH+e2fo2pAVSyYLEXXRPRTCc/5Zu/uJCT4b2LM6xv61B49?=
 =?us-ascii?Q?PfyL9ayh3DlUnB8zVG+UE2nBGq+3muGfEx3fozQNxsZSRxrrmhTmXomq8DpL?=
 =?us-ascii?Q?Pws+gfsBenfjmiPCQSyPl3oKJyPiWgzMTNFgcS832Q3da4XJSliuLiEbZlQS?=
 =?us-ascii?Q?7rzbUGl9K6LRzYsX7trYws0ZLnsj3qd6lp1JC6HIUsEZYpEEacDA2H/H31TH?=
 =?us-ascii?Q?gck536g6uLVjRojtSqZuN+xuID2Z42tiXCEFuhwm9iqMGsyRXxHTVp/T9Sl2?=
 =?us-ascii?Q?6Y4I6tRA2+YhxfskyRRa4qHKJmmuPqprhhK8XO7Q4MtZkTK9UAN+UvDQDpGC?=
 =?us-ascii?Q?q4p89jTyjCcse9Qa3ZXHTkoqqZJ5dhBAWicYM0M016Izi7jEY+VllFZd4Y4f?=
 =?us-ascii?Q?wmf09po9U/0kKFun3nR5428/iRh9U3UL6BVzBxba06XL9c+M1UCbPZQI/jLP?=
 =?us-ascii?Q?0vrgkS+qf/kKM+4ifqB57KM86Dx3eDmaCKF286m/wEWzTnGiJMSseBBKx70T?=
 =?us-ascii?Q?uTPZrdCd/ehTGMxFR9xlDOrzCdEcCGwB52OghYWxq6x8Hbotn893Kl3TdmX3?=
 =?us-ascii?Q?3doEkNv/53qcb0zQhDJxkUCWC8E3m7RXJFzQrJmU5zrG6A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H18fKrMgrIsGDav8KKs8PP2sTkneMebuRDQPA18b96Cl53etxj3N1ext2h4d?=
 =?us-ascii?Q?5eAxqNB0PMCs8GgUqCiPVAlPs5vTNmDVT0G3YTCAyAUFMDYCwjQPJ7oJUzkt?=
 =?us-ascii?Q?GriJ1bwZhvKWTtgOcJigWKSBSBq3WfSITHmwDHhPsJ7Hm1YwuBN778OuY5lQ?=
 =?us-ascii?Q?HZF2M5urewtOqPZmWe7Oo6tTbCvvlG2E0TlLJpyJosH4t45/oQL/wpk+OFzc?=
 =?us-ascii?Q?orOD8DlsdGMB75HvTFvV7ziOaUlSe8oJnJvw0WRHASyLFna0DPTkbaqsZ/BZ?=
 =?us-ascii?Q?C4gvauPUygolkqnF5Gqcd6FKPjKy2Q4IhhOMHoxKE7vGVPYgl+mQ41mIruNX?=
 =?us-ascii?Q?25VcLWOvvz9NFOBJ5QvAxhArEnFb6PshS2NrxxSZ++p9yAfthCdm3aoZRFz5?=
 =?us-ascii?Q?4mlKvvU+EMp52HEz7GZZAalhyvYlxXq7xjEaZvIHNTpZ6rZf7EzGpkKGo7A3?=
 =?us-ascii?Q?HO4oZzNA6E2XwhFzLwfXy/esYPn33P/HbWou5xxg16ROtU9RVIs+beZPcn3i?=
 =?us-ascii?Q?AeElLJWNcMtMA0lhf1H2E4ik8wzijW5Ol9sFIewVNxZ3kCfK9z9X7Nl6Eiid?=
 =?us-ascii?Q?avFomS5JgqU2/Uz5dsCBXwlAHu+SOL+lfn8eb9mQzNa+7e/q/TTFA/jjtXrF?=
 =?us-ascii?Q?KeLUlblz5eWTG7ENJa2rYR2rND6rK+glhxkGc2K9QRUuMv+ZG1L/MS8miGHx?=
 =?us-ascii?Q?VaVa79sT0WSi6Bn7S0BG7crFd48d0XAwwBZ/yeQIZ7KcG9QHrIr3QDtiSoRL?=
 =?us-ascii?Q?qbgRUcbLB7Sl3Bzpovn31RJi2Bv1Aa7b+ky1uU4nEmliUprhIGgVOEWinNnq?=
 =?us-ascii?Q?8wYiSvhnzc+t6pr7t0mCk6NWYxc5vLDoEWCSVLNvDlP6UKicZZ3MTFd3KQBA?=
 =?us-ascii?Q?ntSQHGsOgCgM+dvpIU42eFdChSejQePPFVaW/Ct6bZHs0mu+cOhRS9F2KHvC?=
 =?us-ascii?Q?tfTUoFvVufz7I6u4PkJRUQo6opdEZyTsWc2m/CpYU2QCjetXPOtZp+gI4hUR?=
 =?us-ascii?Q?2/qiUd6Kyn+bFlLuB8LhObM7564MxriPst5uGEOYzGY+YSwiLgArixFk/lPv?=
 =?us-ascii?Q?IOdsH10YOUYI5MYafN6FN8SxvjnO2M0axdnwh6rpl1I7+5zn2kUolyHDrcW3?=
 =?us-ascii?Q?1df8mcvjvJCvYN7Q69ag1cs6YJILq2gjSURiJRms/oUEux9JlS9DCdaOJkUm?=
 =?us-ascii?Q?ZmfDumI5dYc4hK2ioCsYGIC/8MB+Q5ezDNnXWKE91kmuLBbrV0zTRJmxAA04?=
 =?us-ascii?Q?11VhB25sTuhM2l2Lsab+10VDv/INI7Bf9ezcNmhg9jHJWUeJtz6Kt4PkMqiI?=
 =?us-ascii?Q?3flggs1EUBrUd8S97RADg+bySoZvg2zPNmLg/9ZH8FwOgNus73z6RARHQiXJ?=
 =?us-ascii?Q?x4Hb1CsLZ9H8z1IPAXVvKE6FQcb1RXoOhX8VXO7/lLNVm77dUHV5ofwxhkrp?=
 =?us-ascii?Q?ZgmkACDh4zQZLiwSM9lzCg1B6qW6XmtYUmnyXRZwbMaiuSDhcYLmxkZmZSXu?=
 =?us-ascii?Q?VcEV99Zr8OHGyDtzWHrrsqC9VV2vAVCpiVDCqklRUx001NHJdbjXWoAi7NVn?=
 =?us-ascii?Q?awfgmygFLoE42+EQjvSsrF2U1Sg0XxlD/lu7NlYj?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c23fc17-94af-4914-8ba1-08dce064d0b1
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2024 08:57:58.4996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kXwHyt5RGItk2S3l2b59SvxVVtlbAaSPmtEASS9zhYwwtvRlTdX0a9idFFUttU8TPUxzeDci6VCFZtOXqmimBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5213

Correctly spelled comments make it easier for the reader to understand
the code.

Fix typos:
'fragement' ==> 'fragment',
'genration' ==> 'generation',
'funciton' ==> 'function',
'Explitly' ==> 'Explicitly',
'explaination' ==> 'explanation',
'Tranlate' ==> 'Translate',
'immediatelly' ==> 'immediately',
'isntance' ==> 'instance',
'transmittion' ==> 'transmission',
'recevie' ==> 'receive',
'outselves' ==> 'ourselves',
'conrol' ==> 'control'.

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---
 drivers/bluetooth/btintel.c   | 4 ++--
 drivers/bluetooth/btmtk.c     | 2 +-
 drivers/bluetooth/btmtksdio.c | 4 ++--
 drivers/bluetooth/btmtkuart.c | 2 +-
 drivers/bluetooth/btusb.c     | 2 +-
 drivers/bluetooth/hci_ldisc.c | 2 +-
 drivers/bluetooth/hci_ll.c    | 2 +-
 drivers/bluetooth/hci_nokia.c | 2 +-
 drivers/bluetooth/hci_qca.c   | 8 ++++----
 9 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 1ccbb5157515..a6a125935cb3 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1040,7 +1040,7 @@ static int btintel_download_firmware_payload(struct hci_dev *hdev,
 		 * as needed.
 		 *
 		 * Send set of commands with 4 byte alignment from the
-		 * firmware data buffer as a single Data fragement.
+		 * firmware data buffer as a single Data fragment.
 		 */
 		if (!(frag_len % 4)) {
 			err = btintel_secure_send(hdev, 0x01, frag_len, fw_ptr);
@@ -2835,7 +2835,7 @@ void btintel_set_msft_opcode(struct hci_dev *hdev, u8 hw_variant)
 	case 0x12:	/* ThP */
 	case 0x13:	/* HrP */
 	case 0x14:	/* CcP */
-	/* All Intel new genration controllers support the Microsoft vendor
+	/* All Intel new generation controllers support the Microsoft vendor
 	 * extension are using 0xFC1E for VsMsftOpCode.
 	 */
 	case 0x17:
diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 2b7c80043aa2..964911bce528 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -324,7 +324,7 @@ int btmtk_setup_firmware(struct hci_dev *hdev, const char *fwname,
 	wmt_params.data = NULL;
 	wmt_params.status = NULL;
 
-	/* Activate funciton the firmware providing to */
+	/* Activate function the firmware providing to */
 	err = wmt_cmd_sync(hdev, &wmt_params);
 	if (err < 0) {
 		bt_dev_err(hdev, "Failed to send wmt rst (%d)", err);
diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 497e4c87f5be..781a1a86b8a2 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -681,7 +681,7 @@ static int btmtksdio_open(struct hci_dev *hdev)
 	if (err < 0)
 		goto err_release_irq;
 
-	/* Explitly set write-1-clear method */
+	/* Explicitly set write-1-clear method */
 	val = sdio_readl(bdev->func, MTK_REG_CHCR, &err);
 	if (err < 0)
 		goto err_release_irq;
@@ -1396,7 +1396,7 @@ static int btmtksdio_probe(struct sdio_func *func,
 	if (pm_runtime_enabled(bdev->dev))
 		pm_runtime_disable(bdev->dev);
 
-	/* As explaination in drivers/mmc/core/sdio_bus.c tells us:
+	/* As explanation in drivers/mmc/core/sdio_bus.c tells us:
 	 * Unbound SDIO functions are always suspended.
 	 * During probe, the function is set active and the usage count
 	 * is incremented.  If the driver supports runtime PM,
diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
index aa87c3e78871..f4ae9e5ea09e 100644
--- a/drivers/bluetooth/btmtkuart.c
+++ b/drivers/bluetooth/btmtkuart.c
@@ -327,7 +327,7 @@ mtk_stp_split(struct btmtkuart_dev *bdev, const unsigned char *data, int count,
 	if (count <= 0)
 		return NULL;
 
-	/* Tranlate to how much the size of data H4 can handle so far */
+	/* Translate to how much the size of data H4 can handle so far */
 	*sz_h4 = min_t(int, count, bdev->stp_dlen);
 
 	/* Update the remaining size of STP packet */
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index c5f7dd65617e..65404642a373 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1070,7 +1070,7 @@ static inline void btusb_free_frags(struct btusb_data *data)
 static int btusb_recv_event(struct btusb_data *data, struct sk_buff *skb)
 {
 	if (data->intr_interval) {
-		/* Trigger dequeue immediatelly if an event is received */
+		/* Trigger dequeue immediately if an event is received */
 		schedule_delayed_work(&data->rx_work, 0);
 	}
 
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 395d66e32a2e..d2d6ba8d2f8b 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -594,7 +594,7 @@ static void hci_uart_tty_wakeup(struct tty_struct *tty)
  *     Called by tty low level driver when receive data is
  *     available.
  *
- * Arguments:  tty          pointer to tty isntance data
+ * Arguments:  tty          pointer to tty instance data
  *             data         pointer to received data
  *             flags        pointer to flags for data
  *             count        count of received data in bytes
diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 4a0b5c3160c2..e19e9bd49555 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -305,7 +305,7 @@ static void ll_device_woke_up(struct hci_uart *hu)
 	hci_uart_tx_wakeup(hu);
 }
 
-/* Enqueue frame for transmittion (padding, crc, etc) */
+/* Enqueue frame for transmission (padding, crc, etc) */
 /* may be called from two simultaneous tasklets */
 static int ll_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 {
diff --git a/drivers/bluetooth/hci_nokia.c b/drivers/bluetooth/hci_nokia.c
index 62633d9ba7c4..312da01e91d0 100644
--- a/drivers/bluetooth/hci_nokia.c
+++ b/drivers/bluetooth/hci_nokia.c
@@ -501,7 +501,7 @@ static int nokia_close(struct hci_uart *hu)
 	return 0;
 }
 
-/* Enqueue frame for transmittion (padding, crc, etc) */
+/* Enqueue frame for transmission (padding, crc, etc) */
 static int nokia_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 {
 	struct nokia_bt_dev *btdev = hu->priv;
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 678f150229e7..1086ef2c71ea 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -873,7 +873,7 @@ static void device_woke_up(struct hci_uart *hu)
 	hci_uart_tx_wakeup(hu);
 }
 
-/* Enqueue frame for transmittion (padding, crc, etc) may be called from
+/* Enqueue frame for transmission (padding, crc, etc) may be called from
  * two simultaneous tasklets.
  */
 static int qca_enqueue(struct hci_uart *hu, struct sk_buff *skb)
@@ -1059,7 +1059,7 @@ static void qca_controller_memdump(struct work_struct *work)
 		if (!seq_no) {
 
 			/* This is the first frame of memdump packet from
-			 * the controller, Disable IBS to recevie dump
+			 * the controller, Disable IBS to receive dump
 			 * with out any interruption, ideally time required for
 			 * the controller to send the dump is 8 seconds. let us
 			 * start timer to handle this asynchronous activity.
@@ -2358,7 +2358,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			 * Backward compatibility with old DT sources. If the
 			 * node doesn't have the 'enable-gpios' property then
 			 * let's use the power sequencer. Otherwise, let's
-			 * drive everything outselves.
+			 * drive everything ourselves.
 			 */
 			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->dev,
 								   "bluetooth");
@@ -2530,7 +2530,7 @@ static void qca_serdev_shutdown(struct device *dev)
 		    hci_dev_test_flag(hdev, HCI_SETUP))
 			return;
 
-		/* The serdev must be in open state when conrol logic arrives
+		/* The serdev must be in open state when control logic arrives
 		 * here, so also fix the use-after-free issue caused by that
 		 * the serdev is flushed or wrote after it is closed.
 		 */
-- 
2.34.1

