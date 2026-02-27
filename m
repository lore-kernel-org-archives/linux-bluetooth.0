Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013034.outbound.protection.outlook.com [52.101.83.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4DF43E9C3
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 16:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772208150; cv=fail; b=okA5JHzvn5hXrt7zLJlmLGH4gB5DCgBbZegIFgHJCJJRjwTGk+m0r94V+syGOQCJcQq6/6AgJRTyc6XdLyP/37o3w2HD8MWFDpwtMImdN78d2uRppAdwIq9ivCsT3J7XBANmhPReAzjz158D8YsM8YkRnbN+6a5tKwUXTaJyB+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772208150; c=relaxed/simple;
	bh=kgtjbrsv6KA2AEdCfKSp7LJkdUvNPgXDpPyNAySd3q4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ls0jUDB0h/SwPrEOZOBy2QlMjXtWg6GZ/qQnMSV8Eyy23+nZUZtppdx5iDvbRsS0HHjKaM5XUVRZjlcNSvMQVmw+MkCuD6OfkMb1d+zqZauBfovQ9BVpCGx1aObpBw4Uemz5jFfyhy2/X9SKmuLPKIalKMs3PPJPKlyqutc5bRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=YsX2/0ZQ; arc=fail smtp.client-ip=52.101.83.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="YsX2/0ZQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RyIY34aMQdph9XQzYTfrgGLf8CAfFlCMvUTmFNDq88FoHFIwvG/dNXQ3GrdHWHhrO3KEN/cUpSwIYu2YXn1bTIX7DsLSTY/5r9XIGyf9L9DvTsFkkhpiT7UqiuydaFPCZ4xuosY39gIEISnQHqRfCp/F/1UwDKznvVmHhucg0MdnXZZMVk9+2clNZDZ+6tWgf2t30hF+UWGVLhyzG1SVSgZ+Kvrf6p62Ei0NQ7D4QCyHaAZ7Skw7+tsJF4L2N5K9q8v0rYupDMSoJzws1FbHYi+E3+Zd9SYqoxZe0OXKpHZ9KwobNtuBqaT61xluUZ+V2pPnNb1gAwZKABEsJKHFfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eufmgWnX+YKE/julH5qK4u5iCZf/vajrYpn5Nn5lEDE=;
 b=vfTWFQKLAuxksqMzIBPiDc9E6mA9KuLNEAUqBQYHklQyMJlE/jnlrT1MU4/4NE816PWJkRX3ROERA+PMzXz3dODiH9s5Kzg1ZDr5JrX5SsPOaU1ji0xW50Pa0P45xcyrFQMYcqX2EzNiAb7gAE/vZSL5HwDn80MJw0MmexxNPnQ83AUb8dUZvvAio5RCT+MnDV8Yq/FkJ19D6AA48FrtM1QRWkD3NoNagXecWvjdQ7cGjBL2tfH0/Zlf2mwa9UBD7cloL+Gge2q9fW0FtaofnbJSxjRjptPvseREWv2RDArwCu1ki+sc6TpNMpjtHxV3n1lIZPy5jAKMrDhPoVFxag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eufmgWnX+YKE/julH5qK4u5iCZf/vajrYpn5Nn5lEDE=;
 b=YsX2/0ZQdYBrtSwYcBElCMWb7REATDcvNM1GF+6cyAbwLkmMXCPOjf/Pswdon5CjkccWLyQ068GCRVa3Z6oLU2BWrddT/oME6bo3Oj+/BblBZgHvkoED0j7r6DuN9V0lujskme/rIx5Ntve494UhSw/lwyFnLRwMLoLl0jFuUvY=
Received: from DU2PR04CA0256.eurprd04.prod.outlook.com (2603:10a6:10:28e::21)
 by DB9PR03MB7516.eurprd03.prod.outlook.com (2603:10a6:10:22b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.15; Fri, 27 Feb
 2026 16:02:25 +0000
Received: from DB5PEPF00014B88.eurprd02.prod.outlook.com
 (2603:10a6:10:28e:cafe::fc) by DU2PR04CA0256.outlook.office365.com
 (2603:10a6:10:28e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Fri,
 27 Feb 2026 16:02:21 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB5PEPF00014B88.mail.protection.outlook.com (10.167.8.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 16:02:24 +0000
Received: from N9W6SW14.arri.de (192.168.54.16) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 27 Feb
 2026 17:02:24 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <frederic.danis@collabora.com>, Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 04/15] doc/qualification: sm-pics: update capabilities in table 7b
Date: Fri, 27 Feb 2026 16:53:50 +0100
Message-ID: <20260227160022.21462-5-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B88:EE_|DB9PR03MB7516:EE_
X-MS-Office365-Filtering-Correlation-Id: 301382ba-4ecd-4b77-9b9c-08de7619993e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	TOlvMzAwswNUMy7XpShFD6x9t/JImp0xlvWbbwrNHF/5XJPBnNZJFc3R1QI4RwxVe3FhpVYJXwBBhviu2MVK1QL6GUFiz8v7NNIAmxvQecMB8J8oZU3SrlHFr7VM5ww7ehgJjaHDB8OujwIOawcaD6ZFFuPV3Z9LAm/Vnp+YEdu6FT0P37VLh0LEmM7D4Mt46h1nrtYUZeG9F4idtC8p+R0oSjqSzIUV7xAGcQ3Vczo8+IQVw+mXWMX+55Ppe82wDTBAKbryqZikKLzOA2x5Jvl/EAf+GMbQTX6+9xfpqMVxX7bEnT3wRcHkC4nfaj458g6bmH6oZoq+7Jro79jrq5EZ2NQXjDWFZxdomtbVixBBtYba4mlEhU8EdytX9L/q5Nvxwo2Cs42K1o839s20t2h50OdbXzcDFHx/yucmR9p3v5mojjnir2WI1ktco0zzptXT/rgzjl8to8ORY0GLz96GdoH9WE0no0FtMui7DLGrqjtOV9Flb368Vxb2P91iB2JouwbJs+woSuqur68bOCtsRiCSJ6zCcRtjUC/9PK1GngaxaCbhpo8h9LruI9J3Zts7kuNauWe+AvG2Jb3/Lyi+WRsHdO1TRpqpRo8WaLjBKJmJVodBea4RL3fkcQRDr5cxji2NLgbX/x8QbwY4yNs7oMJ3sXfmvoOfgRqTjn25rDC/ksSu1KmftDrHYpefC/jUT0JDJSZ8TYoqRaVMSlHeZJZuq58AAkiXznwPkKGlN2nFoNgVlzHJ8tDNo3rdqSvqGTPvif4ompWvRucZ+z7ZWsbl7BOFvok0BjKbvV0mQa1VNhyfTFr31Qq88jOTfPSAX41UXMQ7RtlL6U9y9w==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	U6iHX+/XaNGvCUBwgFS/qlZMEekRy9Y4S0AsyVP0WwzqFdTZKc14at4gMJZhBRKfN0aDtyPJdCPYm/IbxvL12291pWr+z7mqRVjya/IiPB8BmcoX+hQlncBBZbv7zQxrtQtIWM7fSZzV6EjfSNpdU/Sko5mLDQcRn+zsfW4LWNaVZM+QsDh5x7He5cOlTtyZbtPJ62af8kAUI0UpzV2LpYXoN7B9WL4Tz3eE2e/JniEbshny07OlPMHizJ3qrP06GAucU4rZExPXwAe08HoC5U+xNja0oFVlbINl2noyvUIZxTrRJLc5xhqERVkYJH12ZUbGQq7LfIoR0XcGZJIy5xrBrAzIc68the45rZWbPZ0cvUXATckVTMvYcbSdBjGYaWIG90nB4f5HBJxdOgusGpcN6TM7+RJ5Fy//sMCNHLrkVzekFM+8cgaKZIRmAuE+
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 16:02:24.9744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 301382ba-4ecd-4b77-9b9c-08de7619993e
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B88.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7516

Match naming with current Qualification Workspace
---
 doc/qualification/sm-pics.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/doc/qualification/sm-pics.rst b/doc/qualification/sm-pics.rst
index cbf375a0307f..91c4f0ff449c 100644
--- a/doc/qualification/sm-pics.rst
+++ b/doc/qualification/sm-pics.rst
@@ -149,14 +149,15 @@ Prerequisite: SM 1/2 "Peripheral Role (Responder)"
 +------------------+----------+----------------------------------------------+
 | Parameter Name   | Selected | Description                                  |
 +==================+==========+==============================================+
-| TSPC_SM_7b_1     | x        | Encryption Key (O)                           |
+| TSPC_SM_7b_1     | x        | Long Term Key (LTK) (C.1)                    |
 +------------------+----------+----------------------------------------------+
-| TSPC_SM_7b_2     | x        | Identity Key (O)                             |
+| TSPC_SM_7b_2     | x        | Identity Resolving Key (IRK) (O)             |
 +------------------+----------+----------------------------------------------+
-| TSPC_SM_7b_3     | x        | Signing Key (O)                              |
+| TSPC_SM_7b_3     | x        | Connection Signature Resolving Key (CRSK) (O)|
 +------------------+----------+----------------------------------------------+
 
 - O: Optional
+- C.1: Optional IF SM 2a/1 "Legacy pairing", otherwise Excluded.
 
 Key distribution and usage
 ==========================
-- 
2.51.0

