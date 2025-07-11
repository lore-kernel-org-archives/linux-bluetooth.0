Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011029.outbound.protection.outlook.com [52.101.70.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6297A128395
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 22:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752271281; cv=fail; b=TnREt4TwxcI0Anes9qSbQcl17cZlq7qG5KmOEfl9XquX13LuGpH04i4wKDwi3CsIm1McOCuGZ916UBF3Q/itfp1f2a3gOn05CDeqRUZUakLtwtQkPnr+cejraGw84MIjKFyhQzoJIHqDnkHDQaFY13oA7YaIcz9wK5agxfhYHgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752271281; c=relaxed/simple;
	bh=g60n8EQ1MtBWsvC7AZuCoXUPc/KrbzNqdUmg1ahRehs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZlPzXPvJnyvxpPYgWz90d3kn0YOK0e2C47oMl1BmldCdxuo6pvAYVb1DLS9z6N16s3zo+H65H3/ebL5ltS8yqPlx9/vuQNb/RpSRKx+IYp80qKyv3Rlq51WQA0EM1+9lmQKwiVYs7949KP3DBaVqx6Wlp6Pk3KkYLtnDEhnQpig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=up2EwruZ; arc=fail smtp.client-ip=52.101.70.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="up2EwruZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQi2rJ0+axBtrQGHhtZuyutSsBJyqfuEGc0aUfcDog+wUOpD++4x7CAP+pLi0Lq9Sch4RYufAs9PKyL1cKH/uChTbhpBNlQdI8uAx3iiEURV9zvI3cNi3d5CJykzE2ZPZb7Yt107J56wHHRDSaXAHMvXR+9yK1WCcO8GkrTgoTfkBtJ8/x73iaivdIPMn/rDqs3lvmtRg+0BT+/y21qntYRauwJVKIABLFFTCs1n9tdHUpdsnUh+4P/chnIVjVnPIi3iaLWR3XvAqkkK+m6QEX0XKwVj0v/lmQkaEXE02I9gjZ89czxYYbEdxYAqJjPlxAfD02Nm/eXkaBgklw5FMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6SCXDNm5sBCXV5Sqh1gMzknEwR/SBt8Tyqucs31dmk=;
 b=pV6fd6RCWX6qlE2jnIHcj9MLMK79uXPqDZtiUMF3GoeiKtfzBU0NyOX8bBnR8Nzs17/FhuQkLB7SDa91z/j9wvbRc7V3/6tzMkoLc9cL4VTETBiG0gg54y57hX0q/qaRkyH1JxGODTsxknISa75nGcH6UKOBbrfdV/V58rPkeEKjEtPimC2oxbJfuBRc5uAGbvEXqnzfiYda54YVSIjsgRye7/Tq99l277C8EtWeGg1XQm9jAjagZcvFpPnazeIUmV2gp+GO1YH/yFd9mQZz3UhfJmGTP1IhEPNuQ7b8ZTbD5kKgS+BVtB02x8apBM5TUilco5vFTaRS/cw0r/44sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6SCXDNm5sBCXV5Sqh1gMzknEwR/SBt8Tyqucs31dmk=;
 b=up2EwruZz1xuU0Y0Ma0+OSAEaOdgynEsspVb3ABVAfJKazSPOQvCVTh3o4myJB7hmYgXzgnpKsZWeE7N9onNTHyyCxw3QIM4nHsyrBddVdGkDxdvSpBziX7hUQeQVYDxGJa8gapVLEkA/dHJzbQPT9nymZ3lD0DgwfsmyHtt0s0=
Received: from DUZPR01CA0082.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::10) by DU2PR03MB8123.eurprd03.prod.outlook.com
 (2603:10a6:10:2f2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 22:01:11 +0000
Received: from DU6PEPF0000A7E0.eurprd02.prod.outlook.com
 (2603:10a6:10:46a:cafe::90) by DUZPR01CA0082.outlook.office365.com
 (2603:10a6:10:46a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.26 via Frontend Transport; Fri,
 11 Jul 2025 22:01:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU6PEPF0000A7E0.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:01:11 +0000
Received: from N9W6SW14.arri.de (192.168.54.11) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Sat, 12 Jul
 2025 00:01:10 +0200
From: Christian Eggers <ceggers@arri.de>
To: Brian Gix <brian.gix@gmail.com>, Inga Stotland <inga.stotland@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
CC: <ceggers@arri.de>
Subject: [PATCH BlueZ v2 2/9] mesh: introduce MESH_AD_MAX_LEN and MESH_NET_MAX_PDU_LEN
Date: Fri, 11 Jul 2025 23:57:14 +0200
Message-ID: <20250711220035.10065-3-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E0:EE_|DU2PR03MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: fddfdcf1-36ab-43b6-920d-08ddc0c6726c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i6JVdvXNKuaHUuZbMHUbE1mnXU2SxzBB0oySJs881H02POPTlZ2LLSNemRu0?=
 =?us-ascii?Q?vDoS2me3ZOg2IpiBG+td3cUJamS85yJ9dX8asAA4VD4ONE7zk7wRewDfzgw5?=
 =?us-ascii?Q?pwetFgAOtaCGTo2CQo3pdHRW+QgBrQUYV2wJi2n72pietkFP833dMSvsoZ5l?=
 =?us-ascii?Q?/a+/raNIaoJJWzf2j/xnKjOybCyC1Nt+hNvqgv+SpDPAXa+0UQhals5SHtu5?=
 =?us-ascii?Q?P+2ERd0sMHyKbmL4z8I9q2JYx0kPfiWsi7qV6CY24spIUhxxA6GOY/EHI+0o?=
 =?us-ascii?Q?S0MVx8KAJ2GOyWBd2r/g4Qxn1We35X1DTiK4Kyca9e/Bw2yjmTSoXGHAZBGp?=
 =?us-ascii?Q?khJlfXinCCN9AAE3TX5gRTfXlD8jDUDx6TTSBsqFLdiLEGHx96i2eLTlURwE?=
 =?us-ascii?Q?gN61wfEyMsjN1rRR2b5sCr9lOxA4mKLdqagvcCGheHO1xq4aRPPI8sWk2U/J?=
 =?us-ascii?Q?sNbBt1aD0CjdbfjEZPirffNOzAa+3q+ByP01n4aQpgY/3UyZR3Uc8vVrmWrM?=
 =?us-ascii?Q?RcSTqUHP0vK9mWAh6NVwSNeiS4iR082/ivLfQsM4nXDSeGZR5uKvMqyxg3+f?=
 =?us-ascii?Q?HOEjeqTsxt0pf1YbERuA3qq75fdMULg0HKz3B/4d2d4WlfCZ+oVlheaRmail?=
 =?us-ascii?Q?0JIA/D/7e3XyFOvGZYoSboT7MD0qavb58hmlE+jQVoXFNLIPqV205ps15qF1?=
 =?us-ascii?Q?PjtA+Oqso6naRLBQ/vw9qVvnqTEu1OmJGLyqRVqIndZVgcEUFQqIRGntcs7Y?=
 =?us-ascii?Q?8Z0zUC69//Us56VI61e8PO5FCpV3SUeS/nRpgmMMdADryFInDYFWjNvc5O4m?=
 =?us-ascii?Q?zq1N/NDfmRwgjJXaDAuuTZRSiL743lqjpAR6fnCOOQUYzRR+UiH1cWIghBML?=
 =?us-ascii?Q?FJT6rs2s6ogGQhD1zUR0G+iYUOxjr9IGgo5/gviHf31vTt9cybpU2g6OHiSe?=
 =?us-ascii?Q?dG4x9Cjcan/3l5Jpwu3zQSmVKs6LvT/8GmskvWZaRApZC8u2WHeHSpYcuts7?=
 =?us-ascii?Q?nAbgTkzbcCeFqJBpUzGit0Yj9FtXWqli46ZhbpCV4pmDv2jGBER8bQDdcF4o?=
 =?us-ascii?Q?Upnj4vydturil4tgvnKD8kfP0vmr4xWafAGGN6wdYHvV4TKPx/59C+Agz78b?=
 =?us-ascii?Q?Jqu42jQetwWHaaJYGNe7p2KRmLi82K9PQhAq5SQKw30Q1gCJSrcfY5ROu5MS?=
 =?us-ascii?Q?+PVD7hTSRKrx9B/Rcvx5q4Lr1VTlkz/PC4+X++hQYsHGe51+5ZeIJtUJi3XJ?=
 =?us-ascii?Q?WUOWelxdUZ0iX5CIONVFgAvgduem6X7Fdyn6QC7pGZnJK65NofJ5/N89CqiE?=
 =?us-ascii?Q?rzmzq+KwNMZErvG3LVSIwRToqZkVVKSarg05mv9cRHFE+0ROcDmVKAMjDdjr?=
 =?us-ascii?Q?UQpTE95pBWvNHWig8dBWJABjvC/SaquDNZuShYP9wKolWTSAbeXlCMxTFmfH?=
 =?us-ascii?Q?zgHT/1GH9gBT/npaTu9bZKinL9vppmAjzFjMXnUkKh43Kj2kdvGqEfuyQBB6?=
 =?us-ascii?Q?NDDpmd4HU+4jA/W1onoUlffHQDN7ex+mbxfG?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:01:11.1540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fddfdcf1-36ab-43b6-920d-08ddc0c6726c
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E0.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR03MB8123

Use symbolic names rather than magic numbers. Remove unneeded extra
pointer in send_seg().
---
 mesh/mesh-defs.h       |  9 +++++++++
 mesh/mesh-io-generic.c |  3 ++-
 mesh/mesh-io-mgmt.c    |  3 ++-
 mesh/mesh-io-unit.c    |  4 +++-
 mesh/net-keys.c        |  6 ++++--
 mesh/net.c             | 17 +++++++++--------
 6 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/mesh/mesh-defs.h b/mesh/mesh-defs.h
index 25ce0126c708..a12acaf59453 100644
--- a/mesh/mesh-defs.h
+++ b/mesh/mesh-defs.h
@@ -12,6 +12,15 @@
 #define MESH_AD_TYPE_NETWORK	0x2A
 #define MESH_AD_TYPE_BEACON	0x2B
 
+/*
+ * MshPRT_v1.1, section 3.3.1 / Core_v5.3, section 2.3.1.3
+ * Maximum length of AdvData without 'Length' field (30)
+ */
+#define MESH_AD_MAX_LEN		(BT_AD_MAX_DATA_LEN - 1)
+
+/* Max size of a Network PDU, prior prepending AD type (29)*/
+#define MESH_NET_MAX_PDU_LEN	(MESH_AD_MAX_LEN - 1)
+
 #define FEATURE_RELAY	1
 #define FEATURE_PROXY	2
 #define FEATURE_FRIEND	4
diff --git a/mesh/mesh-io-generic.c b/mesh/mesh-io-generic.c
index 1ec4f379def0..0875a359bd78 100644
--- a/mesh/mesh-io-generic.c
+++ b/mesh/mesh-io-generic.c
@@ -19,6 +19,7 @@
 #include <ell/ell.h>
 
 #include "monitor/bt.h"
+#include "src/shared/ad.h"
 #include "src/shared/hci.h"
 #include "src/shared/mgmt.h"
 #include "lib/bluetooth.h"
@@ -52,7 +53,7 @@ struct tx_pkt {
 	struct mesh_io_send_info	info;
 	bool				delete;
 	uint8_t				len;
-	uint8_t				pkt[30];
+	uint8_t				pkt[MESH_AD_MAX_LEN];
 };
 
 struct tx_pattern {
diff --git a/mesh/mesh-io-mgmt.c b/mesh/mesh-io-mgmt.c
index 4ca7ff93c863..065067fc2821 100644
--- a/mesh/mesh-io-mgmt.c
+++ b/mesh/mesh-io-mgmt.c
@@ -23,6 +23,7 @@
 #include "lib/bluetooth.h"
 #include "lib/bluetooth.h"
 #include "lib/mgmt.h"
+#include "src/shared/ad.h"
 #include "src/shared/mgmt.h"
 
 #include "mesh/mesh-defs.h"
@@ -60,7 +61,7 @@ struct tx_pkt {
 	struct mesh_io_send_info	info;
 	bool				delete;
 	uint8_t				len;
-	uint8_t				pkt[30];
+	uint8_t				pkt[MESH_AD_MAX_LEN];
 };
 
 struct tx_pattern {
diff --git a/mesh/mesh-io-unit.c b/mesh/mesh-io-unit.c
index 936f5a9514c5..f9a5aaa3e210 100644
--- a/mesh/mesh-io-unit.c
+++ b/mesh/mesh-io-unit.c
@@ -22,6 +22,8 @@
 #include <time.h>
 #include <ell/ell.h>
 
+#include "src/shared/ad.h"
+
 #include "mesh/mesh-defs.h"
 #include "mesh/dbus.h"
 #include "mesh/mesh-io.h"
@@ -59,7 +61,7 @@ struct tx_pkt {
 	struct mesh_io_send_info	info;
 	bool				delete;
 	uint8_t				len;
-	uint8_t				pkt[30];
+	uint8_t				pkt[MESH_AD_MAX_LEN];
 };
 
 struct tx_pattern {
diff --git a/mesh/net-keys.c b/mesh/net-keys.c
index 22ab5b626a84..9b11bb7a1da2 100644
--- a/mesh/net-keys.c
+++ b/mesh/net-keys.c
@@ -16,6 +16,8 @@
 
 #include <ell/ell.h>
 
+#include "src/shared/ad.h"
+
 #include "mesh/mesh-defs.h"
 #include "mesh/util.h"
 #include "mesh/crypto.h"
@@ -74,8 +76,8 @@ static struct l_queue *keys;
 static uint32_t last_flooding_id;
 
 /* To avoid re-decrypting same packet for multiple nodes, cache and check */
-static uint8_t cache_pkt[29];
-static uint8_t cache_plain[29];
+static uint8_t cache_pkt[MESH_NET_MAX_PDU_LEN];
+static uint8_t cache_plain[MESH_NET_MAX_PDU_LEN];
 static size_t cache_len;
 static size_t cache_plainlen;
 static uint32_t cache_id;
diff --git a/mesh/net.c b/mesh/net.c
index d711f80c83d1..cf4f337616d5 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -19,6 +19,8 @@
 
 #include <ell/ell.h>
 
+#include "src/shared/ad.h"
+
 #include "mesh/mesh-defs.h"
 #include "mesh/util.h"
 #include "mesh/crypto.h"
@@ -203,7 +205,7 @@ struct oneshot_tx {
 	uint16_t interval;
 	uint8_t cnt;
 	uint8_t size;
-	uint8_t packet[30];
+	uint8_t packet[MESH_AD_MAX_LEN];
 };
 
 struct net_beacon_data {
@@ -2246,7 +2248,7 @@ static bool match_by_dst(const void *a, const void *b)
 
 static void send_relay_pkt(struct mesh_net *net, uint8_t *data, uint8_t size)
 {
-	uint8_t packet[30];
+	uint8_t packet[MESH_AD_MAX_LEN];
 	struct mesh_io *io = net->io;
 	struct mesh_io_send_info info = {
 		.type = MESH_IO_TIMING_TYPE_GENERAL,
@@ -3130,8 +3132,7 @@ static bool send_seg(struct mesh_net *net, uint8_t cnt, uint16_t interval,
 {
 	struct mesh_subnet *subnet;
 	uint8_t seg_len;
-	uint8_t gatt_data[30];
-	uint8_t *packet = gatt_data;
+	uint8_t packet[MESH_AD_MAX_LEN];
 	uint8_t packet_len;
 	uint8_t segN = SEG_MAX(msg->segmented, msg->len);
 	uint16_t seg_off = SEG_OFF(segO);
@@ -3193,7 +3194,7 @@ void mesh_net_send_seg(struct mesh_net *net, uint32_t net_key_id,
 			uint16_t src, uint16_t dst, uint32_t hdr,
 			const void *seg, uint16_t seg_len)
 {
-	uint8_t packet[30];
+	uint8_t packet[MESH_AD_MAX_LEN];
 	uint8_t packet_len;
 	bool segmented = !!((hdr >> SEG_HDR_SHIFT) & 0x1);
 	uint8_t key_aid = (hdr >> KEY_HDR_SHIFT) & KEY_ID_MASK;
@@ -3353,7 +3354,7 @@ void mesh_net_ack_send(struct mesh_net *net, uint32_t net_key_id,
 	uint32_t hdr;
 	uint8_t data[7];
 	uint8_t pkt_len;
-	uint8_t pkt[30];
+	uint8_t pkt[MESH_AD_MAX_LEN];
 
 	/*
 	 * MshPRFv1.0.1 section 3.4.5.2, Interface output filter:
@@ -3400,7 +3401,7 @@ void mesh_net_transport_send(struct mesh_net *net, uint32_t net_key_id,
 				uint16_t msg_len)
 {
 	uint8_t pkt_len;
-	uint8_t pkt[30];
+	uint8_t pkt[MESH_AD_MAX_LEN];
 	bool result = false;
 
 	if (!net->src_addr)
@@ -3416,7 +3417,7 @@ void mesh_net_transport_send(struct mesh_net *net, uint32_t net_key_id,
 		ttl = net->default_ttl;
 
 	/* Range check the Opcode and msg length*/
-	if (*msg & 0xc0 || (9 + msg_len + 8 > 29))
+	if (*msg & 0xc0 || (9 + msg_len + 8 > MESH_NET_MAX_PDU_LEN))
 		return;
 
 	/*
-- 
2.43.0

