Return-Path: <SRS0=7mPt=CW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F22C433E2
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Sep 2020 03:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55B8221BE5
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Sep 2020 03:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgIMDeU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Sep 2020 23:34:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:59033 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbgIMDeJ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Sep 2020 23:34:09 -0400
IronPort-SDR: IZgXSGH1gMaOAjMsRELmhSq5NNveNtwiTjECmStHiXRU1tUIrnjTcOZUqbq1vhPhS/L7LmYwrm
 k6+u9KU+WNlQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9742"; a="243784905"
X-IronPort-AV: E=Sophos;i="5.76,421,1592895600"; 
   d="scan'208";a="243784905"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2020 20:34:01 -0700
IronPort-SDR: zCJ1Wec+p1aRp0vDE0H2l+uhJSqqlroFNcZqupwZ7XrLFm3pcgbjguKqoLLn//rU8imqy7WY0E
 ++vhxiQNM5jA==
X-IronPort-AV: E=Sophos;i="5.76,421,1592895600"; 
   d="scan'208";a="301347240"
Received: from han1-mobl3.jf.intel.com ([10.251.29.101])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2020 20:34:00 -0700
From:   tedd.an@linux.intel.com
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [BlueZ v2 16/17] src: Add SPDX License Identifier
Date:   Sat, 12 Sep 2020 20:33:40 -0700
Message-Id: <20200913033341.4639-17-tedd.an@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200913033341.4639-1-tedd.an@linux.intel.com>
References: <20200913033341.4639-1-tedd.an@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds SPDX License Identifier.

-------------------------------------
       License            COUNT
-------------------------------------
 GPL-2.0-or-later     :     51
 LGPL-2.1-or-later    :     60
 BSD-2-Clause         :      2

License: GPL-2.0-or-later
   src/attrib-server.h
   src/advertising.h
   src/textfile.c
   src/attrib-server.c
   src/uinput.h
   src/log.h
   src/eir.h
   src/sdpd.h
   src/sdpd-request.c
   src/service.h
   src/sdpd-database.c
   src/adapter.h
   src/plugin.h
   src/uuid-helper.h
   src/plugin.c
   src/main.c
   src/sdp-xml.c
   src/error.h
   src/oui.c
   src/device.c
   src/agent.h
   src/sdp-client.c
   src/oui.h
   src/device.h
   src/gatt-database.c
   src/error.c
   src/backtrace.c
   src/sdpd-server.c
   src/adapter.c
   src/log.c
   src/agent.c
   src/backtrace.h
   src/sdp-xml.h
   src/hcid.h
   src/dbus-common.h
   src/uuid-helper.c
   src/storage.c
   src/profile.c
   src/advertising.c
   src/storage.h
   src/dbus-common.c
   src/profile.h
   src/sdpd-service.c
   src/eir.c
   src/sdp-client.h
   src/gatt-database.h
   src/gatt-client.h
   src/rfkill.c
   src/gatt-client.c
   src/service.c
   src/textfile.h

License: LGPL-2.1-or-later
   src/shared/mainloop-glib.c
   src/shared/btp.c
   src/shared/tester.c
   src/shared/btsnoop.c
   src/shared/gatt-helpers.h
   src/shared/log.h
   src/shared/util.h
   src/shared/mainloop-ell.c
   src/shared/hci-crypto.c
   src/shared/mainloop.c
   src/shared/hfp.h
   src/shared/mainloop-notify.c
   src/shared/io-mainloop.c
   src/shared/btsnoop.h
   src/shared/uhid.h
   src/shared/util.c
   src/shared/ringbuf.c
   src/shared/btp.h
   src/shared/shell.h
   src/shared/io-glib.c
   src/shared/queue.h
   src/shared/gatt-server.h
   src/shared/crypto.c
   src/shared/crypto.h
   src/shared/io-ell.c
   src/shared/timeout-glib.c
   src/shared/mgmt.c
   src/shared/gatt-db.c
   src/shared/mainloop-notify.h
   src/shared/hfp.c
   src/shared/timeout-ell.c
   src/shared/shell.c
   src/shared/hci.c
   src/shared/log.c
   src/shared/ringbuf.h
   src/shared/gatt-helpers.c
   src/shared/queue.c
   src/shared/tty.h
   src/shared/timeout-mainloop.c
   src/shared/tester.h
   src/shared/gap.h
   src/shared/mgmt.h
   src/shared/gatt-db.h
   src/shared/uhid.c
   src/shared/mainloop.h
   src/shared/timeout.h
   src/shared/att-types.h
   src/shared/pcap.c
   src/shared/gap.c
   src/shared/att.c
   src/shared/pcap.h
   src/shared/hci.h
   src/shared/gatt-client.h
   src/shared/io.h
   src/shared/gatt-client.c
   src/shared/ad.c
   src/shared/att.h
   src/shared/gatt-server.c
   src/shared/hci-crypto.h
   src/shared/ad.h

