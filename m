Return-Path: <SRS0=lPNB=Z3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59512C43603
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Dec 2019 17:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24154206DB
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Dec 2019 17:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SeMdfkp+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730220AbfLERvh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Dec 2019 12:51:37 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:46018 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730003AbfLERvh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Dec 2019 12:51:37 -0500
Received: by mail-vk1-f195.google.com with SMTP id g7so1390435vkl.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Dec 2019 09:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rqa3jh+6LIF8YzAGtK9fK9ZOaVj+sTsIrw+GWH4Cjrg=;
        b=SeMdfkp+Wi/W5LgJGzFKkrF34IoVAxiin42Q78JEzex1+IjUQ4CWTM3NIOmkUL53rF
         JEAFveuWtm4vbKheNX7SnrI6YswRuztjzOvvco90NXCek/nimvkRixMcESmzEn9pasYU
         lQsq4Ohz20QiuIQFTwghwIsUMqod97zYXs8Kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rqa3jh+6LIF8YzAGtK9fK9ZOaVj+sTsIrw+GWH4Cjrg=;
        b=LEobAioA8FCsYrLchEH5OWlP+WV/faENpxNenxndE0dhTNqsTr/xi1fZtHH/ZeqRkl
         mJokUs5TlWrcftfejjh6QdeE4CxBxeZjy94CKVilfD/u8vOawBlJx0xSiVFZYQwedg6U
         p7uftaqOz/gy8VkdGrMqWb/UGZuo/YUETSq6CqfqYUa+K03yodJHjDPrCZXTAusC0alO
         8ilfG3DSWOEqA/FSusHs0wwOzOdWWRA/0bSitkUqSinCUDrEk0BZGr1mbgAUSTTjUp0n
         edlyZuUCEI2hNZ0vePDN2WM+SJe3pMwXDkLUDpb2ej3tjaOFoKXZkebMkQUUia797sPC
         nNyg==
X-Gm-Message-State: APjAAAXKjTQdWrSOs1br7hQvfKEJyZvWJ6hrAgxIa2AXhfYinY6YDewp
        Cd4epTj0rf8sLP2/YKX887JjoAGSskI=
X-Google-Smtp-Source: APXvYqyMcmhCornn8XBK/9zPIb6HwN0lKh2J4Vv7d2tVxKIfdeGNLbuH+KEaB7PyPTcEJ0tnkrOkIw==
X-Received: by 2002:a1f:9f01:: with SMTP id i1mr7706193vke.54.1575568295863;
        Thu, 05 Dec 2019 09:51:35 -0800 (PST)
Received: from alain.us-east1-b.c.cloudtop-prod.google.com.internal (239.145.196.35.bc.googleusercontent.com. [35.196.145.239])
        by smtp.gmail.com with ESMTPSA id a6sm3949327vsr.9.2019.12.05.09.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 09:51:35 -0800 (PST)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [RFC BlueZ v2] Adding support for blocking keys and mgmt tests.
Date:   Thu,  5 Dec 2019 17:51:32 +0000
Message-Id: <20191205175132.123632-1-alainm@chromium.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Here's a newer version with most of your feedback addressed.  Others
responses sent inline in the v1.

