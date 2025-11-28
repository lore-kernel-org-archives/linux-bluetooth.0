Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011057.outbound.protection.outlook.com [52.101.65.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61755305048;
	Fri, 28 Nov 2025 09:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764321348; cv=fail; b=qugPt45/TllbgrmPdVjJmZuFM0pWEu7qSMj5uSgX0iyHhvjeYgeS7HjR9qQqD0y9jMmLMoXtXi3tM6C/aAWh+GhZXrScQcHkqXj6KugP6q6/EAw7SxS2iu9popoMRVgKfYVovdCsZZIeZAFIXbgFcKhtkbGVFoJpviglJy8qw2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764321348; c=relaxed/simple;
	bh=ye9EU0r8LOlBRe44yt+ZlLuYEmuViRwODUTcXZuCoWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FElVKOCqod7kcjvY97iOL4cBP6nTs9HN49WGi5QUGTqiPi8N33VnEYrVEzYwCxt8ON4NbxjY48dwddR94wmqpApDYRAHPIHvjpH05HuY9JKmHuyGPdVd03QMcDv7BlVHYydUsdcZMy/uUeT7Gva+HuQbI31FPvhck9Rj3GESv7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=F1QP88Rq; arc=fail smtp.client-ip=52.101.65.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="F1QP88Rq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=illGoEdCudmTGgKR2eeG8SbzpdA8YQPbF0g+G2m1ffZxMihm10/074p42sLHGqxWQth3YqhV97kDf3BlFRDUEZTeSdlx4I07VMbF5AYu1XZAYSPoDU+VcB6AloVZUcnPfy8BiLWnn4+3DGpQpHncflg+C3U2tHYNy2B+TPR44EQjFKgt3285XpWwnlbg7VhUSBGG3zZq27PhDNR6qGU235kzWYMx7tog0Q3hVcqZ6OYhTWQV2eAwHf03vSFAu35B9SwUy6QryeaoWfPIhN0gLD9fv0ZDlnnUJttz2KjLSQIs6hbNPGvMf6EVO7WOD4rVyYegngxspI9wNrlSkpVS9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqqPyr8idqf0atEypc+loE/0FiFAY1+CeRMM5A45LGM=;
 b=ltZaIMN5oAh8Dw196d0OePI39I1HmzBLvjUx/eXe2efKyxNxElDqBFuJWhzBSVd9+CIMM5DgKzVYjn/z7cUlr6WIN8/BQ/VsOEbBM6AzbN6S6tvuxscJpmfZ9PFQFWtznfxO99Bpm22mq7WhbCgCBhtC0iaxeD+dgQKn+mbqdUUXzaGF5lqQ68mdpzzlF0G1YXRArUAwEe2wR9zbjCBf1p0VC1kBSmQW/TX4I8n7FLbrH2xNKPzdNxsbPkO2s9aIVHIE2zuvWNTyLEVV4r5zf8T0dIoENYoZjpF5wPBn5Tu76ia0b6ePOramZK7yPO9erjWR6J3evOQ+a4M2o5tVMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqqPyr8idqf0atEypc+loE/0FiFAY1+CeRMM5A45LGM=;
 b=F1QP88RqR0cb+Gs4nGa34ULVWWP2OPGAmedcoSLbTlW9ViDw/rG2xG2HnNC+eI3CV4Hu4ZzxYrhW+w7O/vR3Wq62gVQjvWuY+8xku0i0rVkIwdAGEG1umfHx0XEajSHOCfJuIBTlDOemQ2tRJ7+sfGsX/VT5cYjsjh/KNxNaT1g6n2/rn5OKWLgYJEUcYc/5JxG76CxtctCITZXmwa48F89a4Qz3BZ+9fMzMF9lhwRRJPp6fmZjuhDKpeAfJjomCyfLzGhHeymt7jRVuJpcd1Yv+0CGp6e6w7IcrzsWiJoPST7ePsrNdfSiOamS7VmsYP95FtSXuqAlrjIeA+9QxNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9676.eurprd04.prod.outlook.com (2603:10a6:10:308::13)
 by DB9PR04MB8252.eurprd04.prod.outlook.com (2603:10a6:10:24d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 28 Nov
 2025 09:15:45 +0000
Received: from DB9PR04MB9676.eurprd04.prod.outlook.com
 ([fe80::97c:438a:2968:465d]) by DB9PR04MB9676.eurprd04.prod.outlook.com
 ([fe80::97c:438a:2968:465d%4]) with mapi id 15.20.9366.009; Fri, 28 Nov 2025
 09:15:45 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	sherry.sun@nxp.com,
	dmitrii.lebed@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: [PATCH v2 06/11] Bluetooth: btnxpuart: Add TLS device hello processing
Date: Fri, 28 Nov 2025 14:44:38 +0530
Message-ID: <20251128091443.2797316-7-neeraj.sanjaykale@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9b6cffd8-4f7e-4ea0-4f00-08de2e5eb5ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6OVhDUmjuYIkncd5Bpe/DbydVQMrxm7lVsTPEyaNSG/Mk/AnsxO7tnKPoXnS?=
 =?us-ascii?Q?WxxkUCy9L6US7HnXIf6Bo5WW5z7LVM2/++YMoKAbyxw6xv8vAPV4KmKWP+BT?=
 =?us-ascii?Q?XAoJ5f6zH7s0JGVXPcECuXiN31wlo93vILh+Pn7mE0xApCle+/ebN3jcBxQp?=
 =?us-ascii?Q?qWyk3mpKjw9IrbPw6vGqJBKspejXInwet6XrPW+3Mmcpmm0kUQ18iYWpTdtq?=
 =?us-ascii?Q?RaxhkalFM+ikePNVvjQ1kj2MOpfrlBNtF9MhEOl/o3FRi7SV8Zp+4JapAKjv?=
 =?us-ascii?Q?hsIMvYaTeiUX47B3kw0EIWmxHH+qRodc8KZq6HytHCu5WPlZ7zF3W1uQpAMj?=
 =?us-ascii?Q?PePia/V5+VUTm2AwktSXed8yoKxydAJCH3RlWQBSGLzhdK+6c5RYZb3P2B42?=
 =?us-ascii?Q?Hf8yMEHwQ50XYkhjoMK1ecpz3QSv0Up6PMaoo6q8bsP6qqiih51XYNi69kF8?=
 =?us-ascii?Q?Wb8FGD159ryn7Q/oT8khmnUxeMNPDgvR+RwH04riP7F7uGzotrm8tv2zEJWY?=
 =?us-ascii?Q?ttNkzdmWLlNuJ07DCrUOWmPB2hviy7WxsDEOfzLTh71bdf0S1B+E3B4J24lk?=
 =?us-ascii?Q?ADUAlNJXu4tLAqt4PZor0ncEJDTW2cR4efY6tGxKdezHB7MWmYHFODZV9DHy?=
 =?us-ascii?Q?up8UtAaJslz1ZuWKsw5yVBT74fwsgoohpK77XQu7iqTajAEgoWKVuyJbRzkj?=
 =?us-ascii?Q?MbHU8r+Hf6T1Ss+RRpPzXfYVvUoGSqfpNrFOehl5/8/ehFtKQKfkTXxrQvdD?=
 =?us-ascii?Q?M1xm+PlzRm43SUVVvT9eT+x2v6MqlkVoxPRn9X2PgUuuEU5jMXILtGzrauYD?=
 =?us-ascii?Q?76qMgPqmk2rP8m38pB20X3/BMg/7UbwszqiRyW02RxeknA1vAna7KTL8V50K?=
 =?us-ascii?Q?xGukwjRxXVr4eHEks2/f09S/m724bg/uqU6jvgUdqdaUIqr2QrS/1uk5HS3C?=
 =?us-ascii?Q?v/qI5QuLkpAG+dF/8jpAKcwWzsqnieH01dNeJKUq8ytJyxiD24D14P1f2C02?=
 =?us-ascii?Q?wbXd+blKpnyP5yRNcTmyaNhP3GzswV+vPyn/JcK98QwWPiNKgLCtQTncUD/I?=
 =?us-ascii?Q?9xyyVsM7XLlTD0LfPc4OztgpsLxW5RDx553BXL1J5KxanAuD3C4LmBxrffWb?=
 =?us-ascii?Q?aZRlqc+Qg2fkm308x5iSw+CzRcDLJFSj/6Uy7ZT3LkWJa+kwHJ2qAuzbjZJP?=
 =?us-ascii?Q?UHJxP/TIPW4owTYU/EALToCy41zAn2k5v8BYMlIcY9NwfLFEmjl+7GE8xMgg?=
 =?us-ascii?Q?FSnDrdSh0RRAuszwkNPtADryEiCkrhojzivmovMhJM/5GGbr5WiQereMssP+?=
 =?us-ascii?Q?nKYz5wduQkvh1K3/r1mr8HB3/WnCZck/TFWa6tkdrGVm+ZvnJ/x78Ui6Zcze?=
 =?us-ascii?Q?wL5DJ5WhSAmpaFfsZ56tEvO5MHd2QmHMwEKB3Z8VD4u/yUo4Ui7qFjRGBo9B?=
 =?us-ascii?Q?8VO3IDnx9j5Bg9EGekomIm0mrheOBY8I+HQ69ZeDiQh/AxodM/v8pxChojWv?=
 =?us-ascii?Q?xONk/2LMggATK0XVaDe1pQFAt1M0gZTdvJTX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a8q7EOm6KGihGGJF4nUzm9JVk2InQ6lVGHQkCCd/GnGGPhKAxUaZBqWP2A0a?=
 =?us-ascii?Q?yVvV9N7xPV7LbSD8rwJF+zPyhpOL/61qfMO0Zmllt3fO4+xc3Vmn659SzqEt?=
 =?us-ascii?Q?LI29qdjwsrEQAsUxvaqVqp4T85srysVSa/c4+Ke0o50xFuzu27SklMxetpk4?=
 =?us-ascii?Q?xaTtIAi3QK4gysDRkgoUCJSkulVzV3dpr6UKD3mfK9h9UGdOYV/QzBpHp+xh?=
 =?us-ascii?Q?mtMFUBnyEo1WnPrh6D7r2fZ8cdD4KaMw2ZrxHS1vp5U++WSRj6e57lngSGDn?=
 =?us-ascii?Q?c9r4fdHe+gdUoke112NNclR9mIJE9AwbG+khBtnoI7T0aUeYgZTTSRk+u1Cu?=
 =?us-ascii?Q?FNMqqm5mW2Uj4GkOjVqVf6inn3Rk01pIZL/SNAiclAeyFO8m02ODIatSS/pX?=
 =?us-ascii?Q?0GwgEvGj1TQBxuVSM495nfCbjFTTLsG/T48nMFgs11xLeTB853zIv2ii97W5?=
 =?us-ascii?Q?hN2JKtl3Ta1tXeMenwGbq+hbsU2a1hS6n0BlbWrM2RwayMbdEweioxHnbEV3?=
 =?us-ascii?Q?qi0kyUVv6LKfVRR2Z+S1VcNJqp2JYF73WhTVr7ntt96Jryl6YT7UvLNjh6ID?=
 =?us-ascii?Q?KaFWyAYFngWn1so0bVsixrcE7H7GZqGRzuB+VkYJhFPbEPNiJqVkbaAWqYW3?=
 =?us-ascii?Q?8GOVzdXXqUyHpF2znhvbiFmREu2QigYHhtpzzddUOKGfEw/Ovct/KFy9cgbO?=
 =?us-ascii?Q?/ymVFHb3SQ9CPZGdmwVaqWuWYD6XQFpdxuWjUspOwkBTkiFMg5jgxeu8w9VJ?=
 =?us-ascii?Q?qc4CP2KmeXS843SKQlzJPjzKfIztgOAvk0ohR9AL5EMgh6ssedXVi7qIxel4?=
 =?us-ascii?Q?B2XSczFLsL8ppzDbqXm4DVtDMdacgcxHu7n7WNrURX2sbWSt8nP/RiPByhvl?=
 =?us-ascii?Q?CnUNeuvmI4fogXvxJmv3Qalxt/7+rfAMHZgZiM9d11JtGIOUAF39pKr9LYLq?=
 =?us-ascii?Q?j5n47KOWf84RaWbGaRYsppRvDpSt0VDYOml6PPhP5B/Jnx/kslX7LmvQGcXI?=
 =?us-ascii?Q?P7Z87hxZnbRHuiET+SOp/9xIhUCwRzgEK3itPggcaP8lrSdBX/P/jNQOriRr?=
 =?us-ascii?Q?LxXWo63f1JxwuXfEnqOCqYOnByKoKb8QLcz3iOdfSN9yxW+HD1rpCGVw5dV7?=
 =?us-ascii?Q?x31PahZuVdmmdG+a5ZzRkzPai4SyraBkfZc6tZ8AC2y8nUiCjCJHAxHRwHvy?=
 =?us-ascii?Q?yv52A5KvbVvOKOjY5jfcEH7ZEKN4ZwNGTbRELs/EIgbJqkkAThVbGOaAbQeo?=
 =?us-ascii?Q?gPf5g9W460e7/wLGv3PxjFAg35GoLPUspmIdpgE2lnkovFm0RThw+LAuJ5vk?=
 =?us-ascii?Q?5LwGY/4jtwWC4CLmjbD6cZa8xWOFqoSeFwzwLIRPFNlVA/dpv7SB/8G5vawr?=
 =?us-ascii?Q?zZfVLrw25UXWQgnh8f+N7txY2IWTO95W6Q4O0bvIF1x6xn6/xMhFzhkbq9Pw?=
 =?us-ascii?Q?beRJqp4MKKGNW/v9BpGS3hz6JBpCh+5dVtAAW5/RonE+CUkBRbmOpLFvDXNo?=
 =?us-ascii?Q?1zmqBd/uMBCt1L96J1g1tmpQCZpCVCRXJztStRfCSqS7CQNKpA0GY7KUsEnd?=
 =?us-ascii?Q?7revpDOdz4ADP6DyvpV1v5C+H+BsY7ki/LGrrqiwWdYTsXCaEHyoaL9zy155?=
 =?us-ascii?Q?Ow=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b6cffd8-4f7e-4ea0-4f00-08de2e5eb5ea
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 09:15:45.0747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2nmVQOQ7KCQQkEo3OvI0NAGk63Y9o0F/czMatC0xpzMSBwL82ja1mUjDFa3bVryyTf3MjHys8qd1Q+AqEr2eyZrzfYKEeDaFvBoffiOrLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8252

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

