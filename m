Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011027.outbound.protection.outlook.com [40.107.130.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB3E229B18
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 08:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751011211; cv=fail; b=D8S6m+6FHoaIZAnbgYQczUA+J9/Z1LeQasAMSaUQdwzxELxs3vFOxZnsFhbdcD2fD2smqSQm0TihZxGQrxAPnL8MbGZVbKPMGIJqh37HdwcfLhoFERcbSkEwqtIQsWaWF8r3rXZfm02B8PK7GidQdDlQU4yVsFu9UOmLGsy8JWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751011211; c=relaxed/simple;
	bh=R8yAttsIxtR4Pwf6Jk3w9pNN04RMGjABLLvdpNhNdns=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iQ/Qot03HAHY7agl5DL32ruZ4uJi/pvjjx3J9Bxbw6dbt4l7i2YAf5ltF4EL//a41KyyirxFFq2W/IL9dcHIzT+2PYT90jiJRgxGjNFv8LvG30J4Fb78v2vXbgPRjOsgxE36cFGfIAqJJM6TIx6tYa/dAJhQzlQps2elYc0NzJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=PzIMHpyN; arc=fail smtp.client-ip=40.107.130.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="PzIMHpyN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2NX7J3dUVOiPH1nNVNjuAH8SAJp5wyW8qLre/0gxMe2He+ZLUA7C63GxiOJQ8kFMfAC6Offw7agE/8QLK+CSPciQBKOAAmnNiCrLmuW7Hc7kFWYi9p9wXKapA8FRcmaOu0UzoVBVNwMdnRt00VtF4RAbMIyv+6GyOpjyvencLESMggif5kmHRpJE8g2vnP5lbZH6Rw2uOklAQht02HI7YMqcY4YkZGy7NCev8lj7IwvcjvF6hWKASXqFcByt6k3y8NjAlUMaVunDDnZY1bMtxk+ssr7+lsCokIrTQtWgUJR2o+0Uqz4x7kUdJXRaavUahM2juU9Kmr0T0L4O0Hb1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKinErMHI8Ulen8+HwY+PF0NUHGieg6E4YwZuRTTvpE=;
 b=Ysed8hSsrlAuxy6dDy36H0SGm/Hs52Quj6LBNq4QRHVeeY7/ecskA6hF0zcwLSy5Eg7D60TkduMQpgT1xQQLIaxisWVIrQidksklNggT2rXQpn66nfIH1zVANbgUGYlOS+ZElnN9gkpfcXJlDkLhiRAPBYWhWDEVNtja/Ei2q/IpRy8iau0HtZX/Vw7RYwLfckrG94kgMxez4DRWzz31bDA0ggtdw0vU9OJwuMo1eRQgiU544RwdiI1cdZHHqzSRnqsUPw/+MFZCkJDE5nVztU9R4IrMYEvjc0GqMzmysNeWRNrig3ayH7SZ36rHwIBRwBp63hKS3JomtbbZNVWb4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKinErMHI8Ulen8+HwY+PF0NUHGieg6E4YwZuRTTvpE=;
 b=PzIMHpyNds7IwYMoK+z1iGQumuWGu9TeaMfc1kdg55ZsckmSJAr4OsPTISIaoy/+kLJrZx5qzU6Xqyr1R9lygswskTCgWkEIoYixQ5LDUUMs+f4UOx2JCYAcWeMieEYWP+1m49J+D4o20RG/B5Fk+OrK5iHopBDif/oUVpLnd10=
Received: from CWLP123CA0174.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19b::20)
 by DU0PR03MB9867.eurprd03.prod.outlook.com (2603:10a6:10:400::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Fri, 27 Jun
 2025 08:00:04 +0000
Received: from AMS1EPF00000042.eurprd04.prod.outlook.com
 (2603:10a6:400:19b:cafe::ad) by CWLP123CA0174.outlook.office365.com
 (2603:10a6:400:19b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.16 via Frontend Transport; Fri,
 27 Jun 2025 08:00:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS1EPF00000042.mail.protection.outlook.com (10.167.16.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 08:00:03 +0000
Received: from N9W6SW14.arri.de (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Fri, 27 Jun
 2025 10:00:03 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 3/9] mesh: mesh-config: constify
Date: Fri, 27 Jun 2025 09:59:22 +0200
Message-ID: <20250627075928.19788-3-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000042:EE_|DU0PR03MB9867:EE_
X-MS-Office365-Filtering-Correlation-Id: a61899ec-f6c9-40ef-1ec6-08ddb5509fc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W6Do1bUcYM9yGcK3W+S3bKOKugOOvQFfkcVM9jfIWjEYqzoWbZyFUVTYdYTr?=
 =?us-ascii?Q?j4giWQW2xXRuFeAeAfzeTLat87Jg6NSV1JZRkG1ZsEJmRDVvgRSzX+Y9u6nk?=
 =?us-ascii?Q?ebD4+jzW143ZxlcFdsUASymuhlif7Sydzim1w9LMJL8YcaFBpHYjgRbOJHn/?=
 =?us-ascii?Q?l0g5BjeAhOyZm2fT1pCkVD8zvGO8DtZGyo/2ZFfEgu6Q5Df6uG2PeLO/4c+G?=
 =?us-ascii?Q?1z8nFATczjrHPRl90JhA5X/qTZY/Ioy3P/PBM8ZdRBpKfvnIbjPIQzOkXu98?=
 =?us-ascii?Q?lqDfNLnl56QUeqgTcMJga6juILQ8/V9nxxQcVW6fgiYjNhuE+ltjihf/rn9k?=
 =?us-ascii?Q?zhfItFaKNz92N8Si09dj1+IKZdtCPxEDWY54S3D0q5PNwzM67DTN847zN3ca?=
 =?us-ascii?Q?SEDpak424pT1FfdgnGE/redadwwTVad4QpeQYLfi0PNuvhMr1+nS9r3pJeTe?=
 =?us-ascii?Q?Hy/IetLkJGZslxLCUBW8Uy6DC7FhnNQG6KF3uS/p1ksKPGr3KGJx+W1IIHGg?=
 =?us-ascii?Q?VaNSCg5LwbG8A0a1/3WDt6Eaemo6DY1UtgMcM2cIdj4ptzkCbj+pmxcncpNQ?=
 =?us-ascii?Q?Ox7970tkwpNrIXXGP0yji5p3AHGkms6oDUgLQ3NeJFBnYNGGUWkHQnGQQwDM?=
 =?us-ascii?Q?MuspNq+bTt/qKxuxmH/IPYaJsO9r5OthrOgjgBh+Y5UwuYvUjJLIDIhJwpsc?=
 =?us-ascii?Q?Zu4RhJoIVGG+skC+ysGoaT/E7f/f39fWss2wHuaDgdktb3LGTiIglcyKIXqQ?=
 =?us-ascii?Q?+tvqRmhWLZfHOQZEIkS9CpKjVvj1/9aI3Y2ge0SCS34eo0J0GBeEx6vanJSN?=
 =?us-ascii?Q?9VEqLO6Ci9Y1UREZMxPGb80MK52/Am8rF4cNJUINI8iBVXZwENYGtjUAj+GH?=
 =?us-ascii?Q?0H3/IaixI9xHdtQoK5Hj+HACo5+N2l9gH05Ktk20+726UcAl8PwfgStWT81S?=
 =?us-ascii?Q?qinZA8uNKPMSXO3ztGCgzqfEeYWI9ldQoofaTvtdNfvyn5OyEdk2JvvGu+v3?=
 =?us-ascii?Q?jT1l/seBwl4FNiZXYLeBeGO3vi3OVTNXcepe/hB/1u6GCtvJtwnGBnvGgcLQ?=
 =?us-ascii?Q?VfVzEmssZDCzYAYfF4JcX7F0jigRk0ecrk+husevcw91RK8txvmhAzrgpdb3?=
 =?us-ascii?Q?PofjgLrF02C2WlZtGdKQA+bU3XPH//xoXvfRjFA7xkzBxwb2lioTatp+MeKY?=
 =?us-ascii?Q?oSzkJNBkdWrwrvoQSz5bQE9tYtAWAMLxWh/dpj8/Li75Eyn6GMQ1xosYAtDW?=
 =?us-ascii?Q?I0w+4vblv2jiTafwNOu0s/0j36E6+2M3nqbdlHnxiovP5578/E8Q2Z3OlvlO?=
 =?us-ascii?Q?GL2HQiiJdM51IjJRG/699cZ4aNoiiaP04ngNFWfded0jNGB8LAgvNBQ1I5SY?=
 =?us-ascii?Q?XEzIsiCe+COQADwnJBy038CgcpMlwcwzBv/p0dLk+RnhtZkXgwld+mhvhjnt?=
 =?us-ascii?Q?KMc8j4vVPtooKt8cqXKzJQr+jZn57PQ7hNXHz4UezcdE5gts4PLtgA/hkElu?=
 =?us-ascii?Q?gRaGkU+AZBffLjCp8jFCKBtluhj5rzHAHII9?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 08:00:03.8243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a61899ec-f6c9-40ef-1ec6-08ddb5509fc0
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000042.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9867

removing 2 prototypes where an implementation never existed
---
 mesh/mesh-config-json.c | 14 +++++++-------
 mesh/mesh-config.h      | 20 ++++++++------------
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index 86e7d87e482e..5ad4d832a05a 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -739,7 +739,7 @@ bool mesh_config_net_key_del(struct mesh_config *cfg, uint16_t idx)
 	return save_config(jnode, cfg->node_dir_path);
 }
 
-bool mesh_config_write_device_key(struct mesh_config *cfg, uint8_t *key)
+bool mesh_config_write_device_key(struct mesh_config *cfg, const uint8_t *key)
 {
 	if (!cfg || !add_key_value(cfg->jnode, deviceKey, key))
 		return false;
@@ -747,7 +747,7 @@ bool mesh_config_write_device_key(struct mesh_config *cfg, uint8_t *key)
 	return save_config(cfg->jnode, cfg->node_dir_path);
 }
 
-bool mesh_config_write_candidate(struct mesh_config *cfg, uint8_t *key)
+bool mesh_config_write_candidate(struct mesh_config *cfg, const uint8_t *key)
 {
 	if (!cfg || !add_key_value(cfg->jnode, deviceCan, key))
 		return false;
@@ -782,7 +782,7 @@ bool mesh_config_finalize_candidate(struct mesh_config *cfg)
 	return save_config(cfg->jnode, cfg->node_dir_path);
 }
 
-bool mesh_config_write_token(struct mesh_config *cfg, uint8_t *token)
+bool mesh_config_write_token(struct mesh_config *cfg, const uint8_t *token)
 {
 	if (!cfg || !add_u64_value(cfg->jnode, "token", token))
 		return false;
@@ -2005,7 +2005,7 @@ bool mesh_config_net_key_set_phase(struct mesh_config *cfg, uint16_t idx,
 
 bool mesh_config_model_pub_add(struct mesh_config *cfg, uint16_t ele_addr,
 					uint32_t mod_id, bool vendor,
-					struct mesh_config_pub *pub)
+					const struct mesh_config_pub *pub)
 {
 	json_object *jnode, *jmodel, *jpub, *jrtx;
 	bool res;
@@ -2146,7 +2146,7 @@ void mesh_config_comp_page_del(struct mesh_config *cfg, uint8_t page)
 }
 
 bool mesh_config_comp_page_add(struct mesh_config *cfg, uint8_t page,
-						uint8_t *data, uint16_t size)
+					const uint8_t *data, uint16_t size)
 {
 	json_object *jnode, *jstring, *jarray = NULL;
 	char *buf;
@@ -2187,7 +2187,7 @@ bool mesh_config_comp_page_add(struct mesh_config *cfg, uint8_t page,
 
 bool mesh_config_model_sub_add(struct mesh_config *cfg, uint16_t ele_addr,
 						uint32_t mod_id, bool vendor,
-						struct mesh_config_sub *sub)
+					const struct mesh_config_sub *sub)
 {
 	json_object *jnode, *jmodel, *jstring, *jarray = NULL;
 	int ele_idx, len;
@@ -2239,7 +2239,7 @@ bool mesh_config_model_sub_add(struct mesh_config *cfg, uint16_t ele_addr,
 
 bool mesh_config_model_sub_del(struct mesh_config *cfg, uint16_t ele_addr,
 						uint32_t mod_id, bool vendor,
-						struct mesh_config_sub *sub)
+					const struct mesh_config_sub *sub)
 {
 	json_object *jnode, *jmodel, *jarray;
 	char buf[33];
diff --git a/mesh/mesh-config.h b/mesh/mesh-config.h
index 3cb20b85d5c3..b320116fa8dc 100644
--- a/mesh/mesh-config.h
+++ b/mesh/mesh-config.h
@@ -128,15 +128,11 @@ struct mesh_config *mesh_config_create(const char *cfgdir_name,
 
 bool mesh_config_write_net_transmit(struct mesh_config *cfg, uint8_t cnt,
 							uint16_t interval);
-bool mesh_config_write_device_key(struct mesh_config *cfg, uint8_t *key);
-bool mesh_config_write_candidate(struct mesh_config *cfg, uint8_t *key);
+bool mesh_config_write_device_key(struct mesh_config *cfg, const uint8_t *key);
+bool mesh_config_write_candidate(struct mesh_config *cfg, const uint8_t *key);
 bool mesh_config_read_candidate(struct mesh_config *cfg, uint8_t *key);
 bool mesh_config_finalize_candidate(struct mesh_config *cfg);
-bool mesh_config_write_token(struct mesh_config *cfg, uint8_t *token);
-bool mesh_config_write_network_key(struct mesh_config *cfg, uint16_t idx,
-				uint8_t *key, uint8_t *new_key, int phase);
-bool mesh_config_write_app_key(struct mesh_config *cfg, uint16_t net_idx,
-			uint16_t app_idx, uint8_t *key, uint8_t *new_key);
+bool mesh_config_write_token(struct mesh_config *cfg, const uint8_t *token);
 bool mesh_config_write_seq_number(struct mesh_config *cfg, uint32_t seq,
 								bool cache);
 bool mesh_config_write_unicast(struct mesh_config *cfg, uint16_t unicast);
@@ -150,7 +146,7 @@ bool mesh_config_write_mode(struct mesh_config *cfg, const char *keyword,
 bool mesh_config_write_mode_ex(struct mesh_config *cfg, const char *keyword,
 							int value, bool save);
 bool mesh_config_comp_page_add(struct mesh_config *cfg, uint8_t page,
-						uint8_t *data, uint16_t size);
+					const uint8_t *data, uint16_t size);
 void mesh_config_comp_page_del(struct mesh_config *cfg, uint8_t page);
 bool mesh_config_model_binding_add(struct mesh_config *cfg, uint16_t ele_addr,
 						uint32_t mod_id, bool vendor,
@@ -159,16 +155,16 @@ bool mesh_config_model_binding_del(struct mesh_config *cfg, uint16_t ele_addr,
 						uint32_t mod_id, bool vendor,
 							uint16_t app_idx);
 bool mesh_config_model_pub_add(struct mesh_config *cfg, uint16_t ele_addr,
-						uint32_t mod_id, bool vendor,
-						struct mesh_config_pub *pub);
+					uint32_t mod_id, bool vendor,
+					const struct mesh_config_pub *pub);
 bool mesh_config_model_pub_del(struct mesh_config *cfg, uint16_t ele_addr,
 						uint32_t mod_id, bool vendor);
 bool mesh_config_model_sub_add(struct mesh_config *cfg, uint16_t ele_addr,
 						uint32_t mod_id, bool vendor,
-						struct mesh_config_sub *sub);
+					const struct mesh_config_sub *sub);
 bool mesh_config_model_sub_del(struct mesh_config *cfg, uint16_t ele_addr,
 						uint32_t mod_id, bool vendor,
-						struct mesh_config_sub *sub);
+					const struct mesh_config_sub *sub);
 bool mesh_config_model_sub_del_all(struct mesh_config *cfg, uint16_t ele_addr,
 						uint32_t mod_id, bool vendor);
 bool mesh_config_model_pub_enable(struct mesh_config *cfg, uint16_t ele_addr,
-- 
2.43.0

