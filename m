Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012070.outbound.protection.outlook.com [52.101.71.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313802F1FE3
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 17:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255800; cv=fail; b=lKYSt1JHq7AoG2FTvcYo+l2t62465mA5wBB26NdpvSQ48T9Yhjy67A6TVyP91YKAdjIcd0E6M7WgoZwO72atDNTonaRGOT6GRQX6c4ypoGn7jvgW11Yfnpr1Ba2ApPb9A4L7LQ9GfYmxPYYa6yV/06fONv1iTmH8RgHTzCjTwIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255800; c=relaxed/simple;
	bh=CpwOpRWYbquJfB2mkUb40TluyWXqh4EKOUtQaaDrlis=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PwYBGDMiaWMWMhSbiAqylYvvN1Q1Te1rMlCTtJ+e/GEh+wOvP3YmMic71HkPVM7ZiuEypaqmKb/UH3dTpJtgs5PLKYG+ek2WEvSh/dBPADNbCn9bgG7cf95MovWIoS98fFOEk1PX+9AugXeW/z6T1e39bI5Hu61Ads5S3gFvu44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=KdfDiKG6; arc=fail smtp.client-ip=52.101.71.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="KdfDiKG6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N6Hn5iXECdW3sxDQAzTm7173GsUS6HeEGfUCYNb7rMdYrFctePz6+NvwvkkY27xZWN7StUA0AvWNkIaWHW7PlzuWSQpRk0AOGxUEp+WEFc3/RucZ38Y5CDk8fSnNtikX7x9TYbmYx72hgQz6k2XxbQE3UfUjykCEmPi+MsQNORfLWm8CqBnkPH1O+syyBBRV9Lw4DlvS0co4GlNSa5DUUoOQIS7DWIGAZTD0oL3aEdqW8wcqanYMFDHOUl4k92KDraHA7lmCW1VJYBWZCL/+rIx30iSzQn7FbZM4U+l1b5FvgJrCgZR8TVa4F6igKWPMlERTCpFfiXU7OiPMnKCUgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=At3WuUvoFvroJdEoDMcrAzIegijMD8HBSChR5WHgIbg=;
 b=bH+Si9BkEWmrqxGZxmQxZAw7wkHBNbDORzPf4PDolgOog+kUM2QInerBEsEP8WdnmjuZW0L/EtSZWUPCMnHSMxSB9sznFKlp1zpk/bcDy0ELtZnFSz3MFxC8RWB0ROoysF9nWKfzRYiOwv6Ayw/va7fK6naM9zZWzxPeC+mNy4peNHt4PCyR1NM8XKOd21e/v1S90f66Xj4kHUftq2VY0cSGqc8fYTY0lL3Lm0IIjFynvbnHZuPrhjnvambPDfv2eqECuQAOxOx1+z2jcaqXOeHPIbOIk41uYxKnq9O9lEr+TykbLOlXTtLTSbGIZNvnS+VD0PdHGTvoyEPFMbaBpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=At3WuUvoFvroJdEoDMcrAzIegijMD8HBSChR5WHgIbg=;
 b=KdfDiKG69IgMfpC1l7pjicWkilJlyHgBfL4u/c+JliLlIOBwK3tHw1jn01sc2rerQSeg8tzXCN/q7gXjKalRB2qU505Nh/pMuFpjoKKYrQZjAU3Acl8e04dIdiDp7IB3qtEFaHzKkdb5l64jqd+jOGWtfxnkQaK0FwPV8xmGd2M=
Received: from DB8PR06CA0018.eurprd06.prod.outlook.com (2603:10a6:10:100::31)
 by DB4PR03MB9387.eurprd03.prod.outlook.com (2603:10a6:10:3f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Fri, 11 Jul
 2025 17:43:13 +0000
Received: from DB1PEPF000509EE.eurprd03.prod.outlook.com
 (2603:10a6:10:100:cafe::6d) by DB8PR06CA0018.outlook.office365.com
 (2603:10a6:10:100::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Fri,
 11 Jul 2025 17:43:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF000509EE.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 17:43:11 +0000
Received: from N9W6SW14.arri.de (192.168.54.13) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Fri, 11 Jul
 2025 19:43:11 +0200
From: Christian Eggers <ceggers@arri.de>
To: Brian Gix <brian.gix@gmail.com>, Inga Stotland <inga.stotland@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 7/9] mesh: crypto: mesh_crypto_aes_ccm_encrypt(): remove unused parameter
Date: Fri, 11 Jul 2025 19:39:23 +0200
Message-ID: <20250711173958.25689-8-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711173958.25689-1-ceggers@arri.de>
References: <20250711173958.25689-1-ceggers@arri.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EE:EE_|DB4PR03MB9387:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b831053-88df-432d-4e05-08ddc0a26806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9y/5AQ0yxMAx6F8+NiMl9IMXMvg3HHk2Fg2ilhHFwnX8wB+i1+mNOTOnZKg7?=
 =?us-ascii?Q?sFninzXjX8Pfi4ELlJqoSi4eAxSHVMttMec+b23HoPS/w2yXiTB90LrbryB9?=
 =?us-ascii?Q?xOdbzr8x4y1c0rvHCqmihQDCB+sxtS90Gy93F00rP9mHb/AsoqQAf4k8BJvr?=
 =?us-ascii?Q?tg8dKoAjL9kK9IOdqhqz4FFHkPWn0+kLeBi1Dd2H3UgI5RM8I3/gLP2W37lF?=
 =?us-ascii?Q?ZseBhGCBgBgJ+cpM1p8pOum3eadqETIzzrC91jl8gCnaHwsda5MfDXUeiVR5?=
 =?us-ascii?Q?Z/dWHL+xk0DDDQ2i+QYqAInsF8uVJig2aIbVjybmyhp5UFFmOiivJtjK4/pw?=
 =?us-ascii?Q?zcQOUAzeA7GuIRC/b5FLyG2wpdRGBHWKzw49dXfydRasS4RFXxNJHdtI28FO?=
 =?us-ascii?Q?1sq9ZqFrpjfsruhZD+2iq2jqKnOu2VzigKwr/64Wbk00YFahuURQGtf3ituF?=
 =?us-ascii?Q?rxe0zL7g5VPE8ItLqTBw24k24AKIoKIUweCKO4i0xwP2lZl9zlQB2wVSFpzX?=
 =?us-ascii?Q?Cvuya+w8BpPna9rpXDcJEfRYyhoakuzM73O9Yqa6cBqS7N6L8havMmVHYJa6?=
 =?us-ascii?Q?LpuBSj3S8BPb5IQ2R1l99KYdBtkCMcaO7mv5M3WBK89xWPNai919GSNpZmDI?=
 =?us-ascii?Q?YrlmA5qDOTdbEFypXQKOXgUaZJa3hSaDG9kuJE6cxSh5AsEqBfmEflzRj/9H?=
 =?us-ascii?Q?BsKZZbvMGfwCV1eckzwjEbbtWOw8EyyBzXx4Q3YWUkevrFWm5Rrij0xCe/oT?=
 =?us-ascii?Q?upo0QlwpDirdo5oYnMkTQLz0AYiG0706+iSHZEzr/yU85rUwjzG/66WAT6YL?=
 =?us-ascii?Q?xmRc1bPX48P+DF1DwpwLnikbMIlls7CMNzA4fAYeqE8SuGhXpjgWbbFtQASP?=
 =?us-ascii?Q?ZUYT9ygiP7Zi37pduR3KC6EwjxUqi0sYGTh2kHYRFZC9aCiwHfPCCxYE+7s6?=
 =?us-ascii?Q?6AVknknZznIl4HTjRRiJ+/oT2Y8XLuE9IR3BlpNwRfdJCbi0zS7TelVsknSQ?=
 =?us-ascii?Q?tt40w/KKoFneQbND8mJ2lU2gQgZqjbDTTzR2w1b6rQECY09DsnZq5g0KzVY+?=
 =?us-ascii?Q?3gYrfukU6B3NbGXV81Ax/tsYpD5UcN2cd+Z9/XF0WS1b/gyYXmiXTsPIlWh2?=
 =?us-ascii?Q?oD0P3ItSuMIaoINMfjNPKoMqK1fBJ0erlfKkcTj4oeLJ/6EgX+LL3iw338F5?=
 =?us-ascii?Q?mmujV6dALmFIdbRUdXYCDozIwAuqruH1JB7l8kDgAGw2zxafd073A6zu/6mN?=
 =?us-ascii?Q?8JmCoBo7L9QANIlUBGtOXdaZFXz6qPtsLLe1PLnZVn7mPxhY76ly3ovW9WIG?=
 =?us-ascii?Q?sN0qeuC5flidPsIoyTiyIp+VB+D3sDsTWvdyu83dYzZLhrPczvybMsy/AYVg?=
 =?us-ascii?Q?gof89mCNmDF/UA1fy5TDqF1pb+Hwrvw2X9UfTEZjAa1JwDiuQ4thedEB66vE?=
 =?us-ascii?Q?7AV03lJ4YndD3KtaET+ltpGgspzBnO+LhRBTsyXmljxZqF9UuLxAxsRUVwEg?=
 =?us-ascii?Q?XVsvgAGKdC2AXzOSbon0D6/BEPCxm8IbTHKh?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 17:43:11.8232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b831053-88df-432d-4e05-08ddc0a26806
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR03MB9387

The 'out_mic' pointer isn't written by this function and all callers
pass a NULL pointer for this. It's obviously not required (and would not
work), so lets remove it.
---
 mesh/crypto.c           | 10 ++++------
 mesh/crypto.h           |  3 +--
 mesh/net-keys.c         |  2 +-
 mesh/prov-initiator.c   |  2 +-
 unit/test-mesh-crypto.c |  2 +-
 5 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/mesh/crypto.c b/mesh/crypto.c
index 31001d283a04..3200d1231f1f 100644
--- a/mesh/crypto.c
+++ b/mesh/crypto.c
@@ -84,8 +84,7 @@ bool mesh_crypto_aes_cmac(const uint8_t key[16], const uint8_t *msg,
 bool mesh_crypto_aes_ccm_encrypt(const uint8_t nonce[13], const uint8_t key[16],
 					const uint8_t *aad, uint16_t aad_len,
 					const void *msg, uint16_t msg_len,
-					void *out_msg,
-					void *out_mic, size_t mic_size)
+					void *out_msg, size_t mic_size)
 {
 	void *cipher;
 	bool result;
@@ -733,8 +732,7 @@ bool mesh_crypto_payload_encrypt(uint8_t *aad, const uint8_t *payload,
 	if (!mesh_crypto_aes_ccm_encrypt(nonce, app_key,
 							aad, aad ? 16 : 0,
 							payload, payload_len,
-							out, NULL,
-							aszmic ? 8 : 4))
+							out, aszmic ? 8 : 4))
 		return false;
 
 	return true;
@@ -812,13 +810,13 @@ static bool mesh_crypto_packet_encrypt(uint8_t *packet, uint8_t packet_len,
 		if (!mesh_crypto_aes_ccm_encrypt(nonce, network_key,
 					NULL, 0,
 					packet + 7, packet_len - 7 - 8,
-					packet + 7, NULL, 8))
+					packet + 7, 8))
 			return false;
 	} else {
 		if (!mesh_crypto_aes_ccm_encrypt(nonce, network_key,
 					NULL, 0,
 					packet + 7, packet_len - 7 - 4,
-					packet + 7, NULL, 4))
+					packet + 7, 4))
 			return false;
 	}
 
