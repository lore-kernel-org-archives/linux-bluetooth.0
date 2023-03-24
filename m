Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F728C6FD1C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Mar 2023 00:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjCXAY1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 20:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjCXAY0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 20:24:26 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F119A2E820
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 17:24:09 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id j7-20020a17090aeb0700b0023d19dfe884so25276pjz.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 17:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679617448;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GYJ43ITwFetP/Jq1XrpU6aQnlL+5cM5LCNS44lJDnTc=;
        b=fqwkER2DnPN++O3WiJWTDYPpMO2C2I5SlPoo8D5c0seawM1qLLT/g/vAdBzuda3Usb
         Z4fRiyYJiAOo9QhZ9PbOJq1uNTA+J60aqtRKX6QInNzOQJZBUTQUz7uRbZnF6WS4M0v8
         89oDWGHMzbID9WlcprEUJxX8p5nsmEGE7KxTKqlLGO7x/fezZrY4saRV5Kk5PWdDIDBm
         lcFdElk9nr41aGl5MyKZTRp5VTxnwokgFtz1liuledWmTXVl3fGc5a9jjp4JW7UKwgmM
         xgHoSiPnI4e2/lhriAT3RlMkn22/o5tKAFJ8R161JbpxrakYEe/FJgnJz4rsTTSrffIp
         KtYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679617448;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GYJ43ITwFetP/Jq1XrpU6aQnlL+5cM5LCNS44lJDnTc=;
        b=uqxW0nOCD19aKz9DrKJOj8Z12XTfUYPc7PJUCK0uiK9GR+tphZOk+loFRWhB+jEdwG
         h6vIeAbNAyeViROWaFEBKKF+73i2u2/1ItuNOS+b10m6vM2ZRffdcRrcT01hjRaFzv4u
         cUXsvTfKUHP7cmheD3qaD/B0j9w7G3fL8dCOcedkV0zE1/vH6G8eYHIWsHo7OU5fWujH
         9kQU3erN7FWKet91oH682vkzJ8aAb0WbW5UXeNBBf603GO5nbwz63Wx/rrmcxt5oos2c
         LE5YQGGM+fVnzyA+C+wir7cL3ZRrmsLPb4F6tIdeJzHJwvVtgFSrD+mD8pJx7wWmdwV3
         Uq5w==
X-Gm-Message-State: AAQBX9fcQL6NffMZOxqh/rWKXsasCSM/BE+RLUxclT4lEql3nwRy5mS9
        xLg+DVjpT97MrvRdyfDhH+9H8RoKjyxu0w==
X-Google-Smtp-Source: AKy350aLVgm6HzaKSdgT4xoIdFKjR0wJ9FfPHvKmXe6bPdCKyXMFGKT0qs0Dc6ztYXcscoBP8H8o+vha/mkIAw==
X-Received: from mmandlik-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2893])
 (user=mmandlik job=sendgmr) by 2002:a17:90a:1681:b0:23f:63b3:f164 with SMTP
 id o1-20020a17090a168100b0023f63b3f164mr263950pja.3.1679617448061; Thu, 23
 Mar 2023 17:24:08 -0700 (PDT)
Date:   Thu, 23 Mar 2023 17:24:05 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230323172342.BlueZ.v2.1.I21ac5a143b0e42eef4ff71ef04ef0e53a294932a@changeid>
Subject: [BlueZ PATCH v2] mgmt-tester: Add devcoredump test
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add mgmt-tester test for hci devcoredump. This test triggers the
devcoredump with a test data and verifies the generated devcoredump
file for the test data and correct devcoredump header fields.

Signed-off-by: Manish Mandlik <mmandlik@google.com>
---

Changes in v2:
- rename function names to *_devcd

 emulator/vhci.c     | 42 ++++++++++++++++++++++++
 emulator/vhci.h     |  2 ++
 tools/mgmt-tester.c | 78 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 122 insertions(+)

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
diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index a56c38173..d6963a1a5 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -12511,6 +12511,77 @@ static void test_suspend_resume_success_10(const void *test_data)
 	tester_wait(2, trigger_force_resume, NULL);
 }
 
+#define MAX_COREDUMP_BUF_LEN	512
+#define MAX_COREDUMP_LINE_LEN	40
+
+static void test_hci_devcd(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	struct vhci *vhci = hciemu_get_vhci(data->hciemu);
+	char buf[MAX_COREDUMP_BUF_LEN] = {0};
+	char delim[] = "\n";
+	char *line;
+	char *saveptr;
+	int i = 0;
+
+	char dump_data[] = "test data";
+	char expected[][MAX_COREDUMP_LINE_LEN] = {
+		"Bluetooth devcoredump",
+		"State: 2",
+		"Controller Name: vhci_ctrl",
+		"Firmware Version: vhci_fw",
+		"Driver: vhci_drv",
+		"Vendor: vhci",
+		"--- Start dump ---",
+	};
+
+	/* Triggers the devcoredump */
+	if (vhci_force_devcd(vhci, dump_data, sizeof(dump_data))) {
+		tester_warn("Unable to set force_devcoredump");
+		tester_test_failed();
+		return;
+	}
+
+	/* Read the generated devcoredump file */
+	if (vhci_read_devcd(vhci, buf, sizeof(buf)) <= 0) {
+		tester_warn("Unable to read devcoredump");
+		tester_test_failed();
+		return;
+	}
+
+	/* Verify if all devcoredump header fields are present */
+	line = strtok_r(buf, delim, &saveptr);
+	while (i < ARRAY_SIZE(expected)) {
+		if (!line || strcmp(line, expected[i])) {
+			tester_warn("Incorrect coredump data: %s (expected %s)",
+				    line, expected[i]);
+			tester_test_failed();
+			return;
+		}
+
+		if (!strcmp(line, "State: 2")) {
+			/* After updating the devcoredump state, the HCI
+			 * devcoredump API adds a `\0` at the end. Skip it
+			 * before reading the next line.
+			 */
+			saveptr++;
+		}
+
+		line = strtok_r(NULL, delim, &saveptr);
+		i++;
+	}
+
+	/* Verify the devcoredump data */
+	if (!line || strcmp(line, dump_data)) {
+		tester_warn("Incorrect coredump data: %s (expected %s)", line,
+			    dump_data);
+		tester_test_failed();
+		return;
+	}
+
+	tester_test_passed();
+}
+
 int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);
@@ -14651,5 +14722,12 @@ int main(int argc, char *argv[])
 				setup_ll_privacy_add_device,
 				test_command_generic);
 
+	/* HCI devcoredump
+	 * Setup : Power on
+	 * Run: Trigger devcoredump via force_devcoredump
+	 * Expect: Devcoredump is generated with correct data
+	 */
+	test_bredrle("HCI devcoredump", NULL, NULL, test_hci_devcd);
+
 	return tester_run();
 }
-- 
2.40.0.348.gf938b09366-goog

