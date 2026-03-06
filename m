Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013015.outbound.protection.outlook.com [40.107.162.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AF934104B
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Mar 2026 16:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772814104; cv=fail; b=YgKNcd5wHwkMPF1pfJq+vfdh+r0wdY8Tyrb4KeSn4i9vpFOZGIbAbxaTsMoII8gSnAPfPjaTos1ktZKuJqEVwdX41Rba28VYYwoVC72nAlQdYIMA7eXrBJRwlIiR1yg2VjQ41gh9A/xfk7lyYPq7kamlnpWftdjeR8o7WcU0buo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772814104; c=relaxed/simple;
	bh=fy5pWWDThKMKrj+SlYBQDywZFmpN60M+2nbjyXJOtg8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vmg0F/u0yI1ywvyDkOUKz2a8PH7VAOsW43okGZtgtWcxp4mn0aaYYe0+rlJ9Ia87VqZeEkGKJQQ9L1Z7LRHljQB/W4KX/LU9HqcCs63H45UX0gqclwJH2tSoqap/bigbcE4cuXBEOoukNMNR9C+X/Fn0WMZy3oBCEzL0oOh308U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=MSirXZNP; arc=fail smtp.client-ip=40.107.162.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="MSirXZNP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+5UGuhhI2NAe9L2mzEMNAzfCshl1HWvCtFKxzFNmNqDcPl0Z6EmfMw7jEcFZRMNvuPyeIMqZ2dzMKUSei070vhjBlcziArGeJBNYaRfPEf2+xOXuUWcnsB674M9CQ9KfnN95tGZSrTpIaPKl9LMs+W6xSu1gkcCvrKW3fPraXPfsnzSnprfuZLtYlTOnCWfL5gCq/Q+52o7p2dBVHk7iB8WNACLueouUojBkWlByBk75yzCvw5L281tH5hqF3x6uxQD7JoMlM/kyDI//lMY1hMUyd29YQlFptQCED60wQ0fn3WUCl6bVAZcOUSoFP3PRI51+aobJWRMUaCuupV80g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXAS1TglwK9mSx1dPggO6J0PRv95dRPaHrSORopK5lU=;
 b=X226OjWR/t80Spa1KJ0hN5VZJBKB0dwzvaVFRNOU7SLnPyCl+jfQKUOxHIvm+SzLbbOH4c78KSmv4Zkes5/ETTzNocHWtcLiM/5YUzsywFJbiO61bVw6i5s0iLXiWxUWAZyV9rC6icnu3/xvJPALAvenXBmym8KG+uQY3KrKvkyD39ANXbpSNN1nGd8y3Wlt8p+D5TMKDlmedd8vBWloy5r/8QE2y1oYMNoB7pleJ0vGsO0Ol5h3suIp1AqVhCzQ2gx6c0FUzOLAU0kGUQ7vaPBokQ7tYlZuP9520j34bwAV9moIO11a5lzRQxhfZAh1uvtHO773mEGnHTyAxlyIuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXAS1TglwK9mSx1dPggO6J0PRv95dRPaHrSORopK5lU=;
 b=MSirXZNPkW9DpI23EGQLz2S1q8WQQrmwmQIFoCu+d0M6RhzW7ufQCw/qFfpNfzOys+qOBMvcmuygjpFGTptEGYM+NcVKE/XYVbXhDhxpjzXj6bI13nSE1B9PeYOXWCilZaQmfqS5cfswh3ugaF++enkiaMnt2eojdsBirmuwBO4=
Received: from DUZP191CA0060.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::10)
 by MRWPR03MB11537.eurprd03.prod.outlook.com (2603:10a6:501:84::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 16:21:38 +0000
Received: from DU6PEPF0000A7E2.eurprd02.prod.outlook.com
 (2603:10a6:10:4fa:cafe::27) by DUZP191CA0060.outlook.office365.com
 (2603:10a6:10:4fa::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Fri,
 6 Mar 2026 16:21:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU6PEPF0000A7E2.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 16:21:37 +0000
Received: from N9W6SW14.arri.de (192.168.54.17) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 6 Mar
 2026 17:21:37 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <frederic.danis@collabora.com>, <ceggers@arri.de>
Subject: [PATCH BlueZ 1/6] doc/qualification: gap-pics: fu: add footnote for TSPC_GAP_21_9 feature
Date: Fri, 6 Mar 2026 17:19:16 +0100
Message-ID: <20260306162058.15154-3-ceggers@arri.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260306162058.15154-2-ceggers@arri.de>
References: <20260306162058.15154-2-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E2:EE_|MRWPR03MB11537:EE_
X-MS-Office365-Filtering-Correlation-Id: 7110f794-859a-452b-d207-08de7b9c715b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016;
X-Microsoft-Antispam-Message-Info:
	w31GBeiR3TPlgAXcZzuh2u1hKWl8uebh5yXyhZBKf88O5b31T2KecbhUDv6DQMsr0ZjW1VJ2FW2eXmp6+zXeqwuYeD64WEaDj2bQWkivyBqpGqPOOHsc0kx651huSDrUUA02NIYyJXpleGFAD7iT6HnwQ8vnR2+j59teuz0rfQHS5nRAHlTawtRkr49zGjUK+R/xJdBIR7PgXhPZTNHicPEyS/H/gkeoL2FUUp9B0kAoLoYhIY9wC3bMdlM0gNBcoxeL5euP1gvWL7vKxmtzn/a3R+zWXCTW58BaWkfrQ5dIXPM4vQNrVptht+yW6CANhRlvEPXppCzFsENKMID8ZOmGmxz1F1eV6L/xF7TuS425yxzwzBK6VSkaWAdWSE6+Zmby/IGTG+CVyIU4jSiokukyaZlQqZ6MrbdHDFvSvKCqFq8OAZg077J5HHf8qMbiW7RHgKLwOsI6wqcI+wnJF8dZ9f/1JuLsXPdsqburppP+LNJ+YHZsiAwGTMRuLEuNIgVH/mNsue3XpMuIEe7/dvlBrfLKw/YVOmXN8GJ6gsrcBW+bc1arBieCTnnmyz6KVVkErdNyt7uKvrCfk13oAl2HqwCDVWbhnTHcT3qeYrjaXluSAhOXulzl1a10zFKHYcWUdtuwU2FWeOqOlRh7wIY3p4yHUiz96sq4G6yZhPt+j+TuZaw/ppHTzCikFfDPHxbSIYHoXeh3yXJQE67EN3PPj4Ryto9fjTdlW7xKcy2HDgYBpfODhyyxy4aBIISIPckQtzNaEHmNhhCKlNMaJQ==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wa9MRe+PdsFOzskh5/MpMYvJXCeL7MI6gQhqE/M7jAURiRBH6Wb8qc1RHvsemT7HvTwB5gz2+Z4bAeT1lencDcW2uQfBVcp4EJwi/y2kaheEKlYwooEnhHPjUIt1cgcdhZJmJPdvtNTtoLDV3eBP9jfFv/A2ZprzU/2dUV7D37avsie76B3PI7aW0U2tvbZKWFU1N070uuUk+otvINop66z0D9lZdNkc1qarUJYqqfJwxrv7yVBkBfRwUf23yoHz7IJ6WU1OFRZhFbSNcSREBf8OXE1JjF9io0V0FKHos6OJven+Z1r6QHHYSVN1PK2pbCSmlc6Q4ATh1LAdhO5kJMz5GWAfmxndyUSwo8MOU4pXVSaGLppuMdPp80lximRJmmduuJqOSJu0XAjZ3VAtRQg+eqUYjXN4rjlZ4KMAl3yRPyvpT1MdnTxVJeSB6ZHv
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 16:21:37.9426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7110f794-859a-452b-d207-08de7b9c715b
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR03MB11537

Unfortunately, v1 of my patch series has been applied to master. This is
an incremental update to v2 of 1b7e682ef4b7 ("doc/qualification:
gap-pics: add footnote for TSPC_GAP_21_9 feature")
---
 doc/qualification/gap-pics.rst | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/doc/qualification/gap-pics.rst b/doc/qualification/gap-pics.rst
index d7673e5da088..c9d7b003d547 100644
--- a/doc/qualification/gap-pics.rst
+++ b/doc/qualification/gap-pics.rst
@@ -848,15 +848,18 @@ Prerequisite: GAP 5/3 "Peripheral (LE)" OR GAP 38/3 "Peripheral (BR/EDR/LE)"
   otherwise Optional.
 - C.2: Excluded IF SUM ICS 31/17 "Core v4.2" OR SUM ICS 31/18 "Core v4.2+HS",
   otherwise Optional.
-- (1) Only set of Bluetooth controller supports the HCI_LE_CONN_PARAM_REQ_PROC
-  LE feature, otherwise, GAP/CONN/CPUP/BV-08-C will fail.
-  # cat /sys/kernel/debug/bluetooth/hci0/features
-   0: ff ff ff fe db fd 7b 87
-   1: 02 00 00 00 00 00 00 00
-   2: 5f 02 00 00 00 00 00 00
-  LE: bd 5f 66 00 00 00 00 00
-      ^^
-      ++- This byte must have the 2nd bit (0x02) set.
+- (1) Only set if Bluetooth controller supports the "Connection Parameters
+  Request procedure" LE feature, otherwise, GAP/CONN/CPUP/BV-08-C will fail.
+  To check for this feature, run in bluetoothctl:
+  - power off
+  - hci.open 0 user
+  - hci.cmd 0x2003
+    HCI Command complete:
+    00 bd 5f 66 00 00 00 00 00                       .._f.....       
+       ^^ 
+       ++- This byte must have the 2nd bit (0x02) set.
+  - hci.close
+  - power on
 
 LE Capability Statement
 =======================
-- 
2.51.0

