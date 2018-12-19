Return-Path: <SRS0=/IWC=O4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F67CC43612
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 04:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 774C621871
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 04:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbeLSEVX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Dec 2018 23:21:23 -0500
Received: from mga04.intel.com ([192.55.52.120]:4125 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727189AbeLSEVX (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Dec 2018 23:21:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2018 20:21:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,371,1539673200"; 
   d="scan'208";a="99820177"
Received: from bgix-dell-lap.sea.intel.com ([10.252.192.41])
  by orsmga007.jf.intel.com with ESMTP; 18 Dec 2018 20:21:07 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     johan.hedberg@gmail.com, inga.stotland@intel.com,
        marcel@holtmann.org, brian.gix@intel.com
Subject: [PATCH BlueZ v5 11/30] mesh: Rewrite Controler interface for full init
Date:   Tue, 18 Dec 2018 20:19:57 -0800
Message-Id: <20181219042016.25538-12-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181219042016.25538-1-brian.gix@intel.com>
References: <20181219042016.25538-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/mesh-io-generic.c | 149 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 138 insertions(+), 11 deletions(-)

diff --git a/mesh/mesh-io-generic.c b/mesh/mesh-io-generic.c
index 52514e280..48e47e7a4 100644
--- a/mesh/mesh-io-generic.c
+++ b/mesh/mesh-io-generic.c
@@ -30,7 +30,6 @@
 #include "monitor/bt.h"
 #include "src/shared/hci.h"
 
-#include "mesh/display.h"
 #include "mesh/mesh-io.h"
 #include "mesh/mesh-io-api.h"
 
@@ -177,6 +176,116 @@ static void event_callback(const void *buf, uint8_t size, void *user_data)
 	}
 }
 
