Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011050.outbound.protection.outlook.com [52.101.70.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B26B128395
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 22:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752271393; cv=fail; b=ZEiXMUbAArztTQCor+sFAjXoCQwZX37ydF5z31rPZIR9Fnq7bGI18Q+tD0JynOpLxOSE+MP2XcPKTwZlGrWvIzYhAsi8AF93vprMJfT1PsjoTdVDI2X9k71QN3b8/RISmKSDeojbhP9myp6b7vBssPDkrY8oWaNOmJGtmmWI55I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752271393; c=relaxed/simple;
	bh=CpwOpRWYbquJfB2mkUb40TluyWXqh4EKOUtQaaDrlis=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HoFK0E70Q5uO/wlcrOIBr6NLD8pxnLvzoypIrMyzRDdo2CRT3ku1DmAIpoWKR6FYw5X+nsWl7yMClwA8tPSXoBcHp9JCQ8tqXPELr74TJb7zI0v1xVVeYpbPzQwReccdkHkY6R7H6TZU/JoKBsFkHO1WWmw/L1s4UljRMlbuH1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=BGHIX8yJ; arc=fail smtp.client-ip=52.101.70.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="BGHIX8yJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/WfGIHB75Wk/qNwpTtTj3WjKT/v5+bkjXOWwEmAccBZluifRe8lGLhpdnQQiKkuRdNNw+Ub7ybAhCRUZypxsimSviaicr+4g7qkLNEz3VDdcGnD6p9394wxrXAV5nMFvUPJmf7APXHNcCfNS8R9E0YlJzS4Tp620k+NNWich+stYyCuqD2apfLR/HR5V/D9Zoz+AxXrWnKO0KoIYFjI/ZTdhCgl1sYVWD2+E4+P3ft+K+xE2LqAxqb+MqjBNWg2oWinnGxe1D0jZRQj9M4pOLO1qUmGt0f/fYmaT1fMumcC72fh3yFcqirVXvliaKgCSzXypJAcdmlNl8GCzUzXcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=At3WuUvoFvroJdEoDMcrAzIegijMD8HBSChR5WHgIbg=;
 b=gYUnB9bPa1tpfXnxolM8zQONt+xZbZSTYKUDnkin0fiK/5UPBAkT3Pn48airtx5XCRUzoz49vVp95L/0gWnDq0eHgcwldz8QSKKFlwnJatpW9e5+qsxf+YfHY1+J91cRv8zDxvCtVJAc3t4PFeB4TFJ1x0aQNu5vTBluijPd9QPAsQIDU9XK6bykTEKYj3Yr0l+p4fNpfS6IMKnTo6QB7D94/mDx+KOAqQgHQCx7Gx47SJ6EXsRoPpAIeVqWvODN/eD10v5P+oddsegbN4tpF/ZQiyqwB6uDTUZmryOQP5TO0zOv5OAYGQbf+xOZuVWmIOanRdN07k+oD8DemttZSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=At3WuUvoFvroJdEoDMcrAzIegijMD8HBSChR5WHgIbg=;
 b=BGHIX8yJ1k5tWtxH0x9p/e38RD6hTdqD0ZUOwICKjIeQrwm86QDijKCseUN0zzQBAqck110RuAoDG7/qHtIIyxKWh7VeSeJ1oYXtcOyqxkgLJTLBNTRAM9mCs+83axWZloeisfIxGHNOPPHkLvoGZWwKCgW3AIv4dsBfGQ1yQPo=
Received: from DU2PR04CA0234.eurprd04.prod.outlook.com (2603:10a6:10:2b1::29)
 by AS8PR03MB9818.eurprd03.prod.outlook.com (2603:10a6:20b:61a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Fri, 11 Jul
 2025 22:03:07 +0000
Received: from DU6PEPF0000A7DE.eurprd02.prod.outlook.com
 (2603:10a6:10:2b1:cafe::55) by DU2PR04CA0234.outlook.office365.com
 (2603:10a6:10:2b1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.27 via Frontend Transport; Fri,
 11 Jul 2025 22:03:07 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU6PEPF0000A7DE.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:03:06 +0000
Received: from N9W6SW14.arri.de (192.168.54.11) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Sat, 12 Jul
 2025 00:03:06 +0200
From: Christian Eggers <ceggers@arri.de>
To: Brian Gix <brian.gix@gmail.com>, Inga Stotland <inga.stotland@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
CC: <ceggers@arri.de>
Subject: [PATCH BlueZ v2 7/9] mesh: crypto: mesh_crypto_aes_ccm_encrypt(): remove unused parameter
Date: Fri, 11 Jul 2025 23:57:19 +0200
Message-ID: <20250711220035.10065-8-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711220035.10065-1-ceggers@arri.de>
References: <20250711220035.10065-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DE:EE_|AS8PR03MB9818:EE_
X-MS-Office365-Filtering-Correlation-Id: c332f200-aa21-4f73-3feb-08ddc0c6b752
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ShGjnhm3fLCOZEo+ZtodNrUMX6HPFO+Jsb2aoQay0Yt07xiIcGXXD0kq+3cq?=
 =?us-ascii?Q?Z5paqpS3SMrSHt1nKtmvh0uRjORlz1/ZDeVTYw1EfVzEybCuqU4BMOM5iJ2X?=
 =?us-ascii?Q?raFkSPKGp2Ipi5UexZzMXnbqyM9DHWQntB/0gJ+Q5uCh9iJgGiwUMiqC4StS?=
 =?us-ascii?Q?UnNVQMRUIOAhGJEPh0BBLSH/TcsrIeQV5feLI8yW+T2XQefSqDlaDwpjmYsc?=
 =?us-ascii?Q?3nPRsrwTG7fLM+fI0z7ew7Az21zPoIIVZbOaxrs97FicDNDjfacebHXTkaj5?=
 =?us-ascii?Q?cYKEmGVyyz7HTABn9ENuFXeAZTHJqP3GS+UjwICI2h/EypKbfPOOJaA8R/4g?=
 =?us-ascii?Q?2C+13+S8dOwQs5LPL5MV8ubOx7ybQThGLvIzJZxW+WKqseNvv7cCc+eYqLXD?=
 =?us-ascii?Q?nG0CYovOG2JEH6BCrFGIwEdA3JqLeIA0Whudt42tGn1EB1onw6ViJGDWMPvt?=
 =?us-ascii?Q?6ngKDY+di6lO7ATH6v+yxCZGYdckUsftj3hJBhPGg+K/ipVF2wFdDm6BeaVJ?=
 =?us-ascii?Q?tmJJZhmorFn/QD6mA9ylFC3N8THmFHCaCdP3slvfYZVfmCrDkbMpV0Gv+S9Q?=
 =?us-ascii?Q?JHbNRCjlo0Xze8drWzjHPaHXOSl4CVRLgdjvO68YKpfe4yWSPs20OzrczFdt?=
 =?us-ascii?Q?Fs9H7RiMwAuQKc7tnSLkgFbsPSfP5DceFosc+VIZXcuO2tKNtxW6VlarfpUK?=
 =?us-ascii?Q?ZVN/JJfD4++hKZLgZU0vvTtaAUXEuqzm4O1aVlGgfV+RKqBOC91kimdgm+/3?=
 =?us-ascii?Q?UzFcKbnIrnaFUWRkJmMBm/Wsdpl5oyiLTsxhvIaJtRMQEF1QIO1MdKcChAEW?=
 =?us-ascii?Q?c345bOj5W1FhGQTqzJCVbBMNfNcmotACxxQzvDFqFn4RMpuFF0ZcfOQOL+EJ?=
 =?us-ascii?Q?ISYJB9vsMHGRpaLEU1lueNmXuwdPt05nnI5X2/mXYnMC4P+sXO01s3YwX1e4?=
 =?us-ascii?Q?ze2PklSzZ41ga8S7GTcCVKrPut90n2FGcsnMQdq1sTXFp8n0XDF0kW2Fos0a?=
 =?us-ascii?Q?kxq10M7RwkD9o+g48qDzAlCx0usC8J44LwP4fJHVuvUg8XEU9hbEQIphdBfP?=
 =?us-ascii?Q?KW1njiThJnqsDNBpvroVdlpNL1FMB9oCHXqmBZHe5krjiOIQ935yzjRXIm3q?=
 =?us-ascii?Q?JScof2niOZNQvx95T1KIZpS0HzkRxxt0x4H2xO8o7aOoJBVs0AVTHz4wbFr+?=
 =?us-ascii?Q?a8mlckWkH5rrF94ZFuyfoHDPjjbxnM4pHFch5F5VzkYw5zTCbOWVbln2OUot?=
 =?us-ascii?Q?Avq9A2/FD2V1JB8GSdeJTh/3b07MIgIThrTsZuyFEaJe1i3QrDuHF3DdWhiW?=
 =?us-ascii?Q?B46sbEdijQZDpHCM6B8Rxgl1yWB6+DMnRj43+yY5sDoIkMD3M+70ZH/Tyjdy?=
 =?us-ascii?Q?XCi1kkPB3B8Wejx2yIrvWRBTZ1PW8cvZHY2aKqKDvP0IXKyHDjykK0l4rPmJ?=
 =?us-ascii?Q?bjt4YiVhknHD+af4LJtUShIK5qHVFAK5L7mNrkkhAdDOxz5to+8Os+kaBafO?=
 =?us-ascii?Q?NtQkE2fj3dElU7DKkuET4WiNmOezNQUPpB2B?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:03:06.7435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c332f200-aa21-4f73-3feb-08ddc0c6b752
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DE.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9818

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

