Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010003.outbound.protection.outlook.com [52.101.69.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB8135F8AF;
	Tue, 18 Nov 2025 14:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763475666; cv=fail; b=qmBnmz2ow1R6yCUmn8EqOfrhyAT+/M1s4Ac5OL/E7RvovoV/PB02qnRwLGRkov8tIsUfUfs8rCiZ8oRNGNuhFnTiJwO4E3fXv7iNr0E86gDE8jO58J7Bb6IFSU0sWabQoz88m80Xr1kbToJaH0MzXyxlXaLUiZ6bEesaaIPO77E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763475666; c=relaxed/simple;
	bh=Fwy+UJxJwl+LMgHc9ucr9BPovisTisVTIf8KUEDCmDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jt9EjZg7+ZxP11P8PgU81Ylg83vVJ7svAPvVH8kSycRIQCVJqQVJbWj1Gda9HdZpmKFzol1b7KZ01DMUJPHK9XjasYlPhIEcTZ+YUJp3AL8yEOXrw9jShzrqTHnOVnjgmQDh/4tq1F+W6V5Qi9rqmrPjMtpgFpsui75qMX+2yYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DJGRMKaS; arc=fail smtp.client-ip=52.101.69.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DJGRMKaS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TM1R8qlo06ewk5hbVfBdFR2u0+/qTuW9ygVDeewfrhlu/rGemFYwW5EEpZBP10LUVfKBoMUKgvWfOgvuybx+mAc3ORWFC5ceGTeBAKLNtC/H1mDB+sLadqT2hHh3A1UgvCtGdxLrNUZb0PhlKDHdpgPcbE9s/5WNMpp7dJB1m01RfAmjwL7hfDPp1YkvsPR13HarqxS86OclDIbHGpkGvV8vq+PJJ9Su7BLHKCRlLvbbgx5JpxDBmVspQftV87MUhqUx8GD7BFJ0HjxhbSUspzctGToTNuOyaRq3tnmL5M7vBYxLmE9NY0lx81cctcPocP7RKeMDH/5P1y3a2oXgjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyWmI8e7NmRN9kTK7hN94mbkcDlk8VXZM/fozQouwvQ=;
 b=Lx1e9Eu17VMuMg3tKjWWfKTiqRadx7ftKyxmViMzsHguzHdR2/cL0cdEygF2HBD1N5xybvDrvhX+kIwdytDennLhZvw9t1olS6zwa2p2WB4/KgJ6N4z6RrZsdAfqasgpwvV03Q0FstuEhxPMzIEzTAKCJ6u8vSi/uHXecFmKDA4riYHpfzq5SpPChdWwzF/fOo26c0A1PXBvGeLflq9FbEElR4vG/deNsLEv0qMJ1YDfUWW3VCnV8k6wG9332TqypOVS90f4j+WnjerksezJNkpilheCrBvpvuYvdEh28uA2cRPe5/KCZyN8hnCm9HpUFccIAPx73mrKQxSliAs2jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyWmI8e7NmRN9kTK7hN94mbkcDlk8VXZM/fozQouwvQ=;
 b=DJGRMKaSX4T6WOsC54o8shp+4VUfW0Yx3pfZ/pUp0Ktk+vgeQHV+rcT7YKYctj6khKx+HdDb9lX7safOQvP8J4cNGL0YdqPSh5iaiG2DpyvbR8rti5mA3Pmgaf9JbkkumA01Fu7QF6MJUnATRibsIWvUFu22TUYXftavkwqvxHMKr0BopDqQUv4tyAu9La6I1NfUYxFt8IGG2L21MQRUFQYTXbEjEaD/j71ffHijBIPuOiFxLNMUnupoGjrUXOlxQnrd5wgBeE9ArfBoDxdbJwSfqnOGt5R5WWksUZeM4/hSKf3UbU2x3RerzZ03EH7HXf6mugBFq7GB8vVL0BxtcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by DB9PR04MB9284.eurprd04.prod.outlook.com (2603:10a6:10:36c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 14:20:57 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 14:20:57 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	sherry.sun@nxp.com,
	dmitrii.lebed@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: [PATCH v1 04/11] Bluetooth: btnxpuart: Implement TLS authentication crypto framework
Date: Tue, 18 Nov 2025 19:50:17 +0530
Message-ID: <20251118142025.1982263-5-neeraj.sanjaykale@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 84bd113a-2b9c-48bc-8cdb-08de26adb111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EBB8K2KjIc60F4isBk0t6aqChrjHMezmuoVDHcQyyzNdQ21kP4ToB7OQbjf0?=
 =?us-ascii?Q?4nJVaus0OU2KfmtkGE//7724+KXusZISa6zWZt5vVSyMCteHk5zl9YPd+8DR?=
 =?us-ascii?Q?RGS5ycE9I/Kvww40tKj64ud9Xk/9oAbtnhIjMU9CvgD9+4GhC+gihvb+iFmH?=
 =?us-ascii?Q?lDd2jT/9YGRzRXzy8Yhwhlta0Xnsv9twS7LjD6FgDb9LO1gd070dKE0ikGMi?=
 =?us-ascii?Q?t420CH6cIeHQOcvnG1j+gEFGh9DIWZvKUysxHL3B7KJr1JF+Wa2RbqvRW66S?=
 =?us-ascii?Q?G+QgjHfictXd5T89OMxCLAIAupafjgWuIk20IOWe7ZH7K6/+8Dpd+vahd/n9?=
 =?us-ascii?Q?y0pEsstivUSOCEsHNbvpOzGgOPz7KewqRRln1rBBigIPNccHwzCZV4TBExzP?=
 =?us-ascii?Q?zYmoAftjlgjBiGvn+2FHFXVJolk6LJcim93TVRP6VMqMx7RtaT8Zw8D8zII7?=
 =?us-ascii?Q?lRqACNylh+0evjqQe22fApbGwpCjUsDC6aL/dMdShw5nI8QbtcXRAXfW874P?=
 =?us-ascii?Q?8xBo54JcAe6TdarUlnIfiZVmONifzTEcE1Bp6ux9eNrngMexGCKrFpSSiNYi?=
 =?us-ascii?Q?WMs9TK3ts8d9gGj/pjahmNyVWqKFHbSuKNFy8aCxdOrobf/GOPFAB6cfwb5a?=
 =?us-ascii?Q?pKtSPfZoDZdBdWa7r9kztSAaDLhAKJ1yWOR4Gm0IHMrmHsgvPjcmhPj7D+uz?=
 =?us-ascii?Q?utQkB8LfnU0KMJoJ790voci8Ibsyf5b08T8eg+HlKoq+twgXFXwIjXDqPH2Q?=
 =?us-ascii?Q?TUrNPLUvG42K1JldcalaCQ6xv2m2TuqQciWOk+MDCq2BTSulWRFxibegZZ+l?=
 =?us-ascii?Q?eGZ1oQyn8h9IOfTBWLFZNu9+EFlUsMUFAcL8CWarJ6v+7GKlFPxkiYU10BCp?=
 =?us-ascii?Q?tXQqMAsJjnFa5DdZ+ooKAIVZ+hNL0TblkY0mmxarnxJ23xZ1RE7QxMbfz5hT?=
 =?us-ascii?Q?MGywF4OA66F0leuSBbCZW5iwDeIg52cJgWakY/at9Y7N3I5DLAX+5m/ukbc+?=
 =?us-ascii?Q?sxPFJ98NbRUTNt3j2GqYmNBXObB/aFQbb9tFoemP/DTXjKMVRGfSVg34drOF?=
 =?us-ascii?Q?VocHa6LB4S1H52LH7QAkupMTcxuFpDNhP0lP8BGUK2Y1PcVkiVdg+jh1ZVQW?=
 =?us-ascii?Q?QqUcEXZ4gEnu0EXGbs6M7XfflwyxK0pknVMvrafVtcXFW0/QP5amfmgDLAYX?=
 =?us-ascii?Q?LAIjO2q8QSs6u5A3UBxx2BBCXZXz83LvwknJwKfzUE7iRX64NDG3DaVmD9iI?=
 =?us-ascii?Q?/VC6TmUlZ8NRsFlD0rwkTpDM51W6WKeHS0BLtQ6fpuPtD60mFg3KA2nh3Ba/?=
 =?us-ascii?Q?N3DCPQ0VrhgDNLO10wOgk8hZ7pmyHssr8pV3BtkcSilP8EGBuxKk+DeUfFre?=
 =?us-ascii?Q?wsqEPpZ6ecGp4Lle4CWxSamLUnwbla+jg33meMyfDLOqZG1rIz0y+/Cum2Hx?=
 =?us-ascii?Q?af4D5eQ+AhRwo0CjJRXkXBX6wiqXHsxSueGI6zo0v2IsAxCQyfC8uE6mB11l?=
 =?us-ascii?Q?Sq/iuXPR/zt4nC6SOAGJgqD9bNV/ZhPu3rKs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OFiBQg7BHkAHQKtGdpJUqCGkQUIbay/OwIQsxSQwfbcED3Km/+CjnIhuXG4H?=
 =?us-ascii?Q?aJNviHiVyOP/GEt5RP/po7BIUQYbNC/XMYa0zCMxheEo+C++5KvHVenf0Z0t?=
 =?us-ascii?Q?MiD/pJufHu9kVep2qYAjC4jcXqE/qVzndWfd7c2Rit6XS2BR482pyQ6SS75b?=
 =?us-ascii?Q?670/KSsNFuomA2DcEya+Me55KMT0VADaEFfwA0ye7hIB3x/XsBYeRekRI4rd?=
 =?us-ascii?Q?lCm3MOEoYvihT62kidljqZt5Yc9XOBZvEBHUwh7BwwiDNjNOgYYYMcjdV6Ew?=
 =?us-ascii?Q?o+L9Dbcsd98ofIsNsC1wmzKLqRMJeA5s+UhM0c5nrCi5lVbZ13CNrLezz7Gc?=
 =?us-ascii?Q?2MPkLPHbAunNkUh0i97HFHFtXRzZT3dDUI5csBwy5zKrNaZQJXfnE57WHYzT?=
 =?us-ascii?Q?XFHDYDh/YtRK9MtGQBtA/UDsp9ZLxervUu0oBE7l8n6XH+xBI3HeVV5kVOd9?=
 =?us-ascii?Q?UDjuA/IgUlSM/UjAbZHtEBLAZkaEH4CiIGG+5FSuQaHbv7dfshPAKylzZOQN?=
 =?us-ascii?Q?o4EHYvIV2OMgDfsjpZUrkf8AMMwxETinkUfQcQgn2y5lmZGyyO7+8jAOsW0N?=
 =?us-ascii?Q?QvaNoX+5KGrMm5at8RRlMB/oruNKTsjXb/U5HufUvi9tkj2PBAyUOkBm1rm1?=
 =?us-ascii?Q?7/wzEFX7N1z8h8Q091QmKLEUL17vpatzRgxxht6R6THabJxWN6jULu5OG+ub?=
 =?us-ascii?Q?UaHn+uPbqx9LFaV+dICxhm8LeWjTXxgEazs3kTA67phWggU063SeF5r0UtlV?=
 =?us-ascii?Q?kAjBp98G6C2qMgE/Ehlcjqm0Q5j5bp/Sx4/eSoQg4RqEP7JiN9haN4PM+igh?=
 =?us-ascii?Q?43dLnDhjrNz7CJniGYCj3m84OrpatfrTWZ/bcyzlWzFDEPwDNPImFMVgal4n?=
 =?us-ascii?Q?06iEknSdDwAKsIKboB3kAZYeSqKK+cnE10vOVTRMiN036kl8CFCgAPiTP2WW?=
 =?us-ascii?Q?UBU1Rx5Htzb9S7Wgdcvo89FGfqOM0bWv09i1S0yxtlSLNVYsir3LPU13PXkq?=
 =?us-ascii?Q?h/rAqDG7dF4ngW5NH9eE1qhzbziPHShf3Gn0WgbbkW4oKmaDV9QvhluH7alC?=
 =?us-ascii?Q?Y5i/ZRF3yentrV/AgLBYnISYnxIVRBFxZz3CJSWbgEBx2NDu0IidjWouZpeE?=
 =?us-ascii?Q?adoWop20hdUKi0nQFYiZ7cdfPuok2RG6DmVqzzsORE2SZ7vioRDES2rwGOo9?=
 =?us-ascii?Q?7qR5DHwnMpkenPS6qIX2Ak4QEAeGmcWfp2d9d2n4LhrTp6bQ8IAfeE3p8QkM?=
 =?us-ascii?Q?274odWD+yUYbbFjHIj3gw/EKshqK7spisv8f1pMjprMZE8Td7nOozZuHnhA1?=
 =?us-ascii?Q?a/7c0NyYOo71eP0ZulQsIQLHj4fmssLsgsGTvO14X/XFgX1VDOEpNef3bkIP?=
 =?us-ascii?Q?7BMnUWFYIcfNcHoDrN1wRfJY5nh8J3vVC0DhGAQEBzDiCIOLaf32VnG1DW7x?=
 =?us-ascii?Q?iGU8Y3Jl0hs9Kjnl8d1ruB1GQ470ObGdZ+LxA/3cek83Fxejre9JGP7p9mv8?=
 =?us-ascii?Q?WfBIf0S+OLQKMz2zLBYsfCeyxpj2ltXBLSSU+XAxCgKl9UuBB3pN1dlhhJFw?=
 =?us-ascii?Q?2uPC9kQrwh0qgxR1OO3bC+FDCendOeVOBkcZsyXTU1oeZvG62fWc3waPwHEN?=
 =?us-ascii?Q?Jg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84bd113a-2b9c-48bc-8cdb-08de26adb111
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 14:20:57.7840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7WAft9gX9O1aUGJ2OHmlDqSJ5/7YMgTtkfb7L7cz/p5Q7FWt+OGlf5mfUdm0/y2NT5k1uTuovxWGyoosf6GyFaHaTTDEowTAfpgq7pUB2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9284

This adds nxp_authenticate_device() function that sets up cryptographic
resources for TLS handshake authentication. Allocates SHA256 hash and
ECDH-P256 key exchange with proper cleanup after handshake completion
to maintain only traffic keys.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 48 ++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 084914e72c44..3a8fa5266eca 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -22,6 +22,11 @@
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 
+#include <linux/crypto.h>
+#include <crypto/sha2.h>
+#include <crypto/hash.h>
+#include <crypto/kpp.h>
+
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
@@ -192,6 +197,9 @@ enum bootloader_param_change {
 };
 
 struct btnxpuart_crypto {
+	struct crypto_shash *tls_handshake_hash_tfm;
+	struct shash_desc *tls_handshake_hash_desc;
+	struct crypto_kpp *kpp;
 	u8 ecdsa_public[NXP_FW_ECDSA_PUBKEY_SIZE];	/* ECDSA public key, Authentication*/
 	u8 fw_uuid[NXP_FW_UUID_SIZE];
 };
@@ -1602,16 +1610,48 @@ static void nxp_get_fw_version(struct hci_dev *hdev)
 static int nxp_authenticate_device(struct hci_dev *hdev)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	size_t desc_size = 0;
 	int ret = 0;
 
+	nxpdev->crypto.tls_handshake_hash_tfm = crypto_alloc_shash("sha256", 0, 0);
+	if (IS_ERR(nxpdev->crypto.tls_handshake_hash_tfm))
+		return PTR_ERR(nxpdev->crypto.tls_handshake_hash_tfm);
+
+	desc_size = sizeof(struct shash_desc) +
+		    crypto_shash_descsize(nxpdev->crypto.tls_handshake_hash_tfm);
+	nxpdev->crypto.tls_handshake_hash_desc = kzalloc(desc_size, GFP_KERNEL);
+	if (!nxpdev->crypto.tls_handshake_hash_desc) {
+		ret = -ENOMEM;
+		goto free_tfm;
+	}
+
+	nxpdev->crypto.kpp = crypto_alloc_kpp("ecdh-nist-p256", 0, 0);
+	if (IS_ERR(nxpdev->crypto.kpp)) {
+		ret = PTR_ERR(nxpdev->crypto.kpp);
+		goto free_desc;
+	}
+
+	nxpdev->crypto.tls_handshake_hash_desc->tfm = nxpdev->crypto.tls_handshake_hash_tfm;
+	crypto_shash_init(nxpdev->crypto.tls_handshake_hash_desc);
+
 	/* TODO: Implement actual TLS handshake protocol
 	 * This will include:
-	 * 1. Crypto allocation (SHA256, ECDH-P256)
-	 * 2. Host/Device hello message exchange
-	 * 3. Master secret and traffic key derivation
-	 * 4. Proper error handling and cleanup
+	 * 1. Host/Device hello message exchange
+	 * 2. Master secret and traffic key derivation
 	 */
 
+free_kpp:
+	crypto_free_kpp(nxpdev->crypto.kpp);
+	nxpdev->crypto.kpp = NULL;
+free_desc:
+	kfree(nxpdev->crypto.tls_handshake_hash_desc);
+	nxpdev->crypto.tls_handshake_hash_desc = NULL;
+free_tfm:
+	crypto_free_shash(nxpdev->crypto.tls_handshake_hash_tfm);
+	nxpdev->crypto.tls_handshake_hash_tfm = NULL;
+	if (ret)
+		bt_dev_err(hdev, "Device Authentication failed: %d", ret);
+
 	return ret;
 }
 
-- 
2.43.0

