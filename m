Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012038.outbound.protection.outlook.com [52.101.66.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CED824A07E;
	Wed,  5 Mar 2025 13:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741182255; cv=fail; b=hrtC+TUiXZ8ozvOJOfUzIjrnNWHgPhy0/Tp5i/Ks0qSXZq5DMBpBXBaxNgnUBFGf2t+flwJ0/PtAn/jewzCJjUdq0e1CBHxEvjeTk/+qKOLCy6AKNCOSCjfx4cHcPPrQUMG/VqJ+GC+pUeRYJh42uwMV6xuvJUpPwiMviS566y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741182255; c=relaxed/simple;
	bh=1/jR9CYISle8eUo4WHf9ycLSTcDJYf+Ly+Gn3OEJzZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GDP9BP+eFlEdfKKyDI0+mhZIXgjx9BS0u8/4frsgodi8rh0xiEzs67KEGI9uGlwx6wnAptb85kCr3ttNTSUdN/cNykkYkPBnzF++fPKPhJguMFWMV7TMO2rzVFlczyWsOWpjkpSibow6WdrZoI75Z3IDK/WDqpDx7845RgDabVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hWNtlI5h; arc=fail smtp.client-ip=52.101.66.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hWNtlI5h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BFPq4Dkv01yCr7pG2PkQRptu+T2fneNPgO9gdFGz+SjuM5Iiq9Qbs6sxBOgT8acdsB1pkDBm02q57+AeW1SdVK/jsVjG8v+aAqurIsoxekg73UsrnmoJgK5ruvfc3hCvB3ZsXsvE1gfza5Iq64XEdgr/c4kA/gvoSoGOMFfdGt2Q7fk2hYuYX19VBTSgAaYhY2R3CDzQWqvAPcu40tq44lb2ka4VF2kqNrRNzH/vFFJFV+U+FaDWUXoulI5XOjg6oNqVvsKHYbELXkFb6CNvconcaqTR9MW80ZbgRY151tciMrWai2ovNcAH9PFftpuCpIXXbwN92uZArPiiu7/o+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XirvluISeAskvpLn4Zp9T7aOtGLrRQbthOjlybDRx7k=;
 b=qW16Ww4Yn6czk5OAmLmWg6y3VK3d4kuYxiPJ6lOElsB09dbiv1l8bYmNDbPBSf2lEataWKUog4BaiuTxMiVT27oXQp3RwOVVZrSQsOCMAHSsZfhnitsbVBiRNzS0z5qirLPWBWVfSa7hj47EHX0O6YrE06CD8W3SfrIOCstbGJ3VYJZgD4ZLnRd7JLyuIwWqbOcTR4g2P6w7B305e/UMSRQBsdHrHj48EfOJC83TxAM1E1fCSe6YrrxdmsnRSDam5yQ3PytWc6Zqg4m0l/PGyJwy0PGi5doa2eBysN25sTTl/PTJL7jR9Sx9DnGnsbrxrghP/iJBxhDlt9pMeRQjeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XirvluISeAskvpLn4Zp9T7aOtGLrRQbthOjlybDRx7k=;
 b=hWNtlI5h1Z9YYuKCQZKvQMDmEsSezdQHoQhGM7OWBZRs3zd5wvi11Z51QOPY7kemjPvo39W8g/QUrEjOFlY01ATuwoJZyZLIRIXCl/JKe3k6rnsw/S2VUjc2QOOR8Dv826/CqUlqBlE5inqbgxZYwcfneU4S59N8Ysura++nMhNG6qlfeeIUVvMubf8xADA3y+7tIvLlR65gXHmFFFhymJgSawanv7ZxIRLxm3nBFCWf6tYZEUX1Ye1TWgBtzmAcibSTqjBEhTW2DIZP/5bC3gKt9I+cQKpLj1asCw2NFX0ALL8mupdThqlA8howkQCMIRJDCwY1wTfRO4bNN1Fccw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by GV1PR04MB10965.eurprd04.prod.outlook.com (2603:10a6:150:207::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 13:44:10 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 13:44:09 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: [PATCH v1 1/3] Bluetooth: btnxpuart: Add correct bootloader error codes
Date: Wed,  5 Mar 2025 19:15:21 +0530
Message-Id: <20250305134523.40111-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0141.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::21) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|GV1PR04MB10965:EE_
X-MS-Office365-Filtering-Correlation-Id: 23ec7988-aba6-46d7-2ef2-08dd5bebce58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?he9m9j6/iOxIc3w42CkArbhuJZ7p6WOdhB41Sbdy71pfLqs2k1S7AwFYrpRT?=
 =?us-ascii?Q?h9GEpZ4rP4t5JUkiLWEVZSYxSgtr0+qLYDFBU5nrAeUHWrhuV3Ijb10qLn7k?=
 =?us-ascii?Q?JqnxrebAnlRtg39DGKSUJnTC2zXFaqiJft51qsPGuPip9huHmgB0M5cf6HWu?=
 =?us-ascii?Q?wqJAWejnJe1Y2SETFWm+Bvebbu5rIqKw4rrAGvWoZt+ZegsfrKVX+Mf+mSOu?=
 =?us-ascii?Q?5uJU5fdv3n3BthfyPXoYcsywqjJIgWT9UZMaIOjRsC2eZtyCpeBIPnBQEg2q?=
 =?us-ascii?Q?cf+UfQnRckBTMheifhsOECds/sp+5j/Pob4bJFg1YgTpwj0W5VmwHoAPWs9H?=
 =?us-ascii?Q?IzsNWsD5fHxrqHQZrL98QIeOhiGEL/VPJxfZSfmtkfF71zuUz6FQbXtaA0dq?=
 =?us-ascii?Q?zLXCOxKW/B1pur3fas4WUlC9zQj6HF0NjrJ8QhRm3nsS6PqqgyUqqwrPVhjR?=
 =?us-ascii?Q?+vrFzinI1e31GrxVygUWN0DIUkOP/x4BK+CWJx7YSB7FRZJZ2pYAw7nUwZvE?=
 =?us-ascii?Q?+ZG54HmgRGLisR6vm1jMGiMVvZQwujPyIQLRPOovKVQPvqR+X7K7QZciVo04?=
 =?us-ascii?Q?NTRfl51AuTMmtPSbtpf+QHkjSO/rNEP/WIaoDKXVhZifJzoKw7ukZHLiUxqz?=
 =?us-ascii?Q?83YqSivct9i+UVc6TGNogR9Qt3u+miVzqQEY+D3lE94lgHNC4uIf9eIbhb3j?=
 =?us-ascii?Q?YRDDnQ6VJGpxDxem+zhD7FMIrBHDLq8JMQR/eIZmZcLiHhv0SRvGyk3VavXg?=
 =?us-ascii?Q?vb/g0QDzkAU51x0EjHi389jXQrZ+0onG8bXv1W9Itqlmlnqf/X7a6BgEqSjs?=
 =?us-ascii?Q?t7zN7yVXmKw86BuNL3xOelqsdm81OFThsLTfP2eKy3HHOTC3Hd8cJh3xdsWG?=
 =?us-ascii?Q?f4frm251vvZnYt3Eh3uSnaknUd5YHE80wANpb+93hzTwTOOGnBVxt6qCNs3V?=
 =?us-ascii?Q?IUNUXPWx4dEC+eljKaY2HORkUszwl+cRl2plJJabOpJUxr4wqLNT6b5o4Pd9?=
 =?us-ascii?Q?PRCALGp06itRuAcDaJ+svqZH90RcGuO0m67Qu7JUxA/ZNJL0PmvPitFIisa7?=
 =?us-ascii?Q?4vCwBq/Y5bKAutfvpkzd+y877aoAnat49ZrOMxPLealOx7iLanAX0Th74kpW?=
 =?us-ascii?Q?dOVtDGq5KEhU53db7JgfUpqB0wkyKju038xBhDZZQdZ/BgaPhozZP9D8x3I6?=
 =?us-ascii?Q?32KsKyHHAzWtDt5suicttudqXEwPPGfCfEHniHg/a/st+eKgJ92szOuJrtvR?=
 =?us-ascii?Q?sopICqejDAbgZs5XqTJcVxClWBYe7kRe0lJgSEm0Zd/gBoJrhCqLkmxU6yiZ?=
 =?us-ascii?Q?BLMJ7CKel6d+nOspVQtvvsgCq65t5O9YjLJuqcwlUNhKGKYu59r7kWmdzDVB?=
 =?us-ascii?Q?wIeDEJzNs75W/SQlbPD7NvSnSC/xMILGHj+83kdFZAyK+P+tvofjLJnjKFt5?=
 =?us-ascii?Q?AXMznzvhInm48ZfSfJOuineXadjOQAgX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Iqof/E9M21/EZMPW8j1nebLDOnQckRJshx8EjYN/CVAykRQ+KcjbtwFPZShW?=
 =?us-ascii?Q?NpKjveyirNxAnv6gMgjnxYzLButwdG3reX88xEgJBByufeafWZLtjQDJxhEX?=
 =?us-ascii?Q?IWYFi9nQlWsWSFneLPhuo0unlAq6jFTSewugO05t9vdz4Q6WejvLhBS+7G1D?=
 =?us-ascii?Q?Eo3xDIggPjRNuk9pJnlx+DGc6KNvptzghhf+gDbnMVxYsAX0Gzq2zpUZ6LjM?=
 =?us-ascii?Q?SGCdP71LjhBo4d3aipVynaf0rCVsG0mesYCBbV+MhgD5hoIibU4wAhExPr3w?=
 =?us-ascii?Q?hEWSQ0cGs1hpcMuiZoxlE1g0U5M0s1Bd0IiYB7K4nGOUwf94noOd9awjVfos?=
 =?us-ascii?Q?295J0W1RVyoUtOMVZmXJEzRTuldYsqZopFTd5aQMVl6YDF41MVKBBUHDnAtj?=
 =?us-ascii?Q?qCH24tjykreCgiDobt5Dk6/LlHZJqwJAW2l9q4UKIGjJW6WKvQn3N4P+9lMa?=
 =?us-ascii?Q?Rm3W9MCZDC3hmBoloXnNdyyvdalfvumazSZq0GWcSQH5egBQsNZePlF4f5zR?=
 =?us-ascii?Q?09mgUxYWsS/8hhYsxt9wxHemnllu5hogJowBuyhCTGAY4DiGCpLnAw/cuKyy?=
 =?us-ascii?Q?M60E2/P4eTcianRXE1zD1uZuofR1+jPZd8VHsLv2C4D8jpXkQzlr9yeRuNhh?=
 =?us-ascii?Q?EhzrP6TA4o3rJExp3QpvnDyBtbZxKCmnsH3EaNd4sV3LFSeiuUEFavmIOpiI?=
 =?us-ascii?Q?hgxZJzMUJBGpwlhWXpfeCh7bZtQYeMAGpFTm0BSRNfT8bmRdP5VXjYYEHDzy?=
 =?us-ascii?Q?B8+/4SSE9WJjEegekTN8Sbo2HsbxhJej2pkn3KYW8u3ykzLxGcvkA5DLLJeg?=
 =?us-ascii?Q?6Dibo/eNNS/chx+/VybVoaghjrY2VrnkQqf3gxAJvvUn6i4KxlRKSa0nU51f?=
 =?us-ascii?Q?2ZHaz3QafUtk+7lAFR/gVQ5WVFHImktdA5wXDyIW7RkGseiRDSj9KmlDbvfK?=
 =?us-ascii?Q?EYbGpIbaYVYkmhfMT7Dls6ffVrRmeNFzlpOAxyMJ7AneNDWHBU3m4nKS9RUP?=
 =?us-ascii?Q?20e5g2wbRG9epcA5oES6+dG6u3W+t8Vj7UQelfGxxPZBzsEgF0EX2K5KHnG3?=
 =?us-ascii?Q?emyUk6YrOI67G6jq65W8h5+fxTuYH+hYkaXyB8w/UfSkCWWXcjLfROQKW7al?=
 =?us-ascii?Q?cspVefT5y3vpkYmz/N83AkzczodIu6KyolF3OltYP5z1tJxl81RpLzdTmayu?=
 =?us-ascii?Q?cF3OTKlD7cEooIe7l2FCgZh4smQdORi9tf4y5k47QorFN5hjaLYnz3BohIj9?=
 =?us-ascii?Q?hC/U+EQk8D2r4lXD/dLrYafrbNvQYhAvAt4rWIVB9zqBcXt+yaNiIcx/R1T5?=
 =?us-ascii?Q?opQCdGbwPFMYCn/gc4Mxb16f78R6tppAgwZSDxmMtvNpUIMNkJgtpX44l+KK?=
 =?us-ascii?Q?fCF04LkquhNe/JwX5Ynm/fOR4UHwmpVwTN4iUfwchNuNbR3elAflO/qu/lyQ?=
 =?us-ascii?Q?Sc0JqcDO7gS3RKHG1BHbg0uwuLjUn+C7oyLJhxdVF8wVwIEsIUb5xks9skID?=
 =?us-ascii?Q?OIB8A0OWWJfytPft+yw0lc5aOXYz3NyEegKHAHf80axq6T41q65tSAc2hZpn?=
 =?us-ascii?Q?l42bCfonBmti6s0jGtqZOO1ZJy/81YFDqx76QtE8mNKC3il2dOQtTI+u62gB?=
 =?us-ascii?Q?aw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ec7988-aba6-46d7-2ef2-08dd5bebce58
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 13:44:09.6425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1G2uw0bqiSi0Cze95XkyIZOh9VkWYmwppnWPCjeVjJrKfDVMANkdRcllYqovRyhopzK+vFh0FaQJrd4X7NQPZI5Q5AN0Yofu/uZYXpr6WJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10965

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

