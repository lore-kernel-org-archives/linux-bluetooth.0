Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595F4C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Mar 2022 01:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiCEBXc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Mar 2022 20:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiCEBX1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Mar 2022 20:23:27 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F1731222
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Mar 2022 17:22:38 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id gb21so8668777pjb.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Mar 2022 17:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=S3XNC5obP+w/h0Z9WSaAkiva6CDaOCeNCUkMcPJpXoQ=;
        b=oplMO0EXDp24jyYFsLn7eLFYNI8MJXvrH+HZPbqwY8+eVunPcQgdCCfEsYkFBSgrfS
         XB5vPa3ZWkx9bpLxZrObukJJN72YDr16HSSa64ujsxeLougMvxeEakLRgYYUc9fGMg/h
         ex+KCYsWMwqCVuD/GErWdxqS6z/asNro0f6R+wkHGy/NrLFO1mRw3Up0mAVHjVsEhQHS
         a2A1XMrEmMNKpg7yDu92fdO4Q8A9JfVZ37I+a5HPGZQ/8QOVint5+0dNOhaqwlPB6Kas
         IlKmNb32ZXPS4hwxDhxuYAodGt8fYrdSUpPKf84WIbP9O9/92jWpnaghbmSw88/0zjja
         M3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S3XNC5obP+w/h0Z9WSaAkiva6CDaOCeNCUkMcPJpXoQ=;
        b=5FbbxWtUFR0fvckhqHCnuUQUfwHVP4TnHc4RnWXv1zOX/A02gyojvmiOGdfrk6h+TB
         kpsa50Jj6BqHurGUHgEDVu2mn4KDjN30PRhhZHjcqLiMlPEyEdmKbfs4ieteWsNQ92fr
         8LRbX7dyqGxok3b+mjeYB61eM1LvHDup1e36wZTytMaTvecB3W4FW+mtC2EjDuYkAhFO
         8wPT9QLQ8UtRGYDEWVrwP+2M3Mrs1Thttp/o72xhY/jlLuZRsw0FEQ01/uTCmSESMiV9
         Djrluruo/FZyu5Cyd1SEwvY0Zq/w4wHZ+RoBmSTUErw5P4l9d4My8P3ZPGs7w5W5Gbee
         3yKQ==
X-Gm-Message-State: AOAM532deaJFolZG40bjdn8MxWsaTSOPuDsXsOksEunqRbky+6MgVY4N
        4yPozubiNOW8gk8/Xse7U5BP2z8hnv4=
X-Google-Smtp-Source: ABdhPJyeZ67KA1QDR2rOblC0z49N1uRMS8qsbtKaOElPJGBxCzQFCzzGWN4xw/94PP0nKZN21iDOGg==
X-Received: by 2002:a17:902:9a4c:b0:14d:b0c0:1f7a with SMTP id x12-20020a1709029a4c00b0014db0c01f7amr1161385plv.57.1646443357579;
        Fri, 04 Mar 2022 17:22:37 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m16-20020a638c10000000b0037c4cf366c0sm5363932pgd.61.2022.03.04.17.22.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 17:22:37 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 08/12] btdev: Implements BT_HCI_CMD_LE_BIG_CREATE_SYNC
Date:   Fri,  4 Mar 2022 17:22:25 -0800
Message-Id: <20220305012229.853784-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220305012229.853784-1-luiz.dentz@gmail.com>
References: <20220305012229.853784-1-luiz.dentz@gmail.com>
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

