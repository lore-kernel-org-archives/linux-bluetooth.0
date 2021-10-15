Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE701C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Oct 2021 05:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D120D611C8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Oct 2021 05:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235387AbhJOFLo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Oct 2021 01:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235378AbhJOFLn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Oct 2021 01:11:43 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD1CC061570
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Oct 2021 22:09:38 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 66so7533029pgc.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Oct 2021 22:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7jSvX/2lkJhnWssrWZfWRoyVD0LYUZfMi2FYpBtiMQ4=;
        b=MsTBebBVZClfaTKrpXmh65GzXNQwCk7mBh5PpCtkTT2k4upr124Ohrp8myQ42ugpWK
         X4R0Bfmm8YyHp3rDddEled7/NehBtU+ckBabR7u/MJoqbIcKx6KW0kZr+rGNvMTikRbZ
         CNw7rYYMCBvw8EcRpRoWXO2lNmbTaEL4SOcYa8nFoYCkHMEd9Fmxq47a+w49rd34lAeB
         fEWd026YIaGgwZ4cwOI2OXcVfM92u8Pu0k/sQYc+xybsuSkBMLtS1/TSf+tuLOB1+9B4
         0Y3qRYRShSbXRa8yf6iYWgIHXHJJTwbalVh/ybWRjbXtsHOQhbY4wySxwSX56HW9EQzI
         +xRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7jSvX/2lkJhnWssrWZfWRoyVD0LYUZfMi2FYpBtiMQ4=;
        b=4MAjKkYj19ceGfSKW9exVZGywzgtTERnEr2HMS2tECzJRmVN2rxUQKIxbDNw8g3zpw
         tzgrpRAic+N6mvagffVsxgH+ubXqPgbXk52tL5OctbfZ3eGJc10jTuhpUcu2v4ewSok0
         +Bc6r9K/lWv4dzBButlTK8gJ7JXW9rIGp7197nFxvpiyBfQ6mfP6+bi29sAyUC4+puJO
         hGmDXm14LUT87l1EvKRNPsDl4JhbSgG9TDNfrjVbPK/p2xrhediADT/cOnBIZwQ1rIb2
         WUBzxukLkYJDUyUayYbjFqg775R78kfBiciRWKVH05rDcCXWXrjCysLWNENeA3P1sgh0
         IIhA==
X-Gm-Message-State: AOAM531mbrbKUTGWf/q8Mcs+O+4lWMB84bl0jCgCe36M0x0wNrpNBf5s
        vYjI9bARSHhrxfuuOAPkUwSyuFVNrWg=
X-Google-Smtp-Source: ABdhPJy8mNpCWpEGt8rAa8DH2kTUr33NiZLpyb7m9+lEF/952oiOjZX0urB+1saPFgBEgmNI2E6VxA==
X-Received: by 2002:a63:1d53:: with SMTP id d19mr7391339pgm.85.1634274577326;
        Thu, 14 Oct 2021 22:09:37 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p17sm10347510pju.34.2021.10.14.22.09.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 22:09:36 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 7/7] mgmt-tester: Make use of vhci_set_force_suspend/vhci_set_force_wakeup
Date:   Thu, 14 Oct 2021 22:09:29 -0700
Message-Id: <20211015050929.3130100-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211015050929.3130100-1-luiz.dentz@gmail.com>
References: <20211015050929.3130100-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This replaces the direct setting debugfs to use vhci instance which
properly stores the controller index so it can be used even if there
are real controllers in the system.
---
 emulator/hciemu.c   |   8 ++++
 emulator/hciemu.h   |   1 +
 tools/mgmt-tester.c | 105 ++++++++++----------------------------------
 3 files changed, 33 insertions(+), 81 deletions(-)

diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index 3557efc93..4752c8a4d 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -234,6 +234,14 @@ static bool create_vhci(struct hciemu *hciemu)
 	return true;
 }
 
