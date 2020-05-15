Return-Path: <SRS0=w0Ns=65=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA07DC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 May 2020 17:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9617F20657
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 May 2020 17:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgEORmH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 May 2020 13:42:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:51396 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgEORl6 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 May 2020 13:41:58 -0400
IronPort-SDR: v2fbpxlHZOlrkFguuPHofH7HIJ0EpNFyg0seJo+cbkush+0q5B6LHw8toPhxG6In4+z9VkOCi7
 ACMLl+RdN7dA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 10:41:57 -0700
IronPort-SDR: fAHq7V4ctC678Y3SDrkv5DtVijh/dCo13n0/doT6t/s0sHm0UJau9EalP8h3iYcruczvdf1cRq
 e+1yenoOzqHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,396,1583222400"; 
   d="scan'208";a="464801421"
Received: from mmoiseev-mobl.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.254.65.208])
  by fmsmga005.fm.intel.com with ESMTP; 15 May 2020 10:41:57 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2] mesh: Fix segfault caused by re-enabling of HCI controller
Date:   Fri, 15 May 2020 10:41:56 -0700
Message-Id: <20200515174156.11958-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes the crash that occurs when a controller used by bluetooth-meshd
is removed and then added back again.

Also, correctly restart scanning when the controller is re-enabled.

Backtrace:
0x00005618e754d040 in ?? ()
0x00005618e6e12d9a in io_ready_callback () at mesh/mesh.c:174
0x00005618e6e3d2c8 in l_queue_foreach () at ell/queue.c:441
0x00005618e6e37927 in request_complete () at src/shared/mgmt.c:261
---
 mesh/mesh-io-generic.c | 135 ++++++++++++++++++++++++-----------------
 mesh/mesh.c            |   9 ++-
 2 files changed, 87 insertions(+), 57 deletions(-)

diff --git a/mesh/mesh-io-generic.c b/mesh/mesh-io-generic.c
index 2efd32f12..3ad130567 100644
--- a/mesh/mesh-io-generic.c
+++ b/mesh/mesh-io-generic.c
@@ -287,10 +287,86 @@ static void configure_hci(struct mesh_io_private *io)
 				sizeof(cmd), hci_generic_callback, NULL, NULL);
 }
 
+static void scan_enable_rsp(const void *buf, uint8_t size,
+							void *user_data)
+{
+	uint8_t status = *((uint8_t *) buf);
+
+	if (status)
+		l_error("LE Scan enable failed (0x%02x)", status);
+}
+
+static void set_recv_scan_enable(const void *buf, uint8_t size,
+							void *user_data)
+{
+	struct mesh_io_private *pvt = user_data;
+	struct bt_hci_cmd_le_set_scan_enable cmd;
+
+	cmd.enable = 0x01;	/* Enable scanning */
+	cmd.filter_dup = 0x00;	/* Report duplicates */
+	bt_hci_send(pvt->hci, BT_HCI_CMD_LE_SET_SCAN_ENABLE,
+			&cmd, sizeof(cmd), scan_enable_rsp, pvt, NULL);
+}
+
+static void scan_disable_rsp(const void *buf, uint8_t size,
+							void *user_data)
+{
+	struct bt_hci_cmd_le_set_scan_parameters cmd;
+	struct mesh_io_private *pvt = user_data;
+	uint8_t status = *((uint8_t *) buf);
+
+	if (status)
+		l_error("LE Scan disable failed (0x%02x)", status);
+
+	cmd.type = pvt->active ? 0x01 : 0x00;	/* Passive/Active scanning */
+	cmd.interval = L_CPU_TO_LE16(0x0010);	/* 10 ms */
+	cmd.window = L_CPU_TO_LE16(0x0010);	/* 10 ms */
+	cmd.own_addr_type = 0x01;		/* ADDR_TYPE_RANDOM */
+	cmd.filter_policy = 0x00;		/* Accept all */
+
+	bt_hci_send(pvt->hci, BT_HCI_CMD_LE_SET_SCAN_PARAMETERS,
+			&cmd, sizeof(cmd),
+			set_recv_scan_enable, pvt, NULL);
+}
+
+static bool find_active(const void *a, const void *b)
+{
+	const struct pvt_rx_reg *rx_reg = a;
+
+	/* Mesh specific AD types do *not* require active scanning,
+	 * so do not turn on Active Scanning on their account.
+	 */
+	if (rx_reg->filter[0] < MESH_AD_TYPE_PROVISION ||
+			rx_reg->filter[0] > MESH_AD_TYPE_BEACON)
+		return true;
+
+	return false;
+}
+
+static void restart_scan(struct mesh_io_private *pvt)
+{
+	struct bt_hci_cmd_le_set_scan_enable cmd;
+
+	if (l_queue_isempty(pvt->rx_regs))
+		return;
+
+	pvt->active = l_queue_find(pvt->rx_regs, find_active, NULL);
+	cmd.enable = 0x00;	/* Disable scanning */
+	cmd.filter_dup = 0x00;	/* Report duplicates */
+	bt_hci_send(pvt->hci, BT_HCI_CMD_LE_SET_SCAN_ENABLE,
+				&cmd, sizeof(cmd), scan_disable_rsp, pvt, NULL);
+}
+
 static void hci_init(void *user_data)
 {
 	struct mesh_io *io = user_data;
 	bool result = true;
+	bool restarted = false;
+
+	if (io->pvt->hci) {
+		restarted = true;
+		bt_hci_unref(io->pvt->hci);
+	}
 
 	io->pvt->hci = bt_hci_new_user_channel(io->pvt->index);
 	if (!io->pvt->hci) {
@@ -306,6 +382,9 @@ static void hci_init(void *user_data)
 						event_callback, io, NULL);
 
 		l_debug("Started mesh on hci %u", io->pvt->index);
+
+		if (restarted)
+			restart_scan(io->pvt);
 	}
 
 	if (io->pvt->ready_callback)
