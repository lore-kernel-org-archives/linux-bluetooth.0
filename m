Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3208AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Oct 2021 05:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F9C5611C3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Oct 2021 05:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235385AbhJOFLo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Oct 2021 01:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235357AbhJOFLn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Oct 2021 01:11:43 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59350C061570
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Oct 2021 22:09:37 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id i76so5250047pfe.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Oct 2021 22:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=voADJ4Q8uDAx6V0HizFvVQymLcOOjmdBsq5LmL4p55E=;
        b=Gp2uKNoxh/5izcm4x575oyGpiEbOD89+MfOCdAc/49IPl2Vg68CxnDI3xGPNcG/b9E
         enwQpJbdevjPCXvAIi3SuZqxbVP9XtOkQMJ8kq5wbSk9plAAmS/0voD93RRfMvLmF/Yj
         4W1uTC69XHZLas1lMmwNq1yQjsZ4+jLgvRgzY0+mMyK3NhIwoYFEAf8ldSb5e01+PCIg
         ScQuGtt/RFZ7xEnWzPxW0xLvLnK7gBkL4lHdLRSRQvuNi14VkjR87P6ALOWIc6eikYl3
         zKZUSFU6ordD+sQTqyOB+FNpWvY4IzyjifsKqDg8sn+pbCVoVThNF2z4hLAWTd7TIX+b
         bk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=voADJ4Q8uDAx6V0HizFvVQymLcOOjmdBsq5LmL4p55E=;
        b=1Ff56O/39I0JRjS3i9sRjkmRXAOT2v0yz/BHixdFqrIdoPUTfDgx9YJdXUG4ufn5Kk
         dUOEznTtzc02svQY5kETGvUT1JKhGKke5S4fdiuZYMiViCZQTUTljs6z6NZb1y5g/QhS
         QQbASiDd4ALqdu1AQ1nr7QeyQu+C/Qj0Pueb53Spbg0g3kvD4QFYfeCzzC9B8fLhAdrN
         XV4kBpNTV8JZDqz6kVRS604VTYhDy0/egBltzg4xIwYzReBZ2QshOqn9vE6rMv992l9I
         HHyx/e0ltDSWBZn23H2MWPfLzHLK2LG0ANYpeEqx1RuwTi3jLjVVCJ2qWR3MXRxO3Azc
         UqHQ==
X-Gm-Message-State: AOAM531Fe7RqZ+15ZM3u6fhiVboNmK0FZNya9f1E0XuymgYbY9tCC8Nd
        ZcS4o2worrgOr+PFt3Pkopag108Hc9Y=
X-Google-Smtp-Source: ABdhPJy8+eKt03YhXgj+PuHLZw1200JxzfHvh66/uw5diYCinRMBfuJQ5OYvPnHjApr6nexvdvVCiw==
X-Received: by 2002:a63:4f43:: with SMTP id p3mr7448398pgl.435.1634274576631;
        Thu, 14 Oct 2021 22:09:36 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p17sm10347510pju.34.2021.10.14.22.09.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 22:09:36 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/7] vhci: Add functions to interface with debugfs
Date:   Thu, 14 Oct 2021 22:09:28 -0700
Message-Id: <20211015050929.3130100-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211015050929.3130100-1-luiz.dentz@gmail.com>
References: <20211015050929.3130100-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds functions that can be used to set debugfs options.
---
 emulator/btdev.c |  23 +++++++++-
 emulator/btdev.h |   3 ++
 emulator/vhci.c  | 108 +++++++++++++++++++++++++++++++++++++++++++++++
 emulator/vhci.h  |   5 +++
 4 files changed, 137 insertions(+), 2 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 0c0ebde40..f28187362 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -46,8 +46,6 @@
 #define ISO_HANDLE 257
 #define SCO_HANDLE 257
 
