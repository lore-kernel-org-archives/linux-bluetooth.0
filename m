Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96B626FD99;
	Thu,  6 Mar 2025 18:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741284466; cv=fail; b=FBLlEofkiGkwSbjn1AsLz3w0rxAE/zkXbImCGxT5E84BwXNVcMt9AYi2fg2/PyosILTrUcgLUyiwo7zE1v7IoiW3iZU+kPGR9GFewq/uTz9xtMsN7k9uYx0mpCO0WN4cZ+95JfFaNEY0P4ClVfTFdmw/yN5g6iOyMI/W82uUs9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741284466; c=relaxed/simple;
	bh=1/jR9CYISle8eUo4WHf9ycLSTcDJYf+Ly+Gn3OEJzZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bZw+Q3sTUhRMzJHvfoQy9v6LwB5QxLx6KdbAU1bkYFVluaAfLGS647yCfQ0+DZY8vxAVS3XowaCjvWhyA3z0wBFaao+Vjcna4HKMpN5rcdd7OZbAJDtPu8Bm6vRT6aQz0fr6cHbh0hjzih0a1465q9b0hPONxbP57uAI7gyRKmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RvcFUeYn; arc=fail smtp.client-ip=40.107.22.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RvcFUeYn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CptSelw/AsK4HjSopZrg0cnlwTVG9YpNIMdlANo8e8Boe49PO/OpZogG+vM9ncSGrQzaSHM46bNmwSOOHtIUtyNmMHh0QDgJqLPDGFrabKYCYaHBKjTE8ACGnUAdhdXdxn4RGhGjj1KJCzsEfslCwQW/iSo/zYHuCegirPJ4tBb1+0QKQfc9a1/e6T+jCQNxMRenZ7pnkBATd0LVZl7PuFegObWP8UwszKGVgDTxOwSZPZgZmtEvKPy5H4qIJuupi7N3t2T5pQDUEorjERvYVOrsJgXFeXa7vQ57syF6plgPeUtY4J+wrJN4lsLJFpEQNbbLiQhloFEN24+cxcnynQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XirvluISeAskvpLn4Zp9T7aOtGLrRQbthOjlybDRx7k=;
 b=IAGap9jZCD6IgyONIGvH0sGtjf3o4rxzVvv7BzSUrn0Z0+oY/tdZTRq5Z9bRWx00qWHa8lCEuz8cOU+Ng/ddXrxM/15ojCV8jZKI8qfQYShkr1+JEVxmTSztGYtdYUGWhUZAbJYoIdnQPT67yNzCeAatG4+ulCWtITspFt4FMQ/Cx1htC44beO2bsNzijsjuJGulFvtaoRPfWfyaH/sdClsPnujBTJMLbnUzRjXr5HvpKy6XLGcV8RgCSxpISQvENmMgOMVjxq7d5Y02bk/pWr6AhupAEFz+Ph1aLOdbccJLvdvtxcGATJrr8wN/129clVYATrSLQL5JpFfiqqDtsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XirvluISeAskvpLn4Zp9T7aOtGLrRQbthOjlybDRx7k=;
 b=RvcFUeYnWQILRIdWVIUuaH7yeOuvsZ+7mnlYmFZLa0XcOuDPpxnQp/PBDA4UfLmbSOlQVgMb0R2Zz5XyRcZQjNevKM/6QsZevlm5PH9V2MF/JUGaF+s0DPwldydYcMmToaMfvKgFzzQuGLkpLqB23MdaHUpyGH47js+an3U8o7oDV1je6mEGzEmw9IssFEYYZ4pEYRB7zwSAX5+BOqWgYC8NuESxvkyttXIY9zchvp1Jd+BjeNLPpph95uVdnN1l5+V3hOwo28iOxYq74AL42e2E8b8FpOWdlvgDRf+zeUbprYdnQ503SpwImU8rRRZEatuzDqdu84I4P3cs/txuPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PA1PR04MB10603.eurprd04.prod.outlook.com (2603:10a6:102:484::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 18:07:41 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 18:07:41 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: [PATCH v2 1/3] Bluetooth: btnxpuart: Add correct bootloader error codes
Date: Thu,  6 Mar 2025 23:39:29 +0530
Message-Id: <20250306180931.57705-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|PA1PR04MB10603:EE_
X-MS-Office365-Filtering-Correlation-Id: 85ebf39a-b517-46ce-c77e-08dd5cd9c938
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3ZNERO+zxGersm5E6B3HfltvR4DmzwxFW221KvkZHflLScH8FGTxK1T7cXpO?=
 =?us-ascii?Q?VQ1WYeASA5RO3LZZCdGf4gMSZdS55FZYMXfHRvwWMRdXEwfjdcp2JLOFeOr4?=
 =?us-ascii?Q?A6rAYOltYvjH5UxJ7LSe5iysBQdMSosA50m0NrLVwZQRpnY6Qdenp8SeMpk0?=
 =?us-ascii?Q?B3tCzBDt5ZRRwU0VZ5fMjQxnL9ACOJzaPaYdLZYKiYVlLWdR34ElDWBOQu3B?=
 =?us-ascii?Q?umqMgpA1fpFcbt7SgvJaJiLh51zqltSwBMd79aSQWJJaqXLHN3LAq6kU+3JU?=
 =?us-ascii?Q?/zRBjwgMYAPcZRVcx7zFr46utSc7KKL7yLISFeuoVmzcQ7h2SsOvLJd19W51?=
 =?us-ascii?Q?lLpdNVagAU6CmnH4z6eWh1OPKU9MPxrulm4gRguIiGjjOl7zqMPJxROjHe+3?=
 =?us-ascii?Q?37USJGGyJ9SjpWDvB2dtdI8TRwg0loBjkvF8cyxpMNbkFpzvra5sBvufDtXo?=
 =?us-ascii?Q?RWhIXVHt7SxwWgbnJMO4RvbmHunJbwuSsyr+tjsvz8YTGWNOH2zY3hkh/w+5?=
 =?us-ascii?Q?/LHF/Nldr3AsPtQ7pHJEjEolz6pvdOXI/3PdiVSvf1V5328y/QCD36LAo3CR?=
 =?us-ascii?Q?f/Qk/l1ISJfituqqOhZXi49jb/tPi0zAkSx7vjzquCw8TZ90ITM2E+mV8lJ4?=
 =?us-ascii?Q?sSC1d6oDb4U+wIYodsKTfYGEa9+YjV1WYFQybdU9bndY5Tl0SrfBQseFFuLt?=
 =?us-ascii?Q?m5OO+uWB8WtZF0sRmMTBDT89gYiv+cMPyNV34Dnfa/RpjRFJak7Vzavm9nXe?=
 =?us-ascii?Q?pm8kSegKH9J7UargUEX0eqaXcpIn00jCp69qyeF0WnR/3EPGNPZ5+QLMATwd?=
 =?us-ascii?Q?9kVitBDBv/RiMmwtqIEF32MCkg7E/IF10OhJj310MuYzKhSv4qz4aFP2wop8?=
 =?us-ascii?Q?1SI9D8n4QnY5djq7+Np+wYtJOo8v1J0NV+HIXvsffUFNkcfljWcAw0LvrOB8?=
 =?us-ascii?Q?QdeODoqxPqzAIGPopPrpbvTVMw+NTHhOLUboE5abqhGKulzVRrEiU0B1jFUQ?=
 =?us-ascii?Q?Je4e4dSpp+a5MYpUA0uU33nloOA2mqztQ0jeh6NEUQsRo4H5D3tVJyGqZU1f?=
 =?us-ascii?Q?HWdaPQYOR60DvAZXLKmDNVpa3cdrPAeLFzWlKhFP5Qd6NtTzatCOz/iw+fky?=
 =?us-ascii?Q?tknf0BkxtazyyIuo4a+dliYctXAKSAYLhSSNh/xxof9B1G2/HAdGwKB59Zrz?=
 =?us-ascii?Q?3iI7slbPBGInMSwItu6jt9fYiFSWD7nE2TSI3/TFDcxfvly6FkOdd3d8mgva?=
 =?us-ascii?Q?T8k5bre1jp5vXmBue2MmtDec2+VbtlcgfQR3yQ3db0hQLmuohAIfXEcqkmMt?=
 =?us-ascii?Q?klvljQohK2JRMEJO+teQFiMQJ2PuIGTu1XFArtHvW2e+xnHNhRl7oAifcj47?=
 =?us-ascii?Q?9wZnix4W3yapQfO9sfwZcjN3h3BeAhgft/tfoAIoN2IJ5bxW3mk1ntDC+0dr?=
 =?us-ascii?Q?HpEB7h8yvpVTwIAm+7DnmKhVbYDr2Mbp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9cpRjVoyNpDVg2jPVWN35skebW34q2F2rPO6frR0/Lsy0v2vL9KOSeZPklBV?=
 =?us-ascii?Q?1+UkjdTd84UIYNPWwtsUS52j1N+/FjWtNYDc6cTPQq3q+2PkqFBAFgI2dQFp?=
 =?us-ascii?Q?8fal4B8ZRoYdq+pS+PEkWKbPzGGWAZfDHq9YaRNl3qP+p2Wtt7XEK1z8Qc/n?=
 =?us-ascii?Q?Ff3hbF7yM0tFXCPRtpJXZPfEWZj/kCXaCNOw95MXkvfjvpRO9oT33NLCCU82?=
 =?us-ascii?Q?3EVlVqxIBnDeyOD/EMFIGfRpMHuVcrruuD/fwUOLOL0tFDJvK+RsufXX4wP6?=
 =?us-ascii?Q?5jvXB50liV9K4C1K4kqqsw1glr2dM0f2MIXWt48TE12RbC+uAy0mkUR7pmxR?=
 =?us-ascii?Q?1ihGv3DWVrZD5uTwBa8mmFNUZgLcFyXW3wFc73smgxDzV7VoyH0IKlVnEIHL?=
 =?us-ascii?Q?wAWojxPhYZYzy3bBgPhMeWzn/qVseJ8xG/O197GxzXszhzEZm9CxkQ3uxP75?=
 =?us-ascii?Q?FARwyNcBZY15fahd90yftwzDQsTicaCWgssiMjIDYHOupP/0QmtHTBYZDTWD?=
 =?us-ascii?Q?2vXBYtmiWXNUrWeIjpT+2mnCxGNvLh0J4YsnBplNF1FVjM+aDbR3fkXq2Ft9?=
 =?us-ascii?Q?y5MsgLfcsdvrlZOwQ4y52JXZTECjjiHHHtF+iKMBo+LcKCJYP/Hjn5hsAU2f?=
 =?us-ascii?Q?YV2B0bTcK9AYT+yQkMn0Rn1bnyhx/h7RswJ7qaTft5KfwGo+aMLU4wUflmbS?=
 =?us-ascii?Q?tHW6mNR7azBSAsflhnmC51QZMyad4dw3kRC+vgharjuV3ZMY0FPwDwwDYRpe?=
 =?us-ascii?Q?4TT6FJTSwK8ay1Wf8WKXMs70+Rsad26tcwe4XTagjuBzCxSPleF8BHixA0k2?=
 =?us-ascii?Q?w+WG7E2R5OA3a8XdmH7mW9lshcPf2tF/PdPNOzUCeKGIXrQKVDkBmmG1ci5s?=
 =?us-ascii?Q?Knh8KRFbv3U0gttjVwAzHCleM8CEUJwsLtnkCbjKeDaLtZx7XOaFCIjX4Zs2?=
 =?us-ascii?Q?SMiRhkqTdE+w8ZOFfpgRICyTS76YRi2fTmD1YDlECnDOPeChHp9uhqYJYH3C?=
 =?us-ascii?Q?T7aMM7UcjYoJpDJdM2i6O2rnWsth6b9X+Qoc6Q54Fe4vpg5bExx/BK71W9of?=
 =?us-ascii?Q?XuIXdDnCfbESjmeJ0GnmoveFXLdXRaL4QKabLqDzYeqzIWWBgZcnyu2qFEnJ?=
 =?us-ascii?Q?HxUm3OZt03tPKuYFwCn44f4UyCGUz49zuocQGx/z2PgdamwBsFeqGf1ibSA5?=
 =?us-ascii?Q?oSNlmKcsmxJfV6QZKEQCi0D6TJ2WL6dRhFy1dI67imETtF3h34R3/C+ry3mo?=
 =?us-ascii?Q?LGYChRv7kyyI6j/Sifos+NzJnbAni+tFJukk3a6vrtuLcPGrm0TH4C+K/S2C?=
 =?us-ascii?Q?tSk2yyMQPTGKHEsYCDpOULHmvAb3KhbVX+PHE8MTjmzH2Zx/Czgy8KPviluH?=
 =?us-ascii?Q?Q48Bmfpg2HTYOXbKYdr+kB1D++Cqg8A8qUlvVoUpkGTGywec3VQ+hoC8u6nY?=
 =?us-ascii?Q?OYHQomEBgjbE9QpDSoNALLrA1rRnBBuDhfrAVcJnzozWvYHxF9Q8CfwsMagm?=
 =?us-ascii?Q?JwBWo4qzmwn0xRXC3u+lwXFS6H8MyVsz6lv0GKEyxgZqnVwfgaBc+U9squHD?=
 =?us-ascii?Q?88BezrYMM2z9tUrr82BCIjFYiNyxr06WSl3W1gQsPyA3G1W3E165K9sRp2tN?=
 =?us-ascii?Q?Ag=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ebf39a-b517-46ce-c77e-08dd5cd9c938
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 18:07:41.2018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oaodfj/uXVhh4cH95Ji6NB7Lh2QybMgPmAwVfym59Z6m9uz8E2o38yVbAeEAPUYswhFPPmpLvPuomPBfkhs9S4DnQaUL6BlekCb90N1UjG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10603

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

