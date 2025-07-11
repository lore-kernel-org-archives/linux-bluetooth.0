Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011017.outbound.protection.outlook.com [52.101.70.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4932AEF1
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 18:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752256833; cv=fail; b=OTZPliKFXMrnZwqikXx3uiNcK9ZGGUA7EbYDKD4Y/iKV78nwNNL/mFFXOURph7gaSqwQX4IB+qhMkyso9OgCf6Zonuie0vdIIB7boSKoWiczCeX5Gb7LHiok+/3SqTEk5xcLhzapp1n1yQCGXd5Zh9+dhdy/doGFQ/dKW+rPc5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752256833; c=relaxed/simple;
	bh=ePb9ZPrjLGMO1+bOrymq2hvIx6yUNXqCQwnQ67Nl+jU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BRjZiQ1kZI1JBfZsknAnjj7W5qioHFy21FwE+XAAv5xhLcKeYavrAMdDJONrDMf0C97njO98zqpn+IDOxM+8ce0NXuAy0Pb3XrnoIuhK+XqPgCnNxLVpFTCnO5Xf2TzocaweJLYrnBmZqFa7YFxOiRMzZr1XbtagPgIkZxykaCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=qY39FDjo; arc=fail smtp.client-ip=52.101.70.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="qY39FDjo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RRbkahHFcKiDckVkdfmXRBFlTApi4qEYx/TlUZgv37E4zMX7A3VEw0hd3M1Bsb4g+2/AWXG/HnUnpEtxbtL7Yzyim33BsYgsfR20Y7mGS4ICGhkL1mfQNb/GueRdVzMSI0xYEbGIrDpvVxTkJxMTaSlFCs+bVvHaOtPE4iNp5Xu/l/MYyEvlXVc62968IyyUnlcUuc9U48ex0qsP5zrYgiS2oqok0C3IMJN6f9Wal08JtzENyIPwnlOGel0h6g0c22nPt7bFiNWGlHK+QYuUkUtIZ/APqQK2QM9/RuViS176OmSCSyFpCEcSfejpyISaq0eENFjce0WbK8RSI61vRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JeFK/WZ8g6S+6e7mH/XmAyocwIJ3iZ9/5Za2Pt641R4=;
 b=R7B5U0J0IsKTaKSStvO1AUFqKLxWqAPllLAbgdYsnKuvO/730PT67/+dafofvP8kD1f3oaKGxDgm4U1HwDg1AjLPm6TZimf6tlzkjEk2T5L7WAsldmPGMB7EQuDwhkZmpFdtqHiBBc3L6rYKRNhC3mA8jNyjDebbGZzOeKgi8Zr+n4t5EfZ/EL0bzka0U8lC0kk/tNh7LFXpimC9lzk2/d299ey9S/mEe8lhErv/wNmfFC3tbSW23z3a8rzGjWg4AdnD4OIDRi/MomA76xX04NwOwGyprTViBnB3xgK3Tnmt9ky6fN+nUApHCj1gJ2O7N997E5UeYIH24SpX/Q/jfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JeFK/WZ8g6S+6e7mH/XmAyocwIJ3iZ9/5Za2Pt641R4=;
 b=qY39FDjot+SMDdalwVneDr5CPjWtPyNXJHAw+yCBRUI4pfVg97MzmQqbcSbnnQoADoV2HDi2IETH1l5tiXRBQVhe/jncJctwP+If5UziF/Twk5VAYvmj97eeHXNrwzFHfL59Z853xSeod5BJe5eyetve3SdjR02O9OFFCruAtEw=
Received: from PR1P264CA0089.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:345::16)
 by PAWPR03MB10042.eurprd03.prod.outlook.com (2603:10a6:102:35f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 18:00:23 +0000
Received: from AMS0EPF000001AA.eurprd05.prod.outlook.com
 (2603:10a6:102:345:cafe::2c) by PR1P264CA0089.outlook.office365.com
 (2603:10a6:102:345::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Fri,
 11 Jul 2025 18:00:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS0EPF000001AA.mail.protection.outlook.com (10.167.16.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 18:00:23 +0000
Received: from N9W6SW14.arri.de (192.168.54.13) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Fri, 11 Jul
 2025 20:00:23 +0200
From: Christian Eggers <ceggers@arri.de>
To: Brian Gix <brian.gix@gmail.com>, Inga Stotland <inga.stotland@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [RFC PATCH BlueZ v2 5/7] mesh: main.conf/cfgmod-server: allow to enable proxy support
Date: Fri, 11 Jul 2025 19:56:55 +0200
Message-ID: <20250711175842.28860-6-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711175842.28860-1-ceggers@arri.de>
References: <20250701144647.19572-2-ceggers@arri.de>
 <20250711175842.28860-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AA:EE_|PAWPR03MB10042:EE_
X-MS-Office365-Filtering-Correlation-Id: 610d17f6-abf5-43af-489e-08ddc0a4cf01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sKO4Mzkc1ARyyqp3lGy05TJiVDu2h7IsV/IPKK6hnIavjWRJ4moYzVb2l9Tv?=
 =?us-ascii?Q?Lrd5lEs4ZCb9z32Pe4rdPjWdcB008TeJHeUCp9huAy206W1dgcRJyY1V5Z1b?=
 =?us-ascii?Q?pSGrI4pMn5jfG7oSbOoK7toNa60Fm0atOMmZRkokqjvecgddYDRQpD9r1DsF?=
 =?us-ascii?Q?9afY9xtBfGOfiARg1/Pwmt6+Cghok4TrCeT/QCr/FO/7nC1Os7S6hZ2wVkoe?=
 =?us-ascii?Q?L64IkyjKNNceJG0rZ+uP592Qwb8DdaSdrlFQhlMzczxoPaWpmh75ZqwliqeQ?=
 =?us-ascii?Q?aIBdhobzIu1UGyfijqsJVkWjW+wiDNIFg+Uqf14ujB50eniwxhYhzOSi1+n9?=
 =?us-ascii?Q?uwp9xfx5vgrcwrTotVgXjFbbiiO0TW5XUrJgq+10SWHVSakRJFeEk0aBIvm5?=
 =?us-ascii?Q?17qeqNtZM5hfDzw23jm6qDUZVuf9Yk9M3kX6EZa0HE8t3kXtIfp9KtvYsje+?=
 =?us-ascii?Q?S3xNRzegaoFV3+9dNpQ02zueOoPNHxm48G2UDGH/NmhGrc5vpfoQ73qe/9g4?=
 =?us-ascii?Q?ze53ljlzZhddtj2tnB0YUc0VyDl3H1XmFi1rst6mID2IErW0SNcHDgNmYPGP?=
 =?us-ascii?Q?TaVJshY8ROS2tQBEiHooZ//m/+Tav1a+xYHEjJUN+oQkU/rcphQ3yoLYKQbI?=
 =?us-ascii?Q?h7y+VmKJ3pKrP8fkaCsiVZAxvKdakt1CBypdvgadvI/xc5Wr3ozkI1DcTs/d?=
 =?us-ascii?Q?S29Dk3CbQWBTGpWR/7gqgdFyfIHIGUcwlPU3rxYAkur35ryKlX6CcywHs2Nt?=
 =?us-ascii?Q?CqRVvBxyplaAEFlshnYmbzYLh2j6UNMYS/zTpbK+mnE9AW87AcXK46zHLUFC?=
 =?us-ascii?Q?lGdL6ERbzZr2BFIYUs9SNNuoDUdCz6kQev0xmKwlRcw1XClm1ihsjeQIJJab?=
 =?us-ascii?Q?kyZEip89ij53Bse9iBJTUhWvv13GHMf1X4nrPC59eBgYgeSPrMHMz0g8mp05?=
 =?us-ascii?Q?UKL3YzFlnGnJSpg/HsVpqaBMG21vF95IA9m7Pxg5OHuJ8yB5BEy+NptksKAO?=
 =?us-ascii?Q?Tr7MTE49nUZPQFt4II30bb9vVxSR5+HjjF4kiBPVs+XtWRNEUE/Zg9mPEA2z?=
 =?us-ascii?Q?3ezv1pUQC+ZwLkoxmO6ev7Yza3hg7eFQEIUxboTSMLTBRizDg/8sU0QU3QRL?=
 =?us-ascii?Q?vbTtfgB2eTrQ2zY8P2PWqwBctNTo8SFA0myO5RQBkQv479NTGoC19a1iyzU3?=
 =?us-ascii?Q?iOok0Q4dV4Ir4GwDci/oeeh3eU11T0IkJ4/KLB3Hq1S2uE5AV1ZgZFvs0zXk?=
 =?us-ascii?Q?Y47gSoM85p9xh1E5AltB1c1hu+Y9Q8JVbb6JjWHZcbP25L13h2sTKuxM8yuC?=
 =?us-ascii?Q?TR1yxgag0xvJNBjOuOgxEkweqHRB4R73Tdit/KvgehUvWavhvy/5ffFOyRIc?=
 =?us-ascii?Q?MiO98hocAlLpQr2l4wPKFB4oB0TU4euLX955TNO0f/7H70/qDVzETTWGK7wP?=
 =?us-ascii?Q?vbjbWwFpFxhJK7iQw3vK2jMhPWgqPvhBfZ9HE58jeihiRt3IpygRPA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 18:00:23.6181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 610d17f6-abf5-43af-489e-08ddc0a4cf01
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AA.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB10042

The proxy settings in the config file and in the configuration server
only affect the _relaying_ between GATT and ADV. Provisioning via
PB-GATT and connecting to the GATT proxy service is always possible
(MshPRT_v1.1, section 4.2.12).

The actual relaying of network messages and beacons is implemented in
the next patches.
---
 mesh/cfgmod-server.c |  9 +++++----
 mesh/mesh-main.conf  |  9 +++++++++
 mesh/mesh.c          | 14 +++++++++++++-
 mesh/mesh.h          |  1 +
 mesh/node.c          |  3 ++-
 5 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index f9f80aff7920..5c0015033d00 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -405,7 +405,8 @@ static uint16_t cfg_relay_msg(struct mesh_node *node, const uint8_t *pkt,
 	if (opcode == OP_CONFIG_RELAY_SET) {
 		count = (pkt[1] & 0x7) + 1;
 		interval = ((pkt[1] >> 3) + 1) * 10;
-		node_relay_mode_set(node, !!pkt[0], count, interval);
+		node_relay_mode_set(node, pkt[0] == MESH_MODE_ENABLED, count,
+								interval);
 	}
 
 	n = mesh_model_opcode_set(OP_CONFIG_RELAY_STATUS, msg);
@@ -879,7 +880,7 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 		break;
 
 	case OP_CONFIG_RELAY_SET:
-		if (size != 2 || pkt[0] > 0x01)
+		if (size != 2 || pkt[0] > MESH_MODE_ENABLED)
 			return true;
 		/* Fall Through */
 
@@ -903,10 +904,10 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 		break;
 
 	case OP_CONFIG_PROXY_SET:
-		if (size != 1 || pkt[0] > 0x01)
+		if (size != 1 || pkt[0] > MESH_MODE_ENABLED)
 			return true;
 
-		node_proxy_mode_set(node, !!pkt[0]);
+		node_proxy_mode_set(node, pkt[0] == MESH_MODE_ENABLED);
 		/* Fall Through */
 
 	case OP_CONFIG_PROXY_GET:
diff --git a/mesh/mesh-main.conf b/mesh/mesh-main.conf
index aca9e6fa5a36..d917218fcf1a 100644
--- a/mesh/mesh-main.conf
+++ b/mesh/mesh-main.conf
@@ -16,6 +16,15 @@
 # Defaults to true.
 #Relay = true
 
+# Default setting for supporting proxy. The setting applies
+# to all local nodes.
+# If the value is true, then a configuration client can either enable or disable
+# the proxy feature per local node.
+# If the value is false, then the proxy feature cannot be configured for
+# any local node.
+# Defaults to true.
+#Proxy = true
+
 # Default setting for supporting Friendship. The setting applies
 # to all local nodes.
 # If the value is true, then a configuration client can either enable or disable
diff --git a/mesh/mesh.c b/mesh/mesh.c
index db77602d37da..5dbec2b319d0 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -85,7 +85,7 @@ static struct bt_mesh mesh = {
 	.friend_support = true,
 	.relay_support = true,
 	.lpn_support = false,
-	.proxy_support = false,
+	.proxy_support = true,
 	.crpl = DEFAULT_CRPL,
 	.friend_queue_sz = DEFAULT_FRIEND_QUEUE_SZ,
 	.initialized = false
@@ -192,6 +192,11 @@ bool mesh_relay_supported(void)
 	return mesh.relay_support;
 }
 
+bool mesh_proxy_supported(void)
+{
+	return mesh.proxy_support;
+}
+
 bool mesh_friendship_supported(void)
 {
 	return mesh.friend_support;
@@ -231,6 +236,13 @@ static void parse_settings(const char *mesh_conf_fname)
 		l_free(str);
 	}
 
+	str = l_settings_get_string(settings, "General", "Proxy");
+	if (str) {
+		if (!strcasecmp(str, "false"))
+			mesh.proxy_support = false;
+		l_free(str);
+	}
+
 	str = l_settings_get_string(settings, "General", "Friendship");
 	if (str) {
 		if (!strcasecmp(str, "false"))
diff --git a/mesh/mesh.h b/mesh/mesh.h
index c30a8d1f08da..e293d4ba1613 100644
--- a/mesh/mesh.h
+++ b/mesh/mesh.h
@@ -40,6 +40,7 @@ const char *mesh_prov_status_str(uint8_t status);
 const char *mesh_get_storage_dir(void);
 bool mesh_beacon_enabled(void);
 bool mesh_relay_supported(void);
+bool mesh_proxy_supported(void);
 bool mesh_friendship_supported(void);
 uint16_t mesh_get_crpl(void);
 uint8_t mesh_get_friend_queue_size(void);
diff --git a/mesh/node.c b/mesh/node.c
index 7f20e97ea230..18aad67bf8d0 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -209,7 +209,8 @@ uint8_t *node_uuid_get(struct mesh_node *node)
 static void set_defaults(struct mesh_node *node)
 {
 	node->lpn = MESH_MODE_UNSUPPORTED;
-	node->proxy = MESH_MODE_UNSUPPORTED;
+	node->proxy = (mesh_proxy_supported()) ? MESH_MODE_DISABLED :
+							MESH_MODE_UNSUPPORTED;
 	node->mpb = MESH_MODE_DISABLED;
 	node->mpb_period = NET_MPB_REFRESH_DEFAULT;
 	node->friend = (mesh_friendship_supported()) ? MESH_MODE_DISABLED :
-- 
2.43.0

