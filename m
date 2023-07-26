Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0391DC001E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jul 2023 21:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjGZVZe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jul 2023 17:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjGZVZd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jul 2023 17:25:33 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E19726A0
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jul 2023 14:25:27 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4RB6Pc5PK3z49Q7N;
        Thu, 27 Jul 2023 00:25:24 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1690406724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pLqDflWldlHDXGuQ8EEhZR+uAy7JmyAHwbaz3veUYPM=;
        b=oiKgLD0Zyqo2/mn6YQcpZ1wI9yJ9L0Sv+J/sL53KuyGUZ91fEHecP3ymP2pboM+TGdfUgE
        0p1nVW61G0uZK6El+YYWpJdC65zLc1zVSD3kcyvzWFx/eWBSy17L/JbK8xh0kH+hHnLo1Y
        HWQN+X8fTjA3PLEj9IPrzqoobxGt15cGqnhc5nv//hefTEXyMd3vuLGLmaeujJNueeHUcu
        Wv4CkPKCvi0UrOOG7ehQBW3FOkGio8SfqvPK6Xb5NGnzkXr5EbnI3Ww1Gnt9yWPVm/C9Gk
        Ntj4JuPECtSeMUpuZMmdleNXBLQGNQ5y+As3rI2+/tLK0pTSlyqFxm0MXnwP5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1690406724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pLqDflWldlHDXGuQ8EEhZR+uAy7JmyAHwbaz3veUYPM=;
        b=AR9zbw/Wac12jFaZFKck7Kct75IoY0PCkdYrXXjQJ6lBbk8gLUAQolC+NcmLFx8+MFk/e4
        i68aCoouv//GZgUjBT5KRyZBx7+yAyJclOvzztbqweU6CU675Ju20kG80LYdC30Rdb3oz8
        VfZRO9KH8OOAuGjUYQTHzWuVCatS7Zwrcub+4+3IESRUMP1kL50Mwr3/NoISpMcTc2kKDq
        JGVpSOOumVIAFWMR7ZiR3YBw95cS+5Eh3QajTPyKEISYDW4/gI02DE8jF/wIHJeKkX34wI
        6yGc7y9Vr1vu6OhO/N46Uu0eEpR7J+/nyDfXTAHdN+OvQO8/3BGiP24hLJPA8g==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1690406724; a=rsa-sha256;
        cv=none;
        b=PB3bz7Pz8O3OXDnGe/zenAheZejNJQeA21LK4KPB6oX/XnfZxjhMCO0rlAR5pKNZBlERK6
        j1UPKa3V8ph8E68gaQXLuFvGtctTM0JdIy6FJ32I0nbCnnJpHAss3QQJQhufRH3sJLjfps
        xSPlBcBFlD5nGxuo8lnSOTecofobN6czBu3axeGlX2eXf9iMrzsqs/8bTiwXzzFp601hqe
        /TWNWYHYK2+6Gl1frXc9R97jB6Wwo6295su+hKAuTgY7NJQiV7ZXklwZm1Q6N8W4vu3ZuW
        5+mFizv9xRj/1S5SbY8BFf+UsVKFFb2vjWq86T/OGWkugN5toRJ2LIGHYDoPrA==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/5] btdev: check error conditions for HCI_Create_Connection_Cancel
Date:   Thu, 27 Jul 2023 00:25:15 +0300
Message-ID: <15f85f2e419757a2c689e8572ccf7793a931f555.1690405564.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690405564.git.pav@iki.fi>
References: <cover.1690405564.git.pav@iki.fi>
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
 emulator/btdev.c | 76 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 68 insertions(+), 8 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 637f0bb98..0c75e71c0 100644
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
+	int i;
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
+	int i;
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
@@ -1296,14 +1331,47 @@ static int cmd_add_sco_conn(struct btdev *dev, const void *data, uint8_t len)
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
+	const struct bt_hci_cmd_create_conn_cancel *cmd = data;
+	struct btdev *remote = find_btdev_by_bdaddr(cmd->bdaddr);
+	struct btdev_conn *conn;
+
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
+	if (!pending_conn_del(dev, remote)) {
+		conn = queue_find(dev->conns, match_bdaddr, cmd->bdaddr);
+		if (conn)
+			return -EEXIST;
+
+		return -ENOENT;
+	}
+
 	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_CREATE_CONN_CANCEL);
 
 	return 0;
@@ -1372,14 +1440,6 @@ static int cmd_link_key_reply(struct btdev *dev, const void *data, uint8_t len)
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
-- 
2.41.0

