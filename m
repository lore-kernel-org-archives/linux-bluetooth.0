Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012040.outbound.protection.outlook.com [52.101.66.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766C5218AB3
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 07:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751011110; cv=fail; b=h4fydyJ+4QE2fCZsMKmq0mJ9azuhWLi1yD/xBmusjYH8D2BqQTeMX9jxc1L1yTdcYzILzBVMG5qyRnaLpqZBzJMqBu8suCCbfhJ3bR6gbxnwA7ARozrZP5W3SSUJgViEyJBcwrgvvBWYy1yvWSCkJrcdKVU9gdK7gSWefNqnngE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751011110; c=relaxed/simple;
	bh=MDki9oxDyrXE/MgWCqX3GuaVvjMWx9lfwii9eHxiUbY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qFGijx8rGGG2+z+hg34B9KR3o2LnM3ytw9ZqYQde+PbzdZKJGH45+K77w7z9d6FKmKbBst529vTLZmkFPebDFKqRVV52QMR1XlAOn9detRYT26dItq3tQbv/LkRQUCtLsu5IRbXyJQZpsHZM4sj4RJFPOXzMHgz/hHPH6Qt/bZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=ghOgHEGm; arc=fail smtp.client-ip=52.101.66.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="ghOgHEGm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uOG7o6Sj/VcnJmkRw0MWKrAYTljkEXvyW1EBsIxhH9sOKf4nixWbOOZ5MwGBXrQBxfDpyV/WPVhm5KN0XBUR78zAqj9QfK590qYbDrI1oyx5mEG5WYMAVc/CJg2E5q2ReFtWgKVJboYKaKOBkpJKLQ581+2OWBnr8sqnrzG5Fbu/vryxYjNj8KSSYxfrR2dVxDMQjse6V3aPntRvXr0bBEqua7SI5UNAggHpi8nGO514A+PX7KK/7iyzWiJPuVmQOU58HCKeUXPkJ+S5Ws6wDfIL+r7FoWeMKgncQq23RwIVOnjzj9a7w4KfjgFXbfI8rsg98X+AF5IYCjyr//q4Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/YchOAm+HvBJKBAVueuJBvmn0D/LcCrhzlI3TWYC24=;
 b=lF3DoddDKLX+bnkDn8bStd/i0rKCLtD6HVAQqyLjwbEu3OiV2nop5TxZB4qdmGTVNSbNsrWPn/fXex3xA6ueHuCZxcv/GStQR9dACE6nwAWCrjoDImuRidWs4L8u9eKU1Xhyh/wKvTW2ZtJ52KhbI9t0jPBs2Do9bNFJvM5GcgsysMPTklHa7OlK8Jl1yBBzE+1LTI8RbTSLzKLtFsrui6CAkhItG0QuxlS6zvKGIb8DRW7CC2RWH1X9+H7ButdhUINdfXOjW6s0iH1qwbGdGo1Lb4fq3kx5W7m+yRAy1/Dpstlx9u0YPU1lW9+vZojA46lYeXrCBCOMmwzqh3yXsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/YchOAm+HvBJKBAVueuJBvmn0D/LcCrhzlI3TWYC24=;
 b=ghOgHEGmQMPFLH3Unq+7H0W5th/MqvnjndUWXyxRFhACJQNWmBT7yhOyhQLmxBgR2xzK7+fN5Ms3oA0/AfopWuzfUa3gw6EdAvBg0rQBygQPd3sIe7KTXuImuGpA+PtMhHAy0tgOUYucOOhGxAd664E9NrJknjZY52AE8D+G4JY=
Received: from AM0PR08CA0019.eurprd08.prod.outlook.com (2603:10a6:208:d2::32)
 by PAXPR03MB7805.eurprd03.prod.outlook.com (2603:10a6:102:200::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.22; Fri, 27 Jun
 2025 07:58:19 +0000
Received: from AMS1EPF00000046.eurprd04.prod.outlook.com
 (2603:10a6:208:d2:cafe::74) by AM0PR08CA0019.outlook.office365.com
 (2603:10a6:208:d2::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.21 via Frontend Transport; Fri,
 27 Jun 2025 07:58:19 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS1EPF00000046.mail.protection.outlook.com (10.167.16.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 07:58:19 +0000
Received: from N9W6SW14.arri.de (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Fri, 27 Jun
 2025 09:58:18 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 1/9] doc: mesh-api: minor copy&paste fix
Date: Fri, 27 Jun 2025 09:57:57 +0200
Message-ID: <20250627075805.19597-1-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000046:EE_|PAXPR03MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: b266fb6d-bd50-4beb-1a3b-08ddb5506189
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HKDogtjnrZw3Xoq0IlHt3ac/b5UAOzWgHW6pG0mzXbVwNTqd9dE5g+uwFc2y?=
 =?us-ascii?Q?mZyFO+psBsndNJmKiiXfNpTvX28qTFkrx0l9xh9/ghH1uOcQArHwBq0mrIFj?=
 =?us-ascii?Q?U4UfQJDsbNWaniZWRRnrBuglM7V6u4VnRpEAmCGHX3X3fAazkT4mMAJYo3hN?=
 =?us-ascii?Q?LSyJ3bWIJNfhaCG9DU3ixTNrS4cWerGBNRaPF0roUIfndLJBxYR4fmCTD2Um?=
 =?us-ascii?Q?U6SbrYW/zPWR2iYnACiI+nDM5vsepEaVtDZgSKt6ntpAbvwZ/etC+H4RzIe1?=
 =?us-ascii?Q?gHy1O6SE+YfdDjyJjomy617EEmo8whGxliN2GYw/bxUg/IN7qbWeiISU29VI?=
 =?us-ascii?Q?CASOpmQqUKIMplnjkTJHK0LyC7MIAOgcPFpLP5QXYebc7JDNKXt/rA8PQ9pd?=
 =?us-ascii?Q?7J0zHG1PrAeviuxLO7pw0KawHf3PZyFow5det/ZP5xkq2Fi/cLPQp1UDAV47?=
 =?us-ascii?Q?rULEemJ0w1ACbp8oEhCerleXRDZ6fMp6qn3anug3TGTSQY0fn0zH68ICdp6P?=
 =?us-ascii?Q?FBKdsYjyC0cy1vXZcA928MSXHA6EBH5IBQu0tjSIZ6hFpuoRnXqY8jPciS4Y?=
 =?us-ascii?Q?Y4v2NUnthI91xl/0Pl7Gv15Tc6iA5X5TWoowZyO+nlWndwflakatHh9SpH9w?=
 =?us-ascii?Q?VqCiUn26jhATP/4bq5wfqay0DnoKI7lfoEqO1zQaX2qyw2vpS72FN3Yd6602?=
 =?us-ascii?Q?W1zWIlLynKgwDv8zNJQSOikkKIYBmxOWySQ8Jsplc7igrcRD9iFHK3vI4stp?=
 =?us-ascii?Q?/8xJ8Ka9rEQKAZWTGdBSRUNz6yP+LEn2HXFcC+ZdXaLKmUMfONNqgX/a1Czu?=
 =?us-ascii?Q?zdJ6kHe33TuiAVnGgV4VD8ZSoBsYvkXyuj8r4WFe+2mEvSWfqH6UnwhNwUcY?=
 =?us-ascii?Q?ZuCh9PsJSkfPwmCMNKHGSpdsDCvrj1R5I0DGp6ckwJNHRkuzQZohag5G7MZc?=
 =?us-ascii?Q?GeMcfvYMmkzU4F45JkG28h95LZblo/KwrM4iYO11emuWwcQpNQZk/hZ/Ri8f?=
 =?us-ascii?Q?zR1jLUU+OFA9kaJzFrLVQGYp6JqsQfFAQnE+9LMrroG/u8IfTIa2CUy4lhgv?=
 =?us-ascii?Q?lj3DsZjkTo9uc83vsEGa1uVW42GLdiGKHmgg1kIFwGTTp6ktP8wpW5FDuRCb?=
 =?us-ascii?Q?qKOWjxMATLUJTj6tmtkD+ft4t9vJMj00M+I7VX0Q6mR2CMAksVBw/WisTwbp?=
 =?us-ascii?Q?4TddKyRYcZMqIHptkOFXQ6jXUNZTZCVmBvn5TtCfsn/sYqVrO5gWpKiu6y96?=
 =?us-ascii?Q?nSZ4kz1oYDzRaBGr+iarWm2aYTj2ovK3+h529Oo1dGkN/GVk6GAPUbVMr5RL?=
 =?us-ascii?Q?vfCvnMzGI1OoHzP+loT5FUKxqz7A8m7YuLnKIkHVxo7wMM76KBp8ClBuQR73?=
 =?us-ascii?Q?V4D+shUgQPiocrabnWgTIk/38zXU1MzrHsUcSwReXOB6d9Q7ywtjfkVNv4u5?=
 =?us-ascii?Q?WCcJy3IDz6kDIZxncU0oN3kCt5xI4w9zvWBAQKKQ84Ze2nzr8kE9MpAAE0DG?=
 =?us-ascii?Q?QCNTkj9rzsDZDCZp6eyjazmbKe8ZyHHw5SFI?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 07:58:19.3776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b266fb6d-bd50-4beb-1a3b-08ddb5506189
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7805

---
 doc/mesh-api.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index ea6f034db8a5..c67b8411d797 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -1018,7 +1018,7 @@ Properties:
 		Element index. It is required that the application follows
 		sequential numbering scheme for the elements, starting with 0.
 
-	array{(uint16 id, dict caps)} Models [read-only]
+	array{(uint16 id, dict options)} Models [read-only]
 
 		An array of SIG Models:
 
-- 
2.43.0

