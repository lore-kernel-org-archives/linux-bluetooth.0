Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010003.outbound.protection.outlook.com [52.101.69.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A17D306D26;
	Tue, 18 Nov 2025 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763475661; cv=fail; b=HRbUgppn/NAf9u8F8jsncLfxn/dtyd9MN+ToN0s7ZC5OOivWeqstuTnSPi9x3h1muIhT0keEADDwLPgpdSDCrmgM+ox852VTSfD65rlm4v7RhG2S4DjUMeMML0xeZJfWOI8xv0Dxq6rj4fD8GXw6ITggoGsbxP1ZYZLhBYWy4Rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763475661; c=relaxed/simple;
	bh=654OYUAgWR6OJWw/BECZeJCLow7fTG6883O92JcHXPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kLqFpeAz5/FSUWFqADMgzOSLV6dvz4zkVoDA+cfNABtvIscq+GBCNIHFizshXT8dk1dpDwisL+/fNW0bOBZ5BF+9uZmNS42Xoh1gC7V0HInNFvDX5cd6qdQjt+1NehEdVjkpY/9BVLVkI/VIdvEbvp1mhLUSJ1q0aFK6NjF70KQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MnarTOW/; arc=fail smtp.client-ip=52.101.69.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MnarTOW/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2KfQiQmyR15HWZt2y8G7fjTAcGiudwy1IjNe+NJije3K91/gPzR+JnrfRCIAdcjQExl4gqPZwsn+umljIla5n/gmHhmhy8bCBGbFSv542dLH9RSYR5GLGHP03gdHQBzo2KWoCKlW9yCkBeqdKwyAM4sUlaRakujtQpPLlpf6JWLx4vkI3PH9wxbUi2bkes0ZTmprFRmYp2G8ZHJ/Yk7aI8zDKr1Zi4fXqu88JAoOgechpTB1fVX/KDYF8LUGgQX0BkvtKa9QVRBSunthVas40wcnmEfRQXbqSwC2y/TTRWc2dsaNa4QMNIalFXT1diTVaqGR+6PlAUa+I6TcBqZbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AY5VDcRltYvwg9EDzcMfTBD0wpLN3Omw5pXEU5IIjmE=;
 b=hco2LcZ4iIGi9K3gJTZeENhi4TcOdhuGBk1i139kN2JVyyTFAHmi4pSdlDMZQhoZfe1zg5BswW2rC8QZ6iVWhp1JvNzP/815Eb5Amt5IBwLm//LrxcgYhkIPZYvGoVat1rOznTl8VDbGAebbhEULs6/+RrPBMIS8Q4/y+LW1cBgIvPAe5jTZ4I1IX1Z6Nv4DoGl6FTDeLep9u/gMsWUxmazvns9DyXdFu63grGknTEbY7mawI3SiFIh8fcY6PZjk21gt7NGVGLJaPL8vGNyw5ZNkxDK2VtofuV171MmhndIq39clQNUxEGPd4djR339NcmJBVm9l2DkhFqdu4WDxpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AY5VDcRltYvwg9EDzcMfTBD0wpLN3Omw5pXEU5IIjmE=;
 b=MnarTOW/L/XnYxfXUfjKLcFuso8MY5bXI977XQ2WoBWa0TQpyWFcVbi3qoQAddwObOk4TVaMRE/To8RdXH5XBUHWpH/PJ8w3IZDtcVobQr8O9FM75d8G3NKVqPmcHMnk89MZ7lh4ckE1mQKtYJa0NM7VbmWYl6F0s9JhC3o3Fy/7/xBFWzQOUi9gtRYbcc4FmbiIwwfex86OrmIZIoUqBlxuCqIjnqtm9dR1FQwnxaRIe20GxNQoWfx3t5GrYYDGtHYfaucryfJ64nV/iK3bCS7dg7N6SXp3SPoHGRJ7baQ+Q6027Tk0w0zHeVvHI933X1ZZfvyS0Fjg7mej1A7lGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by DB9PR04MB9284.eurprd04.prod.outlook.com (2603:10a6:10:36c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 14:20:51 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 14:20:51 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	sherry.sun@nxp.com,
	dmitrii.lebed@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: [PATCH v1 01/11] Bluetooth: btnxpuart: Add firmware metadata parsing for secure interface
Date: Tue, 18 Nov 2025 19:50:14 +0530
Message-ID: <20251118142025.1982263-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118142025.1982263-1-neeraj.sanjaykale@nxp.com>
References: <20251118142025.1982263-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0036.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::29) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|DB9PR04MB9284:EE_
X-MS-Office365-Filtering-Correlation-Id: cfc9a5ea-8c52-471b-c389-08de26adad2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P6tWn5ODzptHoLgC3s4fxLYThLjrED3L/sq4Wrw4ygElHinA/94L5k9GPAyc?=
 =?us-ascii?Q?kt8oo8LA8NSjru4Kpni5FcrRGxel9qjWK9hmH9/i5lFG339Jm+11uAksFpVT?=
 =?us-ascii?Q?dFn7VCDHqbj0VEfLrYAjSstnOoYYVlQltg71VxGwqeldZIkagefuRpj/9oPf?=
 =?us-ascii?Q?utg8uEe6YPE0OB0wmqnDZTDi8GKuh5VVAaTCvjpI+G3M+jHWYtOxHWVQOimp?=
 =?us-ascii?Q?SYbaCnyh4ouosJJr4UA89h/RWmXkTjMwXFOYbRsSyLN9OGM1858WakOMW+tQ?=
 =?us-ascii?Q?eH/mG0kbSbDC9E9lmyeFNWan7z7z3nfdy4atY4s2JON3JujyvUkec3YwkxrQ?=
 =?us-ascii?Q?xWCJtBDFx/UqoNpBroMV+ofnIsoMdqlH7nO9ohC1dG8G27yvG9vI6XpEZ4Q5?=
 =?us-ascii?Q?4tx0xbiaEqvIYSI1foC6PkG04XfMyMxvuXphO6BuK4TMCXajCEu8jd3P92Ou?=
 =?us-ascii?Q?/Zbgb16mnsCNSltD38s8hMgN97UQvlQChGcbWkDJHO/TskvhCboBFO+uUNjv?=
 =?us-ascii?Q?u2LPoie3ZOXPDlvuUCPyUJcFcT44A2m9N5kO4w+qef+xR5wSHiBMzzWDSxHC?=
 =?us-ascii?Q?aDALC4XzKBNS3/pS7M1PAxS2bZ4Mg16Mbowu3OAExE++TrSbUX9G5VcTTHiS?=
 =?us-ascii?Q?XixDnBwLBJV/WWgfkCWjb217+dKl4E6rGkIyoyMtosfytLWeim/qNM+0F45u?=
 =?us-ascii?Q?/wvovR3ZJRH4S4yucOesr8kP9jHo//Mk5nc3/P5yfBYy42HL5WV6TeU4K0q4?=
 =?us-ascii?Q?jHs748oatuYOJqZyiloFw2cr7vqo/l3kQAq13N/NWWARWCuZQgHj6iT8aPn3?=
 =?us-ascii?Q?kfUmSAKotDJRb4J6N6y1ByzjQ6FuKBAow8pHOZc78sIP/ZZIPIYeaN7DWsse?=
 =?us-ascii?Q?ZN9WdtMZb+ve/UaS+3AWWdcEOxLI3agRkmrh/TMvYBWCcSJ2s6jcY1fpL3YE?=
 =?us-ascii?Q?FIMj4LJjFQQdrQhgo7LjUZSDfyDSq1SmyrHBP9Ko6R1ugEPC8qqpNEcvC6/O?=
 =?us-ascii?Q?/SVAG0/f5NbSzTPEB2ajONvO2IQ0wrvJpv0Uoogms9pxkTkzCDM47cvmtpro?=
 =?us-ascii?Q?5GJ40JsvNSPtv8lYAXefYv4wXE521stPaHnQg/1xixeohhbLYrHmm7BjS850?=
 =?us-ascii?Q?BVxmNVUdmcdOEumO7w84v8uUFiIw8IRIbE8lqLG2CQBTyiiUYJo9vTc1B31r?=
 =?us-ascii?Q?/zKr5ItrTdZrbA+t1lcssZKN3OprYnYdfivIjhRLVL8Zz4n/DU8aYERrbD8l?=
 =?us-ascii?Q?jm1xhmVi1OoUGM5VcXiYaLlBrmevjOJ8xr+M2eASdwtEBWLX3GGyf1A1yim+?=
 =?us-ascii?Q?S/NGfSmRPYRxRFaJyMtZEma+ymnsvC/M2+bmFNLGBizwjMjd+QEJrlKfufrP?=
 =?us-ascii?Q?VUYZN5SJidDJlJJONfIEB9OBbaAEvx8vf3w2fwxua6mpQzWrvFn5+Jdt7WXL?=
 =?us-ascii?Q?Z6+rdIu6I1rp9eB3sktsFA/o3tZoQw9veVBTlWamKKUCEnTgdXAH5ly92B2/?=
 =?us-ascii?Q?J1JDPXHyaaJackVD9ev9RhGN9Vq/eIIkIvFN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NggpnjL9CK05emarXIVx/10EoONjDt5KgSjUSbAUrpoBmq/UR3WZCf/GsQ6/?=
 =?us-ascii?Q?M14nYk0cuzQQwsDZ2h5hT7vmpPHC+MSI6+pQtuPjOAQJ1jJYn7Do3Cdakd2V?=
 =?us-ascii?Q?OyuyIrF6NaRlxCo1NZv8hGyR+KGtEymSgKdZlxwZl8k/X4j9V3zWuYOp2fjl?=
 =?us-ascii?Q?YXpVej2ZFSW1UM572qao9FwBzoCS7kWFZv/7jNL4LDVpQdzvhz40r5Jl8jv/?=
 =?us-ascii?Q?neTvMVycCw0XhCIdQ2txOcpZeWsZHlCxrlrftsKLzckHN62zQk2xpHKKhweH?=
 =?us-ascii?Q?nBf3bQgaHnz2SvEI/GALcwao/2/LiGKRwFUQdJG2vukl2/epNAn2sf8iOPLW?=
 =?us-ascii?Q?i0voDckQJySPjfwcVm1zvG+BNJAaVKz7M4/UWTUKVG6rxUnhHEnz8dWNw+gV?=
 =?us-ascii?Q?doBs2OPwT2jFo+fVjnqcwZbvhPX8f2Zdy9zTCbhtochhB6qe6izSvqNbozZo?=
 =?us-ascii?Q?xVeaKK0KOtcgQJEukTKjcDbhQhZ8IWCdEB2zwiq3u6qVhwLE83iHtkosoKLe?=
 =?us-ascii?Q?l+0QgC/pQ1iMI1ok4XWdrelnl4upv0PbTXeN/gMWE8STxKD5zI3wwR0LzDwF?=
 =?us-ascii?Q?YzKdIKNfOKIc3eUZ/WY/N+DkNLISaccjIrNbvoiCDki6JTr/XZy46Jq4Tmbq?=
 =?us-ascii?Q?IC8DSgPTGOV1gAAfAr3umYJielsFCTmr49I9EkT8itJPu5XEQyVZvf+LmBjP?=
 =?us-ascii?Q?AXp10llSYyTX0o+m3eER9T645ZlqwwxbHoc9jnU4wuCjNZlqUqnOB9FqN1pn?=
 =?us-ascii?Q?dZTd1owPPT+ApQJDLy8amY5JAS4B6M3lOHYGCimvHFtGcmhqrLPrRxzjAwQ4?=
 =?us-ascii?Q?e/Q+FFmjl5oydQUgHzqk0oQvFqvY9jmP5gRE0Psevyu5PVjU8u7d99cO4fOT?=
 =?us-ascii?Q?BcpdKeiELx3C+bP6shPT7Y58IKbyp62rol6AUOizbcopdT2BWgUAPOuURdb2?=
 =?us-ascii?Q?x+WwZHXVSqJD+MmU/G2KNPCYSfYax3WXyE3fmV6TS4qK4/vIZbxIGeHhraUp?=
 =?us-ascii?Q?RmqtShzCDXtPZRkFhcQz9zlYVchISFGU7YQLH7hpED+FzgamQjE4XUeqP7vs?=
 =?us-ascii?Q?fOZeVx0Y+Bm+Gu430XmCtyjs319LJ9aaxsxjxuVAy9H5ZwM9OrWXvIHGAJP7?=
 =?us-ascii?Q?M6Ofj8ePuAaCRaoTbNrCzCdc/VOih/plHVfYlFMVa+TcrnAK3UQNeVbjNbKF?=
 =?us-ascii?Q?XcDZk3pr+Ky0hervQQRwj97N0ReKnfmMzu+C5cINVev/saHnhS7UCihK1GcK?=
 =?us-ascii?Q?9Y67B46zhHc+51IArl2rEnbPv+OVP/jKpSkd8VOHqwb8RxXtoMW+7/vLqe7c?=
 =?us-ascii?Q?evyuYuqHQKXhaXnZmuXLX59taSIPr7a4oIsjlQ5AwcDismWn1ofN+89zPImN?=
 =?us-ascii?Q?L7f4oRStzIaxb2PL3ZvMtg1ReHZTFLnWqt6jy2boWqU36sivSCvYWO8EJgK4?=
 =?us-ascii?Q?4KEOa9fEV8GF7477OuvfMHYwnobdvBiy51cuWkFskwhkQNgzcEw2UaRJhvIT?=
 =?us-ascii?Q?VAn/tHy29awCQNf1O6nfitBfgUZeM8WpEd1B3dASIsoFbYcelCJky2S3KO/w?=
 =?us-ascii?Q?oZdL3f4qyIONZB08Ph/fiP/XQBE8rnFDLXuzqw8Kfi1rA+jofsq7xVBfcrj2?=
 =?us-ascii?Q?Tg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc9a5ea-8c52-471b-c389-08de26adad2b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 14:20:51.2695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j0ceffgbp75/Oi+G2BEGdstxXYrDyp3G+U0s260FzAbCjCJ+fVsYMgaWFFy2VNno3hl8ksJcv2hv8JjnmFQx1h4eTyOa24ac0kWCGczcdPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9284

This adds support for parsing firmware metadata TLVs to extract FW UUID and
ECDSA Public Key from FW metadata for secure interface authentication.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 133 ++++++++++++++++++++++++++++++++--
 1 file changed, 125 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 3b1e9224e965..3f94ca18a225 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -15,6 +15,7 @@
 #include <linux/string.h>
 #include <linux/crc8.h>
 #include <linux/crc32.h>
+#include <linux/math.h>
 #include <linux/string_helpers.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of_irq.h>
@@ -134,6 +135,14 @@
 #define BT_CTRL_WAKEUP_METHOD_EXT_BREAK 0x04
 #define BT_CTRL_WAKEUP_METHOD_RTS       0x05
 
+/* FW Metadata */
+#define FW_METADATA_TLV_UUID		0x40
+#define FW_METADATA_TLV_ECDSA_KEY	0x50
+#define FW_METADATA_FLAG_BT		0x02
+
+#define NXP_FW_UUID_SIZE           16
+#define NXP_FW_ECDSA_PUBKEY_SIZE   65
+
 struct ps_data {
 	u8    target_ps_mode;	/* ps mode to be set */
 	u8    cur_psmode;	/* current ps_mode */
@@ -180,6 +189,11 @@ enum bootloader_param_change {
 	changed
 };
 
+struct btnxpuart_crypto {
+	u8 ecdsa_public[NXP_FW_ECDSA_PUBKEY_SIZE];	/* ECDSA public key, Authentication*/
+	u8 fw_uuid[NXP_FW_UUID_SIZE];
+};
+
 struct btnxpuart_dev {
 	struct hci_dev *hdev;
 	struct serdev_device *serdev;
@@ -213,6 +227,7 @@ struct btnxpuart_dev {
 	struct btnxpuart_data *nxp_data;
 	struct reset_control *pdn;
 	struct hci_uart hu;
+	struct btnxpuart_crypto crypto;
 };
 
 #define NXP_V1_FW_REQ_PKT	0xa5
@@ -362,6 +377,26 @@ union nxp_set_bd_addr_payload {
 	u8 buf[8];
 };
 
+/* FW Meta Data */
+struct fw_metadata_hdr {
+	__le32 cmd;
+	__le32 addr;
+	__le32 len;
+	__le32 crc;
+};
+
+struct fw_metadata_tail {
+	__le32 len;
+	u8 magic[8];
+	__le32 crc;
+};
+
+struct fw_metadata_tlv {
+	__le16 id;
+	__le16 flag;
+	__le32 len;
+};
+
 static u8 crc8_table[CRC8_TABLE_SIZE];
 
 /* Default configurations */
@@ -1190,6 +1225,85 @@ static void nxp_handle_fw_download_error(struct hci_dev *hdev, struct v3_data_re
 	}
 }
 
+static u32 nxp_process_fw_metadata_tlv(struct hci_dev *hdev, char **payload)
+{
+	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct fw_metadata_tlv *tlv = (struct fw_metadata_tlv *)(*payload);
+	u32 ret = sizeof(*tlv) + le32_to_cpu(tlv->len);
+
+	/* Process only BT specific metadata TLVs */
+	if (!(le16_to_cpu(tlv->flag) & FW_METADATA_FLAG_BT))
+		goto align_and_return;
+
+	switch (le16_to_cpu(tlv->id)) {
+	case FW_METADATA_TLV_UUID:
+		if (le32_to_cpu(tlv->len) == NXP_FW_UUID_SIZE)
+			memcpy(nxpdev->crypto.fw_uuid,
+				*payload + sizeof(*tlv), NXP_FW_UUID_SIZE);
+		break;
+	case FW_METADATA_TLV_ECDSA_KEY:
+		if (le32_to_cpu(tlv->len) == NXP_FW_ECDSA_PUBKEY_SIZE)
+			memcpy(nxpdev->crypto.ecdsa_public,
+				*payload + sizeof(*tlv), NXP_FW_ECDSA_PUBKEY_SIZE);
+		break;
+	default:
+		bt_dev_err(hdev, "Unknown metadata TLV ID: 0x%x", le16_to_cpu(tlv->id));
+		break;
+	}
+
+align_and_return:
+	/* Align the pointer to 4 byte structure alignment */
+	ret = round_up(ret, 4);
+	*payload += ret;
+
+	return ret;
+}
+
+static void nxp_process_fw_meta_data(struct hci_dev *hdev, const struct firmware *fw)
+{
+	const char *metamagc = "metamagc";
+	struct fw_metadata_hdr *hdr = NULL;
+	struct fw_metadata_tail *tail;
+	u32 hdr_crc = 0;
+	u32 payload_crc = 0;
+	char *payload;
+	u32 payload_len = 0;
+
+	/* FW metadata should contain at least header and tail */
+	if (fw->size < (sizeof(*hdr) + sizeof(*tail)))
+		return;
+
+	tail = (struct fw_metadata_tail *)&fw->data[fw->size - sizeof(*tail)];
+
+	/* If tail doesn't contain the string "metamagc", this is invalid FW metadata */
+	if (memcmp(metamagc, tail->magic, strlen(metamagc)))
+		return;
+
+	hdr = (struct fw_metadata_hdr *)&fw->data[fw->size -
+						  sizeof(*tail) -
+						  tail->len];
+
+	/* If metadata header isn't cmd24, this is invalid FW metadata */
+	if (le32_to_cpu(hdr->cmd) != 24)
+		return;
+
+	/* If header CRC doesn't match, this is invalid FW metadata */
+	hdr_crc = crc32_be(0, (u8 *)hdr, offsetof(struct fw_metadata_hdr, crc));
+	if (hdr_crc != hdr->crc)
+		return;
+
+	/* If payload CRC doesn't match, this is invalid FW metadata */
+	payload = (u8 *)hdr  + sizeof(*hdr);
+	payload_crc = crc32_be(0, payload, hdr->len - 4);
+	if (payload_crc != tail->crc)
+		return;
+
+	payload_len = hdr->len - sizeof(*tail);
+
+	while (payload_len > sizeof(struct fw_metadata_tlv))
+		payload_len -= nxp_process_fw_metadata_tlv(hdev, &payload);
+}
+
 static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
@@ -1248,14 +1362,6 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 		goto free_skb;
 	}
 
-	if (req->len == 0) {
-		bt_dev_info(hdev, "FW Download Complete: %zu bytes",
-			   nxpdev->fw->size);
-		clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
-		wake_up_interruptible(&nxpdev->fw_dnld_done_wait_q);
-		goto free_skb;
-	}
-
 	offset = __le32_to_cpu(req->offset);
 	if (offset < nxpdev->fw_v3_offset_correction) {
 		/* This scenario should ideally never occur. But if it ever does,
@@ -1267,6 +1373,17 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	nxpdev->fw_dnld_v3_offset = offset - nxpdev->fw_v3_offset_correction;
+
+	if (req->len == 0) {
+		if (nxpdev->fw_dnld_v3_offset < nxpdev->fw->size)
+			nxp_process_fw_meta_data(hdev, nxpdev->fw);
+		bt_dev_info(hdev, "FW Download Complete: %u bytes.",
+			   req->offset - nxpdev->fw_v3_offset_correction);
+		clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
+		wake_up_interruptible(&nxpdev->fw_dnld_done_wait_q);
+		goto free_skb;
+	}
+
 	serdev_device_write_buf(nxpdev->serdev, nxpdev->fw->data +
 				nxpdev->fw_dnld_v3_offset, len);
 
-- 
2.43.0

