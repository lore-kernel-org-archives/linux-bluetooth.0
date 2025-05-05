Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012007.outbound.protection.outlook.com [52.101.66.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5551F91C8
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746449056; cv=fail; b=K5+HH9q7s7hSSYTkzoblENxkdCDUhlQupQ18OE0SUt5TAneBvx9H8f0b6/LUtFlOMmt5rkGwh7bNLzwcsRX1kblwg/NpTjHHD3W0/CcqJJwSFOQZtG0wqfWhq/4pZmT2sOPQ0KHgoQUwRyM+p0VK4V7SIZEGdl9JKkb04fnXU+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746449056; c=relaxed/simple;
	bh=s7ggvBGveedwsJu+zXZbT6D2cGnQbQnZJLyR8kY2sdI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k5v0KYvML78BSyKPo/4vRXGiGdqS82exe0kHX8KXE9c+dGwLDKf6EmTcqaVn82fCWEKG8eLHSrFSjuii4dCCscHTTiCBNd/AS6E/zwsiq1zFIQ0WWyxLdknF6E/WikpayNH9fsy13CXAN/O5TMq/+KSDt7VMjr8XfxsG5YRnljI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=C3sRcFHk; arc=fail smtp.client-ip=52.101.66.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="C3sRcFHk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t3+OymCglsfz+7ek+jllw0qPFdD+8UyeuQfjg5MRonDa+VsEfVyrM1BihBomEGUWbo6zm/SGo9t6DHkF9zcnSxvsKAtGRHj8CoxoG4sim+YZluWyKivMfhmwsPPxnTimxZ0PUW/C3MztWudnyk3O/9fBtpC/APugu5frxjl+LFeONb9AB3MzGm7QBaKmwsmYGYiD3jMzz70HDlnws3lKCm2Wb1qg9jKg3CbXdaM/RZRI35hKi7tgypeE/37frE4CfYlnPh7QGiJeVnrZLk8O+WXV9rz0adBzXvoSPG+qFYToGJPl04UcrD6ITGd1PHuK6JS6+Jg4abZpfiZrN9qfJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKsPj/IiSEW/YNgvGyi49qZEgt15gnIrrVCh+yCZtMM=;
 b=tNsi/OVHvIB/Jv9eMrISi72GPBBWm2Hsl1cOWiP/Laf6wcRoX+FPKAEwU7z74o1o0RUDib9kmxhbethbhY3plHK9t8ORNFfrk62IlxpFPgkQ7NnW+U5p29eGbGuWWmsjXAPNMqPdqHIOyQbrcrB4nk2DH2XQZnYR2vAAaZCXQXE9jMEuRnoQfR38QFP5VPi6G0AIxtmqGU+1cxdIX6spZK7xy1/AeEmInNK3fh4UJBW5vwFgHw5bn7ne0T253EmPKN2QOvNcDS5GMmjPnrRsNwkIKbOIhaLZjcjJbQCgSUzDNesv5jvoo6ezwmzwRcC6RdKUKFWy4RpGNWHo/fk53A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKsPj/IiSEW/YNgvGyi49qZEgt15gnIrrVCh+yCZtMM=;
 b=C3sRcFHkURXO8d6yqA+3PiMr914xu08BCR2JE35VuQQw0QUSkJVQefJnu7xpQSmj0JAeiKZsbJ/VIPxJ7MLe2RE5DJCXnbuZ4smYtTur0Jee2cCX7R4DMwT9HRh8y8/ky2HmMf8yWW41C28hQmIVl+54KJI25S/6v2Z+pBATUCY=
Received: from AS9PR06CA0070.eurprd06.prod.outlook.com (2603:10a6:20b:464::21)
 by DB9PR03MB7225.eurprd03.prod.outlook.com (2603:10a6:10:227::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Mon, 5 May
 2025 12:44:08 +0000
Received: from AM3PEPF0000A79C.eurprd04.prod.outlook.com
 (2603:10a6:20b:464:cafe::f2) by AS9PR06CA0070.outlook.office365.com
 (2603:10a6:20b:464::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Mon,
 5 May 2025 12:44:08 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM3PEPF0000A79C.mail.protection.outlook.com (10.167.16.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 12:44:08 +0000
Received: from N9W6SW14.arri.de (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Mon, 5 May
 2025 14:44:07 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ] monitor: remove redundant hexdumps in Mesh Provisioning
Date: Mon, 5 May 2025 14:43:45 +0200
Message-ID: <20250505124346.6621-3-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505124346.6621-1-ceggers@arri.de>
References: <20250505124346.6621-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A79C:EE_|DB9PR03MB7225:EE_
X-MS-Office365-Filtering-Correlation-Id: e8b0ae92-57a0-44dd-3109-08dd8bd28719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BeuObqnsjvBkwO9nOAuju7B/G9nYH79mzxYDbuWUA6CW60y12OieiHFMmYO8?=
 =?us-ascii?Q?qPw8LXWIWBKJ1Pfz2VDBS+Cj9hF6PSn5LIh+W4dX1iJS1+UkqDNXI9DUrt/9?=
 =?us-ascii?Q?9PuhAHUPaiZR4azPRjsontbsM4fqhu6WB4gIY2nuUlg9PCg3DigYYDYE3YBb?=
 =?us-ascii?Q?JhYiygBLCpkkkl86jx4x/TU+3KWcaEBPDELRpQMlmBPt4di2XO1AIXBLabLZ?=
 =?us-ascii?Q?K/Pof+Gd06iynlOVrIt2QN15fghO+iZ2xfspAgDdFGAMLy/VjxmuxT5vQ/Of?=
 =?us-ascii?Q?m9Tzty4h5c1cpryPy6EJ4psmOi+ocz51CI+eBJ0zanluZZYaeyPnmXpEj3D8?=
 =?us-ascii?Q?q0TYm4VHj+10pdxGePgr+jzA4hL9KBLixo8lnnNQoTnbu9xLjNXXWY/BGkNs?=
 =?us-ascii?Q?XcG0l/WETETOLVbUZ1xkFQJ0hahHlpAEWgJUU1eUZtNI9YjEub6s+6qxj1Fx?=
 =?us-ascii?Q?+scHskXdEI+ex9o3IliQCOOnz+Y9TZhJIrxAitVzmqUDx24gmUME81hJmusL?=
 =?us-ascii?Q?Tczh53IVfbiHqWzbsCigxabnHjkmDwFTEK3VkMwEpKSC22EeB9tUSrmlOVgJ?=
 =?us-ascii?Q?WtKnb5meFSZo2KGwUru0fT8LFbn5zOe6+4q7JuTpa7AZp6I/+ybGONgC8c2m?=
 =?us-ascii?Q?LscuAYZl07Bjq/IF2+waters6oDrBQoNepo/WPMOz5HqqtD0v5mdSz5B+6IZ?=
 =?us-ascii?Q?uLDDBfwWwzIKwXA9J4DJx1Ol5f8J5tR+CgAuwjh4wcFi2CAwTDhS4J5AAOPV?=
 =?us-ascii?Q?5lVcosSfWUg374ZqCL1uQZ8f335yXRX2U2MregCdGmlEseKR4dMil2ev4EOl?=
 =?us-ascii?Q?V2zE4Gavc+n5a4XuLTa9wg3OFQJd4k07S9wGDNDe4Bu+9sx0GS8WHa0lGD6V?=
 =?us-ascii?Q?Ss0AXPTUMZ2DzPNhSUEA3nfQ/uOfWdzw2NRMUcUDxHTfq2PC4UTFqOXEeCqm?=
 =?us-ascii?Q?uWMmkO8rOAjpWI6A85aqIRU6DC9H4WKfLiF1XA43R8B1NKQlinT+jtYgSyek?=
 =?us-ascii?Q?LMjoz5IJqMkth1W4djg9GvfxT+VhHAgwWrTteU8ax3kBdRrDvUUZQ971mrVF?=
 =?us-ascii?Q?Q21NE+DtsOIj+Whoxzb3RhQl2VKI/TjMs09kopBtJ50QlKByrSdLmEVLJh6B?=
 =?us-ascii?Q?hQm2IC1e8QYFpGE199LBK20meajobYc4iRx9azqA4leitA8vaOHM8L56hTXS?=
 =?us-ascii?Q?NmNUkb+719jy0t11HWZhivYH13vrXtzC8AnCzL3sEtpK45z2wHW51ZYM53f2?=
 =?us-ascii?Q?BwKIpcpfM4ozYdluXGOR9LFXx/WioT3RkQ1G27H/EOrpRIZLJyXRAxkomq7y?=
 =?us-ascii?Q?VPnD7uDx8EDMYNNrUV/l0i8+Ifilk3idJ8rA5+XypGdYe7ba11RgkTwY9ldo?=
 =?us-ascii?Q?UIJ2Ecb4mS521025Fo/FYxfmClp6pxBmYjtBtnd1vinqbm2f+kpq7C4MlKne?=
 =?us-ascii?Q?yKliL5O9FVb2KiRXF4vT6ZP1rs61nUWApYTEMvCxPWCRYmoEOEwmK6NOioy/?=
 =?us-ascii?Q?X0GiM7n+ul3X0TyLMNbBULLKfFC7e99ko4yF?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 12:44:08.2035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b0ae92-57a0-44dd-3109-08dd8bd28719
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A79C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7225

Paket data is already dumped in the statement above.

Fixes: ad0cdbc1e943 ("monitor: Add basic decoding for Mesh Provisioning")
---
 monitor/packet.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index ebd095ab9056..e16af112feed 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -3689,7 +3689,6 @@ static void print_mesh_prov(const uint8_t *data, uint8_t len)
 		print_field("  TotalLength: %u", get_be16(data + 1));
 		print_field("  FCS: 0x%2.2x", data[3]);
 		print_hex_field("  Data", data + 4, len - 4);
-		packet_hexdump(data + 5, len - 5);
 		break;
 	case 0x01:
 		print_field("  Transaction Acknowledgment (0x01)");
@@ -3703,7 +3702,6 @@ static void print_mesh_prov(const uint8_t *data, uint8_t len)
 			return;
 		}
 		print_hex_field("  Data", data + 1, len - 1);
-		packet_hexdump(data + 2, len - 2);
 		break;
 	case 0x03:
 		print_field("  Provisioning Bearer Control (0x03)");
-- 
2.44.1

