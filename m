Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883E8C2BBCF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Dec 2020 00:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 372AA23A5C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Dec 2020 00:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732141AbgLRAOg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Dec 2020 19:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731130AbgLRAOg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Dec 2020 19:14:36 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4559AC061794
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Dec 2020 16:13:56 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id q22so415826pfk.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Dec 2020 16:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=slTTTxTfxp4Eij+N1FYVybwSkV1mtr+po+1ATYUsdNo=;
        b=Hde7x918COuaeaQZfacbMhrJcf6XEVL7QnEJ9kg5F6POReSmSXMOw+J+DN+tw8c/qI
         5pyTwuvRSbpVljuI59GddEYROS6myAoQ8lhNUHtBz0oLQyrskAThEaOm9abf1hKfrZab
         0jP73+5/O8dbPx25WTTKqzEbMmvzK9dNZX7bal/2/6341kD7SIXr31YsLDxTGc2VMhdT
         QXJ3UzLDRQJts2mIvCuvEXmlPd5B3mRt/0Lj2F42b5EuzkVi+VoaQehOezf/dqCjuuZF
         3v03SEOIhB0DE4SEvaZuMcV3K6yCdC0JFUlWMscV5vgWK7yKpa0b/ssAjqiIjd8p4mhx
         s9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=slTTTxTfxp4Eij+N1FYVybwSkV1mtr+po+1ATYUsdNo=;
        b=T3iFK+cwc00xMIu8S7kGMNc4EViY+dbN3/+A+vKSLqnven9Xs1xHEz/zx8KrKMA0PB
         /p65bikd9Lng0XNMfGUQqvWUVuZFi42KSrLtJWzqIMM8mjA4CnQZHkFCftHKKLB7rm8m
         X/Me725UHk8WvUka30GW/T9+o6uv88Dq6znWk9VEzqvn7ISGmSuGxhWtmCGmAJ733Ymj
         Zngjjf3/srJJ2tKIPwoP1tuplhbxR22QjHGrjzmmuTJZ4XoDMfB4gznXAfziW54mOdpE
         O+YWDiWgR9xGivkElNDAKDcfHTb3IpMDusEE5svOOXelbqk+6JyBsvUzHQZ1pcwzCOfQ
         Ajow==
X-Gm-Message-State: AOAM531wGhJqGQDe9orV78lRjZwcgbrIJFuhULOlLleNMnjvj0R2D0+r
        AhJL7zx8L9a2QnY3M7sZUnk5VofgESY=
X-Google-Smtp-Source: ABdhPJytZ6iu758/g/UyFwIwf4CKXZh9RdKd82YRTOGeKHRG0/1aDpBPO/1OHMzukgEezav1JZqt2g==
X-Received: by 2002:a63:4b54:: with SMTP id k20mr1762690pgl.290.1608250434550;
        Thu, 17 Dec 2020 16:13:54 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m77sm6428189pfd.105.2020.12.17.16.13.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 16:13:53 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/3] btdev: Add support for multiple connections
Date:   Thu, 17 Dec 2020 16:13:49 -0800
Message-Id: <20201218001351.1442784-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for assigning different handles for connection
instead of always using fixed handles.
---
 emulator/btdev.c | 930 +++++++++++++++++++++++++++++++----------------
 lib/hci.h        |   1 +
 2 files changed, 610 insertions(+), 321 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index a26d73865..ae382d9b9 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -29,6 +29,7 @@
 #include "src/shared/timeout.h"
 #include "src/shared/crypto.h"
 #include "src/shared/ecc.h"
+#include "src/shared/queue.h"
 #include "monitor/bt.h"
 #include "btdev.h"
 
@@ -36,7 +37,7 @@
 #define has_le(btdev)		(!!((btdev)->features[4] & 0x40))
 
 #define ACL_HANDLE 42
