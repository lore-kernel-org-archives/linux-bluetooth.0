Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010044.outbound.protection.outlook.com [52.101.84.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6F02F5E
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255734; cv=fail; b=F28s4WUnZHK+VUZbnbW6339jFEpjSeZe3JJ6CJLclLEP13LYuD7bfTeP9TLXNGMTh96Bbitw+l7+lOK2p3cbUeLbGjZBEeoFhAttOWfxdPlNU9hiK7X7EdxTzY6zbmuBhusFuronzHnnol/ra/u6o39Y0RwmzGpEpFhi7Bz6uk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255734; c=relaxed/simple;
	bh=Gy8XuyEEOCIT2p0LbzhWF/2l5LQ9jASAVlmkp3LgfFc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D4JdmlV1fiUNle2zhwNdO74dwgMDpOQZU1RReXu4JuwLQZ6HUld3CVItDi0BBC5rh3FrvG5j3FEXVFclhVJdDmBhG3RBvKefZ56nxOGsRA8DrNeVLa04iwYALk4nU2dpNXdxGVsgXjbAo3ZQwjEjUGC4cSSMBFfQyx3ewgxKvVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=UKYQa7MP; arc=fail smtp.client-ip=52.101.84.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="UKYQa7MP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f96g2NdVgUqu5tX333OSingIbwXM1zyYh5nJi4A0DaeP9G2FiDpjOEdAKXLUVmbmkJYQnrTJMThFxEZeOBHfShg+pohZuYHe9veNvLfnLtFkV3yQpYAoJb8FrZFKlhl/z2Tqy9rbVi2nguh0WljL6jkOWqhqcvP9oNjyaANhblRhvFI4/DmP7sz4VE2pDALVZumBX1ZgFbqBbWU0e7VqQ55KLRfRmLIPfHndhJ5zrWebUYuBa5d9K5vl1cIrOdjZIaj385iG4WpoSm6MPKeAg1G+6Y+tqabigctlHtnThSUfIIcbJ+TXFzboUBAuADRNkBJf0j8zy982z9b/ADvSYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Vg4O2xlTZFcZwYoXlQ9TK1/E1cZyJB5NYo3xWKlhSk=;
 b=C6ni4A47NcIjNz1OYUpifGPteer6YLbAWQgGUmQZcgXCMr2bM4WUrVVOr8gi5/P/ajsGZF132N84EKcsE30+WXT9uqI3xbIWC/oqF8y33MfR7Vck1cZKLURWMaCH3AwDH3to6F5Xu1Ucs76660b2ieW/TEssdRuA1rN6cTD0DCaUi09c1br+I5VBkozKLt1F3WQR10zl/oqHpJuKKlYH1O3U1Q1HmQvg6MUpQyXZoUT6y0DPx68rOQ3N+rJxcbvHmrLaRqeVZBeqX8v5nY7rvAQi112hWho+M4gjlyZ3qDd9JZJTMEQfHVV+PtQN/aoyXMii4sKLRTsWSLwi84NFHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Vg4O2xlTZFcZwYoXlQ9TK1/E1cZyJB5NYo3xWKlhSk=;
 b=UKYQa7MP/5g3jaqtNrVgOIlDVzN6Qx6R1FhroBOv0D1Po6+bWkiegzhmjEL4sM6jmxRT62IoItwJz2UU+2jf8vEVfic+qjX5FKTOlJe+On2kPhYB5UWS9DgmirjheKLORfsu8EFN+VlrFFMu1LCAzGVkH68L+so8gPJpPozK7XI=
Received: from DU2PR04CA0244.eurprd04.prod.outlook.com (2603:10a6:10:28e::9)
 by AM9PR03MB7395.eurprd03.prod.outlook.com (2603:10a6:20b:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 17:42:06 +0000
Received: from DU6PEPF00009529.eurprd02.prod.outlook.com
 (2603:10a6:10:28e:cafe::ea) by DU2PR04CA0244.outlook.office365.com
 (2603:10a6:10:28e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Fri,
 11 Jul 2025 17:42:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU6PEPF00009529.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 17:42:05 +0000
Received: from N9W6SW14.arri.de (192.168.54.13) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Fri, 11 Jul
 2025 19:42:04 +0200
From: Christian Eggers <ceggers@arri.de>
To: Brian Gix <brian.gix@gmail.com>, Inga Stotland <inga.stotland@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 5/9] mesh: net: remove unused stuff
Date: Fri, 11 Jul 2025 19:39:21 +0200
Message-ID: <20250711173958.25689-6-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF00009529:EE_|AM9PR03MB7395:EE_
X-MS-Office365-Filtering-Correlation-Id: 40ab8963-ed52-4098-2bc7-08ddc0a2404e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bsmdv7A4AVfEgfXdJIYGxkmVjJie/RfES/fwO2nqwZM8zToZmNaU/SizLpr3?=
 =?us-ascii?Q?O09lRRUXhVUCW6i2/s/lEa+/xcHZr7QRRQharxBf2jJ0Towe2e95GqJ/r699?=
 =?us-ascii?Q?69dnDuDXXj+LbzEVEHroXJFPY76s7hoa83ukE3KaOqtObZ9CLBMc1bE2QO0n?=
 =?us-ascii?Q?G+XJ8r1vyRnFwlmsG4WPmztE0iUE+692YBU48BiKTNOb1qZK+9frlPKnD4zS?=
 =?us-ascii?Q?QceJDUPvK7fb2jjBMZY3/h0ARlY0dE0+Hrjubsg+JWw6Iuqp7M+EletI4w8L?=
 =?us-ascii?Q?+Gs6jxaZunG8zuhrkrnX43v6g9wky7FCra+dW95aG3z/Inrh/sEwqAJB4T1t?=
 =?us-ascii?Q?CX8wU7/h0sCJpEUfYSNRaC02a1UYDmHEvAS/RE1WYUYvTiADH3+dYB37pLwI?=
 =?us-ascii?Q?kidMKTA4jf4onlZaTcpWft0TQBltl9t9BCuehaSpLfhoPxO8oV6hKAWdr7K5?=
 =?us-ascii?Q?a7FFJaTXFy46KF+n4RsbYZY7Vy5zGbxMB55bCXh115SbDHR+N2hmUYlf7Jv6?=
 =?us-ascii?Q?CP4KXrrHwtJdBGm8WsBwRsHl7dby7CcI3vGHNMxr0gmE6fbafSQUE/OlNmEQ?=
 =?us-ascii?Q?v608mhXx8dn2E3zyjCDByo5tvsKuBxeiV1nUAhZi45doA7c8KmkNgQVnJwCy?=
 =?us-ascii?Q?A3rbKYU4I6JSTqISrCTvFYxNDDLNj+xj1ZO8gDrCAduTluAcV1Qto3PWO7PN?=
 =?us-ascii?Q?ByzQu1oaC51nlvnRcVXVDhGvtZD3kNvLNev6uUyF/exptsdjxTj/MBshSH7o?=
 =?us-ascii?Q?DgFEDJbY23nWQEKUIpeeHMORgrjx7OS7AaVckALGD8ZXM8GbI3wl47ZWiu9L?=
 =?us-ascii?Q?yzupnkxB6Z6fClwyLxp5rR/+Rs1VQBiH4AxQdUaRJNl44TiMKNkVEEiZQCvE?=
 =?us-ascii?Q?QDqDRjFL7k4j0pI9sbBM/fZdRqF0zJ7KtkTWIuBnwtB7w/Y0PQ6ZavE6bF6k?=
 =?us-ascii?Q?N7qh39Ns6hHSyFmhqnRpaQtDvOfFxk+rr7U6jgD62X+oqwq1bix81Pa3Pa2Q?=
 =?us-ascii?Q?JfZS2/+b0MXi/SIj2Oz7kLPV8gn0/8Lry7b7MCDsRaUizTlHavSFoNgNXYaW?=
 =?us-ascii?Q?nbWJ3AcCucyI2CnsAdD+qeQzZRG0JGW7VgvaZagVa5jKGFTqpVVLcUo0y3Qm?=
 =?us-ascii?Q?yW3PLnY0/mQB/J8ZN4NoIGWhYc8jEqdijox+pPhsA0YFF+VNgPj213BXdeMU?=
 =?us-ascii?Q?yr1eBrwEqHochjj6EiupTg2clMav5l3vf8uoJbH7PWyM5SvxNfZhQ57kwNd7?=
 =?us-ascii?Q?q5mF4TraE7eFs7P+lmqrageouuAKtCzyjZbfTtCwuPZOJn3antThJOiNymKn?=
 =?us-ascii?Q?ALQ2X2SIq0jhnPAKWpy/oY35tfdMxNkb/AFVKv1sEJzSGNlt+yIhJpSrQgdr?=
 =?us-ascii?Q?K5/MQpxPktm8sVKjqsA1XXPK2q5UtDQN7e1xDzA4hgxhhXqTSAuh92ebSQPB?=
 =?us-ascii?Q?O6evJFQW42WQ2F7cG0Z8VmG9EWP885Q8ibJKyT5zVWHOUj3/iB8uVywiZLjZ?=
 =?us-ascii?Q?bCrUWQE6WcUuCLRLimz3Fyaw56CdDyVTSA51?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 17:42:05.1801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ab8963-ed52-4098-2bc7-08ddc0a2404e
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7395

'struct mesh_key_set' and 'struct net_decode' arent't used anymore since
commit 994932b740c7 ("mesh: Refactor friend.c and net.c for central key
DB").

'mesh_status_func_t' isn't used anymore since commit c4bf0626fb62
("mesh: Replace storage_save_config with mesh_config_save_config").
---
 mesh/net.c | 11 -----------
 mesh/net.h |  9 ---------
 2 files changed, 20 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index 496e4dd7fc04..3a93f6624e8c 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -176,17 +176,6 @@ struct mesh_destination {
 	uint16_t ref_cnt;
 };
 
-struct net_decode {
-	struct mesh_net *net;
-	struct mesh_friend *frnd;
-	struct mesh_key_set *key_set;
-	uint8_t *packet;
-	uint32_t iv_index;
-	uint8_t size;
-	uint8_t nid;
-	bool proxy;
-};
-
 struct net_queue_data {
 	struct mesh_io_recv_info *info;
 	struct mesh_net *net;
diff --git a/mesh/net.h b/mesh/net.h
index bdb797e1249b..5200beb2fada 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -143,13 +143,6 @@ struct mesh_net_heartbeat_pub {
 	uint8_t ttl;
 };
 
-struct mesh_key_set {
-	bool frnd;
-	uint8_t nid;
-	uint8_t enc_key[16];
-	uint8_t privacy_key[16];
-};
-
 struct friend_neg {
 	int8_t rssi;
 	bool clearing;
@@ -219,8 +212,6 @@ struct mesh_friend_msg {
 	} u;
 };
 
-typedef void (*mesh_status_func_t)(void *user_data, bool result);
-
 struct mesh_net *mesh_net_new(struct mesh_node *node);
 void mesh_net_free(void *net);
 void mesh_net_cleanup(void);
-- 
2.43.0

