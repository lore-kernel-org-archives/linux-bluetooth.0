Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC041C7EE2A
	for <linux-bluetooth@archiver.kernel.org>; Sun, 21 May 2023 15:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjEUP1t (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 21 May 2023 11:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjEUP1q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 21 May 2023 11:27:46 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2106ADC
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 May 2023 08:27:44 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 904AD240027
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 May 2023 17:27:41 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4QPPbK0sZJz9rxG;
        Sun, 21 May 2023 17:27:41 +0200 (CEST)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 3/5] btdev: support multiple CIG
Date:   Sun, 21 May 2023 15:27:36 +0000
Message-Id: <69699803f6450633d1b33ccef57fd81f77eee137.1684682575.git.pav@iki.fi>
In-Reply-To: <024df2d86c14fc811701ba27bfa576476bc9c0d6.1684682575.git.pav@iki.fi>
References: <024df2d86c14fc811701ba27bfa576476bc9c0d6.1684682575.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add support for more than one CIG simultaneously.
---
 emulator/btdev.c | 144 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 108 insertions(+), 36 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 7980a5280..0eec1d9f2 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -42,6 +42,7 @@
 #define RL_SIZE			16
 #define CIS_SIZE		3
 #define BIS_SIZE		3
+#define CIG_SIZE		3
 
 #define has_bredr(btdev)	(!((btdev)->features[4] & 0x20))
 #define has_le(btdev)		(!!((btdev)->features[4] & 0x40))
@@ -101,6 +102,11 @@ struct le_ext_adv {
 	unsigned int id;
 };
 
