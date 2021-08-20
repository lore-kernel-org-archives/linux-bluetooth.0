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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5E3C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Aug 2021 05:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DB9561029
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Aug 2021 05:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbhHTFHp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Aug 2021 01:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhHTFHp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Aug 2021 01:07:45 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38497C061575
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Aug 2021 22:07:08 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id hv22-20020a17090ae416b0290178c579e424so6442174pjb.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Aug 2021 22:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GHz2HSS5eMLDkFyaQYXEJuHIA7RR+Oj/OlhCx11WXow=;
        b=eVdiWRaVehrCQ6HRZ/YyMkb5TcO2FbOwzjKeD8DI7epKLCv2SZpedppiIm9Iyvz3hb
         Y0vPWw2b6Odf8c7KfvfZM6ERP7Z0XSt3mWoY/91l+ycAEBwcY9gl5PObPBCdbJTeXtGH
         Suv25Vip+1uJnh5FWr13blfVjeDDHdcrmnoxiomYswFs7QuCNZ+9Q4TO16/Te1hw8oV6
         GnY2uq4mzw2AS7zSXPTBalSIycCe3c9pPVicebl6lGRqDTNyCfZfKQfAZ2ZFIHppvGpM
         y8FaJbz9n6rsHFnxpcKrkXeNE5lh/GA098QX0k4KbJ9ZemiEs9LuUYXn+9RSB9zr/1Dy
         ViBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GHz2HSS5eMLDkFyaQYXEJuHIA7RR+Oj/OlhCx11WXow=;
        b=Yeq95CLn2HPVP7z8ggXLTRNbtmo+gz1xWFVA5HI7APpLpWy4dZTMpOFSRyFSADQ8Tu
         8VFCL10a1vvGRsV8m0QDLNwAs0tMa3cHjHTlc9HSexJeei4ap7tKuNBx7xj6JNvS954l
         Ynah8yAZDp6FKD+TwfWrWpFWije2+XDIFy/IZZi48FaWx8p6koQaCOhsPhU337SALj29
         Q33pLzjrpTNlaZQfb15bP9N5D2CU9Q7OQPhd6qvR137cRmvAHofQaShHaYYo3/cySB9P
         1vJ6FsA6FIR68Dd99n8Te6BE1g3GSrqxGAN7n0Jb4V3fNksYJ1vWI2IHJrJY5eS8Xx1l
         KF3A==
X-Gm-Message-State: AOAM5325nNOlfHPGkxNiycQ3zkH8MO3rbevn4RdZFuZAztDRFZGfSN9/
        3qcNiiNM++XP7+4/BQ16ZH3Bf7X41Uo=
X-Google-Smtp-Source: ABdhPJxK1DmNORBQL2Lj8PR8gUiNGwANIU0uf513Ew3DUNbJ/UiXX8P2jT6UquMIQxzYjYtzJKb70A==
X-Received: by 2002:a17:90b:93:: with SMTP id bb19mr2704405pjb.224.1629436027276;
        Thu, 19 Aug 2021 22:07:07 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:4f24:11af:6492:3c2b])
        by smtp.gmail.com with ESMTPSA id n1sm6302075pgt.63.2021.08.19.22.07.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 22:07:06 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH] tools: userchan-tester: Add test case for the closing channel
Date:   Thu, 19 Aug 2021 22:07:05 -0700
Message-Id: <20210820050705.76853-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds a test casse for checking the controller power state
after closing the user channel.

When the user channel is closed, the controller should be powered down
state.
---
 tools/userchan-tester.c | 69 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/tools/userchan-tester.c b/tools/userchan-tester.c
index c17644fb8..095ef2689 100644
--- a/tools/userchan-tester.c
+++ b/tools/userchan-tester.c
@@ -40,6 +40,8 @@ struct test_data {
 	enum hciemu_type hciemu_type;
 	const void *test_data;
 	unsigned int remove_id;
+	struct bt_hci *hci;
+	uint32_t current_settings;
 };
 
 static void mgmt_debug(const char *str, void *user_data)
@@ -81,6 +83,8 @@ static void read_info_callback(uint8_t status, uint16_t length,
 	tester_print("  Name: %s", rp->name);
 	tester_print("  Short name: %s", rp->short_name);
 
+	data->current_settings = current_settings;
+
 	if (strcmp(hciemu_get_address(data->hciemu), addr)) {
 		tester_pre_setup_failed();
 		return;
@@ -291,6 +295,68 @@ static void test_open_failed(const void *test_data)
 	tester_test_failed();
 }
 
+static void close_read_info_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	const struct mgmt_rp_read_info *rp = param;
+	uint32_t current_settings;
+
+	tester_print("Read Info callback");
+	tester_print("  Status: 0x%02x", status);
+
+	if (status || !param) {
+		tester_test_failed();
+		return;
+	}
+
+	current_settings = btohl(rp->current_settings);
+	if (current_settings & MGMT_SETTING_POWERED) {
+		tester_print("Controller is powered");
+		tester_test_failed();
+		return;
+	}
+
+	tester_test_passed();
+}
+
+static void setup_channel_open(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	/* Check power off */
+	if (data->current_settings & MGMT_SETTING_POWERED) {
+		tester_print("Controller is powered");
+		tester_setup_failed();
+		return;
+	}
+
+	/* Open Channel */
+	data->hci = bt_hci_new_user_channel(data->mgmt_index);
+	if (!data->hci) {
+		mgmt_unregister(data->mgmt, data->remove_id);
+		data->remove_id = 0;
+
+		tester_setup_failed();
+		return;
+	}
+
+	tester_print("User Channel Opened");
+
+	tester_setup_complete();
+}
+
+static void test_close_success(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	tester_print("Close User Channel");
+	bt_hci_unref(data->hci);
+
+	/* Check if power is off */
+	mgmt_send(data->mgmt, MGMT_OP_READ_INFO, data->mgmt_index, 0, NULL,
+					close_read_info_callback, NULL, NULL);
+}
+
 #define test_user(name, data, setup, func) \
 	do { \
 		struct test_data *user; \
@@ -316,6 +382,9 @@ int main(int argc, char *argv[])
 					setup_powered, test_open_failed);
 	test_user("User channel open - Power Toggle Success", INT_TO_PTR(true),
 					toggle_powered, test_open_success);
+	test_user("User channel close - Success", NULL,
+					setup_channel_open, test_close_success);
+
 
 	return tester_run();
 }
-- 
2.25.1

