Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013017.outbound.protection.outlook.com [40.107.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3864F2EFDAB;
	Wed, 18 Jun 2025 15:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750261158; cv=fail; b=dkfkyv/kRiLUCrC1V+KELhJmfAREocLPcbFG1twjTKQgKLjEtUEPuTyXt6LS8/0Vwqkac1J9MY8vpi0O0yjbJrHOR4bwuNsrhIIffgrYKcNoT6HZsBgLlNXntMSOBXN2h8hIHIu6NFuwOtfunrkIsUO3M2/OIohKzI87tdcyXaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750261158; c=relaxed/simple;
	bh=6UDsXPkMOhvO2nP/Z3lMsNiFW1d37kmYb+Ov1O+li44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QZ3TpOZgEeiA4weI6Zzx1YY7sk/Lv2bcieG28SUBxPwcqlBlV28M9BcDTcRrKhLFpVmVm6M3ciWAX4FXfzJq4ExIOLRHlZTc6ZLHxQY2FyOc9T/i8sWqIEe2vgHnuODohxIAez4qgSeQHSYLW5phv8QPJzAdGRUw61yQ0e1h8Ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GyHQ820a; arc=fail smtp.client-ip=40.107.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GyHQ820a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7/koNrGLNBqCcs+GuuP3DGdfY4jHxYQHcc/roh1CEmfydm1pSS7+5ZXF848usMUu1EKvf2VAbRfjXxlYFMB05Z81yL3kQnUMOUTJHcIRr8zDlWOpzuFgxHEdSsmnnteWEXNt85qIzYZ3JrNJbTDLf76LWa6njjlyQxVBGES/ouq5gdxT7hLb9a4el7XLxzOzyBeEdtaYeWWfl5tRJWPDc8AA6HjFrRmBsXHvEjWBkzWkpqnkAa0gG2a6KjxCRmt/tjDa7fnt1/Wwb3EGw4vD0DmSGzMIWyDmy+ffZ8jXPXadHyaD/YZPt4nnnS4cBqUXNDB6f7yNbkgv+zwB3659w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeshOZT1ES9ZJVaLYVSmpPCM4Bdi7+yKFfnRhNW2FOY=;
 b=f2Wb022uXFCQS977papJcv+zGn5I/1/F/WWw5o3WuEdwU4Jbm0zr3qOsb52M4V6FKq5Zagv4jKALUUwK0RPvih9jmQVhKdIA8LTyWwjM4mPv1TipC0Gg9niIIvO9Ndh19my+CESAxe8qyViLvqe1vup54Czyw1UW3mzvN2Lid/6ny44gPubj3qt3OWVscNjda+dxYMBJ5+gM+L7iiGyZOqUBQRHr6XY2zKvtVslNnrDYcQ1emxytvyTIujuXhsF8CR4VS1NdKFIhz39LUHkDtUzUnXYKIRmbxLORLGpmYkAOqsEE31i8rVz9S+IkA0mds0nn41LWlo+3EaREzzvliw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SeshOZT1ES9ZJVaLYVSmpPCM4Bdi7+yKFfnRhNW2FOY=;
 b=GyHQ820aS8VgaVWxdSvz0/QzpHphrd8ghit55J9HqK4AFeVzmnRm3uxdvuW8FtAzGfZKfXu76TrzNVwmtbPzMQT6cWI9ZDI2Atapv2g4qpzdfp4Ze9bcZK4oqifbLimrHmwyw4SYNqX/6wcEM7AVRkKfM6YX/0221FWb415ewJHECqWFMleqW0iVX1FJnFMGDapI6+S4k1SkwsOtQ7JSVvoYHpmyMXfXCjbgDLu6K9gMfKhkghbKFeaxqxr09hnRi0atzOOkl0Yh9zyUUrcrbU98VcDmxW5N/r5QV4JkX+A51JCyHJlObZoC2HadlRPL4FuFMr5tMXQaYXuSR754RQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by GV1PR04MB10775.eurprd04.prod.outlook.com (2603:10a6:150:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 18 Jun
 2025 15:39:13 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 15:39:13 +0000
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
Subject: [PATCH v3 2/2] Bluetooth: btnxpuart: Add support for 4M baudrate
Date: Wed, 18 Jun 2025 20:51:13 +0530
Message-Id: <20250618152113.25500-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250618152113.25500-1-neeraj.sanjaykale@nxp.com>
References: <20250618152113.25500-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0003.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::13) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|GV1PR04MB10775:EE_
X-MS-Office365-Filtering-Correlation-Id: aa340d82-6c9f-4489-aa68-08ddae7e4654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u5Wp6PllcRvSQQ+kJMrbARPl5VA2Ktlk8zdgdnVqEpzFGaMIWMQCjrBoPRIa?=
 =?us-ascii?Q?xwdkT9XZPP1i1Q74A8hXkwbRe1ok8rCtZSLqOOXqGsHfJWEO72Ie6VG58kJK?=
 =?us-ascii?Q?8FgI9eepiPQC1oMqVMY1/RvQ2BA5snvrf+w5fADOWdsA9g2Xg9mCmx+sKNtk?=
 =?us-ascii?Q?HOab8xqsCP50uKUSNKNjJUZWaVpbvicxjbQHn6q8hdtPkGe3FaYxmSz85jar?=
 =?us-ascii?Q?PhHcZfGN98REYHtXvGMMnLulksmYKi5/X8zLLHz9HLcOX9J3Vffbcdb2lbgo?=
 =?us-ascii?Q?QvMYihimGaakpW6v108PV/8QxIqhpyOKo3bR0z9YvLXwioEemtGr3xY9cNBK?=
 =?us-ascii?Q?b/u0uyInVc9eDECkbS8S/Z8vZ0eafE/NT+fq0QGJ9zMKyfaKWEoXHITKRfwe?=
 =?us-ascii?Q?ckV3CKEmnWI88t1QWNskXXf5QlHM4hWKj+JiDSFijkC3ziYhyizoPDz/CJdn?=
 =?us-ascii?Q?0MoOYMExTKHTlv0+3LK731F717Gzxl9xksDrGCKCIFWBlUpTsrk3U41a5Vo2?=
 =?us-ascii?Q?+KrWXF8Oh1HUCsBaHH4GLSje17lSqOLcxF3xJq2TrNBH8Lh+Kxnh/X4feAXc?=
 =?us-ascii?Q?jy5peCTqetaz2xkttFYXUccEUH5F2RN9a/wSXbxE/elZ7bMifrpsoFw4Sirh?=
 =?us-ascii?Q?MAD8W21rHMKUTy0yAHRKXGX6K1i2+PgJZECoH/Otmefxqs549yvILDfDE/04?=
 =?us-ascii?Q?CSjN22Qdd+kMdy36Y6p+yvOH3mlbwlsbZZCbsV5z+DsST+Wjij/B7/EUKsiG?=
 =?us-ascii?Q?oCJag4s0wdSAJKsVgm2sUn/8wEEHseyYeT11quSTXF73b8R2LcS4GN6ZXtJe?=
 =?us-ascii?Q?oOxRiGv57VtyxllmZgtpeksSzOpuXqsW7pQacZ3Fp/T9TJloUAdCUQbmn4d/?=
 =?us-ascii?Q?CJFDa+xJemCyapb5/oRscAP8/XnyQ+ZTsdQ0wL8GDZbx1xUeGfXpwTTOScEa?=
 =?us-ascii?Q?ZVzXrBBCaPWx6u4+oxMCHbSVhHff5DZ+hwmRvBcYavRCqV2P8RwVAMAQi1uT?=
 =?us-ascii?Q?GZvitsc5Ll1I3dCxgi7F7KUEtSOW647Sv50AzGMpQMTPDSYJdHeiCcSqtn7l?=
 =?us-ascii?Q?nsLiy1MI0wEwZBLPz17rasItDDU9YHs43z6/sgK7Pa7oE8f0qohPffonehxU?=
 =?us-ascii?Q?np4Me7dmDVm+2uHeSIoUjdQkgdj0EULW+RldIsd5M2CbS6jYapQ/SkTmysyp?=
 =?us-ascii?Q?/5pyjBqGrAH1sPK8wy7v3LUGSBHBuuokadaeJNlAiQ2YE/UNy6SMqbLUgLwj?=
 =?us-ascii?Q?XTe4xrHxKesDXzR+N/m3d5L1pL+bkQm3Ze2U4LBtwmHHZXQVvsatMWAk9YXs?=
 =?us-ascii?Q?6Cjf4Vu8D2jnYM2a1RoLDKIMrB/NA2bNdNFBLWkKnB+m6L6CkuSDTMCZ1t/S?=
 =?us-ascii?Q?qWsp0rGoc3qOyQSkNnH/2VZoPz9wG0k8SbzJXf+wLHoEBX7DazwPwRiY6Isf?=
 =?us-ascii?Q?4ect/XPCIVUir9O541N6DGC/nYXG7IOSgb/6TM1MQnLGxO5emr7QoQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QCkHKY/RYz5FbSQaTyJmyE1RcboVcdcUykAkA0vhZuBasJ9vXCkTg5Ly7yIA?=
 =?us-ascii?Q?b+ZP71Hr1aVrsIDGFxgBR28ILtN1Vl70VNeCDOdyeGdi/i295vlU85sKQssG?=
 =?us-ascii?Q?oU6WYwyJzSKY+HsLJsirXBIp+y1iF2gMB41jsMUXvJ+aBTFbTL4iOx3xiPni?=
 =?us-ascii?Q?1FQTpCz4kl+/fJGB8Bn7OPgYaHCmptQsH88jfy7iNYiAqnuimDIgDiHKPRCE?=
 =?us-ascii?Q?+bdAk2TlPEyl4GipiTKdXKxEDcqlx1pC3fe/yhyB7Irnsb6DqzPe1m3ZY4e5?=
 =?us-ascii?Q?E/r1CiPqRSRX/OsaWnLVyOGNhX90et+7V0mGiAxmlg/BMzytr95evTTBsUTO?=
 =?us-ascii?Q?nIcKwNZ9TWkQ3CMUhgAfnY3/znzryVRA3jcU5malWs9T8IUHVxCGIw4+f6zZ?=
 =?us-ascii?Q?E8+KzSlDz2aBqeXcFdcPvR11S30zPNtSDbYxASp+tS8TMO4VRu7oceo+5R9b?=
 =?us-ascii?Q?3zhvsWFmLQSFgchzl1g3VYx6kM2ogg3pGBvi2qRT2WVlfy5V2L5X2sd3FEYO?=
 =?us-ascii?Q?jY1UtEBZt7rGv9eQdAz5ScGs0q3sYuzrxyY5Hpi2ib4mIpE6XSOJRZ45XmLM?=
 =?us-ascii?Q?SY3OB6PETSgDEbDx18KfkemP/BAvoqGe8T57aX8sBI4759RGNsIsDmJLo//7?=
 =?us-ascii?Q?zZwlVsbN3E0zA9Px/EZ2MRMf5ErdhXI+bGZo884YtdzW6Ux9+nMHKeD7SNm2?=
 =?us-ascii?Q?po4e+204R92F5moJquSx+CpcTDkUrQlOMedlkHDTvZZMhdJVEFwFO+mrvZsA?=
 =?us-ascii?Q?i8fTD5bm07BLZ98arOkcKIjnTo1W1G7efeyx4LVK4dFBIbMmPSpx4JrbuOjp?=
 =?us-ascii?Q?EO8fXSy3qNIzP/A2TJOJWAxQAW/GogYoiSFqDUxlsthtpBE3MrykBGJBC9bv?=
 =?us-ascii?Q?/nYSg4k2MUqdB9gQxDXliZFrAA8S00nGT7LQJkQ0QUgeg81CntAOz1azfE+T?=
 =?us-ascii?Q?o/YnC5fBagkx7bKuTCq/y3fcql53RjNBMFjt20QIDEjnpgLwOe7O7Q2xims/?=
 =?us-ascii?Q?p8JnG8SL8mwUxE2uSwy4THEpJos14umxZJZUoaeiFB3sApoTEblnvfTIQIiO?=
 =?us-ascii?Q?l9opDmFOaIqQp8mVvN5yAzLF9PWOe0Tzx5yW6AUQCr5mJQTJewKIXAND+GZ9?=
 =?us-ascii?Q?C3EN1osa75ySVbkbV7dYZlaAmkfxUILUWbPQ9ds/pFpQbJKfKOXhDfEk7jfr?=
 =?us-ascii?Q?Dmx8+st940yuMEo0ST+76YwgbBCM/0lpmm3SaOw7KsO32UdrmIzQ3jEzKc1P?=
 =?us-ascii?Q?omaybqSW11NOMD/gWvHtA1dXKrZEUYhmlCZ9jCEGlJxU6Q6uuOwe0hPY4WFE?=
 =?us-ascii?Q?618PI9j2oIOUEbUwhJfe//PLkdtQKsil4yJJbGyMVgn1t1HQie8YJYFQEUVU?=
 =?us-ascii?Q?DLbr1oOAPzB2vjun/q0LAcvNfHj6SoD0+6J2RNpifzmz2RQq/Zg9pAZHmLTp?=
 =?us-ascii?Q?XB+mSL2dZQ8R4ZtiAwlf/87AoazXm54gCd/scNXn+aAVCcnNXMZnomF58n9j?=
 =?us-ascii?Q?V+sYu6nfQE7bfI2TaAvzkdXmsZYGzX9NwD/LmSUb7QAnqQ4tyliyvADPym5p?=
 =?us-ascii?Q?9TK7Kqp9+l8WZoiSOGFEN5+7klmDZtaPvxGEIKCLmPFMfz12hndYQJsLoP/M?=
 =?us-ascii?Q?zQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa340d82-6c9f-4489-aa68-08ddae7e4654
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 15:39:13.0121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BppMqFmFPquI6oSk25ey5RpxbczhuEjyAe2IX6ON1d6cHwc0q+TO3mD7KvY8A6O4xdNWYxR4FwQ0nRKGyBJ0fYi+kyBnZDOEQIUej6OxTx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10775

This adds support for 4000000 as secondary baudrate.

This value is selected from device tree property "max-speed"
which is then used to download FW chunks, and as operational baudrate after
HCI initialization is done.

Earlier, the secondary baudrate was fixed to 3000000 in driver, but now
with "max-speed" property, this secondary baudrate can be set to
4000000.

The secondary baudrate is set by the driver by sending a vendor command
(3F 09) to the firmware, with secondary baudrate parameter, in
nxp_post_init().

Any other value set for max-speed other than 3000000 or 4000000 will
default to 3000000, which is supported by all legacy and new NXP chipsets.

This feature is applicable for all new V3 bootloader chips and w8987 V1
bootloader chip.

This property does not apply for w8997 compatible device, since it
downloads a helper.bin FW file that sets secondary baudrate as 3000000
only.

The switch to 4000000 baudrate is validated using a Saleae Logic Analyzer
and imx8m-mini with AW693 M.2 module.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v2: Change DT property to 'max-speed'. (Krzysztof)
    Add support for 4M baudrate to w8987. Update commit message.
(Sherry)
v3: Add check for 'max-speed' and set default to 3000000. (Sherry)
    Add functional and testing details in commit message. (Paul)
---
 drivers/bluetooth/btnxpuart.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 6b13feed06df..a9a53e6b35cb 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -73,7 +73,8 @@
 #define FW_AUTH_ENC		0xc0
 
 #define HCI_NXP_PRI_BAUDRATE	115200
-#define HCI_NXP_SEC_BAUDRATE	3000000
+#define HCI_NXP_SEC_BAUDRATE_3M	3000000
+#define HCI_NXP_SEC_BAUDRATE_4M	4000000
 
 #define MAX_FW_FILE_NAME_LEN    50
 
@@ -201,6 +202,7 @@ struct btnxpuart_dev {
 	u32 new_baudrate;
 	u32 current_baudrate;
 	u32 fw_init_baudrate;
+	u32 secondary_baudrate;
 	enum bootloader_param_change timeout_changed;
 	enum bootloader_param_change baudrate_changed;
 	bool helper_downloaded;
@@ -802,7 +804,10 @@ static bool nxp_fw_change_baudrate(struct hci_dev *hdev, u16 req_len)
 		nxpdev->fw_v3_offset_correction += req_len;
 	} else if (req_len == sizeof(uart_config)) {
 		uart_config.clkdiv.address = __cpu_to_le32(clkdivaddr);
-		uart_config.clkdiv.value = __cpu_to_le32(0x00c00000);
+		if (nxpdev->new_baudrate == HCI_NXP_SEC_BAUDRATE_4M)
+			uart_config.clkdiv.value = __cpu_to_le32(0x01000000);
+		else
+			uart_config.clkdiv.value = __cpu_to_le32(0x00c00000);
 		uart_config.uartdiv.address = __cpu_to_le32(uartdivaddr);
 		uart_config.uartdiv.value = __cpu_to_le32(1);
 		uart_config.mcr.address = __cpu_to_le32(uartmcraddr);
@@ -966,12 +971,13 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
 			goto free_skb;
 		}
 		if (nxpdev->baudrate_changed != changed) {
+			nxpdev->new_baudrate = nxpdev->secondary_baudrate;
 			if (nxp_fw_change_baudrate(hdev, len)) {
 				nxpdev->baudrate_changed = changed;
 				serdev_device_set_baudrate(nxpdev->serdev,
-							   HCI_NXP_SEC_BAUDRATE);
+							   nxpdev->secondary_baudrate);
 				serdev_device_set_flow_control(nxpdev->serdev, true);
-				nxpdev->current_baudrate = HCI_NXP_SEC_BAUDRATE;
+				nxpdev->current_baudrate = nxpdev->secondary_baudrate;
 			}
 			goto free_skb;
 		}
