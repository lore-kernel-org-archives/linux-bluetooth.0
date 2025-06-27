Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011004.outbound.protection.outlook.com [52.101.65.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D9C23027C
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 07:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751011145; cv=fail; b=e0XI9A/kbqo+1aN4ogWg5IGBgZVvjjAeNIdp1cXTFwaedIFQbKxi2Ox3HTlFOBOieIBosc3rgR7AqF1H9VQKbJVLD7HRueTkwD4dPzKi+5O2EKqUv37xyCZX+99tIJ2Q5pAwBPEx9on80Ywmrbvj5LxLZT0+4kfV8XlVBhfWMbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751011145; c=relaxed/simple;
	bh=SABG1dJyOEYY9dAdHmQxuJuQB6Fykg6P3qbhRX1zebQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mOhqmavAzUwvUiCGI6jDo+zirCytOY/1m14V1Wp6M+SUk2M9i0T25qYJEWpWB0gSrI/i+ihz+IjBTmOdkHXA/CMgbGtfnohyvHIQmQVGk6Lit5b7SOB7V0bbToU+WF8xl3ARFjbbKzDItE4EDfbrXNv1m4Fr435Temv11tnPdlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=YWTaskl0; arc=fail smtp.client-ip=52.101.65.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="YWTaskl0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bteOyXlmHltirYxg3iZqHtZriXFCMHzE/58kFMKg2g7iwFF95keyZAl6oA1VGcH5qOv61IC8rUIA37u5vuh46joKBPqGrY2PAJQKWLcAqi+xvGxnRgXKmGF7S1DMPystzgZBXsM6Rch0/tAVm3rqpLtyF2NlxsPY+qQ0YNuBC4Tfl3T1X1nj5gQTPOTXGeztb+bgLVYkN8DicaJYnIlmsY9ntTHcGamQjzwXDpk1ERcmds4fhZuHEy5aBoMyf2zy4hsbB47FdW7Akg5Ok7l0K9DCMSshtz4eCyPUyo89f018WJVg7tPmBJSfFN92ugXw7XciTq5XG3yhgGGNAhOnZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mnxW7sANcZjH7nBK/1yuEPjt1ZtfaQm6wzIGgC3NLA=;
 b=U6YnmaY1ngRS0KvNcZciqZiIeA8Tx6zmDSTrbVlM6vBG9+ZL5ucyn3s9b7yS6YYW5vmZud4+UNWW4TqVU+jpedg3/7GRn0zdGvWbsG2RGL7qvzNySrksUazeEJuW+6gEOIz4CbMl+zRbv+Ccs6oDyQ8DozulBqQbbQVY9jlc/iI62bs3EPgkqtCyxL/ePl/fBQS0G0qKY6uDiNvM6b58D1wnpgYhU66AhMA2Oo9rCyOr1W+juhZWEPRK6Dxw4qxqJVAl6s9F82ZEAgH+Iw4HDXCplVFDOZXVnS90pkU1+F0rjemPHL1+EfYHbMxTV/RSLr2vBycPHFMfmyGTNYVPPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mnxW7sANcZjH7nBK/1yuEPjt1ZtfaQm6wzIGgC3NLA=;
 b=YWTaskl03VSjH9RPda0CTVMfhJQkU4fuYnMJwlbuc5vgejRTO/Zr9MB/CoRqPz/Cwwev/h2WeRxROAeaH+EHuPf5P8MNtsWVgI5yUUJAxjpzWpFahEYHStbw59tHKr+OTkWd+mC+0ZC3tzfHQB+BizNEiseo5wLU8scyC0px7vs=
Received: from AS4P195CA0004.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5e2::19)
 by DBBPR03MB10222.eurprd03.prod.outlook.com (2603:10a6:10:52c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.22; Fri, 27 Jun
 2025 07:58:53 +0000
Received: from AMS1EPF00000041.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e2:cafe::96) by AS4P195CA0004.outlook.office365.com
 (2603:10a6:20b:5e2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.23 via Frontend Transport; Fri,
 27 Jun 2025 07:58:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS1EPF00000041.mail.protection.outlook.com (10.167.16.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 07:58:52 +0000
Received: from N9W6SW14.arri.de (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Fri, 27 Jun
 2025 09:58:51 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 5/9] mesh: mesh_net_transport_send: simplify
Date: Fri, 27 Jun 2025 09:58:01 +0200
Message-ID: <20250627075805.19597-5-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250627075805.19597-1-ceggers@arri.de>
References: <20250627075805.19597-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000041:EE_|DBBPR03MB10222:EE_
X-MS-Office365-Filtering-Correlation-Id: 683cc327-35c1-4708-1088-08ddb550750e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QMwTDaaoT2refLGB8GRcBwAov/RArxtKxxSPw25BEdx41DysmHZNoJ0ClPGU?=
 =?us-ascii?Q?d9TaXv+yKQKiCfQASPFWchl55MXJGLUeHWbD253RoGcjJEFxu7nYl8FnTyA3?=
 =?us-ascii?Q?zPqJKI0FHcxDzy/mrbh7M76rEO1531i7Ln0ennz9Q1jF9sJew6txo/tLIDjO?=
 =?us-ascii?Q?i5RYFYF43f+kSOrwOwOzODKGitIC3sNEpbpCfxv+8cZKvzWF3eTbMF0WJLrc?=
 =?us-ascii?Q?d0NUwIO/H3uV4amGE+Pf1/g8BWGcMqEWbR0xQrCtbmgH2JBYogCtQ1Exaa+F?=
 =?us-ascii?Q?rVfcWZe/kwnjfV0ISbJxoz7X3f3S4ZU8FWpOTMvofgv8kaW91ssu2QVZqZnx?=
 =?us-ascii?Q?821SZB7TZzX0VlHl43HhpftOB10XxHl4UduWlO3zMFmUJNr6ixaBh3gp8xW2?=
 =?us-ascii?Q?h850PfILY4AOiyAMky9skkbIA/koDdxI/2AxM3JfpnkjdV3qLpMLcIrG9KO6?=
 =?us-ascii?Q?uikcA4HRKbVE9Em14/s69LlQY5kwn+6K0kqYEBbM3Zdc108duqFvKKbby3t4?=
 =?us-ascii?Q?7ct+lY0lb3EWu2x41qt70/g/TNJJOD7A/p3+zhLbuJ6GbT5OgZP3eg4DTEW+?=
 =?us-ascii?Q?D8kH9j3h8gAgWoIhBz/15ZtrEvjiuDMdP7d9+olpWHvySw9arHgSou8rvSM5?=
 =?us-ascii?Q?pO2kIpKMCkaCb1GwZr/vaADbC0TMms7b50Lzf9UgyT6lTffb3A2rrY2y3QUW?=
 =?us-ascii?Q?7xbDrnwFZKAf+JZwt5GB9NDIrBaJkrji8gixhq3xIqLuv/QbjOfeuGKDNIsP?=
 =?us-ascii?Q?FScGRh8wjTaL2O+hR38Nd6re2zSN8pmpvblW1GsHOAXa2IE2HLdnsvtc7qiN?=
 =?us-ascii?Q?AJdO2yVYBv3sZFQWDmeQNpLPd0kz3ma8zRh00VFZNsQp7jRJ5AvuUVlREofG?=
 =?us-ascii?Q?hwk7+EzCwg9lUaO+GeM9amINDmTnjXL8GfrWwvB7J0RysFerxQpwDt9ImsLE?=
 =?us-ascii?Q?9bWYjD1AhLvoYrKZ1K3xdjpRcJpN2X5c8hN8Thm9SMp+nys0Jm3hVk6Jbofe?=
 =?us-ascii?Q?uGC8DS+Ea3D7Silv3IY2CqdG2sWJAqEegBiVsSwRQ8/ISWeKaaofWAdkZ/Qb?=
 =?us-ascii?Q?4+8JY/xBqu5yr5X7XScTAIbolWZ/yTQ9m5OrE/NIV5ihRt5DV3XuavaAYQQl?=
 =?us-ascii?Q?v7U9gL9X1/r3CQksAhhZNwaSKEdRqoyTHJq5e/J8Y30PtQANSQctspXDCEFU?=
 =?us-ascii?Q?jWjkOkIb8KO/2xWVWYPsDuADdCrcS9LG5wbz7utWMxOEgJM78braBK872E/Y?=
 =?us-ascii?Q?ZP4F2Kcf2oZTfvBrL2IJ4PxpnUlyB4YkEM8ivmHdzhJSMzDmgVAjdD3C+3Dt?=
 =?us-ascii?Q?4IdxoDKBS2LfKjp0BLA9WYeie2ZnFCd87y5FF0Fz34EuS0DJzoZeKmTdCcKi?=
 =?us-ascii?Q?YZ/80scPJd6LVBxnu9FdLERKTNM9UR48RA2jGLRQ8eTTlZCKZB3J70HPydvB?=
 =?us-ascii?Q?/PaQYnV/htbG+Yo1JPwPniTI4uWMJy692mooPu7KD3ZFvD8LRS6HA2UvmFSr?=
 =?us-ascii?Q?6oPVCO0MOFcxJK23DoiQPwCatjb+pvb9Q6G7?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 07:58:52.1901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 683cc327-35c1-4708-1088-08ddb550750e
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000041.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB10222

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

