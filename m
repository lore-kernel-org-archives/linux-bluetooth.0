Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD047C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 00:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiBXAbJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Feb 2022 19:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiBXAbI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Feb 2022 19:31:08 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94E56D976
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 16:30:38 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id x11so262036pll.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 16:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=S3XNC5obP+w/h0Z9WSaAkiva6CDaOCeNCUkMcPJpXoQ=;
        b=JsNldMp0ES1m3ifS8VxZDytS0WGcEpvHur1ZbovLiUOHDKep2vwDvTKHVqTPfEaT4+
         Lb1iUqV8y4FaSCBUXsMTjxNFGER5I3R13E/Eh5HLcZDTyTepQwEYN5xbAWzV795SMd8r
         HO4qpDvcW7/KGEuzvacNeBjL25umFqPbdXX1s5S3RZbCbEOEWniat8JXyKXiitM5IkKK
         FiPu7Yc8LNnZkiQbbrBi5IDoVL66sa1ZVqCb0wygXfPFT8njZCRIhBr0pymtD40/8BpJ
         9Rh94KI6NtjInr5Eu/hEM6Xjie6zWOheVs1ZxLXFe51CkeW8/Zr0EnI0h5uE2PO4sbiU
         Lgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S3XNC5obP+w/h0Z9WSaAkiva6CDaOCeNCUkMcPJpXoQ=;
        b=PkYoNLJIgKgYLAzlPOn6br8DCxSr6lqftnAE//YxVW+5Fy55rHNJJgthfz97Ruw1VL
         gVx/1nxN1tNKurCEGCEgA/XNVT3Glv5lzehu2WhO0z3u2PhIvp3WSbzFO0dEHQb95izU
         39cFRcEUebSSMpmXK9WAB7OD147Ktv0gwmgTfRsqYc/OIitRZsCgPaSrBbr1ids/3dIg
         XLlLCVPubPCI6BkbUz6qKZezYINms7qQYJLIrkhKeNkTOHhLmZ6dVFjHaTlaAK3fu6SP
         0fbB7/f+e6kFnKN6lzFLH0ulGKCUk2VyozrJ6Q7zY2C7zPKAE4HGXqbLQBUfZ7Z2/8Mj
         Cbpg==
X-Gm-Message-State: AOAM531L2yLmR1Bj4kf+OycAGqn3FYbtuJoGEmVmkAW5/sahTl6tr9dN
        d1wsPUjl4u6r6PdO10g3/agVmt412Ng=
X-Google-Smtp-Source: ABdhPJw82MvpBpVCVohgngQC8/ui+rn3CBeHYsJrOVCK0GzmdT/XPLuDkjRlxBOZTT+AWn3WVkQFLg==
X-Received: by 2002:a17:902:8492:b0:14d:5ddc:9df6 with SMTP id c18-20020a170902849200b0014d5ddc9df6mr325150plo.15.1645662637710;
        Wed, 23 Feb 2022 16:30:37 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id t19sm574570pjs.54.2022.02.23.16.30.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 16:30:37 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 08/11] btdev: Implements BT_HCI_CMD_LE_BIG_CREATE_SYNC
Date:   Wed, 23 Feb 2022 16:30:26 -0800
Message-Id: <20220224003029.706163-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220224003029.706163-1-luiz.dentz@gmail.com>
References: <20220224003029.706163-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This sends BT_HCI_EVT_LE_BIG_SYNC_ESTABLISHED when handling
BT_HCI_CMD_LE_BIG_CREATE_SYNC.
---
 emulator/btdev.c | 158 ++++++++++++++++++++++++++++++++++++++++++++---
 monitor/bt.h     |   1 +
 2 files changed, 150 insertions(+), 9 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 10fa046bc..567377caa 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -40,6 +40,7 @@
 #define AL_SIZE			16
 #define RL_SIZE			16
 #define CIS_SIZE		3
+#define BIS_SIZE		3
 
 #define has_bredr(btdev)	(!((btdev)->features[4] & 0x20))
 #define has_le(btdev)		(!!((btdev)->features[4] & 0x40))
