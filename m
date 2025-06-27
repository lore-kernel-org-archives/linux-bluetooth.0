Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010016.outbound.protection.outlook.com [52.101.69.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8D83C01
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 08:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751011259; cv=fail; b=qcbLZKn9jhaY+vYBpc/m4649gWhlo2EbGzj2XJETM2PPCp1/uYParzXBTySBQB100p51Vl3AdoS3lgnbrXZxTTP2kGWgx+g6im722R7cgjmc0iahtUIiyWorwah/TlG2KUHETYzX6kWHQkVlZhGTpDCe+sXoqz8arRQhKenGXT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751011259; c=relaxed/simple;
	bh=SABG1dJyOEYY9dAdHmQxuJuQB6Fykg6P3qbhRX1zebQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f4nkSMJ/LIBrVpxNAZ7C9qb/fJN4+eecr7+QomOivwNUqh0VZQ6OtMX+LZ5JNs0HoQ8YvAq/8Oh1BZ3NFJeB1EF9BU/GVrs97utD+b8+SCU+b2Qc2oxCpze0OJFSDzkNrkchs52x90GDH7+A227zzFnFa4XzpmZ9VG6IDMx7hlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=FCrfU0nx; arc=fail smtp.client-ip=52.101.69.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="FCrfU0nx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BXZiSg9XkTkHquZEHNyCanXqzPrpRxjGlswmqRX95cnVyJbfPHJMW9JTB9468zSj3NPOacXN82E4sHkQQIlKbE0pf/iAZyH1i3I+TwH5dYroNc3vvf8uWMTTlmCqVrgqaDMcZdSfH7PEAk9nDkPnOkMJy1QzBPmt/3YsJINfCjhMuS5mWeTTOro+lN3iQxjHb6VW0zxGp5+NaaPcni4lwn7kztMpwBVgjWgGx84a3Wf8/0omblVmlrzLYVZgbFRfhfs0dE2R0DqqfcTbKjjaITBo9pBt8pIfPvpzXrYPMWv3Bcrcikge+8QfZkH82qH9juyCSe378o3rL33rvCoBKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mnxW7sANcZjH7nBK/1yuEPjt1ZtfaQm6wzIGgC3NLA=;
 b=VHcqgLAm7aBRvvqf6wZuPsOYVgiFZBm3wo2ZGXb9EJx79RXChhMO5DcUBA0D7+MPDfOKc9+7U53i4XJ0MBi0Z234Kc7R8mCO2Y9Ns+lUj8OSCSrXcX69XX/nqdKwSJWR4UCJ/DSrIhyDa7tHMUUtOv4aQGKZySttADbSv6+8zqWkK3s62SunYHGduqKYDa4UTxCcjiKlFZ2OuTa6fAW6qkJHerQlVjPQbX2cjNEm59xtUeEqmDBNZ1D+vhuYnROD4xnULABFBRvWeLr0fRO0ebW4j7rHxIebFRTsvc+60L19NQnCtQAqh7oHh+M//7qnJ4oioYCgG6tZY+NUwCKKSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mnxW7sANcZjH7nBK/1yuEPjt1ZtfaQm6wzIGgC3NLA=;
 b=FCrfU0nxjiqCQThk5F9jFlVlJT42jXDmNFVoLLTV2db6qZ+/isXYcZOCExOTtoIEacJv+Kx1HG9VijqD6ZMhNwiTEv04at1X1KZDXh5xYjqZ5R+653r9S5eQIZrb6zy0/8VzGzhzEl0HC0bAhfyEz9MpnjpoyDsEb6jUk3wv6DI=
Received: from PA7P264CA0436.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:37d::8)
 by AS8PR03MB8714.eurprd03.prod.outlook.com (2603:10a6:20b:54f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Fri, 27 Jun
 2025 08:00:49 +0000
Received: from AMS1EPF0000003F.eurprd04.prod.outlook.com
 (2603:10a6:102:37d:cafe::13) by PA7P264CA0436.outlook.office365.com
 (2603:10a6:102:37d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.21 via Frontend Transport; Fri,
 27 Jun 2025 08:00:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS1EPF0000003F.mail.protection.outlook.com (10.167.16.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 08:00:48 +0000
Received: from N9W6SW14.arri.de (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Fri, 27 Jun
 2025 10:00:48 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 5/9] mesh: mesh_net_transport_send: simplify
Date: Fri, 27 Jun 2025 09:59:24 +0200
Message-ID: <20250627075928.19788-5-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000003F:EE_|AS8PR03MB8714:EE_
X-MS-Office365-Filtering-Correlation-Id: 264add07-314e-46a6-3182-08ddb550ba51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o1kKME/Lle7EGgmXqe7QXuMSaYY7/JaWMkRS5iTquacmiWxwvubmFHkFmvKp?=
 =?us-ascii?Q?7MayZhtJfMCalZZAJOjp4AC+SmGpGFiSXJ1KpmSEa/NWOl+PfMMd3feBoyE2?=
 =?us-ascii?Q?1mrRXJGgtVYudC1fP2usOFkBUBFV0YqP1Vfxnm6PPMV4xgXhKR8SZsE5eoNL?=
 =?us-ascii?Q?FikErk9bOHR8zN1vc+fj+0WcWaspNsCnqo3YoGX7lyBNaOVbbbsjSdDR+8JM?=
 =?us-ascii?Q?+BtrsXgwUPy5hWWd/FUowz5vm7zPv/VIt5jm2h9/sGjzgZpV+pO2gn7vSetR?=
 =?us-ascii?Q?b2Q0L673x6jcD1xKVfqcgaIZN9wEEezkuD0TylG3nWxlxq8PMg8PvYl92OD9?=
 =?us-ascii?Q?wjAnSWvf1NOJtmSCOL29OsXpJHNWkedbGkhRB2zDrpUjfDJ2js+IYJWPergq?=
 =?us-ascii?Q?ldfH37gRL3Q1qsZwgH6nhnfdLOx7NE3B/OTB75Q2kd/lfvCyHC/X2Pu37873?=
 =?us-ascii?Q?ECYi1FsUMFS3wwc2tyo+wL0AgBPCxc7CmG6YYpJns4vPI9JH+K9Mxd9evLLu?=
 =?us-ascii?Q?rZP7xvppS9rQqHaZALJ7tHJbN7bjSK4Awu49K1LBq4DgpLa4q6K/AS/HRp+X?=
 =?us-ascii?Q?99msX4OTc6dSm0jdHN/iMW6G2NKSbbNlq7zTGNwvp7SbMa2ggaHYTuCzfNwh?=
 =?us-ascii?Q?btPE15twVic3JminNqw+mn/UUd9YSBPG/pKmdrlPcVaJXLGFJDGp2gUFjCFC?=
 =?us-ascii?Q?2LNtEN+VBcbYXo1+9dLQ22j4xKzA3OLhYNJnULpEAdyrRK1/JkeD6U/+Oi2g?=
 =?us-ascii?Q?tQnLx8IHpsdiydmZ0CVR1UztLgrRDpFqfUVxwYZ7YlSlplWxv0wusLUY0Ni/?=
 =?us-ascii?Q?j8AxPpZ/8fUeruRA9zkirkzIue8yhejncGBjL27ZM/vDqxD3o8U/hnz8kgAf?=
 =?us-ascii?Q?6+juErps7YqQyySBGuHw6tmIb++lzV5+Zos11bTWOlbr6YZvR3wAapcrnkCj?=
 =?us-ascii?Q?u7yNoWsGKx9DkmzY58yihGJ9MwfmxqGtqIiw2NnH8VhdX96zTUSSSBpwfe+R?=
 =?us-ascii?Q?duNO3g3pEwHZQ+ajvLQadGwrM5ypqZhHds1CmS1wzotjCGf30d05WBTFMYh/?=
 =?us-ascii?Q?HLQhE62qO7UpzcHa8ULiYoxhzu9c5kWdjQ6qUz1tUa0OipN0w/tgcB+8Dog8?=
 =?us-ascii?Q?RBzTB8YCY4pT+B1LxT8MAf225fIzfWjTeWiyCnC+h0fFSVElQQiZPngPl2oU?=
 =?us-ascii?Q?2yIjQG9vVt0yH9eqTk9HiyGGvCiAuTZkLxWZQ2DD9mnr5zw8Ex1qo50uEFkf?=
 =?us-ascii?Q?ERYCPpN4RebhfUGZf1vitHme+9UI8A/YiUT7JSayCZigeN50wtJj7v6SwMcP?=
 =?us-ascii?Q?ez5kmYPaUAlIkLCBFXa4AGqzoQgLNVrtLNxFnZut+l/iAG9YxcQ/achykF4X?=
 =?us-ascii?Q?qD1y3Yht7t0b2kJTOwPCzxRfqiZWOnX+bKAqRVgVnD1v8bBweGqyFh5gKHfE?=
 =?us-ascii?Q?Y/iYf8ndlCS0weFhXorjp2vWfRWHKdjdRVVyfiEXQacZDjf5J7r6GMGGRYP0?=
 =?us-ascii?Q?yhUC7mUQc90NCKDLEUxBFKhUspMIR1Ily2N4?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 08:00:48.3968
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 264add07-314e-46a6-3182-08ddb550ba51
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000003F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8714

No need for internal copy of 'seq'.
---
 mesh/net.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index cc862dade5ae..f26a63f178c2 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -3411,7 +3411,6 @@ void mesh_net_transport_send(struct mesh_net *net, uint32_t net_key_id,
 				uint16_t dst, const uint8_t *msg,
 				uint16_t msg_len)
 {
-	uint32_t use_seq = seq;
 	uint8_t pkt_len;
 	uint8_t pkt[30];
 	bool result = false;
@@ -3463,13 +3462,13 @@ void mesh_net_transport_send(struct mesh_net *net, uint32_t net_key_id,
 			return;
 
 		net_key_id = subnet->net_key_tx;
-		use_seq = mesh_net_next_seq_num(net);
+		seq = mesh_net_next_seq_num(net);
 
 		if (result || (dst >= net->src_addr && dst <= net->last_addr))
 			return;
 	}
 
-	if (!mesh_crypto_packet_build(true, ttl, use_seq, src, dst, msg[0],
+	if (!mesh_crypto_packet_build(true, ttl, seq, src, dst, msg[0],
 				false, 0, false, false, 0, 0, 0, msg + 1,
 				msg_len - 1, pkt + 1, &pkt_len))
 		return;
-- 
2.43.0

