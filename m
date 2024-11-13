Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2084.outbound.protection.outlook.com [40.107.241.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4192A54723
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Nov 2024 14:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731507202; cv=fail; b=U9K+0p6vf5qBO19ODxuC5N2EsL4K+Fbt4zQTlyZ7Qi2Hfj+1CzFvSzqvg/eqAxWiPMMyklp0n9/iDsqKkkxnSidq4qChEcowtTx+LH+oMHqCFMELwgqYMg2FYJk4brBOOFCxdG5UuK2FEjGVdlnn5OT8z1Sw2FRCvDuY56ASOps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731507202; c=relaxed/simple;
	bh=PeQJLakcV8Hy+Su6BPt8kF57XfrnPuy5Lyq/DYM/b9Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ek7N7nKKj0A7989Cr5TF7UunyuKTCRfj459x6ZbP1/TGttgNUUeaFg/yCLe0Du4POUWn88H5G9GHyoisZcWMiCY2vqbPfnM4oGEJBO8BxhiN2UlGFi2zIod0SUX7vtAi+3GrcJJUA01LincSYzFAjuAxgff1vGB70OqWvQLZ6VM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=oCIQi3MZ; arc=fail smtp.client-ip=40.107.241.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="oCIQi3MZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKgtZmHhmNyQc7clJjlEsXZRKaIZvlQu0p2DG1/jpYTehIcn+9ldOEtWzbEwOLT5Oj/NNja0VpqUuL+L55T2ujuwN5/U+yeTRKYqgRT8YaTbXjHR8bKszUNjPqxqvjIkTdeMnsbAbb7/uhIrcxeiIT0t/72GbasVLp0V/0QoZOs6mIuBkPKASJzeL4sP4L+aMMC9x0iwWU0gkRYCygiws9/QMdrX4UcKRm+Dyl6vxEtdjGMzU/7LL1p77OA0cVjdy29qdTNiSG6m/02d5QJ9gHls2zvgTxmAsql764plixib2NQwBk9vbiM4bIQ6+8dVCJMmOEsdo5LyefNreviRsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0jQ6tsHr+OIYg0ABAhBjYzXNTFVyRba+WACKmsiz6w=;
 b=Ksp8sD+v+ShI745u1AlY3gBygU7a6NvSnMnnrmZPhyorx38cVRfeBm0V9F2cHRlFgiaKA5IkhV69PFdD6RaWsBhLwS9NzcSoeCbWoWwGG8y/dSUS4MWxn2WPK553RprCMkFKuezGEhr9TMYuAuidBQf+t7oahpLdLLPRO1sMosNe3q31Kyi2UFsBzZKO6bhISPT6wVzYDNUAPeJRDjl0EPZuyKyxfICBiaP0WWWPC/q82wkFPHVweDyJXMGBFTGJSPxf9a2MXbhhM32HsH2nfvEpy1FZDco7Oldyf/R1IOHxcnAc6BWUsdh36cFRwxG8b4s4BAnkWD8X25FPbN54tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0jQ6tsHr+OIYg0ABAhBjYzXNTFVyRba+WACKmsiz6w=;
 b=oCIQi3MZcHOLlKv0xG2dWX1dAWTcmPEWlQbeF5+qLLkQsLiaUYNYx3tMXGf3OxhTSc1nEq1cwi1CAlvr0K6tepH50UrliRvP/nQXdqWocn3kdAFBO6etiIPZsJTta7eF9++0ZK2o6Ut+qD5B9cRTJC3Y+W6a89/Ba01WFnMWnf8=
Received: from AS9PR01CA0033.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:542::19) by DBBPR02MB10890.eurprd02.prod.outlook.com
 (2603:10a6:10:531::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 14:13:13 +0000
Received: from AMS1EPF00000047.eurprd04.prod.outlook.com
 (2603:10a6:20b:542:cafe::6e) by AS9PR01CA0033.outlook.office365.com
 (2603:10a6:20b:542::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Wed, 13 Nov 2024 14:13:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF00000047.mail.protection.outlook.com (10.167.16.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 14:13:13 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 15:13:13 +0100
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 15:13:12 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 13 Nov 2024 15:13:12 +0100
Received: from pc57895-2408.se.axis.com (pc57895-2408.se.axis.com [10.93.175.8])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id C35701A6;
	Wed, 13 Nov 2024 15:13:12 +0100 (CET)
Received: by pc57895-2408.se.axis.com (Postfix, from userid 9907)
	id C00EA40D204E; Wed, 13 Nov 2024 15:13:12 +0100 (CET)
From: Marcus Prebble <marcus.prebble@axis.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcus Prebble <marcus.prebble@axis.com>
Subject: [PATCH BlueZ] rfkill: Do not log errors for missing device path
Date: Wed, 13 Nov 2024 15:12:56 +0100
Message-ID: <20241113141256.602066-1-marcus.prebble@axis.com>
X-Mailer: git-send-email 2.39.5
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000047:EE_|DBBPR02MB10890:EE_
X-MS-Office365-Filtering-Correlation-Id: da01bbe3-3e6c-4ab9-abde-08dd03ed4f99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jj0R3I83x6InPplzUGrshEij818i+9N1KK2aNfFdwVKJGuHSLT9WU2i0n4QI?=
 =?us-ascii?Q?jqhSZt8qHGmlG3pXpmAyzg7/XHfpRSsyk66kT4n8lZ+5wunRPuyV9Rj7/+JT?=
 =?us-ascii?Q?fjsQUQxvtDF3OLOXY3C8jK2Smxy7MUKL/dYbhJ5zNJ0sOvWAIstVrw3ueTvT?=
 =?us-ascii?Q?PDVPE6d8EjUTruoHDk3VpO0o5oHNscoRLvgnFNcih90XeuLXRzYkIotwSZzj?=
 =?us-ascii?Q?ebWJIM9+3YrSrChyA4e9HBBxEmBA68ibxRpdapg5wkCmUx2CWZsfgdHo67Zh?=
 =?us-ascii?Q?JUC7D/J9rolIEnaRDc2tgM//fBAKg4chZtcvrW2CxY7oYIY2Qh5qduCdNMHD?=
 =?us-ascii?Q?23fOoEyVs8EnVR6J/CKQeMXo9aJqunaseqt3p7tZKTB0W46iBklbZrnMgK+W?=
 =?us-ascii?Q?4FpJAEEAA5NZPDDRRgfgyswDkVGMhON1vFBSski5ZX8JjkoSWkf3WsTxG9vp?=
 =?us-ascii?Q?Hu55w3+RhkMW8ha/1y+Iao6kwFzrhW6ViYXZLbCMLq+YPvWcZw0ugKHMOkcy?=
 =?us-ascii?Q?P1b2IbxKsVBp71TvavcWXjuX6qMs0UXShGOZkAcLMB5Aj5iZ6ZlE90kG4Yt5?=
 =?us-ascii?Q?unUfFhdDpW3sbhDD7pvmsiUkCf7wIXKNvJagL+H0TuGu6B87TXA77D94MQJ1?=
 =?us-ascii?Q?oUwc5i0YqagJ85ya4Q4ux8k9HlwljokgPORa7NaNI7M9RLzOcAyyRG1M07+/?=
 =?us-ascii?Q?IUe7p4YDC8BENFGHZL+QuXiHIAfJkaeLhtnQg2ocHIzJL+8MaoiiCQ5QoWAG?=
 =?us-ascii?Q?O8sC6htbcRkXvRQsGJ0Hu144VIheTNfj8z2nsE6aAayZN8MCUCtmFb9tk7Ca?=
 =?us-ascii?Q?0PGcbP4rvugEXi+3oIACH1hzloxcfottT+GLaffpVT4kbFS4EPSZ6x+GxXdR?=
 =?us-ascii?Q?UaH4g+yovQO3Db5X0KByAJxXaFTfltDSZCfcaC4UclQ2HSkZCdOrZEY0Vkcu?=
 =?us-ascii?Q?mgebRJryAn8mnjd2AoS+4C9VPmCPRR1CgYcwprLiaiLCpsnpYgPdtGAaogHH?=
 =?us-ascii?Q?LMpB2mOxvaobayQZZeRr3yFfnbENOsgenhoIZGcXZxUnMt+FV/U1gWuhzEVU?=
 =?us-ascii?Q?fYemEHG8RaBY657KIFoiOi32JV8kezDUq75B2YikC1W4uTllqjYmhO06VG55?=
 =?us-ascii?Q?BohF7XP2d6nDsDsim+ng4cP3PCPmzymR9Mruc5gMtrpwxCRf1hwhompLPpDr?=
 =?us-ascii?Q?8Ile76GsPCU1ysCGvfSIL4/s5gm5PGq+34B5Daj/oAtgT6J1eiloLwvhfIdm?=
 =?us-ascii?Q?+cQ/om4rWcuQ1WgLpWX9ck1w4lCHAT+83CsBD/fmSbaEJmI1djBAEsXl6098?=
 =?us-ascii?Q?odVE+g1dWNyCXaqB4QozYq1xa6LypLIHKJ5ZhKe0XZvhijKrSeciJ1cWPKcV?=
 =?us-ascii?Q?4SxHHlnaffZ5dWA9LP6duG2GmU8sIF1a29WRdza10QGWyfiT5A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 14:13:13.3613
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da01bbe3-3e6c-4ab9-abde-08dd03ed4f99
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000047.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR02MB10890

In the case of our products, we lack a physical RFKILL switch and do
not have the rfkill module enabled in the kernel which resulted in an
error message each time bluetoothd was started.

This commit looks at the errno code after failing to open the RFKILL
device and only logs an error if it is something other than ENOENT
(No such file or directory).

Fixes: https://github.com/bluez/bluez/issues/792
---
 src/rfkill.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/src/rfkill.c b/src/rfkill.c
index 88cad1c9e..ac4a48d0a 100644
--- a/src/rfkill.c
+++ b/src/rfkill.c
@@ -55,6 +55,7 @@ struct rfkill_event {
 	uint8_t  hard;
 };
 #define RFKILL_EVENT_SIZE_V1    8
+#define RFKILL_DEVICE_PATH      "/dev/rfkill"
 
 static int get_adapter_id_for_rfkill(uint32_t rfkill_id)
 {
@@ -88,7 +89,7 @@ int rfkill_get_blocked(uint16_t index)
 	int fd;
 	int blocked = -1;
 
-	fd = open("/dev/rfkill", O_RDWR);
+	fd = open(RFKILL_DEVICE_PATH, O_RDWR);
 	if (fd < 0) {
 		DBG("Failed to open RFKILL control device");
 		return -1;
@@ -178,9 +179,16 @@ void rfkill_init(void)
 	int fd;
 	GIOChannel *channel;
 
-	fd = open("/dev/rfkill", O_RDWR);
+	errno = 0;
+	fd = open(RFKILL_DEVICE_PATH, O_RDWR);
 	if (fd < 0) {
-		error("Failed to open RFKILL control device");
+		if (errno == ENOENT) {
+			DBG("No RFKILL device available at '%s'",
+				RFKILL_DEVICE_PATH);
+		} else {
+			error("Failed to open RFKILL control device: %s",
+				strerror(errno));
+		}
 		return;
 	}
 
-- 
2.39.2

