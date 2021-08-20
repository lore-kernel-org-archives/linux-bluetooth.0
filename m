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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73559C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Aug 2021 04:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52F7B61004
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Aug 2021 04:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbhHTE5b (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Aug 2021 00:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbhHTE5b (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Aug 2021 00:57:31 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A124C061575
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Aug 2021 21:56:54 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so13018876pjr.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Aug 2021 21:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6tw02PyrxvO/DwhHU4sLaJ9eR7/inZjCudZ75oz8OYM=;
        b=I6K1ljeDL6oDfD2Ak+ciC/kupG6YUGKTm3b1k0gEyxro5BcgM4TtRdAeW+ZICd3fIv
         Vj4LEMS2I23Z7jrbDzMfpEUXYxuVp2Qr0aR2iVbAo69YOiI8CfaE/qC0bc+62j8JZpxM
         7YqcSYOfp9ph2lkheIjTAhlbMwZzxDH2UXbvD+zD/QtfVH6NNe4n9xVgFdbX4NA0T+ty
         Yo+uksotoG7vM30WhAuAelUK6knVyjvEgVSIp5YKWHampdx+hmnN5/RXyHYCUzXNZMT8
         /YXHhFs3fzY+0E91w2mXlECUN5BOEcK+Ew6caW74wWVY3WcxK/OGN6Cb+C4VWeFbSwqL
         eqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6tw02PyrxvO/DwhHU4sLaJ9eR7/inZjCudZ75oz8OYM=;
        b=UcGIfjX7cRMhtaZgwRAvVEk3Vii8Zrtpe13ExXlqhOkBCtFHqi7u97K+LfiW4gJ1oS
         SYHR5N6LnE/DhGXvTzUI/rmZLOuozaMyoL6Z+Eqw2zPhNJwMPTCMjYd/hvWno8J/J3tg
         BkY3MBBQQZCwnvk9auVxqHpp+bzZLRJY3nSjt/DieDJQRQlmmDCUHTDxoNfzZ9Y0ANvr
         mtcHW7XCr6grsviLGLWaig1bifllvnqB/9o7rJWfHkTkSNlNFfU1O6tcjurSpuKAP4ml
         RNk1vqKl9F/4JyXKqqAB1tIWXLXAuDL1c6CUKrC5TM3L5KVu1bkat2MiSuSlkT6Os4Ir
         IiSQ==
X-Gm-Message-State: AOAM530yba5uJpBIVQ3rGnWnJcbeydRPvXrBJuZxwIY3CFvDES7SRPC0
        wfNkQofTLLx8FNaMxh1JJsN3ekSletY=
X-Google-Smtp-Source: ABdhPJxQ9hKujVtkQXvJuPF6D6NzMtkL3nO17KJXdKMq/B2vO97C9m5WfGl19mEoTeqWDXpX/wPqSw==
X-Received: by 2002:a17:90a:5305:: with SMTP id x5mr2574651pjh.135.1629435413514;
        Thu, 19 Aug 2021 21:56:53 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:4f24:11af:6492:3c2b])
        by smtp.gmail.com with ESMTPSA id j5sm10300971pjv.56.2021.08.19.21.56.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 21:56:53 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH] tools: userchan-tester: Add test case for the closing channel
Date:   Thu, 19 Aug 2021 21:56:52 -0700
Message-Id: <20210820045652.69761-1-hj.tedd.an@gmail.com>
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
 tools/userchan-tester.c | 70 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tools/userchan-tester.c b/tools/userchan-tester.c
index c17644fb8..ab95c0044 100644
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
@@ -291,6 +295,69 @@ static void test_open_failed(const void *test_data)
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
+
+	if (!(current_settings & MGMT_SETTING_POWERED)) {
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
@@ -316,6 +383,9 @@ int main(int argc, char *argv[])
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

