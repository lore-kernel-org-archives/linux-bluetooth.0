Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010065.outbound.protection.outlook.com [52.101.69.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B8D14AA9
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 13:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751979843; cv=fail; b=kc7p6gwDNlS9TZ8ICwrh65J3F202gnH79GVS8ZCfrxtcz1JX8cFJrd2Ny0dF5kqEgaYaqoyoI31pImNH3CySYAuX4QEBBDmli/SPRcm3K9guh3uabJqaVV2ZxBZqdGmgzGD5H9vgf+pZweVfvFpy8SUNEQIjYJXDtm/NMU+8038=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751979843; c=relaxed/simple;
	bh=93dYgIvXM9F//FdSWUKia5bOoLoHJxlXWXABB4Cxh34=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CpX4ctPNLucvxk4uzAalFrgdzyhPfM7OyjCCxnBqwA/XVlxlAzCZavdWwtpr1UP/c1LF9RmWN8IaqqOPXkcOxQdJtTojTLHkilkgMSIrjQojQg/ZtIHowsyiGMLyuwgqprhZC87Zo9MZTR55tO6UBq44/I3lCIydJwQRFPHhRhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=OH+hDxCb; arc=fail smtp.client-ip=52.101.69.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="OH+hDxCb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tgbu90y4mEuHIM7Tx7gZR4jfREmIVz/I3THPwgqKASuxjz76jgHNTRJsbPAjSfjngLURMrRZx83eZ0u2FfGximlKr0RJ0vHu/DH1jTjGsyGwUbzl1+XgK64dde1zs0uxpghA19EcivJAzFVBuoO4pR2Z+GpeGRAGio7thsVGP+mwgXeVIhS5pIHJtMdaqN5s1qaZkI9nIMCWx9HUHiBkzvI5wbnpMv6wAoF/7LctwztuQQlj1LTqx4mdjCvbwCkN0+gTeWVOiBOuzyFr3I4Q95VGRA10WA0+CGDZMIVwwvwKEVAHjGZFgLfgKwHbdhJF/1FTOmfuS7pTz8Wv/o50vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPo4TAYk2Y3N/m952FQxHUq4JbM+/mCx7miCvNo27xw=;
 b=Zuo0iBvKU3yBNz1eN0WDCo0UNTmoFJ5WJwjSpxwH9CVnsV4xDhX2aR3h0HbfaUHMvsVeuV5eCf80mu74DkLJJgMKeTg87zdNq5mQPW5rk0yb2tGYl+2Tw1yi+n2oxmb6u9kYilw+SUGhe0UgCqt/SgjCDFHkr4H3qVCTjoM97vvSDVjnUhh7eH//OXT/vVh3uRLxWzaHCs+dTcpCw9W4FFSxpaffHQMnu1SkyfUJ7CTB5l1cVxIgXjPm55CmU17/lqD1ikKuAOEPOgVLeoqwUAPxJJ8sjh1gixkTM7pmAl9A6z/MqDlDp4UWjiGffdSBJEgdvckK6aZ5+AoD7+7Iig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPo4TAYk2Y3N/m952FQxHUq4JbM+/mCx7miCvNo27xw=;
 b=OH+hDxCbYg/rGciebdx22zkGVteHteqdu50P5lNrDEdpvkZjiIQIX+HI8bwz7XURRbCrks3Bh+7kAXmjNiKqYgHmDaN69KhbtAkRcOX/3POsmyeu5RqqqVn6KrkA9Pp6aC5J6T8izsjQVdfl4YoXbWU+XFGQNPtAVtahEz9M0qM=
Received: from AS8PR04CA0018.eurprd04.prod.outlook.com (2603:10a6:20b:310::23)
 by AS2PR03MB9224.eurprd03.prod.outlook.com (2603:10a6:20b:5fe::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Tue, 8 Jul
 2025 13:03:56 +0000
Received: from AM4PEPF00027A5E.eurprd04.prod.outlook.com
 (2603:10a6:20b:310:cafe::4) by AS8PR04CA0018.outlook.office365.com
 (2603:10a6:20b:310::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.26 via Frontend Transport; Tue,
 8 Jul 2025 13:03:56 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM4PEPF00027A5E.mail.protection.outlook.com (10.167.16.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 13:03:56 +0000
Received: from N9W6SW14.arri.de (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Tue, 8 Jul
 2025 15:03:56 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 12/15] mesh: node: remove dead function prototype
Date: Tue, 8 Jul 2025 14:59:44 +0200
Message-ID: <20250708125947.11988-12-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250708125947.11988-1-ceggers@arri.de>
References: <20250708125947.11988-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A5E:EE_|AS2PR03MB9224:EE_
X-MS-Office365-Filtering-Correlation-Id: e1bb54e8-d4a4-4ba5-fb68-08ddbe1fe5de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TS/XSXyRbc9bN9LzRwGHQP3v6Jo6fmfv4us3kSO39ZmcP5yx3jbL4X1XZbEB?=
 =?us-ascii?Q?FynAgQc5k+A82WMHNEZYSVxff5GSzocScqKv2m5nAN8hyJhr6RQMsxvw+Kwy?=
 =?us-ascii?Q?N8iqtqbHnU0faonu4/sHb9TrCFwdCGdEhjh0lrsMy/NPTnQHiP+Y2p3gNtVP?=
 =?us-ascii?Q?uG65zjAz67gjbA4eERXIv6uC8x2gY+RVeonOjE1+qo74S5p8X8VWtOsfOMEU?=
 =?us-ascii?Q?93NN8wWO+0k7TC9I5usI8iAgKpT9AbahAl22MPJFQtmrZYZZzitxlAUZLdKX?=
 =?us-ascii?Q?4kdQmuglgmcgNAN1KmqFeWqjo6AzLo2zz+7GttqLRD+3W6KrwInZI2obrAB/?=
 =?us-ascii?Q?CifJgKv5ZAFviItilOp5XimZERcdCURzVhatZ7S4BdUpT9YepT+fskeqMK0N?=
 =?us-ascii?Q?l3RrC3xsb1/riZrT+XLgftttUdJ8WdhL9eY9IRepEPeE5UZWAtHsLHB1tMw2?=
 =?us-ascii?Q?fuODJAz2UmUjTBere4pI4CMBYtmeZa/i8K1YQTOF02nzYSMtp0mjpKksp+sJ?=
 =?us-ascii?Q?D+JptKUBXXaXpoKCj8QTn6BCT/AUwhvPusTz4KqJpV4hrSr5y+48LTgvMswg?=
 =?us-ascii?Q?cbkqjOrI9MBRlRiOzoHB65enLFL0+g9X4lS63dop5V07JPGvTGpQMKA7CVhT?=
 =?us-ascii?Q?avQDkbovhxdUUPW4WPfbTJpqzJYzoecyEgfXqg2Nw1Z5KcgZVbKMzNNSKpp/?=
 =?us-ascii?Q?E12BCUIbNflijaN2NnL5GfB+xH0v3ZBEUL3WIWh4hCtvdxQnfWxRhTcjrjxk?=
 =?us-ascii?Q?Z4wsEyGd8mq5oXFbvAdBHI3hM8mCF7aIHN3UP/gWvc8MSDc6MaPHpwoKecCf?=
 =?us-ascii?Q?8Y74B+2l3IaFa1ZXSXIQwv/e3wsbGBO/+ygUYns3Md89+aKr6TzASHGdKIXw?=
 =?us-ascii?Q?jBK35rduZLfM8kE+mzMDPwoMy+mlDo5CcWuWBKgoAAFh88C0wFxNfORV0Fvn?=
 =?us-ascii?Q?LWVUdmQ33gIo8NyATnbzwbJqlJa4TI5L/auW96U0Cs0fPNX9dF6ludkEPSd6?=
 =?us-ascii?Q?SlCuZJeuC7aQzaeo/U1PgVqtJ/Jk4depcwNvxWshg4ftoQTAZAh8Zv6hS7OV?=
 =?us-ascii?Q?X7QDSaWUnD7OEBLdyhcvkJVpFjs1ljSA4I5EqVJA1f7FTxVEv9iMEuen36s9?=
 =?us-ascii?Q?g9mrbrjZM64sWOZcaEIENGFywN8hUs8wWZAYx1VbrD6SsP5L6TTjI+s8TR3i?=
 =?us-ascii?Q?S+GRZ/LzftzfANf0Jz1AbdA4yi3fVPNuOVNIiVlGldLGnG8UCeHJOXwqAf/u?=
 =?us-ascii?Q?lb31nGN9e9Xi9uiRI6S/h0fnQmtQ7dVgmdRlVd706WVUKm1VCDc3QHuA5VhV?=
 =?us-ascii?Q?6U9hEmPnwYQFV2EHCIWm/twQoawrgrtCQi5v0Wd8mrLjeImYGy8WesH2BEAc?=
 =?us-ascii?Q?cOTcfUyNnItwxeuC85Rjb9RqtqPYWsvd7JqLAVUAjvGuhfHuUjCmbTbcl2qP?=
 =?us-ascii?Q?tIG/JqLoqox1+AGWMoO/jFscb5nhTusAajDSa6Gt/QyjpPUt3KEUlpN5pd4v?=
 =?us-ascii?Q?g+Y8ca+VH7VLDfMao9GspwkcaBth4NJPAoTZ?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 13:03:56.5923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1bb54e8-d4a4-4ba5-fb68-08ddbe1fe5de
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A5E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9224

node_init_from_storage() has been made static (and renamed) in commit
7cafe5fd7cc8 ("mesh: Manage node config directory in mesh-config").
---
 mesh/node.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mesh/node.h b/mesh/node.h
index 136173c8cee1..92dff2256dcf 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -51,8 +51,6 @@ int node_get_element_idx(struct mesh_node *node, uint16_t ele_addr);
 struct l_queue *node_get_element_models(struct mesh_node *node,
 							uint8_t ele_idx);
 uint16_t node_get_crpl(struct mesh_node *node);
-bool node_init_from_storage(struct mesh_node *node, const uint8_t uuid[16],
-					struct mesh_config_node *db_node);
 const uint8_t *node_get_comp(struct mesh_node *node, uint8_t page_num,
 								uint16_t *len);
 bool node_replace_comp(struct mesh_node *node, uint8_t retire, uint8_t with);
-- 
2.43.0

