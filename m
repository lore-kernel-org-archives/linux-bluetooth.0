Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013046.outbound.protection.outlook.com [40.107.159.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870BA2DC342
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 13:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751979624; cv=fail; b=iUa3pLmA6+gT7+VmT+WPeHQVRLro45Yyao6CyWJOsuUHyhNqLfCkxoIMQ+mHxFFNg15X/p3kLnoZJ1fWbGi6/BIO+otWNyaTvUk8SzD52Q0TICQMXuVFUDXWqibs261C7RN0js0bnaMtj03+yjQwc/W499Z1MGDA7azAd2MifbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751979624; c=relaxed/simple;
	bh=p0UeAFxE8VAm3QFoC5EwQb0IO8Fs2F7yoiH+R0oLQN8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oTHlO1I42vvVSHVOmsKomm3vGlIbo8T118tf1nD9jdI2rPKpT93GGWIyMaeiWvY12DRATSWPr+QOhYaaHH1crKpxAufxdOhxvbII0JzcOWHpb7l+M97aM27eMrbW5PzmAafr4PNjPzsKOHnIJKz4Q2/9KN5TXpLjUQzJ9hQXegc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=hdywDsvx; arc=fail smtp.client-ip=40.107.159.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="hdywDsvx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvXA0+/37O3+1Y7up7nS4AwZLfwIe0BTUESTbEzquGkbHO7ZWki4Mfs5hz6er9EHjjw+9FacxCAPYbo5zj79LJOeX5mzxGzjer3m4UdqjWjf48+tH6yaKDH7+a20rvCxGloPmXTiEuCzFkAaOE5z4A5v0X2XiTdCvbbo+Qk7M9wNIpGFAdaqcfbrOSzuPlTnIs7k+OxDiOu3vZftRe2pDy6XEJCBALZLjlEVKJj4jJPg4n38y1C1cvx4XMX4wYbpUx8hWAW7balP70IF+4KTAmvUQVUbf3zx4oMDpgzRZGMxAYvbhZUeKAbeorKMI64FNT6VD9MWfWmSqiSS0zZGcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h86U4zQ3Mg2Zip6V40lenR12jhI9DiJUEMH25fzkcIY=;
 b=fQk0vJCXz9BWN03QGAddZqwqEv5WlFLF/sy3vKxWQtioCmgS7gmrSfZCAfp3c05DXzg7w/NmZqP6V3iumbQo4QPHzufUVHL0hK7ULYP9IMOD0+ciytokQZs80Fna/NLCLZqjOUzZ14Vbtw+MMTDvfhafQu1BxSD6bBfh/BWYxhFZQAJmjOtxNvysKOhqJqti04v+ob+unUyZqqE1bwwc/e6XuHUZ6yvt6PtRoflMLPFX0cUGmuN/P0zfpdskSifa02H0D8Ul8aIKCWVCQ8kNhtgmMUars7f/m3ZOZNgMuzBFtyJPCxxCQdEdTPpZ7PEbmR3UuZ48+seV2ybxAl4Yxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h86U4zQ3Mg2Zip6V40lenR12jhI9DiJUEMH25fzkcIY=;
 b=hdywDsvx+Jeracc6Laa+DOOsvZdaHVgBzLX7y/e+dZ8D0XvWeeD704p0xav/14evfC96vFHfubTR9Y95B9GWHW68OjG9l+fbALZ9mwKb4fV2FIplcu6Ps8n5iMuqAVTGB3h/tP8hqcKoW0RkI+C5PmzowFMcmixPIYC/0SWHpQU=
Received: from AM0PR03CA0095.eurprd03.prod.outlook.com (2603:10a6:208:69::36)
 by AS2PR03MB10153.eurprd03.prod.outlook.com (2603:10a6:20b:64b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 13:00:17 +0000
Received: from AM4PEPF00027A5F.eurprd04.prod.outlook.com
 (2603:10a6:208:69:cafe::2a) by AM0PR03CA0095.outlook.office365.com
 (2603:10a6:208:69::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Tue,
 8 Jul 2025 13:00:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM4PEPF00027A5F.mail.protection.outlook.com (10.167.16.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 13:00:16 +0000
Received: from N9W6SW14.arri.de (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Tue, 8 Jul
 2025 15:00:15 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 03/15] mesh: friend: remove dead function declarations
Date: Tue, 8 Jul 2025 14:59:35 +0200
Message-ID: <20250708125947.11988-3-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A5F:EE_|AS2PR03MB10153:EE_
X-MS-Office365-Filtering-Correlation-Id: 709627dd-e237-4a01-a356-08ddbe1f627c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x0fqoWBD7XCAqGYR7ZoCj9sptweqLIGrboakgSL4C0LP3TWR4ZnyMmmjNx3Y?=
 =?us-ascii?Q?JvdS2iQPYJsh0aAEmsxrRfYQ4Jg8jBdG0yB9C6uLSYDMQIsjvuaAfX3iC1ew?=
 =?us-ascii?Q?Z9pUK58WsXOCWUzop6+qCRw2Y4RpR2Qwcni+qVSupM+As4xzxHKiSjUrgTVH?=
 =?us-ascii?Q?tjFEq2SqZoHZ4FHCRhn85g9L68dpkvfoVa56QeuJTyyvGw49bs6u3caBOOGP?=
 =?us-ascii?Q?SyzA6+Uy94NgBJgVTtNMPGlagJmttUvMKnpozcexIk8ikQhjyy3aVZ4LYb14?=
 =?us-ascii?Q?faoO6vJ3unWcorBWkngKmcgq+pX/jqC1H1gNNwnvTpEFSg3p8ND40SwgHTae?=
 =?us-ascii?Q?Rso2AUIu2M3Yo2X1bqF19mPTnc+ZAqffSnp4fizxghX9X5sTbTItigQpXfZD?=
 =?us-ascii?Q?johA0pvnvRMKOVzHrtkngsj4wNuWG7TGAQcdbk/1Z/wHS3UPoMAjQ3kzX1gj?=
 =?us-ascii?Q?uXGmihrBeHAGQ+aiRPH+oNyys2YW9KIqrhcYBNpbGfT/O54cULg55TxVXVnn?=
 =?us-ascii?Q?bhX4wc+r6FQgI/wwZb+99kfscRY/C4nfNaCQO3kzUlFS1EWCC0VExPR52/yV?=
 =?us-ascii?Q?lNdk4oqydibUGuikKW0xuo4uc+mz/lHAQF4j/aot9/bajv3VnYkwRNRrgGp2?=
 =?us-ascii?Q?nL68qzII/IrUeSNlHBJOkKYN2Rv1hPYG6BBzyezKEYVHrefqfFP07GE1G6sN?=
 =?us-ascii?Q?Z4EFGXtBwxqhhwnCTb55TnBROjBRGnlaboQf2scF9ceVS4u9vqrcrQNLWllD?=
 =?us-ascii?Q?tFube/WHcl9j6mVJoBhlNX6/2klP3KAHP1LSH6f+iNZKt0oDCAN4QyRBNTAB?=
 =?us-ascii?Q?zXPBT4+h6CB16HL6dEJT8Ej96O8+1CLySyPSXdFhS5yzqQMXlPY8tfYqDeEQ?=
 =?us-ascii?Q?/0IgwkQ3T4KPW2xSZxeneEMWc9lSKUxZOWDX64TTX8pmZuavdgwXOAb1wg2a?=
 =?us-ascii?Q?6LYd0fqrKv0RbMEpRKDQSkicVZOYRkz83AqzB1hYhwneu0pmg4Xw0RaHS7GK?=
 =?us-ascii?Q?cpnlG7yOEC62B0a7Ejgh1IAS68bqwUItY7R28cTcp0DgQH+TUxYYvtuoyBVj?=
 =?us-ascii?Q?iUqHacxSWSpuNEuCttpKwtZYb95quJaeTlNopqS7RYtiVEWnhtPSmtQ/pacE?=
 =?us-ascii?Q?IzDMjOQKeAw7YeXwbgqsumEJfnFoH/Qd1BZltmPfKsShT3OPk1ILrWTlnl2R?=
 =?us-ascii?Q?1+jea25iW1JuULK3o1MB3ZPaRaQ6sc5mIBF6KmOW0qUlDfHH/vgKmJxucfQG?=
 =?us-ascii?Q?F3iv53BS3kCwZpzT359kcRHqHHk0Ie86GNQkEams2VTBi3BJrnn6qYF4DpeU?=
 =?us-ascii?Q?L5/8X039a+iz0iJFGCL/G/jkt1GFuR7KXulnO4+XSvhnQp4toaRIuUMb+3M4?=
 =?us-ascii?Q?p+YI2FnQbT/ybmo12g9bUkQzSTUmDjNqvA8KU8hS9eDG2ZLibcQo9phDVyX4?=
 =?us-ascii?Q?cCvBvvNk+KdLcY0DmT62ncMxzOLD0qfIZOEcXdrWjpU06EIs10Abyy/z6ovA?=
 =?us-ascii?Q?NkOVmr7XOkGjQFH84Z013YDKibkk+/9sz0Mt?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 13:00:16.1653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 709627dd-e237-4a01-a356-08ddbe1f627c
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A5F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB10153

The implementations for these functions have been removed in commit
f246d31a7752 ("mesh: Friendship clean-up and rewrite").
---
 mesh/friend.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/mesh/friend.h b/mesh/friend.h
index ba60534266bd..644ad1b9b42f 100644
--- a/mesh/friend.h
+++ b/mesh/friend.h
@@ -31,19 +31,3 @@ void friend_sub_add(struct mesh_net *net, struct mesh_friend *frnd,
 					const uint8_t *pkt, uint8_t len);
 void friend_sub_del(struct mesh_net *net, struct mesh_friend *frnd,
 					const uint8_t *pkt, uint8_t len);
-void mesh_friend_relay_init(struct mesh_net *net, uint16_t addr);
-
-/* Low-Power-Node role */
-void frnd_sub_add(struct mesh_net *net, uint32_t parms[7]);
-void frnd_sub_del(struct mesh_net *net, uint32_t parms[7]);
-void frnd_poll(struct mesh_net *net, bool retry);
-void frnd_clear(struct mesh_net *net);
-void frnd_ack_poll(struct mesh_net *net);
-void frnd_poll_cancel(struct mesh_net *net);
-void frnd_request_friend(struct mesh_net *net, uint8_t cache,
-			uint8_t offer_delay, uint8_t delay, uint32_t timeout);
-void frnd_offer(struct mesh_net *net, uint16_t src, uint8_t window,
-			uint8_t cache, uint8_t sub_list_size,
-			int8_t r_rssi, int8_t l_rssi, uint16_t fn_cnt);
-void frnd_key_refresh(struct mesh_net *net, uint8_t phase);
-uint32_t frnd_get_key(struct mesh_net *net);
-- 
2.43.0

