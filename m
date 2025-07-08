Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013020.outbound.protection.outlook.com [40.107.159.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DEF14AA9
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 13:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751979727; cv=fail; b=kAYBWf60r43dUj6KCw+gGm8wnYLegD8SuhccVeb3koBAimSuN+joKtcHnOm782AJTCwkz6f3I64yQdQ20PTL0Zfs3kgIUQ1/Q2A8h9psHySLecotE6UIUcNW9bPTL7NxGmSkioYJuuUQEG6kFWpmLGsiqaquJ9bbZYfWLWMLD9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751979727; c=relaxed/simple;
	bh=KBVWHnYZSKm5rmaHS1WMnzF09GVhGzNaFLYp1cZLTMc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rLqKMVHRsIci3oZIHgn1aXzXcKrmqv0nUyS1LD5bS+tWF6KQJBN2ZsyZOear7Nxl37seK3s4yDO2z7fHZ7CszXKD6NgHTULco5XIikFWU37mPL49ueB/YjHrhtBmJy0TKUCyI48L8a3+rSKSDZ8DdZU/4m2ZZ9HteW6Sf+b6Gvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=XOe4q3Sw; arc=fail smtp.client-ip=40.107.159.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="XOe4q3Sw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIXdwITf84o/Mx1TiToYsP8MlQVVi0CKTR2BWLksInQtFhmUEUrp5ZLiNTCUYTl0b6UCL1Trki55cj3XcDdnnNUQbVZ1gkYGJtEYQdaTVrsvl11Oy45Z/Cs4jV4O5sqy6Zi+XPuewjxrLbLwph8tII6F9caP74QMxvFj+YOXfHrMILG2BLdKGydR9ddGarxbCi6D1HNPsOXPH3479B4S8tiMKg1+V1qe/iokkCMfVT7zSYLXGRCyHiJ9VLKQ+M9PAhUIgpjRPGWZ0OTHPaojKWLcRNkFBSZajxdbN1f57JpeiMRcGB+E6OrH08EqeCJqQmPtl/Xa/xTxB5h1cHd+pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pB/WJlHLY/V5/snbR86vOQYHHGra08Qj8Ev/ZrGxwPk=;
 b=pM+vy5GoJj/TIJu6lI5Y/NnNP4idMrhdTFeHOan9yc/2wW5s1eDhxffmYFBEFa3BLqc9cMaFiuyjg8cOZ/NWMYYrv9VQdoKcEA9JdwmMLM4nqtDBl5WVN7s97qY9KeoMSxPIaXK0Ha0qyBh6Xn64vFoRtpBE0OP3h8GoS405z71li2cJSM0B59GFnziJO+oirB59HBkdaCVqRklVMmplBZBy/sgdCxEVBW8QCf4dYxRADc6OKTZ4L7UIKYYQkRPT51+bkKoKKFHPNucjdnpWYqbbIb3szKX11OAlKbqY/CAATgpv4ElPl87HpDlaJhazVhBsykSrLNUnLFe4UF0NnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pB/WJlHLY/V5/snbR86vOQYHHGra08Qj8Ev/ZrGxwPk=;
 b=XOe4q3SwPSMM/5klKvYKpFkIrTQ9kz0lGfTw7MxkwkyQFQ2A5n6rAeOY2DcfPMNN0jnQQgw8Bn1I5Dsaw7sumF40UMrmd30KUaTe5EBqi/XdYDDxLXtbFcO/CpPSIZHb34GjcXGmrgIX7L3Sv1DnhZ5wCroIuYAs68w31GqY3iY=
Received: from AS4P190CA0037.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d1::18)
 by PA4PR03MB6925.eurprd03.prod.outlook.com (2603:10a6:102:e5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 13:02:01 +0000
Received: from AM4PEPF00027A64.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d1:cafe::40) by AS4P190CA0037.outlook.office365.com
 (2603:10a6:20b:5d1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Tue,
 8 Jul 2025 13:02:01 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM4PEPF00027A64.mail.protection.outlook.com (10.167.16.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 13:01:59 +0000
Received: from N9W6SW14.arri.de (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Tue, 8 Jul
 2025 15:01:59 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 07/15] mesh: net: remove unused stuff
Date: Tue, 8 Jul 2025 14:59:39 +0200
Message-ID: <20250708125947.11988-7-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A64:EE_|PA4PR03MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: c6c758c1-090f-4808-a82e-08ddbe1fa043
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BSYaYqfF2wkegNXcHlMK6oAS37UsQyEKKYOUcH8RmpJVIG3A/mcHzTJH0WQt?=
 =?us-ascii?Q?vVDKMSs9KAxCup0TEv9eL58EwQIsUsZla1Hi4sPCDheAayx5UFB1PpdSSgwt?=
 =?us-ascii?Q?QZ42P4YMoE3Ju4OfTekJAJVFXqgb/X9f9SZb0B4n0n86a+yfS3qY2FIyDeRz?=
 =?us-ascii?Q?OtDr16OZyeEtajm0Nxge+32MP8pTRZy7xVXXjX56EeDwwNKsRqh/1OwXPQz8?=
 =?us-ascii?Q?lQ4i5HBSFkm6vgpPZS7n7FCfFXm4mVDI8c+sR9opAzHzmT0n3pU4dl5LlI9D?=
 =?us-ascii?Q?UWLMRQLg71Xs7eXvIA7JKdfb7JoMYB4qLr3rpB5q2r/CNzgFsKdgNPUKsZEx?=
 =?us-ascii?Q?Pik+sj+YUWizdAlfp1nzh+3t3tErnEzu0jBgkaX7PTO9cd+xYJ5bjmBhRnEQ?=
 =?us-ascii?Q?/eax6GpoUGZVb6/mjKABLJLr3E5250TY536ERBLMKFaqUGqu7vc6ka3NDp0u?=
 =?us-ascii?Q?pZa5S7EWKDzRruMpTuzgYZUqJTiFq99s0VB7ZW2gWkoEN9IVn7UIk9O+YIVP?=
 =?us-ascii?Q?CPCIzK4cMWQw8f0jwq9AgXVYUNvsNsODB1emyzTRB7CSVZ2Q/tW+iHb5Bh6s?=
 =?us-ascii?Q?oRfcYLYF6fYhN/esDg3UG9n5Ie8G2u13Dg44bCRB3doHRzWZpHayznDkI6p9?=
 =?us-ascii?Q?QQbvqu2JYKGO5fLlbWMCJOM9n4tIckeIYuQSDWzA6OeZjzmmNevVYNxZfCdz?=
 =?us-ascii?Q?RMLwK29Wwlp6ZweNdtubmh+cIHF7QwDFVPHEZQjlNj26sd55Jjgg5ncuO6D6?=
 =?us-ascii?Q?ZMfXWbMx2KiApLoWeuGv/k5hghsnHSN2r7Ikk5ONJ8PtC0oTXD0V3Bj6uHwr?=
 =?us-ascii?Q?xc5UVSUWprsc5m38lBV5Yq4oUqhZ+iv4a97j+ZOCnCXpaEnRsnMq0Fy+Orhy?=
 =?us-ascii?Q?DIYGSqPi+tmYfByWu7tG4qmHLYZDAy9me5kzIuGASmgRf+BKI6OSWjHyHfLB?=
 =?us-ascii?Q?b+H8j+Nm1avUgXbFbKg7cMDHXulSjGTRWUFQXTabV/Y03fQqzY5Mwym/gDty?=
 =?us-ascii?Q?W9yoA3AOTb4FKKvO4PzLWUU/vrkAkkbemORvDy04y8Ya9/oFt1MpZU+gxtAI?=
 =?us-ascii?Q?I5tdfDiqrG7tFcsYNSGJHR3GCn8YiQ5w1c5SBjmzoo0W2eFhRxcRITQ1sy2F?=
 =?us-ascii?Q?QOoLYEhlLf4ZSsFibx4/vpPvuhz+uoeWv6LBP8vQiKwEpTRHArblIYxh5kiB?=
 =?us-ascii?Q?uTByuCXD7Le05Fy9DN9CU0f4KIHst15jU7vCHIyJhxBd2ml/KBFQ3A7i3emV?=
 =?us-ascii?Q?jIzeBHgLM+gn0pJSB0c7LY1bQx0W5g/O2Qv0thFafba2CrldKVdMRWeXv3D0?=
 =?us-ascii?Q?iJCBQri0OkOnifxoxA0vRw58yZ9oLIzYW3RjZ4oM+x8f0EnSzY2qaRmSSxBR?=
 =?us-ascii?Q?PVPCR6KXlBPvMt6+czjI0au41MO6UKf6wmHaGRbV09+ijRNvhvn/au5DiJw6?=
 =?us-ascii?Q?feDULjUrpiob2zG7nSnn2ZwsSUNaE1GxbB9JqMUGd8rbUlrP+Q60wy98NmME?=
 =?us-ascii?Q?AzjCaTb0F8Hyw+k5NYolSIm6x38aL+YwkvqL?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 13:01:59.8165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c758c1-090f-4808-a82e-08ddbe1fa043
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A64.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB6925

'struct mesh_key_set', 'mesh_status_func_t' and 'struct net_decode'
aren't used anywhere.
---
 mesh/net.c | 11 -----------
 mesh/net.h |  9 ---------
 2 files changed, 20 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index cbdfd9d299d5..2e10aadcec19 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -182,17 +182,6 @@ struct mesh_destination {
 	uint16_t ref_cnt;
 };
 
-struct net_decode {
-	struct mesh_net *net;
-	struct mesh_friend *frnd;
-	struct mesh_key_set *key_set;
-	uint8_t *packet;
-	uint32_t iv_index;
-	uint8_t size;
-	uint8_t nid;
-	bool proxy;
-};
-
 struct net_queue_data {
 	struct mesh_io_recv_info *info;
 	struct mesh_net *net;
diff --git a/mesh/net.h b/mesh/net.h
index 8a3b4038b6de..62b8f5896089 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -143,13 +143,6 @@ struct mesh_net_heartbeat_pub {
 	uint8_t ttl;
 };
 
-struct mesh_key_set {
-	bool frnd;
-	uint8_t nid;
-	uint8_t enc_key[16];
-	uint8_t privacy_key[16];
-};
-
 struct friend_neg {
 	int8_t rssi;
 	bool clearing;
@@ -219,8 +212,6 @@ struct mesh_friend_msg {
 	} u;
 };
 
-typedef void (*mesh_status_func_t)(void *user_data, bool result);
-
 struct mesh_net *mesh_net_new(struct mesh_node *node);
 void mesh_net_free(void *net);
 void mesh_net_cleanup(void);
-- 
2.43.0

