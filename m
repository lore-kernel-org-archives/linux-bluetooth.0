Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C8FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 01:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9CD4610C8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 01:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbhKSBOQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Nov 2021 20:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbhKSBOQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Nov 2021 20:14:16 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A79C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Nov 2021 17:11:15 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id o6-20020a17090a0a0600b001a64b9a11aeso7399271pjo.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Nov 2021 17:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i8+3wMG6jjGrnMrw6vtbwn7IFvqWd4bYBuWAqUneFsw=;
        b=I7XeLGJyj39Q3cIEg9zUoHbuqKIMABtHuq6394ynvBcL3j6pcSgQdI9REvGjknKwt8
         ejV9KhR6J+glMEpl9U7ikSlrlriP5QE7sBhDn0YrUqk45HRZErCIUQChOvaUDsKsJ8tb
         3AQaAPvUdVXrBjxFyW8d27f8iovDz+i7sF7RPWiaA550vgWHgoPZwnNYJEYnJI2Rdc5M
         0kfiTygKe7qeAidsel0XKT9icTerJy48DIb9cpTJ99j/oAZDVTtZL3KM3QCKFedFVYPw
         jn1jvZysraK9n/a6gpcSU3tl5ZB2ExWo+RvoY7APcrV+3ExKxXGLEqtH2ORwAcVpAhi2
         iQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i8+3wMG6jjGrnMrw6vtbwn7IFvqWd4bYBuWAqUneFsw=;
        b=wHLMb2vdO79m8jn/nYW4/VzUKtrqzYZ5C+SofYW1E62wDudpFcLzJVAai3VTFuRXBG
         tEVVEV4f3UyaOR3b5Y3aaG0J7LlDIVNjqNcc/ltW+9mtpA6/v1g5Th68+9tSDeqKVtmu
         2ZlxEasPPsBgt66IdMxVatXsewFy2trjT3hcSDt836zlaadzKnfrNVuu0eFqDzqswIOJ
         mpHnN+vfL78C5FWc8274fxDl8emIJ5+IPtAGmREN7CqPo3fLB7CYjNkzwb7ixieYwDI5
         51rGoKJj7iKhZF+087Efe+GVDyjX8IPHNugYPfHZiXLfTxIHwxeUoJ0IW8asWK1yisvn
         om1A==
X-Gm-Message-State: AOAM530VhNmxNjoek8MEgsJ0EC6kN+QdXCBpTqYqM4Hhj3Nv305bhxCa
        sPeRBDNjLyNDhQ0uAjwS9s8+Xhz6xQc=
X-Google-Smtp-Source: ABdhPJzXxvb7ATd+VxBL7N4LYSYjnvwgz//SmHMK2IcWd+ne9sPf09ZVNNVwkUu8W6nne643kGnVYw==
X-Received: by 2002:a17:90b:4c0f:: with SMTP id na15mr15720543pjb.222.1637284274896;
        Thu, 18 Nov 2021 17:11:14 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id cv1sm9018755pjb.48.2021.11.18.17.11.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 17:11:14 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mgmt-tester: Fix Get Device Flags tests
Date:   Thu, 18 Nov 2021 17:11:13 -0800
Message-Id: <20211119011113.1033964-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

With series
https://patchwork.kernel.org/project/bluetooth/list/?series=582749 Wake
up flag is properly check so force_wakeup must be set in order to have
the wakeup flag as supported.
---
 tools/mgmt-tester.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index e5319d123..fbb6dd62d 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -10616,7 +10616,7 @@ static const struct hci_cmd_data ll_privacy_set_device_flags_1_hci_list[] = {
 static const uint8_t device_flags_changed_params_1[] = {
 	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* BDADDR */
 	0x01,					/* Type - LE Public */
-	0x03, 0x00, 0x00, 0x00,			/* Supported Flags */
+	0x02, 0x00, 0x00, 0x00,			/* Supported Flags */
 	0x02, 0x00, 0x00, 0x00			/* Current Flags */
 };
 
@@ -11295,6 +11295,23 @@ static void check_scan(void *user_data)
 	test_condition_complete(data);
 }
 
+static void test_device_flags(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	struct vhci *vhci = hciemu_get_vhci(data->hciemu);
+	int err;
+
+	/* Set Force Wakeup */
+	err = vhci_set_force_wakeup(vhci, true);
+	if (err) {
+		tester_warn("Unable to enable the force_wakeup");
+		tester_test_failed();
+		return;
+	}
+
+	test_command_generic(test_data);
+}
+
 static void test_remove_device(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -14038,7 +14055,7 @@ int main(int argc, char *argv[])
 	test_bredrle50("Get Device Flags - Success",
 				&get_dev_flags_success,
 				setup_get_dev_flags,
-				test_command_generic);
+				test_device_flags);
 
 	/* MGMT_OP_GET_DEVICE_FLAGS
 	 * Fail - Invalid parameter
@@ -14046,7 +14063,7 @@ int main(int argc, char *argv[])
 	test_bredrle50("Get Device Flags - Invalid Parameter",
 				&get_dev_flags_fail_1,
 				setup_get_dev_flags,
-				test_command_generic);
+				test_device_flags);
 
 	/* MGMT_OP_SET_DEVICE_FLAGS
 	 * Success
@@ -14054,7 +14071,7 @@ int main(int argc, char *argv[])
 	test_bredrle50("Set Device Flags - Success",
 				&set_dev_flags_success,
 				setup_get_dev_flags,
-				test_command_generic);
+				test_device_flags);
 
 	/* MGMT_OP_SET_DEVICE_FLAGS
 	 * Invalid Parameter - Missing parameter
@@ -14062,7 +14079,7 @@ int main(int argc, char *argv[])
 	test_bredrle50("Set Device Flags - Invalid Parameter 1",
 				&set_dev_flags_fail_1,
 				setup_get_dev_flags,
-				test_command_generic);
+				test_device_flags);
 
 	/* MGMT_OP_SET_DEVICE_FLAGS
 	 * Invalid Parameter - Not supported value
@@ -14070,7 +14087,7 @@ int main(int argc, char *argv[])
 	test_bredrle50("Set Device Flags - Invalid Parameter 2",
 				&set_dev_flags_fail_2,
 				setup_get_dev_flags,
-				test_command_generic);
+				test_device_flags);
 
 	/* MGMT_OP_SET_DEVICE_FLAGS
 	 * Device not exist
@@ -14078,7 +14095,7 @@ int main(int argc, char *argv[])
 	test_bredrle50("Set Device Flags - Device not found",
 				&set_dev_flags_fail_3,
 				setup_get_dev_flags,
-				test_command_generic);
+				test_device_flags);
 
 	/* Suspend/Resume
 	 * Setup : Power on and register Suspend Event
-- 
2.33.1

