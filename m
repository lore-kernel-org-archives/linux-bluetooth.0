Return-Path: <SRS0=DiUs=Z2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489B4C432C0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Dec 2019 01:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B7A4206DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Dec 2019 01:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aE/URoJU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfLDBdM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Dec 2019 20:33:12 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39323 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfLDBdM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Dec 2019 20:33:12 -0500
Received: by mail-vs1-f67.google.com with SMTP id p21so3774133vsq.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Dec 2019 17:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xhzIH90MMqF7RQsF6SQZywyv+3zFv/qZXPnuBXXmYhw=;
        b=aE/URoJU+ZB+2p6Ba/LbV09G/ZvaOihVFAbXElYRUJRXIItvVWmb0xX7RkvXJ3cFpB
         C54+39TlQWbet3Xrz/3IIOGPLDLkAhmsadTDZ0ftCi+t4/EACYrDENI0URDJ+UbVEASY
         UyVucpcit4qCdYYoBTXbW7AxPQ1bedXIojcxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xhzIH90MMqF7RQsF6SQZywyv+3zFv/qZXPnuBXXmYhw=;
        b=t/H5FMB2/ytPCs7SOQHyGotQqYO6ue77j5Fx9XJwgZzyu6nqmdd/Ea5qF3zGGgNavK
         4cY5LhOM6SlNkg/ozRPXoE/uGw9UellQK3/H3Tw79EZDUP6yUOtu4aovrrkLDUC5PV85
         5evXM+KmAaas5jZrE70FNIh2nInNJgeyibInfIlRcBfF5JWQ6ItY1SasjuJuGBoDwYPJ
         3Qfu/aJhY7qWJ1GPiPhsMhCffP2AmqOpqYOfXcepntPMI82Cbx55CkeIaxYUV7HMqDeD
         ZAzxlFbtziaTxPl6m9FD+DsgsI7g3JJtuO7Cxa6TcNKhV7pnDPYSuOkJs+uWUxA9eab6
         qDBA==
X-Gm-Message-State: APjAAAVgnrYc6a5lnIysVTvACkbjGwDpF+6j0dYo1GEgag9qpgJCaIt5
        2KlafAWqLoS/V2VZP2ZKq7lhchNf2Sc=
X-Google-Smtp-Source: APXvYqye9zokkNLjjvcrTfmCvcfMA+OD7lYkRs4LhoNuvLFJ90awRXWWNunqLldeAlzO20yhbeIrVQ==
X-Received: by 2002:a67:6d03:: with SMTP id i3mr219657vsc.56.1575423190556;
        Tue, 03 Dec 2019 17:33:10 -0800 (PST)
Received: from alain.us-east1-b.c.cloudtop-prod.google.com.internal (239.145.196.35.bc.googleusercontent.com. [35.196.145.239])
        by smtp.gmail.com with ESMTPSA id i15sm1457886vkn.54.2019.12.03.17.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 17:33:10 -0800 (PST)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [RFC BlueZ] Adding support for blocking keys and mgmt tests.
Date:   Wed,  4 Dec 2019 01:33:06 +0000
Message-Id: <20191204013306.29935-1-alainm@chromium.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Would love feedback on this.  Corresponding kernel change also sent for
comments.

---
 lib/mgmt.h       | 12 +++++++++
 src/adapter.c    | 67 ++++++++++++++++++++++++++++++++++++++++++++----
 unit/test-mgmt.c | 33 ++++++++++++++++++++++++
 3 files changed, 107 insertions(+), 5 deletions(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 570dec997..fa50a3656 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -583,6 +583,18 @@ struct mgmt_cp_set_phy_confguration {
 	uint32_t	selected_phys;
 } __packed;
 
+#define MGMT_OP_SET_BLOCKED_KEYS	0x0046
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
index cef25616f..1b451af30 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -99,6 +99,19 @@
 #define DISTANCE_VAL_INVALID	0x7FFF
 #define PATHLOSS_MAX		137
 
+/**
+ * These are known security keys that have been compromised.
+ * If this grows or there are needs to be platform specific, it is
+ * conceivable that these could be read from a config file.
+*/ 
+static const struct mgmt_blocked_key_info blocked_keys [] = {
+	// Google Titan Security Keys
+	{ 0x01 /* LTK */, {0xbf, 0x01, 0xfb, 0x9d, 0x4e, 0xf3, 0xbc, 0x36,
+					0xd8, 0x74, 0xf5, 0x39, 0x41, 0x38, 0x68, 0x4c}},
+	{ 0x02 /* IRK */, {0xa5, 0x99, 0xba, 0xe4, 0xe1, 0x7c, 0xa6, 0x18,
+					0x22, 0x8e, 0x07, 0x56, 0xb4, 0xe8, 0x5f, 0x01}},
+};
+
 static DBusConnection *dbus_conn = NULL;
 
 static bool kernel_conn_control = false;
@@ -8827,6 +8840,40 @@ failed:
 	btd_adapter_unref(adapter);
 }
 
+static void set_blocked_ltks_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		btd_error(adapter->dev_id,
+				"Failed to set blocked LTKs: %s (0x%02x)",
+				mgmt_errstr(status), status);
+		return;
+	}
+
+	DBG("Successfully set blocked keys for index %u", adapter->dev_id);
+}
+
+static bool set_blocked_keys(uint16_t index, struct btd_adapter *adapter)
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
+	return mgmt_send(mgmt_master, MGMT_OP_SET_BLOCKED_KEYS, index,
+					sizeof(buffer),	buffer,	read_info_complete, adapter, NULL);
+}
+
+
 static void index_added(uint16_t index, uint16_t length, const void *param,
 							void *user_data)
 {
@@ -8861,15 +8908,25 @@ static void index_added(uint16_t index, uint16_t length, const void *param,
 	 */
 	adapter_list = g_list_append(adapter_list, adapter);
 
-	DBG("sending read info command for index %u", index);
+	DBG("Setting blocked keys for index %u", index);
+	if (!set_blocked_keys(index, adapter)){
+		btd_error(adapter->dev_id,
+			"Failed to set blocked keys for index %u", index);
+		// TODO: Until the MGMT is ported to all kernels, this is best effort.
+	}
 
-	if (mgmt_send(mgmt_master, MGMT_OP_READ_INFO, index, 0, NULL,
-					read_info_complete, adapter, NULL) > 0)
-		return;
+	DBG("sending read info command for index %u", index);
 
-	btd_error(adapter->dev_id,
+	if (!mgmt_send(mgmt_master, MGMT_OP_READ_INFO, index, 0, NULL,
+					read_info_complete, adapter, NULL) > 0) {
+		btd_error(adapter->dev_id,
 			"Failed to read controller info for index %u", index);
+			goto unload;
+	}
+
+	return;
 
+unload:
 	adapter_list = g_list_remove(adapter_list, adapter);
 
 	btd_adapter_unref(adapter);
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

