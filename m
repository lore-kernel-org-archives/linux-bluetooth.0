Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010011.outbound.protection.outlook.com [52.101.69.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FE83D7D93
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 16:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772036367; cv=fail; b=r62vUaureP/p0U4NSlaL3QqZnrfreRS23dPIQkddhA0mse5r5Nt241cGFLKZkyUIeRCVh72patuqdKC3M+mo28SwgVefzL5KDtvN09dx4l4h5eYe6dNXNjmo7IVU+sKyTlKoB/hROJURmQG4AV4NwIcou11cvMtjPYbA1FEhtDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772036367; c=relaxed/simple;
	bh=r2iIgWFk10LoOgC0+Y+pYB3fbb3PkfqEbd0n7uGAwoc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nr0kCTkx5jrLCg2HKGRkmKBywC+mPDjFe9AjfB1tMqFfOOkyG1ycYWvlYqpx0UzLwGx/pPm2i8xBvdprAvlbIhRC4sc6OccTSbVPVXkOrXwOFCGqY5ihZw7asysz2FKXJRG/5qlMagxMwQCvjbxSroyF6GT5Mey6CXMOkSoVvL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=LWuGheWb; arc=fail smtp.client-ip=52.101.69.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="LWuGheWb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGvDM/uDXTna/OOd2A4cdKUUqtuOADtpNNDvrNXxNO3qerv2Bk0Y/NIO+wsWoUAkutkzkF7FMfEBs062U+nBelXnNBB0UNfw3NKmtUpwB2xoIIa751Jk5Y4na0uzhtxt4rn7dDz5smu6kPwo5dI0lHKWLC0QOjaEsDHpLk3//f6m0tAxhSIoSSKi+DdczdszARv+kHwmDLIFGL4maROUJvov/xS6BcSk2m1KJkcfZVgSuXT6V4BulKaNK1fI9tMVYkVHKn0rRuH2qtZUqmlCz8oDfPja5sgI38Rdn6fymnI/mPKiJKQMeicHLLsFYbLdl8qEh9/RhsecA/gFeqaciA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxvGoeB/70mDTrJ6uS9RZ5mk7rJ6rkKgZ9XyHh6owQs=;
 b=sW9gO0EIb3/Gc3CEe3V3QzdwqelBMSb1a/MjEjDb81SPTm8yki3AQh7vd/Jd+jyqd1VYUD3O5IwO18Vvcii7aoJIj7Oz2kqDkHN45dg4k+08GTnTpF4maPQk6tl9mg4TnP8kDQW5CKRR0++k6RnUhA1Fa5pp7Q9FPozGiJHmnox62ZYpsGWj9+KpAdrgFjKJcwZ1SSlurP0v8V3/o5mZVd6FI+5aM8reKOQIBzPlwmbbNqn0HNHRAybKLu0AE4og34Os/sxapScFJRzeb5i2AczNd7MQlM5E3ndTMotOktPq5gGTckYNv1FQPsETxLjPHQ2QDysGSvT2VzvkydXNXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxvGoeB/70mDTrJ6uS9RZ5mk7rJ6rkKgZ9XyHh6owQs=;
 b=LWuGheWbL+acTHQ3yVxIyfN4u4nRIKVCqwny7CWsYiaNsNQGx9v7KDfDVhUjwcXTKY8dH3RXBVk6DbKWl74+qmilE9v8jI3Hsr6xdTpmui/WLErwLWAe/uk/CSiD9Cs9dr2r/qPWcf8N2wAJl4hpvyIP/z+yxhFatQIguZzKnVE=
Received: from DB8PR06CA0063.eurprd06.prod.outlook.com (2603:10a6:10:120::37)
 by DB9PR03MB9733.eurprd03.prod.outlook.com (2603:10a6:10:459::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Wed, 25 Feb
 2026 16:19:16 +0000
Received: from DB1PEPF000509F4.eurprd02.prod.outlook.com
 (2603:10a6:10:120:cafe::91) by DB8PR06CA0063.outlook.office365.com
 (2603:10a6:10:120::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Wed,
 25 Feb 2026 16:19:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF000509F4.mail.protection.outlook.com (10.167.242.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 16:19:15 +0000
Received: from N9W6SW14.arri.de (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 25 Feb
 2026 17:19:15 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 08/12] l2test: add comment to -F <fcs> option
Date: Wed, 25 Feb 2026 17:17:11 +0100
Message-ID: <20260225161715.20394-8-ceggers@arri.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225161715.20394-1-ceggers@arri.de>
References: <20260225161715.20394-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F4:EE_|DB9PR03MB9733:EE_
X-MS-Office365-Filtering-Correlation-Id: bad1db0c-bf62-44de-7813-08de74899ef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	xeuxwWtVfnvutjYycU9dqKY+6tRj97Np9O4lHy+061POS18HkfQ7ZweR9jVwTAS8fKGngJ4OjO5f9CkvfE/2MHQQQmE4Sc9uqErDdM9UU3sGh7TW9ciLIF1VAwvLRPs+yga/w47uZdMB6wXRFPL9IXopAbh+9fWurBhgqSvZSafyrjcFWADGh2wqjKx7s13gBxJA0Vtr3Kw2QZdUtS/4oLKF3Mt3TPOKnTeNmKTbDKkHVuYilCpwIqqcSKk7l+fGerGmo4eVTwyRaxc3Pcrn/fCVUq6DVh5f776BUr95PwTu9uUHv1LO2GreSp0XXbP1jxMvemx6ipvS3i609PQZNrwflF134pwy0DzDqux8DPqslIFDPXXpWGyUBBuWhz0ba730p86Grpb+tKoVmdYSAk7tvgewu1V+Bnqedzp7r1tACN7tD6DmzYgwuJwzDj5hDtq1jUhrvSYcWpWSo1kQgRSffBvcqflKEe7UrGl6rHaAK7iesm6UVXG6PX8r2iXo42m57U/GaKgpsvDibTQtmEmMPFMh7WCKWnQAxG1KyArf9jTiKyxPROd67BFxowRCPeiwuBlqkfNEKVuAWkmkUu0+Mq9dt6KrfZRZNnyt1Q/Ame0FHsBO40ddf1e0OaQee/vcuXtZurJCqdXKPTkz02CWzOEksjTZ5R1FkAYIqBP0/wfZEeffVxpFnrnHvER5ZhXAvPfm86d8EjdnwKFThz6ckKK6MCiiCoAeumwhYFB4tatOgRJXEwvjUA6AVcFKDA9m5tGpLm9Y2K8A8N5cPQzT0WLigezmTAh9QIA+4RGGSnr2CSZ2c1xnnprA8N/OD/svgPAdyTfGr7VVWXG8LQ==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	P0LU6i64siSJxu2zMn/RBjHu2ew8QIDqqhy0whDvxvGpUXz5FSUyfVQKS+bnxmrMDE5On2A8fUDmpdiTWLB5r7y9ALhUyuQpZ6RKLAadpYylF4OVL/+mT8uHtILv9+lI5X8CMPg37/XGl/az2I0nillHyDRH29r1DsnA3CiSNBJGY5f10pA21t4qv2T0C+vkhtmBPpVDt/zpaaHPMmRHhQ2ckM3hZZD4V9xKGK+9FZ1bISVXjiETDSVgyFFfNjeqtKpaJp9dANNpPpS1d4mb0u0Jb88RH4nCB1pUQyM8R1DU9482oFthIQKfkGa9mba15RLNTZs+gQz8IX0M/HAYG8FfDozw7Dsg6DPiy8VGCkmVZB1xjvND9qhsU29NZ/OVpTt06ZLNLWo8xoXojGw+kJPCTn//Y4kdnhLv7xr07HYvLS5uSY8hb08asj5oB73j
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 16:19:15.8499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bad1db0c-bf62-44de-7813-08de74899ef2
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB9733

Clarify that this option has affect for BR/EDR sockets only. Use defines
instead of magic numbers.
---
 lib/bluetooth/l2cap.h | 3 +++
 tools/l2test.c        | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/bluetooth/l2cap.h b/lib/bluetooth/l2cap.h
index 62cc04b57ae9..8b54233ef9c2 100644
--- a/lib/bluetooth/l2cap.h
+++ b/lib/bluetooth/l2cap.h
@@ -187,6 +187,9 @@ typedef struct {
 #define L2CAP_MODE_LE_FLOWCTL	0x80
 #define L2CAP_MODE_ECRED		0x81
 
+#define L2CAP_FCS_NONE		0x00
+#define L2CAP_FCS_CRC16		0x01
+
 #define L2CAP_SERVTYPE_NOTRAFFIC	0x00
 #define L2CAP_SERVTYPE_BESTEFFORT	0x01
 #define L2CAP_SERVTYPE_GUARANTEED	0x02
diff --git a/tools/l2test.c b/tools/l2test.c
index 2cf3a47e7cdf..e49289a4c774 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -72,7 +72,7 @@ static int imtu = 672;
 static int omtu = 0;
 
 /* Default FCS option */
-static int fcs = 0x01;
+static int fcs = L2CAP_FCS_CRC16;
 
 /* Default Transmission Window */
 static int txwin_size = 63;
@@ -1349,7 +1349,7 @@ static void usage(void)
 		"\t[-g milliseconds] delay before disconnecting (default = 0)\n"
 		"\t[-X mode] l2cap mode (help for list, default = basic)\n"
 		"\t[-a policy] chan policy (help for list, default = bredr)\n"
-		"\t[-F fcs] use CRC16 check (default = 1)\n"
+		"\t[-F fcs] use CRC16 check (default = 1, affects BR/EDR only)\n"
 		"\t[-Q num] Max Transmit value (default = 3)\n"
 		"\t[-Z size] Transmission Window size (default = 63)\n"
 		"\t[-Y priority] socket priority\n"
-- 
2.51.0