+struct le_cig {
+	struct bt_hci_cmd_le_set_cig_params params;
+	struct bt_hci_cis_params cis[CIS_SIZE];
+} __attribute__ ((packed));
+
 struct btdev {
 	enum btdev_type type;
 	uint16_t id;
@@ -204,10 +210,7 @@ struct btdev {
 	uint16_t le_pa_sync_handle;
 	uint8_t  big_handle;
 	uint8_t  le_ltk[16];
-	struct {
-		struct bt_hci_cmd_le_set_cig_params params;
-		struct bt_hci_cis_params cis[CIS_SIZE];
-	} __attribute__ ((packed)) le_cig;
+	struct le_cig le_cig[CIG_SIZE];
 	uint8_t  le_iso_path[2];
 
 	/* Real time length of AL array */
@@ -5757,6 +5760,36 @@ static int cmd_read_iso_tx_sync(struct btdev *dev, const void *data,
 	return -ENOTSUP;
 }
 
+static int find_cig(struct btdev *dev, uint8_t cig_id)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(dev->le_cig); ++i)
+		if (dev->le_cig[i].params.cig_id == cig_id)
+			return i;
+	return -1;
+}
+
+static uint16_t make_cis_handle(uint8_t cig_idx, uint8_t cis_idx)
+{
+	/* Put CIG+CIS idxs to handle so don't need to track separately */
+	return ISO_HANDLE + cig_idx*CIS_SIZE + cis_idx;
+}
+
+static int parse_cis_handle(uint16_t handle, int *cis_idx)
+{
+	int cig_idx;
+
+	if (handle < ISO_HANDLE || handle >= ISO_HANDLE + CIS_SIZE*CIG_SIZE)
+		return -1;
+
+	cig_idx = (handle - ISO_HANDLE) / CIS_SIZE;
+	if (cis_idx)
+		*cis_idx = (handle - ISO_HANDLE) % CIS_SIZE;
+
+	return cig_idx;
+}
+
 static int cmd_set_cig_params(struct btdev *dev, const void *data,
 							uint8_t len)
 {
@@ -5766,12 +5799,13 @@ static int cmd_set_cig_params(struct btdev *dev, const void *data,
 		uint16_t handle[CIS_SIZE];
 	} __attribute__ ((packed)) rsp;
 	int i = 0;
+	int cig_idx;
 	uint32_t interval;
 	uint16_t latency;
 
 	memset(&rsp, 0, sizeof(rsp));
 
-	if (cmd->num_cis > ARRAY_SIZE(dev->le_cig.cis)) {
+	if (cmd->num_cis > ARRAY_SIZE(dev->le_cig[0].cis)) {
 		rsp.params.status = BT_HCI_ERR_MEM_CAPACITY_EXCEEDED;
 		goto done;
 	}
@@ -5820,14 +5854,14 @@ static int cmd_set_cig_params(struct btdev *dev, const void *data,
 		goto done;
 	}
 
-	if (dev->le_cig.params.cig_id != 0xff &&
-				dev->le_cig.params.cig_id != cmd->cig_id) {
-		rsp.params.status = BT_HCI_ERR_INVALID_PARAMETERS;
+	cig_idx = find_cig(dev, cmd->cig_id);
+	if (cig_idx < 0)
+		cig_idx = find_cig(dev, 0xff);
+	if (cig_idx < 0) {
+		rsp.params.status = BT_HCI_ERR_MEM_CAPACITY_EXCEEDED;
 		goto done;
 	}
 
-	memcpy(&dev->le_cig, data, len);
-
 	rsp.params.status = BT_HCI_ERR_SUCCESS;
 	rsp.params.cig_id = cmd->cig_id;
 
@@ -5835,7 +5869,7 @@ static int cmd_set_cig_params(struct btdev *dev, const void *data,
 		struct btdev_conn *iso;
 
 		rsp.params.num_handles++;
-		rsp.handle[i] = cpu_to_le16(ISO_HANDLE + i);
+		rsp.handle[i] = cpu_to_le16(make_cis_handle(cig_idx, i));
 
 		/* BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
 		 * page 2553
@@ -5845,14 +5879,16 @@ static int cmd_set_cig_params(struct btdev *dev, const void *data,
 		 * code Command Disallowed (0x0C).
 		 */
 		iso = queue_find(dev->conns, match_handle,
-				UINT_TO_PTR(cpu_to_le16(rsp.handle[i])));
+				UINT_TO_PTR(le16_to_cpu(rsp.handle[i])));
 		if (iso) {
-			rsp.params.status = BT_HCI_ERR_INVALID_PARAMETERS;
+			rsp.params.status = BT_HCI_ERR_COMMAND_DISALLOWED;
 			i = 0;
 			goto done;
 		}
 	}
 
+	memcpy(&dev->le_cig[cig_idx], data, len);
+
 done:
 	cmd_complete(dev, BT_HCI_CMD_LE_SET_CIG_PARAMS, &rsp,
 				sizeof(rsp.params) + (i * sizeof(uint16_t)));
@@ -5878,35 +5914,40 @@ static void le_cis_estabilished(struct btdev *dev, struct btdev_conn *conn,
 						uint8_t status)
 {
 	struct bt_hci_evt_le_cis_established evt;
+	int cig_idx, cis_idx;
 
 	memset(&evt, 0, sizeof(evt));
 
 	evt.status = status;
 	evt.conn_handle = conn ? cpu_to_le16(conn->handle) : 0x0000;
 
+	cig_idx = conn ? parse_cis_handle(conn->link->handle, &cis_idx) : -1;
+	if (cig_idx < 0 && !evt.status)
+		evt.status = BT_HCI_ERR_UNSPECIFIED_ERROR;
+
 	if (!evt.status) {
 		struct btdev *remote = conn->link->dev;
-		int i = conn->handle - ISO_HANDLE;
+		struct le_cig *le_cig = &remote->le_cig[cig_idx];
 
 		/* TODO: Figure out if these values makes sense */
-		memcpy(evt.cig_sync_delay, remote->le_cig.params.c_interval,
-				sizeof(remote->le_cig.params.c_interval));
-		memcpy(evt.cis_sync_delay, remote->le_cig.params.p_interval,
-				sizeof(remote->le_cig.params.p_interval));
-		memcpy(evt.c_latency, &remote->le_cig.params.c_interval,
-				sizeof(remote->le_cig.params.c_interval));
-		memcpy(evt.p_latency, &remote->le_cig.params.p_interval,
-				sizeof(remote->le_cig.params.p_interval));
-		evt.c_phy = remote->le_cig.cis[i].c_phy;
-		evt.p_phy = remote->le_cig.cis[i].p_phy;
+		memcpy(evt.cig_sync_delay, le_cig->params.c_interval,
+				sizeof(le_cig->params.c_interval));
+		memcpy(evt.cis_sync_delay, le_cig->params.p_interval,
+				sizeof(le_cig->params.p_interval));
+		memcpy(evt.c_latency, &le_cig->params.c_interval,
+				sizeof(le_cig->params.c_interval));
+		memcpy(evt.p_latency, &le_cig->params.p_interval,
+				sizeof(le_cig->params.p_interval));
+		evt.c_phy = le_cig->cis[cis_idx].c_phy;
+		evt.p_phy = le_cig->cis[cis_idx].p_phy;
 		evt.nse = 0x01;
 		evt.c_bn = 0x01;
 		evt.p_bn = 0x01;
 		evt.c_ft = 0x01;
 		evt.p_ft = 0x01;
-		evt.c_mtu = remote->le_cig.cis[i].c_sdu;
-		evt.p_mtu = remote->le_cig.cis[i].p_sdu;
-		evt.interval = remote->le_cig.params.c_latency;
+		evt.c_mtu = le_cig->cis[cis_idx].c_sdu;
+		evt.p_mtu = le_cig->cis[cis_idx].p_sdu;
+		evt.interval = le_cig->params.c_latency;
 	}
 
 	le_meta_event(dev, BT_HCI_EVT_LE_CIS_ESTABLISHED, &evt, sizeof(evt));
@@ -5927,9 +5968,20 @@ static int cmd_create_cis_complete(struct btdev *dev, const void *data,
 		struct btdev_conn *acl;
 		struct btdev_conn *iso;
 		struct bt_hci_evt_le_cis_req evt;
+		struct le_cig *le_cig;
+		int cig_idx, cis_idx;
+
+		cig_idx = parse_cis_handle(le16_to_cpu(cis->cis_handle),
+								&cis_idx);
+		if (cig_idx < 0) {
+			le_cis_estabilished(dev, NULL,
+						BT_HCI_ERR_UNKNOWN_CONN_ID);
+			break;
+		}
+		le_cig = &dev->le_cig[cig_idx];
 
 		acl = queue_find(dev->conns, match_handle,
-				UINT_TO_PTR(cpu_to_le16(cis->acl_handle)));
+				UINT_TO_PTR(le16_to_cpu(cis->acl_handle)));
 		if (!acl) {
 			le_cis_estabilished(dev, NULL,
 						BT_HCI_ERR_UNKNOWN_CONN_ID);
@@ -5937,9 +5989,9 @@ static int cmd_create_cis_complete(struct btdev *dev, const void *data,
 		}
 
 		iso = queue_find(dev->conns, match_handle,
-				UINT_TO_PTR(cpu_to_le16(cis->cis_handle)));
+				UINT_TO_PTR(le16_to_cpu(cis->cis_handle)));
 		if (!iso) {
-			iso = conn_add_cis(acl, cpu_to_le16(cis->cis_handle));
+			iso = conn_add_cis(acl, le16_to_cpu(cis->cis_handle));
 			if (!iso) {
 				le_cis_estabilished(dev, NULL,
 						BT_HCI_ERR_UNKNOWN_CONN_ID);
@@ -5949,8 +6001,8 @@ static int cmd_create_cis_complete(struct btdev *dev, const void *data,
 
 		evt.acl_handle = cpu_to_le16(acl->handle);
 		evt.cis_handle = cpu_to_le16(iso->handle);
-		evt.cig_id = iso->dev->le_cig.params.cig_id;
-		evt.cis_id = iso->dev->le_cig.cis[i].cis_id;
+		evt.cig_id = le_cig->params.cig_id;
+		evt.cis_id = le_cig->cis[cis_idx].cis_id;
 
 		le_meta_event(iso->link->dev, BT_HCI_EVT_LE_CIS_REQ, &evt,
 					sizeof(evt));
@@ -5959,20 +6011,37 @@ static int cmd_create_cis_complete(struct btdev *dev, const void *data,
 	return 0;
 }
 
+static bool match_handle_cig_idx(const void *data, const void *match_data)
+{
+	const struct btdev_conn *conn = data;
+	int cig_idx = PTR_TO_INT(match_data);
+
+	return cig_idx >= 0 && parse_cis_handle(conn->handle, NULL) == cig_idx;
+}
+
 static int cmd_remove_cig(struct btdev *dev, const void *data, uint8_t len)
 {
 	const struct bt_hci_cmd_le_remove_cig *cmd = data;
 	struct bt_hci_rsp_le_remove_cig rsp;
+	struct btdev_conn *conn = NULL;
+	int idx;
 
-	memset(&dev->le_cig, 0, sizeof(dev->le_cig));
 	memset(&rsp, 0, sizeof(rsp));
 
 	rsp.cig_id = cmd->cig_id;
 
-	if (dev->le_cig.params.cig_id == cmd->cig_id)
+	idx = find_cig(dev, cmd->cig_id);
+	conn = queue_find(dev->conns, match_handle_cig_idx, INT_TO_PTR(idx));
+
+	if (idx >= 0 && !conn) {
+		memset(&dev->le_cig[idx], 0, sizeof(struct le_cig));
+		dev->le_cig[idx].params.cig_id = 0xff;
 		rsp.status = BT_HCI_ERR_SUCCESS;
-	else
+	} else if (conn) {
+		rsp.status = BT_HCI_ERR_COMMAND_DISALLOWED;
+	} else {
 		rsp.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+	}
 
 	cmd_complete(dev, BT_HCI_CMD_LE_REMOVE_CIG, &rsp, sizeof(rsp));
 
@@ -6842,6 +6911,7 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 {
 	struct btdev *btdev;
 	int index;
+	unsigned int i;
 
 	btdev = malloc(sizeof(*btdev));
 	if (!btdev)
@@ -6909,9 +6979,11 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 
 	btdev->iso_mtu = 251;
 	btdev->iso_max_pkt = 1;
-	btdev->le_cig.params.cig_id = 0xff;
 	btdev->big_handle = 0xff;
 
+	for (i = 0; i < ARRAY_SIZE(btdev->le_cig); ++i)
+		btdev->le_cig[i].params.cig_id = 0xff;
+
 	btdev->country_code = 0x00;
 
 	index = add_btdev(btdev);
-- 
2.40.1

