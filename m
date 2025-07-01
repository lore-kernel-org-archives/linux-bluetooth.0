Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011061.outbound.protection.outlook.com [52.101.65.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE11E275111
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751381265; cv=fail; b=b9y3/Ks14Z7e9xZZgK7A0kaNsStHwu6G6n+vqkeHU8ICt1wzix9ZB149tcTNGVYg/Z+3zXEzL8eDDec1PbF+PUo3GiGb15ijUXCIxm6UhGB9mBxegrOnxvG7nEwE9m3gRrk9pv9ioaJaEwG35TUoIW4H9SH/uX5Mh5sQ0aZfQ3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751381265; c=relaxed/simple;
	bh=Gi1cUytfPRmek5X0tmKp7gPloW3XO0yPDYBxUiCWxpc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=quJpsmsDKmoYPnvVKsnSDSieV3q4F+R1ToEyN8oAKXLVl5l6gIu/jpTAXT3Xxq8MBncaGpKKzjWSsNW8KMo7az0HD4OIETTvBLY4PWN3ojF+dPBuye7/UofMefkN9ShRM2MyChJjTsQTrV2bK0AV9BWDjeMR/KkXnW+gWZnBtpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=YFM6VW6r; arc=fail smtp.client-ip=52.101.65.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="YFM6VW6r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/lF/ZVqzTFJodxgUfzQ6yegSD4UY6eM51uo0SrUeZt9XM4F6no6VCHvFiPbh7wfxbIO3boR+1O9Y3SvCB+3PsHT7C1YzTrbHuvedjWS6NqQTDj/vXZvd+CccKUJeRVIF3q3K8jY0DJTzQdZ2qvPJiDmbPKUqXR7/b9V9V/258O4fOHZ8cs5Hhg5H6AdpwTSBmVIMykC1XN8yFTnXUmM1cbK6c2nqliJQ4DI2ZYe0G4t3ZrpaHYCuG0LvygFABlbqV7dUi1oqhkKrq9DoFIQwkMT8ATwOm+jnaxAOEmjtol0itr3u6E7+2qfIq6GvZsKzslqLr7yYqXwQ+VBdAI2Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdqN2fefsmXGtz6Om4HGKWjyvUOg9D+NnI1pxZdwRTs=;
 b=nah9gDKuTVLB7gQ8/dXJKNwTeJAM7rjtjUTgy8CVegazEAUwArRv4RE8t1l0XLT2lU2jnsG92EpH0s7Ddjk8SO4gNd4TrIYM5A0rVVsiBOukAtTkjp98GO314BmjFivMYQJ4iAvUnnlD+i3W7stD8/O4WZoH72HdFOoyqbdUGiQU1dYb7itwm/kZ3EbKUqm3QD+YjpmwHiGClf9iUS+/rsYq3O6myGWGv7LqMY5XEUa7rO+q2BwGUK1UJLyNiXOVsKqh3dHGizy/TrQjnmAlUIsZIdaBIbofS3JlYSXE0gJX940LZFYuNtDgIA8aDobRU+paLyWDhe1eZnfKWbGxOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdqN2fefsmXGtz6Om4HGKWjyvUOg9D+NnI1pxZdwRTs=;
 b=YFM6VW6rV2Gz+RqlFCCr8lL4axf78tM1nfOd69gd5FPxcUq8dTtfkzqa3PWTWYDSiFylD7/qf6L5LCozaM6oo4Hyer99uPvdbdlpoxRWXw6AM5B2M3rjaAQkfaqR2+LzKylQFtTlgZTlyPSIOaA67Vml9WjDiF8aYMvdSrtcjdU=
Received: from PA7P264CA0517.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3db::27)
 by AM9PR03MB7646.eurprd03.prod.outlook.com (2603:10a6:20b:413::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Tue, 1 Jul
 2025 14:47:38 +0000
Received: from AM4PEPF00025F97.EURPRD83.prod.outlook.com
 (2603:10a6:102:3db:cafe::e1) by PA7P264CA0517.outlook.office365.com
 (2603:10a6:102:3db::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Tue,
 1 Jul 2025 14:47:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM4PEPF00025F97.mail.protection.outlook.com (10.167.16.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.1 via Frontend Transport; Tue, 1 Jul 2025 14:47:37 +0000
Received: from N9W6SW14.arri.de (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Tue, 1 Jul
 2025 16:47:37 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Brian Gix <brian.gix@gmail.com>, Inga Stotland <inga.stotland@gmail.com>,
	Christian Eggers <ceggers@arri.de>
Subject: [RFC PATCH BlueZ 1/4] mesh: acceptor: increase interval for unprovisioned device beacon
Date: Tue, 1 Jul 2025 16:22:21 +0200
Message-ID: <20250701144647.19572-4-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701144647.19572-2-ceggers@arri.de>
References: <20250701144647.19572-2-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F97:EE_|AM9PR03MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: 105bc071-a0fa-444c-4c66-08ddb8ae3910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/gEfY+NvvwX0BwLSEWdjYA5a8WZuCXJpQeaDqgHjVMdRzpQQAZCWNo0FH6gI?=
 =?us-ascii?Q?XzvBS/Dr6kwDK8zvbxKMPK9mCWId2hAN7ULxFb0MQ3SawBcCdReCA6pnPw5z?=
 =?us-ascii?Q?3g4TXTUNUEQkTG4YhaclF0b2R6a+ZxAmDHtn6nvves5etFaL3Z7Tmb0mnSGc?=
 =?us-ascii?Q?wDdDTVxQJTJDHW7ZUI23ifpTBew1PhwY8HStoCwHgu1/sHDnZ7wpWUNaPFG4?=
 =?us-ascii?Q?nLx77OqQrIDsldqgjT6qfHY2aX++CE1WxiwrzUs0HTbtEoGs+BBwXsJl3iYA?=
 =?us-ascii?Q?glJKHGh+BMK8Di+Vy9KIUqO0zkDJ8jJmMO/60ezsKi8XG5poJzd65wtw5xl6?=
 =?us-ascii?Q?RmTSkgmahIi348/qez7CKD37c7jWJItpLccMM3LR+dhEbO+pDHXYsyhc+BNf?=
 =?us-ascii?Q?XsyV/aOJ8h4Ho1qDyLP/MpjyuXKcE0xbnb1UzKyFY1AXPBy6EIWRoms/aYzO?=
 =?us-ascii?Q?nvjS/HjRuqLvoxYrJq58+KSwDAJgr+IUHcsMH1D1eEE8q0nIzVGm4mrkIE8a?=
 =?us-ascii?Q?ibN3Tse5XxkNvj8T6xJ7XWJ7Z4l6DkVukWVLFlWP2jnTkFigyGK293vjbYT1?=
 =?us-ascii?Q?V9cXepaKxDQIRQtnUwH1xOUa02yDIlPvK800YHM8MP0+S52Li+UIn/yV1Qh4?=
 =?us-ascii?Q?LzoBBgTJoKFObASFpU5q4QmFpYf02J9lb4VMOuTKuZdLXVdQsI9nWMBb/1Xx?=
 =?us-ascii?Q?UlqixKKwZ1UTqlgRbd6n5CjCHTt2mLvt7DRi9lLBi//tpbsypignBhpZbZqK?=
 =?us-ascii?Q?Cpgor4n7zsDEk4M5/QEZ/qvAHuSZ+1wh2YWiOXjvc9Yg/3FUYthHXnfnK2cQ?=
 =?us-ascii?Q?oFBGdwSBitd8boBkV5MrffcPYmsOtlenZ44Y0CYQCkr14kShLxWQ0giwfWMN?=
 =?us-ascii?Q?rZj04MfhCjZ0kIRVJNvYRWDYF2BKoxMBZn88taKE8QWiYiqu/hUo2Oy0IEqq?=
 =?us-ascii?Q?usak6Ew7olKZp/j3gc+WPMH2qvklA8stu26OuNlMEtq1QUg1SYopsGqCKLlo?=
 =?us-ascii?Q?tPglTfy+waBNs5ZXlTiVlVFkdk+AaoJQjqMkVmXoO4BlKHLo+SmEUuJIbde0?=
 =?us-ascii?Q?f6P/4QPA6aNhjOcH+369DlkSolf5VgId+ibVDQ4c2GNWZrcYK9eWcsOpSFnz?=
 =?us-ascii?Q?l2EgAcfA+4DD+m9AcKhmZEafDrF8GQJaE6ZVL2zGmTOsSOFp6umy7VbKJqPc?=
 =?us-ascii?Q?n6J+d3oPz9PzhSwv2iJd027aHrC7P+KBaOoBK0F0MdDweqNfVGBdaS++BGpd?=
 =?us-ascii?Q?JxJNMI3RfB3g/b7mHdW7P989MWsVsiDKK5rLKau8gpLUj0B7EqFzRUIeYtx9?=
 =?us-ascii?Q?fuvQQ7e6GSCIb8P3poiHk76vQbW5aOhKCpUAUC9V0ce2kd/W0NGc+GUSSADZ?=
 =?us-ascii?Q?ihlCEOH0N0REajAVtg3MdIDnBVIxRcjYerLC+x4ifxjxGULdopJIhNdg23vC?=
 =?us-ascii?Q?m2gan44DOMy5qJevV+HvnJW0jKg5cmET3t8tAsHc4gF/LEOIbjpWzS+2/OMI?=
 =?us-ascii?Q?ZRJEtUVrrV63HWRaGDGdGlGOdrrlVTIjMT/f?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 14:47:37.7288
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 105bc071-a0fa-444c-4c66-08ddb8ae3910
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F97.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7646

I cannot find a specific interval for sending unprovisioned device
beacons in MshPRT_v1.1, section 3.10.2/5.2.1. The current interval of
500 ms seems to cause interferience with normal advertising messages,
maybe this is controller dependent (seen on RTL8761BU).

A beacon interval of 1000 ms should be sufficient for scanning (e.g. by
a provisioner) while allowing normal advertising messages to be
transmitted.
---
 mesh/prov-acceptor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/prov-acceptor.c b/mesh/prov-acceptor.c
index 27d4964316b3..78304515ed16 100644
--- a/mesh/prov-acceptor.c
+++ b/mesh/prov-acceptor.c
@@ -793,7 +793,7 @@ bool acceptor_start(uint8_t num_ele, uint8_t *uuid,
 		memcpy(beacon + 2, uuid, 16);
 
 		/* Infinitely Beacon until Canceled, or Provisioning Starts */
-		result = mesh_send_pkt(0, 500, beacon, len);
+		result = mesh_send_pkt(0, 1000, beacon, len);
 
 		if (!result)
 			goto error_fail;
-- 
2.43.0

