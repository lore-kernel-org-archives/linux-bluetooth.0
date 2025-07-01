Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013033.outbound.protection.outlook.com [40.107.162.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15059278772
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 14:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751381340; cv=fail; b=JKmIhC9ARVvv1dA7zIQEel3rFqLd8UuS9OqhYd9wSfmY+0dtHY+1jRFW0m1JZA/iXN0GYWxe/eRq5TSDRmABy5CBm4bsSM8BYX7V6fb3aJnPc2fvNtOjqtBTvur/EqW5adcHkdQJqGXSlXrWJTu1XV3k840l8rJEgW+JGFz+1Qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751381340; c=relaxed/simple;
	bh=dHs1TietHen/efdl9blaRyQjHaxN++W+K/vYt5ZeYZc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bSONXj0PCtfacBCsmZXON9H87vpDMa5Bwy9zRcewoGbQ0+Z1QEFdZVUf9kcRdFJh80TGwIvx9o5mALmd5PZmlln2QD9Ajabk+AQh2jGHEsukJCXEeo5QEBNuy93kdnG+t6yeL3aPvUMlZFP+vsGSkmKXxDdBA4viEK2pxceYhPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=bo4oLDeo; arc=fail smtp.client-ip=40.107.162.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="bo4oLDeo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nrmvzb62NsseAyzbWHE8tmPQBxqg7aRHkwTy437zrDiJGsIlmWkU4SqQZwQDmvfNCS7gPU4bOSBAonLNBMrGHSsC+EbWn1ka4yXVxvGv/3y3x5ZAgb0VVpuTnPTc8w/L5RD+ggDr+JTHMg0BA/DVlnuSjnNXek0HUosbtv5b2xVowI88tfg9inQiRLZW56pGlLGwaV6WZutIuCFxHA7Jcvpqpri2LYz7HrjrLFy79bD5h7O3z3Jd4OUC3QG+AXpiywWRM77Wfcyk/dV49/Pnt3SapFk4mBcYAymE91H88E397kdThUN7tQgrn6AYijUyBs//sHuGOt6ZkMSjQ5RNjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iyLyeDvGIl/y0oqnSKzyk+qLSuYJaGa15fit8tKsH4=;
 b=cf05Q58Hm/LcGZSihluJmFHDZuCR8611AGX3C6XVZBpbnIMO18dZ802n5UgsDpiwz7aJuBm4oZS97JunPCQHehWE6pwDRV2Pblh8016joIgCIblTSL/BfqWQvgg4B2Pw5n/zoLb7oVDxvJrjxp4wSSzFpyfXJR1XjZDnywDPn+aN1vab3T1ZBs5J19791hdM0Rq5NHmPfdGM11bGgCCjqSbto2Iym0D4OFIl80FqFOANuraCEVV2pb9SntUHtrg8cuw/nzxK4GoC3v3MDCmwgx36iLI9cXb/tppQKZTudkCNW03t8ziwSXVTfXse1kXDdt9KO0kfaFkvA1VL11ssnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iyLyeDvGIl/y0oqnSKzyk+qLSuYJaGa15fit8tKsH4=;
 b=bo4oLDeoxMjlHxqZq/f1lhTTMdXdnV/HUIucui/dllHfN5EK0yCpzBySC+WwQE8537ClJjrilhoCW5ICWSGfveKFdUqStBgs/TTJIASj/6HvwmLUj9xqDWBNoW90qHhdoiBcpojr171zpTIsi9PXtdVitbxEZKoah3XiFUXECv4=
Received: from AS4P190CA0038.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d1::17)
 by AM9PR03MB6979.eurprd03.prod.outlook.com (2603:10a6:20b:285::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Tue, 1 Jul
 2025 14:48:52 +0000
Received: from AMS0EPF000001A8.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d1:cafe::7d) by AS4P190CA0038.outlook.office365.com
 (2603:10a6:20b:5d1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Tue,
 1 Jul 2025 14:48:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS0EPF000001A8.mail.protection.outlook.com (10.167.16.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 14:48:51 +0000
Received: from N9W6SW14.arri.de (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Tue, 1 Jul
 2025 16:48:50 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Brian Gix <brian.gix@gmail.com>, Inga Stotland <inga.stotland@gmail.com>,
	Christian Eggers <ceggers@arri.de>
Subject: [RFC PATCH BlueZ 4/4] mesh: initial support for proxy configuration messages via GATT
Date: Tue, 1 Jul 2025 16:22:24 +0200
Message-ID: <20250701144647.19572-7-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701144647.19572-2-ceggers@arri.de>
References: <20250701144647.19572-2-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A8:EE_|AM9PR03MB6979:EE_
X-MS-Office365-Filtering-Correlation-Id: 85297844-9745-47c6-2f72-08ddb8ae64ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?78n7Qd05ssGvPEkAMmUl3EzG1O2EvXZ/52OoQ9u/4ZCW29aqbRKIyp6mWn4M?=
 =?us-ascii?Q?Xaj1FeVVh/YbNpKh0CC2GCZVAMEme4K6VhFjOVCA5cRM3cRh/NhUcO90gTTs?=
 =?us-ascii?Q?xmRvApyHd0wJMD2g6T43CJc4LoLLn+vH9+oHoOVVLSkJ62bRHafDeS+TH7GZ?=
 =?us-ascii?Q?0ddvLnZn1fnN4FdiphuGmBCfeMzypgaEPYKTp2ZZD47LbDfhRMyWKKvKTr//?=
 =?us-ascii?Q?eiePI4aFfjoa9+pzy6Wv47PNkWsqX7FVxPAvpLJ3HEItRB5lQNPRGhDsTC5L?=
 =?us-ascii?Q?2omhr4+PzxS9tsnAwGVcOjrV4HVyUYmNr3ZttmcjhQvtAIahGULbMaLOmjAm?=
 =?us-ascii?Q?91Xgj3gpNGZ4c74ApFYULSC7FTTXGIoCgZdxN7EE9aaK6Od5yFazkV/5+xcO?=
 =?us-ascii?Q?fiXl0O2gPPAScnnibCf1JQQYfVQS5kCOReRqS4tYGFL0XEm0jeza8+Cc8+vA?=
 =?us-ascii?Q?2FwuvY/8uPtQynLDHaw54LhWD64Rr2adTHqgvEdu6hKhhwP+2necidsuLa2d?=
 =?us-ascii?Q?WAVwX0ztWPrMB9SiSOmYGKUt5VhqMQCldo7c9+DfJqHJUFUpk80kgEaR5NnZ?=
 =?us-ascii?Q?Vz328GfbGyfTpZglQp8xRYDbQ9YYW/9EYS1v1Rj/UYaAQ0mAyYrby3WArCpq?=
 =?us-ascii?Q?lHob7LgLkRUisnWZyRaUdKU15tXXvIoZSCgHWzjkSSMccyKaeX7gy8MEIJIz?=
 =?us-ascii?Q?o5X3SAyFNq5pA9/9VUjdu9Puzg6yyk2DW8UVneU27L9GXa+5g1XPRoiyf8kN?=
 =?us-ascii?Q?mIpTD6LCoa2gXvSTH3jfK9LTiNyGdpeWg5NREzDE9kTRG2tQ+kBSuZBPWbSH?=
 =?us-ascii?Q?EVawSja84BLDfw8Qtqpt5lWsJPSIreA58D6CK43zBIkT52x/hnvMorJTQvIL?=
 =?us-ascii?Q?SkzeVPKMLifIarh2ZMWxMYkTyROdKX+G8gxANL3aJo3uWnwYqF1IFfg5Y+50?=
 =?us-ascii?Q?+ZJvnXs2+XHj2Vl59t1ub7phIh4j2L5LBoVpzvZFsz5YavGeDamvKvYbYmWs?=
 =?us-ascii?Q?x+zUX4IYpGRxbRCH4EM4SaN0ub97vFM0voKs23e9U5IvpH9i8924Wn6sSsbf?=
 =?us-ascii?Q?8QImLzkccagWsUacsJWnXDGNOya5ewpXu2Mkke7QVOBn5QYlAjHd2uyDZQib?=
 =?us-ascii?Q?Ovl0EkOWP4a9TexHBWb3t6CdQ1zBx1uQzjdl72eqr4sxsST7D++2uCsZUvFS?=
 =?us-ascii?Q?vnf2gcL553NeItnZF/u7rIzzz5Q/pT93ECAZ7485Pwubsk8UeoXWJyqBEdIF?=
 =?us-ascii?Q?pnltr36frjiNgHbiVoUImUsOIex6TyMndtto4MMGD/HSjQjJGOIe2UHv6hYF?=
 =?us-ascii?Q?stuVcaAWOQAXwQP7nTIuVqRChIU42bovkaZ6FiyMPJSBCIlheJEcoFMsWH0V?=
 =?us-ascii?Q?VUBKkQBjJDpSYMelk6kd4NGYww9fN4q4anGFoz03xM32GPgA/i7WGUg35eHl?=
 =?us-ascii?Q?iHHaHVsYNlRCz8FtU/ndsjisbhghCVrJeQjMRp8bNNudbvg65YpSx5dQP3M1?=
 =?us-ascii?Q?RkMvx6KsriJK+Z8UUZG/cA5f8se7Cx+UMrmi?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 14:48:51.0853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85297844-9745-47c6-2f72-08ddb8ae64ca
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A8.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB6979

Implement reception and response for Proxy Configuration Messages
(MshPRT_v1.1, section 6.6).

ToDo: Apply configured filters.
---
 Makefile.mesh    |   3 +-
 mesh/crypto.c    |   6 +-
 mesh/crypto.h    |   3 +
 mesh/net-keys.c  |  58 +++++++++++++++++-
 mesh/net-keys.h  |   3 +
 mesh/net.c       |  56 +++++++++++++++++-
 mesh/proxy-cfg.c | 149 +++++++++++++++++++++++++++++++++++++++++++++++
 mesh/proxy-cfg.h |  17 ++++++
 8 files changed, 289 insertions(+), 6 deletions(-)
 create mode 100644 mesh/proxy-cfg.c
 create mode 100644 mesh/proxy-cfg.h

diff --git a/Makefile.mesh b/Makefile.mesh
index 8a190f75de9d..d39bb17eca70 100644
--- a/Makefile.mesh
+++ b/Makefile.mesh
@@ -41,7 +41,8 @@ mesh_sources = mesh/mesh.h mesh/mesh.c \
 				mesh/prv-beacon.h mesh/prvbeac-server.c \
 				mesh/mesh-defs.h \
 				mesh/gatt-service.h mesh/gatt-service.c \
-				mesh/gatt-proxy-svc.h mesh/gatt-proxy-svc.c
+				mesh/gatt-proxy-svc.h mesh/gatt-proxy-svc.c \
+				mesh/proxy-cfg.h mesh/proxy-cfg.c
 pkglibexec_PROGRAMS += mesh/bluetooth-meshd
 
 mesh/mesh.$(OBJEXT): ell/internal
diff --git a/mesh/crypto.c b/mesh/crypto.c
index ab44baee3427..93c3af751e80 100644
--- a/mesh/crypto.c
+++ b/mesh/crypto.c
@@ -591,7 +591,7 @@ bool mesh_crypto_packet_build(bool ctl, uint8_t ttl,
 	return true;
 }
 
-static bool network_header_parse(const uint8_t *packet, uint8_t packet_len,
+bool mesh_crypto_network_header_parse(const uint8_t *packet, uint8_t packet_len,
 				bool *ctl, uint8_t *ttl, uint32_t *seq,
 				uint16_t *src, uint16_t *dst)
 {
@@ -631,7 +631,7 @@ bool mesh_crypto_packet_parse(const uint8_t *packet, uint8_t packet_len,
 	uint16_t this_dst;
 	bool is_segmented;
 
-	if (!network_header_parse(packet, packet_len,
+	if (!mesh_crypto_network_header_parse(packet, packet_len,
 					ctl, ttl, seq, src, &this_dst))
 		return false;
 
@@ -836,7 +836,7 @@ bool mesh_crypto_packet_encode(uint8_t *packet, uint8_t packet_len,
 	uint16_t src;
 	uint16_t dst;
 
-	if (!network_header_parse(packet, packet_len,
+	if (!mesh_crypto_network_header_parse(packet, packet_len,
 						&ctl, &ttl, &seq, &src, &dst))
 		return false;
 
diff --git a/mesh/crypto.h b/mesh/crypto.h
index 55789886eb0e..d66248f84cff 100644
--- a/mesh/crypto.h
+++ b/mesh/crypto.h
@@ -77,6 +77,9 @@ bool mesh_crypto_packet_parse(const uint8_t *packet, uint8_t packet_len,
 				bool *szmic, bool *relay, uint16_t *seqZero,
 				uint8_t *segO, uint8_t *segN,
 				const uint8_t **payload, uint8_t *payload_len);
+bool mesh_crypto_network_header_parse(const uint8_t *packet, uint8_t packet_len,
+				bool *ctl, uint8_t *ttl, uint32_t *seq,
+				uint16_t *src, uint16_t *dst);
 bool mesh_crypto_payload_encrypt(uint8_t *aad, const uint8_t *payload,
 				uint8_t *out, uint16_t payload_len,
 				uint16_t src, uint16_t dst, uint8_t key_aid,
diff --git a/mesh/net-keys.c b/mesh/net-keys.c
index 62ea4208af98..4b2e14cabb01 100644
--- a/mesh/net-keys.c
+++ b/mesh/net-keys.c
@@ -76,6 +76,15 @@ struct net_key {
 	bool ivu;
 };
 
+struct proxy_cfg_msg {
+	const uint8_t *data;
+	uint8_t len;
+	uint8_t *plain;
+	uint8_t plain_len;
+	uint32_t iv_index;
+	uint32_t key_id;
+};
+
 static struct l_queue *beacons;
 static struct l_queue *keys;
 static uint32_t last_flooding_id;
@@ -249,13 +258,36 @@ static void decrypt_net_pkt(void *a, void *b)
 
 	if (result) {
 		cache_id = key->id;
-		if (cache_plain[1] & 0x80)
+		if (cache_plain[1] & CTL)
 			cache_plainlen = cache_len - 8;
 		else
 			cache_plainlen = cache_len - 4;
 	}
 }
 
+static void decrypt_proxy_cfg_msg(void *a, void *b)
+{
+	const struct net_key *key = a;
+	struct proxy_cfg_msg *proxy_cfg = b;
+	bool result;
+
+	if (proxy_cfg->key_id || !key->ref_cnt ||
+					(proxy_cfg->data[0] & 0x7f) != key->nid)
+		return;
+
+	result = mesh_crypto_packet_decode(proxy_cfg->data, proxy_cfg->len,
+							true,
+							proxy_cfg->plain,
+							proxy_cfg->iv_index,
+							key->enc_key,
+							key->prv_key);
+
+	if (result) {
+		proxy_cfg->key_id = key->id;
+		proxy_cfg->plain_len = proxy_cfg->len - 8;
+	}
+}
+
 uint32_t net_key_decrypt(uint32_t iv_index, const uint8_t *pkt, size_t len,
 					uint8_t **plain, size_t *plain_len)
 {
@@ -285,6 +317,30 @@ done:
 	return cache_id;
 }
 
+uint32_t net_key_decrypt_proxy_cfg_msg(uint32_t iv_index,
+					const uint8_t *pkt, size_t len,
+					uint8_t *plain, size_t *plain_len)
+{
+	struct proxy_cfg_msg proxy_cfg = {
+		.data = pkt,
+		.len = len,
+		.plain = plain,
+		.iv_index = iv_index,
+	};
+
+	/* MshPRT_v1.1, section 6.6: Proxy configuration messages have CTL=1 */
+	if (!(pkt[1] & CTL))
+		return 0;
+
+	/* Try all network keys known to us */
+	l_queue_foreach(keys, decrypt_proxy_cfg_msg, &proxy_cfg);
+
+	if (proxy_cfg.key_id)
+		*plain_len = proxy_cfg.plain_len;
+
+	return proxy_cfg.key_id;
+}
+
 bool net_key_encrypt(uint32_t id, uint32_t iv_index, uint8_t *pkt, size_t len)
 {
 	struct net_key *key = l_queue_find(keys, match_id, L_UINT_TO_PTR(id));
diff --git a/mesh/net-keys.h b/mesh/net-keys.h
index 5a9d7868ab48..141543feace2 100644
--- a/mesh/net-keys.h
+++ b/mesh/net-keys.h
@@ -23,6 +23,9 @@ uint32_t net_key_frnd_add(uint32_t flooding_id, uint16_t lpn, uint16_t frnd,
 void net_key_unref(uint32_t id);
 uint32_t net_key_decrypt(uint32_t iv_index, const uint8_t *pkt, size_t len,
 					uint8_t **plain, size_t *plain_len);
+uint32_t net_key_decrypt_proxy_cfg_msg(uint32_t iv_index,
+					const uint8_t *pkt, size_t len,
+					uint8_t *plain, size_t *plain_len);
 bool net_key_encrypt(uint32_t id, uint32_t iv_index, uint8_t *pkt, size_t len);
 uint32_t net_key_network_id(const uint8_t network[8]);
 uint32_t net_key_beacon(const uint8_t *data, uint16_t len, uint32_t *ivi,
diff --git a/mesh/net.c b/mesh/net.c
index a64cfbde6f4e..141ec4f5acb1 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -25,6 +25,7 @@
 #include "mesh/net-keys.h"
 #include "mesh/node.h"
 #include "mesh/net.h"
+#include "mesh/proxy-cfg.h"
 #include "mesh/mesh-io.h"
 #include "mesh/friend.h"
 #include "mesh/gatt-service.h"		// PROXY_MSG_TYPE_NETWORK_PDU
@@ -2352,7 +2353,7 @@ static enum _relay_advice packet_received(struct mesh_net *net,
 		return RELAY_NONE;
 	}
 
-	if (net_dst == 0) {
+	if (net_dst == UNASSIGNED_ADDRESS) {
 		l_error("illegal parms: DST: %4.4x Ctl: %d TTL: %2.2x",
 						net_dst, net_ctl, net_ttl);
 		return RELAY_NONE;
@@ -2523,6 +2524,34 @@ static void net_rx(void *net_ptr, void *user_data)
 	}
 }
 
+static void net_proxy_cfg_msg_rx(void *net_ptr, void *user_data)
+{
+	struct net_queue_data *data = user_data;
+	struct mesh_net *net = net_ptr;
+	uint8_t out[29];
+	size_t out_size;
+	uint32_t net_key_id;
+	bool ivi_net = !!(net->iv_index & 1);
+	bool ivi_pkt = !!(data->data[0] & 0x80);
+
+	/* if IVI flag differs, use previous IV Index */
+	uint32_t iv_index = net->iv_index - (ivi_pkt ^ ivi_net);
+
+	net_key_id = net_key_decrypt_proxy_cfg_msg(iv_index,
+							data->data, data->len,
+							out, &out_size);
+
+	if (!net_key_id)
+		return;
+
+	if (!data->seen) {
+		data->seen = true;
+		print_packet("RX: ProxyCfg [enc] :", data->data, data->len);
+	}
+
+	proxy_cfg_msg_received(net, net_key_id, iv_index, out, out_size);
+}
+
 static void net_msg_recv(void *user_data, struct mesh_io_recv_info *info,
 					const uint8_t *data, uint16_t len)
 {
@@ -2560,6 +2589,26 @@ static void net_msg_recv(void *user_data, struct mesh_io_recv_info *info,
 	}
 }
 
+static void
+net_proxy_cfg_msg_recv(void *user_data, struct mesh_io_recv_info *info,
+					const uint8_t *data, uint16_t len)
+{
+	struct net_queue_data net_data = {
+		.info = info,
+		.data = data + 1,
+		.len = len - 1,
+		.relay_advice = RELAY_NONE,
+		.seen = false,
+	};
+
+	if (len < 9)
+		return;
+
+	l_queue_foreach(nets, net_proxy_cfg_msg_rx, &net_data);
+
+	/* Proxy configuration messages are not relayed */
+}
+
 static void iv_upd_to(struct l_timeout *upd_timeout, void *user_data)
 {
 	struct mesh_net *net = user_data;
@@ -3074,6 +3123,9 @@ void mesh_net_attach_gatt(struct gatt_proxy_service *gatt_proxy)
 	gatt_proxy_service_register_recv_cb(gatt_proxy,
 						PROXY_MSG_TYPE_NETWORK_PDU,
 						net_msg_recv, NULL);
+	gatt_proxy_service_register_recv_cb(gatt_proxy,
+						PROXY_MSG_TYPE_PROXY_CFG,
+						net_proxy_cfg_msg_recv, NULL);
 }
 
 void mesh_net_detach_gatt(struct gatt_proxy_service *gatt_proxy)
@@ -3082,6 +3134,8 @@ void mesh_net_detach_gatt(struct gatt_proxy_service *gatt_proxy)
 
 	gatt_proxy_service_deregister_recv_cb(gatt_proxy,
 						PROXY_MSG_TYPE_NETWORK_PDU);
+	gatt_proxy_service_deregister_recv_cb(gatt_proxy,
+						PROXY_MSG_TYPE_PROXY_CFG);
 }
 
 bool mesh_net_iv_index_update(struct mesh_net *net)
diff --git a/mesh/proxy-cfg.c b/mesh/proxy-cfg.c
new file mode 100644
index 000000000000..2cb23e0cc05b
--- /dev/null
+++ b/mesh/proxy-cfg.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2025  ARRI Lighting. All rights reserved.
+ *
+ *
+ */
+
+#include <stdbool.h>
+
+#include <ell/dbus.h>
+#include <ell/log.h>
+#include <ell/util.h>			// l_put_be16()
+
+#include "mesh/crypto.h"		// mesh_crypto_network_header_parse()
+#include "mesh/mesh-io.h"		// mesh_io_recv_func_t, required by gatt-proxy-svc.h
+#include "mesh/gatt-service.h"		// PROXY_MSG_TYPE_PROXY_CFG
+#include "mesh/gatt-proxy-svc.h"	// gatt_proxy_service_send()
+#include "mesh/mesh-defs.h"		// UNASSIGNED_ADDRESS
+#include "mesh/net.h"			// mesh_net_next_seq_num(),
+					// mesh_net_get_address()
+#include "mesh/net-keys.h"		// net_key_encrypt(),
+					// net_key_decrypt_proxy_cfg_msg()
+#include "mesh/util.h"			// print_packet()
+#include "mesh/proxy-cfg.h"
+
+enum proxy_cfg_msg_op {
+	PROXY_CFG_MSG_OP_FILTER_SET_TYPE = 0x00,
+	PROXY_CFG_MSG_OP_FILTER_ADDRS_ADD = 0x01,
+	PROXY_CFG_MSG_OP_FILTER_ADDRS_REM = 0x02,
+	PROXY_CFG_MSG_OP_FILTER_STATUS = 0x03,
+};
+
+enum proxy_filter_type {
+	PROXY_FILTER_TYPE_ACCEPT_LIST = 0x00,
+	PROXY_FILTER_TYPE_REJECT_LIST = 0x00,
+};
+
+static enum proxy_filter_type filter_type = PROXY_FILTER_TYPE_ACCEPT_LIST;
+static uint8_t num_filters = 0;
+
+void proxy_cfg_msg_received(struct mesh_net *net, uint32_t net_key_id,
+					uint32_t iv_index,
+					const uint8_t *data, uint8_t size)
+{
+	const uint8_t *msg;
+	uint8_t cfg_msg_len;
+	uint8_t net_ttl;
+	uint32_t net_seq;
+	uint16_t net_src, net_dst;
+	bool net_ctl;
+	uint8_t rsp[10];
+	uint8_t rsp_len = 0;
+
+	print_packet("RX: ProxyCfg [clr] :", data, size);
+
+	if (!mesh_crypto_network_header_parse(data, size, &net_ctl, &net_ttl,
+					&net_seq, &net_src, &net_dst)) {
+		l_error("Failed to parse packet content");
+		return;
+	}
+
+	/*
+	 * MshPRT_v1.1, section 6.6:
+	 * - The CTL field shall be set to 1. [already checked]
+	 * - The TTL field shall be set to 0.
+	 * - The DST field shall be set to the unassigned address.
+	 */
+	if (net_dst != UNASSIGNED_ADDRESS || net_ttl) {
+		l_error("illegal parms: DST: %4.4x Ctl: %d TTL: %2.2x",
+						net_dst, net_ctl, net_ttl);
+		return;
+	}
+
+	l_debug("RX: ProxyCfg %04x -> %04x : TTL 0x%02x : IV : %8.8x SEQ 0x%06x",
+			net_src, net_dst, net_ttl, iv_index, net_seq);
+
+	msg = data + 9;
+	cfg_msg_len = size - 9;
+
+	if (!cfg_msg_len)
+		return;
+
+	/* process request */
+	switch (msg[0]) {
+		case PROXY_CFG_MSG_OP_FILTER_SET_TYPE:
+			if (cfg_msg_len > 1) {
+				filter_type = msg[1];
+				num_filters = 0;
+			}
+			break;
+
+		case PROXY_CFG_MSG_OP_FILTER_ADDRS_ADD:
+			if (cfg_msg_len & 0x1)
+				num_filters += (cfg_msg_len - 1) / 2;
+			break;
+
+		case PROXY_CFG_MSG_OP_FILTER_ADDRS_REM:
+			if (cfg_msg_len)
+				num_filters -= (num_filters >= ((cfg_msg_len - 1) / 2)) ? ((cfg_msg_len - 1) / 2) : num_filters;
+			break;
+
+		default:
+			break;
+	}
+
+	/* prepare response */
+	switch (msg[0]) {
+		case PROXY_CFG_MSG_OP_FILTER_SET_TYPE:
+		case PROXY_CFG_MSG_OP_FILTER_ADDRS_ADD:
+		case PROXY_CFG_MSG_OP_FILTER_ADDRS_REM:
+			rsp[0] = PROXY_CFG_MSG_OP_FILTER_STATUS;
+			rsp[1] = filter_type;
+			l_put_be16(num_filters, &rsp[2]);
+			rsp_len = 4;
+			break;
+
+		/*
+		 * MshPRT_v1.1, section 6.7:
+		 * Upon receiving a proxy configuration message with the Opcode
+		 * field set to a value that is Reserved for Future Use, the
+		 * Proxy Server shall ignore this message.
+		 */
+		default:
+			break;
+	}
+
+	if (rsp_len) {
+		uint8_t pkt[30];
+		uint8_t pkt_len;
+
+		net_seq = mesh_net_next_seq_num(net);
+		if (!mesh_crypto_packet_build(true, 0/*TTL*/, net_seq,
+					mesh_net_get_address(net)/*src*/,
+					UNASSIGNED_ADDRESS/*dst*/, rsp[0],
+					false, 0, false, false, 0, 0, 0,
+					msg + 1, rsp_len - 1, pkt, &pkt_len))
+			return;
+
+		if (!net_key_encrypt(net_key_id, iv_index, pkt, pkt_len)) {
+			l_error("Failed to encode packet");
+			return;
+		}
+
+		gatt_proxy_service_send(PROXY_MSG_TYPE_PROXY_CFG, pkt, pkt_len);
+	}
+}
diff --git a/mesh/proxy-cfg.h b/mesh/proxy-cfg.h
new file mode 100644
index 000000000000..658948ae7cbc
--- /dev/null
+++ b/mesh/proxy-cfg.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2015  ARRI Lighting. All rights reserved.
+ *
+ *
+ */
+
+#include <stdint.h>
+
+struct mesh_net;
+
+void proxy_cfg_msg_received(struct mesh_net *net, uint32_t net_key_id,
+					uint32_t iv_index,
+					const uint8_t *data, uint8_t size);
-- 
2.43.0

