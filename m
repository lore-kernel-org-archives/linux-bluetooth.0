Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013049.outbound.protection.outlook.com [40.107.159.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C3D14AA9
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751979762; cv=fail; b=cqbCRjX+0AJeT2g7AI+G8CincNdrCTAItEQS4wOY9b8TXsqVUYjFPO7l2D01pF371+OzvX5oGSo1VIjdrWeE5PfAqZ350pGh/Hq4j/9+PdhvT4v4SE71Px7OSFA58Aqi8s/LFOuPBIlZifxVXwB2BP8z3j2kmRrvtLZCIbggZMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751979762; c=relaxed/simple;
	bh=mZV5+cUVpWo6xFKbesMz+N9C/alXAwJQmNzHOc23664=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sRKwxMaSRF8gZQB4+mvh7NYFsU9tHi1hih7eyhz3cYNns1HwN7HteknIgMLvmMGe3DYkyPE+vXInC2Gf1XH5qFJgYvuLSxPmF6sHuuOmZOdc1gbCWr2l0Nv0bg51Z3Nd2gU/kM88zoNhaY1uhwe2ZWltify+u0S4axmDkp9sN6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=UlKXaWId; arc=fail smtp.client-ip=40.107.159.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="UlKXaWId"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DFjVxVesyPwU8PvvcSNEQk2ibqkYlRh/BDBwFQUrqvYvqAegyzFAfVRO9oLzXR4FG2gKFfHvpg3NRBDPl4GYDgbHiTjbliXBRrV/18+l8VAr7mJOMrs16tNeAxGVNMFmYNOMwjPs8O74CEQA7GUQquzWfgV00ivh4Q2A94VC5kEBHKRvXzDEyrS7jUEsmHmuBeBcLnl7a07lWkuf/EHnNUpo5TD0IWCWqWZ8OSqJyJQwEaX+WUf1R4XCU9Bcv0hd7aTuQrbhkKR97+O33pNRRcFfcmGOViWBf5xxaIhTHREpZ0y790/7Tpwx/tEjQvcSGviWgu1Z3xthDStjgRXmoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50j7Ja0LaEkVNavbzwFfOIqCR0+wa4KBnfDM8Lu2fWU=;
 b=USYlJdtRxVFNvnYt2JEaIXns8rlrf4EZF8LNq85f2Pj5cSvzRO1gOGKlyoeM1KaNj+XHgkdInZauWmhTco1kgeFWgusDLkXy7ZFPjYoCmuAtCGj/j9bQhCJmbEKEbJTn7l4lJhWV4VB5d2SCoAjIP+FQLiBVqh3+5cc0Oi18zoGIP9C8SyHWMQ/Sqe+VEsssocSW4XdeDaAlhkOmh+xM5XK6RZMoTCLtvOA70WapfbU50bQw6Gv4KXjQgTix7VVCkRG5JPszOVGp8OYUJ4pLcx3k5l33Rk8CNCui3j+d91t6x8kmqvbBY72VTVEvNGULPigTYQ4hx4NZDi9DHbkaLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50j7Ja0LaEkVNavbzwFfOIqCR0+wa4KBnfDM8Lu2fWU=;
 b=UlKXaWIdCiKxHDTXdThNJKA6NFvR/ToaJCtDW+63YwnH1xblF5WhTHMgokXqX2Ksc3e2mcAJny6GLYaZXJG2T5oXTNNKFbseVKBufpx2XldHxs8PRTYXN+tAQQ3MKZhblIQ3cSyNJJfkUzJUJbzCkX2GvswY0LpTrVbsY+dQlJg=
Received: from AS4P190CA0036.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d1::7)
 by DBBPR03MB10461.eurprd03.prod.outlook.com (2603:10a6:10:539::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 13:02:35 +0000
Received: from AM4PEPF00027A64.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d1:cafe::8b) by AS4P190CA0036.outlook.office365.com
 (2603:10a6:20b:5d1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Tue,
 8 Jul 2025 13:02:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM4PEPF00027A64.mail.protection.outlook.com (10.167.16.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 13:02:35 +0000
Received: from N9W6SW14.arri.de (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Tue, 8 Jul
 2025 15:02:34 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 09/15] mesh: net: remove obsolete struct net_key
Date: Tue, 8 Jul 2025 14:59:41 +0200
Message-ID: <20250708125947.11988-9-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A64:EE_|DBBPR03MB10461:EE_
X-MS-Office365-Filtering-Correlation-Id: d0167701-0aa2-4f2b-35b3-08ddbe1fb564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GDyCegwujU6oiSI0JXmEhcfyG+t54qy38z2PpSdTI92+lfo1UPczau+rB9ox?=
 =?us-ascii?Q?ZQpOQVDst0Yhv4tUBKq2II7uTETPwZ/S0+W9HLQVwD5ftqk+tko5rcAbBMZG?=
 =?us-ascii?Q?qaUZSRV5W7FYsMpBLO/WTOIisZzgMsaer2kxkUhOGHZQ0Dsot6F9iJP8272c?=
 =?us-ascii?Q?y02VSycFwUyzLO4forksoPeOVw98XFYBWTjPAbD+0yfAX6VB6wocN5bmT0QV?=
 =?us-ascii?Q?SYgrxnu5z3YVkVOR31LtOjaTR4r1QaXzlUhAUn5t8V9ozMTF0gHAOT6qGtGD?=
 =?us-ascii?Q?/Yv3a8B/NIop/h110H6YvcRJ6/Ymcw7NJXg/LBH+ZgIen8rR1Ls3gLGL6wfj?=
 =?us-ascii?Q?urH1Z1uTri5GZn3as7n/djCEklAoF63kWV5nDEvPmqAun9NsreNgNCJqVcpD?=
 =?us-ascii?Q?P/UuZGMPvWO8EB4zS/unD9ZOS92M40w4uGMIBuBOBq5kafzHDjyPjDdBtpCx?=
 =?us-ascii?Q?wSEG2cCuE1gUVYNcfjWo/8qEFpxs7wZwSi7MNyl7aL/WIxdN4camqH59XxJJ?=
 =?us-ascii?Q?GZKb9XF8VKou2XDi5s1CkG26WKJMXH7DgzqJFoKrbdXBVO3vkse1HJm+KbaE?=
 =?us-ascii?Q?+7FbNEH7EXVDZ38+X1SdGjbI7IHfdMC1WvAR05xtjCLKQMmIheNpYknctvUc?=
 =?us-ascii?Q?RpTUdWpEoa8E+jSbg+h8B6Y9bBL6AoomOKSuoOlDP9X6Fo3OTouD47b8bF59?=
 =?us-ascii?Q?1ewKUEUJ7Tki2bZkDkZMOIvCqPm9Zk2IU+/Xku1Pv5BNWVVRMbULJ8Mnwo6F?=
 =?us-ascii?Q?4dvXrm/oBVoupXIDpsytxjdveSJV4ggTvtDZAbe2IYViqNKxR+5Ijoiu4kmD?=
 =?us-ascii?Q?ez+bGXivt5SNBNXCvTzwwoW/giHBW0rGNz9W5BNY4ahz7QUCOwdvoAwffpjH?=
 =?us-ascii?Q?IfFj4ibnnQcqUvqHkN0qiHrJJAe3hWgNjBQzsPrAOiKJtitN/ZaMzE3Y2TQO?=
 =?us-ascii?Q?IKUv/4rdm4Nhp7gp20kgNd8FtOyARWfH2zJQzJmsr+Z5oT1itVcqbKSa6O2b?=
 =?us-ascii?Q?7fKADgGOgrNdXwpkTVYp7DQChRDOg+ZpYB7yFc6Im823xkrSEHPRT09ZAvCR?=
 =?us-ascii?Q?nWKuxS8zrSJoA9O3BE5MmaCCaqQz0C+W47OxQhbbJLUHFuEsnRI8rp8Mi/5g?=
 =?us-ascii?Q?gm4iCAM4gbfeX3CZ14MMSiEFcSKndWmPHRTW16JbJMD8wz7gLP6w3fJ215Zm?=
 =?us-ascii?Q?Vt1RdnbwJQPiiT7R+zRHk4/vA16Mt87k+ihOYI5tseB83nHEXtwfIPA6oSDy?=
 =?us-ascii?Q?pk6ApjDt/q9GJDhj7h8fzHlM8ruu20J/aiLOhKEAR4rOXcnyf9UYnhPB/jNo?=
 =?us-ascii?Q?r5pD6wwxGwjqtbcwVlAs1n5hZXJsslsXmCiRyoRwJucFG9pvBeSqH9ZlRxs5?=
 =?us-ascii?Q?+7yiMAZcgSxveSy/k9EyGrQ9+LruPYQw3poYrdXKa9Uxk6+VmEkYgNqFY1Em?=
 =?us-ascii?Q?vs8lJjv83I2xMB4tliHNK73A7eXOBEfhxCdgt4+WbR/Iqs5wGcmMvp++kuIA?=
 =?us-ascii?Q?/BomYJ+I4mL94bC0jBdOY4ipSkcAIbNxkN82?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 13:02:35.2543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0167701-0aa2-4f2b-35b3-08ddbe1fb564
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A64.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB10461

'struct net_key' has been introduced in commmit 37ebf9eb0bf9 ("mesh:
Upper and Lower mesh transport") and became superseded in commit
994932b740c7 ("mesh: Refactor friend.c and net.c for central key DB").
---
 mesh/net.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index b61cb8cc41ac..54283d9ba265 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -74,14 +74,6 @@ enum _iv_upd_state {
 	IV_UPD_NORMAL_HOLD,
 };
 
-struct net_key {
-	struct mesh_key_set key_set;
-	unsigned int beacon_id;
-	uint8_t key[16];
-	uint8_t beacon_key[16];
-	uint8_t network_id[8];
-};
-
 struct mesh_subnet {
 	struct mesh_net *net;
 	uint16_t idx;
-- 
2.43.0

