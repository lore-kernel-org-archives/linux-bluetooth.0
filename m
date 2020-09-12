Return-Path: <SRS0=izlr=CV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CAFC433E2
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Sep 2020 06:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92E4420796
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Sep 2020 06:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbgILGeg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Sep 2020 02:34:36 -0400
Received: from mga17.intel.com ([192.55.52.151]:11516 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgILGe2 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Sep 2020 02:34:28 -0400
IronPort-SDR: Mwnvr9Km4OACPcjO5fASeQk5m6BqLF8KtoCJt6fpY7T4ZTaJOoJRdOdzdYSMzZRSWfe05p3cOj
 xG2FFlgV1daw==
X-IronPort-AV: E=McAfee;i="6000,8403,9741"; a="138912324"
X-IronPort-AV: E=Sophos;i="5.76,419,1592895600"; 
   d="scan'208";a="138912324"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 23:24:18 -0700
IronPort-SDR: 3NguPU7YZuKcLIUsoFCwcHXZRgRbz7L4/0r9S7tkuXxfoEU2gvC0uvg1uZ13DIlStJc4Poi614
 01E5vEm/9VQg==
X-IronPort-AV: E=Sophos;i="5.76,419,1592895600"; 
   d="scan'208";a="342519254"
Received: from han1-mobl3.jf.intel.com ([10.255.228.79])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 23:24:18 -0700
From:   tedd.an@linux.intel.com
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [BlueZ 05/17] emulator: Add SPDX License Identifier
Date:   Fri, 11 Sep 2020 23:23:45 -0700
Message-Id: <20200912062357.23926-6-tedd.an@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200912062357.23926-1-tedd.an@linux.intel.com>
References: <20200912062357.23926-1-tedd.an@linux.intel.com>
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
 LGPL-2.1-or-later    :     20
 GPL-2.0-or-later     :      2

License: LGPL-2.1-or-later
   emulator/server.c
   emulator/amp.c
   emulator/hciemu.c
   emulator/vhci.c
   emulator/btdev.c
   emulator/serial.h
   emulator/le.h
   emulator/le.c
   emulator/main.c
   emulator/amp.h
   emulator/hciemu.h
   emulator/bthost.h
   emulator/btdev.h
   emulator/vhci.h
   emulator/serial.c
   emulator/phy.c
   emulator/smp.c
   emulator/phy.h
   emulator/bthost.c
   emulator/server.h

License: GPL-2.0-or-later
   emulator/b1ee.c
   emulator/hfp.c
---
 emulator/amp.c    | 1 +
 emulator/amp.h    | 1 +
 emulator/b1ee.c   | 1 +
 emulator/btdev.c  | 1 +
 emulator/btdev.h  | 1 +
 emulator/bthost.c | 1 +
 emulator/bthost.h | 1 +
 emulator/hciemu.c | 1 +
 emulator/hciemu.h | 1 +
 emulator/hfp.c    | 1 +
 emulator/le.c     | 1 +
 emulator/le.h     | 1 +
 emulator/main.c   | 1 +
 emulator/phy.c    | 1 +
 emulator/phy.h    | 1 +
 emulator/serial.c | 1 +
 emulator/serial.h | 1 +
 emulator/server.c | 1 +
 emulator/server.h | 1 +
 emulator/smp.c    | 1 +
 emulator/vhci.c   | 1 +
 emulator/vhci.h   | 1 +
 22 files changed, 22 insertions(+)

diff --git a/emulator/amp.c b/emulator/amp.c
index 605c6c825..33e6ff476 100644
--- a/emulator/amp.c
+++ b/emulator/amp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/emulator/amp.h b/emulator/amp.h
index 189dfb7d4..0c948a38c 100644
--- a/emulator/amp.h
+++ b/emulator/amp.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/emulator/b1ee.c b/emulator/b1ee.c
index 377181b01..d84b4587f 100644
--- a/emulator/b1ee.c
+++ b/emulator/b1ee.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/emulator/btdev.c b/emulator/btdev.c
index e9c3811f8..05bf76cb2 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/emulator/btdev.h b/emulator/btdev.h
index a9f71b281..7a6ca9571 100644
--- a/emulator/btdev.h
+++ b/emulator/btdev.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/emulator/bthost.c b/emulator/bthost.c
index 71d5f97bb..40a40ea3c 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/emulator/bthost.h b/emulator/bthost.h
index 2b347136f..d190d38bc 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index ac861cce2..ef5dc35d5 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/emulator/hciemu.h b/emulator/hciemu.h
index 4c8858bb6..5c70aa2fd 100644
--- a/emulator/hciemu.h
+++ b/emulator/hciemu.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/emulator/hfp.c b/emulator/hfp.c
index 29ec63e7d..533f6dbb4 100644
--- a/emulator/hfp.c
+++ b/emulator/hfp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/emulator/le.c b/emulator/le.c
index 1c8ba280b..9980475b3 100644
--- a/emulator/le.c
+++ b/emulator/le.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/emulator/le.h b/emulator/le.h
index 5e832e8e5..7d977292c 100644
--- a/emulator/le.h
+++ b/emulator/le.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/emulator/main.c b/emulator/main.c
index 75cb79c7b..9d613f75b 100644
--- a/emulator/main.c
+++ b/emulator/main.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/emulator/phy.c b/emulator/phy.c
index beb8bbbe4..0711495fa 100644
--- a/emulator/phy.c
+++ b/emulator/phy.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/emulator/phy.h b/emulator/phy.h
index d5efa5180..192bb567b 100644
--- a/emulator/phy.h
+++ b/emulator/phy.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/emulator/serial.c b/emulator/serial.c
index 1c324d531..9ae73f102 100644
--- a/emulator/serial.c
+++ b/emulator/serial.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/emulator/serial.h b/emulator/serial.h
index 4e5a56f88..75aff38cb 100644
--- a/emulator/serial.h
+++ b/emulator/serial.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/emulator/server.c b/emulator/server.c
index c28b15ebf..3fb348ac3 100644
--- a/emulator/server.c
+++ b/emulator/server.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/emulator/server.h b/emulator/server.h
index bf725e788..a169c4c09 100644
--- a/emulator/server.h
+++ b/emulator/server.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/emulator/smp.c b/emulator/smp.c
index c30de3666..ae06ae9aa 100644
--- a/emulator/smp.c
+++ b/emulator/smp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/emulator/vhci.c b/emulator/vhci.c
index f79b34f46..58ae0a5f8 100644
--- a/emulator/vhci.c
+++ b/emulator/vhci.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/emulator/vhci.h b/emulator/vhci.h
index 1ec7191f8..dcb8860e2 100644
--- a/emulator/vhci.h
+++ b/emulator/vhci.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
-- 
2.25.4

