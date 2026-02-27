Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013031.outbound.protection.outlook.com [40.107.159.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1349326952
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 16:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772208107; cv=fail; b=N4vBEVWyl+MjfRFAFyikXhAXPt3eoFn3SoRYIRaV0JX3glFpPj3njDxzhSUzJmBpJW91ylgwt8Ybnu/d+fjdbDXyv0p7rfD1AMsM8+rfI0CT9l3lad6P2Yt1Lu+HzxPekQ/eLHibiEjqtNwAO/Ou2MSSkhpwnYou0l+tG63cGow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772208107; c=relaxed/simple;
	bh=KVnHQbWlDcWB46i679tiVp8XZwZ+8XHqiI4+pZY3uD0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oMb+oGwgKDbROFYaaDiMjQ1D0BZoIXkS4WWfG7bfNvmN2xo0D/Ysg4a8T4r1jc2Nshrd4Z498lkmEHcV/CjxThDUEyiYIPqh8N5uvnGOc6qLHEuCca9e6XCOu37Ln2h7iy6cA4eq0AU9TMJzvyAQ/dgsh5eoEX2zza2nuAG2CDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=TFMT8Nln; arc=fail smtp.client-ip=40.107.159.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="TFMT8Nln"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fO8lOHSHaUraDtzXvl+1EWhxuDlZbIFrq4E+HPrAToovi92FWma7hyxOJ4qFOUY8oPhzTFIQIorQ0hp29i22IsSSZCQ96IXBlIa6qY/GafIkhq3j6sfoTVRgcTr4s3WPqrWoInxVB4xY47aPXzBilEPb3PXRnkBsxnb2nvO0zrbszqohg6ewyiSVMaVUXMv4eMn5OQeHK76fv6TRMWpqHwpggiYqtnu2S1xA1UgHTToOLdA9xs22S43J17xxoCRkEjNyg/+r1YBTFwtVUAGFgeI9Gr1iaKQO3ij8cX9j1UQLcT33vshpu67EPPzHBww7oMRAHvsTd+Zo3KRRRHVdrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XP7eWED9xdvITX7nXMSJsy7ZNkIBKsAb1mv0+xrOyDw=;
 b=WJJutYYIUyH4n7S1372TOZiScwni4ng+x4CbAv7YJWwbO5vQFq4lK9yIicGPPpm/TFblp5SvLrKmcMUPt4WzqqBxvw85n0fHivhHLV5o/F1RFezevIQFnQCHyFqfPrDAHSR/ojgOT8JXpxTmH5hwFrLvn9z3fmKOTZVWLjdVtqhM5/QI1W8XI5s+BbzRQx0pK5qSdVfoN23ZSBZGIciJllY/LkHQaJmdhruuxBEtniYqMV1SI0x5FOyI9T4eiW/93ebX2fqYI/nPQrblyiN1PfLZJPYhZGHVeQ4kvsYMWfxkKGKhUv/TxAMYZ4p2gtrwPuBxLKwz6KBAqxeLnmE7cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XP7eWED9xdvITX7nXMSJsy7ZNkIBKsAb1mv0+xrOyDw=;
 b=TFMT8NlnK12Y++ouBLq+16dKeqRFBwVwM0EVeqxch8LA7JJhrCmIztSLqEDEXlUpnYxnkhaHVqZfqBtLW0DdF/R4jR7H8AgVnnoClra5AdG7COGuFQ5eK8sZ+DDv221KbuepQrOPKc07byTpI02SKcHQdWjQHCAZgKoeqylwHL8=
Received: from DU2PR04CA0204.eurprd04.prod.outlook.com (2603:10a6:10:28d::29)
 by AM9PR03MB8056.eurprd03.prod.outlook.com (2603:10a6:20b:412::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 16:01:41 +0000
Received: from DB5PEPF00014B8A.eurprd02.prod.outlook.com
 (2603:10a6:10:28d:cafe::3c) by DU2PR04CA0204.outlook.office365.com
 (2603:10a6:10:28d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Fri,
 27 Feb 2026 16:01:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB5PEPF00014B8A.mail.protection.outlook.com (10.167.8.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 16:01:41 +0000
Received: from N9W6SW14.arri.de (192.168.54.16) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 27 Feb
 2026 17:01:40 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <frederic.danis@collabora.com>, Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 02/15] doc/qualification: gap-pts: fix GAP/SEC/CSIGN/* tests
Date: Fri, 27 Feb 2026 16:53:48 +0100
Message-ID: <20260227160022.21462-3-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8A:EE_|AM9PR03MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: 190aef0c-7765-4a09-6477-08de76197f12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	FwKFlstuLT+No9XEs7T2RVod3BzsGnp3weyhNspTLG5oC5TelTMRNPej62xCpUy7uikQDFF+YaoL/RUetCDAgE8EYKzPAYVz2jUYauL4sGZcB0bir0iNykpvotzUKrGHrMMpL2wUjO7DbQAIdpuHpC54jP9dE9srDaE1oxAG9bc2n/jyJ7ssm7hmv24Xb5BgzvVoMo6dStiYJAYdMGCr8PI3n9ATsQgxk1IZNYfi7EdnNbZyv/EKODGcRsLMb3HdAHBVIFIsFXIaAS9brQvNBbVi1gHliw0YKMPSiyGN7UieSakcRPRcmi0kA7VFIgnVgdPhKJevfVIHdXLeUoAA/zCTQTpW3FRggg9TjhIDX/StAbqIZJRy36Jaomp8Kf1AllHDhlO//Hrm94tyKI5L6fga82dhut5CKQFk17hnNMIg4eIKdURkh6cN7UZWWN42fHVuu/xufFTHOdPNdmxppdijaEBKrPSsTnjxKkfdk/EVYHtZTVE7uq4+P6c8mWHoUy6fXTdqbIuEx04sZdMhPrXixFSwlxDDvEweZt/VWCAPyMMALk043ssPLolsw04UgkV/1zNhRW1L+l046cKXW3bjCboHQgBfepEvfwPvTFm2uz/RWze28OTLjNzFbpNImS9PwvrMJ2WWCmjfVXBNHzDl4MSpExixwF4gHTS1a44zcuvpotVpmen/UdBs7j0Nxv6ZAjBnsnFfqQbBpiyb7eugf3EjnjHTGpqgw8Dyll8ri13zly4/A68Sn9uvSP7dZGMmKUGQL1AGbitd1ZWSDSDi0UD9q+CvStfBTnU1kgqkNnnse+JmELlp1/3qWVQouVFyuVCYgYIMqJOtbQGi+Q==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mvbYnTnJb2/iqV8clPNC4nNEtXoz7SjL86r7id03UcUw035BuCJciJoWMchWQf4qAhbXxL2O2CxfLx1NKQOHJ9if86Iv8QHrN5v542ANLguvabPTztbtZHEemOam2BLfA53pg+4mzCD7yYafOCTH1mkZDDu2LPqbc1IfOPIIDWzr0JqE/Q7e1ZFN5C3tV+23Ud3j90rNANkIyWq5MzhjKYDTH2UlSt34cxSU4pA4LMjpvT8YDPl1z75fyh62GOxjiprZs+Ojsffz3zS7tZi8k9TBbb5Wq+IyZhJO65d0/KYU5Z7NamyWLXv8MOQBAzlqkUgzBUHWOHm9f7do7Y8oOqGhmd55P6U1cLmI4ve5yTkGCnfpst6YEwQZpluDinRLxiex9CcxPjAv2kEZTS4BSnQ1ekDccPYi9z3Jl4ryZhELFowXTw85VcXqCDsyMmtm
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 16:01:41.0639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 190aef0c-7765-4a09-6477-08de76197f12
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB8056

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

