Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013001.outbound.protection.outlook.com [40.107.159.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBB822578C
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 12:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746449050; cv=fail; b=L6tQ9bCWBKl9hcQ8zUMBYe6nvfwTBUoEfIUInxBlAO0MDj6f80C5Zw6qG/eM4VmcZ7mPcLitA1WC4Mpd4pM9fM06qdv7subyWUyWkyT0auYAQsE+nICxUsRNs3jlnE7N6LY2aNSbDhyXDiDKsfnpT7Zcix45XyH59XoysRVNwTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746449050; c=relaxed/simple;
	bh=iHJBIGtT3M+AcL/L/FCHzQOrr0ncHLjKLyP3iPz0z0A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QcXkdpm7OXo3Sw8m5cgXV4yuu2aLvgLILCDw946R+DOhIYbjrJZu98q4ZT3aBafQZfH6cippnZTFf+pPZqluwl21uF7HSBflWbHh+VErz/fOSeoR/N0c1UqdODv8D4koGXZ057WeGraMSSXeXGTVV7KkkykZLyt7N+EcGPSR79g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=XShK5sXn; arc=fail smtp.client-ip=40.107.159.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="XShK5sXn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJYQHQcE7LFe+F6k+JLjOr2z6VPBOIBCVNn3kOMCbLMLK4QNqGX0YQehA0GpKvOSe/VRCIu6XDyvRVoNtP0GR5mQrW6Ei/eLaB5LMfkHlKjT0Mr4X5vhsyZpMGl6aWZ+2YhvwA002X3oxqYSNfVgfsIS9/OsQvkAztolLUFTUnZggpy1cA1ePLFOKRjdY1rjQSNfuUZGVNbwDKTRQQSU5sXq/3O5gg4mUtv9Ko6pPfkuYV/h5Y9MwKB1iYYT4l71Ti1u6a/VYslr2NJ7eZMcofTT56dowkmCafmxbwPvOAwigY4ezU5Gqq/QeCIjpbsUlULR+9a6cl+/uARH3e0N2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37lBgi5Bpk6TpoZDNqSZmp19p3Y1pdA6e9FQiLDTgTI=;
 b=pdg8Tyu629PSwAI2tbFgpLII0CMjxbXE9KbyoCFheAP9BHaJuE16xmsP8bj1hg7u5n4qB+qXPYz+D1l6g3O72v0pfJ/y+fMcSeEvzK8aIjDdn43JUAGnJQlT7K1Gs2FFqCQUO0QLGOBzgTw/+KzG1MSNV0OpnsljNGmeqChb2ZqqVc+7cYX/5wTva3Xfc9V/j+SmqYlEP/ufRznIsFml6g9paZuB7EYrC8CYTyZQy6iSPV5b3amzPzOJQsIqN5np+9MaS/qHP1DZFT9eHpnpkUarHdSBTSFpB9CZLoIUcy/wHnMn+5tFolQY+fpYTveGzb3hqrq1qB7nt6HpsODmCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37lBgi5Bpk6TpoZDNqSZmp19p3Y1pdA6e9FQiLDTgTI=;
 b=XShK5sXnq9vGlttKm3Tr7NtFAg5dMSthVmIiD/7cm7Er638Beh3LdxfrWtLtZzfXA/X87g6THZvxTTg/bjIwUVy+d0KIli2LRTED8cO0vSimCUfBCWW96FNjDBhFZeJM86ck1/gVBsIeuZCfu78/sFLwRUqFu78A4HquRUFtqyw=
Received: from AM8P191CA0003.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::8)
 by AS2PR03MB9073.eurprd03.prod.outlook.com (2603:10a6:20b:5f8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Mon, 5 May
 2025 12:44:03 +0000
Received: from AM3PEPF0000A79A.eurprd04.prod.outlook.com
 (2603:10a6:20b:21a:cafe::86) by AM8P191CA0003.outlook.office365.com
 (2603:10a6:20b:21a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Mon,
 5 May 2025 12:44:03 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM3PEPF0000A79A.mail.protection.outlook.com (10.167.16.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 12:44:01 +0000
Received: from N9W6SW14.arri.de (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Mon, 5 May
 2025 14:44:01 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ] mesh: agent: add hash calculation of URI
Date: Mon, 5 May 2025 14:43:44 +0200
Message-ID: <20250505124346.6621-2-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A79A:EE_|AS2PR03MB9073:EE_
X-MS-Office365-Filtering-Correlation-Id: f6b31e3f-1c9d-4aaa-4bef-08dd8bd28328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tLAH9otZcPBulEuwXbt+fZKyowcEJOZL0JW+47X+to8VhCyTezddlakBQ6Xa?=
 =?us-ascii?Q?Q6CAuiVb1aMgducaIy7ngaJNrE2/sUR7Jctonr47OJhh4TvwuDiAhu0yF68l?=
 =?us-ascii?Q?eEpHaGjpCoL6Q8/ZXvlYKoTuOeCkDGeZZVvhjhFjTSKSRZKoloOI8aoASrER?=
 =?us-ascii?Q?7g4tkOKzQk/kA9k6VbGviOABrVo2Ov/4PMHnV7YA6DEpMrLwy6xF6/WiNI3F?=
 =?us-ascii?Q?hshvtKBxNtk56Ozw8SrwCFPIwoLxiSA4c7D3T/Yb1jTiP+cemlGn9wxIcV/q?=
 =?us-ascii?Q?XT2IfUkzsSM+ga9mkTvt9M35VMO3STuNdvRoxbJsxyxgZvyaPmNu7lRjAOXX?=
 =?us-ascii?Q?s4/qPTfD8PBCucOEgaqlSQ3EKdW5EgsaqBOavH1+iIr+kNrPoBMBd4qWXiOh?=
 =?us-ascii?Q?EvasmwU5c+lem2jFkLiPTM6sf+NR6v1tEnTEzo+zgb6ogs7LEENeH24HcDMJ?=
 =?us-ascii?Q?5JOt7OVF/FiyzYBqpmlONNG+vOrKAS6TF+q+ii79yA8dNZaJVMzeH0J5EGry?=
 =?us-ascii?Q?oEw6cJtp4uAmyKDUvrgmstSprLHRHhAmZlz0yTIOKbC5hlWuDUfWZaaD+xnq?=
 =?us-ascii?Q?R3+jUW2SPfSZfhOcAmLspOjOSlZChQFqHKp7ZcXQq4qvdbYngDUnjdVcBwOp?=
 =?us-ascii?Q?khUONyaUeE4reyrC6rgfArcCVh16DwlGlE/zkj7ArqnVFSntD9FnHCkmepQz?=
 =?us-ascii?Q?jq04EPigcVhp8YEsz415U0DAyDGKqJkI/+YdU3wxYWSZMc0Z0bAKFZ8EQh/q?=
 =?us-ascii?Q?nspzagTgGkuxEkgFJm3pSyZQH+FXorFjKzpLtwaq+yc35WNoXKv3je5U8eA6?=
 =?us-ascii?Q?9K1j67qfhL7TZf9W8fbTIReTpI9Fqshp4qPsjLJVzo21yYHSNcpGUzLavRjT?=
 =?us-ascii?Q?ALwXtcpk+d6f1MLdzV/0NoJXi/isLBtGUipL5xvLG0pCl2Qk0apIJ8or0Cbh?=
 =?us-ascii?Q?VXML3DGgOCpLmWH073ZPrlJaRD77/W9nwrPLg/NDNv5+rahrCV1s8Zpv+OT+?=
 =?us-ascii?Q?WmlE5a33T0UTcZqsv+GJNnCpnStgfOfkAuQsbUCijf3bF0z9xjJvx/42Ftgm?=
 =?us-ascii?Q?2ZNernMF7JdT058WYyybCeFHTKbtJQKrtKE5kzT5X4M0UjscanQl8aqoH68k?=
 =?us-ascii?Q?A5AdZGVzdlUvtfBQKVg7clRnYntPlPTcQxpBwSuPkKxN9xZ1BAyXAOUFxIuY?=
 =?us-ascii?Q?fdWBV2EU8lhLVeDNCJQdU2Yd6yMwV1LUoLkC7RVtDAi0vYLAJmcxLTncEK5k?=
 =?us-ascii?Q?NJZx5VFZhn1ARbdujh+Y+H1xe04/lWZuGjTGyo8NqWAn0SXugVHKmPiUHdJm?=
 =?us-ascii?Q?pTJKqp7JIXLV+D0F0CXkIaNUGlKtL7LXcXKJJ6GSMsLCnpGfROcYMwwLrdBf?=
 =?us-ascii?Q?oDG9c5t67GK0u41pqZZeuFq4V++1CFy7h/eqKQt1y+oOpWFLHEDJJqRwasOv?=
 =?us-ascii?Q?LCvijQD36asTQFl/ZKiXV4yJEyOQdpJRXJJ7We9/9RyrLPsaM0u4ilNP/LHT?=
 =?us-ascii?Q?QGnMj+f/XUXYWNvypg5tyqN1LQB+Skt82h2E?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 12:44:01.5913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b31e3f-1c9d-4aaa-4bef-08dd8bd28328
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A79A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9073

Mesh profile spec, 3.9.2 Unprovisioned Device beacon:
Along with the Unprovisioned Device beacon, the device may also
advertise a separate non-connectable advertising packet with a Uniform
Resource Identifier (URI) data type ...

The remaining implementation of this feature does already exist.
---
 mesh/agent.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/mesh/agent.c b/mesh/agent.c
index a1413c0008dc..86f25ac96a11 100644
--- a/mesh/agent.c
+++ b/mesh/agent.c
@@ -16,7 +16,9 @@
 
 #include <ell/ell.h>
 
+#include "mesh/crypto.h"
 #include "mesh/mesh.h"
+#include "mesh/provision.h"
 #include "mesh/error.h"
 #include "mesh/dbus.h"
 #include "mesh/agent.h"
@@ -168,10 +170,19 @@ static bool parse_properties(struct mesh_agent *agent,
 			if (!parse_prov_caps(&agent->caps, &variant))
 				return false;
 		} else if (!strcmp(key, "URI")) {
+			uint8_t salt[16];
+
 			if (!l_dbus_message_iter_get_variant(&variant, "s",
 								&uri_string))
 				return false;
-			/* TODO: compute hash */
+
+			mesh_crypto_s1(uri_string, strlen(uri_string), salt);
+			agent->caps.uri_hash =
+				salt[0] << 24 |
+				salt[1] << 16 |
+				salt[2] <<  8 |
+				salt[3] <<  0;
+			agent->caps.oob_info |= OOB_INFO_URI_HASH;
 		} else if (!strcmp(key, "OutOfBandInfo")) {
 			if (!parse_oob_info(&agent->caps, &variant))
 				return false;
-- 
2.44.1

