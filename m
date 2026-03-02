Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010012.outbound.protection.outlook.com [52.101.69.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FB93E0C53
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772459446; cv=fail; b=CBPUoYyeeAwldN0dUJABjjklA6yFMgsflGgzeF1W53Rj6KGS172IU/kGMfGppuH49EsQNAxpI646Q6gc1dYW9z2nw8/3afVtROpypX1cFXanknGice+z7K+NUuecTw+7u3IlqiD1fYhU6m/p+ZvKEMRwHwVlxWCjZD7Jt87dAP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772459446; c=relaxed/simple;
	bh=JwcpItgM3cqvEqsxXN8z5RsW5/nwzRa3GpSkgk7k3oY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HVci8vX2qok/PRNtBz8grSUUE0RgmG2WsV/vQhF8EsBeY8dlOOi7nBVswXy/usJGdGHPAGUowM2JzoVxhmXJ0hyvhtrfACbqWqTYVGJYYhSAkX8rmo4jMkIEekfyXIzkXxothufTWD9uoqqyD2oDeiOkWuaVxXhW0iqQi3eTdOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=Xg2rmM7Y; arc=fail smtp.client-ip=52.101.69.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="Xg2rmM7Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9llmrV2ASp08RPc45YawM9Co+sm0tQS41x8hFnEySjBlTGXYSdf/OEzy6zHzFglMGfgtigrHJ9Fu02apLPGwDBHOYjdyNwXi3TFx9ZDlCWrbuwDhNG7KTpSQxtwcTN/lSfeoApkMPapRbcvAXyu8mQbrWkNo7g8CDRATR/ptwOIw8CGVo64Z+shIrD5Ckiie5YufZFMM8Hary/uzHzDnCtZB2OvBZwm+prvznU23hgK5xz4wwhZNMKPUiXsPPSYrACGqiOW2ozYSbubhrNo2ip16j6wLnrj2Crm1ITuOG9UWJqSTdnrjLxlKX1kGkef1KPT/LqpDvJvLAZ0v1Dy5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLwoHtaxt2UOhM2ZljwKWDAAr4+h8usdCvvskB7GB7k=;
 b=dVlusMdp2mpb1N0FFcyTk5KDTlrHDYLPzjDizSFmMXDZ0Smx0Fcz4ItX0ynPNfJtAYqPBZEjxdqlmueVxIlmfRDqzHDmd6Wy1smB/P90iOlHtx0LkXGxQRvNuYDgeXUWfno0APOOQAFny69nhu8S9FIZGUN+UPFn4NSBlivqNkA5lFpNJ6cKP/b8k4QNrZJHeq2B8o/6xn6kU1Rb2WB4S4F3mWpHbh7IzbxLBii4ipCwTvnl9bjTwiDBUvlHonSp1FrwVD7A7F31iMoExgLriiPfo0NEad32EiIlrn20c4k7Zk58f6p3rIBNhK4aAqsgpEAmpJvMFXfQoz2v2HFd5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLwoHtaxt2UOhM2ZljwKWDAAr4+h8usdCvvskB7GB7k=;
 b=Xg2rmM7YyzDxl2AfdmyySWtcz40tvsdvuzvi9VVtal3jWNatYBOw+x/b3QoaP0vRiq/AHyYLD7r+y7/JqdVd5wL/jFVcaWZOF7GrqBkXxynt7E0Qoq43RgRrUNGqOi72tO6eOiXpSc6rnN3rZCHosjA4gMj4ZmMJNht1LVFdYCI=
Received: from DUZPR01CA0219.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::16) by GVXPR03MB11477.eurprd03.prod.outlook.com
 (2603:10a6:150:319::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 13:50:39 +0000
Received: from DB1PEPF00039232.eurprd03.prod.outlook.com
 (2603:10a6:10:4b4:cafe::83) by DUZPR01CA0219.outlook.office365.com
 (2603:10a6:10:4b4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Mon,
 2 Mar 2026 13:50:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF00039232.mail.protection.outlook.com (10.167.8.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 2 Mar 2026 13:50:39 +0000
Received: from N9W6SW14.arri.de (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 2 Mar
 2026 14:50:38 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <frederic.danis@collabora.com>, <ceggers@arri.de>
Subject: [PATCH BlueZ v2 12/15] doc/qualification: gatt-pts: update description for GATT/SR/GAI/BV-01-C
Date: Mon, 2 Mar 2026 14:30:40 +0100
Message-ID: <20260302134540.25540-13-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF00039232:EE_|GVXPR03MB11477:EE_
X-MS-Office365-Filtering-Correlation-Id: 348695ca-ab23-4354-f7f3-08de7862b04a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	gg1n47hScWGuTZXWbTb50vEz5NusmywWegvf1igvh0MtWk0jfmcRg3br5J4M2cDj3mWUpEU2L6/D54XqQ3v5cNWGFowvtcsB5f5uJIopP4GxDlrAxmShXlVQxfdJizeLxzrvIg7TNXQUXOJYsw5IkheugedFX1M1W93jasuS7oEEdPwn19uOEbfb3MLtra5YJTokmGTr9w8Lf3JmlB5dfcPPQwgmBFVTzs+EmmCh6Xuc73mFyybmRt82tn2w51wKP7OxEalaFMi/f/pdrzAClIZTRKMNYMI8ZnkIfnRGfbhJFgd3Cq4zwrQ7+FE7PpdqeCLrvlLlfwPaQizWsy6PjNLQI38sg7tXwQC8jLaYetordfU1ygZdUGw6Aw3EfWW6cYchus1CYnV5kOiyZcFWe2sEYfYrpaZ5z1hgDZ0Hy1LvHbhiA0zajxLgl5aJsMCHcsG2xaF/rfYRFXQveMy3cQf9yiFrvNe5jPHNe03T820kSFU1oupEM3hzrKAUIy5kNYx2tAElU8ZpReRxD+RNLO6NLp2Ydj+j8SFktfcNkvI+img4SvfbcslQHzpJg/mJZomrTaVEW9MnhsSCz7rjrCC2b+rEKXg5k7cY0LJmb/RbWXRAxzMyI4GAiF+ciAzgDTMj2RAZwRio+JRvJZPXHBbgUS9KIwY+W4IIYRY3ohv76T8qDg/NkopucAy7EZe30ofzHgY4MAeFyIz6x7J+Jxizz1cxvNq8Yu/iVhTM6WRF/ifyX0mtoDqpOOIPc/gleQUSa5lXShEASwZ4h6N7E9G0pMbEY8s4daTkzAs+WOQAQTMLoXOctxAxIqpQHhepKlEVytGquQ+UjGeRSDitww==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4mzPNqvgPdpjNb6ZP/utUKE2uwT0YeB3CyRL6j3mApXTc64klPr/c0hx83oRxeHOH25cQFJJsGXMtjbZXRsJXrVmtb+M6pu1jKx4yc3zFr1ZnjJ0OEXsc7DYm5SpdUz0wHQqzjEgxnBFIpFlKan9TQ/s6q+Yg+2Y+DJjQdgnYNAXkpzf7BM/+VTl4iB/1cCI5NNhtsc39K+1kE4DGmMgUacKiVZGteq14D/qYt5E7AitBTWC9Em/MepkU+5q8tCH4weFn+TFStHnbjXd1Dr4+qpid4n1Y8UyLigYjLT+ulPoq6yKcejuSr2DG7xSsrXiTay9NnDMlMHGjALaiCkSly/qSqQz7C6NeSxom2QnVG6bGq7cghAtAZUgWkCsVIudT1Y9nZGhEDrrsUSLYa5JzBK8X/2khVLdoaOqfYBKrOwEvRWkZqM5nv4z/5ykxiOQ
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 13:50:39.2292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 348695ca-ab23-4354-f7f3-08de7862b04a
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039232.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR03MB11477

This tests requires an indication on the "Service Changed"
characteristic of the builtin "GATT" service. This indication can be
raised by adding (or removing) a custom service. Of course we have to do
this at the point when PTS is expecting to revice the notification.

https://lore.kernel.org/linux-bluetooth/CABBYNZ+O6KbjXoxTKSaPnSd=p2CDJ7j6cBktPT4xXD=PR0CBhA@mail.gmail.com/
---
 doc/qualification/gatt-pts.rst | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/doc/qualification/gatt-pts.rst b/doc/qualification/gatt-pts.rst
index 9c621ba8f584..d836e5fb2981 100644
--- a/doc/qualification/gatt-pts.rst
+++ b/doc/qualification/gatt-pts.rst
@@ -1162,15 +1162,19 @@ for which we know the test passed.
 |                        |          |         |       |                                                                         |
 |                        |          |         |       | - [bluetooth]# gatt.write 2                                             |
 +------------------------+----------+---------+-------+-------------------------------------------------------------------------+
-| GATT/SR/GAI/BV-01-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
+| GATT/SR/GAI/BV-01-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
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
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - enter '1' when prompted                                           |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | On PTS request to send a notification:                                  |
 |                        |          |         |       |                                                                         |
 |                        |          |         |       | - [bluetooth]# gatt.register-application                                |
 +------------------------+----------+---------+-------+-------------------------------------------------------------------------+
-- 
2.51.0

