Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012022.outbound.protection.outlook.com [52.101.71.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FD82AEF1
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752256880; cv=fail; b=KzBI7c0o4oREzqY7FjsV6RxHusqFgCcoFDSmkN33UDhYn4wdwEX5Bzq2xqEddBXwEGKEsS6fum115pVhVdpw0mrO8GsWTAEsdxLtDTflHd5s8soTSmrLd6gT7A/CN8htlSj1NeThYZLWUBgCYWOt8NKfOAzPdQKYiswKmyEnxes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752256880; c=relaxed/simple;
	bh=v+zd/8DDZi8Ne/X9eBYM8hP/VRfU129WtUPT53BK4Yc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gW0qUPN/kZUvFEtxnUHO3WbGCsiQIXvMDANobGgKQLTuYJFXI//XfDL4C5o8YZ5bL7MllWtzNQd34717hLhJRqe1aWHrp2UTYQNzKjuyGehsmbUa1VOAXlzEBhFqkaGLKDnZR9DDRwvzgvL4LmYf44UAG69pgPshjYsdawm4P1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=cKGEbpYq; arc=fail smtp.client-ip=52.101.71.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="cKGEbpYq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2NDFMGgT8uCs2nqkzm8W46KeuRb6tzpRFh3O+Im3afcdncqHtNbuh/iyW6XC1N38dBPhnAWgjCIcdpXvdXHAl/AJk3eHNvFSXHitAGeKxY9V22yU1kLFYHNLy1lq6u3JZqJNCdFimrMcYB2bLM/70/86HwabCvq5IVAwDFW2y5CrgVS1mInYRK6i7guEyyWfHkEPO6QKzIFmDlO+CHT5HMDMbIKrw3bJTfvyDAqxaHE4lItMxrZF/Ayj1FntFXzZy/kP5CBXwScauU3F01erbnOVoOTjNB5Dto6F97SVz/bRoCXKOpfnur6jcElgDSKhzUwhMTLxVg2p9Rkmhc3xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E797FdjeBCDN+hLcw9leJmZNWA3cnhaD73ApkdhC1PM=;
 b=OhbCzsFDv7m4uK7gIXnC2d9dwNfQkCfYOGGecR1lEuU+XcVjelM4H/pUCnti4DI7/wziRLL/IMkzo4ZLhoXCg2jsEOqMYXv4DuUIXb18SIzjUHaoJkYtkXgPFT2g5M9Rn4HZJnlfYBqG06f8JhtzOeuK1cXOQ09+qj0EJ3/qhpxzm7ISgbcrgfG4Hk5lO0yhNkSPKKYvFAEcqeNNMlII04VPLrEsFg8zWspCRhxH7OIGnsq3gkc6LIcEdgIJJgeEuKzUPKSAbNNZkUDlaGKIzPb9pUF5Xw58hiy9sJz6YETbvlMIbwl6YHXlLt2tszRj6qzwbULfJCi8Lj+palWVGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E797FdjeBCDN+hLcw9leJmZNWA3cnhaD73ApkdhC1PM=;
 b=cKGEbpYqwigFxNVbUPp3k1R7L8fZbKtAMmOyRr9QhMHR8D3Qr0KxLmEpjFCG+OGf4codnBGmVok+neUaIUjgknQPbFwI4glgUe6EAcxO1MDhWZVweFu8GUtA1dDoM4ocXJBLQSpYav6aV+mk5vvvh5tq0CVbgZQqGnIi9RgTMn8=
Received: from AS4P250CA0019.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5e3::10)
 by DB3PR0302MB9184.eurprd03.prod.outlook.com (2603:10a6:10:43e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Fri, 11 Jul
 2025 18:01:15 +0000
Received: from AMS0EPF000001A8.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e3:cafe::f4) by AS4P250CA0019.outlook.office365.com
 (2603:10a6:20b:5e3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.27 via Frontend Transport; Fri,
 11 Jul 2025 18:01:15 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS0EPF000001A8.mail.protection.outlook.com (10.167.16.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 18:01:15 +0000
Received: from N9W6SW14.arri.de (192.168.54.13) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Fri, 11 Jul
 2025 20:01:14 +0200
From: Christian Eggers <ceggers@arri.de>
To: Brian Gix <brian.gix@gmail.com>, Inga Stotland <inga.stotland@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [RFC PATCH BlueZ v2 7/7] mesh: gatt-proxy: propagate beacons
Date: Fri, 11 Jul 2025 19:56:57 +0200
Message-ID: <20250711175842.28860-8-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711175842.28860-1-ceggers@arri.de>
References: <20250701144647.19572-2-ceggers@arri.de>
 <20250711175842.28860-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A8:EE_|DB3PR0302MB9184:EE_
X-MS-Office365-Filtering-Correlation-Id: c0fe520c-7780-4c5a-5ebb-08ddc0a4ede3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N18YPt/jltWrJ9SotorOq6TVvMGdtRtN3LtHJad6x+YR8y5XFSinBs6SDWqs?=
 =?us-ascii?Q?wfV2yD3E4xNr3calYwtJnon6FunCFA/uQMs2P0Ef8uvcGBjHZXJXXGaBF2aY?=
 =?us-ascii?Q?a26YSTA+CxB3wMIgCDKyBw3eOQbg/Z2MgWVzigMzdO11tNm0QYLFpsx8Urv7?=
 =?us-ascii?Q?QM8iofnLwecBkPjDxwcOm77K3mSQprUbxvDAtWiENx5I/6cQDUZnU9IfeBpD?=
 =?us-ascii?Q?5wGIaYgAzkVhPzGPE1QnqhykpXuBjEwDZKZpVRTZ2PaEc7h3FHchPCJbSNDI?=
 =?us-ascii?Q?qoAYLFVO3UAUs0IK9imHqkRIM2VrUIfC/WDNN6msSzp9Ust72LSwHKWjY0gO?=
 =?us-ascii?Q?HKwNJ3beCyunGJWHNOgM0EQOb1qp5MN+IaPT9PU2ot2geWAMHRG462vOJanb?=
 =?us-ascii?Q?X2Va3odhsvzLxXfx8rG0Qm6TpwrPgFdkIIZ4wfYzP29Lw4iiuZ1bXhnqE/j1?=
 =?us-ascii?Q?MDiucpYrP/kGIfCh7fagpA7PDE+fchd6P8pGx1WRcvPLc7zbjp5nBUKFt5WX?=
 =?us-ascii?Q?b+0rndzVTDC3va51A04B4RBsyTChqwVlkHTozicy6Ya0RXYO9yKzucogFR2N?=
 =?us-ascii?Q?qno4PCyL9POjaJ0Y9N+OXpXEZQtFflI+nMHnjqYWBpe/JYcWC8haOxjSW3ND?=
 =?us-ascii?Q?iGlHMB0LEALA0cFByXr3LSvFkhcNm9Lmpr4oMAgvfF3D/uWxOHoJgzb7UR7f?=
 =?us-ascii?Q?+mecy8Lga5vTG4fHNH5K3thwnCQ0Rzw4m6DktCWlfeTME6hZmOBFgYS22hRa?=
 =?us-ascii?Q?He984oRQYmFIjZP2vZBT+Mh4ccvzvJKOWNOHUynkLlwy6INo4+HgYV4iu8fi?=
 =?us-ascii?Q?NNd4pPGatfJ+SUUAUvEQgF0eIE0CYTawB+VJVcsTn7ZIBqVJrgERgS6X0io+?=
 =?us-ascii?Q?w3sKt9mrxNKPX6/nf1YAXBtB4n7wd/QyJ7bH88UgL+BbQb88M1FALk00+veh?=
 =?us-ascii?Q?RMFFY8wjUN2IFiOGU0nop3fimgSbaihbVoEodKFSsb63U0kWx23APJ/gxRaY?=
 =?us-ascii?Q?LFZMgEMMczS2AbYcqKv65yM5WP3+IbkaORKO2BoTx0Tuo64daGyxDnEh9uif?=
 =?us-ascii?Q?X1vVlc+yTaB83IZbgDGHkW43zxC3NzujOdeWSxS2YeEVlLZeTas6LPKv0PQn?=
 =?us-ascii?Q?wt5NMqSp47v4I70bmlCMJQZ30Z4WSb52l0+O4DK0Y8bOO6ajeDAvxBFKjd1t?=
 =?us-ascii?Q?VyJmVcMKpZiFxmY6BpR50zCMRqmehIAzQbgenDRF6XvrX9Wu6BwJQk5KSeei?=
 =?us-ascii?Q?9R8Bg7kRWtdgE0bLb7XBS9ofTVENyT96o/gpVZeBw+L0WpZ9L/ulZacXi/8Z?=
 =?us-ascii?Q?cW5rODvA3hfQHbwdat6hxfmax3cnEu/fiVZaGCfwZZVVfBP/ybEVWSvQMf7A?=
 =?us-ascii?Q?44ev3xcv7GzYsiha8UzFA99CZUj3GqCqalxewaR3CdBC0Q2VzR0VIfxSJOK+?=
 =?us-ascii?Q?K3dPYj7RO/8jztuKR9j5N1SQoEVgqXkYIk5QjZ57fAEMzIXowGaL4kStgVbI?=
 =?us-ascii?Q?vs9jmY6YswIqo3Rxqag8EpqpMyi219aRLwVy?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 18:01:15.4369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0fe520c-7780-4c5a-5ebb-08ddc0a4ede3
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A8.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB9184

MshPRT_v1.1, section 6.7 requires that:
1. Upon connection of a GATT proxy client to a GATT proxy server, the
   server sends a beacon for each known subnet to the client.
2. Upon processing a SNB or MPB with a new IV index or flags value, the
   GATT proxy server shall propagate the beacon to the client.
3. When the GATT proxy server is added to a new subnet, a beacon for
   that subnet shall be sent to the client.
---
 mesh/gatt-proxy-svc.c | 20 +++++++++++++++++++-
 mesh/gatt-proxy-svc.h |  1 +
 mesh/net-keys.c       | 25 +++++++++++++++++++++++++
 mesh/net-keys.h       |  1 +
 mesh/net.c            | 23 +++++++++++++++++++++++
 mesh/net.h            |  1 +
 6 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/mesh/gatt-proxy-svc.c b/mesh/gatt-proxy-svc.c
index 4100578a9f0a..020555bbfdb2 100644
--- a/mesh/gatt-proxy-svc.c
+++ b/mesh/gatt-proxy-svc.c
@@ -25,7 +25,8 @@
 #include "mesh/net.h"			// PROXY_FILTER_ACCEPT_LIST,
 					// PROXY_FILTER_REJECT_LIST
 					// mesh_net_attach_gatt(),
-					// mesh_net_detach_gatt()
+					// mesh_net_detach_gatt(),
+					// mesh_net_send_all_beacons_gatt()
 #include "mesh/net-keys.h"		// net_key_fill_adv_service_data(),
 					// net_key_get_next_id()
 #include "mesh/util.h"			// print_packet()
@@ -281,6 +282,11 @@ static void gatt_proxy_svc_send(enum proxy_msg_type msg_type, const void *data,
 	}
 }
 
+void gatt_proxy_svc_send_beacon(const void *data, uint8_t len)
+{
+	gatt_proxy_svc_send(PROXY_MSG_TYPE_MESH_BEACON, data, len);
+}
+
 void gatt_proxy_svc_send_net(uint16_t dst, const void *data, uint8_t len)
 {
 	int i;
@@ -331,6 +337,18 @@ static void gatt_service_notify_acquired(void *user_data)
 	 */
 	gatt_proxy->filter_type = PROXY_FILTER_ACCEPT_LIST;
 	gatt_proxy->filter_count = 0;
+
+	/*
+	 * MshPRT_v1.1, section 6.7 - Proxy Server behavior
+	 * Upon connection, [...] The Proxy Server shall send a mesh
+	 * beacon for each known subnet to the Proxy Client, [...]
+	 *
+	 * MshPRT_v1.1, section 7.2.3.2.1 - Characteristic behavior
+	 * [...] the client will enable notifications [...] to the
+	 * Mesh Proxy Data Out Client Characteristic Configuration
+	 * Descriptor after a connection is established.
+	 */
+	mesh_net_send_all_beacons_gatt();
 }
 
 static void gatt_service_notify_stopped(void *user_data)
diff --git a/mesh/gatt-proxy-svc.h b/mesh/gatt-proxy-svc.h
index 0abb85d7109f..2784602160bb 100644
--- a/mesh/gatt-proxy-svc.h
+++ b/mesh/gatt-proxy-svc.h
@@ -36,5 +36,6 @@ unsigned gatt_proxy_svc_filter_count(struct gatt_proxy_svc *gatt_proxy,
 void gatt_proxy_svc_filter_pdu_rcvd(struct gatt_proxy_svc *gatt_proxy,
 								uint16_t src);
 
+void gatt_proxy_svc_send_beacon(const void *data, uint8_t len);
 void gatt_proxy_svc_send_net(uint16_t dst, const void *data, uint8_t len);
 void gatt_proxy_svc_send_proxy_cfg(const void *data, uint8_t len);
diff --git a/mesh/net-keys.c b/mesh/net-keys.c
index 1a2cd39421c1..918455b2200f 100644
--- a/mesh/net-keys.c
+++ b/mesh/net-keys.c
@@ -732,6 +732,18 @@ bool net_key_beacon_refresh(uint32_t id, uint32_t ivi, bool kr, bool ivu,
 
 		print_packet("Set SNB to", key->snb, BEACON_LEN_SNB);
 		gatt_proxy_svc_set_current_adv_key(key->id);
+
+		/*
+		 * MshPRT_v1.1, section 6.7 - Proxy Server behavior
+		 * Upon successfully processing a Secure Network Beacon or
+		 * a Mesh Private beacon with a new value for the IV Index
+		 * field or the Flags field, the Proxy Server shall send a
+		 * mesh beacon to the Proxy Client, ...
+		 * When the Proxy Server is added to a new subnet, the server
+		 * shall send a mesh beacon for that subnet to the Proxy Client,
+		 * ...
+		 */
+		gatt_proxy_svc_send_beacon(key->snb + 1, BEACON_LEN_SNB - 1);
 	}
 
 	l_debug("Set Beacon: IVI: %8.8x, IVU: %d, KR: %d", ivi, ivu, kr);
@@ -850,6 +862,19 @@ void net_key_beacon_disable(uint32_t id, bool mpb)
 	key->observe.timeout = NULL;
 }
 
+void net_key_beacon_send_gatt(uint32_t id)
+{
+	struct net_key *key = l_queue_find(keys, match_id, L_UINT_TO_PTR(id));
+
+	if (!key)
+		return;
+
+	/* FIXME: How to determine that key actually contains a valid SNB? */
+	if (key->snb && key->snb[0] == BT_AD_MESH_BEACON &&
+			key->snb[1] == BEACON_TYPE_SNB && key->snb[2] == 0)
+		gatt_proxy_svc_send_beacon(key->snb + 1, BEACON_LEN_SNB - 1);
+}
+
 static void free_key(void *data)
 {
 	struct net_key *key = data;
diff --git a/mesh/net-keys.h b/mesh/net-keys.h
index b43157df29bc..0d292ee41606 100644
--- a/mesh/net-keys.h
+++ b/mesh/net-keys.h
@@ -40,6 +40,7 @@ bool net_key_beacon_refresh(uint32_t id, uint32_t iv_index, bool kr, bool ivu,
 								bool force);
 void net_key_beacon_enable(uint32_t id, bool mpb, uint8_t refresh_count);
 void net_key_beacon_disable(uint32_t id, bool mpb);
+void net_key_beacon_send_gatt(uint32_t id);
 uint32_t net_key_beacon_last_seen(uint32_t id);
 
 bool net_key_fill_adv_service_data(uint32_t id,
diff --git a/mesh/net.c b/mesh/net.c
index 97591a5323d1..e4998a0924f6 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2997,6 +2997,29 @@ void net_local_beacon(uint32_t net_key_id, uint32_t ivi, bool ivu, bool kr)
 	l_queue_foreach(nets, process_beacon, &beacon_data);
 }
 
+static void send_beacon_gatt(void *a, void *b)
+{
+	struct mesh_subnet *subnet = a;
+
+	net_key_beacon_send_gatt(subnet->net_key_tx);
+}
+
+static void send_all_beacons_gatt(void *a, void *b)
+{
+	struct mesh_net *net = a;
+
+	l_queue_foreach(net->subnets, send_beacon_gatt, NULL);
+}
+
+void mesh_net_send_all_beacons_gatt(void)
+{
+	/*
+	 * Upon connection, [...] The Proxy Server shall send a mesh beacon
+	 * for each known subnet to the Proxy Client, [...]
+	 */
+	l_queue_foreach(nets, send_all_beacons_gatt, NULL);
+}
+
 bool mesh_net_set_snb_mode(struct mesh_net *net, bool enable)
 {
 	if (!net)
diff --git a/mesh/net.h b/mesh/net.h
index af581478412c..bf537e20a57c 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -229,6 +229,7 @@ uint16_t mesh_net_get_address(struct mesh_net *net);
 bool mesh_net_register_unicast(struct mesh_net *net,
 					uint16_t unicast, uint8_t num_ele);
 void net_local_beacon(uint32_t key_id, uint32_t ivi, bool ivu, bool kr);
+void mesh_net_send_all_beacons_gatt(void);
 bool mesh_net_set_snb_mode(struct mesh_net *net, bool enable);
 bool mesh_net_set_mpb_mode(struct mesh_net *net, bool enabla, uint8_t period,
 								bool init);
-- 
2.43.0

