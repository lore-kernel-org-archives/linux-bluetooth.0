Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011057.outbound.protection.outlook.com [52.101.65.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB683043C1;
	Fri, 28 Nov 2025 09:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764321346; cv=fail; b=FdQYORt1CCZHFtqIctQzRYBk2ZjlP+0VS8qCOJsBj//hfqtITQp4tHbN9rXvgLoMN1TtyDWCbUa/mtUsUOglmqPknRsmI7GGZ2YL3oJ9egVdn89Z4vwlJ6jn1NMGoOCxh8cEkt1Obdyz5NsAFDpnREgLvLeVev1hhRxDhQXGdKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764321346; c=relaxed/simple;
	bh=kuW6D77+qQAlG7p9fmOjlK5DM8ij1Ty2Fgov5zgcUs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eZjWC417EYwlGSx6J4IWzziRGdzAUDyvk/KT0ie5/SIhjcfxBmMt41A4a8D1Z8qFIftx9BlSy08DDo5lf5UF44AN8GwACQNGj6WKaf0NggtfeL8+TlKRA1raQrnOIIux1FBlKWE7SfbInWYjVsIajvfUAzNpVC09Pmv86x5ZoX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DTf95gE+; arc=fail smtp.client-ip=52.101.65.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DTf95gE+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtPif8+TD2CSU8GJICBHpBG8J5xTuh73Wu7x9H7QtXFwAnxM8fTHMOvr+gcMSQuC09U+oArztXeDEN4Bm/noGV2NHiluVNCYO2wwVODBjNGsueuupYEFzHet/B1laB8tq+IGF20c+g/wVwoadSFb9YvPVb2j1G7jExaEjHOWqsTX1xDO8wb1YpTdyqnisVea6DU01Rv/kRVS3bxDDZbk/n7Ri0WVqxyspNAEt1lf7mO6IlatHVCRbo+9Rzd1rK2gdLg4m+Qv/t58+2I+J+jLZl7BaQN8SuyLSISeaLK40F3lYoHhRLp+xgERvdbiiXfgZdavOD59YzSnZGHcmGfbMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Hv+RQnhYmcKQmQwtxr1nHWT5U1rIu5dXRon8Kc573E=;
 b=MBBR8Gf6NqKiUK3yYHiM7Aq6Mc7BUqEkLqhzb+GMSGLtcRI/MwrwY72ML+H96WcqdGy4PfqoXkq1MIzA1sSrFG/7gToPRGGU4nN/k3KTW0GL9L/A4BuJMpiEPSkSCUkk7YEkAhhlg6Iq/NVgTeedD9VJ+xaUFWNZlnf3FevN99C/oXbgA5RxHHBkLMRKRQ4BOI/+0O6nXWqsmD/w8+KgX/OKuCyypzvqYc5zw79ydRO2EUbNGy+c/VZ4Xt6y8Jf4FrYuWe6x7GV4SFRb14CxSecEP6khJy5qwblWM23b49GxiBgCko2Em1HnowBHDDAUlicHB/Qsan0xt4JEu1Ey0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Hv+RQnhYmcKQmQwtxr1nHWT5U1rIu5dXRon8Kc573E=;
 b=DTf95gE+lZZupa+2Gs0u2Wl4zSj2C8p1mi3NgDW+GmSmLaNcPXt7tIkO3Ofl5gKefL9f2rNeyDpuoa2yiPorCB71OrEjqFZ+n/0glJKANLcgkddAGqHRIlcktTIBLcqh55qLcCCxOl+pfXee4jh204Z5qBTz+yCHod2trMogjVOWWgAzNEZi0aUjEqmpKkK1FANw50YX6tm7MjP4ZJE2MS2W3fe8RDhgg8Ud0Fzs9TOUc/N3RRmsJxBGoXxoVmaFzJPcYzyIel0jo/2kuzXRo7tu1zBpf8Ka+Jkw/1cw3+NI9Nu3etfvUeRZwPcheIYlFpydIqRWZiELXpIpdP52OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9676.eurprd04.prod.outlook.com (2603:10a6:10:308::13)
 by DB9PR04MB8252.eurprd04.prod.outlook.com (2603:10a6:10:24d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 28 Nov
 2025 09:15:42 +0000
Received: from DB9PR04MB9676.eurprd04.prod.outlook.com
 ([fe80::97c:438a:2968:465d]) by DB9PR04MB9676.eurprd04.prod.outlook.com
 ([fe80::97c:438a:2968:465d%4]) with mapi id 15.20.9366.009; Fri, 28 Nov 2025
 09:15:42 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	sherry.sun@nxp.com,
	dmitrii.lebed@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: [PATCH v2 05/11] Bluetooth: btnxpuart: Add TLS host hello handshake implementation
Date: Fri, 28 Nov 2025 14:44:37 +0530
Message-ID: <20251128091443.2797316-6-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251128091443.2797316-1-neeraj.sanjaykale@nxp.com>
References: <20251128091443.2797316-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::11) To DB9PR04MB9676.eurprd04.prod.outlook.com
 (2603:10a6:10:308::13)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9676:EE_|DB9PR04MB8252:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f8c9433-e015-4cd2-765a-08de2e5eb3f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?onOP7s8JO8iAf/FhQTVDfkKNbUjXjtbAEB03RtZej7PEt8Bb+I/Xh7oMeXf5?=
 =?us-ascii?Q?+QF68JCpUvqsr3SN6m6bN+IHsSnkL0zvx9SgoZzAf+zmFq9sf0bdzbExBdpg?=
 =?us-ascii?Q?t0KlOKM7ct5jPYXuJpj25paW3oDa8Q5sLxP0m2jjq6ggYDrHdk87OsqN7aMh?=
 =?us-ascii?Q?pJZC3WehTX/EsLjIvWOdchWxLpdg+abPtGwk1UOiJEtMCtCWVk0ACzeBH9kN?=
 =?us-ascii?Q?ns863jiAATU17+JzEQ6CqUZ3Trapz/WNsTzEUC/OBCEnHcgbLv0RT90oJbOP?=
 =?us-ascii?Q?Rzsy/WvLcbxOVJPcKV0GVe2qMvFie7glbLMpkTT6V7WAIs3TEKWpOeihsdOH?=
 =?us-ascii?Q?QAhcdNJX7//yDpGHsgny9rIEvay1vfzjzyYCYaZyxuT7xbGOzENjOCK3/Ivm?=
 =?us-ascii?Q?0GKoCRo7vfZCTIQ5VHvvs86qypt18b0Wg+DL+Z4lp+r7Vmq5MKwZUAyeHAhJ?=
 =?us-ascii?Q?7mPPOHbOfcyRGZmSVXZ8y5Adnwzv4G/m7IHh+dlGjLs3RNN3pCHKn+cl7GtN?=
 =?us-ascii?Q?5LZ631Jq3S0t9kQSrkLBy22twQjnCnM1JEYIwc0HAxgIf7uCghHwRRq5iapI?=
 =?us-ascii?Q?8vJ1+cwlKeCTbC46n3kTgx/pOkGULdAzdmEyAopzutz1b0x+2fdQE01qjHpX?=
 =?us-ascii?Q?djGu2zYq9wMwKTDRcsO3c8/q3AB7bPQIqOWho8z8m/IWeNHtE/i31Q2RUpuT?=
 =?us-ascii?Q?oSln3kShJ5QQbvWi0VGg5Jt6UmWfKgNDclPPOFGMmqovdDQH/qTu6vls35LN?=
 =?us-ascii?Q?CSOXVc8lqDeONTw74AoftnIsLExGYzvVMvniTIJUrgrWW8nVX0wnOnrs2sT2?=
 =?us-ascii?Q?ls0cInEjtTRACe+NCtEcvD1xXY4WjrwIgTZXAWwZCpvvsmaUX9xIxcUKQiPg?=
 =?us-ascii?Q?A6dvXkR01RpLdaSAiAGQc3q7Csejf6sCzpYhVeIhunbpJGpieByIDGeBUlis?=
 =?us-ascii?Q?TjpcW12z6LXSrg6hWyIh3J6ZtfcbRekwPa4yfH7X78S1y0OKZ5GANwC8qltT?=
 =?us-ascii?Q?+53LffUkYjVTy6gkQtZEN+kb07mt/Unvrtpw41Iz1kBndxYxuReDE76APjZx?=
 =?us-ascii?Q?3PRJBShKSQXxab8qelznMgdzG5PyjNW0NrOo9wx9D01ae3jyL83O3i50Qo8X?=
 =?us-ascii?Q?1Axrumg2AnYvYoDJL9DIByoGwP2FcVGNMAJOTw0xaHXuLmPSQBpFej31tmvm?=
 =?us-ascii?Q?6A2s6ihYqJdeoofQ5wMSdBgxu89HO1QhZKzd3Mz3OELERRWEnZ39+KcmB4iF?=
 =?us-ascii?Q?uDxldSd5wqV63w9TuTPMr1EuCKsfHXMwUhu11odkisRDXpmMW7ze3xQEVrq+?=
 =?us-ascii?Q?A6VGWC8ea1iPT4bHpiXY537WY68RKKPxjmByDDpeVu7OnoDKbbM6H+HJZ0wm?=
 =?us-ascii?Q?VepiUyYKrYCAg09SqWWqFocDVlS4bKx+qVfEEH1sJrIvVC8WEPssiYt1e6RA?=
 =?us-ascii?Q?ORRsOeTy8y05xy8DlS2KhTbkRdKNwFsggoyUnXfeWXte0IRDhlTXR0T5Pivj?=
 =?us-ascii?Q?Jl2juHMVt58wm9QP3IH8QIQL0Fc0IbBoBcYK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U4gq/larUGhRh2WdYHSPdysp6DUS2+BPlqCCJNSPQ21oA2rDLck8xQHZflBX?=
 =?us-ascii?Q?3rIqW79yamovsBs79EAklx+aLbw9L7chMysg52bom3SDpeAu8tXg7BIwEfKL?=
 =?us-ascii?Q?oEwiPGci//wgnawPjJNmwCK6f4PrVHjNKMHMGehGXJPcpPEjz3lGd/r/DS83?=
 =?us-ascii?Q?WHjkclimavEp5rMbP2c+SbFN5jWp+SLJD56qaY/Y5hA2IUYQkWZQwwTr11Ub?=
 =?us-ascii?Q?Mbl9UxXuoLbM6w3cixmiY9ELHaKlI/iPVlXpeNZT4T/A55z45HnXt17ybtB1?=
 =?us-ascii?Q?ngmk/1WCQk7NZrSEPfrG1kQ/yhBUzhPnLZHE58k8Ld8hk68ih5rpbokjj7TF?=
 =?us-ascii?Q?RKtifmpj9B+g0jGc58nsjwQ6uK2bz4R19ULqnPsPQ+FAWkR/c+r3SqSbY5wN?=
 =?us-ascii?Q?AwRJg34uqjRvNb9WnWZSVceiFJHEJmW1b02m/5u85eC30ICWRmnUd2ffT62c?=
 =?us-ascii?Q?vcCQ8xKydHid3HK4FTYF7pGKHSWiCsqvDqhq9Z8Mx7uj2T+jbFHVbzQSz4IA?=
 =?us-ascii?Q?s3cuL+xw7r5SEyA2ap09mSG/jb7NDeQhlioIVVt96Rsmji0qUKfzMAOoDGkK?=
 =?us-ascii?Q?J6PjcDgfAtil5gjuHwzyM3UB+c7NAvnp/UMw2O4KbFAMJ02/t8eTEiF6wA6M?=
 =?us-ascii?Q?EbiDIUdmew+GgudbpNt1HVDHE4xuzjTOwtFnXg88CGzMts9eJmkiv6pIuj4V?=
 =?us-ascii?Q?NkTuKNcjuA1SYWnBp+ov/3L3GNLXj/zpr2iAE4WbPLvervLlurTPF3jB1OOD?=
 =?us-ascii?Q?6xXx4aNx4h61yITN9lAdVqMlbRfpli4RW+nrH6zNeUfFhYW2H5GlUyh3B1BE?=
 =?us-ascii?Q?9TCRQWbyCHYrppkFVrNpw2LYxRvi54ChmXU/YUCm/lId/qqRcM6yr8zEuI39?=
 =?us-ascii?Q?GwpPFrJv7xsIrXIGreTJKdhRLbCZVS/uE78Td5LmoaaDf0imYM5x785qthFu?=
 =?us-ascii?Q?jBXi7ygCQ3M4d1g8U4mq/GCFdWOunCt09g5W9OYy6wrEPKeFzQ3jCSLy1gWt?=
 =?us-ascii?Q?KDvL0C8Sdo3GqG/Ku25KqoQQH7H9fmOob8c8i3dvz/lyp5Uf6z0rlfhf26vD?=
 =?us-ascii?Q?/BrIR42ahXRWH4ULcrJG0GuSaxooT5A95PDxQvkqgq3GQcfF+gAKgxttTpec?=
 =?us-ascii?Q?gZhoFBDcRokfdrW2zrxCNThfRiMO0SN3fPbpVmw+0ww/CtrFJEUpQLqrHVBL?=
 =?us-ascii?Q?QWoVQeEe+S7/nXD8cQyWFnRK1pgAFiHcDYJT2Ne+Y+wdETdlZtkaEOVo//dl?=
 =?us-ascii?Q?uKWmOiKPlCxtXnvTF8of5eDwNeH7FbFN/islqMKBQ+M000m06UmG+BOf/ao+?=
 =?us-ascii?Q?5L5+A9wfw5pedLcvAooNlGSZVLIHYkqmY2FOCNL5xWu8wAPh1+W3aTiNwoK0?=
 =?us-ascii?Q?LQJ+00Dj3q7daEVidzgtkNJwP4dXIiUkUyEx7kpExG9THk/R5hain0GERsNM?=
 =?us-ascii?Q?rPYRxQOM+/tMG+ABE2anOWHZ3qRpp038G7acMjRKr/BJ+caOKk2/GB/DoCoK?=
 =?us-ascii?Q?fSp88Sqcwz4ZsoTkRE875v5/q6QFi/OI0bC5EUnSbBrBYeJi+9Gt7k/zqo8X?=
 =?us-ascii?Q?12mOjQYUdxhh0U8IZapBgmm0ZPCyJ0ty2fPladRGJhQYDa3d5rWPMiS8xSdQ?=
 =?us-ascii?Q?Ag=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8c9433-e015-4cd2-765a-08de2e5eb3f5
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 09:15:42.0423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 59kFeBpfvCFsOQNhRcePg3y4s7StcvMY6si6GjBJ2EoypTefUpVBhGaTjp4j4LpEj6+ATERetx18qFo/fimCPjB6KIM5vAZVP4/z64PoxrE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8252

Implement TLS handshake initiation for secure interface authentication.
Includes ECDH public key generation, host hello message creation, and
handshake hash computation for secure chip authentication.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 189 +++++++++++++++++++++++++++++++++-
 1 file changed, 188 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 7c94d8ab94f3..8208b0748f97 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -26,6 +26,7 @@
 #include <crypto/sha2.h>
 #include <crypto/hash.h>
 #include <crypto/kpp.h>
+#include <crypto/ecdh.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -124,6 +125,8 @@
 #define HCI_NXP_IND_RESET	0xfcfc
 /* Bluetooth vendor command: Trigger FW dump */
 #define HCI_NXP_TRIGGER_DUMP	0xfe91
+/* Bluetooth vendor command: Secure Host Interface */
+#define HCI_NXP_SHI_ENCRYPT	0xfe9c
 
 /* Bluetooth Power State : Vendor cmd params */
 #define BT_PS_ENABLE			0x02
@@ -388,6 +391,55 @@ union nxp_set_bd_addr_payload {
 	u8 buf[8];
 };
 
+/* Secure Host Interface */
+#define NXP_TLS_MAGIC			0x43b826f3
+#define NXP_TLS_VERSION			1
+
+#define NXP_TLS_ECDH_PUBLIC_KEY_SIZE	64
+
+enum nxp_tls_signature_algorithm {
+	NXP_TLS_ECDSA_SECP256R1_SHA256 = 0x0403,
+};
+
+enum nxp_tls_key_exchange_type {
+	NXP_TLS_ECDHE_SECP256R1 = 0x0017,
+};
+
+enum nxp_tls_cipher_suite {
+	NXP_TLS_AES_128_GCM_SHA256 = 0x1301,
+};
+
+enum nxp_tls_message_id {
+	NXP_TLS_HOST_HELLO	= 1,
+	NXP_TLS_DEVICE_HELLO	= 2,
+	NXP_TLS_HOST_FINISHED	= 3,
+};
+
+struct nxp_tls_message_hdr {
+	__le32 magic;
+	__le16 len;
+	u8 message_id;
+	u8 protocol_version;
+};
+
+struct nxp_tls_host_hello {
+	struct nxp_tls_message_hdr hdr;
+	__le16 sig_alg;
+	__le16 key_exchange_type;
+	__le16 cipher_suite;
+	__le16 reserved;
+	u8 random[32];
+	u8 pubkey[NXP_TLS_ECDH_PUBLIC_KEY_SIZE]; /* ECDHE */
+};
+
+union nxp_tls_host_hello_payload {
+	struct {
+		u8 msg_type;
+		struct nxp_tls_host_hello host_hello;
+	} __packed;
+	u8 buf[113];
+};
+
 /* FW Meta Data */
 struct fw_metadata_hdr {
 	__le32 cmd;
@@ -1607,10 +1659,137 @@ static void nxp_get_fw_version(struct hci_dev *hdev)
 }
 
 /* Secure Interface */
+static int nxp_generate_ecdh_public_key(struct crypto_kpp *tfm, u8 public_key[64])
+{
+	DECLARE_CRYPTO_WAIT(result);
+	struct kpp_request *req;
+	u8 *tmp;
+	struct scatterlist dst;
+	int err;
+
+	tmp = kzalloc(64, GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	req = kpp_request_alloc(tfm, GFP_KERNEL);
+	if (!req) {
+		err = -ENOMEM;
+		goto free_tmp;
+	}
+
+	sg_init_one(&dst, tmp, 64);
+	kpp_request_set_input(req, NULL, 0);
+	kpp_request_set_output(req, &dst, 64);
+	kpp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
+				 crypto_req_done, &result);
+
+	err = crypto_kpp_generate_public_key(req);
+	err = crypto_wait_req(err, &result);
+	if (err < 0)
+		goto free_all;
+
+	memcpy(public_key, tmp, 64);
+
+free_all:
+	kpp_request_free(req);
+free_tmp:
+	kfree(tmp);
+	return err;
+}
+
+static inline void nxp_tls_hdr_init(struct nxp_tls_message_hdr *hdr, size_t len,
+				   enum nxp_tls_message_id id)
+{
+	hdr->magic = cpu_to_le32(NXP_TLS_MAGIC);
+	hdr->len = cpu_to_le16((u16)len);
+	hdr->message_id = (u8)id;
+	hdr->protocol_version = NXP_TLS_VERSION;
+}
+
+static struct sk_buff *nxp_host_do_hello(struct hci_dev *hdev)
+{
+	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	union nxp_tls_host_hello_payload tls_hello;
+	struct nxp_tls_host_hello *host_hello = &tls_hello.host_hello;
+	struct ecdh p = {0};
+	u8 *buf = NULL;
+	unsigned int buf_len;
+	struct sk_buff *skb;
+	int ret;
+
+	nxp_tls_hdr_init(&host_hello->hdr, sizeof(*host_hello), NXP_TLS_HOST_HELLO);
+
+	host_hello->sig_alg = cpu_to_le16(NXP_TLS_ECDSA_SECP256R1_SHA256);
+	host_hello->key_exchange_type = cpu_to_le16(NXP_TLS_ECDHE_SECP256R1);
+	host_hello->cipher_suite = cpu_to_le16(NXP_TLS_AES_128_GCM_SHA256);
+
+	get_random_bytes(host_hello->random, sizeof(host_hello->random));
+
+	/* Generate random private key */
+	p.key_size = 32;
+	p.key = kzalloc(p.key_size, GFP_KERNEL);
+	if (!p.key)
+		return ERR_PTR(-ENOMEM);
+
+	get_random_bytes(p.key, p.key_size);
+
+	buf_len = crypto_ecdh_key_len(&p);
+	buf = kzalloc(buf_len, GFP_KERNEL);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto free_key;
+	}
+
+	ret = crypto_ecdh_encode_key(buf, buf_len, &p);
+	if (ret) {
+		bt_dev_err(hdev, "crypto_ecdh_encode_key() failed");
+		goto free_buf;
+	}
+
+	ret = crypto_kpp_set_secret(nxpdev->crypto.kpp, buf, buf_len);
+	if (ret) {
+		bt_dev_err(hdev, "crypto_kpp_set_secret() failed");
+		goto free_buf;
+	}
+
+	ret = nxp_generate_ecdh_public_key(nxpdev->crypto.kpp, host_hello->pubkey);
+	if (ret) {
+		bt_dev_err(hdev, "Failed to generate ECDH public key: %d", ret);
+		goto free_buf;
+	}
+
+	ret = crypto_shash_update(nxpdev->crypto.tls_handshake_hash_desc,
+				  (u8 *)host_hello, sizeof(*host_hello));
+	if (ret) {
+		bt_dev_err(hdev, "Failed to update handshake hash: %d", ret);
+		goto free_buf;
+	}
+
+	tls_hello.msg_type = 0;
+
+	skb = __hci_cmd_sync(hdev, HCI_NXP_SHI_ENCRYPT, sizeof(tls_hello),
+			     tls_hello.buf, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Host Hello command failed: %ld", PTR_ERR(skb));
+		ret = PTR_ERR(skb);
+	}
+
+free_buf:
+	kfree(buf);
+free_key:
+	memset(p.key, 0, p.key_size);
+	kfree(p.key);
+	if (ret)
+		return ERR_PTR(ret);
+	else
+		return skb;
+}
+
 static int nxp_authenticate_device(struct hci_dev *hdev)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
 	size_t desc_size = 0;
+	struct sk_buff *skb;
 	int ret = 0;
 
 	nxpdev->crypto.tls_handshake_hash_tfm = crypto_alloc_shash("sha256", 0, 0);
@@ -1634,12 +1813,20 @@ static int nxp_authenticate_device(struct hci_dev *hdev)
 	nxpdev->crypto.tls_handshake_hash_desc->tfm = nxpdev->crypto.tls_handshake_hash_tfm;
 	crypto_shash_init(nxpdev->crypto.tls_handshake_hash_desc);
 
+	skb = nxp_host_do_hello(hdev);
+	if (IS_ERR(skb)) {
+		ret =  PTR_ERR(skb);
+		goto free_kpp;
+	}
+
 	/* TODO: Implement actual TLS handshake protocol
 	 * This will include:
-	 * 1. Host/Device hello message exchange
+	 * 1. Handle Device hello message exchange
 	 * 2. Master secret and traffic key derivation
 	 */
 
+free_skb:
+	kfree_skb(skb);
 free_kpp:
 	crypto_free_kpp(nxpdev->crypto.kpp);
 	nxpdev->crypto.kpp = NULL;
-- 
2.43.0