---
 lib/mgmt.h       | 17 +++++++++++++
 src/adapter.c    | 65 +++++++++++++++++++++++++++++++++++++++++++++++-
 unit/test-mgmt.c | 33 ++++++++++++++++++++++++
 3 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 570dec997..3e2e26e68 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -583,6 +583,23 @@ struct mgmt_cp_set_phy_confguration {
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
+
 
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
diff --git a/src/adapter.c b/src/adapter.c
index cef25616f..f571961bb 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -99,10 +99,25 @@
 #define DISTANCE_VAL_INVALID	0x7FFF
 #define PATHLOSS_MAX		137
 
+/**
+ * These are known security keys that have been compromised.
+ * If this grows or there are needs to be platform specific, it is
+ * conceivable that these could be read from a config file.
+*/ 
+static const struct mgmt_blocked_key_info blocked_keys [] = {
+	// Google Titan Security Keys
+	{ HCI_BLOCKED_KEY_TYPE_LTK, {0xbf, 0x01, 0xfb, 0x9d, 0x4e, 0xf3, 0xbc, 0x36,
+		 					0xd8, 0x74, 0xf5, 0x39, 0x41, 0x38, 0x68, 0x4c}},
+	{ HCI_BLOCKED_KEY_TYPE_IRK, {0xa5, 0x99, 0xba, 0xe4, 0xe1, 0x7c, 0xa6, 0x18,
+					0x22, 0x8e, 0x07, 0x56, 0xb4, 0xe8, 0x5f, 0x01}},
+};
+
 static DBusConnection *dbus_conn = NULL;
 
 static bool kernel_conn_control = false;
 
+static bool kernel_blocked_keys_supported = false;
+
 static GList *adapter_list = NULL;
 static unsigned int adapter_remaining = 0;
 static bool powering_down = false;
@@ -8568,6 +8583,40 @@ static bool set_static_addr(struct btd_adapter *adapter)
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
@@ -8795,6 +8844,12 @@ static void read_info_complete(uint8_t status, uint16_t length,
 
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
@@ -8972,9 +9027,17 @@ static void read_commands_complete(uint8_t status, uint16_t length,
 	for (i = 0; i < num_commands; i++) {
 		uint16_t op = get_le16(rp->opcodes + i);
 
-		if (op == MGMT_OP_ADD_DEVICE) {
+		switch (op){
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
diff --git a/unit/test-mgmt.c b/unit/test-mgmt.c
index c67678b9a..d73c03f61 100644
--- a/unit/test-mgmt.c
+++ b/unit/test-mgmt.c
@@ -256,6 +256,33 @@ static const struct command_test_data command_test_3 = {
 	.rsp_status = MGMT_STATUS_INVALID_INDEX,
 };
 
+static const unsigned char invalid_key_buffer[] =
+ { 0x01, 0x02 };
+
+static const struct command_test_data command_test_set_blocked_keys1 = {
+ .opcode = MGMT_OP_SET_BLOCKED_KEYS,
+ .index = MGMT_INDEX_NONE,
+ .cmd_data = invalid_key_buffer,
+ .cmd_size = sizeof(invalid_key_buffer),
+ .rsp_data = NULL,
+ .rsp_size = 0,
+ .rsp_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
+static const unsigned char valid_keys_buffer1[] =
+ { 0x01, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+ 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f };
+
+static const struct command_test_data command_test_set_blocked_keys2 = {
+ .opcode = MGMT_OP_SET_BLOCKED_KEYS,
+ .index = MGMT_INDEX_NONE,
+ .cmd_data = valid_keys_buffer1,
+ .cmd_size = sizeof(valid_keys_buffer1),
+ .rsp_data = NULL,
+ .rsp_size = 0,
+ .rsp_status = MGMT_STATUS_SUCCESS,
+};
+
 static const unsigned char event_index_added[] =
 				{ 0x04, 0x00, 0x01, 0x00, 0x00, 0x00 };
 
@@ -441,6 +468,12 @@ int main(int argc, char *argv[])
 	g_test_add_data_func("/mgmt/response/2", &command_test_3,
 								test_response);
 
+	g_test_add_data_func("/mgmt/command/set_blocked_keys1",
+						&command_test_set_blocked_keys1, test_command);
+
+	g_test_add_data_func("/mgmt/command/set_blocked_keys2",
+						&command_test_set_blocked_keys2, test_command);
+
 	g_test_add_data_func("/mgmt/event/1", &event_test_1, test_event);
 	g_test_add_data_func("/mgmt/event/2", &event_test_1, test_event2);
 
-- 
2.24.0.393.g34dc348eaf-goog

