Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013004.outbound.protection.outlook.com [52.101.72.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FA544B676
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772208253; cv=fail; b=nvj9lnSE0JJmjIA8KLYgtaMZzmZxfvdeSGk5NGVc35K/54tuEAmUwQ4e9TinBw2zrIbm9D8hnobaSoND0mxW7+omb2Ey/gpXiqCJTayVLQRcAP3p+2ki4cfKfTny8hKtlYo8HbpIiUAGsat4Y+SQj+8BbOQ3Bq83FS4eOCsV42c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772208253; c=relaxed/simple;
	bh=xRLqfTmw8L31RBeXC3zZdXBjZ5vZzLOmrDfH35514gE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kKgzUQh6eDvp6/1rPZZU3OS0lcMnTierxnVmlec1ulqE+CMgvJBnVCTZMfAWqcD4dmbC98du2GnTRF9b/hqANGlbOZua6kRqV3wJWfmSl4Z0PKNiONueZgftd62CqHX22BOwKtoX/UXuZZ89o7IU0h8N2QR5UoJbREyXerc8+yY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=EEr/2hN4; arc=fail smtp.client-ip=52.101.72.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="EEr/2hN4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SukN4xGAtPDUciHw5mL13XHfNqKgccoD0NDOzDer+OQomKfRC+KyqPJBSf7BiA/92yb1wTmukehI7MZNU/4WzuvtCgU+MHhk3n7MZvDJqWP1v45LmxCOq+ldIVn4pkHncIIzkPK4XnhHrtPEseKdKY4XdCTfZzinjm3R66r8yoxl+UVLT3sek3QMbDgjbAqkD2UKmgaol1USGuIRq9HWbGxu6iHCxkt0QUqSJlfwQunbILSOmIgOPgxX/R/xQXZUdERLxzB3oCuNQAr/bZe6ipc5BFFHRAHyViBDCfMK+/Mj5mF5NZvJJr6XNkGmXt3sTYpPLsmFYePhf9duMGs2bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ii5V1Q3XTs+1zcVhIf1fuOmilago6KK+BRmYojRE4vw=;
 b=f+GbhKrVFRYZk6gE9fqb29p1QLPdxC2IhiK9qrX2oWd2XZALwnXUi1b6qAocrE3GXWZcLlKiR06QkEdkOycZtPNJlyR+iR7rbS47iimv0mO7GGxTf/1hI5Mgqj8waKyu1FQZ1pxQRuK3eMUQ0DmpXhzRSzniNK/O4icObPNKqs5VEeq50thcc/3ELLYyslr9c0v77PebhCB3YUuzWRSizwSJGG5NYuwgvMX9sFLLZlmWF88L8eOuBtDvHivYswhQHh+j6XNPBwpuTP1g/bg3HL+yATXLDOaA8MPjbHK1t2tr/Fh50GkykZpCD27ugtv+2U9rW5OIK5HKP1w+QUl7eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ii5V1Q3XTs+1zcVhIf1fuOmilago6KK+BRmYojRE4vw=;
 b=EEr/2hN4hieV7yjteQP2r2hsJyQcVC+ay/aoEsuV9HxvE34W/rLmJMPbhS20ZdKS1LvsSZnPIMWt33Z/BIeAk2sXTy7owVIjjqI+O9+pnifPf8VhSC9HBANUtlKvMS4nsa/vGd7+CoTyVoEspr8oyrAIjK/R/hDfv/kOfWwnx5E=
Received: from DU6P191CA0057.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::15)
 by AS8PR03MB9165.eurprd03.prod.outlook.com (2603:10a6:20b:5b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Fri, 27 Feb
 2026 16:04:07 +0000
Received: from DB5PEPF00014B8F.eurprd02.prod.outlook.com
 (2603:10a6:10:53e:cafe::41) by DU6P191CA0057.outlook.office365.com
 (2603:10a6:10:53e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Fri,
 27 Feb 2026 16:04:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB5PEPF00014B8F.mail.protection.outlook.com (10.167.8.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 16:04:06 +0000
Received: from N9W6SW14.arri.de (192.168.54.16) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 27 Feb
 2026 17:04:05 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <frederic.danis@collabora.com>, Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 09/15] doc/qualification: gatt-pts: add description for GATT/SR/GAW/BI-39-C
Date: Fri, 27 Feb 2026 16:53:55 +0100
Message-ID: <20260227160022.21462-10-ceggers@arri.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260227160022.21462-1-ceggers@arri.de>
References: <20260227160022.21462-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8F:EE_|AS8PR03MB9165:EE_
X-MS-Office365-Filtering-Correlation-Id: 96705063-95e1-4689-a533-08de7619d5c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	PtS6TWwMV1JAOmCQE6I30IXyPOuMC63olZOOS4r6Loo2aG2CI7moPXPKa3ssyrG1T3VTc9oNlpcFQTGMFJ/4054qmlL4Qdpjqb57qBIsLuLzYfj3IhOSb5GHMPJyQ7arcV+2yOkEAlVodQqm0jRrwChj7u8kkpu+9swYsyegqf857rNM0lf7c5O3/4m6jzCXh9g5mY1/X7h6Dhrs0dBGT2CzjRrP6AtCdZ5rjO1feQRbs5r8F+sDwn4ExC48VrN2ggfxA0OCyxgoCSWLyCo7jjvPOINt0v14QB5mpQhA4vfXHQQbWxaqnbeGZJEaq1yq//errMwhCL20pbjJh4evS53cSzUCt6DAXoQX621ZN7so3kBobXRjFv/6bl06sE4z6KJlSqeDX++WK4J11smdXZGgDQvFHzNGnwitms+PmTBYBNQHIHaWigxdTH0fRSi6i7cpTGSJ7oEXT+763ATxvUbjWdyy7h1K9wxcs7UA/avmhFvC+9QuHHn4FgnrGZrlEOoAGJGbUvsng2bZ3nCLCc8pkarhigjA0OhHcCMXSevl2osc1ty/txeFMdlk2/kPjc9Nr5yD5cPwe8p65d5uXpAwtMgevAmJ4ORp8H1ktPi7lYIiG4GV4YotD0Agm8y530hf/Be1fUME2zyGqsSxX3pnQn7K9ny2yvt6P7UEdwP9ormOt3R9dbS+wfRg0F23dyhet9Lk3IAmoKZxJ3XDtYkyRT7i1/rHxOm/GRjq/bY2H9v+65RCuPhfQhYMXWf8sx/IV3eW6LAuRwXWuFajZrOHSy3LU8El40xSaj6PhsBtk/JaJ/fkrsp4CiCxDKUW0RQTRYP8wWDWqS/HPw0YMA==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZJ3b9GUBqdBuwKIHGiwrkf8bCd+Dpi3QAXtM8HfsuaffjeXhdw8aEXYt+dHVD/sbYcnRiZ37AkI9Pmhihzmw6aO0nGv8z5pxFGjTwVDmvCmeDzaJyu2iUyItWn5XhY3had/xDeSAo6bA3N2LU8u4PLpfyueMFiSxRVDYakhOJj9HtazZZYmvEuckHbudEk3TLl2cFo43Netum+Y7XluslsfLv6KTnzTSmuB4swvDmgGsK0fGC1LOBT3YxbGk1BumeKxl91o7aPwUMUZD1mAPAtBozCx2sP5I2FFkVPmyUm5xCDhmpC6gvCnByHXFgqFDh1iuT8AiHXhf78Nunk659qQCIPYnfRNnrCCJjknuJiJd9qLXI3ubHasaMD5GF8xue1q82vJa45J2X1IUYcFnrl03u+F0mb5v39fTBE3CcH4k2GZhRM/Dgi4Z95/ZIPgl
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 16:04:06.4896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96705063-95e1-4689-a533-08de7619d5c0
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9165

---
 doc/qualification/gatt-pts.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/doc/qualification/gatt-pts.rst b/doc/qualification/gatt-pts.rst
index 447cf4a66610..239d7c154da7 100644
--- a/doc/qualification/gatt-pts.rst
+++ b/doc/qualification/gatt-pts.rst
@@ -1099,6 +1099,23 @@ for which we know the test passed.
 |                        |          |         |       | Enter the handle displayed for the characteristic during                |
 |                        |          |         |       | register-application on handle request                                  |
 +------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAW/BI-39-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA read,write           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1' when prompted                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Enter the handle displayed for the characteristic during                |
+|                        |          |         |       | register-application on handle request                                  |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Enter '2' when asked for handle size                                    |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
 | GATT/SR/GAN/BV-01-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl advertise on'                                         |
 |                        |          |         |       |                                                                         |
 |                        |          |         |       | Run 'btgatt-server -r'                                                  |
-- 
2.51.0

