Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3061A1CB51B;
	Mon, 10 Mar 2025 12:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741608043; cv=fail; b=uiRa/YBi//tnsqXI63ExVy3n7oIPjgwnBy1g7v3x1R1lI0WJWDK55bUw7e3KxO0xCrL+jaBGhdXayGey+/HUmng6M5d4rAsyej4P+ND+i5dXaOr/eh2gvh+wBGUeeFhB9vIkaDR0RffKiCFTXBglmUNyp+j9gBgKdtvN+Us2L9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741608043; c=relaxed/simple;
	bh=SLj8M0GTizSsWuCTOyK7UQmEitIqD9Lo4lB7Ztvz4nI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=i6M/G6484cEDwoAXpNQJM2rGUFZtJe+reR6alm/eM9XnMdtl6tl1/obzUy9KF1crXfymOT7KQSxHmeEHefTJJHP8hTYwVv36Zu8zaPufrd2pZk5NZzeYKPQlkcm/h/3oD83m0wlJUaL5/GRGn0mx/lPEghJVpKhS8pLhB6LzIjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ccx9pWmz; arc=fail smtp.client-ip=40.107.20.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ccx9pWmz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2aPS+AVr/+TOoNixOM6pmX95W7IC6WPMpBx6Pp644akryr8051TbYn9iSzDIJCK498f7EDczdQrt1PUlBbnGateE7vDHzLdBhnC1uUMBAPMs0+yK4avTR1f/7OH7YQg2Dj8Rhq0V7VKJHZsuq40OhgVDFWyNYfqmJm3b5GGrpruOcRjlkpFAq+6GrqhY0ZInabMj3XIF32M+nE9XroE3QeI96AmvvsSulDrWw9RUaNTWDmdOQfIaAhjHs1uZ82Ju8BskYBXpBOi0a7BnQXIy0x+00IesG8AwDhKUX+gc0VZp9koovdN9UrVFDjATrqO2hkiZXEOjc5xRohQcFqFfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1JlQcPBLaQea88TTEEJBKUOn8Of4DA44cyUeOTK83k=;
 b=xLM/Rfitgmx+jJ1unZjhARH7cAEC66c0idclEg/DQyFqZuzNwPovQorCRfMbVXeANg69EuqywzoOnI5r1dlCpNBHorBubS7mbgtGHuR8Gth13T9RAOKMGU34+ahKobSjuEOz2IAGrFqGRGzExemehEIuhYCetTWtMeS2oeuHnxPiNQTHToydYdSd3IK+ykLXmgFaLRnYk7PERGyYlvyvezfQ0zIuUC8gcEMY+8KujPz1kaEEE+ztww7LdtuscYTtNb2X/9TYH7CFeHSfO27ZZjOWb4HCCXVczmTJqqhiQbINrUdLrt1cnNPLTnep6KB/NWZDdm2z39KGO04xF5tjpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1JlQcPBLaQea88TTEEJBKUOn8Of4DA44cyUeOTK83k=;
 b=ccx9pWmzNrRg9ObyqtGGLvjzqbW8iID7xdsuuT4c5TJNVEtXZ5jTYa84OQECIKV0yRCThElozDFXwnYfWlyuMrEjQdzaY9NPyFcD0/QtO1nMEyUnUCkn3Ma8Sx475Pee3/WMrHm/qlFcqqKmrTBW+qpDYyL1QekV2lVXaxfOxV0jKQVCVUx9wQ5vymwqMPkEkO+X5YEsDS/zeE33MLHJiycBLQrNCGbxR/FZ7BcWVNGUNQ9i6PbcyBrqZ+qG+uUwdHcTs0JNTgSqEXgee7AdK4FiZ53vgtllx1ciopUPjRIpoeIjm42zznUMxPp+BTn7XskbwR4bNwFcMR3npLlL9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9687.eurprd04.prod.outlook.com (2603:10a6:102:270::15)
 by PAXPR04MB9203.eurprd04.prod.outlook.com (2603:10a6:102:222::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Mon, 10 Mar
 2025 12:00:38 +0000
Received: from PA4PR04MB9687.eurprd04.prod.outlook.com
 ([fe80::742e:a5ac:15f4:116a]) by PA4PR04MB9687.eurprd04.prod.outlook.com
 ([fe80::742e:a5ac:15f4:116a%3]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 12:00:38 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: [PATCH v3 1/3] Bluetooth: btnxpuart: Add correct bootloader error codes
Date: Mon, 10 Mar 2025 17:32:29 +0530
Message-Id: <20250310120231.263174-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0240.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::15) To PA4PR04MB9687.eurprd04.prod.outlook.com
 (2603:10a6:102:270::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9687:EE_|PAXPR04MB9203:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b1e9ccd-18bf-4f1d-f525-08dd5fcb2b72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tHm/vxC1AS9nY9p/nEB1vxvsayQMJRtOR8++6LqlbSCEpMlFu/XoXa1n+axE?=
 =?us-ascii?Q?lyUWpuLKy7QdrPA1cKloxeDaa0Zt6PAU2pWjxlTiXLikCa2xVK08uYX2J82m?=
 =?us-ascii?Q?pgcvxZOo/S80y9Uh75skA/BB+fqvAcNYMJ+xbLWJroeEbwo33mHsSWLxASxy?=
 =?us-ascii?Q?jWexwHME9p4F5JBW4KVaoKOiUIR4tidqhkYWPuMKL/47sjLYCzj4w3eXafPi?=
 =?us-ascii?Q?1k3Y8VSOns/oKeq0Uk4QrDqXDQuFHVUpZ6Gqo3mLcSPlQphdqPdYBW/otd81?=
 =?us-ascii?Q?Qxb7TUoQ2j1P+uvJVgbUReYyD3a4YDdQ/kyPmHEBPYebcMszVXd5t5CVy4JY?=
 =?us-ascii?Q?Qp/7re0wr2uL8dv+2VPdiaP7k4ZIoMA7133EuPOw6y8R572xqFJUE3Q70K2V?=
 =?us-ascii?Q?bUOl++tqSq13b3i8wNjhwjUwJL4Gvsvc9JpPi1ywpMfjw4IPhHEI2Zt977Qa?=
 =?us-ascii?Q?AZq8ftHamwVgW8Ywo8pA6isTO8w4mWTArycg6N3hwFGXJwwngytkPsRY1tPa?=
 =?us-ascii?Q?fOkQT6GeFWxBngHMfzhJNAkgN99z7Mdd3ch+6kqjzfaQz4IXxr+gFPoNF41V?=
 =?us-ascii?Q?JL7T2y4z5dQh/7uzuJlbaZzXPr+UrP7oHV6OaZke+syS3Xu2AMbTZw9uv5I+?=
 =?us-ascii?Q?4yQkMFMahYe3NFtc4ILEEhg5ZANU/rFoZcDPmzDKz1QjrfEA4BLNpVaw3lQV?=
 =?us-ascii?Q?g6NfPwP9JhYQpMrddEkzmKNYtHyVW7N3XZr/E3EoSa9IGx3R9/LoG539EIUd?=
 =?us-ascii?Q?Av2OEoMnJbSbcyPewTXGYNeLg3EMTcIlOzyL3DlJYGlnFSYX4JxaPPdoiSNW?=
 =?us-ascii?Q?cxoD6F9djlFMl0aUemIWclXEq4MaTmVxEHvihF5WfKuI/3YnOgIXfQ5q++tI?=
 =?us-ascii?Q?sOVMb/J95kZKT9I+5dj+AHfu7ZDyANFa7Tj/ga+g1lJOTjFhnxHUQ5xLEWdZ?=
 =?us-ascii?Q?Ki/EmA0PVNKVjXU9V7LMvzd8lF5vwwk0AOuAOaprP7Vkr+FQ46Yf/R6PCxDX?=
 =?us-ascii?Q?y1nEdJxRdqR5m5WA3NSYupErTtHzwjEDd+Q/7RQUYx7i5svVOWBihGnazVGm?=
 =?us-ascii?Q?pLsSfORWiXLyQIZX2duQGDnhD/HReobY2j4YWuagjJKUmySU4q0DmepGZVpI?=
 =?us-ascii?Q?zb7KamLuRz1uPm2+HcRl/Lt87qmDtohyHtRqC3HjDiFZ0uzj7HdM9HZaucyW?=
 =?us-ascii?Q?KsjF9ZGQ6khJONf4AtCa1+skd01lGFDZyOfo1FNgf7A90sxDhwVtm7BNj6OE?=
 =?us-ascii?Q?HfLpfi1cUsrwAD2Qk9ENNvyDPQCIEr0mrmiTDYgAzz0R7o/Zs6YdkcMGt7Ok?=
 =?us-ascii?Q?nhwi69kHu4R6002uNWVh2KHcUzeu0fslNi42WGDUucJfcAXhUnS3U6xn2kd9?=
 =?us-ascii?Q?i+uRWr8vqc7v5pQlYJzzRT+Ew38OuSrIjppUdboXFiBg/VZkP+w0KA5Lkm3H?=
 =?us-ascii?Q?AH8vaj/AfWIB/Kkv5vuUkGweynckokPV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9687.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uQ1jDs5tUK6oepcb/OR8DkQ8IA1g7W3f39/4GP25G5lmMS9wLeFYBpnzNBy6?=
 =?us-ascii?Q?PBxhxWnjqwzhAiRaxt3DhKSGRBDU3MSdUMS8i3tqw1Wgjy06JnId74AWRWDA?=
 =?us-ascii?Q?l76zqM+Gqh9crzaC+9GRZ9nV7qOXA5xLPC4eAGaOyWhohQcabYHBNwqXLEB7?=
 =?us-ascii?Q?KmkODKz2g4XAh7CheN8Y1NVJmjmZZjFX0tBQ+udiS4dwsreWrBpmHnmAQE1E?=
 =?us-ascii?Q?WvWfieZ3VPrOaHvr7rep2Bh02tJpG33zzsTxUbeHnxONZ/s+a3lhj+1Wqjan?=
 =?us-ascii?Q?g89SA8pFOQT3D9fgqsS9q7g+V7xZMjR/cfZU3gEy+bt+Fxt79bmlNvZjDCQM?=
 =?us-ascii?Q?dAqla26s9PffATcInxHEWdFTeQslTPGDSKi2oXeLVOozm6FhoLJu/a5hrLN6?=
 =?us-ascii?Q?s5Y42MYSqETXQ1UHTJamS3AHd9hBd7ff0MI70aAsMFQ8e/4MXZtUpQjIaFBG?=
 =?us-ascii?Q?RnDuQFyMflkw6RDqoXMurID8CchxzoWEDB7bf6vLaEaJHlt2JPs26HgUi8WE?=
 =?us-ascii?Q?usgwqhNtDjduEuuCNO+/Wj8L0u9nc1n8OxIEFON13LbcRYBPONkkm7ES1SU5?=
 =?us-ascii?Q?fpQs/JklpvcwvVq0LJQHgA8vuf9YMbXQvtWBqOCWsQ5eFe3bd6XaTSXqA8Zs?=
 =?us-ascii?Q?d31pUiuCNGR6ld1EJEAhLVtkdCkMvHCwANHdR+viKd8sfzAxALQ4bSh7t4Ob?=
 =?us-ascii?Q?AitrVw2H/2mBujwlNGcEJKHPE33gH+LQv9tXsbR+vbelI4AXMCTOJbVrmLrB?=
 =?us-ascii?Q?NWkbgp+9dHwxMcokifmYDSH3SZz/8qPP5vp4OouP7LCgWOHLcp3pSedYSN3x?=
 =?us-ascii?Q?pBbswe3BuYageDTL+mqPtT4M/czTnIIgHe+I4q/zu/CW/+tIj+517nXsiJhu?=
 =?us-ascii?Q?C2Q3/cuv74gOffReAQlG7WpE9vkkWbOBPzlaJVZ1THY/KDyG5LgiqpciTyRg?=
 =?us-ascii?Q?P9kOX2Dzdv49VQikXht04eAaHzshbjHoBAhlKp+jEv4FFLnO9T17rfeZFN2e?=
 =?us-ascii?Q?EvEIfSv+NFdyEt6gWmaCP4Gk+ioVD+JiyFN9kJ5LIBDUujJWGVKpX7ORlgo4?=
 =?us-ascii?Q?umcsnKn9lPGeRhJJVC0g9jrE2cTv5+FECyyk1w2EyssmOlBamLFLfQfdL/ZB?=
 =?us-ascii?Q?psqbll2P7vU0vYkwIzzH8IanEUXRAV6T1JCpI4kPrp0jgU43rJMF4lDoMge4?=
 =?us-ascii?Q?FjkGhr5WDWzNbyRFymbbE08c2vO9MEmLmj4FMTMjq/npPeGv93HR88xfY9fy?=
 =?us-ascii?Q?O4b1PPwmmTW5/YaVQee0nrpLfghqTMS4m9JtHuc8C0oAotqRKgI+5pyma0p8?=
 =?us-ascii?Q?AZRF1S/dmrU85WRp7D7cSXvrd0mB6S0LIfkHwximN2TD/yBOMScGk411wEnp?=
 =?us-ascii?Q?odAqinVPcH+fSMV6fzfbqfNsKVyZsgPZnRIn+/HU4Rkm3BYLSJNDW5cUJ6tX?=
 =?us-ascii?Q?nIP8I+Az73CParQw6Szsh2gr+QEiZI45byWomo7ivKjtFjMI0kkNw+bZ0I0A?=
 =?us-ascii?Q?c9C7UvNmrIDjvyNrpNI2KlNecKPcEvCgTfA9VHF7K7gZlAW+h90KAfd3lHwU?=
 =?us-ascii?Q?OBx6RzTZYrQL+VNo9yLJnVmBRxmEX0V441EwX8B/m1RJRk2ZoaUou5XTnD3d?=
 =?us-ascii?Q?FA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b1e9ccd-18bf-4f1d-f525-08dd5fcb2b72
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9687.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 12:00:37.9550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dEfExviaUFQYt76lYAvUl5ATK174OKiQDGBAMpxI8Cq36kIGjJlsSZbtWJSDdv3JStDtfSzNZvuZ/tI5KWAdgCM3De7dJtjupSkFK602UK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9203

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
index 5c6904c803c8..67c2bd409b75 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -210,10 +210,11 @@ struct btnxpuart_dev {
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
 
@@ -316,6 +317,16 @@ union nxp_v3_rx_timeout_nak_u {
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
 /* FW dump */
 #define NXP_FW_DUMP_SIZE	(1024 * 1000)
 
@@ -1089,25 +1100,27 @@ static void nxp_handle_fw_download_error(struct hci_dev *hdev, struct v3_data_re
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

