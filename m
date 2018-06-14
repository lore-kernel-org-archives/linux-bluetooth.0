Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH BlueZ v3 07/11] emulator: Add 5.0 feature support
Date: Thu, 14 Jun 2018 17:51:20 +0530
Message-Id: <1528978884-3882-8-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1528978884-3882-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1528978884-3882-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds new hciemu for BT 5.0. Also adds extended advertising,
scanning and connection support in btdev and bthost
---
 emulator/btdev.c  | 448 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 emulator/btdev.h  |   1 +
 emulator/bthost.c |  99 ++++++++++++
 emulator/bthost.h |   7 +
 emulator/hciemu.c |   3 +
 emulator/hciemu.h |   1 +
 monitor/bt.h      |   1 +
 7 files changed, 550 insertions(+), 10 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 69d84a5..99bdb4b 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -145,6 +145,8 @@ struct btdev {
 	uint16_t sync_train_interval;
 	uint32_t sync_train_timeout;
 	uint8_t  sync_train_service_data;
+
+	uint16_t le_ext_adv_type;
 };
 
 struct inquiry_data {
@@ -450,6 +452,32 @@ static void set_le_commands(struct btdev *btdev)
 	/* Extra LE commands for >= 4.2 adapters */
 	btdev->commands[34] |= 0x02;	/* LE Read Local P-256 Public Key */
 	btdev->commands[34] |= 0x04;	/* LE Generate DHKey */
+
+	/* Extra LE commands for >= 5.0 adapters */
+	if (btdev->type >= BTDEV_TYPE_BREDRLE50) {
+		btdev->commands[36] |= 0x02;	/* LE Set Advertising Set Random Address */
+		btdev->commands[36] |= 0x04;	/* LE Set Extended Advertising Parameters */
+		btdev->commands[36] |= 0x08;	/* LE Set Extended Advertising Data */
+		btdev->commands[36] |= 0x10;	/* LE Set Extended Scan Response Data */
+		btdev->commands[36] |= 0x20;	/* LE Set Extended Advertising Enable */
+		btdev->commands[36] |= 0x40;	/* LE Read Maximum Advertising Data Length */
+		btdev->commands[36] |= 0x80;	/* LE Read Number of Supported Advertising Sets */
+		btdev->commands[37] |= 0x01;	/* LE Remove Advertising Set */
+		btdev->commands[37] |= 0x02;	/* LE Clear Advertising Sets */
+		btdev->commands[37] |= 0x04;	/* LE Set Periodic Advertising Parameters */
+		btdev->commands[37] |= 0x08;	/* LE Set Periodic Advertising Data */
+		btdev->commands[37] |= 0x10;	/* LE Set Periodic Advertising Enable */
+		btdev->commands[37] |= 0x20;	/* LE Set Extended Scan Parameters */
+		btdev->commands[37] |= 0x40;	/* LE Set Extended Scan Enable */
+		btdev->commands[37] |= 0x80;	/* LE Extended Create Connection */
+		btdev->commands[38] |= 0x01;	/* LE Periodic Advertising Create Sync */
+		btdev->commands[38] |= 0x02;	/* LE Periodic Advertising Create Sync Cancel */
+		btdev->commands[38] |= 0x04;	/* LE Periodic Advertising Terminate Sync */
+		btdev->commands[38] |= 0x08;	/* LE Add Device To Periodic Advertiser List */
+		btdev->commands[38] |= 0x10;	/* LE Remove Device From Periodic Advertiser List */
+		btdev->commands[38] |= 0x20;	/* LE Clear Periodic Advertiser List */
+		btdev->commands[38] |= 0x40;	/* LE Read Periodic Advertiser List Size */
+	}
 }
 
 static void set_bredrle_commands(struct btdev *btdev)
@@ -502,6 +530,12 @@ static void set_bredrle_features(struct btdev *btdev)
 	btdev->features[7] |= 0x02;	/* Inquiry TX Power Level */
 	btdev->features[7] |= 0x80;	/* Extended features */
 
+	if (btdev->type >= BTDEV_TYPE_BREDRLE50) {
+		btdev->le_features[1] |= 0x01;	/* LE 2M PHY */
+		btdev->le_features[1] |= 0x08;	/* LE Coded PHY */
+		btdev->le_features[1] |= 0x10;  /* LE EXT ADV */
+	}
+
 	btdev->feat_page_2[0] |= 0x01;	/* CSB - Master Operation */
 	btdev->feat_page_2[0] |= 0x02;	/* CSB - Slave Operation */
 	btdev->feat_page_2[0] |= 0x04;	/* Synchronization Train */
@@ -596,7 +630,8 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 
 	memset(btdev, 0, sizeof(*btdev));
 
