Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011017.outbound.protection.outlook.com [40.107.130.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1A93F23D9
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 13:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772459185; cv=fail; b=l59GjfSUCfFi0UzIE1DFa+z597QJASA+rvSwugB316ykPy+8v+XKC1KK/TGkshCYjZoi/XidR4PK9yxHsd/WiTDvaP81WJjn6mvQyYnqdCxvD8Txcy6itOOmJBeAdraa9PxlYqXSg6pMVXc1BNoW4Q4+FTk+fJjTIrst2ve0E8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772459185; c=relaxed/simple;
	bh=KVnHQbWlDcWB46i679tiVp8XZwZ+8XHqiI4+pZY3uD0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ijTh3YokKNq8vTGaGrPpVGd9wcY+XHLI/FFvFTNjNVeEZveLj3QNrL2P55lwKSYoJkPHThOKiydwhiJXt4Ki1E/3UbNgx1kiqR9Hp2N6YXXCXXg8K6rQsfzaoMD0EMzYjHNzEWr1cp4tvz7zBU1Bh0nulPjouK9jt8KCPCTEMs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=UQ7c/yOl; arc=fail smtp.client-ip=40.107.130.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="UQ7c/yOl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CrStck4ETVvGSR8j3APvh12c9gfj21WvpU40PX77cA3WOnoQv7RzesUtvmjQsnqhxgBaitAW4vD5Ajlrhe8e/jUpkfk9bk/Erlp+8YYlZqWAtHz0EkFXm86+EKQJAe/hg4008P4TByXYy8J1v+a8hyXwi1OXeAzCZ1B8tFwDf1RPNJc2srHdSv0JsdStY2+sTPWzXRP6JoMgrB4E/kOiP4JA3HB6LpJLmVV9WKjbtgfXXDzwgslu2aBvguYA5xToZcXj4dpQ78Vk9Kx9zRb9TLIevok3Tl9PpySQXCD2665KBjKz1tK5WkZFXcflNp4mZb8uj6ulBgAdLnZz+LSVWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XP7eWED9xdvITX7nXMSJsy7ZNkIBKsAb1mv0+xrOyDw=;
 b=QiwZYuGBSotpJFwzrfXq2I9ck0iI3oTb4Uz74jIVjxRrikuIszFNHjfDRCtEHJzU2C/INlfdxlxrIAUGl+zGweIVkLNA+3ul9Aiu1gd5WSYt8e75pvCb0OdwWJC+bafgz7sTVqm1ISnP/BP8Ci+SFIfoPMhO5SxogYVOZ1Ld+nJvm7zksNLhA/cbF3HfHlkeSFgDYd2zheHVDOOMMNvOT04KqKLR0dl65ziH8iMjkaJmRc645uM0V2SPjDwvXmMmeF+jY3DImeGqItr2c9FO7eoNARTdWp99aChuf2cbPH1nvXeVfKqo1lq+8Efh3g1bWE4meeHPslBG0K5dqrDLSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XP7eWED9xdvITX7nXMSJsy7ZNkIBKsAb1mv0+xrOyDw=;
 b=UQ7c/yOl3jxZ6BDmOKvsblyqYFB0y6OdXlz9yGpjAw/Bz1sYsqEo4g7BUyh5D0tCO6nj37xndQeUNIzkSCcn0jY8ZZ66RUOaKYROx+Mbu282sC7cjYSEfa24+hKfPbY7qc1+AeyYW9GnaPp1ndvRf6BqpU9vw9d8ArKLtyVEeFI=
Received: from DUZPR01CA0293.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::7) by PAXPR03MB7872.eurprd03.prod.outlook.com
 (2603:10a6:102:213::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 2 Mar
 2026 13:46:19 +0000
Received: from DB1PEPF00039233.eurprd03.prod.outlook.com
 (2603:10a6:10:4b7:cafe::4a) by DUZPR01CA0293.outlook.office365.com
 (2603:10a6:10:4b7::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.19 via Frontend Transport; Mon,
 2 Mar 2026 13:46:16 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF00039233.mail.protection.outlook.com (10.167.8.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 2 Mar 2026 13:46:18 +0000
Received: from N9W6SW14.arri.de (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 2 Mar
 2026 14:46:18 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <frederic.danis@collabora.com>, <ceggers@arri.de>
Subject: [PATCH BlueZ v2 02/15] doc/qualification: gap-pts: fix GAP/SEC/CSIGN/* tests
Date: Mon, 2 Mar 2026 14:30:30 +0100
Message-ID: <20260302134540.25540-3-ceggers@arri.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260302134540.25540-1-ceggers@arri.de>
References: <20260302134540.25540-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF00039233:EE_|PAXPR03MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: 2816c3e4-0e77-43bb-9ed9-08de7862152c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	4+fNAgugaw0NfZz3sL6ya/b9sdztpIAV3Fv4TbEy3AVNpbNx8/XA50mc+1a7E7HyW9jyQtreG2Wz7NEIbB5uYim0e3zAhAL05z8ZXwP5j9yk3YQEybrLwdWlhX3CaHzYrYvyHCNVI1jMKnuVmTa4FAgu75nmU8s6SETQ5M1smUE+souvXKXyIudl6mSjBhuWYUOV/fe7l9yttlt4VdyW7/ZC12d2IsTapr6wqH9g2fuL+RpN6UyCs4es0eYGxBN4b3G3U6b4aR4158R4uUdK4R8WNEK7hmwaqwMs+wDILNQ+t90bMUWtfGLOMhugDRyvpFmx7bwH1TD1XwolnYmlCyNOX5dzJmfvfZqX44IzCFvURGZgbLP9ajkwa+FY7oPyYwv9pg2AH09S9/4SgWwtQTyrKHqptk7Vm/GvhfJBiX0g3k8A804lt1HCGsNGPeX0HXRwhfDfbrB+BPCYt6HympWxQlQLfHqZFtRoLa+nGk9CF58sPffPJlYN9ufUGqcq0o5bMt4BIQHb0dhqAxeeE3XTm4AqScd8bfj667ijxWoV7VCznY66+aNXC9BfeskC2XOxsbqA5q9aKbz0/T9lMOrhrZP2UoxYPIoQehogSJYbHuuov1Aj5ozPoOYXcLpzRDXpa4v98icSAXoEltmgaiFdWmOWCLHX4d9iBFq6IZ53pICuHfxHTFhEjc5rc9Av6auyvExgPyr6PkbTgf2r+5sP1IGHd1EaGic71EtYe92x2Bikv1sQ+fIVJer1yZlH6/gM5Kp13f3PaatAHY6eswYCIdubaRK94wtbhWvcKvmInihTGPacujDP0hkT3zUrlJrZ4ve8wUntETdNivrAwg==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bM0XadssvtuhzcApwA0sGctytkrDEw6PVLXmcCSkVu6MOEGdSqXogV1XGB3SSi5Qu6xhMx9U6WdvkGkRfz8MrJ4KkFVIjSIq+OekTWoWuCpwzv2AnpjYx19nufUWOJqya/C+UA+FhZ5+8R9xYUPQMOR0I58jyJNJ2cjtdM1xxeLQ4f8hzaKdHc1Qv1bqedDMeGyo/ImC1RuSWgGKIpn05hlAeULAFDjcgN//0j0VZBc8hiD7LYVnD3bYFspT9HVhvfwzkaSMIyFp0V315tCi0bt9huqoGzaG2RFgFlo7av+zKsuQw/VmqELUZfek1VkIsQwXwbPKODmg6h2Iu0fQJK6J+nnQ/KLTHS97QkdsqjFjdN/i0lNFZpdr0chqggKLV63+FoEyD4M54tBVs6uu9osTy+eUXtzHjpMvjWSBOD1XeFu7TryEqNMRbxSz5oXH
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 13:46:18.9843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2816c3e4-0e77-43bb-9ed9-08de7862152c
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7872

These tests require an additional characteristic for authenticated
signed writes:

> Couldn't find a characteristic which supports ATT Signed Write.
---
 doc/qualification/gap-pts.rst | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/doc/qualification/gap-pts.rst b/doc/qualification/gap-pts.rst
index d7fa58c75723..287be6c3460d 100644
--- a/doc/qualification/gap-pts.rst
+++ b/doc/qualification/gap-pts.rst
@@ -1950,9 +1950,16 @@ for which we know the test passed.
 |                        |          |         |       |                                                                         |
 |                        |          |         |       |     - enter '1' when prompted                                           |
 |                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-characteristic 0xBBBB \                  |
+|                        |          |         |       |     authenticated-signed-writes                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - enter '1' when prompted                                           |
+|                        |          |         |       |                                                                         |
 |                        |          |         |       |   - [bluetooth]# gatt.register-application                              |
 |                        |          |         |       |                                                                         |
 |                        |          |         |       |   - [bluetooth]# advertise on                                           |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | Number of bytes of signed write characteristic => 1                     |
 +------------------------+----------+---------+-------+-------------------------------------------------------------------------+
 | GAP/SEC/CSIGN/BI-01-C  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
 |                        |          |         |       |                                                                         |
@@ -1967,6 +1974,11 @@ for which we know the test passed.
 |                        |          |         |       |                                                                         |
 |                        |          |         |       |     - enter '1' when prompted                                           |
 |                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-characteristic 0xBBBB \                  |
+|                        |          |         |       |     authenticated-signed-writes                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - enter '1' when prompted                                           |
+|                        |          |         |       |                                                                         |
 |                        |          |         |       |   - [bluetooth]# gatt.register-application                              |
 |                        |          |         |       |                                                                         |
 |                        |          |         |       |   - [bluetooth]# advertise on                                           |
@@ -1975,6 +1987,8 @@ for which we know the test passed.
 |                        |          |         |       |                                                                         |
 |                        |          |         |       | - [PTS-GAP-2410]# disconnect                                            |
 |                        |          |         |       |                                                                         |
+|                        |          |         |       | Number of bytes of signed write characteristic => 1                     |
+|                        |          |         |       |                                                                         |
 |                        |          |         |       | No data update message => OK                                            |
 +------------------------+----------+---------+-------+-------------------------------------------------------------------------+
 | GAP/SEC/CSIGN/BI-02-C  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
@@ -1990,6 +2004,11 @@ for which we know the test passed.
 |                        |          |         |       |                                                                         |
 |                        |          |         |       |     - enter '1' when prompted                                           |
 |                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-characteristic 0xBBBB \                  |
+|                        |          |         |       |     authenticated-signed-writes                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - enter '1' when prompted                                           |
+|                        |          |         |       |                                                                         |
 |                        |          |         |       |   - [bluetooth]# gatt.register-application                              |
 |                        |          |         |       |                                                                         |
 |                        |          |         |       |   - [bluetooth]# advertise on                                           |
@@ -1998,6 +2017,8 @@ for which we know the test passed.
 |                        |          |         |       |                                                                         |
 |                        |          |         |       | - [PTS-GAP-2410]# disconnect                                            |
 |                        |          |         |       |                                                                         |
+|                        |          |         |       | Number of bytes of signed write characteristic => 1                     |
+|                        |          |         |       |                                                                         |
 |                        |          |         |       | 2 update messages, out of 3 signed write commands => OK                 |
 +------------------------+----------+---------+-------+-------------------------------------------------------------------------+
 | GAP/SEC/CSIGN/BI-03-C  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
@@ -2013,6 +2034,11 @@ for which we know the test passed.
 |                        |          |         |       |                                                                         |
 |                        |          |         |       |     - enter '1' when prompted                                           |
 |                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-characteristic 0xBBBB \                  |
+|                        |          |         |       |     authenticated-signed-writes                                         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - enter '1' when prompted                                           |
+|                        |          |         |       |                                                                         |
 |                        |          |         |       |   - [bluetooth]# gatt.register-application                              |
 |                        |          |         |       |                                                                         |
 |                        |          |         |       |   - [bluetooth]# advertise on                                           |
@@ -2023,6 +2049,8 @@ for which we know the test passed.
 |                        |          |         |       |                                                                         |
 |                        |          |         |       | - [bluetooth]# remove <bdaddr>                                          |
 |                        |          |         |       |                                                                         |
+|                        |          |         |       | Number of bytes of signed write characteristic => 1                     |
+|                        |          |         |       |                                                                         |
 |                        |          |         |       | No data update message => OK                                            |
 +------------------------+----------+---------+-------+-------------------------------------------------------------------------+
 | GAP/SEC/CSIGN/BI-04-C  | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
@@ -2046,6 +2074,8 @@ for which we know the test passed.
 |                        |          |         |       |                                                                         |
 |                        |          |         |       | - [PTS-GAP-2410]# disconnect                                            |
 |                        |          |         |       |                                                                         |
+|                        |          |         |       | Number of bytes of signed write characteristic => 1                     |
+|                        |          |         |       |                                                                         |
 |                        |          |         |       | No data update message => OK                                            |
 +------------------------+----------+---------+-------+-------------------------------------------------------------------------+
 | GAP/ADV/BV-01-C        | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
-- 
2.51.0

