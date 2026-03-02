Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012050.outbound.protection.outlook.com [52.101.66.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A273ED11C
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 13:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772459342; cv=fail; b=hB17L4Hnn5QB5N2v/dttDfgPC5Cmq1C5ikbxjZVBiXlZA9Qf2ZSUPff6LjlsI9evqxW0Rkd4p4OOw9Zhf7qUnpwed7xD2OxUNNDn2grvkETJdFXVmA/HQKWI+j4L7P2Vf89Zpaz9IHiBfAl9EwDkg9suO8v4sLFWnS3mbMx1cDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772459342; c=relaxed/simple;
	bh=l4YQ+zxlvFvTmsnwyusMr4p3hNqEpyeBMtVcUXl/B1E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P3HnK+4SdjZZHrNhrq4yiVWGGPa1fH6vLb/LL+wo3dlDe0SVImZbIpaBq80WP2tKPUFMNqnN7re7Z71r3qGp9uFBnZGUin0X7vJbCZ88cWPOVzSFRSuVLYalrN2GxGpxe+t7JLeXrKUVmmnFAwURnZhZBMNJ52kS3D0iAFFV9rE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=aYzXF8Ci; arc=fail smtp.client-ip=52.101.66.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="aYzXF8Ci"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXyxLNsq8NkMO3Y4Gu7WJkjN9FN7KdIVQQ0B+7qkiGcb5BG94VjYyjB++sj9THd3ihfrHOyfqasu//dYPaxU2fFwKbCx6xMN7p0q9x9majyLhTo53e489pNZCP88/xPqjGHldw0gYs4mNSnC54sC1EkuL7+DtbkhYVUZCYR5TxVKO/M0Ru8XwMb6+aaGnzOd+F4a9n9Yj+bgPJGi7Meo13nq57ZjVGoxJcIf+XN/IvSW3t9VqLcFZIfroQbWg3nCGVWv6h7iOm9Xnx9nbphVZ55fFgY1FNwKvGvG2c+fJp5/5H6uT2Y9hsaohY9dBxk3wZ7f2f8EThLqUbK5vi1sSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ci/9tNzuVMVHhbDHzxNQIGAbVnGO7ZV1POyFBJ5G3J4=;
 b=yHFyjRkU+sOEahE+toFatQb6jZdwShlVQigDuD/XPRN4WNwSimBZL3ntHwa9wfK2s2vaEB7EGS1uVB5bf9P94CUPgDlMVJaxCvJb2i0X3BSgf1yWAE+g0zqFMBhnU3oqUWatgVa//HrqM7P9gXoFhq5rk6GuFu/179rgYKlCkgw4E/TnG4wOh0OoEhYq2SZEQ0HiPr1wVFC+W94aDco8g8JE6/88CmSalu08nH4pQ1S/KdR+RyuXT6WYjusg/wYgzF+ToJHSdPnIL12HNEF3Bd6E4DvObGtRAlwIL5JrEofWtDFyjW3rDskmajmf+6iSayHCortmRmZcyRl0pYLRXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ci/9tNzuVMVHhbDHzxNQIGAbVnGO7ZV1POyFBJ5G3J4=;
 b=aYzXF8Ci0yGgsywD2IBQ3xKtI5wReGXcnhba8ZRHfTdno8gso/N6fT6SaFTloKDK8HMucME/pAsOUNKNyMF2cr6cy7HEmJdXH4r4onjoeSJnN1nlmhVBWMN8Juz3MVj6Sckmtx2/2xm62Y64+xgIT2MqIkKzftUSq44zgdoOjwA=
Received: from DU2PR04CA0303.eurprd04.prod.outlook.com (2603:10a6:10:2b5::8)
 by AS8PR03MB6950.eurprd03.prod.outlook.com (2603:10a6:20b:23e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 13:48:52 +0000
Received: from DB1PEPF0003922F.eurprd03.prod.outlook.com
 (2603:10a6:10:2b5:cafe::2e) by DU2PR04CA0303.outlook.office365.com
 (2603:10a6:10:2b5::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.18 via Frontend Transport; Mon,
 2 Mar 2026 13:48:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF0003922F.mail.protection.outlook.com (10.167.8.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 2 Mar 2026 13:48:52 +0000
Received: from N9W6SW14.arri.de (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 2 Mar
 2026 14:48:51 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <frederic.danis@collabora.com>, <ceggers@arri.de>
Subject: [PATCH BlueZ v2 08/15] doc/qualification: sm-pts: add description for SM/PER/KDU/BI-04-C test
Date: Mon, 2 Mar 2026 14:30:36 +0100
Message-ID: <20260302134540.25540-9-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF0003922F:EE_|AS8PR03MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a7e3f8f-ffec-47bf-948d-08de78627070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	5cRfH1VerOpw6P/r4zNCCEUnbtBJH3vGBoG5f57QD2vh/e+vFlBsWWz1fktFa3r2cE4zTWINPuSqyljv7NeIiamnmbcjRHMKRlCMjPaN93mMguIBsSC8B+A9R4Sj75mEfW9gDxH2e3nctOZV8Al68yBpIobhwpMCpLvNcRilW2DYGpXuEKfSA7Cq06riMsqV8159moWApvsAT21XbqS83ni2XgBxa9hSdUNUQdImJuSMVupUplhMzgD6yMOcK3DM9ijuySv1MuHSMuBWmWza9DcyA1JMWu5mX1mwrXID7vGUWogzLyB8Bqulrw+6R2a5gUh8SLIB72xSScnt49Jvtc+8yIHOvPcJcnN1KpiKsEzakbOiP1vmVAhcUrFkLy0VDW1tBEOsv2AcMDqiliC7Mri4QPeAHm51RDKWt7goAMaWLWfh//ONNMpVPe2oZ67PqFiI+sSKHmnd/b/TSTRmo462JD7P+kSugwA6IU7tJfa0g4uIR9qGYjgkL0avQNZ9oeZuBSMWjT1sML5QSx69mnICwwU39fQRC+ae1XakheOLNMeIX72yaI2QF/9tCCbkNvLJyrovyQjyDnsoSQC6/S3Yxz7GaH1yaDwwdERf3i0/KH+O7mwgpRRtIef176jDzwg1PJgqREbm5+ZjTDBfcuUFMjjCMtTUUnkpzD+2rO6fJnpYlPJvDlGPni17yl/xzf6IzmquMXb+/OHSBV24n5sqdHRL6Gp2wK3haNxz0JU4rdBJUzr9S7D9x9JSVvnc6cxuJqu09GxOJtcFqOC2SFDxr5o6OzUZaK9K0YP+OSfvibWS9dZhGnSKCyNnMBZgYBu0a8EVJ43UinI8yVNTUA==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Usiq+rHTZm8cyMdhuyfDI6G7+F+hDfNnCDnPIeaATO5dkJaupQhdZbPV2l0FGGb0GYtMa5YE1hJ109k6zSMiT7INufZ7BiLB2e+CVUPhJh0ipc4pFDQ6uPs/OQGOjse/lQlTxrDV/AUjMD8ezhTY+RVhWixBKxzp5An3haKt40m8KNz1QyaBMAGr739Fcf6PZs78mqM80yUZyiaIq0GuYIb0V7U9QkymD40pjAkEIPEvAlwJXDt1B92S9Om3b61kE4/fRtK60/fTTkdkjIwmc7oJAIwo/vVQLLXsWAXARImiAyVn4OtyDZldYvgXiRBYNAi82z39PZL8pov542iBtpoxn7apkLaeuSs+YKu17PNGX9S5PldrGcV6NOf8AuXGEP5YP8z4YWYYUNB5AzavZtga3RP0r4FZToIrfpZEITfd2r/0r0gH6NuOtgGQyvTX
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 13:48:52.1024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7e3f8f-ffec-47bf-948d-08de78627070
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF0003922F.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6950

---
 doc/qualification/sm-pts.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/doc/qualification/sm-pts.rst b/doc/qualification/sm-pts.rst
index 983bf8e45ebb..38ac2c5babf9 100644
--- a/doc/qualification/sm-pts.rst
+++ b/doc/qualification/sm-pts.rst
@@ -630,6 +630,22 @@ for which we know the test passed.
 |                      |          |         |       |                                                                         |
 |                      |          |         |       |   - bluetoothctl advertise off                                          |
 +----------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| SM/PER/KDU/BI-04-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable on                              |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise on                                           |
+|                      |          |         |       +-------------------------------------------------------------------------+
+|                      |          |         |       | Post-condition:                                                         |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       | - Run:                                                                  |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise.discoverable off                             |
+|                      |          |         |       |                                                                         |
+|                      |          |         |       |   - bluetoothctl advertise off                                          |
++----------------------+----------+---------+-------+-------------------------------------------------------------------------+
 | SM/PER/PIS/BV-01-C   | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
 |                      |          |         |       |                                                                         |
 |                      |          |         |       | - Run:                                                                  |
-- 
2.51.0