-	if (type == BTDEV_TYPE_BREDRLE || type == BTDEV_TYPE_LE) {
+	if (type == BTDEV_TYPE_BREDRLE || type == BTDEV_TYPE_LE
+				|| BTDEV_TYPE_BREDRLE50) {
 		btdev->crypto = bt_crypto_new();
 		if (!btdev->crypto) {
 			free(btdev);
@@ -611,6 +646,7 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 
 	switch (btdev->type) {
 	case BTDEV_TYPE_BREDRLE:
+	case BTDEV_TYPE_BREDRLE50:
 		btdev->version = 0x09;
 		set_bredrle_features(btdev);
 		set_bredrle_commands(btdev);
@@ -1174,6 +1210,53 @@ static void le_conn_complete(struct btdev *btdev,
 	send_event(btdev, BT_HCI_EVT_LE_META_EVENT, buf, sizeof(buf));
 }
 
+static void le_ext_conn_complete(struct btdev *btdev,
+				const struct bt_hci_cmd_le_ext_create_conn *leecc,
+				uint8_t status)
+{
+	char buf[1 + sizeof(struct bt_hci_evt_le_enhanced_conn_complete)];
+	struct bt_hci_evt_le_enhanced_conn_complete *cc = (void *) &buf[1];
+	struct bt_hci_le_ext_create_conn *lecc = (void *)leecc->data;
+
+	memset(buf, 0, sizeof(buf));
+
+	buf[0] = BT_HCI_EVT_LE_ENHANCED_CONN_COMPLETE;
+
+	if (!status) {
+		struct btdev *remote;
+
+		remote = find_btdev_by_bdaddr_type(leecc->peer_addr,
+							leecc->peer_addr_type);
+
+		btdev->conn = remote;
+		btdev->le_adv_enable = 0;
+		remote->conn = btdev;
+		remote->le_adv_enable = 0;
+
+		cc->status = status;
+		cc->peer_addr_type = btdev->le_scan_own_addr_type;
+		if (cc->peer_addr_type == 0x01)
+			memcpy(cc->peer_addr, btdev->random_addr, 6);
+		else
+			memcpy(cc->peer_addr, btdev->bdaddr, 6);
+
+		cc->role = 0x01;
+		cc->handle = cpu_to_le16(42);
+		cc->interval = lecc->max_interval;
+		cc->latency = lecc->latency;
+		cc->supv_timeout = lecc->supv_timeout;
+
+		send_event(remote, BT_HCI_EVT_LE_META_EVENT, buf, sizeof(buf));
+	}
+
+	cc->status = status;
+	cc->peer_addr_type = leecc->peer_addr_type;
+	memcpy(cc->peer_addr, leecc->peer_addr, 6);
+	cc->role = 0x00;
+
+	send_event(btdev, BT_HCI_EVT_LE_META_EVENT, buf, sizeof(buf));
+}
+
 static const uint8_t *scan_addr(const struct btdev *btdev)
 {
 	if (btdev->le_scan_own_addr_type == 0x01)
@@ -1202,6 +1285,18 @@ static bool adv_match(struct btdev *scan, struct btdev *adv)
 	return !memcmp(scan_addr(scan), adv->le_adv_direct_addr, 6);
 }
 
+static bool ext_adv_match(struct btdev *scan, struct btdev *adv)
+{
+	/* Match everything if this is not directed advertising */
+	if (!(adv->le_ext_adv_type & 0x04))
+		return true;
+
+	if (scan->le_scan_own_addr_type != adv->le_adv_direct_addr_type)
+		return false;
+
+	return !memcmp(scan_addr(scan), adv->le_adv_direct_addr, 6);
+}
+
 static bool adv_connectable(struct btdev *btdev)
 {
 	if (!btdev->le_adv_enable)
@@ -1210,6 +1305,14 @@ static bool adv_connectable(struct btdev *btdev)
 	return btdev->le_adv_type != 0x03;
 }
 
+static bool ext_adv_connectable(struct btdev *btdev)
+{
+	if (!btdev->le_adv_enable)
+		return false;
+
+	return btdev->le_ext_adv_type & 0x01;
+}
+
 static void le_conn_request(struct btdev *btdev,
 				const struct bt_hci_cmd_le_create_conn *lecc)
 {
@@ -1224,6 +1327,20 @@ static void le_conn_request(struct btdev *btdev,
 					BT_HCI_ERR_CONN_FAILED_TO_ESTABLISH);
 }
 
+static void le_ext_conn_request(struct btdev *btdev,
+				const struct bt_hci_cmd_le_ext_create_conn *leecc)
+{
+	struct btdev *remote = find_btdev_by_bdaddr_type(leecc->peer_addr,
+							leecc->peer_addr_type);
+
+	if (remote && ext_adv_connectable(remote) && ext_adv_match(btdev, remote) &&
+				remote->le_adv_own_addr == leecc->peer_addr_type)
+		le_ext_conn_complete(btdev, leecc, 0);
+	else
+		le_ext_conn_complete(btdev, leecc,
+					BT_HCI_ERR_CONN_FAILED_TO_ESTABLISH);
+}
+
 static void conn_request(struct btdev *btdev, const uint8_t *bdaddr)
 {
 	struct btdev *remote = find_btdev_by_bdaddr(bdaddr);
@@ -1851,6 +1968,47 @@ static void le_send_adv_report(struct btdev *btdev, const struct btdev *remote,
 					1 + 10 + meta_event.lar.data_len + 1);
 }
 
+static void le_send_ext_adv_report(struct btdev *btdev,
+					const struct btdev *remote,
+					uint16_t type, bool is_scan_rsp)
+{
+	struct __packed {
+		uint8_t subevent;
+		uint8_t num_reports;
+		union {
+			struct bt_hci_le_ext_adv_report lear;
+			uint8_t raw[24 + 31];
+		};
+	} meta_event;
+
+	meta_event.subevent = BT_HCI_EVT_LE_EXT_ADV_REPORT;
+
+	memset(&meta_event.lear, 0, sizeof(meta_event.lear));
+	meta_event.num_reports = 1;
+	meta_event.lear.event_type = cpu_to_le16(type);
+	meta_event.lear.addr_type = remote->le_adv_own_addr;
+	memcpy(meta_event.lear.addr, adv_addr(remote), 6);
+	meta_event.lear.rssi = 127;
+	meta_event.lear.tx_power = 127;
+	/* Right now we dont care about phy in adv report */
+	meta_event.lear.primary_phy = 0x01;
+	meta_event.lear.secondary_phy = 0x01;
+
+	/* Scan or advertising response */
+	if (is_scan_rsp) {
+		meta_event.lear.data_len = remote->le_scan_data_len;
+		memcpy(meta_event.lear.data, remote->le_scan_data,
+						meta_event.lear.data_len);
+	} else {
+		meta_event.lear.data_len = remote->le_adv_data_len;
+		memcpy(meta_event.lear.data, remote->le_adv_data,
+						meta_event.lear.data_len);
+	}
+
+	send_event(btdev, BT_HCI_EVT_LE_META_EVENT, &meta_event,
+					1 + 1 + 24 + meta_event.lear.data_len);
+}
+
 static uint8_t get_adv_report_type(uint8_t adv_type)
 {
 	/*
@@ -1863,6 +2021,22 @@ static uint8_t get_adv_report_type(uint8_t adv_type)
 	return adv_type;
 }
 
+static uint8_t get_ext_adv_report_type(uint8_t ext_adv_type)
+{
+	/* If legacy bit is not set then just reset high duty cycle directed bit */
+	if (!(ext_adv_type & 0x10))
+		return (ext_adv_type & 0xf7);
+
+	/*
+	 * Connectable low duty cycle directed advertising creates a
+	 * connectable directed advertising report type.
+	 */
+	if (ext_adv_type == 0x001d)
+		return 0x0015;
+
+	return ext_adv_type;
+}
+
 static void le_set_adv_enable_complete(struct btdev *btdev)
 {
 	uint8_t report_type;
@@ -1891,6 +2065,44 @@ static void le_set_adv_enable_complete(struct btdev *btdev)
 	}
 }
 
+static void le_set_ext_adv_enable_complete(struct btdev *btdev)
+{
+	uint16_t report_type;
+	int i;
+
+	report_type = get_ext_adv_report_type(btdev->le_ext_adv_type);
+
+	for (i = 0; i < MAX_BTDEV_ENTRIES; i++) {
+		if (!btdev_list[i] || btdev_list[i] == btdev)
+			continue;
+
+		if (!btdev_list[i]->le_scan_enable)
+			continue;
+
+		if (!ext_adv_match(btdev_list[i], btdev))
+			continue;
+
+		le_send_ext_adv_report(btdev_list[i], btdev, report_type, false);
+
+		if (btdev_list[i]->le_scan_type != 0x01)
+			continue;
+
+		/* if scannable bit is set the send scan response */
+		if (btdev->le_ext_adv_type & 0x02) {
+			if (btdev->le_ext_adv_type == 0x13)
+				report_type = 0x1b;
+			else if (btdev->le_ext_adv_type == 0x12)
+				report_type = 0x1a;
+			else if (!(btdev->le_ext_adv_type & 0x10))
+				report_type &= 0x08;
+			else
+				continue;
+
+			le_send_ext_adv_report(btdev_list[i], btdev, report_type, true);
+		}
+	}
+}
+
 static void le_set_scan_enable_complete(struct btdev *btdev)
 {
 	int i;
@@ -1920,6 +2132,44 @@ static void le_set_scan_enable_complete(struct btdev *btdev)
 	}
 }
 
+static void le_set_ext_scan_enable_complete(struct btdev *btdev)
+{
+	int i;
+
+	for (i = 0; i < MAX_BTDEV_ENTRIES; i++) {
+		uint16_t report_type;
+
+		if (!btdev_list[i] || btdev_list[i] == btdev)
+			continue;
+
+		if (!btdev_list[i]->le_adv_enable)
+			continue;
+
+		if (!ext_adv_match(btdev, btdev_list[i]))
+			continue;
+
+		report_type = get_ext_adv_report_type(btdev_list[i]->le_ext_adv_type);
+		le_send_ext_adv_report(btdev, btdev_list[i], report_type, false);
+
+		if (btdev->le_scan_type != 0x01)
+			continue;
+
+				/* if scannable bit is set the send scan response */
+		if (btdev_list[i]->le_ext_adv_type & 0x02) {
+			if (btdev_list[i]->le_ext_adv_type == 0x13)
+				report_type = 0x1b;
+			else if (btdev_list[i]->le_ext_adv_type == 0x12)
+				report_type = 0x1a;
+			else if (!(btdev_list[i]->le_ext_adv_type & 0x10))
+				report_type &= 0x08;
+			else
+				continue;
+
+			le_send_ext_adv_report(btdev, btdev_list[i], report_type, true);
+		}
+	}
+}
+
 static void le_read_remote_features_complete(struct btdev *btdev)
 {
 	char buf[1 + sizeof(struct bt_hci_evt_le_remote_features_complete)];
@@ -2086,6 +2336,15 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	const struct bt_hci_cmd_read_local_amp_assoc *rlaa_cmd;
 	const struct bt_hci_cmd_read_rssi *rrssi;
 	const struct bt_hci_cmd_read_tx_power *rtxp;
+	const struct bt_hci_cmd_le_set_adv_set_rand_addr *lsasra;
+	const struct bt_hci_cmd_le_set_ext_adv_params *lseap;
+	const struct bt_hci_cmd_le_set_ext_adv_enable *lseae;
+	const struct bt_hci_cmd_le_set_ext_adv_data *lsead;
+	const struct bt_hci_cmd_le_set_ext_scan_rsp_data *lsesrd;
+	const struct bt_hci_cmd_le_set_default_phy *phys;
+	const struct bt_hci_cmd_le_set_ext_scan_params *lsesp;
+	const struct bt_hci_le_scan_phy *lsp;
+	const struct bt_hci_cmd_le_set_ext_scan_enable *lsese;
 	struct bt_hci_rsp_read_default_link_policy rdlp;
 	struct bt_hci_rsp_read_stored_link_key rslk;
 	struct bt_hci_rsp_write_stored_link_key wslk;
@@ -2145,6 +2404,8 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	struct bt_hci_rsp_read_tx_power rtxp_rsp;
 	struct bt_hci_evt_le_read_local_pk256_complete pk_evt;
 	struct bt_hci_evt_le_generate_dhkey_complete dh_evt;
+	struct bt_hci_rsp_le_read_num_supported_adv_sets rlrnsas;
+	struct bt_hci_rsp_le_set_ext_adv_params rlseap;
 	uint8_t status, page;
 
 	switch (opcode) {
@@ -2679,7 +2940,8 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		break;
 
 	case BT_HCI_CMD_READ_LE_HOST_SUPPORTED:
-		if (btdev->type != BTDEV_TYPE_BREDRLE)
+		if (btdev->type != BTDEV_TYPE_BREDRLE &&
+				btdev->type != BTDEV_TYPE_BREDRLE50)
 			goto unsupported;
 		rlhs.status = BT_HCI_ERR_SUCCESS;
 		rlhs.supported = btdev->le_supported;
@@ -2688,7 +2950,8 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		break;
 
 	case BT_HCI_CMD_WRITE_LE_HOST_SUPPORTED:
-		if (btdev->type != BTDEV_TYPE_BREDRLE)
+		if (btdev->type != BTDEV_TYPE_BREDRLE &&
+				btdev->type != BTDEV_TYPE_BREDRLE50)
 			goto unsupported;
 		wlhs = data;
 		btdev->le_supported = wlhs->supported;
@@ -2698,7 +2961,8 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		break;
 
 	case BT_HCI_CMD_READ_SECURE_CONN_SUPPORT:
-		if (btdev->type != BTDEV_TYPE_BREDRLE)
+		if (btdev->type != BTDEV_TYPE_BREDRLE &&
+				btdev->type != BTDEV_TYPE_BREDRLE50)
 			goto unsupported;
 		rscs.status = BT_HCI_ERR_SUCCESS;
 		rscs.support = btdev->secure_conn_support;
@@ -2706,7 +2970,8 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		break;
 
 	case BT_HCI_CMD_WRITE_SECURE_CONN_SUPPORT:
-		if (btdev->type != BTDEV_TYPE_BREDRLE)
+		if (btdev->type != BTDEV_TYPE_BREDRLE &&
+				btdev->type != BTDEV_TYPE_BREDRLE50)
 			goto unsupported;
 		wscs = data;
 		btdev->secure_conn_support = wscs->support;
@@ -2715,14 +2980,16 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		break;
 
 	case BT_HCI_CMD_READ_LOCAL_OOB_EXT_DATA:
-		if (btdev->type != BTDEV_TYPE_BREDRLE)
+		if (btdev->type != BTDEV_TYPE_BREDRLE &&
+				btdev->type != BTDEV_TYPE_BREDRLE50)
 			goto unsupported;
 		rloed.status = BT_HCI_ERR_SUCCESS;
 		cmd_complete(btdev, opcode, &rloed, sizeof(rloed));
 		break;
 
 	case BT_HCI_CMD_READ_SYNC_TRAIN_PARAMS:
-		if (btdev->type != BTDEV_TYPE_BREDRLE)
+		if (btdev->type != BTDEV_TYPE_BREDRLE &&
+				btdev->type != BTDEV_TYPE_BREDRLE50)
 			goto unsupported;
 		rstp.status = BT_HCI_ERR_SUCCESS;
 		rstp.interval = cpu_to_le16(btdev->sync_train_interval);
@@ -2872,7 +3139,8 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 
 	case BT_HCI_CMD_READ_ENCRYPT_KEY_SIZE:
 		if (btdev->type != BTDEV_TYPE_BREDRLE &&
-					btdev->type != BTDEV_TYPE_BREDR)
+					btdev->type != BTDEV_TYPE_BREDR &&
+					btdev->type != BTDEV_TYPE_BREDRLE50)
 			goto unsupported;
 		reks = data;
 		read_enc_key_size_complete(btdev, le16_to_cpu(reks->handle));
@@ -2918,7 +3186,8 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		break;
 
 	case BT_HCI_CMD_SET_EVENT_MASK_PAGE2:
-		if (btdev->type != BTDEV_TYPE_BREDRLE)
+		if (btdev->type != BTDEV_TYPE_BREDRLE &&
+				btdev->type != BTDEV_TYPE_BREDRLE50)
 			goto unsupported;
 		semp2 = data;
 		memcpy(btdev->event_mask_page2, semp2->mask, 8);
@@ -3245,6 +3514,149 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		lcprnr_rsp.status = BT_HCI_ERR_SUCCESS;
 		cmd_complete(btdev, opcode, &lcprnr_rsp, sizeof(lcprnr_rsp));
 		break;
+	case BT_HCI_CMD_LE_READ_NUM_SUPPORTED_ADV_SETS:
+		if (btdev->type != BTDEV_TYPE_BREDRLE50)
+			goto unsupported;
+
+		rlrnsas.status = BT_HCI_ERR_SUCCESS;
+		/* Support one set as of now */
+		rlrnsas.num_of_sets = 1;
+		cmd_complete(btdev, opcode, &rlrnsas, sizeof(rlrnsas));
+		break;
+	case BT_HCI_CMD_LE_SET_ADV_SET_RAND_ADDR:
+		if (btdev->type != BTDEV_TYPE_BREDRLE50)
+			goto unsupported;
+
+		lsasra = data;
+		memcpy(btdev->random_addr, lsasra->bdaddr, 6);
+		status = BT_HCI_ERR_SUCCESS;
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+		break;
+	case BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS:
+		if (btdev->type != BTDEV_TYPE_BREDRLE50)
+			goto unsupported;
+
+		if (btdev->le_adv_enable) {
+			status = BT_HCI_ERR_COMMAND_DISALLOWED;
+			cmd_complete(btdev, opcode, &status, sizeof(status));
+			break;
+		}
+
+		lseap = data;
+		btdev->le_ext_adv_type = le16_to_cpu(lseap->evt_properties);
+		btdev->le_adv_own_addr = lseap->own_addr_type;
+		btdev->le_adv_direct_addr_type = lseap->peer_addr_type;
+		memcpy(btdev->le_adv_direct_addr, lseap->peer_addr, 6);
+
+		rlseap.status = BT_HCI_ERR_SUCCESS;
+		rlseap.tx_power = 0;
+		cmd_complete(btdev, opcode, &rlseap, sizeof(rlseap));
+		break;
+	case BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE:
+		if (btdev->type != BTDEV_TYPE_BREDRLE50)
+			goto unsupported;
+
+		lseae = data;
+		if (btdev->le_adv_enable == lseae->enable)
+			status = BT_HCI_ERR_COMMAND_DISALLOWED;
+		else {
+			btdev->le_adv_enable = lseae->enable;
+			status = BT_HCI_ERR_SUCCESS;
+		}
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+		if (status == BT_HCI_ERR_SUCCESS && btdev->le_adv_enable)
+			le_set_ext_adv_enable_complete(btdev);
+		break;
+	case BT_HCI_CMD_LE_SET_EXT_ADV_DATA:
+		if (btdev->type != BTDEV_TYPE_BREDRLE50)
+			goto unsupported;
+
+		lsead = data;
+		btdev->le_adv_data_len = lsead->data_len;
+		memcpy(btdev->le_adv_data, lsead->data, 31);
+		status = BT_HCI_ERR_SUCCESS;
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+		break;
+	case BT_HCI_CMD_LE_SET_EXT_SCAN_RSP_DATA:
+		if (btdev->type != BTDEV_TYPE_BREDRLE50)
+			goto unsupported;
+
+		lsesrd = data;
+		btdev->le_scan_data_len = lsesrd->data_len;
+		memcpy(btdev->le_scan_data, lsesrd->data, 31);
+		status = BT_HCI_ERR_SUCCESS;
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+		break;
+	case BT_HCI_CMD_LE_REMOVE_ADV_SET:
+		if (btdev->type != BTDEV_TYPE_BREDRLE50)
+			goto unsupported;
+
+		status = BT_HCI_ERR_SUCCESS;
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+		break;
+	case BT_HCI_CMD_LE_CLEAR_ADV_SETS:
+		if (btdev->type != BTDEV_TYPE_BREDRLE50)
+			goto unsupported;
+
+		status = BT_HCI_ERR_SUCCESS;
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+		break;
+	case BT_HCI_CMD_LE_SET_DEFAULT_PHY:
+		if (btdev->type == BTDEV_TYPE_BREDR)
+			goto unsupported;
+		phys = data;
+		if (phys->all_phys > 0x03 ||
+			(!(phys->all_phys & 0x01) &&
+				(!phys->tx_phys || phys->tx_phys > 0x07)) ||
+			(!(phys->all_phys & 0x02) &&
+				(!phys->rx_phys || phys->rx_phys > 0x07)))
+			status = BT_HCI_ERR_INVALID_PARAMETERS;
+		else
+			status = BT_HCI_ERR_SUCCESS;
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+		break;
+	case BT_HCI_CMD_LE_SET_EXT_SCAN_PARAMS:
+		if (btdev->type != BTDEV_TYPE_BREDRLE50)
+			goto unsupported;
+
+		lsesp = data;
+		lsp = (void *)lsesp->data;
+
+		if (btdev->le_scan_enable)
+			status = BT_HCI_ERR_COMMAND_DISALLOWED;
+		else if (lsesp->num_phys == 0)
+			status = BT_HCI_ERR_INVALID_PARAMETERS;
+		else {
+			status = BT_HCI_ERR_SUCCESS;
+			/* Currently we dont support multiple types in single command
+			 * So just take the first one will do.
+			 */
+			btdev->le_scan_type = lsp->type;
+			btdev->le_scan_own_addr_type = lsesp->own_addr_type;
+		}
+
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+		break;
+	case BT_HCI_CMD_LE_SET_EXT_SCAN_ENABLE:
+		if (btdev->type != BTDEV_TYPE_BREDRLE50)
+			goto unsupported;
+
+		lsese = data;
+		if (btdev->le_scan_enable == lsese->enable)
+			status = BT_HCI_ERR_COMMAND_DISALLOWED;
+		else {
+			btdev->le_scan_enable = lsese->enable;
+			btdev->le_filter_dup = lsese->filter_dup;
+			status = BT_HCI_ERR_SUCCESS;
+		}
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+		break;
+	case BT_HCI_CMD_LE_EXT_CREATE_CONN:
+		if (btdev->type != BTDEV_TYPE_BREDRLE50)
+			goto unsupported;
+
+		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
+		break;
 	default:
 		goto unsupported;
 	}
@@ -3282,6 +3694,8 @@ static void default_cmd_completion(struct btdev *btdev, uint16_t opcode,
 	const struct bt_hci_cmd_le_conn_param_req_reply *lcprr;
 	const struct bt_hci_cmd_le_conn_param_req_neg_reply *lcprnr;
 	const struct bt_hci_cmd_le_set_scan_enable *lsse;
+	const struct bt_hci_cmd_le_set_ext_scan_enable *lsese;
+	const struct bt_hci_cmd_le_ext_create_conn *leecc;
 
 	switch (opcode) {
 	case BT_HCI_CMD_INQUIRY:
@@ -3476,7 +3890,21 @@ static void default_cmd_completion(struct btdev *btdev, uint16_t opcode,
 		lsse = data;
 		if (btdev->le_scan_enable && lsse->enable)
 			le_set_scan_enable_complete(btdev);
-
+		break;
+	case BT_HCI_CMD_LE_SET_EXT_SCAN_ENABLE:
+		if (btdev->type != BTDEV_TYPE_BREDRLE50)
+			return;
+		lsese = data;
+		if (btdev->le_scan_enable && lsese->enable)
+			le_set_ext_scan_enable_complete(btdev);
+		break;
+	case BT_HCI_CMD_LE_EXT_CREATE_CONN:
+		if (btdev->type != BTDEV_TYPE_BREDRLE50)
+			return;
+		leecc = data;
+		btdev->le_scan_own_addr_type = leecc->own_addr_type;
+		le_ext_conn_request(btdev, leecc);
+		break;
 	}
 }
 
diff --git a/emulator/btdev.h b/emulator/btdev.h
index ba06a10..362d1e7 100644
--- a/emulator/btdev.h
+++ b/emulator/btdev.h
@@ -63,6 +63,7 @@ enum btdev_type {
 	BTDEV_TYPE_LE,
 	BTDEV_TYPE_AMP,
 	BTDEV_TYPE_BREDR20,
+	BTDEV_TYPE_BREDRLE50,
 };
 
 enum btdev_hook_type {
diff --git a/emulator/bthost.c b/emulator/bthost.c
index 2bcdc31..d37957f 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -839,6 +839,12 @@ static void evt_cmd_complete(struct bthost *bthost, const void *data,
 		break;
 	case BT_HCI_CMD_LE_SET_ADV_DATA:
 		break;
+	case BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS:
+		break;
+	case BT_HCI_CMD_LE_SET_EXT_ADV_DATA:
+		break;
+	case BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE:
+		break;
 	default:
 		printf("Unhandled cmd_complete opcode 0x%04x\n", opcode);
 		break;
@@ -1161,6 +1167,26 @@ static void evt_le_conn_complete(struct bthost *bthost, const void *data,
 	init_conn(bthost, le16_to_cpu(ev->handle), ev->peer_addr, addr_type);
 }
 
+static void evt_le_ext_conn_complete(struct bthost *bthost, const void *data,
+								uint8_t len)
+{
+	const struct bt_hci_evt_le_enhanced_conn_complete *ev = data;
+	uint8_t addr_type;
+
+	if (len < sizeof(*ev))
+		return;
+
+	if (ev->status)
+		return;
+
+	if (ev->peer_addr_type == 0x00)
+		addr_type = BDADDR_LE_PUBLIC;
+	else
+		addr_type = BDADDR_LE_RANDOM;
+
+	init_conn(bthost, le16_to_cpu(ev->handle), ev->peer_addr, addr_type);
+}
+
 static void evt_le_conn_update_complete(struct bthost *bthost, const void *data,
 								uint8_t len)
 {
@@ -1240,6 +1266,9 @@ static void evt_le_meta_event(struct bthost *bthost, const void *data,
 	case BT_HCI_EVT_LE_LONG_TERM_KEY_REQUEST:
 		evt_le_ltk_request(bthost, evt_data, len - 1);
 		break;
+	case BT_HCI_EVT_LE_ENHANCED_CONN_COMPLETE:
+		evt_le_ext_conn_complete(bthost, evt_data, len - 1);
+		break;
 	default:
 		printf("Unsupported LE Meta event 0x%2.2x\n", *event);
 		break;
@@ -2269,6 +2298,38 @@ void bthost_hci_connect(struct bthost *bthost, const uint8_t *bdaddr,
 	}
 }
 
+void bthost_hci_ext_connect(struct bthost *bthost, const uint8_t *bdaddr,
+							uint8_t addr_type)
+{
+	struct bt_hci_cmd_le_ext_create_conn *cc;
+	struct bt_hci_le_ext_create_conn *cp;
+	uint8_t buf[sizeof(*cc) + sizeof(*cp)];
+
+	cc = (void *)buf;
+	cp = (void *)cc->data;
+
+	bthost->conn_init = true;
+
+	memset(cc, 0, sizeof(*cc));
+	memset(cp, 0, sizeof(*cp));
+
+	memcpy(cc->peer_addr, bdaddr, sizeof(cc->peer_addr));
+
+	if (addr_type == BDADDR_LE_RANDOM)
+		cc->peer_addr_type = 0x01;
+
+	cc->phys = 0x01;
+
+	cp->scan_interval = cpu_to_le16(0x0060);
+	cp->scan_window = cpu_to_le16(0x0030);
+	cp->min_interval = cpu_to_le16(0x0028);
+	cp->max_interval = cpu_to_le16(0x0038);
+	cp->supv_timeout = cpu_to_le16(0x002a);
+
+	send_command(bthost, BT_HCI_CMD_LE_EXT_CREATE_CONN,
+						buf, sizeof(buf));
+}
+
 void bthost_hci_disconnect(struct bthost *bthost, uint16_t handle,
 								uint8_t reason)
 {
@@ -2301,6 +2362,29 @@ void bthost_set_adv_data(struct bthost *bthost, const uint8_t *data,
 							sizeof(adv_cp));
 }
 
+void bthost_set_ext_adv_data(struct bthost *bthost, const uint8_t *data,
+								uint8_t len)
+{
+	struct bt_hci_cmd_le_set_ext_adv_data *adv_cp;
+	uint8_t buf[sizeof(*adv_cp) + 31];
+
+	adv_cp = (void *)buf;
+
+	memset(adv_cp, 0, sizeof(*adv_cp));
+	memset(adv_cp->data, 0, 31);
+
+	adv_cp->operation = 0x03;
+	adv_cp->fragment_preference = 0x01;
+
+	if (len) {
+		adv_cp->data_len = len;
+		memcpy(adv_cp->data, data, len);
+	}
+
+	send_command(bthost, BT_HCI_CMD_LE_SET_EXT_ADV_DATA, buf,
+							sizeof(buf));
+}
+
 void bthost_set_adv_enable(struct bthost *bthost, uint8_t enable)
 {
 	struct bt_hci_cmd_le_set_adv_parameters cp;
@@ -2312,6 +2396,21 @@ void bthost_set_adv_enable(struct bthost *bthost, uint8_t enable)
 	send_command(bthost, BT_HCI_CMD_LE_SET_ADV_ENABLE, &enable, 1);
 }
 
+void bthost_set_ext_adv_enable(struct bthost *bthost, uint8_t enable)
+{
+	struct bt_hci_cmd_le_set_ext_adv_params cp;
+	struct bt_hci_cmd_le_set_ext_adv_enable cp_enable;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.evt_properties = cpu_to_le16(0x0013);
+	send_command(bthost, BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS,
+							&cp, sizeof(cp));
+
+	cp_enable.enable = enable;
+	send_command(bthost, BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE, &cp_enable,
+					sizeof(cp_enable));
+}
+
 void bthost_write_ssp_mode(struct bthost *bthost, uint8_t mode)
 {
 	send_command(bthost, BT_HCI_CMD_WRITE_SIMPLE_PAIRING_MODE, &mode, 1);
diff --git a/emulator/bthost.h b/emulator/bthost.h
index 553865a..b5f3696 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -56,6 +56,9 @@ void bthost_set_connect_cb(struct bthost *bthost, bthost_new_conn_cb cb,
 void bthost_hci_connect(struct bthost *bthost, const uint8_t *bdaddr,
 							uint8_t addr_type);
 
+void bthost_hci_ext_connect(struct bthost *bthost, const uint8_t *bdaddr,
+							uint8_t addr_type);
+
 void bthost_hci_disconnect(struct bthost *bthost, uint16_t handle,
 								uint8_t reason);
 
@@ -83,6 +86,10 @@ void bthost_set_adv_data(struct bthost *bthost, const uint8_t *data,
 								uint8_t len);
 void bthost_set_adv_enable(struct bthost *bthost, uint8_t enable);
 
+void bthost_set_ext_adv_data(struct bthost *bthost, const uint8_t *data,
+								uint8_t len);
+void bthost_set_ext_adv_enable(struct bthost *bthost, uint8_t enable);
+
 void bthost_write_ssp_mode(struct bthost *bthost, uint8_t mode);
 
 void bthost_write_le_host_supported(struct bthost *bthost, uint8_t mode);
diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index 1787a6c..bc36773 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -331,6 +331,9 @@ struct hciemu *hciemu_new(enum hciemu_type type)
 	case HCIEMU_TYPE_LEGACY:
 		hciemu->btdev_type = BTDEV_TYPE_BREDR20;
 		break;
+	case HCIEMU_TYPE_BREDRLE50:
+		hciemu->btdev_type = BTDEV_TYPE_BREDRLE50;
+		break;
 	default:
 		return NULL;
 	}
diff --git a/emulator/hciemu.h b/emulator/hciemu.h
index 5c0c4c3..e37c069 100644
--- a/emulator/hciemu.h
+++ b/emulator/hciemu.h
@@ -31,6 +31,7 @@ enum hciemu_type {
 	HCIEMU_TYPE_BREDR,
 	HCIEMU_TYPE_LE,
 	HCIEMU_TYPE_LEGACY,
+	HCIEMU_TYPE_BREDRLE50,
 };
 
 enum hciemu_hook_type {
diff --git a/monitor/bt.h b/monitor/bt.h
index 595b6a7..ec62864 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -3010,6 +3010,7 @@ struct bt_hci_le_ext_adv_report {
 	uint8_t  direct_addr_type;
 	uint8_t  direct_addr[6];
 	uint8_t  data_len;
+	uint8_t  data[0];
 } __attribute__ ((packed));
 
 #define BT_HCI_EVT_LE_ADV_SET_TERM		0x12
-- 
2.7.4

