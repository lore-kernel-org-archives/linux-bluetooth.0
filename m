Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF45C6FD20
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Mar 2023 18:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjCXSSe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Mar 2023 14:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbjCXSSa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Mar 2023 14:18:30 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A01D18B17
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Mar 2023 11:18:21 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id y32-20020a634960000000b0050fa03fa554so983711pgk.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Mar 2023 11:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679681901;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aSW5lVN/XdDnqsYnEdlvJ79vqtFaMV3jR95gfz5aEeg=;
        b=Dy3NhjDiXi4oiBF4Tnsprf/JOEIbUmTgkSnrcpUHd0skU6GPYbKoD5p5d61/8P+ytH
         PVS19xEOlnpdhjb6mhBLyvgn5Mqd7dqoN3NAqfYcUk142ez2T1s8hoOZulhAQ5Igehbj
         omKpZVKsrqM+lxRRBUgoHZE7sMYUmuNA7NdYOwsdsnfw57tu1dTZsB1DjJAxMnPc1jup
         IDTPPQJcU0u4QylXwCkvYkhLWyaBkD1Tzt3rxlMHSokGcLwII5w8Sv/X/2YraS21OyDm
         2FFPQgv/QzPTopPYKdXu+ZFaqpvs1vn+g+ZYpIq2dh85qVq9rV4arYoyVAcB/cLp0zfs
         0bYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679681901;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aSW5lVN/XdDnqsYnEdlvJ79vqtFaMV3jR95gfz5aEeg=;
        b=Bb12yLn8sTZyr8u18DJNj306UzfhdQqnDoO9M+8wDYNcBrtfVcfOQR/r9RLYFbBOWF
         GX/nzBNxabSCEjjFa+zh6WLxWPYfNp+cmOEGJrvfCoFc6+md/jcwsW3wowWcYP9XnhuF
         6aZcbFt/e9DLm1wmX3wbEgq/bwQIPA0spqjZ4Rc6kkc5e3Ueog2yFhLdHdT9rCyqbFeN
         kO7R66/i8PfIMlVKqybLY97ECc3N87TYT5uxJ9k3M9VS5h6waXOXZfXVKTiJkNaIkR5n
         2EkzhtObnSW1t0VFcznFzBLwTC7B7lSC7EXkolbDhl5dEd0X2Y2qS6vfOCutwRWHUNtj
         GDOA==
X-Gm-Message-State: AAQBX9c2yQejvxxuckq/mIT3Uv3Pfrc5fiwSfM+J+/8uNKoUql7h//BW
        Z1FglXdemo7UDXo+/W+XgHeDpq3kBiN7jQ==
X-Google-Smtp-Source: AKy350YQvBZ+RIYYu/aKFebCbJj4Bl1VbACugggNmrKeJ56LzKSgTIxfgBOSnEfAXKc6LpLgC9rI6fQwtzH9sQ==
X-Received: from mmandlik-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2893])
 (user=mmandlik job=sendgmr) by 2002:a17:90a:c095:b0:234:acfd:c8da with SMTP
 id o21-20020a17090ac09500b00234acfdc8damr1138137pjs.2.1679681900832; Fri, 24
 Mar 2023 11:18:20 -0700 (PDT)
Date:   Fri, 24 Mar 2023 11:18:16 -0700
In-Reply-To: <20230324111613.BlueZ.v4.1.I21ac5a143b0e42eef4ff71ef04ef0e53a294932a@changeid>
Mime-Version: 1.0
References: <20230324111613.BlueZ.v4.1.I21ac5a143b0e42eef4ff71ef04ef0e53a294932a@changeid>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230324111613.BlueZ.v4.2.I6b8d9794fa661c63824306ccc8eecf6479040b1a@changeid>
Subject: [BlueZ PATCH v4 2/2] mgmt-tester: Add devcoredump test
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Manish Mandlik <mmandlik@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add mgmt-tester test for hci devcoredump. This test triggers the
devcoredump with a test data and verifies the generated devcoredump
file for the test data and correct devcoredump header fields.
---

Changes in v4:
- New patch in the series

 tools/mgmt-tester.c | 78 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

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

