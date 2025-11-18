Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011016.outbound.protection.outlook.com [40.107.130.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DE13624B3;
	Tue, 18 Nov 2025 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763475674; cv=fail; b=o7tOtpJEJdh8s9FiQ6cah/Ka2t+8rFj3CbREQIfVNnAUfxPsinMlGAs/hpsILOAjoFm8vBj5pcBJaQBvKuZaSEtWYRVswcGre6WLuGmNidyBwNcyvykkDcC4Q3SGKxEsgTqDw3bCKqwsOOP91hxXhP8fYPlYWafk26wj9xKSQHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763475674; c=relaxed/simple;
	bh=IHue4TZVcBbS57tj6ujtchivXOHI+sA+upxbVGTWhiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dVnZW5lkqtuN32BOtdRmJH7YJ6y4HxEcSY87DhzubWVf839N8IfPNcr7v1XqTCu+V1WH499vzxIDCT2ocMrGf00N++gVBtmWAKUv5gyGfQ+Hs/nd420Tv8o680kAQyuUY+alkDNLDyrxVuwNBvBpCccr3uQXj1q8Aqq5dAc3T3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f8A/U3pg; arc=fail smtp.client-ip=40.107.130.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f8A/U3pg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRBLr435HrwR/0rb2v71HlyLvjTjyy4ppvpGJQedTB4hpQo3r4xaZJExbCdKb8zNNcYIsovmMG3P14DJ84MPUvaWD6oMt+ioc6Wa/EnmBlN+DHUsoMAm3ox68SqlEd5lafkBaMJpnppkukzyqktO/kaKrSIEjTbmzXmNsnFVjm7dAVSvsbkrgSyDhUVcOnT7mKc4KZFMpREGS+S+nTc9wUin7qdmNrwnNXJh8ZSjkIU870iWhOIY/0qxsEi3RPqbw1XB6LzD0YjHV3LMTbe6v6nCfZNxrD1ejHsfnHZTdKLhOtQOm0PtOHSiflPqBlHcCLylBiHj9LCKAaglwA1S/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYNZcdAwOPVa6z9FGveGiEe0RMiiEle6nFACz8hedJ0=;
 b=OkdJvHmhngW+QYZ2ESQzOSk9M8uvcOPoDKMcqg0AlRsjCT/fG2ZZa0PVPLVHJ7EQ+TPUOLK3hO/GMRD1nlXzZLXIwdpbxYlfZAlzCMmdIBgf9JxmluJwZ9q/0FfqtHQ367An/1PIaqM7zI3e8Q5A/5wZh6rJ0qTzHl0ZWpKp8WBE63JSpyqm3ykmbo6PSOuvVpNexEaXEIthYiF8fpdPjQte/YXGqNyH1/bgtV2o78WVZ9bRbBP9/V+NIKkSJ2BviKK1Q1uveueuZZltzdtHXK3GfnPt+u1FK9VJ2zkjBOURuLlnV4Z90dk9ZzPzR5CE+dwwdVOaO/TXl4RiPBEZnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYNZcdAwOPVa6z9FGveGiEe0RMiiEle6nFACz8hedJ0=;
 b=f8A/U3pgvC20dMRhwzklRMzGW+rAlAhEwmgQU4nlQW/RwTkpuOZYBJ32Z+nvVsusn7hfOMsRl19eU8boKv7rZ5LlzVfo551w5I/qMloOoKoJgkIuAEICrWrPtOPlJJN0AOFwzTUFHtPCjI9cnfBIXUxEhvTQprBWjC2g7+STjpyOEvxNPM50o56dwsIh36AJMPdrj/mQ97Zgtf34YO1KNhDNgvpYiememxRsh155bGOwbJcHrjpZL0TehzT6x8b0gyvpG5uA96uhSkb7AokCbdllHBwlNItqG1OAGDfo4suDeEfZnd72w+6XtqIS8FSqYTDrfS1dTbdf66Kp+f/JKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PA1PR04MB10179.eurprd04.prod.outlook.com (2603:10a6:102:460::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 14:21:06 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 14:21:06 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	sherry.sun@nxp.com,
	dmitrii.lebed@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: [PATCH v1 08/11] Bluetooth: btnxpuart: Derive traffic keys from TLS 1.3 handshake
Date: Tue, 18 Nov 2025 19:50:21 +0530
Message-ID: <20251118142025.1982263-9-neeraj.sanjaykale@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|PA1PR04MB10179:EE_
X-MS-Office365-Filtering-Correlation-Id: a2c305f8-dc5c-4b75-b8bc-08de26adb605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FjXiZPEiAg5CzeSUj9NGO5YgWvakvhKKyrkE4YtIe2qptli5MahPuneMX/tv?=
 =?us-ascii?Q?SwlDheK0ST5HRIt+WflCLAwgy4kl5qJG4KKJaqlbiQeCgkm1gP9r8uNbIlhh?=
 =?us-ascii?Q?APCBk8VVCHzqNyU3SgCHGz1JCzXdRUeQSzpJWmcoozZw77K66QDAUN/Dwt8y?=
 =?us-ascii?Q?WvRDESMl38N8cx4j97aev9fpXBVycPfMpKYKfhtt8fobxoLHJr2pBhBE/Ozc?=
 =?us-ascii?Q?dtnwRD4JI6AM2k2ga8WSFkOhm9jaKMeNGgAe9O51F+eUM7/8qoDI74cCul+C?=
 =?us-ascii?Q?Ai9yBR69waEqYDJuq791SgH+FvE/S48YTJ0Y9bpe9iN1bOeq0xPCo1MprN/U?=
 =?us-ascii?Q?HCo44mSAh7PdnqRgeD7HlL+vE4YMEBrlpwM3WyL6/fIipsvl0F5bcrjNL/3D?=
 =?us-ascii?Q?Ke43fP6BX9dPbCu1bokPXHlmAo3NGy9r0aP1ni7Ib7IGMyn1ye4RjVMhKWgx?=
 =?us-ascii?Q?SDFy7pJ1b2KRZlTDF2hsYu31jxP1bvsp7hPdkoPrMjJAJNtNj4DmfY4LO5dB?=
 =?us-ascii?Q?itJ97AchRUzPPfGZFo3qC1RATxGB+FYivBKaI4LhfKq5H8IuTttBScB2TBDM?=
 =?us-ascii?Q?f96dc1IlYAeTF0FiWqrsnT3xIkAMFG+xRh1LrXpcGvuzH5xpKCTXwNig9Hj/?=
 =?us-ascii?Q?Ho41ieEcASxiYzyZmP5xjWDy+4VH3jUgV+/ZoOtlIKtvnu6g0bfun7iGxkhG?=
 =?us-ascii?Q?CdvRn9ejs6PEPnN1iDyMWiLNmGsSJXSsiOtADaRnC7+f2+M1oVU4en9yzYct?=
 =?us-ascii?Q?Uw0j1I+bJgX2ODJ4bV0GKoBoYflF7nifPtz4KUit+H4PJQ3VHWpD1pi1Pkj2?=
 =?us-ascii?Q?tc8uhP1r9nO5S8jgAFANJUnFgAPtCMpbCeGw1GHHqURREfT+5+GCKds8qeN7?=
 =?us-ascii?Q?1XAlNrJUsKKLagyaR0Zz9cQhVztXC1iT3Pdm/OsjaIfWg6h5R+JYdL1dHlI3?=
 =?us-ascii?Q?Cfi4zp8j1Kgx7xDlFQIC5z8cL6H1uD1tqoEvitCq/1xK+V+9LPAUH2qCFwwB?=
 =?us-ascii?Q?v7D09ED3ZyYSiPXB4H+kdXMlcBQVI3jQuAGhXzgVwpnHDkzz6TfnehYl8azY?=
 =?us-ascii?Q?7yeIbY535CSJF4aYyx9TSkz3ckaxD/soy0CHiYRwzUFT8l3uerjltlYWKFUk?=
 =?us-ascii?Q?1iW2Sv1ncGLrbbmC4WRzULo/PpG2FPFNL1l+etzTp7jgx2FffW/g4dWpnR3A?=
 =?us-ascii?Q?L4gb2kMVfKd6x+gGDEcz7pmB+cEJ6UFIS4z4gvEIkSSTLTBFQ9pcUuEyCNIM?=
 =?us-ascii?Q?VgypBl7DTkHQS3AX8Sm9XnYnejQxIqavPaKowuT4FC8UWi/CiXI0LCSUU8ez?=
 =?us-ascii?Q?uFN3pQaSB1aA/KrL73idbYzXk/IU6k7o5TuE3tITlf+i/F7raYJ/vAYUHJC9?=
 =?us-ascii?Q?IDpRJ1YRuiAVGaMGXidkPh4LKsSkF8g7r9gRqX5GrT79kbq64AeWokC1vVfe?=
 =?us-ascii?Q?01QCK03kSuI8J0YCHyQGbhYKzWeumd6PHT/4RwBwyVOh15N5sRZZZkdvngVU?=
 =?us-ascii?Q?mEOpQ5jdGduECtmPtTkA4k/drgCHOrDMoDFN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kpk190YFDv6e1bDletyqUJwjAg/2rHR/JwZjmk+AVXELZOa/z9NrJb2Awt7w?=
 =?us-ascii?Q?m/BfkuE/DZzraBfMcfTfWbGL01lWu4718YwPjOIDpQPB6h4R0XbRp8zo6C0q?=
 =?us-ascii?Q?cS10FUmnQO1nRGE9n6xydIcdYua+dlzuM+nUOFKDE6TjizpFvje91HuTAdcg?=
 =?us-ascii?Q?qhNsAsRDr26dcfmWQaG7mQgZWp+9TYwbrofnGvB3nFxBJuFNNTS8KGfq8w3z?=
 =?us-ascii?Q?qNNJ01jiU08SDlLnzUIt/BcTYiUGysNs1LaYVsPuV2q+dPldkvdxhGQomLDs?=
 =?us-ascii?Q?nAD+D5Gg5CpgX2hfWm/yIJOA6NTIdKs/HedgIBOL/SSEK5GQl9usUa/H4+LE?=
 =?us-ascii?Q?Ua3zdzD4/EN9CMggcdusfwPE5tsSoCRTrenkf2Nic3XTmw4Zkt8UBZJjz42r?=
 =?us-ascii?Q?aLipLszE5QjvQCzMt76O5b2Bhe6gI6RxXKV+PwO4mNMn5M8fFOFQp84kllF0?=
 =?us-ascii?Q?3lMyerMtov8Nk8AjIVdqrpLNnHis/a6fvKxDlyCyhfbihcktnI3lBTCsftkH?=
 =?us-ascii?Q?+Baxw89M63QMkSN/rUhVWSY0LUaA08onGEkqp/fet8+y+ARSpQ1iar/0Y1F3?=
 =?us-ascii?Q?drFW089M5od5RWYWmZWJYlMw076W41SwgTdhrt11SUmxCzMhF/iXzAXIt93n?=
 =?us-ascii?Q?wIVrX8bHTAMzLWrTelZrtzhMEbdSvyJ3SQBXUq4DG5IdL0lGuneEBGYtm91t?=
 =?us-ascii?Q?m7j1Fa0Qxm6gNoJH9wmFOfLxvI0nCFRNiN0BAng3R3RM1He6u1ZyXyQ2QldG?=
 =?us-ascii?Q?f1WBDt3k1pboKipzJYne7WA/U2Wa+sbXHbRDxJ2GdCi7vkrBxM9eSNDAqhSa?=
 =?us-ascii?Q?OEvB3Q0hzLL4onGM2ZEeyZdDv4oNsJSdQ5zlXio7W5xFRSuRTYNfx984EUKi?=
 =?us-ascii?Q?/sfWoToQ4YJVMF/YHw1AsndvdqvKMB5uEj3SqJCNzs2AWP6sw6tCVOxfshhN?=
 =?us-ascii?Q?UFOLPxNjSfDWZUotCPktZgNtR0Qu14D8mKvrXhz3BNYpceYrLrjLjntE3+KY?=
 =?us-ascii?Q?UXz4l3eF1MBpqFD694D/w1nsB0Rs6wAGj4Sbn9k/35cg3TuTUF13OsfUuDkw?=
 =?us-ascii?Q?wXHd0npOBPi0a3ZF7M4KYdT3PHOGYOVD267qEt+cympC9YLAT30Z+JuOBovy?=
 =?us-ascii?Q?+A+s9WFVkenG3AIZ2gcC04P1CxlhfqSH1K5XPrvP5xFIkbztdVQBx0jHWyWs?=
 =?us-ascii?Q?5cOx9z0/2GYxrrnquc/rsdSjtS3kic+iS069Iqyg+zHBCTUFqucDgI4Gk925?=
 =?us-ascii?Q?vhZL2hHafc/s3RZXSarXWtASUhQ8qp/bll0AiWF7xNfymQRuHw+kaYxg5uq9?=
 =?us-ascii?Q?smmbSf7qZElq12aMsxXhkShP6BK4yZaPLa7bB3DU1YYQsnWmyWxxCOgN5p01?=
 =?us-ascii?Q?yRG7HwAbS2FGLDExSHVuBavbCTCOHnP2IIfuL9QBFvg825W1eK+2PO+hiBYW?=
 =?us-ascii?Q?GNK8bCgcWKO0qT8UrGBzzViwsEzURxuwVi5RBeqZHn5hBaVyJp0D5UlDd6di?=
 =?us-ascii?Q?qi9Haqj7icFVtPXZ3ySFK9uD8+3KzSpsxgz3xI3VTeEl8JkLAPoE2MAcAsCf?=
 =?us-ascii?Q?AdTlzdbQD5KtlL/9SQrtAVqenWJSxeikusdAhssV4QXWIKmF3VTHmzIY5IgD?=
 =?us-ascii?Q?Vg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c305f8-dc5c-4b75-b8bc-08de26adb605
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 14:21:06.0456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5nePR69QioaVfA3oxOi/U2et/5YlA6YpyGSaDbMuNy2bfqMv4bgaQZ44keGrEVav1hoRUL3T396z3g/QnhLlZkXTVPrTXL7iGl8xaf0pm7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10179

This completes the TLS handshake implementation by adding master secret
derivation and traffic key generation. These traffic keys will be used
to encrypt/decrypt sensitive HCI commands, response and events.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 88 +++++++++++++++++++++++++++++++++--
 1 file changed, 84 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index bfe6a138d78d..4b03b0321e82 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -206,6 +206,16 @@ enum bootloader_param_change {
 	changed
 };
 
+struct nxp_tls_traffic_keys {
+	u8 h2d_secret[SHA256_DIGEST_SIZE];
+	u8 d2h_secret[SHA256_DIGEST_SIZE];
+	/* These keys below should be used for message encryption/decryption */
+	u8 h2d_iv[GCM_AES_IV_SIZE];
+	u8 h2d_key[AES_KEYSIZE_128];
+	u8 d2h_iv[GCM_AES_IV_SIZE];
+	u8 d2h_key[AES_KEYSIZE_128];
+};
+
 struct btnxpuart_crypto {
 	struct crypto_shash *tls_handshake_hash_tfm;
 	struct shash_desc *tls_handshake_hash_desc;
@@ -215,8 +225,10 @@ struct btnxpuart_crypto {
 	u8 fw_uuid[NXP_FW_UUID_SIZE];
 	u8 handshake_h2_hash[SHA256_DIGEST_SIZE];
 	u8 handshake_secret[SHA256_DIGEST_SIZE];
+	u8 master_secret[SHA256_DIGEST_SIZE];
 	struct completion completion;
 	int decrypt_result;
+	struct nxp_tls_traffic_keys keys;
 };
 
 struct btnxpuart_dev {
@@ -416,7 +428,10 @@ union nxp_set_bd_addr_payload {
 #define NXP_TLS_KEYING_IV_LABEL		NXP_TLS_LABEL("iv")
 #define NXP_TLS_KEYING_KEY_LABEL	NXP_TLS_LABEL("key")
 #define NXP_TLS_FINISHED_LABEL		NXP_TLS_LABEL("finished")
+#define NXP_TLS_DERIVED_LABEL		NXP_TLS_LABEL("derived")
 #define NXP_TLS_HOST_HS_TS_LABEL	NXP_TLS_LABEL("H HS TS")
+#define NXP_TLS_D_AP_TS_LABEL		NXP_TLS_LABEL("D AP TS")
+#define NXP_TLS_H_AP_TS_LABEL		NXP_TLS_LABEL("H AP TS")
 
 enum nxp_tls_signature_algorithm {
 	NXP_TLS_ECDSA_SECP256R1_SHA256 = 0x0403,
@@ -2525,6 +2540,71 @@ static int nxp_host_do_finished(struct hci_dev *hdev)
 	return ret;
 }
 
+static void nxp_handshake_derive_master_secret(u8 master_secret[SHA256_DIGEST_SIZE],
+					       u8 handshake_secret[SHA256_DIGEST_SIZE])
+{
+	u8 zeros[SHA256_DIGEST_SIZE] = {0};
+	u8 dhs[SHA256_DIGEST_SIZE];
+
+	/* Derive intermediate secret */
+	nxp_hkdf_expand_label(handshake_secret, NXP_TLS_DERIVED_LABEL,
+			      NULL, 0, dhs, sizeof(dhs));
+	/* Extract master secret from derived handshake secret */
+	nxp_hkdf_sha256_extract(dhs, SHA256_DIGEST_SIZE, zeros,
+				sizeof(zeros), master_secret);
+
+	memset(dhs, 0, sizeof(dhs));
+}
+
+static int nxp_handshake_derive_traffic_keys(struct hci_dev *hdev)
+{
+	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct nxp_tls_traffic_keys *keys = &nxpdev->crypto.keys;
+	u8 hash[SHA256_DIGEST_SIZE];
+	int ret = 0;
+
+	ret = crypto_shash_final(nxpdev->crypto.tls_handshake_hash_desc, hash);
+	if (ret)
+		return ret;
+
+	ret = nxp_hkdf_derive_secret(nxpdev->crypto.master_secret,
+				     NXP_TLS_D_AP_TS_LABEL, hash, keys->d2h_secret);
+	if (ret)
+		return ret;
+
+	ret = nxp_hkdf_expand_label(keys->d2h_secret,
+				    NXP_TLS_KEYING_KEY_LABEL, NULL, 0,
+				    keys->d2h_key, AES_KEYSIZE_128);
+	if (ret)
+		return ret;
+
+	ret = nxp_hkdf_expand_label(keys->d2h_secret,
+				    NXP_TLS_KEYING_IV_LABEL, NULL, 0,
+				    keys->d2h_iv, GCM_AES_IV_SIZE);
+	if (ret)
+		return ret;
+
+	ret = nxp_hkdf_derive_secret(nxpdev->crypto.master_secret,
+				     NXP_TLS_H_AP_TS_LABEL, hash, keys->h2d_secret);
+	if (ret)
+		return ret;
+
+	ret = nxp_hkdf_expand_label(keys->h2d_secret,
+				    NXP_TLS_KEYING_KEY_LABEL, NULL, 0,
+				    keys->h2d_key, AES_KEYSIZE_128);
+	if (ret)
+		return ret;
+
+	ret = nxp_hkdf_expand_label(keys->h2d_secret,
+				    NXP_TLS_KEYING_IV_LABEL, NULL, 0,
+				    keys->h2d_iv, GCM_AES_IV_SIZE);
+	if (ret)
+		return ret;
+
+	memset(hash, 0, sizeof(hash));
+	return ret;
+}
+
 static int nxp_authenticate_device(struct hci_dev *hdev)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
@@ -2579,10 +2659,10 @@ static int nxp_authenticate_device(struct hci_dev *hdev)
 	if (ret)
 		goto free_skb;
 
-	/* TODO: Implement actual TLS handshake protocol
-	 * This will include:
-	 * 1. Master secret and traffic key derivation
-	 */
+	nxp_handshake_derive_master_secret(nxpdev->crypto.master_secret,
+					   nxpdev->crypto.handshake_secret);
+
+	nxp_handshake_derive_traffic_keys(hdev);
 
 free_skb:
 	kfree_skb(skb);
-- 
2.43.0

