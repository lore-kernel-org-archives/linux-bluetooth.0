Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D566C8F5A
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 10:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742380673; cv=fail; b=qBooOsEg5dgd/R1cyBLxR5opFengT1jarrl/iS87IwLqFJQIWrgpo2FEviP77N16GponsSN3wsxtSRO14lU+g97N1LXZETz3lVjTau72J/e2f1FtaCxziG9cBvR9Ux3mmQIUa5R0HoPohbMTzeKfZn7dQhizfKYXtYGNcpADllU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742380673; c=relaxed/simple;
	bh=jXXNgJTWTk8dVuDax09gh/e1IqeS/lxI8waL88eygyw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=laOPsuV6TE22Y9LCSifGOwyt3+QQj3b7EvYF58YkirFfear8eME3QDsWXVsiUPun0fUf+CJ2Aso2tDVvj0ovES1ZcdFrX6oqX3qr4APWM06WbLIKGk9iQ/DYtD7is3yAQ1nn5y6eercgn7SyAGfy40eJrbLzWiJwHMWgWNMcSfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=q6h0KauK; arc=fail smtp.client-ip=40.107.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="q6h0KauK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PU0r2vkJY7rpmzs81SrCt8sMoRcgORRsH/ljp7KvIUR+vP3R14SIlv1EQVMOJs01h0Ldtskw6wvN7r46ioQdNRYVAuxD8MteEBp6n9L5ZH9+g6gbXXYjZ9enlvVc1aqNSeJn7oe/8tRdOut4y0G1eJkIRQCNlNCSfvLQyQvOq6Or4wJxU0HktZJEYvD8oAY9++Bcq4ji8oIPHC8dz6UTZqEaiGZrFUtVoSlUCEvLWadN3izmM/5qU59MqStpPMrQBbwL5CnBewcU8Xw537mlCZ0d1ZyW+UW+AEvCOxMoCGM0CmzHnzQtXHSpGsWdnXHm/dhwTdeJ8ukuNsJt30n0hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTKJO1b3yBpEtZ6cW/yx4Et261kuaISsFHZyANcXTaE=;
 b=s6ywDhBY8Dzvv/0T8GOj/OL9Dimrqf37TalhCKwSvJSVcnaerXzw3P1xsGvdf5U/oHXAVAEYlMG/XPXXtz3LBKbMlKII4fuKqY0evBrY1/vlHud/BLNgXLprgsqGxlHv5RIUt5jfByhol7LOk4F2Q4xiZycFrBH/M88G5M7DiVpsN8LI/z+i1Euf5godCyWtSvzL7IGihblidRY+IAR4QHpgtDEnOYuKjfBkUyNN00Slyb0vjuzHPCm7Drg9C/mobXn/Ve7o6Cv8/Zhccv+lr0tZGBvdwfeH3vLsHEEGKWHrNLvhVhKmlPFUdIf7UbQSngJvMRX+Ui0v3BhG01zCkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTKJO1b3yBpEtZ6cW/yx4Et261kuaISsFHZyANcXTaE=;
 b=q6h0KauKB1vL5QE0ryZ8fv9xK5q9iAAUaJmGHsai55mk5U1QpPd/JpCrRP0/j6ZLKW1bnE7W4jYeALK24nQ/Q5yLt/1vC4INx+p75BHNptPRy5NHyjTO740lF3NmWN21ZZb0EefHosiiohDyAR6mMal72r3gEM0SL9Cdmrm1t30=
