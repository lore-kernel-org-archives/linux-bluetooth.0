Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C448BC432BE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABC3F600CC
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240368AbhHMMVV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240404AbhHMMVR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:21:17 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE48C0617AD
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:20:50 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w200-20020a25c7d10000b02905585436b530so9003576ybe.21
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qX0op0RwNnb4SfUwmWelLnu1NmagbazjMSr5aFn1x1M=;
        b=ZPZbxqcTod1mXB8Rd2argXY5uRt8ZOYSaclKG7SMXtWOIfBXzF1RDpkgeAVx4/nuw6
         1Re+TqUVJgWrhLK7I90i+mWjidtqc/fcUOxZ3Ws/wgo4xNGAqUgBEL/IK+NNjEwTLaT+
         KY6op28RMZnkep8n8iTYMbDbcqzzmXkIhbWnfluo+cegpsNus4r8pzCWCAEbZ1Qd4r4s
         x95TuVGSOpJMqzoNCtxHWI7QAhh2+C9RrJOrWGON4lTXmXH9Ny3TLwHzygpIKb11B4fF
         PpK+eLXV5plXj5TKw27rDtu2U3lkdAheWvkkICOOy+7q+2mbN4BxPIytlAzpEtyXuIyE
         foOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qX0op0RwNnb4SfUwmWelLnu1NmagbazjMSr5aFn1x1M=;
        b=jV4imWs72k3ou0rGUqWu8PXh59GyxPqkv+LZrHuJNJElAoQzaWFUJdGt1UCtVtPJjW
         ZATYLVNtFuyh7Y9UwSNfBFKlLa8l+5UuRzmthEia+ht/W24YV5T+eErGYtn2tq342BEg
         a+5UyxzqxyFi0uJPviDeQT3sbGUIcaI7fqXfhQ8tAC33r7D9ZSFYPoeDJUkmM8200ZT6
         wjUlH858/A/NSSyzVFKFUoqmajWO4pedkZh/q8goEALWWvR1j3P0WAEorjXMPToD6nYr
         jKwjn52B86CkszsxYcrMbtYHOVbJR2hkGoMnt+GlOSahQIZe0BiLFxI7Afyve2I8IbQj
         La2g==
X-Gm-Message-State: AOAM533puw3bD1GczbvFdu5J/nW8IS4Mo6WGmSYSLBgXniiwHtUORgpD
        6A3AjCu6g3qskesGthbUkjJcTKyaRprPBfKDtMhHcnb47hwGABnGu0Gb3k7PcRnYYf7BX5zxon0
        mzjKwQuzB1x7n3tF6m9HWIgfEBKeeQAhPkgK6ZQnnnmI9yLpg5KhQlGgFCf2i5bJo8RTTNYFCzw
        qg
X-Google-Smtp-Source: ABdhPJwAJpvnIFufGrREMgX7+yNFqZQq9S24RZojX4M7MP32+05EL9aLrDTvRnF97b0BLopiOfGmjwaVUX8I
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a25:7497:: with SMTP id
 p145mr2660406ybc.338.1628857249767; Fri, 13 Aug 2021 05:20:49 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:05 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.20.I63cb796d677d5bd085fc77cb1cb7164278b8e1cd@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 20/62] monitor: Inclusive language in filtering devices
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

