Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011070.outbound.protection.outlook.com [52.101.65.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAB730275E;
	Fri, 28 Nov 2025 09:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764321354; cv=fail; b=QJSnrq/Jv/oVERP1n5s6pF9FiDwNEyzBp8iy4oj4liVQ3JFuEBeUNP3NL6v+jub7WQhEwJzgo3gjfqhXF0aEUes8B1pvvFB/XA+6VgAUPhVr41LiToIccipGhpQH13S9cicrlFwJKAEbSvNAVlkE0Frwdxdw6xyUB/6yYhG/Fog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764321354; c=relaxed/simple;
	bh=IGWO6NoGxkaNaAj3nk9Pwgo/oxIJu7cVi4x3Q1GMOSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ju7+6C0lga0N+taAkjlq95G88XiWqetplKYvi2o6f0FJqLshEebAQG9kPtmwDYoHzrQFGQNiFSuJIvpmvcx8qwqBWsCN/QJ6QzWwlqXQvyqJexyK0cHqt7NiJLgxMATaa27ZvMl73CZ14+Tfx2WSPtME1F0w3lBeyLGjBdeVuOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HmyFVd8r; arc=fail smtp.client-ip=52.101.65.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HmyFVd8r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tUtuZxJx7LFXI+onAGlabDU00fHbxuJPT9yhe66CuZG1UDRJDmDBZCRL84LhAqhTDOdL6rLKAQBucTAniuG9IdDWYNKW5+hU5WEmALr12WzWeWdF7+F3he+wgAB71ZpDNycyod/k347bkUrvb6vEvOshSBZURPb+8/FLC76adnGdDFliW06p0pS0+PIiqGWtPNMMGoU0F2wx2oAjuSzIX7eDJrmQV0O8oK3cEu+/b9Jn72TB0dmbZ2ZqUBRqXgTlQyxudGA9RzgYU6QFud3kkBZexP3DzVtPOuMgSIEKS6xWizDgBnpAbrrt1mULuMIHQyWPsjzVqYfwZgGljJ72Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtJI53yQlAlHMiWfYSdkyUiGhEbLBlPp91w/jJcr92c=;
 b=witwkKcuDYnpwH+TBc7trJ5AUZYbbacloaPZHsctOgJiXmSuIAmrKcpyFfAz+x3hdt7tcJMslBLEIPUjzC/473rT5kzukg7Y1Ji/mv1aLSsUQN5YMc3HkyJ8qqDpTt0HYSXNqWqhyP61Nh74XppjCcedVxSFPz1nfgvrI3UalLqTNU/ocKso1Z4i7GHbQibz7aOLn1w0Pcke62+Kt2eQ5Ojw4SPV5ZPo91pcjElx83/EgkZUm0o38KaDHYzisR37F0DmAKftt3KrywfKdnzbXNEQf87SDKngppB+jKtUPi1JNWS0yAxLmPOrmg3BzJ/Dl6mTW5n3ljpxZUDuCZYy5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtJI53yQlAlHMiWfYSdkyUiGhEbLBlPp91w/jJcr92c=;
 b=HmyFVd8rATY11ZgJBSsKY+LGgBH7Ey0gy+7CDt0GLYqszPNqAsyeBjXNTyL43rSHRFeNUSOMBBTvPh7TnYVMeIGtGxYFfpw52eR47dERkRavhwaHoD4oSrJSifz9tOGd2BKUX5mWbt/TbXOteY8VtN+I5E0hb/Bxavn9c6KvkcNnGjLAeC3Nd0Tyrf3TPeCJfYRoQdQMcrk8x2nyQj4SpwaVJl6gCoF4r5KzF0ZfQZMmwWBI3gSeZhyGGYSib7mEx3uYSbA2Tl9a2dpPfDOLnI8l8lqaubrZf57RuScLcS9KwFRFo12hR4VzqLjdsZQDrZ3Q6tRxyux5gO1P5TR68g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9676.eurprd04.prod.outlook.com (2603:10a6:10:308::13)
 by AS5PR04MB9998.eurprd04.prod.outlook.com (2603:10a6:20b:67e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.16; Fri, 28 Nov
 2025 09:15:49 +0000
Received: from DB9PR04MB9676.eurprd04.prod.outlook.com
 ([fe80::97c:438a:2968:465d]) by DB9PR04MB9676.eurprd04.prod.outlook.com
 ([fe80::97c:438a:2968:465d%4]) with mapi id 15.20.9366.009; Fri, 28 Nov 2025
 09:15:48 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	sherry.sun@nxp.com,
	dmitrii.lebed@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: [PATCH v2 07/11] Bluetooth: btnxpuart: Add device authentication
Date: Fri, 28 Nov 2025 14:44:39 +0530
Message-ID: <20251128091443.2797316-8-neeraj.sanjaykale@nxp.com>
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
X-MS-TrafficTypeDiagnostic: DB9PR04MB9676:EE_|AS5PR04MB9998:EE_
X-MS-Office365-Filtering-Correlation-Id: 326ec4ce-311f-4166-29eb-08de2e5eb7c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dtyocH1fzLpp3Kyv1APSy6RnmEWKXlxdd4Mi4/91PR2g0L7bDyOSKIsRzZuk?=
 =?us-ascii?Q?NNEjONfDG67z2ro8UzVO1ewDDzleA8jeQGSK18MVpWJxVDj2Z132HRUSpLFy?=
 =?us-ascii?Q?shooy4/phfvP2oeQHaaVOnfgItvbv3AdlKhUMCOJ7XkBe9UoUuor39QTlDnq?=
 =?us-ascii?Q?B0zVKSGWb0edJSlXj9ZejsXP90rbQfHzgiwWX5s+WrAVh+9oOaZjWxlWi5IA?=
 =?us-ascii?Q?g1v1HIxNtEtpS/fNRY40MThpe6a3ZzhvmrbKOzjRZ9zw2uvzFVCMK9aXoJKN?=
 =?us-ascii?Q?YNrSPknt6quWavP5UosvNC8PEjfuvWe+V1AhHerOgw0cey6ajZEyW5AQuDIl?=
 =?us-ascii?Q?X4bVi+UM55bgB/So0LO6qFNo/uQ4BF0B7ergGAzqyICccEBGJK0do0wic1eQ?=
 =?us-ascii?Q?ODwyBuvm7RTMen3+QOJl5VscQ1snParzge/XDX1OmphFD9yFY4DaSmAP0CZ5?=
 =?us-ascii?Q?M3FTGwsZk+MqSBp/U3+Nl1nmLYu2fqlTwZnp4tDevfYb62hIbhiDNk/3ol05?=
 =?us-ascii?Q?jqwEueUDI9tdrZ9AGvvxTnn7vY00GJz6od1xPw4KTu3IaCrR/gxsjXmG8uOz?=
 =?us-ascii?Q?gUpUcYdOdzTrXJKzhZo6xCElMJNec9ZTdpcP3uI5Gh9mxPd9Dbi+cUPr/F4W?=
 =?us-ascii?Q?EHYBhoXjS5RhPV/drvWR4pFecypy8Y8smeSGeX0ijyDmznI3xqXYK4h3diu7?=
 =?us-ascii?Q?tcBB12fIQa+eZ58XSaq0JIKvcmwgm1ZmEK7iiDl1A1RGGepnrSZQct4qZpjL?=
 =?us-ascii?Q?3J41l9NTP1kRW5pg5wdlXIWtNfW3h6TkvHYXU80La2iFrS0RlXFMq1p7Wi31?=
 =?us-ascii?Q?Uxd/137fSsqSer+R8ijVspTGTAGUL78RmEK5BvwU9l9K1qycaMzbubpDEMsL?=
 =?us-ascii?Q?kZoR1v1mcrCR5nKcM+MNFQt1kylzEBmGt7V0BdvQUkDvvc3FxswNhR3z4Ehz?=
 =?us-ascii?Q?lzRmIRg4tMJawF82e1fc7zZIXpqD7D0HVsKooLOkzLRpaMb/5ab/2nxCHtGw?=
 =?us-ascii?Q?Zjcw1vbHt904hIVuw/Ib6G8VA36ABZAsY5yVcD8NdbjPvQpEwAamrv8gm0+E?=
 =?us-ascii?Q?/zCJNTIzDaO1flBTYBbnPCsrOTulw4T7aP30/A4DtVfpSLHNWzYMfbLWRCCR?=
 =?us-ascii?Q?r6Lc7Jw350A5eO/uRDya9x6xCyhm/JV+rlfNWg9wOeMtFwZ4sRa3yu6crijL?=
 =?us-ascii?Q?2bUJzPnDyG0cvQs3vXk0AfttqYP9xnOloEqDFJM6O3EH0fSugljIlztJgun3?=
 =?us-ascii?Q?PW8vbiCs0jDQ++9zywKA5IgVI6QMqLYSOwJXsl1CZfwxOAd0wkvH7RZaaTGD?=
 =?us-ascii?Q?kCFhoAd6C8xVPlCBXW1NsZ52U8uM0PemN2ZQ78ptNM3chobNYiR+dwRWWuQl?=
 =?us-ascii?Q?sNqcA6T4peYtotKzOKpRklaKN8Zth5gPwaX7UsQL7vpGmpwoLxfD+qVcE4wy?=
 =?us-ascii?Q?iXzINupjGfEPByrS/Qg2gsi/NqWg5ypDAZJ4W5UvULX2ADdZbNpIU03RKqiB?=
 =?us-ascii?Q?bcNn56Cjs9oyMwQGdxNU1J+uR58lrbT4sI0p?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AvNWjzSxG9zLmG0hXT7LtcC7qiN606IApwH2qJ4/8Qrvsp+8nvIZDfReZRV0?=
 =?us-ascii?Q?2qEdgzvj9RewESXQXxTi3VTfbkjuxhxI6+PNXcK6xQITZwehmDFT/fZA1J1Z?=
 =?us-ascii?Q?yQPz/ZwppmZbc5aOVwScWSSJ3bNO9YZn7odm2jBq7Yw9WqjdOMQcCHQwLdWp?=
 =?us-ascii?Q?kSV9JuYjG6up5PFvJfju/BlvJos2Yrmt0czq1xWxRaUHMmlUzieZDhrJPe3A?=
 =?us-ascii?Q?qjCdi3zicYcxh19KXzPUK3jhMh9FTkatVkY8LiUlBr9PLvji07jImKWsrEc+?=
 =?us-ascii?Q?TDS+R9foFyx2T4lHFX0KXGtwy1NExUpurAnUWGr068k2GYBAGQYZPtK78eH6?=
 =?us-ascii?Q?u+Z8I/kRLla+WNUYKWRUYK4NXAHy+GW+VDuMQe8b9BgFEfPjA28vHK46SoVc?=
 =?us-ascii?Q?zILHbLMNp3j0+dV90lVGn3OCSZorJjModna996cEYt8JWsYQmfcd7xKJpQap?=
 =?us-ascii?Q?Xi7H0Q1REObw+2/I6TX4dixZHN8u2trEa3fp977zPBxmp2cetpcEwvhXvmrv?=
 =?us-ascii?Q?AenL1od/xP1BaWhYN817fiHP93DuRixr2CJ+5kkZtxyitUOb2ZqMkiheGNhm?=
 =?us-ascii?Q?fvhJlSaahGwPNog8Qe1DeckpL/+sO7PYJ36d/dkrpleOdHyL4gwt6yGNQM4y?=
 =?us-ascii?Q?Sq3YR9NaMjthwxRDFyZ/MVnteMX7PxsTQHFx6WveTCJgJEH/xrDSqeFReX1p?=
 =?us-ascii?Q?qy4TmA1TnelkKXjpxKaJeoLXsWS8XqFa1/Mri0nrcInA0lfrqE/DYQvtCXKD?=
 =?us-ascii?Q?YL8YLSn1lYpqRVeb+SNTNCovZ4r3Uq1q+D+UfRIiNROf2arI2yw4htJ8LShH?=
 =?us-ascii?Q?iQAxev/qKGX6c3qgXX5mil8qpWBZDk88Wkq7A8+HIdCcnQfQA8yWts3gjAlm?=
 =?us-ascii?Q?LR48qUgT+zcTsBtRvRZTCJlKFPy24fdlCQxDu+uWiPa3etkSDDOochVUSrRi?=
 =?us-ascii?Q?PhVUU1fgiesqz944hzHqiWHKqE/tNMhu9hKlF36dqhMOIA5z9yP8qRKds/JK?=
 =?us-ascii?Q?zCsWWfeKHTS5wU9NEWaRSZ9cRE1gSs7t1LaZMq0vD4E6jnt9uoTQq/g6ljRH?=
 =?us-ascii?Q?JRNQQeUgduBQSLTKWjjmnU8lXjcireCMbJ2iHxC56DrRa+0i5FBEdhr61jwM?=
 =?us-ascii?Q?leHPdvxAuzXghGbVnNXMdj528eKptehHo8xeVS1BvU1NUPNr92OupNF4KzL1?=
 =?us-ascii?Q?8L/+nW3UxCZmbs2TyVa3sZ880lugmBRxf++UYgqMhwZsqGQ7NUWgKYKRsgi1?=
 =?us-ascii?Q?GL3XkreBMlPPHftxbtBSEhvB46M9KbGXWt01F67ECFnTih+ALugsch7gQglk?=
 =?us-ascii?Q?TwDEXE5v42Idt8pDWHzssKQ20wxA3ErBk3sPtHn62Xq4ifLm1VZnHLOuGI41?=
 =?us-ascii?Q?ucM6Q3+Vvtu86sfKZZzGDxcKO850LcZ2gOQzjClzvgBDuU9slxvQDeAFWElv?=
 =?us-ascii?Q?0n8WaDrmszOu79OMscl6cA7OJIi9AgQ1PjemnGio1vNaiyO5mLOAvRYcAMA2?=
 =?us-ascii?Q?FGIVN+dEeE5plUNFK+BWwI8uhB3hYX4BSnFQ7McwdJAGCcoxI5138iq14XvB?=
 =?us-ascii?Q?9EWKJ5hu3Vo+jffk0HRuHWQacngBUDqWBH3dNNHDubhfnMS54NSMiYDSGUnU?=
 =?us-ascii?Q?KQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 326ec4ce-311f-4166-29eb-08de2e5eb7c9
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 09:15:48.2338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MK2bdEsnieZSIbztOGJNMNssvEx5eSr91eJxr7viy1ccMHnkb1YZM/f15BnjwVlTBBJgi4EEi6Q0dehEiTxA3IQFDcsRtXfxI16MOWL2bYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9998

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