Received: from AM0PR01CA0120.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::25) by VI2PR03MB10955.eurprd03.prod.outlook.com
 (2603:10a6:800:291::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 10:37:44 +0000
Received: from AMS0EPF00000196.eurprd05.prod.outlook.com
 (2603:10a6:208:168:cafe::e2) by AM0PR01CA0120.outlook.office365.com
 (2603:10a6:208:168::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Wed,
 19 Mar 2025 10:37:44 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS0EPF00000196.mail.protection.outlook.com (10.167.16.217) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 10:37:44 +0000
Received: from N9W6SW14.arri.de (10.30.5.20) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Wed, 19 Mar
 2025 11:37:43 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 1/5] tools: iso-tester: add inclusion of time.h
Date: Wed, 19 Mar 2025 11:37:20 +0100
Message-ID: <20250319103724.10433-1-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000196:EE_|VI2PR03MB10955:EE_
X-MS-Office365-Filtering-Correlation-Id: fd3273ca-388c-4e13-1f46-08dd66d21561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pBvGECrhS3VCyN/8RSZcF93M7d/AvJ2DBPRkJfrxuO7/3fkflEoP+qDjZaNZ?=
 =?us-ascii?Q?xXgt2a1ZpV6UNL4k076RlTMnZ07UttDGbT8ujfP5dwP65QB90T86EPsVkmf9?=
 =?us-ascii?Q?68t527ZJhI2vmugH747yu0DWIBAwHC7e/XtNYdT/YtYWruhGpga8Z6duvp5R?=
 =?us-ascii?Q?LS7NdYM+Z3ilCv06dbdnzvoI2QdYG1HYJeVqlmgjDOsumyBXjkGw1UvLJqfq?=
 =?us-ascii?Q?Y0xMTXRcFW/fqdrZkPgK11v/Cz2zhs0n1ZPtA0J3lqMz0G6xTj/tYrpwSLyx?=
 =?us-ascii?Q?5RrVVpwAdZLGYiCjQAGBROmseU7EL3jgxNOcZQCNbdZwKOLE7uQ8HyoVLbCQ?=
 =?us-ascii?Q?/mmF4qzzKZ0qNtT8StAQ+XB1mwaMfZduA99OJO+r3nX83hYGKZb7fmOYoPku?=
 =?us-ascii?Q?zxMmMmSMvDsNJJElc135eJekBHUvG7iJ0pChVIJfzzpSrsgMSkVvqKetRedA?=
 =?us-ascii?Q?fCPc49oSWusBkWyPXiWg/BVNxzxqePBHOKKjVVWC5ZiKTYhseki6zQC6o4Cb?=
 =?us-ascii?Q?kKPhCVDsLhWI4D/agzUs+qYDHC3X7XBlNnRKhH4M1dOiuqY5rwASkaaf9IwC?=
 =?us-ascii?Q?/JvJ9QIw1Ii92R5GB+Q01tj+8/qyskmlKjuy789fGrLP2FtzjJYLx9MsXcIN?=
 =?us-ascii?Q?8mA4SyeTIv1tuLASu/WlwYcCqRdmbA0wnLTNpKNvwz2Y/HgeDpgaTnKdpaC6?=
 =?us-ascii?Q?vaDook3kV+6VQCGBaUUBQAKlFnSA8hxy5PkndaI70wVYkDbcfgER2pO0Yisu?=
 =?us-ascii?Q?QZcNNoQ+CjaCgxqvJJrt/HJy7cEAjwYx4Cz6alMi5JvCwExLZjuy7n28m/+a?=
 =?us-ascii?Q?SowzDR9kw7bheOpEkMkkD/GTXHW+udN1d4O4DIuSyncP4H0IlhgWVHkcMDTu?=
 =?us-ascii?Q?v2BPwpLeIF8PFxgxDZ9v//uu5mJap3+ca0M0IfaV/VBpcwlxzgs0w/S6EpWC?=
 =?us-ascii?Q?YhqLDcPwM3is7N1IcFDU14orQkpX3Tr0g+J9QtPl91GpaZ4QJ54b5Yn/dT14?=
 =?us-ascii?Q?K23cAos31n4sj4TYkhdhSNueYVhAS2SXfopXbOFJlnIZ3Q8i9sNHO1DaWEW8?=
 =?us-ascii?Q?Z4JNMuUTp3RDZ9NaV+pYZEJJ9W/J2rLP6PfunKW/PeKqO7QfJ61YpDSMiOfQ?=
 =?us-ascii?Q?8BczxYLNJW/jykYax7zjG2xs7SqrBmDZxS+OS1lWFgS23aarksuISj3x+n3i?=
 =?us-ascii?Q?l3SQQFv+P3TB7U0E6ILFLAw0fgwJ+Bne6sMojZGUbhL+EsMqbS/M0oYqT3Q+?=
 =?us-ascii?Q?fr+H+2GoozDUgYrfS1hHyC2yH0MrzObFpO2J8189Xhuvyz/6HCO6L83B0ayb?=
 =?us-ascii?Q?QxjseYH9eOkLqj5IZHpxWO6hPdGc4vWPkEW2uyCmsCflXWfiuxwfEHcqCgbf?=
 =?us-ascii?Q?JHqhY9nHTE/rodm1/S08QTczqH4lv8quqCF3GKJEpvLTBaovG5Xntn/nWwhw?=
 =?us-ascii?Q?F9Y3bxSgSRbYN7SnYLnHmoI1S2B8ECDco72H1DISwrpGYZKWQiqnEJvL5upB?=
 =?us-ascii?Q?dwj3BvpJUZkWUY8=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 10:37:44.3861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3273ca-388c-4e13-1f46-08dd66d21561
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000196.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR03MB10955

Inclusion of <linux/errqueue.h> requires that 'struct timespec' has
already been defined:

| In file included from ../bluez-5.79/tools/iso-tester.c:21:
| /usr/include/linux/errqueue.h:57:25: error: array type has incomplete element type 'struct timespec'
|    57 |         struct timespec ts[3];
|       |                         ^~
---
 tools/iso-tester.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 640692b779c9..350775fddc96 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -17,6 +17,7 @@
 #include <errno.h>
 #include <poll.h>
 #include <stdbool.h>
+#include <time.h>
 
 #include <linux/errqueue.h>
 #include <linux/net_tstamp.h>
-- 
2.43.0

