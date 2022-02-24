Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8E9C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 00:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiBXAbM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Feb 2022 19:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiBXAbJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Feb 2022 19:31:09 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7BB6E2BB
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 16:30:38 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id bx5so516248pjb.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 16:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=00tpi3ubMc39x6VvlyEVIwLH2tXd1gkjhv4j61ryDfc=;
        b=qrQZ6VFsshBBLKd4e7+4TzgWINCd74clH4AjLFEXs3WOTCG+imdAfx/HiaxFJcuLMc
         GRTmDQh1RHZGwuRnegivlszm42aAt7OhFo/X+C4u5NSkS9QcPGogDLZcMDT6JS15aPOu
         mOQoAou9PniLTGIYH5Grv75e7Dr58VaWOD5KJOK9v5tjb05i95aPYkpO50Y6U8Re7SRH
         SFzVqmy+mS2TFYRKTRJLMN+3xz8KtbIHyH68S9Z1u5JPZ/JHWY2ZXRVi0kPJ2p/yWBtH
         Cuq+OvXyP0r8efDPcW/1gL5EDrR9Q3vA+LnI10Au307F0ThuWXhTWPcwtuZMfBxmoDhX
         eAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=00tpi3ubMc39x6VvlyEVIwLH2tXd1gkjhv4j61ryDfc=;
        b=a2ImGxALO1KXYS3vzNYvhS7ckTzzp53uwci17IU0TqigNxCeToAxf98LRslk/hZsJk
         hcODKTZ/toWy+Mnr+2GAH3fj8etuX5oHl/bH+b+v3DC1JmenwiGMbBBCLYHSD/PCJNRb
         lDXzaTWkbU3Fr+Eubwqitbd3/6NdHpbuxzSRm2ehNx8X1nqqXseLpIKLkhrP3FFUoEjP
         iPJeOGaNjX1746Uxaf2q7q77PIa5lQhakQ2GFrEMXMxv9hZfTDym6IyLhbf/YemWVd2e
         A3hKWsNp6d54RC7EVOny2PFNlJOJQvFiNIZaJqo+XM/q/hJg31VzPX739pG3cIpR9kMK
         s+Kg==
X-Gm-Message-State: AOAM532CAwv9UbBXQG7RHCJB/QIPXNPgFFmkqnt6EselnjoQT2R2lLXl
        hq01Q4AkH/ZT5RK2OGybhlhA0nIPcXI=
X-Google-Smtp-Source: ABdhPJzcUP1qmMTXyHcAhvSLCZkpLULoL/vD0/BxHQcUmTKYvRJBg1w0WEhWli/oRBlfW8UvL5oFmw==
X-Received: by 2002:a17:902:da84:b0:14f:deb1:8f6d with SMTP id j4-20020a170902da8400b0014fdeb18f6dmr16118plx.103.1645662637022;
        Wed, 23 Feb 2022 16:30:37 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id t19sm574570pjs.54.2022.02.23.16.30.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 16:30:36 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 07/11] monitor: Rename Periodic Advertising terms to PA/pa
