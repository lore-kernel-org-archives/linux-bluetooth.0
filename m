Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011023.outbound.protection.outlook.com [52.101.65.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF5E2550D2
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 13:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751979888; cv=fail; b=UksdoKhBsAtBH31m+smB2RA+DAwG1MeTFl9bDWiIt41ZDSWNR52RGlcGYjX4YGP15h6CxZDmshVEOYUK9t5eZTGSYJeC1M7TSayMFhdmq3WUbwdYbqef+DJ/D7fRj0LKcBU+N3THDYGlS9+gE1svaXnjisSiKmUKO/m6F3mYjcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751979888; c=relaxed/simple;
	bh=1Nl3qrfvXfIz71u6q95dqz287MCViI86UKiHU2VNitk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IGWIZyduMFUd7HDbfkRkXdewRq4sq7X4DyifaymZFRd4dxJWPfLb7GWHr7+azBDGf3MHH3VdZG8JEnZCOUJDyIv3roGG7fPOSMOJxAmPoCGijxAgJcR3t4cW+9dT+2werhFrA6vTs3+IZmg5nrT+Fq5Ye967iKkWmuPBAXAYvh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=NUlbcjGE; arc=fail smtp.client-ip=52.101.65.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="NUlbcjGE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFP6j/EF9hfdFSRcSmZOogkQy+EMsuJGY31HxhYkjHrCzvD4fxZUYBsyKkJ6ZEYBWaKirbfm52NKU39Pn9InqKRYmtUrKzOcnd36C3h42wxFIe7eXdiDBbHeewY7eOKdCiyasJdEsCu324ZoyfdRivBcty7qeGhmNg7K5ZeWDmVuqLHBlKI6i5eZUHKCc/Xe67685FQiURa5W5jo3gtosAknHL+KA8aZaQJpwnVAN2fV/U82zu03kRIZdf9xyKD9QEarKrQwqxY9SGCqtgkjlah2wgbtxp9cZwCKPb9MP+2yLrTj58S4ZwaMwIeUkQ/N1rB7IXprhrJnIF87ni1HmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3n3u3JxqDMaWjBw+NOPOsfPy8XvwW1RCpQVUzs3toJE=;
 b=CyKCBL76NOfEERcuisIx2Vi0IAtSmBlLRzVNMQFgHrQ43I1McwkaVecArval6PdXjfUGuDdUONb4Yo3IS/coAxyDh7brRcRJ8DRk/d2XylI2BG99Jm6HezJtXDwyQybWRwRxYf0dg/LrX4JfNbBHYZeytALtT+kKXkx2Wfj9vwbQ4kQuvOkcavmLy19kXZXfmKd/zMiP+Jeafhsp2ZzmxHO34Uq5RQF1NOPWM7LaI51+ncH7DkCqVsqViYYrF1M8D9qKwUrT32TU7Utj7o0DgqrpSB5nj/wrQ82V6mI4pZikPzhc8fvNzKl24L+KVMkq8OytVOJLmvhyYyeNWPM5aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3n3u3JxqDMaWjBw+NOPOsfPy8XvwW1RCpQVUzs3toJE=;
 b=NUlbcjGEOrw6yyzlJULNYsuoEeMvtmZs1U5ZlBocbTxB+yB7/kQGMhsdVK6ocwrgLG3m0mfPkYErL8jSkhURz2ivNAG0P77TevJ0VuYJcBlop1IB8qMO0vt4aH2AtFIEvT+9qVkoDC5ncVSlKIQSR0R12AfQ5UvzavDbQf+y17I=
Received: from AS9PR06CA0399.eurprd06.prod.outlook.com (2603:10a6:20b:461::12)
 by DU0PR03MB9225.eurprd03.prod.outlook.com (2603:10a6:10:471::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Tue, 8 Jul
 2025 13:04:43 +0000
Received: from AM4PEPF00027A5F.eurprd04.prod.outlook.com
 (2603:10a6:20b:461:cafe::3e) by AS9PR06CA0399.outlook.office365.com
 (2603:10a6:20b:461::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.26 via Frontend Transport; Tue,
 8 Jul 2025 13:04:43 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM4PEPF00027A5F.mail.protection.outlook.com (10.167.16.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 13:04:43 +0000
Received: from N9W6SW14.arri.de (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Tue, 8 Jul
 2025 15:04:43 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 13/15] mesh: prov: cleanup header
Date: Tue, 8 Jul 2025 14:59:45 +0200
Message-ID: <20250708125947.11988-13-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A5F:EE_|DU0PR03MB9225:EE_
X-MS-Office365-Filtering-Correlation-Id: c2a44ece-42eb-4966-552e-08ddbe2001b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DRn4vbiOiC/KprsKLXR28E6BxZk/1JRKX6T06G3sgPTN8sSsDsy+2O/MHVHn?=
 =?us-ascii?Q?SJ638CItYEhUU2Jnm+SQVnAarJOw+OuTrBlu0anJXWGCe/ZGwraJ25xdu2w7?=
 =?us-ascii?Q?pwLEPpshtswRcIccwg0qv+gSk3Tu7cTcCw5i5Jt+cVYxBSh4hobYK9ErWsZx?=
 =?us-ascii?Q?Kmot+FP5qN4bzp29CnRoypgXoyKx+i2GLI4IPpiuLiVn2TGsXmDSJLq9Uoww?=
 =?us-ascii?Q?SmswJO7ai26KD3hKzWyejygIpSnhiMHDsvsf0XwOVjtHsVJNlOEPEgmxtApq?=
 =?us-ascii?Q?vf9pukzTlYi9E8iREgfnmzV5YkREUsxxyyfKUcJqwH6Z18bHHWl5YKYFLI2B?=
 =?us-ascii?Q?j1QJ69m1Ts3+YBjgsnr1N5N/b/ub3mJwgpLqz/U6f+5rgoIvxJSP8vshIKoS?=
 =?us-ascii?Q?+i3sxwBem2K8iLFFu6hP68kJpT+VpDQsI9KTaMHQF5HRUZ4jMIfEDulvVkUn?=
 =?us-ascii?Q?+iKtMHVGEi8QV8YLVF9hctlGH33x7gaoU9jbAqdaAqnyRPBjGCpJFyWiisyD?=
 =?us-ascii?Q?YjJDGXlQi2TTgO9TXge8WFu1jozL7a8ScXLWBFJ/ArSlRvvCcP6XO5n6FWwA?=
 =?us-ascii?Q?DJf8JdhWUDhfhWNBV4AoLi5XISrhQhf/fJpYBwzi/eQ0RU++mjArcemmdvsm?=
 =?us-ascii?Q?q0Z1TGpajQKolTQDeYRFwLVSEbaHnFXBRXonT1EpihT/4+FOw/EA4V9h19Jd?=
 =?us-ascii?Q?pQ+kj0aVvgizz3969roEMrizM5UASHTtMHbl//No6NJ3aVKr7f7CknTF+s7V?=
 =?us-ascii?Q?BzOed+rE47b1fDlQ+QTVczqlxVVI3OKYKeA43cwaBqfmU+j9vjCSaw/YVTfO?=
 =?us-ascii?Q?jEHcy1seSsFY19Kme0REATlM9uDySIcILE2dCLr1Q1vSgRXgP5zNjPuw8yIS?=
 =?us-ascii?Q?tSg677QQiLBnGi8viI+NRuYiwHLTJg+hjKF2Mg64NL7nR5wCAaEccqNs9qOU?=
 =?us-ascii?Q?fdtSPk33sq5yfHJztA8Y2H+WZ43LP/B4As1Z5lpTO3VPDxNJYnXRvmtwMmY9?=
 =?us-ascii?Q?2AwR1jwVRCj3ZIXd2wNwx2tl5DgOQ2L/0vFoZ4s6zSARvnlqukDx2blyqlI1?=
 =?us-ascii?Q?4u+FbeGwIP0gzk3e69Py/81r1uGe4jzLBh2hLeEqS9LCac3VdldDwDV45r8P?=
 =?us-ascii?Q?y92sUgdMYoqmon9dkHxG/yDujbacHbSsEKoVwfFwySpv/mW90o26yN5TRyM+?=
 =?us-ascii?Q?JuYrlHJ9AuQz6ghrOD5nx2ivRrDbP0pEJUj/xUNN9Onxx1io63WnosJne5Yg?=
 =?us-ascii?Q?gCVPzWybnZwtEAVmEZUiXH29Z38P4mMcR3jGdwa94FExY4fcAA2kBAdWlqGm?=
 =?us-ascii?Q?oh29Uvr5Ay+ZjWs2eGlGJDyYZ8HiIOvQyglFLApSVBQweNwE+agtpyyuVOAG?=
 =?us-ascii?Q?OYGauF94jgFbqUDHxaMp9q47Odm9m6dQlUM1Bu4u/KBhaJiB4rkuzqD8B2vI?=
 =?us-ascii?Q?8qlzEtiuJLrs1T6arV/tlGLsskZzXPia5BakFl5i3g4zDu6Z0etqFijtu3RP?=
 =?us-ascii?Q?0C9qc+g2BSg6rtAN8rs6M72SygVKuFLrl7ab?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 13:04:43.3218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a44ece-42eb-4966-552e-08ddbe2001b9
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A5F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9225

Most stuff in this file isn't been used.
---
 mesh/prov.h | 116 ----------------------------------------------------
 1 file changed, 116 deletions(-)

diff --git a/mesh/prov.h b/mesh/prov.h
index e86668fe40b8..c944663fa229 100644
--- a/mesh/prov.h
+++ b/mesh/prov.h
@@ -12,39 +12,11 @@
 #define __packed __attribute__((packed))
 #endif
 
-struct mesh_net;
-struct mesh_dev;
-
-enum mesh_trans {
-	MESH_TRANS_IDLE,
-	MESH_TRANS_TX,
-	MESH_TRANS_RX,
-};
-
-enum mesh_bearer {
-	MESH_BEARER_IDLE,
-	MESH_BEARER_ADV,
-};
-
-enum mesh_prov_mode {
-	MESH_PROV_MODE_NONE,
-	MESH_PROV_MODE_INITIATOR,
-	MESH_PROV_MODE_GATT_ACCEPTOR,
-	MESH_PROV_MODE_ADV_ACCEPTOR,
-	MESH_PROV_MODE_GATT_CLIENT,
-	MESH_PROV_MODE_MESH_SERVER,
-	MESH_PROV_MODE_MESH_CLIENT,
-	MESH_PROV_MODE_MESH_GATT_CLIENT,
-};
-
-struct mesh_prov;
-
 typedef void (*prov_trans_tx_t)(void *tx_data, const void *data, uint16_t len);
 typedef void (*mesh_prov_open_func_t)(void *user_data, prov_trans_tx_t trans_tx,
 					void *trans_data, uint8_t trans_type);
 
 typedef void (*mesh_prov_close_func_t)(void *user_data, uint8_t reason);
-typedef void (*mesh_prov_send_func_t)(bool success, struct mesh_prov *prov);
 typedef void (*mesh_prov_ack_func_t)(void *user_data, uint8_t msg_num);
 typedef void (*mesh_prov_receive_func_t)(void *user_data, const void *data,
 								uint16_t size);
@@ -118,91 +90,3 @@ struct conf_input {
 	uint8_t				prv_pub_key[64];
 	uint8_t				dev_pub_key[64];
 } __packed;
-
-struct mesh_prov {
-	int ref_count;
-	struct mesh_dev *dev;
-	struct mesh_net *net;
-	enum mesh_prov_mode mode;
-	enum mesh_trans trans;
-	enum mesh_bearer bearer;
-	uint8_t uuid[16];
-	uint8_t caps[12];
-
-	uint32_t conn_id;
-	uint16_t net_idx;
-	uint16_t remote;
-	uint16_t addr;
-	uint16_t expected_len;
-	uint16_t packet_len;
-	uint8_t local_msg_num;
-	uint8_t peer_msg_num;
-	uint8_t last_peer_msg_num;
-	uint8_t got_segs;
-	uint8_t expected_segs;
-	uint8_t expected_fcs;
-	uint8_t packet_buf[80];
-	uint8_t peer_buf[80];
-	struct timeval tx_start;
-	struct l_timeout *tx_timeout;
-
-	/* Provisioning credentials and crypto material */
-	struct conf_input conf_inputs;
-	uint8_t dev_key[16];
-	uint8_t conf_salt[16];
-	uint8_t s_key[16];
-	uint8_t s_nonce[13];
-	uint8_t conf_key[16];
-	uint8_t conf[16];
-	uint8_t r_conf[16];
-	uint8_t rand_auth[32];
-	uint8_t prov_salt[16];
-	uint8_t secret[32];
-	uint8_t r_public[64];
-	uint8_t l_public[64];
-	/* End Provisioning credentials and crypto material */
-
-	mesh_prov_open_func_t open_callback;
-	mesh_prov_close_func_t close_callback;
-	mesh_prov_receive_func_t receive_callback;
-	void *receive_data;
-	mesh_prov_send_func_t send_callback;
-	void *send_data;
-};
-
-struct mesh_prov *mesh_prov_new(struct mesh_net *net, uint16_t remote);
-
-struct mesh_prov *mesh_prov_ref(struct mesh_prov *prov);
-void mesh_prov_unref(struct mesh_prov *prov);
-
-bool mesh_prov_gatt_client(struct mesh_prov *prov, struct mesh_dev *dev,
-					uint8_t uuid[16],
-					mesh_prov_open_func_t open_callback,
-					mesh_prov_close_func_t close_callback,
-					mesh_prov_receive_func_t recv_callback,
-					void *user_data);
-
-bool mesh_prov_listen(struct mesh_net *net, uint8_t uuid[16], uint8_t caps[12],
-					mesh_prov_open_func_t open_callback,
-					mesh_prov_close_func_t close_callback,
-					mesh_prov_receive_func_t recv_callback,
-					void *user_data);
-
-bool mesh_prov_connect(struct mesh_prov *prov, struct mesh_dev *dev,
-					uint16_t net_idx, uint8_t uuid[16],
-					mesh_prov_open_func_t open_callback,
-					mesh_prov_close_func_t close_callback,
-					mesh_prov_receive_func_t recv_callback,
-					void *user_data);
-
-unsigned int mesh_prov_send(struct mesh_prov *prov,
-					const void *data, uint16_t size,
-					mesh_prov_send_func_t send_callback,
-					void *user_data);
-bool mesh_prov_cancel(struct mesh_prov *prov, unsigned int id);
-
-bool mesh_prov_close(struct mesh_prov *prov, uint8_t reason);
-void mesh_prov_set_addr(struct mesh_prov *prov, uint16_t addr);
-uint16_t mesh_prov_get_addr(struct mesh_prov *prov);
-void mesh_prov_set_idx(struct mesh_prov *prov, uint16_t net_idx);
-uint16_t mesh_prov_get_idx(struct mesh_prov *prov);
-- 
2.43.0

