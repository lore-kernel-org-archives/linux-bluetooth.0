Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010052.outbound.protection.outlook.com [52.101.69.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC3F314A89;
	Tue, 13 Jan 2026 07:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768290435; cv=fail; b=mEUWBQpygmbWg0HSC1pePLN0wbNsV2UdwBzg4Ypr1j1ChikQopa/XH69Dm/t42kDJzDbvaUehpNPOjaGEw5bbD9hd9diqM2mN09496OKpL2ZToL8oKO/hSWK9inIAUr7Tqlr5S4v31xSh4tvY6GsdRrNZYMI3xqNeVp77LGw/HY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768290435; c=relaxed/simple;
	bh=CmaiCwS45Me+s454rXQi2XdQHRTBGAPTV4b19nqDUGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P3L9k45LuvacEyNMyTxnrUjkS6r4Gsni6ev6vMPFesvVnzKhRFsAxc6KhYlyNo4GowB7HCemgLbIER/KCIAPYpWP7nJpqC47lthQg8RYfJt40CJ/QJstGW4TEBNwgmp7j2T6yn0eQ6868wQzCMLqxB6ZStzwjRywrye2FyniLs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W3dLPFcy; arc=fail smtp.client-ip=52.101.69.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W3dLPFcy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iv4O3qdO7nfX8gxKQOSeuhcVNJaiv7k5LfHwn/+++RoyK1q+KuQ40/9fY0xpmcMJwO+46/qiMoOYmmEUkq64xHzj/v0zuPZeUdUtGIg8E3NSSpqG9iQag0mNxNjoaEjfTkFQ75+9hvE0ILzDgT96+A1WxhUyj6U53djtMLGb0bBvdIP9p70MLg1oB4TKH4RXZ2omVmPyiVA/wnnfIe5dmnD2VYHr8Pr7yef2o6ZZ6hhgttxeXqLoncug2Vy+1V9uY1KfOsxE/g1z+eoJqFZd/2Ol+poJGveTVv4npNuonIvsHHN8Z+Aa4f2Ungb/M+Xt+dJLo8ykWFvIIMXiUxWIVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvyUPpjImRls9SVxtFgJP0Ji0abVMi7jLMTMOCKM3I8=;
 b=NTEyCl9MTcC11hMTAAKcNnb78TKEoHTMhK8PqQgjAR3sxK38cr4KQWEhElZ2sUecAQD/QO4JnsUMyVI/rEEu6jrNu43+1x1yWMErusVOcJQYC5LMI9JMIaCCYkNyUagsMYAq+O1lNmeRZUcC4smdtmFR3l3egf3QsFeLUnPssd4XMTCMTUXukOzKCnlQD7/UuH9hFGQWenK/LSQ8toiFNhi5v0sPJCAFRuJMKEvALairkU69TtZM8PXEc9oDb1p0IlEgta+kPv512lVqQpiEWDHzHU8M6qhl3HhBTSPUgRULUl907empJYCiinU4Nl1tVv6RWDZaprIAroOOtypffA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvyUPpjImRls9SVxtFgJP0Ji0abVMi7jLMTMOCKM3I8=;
 b=W3dLPFcyE3iaCFi7YABU7DCSjqw0X58ShSDidXUkqcO3DiLFVn0e6td1iOfuYEyLOzochkGBlcTxSh/MYnDtl+4ZDlnjm0w4G5IcdY527ZwOQgFLf6RuBkaObxkjlR78HP1/mFEDHDFA44UCIrtPani2QJDaMYeOrniSGi4SPkir3qHfd7abgutZEZOKKLFo5kVaw5eBU4pljcprjj10bXYajxtzqzSh6b4Z4df2CeZsgWH+JLjt/UxQ827vM1VvcZUSHBEAGVO/YqxLTQqwd8Gunt6/vZj1Gr4qf/WwvlafAG3nahxTmuVIZGR5nepTxFZoJzbiaHdvjrHM8FXJWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PAXPR04MB8144.eurprd04.prod.outlook.com (2603:10a6:102:1cc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Tue, 13 Jan
 2026 07:47:05 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.9520.003; Tue, 13 Jan 2026
 07:47:05 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	dmitrii.lebed@nxp.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/11] Bluetooth: btnxpuart: Derive traffic keys from TLS 1.3 handshake
Date: Tue, 13 Jan 2026 13:17:15 +0530
Message-ID: <20260113074718.2384043-9-neeraj.sanjaykale@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 29a91da1-fb25-449b-3102-08de5277f260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|19092799006|1800799024|38350700014|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HIzpqmw4Ow9iFh3rLFKsrA2Yq62PFpqsN34MTHBo8vqNoXqEDychAWVJELoP?=
 =?us-ascii?Q?6j4OvrruHtD0DTVIgcl2SadJXVOiJ8Sln0/pJd+u5HH67fOkGVqG6NFrCyBC?=
 =?us-ascii?Q?zoRwB7DEMO9fqUl1ByymSixjrvdyIMh0QCoEZVc64Vi/hk+5HjCPe/1IEYN/?=
 =?us-ascii?Q?tq7ULtvGFZ1kKit/b9JZ0dExV/Y7p42X7+LuTg8E0ESc6QfYr4T51WY5K0vy?=
 =?us-ascii?Q?D7hLh7/Rr/7hS0DPPxpAYtUWWv0Q4j5zU4nG9gkyyxZ0+dVRvmLcQmClzrZn?=
 =?us-ascii?Q?riH7r2Fft0QKGI/t3rjHaEYSeu0L28BXbS4VDD2vEEtRo+3juusbJm1Ug+V0?=
 =?us-ascii?Q?zxV+loXSodSgZQw1wa8hf1QXweXI3s0ScMAV8trJVPfff5NEkesxv+tdBD0G?=
 =?us-ascii?Q?Y4Ur7GsQZZB0zIxe7/AMO8d5xdht9RFyr5jyBD3hsEEnBQa0SrZrYtlVKzeR?=
 =?us-ascii?Q?YWAmW7bK5Xfe5PlRFzGDdAikT8ewhViNWrhmoWJ6sBr5S4P6RE31JqmlWAyR?=
 =?us-ascii?Q?seLP77FI2bm9cKPGZ3TZMJVVGDh00O/KS2EGg1OUZbCcFfpuwdgK3/PZtB3D?=
 =?us-ascii?Q?Sfl9uZgdvMO+aaYHCDdnfy5L2Kg6hXtcXXH6/qLEqX9bzLHtCap/kBO0fGVc?=
 =?us-ascii?Q?pG9PZa2/i/7Q/TQG7Shza0Go+XNALQIOcVzgNeTqeh0f2SUhKtbs+kaHjvad?=
 =?us-ascii?Q?e8c35KkIKxZbjnPJDZvfNfjmnB+Acyu3zF9BxKFi98SWevv+/PVzEuwr86e7?=
 =?us-ascii?Q?nnKs2+2spFrf1A0+i5+bmJEtrQQa/zo1rhUuD4r04T55F0MNj0Qcn63yK8i3?=
 =?us-ascii?Q?MJhonoY1n9W/2slOPB6S/tlUSD0pnG9IG3NiFeAZmeWbnWA7FmkvZNk2aOeo?=
 =?us-ascii?Q?Cb8s7/fHcbKBTeozgwrovhhF3BbWWL/1b4iyTcfyzIi4L0isybZI/m1TBOvj?=
 =?us-ascii?Q?/DG6LOZriutw6uxYZUILXR7mDLsI4eyzVkeB25DQ3pyN0POg1CFIPaXkEvlh?=
 =?us-ascii?Q?GSwQ5oeu30vKyF1pE2ZCI4oOtSTzFw5LheUBGU1032/tr0afB7GVptqbgHvo?=
 =?us-ascii?Q?645izuJUgn6NRjAv3Fzitjeely9uj7Ar6/HKgbOeuW5rOVBOY1Mafe/NzvCP?=
 =?us-ascii?Q?GGO0GX6ZxT2ltDBqGBy0YfdUjFJLJ7VBBueZ28VkryOtp6+/aMAdnGbAoXww?=
 =?us-ascii?Q?DJ/PSRwc4pZbcNloaruP2yxJ9WzFT+Vvjc+KwA9ZRp9KgdUMAGMEdtXIC5DU?=
 =?us-ascii?Q?Ue/eO6kcFX6FbR77cTwXYu8he8wkuGFnjEzrKxLrD94Scb42eUhi5iALgpcI?=
 =?us-ascii?Q?ijWDoIpf2bvgtYTqcrIaVbFQr4dgFmUHVnZGnvDXv6kHHPnMhP9GboK1GA5i?=
 =?us-ascii?Q?rZPk4B3ZVoABSiqIGjFZsKt3i0Jt/Nqmt+Hgx0oXbJ5LvVPJQWwW67xAeyYB?=
 =?us-ascii?Q?EvjHQmIvzErq4ect9kZYtqUdah7yuYrWire3Id+pJU/c8nmAvr1VQshBpYDr?=
 =?us-ascii?Q?nK6DEmImGjaNKULnRsBJSWbjGcOU5D9dr3pm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(19092799006)(1800799024)(38350700014)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UHv5FvjZ3ma2m5XCo2IWJaz8b9MweQPQ2J3rJ4RtkfaXHEAkdM4zfF/9xvJD?=
 =?us-ascii?Q?Zf7rhX0op1QxrNVYr2GmgUTjugIyVFWbeBte9vo2nvsad9h2NAUrvSW+1L2M?=
 =?us-ascii?Q?Ed1jhFMqvk6OpBOQP7MEkhnAla2vQu1BcXiKM809fCSRPy7obcXwvDl8maam?=
 =?us-ascii?Q?IxTnHxLOu2worqnhEL5MFS4Pjj2jY9Y27d/D5o/pt5NHUHGBoWWPoBgA4FDY?=
 =?us-ascii?Q?cWmFHzwkq0ekqtx/Nr+7zresCm46BLk3icWiMSJveo86/iXCDxHyJ/JqNq9f?=
 =?us-ascii?Q?JBocio4y97RvnJkx/9bfm/JCy/KxxWhOAA79d6wOWdFnJU4KYPnEYzAstrQa?=
 =?us-ascii?Q?C3t6jk93Gr7DZIqpdeYmuohdxCkPtLDzIvIzrYqEoPcyGHEiqlAUKnEosgi4?=
 =?us-ascii?Q?2HqsEZoMadd5ze4sVfenzBvWYaRXeCzy31sqtIb/tOZNL5og1boSB27avkQ5?=
 =?us-ascii?Q?Ff+Guxy1cZSYjJx9TLMyVBhugdmo0NeheyrcRxXo3ffYrU6R5REQu/dCdzA5?=
 =?us-ascii?Q?MUE8Rpln0CYRjCEolaiqu3J23lrVW1xCrnWdSAWRvgt3matqg++jP3rk7HqH?=
 =?us-ascii?Q?Wvmv80P0ufXQ/bSAoyEsuFJN2GUtNcvaFW091YnqB9F3uC6L1Ec2eHsvmAMk?=
 =?us-ascii?Q?EaXcvCzilLxE6Z7kovFoxT4gg35OBjEs1wA8THMX9fKpXO2cVHWdR90sGrJ+?=
 =?us-ascii?Q?po2WzOJV7WiGqeL5Qy3X2tfdedsqhdIuJlVWvVGuDkD0D6tLYq4yjI17J5TC?=
 =?us-ascii?Q?IipflEbAlQ2K4JP+zm4LgQCKO8A+diHB1MEPuVMfKL2GplofpPxd1wBAz8yq?=
 =?us-ascii?Q?999TwYFXQx/U6BHVkM5YwvmNXZNqt3Q5mswMMw+flGEI5x0ZSQ/CLwlr64lh?=
 =?us-ascii?Q?mEx5Jdb85P/VGB2RWdRr7Ui0amhjgvk1juJqZKS20gz7dgFgx/5XugpTtAgN?=
 =?us-ascii?Q?6iI+OV3MdjSgbBvlea/ssQ+1TIp5CBmrCXac51KlcpRbwBje91QbwyTY+T9T?=
 =?us-ascii?Q?RmGIDw550mA2XjvZulJal+zSoSE7Kona1GwyGSpjkmptmeOa6hyPqF+rWmwR?=
 =?us-ascii?Q?tUGur+KqFhpm1WdHuB7CX8OjOhqPRDfsgj5vYSiHgmeDxiwTqIs8SqKxMmnv?=
 =?us-ascii?Q?rlWUSsj0YcK06tyaoiXsVPxvxxe1lDKQkNGANb/b+lzRNH/CuCep3PFPXwgk?=
 =?us-ascii?Q?+EeWT3lyXfd8tYA+7onasn9SXwYEyxk4dRZbnhxZc0je4OinuKt78XK5suGW?=
 =?us-ascii?Q?th7dkGtA4O+5SVKxQt7Ulx0mtDcrjzzdXj6ZNtd5lAypbkc0uLS4iYK5bFc+?=
 =?us-ascii?Q?3kzNSskWw8G9PR/aqzZ8Lf1y7OXRrvJDJnTKu2BKkIPc3wXT7tjLJccBV/XG?=
 =?us-ascii?Q?YYdLud0zUTeOiPOHIOuKS2xBBg9IiNYd92WxJB/ZHd5VOsf2wa6Y433pGroa?=
 =?us-ascii?Q?23qc3n2AMmWbVcQ4nwDyJRySY+T6lbcl5wdxQLfEmLMttxR1b6O+EMxwalwL?=
 =?us-ascii?Q?HJ/0fKkI4C5UZC00TNizYEI9aAwK3w7Hy5HE+Dk6lXVH57UOxTMXeezH9JV6?=
 =?us-ascii?Q?ifm/bk4m2eKcKMJClPaD0LpBqfYIXfrzcK+uCtnATro2AyCK7KMfnKCZVXJk?=
 =?us-ascii?Q?0u8oio0gaWJBZcWZDJHCESdinoqMMfL3TeLfzA+GGbZPtSbJxrPZD8mWaUTC?=
 =?us-ascii?Q?wnrYMpKCWWd/9RtYTOb7w7zhs9Y3IC07iK0HSTfL+3eJ3XTH62ioTERlNBRm?=
 =?us-ascii?Q?1pxHHpN2MfWSa2NYwjRoLMFBdsXUQL8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a91da1-fb25-449b-3102-08de5277f260
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 07:47:05.6748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SCXWYm+ZWmadaiuozmPiIKli7ATKSKchWgoQF6XQPlSEbtFD08AtV0xjgeKnqlE0CHETSLZNjKP4MySJA/6kss9e2izEuvz2vEZKZ/gamiY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8144

This completes the TLS handshake implementation by adding master secret
derivation and traffic key generation. These traffic keys will be used
to encrypt/decrypt sensitive HCI commands, response and events.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 88 +++++++++++++++++++++++++++++++++--
 1 file changed, 84 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 9ed4cece7e42..cabed02e0964 100644
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
@@ -2526,6 +2541,71 @@ static int nxp_host_do_finished(struct hci_dev *hdev)
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
@@ -2580,10 +2660,10 @@ static int nxp_authenticate_device(struct hci_dev *hdev)
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

