Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013000.outbound.protection.outlook.com [40.107.159.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BBB2F0059
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 17:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255704; cv=fail; b=bGYmSDPGnd6KnyD/glPWoMmeF2siaxfYr+jqeuaBUjc1eeldxjg2pvXKl4JYwmE/kGRA4Jeq2ZRONzXIkWS7AqByP5XpTawdPu71iTzEMeW/d/tzar+rL4iinKkOhAW8lcgjFMBjTCt79nYa2pscI/UXhhuS9JiqIS5RWpyzLVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255704; c=relaxed/simple;
	bh=iyWnnMrFw5GwH5MY4NYzRUgE9iphKkU2K83l4OLsmnA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dZHdAzW8toijhMgUJ7l3ACOEhrRVjhOPjpwXrJLTsAtuJyOsPHtG0MRAprkNx0s92JwMEBjIWL92JY+hKKunjdmEEJ/mrdz23WKa6jKWVUvkuNUaCPydtApONO41WJ8FQ8Q3v4165jtQz17azOjxWUDiSUOdydiDdCJK+9MjSsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=Ut6ZM7oW; arc=fail smtp.client-ip=40.107.159.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="Ut6ZM7oW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xn0iM6t8PwY9CSLuOwtPliypj1dkufpZogrmM6jznl6eBrBiBswQzgF2FztxN0sGJykYYkZQDI3osgFOm58nXpKgwzO/gzZzk7KG/182Lk41I7WHZHetGIBhSrPEOQsmapO92wkMLwXFL+yXEKH5JEw2PSSg0S3vVfA00Vj6nh8RFEJNfA6/SNDBnDBxHeHryHf3hSa0tfFo00Vfxml0glCKBN4N7atEepeyjhRbcGozBG23rEP1HBguImhIWhroJzLDtEtpsUduRme039ysKheA9LYXDjCYcA0/Qkx2VVYwEIStHDVxewj0K9i0d11r6VOjjSPnTpJEYPAuDkHz0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIFET7edovHsUjAMoKGJ3fYaGtlt8jzsS7Pi7ytwUm0=;
 b=EkZC6ONtPn3C30O1NCm1vy1hTTe9QrYVeEa9GL72ektY9BIJ/Brn3AbBToVfXhGRg2qlSV6pzxft1zw+Nw358gs80P9USs37UN56Eto68QqCLqxhQtVvLhQaGSjk7c/XfbQl/i7D4nptjaIba0euS8XDSYAJYiK+4aCYtXCO+9MslNOn5/kgQ7oI9YkcIm6ilsp7CuXXh85wlYRGORqf+wRqPE8Lm4nCnkxi2wUTDPP9vJ8J1YyTAyUlduehPBKcuu5kB9/XTqZ4hnZedNe3rTBA4lJb0eFB0XcQeZohRUgJYa4fCAlQMM/kU6K/a1TA/qDuwxYp44J8iDZeBgq87Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIFET7edovHsUjAMoKGJ3fYaGtlt8jzsS7Pi7ytwUm0=;
 b=Ut6ZM7oW0DbcWnWrKPSPm//RCgWhXMutwSmmhEw9M7A5uVdhEUduHLPcgJGPanCmY3bKcbRyNrWifmzbozk8OilrcOJan3UTg9D0HhHZvsM9+ytp2i+DXQ5ibsoWMP7h3+veIJkWujf3sdpJV8yIxSusfJVAmZllXsy+gDOWru8=
Received: from DU2PR04CA0315.eurprd04.prod.outlook.com (2603:10a6:10:2b5::20)
 by DB4PR03MB9338.eurprd03.prod.outlook.com (2603:10a6:10:3fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 17:41:34 +0000
Received: from DU6PEPF00009525.eurprd02.prod.outlook.com
 (2603:10a6:10:2b5:cafe::c9) by DU2PR04CA0315.outlook.office365.com
 (2603:10a6:10:2b5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Fri,
 11 Jul 2025 17:41:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU6PEPF00009525.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 17:41:34 +0000
Received: from N9W6SW14.arri.de (192.168.54.13) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Fri, 11 Jul
 2025 19:41:33 +0200
From: Christian Eggers <ceggers@arri.de>
To: Brian Gix <brian.gix@gmail.com>, Inga Stotland <inga.stotland@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 3/9] mesh: replace MESH internal defines by shared ones
Date: Fri, 11 Jul 2025 19:39:19 +0200
Message-ID: <20250711173958.25689-4-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711173958.25689-1-ceggers@arri.de>
References: <20250711173958.25689-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF00009525:EE_|DB4PR03MB9338:EE_
X-MS-Office365-Filtering-Correlation-Id: 65a1673a-80c7-4524-7f7d-08ddc0a22dd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|30052699003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IZE2b0UakHMwzOa41c7NEwD6A2oOzOuroKSqQH1kdswNAbfe78GNaHUQIsUv?=
 =?us-ascii?Q?hipKlpyCo0v/umyGSO/o8gxOjrp0cakiIG6NnjD8gkghzV++IKs1F3yR6Grr?=
 =?us-ascii?Q?V8+CyHH53ZjT9LJrq8dvChBPxEScS3UkrgvQnF0q1ZfIJSMjr2hiNy8CMg9O?=
 =?us-ascii?Q?ToV429qE7Ilwew10TVDCkoSO1WcNcrTpE82XypdgfKhqzVbLQv1kzbFJkumX?=
 =?us-ascii?Q?+8Y6e7PjwNr1+FukseqR4TEncCJWPffMIr9XBxdHLyqwE9vXue2TZgKsfqlp?=
 =?us-ascii?Q?CfqoXZFl9b5b6voJgwiWhiXLgGUSk+p6Ataq61NSK0AZsgASs2TlGYUdxV+d?=
 =?us-ascii?Q?Iw0Po0+/0SX1DYG17R4g/MJbV4BUeiZLkg/MpmsjpZQohSUnLmBwxUNc9p8I?=
 =?us-ascii?Q?/RLTgVuO18D0Cqy+3HSt2u5akd0FK1iYZgjWK2JOFOrB6ZjkL+5tFb/4Jy41?=
 =?us-ascii?Q?UoOgKs+DKNQw0H89BRHvhc2dqkrUz82xHQfc//apYFWX3rqjLShWBGyWUj0H?=
 =?us-ascii?Q?X6ETZGhc7Bc7CIx2F3qMJ3h0yHlG1Lzomzp6F71Bz6AtnF4QSQRGSZiMyvLc?=
 =?us-ascii?Q?C7RVIt3/u97hJ7OcJxELwRjQTBqV5jzY6a6nf+3y4OMmC+NgM0Har3fbJNhd?=
 =?us-ascii?Q?BUkgDfFYx6B4OscViOgTjXGkpAg4iy8EIwdqNunMBNuPCiwWSVjSQr0fNACz?=
 =?us-ascii?Q?1RUcfSZSmbLZI4/JO7o3cFuKZy9rXJNPuLsMS4JxpAQCV9ZbXtUvXCm27BmP?=
 =?us-ascii?Q?2vAMjpbJRd0q20c6WDhboZX974XAEK0gXMTSpvrP5Pd9DOHLjinshvvTefJO?=
 =?us-ascii?Q?P0qK9kv3iFc45NDwkdXNAWoHCQfohcYOXxowBcHPkxnqj1BF49XRToaNbVWH?=
 =?us-ascii?Q?N4p6ehq0Ovc2G2CVB/HcGjJ69gYPp89cvnGANJVSbuVFENYor8p8w75qZVW/?=
 =?us-ascii?Q?aVRaxyaqYtfD95uq2VI733b9zLlaCtCYAz//m0bneDMM0hrglSzJKp4bgiec?=
 =?us-ascii?Q?5ts2I4sjcfzvE2KPHJ80M+1Ke7sndc1j9m9oCnj0uzgnUFAuFlU6gEudN2ng?=
 =?us-ascii?Q?4iRlmbMxGIUu5s3KAP/AfOKcfvhIaKLsg3BTu9cM9v8A8qG8maNEqoCh+Xtk?=
 =?us-ascii?Q?rh+HIy/BbsXiMBWY6VDDOfmRX67rvQGTvh0Y1N5MErmDms1qyfLtTiuaANZA?=
 =?us-ascii?Q?FryBa/QItgSkU0c5IEUzQycQhVXytTNSYm38v1ePHXq8PiXgbQpL4XAAa1BN?=
 =?us-ascii?Q?6kHrkMOkhsQcs/24sIyJwBgNpvVZnkz5Y3BWwCcVzydTql7ktFo8FpIWXRN+?=
 =?us-ascii?Q?svfM9S5pxvTBXRMn7ZlyoceHXZwZtBwO5+txqnXuDZNWyClbvhqBJQfWTfXM?=
 =?us-ascii?Q?RcRMMz7UsdrtN7Xq2SblOc4S5nOcNDsoyT/RUOPefGP5iyYPktxKNSlTSF8c?=
 =?us-ascii?Q?vEA1ysr0xT164CkZCcnkoDzbjmlQAB+oxSXHU6F5Axy3r+0s76z/aEnb2Xd/?=
 =?us-ascii?Q?ELq+uTFQreB23vDWPlSVKmQ/dhYLwdyINyYa?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(30052699003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 17:41:34.2173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a1673a-80c7-4524-7f7d-08ddc0a22dd9
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009525.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR03MB9338

Replace BT_AD_MESH_* by MESH_AD_TYPE_*.

Both sets of definition have been added almost at the time, so maybe
it was a 'race condition'.
---
 mesh/manager.c         |  4 +++-
 mesh/mesh-defs.h       |  4 ----
 mesh/mesh-io-generic.c |  4 ++--
 mesh/mesh-io-mgmt.c    | 17 ++++++++---------
 mesh/mesh-io.c         |  3 ++-
 mesh/mesh.c            |  6 ++++--
 mesh/net-keys.c        |  4 ++--
 mesh/net.c             | 16 ++++++++--------
 mesh/pb-adv.c          | 14 ++++++++------
 mesh/prov-acceptor.c   |  8 ++++----
 mesh/prov-initiator.c  |  3 ++-
 11 files changed, 43 insertions(+), 40 deletions(-)

diff --git a/mesh/manager.c b/mesh/manager.c
index 3786f7a8f4cd..b69866355bd1 100644
--- a/mesh/manager.c
+++ b/mesh/manager.c
@@ -17,6 +17,8 @@
 #define _GNU_SOURCE
 #include <ell/ell.h>
 
+#include "src/shared/ad.h"
+
 #include "mesh/mesh-defs.h"
 #include "mesh/dbus.h"
 #include "mesh/error.h"
@@ -57,7 +59,7 @@ struct scan_req {
 
 static struct l_queue *scans;
 static struct prov_remote_data *prov_pending;
-static const uint8_t prvb[2] = {MESH_AD_TYPE_BEACON, 0x00};
+static const uint8_t prvb[2] = {BT_AD_MESH_BEACON, 0x00};
 
 static bool by_scan(const void *a, const void *b)
 {
diff --git a/mesh/mesh-defs.h b/mesh/mesh-defs.h
index a12acaf59453..5b0403d1315e 100644
--- a/mesh/mesh-defs.h
+++ b/mesh/mesh-defs.h
@@ -8,10 +8,6 @@
  *
  */
 
-#define MESH_AD_TYPE_PROVISION	0x29
-#define MESH_AD_TYPE_NETWORK	0x2A
-#define MESH_AD_TYPE_BEACON	0x2B
-
 /*
  * MshPRT_v1.1, section 3.3.1 / Core_v5.3, section 2.3.1.3
  * Maximum length of AdvData without 'Length' field (30)
diff --git a/mesh/mesh-io-generic.c b/mesh/mesh-io-generic.c
index 0875a359bd78..f65de9d8d6de 100644
--- a/mesh/mesh-io-generic.c
+++ b/mesh/mesh-io-generic.c
@@ -353,8 +353,8 @@ static bool find_active(const void *a, const void *b)
 	/* Mesh specific AD types do *not* require active scanning,
 	 * so do not turn on Active Scanning on their account.
 	 */
-	if (rx_reg->filter[0] < MESH_AD_TYPE_PROVISION ||
-			rx_reg->filter[0] > MESH_AD_TYPE_BEACON)
+	if (rx_reg->filter[0] < BT_AD_MESH_PROV ||
+			rx_reg->filter[0] > BT_AD_MESH_BEACON)
 		return true;
 
 	return false;
diff --git a/mesh/mesh-io-mgmt.c b/mesh/mesh-io-mgmt.c
index 065067fc2821..30d3981bc14f 100644
--- a/mesh/mesh-io-mgmt.c
+++ b/mesh/mesh-io-mgmt.c
@@ -156,7 +156,7 @@ static bool filter_dups(const uint8_t *addr, const uint8_t *adv,
 	if (!addr)
 		addr = zero_addr;
 
-	if (adv[1] == MESH_AD_TYPE_PROVISION) {
+	if (adv[1] == BT_AD_MESH_PROV) {
 		filter = l_queue_find(pvt->dup_filters, find_by_adv, adv);
 
 		if (!filter && addr != zero_addr)
@@ -215,7 +215,7 @@ static void process_rx(uint16_t index, struct mesh_io_private *pvt, int8_t rssi,
 	};
 
 	/* Accept all traffic except beacons from any controller */
-	if (index != pvt->send_idx && data[0] == MESH_AD_TYPE_BEACON)
+	if (index != pvt->send_idx && data[0] == BT_AD_MESH_BEACON)
 		return;
 
 	print_packet("RX", data, len);
@@ -263,8 +263,7 @@ static void event_device_found(uint16_t index, uint16_t length,
 		if (len > adv_len)
 			break;
 
-		if (adv[1] >= MESH_AD_TYPE_PROVISION &&
-					adv[1] <= MESH_AD_TYPE_BEACON)
+		if (adv[1] >= BT_AD_MESH_PROV && adv[1] <= BT_AD_MESH_BEACON)
 			process_rx(index, pvt, ev->rssi, instant, addr,
 							adv + 1, adv[0]);
 
@@ -303,8 +302,8 @@ static bool find_active(const void *a, const void *b)
 	/* Mesh specific AD types do *not* require active scanning,
 	 * so do not turn on Active Scanning on their account.
 	 */
-	if (rx_reg->filter[0] < MESH_AD_TYPE_PROVISION ||
-			rx_reg->filter[0] > MESH_AD_TYPE_BEACON)
+	if (rx_reg->filter[0] < BT_AD_MESH_PROV ||
+					rx_reg->filter[0] > BT_AD_MESH_BEACON)
 		return true;
 
 	return false;
@@ -332,8 +331,8 @@ static void ctl_up(uint8_t status, uint16_t length,
 	int index = L_PTR_TO_UINT(user_data);
 	uint16_t len;
 	struct mgmt_cp_set_mesh *mesh;
-	uint8_t mesh_ad_types[] = { MESH_AD_TYPE_NETWORK,
-				MESH_AD_TYPE_BEACON, MESH_AD_TYPE_PROVISION };
+	uint8_t mesh_ad_types[] = { BT_AD_MESH_DATA, BT_AD_MESH_BEACON,
+							BT_AD_MESH_PROV };
 
 	l_debug("HCI%d is up status: %d", index, status);
 	if (status)
@@ -544,7 +543,7 @@ static void send_pkt(struct mesh_io_private *pvt, struct tx_pkt *tx,
 	memcpy(send->adv_data + 1, tx->pkt, tx->len);
 
 	/* Filter looped back Provision packets */
-	if (tx->pkt[0] == MESH_AD_TYPE_PROVISION)
+	if (tx->pkt[0] == BT_AD_MESH_PROV)
 		filter_dups(NULL, send->adv_data, get_instant());
 
 	mesh_mgmt_send(MGMT_OP_MESH_SEND, index,
diff --git a/mesh/mesh-io.c b/mesh/mesh-io.c
index 99c7c2014375..ec5feb9c2714 100644
--- a/mesh/mesh-io.c
+++ b/mesh/mesh-io.c
@@ -18,6 +18,7 @@
 
 #include "lib/bluetooth.h"
 #include "lib/mgmt.h"
+#include "src/shared/ad.h"
 #include "src/shared/mgmt.h"
 
 #include "mesh/mesh-defs.h"
@@ -42,7 +43,7 @@ static const struct mesh_io_table table[] = {
 	{MESH_IO_TYPE_UNIT_TEST, &mesh_io_unit},
 };
 
-static const uint8_t unprv_filter[] = { MESH_AD_TYPE_BEACON, 0 };
+static const uint8_t unprv_filter[] = { BT_AD_MESH_BEACON, 0 };
 
 static struct mesh_io *default_io;
 static struct l_timeout *loop_adv_to;
diff --git a/mesh/mesh.c b/mesh/mesh.c
index 01a1607b1a31..db77602d37da 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -17,6 +17,8 @@
 #define _GNU_SOURCE
 #include <ell/ell.h>
 
+#include "src/shared/ad.h"
+
 #include "mesh/mesh-io.h"
 #include "mesh/node.h"
 #include "mesh/net.h"
@@ -139,7 +141,7 @@ static void prov_rx(void *user_data, struct mesh_io_recv_info *info,
 
 bool mesh_reg_prov_rx(prov_rx_cb_t cb, void *user_data)
 {
-	uint8_t prov_filter[] = {MESH_AD_TYPE_PROVISION};
+	uint8_t prov_filter[] = {BT_AD_MESH_PROV};
 
 	if (mesh.prov_rx && mesh.prov_rx != cb)
 		return false;
@@ -153,7 +155,7 @@ bool mesh_reg_prov_rx(prov_rx_cb_t cb, void *user_data)
 
 void mesh_unreg_prov_rx(prov_rx_cb_t cb)
 {
-	uint8_t prov_filter[] = {MESH_AD_TYPE_PROVISION};
+	uint8_t prov_filter[] = {BT_AD_MESH_PROV};
 
 	if (mesh.prov_rx != cb)
 		return;
diff --git a/mesh/net-keys.c b/mesh/net-keys.c
index 9b11bb7a1da2..338d287a7ef7 100644
--- a/mesh/net-keys.c
+++ b/mesh/net-keys.c
@@ -399,7 +399,7 @@ static bool mpb_compose(struct net_key *key, uint32_t ivi, bool kr, bool ivu)
 						b_data, 5, b_data, NULL, 8))
 		return false;
 
-	key->mpb[0] = MESH_AD_TYPE_BEACON;
+	key->mpb[0] = BT_AD_MESH_BEACON;
 	key->mpb[1] = BEACON_TYPE_MPB;
 	memcpy(key->mpb + 2, random, 13);
 	memcpy(key->mpb + 15, b_data, 13);
@@ -421,7 +421,7 @@ static bool snb_compose(struct net_key *key, uint32_t ivi, bool kr, bool ivu)
 		return false;
 	}
 
-	key->snb[0] = MESH_AD_TYPE_BEACON;
+	key->snb[0] = BT_AD_MESH_BEACON;
 	key->snb[1] = BEACON_TYPE_SNB;
 	key->snb[2] = 0;
 
diff --git a/mesh/net.c b/mesh/net.c
index cf4f337616d5..b6ff11ffd777 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2258,7 +2258,7 @@ static void send_relay_pkt(struct mesh_net *net, uint8_t *data, uint8_t size)
 		.u.gen.max_delay = DEFAULT_MAX_DELAY
 	};
 
-	packet[0] = MESH_AD_TYPE_NETWORK;
+	packet[0] = BT_AD_MESH_DATA;
 	memcpy(packet + 1, data, size);
 
 	mesh_io_send(io, &info, packet, size + 1);
@@ -2292,7 +2292,7 @@ static void send_msg_pkt_oneshot(void *user_data)
 		return;
 	}
 
-	tx->packet[0] = MESH_AD_TYPE_NETWORK;
+	tx->packet[0] = BT_AD_MESH_DATA;
 	info.type = MESH_IO_TIMING_TYPE_GENERAL;
 	info.u.gen.interval = tx->interval;
 	info.u.gen.cnt = tx->cnt;
@@ -3003,9 +3003,9 @@ bool mesh_net_attach(struct mesh_net *net, struct mesh_io *io)
 
 	first = l_queue_isempty(nets);
 	if (first) {
-		const uint8_t snb[] = {MESH_AD_TYPE_BEACON, 1};
-		const uint8_t mpb[] = {MESH_AD_TYPE_BEACON, 2};
-		const uint8_t pkt[] = {MESH_AD_TYPE_NETWORK};
+		const uint8_t snb[] = {BT_AD_MESH_BEACON, 1};
+		const uint8_t mpb[] = {BT_AD_MESH_BEACON, 2};
+		const uint8_t pkt[] = {BT_AD_MESH_DATA};
 
 		if (!nets)
 			nets = l_queue_new();
@@ -3033,9 +3033,9 @@ bool mesh_net_attach(struct mesh_net *net, struct mesh_io *io)
 
 struct mesh_io *mesh_net_detach(struct mesh_net *net)
 {
-	const uint8_t snb[] = {MESH_AD_TYPE_BEACON, 1};
-	const uint8_t mpb[] = {MESH_AD_TYPE_BEACON, 2};
-	const uint8_t pkt[] = {MESH_AD_TYPE_NETWORK};
+	const uint8_t snb[] = {BT_AD_MESH_BEACON, 1};
+	const uint8_t mpb[] = {BT_AD_MESH_BEACON, 2};
+	const uint8_t pkt[] = {BT_AD_MESH_DATA};
 	struct mesh_io *io;
 	uint8_t type = 0;
 
diff --git a/mesh/pb-adv.c b/mesh/pb-adv.c
index 0b1fd7d577ff..1b80b97ad31c 100644
--- a/mesh/pb-adv.c
+++ b/mesh/pb-adv.c
@@ -16,6 +16,8 @@
 
 #include <ell/ell.h>
 
+#include "src/shared/ad.h"
+
 #include "mesh/mesh-defs.h"
 #include "mesh/crypto.h"
 #include "mesh/net.h"
@@ -97,7 +99,7 @@ struct idle_rx {
 
 static struct l_queue *pb_sessions = NULL;
 
-static const uint8_t filter[1] = { MESH_AD_TYPE_PROVISION };
+static const uint8_t filter[1] = { BT_AD_MESH_PROV };
 
 static void pb_adv_packet(void *user_data, const uint8_t *pkt, uint16_t len);
 
@@ -130,7 +132,7 @@ static void send_adv_segs(struct pb_adv_session *session, const uint8_t *data,
 							uint16_t size)
 {
 	uint16_t init_size;
-	uint8_t buf[PB_ADV_MTU + 6] = { MESH_AD_TYPE_PROVISION };
+	uint8_t buf[PB_ADV_MTU + 6] = { BT_AD_MESH_PROV };
 	uint8_t max_seg;
 	uint8_t consumed;
 	int i;
@@ -236,7 +238,7 @@ static void pb_adv_tx(void *user_data, const void *data, uint16_t len)
 
 static void send_open_req(struct pb_adv_session *session)
 {
-	struct pb_open_req open_req = { MESH_AD_TYPE_PROVISION };
+	struct pb_open_req open_req = { BT_AD_MESH_PROV };
 
 	l_put_be32(session->link_id, &open_req.link_id);
 	open_req.trans_num = 0;
@@ -251,7 +253,7 @@ static void send_open_req(struct pb_adv_session *session)
 
 static void send_open_cfm(struct pb_adv_session *session)
 {
-	struct pb_open_cfm open_cfm = { MESH_AD_TYPE_PROVISION };
+	struct pb_open_cfm open_cfm = { BT_AD_MESH_PROV };
 
 	l_put_be32(session->link_id, &open_cfm.link_id);
 	open_cfm.trans_num = 0;
@@ -265,7 +267,7 @@ static void send_open_cfm(struct pb_adv_session *session)
 
 static void send_ack(struct pb_adv_session *session, uint8_t trans_num)
 {
-	struct pb_ack ack = { MESH_AD_TYPE_PROVISION };
+	struct pb_ack ack = { BT_AD_MESH_PROV };
 
 	if (!l_queue_find(pb_sessions, session_match, session))
 		return;
@@ -280,7 +282,7 @@ static void send_ack(struct pb_adv_session *session, uint8_t trans_num)
 
 static void send_close_ind(struct pb_adv_session *session, uint8_t reason)
 {
-	struct pb_close_ind close_ind = { MESH_AD_TYPE_PROVISION };
+	struct pb_close_ind close_ind = { BT_AD_MESH_PROV };
 
 	if (!l_queue_find(pb_sessions, session_match, session))
 		return;
diff --git a/mesh/prov-acceptor.c b/mesh/prov-acceptor.c
index 650309b635cd..0cedc227ad28 100644
--- a/mesh/prov-acceptor.c
+++ b/mesh/prov-acceptor.c
@@ -16,6 +16,7 @@
 
 #include <ell/ell.h>
 
+#include "src/shared/ad.h"
 #include "src/shared/ecc.h"
 
 #include "mesh/mesh-defs.h"
@@ -50,8 +51,8 @@ struct deferred_cmd {
 	uint8_t cmd[];
 };
 
-static const uint8_t pkt_filter = MESH_AD_TYPE_PROVISION;
-static const uint8_t bec_filter[] = {MESH_AD_TYPE_BEACON,
+static const uint8_t pkt_filter = BT_AD_MESH_PROV;
+static const uint8_t bec_filter[] = {BT_AD_MESH_BEACON,
 						BEACON_TYPE_UNPROVISIONED};
 
 #define MAT_REMOTE_PUBLIC	0x01
@@ -736,8 +737,7 @@ bool acceptor_start(uint8_t num_ele, uint8_t *uuid,
 		void *caller_data)
 {
 	struct mesh_agent_prov_caps *caps;
-	uint8_t beacon[24] = {MESH_AD_TYPE_BEACON,
-						BEACON_TYPE_UNPROVISIONED};
+	uint8_t beacon[24] = {BT_AD_MESH_BEACON, BEACON_TYPE_UNPROVISIONED};
 	uint8_t len = sizeof(beacon) - sizeof(uint32_t);
 	bool result;
 
diff --git a/mesh/prov-initiator.c b/mesh/prov-initiator.c
index dc19d1e9b7a5..c0d2de443ac1 100644
--- a/mesh/prov-initiator.c
+++ b/mesh/prov-initiator.c
@@ -16,6 +16,7 @@
 
 #include <ell/ell.h>
 
+#include "src/shared/ad.h"
 #include "src/shared/ecc.h"
 
 #include "mesh/mesh-defs.h"
@@ -51,7 +52,7 @@ static const uint16_t expected_pdu_size[] = {
 
 #define BEACON_TYPE_UNPROVISIONED		0x00
 
-static const uint8_t pkt_filter = MESH_AD_TYPE_PROVISION;
+static const uint8_t pkt_filter = BT_AD_MESH_PROV;
 
 enum int_state {
 	INT_PROV_IDLE = 0,
-- 
2.43.0

