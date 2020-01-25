Return-Path: <SRS0=CluT=3O=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2832EC35241
	for <linux-bluetooth@archiver.kernel.org>; Sat, 25 Jan 2020 08:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0681520709
	for <linux-bluetooth@archiver.kernel.org>; Sat, 25 Jan 2020 08:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgAYIT6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 25 Jan 2020 03:19:58 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:60056 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgAYIT6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 25 Jan 2020 03:19:58 -0500
Received: from localhost.localdomain (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 0D593CED19
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jan 2020 09:29:16 +0100 (CET)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Move {min,max}_key_size debugfs into hci_debugfs_create_le
Date:   Sat, 25 Jan 2020 09:19:51 +0100
Message-Id: <20200125081951.96271-1-marcel@holtmann.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The debugfs entries for {min,max}_key_size are created during SMP
registration and thus it might lead to multiple attempts to create the
same entries. Avoid this by moving them to the LE controller init
section.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_debugfs.c | 61 ++++++++++++++++++++++++
 net/bluetooth/smp.c         | 93 -------------------------------------
 2 files changed, 61 insertions(+), 93 deletions(-)

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 1c8100bc4e04..6b1314c738b8 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -26,6 +26,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
+#include "smp.h"
 #include "hci_debugfs.h"
 
 #define DEFINE_QUIRK_ATTRIBUTE(__name, __quirk)				      \
@@ -989,6 +990,62 @@ static int adv_max_interval_get(void *data, u64 *val)
 DEFINE_SIMPLE_ATTRIBUTE(adv_max_interval_fops, adv_max_interval_get,
 			adv_max_interval_set, "%llu\n");
 
+static int min_key_size_set(void *data, u64 val)
+{
+	struct hci_dev *hdev = data;
+
+	if (val > hdev->le_max_key_size || val < SMP_MIN_ENC_KEY_SIZE)
+		return -EINVAL;
+
+	hci_dev_lock(hdev);
+	hdev->le_min_key_size = val;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int min_key_size_get(void *data, u64 *val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock(hdev);
+	*val = hdev->le_min_key_size;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(min_key_size_fops, min_key_size_get,
+			min_key_size_set, "%llu\n");
+
+static int max_key_size_set(void *data, u64 val)
+{
+	struct hci_dev *hdev = data;
+
+	if (val > SMP_MAX_ENC_KEY_SIZE || val < hdev->le_min_key_size)
+		return -EINVAL;
+
+	hci_dev_lock(hdev);
+	hdev->le_max_key_size = val;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int max_key_size_get(void *data, u64 *val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock(hdev);
+	*val = hdev->le_max_key_size;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(max_key_size_fops, max_key_size_get,
+			max_key_size_set, "%llu\n");
+
 static int auth_payload_timeout_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
@@ -1071,6 +1128,10 @@ void hci_debugfs_create_le(struct hci_dev *hdev)
 			    &adv_max_interval_fops);
 	debugfs_create_u16("discov_interleaved_timeout", 0644, hdev->debugfs,
 			   &hdev->discov_interleaved_timeout);
+	debugfs_create_file("min_key_size", 0644, hdev->debugfs, hdev,
+			    &min_key_size_fops);
+	debugfs_create_file("max_key_size", 0644, hdev->debugfs, hdev,
+			    &max_key_size_fops);
 	debugfs_create_file("auth_payload_timeout", 0644, hdev->debugfs, hdev,
 			    &auth_payload_timeout_fops);
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 4ece170c518e..204f14f8b507 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -3373,94 +3373,6 @@ static const struct file_operations force_bredr_smp_fops = {
 	.llseek		= default_llseek,
 };
 
-static ssize_t le_min_key_size_read(struct file *file,
-				     char __user *user_buf,
-				     size_t count, loff_t *ppos)
-{
-	struct hci_dev *hdev = file->private_data;
-	char buf[4];
-
-	snprintf(buf, sizeof(buf), "%2u\n", hdev->le_min_key_size);
-
-	return simple_read_from_buffer(user_buf, count, ppos, buf, strlen(buf));
-}
-
-static ssize_t le_min_key_size_write(struct file *file,
-				      const char __user *user_buf,
-				      size_t count, loff_t *ppos)
-{
-	struct hci_dev *hdev = file->private_data;
-	char buf[32];
-	size_t buf_size = min(count, (sizeof(buf) - 1));
-	u8 key_size;
-
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-
-	buf[buf_size] = '\0';
-
-	sscanf(buf, "%hhu", &key_size);
-
-	if (key_size > hdev->le_max_key_size ||
-	    key_size < SMP_MIN_ENC_KEY_SIZE)
-		return -EINVAL;
-
-	hdev->le_min_key_size = key_size;
-
-	return count;
-}
-
-static const struct file_operations le_min_key_size_fops = {
-	.open		= simple_open,
-	.read		= le_min_key_size_read,
-	.write		= le_min_key_size_write,
-	.llseek		= default_llseek,
-};
-
-static ssize_t le_max_key_size_read(struct file *file,
-				     char __user *user_buf,
-				     size_t count, loff_t *ppos)
-{
-	struct hci_dev *hdev = file->private_data;
-	char buf[4];
-
-	snprintf(buf, sizeof(buf), "%2u\n", hdev->le_max_key_size);
-
-	return simple_read_from_buffer(user_buf, count, ppos, buf, strlen(buf));
-}
-
-static ssize_t le_max_key_size_write(struct file *file,
-				      const char __user *user_buf,
-				      size_t count, loff_t *ppos)
-{
-	struct hci_dev *hdev = file->private_data;
-	char buf[32];
-	size_t buf_size = min(count, (sizeof(buf) - 1));
-	u8 key_size;
-
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-
-	buf[buf_size] = '\0';
-
-	sscanf(buf, "%hhu", &key_size);
-
-	if (key_size > SMP_MAX_ENC_KEY_SIZE ||
-	    key_size < hdev->le_min_key_size)
-		return -EINVAL;
-
-	hdev->le_max_key_size = key_size;
-
-	return count;
-}
-
-static const struct file_operations le_max_key_size_fops = {
-	.open		= simple_open,
-	.read		= le_max_key_size_read,
-	.write		= le_max_key_size_write,
-	.llseek		= default_llseek,
-};
-
 int smp_register(struct hci_dev *hdev)
 {
 	struct l2cap_chan *chan;
@@ -3485,11 +3397,6 @@ int smp_register(struct hci_dev *hdev)
 
 	hdev->smp_data = chan;
 
-	debugfs_create_file("le_min_key_size", 0644, hdev->debugfs, hdev,
-			    &le_min_key_size_fops);
-	debugfs_create_file("le_max_key_size", 0644, hdev->debugfs, hdev,
-			    &le_max_key_size_fops);
-
 	/* If the controller does not support BR/EDR Secure Connections
 	 * feature, then the BR/EDR SMP channel shall not be present.
 	 *
-- 
2.24.1

