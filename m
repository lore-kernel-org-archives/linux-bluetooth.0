Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BB4C6FD20
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Mar 2023 18:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjCXSSc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Mar 2023 14:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjCXSSU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Mar 2023 14:18:20 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C087F1025F
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Mar 2023 11:18:19 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id x4-20020a170902ec8400b001a1a5f6f272so1628960plg.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Mar 2023 11:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679681899;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tsPct1nXj3p0DgXEIXFQI0q4AZ/j9B3r7XwNOl9p7aE=;
        b=qLG8nRi+op0HZ5c4vOJoaX1K+Z8h1oxzbWu8PJbzU1hHkSINlSOtNy8sCHeZ6EgMDv
         WqbQO/PABnjCyi3i4A9LEPhGWpZcDdftwHVfqBADIUKvCxsG5khKSDGAe93yREW2utFf
         r0UDB/S1UA+AyI6/5qtfTdLT6XVSuzuKNNzA9PTqcluhpzCkVqgBAFoH8vWL98opwXMn
         NVnRanIrlgF1WVCHwPm++HhXt/6RqG7/XvDGgNHSVz3tu9C+fTf3M98CCMeYBdi67uNL
         IUdL9wWlDLwxQ+xjvxiEvHnML/ABr+HA0nIKDVgCAzirAwqyeaZnPtsfFtGrmSfxgSUM
         f39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679681899;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tsPct1nXj3p0DgXEIXFQI0q4AZ/j9B3r7XwNOl9p7aE=;
        b=HVN4orTzqz64/qre8ACqzUqzhaDmuNfDnUJ5stRELTiVZpNq+CRK8GfZibgsTaDZms
         xHbToYwmflLCQ0y1HgxF1qCF3EJSjhco6hoh7alvqTy3JqJQoT5GPGLpYLI3fa3QGRi7
         n++41QRt/8o4rBAr9Zuuea59d1wudCoD1CgCTBaG2gA71hAK84SVtIku7Qtg4zqjheH3
         cr9QPJVPpo+ZNbD9UCfF++v4jbuq22E70B6B8eQQUXS9MWTUepKam7AMFlHxVNFXwKxj
         H7V/L8OxgFOElqTAGK4f1oe7SvcwBm0+yPW9Ki0Gp/L5F0osDYxynSyM5mELH+1DGFsp
         1vjw==
X-Gm-Message-State: AAQBX9e9q4Aj5QqUxinHEfXbvcnO8agSTxVQkboVrAEt4c4JnTLvG73s
        FqPnq2yfUPv1fwLv3XsQYLrpSFcyK6GC7A==
X-Google-Smtp-Source: AKy350YL9gkmqLhzmqBh+Dxr6chs1LRNZom/xqidZ0hDMNjK5QeDZGnp9v5S3p43NKxTX6CpBb4JkGMnWq6ZEA==
X-Received: from mmandlik-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2893])
 (user=mmandlik job=sendgmr) by 2002:a63:4042:0:b0:50f:53aa:f662 with SMTP id
 n63-20020a634042000000b0050f53aaf662mr899613pga.5.1679681899054; Fri, 24 Mar
 2023 11:18:19 -0700 (PDT)
Date:   Fri, 24 Mar 2023 11:18:15 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230324111613.BlueZ.v4.1.I21ac5a143b0e42eef4ff71ef04ef0e53a294932a@changeid>
Subject: [BlueZ PATCH v4 1/2] vhci: Add support to trigger devcoredump and
 read the dump file
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Manish Mandlik <mmandlik@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add vhci support to trigger the hci devcoredump by writing to
force_devcoredump debugfs entry and read the generated devcoredump
file.
---

Changes in v4:
- Split into two patches - vhci patch and mgmt-tester patch

Changes in v3:
- Fix compiler warning for signed comparision in test_hci_devcd()

Changes in v2:
- Rename function names to *_devcd

 emulator/vhci.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 emulator/vhci.h |  2 ++
 2 files changed, 44 insertions(+)

diff --git a/emulator/vhci.c b/emulator/vhci.c
index a12b11e0f..1676f1697 100644
--- a/emulator/vhci.c
+++ b/emulator/vhci.c
@@ -22,6 +22,7 @@
 #include <sys/uio.h>
 #include <fcntl.h>
 #include <unistd.h>
+#include <dirent.h>
 
 #include "lib/bluetooth.h"
 #include "lib/hci.h"
@@ -32,6 +33,7 @@
 #include "vhci.h"
 
 #define DEBUGFS_PATH "/sys/kernel/debug/bluetooth"
+#define DEVCORE_PATH "/sys/class/devcoredump"
 
 struct vhci {
 	enum btdev_type type;
@@ -267,3 +269,43 @@ int vhci_set_force_static_address(struct vhci *vhci, bool enable)
 	return vhci_debugfs_write(vhci, "force_static_address", &val,
 							sizeof(val));
 }
+
+int vhci_force_devcd(struct vhci *vhci, void *data, size_t len)
+{
+	return vhci_debugfs_write(vhci, "force_devcoredump", data, len);
+}
+
+int vhci_read_devcd(struct vhci *vhci, void *buf, size_t size)
+{
+	DIR *dir;
+	struct dirent *entry;
+	char filename[PATH_MAX];
+	int fd;
+	int count;
+
+	dir = opendir(DEVCORE_PATH);
+	if (dir == NULL)
+		return -errno;
+
+	while ((entry = readdir(dir)) != NULL) {
+		if (strstr(entry->d_name, "devcd"))
+			break;
+	}
+
+	if (entry == NULL) {
+		closedir(dir);
+		return -ENOENT;
+	}
+
+	sprintf(filename, DEVCORE_PATH "/%s/data", entry->d_name);
+	fd  = open(filename, O_RDONLY);
+	if (fd < 0) {
+		closedir(dir);
+		return -errno;
+	}
+
+	count = read(fd, buf, size);
+	close(fd);
+
+	return count;
+}
diff --git a/emulator/vhci.h b/emulator/vhci.h
index 6da56cb58..5dd28b627 100644
--- a/emulator/vhci.h
+++ b/emulator/vhci.h
@@ -29,3 +29,5 @@ int vhci_set_msft_opcode(struct vhci *vhci, uint16_t opcode);
 int vhci_set_aosp_capable(struct vhci *vhci, bool enable);
 int vhci_set_emu_opcode(struct vhci *vhci, uint16_t opcode);
 int vhci_set_force_static_address(struct vhci *vhci, bool enable);
+int vhci_force_devcd(struct vhci *vhci, void *data, size_t len);
+int vhci_read_devcd(struct vhci *vhci, void *buf, size_t size);
-- 
2.40.0.348.gf938b09366-goog

