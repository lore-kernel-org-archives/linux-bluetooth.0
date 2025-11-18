Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013031.outbound.protection.outlook.com [40.107.162.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC953624A9;
	Tue, 18 Nov 2025 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763475673; cv=fail; b=InErYbg7jOEueDbp6RpYH57qEnmoCR9HC8sh2eoiwk0D/E9Wrwp6VA7zsBp81PRhuGiRZj07TNbFCu9WTwxeWHWnWrHTCcR69iHbaSOIm+r1X/lLpPClTjkq55ipQkDI97Zl+sFSlp2RgfThZhG6PGS7yOypsE+/qarPkYlXCxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763475673; c=relaxed/simple;
	bh=CesTZwcnVPHapx6xx9eim1mOlU6tjuhHyMnHVE1aLe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e6TkzwpSiQa45UEvQuPmm/Cp22HC9sUbwfWZ7P0o5w6tMqiS/eKJQ30lCK4YJ3aH9G0tAFHspLxjuRGxs4BBXFDVtq64LI1gdaS+bMcP5y/vqeNrj9lcAYERLX308LAw48t/FVG3XQ8WNAVhOAQFfge6Si6/3UVxtsrrS58YeiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KZXjS0HB; arc=fail smtp.client-ip=40.107.162.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KZXjS0HB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fz8ZfMRu8jkDPzQ3M4iCdiCn1Fbff/K4kx3d0aeqh6tC4ur7rKmzH6JXlkl/CryHiBD6NXBAHH0vVRSZnNK9g3e6lLQDdcbV3Brh6EIdMcAHKDIU+jJDY2XyodCdu0Wa3AkLq65GHWP95S3A/AhY8XsJy8jVAbTTAu4UJOUGHbKEiWSmDGuUw1szSAFrX0wUlYBSipTATVrQR0OFmzVWjjElW7+oXSiX5vJn1FXR5DYX44N2f1R2Al2UdJPtspV4MLC+ryzY6Mt0zFSJ1B8Bv+P6XRptxLeAAaYmRHm8Xo9WORbewOPkbMIZzVay6te8dSbB0WF0htnbuEjDNDh0Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URKHzbb6XtGg1O8i7BbfM+D8jm3hcGkZuPXhjKclaoo=;
 b=ZL7/SVMBK4WKTzbqlPECBgy2wuGcNmukd0FeNtBCPfnhDOZzBjfg7B31T8eZhz69MeoQJ0nOxc3YdsqR0TUkgEkff723WC0UrbFVSDGJORJ1fZZogyHkOZz+OcN7SB4H6kpqOAyGeNVDMzv83Rg0jaREqE6U5wMXqWK4FTipztOE6XM+z+5Yp42y5W4JBgl7+c9p8U4GVfvDWEih/cBcOGV6NTqH0KLU9cIULrxKSoMxlQZassYFpUsYPetH4p5u7g2NxfuBNSCuoA8WnDFiEzDwP5BwgZxGhJSjKmWaF2Kd0cXe9fEGF94ji51LRAZQggudW9FgX1kVQlv9Mg23cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URKHzbb6XtGg1O8i7BbfM+D8jm3hcGkZuPXhjKclaoo=;
 b=KZXjS0HBT8lSy5CP068kzmUQcHx3JaBf1ZqJI3HyMYvDrNbt+ens9g9P4/+f8URaImWZsLdEEKoKBZrH0oSW82OLtZmTYV176usDh4VgLRMF0VbmlM1SxSAHu5OxCV6UJuh12MxxyFBU6wFaJwbLg62rN6RyW1ltffe1ImfajW0OF/jbmWIMZPCxrP2i2i3yy3Tqp+vQAtqlp2MGWIuenl+MiVa0eujtSVyvY+5MJ+jRFfc0YRdeRZPSLbrCwui3xOCdxpOBPE9yHWchATglcPUtYmRVoWPwnjbUxUTdYF7sEqCHvsMuCQIl783x60da9wIropUKBMO04Uoym8vzCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by DB9PR04MB9284.eurprd04.prod.outlook.com (2603:10a6:10:36c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 14:21:01 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 14:21:01 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	sherry.sun@nxp.com,
	dmitrii.lebed@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: [PATCH v1 06/11] Bluetooth: btnxpuart: Add TLS device hello processing
Date: Tue, 18 Nov 2025 19:50:19 +0530
Message-ID: <20251118142025.1982263-7-neeraj.sanjaykale@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 837dfdbd-087b-4bb1-5db8-08de26adb37b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6Wib7hcmH88uPPyxdmdtyjGGPD5DcWzkdO3Glkl6Y4yc8id/H4vied0gtbl9?=
 =?us-ascii?Q?VD/1MtL7SkXd/EDvu8uuBKHkVEQTj4sxfJDTvejR9pCb1GwkKEJAT2Xt7JnK?=
 =?us-ascii?Q?234waIgERGni2dzwmusI7OiwqItdrDXgN2vFaXxxnvKnMeHJJkxnhX8vL0pA?=
 =?us-ascii?Q?FmrGPSHKBxxd1/y7BeMZvM9EiS/O5agsCu13YGNRJCreA9RdPmJqfbiDws1J?=
 =?us-ascii?Q?bJhdpwuFritH2sVjDvWN4w/IV69u2qzDkIFYyBUddqb1CyDbsuLoDre4jWNg?=
 =?us-ascii?Q?6mkR0TaVwj604mTqE9LG50UmvUcHUdfnI+CvJhHpaFNvXEsSodHJhhqJmul+?=
 =?us-ascii?Q?T4t/BhbkseQElTLb7QIZxR9fJgTZHUSWNNHgGm/y4Tfq2ucVDiQejSxAREMU?=
 =?us-ascii?Q?b/aVTe4yD5ueoX8ctO9500VpSCXJYcig9HpU6t+1dyTy9U2a6N64l110GwOk?=
 =?us-ascii?Q?uMFo9WniGHGp6rYg3ftkQRTtGyLX26i9kFat7+zK4Ay5xeEH8ufco0P9CRUW?=
 =?us-ascii?Q?MAAbhynXovop8Le4INUdhRTNb9fdBZ7jcYSE8GgbYFmurydmvGyocUCn8uEH?=
 =?us-ascii?Q?wP38OCFUwsbewr1e6y963T+hjpFSrvAGYb+3IJ6+lU4+G6KGxuaWSY0l7Y8h?=
 =?us-ascii?Q?psJLdJzaixTMLq46AGEGgZxFy5KDW9DxTxoME7n/OhwKsQNVYeidoNFfalmM?=
 =?us-ascii?Q?7vrI74MStYiTYAeTcxBWkS/wIGJcv6YTc1dm55rVQQl8oRH46I+1aXAqpUHE?=
 =?us-ascii?Q?jso+hWUy6vy3pyuxEqKwU2yHe7Ondrj0Ygo6JF07vbKa/1g8V5NGpBZd1yWO?=
 =?us-ascii?Q?zkMuk8Dh4dLY2BfZwZuWXmXLketyGb//rvu18D6MY7yXEqZ814MXcACBJ+yJ?=
 =?us-ascii?Q?6tWQXQneOqFK1vmE8Jo3ZdxklkT3sTtU0XM9jhvcPkAi9DHXLaYQKaZeQqLV?=
 =?us-ascii?Q?hnVpGTTnEDib1vWxebOGXbrZTlXRHKTYrkffBsgGeTia5m63AytAa+MNquce?=
 =?us-ascii?Q?rUgOVojqg8YF553LyVvMsYSkmJauTCUKplGgk3oN/x40FFDH7wrGwpWZlnjE?=
 =?us-ascii?Q?g2MAGzlfVnt3cUV/aetmuiEyd06eHFyGYQL9KKP1K+f4xTJtxrHX4UCAiabB?=
 =?us-ascii?Q?eBDtj/UqeLplhaMx7HirWBHMS6uodT20F98j6FiwxFU3Hd4P6fmDZGgp9L3b?=
 =?us-ascii?Q?PIiI55nYnxBMteC4OnG7U9e/WHgvspnC5Gxewz89nDk3XKi59UPMG58fgPCe?=
 =?us-ascii?Q?XMHDKS+cqZa1Jex+uwHpJzqUmWh1qyo4S5snIrW6Bgvk8dfmz/OU/eXlCaAA?=
 =?us-ascii?Q?uQ6Dy/eek73deMMnuKauA8n0GQUTWPHUcTMpd4oPGTNLKyln+IuVk1hSstHI?=
 =?us-ascii?Q?FmCAA7J1FOmFfp/Y9/2SRW/WDaOrrgLSfDJ9npSwnftwB3047UUh4Y7NdUJM?=
 =?us-ascii?Q?FJuArO9N55ubLUopL8p+rQdm2bxlqn/gstb8/fV/6jU0Y+O+4/aIIXM2q8R5?=
 =?us-ascii?Q?sE8Fnz8pBq+we6BHZZgIJuiue6FPM4A8xl1g?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kuHvgSyCEdAPKL9YJOLOLN+GaiXZEodv5hSJPbBRtJerg7brRILSGZ2f2w0F?=
 =?us-ascii?Q?PaCUTzbtymt5B50wq8FIJb6KfWB+sWjOnST+jZkLl9/XQ3gk4R6ZrY4+CMdS?=
 =?us-ascii?Q?DfLkjEOoK28wWxNbjw3cUY5/yQRYbPi2WjH2lr0EbzG7qmms4q1QlQvWlAur?=
 =?us-ascii?Q?BQC5Y9ivpnvIMEz6HRoypzN7N1yC3dYT9wbRKa7FWyrRHepKI0lqsygPilmA?=
 =?us-ascii?Q?4h9Aemdr/YUdOEX7TikVHT3wrXD1BwS3mc0zSvpG9UlDBpwOIVV1Sie3Spxg?=
 =?us-ascii?Q?7/jTav/VKMi/knqMKuZvIlQ+jYXvuWf+4DGWGv3Tmd8xK/XgCt8bRtILEvkF?=
 =?us-ascii?Q?/2YTgogBDts7czowe1+S7MxufNj5PbYOxmIaz/W3g6lWAr6ux3bBB04DHiMT?=
 =?us-ascii?Q?midPeGFO+0mQH/oOPkR3kL0IGJBPyG2CaRkwNa4wQOIGMP6yJSpV/ShyqjPo?=
 =?us-ascii?Q?sro+KHjMUtCJp1W+WerUsMh4q934VkNIn0UDPPSdG+cU3MzOFhxeertDCZyT?=
 =?us-ascii?Q?rWwBtzxmRpQFsN3s9KA9ayp7wAlyCUO8TH95XmH89xPwxjsfTgtO3JfU6GbR?=
 =?us-ascii?Q?SO+6hD75M+3HRVNtdXxE4j5VwTx7/N8S+jf7bHR+nbQ4VRIcB2uyV6kczsVS?=
 =?us-ascii?Q?YsTGgLIJMoqiRchWOLdElgTth1US2wCgsZCj9QGnM6wUCx5exI+54yDJwZxh?=
 =?us-ascii?Q?D+uEUd7PTFzgfUaQRCPEocjJI/q6Zu+5rqFKL59x3kuO4EkhQvkLSHuBUa5n?=
 =?us-ascii?Q?HzooFk45q5OE0SxVMcskoF1lhcdwPVC3taRs/xoZm92tnCrZMcPazNtbnh2v?=
 =?us-ascii?Q?pnZJH8vF35hnvrcCTsVKqPjyAcU0toYYpE1jRCag3FgIa8N2uUOEygc1jCSK?=
 =?us-ascii?Q?aRIaBlw1hZAyhlW6XGAdyoo281CL6phofUB9IMXQhveC43UWGjM7v4Zujhr2?=
 =?us-ascii?Q?GYPoJQRB7h5DKkllHVIZ9F3wUrnuXWaylpAx/EK4ifgU+JzNeef7yqFEsdzJ?=
 =?us-ascii?Q?ea07oKRty2CEMd1kJsnVIrcAjExx12DU52Qdo02Tbk39woFeLLeE7pbf2zOV?=
 =?us-ascii?Q?Sda+yWdxMqjQ33+wMJxIcLAHZHFopcLt8qp+R6yiHViR/reZyWBq9GL8ndJO?=
 =?us-ascii?Q?9uWyxQC+6vWcINOo7o2f/mpexPGUh0CnD/QQu4Xaz510KzaZIzrYggR+2+3L?=
 =?us-ascii?Q?2KgH/bd9+ByrVmuO4/3CVrZ9sGrDVAB35OImk/4lGx6Wc82GRclmw6+IJa9G?=
 =?us-ascii?Q?WktKEUPE3WML0iQtgVMz3Xzp35SN8tTXl/WeDvQJt4fZBN62JYQQ3oNjfO4U?=
 =?us-ascii?Q?Oh79p5S9Lf0dQrrkT0hxQTCXCc75VO2+NZS70Wl/ZbQEw5+2wGPa9UeDXmNP?=
 =?us-ascii?Q?96GN9GNESIiuR3qlQkjzshUb4sca98o5zsoQB7Qab+0CaLUgLUGQjRQ0uCvh?=
 =?us-ascii?Q?zPK3/MBlzeSyVjVaDRtvtlnllG98AF8l7jsR8izzlXSnRCo1RUvii77vOmou?=
 =?us-ascii?Q?jupGEzZH96+uc1cQY3ST//xKkx8c8yEYy8lmW13h86+3BZMOGAZp1ZcSHmJB?=
 =?us-ascii?Q?Bvtd9Bpf2DTJT1gMXs5+PC9lkYJVOkPSQMJFO9Sjm0h7DaV4cjsAD28hasDw?=
 =?us-ascii?Q?OA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 837dfdbd-087b-4bb1-5db8-08de26adb37b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 14:21:01.8055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cuA0FlJ8fnveTe6HDKOlFKxsRUv3kWY7sT7/kOxQHNcLdIOKQCGiHTREb2U/jpDJV8fErolMhR21yj7VuNi0vfnyRbJvdjbPrEV0GDUA/uA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9284

This implements device hello message processing to derive handshake
traffic secrets:

- Add HKDF-SHA256 functions for TLS 1.3 traffic secret derivation
  following RFC 5869/8446
- Extract device ECDH public key and compute shared secret using
  KPP API with host private key and device public key
- Derive handshake traffic secret from ECDH shared secret
  following TLS 1.3 key schedule
- Validate device hello message and update handshake hash state

The handshake traffic secret enables decryption of the
device_finish portion within the device_hello message.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 274 +++++++++++++++++++++++++++++++++-
 1 file changed, 270 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 44073eae0df3..3bff7758fa5e 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -150,8 +150,9 @@
 #define FW_METADATA_TLV_ECDSA_KEY	0x50
 #define FW_METADATA_FLAG_BT		0x02
 
-#define NXP_FW_UUID_SIZE           16
-#define NXP_FW_ECDSA_PUBKEY_SIZE   65
+#define NXP_FW_UUID_SIZE		16
+#define NXP_FW_ECDH_PUBKEY_SIZE		64
+#define NXP_FW_ECDSA_PUBKEY_SIZE	65
 
 struct ps_data {
 	u8    target_ps_mode;	/* ps mode to be set */
@@ -203,8 +204,11 @@ struct btnxpuart_crypto {
 	struct crypto_shash *tls_handshake_hash_tfm;
 	struct shash_desc *tls_handshake_hash_desc;
 	struct crypto_kpp *kpp;
+	uint8_t ecdh_public[NXP_FW_ECDH_PUBKEY_SIZE];	/* ECDH public key, Key negotiation */
 	u8 ecdsa_public[NXP_FW_ECDSA_PUBKEY_SIZE];	/* ECDSA public key, Authentication*/
 	u8 fw_uuid[NXP_FW_UUID_SIZE];
+	u8 handshake_h2_hash[SHA256_DIGEST_SIZE];
+	u8 handshake_secret[SHA256_DIGEST_SIZE];
 };
 
 struct btnxpuart_dev {
@@ -396,6 +400,11 @@ union nxp_set_bd_addr_payload {
 #define NXP_TLS_VERSION			1
 
 #define NXP_TLS_ECDH_PUBLIC_KEY_SIZE	64
+#define NXP_DEVICE_UUID_LEN		16
+#define NXP_ENC_AUTH_TAG_SIZE		16
+
+#define NXP_TLS_LABEL(str)		str, strlen(str)
+#define NXP_TLS_DEVICE_HS_TS_LABEL	NXP_TLS_LABEL("D HS TS")
 
 enum nxp_tls_signature_algorithm {
 	NXP_TLS_ECDSA_SECP256R1_SHA256 = 0x0403,
@@ -440,6 +449,38 @@ union nxp_tls_host_hello_payload {
 	u8 buf[113];
 };
 
+struct nxp_tls_device_info {
+	__le16 chip_id;
+	__le16 device_flags;
+	u8 reserved[4];
+	u8 uuid[NXP_DEVICE_UUID_LEN];
+};
+
+struct nxp_tls_signature {
+	u8 sig[64];        /* P-256 ECDSA signature, two points */
+};
+
+struct nxp_tls_finished {
+	u8 verify_data[32];
+};
+
+struct nxp_tls_device_hello {
+	struct nxp_tls_message_hdr hdr;
+	__le32 reserved;
+	u8 random[32];
+	u8 pubkey[NXP_TLS_ECDH_PUBLIC_KEY_SIZE];
+	/* Encrypted portion */
+	struct {
+		struct nxp_tls_device_info device_info;
+		struct nxp_tls_signature device_handshake_sig;   /* TLS Certificate Verify */
+		struct nxp_tls_finished device_finished;
+	} enc;
+	u8 auth_tag[NXP_ENC_AUTH_TAG_SIZE];   /* Auth tag for the encrypted portion */
+};
+
+#define DEVICE_HELLO_SIG_CUTOFF_POS \
+	offsetof(struct nxp_tls_device_hello, enc)
+
 /* FW Meta Data */
 struct fw_metadata_hdr {
 	__le32 cmd;
@@ -1698,7 +1739,7 @@ static int nxp_generate_ecdh_public_key(struct crypto_kpp *tfm, u8 public_key[64
 }
 
 static inline void nxp_tls_hdr_init(struct nxp_tls_message_hdr *hdr, size_t len,
-				   enum nxp_tls_message_id id)
+				    enum nxp_tls_message_id id)
 {
 	hdr->magic = cpu_to_le32(NXP_TLS_MAGIC);
 	hdr->len = cpu_to_le16((u16)len);
@@ -1785,11 +1826,222 @@ static struct sk_buff *nxp_host_do_hello(struct hci_dev *hdev)
 		return skb;
 }
 
+static int nxp_crypto_shash_final(struct shash_desc *desc, u8 *out)
+{
+	struct shash_desc *desc_tmp = kzalloc(sizeof(struct shash_desc) +
+					      crypto_shash_descsize(desc->tfm),
+					      GFP_KERNEL);
+
+	if (!desc_tmp)
+		return -ENOMEM;
+
+	crypto_shash_export(desc, desc_tmp);
+	crypto_shash_final(desc, out);
+	crypto_shash_import(desc, desc_tmp);
+	kfree(desc_tmp);
+
+	return 0;
+}
+
+static int nxp_compute_shared_secret(struct crypto_kpp *tfm, const u8 public_key[64], u8 secret[32])
+{
+	DECLARE_CRYPTO_WAIT(result);
+	struct kpp_request *req;
+	struct scatterlist src, dst;
+	int err;
+
+	req = kpp_request_alloc(tfm, GFP_KERNEL);
+	if (!req) {
+		pr_err("Failed to allocate memory for KPP request\n");
+		return -ENOMEM;
+	}
+
+	sg_init_one(&src, public_key, 64);
+	sg_init_one(&dst, secret, 32);
+	kpp_request_set_input(req, &src, 64);
+	kpp_request_set_output(req, &dst, 32);
+	kpp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
+				 crypto_req_done, &result);
+	err = crypto_kpp_compute_shared_secret(req);
+	err = crypto_wait_req(err, &result);
+	if (err < 0) {
+		pr_err("alg: ecdh: compute shared secret failed. err %d\n", err);
+		goto free_all;
+	}
+
+free_all:
+	kpp_request_free(req);
+	return err;
+}
+
+static int nxp_hkdf_sha256_extract(const void *salt, size_t salt_len,
+				    const void *ikm, size_t ikm_len,
+				    u8 result[SHA256_DIGEST_SIZE])
+{
+	struct crypto_shash *tfm;
+	struct shash_desc *desc;
+	u8 zeroes[SHA256_DIGEST_SIZE] = {0};
+	int ret = 0;
+
+	tfm = crypto_alloc_shash("hmac(sha256)", 0, 0);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	desc = kzalloc(sizeof(*desc) + crypto_shash_descsize(tfm), GFP_KERNEL);
+	if (!desc) {
+		crypto_free_shash(tfm);
+		return -ENOMEM;
+	}
+
+	desc->tfm = tfm;
+
+	/* RFC 5869: If salt is empty, use HashLen zero octets */
+	if (salt_len == 0)
+		ret = crypto_shash_setkey(tfm, zeroes, SHA256_DIGEST_SIZE);
+	else
+		ret = crypto_shash_setkey(tfm, salt, salt_len);
+
+	if (ret)
+		goto cleanup;
+
+	ret = crypto_shash_init(desc);
+	if (ret)
+		goto cleanup;
+
+	ret = crypto_shash_update(desc, ikm, ikm_len);
+	if (ret)
+		goto cleanup;
+
+	ret = crypto_shash_final(desc, result);
+
+cleanup:
+	kfree(desc);
+	crypto_free_shash(tfm);
+	return ret;
+}
+
+static int nxp_hkdf_expand_label(const u8 secret[SHA256_DIGEST_SIZE],
+				 const char *label, size_t label_size,
+				 u8 *context, size_t context_size,
+				 void *output, size_t output_size)
+{
+	struct crypto_shash *tfm = crypto_alloc_shash("hmac(sha256)", 0, 0);
+	struct shash_desc *desc = kzalloc(sizeof(*desc) + crypto_shash_descsize(tfm),
+					  GFP_KERNEL);
+	u8 hmac_out[SHA256_DIGEST_SIZE];
+	u16 length = output_size;
+	u8 one = 0x01;
+
+	if (IS_ERR(tfm)) {
+		pr_err("Failed to alloc shash for HMAC\n");
+		return -ENOMEM;
+	}
+
+	if (!desc) {
+		crypto_free_shash(tfm);
+		return -ENOMEM;
+	}
+
+	crypto_shash_setkey(tfm, secret, SHA256_DIGEST_SIZE);
+	desc->tfm = tfm;
+
+	crypto_shash_init(desc);
+	crypto_shash_update(desc, (u8 *)&length, sizeof(length));
+	crypto_shash_update(desc, label, label_size);
+
+	if (context && context_size > 0)
+		crypto_shash_update(desc, context, context_size);
+
+	/* RFC 5869: HKDF-Expand counter starts at 0x01 */
+	crypto_shash_update(desc, &one, sizeof(one));
+	crypto_shash_final(desc, hmac_out);
+
+	memcpy(output, hmac_out, output_size);
+
+	kfree(desc);
+	crypto_free_shash(tfm);
+	return 0;
+}
+
+static int nxp_hkdf_derive_secret(u8 secret[32], const char *label, size_t label_size,
+				  u8 context[SHA256_DIGEST_SIZE],
+				  u8 output[SHA256_DIGEST_SIZE])
+{
+	return nxp_hkdf_expand_label(secret, label, label_size, context, SHA256_DIGEST_SIZE,
+				     output, SHA256_DIGEST_SIZE);
+}
+
+static int nxp_process_device_hello(struct hci_dev *hdev, struct nxp_tls_device_hello *msg)
+{
+	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct nxp_tls_message_hdr *hdr;
+	u8 hs_traffic_secret[SHA256_DIGEST_SIZE];
+	u8 *shared_secret = NULL;
+	int ret;
+
+	if (!msg)
+		return -EINVAL;
+
+	hdr = &msg->hdr;
+
+	if (le32_to_cpu(hdr->magic) != NXP_TLS_MAGIC ||
+	    le16_to_cpu(hdr->len) != sizeof(*msg) ||
+	    hdr->message_id != NXP_TLS_DEVICE_HELLO ||
+	    hdr->protocol_version != NXP_TLS_VERSION) {
+		bt_dev_err(hdev, "Invalid device hello header");
+		return -EINVAL;
+	}
+
+	shared_secret = kzalloc(32, GFP_KERNEL);
+	if (!shared_secret)
+		return -ENOMEM;
+
+	ret = crypto_shash_update(nxpdev->crypto.tls_handshake_hash_desc, (u8 *)msg,
+			    DEVICE_HELLO_SIG_CUTOFF_POS);
+	if (ret)
+		goto fail;
+
+	ret = nxp_crypto_shash_final(nxpdev->crypto.tls_handshake_hash_desc,
+				     nxpdev->crypto.handshake_h2_hash);
+	if (ret)
+		goto fail;
+
+	memcpy(nxpdev->crypto.ecdh_public, msg->pubkey, NXP_FW_ECDH_PUBKEY_SIZE);
+
+	ret = nxp_compute_shared_secret(nxpdev->crypto.kpp, nxpdev->crypto.ecdh_public,
+				  shared_secret);
+	if (ret)
+		goto fail;
+
+	ret = nxp_hkdf_sha256_extract(NULL, 0, shared_secret, 32,
+				      nxpdev->crypto.handshake_secret);
+	if (ret)
+		goto fail;
+
+	ret = nxp_hkdf_derive_secret(nxpdev->crypto.handshake_secret,
+				     NXP_TLS_DEVICE_HS_TS_LABEL,
+				     nxpdev->crypto.handshake_h2_hash,
+				     hs_traffic_secret);
+	if (ret)
+		goto fail;
+
+	/* TODO: Verify Signature in Device Hello using ECDSA Public Key
+	 * extracted from the FW metadata.
+	 */
+
+fail:
+	memset(shared_secret, 0, 32);
+	kfree(shared_secret);
+	return ret;
+}
+
 static int nxp_authenticate_device(struct hci_dev *hdev)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct nxp_tls_device_hello *device_hello;
 	size_t desc_size = 0;
 	struct sk_buff *skb;
+	u8 *status;
 	int ret = 0;
 
 	nxpdev->crypto.tls_handshake_hash_tfm = crypto_alloc_shash("sha256", 0, 0);
@@ -1819,9 +2071,23 @@ static int nxp_authenticate_device(struct hci_dev *hdev)
 		goto free_kpp;
 	}
 
+	status = skb_pull_data(skb, 1);
+	if (*status)
+		goto free_skb;
+
+	if (skb->len != sizeof(struct nxp_tls_device_hello)) {
+		bt_dev_err(hdev, "Invalid Device Hello Length: %d", skb->len);
+		goto free_skb;
+	}
+
+	device_hello = skb_pull_data(skb, sizeof(*device_hello));
+	ret = nxp_process_device_hello(hdev, device_hello);
+	if (ret)
+		goto free_skb;
+
 	/* TODO: Implement actual TLS handshake protocol
 	 * This will include:
-	 * 1. Handle Device hello message exchange
+	 * 1. Send Host Finish TLS message
 	 * 2. Master secret and traffic key derivation
 	 */
 
-- 
2.43.0

