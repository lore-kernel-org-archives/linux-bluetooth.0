Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9744C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Mar 2023 06:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjC3GIK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Mar 2023 02:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjC3GIJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Mar 2023 02:08:09 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06F840C6
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Mar 2023 23:08:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 4-20020a251904000000b00b7f75c3cafdso2524077ybz.16
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Mar 2023 23:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680156487;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GucA/TicppslztYc/WfsOHum2FhKG0FA+lcCDeFNths=;
        b=MQSmfc6YyC+HvRLaZm8rfVEXFBYmrJmgNL9qaYqYOLp88nWB/XkVvgOarm2BUc5v29
         ymRpAuGrjCMYVVlh37GNWMXRR0/30kbqKGZI0cmeSz42aZxf8mjJUh1p/ryF0oZ36/oE
         xaxR1hDeJ2PuZ7jBlE6V8vr624wLriep5VhwZHrgqUm+y2xHKycFnr81AC+nkyJu9ZQ4
         EG0MoiEDdtgVzTX1NFn/XnyqHjwqKDpYrIy0P/U4lNkiuyZYtvwGj+9Atb6I3E0i1+wK
         a0m5NMLRA3Wqi2sxdnfc2XOasNmV7WBXg9E6S0EyoM3PGuVQG3mRWynWwVEA3HyDyKiv
         mKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680156487;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GucA/TicppslztYc/WfsOHum2FhKG0FA+lcCDeFNths=;
        b=vNCToUwCPxtIz5pKY2q/6QArpiwTjYzNXZKoGLoPdizgOqgVc+2D91l5662Pp8DgzR
         xSLfGU8w18Oqv1KBlsr+CuYwaPtqyRzU9fPOPXZH4du33QlC5+c5sEAdaPRIZ279NMcp
         LR6X0cna4Uasi/tMYY21CjaTarlZu4YKOdIQvyZKEhk5WlT+tqKOYRYVsI7ajtSc+wHB
         6quSNTCtunuE60wmtNKEnvEwN7CbX/Djzo1JZ0VvLRDzbL//ny3EA8kGD4/7/lo3E0X7
         PBgRE8/SfoF5WAiUAoXqm7eNlRN1AuL7XfSe3IY6z96pMdKxt4jkKKi9ZNO038YSpOZ3
         KNlg==
X-Gm-Message-State: AAQBX9del9ftKxkmtoWAECxS99qhmdJBEQawD4fQQ44G2KCksHH49QmA
        5MlaPo5Offf9voxkar9Jwb7WeZI6OIddbg==
X-Google-Smtp-Source: AKy350ZuUo04vO9lUTdNAlxkVsQjrqin53BD3q8xfk84x5arbFXUjYfr0MfcUOKxbsWmVIW/ftLc9/8ABEkf9Q==
X-Received: from mmandlik-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2893])
 (user=mmandlik job=sendgmr) by 2002:a81:ac64:0:b0:544:b9b2:5c32 with SMTP id
 z36-20020a81ac64000000b00544b9b25c32mr10577610ywj.7.1680156486942; Wed, 29
 Mar 2023 23:08:06 -0700 (PDT)
Date:   Wed, 29 Mar 2023 23:08:02 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230329230734.BlueZ.v5.1.I21ac5a143b0e42eef4ff71ef04ef0e53a294932a@changeid>
Subject: [BlueZ PATCH v5 1/2] vhci: Add support to trigger devcoredump and
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

Changes in v5:
- Refactor vhci_read_devcd()

Changes in v4:
- Split into two patches - vhci patch and mgmt-tester patch

Changes in v3:
- Fix compiler warning for signed comparision in test_hci_devcd()

Changes in v2:
- Rename function names to *_devcd

 emulator/vhci.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++-
 emulator/vhci.h |  2 ++
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/emulator/vhci.c b/emulator/vhci.c
index a12b11e0f..ecf1db3c7 100644
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
@@ -184,7 +186,7 @@ struct btdev *vhci_get_btdev(struct vhci *vhci)
 	return vhci->btdev;
 }
 
-static int vhci_debugfs_write(struct vhci *vhci, char *option, void *data,
+static int vhci_debugfs_write(struct vhci *vhci, char *option, const void *data,
 			      size_t len)
 {
 	char path[64];
@@ -267,3 +269,60 @@ int vhci_set_force_static_address(struct vhci *vhci, bool enable)
 	return vhci_debugfs_write(vhci, "force_static_address", &val,
 							sizeof(val));
 }
+
+int vhci_force_devcd(struct vhci *vhci, const void *data, size_t len)
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
+	int ret;
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
+		ret = -ENOENT;
+		goto close_dir;
+	}
+
+	sprintf(filename, DEVCORE_PATH "/%s/data", entry->d_name);
+	fd  = open(filename, O_RDWR);
+	if (fd < 0) {
+		ret = -errno;
+		goto close_dir;
+	}
+
+	ret = read(fd, buf, size);
+	if (ret < 0) {
+		ret = -errno;
+		goto close_file;
+	}
+
+	/* Once the devcoredump is read, write anything to it to mark it for
+	 * cleanup.
+	 */
+	if (write(fd, "0", 1) < 0) {
+		ret = -errno;
+		goto close_file;
+	}
+
+close_file:
+	close(fd);
+
+close_dir:
+	closedir(dir);
+
+	return ret;
+}
diff --git a/emulator/vhci.h b/emulator/vhci.h
index 6da56cb58..68eae4c4a 100644
--- a/emulator/vhci.h
+++ b/emulator/vhci.h
@@ -29,3 +29,5 @@ int vhci_set_msft_opcode(struct vhci *vhci, uint16_t opcode);
 int vhci_set_aosp_capable(struct vhci *vhci, bool enable);
 int vhci_set_emu_opcode(struct vhci *vhci, uint16_t opcode);
 int vhci_set_force_static_address(struct vhci *vhci, bool enable);
+int vhci_force_devcd(struct vhci *vhci, const void *data, size_t len);
+int vhci_read_devcd(struct vhci *vhci, void *buf, size_t size);
-- 
2.40.0.348.gf938b09366-goog

