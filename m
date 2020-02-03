Return-Path: <SRS0=oUsU=3X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1906C35247
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Feb 2020 15:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7A220838
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Feb 2020 15:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgBCPgK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Feb 2020 10:36:10 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:33742 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgBCPgJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Feb 2020 10:36:09 -0500
Received: from localhost.localdomain (x59cc8b15.dyn.telefonica.de [89.204.139.21])
        by mail.holtmann.org (Postfix) with ESMTPSA id 66DDDCED1A
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Feb 2020 16:45:29 +0100 (CET)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC v3] Bluetooth: Add debugfs option to enable runtime debug statements
Date:   Mon,  3 Feb 2020 16:36:03 +0100
Message-Id: <20200203153603.61931-1-marcel@holtmann.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/bluetooth.h | 10 +++++
 net/bluetooth/Kconfig             |  7 +++
 net/bluetooth/af_bluetooth.c      |  2 +
 net/bluetooth/lib.c               | 73 +++++++++++++++++++++++++++++++
 4 files changed, 92 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index e42bb8e03c09..1670953178a0 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -129,6 +129,10 @@ void bt_warn(const char *fmt, ...);
 __printf(1, 2)
 void bt_err(const char *fmt, ...);
 __printf(1, 2)
+#if IS_ENABLED(CONFIG_BT_DEBUGFS_OPTION)
+void bt_dbg(const char *fmt, ...);
+__printf(1, 2)
+#endif
 void bt_warn_ratelimited(const char *fmt, ...);
 __printf(1, 2)
 void bt_err_ratelimited(const char *fmt, ...);
@@ -136,7 +140,11 @@ void bt_err_ratelimited(const char *fmt, ...);
 #define BT_INFO(fmt, ...)	bt_info(fmt "\n", ##__VA_ARGS__)
 #define BT_WARN(fmt, ...)	bt_warn(fmt "\n", ##__VA_ARGS__)
 #define BT_ERR(fmt, ...)	bt_err(fmt "\n", ##__VA_ARGS__)
+#if IS_ENABLED(CONFIG_BT_DEBUGFS_OPTION)
+#define BT_DBG(fmt, ...)	bt_dbg(fmt "\n", ##__VA_ARGS__)
+#else
 #define BT_DBG(fmt, ...)	pr_debug(fmt "\n", ##__VA_ARGS__)
+#endif
 
 #define bt_dev_info(hdev, fmt, ...)				\
 	BT_INFO("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
@@ -393,6 +401,8 @@ void bt_procfs_cleanup(struct net *net, const char *name);
 
 extern struct dentry *bt_debugfs;
 
+void bt_lib_debugfs_init(void);
+
 int l2cap_init(void);
 void l2cap_exit(void);
 
diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index 165148c7c4ce..2871d0770c11 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -128,4 +128,11 @@ config BT_DEBUGFS
 	  Provide extensive information about internal Bluetooth states
 	  in debugfs.
 
+	  When dynamic debug is not used, then this option also includes
+	  a switch to enable/disable internal debug statements.
+
+config BT_DEBUGFS_OPTION
+	bool
+	default y if BT_DEBUGFS && !DYNAMIC_DEBUG
+
 source "drivers/bluetooth/Kconfig"
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 3fd124927d4d..fa0cd665f32a 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -731,6 +731,8 @@ static int __init bt_init(void)
 
 	bt_debugfs = debugfs_create_dir("bluetooth", NULL);
 
+	bt_lib_debugfs_init();
+
 	bt_leds_init();
 
 	err = bt_sysfs_init();
diff --git a/net/bluetooth/lib.c b/net/bluetooth/lib.c
index c09e0a3a0ed9..29f9edb57c5c 100644
--- a/net/bluetooth/lib.c
+++ b/net/bluetooth/lib.c
@@ -27,6 +27,7 @@
 #define pr_fmt(fmt) "Bluetooth: " fmt
 
 #include <linux/export.h>
+#include <linux/debugfs.h>
 
 #include <net/bluetooth/bluetooth.h>
 
@@ -135,6 +136,57 @@ int bt_to_errno(__u16 code)
 }
 EXPORT_SYMBOL(bt_to_errno);
 
+#ifdef CONFIG_BT_DEBUGFS_OPTION
+static bool debug_enable;
+
+static ssize_t debug_enable_read(struct file *file, char __user *user_buf,
+				 size_t count, loff_t *ppos)
+{
+	char buf[3];
+
+	buf[0] = debug_enable ? 'Y': 'N';
+	buf[1] = '\n';
+	buf[2] = '\0';
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+}
+
+static ssize_t debug_enable_write(struct file *file,
+				  const char __user *user_buf,
+				  size_t count, loff_t *ppos)
+{
+	bool enable;
+	int err;
+
+	err = kstrtobool_from_user(user_buf, count, &enable);
+	if (err)
+		return err;
+
+	if (enable == debug_enable)
+		return -EALREADY;
+
+	debug_enable = enable;
+
+	return count;
+}
+
+static const struct file_operations debug_enable_fops = {
+	.open		= simple_open,
+	.read		= debug_enable_read,
+	.write		= debug_enable_write,
+	.llseek		= default_llseek,
+};
+
+void bt_lib_debugfs_init(void)
+{
+	debugfs_create_file("debug_enable", 0644, bt_debugfs, NULL,
+			    &debug_enable_fops);
+}
+#else
+void bt_lib_debugfs_init(void)
+{
+}
+#endif
+
 void bt_info(const char *format, ...)
 {
 	struct va_format vaf;
@@ -183,6 +235,27 @@ void bt_err(const char *format, ...)
 }
 EXPORT_SYMBOL(bt_err);
 
+#ifdef CONFIG_BT_DEBUGFS_OPTION
+void bt_dbg(const char *format, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	if (likely(!debug_enable))
+		return;
+
+	va_start(args, format);
+
+	vaf.fmt = format;
+	vaf.va = &args;
+
+	printk(KERN_DEBUG pr_fmt("%pV"), &vaf);
+
+	va_end(args);
+}
+EXPORT_SYMBOL(bt_dbg);
+#endif
+
 void bt_warn_ratelimited(const char *format, ...)
 {
 	struct va_format vaf;
-- 
2.24.1