@@ -713,62 +792,6 @@ static bool find_by_filter(const void *a, const void *b)
 	return !memcmp(rx_reg->filter, filter, rx_reg->len);
 }
 
-static void scan_enable_rsp(const void *buf, uint8_t size,
-							void *user_data)
-{
-	uint8_t status = *((uint8_t *) buf);
-
-	if (status)
-		l_error("LE Scan enable failed (0x%02x)", status);
-}
-
-static void set_recv_scan_enable(const void *buf, uint8_t size,
-							void *user_data)
-{
-	struct mesh_io_private *pvt = user_data;
-	struct bt_hci_cmd_le_set_scan_enable cmd;
-
-	cmd.enable = 0x01;	/* Enable scanning */
-	cmd.filter_dup = 0x00;	/* Report duplicates */
-	bt_hci_send(pvt->hci, BT_HCI_CMD_LE_SET_SCAN_ENABLE,
-			&cmd, sizeof(cmd), scan_enable_rsp, pvt, NULL);
-}
-
-static void scan_disable_rsp(const void *buf, uint8_t size,
-							void *user_data)
-{
-	struct bt_hci_cmd_le_set_scan_parameters cmd;
-	struct mesh_io_private *pvt = user_data;
-	uint8_t status = *((uint8_t *) buf);
-
-	if (status)
-		l_error("LE Scan disable failed (0x%02x)", status);
-
-	cmd.type = pvt->active ? 0x01 : 0x00;	/* Passive/Active scanning */
-	cmd.interval = L_CPU_TO_LE16(0x0010);	/* 10 ms */
-	cmd.window = L_CPU_TO_LE16(0x0010);	/* 10 ms */
-	cmd.own_addr_type = 0x01;		/* ADDR_TYPE_RANDOM */
-	cmd.filter_policy = 0x00;		/* Accept all */
-
-	bt_hci_send(pvt->hci, BT_HCI_CMD_LE_SET_SCAN_PARAMETERS,
-			&cmd, sizeof(cmd),
-			set_recv_scan_enable, pvt, NULL);
-}
-
-static bool find_active(const void *a, const void *b)
-{
-	const struct pvt_rx_reg *rx_reg = a;
-
-	/* Mesh specific AD types do *not* require active scanning,
-	 * so do not turn on Active Scanning on their account.
-	 */
-	if (rx_reg->filter[0] < MESH_AD_TYPE_PROVISION ||
-			rx_reg->filter[0] > MESH_AD_TYPE_BEACON)
-		return true;
-
-	return false;
-}
-
 static bool recv_register(struct mesh_io *io, const uint8_t *filter,
 			uint8_t len, mesh_io_recv_func_t cb, void *user_data)
 {
diff --git a/mesh/mesh.c b/mesh/mesh.c
index 890a3aa8f..0a8ea970d 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -66,6 +66,7 @@ struct bt_mesh {
 	uint16_t req_index;
 	uint8_t friend_queue_sz;
 	uint8_t max_filters;
+	bool initialized;
 };
 
 struct join_data{
@@ -91,7 +92,8 @@ static struct bt_mesh mesh = {
 	.lpn_support = false,
 	.proxy_support = false,
 	.crpl = DEFAULT_CRPL,
-	.friend_queue_sz = DEFAULT_FRIEND_QUEUE_SZ
+	.friend_queue_sz = DEFAULT_FRIEND_QUEUE_SZ,
+	.initialized = false
 };
 
 /* We allow only one outstanding Join request */
@@ -168,6 +170,11 @@ static void io_ready_callback(void *user_data, bool result)
 {
 	struct mesh_init_request *req = user_data;
 
+	if (mesh.initialized)
+		return;
+
+	mesh.initialized = true;
+
 	if (result)
 		node_attach_io_all(mesh.io);
 
-- 
2.26.2

