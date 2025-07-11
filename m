Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011045.outbound.protection.outlook.com [52.101.70.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8D62F19B3
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 17:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255850; cv=fail; b=MJylN6Nvyz/qF6Ev+oOn3ICjivVkHZI937FQFLBC36dazRx2aEHHqTE/3RoRtoyhh33rqHL9fIbkpLXLh84fotnP7JyNvay0lkao5/ymvaUacZkoP4WwImRJ4a8+a5P0C/x8ebGfl7eiGj25TDtW3OFeubf95dRrE2NLXsChDR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255850; c=relaxed/simple;
	bh=r/QgVBy42rjrnEG6GcJVuMvHTNY36fysrxA6hD+j3Xc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MGzJ1elrWnrRW0pNeIqDezAHNhCVHD5ChkGXKsQD0fb8W6Ho1n0wemVrkJOk5l8DdojW7/suC3nzERvn+x9NIdpqwwWj4+1zTFuZ6iwiM9mrw/Dwo+EbbzcG5eQ0+QN7QiARTVrX8NVzv7ZLLKdysQ2UlgJ4AEdJKCZnphTK+90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=kSNOoaoQ; arc=fail smtp.client-ip=52.101.70.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="kSNOoaoQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EA+Bc/GWhyWm62UALwV+v8IZ+F5+AzvAxb+HjAtUetrbHt7UqlRLgtNigsHt00E3dqkf5ItWVcXCTJF6ve1iJuAppzz+kgVU+ra9wLmKKocvTL/qI4kZFNGNjJgi3xH/XPBmzIMAnKK9AVVNklw3p3CM+goM2PxDx3RsHQo6Uszs9eIxHlBMFgTqbSP4U8Z29SxLZtImPizI/XT176XNp8O3uPTl29KHdYEQl0dw7+JdT1lcd5hlN/PPefktlO/PMHTTytf5dcKxZAncYnbc8oFB7gBUuHBsETyjBZwpBP/ARQjQ6/fnX5sxa9sFe4Iu/72it7SiZBvDRlomsmBacQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/iXuJjToz0x9XbR3dWHvhQKKTSkRZeQHN1FxWqnQA0=;
 b=q37fGaAPuuARKwgsyOd/wBINAHRpaypZh9NAC6JLLQDT585ZuWpWqY8LVdwIDzEaU35cwaEIpx9YJsS7Rn+Q3LRWPcAo1wxW4JYdASPTzlCI0CKYB0UGJksmBaFEqoja1y+jJp12EHUhgNaz54RZ59LnZMfGpFvEnEhoYmJnLJ4P4Toqn4U07E9SEe6+trig1pjepiQK/08P78tO9A80zycHKgX+dDAUPoVJmMtu8VccGKUr/27O66yNCgxXxZEyYUcM7ODSLYx5ObFt6Erk1qaQSJIy9A/IKZPcwe4J7YI9a1xRFTuH0Wnz3oqwt6IO+0P/3mjmcRuvPs6rZSWHkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/iXuJjToz0x9XbR3dWHvhQKKTSkRZeQHN1FxWqnQA0=;
 b=kSNOoaoQ/qPCw8BuPC96hGZZ46mqXMdQN1mjfva6vD3kDDFa52Nn4gD21kWJok8n9whb06zUXk/7GfxUmMiy9uUz6+GYvQza6DtXO41D8TefccYZvT0mXALAjNfU3DQNajmea6ss+oLGcPrNga20LiAs14sdZ14GdZ3ZCtTlymI=
Received: from DU7PR01CA0035.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::16) by PA4PR03MB6973.eurprd03.prod.outlook.com
 (2603:10a6:102:ec::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.33; Fri, 11 Jul
 2025 17:44:04 +0000
Received: from DB1PEPF000509F0.eurprd03.prod.outlook.com
 (2603:10a6:10:50e:cafe::7f) by DU7PR01CA0035.outlook.office365.com
 (2603:10a6:10:50e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.26 via Frontend Transport; Fri,
 11 Jul 2025 17:44:10 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF000509F0.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 17:44:03 +0000
Received: from N9W6SW14.arri.de (192.168.54.13) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Fri, 11 Jul
 2025 19:44:02 +0200
From: Christian Eggers <ceggers@arri.de>
To: Brian Gix <brian.gix@gmail.com>, Inga Stotland <inga.stotland@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 9/9] mesh: fix corrupted relay packets
Date: Fri, 11 Jul 2025 19:39:25 +0200
Message-ID: <20250711173958.25689-10-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F0:EE_|PA4PR03MB6973:EE_
X-MS-Office365-Filtering-Correlation-Id: 40621298-b688-4e04-4baf-08ddc0a28695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4sON9m0qtzCnEtP6iaobJv3SD/AzUhY+kFdkBni/XOHUh5ApIa+ye1QuxXBg?=
 =?us-ascii?Q?Yn0lUciAVf5OimwC8NxSBWPwz7aUzXQ4Hmmv/Jx+UkaQLArExnqrHx3Ou5Sg?=
 =?us-ascii?Q?xg5tH14KvgaEHlZC0fKV/qxLsXzPd5nW9w0HAL+mizKRfuAgkIg+FsWn3RoK?=
 =?us-ascii?Q?XMXwE32Ie0tFwCA18idX4doT6eThCjFYt+jueF2VFjKDdSnslg+jkIpa4mCb?=
 =?us-ascii?Q?fmw2pFMDluzHdwLWnec034XJSLZCJiKH5U9BKx5IX+gG/c5zkdxcTtSsCG4s?=
 =?us-ascii?Q?KaaTV5c8gr5k5FYBJp3iuGVZnwPEC2Hqu9xVGHLxgN2JDgcY/x7zoklllsjh?=
 =?us-ascii?Q?0VVSYW7JiUBOU6wQ3e/8XFGKEPbOM/89eBzwoeKdbO8MO+QiJjkRlQp7cRtd?=
 =?us-ascii?Q?iAaqevY8rWpV2X4Qo4yRARSMXRXHL8PNRzd+uEmzUmWTzJCxbdWvp85rdlp5?=
 =?us-ascii?Q?gSJh8t9hZdt+KZDm8e+znowt3vKoXB6BxIpAJcuB60lKVthTe2UiAX7rkYsF?=
 =?us-ascii?Q?KsgvPl8MWI/9S9tCKcn13FjcOtsXmWVC00zDRoUSe4zOUkkvZ2584c2GT3Y5?=
 =?us-ascii?Q?5EWTJZcestv5sg9tx5mIKKvU/bpit9xkWuFQGp0cS+rjVhWIckqqsth7lP9J?=
 =?us-ascii?Q?AIU+Jqa7iEJl86gzJGQSRFHAr2VEJu9L/BoirxwOqS5BOGvp6wRzboy5n8fW?=
 =?us-ascii?Q?9G0r9M3BDM6f3lRJbp9cFyLJ92/PyBPKIK4VYv5uKAdoocS+NTjO5tOVIQzE?=
 =?us-ascii?Q?zqikzsSe2RitLRDQJhUvb+kcb0EpC9HTVyjqvD2lb4SCT1kY5J7s2ErjF3Aq?=
 =?us-ascii?Q?xr9kCyjldPvxAorLS8jpSCJKbYEa3cr7kot7DW1/eT7zUAciDHKdXQBJrf4g?=
 =?us-ascii?Q?xgw4D+zpiwHELmvjQNTxaP6wpFYCwSlz+9M6pAPE16vY4ygXbekPHIttmuzE?=
 =?us-ascii?Q?5Sf26PCceWuI/m0+MY1a6JbP0hRgEJJci2tdC28wIhAOVaZj5Ub+TF+tIgdS?=
 =?us-ascii?Q?lLp9YtcXnJ1txQaz6sn2D/vx07zkktcWp/EyrfzqGYUB60RTPR75YCnl4QKa?=
 =?us-ascii?Q?85eIdUsbn1XkyIhrCKpHRp3pUN12JMCDj1QLlfb4wTnlexU/ft7NIOhqjaky?=
 =?us-ascii?Q?65FTj2J8LP7LPXMjJAfPAZQ7WcxbhEI8w6BC/Jy1WwRIgsBcy0BHkmeaiyl3?=
 =?us-ascii?Q?G85r493eaD0ONzUomTHz6spedVFsXFBdokvaFH3aukaWdmVf5dbFwrhG2huV?=
 =?us-ascii?Q?vdCWvOWTHwdg20UlhmkbVOEj3iCY8HMq90BQYDYWkX0webGNL0P9BFgX4K4F?=
 =?us-ascii?Q?S9xmm+bSiOuabSUybhkoHaDBJwDEnqhmunKDXvxRT2G++jFHKmG45sCwASGq?=
 =?us-ascii?Q?EYyrXFUIGXOZJUtYYM3E3S9NOeRdtR1aX1DCmFF5WymBcgnDUzw+3vRvqQ7U?=
 =?us-ascii?Q?FYFZS9hJKr1bZ6qNyT9pp7tUHl0TkKl+GBtgfCH5Vlv9M0MsVUXxfX/EmuFb?=
 =?us-ascii?Q?Ozotslyaod4zOmAGJ8Z19ZKuEW4FYGD0W2SF?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 17:44:03.0911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40621298-b688-4e04-4baf-08ddc0a28695
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB6973

Currently, all relayed packets are broken!

At the point when net_key_encrypt() is called from net_rx() for
encrypting a relay packet, the packet size must include the NetMIC
field. But the length of this field has already been removed during
decryption of the incoming packet (by decrypt_net_pkt()), although
mesh_crypto_packet_decrypt() has correctly reset the NetMIC field to
zeroes.

Move stripping of the NetMIC field length from decrypt_net_pkt() to
mesh_crypto_packet_parse(), so that the field length is only stripped
from the payload message (but keeping the field length for the network
PDU). Additionally add extra length checks during parsing.
---
 mesh/crypto.c   | 21 +++++++++++++++++++++
 mesh/net-keys.c |  5 +----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/mesh/crypto.c b/mesh/crypto.c
index 3dcf226ad8d3..451be81d2fb3 100644
--- a/mesh/crypto.c
+++ b/mesh/crypto.c
@@ -637,6 +637,9 @@ bool mesh_crypto_packet_parse(const uint8_t *packet, uint8_t packet_len,
 	if (dst)
 		*dst = this_dst;
 
+	if (packet_len < 9 + 4)
+		return false;
+
 	hdr = l_get_be32(packet + 9);
 
 	is_segmented = !!((hdr >> SEG_HDR_SHIFT) & 0x1);
@@ -644,6 +647,9 @@ bool mesh_crypto_packet_parse(const uint8_t *packet, uint8_t packet_len,
 		*segmented = is_segmented;
 
 	if (*ctl) {
+		/* NetMIC */
+		packet_len -= 8;
+
 		uint8_t this_opcode = packet[9] & OPCODE_MASK;
 
 		if (cookie)
@@ -660,13 +666,22 @@ bool mesh_crypto_packet_parse(const uint8_t *packet, uint8_t packet_len,
 				*seqZero = (hdr >> SEQ_ZERO_HDR_SHIFT) &
 								SEQ_ZERO_MASK;
 
+			if (packet_len < 9)
+				return false;
+
 			*payload = packet + 9;
 			*payload_len = packet_len - 9;
 		} else {
+			if (packet_len < 10)
+				return false;
+
 			*payload = packet + 10;
 			*payload_len = packet_len - 10;
 		}
 	} else {
+		/* NetMIC */
+		packet_len -= 4;
+
 		if (cookie)
 			*cookie = l_get_be32(packet + packet_len - 8);
 
@@ -687,9 +702,15 @@ bool mesh_crypto_packet_parse(const uint8_t *packet, uint8_t packet_len,
 			if (segN)
 				*segN = (hdr >> SEGN_HDR_SHIFT) & SEG_MASK;
 
+			if (packet_len < 13)
+				return false;
+
 			*payload = packet + 13;
 			*payload_len = packet_len - 13;
 		} else {
+			if (packet_len < 10)
+				return false;
+
 			*payload = packet + 10;
 			*payload_len = packet_len - 10;
 		}
diff --git a/mesh/net-keys.c b/mesh/net-keys.c
index 0daeb9209b86..98e6d23d3f87 100644
--- a/mesh/net-keys.c
+++ b/mesh/net-keys.c
@@ -238,10 +238,7 @@ static void decrypt_net_pkt(void *a, void *b)
 
 	if (result) {
 		cache_id = key->id;
-		if (cache_plain[1] & 0x80)
-			cache_plainlen = cache_len - 8;
-		else
-			cache_plainlen = cache_len - 4;
+		cache_plainlen = cache_len;
 	}
 }
 
-- 
2.43.0

