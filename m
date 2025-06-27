Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011007.outbound.protection.outlook.com [40.107.130.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA4422A813
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 07:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751011191; cv=fail; b=Bs9hw/Ic6CX/9jm8nzyHeIxq2XZ+FAbaR4NS6vxDg+6WPWAfqE9VpZD519NMpMXVIQAE1VyGe+FusXPu7fbgoMefG3jwS+ZxxyLEn60ntRKohs5diwgZgmQmJlIGmdLpPjkn0GOihyTksP+G39Y6oe/ztX65PRAOpuC6oFR4+uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751011191; c=relaxed/simple;
	bh=fX4V4Icr/O1C4eVbzRVkoHsrEv24fUdylG62HHA/Nz8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AmBQKrWAohPBX3Ju2xxmfuxDrPxB/eGBi8EMAsXdM/mQ/VRkyzI1PYFrD3nAdMxTWXYU0yIs0V0uiKWd78njMZ5MmqmLxLs2HsXB/mLScYi5fr9L0LzR4hKfwMAoq4eSHqiuMbW2HBur74U88Az1pKUUc+J//ubnFaTZTXa9xeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=goho0UPT; arc=fail smtp.client-ip=40.107.130.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="goho0UPT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RCmGg15NZa+JtVGQD6ykprkR0TrWahgfUxjBCbxCgUOi3JB+cl3SFLUjMzno6cSryEFX9BBBjDlmgX+BiyQgAFEZEnzwOk9Q6wfY8ezN/PBeFS4nLDcaYOvZPQ/59cBr/jQJmZejceRqs4R09Zh1Uz7YRoWeu8A0bW+I0/xKSzMYZiXppC9ZeqNGiPJ9gff81yycN+EGfqLUkJ/PkV45MGTgh8D31yR570kr3Cr3lUeIaN0FOcMR7qTFvIEGa2VnClD3OsM9/eTUNYr2JYHCSXJL7wXozDEl/SH+prCjXlx3EQBtKGYk024rS4RoUoR7IopyR5Xp/pW/e+QC9leq+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3vQ+XqeUp3/d4LjQbflAVEWBaiIrmi16OQkBoQd59s=;
 b=ROYU/CN0Jx/rYgzuFUbJ4Gpq5mlYZBPMpJ9m0h6rIXBLh5jmCSVljM/7H8Ac+l7ndYMLBHD7tbznlYrUbC4egFfkM7MANx+XMUKZl/pcYdRTejd9TtcT+uGKZn8OxvCudn22XC08fQp+Ojc1rLOCbc1l7DRi9GtMAf4k73iFIglt+xSwDWUHukob5cbyMcKYb3o0cXqlTCeB2lJS93c/ndve6ZeUlE8AQKcleuBo0sFPRQm7H8ivWdROGKir4LNr8Oe8ijyVm4pReNHzuefNFME46yZisjWcTdQhuPzAQkHj7oNvTige0S/PHZif6AdQcZxAHJlXYNGFsLm1TSYCFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3vQ+XqeUp3/d4LjQbflAVEWBaiIrmi16OQkBoQd59s=;
 b=goho0UPToKOS+JXqe40f7Aq3gqbUlj3P2WHOU0JMqEo/UMpTbjd0da2c7Tp1f1hlxRL83rzjSqWIqgxPuJGG6waBhtGRHyJ8vkayA14p1Lt78LvCArGocDuOWAFas8tFLK6TUDvDddLw8+lwJe/HdsR4tFc9j/GXGlePNhy5+r8=
Received: from PA7P264CA0249.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:371::16)
 by PA6PR03MB10322.eurprd03.prod.outlook.com (2603:10a6:102:3d5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Fri, 27 Jun
 2025 07:59:46 +0000
Received: from AMS1EPF00000040.eurprd04.prod.outlook.com
 (2603:10a6:102:371:cafe::3f) by PA7P264CA0249.outlook.office365.com
 (2603:10a6:102:371::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.23 via Frontend Transport; Fri,
 27 Jun 2025 07:59:45 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS1EPF00000040.mail.protection.outlook.com (10.167.16.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 07:59:45 +0000
Received: from N9W6SW14.arri.de (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Fri, 27 Jun
 2025 09:59:45 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 2/9] mesh: keyring: constify
Date: Fri, 27 Jun 2025 09:59:21 +0200
Message-ID: <20250627075928.19788-2-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000040:EE_|PA6PR03MB10322:EE_
X-MS-Office365-Filtering-Correlation-Id: a45924f7-01fd-4d00-b50f-08ddb55094d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WVqsyKxZdxpsmJaWQzkw/BtOdMSnhrLLjKIJvwR9PRrekIpDpc5fNmHqfpJB?=
 =?us-ascii?Q?Kgiwc3uoMx5qdHXVkuNWJk9EXJLCGBjMlt+szM3L6/6UdoNaaCRenYNf+3Rs?=
 =?us-ascii?Q?rJLUJtw700x5d4dBiKkh522C4LU582wxIHdk7EfyfHBIM0urcXBG42whgVD2?=
 =?us-ascii?Q?b/4wVHuXev7XQsBhDh/6ka75XbyQIFPtI2cWcZbpxowxgFcwrB6bZf25qi68?=
 =?us-ascii?Q?PfAkCmAkac3ONApm9v+rCyOkn7Qu+oD5Ab3RVJ42P9M8iWIQLwO/ad9UOcyu?=
 =?us-ascii?Q?+JDeT9XkbLjVD5b32IfdGa4233TR+nz+MBX4q9SV4ga0yoy10HLb+775sTxF?=
 =?us-ascii?Q?2NU7b/sU41gYZhI+2HBWRzUTMy01/TiCxUG3kPUrzOg7R11oJ6xLW3visYlX?=
 =?us-ascii?Q?QSfsXoYJPv3uhgFxpZXoNVqmfN4E4CIMLlcQD9zJB4bmcE1dOHqexmkBVcvk?=
 =?us-ascii?Q?Fwsvpj25k/O2rwA/iZ2fMt5OeVgFX0LP0CP9h1JbD3i6oQTg0ydOo+T2gHsR?=
 =?us-ascii?Q?TN8MZEmliXXB1y79TvLtsVDSWEFBFKwQh2RpFrQCQiZyUnvj/qodzeu1XdVH?=
 =?us-ascii?Q?ARZfKcvmnllpHbemwJq3Ef39nvqA3anqCSC00MlWJg4Rhx7YtwhELnGZ8gW9?=
 =?us-ascii?Q?R4m3gPcbLeEuNGTw59Gx1W9BY+KqapUWJlUMAkyiYqott1z54tlT96MuY3Tg?=
 =?us-ascii?Q?n85MzmCjxe8LPXDAmNdBPJ7ry2zfzK9iNM9o4URD9zihepLy4NFUlSwngGOx?=
 =?us-ascii?Q?Gtz9k6piVdEl4xpsKToXJ1bprXWgA+sEz8lF1cfSEYEtXxOC9GebXEhOnmzS?=
 =?us-ascii?Q?WS/mQ1LqFSqNGNeAGMhUd5hauO7bwv0zH6tMYOxCWqaiBaoX/N14zihWm0yc?=
 =?us-ascii?Q?JpZ7l526a4pWsLwHTywQ9PKS+oUl9O+MfoT66nuv215ADZ8JIebnoIUJw7v/?=
 =?us-ascii?Q?O4xLH1Q8uC3fTY/E2RQWXdx/AfzTVPzO69IE2E2ivbxDaiskSBFCZ37GD2SY?=
 =?us-ascii?Q?rfZVU3I0AMwH40Fw8W9+yg1PiTuKLyP2IrGh/fkM2jhiet/5cl1XeBWxGzYI?=
 =?us-ascii?Q?UAQveosDsUaleGHxApo2/jVw5IIAtuSoX+irzm0Hw9fy8Ut1sMIXJmmeuRnp?=
 =?us-ascii?Q?+QT+3Fvvk32oPpQWwqhd+da5K1Lm/M6u0RoK15r0ftV2cpDbUelsVy6N/69k?=
 =?us-ascii?Q?GK/kTmP0g98PJpqdwPSGaNjIL4xVys5zvXjDQxuGbOJ9MxSZBsZRZZIzuxb3?=
 =?us-ascii?Q?XFsAACe55VKF0jH0/iHMYMfiMqXJSa6vvpi+4m4Fikyxq1PJdFJuj+haaSK2?=
 =?us-ascii?Q?LO+znrpQsD0mWCyXU/aaHtY6cPFAOLufITRKuwpUNY/w1K8DROgn2bFDpDD1?=
 =?us-ascii?Q?TH+pG02z16rC4S6CXDkXfR/NuPWuTmbQOWSMu08k8J0kWhThugMdvJKlKcXY?=
 =?us-ascii?Q?l26dW0kxWs0pyODGwfln3hxdmASJcH43O9a3Au6jC+nE5f6ISw4yKKwB13CQ?=
 =?us-ascii?Q?LMoJ5R7XMxdTSkue37jFjPwUSwB4pLULxm3c?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 07:59:45.5414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a45924f7-01fd-4d00-b50f-08ddb55094d9
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000040.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR03MB10322

---
 mesh/keyring.c | 4 ++--
 mesh/keyring.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/mesh/keyring.c b/mesh/keyring.c
index cb091e15b613..3a09876777fd 100644
--- a/mesh/keyring.c
+++ b/mesh/keyring.c
@@ -67,7 +67,7 @@ static int open_key_file(struct mesh_node *node, const char *key_dir,
 }
 
 bool keyring_put_net_key(struct mesh_node *node, uint16_t net_idx,
-						struct keyring_net_key *key)
+					const struct keyring_net_key *key)
 {
 	bool result = false;
 	int fd;
@@ -191,7 +191,7 @@ bool keyring_finalize_app_keys(struct mesh_node *node, uint16_t net_idx)
 }
 
 bool keyring_put_remote_dev_key(struct mesh_node *node, uint16_t unicast,
-					uint8_t count, uint8_t dev_key[16])
+					uint8_t count, const uint8_t dev_key[16])
 {
 	const char *node_path;
 	char key_file[PATH_MAX];
diff --git a/mesh/keyring.h b/mesh/keyring.h
index efc499ac267e..e2088edfde14 100644
--- a/mesh/keyring.h
+++ b/mesh/keyring.h
@@ -23,7 +23,7 @@ struct keyring_app_key {
 };
 
 bool keyring_put_net_key(struct mesh_node *node, uint16_t net_idx,
-						struct keyring_net_key *key);
+					const struct keyring_net_key *key);
 bool keyring_get_net_key(struct mesh_node *node, uint16_t net_idx,
 						struct keyring_net_key *key);
 bool keyring_del_net_key(struct mesh_node *node, uint16_t net_idx);
@@ -36,7 +36,7 @@ bool keyring_del_app_key(struct mesh_node *node, uint16_t app_idx);
 bool keyring_get_remote_dev_key(struct mesh_node *node, uint16_t unicast,
 							uint8_t dev_key[16]);
 bool keyring_put_remote_dev_key(struct mesh_node *node, uint16_t unicast,
-					uint8_t count, uint8_t dev_key[16]);
+				uint8_t count, const uint8_t dev_key[16]);
 bool keyring_del_remote_dev_key(struct mesh_node *node, uint16_t unicast,
 								uint8_t count);
 bool keyring_del_remote_dev_key_all(struct mesh_node *node, uint16_t unicast);
-- 
2.43.0

