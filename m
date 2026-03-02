Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010044.outbound.protection.outlook.com [52.101.84.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD7122157B
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 13:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772459421; cv=fail; b=e3TVl6g/96jp1rM+1TKKlBEi/0M8EhjIji18DAaJ5F0VeS1Po7BYPhRzXsev+X+f0WkuCvpeGGJUSqNfpJxeD4lQ/z/YGgQ5U6U9G8RkLLwuxW2RbR0/YS5VUzYNA9bto5G6jZ2h7KcX2jD19N6UbWfYJun1syxSDFTNqqpNn1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772459421; c=relaxed/simple;
	bh=ZhyMnErEAdyMGDmk1z59pA8qbmJGaAaKDysgI1wbBvY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/ePs4KTapGf79U0VHUOTIj0j6hJ7szhIHGepV3RGAYwHPA4S9yrEJ7pc2jnq2HFX/Zvs3iEaZ3F5m7li+Aus0I2o1jF9hcOCSzUsNXZ72NUMKWT9dN5QMXzuEUVoY8hy4CEfh183OQeGqL2d2ozzyd2kbMaaGIv2CvmXryZOX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=AJpciYgb; arc=fail smtp.client-ip=52.101.84.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="AJpciYgb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aWpkCj9YVwYgOx3mXp/ioDqU/VxsD+ZNh6MilVFalSCCRSgWCgftHdNOZgMtvU3FQXKdmV0WBwVJf4ji9JZtl6eAlSB5IGNp1AF+ZIk8JgOrra8kNfrNf3OGsCeqoj0T4hhsueZ7XrQHUaRwBp7XLxRXLXjIu8TkwHq8icP4n1B2fw3e+rDBl9iSS3ADJKGbSC8CZIH5g7TCIMR4++eVLfc7DvaXGrQXtypRN4pXO6KJ3baxDnhrFdJKMNL9i6RXahbsjTaxsHqtruXWs2uCqka5oQjgGC3TzS9qOuo5osV5xTZwAJReA+lcfMVOCdWGmop359aNERRmL9mJQagMIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lq2f5hsGdtTNZr5PLoUQsAqBfp9+0Q09JVHIwDZLDxU=;
 b=lG4xRTOKLS87Qa5YLZWKzzlHKbbUOtnI4Ev6j545osahfGjcvRunjl7lUWg+g2QnvLoAN0F5Un2AlgcTNL/2kD2GY4LYHM5y+NORUm4fw2myhG0aDqoCrZV6oszmpF2ew+h8oas1L5ILwwQ6sIA3HhPi2bluk3W3qfzZwminGrsQ1mDbJIZXDgdaUXOKwk+LOw9EFmEIVPyBCY2XxrYjz1Qrk7+59xDGkViwYLldrXQRFW+wPGTVp/x6murvchevjSDiFe7SJpH7PpeCt+lg41wPUvr3WasWC86oMkx+padDpQONEc+5DUdWJHkddT8N5ylXLMcIqV6J2CxFEYmYFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lq2f5hsGdtTNZr5PLoUQsAqBfp9+0Q09JVHIwDZLDxU=;
 b=AJpciYgbOFUjRIsoe6RbhFbvKKiB1F55hSY3gGamLXarjd/6ex9WKMbiFOq4qfD/ct9jZ2rIkyhMpnfIqjA387h1VCeScfIrXy3PyusCd4aiSa9RT3J78qmeM2/7zn0sDklAgK347cdw9JWaVNGzUJHW3Q57GHJQbTwriHxmxRU=
Received: from DB9PR06CA0017.eurprd06.prod.outlook.com (2603:10a6:10:1db::22)
 by DB9PR03MB8328.eurprd03.prod.outlook.com (2603:10a6:10:390::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 13:50:15 +0000
Received: from DB1PEPF00039233.eurprd03.prod.outlook.com
 (2603:10a6:10:1db:cafe::1f) by DB9PR06CA0017.outlook.office365.com
 (2603:10a6:10:1db::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Mon,
 2 Mar 2026 13:49:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF00039233.mail.protection.outlook.com (10.167.8.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 2 Mar 2026 13:50:11 +0000
Received: from N9W6SW14.arri.de (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 2 Mar
 2026 14:50:11 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <frederic.danis@collabora.com>, <ceggers@arri.de>
Subject: [PATCH BlueZ v2 11/15] doc/qualification: gatt-pts: add description for GATT/SR/GAN/BV-03-C
Date: Mon, 2 Mar 2026 14:30:39 +0100
Message-ID: <20260302134540.25540-12-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF00039233:EE_|DB9PR03MB8328:EE_
X-MS-Office365-Filtering-Correlation-Id: 20fedb10-1f1f-43eb-8ee9-08de78629fbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	c9TZju3UyGULSCiS2ZFxc7L+KykKGduGmpywL3YoTHE0GSpaLogaLx4HIF7wwiuEqBIYKrfzLdY16v20Y5YUcL9mkqYjQwwnQ2Z3wnRNeDCxNefD4LtrXUHmt6VyI0Xtp7+/AauTNb2rcIP4SKgn0qNnc2TSgopRbLIl0B/uelFAkwdheHh/lPZZwNF9Akhp+tV3PGblY1svdlFBD7zHPg+4h2pV0AOCLoeTEuYA8Q+BYD2rb5qsckV6pp/FhJ8Cvrwbs1JJJ9TiwUJscIXj6b2rcSFVwDox1km/+OulSDvtHa+N2eWXByP1U7RwPUe8SHgWybUOZ2lpr+OCdf3nq94r/uXFC0gB0YbTXhh7dIiS0BmdKsUT451Dvm37eXeczHugeqnWnnfwKSAr0zG4r4TcM3TPwet3qVghvTGnif9i8hBxc/YxEGBxdTIyKrQPbBDrbiQaFiGGgZsbTHzaLsJC+xK39i4wlZKDTSLCce0DUyQJmxNGNOlzTKuJe+iwJSTF6VDfvDBFHJZrAK4xtf7tMMsnEwI+UL8SiLJtquJx0Ert1mTrg7nxf+3Cgt8yEln381jYSY8dMNfwreLy7uciYKi4owNDv0pX8l0pzQYswsWf4wnUrGO15jpvDbsEBEYk4Cbc7TTYafHcb6Uf24kQEfi8GdLYe+RGUwBAy8OqVCqEmvmpOs1VHHYyAavjlcYn96Zw63ixsIHSPcq2X1YKH2B86Q/kxj3IiyaCFQlIX6//b3aSSoRxU7lgrV3Lxbvv+NieVhjyJWBEqydNJmvDo46rILJI876b2gcRawJqVYgzPjnCUG/nsuFdJ93/E5xqQijnFPo2FQwq2Wg1yA==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Cp87wotxlBJjAxFEqE4JM8WCwhNEkA/V68CZUYlooR3f4Br9q6aFaCQtZr+/zx5yrQHIA0Vges+FuEO97pZCc+npyx5jWGjFpc7TGKTN78Thp2H27CwGfEHh8+NAo+y84pw0elRkEcm+XnYiH8f8xyohiQo/xKurtqlkxnLZLlYha9NxhKOoDv/CLpNxuIrDQLEVjT9JQ4KFdkLYoRaeE2urvCZSq1qwKBaXdNvAbBRRR3xTKbfEEm8Ab2oJlgjz7jmKbWJPVw4o1hx3OxQncFgN93jVbhAaFvfX4pHHsDTAGPnb4rRD6a2Iw5B18xFBFUWmeDD5AR4YFzf/MdRwV5rtvtp4cFoKrTe6PIiO2jhaio6DnEbeylnfzFtPuYFHjXzXicChhBVpA20aVZtScJRODt/rUqNr6N3w6gAkiVd0DeqCSJQyQDXdd95N0qD2
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 13:50:11.4460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20fedb10-1f1f-43eb-8ee9-08de78629fbb
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB8328

Same as for GATT/SR/GAN/BV-01-C.
---
 doc/qualification/gatt-pts.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/doc/qualification/gatt-pts.rst b/doc/qualification/gatt-pts.rst
index ea0bc2fd3e10..9c621ba8f584 100644
--- a/doc/qualification/gatt-pts.rst
+++ b/doc/qualification/gatt-pts.rst
@@ -1140,6 +1140,28 @@ for which we know the test passed.
 |                        |          |         |       |                                                                         |
 |                        |          |         |       | - [bluetooth]# gatt.write 2                                             |
 +------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAN/BV-03-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run 'bluetoothctl':                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# advertise on                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-service 0xFFFF                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - *yes* when asked if primary service                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-characteristic 0xAAAA write,notify       |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - enter '1' when prompted                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-application                              |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.select-attribute local 0xAAAA                     |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | On PTS request to send a notification:                                  |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.write 2                                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
 | GATT/SR/GAI/BV-01-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
 |                        |          |         |       |                                                                         |
 |                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
-- 
2.51.0