License: BSD-2-Clause
   src/shared/ecc.h
   src/shared/ecc.c
---
 src/adapter.c                 | 1 +
 src/adapter.h                 | 1 +
 src/advertising.c             | 1 +
 src/advertising.h             | 1 +
 src/agent.c                   | 1 +
 src/agent.h                   | 1 +
 src/attrib-server.c           | 1 +
 src/attrib-server.h           | 1 +
 src/backtrace.c               | 1 +
 src/backtrace.h               | 1 +
 src/dbus-common.c             | 1 +
 src/dbus-common.h             | 1 +
 src/device.c                  | 1 +
 src/device.h                  | 1 +
 src/eir.c                     | 1 +
 src/eir.h                     | 1 +
 src/error.c                   | 1 +
 src/error.h                   | 1 +
 src/gatt-client.c             | 1 +
 src/gatt-client.h             | 1 +
 src/gatt-database.c           | 1 +
 src/gatt-database.h           | 1 +
 src/hcid.h                    | 1 +
 src/log.c                     | 1 +
 src/log.h                     | 1 +
 src/main.c                    | 1 +
 src/oui.c                     | 1 +
 src/oui.h                     | 1 +
 src/plugin.c                  | 1 +
 src/plugin.h                  | 1 +
 src/profile.c                 | 1 +
 src/profile.h                 | 1 +
 src/rfkill.c                  | 1 +
 src/sdp-client.c              | 1 +
 src/sdp-client.h              | 1 +
 src/sdp-xml.c                 | 1 +
 src/sdp-xml.h                 | 1 +
 src/sdpd-database.c           | 1 +
 src/sdpd-request.c            | 1 +
 src/sdpd-server.c             | 1 +
 src/sdpd-service.c            | 1 +
 src/sdpd.h                    | 1 +
 src/service.c                 | 1 +
 src/service.h                 | 1 +
 src/shared/ad.c               | 1 +
 src/shared/ad.h               | 1 +
 src/shared/att-types.h        | 1 +
 src/shared/att.c              | 1 +
 src/shared/att.h              | 1 +
 src/shared/btp.c              | 1 +
 src/shared/btp.h              | 1 +
 src/shared/btsnoop.c          | 1 +
 src/shared/btsnoop.h          | 1 +
 src/shared/crypto.c           | 1 +
 src/shared/crypto.h           | 1 +
 src/shared/ecc.c              | 1 +
 src/shared/ecc.h              | 1 +
 src/shared/gap.c              | 1 +
 src/shared/gap.h              | 1 +
 src/shared/gatt-client.c      | 1 +
 src/shared/gatt-client.h      | 1 +
 src/shared/gatt-db.c          | 1 +
 src/shared/gatt-db.h          | 1 +
 src/shared/gatt-helpers.c     | 1 +
 src/shared/gatt-helpers.h     | 1 +
 src/shared/gatt-server.c      | 1 +
 src/shared/gatt-server.h      | 1 +
 src/shared/hci-crypto.c       | 1 +
 src/shared/hci-crypto.h       | 1 +
 src/shared/hci.c              | 1 +
 src/shared/hci.h              | 1 +
 src/shared/hfp.c              | 1 +
 src/shared/hfp.h              | 1 +
 src/shared/io-ell.c           | 1 +
 src/shared/io-glib.c          | 1 +
 src/shared/io-mainloop.c      | 1 +
 src/shared/io.h               | 1 +
 src/shared/log.c              | 1 +
 src/shared/log.h              | 1 +
 src/shared/mainloop-ell.c     | 1 +
 src/shared/mainloop-glib.c    | 1 +
 src/shared/mainloop-notify.c  | 1 +
 src/shared/mainloop-notify.h  | 1 +
 src/shared/mainloop.c         | 1 +
 src/shared/mainloop.h         | 1 +
 src/shared/mgmt.c             | 1 +
 src/shared/mgmt.h             | 1 +
 src/shared/pcap.c             | 1 +
 src/shared/pcap.h             | 1 +
 src/shared/queue.c            | 1 +
 src/shared/queue.h            | 1 +
 src/shared/ringbuf.c          | 1 +
 src/shared/ringbuf.h          | 1 +
 src/shared/shell.c            | 1 +
 src/shared/shell.h            | 1 +
 src/shared/tester.c           | 1 +
 src/shared/tester.h           | 1 +
 src/shared/timeout-ell.c      | 1 +
 src/shared/timeout-glib.c     | 1 +
 src/shared/timeout-mainloop.c | 1 +
 src/shared/timeout.h          | 1 +
 src/shared/tty.h              | 1 +
 src/shared/uhid.c             | 1 +
 src/shared/uhid.h             | 1 +
 src/shared/util.c             | 1 +
 src/shared/util.h             | 1 +
 src/storage.c                 | 1 +
 src/storage.h                 | 1 +
 src/textfile.c                | 1 +
 src/textfile.h                | 1 +
 src/uinput.h                  | 1 +
 src/uuid-helper.c             | 1 +
 src/uuid-helper.h             | 1 +
 113 files changed, 113 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 1435e2bd7..9b4a3523e 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/adapter.h b/src/adapter.h
