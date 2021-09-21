Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B17C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Sep 2021 18:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19A1761242
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Sep 2021 18:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbhIUS0i (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Sep 2021 14:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbhIUS0g (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Sep 2021 14:26:36 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2DEC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Sep 2021 11:25:08 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id nn5-20020a17090b38c500b0019af1c4b31fso243262pjb.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Sep 2021 11:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W/f3b4u2kEgQ+20UHKn0LDzErQDeUyizAnTJKvNQL6g=;
        b=U16KpPAv1cUvNMP3RUS8gkRqtcblpwFbx8YiDIsH4zuS21KvSbWMMBDWmNzo8g63SY
         x6b8N1wyMFTCWtpGtAp1Ry77KmpR6Df32eulQBz1a4jQcic0VFDFsu7WwzMqqlqv8INN
         ZxN11lfYXRRNbYNXbuKdvNVAu0ERex0TrzDsNul034dwljQZs8gWMUKQYLiEwMfmkmlS
         YcJ+eFlReYswwOjBGUtGEQ0aKucS8juLGUxXRbri5zlCjnNK0/fI34BvNxkerzXr1Rnf
         2oYvoKLxfRMf4nXHePjStPv724D+zGALZepLhIACeqNPdNgSFz3jw3j4HeYIJe5g4eBJ
         ae9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W/f3b4u2kEgQ+20UHKn0LDzErQDeUyizAnTJKvNQL6g=;
        b=V6XyEHQYDW6dlWSI6b0wY0lo69FmY+6aEeUG9P4sKTyFPaa9XAbKwj6VVLQo+XQbbZ
         BHea+mVLYEQ3jKu1uwuBwaWEv2RKPJloo0jcJQtDelMyhTk2ehjEs7j7jLqnXkYmmmQq
         6cGb9/X0v3yaWQy29139Mcmk42l4SXLC5+QxbV/AznHLKVMLMSrpIKN9GfAjLFxzd168
         2RIosnQ93wxyZyOJHT8jBpOjzDjWdj3dr9z80y+nf8H4FD7eyfg5dMbr5iDZtpFklwKv
         B2eUfB9NqhPMWizg49Qx08bQSjwPRWg3+mJiGyTTKLMeHKfbhWEsBf+gyuPtU7PLBr/o
         2QAw==
X-Gm-Message-State: AOAM531OK9tqRqJxEVP8pPkY8t1/s3ehMv/cLIsV3Z/RDr9PLB9ACVpf
        uTd/NDxNyiDq8bspGkMZ9/kcEPHxefg=
X-Google-Smtp-Source: ABdhPJxIivGsg+XYbWYULVaHpouwB7Y/qgtA2Gd6lLVDc1eYDv1TvNNXE/+eGBx1v2dfgboNOfxUuQ==
X-Received: by 2002:a17:90a:ca0d:: with SMTP id x13mr6816852pjt.210.1632248707024;
        Tue, 21 Sep 2021 11:25:07 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id y26sm17921350pfe.69.2021.09.21.11.25.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 11:25:06 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_core: Move all debugfs handling to hci_debugfs.c
Date:   Tue, 21 Sep 2021 11:25:04 -0700
Message-Id: <20210921182504.1308610-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This moves hci_debugfs_create_basic to hci_debugfs.c which is where all
the others debugfs entries are handled.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c    | 124 ------------------------------------
 net/bluetooth/hci_debugfs.c | 123 +++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_debugfs.h |   5 ++
 3 files changed, 128 insertions(+), 124 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 52ab168c05ea..aeec5a3031a6 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -62,130 +62,6 @@ DEFINE_MUTEX(hci_cb_list_lock);
 /* HCI ID Numbering */
 static DEFINE_IDA(hci_index_ida);
 
-/* ---- HCI debugfs entries ---- */
-
-static ssize_t dut_mode_read(struct file *file, char __user *user_buf,
-			     size_t count, loff_t *ppos)
-{
-	struct hci_dev *hdev = file->private_data;
-	char buf[3];
-
-	buf[0] = hci_dev_test_flag(hdev, HCI_DUT_MODE) ? 'Y' : 'N';
-	buf[1] = '\n';
-	buf[2] = '\0';
-	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
-}
-
-static ssize_t dut_mode_write(struct file *file, const char __user *user_buf,
-			      size_t count, loff_t *ppos)
-{
-	struct hci_dev *hdev = file->private_data;
-	struct sk_buff *skb;
-	bool enable;
-	int err;
-
-	if (!test_bit(HCI_UP, &hdev->flags))
-		return -ENETDOWN;
-
-	err = kstrtobool_from_user(user_buf, count, &enable);
-	if (err)
-		return err;
-
-	if (enable == hci_dev_test_flag(hdev, HCI_DUT_MODE))
-		return -EALREADY;
-
-	hci_req_sync_lock(hdev);
-	if (enable)
-		skb = __hci_cmd_sync(hdev, HCI_OP_ENABLE_DUT_MODE, 0, NULL,
-				     HCI_CMD_TIMEOUT);
-	else
-		skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL,
-				     HCI_CMD_TIMEOUT);
-	hci_req_sync_unlock(hdev);
-
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
-
-	kfree_skb(skb);
-
-	hci_dev_change_flag(hdev, HCI_DUT_MODE);
-
-	return count;
-}
-
-static const struct file_operations dut_mode_fops = {
-	.open		= simple_open,
-	.read		= dut_mode_read,
-	.write		= dut_mode_write,
-	.llseek		= default_llseek,
-};
-
-static ssize_t vendor_diag_read(struct file *file, char __user *user_buf,
-				size_t count, loff_t *ppos)
-{
-	struct hci_dev *hdev = file->private_data;
-	char buf[3];
-
-	buf[0] = hci_dev_test_flag(hdev, HCI_VENDOR_DIAG) ? 'Y' : 'N';
-	buf[1] = '\n';
-	buf[2] = '\0';
-	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
-}
-
-static ssize_t vendor_diag_write(struct file *file, const char __user *user_buf,
-				 size_t count, loff_t *ppos)
-{
-	struct hci_dev *hdev = file->private_data;
-	bool enable;
-	int err;
-
-	err = kstrtobool_from_user(user_buf, count, &enable);
-	if (err)
-		return err;
-
-	/* When the diagnostic flags are not persistent and the transport
-	 * is not active or in user channel operation, then there is no need
-	 * for the vendor callback. Instead just store the desired value and
-	 * the setting will be programmed when the controller gets powered on.
-	 */
-	if (test_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks) &&
-	    (!test_bit(HCI_RUNNING, &hdev->flags) ||
-	     hci_dev_test_flag(hdev, HCI_USER_CHANNEL)))
-		goto done;
-
-	hci_req_sync_lock(hdev);
-	err = hdev->set_diag(hdev, enable);
-	hci_req_sync_unlock(hdev);
-
-	if (err < 0)
-		return err;
-
-done:
-	if (enable)
-		hci_dev_set_flag(hdev, HCI_VENDOR_DIAG);
-	else
-		hci_dev_clear_flag(hdev, HCI_VENDOR_DIAG);
-
-	return count;
-}
-
-static const struct file_operations vendor_diag_fops = {
-	.open		= simple_open,
-	.read		= vendor_diag_read,
-	.write		= vendor_diag_write,
-	.llseek		= default_llseek,
-};
-
-static void hci_debugfs_create_basic(struct hci_dev *hdev)
-{
-	debugfs_create_file("dut_mode", 0644, hdev->debugfs, hdev,
-			    &dut_mode_fops);
-
-	if (hdev->set_diag)
-		debugfs_create_file("vendor_diag", 0644, hdev->debugfs, hdev,
-				    &vendor_diag_fops);
-}
-
 static int hci_reset_req(struct hci_request *req, unsigned long opt)
 {
 	BT_DBG("%s %ld", req->hdev->name, opt);
diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 841393389f7b..902b40a90b91 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -27,6 +27,7 @@
 #include <net/bluetooth/hci_core.h>
 
 #include "smp.h"
+#include "hci_request.h"
 #include "hci_debugfs.h"
 
 #define DEFINE_QUIRK_ATTRIBUTE(__name, __quirk)				      \
@@ -1250,3 +1251,125 @@ void hci_debugfs_create_conn(struct hci_conn *conn)
 	snprintf(name, sizeof(name), "%u", conn->handle);
 	conn->debugfs = debugfs_create_dir(name, hdev->debugfs);
 }
