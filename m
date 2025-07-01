Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012052.outbound.protection.outlook.com [52.101.71.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7004326FA52
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 14:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751379483; cv=fail; b=SnnOzw2jkrlCengqEQD8U41ddekjK066EbrY8GRE0mKz9JQefddsZ+iuS1EV4g7gRns6MXgioamnJsaODrUiMXcy3JVhLiZK2qPKK3gs9g+wNd/XSkynKlZ3luC4ABbtbBqIKUDcsTO+ibn6YNCLF3wZSwQRIspS5RkfzAIaHII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751379483; c=relaxed/simple;
	bh=tLpMW+QeavR8xc869GlyAcY2m/WbmRI1uYR8lsowG/Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=grS3wis1E4sJs2ndObhTiQOOL/KRaUNpK/piqiCRFLmshH7TfnBhS5gLbD20KbayuePy3W/FRW9eiikCCE7Im2FTb65LEF32TYUk1d5BeM2FmIcrLHRlnBRSpQZS/S7pHDTfLVs0LIAt5p4CbQAqzmwX/LA/zAnxMugzU7WB3Q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=Qt659BiF; arc=fail smtp.client-ip=52.101.71.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="Qt659BiF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZBwlbqNwBhza+ZNsaSk+Sixc2QgNx9+dFgXMOBJz/R+d6WGAZNQqwSVlCo0EWBBn/tOalxqLwqyxlIADx3OHtL40Jq9Svae226ThUhcUWEWpt5Pss9ZibWm9gUNW6wbA4Ms2Kww9uIbApVqyZCP7CQfyiTglWhuTDDY+FdrKRCkfYvdywc456pEcDMFomazYET0qqpeOqZbcFSg0yzGJG8ayWQ8IuyKuqGr7FlB35seDlRp7aoG5wiEC96vITNHLCj0gNfKmuC7NugQr4xiUgdWpzcJNB4/8fKgBF+7N7FhzNazyK+usNA5cRw4cIHpo+YHKwiv5gJt1EIQpvKfhgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxvB5QX1lfDMwqSq3WwTSV+KJNIOHnwLVLWkr7PbjWE=;
 b=BP15pMwUpSQD9Dab/uTKmP3Ofy/+FbYgjfGY+qjsWmdVTU5y8bv2qVO29KmTESL4VahjI4pggVJxeVvDiLKfZBYcHGZAMCqQV1Cla9tV/Dm73Dj+xwKRaM1reuUp05Px/9P6/xGQGbbP0rzho/MFYxdi+BHVL0ta6wRbHX61onKd8DeMarGOFDVX5OewKg961ZKXefZGgSzAyQP73Op4Fhwx6fSx81NYCq/uTYUk6U/CpM2o5SsO8sY47ypw/VfXmM25x+We/DOaNxgrWtXwZnQMqBgBq9gkWx7oZfgttOSeLxXy9QA6BEaVHscFQNbiEbkZ2Fp0A1P1AVtt4w/ixw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxvB5QX1lfDMwqSq3WwTSV+KJNIOHnwLVLWkr7PbjWE=;
 b=Qt659BiFOzAYl17WjvtDaEmrzbto7pcnGBFpaIZHKotlPQF/WVDtL+VWjIuhCHL+HnH0ik486FQl3Wcxqu9aIQpnv2svzOA3T0lsw1/0dGIPSDKAkwFGr4rEI1wEYYVgVUt0J4tindrtTCVbMeU/K+oGL7DIrC3fyAFnQobzBHw=
Received: from DU2PR04CA0256.eurprd04.prod.outlook.com (2603:10a6:10:28e::21)
 by AS4PR03MB8313.eurprd03.prod.outlook.com (2603:10a6:20b:504::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Tue, 1 Jul
 2025 14:17:55 +0000
Received: from DB1PEPF000509FA.eurprd03.prod.outlook.com
 (2603:10a6:10:28e:cafe::3d) by DU2PR04CA0256.outlook.office365.com
 (2603:10a6:10:28e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.31 via Frontend Transport; Tue,
 1 Jul 2025 14:17:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF000509FA.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Tue, 1 Jul 2025 14:17:55 +0000
Received: from N9W6SW14.arri.de (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Tue, 1 Jul
 2025 16:17:54 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 1/2] advertising: client_remove: use concrete type
Date: Tue, 1 Jul 2025 16:17:38 +0200
Message-ID: <20250701141739.19128-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FA:EE_|AS4PR03MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: 50024a8a-2ac7-46bb-181f-08ddb8aa1290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fN94JnEQYwzhZ+INk018MSQYI55F+F6qxELGC+ObXxn5gCV8iJn/cvH0SXUE?=
 =?us-ascii?Q?87LQGJRBH7jOv41V/E4KySkmj2X/vpFGkI0YgtdvSYVkJKklCxyi9j1Kz8l1?=
 =?us-ascii?Q?tTdvrmzUMxfU3zptEX3HivaD4ZcjDRhvayjVVcjc8Mk2B4qUkgcknE43ZrNW?=
 =?us-ascii?Q?Ph8d7djws7YUl5t3zMzdwqUzzlDZ/VFix/hNSeCGy4cMiVaiE504JP9tSN28?=
 =?us-ascii?Q?cL1WQsb5WRB+VPt17E/0pY7k7pELnMFq2hSEkcb67tq2naVmT6uciSg0KS75?=
 =?us-ascii?Q?M5cbD9v0pzTHtAKyOwAjijKnO+JhdlLDKhQDUuCXHAFx2NV9u0jHSZ3hVlZj?=
 =?us-ascii?Q?u+PIM2ijTRgyBI7q/8WDje+qf/x7yj+RURmo+NAxtOTZCDL8hjcLJo1lSk/f?=
 =?us-ascii?Q?pCd4YfQ/vt7ltEsLFGN5rCoVVqS6poBfZ2ToV3HANAOKLHfxDC2gi9A2ipmu?=
 =?us-ascii?Q?VeEBYa6rZ6aab4weRDUafzBPl1bTo2wJ0WIJN2AIISyQtubXpM73QQRAGxzS?=
 =?us-ascii?Q?3FkU/U1l7lQC50UeS8aQTcFMqMNFre/bDnGptc3oFCg3naAPOmMkUv8q9qC9?=
 =?us-ascii?Q?m5Uccgow3vUz1P1pLrnUiGT3KyUTryOMI3/cf9ZOtaotIUSw08Qy8gYCyCZ4?=
 =?us-ascii?Q?xC6DPFL3i6YQL/jeESkgOcWbMO425EpGMaoMjhWQWtk0AzTSyZq8zjFG30nw?=
 =?us-ascii?Q?7fCOCz23bfrkR3op0T0WXpD8wf4cfA/ZZ9Nq1WTOYkz93CeAI0tU1Dbqf4dl?=
 =?us-ascii?Q?bQEFio3hvu0QROoxC9O8h9i6ki/HRz+WWI++ZqNUyoquAOyKv6MNaebTNaFW?=
 =?us-ascii?Q?F6IunzP2/hmkDBKg2isLKVRi8HiU+U4AoBjjZVsoFBwTl5VSa40cBJ+5Pdol?=
 =?us-ascii?Q?2GjcQS4xcmM5nTD6XCLQ71J3Yw+U48QR/6LxwiDhraMPbLVjAA3I7YqgKhvi?=
 =?us-ascii?Q?7mMx6ThWxEhN6ui9M7Lsp9dlxBz9zoG7vTmt0bXPaWaw4iA1JD/uuvvkRGVq?=
 =?us-ascii?Q?89Fi2yCUWJbvzwgsQOpzxSHIwwjEkGArGHMdePAS5eTn9fDIwptYDe/L2UO4?=
 =?us-ascii?Q?1VbDB03ckvNN9bbY14M21kyci+0HhRbq4gUoShL8/H9+d10GIt8LWbGWc8qu?=
 =?us-ascii?Q?eOwjv8e5GB+b4v30HZTsrf1k2YzleyAp5i+jUnBP3PDhvH3ctHDTIoCXb13X?=
 =?us-ascii?Q?rj1ch4Vq9/zQgoaOAEUj5ZreYFPRfSrp+I/mDlIkr6FkB8Ys1WAPQPFl2bEb?=
 =?us-ascii?Q?LA6dzZ1sUEiHdE0ZTdqtelWQrPmNIgr2fROm/V4lH6iqFTBDX3Ww9u83iZev?=
 =?us-ascii?Q?W/w2vlzqAiB4u//2HsllfdzsMRvmiXiQ2flawp+nw5jw7fELqj+q1sloswN0?=
 =?us-ascii?Q?5y2AlDiEhviZPpxWhEb1mQMBTqa+PLrPQR+IneMXdSW89WLy2IjHX4bvH0cY?=
 =?us-ascii?Q?WR1IXeT5fZKqB5wmrnj1jTEXMaj2dq+8k6jQBH4x8OmM0OOTNKLV+/sDZStI?=
 =?us-ascii?Q?VP0k+cXqnXGJjIETs02UmnaJGU6Pp6lVQGWA?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 14:17:55.1136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50024a8a-2ac7-46bb-181f-08ddb8aa1290
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FA.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR03MB8313

No need for using a void pointer here.
---
 src/advertising.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index 4476d7cd53a5..cc30c1c85ef6 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -195,9 +195,8 @@ static void remove_advertising(struct btd_adv_manager *manager,
 			manager->mgmt_index, sizeof(cp), &cp, NULL, NULL, NULL);
 }
 
-static void client_remove(void *data)
+static void client_remove(struct btd_adv_client *client)
 {
-	struct btd_adv_client *client = data;
 	struct mgmt_cp_remove_advertising cp;
 
 	g_dbus_client_set_proxy_handlers(client->client, NULL, NULL, NULL,
@@ -225,9 +224,11 @@ static void client_remove(void *data)
 
 static void client_disconnect_cb(DBusConnection *conn, void *user_data)
 {
+	struct btd_adv_client *client = user_data;
+
 	DBG("Client disconnected");
 
-	client_remove(user_data);
+	client_remove(client);
 }
 
 static bool parse_type(DBusMessageIter *iter, struct btd_adv_client *client)
-- 
2.43.0

