Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010006.outbound.protection.outlook.com [52.101.69.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844D33803D6
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772208281; cv=fail; b=OffHm/9nhL/vyR5QYaizRZKFq3cdlAB2VdR2sJ7A4POSI1bA8bEYmfME8Dj6P0G8SdiUc0v+o9WpwLlr/wfEiCV2/KmgfU7XZWXZrh+zPTN/YsipJPYZzsfHQZww28YcSknPKHEWH0hzq7pYDnydf3zVKs7g8EtWadE80pXE3zY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772208281; c=relaxed/simple;
	bh=7Q5VpdbhWdeSEhZl4RwJZLBe7t4WHdMhmbccRZcCxTw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hT1UVQdu6XcfOy1QTpZs6ITAdzrmBOKT1ZVbFgoIVdZQCOIKghBWJlnTWVJP5sRz37X9aClnHlGp4y80AM4QqmbVN0KYfhHKWSLfLlvcQHBFjTtOU3+oMEBRPxvzKjQX9wPTnUWeN6mZgnL2/OLTap8vsBxfD0Nhr8BmEcNxlNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=pqIQBXP8; arc=fail smtp.client-ip=52.101.69.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="pqIQBXP8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ggazfum57YtB/PrdW17q19ZyD+S+L/ahh9oYA55j2fkAsGiSWi1t+uDIzfmFe1ITug4i6EtZd0tucHlHEPywcswr6JFhY1LHVWKaZC7WFZ+Y8/1O28NHo1ZlXS9mryciX8kiUu4TIiH6oYPGhr4r73Y2wWHVYEWoCQDJiKUIRqJ06p4o+bTg5VdVccIOhz6u6FCnkCUGB1IEnH9/bM8MH5fjtUyLiB1UxFMq9yTjLdA20Ck0WfbsW149hknBnTnGf6jv1Ls05woWFnbOR+aCEIE5T5ehDfXLaH/6q4V829zTwGlcHGvUQ5SRgUqiyZ1Z/cbTOZbgLad1zVh+1lLvPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Tv2PXBz+j5gMqviViQMV94POpefcsJGe4p7H4X20Fc=;
 b=L5Q6UzyPVUwdfHhVKooTJ5u3u9tE1S/kipRQUXzwaHIc7orRd45hsaLZe0hECgogUZVvfLA9vj9xjnt8a3lO3bnhT5dgQE1IQC54S6gYBs7VGfQYrrf0blx8QwgzycHr5CCz9kJYuNduIGNhKQ+R1hiJeuTNiyJetN2lPd0YTuG/fMzoiLhkn0wLc/k/DIXVyeTZFyHBNSgDmzxplkmLInwEzKSlNJYfWBB1i7ODWkiUbPUJ3QcrNuQnwjl1fvLFLrLh5vasOGLbq/GW7VoXLEUJEmfr4L+UICn1015XLMDi3MSgcr/QzsWqZp8TaIaqBChsCR8XF6OS7cDuiV9pXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Tv2PXBz+j5gMqviViQMV94POpefcsJGe4p7H4X20Fc=;
 b=pqIQBXP8+huoQaykmiknY9JVqVDOuC/0NzLnOiuF44fHpbXyq3GTIp0al61d/y2IRzjXPWy68EoMuzz7cPQiozgGSgHFIv+OzqzFF4U1P9KfKUCzkXnCU0UJxIFiLwD3/RIow0nEHtQULQc9Us/gaJesRXctT1V6ec8plZ5/hLw=
Received: from DU6P191CA0026.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::17)
 by AM9PR03MB6916.eurprd03.prod.outlook.com (2603:10a6:20b:2d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.15; Fri, 27 Feb
 2026 16:04:37 +0000
Received: from DB5PEPF00014B8C.eurprd02.prod.outlook.com
 (2603:10a6:10:53f:cafe::e1) by DU6P191CA0026.outlook.office365.com
 (2603:10a6:10:53f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Fri,
 27 Feb 2026 16:04:28 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB5PEPF00014B8C.mail.protection.outlook.com (10.167.8.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 16:04:36 +0000
Received: from N9W6SW14.arri.de (192.168.54.16) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 27 Feb
 2026 17:04:36 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <frederic.danis@collabora.com>, Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 11/15] doc/qualification: gatt-pts: add description for GATT/SR/GAN/BV-03-C
Date: Fri, 27 Feb 2026 16:53:57 +0100
Message-ID: <20260227160022.21462-12-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8C:EE_|AM9PR03MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: 54d04988-5ad0-41ed-80f8-08de7619e7ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	c/gUn2e+3gCKjT61PMfWU3kGj6pqfixmfl+oO/4XDe1Pe7pIHFZ045zU99b4Mx4Rx64FEsNap+qaB3GBXd5Z5i6iTRFboJACtwfCSvJ6UiekAs4QV42mL6+Dkj+Tc4O1I0h/WARM9tF1i4xlvOCo6fEBL2a8DjRdGbO4Quuzn4mGKaxlkwW50Eo0WZCXtKRneDczz910me6DmLfMGxuOmZ4fsvqo0DB4jJNdafzj6Q5VUA3oV5j5XZ7yXudIJtHy+yqfSHxkbLcvrX2/CBSq1l1XsapmKqFhF7TNHfCr9G18Vw0M888mzGaIQ+TdkY86b6GyTSmW0YgI8XCAMZiwpXlbxNd7xVocOFrtcJfNZYeXMxh6oj0Cwunh7bDnBdvfZV/5Ks4hyc2zoeSJ4DyTWBLViqflB3OxwzDWCe6d/BGRUOPFVWR2/8BjlRkYCB8STXRjGxYU6IFKAJGo+nDKnlyk4w5faW28U+saO0OeLwc4f1XxhSiyJ7T8oVLkWNxkKu0NSmSCxiauZ+nO+KLgqaByT5PQbfGv6DOE5qIeMqEHfljC2OY1ynj4M/Amb6zXuWMldjvZi2uzTCSxO7AXrwV2W5/HHG2Q8xCeZjVzU3YDj09a60VRkIbgb9OAVE9ZWY6up2hlHkM85sz6hl9WCbMxMv33ll9VVYqf9eqLIIiRQ2S8RhNA0DaVwxSqNhtJJ52IX7/r7T+RXM7CPfFyuyBs0P0tjP2QSPPzrUsEWu6vnkuI+7t+6gI3QSFmlrqnCRApRlW2mrGLNEjo4fuInRXQrHAb8F1ztvwDAjZ8SqzRTgYJoAoV6MjIlrALPH9dqnmMiGE4dzpoozz17af9HQ==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JXSbp89WrvXuNNPpg9HO0hz9qXVIJa8lbZnpgzy8YzgcGZm2o0jfLdpVhxWSCB4P0h8/aHiSBko5eZL638m6fuN4n88VZeUy5AH3tvM3veVWmrokc4Io0afwgEVdkba4vrUvbiuaKogFHZj+NN/J4mujDsPerqtHskxNs37tF7T8XVGfJOxJtFAye+GOUPk8NtL2GBE53Pa2El6FkuDBT2+2ZKwIegPi5nBzGmwO5jplPFJCsLhM+l+UT3uAWZ/t6M2VoXdI2TSUSWTMT1uDETB2kjhqkKC2sfCmU9EL6NAGj9/rv3CSnDCY9ZPVcf3bjE+miEzGq8iwEBayYzduB1RucIoC/SqYYX41PQsOe6DqMkFlBv7zRWRAHi7YajoCINZ6yfJCut3dGi+UnGcnUIdnNFv0OnZF4/+qEixlUk0kp+87hpJcEmtubS65zI9u
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 16:04:36.5503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d04988-5ad0-41ed-80f8-08de7619e7ab
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB6916

Same as for GATT/SR/GAN/BV-01-C.
---
 doc/qualification/gatt-pts.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/doc/qualification/gatt-pts.rst b/doc/qualification/gatt-pts.rst
index 7a2f28257338..e9acba7e7cd0 100644
--- a/doc/qualification/gatt-pts.rst
+++ b/doc/qualification/gatt-pts.rst
@@ -1136,6 +1136,26 @@ for which we know the test passed.
 |                        |          |         |       |                                                                         |
 |                        |          |         |       | - [bluetooth]# gatt.write 2                                             |
 +------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAN/BV-03-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA write,notify         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1' when prompted                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.select-attribute local 0xAAAA                       |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Wait until PTS prompts for sending a notification                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.write 2                                             |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
 | GATT/SR/GAI/BV-01-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
 |                        |          |         |       |                                                                         |
 |                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
-- 
2.51.0