+
+static ssize_t dut_mode_read(struct file *file, char __user *user_buf,
+			     size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	char buf[3];
+
+	buf[0] = hci_dev_test_flag(hdev, HCI_DUT_MODE) ? 'Y' : 'N';
+	buf[1] = '\n';
+	buf[2] = '\0';
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+}
+
+static ssize_t dut_mode_write(struct file *file, const char __user *user_buf,
+			      size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	struct sk_buff *skb;
+	bool enable;
+	int err;
+
+	if (!test_bit(HCI_UP, &hdev->flags))
+		return -ENETDOWN;
+
+	err = kstrtobool_from_user(user_buf, count, &enable);
+	if (err)
+		return err;
+
+	if (enable == hci_dev_test_flag(hdev, HCI_DUT_MODE))
+		return -EALREADY;
+
+	hci_req_sync_lock(hdev);
+	if (enable)
+		skb = __hci_cmd_sync(hdev, HCI_OP_ENABLE_DUT_MODE, 0, NULL,
+				     HCI_CMD_TIMEOUT);
+	else
+		skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL,
+				     HCI_CMD_TIMEOUT);
+	hci_req_sync_unlock(hdev);
+
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	kfree_skb(skb);
+
+	hci_dev_change_flag(hdev, HCI_DUT_MODE);
+
+	return count;
+}
+
+static const struct file_operations dut_mode_fops = {
+	.open		= simple_open,
+	.read		= dut_mode_read,
+	.write		= dut_mode_write,
+	.llseek		= default_llseek,
+};
+
+static ssize_t vendor_diag_read(struct file *file, char __user *user_buf,
+				size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	char buf[3];
+
+	buf[0] = hci_dev_test_flag(hdev, HCI_VENDOR_DIAG) ? 'Y' : 'N';
+	buf[1] = '\n';
+	buf[2] = '\0';
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+}
+
+static ssize_t vendor_diag_write(struct file *file, const char __user *user_buf,
+				 size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	bool enable;
+	int err;
+
+	err = kstrtobool_from_user(user_buf, count, &enable);
+	if (err)
+		return err;
+
+	/* When the diagnostic flags are not persistent and the transport
+	 * is not active or in user channel operation, then there is no need
+	 * for the vendor callback. Instead just store the desired value and
+	 * the setting will be programmed when the controller gets powered on.
+	 */
+	if (test_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks) &&
+	    (!test_bit(HCI_RUNNING, &hdev->flags) ||
+	     hci_dev_test_flag(hdev, HCI_USER_CHANNEL)))
+		goto done;
+
+	hci_req_sync_lock(hdev);
+	err = hdev->set_diag(hdev, enable);
+	hci_req_sync_unlock(hdev);
+
+	if (err < 0)
+		return err;
+
+done:
+	if (enable)
+		hci_dev_set_flag(hdev, HCI_VENDOR_DIAG);
+	else
+		hci_dev_clear_flag(hdev, HCI_VENDOR_DIAG);
+
+	return count;
+}
+
+static const struct file_operations vendor_diag_fops = {
+	.open		= simple_open,
+	.read		= vendor_diag_read,
+	.write		= vendor_diag_write,
+	.llseek		= default_llseek,
+};
+
+void hci_debugfs_create_basic(struct hci_dev *hdev)
+{
+	debugfs_create_file("dut_mode", 0644, hdev->debugfs, hdev,
+			    &dut_mode_fops);
+
+	if (hdev->set_diag)
+		debugfs_create_file("vendor_diag", 0644, hdev->debugfs, hdev,
+				    &vendor_diag_fops);
+}
diff --git a/net/bluetooth/hci_debugfs.h b/net/bluetooth/hci_debugfs.h
index 4444dc8cedc2..9a8a7c93bb12 100644
--- a/net/bluetooth/hci_debugfs.h
+++ b/net/bluetooth/hci_debugfs.h
@@ -26,6 +26,7 @@ void hci_debugfs_create_common(struct hci_dev *hdev);
 void hci_debugfs_create_bredr(struct hci_dev *hdev);
 void hci_debugfs_create_le(struct hci_dev *hdev);
 void hci_debugfs_create_conn(struct hci_conn *conn);
+void hci_debugfs_create_basic(struct hci_dev *hdev);
 
 #else
 
@@ -45,4 +46,8 @@ static inline void hci_debugfs_create_conn(struct hci_conn *conn)
 {
 }
 
+static inline void hci_debugfs_create_basic(struct hci_dev *hdev)
+{
+}
+
 #endif
-- 
2.31.1

