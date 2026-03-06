Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013007.outbound.protection.outlook.com [40.107.159.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B5B3AE1B7
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Mar 2026 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772814166; cv=fail; b=bFig4yYzNKbE4+dDNqmIk8/UA/nQZtAylnukSGzRISOC6wOsWB8bRhyizUpUaFgzHfr9wPiNdA/dqzvtFKpOQ0PaAkRYurJYOXajWZ9S3kQTP13/+ao74R9QkD0CGXi2VBt6m49rkXC/3jPlCGKjNLo3LfHJEy7kxQSnSM0J8+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772814166; c=relaxed/simple;
	bh=f3xa6sTbzmihZUue+yi0GVeqbjg0BsFIfVbCiEZIel4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UaDC+tD8ZM1qfXv0JRfKdE6dFIjynSDQ3Dbl9Ej9HYciBHxDZk2dJ5wvz25S4W3NGCMU17rCRsBAL3AkQdjnW4FVN+q3LN97fEvyBWDkcusxzKTHHMtjITVBkuyhKi10jgbGXjh6i51zUcHwmDqXjMOh7v5x+GYChKTJFRH9T3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=a/IZe2pR; arc=fail smtp.client-ip=40.107.159.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="a/IZe2pR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y4PQhwmdL8GXU8L9Bx7BnU1yncMM2FkJNGSql9Jh7QWMxX/ffv0I+ne6iqSG9TI6z4SsRb8cxnW2n9SKAng1H3hT0Jv1Jw8LujBgLWN8kx5jwFF6GhvXoA7NQho/ZoVC7tq70YX8U/u/jFKHjR0UsrgOnErWqG4Qj+AN8iURkrgjsuA7FbOMIrJGYCzgB5g+E38uqsjtSMMGjP1Na4K6iWEhbxMtwmORgsHKJJyNiG+kHnpVwuS1EgcLW9kszvrqQMw0PzkQ38JKGBNUL0JkvOvO8NND8QWWcXQMS0pRmh/ee3bOOgLJlhTs6mtDAK4F+tGcZPUkzkER7H0lRaidCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCpPBZ8nV2OdClurIfQ7JlW3eOWRWfkmbLZ06RlNf4E=;
 b=nuFqbsyGOAKJR2W+dczRYpExzFDfvNusFotS4CU+Ct6OVnP7hmiE3z1zLvzgd3ck1B2KJsdCyXQVs2nwx3e29gSvPIL1OFD/erxg2s9gS/A8viqQSajN5VTQqu9ArE8/TFCEB1yh/yBYwvyOpXymagt4yUms+MNZMTOAfTN2s2O8/bhkHD8cIJtLH3LfVYLwjU9KBBpDM49qiYIxk/9o6rK3r4jkYgmhduuCIc2ij2ghgR8S0a45YHBPQsOE/ptywrhSYO/i4g4jmISHgaslP/9tzQRokeML6mlFN0EiWoHN95MLu7RujnKNnLWSNKiwEBRhJd7SEOeJ/yPyyCoWOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCpPBZ8nV2OdClurIfQ7JlW3eOWRWfkmbLZ06RlNf4E=;
 b=a/IZe2pRERiSAYXXBb5lp7PXtnzFg/f5pz2GbzJ37bSW/C+KJvflnKURBGi27vjdbopSXC6x1u4U/YL6ZrS7G6vcE9fcq53JhqgU5svq4JBy47y5VEzVxXbK6IHAZRkSqIQc1YBvAgnBNclDYDEjs9d5oGDoCj/eh3Y51uA4fQE=
Received: from DU6P191CA0064.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::24)
 by VI1PR03MB6142.eurprd03.prod.outlook.com (2603:10a6:800:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Fri, 6 Mar
 2026 16:22:37 +0000
Received: from DU6PEPF0000A7DD.eurprd02.prod.outlook.com
 (2603:10a6:10:53e:cafe::16) by DU6P191CA0064.outlook.office365.com
 (2603:10a6:10:53e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 16:22:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU6PEPF0000A7DD.mail.protection.outlook.com (10.167.8.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 16:22:37 +0000
Received: from N9W6SW14.arri.de (192.168.54.17) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 6 Mar
 2026 17:22:36 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <frederic.danis@collabora.com>, <ceggers@arri.de>
Subject: [PATCH BlueZ 4/6] doc/qualification: gatt-pts: fu: update descr. for GATT/SR/GAI/BV-01-C
Date: Fri, 6 Mar 2026 17:19:19 +0100
Message-ID: <20260306162058.15154-6-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DD:EE_|VI1PR03MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb78cce-5272-4bdd-263f-08de7b9c94a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	aaI5j5TEV8auA6yrnYXhmnJq6gXLCiM58DYZsaLQ9vn8kXBT+6/GUbgsOo5sjkXJMWpff7hkaXPnKibXRWe4/PITfwzfYxrE8BHu8Gca8r6+4WiALWAWVf3mJKbQLWPGcJ3pk4zlWd8IW/m2jKpWW6YZqSDbcZ3jsTmKCRY0r2iIstYzCk/0VRo4TeUx0eoseVG6xhPoO3e2jpMnsAXQsVrBk6+MOzyWq5uh3lhqIchLXpG5CkOhDSmR8uAAVV4PDNCnQ7v0X30UwLNuTw5uwA3mZjXFdxjYhsgS8gFBfvEkmrFddNRnCaAYglG9wEnRULvyMak3VmbZgV3g55luEni6z6KSyTeiP7Kw1TxZrNPvJBdEfizBy+hchfVhyZFn1XkITUYF4zG3BRdaAN4ju1g1NaPcdpYdMRxwWV1bPe19/3ZDrtWfI5TSeMMgNqaYvORf9YROnGeaV9h9jf9OkCkt5jqIWl4VWojCt8a3rcxtcNiS2NGQqeQgNrxFe/Z53UO6li5a/bLV4xE+BvIUhmddemORBWnyc8ywnUL/21/sxTgcDma5h4tkAdroZD9MrC6wKabogWcORicz695xLqNkXF8DF03fxQEMYerZtXk+KfTx/pkZuotzrIR4Lpkhdr/jw8SdFNap60krHa8r6DIziF/Gwt9hU5Lj8NEBkG721FnaBFSOSmjaH0jjECuCKzMsGoSENNAZjoxbM6VAz9v+d0/cluM5oYYRPxWv2QyFmFsFuW1ngl/6M58QAMA1Dj4gY7jZyrvqH24IodrcCw==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qJ5J+7i8c+E0s8uy7mzeypIf6PbAxr/kSOVOVJE/6hBv47x2uiiT5M1RclWIPTCT2ryC1grCrRncPXsEyQqh53XW9MKFMn3fmrg7T16XEKRhjnptONFMZH1NBz/XxzJ5KUW1/nEIjq7Huc5oMytweWJWRjYhElv8YkKW31Nbm8E4FeFUkGmREYiwytK/kjqT0wEDI3fZXDkiuV0qz+eEhzrA2RRRPTpgPczSsRSWK+xEBQsDPqKpf/1/RsUqQiNDaQax6aVSwhpA1NUPrdxHphMzEbAgsDQUGXgHPpwBCzn1fN5lxN/kyAknJbQkANamr94XxQD6+NOdJSvHng/ILCPTA3oSVCqe5Uks89yh0L/qz+dvqYgHu3w2f8FKiqaFgr3bdckN7fP3erDkV5e5nVDrEMTY2CC4Y2UoYbdIeSc9CGPkcvjVXG9AhYIYM7d5
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 16:22:37.1686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb78cce-5272-4bdd-263f-08de7b9c94a9
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DD.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB6142

Unfortunately, v1 of my patch series has been applied to master. This is
an incremental update to v2 of 7a2d04492f98 ("doc/qualification:
gatt-pts: update description for GATT/SR/GAI/BV-01-C")
---
 doc/qualification/gatt-pts.rst | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/doc/qualification/gatt-pts.rst b/doc/qualification/gatt-pts.rst
index 4749fef1d677..79dc75118451 100644
--- a/doc/qualification/gatt-pts.rst
+++ b/doc/qualification/gatt-pts.rst
@@ -1162,21 +1162,26 @@ for which we know the test passed.
 |                        |          |         |       |                                                                         |
 |                        |          |         |       | - [bluetooth]# gatt.write 2                                             |
 +------------------------+----------+---------+-------+-------------------------------------------------------------------------+
-| GATT/SR/GAI/BV-01-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+| GATT/SR/GAI/BV-01-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
 |                        |          |         |       |                                                                         |
-|                        |          |         |       | - [bluetooth]# advertise on                                             |
-|                        |          |         |       |                                                                         |
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
-|                        |          |         |       | - Wait until PTS prompts for sending an indication                      |
+|                        |          |         |       |     - enter '1' when prompted                                           |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | On PTS request to send a notification:                                  |
 |                        |          |         |       |                                                                         |
 |                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Enter the handle displayed for the characteristic during                |
+|                        |          |         |       | register-application on handle request                                  |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | Enter '2' when asked for handle size                                    |
 +------------------------+----------+---------+-------+-------------------------------------------------------------------------+
 | GATT/SR/GAI/BV-02-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
 |                        |          |         |       |                                                                         |
-- 
2.51.0

