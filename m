Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013045.outbound.protection.outlook.com [40.107.162.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCA7226533;
	Mon, 10 Mar 2025 10:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741602262; cv=fail; b=dotsD/QqPUqcPAY6deSV/pE6c0MAuhDWk7H1q9Xu0bhy7tShGDVtOzxPU3cT03nFRMqFDerR9OvccYNVXs8bcf3IYaNbjchneZhy2ZPewFH7DkCOwwuP8g6B86HBLIdzqjed/ybDJGzlwO9bx6DDGsi1PS4MRYe2F21aYTKuO+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741602262; c=relaxed/simple;
	bh=1/jR9CYISle8eUo4WHf9ycLSTcDJYf+Ly+Gn3OEJzZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Q5qU3CRgREJCzzMGo7dk2P1vcBQoBi5U/lyQmLJH7P6og0SgwuFinWtlyxx8YzZo0e8iqtZMozwz+YPASbcXlwxFEuww2TQvUUXKHgvPvDBzdral+REPPYfZf4AvVZYHc673qeF28YNl/p2KbEPsAZZI9O15qsDR0osAY9Fx8m8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HceX6XQ0; arc=fail smtp.client-ip=40.107.162.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HceX6XQ0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mhGSr6ECEcAvF1EiUnCkm2fUFdi1C+PAsC2olhtEO79TPgqwENNUu+WybeAAskvM4NejSTF+6YyDzYgRycqBKgSvzYXQBl+CSa9iwy9eXc8kNRuAtwtwDzZZKUin9MWXnjfk6qPRp+icOocjFJ16TspmXOMz/nCxOLKojgBMaVAgrNbebwCmPWblfUMXixzPCcEWvzzGQQ9TBszwq0RltwsfVAu1LddVdz7fXeJZ0FyUJGYaXc/3BcnpIehFX1IlZ+eQt4hGql/ABNzQydBShsytnSlXV6IrhuXIlHVykTaaeUlefK8mzwYQgVvgNE2G92tIb6lQzYkJEeNM8n2keg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XirvluISeAskvpLn4Zp9T7aOtGLrRQbthOjlybDRx7k=;
 b=SSMhOjUR8VoJwLMvYYBomThC/dI/JFP1+QKUNFGAdpHQzdMANeSNnikQmOlg9k5ZRnMsoJ1x1oA9SICR3diGWDMn8PqnIufNSK/GpG5HFVNwLgzj4PzhAzXhpRq6EA/0370LQ8rACtHLRgJH3s2a04NWAWDoelirr1B3Atlk3pYWnMYCJidUsnpa163SWlkl6ti1FrzSyNTyjVRGfVyMPYSkOYc5JuyoKs1yYFpM5cEZ7oWKj1GswaFv6N2xp62T0mlFI0/6n87WscF0FdGnXaQWkUSxLYScBBQrYj84VsrES1IpxVdArUJYo6GSLwEAoGJwLr4NJfxxoW1AOxj29g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XirvluISeAskvpLn4Zp9T7aOtGLrRQbthOjlybDRx7k=;
 b=HceX6XQ0syiraIr6aqD2e0F10Crc2pd3+J7slUKPVrBdNngUcJK4SUQbgBqHdBvtGlCAQ2OQqqdANRjCosokfeLxjihxWu6Kcbd4F66ax8EvAwkeDifrI2ndNyfT484pS30IY1qY0nrL9TUfkcWpAQmVW5Jqj8iihfuy87cVye5ED5zURz0+Qm4A9VgtS6U78EGEFYDxjX9Ero17P8rVO+K8xBKClnJzPY/JL7uX6/jHiwnyQZ+vX/8FOr/gmujfP8lSHmtRQNmyJsV+xB2G1IzC+DEV8d1FShnMaapoznejHcj4aWv+svpJ8GBQyA+NFtiRkHxlz7clbE406b8KQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by DB9PR04MB9234.eurprd04.prod.outlook.com (2603:10a6:10:372::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 10:24:17 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 10:24:16 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: [PATCH v3 1/3] Bluetooth: btnxpuart: Add correct bootloader error codes
Date: Mon, 10 Mar 2025 15:56:11 +0530
Message-Id: <20250310102613.261996-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0016.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::26) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|DB9PR04MB9234:EE_
X-MS-Office365-Filtering-Correlation-Id: dfab4e3b-8b72-4644-fc0c-08dd5fbdb62c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JYXVTCzxYDnwXoQ4TJPVODodlu2Hd4u0eTVwE4KQ3HdiR979wgfjymL2Wb1S?=
 =?us-ascii?Q?Uw7ESerySW2p1ewC92koWyJ8kAgw80oFqB8T5BsBxFtUwiwsx3SAq5r0evsP?=
 =?us-ascii?Q?LY2M0aUiDqZD5wH6lslDMcqGfRHk/Adi/91JJi7qFqkX+ZPKM7pj7TDjG5cs?=
 =?us-ascii?Q?EE3RZvdk+Kx4l+36uJQxfafTO3c/pmnKVkfOtLyxzNgUxjhsdx3JkHw6muDa?=
 =?us-ascii?Q?vpahg6+8xQpp4GlMmlIi+HmPGvrtm4gTOX1G+0y5v8BNuS3pYZKDHul5wCrr?=
 =?us-ascii?Q?1FGeDO+/yj7Jup2/tShtBDUeqB4agodVJHvWxljx6mzogm2eafSOrp1TBOsE?=
 =?us-ascii?Q?lvuEpgduni9EE0mLveuCC53ONuf8W9I4ItyAoHbeLIyoNL8fMxSWFkR5vKRv?=
 =?us-ascii?Q?pfdhfqDFgd7ci7WwSp6f7h/v2zazjYX13T0/ruB5HQigE7bmMn1LG/4zyOz2?=
 =?us-ascii?Q?rC+kiN31HGTigHfbPNdJNnAF/OImQtbq5HxCqDrp65kmupD2Vw+lwqN1Q/K0?=
 =?us-ascii?Q?Li2/R20JAuU+YFUPsNvtDnP1ID7CNPbExSAocGW1GtHYg/VqO+CF0oIbLToQ?=
 =?us-ascii?Q?TQkFy0N2MR/UxV44t27bTY6DbPIZ/O/keHCq9eYoftw6y7L8cn0eAvSz2G8C?=
 =?us-ascii?Q?AFJTls8iDMdfKKwSh/k0/E5C4N+wia1atwgqR+33FFXP2eeYxmmOOtUyBPvm?=
 =?us-ascii?Q?vWINzhSnt0VaZpytAqf3PyHFxA8my5APrhhLSI+5kBRNXihfIANZ/pEpuLL3?=
 =?us-ascii?Q?MW/iJUPy7xt43ncZnL3jTiR6iSYauKC8drxbrJg68VTM4WluR0MECG4BoWDe?=
 =?us-ascii?Q?pug8fVuc7qtdfkgDhCFKb7nMTk4lhjac5/eltBCdQfR/TTg3OUDHZVUZ0t8C?=
 =?us-ascii?Q?+2knYriIKewf1Asrb+9gwuzElnR36dHRIK5Fn0wWAm3NpO9I/W1O+r7ydkPd?=
 =?us-ascii?Q?tm4uBSAUC20fHhiUdWVVVWIG7B7S1zxEI/iSDrjuI8QBSL7u4aBZRNVCkiTN?=
 =?us-ascii?Q?aWtgHvgeppjDlRjKF+wpgliZTmmZjl6PMLsNgPoGViAxV1vsSoQpzS49qD8i?=
 =?us-ascii?Q?K0SBbITGGtqh89/X9z0GmHnXdx9oGSFkYnVn3zl6LbbdYrKAo1g9fXo52KTp?=
 =?us-ascii?Q?GHU9WQYjwlRxrD/H2XM8AHlZOx/yXjuY5dHfYpZvwFIoE5DRxtXx4MbAtLVc?=
 =?us-ascii?Q?+NCg1d5M4Ae6DzZIC1Swlq0GKXU07R1O5zinT0yh0HHziv1FJggtZmqa//1N?=
 =?us-ascii?Q?2wvtXTtdpKxhF+SaYNISjO7R3Vy6Pr1WAQN9uLWSP00RrV06h4eFtcWmbhd4?=
 =?us-ascii?Q?lecXYtMB5kF71HwUIdjGMsi0AwYfpiuYBa00g0X4F0MSwA4mU9AiHn6QjeSe?=
 =?us-ascii?Q?T00rPJ9RYYRHdQj2367DttN5QKvcYEhBDC0OiHRZZCExDXC+h0pbBB31Swqo?=
 =?us-ascii?Q?NmrBxgM0boycRelv/KrkMJ16Ayj4tFyS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8wDkevdJfFpGHzELhtvoDW41mgZGYom175tWHiKjGqgNxLm7F3qs7TceLftb?=
 =?us-ascii?Q?QuSjOvwiWmfZVuPjivcxxD0hMVpVZTlksaKaakGCVeCKbw0dwlfEWHwffwX+?=
 =?us-ascii?Q?LXC7DBA02VnixpJ0x1NbnhiWkGy10YPLaKBqOH1qv8zUleOZ9kOI9ICK/k5D?=
 =?us-ascii?Q?bi6kYmG9/VrqQUdElg2IebfL/jN+B3osmvE/4OuSNODfn6lGjuQxx7Fs61fF?=
 =?us-ascii?Q?i0e2FdcYOGcVHd/531JAm4J14IVuQZcRGEt3rAJdq8sApTLhTbxNvQouvWFt?=
 =?us-ascii?Q?js0CIEJCIUQtY/AuKcZFFvyZmA30nHpgl2jMreN0jvFNhk9Sh7cASlnpg3UF?=
 =?us-ascii?Q?3seiLDFuEOmutMnp2PfMmJFZj2KC6OP9Kp4t1szhv1z+V3JO0bDY7XmtwKFh?=
 =?us-ascii?Q?DJ+faxfclfO/Ejo8sVHyW1DtiHJDEX2S7fURK48kVFfPSEg5/n3CMu6R/ak0?=
 =?us-ascii?Q?+ZoiXTR+tdTMLZTOAG32jouXHK/a+y280uy4jtqRlWmQy6PiPWDPxHOm6hJW?=
 =?us-ascii?Q?ZPI7ITFtCY8zL4u3+5ycgFRBVRqeIBXLdXbCdzhSwx2RYXjSLi1CkxXb44TF?=
 =?us-ascii?Q?xLsijyhUA/cwgTRzY0gFxaviVtMDxeO4DTfTk9GWgE9HgyKwP5h9wWFd41eP?=
 =?us-ascii?Q?fjQI3wX/D2YtJeZLJJEprsG8t1pMoCag/x2Po/kGzBAYSjq/WJXcZeTZWY3f?=
 =?us-ascii?Q?xa7/QyoWJ0bEt2RTAfa8J/i5IRs4XtI9LXmSHu6Nfn3RQhO41AahhN1TCdDg?=
 =?us-ascii?Q?JyMK6UZCmbTbODjB8gRIwmKcToOabcERLxz/Td4Eqj4LljFIm6b8fjBrWfp0?=
 =?us-ascii?Q?EGO+Is4vF3B+1FAg8OUhZ87Js1alOXwKs4yzM9hNfaAfAngfzQ+Y0a0CCsDq?=
 =?us-ascii?Q?VCrw3OE8Aiq9g1wmTbyrVSA0Ld8l/4D1EfdUfgVq5S7gueSiKF+9IaBtDkUg?=
 =?us-ascii?Q?DeW9U0qws4pzmz7+jloTH2my5exxyoHnS6YvQGBqbYc259T4pQmwX8eH/UnV?=
 =?us-ascii?Q?gJD3U8fkm3T3NV8nwnsubZWCq0tN0q/skKeAUoBNCBF65/ox8VYgpY8/Good?=
 =?us-ascii?Q?eJixnBpaXWSbTsWTC5GU+bq/vJcUtj7v8KmXRT2mTBdsd6Ghz5NSbYs/I8Wq?=
 =?us-ascii?Q?DlVINl/dj19xfyb3U7ST/BOaozygEZs1XiDYk5FJr6aVnGvcBbGdidqQzFAm?=
 =?us-ascii?Q?RMfu/JFP63u7Nu87A04APfKqwhbmsastIAQ3YJ9nikElgyoXt6tHdLPC6/ZM?=
 =?us-ascii?Q?V5vEqUBgadP2mU29ZyOB6zJ4RB5u5GfvDIaW50ETC0g3W0OsKy6IYso8hOXX?=
 =?us-ascii?Q?pyXzr4UgXtKVfbN/csTAG/71DClf+dLQngvMs0DCIOV8U6uO8evfr+wqlKO1?=
 =?us-ascii?Q?NqwfSn06EPx1ObYG7EF4Ws+iNRKVjaFlYk0lQR8n2SPlU4GJB8Pj429w6wfS?=
 =?us-ascii?Q?ZPzmqBgAhEaxWBM9yVg9vWgf6UYwhuHg29v1+vWV3LybFLqHifRInwTtMfiT?=
 =?us-ascii?Q?Jb52h9ez4LCzv7tDC2VenAW3/SZLOqvgUYmAlkHf/A49GxRhSDORNxK1BFyF?=
 =?us-ascii?Q?N+6we4lQcjVmCh7SoxWvDWtaUCtF3w8OGX9TYjIyFnII/l+N0nPujHS1bp2+?=
 =?us-ascii?Q?Mw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfab4e3b-8b72-4644-fc0c-08dd5fbdb62c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 10:24:16.9299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hSj6A/hdSVinYExf9tWSPcyqB+Kp2x5qIk2ObgsPsHbZI2rENsBuC42uhpMNkAM1PZY4g16xSWiQLDAjbiFMV6z8Q3Rtuuvugi9p40AvdLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9234

This corrects the bootloader error codes for NXP chipsets.
Since we have a common handling for all error codes, there is no backward
compatibility issue.
Added error handling for CRC error code in V3 bootloader signature.

Fixes: 27489364299a ("Bluetooth: btnxpuart: Add handling for boot-signature timeout errors")
Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 57 +++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 22 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 021983686cb3..b8a00bf062e2 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -204,10 +204,11 @@ struct btnxpuart_dev {
 #define NXP_NAK_V3		0x7b
 #define NXP_CRC_ERROR_V3	0x7c
 
-/* Bootloader signature error codes */
-#define NXP_ACK_RX_TIMEOUT	0x0002	/* ACK not received from host */
-#define NXP_HDR_RX_TIMEOUT	0x0003	/* FW Header chunk not received */
-#define NXP_DATA_RX_TIMEOUT	0x0004	/* FW Data chunk not received */
+/* Bootloader signature error codes: Refer AN12820 from nxp.com */
+#define NXP_CRC_RX_ERROR	BIT(0)	/* CRC error in previous packet */
+#define NXP_ACK_RX_TIMEOUT	BIT(2)	/* ACK not received from host */
+#define NXP_HDR_RX_TIMEOUT	BIT(3)	/* FW Header chunk not received */
+#define NXP_DATA_RX_TIMEOUT	BIT(4)	/* FW Data chunk not received */
 
 #define HDR_LEN			16
 
@@ -310,6 +311,16 @@ union nxp_v3_rx_timeout_nak_u {
 	u8 buf[6];
 };
 
+struct nxp_v3_crc_nak {
+	u8 nak;
+	u8 crc;
+} __packed;
+
+union nxp_v3_crc_nak_u {
+	struct nxp_v3_crc_nak pkt;
+	u8 buf[2];
+};
+
 static u8 crc8_table[CRC8_TABLE_SIZE];
 
 /* Default configurations */
@@ -1059,25 +1070,27 @@ static void nxp_handle_fw_download_error(struct hci_dev *hdev, struct v3_data_re
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
 	__u32 offset = __le32_to_cpu(req->offset);
 	__u16 err = __le16_to_cpu(req->error);
-	union nxp_v3_rx_timeout_nak_u nak_tx_buf;
-
-	switch (err) {
-	case NXP_ACK_RX_TIMEOUT:
-	case NXP_HDR_RX_TIMEOUT:
-	case NXP_DATA_RX_TIMEOUT:
-		nak_tx_buf.pkt.nak = NXP_NAK_V3;
-		nak_tx_buf.pkt.offset = __cpu_to_le32(offset);
-		nak_tx_buf.pkt.crc = crc8(crc8_table, nak_tx_buf.buf,
-				      sizeof(nak_tx_buf) - 1, 0xff);
-		serdev_device_write_buf(nxpdev->serdev, nak_tx_buf.buf,
-					sizeof(nak_tx_buf));
-		break;
-	default:
-		bt_dev_dbg(hdev, "Unknown bootloader error code: %d", err);
-		break;
-
+	union nxp_v3_rx_timeout_nak_u timeout_nak_buf;
+	union nxp_v3_crc_nak_u crc_nak_buf;
+
+	if (err & NXP_CRC_RX_ERROR) {
+		crc_nak_buf.pkt.nak = NXP_CRC_ERROR_V3;
+		crc_nak_buf.pkt.crc = crc8(crc8_table, crc_nak_buf.buf,
+					   sizeof(crc_nak_buf) - 1, 0xff);
+		serdev_device_write_buf(nxpdev->serdev, crc_nak_buf.buf,
+					sizeof(crc_nak_buf));
+	} else if (err & NXP_ACK_RX_TIMEOUT ||
+		   err & NXP_HDR_RX_TIMEOUT ||
+		   err & NXP_DATA_RX_TIMEOUT) {
+		timeout_nak_buf.pkt.nak = NXP_NAK_V3;
+		timeout_nak_buf.pkt.offset = __cpu_to_le32(offset);
+		timeout_nak_buf.pkt.crc = crc8(crc8_table, timeout_nak_buf.buf,
+					       sizeof(timeout_nak_buf) - 1, 0xff);
+		serdev_device_write_buf(nxpdev->serdev, timeout_nak_buf.buf,
+					sizeof(timeout_nak_buf));
+	} else {
+		bt_dev_err(hdev, "Unknown bootloader error code: %d", err);
 	}
-
 }
 
 static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
-- 
2.25.1

