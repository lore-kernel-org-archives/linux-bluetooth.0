Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011016.outbound.protection.outlook.com [40.107.130.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA43135F8C5;
	Tue, 18 Nov 2025 14:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763475671; cv=fail; b=DbC449+Rba8CC76/88XkMQzmsh87mvPfM/bZLSaQQ4UoYOxbD6tOYxYyc28ttFB+V1mKjkX84ic9WlLOVIi24Ov6iVyxbg5V49oIRRYnucRTPnmlZ7OEFFdzzw/P+77fgsVW6PZA9S01/TB3s+hD0Dd3Vu1Qes+djd8qfz9nLto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763475671; c=relaxed/simple;
	bh=wF8nTOEwMdDerHF7DBOKSoc8NAtwBaVzr12r8XCvG4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jlNWIvauR30drIJnGaT7fz5wOgg4UMpYb6QwkTsbvAn9JugiJSW5m3M1Kvz8fhPDyisY3s47LMXMKaxaj6ey+IADipi5gMWJS2ggjYM+aICY9SHLS6UbZ/qO8nlKbcEKqA99OZkcE5JZ2FD8tb3F/1OSk6GW7vcwURt8GoU62PM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d6EtBHT+; arc=fail smtp.client-ip=40.107.130.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d6EtBHT+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cfh0xmUQZebMPN5r6IEUEBItr5bx1RfU71F6xYzFDWt2dC8TqLRbgwKaP80yf89uCcjys69I0ngAu2eyUCnzK75vlUZw1j6r9ClXPoQLMKC479dxZ2TjS2XziGjbBw/yCYYVphzme2jvjgH1oH+2e6VqW+b1bwOCcmckvhwLChWoLkGraPG86M4w/CSIK4QEWzvRIgMB9Fla2gIUN5Y+NAJBxWw3DqmZB7VlObLjaL3Vf6qDlB9JJ/pmu/Sz0C3zajw3G6YPpWwYKXqNKxi6HrdYVUQ4hpo2gfIXPDcGN+c3Vtt/dJPlIH3WQe7C+hkAwMV1jmEX4Sxm2NMLtobhiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mtj6UoX9RjA3Sqcsa1eN5LiBSiFLLzT8NXmoyx53eXs=;
 b=ALSiqC74HrQObmJeLSlGoOzwj8CPTfOSNW9Ujodd46oLdItDR+LXrmtTKBdLyBlAGhCjUxFupQqteNGUXlz2RXbAPvoJ/hdFmVMne+E+Y9qdDP/D25S/VftgNbF4dyniHigMd+Noz9f14GXKfO7CzeOfylLUv+uL5pS74VAiX0jfCZHXj3q82iLa7ru18RFRWf0Z+Iv0HD/089+JjHgLr+iZu+74hhhe453K5cU8KhciAZesjSvY8rdmt8AR7gOl1//0q+8tHa2P32qIcqJlz0FY8H3buvDSQrA3Iuf+pNjLJMq2wNs1Nuj/ZXVMWC26tvltVFTiMLN+SEgiefeakg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mtj6UoX9RjA3Sqcsa1eN5LiBSiFLLzT8NXmoyx53eXs=;
 b=d6EtBHT+iiTvwTy0qKVpjpe1Aw/fSNtd0kw0hu0C5eI2b/kcWj/dpglTABWkKMRc5OOIUyAMQApAvuXPJcDXFVzugNyw4yVD3/36jMhpwgADChAeIO4/dQ1HnFhUPypaniFNwuYHhmCQB81lwGaBMoOnyI6r1ep/Sv2woTdHmLtbK/Ph63grr8XzeirlICHPuq5cjhfjeRKx3IuMMl4d5U//waEOZYiUCAUItZbooOCvMfWe8KZ+QvRwWW7birTK5KoUrYftdafHlp44Hd1u9hVqCwp2qqh2p8dlPu9ebyX2AiLJte679ghUO2MdwkOD39o75fzvBEW/8LN21gfr9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PA1PR04MB10179.eurprd04.prod.outlook.com (2603:10a6:102:460::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 14:21:04 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 14:21:04 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	sherry.sun@nxp.com,
	dmitrii.lebed@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: [PATCH v1 07/11] Bluetooth: btnxpuart: Add device authentication
Date: Tue, 18 Nov 2025 19:50:20 +0530
Message-ID: <20251118142025.1982263-8-neeraj.sanjaykale@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6003767b-f931-42a3-5451-08de26adb4b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zNVDvVnn/Cy83w60eUJdWnCWmwr/NElckJpzSWbfRfOQv+XE4Jsaohvd/P+C?=
 =?us-ascii?Q?a9xxcthhpb667VZhxzH3+fiztAF1f5b0A0H36JS422qE/oinxgfSbSrAm6jd?=
 =?us-ascii?Q?9GpPs/aoufPbyHmXIjvYxOLqcJynST8Qx7a1VasfbvhDqHfzdrFp8lW0750/?=
 =?us-ascii?Q?QGHZJ8DaZNmeAAAM5d8q21BoeFwUUc3F36p1zsgUN9LA9gMtTj0MtcWE8o4p?=
 =?us-ascii?Q?g57dpPoO9kBA94st/TjfpDLbeoEc2WL1AKtliG6thMluw1I2d/bZNUzpTcNo?=
 =?us-ascii?Q?XcvSgK+A0BeJWvpil1V8fklv0yqCRRMV388vMBD8+R+vZYJPmwuZ6GesNDHq?=
 =?us-ascii?Q?7RjJLjaT3CZU2WNmoyjf41PBMiQd08u4qPbQLsWWLyLgVmYZxDVMWhWh/+XZ?=
 =?us-ascii?Q?Ep1FckEDtJNgzetW85hbncSb0m532ZRRk1pcBvYSXVP8LhYCYTWEPOxKOg0a?=
 =?us-ascii?Q?l4L/LDX/VPUguHmXwctw3p2+4lt1SKySZ74JWU1sQdNZn1tnmiV/9ezmVRVl?=
 =?us-ascii?Q?URHQvi58rN432XRXJ6ZWn24WjjKF/id638UGE9a7rMqlp2mD/R1oqx8sTIT7?=
 =?us-ascii?Q?CRAALQ3nr5xXwhPRk2PIpeUznOiYT6Q6huugni/nYZNf5bSEppVLIQLEz5BJ?=
 =?us-ascii?Q?hUI3nU7QNLEyPUjf3j3VHnQQFKwr6z7oT1Zl5vvpYooqoGAoEM6w5CkT6RxR?=
 =?us-ascii?Q?nO6vYQvzyIb8c4Aax320k/nsg+HEbHB0o3p669s/kKx6nIEfryZ8SMOvqoYe?=
 =?us-ascii?Q?ULjIeYs/fGkb2oC3ktxk/QICTuVMwrr7LFUeyN1g8sf7TXZKxeRbcyqnjhPP?=
 =?us-ascii?Q?qb6UFaG9LTGHv6ylD+rbLaN5LkqQfJ2cZ75J4mCRxBILRYLOanFFs35RFctz?=
 =?us-ascii?Q?CFYg9HULC6s5s7fU2HIG9+x+qCfCHgv8qj6RkdTBgZzGYuzVHmRwCyB93sX0?=
 =?us-ascii?Q?BCmx40WfBflE5+/cJxld4wuEgALkIdziRlSDWvd/fxXbMLLYn7ParlTV3CCQ?=
 =?us-ascii?Q?M5xxF0O3Hu49BZxFRov31Er2R60IvliqZcf+Y7a1wC+LdzYwl/Ww50f8k05x?=
 =?us-ascii?Q?TePg/iVn8le1BgcYK+KNU4Ololn8yPiynB4dTWo3Q4Hrn9qjfSSzlbdgE5M4?=
 =?us-ascii?Q?SCjL17wXZhDYmOM7tyCdw7Yv2s5k3JUefNfYWcc4cZqHpIvhPK6ay5O6vXv2?=
 =?us-ascii?Q?MQ1ABLCgSiocdIkqOQhzfxViMbZAqR7dwXsCEhoenq9ZhqvClE70X9iVmXjd?=
 =?us-ascii?Q?B9P1cuFZFAjVRdjI4D52RlNZmfOpylSlU1eAa1VPXbNMhGZ4/1hr40kXjDVd?=
 =?us-ascii?Q?ADQUw7R9700sjcMOAtNKn2mdR9QLSL4ArCuI9SnIi2oqluepfaucMNm72gHk?=
 =?us-ascii?Q?up3Rf7UWl4/hRzCRjvYYLEX4moR8/kUOKz+G7K6BIy3risWNmtnLuyjL0dR1?=
 =?us-ascii?Q?Po585ttmg/0HvQC4TD4+Q7hBRHseTQbfuTNnK155TtSlnMeq2k47UR/2EYko?=
 =?us-ascii?Q?ncPfpGK1VrrMmIIFD3ieXe2M8ho2XfFn8eaa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XcvPkd8SfztloCjFm527jV22VsHoqqZjfznWxPIfWpQalcSnseK1VsibhJ/t?=
 =?us-ascii?Q?WJIdvhFDFUSmCvjtvrwFOoP54nmdr3Cmy821qucIdE1nced835P2oubWwHNt?=
 =?us-ascii?Q?szRBENwkWg2WOQeRx7dQ8KDc4xXLJdAXT82y0qwfGkH84gly5DEj5IOE6INZ?=
 =?us-ascii?Q?LgpFeL1GKdAW9gGYF+xrPZ9YgibEtZCmjlEkv95kQ/FYyo+FFovvXzWV2+/z?=
 =?us-ascii?Q?THxPrVXxCtAIQVV7Xf6CWP7rcgtWcOsFwP/Zv6ZL+2f6/CbX18nDbgw1ETep?=
 =?us-ascii?Q?2VwNoUd5i018n+fhSglvzsf4S+2QFYva/aL8OKDlXRDNllgS8RoTMRiO44Ve?=
 =?us-ascii?Q?tlEyUOuK6r8MmC0fKjD+2Os/ywJu8rJMdsX03OJCYObIzsiuoqy3VwggHUaB?=
 =?us-ascii?Q?4LJ2+N5/Af4+FTUK+7zbNkDbA9XRpi6xgl0fIK6BjCYA/OJa6tx0+k2j9Imh?=
 =?us-ascii?Q?34YpT7RCw2ne18Unq5Kq34ephR0rhQSPTEw+w00sgfaaj9qbwLVZcSQhxEJl?=
 =?us-ascii?Q?X/f/NiX+p4SJTO1RAHzNrkrpXEvnlfJZ38IzeccWY6gQjS4SZ04KUh0di/qG?=
 =?us-ascii?Q?KFWH3Sn9YaEApNy4IyNTw7BFfwZwCs5X/5GE/HfmWSYyKGeGc3Y7DAFaiYJN?=
 =?us-ascii?Q?ful60m/pWrvD1hh8J8HHP9C2JqjCrQUa43p1K93cBOXIkt4BGAIXU8NXP7B8?=
 =?us-ascii?Q?wsO24qqjPgoLNl0U0ibomsRIY61GijFt7ZXA0C8WZ/sKAW/dMhfW/HEspV1E?=
 =?us-ascii?Q?n4N2zCwd+FbbE5YTsaupvLDq3R/vWFsC690NhII+Pu3ifodZR8dmBrdqzoK5?=
 =?us-ascii?Q?PQJcxFNi1ewWIsTgnr+2CZ/4Fmi5m67NDXxO+zPzxCKdg2QqHobcRmgs+oPm?=
 =?us-ascii?Q?7tQHvF/fbxHs7QnZ6UDifCbj2R3YDAdFGsFAqxUoGHOgL9mXP+X/wAeMzN+X?=
 =?us-ascii?Q?bMd+u0dSPFoZbNJ8zjqQa9owiwBgSllvM4O3F0Da45JIqsIjdYLWm/nbG4a2?=
 =?us-ascii?Q?2w5+FMYF671etj2FVakJlBtZfG94fuWW2c9rwcauRrMaa28AbDDO/dRDBs5P?=
 =?us-ascii?Q?oGQ7CCbMGM8IdW4OH90SUYuWiyABXGk5ygqw8a2MAIkrRcP6Q3xH+DsEd0Kc?=
 =?us-ascii?Q?nLSIIClFDIPMBfsnEIvmv+NVjgAIDyhTHsQ74aaC6su4CLZ+a/KWa/N/9tOc?=
 =?us-ascii?Q?RH4kA2Lm0wATPZlJ9NjOvWnQ40fQQzT+MIOblPdXwXQh+3o55QA4LLcWc4ES?=
 =?us-ascii?Q?49KEiqVlhW2xqHTz9xqRL4E0kIdWq3+DS2xJhtqrpMswL+QlJT61pW/r/CPP?=
 =?us-ascii?Q?cPLIavmR50mj0yVj4SrUAptIxVQJqy8PRdKOk9XedyrZ19y8wMjJQk+S6Pzu?=
 =?us-ascii?Q?MQYJXbu5ERZHhsyeDZk+9e6u1I8eSATqVJXo39Zmr9/77tbUIHzS2/TF+I4B?=
 =?us-ascii?Q?8B8nxbxqZ1rUDmfAWTtw2cB+x7FGbZRghbsaQls3s4sxpPV6EoA6aPWWabsU?=
 =?us-ascii?Q?AWD2dUy7AVDIyUlvN2wJpycgJTEzfpjgCZn0jUaq9G1E1az2JzVfuIWjXRol?=
 =?us-ascii?Q?XNKtfoBfAaVQMMKqdJe3RGPqTaBovACI5O07pDIun+/CMmBLp9AQ3exDhxtD?=
 =?us-ascii?Q?iQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6003767b-f931-42a3-5451-08de26adb4b3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 14:21:04.0725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/n+zcesW1lt8zFE80C+AIf3/H1bEJmFUP84hwRHXxtIWnwANq01MPQOMg4x7eOecLWNHrNyxQEsp3bcUNS1jLYn73n6u0lqSIlhj6mvedo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10179

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
 drivers/bluetooth/btnxpuart.c | 503 +++++++++++++++++++++++++++++++++-
 1 file changed, 498 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 3bff7758fa5e..bfe6a138d78d 100644
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
@@ -1700,6 +1745,37 @@ static void nxp_get_fw_version(struct hci_dev *hdev)
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
+	fw_name = nxp_get_fw_name_from_chipid(hdev, device_info->chip_id,
+					      device_info->device_flags);
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
@@ -1971,6 +2047,320 @@ static int nxp_hkdf_derive_secret(u8 secret[32], const char *label, size_t label
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
+		.len = (u16)size
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
+		.len = (u16)size
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
@@ -2025,9 +2415,51 @@ static int nxp_process_device_hello(struct hci_dev *hdev, struct nxp_tls_device_
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
@@ -2035,6 +2467,64 @@ static int nxp_process_device_hello(struct hci_dev *hdev, struct nxp_tls_device_
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
@@ -2085,10 +2575,13 @@ static int nxp_authenticate_device(struct hci_dev *hdev)
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

