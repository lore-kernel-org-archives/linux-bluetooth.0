Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011035.outbound.protection.outlook.com [52.101.70.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE75A2DC34C
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 13:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751979928; cv=fail; b=difk/qKgYHS/Q1dxETvPlBI5zagdyg8HmdFiRfrTEO8G0eSJakVJA5gHL9+u8oW9WRFOOX/geaKpsaydzQRbDD+Cv/4AO4Jp0k+eWLOIacX5QxV+ey5vwHv662X3Cid0ysdhK9GZB2fk+AN6M6dbir1VqPaKcLXLiVUM8fQjl7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751979928; c=relaxed/simple;
	bh=4Ko4GIrmVcXBcSuUp/qkNdXuf0Tk+PoZj1d5sqBYMA8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FEzpnZNtZ8c2waG5SXnblKm2Ma/lW8dhxokrevrZMtQnQ/w/xFt8RH52gUVq1lSS861anS8r8LOz04LisRpQKEzwCbsSpfmRVup47XuPFBdHa4UtAHoIQw23kCnSijQAQM1PXwGQHnYa0K4u6X8dkbvXIq1CB5NsfCQNH2IVcG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=ntIS4bP3; arc=fail smtp.client-ip=52.101.70.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="ntIS4bP3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uqpnp4Ulh+QtPZ8ulGPbPP/Hx6qZZQcujj8fNF1mCSfpn8Ih7wpBjFfpNHnpTNpDOSO5COKToIfjGMos5Gx7/rCubInYltP8jZD0xUexCvZRBKD+WaxN1AJrA8ckiPt+AtiRpviVBVK5rF9OoxQ+NfuMrGGnqOxdfRXXS0oDxV/lXFO2xMaFfHHaIidujr+NGehiekxrPMuVymPr+TkUll0Wy8XdoKKTlsQKGZGdFP7MTFfi4U1iH9R93/f7+NLhXgQ64EvAh7icGtWKE69vMktunhjlYDHborBnSFBTZO7RwFtBKASbm0RVsNKEPOb0NFk2F2qjF9ycFqMQ45AR3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+nl3N15qoMPpEpATENQ3F0ZpWbYw5pF/V945gBS1qg=;
 b=b0YIE553Kx6dMqmwK29Uh+2CXSnyK76dJcE/yfvY6XNyYpt4g3OYZGBU4fTbFV5hrRZaD+UB3V1UqfNi6A9Y0nQ+rjZ71LO+20G/o0nQYvkRuntXD42UbtgKU/u/ILBr6MmV29IAxXnUysYbbLyKQsfk4IceP0j4mb+YCENvZHKlMLWiHlksZAmGo4pdpBHAsw6+HImBjH7DvaydG9b7U/tMwlm7zT1vNz86vLTgKofDV0CvYeT0RyF/ArTfCCcnmW0O62liD+l74BEpw88M3+m//MlweJwM0E4PkABbMKY1wy1NAE5gHx+HdvYcqSJIBJE5qA4V4Q3yU98i0ZJUgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+nl3N15qoMPpEpATENQ3F0ZpWbYw5pF/V945gBS1qg=;
 b=ntIS4bP3MGA8wpO7PIgk+zkfgjdLulbquBKRexhfDfaZ/BQ1aXJM+dapWMAACulZMUlsBSsEtUxwQdh7eHX/pEqZ7MXmHRLSqR/x50RqXauALvROZOuhVU+kDhrZM1hg2vfMTtLjOmr6skDq4XDFzoM3uuaEJu6pvBAKE8MHgh4=
Received: from PAZP264CA0215.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:237::29)
 by DU0PR03MB9446.eurprd03.prod.outlook.com (2603:10a6:10:41a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 13:05:21 +0000
Received: from AMS0EPF00000196.eurprd05.prod.outlook.com
 (2603:10a6:102:237:cafe::84) by PAZP264CA0215.outlook.office365.com
 (2603:10a6:102:237::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.26 via Frontend Transport; Tue,
 8 Jul 2025 13:05:21 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS0EPF00000196.mail.protection.outlook.com (10.167.16.217) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 13:05:21 +0000
Received: from N9W6SW14.arri.de (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Tue, 8 Jul
 2025 15:05:21 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 15/15] mesh: use '0x1' rathen than 'true' for bit operations
Date: Tue, 8 Jul 2025 14:59:47 +0200
Message-ID: <20250708125947.11988-15-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250708125947.11988-1-ceggers@arri.de>
References: <20250708125947.11988-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000196:EE_|DU0PR03MB9446:EE_
X-MS-Office365-Filtering-Correlation-Id: 694b4ea3-6b33-4953-ff00-08ddbe201867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ugQZIbYEcB/APiKQcVH04khs8umB3Rzz3J69r5qs19Plevycg9Wl4GoYiAri?=
 =?us-ascii?Q?rgCiKZGE3PtruShKQTlYLwdf66RiDc+1/FKM+ydHT4qV0wU9up8ASKVoybWn?=
 =?us-ascii?Q?4tTztFKkPJWX2T/9F9iFQsQISfExU5xAucd9j2iBjbtDY1EQhB9+AucaU9Tl?=
 =?us-ascii?Q?4zMhBG1XzedRWIs4xB9De+twS53WKk6HRpWho1Ux5cyBwIniCozz6i/ZtKwI?=
 =?us-ascii?Q?MA+9773J0tRYWj5AniV9DcC4XDctRvoQfcTaptcextE5Zu0WXh3JxLM1fO9P?=
 =?us-ascii?Q?EdrxHjAAbWh9J6rnR+53xP+xxI9xH7cNB85TyIutj6IJODRF+pm2oQzmRAFi?=
 =?us-ascii?Q?sLkLM5spNniTUj/kyCR+eMcApz+KYu3hcJnFE8qGsC1Ib0G1ZNkvMv56E0Kx?=
 =?us-ascii?Q?b2Mu1yh27jZOIdjTZNvTMZnojEPbRb/QSCHyP8GurbBhUX98TBQZLwVsn5MS?=
 =?us-ascii?Q?DGmKlSPTNzF0ksO9n2hN5NPDQG1TO0Wo1SptgrHhMy16nUWil7+42CayvgVP?=
 =?us-ascii?Q?UychhDW2QRfam42K14yrNTgVhDBvpq4mVOAedjA/A70YwDIizA0cEeenom45?=
 =?us-ascii?Q?PdJvkm4/y40mq81gNKjyj3PlyT3C/ZllEDzTt3R3jheb8WBbyPFsIhPgIUEe?=
 =?us-ascii?Q?mK/9fwatNf1ehZSICRFdlbn3SkeAnpHvYgWp6u8rJSdzoZcsAPibeHPhT5Xn?=
 =?us-ascii?Q?bkYUQM15CgqAaE0xKF3r8eQb2ZNCHJj8yj7WefALj9BTQlppYEWS56Wh93+q?=
 =?us-ascii?Q?Oa7dwbjielx8DY11y+Ikz1GU5GARYB6DEIkX/84f4U8VNZEFqoaFxQhwaVaf?=
 =?us-ascii?Q?Zi3UHuU2iYUi0FiRu2dzfIaB4YWJj7p9eMxNwUxk0FecmZvUWbhkItU+VN2b?=
 =?us-ascii?Q?On213BuPDfb9JYbJmVzDYBXMqJWtz/euWlnJzmYiLZoVQ950k1jy+4pMM9Uq?=
 =?us-ascii?Q?hkLDgEpKKm+dNCXB/4sSRV2S3Aw2fDWoQ1u6Aym+2AyWEm1U4tKQeboEot5C?=
 =?us-ascii?Q?IcW/JUsF0xT0zuTUUqSJQQ0tmfGGtCoqAAm/swb+7kEWJhKzv8vykEr61V/N?=
 =?us-ascii?Q?/vew2EegHB7ZLlFJYLIJtIwTZw+k1P5eWATDc6lrnb+zkPVbPJ3cwHCgLFKX?=
 =?us-ascii?Q?RRMJzb7ZOlwW+JXaNPBzjajohaERhFomE9y4MapXZC9vs3WyP2SunLGm1b/1?=
 =?us-ascii?Q?MinNE2hR4jHHS4KncdtHUk+QY1q5uf9AV7vGwDsTkYjk2sAAfixy4QyUfJFr?=
 =?us-ascii?Q?nGsKidN89LqP7xlQpjqEVCK8OQjqk6LRK1Scrj4aeeXyxSiHx8iZUnGAZg1m?=
 =?us-ascii?Q?UMAbFxmbsLXZM0Rokb8NJXTgWY7YRQf/sbgil7BYxrKO8R5uMV4Lu0zub/la?=
 =?us-ascii?Q?UE7JXzbL+DtaN4weXNeWVXJ+SaAngRNEMlF0ATgBCnjZahNAj96ikPhiembU?=
 =?us-ascii?Q?GVKvxWdQvB+XeUnN7BowTBEBJbpSIZzbaolb6BXuIRv/UsJNlJ2I9VekEK9Y?=
 =?us-ascii?Q?pOzBqyIQEyAM7owIdYp74UO8MTS3BZFWMNQE?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 13:05:21.3766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 694b4ea3-6b33-4953-ff00-08ddbe201867
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000196.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9446

Although 'true' expands to 1, it feels more natural using '0x1' (or '1')
when performing masking or bit shifting operations.
---
 mesh/crypto.c | 6 +++---
 mesh/net.c    | 4 ++--
 mesh/net.h    | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/mesh/crypto.c b/mesh/crypto.c
index a9d670485da5..31001d283a04 100644
--- a/mesh/crypto.c
+++ b/mesh/crypto.c
@@ -640,7 +640,7 @@ bool mesh_crypto_packet_parse(const uint8_t *packet, uint8_t packet_len,
 
 	hdr = l_get_be32(packet + 9);
 
-	is_segmented = !!((hdr >> SEG_HDR_SHIFT) & true);
+	is_segmented = !!((hdr >> SEG_HDR_SHIFT) & 0x1);
 	if (segmented)
 		*segmented = is_segmented;
 
@@ -655,7 +655,7 @@ bool mesh_crypto_packet_parse(const uint8_t *packet, uint8_t packet_len,
 
 		if (this_dst && this_opcode == NET_OP_SEG_ACKNOWLEDGE) {
 			if (relay)
-				*relay = !!((hdr >> RELAY_HDR_SHIFT) & true);
+				*relay = !!((hdr >> RELAY_HDR_SHIFT) & 0x1);
 
 			if (seqZero)
 				*seqZero = (hdr >> SEQ_ZERO_HDR_SHIFT) &
@@ -682,7 +682,7 @@ bool mesh_crypto_packet_parse(const uint8_t *packet, uint8_t packet_len,
 
 		if (is_segmented) {
 			if (szmic)
-				*szmic = !!((hdr >> SZMIC_HDR_SHIFT) & true);
+				*szmic = !!((hdr >> SZMIC_HDR_SHIFT) & 0x1);
 
 			if (seqZero)
 				*seqZero = (hdr >> SEQ_ZERO_HDR_SHIFT) &
diff --git a/mesh/net.c b/mesh/net.c
index e8e3e271cf59..895b79e60db2 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -3184,9 +3184,9 @@ void mesh_net_send_seg(struct mesh_net *net, uint32_t net_key_id,
 {
 	uint8_t packet[30];
 	uint8_t packet_len;
-	bool segmented = !!((hdr >> SEG_HDR_SHIFT) & true);
+	bool segmented = !!((hdr >> SEG_HDR_SHIFT) & 0x1);
 	uint8_t key_aid = (hdr >> KEY_HDR_SHIFT) & KEY_ID_MASK;
-	bool szmic = !!((hdr >> SZMIC_HDR_SHIFT) & true);
+	bool szmic = !!((hdr >> SZMIC_HDR_SHIFT) & 0x1);
 	uint16_t seqZero = (hdr >> SEQ_ZERO_HDR_SHIFT) & SEQ_ZERO_MASK;
 	uint8_t segO = (hdr >> SEGO_HDR_SHIFT) & SEG_MASK;
 	uint8_t segN = (hdr >> SEGN_HDR_SHIFT) & SEG_MASK;
diff --git a/mesh/net.h b/mesh/net.h
index 62b8f5896089..5200beb2fada 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -65,9 +65,9 @@ struct mesh_node;
 
 /* Mask of Hdr bits which must be constant over entire incoming SAR message */
 /* (SEG || AKF || AID || SZMIC || SeqZero || SegN) */
-#define HDR_KEY_MASK		((true << SEG_HDR_SHIFT) |		\
+#define HDR_KEY_MASK		((0x1 << SEG_HDR_SHIFT) |		\
 				(KEY_ID_MASK << KEY_HDR_SHIFT) |	\
-				(true << SZMIC_HDR_SHIFT) |		\
+				(0x1 << SZMIC_HDR_SHIFT) |		\
 				(SEQ_ZERO_MASK << SEQ_ZERO_HDR_SHIFT) |	\
 				(SEG_MASK << SEGN_HDR_SHIFT))
 
-- 
2.43.0