@@ -992,7 +998,7 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
 			nxpdev->helper_downloaded = true;
 			serdev_device_wait_until_sent(nxpdev->serdev, 0);
 			serdev_device_set_baudrate(nxpdev->serdev,
-						   HCI_NXP_SEC_BAUDRATE);
+						   HCI_NXP_SEC_BAUDRATE_3M);
 			serdev_device_set_flow_control(nxpdev->serdev, true);
 		} else {
 			clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
@@ -1216,12 +1222,13 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	if (nxpdev->baudrate_changed != changed) {
+		nxpdev->new_baudrate = nxpdev->secondary_baudrate;
 		if (nxp_fw_change_baudrate(hdev, len)) {
 			nxpdev->baudrate_changed = cmd_sent;
 			serdev_device_set_baudrate(nxpdev->serdev,
-						   HCI_NXP_SEC_BAUDRATE);
+						   nxpdev->secondary_baudrate);
 			serdev_device_set_flow_control(nxpdev->serdev, true);
-			nxpdev->current_baudrate = HCI_NXP_SEC_BAUDRATE;
+			nxpdev->current_baudrate = nxpdev->secondary_baudrate;
 		}
 		goto free_skb;
 	}
@@ -1447,8 +1454,8 @@ static int nxp_post_init(struct hci_dev *hdev)
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
 	struct ps_data *psdata = &nxpdev->psdata;
 
