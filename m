Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010052.outbound.protection.outlook.com [52.101.69.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D922DCF54
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 13:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751979620; cv=fail; b=AfSIjRUc8Er/xDVGby0FoEbfF0k3yOWxkYR5Q0mNcRvAGAX0kTrRWaSiYWn4a0lCbX3nxteQxFYfZFMDF5CN/OtNyghPPKZ+jbQMqLO/LFnRhMkxa3ILp0Pi4j68BccxH8GfWE9RxBvF8TVVbqlzq5aOoZ+tZuS8N+FxX4bFALQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751979620; c=relaxed/simple;
	bh=qLmqNNbnnTTD6vJDAO/ICB8ch3M+4eWvW00Xe/qh+3Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AIt2ouoHMeZ2B9hzQm3fEP4LhH0rg333+b7+mocwckVEb8HbUK8E0SvwIuYxPNDuM6/bbzkvp0BIJ3RlUHT600RGHCW9jXiCPMMDLz0r6iAGs2wAcR/Wb13tqfxfEV/MvDO9g9fi3RLVBPmZlxg62szMyB2zLVyOBZrzK8fUL7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=JjIpdgJD; arc=fail smtp.client-ip=52.101.69.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="JjIpdgJD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxSX4F+rVD/zlxhMTgjxcEqMsoZaCfWgU0C4FPJW9sThELTQTpRzQJUG4LgCYv0WOAikJfKlGYBKYf4eHaWz8fjorAOsy0gzAFrcQAvYXhU3M2z50yl5u8KzzKEM8m1HppZBu01XW2R7O+WsI7LARH7FG4N4a3gF5LdSktg5nIV8vyh8pKsAzSW90u51/o1ZYGexMkORO7vY4oByp7kJmMGv+wgNwPJG7iCMgtBPc9saq9k32DkqGh5XqPT4TvK4jPRoAqPGNydOcT3ECQzMEa44NhovK8zYP+PaNedorN9SMyJpBsQ7542+SE+SVe2Cw3vXrTq3tn/4cM1UN0k3fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSsz55cvzhx7GFrlXLW23CGOUcAQ0gmMfYxxIBnCO2s=;
 b=xXyT5xf/wZmtbLRPMmx7eAOFXSP+wODendeexF3JfUs/R4C/5uqiDmYQk0lh5wudXYnmnak+3rOnL4ZCWtv0t+cFN6ce0r+1fCrsAUb6HibzOPG9osQvFj5j3BWRQ3/vZ6fOFld4dXUfW+FMGfB/++3Ri9+s0+mMPMVkx7ca+3od1YmXlKDoiIlKBZIWTOHgIuJgFpmgigh0YEwGceYc0ldifrIIHHYJ8PJaU88AJT41Y4D5szi9UmFRNXqzGUtZSsQ74NpS92AngXLtQwwAWzvhMyb/7HAyEDSUzNQ1q9E6F86Q2yQhZp//nIx656BEXFDmQ0ZgowEjqU78ZY05SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSsz55cvzhx7GFrlXLW23CGOUcAQ0gmMfYxxIBnCO2s=;
 b=JjIpdgJDTZDU1D9cOaaDbuvmv4o3iPvYJ3MtJwjUbkYvTpSawhHrSP57Y/wCi3G3n2QY6fwo9DLRLdJ08TtNxd3oygWvuE7vkhzKWkaIw9z6wLgHKiF7TrZHMBqqeukPuEaRG99xgrs3jXIgJYLCGcalChBu2SYYdIAeqSfoNpg=
Received: from AS4P190CA0023.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::9)
 by AS8PR03MB8395.eurprd03.prod.outlook.com (2603:10a6:20b:527::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 13:00:11 +0000
Received: from AM4PEPF00027A61.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::57) by AS4P190CA0023.outlook.office365.com
 (2603:10a6:20b:5d0::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.20 via Frontend Transport; Tue,
 8 Jul 2025 13:00:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM4PEPF00027A61.mail.protection.outlook.com (10.167.16.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 13:00:09 +0000
Received: from N9W6SW14.arri.de (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Tue, 8 Jul
 2025 15:00:09 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 02/15] mesh: crypto: remove unused function parameter
Date: Tue, 8 Jul 2025 14:59:34 +0200
Message-ID: <20250708125947.11988-2-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A61:EE_|AS8PR03MB8395:EE_
X-MS-Office365-Filtering-Correlation-Id: f6c3e084-12fb-42bc-63ce-08ddbe1f5e83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hR1QpKyof7IXUP0cDtqo2MPgAX+3H8sRju3RahOx9oGMYM95p/AM175ORjk+?=
 =?us-ascii?Q?kvxeXKfO/8ys+nVuj55Mc9r7tew8SqrsuH4WyyyJcPCoGmfGIFmWsGoOkoa/?=
 =?us-ascii?Q?mkD+VnVulzMlhS61TqUPTeNBtmA1PHX7YP6vZpMv00zG7eN1Tr3vqT+HhbWA?=
 =?us-ascii?Q?KUGqgJo2tkcnrcvn78/UDFBCRo3Dx6h3Vpfqh+IutulHLm6HbgCZZlUnd5Bj?=
 =?us-ascii?Q?LjoqFtcl/N0p6XBICWU/Nxdiixo4WXx6bKH9ZQTO6KgsESaLO6xdJoCoOGBt?=
 =?us-ascii?Q?2Wb1V7qavwQNzzA6Jy43fqLz1MeJ7l5CU96Gg9utd971I/WgTIWxmUZWbkw8?=
 =?us-ascii?Q?0ExazkdQhlxeY0z7gY5Nl5gqVp5sO6Wyt7QZVnkScbfGf0iNRWe8+fL2t/t6?=
 =?us-ascii?Q?x58wxp+j5Fh7dI/EJSHWOlDTEj+Sx4qCUsLP70ssnpPcTZXofIRNRZfqQsMx?=
 =?us-ascii?Q?lb89cQ9BB/3m+GuP2lwt1NYehNs/jcBG8UmX8oDiywS5NbQv4w/AzI7cCt+P?=
 =?us-ascii?Q?lZfAFywbHg/WtS1m6PbiuUp7Tdc/4/Gyup2vsNzB5Ficj5Yf8p5B+JpCpuqh?=
 =?us-ascii?Q?YwPGa2znoR+i/gIO0WvRP/t/x0KCSmK8ddZ24ZYoWw/IYMLhX4Pm6eE8chVx?=
 =?us-ascii?Q?QkBytNmGBWvXUaZC9xNhVOIze9tU07JKGN7UOU4xL4eDFsnFilo6L8+ndHk0?=
 =?us-ascii?Q?hhth+upsPnow597kmuqcwgyGov65es5Bxf5dKYTZ9I3lgAAyc0Ss3wX8KMBy?=
 =?us-ascii?Q?qVek5uO3YtyB8znUQ5vhRh8WOOh9i5pdOtR+YPso3wwn5kEcChE3kljaXgZE?=
 =?us-ascii?Q?n4lUOW3mRB1BT0r3r1WQAX348IVtmXc/RO5BBiaoz96dtQULeLMLji477Gcp?=
 =?us-ascii?Q?ja4l5p5XN1MSoDgeDPhCVt4iot7AQyTG3+tFp+wllW/cNBz+nTiSnaQ4+eHn?=
 =?us-ascii?Q?j+IJffPIX/0UtDbqHV+68mp+J/aaEVXGzIhO64CWNhd5JR/rqgUA8rrVwLXl?=
 =?us-ascii?Q?V530gtNxurQVUnmB/0uM3Rs6+uhtep/XzfMUeXGOwA/vsePO3280Y9fsxhKQ?=
 =?us-ascii?Q?bCTuTJE0ifE4ntkX0Gj/TQGVCKKrUANcEH/sz6OTVrt8nm30sSOjk81hV2qb?=
 =?us-ascii?Q?CJPVXBk4Qe4X73vEmI3hjjNgI5XzRFAHI4y7dt4xyPNURZCNmXo+AKt5ofTO?=
 =?us-ascii?Q?D+tyVTA8rTi1KMVoBYYle9HpEOmPkXTuLlt3VxTvEq4rjk6RszLXcnyRL7Ag?=
 =?us-ascii?Q?ZySn8UqXwpBzsOeRfYn775xAxIxnyXVu9wDgoqZg1vXacLbWbnxxQV7Bjk7i?=
 =?us-ascii?Q?JWatK2J2X+UxmluP45RobdOXuSH4ZI5bD2GUFG4puTO+LQpZnvXom00tJmIi?=
 =?us-ascii?Q?x7NouTbuyMPzyfztzJEQ2SEZC7ITEzMIY7mojeC+piKP5JJCKmUrQzeM/zoX?=
 =?us-ascii?Q?dR2oOf8wVEwxQuvH65Bpm4LaSxhZUgU1GppQkxON3kJGHBuzj0ZZssV2dHZm?=
 =?us-ascii?Q?4u9VBRLrH9bOu+R39MSkneDYqKoP+Xn+fV+F?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 13:00:09.4970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c3e084-12fb-42bc-63ce-08ddbe1f5e83
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A61.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8395

The 'relay' parameter isn't used by mesh_crypto_packet_build().
---
 mesh/crypto.c           |  2 +-
 mesh/crypto.h           |  2 +-
 mesh/net.c              | 10 +++++-----
 unit/test-mesh-crypto.c | 15 +++++----------
 4 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/mesh/crypto.c b/mesh/crypto.c
index ab44baee3427..136e6953578f 100644
--- a/mesh/crypto.c
+++ b/mesh/crypto.c
@@ -527,7 +527,7 @@ bool mesh_crypto_packet_build(bool ctl, uint8_t ttl,
 				uint16_t src, uint16_t dst,
 				uint8_t opcode,
 				bool segmented, uint8_t key_aid,
-				bool szmic, bool relay, uint16_t seqZero,
+				bool szmic, uint16_t seqZero,
 				uint8_t segO, uint8_t segN,
 				const uint8_t *payload, uint8_t payload_len,
 				uint8_t *packet, uint8_t *packet_len)
diff --git a/mesh/crypto.h b/mesh/crypto.h
index 3d85785f174c..5e4d1d229c19 100644
--- a/mesh/crypto.h
+++ b/mesh/crypto.h
@@ -63,7 +63,7 @@ bool mesh_crypto_packet_build(bool ctl, uint8_t ttl,
 				uint16_t src, uint16_t dst,
 				uint8_t opcode,
 				bool segmented, uint8_t key_aid,
-				bool szmic, bool relay, uint16_t seqZero,
+				bool szmic, uint16_t seqZero,
 				uint8_t segO, uint8_t segN,
 				const uint8_t *payload, uint8_t payload_len,
 				uint8_t *packet, uint8_t *packet_len);
diff --git a/mesh/net.c b/mesh/net.c
index a49df531c933..cbdfd9d299d5 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -3168,7 +3168,7 @@ static bool send_seg(struct mesh_net *net, uint8_t cnt, uint16_t interval,
 	/* TODO: Are we RXing on an LPN's behalf? Then set RLY bit */
 	if (!mesh_crypto_packet_build(false, msg->ttl, seq_num, msg->src,
 					msg->remote, 0, msg->segmented,
-					msg->key_aid, msg->szmic, false,
+					msg->key_aid, msg->szmic,
 					msg->seqZero, segO, segN,
 					msg->buf + seg_off, seg_len,
 					packet + 1, &packet_len)) {
@@ -3224,7 +3224,7 @@ void mesh_net_send_seg(struct mesh_net *net, uint32_t net_key_id,
 	l_debug("segO: %d", segO);
 
 	if (!mesh_crypto_packet_build(false, ttl, seq, src, dst, 0,
-					segmented, key_aid, szmic, false,
+					segmented, key_aid, szmic,
 					seqZero, segO, segN, seg, seg_len,
 					packet + 1, &packet_len)) {
 		l_error("Failed to build packet");
@@ -3379,7 +3379,7 @@ void mesh_net_ack_send(struct mesh_net *net, uint32_t net_key_id,
 	/* Not Segmented, no Key ID associated, no segO or segN */
 	if (!mesh_crypto_packet_build(true, ttl, seq, src, dst,
 					NET_OP_SEG_ACKNOWLEDGE, false, 0, false,
-					rly, seqZero, 0, 0, data + 1, 6,
+					seqZero, 0, 0, data + 1, 6,
 					pkt + 1, &pkt_len))
 		return;
 
@@ -3465,8 +3465,8 @@ void mesh_net_transport_send(struct mesh_net *net, uint32_t net_key_id,
 	}
 
 	if (!mesh_crypto_packet_build(true, ttl, seq, src, dst, msg[0],
-				false, 0, false, false, 0, 0, 0, msg + 1,
-				msg_len - 1, pkt + 1, &pkt_len))
+				false, 0, false, 0, 0, 0, msg + 1, msg_len - 1,
+				pkt + 1, &pkt_len))
 		return;
 
 	if (!net_key_encrypt(net_key_id, iv_index, pkt + 1, pkt_len)) {
diff --git a/unit/test-mesh-crypto.c b/unit/test-mesh-crypto.c
index 39632d9734f2..81f0724fe540 100644
--- a/unit/test-mesh-crypto.c
+++ b/unit/test-mesh-crypto.c
@@ -846,8 +846,7 @@ static void check_encrypt_segment(const struct mesh_crypto_test *keys,
 				keys->net_src, keys->net_dst,
 				keys->opcode,
 				keys->segmented, key_aid,
-				keys->szmic, keys->relay, keys->seqZero,
-				seg, seg_max,
+				keys->szmic, keys->seqZero, seg, seg_max,
 				enc_msg, len,
 				packet, &packet_len);
 	} else {
@@ -856,8 +855,7 @@ static void check_encrypt_segment(const struct mesh_crypto_test *keys,
 				keys->net_src, keys->net_dst,
 				keys->opcode,
 				keys->segmented, key_aid,
-				keys->szmic, keys->relay, keys->seqZero,
-				seg, seg_max,
+				keys->szmic, keys->seqZero, seg, seg_max,
 				enc_msg, len,
 				packet, &packet_len);
 	}
@@ -1163,8 +1161,7 @@ static void check_encrypt(const struct mesh_crypto_test *keys)
 					keys->net_src, keys->net_dst,
 					keys->opcode,
 					keys->segmented, key_aid,
-					keys->szmic, keys->relay, keys->seqZero,
-					i, seg_max,
+					keys->szmic, keys->seqZero, i, seg_max,
 					enc_msg + 1, seg_len,
 					packet, &packet_len);
 		} else {
@@ -1174,8 +1171,7 @@ static void check_encrypt(const struct mesh_crypto_test *keys)
 					keys->net_src, keys->net_dst,
 					keys->opcode,
 					keys->segmented, key_aid,
-					keys->szmic, keys->relay, seqZero,
-					i, seg_max,
+					keys->szmic, seqZero, i, seg_max,
 					enc_msg + (i * 12), seg_len,
 					packet, &packet_len);
 		}
@@ -1732,8 +1728,7 @@ static void check_decrypt(const struct mesh_crypto_test *keys)
 				keys->net_dst, net_op,
 				keys->segmented,
 				keys->key_aid | (keys->akf ? KEY_ID_AKF : 0),
-				keys->szmic, keys->relay, seqZero,
-				i, seg_max,
+				keys->szmic, seqZero, i, seg_max,
 				payload + hdr_len, payload_len - hdr_len,
 				packet, &pkt_len);
 		verify_data("TransportData", 9, keys->trans_pkt[i], packet + 9,
-- 
2.43.0

