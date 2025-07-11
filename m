Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011035.outbound.protection.outlook.com [40.107.130.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3C02EA143
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 17:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255672; cv=fail; b=vAtyY0ihdtSRA4BFcIUJFgjML0I7et4d5p12A0dyIuAp9eHeRw+KtoyMgu7GAEo4GeAuOMIAeuDnKcr21rAcpj+NnaBUOLgiFSPXve5W4OY7wUq9fu/RRcAUmY9mat/NBHVpZU7X2Vzbhi+La7FQyZEckcsgjBpoGf1kJdJJoTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255672; c=relaxed/simple;
	bh=g60n8EQ1MtBWsvC7AZuCoXUPc/KrbzNqdUmg1ahRehs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZceqjzVVTdBlZaKuPdV4RweUd/dl+oqqlzUd6WicLlK2PL6Vk+mglUjGT5jsu7lmQBqWmwGWlIztws350voY5Fe9+cN/akaxma3PArm+GEBdgGshqaQLXYfOOfOeIokEvaF7E9RSCw4/mS+7bxGW/kM/dnbwJddXgRaIC6hA2io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=Zm5QDbUf; arc=fail smtp.client-ip=40.107.130.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="Zm5QDbUf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8xpxkp6AD3BlTO3Kcr/tBjmQ6MHkGsloXLaCVxlteMCTqLRHh4fiNcDTld1pZBKGL7VsyadR6Qup18cb7i5+xo0twop+rHewgbxy79qxaLUuNIt/oRdrnHoQs4pviWod0XGgVJ3P8FCQV4mYwz2kTnfqb/MZufDajkpesZBGrrHbSQCQV3DcGx+njM/Vsz8Y1BTOuA47CYbh95MsNOuowqRhe/ox9tbtGP0gLDjV/fANgGHmFtLUi5b6+B3FRTo+jJ0s5VSrlpx19yA5alsOqg25MlW+O4UQacWvVvz4gF8J90g2GAkLG3Z6XyZs57xZMpTS6fw+GZEuJ3Q9FBbCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6SCXDNm5sBCXV5Sqh1gMzknEwR/SBt8Tyqucs31dmk=;
 b=EIXIfi+FvTh7DTE6dk6PxS4UQdb7+eAmC/QkPgIa2u7slRkGfgcgu/XwBO1pUaFSroAvzemRUOcNJHzxN2/sbYfu7OARUqHrT6++HAYalmb5y8nG/OK0iGWIQjnZQSBnteg6JhXpyC/8Rp+NAcmv2nwoRPCDuN2Fi/rusagNfgb64LXjkOWUlc5Aw5+aDKDbekclv+TNaYj2GSS8k0Zksrcz7xe6pzYAAhip0GO7qmDuJJV8wSaHNlVd4o6t7Q6ztZLjxe9mMnRxdv0U/b8piqOAv2KnDTMOSJc3OS3ObYpPnwaEAI2YPDOkpa5Z/SCewvAFJSoLJVGGNnaLOhjLXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6SCXDNm5sBCXV5Sqh1gMzknEwR/SBt8Tyqucs31dmk=;
 b=Zm5QDbUfRwSDud1GC+QhBOjnYqPhl3K8Z+Bxukusuw0YCB2DmvaO18x/BW8Se/HhreVJ+EkHaYGakljSlnjbHGmJImIwGLPADnKYpCeae48ArRC3Ou/6UYyC9l2b3aMWVeUcLqgp5rk+YNwAxd2XGAPlY6Q4dWIcMfXIyCmfEPM=
Received: from DB8P191CA0023.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::33)
 by PA4PR03MB7215.eurprd03.prod.outlook.com (2603:10a6:102:10b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 17:41:05 +0000
Received: from DU6PEPF00009526.eurprd02.prod.outlook.com
 (2603:10a6:10:130:cafe::46) by DB8P191CA0023.outlook.office365.com
 (2603:10a6:10:130::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Fri,
 11 Jul 2025 17:41:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU6PEPF00009526.mail.protection.outlook.com (10.167.8.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 17:41:05 +0000
Received: from N9W6SW14.arri.de (192.168.54.13) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Fri, 11 Jul
 2025 19:41:04 +0200
From: Christian Eggers <ceggers@arri.de>
To: Brian Gix <brian.gix@gmail.com>, Inga Stotland <inga.stotland@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 2/9] mesh: introduce MESH_AD_MAX_LEN and MESH_NET_MAX_PDU_LEN
Date: Fri, 11 Jul 2025 19:39:18 +0200
Message-ID: <20250711173958.25689-3-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF00009526:EE_|PA4PR03MB7215:EE_
X-MS-Office365-Filtering-Correlation-Id: 58c5ddc8-9a85-4eca-7aee-08ddc0a21c9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jdjolJe60DJxwtzCSXunmXhzidvzD9hv4fuilTUcKVIjUE8cipyMYWwZehok?=
 =?us-ascii?Q?haJN6bQQS5ghCY9ECnM86efdIq/MLKLqn6q2HlIvt+tG78Ext3MA3KY+N1yq?=
 =?us-ascii?Q?LdLhWo17DvZufFxavXK21mqhFcVktQLnMwu6OOAxmBah38Y391l+/E//t2hJ?=
 =?us-ascii?Q?gzVNLmiHk89jdnOE0YpJIo61eQWS2t+K4ZqnZ4BErNFWKiNjSUBnum5qhkGB?=
 =?us-ascii?Q?VRPDipB/x0MeLRbpF87UC79IQcDL4V9abtpQ0V+GXA3rGBAGWK/yvfJTvG/Q?=
 =?us-ascii?Q?yi856UxD52LFfb5pv6j7e8bFNenQZLBZ/JtPDWQi3FIJ6KRDZN4JA2Y3pTUH?=
 =?us-ascii?Q?xqBH1hKwPFgiw+ewri6zkA/Nt8fdDWz3u8n7fE7bRf4f6zppPdJwdGwjhBgX?=
 =?us-ascii?Q?fq+8rFNaJtwQ81PMLWL4BW7wqwNwQjPgO4P47OJDb6IwgWE+RqcKKchKyR44?=
 =?us-ascii?Q?pdGWUNobY+uIczdUohgE1TpLuUtjc8Dd+7cwaOI+cjJzX5AfHl3gEQVktLJ5?=
 =?us-ascii?Q?Mx0qombZQj3nJDivzG0Pd78fVu+VmCaR1UJG/yAOOQVDQXC1B7kIouuYuKmT?=
 =?us-ascii?Q?YAjQVChCnnLlbkPMvhvDegCQoEOfx+YA3psTs5gSDDkS082j1SOY8RWKLPxw?=
 =?us-ascii?Q?Lvv8xlk48N/ed/56gEYjRL+yNHPcYI8U4mwNytIQJ/l8yT3hkYNuitzcj0ua?=
 =?us-ascii?Q?Ww+tyBipyprK+KTMx7VhF32NU6D+FA4mPuuQwyKiJC0avW8A2Q7n7ASN5EZ2?=
 =?us-ascii?Q?R02ypL2td5ck0R32+NlT87BzL2Ml4hw6id+0JYV+tzyAguhrouHI0XAXqk3f?=
 =?us-ascii?Q?LWxG7WkVbCNb/lZaMLyYyD6aHfbXgopQh3hpNlAxs/L8YlnRv4oO5B7oHloV?=
 =?us-ascii?Q?QJJ64NRsXJ3tJ5ELb+MbvDJrGzkVzyXLXWim+6Ei68DA3JNA7B3eixLkg1bO?=
 =?us-ascii?Q?UpMz7c/pJJFTuKM6bGW8QJwbOx9q4GJmie5Alf5N1h+YZPOhSvS4GK5fyytx?=
 =?us-ascii?Q?QYoYSwpll5IDH+x5dhAXx1OQLe6PdHBrj+9dZTAMAybdTPbJhv63K/ktJQtB?=
 =?us-ascii?Q?aJjed0hCHWq7SJNBve/47qG/PnmCtKEQFFlJRWi/T2lOGuQJ5a+K/5kP6xOi?=
 =?us-ascii?Q?7NMeqmdbe1uTbSa6CZQi/NJo8SFbRNg5g72Xq+juW4yGm9PK/6cFzBMTy2XU?=
 =?us-ascii?Q?NBRXyHfDcHosQGUr+PvWMQOE96wK+XC3mPq3oByYqtQ86KJfffLBm66XtZhB?=
 =?us-ascii?Q?Pucl33yCHTK23g/EeKPwoyjGaz9hjUbvaCYCLuGgAZvHKvS/vBucD1S0ExTB?=
 =?us-ascii?Q?zE9VEB8MON3AfKWjDYDRrLlHrIePsCtORIX2bjO+sdy3udfxTV22lilozfvg?=
 =?us-ascii?Q?mnRWJ4bTAEPlaptWHfAs1P9xSYANu1L/ux4BNe9CPdIyFiH2GzR9KU/Mr+kN?=
 =?us-ascii?Q?9bFmtg+mrYYm0Ev63l9e/NY8dAZdrJJQN7sO0hIGJYMLj26bAWj/h/qTZKEM?=
 =?us-ascii?Q?RjKqXb0cEq/XUKWzyB7xcEZTjU2JhUwb3HPP?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 17:41:05.2866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c5ddc8-9a85-4eca-7aee-08ddc0a21c9a
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009526.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB7215

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