"accept list" is preferred, as reflected in the BT core spec 5.3.
---

 emulator/btdev.c    | 24 +++++++++++------------
 emulator/le.c       | 32 +++++++++++++++----------------
 monitor/bt.h        | 14 +++++++-------
 monitor/packet.c    | 46 ++++++++++++++++++++++-----------------------
 tools/hci-tester.c  |  4 ++--
 tools/mgmt-tester.c |  4 ++--
 6 files changed, 62 insertions(+), 62 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 159ebe6ec5..89f7701714 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -3492,11 +3492,11 @@ static int cmd_le_create_conn_complete(struct btdev *dev, const void *data,
 
 static int cmd_read_wl_size(struct btdev *dev, const void *data, uint8_t len)
 {
-	struct bt_hci_rsp_le_read_white_list_size rsp;
+	struct bt_hci_rsp_le_read_accept_list_size rsp;
 
 	rsp.status = BT_HCI_ERR_SUCCESS;
 	rsp.size = WL_SIZE;
-	cmd_complete(dev, BT_HCI_CMD_LE_READ_WHITE_LIST_SIZE, &rsp,
+	cmd_complete(dev, BT_HCI_CMD_LE_READ_ACCEPT_LIST_SIZE, &rsp,
 						sizeof(rsp));
 
 	return 0;
@@ -3544,7 +3544,7 @@ static int cmd_wl_clear(struct btdev *dev, const void *data, uint8_t len)
 	wl_clear(dev);
 
 	status = BT_HCI_ERR_SUCCESS;
-	cmd_complete(dev, BT_HCI_CMD_LE_CLEAR_WHITE_LIST, &status,
+	cmd_complete(dev, BT_HCI_CMD_LE_CLEAR_ACCEPT_LIST, &status,
 						sizeof(status));
 
 	return 0;
@@ -3561,7 +3561,7 @@ static void wl_add(struct btdev_wl *wl, uint8_t type, bdaddr_t *addr)
 
 static int cmd_add_wl(struct btdev *dev, const void *data, uint8_t len)
 {
-	const struct bt_hci_cmd_le_add_to_white_list *cmd = data;
+	const struct bt_hci_cmd_le_add_to_accept_list *cmd = data;
 	uint8_t status;
 	bool exists = false;
 	int i, pos = -1;
@@ -3597,14 +3597,14 @@ static int cmd_add_wl(struct btdev *dev, const void *data, uint8_t len)
 
 	if (pos < 0) {
 		cmd_status(dev, BT_HCI_ERR_MEM_CAPACITY_EXCEEDED,
-					BT_HCI_CMD_LE_ADD_TO_WHITE_LIST);
+					BT_HCI_CMD_LE_ADD_TO_ACCEPT_LIST);
 		return 0;
 	}
 
 	wl_add(&dev->le_wl[pos], cmd->addr_type, (bdaddr_t *)&cmd->addr);
 
 	status = BT_HCI_ERR_SUCCESS;
-	cmd_complete(dev, BT_HCI_CMD_LE_ADD_TO_WHITE_LIST,
+	cmd_complete(dev, BT_HCI_CMD_LE_ADD_TO_ACCEPT_LIST,
 						&status, sizeof(status));
 
 	return 0;
@@ -3612,7 +3612,7 @@ static int cmd_add_wl(struct btdev *dev, const void *data, uint8_t len)
 
 static int cmd_remove_wl(struct btdev *dev, const void *data, uint8_t len)
 {
-	const struct bt_hci_cmd_le_remove_from_white_list *cmd = data;
+	const struct bt_hci_cmd_le_remove_from_accept_list *cmd = data;
 	uint8_t status;
 	int i;
 	char addr[18];
@@ -3652,7 +3652,7 @@ static int cmd_remove_wl(struct btdev *dev, const void *data, uint8_t len)
 		return -EINVAL;
 
 	status = BT_HCI_ERR_SUCCESS;
-	cmd_complete(dev, BT_HCI_CMD_LE_REMOVE_FROM_WHITE_LIST,
+	cmd_complete(dev, BT_HCI_CMD_LE_REMOVE_FROM_ACCEPT_LIST,
 						&status, sizeof(status));
 
 	return 0;
@@ -4237,10 +4237,10 @@ static int cmd_gen_dhkey(struct btdev *dev, const void *data, uint8_t len)
 					cmd_set_scan_enable_complete), \
 	CMD(BT_HCI_CMD_LE_CREATE_CONN, cmd_le_create_conn, \
 					cmd_le_create_conn_complete), \
-	CMD(BT_HCI_CMD_LE_READ_WHITE_LIST_SIZE, cmd_read_wl_size, NULL), \
-	CMD(BT_HCI_CMD_LE_CLEAR_WHITE_LIST, cmd_wl_clear, NULL), \
-	CMD(BT_HCI_CMD_LE_ADD_TO_WHITE_LIST, cmd_add_wl, NULL), \
-	CMD(BT_HCI_CMD_LE_REMOVE_FROM_WHITE_LIST, cmd_remove_wl, NULL), \
+	CMD(BT_HCI_CMD_LE_READ_ACCEPT_LIST_SIZE, cmd_read_wl_size, NULL), \
+	CMD(BT_HCI_CMD_LE_CLEAR_ACCEPT_LIST, cmd_wl_clear, NULL), \
+	CMD(BT_HCI_CMD_LE_ADD_TO_ACCEPT_LIST, cmd_add_wl, NULL), \
+	CMD(BT_HCI_CMD_LE_REMOVE_FROM_ACCEPT_LIST, cmd_remove_wl, NULL), \
 	CMD(BT_HCI_CMD_LE_CONN_UPDATE, cmd_conn_update, \
 					cmd_conn_update_complete), \
 	CMD(BT_HCI_CMD_LE_READ_REMOTE_FEATURES, cmd_le_read_remote_features, \
diff --git a/emulator/le.c b/emulator/le.c
index 4ffe3b16db..23f2579426 100644
--- a/emulator/le.c
+++ b/emulator/le.c
@@ -1211,12 +1211,12 @@ static void cmd_le_create_conn_cancel(struct bt_le *hci,
 static void cmd_le_read_white_list_size(struct bt_le *hci,
 						const void *data, uint8_t size)
 {
-	struct bt_hci_rsp_le_read_white_list_size rsp;
+	struct bt_hci_rsp_le_read_accept_list_size rsp;
 
 	rsp.status = BT_HCI_ERR_SUCCESS;
 	rsp.size = hci->le_white_list_size;
 
-	cmd_complete(hci, BT_HCI_CMD_LE_READ_WHITE_LIST_SIZE,
+	cmd_complete(hci, BT_HCI_CMD_LE_READ_ACCEPT_LIST_SIZE,
 							&rsp, sizeof(rsp));
 }
 
@@ -1228,14 +1228,14 @@ static void cmd_le_clear_white_list(struct bt_le *hci,
 	clear_white_list(hci);
 
 	status = BT_HCI_ERR_SUCCESS;
-	cmd_complete(hci, BT_HCI_CMD_LE_CLEAR_WHITE_LIST,
+	cmd_complete(hci, BT_HCI_CMD_LE_CLEAR_ACCEPT_LIST,
 						&status, sizeof(status));
 }
 
 static void cmd_le_add_to_white_list(struct bt_le *hci,
 						const void *data, uint8_t size)
 {
-	const struct bt_hci_cmd_le_add_to_white_list *cmd = data;
+	const struct bt_hci_cmd_le_add_to_accept_list *cmd = data;
 	uint8_t status;
 	bool exists = false;
 	int i, pos = -1;
@@ -1243,7 +1243,7 @@ static void cmd_le_add_to_white_list(struct bt_le *hci,
 	/* Valid range for address type is 0x00 to 0x01 */
 	if (cmd->addr_type > 0x01) {
 		cmd_status(hci, BT_HCI_ERR_INVALID_PARAMETERS,
-					BT_HCI_CMD_LE_ADD_TO_WHITE_LIST);
+					BT_HCI_CMD_LE_ADD_TO_ACCEPT_LIST);
 		return;
 	}
 
@@ -1259,13 +1259,13 @@ static void cmd_le_add_to_white_list(struct bt_le *hci,
 
 	if (exists) {
 		cmd_status(hci, BT_HCI_ERR_UNSPECIFIED_ERROR,
-					BT_HCI_CMD_LE_ADD_TO_WHITE_LIST);
+					BT_HCI_CMD_LE_ADD_TO_ACCEPT_LIST);
 		return;
 	}
 
 	if (pos < 0) {
 		cmd_status(hci, BT_HCI_ERR_MEM_CAPACITY_EXCEEDED,
-					BT_HCI_CMD_LE_ADD_TO_WHITE_LIST);
+					BT_HCI_CMD_LE_ADD_TO_ACCEPT_LIST);
 		return;
 	}
 
@@ -1273,21 +1273,21 @@ static void cmd_le_add_to_white_list(struct bt_le *hci,
 	memcpy(&hci->le_white_list[pos][1], cmd->addr, 6);
 
 	status = BT_HCI_ERR_SUCCESS;
-	cmd_complete(hci, BT_HCI_CMD_LE_ADD_TO_WHITE_LIST,
+	cmd_complete(hci, BT_HCI_CMD_LE_ADD_TO_ACCEPT_LIST,
 						&status, sizeof(status));
 }
 
 static void cmd_le_remove_from_white_list(struct bt_le *hci,
 						const void *data, uint8_t size)
 {
-	const struct bt_hci_cmd_le_remove_from_white_list *cmd = data;
+	const struct bt_hci_cmd_le_remove_from_accept_list *cmd = data;
 	uint8_t status;
 	int i, pos = -1;
 
 	/* Valid range for address type is 0x00 to 0x01 */
 	if (cmd->addr_type > 0x01) {
 		cmd_status(hci, BT_HCI_ERR_INVALID_PARAMETERS,
-					BT_HCI_CMD_LE_REMOVE_FROM_WHITE_LIST);
+					BT_HCI_CMD_LE_REMOVE_FROM_ACCEPT_LIST);
 		return;
 	}
 
@@ -1302,7 +1302,7 @@ static void cmd_le_remove_from_white_list(struct bt_le *hci,
 
 	if (pos < 0) {
 		cmd_status(hci, BT_HCI_ERR_INVALID_PARAMETERS,
-					BT_HCI_CMD_LE_REMOVE_FROM_WHITE_LIST);
+					BT_HCI_CMD_LE_REMOVE_FROM_ACCEPT_LIST);
 		return;
 	}
 
@@ -1310,7 +1310,7 @@ static void cmd_le_remove_from_white_list(struct bt_le *hci,
 	memset(&hci->le_white_list[pos][1], 0, 6);
 
 	status = BT_HCI_ERR_SUCCESS;
-	cmd_complete(hci, BT_HCI_CMD_LE_REMOVE_FROM_WHITE_LIST,
+	cmd_complete(hci, BT_HCI_CMD_LE_REMOVE_FROM_ACCEPT_LIST,
 						&status, sizeof(status));
 }
 
@@ -1830,13 +1830,13 @@ static const struct {
 				cmd_le_create_conn, 25, true },
 	{ BT_HCI_CMD_LE_CREATE_CONN_CANCEL,
 				cmd_le_create_conn_cancel, 0, true },
-	{ BT_HCI_CMD_LE_READ_WHITE_LIST_SIZE,
+	{ BT_HCI_CMD_LE_READ_ACCEPT_LIST_SIZE,
 				cmd_le_read_white_list_size, 0, true },
-	{ BT_HCI_CMD_LE_CLEAR_WHITE_LIST,
+	{ BT_HCI_CMD_LE_CLEAR_ACCEPT_LIST,
 				cmd_le_clear_white_list, 0, true },
-	{ BT_HCI_CMD_LE_ADD_TO_WHITE_LIST,
+	{ BT_HCI_CMD_LE_ADD_TO_ACCEPT_LIST,
 				cmd_le_add_to_white_list,  7, true },
-	{ BT_HCI_CMD_LE_REMOVE_FROM_WHITE_LIST,
+	{ BT_HCI_CMD_LE_REMOVE_FROM_ACCEPT_LIST,
 				cmd_le_remove_from_white_list, 7, true },
 
 	{ BT_HCI_CMD_LE_ENCRYPT, cmd_le_encrypt, 32, true },
diff --git a/monitor/bt.h b/monitor/bt.h
index 3144c25ff0..3150e82f3a 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2072,22 +2072,22 @@ struct bt_hci_cmd_le_create_conn {
 
 #define BT_HCI_CMD_LE_CREATE_CONN_CANCEL	0x200e
 
-#define BT_HCI_CMD_LE_READ_WHITE_LIST_SIZE	0x200f
-struct bt_hci_rsp_le_read_white_list_size {
+#define BT_HCI_CMD_LE_READ_ACCEPT_LIST_SIZE	0x200f
+struct bt_hci_rsp_le_read_accept_list_size {
 	uint8_t  status;
 	uint8_t  size;
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_LE_CLEAR_WHITE_LIST		0x2010
+#define BT_HCI_CMD_LE_CLEAR_ACCEPT_LIST		0x2010
 
-#define BT_HCI_CMD_LE_ADD_TO_WHITE_LIST		0x2011
-struct bt_hci_cmd_le_add_to_white_list {
+#define BT_HCI_CMD_LE_ADD_TO_ACCEPT_LIST	0x2011
+struct bt_hci_cmd_le_add_to_accept_list {
 	uint8_t  addr_type;
 	uint8_t  addr[6];
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_LE_REMOVE_FROM_WHITE_LIST	0x2012
-struct bt_hci_cmd_le_remove_from_white_list {
+#define BT_HCI_CMD_LE_REMOVE_FROM_ACCEPT_LIST	0x2012
+struct bt_hci_cmd_le_remove_from_accept_list {
 	uint8_t  addr_type;
 	uint8_t  addr[6];
 } __attribute__ ((packed));
diff --git a/monitor/packet.c b/monitor/packet.c
index 17da5a08d9..82763cc27b 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -2164,16 +2164,16 @@ static void print_adv_filter_policy(const char *label, uint8_t value)
 			"Allow Connect Request from Any";
 		break;
 	case 0x01:
-		str = "Allow Scan Request from White List Only, "
+		str = "Allow Scan Request from Accept List Only, "
 			"Allow Connect Request from Any";
 		break;
 	case 0x02:
 		str = "Allow Scan Request from Any, "
-			"Allow Connect Request from White List Only";
+			"Allow Connect Request from Accept List Only";
 		break;
 	case 0x03:
-		str = "Allow Scan Request from White List Only, "
-			"Allow Connect Request from White List Only";
+		str = "Allow Scan Request from Accept List Only, "
+			"Allow Connect Request from Accept List Only";
 		break;
 	default:
 		str = "Reserved";
@@ -6534,13 +6534,13 @@ static void print_scan_filter_policy(uint8_t policy)
 		str = "Accept all advertisement";
 		break;
 	case 0x01:
-		str = "Ignore not in white list";
+		str = "Ignore not in accept list";
 		break;
 	case 0x02:
 		str = "Accept all advertisement, inc. directed unresolved RPA";
 		break;
 	case 0x03:
-		str = "Ignore not in white list, exc. directed unresolved RPA";
+		str = "Ignore not in accept list, exc. directed unresolved RPA";
 		break;
 	default:
 		str = "Reserved";
@@ -6579,10 +6579,10 @@ static void le_create_conn_cmd(const void *data, uint8_t size)
 
 	switch (cmd->filter_policy) {
 	case 0x00:
-		str = "White list is not used";
+		str = "Accept list is not used";
 		break;
 	case 0x01:
-		str = "White list is used";
+		str = "Accept list is used";
 		break;
 	default:
 		str = "Reserved";
@@ -6605,25 +6605,25 @@ static void le_create_conn_cmd(const void *data, uint8_t size)
 	print_slot_625("Max connection length", cmd->max_length);
 }
 
-static void le_read_white_list_size_rsp(const void *data, uint8_t size)
+static void le_read_accept_list_size_rsp(const void *data, uint8_t size)
 {
-	const struct bt_hci_rsp_le_read_white_list_size *rsp = data;
+	const struct bt_hci_rsp_le_read_accept_list_size *rsp = data;
 
 	print_status(rsp->status);
 	print_field("Size: %u", rsp->size);
 }
 
-static void le_add_to_white_list_cmd(const void *data, uint8_t size)
+static void le_add_to_accept_list_cmd(const void *data, uint8_t size)
 {
-	const struct bt_hci_cmd_le_add_to_white_list *cmd = data;
+	const struct bt_hci_cmd_le_add_to_accept_list *cmd = data;
 
 	print_addr_type("Address type", cmd->addr_type);
 	print_addr("Address", cmd->addr, cmd->addr_type);
 }
 
-static void le_remove_from_white_list_cmd(const void *data, uint8_t size)
+static void le_remove_from_accept_list_cmd(const void *data, uint8_t size)
 {
-	const struct bt_hci_cmd_le_remove_from_white_list *cmd = data;
+	const struct bt_hci_cmd_le_remove_from_accept_list *cmd = data;
 
 	print_addr_type("Address type", cmd->addr_type);
 	print_addr("Address", cmd->addr, cmd->addr_type);
@@ -7562,10 +7562,10 @@ static void le_ext_create_conn_cmd(const void *data, uint8_t size)
 
 	switch (cmd->filter_policy) {
 	case 0x00:
-		str = "White list is not used";
+		str = "Accept list is not used";
 		break;
 	case 0x01:
-		str = "White list is used";
+		str = "Accept list is used";
 		break;
 	default:
 		str = "Reserved";
@@ -8990,17 +8990,17 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x200e, 213, "LE Create Connection Cancel",
 				null_cmd, 0, true,
 				status_rsp, 1, true },
-	{ 0x200f, 214, "LE Read White List Size",
+	{ 0x200f, 214, "LE Read Accept List Size",
 				null_cmd, 0, true,
-				le_read_white_list_size_rsp, 2, true },
-	{ 0x2010, 215, "LE Clear White List",
+				le_read_accept_list_size_rsp, 2, true },
+	{ 0x2010, 215, "LE Clear Accept List",
 				null_cmd, 0, true,
 				status_rsp, 1, true },
-	{ 0x2011, 216, "LE Add Device To White List",
-				le_add_to_white_list_cmd, 7, true,
+	{ 0x2011, 216, "LE Add Device To Accept List",
+				le_add_to_accept_list_cmd, 7, true,
 				status_rsp, 1, true },
-	{ 0x2012, 217, "LE Remove Device From White List",
-				le_remove_from_white_list_cmd, 7, true,
+	{ 0x2012, 217, "LE Remove Device From Accept List",
+				le_remove_from_accept_list_cmd, 7, true,
 				status_rsp, 1, true },
 	{ 0x2013, 218, "LE Connection Update",
 				le_conn_update_cmd, 14, true },
diff --git a/tools/hci-tester.c b/tools/hci-tester.c
index 0fb74e69c7..645d89e721 100644
--- a/tools/hci-tester.c
+++ b/tools/hci-tester.c
@@ -337,12 +337,12 @@ static void test_read_local_supported_codecs(const void *test_data)
 
 static void test_le_read_white_list_size(const void *test_data)
 {
-	test_command(BT_HCI_CMD_LE_READ_WHITE_LIST_SIZE);
+	test_command(BT_HCI_CMD_LE_READ_ACCEPT_LIST_SIZE);
 }
 
 static void test_le_clear_white_list(const void *test_data)
 {
-	test_command(BT_HCI_CMD_LE_CLEAR_WHITE_LIST);
+	test_command(BT_HCI_CMD_LE_CLEAR_ACCEPT_LIST);
 }
 
 static void test_le_encrypt_complete(const void *data, uint8_t size,
diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index e369d7488b..26d78360d7 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -4248,7 +4248,7 @@ static const struct generic_data add_device_success_6 = {
 	.expect_alt_ev = MGMT_EV_DEVICE_ADDED,
 	.expect_alt_ev_param = add_device_success_param_6,
 	.expect_alt_ev_len = sizeof(add_device_success_param_6),
-	.expect_hci_command = BT_HCI_CMD_LE_ADD_TO_WHITE_LIST,
+	.expect_hci_command = BT_HCI_CMD_LE_ADD_TO_ACCEPT_LIST,
 	.expect_hci_param = le_add_to_white_list_param,
 	.expect_hci_len = sizeof(le_add_to_white_list_param),
 };
@@ -4418,7 +4418,7 @@ static const struct generic_data remove_device_success_7 = {
 	.expect_param = remove_device_param_2,
 	.expect_len = sizeof(remove_device_param_2),
 	.expect_status = MGMT_STATUS_SUCCESS,
-	.expect_hci_command = BT_HCI_CMD_LE_REMOVE_FROM_WHITE_LIST,
+	.expect_hci_command = BT_HCI_CMD_LE_REMOVE_FROM_ACCEPT_LIST,
 	.expect_hci_param = le_add_to_white_list_param,
 	.expect_hci_len = sizeof(le_add_to_white_list_param),
 	.expect_alt_ev = MGMT_EV_DEVICE_REMOVED,
-- 
2.33.0.rc1.237.g0d66db33f3-goog

