Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012052.outbound.protection.outlook.com [52.101.66.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D082550D2
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 13:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751979909; cv=fail; b=tWZriap56a8iOldLUvXYqEI0/ALUtBLcefOVmmMTZjSiEVywmahOqJXd0+4W+I6SvIBAPB22E0eTCSpDPXT4oMr7bf9959SFYWPhmyDr43qm8PUWE4z1toYUespM4t+1dlmPLh0mmh1jz/6H21NYakAvpugg0aZoA7Azj4D78xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751979909; c=relaxed/simple;
	bh=6uy/HI8kC8g7+CcxM50pGppDP3pZo6h08L/aiIIgp6E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aGcHv/uEWMz0oC1d/Nd8f+zmMhOAdPnwQfAcq70cLOvRs1l4sVDxwrctLUhDqm+m27vrJ4DMUdc0X++WSrlW6kOKD7cVcnLS4Avo7xBr0R//wKiVAhrB2pXhG3rXgx3ZIUdce2BuQ91mIN8e7vJ8961pQ6w/Z2ar+M+q84srG/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=tyW0tFYb; arc=fail smtp.client-ip=52.101.66.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="tyW0tFYb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vGcN3cfWauGcE22Z1EwtnHDX0eB1BZJFXXh16eMxebuZ7cWQVW6VemQURv8Gr78JZl6M2NK3JhgP/8HuS4diL2q0N/HzDE0XbyzG84l4GadfgNzLpNKFSyRIFaMF6rwetF2yv7zo3ewKVLU8uEOtxZ9BYOB3xBwfcxicnT91SjrpJKnPRkYX84bedWbW+NzF370yAk+8Y83AMOmpJ/lsuP9vm8fyZ9zfqZwqwVfF7H4OofFHD1JnDLirDhGHyDVPYFOoeHXMq+U/RYOgyCO9Q37j5KB9w1QA/OKEkK68U3MVfSlncUjJw0cAlqWJQY9/v+Pr0ZdPiXm0lxBIqpr2Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqJub5K2ijak0UwIzYxxrx7LIK3C7SJf0dGUzQ1gBbo=;
 b=WZOMWVMYkBzHbjFDQ417+wiC+qwDmOfgHSo3EYGGSlZv5krj1+jcFmEYprPeqzLeH6v7XswoevweTHCwv4O6zne9VR0UHWA+We4ejZPwZonEW/+eyCSVF0GqSenL/vto58xZefwmTFOhI7tP986bQEQnXkRZMb5jrjps1Y5CLLGveUGOns0xNcN930S2CTfX7GqhUy3UDlM73MjQ+kTEmeKxTup4lBGyuJXA4ygNWGR0GtyjLnoByj80MT8gCjyb412ztNimw3iGQvkQ/MmhJqomWneX7aigxsr1QLr1nGpi6Q1K4f3iQEv4EL+1b+ax7WxdcmlKQOvNvIaxlCWttw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqJub5K2ijak0UwIzYxxrx7LIK3C7SJf0dGUzQ1gBbo=;
 b=tyW0tFYbb5a866i6ZR6gGTquDkSZzpPY2sGy35B3qaIxX6FPzcbhsQAYkxCcxOvQGqix+TtiIPMYeosXT6MoPWbHnCcCykkCQ/hwCyqj6a2w2T2temXwl6IvVfTiRbwJn28ieZ71prn34qH4ZUr7SqMdnMnXiy7Yk3eJgNi5VL8=
Received: from AM0PR10CA0115.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::32)
 by AM9PR03MB7041.eurprd03.prod.outlook.com (2603:10a6:20b:282::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 13:05:03 +0000
Received: from AMS0EPF00000196.eurprd05.prod.outlook.com
 (2603:10a6:208:e6:cafe::e2) by AM0PR10CA0115.outlook.office365.com
 (2603:10a6:208:e6::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Tue,
 8 Jul 2025 13:05:03 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS0EPF00000196.mail.protection.outlook.com (10.167.16.217) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 13:05:01 +0000
Received: from N9W6SW14.arri.de (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Tue, 8 Jul
 2025 15:05:01 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 14/15] mesh: remove unneeded casts to bool
Date: Tue, 8 Jul 2025 14:59:46 +0200
Message-ID: <20250708125947.11988-14-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000196:EE_|AM9PR03MB7041:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f91bd9c-bc38-4bc2-30ff-08ddbe200cc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Etu+1Jc7joZU/KQh6vW1l+xgpoWzqlJO4UuN8BQEKn8vJG2KR+lJ0OBqiEFN?=
 =?us-ascii?Q?M8EPndIYhLz+Sc5pwwlbrkbCYDpTa1jy0FbbXN/3njEn+jhftxUOzdXZAfcW?=
 =?us-ascii?Q?xBlynByNh0WYkSsPxB1nankIgeiPZN1bwgt8E6+TTJjM1KA1XS1Dcfg6kWOL?=
 =?us-ascii?Q?RrcRvNkIGysLPG88CmT1Kn1tBmwtFaqpl/msHElvGQEs5/D+21Vu9QvfGluQ?=
 =?us-ascii?Q?EU2cXVzKGXlbiXCu7ixvqpr2XKJoo5Iq/3lDFkOQPSGicpSkQtzjysSeoVh+?=
 =?us-ascii?Q?YiNk+LH/LImMDukd5HqFflxShhFp4UsjStU7WbNDJb3Z6/fhrGl5+AKv+MVU?=
 =?us-ascii?Q?72Dzdg3QOxOc58GkgSqQPyYRA2Pu/AofipyZpt0Bc9VnlVxbznWKhMytK7mG?=
 =?us-ascii?Q?aSQWi56s37k0fGu+7Fm3noIuWEeqPHXVd3uxdO6kUALm1PW66aJrrt8vCqMf?=
 =?us-ascii?Q?iQegU69gZ0HEKXQIJidCYtE2LJEn4AE4V/nSjHceiHxBHGtp0f0v/FU7JBPR?=
 =?us-ascii?Q?P7AnhENezkY5OquIph8AyfjDR0RF7cNtfwjBVDLZJS2CYu3xjFUujtKNpyFZ?=
 =?us-ascii?Q?B2bFnEhVSBxU+OyAf4E/o+kBxjv2ozorSjg2i1ZBmDGjjancp8Wfy0Ra9p34?=
 =?us-ascii?Q?2JEHi4fL+LqxItoLP4PuUN9kU7LdN2ZXLWuz7L9YZeP5RmGMwoSX36D5IXo4?=
 =?us-ascii?Q?/rI6dTSdGdg0k1VEEwCz+z7Q555JPRlNTrBouOKn4935gqJf0DrqCaWWXMQE?=
 =?us-ascii?Q?6mDionLfRA9Y+DCnsmqzR/y9C55BEKt9My0MoSVtzq0RscJm6hOvqoN/okjD?=
 =?us-ascii?Q?UQxjYfanrj5NzrnfU6oStv2Bv4SuOgnd8ut7OE9qXdCCUPv6MrdY8wC1DFbA?=
 =?us-ascii?Q?QJ6zubnLZyNEp/WPUQpZsoNiXnikia9d8Q1rnCSmC7kg1LWBh1kN/MRrA1vr?=
 =?us-ascii?Q?T+XIBCLW1rDn+/A/hZ6dvqvK1lq7llWf8iqn1+7k0Ch8WBIILHYWgXxxKE7/?=
 =?us-ascii?Q?FZZTYrXseu45bhVTWP3ETT2x0haFxvh5WzSNPzWho+Mf5WQoOxdCfBtZYRix?=
 =?us-ascii?Q?sBYvMaju3h2HAqdX4HEc/8Ns9ppD2Zhi1Iv2TngPfVKjvnNGSbp76zT9Njtg?=
 =?us-ascii?Q?KDNNA1r2BuDCSI+Si/8jnIbyf+JsfNspOC70jSVYysgwwRs1GS91U5anM5jY?=
 =?us-ascii?Q?nNXPuLJ53yZkPkfDeXnT8yBytCu0GcftElu5cSRMV8sWd0U3teGKd/o7mKoM?=
 =?us-ascii?Q?5H5h2EEoZuK4ZRD463clpoGx57KNCzMAyORw1N2cP00rrFwadh17Q6eVrVDO?=
 =?us-ascii?Q?wP2glfhXch9/Ut0VbzJ6p2cTTw9U23/Q9xkvd2jJYM3ryx9EIYKt8MYOYUKL?=
 =?us-ascii?Q?M/xz+88rFNE+RJ0REMsFddrm3syIEfGgrj3c6PxnjZTclmFYRRh2ODLkh4nM?=
 =?us-ascii?Q?UGUla2NbK2Oh3OnE5FZNEaaX9J9kL1CsDAhP/yjY0nv9CxocIJt1BumCcg7D?=
 =?us-ascii?Q?2x8YnXkIxdMwcfUe++5XTfI77/LUrnW3e3fa?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 13:05:01.8614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f91bd9c-bc38-4bc2-30ff-08ddbe200cc6
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000196.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7041

The result of these expression is already of type 'bool'.
---
 mesh/crypto.c       | 2 +-
 mesh/friend.c       | 2 +-
 mesh/mesh-io-mgmt.c | 2 +-
 mesh/mesh-io-unit.c | 2 +-
 mesh/net.c          | 8 ++++----
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/mesh/crypto.c b/mesh/crypto.c
index 136e6953578f..a9d670485da5 100644
--- a/mesh/crypto.c
+++ b/mesh/crypto.c
@@ -67,7 +67,7 @@ static bool aes_cmac_one(const uint8_t key[16], const void *msg,
 
 	if (result) {
 		ssize_t len = l_checksum_get_digest(checksum, res, 16);
-		result = !!(len == 16);
+		result = (len == 16);
 	}
 
 	l_checksum_free(checksum);
diff --git a/mesh/friend.c b/mesh/friend.c
index 6aacf6338f24..1c60705e046c 100644
--- a/mesh/friend.c
+++ b/mesh/friend.c
@@ -521,7 +521,7 @@ void friend_poll(struct mesh_net *net, uint16_t src, bool seq,
 
 	frnd->u.active.seq = seq;
 	frnd->u.active.last = !seq;
-	md = !!(l_queue_length(frnd->pkt_cache) > 1);
+	md = (l_queue_length(frnd->pkt_cache) > 1);
 
 	if (pkt->ctl) {
 		/* Make sure we don't change the bit-sense of MD,
diff --git a/mesh/mesh-io-mgmt.c b/mesh/mesh-io-mgmt.c
index 0d32859794d5..4ca7ff93c863 100644
--- a/mesh/mesh-io-mgmt.c
+++ b/mesh/mesh-io-mgmt.c
@@ -581,7 +581,7 @@ static void tx_to(struct l_timeout *timeout, void *user_data)
 		count = 1;
 	}
 
-	tx->delete = !!(count == 1);
+	tx->delete = (count == 1);
 
 	send_pkt(pvt, tx, ms);
 
diff --git a/mesh/mesh-io-unit.c b/mesh/mesh-io-unit.c
index 4fd72bf8480d..936f5a9514c5 100644
--- a/mesh/mesh-io-unit.c
+++ b/mesh/mesh-io-unit.c
@@ -341,7 +341,7 @@ static void tx_to(struct l_timeout *timeout, void *user_data)
 		count = 1;
 	}
 
-	tx->delete = !!(count == 1);
+	tx->delete = (count == 1);
 
 	send_pkt(pvt, tx, ms);
 
diff --git a/mesh/net.c b/mesh/net.c
index 54283d9ba265..e8e3e271cf59 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -606,7 +606,7 @@ static void refresh_beacon(void *a, void *b)
 	struct mesh_net *net = b;
 
 	net_key_beacon_refresh(subnet->net_key_tx, net->iv_index,
-		!!(subnet->kr_phase == KEY_REFRESH_PHASE_TWO), net->iv_update,
+		subnet->kr_phase == KEY_REFRESH_PHASE_TWO, net->iv_update,
 									false);
 }
 
@@ -2809,7 +2809,7 @@ static void process_beacon(void *net_ptr, void *user_data)
 	/* Get IVU and KR boolean bits from beacon */
 	ivu = beacon_data->ivu;
 	kr = beacon_data->kr;
-	local_kr = !!(subnet->kr_phase == KEY_REFRESH_PHASE_TWO);
+	local_kr = (subnet->kr_phase == KEY_REFRESH_PHASE_TWO);
 
 	/* We have officially *seen* this beacon now */
 	beacon_data->processed = true;
@@ -2831,7 +2831,7 @@ static void process_beacon(void *net_ptr, void *user_data)
 		if (updated)
 			net_key_beacon_refresh(beacon_data->net_key_id,
 				net->iv_index,
-				!!(subnet->kr_phase == KEY_REFRESH_PHASE_TWO),
+				subnet->kr_phase == KEY_REFRESH_PHASE_TWO,
 				net->iv_update, false);
 	}
 }
@@ -2974,7 +2974,7 @@ bool mesh_net_set_key(struct mesh_net *net, uint16_t idx, const uint8_t *key,
 	subnet->kr_phase = phase;
 
 	net_key_beacon_refresh(subnet->net_key_tx, net->iv_index,
-		!!(subnet->kr_phase == KEY_REFRESH_PHASE_TWO), net->iv_update,
+		subnet->kr_phase == KEY_REFRESH_PHASE_TWO, net->iv_update,
 									false);
 
 
-- 
2.43.0

