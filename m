Return-Path: <SRS0=Oq99=5U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB58C43331
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Apr 2020 03:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199A0206CC
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Apr 2020 03:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hdtjJZvY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgDDDbe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Apr 2020 23:31:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41522 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbgDDDbb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Apr 2020 23:31:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id m13so568689pgd.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2020 20:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v1mdWcuwskC5xCxFq+Qddy86SO72Bw+uYH+YeQZGcNE=;
        b=hdtjJZvYVOQsb3dVzkBalbaBdiHxGcZAApVW04rr3BcEzsea3w0jFkiUten1Wq0d7J
         8NXzcwSTadalpNtoqjqwmaaW1SIwQ4W+MPFH37wQEnjWgZ+K95lkiIw5hOujctIJ4P/S
         QIoVpuHz1MVJmZ+OA2Lm0lfxbj0gkchH7dxCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v1mdWcuwskC5xCxFq+Qddy86SO72Bw+uYH+YeQZGcNE=;
        b=BRi5LnwUyCKP8XLFWwx+8/cfVr6ySYknf7AP4mvAau45/a1/AriISKEYhTcvy4r9yk
         Iuu5TMRrKMqFqw/3fu1of3IjFtql1hygvTTyY7JCjQp/I+tTmERNy2IXQa9F9lUvXYcQ
         jyffMhNLch6Eoe9pfM10fUNGsRVlRxctcbBtiuR+PJ0PEgs/RW5qeJjaKZ/vHioR6c8G
         D5wnHL/c4sBf5XagVpxrf2nGkoUS3a126esxZ2b+C1uE6eeZQfIBjNhdSwZn6c6Sqe5G
         fOl7XHvTyW193mJDstpe++pLDUYYbZo5UBOb9l+DqrqMFYGf0k55fNi7YzpQ/Z7WSFjl
         E0pQ==
X-Gm-Message-State: AGi0PuaIaM01cJaFWegTOReJpz4iuXU/tWlAePDYlvGJE14XfpKfB/ij
        In/wy4VU4uLNJoyhqyM9d+fLTgcmruk=
X-Google-Smtp-Source: APiQypJ77ulOxjh+3lJmzBP70688j+/yZ+EXq9Z0QmGYQf8wqv4ALEIxck7H5Vy2ku+i/vAZcPAu2A==
X-Received: by 2002:a63:be49:: with SMTP id g9mr11194340pgo.30.1585971089286;
        Fri, 03 Apr 2020 20:31:29 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id o184sm6800599pfg.149.2020.04.03.20.31.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 20:31:28 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v5 1/3] Bluetooth: Add the framework of using Microsoft vendor extension
Date:   Fri,  3 Apr 2020 20:31:16 -0700
Message-Id: <20200403203058.v5.1.I04214d389ccfe933f1056a17c0e0ecdacb0395b5@changeid>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200404033118.22135-1-mcchou@chromium.org>
References: <20200404033118.22135-1-mcchou@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds the framework of using Microsoft vendor extension by
introducing a kernel config, BT_MSFTEXT, and a source file to facilitate
Microsoft vendor extension functions.
This was verified with Intel ThunderPeak BT controller
where msft_opcode is 0xFC1E. See https://docs.microsoft.com/en-us/windows-
hardware/drivers/bluetooth/microsoft-defined-bluetooth-hci-commands-and-
events for more information about the extension.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
(cherry picked from commit dadae5cfbf84abb7b5465e82a7aae801a2a4f163)
Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
---

Changes in v5:
- Extract the changes on btusb as a different commit.

Changes in v4:
- Introduce CONFIG_BT_MSFTEXT as a starting point of providing a
framework to use Microsoft extension
- Create include/net/bluetooth/msft.h and net/bluetooth/msft.c to
facilitate functions of Microsoft extension.

Changes in v3:
- Create net/bluetooth/msft.c with struct msft_vnd_ext defined internally
and change the hdev->msft_ext field to void*.
- Define and expose msft_vnd_ext_set_opcode() for btusb use.
- Init hdev->msft_ext in hci_alloc_dev() and deinit it in hci_free_dev().

Changes in v2:
- Define struct msft_vnd_ext and add a field of this type to struct
hci_dev to facilitate the support of Microsoft vendor extension.

 include/net/bluetooth/hci_core.h |  4 ++++
 include/net/bluetooth/msft.h     | 19 +++++++++++++++++++
 net/bluetooth/Kconfig            |  7 +++++++
 net/bluetooth/Makefile           |  1 +
 net/bluetooth/msft.c             | 15 +++++++++++++++
 5 files changed, 46 insertions(+)
 create mode 100644 include/net/bluetooth/msft.h
 create mode 100644 net/bluetooth/msft.c

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d4e28773d3781..239cae2d99986 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -484,6 +484,10 @@ struct hci_dev {
 	struct led_trigger	*power_led;
 #endif
 
+#if IS_ENABLED(CONFIG_BT_MSFTEXT)
+	__u16			msft_opcode;
+#endif
+
 	int (*open)(struct hci_dev *hdev);
 	int (*close)(struct hci_dev *hdev);
 	int (*flush)(struct hci_dev *hdev);
diff --git a/include/net/bluetooth/msft.h b/include/net/bluetooth/msft.h
new file mode 100644
index 0000000000000..7218ea759dde4
--- /dev/null
+++ b/include/net/bluetooth/msft.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright (C) 2020 Google Corporation */
+
+#ifndef __MSFT_H
+#define __MSFT_H
+
+#include <net/bluetooth/hci_core.h>
+
+#if IS_ENABLED(CONFIG_BT_MSFTEXT)
+
+void msft_set_opcode(struct hci_dev *hdev, __u16 opcode);
+
+#else
+
+static inline void msft_set_opcode(struct hci_dev *hdev, __u16 opcode) {}
+
+#endif
+
+#endif /* __MSFT_H*/
diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index 165148c7c4ce5..d439be5c534e7 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -93,6 +93,13 @@ config BT_LEDS
 	  This option selects a few LED triggers for different
 	  Bluetooth events.
 
+config BT_MSFTEXT
+	bool "Enable Microsoft extensions"
+	depends on BT
+	help
+	  This options enables support for the Microsoft defined HCI
+	  vendor extensions.
+
 config BT_SELFTEST
 	bool "Bluetooth self testing support"
 	depends on BT && DEBUG_KERNEL
diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index fda41c0b47818..41dd541a44a52 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -19,5 +19,6 @@ bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o \
 bluetooth-$(CONFIG_BT_BREDR) += sco.o
 bluetooth-$(CONFIG_BT_HS) += a2mp.o amp.o
 bluetooth-$(CONFIG_BT_LEDS) += leds.o
+bluetooth-$(CONFIG_BT_MSFTEXT) += msft.o
 bluetooth-$(CONFIG_BT_DEBUGFS) += hci_debugfs.o
 bluetooth-$(CONFIG_BT_SELFTEST) += selftest.o
diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
new file mode 100644
index 0000000000000..04dad4ac7bf78
--- /dev/null
+++ b/net/bluetooth/msft.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (C) 2020 Google Corporation */
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+#include <net/bluetooth/msft.h>
+
+void msft_set_opcode(struct hci_dev *hdev, __u16 opcode)
+{
+	hdev->msft_opcode = opcode;
+
+	bt_dev_info(hdev, "Enabling MSFT extensions with opcode 0x%2.2x",
+		    hdev->msft_opcode);
+}
+EXPORT_SYMBOL(msft_set_opcode);
-- 
2.24.1

