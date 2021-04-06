Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129CCC43460
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Apr 2021 13:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEC95613C2
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Apr 2021 13:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243998AbhDFNgs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Apr 2021 09:36:48 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:47734 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344546AbhDFNgr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Apr 2021 09:36:47 -0400
Received: from localhost.localdomain (p4ff9f418.dip0.t-ipconnect.de [79.249.244.24])
        by mail.holtmann.org (Postfix) with ESMTPSA id EE62FCED22
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Apr 2021 15:44:20 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add support for reading AOSP vendor capabilities
Date:   Tue,  6 Apr 2021 15:36:32 +0200
Message-Id: <20210406133632.241599-1-marcel@holtmann.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When drivers indicate support for AOSP vendor extension, initialize them
and read its capabilities.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 11 ++++++++++
 net/bluetooth/Kconfig            |  7 +++++++
 net/bluetooth/Makefile           |  1 +
 net/bluetooth/aosp.c             | 35 ++++++++++++++++++++++++++++++++
 net/bluetooth/aosp.h             | 16 +++++++++++++++
 net/bluetooth/hci_core.c         |  3 +++
 6 files changed, 73 insertions(+)
 create mode 100644 net/bluetooth/aosp.c
 create mode 100644 net/bluetooth/aosp.h

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 1101589422d8..29f609b67f22 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -596,6 +596,10 @@ struct hci_dev {
 	void			*msft_data;
 #endif
 
+#if IS_ENABLED(CONFIG_BT_AOSPEXT)
+	bool			aosp_capable;
+#endif
+
 	int (*open)(struct hci_dev *hdev);
 	int (*close)(struct hci_dev *hdev);
 	int (*flush)(struct hci_dev *hdev);
@@ -1248,6 +1252,13 @@ static inline void hci_set_msft_opcode(struct hci_dev *hdev, __u16 opcode)
 #endif
 }
 
+static inline void hci_set_aosp_capable(struct hci_dev *hdev)
+{
+#if IS_ENABLED(CONFIG_BT_AOSPEXT)
+	hdev->aosp_capable = true;
+#endif
+}
+
 int hci_dev_open(__u16 dev);
 int hci_dev_close(__u16 dev);
 int hci_dev_do_close(struct hci_dev *hdev);
diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index 400c5130dc0a..e0ab4cd7afc3 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -99,6 +99,13 @@ config BT_MSFTEXT
 	  This options enables support for the Microsoft defined HCI
 	  vendor extensions.
 
+config BT_AOSPEXT
+	bool "Enable Android Open Source Project extensions"
+	depends on BT
+	help
+	  This options enables support for the Android Open Source
+	  Project defined HCI vendor extensions.
+
 config BT_DEBUGFS
 	bool "Export Bluetooth internals in debugfs"
 	depends on BT && DEBUG_FS
diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index 1c645fba8c49..cc0995301f93 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -20,5 +20,6 @@ bluetooth-$(CONFIG_BT_BREDR) += sco.o
 bluetooth-$(CONFIG_BT_HS) += a2mp.o amp.o
 bluetooth-$(CONFIG_BT_LEDS) += leds.o
 bluetooth-$(CONFIG_BT_MSFTEXT) += msft.o
+bluetooth-$(CONFIG_BT_AOSPEXT) += aosp.o
 bluetooth-$(CONFIG_BT_DEBUGFS) += hci_debugfs.o
 bluetooth-$(CONFIG_BT_SELFTEST) += selftest.o
diff --git a/net/bluetooth/aosp.c b/net/bluetooth/aosp.c
new file mode 100644
index 000000000000..a1b7762335a5
--- /dev/null
+++ b/net/bluetooth/aosp.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021 Intel Corporation
+ */
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+#include "aosp.h"
+
+void aosp_do_open(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+
+	if (!hdev->aosp_capable)
+		return;
+
+	bt_dev_dbg(hdev, "Initialize AOSP extension");
+
+	/* LE Get Vendor Capabilities Command */
+	skb = __hci_cmd_sync(hdev, hci_opcode_pack(0x3f, 0x153), 0, NULL,
+			     HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb))
+		return;
+
+	kfree_skb(skb);
+}
+
+void aosp_do_close(struct hci_dev *hdev)
+{
+	if (!hdev->aosp_capable)
+		return;
+
+	bt_dev_dbg(hdev, "Cleanup of AOSP extension");
+}
diff --git a/net/bluetooth/aosp.h b/net/bluetooth/aosp.h
new file mode 100644
index 000000000000..d5603afeb718
--- /dev/null
+++ b/net/bluetooth/aosp.h
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021 Intel Corporation
+ */
+
+#if IS_ENABLED(CONFIG_BT_AOSPEXT)
+
+void aosp_do_open(struct hci_dev *hdev);
+void aosp_do_close(struct hci_dev *hdev);
+
+#else
+
+static inline void msft_do_open(struct hci_dev *hdev) {}
+static inline void msft_do_close(struct hci_dev *hdev) {}
+
+#endif
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 520718d7679b..37a6c566aa62 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -44,6 +44,7 @@
 #include "smp.h"
 #include "leds.h"
 #include "msft.h"
+#include "aosp.h"
 
 static void hci_rx_work(struct work_struct *work);
 static void hci_cmd_work(struct work_struct *work);
@@ -1586,6 +1587,7 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 		ret = hdev->set_diag(hdev, true);
 
 	msft_do_open(hdev);
+	aosp_do_open(hdev);
 
 	clear_bit(HCI_INIT, &hdev->flags);
 
@@ -1782,6 +1784,7 @@ int hci_dev_do_close(struct hci_dev *hdev)
 
 	hci_sock_dev_event(hdev, HCI_DEV_DOWN);
 
+	aosp_do_close(hdev);
 	msft_do_close(hdev);
 
 	if (hdev->flush)
-- 
2.30.2