Date:   Wed, 23 Feb 2022 16:30:25 -0800
Message-Id: <20220224003029.706163-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220224003029.706163-1-luiz.dentz@gmail.com>
References: <20220224003029.706163-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This renames the use of Periodic Advertising in the API to just PA.
---
 emulator/btdev.c | 168 ++++++++++++++++++++++-------------------------
 monitor/bt.h     |  82 +++++++++++------------
 monitor/packet.c | 104 ++++++++++++++---------------
 3 files changed, 173 insertions(+), 181 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index e79b0dc67..10fa046bc 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -191,14 +191,14 @@ struct btdev {
 	uint8_t  le_scan_filter_policy;
 	uint8_t  le_filter_dup;
 	uint8_t  le_adv_enable;
-	uint8_t  le_periodic_adv_enable;
-	uint16_t le_periodic_adv_properties;
-	uint16_t le_periodic_min_interval;
-	uint16_t le_periodic_max_interval;
-	uint8_t  le_periodic_data_len;
-	uint8_t  le_periodic_data[31];
-	struct bt_hci_cmd_le_periodic_adv_create_sync pa_sync_cmd;
-	uint16_t le_periodic_sync_handle;
+	uint8_t  le_pa_enable;
+	uint16_t le_pa_properties;
+	uint16_t le_pa_min_interval;
+	uint16_t le_pa_max_interval;
+	uint8_t  le_pa_data_len;
+	uint8_t  le_pa_data[31];
+	struct bt_hci_cmd_le_pa_create_sync pa_sync_cmd;
+	uint16_t le_pa_sync_handle;
 	uint8_t  le_ltk[16];
 	struct {
 		struct bt_hci_cmd_le_set_cig_params params;
@@ -5010,120 +5010,119 @@ static int cmd_clear_adv_sets(struct btdev *dev, const void *data,
 	return 0;
 }
 
-static int cmd_set_per_adv_params(struct btdev *dev, const void *data,
+static int cmd_set_pa_params(struct btdev *dev, const void *data,
 							uint8_t len)
 {
-	const struct bt_hci_cmd_le_set_periodic_adv_params *cmd = data;
+	const struct bt_hci_cmd_le_set_pa_params *cmd = data;
 	uint8_t status;
 
-	if (dev->le_periodic_adv_enable) {
+	if (dev->le_pa_enable) {
 		status = BT_HCI_ERR_COMMAND_DISALLOWED;
 	} else {
 		status = BT_HCI_ERR_SUCCESS;
-		dev->le_periodic_adv_properties = le16_to_cpu(cmd->properties);
-		dev->le_periodic_min_interval = cmd->min_interval;
-		dev->le_periodic_max_interval = cmd->max_interval;
+		dev->le_pa_properties = le16_to_cpu(cmd->properties);
+		dev->le_pa_min_interval = cmd->min_interval;
+		dev->le_pa_max_interval = cmd->max_interval;
 	}
 
-	cmd_complete(dev, BT_HCI_CMD_LE_SET_PERIODIC_ADV_PARAMS, &status,
+	cmd_complete(dev, BT_HCI_CMD_LE_SET_PA_PARAMS, &status,
 							sizeof(status));
 	return 0;
 }
 
-static int cmd_set_per_adv_data(struct btdev *dev, const void *data,
+static int cmd_set_pa_data(struct btdev *dev, const void *data,
 							uint8_t len)
 {
-	const struct bt_hci_cmd_le_set_periodic_adv_data *cmd = data;
+	const struct bt_hci_cmd_le_set_pa_data *cmd = data;
 	uint8_t status = BT_HCI_ERR_SUCCESS;
 
-	dev->le_periodic_data_len = cmd->data_len;
-	memcpy(dev->le_periodic_data, cmd->data, 31);
-	cmd_complete(dev, BT_HCI_CMD_LE_SET_PERIODIC_ADV_DATA, &status,
+	dev->le_pa_data_len = cmd->data_len;
+	memcpy(dev->le_pa_data, cmd->data, 31);
+	cmd_complete(dev, BT_HCI_CMD_LE_SET_PA_DATA, &status,
 							sizeof(status));
 
 	return 0;
 }
 
-static void send_per_adv(struct btdev *dev, const struct btdev *remote,
+static void send_pa(struct btdev *dev, const struct btdev *remote,
 						uint8_t offset)
 {
 	struct __packed {
-		struct bt_hci_le_per_adv_report ev;
+		struct bt_hci_le_pa_report ev;
 		uint8_t data[31];
 	} pdu;
 
 	memset(&pdu.ev, 0, sizeof(pdu.ev));
-	pdu.ev.handle = cpu_to_le16(dev->le_periodic_sync_handle);
+	pdu.ev.handle = cpu_to_le16(dev->le_pa_sync_handle);
 	pdu.ev.tx_power = 127;
 	pdu.ev.rssi = 127;
 	pdu.ev.cte_type = 0x0ff;
 
-	if ((size_t) remote->le_periodic_data_len - offset > sizeof(pdu.data)) {
+	if ((size_t) remote->le_pa_data_len - offset > sizeof(pdu.data)) {
 		pdu.ev.data_status = 0x01;
 		pdu.ev.data_len = sizeof(pdu.data);
 	} else {
 		pdu.ev.data_status = 0x00;
-		pdu.ev.data_len = remote->le_periodic_data_len - offset;
+		pdu.ev.data_len = remote->le_pa_data_len - offset;
 	}
 
-	memcpy(pdu.data, remote->le_periodic_data + offset, pdu.ev.data_len);
+	memcpy(pdu.data, remote->le_pa_data + offset, pdu.ev.data_len);
 
-	le_meta_event(dev, BT_HCI_EVT_LE_PER_ADV_REPORT, &pdu,
+	le_meta_event(dev, BT_HCI_EVT_LE_PA_REPORT, &pdu,
 					sizeof(pdu.ev) + pdu.ev.data_len);
 
 	if (pdu.ev.data_status == 0x01) {
 		offset += pdu.ev.data_len;
-		send_per_adv(dev, remote, offset);
+		send_pa(dev, remote, offset);
 	}
 }
 
-static void le_per_adv_sync_estabilished(struct btdev *dev,
-					struct btdev *remote, uint8_t status)
+static void le_pa_sync_estabilished(struct btdev *dev, struct btdev *remote,
+						uint8_t status)
 {
 	struct bt_hci_evt_le_per_sync_established ev;
-	struct bt_hci_cmd_le_periodic_adv_create_sync *cmd = &dev->pa_sync_cmd;
+	struct bt_hci_cmd_le_pa_create_sync *cmd = &dev->pa_sync_cmd;
 
 	memset(&ev, 0, sizeof(ev));
 	ev.status = status;
 
 	if (status) {
 		memset(&dev->pa_sync_cmd, 0, sizeof(dev->pa_sync_cmd));
-		dev->le_periodic_sync_handle = 0x0000;
-		le_meta_event(dev, BT_HCI_EVT_LE_PER_SYNC_ESTABLISHED, &ev,
+		dev->le_pa_sync_handle = 0x0000;
+		le_meta_event(dev, BT_HCI_EVT_LE_PA_SYNC_ESTABLISHED, &ev,
 							sizeof(ev));
 		return;
 	}
 
-	dev->le_periodic_sync_handle = SYC_HANDLE;
+	dev->le_pa_sync_handle = SYC_HANDLE;
 
-	ev.handle = cpu_to_le16(dev->le_periodic_sync_handle);
+	ev.handle = cpu_to_le16(dev->le_pa_sync_handle);
 	ev.addr_type = cmd->addr_type;
 	memcpy(ev.addr, cmd->addr, sizeof(ev.addr));
 	ev.phy = 0x01;
-	ev.interval = remote->le_periodic_min_interval;
+	ev.interval = remote->le_pa_min_interval;
 	ev.clock_accuracy = 0x07;
 
 	memset(&dev->pa_sync_cmd, 0, sizeof(dev->pa_sync_cmd));
 
-	le_meta_event(dev, BT_HCI_EVT_LE_PER_SYNC_ESTABLISHED, &ev, sizeof(ev));
-	send_per_adv(dev, remote, 0);
+	le_meta_event(dev, BT_HCI_EVT_LE_PA_SYNC_ESTABLISHED, &ev, sizeof(ev));
+	send_pa(dev, remote, 0);
 }
 
-static int cmd_set_per_adv_enable(struct btdev *dev, const void *data,
-							uint8_t len)
+static int cmd_set_pa_enable(struct btdev *dev, const void *data, uint8_t len)
 {
-	const struct bt_hci_cmd_le_set_periodic_adv_enable *cmd = data;
+	const struct bt_hci_cmd_le_set_pa_enable *cmd = data;
 	uint8_t status;
 	int i;
 
-	if (dev->le_periodic_adv_enable == cmd->enable) {
+	if (dev->le_pa_enable == cmd->enable) {
 		status = BT_HCI_ERR_COMMAND_DISALLOWED;
 	} else {
-		dev->le_periodic_adv_enable = cmd->enable;
+		dev->le_pa_enable = cmd->enable;
 		status = BT_HCI_ERR_SUCCESS;
 	}
 
-	cmd_complete(dev, BT_HCI_CMD_LE_SET_PERIODIC_ADV_ENABLE, &status,
+	cmd_complete(dev, BT_HCI_CMD_LE_SET_PA_ENABLE, &status,
 							sizeof(status));
 
 	for (i = 0; i < MAX_BTDEV_ENTRIES; i++) {
@@ -5133,8 +5132,8 @@ static int cmd_set_per_adv_enable(struct btdev *dev, const void *data,
 			continue;
 
 		if (remote->le_scan_enable &&
-			remote->le_periodic_sync_handle == INV_HANDLE)
-			le_per_adv_sync_estabilished(remote, dev,
+			remote->le_pa_sync_handle == INV_HANDLE)
+			le_pa_sync_estabilished(remote, dev,
 							BT_HCI_ERR_SUCCESS);
 	}
 
@@ -5239,17 +5238,16 @@ static void scan_ext_adv(struct btdev *dev, struct btdev *remote)
 	}
 }
 
-static void scan_per_adv(struct btdev *dev, struct btdev *remote)
+static void scan_pa(struct btdev *dev, struct btdev *remote)
 {
-	if (dev->le_periodic_sync_handle != INV_HANDLE ||
-				!remote->le_periodic_adv_enable)
+	if (dev->le_pa_sync_handle != INV_HANDLE || !remote->le_pa_enable)
 		return;
 
 	if (remote != find_btdev_by_bdaddr_type(dev->pa_sync_cmd.addr,
 						dev->pa_sync_cmd.addr_type))
 		return;
 
-	le_per_adv_sync_estabilished(dev, remote, BT_HCI_ERR_SUCCESS);
+	le_pa_sync_estabilished(dev, remote, BT_HCI_ERR_SUCCESS);
 }
 
 static int cmd_set_ext_scan_enable_complete(struct btdev *dev, const void *data,
@@ -5266,7 +5264,7 @@ static int cmd_set_ext_scan_enable_complete(struct btdev *dev, const void *data,
 			continue;
 
 		scan_ext_adv(dev, btdev_list[i]);
-		scan_per_adv(dev, btdev_list[i]);
+		scan_pa(dev, btdev_list[i]);
 	}
 
 	return 0;
@@ -5387,27 +5385,26 @@ static int cmd_ext_create_conn_complete(struct btdev *dev, const void *data,
 	return 0;
 }
 
-static int cmd_per_adv_create_sync(struct btdev *dev, const void *data,
-							uint8_t len)
+static int cmd_pa_create_sync(struct btdev *dev, const void *data, uint8_t len)
 {
 	uint8_t status = BT_HCI_ERR_SUCCESS;
 
-	if (dev->le_periodic_sync_handle)
+	if (dev->le_pa_sync_handle)
 		status = BT_HCI_ERR_MEM_CAPACITY_EXCEEDED;
 	else {
-		dev->le_periodic_sync_handle = INV_HANDLE;
+		dev->le_pa_sync_handle = INV_HANDLE;
 		memcpy(&dev->pa_sync_cmd, data, len);
 	}
 
-	cmd_status(dev, status, BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC);
+	cmd_status(dev, status, BT_HCI_CMD_LE_PA_CREATE_SYNC);
 
 	return 0;
 }
 
-static int cmd_per_adv_create_sync_complete(struct btdev *dev, const void *data,
+static int cmd_pa_create_sync_complete(struct btdev *dev, const void *data,
 							uint8_t len)
 {
-	const struct bt_hci_cmd_le_periodic_adv_create_sync *cmd = data;
+	const struct bt_hci_cmd_le_pa_create_sync *cmd = data;
 	struct btdev *remote;
 
 	/* This command may be issued whether or not scanning is enabled and
@@ -5420,15 +5417,15 @@ static int cmd_per_adv_create_sync_complete(struct btdev *dev, const void *data,
 		return 0;
 
 	remote = find_btdev_by_bdaddr_type(cmd->addr, cmd->addr_type);
-	if (!remote || !remote->le_periodic_adv_enable)
+	if (!remote || !remote->le_pa_enable)
 		return 0;
 
-	le_per_adv_sync_estabilished(dev, remote, BT_HCI_ERR_SUCCESS);
+	le_pa_sync_estabilished(dev, remote, BT_HCI_ERR_SUCCESS);
 
 	return 0;
 }
 
-static int cmd_per_adv_create_sync_cancel(struct btdev *dev, const void *data,
+static int cmd_pa_create_sync_cancel(struct btdev *dev, const void *data,
 							uint8_t len)
 {
 	uint8_t status = BT_HCI_ERR_SUCCESS;
@@ -5437,10 +5434,10 @@ static int cmd_per_adv_create_sync_cancel(struct btdev *dev, const void *data,
 	 * HCI_LE_Periodic_Advertising_Create_Sync command is pending, the
 	 * Controller shall return the error code Command Disallowed (0x0C).
 	 */
-	if (dev->le_periodic_sync_handle != INV_HANDLE)
+	if (dev->le_pa_sync_handle != INV_HANDLE)
 		status = BT_HCI_ERR_COMMAND_DISALLOWED;
 
-	cmd_complete(dev, BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC_CANCEL,
+	cmd_complete(dev, BT_HCI_CMD_LE_PA_CREATE_SYNC_CANCEL,
 					&status, sizeof(status));
 
 	/* After the HCI_Command_Complete is sent and if the cancellation was
@@ -5449,13 +5446,12 @@ static int cmd_per_adv_create_sync_cancel(struct btdev *dev, const void *data,
 	 * the error code Operation Cancelled by Host (0x44).
 	 */
 	if (!status)
-		le_per_adv_sync_estabilished(dev, NULL, BT_HCI_ERR_CANCELLED);
+		le_pa_sync_estabilished(dev, NULL, BT_HCI_ERR_CANCELLED);
 
 	return 0;
 }
 
-static int cmd_per_adv_term_sync(struct btdev *dev, const void *data,
-							uint8_t len)
+static int cmd_pa_term_sync(struct btdev *dev, const void *data, uint8_t len)
 {
 	uint8_t status = BT_HCI_ERR_SUCCESS;
 
@@ -5463,36 +5459,36 @@ static int cmd_per_adv_term_sync(struct btdev *dev, const void *data,
 	 * parameter does not exist, then the Controller shall return the error
 	 * code Unknown Advertising Identifier (0x42).
 	 */
-	if (dev->le_periodic_sync_handle != SYC_HANDLE)
+	if (dev->le_pa_sync_handle != SYC_HANDLE)
 		status = BT_HCI_ERR_UNKNOWN_ADVERTISING_ID;
 	else
-		dev->le_periodic_sync_handle = 0x0000;
+		dev->le_pa_sync_handle = 0x0000;
 
-	cmd_complete(dev, BT_HCI_CMD_LE_PERIODIC_ADV_TERM_SYNC,
+	cmd_complete(dev, BT_HCI_CMD_LE_PA_TERM_SYNC,
 					&status, sizeof(status));
 
 	return 0;
 }
 
-static int cmd_per_adv_add(struct btdev *dev, const void *data, uint8_t len)
+static int cmd_pa_add(struct btdev *dev, const void *data, uint8_t len)
 {
 	/* TODO */
 	return -ENOTSUP;
 }
 
-static int cmd_per_adv_remove(struct btdev *dev, const void *data, uint8_t len)
+static int cmd_pa_remove(struct btdev *dev, const void *data, uint8_t len)
 {
 	/* TODO */
 	return -ENOTSUP;
 }
 
-static int cmd_per_adv_clear(struct btdev *dev, const void *data, uint8_t len)
+static int cmd_pa_clear(struct btdev *dev, const void *data, uint8_t len)
 {
 	/* TODO */
 	return -ENOTSUP;
 }
 
-static int cmd_read_per_adv_list_size(struct btdev *dev, const void *data,
+static int cmd_read_pa_list_size(struct btdev *dev, const void *data,
 							uint8_t len)
 {
 	/* TODO */
@@ -5571,28 +5567,24 @@ done:
 					NULL), \
 	CMD(BT_HCI_CMD_LE_REMOVE_ADV_SET, cmd_remove_adv_set, NULL), \
 	CMD(BT_HCI_CMD_LE_CLEAR_ADV_SETS, cmd_clear_adv_sets, NULL), \
-	CMD(BT_HCI_CMD_LE_SET_PERIODIC_ADV_PARAMS, cmd_set_per_adv_params, \
-					NULL), \
-	CMD(BT_HCI_CMD_LE_SET_PERIODIC_ADV_DATA, cmd_set_per_adv_data, NULL), \
-	CMD(BT_HCI_CMD_LE_SET_PERIODIC_ADV_ENABLE, cmd_set_per_adv_enable, \
+	CMD(BT_HCI_CMD_LE_SET_PA_PARAMS, cmd_set_pa_params, \
 					NULL), \
+	CMD(BT_HCI_CMD_LE_SET_PA_DATA, cmd_set_pa_data, NULL), \
+	CMD(BT_HCI_CMD_LE_SET_PA_ENABLE, cmd_set_pa_enable, NULL), \
 	CMD(BT_HCI_CMD_LE_SET_EXT_SCAN_PARAMS, cmd_set_ext_scan_params, NULL), \
 	CMD(BT_HCI_CMD_LE_SET_EXT_SCAN_ENABLE, cmd_set_ext_scan_enable, \
 					cmd_set_ext_scan_enable_complete), \
 	CMD(BT_HCI_CMD_LE_EXT_CREATE_CONN, cmd_ext_create_conn, \
 					cmd_ext_create_conn_complete), \
-	CMD(BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC, cmd_per_adv_create_sync, \
-					cmd_per_adv_create_sync_complete), \
-	CMD(BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC_CANCEL, \
-					cmd_per_adv_create_sync_cancel, NULL), \
-	CMD(BT_HCI_CMD_LE_PERIODIC_ADV_TERM_SYNC, cmd_per_adv_term_sync, \
-					NULL), \
-	CMD(BT_HCI_CMD_LE_ADD_DEV_PERIODIC_ADV_LIST, cmd_per_adv_add, NULL), \
-	CMD(BT_HCI_CMD_LE_REMOVE_DEV_PERIODIC_ADV_LIST, cmd_per_adv_remove, \
+	CMD(BT_HCI_CMD_LE_PA_CREATE_SYNC, cmd_pa_create_sync, \
+					cmd_pa_create_sync_complete), \
+	CMD(BT_HCI_CMD_LE_PA_CREATE_SYNC_CANCEL, cmd_pa_create_sync_cancel, \
 					NULL), \
-	CMD(BT_HCI_CMD_LE_CLEAR_PERIODIC_ADV_LIST, cmd_per_adv_clear, NULL), \
-	CMD(BT_HCI_CMD_LE_READ_PERIODIC_ADV_LIST_SIZE, \
-					cmd_read_per_adv_list_size, NULL), \
+	CMD(BT_HCI_CMD_LE_PA_TERM_SYNC, cmd_pa_term_sync, NULL), \
+	CMD(BT_HCI_CMD_LE_ADD_DEV_PA_LIST, cmd_pa_add, NULL), \
+	CMD(BT_HCI_CMD_LE_REMOVE_DEV_PA_LIST, cmd_pa_remove, NULL), \
+	CMD(BT_HCI_CMD_LE_CLEAR_PA_LIST, cmd_pa_clear, NULL), \
+	CMD(BT_HCI_CMD_LE_READ_PA_LIST_SIZE, cmd_read_pa_list_size, NULL), \
 	CMD(BT_HCI_CMD_LE_READ_TX_POWER, cmd_read_tx_power, NULL), \
 	CMD(BT_HCI_CMD_LE_SET_PRIV_MODE, cmd_set_privacy_mode, NULL)
 
diff --git a/monitor/bt.h b/monitor/bt.h
index b6b6c49e1..5c2acee67 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2427,24 +2427,24 @@ struct bt_hci_cmd_le_remove_adv_set {
 
 #define BT_HCI_CMD_LE_CLEAR_ADV_SETS			0x203d
 
-#define BT_HCI_CMD_LE_SET_PERIODIC_ADV_PARAMS			0x203e
-struct bt_hci_cmd_le_set_periodic_adv_params {
+#define BT_HCI_CMD_LE_SET_PA_PARAMS			0x203e
+struct bt_hci_cmd_le_set_pa_params {
 	uint8_t  handle;
 	uint16_t min_interval;
 	uint16_t max_interval;
 	uint16_t properties;
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_LE_SET_PERIODIC_ADV_DATA			0x203f
-struct bt_hci_cmd_le_set_periodic_adv_data {
+#define BT_HCI_CMD_LE_SET_PA_DATA			0x203f
+struct bt_hci_cmd_le_set_pa_data {
 	uint8_t  handle;
 	uint8_t  operation;
 	uint8_t  data_len;
 	uint8_t  data[0];
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_LE_SET_PERIODIC_ADV_ENABLE			0x2040
-struct bt_hci_cmd_le_set_periodic_adv_enable {
+#define BT_HCI_CMD_LE_SET_PA_ENABLE			0x2040
+struct bt_hci_cmd_le_set_pa_enable {
 	uint8_t  enable;
 	uint8_t  handle;
 } __attribute__ ((packed));
@@ -2490,8 +2490,8 @@ struct bt_hci_le_ext_create_conn {
 	uint16_t max_length;
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC		0x2044
-struct bt_hci_cmd_le_periodic_adv_create_sync {
+#define BT_HCI_CMD_LE_PA_CREATE_SYNC		0x2044
+struct bt_hci_cmd_le_pa_create_sync {
 	uint8_t  options;
 	uint8_t  sid;
 	uint8_t  addr_type;
@@ -2501,31 +2501,31 @@ struct bt_hci_cmd_le_periodic_adv_create_sync {
 	uint8_t  sync_cte_type;
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC_CANCEL		0x2045
+#define BT_HCI_CMD_LE_PA_CREATE_SYNC_CANCEL		0x2045
 
-#define BT_HCI_CMD_LE_PERIODIC_ADV_TERM_SYNC		0x2046
-struct bt_hci_cmd_le_periodic_adv_term_sync {
+#define BT_HCI_CMD_LE_PA_TERM_SYNC		0x2046
+struct bt_hci_cmd_le_pa_term_sync {
 	uint16_t sync_handle;
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_LE_ADD_DEV_PERIODIC_ADV_LIST		0x2047
-struct bt_hci_cmd_le_add_dev_periodic_adv_list {
+#define BT_HCI_CMD_LE_ADD_DEV_PA_LIST		0x2047
+struct bt_hci_cmd_le_add_dev_pa_list {
 	uint8_t  addr_type;
 	uint8_t  addr[6];
 	uint8_t  sid;
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_LE_REMOVE_DEV_PERIODIC_ADV_LIST		0x2048
-struct bt_hci_cmd_le_remove_dev_periodic_adv_list {
+#define BT_HCI_CMD_LE_REMOVE_DEV_PA_LIST		0x2048
+struct bt_hci_cmd_le_remove_dev_pa_list {
 	uint8_t  addr_type;
 	uint8_t  addr[6];
 	uint8_t  sid;
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_LE_CLEAR_PERIODIC_ADV_LIST		0x2049
+#define BT_HCI_CMD_LE_CLEAR_PA_LIST		0x2049
 
-#define BT_HCI_CMD_LE_READ_PERIODIC_ADV_LIST_SIZE		0x204a
-struct bt_hci_rsp_le_read_dev_periodic_adv_list_size {
+#define BT_HCI_CMD_LE_READ_PA_LIST_SIZE		0x204a
+struct bt_hci_rsp_le_read_dev_pa_list_size {
 	uint8_t  status;
 	uint8_t  list_size;
 } __attribute__ ((packed));
@@ -2582,28 +2582,28 @@ struct bt_hci_cmd_le_tx_test_v3 {
 	uint8_t  antenna_ids[0];
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_SET_PERIODIC_ADV_REC_ENABLE	0x2059
-struct bt_hci_cmd_set_periodic_adv_rec_enable {
+#define BT_HCI_CMD_SET_PA_REC_ENABLE		0x2059
+struct bt_hci_cmd_set_pa_rec_enable {
 	uint16_t sync_handle;
 	uint8_t  enable;
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_PERIODIC_SYNC_TRANS	0x205a
+#define BT_HCI_CMD_PERIODIC_SYNC_TRANS		0x205a
 struct bt_hci_cmd_periodic_sync_trans {
 	uint16_t handle;
 	uint16_t service_data;
 	uint16_t sync_handle;
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_PERIODIC_ADV_SET_INFO_TRANS	0x205b
-struct bt_hci_cmd_periodic_adv_set_info_trans {
+#define BT_HCI_CMD_PA_SET_INFO_TRANS		0x205b
+struct bt_hci_cmd_pa_set_info_trans {
 	uint16_t handle;
 	uint16_t service_data;
 	uint16_t adv_handle;
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_PERIODIC_ADV_SYNC_TRANS_PARAMS	0x205c
-struct bt_hci_cmd_periodic_adv_sync_trans_params {
+#define BT_HCI_CMD_PA_SYNC_TRANS_PARAMS		0x205c
+struct bt_hci_cmd_pa_sync_trans_params {
 	uint16_t  handle;
 	uint8_t   mode;
 	uint16_t  skip;
@@ -2611,8 +2611,8 @@ struct bt_hci_cmd_periodic_adv_sync_trans_params {
 	uint8_t   cte_type;
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_DEFAULT_PERIODIC_ADV_SYNC_TRANS_PARAMS	0x205d
-struct bt_hci_cmd_default_periodic_adv_sync_trans_params {
+#define BT_HCI_CMD_DEFAULT_PA_SYNC_TRANS_PARAMS	0x205d
+struct bt_hci_cmd_default_pa_sync_trans_params {
 	uint8_t  mode;
 	uint16_t skip;
 	uint16_t sync_timeout;
@@ -3497,7 +3497,7 @@ struct bt_hci_le_ext_adv_report {
 	uint8_t  data[0];
 } __attribute__ ((packed));
 
-#define BT_HCI_EVT_LE_PER_SYNC_ESTABLISHED	0x0e
+#define BT_HCI_EVT_LE_PA_SYNC_ESTABLISHED	0x0e
 struct bt_hci_evt_le_per_sync_established {
 	uint8_t  status;
 	uint16_t handle;
@@ -3509,8 +3509,8 @@ struct bt_hci_evt_le_per_sync_established {
 	uint8_t  clock_accuracy;
 } __attribute__ ((packed));
 
-#define BT_HCI_EVT_LE_PER_ADV_REPORT	0x0f
-struct bt_hci_le_per_adv_report {
+#define BT_HCI_EVT_LE_PA_REPORT			0x0f
+struct bt_hci_le_pa_report {
 	uint16_t handle;
 	uint8_t  tx_power;
 	int8_t   rssi;
@@ -3520,7 +3520,7 @@ struct bt_hci_le_per_adv_report {
 	uint8_t  data[0];
 } __attribute__ ((packed));
 
-#define BT_HCI_EVT_LE_PER_SYNC_LOST	0x10
+#define BT_HCI_EVT_LE_PA_SYNC_LOST		0x10
 struct bt_hci_evt_le_per_sync_lost {
 	uint16_t handle;
 } __attribute__ ((packed));
@@ -3552,8 +3552,8 @@ struct bt_hci_evt_le_cte_request_failed {
 	uint16_t handle;
 } __attribute__ ((packed));
 
-#define BT_HCI_EVT_LE_PER_ADV_SYNC_TRANS_REC		0x18
-struct bt_hci_evt_le_per_adv_sync_trans_rec {
+#define BT_HCI_EVT_LE_PA_SYNC_TRANS_REC		0x18
+struct bt_hci_evt_le_pa_sync_trans_rec {
 	uint8_t  status;
 	uint16_t handle;
 	uint16_t service_data;
@@ -3566,7 +3566,7 @@ struct bt_hci_evt_le_per_adv_sync_trans_rec {
 	uint8_t  clock_accuracy;
 } __attribute__ ((packed));
 
-#define BT_HCI_EVT_LE_CIS_ESTABLISHED			0x19
+#define BT_HCI_EVT_LE_CIS_ESTABLISHED		0x19
 struct bt_hci_evt_le_cis_established {
 	uint8_t  status;
 	uint16_t conn_handle;
@@ -3586,7 +3586,7 @@ struct bt_hci_evt_le_cis_established {
 	uint16_t interval;
 } __attribute__ ((packed));
 
-#define BT_HCI_EVT_LE_CIS_REQ				0x1a
+#define BT_HCI_EVT_LE_CIS_REQ			0x1a
 struct bt_hci_evt_le_cis_req {
 	uint16_t acl_handle;
 	uint16_t cis_handle;
@@ -3594,7 +3594,7 @@ struct bt_hci_evt_le_cis_req {
 	uint8_t  cis_id;
 } __attribute__ ((packed));
 
-#define BT_HCI_EVT_LE_BIG_COMPLETE			0x1b
+#define BT_HCI_EVT_LE_BIG_COMPLETE		0x1b
 struct bt_hci_evt_le_big_complete {
 	uint8_t  status;
 	uint8_t  handle;
@@ -3611,13 +3611,13 @@ struct bt_hci_evt_le_big_complete {
 	uint16_t bis_handle[0];
 } __attribute__ ((packed));
 
-#define BT_HCI_EVT_LE_BIG_TERMINATE			0x1c
+#define BT_HCI_EVT_LE_BIG_TERMINATE		0x1c
 struct bt_hci_evt_le_big_terminate {
 	uint8_t  reason;
 	uint8_t  handle;
 } __attribute__ ((packed));
 
-#define BT_HCI_EVT_LE_BIG_SYNC_ESTABILISHED		0x1d
+#define BT_HCI_EVT_LE_BIG_SYNC_ESTABILISHED	0x1d
 struct bt_hci_evt_le_big_sync_estabilished {
 	uint8_t  status;
 	uint8_t  handle;
@@ -3632,13 +3632,13 @@ struct bt_hci_evt_le_big_sync_estabilished {
 	uint16_t bis[0];
 } __attribute__ ((packed));
 
-#define BT_HCI_EVT_LE_BIG_SYNC_LOST			0x1e
+#define BT_HCI_EVT_LE_BIG_SYNC_LOST		0x1e
 struct bt_hci_evt_le_big_sync_lost {
 	uint8_t  big_id;
 	uint8_t  reason;
 } __attribute__ ((packed));
 
-#define BT_HCI_EVT_LE_REQ_PEER_SCA_COMPLETE		0x1f
+#define BT_HCI_EVT_LE_REQ_PEER_SCA_COMPLETE	0x1f
 struct bt_hci_evt_le_req_peer_sca_complete {
 	uint8_t  status;
 	uint16_t handle;
@@ -3657,7 +3657,7 @@ struct bt_hci_evt_le_req_peer_sca_complete {
 #define BT_HCI_ERR_UNSUPPORTED_FEATURE		0x11
 #define BT_HCI_ERR_INVALID_PARAMETERS		0x12
 #define BT_HCI_ERR_UNSPECIFIED_ERROR		0x1f
-#define BT_HCI_ERR_ADV_TIMEOUT                 0x3c
+#define BT_HCI_ERR_ADV_TIMEOUT			0x3c
 #define BT_HCI_ERR_CONN_FAILED_TO_ESTABLISH	0x3e
 #define BT_HCI_ERR_UNKNOWN_ADVERTISING_ID	0x42
 #define BT_HCI_ERR_CANCELLED			0x44
diff --git a/monitor/packet.c b/monitor/packet.c
index a17c632a7..b7431b57d 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -7400,37 +7400,37 @@ static void le_remove_adv_set_cmd(const void *data, uint8_t size)
 	print_handle(cmd->handle);
 }
 
-static const struct bitfield_data periodic_adv_properties_table[] = {
+static const struct bitfield_data pa_properties_table[] = {
 	{  6, "Include TxPower"		},
 	{ }
 };
 
-static void print_periodic_adv_properties(uint16_t flags)
+static void print_pa_properties(uint16_t flags)
 {
 	uint16_t mask;
 
 	print_field("Properties: 0x%4.4x", flags);
 
-	mask = print_bitfield(2, flags, periodic_adv_properties_table);
+	mask = print_bitfield(2, flags, pa_properties_table);
 	if (mask)
 		print_text(COLOR_UNKNOWN_ADV_FLAG,
 				"  Unknown advertising properties (0x%4.4x)",
 									mask);
 }
 
-static void le_set_periodic_adv_params_cmd(const void *data, uint8_t size)
+static void le_set_pa_params_cmd(const void *data, uint8_t size)
 {
-	const struct bt_hci_cmd_le_set_periodic_adv_params *cmd = data;
+	const struct bt_hci_cmd_le_set_pa_params *cmd = data;
 
 	print_handle(cmd->handle);
 	print_slot_125("Min interval", cmd->min_interval);
 	print_slot_125("Max interval", cmd->max_interval);
-	print_periodic_adv_properties(cmd->properties);
+	print_pa_properties(cmd->properties);
 }
 
-static void le_set_periodic_adv_data_cmd(const void *data, uint8_t size)
+static void le_set_pa_data_cmd(const void *data, uint8_t size)
 {
-	const struct bt_hci_cmd_le_set_periodic_adv_data *cmd = data;
+	const struct bt_hci_cmd_le_set_pa_data *cmd = data;
 	const char *str;
 
 	print_handle(cmd->handle);
@@ -7458,9 +7458,9 @@ static void le_set_periodic_adv_data_cmd(const void *data, uint8_t size)
 	print_eir(cmd->data, cmd->data_len, true);
 }
 
-static void le_set_periodic_adv_enable_cmd(const void *data, uint8_t size)
+static void le_set_pa_enable_cmd(const void *data, uint8_t size)
 {
-	const struct bt_hci_cmd_le_set_periodic_adv_enable *cmd = data;
+	const struct bt_hci_cmd_le_set_pa_enable *cmd = data;
 
 	print_enable("Periodic advertising", cmd->enable);
 	print_handle(cmd->handle);
@@ -7657,9 +7657,9 @@ static void print_create_sync_options(uint8_t flags)
 	}
 }
 
-static void le_periodic_adv_create_sync_cmd(const void *data, uint8_t size)
+static void le_pa_create_sync_cmd(const void *data, uint8_t size)
 {
-	const struct bt_hci_cmd_le_periodic_adv_create_sync *cmd = data;
+	const struct bt_hci_cmd_le_pa_create_sync *cmd = data;
 
 	print_create_sync_options(cmd->options);
 	print_field("SID: 0x%2.2x", cmd->sid);
@@ -7672,34 +7672,34 @@ static void le_periodic_adv_create_sync_cmd(const void *data, uint8_t size)
 	print_create_sync_cte_type(cmd->sync_cte_type);
 }
 
-static void le_periodic_adv_term_sync_cmd(const void *data, uint8_t size)
+static void le_pa_term_sync_cmd(const void *data, uint8_t size)
 {
-	const struct bt_hci_cmd_le_periodic_adv_term_sync *cmd = data;
+	const struct bt_hci_cmd_le_pa_term_sync *cmd = data;
 
 	print_field("Sync handle: 0x%4.4x", cmd->sync_handle);
 }
 
-static void le_add_dev_periodic_adv_list_cmd(const void *data, uint8_t size)
+static void le_add_dev_pa_list_cmd(const void *data, uint8_t size)
 {
-	const struct bt_hci_cmd_le_add_dev_periodic_adv_list *cmd = data;
+	const struct bt_hci_cmd_le_add_dev_pa_list *cmd = data;
 
 	print_addr_type("Adv address type", cmd->addr_type);
 	print_addr("Adv address", cmd->addr, cmd->addr_type);
 	print_field("SID: 0x%2.2x", cmd->sid);
 }
 
-static void le_remove_dev_periodic_adv_list_cmd(const void *data, uint8_t size)
+static void le_remove_dev_pa_list_cmd(const void *data, uint8_t size)
 {
-	const struct bt_hci_cmd_le_remove_dev_periodic_adv_list *cmd = data;
+	const struct bt_hci_cmd_le_remove_dev_pa_list *cmd = data;
 
 	print_addr_type("Adv address type", cmd->addr_type);
 	print_addr("Adv address", cmd->addr, cmd->addr_type);
 	print_field("SID: 0x%2.2x", cmd->sid);
 }
 
-static void le_read_periodic_adv_list_size_rsp(const void *data, uint8_t size)
+static void le_read_pa_list_size_rsp(const void *data, uint8_t size)
 {
-	const struct bt_hci_rsp_le_read_dev_periodic_adv_list_size *rsp = data;
+	const struct bt_hci_rsp_le_read_dev_pa_list_size *rsp = data;
 
 	print_status(rsp->status);
 	print_field("List size: 0x%2.2x", rsp->list_size);
@@ -7861,15 +7861,15 @@ static void le_tx_test_cmd_v3(const void *data, uint8_t size)
 		print_field("  Antenna ID: %u", cmd->antenna_ids[i]);
 }
 
-static void le_periodic_adv_rec_enable(const void *data, uint8_t size)
+static void le_pa_rec_enable(const void *data, uint8_t size)
 {
-	const struct bt_hci_cmd_le_set_periodic_adv_enable *cmd = data;
+	const struct bt_hci_cmd_le_set_pa_enable *cmd = data;
 
 	print_field("Sync handle: %d", cmd->handle);
 	print_enable("Reporting", cmd->enable);
 }
 
-static void le_periodic_adv_sync_trans(const void *data, uint8_t size)
+static void le_pa_sync_trans(const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_periodic_sync_trans *cmd = data;
 
@@ -7878,9 +7878,9 @@ static void le_periodic_adv_sync_trans(const void *data, uint8_t size)
 	print_field("Sync handle: %d", cmd->sync_handle);
 }
 
-static void le_periodic_adv_set_info_trans(const void *data, uint8_t size)
+static void le_pa_set_info_trans(const void *data, uint8_t size)
 {
-	const struct bt_hci_cmd_periodic_adv_set_info_trans *cmd = data;
+	const struct bt_hci_cmd_pa_set_info_trans *cmd = data;
 
 	print_field("Connection handle: %d", cmd->handle);
 	print_field("Service data: 0x%4.4x", cmd->service_data);
@@ -7909,9 +7909,9 @@ static void print_sync_mode(uint8_t mode)
 	print_field("Mode: %s (0x%2.2x)", str, mode);
 }
 
-static void le_periodic_adv_sync_trans_params(const void *data, uint8_t size)
+static void le_pa_sync_trans_params(const void *data, uint8_t size)
 {
-	const struct bt_hci_cmd_periodic_adv_sync_trans_params *cmd = data;
+	const struct bt_hci_cmd_pa_sync_trans_params *cmd = data;
 
 	print_field("Connection handle: %d", cmd->handle);
 	print_sync_mode(cmd->mode);
@@ -7922,10 +7922,10 @@ static void le_periodic_adv_sync_trans_params(const void *data, uint8_t size)
 	print_create_sync_cte_type(cmd->cte_type);
 }
 
-static void le_set_default_periodic_adv_sync_trans_params(const void *data,
+static void le_set_default_pa_sync_trans_params(const void *data,
 								uint8_t size)
 {
-	const struct bt_hci_cmd_default_periodic_adv_sync_trans_params *cmd = data;
+	const struct bt_hci_cmd_default_pa_sync_trans_params *cmd = data;
 
 	print_sync_mode(cmd->mode);
 	print_field("Skip: 0x%2.2x", cmd->skip);
@@ -9141,13 +9141,13 @@ static const struct opcode_data opcode_table[] = {
 				null_cmd, 0, true,
 				status_rsp, 1, true },
 	{ 0x203e, 298, "LE Set Periodic Advertising Parameters",
-				le_set_periodic_adv_params_cmd, 7, true,
+				le_set_pa_params_cmd, 7, true,
 				status_rsp, 1, true },
 	{ 0x203f, 299, "LE Set Periodic Advertising Data",
-				le_set_periodic_adv_data_cmd, 3, false,
+				le_set_pa_data_cmd, 3, false,
 				status_rsp, 1, true },
 	{ 0x2040, 300, "LE Set Periodic Advertising Enable",
-				le_set_periodic_adv_enable_cmd, 2, true,
+				le_set_pa_enable_cmd, 2, true,
 				status_rsp, 1, true },
 	{ 0x2041, 301, "LE Set Extended Scan Parameters",
 				le_set_ext_scan_params_cmd, 3, false,
@@ -9159,26 +9159,26 @@ static const struct opcode_data opcode_table[] = {
 				le_ext_create_conn_cmd, 10, false,
 				status_rsp, 1, true },
 	{ 0x2044, 304, "LE Periodic Advertising Create Sync",
-				le_periodic_adv_create_sync_cmd, 14, true,
+				le_pa_create_sync_cmd, 14, true,
 				status_rsp, 1, true },
 	{ 0x2045, 305, "LE Periodic Advertising Create Sync Cancel",
 				null_cmd, 0, true,
 				status_rsp, 1, true },
 	{ 0x2046, 306, "LE Periodic Advertising Terminate Sync",
-				le_periodic_adv_term_sync_cmd, 2, true,
+				le_pa_term_sync_cmd, 2, true,
 				status_rsp, 1, true },
 	{ 0x2047, 307, "LE Add Device To Periodic Advertiser List",
-				le_add_dev_periodic_adv_list_cmd, 8, true,
+				le_add_dev_pa_list_cmd, 8, true,
 				status_rsp, 1, true },
 	{ 0x2048, 308, "LE Remove Device From Periodic Advertiser List",
-				le_remove_dev_periodic_adv_list_cmd, 8, true,
+				le_remove_dev_pa_list_cmd, 8, true,
 				status_rsp, 1, true },
 	{ 0x2049, 309, "LE Clear Periodic Advertiser List",
 				null_cmd, 0, true,
 				status_rsp, 1, true },
 	{ 0x204a, 310, "LE Read Periodic Advertiser List Size",
 				null_cmd, 0, true,
-				le_read_periodic_adv_list_size_rsp, 2, true },
+				le_read_pa_list_size_rsp, 2, true },
 	{ 0x204b, 311, "LE Read Transmit Power",
 				null_cmd, 0, true,
 				le_read_tx_power_rsp, 3, true },
@@ -9198,20 +9198,20 @@ static const struct opcode_data opcode_table[] = {
 				le_tx_test_cmd_v3, 9, false,
 				status_rsp, 1, true },
 	{ 0x2059, 325, "LE Periodic Advertising Receive Enable",
-				le_periodic_adv_rec_enable, 3, true,
+				le_pa_rec_enable, 3, true,
 				status_rsp, 1, true },
 	{ 0x205a, 326, "LE Periodic Advertising Sync Transfer",
-				le_periodic_adv_sync_trans, 6, true,
+				le_pa_sync_trans, 6, true,
 				status_handle_rsp, 3, true },
 	{ 0x205b, 327, "LE Periodic Advertising Set Info Transfer",
-				le_periodic_adv_set_info_trans, 5, true,
+				le_pa_set_info_trans, 5, true,
 				status_handle_rsp, 3, true },
 	{ 0x205c, 328, "LE Periodic Advertising Sync Transfer Parameters",
-				le_periodic_adv_sync_trans_params, 8, true,
+				le_pa_sync_trans_params, 8, true,
 				status_handle_rsp, 3, true},
 	{ 0x205d, 329, "LE Set Default Periodic Advertisng Sync Transfer "
 				"Parameters",
-				le_set_default_periodic_adv_sync_trans_params,
+				le_set_default_pa_sync_trans_params,
 				6, true, status_rsp, 1, true},
 	{ BT_HCI_CMD_LE_READ_BUFFER_SIZE_V2,
 				BT_HCI_BIT_LE_READ_BUFFER_SIZE_V2,
@@ -10631,7 +10631,7 @@ static void le_ext_adv_report_evt(const void *data, uint8_t size)
 	}
 }
 
-static void le_per_adv_sync(const void *data, uint8_t size)
+static void le_pa_sync(const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_per_sync_established *evt = data;
 
@@ -10649,9 +10649,9 @@ static void le_per_adv_sync(const void *data, uint8_t size)
 	print_field("Advertiser clock accuracy: 0x%2.2x", evt->clock_accuracy);
 }
 
-static void le_per_adv_report_evt(const void *data, uint8_t size)
+static void le_pa_report_evt(const void *data, uint8_t size)
 {
-	const struct bt_hci_le_per_adv_report *evt = data;
+	const struct bt_hci_le_pa_report *evt = data;
 	const char *color_on;
 	const char *str;
 
@@ -10710,7 +10710,7 @@ static void le_per_adv_report_evt(const void *data, uint8_t size)
 	packet_hexdump(evt->data, evt->data_len);
 }
 
-static void le_per_adv_sync_lost(const void *data, uint8_t size)
+static void le_pa_sync_lost(const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_per_sync_lost *evt = data;
 
@@ -10768,9 +10768,9 @@ static void le_cte_request_failed_evt(const void *data, uint8_t size)
 	print_field("Connection handle: %d", evt->handle);
 }
 
-static void le_per_adv_sync_trans_rec_evt(const void *data, uint8_t size)
+static void le_pa_sync_trans_rec_evt(const void *data, uint8_t size)
 {
-	const struct bt_hci_evt_le_per_adv_sync_trans_rec *evt = data;
+	const struct bt_hci_evt_le_pa_sync_trans_rec *evt = data;
 
 	print_status(evt->status);
 	print_field("Handle: %d", evt->handle);
@@ -10957,11 +10957,11 @@ static const struct subevent_data le_meta_event_table[] = {
 	{ 0x0d, "LE Extended Advertising Report",
 				le_ext_adv_report_evt, 1, false},
 	{ 0x0e, "LE Periodic Advertising Sync Established",
-				le_per_adv_sync, 15, true },
+				le_pa_sync, 15, true },
 	{ 0x0f, "LE Periodic Advertising Report",
-				le_per_adv_report_evt, 7, false},
+				le_pa_report_evt, 7, false},
 	{ 0x10, "LE Periodic Advertising Sync Lost",
-				le_per_adv_sync_lost, 2, true},
+				le_pa_sync_lost, 2, true},
 	{ 0x11, "LE Scan Timeout" },
 	{ 0x12, "LE Advertising Set Terminated",
 				le_adv_set_term_evt, 5, true},
@@ -10972,7 +10972,7 @@ static const struct subevent_data le_meta_event_table[] = {
 	{ 0x17, "LE CTE Request Failed",
 				le_cte_request_failed_evt, 3, true},
 	{ 0x18, "LE Periodic Advertising Sync Transfer Received",
-					le_per_adv_sync_trans_rec_evt, 19,
+					le_pa_sync_trans_rec_evt, 19,
 					true},
 	{ BT_HCI_EVT_LE_CIS_ESTABLISHED,
 				"LE Connected Isochronous Stream Established",
-- 
2.35.1

