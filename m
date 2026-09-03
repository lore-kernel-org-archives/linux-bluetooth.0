Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022099.outbound.protection.outlook.com [52.101.53.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AD74A2071;
	Thu,  3 Sep 2026 12:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788437924; cv=fail; b=fBNtuGiMBx6OpTTKE9ObMjrB8x+6+V0f03KTqaH4fVhLmaTPTzb69Pqo1I29vx2vAH8zezF1lK1KQD37s36jEsvmM+Vm0RvqOBBxh8pmY6/ufiFAcTWK0qitLmY4qc/gorCfJA5AxX30fvNb9jRsXrSSTBvMkThThHgxK9GiNWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788437924; c=relaxed/simple;
	bh=4VygJI9CMqGmQXIStZbkInkKjJrPpSH5Y6D7Y2Wr+9A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cXRNP1DxmsMBpqVXh7MK6PUKY0ei6+vQkI+NeRusfOCL/4VYSAhyXMYL7ZeSl+n9+xW+10cPTpYfwtGFT3QqYAWqjPHnXSJxae0Ib1hxb6XUVwvSgrhL3S550CdoxfatODJmJqS5lZgfO381aR8aY9BnqdMaRXrJ57849EBwojk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synaptics.com; spf=pass smtp.mailfrom=synaptics.com; dkim=pass (2048-bit key) header.d=synaptics.com header.i=@synaptics.com header.b=e0YE9sSS; arc=fail smtp.client-ip=52.101.53.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synaptics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synaptics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synaptics.com header.i=@synaptics.com header.b="e0YE9sSS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPiywnddKLHK21+TPOmmfrF4wnbqWfChF6MK0rOqIqj2GzMdmEC4nkmvOvxwHGxY+jz/9S7As1PdrpWDqz3UGeGfvgQDMsMNGBOLGHliM8w5QcffqN2It1spa7YXZhwjLNrXrJlC/f7LaOc4YsdwrVyFw809easrn/6FzV+qvPwAgPaanFY9OND6Q9catVS83h8nR0Z2cmBU0tJJEBt/g2S1nucungQQRuHojaFnF3g0NKw/pQHGdLVOTBgHw36Arb99w4qZIi4hKc4JPxObqyUCMGoGuG4wO27A+7vAEjub37pR+M/YiqB5NAlloWNviOVw6IcS5Xl+dwy8lKs2/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4nR80PoG4iBPJhKN54RTH1iIN31QKwU0G8VoWbjNC8=;
 b=pC1J4zwRlI7/ex3F/2kAj+DcQF9YRovj8/WG3WRVM0k53syA3o/UOdA7MDMDwlkNJS6HEGhtTpME3JMds5xvnVkmv6DUTfljKL6Yopr2bgA7WwZ0/G4xjxiBiMgze+uXlAw8x2CExCAwaOUHhLwXjcZDh8I5ZHST2oy8IRZqDEmVuzN+aZb6zkfa4qi70gDmC/HMXw/wABtCY/CK30x1OIn9BucfzbgHloqfXjkP4BQSBGoMOyWtwOsomVVRA9THsN49IRkz6scLL4sQml3fWl7lBajQtIZVFjH6wS1pH+6uZfvOh/SD2HnVitWxOyzOTo+YRVF5yqnudxfO2CcRUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 59.124.75.172) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=synaptics.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=synaptics.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synaptics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4nR80PoG4iBPJhKN54RTH1iIN31QKwU0G8VoWbjNC8=;
 b=e0YE9sSSdN2qkS02XIjuXJgEICnKyZo9IPoLYBxqjZKH6ZhOHmwOWNmev5rIAnaKM5ecUfk5834rC8EdM9S/mNK2S+PxoYVN+oB3wbZ0ea1g7tRvmRgqJPWOF2j1IXbeNXDlLzM7IKKtrYCQIT8G75QGxDAr8SCFwNNg0HmyCal/NF/YivORiYkPXQF/doCKHLWD6wRNE+S1XW0Ya54Sx/ZU3GEH+nqwVrGtY16octcR9uOLkiihC8Jr2EYE46e36hJ9ckSBl+Uu4nx2rS5jqNHa46wgAufGPPHA+S+btEkTrEd8aD8er+1hvjCJcPyhN+Dr2+VhLOXwqsXolX4YkA==