diff --git a/mesh/crypto.h b/mesh/crypto.h
index 5e4d1d229c19..e4bbe4343223 100644
--- a/mesh/crypto.h
+++ b/mesh/crypto.h
@@ -15,8 +15,7 @@
 bool mesh_crypto_aes_ccm_encrypt(const uint8_t nonce[13], const uint8_t key[16],
 					const uint8_t *aad, uint16_t aad_len,
 					const void *msg, uint16_t msg_len,
-					void *out_msg,
-					void *out_mic, size_t mic_size);
+					void *out_msg, size_t mic_size);
 bool mesh_crypto_aes_ccm_decrypt(const uint8_t nonce[13], const uint8_t key[16],
 				const uint8_t *aad, uint16_t aad_len,
 				const void *enc_msg, uint16_t enc_msg_len,
diff --git a/mesh/net-keys.c b/mesh/net-keys.c
index 338d287a7ef7..0daeb9209b86 100644
--- a/mesh/net-keys.c
+++ b/mesh/net-keys.c
@@ -396,7 +396,7 @@ static bool mpb_compose(struct net_key *key, uint32_t ivi, bool kr, bool ivu)
 
 	l_getrandom(random, sizeof(random));
 	if (!mesh_crypto_aes_ccm_encrypt(random, key->pvt_key, NULL, 0,
-						b_data, 5, b_data, NULL, 8))
+						b_data, 5, b_data, 8))
 		return false;
 
 	key->mpb[0] = BT_AD_MESH_BEACON;