-	if (nxpdev->current_baudrate != HCI_NXP_SEC_BAUDRATE) {
-		nxpdev->new_baudrate = HCI_NXP_SEC_BAUDRATE;
+	if (nxpdev->current_baudrate != nxpdev->secondary_baudrate) {
+		nxpdev->new_baudrate = nxpdev->secondary_baudrate;
 		nxp_set_baudrate_cmd(hdev, NULL);
 	}
 	if (psdata->cur_h2c_wakeupmode != psdata->h2c_wakeupmode)
@@ -1773,6 +1780,13 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 	if (!nxpdev->fw_init_baudrate)
 		nxpdev->fw_init_baudrate = FW_INIT_BAUDRATE;
 
+	device_property_read_u32(&nxpdev->serdev->dev, "max-speed",
+				 &nxpdev->secondary_baudrate);
+	if (!nxpdev->secondary_baudrate ||
+	    (nxpdev->secondary_baudrate != HCI_NXP_SEC_BAUDRATE_3M &&
+	     nxpdev->secondary_baudrate != HCI_NXP_SEC_BAUDRATE_4M))
+		nxpdev->secondary_baudrate = HCI_NXP_SEC_BAUDRATE_3M;
+
 	set_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
 
 	crc8_populate_msb(crc8_table, POLYNOMIAL8);
-- 
2.34.1