Received: from SJ0PR05CA0205.namprd05.prod.outlook.com (2603:10b6:a03:330::30)
 by CH0PR03MB6036.namprd03.prod.outlook.com (2603:10b6:610:bf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 12:18:38 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:330:cafe::4a) by SJ0PR05CA0205.outlook.office365.com
 (2603:10b6:a03:330::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Thu, 3
 Sep 2026 12:18:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 59.124.75.172)
 smtp.mailfrom=synaptics.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=synaptics.com;
Received-SPF: Fail (protection.outlook.com: domain of synaptics.com does not
 designate 59.124.75.172 as permitted sender) receiver=protection.outlook.com;
 client-ip=59.124.75.172; helo=bt-tpe-server.synaptics-inc.local;
Received: from bt-tpe-server.synaptics-inc.local (59.124.75.172) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Thu, 3 Sep 2026 12:18:35 +0000
From: Andy Chang <Andy.Chang@synaptics.com>
To: linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>,
	linux-kernel@vger.kernel.org,
	Andy Chang <Andy.Chang@synaptics.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v4 2/2] Bluetooth: btbcm: Add Synaptics 4384 chip support
Date: Thu,  3 Sep 2026 20:18:24 +0800
Message-Id: <20260903121824.3080796-3-Andy.Chang@synaptics.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260903121824.3080796-1-Andy.Chang@synaptics.com>
References: <20260901023300.1382808-1-andy.chang@synaptics.corp-partner.google.com>
 <20260903121824.3080796-1-Andy.Chang@synaptics.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|CH0PR03MB6036:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d7b13dd1-ae58-4c97-130c-08df09b57b42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|1800799024|23010399003|82310400026|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yZqtIfdq5nRPCm021asvQJ//k6LBcB424ozJmBjm8IH/jofRc5J3Q4lt1oajhEL0kkl7QLbui2YXSfZjMCDvnS+rSNE8ubfeyxSFAOVh8wdDA/OzVy3YoV4BMZvXKDZU5lWWW351U79LXWg8STswAfBqHYk6w/GbmdSWDEV4HzCEbPdfPuKT2fQoQ+Ke+zqrOLpdW/j9u93O3vB9f/uDjtUraUJkb3VhSMiDTBt5Ghdh4dxrb4YUtdR320/OlC4yzZjM9Om/G9KiDoxZ8d8+vAdT8ZwrO2wTK7YXufGgjd22zkMtaohdpbw4+GjF6uUDf7jSLzUIeb0DlPVvqBUIVsYVRqoXR3WpKbWPtfLFU49QoagP+PaVRlp4iKKY7vERFphl5M45Vf5Dz3913Sojyw8cvFWGkCceW7yyGQ7c5wxzssno+OIEYP30chiJb3cyNs0ix+kE4MGfC3M9YvxZuOiVOF26i42pd+w+CS5NO5CZ8i3IV6FXDHDTMxRSnqYtI5eyojelKFk2SwfuvyXfUc4QtHlA6K7wMMCYIIGsIZ/5Z7gNZDmgJpWHQaQ1GfAPpQfxQ4F7lDpiPp70WU4aSjYpUokYt0OvLh1g3FN1zXvGRhDjy0IQe7bErObL6Dhb6Bqn74eYalMQ4CWefOGbyPbPv8GvHUZKZ7JmSYV/b2QhxkJqVkq3ij8ii9y4igCwTFr3KBt8RIlrDrV0Eq1Yjw==
X-Forefront-Antispam-Report:
	CIP:59.124.75.172;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:bt-tpe-server.synaptics-inc.local;PTR:59-124-75-172.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(23010399003)(82310400026)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ykZo39gOp1kPvFFRdSIIz5148KI4BmJxphGLrRFlGvNSpBpNTdgk3olV+yx47qIvJpCD+mpxc3Q6zno+IAT0Xbmue/s4XD5EiDCWlFuTo5VdvVkEM+AZYx6FizjhYHqiT8xSHxWrKOHoKKC3cNCwTwA4ejPEW+sUjP7esppjbWctvLAkzmq6mvgdl4s4UUD0P4MFk92i83s8k17/hpkcAqOqmHd6o6uq6N5U8mqfRA3T1tEx9cS6/0My2vohbYa0MTIJa1QXVj2pX+D6eJjLq9e0+i3Ap3O98rq66uqzwOlICfgWvq0LBZQ29qt6GF8SylqEtJ8MeLSwG7n0pfL01xKbXf1cXCWC84rqL8UZN4jbPzYNHgSqwp28OdMgBeWv//8+3GPvT6l2nNSayEBAQMilqnP6fvwYEkKBavOUtTpJeLJZtxVTn+FzsctLCf2+
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 12:18:35.3609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b13dd1-ae58-4c97-130c-08df09b57b42
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=335d1fbc-2124-4173-9863-17e7051a2a0e;Ip=[59.124.75.172];Helo=[bt-tpe-server.synaptics-inc.local]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB6036