+struct vhci *hciemu_get_vhci(struct hciemu *hciemu)
+{
+	if (!hciemu)
+		return NULL;
+
+	return hciemu->vhci;
+}
+
 struct hciemu_client *hciemu_get_client(struct hciemu *hciemu, int num)
 {
 	const struct queue_entry *entry;
diff --git a/emulator/hciemu.h b/emulator/hciemu.h
index 3d3d93b4b..338fa844d 100644
--- a/emulator/hciemu.h
+++ b/emulator/hciemu.h
@@ -45,6 +45,7 @@ typedef void (*hciemu_destroy_func_t)(void *user_data);
 bool hciemu_set_debug(struct hciemu *hciemu, hciemu_debug_func_t callback,
 			void *user_data, hciemu_destroy_func_t destroy);
 
+struct vhci *hciemu_get_vhci(struct hciemu *hciemu);
 struct bthost *hciemu_client_get_host(struct hciemu *hciemu);
 
 const char *hciemu_get_address(struct hciemu *hciemu);
diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 8bddf6b03..62218b431 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -30,6 +30,7 @@
 #include "lib/l2cap.h"
 
 #include "monitor/bt.h"
+#include "emulator/vhci.h"
 #include "emulator/bthost.h"
 #include "emulator/hciemu.h"
 
@@ -313,62 +314,6 @@ struct generic_data {
 	uint8_t adv_data_len;
 };
 
-static int set_debugfs_force_suspend(int index, bool enable)
-{
-	int fd, n, err;
-	char val, path[64];
-
-	err = 0;
-
-	/* path for the debugfs file
-	 * /sys/kernel/debug/bluetooth/hciX/force_suspend
-	 */
-	memset(path, 0, sizeof(path));
-	sprintf(path, "/sys/kernel/debug/bluetooth/hci%d/force_suspend", index);
-
-	fd = open(path, O_RDWR);
-	if (fd < 0)
-		return -errno;
-
-	val = (enable) ? 'Y' : 'N';
-
-	n = write(fd, &val, sizeof(val));
-	if (n < (ssize_t) sizeof(val))
-		err = -errno;
-
-	close(fd);
-
-	return err;
-}
-
-static int set_debugfs_force_wakeup(int index, bool enable)
-{
-	int fd, n, err;
-	char val, path[64];
-
-	err = 0;
-
-	/* path for the debugfs file
-	 * /sys/kernel/debug/bluetooth/hciX/force_suspend
-	 */
-	memset(path, 0, sizeof(path));
-	sprintf(path, "/sys/kernel/debug/bluetooth/hci%d/force_wakeup", index);
-
-	fd = open(path, O_RDWR);
-	if (fd < 0)
-		return -errno;
-
-	val = (enable) ? 'Y' : 'N';
-
-	n = write(fd, &val, sizeof(val));
-	if (n < (ssize_t) sizeof(val))
-		err = -errno;
-
-	close(fd);
-
-	return err;
-}
-
 static const uint8_t set_exp_feat_param_debug[] = {
 	0x1c, 0xda, 0x47, 0x1c, 0x48, 0x6c, 0x01, 0xab, /* UUID - Debug */
 	0x9f, 0x46, 0xec, 0xb9, 0x30, 0x25, 0x99, 0xd4,
@@ -10512,12 +10457,12 @@ static const struct generic_data suspend_resume_success_1 = {
 
 static void test_suspend_resume_success_1(const void *test_data)
 {
-	bool suspend;
+	struct test_data *data = tester_get_data();
+	struct vhci *vhci = hciemu_get_vhci(data->hciemu);
 	int err;
 
 	/* Triggers the suspend */
-	suspend = true;
-	err = set_debugfs_force_suspend(0, suspend);
+	err = vhci_set_force_suspend(vhci, true);
 	if (err) {
 		tester_warn("Unable to enable the force_suspend");
 		tester_test_failed();
@@ -10535,12 +10480,12 @@ static const struct generic_data suspend_resume_success_2 = {
 
 static void test_suspend_resume_success_2(const void *test_data)
 {
-	bool suspend;
+	struct test_data *data = tester_get_data();
+	struct vhci *vhci = hciemu_get_vhci(data->hciemu);
 	int err;
 
 	/* Triggers the suspend */
-	suspend = true;
-	err = set_debugfs_force_suspend(0, suspend);
+	err = vhci_set_force_suspend(vhci, true);
 	if (err) {
 		tester_warn("Unable to enable the force_suspend");
 		tester_test_failed();
@@ -10548,8 +10493,7 @@ static void test_suspend_resume_success_2(const void *test_data)
 	}
 
 	/* Triggers the resume */
-	suspend = false;
-	err = set_debugfs_force_suspend(0, suspend);
+	err = vhci_set_force_suspend(vhci, false);
 	if (err) {
 		tester_warn("Unable to enable the force_suspend");
 		tester_test_failed();
@@ -10586,12 +10530,12 @@ static void setup_suspend_resume_success_3(const void *test_data)
 
 static void test_suspend_resume_success_3(const void *test_data)
 {
-	bool suspend;
+	struct test_data *data = tester_get_data();
+	struct vhci *vhci = hciemu_get_vhci(data->hciemu);
 	int err;
 
 	/* Triggers the suspend */
-	suspend = true;
-	err = set_debugfs_force_suspend(0, suspend);
+	err = vhci_set_force_suspend(vhci, true);
 	if (err) {
 		tester_warn("Unable to enable the force_suspend");
 		tester_test_failed();
@@ -10635,15 +10579,15 @@ static void setup_suspend_resume_success_4(const void *test_data)
 
 static void test_suspend_resume_success_4(const void *test_data)
 {
-	bool suspend;
+	struct test_data *data = tester_get_data();
+	struct vhci *vhci = hciemu_get_vhci(data->hciemu);
 	int err;
 
 	test_command_generic(test_data);
 
 	/* Triggers the suspend */
-	suspend = true;
 	tester_print("Set the system into Suspend via force_suspend");
-	err = set_debugfs_force_suspend(0, suspend);
+	err = vhci_set_force_suspend(vhci, true);
 	if (err) {
 		tester_warn("Unable to enable the force_suspend");
 		tester_test_failed();
@@ -10664,13 +10608,13 @@ static const struct generic_data suspend_resume_success_5 = {
 
 static void trigger_force_suspend(void *user_data)
 {
-	bool suspend;
+	struct test_data *data = tester_get_data();
+	struct vhci *vhci = hciemu_get_vhci(data->hciemu);
 	int err;
 
 	/* Triggers the suspend */
-	suspend = true;
 	tester_print("Set the system into Suspend via force_suspend");
-	err = set_debugfs_force_suspend(0, suspend);
+	err = vhci_set_force_suspend(vhci, true);
 	if (err) {
 		tester_warn("Unable to enable the force_suspend");
 		return;
@@ -10679,13 +10623,13 @@ static void trigger_force_suspend(void *user_data)
 
 static void trigger_force_resume(void *user_data)
 {
-	bool suspend;
+	struct test_data *data = tester_get_data();
+	struct vhci *vhci = hciemu_get_vhci(data->hciemu);
 	int err;
 
 	/* Triggers the suspend */
-	suspend = false;
 	tester_print("Set the system into Resume via force_suspend");
-	err = set_debugfs_force_suspend(0, suspend);
+	err = vhci_set_force_suspend(vhci, false);
 	if (err) {
 		tester_warn("Unable to disable the force_suspend");
 		return;
@@ -10720,12 +10664,12 @@ static const struct generic_data suspend_resume_success_7 = {
 
 static void test_suspend_resume_success_7(const void *test_data)
 {
-	bool suspend;
+	struct test_data *data = tester_get_data();
+	struct vhci *vhci = hciemu_get_vhci(data->hciemu);
 	int err;
 
 	/* Set Force Wakeup */
-	suspend = true;
-	err = set_debugfs_force_wakeup(0, suspend);
+	err = vhci_set_force_wakeup(vhci, true);
 	if (err) {
 		tester_warn("Unable to enable the force_wakeup");
 		tester_test_failed();
@@ -10733,8 +10677,7 @@ static void test_suspend_resume_success_7(const void *test_data)
 	}
 
 	/* Triggers the suspend */
-	suspend = true;
-	err = set_debugfs_force_suspend(0, suspend);
+	err = vhci_set_force_wakeup(vhci, false);
 	if (err) {
 		tester_warn("Unable to enable the force_suspend");
 		tester_test_failed();
-- 
2.31.1

