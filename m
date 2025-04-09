Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2068.outbound.protection.outlook.com [40.107.22.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2346818B46E;
	Wed,  9 Apr 2025 08:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744187969; cv=fail; b=bAzoE1yf+1XpZzq+7kOcITMORqbWIE0ARhj8exOQP5ovCpBw+nTwCh4nBfnvw8axSeWBm/Kvdj/9v/u05RDtoS+j6o5GHqOWfiF8YXKllKKRVW1gPH0V/cAqrNPrMMVaHP3a2dcdJZoM99MHGJN5WtyjCIGXwf5bzE1ClSqwQbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744187969; c=relaxed/simple;
	bh=+By2aTaQMKS6Kk31FLsOlbhd3tKnt6gPALmBVZmHCxg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iKk4joflXTK5FjCELc6uJe5kmcQSythDKeRY8vVo/nu0OmptJ0k3qLP6SujNWSqDXz2+GYEI3ZOGvvR21+gTsMsrTiPNZPxvAiU1I86ETwsIu1gwQfoI/zU4sfJ9qW8E7067lZiFNW95g8oC4YcrjqvCkqV6tXGGRJNIgbeRebM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=c1Ko8ZxJ; arc=fail smtp.client-ip=40.107.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="c1Ko8ZxJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNf/91Qvltpaohm3ZUhF/5OxTZyGwq7NteOfbmRzc5Lo2R8G2xd19h7YuKusz8HgFn3R47U+cZPO7qzJ4StRI/myfqzK1980wF6lDnNvOrdMrp0ajVBu9NjS2hR5xRxkCzJwfdZNFBMmcHYVgNFpLx+q5glvZ4tPDVrsz2uxXsZTlg7kfp/j1z5vFMjC8imsZgGxJGz7c1qo7z6Rjhwxpe7RswZwsH+FHjvr9ijIzWNZMdqTMKsKuqZRzNruN9GSwYNQYldgZmRYbxEnV7uIO5uT8fSnstFw8h0N48D26BQVwyRxy6wFiztnd1l1pqySlhmilGnlAaqGCOTC1Ff5iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWqhGVPBdtL0SBhdwfGhU+Gaq9b6jfY3hGBQmid0Tl0=;
 b=nX+7HPBn4mdqtjYG4snb1ftmh2DeUgeVK26TBr1ndU0/MdofqzF4ngqOjdqa2NNUWvRSZQDGNdHb9hMZR8/dMsJZaledd7Sb3RydFDLqa1OAiaLdqlIxYIg1Rj53WmdEhTHj+D5hA48fe/TtQMkeiQH2phIMpFFjjvpgZePRLrjDpsGXmfBQbK5p8uCa6GGnBk3UdMUA0SXJLgIUQ5mJXNqreGKsuhUJbEVJWzZqKbuHyob2wZzKlBxCk6aSUrWAL+lO7Kd8zw+Qz8j9LW1JmPWWf6l6cri1hOQSHpKmESyik/6DsRUt8Bp2bSurLyXVXTS+a4H/NT49oNDJbKk5HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWqhGVPBdtL0SBhdwfGhU+Gaq9b6jfY3hGBQmid0Tl0=;
 b=c1Ko8ZxJEH9Ba8rEhcjKXfzzQKFkk2plGhturl5zhiEmsZtOmQwJvUPFrnbuDZOYq8a2WXPAzU0kPlDN6axe8H1YXcMPW0GyGyWxnGn07lcwBBB4uAQVOWcQaWJhPadQApWCu4m7Z1HPFsJD5lPyh8tj6pgy7EvV+4kRwtO9V+w=
Received: from AS9PR04CA0130.eurprd04.prod.outlook.com (2603:10a6:20b:531::29)
 by PR3PR06MB6635.eurprd06.prod.outlook.com (2603:10a6:102:61::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Wed, 9 Apr
 2025 08:39:24 +0000
Received: from AMS1EPF00000045.eurprd04.prod.outlook.com
 (2603:10a6:20b:531:cafe::c4) by AS9PR04CA0130.outlook.office365.com
 (2603:10a6:20b:531::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.36 via Frontend Transport; Wed,
 9 Apr 2025 08:39:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 AMS1EPF00000045.mail.protection.outlook.com (10.167.16.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Wed, 9 Apr 2025 08:39:24 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Wed, 9 Apr 2025 10:39:24 +0200
From: Catalin Popescu <catalin.popescu@leica-geosystems.com>
To: amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de
Cc: linux-bluetooth@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loic.poulain@linaro.org,
	m.felsch@pengutronix.de,
	Catalin Popescu <catalin.popescu@leica-geosystems.com>
Subject: [PATCH next v3 2/2] Bluetooth: btnxpuart: implement powerup sequence
Date: Wed,  9 Apr 2025 10:39:21 +0200
Message-Id: <20250409083921.3701280-2-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250409083921.3701280-1-catalin.popescu@leica-geosystems.com>
References: <20250409083921.3701280-1-catalin.popescu@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 09 Apr 2025 08:39:24.0228 (UTC) FILETIME=[E5899040:01DBA92A]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000045:EE_|PR3PR06MB6635:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 308424b1-2443-4f28-4112-08dd77420843
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8yk+akVqvU9zz4vb8ulz4Bsx17eVoXvSLG9p+ReIL0l5H68AU8GzvbxkLUvO?=
 =?us-ascii?Q?7x6GLV3lOpYS7q8DpvuSsQrAfLj28lm+nuWuJSeKADJR9TPsFskL4o9BCyy0?=
 =?us-ascii?Q?rvVeKmrUqCH3k+OLhubFHmdrBA7yFZL/8GAf4NYOqkK21aXWL/VQIpxWjLNQ?=
 =?us-ascii?Q?MsygZgXb9R1y/jSqa4Dta5Mq/kWTcrnnx/ODNRbIy3LslsNA7/qaFLrtu2R3?=
 =?us-ascii?Q?e67YUen7Jph1rp76jnSd41X4VlFFzssaobhBFNoW0em8EruP4nToLEUVACe3?=
 =?us-ascii?Q?xkg31Z2qVia9q9G4UlmdbMQfA18KdH7GnFFb2KA1mElyE8UDXlfv+oXRRaLD?=
 =?us-ascii?Q?z3Um9AEFlNE+/0AYrGqb9Tf70Vyxuz9gAQHf2UfQBLyEJLpoh7NCY67r44rI?=
 =?us-ascii?Q?tw0BueTv2On66MuL9T4m2EDk9FJmAq+7Y7HH3qzNTgAD5SooiFzvYw4vK7BS?=
 =?us-ascii?Q?6ZGz85/5hWRLOgrH0XGle51NJRtHTpVa9MKhE796FssDQjdkDSgBC9oWlYfh?=
 =?us-ascii?Q?QfDTq6E21EcxcBUpIpWpsBCKQNYkDURU90ayVNPAMN27aUzeOPj+dFOGMS9J?=
 =?us-ascii?Q?B/YI6sa/n58qn47Q2UZ7PTmWEK7K10KCkLe2qG2EYZZG6cQUveG9Qbbjj370?=
 =?us-ascii?Q?D5T0vuWwzRG0NmdqJyeH/V6vIz9PYqkQ62uBEmjMKW4pQ7J3fTNbQmIyKBgd?=
 =?us-ascii?Q?N5rz1nkb321NF994o27qPwWaOiqiBNr8/9mEOsA8WDilGNLNwhyj5rh+mYFU?=
 =?us-ascii?Q?LQJpvO0cBK78j/yxgeLh1f+/N/LMrzvChawNICg3XvgmAbpP9gNx8RIMfkPm?=
 =?us-ascii?Q?eZI8KbIhwtUYNaD8KrhvdGj5NcpxYjSC3f85p7Hdkzm9vIvEBPaCFFUvXZEX?=
 =?us-ascii?Q?FlyQj/cV1UxMGJKuDOKqksd0tkHPrUfz72HH5XcuOvT0xPC1QEHFvvPmDH3y?=
 =?us-ascii?Q?IEjhOXNFZyUCsDE1UIoNFGXut0CtwaOkTjiRZ1zpuHyEPxuGBBfHnWe3gk+d?=
 =?us-ascii?Q?BSewZj7SkuRNL896j2ZKMxS44d8OwhYpfeUh+Oq1H9p0hGet8ITuxMjfvdqT?=
 =?us-ascii?Q?PEAr6QOXirxa+jW8PfVnus0/C1gM6oYWQT21UGbBto96fjfd3WhNqnBPlZPX?=
 =?us-ascii?Q?9gr6kK0qP1K7mfdXE7EfeXB2f1pkBLmGvAJ2C/PEUsVC419+K6bE+v5Qgvxt?=
 =?us-ascii?Q?mExa1jpIfVQzkFGIuoOu3dgqMsqQG0mlQ2//8bJsvPfHOth70MB7RqO3uuHv?=
 =?us-ascii?Q?u99wKler8sXugOJ0AiTyxKhyGmqp2+sSOEYYfS93J1jOo48PgO7dBHZwKiSs?=
 =?us-ascii?Q?fyKPXQbP3iC/lMKtEZnu18xvZv6Uo1B33ad0VkRkM5HdaV+tg8NXbRRdFzfC?=
 =?us-ascii?Q?lO4LHqWWf99jYuqv1HNdDU44j3XXNu2cInWp97y8NZ3SXnBeOrXfamQQVDVM?=
 =?us-ascii?Q?3dwb6/1yHp/8c6/iEqGM+U+pqtou/d7SxL9148+QT6veUS22qMZrN3XVcafk?=
 =?us-ascii?Q?SoF2mPvmOxjOEpU=3D?=
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 08:39:24.5713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 308424b1-2443-4f28-4112-08dd77420843
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000045.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR06MB6635

NXP bluetooth chip shares power supply and reset gpio with a WLAN
chip. Add support for power supply and reset and enforce powerup
sequence:
- apply power supply
- deassert reset/powerdown

Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
Reviewed-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v3:
- rebase on linux-next tag next-20250409
- fix issue reported by CI regarding the subject
v2:
- rebase on linux-next tag next-20250227
- add reviewed-by
---
 drivers/bluetooth/btnxpuart.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 604ab2bba231..e1f7d1956020 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -17,6 +17,8 @@
 #include <linux/crc32.h>
 #include <linux/string_helpers.h>
 #include <linux/gpio/consumer.h>
+#include <linux/regulator/consumer.h>
+#include <linux/reset.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -204,6 +206,7 @@ struct btnxpuart_dev {
 
 	struct ps_data psdata;
 	struct btnxpuart_data *nxp_data;
+	struct reset_control *pdn;
 };
 
 #define NXP_V1_FW_REQ_PKT	0xa5
@@ -1712,6 +1715,7 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 	struct hci_dev *hdev;
 	struct btnxpuart_dev *nxpdev;
 	bdaddr_t ba = {0};
+	int err;
 
 	nxpdev = devm_kzalloc(&serdev->dev, sizeof(*nxpdev), GFP_KERNEL);
 	if (!nxpdev)
@@ -1739,6 +1743,16 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 
 	crc8_populate_msb(crc8_table, POLYNOMIAL8);
 
+	nxpdev->pdn = devm_reset_control_get_optional_shared(&serdev->dev, NULL);
+	if (IS_ERR(nxpdev->pdn))
+		return PTR_ERR(nxpdev->pdn);
+
+	err = devm_regulator_get_enable(&serdev->dev, "vcc");
+	if (err) {
+		dev_err(&serdev->dev, "Failed to enable vcc regulator\n");
+		return err;
+	}
+
 	/* Initialize and register HCI device */
 	hdev = hci_alloc_dev();
 	if (!hdev) {
@@ -1746,6 +1760,8 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 		return -ENOMEM;
 	}
 
+	reset_control_deassert(nxpdev->pdn);
+
 	nxpdev->hdev = hdev;
 
 	hdev->bus = HCI_UART;
@@ -1784,6 +1800,7 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 	return 0;
 
 probe_fail:
+	reset_control_assert(nxpdev->pdn);
 	hci_free_dev(hdev);
 	return -ENODEV;
 }
@@ -1811,6 +1828,7 @@ static void nxp_serdev_remove(struct serdev_device *serdev)
 
 	ps_cleanup(nxpdev);
 	hci_unregister_dev(hdev);
+	reset_control_assert(nxpdev->pdn);
 	hci_free_dev(hdev);
 }
 
-- 
2.43.0

