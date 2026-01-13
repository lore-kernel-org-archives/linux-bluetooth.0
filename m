Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013008.outbound.protection.outlook.com [52.101.83.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A363242B5;
	Tue, 13 Jan 2026 07:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768290452; cv=fail; b=BTYrQw/H/j3Hg9fLa45KxKAenXR5O//SDQw2z4OfkdUoCIObLvpaYe77DZ5g16D0wge40Xy6HUc2Pb7vL0PIcxCM6037RkhRvON3CQg6rIk8ibwtTdDzzNzObjsxnHpNLDwnjI3iF8WhKYKHMe1J07NuYgaiql3tgnqCWhdAUVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768290452; c=relaxed/simple;
	bh=IGWO6NoGxkaNaAj3nk9Pwgo/oxIJu7cVi4x3Q1GMOSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dXYfddQJigIhD7wGYDURKy+xC1iEwSms+3sfNzQfPt2MPb4J+Zr/CV/yCJO7AeEYa35pC3wO/mBNXbcy5Am/mL+9QjMNQ50IottkD4tdgG4af7slkJKXeF16zxJqF2rJwJvrvWtAly1jAbVbe53OOa44XKaGIzOcbWFIdI9trIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gn8JpPhA; arc=fail smtp.client-ip=52.101.83.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gn8JpPhA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQPzqzn9Hd43iuAhlw4Bx3IerTmw6VPGS6Lo+78rJgqlh10q56XhZly3zDMyPFgyAXOPGmJcRhPt+wm9ccMAIDu78utPaBoJP5XFcA76lvXXf3nTLt5HK2HjHtiYKjSfC2N0FCndKugV1Of6nwJolPqPicUn+Uu7R4z/aiAIPU43VASj0xGQcoInSz8WrTRywWVg8xcfHqXFT9uCreMEQvpe5fTebLIF/EmBr941YG94DeI7+aFb65tq8i/ItfnIQDASsZCEQPnaYGxHm5oeBi/g0PRPuHbVfj67ZUlCHV1OGjy9F9cOWyp6QzRPH18XKc3jtYp4NzhPKu+O2jrb9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtJI53yQlAlHMiWfYSdkyUiGhEbLBlPp91w/jJcr92c=;
 b=bHt3RAcbHUFqWK4o1P1kNSpVJ0XQUPrnvlJE546AMC3AKDSLqV/AA8lxi2fsRIUNJ0O01Ldn+ool2dds7bP1bXyHgTjcHtP9a5IXkjp9ICVw2AjshFReoP75/iXUuSl5xiEUkuWJTY96+WS466lov5bIJxi/NqA1qDWEzNh+jASW9noaRLFptpofB3PVlX+Jz8PudB5xrmO8iovsrJsfwQEr3A5sJg5iZNnrjBQkBPKcOnW+fimwa3/JMtl+Gm3jAi89sFLodKgqnTRpf6dyvkzshaTvAdQYqa88DqafXh6gWMPoKWwOeGc3Pkj4uOETtLtOCOu1OnYYzGhrVp6wbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtJI53yQlAlHMiWfYSdkyUiGhEbLBlPp91w/jJcr92c=;
 b=gn8JpPhAhMVNlWL+b0JMPPWWMMqCi1JdyUZjZUW0Ttj8vB6v0mWUBTsIv6Tp+h5XHmc4vytKqRqg83eUupffIN/VFqHVFtMx9F0EYe2jGTNRAcvgGSgfJbkxRK26fEGKguhO0Af13TqYLjWKlxBeFJVCMk/n7hOIanw8wSwZ7+eUHv6+/EClVCzHBcvn1X6741J4vhd7SpN/sQBCkfvqn6m60K1D1Fm1AZ5QSVLOT61gti7Xb4vZQcMRGUzhgaEEZZ9mV+eJttcXmepfcvc9pSfMRdu+ctMi+7wd5FzYQdOF8Giyu1EYw9NHKZsQpKtjyGCyCdiHPChin4aZ83yqfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PAXPR04MB8144.eurprd04.prod.outlook.com (2603:10a6:102:1cc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Tue, 13 Jan
 2026 07:47:03 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.9520.003; Tue, 13 Jan 2026
 07:47:03 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	dmitrii.lebed@nxp.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/11] Bluetooth: btnxpuart: Add device authentication
Date: Tue, 13 Jan 2026 13:17:14 +0530
Message-ID: <20260113074718.2384043-8-neeraj.sanjaykale@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 556cd2b7-22a7-4e53-308b-08de5277f12a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|19092799006|1800799024|38350700014|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dlfcedsVjMub5A2gn2Y6CwKYojfFa4IDKH4Rj2UThP4kbKPsCTLEjreJOuFu?=
 =?us-ascii?Q?aE0+K0SBQjJrQq+CZd0aSzhaPoXxpkkJBp5jP3IML2QoqAW2O5JBRAVSdpMt?=
 =?us-ascii?Q?3h4sALrVBtycOq0+0BFSEzEwzzcV4shDm0B/sJuap7VIdS5O94z88dF9XR/t?=
 =?us-ascii?Q?hQveTFn+A3bXXvR9JqySkLlr7NiMuKyvYJakl8RfN2Rc4BsDrXK/59igAsVT?=
 =?us-ascii?Q?8Y7noiFqaanfev9QBDK6fZZVQjyWBiT1iJs9bo7u1APd3jpooApIJWGbRmhZ?=
 =?us-ascii?Q?yubgQxuVbnh7eomCfNc0Wd2aPXfs3VSXhFdD/oevxdsfyHVu55ingAYciEJz?=
 =?us-ascii?Q?+TWInP2Et8uQrtfvLHSsj6fZQOMrUt6Xu7J14MlPDOMoY9SaAIV3FxPNFpOl?=
 =?us-ascii?Q?TGFdsn8Qk7KrfnOLcX86r1xCbnF+sSdydaaeBcsoYCXCoQtvl4eZIi+WqHcM?=
 =?us-ascii?Q?O+7UFkI9YwRS3UF/lIxACfMIJCejtLunZZrntCM/wIvzZkm0gmMtuRAqqsb6?=
 =?us-ascii?Q?xrA49FGCqUH9gZYAzq2zW+yzI95h8CtlZ4V996wWDpugj+eJeQyDl8e8EyOL?=
 =?us-ascii?Q?LL/q9QcHxxAcJc3BueIOp9Y0pw/UShxkKcDVnErGhTHzGgGnPSirvymApvh8?=
 =?us-ascii?Q?b+4K9Ivkm3avz/le2P4Y+S+EM/rMPdQDu/0n3Qtn88VQR/80OE0q4OkQjUJK?=
 =?us-ascii?Q?5zIhEOhRBzDNv8S3AVGxUiO1+UyypKjht8kdIbtywGbSh8s4TwYthFtwIQ/f?=
 =?us-ascii?Q?uB9x8NP0fFnwh/xmMNDgDTbGAtx2W4PegugeKjSnsee2ffet0w/GZffiBlXL?=
 =?us-ascii?Q?GC+UFIGEQQFzomn1wF686nMH+NBKlZcwMa7ZzGzmshMb04JY9PuM4rEXHB5m?=
 =?us-ascii?Q?NdPy0wz2Rmd0lZ+G5RWnMnyGNLCgKNqL10STbF5iK4pvTX/R7zrMZpjI1+Mx?=
 =?us-ascii?Q?rf231hj0UKZRB014qhUzBMk/aahpTmrWvq5+bpT6sH2fiS0pO7xk6ITAfddk?=
 =?us-ascii?Q?nQEHGZlJKEHBkj56X2/t5aFOGZ8qWAdHMG15E/fQpacRjPLKMSAY6MGLdvlv?=
 =?us-ascii?Q?sgjEfCQub3LhpWMHBuQ3/B+QA4E1QGQwDUl2cQnNm6VnBhz1Z8uhBtUoN7zT?=
 =?us-ascii?Q?iEJegP90TQR8f1Sjo+LobwzcqstWDIsi7k5kq+aljruSv/t1p/vyisYjiCpI?=
 =?us-ascii?Q?a7meFGu2bgfYtImpG1OauqcWKCV/ZrGGz4jgiMd3tbYkCzln9qssk503ezsK?=
 =?us-ascii?Q?XWDptAhfNQfRi3r97ZZM7BRiCktcnTOT559dAkn/CfJiExuOhsHi0GREWCVe?=
 =?us-ascii?Q?+jM8wjdk+EvKk6NFdFeuj5yU3PHS/6k7f6mYtKNsoJ2/ITFYKzDlpip/kTTn?=
 =?us-ascii?Q?CtG7tiG94P5O1KcsNOWfq1xM5tdz9F0OkCKGmMXUn5wMVx+flk2OaPEQS6g2?=
 =?us-ascii?Q?RXU/fCP0FmrePtzNStAgbUcxKHF/GZ+nTG9cYWIdtP2CtZBPf06vHJHY2lEl?=
 =?us-ascii?Q?i7O99bxp/by1mCQA8eWM54G/XpFnb9DfuxSB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(19092799006)(1800799024)(38350700014)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BbFBoz9yD6Oj46tA3G6xoj5/qTm4R0LeRVCBGxwqUP1QxLhFu0XQvYbtv8MW?=
 =?us-ascii?Q?ySx89TsnK5gTlcBTnOJrLYqkbY2vWaW06f89oocpgfkng29vQZuSE/rbFxrg?=
 =?us-ascii?Q?A88gxKaFlGAJOkIFwB+KTf+9RUOCWX6JA0bTPT3087PQyfLKmC2TcnV3MDVg?=
 =?us-ascii?Q?tT9RfeV3/6OtGqQIDpvPWNyLMBsrNj2WSK1t1IJ2zz5RapkVNTMf5aV+0KW8?=
 =?us-ascii?Q?xaOsLdKtVU0x7JgSK9TEOJ8ORqnmShBb1cNjfnCRFne8hFwF/RI59zKRWuAT?=
 =?us-ascii?Q?IaDmyoUguIwiOkRugbC8TuieWWqXKRIy1FkloaO+i0Nt0GQKMIOo+AwOv8LW?=
 =?us-ascii?Q?EqyYI8kWdIvQy5SfoEwDoeHwGRWVnVzIL0N0/xnc40CW5HIl6La9lPbxcWlh?=
 =?us-ascii?Q?kjephYJLY0XuVFJ3LdOXODf4a9FHcBv8hg4JQOUTgRQ1KPorwXqPxULcsz/i?=
 =?us-ascii?Q?+U/dGO8Rfd7LAFIXlEJWEH7r2AsE9aCzbznB7SwvJn3Kz+xVe+F8cgZHFg3C?=
 =?us-ascii?Q?agt8cI55I6BBM2DGS5uUfCzYxJDF0Os5BjoQRIAIYvM/8rWYm6vHtIAgu05g?=
 =?us-ascii?Q?S/UydPEMXBEuPxj63tQsgqtvT2vqZ1uJgHvKMh/baE7zh1t2umwkMNK6Jrnf?=
 =?us-ascii?Q?19yRWPYSrFx2U2be5QMSrsYWXmIDqeUveESBBelsjcnY1BF5MKDMUFg4qD1Y?=
 =?us-ascii?Q?LffPKQpweqffYUYSvKaS6g7ovGAjmigyS/lbiKaFhx+0bprC+BYilQv+9PZK?=
 =?us-ascii?Q?7Lj05ZTunV+Xc+ismFNWpA4YaKCZyo45AAAfXJtd4/xfD7SOK/VkRpf4EbEW?=
 =?us-ascii?Q?cisA5jGXZ3dhS84gFpfJ5iI+52EAcnt1ccB5XDZFWLk+H7tI6uaXcfxlEXb7?=
 =?us-ascii?Q?lXbcHox04DSRkQ+W2M8/7CH7Ge4LxUNdKTRQPbJX2WAzpSFV3e6zGoQ49dLB?=
 =?us-ascii?Q?6TH3k7f8ddze6iVQcUe+76tlmSxzV7smBoc/3sssLg68BHAyJM5ap4Alb+Kq?=
 =?us-ascii?Q?/2FjrGnliqwb2b9le8ZY08ZTFx+5IMhwuTih5zmXqli1aTSSdohUYeABLll0?=
 =?us-ascii?Q?7KXqHBDMCCR/7vz5Syc8x9mDN7pC3mtDL26Nj+PteU5SFyDnfJqMOrZGUIr8?=
 =?us-ascii?Q?Ra8Qb8rNAg2hAf/w6aTMuzcd6m06PCMfDoSyKIoOBPCl35Zsv5x1irFiNlcO?=
 =?us-ascii?Q?InGAuk0/BEI66GqgEqqrBBMJ6yOLDt3fTjoqSWjOlsR1wOcjA3tSnIo6GCkf?=
 =?us-ascii?Q?W2AQ4EKMHCJWdKRxhMXyfAutmnYq7t38ccOYpPU9HpqWrz2ZS5a48AKeFTVY?=
 =?us-ascii?Q?/o3rw/cF/lMlQDVJ/ekeUkbGs04d82Bjrf3HpNE+YKw90xic7wlw2+qBwFsr?=
 =?us-ascii?Q?his4O4SZq1kblSfXBuy4Y/nZ3q8vvOpfcNWZJgsxx7lLkxGxrSH7QMHp+rJA?=
 =?us-ascii?Q?Zqv5Hn/r2NgGxv1yO4QJTrMQKNTsScRPFbD03TNu1Upk7DeCQQZz1CqEB/Hb?=
 =?us-ascii?Q?6VR+Quzjs8A570/KtpC1MElArHhszvPTXuIUdNvHx1FqPk7v93HButFMTkcj?=
 =?us-ascii?Q?P9CWWS+rRgXVqzNhHhwJTqtNwlC8aw3KsDKLwOkEpyRIouQ2wu+sFLu69Utl?=
 =?us-ascii?Q?+xKeW9A7CXImoLBu+xWAvuPS7OSHb+LRThpcxEFzHIF+fwj9v+k1AxdxsVLF?=
 =?us-ascii?Q?aFIGsDvd7QH4tVMyMBgHWMZqfX3SE053ffWtZpXd8wJpjgvAj+Ha23EjSaga?=
 =?us-ascii?Q?oHFkqbqV+8A1tXyqwUGVkcpGRZHkLoA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 556cd2b7-22a7-4e53-308b-08de5277f12a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 07:47:03.6666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nrvkXS8e8BbGT/lMJoc0foeTfyidkUkRI4UgTVYoeOYX47+7eaVSXQ5l6OcSANQFA2ZtTcKO+Zj84h+zO1B7OyqZbF92ULtHgnN9WX5IN2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8144

This implements secure device authentication during TLS 1.3-like
handshake with ECDSA signature verification.

The authentication flow:
- Derive handshake traffic secret from ECDH shared secret
- Decrypt device hello encrypted section using AES-GCM with traffic secret
- Extract ECDSA public key from firmware metadata for verification
- Verify device handshake signature to authenticate device identity
- Validate device finished message using calculated verify data
- Clear handshake traffic secret after successful authentication

This ensures only devices with valid private keys can complete the
handshake.

Key components added:
- AES-GCM encrypt/decrypt with traffic secret derived keys
- ECDSA P-256 signature verification using kernel crypto API
- X9.62 to P1363 signature format conversion
- TLS 1.3 finished message verification
- Secure memory cleanup of cryptographic material

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v2: Fix sparse warnings. (kernel test robot)
---
 drivers/bluetooth/btnxpuart.c | 504 +++++++++++++++++++++++++++++++++-
 1 file changed, 499 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 0e71f68a408e..9ed4cece7e42 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -27,6 +27,12 @@
 #include <crypto/hash.h>
 #include <crypto/kpp.h>
 #include <crypto/ecdh.h>
+#include <linux/scatterlist.h>
+#include <linux/completion.h>
+#include <crypto/aes.h>
+#include <crypto/gcm.h>
+#include <crypto/aead.h>
+#include <crypto/public_key.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -204,11 +210,13 @@ struct btnxpuart_crypto {
 	struct crypto_shash *tls_handshake_hash_tfm;
 	struct shash_desc *tls_handshake_hash_desc;
 	struct crypto_kpp *kpp;
-	uint8_t ecdh_public[NXP_FW_ECDH_PUBKEY_SIZE];	/* ECDH public key, Key negotiation */
+	u8 ecdh_public[NXP_FW_ECDH_PUBKEY_SIZE];	/* ECDH public key, Key negotiation */
 	u8 ecdsa_public[NXP_FW_ECDSA_PUBKEY_SIZE];	/* ECDSA public key, Authentication*/
 	u8 fw_uuid[NXP_FW_UUID_SIZE];
 	u8 handshake_h2_hash[SHA256_DIGEST_SIZE];
 	u8 handshake_secret[SHA256_DIGEST_SIZE];
+	struct completion completion;
+	int decrypt_result;
 };
 
 struct btnxpuart_dev {
@@ -405,6 +413,10 @@ union nxp_set_bd_addr_payload {
 
 #define NXP_TLS_LABEL(str)		str, strlen(str)
 #define NXP_TLS_DEVICE_HS_TS_LABEL	NXP_TLS_LABEL("D HS TS")
+#define NXP_TLS_KEYING_IV_LABEL		NXP_TLS_LABEL("iv")
+#define NXP_TLS_KEYING_KEY_LABEL	NXP_TLS_LABEL("key")
+#define NXP_TLS_FINISHED_LABEL		NXP_TLS_LABEL("finished")
+#define NXP_TLS_HOST_HS_TS_LABEL	NXP_TLS_LABEL("H HS TS")
 
 enum nxp_tls_signature_algorithm {
 	NXP_TLS_ECDSA_SECP256R1_SHA256 = 0x0403,
@@ -478,9 +490,42 @@ struct nxp_tls_device_hello {
 	u8 auth_tag[NXP_ENC_AUTH_TAG_SIZE];   /* Auth tag for the encrypted portion */
 };
 
+struct nxp_tls_data_add {
+	u8 version;        /* NXP_TLS_VERSION */
+	u8 reserved[5];    /* zeroes */
+	__le16 len;
+};
+
+struct nxp_tls_host_finished {
+	struct nxp_tls_message_hdr hdr;
+	__le32 reserved;
+	/* Encrypted portion */
+	struct {
+		struct nxp_tls_signature reserved2;
+		struct nxp_tls_finished host_finished;
+	} enc;
+	u8 auth_tag[NXP_ENC_AUTH_TAG_SIZE];   /* Auth tag for the encrypted portion */
+};
+
+union nxp_tls_host_finished_payload {
+	struct {
+		u8 msg_type;
+		struct nxp_tls_host_finished host_finished;
+	} __packed;
+	u8 buf[125];
+};
+
 #define DEVICE_HELLO_SIG_CUTOFF_POS \
 	offsetof(struct nxp_tls_device_hello, enc)
 
+#define DEVICE_HELLO_FINISHED_ENC_CUTOFF_POS \
+	(offsetof(struct nxp_tls_device_hello, enc.device_finished) - \
+	DEVICE_HELLO_SIG_CUTOFF_POS)
+
+
+#define HOST_FINISHED_CUTOFF_POS \
+	offsetof(struct nxp_tls_host_finished, enc.host_finished)
+
 /* FW Meta Data */
 struct fw_metadata_hdr {
 	__le32 cmd;
@@ -1700,6 +1745,38 @@ static void nxp_get_fw_version(struct hci_dev *hdev)
 }
 
 /* Secure Interface */
+static int nxp_get_pub_key(struct hci_dev *hdev,
+		      const struct nxp_tls_device_info *device_info,
+		      u8 ecdsa_pub_key[NXP_FW_ECDSA_PUBKEY_SIZE])
+{
+	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	const char *fw_name;
+
+	if (ecdsa_pub_key[0] == 0x04)
+		return 0;
+
+	fw_name = nxp_get_fw_name_from_chipid(hdev,
+					      le16_to_cpu(device_info->chip_id),
+					      le16_to_cpu(device_info->device_flags));
+	if (nxp_request_firmware(hdev, fw_name, NULL))
+		return -ENOENT;
+
+	nxp_process_fw_meta_data(hdev, nxpdev->fw);
+	release_firmware(nxpdev->fw);
+	memset(nxpdev->fw_name, 0, sizeof(nxpdev->fw_name));
+
+	if (memcmp(nxpdev->crypto.fw_uuid, device_info->uuid, 16) ||
+	    nxpdev->crypto.ecdsa_public[0] != 0x04) {
+		bt_dev_err(hdev,
+			   "UUID check failed while trying to read ECDSA public key from FW.");
+		return -EBADF;
+	}
+
+	memcpy(ecdsa_pub_key, nxpdev->crypto.ecdsa_public, 65);
+
+	return 0;
+}
+
 static int nxp_generate_ecdh_public_key(struct crypto_kpp *tfm, u8 public_key[64])
 {
 	DECLARE_CRYPTO_WAIT(result);
@@ -1971,6 +2048,320 @@ static int nxp_hkdf_derive_secret(u8 secret[32], const char *label, size_t label
 				     output, SHA256_DIGEST_SIZE);
 }
 
+/*
+ * The digital signature is computed over the concatenation of:
+ *  -  A string that consists of octet 32 (0x20) repeated 64 times
+ *  -  The context string
+ *  -  A single 0 byte which serves as the separator
+ *  -  The content to be signed
+ */
+static int nxp_handshake_sig_hash(const u8 transcript_hash[SHA256_DIGEST_SIZE],
+				   const char *context, size_t context_len,
+				   u8 output_hash[SHA256_DIGEST_SIZE])
+{
+	struct crypto_shash *tfm;
+	struct shash_desc *desc;
+	const u8 zero = 0;
+
+	tfm = crypto_alloc_shash("sha256", 0, 0);
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
+	memset(output_hash, 0x20, SHA256_DIGEST_SIZE);
+
+	crypto_shash_init(desc);
+	/* 2x hash size = block size of 0x20 */
+	crypto_shash_update(desc, output_hash, SHA256_DIGEST_SIZE);
+	crypto_shash_update(desc, output_hash, SHA256_DIGEST_SIZE);
+
+	crypto_shash_update(desc, context, context_len);
+	crypto_shash_update(desc, &zero, sizeof(zero));
+
+	crypto_shash_update(desc, transcript_hash, SHA256_DIGEST_SIZE);
+	crypto_shash_final(desc, output_hash);
+
+	kfree(desc);
+	crypto_free_shash(tfm);
+	return 0;
+}
+
+
+static void nxp_aead_complete(void *req, int err)
+{
+	struct btnxpuart_crypto *crypto = req;
+
+	crypto->decrypt_result = err;
+	complete(&crypto->completion);
+}
+
+static int nxp_aes_gcm_decrypt(struct hci_dev *hdev, void *buf, size_t size,
+			       u8 auth_tag[16], u8 key[AES_KEYSIZE_128],
+			       u8 iv[GCM_AES_IV_SIZE])
+{
+	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct crypto_aead *tfm;
+	struct aead_request *req;
+	struct scatterlist src, dst;
+	struct nxp_tls_data_add aad = {
+		.version = NXP_TLS_VERSION,
+		.len = cpu_to_le16((u16)size)
+	};
+	u8 *ciphertext;
+	u8 *plaintext;
+	int ret = 0;
+
+	ciphertext = kzalloc(sizeof(aad) + size + NXP_ENC_AUTH_TAG_SIZE,
+				 GFP_KERNEL);
+	if (!ciphertext)
+		return -ENOMEM;
+
+	plaintext = kzalloc(size + NXP_ENC_AUTH_TAG_SIZE, GFP_KERNEL);
+	if (!plaintext) {
+		ret = -ENOMEM;
+		goto free_ciphertext;
+	}
+
+	memcpy(ciphertext, &aad, sizeof(aad));
+	memcpy(ciphertext + sizeof(aad), buf, size);
+	memcpy(ciphertext + sizeof(aad) + size, auth_tag, NXP_ENC_AUTH_TAG_SIZE);
+
+	tfm = crypto_alloc_aead("gcm(aes)", 0, 0);
+	if (IS_ERR(tfm)) {
+		ret = PTR_ERR(tfm);
+		goto free_plaintext;
+	}
+
+	crypto_aead_setkey(tfm, key, AES_KEYSIZE_128);
+	crypto_aead_setauthsize(tfm, NXP_ENC_AUTH_TAG_SIZE);
+
+	req = aead_request_alloc(tfm, GFP_KERNEL);
+	if (!req) {
+		ret = -ENOMEM;
+		goto free_tfm;
+	}
+
+	sg_init_one(&src, ciphertext, sizeof(aad) + size + NXP_ENC_AUTH_TAG_SIZE);
+	sg_init_one(&dst, plaintext, size + NXP_ENC_AUTH_TAG_SIZE);
+	init_completion(&nxpdev->crypto.completion);
+
+	aead_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
+				  nxp_aead_complete, &nxpdev->crypto);
+	aead_request_set_crypt(req, &src, &dst, size + NXP_ENC_AUTH_TAG_SIZE, iv);
+	aead_request_set_ad(req, sizeof(aad));
+
+	ret = crypto_aead_decrypt(req);
+	if (ret == -EINPROGRESS || ret == -EBUSY) {
+		wait_for_completion(&nxpdev->crypto.completion);
+		ret = nxpdev->crypto.decrypt_result;
+	}
+	if (!ret)
+		memcpy(buf, plaintext + sizeof(aad), size);
+
+	aead_request_free(req);
+free_tfm:
+	crypto_free_aead(tfm);
+free_plaintext:
+	kfree(plaintext);
+free_ciphertext:
+	kfree(ciphertext);
+	return ret;
+}
+
+static int nxp_aes_gcm_encrypt(struct hci_dev *hdev, void *buf, size_t size, u8 auth_tag[16],
+			       u8 key[AES_KEYSIZE_128], u8 iv[GCM_AES_IV_SIZE])
+{
+	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct crypto_aead *tfm;
+	struct aead_request *req;
+	struct scatterlist src, dst;
+	struct nxp_tls_data_add aad = {
+		.version = NXP_TLS_VERSION,
+		.len = cpu_to_le16((u16)size)
+	};
+	u8 *ciphertext;
+	u8 *plaintext;
+	int ret = 0;
+
+	ciphertext = kzalloc(sizeof(aad) + size + NXP_ENC_AUTH_TAG_SIZE,
+				 GFP_KERNEL);
+	if (!ciphertext)
+		return -ENOMEM;
+
+	plaintext = kzalloc(size + NXP_ENC_AUTH_TAG_SIZE, GFP_KERNEL);
+	if (!plaintext) {
+		ret = -ENOMEM;
+		goto free_ciphertext;
+	}
+
+	memcpy(plaintext, &aad, sizeof(aad));
+	memcpy(plaintext + sizeof(aad), buf, size);
+
+	tfm = crypto_alloc_aead("gcm(aes)", 0, 0);
+	if (IS_ERR(tfm)) {
+		ret = PTR_ERR(tfm);
+		goto free_plaintext;
+	}
+
+	crypto_aead_setkey(tfm, key, AES_KEYSIZE_128);
+	crypto_aead_setauthsize(tfm, NXP_ENC_AUTH_TAG_SIZE);
+
+	req = aead_request_alloc(tfm, GFP_KERNEL);
+	if (!req) {
+		ret = -ENOMEM;
+		goto free_tfm;
+	}
+
+	sg_init_one(&src, plaintext, size + NXP_ENC_AUTH_TAG_SIZE);
+	sg_init_one(&dst, ciphertext, sizeof(aad) + size + NXP_ENC_AUTH_TAG_SIZE);
+	init_completion(&nxpdev->crypto.completion);
+
+	aead_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
+				  nxp_aead_complete, &nxpdev->crypto);
+	aead_request_set_crypt(req, &src, &dst, size, iv);
+	aead_request_set_ad(req, sizeof(aad));
+
+	ret = crypto_aead_encrypt(req);
+	if (ret == -EINPROGRESS || ret == -EBUSY) {
+		wait_for_completion(&nxpdev->crypto.completion);
+		ret = nxpdev->crypto.decrypt_result;
+	}
+	if (!ret) {
+		memcpy(buf, ciphertext + sizeof(aad), size);
+		memcpy(auth_tag, ciphertext + size + sizeof(aad), NXP_ENC_AUTH_TAG_SIZE);
+	}
+
+	aead_request_free(req);
+free_tfm:
+	crypto_free_aead(tfm);
+free_plaintext:
+	kfree(plaintext);
+free_ciphertext:
+	kfree(ciphertext);
+	return ret;
+}
+
+static int nxp_handshake_decrypt_verify(struct hci_dev *hdev, void *buf, size_t size,
+					u8 auth_tag[16],
+					u8 traffic_secret[SHA256_DIGEST_SIZE])
+{
+	u8 key[AES_KEYSIZE_128] = {0};
+	u8 iv[GCM_AES_IV_SIZE] = {0};
+
+	nxp_hkdf_expand_label(traffic_secret, NXP_TLS_KEYING_KEY_LABEL, NULL, 0,
+			      key, AES_KEYSIZE_128);
+	nxp_hkdf_expand_label(traffic_secret, NXP_TLS_KEYING_IV_LABEL, NULL, 0,
+			      iv, GCM_AES_IV_SIZE);
+
+	return nxp_aes_gcm_decrypt(hdev, buf, size, auth_tag, key, iv);
+}
+
+static int nxp_handshake_encrypt(struct hci_dev *hdev, void *buf,
+				 size_t size, u8 auth_tag[16],
+				 u8 traffic_secret[SHA256_DIGEST_SIZE])
+{
+	u8 key[AES_KEYSIZE_128] = {0};
+	u8 iv[GCM_AES_IV_SIZE] = {0};
+
+	nxp_hkdf_expand_label(traffic_secret, NXP_TLS_KEYING_KEY_LABEL, NULL,
+			      0, key, AES_KEYSIZE_128);
+	nxp_hkdf_expand_label(traffic_secret, NXP_TLS_KEYING_IV_LABEL, NULL,
+			      0, iv, GCM_AES_IV_SIZE);
+
+	return nxp_aes_gcm_encrypt(hdev, buf, size, auth_tag, key, iv);
+}
+
+static int nxp_p256_ecdsa_verify(const u8 sig[64], const u8 pub[65],
+				const u8 *hash, size_t hash_len)
+{
+	struct public_key_signature sig_info = {0};
+	struct public_key pub_key = {0};
+	int ret;
+
+	sig_info.s = (u8 *)sig;
+	sig_info.s_size = 64;
+	sig_info.digest = (u8 *)hash;
+	sig_info.digest_size = hash_len;
+	sig_info.pkey_algo = "ecdsa";
+	sig_info.hash_algo = "sha256";
+	sig_info.encoding = "p1363";
+
+	pub_key.key = (void *)pub;
+	pub_key.keylen = 65;
+	pub_key.algo = OID_id_ecPublicKey;
+	pub_key.key_is_private = false;
+	pub_key.pkey_algo = "ecdsa-nist-p256";
+	pub_key.id_type = NULL;
+
+	ret = public_key_verify_signature(&pub_key, &sig_info);
+	if (ret)
+		pr_err("ECDSA signature verification failed: %d\n", ret);
+
+	return ret;
+}
+
+static int nxp_device_hello_sig_verify(struct hci_dev *hdev, struct nxp_tls_device_hello *msg)
+{
+	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	u8 hash_sig[SHA256_DIGEST_SIZE];
+
+	nxp_handshake_sig_hash(nxpdev->crypto.handshake_h2_hash,
+			       "D HS SIG", 8, hash_sig);
+	return nxp_p256_ecdsa_verify(msg->enc.device_handshake_sig.sig,
+				nxpdev->crypto.ecdsa_public,
+				hash_sig, SHA256_DIGEST_SIZE);
+}
+
+static int nxp_write_finished(struct hci_dev *hdev,
+			       const u8 hs_traffic_secret[SHA256_DIGEST_SIZE],
+			       u8 verify_data[SHA256_DIGEST_SIZE])
+{
+	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	u8 transcript_hash[SHA256_DIGEST_SIZE];
+	u8 finished_key[SHA256_DIGEST_SIZE];
+	int ret = 0;
+
+	ret = nxp_crypto_shash_final(nxpdev->crypto.tls_handshake_hash_desc,
+				     transcript_hash);
+	if (ret)
+		return ret;
+
+	ret = nxp_hkdf_expand_label(hs_traffic_secret, NXP_TLS_FINISHED_LABEL,
+				    NULL, 0, finished_key, sizeof(finished_key));
+	if (ret)
+		return ret;
+
+	nxp_hkdf_sha256_extract(finished_key, SHA256_DIGEST_SIZE, transcript_hash,
+				SHA256_DIGEST_SIZE, verify_data);
+
+	return 0;
+}
+
+static int nxp_verify_device_finished(struct hci_dev *hdev,
+				      struct nxp_tls_device_hello *msg,
+				      const u8 hs_traffic_secret[SHA256_DIGEST_SIZE])
+{
+	u8 verify_data[SHA256_DIGEST_SIZE] = {0};
+	int ret = 0;
+
+	ret = nxp_write_finished(hdev, hs_traffic_secret, verify_data);
+	if (ret)
+		return ret;
+
+	if (memcmp(verify_data, msg->enc.device_finished.verify_data,
+		      SHA256_DIGEST_SIZE))
+		return -EBADMSG;
+
+	return 0;
+}
+
 static int nxp_process_device_hello(struct hci_dev *hdev, struct nxp_tls_device_hello *msg)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
@@ -2025,9 +2416,51 @@ static int nxp_process_device_hello(struct hci_dev *hdev, struct nxp_tls_device_
 	if (ret)
 		goto fail;
 
-	/* TODO: Verify Signature in Device Hello using ECDSA Public Key
-	 * extracted from the FW metadata.
+	ret = nxp_handshake_decrypt_verify(hdev, &msg->enc, sizeof(msg->enc),
+					   msg->auth_tag, hs_traffic_secret);
+	if (ret)
+		goto fail;
+
+	/*
+	 * Verify ECDSA signature handshake_sig using Device's public key from FW metadata.
+	 *
+	 * This is the key point where Device authentication happens:
+	 * - Host generates a random (HostHello.random)
+	 * - Device signs the entire handshake (incl. Host's random) with its
+	 *   private key (DeviceHello.device_handshake_sig)
+	 * - Host now verifies ECDSA signature generated by device using Device's
+	 *   public key
+	 *
+	 * Only the device that possesses the proper private key could sign the
+	 * Host's random.
+	 * If the device is an impostor and does not pose a valid private key,
+	 * the handshake will fail at this point.
 	 */
+	ret = nxp_get_pub_key(hdev, &msg->enc.device_info, nxpdev->crypto.ecdsa_public);
+	if (ret)
+		goto fail;
+
+	ret = nxp_device_hello_sig_verify(hdev, msg);
+	if (ret)
+		goto fail;
+
+	ret = crypto_shash_update(nxpdev->crypto.tls_handshake_hash_desc,
+				  (u8 *)&msg->enc,
+				  DEVICE_HELLO_FINISHED_ENC_CUTOFF_POS);
+	if (ret)
+		goto fail;
+
+	ret = nxp_verify_device_finished(hdev, msg, hs_traffic_secret);
+	if (ret)
+		goto fail;
+
+	ret = crypto_shash_update(nxpdev->crypto.tls_handshake_hash_desc,
+				  (u8 *)&msg->enc.device_finished,
+				  sizeof(msg->enc.device_finished));
+	if (ret)
+		goto fail;
+
+	memset(hs_traffic_secret, 0, SHA256_DIGEST_SIZE);
 
 fail:
 	memset(shared_secret, 0, 32);
@@ -2035,6 +2468,64 @@ static int nxp_process_device_hello(struct hci_dev *hdev, struct nxp_tls_device_
 	return ret;
 }
 
+static int nxp_host_do_finished(struct hci_dev *hdev)
+{
+	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	union nxp_tls_host_finished_payload finished;
+	struct nxp_tls_host_finished *msg = &finished.host_finished;
+	u8 hs_traffic_secret[SHA256_DIGEST_SIZE];
+	struct sk_buff *skb;
+	u8 *status;
+	int ret = 0;
+
+	memset(msg, 0, sizeof(*msg));
+	nxp_tls_hdr_init(&msg->hdr, sizeof(*msg), NXP_TLS_HOST_FINISHED);
+
+	crypto_shash_update(nxpdev->crypto.tls_handshake_hash_desc,
+			    (u8 *)msg, HOST_FINISHED_CUTOFF_POS);
+
+	ret = nxp_hkdf_derive_secret(nxpdev->crypto.handshake_secret,
+				     NXP_TLS_HOST_HS_TS_LABEL,
+				     nxpdev->crypto.handshake_h2_hash,
+				     hs_traffic_secret);
+	if (ret)
+		return ret;
+
+	ret = nxp_write_finished(hdev, hs_traffic_secret,
+				 msg->enc.host_finished.verify_data);
+	if (ret)
+		return ret;
+
+	crypto_shash_update(nxpdev->crypto.tls_handshake_hash_desc,
+			    (u8 *)&msg->enc.host_finished, sizeof(msg->enc.host_finished));
+
+	nxp_handshake_encrypt(hdev, &msg->enc, sizeof(msg->enc),
+			      msg->auth_tag, hs_traffic_secret);
+
+	finished.msg_type = 0x01;
+
+	skb = __hci_cmd_sync(hdev, HCI_NXP_SHI_ENCRYPT,
+			     sizeof(finished), finished.buf,
+			     HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Host Finished error %ld", PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+	status = skb_pull_data(skb, 1);
+	if (!status) {
+		ret = -EIO;
+		goto fail;
+	}
+	if (*status) {
+		ret = -EIO;
+		bt_dev_err(hdev, "Host Finished status error: %d", *status);
+	}
+
+fail:
+	kfree_skb(skb);
+	return ret;
+}
+
 static int nxp_authenticate_device(struct hci_dev *hdev)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
@@ -2085,10 +2576,13 @@ static int nxp_authenticate_device(struct hci_dev *hdev)
 	if (ret)
 		goto free_skb;
 
+	ret = nxp_host_do_finished(hdev);
+	if (ret)
+		goto free_skb;
+
 	/* TODO: Implement actual TLS handshake protocol
 	 * This will include:
-	 * 1. Send Host Finish TLS message
-	 * 2. Master secret and traffic key derivation
+	 * 1. Master secret and traffic key derivation
 	 */
 
 free_skb:
-- 
2.43.0

