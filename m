Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013002.outbound.protection.outlook.com [40.107.159.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EDA2F2705
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 17:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255813; cv=fail; b=ofLeb8K0D9iVUxsPpf0a8ndN7p7qRhsfE8X8Ww7JeGNipQFWgMB0vKnBu9nn2QlTMsb9XHp6WnRwHtnpdj0k6BXrXxV2kC/o3T9zVYTg6nX9kaYdJZhMEigj0rfzXlMDQykQe2p/TbeLD5vuWEHoufdpMSp2cy1PC5MyeODDK/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255813; c=relaxed/simple;
	bh=KfwtjEbh/TofZaABtpRb0yhb4TXeNZjpU3IUG24BoVU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MAQss3ZdLAlQ9h3xuuVIq8k7rPXYPFp8ZvKyOrzWWaW5suLMjTa6yBNNb9tNBUoCTCyAYPeYgsiBdTgFkLODKOSBnoif4cILxVwzAmprYHIen43R97kLOVc7d14GkiTHwnC3LjupZeDdMcB5mhX2AwBk/2yhsXdb0ZdNdX3095c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=bBloCAuo; arc=fail smtp.client-ip=40.107.159.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="bBloCAuo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOiB8ELvrtrXC5cIBQlmxYlu5DBkAqYBlTr86W2q/yeaUbvSGbl4OD3Qg7n7A1oddN24qH46CH7Y/KW2EnBkod0SlVvBOtfVSDonc1eRlJKIsRAsng0VYhNOWIev4k1QDQQ6HCMY4ahDsYIxSrphbHTJMQruQywIwWlnJmepGtXMajvvpiOEr/aCtR68tcZL21JRLZ9xcR2OOcrKmMO3pxVNKHua3KUHLlDT8K9azvCmQTDoSJ0XqWlBRW0vdAaBtSbI15+IK06K9v7aB2Qk3/10YW6HmB9EQx4Ywe4YIWAb0+uvNqczNxVx2KrzEqmxOC4AJHB/cmjl/ooueCvbHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcpgtka5i+yOc3sHThhdVC1k0rlrHG7XQiS/APkli84=;
 b=yYyehuGkDlLCZ6MeeXPaReUpx1AIjcjVBGcjbcibdPe6sY5U34aAhlYjex9c9REzyOVnnP7fSjbuL6TK8F8Fvrc93iPcSypxTBOqK5uh0fR4HdVc9gr3FfNHbTYtaFM0SP2+VpV3KSKMaC+s9sLLYZ3efCFp1GGiZMsX6z82inizNvcRtwYtcmxr7YFHmswoHtLyUK/meuh0vbH3Y150U7CvZl74nB4lfY8bmywCRAO/3qppKd8AQmnipzzUxRwRknm3iXh1cUR1XzYmyspjpKQrS/WaiWtndSTVfxtSf7zsZUsViXHZxhoO/8IEvXbjjtJ/FSmzZ1P8+Qoc+9JYTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcpgtka5i+yOc3sHThhdVC1k0rlrHG7XQiS/APkli84=;
 b=bBloCAuoiFFyMxyTW1dz2MHe0DO0ZEcJbrgK7XRufvoZjTqKVOxm2jWaqVxAFaaWOaij4xDtO/5DiHaAG0QXWfM/Rb5rfxbUWBwZ74JbrH75Icva8ey/azvbmAKjoqdanygr9SoJS+atM28EkPaGmr7HINgvbb0IVpmBBuea0UY=
Received: from DU7P195CA0004.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::34)
 by AS8PR03MB7462.eurprd03.prod.outlook.com (2603:10a6:20b:2e4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 17:43:27 +0000
Received: from DB1PEPF000509EF.eurprd03.prod.outlook.com
 (2603:10a6:10:54d:cafe::88) by DU7P195CA0004.outlook.office365.com
 (2603:10a6:10:54d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Fri,
 11 Jul 2025 17:43:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF000509EF.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 17:43:26 +0000
Received: from N9W6SW14.arri.de (192.168.54.13) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Fri, 11 Jul
 2025 19:43:26 +0200
From: Christian Eggers <ceggers@arri.de>
To: Brian Gix <brian.gix@gmail.com>, Inga Stotland <inga.stotland@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 8/9] mesh: crypto: simplify mesh_crypto_packet_parse()
Date: Fri, 11 Jul 2025 19:39:24 +0200
Message-ID: <20250711173958.25689-9-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EF:EE_|AS8PR03MB7462:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b664b8-a6da-4b4d-e83a-08ddc0a270fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?87AMebKz6qjkF7cXi89vuPN3ecciOnR5M9UdOW4+PWctm2Ie9efJMnVpBJc9?=
 =?us-ascii?Q?q49jENh/v2HraZQEh8aosEPTB++G+YuBIDLcwaZYY36amdqI9jMiaBcT76gR?=
 =?us-ascii?Q?z/TXrDzdwNHMSibuOx/ICrCKTEpm5xaS40V6nVO5LbfChTrFAt9J3Gig7u/y?=
 =?us-ascii?Q?ZkGvMUrj70BqNg34jHwN4hVlrhpWp76TVTr3G7cvNL3OYCWlRK9j/ECjIcKl?=
 =?us-ascii?Q?+5huoDSKDeF5jBtAZefegwtmIRe5Vh+Xgp6TmiJ22LYI4BuMJGzlDNHPOwBJ?=
 =?us-ascii?Q?d6i2Kv001EPSAna0wh/1CQUnyHiexbBGzrb5dCFo8ZgOuk1DWx3+EDD6MmJ3?=
 =?us-ascii?Q?Q9kQPCB3hv/ZxLxGboK5YTbOghsJPgzrX0qeqYmv0o4xs9dcatNd0yZ112P9?=
 =?us-ascii?Q?u/t5IaJXQxvrIsixGeEGRANZp1pyUHTyppYjveMArQgNiMrC1kmmDmSIeeB2?=
 =?us-ascii?Q?1RgongUc+Ks9zSTf6hv5Oo4UiENxvb7ojFK9HKjeNMOhKDuL8PN0+tNJsoZF?=
 =?us-ascii?Q?RsFvxiq9CV6RyWE6fqNtAGganh6aOh05jfe2rTkocnuL+SCmZ9V7JSljZJY+?=
 =?us-ascii?Q?Cv+GE42beHSGh64KJ6P7gsXzCSrhBH4V1afuY4H71014tBVNyEFRet7OneiT?=
 =?us-ascii?Q?+k/+zGQzZTWYZM5CwotNvxtoi1kSJNt8GdL4gVrX/Gm9PuyW6Gi9sdve1Li3?=
 =?us-ascii?Q?njAYJMt+C4rOZJwD6FQdS/yyEgDNTHwOYoVgsEjqS38SWVlntQPsMCfhIluA?=
 =?us-ascii?Q?so1r0LfI/Mdio+GwzknQbbiAihSBJQe0G7xce5hB7MZgC24RteuMl0qVaApF?=
 =?us-ascii?Q?roRu50stpyhxd96ti0MEtSzMi6yKTgQe1zYauqq6sXFHYCK89f4uW06xWTw3?=
 =?us-ascii?Q?YyC815bk6zZy9P/+0Vf6D4JHzMhRQCxGnfy+IHxuDDrMEWeBgwm2wLwcBjK0?=
 =?us-ascii?Q?7l+SJXCKzkQvIhWev+I7Zx6bbe5ikjIhjmgtXsAMVhlHLNdAlj/0n/4jTYEc?=
 =?us-ascii?Q?NXyNl+Kwc2WHdXn+wh1ST8shk+pnaut8wtrZ4ZPfKL0GHXEn/RQ36uF0E2Y+?=
 =?us-ascii?Q?zdCG1sNQjpwdM45NpDNMZx2HE4ih782p4e+Lpj3jteoR6z32a+qtCQIVdsyF?=
 =?us-ascii?Q?zunjDlHVkXBh/wQKjkWAXQfmLu9HtYe9Lwq1vWvgsZ2CjSNYytiKSqNMisev?=
 =?us-ascii?Q?re5xSUN2WgJUWaja0cet5A6u2epPtXt5B/XMYuwzoJP8+EEkjkGt3fMW5S1L?=
 =?us-ascii?Q?YWtsxtdSO9kD+JjSPgqqsqu1Nip7O3wvBDKMflLSYzBY02XyzbEUb09rsDS/?=
 =?us-ascii?Q?1a8cX8HajcV/AKsI9/tnuJZA12xZ8eKKBt/16wlHWRUJQFVQ0WMQRPHOg7Pg?=
 =?us-ascii?Q?YvAPhGqRp+/3sXRfXPk/KREBYA88AD6ndoX1L86yRSoLxKAOFJv8K/WHPpQD?=
 =?us-ascii?Q?6OTVP9bkI2MXdY5wHzTWdpVmrlOBhNcLocEFMf4Jd7gqjDAchtZ3CZFly0NN?=
 =?us-ascii?Q?rO+LIGqLOi8FHeVWaVOmnPZ9102w8nvgjFzM?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 17:43:26.8479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b664b8-a6da-4b4d-e83a-08ddc0a270fa
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7462

- NULL pointer checks are not required (no caller passes NULL pointers)
- reuse result of mesh_crypto_network_header_parse() rather than
  determining value of 'CTL' again.
---
 mesh/crypto.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/mesh/crypto.c b/mesh/crypto.c
index 3200d1231f1f..3dcf226ad8d3 100644
--- a/mesh/crypto.c
+++ b/mesh/crypto.c
@@ -643,7 +643,7 @@ bool mesh_crypto_packet_parse(const uint8_t *packet, uint8_t packet_len,
 	if (segmented)
 		*segmented = is_segmented;
 
-	if (packet[1] & CTL) {
+	if (*ctl) {
 		uint8_t this_opcode = packet[9] & OPCODE_MASK;
 
 		if (cookie)
@@ -660,17 +660,11 @@ bool mesh_crypto_packet_parse(const uint8_t *packet, uint8_t packet_len,
 				*seqZero = (hdr >> SEQ_ZERO_HDR_SHIFT) &
 								SEQ_ZERO_MASK;
 
-			if (payload)
-				*payload = packet + 9;
-
-			if (payload_len)
-				*payload_len = packet_len - 9;
+			*payload = packet + 9;
+			*payload_len = packet_len - 9;
 		} else {
-			if (payload)
-				*payload = packet + 10;
-
-			if (payload_len)
-				*payload_len = packet_len - 10;
+			*payload = packet + 10;
+			*payload_len = packet_len - 10;
 		}
 	} else {
 		if (cookie)
@@ -693,17 +687,11 @@ bool mesh_crypto_packet_parse(const uint8_t *packet, uint8_t packet_len,
 			if (segN)
 				*segN = (hdr >> SEGN_HDR_SHIFT) & SEG_MASK;
 
-			if (payload)
-				*payload = packet + 13;
-
-			if (payload_len)
-				*payload_len = packet_len - 13;
+			*payload = packet + 13;
+			*payload_len = packet_len - 13;
 		} else {
-			if (payload)
-				*payload = packet + 10;
-
-			if (payload_len)
-				*payload_len = packet_len - 10;
+			*payload = packet + 10;
+			*payload_len = packet_len - 10;
 		}
 	}
 
-- 
2.43.0

