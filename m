Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011031.outbound.protection.outlook.com [52.101.70.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FC6128395
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 22:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752271345; cv=fail; b=f34RmJHTmbwtKBzkwr+D8Yll9bcS9NCNyAf/9o1uSotUAI0GSh+PYrdWcrV4dxVr8HbWU1h9/hmC40kho+T2BfA8v+r6hxJeRYDQDF3bTgiXOwP7+uQDJaC2JfnWPncB+F7pebGjp8ZN7sANZtD4G8rjR018Wf1qSwOeHgEblaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752271345; c=relaxed/simple;
	bh=Gy8XuyEEOCIT2p0LbzhWF/2l5LQ9jASAVlmkp3LgfFc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m3duoKa4eoIvxzbMGgmaaHIzbwy5vNfB2M/wMRanGE69HVz0oryvTdcVJgvn2WkAOM/gWSukq1v9ZQbOtHwSURiWwuQELn9U/Ov1fcXeQboc2iBCEUXosj2zSqzo5XgA5h0tXRpdIhTEd6XswjlxLkbwyMO4TXGriM++ddKuGLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=IWp6n//v; arc=fail smtp.client-ip=52.101.70.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="IWp6n//v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Niifq7PyxvbDWm3OfMBxBZ/U9I8kHaxS4t/FMZc6LCZc1SFdvxBR8+J5EghEh0TEEHltr8CApWT9F/QHITi4bAzWpMUAPNwOur9etl9jlmQAsRpPay40liEbZW1v1YdhixGX1Obwq90xN1xkHIxzTDRnw55FdtCrM5V9bAlrmUv4g599Hlj10Ir1+zXl1xwx6M64Bh/hjh+bsvQ3YzOpeXbGkcJUbqWZ9wIh3/QU2EZVcdTIlBa87we9M2wHOulcH0eeUBrL0caieXalsy3uC7TBvKVCRjusCexiz9Q/K9IeCNfIuCa8zgXs4Zy7EedjmdfC9mgEam34DaukcU0dhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Vg4O2xlTZFcZwYoXlQ9TK1/E1cZyJB5NYo3xWKlhSk=;
 b=iM2N4BPRXlBaT52ZQTGPpKkKSxXg8L77CWK+fovqOUajlEpD9tOvKoJI4XmpntM9qHbAlKZfP+TRA9cKTISX7m3V+wGVdboEfYtJaGzmEXPg3iWAZcH8IrV1GNRSHuCVhV9Y/RUMtp89Gk4q4EJcBdPkf49wP4QBLIB6N/OiEb2QM6u3INKE7ADtlycZaYI7TxlLgwj4XQOSqZGEmTu55AwVnDfgFj0jos6FY1qklkXulL3hN/JoohGDQq2pjEaWbeNWP09jE4gbWE8s1IaMzXEERsCneM/2qbJBav5WD5nPqy14xxkqfiavlP+fwbUVjzHpYIMXt+2HxqwyY7uV9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Vg4O2xlTZFcZwYoXlQ9TK1/E1cZyJB5NYo3xWKlhSk=;
 b=IWp6n//vCawCddVcLJPCc6Tfimke6bZGYnzPt4fTdTbtXiVUpV/HYAK3J2orji1bMZViM9vSSScF1RcvziEu7KD441YzwPgSgxnwZj21cu6exT8dBwZxl/5mqSZNYr/AiKf2SFh28n5RO5X8G5QybgeELesksTY60heJ49SANK0=
Received: from DUZPR01CA0090.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::8) by DB8PR03MB6284.eurprd03.prod.outlook.com
 (2603:10a6:10:13e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 22:02:20 +0000
Received: from DU6PEPF0000A7E0.eurprd02.prod.outlook.com
 (2603:10a6:10:46a:cafe::3d) by DUZPR01CA0090.outlook.office365.com
 (2603:10a6:10:46a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.26 via Frontend Transport; Fri,
 11 Jul 2025 22:02:31 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU6PEPF0000A7E0.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:02:20 +0000
Received: from N9W6SW14.arri.de (192.168.54.11) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Sat, 12 Jul
 2025 00:02:19 +0200
From: Christian Eggers <ceggers@arri.de>
To: Brian Gix <brian.gix@gmail.com>, Inga Stotland <inga.stotland@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
CC: <ceggers@arri.de>
Subject: [PATCH BlueZ v2 5/9] mesh: net: remove unused stuff
Date: Fri, 11 Jul 2025 23:57:17 +0200
Message-ID: <20250711220035.10065-6-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E0:EE_|DB8PR03MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: 3538b20c-b3f1-41b5-a38b-08ddc0c69b97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gUuIASC1hN6L+rJOoukckqekzQBQZMm+UuiOMTR4WNQUaA6oTLwvlTl6dDwq?=
 =?us-ascii?Q?t5hkdwdo6XUhw1DJVnMeR0IGe3vRk4fdTWor+iLjscSeaLI3DLJwtC6r/j79?=
 =?us-ascii?Q?p5TTc+QCCG0C5xj93+G3AragAOsNIUP/t1XyoG5YfNBssLIDVdJUS1SJHvvN?=
 =?us-ascii?Q?MleLNpnICYED5KkORPhsk1NDBIYyXqHJ1XVNYEg6C3PHYo2t2Xx8g7UeprHW?=
 =?us-ascii?Q?2Cdp9YAg6v+FKJqQITIdyUuwcH8l1y/IvEv7cRXE2hhuIlJWscUHAeZ+h322?=
 =?us-ascii?Q?CnmHkkfWWD14/y+rG7Sr2kp5IMdjY0jtSnsqhH3xKv2Npxc6s+0YAqVYOTTe?=
 =?us-ascii?Q?IgRu5YyNF6ttW71qUARQ4IXDq26PK6TiNsD5A252mEDG8eKmZlwqA/M4UfJw?=
 =?us-ascii?Q?cIbHUeQni3tkvEKYHP1H0e73o1lXVnWuIcJ2BdFTKLQfMUG+1FpNWm7ymKjz?=
 =?us-ascii?Q?pxag2PfXeOGxa8kRCjm+I8tPCLKTaaMnfLHZS/j3KEpZtyjhoBIFIM0SHPTE?=
 =?us-ascii?Q?kjh4N0mctRXcbJD/nvqQhDbSfBqcxJAO/d6BQwQ/nrL7ZlnyVMXthzeTB3uc?=
 =?us-ascii?Q?9xCfDtbX8au8dqhQoxlLhr5H5aWau0Akkb8rp9D8M8noi/MF15cPkR/4aNw6?=
 =?us-ascii?Q?s5DCBmNNCMQws2jtZm2LJuctOj5C7brUVLW+lpQCAXEVwG20X01KqOFfwGR/?=
 =?us-ascii?Q?rRmDcbKb4/0hHB62SxJgLjGQ6TGl2DuQooqQ9+GMekU9GtP49rqeLQT+hfdg?=
 =?us-ascii?Q?aPqarYN46femrArU423ThJTedv0cXBAPrVKA2gYGUMR6ekYNloBkX4TH3Igv?=
 =?us-ascii?Q?dMvuP+2fEc040ZHz1caaAaFKuZpICju01jzqnnUA5MDaK5/pNZ1GuEgpF+OX?=
 =?us-ascii?Q?eXhHw3/oYgCUAY8LCJTtM3yl5jjP5Y2UDMeAs/uiqKcjJVctLLk4ZXntIblB?=
 =?us-ascii?Q?rfWN2CifZOtZ6O3Bx4Jj0ovg6YiLrrCWk1NMgf/YxpzjyuzabYIII8pFri/x?=
 =?us-ascii?Q?4hKNOT7/n8eZ0I/ABT6HjU2F1Z1fbS4bw7MWpWiKJT69wcfYQFpFlB84xoBt?=
 =?us-ascii?Q?CjggQvZSUfhg2ZA4x7UqGeAfI2MdUYE3KgN+dGcg0a3lxpp+nf81mEPR7h7u?=
 =?us-ascii?Q?HGTMXmdoKiH+IVzsLuOZ+UoaEhfPBBcU9bbgCMLp/fJFyFy2iETzKYuJ1HCN?=
 =?us-ascii?Q?VqChihFlJ/l7rTklnwj8uYoaNQpQ5X0wQeQTD3KPWB3uF3hdLiJp1NIcOlCW?=
 =?us-ascii?Q?Irh09r9kQNUN4CvebpnfKjSaoTIqZXW9I3/nGz1aQ8phjie2D4mJ2s6kMEvp?=
 =?us-ascii?Q?PKSJf4NxiFHIi0uPJJAshOweeLLO0DrTYm02AgbT4i4k9UqllChQMj3l1n1b?=
 =?us-ascii?Q?lcOn2t9UxZND9qiiJnqyq0IKXz/As33SExG81L8hNPR02KLn51E5G3Z1frQX?=
 =?us-ascii?Q?tdE9FGkURhB2MdVskDtUd+qPg3Q/9z2QMtJcbTgY9Q/p2KaOWVovscNftWt7?=
 =?us-ascii?Q?bBOgbkn5SzS8nBaHHexabNcXqO95cowR8QpO?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:02:20.2214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3538b20c-b3f1-41b5-a38b-08ddc0c69b97
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E0.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6284

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

