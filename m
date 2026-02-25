Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011050.outbound.protection.outlook.com [52.101.65.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894EB3D7D81
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772036266; cv=fail; b=D5hHozjpYZ6MSzgf5wE5G93r6FyXTS1V3mexzbfZx9i9tGm/rT08GpLjYaMbvd31bypbamz4/wI8f2f9ELyg0/GFfVXZj6+UHnCQL7ix/IDwC2fZAI95pLAqt6ZniccTHN2uiL5c6oIhMarAx0KGgodJ7uNuWcgoYbLvaBse/vQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772036266; c=relaxed/simple;
	bh=PB0G9jLF3PhBPTUAZqDez/6NRnyxKTxyONJQZBVEdWQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hu+a342lT2IsWXXXU5h3DbjlXdy2uO6Z7u1zZk3XQ71313JURsqPbXc8rIJzcOO0g1ryZPfzoI69EtoFqjA3F4YJJ/oL/ILiGkl6C+bplhnsRhSxZgzNpi9s8S/M71vHTkp0W7xUVuftDYCEOqlwrktRviNeBhCeDzRRQLlD3as=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=o8IoXW2I; arc=fail smtp.client-ip=52.101.65.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="o8IoXW2I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qcn+FFLKOYNtvSWitH0z06v5u3OdBw7lxwbLNfSzE8qDLXeBQL5t3BK4MlFF1xKGNF9YOdxTwdmyNtO02lM9nRyU6a+cnN/0pU9UK9XWXQ52sFa2BwJeKZG8mMlG+EU/PPY9rbpqRdm1AkTq5Gk4/k7A0r/A+HDYCR9CUWfnc0mRlF7MoW4YIAkdGRAxLmeBFTvBeBqbMS0t+KFnFlgQ7Y9YaYsYtVqnPhYGDbIwrN28LX/LJ27h9Iirj+8U+r0jQFPjEcoKcpF4aSemZtsn+A0WGJzCHO629Zw2bjCxTDWPG4E4B0uiRgx6yjKZR3TLOUrrb0eq2XM2DsvrMdyWWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWEsg3sYd2V+bvG9o0a6rqiI5MGdWKNalLEGR8IvjCg=;
 b=zOpjWWdMVEtaCvCDH27DcrzGCvOH686VDVCUzVBOXaybeOlf6pgN/c7eM213Fw6dZjusPVQqqwnSB59ivMiU1xztainTi4qwZlx1qWaTOyMCuVMS2hcu4U8VdJZTImGO/FRpIfvTbdt755QAYVRw5/r+RYAn2mr9XZ7ZDFhDu1XE6/EX0DlwVBWNDNAbP4bvlDew84ecJP0Jw6MAXWJCgdtsbdYo7DuvmTPjazJQcIBbJTynmYjDQp8t/jbVE75Zj5ImoljiRRaZdYdhum3UQ0R3MpeqY/9FwhltmfNmcmclAKXL76zLn31MwUDCrvYizcOTg63cdBmmKoZryiwSKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWEsg3sYd2V+bvG9o0a6rqiI5MGdWKNalLEGR8IvjCg=;
 b=o8IoXW2IGl6Aedcop+MgjAmuexYvGDtbGKHOjHK/LnlKH6EXzcWZp0OfgT48DFBrOSG7pPbsUFxAmESyl+mBd8RupoFFEJujHd+JHJYechEVQqh3DrHw04v3YBFB7WEbsAiolIkwPALz528K7E3DsMf5xT8TgtOjREyW/JuM6ZI=
Received: from DU7P191CA0001.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::20)
 by PA4PR03MB7232.eurprd03.prod.outlook.com (2603:10a6:102:109::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 16:17:38 +0000
Received: from DB1PEPF000509F8.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::37) by DU7P191CA0001.outlook.office365.com
 (2603:10a6:10:54e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.24 via Frontend Transport; Wed,
 25 Feb 2026 16:17:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF000509F8.mail.protection.outlook.com (10.167.242.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 16:17:38 +0000
Received: from N9W6SW14.arri.de (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 25 Feb
 2026 17:17:37 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 02/12] tools: btgatt-client/-server: replace ATT_CID with 'shared' BT_ATT_CID
Date: Wed, 25 Feb 2026 17:17:05 +0100
Message-ID: <20260225161715.20394-2-ceggers@arri.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225161715.20394-1-ceggers@arri.de>
References: <20260225161715.20394-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F8:EE_|PA4PR03MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: bffb9f86-3f4e-4bc1-dd8c-08de748964b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	DW0Au+8STsZ8SsDEgIZaaBg+miS3K0Ld8r8ni638SlDB1SSGfjmrh2BRr8onwYw5VyGI9TvPENYAtKXCLvFhhvLt79niHbc5MJU/zkkzNFHaQNVVq131L7QTsOmDS3hwlcQmkxeQW1wLd5VmKq1MaHPCR20c6YmrjKdRShLZN86cp1i4YqjBCyw0jgt/BsKKHeJlR2wLgeXH7WoPso9fAMbSqCsb+y79eyj6GtXCKTPrs0JeWLTPL3Nu32RWz90x4z5Rye+zSV1nNsQXsxhPoGPNVzmSvZapBifOmieMNrBOqttKS9tPAqdja4FtBsYrDiinjBqJ3OW36j9B+nATlAhoUuFgA9sh+fgIPzexOBNsFpd0i7SeLRsdvpdVmcWU+O4TKWAmDjE9guEiE9nhA2vKsXXeg14SsjHoJh/PowBX3VkPG9aFAF1pcGt2Y7My58JYz8vHPMKvG333G3DIKyVW/Aamn9jUZPYNrDkgE4CqQn/d3NQS0SAykq9WmEzihnSAciF7XbZCuFAs928DJhD/HZvNhDYmGiX/H3vkj83+iTo3mCtO6ndRvsSNfPQk32Q106Gmj+T3zycOjDLKBKemR16+GGWpf87xNPWO+fFe4gDauJSyTFbgMqqKwtrWegq6/CYHqnE20PKQ+qsefqVF8etX1zHWkOD5896BJKILnZhZr16dTNQOEtgB1zI5KPgwjEl2jsRU5SoYyTBPzvU/xJxFjarXDihP2ywex7fbdO+x+kL6HiW1parlNoYXpXCQjm9Pga8ZIi8JPk+RKMe1mgSHf65p5d9lB3OqbOxP+9+iErFxLTJOHF1A7WCYcVNAV4d+jDypW7qrnb0BbA==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9GfEm/cfWRIdt+JzB1/cOgnXOJFOSfW1DJ9c2e6Qm0B6QhpKx24/ACrVxBgFkQkzwXRITjGKWwhAeRunC8CuNmBhWuB74n1P5pR3mWuSFStQZ02Pr4Vibjmtw+4Mr/q58B1zRCvG6xCfjfRVG2ZTHiG+TNjYzy4qPIlWalITwrXlprsNHpOxEql4IqR7HWdkNs5vq/KFgEWdh4uz2+L4xTk+exmDjgh6uIzJgals3DcJ8oP9Jtv7wyg+e8bUBc3r6J49WQmOV8/GoeIUOwjIpCg/sOaPKT9qvPuUeXmjmZyZKwwTdwotHI4WVLVsrIAXIQqdlnj4diOK1p8WvvWFAmZhz/kAhcRz37GurJP5ra4hISqE+yofpu21i9m9cj3cIE3iNFdlDrqYD7qsvPJORh8EXRwNF+CmfMSon9MK469tIMyUuqTrfXg2F9qKAG5y
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 16:17:38.1127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bffb9f86-3f4e-4bc1-dd8c-08de748964b0
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F8.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB7232

Avoid multiple definitions of the same value.
---
 tools/btgatt-client.c | 6 ++----
 tools/btgatt-server.c | 4 +---
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 54a3cc8763f2..667b3d651616 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -35,8 +35,6 @@
 #include "src/shared/gatt-client.h"
 #include "src/shared/gatt-helpers.h"
 
-#define ATT_CID 4
-
 #define PRLOG(...) \
 	printf(__VA_ARGS__); print_prompt();
 
@@ -1660,7 +1658,7 @@ static int l2cap_le_att_connect(bdaddr_t *src, bdaddr_t *dst, uint8_t dst_type,
 	/* Set up source address */
 	memset(&srcaddr, 0, sizeof(srcaddr));
 	srcaddr.l2_family = AF_BLUETOOTH;
-	srcaddr.l2_cid = htobs(ATT_CID);
+	srcaddr.l2_cid = htobs(BT_ATT_CID);
 	srcaddr.l2_bdaddr_type = 0;
 	bacpy(&srcaddr.l2_bdaddr, src);
 
@@ -1683,7 +1681,7 @@ static int l2cap_le_att_connect(bdaddr_t *src, bdaddr_t *dst, uint8_t dst_type,
 	/* Set up destination address */
 	memset(&dstaddr, 0, sizeof(dstaddr));
 	dstaddr.l2_family = AF_BLUETOOTH;
-	dstaddr.l2_cid = htobs(ATT_CID);
+	dstaddr.l2_cid = htobs(BT_ATT_CID);
 	dstaddr.l2_bdaddr_type = dst_type;
 	bacpy(&dstaddr.l2_bdaddr, dst);
 
diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
index 66523c1b3306..1690b0dd059f 100644
--- a/tools/btgatt-server.c
+++ b/tools/btgatt-server.c
@@ -42,8 +42,6 @@
 #define UUID_HEART_RATE_BODY		0x2a38
 #define UUID_HEART_RATE_CTRL		0x2a39
 
-#define ATT_CID 4
-
 #define PRLOG(...) \
 	do { \
 		printf(__VA_ARGS__); \
@@ -663,7 +661,7 @@ static int l2cap_le_att_listen_and_accept(bdaddr_t *src, int sec,
 	/* Set up source address */
 	memset(&srcaddr, 0, sizeof(srcaddr));
 	srcaddr.l2_family = AF_BLUETOOTH;
-	srcaddr.l2_cid = htobs(ATT_CID);
+	srcaddr.l2_cid = htobs(BT_ATT_CID);
 	srcaddr.l2_bdaddr_type = src_type;
 	bacpy(&srcaddr.l2_bdaddr, src);
 
-- 
2.51.0

