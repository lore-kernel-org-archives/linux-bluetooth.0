Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A15DC6FA8E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Mar 2023 23:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjCBXRe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Mar 2023 18:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjCBXRd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Mar 2023 18:17:33 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB0858B7E
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Mar 2023 15:17:04 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id u4-20020a170902bf4400b0019e30a57694so392428pls.20
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Mar 2023 15:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vdH99IE9Hqsj5GoleVNY62nzl+c8xVpDWHboYQCBxx0=;
        b=RYAETNiB9XmADKtTANjyUSEtlZF34aFCT2k30tBKGUPP1y35koi3tr/JC8UnWMeP0v
         gzR9zBVoTUFbj76e0kS61c4V9MwOJxw60FX3qAXbt+pJfbdbYQHQVaGzB/mkCS/uQ7oG
         9vCgTVs0o/q9Alq1kE1mAhad2zpPaU46YWgdscVukGFRE9/ExUAgNFj7wv71XOcec5GR
         23MN6d5ezhJpiI0E7xar+tOy6dIlQmZdJvq8geC9fQBkU6+/YQdXLox6t3tanrYafzCD
         2vlGDMSly4v+XoNVD7jnPCvBXGjdTbffKFuOxd7xdjdK86yFj3Tw2cLsyHqtr9KL+bFQ
         eHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vdH99IE9Hqsj5GoleVNY62nzl+c8xVpDWHboYQCBxx0=;
        b=6+1nB7lXUq1VDnVgYHpctPD+VnXlhaoku+gGM93X9DHTHZ73bcfCy5cRDluYJMciJe
         vLaywkVzPGQugV8XHx5YceYa6lfD1aqs7iciitNqvAXSltPq/hryERpiZxhC9ezn6i1r
         HQyKYalP6/dYks+HDtWqlBy9joQOTlo9sV1iPvLonTkYnG2PsJS7eD838aN1dOUxnN7l
         wB5STpN8/6PjzlggHa/bSvGUxtXLOzQTVx7tWsIzTUxK5HwMBGsjo3i0aeD/kKDUY+rB
         ONGKS7lU02QCcq+sIeYPW6hyN3AjNck5N8JySW/BCdNVd6XEE//roxO1R2v0+KSVzIvT
         6Phw==
X-Gm-Message-State: AO0yUKUpxGadUefcw++24K/2t/5omvXMPKOuw7+aV/1C5oUsDAJvtfdk
        z/XRxVGmngPTUKeNpyoDqZ18qej7bYbhyA==
X-Google-Smtp-Source: AK7set9331z201G7tqNuoebvF0vIC8VBCfZ/b0fYjZDJxcj7iKaukl7YRGYcoq/vSvH6RXEhP5U53CBUptwfow==
X-Received: from mmandlik-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2893])
 (user=mmandlik job=sendgmr) by 2002:a17:90b:354f:b0:233:bada:17b5 with SMTP
 id lt15-20020a17090b354f00b00233bada17b5mr1488167pjb.4.1677799020773; Thu, 02
 Mar 2023 15:17:00 -0800 (PST)
Date:   Thu,  2 Mar 2023 15:16:54 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230302151621.BlueZ.v1.1.I21ac5a143b0e42eef4ff71ef04ef0e53a294932a@changeid>
Subject: [BlueZ PATCH v1] mgmt-tester: Add devcoredump test
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add mgmt-tester test for hci devcoredump.

---

 emulator/vhci.c     | 42 ++++++++++++++++++++++++
 emulator/vhci.h     |  2 ++
 tools/mgmt-tester.c | 78 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 122 insertions(+)

diff --git a/emulator/vhci.c b/emulator/vhci.c
index a12b11e0f..048ea08c6 100644
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
+int vhci_force_devcoredump(struct vhci *vhci, void *data, size_t len)
+{
+	return vhci_debugfs_write(vhci, "force_devcoredump", data, len);
+}
+
+int vhci_read_devcoredump(struct vhci *vhci, void *buf, size_t size)
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
index 6da56cb58..cb969911c 100644
--- a/emulator/vhci.h
+++ b/emulator/vhci.h
@@ -29,3 +29,5 @@ int vhci_set_msft_opcode(struct vhci *vhci, uint16_t opcode);
 int vhci_set_aosp_capable(struct vhci *vhci, bool enable);
 int vhci_set_emu_opcode(struct vhci *vhci, uint16_t opcode);
 int vhci_set_force_static_address(struct vhci *vhci, bool enable);
+int vhci_force_devcoredump(struct vhci *vhci, void *data, size_t len);
+int vhci_read_devcoredump(struct vhci *vhci, void *buf, size_t size);
diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index a56c38173..70b425547 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -12511,6 +12511,77 @@ static void test_suspend_resume_success_10(const void *test_data)
 	tester_wait(2, trigger_force_resume, NULL);
 }
 
+#define MAX_COREDUMP_BUF_LEN	512
+#define MAX_COREDUMP_LINE_LEN	40
+
+static void test_hci_devcoredump(const void *test_data)
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
+	if (vhci_force_devcoredump(vhci, dump_data, sizeof(dump_data))) {
+		tester_warn("Unable to set force_devcoredump");
+		tester_test_failed();
+		return;
+	}
+
+	/* Read the generated devcoredump file */
+	if (vhci_read_devcoredump(vhci, buf, sizeof(buf)) <= 0) {
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
+	test_bredrle("HCI devcoredump", NULL, NULL, test_hci_devcoredump);
+
 	return tester_run();
 }
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

