Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010052.outbound.protection.outlook.com [52.101.69.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE2926A0A7;
	Tue, 13 Jan 2026 07:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768290434; cv=fail; b=K2MChdLLKi2kNlVnBQj3BRMGA0EhZtKehgB3lmhoayXUPVlPGLIPnqyMRpeacFHoZyERTdgwfoKJRULyczUw2OKPntsPEf9cSxCsd88K8BC1oV69rWbeXsc4v8u5mhepJa4+i6x765632PeQo0Fm97vePm6lZ6B0fo5WVIriWbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768290434; c=relaxed/simple;
	bh=ye9EU0r8LOlBRe44yt+ZlLuYEmuViRwODUTcXZuCoWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hmOInRmywGyNbJRRn+VSyNRoLjxuLnBTf+jgNxTEuu4cQj7xcbquZxT3b/xC5PMmqxJWr+Pjc8pYCwiP6EZ7qtKwhCtnQhVtwyTAQxHkeJlNJSWjw748E9EII35oOwb7JjsAvEXUVt9XXDgpKeBc4MSN3K5u3PNWBVT2P+A/DRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ElEvgags; arc=fail smtp.client-ip=52.101.69.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ElEvgags"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mfcXi80cYqsmlf4h6k2r+G7/hq4NCyyyr8SJJQGOz+JOjW2b6DhIL9HO0oZ+uaf82Z/RfauTqBuhiE3j8mW4CQNMUAkj7hIZ617IOVEL63LnNDaextzF1m9kALwAhS23CKypy31sA1cEHlTmfIV2JNwk4igVUPCoA4UnXVU4u5I/V+p66mgax4e6vlHYnOKRlLShvrynDL0WhLsHyySDFpnA6RKzqQEghVVf/cTkU7qA5kAdb7cgOrb+cgO1aLk7PCEDWVLve8hukjIMjKqXy/mOGMutiho2LvayXQ87PZuDLo9oRfrKKQpOmeCRCfvmmm179cmhVQvOOR+f75+G0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqqPyr8idqf0atEypc+loE/0FiFAY1+CeRMM5A45LGM=;
 b=NdHUiR+/PddUSwTRQZ0rgocqCbCf3tAIepTHo4Ngr5MUNeCi7fut+srH//MF9Wvg7HGuKnZty6DahcR2AD2EAUCXxyt5vTQh/HmdkaHZKDUPdyB3N/oOesi+HB8RkfcAOxo7WvIKsEa1lRRjWjEm4zzgJVOh0z9txblEKGn/a6mZm8/oaeod8g7Dzvzta6oQTsjeS4fWnXTJ701Q5+CWXyL3u/sQ4tL3MinaUW/QKuFYkmPPBPFcKNCI+U4WKtBsbvnk0H9T/NocIhaWDdnecxmClW8FYaq3P9uwSKY1mqPu2sA691yV0PdJizzoNyxJUuCuGvvZ/zQpUxBFfFzjWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqqPyr8idqf0atEypc+loE/0FiFAY1+CeRMM5A45LGM=;
 b=ElEvgagsH0Rkg5RTsS5E6h9j5OJdwJUR/qu4VdUHpLdaB+EgsFvLOlOGfAzvSI5jN4BEi1Upopjkob6ufiIP7q5ow7Lh062dBg8QNDX+ApWC7tDwjNrRBI++9VTSdACERIBgqoVKeep9fKmq/xexde5U/R6unkwiOHCYcvnMlXeSwf1IEBvA9eJQ5RernbASx9+1iHccuxzXrNbid8ZSKUWCKzrpV3Bkl55QzpxFljIgdfzVYoa51jSbnmUa8EJnyJHpgoseL5BI63KCvUNMFINTf5FYWVv9YnpXKnOQsxJZ3o97glmtUO9cPRABqLijRjYlzYRLzsqdiHTgUvJCog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PAXPR04MB8144.eurprd04.prod.outlook.com (2603:10a6:102:1cc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Tue, 13 Jan
 2026 07:47:01 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.9520.003; Tue, 13 Jan 2026
 07:47:01 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	dmitrii.lebed@nxp.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/11] Bluetooth: btnxpuart: Add TLS device hello processing
Date: Tue, 13 Jan 2026 13:17:13 +0530
Message-ID: <20260113074718.2384043-7-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113074718.2384043-1-neeraj.sanjaykale@nxp.com>
References: <20260113074718.2384043-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::38) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|PAXPR04MB8144:EE_
X-MS-Office365-Filtering-Correlation-Id: cd89c250-3b1a-4f22-038c-08de5277efdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|19092799006|1800799024|38350700014|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9u5IWntTs3BjQfX2aaOVtEoURntpYKjJVxqjf5mAF+yBJyA2B480DtwUQzN5?=
 =?us-ascii?Q?kgInjejQPQH7+oyqTu5HIeZARQFvBXcwjRvGyoA2QxBcwF09AYfFT5wJrDru?=
 =?us-ascii?Q?gzy44LffKRgShM0OZz4ZAvqaZbFWxHa+xbGecolDsnW7TJOT9W9wescus3ZD?=
 =?us-ascii?Q?f4//ZzO9EPTT2gc84iJxZ0E/J1GZJOROBwvR+R33RU/JcpzVWiTFtIQdH8ux?=
 =?us-ascii?Q?SCzlcXKJaNxFtZveXVGgKNd0FgWzEmba0frf9uvjtNk8pRcWJQgsDLhVn37U?=
 =?us-ascii?Q?4uOPqCj1+pqFpnHM4dEY3IN0Ggx7VEY/quotgkIZsodz/0PY8TUM+qfJnZ/I?=
 =?us-ascii?Q?FWtNNzPYFxNHyP5+o3fYgYUMDf+OhfD40u5EFHHkwRqhQBlBRWGIEoybusDH?=
 =?us-ascii?Q?sqoI5sKC4cs3mpHZGb7HexGRGV0KeV3eKeypPdhv534wcPawFtxvA5jYimgw?=
 =?us-ascii?Q?eW6qLHOuYw5yhcpp8Lg/7i6WxWByj+kRb72gXE21m+WGYd1xL8bGhlZbP+2j?=
 =?us-ascii?Q?FinIjnpAglipqewtPPjUIFZkcryCOd8jeB9mhNxTx2joOOn/qBAPEvWQMDIu?=
 =?us-ascii?Q?PselZiuN6kDFVnQ9uh+f0HtSMBxrufJg7STBjjCmO+izN/4uXXobOxocu4ce?=
 =?us-ascii?Q?Pd0Y7FkoYRyCcnn5Jr0rFZNww7HvWlEjgS2yvhGajNQA2IxM6lidUH4fGB5z?=
 =?us-ascii?Q?I8V4H4y5pcLd0+QQoxdYLOa67aNrrT17tUgFSMtjr2roYAC3KRTrUjCWMpiD?=
 =?us-ascii?Q?py8toocXO8DjJmpUPF3KiawTKLLCZcMzZ/F8YR0XBPbyDYstBHnFV4nVfxaf?=
 =?us-ascii?Q?v/EyJXcm4Zzn0qnBki4l7SFO9ve7gaq4rWtSglIB3QJMu9XhDX5KCTWHljHo?=
 =?us-ascii?Q?M8vJX/ujQRip++Je4CpNeH2yUqWaWdM1yQ6QmqUAI4qxX+dbE4UwqsTmR1ps?=
 =?us-ascii?Q?YOfBKZ9HyTtCS1zE+pjDVBvd+Fd1baRa+kwHpK5oN9uMFirL4jXmUsGPHQpk?=
 =?us-ascii?Q?c9HlJ3qt8dymM9c3CSFkKgDxbci1i4qruBerNH9LqEE4i7dJdRLfue8s9jzS?=
 =?us-ascii?Q?MXUU91GldirDS/PBaNStyiPVq7GKC4ufYY1745AvcsSrgDDy8vJT98Un0rEe?=
 =?us-ascii?Q?HwYFoCO0VwHl2wSnWiRS6aEAxKu9U9kETtvyzkg70x0UZITDBlJ4F8WQOt9x?=
 =?us-ascii?Q?if3G6CfQcodLNAMRAwn+g1ALi3xKMRNQ1K5c/x0eA0K5I0NmolcCHuuWf2cc?=
 =?us-ascii?Q?TMg3XvQ1x+WVDsKb7kfoGFnb2wd7uCEG9yQzY+lRbgK/OUiqES6ltXY6iB7F?=
 =?us-ascii?Q?nJw9LhELmRRlwLzKEqkHySfUuL/JxRyxiAo+5NawhCeMmU8Umv8iU3iojzh8?=
 =?us-ascii?Q?t/Fqs+uaRZhQQVuS5mBZ3vYmHEu2jaDCSMiYCk0HsyXrqleRlROvvBcDagbv?=
 =?us-ascii?Q?3fIEZOtK4/rgfYaUmMlG6hpl48YF7zXLn9gW9mMF/xXXVvfmBpHI+71lvLzv?=
 =?us-ascii?Q?Zn0S/wiu+4JmbXHmQjjLYYyWqz7PqP4PmIiA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(19092799006)(1800799024)(38350700014)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U6vGVufazr9oC2aLwc6vCw/RES45QBXvx2nDU2pvEtsJID8T+H/YUJGmlpBJ?=
 =?us-ascii?Q?JMX7Tembw9ElWANgaS9qW+CtdQORqgxovYV+XhqHdNAc6eF6ztDy43jIR6y1?=
 =?us-ascii?Q?CJfgz7mKVzkF47L1kuWgNON2cHRxQc6mOcJUcPDOJ95y1/teFelD2+WMqc5v?=
 =?us-ascii?Q?B/Ryyww7wTedVwnDMag6wmK6bIgSU9NIGUyMJ9nfctH26mEqubPn/rp4qzp5?=
 =?us-ascii?Q?dpU78hd0+2kSuIUywzlzaONqshYZyR9Ja+PAjE8NzzZdTm1eyDax46GmWjPh?=
 =?us-ascii?Q?gbBvrptmALNRUG/cIp3DksZ6p77QslG2Fdl2ZjPzbNOaIPOvQ9J4XgKNPKpM?=
 =?us-ascii?Q?x0OuT7fYV5Kt5k5kM3N6O4X8j9AbxHYPX7ysQStY6u+Ulo1Qn+/1SO6LEPtY?=
 =?us-ascii?Q?+LqT7J4/svnc1p26lT+AnOxJR29zT2Lh288dpl28rIeSy/guZWdxtHPIqjAF?=
 =?us-ascii?Q?bveXewTSsWGCs5vZJhUzzFZEC6FuKol2/iZspr74evbxhs2k29YC9r9+t4AP?=
 =?us-ascii?Q?17jKIwGu6thx5LDhB6wlNSwFbdoo7YMaJ0X/fovWdZfMOUdJpZlGfuVP2LaP?=
 =?us-ascii?Q?2NBOHP8+qAfvETvU7kyZpGVPegEW0Imze+dcju1OmEceEdQOZfiEUb4qeRt1?=
 =?us-ascii?Q?OINlVm6Uo9o5e6nA1sOMG/St5iUxyp31ilk8iOPHujARLPRweYryzgCzxqhg?=
 =?us-ascii?Q?kQngJG3g5VAdKCJZNdI4qB+Ceic8rjwyauaOxALjA5cXO6jt/3IO9KlR3uxL?=
 =?us-ascii?Q?Wx0+aJFku3Iwaf2jrsFfgmj4pwZP63z/3kdsa6oShwNLmUpF9nNfANzBthfT?=
 =?us-ascii?Q?Kdqmg4jrfjG/pcoSKIbwtiGq8b1as6osEq0i7M8k89UKu4Hq61FeUcErMJ+j?=
 =?us-ascii?Q?l7sAy7br3Yis6mr7gJyvTOjR8LAyMZqN7gmzL7rDJGCyfGWNxv50ufCszL9H?=
 =?us-ascii?Q?EGoF9Ipbx+HFnhzQ1+ynsRNVNF8kqxWtjkHmiEk52o7eHrcgXTQVUlUFnXQE?=
 =?us-ascii?Q?UyODTHY54NJTnMe0IkIcJFuAClXyuncufBFHQFL9VXtoeWxD3HaRL4VNrsyW?=
 =?us-ascii?Q?pLxXenmxQhuXB1IoG9szhFu+xF0cI8NmGJuDTuG0oYSTGvjFfWhriFOqutWA?=
 =?us-ascii?Q?3m+3m73Tx6+n/KFpdmZ3M9VkyMx8PphvruIth+FByrxzx72K4UPpldiPdIjP?=
 =?us-ascii?Q?pwhfsImzqZ2xOIOUy9cnnxrJJpKn5LfFB+UmreX6/O7uKCCBdLGLcJifDgmE?=
 =?us-ascii?Q?gBpNI/OkoiUnmImN9iTL8kDM2ul85Oy6s7e0oCve79PcgLfJjO0X6tpw9Ncw?=
 =?us-ascii?Q?tG6/1nP6J9VN0T8rJJYGJ1sifx5cAcVZXWrJjqUaZNsqNEx69hR2u/RcJX16?=
 =?us-ascii?Q?8+KdrnvgrhK5XNTMbpnqoTtdoPr6QXj3WCuUH7rqHA2qaGgAi/OkdI3n/3+g?=
 =?us-ascii?Q?K+02pRRavXrP96fXrf3qErGeLnAtOw8seSIbSwYqROStXsO1xDcRN4TIt0Gp?=
 =?us-ascii?Q?q2rKO2pa8ioT/7T9/jP1X40cM3ecOCqZAC9jaU7GaDTgTQfDpG+AzfvL+Sbb?=
 =?us-ascii?Q?P9IhOh1CxRxzi9jEEh2VnCDJQwiPsKYpJGBqsSGKk76iA5AM/2pzvFMbt7e6?=
 =?us-ascii?Q?uPiqxDa8v8JhDBjtVqmzK7sXO1WYDTE60uwz2li6h4UcF7gnrhXkvFP30qPE?=
 =?us-ascii?Q?jUKTGshFPi6rV4R9+sYTtVkU9HD1jjiLcQiq3ADU01s7IfMSQGGEecrQiiCQ?=
 =?us-ascii?Q?0aQXBWuhBoTSlrXBRNNV3tzSJ4vSk4s=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd89c250-3b1a-4f22-038c-08de5277efdc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 07:47:01.6432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FpqvP196sOsQRgZFcMafBSYJTPjO9xQyL4D5ReoNH3gdGjdqijElCvAuhBnTJtjz8NV8MBczyVusnJq/fmBZdcQ7TtT3DDGMC53vxKtNFhM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8144

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
index 8208b0748f97..0e71f68a408e 100644
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

