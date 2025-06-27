Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010032.outbound.protection.outlook.com [52.101.84.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603BD3C01
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 08:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751011277; cv=fail; b=iFXe5yM2qjsn8IJ2RuVDASqd3ZWZP46L5C947Pv+a65oQPrSUsBfJ/dEvdd4y5svWZ5WT58e1of7xRP+KcIPrqJLDPrk+iZr8stfn/Nne77UUl9NQM9KNDBM9Q66sLLyxaRuHUsNu/ogJyUbIHa97dU6LF9MJiINHjs9HOVLSkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751011277; c=relaxed/simple;
	bh=TbC6cK19G8AP0Nxb8ZPwWAdA29rxgwhwIaycF8hEPhA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h1zd8mcwmWjIQGJw9bWfWWVROESymCPDOHDabpJjnYtaqHs2EocweW14sL0TJ2THiiVRtS/j0wFzDckm9PqnyLW1TkG7B0vCTP2grFMH3aL7/zvs9TFil2Ji2OV293naRJpOZRku2Y8tKEmB+IFXsutcNiIgkT9jvOc2clud7Pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=sH1XoOdO; arc=fail smtp.client-ip=52.101.84.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="sH1XoOdO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8D5Qt1K/z1bGdNvLzCT4Kyvcs3d1Ioxf6S3YrTX3c8zOI3ceDv8XrX+TZTkbjQof/c4FMwIo0wSTaR21tBOOA+sbRVzNtIr4+z/AToxPUi5MI9wiQPyLIon749QhyUU3wYFjsyzhcl1l23+3ybtY+arXLx5e0EfmFO1CMdpsI/bswqgitOtDlWE3TThVKNYyAkf1MG9Hrm6YR+4GqYG5wYMJFSJrnFqx6X71Zy5XULBMzsMiCFq2+UIkQqBHhexymfbMq3L8HyqQfDVL2JVk01cFB5/iZrzcvFsoyX7uDXyfiqXWw/aTNAVOArweXDxogMC9EIwAvShY8x2I+mbgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9uhGkyMhIyqtNafox95No2suV904WSXc7jq9f+yxMNE=;
 b=etnSAiTYikVRnMzuA2caFceIt0v6nSo2vj0Yuiw9i25hgLes64rIBn5FST9Uc5nDAmNEDdJIXcl+fckmUIRFsVDuyT7BWZDQpVf6MnOyAcs9s0TA8r5KSc8IU1RebMyVzn1mKGLwQMPfI5Csl7WX2oEccNnWWIuP7WTh6J0fyzjgoS9wyYMQisOhQorqAoQkpBW40x6wyINlX0sse+14+N4k+0Uwp7V6/wQQcfp0rC8EpjkyG1rb1Ofh5blkzJrsty0Na1jM1e//A38lKkLeCSvhchMRJo0dGUsMNgbYw+CeN3NWMPfOY0Jq2056tm0WJys8gOogJcRYUHlgQjJMOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uhGkyMhIyqtNafox95No2suV904WSXc7jq9f+yxMNE=;
 b=sH1XoOdOx0pmNKmo4bxhe3W9XflNDrv/rShmI25MpIyBRUh9rlIZH19B6ms5lR+Ayr5UU9AEcusJZWP2ixxD/pjg2475M+k/TuBlWwhzmpMqAWRoVgfEmp/HqwlSo97tvyDfE2lKimzIM/XSlSC1vRHtM+NGcl3BFCj5kkguNIQ=
Received: from PA7P264CA0433.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:37d::17)
 by VI0PR03MB10781.eurprd03.prod.outlook.com (2603:10a6:800:26c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Fri, 27 Jun
 2025 08:01:09 +0000
Received: from AMS1EPF0000003F.eurprd04.prod.outlook.com
 (2603:10a6:102:37d:cafe::ed) by PA7P264CA0433.outlook.office365.com
 (2603:10a6:102:37d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.23 via Frontend Transport; Fri,
 27 Jun 2025 08:01:09 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS1EPF0000003F.mail.protection.outlook.com (10.167.16.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 08:01:09 +0000
Received: from N9W6SW14.arri.de (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Fri, 27 Jun
 2025 10:01:09 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 6/9] mesh: node_add_pending_local: use concrete type
Date: Fri, 27 Jun 2025 09:59:25 +0200
Message-ID: <20250627075928.19788-6-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250627075928.19788-1-ceggers@arri.de>
References: <20250627075928.19788-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000003F:EE_|VI0PR03MB10781:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ff1303a-9db9-4a2b-72bc-08ddb550c70e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6CBfQi8hCkhH1GYH/GtH6FOyYxFUNH4Y3FJtVZa+etM1oJxFc0Rsz4WyrfVc?=
 =?us-ascii?Q?qrL6kqrD8P6bKrHhiH5219mnGVm/QlK1una/9gc7mgc/F1YSofLhInzL7Ss6?=
 =?us-ascii?Q?5mlnZ6Hs+ElOFY3bOU5N4y1f1dXsRlFesVPRq1kgSy9B8J+W5x6ZlIXIwoNc?=
 =?us-ascii?Q?AzwKxM0At3fWZuAIhSbWEvelz/iZpG8Uo9NIAqXLp3wbJYA7jjqKwk2g1O9L?=
 =?us-ascii?Q?eEpwj6CcYNec410WLUI/eHy6Nq0NXkpv/2L+fJxffcPzDSnjbjmwX/8izpXL?=
 =?us-ascii?Q?sc8xsuds49owf5/WXBoO753pZyC8wslKi1pxreYYei58Ipyjm0+2+xZ5rxQY?=
 =?us-ascii?Q?f//8mB47s5KkQ2Lt5ic49CT4xddixK5PnBpU1ZHgZHnHGtfe4WWFe4QIVewx?=
 =?us-ascii?Q?KmbC3m42l+olwkpBfUb6wcVF+gSf+5QPo1mgkl3XkGOisIxd1GfD33KygYOh?=
 =?us-ascii?Q?Jsx9kyED8uCkmhr/PPnq+hnfBDKfYzx+qLhSKS2cMNI8gvFX6pK1ci8G8Woe?=
 =?us-ascii?Q?KkMlAB//jFr8eITv6nrynYVpXQMSPX+kJc9+TNY2M8++8IOiuXl2OIxpiaaP?=
 =?us-ascii?Q?lOqYbQLU8FQWLQRpdQNsu/afb/YZmeX2AYEEaVE9AkYkgCLHmT3/kbzUlUOw?=
 =?us-ascii?Q?FmXkCrNeaHc5kwNqHoqAuJU9rUtw/jV1/qzDlqPlH2VSwGZlBnziis6kIVFy?=
 =?us-ascii?Q?hlFGwXqHr5w6Y+qLwz7dPlnWLKyRA/kgjG4iXRX6rtlcAmD4xeKsAK+R7+/G?=
 =?us-ascii?Q?o9IMQbx3SLdAZJ9SGp12yEqL5FlNHcMyA4XVvzb6gSGECarx0jOIRPXq1p6B?=
 =?us-ascii?Q?Hz1+UOFCioA6sghOL7vW+2c5IJDlwzYoPHLjNINHF8kAMiFR6juG44xz/26H?=
 =?us-ascii?Q?alBjjsOKMxlBpLqFWhIkRMsaf4qbsoN8Ngbfw9alUqO8eKU2XwHIJmwv39us?=
 =?us-ascii?Q?I7skltHBmkCHMdJQ2mKG03AZThmdcWouKVN2HKvZ/l4knzQqqOSW854XjTzt?=
 =?us-ascii?Q?Qu9yB9QqlsyH4WkNdcMOM8nzZKhJki0y/A3NcizMg4hxO4p3GK3uIp5pBekU?=
 =?us-ascii?Q?qFRKubbof2X+nKOUq68GqWvGQOZxTwdSHhmAKXqyopHFw4nnA6RelHQwdwZ4?=
 =?us-ascii?Q?lU6By8kOy4cdO1PFkd0BQMTmE185ivHRhMXwa9Wp7d11NrtRGACUtiAabD7Q?=
 =?us-ascii?Q?mIfhsjbZf11iZx+YBWRebnbp5qYMNxqfJ7X4mW84YUoTXHnpNAZ8oqtD9Ew5?=
 =?us-ascii?Q?nEcsYqCcDZaz48SU9G/0SYPqm62ACbm5yO91yGXwkhBXSSDgL1WBcV62GEnx?=
 =?us-ascii?Q?y6+PEc9luox7guDsdkLzrVjT0AT6iao5AJlDp0OZ59gLMjBPBoEQZrlLmidC?=
 =?us-ascii?Q?5PP8aKXr05AGjY0jJZ/joE5wWFCIrZPdv4AbLsqKRTqNvWU3lm81wYg1YoHE?=
 =?us-ascii?Q?pvA3YenbPM61qRmGmHomhqw5QDCMQdfrMUTn2bM0JOzCRifsTgsBz2VbFiXV?=
 =?us-ascii?Q?x1Vvly360x0bftNQ7I6og195L3pmBXnLhAyt?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 08:01:09.7728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff1303a-9db9-4a2b-72bc-08ddb550c70e
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000003F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR03MB10781

No need for using a void pointer here. Add const qualifier to passed
mesh_prov_node_info.
---
 mesh/manager.c       | 2 +-
 mesh/mesh.c          | 2 +-
 mesh/node.c          | 9 +++++----
 mesh/node.h          | 4 +++-
 mesh/provision.h     | 4 ++--
 mesh/remprv-server.c | 2 +-
 6 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/mesh/manager.c b/mesh/manager.c
index 63551b4ee4c7..3786f7a8f4cd 100644
--- a/mesh/manager.c
+++ b/mesh/manager.c
@@ -177,7 +177,7 @@ static void send_add_failed(const char *owner, const char *path,
 }
 
 static bool add_cmplt(void *user_data, uint8_t status,
-					struct mesh_prov_node_info *info)
+					const struct mesh_prov_node_info *info)
 {
 	struct prov_remote_data *pending = user_data;
 	struct mesh_node *node = pending->node;
diff --git a/mesh/mesh.c b/mesh/mesh.c
index 50059adbed57..354aabaf388e 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -455,7 +455,7 @@ static void prov_join_complete_reply_cb(struct l_dbus_message *msg,
 }
 
 static bool prov_complete_cb(void *user_data, uint8_t status,
-					struct mesh_prov_node_info *info)
+					const struct mesh_prov_node_info *info)
 {
 	struct l_dbus *dbus = dbus_get_bus();
 	struct l_dbus_message *msg;
diff --git a/mesh/node.c b/mesh/node.c
index a85814727d40..65161b7afb3d 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -1412,8 +1412,9 @@ static void save_pages(void *data, void *user_data)
 }
 
 static bool add_local_node(struct mesh_node *node, uint16_t unicast, bool kr,
-				bool ivu, uint32_t iv_idx, uint8_t dev_key[16],
-				uint16_t net_key_idx, uint8_t net_key[16])
+				bool ivu, uint32_t iv_idx,
+				const uint8_t dev_key[16],
+				uint16_t net_key_idx, const uint8_t net_key[16])
 {
 	if (!nodes)
 		nodes = l_queue_new();
@@ -2493,9 +2494,9 @@ const char *node_get_element_path(struct mesh_node *node, uint8_t ele_idx)
 	return ele->path;
 }
 
-bool node_add_pending_local(struct mesh_node *node, void *prov_node_info)
+bool node_add_pending_local(struct mesh_node *node,
+					const struct mesh_prov_node_info *info)
 {
-	struct mesh_prov_node_info *info = prov_node_info;
 	bool kr = !!(info->flags & PROV_FLAG_KR);
 	bool ivu = !!(info->flags & PROV_FLAG_IVU);
 
diff --git a/mesh/node.h b/mesh/node.h
index 4f31c5056dfd..cba51cb93bbb 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -14,6 +14,7 @@ struct mesh_io;
 struct mesh_agent;
 struct mesh_config;
 struct mesh_config_node;
+struct mesh_prov_node_info;
 
 typedef void (*node_ready_func_t) (void *user_data, int status,
 							struct mesh_node *node);
@@ -71,7 +72,8 @@ uint8_t node_friend_mode_get(struct mesh_node *node);
 const char *node_get_element_path(struct mesh_node *node, uint8_t ele_idx);
 const char *node_get_owner(struct mesh_node *node);
 const char *node_get_app_path(struct mesh_node *node);
-bool node_add_pending_local(struct mesh_node *node, void *info);
+bool node_add_pending_local(struct mesh_node *node,
+					const struct mesh_prov_node_info *info);
 void node_attach_io_all(struct mesh_io *io);
 void node_attach_io(struct mesh_node *node, struct mesh_io *io);
 void node_attach(const char *app_root, const char *sender, uint64_t token,
diff --git a/mesh/provision.h b/mesh/provision.h
index cfeb6debab53..3982c8703882 100644
--- a/mesh/provision.h
+++ b/mesh/provision.h
@@ -91,7 +91,7 @@ struct mesh_prov_node_info {
 
 typedef bool (*mesh_prov_acceptor_complete_func_t)(void *user_data,
 					uint8_t status,
-					struct mesh_prov_node_info *info);
+					const struct mesh_prov_node_info *info);
 
 typedef void (*mesh_prov_initiator_start_func_t)(void *user_data, int err);
 
@@ -100,7 +100,7 @@ typedef bool (*mesh_prov_initiator_data_req_func_t)(void *user_data,
 
 typedef bool (*mesh_prov_initiator_complete_func_t)(void *user_data,
 					uint8_t status,
-					struct mesh_prov_node_info *info);
+					const struct mesh_prov_node_info *info);
 
 typedef void (*mesh_prov_initiator_scan_result_t)(void *user_data,
 					uint16_t server, bool extended,
diff --git a/mesh/remprv-server.c b/mesh/remprv-server.c
index 53c764f8626a..20a3da343b26 100644
--- a/mesh/remprv-server.c
+++ b/mesh/remprv-server.c
@@ -514,7 +514,7 @@ bool register_nppi_acceptor(mesh_prov_open_func_t open_cb,
 }
 
 static bool nppi_cmplt(void *user_data, uint8_t status,
-					struct mesh_prov_node_info *info)
+					const struct mesh_prov_node_info *info)
 {
 	struct rem_prov_data *prov = user_data;
 
-- 
2.43.0