index f8ac20261..ced0bb6e9 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/advertising.c b/src/advertising.c
index e5f25948d..3856ff32d 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/advertising.h b/src/advertising.h
index 50d86674b..79c559431 100644
--- a/src/advertising.h
+++ b/src/advertising.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/agent.c b/src/agent.c
index e0ffcd22f..5df15fc7c 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/agent.h b/src/agent.h
index 1438b9e6d..06dc8c765 100644
--- a/src/agent.h
+++ b/src/agent.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 7c15a4e8f..877179a41 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/attrib-server.h b/src/attrib-server.h
index 063cb6621..69d60c1a8 100644
--- a/src/attrib-server.h
+++ b/src/attrib-server.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/backtrace.c b/src/backtrace.c
index c43873354..c5bbeeaf9 100644
--- a/src/backtrace.c
+++ b/src/backtrace.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/backtrace.h b/src/backtrace.h
index b3eef6dd9..3094f1aaa 100644
--- a/src/backtrace.h
+++ b/src/backtrace.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/dbus-common.c b/src/dbus-common.c
index 6e2097a2d..f099647bb 100644
--- a/src/dbus-common.c
+++ b/src/dbus-common.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/dbus-common.h b/src/dbus-common.h
index fbf4acd28..f1bbe28d3 100644
--- a/src/dbus-common.h
+++ b/src/dbus-common.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /* *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
diff --git a/src/device.c b/src/device.c
index 8f73ce4d3..83f928c30 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/device.h b/src/device.h
index 3cd090786..2c081662e 100644
--- a/src/device.h
+++ b/src/device.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/eir.c b/src/eir.c
index fa52a2bd8..61ce1728d 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/eir.h b/src/eir.h
index c868177a6..929472098 100644
--- a/src/eir.h
+++ b/src/eir.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/error.c b/src/error.c
index 89517075e..e01636f68 100644
--- a/src/error.c
+++ b/src/error.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/error.h b/src/error.h
index 7c8cad066..158afe556 100644
--- a/src/error.h
+++ b/src/error.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/gatt-client.c b/src/gatt-client.c
index 20c3fbec2..d618af607 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/gatt-client.h b/src/gatt-client.h
index 92a925546..e277ed1f8 100644
--- a/src/gatt-client.h
+++ b/src/gatt-client.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/gatt-database.c b/src/gatt-database.c
index e7e4a36a6..a83ec336e 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/gatt-database.h b/src/gatt-database.h
index 154d3243f..9d0de0bbc 100644
--- a/src/gatt-database.h
+++ b/src/gatt-database.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/hcid.h b/src/hcid.h
index 3624ba6ea..e77c6a030 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/log.c b/src/log.c
index a42c5941d..76c501809 100644
--- a/src/log.c
+++ b/src/log.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/log.h b/src/log.h
index e83431151..77887088c 100644
--- a/src/log.h
+++ b/src/log.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/main.c b/src/main.c
index b37c32948..73b34d0ce 100644
--- a/src/main.c
+++ b/src/main.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/oui.c b/src/oui.c
index 8059c0a89..32cad253c 100644
--- a/src/oui.c
+++ b/src/oui.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/oui.h b/src/oui.h
index 2ddc27fef..3696a981e 100644
--- a/src/oui.h
+++ b/src/oui.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/plugin.c b/src/plugin.c
index 39310a7db..30cc02274 100644
--- a/src/plugin.c
+++ b/src/plugin.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/plugin.h b/src/plugin.h
index 89c7b8515..3335ed54d 100644
--- a/src/plugin.h
+++ b/src/plugin.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/profile.c b/src/profile.c
index 6961a107b..8f417dbb1 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/profile.h b/src/profile.h
index 95523e50a..b5dac8e88 100644
--- a/src/profile.h
+++ b/src/profile.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/rfkill.c b/src/rfkill.c
index fb2d11306..8f63f464d 100644
--- a/src/rfkill.c
+++ b/src/rfkill.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/sdp-client.c b/src/sdp-client.c
index b92a083af..e3f26d764 100644
--- a/src/sdp-client.c
+++ b/src/sdp-client.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/sdp-client.h b/src/sdp-client.h
index 3a7212fd2..70d669d07 100644
--- a/src/sdp-client.h
+++ b/src/sdp-client.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/sdp-xml.c b/src/sdp-xml.c
index 6f831737d..8f7f0c314 100644
--- a/src/sdp-xml.c
+++ b/src/sdp-xml.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/sdp-xml.h b/src/sdp-xml.h
index 80a4f446d..bb99b0954 100644
--- a/src/sdp-xml.h
+++ b/src/sdp-xml.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/sdpd-database.c b/src/sdpd-database.c
index 843b6d02b..518ef7a2f 100644
--- a/src/sdpd-database.c
+++ b/src/sdpd-database.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/sdpd-request.c b/src/sdpd-request.c
index deaed266f..a3d6443ff 100644
--- a/src/sdpd-request.c
+++ b/src/sdpd-request.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/sdpd-server.c b/src/sdpd-server.c
index ef35309ce..a3903ea57 100644
--- a/src/sdpd-server.c
+++ b/src/sdpd-server.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/sdpd-service.c b/src/sdpd-service.c
index c3ee3eb48..bf03082f8 100644
--- a/src/sdpd-service.c
+++ b/src/sdpd-service.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/sdpd.h b/src/sdpd.h
index 49cd98a2b..a4dd38e87 100644
--- a/src/sdpd.h
+++ b/src/sdpd.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/service.c b/src/service.c
index e4d747a6e..072e937e6 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/service.h b/src/service.h
index 6f1edfb8f..a56e1be4b 100644
--- a/src/service.h
+++ b/src/service.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/ad.c b/src/shared/ad.c
index 14a2709b1..819b8b4cb 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/ad.h b/src/shared/ad.h
index 17e3b631b..809e7bbdc 100644
--- a/src/shared/ad.h
+++ b/src/shared/ad.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/att-types.h b/src/shared/att-types.h
index 99b108990..5fa0bc7b4 100644
--- a/src/shared/att-types.h
+++ b/src/shared/att-types.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/att.c b/src/shared/att.c
index 58f23dfcb..89500ebc7 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/att.h b/src/shared/att.h
index ed20bb5b8..401eba9e7 100644
--- a/src/shared/att.h
+++ b/src/shared/att.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/btp.c b/src/shared/btp.c
index 7eea241a2..f5833e42b 100644
--- a/src/shared/btp.c
+++ b/src/shared/btp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/btp.h b/src/shared/btp.h
index f0ac3a1ee..f9a1b1dd7 100644
--- a/src/shared/btp.h
+++ b/src/shared/btp.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/btsnoop.c b/src/shared/btsnoop.c
index f0d074743..31f671c20 100644
--- a/src/shared/btsnoop.c
+++ b/src/shared/btsnoop.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/btsnoop.h b/src/shared/btsnoop.h
index 5fb084aa2..b20723a64 100644
--- a/src/shared/btsnoop.h
+++ b/src/shared/btsnoop.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/crypto.c b/src/shared/crypto.c
index 5cc88ce4a..430d82573 100644
--- a/src/shared/crypto.c
+++ b/src/shared/crypto.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/crypto.h b/src/shared/crypto.h
index d17daa835..30749df8d 100644
--- a/src/shared/crypto.h
+++ b/src/shared/crypto.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/ecc.c b/src/shared/ecc.c
index 1b45e0d0a..04c7dd9d6 100644
--- a/src/shared/ecc.c
+++ b/src/shared/ecc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: BSD-2-Clause
 /*
  * Copyright (c) 2013, Kenneth MacKay
  * All rights reserved.
diff --git a/src/shared/ecc.h b/src/shared/ecc.h
index 8c15e4ee8..f7b155452 100644
--- a/src/shared/ecc.h
+++ b/src/shared/ecc.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: BSD-2-Clause */
 /*
  * Copyright (c) 2013, Kenneth MacKay
  * All rights reserved.
diff --git a/src/shared/gap.c b/src/shared/gap.c
index 0b8d073c5..b9df64139 100644
--- a/src/shared/gap.c
+++ b/src/shared/gap.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/gap.h b/src/shared/gap.h
index 52c264a8e..dcfefcd1f 100644
--- a/src/shared/gap.h
+++ b/src/shared/gap.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index f15466673..b596ef3f9 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index 10900168b..f3cb6bc47 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index e939ddc3a..b9e4187a5 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 5bf19d302..a15789ef4 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index 6b39bb161..75f75ee59 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/gatt-helpers.h b/src/shared/gatt-helpers.h
index dd9dd1c44..4923d27ae 100644
--- a/src/shared/gatt-helpers.h
+++ b/src/shared/gatt-helpers.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 28ac2d68d..295b1811b 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/gatt-server.h b/src/shared/gatt-server.h
index a2492d275..88db54c16 100644
--- a/src/shared/gatt-server.h
+++ b/src/shared/gatt-server.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/hci-crypto.c b/src/shared/hci-crypto.c
index f7507472b..cd635a670 100644
--- a/src/shared/hci-crypto.c
+++ b/src/shared/hci-crypto.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/hci-crypto.h b/src/shared/hci-crypto.h
index b090c2410..420626c93 100644
--- a/src/shared/hci-crypto.h
+++ b/src/shared/hci-crypto.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/hci.c b/src/shared/hci.c
index 262e93d5a..e931e1e03 100644
--- a/src/shared/hci.c
+++ b/src/shared/hci.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/hci.h b/src/shared/hci.h
index dba0f11db..b44f56f75 100644
--- a/src/shared/hci.h
+++ b/src/shared/hci.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index f4747b4ca..7da48bd2b 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index 2eb783849..859303d95 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/io-ell.c b/src/shared/io-ell.c
index 6748982c7..47f44475b 100644
--- a/src/shared/io-ell.c
+++ b/src/shared/io-ell.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/io-glib.c b/src/shared/io-glib.c
index d62de4e10..a518780d7 100644
--- a/src/shared/io-glib.c
+++ b/src/shared/io-glib.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/io-mainloop.c b/src/shared/io-mainloop.c
index 2306c3479..0fcb21968 100644
--- a/src/shared/io-mainloop.c
+++ b/src/shared/io-mainloop.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/io.h b/src/shared/io.h
index 8bc1111d0..1944470a3 100644
--- a/src/shared/io.h
+++ b/src/shared/io.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/log.c b/src/shared/log.c
index 7c8b71220..d8f6442fc 100644
--- a/src/shared/log.c
+++ b/src/shared/log.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/log.h b/src/shared/log.h
index c72ab735b..7dab6126c 100644
--- a/src/shared/log.h
+++ b/src/shared/log.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/mainloop-ell.c b/src/shared/mainloop-ell.c
index 63e254ac6..7bb447378 100644
--- a/src/shared/mainloop-ell.c
+++ b/src/shared/mainloop-ell.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/mainloop-glib.c b/src/shared/mainloop-glib.c
index 2508a1fb2..4913e544e 100644
--- a/src/shared/mainloop-glib.c
+++ b/src/shared/mainloop-glib.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/mainloop-notify.c b/src/shared/mainloop-notify.c
index 1de714a0e..f9b1efca5 100644
--- a/src/shared/mainloop-notify.c
+++ b/src/shared/mainloop-notify.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/mainloop-notify.h b/src/shared/mainloop-notify.h
index 721b5fbed..5b4cf08ac 100644
--- a/src/shared/mainloop-notify.h
+++ b/src/shared/mainloop-notify.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/mainloop.c b/src/shared/mainloop.c
index 8a8e2c022..0b8f91bb2 100644
--- a/src/shared/mainloop.c
+++ b/src/shared/mainloop.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/mainloop.h b/src/shared/mainloop.h
index 1ede62797..34cb6d557 100644
--- a/src/shared/mainloop.h
+++ b/src/shared/mainloop.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
index 277e361a6..8c356d84d 100644
--- a/src/shared/mgmt.c
+++ b/src/shared/mgmt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/mgmt.h b/src/shared/mgmt.h
index 7caeb3844..f80e18364 100644
--- a/src/shared/mgmt.h
+++ b/src/shared/mgmt.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/pcap.c b/src/shared/pcap.c
index 0d887e24c..5c41b896d 100644
--- a/src/shared/pcap.c
+++ b/src/shared/pcap.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/pcap.h b/src/shared/pcap.h
index b47de62e8..96b927ee3 100644
--- a/src/shared/pcap.h
+++ b/src/shared/pcap.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/queue.c b/src/shared/queue.c
index 60df11143..4efb12e23 100644
--- a/src/shared/queue.c
+++ b/src/shared/queue.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/queue.h b/src/shared/queue.h
index 8cd817cc0..b03ac74ae 100644
--- a/src/shared/queue.h
+++ b/src/shared/queue.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/ringbuf.c b/src/shared/ringbuf.c
index 8cf0b5b19..8cc32aac0 100644
--- a/src/shared/ringbuf.c
+++ b/src/shared/ringbuf.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/ringbuf.h b/src/shared/ringbuf.h
index adf471a43..4452853fe 100644
--- a/src/shared/ringbuf.h
+++ b/src/shared/ringbuf.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/shell.c b/src/shared/shell.c
index d58e2d7d1..30d2fbbb4 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/shell.h b/src/shared/shell.h
index e14d58381..8d03dec06 100644
--- a/src/shared/shell.h
+++ b/src/shared/shell.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/tester.c b/src/shared/tester.c
index 62e5c1aae..eb15694ed 100644
--- a/src/shared/tester.c
+++ b/src/shared/tester.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/tester.h b/src/shared/tester.h
index 96e8dc901..796e57c92 100644
--- a/src/shared/tester.h
+++ b/src/shared/tester.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/timeout-ell.c b/src/shared/timeout-ell.c
index 8419d4617..5081d2f66 100644
--- a/src/shared/timeout-ell.c
+++ b/src/shared/timeout-ell.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/timeout-glib.c b/src/shared/timeout-glib.c
index fd71ca430..91494538c 100644
--- a/src/shared/timeout-glib.c
+++ b/src/shared/timeout-glib.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/timeout-mainloop.c b/src/shared/timeout-mainloop.c
index 971124a2e..7cbec435f 100644
--- a/src/shared/timeout-mainloop.c
+++ b/src/shared/timeout-mainloop.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/timeout.h b/src/shared/timeout.h
index 4930ce162..cab335dd4 100644
--- a/src/shared/timeout.h
+++ b/src/shared/timeout.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/tty.h b/src/shared/tty.h
index 66ec09f31..9b7ca9688 100644
--- a/src/shared/tty.h
+++ b/src/shared/tty.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/uhid.c b/src/shared/uhid.c
index 71a4e04ba..09d4e2de2 100644
--- a/src/shared/uhid.c
+++ b/src/shared/uhid.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/uhid.h b/src/shared/uhid.h
index dbdca852d..0c7e79aa4 100644
--- a/src/shared/uhid.h
+++ b/src/shared/uhid.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/util.c b/src/shared/util.c
index 4ecf31a03..2ba8a2a3a 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/shared/util.h b/src/shared/util.h
index 9193068d1..3753ce2c6 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/storage.c b/src/storage.c
index 8cbb5b270..a764e4a6f 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/storage.h b/src/storage.h
index 1c0ad57ec..2d766542d 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/textfile.c b/src/textfile.c
index 371651bd8..4f7ed3d72 100644
--- a/src/textfile.c
+++ b/src/textfile.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/textfile.h b/src/textfile.h
index f01629e43..87dfdabd5 100644
--- a/src/textfile.h
+++ b/src/textfile.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/uinput.h b/src/uinput.h
index 20e0941d1..3b96b331a 100644
--- a/src/uinput.h
+++ b/src/uinput.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/uuid-helper.c b/src/uuid-helper.c
index 2c897d86c..df90c7992 100644
--- a/src/uuid-helper.c
+++ b/src/uuid-helper.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/src/uuid-helper.h b/src/uuid-helper.h
index c0d7f9eec..304bc71c3 100644
--- a/src/uuid-helper.h
+++ b/src/uuid-helper.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
-- 
2.17.1