-#define DEBUGFS_PATH "/sys/kernel/debug/bluetooth"
-
 struct hook {
 	btdev_hook_func handler;
 	void *user_data;
@@ -141,6 +139,7 @@ struct btdev {
 	uint8_t  le_states[8];
 	const struct btdev_cmd *cmds;
 	uint16_t msft_opcode;
+	bool aosp_capable;
 
 	uint16_t default_link_policy;
 	uint8_t  event_mask[8];
@@ -6677,3 +6676,23 @@ bool btdev_del_hook(struct btdev *btdev, enum btdev_hook_type type,
 
 	return false;
 }
+
+int btdev_set_msft_opcode(struct btdev *btdev, uint16_t opcode)
+{
+	if (!btdev)
+		return -EINVAL;
+
+	btdev->msft_opcode = opcode;
+
+	return 0;
+}
+
+int btdev_set_aosp_capable(struct btdev *btdev, bool enable)
+{
+	if (!btdev)
+		return -EINVAL;
+
+	btdev->aosp_capable = enable;
+
+	return 0;
+}
diff --git a/emulator/btdev.h b/emulator/btdev.h
index f7cba149a..412bfd158 100644
--- a/emulator/btdev.h
+++ b/emulator/btdev.h
@@ -93,3 +93,6 @@ int btdev_add_hook(struct btdev *btdev, enum btdev_hook_type type,
 
 bool btdev_del_hook(struct btdev *btdev, enum btdev_hook_type type,
 							uint16_t opcode);
+
+int btdev_set_msft_opcode(struct btdev *btdev, uint16_t opcode);
+int btdev_set_aosp_capable(struct btdev *btdev, bool enable);
diff --git a/emulator/vhci.c b/emulator/vhci.c
index 97fbcb8c4..e016a1ac5 100644
--- a/emulator/vhci.c
+++ b/emulator/vhci.c
@@ -20,6 +20,8 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/uio.h>
+#include <fcntl.h>
+#include <unistd.h>
 
 #include "lib/bluetooth.h"
 #include "lib/hci.h"
@@ -29,8 +31,11 @@
 #include "btdev.h"
 #include "vhci.h"
 
+#define DEBUGFS_PATH "/sys/kernel/debug/bluetooth"
+
 struct vhci {
 	enum btdev_type type;
+	uint16_t index;
 	struct io *io;
 	struct btdev *btdev;
 };
@@ -140,6 +145,7 @@ struct vhci *vhci_open(uint8_t type)
 
 	memset(vhci, 0, sizeof(*vhci));
 	vhci->type = type;
+	vhci->index = rsp.index;
 	vhci->io = io_new(fd);
 
 	io_set_close_on_destroy(vhci->io, true);
@@ -175,3 +181,105 @@ struct btdev *vhci_get_btdev(struct vhci *vhci)
 
 	return vhci->btdev;
 }
+
+static int vhci_debugfs_open(struct vhci *vhci, char *option)
+{
+	char path[64];
+
+	if (!vhci)
+		return -EINVAL;
+
+	memset(path, 0, sizeof(path));
+	sprintf(path, DEBUGFS_PATH "/hci%d/%s", vhci->index, option);
+
+	return open(path, O_RDWR);
+}
+
+int vhci_set_force_suspend(struct vhci *vhci, bool enable)
+{
+	int fd, err;
+	char val;
+
+	fd = vhci_debugfs_open(vhci, "force_suspend");
+	if (fd < 0)
+		return -errno;
+
+	val = (enable) ? 'Y' : 'N';
+
+	err = write(fd, &val, sizeof(val));
+	if (err < 0) {
+		err = -errno;
+		goto done;
+	}
+
+done:
+	close(fd);
+	return err;
+}
+
+int vhci_set_force_wakeup(struct vhci *vhci, bool enable)
+{
+	int fd, err;
+	char val;
+
+	fd = vhci_debugfs_open(vhci, "force_wakeup");
+	if (fd < 0)
+		return -errno;
+
+	val = (enable) ? 'Y' : 'N';
+
+	err = write(fd, &val, sizeof(val));
+	if (err < 0) {
+		err = -errno;
+		goto done;
+	}
+
+done:
+	close(fd);
+	return err;
+}
+
+int vhci_set_msft_opcode(struct vhci *vhci, uint16_t opcode)
+{
+	int fd, err;
+
+	fd = vhci_debugfs_open(vhci, "msft_opcode");
+	if (fd < 0)
+		return -errno;
+
+	err = write(fd, &opcode, sizeof(opcode));
+	if (err < 0) {
+		err = -errno;
+		goto done;
+	}
+
+	btdev_set_msft_opcode(vhci->btdev, opcode);
+
+done:
+	close(fd);
+	return err;
+}
+
+int vhci_set_aosp_capable(struct vhci *vhci, bool enable)
+{
+	int fd, err;
+	char val;
+
+	fd = vhci_debugfs_open(vhci, "aosp_capable");
+	if (fd < 0)
+		return -errno;
+
+	val = (enable) ? 'Y' : 'N';
+
+	err = write(fd, &val, sizeof(val));
+	if (err < 0) {
+		err = -errno;
+		goto done;
+	}
+
+	btdev_set_aosp_capable(vhci->btdev, enable);
+
+done:
+	close(fd);
+	return err;
+}
diff --git a/emulator/vhci.h b/emulator/vhci.h
index 0554121e8..a601d3934 100644
--- a/emulator/vhci.h
+++ b/emulator/vhci.h
@@ -22,3 +22,8 @@ struct vhci *vhci_open(uint8_t type);
 void vhci_close(struct vhci *vhci);
 
 struct btdev *vhci_get_btdev(struct vhci *vhci);
+
+int vhci_set_force_suspend(struct vhci *vhci, bool enable);
+int vhci_set_force_wakeup(struct vhci *vhci, bool enable);
+int vhci_set_msft_opcode(struct vhci *vhci, uint16_t opcode);
+int vhci_set_aosp_capable(struct vhci *vhci, bool enable);
-- 
2.31.1

