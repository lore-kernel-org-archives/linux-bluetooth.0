Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010061.outbound.protection.outlook.com [52.101.84.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D816C3803D6
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 16:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772208335; cv=fail; b=bi7vDutHfElvj46GzQuEiyL62+iX/h2Z8yQgWOR7SakWSGBZ3IWir/99/dB8sCT9NbX9YU86jMEVeCtU0wsVMbjoUQqauMKn6rym48LTepnw9f3jwlwsk/nKX/AVmjEICIoZp9I2qzk8T1dLl4coAHX9Yn9Ird4Az/HwN5xds64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772208335; c=relaxed/simple;
	bh=A/uSCEfGUI5wh31Q1OTK1f8BGxHtQUt4xjbW9SLono0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O4NBFPWybgLuxXK8U0nb9TqHsVl/tpyCX2x2PvVlea+G7LwIBh3jR1DpTamPa0FosfJp+GHdEXLgs8mIcMf7slZx2n2b8XFePzJDKh8moDIWvd8wLS/vCHA8w/gJGn6J7okxLDvbwMWgOMGwtUEVLnQzaLdWpVB/uyJfd1ZgiaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=frsb4ThF; arc=fail smtp.client-ip=52.101.84.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="frsb4ThF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xn3lthqMRYcmNAWx7xM0MJk9HpQCasZ/JwBnCnmxtZ5tPr4tJbJAyaFzHHoai8Vyr7zyMRzuYRXTDUaTLit44WVo7G5rv0n6yOkSI45sXwVVyP34MVNlz0Eq7fKJd7UQdvPO5AfqMG9JzJdm9bc5EKk0JjWCm/B5ZqDERLJ+FPTMwaQGAWQN14FV8y4HLLSx+Hq41AqjDvJNNQb21ghq2Ntbz8LZwtcIPTCaEodrBvCtRvyb2soemUS8HxnTlyIIHIMCDJLFExXlxgtask91492Chw1T+0ZcBBha1inRo48iTtI/gzVBSzIPU0RELbsF5dcdS6vp0oImkQ1mkZzuIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxGhWYuq58sZwzG6ZSAeK3h/ZEAWGaHazF6svtStYK4=;
 b=F5STa7J7F77BllZ8uBg3f8xtAivZRFOE2S9FH8RJtGn6DFj5P+PUz5pLMsCXw1+3pEGgYrv2ilE0D90LJNNwuZXL49Y2KU5BilPu78U1jglefvbCCBjfQ/dvVQGUb8V5IhQDSVjPUvWuccfCXrG8ZXLvLjNW9B15JsUsRR0XKdDcbCINCUduInf4V8W8DXYpEwalMUx4M5zCK+WwhBT4wTUZFzldVp74rzu8vp6Q/uzyux5TJUr/dxIwlUwqwaRZItDDdJOkjnR6R1/Nqly6ZMNSUt6b9b1LbYuEnoRnEqtPjKc3mlBWnIBpr14a2cmGUX7I4BXCZGfIl7EHwJtxNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxGhWYuq58sZwzG6ZSAeK3h/ZEAWGaHazF6svtStYK4=;
 b=frsb4ThFd4bwAkN6y//wnEjX6qHm3xl9OB78oiI3eDGj65SqZuNV9hNhuwfBy0hIJ5xCWgQVvrcQEVQJaCIivLfUB88KbfIs7e2dljmaHGG4+dSi7HvC1lwFDg+l0/qon56VAoSFp9K7S+cNt/pzO6jn5vdiv7u67qKjp+MFXvE=
Received: from AS4P192CA0002.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5da::9)
 by PAVPR03MB9478.eurprd03.prod.outlook.com (2603:10a6:102:305::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 16:05:27 +0000
Received: from AMS1EPF0000004D.eurprd04.prod.outlook.com
 (2603:10a6:20b:5da:cafe::da) by AS4P192CA0002.outlook.office365.com
 (2603:10a6:20b:5da::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Fri,
 27 Feb 2026 16:05:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS1EPF0000004D.mail.protection.outlook.com (10.167.16.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 16:05:27 +0000
Received: from N9W6SW14.arri.de (192.168.54.16) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 27 Feb
 2026 17:05:26 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <frederic.danis@collabora.com>, Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 13/15] doc/qualification: gatt-pts: add description for GATT/SR/GAI/BV-02-C
Date: Fri, 27 Feb 2026 16:53:59 +0100
Message-ID: <20260227160022.21462-14-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004D:EE_|PAVPR03MB9478:EE_
X-MS-Office365-Filtering-Correlation-Id: be20ac12-ffd2-4a76-9800-08de761a05ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	LrULBCCiAmdIRD3XaoC35WvDlGRDOkgIBoGbRfmaJehNZHdu1bNSJBGkSFbizdD6V+vrVrfQrE6Tab58e1AhiISuJGn0v5W4nG8Mye7xPv5QFvH8V92PfxXui/27+NhaRhZWzZryec5No7lIm5vQCJzw9BdJkAZjsusuN9vVatzbnwhl4jJgvEiRXuh4rgp15hvjiiKVNbG/TYpgzxmnc/gOt8K0j/Yr1daPsbmGt9tTqqQcATo6zL2BXXWFjVkLy5vrBgh1U84uOf4wXAoQ+yX2E7Fan6Vw8hHWBmtyKsvklHBlMZxMz+7q03/cG3Dx4x2SJKf9rvRL9z8u8u1YvfvwDIIE5dJJWd7YpwKUyAykmuIXNMyifTfUBOWkeMCS0/RntBnHXvOiwdXYDelNkFfaLfpjev6rK/2OtM93QjHcwBaTgJmTANA73ViPQLo4rUz7/Oc+e1IkTvzJzm6DKSptMakXVKcEbzeDFQxFvGmxdToz8V72tARn/fzCWXiB2VBAauBeYn90BUZjHmkYL0Lg+JMYRp9JAfkN6ZyoV1S+uegZQBRQcnxFvWRHllHIqOQOZlHMhB/ZSlLbcgHB6vQ7jlLBOev68jCZKn8RsXDuq1vqOEZ2chUzRXQQtW/LMnYX+MAkhdAmhHyN71aJHVXu7VlunpFsl0KCxyTW4b1W+ZgECgIwM7cv/ig0gcsow4U23wPzX3ejogYtEDefupWTp4VxkNpLAXVw2O4x4Lx/Yw5W9H2aITbHprE5Vf2zu0jj69rNwRsad4Br8+M9RnzFT8sA6wKzXGDvRMWUjLYTmZ/vM2d+/4cAU/LqZOR38kVR7OcjeLEJCHecS/3ELA==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QmSVXZRtn5W44PpSgp7nOeY4GWTbhdbGz1T94OdWnRIoW6rpUvZgtNy17b66+yCyfXcUEwy7Opw18pO+3NEdrOqAG2mIQih8nLsU2ZMMNhybBgioy54szEz3DjaNPslNJfzJaP9yp77F98L8SNFnomaSt6JGpcvOoPWZmneKM/KTUaiSdeSOqwR9GA0uzlXYI0zBqlnZGc3WhXxJE9NHKSKYjGGiXUPcsDzXNI6Em2Yp3PsFzkbGe14Ax6YBeyCVeElEpiZheYvMqN+dtwR87jg32DEoYYsyjU7VlWYqoaGBD3+lGzCrbaf2/ZSQZ9U3A04mjrRKuj1uvxbHjOMtnVod0V01c4UEtNoODpDFJXQ7LEDMpSNZ95rE58pjlEbjdoB/9M4F4ZZpAQCYqvDjCDUFKde7yfR/7IGwEho8zyAZhJxWgWJefLa2FXoN86pU
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 16:05:27.3565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be20ac12-ffd2-4a76-9800-08de761a05ef
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR03MB9478

Same as for GATT/SR/GAI/BV-01-C
---
 doc/qualification/gatt-pts.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/doc/qualification/gatt-pts.rst b/doc/qualification/gatt-pts.rst
index 3959e70ab73d..760d78615970 100644
--- a/doc/qualification/gatt-pts.rst
+++ b/doc/qualification/gatt-pts.rst
@@ -1172,6 +1172,22 @@ for which we know the test passed.
 |                        |          |         |       |                                                                         |
 |                        |          |         |       | - [bluetooth]# gatt.register-application                                |
 +------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAI/BV-02-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA read,write           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1' when prompted                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Wait until PTS prompts for sending an indication                      |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
 | GATT/SR/GAS/BV-01-C    | PASS     |     6.1 | 5.69  | In a first terminal run 'bluetoothctl':                                 |
 |                        |          |         |       |                                                                         |
 |                        |          |         |       | - [bluetooth]# remove <pts_addr>                                        |
-- 
2.51.0

