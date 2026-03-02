Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010029.outbound.protection.outlook.com [52.101.69.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C138379EE1
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 13:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772459400; cv=fail; b=Qkw2tEgEF09BNRmiO1WhwIBMBXsWvR6bgdTk0k0UajuGkxq/OmVUjH7NJFZynJXczRBuEPHI4emfMsrVXtHWU36E8HTSSrYJs1X1MIEVA+2pGr5rcTo52obQ4pww4rHHBjToZUmUPNhFzZhSYNrXZDsvva2DN2wuOsm4O4G2iEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772459400; c=relaxed/simple;
	bh=RpKN+HAZvwdwaAbQ1rTjf8ovBkoLF3eys9MmWY00WgU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SOiOKjS79ts2seFb3eleEsuc2WKS2G1Jq3XAtsHZTbcWIeWFjh9aTyyybtNohizj89TGYTCbnpksTgwalUHO8/ICZqRZLowYqnI3b1IXARkXrCR6GEK7YWBrKZHSAMW/dX+YWQKnoeh9H5ktJgy+yHDfyzT42zxhIashknpKwjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=dnacEcXx; arc=fail smtp.client-ip=52.101.69.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="dnacEcXx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crZ4Kttdhqfc31mtmJmJmDfRANP9kXkC2Klj4mgFUG88PAQ3M+9nUCbxZjpVk8TP65IJ2/JIPZsZf9QDA9kBhnvmO7d8XLu2tc31lqAorZ4AIzQ/utIDwGtyJx8QDi+9in9JTQdUS+zhNW+4TMUnX+0eqkZikON/lLpxrkss50EZdXL1qjF+03cqoNo3nj3uAej/rb6UKY4Fc0oyCC8BPBKbKA14WjDWXdHkMKAiOiNaTT3XnHvujQ7GvCefsbwP6tTgRTPygYwgTglA+Nosi6dtg15ytwh5FD3oZC365RpM8+wkcGMgCAUb/6jsqlgL4xpMkhgYjIN6YziqaRR7vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bQg5mOy2Du73MBBJUzjDt7e7IPlnixH7rZVKFChyz4=;
 b=KacKTiHbao2NObUL6Bvkj8s+gluNorGnpgcc4/nK6vECsbP4rU+5h9N8EMeeFOU8o31kuPXEZYtBqVFEO0GbmQhIkZFlitBRac/RdB9aj7finvj8cc+oB0yfPgFSRDSodJoRbY4A9z2CkTV6A9v84cweTdELAArnefo4n/P6mTJZ3dtsb23f5fVef6Rcjfh96UiaC6KZiKthCKhs0usnMWtKeWCLBEaYzjxHrOHV4bbvgNDWTreIGDzChKcjT9XUpCWgbxkHp4fVJSCIkQ29viTDe/UrZwKv005NKAqbVh7BNVRnD2BerNgY5iZJ296RdydkQZowm6d26CMaOMtjVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bQg5mOy2Du73MBBJUzjDt7e7IPlnixH7rZVKFChyz4=;
 b=dnacEcXxz/XZv7B/tG4b1WlMKH+nC6G6JYHL70dpLG5m3aZJvLoxZGDI75iVqQPWXu6qvNWpFuAmKZS2oco+rNnN8WwFC24iSzmTntcsaYror4TQzxkrfuwP51Gvd/JES8QPhX2ZnjWTNQ+2uoZ0bss5Yjd36WDz1loryLNBTSs=
Received: from DB9PR06CA0025.eurprd06.prod.outlook.com (2603:10a6:10:1db::30)
 by AM0PR03MB6161.eurprd03.prod.outlook.com (2603:10a6:20b:15e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 13:49:54 +0000
Received: from DB1PEPF00039233.eurprd03.prod.outlook.com
 (2603:10a6:10:1db:cafe::31) by DB9PR06CA0025.outlook.office365.com
 (2603:10a6:10:1db::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.20 via Frontend Transport; Mon,
 2 Mar 2026 13:49:42 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF00039233.mail.protection.outlook.com (10.167.8.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 2 Mar 2026 13:49:53 +0000
Received: from N9W6SW14.arri.de (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 2 Mar
 2026 14:49:52 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <frederic.danis@collabora.com>, <ceggers@arri.de>
Subject: [PATCH BlueZ v2 10/15] doc/qualification: gatt-pts: update description for GATT/SR/GAN/BV-01-C
Date: Mon, 2 Mar 2026 14:30:38 +0100
Message-ID: <20260302134540.25540-11-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF00039233:EE_|AM0PR03MB6161:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a439c93-3d8a-4c00-35e0-08de786294c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	nIhnK6bMgteJHA+9xMXZHBPNvhIiXvVh+mONxBuwcMPJbL8Fu33wQ92d/iAMbJ1LePJhDcVLgcLbNTNjQdL8f7AzkkJtgHZbDgFQd55PiBNH3XIJoeeKEO7YGLYxxa1KU44if+LgoWt1spwes2yowJ13e5goB4fdu30/fWmEFHYazL3Xwjso+DZVfC/O5a4Ysq4rDu2XwGywK2WES5vvDsMyxDiDz8fC14ANXF+8AqWPgJmWzgAsV2en8cmR6XhKlUDx2YuaX95LKES6ew/+xR/U/3TFNWrgRTxgOf+zOTBMEIjWiGBdz6JlYAPNxtd79iJZ3V3wAPBwMexWWArjR3tcgbJyQAL6HrGgki4xIEIAqlPLOlxRHTXlVqKh5ftkmPyxqmh+7ze0P5AcDhSHKo78naWfT8YgBESZ5fOt+51TmpFXPIN4hZEKubIdKMleRXDhwmkW5muVHF7mC1lRNGRDxa/lXvHL6KFPROuahXwUo6ur08ByRKG/9vwxuJEdmxwnAdq6TQ/nnUSzetYtkILi6xlVMpXHayLls/sdyBe6kMxHjcRiHzhuW+OcSUwon7phdETSN/E+910r7qgZ0Kvod131QBPi3nVeJkrfeB2bMvOSrKCRbtEqQTfhw3P/9HkVGe8XU33zrWs9nFqAa4ISV8mueyg9DXjDyQ4MnyCDx7BZnZfIovnFGqiDA07fplWQtJiiSna1vvK/sLweN+L+RdMrbYGBKOe6XWCLl4JUh5byaFGG20UlpKufSSfC8tFWNe0NAUxLBiXY0IPCPrWS7L2ugiacTGl3ZNZa+AIw1NnKI5qc5LMdp/SfJhlfwV7n2X22i2FbIkTOgTNC0w==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	S3yeKrOgHkwOVcK162xv0kRlIyswu+yS4e9XpmwWhHeJR755VrgKsk0JIXSJfOg/CtFUEEIPwp3I0gS8zMuTnTlO94xzjnKqem/wkOTlnE8YYxfpmMmaB1C93+A9L/aZHPOdK5V4IfisJO4PUM0ye2hkqqJMzWTf5jCtGdt7GOpF/y8GLfF8jn0ICYxSItJwJaUs5Qj7QlbQx7L/qNoRKQJUagf1tM2/JWCSyJXBDL1L97PM9/Sxj2c+6PUW8/1DF4ij05A+wmOSChHVctht0oH1ge+9sp/I0hqCbpsMzlW8nolGeIVr/M58LYLyPDLV0WHxFQiRYmyIX3ooFHUa4QnBJZTRqCtIfKCRuK2qy1f/HXceQHs92SRx9KwljGCFflv72nPAj8/U5sA/BWdbm1NfcrMjMBRUpL0dHVTpirhnt+nimjb4OFoH6kiUr7I7
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 13:49:53.0407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a439c93-3d8a-4c00-35e0-08de786294c3
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB6161

'btgatt-server' exits after PTS disconnects and is not available when
PTS reconnects. Starting btgatt-server again would solve the problem,
but we should prefer testing with the real GATT daemon instead of using
debugging containers. Additionally, this solution also works for
GATT/SR/GAN/BV-03-C (next commit).
---
 doc/qualification/gatt-pts.rst | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/doc/qualification/gatt-pts.rst b/doc/qualification/gatt-pts.rst
index 803b700d97e0..ea0bc2fd3e10 100644
--- a/doc/qualification/gatt-pts.rst
+++ b/doc/qualification/gatt-pts.rst
@@ -1118,9 +1118,27 @@ for which we know the test passed.
 |                        |          |         |       |                                                                         |
 |                        |          |         |       | Enter '2' when asked for handle size                                    |
 +------------------------+----------+---------+-------+-------------------------------------------------------------------------+
-| GATT/SR/GAN/BV-01-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl advertise on'                                         |
+| GATT/SR/GAN/BV-01-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
 |                        |          |         |       |                                                                         |
-|                        |          |         |       | Run 'btgatt-server -r'                                                  |
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
 +------------------------+----------+---------+-------+-------------------------------------------------------------------------+
 | GATT/SR/GAI/BV-01-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
 |                        |          |         |       |                                                                         |
-- 
2.51.0

