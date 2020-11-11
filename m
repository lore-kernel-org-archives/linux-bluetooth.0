Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2820C388F9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Nov 2020 01:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CFCD20809
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Nov 2020 01:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLl4rPuB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgKLBdN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Nov 2020 20:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbgKKXG2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Nov 2020 18:06:28 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CB9C061A47
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2020 15:04:32 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id b3so1744045pls.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2020 15:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OlQzQ5QqgKmLpdDa8x/sdZPyVHoj8u2xzjyntZXMKfE=;
        b=CLl4rPuBMyNE9lQG6UA+B8oVKIYraIrbLQ3vcaUaTrQjxzjnMMm2jKagGmtEc4OiOp
         k/zyGzFODTJlhASb+G1P2MAOBoSUH4L6e9diCaWrFhg0WSXEzUBU4nFXApMS7q4VcWSr
         2qT0iE1GHtK1CdfOhgw8kXZHQNiSA3q292XuecOhQ2fj0WtLUUichgKB2GhNrjPUq8v0
         FOcph3qG6houavdvkn+RTC+hZ8mRMUB5r0TRj7fE9jdRogaytdjeYEmfIiPvWNTpPKC3
         YnjJdmG6iMwMTg6hTAVj5r8qREFZJM8IN/ukgDRuo098m4qRfMdXR5B1YYqhthq5WfRW
         I20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OlQzQ5QqgKmLpdDa8x/sdZPyVHoj8u2xzjyntZXMKfE=;
        b=EvdgO3YeZanKAg3OnYkL1/Ufe45yoiJ0u0D6gAFljyWBfUWTfYVnag8j+HG7atJ1Je
         +eHI6ZAc2Zs86iG+TfSWU1JEFlyBKRr+/51TQ0NRhQrFxHMunPSu+FYgpfy1UWsMXs/b
         bXsgu26DMTEg1muWFS23HxErzJYoWo1Og4XtHtf83Aomw76eaGChfoVaYruvvuxQgDr/
         Cx5XSbCB+7FNCBdDAg8WzdQGtOWVhwlZzXKWnksFSNLpBqbBOMiSctdx2xTghFlLSxD8
         iZDupQ6RFV2oHlvDXAXo8uy+pMIJ5Sb+EhplPPTMb0/iEp1eelg+FF36zdrChSsev7uz
         iRFA==
X-Gm-Message-State: AOAM532vaB0gXVmjQzlFRKwgWf3Q3fCaCAC8oIaSJ6JciwhW88MHX0H1
        9X/ak+mk16SBNkDCGxec0RzKk5ZJikHZBA==
X-Google-Smtp-Source: ABdhPJxfldlH8gzZ9CXFSyw5wxOevgzVJeCtjKaoCyGii2VP+7bkv+HwgwsUpeLxZyWTD/M1YQCrtQ==
X-Received: by 2002:a17:902:bc83:b029:d6:ab18:1079 with SMTP id bb3-20020a170902bc83b02900d6ab181079mr24310641plb.22.1605135871419;
        Wed, 11 Nov 2020 15:04:31 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id n27sm3867767pfq.59.2020.11.11.15.04.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 15:04:30 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 06/10] mgmt-tester: Update supported-features to not include HS
Date:   Wed, 11 Nov 2020 15:04:17 -0800
Message-Id: <20201111230421.3364932-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201111230421.3364932-1-luiz.dentz@gmail.com>
References: <20201111230421.3364932-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

High speed has been disabled by default, also since it can be enabled
this turn checks of supported-features into warnings to allow it work
even if BT_HS has been enabled in the kernel.
---
 src/shared/util.h   |   1 +
 tools/mgmt-tester.c | 196 ++++++++++++++++++++++----------------------
 2 files changed, 99 insertions(+), 98 deletions(-)

diff --git a/src/shared/util.h b/src/shared/util.h
index 8a920bc12..6fb702797 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -15,6 +15,7 @@
 #include <string.h>
 
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+#define BIT(n)  (1 << (n))
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 #define le16_to_cpu(val) (val)
diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index d8554411f..a5bfa1ce1 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -64,6 +64,23 @@ static void print_debug(const char *str, void *user_data)
 	tester_print("%s%s", prefix, str);
 }
 