diff --git a/mesh/prov-initiator.c b/mesh/prov-initiator.c
index c0d2de443ac1..d46081c7ae19 100644
--- a/mesh/prov-initiator.c
+++ b/mesh/prov-initiator.c
@@ -466,7 +466,7 @@ void initiator_prov_data(uint16_t net_idx, uint16_t primary, void *caller_data)
 			&prov_data.data,
 			sizeof(prov_data.data),
 			&prov_data.data,
-			NULL, sizeof(prov_data.mic));
+			sizeof(prov_data.mic));
 	print_packet("EncdData", &prov_data.data, sizeof(prov_data) - 1);
 	prov->trans_tx(prov->trans_data, &prov_data, sizeof(prov_data));
 	prov->state = INT_PROV_DATA_SENT;
diff --git a/unit/test-mesh-crypto.c b/unit/test-mesh-crypto.c
index 81f0724fe540..36cae70a68a4 100644
--- a/unit/test-mesh-crypto.c
+++ b/unit/test-mesh-crypto.c
@@ -1864,7 +1864,7 @@ static void check_beacon(const struct mesh_crypto_test *keys)
 		l_put_be32(keys->iv_index, beacon + 15);
 		mesh_crypto_aes_ccm_encrypt(random, enc_key, NULL, 0,
 							beacon + 14, 5,
-							beacon + 14, NULL, 8);
+							beacon + 14, 8);
 		verify_data("BeaconMIC", 0, keys->beacon_cmac, beacon + 19, 8);
 		verify_data("PrivBeacon", 0, keys->beacon, beacon, 27);
 	}
-- 
2.43.0

