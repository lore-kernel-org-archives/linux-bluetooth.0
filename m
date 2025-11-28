Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013017.outbound.protection.outlook.com [52.101.72.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3C124E4C3
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 01:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764295114; cv=fail; b=Y0uwAFbIYrrEAzF3dUxnotG+8O+1CD8LzD+pk/8CevaTt3Uoz+hIZ9dk21tc+zG8zs+AvPL6MViuXpYwaQxreUNeGJ+9vS31e14T8opsZSNPZR//ZZ842AUwmg6tQmxqN9daj2Q/hT/LKYRiUjzOzEJWzvPcb5RJLgFTATMcmiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764295114; c=relaxed/simple;
	bh=nUE919yC7+ZWGFZ/AoJ0G6H7INzM2EEBxKVmzH7oYyo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tuouwt/qDpwItJvzS4YIr0kWYbeB8mSNmlz6vEikFSkNnzbQJ3Grfe5HOSz11lST2H/sqqdzq/4G3YW86n6Fn3Rm13VqLq+lmc8rLYi+roAOPwW9PuLE0bYOfH1erXFyLFGoETLdn28pgHiayK/8sKhLarA7Br6zRNdktgOv38U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=GAOJxILg; arc=fail smtp.client-ip=52.101.72.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="GAOJxILg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PcXCEQe1Btnu+GcYMbnJjCGco7gAdM4TsgWPjy7HK6+97DXD89TNcygJZGA8nD8uCwpidrZxGgtUNgnGYUYWWgjK8+imQ2YDvZ9H+E15zFsTkWcPnOfYvQWZozUjDx0O/yuBL6x08+41+zn+8URLIbvxq+YWh19X/mWPa2jkT2vmIBzl8VhcoKEc0tJnFFAkQXzwSh1ThiZ8G8rTqDtgOXMVgOWQQVv4UlgzOyTiirF6haRg0pL3IeoO3FEL11WBkdheWSAvZWjXy5Ww1238wbMmnG7/1ObNRFhpPeg7sDuW4oY4EdbIhSXol9GkjYcYQGaLbHxm6LCHysJ2cCJ1+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xF60Pxuu5Vpjfa8FpOh/Tt3sbwxa1xiM8yWY4q7RrA=;
 b=x3XqwhmvQguSZo7q1qFQBaiwP1T/e2jcPpdKoCTRAaIURPEdxbPudoVc8TH1I4njqD9M3/g9FAfBX4K2uNT55UGKSjbOhSSpz3InteRK/bnWbbuzXAK35WqS0eZfnLa4qjzZYqATM76SsaZ4Xa4PQM2536QMTBAX0D4EbgqehXthsGSa5EfXXzEa7Bc8SGEb7W5NBBkfCCjl5iFxlLuWng4NeDYuUr6ooESLF82+sgEK0BSUmF53yDwc6ZnPyH2BXpL8iVqvOrxUkSpWng+cuioof7AdJO6cEdT3EDN7kMfVGLRtPSXtZWbtWSHpSOEWBJbEk7kJdHGA8N9U3hwjOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xF60Pxuu5Vpjfa8FpOh/Tt3sbwxa1xiM8yWY4q7RrA=;
 b=GAOJxILgSSBqA3MDequmcUADuRGOqYPktfcK0bJCGcYoZKXgISdKfI47DWTb77SN7fbabmzb6AkNgHyr5717sEtkDh2bG/cgNWrvQdqFSaMGRl4820GBNIR8zmcAYbgJRPEnMobZb+4xBJel6iCAfAFYJyeN7XRE6HQdfFkV3N8=
Received: from PAZP264CA0182.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:236::15)
 by DU0PR02MB9244.eurprd02.prod.outlook.com (2603:10a6:10:474::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Fri, 28 Nov
 2025 01:58:28 +0000
Received: from AM4PEPF00025F96.EURPRD83.prod.outlook.com
 (2603:10a6:102:236:cafe::5f) by PAZP264CA0182.outlook.office365.com
 (2603:10a6:102:236::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.13 via Frontend Transport; Fri,
 28 Nov 2025 01:58:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00025F96.mail.protection.outlook.com (10.167.16.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.0 via Frontend Transport; Fri, 28 Nov 2025 01:58:28 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Fri, 28 Nov
 2025 02:58:28 +0100
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Fri, 28 Nov
 2025 02:58:28 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Fri, 28 Nov 2025 02:58:28 +0100
Received: from lnxchenhuiz2.sh.cn.axis.com (lnxchenhuiz2.sh.cn.axis.com [192.168.77.59])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id EDCD77E5;
	Fri, 28 Nov 2025 02:58:26 +0100 (CET)
From: Hermes Zhang <Hermes.Zhang@axis.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Hermes Zhang <chenhuiz@axis.com>
Subject: [PATCH] main: Fix wrong option name in LE options array
Date: Fri, 28 Nov 2025 09:58:18 +0800
Message-ID: <20251128015818.1838246-1-Hermes.Zhang@axis.com>
X-Mailer: git-send-email 2.49.0
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F96:EE_|DU0PR02MB9244:EE_
X-MS-Office365-Filtering-Correlation-Id: 696dd701-8759-43b2-a749-08de2e219ff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hrGHhavc1Twyj1p6RInz9u9LoW4Pu6GaaHCV7EOE9BPNkvpXxwzRuZSc8ODn?=
 =?us-ascii?Q?oHnJWyWywDdMQ94z8lX2tPyS2Laa6l2E0MEotR+yyEiYixACkJph4z9HQqe9?=
 =?us-ascii?Q?Ye5NPcdrqz3C/zpqRhabebR8rODX/WDL0+FOv5GmEV/CE//07lgPvpG9KidI?=
 =?us-ascii?Q?7I6IqCYt5HY64qRWZEHt/liwsbz5vCjbDa7ivSXO04a9Q65Nh0d7gdacnIuM?=
 =?us-ascii?Q?uAjFANr1O9j1aOaAz2XrCXhG5FfEdICbiJKujqgFqznlEVZN4naOm6VKYx66?=
 =?us-ascii?Q?yJn8AxVdM8SklR5nYoS+Ta/V9MiRyjsOD3ahujbIXdqI+JBUn7qlue0jR/oN?=
 =?us-ascii?Q?OROoZtxfvKRHYGFRoCHN7kTqwg5RowHPNQHgnbo0Hrjj3JhemmmTlXZWUSMV?=
 =?us-ascii?Q?MQPSGP6Yy0G/0/zqHMex3yzUPPJYM1RtUeG7SmHze7i8iHfCLp2vw1bt3Nxs?=
 =?us-ascii?Q?MSSA+PaqS8tkyp/7QCr17MNkhxB9UXLrQKIT2JkU+YX8/NujlHcghipwD+JJ?=
 =?us-ascii?Q?KR1znGkz4rGMM/JdqIzIilvc3AplkB3ccdKEEyOm+DEendU8eHz0vpHP+iZS?=
 =?us-ascii?Q?hP4QUj7p3LOL9DI0fAOC+OEsvLpr8D4W/B4umaKztAt2dhG563hs6eRtMrzC?=
 =?us-ascii?Q?zQA/hoqxKix4ap4eV/BLQSvC2qGKFbh222XWasNRA+w1UB+biUt/J+zPOq1f?=
 =?us-ascii?Q?Xu/gHwhWKZa2OvmuSyZynpGiNiuQMaCMTtbD0ehJWbWTY81/qMonJB3kmM0K?=
 =?us-ascii?Q?x36oMzuXA6jQcQuiq+Z6QnvoYCa6ATYtd5OFPVnKVfZjCXesgA2XAvr9+/+4?=
 =?us-ascii?Q?p52ep3yAHyfEoYdHFyWzpNUMfA0TzJJNsq3UVXkbD1BLOPDRaawUc4qjhtTw?=
 =?us-ascii?Q?E5ibA+yyqJ7runL15c21WHGI6OowHNHRBSftn2NPx6XY+WsOkHHd26YNCTAr?=
 =?us-ascii?Q?0bH3/a/DdqjrBruHZAnpF1EMbpUkLti0BLLY7a5TnTLQg0gj0RzB6FF4kCgN?=
 =?us-ascii?Q?8iNwEL2F5XE6PjH1oJ81bn2sdZ87gA0IauXorWk0P5hK3l+xxXBTJUoZ+n/N?=
 =?us-ascii?Q?GmRXvpf6Yr1MF8cA0/Vbv50ENhtVtb4yO/ImvcdhlDCPUfbsnweTmB6tqdW8?=
 =?us-ascii?Q?Qqbi28Gnt+h0SadVpGXic8+OVbvYCdvsOqxYMd6T4k5Ea/0IpiqTQqJ8g5ZJ?=
 =?us-ascii?Q?1qclwZOOxAKgnuboY4G+U92sm5VUPyaNsXLrXY0Q3dPROBRixc8Y9fTdfF//?=
 =?us-ascii?Q?TdTTg7IGdZ2dvrbIZMn+1QHXqwzNRF+AcUBHbrSLvbmmD9zH9HlwU+o9bTWP?=
 =?us-ascii?Q?QPh0Eug3u4NmqkpOfLNh0eulKorlK/uAi0aVhbcGMeMOdmJ7rKtovq+1EeqE?=
 =?us-ascii?Q?ZKSgyYCehcrdfPcPiMcEjSajAzMeIZH7K0M35DDzmLRa3s4Vr55mqdkCaR0s?=
 =?us-ascii?Q?KqAeTnCOk9kmQvAOWeB1rHvmeYEUnsozU/mLbPKS2Zn0JqyRQEGvTjKm1b2u?=
 =?us-ascii?Q?fnjqpBCZWjso5JMr8UrjU/Tl2p3xWYwgqNovEad2ueIarivmpQkeHN8NKZLS?=
 =?us-ascii?Q?Rp4iCPVTX3G1slVmtzU=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 01:58:28.4916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 696dd701-8759-43b2-a749-08de2e219ff0
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F96.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB9244

From: Hermes Zhang <chenhuiz@axis.com>

Correct the name of "AdvMonitoring" to "AdvMonitor" for consistency
with Bluetooth Low Energy (LE) terminology in the le_options array.

- ScanIntervalAdvMonitoring -> ScanIntervalAdvMonitor
- ScanWindowAdvMonitoring -> ScanWindowAdvMonitor

This will remove the confuse warning message:

bluetoothd[973]: ... /main.c:check_options() Unknown key ScanIntervalAdvMonitor for group LE in /etc/bluetooth/main.conf
bluetoothd[973]: ... /main.c:check_options() Unknown key ScanWindowAdvMonitor for group LE in /etc/bluetooth/main.conf
---
 src/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/main.c b/src/main.c
index 1c7390e63..558bf2888 100644
--- a/src/main.c
+++ b/src/main.c
@@ -120,8 +120,8 @@ static const char *le_options[] = {
 	"ScanWindowSuspend",
 	"ScanIntervalDiscovery",
 	"ScanWindowDiscovery",
-	"ScanIntervalAdvMonitoring",
-	"ScanWindowAdvMonitoring",
+	"ScanIntervalAdvMonitor",
+	"ScanWindowAdvMonitor",
 	"ScanIntervalConnect",
 	"ScanWindowConnect",
 	"MinConnectionInterval",
-- 
2.49.0