-#define ISO_HANDLE 44
+#define ISO_HANDLE 257
 #define SCO_HANDLE 257
 
 struct hook {
@@ -48,10 +49,17 @@ struct hook {
 
 #define MAX_HOOK_ENTRIES 16
 
+struct btdev_conn {
+	uint16_t handle;
+	uint8_t  type;
+	struct btdev *dev;
+	struct btdev_conn *link;
+};
+
 struct btdev {
 	enum btdev_type type;
 
-	struct btdev *conn;
+	struct queue *conns;
 
 	bool auth_init;
 	uint8_t link_key[16];
@@ -520,36 +528,70 @@ static void send_event(struct btdev *btdev, uint8_t event,
 		send_packet(btdev, iov, len > 0 ? 3 : 2);
 }
 
+static bool match_handle(const void *data, const void *match_data)
+{
+	const struct btdev_conn *conn = data;
+	uint16_t handle = PTR_TO_UINT(match_data);
+
+	return conn->handle == handle;
+}
+
+static void conn_unlink(struct btdev_conn *conn1, struct btdev_conn *conn2)
+{
+	conn1->link = NULL;
+	conn2->link = NULL;
+}
+
+static void conn_remove(struct btdev_conn *conn)
+{
+	if (conn->link) {
+		struct btdev_conn *link = conn->link;
+
+		conn_unlink(conn, conn->link);
+		conn_remove(link);
+	}
+
+	queue_remove(conn->dev->conns, conn);
+
+	free(conn);
+}
+
+static void disconnect_complete(struct btdev *dev, uint16_t handle,
+					uint8_t status, uint8_t reason)
+{
+	struct bt_hci_evt_disconnect_complete rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+
+	rsp.status = status;
+	rsp.handle = cpu_to_le16(handle);
+	rsp.reason = reason;
+
+	send_event(dev, BT_HCI_EVT_DISCONNECT_COMPLETE, &rsp, sizeof(rsp));
+}
+
 static int cmd_disconnect_complete(struct btdev *dev, const void *data,
 						uint8_t len)
 {
 	const struct bt_hci_cmd_disconnect *cmd = data;
 	struct bt_hci_evt_disconnect_complete rsp;
-	struct btdev *remote = dev->conn;
+	struct btdev_conn *conn;
 
 	memset(&rsp, 0, sizeof(rsp));
 
-	if (!remote) {
-		rsp.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
-		rsp.handle = cpu_to_le16(cmd->handle);
-		rsp.reason = 0x00;
-
-		send_event(dev, BT_HCI_EVT_DISCONNECT_COMPLETE, &rsp,
-						sizeof(rsp));
+	conn = queue_remove_if(dev->conns, match_handle,
+				UINT_TO_PTR(cpu_to_le16(cmd->handle)));
+	if (!conn) {
+		disconnect_complete(dev, 0x0000, BT_HCI_ERR_UNKNOWN_CONN_ID,
+								0x00);
 		return 0;
 	}
 
-	rsp.status = BT_HCI_ERR_SUCCESS;
-	rsp.handle = cpu_to_le16(cmd->handle);
-	rsp.reason = cmd->reason;
+	disconnect_complete(dev, conn->handle, BT_HCI_ERR_SUCCESS, cmd->reason);
+	disconnect_complete(conn->link->dev, conn->link->handle,
+				BT_HCI_ERR_SUCCESS, cmd->reason);
 
-	if (rsp.handle == ACL_HANDLE) {
-		dev->conn = NULL;
-		remote->conn = NULL;
-	}
-
-	send_event(dev, BT_HCI_EVT_DISCONNECT_COMPLETE, &rsp, sizeof(rsp));
-	send_event(remote, BT_HCI_EVT_DISCONNECT_COMPLETE, &rsp, sizeof(rsp));
+	conn_remove(conn);
 
 	return 0;
 }
@@ -566,15 +608,18 @@ static int cmd_remote_version_complete(struct btdev *dev, const void *data,
 {
 	const struct bt_hci_cmd_read_remote_version *cmd = data;
 	struct bt_hci_evt_remote_version_complete ev;
+	struct btdev_conn *conn;
 
 	memset(&ev, 0, sizeof(ev));
 
-	if (dev->conn) {
+	conn = queue_find(dev->conns, match_handle,
+				UINT_TO_PTR(cpu_to_le16(cmd->handle)));
+	if (conn) {
 		ev.status = BT_HCI_ERR_SUCCESS;
 		ev.handle = cpu_to_le16(cmd->handle);
-		ev.lmp_ver = dev->conn->version;
-		ev.manufacturer = cpu_to_le16(dev->conn->manufacturer);
-		ev.lmp_subver = cpu_to_le16(dev->conn->revision);
+		ev.lmp_ver = conn->link->dev->version;
+		ev.manufacturer = cpu_to_le16(conn->link->dev->manufacturer);
+		ev.lmp_subver = cpu_to_le16(conn->link->dev->revision);
 	} else {
 		ev.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
 		ev.handle = cpu_to_le16(cmd->handle);
@@ -860,27 +905,105 @@ static int cmd_create_conn(struct btdev *dev, const void *data, uint8_t len)
 	return 0;
 }
 
+static struct btdev_conn *conn_new(struct btdev *dev, uint16_t handle,
+							uint8_t type)
+{
+	struct btdev_conn *conn;
+
+	while ((conn = queue_find(dev->conns, match_handle,
+					UINT_TO_PTR(handle))))
+		handle++;
+
+	conn = new0(struct btdev_conn, 1);
+	conn->handle = handle;
+	conn->type = type;
+	conn->dev = dev;
+
+	if (!queue_push_tail(dev->conns, conn)) {
+		free(conn);
+		return NULL;
+	}
+
+	return conn;
+}
+
+static struct btdev_conn *conn_link(struct btdev *dev, struct btdev *remote,
+					uint16_t handle, uint8_t type)
+{
+	struct btdev_conn *conn1, *conn2;
+
+	conn1 = conn_new(dev, handle, type);
+	if (!conn1)
+		return NULL;
+
+	conn2 = conn_new(remote, handle, type);
+	if (!conn2) {
+		free(conn1);
+		return NULL;
+	}
+
+	conn1->link = conn2;
+	conn2->link = conn1;
+
+	util_debug(dev->debug_callback, dev->debug_data,
+				"conn1 %p handle 0x%04x conn2 %p handle 0x%04x",
+				conn1, conn1->handle, conn2, conn2->handle);
+
+	return conn1;
+}
+
+static struct btdev_conn *conn_add(struct btdev *dev,
+				const uint8_t *bdaddr, uint8_t bdaddr_type,
+				uint16_t handle, uint8_t type)
+{
+	struct btdev *remote;
+
+	remote = find_btdev_by_bdaddr_type(bdaddr, bdaddr_type);
+	if (!remote)
+		return NULL;
+
+	return conn_link(dev, remote, handle, type);
+}
+
+static struct btdev_conn *conn_add_acl(struct btdev *dev,
+				const uint8_t *bdaddr, uint8_t bdaddr_type)
+{
+	return conn_add(dev, bdaddr, bdaddr_type, ACL_HANDLE, HCI_ACLDATA_PKT);
+}
+
+static struct btdev_conn *conn_add_sco(struct btdev_conn *acl)
+{
+	return conn_link(acl->dev, acl->link->dev, SCO_HANDLE, HCI_SCODATA_PKT);
+}
+
+static struct btdev_conn *conn_add_iso(struct btdev_conn *acl, uint16_t handle)
+{
+	return conn_link(acl->dev, acl->link->dev, handle, HCI_ISODATA_PKT);
+}
+
 static void conn_complete(struct btdev *btdev,
 					const uint8_t *bdaddr, uint8_t status)
 {
 	struct bt_hci_evt_conn_complete cc;
 
 	if (!status) {
-		struct btdev *remote = find_btdev_by_bdaddr(bdaddr);
+		struct btdev_conn *conn;
 
-		btdev->conn = remote;
-		remote->conn = btdev;
+		conn = conn_add_acl(btdev, bdaddr, BDADDR_BREDR);
+		if (!conn)
+			return;
 
 		cc.status = status;
 		memcpy(cc.bdaddr, btdev->bdaddr, 6);
 		cc.encr_mode = 0x00;
 
-		cc.handle = cpu_to_le16(ACL_HANDLE);
+		cc.handle = cpu_to_le16(conn->link->handle);
 		cc.link_type = 0x01;
 
-		send_event(remote, BT_HCI_EVT_CONN_COMPLETE, &cc, sizeof(cc));
+		send_event(conn->link->dev, BT_HCI_EVT_CONN_COMPLETE, &cc,
+						sizeof(cc));
 
-		cc.handle = cpu_to_le16(ACL_HANDLE);
+		cc.handle = cpu_to_le16(conn->handle);
 		cc.link_type = 0x01;
 	} else {
 		cc.handle = cpu_to_le16(0x0000);
@@ -917,17 +1040,32 @@ static int cmd_create_conn_complete(struct btdev *dev, const void *data,
 
 static int cmd_add_sco_conn(struct btdev *dev, const void *data, uint8_t len)
 {
+	const struct bt_hci_cmd_add_sco_conn *cmd = data;
 	struct bt_hci_evt_conn_complete cc;
+	struct btdev_conn *conn;
 
-	if (!dev->conn)
-		return 0;
+	memset(&cc, 0, sizeof(cc));
+
+	conn = queue_find(dev->conns, match_handle,
+				UINT_TO_PTR(cpu_to_le16(cmd->handle)));
+	if (!conn) {
+		cc.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+		goto done;
+	}
+
+	conn = conn_add_sco(conn);
+	if (!conn) {
+		cc.status = BT_HCI_ERR_MEM_CAPACITY_EXCEEDED;
+		goto done;
+	}
 
 	cc.status = BT_HCI_ERR_SUCCESS;
-	memcpy(cc.bdaddr, dev->conn->bdaddr, 6);
-	cc.handle = cpu_to_le16(SCO_HANDLE);
+	memcpy(cc.bdaddr, conn->link->dev->bdaddr, 6);
+	cc.handle = cpu_to_le16(conn->handle);
 	cc.link_type = 0x00;
 	cc.encr_mode = 0x00;
 
+done:
 	send_event(dev, BT_HCI_EVT_CONN_COMPLETE, &cc, sizeof(cc));
 
 	return 0;
@@ -1004,35 +1142,57 @@ static int cmd_link_key_reply(struct btdev *dev, const void *data, uint8_t len)
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
+static void auth_complete(struct btdev_conn *conn, uint8_t status)
+{
+	struct bt_hci_evt_auth_complete ev;
+
+	memset(&ev, 0, sizeof(ev));
+
+	ev.handle = conn ? cpu_to_le16(conn->handle) : 0x0000;
+	ev.status = status;
+
+	send_event(conn->dev, BT_HCI_EVT_AUTH_COMPLETE, &ev, sizeof(ev));
+}
+
 static int cmd_link_key_reply_complete(struct btdev *dev, const void *data,
 						uint8_t len)
 {
 	const struct bt_hci_cmd_link_key_request_reply *cmd = data;
-	struct btdev *remote = dev->conn;
-	struct bt_hci_evt_auth_complete ev;
-
-	memcpy(dev->link_key, cmd->link_key, 16);
+	struct btdev_conn *conn;
+	uint8_t status;
 
-	if (!remote) {
-		remote = find_btdev_by_bdaddr(cmd->bdaddr);
-		if (!remote)
-			return 0;
+	conn = queue_find(dev->conns, match_bdaddr, cmd->bdaddr);
+	if (!conn) {
+		status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
 	}
 
-	if (!memcmp(remote->link_key, LINK_KEY_NONE, 16)) {
-		send_event(remote, BT_HCI_EVT_LINK_KEY_REQUEST, dev->bdaddr, 6);
+	memcpy(dev->link_key, cmd->link_key, 16);
+
+	if (!memcmp(conn->link->dev->link_key, LINK_KEY_NONE, 16)) {
+		send_event(conn->link->dev, BT_HCI_EVT_LINK_KEY_REQUEST,
+					dev->bdaddr, 6);
 		return 0;
 	}
 
-	ev.handle = cpu_to_le16(ACL_HANDLE);
-
-	if (!memcmp(dev->link_key, remote->link_key, 16))
-		ev.status = BT_HCI_ERR_SUCCESS;
+	if (!memcmp(dev->link_key, conn->link->dev->link_key, 16))
+		status = BT_HCI_ERR_SUCCESS;
 	else
-		ev.status = BT_HCI_ERR_AUTH_FAILURE;
+		status = BT_HCI_ERR_AUTH_FAILURE;
+
+done:
+	auth_complete(conn, status);
 
-	send_event(dev, BT_HCI_EVT_AUTH_COMPLETE, &ev, sizeof(ev));
-	send_event(remote, BT_HCI_EVT_AUTH_COMPLETE, &ev, sizeof(ev));
+	if (conn)
+		auth_complete(conn->link, status);
 
 	return 0;
 }
@@ -1063,13 +1223,11 @@ static int cmd_link_key_neg_reply_complete(struct btdev *dev, const void *data,
 							uint8_t len)
 {
 	const struct bt_hci_cmd_link_key_request_neg_reply *cmd = data;
-	struct btdev *remote = dev->conn;
+	struct btdev *remote;
 
-	if (!remote) {
-		remote = find_btdev_by_bdaddr(cmd->bdaddr);
-		if (!remote)
-			return 0;
-	}
+	remote = find_btdev_by_bdaddr(cmd->bdaddr);
+	if (!remote)
+		return 0;
 
 	if (use_ssp(dev, remote)) {
 		struct bt_hci_evt_io_capability_request io_req;
@@ -1100,21 +1258,23 @@ static int cmd_pin_code_reply(struct btdev *dev, const void *data, uint8_t len)
 	return 0;
 }
 
-static uint8_t get_link_key_type(struct btdev *btdev)
+static uint8_t get_link_key_type(struct btdev *btdev, const uint8_t *bdaddr)
 {
-	struct btdev *remote = btdev->conn;
+	struct btdev_conn *conn;
 	uint8_t auth, unauth;
 
-	if (!remote)
+	conn = queue_find(btdev->conns, match_bdaddr, bdaddr);
+	if (!conn)
 		return 0x00;
 
 	if (!btdev->simple_pairing_mode)
 		return 0x00;
 
-	if (btdev->ssp_debug_mode || remote->ssp_debug_mode)
+	if (btdev->ssp_debug_mode || conn->link->dev->ssp_debug_mode)
 		return 0x03;
 
-	if (btdev->secure_conn_support && remote->secure_conn_support) {
+	if (btdev->secure_conn_support &&
+			conn->link->dev->secure_conn_support) {
 		unauth = 0x07;
 		auth = 0x08;
 	} else {
@@ -1122,18 +1282,18 @@ static uint8_t get_link_key_type(struct btdev *btdev)
 		auth = 0x05;
 	}
 
-	if (btdev->io_cap == 0x03 || remote->io_cap == 0x03)
+	if (btdev->io_cap == 0x03 || conn->link->dev->io_cap == 0x03)
 		return unauth;
 
-	if (!(btdev->auth_req & 0x01) && !(remote->auth_req & 0x01))
+	if (!(btdev->auth_req & 0x01) && !(conn->link->dev->auth_req & 0x01))
 		return unauth;
 
 	/* DisplayOnly only produces authenticated with KeyboardOnly */
-	if (btdev->io_cap == 0x00 && remote->io_cap != 0x02)
+	if (btdev->io_cap == 0x00 && conn->link->dev->io_cap != 0x02)
 		return unauth;
 
 	/* DisplayOnly only produces authenticated with KeyboardOnly */
-	if (remote->io_cap == 0x00 && btdev->io_cap != 0x02)
+	if (conn->link->dev->io_cap == 0x00 && btdev->io_cap != 0x02)
 		return unauth;
 
 	return auth;
@@ -1148,7 +1308,7 @@ static void link_key_notify(struct btdev *btdev, const uint8_t *bdaddr,
 
 	memcpy(ev.bdaddr, bdaddr, 6);
 	memcpy(ev.link_key, key, 16);
-	ev.key_type = get_link_key_type(btdev);
+	ev.key_type = get_link_key_type(btdev, bdaddr);
 
 	send_event(btdev, BT_HCI_EVT_LINK_KEY_NOTIFY, &ev, sizeof(ev));
 }
@@ -1157,14 +1317,17 @@ static int cmd_pin_code_reply_complete(struct btdev *dev, const void *data,
 							uint8_t len)
 {
 	const struct bt_hci_cmd_pin_code_request_reply *cmd = data;
-	struct bt_hci_evt_auth_complete ev;
-	struct btdev *remote = dev->conn;
+	struct btdev *remote;
+	struct btdev_conn *conn;
+	uint8_t status;
 
-	if (!remote) {
+	conn = queue_find(dev->conns, match_bdaddr, cmd->bdaddr);
+	if (!conn) {
 		remote = find_btdev_by_bdaddr(cmd->bdaddr);
 		if (!remote)
 			return 0;
-	}
+	} else
+		remote = conn->link->dev;
 
 	memcpy(dev->pin, cmd->pin_code, cmd->pin_len);
 	dev->pin_len = cmd->pin_len;
@@ -1173,8 +1336,8 @@ static int cmd_pin_code_reply_complete(struct btdev *dev, const void *data,
 		struct bt_hci_evt_pin_code_request pin_req;
 
 		memcpy(pin_req.bdaddr, dev->bdaddr, 6);
-		send_event(remote, BT_HCI_EVT_PIN_CODE_REQUEST, &pin_req,
-							sizeof(pin_req));
+		send_event(remote, BT_HCI_EVT_PIN_CODE_REQUEST,
+					&pin_req, sizeof(pin_req));
 		return 0;
 	}
 
@@ -1182,17 +1345,15 @@ static int cmd_pin_code_reply_complete(struct btdev *dev, const void *data,
 			!memcmp(dev->pin, remote->pin, dev->pin_len)) {
 		link_key_notify(dev, remote->bdaddr, LINK_KEY_DUMMY);
 		link_key_notify(remote, dev->bdaddr, LINK_KEY_DUMMY);
-		ev.status = BT_HCI_ERR_SUCCESS;
+		status = BT_HCI_ERR_SUCCESS;
 	} else {
-		ev.status = BT_HCI_ERR_AUTH_FAILURE;
+		status = BT_HCI_ERR_AUTH_FAILURE;
 	}
 
-	if (remote->conn) {
-		ev.handle = cpu_to_le16(ACL_HANDLE);
-		send_event(remote, BT_HCI_EVT_AUTH_COMPLETE, &ev, sizeof(ev));
-	} else {
-		conn_complete(remote, dev->bdaddr, ev.status);
-	}
+	if (conn)
+		auth_complete(conn->link, status);
+	else
+		conn_complete(remote, dev->bdaddr, status);
 
 	dev->pin_len = 0;
 	remote->pin_len = 0;
@@ -1218,27 +1379,25 @@ static int cmd_pin_code_neg_reply_complete(struct btdev *dev, const void *data,
 							uint8_t len)
 {
 	const struct bt_hci_cmd_pin_code_request_neg_reply *cmd = data;
-	struct bt_hci_evt_auth_complete ev;
-	struct btdev *remote = dev->conn;
+	struct btdev *remote;
+	struct btdev_conn *conn;
+	uint8_t status;
 
-	if (!remote) {
-		remote = find_btdev_by_bdaddr(cmd->bdaddr);
-		if (!remote)
-			return 0;
-	}
+	remote = find_btdev_by_bdaddr(cmd->bdaddr);
+	if (!remote)
+		return 0;
 
-	ev.status = BT_HCI_ERR_PIN_OR_KEY_MISSING;
-	ev.handle = cpu_to_le16(ACL_HANDLE);
+	status = BT_HCI_ERR_PIN_OR_KEY_MISSING;
 
-	if (dev->conn)
-		send_event(dev, BT_HCI_EVT_AUTH_COMPLETE, &ev, sizeof(ev));
+	conn = queue_find(dev->conns, match_bdaddr, cmd->bdaddr);
+	if (conn)
+		auth_complete(conn, status);
 	else
 		conn_complete(dev, cmd->bdaddr, BT_HCI_ERR_PIN_OR_KEY_MISSING);
 
-	if (remote->conn) {
+	if (conn) {
 		if (remote->pin_len)
-			send_event(remote, BT_HCI_EVT_AUTH_COMPLETE, &ev,
-								sizeof(ev));
+			auth_complete(conn->link, status);
 	} else {
 		conn_complete(remote, dev->bdaddr,
 					BT_HCI_ERR_PIN_OR_KEY_MISSING);
@@ -1258,9 +1417,11 @@ static int cmd_auth_requested_complete(struct btdev *dev, const void *data,
 						uint8_t len)
 {
 	const struct bt_hci_cmd_auth_requested *cmd = data;
-	struct btdev *remote = dev->conn;
+	struct btdev_conn *conn;
 
-	if (!remote) {
+	conn = queue_find(dev->conns, match_handle,
+				UINT_TO_PTR(le16_to_cpu(cmd->handle)));
+	if (!conn) {
 		struct bt_hci_evt_auth_complete ev;
 
 		ev.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
@@ -1273,7 +1434,8 @@ static int cmd_auth_requested_complete(struct btdev *dev, const void *data,
 
 	dev->auth_init = true;
 
-	send_event(dev, BT_HCI_EVT_LINK_KEY_REQUEST, remote->bdaddr, 6);
+	send_event(dev, BT_HCI_EVT_LINK_KEY_REQUEST, conn->link->dev->bdaddr,
+					sizeof(conn->link->dev->bdaddr));
 
 	return 0;
 }
@@ -1286,35 +1448,45 @@ static int cmd_set_conn_encrypt(struct btdev *dev, const void *data,
 	return 0;
 }
 
-static void encrypt_change(struct btdev *btdev, uint8_t mode, uint8_t status)
+static void encrypt_change(struct btdev_conn *conn, uint8_t mode,
+					uint8_t status)
 {
 	struct bt_hci_evt_encrypt_change ev;
 
+	if (!conn)
+		return;
+
+	memset(&ev, 0, sizeof(ev));
+
 	ev.status = status;
-	ev.handle = cpu_to_le16(ACL_HANDLE);
+	ev.handle = cpu_to_le16(conn->handle);
 	ev.encr_mode = mode;
 
-	send_event(btdev, BT_HCI_EVT_ENCRYPT_CHANGE, &ev, sizeof(ev));
+	send_event(conn->dev, BT_HCI_EVT_ENCRYPT_CHANGE, &ev, sizeof(ev));
 }
 
 static int cmd_set_conn_encrypt_complete(struct btdev *dev, const void *data,
 							uint8_t len)
 {
 	const struct bt_hci_cmd_set_conn_encrypt *cmd = data;
+	struct btdev_conn *conn;
 	uint8_t mode;
 
-	if (!dev->conn)
+	conn = queue_find(dev->conns, match_handle,
+				UINT_TO_PTR(le16_to_cpu(cmd->handle)));
+	if (!conn)
 		return 0;
 
 	if (!cmd->encr_mode)
 		mode = 0x00;
-	else if (dev->secure_conn_support && dev->conn->secure_conn_support)
+	else if (dev->secure_conn_support &&
+				conn->link->dev->secure_conn_support)
 		mode = 0x02;
 	else
 		mode = 0x01;
 
-	encrypt_change(dev, mode, BT_HCI_ERR_SUCCESS);
-	encrypt_change(dev->conn, mode, BT_HCI_ERR_SUCCESS);
+	encrypt_change(conn, mode, BT_HCI_ERR_SUCCESS);
+	encrypt_change(conn->link, mode, BT_HCI_ERR_SUCCESS);
 
 	return 0;
 }
@@ -1396,11 +1568,14 @@ static int cmd_read_remote_features_complete(struct btdev *dev,
 {
 	const struct bt_hci_cmd_read_remote_features *cmd = data;
 	struct bt_hci_evt_remote_features_complete rfc;
+	struct btdev_conn *conn;
 
-	if (dev->conn) {
+	conn = queue_find(dev->conns, match_handle,
+				UINT_TO_PTR(le16_to_cpu(cmd->handle)));
+	if (conn) {
 		rfc.status = BT_HCI_ERR_SUCCESS;
 		rfc.handle = cpu_to_le16(cmd->handle);
-		memcpy(rfc.features, dev->conn->features, 8);
+		memcpy(rfc.features, conn->link->dev->features, 8);
 	} else {
 		rfc.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
 		rfc.handle = cpu_to_le16(cmd->handle);
@@ -1439,10 +1614,13 @@ static int cmd_read_remote_ext_features_compl(struct btdev *dev,
 {
 	const struct bt_hci_cmd_read_remote_ext_features *cmd = data;
 	struct bt_hci_evt_remote_ext_features_complete ev;
+	struct btdev_conn *conn;
 
 	memset(&ev, 0, sizeof(ev));
 
-	if (dev->conn && cmd->page < 0x02) {
+	conn = queue_find(dev->conns, match_handle,
+				UINT_TO_PTR(le16_to_cpu(cmd->handle)));
+	if (conn && cmd->page < 0x02) {
 		ev.handle = cpu_to_le16(cmd->handle);
 		ev.page = cmd->page;
 		ev.max_page = 0x01;
@@ -1450,11 +1628,11 @@ static int cmd_read_remote_ext_features_compl(struct btdev *dev,
 		switch (cmd->page) {
 		case 0x00:
 			ev.status = BT_HCI_ERR_SUCCESS;
-			memcpy(ev.features, dev->conn->features, 8);
+			memcpy(ev.features, conn->link->dev->features, 8);
 			break;
 		case 0x01:
 			ev.status = BT_HCI_ERR_SUCCESS;
-			btdev_get_host_features(dev->conn, ev.features);
+			btdev_get_host_features(conn->link->dev, ev.features);
 			break;
 		default:
 			ev.status = BT_HCI_ERR_INVALID_PARAMETERS;
@@ -1488,10 +1666,13 @@ static int cmd_read_clock_offset_complete(struct btdev *dev, const void *data,
 {
 	const struct bt_hci_cmd_read_clock_offset *cmd = data;
 	struct bt_hci_evt_clock_offset_complete ev;
+	struct btdev_conn *conn;
 
 	memset(&ev, 0, sizeof(ev));
 
-	if (dev->conn) {
+	conn = queue_find(dev->conns, match_handle,
+				UINT_TO_PTR(le16_to_cpu(cmd->handle)));
+	if (conn) {
 		ev.status = BT_HCI_ERR_SUCCESS;
 		ev.handle = cpu_to_le16(cmd->handle);
 		ev.clock_offset = 0;
@@ -2142,20 +2323,38 @@ static void set_common_commands_bredr20(struct btdev *btdev)
 }
 
 static int cmd_setup_sync_conn(struct btdev *dev, const void *data, uint8_t len)
+{
+	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_EVT_SYNC_CONN_COMPLETE);
+
+	return 0;
+}
+
+static int cmd_setup_sync_conn_complete(struct btdev *dev, const void *data,
+							uint8_t len)
 {
 	const struct bt_hci_cmd_setup_sync_conn *cmd = data;
 	struct bt_hci_evt_sync_conn_complete cc;
-	uint8_t status = BT_HCI_ERR_SUCCESS;
+	struct btdev_conn *conn;
 
-	cmd_status(dev, status, BT_HCI_EVT_SYNC_CONN_COMPLETE);
+	memset(&cc, 0, sizeof(cc));
 
-	if (!dev->conn)
-		return 0;
+	conn = queue_find(dev->conns, match_handle,
+				UINT_TO_PTR(le16_to_cpu(cmd->handle)));
+	if (!conn) {
+		cc.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+		goto done;
+	}
 
-	cc.status = status;
-	memcpy(cc.bdaddr, dev->conn->bdaddr, 6);
+	conn = conn_add_sco(conn);
+	if (!conn) {
+		cc.status = BT_HCI_ERR_MEM_CAPACITY_EXCEEDED;
+		goto done;
+	}
 
-	cc.handle = cpu_to_le16(status == BT_HCI_ERR_SUCCESS ? SCO_HANDLE : 0);
+	cc.status = BT_HCI_ERR_SUCCESS;
+	memcpy(cc.bdaddr, conn->link->dev->bdaddr, 6);
+
+	cc.handle = cpu_to_le16(conn->handle);
 	cc.link_type = 0x02;
 	cc.tx_interval = 0x000c;
 	cc.retrans_window = 0x06;
@@ -2163,6 +2362,7 @@ static int cmd_setup_sync_conn(struct btdev *dev, const void *data, uint8_t len)
 	cc.tx_pkt_len = 60;
 	cc.air_mode = (cmd->voice_setting == 0x0060) ? 0x02 : 0x03;
 
+done:
 	send_event(dev, BT_HCI_EVT_SYNC_CONN_COMPLETE, &cc, sizeof(cc));
 
 	return 0;
@@ -2255,13 +2455,14 @@ static int cmd_write_inquiry_tx_power(struct btdev *dev, const void *data,
 
 static int cmd_io_cap_reply(struct btdev *dev, const void *data, uint8_t len)
 {
-	struct btdev *remote = dev->conn;
 	const struct bt_hci_cmd_io_capability_request_reply *cmd = data;
 	struct bt_hci_evt_io_capability_response ev;
 	struct bt_hci_rsp_io_capability_request_reply rsp;
+	struct btdev_conn *conn;
 	uint8_t status;
 
-	if (!remote) {
+	conn = queue_find(dev->conns, match_bdaddr, cmd->bdaddr);
+	if (!conn) {
 		status = BT_HCI_ERR_UNKNOWN_CONN_ID;
 		goto done;
 	}
@@ -2276,22 +2477,23 @@ static int cmd_io_cap_reply(struct btdev *dev, const void *data, uint8_t len)
 	ev.oob_data = cmd->oob_data;
 	ev.authentication = cmd->authentication;
 
-	send_event(remote, BT_HCI_EVT_IO_CAPABILITY_RESPONSE, &ev, sizeof(ev));
+	send_event(conn->link->dev, BT_HCI_EVT_IO_CAPABILITY_RESPONSE, &ev,
+					sizeof(ev));
 
-	if (remote->io_cap) {
+	if (conn->link->dev->io_cap) {
 		struct bt_hci_evt_user_confirm_request cfm;
 
 		memcpy(cfm.bdaddr, dev->bdaddr, 6);
 		cfm.passkey = 0;
 
-		send_event(remote, BT_HCI_EVT_USER_CONFIRM_REQUEST,
+		send_event(conn->link->dev, BT_HCI_EVT_USER_CONFIRM_REQUEST,
 							&cfm, sizeof(cfm));
 
 		memcpy(cfm.bdaddr, cmd->bdaddr, 6);
 		send_event(dev, BT_HCI_EVT_USER_CONFIRM_REQUEST,
 							&cfm, sizeof(cfm));
 	} else {
-		send_event(remote, BT_HCI_EVT_IO_CAPABILITY_REQUEST,
+		send_event(conn->link->dev, BT_HCI_EVT_IO_CAPABILITY_REQUEST,
 							dev->bdaddr, 6);
 	}
 
@@ -2308,51 +2510,49 @@ static void ssp_complete(struct btdev *btdev, const uint8_t *bdaddr,
 						uint8_t status, bool wait)
 {
 	struct bt_hci_evt_simple_pairing_complete iev, aev;
-	struct bt_hci_evt_auth_complete auth;
-	struct btdev *remote = btdev->conn;
-	struct btdev *init, *accp;
+	struct btdev_conn *conn;
+	struct btdev_conn *init, *accp;
 
-	if (!remote)
+	conn = queue_find(btdev->conns, match_bdaddr, bdaddr);
+	if (!conn)
 		return;
 
 	btdev->ssp_status = status;
 	btdev->ssp_auth_complete = true;
 
-	if (!remote->ssp_auth_complete && wait)
+	if (!conn->link->dev->ssp_auth_complete && wait)
 		return;
 
 	if (status == BT_HCI_ERR_SUCCESS &&
-				remote->ssp_status != BT_HCI_ERR_SUCCESS)
-		status = remote->ssp_status;
+			conn->link->dev->ssp_status != BT_HCI_ERR_SUCCESS)
+		status = conn->link->dev->ssp_status;
 
 	iev.status = status;
 	aev.status = status;
 
 	if (btdev->auth_init) {
-		init = btdev;
-		accp = remote;
+		init = conn;
+		accp = conn->link;
 		memcpy(iev.bdaddr, bdaddr, 6);
 		memcpy(aev.bdaddr, btdev->bdaddr, 6);
 	} else {
-		init = remote;
-		accp = btdev;
+		init = conn->link;
+		accp = conn;
 		memcpy(iev.bdaddr, btdev->bdaddr, 6);
 		memcpy(aev.bdaddr, bdaddr, 6);
 	}
 
-	send_event(init, BT_HCI_EVT_SIMPLE_PAIRING_COMPLETE, &iev,
-								sizeof(iev));
-	send_event(accp, BT_HCI_EVT_SIMPLE_PAIRING_COMPLETE, &aev,
-								sizeof(aev));
+	send_event(init->dev, BT_HCI_EVT_SIMPLE_PAIRING_COMPLETE, &iev,
+							sizeof(iev));
+	send_event(accp->dev, BT_HCI_EVT_SIMPLE_PAIRING_COMPLETE, &aev,
+							sizeof(aev));
 
 	if (status == BT_HCI_ERR_SUCCESS) {
-		link_key_notify(init, iev.bdaddr, LINK_KEY_DUMMY);
-		link_key_notify(accp, aev.bdaddr, LINK_KEY_DUMMY);
+		link_key_notify(init->dev, iev.bdaddr, LINK_KEY_DUMMY);
+		link_key_notify(accp->dev, aev.bdaddr, LINK_KEY_DUMMY);
 	}
 
-	auth.status = status;
-	auth.handle = cpu_to_le16(ACL_HANDLE);
-	send_event(init, BT_HCI_EVT_AUTH_COMPLETE, &auth, sizeof(auth));
+	auth_complete(init, status);
 }
 
 static int cmd_user_confirm_reply(struct btdev *dev, const void *data,
@@ -2419,10 +2619,15 @@ static int cmd_read_encrypt_key_size(struct btdev *dev, const void *data,
 {
 	const struct bt_hci_cmd_read_encrypt_key_size *cmd = data;
 	struct bt_hci_rsp_read_encrypt_key_size rsp;
+	struct btdev_conn *conn;
+
+	memset(&rsp, 0, sizeof(rsp));
 
 	rsp.handle = cmd->handle;
 
-	if (dev->conn) {
+	conn = queue_find(dev->conns, match_handle,
+					UINT_TO_PTR(le16_to_cpu(cmd->handle)));
+	if (conn) {
 		rsp.status = BT_HCI_ERR_SUCCESS;
 		rsp.key_size = 16;
 	} else {
@@ -2485,7 +2690,8 @@ static int cmd_get_mws_transport_config(struct btdev *dev, const void *data,
 }
 
 #define CMD_BREDR \
-	CMD(BT_HCI_CMD_SETUP_SYNC_CONN, cmd_setup_sync_conn, NULL), \
+	CMD(BT_HCI_CMD_SETUP_SYNC_CONN, cmd_setup_sync_conn, \
+					cmd_setup_sync_conn_complete), \
 	CMD(BT_HCI_CMD_READ_EXT_INQUIRY_RESPONSE, cmd_read_ext_inquiry, NULL), \
 	CMD(BT_HCI_CMD_WRITE_EXT_INQUIRY_RESPONSE, cmd_write_ext_inquiry, \
 					NULL), \
@@ -2986,50 +3192,67 @@ static bool adv_connectable(struct btdev *btdev)
 	return btdev->le_adv_type != 0x03;
 }
 
+static void le_meta_event(struct btdev *btdev, uint8_t event,
+						void *data, uint8_t len)
+{
+	void *pkt_data;
+
+	util_debug(btdev->debug_callback, btdev->debug_data,
+				"meta event 0x%02x", event);
+
+	pkt_data = alloca(1 + len);
+	if (!pkt_data)
+		return;
+
+	((uint8_t *) pkt_data)[0] = event;
+
+	if (len > 0)
+		memcpy(pkt_data + 1, data, len);
+
+	send_event(btdev, BT_HCI_EVT_LE_META_EVENT, pkt_data, 1 + len);
+}
+
 static void le_conn_complete(struct btdev *btdev,
 				const struct bt_hci_cmd_le_create_conn *lecc,
 				uint8_t status)
 {
-	char buf[1 + sizeof(struct bt_hci_evt_le_conn_complete)];
-	struct bt_hci_evt_le_conn_complete *cc = (void *) &buf[1];
+	struct bt_hci_evt_le_conn_complete cc;
 
-	memset(buf, 0, sizeof(buf));
-
-	buf[0] = BT_HCI_EVT_LE_CONN_COMPLETE;
+	memset(&cc, 0, sizeof(cc));
 
 	if (!status) {
-		struct btdev *remote;
+		struct btdev_conn *conn;
 
-		remote = find_btdev_by_bdaddr_type(lecc->peer_addr,
-							lecc->peer_addr_type);
+		conn = conn_add_acl(btdev, lecc->peer_addr,
+						lecc->peer_addr_type);
+		if (!conn)
+			return;
 
-		btdev->conn = remote;
 		btdev->le_adv_enable = 0;
-		remote->conn = btdev;
-		remote->le_adv_enable = 0;
+		conn->link->dev->le_adv_enable = 0;
 
-		cc->status = status;
-		cc->peer_addr_type = btdev->le_scan_own_addr_type;
-		if (cc->peer_addr_type == 0x01)
-			memcpy(cc->peer_addr, btdev->random_addr, 6);
+		cc.status = status;
+		cc.peer_addr_type = btdev->le_scan_own_addr_type;
+		if (cc.peer_addr_type == 0x01)
+			memcpy(cc.peer_addr, btdev->random_addr, 6);
 		else
-			memcpy(cc->peer_addr, btdev->bdaddr, 6);
-
-		cc->role = 0x01;
-		cc->handle = cpu_to_le16(ACL_HANDLE);
-		cc->interval = lecc->max_interval;
-		cc->latency = lecc->latency;
-		cc->supv_timeout = lecc->supv_timeout;
-
-		send_event(remote, BT_HCI_EVT_LE_META_EVENT, buf, sizeof(buf));
+			memcpy(cc.peer_addr, btdev->bdaddr, 6);
+
+		cc.role = 0x01;
+		cc.handle = cpu_to_le16(conn->handle);
+		cc.interval = lecc->max_interval;
+		cc.latency = lecc->latency;
+		cc.supv_timeout = lecc->supv_timeout;
+		le_meta_event(conn->link->dev, BT_HCI_EVT_LE_CONN_COMPLETE,
+					&cc, sizeof(cc));
 	}
 
-	cc->status = status;
-	cc->peer_addr_type = lecc->peer_addr_type;
-	memcpy(cc->peer_addr, lecc->peer_addr, 6);
-	cc->role = 0x00;
+	cc.status = status;
+	cc.peer_addr_type = lecc->peer_addr_type;
+	memcpy(cc.peer_addr, lecc->peer_addr, 6);
+	cc.role = 0x00;
 
-	send_event(btdev, BT_HCI_EVT_LE_META_EVENT, buf, sizeof(buf));
+	le_meta_event(btdev, BT_HCI_EVT_LE_CONN_COMPLETE, &cc, sizeof(cc));
 }
 
 static int cmd_le_create_conn(struct btdev *dev, const void *data, uint8_t len)
@@ -3092,27 +3315,29 @@ static void le_conn_update(struct btdev *btdev, uint16_t handle,
 				uint16_t latency, uint16_t supv_timeout,
 				uint16_t min_length, uint16_t max_length)
 {
-	struct btdev *remote = btdev->conn;
-	struct __packed {
-		uint8_t subevent;
-		struct bt_hci_evt_le_conn_update_complete ev;
-	} ev;
+	struct bt_hci_evt_le_conn_update_complete ev;
+	struct btdev_conn *conn;
+
+	memset(&ev, 0, sizeof(ev));
 
-	ev.subevent = BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE;
-	ev.ev.handle = cpu_to_le16(handle);
-	ev.ev.interval = cpu_to_le16(min_interval);
-	ev.ev.latency = cpu_to_le16(latency);
-	ev.ev.supv_timeout = cpu_to_le16(supv_timeout);
+	ev.handle = cpu_to_le16(handle);
+	ev.interval = cpu_to_le16(min_interval);
+	ev.latency = cpu_to_le16(latency);
+	ev.supv_timeout = cpu_to_le16(supv_timeout);
 
-	if (remote)
-		ev.ev.status = BT_HCI_ERR_SUCCESS;
+	conn = queue_find(btdev->conns, match_handle, UINT_TO_PTR(handle));
+	if (conn)
+		ev.status = BT_HCI_ERR_SUCCESS;
 	else
-		ev.ev.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+		ev.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
 
-	send_event(btdev, BT_HCI_EVT_LE_META_EVENT, &ev, sizeof(ev));
+	le_meta_event(btdev, BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE, &ev,
+					sizeof(ev));
 
-	if (remote)
-		send_event(remote, BT_HCI_EVT_LE_META_EVENT, &ev, sizeof(ev));
+	if (conn)
+		le_meta_event(conn->link->dev,
+					BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE,
+					&ev, sizeof(ev));
 }
 
 static void le_conn_param_req(struct btdev *btdev, uint16_t handle,
@@ -3120,23 +3345,23 @@ static void le_conn_param_req(struct btdev *btdev, uint16_t handle,
 				uint16_t latency, uint16_t supv_timeout,
 				uint16_t min_length, uint16_t max_length)
 {
-	struct btdev *remote = btdev->conn;
-	struct __packed {
-		uint8_t subevent;
-		struct bt_hci_evt_le_conn_param_request ev;
-	} ev;
+	struct bt_hci_evt_le_conn_param_request ev;
+	struct btdev_conn *conn;
 
-	if (!remote)
+	conn = queue_find(btdev->conns, match_handle, UINT_TO_PTR(handle));
+	if (!conn)
 		return;
 
-	ev.subevent = BT_HCI_EVT_LE_CONN_PARAM_REQUEST;
-	ev.ev.handle = cpu_to_le16(handle);
-	ev.ev.min_interval = cpu_to_le16(min_interval);
-	ev.ev.max_interval = cpu_to_le16(max_interval);
-	ev.ev.latency = cpu_to_le16(latency);
-	ev.ev.supv_timeout = cpu_to_le16(supv_timeout);
+	memset(&ev, 0, sizeof(ev));
+
+	ev.handle = cpu_to_le16(handle);
+	ev.min_interval = cpu_to_le16(min_interval);
+	ev.max_interval = cpu_to_le16(max_interval);
+	ev.latency = cpu_to_le16(latency);
+	ev.supv_timeout = cpu_to_le16(supv_timeout);
 
-	send_event(remote, BT_HCI_EVT_LE_META_EVENT, &ev, sizeof(ev));
+	le_meta_event(conn->link->dev, BT_HCI_EVT_LE_CONN_PARAM_REQUEST, &ev,
+					sizeof(ev));
 }
 
 static int cmd_conn_update_complete(struct btdev *dev, const void *data,
@@ -3164,44 +3389,28 @@ static int cmd_conn_update_complete(struct btdev *dev, const void *data,
 	return 0;
 }
 
-static void le_meta_event(struct btdev *btdev, uint8_t event,
-						void *data, uint8_t len)
-{
-	void *pkt_data;
-
-	util_debug(btdev->debug_callback, btdev->debug_data,
-				"meta event 0x%02x", event);
-
-	pkt_data = alloca(1 + len);
-	if (!pkt_data)
-		return;
-
-	((uint8_t *) pkt_data)[0] = event;
-
-	if (len > 0)
-		memcpy(pkt_data + 1, data, len);
-
-	send_event(btdev, BT_HCI_EVT_LE_META_EVENT, pkt_data, 1 + len);
-}
-
 static int cmd_le_read_remote_features(struct btdev *dev, const void *data,
 							uint8_t len)
 {
+	const struct bt_hci_cmd_read_remote_features *cmd = data;
 	struct bt_hci_evt_le_remote_features_complete ev;
-	struct btdev *remote = dev->conn;
+	struct btdev_conn *conn;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
 
-	if (!remote) {
-		cmd_status(dev, BT_HCI_ERR_UNKNOWN_CONN_ID,
-					BT_HCI_CMD_LE_READ_REMOTE_FEATURES);
-		return 0;
-	}
+	conn = queue_find(dev->conns, match_handle,
+				UINT_TO_PTR(le16_to_cpu(cmd->handle)));
+	if (!conn)
+		status = BT_HCI_ERR_UNKNOWN_CONN_ID;
 
-	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_LE_READ_REMOTE_FEATURES);
+	cmd_status(dev, status, BT_HCI_CMD_LE_READ_REMOTE_FEATURES);
+
+	if (status)
+		return 0;
 
 	memset(&ev, 0, sizeof(ev));
 	ev.status = BT_HCI_ERR_SUCCESS;
-	ev.handle = cpu_to_le16(ACL_HANDLE);
-	memcpy(ev.features, remote->le_features, 8);
+	ev.handle = cpu_to_le16(conn->handle);
+	memcpy(ev.features, conn->link->dev->le_features, 8);
 
 	le_meta_event(dev, BT_HCI_EVT_LE_REMOTE_FEATURES_COMPLETE, &ev,
 						sizeof(ev));
@@ -3246,27 +3455,27 @@ static int cmd_rand(struct btdev *dev, const void *data, uint8_t len)
 static int cmd_start_encrypt(struct btdev *dev, const void *data, uint8_t len)
 {
 	const struct bt_hci_cmd_le_start_encrypt *cmd = data;
-	char buf[1 + sizeof(struct bt_hci_evt_le_long_term_key_request)];
-	struct bt_hci_evt_le_long_term_key_request *ev = (void *) &buf[1];
-	struct btdev *remote = dev->conn;
+	struct bt_hci_evt_le_long_term_key_request ev;
+	struct btdev_conn *conn;
 
-	if (!remote) {
+	conn = queue_find(dev->conns, match_handle,
+				UINT_TO_PTR(le16_to_cpu(cmd->handle)));
+	if (!conn) {
 		cmd_status(dev, BT_HCI_ERR_UNKNOWN_CONN_ID,
-						BT_HCI_CMD_LE_START_ENCRYPT);
+				BT_HCI_CMD_LE_START_ENCRYPT);
 		return 0;
 	}
 
-	memcpy(dev->le_ltk, cmd->ltk, 16);
-
 	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_LE_START_ENCRYPT);
 
-	memset(buf, 0, sizeof(buf));
-	buf[0] = BT_HCI_EVT_LE_LONG_TERM_KEY_REQUEST;
-	ev->handle = cpu_to_le16(ACL_HANDLE);
-	ev->ediv = cmd->ediv;
-	ev->rand = cmd->rand;
+	memcpy(dev->le_ltk, cmd->ltk, 16);
+
+	ev.handle = cpu_to_le16(conn->handle);
+	ev.ediv = cmd->ediv;
+	ev.rand = cmd->rand;
 
-	send_event(remote, BT_HCI_EVT_LE_META_EVENT, buf, sizeof(buf));
+	le_meta_event(conn->link->dev, BT_HCI_EVT_LE_LONG_TERM_KEY_REQUEST, &ev,
+					sizeof(ev));
 
 	return 0;
 }
@@ -3274,11 +3483,13 @@ static int cmd_start_encrypt(struct btdev *dev, const void *data, uint8_t len)
 static int cmd_ltk_reply(struct btdev *dev, const void *data, uint8_t len)
 {
 	const struct bt_hci_cmd_le_ltk_req_reply *cmd = data;
-	struct bt_hci_evt_encrypt_change ev;
 	struct bt_hci_rsp_le_ltk_req_reply rp;
-	struct btdev *remote = dev->conn;
+	struct btdev_conn *conn;
+	uint8_t mode, status;
 
-	if (!remote) {
+	conn = queue_find(dev->conns, match_handle,
+				UINT_TO_PTR(le16_to_cpu(cmd->handle)));
+	if (!conn) {
 		rp.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
 		cmd_complete(dev, BT_HCI_CMD_LE_LTK_REQ_REPLY, &rp, sizeof(rp));
 		return 0;
@@ -3287,36 +3498,34 @@ static int cmd_ltk_reply(struct btdev *dev, const void *data, uint8_t len)
 	memcpy(dev->le_ltk, cmd->ltk, 16);
 
 	memset(&rp, 0, sizeof(rp));
-	rp.handle = cpu_to_le16(ACL_HANDLE);
+	rp.handle = cpu_to_le16(conn->handle);
 
 	rp.status = BT_HCI_ERR_SUCCESS;
 	cmd_complete(dev, BT_HCI_CMD_LE_LTK_REQ_REPLY, &rp, sizeof(rp));
 
-	memset(&ev, 0, sizeof(ev));
-
-	if (memcmp(dev->le_ltk, remote->le_ltk, 16)) {
-		ev.status = BT_HCI_ERR_AUTH_FAILURE;
-		ev.encr_mode = 0x00;
+	if (memcmp(dev->le_ltk, conn->link->dev->le_ltk, 16)) {
+		status = BT_HCI_ERR_AUTH_FAILURE;
+		mode = 0x00;
 	} else {
-		ev.status = BT_HCI_ERR_SUCCESS;
-		ev.encr_mode = 0x01;
+		status = BT_HCI_ERR_SUCCESS;
+		mode = 0x01;
 	}
 
-	ev.handle = cpu_to_le16(ACL_HANDLE);
-
-	send_event(dev, BT_HCI_EVT_ENCRYPT_CHANGE, &ev, sizeof(ev));
-	send_event(remote, BT_HCI_EVT_ENCRYPT_CHANGE, &ev, sizeof(ev));
+	encrypt_change(conn, mode, status);
+	encrypt_change(conn->link, mode, status);
 
 	return 0;
 }
 
 static int cmd_ltk_neg_reply(struct btdev *dev, const void *data, uint8_t len)
 {
+	const struct bt_hci_cmd_le_ltk_req_neg_reply *cmd = data;
 	struct bt_hci_rsp_le_ltk_req_neg_reply rp;
-	struct bt_hci_evt_encrypt_change ev;
-	struct btdev *remote = dev->conn;
+	struct btdev_conn *conn;
 
-	if (!remote) {
+	conn = queue_find(dev->conns, match_handle,
+				UINT_TO_PTR(le16_to_cpu(cmd->handle)));
+	if (!conn) {
 		rp.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
 		cmd_complete(dev, BT_HCI_CMD_LE_LTK_REQ_NEG_REPLY, &rp,
 							sizeof(rp));
@@ -3324,15 +3533,11 @@ static int cmd_ltk_neg_reply(struct btdev *dev, const void *data, uint8_t len)
 	}
 
 	memset(&rp, 0, sizeof(rp));
-	rp.handle = cpu_to_le16(ACL_HANDLE);
+	rp.handle = cpu_to_le16(conn->handle);
 	rp.status = BT_HCI_ERR_SUCCESS;
 	cmd_complete(dev, BT_HCI_CMD_LE_LTK_REQ_NEG_REPLY, &rp, sizeof(rp));
 
-	memset(&ev, 0, sizeof(ev));
-	ev.status = BT_HCI_ERR_PIN_OR_KEY_MISSING;
-	ev.handle = cpu_to_le16(ACL_HANDLE);
-
-	send_event(remote, BT_HCI_EVT_ENCRYPT_CHANGE, &ev, sizeof(ev));
+	encrypt_change(conn->link, 0x00, BT_HCI_ERR_PIN_OR_KEY_MISSING);
 
 	return 0;
 }
@@ -3413,10 +3618,12 @@ static int cmd_conn_param_neg_reply_complete(struct btdev *dev,
 						const void *data, uint8_t len)
 {
 	const struct bt_hci_cmd_le_conn_param_req_neg_reply *cmd = data;
-	struct btdev *remote = dev->conn;
+	struct btdev_conn *conn;
 	struct bt_hci_evt_le_conn_update_complete ev;
 
-	if (!remote)
+	conn = queue_find(dev->conns, match_handle,
+				UINT_TO_PTR(le16_to_cpu(cmd->handle)));
+	if (!conn)
 		return 0;
 
 	memset(&ev, 0, sizeof(ev));
@@ -3424,7 +3631,7 @@ static int cmd_conn_param_neg_reply_complete(struct btdev *dev,
 	ev.handle = cpu_to_le16(cmd->handle);
 	ev.status = cpu_to_le16(cmd->reason);
 
-	le_meta_event(remote, BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE, &ev,
+	le_meta_event(conn->link->dev, BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE, &ev,
 						sizeof(ev));
 
 	return 0;
@@ -3861,15 +4068,14 @@ static void le_ext_conn_complete(struct btdev *btdev,
 	memset(&ev, 0, sizeof(ev));
 
 	if (!status) {
-		struct btdev *remote;
+		struct btdev_conn *conn;
 
-		remote = find_btdev_by_bdaddr_type(cmd->peer_addr,
-							cmd->peer_addr_type);
+		conn = conn_add_acl(btdev, cmd->peer_addr, cmd->peer_addr_type);
+		if (!conn)
+			return;
 
-		btdev->conn = remote;
 		btdev->le_adv_enable = 0;
-		remote->conn = btdev;
-		remote->le_adv_enable = 0;
+		conn->link->dev->le_adv_enable = 0;
 
 		ev.status = status;
 		ev.peer_addr_type = btdev->le_scan_own_addr_type;
@@ -3879,13 +4085,14 @@ static void le_ext_conn_complete(struct btdev *btdev,
 			memcpy(ev.peer_addr, btdev->bdaddr, 6);
 
 		ev.role = 0x01;
-		ev.handle = cpu_to_le16(ACL_HANDLE);
+		ev.handle = cpu_to_le16(conn->handle);
 		ev.interval = lecc->max_interval;
 		ev.latency = lecc->latency;
 		ev.supv_timeout = lecc->supv_timeout;
 
-		le_meta_event(remote, BT_HCI_EVT_LE_ENHANCED_CONN_COMPLETE, &ev,
-						sizeof(ev));
+		le_meta_event(conn->link->dev,
+				BT_HCI_EVT_LE_ENHANCED_CONN_COMPLETE, &ev,
+				sizeof(ev));
 	}
 
 	ev.status = status;
@@ -4066,17 +4273,30 @@ static int cmd_set_cig_params(struct btdev *dev, const void *data,
 	const struct bt_hci_cmd_le_set_cig_params *cmd = data;
 	struct lescp {
 		struct bt_hci_rsp_le_set_cig_params params;
-		uint16_t handle;
+		uint16_t handle[3];
 	} __attribute__ ((packed)) rsp;
+	int i = 0;
 
 	memset(&rsp, 0, sizeof(rsp));
 
 	memcpy(&dev->le_cig, data, len);
+
+	if (cmd->num_cis > ARRAY_SIZE(rsp.handle)) {
+		rsp.params.status = BT_HCI_ERR_MEM_CAPACITY_EXCEEDED;
+		goto done;
+	}
+
 	rsp.params.status = BT_HCI_ERR_SUCCESS;
 	rsp.params.cig_id = cmd->cig_id;
-	rsp.params.num_handles = 1;
-	rsp.handle = cpu_to_le16(ISO_HANDLE);
-	cmd_complete(dev, BT_HCI_CMD_LE_SET_CIG_PARAMS, &rsp, sizeof(rsp));
+
+	for (i = 0; i < cmd->num_cis; i++) {
+		rsp.params.num_handles++;
+		rsp.handle[i] = cpu_to_le16(ISO_HANDLE + i);
+	}
+
+done:
+	cmd_complete(dev, BT_HCI_CMD_LE_SET_CIG_PARAMS, &rsp,
+				sizeof(rsp.params) + (i * sizeof(uint16_t)));
 
 	return 0;
 }
@@ -4095,7 +4315,8 @@ static int cmd_create_cis(struct btdev *dev, const void *data, uint8_t len)
 	return 0;
 }
 
-static void le_cis_estabilished(struct btdev *dev, uint8_t status)
+static void le_cis_estabilished(struct btdev *dev, struct btdev_conn *conn,
+						uint8_t status)
 {
 	struct bt_hci_evt_le_cis_established evt;
 
@@ -4103,11 +4324,8 @@ static void le_cis_estabilished(struct btdev *dev, uint8_t status)
 
 	evt.status = status;
 
-	if (dev->conn)
-		dev = dev->conn;
-
 	if (!evt.status) {
-		evt.conn_handle = cpu_to_le16(ISO_HANDLE);
+		evt.conn_handle = cpu_to_le16(conn->handle);
 		/* TODO: Figure out if these values makes sense */
 		memcpy(evt.cig_sync_delay, dev->le_cig.params.m_interval,
 				sizeof(dev->le_cig.params.m_interval));
@@ -4131,27 +4349,49 @@ static void le_cis_estabilished(struct btdev *dev, uint8_t status)
 
 	le_meta_event(dev, BT_HCI_EVT_LE_CIS_ESTABLISHED, &evt, sizeof(evt));
 
-	if (dev->conn)
-		le_meta_event(dev->conn, BT_HCI_EVT_LE_CIS_ESTABLISHED, &evt,
-							sizeof(evt));
+	if (conn)
+		le_meta_event(conn->link->dev, BT_HCI_EVT_LE_CIS_ESTABLISHED,
+						&evt, sizeof(evt));
 }
 
 static int cmd_create_cis_complete(struct btdev *dev, const void *data,
 							uint8_t len)
 {
-	struct btdev *remote = dev->conn;
+	const struct bt_hci_cmd_le_create_cis *cmd = data;
+	int i;
 
-	if (remote) {
+	for (i = 0; i < cmd->num_cis; i++) {
+		const struct bt_hci_cis *cis = &cmd->cis[i];
+		struct btdev_conn *acl;
+		struct btdev_conn *iso;
 		struct bt_hci_evt_le_cis_req evt;
 
-		evt.acl_handle = cpu_to_le16(ACL_HANDLE);
-		evt.cis_handle = cpu_to_le16(ISO_HANDLE);
+		acl = queue_find(dev->conns, match_handle,
+				UINT_TO_PTR(cpu_to_le16(cis->acl_handle)));
+		if (!acl) {
+			le_cis_estabilished(dev, NULL,
+						BT_HCI_ERR_UNKNOWN_CONN_ID);
+			break;
+		}
+
+		iso = queue_find(dev->conns, match_handle,
+				UINT_TO_PTR(cpu_to_le16(cis->cis_handle)));
+		if (!iso) {
+			iso = conn_add_iso(acl, cpu_to_le16(cis->cis_handle));
+			if (!iso) {
+				le_cis_estabilished(dev, NULL,
+						BT_HCI_ERR_UNKNOWN_CONN_ID);
+				break;
+			}
+		}
+
+		evt.acl_handle = cpu_to_le16(acl->handle);
+		evt.cis_handle = cpu_to_le16(iso->handle);
 		evt.cig_id = 0x00;
 		evt.cis_id = 0x00;
 
-		le_meta_event(remote, BT_HCI_EVT_LE_CIS_REQ, &evt, sizeof(evt));
-	} else {
-		le_cis_estabilished(dev, BT_HCI_ERR_UNKNOWN_CONN_ID);
+		le_meta_event(iso->dev, BT_HCI_EVT_LE_CIS_REQ, &evt,
+					sizeof(evt));
 	}
 
 	return 0;
@@ -4173,8 +4413,19 @@ static int cmd_remove_cig(struct btdev *dev, const void *data, uint8_t len)
 
 static int cmd_accept_cis(struct btdev *dev, const void *data, uint8_t len)
 {
+	const struct bt_hci_cmd_le_accept_cis *cmd = data;
+	struct btdev_conn *conn;
+
+	conn = queue_find(dev->conns, match_handle,
+				UINT_TO_PTR(cpu_to_le16(cmd->handle)));
+	if (!conn) {
+		cmd_status(dev, BT_HCI_ERR_UNKNOWN_CONN_ID,
+					BT_HCI_CMD_LE_ACCEPT_CIS);
+		return 0;
+	}
+
 	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_LE_ACCEPT_CIS);
-	le_cis_estabilished(dev, BT_HCI_ERR_SUCCESS);
+	le_cis_estabilished(dev, conn, BT_HCI_ERR_SUCCESS);
 
 	return 0;
 }
@@ -4182,9 +4433,18 @@ static int cmd_accept_cis(struct btdev *dev, const void *data, uint8_t len)
 static int cmd_reject_cis(struct btdev *dev, const void *data, uint8_t len)
 {
 	const struct bt_hci_cmd_le_reject_cis *cmd = data;
+	struct btdev_conn *conn;
 
-	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_LE_ACCEPT_CIS);
-	le_cis_estabilished(dev, cmd->reason);
+	conn = queue_find(dev->conns, match_handle,
+				UINT_TO_PTR(cpu_to_le16(cmd->handle)));
+	if (!conn) {
+		cmd_status(dev, BT_HCI_ERR_UNKNOWN_CONN_ID,
+					BT_HCI_CMD_LE_REJECT_CIS);
+		return 0;
+	}
+
+	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_LE_REJECT_CIS);
+	le_cis_estabilished(dev, conn, cmd->reason);
 
 	return 0;
 }
@@ -4229,10 +4489,13 @@ static int cmd_setup_iso_path(struct btdev *dev, const void *data, uint8_t len)
 {
 	const struct bt_hci_cmd_le_setup_iso_path *cmd = data;
 	struct bt_hci_rsp_le_setup_iso_path rsp;
+	struct btdev_conn *conn;
 
 	memset(&rsp, 0, sizeof(rsp));
 
-	if (le16_to_cpu(cmd->handle) != ISO_HANDLE) {
+	conn = queue_find(dev->conns, match_handle,
+				UINT_TO_PTR(cpu_to_le16(cmd->handle)));
+	if (!conn) {
 		rsp.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
 		goto done;
 	}
@@ -4246,11 +4509,11 @@ static int cmd_setup_iso_path(struct btdev *dev, const void *data, uint8_t len)
 	switch (cmd->direction) {
 	case 0x00:
 		dev->le_iso_path[0] = cmd->path;
-		rsp.handle = cpu_to_le16(ISO_HANDLE);
+		rsp.handle = cpu_to_le16(conn->handle);
 		break;
 	case 0x01:
 		dev->le_iso_path[1] = cmd->path;
-		rsp.handle = cpu_to_le16(ISO_HANDLE);
+		rsp.handle = cpu_to_le16(conn->handle);
 		break;
 	default:
 		rsp.status = BT_HCI_ERR_INVALID_PARAMETERS;
@@ -4266,9 +4529,14 @@ static int cmd_remove_iso_path(struct btdev *dev, const void *data, uint8_t len)
 {
 	const struct bt_hci_cmd_le_remove_iso_path *cmd = data;
 	uint8_t status = BT_HCI_ERR_SUCCESS;
+	struct btdev_conn *conn;
 
-	if (!dev->conn || le16_to_cpu(cmd->handle) != ISO_HANDLE)
+	conn = queue_find(dev->conns, match_handle,
+				UINT_TO_PTR(cpu_to_le16(cmd->handle)));
+	if (!conn) {
 		status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+		goto done;
+	}
 
 	switch (cmd->direction) {
 	case 0x00:
@@ -4281,6 +4549,7 @@ static int cmd_remove_iso_path(struct btdev *dev, const void *data, uint8_t len)
 		status = BT_HCI_ERR_INVALID_PARAMETERS;
 	}
 
+done:
 	cmd_complete(dev, BT_HCI_CMD_LE_REMOVE_ISO_PATH, &status,
 							sizeof(status));
 
@@ -4797,6 +5066,8 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 
 	get_bdaddr(id, index, btdev->bdaddr);
 
+	btdev->conns = queue_new();
+
 	return btdev;
 }
 
@@ -4878,7 +5149,10 @@ void btdev_set_send_handler(struct btdev *btdev, btdev_send_func handler,
 
 static void num_completed_packets(struct btdev *btdev, uint16_t handle)
 {
-	if (btdev->conn) {
+	struct btdev_conn *conn;
+
+	conn = queue_find(btdev->conns, match_handle, UINT_TO_PTR(handle));
+	if (conn) {
 		struct bt_hci_evt_num_completed_packets ncp;
 
 		ncp.num_handles = 1;
@@ -5019,10 +5293,11 @@ static void process_cmd(struct btdev *btdev, const void *data, uint16_t len)
 	}
 }
 
-static void send_acl(struct btdev *conn, const void *data, uint16_t len)
+static void send_acl(struct btdev *dev, const void *data, uint16_t len)
 {
 	struct bt_hci_acl_hdr hdr;
 	struct iovec iov[3];
+	struct btdev_conn *conn;
 
 	/* Packet type */
 	iov[0].iov_base = (void *) data;
@@ -5032,8 +5307,16 @@ static void send_acl(struct btdev *conn, const void *data, uint16_t len)
 	 * From controller to host this should be converted to ACL_START.
 	 */
 	memcpy(&hdr, data + 1, sizeof(hdr));
+
+	conn = queue_find(dev->conns, match_handle,
+					UINT_TO_PTR(acl_handle(hdr.handle)));
+	if (!conn)
+		return;
+
+	num_completed_packets(dev, conn->handle);
+
 	if (acl_flags(hdr.handle) == ACL_START_NO_FLUSH)
-		hdr.handle = acl_handle_pack(acl_handle(hdr.handle), ACL_START);
+		hdr.handle = acl_handle_pack(conn->handle, ACL_START);
 
 	iov[1].iov_base = &hdr;
 	iov[1].iov_len = sizeof(hdr);
@@ -5041,17 +5324,26 @@ static void send_acl(struct btdev *conn, const void *data, uint16_t len)
 	iov[2].iov_base = (void *) (data + 1 + sizeof(hdr));
 	iov[2].iov_len = len - 1 - sizeof(hdr);
 
-	send_packet(conn, iov, 3);
+	send_packet(conn->link->dev, iov, 3);
 }
 
-static void send_iso(struct btdev *conn, const void *data, uint16_t len)
+static void send_iso(struct btdev *dev, const void *data, uint16_t len)
 {
+	struct bt_hci_acl_hdr *hdr;
 	struct iovec iov;
+	struct btdev_conn *conn;
 
-	iov.iov_base = (void *) (data);
+	iov.iov_base = hdr = (void *) (data);
 	iov.iov_len = len;
 
-	send_packet(conn, &iov, 1);
+	conn = queue_find(dev->conns, match_handle,
+					UINT_TO_PTR(acl_handle(hdr->handle)));
+	if (!conn)
+		return;
+
+	num_completed_packets(dev, conn->handle);
+
+	send_packet(conn->link->dev, &iov, 1);
 }
 
 void btdev_receive_h4(struct btdev *btdev, const void *data, uint16_t len)
@@ -5074,14 +5366,10 @@ void btdev_receive_h4(struct btdev *btdev, const void *data, uint16_t len)
 		process_cmd(btdev, data + 1, len - 1);
 		break;
 	case BT_H4_ACL_PKT:
-		if (btdev->conn)
-			send_acl(btdev->conn, data, len);
-		num_completed_packets(btdev, ACL_HANDLE);
+		send_acl(btdev, data, len);
 		break;
 	case BT_H4_ISO_PKT:
-		num_completed_packets(btdev, ISO_HANDLE);
-		if (btdev->conn)
-			send_iso(btdev->conn, data, len);
+		send_iso(btdev, data, len);
 		break;
 	default:
 		util_debug(btdev->debug_callback, btdev->debug_data,
diff --git a/lib/hci.h b/lib/hci.h
index 0ca20421a..3382b87bf 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -107,6 +107,7 @@ enum {
 #define HCI_ACLDATA_PKT		0x02
 #define HCI_SCODATA_PKT		0x03
 #define HCI_EVENT_PKT		0x04
+#define HCI_ISODATA_PKT		0x05
 #define HCI_VENDOR_PKT		0xff
 
 /* HCI Packet types */
-- 
2.26.2

