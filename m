Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011059.outbound.protection.outlook.com [52.101.65.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E76A1A8BE1
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 10:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722421454; cv=fail; b=No23G7o8tXshWCfMLUdCy35U25nG8dlhR1Rn9cHsU2Z2SxjHohxKPWWmwsgVZEriA8ZiZ90SjDTSljSX0bLH6kfNqTZtHfhu7PuNxrBmCIXmpTW1YelCJ16DcrA0Gya96e1UQeOj8DJ5wczdoAKuwA9oDk5MIhRWivOWeC2Dvro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722421454; c=relaxed/simple;
	bh=puRDau03x/Tc8/5A47k9XiOatYW+NiM6XvFuMFfIvsI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R0AdQVy6lkV63Y52SyzV2iYEG5vxOC9a6hTmcFf6SV0ixCN+6tQ8L6mjZ4rbG9eRSlNXVN/qoqJC4tRw/507w4lqK3eh+ftJbhi7Qe26Vc10TF712KsoUuyH95VgS+ismoJ9Yl22YG+MgeCiNI+hqUEDY8CqJPFAj0XRlTcbXP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=IQhD/F+j; arc=fail smtp.client-ip=52.101.65.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="IQhD/F+j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGfeN2eTx9MFfsi7vAwMibpTfyonNcMBBXgfUY46xNovPLMjnV4+KNI0xj6rxB6t+cYf6qjuJFwmq4wfmB4of3cajXupZVdsIHXjpBN8lCH0NjXKcpp6bKeE1pdla4NQQLmSAQm640P6sXhqFVQiErN269ESYVBhax8J2nETZ5pxUiIpxiE+IqCUxdsnG3erkXJjTRIaCfi8ng5Hv0Fu9OKs4n2pq/OLL8ZOfBzysAFur680DCcsECbgF03LLObYtqq5OEz8iLR81ffm7Zq10M5I1amcj+lyB6fwUruppMnL/C8XxxL79q1ALAvKeXYCJwvcUxM1JmNYk9Orj1UMFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+u138ZFW7JQIfuBCEhVVWSSZ2MegBg8DZBVfAY2dMuU=;
 b=NQFL0VMATNM2GkdPDY8+1DPK0F6uD1DQxniQPbrZyX4AJluvQAOTGei4rPZNAgBrjmu4jkkiZFZkxxTu54WrkajObpVbly/ZoK1EFsY4ze+nSCpRTUU278dyfc6A+t2sllHswCCJ6Vs0q77UZbuBB9Ar0FWMN5+8A4FEwC2xTDADMxYsmk7o1/lMQH0ziDa08AerQqozQyKYGUwtFCsxRNapsbfQwVfUq9zaLwXChI9FTfzt9+1IjYRyj8RB4pkcSLDvGRVZykGpBzoCPPSeD5ttBY3nqBBa7R5SiuvZTA3Hh5ELz0kaSwrcbq7Ra8Z/SmQl8IOzVEW6EPKhn0vbuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+u138ZFW7JQIfuBCEhVVWSSZ2MegBg8DZBVfAY2dMuU=;
 b=IQhD/F+j1R2Jl9dLe9Lvx9U7+AmpiMVyZTE4EgM0SL0ijEM0gUZtByjkP1tVelZ1HSrifFPxY+HKxM+udaxsYQrZWx7sSYY1RZ6Q17YKLcdno+LVIv+hxeH30IcLxYBGu+emu87VptKialqlW5KDjzXSqxEAVeJ7Ymeo8iZO+nc=
Received: from AM6P195CA0073.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:86::14)
 by AS8PR02MB6885.eurprd02.prod.outlook.com (2603:10a6:20b:250::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 10:24:07 +0000
Received: from AM2PEPF0001C712.eurprd05.prod.outlook.com
 (2603:10a6:209:86:cafe::b0) by AM6P195CA0073.outlook.office365.com
 (2603:10a6:209:86::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Wed, 31 Jul 2024 10:24:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF0001C712.mail.protection.outlook.com (10.167.16.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Wed, 31 Jul 2024 10:24:06 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 31 Jul
 2024 12:24:06 +0200
Received: from se-mail02w.axis.com (10.20.40.8) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 31 Jul
 2024 12:24:06 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 31 Jul 2024 12:24:06 +0200
Received: from pc48844-2217.se.axis.com (pc48844-2217.se.axis.com [10.92.172.48])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 1B43829B;
	Wed, 31 Jul 2024 12:24:06 +0200 (CEST)
Received: by pc48844-2217.se.axis.com (Postfix, from userid 13016)
	id 18231287A5C2; Wed, 31 Jul 2024 12:24:06 +0200 (CEST)
From: Alexander Ganslandt <alexander.ganslandt@axis.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Alexander Ganslandt <alexander.ganslandt@axis.com>
Subject: [PATCH BlueZ] client/gatt: Set handle before calling print functions
Date: Wed, 31 Jul 2024 12:23:21 +0200
Message-ID: <20240731102321.700398-1-alexander.ganslandt@axis.com>
X-Mailer: git-send-email 2.39.2
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C712:EE_|AS8PR02MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 598437fe-9645-4970-bdb5-08dcb14ae893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jxPSFD62L52Qp5XXz0AGmQnHJLC7Em1LVSyk/UeMuK4PFf8d0i/gm7c5UMQE?=
 =?us-ascii?Q?3183/f3UdqC/IPPXnDLs3RmEmhU8NUH0U4DM6/qfyMpZPhYJwL/ZAP93lNKs?=
 =?us-ascii?Q?rTwFaX/76l8i6z4SW7F2a6oZasHM1WGBhF/siuWggMnxODGd6rtHeCbfItZl?=
 =?us-ascii?Q?i+MC8iH7MHJTND5nGXAtLsloDZs/J/wQzpblv1KbY7WnUWW3eN1RvW+P+Icd?=
 =?us-ascii?Q?3DreD4sj4hOLQgvlGUVO1RkSsWw0KMGP3lucDbPlQPBUe5NrxK6nonYZEVv6?=
 =?us-ascii?Q?GG/yBFIg9Y5ydWRN8Tz/kHPHioZzYgqAneTliyrISVzePCKJ4bCn+TKq9ccm?=
 =?us-ascii?Q?Q6xuIxkQKqL5ADyQBujWenltocsHnPQsQBlaSkwpuyH8BRscDSFZprGYhktp?=
 =?us-ascii?Q?ciBFlfEAlt4MUofN0b5dV75EYeJsnqVOmJL/2icR8iFdi6uqOwkhSYqKTecH?=
 =?us-ascii?Q?4zikS+S3Fl8wwfBFsHF0cSdbHgEvU8bSPy/SIFiqt0fDfemQTWXJloDvO77d?=
 =?us-ascii?Q?KRq0OPO8pK1MFXnumVh6RITwXRL2ksM9q3ZHrRolU44IwBXjYzgjL6mF6Maq?=
 =?us-ascii?Q?8KnnCazHqCItT+Inz4y5NTzc8Z8p47cTv1fYKvYxzaj4MzrCNU4Prh1NxNKT?=
 =?us-ascii?Q?ymcnMyDGcMWYtJH0qA7qe2CfNo6/mOF74rWqqAq5jbU14rDh3q573z3URbHA?=
 =?us-ascii?Q?BlcKt3+qVmRMRrDKCOlEe8Y5JMNvcSTcstL5smNRJMp61Uz0kZhfHhizK4wj?=
 =?us-ascii?Q?lCrdd81DTEqScrO4qnKMoMkzinM8tWrhVMLlTZg4s1YZEaAEjOGQssGwCpGt?=
 =?us-ascii?Q?eE3ArFH4oDK/vUh20pkjnO72o//ck2qXtzyyP/cUf6IK0ANjGjkdeJiHbA4A?=
 =?us-ascii?Q?SGCsgh2t1F9s11semT1WSwLy+VJafcii5KXhAVtgQEEyUsPsJalgYUf+TrY+?=
 =?us-ascii?Q?ZUb022Habfm5mqr0VPs/3UOuyMLDxMODEx27wPeIhHY6bGuBiQXAyV0Iw/M4?=
 =?us-ascii?Q?QjrQm+JidfnlAjbp8HxP6YjQuUywH152yIW9JOSVyfAdYyJ88E9+mvUSv6q9?=
 =?us-ascii?Q?M08eWO48ptJqZrSkQqKSQcvFMvc0psbjHLNnLw4MmSf+Zc8ri8hqSxCq3WUl?=
 =?us-ascii?Q?XDDg3MNOlkMBc/BreD4m3yGQCpsMO1V7N08Pfnb75rwkt5x8FLpS0VQMsw75?=
 =?us-ascii?Q?3MSpbfecbcvSEwe6cJxPBVK4tgvCZrXYz4pSGjXOmjhzSqdldhPk++23+W4/?=
 =?us-ascii?Q?faMMITHkHYK135Dgl/yh/ny8kbMmkU2LM5DLdSGxEbOQ7YqaL0CwDpRtA/Hi?=
 =?us-ascii?Q?CnCZlvLzv+t1jdNvdWzDpAsVjVy5JS+fYtKc7kD5BJMtHDr2Kx49oCBXcfJt?=
 =?us-ascii?Q?qfnrsPaTVzxDMVCuHRxNJo8+WmbSbSAvl1kHh1QX5SayOE49MQTTk4fzi4Mc?=
 =?us-ascii?Q?QGchMe7OzNzRNAwrwiuRHYsayQZgDU3A?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 10:24:06.6991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 598437fe-9645-4970-bdb5-08dcb14ae893
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C712.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB6885

The print functions (print_service, print_chrc and print_desc) all print
the handle, but the handle is never set in the struct object. This
results in the handle always printing as 0x0000. Set the handle before
calling the print function.
---
 client/gatt.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/client/gatt.c b/client/gatt.c
index e1d2b545d..4dac88590 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -165,6 +165,7 @@ static void print_service_proxy(GDBusProxy *proxy, const char *description)
 	DBusMessageIter iter;
 	const char *uuid;
 	dbus_bool_t primary;
+	uint16_t handle;
 
 	if (g_dbus_proxy_get_property(proxy, "UUID", &iter) == FALSE)
 		return;
@@ -176,10 +177,16 @@ static void print_service_proxy(GDBusProxy *proxy, const char *description)
 
 	dbus_message_iter_get_basic(&iter, &primary);
 
+	if (g_dbus_proxy_get_property(proxy, "Handle", &iter) == FALSE)
+		return;
+
+	dbus_message_iter_get_basic(&iter, &handle);
+
 	memset(&service, 0, sizeof(service));
 	service.path = (char *) g_dbus_proxy_get_path(proxy);
 	service.uuid = (char *) uuid;
 	service.primary = primary;
+	service.handle = handle;
 
 	print_service(&service, description);
 }
@@ -253,15 +260,22 @@ static void print_characteristic(GDBusProxy *proxy, const char *description)
 	struct chrc chrc;
 	DBusMessageIter iter;
 	const char *uuid;
+	uint16_t handle;
 
 	if (g_dbus_proxy_get_property(proxy, "UUID", &iter) == FALSE)
 		return;
 
 	dbus_message_iter_get_basic(&iter, &uuid);
 
+	if (g_dbus_proxy_get_property(proxy, "Handle", &iter) == FALSE)
+		return;
+
+	dbus_message_iter_get_basic(&iter, &handle);
+
 	memset(&chrc, 0, sizeof(chrc));
 	chrc.path = (char *) g_dbus_proxy_get_path(proxy);
 	chrc.uuid = (char *) uuid;
+	chrc.handle = handle;
 
 	print_chrc(&chrc, description);
 }
@@ -347,15 +361,22 @@ static void print_descriptor(GDBusProxy *proxy, const char *description)
 	struct desc desc;
 	DBusMessageIter iter;
 	const char *uuid;
+	uint16_t handle;
 
 	if (g_dbus_proxy_get_property(proxy, "UUID", &iter) == FALSE)
 		return;
 
 	dbus_message_iter_get_basic(&iter, &uuid);
 
+	if (g_dbus_proxy_get_property(proxy, "Handle", &iter) == FALSE)
+		return;
+
+	dbus_message_iter_get_basic(&iter, &handle);
+
 	memset(&desc, 0, sizeof(desc));
 	desc.path = (char *) g_dbus_proxy_get_path(proxy);
 	desc.uuid = (char *) uuid;
+	desc.handle = handle;
 
 	print_desc(&desc, description);
 }
-- 
2.39.2