Add support for the Synaptics 4384 Bluetooth controller
by adding the corresponding chip IDs.

Tested on the VIM3 platform. Verified that the controller initializes
successfully and that firmware loading and basic Bluetooth operation
work as expected.

The VIM3 is a Khadas single-board computer that I used as the host
platform for testing the BCM4384 Bluetooth controller.

Test log:

  Bluetooth: hci0: BCM: chip id 206
  Bluetooth: hci0: BCM: features 0x0f
  Bluetooth: hci0: BCM4384B0
  Bluetooth: hci0: BCM4384B0 (002.001.025) build 0000
  Bluetooth: hci0: BCM4384B0 'brcm/BCM4384B0.hcd' Patch
  Bluetooth: hci0: BCM: features 0x0f
  Bluetooth: hci0: BCM4384B0 AP6684P CN iPA [Version: 1030.1021]
  Bluetooth: hci0: BCM4384B0 (002.001.025) build 1021
  Bluetooth: hci0: BCM: Using default device address (43:84:b0:00:76:93)

Signed-off-by: Andy Chang <Andy.Chang@synaptics.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Linus Walleij <linusw@kernel.org>
---
 drivers/bluetooth/btbcm.c   | 6 +++++-
 drivers/bluetooth/hci_bcm.c | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 463d59890bef..63c4c788d9c4 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -31,6 +31,7 @@
 #define BDADDR_BCM4334B0 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb0, 0x34, 0x43}})
 #define BDADDR_BCM4345C5 (&(bdaddr_t) {{0xac, 0x1f, 0x00, 0xc5, 0x45, 0x43}})
 #define BDADDR_BCM43341B (&(bdaddr_t) {{0xac, 0x1f, 0x00, 0x1b, 0x34, 0x43}})
+#define BDADDR_BCM4384B0 (&(bdaddr_t) {{0x93, 0x76, 0x00, 0xb0, 0x84, 0x43}})
 
 #define BCM_FW_NAME_LEN			64
 #define BCM_FW_NAME_COUNT_MAX		4
@@ -130,7 +131,8 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
 	    !bacmp(&bda->bdaddr, BDADDR_BCM4345C5) ||
 	    !bacmp(&bda->bdaddr, BDADDR_BCM43430A0) ||
 	    !bacmp(&bda->bdaddr, BDADDR_BCM43430A1) ||
-	    !bacmp(&bda->bdaddr, BDADDR_BCM43341B)) {
+	    !bacmp(&bda->bdaddr, BDADDR_BCM43341B) ||
+	    !bacmp(&bda->bdaddr, BDADDR_BCM4384B0)) {
 		/* Try falling back to BDADDR EFI variable */
 		if (btbcm_set_bdaddr_from_efi(hdev) != 0) {
 			bt_dev_info(hdev, "BCM: Using default device address (%pMR)",
@@ -514,6 +516,8 @@ static const struct bcm_subver_table bcm_uart_subver_table[] = {
 	{ 0x4106, "BCM4335A0"	},	/* 002.001.006 */
 	{ 0x410c, "BCM43430B0"	},	/* 002.001.012 */
 	{ 0x2119, "BCM4373A0"	},	/* 001.001.025 */
+	{ 0x2128, "BCM4384A0"	},	/* 001.001.040 */
+	{ 0x4119, "BCM4384B0"	},	/* 002.001.025 */
 	{ }
 };
 
diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 9a103db7e355..e70b9f3fd968 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1593,6 +1593,7 @@ static const struct of_device_id bcm_bluetooth_of_match[] = {
 	{ .compatible = "brcm,bcm4349-bt", .data = &bcm43438_device_data },
 	{ .compatible = "brcm,bcm43540-bt", .data = &bcm4354_device_data },
 	{ .compatible = "brcm,bcm4335a0" },
+	{ .compatible = "brcm,bcm4384-bt" },
 	{ .compatible = "cypress,cyw4373a0-bt", .data = &cyw4373a0_device_data },
 	{ .compatible = "infineon,cyw55572-bt", .data = &cyw55572_device_data },
 	{ },
-- 
2.25.1

