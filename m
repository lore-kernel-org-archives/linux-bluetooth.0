Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF184C41513
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Aug 2023 16:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjHAQiy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Aug 2023 12:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjHAQiu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Aug 2023 12:38:50 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9281FFA
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Aug 2023 09:38:48 -0700 (PDT)
Received: from monolith.lan (unknown [193.138.7.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4RFgm62r5Zz49Q80;
        Tue,  1 Aug 2023 19:38:46 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1690907926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cWDF6NzBpd2qffF2qX/Q4yfm5FctR7l8DJawxZV+a3E=;
        b=tj0542y2DIUUdYwHUgWtMte6Q9jDLoUTmT7kECOB3ia1vI92E2UqmigHjNPL3sBYSYlPp3
        Pff5j/XhNbRGYEbhYPY9u1nPUeONncjo647POoP/yJnrd8whRAMx5QDkizcqjCNV+Uh5oE
        rKZ76N+jtBpe6kE+55a1a+aYVbwX85TPVKhvTFmK7Ie3kyxqYJyLw3SZUPm/alvJkmsUlt
        Niwra6+fy1zRm4LZOH+bAL/P6hDpbJpayRdPJNKV/1Z0GRobJtpuSIU24+F7qX+04uZ8dP
        xbOBgFhQOrcKwz6G4+6vhZvFy9Din3C/dfrN7hJCphvA4lpPaJ2VqeqT9XMk5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1690907926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cWDF6NzBpd2qffF2qX/Q4yfm5FctR7l8DJawxZV+a3E=;
        b=t14LqmqQ6a8TXLVtc53H4luh98C0oHdO0ogNAFyY7gneWFXIQvmRvHngXHtVuf6aXUUsJl
        NOA+kJTuQiAsWUVDvWBOukjw3siz9k5+UOVAHM5kxFuquBVibihUCMicnaxm4+nxBT+EaR
        h4RSx9J1yl+KrwhTS1dINcGFK8nOEDOFcXJd7ZFbmzjJXvDBdAySMxfNG9KQ/o7mZIoINc
        woSCuiSpn9Y/h9wFWkjIGX2IO0laBmFiG11x7laxrsW3qHXWZEqTh7mZYvq/h2MVzEroUf
        UiD+5ZdJvJK/09036RLj9uu0Dci2Qgpy0N2Gbglaj2M3jRI7sL8o38JTE1Gmfg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1690907926; a=rsa-sha256;
        cv=none;
        b=SfjuVWgBklRgxGBieApexnNXGZzeIEs/cFB/P2PqFX8qwHtJKn6a18MYbCwCMvU23D+Ax9
        Cw5qPp7V9nT3X0Gxo6D4ma/TeB76V/gjDHndj96qGhfb9ERzOF2EOnVPtvCQ3qyXA5gHMr
        PSDPN+lrevukymJhuqLGPDzsgWhW3Z5ewovnqVyP3bTSElyIPhEF+hejZfs708INIluWLq
        znoUCZVEjYyLSnGMf/yrYyl62NGlihrgB9TcYQhTHmOUeA+4shYjMCvNOhzgm6Y6dUsh80
        ONooK8K+lCrOS0v2jNGe5Rp5JmjDqbWCb2QO1OpQvoCHNVxmce+yWckCezBodQ==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 1/5] btdev: check error conditions for HCI_Create_Connection_Cancel
Date:   Tue,  1 Aug 2023 19:38:38 +0300
Message-ID: <5eca51146b08a512052261b88ae5c8a7437af5fc.1690907478.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690907478.git.pav@iki.fi>
References: <cover.1690907478.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Create Connection Cancel shall return Command Complete with error status
when there is no Create Connection that can be canceled.  In these
cases, we should not send a (spurious) Connection Complete event.

Fix by keeping a list of pending Create Connection commands, and
returning command errors if there is none pending at the moment.
---

Notes:
    v2: emit Command_Complete (not Status) + fix compile

 emulator/btdev.c | 86 +++++++++++++++++++++++++++++++++++++++++-------
 monitor/bt.h     |  4 +++
 2 files changed, 79 insertions(+), 11 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 637f0bb98..8658b4121 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -62,6 +62,7 @@ struct hook {
 
 #define MAX_HOOK_ENTRIES 16
 #define MAX_EXT_ADV_SETS 3
+#define MAX_PENDING_CONN 16
 
 struct btdev_conn {
 	uint16_t handle;
@@ -223,6 +224,8 @@ struct btdev {
 	uint8_t  le_rl_enable;
 	uint16_t le_rl_timeout;
 
+	struct btdev *pending_conn[MAX_PENDING_CONN];
+
 	uint8_t le_local_sk256[32];
 
 	uint16_t sync_train_interval;
@@ -1211,10 +1214,36 @@ static struct btdev_conn *conn_link_bis(struct btdev *dev, struct btdev *remote,
 	return conn;
 }
 
+static void pending_conn_add(struct btdev *btdev, struct btdev *remote)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(btdev->pending_conn); ++i) {
+		if (!btdev->pending_conn[i]) {
+			btdev->pending_conn[i] = remote;
+			return;
+		}
+	}
+}
+
+static bool pending_conn_del(struct btdev *btdev, struct btdev *remote)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(btdev->pending_conn); ++i) {
+		if (btdev->pending_conn[i] == remote) {
+			btdev->pending_conn[i] = NULL;
+			return true;
+		}
+	}
+	return false;
+}
+
 static void conn_complete(struct btdev *btdev,
 					const uint8_t *bdaddr, uint8_t status)
 {
 	struct bt_hci_evt_conn_complete cc;
+	struct btdev *remote = find_btdev_by_bdaddr(bdaddr);
 
 	if (!status) {
 		struct btdev_conn *conn;
@@ -1223,6 +1252,8 @@ static void conn_complete(struct btdev *btdev,
 		if (!conn)
 			return;
 
+		pending_conn_del(conn->link->dev, btdev);
+
 		cc.status = status;
 		memcpy(cc.bdaddr, btdev->bdaddr, 6);
 		cc.encr_mode = 0x00;
@@ -1240,6 +1271,8 @@ static void conn_complete(struct btdev *btdev,
 		cc.link_type = 0x01;
 	}
 
+	pending_conn_del(btdev, remote);
+
 	cc.status = status;
 	memcpy(cc.bdaddr, bdaddr, 6);
 	cc.encr_mode = 0x00;
@@ -1260,6 +1293,8 @@ static int cmd_create_conn_complete(struct btdev *dev, const void *data,
 		memcpy(cr.dev_class, dev->dev_class, 3);
 		cr.link_type = 0x01;
 
+		pending_conn_add(dev, remote);
+
 		send_event(remote, BT_HCI_EVT_CONN_REQUEST, &cr, sizeof(cr));
 	} else {
 		conn_complete(dev, cmd->bdaddr, BT_HCI_ERR_PAGE_TIMEOUT);
@@ -1296,16 +1331,24 @@ static int cmd_add_sco_conn(struct btdev *dev, const void *data, uint8_t len)
 	cc.encr_mode = 0x00;
 
 done:
+	pending_conn_del(dev, conn->link->dev);
+
 	send_event(dev, BT_HCI_EVT_CONN_COMPLETE, &cc, sizeof(cc));
 
 	return 0;
 }
 
+static bool match_bdaddr(const void *data, const void *match_data)
+{
+	const struct btdev_conn *conn = data;
+	const uint8_t *bdaddr = match_data;
+
+	return !memcmp(conn->link->dev->bdaddr, bdaddr, 6);
+}
+
 static int cmd_create_conn_cancel(struct btdev *dev, const void *data,
 							uint8_t len)
 {
-	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_CREATE_CONN_CANCEL);
-
 	return 0;
 }
 
@@ -1313,8 +1356,37 @@ static int cmd_create_conn_cancel_complete(struct btdev *dev, const void *data,
 							uint8_t len)
 {
 	const struct bt_hci_cmd_create_conn_cancel *cmd = data;
+	struct bt_hci_rsp_create_conn_cancel rp;
+	struct btdev *remote = find_btdev_by_bdaddr(cmd->bdaddr);
+	struct btdev_conn *conn;
 
-	conn_complete(dev, cmd->bdaddr, BT_HCI_ERR_UNKNOWN_CONN_ID);
+	/* BLUETOOTH CORE SPECIFICATION Version 5.4 | Vol 4, Part E page 1848
+	 *
+	 * If the connection is already established, and the
+	 * HCI_Connection_Complete event has been sent, then the Controller
+	 * shall return an HCI_Command_Complete event with the error code
+	 * Connection Already Exists (0x0B). If the HCI_Create_Connection_Cancel
+	 * command is sent to the Controller without a preceding
+	 * HCI_Create_Connection command to the same device, the BR/EDR
+	 * Controller shall return an HCI_Command_Complete event with the error
+	 * code Unknown Connection Identifier (0x02).
+	 */
+	if (pending_conn_del(dev, remote)) {
+		rp.status = BT_HCI_ERR_SUCCESS;
+	} else {
+		conn = queue_find(dev->conns, match_bdaddr, cmd->bdaddr);
+		if (conn)
+			rp.status = BT_HCI_ERR_CONN_ALREADY_EXISTS;
+		else
+			rp.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+	}
+
+	memcpy(rp.bdaddr, cmd->bdaddr, sizeof(rp.bdaddr));
+
+	cmd_complete(dev, BT_HCI_CMD_CREATE_CONN_CANCEL, &rp, sizeof(rp));
+
+	if (!rp.status)
+		conn_complete(dev, cmd->bdaddr, BT_HCI_ERR_UNKNOWN_CONN_ID);
 
 	return 0;
 }
@@ -1372,14 +1444,6 @@ static int cmd_link_key_reply(struct btdev *dev, const void *data, uint8_t len)
 	return 0;
 }
 
-static bool match_bdaddr(const void *data, const void *match_data)
-{
-	const struct btdev_conn *conn = data;
-	const uint8_t *bdaddr = match_data;
-
-	return !memcmp(conn->link->dev->bdaddr, bdaddr, 6);
-}
-
 static void auth_complete(struct btdev_conn *conn, uint8_t status)
 {
 	struct bt_hci_evt_auth_complete ev;
diff --git a/monitor/bt.h b/monitor/bt.h
index dca2dc8b8..6fb81abfe 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -590,6 +590,10 @@ struct bt_hci_cmd_add_sco_conn {
 struct bt_hci_cmd_create_conn_cancel {
 	uint8_t  bdaddr[6];
 } __attribute__ ((packed));
+struct bt_hci_rsp_create_conn_cancel {
+	uint8_t  status;
+	uint8_t  bdaddr[6];
+} __attribute__ ((packed));
 
 #define BT_HCI_CMD_ACCEPT_CONN_REQUEST		0x0409
 struct bt_hci_cmd_accept_conn_request {
-- 
2.41.0

