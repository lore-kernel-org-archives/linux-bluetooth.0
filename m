Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011055.outbound.protection.outlook.com [52.101.70.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61021231826
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 07:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751011117; cv=fail; b=m8ae6G2N6oEMUwWrdAwlqE2P+hh9c7P6MfwbB+ia+SNRUX3EZj6tGxNrXr3JX0wSqa3bbWzl7YHqE8NY1UOIRxQHd5IaYLJLYMVvPeGUMPidL/bBXSs+XUsqDCUMij5Ae2obgoxktU6WcjCZMZ4Y+mzE0pR6I2c7E2fC7ktuPU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751011117; c=relaxed/simple;
	bh=R8yAttsIxtR4Pwf6Jk3w9pNN04RMGjABLLvdpNhNdns=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fd/yaUxj85CJYKw1hGKMHGY4UMsjkB2ngc5LTVilQa6g5GtichkeITfirrBLx0T0U9Z6quI1ZiSniDOdYEHDO7CWzMG67psRnGfD5BjpidE0LPi67zPFz1FwR8OvQO8tG1O77R2Gj2j+xF4xnLEIFyp8LlbIlm9fkP4icBgCsNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=mBZb7/6i; arc=fail smtp.client-ip=52.101.70.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="mBZb7/6i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qVqKjMdcU5hMnbn+4Qx9y7p5Ulh5svJf7MMUJx48pupP/PRAcDiG0IjZWBMz7i9qRZ5+iHBRjqdvFK2itA1l4MEQlxtosXrOW4hWLEy+8kbf6d5JP82pR4/krDXv4/4/C7eWkTLsw8VJq8xhWvxk8ZVIgnbicJVaaEEaFd9f5AAacXOyR/L34ZanwYezkw5GG5MnD26CtZyJg6cxW2qZlLj3FZwm2QG6zJnGTtTPPJqsNISXYCClOfzjnDU/qqJlHZyfnmRf6dG8lx6YXirTv1f8MGS6hErBa34OnXhlN9ZdoWgKAEzUHOxf+t/rVyf4FJznJO4SI2HR1urSfys29Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKinErMHI8Ulen8+HwY+PF0NUHGieg6E4YwZuRTTvpE=;
 b=E4XCd1Fna/hr7UuNQaKxaZGNZ2l7eWtFJws4Fx2kEi0QnieNSxW3VMoPuxdAqauCxFkAMp39NGsq+MUMaqeN6gR0+9tJuxeN2bRiRxpc2OJrE8DQTY4OLqpwdDh+hYx0O/APeOuaBl6fTntAUiJ7RkMtNL7DaREO6kSqmYXBcMvXhnNM9B6tAxXB7aSjuX+f+im3QAhUeAXP818ohxZrekYiF3X0K37vlJ+62FlveMdAtNDJdJ5WDWdn8pYQBIHJgm0dOP7zgOjlasImBQr1gMKasJE6g+Ko1PEajgrSGyyKFM7/a/G58nsZGq2ywfY9epfDb31g6loGnBWeNOnlGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKinErMHI8Ulen8+HwY+PF0NUHGieg6E4YwZuRTTvpE=;
 b=mBZb7/6iwXtaIOYFW/VNF/A7tQhlTFB9VBMOA5q9qQPrJD/2KF9ymksa9ipnaJHmDbGqsR6TYY4zB1DlW30TjXlIsn9SknIbRIKRGn5kVcVu3RrOuP5KfCZsSdul5IpJkrpsOg/GTLAor+wUYEy8h1lauh1fzb/dbU5rYbHv7Q0=
Received: from PA7P264CA0248.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:371::14)
 by DB4PR03MB9604.eurprd03.prod.outlook.com (2603:10a6:10:3f0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Fri, 27 Jun
 2025 07:58:29 +0000
Received: from AMS1EPF00000040.eurprd04.prod.outlook.com
 (2603:10a6:102:371:cafe::f1) by PA7P264CA0248.outlook.office365.com
 (2603:10a6:102:371::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.23 via Frontend Transport; Fri,
 27 Jun 2025 07:58:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS1EPF00000040.mail.protection.outlook.com (10.167.16.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 07:58:26 +0000
Received: from N9W6SW14.arri.de (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Fri, 27 Jun
 2025 09:58:26 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 3/9] mesh: mesh-config: constify
Date: Fri, 27 Jun 2025 09:57:59 +0200
Message-ID: <20250627075805.19597-3-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250627075805.19597-1-ceggers@arri.de>
References: <20250627075805.19597-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000040:EE_|DB4PR03MB9604:EE_
X-MS-Office365-Filtering-Correlation-Id: 79d15bed-6b34-4449-0788-08ddb55065ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?owwA4YOermwlS80XtXoPrF/i2c5rSLjMaPRpa7o2RefMggnIHveQOCqaXmBD?=
 =?us-ascii?Q?B9XYIgN8VxDKTr8yQya40uh3ZV8FQBeS36Lunq7ZGm6mGkLmVRuC2uRd6D7f?=
 =?us-ascii?Q?uEBcrsiN4qrDrCBUKY6FhtpQ7YWJewQnFyQ2b76ZOoYAfXKgHQFpDyykaGrP?=
 =?us-ascii?Q?2BTkYQWrf5qTu3a6NLPLW5BvlHCihJNCcjXzPkxpRaHQyyvgQY01z20w6IVK?=
 =?us-ascii?Q?wiRG0AvnE5/NrEqoTKbglxb143FcaKKAkPV01Dkna1hT9sOL8zgWYMM7K1hD?=
 =?us-ascii?Q?Whx99YoHux4TxzH3Tw9z9ZXKhMaQjAk7CFberlyLnBtfiJYSNT8xEeSNa8lE?=
 =?us-ascii?Q?T87s8P+WL5p8eZptN0NliP1T7dEhq/5s4yLEhnzJknz3YG+VYlcPpydpzPnE?=
 =?us-ascii?Q?AoZJMfn8uZcnrcINcTxM5MU8R+VGnFQaO9F9sXGTPQbBDgHNlSc3xAb9Q2TN?=
 =?us-ascii?Q?AiiU8osZQG83OcokCO5MOe6PSjw8c7iiUCmCYSinQ+TiLY1fslhnilV/Wpg/?=
 =?us-ascii?Q?eHqHzNjFt64BZGR0hTenMg2F6nDlYQ74DhJI/X0tU59kXPttq2uJx2HK6Dfk?=
 =?us-ascii?Q?6STGt0mZCirO5AhDI2ROWxqnHvh1MBqg4P5YdqUYdSAG9oY2PDEXkdf8XQVx?=
 =?us-ascii?Q?GzCrZnozzHxMjGFFcfofQjoPMj5AdmyZvJws4QdR8ZccRWR6S+mcRSfs9Vny?=
 =?us-ascii?Q?1lnRUEiZeos/QmzSnoZxQ83ohabLuuUsQ8hQfDOREG6hrHOn+yOZdEclR+C9?=
 =?us-ascii?Q?byv5yjjrDunhQJ4cYk9ed2Vv4ZWhOhv6UqnXEuebotWpp+KXNv+MWHz1+P9D?=
 =?us-ascii?Q?8DxRIO9Dcbga1E1ApqmdIcKTTId95AU/nM0S07LMzUTZQkCYzpYQT2W3/eEk?=
 =?us-ascii?Q?fESTt7Q6SexkV9rsM0QrOzazfKnnbn02Ts2BNblPJbd5JJ0ku+joCes1gszr?=
 =?us-ascii?Q?v+aWfAqqMievzqWgrnWBGdABSA/Z5UIWJdMiHjc61vgdlD5nlNSeIn7IRUaN?=
 =?us-ascii?Q?pzI9Tf6gT7PCBXMZUNnn3fcegVfN/bFft3GvoS/wIi8/geHzJcYAQjylptQf?=
 =?us-ascii?Q?l7T3EPlk/p2mnD/pbIlNPYwoC5fJLD9f3y85dZCY7FVAZ+ZVw5Gnie0l3kJq?=
 =?us-ascii?Q?nJEaRbMOk0HGwNzGMulGcKQ0prUAiI+mFFp1IswLil1Wf/I2xHVgF8F5AmOU?=
 =?us-ascii?Q?hl54bzEPbILoJWjigO1eoxookqv2GXmSc/sbfKeNU0POBuPLQTneBu+dv7nJ?=
 =?us-ascii?Q?R4SC6/tshxqHwTYB1Jtu0cJwtyNbZr6fg18ZbGLrDZEQ1+9GVgbv5aa7BV+K?=
 =?us-ascii?Q?OyX2xePSVBJfGmauvvrTdcJm9d4hj6p69JYLrDviqyMKyAPlOphoEiY6oNvS?=
 =?us-ascii?Q?PaiA62xNEnHzmMg1yTiGQnHIG3CQki6blInZglB426tLHb/tTF0k3T4rH8eq?=
 =?us-ascii?Q?YRvZohO9YMgmIKIvherghwhytx/7TSzIBv6jqeb4jeFTPLNtnYbQUSAn18yb?=
 =?us-ascii?Q?LPyuRJNCXgplGHDQZY1xoe959R8j3QipeY4J?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 07:58:26.6633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d15bed-6b34-4449-0788-08ddb55065ef
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000040.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR03MB9604

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

