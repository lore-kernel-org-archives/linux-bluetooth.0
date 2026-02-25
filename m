Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013008.outbound.protection.outlook.com [40.107.162.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E00A26F46F
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 16:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772036356; cv=fail; b=dTyW8+fnWHSOTTZOH2z9G+dsIqJjqlAi4NqBXNTyJEoKvF8Pabw84b9KRX5wUB1wmEMcnCxWUu0n6JATlfs0+sjH6yy44oDyek368w5v5RyNXYI/rtQ6pyO7ZvPtUEDbd3LvmbmdW+wbri8s1TmeKB+sYxPzVeLwLaSuWD+KyI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772036356; c=relaxed/simple;
	bh=Q4k39tOP5bKCfmkjz8hlhWBttWoZ0+pnrGwKeZD0zBY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hU1owuscGuWU03d6mnq+yBsOu9jhOLWuRxpgjlB4oVIpvtBi7ItAPEWWWsRhtnmWGvhrRMe7662QauU+wenr059qvNPaycBxf3lVqGCv8z+TS4YZBpCr4PecTMwh/csJQNQ1kgsyw/NCScBOG3qJqTkrzlJ2cV1ld1FV4zBYMrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=vD6S93Tq; arc=fail smtp.client-ip=40.107.162.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="vD6S93Tq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BfrMkAKtd/H+PCIe8EUeU2/uH1dU7CEmhjy6zF/tnWI+vRNXzqq9GPSg5MWPh+8Ik3ZLQc/xlo97thmjh2aOJaNLhYX8GqfkH7q2//qzFJH1uDLp5B9R+o6+554TMME+27W47uyx1onXg2yjr3W7xRkGtr/0YTQQKIKKvc7a1pGd8nR0b9MrEWS1Gmp2Nm4MV2ywxizAM6WPcgsVa4JA+lkJPfA17idM/kzRlGP0+KYcCkXMR+wuWWzWFor342ohEXItTRtL1FKK0jn3Q04T6dTF7kFuX2J6fg2vclc5fmzPhoCC5MreAuM32S9rhIHDQxFwaCtTb7fkBL4Uj7gFjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnxGglBLVw2DyVlikO+2+sAP1gi8s/UUD0dGd+OjiZM=;
 b=etiteGdIcSo96GEmlZ+Tuvn1JY63P4eYD+1ai2p/DO1YD75iHizCXZuDNUSpMAP3bXfzEORDh2lYlG+C16tOc8QeAqp10tEEXY5lVO7ac1GX275TP/B5ZDtAN7dZAd+PGL46sJNbZyHPDwKcZORrCZ6hFwN4RW3QaUgeLNUEOc1q3jp2HGazr1p6j9upSSPmTe7UPxJUGHPcU3qyL9ZgoV9gl7zL/DXYzpe+5AfhsG2Aljg+gUgEi5PVtcQpgXJpSsRcj2SVzQZKjppUJT+YyVjRQkDK3+6f0dSZSgZBTJiD6um4YD6Xf2Rxr1yijio6ondvBAQ0IXsCdRMwo0wkhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnxGglBLVw2DyVlikO+2+sAP1gi8s/UUD0dGd+OjiZM=;
 b=vD6S93TqUl+OT4Qa+6hurPhnGOvSCSltHe7ZkKrhTJyz/Iqm0eF0Oyb1hztfoLonkDRsMnfO4DVZ4sl2ZPuQaKu1N/LOj0zqEp1BwADiL8Y9OhtU05YN1sHbFzPDJTxeFa3ISc/CY56rD6Y6YxV+XbSheo2deHsfKIYaRtfL24Q=
Received: from DUZPR01CA0326.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::25) by AM9PR03MB7542.eurprd03.prod.outlook.com
 (2603:10a6:20b:411::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 16:19:06 +0000
Received: from DB1PEPF000509F6.eurprd02.prod.outlook.com
 (2603:10a6:10:4ba:cafe::de) by DUZPR01CA0326.outlook.office365.com
 (2603:10a6:10:4ba::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.24 via Frontend Transport; Wed,
 25 Feb 2026 16:18:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF000509F6.mail.protection.outlook.com (10.167.242.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 16:19:06 +0000
Received: from N9W6SW14.arri.de (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 25 Feb
 2026 17:19:06 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 07/12] tools: btgatt-server: remove unused member 'fd'
Date: Wed, 25 Feb 2026 17:17:10 +0100
Message-ID: <20260225161715.20394-7-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F6:EE_|AM9PR03MB7542:EE_
X-MS-Office365-Filtering-Correlation-Id: 393481a5-23aa-4f49-fd7d-08de7489995d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	iL51uoCyv+++rlRg+kKe71lVUQstGxrSMnE5xCHguOAMsP60HTKjz9T0Jk4VYoez5ALYSbAk6QOsP6e9sdRDFJQhwOq2Uprbke7IlxeWMAuDzxIu+AyM3IgaQx/5vkYoSqKD9PS3j8zuon3ZWgRdke38YKb8ME9bblJsoPgrCQc+xvfw0C2GxKIduh+QuWmhvpjla/9BA2dNOiY9nxAFx7H1foaoGnuleS14Ea8IO+wQvUHUsjV7T5SeFdmvJAYeUmthX8rvNNNDRvrc2z4OvHOGXfPY/AIzqEUGE4mQ2av7X5FVizuysTwAuo4eLPF2mjPkvqMNiRVrzGvrp11KmuDZTzS6NmCqKQ0infzUgvEMkhIgoC7WPtElgUIjemuNXYcid8uTmkIphs0g+8sKkk925/sZpqeulckkpK7r647jRtUyPXvg3DN7w2qSMNQYZRD4Agn3DSIBmgBp9uE3ar4j6V6HL1k9abyqjKl1XozJl9qx9OcUYbxVkVlZF5igRXXDv49PE0LODmQqg/MBd3/H8ixXNTQ45di+k67HWEbtmEBknJjajcUGCuCCW5/5H4ZbkKtzOl+mnT1SZ50IoSxGM+gjz7rBPlEthmOAAFGQqEQ4PZGoC1VtQzS3//AngwRi/IJda/Yx4Jt7JkVhX4w/htcxrJupdykT8HrS6o8MyjQj8cFf02kqUkxySQNRd0s24HItix3uuz/VfXEUVHU7BgO5PdCt8mXOrI+mopcgbSxQsIn0gPoIGgfEU/Tl9cEaJhh5UwHy/tDYy4lItS3pzv2oH4h+IJK0tktS5jNu/CDNRLjqwtVDZ2bflvcE8uiBcYmsYDJFcQpDol79BA==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2p9nk4iEk6+UJIg7ZaqRMu35pWm3FFUbX6sLBZmdyj5syciqQJq4hFlrd/smP4uKebzQYYvEysc7+hyxeSSTyWaiWpGEDqFr+0jQm8vFYQs/LFi+7ige1vlOsSpj4MbjiA9T/Hfp3ieFS7yIHBE1amzh9wQgox63AfAAw4s4dd6+l1HQO1bnByIbxmC2OBwN/TKn0tOmKrifZSUjWOjaIq6ufTuSXRXVZCDIXdmGgM5rZPa7xte4IPGwKkKwW22i+sBS3jhDXVKTrp7oQXPn3km7VBlaFyX6HayM42FTzOwh9C1S6tBAWaYEQwHl8yp5mraS5Evi2GnZKzPIGGQ0DwqRHdngF1rMIrIr20474yArasPbI+ktnH/OVyEQ+eTpPN9Z3BQHeavlDLP/1uwQ7nVIG9OeSwxH5X7QaV4NYMCwsm9QdFTAoUjSe/tlEeJZ
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 16:19:06.4877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 393481a5-23aa-4f49-fd7d-08de7489995d
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F6.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7542

---
 tools/btgatt-server.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
index 1690b0dd059f..449c342031a5 100644
--- a/tools/btgatt-server.c
+++ b/tools/btgatt-server.c
@@ -66,7 +66,6 @@ static const char test_device_name[] = "Very Long Test Device Name For Testing "
 static bool verbose = false;
 
 struct server {
-	int fd;
 	struct bt_att *att;
 	struct gatt_db *db;
 	struct bt_gatt_server *gatt;
@@ -570,7 +569,6 @@ static struct server *server_create(int fd, uint16_t mtu, bool hr_visible)
 	memcpy(server->device_name, test_device_name, name_len);
 	server->device_name[name_len] = '\0';
 
-	server->fd = fd;
 	server->db = gatt_db_new();
 	if (!server->db) {
 		fprintf(stderr, "Failed to create GATT database\n");
-- 
2.51.0