+static void local_commands_callback(const void *data, uint8_t size,
+							void *user_data)
+{
+	const struct bt_hci_rsp_read_local_commands *rsp = data;
+
+	if (rsp->status)
+		l_error("Failed to read local commands");
+}
+
+static void local_features_callback(const void *data, uint8_t size,
+							void *user_data)
+{
+	const struct bt_hci_rsp_read_local_features *rsp = data;
+
+	if (rsp->status)
+		l_error("Failed to read local features");
+}
+
+static void hci_generic_callback(const void *data, uint8_t size,
+								void *user_data)
+{
+	uint8_t status = l_get_u8(data);
+
+	if (status)
+		l_error("Failed to initialize HCI");
+}
+
+static void configure_hci(struct mesh_io_private *io)
+{
+	struct bt_hci_cmd_le_set_scan_parameters cmd;
+	struct bt_hci_cmd_set_event_mask cmd_sem;
+	struct bt_hci_cmd_le_set_event_mask cmd_slem;
+
+	/* Set scan parameters */
+	cmd.type = 0x00; /* Passive Scanning. No scanning PDUs shall be sent */
+	cmd.interval = 0x0030; /* Scan Interval = N * 0.625ms */
+	cmd.window = 0x0030; /* Scan Window = N * 0.625ms */
+	cmd.own_addr_type = 0x00; /* Public Device Address */
+	/* Accept all advertising packets except directed advertising packets
+	 * not addressed to this device (default).
+	 */
+	cmd.filter_policy = 0x00;
+
+	/* Set event mask
+	 *
+	 * Mask: 0x2000800002008890
+	 *   Disconnection Complete
+	 *   Encryption Change
+	 *   Read Remote Version Information Complete
+	 *   Hardware Error
+	 *   Data Buffer Overflow
+	 *   Encryption Key Refresh Complete
+	 *   LE Meta
+	 */
+	cmd_sem.mask[0] = 0x90;
+	cmd_sem.mask[1] = 0x88;
+	cmd_sem.mask[2] = 0x00;
+	cmd_sem.mask[3] = 0x02;
+	cmd_sem.mask[4] = 0x00;
+	cmd_sem.mask[5] = 0x80;
+	cmd_sem.mask[6] = 0x00;
+	cmd_sem.mask[7] = 0x20;
+
+	/* Set LE event mask
+	 *
+	 * Mask: 0x000000000000087f
+	 *   LE Connection Complete
+	 *   LE Advertising Report
+	 *   LE Connection Update Complete
+	 *   LE Read Remote Used Features Complete
+	 *   LE Long Term Key Request
+	 *   LE Remote Connection Parameter Request
+	 *   LE Data Length Change
+	 *   LE PHY Update Complete
+	 */
+	cmd_slem.mask[0] = 0x7f;
+	cmd_slem.mask[1] = 0x08;
+	cmd_slem.mask[2] = 0x00;
+	cmd_slem.mask[3] = 0x00;
+	cmd_slem.mask[4] = 0x00;
+	cmd_slem.mask[5] = 0x00;
+	cmd_slem.mask[6] = 0x00;
+	cmd_slem.mask[7] = 0x00;
+
+	/* TODO: Move to suitable place. Set suitable masks */
+	/* Reset Command */
+	bt_hci_send(io->hci, BT_HCI_CMD_RESET, NULL, 0, hci_generic_callback,
+								NULL, NULL);
+
+	/* Read local supported commands */
+	bt_hci_send(io->hci, BT_HCI_CMD_READ_LOCAL_COMMANDS, NULL, 0,
+					local_commands_callback, NULL, NULL);
+
+	/* Read local supported features */
+	bt_hci_send(io->hci, BT_HCI_CMD_READ_LOCAL_FEATURES, NULL, 0,
+					local_features_callback, NULL, NULL);
+
+	/* Set event mask */
+	bt_hci_send(io->hci, BT_HCI_CMD_SET_EVENT_MASK, &cmd_sem,
+			sizeof(cmd_sem), hci_generic_callback, NULL, NULL);
+
+	/* Set LE event mask */
+	bt_hci_send(io->hci, BT_HCI_CMD_LE_SET_EVENT_MASK, &cmd_slem,
+			sizeof(cmd_slem), hci_generic_callback, NULL, NULL);
+
+	/* Scan Params */
+	bt_hci_send(io->hci, BT_HCI_CMD_LE_SET_SCAN_PARAMETERS, &cmd,
+				sizeof(cmd), hci_generic_callback, NULL, NULL);
+}
+
 static bool dev_init(uint16_t index, struct mesh_io *io)
 {
 	struct mesh_io_private *tmp;
@@ -198,6 +307,8 @@ static bool dev_init(uint16_t index, struct mesh_io *io)
 	if (!tmp->hci)
 		goto fail;
 
+	configure_hci(tmp);
+
 	bt_hci_register(tmp->hci, BT_HCI_EVT_LE_META_EVENT,
 						event_callback, io, NULL);
 
@@ -480,7 +591,6 @@ static bool send_tx(struct mesh_io *io, struct mesh_io_send_info *info,
 	if (!info || !data || !len || len > sizeof(tx->pkt))
 		return false;
 
-
 	tx = l_new(struct tx_pkt, 1);
 	if (!tx)
 		return false;
@@ -524,7 +634,7 @@ static bool find_by_pattern(const void *a, const void *b)
 	return (!memcmp(tx->pkt, pattern->data, pattern->len));
 }
 
-static bool tx_cancel(struct mesh_io *io, uint8_t *data, uint8_t len)
+static bool tx_cancel(struct mesh_io *io, const uint8_t *data, uint8_t len)
 {
 	struct mesh_io_private *pvt = io->pvt;
 	struct tx_pkt *tx;
@@ -568,13 +678,25 @@ static bool find_by_filter_id(const void *a, const void *b)
 	return rx_reg->filter_id == filter_id;
 }
 
+static void set_recv_scan_enable(const void *buf, uint8_t size,
+							void *user_data)
+{
+	struct mesh_io_private *pvt = user_data;
+	struct bt_hci_cmd_le_set_scan_enable cmd;
+
+	cmd.enable = 0x01;	/* Enable scanning */
+	cmd.filter_dup = 0x00;	/* Report duplicates */
+	bt_hci_send(pvt->hci, BT_HCI_CMD_LE_SET_SCAN_ENABLE,
+			&cmd, sizeof(cmd), NULL, NULL, NULL);
+}
+
 static bool recv_register(struct mesh_io *io, uint8_t filter_id,
 				mesh_io_recv_func_t cb, void *user_data)
 {
-	struct bt_hci_cmd_le_set_scan_enable cmd;
+	struct bt_hci_cmd_le_set_scan_parameters cmd;
 	struct mesh_io_private *pvt = io->pvt;
 	struct pvt_rx_reg *rx_reg;
-	bool scanning;
+	bool already_scanning;
 
 	l_info("%s %d", __func__, filter_id);
 	if (!cb || !filter_id || filter_id > sizeof(pvt->filters))
@@ -593,15 +715,20 @@ static bool recv_register(struct mesh_io *io, uint8_t filter_id,
 	rx_reg->cb = cb;
 	rx_reg->user_data = user_data;
 
-	scanning = !l_queue_isempty(pvt->rx_regs);
+	already_scanning = !l_queue_isempty(pvt->rx_regs);
 
 	l_queue_push_head(pvt->rx_regs, rx_reg);
 
-	if (!scanning) {
-		cmd.enable = 0x01;	/* Enable scanning */
-		cmd.filter_dup = 0x00;	/* Report duplicates */
-		bt_hci_send(pvt->hci, BT_HCI_CMD_LE_SET_SCAN_ENABLE,
-				&cmd, sizeof(cmd), NULL, NULL, NULL);
+	if (!already_scanning) {
+		cmd.type = 0x00;			/* Passive scanning */
+		cmd.interval = L_CPU_TO_LE16(0x0010);	/* 10 ms */
+		cmd.window = L_CPU_TO_LE16(0x0010);	/* 10 ms */
+		cmd.own_addr_type = 0x01;		/* ADDR_TYPE_RANDOM */
+		cmd.filter_policy = 0x00;		/* Accept all */
+
+		bt_hci_send(pvt->hci, BT_HCI_CMD_LE_SET_SCAN_PARAMETERS,
+				&cmd, sizeof(cmd),
+				set_recv_scan_enable, pvt, NULL);
 	}
 
 	return true;
-- 
2.14.5

