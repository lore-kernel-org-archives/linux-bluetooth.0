Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11496C6FD20
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Mar 2023 17:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjCXRWh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Mar 2023 13:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjCXRWf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Mar 2023 13:22:35 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4C1B751
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Mar 2023 10:22:34 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id o4-20020a056a00214400b00627ddde00f4so1309887pfk.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Mar 2023 10:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679678554;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=en5uyJ0jozcxQz6Wf0lgpgw8RE5n+UOgd4/2Vd3q22c=;
        b=VHFq9YcBcmztKYbdIfCPfG+StxFx9unuo8u4TB9mIT4P9zOiIyPfIlqxRfrShZaiRH
         LqYbETAIjNibmYR3cOh0tj5itYaf51qCGK3VtYuNgzJjXkYNCm3wctO2cdt2qIUw+bYr
         TasRIlUkijVpRRB1r31vlzqHWZnA8DRIWZi9wsphDN+sVf0kZiFH76deVWsOHb0h0j+3
         QyQAKHsKXmvPKImdSF/ryZPY2sUyo9oyUv+MaD/nz7e3JOLgAbEXQ3nQeKUMFB4hXDyN
         xK5SAmtF/D0hfcltYZ48hRI0hA2KvlDQ3sDE/OvUvuNDpjDbFxw1B04o7F1vqsNCG/ws
         sUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679678554;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=en5uyJ0jozcxQz6Wf0lgpgw8RE5n+UOgd4/2Vd3q22c=;
        b=OkkC5N/GmhZydy1VhaIZionWfB0KOFkVP8Z/wY105shBbNlD3X5lnPEG4QQT3ibv0x
         jQImawNTrXJay8Cd/EcrQfpcnrlOLU4wd5GFl5eM4YV/NjD3vENytkJOuDdusML3FegV
         cjpyeXmaNeSaS6zsWnlqUlTcgVZlz9x+PVVtkPuCzRI1RHThF/fXCJTS1UEda8witg9A
         +j7ngy4BnlXo6/wdPATI7JoF6HyzHel80mu6yZRarfRM5yWR4BqMjffkaPLmtpJrPQhp
         GGZy9IwRQl03z93fb1kXf3zGOcCmpW5cR3hAgODSI0jCkUevKAQ89mcliNPMxVSXgALq
         ke0w==
X-Gm-Message-State: AAQBX9fZEwj8Ev0kkaMIqAQDFLjBdfHl7CCnOfIylkzmfGm2mEjvVR7A
        4E6xsGLD4mNea27awx1lQrzOV98IBCwGHA==
X-Google-Smtp-Source: AKy350YTs10W7zFGU60yYdIdHES0zgj8Jd6BBaCnpPdvlFu3Yt3L02ZF/mBe3WRsQZ3JgJWRgs6HJmDHJaGFrg==
X-Received: from mmandlik-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2893])
 (user=mmandlik job=sendgmr) by 2002:a17:902:e88e:b0:1a0:7630:8ef9 with SMTP
 id w14-20020a170902e88e00b001a076308ef9mr1272424plg.12.1679678553959; Fri, 24
 Mar 2023 10:22:33 -0700 (PDT)
Date:   Fri, 24 Mar 2023 10:22:30 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230324102227.BlueZ.v3.1.I21ac5a143b0e42eef4ff71ef04ef0e53a294932a@changeid>
Subject: [BlueZ PATCH v3] mgmt-tester: Add devcoredump test
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

Changes in v3:
- Fix compiler warning for signed comparision in test_hci_devcd()

Changes in v2:
- Rename function names to *_devcd

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
index a56c38173..838ae5d2b 100644
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
+	unsigned int i = 0;
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

