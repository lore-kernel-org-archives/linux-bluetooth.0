Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011017.outbound.protection.outlook.com [52.101.70.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CC03ED5AF
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Mar 2026 16:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772814118; cv=fail; b=nLXFlxujfky+bj6iRcENuBK+H1EdPdK88WLrPc/xQlWpET8LZcuF/AQfCnaKd8f23dVbc7B6FiVHKH/SOl0Tl9I/uXyDn54IXvdnt4HS6I9Gnv1qstw9nIu/Ta6MgzVfkzFVeT/CNeALSaTbB4GmvJtK9uZj3nKThSQg9gcJenQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772814118; c=relaxed/simple;
	bh=B5C+fs2bIx7osjfuDRNjPaHL4DiYSLGNgva68TCYcj0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vah2RhiZPVdOt7A6skJ0dRQbRs+x7096GhghFg2eBYogFisAeAKsl4n1i+NhDFo9O6DciYiXXVezcv/CH/JI691fZONsqIbNMeRajAZiH9/PSjbpTdv0NMpgSVi6REIR6NvPnz1U6iSuU97BpJ8KsFnA/Vq5RPOO4/a5JhV7kgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=Rcj2B1ZE; arc=fail smtp.client-ip=52.101.70.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="Rcj2B1ZE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDviWxWk7yh1E8mSpOmO+xlnhv2I0MsxeveZei+RsfD36jk3dMug8L2DDfGrLAcZNb0n1eSfz3k3Bb0QbuGciLIV2yCMUuk9mCaHhtbwghouR93yMtNM8v8+yUQU98zN7GhnQIeqhLC0IXl6VMkGwz+WqmLix7Uv/VcNIISlVMYL53jB+CJQlmqMOWNqaia0p5OurwnKx4PkxfXHSWEHbGbG/kslXRLKhNHsgo8zUcvPQ1FTj2WAdEcJXezC9HjPeIfdaXBVAnU+Rd56zy+QUKoP3PXirIIwNSGm9GDwrVamPz5dsZIQNFnD9FafD+fgGKmy9ZrADAIGwGkK6OI2JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KB8eAw4jhMMUaqbJYZhJQmGPBkoE+28ljCuPOgN8gI=;
 b=PxfKmHf1cJCc6zJ6r/ZC2LZmYd5m/VGmfw2Z/XkeWFAgdID0uoZuIZf6KMaqZWNIFEnZ+0D6frGb2N8xr+TSnXzM6wRUGdgDUqgu/yPq8ZsbbOy0CeX9iLppGYi5ClKAeKJeZpgJyITIvyQezfBG8R9PuG/TZlsWJUWvNLUq6o1VWM19V3rLsSWjwf6F5a44hnpVaVrdmXM+/7EVvfbQOTWKIQ6GKk5bvOChAzNUf1OURhUjowkVtUnnsrC3+mI1lIvp68FGUWNlWBymCHZH78TswwSEFY+w67q+dHVF2yrgYb9qeixQy/R4mzuHeMs6d9bYSyvUGtHcLjppud1wXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KB8eAw4jhMMUaqbJYZhJQmGPBkoE+28ljCuPOgN8gI=;
 b=Rcj2B1ZEMyYTipYaVTZxi/owa5Z+apmrIEQLgaaKsGkbeWJalzAhKZ0nrsHVzPznu2OFTieWroT50pQ6mRMaYd4Zbi0nhZXNfkI/p8KxRm1sD9oH6F63nRwGLt8GWIl1S3p6/qQX54wDTIGyEEVhcsbAD9dNlmFP3H21WYafSps=
Received: from DUZPR01CA0047.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::16) by AS8PR03MB8997.eurprd03.prod.outlook.com
 (2603:10a6:20b:5bc::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Fri, 6 Mar
 2026 16:21:52 +0000
Received: from DU6PEPF0000A7DF.eurprd02.prod.outlook.com
 (2603:10a6:10:469:cafe::ae) by DUZPR01CA0047.outlook.office365.com
 (2603:10a6:10:469::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Fri,
 6 Mar 2026 16:21:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU6PEPF0000A7DF.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 16:21:52 +0000
Received: from N9W6SW14.arri.de (192.168.54.17) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 6 Mar
 2026 17:21:51 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <frederic.danis@collabora.com>, <ceggers@arri.de>
Subject: [PATCH BlueZ 2/6] doc/qualification: gatt-pts: fu: add description for GATT/SR/GAW/BI-39-C
Date: Fri, 6 Mar 2026 17:19:17 +0100
Message-ID: <20260306162058.15154-4-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DF:EE_|AS8PR03MB8997:EE_
X-MS-Office365-Filtering-Correlation-Id: 43ea3cf9-044d-4fc1-0efb-08de7b9c79e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016;
X-Microsoft-Antispam-Message-Info:
	yfK/irf2O8fFOz8wRO3T+aWT2uKGhKd7nr105zoN6h+kHIrTIlM2zU2fHIbFeDvLO4EOmXNFv9AIIPhWvXbPvDe6+e8+lWRthBqx+Q3y0R4wEe8cJYDiRqzmmpWRey59A0kAz+K0aNoevPFSaObp5EnBYhRxbfuXM5puRloLtFCD5eQBaI8N9VUKOK9zbzYEXOVVXM6dMHWJNHUDm13mTyid9jZ6+n1wI15fOvwK66GWaxSXVC6XmzNgCq+NStO5iQDcItduI5IMk2cyYCrYjPwRQxnbNltIrLPszE88X9gVJtvdW54QJTpkP7DgfQD1R7Wz3Q4CFIaxmog6Ha0RBKvQ4dfm07/J1KbrMmbU8X0Qzr7FDI90j+f6KLXasFNXhBOuogUnD6Ay8nv9nSlGnBifM36yuEd1AAUEqEYVJOaFbRlUlzlHgYvmLux7mUUGQjbNjfC04WLQfJBzmvDO3YFUTNu9e3x/Bq0k02lkjjmUcSLXWfFqWzmiKcXDdjeUKTlQt/ks91hru9pUGBvRgBgrTgh6muTHYsYBT6wqyZXKFjqx+NTak5AQULZzkY39qBaIwyhESzepUYmkXcrqsIdGrQU/3vjGAzvpbVDQj9nsOgIWay9n8WLQQL41aiQLR2G57PsgbCScBetZQ7LmyJZEGucVUwOZhhSL4Vl+l1dyZsgt/2XZVZtRO41orxU/OskY+LZi1+xqAyovXiD3uCPPaSQjcJbf90li3JoA4FmSxjuvbjHHqiFnj8JOffXSw/DG9D2i7mEuR3vA/NtWZw==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PJ+wqqgyYN2VVpKVpw91snkKJrzQOLBpXZRrnZr4QGgMUpK5DdiOKxsla3K3MMC0bbXtT2EK4P9GZbPhslxoH+Df6uA3etMs985mhPdzgCM7Ti8jYz7cEA1GgsA0nLyDgpHU5NRFlpRO22ZRrpSs9OBD+DGeXVYqLtOWKUoYCvaRJGptCnEcI+SO2a8c3G14K/RPUcrOd3O0jWznPTmVyuk0J15JgKUnr1Dg0L6ZxNJS+0CmSPDRZjic4llNkEkgnoDuldl0wP5XocZGtvmsFhCJRwgPOHU/wz/4+4G9mpqT59rUXJf/W+S1cNjb/MmLSjhNZtuaRjbMjSfAh1drPXvu3nemd/1cesKGvKm6RlUzgMoY1oHEyz2wrreQPrOAWSS4gVTfpKxHZwhzEZJA/hhNQk/NBb7TxOjjxy8cNUrBm8RKAmL3waYaG+KVbyNR
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 16:21:52.2824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ea3cf9-044d-4fc1-0efb-08de7b9c79e8
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8997

Unfortunately, v1 of my patch series has been applied to master. This is
an incremental update to v2 of db7d1a9c770c ("doc/qualification:
gatt-pts: add description for GATT/SR/GAW/BI-39-C")
---
 doc/qualification/gatt-pts.rst | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/doc/qualification/gatt-pts.rst b/doc/qualification/gatt-pts.rst
index 760d78615970..fd1fa8370d50 100644
--- a/doc/qualification/gatt-pts.rst
+++ b/doc/qualification/gatt-pts.rst
@@ -1099,40 +1099,44 @@ for which we know the test passed.
 |                        |          |         |       | Enter the handle displayed for the characteristic during                |
 |                        |          |         |       | register-application on handle request                                  |
 +------------------------+----------+---------+-------+-------------------------------------------------------------------------+
-| GATT/SR/GAW/BI-39-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+| GATT/SR/GAW/BI-39-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
 |                        |          |         |       |                                                                         |
-|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       | - Run 'bluetoothctl':                                                   |
 |                        |          |         |       |                                                                         |
-|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |   - [bluetooth]# gatt.register-service 0xFFFF                           |
 |                        |          |         |       |                                                                         |
-|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA read,write           |
+|                        |          |         |       |     - *yes* when asked if primary service                               |
 |                        |          |         |       |                                                                         |
-|                        |          |         |       |   - enter '1' when prompted                                             |
+|                        |          |         |       |   - [bluetooth]# gatt.register-characteristic 0xAAAA read,write         |
 |                        |          |         |       |                                                                         |
-|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |     - enter '1' when prompted                                           |
 |                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-application                              |
+|                        |          |         |       +-------------------------------------------------------------------------+
 |                        |          |         |       | Enter the handle displayed for the characteristic during                |
 |                        |          |         |       | register-application on handle request                                  |
 |                        |          |         |       |                                                                         |
 |                        |          |         |       | Enter '2' when asked for handle size                                    |
 +------------------------+----------+---------+-------+-------------------------------------------------------------------------+
-| GATT/SR/GAN/BV-01-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+| GATT/SR/GAN/BV-01-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
 |                        |          |         |       |                                                                         |
-|                        |          |         |       | - [bluetooth]# advertise on                                             |
+|                        |          |         |       | - Run 'bluetoothctl':                                                   |
 |                        |          |         |       |                                                                         |
-|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |   - [bluetooth]# advertise on                                           |
 |                        |          |         |       |                                                                         |
-|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |   - [bluetooth]# gatt.register-service 0xFFFF                           |
 |                        |          |         |       |                                                                         |
-|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA write,notify         |
+|                        |          |         |       |     - *yes* when asked if primary service                               |
 |                        |          |         |       |                                                                         |
-|                        |          |         |       |   - enter '1' when prompted                                             |
+|                        |          |         |       |   - [bluetooth]# gatt.register-characteristic 0xAAAA write,notify       |
 |                        |          |         |       |                                                                         |
-|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |     - enter '1' when prompted                                           |
 |                        |          |         |       |                                                                         |
-|                        |          |         |       | - [bluetooth]# gatt.select-attribute local 0xAAAA                       |
+|                        |          |         |       |   - [bluetooth]# gatt.register-application                              |
 |                        |          |         |       |                                                                         |
-|                        |          |         |       | - Wait until PTS prompts for sending a notification                     |
+|                        |          |         |       |   - [bluetooth]# gatt.select-attribute local 0xAAAA                     |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | On PTS request to send a notification:                                  |
 |                        |          |         |       |                                                                         |
 |                        |          |         |       | - [bluetooth]# gatt.write 2                                             |
 +------------------------+----------+---------+-------+-------------------------------------------------------------------------+
-- 
2.51.0

