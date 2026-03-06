Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013017.outbound.protection.outlook.com [52.101.72.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC49D2DCF58
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Mar 2026 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772814147; cv=fail; b=uACOE47KqzV/nFfoVg4VTWXzQdkyzIOl0VqFzU4ACBCfwjZVj9uyKmjJDyPE9nqPvmwOpKnwOklVehVGsi6aNUU5v5UH8MNKqbz7Bs24Ml9JSiGGr9d5pf3MajihDrczkU6S7nzU5VyTG9qJKmo4eRFS5gqhDTZcIjEbsKyKaak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772814147; c=relaxed/simple;
	bh=o6WNEtcbJO3i1yebRvgBXRzKtMHPGE47sAlQ/J+7tO8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=osW8Ra5o6h8EHdEeJ1mvaEDZfI0+je0MPzeNSuHuw3dmlbqq5BmIeFfjcmQNemZ+kT4dJ+o8tgfhc2yzfrhizlxm4O7AzrOfUU8EVZNC6zaZMNz0Q7iGR6pNvtgIIVWKPQpkOXURTx5DZ2zpOQeEusHN4Sk0blIKmZDKGxKs13Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=vKyewCeH; arc=fail smtp.client-ip=52.101.72.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="vKyewCeH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrbG3kXO7d3yY5v8PK/p6wfVsm4uAd9wtogySt/6JX35ZxiPo8UaXSE/cpyfZU28YCxjKCjXjajAFPlHxnCebl/LTnZukuGprtydxfQe2dzj/Msrg7izb6MDsMz9l8ac8JU0+Eld+EatO7gS3isUHNgENj5nwMBaD63MEKgNoYhrEZ4d6+ni7u/I8epZ7UyUb061KyFljIdoqVQLV/k6KEPDB9L/pdOiSigX8fpe5Y55n5er3tmmVcQWYvk2BvYqDB3u1PIgwRg0/LSCZozYZsFuUXSSUKqDO7KFYoLBsEH4d2EJvnrkzF9iD6V87J75h1Dt+MVHud9atp1KZrVXWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmS9DbFaJ3xsMrtZzYIO+JcBaGc2EwRACziOkCDsGOI=;
 b=qRZ9Ggy6i6sup99LsDNosGse0HqfGLbh+MwLXOEbChBYNym6FZoKKVOlmY7pqBCjpvevsZqM1I6lVo0QsV39hVOBb3+lEhNiyfF/MPer/kPMq3p8NAHAjwfoGSQpObX9gEzqVK22301ajMmWbOnxxCXPLvXpKFsrXOGrIizky3xWsbrRCViVbL8pcioXF4rbakvvLZidgW0v2K2ybREtZ6+friiGZr508R1/FopwrNpRnN6tKIGUEU0maIOcZqEu3Y/9s2iUfqdfyA9fUE3Se3FTRZuygRgQbRdJCLWhmpnIO3tMUIHQUUj6G32J39kLl5V27+T/fp9PITwCnEw7IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmS9DbFaJ3xsMrtZzYIO+JcBaGc2EwRACziOkCDsGOI=;
 b=vKyewCeHhfZVYzd08wJ+4MoLToc4z7oqKKu/BimZs7X3rs1v9OcRMVqTSvkkK+fTlJGzgI7/vD2CLJ9itaXkqTXJByntF5aOxZ5E0EvJomyllo6X0ptaoITuNWjImb0jwuDG3MzCjWvq3WZ1zsrID8SCF+XQ88r6gaShTOKhOLY=
Received: from DU7P194CA0001.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::16)
 by VI0PR03MB11173.eurprd03.prod.outlook.com (2603:10a6:800:2f8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Fri, 6 Mar
 2026 16:22:21 +0000
Received: from DU6PEPF0000A7E1.eurprd02.prod.outlook.com
 (2603:10a6:10:553:cafe::11) by DU7P194CA0001.outlook.office365.com
 (2603:10a6:10:553::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 16:22:20 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU6PEPF0000A7E1.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 16:22:19 +0000
Received: from N9W6SW14.arri.de (192.168.54.17) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 6 Mar
 2026 17:22:19 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <frederic.danis@collabora.com>, <ceggers@arri.de>
Subject: [PATCH BlueZ 3/6] doc/qualification: gatt-pts: fu: add description for GATT/SR/GAN/BV-03-C
Date: Fri, 6 Mar 2026 17:19:18 +0100
Message-ID: <20260306162058.15154-5-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E1:EE_|VI0PR03MB11173:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eb5a706-2a33-4f83-1810-08de7b9c8a6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016;
X-Microsoft-Antispam-Message-Info:
	ltqP7nSBmikOpeGi1eMDbm381PpZNQBOS5SDVsN/NNmx6rWnR+H16v6VMRNswcaZoJpVU36tVF2g5z38UJwueOoUOT5/B73Ceet9BKWPDZN3CC4gZkGLV0f+5c+KdyrECbMuI1JpsAKL1buKJm6vAL+EWvPhq8pYZNbLmRZUAfUIP6pD63LaSZOWLWR9yFYJxsnCTa2P3pxpyQqrZAy1jc76LYj7n7UIaCNoZzB9XUtkv2JPBCeMtNk99GthcgZhH2Tu10orTQxZlng6h91878oy9svnZIk2tqQN1fZPvVzRWjp8L6hUreAFZ8z5z2wvwd+3E//rU+PL9mA5qLMTu7dJQO3rdd8L3ZuX9MyDszFWMRjNKq8UPnG9SCfQTZzZgv/sN844RNjtdMBNGV2OlS1QCXbIN0ftIOOVR6ypcpE3UoBPDnTezPbis/M3ohEiOy5FgcACJCG5+RZYZWC5L6lXN0UOSj2Ei5EuSRGn+9zrIoX3PK5zXyTpYhjhxJfAKh+Z5Hkane8IWj34b1ynj3BvrveRXIly1IQWDzp8RzGk+zQejbcQbe3QperZtPc6SyrS+C/d3+mWj0bpjMIVGXqGEpaA4QvDUqnmmRIQnONEoLjELicDZPnOsIS1XTjnmH4FUSlHSe50VmIVn+HEQQ0yyFG5+zhO2UrFIJQlbOeODZAUmbR+mbK0R0ngRw8dG0w0j77dzG4Wj8obTS/xxkerhSmis8gp1eznP0IF6QRxFqqfN5pg5UC1T3BmynI7SWGFOIu5Dkq2Ub/9Ap+C9w==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	16qTkqoULDHANDcb2D496qekaMJ5rp1fcbVXSdh8ZoH8LMsHxjeCXyOf9EEqoHwkoXSWhFZDYodsIdKGsVDRSd7TZCInkMXRdQXwJIaNbrn5Q8K0Oe5BcauCne0QPSLVWABdpQ+8LfCl3JRE6yXd7hOFhvShoVtsxAAIg2UVLYXUrVSCclq/eSjdkTbDdAscW/6Kp8gjTYX4e14Rr+BcUeIhFjtmXIIbW4/HW02gV6mdTwfBmVu344Q90EEQv4gxxBY5l7BdPNlyf0445HtWZBf6wwFEth6RCJaAXuc33YciFQEBhjeOJW5BNA2cRDpfSXOHtSCOCSFwxN4t522jHA1Cl6gMjFG4PRc3kLBUcQ1w/j7AtfrikKLrDAPCKC5dfYAGtMDBrJxEZghtUQCReHl/25fXqenY972G0fyNt+3VSnPf3f4IqJ9Wp7g1j5WA
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 16:22:19.9989
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb5a706-2a33-4f83-1810-08de7b9c8a6d
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E1.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR03MB11173

Unfortunately, v1 of my patch series has been applied to master. This is
an incremental update to v2 of 268d715b80e0 ("doc/qualification:
gatt-pts: add description for GATT/SR/GAN/BV-03-C")
---
 doc/qualification/gatt-pts.rst | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/doc/qualification/gatt-pts.rst b/doc/qualification/gatt-pts.rst
index fd1fa8370d50..4749fef1d677 100644
--- a/doc/qualification/gatt-pts.rst
+++ b/doc/qualification/gatt-pts.rst
@@ -1140,23 +1140,25 @@ for which we know the test passed.
 |                        |          |         |       |                                                                         |
 |                        |          |         |       | - [bluetooth]# gatt.write 2                                             |
 +------------------------+----------+---------+-------+-------------------------------------------------------------------------+
-| GATT/SR/GAN/BV-03-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+| GATT/SR/GAN/BV-03-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
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

