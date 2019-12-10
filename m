Return-Path: <SRS0=8Xmo=2A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00662C43603
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Dec 2019 17:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA41720828
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Dec 2019 17:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ntMJst6i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfLJR7J (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Dec 2019 12:59:09 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37358 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbfLJR7J (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Dec 2019 12:59:09 -0500
Received: by mail-vs1-f66.google.com with SMTP id x18so13731203vsq.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Dec 2019 09:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8VJABh4MFINUlbv0ui6NTw1z4331P9vIuPheBBNReww=;
        b=ntMJst6iXN4DD4R4x68xwcGIQbMwjJeUeGvZkxN2a9I8L6JGkAsvXGptN5Sr2HiC+z
         I5m3z2vn3ELTi2uZ3VD+T02L+lAcDKMS/anTirUW1x62ItMcXb+agTPpyRyEqcZQGfVS
         jXwuYH172S9cXPhQOsse5v4YW4Zb2g3oOlDj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8VJABh4MFINUlbv0ui6NTw1z4331P9vIuPheBBNReww=;
        b=LNCiIX2PoJi9DPika/E6LxQ3SM7nxlRC6CKGa9QNAPrnbJEQggL66JR1Y9fZtl41Q2
         uIl7+nAlYoxyIeRAszK4OlJrL9PFJTQ462rvrkP8XNVe9YjSlHo9M1lKGKJJLw+Q/Mqv
         fpc/fJxia+mXCg4kroPInOjDP6/OhI6S4rq5MoA3oeoQ96nJzFl5ueoa3Zbu2SR2MwjT
         Mivc1+gMV4MFnCCZW7QehFb3ciK4uLrLmhaHVWHSHHPw3IJ8kcaHlbdRIOgnUPHQFbLs
         /fT7Uh0bhFbicAVN3I+ROFh9v4JZg93jPwO1JWnr4pPGGIn8sq7W3Qbdw/PRpRJIEf0U
         MisA==
X-Gm-Message-State: APjAAAWcS2IEwpe19ssqWP+3dO1juc59eeE06f3bOf3WhShmDWPutiSL
        60SFtLJbaaQ8pH0vbk0MyzWehF5s32s=
X-Google-Smtp-Source: APXvYqyiyikdcTKUZqOGA19AmueHh3bauUyUx25zFkA5DmRxTJEG/C6H8qHHexNpX9bKvnNb102dOg==
X-Received: by 2002:a05:6102:2e8:: with SMTP id j8mr25694285vsj.183.1576000747688;
        Tue, 10 Dec 2019 09:59:07 -0800 (PST)
Received: from alain.us-east1-b.c.cloudtop-prod.google.com.internal (239.145.196.35.bc.googleusercontent.com. [35.196.145.239])
        by smtp.gmail.com with ESMTPSA id r6sm2393351vsp.5.2019.12.10.09.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 09:59:06 -0800 (PST)
From:   Alain Michaud <alainm@chromium.org>
To:     BlueZ <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>
Subject: [PATCH v2] Loading keys that should be blocked from bluetoothd.
Date:   Tue, 10 Dec 2019 17:59:01 +0000
Message-Id: <20191210175901.31161-1-alainm@chromium.org>
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This changes will send a list of known bad keys that should be blocked
if supported by the kernel.

In particular keys from the Google Titan Security key are being blocked.
For additional information, please see
https://security.googleblog.com/2019/05/titan-keys-update.html

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

 lib/mgmt.h    | 16 ++++++++++++
 src/adapter.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 570dec997..a99b18c88 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -583,6 +583,22 @@ struct mgmt_cp_set_phy_confguration {
 	uint32_t	selected_phys;
 } __packed;
 
+#define MGMT_OP_SET_BLOCKED_KEYS	0x0046
+
+#define HCI_BLOCKED_KEY_TYPE_LINKKEY	0x00
+#define HCI_BLOCKED_KEY_TYPE_LTK		0x01
+#define HCI_BLOCKED_KEY_TYPE_IRK		0x02
+
+struct mgmt_blocked_key_info {
+	uint8_t type;
+	uint8_t val[16];
+} __packed;
+
+struct mgmt_cp_set_blocked_keys {
+	uint16_t key_count;
+	struct mgmt_blocked_key_info keys[0];
+} __packed;
+#define MGMT_OP_SET_BLOCKED_KEYS_SIZE 0
 
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
diff --git a/src/adapter.c b/src/adapter.c
index cef25616f..2958870e6 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -99,10 +99,27 @@
 #define DISTANCE_VAL_INVALID	0x7FFF
 #define PATHLOSS_MAX		137
 
+/*
+ * These are known security keys that have been compromised.
+ * If this grows or there are needs to be platform specific, it is
+ * conceivable that these could be read from a config file.
+ */
+static const struct mgmt_blocked_key_info blocked_keys[] = {
+	/* Google Titan Security Keys */
+	{ HCI_BLOCKED_KEY_TYPE_LTK,
+		{0xbf, 0x01, 0xfb, 0x9d, 0x4e, 0xf3, 0xbc, 0x36,
+		 0xd8, 0x74, 0xf5, 0x39, 0x41, 0x38, 0x68, 0x4c}},
+	{ HCI_BLOCKED_KEY_TYPE_IRK,
+		{0xa5, 0x99, 0xba, 0xe4, 0xe1, 0x7c, 0xa6, 0x18,
+		 0x22, 0x8e, 0x07, 0x56, 0xb4, 0xe8, 0x5f, 0x01}},
+};
+
 static DBusConnection *dbus_conn = NULL;
 
 static bool kernel_conn_control = false;
 
+static bool kernel_blocked_keys_supported = false;
+
 static GList *adapter_list = NULL;
 static unsigned int adapter_remaining = 0;
 static bool powering_down = false;
@@ -8568,6 +8585,40 @@ static bool set_static_addr(struct btd_adapter *adapter)
 	return false;
 }
 
+static void set_blocked_keys_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		btd_error(adapter->dev_id,
+				"Failed to set blocked keys: %s (0x%02x)",
+				mgmt_errstr(status), status);
+		return;
+	}
+
+	DBG("Successfully set blocked keys for index %u", adapter->dev_id);
+}
+
+static bool set_blocked_keys(struct btd_adapter *adapter)
+{
+	uint8_t buffer[sizeof(struct mgmt_cp_set_blocked_keys) +
+					sizeof(blocked_keys)] = { 0 };
+	struct mgmt_cp_set_blocked_keys *cp =
+					(struct mgmt_cp_set_blocked_keys *)buffer;
+	int i;
+
+	cp->key_count = G_N_ELEMENTS(blocked_keys);
+	for (i = 0; i < cp->key_count; ++i) {
+		cp->keys[i].type = blocked_keys[i].type;
+		memcpy(cp->keys[i].val, blocked_keys[i].val, sizeof(cp->keys[i].val));
+	}
+
+	return mgmt_send(mgmt_master, MGMT_OP_SET_BLOCKED_KEYS, adapter->dev_id,
+					sizeof(buffer),	buffer,	set_blocked_keys_complete,
+					adapter, NULL);
+}
+
 static void read_info_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -8795,6 +8846,12 @@ static void read_info_complete(uint8_t status, uint16_t length,
 
 	set_name(adapter, btd_adapter_get_name(adapter));
 
+	if (kernel_blocked_keys_supported && !set_blocked_keys(adapter)) {
+		btd_error(adapter->dev_id,
+			"Failed to set blocked keys for index %u", adapter->dev_id);
+		goto failed;
+	}
+
 	if (main_opts.pairable &&
 			!(adapter->current_settings & MGMT_SETTING_BONDABLE))
 		set_mode(adapter, MGMT_OP_SET_BONDABLE, 0x01);
@@ -8972,9 +9029,17 @@ static void read_commands_complete(uint8_t status, uint16_t length,
 	for (i = 0; i < num_commands; i++) {
 		uint16_t op = get_le16(rp->opcodes + i);
 
-		if (op == MGMT_OP_ADD_DEVICE) {
+		switch (op) {
+		case MGMT_OP_ADD_DEVICE:
 			DBG("enabling kernel-side connection control");
 			kernel_conn_control = true;
+			break;
+		case MGMT_OP_SET_BLOCKED_KEYS:
+			DBG("kernel supports the set_blocked_keys op");
+			kernel_blocked_keys_supported = true;
+			break;
+		default:
+			break;
 		}
 	}
 }
-- 
2.24.0.525.g8f36a354ae-goog