@@ -65,6 +66,7 @@ struct btdev_conn {
 	uint8_t  type;
 	struct btdev *dev;
 	struct btdev_conn *link;
+	void *data;
 };
 
 struct btdev_al {
@@ -199,6 +201,7 @@ struct btdev {
 	uint8_t  le_pa_data[31];
 	struct bt_hci_cmd_le_pa_create_sync pa_sync_cmd;
 	uint16_t le_pa_sync_handle;
+	uint8_t  big_handle;
 	uint8_t  le_ltk[16];
 	struct {
 		struct bt_hci_cmd_le_set_cig_params params;
@@ -690,6 +693,7 @@ static void conn_remove(void *data)
 
 	queue_remove(conn->dev->conns, conn);
 
+	free(conn->data);
 	free(conn);
 }
 
@@ -1121,9 +1125,65 @@ static struct btdev_conn *conn_add_cis(struct btdev_conn *acl, uint16_t handle)
 	return conn_link(acl->dev, acl->link->dev, handle, HCI_ISODATA_PKT);
 }
 
-static struct btdev_conn *conn_add_bis(struct btdev *dev, uint16_t handle)
+static struct btdev_conn *conn_add_bis(struct btdev *dev, uint16_t handle,
+						const struct bt_hci_bis *bis)
 {
-	return conn_new(dev, handle, HCI_ISODATA_PKT);
+	struct btdev_conn *conn;
+
+	conn = conn_new(dev, handle, HCI_ISODATA_PKT);
+	if (!conn)
+		return conn;
+
+	conn->data = util_memdup(bis, sizeof(*bis));
+
+	return conn;
+}
+
+static struct btdev_conn *find_bis_index(struct btdev *remote, uint8_t index)
+{
+	struct btdev_conn *conn;
+	const struct queue_entry *entry;
+
+	for (entry = queue_get_entries(remote->conns); entry;
+					entry = entry->next) {
+		conn = entry->data;
+
+		/* Skip if not a broadcast */
+		if (conn->type != HCI_ISODATA_PKT || conn->link)
+			continue;
+
+		if (!index)
+			return conn;
+
+		index--;
+	}
+
+	return NULL;
+}
+
+static struct btdev_conn *conn_link_bis(struct btdev *dev, struct btdev *remote,
+							uint8_t index)
+{
+	struct btdev_conn *conn;
+	struct btdev_conn *bis;
+
+	bis = find_bis_index(remote, index);
+	if (!bis)
+		return NULL;
+
+	conn = conn_add_bis(dev, ISO_HANDLE, bis->data);
+	if (!conn)
+		return NULL;
+
+	bis->link = conn;
+	conn->link = bis;
+
+	util_debug(dev->debug_callback, dev->debug_data,
+				"bis %p handle 0x%04x", bis, bis->handle);
+	util_debug(dev->debug_callback, dev->debug_data,
+				"conn %p handle 0x%04x", conn, conn->handle);
+
+	return conn;
 }
 
 static void conn_complete(struct btdev *btdev,
@@ -5103,8 +5163,6 @@ static void le_pa_sync_estabilished(struct btdev *dev, struct btdev *remote,
 	ev.interval = remote->le_pa_min_interval;
 	ev.clock_accuracy = 0x07;
 
-	memset(&dev->pa_sync_cmd, 0, sizeof(dev->pa_sync_cmd));
-
 	le_meta_event(dev, BT_HCI_EVT_LE_PA_SYNC_ESTABLISHED, &ev, sizeof(ev));
 	send_pa(dev, remote, 0);
 }
@@ -5858,14 +5916,14 @@ static int cmd_create_big_complete(struct btdev *dev, const void *data,
 
 		memset(&pdu, 0, sizeof(pdu));
 
-		conn = conn_add_bis(dev, ISO_HANDLE);
+		conn = conn_add_bis(dev, ISO_HANDLE, bis);
 		if (!conn) {
 			pdu.evt.status = BT_HCI_ERR_MEM_CAPACITY_EXCEEDED;
 			goto done;
 		}
 
 		pdu.evt.handle = cmd->handle;
-		pdu.evt.num_bis = 0x01;
+		pdu.evt.num_bis++;
 		pdu.evt.phy = bis->phy;
 		pdu.evt.max_pdu = bis->sdu;
 		memcpy(pdu.evt.sync_delay, bis->sdu_interval, 3);
@@ -5910,8 +5968,89 @@ static int cmd_term_big_complete(struct btdev *dev, const void *data,
 
 static int cmd_big_create_sync(struct btdev *dev, const void *data, uint8_t len)
 {
-	/* TODO */
-	return -ENOTSUP;
+	const struct bt_hci_cmd_le_big_create_sync *cmd = data;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
+
+	/* If the Sync_Handle does not exist, the Controller shall return the
+	 * error code Unknown Advertising Identifier (0x42).
+	 */
+	if (dev->le_pa_sync_handle != le16_to_cpu(cmd->sync_handle))
+		status = BT_HCI_ERR_UNKNOWN_ADVERTISING_ID;
+
+	/* If the Host sends this command with a BIG_Handle that is already
+	 * allocated, the Controller shall return the error code Command
+	 * Disallowed (0x0C).
+	 */
+	if (dev->big_handle == cmd->handle)
+		status = BT_HCI_ERR_COMMAND_DISALLOWED;
+
+	/* If the Num_BIS parameter is greater than the total number of BISes
+	 * in the BIG, the Controller shall return the error code Unsupported
+	 * Feature or Parameter Value (0x11).
+	 */
+	if (cmd->num_bis != len - sizeof(*cmd))
+		status = BT_HCI_ERR_UNSUPPORTED_FEATURE;
+
+	if (status)
+		return status;
+
+	cmd_status(dev, status, BT_HCI_CMD_LE_BIG_CREATE_SYNC);
+
+	return status;
+}
+
+static int cmd_big_create_sync_complete(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_le_big_create_sync *cmd = data;
+	struct __packed {
+		struct bt_hci_evt_le_big_sync_estabilished ev;
+		uint16_t bis[BIS_SIZE];
+	} pdu;
+	struct btdev *remote;
+	struct btdev_conn *conn = NULL;
+	struct bt_hci_bis *bis;
+	int i;
+
+	remote = find_btdev_by_bdaddr_type(dev->pa_sync_cmd.addr,
+						dev->pa_sync_cmd.addr_type);
+	if (!remote)
+		return 0;
+
+	memset(&pdu.ev, 0, sizeof(pdu.ev));
+
+	for (i = 0; i < cmd->num_bis; i++) {
+		conn = conn_link_bis(dev, remote, i);
+		if (!conn)
+			break;
+
+		pdu.bis[i] = cpu_to_le16(conn->handle);
+	}
+
+	if (i != cmd->num_bis || !conn) {
+		pdu.ev.status = BT_HCI_ERR_MEM_CAPACITY_EXCEEDED;
+		le_meta_event(dev, BT_HCI_EVT_LE_BIG_SYNC_ESTABILISHED, &pdu,
+					sizeof(pdu.ev));
+		return 0;
+	}
+
+	dev->big_handle = cmd->handle;
+	bis = conn->data;
+
+	pdu.ev.handle = cmd->handle;
+	memcpy(pdu.ev.latency, bis->sdu_interval, sizeof(pdu.ev.interval));
+	pdu.ev.nse = 0x01;
+	pdu.ev.bn = 0x01;
+	pdu.ev.pto = 0x00;
+	pdu.ev.irc = 0x01;
+	pdu.ev.max_pdu = bis->sdu;
+	pdu.ev.interval = bis->latency;
+	pdu.ev.num_bis = cmd->num_bis;
+
+	le_meta_event(dev, BT_HCI_EVT_LE_BIG_SYNC_ESTABILISHED, &pdu,
+			sizeof(pdu.ev) + (cmd->num_bis * sizeof(uint16_t)));
+
+	return 0;
 }
 
 static int cmd_big_term_sync(struct btdev *dev, const void *data, uint8_t len)
@@ -6125,7 +6264,8 @@ static int cmd_config_data_path(struct btdev *dev, const void *data,
 			cmd_create_big_complete), \
 	CMD(BT_HCI_CMD_LE_CREATE_BIG_TEST, cmd_create_big_test, NULL), \
 	CMD(BT_HCI_CMD_LE_TERM_BIG, cmd_term_big, cmd_term_big_complete), \
-	CMD(BT_HCI_CMD_LE_BIG_CREATE_SYNC, cmd_big_create_sync, NULL), \
+	CMD(BT_HCI_CMD_LE_BIG_CREATE_SYNC, cmd_big_create_sync, \
+			cmd_big_create_sync_complete), \
 	CMD(BT_HCI_CMD_LE_BIG_TERM_SYNC, cmd_big_term_sync, NULL), \
 	CMD(BT_HCI_CMD_LE_REQ_PEER_SCA, cmd_req_peer_sca, NULL), \
 	CMD(BT_HCI_CMD_LE_SETUP_ISO_PATH, cmd_setup_iso_path, NULL), \
diff --git a/monitor/bt.h b/monitor/bt.h
index 5c2acee67..3bee11868 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2797,6 +2797,7 @@ struct bt_hci_cmd_le_term_big {
 #define BT_HCI_CMD_LE_BIG_CREATE_SYNC		0x206b
 #define BT_HCI_BIT_LE_BIG_CREATE_SYNC		BT_HCI_CMD_BIT(43, 0)
 struct bt_hci_bis_sync {
+	uint8_t  index;
 } __attribute__ ((packed));
 
 struct bt_hci_cmd_le_big_create_sync {
-- 
2.35.1