+static void test_post_teardown(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	if (data->sk >= 0)
+		close(data->sk);
+
+	hciemu_unref(data->hciemu);
+	data->hciemu = NULL;
+}
+
+static void test_pre_setup_failed(void)
+{
+	test_post_teardown(NULL);
+	tester_pre_setup_failed();
+}
+
 static void read_version_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -74,7 +91,7 @@ static void read_version_callback(uint8_t status, uint16_t length,
 	tester_print("  Status: %s (0x%02x)", mgmt_errstr(status), status);
 
 	if (status || !param) {
-		tester_pre_setup_failed();
+		test_pre_setup_failed();
 		return;
 	}
 
@@ -92,11 +109,31 @@ static void read_commands_callback(uint8_t status, uint16_t length,
 	tester_print("  Status: %s (0x%02x)", mgmt_errstr(status), status);
 
 	if (status || !param) {
-		tester_pre_setup_failed();
+		test_pre_setup_failed();
 		return;
 	}
 }
 
+static bool check_settings(uint32_t supported, uint32_t expected)
+{
+	int i;
+
+	if (supported == expected)
+		return true;
+
+	for (i = 0; i < 17; i++) {
+		if (supported & BIT(i))
+			continue;
+
+		if (expected & BIT(i)) {
+			tester_warn("Expected bit %u not supported", i);
+			return false;
+		}
+	}
+
+	return true;
+}
+
 static void read_info_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -111,7 +148,7 @@ static void read_info_callback(uint8_t status, uint16_t length,
 	tester_print("  Status: %s (0x%02x)", mgmt_errstr(status), status);
 
 	if (status || !param) {
-		tester_pre_setup_failed();
+		test_pre_setup_failed();
 		return;
 	}
 
@@ -131,33 +168,43 @@ static void read_info_callback(uint8_t status, uint16_t length,
 	tester_print("  Short name: %s", rp->short_name);
 
 	if (strcmp(hciemu_get_address(data->hciemu), addr)) {
-		tester_pre_setup_failed();
+		test_pre_setup_failed();
 		return;
 	}
 
 	if (rp->version != data->expected_version) {
-		tester_pre_setup_failed();
+		tester_warn("Expected version: 0x%02x != 0x%02x",
+				rp->version, data->expected_version);
+		test_pre_setup_failed();
 		return;
 	}
 
 	if (manufacturer != data->expected_manufacturer) {
-		tester_pre_setup_failed();
+		tester_warn("Expected manufacturer: 0x%04x != 0x%04x",
+				manufacturer, data->expected_manufacturer);
+		test_pre_setup_failed();
 		return;
 	}
 
-	if (supported_settings != data->expected_supported_settings) {
-		tester_pre_setup_failed();
+	if (!check_settings(supported_settings,
+				data->expected_supported_settings)) {
+		tester_warn("Expected supported settings: 0x%08x != 0x%08x",
+				supported_settings,
+				data->expected_supported_settings);
+		test_pre_setup_failed();
 		return;
 	}
 
-	if (current_settings != data->initial_settings) {
-		tester_pre_setup_failed();
+	if (!check_settings(current_settings, data->initial_settings)) {
+		tester_warn("Initial settings: 0x%08x != 0x%08x",
+				current_settings, data->initial_settings);
+		test_pre_setup_failed();
 		return;
 	}
 
 	if (rp->dev_class[0] != 0x00 || rp->dev_class[1] != 0x00 ||
 						rp->dev_class[2] != 0x00) {
-		tester_pre_setup_failed();
+		test_pre_setup_failed();
 		return;
 	}
 
@@ -269,7 +316,7 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 	tester_print("  Status: %s (0x%02x)", mgmt_errstr(status), status);
 
 	if (status || !param) {
-		tester_pre_setup_failed();
+		test_pre_setup_failed();
 		return;
 	}
 
@@ -282,7 +329,7 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 	data->hciemu = hciemu_new(data->hciemu_type);
 	if (!data->hciemu) {
 		tester_warn("Failed to setup HCI emulation");
-		tester_pre_setup_failed();
+		test_pre_setup_failed();
 	}
 
 	if (tester_use_debug())
@@ -299,14 +346,14 @@ static void test_pre_setup(const void *test_data)
 	data->mgmt = mgmt_new_default();
 	if (!data->mgmt) {
 		tester_warn("Failed to setup management interface");
-		tester_pre_setup_failed();
+		test_pre_setup_failed();
 		return;
 	}
 
 	data->mgmt_alt = mgmt_new_default();
 	if (!data->mgmt_alt) {
 		tester_warn("Failed to setup alternate management interface");
-		tester_pre_setup_failed();
+		test_pre_setup_failed();
 
 		mgmt_unref(data->mgmt);
 		data->mgmt = NULL;
@@ -330,17 +377,6 @@ static void test_pre_setup(const void *test_data)
 	data->sk = -1;
 }
 
-static void test_post_teardown(const void *test_data)
-{
-	struct test_data *data = tester_get_data();
-
-	if (data->sk >= 0)
-		close(data->sk);
-
-	hciemu_unref(data->hciemu);
-	data->hciemu = NULL;
-}
-
 static void test_add_condition(struct test_data *data)
 {
 	data->unmet_conditions++;
@@ -382,94 +418,58 @@ static void test_condition_complete(struct test_data *data)
 	tester_test_passed();
 }
 
-#define test_bredrle_full(name, data, setup, func, timeout) \
+#define test_full(name, data, setup, func, timeout, type, version, \
+			expected_settings, settings) \
 	do { \
 		struct test_data *user; \
 		user = new0(struct test_data, 1); \
-		user->hciemu_type = HCIEMU_TYPE_BREDRLE; \
+		user->hciemu_type = type; \
 		user->test_setup = setup; \
 		user->test_data = data; \
-		user->expected_version = 0x09; \
+		user->expected_version = version; \
 		user->expected_manufacturer = 0x003f; \
-		user->expected_supported_settings = 0x0001bfff; \
-		user->initial_settings = 0x00000080; \
+		user->expected_supported_settings = expected_settings; \
+		user->initial_settings = settings; \
 		tester_add_full(name, data, \
 				test_pre_setup, test_setup, func, NULL, \
 				test_post_teardown, timeout, user, free); \
 	} while (0)
 
+#define test_bredrle_full(name, data, setup, func, timeout) \
+	test_full(name, data, setup, func, timeout, HCIEMU_TYPE_BREDRLE, \
+					0x09, 0x0001beff, 0x00000080)
+
 #define test_bredrle(name, data, setup, func) \
 	test_bredrle_full(name, data, setup, func, 2)
 
 #define test_bredr20(name, data, setup, func) \
-	do { \
-		struct test_data *user; \
-		user = new0(struct test_data, 1); \
-		user->hciemu_type = HCIEMU_TYPE_LEGACY; \
-		user->test_setup = setup; \
-		user->test_data = data; \
-		user->expected_version = 0x03; \
-		user->expected_manufacturer = 0x003f; \
-		user->expected_supported_settings = 0x000110bf; \
-		user->initial_settings = 0x00000080; \
-		tester_add_full(name, data, \
-				test_pre_setup, test_setup, func, NULL, \
-				test_post_teardown, 2, user, free); \
-	} while (0)
+	test_full(name, data, setup, func, 2, HCIEMU_TYPE_LEGACY, \
+					0x03, 0x000110bf, 0x00000080)
 
 #define test_bredr(name, data, setup, func) \
-	do { \
-		struct test_data *user; \
-		user = new0(struct test_data, 1); \
-		user->hciemu_type = HCIEMU_TYPE_BREDR; \
-		user->test_setup = setup; \
-		user->test_data = data; \
-		user->expected_version = 0x05; \
-		user->expected_manufacturer = 0x003f; \
-		user->expected_supported_settings = 0x000111ff; \
-		user->initial_settings = 0x00000080; \
-		tester_add_full(name, data, \
-				test_pre_setup, test_setup, func, NULL, \
-				test_post_teardown, 2, user, free); \
-	} while (0)
+	test_full(name, data, setup, func, 2, HCIEMU_TYPE_BREDR, \
+					0x05, 0x000110ff, 0x00000080)
 
 #define test_le_full(name, data, setup, func, timeout) \
-	do { \
-		struct test_data *user; \
-		user = new0(struct test_data, 1); \
-		user->hciemu_type = HCIEMU_TYPE_LE; \
-		user->test_setup = setup; \
-		user->test_data = data; \
-		user->expected_version = 0x09; \
-		user->expected_manufacturer = 0x003f; \
-		user->expected_supported_settings = 0x0001be1b; \
-		user->initial_settings = 0x00000200; \
-		tester_add_full(name, data, \
-				test_pre_setup, test_setup, func, NULL, \
-				test_post_teardown, timeout, user, free); \
-	} while (0)
+	test_full(name, data, setup, func, timeout, HCIEMU_TYPE_LE, \
+					0x09, 0x0001be1b, 0x00000200)
 
 #define test_le(name, data, setup, func) \
 	test_le_full(name, data, setup, func, 2)
 
 #define test_bredrle50_full(name, data, setup, func, timeout) \
-	do { \
-		struct test_data *user; \
-		user = new0(struct test_data, 1); \
-		user->hciemu_type = HCIEMU_TYPE_BREDRLE50; \
-		user->test_setup = setup; \
-		user->test_data = data; \
-		user->expected_version = 0x09; \
-		user->expected_manufacturer = 0x003f; \
-		user->expected_supported_settings = 0x0001bfff; \
-		user->initial_settings = 0x00000080; \
-		tester_add_full(name, data, \
-				test_pre_setup, test_setup, func, NULL, \
-				test_post_teardown, timeout, user, free); \
-	} while (0)
+	test_full(name, data, setup, func, timeout, HCIEMU_TYPE_BREDRLE50, \
+					0x09, 0x0001beff, 0x00000080)
 
 #define test_bredrle50(name, data, setup, func) \
-			test_bredrle50_full(name, data, setup, func, 2)
+	test_bredrle50_full(name, data, setup, func, 2)
+
+#define test_hs_full(name, data, setup, func, timeout) \
+	test_full(name, data, setup, func, timeout, HCIEMU_TYPE_BREDRLE, \
+					0x09, 0x0001bfff, 0x00000080)
+
+#define test_hs(name, data, setup, func) \
+	test_hs_full(name, data, setup, func, 2)
 
 static void controller_setup(const void *test_data)
 {
@@ -5069,7 +5069,7 @@ static const char ext_ctrl_info1[] = {
 	0x00, 0x00, 0x00, 0x01, 0xaa, 0x00, /* btaddr */
 	0x09, /* version */
 	0x3f, 0x00, /* manufacturer */
-	0xff, 0xbf, 0x01, 0x00, /* supported settings */
+	0xff, 0xbe, 0x01, 0x00, /* supported settings */
 	0x80, 0x00, 0x00, 0x00, /* current settings */
 	0x09, 0x00, /* eir length */
 	0x04, /* dev class length */
@@ -5114,7 +5114,7 @@ static const char ext_ctrl_info2[] = {
 	0x00, 0x00, 0x00, 0x01, 0xaa, 0x00, /* btaddr */
 	0x09, /* version */
 	0x3f, 0x00, /* manufacturer */
-	0xff, 0xbf, 0x01, 0x00, /* supported settings */
+	0xff, 0xbe, 0x01, 0x00, /* supported settings */
 	0x81, 0x02, 0x00, 0x00, /* current settings */
 	0x0D, 0x00, /* eir length */
 	0x04, /* dev class length */
@@ -5145,7 +5145,7 @@ static const char ext_ctrl_info3[] = {
 	0x00, 0x00, 0x00, 0x01, 0xaa, 0x00, /* btaddr */
 	0x09, /* version */
 	0x3f, 0x00, /* manufacturer */
-	0xff, 0xbf, 0x01, 0x00, /* supported settings */
+	0xff, 0xbe, 0x01, 0x00, /* supported settings */
 	0x80, 0x02, 0x00, 0x00, /* current settings */
 	0x16, 0x00, /* eir length */
 	0x04, /* dev class length */
@@ -5180,7 +5180,7 @@ static const char ext_ctrl_info4[] = {
 	0x00, 0x00, 0x00, 0x01, 0xaa, 0x00, /* btaddr */
 	0x09, /* version */
 	0x3f, 0x00, /* manufacturer */
-	0xff, 0xbf, 0x01, 0x00, /* supported settings */
+	0xff, 0xbe, 0x01, 0x00, /* supported settings */
 	0x80, 0x02, 0x00, 0x00, /* current settings */
 	0x1a, 0x00, /* eir length */
 	0x04, /* dev class length */
@@ -5239,7 +5239,7 @@ static const char ext_ctrl_info5[] = {
 	0x00, 0x00, 0x00, 0x01, 0xaa, 0x00, /* btaddr */
 	0x09, /* version */
 	0x3f, 0x00, /* manufacturer */
-	0xff, 0xbf, 0x01, 0x00, /* supported settings */
+	0xff, 0xbe, 0x01, 0x00, /* supported settings */
 	0x81, 0x02, 0x00, 0x00, /* current settings */
 	0x1a, 0x00, /* eir len */
 	0x04, /* dev class len */
@@ -9080,19 +9080,19 @@ int main(int argc, char *argv[])
 				&set_sc_only_on_success_test_2,
 				NULL, test_command_generic);
 
-	test_bredrle("Set High Speed on - Success",
+	test_hs("Set High Speed on - Success",
 				&set_hs_on_success_test,
 				NULL, test_command_generic);
-	test_bredrle("Set High Speed on - Invalid parameters 1",
+	test_hs("Set High Speed on - Invalid parameters 1",
 				&set_hs_on_invalid_param_test_1,
 				NULL, test_command_generic);
-	test_bredrle("Set High Speed on - Invalid parameters 2",
+	test_hs("Set High Speed on - Invalid parameters 2",
 				&set_hs_on_invalid_param_test_2,
 				NULL, test_command_generic);
-	test_bredrle("Set High Speed on - Invalid parameters 3",
+	test_hs("Set High Speed on - Invalid parameters 3",
 				&set_hs_on_invalid_param_test_3,
 				NULL, test_command_generic);
-	test_bredrle("Set High Speed on - Invalid index",
+	test_hs("Set High Speed on - Invalid index",
 				&set_hs_on_invalid_index_test,
 				NULL, test_command_generic);
 
-- 
2.26.2

