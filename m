Return-Path: <SRS0=I8IU=AS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD1EC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 02:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 350D2206E2
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 02:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XqI44sTl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgGGCT0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Jul 2020 22:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgGGCT0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Jul 2020 22:19:26 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564C8C061755
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jul 2020 19:19:26 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id v1so21698351vsb.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2020 19:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fXlDVwOK9y2sRda2nGIuhcRuMpsLxZNBuUuDCTcE2Uk=;
        b=XqI44sTllruhD3zy/xvdUWl2f7aJPJne1DfyUdUbL1MxiAQJS9woTQ67PnHrvldesw
         LKr1TDtKG9MCMXg1TKjXQ7DjWQlBINXDGXvsvYonss9vDl9yqerCBFWRwl+xwpVWyhVf
         KhEkPujx2Uuf2vrZ5XzbDmlqZPhyAOMK5S07Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fXlDVwOK9y2sRda2nGIuhcRuMpsLxZNBuUuDCTcE2Uk=;
        b=pGKMCVDdRVBokVDeDePuj6uNPoaXFYPEaoI+ISJgyOkC/CkYpNys1/JnfQ4jzjXdnD
         bE8KKW/WPVTPkWdI4sFeMT49C33UpOVvQMcYkQBr0cHqNngVOXChcizzIeFo8l8rvdtP
         FtLukQYQ3iWb7d0ShYJ+1XeoeZWXmEtlsg9R/pfAmPD5Hd6iVQwzRmj6CXIfkkJ79ppJ
         ILH4ziX+V/SXmEmXjNTIFVRC9zsOcwU5P9zMefazdJVy07kxNh9vqm3UDHt1RKSfk+fN
         K7I7l/WhV9C5C2GRU37dLXuO8tdOqXMm93LahaCuPwYgdHZIPcZ5eQ2ERDvbysgKznRo
         zIPg==
X-Gm-Message-State: AOAM530f5dNrOsYZGcY/VylngYSP2TaYMWCWCI3tbrrDZ/MpC3ASqe5G
        v7vCqQlmCqsBDgEJrmH6S3ueb/b+ATM=
X-Google-Smtp-Source: ABdhPJzdoL9gbR78xJ64mxmGHylXLShpoitfalka4xzYvWlINC/4cOgKTz9Lk2s9h/3mZMDXtA4uGg==
X-Received: by 2002:a67:7d50:: with SMTP id y77mr37509155vsc.66.1594088364876;
        Mon, 06 Jul 2020 19:19:24 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id q200sm4855727vke.53.2020.07.06.19.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 19:19:24 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [BlueZ PATCH 1/2] adapter: add support for the Roles property
Date:   Tue,  7 Jul 2020 02:19:18 +0000
Message-Id: <20200707021920.209213-1-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds support for the Roles property as defined in
adapter-api.txt.

---

 src/adapter.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 9ce351893..7afd6980c 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -122,6 +122,8 @@ static bool kernel_blocked_keys_supported = false;
 
 static bool kernel_set_system_config = false;
 
+static bool kernel_exp_features = false;
+
 static GList *adapter_list = NULL;
 static unsigned int adapter_remaining = 0;
 static bool powering_down = false;
@@ -293,6 +295,8 @@ struct btd_adapter {
 	unsigned int db_id;		/* Service event handler for GATT db */
 
 	bool is_default;		/* true if adapter is default one */
+
+	bool le_simult_roles_supported;
 };
 
 typedef enum {
@@ -3199,6 +3203,35 @@ static gboolean property_get_modalias(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean property_get_roles(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	DBusMessageIter entry;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_STRING_AS_STRING, &entry);
+
+	if (adapter->supported_settings & MGMT_SETTING_LE) {
+		const char *str = "central";
+		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &str);
+	}
+
+	if (adapter->supported_settings & MGMT_SETTING_ADVERTISING) {
+		const char *str = "peripheral";
+		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &str);
+	}
+
+	if (adapter->le_simult_roles_supported) {
+		const char *str = "central-peripheral";
+		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &str);
+	}
+
+	dbus_message_iter_close_container(iter, &entry);
+
+	return TRUE;
+}
+
 static int device_path_cmp(gconstpointer a, gconstpointer b)
 {
 	const struct btd_device *device = a;
@@ -3479,6 +3512,7 @@ static const GDBusPropertyTable adapter_properties[] = {
 	{ "UUIDs", "as", property_get_uuids },
 	{ "Modalias", "s", property_get_modalias, NULL,
 					property_exists_modalias },
+	{ "Roles", "as", property_get_roles },
 	{ }
 };
 
@@ -9023,6 +9057,56 @@ static bool set_blocked_keys(struct btd_adapter *adapter)
 						adapter, NULL);
 }
 
+static void read_exp_features_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	const struct mgmt_rp_read_exp_features_info *rp = param;
+	size_t feature_count = 0;
+	size_t i = 0;
+
+	DBG("index %u status 0x%02x", adapter->dev_id, status);
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		btd_error(adapter->dev_id,
+				"Failed to read exp features info: %s (0x%02x)",
+				mgmt_errstr(status), status);
+		return;
+	}
+
+	if (length < sizeof(*rp)) {
+		btd_error(adapter->dev_id, "Response too small");
+		return;
+	}
+
+	feature_count = le16_to_cpu(rp->feature_count);
+	for (i = 0; i < feature_count; ++i) {
+
+		/* 671b10b5-42c0-4696-9227-eb28d1b049d6 */
+		static const uint8_t le_simult_central_peripheral[16] = {
+			0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb, 0x27, 0x92,
+			0x96, 0x46, 0xc0, 0x42, 0xb5, 0x10, 0x1b, 0x67,
+		};
+
+		if (memcmp(rp->features[i].uuid, le_simult_central_peripheral,
+				sizeof(le_simult_central_peripheral)) == 0) {
+			uint32_t flags = le32_to_cpu(rp->features[i].flags);
+
+			adapter->le_simult_roles_supported = flags & 0x01;
+		}
+	}
+}
+
+static void read_exp_features(struct btd_adapter *adapter)
+{
+	if (mgmt_send(adapter->mgmt, MGMT_OP_READ_EXP_FEATURES_INFO,
+			adapter->dev_id, 0, NULL, read_exp_features_complete,
+			adapter, NULL) > 0)
+		return;
+
+	btd_error(adapter->dev_id, "Failed to read exp features info");
+}
+
 static void read_info_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -9132,6 +9216,9 @@ static void read_info_complete(uint8_t status, uint16_t length,
 			(missing_settings & MGMT_SETTING_FAST_CONNECTABLE))
 		set_mode(adapter, MGMT_OP_SET_FAST_CONNECTABLE, 0x01);
 
+	if (kernel_exp_features)
+		read_exp_features(adapter);
+
 	err = adapter_register(adapter);
 	if (err < 0) {
 		btd_error(adapter->dev_id, "Unable to register new adapter");
@@ -9447,6 +9534,10 @@ static void read_commands_complete(uint8_t status, uint16_t length,
 			DBG("kernel supports set system confic");
 			kernel_set_system_config = true;
 			break;
+		case MGMT_OP_READ_EXP_FEATURES_INFO:
+			DBG("kernel supports exp features");
+			kernel_exp_features = true;
+			break;
 		default:
 			break;
 		}
-- 
2.27.0.212.ge8ba1cc988-goog

