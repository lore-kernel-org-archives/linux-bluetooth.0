Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013033.outbound.protection.outlook.com [40.107.159.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A07C3AE1B7
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Mar 2026 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772814225; cv=fail; b=EQJug0bDhpz7jJQRzCrJRKBVbf9gByQ5oEBbFiDDmd6xtnYjDou4fzwY6B23RlliH9oxfT/x9Qr30i8kWARN1wjvrT0kYzFCnSp840OBq1B66Kjn8xOekow67k2zwGD/3USd0Ly3GbpwKHJmlafkGnrJbUBTxVJlzss7bxtP+Us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772814225; c=relaxed/simple;
	bh=JyuEjK4qytrlN8qb41YDpkCLYjpUgzIxhU7j9yazNrE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZAWBG22ZO5OneJDEGhYBjAEvbDKrnEEfKiA/0LhDf0MXjEFa4Qf6t7WaOABtsfBHu+utxgHbQDxF+AL+dSJMbEHWkjZHbTzqRETTPMyg8/430+4ZmVmIu6zbKk719pc8YCpnZ/r9KDJWmVfFhPs1GGQhHRBuTP/muNd7uFdUf5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=Xt/1yT3a; arc=fail smtp.client-ip=40.107.159.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="Xt/1yT3a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rn5eifV+JEMSBXgH21GaXa34+THUO8axZDu6DMaKU6YGbvbdx9IHoaPwXK5u1bcpo1lR/NkAdj498vXqA29ywy2AiqMiq26Bx5dmLliDyjlK94i6cZ5o5hBHXJcnLKiT9oS4jxZdulbpacPdbksNeftQJrzsV9y4KS+yO5lsZz03DChWAMLVhwnN42ZEDQ4kG/ae2nW6W85X+DSb1uWKy6Ms8LjzBteFmi4RI4lPmProBPj9WaOm8JVmJMggcDsARYfqKJw1y/FxFpqVEISOi0NLnPosJ9L1xy0rBqELIdACp6yI5c4mXXQKn7NNWXrry7Ufll7zyBJmm0rxL6bVRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4JCB/vCRM3hRqYq/quvNiOPlB5X3qFJDopw8dyQYJs=;
 b=hT1RkeGcn+twG5qgXPuDFkD+MtPDl8VOrV5YsS+u1I5Fx7xAlIem/yVQpGBlNWLHb9hcZOikCT+QDr36+GC2sK44nJ+IiGGm2jLp47mPCGZ6q6/arsA8pxtkk3ehisxZE24LqwrUqUCFKTWjQBfskBZIMLouY0asx+SZuWgfWek/SFeaajNxEHEcdYUN/lBZRXj70m9afCqO0UiCT1vAUEJY8cgzzoHn/x0QnIdOrf6mTnR/QJHLlJhx40r1Mou/+1h9LpOsUTnXcQGJWfnNkmvT8AYBb4IGh4SXVFbv771ZMmC9LaFU4lxAqBYAln7MpYJJdM76FdCRxd0FTnEgmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4JCB/vCRM3hRqYq/quvNiOPlB5X3qFJDopw8dyQYJs=;
 b=Xt/1yT3asxPpR9UxtTgrO4SkyttMOzIyQbiglUwR9ezyPj/jZS/XMtrnmBI4bTLOiY6hhIx0rs9Gl0+gaTkbACwx1qWNbD7JbBJZ3GfKvYewWvGF5ohozY9poht/WFsLEMIK8eqro5Bxz7Wg713La0xGlWOr1W2F/smXiaKwhTk=
Received: from DB7PR05CA0004.eurprd05.prod.outlook.com (2603:10a6:10:36::17)
 by GV1PR03MB10234.eurprd03.prod.outlook.com (2603:10a6:150:165::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 16:23:36 +0000
Received: from DU6PEPF0000A7E2.eurprd02.prod.outlook.com
 (2603:10a6:10:36:cafe::b4) by DB7PR05CA0004.outlook.office365.com
 (2603:10a6:10:36::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Fri,
 6 Mar 2026 16:23:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU6PEPF0000A7E2.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 16:23:36 +0000
Received: from N9W6SW14.arri.de (192.168.54.17) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 6 Mar
 2026 17:23:35 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <frederic.danis@collabora.com>, <ceggers@arri.de>
Subject: [PATCH BlueZ 6/6] doc/qualification: l2cap-pts: fu: add descriptions for LE CFC tests
Date: Fri, 6 Mar 2026 17:19:21 +0100
Message-ID: <20260306162058.15154-8-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E2:EE_|GV1PR03MB10234:EE_
X-MS-Office365-Filtering-Correlation-Id: b89f71d4-7370-4649-3ca8-08de7b9cb7de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016;
X-Microsoft-Antispam-Message-Info:
	E+IBRxPdYf4E2NjNBSTyLaeHfXWJp+FE9LusU7hxxtkm7qaP1smn9hik2PKg0g70/fcSVYqNsBOjsaDzpVeLA7OV3e0nWOZowXdWsdfTbnCBRrhxXQOkmsu1mVg5pj7hGwgNzNbW4ab9k4a88NN/Brw1WSomroeDSSE3wu/ft34uTiWJWpxOhsXG8/QK8NS1978nFyz+Z6btGPz0zA4mnjR68jHZTdNScEsB0Fz0TWshZKDJFMVwgEIWOxoN3Gy3m+Gmu5hPlht4wI5xH9O2P67IwH6U6nO8Klq4ptK6xvKjqgS13ZGQehaBmG/zVLjVYrRSVrnX8DDlgh2VG+XllF5TPDajg75gxa6Xtx7w/BLaKfdwnE+jqRdRb2Iz93cZXY0mAcRXi8ehAMg/V3sGPiF3S3+X8OkU9sNy0SYd9FTc8CVavyPgoJZbdO8rSN2P6MQ+RwSpScKUQ0FX/oo4EGFxCwuHqgkIm7+JU1MpPwbdpmSe0dde6wcmwv+VBnnzXtJpZCVp5raM2DeI38sKuNspuHEqgJKBJFhmVMtzd3h15YaqhSPqx4IhfF0kpJgIWcxnDdqIMMrafRfUml1q7d1PvE9iHVtqq18PcKwvefRyeprHf0jWLAY1f7ICuJ41I623KYQu0+NrPxOIu+Zw2yC5oK1mg0SuLJQ7jXnd/aKy5pWfukM5p3nOPEDqpDWbmrQlTT6mqn7IERuEgnkfe5gaxksVNM8IxHdzPQ/CB3ibYTKMY7Rp4T1e7ROi2Y425YfbiQ94ZggMXNqdcSgFAg==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lUWWhLpHtW3r4rNDoRwAJFGpsqRmBP5ScjSr3oQOPkfPO5Al75Jd0fQTEgjtMwfklL1/Lliv0SFcASLQXvh9xpPr0UwjbdqyyL5Qwq3/i/qtMCj6lFM4ZupxcpOIPkbGuv5x61gB6e+dd9phAOyh//lGCcRt/rKkUDEJvXBomlszptOVvPmlNzBdCNlNksVjrmP+ORmBdK6qYjfpjKDjbT0uaE4+LUeWu60be10jEJ5rh7zI+VHVbxcswxWONvnKlVXZbVLJZW28MBxaBSVaFGyKMj2KcIdvjCleSTQciBc7/jfkUvTVU/qIz4jYagyMVd/YICcw7ABZ+GjX8/n/FYNxAPIrihVcsY9TF2uxXbt0FX50fbw6Ad/SHKZNZJRT9JZrh/wU7OL0349P7RAF2lvslPIIGUi28oq3lMXokXtXZk9M0dM6QCdNCO1TP3d4
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 16:23:36.2380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b89f71d4-7370-4649-3ca8-08de7b9cb7de
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10234

Unfortunately, v1 of my patch series has been applied to master. This is
an incremental update to v2 of d99f2e129634 ("doc/qualification:
l2cap-pts: add descriptions for LE CFC tests")
---
 doc/qualification/l2cap-pts.rst | 38 ++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/doc/qualification/l2cap-pts.rst b/doc/qualification/l2cap-pts.rst
index 043b8f20cd64..f0e7aa5eea40 100644
--- a/doc/qualification/l2cap-pts.rst
+++ b/doc/qualification/l2cap-pts.rst
@@ -96,20 +96,20 @@ for which we know the test passed.
 |                       |        |        |       | - Run:                                               |
 |                       |        |        |       |                                                      |
 |                       |        |        |       |   - btmon                                            |
+|                       |        |        |       +------------------------------------------------------+
+|                       |        |        |       | Look for "frame too long"                            |
 |                       |        |        |       |                                                      |
-|                       |        |        |       | - Look for "frame too long"                          |
-|                       |        |        |       |                                                      |
-|                       |        |        |       | - Answer PTS question with "yes"                     |
+|                       |        |        |       | Answer PTS question with "yes"                       |
 +-----------------------+--------+--------+-------+------------------------------------------------------+
 | L2CAP/COS/CED/BI-09-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
 |                       |        |        |       |                                                      |
 |                       |        |        |       | - Run:                                               |
 |                       |        |        |       |                                                      |
 |                       |        |        |       |   - btmon                                            |
+|                       |        |        |       +------------------------------------------------------+
+|                       |        |        |       | Look for "invalid signal packet size"                |
 |                       |        |        |       |                                                      |
-|                       |        |        |       | - Look for "invalid signal packet size"              |
-|                       |        |        |       |                                                      |
-|                       |        |        |       | - Answer PTS question with "yes"                     |
+|                       |        |        |       | Answer PTS question with "yes"                       |
 +-----------------------+--------+--------+-------+------------------------------------------------------+
 | L2CAP/COS/CED/BI-11-C | PASS   |    6.1 | 5.69  |                                                      |
 +-----------------------+--------+--------+-------+------------------------------------------------------+
@@ -118,30 +118,30 @@ for which we know the test passed.
 |                       |        |        |       | - Run:                                               |
 |                       |        |        |       |                                                      |
 |                       |        |        |       |   - btmon                                            |
+|                       |        |        |       +------------------------------------------------------+
+|                       |        |        |       | Look for "invalid signal packet size"                |
 |                       |        |        |       |                                                      |
-|                       |        |        |       | - Look for "invalid signal packet size"              |
-|                       |        |        |       |                                                      |
-|                       |        |        |       | - Answer PTS question with "yes"                     |
+|                       |        |        |       | Answer PTS question with "yes"                       |
 +-----------------------+--------+--------+-------+------------------------------------------------------+
 | L2CAP/COS/CED/BI-16-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
 |                       |        |        |       |                                                      |
 |                       |        |        |       | - Run:                                               |
 |                       |        |        |       |                                                      |
 |                       |        |        |       |   - btmon                                            |
+|                       |        |        |       +------------------------------------------------------+
+|                       |        |        |       | Look for "invalid signal packet size"                |
 |                       |        |        |       |                                                      |
-|                       |        |        |       | - Look for "invalid signal packet size"              |
-|                       |        |        |       |                                                      |
-|                       |        |        |       | - Answer PTS question with "yes"                     |
+|                       |        |        |       | Answer PTS question with "yes"                       |
 +-----------------------+--------+--------+-------+------------------------------------------------------+
 | L2CAP/COS/CED/BI-17-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
 |                       |        |        |       |                                                      |
 |                       |        |        |       | - Run:                                               |
 |                       |        |        |       |                                                      |
 |                       |        |        |       |   - btmon                                            |
+|                       |        |        |       +------------------------------------------------------+
+|                       |        |        |       | Look for "invalid signal packet size"                |
 |                       |        |        |       |                                                      |
-|                       |        |        |       | - Look for "invalid signal packet size"              |
-|                       |        |        |       |                                                      |
-|                       |        |        |       | - Answer PTS question with "yes"                     |
+|                       |        |        |       | Answer PTS question with "yes"                       |
 +-----------------------+--------+--------+-------+------------------------------------------------------+
 | L2CAP/COS/CED/BI-29-C | PASS   | future | 5.69  | On request run:                                      |
 |                       |        |        |       |                                                      |
@@ -510,8 +510,8 @@ for which we know the test passed.
 |                       |        |        |       |                                                      |
 |                       |        |        |       |   - l2test -w -P 0x0027 -V le_public                 |
 |                       |        |        |       |                         -e $((0x78563412)) -b 10     |
-|                       |        |        |       |                                                      |
-|                       |        |        |       | - Result: 123456780A007F7F7F7F                       |
+|                       |        |        |       +------------------------------------------------------+
+|                       |        |        |       | Result: 123456780A007F7F7F7F                         |
 +-----------------------+--------+--------+-------+------------------------------------------------------+
 | L2CAP/LE/CFC/BV-05-C  | PASS   |    6.1 | 5.69  |                                                      |
 +-----------------------+--------+--------+-------+------------------------------------------------------+
@@ -533,8 +533,8 @@ for which we know the test passed.
 |                       |        |        |       | - Run:                                               |
 |                       |        |        |       |                                                      |
 |                       |        |        |       |   - l2test -r -V le_public -P 0x0027                 |
-|                       |        |        |       |                                                      |
-|                       |        |        |       | - On request terminate l2test                        |
+|                       |        |        |       +------------------------------------------------------|
+|                       |        |        |       | On request terminate l2test                          |
 +-----------------------+--------+--------+-------+------------------------------------------------------+
 | L2CAP/LE/CFC/BV-09-C  | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
 |                       |        |        |       |                                                      |
-- 
2.51.0

