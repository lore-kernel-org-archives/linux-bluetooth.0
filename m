Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011052.outbound.protection.outlook.com [52.101.65.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FC73C01
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 08:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751011310; cv=fail; b=aBefTVhuCLPzmzBrWalFG7VDyzC5SobF5GPc+Og2w3iCL+9UOqKA5UGNXNwIt+o6mA/jjotaVlY0Zytq/nelGeT2sEQP/zs9xvtN1sKhq/mrybIJQVFBtHraywdDmXVF1eozwHHX6zxLKCn7bQNJMkBmQr5igl4OZmOGh1v6mn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751011310; c=relaxed/simple;
	bh=bZOL6s3sFBloU5lVkOscR3M+tQnRhrP4mSs8jEnEf6U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TslZfgz+9DQggxdR1azCyfzH8XvFDQdxb+JsCrfpbVEhd6EbxjSX+/gg0ZV6UpsVKwxY/HcFplby/whSKE6/1sp26XBbDMt7kO/uw4ErbFPJJuyK/eXs1Q7dC1YHETYb5FC8DKOWvRq/mCtoqa5ENz1vUVYmCXQ0Elg2e7syv08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=PjyU7mKj; arc=fail smtp.client-ip=52.101.65.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="PjyU7mKj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhAOT3JogxaOjGCTph+WvIL31Mh6dBe0/9XuIBBRY2Y4hcdRedAkxedEcl64VzisWvby/X3PwsSTNpcchF6rbN7+3dNYq23e6A5kRxrHarOK9u/mnnwLWVJ0WGddl0as7tYvayJ99XGa/hAVA+JLHDT0gkPlrKyHp6Jv7aP/knG+TsNcodeql7/3KonN2YPjweWvXQCGUFd2dV176fu3lgEu7Durjxsv+IcxRzGcz7ttcgc3DaVNxFy9exM+dAHez2AdLUZiEtmPVz6McsZ+5/wqvhp42gjOg5y8prxXcIh7V5EX/F9JPPJTAKPiQABGGeteo+A34kFgxrqwwhsqiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E56JCp+eenavz7kCfxqjUGgxuKkfR7kk8sfg8U5n1ak=;
 b=kVUbmxmyj3yO6ayy0wRYPpT8KFfoxUGM/t4UtAHdurPKhm8f3qSDOBd/JJrqyQKMLy2bDUhO+B4LUwQHaEn1HBXfe6RxaLdYQpZqOfMuUoVuRzgE8URU+0cbsn4qb7Vjl4BYeT4DeCT/TcNcvoqMhl7TDNWgQoOgQkLWlEn/Bdeyl2yvUEAHRLlaLYs0xGEFeUyxHjHvbekCy2RshdjGsyZ+eWnEpxciR8Phi6K/QRi2puJ/pibyGN5wtQ/yDH4zsG7Vm4S+JvHvnFtmM6RcjLK4QbRcVZzyPVWPBRRho/ii6N/by7VXf7Ork7dl6svWhSYBn7luxbnvum6POlOqtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E56JCp+eenavz7kCfxqjUGgxuKkfR7kk8sfg8U5n1ak=;
 b=PjyU7mKj9FXg0ImdpZ4leBFeJfrR7s5Z6wVDAla0nI7VjXjlVvf6qVJu0i1OxvF9xkAmIaRgluTU9GW0is/BMZDYGz6ZzaK7+I3AtVposqQGg+8Lfr7oFs5bTxpKmFXgKJQZ1tmp8+kod16YYZqGsXcld22MGIRmCaFJl5ipOtQ=
Received: from CWLP265CA0433.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1d7::19)
 by PAVPR03MB9750.eurprd03.prod.outlook.com (2603:10a6:102:313::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 27 Jun
 2025 08:01:45 +0000
Received: from AMS1EPF00000040.eurprd04.prod.outlook.com
 (2603:10a6:400:1d7:cafe::d7) by CWLP265CA0433.outlook.office365.com
 (2603:10a6:400:1d7::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.19 via Frontend Transport; Fri,
 27 Jun 2025 08:01:45 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS1EPF00000040.mail.protection.outlook.com (10.167.16.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 08:01:45 +0000
Received: from N9W6SW14.arri.de (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Fri, 27 Jun
 2025 10:01:45 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 7/9] mesh: remove unused function typedef
Date: Fri, 27 Jun 2025 09:59:26 +0200
Message-ID: <20250627075928.19788-7-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250627075928.19788-1-ceggers@arri.de>
References: <20250627075928.19788-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000040:EE_|PAVPR03MB9750:EE_
X-MS-Office365-Filtering-Correlation-Id: a8d76d3d-929c-46d2-9a15-08ddb550dc49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BXB/gG2HMWVWSLbsApckHIQhNMeUE0azueyja09MAl4ZQGIIVOw1+lFIk3QG?=
 =?us-ascii?Q?NshpIoTpA4km011pmQ2ANRrCoEZYFIc0FPt+6We2Xro1Vckl74Bek2xxGHCh?=
 =?us-ascii?Q?Fhi8SC3Btsr71y2lvtwrrM4uO45LlLllNkzYjExrzgS9NJejOcRukk8/trr9?=
 =?us-ascii?Q?Kz5IxP+Vn8gn8Tx0zZs4GLsI4E51tXAmDggyngMmdhDDpOokzmqtlGx8zFOJ?=
 =?us-ascii?Q?h6OZ56h6vzCbl+9gBPasYLFlqUOA+aBlG5SNcd8q6FBCBQH4a0BJrlAmTyHV?=
 =?us-ascii?Q?8z2YqVc4DtSt1Gb7Cz6nBj/naA+4xDQ2NyUwLxhSuLVc+VI0KDtOW7ur3xg/?=
 =?us-ascii?Q?2Aa7cZHDG39lErUfnb2FR7PM9nTiUBjo11bcPVBLwaFzMPH4R1H7Io0/4kSf?=
 =?us-ascii?Q?MVfS0wtLZC3ulL5DSbxrqvRrgISMDTzEJRu9ii/vpuNyLfwIsv3Edeo4QWaQ?=
 =?us-ascii?Q?U4AXnoff39Z7TnO87ts/Tx0NqHWjgfz4nl67D7tb4jGF+8njvONwzf3X4U4V?=
 =?us-ascii?Q?ioGgwIxmvD4xFrG9d5gpv/BpG29EaAmNfyhnwTV7Us36Tkmw5FRmsePRm/6L?=
 =?us-ascii?Q?vRSqMLOcEa/WizbcPSHmrQspFw5EfJsGDK0OnG3nMv8rPunvJKqSuC6I+7ZR?=
 =?us-ascii?Q?ylvD49s7zPaxXUoG2sNPhDwxMMC7fmFgGLv9AAKWu6hx4BlBj7d/loJwR3N4?=
 =?us-ascii?Q?Df1Bz4wT3n2f/ONATmsA2ibt1UT9ZUDbBEa/HaQ3PL+gqGoBkSx11aS1jBPa?=
 =?us-ascii?Q?57qxYM9rQrKLD6JGQ5Ul+YQMp9dNt8jAayCYGzME2QhaKXQCUsVqkBvmruPw?=
 =?us-ascii?Q?xIehX2jg6vhlUD13pbQkH7k0JI/7z3WbzMLiiInwdNKe5r3viUqiaieba8gD?=
 =?us-ascii?Q?YIdzEZJzCLSrFLEQ8jIuQ2IdlmNdl4c5FVjnkHL7gX6j69vNGJZjRuZ0y09o?=
 =?us-ascii?Q?f+QuIIrcIkSOPLKobRODbceoZlRQHsmqKW/Pgc+v4b7b1ZgieGHzM29zdo6J?=
 =?us-ascii?Q?wLExFUyouGR5WrMCpHGTqV0Yc7Qrwf11FOdbT0DKtv7sZFUxmQAwVUIKaIqD?=
 =?us-ascii?Q?7q+yj1IN/i/SrL18RexfkztPlyQYdaOyXDtlYnPZzfKH+JKoXn2wYMYDj8pY?=
 =?us-ascii?Q?A5o0QO0WlT3kvAX5L97gRoEEB6Rj0kVYU2lsrkr2KZkSsJK++v0kQmr4HKqk?=
 =?us-ascii?Q?KvSTGJlYf2wXVfkyPFef+v4Z3S0CwTzWSn7zIzu5pTi73o+6hIJJqBmxVpnF?=
 =?us-ascii?Q?wPAWhArVsXm2Agwy342UvmpbtLg48YFJUVO41KrzL28+HG3clLuZPK4/c4PW?=
 =?us-ascii?Q?4BJYTAy7XY2sQjkN/If+Mb1putvLHPCPJr5ws9hHeHWw+NXBNYvhR7G4CoQY?=
 =?us-ascii?Q?+ZObtzRmrKy0Bc9nao8pEI1rksOkm40Nv8G8vfXEUlIPQuX1hOhVcO5H0Qd2?=
 =?us-ascii?Q?3oLI/PS2EKzdTZIoSm54wiiCrgMjI35h1a9z+efG4dwoLFoOFk91WT2rBEXD?=
 =?us-ascii?Q?89qpogQW1971D0or8TLJ7WDNNlP3z3YJkzb9?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 08:01:45.3886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d76d3d-929c-46d2-9a15-08ddb550dc49
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000040.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR03MB9750

mesh_io_recv_ext_func_t has been introduced in
6a6fe856a900 ("mesh: rework incoming advertisement filtering").
According to 'git log -p <rev> master' it has never been used.
---
 mesh/mesh-io.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mesh/mesh-io.h b/mesh/mesh-io.h
index f7711e78635e..d9e0c138328d 100644
--- a/mesh/mesh-io.h
+++ b/mesh/mesh-io.h
@@ -66,11 +66,6 @@ typedef void (*mesh_io_recv_func_t)(void *user_data,
 					struct mesh_io_recv_info *info,
 					const uint8_t *data, uint16_t len);
 
-typedef void (*mesh_io_recv_ext_func_t)(void *user_data,
-					struct mesh_io_recv_info *info,
-					const uint8_t *data, uint16_t len,
-					const uint8_t *addr);
-
 typedef void (*mesh_io_ready_func_t)(void *user_data, bool result);
 
 struct mesh_io *mesh_io_new(enum mesh_io_type type, void *opts,
-- 
2.43.0

